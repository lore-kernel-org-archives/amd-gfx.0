Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1739C48260
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 15:05:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7850310E855;
	Thu,  8 Feb 2024 15:05:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cYH6lg9N";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2FD010E855
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 15:05:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh+NlWwYcVp9VapI9PQUXp2SFZmy3MgDkZCf/xsamHqBcdK4f6fWiz+owOO6T3CtPDemVyYlYufI99G6SeTfBKHOT5bfVovUJ4t6rRykyXY8rxqYK1aAQJpK2zfMwsAZeZP1Xo/WJW5t7C1LIg1P4GduPzorkUKFy1M3r2Ll/Td5HzAB16qpi8BlM6hG1eX5iL6335jeYowpFypNlXqSGGRaBM1JrJNJzczgFsLWJyje4VsxMbrc5uV3TRW0vfqg2HTwoXPCo0BkFG5W8OMi52PsSszau8Iqu+nyHBoQjnoKCZ4xKbDxERLBCcIoWLun8W9XvKsUeGecDmxDWnPi9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qiyYjqKW7BZhtcYTAEd0INgDI+2uo+PNvDlrNEN8uY=;
 b=XPB3viWl7jnztmE3XrHWDo6TPWeAtEA8VP9d4ip2RvmrtLXTUB1LJG1iyaK9J4A4oMM3XLv6mSHNg56FrBpJFyfypZ0b5UyjfugDEZ2agNxw8kcVNa2f7gcOD7gSFBKrPY/kgtpHgCs0V7gVWmEHt/2M+TOAss08mKZdczXEi+VW5mc9iZ1e8QECtHuPMBhM4dHCeda74XY/Fe7kfF4FvuiFuKUOhnkb74LAog9HzhUX5QsXHhOMu7q8PW4WliWdUdYOkAYClLbZlGiSbsKGpn2tp4SG4FXAoJBBieqe3CFlsZXLdp6p5B1nODdF1YXL9HS/oDxqfN33PDoQMNQlsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qiyYjqKW7BZhtcYTAEd0INgDI+2uo+PNvDlrNEN8uY=;
 b=cYH6lg9NMBO5BfUXRjd03uJ/jjh0DHDmr19vM4zmKC4wD/mF9l7ElRBOWQZgsZzuqcCpwytzUq+6Yky+80ihTiMgbpccLfoVCEvQZElezr9C3U1rUztqKSUjnEavVyfT/FvoWECjq2Hfu47j71FFFjdu1jvDllFqFuQw5CLgWg8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by SJ0PR12MB8614.namprd12.prod.outlook.com (2603:10b6:a03:47d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 15:05:06 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::f6d2:541d:5eda:d826%5]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 15:05:06 +0000
Message-ID: <a504e189-27cd-4766-843c-579cb36ef343@amd.com>
Date: Thu, 8 Feb 2024 09:04:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/amd: Drop unneeded functions to check if
 s3/s0ix active
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20240208055256.130917-1-mario.limonciello@amd.com>
 <20240208055256.130917-3-mario.limonciello@amd.com>
 <b2d9c463-19f8-40d0-86ca-37e500634b9d@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <b2d9c463-19f8-40d0-86ca-37e500634b9d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN7PR04CA0013.namprd04.prod.outlook.com
 (2603:10b6:806:f2::18) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|SJ0PR12MB8614:EE_
