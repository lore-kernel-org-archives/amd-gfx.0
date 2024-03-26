Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C4CC6FD1F
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 09:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7548010E3D9;
	Tue, 26 Mar 2024 09:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RO4i7qRS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2134.outbound.protection.outlook.com [40.107.220.134])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D949610E3D9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 09:34:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JiO4O9gx0qhfopMIn47RvOKBtfvhMjbzkC+ymgjZpuV8JHowCIPXFh/iroNMRnxy2LyKmKbpdbq6D6MAduPANw4sJdoPlpwNd0SAYAFHnpC6zK1hh7nRqebf5+BceHGTQ69f1AvzlW3+3xjsML9gY0Zyol6A6OUwfNm8Op0O1vmEFfY0r4dtsaILnlqpVcXpPleK5n8bsjFGNZJYmycQcxVz3cNX+DOHgRU+KWY6SyCoWFTLAMGpME+q8N0P3qnKw+36lAu58t7c+EdQAOppABd94mP34RNmoRKzI2lQ+DV3dfGPo6zeVbeO9jlPUQ1zVPwDNbvOldXD6DioF7m+1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO2QylHAzpPxHK68OTBhBGtXzWP1ZJtcIKbDiVeAfSM=;
 b=Wqw2kcCBLsU+2Vfos9GyXEtaFFM8IkmmHlb3J/XVlLE15mQp0S7OmbWolw/7pMSXWF//5GZNAzq88zwgfIXR9T+4AjxYw6VPegrY5ozgTm/qcCxixjOHKA1+TB8fKnUGMQA8Dk8/khwbbY4s2Jb8YYrLHbOpE2DWy83bbSqbC46dOS1Ejn99lohV34iw7eF3FsVqPj1qo/8BQv1EdFBorWK+xH5tb86Wi1voYQsvUbJkArP5yNIx4Kjv2NpE2kt7Wr2MWQoz8oEhU8+mdttCAkYcK04I3QZaFgq8FaFO7Jg5T1g4ocjfIL5+HGxCGwpnZHuXkf1g1l1ZulO2HXqD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO2QylHAzpPxHK68OTBhBGtXzWP1ZJtcIKbDiVeAfSM=;
 b=RO4i7qRSIA+4Z4r/vT6yNGgyD23/owNtX/8F2asDQdpW64hmd+CPoLjPo8PDd7odUqwwI5PaU5t3qhd5dHPjX/HFlikNUCW44ZsXS79SnnJdyhNe40AZmZTWOEEIYPVAtTrDP6XziRRHr92fbbvuQmNQmLxiFgY2HpMegaVS2wY=
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 BY5PR12MB4291.namprd12.prod.outlook.com (2603:10b6:a03:20c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 09:34:32 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 09:34:32 +0000
Message-ID: <a0aa97c7-9cda-4521-a6cc-18afcb6af7f4@amd.com>
Date: Tue, 26 Mar 2024 15:04:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] drm/amdgpu: Add support for BAMACO mode checking
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Kenneth.Feng@amd.com, Alexander.Deucher@amd.com, kevinyang.wang@amd.com
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
 <20240325101559.2807629-4-Jun.Ma2@amd.com>
 <2456ff9c-8e83-4b16-98bb-fb2f366dbd73@amd.com>
