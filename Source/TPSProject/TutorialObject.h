#pragma once

#include "CoreMinimal.h"

struct FTutorialObject
{
protected:
	FString Name;
	int Age;

public:
	FTutorialObject();

	explicit FTutorialObject(const FString& Name, const int& Age)
		:Name(Name),Age(Age)
	{
	}

	FString GetTitle() const
	{
		return FString::Printf(TEXT("《%s》, Name is %d"), *Name, Age);
	}

	FString ToString() const
	{
		return GetTitle();
	}
};