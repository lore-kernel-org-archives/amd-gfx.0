Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0D9C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 05:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D99610E130;
	Thu, 18 Jan 2024 05:05:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B8AA10E140
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 05:05:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZHS19o2KhWHKh9OqVaLH2sglthKlFCAMpuRgVH+BnRt/yYyb9jOJPViRSy0LRlKO9PavoqbmVRTjX1IGh/7lGRl1kyYBqPISnJJaq11/4ZbjupdMRd11Ef6fV7pPsqLDz/ovMHKAAZ69BPrHDmclElhfmHYk2AZ3oQbHbs6dOicasW+yV/lZm4jkn8JywMR86Wy8UNKbpymoTUvdVo9h302Jt3ge2lI5evRgg+afaic0yhML+TYFe37zP+r1a+/RxcZslJIJRhNBKfohJZzG2Zuneiv51IjX01lhDaI43CP+NOCOsqgtWeF2XmdABb28tSDADNFdi6i9/pT6o6JFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN86/AjDwNqncYvAJztTNoIkgsR6y/eTcHqdOEucMh8=;
 b=N0Z9oCmi0Fdf41k4Sy/cm47jLcSpPto/9MarjwywFRBDSzcrxCo/GCgjfh/bXDOzUTMGfZ7X7+cPQr2a/3Es6VWZBgYZ42ZllMrIxZLOG+junLGoHeJRf0CQ48021ty0XvrF7/Y4UgDwTh920f48nb5bqiF24zB0GVz6WJbIyUqRPBrD+b56+XFP70/WVjf0XaKVR3an+XxIgecvycyZLFxEMYu6FiatVcGq10Ig3UnURJhEosDkHP5hKsV5tT9Y9jRwMud2Yd2E0fH52F9Rh46FLIBihtrRr6VddECzKd8wCpbUF3huKjMoMS5dE0B41MUpMcy3Tan2y+XfeKUSUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN86/AjDwNqncYvAJztTNoIkgsR6y/eTcHqdOEucMh8=;
 b=hGeqSdQgoZGCeAfoM7bfeI0km/DmxEruVuj8bTfXaLR0VEXrBh56tn06tZObGnRnsSCPQkzlQCZCNeZvnsHZBm7zOGJQtHPv0bmlJ9r0fMJqlbZklcDJDVNo0a9PC0+g+gM18PsYwKYXQuF7fiHeuDhtPEoGKUpiF2+x8F88UxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 05:05:31 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%6]) with mapi id 15.20.7181.018; Thu, 18 Jan 2024
 05:05:31 +0000