In-Reply-To: <2456ff9c-8e83-4b16-98bb-fb2f366dbd73@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::19) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|BY5PR12MB4291:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: edkjzgNgixKtQF1xQ3GU4CmisWzzhoXWjwDzWt8yq0YDOVInP1v55z8ZPXEU89HE3E/cXDR8j7kdvRnTFa+rywcbXufWwJLMRLmrFSxJ5dHgkwPFI9iA8f482kinMSvlCVkoBBsHIH5S5mzpAL50wq5BQOVirqYNKphtljN2/2mC4tsxlKTLnZdTYmtHqvGzdRdrs7c7N0gULnEZDM8xp6+5rcgkrpLDYeUtIhx1VRb1+geHy9IzZGKUETWInIMoOf42wDG4t9dIiHzQFJxS6xmBsRvEEenlTtmQ2w0V+R9qgh381Z8Zqs1WNDat0Sb0iVFGU2O2/V1/eGTnM2s05O/xEdR9o4G8EfVQtj9VKhYT0H4b8pSQej5W/x2KW3lF7FY6aek4G7jUFwgBdG8XAB/u/P3ft/GCjEDQfCyI7YL+TN/XtvbbMLuEl+0bQEDp3EDpsuLvMCDY/bVGN61pqDfloiQLDO4q8YlmV4jRb0MWKSNu9sjlDnrpPA3v5EzYGSn4/12rO+47NmGE3eVcXhesbWQu7nKnBcVKRLa15Tdbk/IXQkbf3U2hroFEsIemJQefoepmR7x9KfNyjfFQBNua9kNeMXhk3KigDjVuw+Sks/hgRblTRJAI7SCn6/mrF/GCeSwIPjY+XtmqQuuVx54vlrItixvcFAxp34iNZdg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3VaNDZGQkN3V3Zidkc2S1NINE1EcFIzcTM4RUlFRnY1TXZkdkNlaEN2MTh4?=
 =?utf-8?B?NkVHU1FJNC80M1FtOElUZ3RDWEJUemwxeEdjWW1NekF6WldVcVZCa2kvaHg0?=
 =?utf-8?B?UUNkbjlhOVFwbUY2ZU1jNlR6UXAwQzREbHNkWHEvOW05cmhUMlhHV09Lc25z?=
 =?utf-8?B?L0VPSEhONzRLS05XejdKTXkxdmdHZEI0YSttWkM1SVZYMzF6TzBuYTlFQnNI?=
 =?utf-8?B?VnAxWjZUdmc2RVpYUjh2Z2NmaWtXRDU5dUpHMHFrMDBPRGl2alpraHBRaDR3?=
 =?utf-8?B?MWdHUU1mUVFHY3BHRWZDc2VTTHF3V013Q2pieFlGUEVWZWphWU1BMDl1NFQz?=
 =?utf-8?B?Q2N3ejJNSE04UVFab3NJUVg5eCttY1BGQmFIcWlhZU43Q0ljY0dRaUpvK1dl?=
 =?utf-8?B?eFRHbEtVZ1VZaHhVN1ZJWEtGc0tIUkcvcU96ZVhCZHBYbUZVRnhrTXFBakJz?=
 =?utf-8?B?anJVaWJnbHROdEdNSXNQTWwwanJVU0FDMnhVZWhRUG9ueW1qSS9DVmkrNVBm?=
 =?utf-8?B?eFJuZ0RpelNYa2pRa0IwdldnKy90SFU1dlkxSjREZld4NkZhL2grblpvM0s2?=
 =?utf-8?B?VzVNdm1sQ2txSnNnNzg2SW56dTFHOXlJNnFUM1FyNEtYWUt1Y1oyZXdOemVQ?=
 =?utf-8?B?cyt3UVBFMkgvUzY1Qzh1R1FKSzdNeVhTOTdWU1ZwU1pDczUyeWlVWXNHbzRo?=
 =?utf-8?B?cUJub0ZySHFOa3VBNXBkNmQ1d2RBd2JnNnYwMGFHMWk1Rjk5L3FnS1M0Ykh5?=
 =?utf-8?B?ZzBvZ1VsNmlxaHkzaDdTVTM3clo5RWFKV1drY2ptdG41dEMxT2lzY1ZFR0lu?=
 =?utf-8?B?WHAybFlCTVdpcmFXVmpiSEpwVXA1YUMvc2t3VWdaMFdGL0hJaW16dEdKVmRm?=
 =?utf-8?B?dEJQQ0RZVld0OXgyaEo2WTBqSnJXV0xmWUNqS2hUc2d0cXdIZ1RweHJzb0pG?=
 =?utf-8?B?eStuclFpU0NFcktxT0JCT1NsTTRpNG5zaXZWVnkvRlFxTDlsYkJpWUIzS3pK?=
 =?utf-8?B?ZDV1UmpjWVZvVlBNeHlWSTFqV1ltUjNkbm5HUmpnVGM0dUZBcGxsUytSZy9F?=
 =?utf-8?B?a1NOVVF3T2gwNHdPNUg1SWVNYVRpa3U1ZFp1S1lZeVhzZnQ1dXZ0bXZ0MVN2?=
 =?utf-8?B?UWpWV1VieElVTkJyOVFSd1c1ZmZnZ0dTZUU1QUMwMjBXMVhySGl4cXQ1THpY?=
 =?utf-8?B?aGVlOGxaUXBmKy80VE5OMTZvc3hXakVaQTE0ajFJUkQweHBjL1lEcWhWNlIw?=
 =?utf-8?B?QkwzbjZhLzBXZjBKc2l1bmtvQ0ZCT3N2WkEwaGVmd083bEdOclFKak5yajhR?=
 =?utf-8?B?U0FhVXJSWmtKUkRXQ0s2VWpQRXd5WTZmSGtGM2lWb2Rsa1VCSCtzQk12Z01C?=
 =?utf-8?B?K1F6SVFtcGFxVU9wYTgzSmdwb015VEZaNXNBU3NNdXpSUnlYMC9DWjhlNTg4?=
 =?utf-8?B?V2RrTXBpbElURFFDelYwU1FDUXRadDZSalpCRDd0NkVjM0ZzNVRoRUtIOTdC?=
 =?utf-8?B?YVFpWTQralZXNS9SVGNBcmFDOUJvVG4yM3FTSW9ZNUw0YndDSWhCamhSN3pv?=
 =?utf-8?B?UlVNd3NFd1AzRGM0UytpeTArWWpWclgweE1JTkNFWWY1WGo1akZSRGt2RzdH?=
 =?utf-8?B?dFB6SXBkTDZOSGtEZnVaRVh1UDlWWC83MmsvbkdWU1JkNks2VWdXSUk4SDlI?=
 =?utf-8?B?S0xtU0p2Zk9GeEdrQ0VBYXdiYnljTjFtaThCQld3TVQvLzZMc3pHNzE5dHVl?=
 =?utf-8?B?M0VTVGtndTJJRGRYLzliRmppNnFOcHhsLytLRmVoZWk3NlgyM1JwR3RPazhE?=
 =?utf-8?B?U20rRCtYd1pvVHUwZ1YvSTkyN3puRjd4YW5zNndyNE5ocXQ3ZklGV0tNNUJY?=
 =?utf-8?B?bjZaSXphUkxkSlpvOG51SDhsTVc4NnVCb25xNHZtenVqZnFpVTUxMlYrZFo0?=
 =?utf-8?B?c1JRaXJweitUQ3VOMTE0clJiSjFNUjNqRjcrazF2cDNKSzF0bG5TRUFYTUtX?=
 =?utf-8?B?bDVjTmk1MlNjbnEzY3JWVDJhME5uY1NteWFXOFRJZmZGN2RlRGxXd0huYVM1?=
 =?utf-8?B?M2xMYkR1WVMxbFpSSTRPeFlRT2hVUXBQRFhzZS9aRGVGQjV0LzYxYUE2QXY0?=
 =?utf-8?Q?5gFBfQa9WgWeWEJn/9Ltc0i3R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006ebca5-f411-40d4-ff25-08dc4d77f101
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 09:34:32.3250 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh87TxaQ+SYwpPka5FyAOTap18IYodYEDZJxtCf6ibCrr/hf7q/7ydHbvwDBrnFH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4291
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