X-MS-Office365-Filtering-Correlation-Id: aca44efe-6fc9-4965-4e2b-08dc28b755ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zgcJObwkwG6uVEIdjGtPXiTq0GereZuR+IZa4DwEtqiiv8kXwFdGQf1/Geo7uwkwdbWWkSSJ4w8X5fad/9ffSYTp1tPujw14muBrBBom3ism4Q2s6Pah0njK26IrlQEWqy+jMT44tlSDhPWuZ2Dtj5KsDI8DUm+51R0yGwAkOhoNdKwIZ6w2JID6BUyz9D0uGOodU4lZWHQKCt8XsJibEC5AwfTA0m7DDaOor+b5lrgkLOZLlrRNV2BjlMu80VvDPkW86hyeMaZW5JbbkCe2iir3V/zO/c9xF/yWAO5ymWIhOyf7cxnR4ztnGYKq+u/3NKXQsdVpoYVGhyo5pktyFKX7aF2Elk8T5QS0WKjzuRhKkjlM0RMz6J/gQOMeCJOnxK9TkGoVOinmnSsUdwFWXfP0KF2WzXHhBEbJ2Wbrv2Tf6xq1E9beAwT8C076D1qPyu+hpr6ReCcay9LhZwYrEKH1koFF6jp+0QkJx1ygVgRyweCcZyozb593MzQk9lwJ4G6jor7HxA/NZtLcmAA0egsD2cNZYwlw9EVsR1BeBjnEz18igNHnOeJ87Kmw3EZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(396003)(366004)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(2906002)(6512007)(53546011)(478600001)(6486002)(31696002)(41300700001)(36756003)(86362001)(44832011)(26005)(83380400001)(6506007)(316002)(66556008)(5660300002)(8936002)(6666004)(8676002)(66946007)(66476007)(2616005)(66574015)(38100700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU1YdEtBVXVxS2orcEpRUnRIL0x2YnErUXlSRkZNWXpmcWlXN2wySk45azVp?=
 =?utf-8?B?WXppZXB6ZnZIUG11L2ZOMFhCSkJhd1RudkVVLzdWMyt4V25UV2V2MXN5QTZr?=
 =?utf-8?B?cDdPQjM5emZmREU0RjN5b2tFSDNMVWlleWUzWmd1ekxvaVBteEVFeFJoakh4?=
 =?utf-8?B?bHloY2t1WlFjdkppSExKYTlTcXQwN3NhK0J4cGoyYWVKU3RKTU94aXlXMStF?=
 =?utf-8?B?WWdISTVBRytYK2pTOHhJRTVFRW8rRXNnUE14VjlFTmVHUWs0SHBBdWxvS0Mz?=
 =?utf-8?B?SnF1Z2Z0QVNGU1RITU82djNRUy9XWDJJZ2tJR3RtRHljSCtKOFZCOXkzc2Rl?=
 =?utf-8?B?SzNmMFdDdlpTeTJ2Mll4VGNPRlpGOHFPWlM5SDRza3BVL1pQU0EzRytYNytN?=
 =?utf-8?B?WjA0cnZ2WkVWRzdYWkN6U0VRMXExVVdCQldHV2t3Vk1rdHd4QWd4QmREdU1k?=
 =?utf-8?B?c2lDWnQrbnhWZFRxeGdGb09ZMVRxd3dSSVVJUzFQdmF2cnVHNWliTllYK093?=
 =?utf-8?B?Y09DQVNHMDcwbGdZdExEdklTZmdpdkk5eUlkaVNXYUpUelJCK3FWamZOTXdU?=
 =?utf-8?B?Zmw2VVZDaGVqRkVJMDhOOW0zT3ZBZFhSNVNxM2dOQzQ5ZGxnQTRNQkl0R3c2?=
 =?utf-8?B?YWtOdmJXcVQvWFZ4U29CQ3RqbC9BbWhCOWs2ZUVzUWhudzdQdEgvd2ptVnR0?=
 =?utf-8?B?T2Ywb21JU042bnNrRnhQWHZNT2tNQmdaRis2dDJvenNGdVFpSC9NL3VEc2JR?=
 =?utf-8?B?OEYyMlFNSDRMVWt2Nzd0R3hmbWdQOGVDNDZDZzF0ZEdWNmRPb0dyeC80NDlz?=
 =?utf-8?B?UGw0V2MwNXhBQnYrS0xHMDdlMVBtNW5Ma2JwT3RVVllIa05JK1k4S3BCem1x?=
 =?utf-8?B?UXdDSUU0azlKZ2wzQ1FuSFR2OXo2M2tnNXd1Z09UYXlMRUtyaUNkMGtSdHY2?=
 =?utf-8?B?M3hWNElFT0d5a2ZhYVYzdUc5ZVBSb3p2OHBOQ2tRdHQwZE5JaGlmQWs2Tm1r?=
 =?utf-8?B?SGZhYmZqbW91bGpWOTVZMXJlMml0azJYUDFRaDlST05pUzNFanBiK0MyRTdM?=
 =?utf-8?B?dXlYdmZIeTdwc0xUd2RnMXJSVExzcitacUcyUFFMenVVSUhxc3BJSWFZYkNZ?=
 =?utf-8?B?WHo3aUdMSzVqejk1Qm1mdVhwbENkNEhCbDg0UXErUFJYaC84elZyVVVkam1h?=
 =?utf-8?B?Qm5pMmQ5aDF3akdwWUtXZmdoUDZjb0JmeGwyaFBUdUhXZnJaa0RFaXlDUk0z?=
 =?utf-8?B?TzR6RDlxOURxSzUwaVcvWWlhRDhZNGJGUGkvK3ozYUY2WjlBNDhOamJtVGpQ?=
 =?utf-8?B?ckdZWFdoNGdBSEhkc3l2Y1laY1J5QnFYM1RiY3UwNUQvNlE0TSs5SEVXSWw5?=
 =?utf-8?B?RjdXRWlVcy9wdmk4bXBIUS9ZTmV1S2d1aFB6NWNtMTN2V21sM3plV2JWWUhx?=
 =?utf-8?B?cnh5Y2Z4REdyUUg3SGtvbVJQUzhmQVpRUStDdStFZlJLZWlWaFk4Ukg4VDFQ?=
 =?utf-8?B?ak5RMW51V0g2aDBHTGhJNmVPcjZIbVBWR0dmeG9UZS9NeVZXU3FXMGxQZjds?=
 =?utf-8?B?T0pKbWUxY3lIcDVTUlNPbzhyeWhmbTEyZWlqTjNjRUdVRk50V3p3MUNSTlRt?=
 =?utf-8?B?V2tXSEpIMTh0L2hSRXdjWU02V0xVc2FJK0Y1cVhJQlJSMDBHNlFpUFVhZnk2?=
 =?utf-8?B?VlN3amhPc3JNVEpwWnRxZW92dUQ1TUxlOVlaWWlOYU9yUFhaZGhJeG9FUGlZ?=
 =?utf-8?B?MXowVXgrMDUrNnRoRno3REVNMjhGbDA2b1pmaTM4Wmk1SGRzb3Joakc3MFBr?=
 =?utf-8?B?ZkFrSFVLSzNXdjhNSDZqZHZad1JJdlJGN1dqcFpTZ2U5SVIyRkZBb1czMU1J?=
 =?utf-8?B?OHd3ZWMvNmgvbGkxYnhQUnlTOTJKWVk4cDh6Vzk5RHVZcmVhd3U4SFlFQWk5?=
 =?utf-8?B?eVJiQjR0eUxJU2RjMDBhbXJ4UEtxandYZUJocXdkdFk0ZWdmSDJiZHF5bkVK?=
 =?utf-8?B?Zk0rNUFDQ3hKbkFsTVc0Y2hGR3dTTWI4UCtKS3ZkSndQMjJKQVRkWm5aZzJ5?=
 =?utf-8?B?YmtGSVFpdU00bzFFemdIekpackdKMHlNUTY1UDdMZHVaL24zaGdnZW1qbko4?=
 =?utf-8?Q?8aueyVZQ80DvvBiqmVqfj8jc2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca44efe-6fc9-4965-4e2b-08dc28b755ab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 15:05:06.2341 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WkYrrV6a7PNIblSaID8QSm59lb0t8gtYEEzAzmbdd9FVG91jskOguTC3zzHhZqHOd7XEfkJuPHrAwCC2KCsgWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8614
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

On 2/8/2024 00:54, Christian König wrote:
> Am 08.02.24 um 06:52 schrieb Mario Limonciello:
>> amdgpu_acpi_is_s0ix_active() and amdgpu_acpi_is_s0ix_active() aren't
>> needed to be checked multiple times in a suspend cycle.  Checking and
>> setting up policy one time in the prepare() callback is sufficient.
> 
> Mhm, looking at amdgpu_acpi_is_s3_active() I think we should not cache 
> that in a variable in the first place.
> 
> Just calling the function all the time to check the state should be 
> sufficient, or do we then run into any state transition problems?

I think calling to check it each time is perfectly fine, it should never 
change once the sequence starts until it's over.

If the first 2 patches look OK, I'd like to get those merged so we can 
fix the regressions.  I'll do another series that can drop the cached 
parameters.

> 
> Regards,
> Christian.
> 
>>
>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>> v4: New patch
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 ----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c |  7 +++----
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 17 ++---------------
>>   3 files changed, 5 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index f6c38a974bae..53823539eba5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1545,12 +1545,8 @@ static inline int 
>> amdgpu_acpi_smart_shift_update(struct drm_device *dev,
>>   #endif
>>   #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
>> -bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
>> -bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
>>   void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
>>   #else
>> -static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device 
>> *adev) { return false; }
>> -static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device 
>> *adev) { return false; }
>>   static void amdgpu_choose_low_power_state(struct amdgpu_device 
>> *adev) { }
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> index cc21ed67a330..1d58728f8c3f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
>> @@ -1366,8 +1366,7 @@ bool amdgpu_acpi_should_gpu_reset(struct 
>> amdgpu_device *adev)
>>           adev->gfx.imu.funcs) /* Not need to do mode2 reset for IMU 
>> enabled APUs */
>>           return false;
>> -    if ((adev->flags & AMD_IS_APU) &&
>> -        amdgpu_acpi_is_s3_active(adev))
>> +    if ((adev->flags & AMD_IS_APU) && adev->in_s3)
>>           return false;
>>       if (amdgpu_sriov_vf(adev))
>> @@ -1472,7 +1471,7 @@ void amdgpu_acpi_release(void)
>>    *
>>    * returns true if supported, false if not.
>>    */
>> -bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>> +static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
>>   {
>>       return !(adev->flags & AMD_IS_APU) ||
>>           (pm_suspend_target_state == PM_SUSPEND_MEM);
>> @@ -1485,7 +1484,7 @@ bool amdgpu_acpi_is_s3_active(struct 
>> amdgpu_device *adev)
>>    *
>>    * returns true if supported, false if not.
>>    */
>> -bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
>> +static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device 
>> *adev)
>>   {
>>       if (!(adev->flags & AMD_IS_APU) ||
>>           (pm_suspend_target_state != PM_SUSPEND_TO_IDLE))
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 971acf01bea6..2bc4c5bb9b5a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2456,13 +2456,6 @@ static int amdgpu_pmops_prepare(struct device 
>> *dev)
>>           pm_runtime_suspended(dev))
>>           return 1;
>> -    /* if we will not support s3 or s2i for the device
>> -     *  then skip suspend
>> -     */
>> -    if (!amdgpu_acpi_is_s0ix_active(adev) &&
>> -        !amdgpu_acpi_is_s3_active(adev))
>> -        return 1;
>> -
>>       return amdgpu_device_prepare(drm_dev);
>>   }
>> @@ -2476,10 +2469,6 @@ static int amdgpu_pmops_suspend(struct device 
>> *dev)
>>       struct drm_device *drm_dev = dev_get_drvdata(dev);
>>       struct amdgpu_device *adev = drm_to_adev(drm_dev);
>> -    if (amdgpu_acpi_is_s0ix_active(adev))
>> -        adev->in_s0ix = true;
>> -    else if (amdgpu_acpi_is_s3_active(adev))
>> -        adev->in_s3 = true;
>>       if (!adev->in_s0ix && !adev->in_s3)
>>           return 0;
>>       return amdgpu_device_suspend(drm_dev, true);
>> @@ -2510,10 +2499,8 @@ static int amdgpu_pmops_resume(struct device *dev)
>>           adev->no_hw_access = true;
>>       r = amdgpu_device_resume(drm_dev, true);
>> -    if (amdgpu_acpi_is_s0ix_active(adev))
>> -        adev->in_s0ix = false;
>> -    else
>> -        adev->in_s3 = false;
>> +    adev->in_s0ix = adev->in_s3 = false;
>> +
>>       return r;
>>   }
> 

