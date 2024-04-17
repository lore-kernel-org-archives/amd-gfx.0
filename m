Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD26C4345F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Apr 2024 07:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3D211325D;
	Wed, 17 Apr 2024 07:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NEzOr/j1";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A32D211325A
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Apr 2024 07:45:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S21JK0PFnYCj744qgWQVHqe7PIfcu6j1DcIpomg7tOmYTF5pN2r5gDGMuh0Xd9PDl7w/28gL5f9avB6mx9XlZllsLskApErzhxrYrsf1l7jPR7xUMZntg/oBfe/ProF61GIfeFG5O8JaHGm+6e0GESAF43/KrHYyy4sV0RLdM5sxRO00izTI09/dSFea7/NUT5k/VRwNDTXNfLHK1l7+4CY6yxwJO4QmqhyDL6jpfAjpquBw2hqUNvpUSJDWLLYTgP7p2nBrh8Mz6112EFlTlir32fBo2HqZDYGlg8jOyfW7p0MaybB4rxaQ5K/+u/h7lKsHy422q07eeEMXcaeZMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HYaEVvURHi0U6eg35ZRu/MH7AIj9UDYznW+ZDZHP50=;
 b=dMqDij/JldpEeGg3LHwUlTWaaIsabH25pzkksqtMjO1jRVm81SUKO4huNW7x4RCcZACCVb4uEUx4ihRIvEvqAqAKuv8lS+AQOKgFXV+m8MG2OtcQ3kF1LddwiGtf3e8IJHbyUt/LqqjMnw2bpAIbQGEh0IYryLRwCd3U6AN05CmIfyesc/kdWcXE/3/X/RHmDtUzoaILKHeU457YNAH907miWbLrK5we+VdDfRs8w9Lxl8H3mW3gVUkgq0Xs9MdvxTsKDxBvke2hgAIWXW69D6qdBWNLff1Jxo8rfu/uHJgMwIllH/05pn3AJkOnmY7kHBpDdU21vfv+DeRGg8dd8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HYaEVvURHi0U6eg35ZRu/MH7AIj9UDYznW+ZDZHP50=;
 b=NEzOr/j1PI6GInwrz/0S/m77UN0b1Xhl0+VaxIiL3ao5EdSWoMmHabBhiPe7ELdEkhdvzPujRwcJ46MSkefUTejKFbJAGtBgW0xOEqRML0mnjGNvNpPcuFdMiam8dUtho5UpVBHic+n6uM18koPKXaV8S5mIZl0r5oQni9/Lqag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5596.namprd12.prod.outlook.com (2603:10b6:510:136::13)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 07:45:04 +0000