On 3/26/2024 2:59 PM, Lazar, Lijo wrote:
> 
> 
> On 3/25/2024 3:45 PM, Ma Jun wrote:
>> Optimize the code to add support for BAMACO mode checking
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 74 +++++++++++++++----------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 +-
>>  3 files changed, 50 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 80b9642f2bc4..e267ac032a1c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2734,7 +2734,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
>>  		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
>>  	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BOCO) {
>>  		/* nothing to do */
>> -	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>> +	} else if (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO) {
> 
> This kind of checking doesn't work well if we have to add new RPM modes.
> Instead use || or a wrapper.
> 

A few more comments below.

> Thanks,
> Lijo
> 
>>  		amdgpu_device_baco_enter(drm_dev);
>>  	}
>>  
>> @@ -2774,7 +2774,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
>>  		 * PCI core handles it for _PR3.
>>  		 */
>>  		pci_set_master(pdev);
>> -	} else if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>> +	} else if (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO) {
>>  		amdgpu_device_baco_exit(drm_dev);
>>  	}
>>  	ret = amdgpu_device_resume(drm_dev, false);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> index a66d47865e3b..81bb0a2c8227 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>> @@ -133,6 +133,7 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
>>  int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>  {
>>  	struct drm_device *dev;
>> +	int bamaco_support = 0;
>>  	int r, acpi_status;
>>  
>>  	dev = adev_to_drm(adev);
>> @@ -150,38 +151,55 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>>  	}
>>  
>>  	adev->pm.rpm_mode = AMDGPU_RUNPM_NONE;
>> -	if (amdgpu_device_supports_px(dev) &&
>> -	    (amdgpu_runtime_pm != 0)) { /* enable PX as runtime mode */
>> -		adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>> -		dev_info(adev->dev, "Using ATPX for runtime pm\n");
>> -	} else if (amdgpu_device_supports_boco(dev) &&
>> -		   (amdgpu_runtime_pm != 0)) { /* enable boco as runtime mode */
>> -		adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>> -		dev_info(adev->dev, "Using BOCO for runtime pm\n");
>> -	} else if (amdgpu_device_supports_baco(dev) &&
>> -		   (amdgpu_runtime_pm != 0)) {
>> -		switch (adev->asic_type) {
>> -		case CHIP_VEGA20:
>> -		case CHIP_ARCTURUS:
>> -			/* enable BACO as runpm mode if runpm=1 */
>> -			if (amdgpu_runtime_pm > 0)
>> -				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> -			break;
>> -		case CHIP_VEGA10:
>> -			/* enable BACO as runpm mode if noretry=0 */
>> -			if (!adev->gmc.noretry)
>> +	if (amdgpu_runtime_pm == 2) {
>> +		adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
>> +		dev_info(adev->dev, "Forcing BAMACO for runtime pm\n");
>> +	} else if (amdgpu_runtime_pm == 1) {
>> +		adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> +		dev_info(adev->dev, "Forcing BACO for runtime pm\n");

The above two don't work if SOC itself doesn't have the support. The
option should be considered as what to choose for runtime pm when both
BACO/BAMACO are supported rather than forcing irrespective of SOC
feature support.

If the forced mode is not supported, driver may decide to fallback to
auto mode or drop runpm altogether.

>> +	} else if (amdgpu_runtime_pm != 0) {

Since it's refactored, explicitly do a check here for AUTO MODE instead
of any non-zero value.

Thanks,
Lijo

>> +		if (amdgpu_device_supports_px(dev)) { /* enable PX as runtime mode */
>> +			adev->pm.rpm_mode = AMDGPU_RUNPM_PX;
>> +			dev_info(adev->dev, "Using ATPX for runtime pm\n");
>> +		} else if (amdgpu_device_supports_boco(dev)) { /* enable boco as runtime mode */
>> +			adev->pm.rpm_mode = AMDGPU_RUNPM_BOCO;
>> +			dev_info(adev->dev, "Using BOCO for runtime pm\n");
>> +		} else {
>> +			bamaco_support = amdgpu_device_supports_baco(dev);
>> +
>> +			if (!bamaco_support)
>> +				goto no_runtime_pm;
>> +
>> +			switch (adev->asic_type) {
>> +			case CHIP_VEGA20:
>> +			case CHIP_ARCTURUS:
>> +				/* vega20 and arcturus don't support runtime pm */
>> +				break;
>> +			case CHIP_VEGA10:
>> +				/* enable BACO as runpm mode if noretry=0 */
>> +				if (!adev->gmc.noretry)
>> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> +				break;
>> +			default:
>> +				/* enable BACO as runpm mode on CI+ */
>>  				adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> -			break;
>> -		default:
>> -			/* enable BACO as runpm mode on CI+ */
>> -			adev->pm.rpm_mode = AMDGPU_RUNPM_BACO;
>> -			break;
>> +				break;
>> +			}
>> +			if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO) {
>> +				if (bamaco_support & MACO_SUPPORT) {
>> +					adev->pm.rpm_mode = AMDGPU_RUNPM_BAMACO;
>> +					dev_info(adev->dev, "Using BAMACO for runtime pm\n");
>> +				} else {
>> +					dev_info(adev->dev, "Using BACO for runtime pm\n");
>> +				}
>> +			}
>>  		}
>> -
>> -		if (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO)
>> -			dev_info(adev->dev, "Using BACO for runtime pm\n");
>>  	}
>>  
>> +no_runtime_pm:
>> +	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE)
>> +		dev_info(adev->dev, "NO pm mode for runtime pm\n");
>> +
>>  	/* Call ACPI methods: require modeset init
>>  	 * but failure is not fatal
>>  	 */
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> index 94b310fdb719..b4702a7961ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
>> @@ -2617,7 +2617,7 @@ static int psp_load_p2s_table(struct psp_context *psp)
>>  	struct amdgpu_firmware_info *ucode =
>>  		&adev->firmware.ucode[AMDGPU_UCODE_ID_P2S_TABLE];
>>  
>> -	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
>> +	if (adev->in_runpm && (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO))
>>  		return 0;
>>  
>>  	if (amdgpu_ip_version(adev, MP0_HWIP, 0) == IP_VERSION(13, 0, 6)) {
>> @@ -2647,7 +2647,7 @@ static int psp_load_smu_fw(struct psp_context *psp)
>>  	 * Skip SMU FW reloading in case of using BACO for runpm only,
>>  	 * as SMU is always alive.
>>  	 */
>> -	if (adev->in_runpm && (adev->pm.rpm_mode == AMDGPU_RUNPM_BACO))
>> +	if (adev->in_runpm && (adev->pm.rpm_mode >= AMDGPU_RUNPM_BACO))
>>  		return 0;
>>  
>>  	if (!ucode->fw || amdgpu_sriov_vf(psp->adev))