Message-ID: <5c524240-057d-4bcb-8155-c995f2ec2365@amd.com>
Date: Thu, 18 Jan 2024 10:35:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/pm: Fix the power source flag error
Content-Language: en-US
To: "Ma, Jun" <majun@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240117085229.981555-1-Jun.Ma2@amd.com>
 <f902f7a3-ea3a-46fa-9220-447e54954820@amd.com>
 <9a10bd66-6551-416a-a61f-2ff8c209cc44@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <9a10bd66-6551-416a-a61f-2ff8c209cc44@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0076.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::21) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 42b97f75-761d-44d4-2bb4-08dc17e3181d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k4cPMsjFhE+vaZSTC8TAhWmP8dTCLg1EArmnv7eHOdiQZdXBN7ssDfpvBWr73b87PazQ3qIaUR6n+DHg8stM63gWAc+RI9vHNAy147nSD8w/QMp4PQGIMXR5w8vdSr6uq732EGd1tQHOkdpaYIDZN7sbEAw0w52y52PkgG730xpGAYyBwdONKXE1n4n3DlDuU+xJDts5vOubjd4WQq+L9qBKJvhCXjyr7tbJ74M+3r10Oxp8q/HHuVbtDzGFhKk0AcpRr/kHszSgWWnEivvkUEuoNDkIdWH4wqO8OXVAB55ULL+SjG78aP4Pud+yFBKcgx50r1Qx+VpvRyjTtUjlnE7I63XybRVVpFrC6iEx3spBBDSlW78Ho3mnOpIywtyDlTalP/w3Dl/F/u2X7m3+3E7f/OjRU37Kc3qhafJnuYFXOkSxlJF1BnBcqnuFIvt/VIXN09P672gnSGFUEMwzMfCYTrZ8M3ShlSq3zD0ED6ImA3H98CBTR2FEkBKSJ/F8SJsKtlPREmFPCvGKp0H+dvOzToVRmV5aXzvR0MxFAhl5/FQAZMA186Kvv/X/oBdTSou/DE5ZInoZg/N70JGXBVEXmn004O18ApoXvdz5msF0N7Y96X1rFKmMWJOCDKIMXrv1jwsPF8Y/AVk0g2JWog==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(38100700002)(83380400001)(36756003)(86362001)(31696002)(110136005)(66556008)(66946007)(66476007)(2906002)(8936002)(8676002)(4326008)(5660300002)(26005)(2616005)(316002)(6512007)(53546011)(6486002)(478600001)(6506007)(6666004)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?endiNkYzcUxzMXNMbEUxYXJZMkY3T3ZEU2RUSmpqeG5IaTM1T2c2RnNjTUxj?=
 =?utf-8?B?Sk94NXdSOGhZeFJjTU9OamVTaytRTGFDRFFNak1USlA0S051NU9vR0dyT0NJ?=
 =?utf-8?B?bGZlSXBpbDlMbGRaOW5sQUZBamZqUVlPS3hydEovc2dDTDBXODRLN1E3Yjlh?=
 =?utf-8?B?Q2lWZ3RpUjFuY1VRcUFKNU9VVTBnNEE1b05jNWxFRXg3VTE4elBaYzZIdXZW?=
 =?utf-8?B?YW1BdzZwTjhzRG1ibTc1ZzVpWG9NN01OOXVWSEFHVTVHQ3JDeFhqLzU1ZUdr?=
 =?utf-8?B?WjBiZ2E4OThDeE5NUU12KzhGRDI5ekpFYXpONm9GWldxd0N1OXc4SnVDWjIw?=
 =?utf-8?B?TzlPVU84c0VFSDdTOGtOQmpuWDNqanV6NkpEMHRaZ3o3RDhQSFJ4WktibnN4?=
 =?utf-8?B?UzlLTTFtZ0hmNkx5RkJLb1ltVE9MTGhtN0tGaHJqMXg4T2ZDZDF1T1hyQm16?=
 =?utf-8?B?YitmUUhNWTNFYzRTMU9adUNtQlpWVXJEaldkWU1vR1lvTCtzRGI5cEhYUldP?=
 =?utf-8?B?ZWp5RjNlZkR3dGZ5TkVvcU1vQ3RHRzV4akpMK3JxMk8rNkhpblROenlEbzQz?=
 =?utf-8?B?R1F1Szc0bjF0SmNVaVlzOUxRazlySng3VWM3cDRtZ1RDL2RRSVc1amZXK21Y?=
 =?utf-8?B?VHdoVjhydFVJWFRuOGlYMzhCaFRWemNnbHZTZkFNSkJuaHFZRysxN0IyN3dx?=
 =?utf-8?B?ZFFMZ0NIdDZGNmM0UDgyalk0SjFQQXhLU3JKdkVuNGlKdUttOWZuWVhpalNW?=
 =?utf-8?B?Q3V6blVGY1AvYTlEY28zNmZiNVRYKzNoSGJEUjBkVHBIVFdTTUR5dnJya0dL?=
 =?utf-8?B?bHJCOTAzTm5aQ3Q3NFU1QVE3S1R2VzdHc3BWeFFKdjBiWVR6Uzl5TGx3dGZR?=
 =?utf-8?B?cHNuSGtrTXRseENvdW1xL2pPUFluME8xQmpHblJvQ05uZitHM0JVb2J5ZFB2?=
 =?utf-8?B?OFV1V2k1aERzd1VtdHhhSkY0bEZLQVJyWGxkRGJZZnZRZ2JIY1Z5cWNRQjZk?=
 =?utf-8?B?c29OWERueFdTTGRmMklqdkFoR3BlcDI4QldWSUl1WmFxZzVFWnRncUhLNGtx?=
 =?utf-8?B?ZlhUMU5GNXB3SE1UWVVXOGpCdDJMK3JYaE5HckpJdmx5NDFwdEJMeW80VVpW?=
 =?utf-8?B?dGNseWVvMkxFdjhqbGpwRHlKdFN5NWVMUSsxdGxHelBQZVhkWUxKNmlVeEkw?=
 =?utf-8?B?YTlyeUJmT1NSaFM3MUFkM2NHaWo1Wnd4Z0I5NlBHN3lZckJqSTZlRUNobHEv?=
 =?utf-8?B?SG9WaGhLRm5JM2N0WkE1SlVHcm1yNUpNUllsWVA3Zy9hTjFpeXRPQ09YMnIr?=
 =?utf-8?B?ZTA1TFM4V29ob0d1Mmc5NW5LL2xwaFhYT2JLcjh3Vm1hZ2hPb2lNWTh5UVNp?=
 =?utf-8?B?V2g1R2tTOWVSM0ROMmpTTmRvMU8rVmM3Nk9MNmVGNTE3R0VudTZGcUgxVlVL?=
 =?utf-8?B?dzlSdS96MjVJOUQ2a3hvUS9UaGFpcm9sejdmZ1E1bHZ4Vm84ME05Z3pQcmF3?=
 =?utf-8?B?UVQ2NXRsRXI1RjNXSTJZNmdDNkR4YktqYzVkTlRJdU5vTzVLVnU3RFZBOU41?=
 =?utf-8?B?ckdTamdRZTJSdFRhWE5PcTZxdkpBWlU2WVRZblJFNVRHVDRrQi9DMlhvd2d6?=
 =?utf-8?B?N3JpdGJQeFFRTU4rVTQ5OHl3K3k5L0Nyc1FGTjNyYWN2SmRNUnFOdkkyUnlm?=
 =?utf-8?B?NE83QnlPYnQ0Q2pLRWJNcDlIaG9SYmxWdThFMC9nL3lHM2s0MEVCdzRzVC90?=
 =?utf-8?B?amlVc2NlRWJGSzQ3Rnc1NnRVUUdtQzQ0Q1FVVGpZUGQyZFpSMFY3MUd3OCsy?=
 =?utf-8?B?VmM2MW5iOHBld0tGcDZtQmQ4bHpzWVJqdFZzV3N3dFR5VitXVi82M0lXYWpH?=
 =?utf-8?B?aUh5K2tySWFNUzlVZ1NlQ0lZeGk0RThGbkNmaVdycWFSencwSFM0VDlBay9I?=
 =?utf-8?B?OFg1Z3NVTVh0QXNDcGppSlk5d2twdnFobEpjNHNVdEpmajkzTVZYMDFWaHBa?=
 =?utf-8?B?MUp0ZXYrWVpBSDNQbzZlT1NIdFhETk5HdEJjc2ZBWnN5RE01bzhHK2FTUnpK?=
 =?utf-8?B?dytiVnJXSktXZnhoOE9GOHB0ZGJtRWttcUdSMUQ5M0s2aHJpdXV2Rkp1RHVs?=
 =?utf-8?Q?HXx717jI/bPOZknMthd9h4HNe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b97f75-761d-44d4-2bb4-08dc17e3181d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 05:05:31.3114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNuz1qgha7QENTUtQnWEZqms7V1lT/q/JRlWEXxPeF6MHPTjQx+q9FnMDY7MbORM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/18/2024 7:54 AM, Ma, Jun wrote:
