% Read the temperature CSV
data = readtable('temperature.csv');

% Display the data to check
disp(data);

% Convert string date to datetime
data.Date = datetime(data.Date, 'InputFormat', 'yyyy-MM-dd');

% Plot the temperature over time
figure;
plot(data.Date, data.Temperature, '-o', 'LineWidth', 2);
xlabel('Date');
ylabel('Temperature (°C)');
title('30-Day Daily Temperature Trend');
grid on;
hold on;

% Calculate statistics
meanTemp = mean(data.Temperature);
maxTemp = max(data.Temperature);
minTemp = min(data.Temperature);

fprintf('Average Temp: %.2f°C\n', meanTemp);
fprintf('Max Temp: %.2f°C\n', maxTemp);
fprintf('Min Temp: %.2f°C\n', minTemp);

% Prepare data for linear model
X = (1:height(data))';  % [1; 2; 3; ... 30]
Y = data.Temperature;

% Fit linear model
model = fitlm(X, Y);

% Predict next 7 days
futureX = (length(X)+1):(length(X)+7);  % Days 31–37
predictedTemp = predict(model, futureX');

% Generate future dates
futureDates = data.Date(end) + days(1:7);

% Plot predictions
plot(futureDates, predictedTemp, 'r--o', 'LineWidth', 2);
legend('Actual Data', 'Predicted');

% Format x-axis labels
xtickformat('yyyy-MM-dd');
xtickangle(45);

% Show predictions in console
disp('Predicted temperatures for next 7 days:');
for i = 1:7
    fprintf('Day %d (%s): %.2f°C\n', 30 + i, datestr(futureDates(i)), predictedTemp(i));
end