Received: from PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033]) by PH7PR12MB5596.namprd12.prod.outlook.com
 ([fe80::6974:3875:ed0:7033%3]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 07:45:04 +0000
Message-ID: <be82827f-93e8-4053-a301-7e6bc8fed5c5@amd.com>
Date: Wed, 17 Apr 2024 13:14:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Skip the coredump collection on reset
 during driver reload
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
To: Ahmad Rehman <Ahmad.Rehman@amd.com>, amd-gfx@lists.freedesktop.org
Cc: lijo.lazar@amd.com
References: <20240417041336.65366-1-Ahmad.Rehman@amd.com>
 <26c0e7b8-e0a6-495f-877d-2fe522b2249b@amd.com>
In-Reply-To: <26c0e7b8-e0a6-495f-877d-2fe522b2249b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::12) To PH7PR12MB5596.namprd12.prod.outlook.com
 (2603:10b6:510:136::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5596:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ab073a-1433-47ac-afda-08dc5eb24b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Asep8UWXnQF1ThI+zkTnoIMjjHwGvOuNoK9HOKzqI9TfOGFhiJf+4Xt8azirzPP8obtczYZAEkmp3yJgbXRlVP7yb0kErR9AtReW1Bq7Rr4B8x5GRwn1dVANWZ60kdo1CtDqJaVN8PMc2xkJCnJVa/xUnpqvBY6xFpneFBXWSsrfd9f1aXMqPhC28uUvuFv4UHmDCB46ECWIdwGYEsJD9rvYX+KWERP6SGkwl8yS+BXrjORNwN/SnTRqEuO4VO+9SjZLG3537+SJr1VBSrF4CtA2g6U4h3M7KNA3CHV6SRF57IdqjyVlo7Xp8yDtALUxyVw76M8HZ5neXCcJQ7FEax+cmPdfNHugXsM1mhWwwjCnCn7ueWeF37SrdPUFERiHSUPZuwOjr9VQ95yFh3QJtEeOkPapEAteXOXY9dt0DGtGDxczZ2Eet86CIEugkwy3HxdngWpfE9ktJqGTkgJaaY2aYeEsRyLd1f4w82V58XPBp7tVzbZq+haawJrnbek9vvTgZoHFu/Zn61bCiru+I1QUpxYYtldo5HCj22d+NpfGJ6rQKnu3QPcZCTTe1qXd1GWbzvIUxxEAPEfwtciazYFTTaiU6ObQQpn4BD7mSxoH3i1wzBz0xniPH+uPj0On0I3dwR61r5OTVceCyyX70FxQ+SdjS8h5O5NDrFiT+V0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5596.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3FxR3Z2by9VRWpSMGxHcG80L3Q2ZnVwTitqeFk2d20zdkU1dFBpejRTdXND?=
 =?utf-8?B?dFViaHpZV2JwVmZ1QURvWGd0MVBGVlVTb0ZvQW5BbDVSMXduWHZtbnYzaSsy?=
 =?utf-8?B?cnlyVzVjRWp6d3JzUksrNDR0TDJEcG9KSmszelUzQi82WkxKNldpOCtUc1U5?=
 =?utf-8?B?ZXI1Q2twNWozU3hQVytQS1QvQmFLL0kvcGVMMWFVWDVITnp3M0pwWUNNbHJl?=
 =?utf-8?B?Nmd0TE5ZMGFHWmE3a2lqblJFa01yaDBLVkYzLzNNRkxJamlwMHZBQzNBYnpM?=
 =?utf-8?B?bk9sbC9CMzdXSXo5V1A0ODZST1RITXhsU1MwYUxiQU5GLzVDTVphc1hSRWVi?=
 =?utf-8?B?dVozekhTdUxqU3FVcFVEb01DZUkvV3VIM1pUdFgzWG83VDQ3d3VUMGoxY2dw?=
 =?utf-8?B?RFFkdHhqSStkVkd3QmExaW95OUk5VVl6U1g5ekJxSmVUcmVxbzQ1b1B6ZVl5?=
 =?utf-8?B?eVYyTDJkakQyTUI0UmU0TzJEMFpzUDVIMXFRM0VzUEJNVThkNkZ3aytvc0pB?=
 =?utf-8?B?UmpPSmNtTFBVdC9JYm1pL1d4NWttWkNySWl1NEplb2RaSUFhS2Ixb0JFd3NJ?=
 =?utf-8?B?OGVuZDFkUDlCMlpPZkVFN3NxNldha3V6VER3dlE2M1Z0UE5YTGsxbzUwbXVz?=
 =?utf-8?B?Yy9kSTdoY3BqUjJxZTgzS0hEWCtiZE9GbCtyRkZnRVdJckFxRkthN3ppV0xw?=
 =?utf-8?B?RVJRMnY2S0kzbWo1cDVCL2VnZWFyRHE3MndXSFZ1aUF4ZW5RUEJUQlJxSXhL?=
 =?utf-8?B?QUE4SktEQmJtT1pYZ0JpVVZZV0k4ZEVTRHAra3ptYk4zdkZ4RFo2VGFmYktI?=
 =?utf-8?B?enZtNkdJOWE0ZjBmMjRYTE5QOTBjYVVVOS9KKyt6eUhLRlhZT3ZiTWRYeEZ2?=
 =?utf-8?B?UW1NeXBhY0t1RXNXRkRGNVZBSW83Wll3Y1dFTk9qTXBWR1laWm0zU09neGFN?=
 =?utf-8?B?VUV0bkdhQXhxdDZnMDVwck9Ba1hNaW50dHBEM2hvVGVuQjVnR2hObDM4c2VF?=
 =?utf-8?B?YkhlQ1p2V0RWVXdWN2o3WG1QSnQ0bzBXQ0liQkcydTAzZUVHL0VvRHlkQ3N6?=
 =?utf-8?B?YkZjUTViMTlkckl2Wk5oM21VWFphTFAzVzdwRjdvTE16SEd0WWVKckFQczdJ?=
 =?utf-8?B?eVJKZU95V2VRUzdFRWtoRDJVbU5uQ0thakNmTWJjNEV5MWxxTDhMWllXczIx?=
 =?utf-8?B?bU8zejhtOVJoNkxiNkk3bmc2NUsvMmplN004Sm1EVUdUcU9SMEFSYll4R1JN?=
 =?utf-8?B?VTMvaWFnL3YwMEkwN2FGdFZKN2ZlSjJVMlJKNG42M0x0YmQ4Vk1uZ0xZbmNt?=
 =?utf-8?B?UUpHYmM3Z0NEZDdMZkV6ZWl6dXpqSHpWOE83MUp1ZUxhWUU3RW5jWEV0SEZ4?=
 =?utf-8?B?aE5uTmV6WXBBQzkyWklnSWZwZzZkV0ZzQVRXNnhpRmJMZndyS3hlbW9wZm1o?=
 =?utf-8?B?MjFlUWk0Y3dIeTUzMVVEdVZmNGF5K2R1M21WenBOUE9uUmFNR1hBODRRaXIv?=
 =?utf-8?B?WFpNM29pZnF6YzFqRERxMlFYRkNHY1RqSjRGT1JyNFFaV05zWUZnZzJ5V2k5?=
 =?utf-8?B?U1M2eUFMM25OMisxQ081ZWZpd2cxckduVUFqU0RieUtIckthOXdTMlBtNStJ?=
 =?utf-8?B?d2ordEIwTHJ6eksrMXRkb2FHeVI4SDM4K3RGR1p2TmdleThjYXFVVjFDdUNr?=
 =?utf-8?B?YUZYMExJaGduY2ttU2tOZFEvYWgzVDcvaWhxME1JSEpCYWRZRVd6M3NMaFB1?=
 =?utf-8?B?RU1Gdlg3bzlncDN0ZzhPMnpocXROWGtldEVpSExQUVdoMVRYR0VZVVJMOEhy?=
 =?utf-8?B?TVE0OWJVNngydy9rY0xZUVlXWlpkL1U3YUVzS1pQL2lrT0pYU0tOaDNRMHV4?=
 =?utf-8?B?dUppRGVlVUJqeW4zNk9EUWYySGp5Sm8xZmhQQ0I1SGZEbFR0RDZuNEJKSUc2?=
 =?utf-8?B?c2tGVDdvU0lhWjRGenMxWjBCRFhRZmUwM0xldVFtZWZXM3VjZk9yYjBsYnJS?=
 =?utf-8?B?bHVHc2xIMHdQNytzUnNybzdYK3VHL3hSNW1BamIzSGxkdmRHa0wySkhpcmVQ?=
 =?utf-8?B?elV6UjdrWExKZ2dkanRyblpCckN4Q2VQbUdwdS9OZjhOcXFqSDU2T0NFZjRG?=
 =?utf-8?Q?abI1+e/YExwPoPAHZ3qAPn2Vb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ab073a-1433-47ac-afda-08dc5eb24b49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5596.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 07:45:04.3147 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CpIlNcjfngggwhOkIOkJKn5jVPOaKhdoeDHWLRhNplEAbocaK2Jys6g9oxR3oxd0LdgZsBrt5JIxHmAsJovZnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032
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


On 4/17/2024 1:06 PM, Khatri, Sunil wrote:
> devcoredump is used to debug gpu hangs/resets. So in normal process 
> when there is a hang due to ring timeout or page fault we are doing a 
> hard reset as soft reset fail in those cases. How are we making sure 
> that the devcoredump is triggered in those cases and captured?
>
> Regards
> Sunil Khatri
>
> On 4/17/2024 9:43 AM, Ahmad Rehman wrote:
>> In passthrough environment, the driver triggers the mode-1 reset on
>> reload. The reset causes the core dump collection which is delayed task
>> and prevents driver from unloading until it is completed. Since we do
>> not need to collect data on "reset on reload" case, we can skip core
>> dump collection.
>>
>> v2: Use the same flag to avoid calling amdgpu_reset_reg_dumps as well.
>>
>> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++--
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 1 +
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 1 +
>>   3 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1b2e177bc2d6..c718982cffa8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5357,7 +5357,9 @@ int amdgpu_do_asic_reset(struct list_head 
>> *device_list_handle,
>>       /* Try reset handler method first */
>>       tmp_adev = list_first_entry(device_list_handle, struct 
>> amdgpu_device,
>>                       reset_list);
>> -    amdgpu_reset_reg_dumps(tmp_adev);
>> +
>> +    if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags))
>> +        amdgpu_reset_reg_dumps(tmp_adev);
>>         reset_context->reset_device_list = device_list_handle;
>>       r = amdgpu_reset_perform_reset(tmp_adev, reset_context);
>> @@ -5430,7 +5432,8 @@ int amdgpu_do_asic_reset(struct list_head 
>> *device_list_handle,
>>                     vram_lost = amdgpu_device_check_vram_lost(tmp_adev);
>>   -                amdgpu_coredump(tmp_adev, vram_lost, reset_context);
>> +                if (!test_bit(AMDGPU_SKIP_COREDUMP, 
>> &reset_context->flags))
>> +                    amdgpu_coredump(tmp_adev, vram_lost, 
>> reset_context);
>>                     if (vram_lost) {
>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 6ea893ad9a36..c512f70b8272 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2481,6 +2481,7 @@ static void 
>> amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
>>         /* Use a common context, just need to make sure full reset is 
>> done */
>>       set_bit(AMDGPU_SKIP_HW_RESET, &reset_context.flags);
>> +    set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);
If this is used for guests only can we better have a flag like 
amdgpu_sriov_vf  for setting the skip coredump flag ??

Regards
Sunil khatri

>>       r = amdgpu_do_asic_reset(&device_list, &reset_context);
>>         if (r) {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> index 66125d43cf21..b11d190ece53 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
>> @@ -32,6 +32,7 @@ enum AMDGPU_RESET_FLAGS {
>>         AMDGPU_NEED_FULL_RESET = 0,
>>       AMDGPU_SKIP_HW_RESET = 1,
>> +    AMDGPU_SKIP_COREDUMP = 2,
>>   };
>>     struct amdgpu_reset_context {
