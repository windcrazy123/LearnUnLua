// Fill out your copyright notice in the Description page of Project Settings.


#include "TPSCharacter.h"

#include "Blueprint/UserWidget.h"
#include "Slate/WidgetTransform.h"

// Sets default values
ATPSCharacter::ATPSCharacter()
{
 	// Set this character to call Tick() every frame.  You can turn this off to improve performance if you don't need it.
	PrimaryActorTick.bCanEverTick = true;

}

// Called when the game starts or when spawned
void ATPSCharacter::BeginPlay()
{
	Super::BeginPlay();

	FWidgetTransform(FVector2d(1,1),FVector2d(2,2),FVector2d(3,3), 0);
	UUserWidget* UserWidget;
	NewObject<>(,)
}

// Called every frame
void ATPSCharacter::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);

}

// Called to bind functionality to input
void ATPSCharacter::SetupPlayerInputComponent(UInputComponent* PlayerInputComponent)
{
	Super::SetupPlayerInputComponent(PlayerInputComponent);

}

