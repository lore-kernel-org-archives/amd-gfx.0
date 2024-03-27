Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723E4C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 01:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D895810F635;
	Wed, 27 Mar 2024 01:37:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NnXt7Qa3";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2128.outbound.protection.outlook.com [40.107.237.128])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1709E10F635
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 01:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWYpgnzKYKO+QdgmwEci05nyAyYJFRLzmBn+2TUq2A2MiGvm/c6fdCQWcd2+v5n7r9iHPMUMBC6ggitwynXFoB6Ah92+uoXnJ2II/4ipTWYQzyHy6U+v6BJlgNhgd5wdgMqbqH7iVzqUjfoPHAFtN93A3dpdGXFS4yxlG/7zBfBq/5UmTq8LK2Qb7/4mDFajB/ZRt/sAMFY2bfat8H3bY5w4PTwwaDWDiIw017qvS0WL/HDbIPDWFDrYfXoo71BafzlfBT37PEp+UUdLrNNbxZDmcZHVdxix66UyZl2cN1yCDqNZ93gF5KCRuR4VAuaE4Ndw2r4uunk6FYOfuunD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t5TMcHoQg8UANW1auG2SOz095kIo0VUZKT0ZyD/jEM=;
 b=Pec+C0rsVVcYmDytCb8oDlsC+hPzyiYoes0GA/oLKOKJbUJmVozjJZNYWLEvLJqGIsWvjqo+tM7dcHGQJ38kzQArdb5TvNEAZ/DBEpCvEFVFU6ecpL/TqBc6XucjODB0dsobfZnHm07/Lg1u6kIO0tC6gJaKg6moy4pW6yEZ/nrZPiBqUvPUfi/AsNqWVSZCR8hEgjA+jwbLdLrN09oLc7OCdeR4p17SdOo6Jb/SQAnOC73DrJCn+aTfe3fchvvhl/EU0S/Kwoaqie5Sk7WWsZsFjMDhFGRps1L9n6VA5jQhQzxWjtlfxV6uNexO/+5VC3hi98x9YC9EYGIFKwK3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t5TMcHoQg8UANW1auG2SOz095kIo0VUZKT0ZyD/jEM=;
 b=NnXt7Qa3E69JYwIFF8naoe8/vrPjY9X6zJGYjgHrPb4cLDzJl6d942z1JsT6799Hf9ExPfzWwwGBeE/K0szUAE/HMLZR8s7UG2VNanIWYi4PfkJrwWFPBanswISkybJRQpt9cMc1PCkRvhv+tUtJ34YldvZJXp9OSrWZGKpum2c=
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 01:37:32 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::3c13:5719:7068:2510%3]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 01:37:32 +0000
Message-ID: <9a7e36b1-5778-4874-ad67-26f8c79eca61@amd.com>
Date: Wed, 27 Mar 2024 09:37:25 +0800
User-Agent: Mozilla Thunderbird
Cc: majun@amd.com, Kenneth.Feng@amd.com, Alexander.Deucher@amd.com,
 kevinyang.wang@amd.com
Subject: Re: [PATCH 4/5] drm/amdgpu: Add support for BAMACO mode checking
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240325101559.2807629-1-Jun.Ma2@amd.com>
 <20240325101559.2807629-4-Jun.Ma2@amd.com>
 <2456ff9c-8e83-4b16-98bb-fb2f366dbd73@amd.com>
