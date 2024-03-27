Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C4C7C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 05:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE34310ED61;
	Wed, 27 Mar 2024 05:28:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3j2ge3Yh";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2119.outbound.protection.outlook.com [40.107.92.119])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0283910ED61
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 05:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNkDKb4B6ZyVCYruDxgbfCTxBxTyQzHUEKchzw1Vks1IyDGOWg1ZK+gU0ftWNAWWW4pV7hnRUoauRwLTIdKNAqbCl6CWDw6I+wYPUIl2eP6kmCLbnfL4RMn94HUiPuiFtbDinKO5vZBsrwfpXg/WNzms/DPHOe8DRo4Uw2Fqd0miv1rJ9YVcK+WlkkUXuoC2/VrQFjw2TX1rqWmJjYNhYjkDrky8zlMURwrHH/MLsi2cCXnqnWPgdA7VdokDXKvUf9Ly4U4SF7rCXOrwXEKopcBdwmz2ysaU8f9njU+tCQfnDQhIxPwvU8uAglr9rLPl/8hYxXsiWXmT0ZaPuTSqGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPUXzueMSgg066CepXBE4qzzGRg7XjNFhbd5Vx78jG4=;
 b=PIX0IBLiY9ep+1ztip7N2sCllKJjbKRgs4Yq3yNLZG0G6nnacwNoDNiqdNpdzxFllVwXcSP3ppDMigd8m+i3Eydbch3bJ8s6vaKMrnKb+HByb1zGad7rgozXYM09oHUHwQcX316CTuJo7mY+F5fWDbdmYZL5Tq7i7mPQPIRGYg5MrEYlc5qDgAWn50KBtZPtftOjsl5BI4eIJiZqJcxVUWdyR5Xcwnei1M1TG3v4f3DVkNy5acscoedNX5g/m3ochviL6TLeZMdFzoJLmdI/0wZkvTCO38i9K80gu/8YFJGZFNOQM+E9nMIReFsXtrf8WiNyTSQvLzeVeBcKXzMh7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPUXzueMSgg066CepXBE4qzzGRg7XjNFhbd5Vx78jG4=;
 b=3j2ge3YhfKrX6ywCjpcK2XXIi7BgOv8GX2Oa0ToWJBTuuIoTZbBCUHS2j3nMyRvM/rMYq1XASsBzMzUobHp3y+DmpVCKvwY10td9Kj3P5pUxhqjiR9CNqoGwDMFROD8y1ynq3L99WQHq5iJhBhu0QkJAO57VnSd2ROpyypgNJDI=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Wed, 27 Mar
 2024 05:28:06 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 05:28:05 +0000