> Hi Lijo,
> 
> On 1/17/2024 5:41 PM, Lazar, Lijo wrote:
>> On 1/17/2024 2:22 PM, Ma Jun wrote:
>>> The power source flag should be updated when
>>> [1] System receives an interrupt indicating that the power source
>>> has changed.
>>> [2] System resumes from suspend or runtime suspend
>>>
>>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 24 +++++++++++--------
>>>    .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  2 ++
>>>    .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  2 ++
>>>    3 files changed, 18 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> index c16703868e5c..e16d22e30a8a 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
>>> @@ -24,6 +24,7 @@
>>>    
>>>    #include <linux/firmware.h>
>>>    #include <linux/pci.h>
>>> +#include <linux/power_supply.h>
>>>    #include <linux/reboot.h>
>>>    
>>>    #include "amdgpu.h"
>>> @@ -793,6 +794,17 @@ static int smu_apply_default_config_table_settings(struct smu_context *smu)
>>>    	return smu_set_config_table(smu, &adev->pm.config_table);
>>>    }
>>>    
>>> +static void smu_update_power_source(struct amdgpu_device *adev)
>>> +{
>>> +	if (power_supply_is_system_supplied() > 0)
>>> +		adev->pm.ac_power = true;
>>> +	else
>>> +		adev->pm.ac_power = false;
>>> +
>>> +	if (is_support_sw_smu(adev))
>>> +		smu_set_ac_dc(adev->powerplay.pp_handle);
>>> +}
>>> +
>>>    static int smu_late_init(void *handle)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> @@ -817,16 +829,8 @@ static int smu_late_init(void *handle)
>>>    	 * handle the switch automatically. Driver involvement
>>>    	 * is unnecessary.
>>>    	 */
>>> -	if (!smu->dc_controlled_by_gpio) {
>>> -		ret = smu_set_power_source(smu,
>>> -					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
>>> -					   SMU_POWER_SOURCE_DC);
>>> -		if (ret) {
>>> -			dev_err(adev->dev, "Failed to switch to %s mode!\n",
>>> -				adev->pm.ac_power ? "AC" : "DC");
>>> -			return ret;
>>> -		}
>>> -	}
>>
>> For this part of the change - driver already updates FW with the initial
>> detected power state or the last detected power state before going for
>> suspend. Isn't that good enough?
>>
> 
> The power source may change during system suspend, so it's necessary to detect the
> power source again before system reads the power related data, such as max_power_limit.
> 