Content-Language: en-US
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <2456ff9c-8e83-4b16-98bb-fb2f366dbd73@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0008.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::20) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA0PR12MB7601:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +HCDZZgdY6NZhFkk5HR02MC+vEviKiBJ4SLf6yLB5UkrMaecTXzTy/sWdp2bsxvTLfKVhbW5sgbjQMYBlKMJWedXMidjweV57+61obyTbh20o/4KxVa+H4mJVS/HBNQZkYSoU8DUfZrE/3yxVd4uoh42Q224/nHO0xOIFiKQUYE/sD5QEgiUMMAKwAdo0O92mPkbfs1zZQUyyG1S5xbziseA4eGx9w46bX6YfHVe36SUnKFWBbjq4TmJj4TLI48lIvKK7g8hxGAxJtV1jzntcJo2ET/X17mmytpTd59XvUI46pbG6zKViTewrqoyambKD2rpebXFFMey2t67aijOxVuqRn6Byir+FW6FU0VwRQak2x9t4ez+4FVGM5FtFSlD0EB7xYJByuMePnCMnBXYd+uYt2oBjhMQUBsjh6vz+cA/UndmB6GYPBSmehyYSZNvLJ4mrLxp+PnOxVOIDK1SZcJQMyWxzil2HUnj2i7zWF51TRcG6ZUYa26snxWGk0MxkGVhVS7iAIIkJPKvbI8hQNw2IfbX0rb9WEZb53xPYtdfh8QSyeFgIDnrGePA/5eNeBdrk6axOD1IWiXGkNMDyn+R04NAa2AF+R4Tmq4U+Q2WJxkLrawAlnXXHStbAjv0ud4mPo5KtQb4HEIqyDh7Da9THdEOoIaMH2K0yZDFcMA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFFENG5ITm5MRkZ2Si83VG42cUlHcFI5a1VndjI1N3FNT3ZDUW9WOC96eHBu?=
 =?utf-8?B?MzdENVZYcmpuTG1Dbmk4MnRnd1M5b3hRT1Z4MDZHeVZacDl1T3Mybk9VTU1a?=
 =?utf-8?B?UXN2SGl3UXAxSzJoYnRsYnRjei9ibUdDWXJaalc0WUVhRVl4dEZCT2FYYy9V?=
 =?utf-8?B?Rld3RG1URDM3N3JDV1l4aE5WeG9WTzhlcjZWSUhTU0x4ZTFudExOM2tKTUl4?=
 =?utf-8?B?ZGVPQ3lheEI2S1grNnp2M1NZNmQweGR6OUFpRGpTaFFMRE4xb014ZlRvdTI4?=
 =?utf-8?B?WWxBVUpQbFN0dTU0TEhSbFR0ZllHa3VjRDk5YkxlNUd6U1NxZFhFck9sU1RS?=
 =?utf-8?B?TzN2MndsUHdCZm1obTB0S0pYNkxEeDFkNkZ6R3ZHN0loNEFySU5Bc2hXQWFF?=
 =?utf-8?B?d3Z6U0ZaaEVkRkxjVEEyT3l0LzZDc1A3cW5JSm45a2Y2aUg4dW02TnlhWXVp?=
 =?utf-8?B?ZTl6NC8zRzhmL1NxcEcxYlplL1NMVjU1K1VNZ2lBRGFTTTJqRGNOSDhMc0Ez?=
 =?utf-8?B?cGtHNk1FSndXdzFwT3FMa2ViVThUSVl0NjViRXNzWUt1SWM4THM3cS9DZ29D?=
 =?utf-8?B?eElPRDNienltLzVaY1VZU2h1d3hzNnJnY2VZN09mb2ZLN0c4V1hVd0gxRmwr?=
 =?utf-8?B?c2J6SC9XVC9xTUE4TkdzRmhPRTNKYURFMmdwcEhIVDdXODdEdENYUFFuNXFE?=
 =?utf-8?B?a05IaGZnbEpsSU9wMnpWRHl5SmcybVd2YUNYakp6dWNIaTkrSnlDK0FHY1lq?=
 =?utf-8?B?aE1aNkhMTTlaR2drdmdHeUdBeUIwN3JNMFdMTW1Oc3hjbmdtSVRWSEZwaExy?=
 =?utf-8?B?TUJZVHFydDFTSkx5WU13QnFiQmxhRXFvdG5Qb0c1cFBQd2E1Rk5kRlVreFRa?=
 =?utf-8?B?ZnBVa2U0eDRKU3VBbUZ2V2FiT0VVbDc0L1FtUVJlVlFGYllHWm9YWmE0RTAx?=
 =?utf-8?B?aENldWlrRGovUVRoenlqejJ3amJRQ1pjVWE5TTNoc2ZSalZCNEJkK2lTYU85?=
 =?utf-8?B?emQwZ2lCRWtBN0ZlMnI0V0RWMTR1MUdCeW9POVk4UEhGZmowcnBUaUNQM0Rz?=
 =?utf-8?B?WnFiblgzdlVSSmlqaTVQZjEvMHJEVzVQbVVhN1FHUmFoazZTd0FPeFFvNHZ4?=
 =?utf-8?B?a1ZXaFZ1WVZxaFNWVFFtUHpjeFFvWXBHUnlER1FCaVhYTEkyMzQ1cnlaK3Rk?=
 =?utf-8?B?aXNrelU3ZFpDck91dmkwclh3WXYwVldaemNqMHBPQVhwbjcyM2dCWjRXU2Vi?=
 =?utf-8?B?ZGIwSk50NWpWZmlqcXplV2J2U3VwRTduL2RrU0orNDBhR1JQYytPT3Z5UmZU?=
 =?utf-8?B?ZmZQU2RpaDlJb2NKekZSVEROYXkyRzFrZzVoSnhmWXMxZWpxTmJmV3U2VFBi?=
 =?utf-8?B?ZHJsWUo1dERuelVBZWVXOSt2VXdNMjI4RzB2QTd4Y0pOWkJtREVsV2w4d0hD?=
 =?utf-8?B?cVhDVjBlN2JyejRpSUxoSkRNWlZTbENadzNFL1BYaUhQUk11KzBab3BVWGZj?=
 =?utf-8?B?Rm9haDJkRHVDQmptN3k3cXpHYlBrN0JsK2RYR3lYY3YrclpwaHd6RjQyeU5R?=
 =?utf-8?B?YW1EaTMrMC8yMmUwcG9wVk5iWDZSTHNyNHl0cTlqemYrek9yVGViUHcrZkpH?=
 =?utf-8?B?eVBBQnJwZmg2Q1lQVWNmQVpmaUc5WTArSHJvaWM0aHZCWTltbG9hRGJOaEJZ?=
 =?utf-8?B?c21SNTRueFNwUVVpQWsyRTRHTTh0SnhlbkhMTFFURER4NlBObkVGL0RPSTFO?=
 =?utf-8?B?NUxoT3d3cStMejNReVFDR2h3SVVpWUJ3Uk13SmkxeEs3aU9zTnBwRWpiTG9u?=
 =?utf-8?B?d0w0U0hIbmxNa1cwOFlhVEFFcFJGM0FXTXNZSTBiejR1WGw2Zmp6NGVPV2RI?=
 =?utf-8?B?TUw0N09WZFhrOENMUjRYNFNhb3FOMExocWZIQWRzaE5xdzh6blpDR0VqNmI0?=
 =?utf-8?B?OGVEOEdpQ2d3SXlHcXErQnFaN0pqZ2tlUytMK203blM0WnBEVzYrNE9XT3BI?=
 =?utf-8?B?VTRjTXAyRFUxTTZOZk9vQm4veHZBcnBiOHVJSXNUcGhONTd5QWxCRWpHdzNK?=
 =?utf-8?B?aXdVUVJKMzByT05uckVQTWdLQUs5YjExLzM2eU1zQUQwQVBqVGdsY0VSaW12?=
 =?utf-8?Q?pqobPPwBBYr3fiD+/ECAkbt3r?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed4b619-3889-4239-4c04-08dc4dfe7877
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 01:37:32.0025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWjULbZ7oa7O1P3cHeAxa+2e7fY7xk7qq71Z9TbVYnbMNdWW7IyGfBPXwVhqWq1M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
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



On 3/26/2024 5:29 PM, Lazar, Lijo wrote:
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

Thanks, will fix in v2.

Regards,
Ma Jun
> 
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
>> +	} else if (amdgpu_runtime_pm != 0) {
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