Message-ID: <48f0cd16-5a6c-4d88-9309-b61d088cf084@amd.com>
Date: Wed, 27 Mar 2024 13:27:56 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com
Subject: Re: [PATCH 4/5] drm/amdgpu: Add support for BAMACO mode checking
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
 <20240325101559.2807629-4-Jun.Ma2@amd.com>
 <2456ff9c-8e83-4b16-98bb-fb2f366dbd73@amd.com>
 <a0aa97c7-9cda-4521-a6cc-18afcb6af7f4@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <a0aa97c7-9cda-4521-a6cc-18afcb6af7f4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0111.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::27) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|PH7PR12MB5855:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7hpzrQKKErNxHuH5qlWapwId77ZUJLc/mCADjzjej2drI4Ou1nKayrmH4bzH4iZF7QLoS+hyyrECIptetxQmAU3Ad8qnOKjLpNGfv6v/qETUkhPYOwTYtRUDkoEzGGMH7n04k61YIkOpIuwarRItcr61sxnUQYDX8b5EjM7D1XCDOUPArw85+aWPI6W8oOZmgCcOS6WmomKDl9XZ2v1NyhtzJgneUkEMwzVL7wBrEJ0Z/PUrn2cLl2Mb6Qn3ThoIPEH1R4Eq9jvsWMOROoWvbG8S7+85TiS3p+R/S3D1pw/aq/ruhyeQtwjxSzwSFhxwb6LhotSJOejScm8fgrcbxhv2FKUsmIvD4QHM+KBT0NIBZWfJ6UH3R8CSM5MascA+wIINIyo6gWKAvBhaSQtfpr0S2P3PihVArFkWUYF7sgj2yACR4C7Q+prTUCNSWB/Tv6jEqV0qhjp7s1TUYHGnR+BdCfjKDemwz9rSRff2XUvIuX+1chOK8ilk9IbcPArfDgfmz54bqiotfLWCvVdz5qHQqpAgttiVArjcoRQmiLd+HAoDlT4+yvua136sLUuepbKrrnveLPUwC34m4cWI2IKovAYPiI8FVKm7kAqWCaUdVOdmDCRjRel3uUpiALYbk47tm54goicTx/UxmdNQK5fKjOk/LV8NZ3eHcLhYJ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3hOV1dkaHJ5Y0FJMUlybDVPc1lIeFk5ZFByYU9ZbjhvMTlKaWVuWEl4c01p?=
 =?utf-8?B?MnIrWEhwOEl4NFhlU1d1ajNqZUFCazdPWHAzVStMMG1RenI3OS91VU92QkhI?=
 =?utf-8?B?L2xlTXpqdkI3a1dwQXRmT2tjalV5U1lmR3MySGcrVGMwUkZMOVd2dmJlYmFy?=
 =?utf-8?B?eDJvRHhzOFFZTFhQcWQ2ZnpBUTE4R0FaOGRYZ1RtSGg3WWNVSWVWVnNTcUlu?=
 =?utf-8?B?V2pxanYvc2VzUEFSWTVEQ0Zza00zTWVXMzQ2WWZkK0ViN3R1ZXBtemliTU82?=
 =?utf-8?B?NDUreC8xTTV4UElXbWlWMGlOYStkVlFlamhaVisvRmFTOVl2c0cyR1Jzd3Y2?=
 =?utf-8?B?UnRHSXM2cTdMNlBzVHRJL1FMaC9GVXBIaU9pUExpVzBxbG9qRVlNMGJPcjZw?=
 =?utf-8?B?V0ZWYjI0NjlCem93L2ppd1daalg1Wjhid0c1UkdlT2VyenB0a3ozM3Y5dTl2?=
 =?utf-8?B?dlJTNnIxWTlham5YU0x2Ty9GcS9SYks1b0N3dkRqVWVDNXpnMG1LYk5qaHVV?=
 =?utf-8?B?WGhuNk1uQmdqTkk5d3dweHZ2bkJBU0FQdEp0WHlvcUlyWjZEWTgxUFZzQm5T?=
 =?utf-8?B?RTFzVUM2bE5pK284T0MwTk5qaFBPMi8rYm1NdHFVMFRXbnI4ZjlObWxnbFdR?=
 =?utf-8?B?SnpjMjk2ejNOTXMzNEdiTVpTWHdEb01xWVprczFnRjcyS2E5MkxtVUxZbUQv?=
 =?utf-8?B?aC9ubU9GQ2JGNUxPNk4wdTZpODEyNzd6M3pTSjlVRy9uSlR6VmF0YkM5bFNQ?=
 =?utf-8?B?ZEd2WGNSUHRSRFBoK255c1lhYktFRnlIR0Zaekd4ZG9pdm5OaFc3cHFOcllp?=
 =?utf-8?B?TGJZLzFHSzZUTmNZTnkxbWk1UWhZTVgxZGJsN1I4Zld6WGJESDRMc3owUDVy?=
 =?utf-8?B?azlmcytEak84WEZHY1hMMU1YMXArelVWbFFwS0xzZGNqWk1RMnJZTjJ3allF?=
 =?utf-8?B?Y3NneTZTNEpYeWRzSTFsdUZ5MzQwWnNtRFFjOS9xWWN6bkswUUpWcG5nRnpX?=
 =?utf-8?B?eGFaNUFRNE5FcDRBU09KQnpQMTNmOFlGWGwvaUZKbkhkWFdUZ0hxSFYvd3ZO?=
 =?utf-8?B?Z016QVp5SFBkWHdBVVlJR1lIdFN5ZXI3eTYrdDQrU3c0bm9lYnkrVXNaaStw?=
 =?utf-8?B?SDc2cVIxZUNteGMyWmsvS0JTOC9uMGpFNmlBUnJXQTRYTXJIVzJ1SzdYT1ZK?=
 =?utf-8?B?NWRpQWlya3M3Zk5EVlFUK1hxWWprN2NubnZzUTREUGo2dzRlT21GM01oeFhU?=
 =?utf-8?B?d2ljNEQ4aHNZSkZXbkdldWhwSmRHQlM4QXRsRkE4cGhSdUpYdXkvaGhENzRy?=
 =?utf-8?B?aWlDRnFPcFZrRENhNE9kSUJoaVZIT0dMQllXbW5RanVPc3g3MTU0M2FtUlRJ?=
 =?utf-8?B?K0ZQTG1VMjBmK25mbVI4L3FLL1RkRXhWT1dtM04xbThlMEVsVHorM1ViTnZY?=
 =?utf-8?B?YzBwVWRFYjZmaGJrZVd0azBRaHhvMmk0MVM0dC9nb2xCYXJpYjI1YVU0SU1N?=
 =?utf-8?B?U3Yza09oUmpMUnJYZHFFRkEzU05vY0JId0R6QnhMdUUvc3hzL1NIS1liQW9F?=
 =?utf-8?B?RHlTNzlXWEh6WUMvV2VvdEQvbDNpN2ZpR3VuQUNoOUZhMnB4T0JITUwrN2s1?=
 =?utf-8?B?MGVyZVBsbVkyODNscG9SVk9ZWWh2VjRTckhpcURONHYzcjNNRmJzT3M1VjRU?=
 =?utf-8?B?aVJ3a1ZGY1laMGlmZUMxSW1YamFNeTFWekRaOEQrem5Ic3NyQjhYc21IM1dI?=
 =?utf-8?B?d0FMNHFOZzBSTHZGbVNCN0lFc0FWQ0d0aGJqZnVBREI2ZHFxc2lleUcrNXln?=
 =?utf-8?B?MlpJL2lXUE5pd2NhT05vUzdDYWhHb2FTR0JRcTg1ajVnNU9QV2V1YjNXbXAr?=
 =?utf-8?B?NlJucFMxZHUyeDJoQjh1WUs1czRoc21YRWUxcVpxYjZmYlcwaElQVU0vTGVH?=
 =?utf-8?B?eWhxbG9rcW5RcDRVUnRoNG8xWUNKY09JRDlqM1dHV05jK3ZyTUJFUmVtYUJ4?=
 =?utf-8?B?UDhSUUhpL1pQYXBNNlp3YVRsaGhpdFVXS3NnbS8rc0h5clZ0M1JLNVAvYkdm?=
 =?utf-8?B?WXVaK0NQZlNHM2dJUm1EZmpaMkF6MDRjdkFVM3Vvb1ByWm9DeVlnVHpjaFJM?=
 =?utf-8?Q?V6WqnwOHdmEZ++HnwvWgZCPrQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b9988e-a127-44d9-e628-08dc4e1eadad
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 05:28:05.2715 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyATKCEGajkbYRxHCmJrzWAPJVgqQa+IV+Ami8hHg4ziR07uvF5ThqWOHW8kS/hX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/26/2024 5:34 PM, Lazar, Lijo wrote:
> 
> 
> On 3/26/2024 2:59 PM, Lazar, Lijo wrote:
>>
>>
>> On 3/25/2024 3:45 PM, Ma Jun wrote:
>>> Optimize the code to add support for BAMACO mode checking
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +-
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 74 +++++++++++++++----------
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 +-
>>>  3 files changed, 50 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> index 80b9642f2bc4..e267ac032a1c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>>> @@ -2734,7 +2734,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>>  		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
>>>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>>>  		/* nothing to do */
>>> -	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>>> +	} else if (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO) {
>>
>> This kind of checking doesn't work well if we have to add new RPM modes.
>> Instead use || or a wrapper.
>>
> 
> A few more comments below.
> 
>> Thanks,
>> Lijo
>>
>>>  		amdgpu_device_baco_enter(drm_dev);
>>>  	}
>>>  
>>> @@ -2774,7 +2774,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>>>  		 * PCI core handles it for _PR3.
>>>  		 */
>>>  		pci_set_master(pdev);
>>> -	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>>> +	} else if (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO) {
>>>  		amdgpu_device_baco_exit(drm_dev);
>>>  	}
>>>  	ret = amdgpu_device_resume(drm_dev, false);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index a66d47865e3b..81bb0a2c8227 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -133,6 +133,7 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
>>>  int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>>  {
>>>  	struct drm_device *dev;
>>> +	int bamaco_support = 0;
>>>  	int r, acpi_status;
>>>  
>>>  	dev = adev_to_drm(adev);
>>> @@ -150,38 +151,55 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>>  	}
>>>  
>>>  	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
>>> -	if (amdgpu_device_supports_px(dev) &&
>>> -	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
>>> -		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>>> -		dev_info(adev->dev, "Using ATPX for runtime pm\n");
>>> -	} else if (amdgpu_device_supports_boco(dev) &&
>>> -		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
>>> -		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>>> -		dev_info(adev->dev, "Using BOCO for runtime pm\n");
>>> -	} else if (amdgpu_device_supports_baco(dev) &&
>>> -		   (amdgpu_runtime_pm != 0)) {
>>> -		switch (adev->asic_type) {
>>> -		case CHIP_VEGA20:
>>> -		case CHIP_ARCTURUS:
>>> -			/* enable BACO as runpm mode if runpm=1 */
>>> -			if (amdgpu_runtime_pm > 0)
>>> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> -			break;
>>> -		case CHIP_VEGA10:
>>> -			/* enable BACO as runpm mode if noretry=0 */
>>> -			if (!adev->gmc.noretry)
>>> +	if (amdgpu_runtime_pm == 2) {
>>> +		adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
>>> +		dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
>>> +	} else if (amdgpu_runtime_pm == 1) {
>>> +		adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> +		dev_info(adev->dev, "Forcing BACO for runtime pm\n");
> 
> The above two don't work if SOC itself doesn't have the support. The
> option should be considered as what to choose for runtime pm when both
> BACO/BAMACO are supported rather than forcing irrespective of SOC
> feature support.
> 
> If the forced mode is not supported, driver may decide to fallback to
> auto mode or drop runpm altogether.
> 
>>> +	} else if (amdgpu_runtime_pm != 0) {
> 
> Since it's refactored, explicitly do a check here for AUTO MODE instead
> of any non-zero value.
> 
Thanks. I will fix it. 
Maybe I should have split this patch into two patches.
One is for BAMACO mode check, the other one is for this function refactor.

Regards,
Ma Jun

> Thanks,
> Lijo
> 
>>> +		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
>>> +			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>>> +			dev_info(adev->dev, "Using ATPX for runtime pm\n");
>>> +		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
>>> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>>> +			dev_info(adev->dev, "Using BOCO for runtime pm\n");
>>> +		} else {
>>> +			bamaco_support = amdgpu_device_supports_baco(dev);
>>> +
>>> +			if (!bamaco_support)
>>> +				goto no_runtime_pm;
>>> +
>>> +			switch (adev->asic_type) {
>>> +			case CHIP_VEGA20:
>>> +			case CHIP_ARCTURUS:
>>> +				/* vega20 and arcturus don't support runtime pm */
>>> +				break;
>>> +			case CHIP_VEGA10:
>>> +				/* enable BACO as runpm mode if noretry=0 */
>>> +				if (!adev->gmc.noretry)
>>> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> +				break;
>>> +			default:
>>> +				/* enable BACO as runpm mode on CI+ */
>>>  				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> -			break;
>>> -		default:
>>> -			/* enable BACO as runpm mode on CI+ */
>>> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>>> -			break;
>>> +				break;
>>> +			}
>>> +			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>>> +				if (bamaco_support & MACO_SUPPORT) {
>>> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
>>> +					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
>>> +				} else {
>>> +					dev_info(adev->dev, "Using BACO for runtime pm\n");
>>> +				}
>>> +			}
>>>  		}
>>> -
>>> -		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>>> -			dev_info(adev->dev, "Using BACO for runtime pm\n");
>>>  	}
>>>  
>>> +no_runtime_pm:
>>> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
>>> +		dev_info(adev->dev, "NO pm mode for runtime pm\n");
>>> +
>>>  	/* Call ACPI methods: require modeset init
>>>  	 * but failure is not fatal
>>>  	 */
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> index 94b310fdb719..b4702a7961ec 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>>> @@ -2617,7 +2617,7 @@ static int psp_load_p2s_table(struct psp_context *psp)
>>>  	struct amdgpu_firmware_info *ucode =
>>>  		&adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
>>>  
>>> -	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
>>> +	if (adev->in_runpm && (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO))
>>>  		return 0;
>>>  
>>>  	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
>>> @@ -2647,7 +2647,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
>>>  	 * Skip SMU FW reloading in case of using BACO for runpm only,
>>>  	 * as SMU is always alive.
>>>  	 */
>>> -	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
>>> +	if (adev->in_runpm && (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO))
>>>  		return 0;
>>>  
>>>  	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
