Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90881C05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 19:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3DE10E97B;
	Tue, 14 Feb 2023 19:28:48 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6F7510E97F
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 19:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ntJ9oxm8MzIK10LpGKPD4tC2vJwg7bhKetfDCowTd7OGdiY1EIJbLtLtrkRtUj3aaQWgftdkEkLq1qWs9QWmmROO/KoTRYSvpdEOPtViwoFMXtf8YZpgyjrIlX3Ac8onGgteVA+jScYF9NJbNbvj5JIftb/0GhjmWlAuCAlKtngIWyzZM9aUYawsWTSMCa/N3TNIlAIZF+0iGQ7g2gF+tiVvS+yYxWgk0G5S6rMgmpn4HkP858lWkQhY7q6Byzhz6Oy2mESe6fvkXGM/I7XvjyXP+TpiX4i6JqzObgXtbFGmt7R01E0+smRY0AwpFkVb0EWev3Ktta6BuhIXtZhkKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf7TOlJM8KyMzXJKXb8uAtHdoZVs4RbTKXKv1YSpaes=;
 b=K1BzIPhQqbz0+K2w0x6l4vPF8BllG66zd3sEFCkBbdnlRD/DucSTuOITVeRdL3nG2Ikjwzmnz54gXIa49BHohEwUOiD9OeTzIb0cCtber6msEGkUe7iORUfCTagDjF44endjwtVkO+RRxektnv2xjxwZ3T82pFLOcVstetoIRERM6s98Fc3x1WI38SWFcRtkv9HCZe8gxoDyjGBNJsIODVKnNGF1yb1xJUL3qdV+tw2Ifi0ZhP8T58XEeX3QU2W+RFMHu357h9V2LcobXJnTVLOjX8V0QWrgGdQsPtJTzJIA/SnCVSE9jxg1Fhr2+WlbNOB7IVbnvzWw0LOKbB6k5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf7TOlJM8KyMzXJKXb8uAtHdoZVs4RbTKXKv1YSpaes=;
 b=ThaQQXUhf74Q1VtI7kqIaIi9WMrNIY7NpEWfn1+/9l/3OsnGI6/4F52O5PwF1vmKSGQk3gamBhqBCI82I+H6OoNiOc40NEkE8E7nlsj3N6BurUN/LE2VrBpzP+dMwqBl1X7M6CyKGlVUpPhO/bRtG5s6rsO5CojSGpuic2w46Bs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by CH0PR12MB5060.namprd12.prod.outlook.com (2603:10b6:610:e3::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 19:28:44 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::d1c8:8b04:20ba:9d6f%4]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 19:28:44 +0000
Message-ID: <ae796f69-28bb-4e45-700b-39a13b69bcf7@amd.com>
Date: Tue, 14 Feb 2023 20:28:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 8/8] drm/amdgpu: start using kernel doorbell bo
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230214161510.2153-1-shashank.sharma@amd.com>
 <20230214161510.2153-9-shashank.sharma@amd.com>
 <d890c9c9-5cc7-365a-df23-f2c16a85bac9@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <d890c9c9-5cc7-365a-df23-f2c16a85bac9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|CH0PR12MB5060:EE_