Ok. For dGPUs, then refresh of power state after resume will be required 
in GPIO controlled case also. Since FW is reloaded, FW may not detect it 
as a power source change.

Rather than creating another wrapper function, it is simpler to do 
something like
	adev->pm.ac_power = power_supply_is_system_supplied() > 0;
	ret = smu_set_ac_dc(smu);

Thanks,
Lijo

> Regards,
> Ma Jun
> 
> 
>> Thanks,
>> Lijo
>>
>>> +	if (!smu->dc_controlled_by_gpio)
>>> +		smu_update_power_source(adev);
>>>    
>>>    	if ((amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 1)) ||
>>>    	    (amdgpu_ip_version(adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 3)))
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> index 2e7f8d5cfc28..8047150fddd4 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
>>> @@ -1442,10 +1442,12 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>>>    			case 0x3:
>>>    				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>>    				schedule_work(&smu->interrupt_work);
>>> +				adev->pm.ac_power = true;
>>>    				break;
>>>    			case 0x4:
>>>    				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>>    				schedule_work(&smu->interrupt_work);
>>> +				adev->pm.ac_power = false;
>>>    				break;
>>>    			case 0x7:
>>>    				/*
>>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> index 771a3d457c33..c486182ff275 100644
>>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
>>> @@ -1379,10 +1379,12 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>>>    			case 0x3:
>>>    				dev_dbg(adev->dev, "Switched to AC mode!\n");
>>>    				smu_v13_0_ack_ac_dc_interrupt(smu);
>>> +				adev->pm.ac_power = true;
>>>    				break;
>>>    			case 0x4:
>>>    				dev_dbg(adev->dev, "Switched to DC mode!\n");
>>>    				smu_v13_0_ack_ac_dc_interrupt(smu);
>>> +				adev->pm.ac_power = false;
>>>    				break;
>>>    			case 0x7:
>>>    				/*
>>