X-MS-Office365-Filtering-Correlation-Id: 75dd5f24-e90b-40ee-f3c4-08db0ec1afc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wy4DIpaAKg2OOJcCCxbnnLbeRqvCmCps+o+J2JbhXEJ7rF5Rx+uskOaXpD/uYG/cEPvxI6Qi3I/jgmpUdmEGnjIPMJerYYIarwjYqcIaiWxnyLfG9QLMevjJ3Mk0mfAf4287/9L/FQTY6I0LiJcVFxcR92w+EYKJ9R49WNCMd9VFeT36qCSoeeSC8g5LRT1o1EZrukXIVRe+0rbJ7ejEzL5sU4DYNmipTs2c1KpwEn3gPD26pJg27IO1j0ClgXWri0lzXyl5yFed0rJ4XdMdsU+/GFF0H94UbHO0SQocEmjSRkEVnEGvQHwxjtQp8X+cHJzxBVUe/wwemetLm8N+67hBkbPfYYH9sP1CXSty9H+g3qWQOoEs+bC+d9Qp6tz79IXdM1kybhgHku7w7sjl9d9yZLXq+spiLSnSeNZsR/EFpjYKWrBo93D54ccX+7FbM7ENDnJUxMOOVAOq6ucEgR2549hj1EmviPrEeKbkShyruRjDGUjlpntP5Te3AZLtVey2irWl/dg2DBLp/rf2aqUZHOZvlNhdXclOCrEgXHwegHSkNMlR0o4eRBFk6e0w9CLhIQRivsVWdmOGOLY/TyzO8Je/Q5KRorzIxvZLIq+fK85sFFrQTDRa6gA9YXE+/iKFE0NWuWC924mZ3myJ8EiENBi89tyDFV5kBXVTS2tNkko40E09cYYHDoLljMHQxvW7pRtn7TBDvnr4i+KmWXtPUx70E9tINkOoTJhWZbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(451199018)(36756003)(31696002)(86362001)(186003)(26005)(66574015)(83380400001)(316002)(6512007)(478600001)(2616005)(6666004)(31686004)(6486002)(6506007)(53546011)(44832011)(2906002)(8676002)(41300700001)(66476007)(66946007)(66556008)(5660300002)(4326008)(38100700002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0JNZ3ZqMEFUY2NCcFIvYVMrVWx4WG5rNlkvVjBQWDlkSFphRUsxWEFlU3NG?=
 =?utf-8?B?Z3FFNHh6YkNSS1Q0UkZ4aHZBRFp2YnQ0UWtUQzh4OStuYXB6UkFlbTY1dVM2?=
 =?utf-8?B?ZGY3b0NjWThuYnlHQUsvbXBVZ01YUmVPMlFmbjI3bmJjUTR5WlZ1WXlqeWtv?=
 =?utf-8?B?NVBaNURPa1F2TEJVaXc2S3FUYkhyTnR4dG03U2J0ZzJFa01HWmZDNThTZVRI?=
 =?utf-8?B?UXJhdCt6ZG5weXBKaU9vSWFkdEl0eEVlTEFCTnd4Y1VSZTRyRTdnMGVHSldj?=
 =?utf-8?B?RlBxNENqZHB1WkVnSjZrdVBVa0tVbkhyKzRXUzZpMFowVVhLaWdMTDVzS3hJ?=
 =?utf-8?B?eXlnK0NITGlkVStNVUxHYm8vMFhPd1BqbmRUblpwV3pLNGRUMVpOdEpmNk5m?=
 =?utf-8?B?V0hUWDVZeUZnMEE4S0pxbURmSjdkOTEzYWFkdWxEOEZqaHEzMDRFclNsZWs2?=
 =?utf-8?B?VE1lOGZUaWIxUW1ibWNFd0FlMlVYY0k1bjN3UHE5cmY2bG55VlZVdTNzWDBy?=
 =?utf-8?B?ZTZNN25QVTFOR0RvTFlmU0tVUFlzMjZyR1FwcEVkY0JYTU9oSVhqaUtnMEFl?=
 =?utf-8?B?b3ZEVEtVSWFKRmk3VVVHNHl4Y1BDSFkyY0FjZVJJZ0FYUElCYVdVbm9iUWJO?=
 =?utf-8?B?S0xtOWNFTGNPUUFHZG44dElKWlk5TEo3dEUzWEFGZVhVdkFJY2RldWovbWg2?=
 =?utf-8?B?WGRGMXQyVVdkcVVUdXhzN3lrYmQwenpvRGZwNGI5VHltV0cvTEFZS0RrVkkr?=
 =?utf-8?B?MXNVZjNHRjY4Tzl5OWt1UU9WSnU5VTBBQ1ZmS1JjcnBGQUx0UVlqUnU5TjBs?=
 =?utf-8?B?Q1ArcXVpb0xPMXBCQWdOeGwvY3V1K3BtbEsyKzBQcXFCTklIZkM0WE44dnNU?=
 =?utf-8?B?TDE1S1NHZWZPYUIvNFNKY2hCK1dvRHQ1N1I3aUJZS29sK2dkWXhrVGhSY3J6?=
 =?utf-8?B?NDlGM2pmNFR5b3NGZGVqeFRYUUVkYkwyRno1OFFMSm5rMU5pN0t4SjhiV0x4?=
 =?utf-8?B?ckJzemJmUEFyY2J5RWxmMER0eGMzR2hEWTJ0dmE0aW9PNUZVa0NCVGYyeHhO?=
 =?utf-8?B?MGo0dERWNlNPYWNCWkxCUi9RTlExQ0Q5V1FCdjdjT1hJVWYrRzVHV2pKM0VH?=
 =?utf-8?B?ZGF2RVNlNklkdzNvZDE1WGdlODUxUHFTQXlnNjF2QURLdS9kWTA5VmZHUFU1?=
 =?utf-8?B?SXp5My9YeVoyWTNSWTVIWjlSaURzeHNkU2gwdE1ncFJrM0tOOVhIT2FJclRI?=
 =?utf-8?B?d2l4cnc1MlNGVFAvTnZLenQrakxjWFBVTWxBZkVadWpJUTJ0YjBndEJ3WkFH?=
 =?utf-8?B?TVhJVFhRVzhncmhwZkNhZXEyN1pVRXRCeHU5VjZteWZCeFFFbHMvaEw3RWFL?=
 =?utf-8?B?QVlVSXFJb21qRk04cnNsWkFzYmd6SEp0dzRDdFVtb1pBa01VZklGb0dEeDg2?=
 =?utf-8?B?cDhyR0J6Y0U0cjN5TTFaNW8wUHp6ZW10S08yL2NSZEY0RHl4T1g5WFRmWHRo?=
 =?utf-8?B?RE9Xd3ZDbjIrVmRuenkxRDV2cjNkREFJY3Vod0hBaGpVU2x2NVZnRWI5UCt2?=
 =?utf-8?B?bkpHeEdBSDdzM0w1SDJpeUsrWFdmVnIyejJGK2Z0VTJ2VzduMzI2eGxVa1p6?=
 =?utf-8?B?eXNyeWpiemxxOHFCcVZubitJUElVay81NkFTQTZncGVveURpZ3BSTEJJa3Jw?=
 =?utf-8?B?a2R2d0NQQ255cXhHRlI1THY4UTJsRmRqdS9MbGowSXYyZDZnK1pjdExjOEo5?=
 =?utf-8?B?RDliNEZCd0Y3L2s3cThMWGhxOXNiT25hcjJLUGtjRkdSOGRLeGErRGxzbk9G?=
 =?utf-8?B?UVgvVFZZR3FyT3hWNy9ZL3RrL3FLRk50L281MnkySGZDUnNnVWl6ektwWlYx?=
 =?utf-8?B?R0pHUjhzS0RUNlo4d3RtYm1iTFpBNTZHWlJpNkROMGxIcURyaVF0T0U1cXcx?=
 =?utf-8?B?dk5xWW9ncFdLVytaM21mcUpES3FPNWk3RC9MN3VNTVM3ZWt2d0pUWUVsZHdG?=
 =?utf-8?B?ZlQzenpJUlZYdXd6WDZQNWFsT3p0VzZlVU5rbjZrZTViQktzN2tuZGVpS2R0?=
 =?utf-8?B?c0ZmengrQVBKOUU0TFUxOUlCdlBrbEdOMmlBUzRYemc2bXVCZmh4VUJ6VHo0?=
 =?utf-8?Q?lPRVN+EBWCZzNfa282U+qFc/L?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dd5f24-e90b-40ee-f3c4-08db0ec1afc6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 19:28:44.6240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ggqo9ZAXnG5nvb8sbP341xf14mIgTe18QGLWN/yOhtgcL3OnkD7kIfXvfrPRp3/ACmMEwAI2RliBGDtgc3J9RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5060
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, Arvind.Yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 14/02/2023 19:40, Christian König wrote:
> Am 14.02.23 um 17:15 schrieb Shashank Sharma:
>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>
>> This patch does the following:
>>
>> - Adds new variables like mman.doorbell_bo_size/gpu_addr/cpu_addr.
>>    The cpu_addr ptr will be used now for doorbell read/write from
>>    doorbell BAR.
>> - Adjusts the existing code to use kernel doorbell BO's size and its
>>    cpu_address.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>
> Maybe squash this one together with the previous patch.

I just split it from the last patch in this series, thought it was too 
scattered and might not be

easy to review :D


>
> But see below.
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  5 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 33 +++++++++-----------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  1 -
>>   3 files changed, 16 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 0493c64e9d0a..87f486f522ae 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -109,11 +109,10 @@ static void amdgpu_doorbell_get_kfd_info(struct 
>> amdgpu_device *adev,
>>           *aperture_base = adev->doorbell.doorbell_aper_base;
>>           *aperture_size = 0;
>>           *start_offset = 0;
>> -    } else if (adev->doorbell.doorbell_aper_size > 
>> adev->doorbell.num_doorbells *
>> -                        sizeof(u32)) {
>> +    } else if (adev->doorbell.doorbell_aper_size > 
>> adev->mman.doorbell_kernel_bo_size) {
>>           *aperture_base = adev->doorbell.doorbell_aper_base;
>>           *aperture_size = adev->doorbell.doorbell_aper_size;
>> -        *start_offset = adev->doorbell.num_doorbells * sizeof(u32);
>> +        *start_offset = adev->mman.doorbell_kernel_bo_size;
>>       } else {
>>           *aperture_base = 0;
>>           *aperture_size = 0;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 43c1b67c2778..fde199434579 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -596,8 +596,8 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device 
>> *adev, u32 index)
>>       if (amdgpu_device_skip_hw_access(adev))
>>           return 0;
>>   -    if (index < adev->doorbell.num_doorbells) {
>> -        return readl(adev->mman.doorbell_aper_base_kaddr + index);
>> +    if (index < adev->mman.num_kernel_doorbells) {
>> +        return readl(adev->mman.doorbell_cpu_addr + index);
>>       } else {
>>           DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>           return 0;
>> @@ -619,8 +619,8 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device 
>> *adev, u32 index, u32 v)
>>       if (amdgpu_device_skip_hw_access(adev))
>>           return;
>>   -    if (index < adev->doorbell.num_doorbells) {
>> -        writel(v, adev->mman.doorbell_aper_base_kaddr + index);
>> +    if (index < adev->mman.num_kernel_doorbells) {
>> +        writel(v, adev->mman.doorbell_cpu_addr + index);
>>       } else {
>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>       }
>> @@ -640,8 +640,8 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device 
>> *adev, u32 index)
>>       if (amdgpu_device_skip_hw_access(adev))
>>           return 0;
>>   -    if (index < adev->doorbell.num_doorbells) {
>> -        return atomic64_read((atomic64_t 
>> *)(adev->mman.doorbell_aper_base_kaddr + index));
>> +    if (index < adev->mman.num_kernel_doorbells) {
>> +        return atomic64_read((atomic64_t 
>> *)(adev->mman.doorbell_cpu_addr + index));
>>       } else {
>>           DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>           return 0;
>> @@ -663,8 +663,8 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device 
>> *adev, u32 index, u64 v)
>>       if (amdgpu_device_skip_hw_access(adev))
>>           return;
>>   -    if (index < adev->doorbell.num_doorbells) {
>> -        atomic64_set((atomic64_t 
>> *)(adev->mman.doorbell_aper_base_kaddr + index), v);
>> +    if (index < adev->mman.num_kernel_doorbells) {
>> +        atomic64_set((atomic64_t *)(adev->mman.doorbell_cpu_addr + 
>> index), v);
>>       } else {
>>           DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", 
>> index);
>>       }
>> @@ -1037,7 +1037,7 @@ static int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>       if (adev->asic_type < CHIP_BONAIRE) {
>>           adev->doorbell.doorbell_aper_base = 0;
>>           adev->doorbell.doorbell_aper_size = 0;
>> -        adev->doorbell.num_doorbells = 0;
>> +        adev->mman.num_kernel_doorbells = 0;
>>           adev->mman.doorbell_aper_base_kaddr = NULL;
>>           return 0;
>>       }
>> @@ -1052,13 +1052,13 @@ static int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>       adev->doorbell.doorbell_aper_size = 
>> pci_resource_len(adev->pdev, 2);
>>         if (adev->enable_mes) {
>> -        adev->doorbell.num_doorbells =
>> +        adev->mman.num_kernel_doorbells =
>>               adev->doorbell.doorbell_aper_size / sizeof(u32);
>>       } else {
>> -        adev->doorbell.num_doorbells =
>> +        adev->mman.num_kernel_doorbells =
>>               min_t(u32, adev->doorbell.doorbell_aper_size / 
>> sizeof(u32),
>>                     adev->doorbell_index.max_assignment+1);
>> -        if (adev->doorbell.num_doorbells == 0)
>> +        if (adev->mman.num_kernel_doorbells == 0)
>>               return -EINVAL;
>>             /* For Vega, reserve and map two pages on doorbell BAR 
>> since SDMA
>> @@ -1068,15 +1068,10 @@ static int amdgpu_device_doorbell_init(struct 
>> amdgpu_device *adev)
>>            * the max num_doorbells should + 1 page (0x400 in dword)
>>            */
>>           if (adev->asic_type >= CHIP_VEGA10)
>> -            adev->doorbell.num_doorbells += 0x400;
>> +            adev->mman.num_kernel_doorbells += 0x400;
>>       }
>>   -    adev->mman.doorbell_aper_base_kaddr = 
>> ioremap(adev->doorbell.doorbell_aper_base,
>> -                              adev->doorbell.num_doorbells *
>> -                              sizeof(u32));
>> -    if (adev->mman.doorbell_aper_base_kaddr == NULL)
>> -        return -ENOMEM;
>> -
>> +    adev->mman.doorbell_kernel_bo_size = 
>> adev->mman.num_kernel_doorbells * sizeof(u32);
>
> I would just keep the kernel_bo_size around and make the 
> num_kernel_doorbells a local variable.
>
Noted,

- Shashank

> Christian.
>
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> index 526b6b4a86dd..7bdff4f926ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>> @@ -28,7 +28,6 @@ struct amdgpu_doorbell {
>>       /* doorbell mmio */
>>       resource_size_t        doorbell_aper_base;
>>       resource_size_t        doorbell_aper_size;
>> -    u32            num_doorbells;    /* Number of doorbells actually 
>> reserved for amdgpu. */
>>   };
>>     /* Reserved doorbells for amdgpu (including multimedia).
>
