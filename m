Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3803EC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 16:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59DD10F7AB;
	Wed, 24 Jan 2024 16:39:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CB610F42F
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 16:39:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7C9lqRt29jQ8cyUi6vvew/iDey/zr5q3aN1S2nKgsxwxcwFk2DdPT3jaod/27I+a3k6w+MqXuyS4+7ASflHE0w/6B6/Ip8yXGu9viCTjMg6vKlMHyhbClxDpLgo8qhebdn8RDuhDrED0lllJvfWN9vmWD3mL/4oqOFkrbQX0hXRQnbo8KMD9jJ2Ck1DBLFmPmnRC3vV4MPwpAq8P0KX2M6Z+zUrxEL4zYc/gG8pE+P7l9jCsh/HZfyXxRdnLyI+d1vMIwXu29hEoIF0XhWQnRMBFxEd/7+mN3BVC28NQqZKCjIDuw6hckN7UYoq6l3vNVdM1qcv3janM2L4wQM50w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NKVLLJ8+qpVamfNZ2kinmkjrnMK0E3Mjj6b3aBxrUA=;
 b=EtKXzyPj4QCJz+sS5+BattROc1X/2V3F0LgHvvvHQpiiHQY5w0itUaw0/OsnhwWJU491n8F2X/3wyRfC9qR3Rjmwrgw9Sp8NCMPEMBW2qnQBsgBAam5oU4RzEDCZsjCWo9PmsHPP0l9GPgNOWyH7irxp6maLF4/wJ+Ea8QPzMDZqLhyE+IiHk5zzVpeKD0Tl17bw/2CZt02v1uQPK7LUkB3LBr0YoZErxQDnAU3BfFc8/xQ2ZcbXsPw5T0e8g0aBQrZD0VOx9NIzcelwyWzO5TWAve+0FRF4qxh0AlDFc2+lO1fRFExELcbguGJL5Pob5Ff8E81RiVWPfHvTaCjcFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NKVLLJ8+qpVamfNZ2kinmkjrnMK0E3Mjj6b3aBxrUA=;
 b=nnGevaF6PlzndOnkEj1hAEq1MXSizeTi2fGi5V1Q5FBW6mDFlXYU3vPxL3hrCMn6litwAwtI1QMr9rlvnPJppVXeh40S47k1hJhgDtWyAVisyFusY+8JXVHSGhIcv1mWYA4FrVJRLY+/tFnA9sIfRUZXCovBY2tlbdaxdOJgWyc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB7617.namprd12.prod.outlook.com (2603:10b6:610:140::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 16:38:56 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 16:38:56 +0000
Message-ID: <8115f9fe-1290-4f7d-ac38-ad69e3f71292@amd.com>
Date: Wed, 24 Jan 2024 11:38:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: change vm->task_info handling
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240118192104.147-1-shashank.sharma@amd.com>
 <83155aae-3bb2-48ed-bcfc-48bd02bbcec6@amd.com>
 <c77d4ca5-413a-0d18-e1c6-20cc6addc6e1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <c77d4ca5-413a-0d18-e1c6-20cc6addc6e1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0311.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 406dbf63-f91b-4fde-ce75-08dc1cfaf54f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pvyGDSo0vyPCsEjXfWo7z3dOCMsCx8hW63Iz/uhDZL6DQBLaZ+ZazShyiM+DEhldMgcndPBQwj5y3J1MEND9fxVVIsX+Q4GRIWW68yHbFI4mZ1Eo4LyPJ04NRtFxLQsd9p9pgRQiQnt4KtT+BCpk0UL+lC4byBcs+0lLu4kt2LpFDNhOlKXltLv1sNYV2OOSj579T7yWr70CDYRl7T4Cm6QAO4ZwXmLT9qvGNNC8wd1NgSE71N3cdkENtcwXjABGlW0HBGRELkjwu1spXDeRW9nnpOwY8TweRpQRmDWrqWjDaO2MfqmWW7RbIZuhRJWnLxAxFTCfMhYLH1ViVDS430plHEs1GuWxj8Je6tAGKT0ISEc8EMzpFCfqbwYceozZ/AboQigg7vaj07a7AkYTjQ+H81oTarwI6tS0VZWmp1vcfRe8rBHPM5NI6RI7CilF9TpIO5VXmjHkrl3R70efmbbPV9KLOcbLAqxS7buP5IC3kxtR9I6fSugAUOhKo5Rc+K2vKsl/tg+1O3JOiRY9T93r9VXNIEPo1eHE4hiSO7+6UMcJVvfQx0JS+G2KSpL4aEYfRNop5KAlh3QvHTL2qxaQNdL//lJU9P80d4vpYub8ggqO12Bc5rQP+kzYGk3fCvSauhhERJYCeIIoEJREiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(4326008)(44832011)(2906002)(83380400001)(8676002)(8936002)(31696002)(38100700002)(86362001)(36756003)(41300700001)(30864003)(5660300002)(6512007)(316002)(53546011)(6506007)(66476007)(54906003)(66556008)(66946007)(478600001)(2616005)(31686004)(966005)(6666004)(6486002)(26005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mll2YlFzbWoxTUJ5TGRMRVBoeDB1ZGNUaWtPZ0lQVTl3cldNTW04ZTFXVEth?=
 =?utf-8?B?QVYrMEVIWXhPQzA5R20rb0IrK1MvenVOb2tleUdSWGp5NElCelo0R2I5ak9s?=
 =?utf-8?B?WkFtbksvSTBXS3c2c0RsaTJic3RtUnp3REs4QU8yVmFDaG5FYjhwVmh2YnJq?=
 =?utf-8?B?NWpJenhNa29qVUtEUjR5TWlpSFhrRHJ4d1VMNGlwNlZoUHVLbkx2bVgvOVBn?=
 =?utf-8?B?dDB4WGppckt1QlhtcjVyL0hmNHVmMEVPNTdaVnF2cWJrSm5jelBiU1ZuekR2?=
 =?utf-8?B?a0M0WjB0ZmpYOGp0dURGQ3RzWHl4LzVtZkorRVNjWXFqQklNUng0TFVWTEg3?=
 =?utf-8?B?TVRKeVlaT1pwSFNVYmRZeTZGQ1dZc2huODhTU3A1N0lsQ2xlNUNxMEFhS1dE?=
 =?utf-8?B?Tkd4MHdrejJKU1U1VHM2VXBRU1FPaVJ3OHZMMTNQS2FPZnJvbWh6YXZYNldM?=
 =?utf-8?B?WnVlNnd0UmdCZWdSM252RU5nM2xVZTZTNWR6MVhKb0kxYWpjVzl1VDNDblZW?=
 =?utf-8?B?cWQ5eW9WQ0pyNkNwelZVTHhFazYrQVZWc1hpdURnTnhjaWJ4RGU1VVlKM2NR?=
 =?utf-8?B?cVdaM2VOcXdrR0x1ZWdJQ3pDRzczZENQV3dRZXV5akpWdkpBRklCY2ZvQzhs?=
 =?utf-8?B?Y09xNkdhd2lBRXpHeEdLSXpzZ1IwNng0RzhQNWU5N1NYVStSVVZnZERTR2FE?=
 =?utf-8?B?TUlzcThCRmtrMDBnazVsUG9TWkJ6djZ6L05Cbkw1aDlRNFRMWUN3VCtiV2tk?=
 =?utf-8?B?UzRreklxLzA1V05vTURoTjA0Z0R0ZWh0R2E2ajg5NXZkekZZcjM4V3VLdlJz?=
 =?utf-8?B?QUN0eHA3YVRBc2Nmd21TbEphd1BHR2ZyTmpOWHNoSWVSNHN6MTdFd1VQaUVZ?=
 =?utf-8?B?bGNjUWVqUXkxK3RuRkQyMTFhdUFKL1duSEdPT0JSWVU3emRpSzUrdURVUG5z?=
 =?utf-8?B?bTFVVFUzTUZpSXBWYkJySkwwU2JjWmwySWo4dnZEVi9ZSmFuejBZaXZiUWRh?=
 =?utf-8?B?bEMrM2psZlpWZDdpeVNBSVl0NSs1V0YyY29oOXpSR1dRS2NSTVkxM0wxTExn?=
 =?utf-8?B?cWY1MWJTdzZ5YllwbFZ2M1Q1SVE4Nyt4NnVXUm1pSzgxTTZiQm1PUmt4clJl?=
 =?utf-8?B?YWJsNHJ0Q3U1YUY1RXg3eGZlOWtaV2JpTEFlaGoySWJQNHRMWUpWWlpsTytC?=
 =?utf-8?B?RnVhQ08xNGtxQU1WWnN2Wkc2UUZRUWRWakZwTGlGWXZ0Z0pSZzIyQWZqaWto?=
 =?utf-8?B?L0R2TW9CUVJ1eThEaWlHdEcrVmRuczRPME9GU3RmMEg0RllMRGRjVFg3TWgw?=
 =?utf-8?B?dVRiWnZQM3JyUExjdGZ3VnJpbTFnV0FMeW9aVVY5UDRxWThYODV0d3RBNDFL?=
 =?utf-8?B?Qll0aEJnTzhKcVFkWmtsMENVcUcyRm5VTXhWVFhYU1lNdlpZVFJUeFZ2QTh0?=
 =?utf-8?B?VUo2THdYbDZJWmxxNXMra2I4T0c0OGxtKy9Cek50WWYyY2NkQXRMLy8xOW5E?=
 =?utf-8?B?Rm11QllPT1k2TTBxaFBjcEpsdFFHc2hlc1ZRNEVYVWw1R1ZUbGpqL3JqUTcw?=
 =?utf-8?B?MzRzVVZoeWFPd2xaQk5TejQraVU3NDdHSHhqekQxcnorS1BtbG1lRDFNUllW?=
 =?utf-8?B?ZmdCZUZDVFZuTG0xUy94NlQyS3lZSURSRzBYcGNleWJ6QW1KaHlVdzdMMzVy?=
 =?utf-8?B?REwyTFB3QjZyY2trS3d4SHVhZFl6bjdoODl2VVRGbHVhbHlqZ0tDNEk2d3Ra?=
 =?utf-8?B?eEROdjlWd25rM2JCa3FVcUZvcERMRUQvTWlscEU2UGFVempsZU1yb1AyY0N0?=
 =?utf-8?B?T3pMNm1wTkQxcEoyMC9QSkQrNTZJTEdiNnBjdEtncCtqdXUvQmxjWHdzMzFN?=
 =?utf-8?B?UUF2T2JGZk5WNVpyNFJTRDAwc2ZVbXMxUXNRc2t3bEZrc1kzZjloZmRRdGM3?=
 =?utf-8?B?SFhRTGhnalhOOWJEdmJ5ZjBtVGhtREFMRHpzTk1WYzRNcUxaRCtUeGNPZEgy?=
 =?utf-8?B?dVo1Y0ppNlBCMjB5T2xNUlJXMFMrWUsxTUVvMU8vbUdEN0F2Wm5FNlVILzV3?=
 =?utf-8?B?My9RdHFiRDBYVndQZloxZFJMRzI3T1crZGZnZ0dwZE5Dam5IUFlLc3Fza2RR?=
 =?utf-8?Q?5bZlNOt2XR0GdhNyTLqECYyMg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 406dbf63-f91b-4fde-ce75-08dc1cfaf54f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 16:38:56.4144 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzzLBWhOlzyYwBHcDM2ab9jiie59FzvcU7WqQw7g27JCTPomC6AhIvFv+Q18PdvnFyL/EXWDcODX/tUg/1Xqpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7617
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-24 9:32, Shashank Sharma wrote:
>
> On 19/01/2024 21:23, Felix Kuehling wrote:
>>
>> On 2024-01-18 14:21, Shashank Sharma wrote:
>>> This patch changes the handling and lifecycle of vm->task_info object.
>>> The major changes are:
>>> - vm->task_info is a dynamically allocated ptr now, and its uasge is
>>>    reference counted.
>>> - introducing two new helper funcs for task_info lifecycle management
>>>      - amdgpu_vm_get_task_info: reference counts up task_info before
>>>        returning this info
>>>      - amdgpu_vm_put_task_info: reference counts down task_info
>>> - last put to task_info() frees task_info from the vm.
>>>
>>> This patch also does logistical changes required for existing usage
>>> of vm->task_info.
>>>
>>> V2: Do not block all the prints when task_info not found (Felix)
>>>
>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>
>> Nit-picks inline.

[snip]

>>> +/**
>>> + * amdgpu_vm_put_task_info_pasid - reference down the vm task_info ptr
>>> + * frees the vm task_info ptr at the last put
>>> + *
>>> + * @adev: drm device pointer
>>> + * @task_info: task_info struct under discussion.
>>> + * @pasid: pasid of the VM which contains task_info
>>> + */
>>> +void amdgpu_vm_put_task_info_pasid(struct amdgpu_device *adev,
>>> +                   struct amdgpu_task_info *task_info,
>>> +                   u32 pasid)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
>>> +
>>> +    /* Clean up if object was removed in the last put */
>>> +    if (ret == 1) {
>>> +        struct amdgpu_vm *vm;
>>> +
>>> +        vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
>>> +        if (!vm) {
>>> +            WARN(1, "Invalid PASID %u to put task info\n", pasid);
>>> +            return;
>>> +        }
>>> +
>>> +        vm->task_info = NULL;
>>
>> This doesn't make sense. If there is a VM pointing to the task_info, 
>> then the ref count should not go to 0. Therefore this whole "look up 
>> the VM from PASID and clear vm->task_info" seams bogus.
>
> Actually, (ret == 1) above indicates that cleanup function has been 
> called and task_info has been freed, and the vm->task_info is a 
> dangling ptr.
>
> The current design is
>
> - first open per process/fd creates vm->task_info
>
> - last close per process/fd frees vm->task_info
>
>>
>> I'd expect the last put_task_info call to come from amdgpu_vm_fini. 
>> At that point setting task_info to NULL is probably unnecessary. But 
>> if we wanted that, we could set it to NULL in the caller.
>>
> Even this can be done, I can call the first get_vm_info() from vm_init 
> and last put from vm_fini.

Well, actually it doesn't matter where the last put comes from. The main 
point is, that vm->task_info is a counted reference. As long as that 
reference exists, the refcount should not become 0. If it does, that's a 
bug somewhere. The vm->task_info reference is only dropped in 
amdgpu_vm_fini, after which the whole vm structure is freed. So there 
should never be a need to set vm->task_info to NULL in 
amdgpu_vm_put_task_info_*.

[snip]
>>> +static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
>>> +{
>>> +    vm->task_info = kzalloc(sizeof(struct amdgpu_task_info), 
>>> GFP_KERNEL);
>>> +    if (!vm->task_info) {
>>> +        DRM_ERROR("OOM while creating task_info space\n");
>>
>> Printing OOM error messages is usually redundant. The allocators are 
>> already very noisy when OOM happens. I think checkpatch.pl also warns 
>> about that. Maybe it doesn't catch DRM_ERROR but only printk and 
>> friends.
>>
> Agree, I will make this debug instead of error.

Even a debug message is not needed. See https://lkml.org/lkml/2014/6/10/382.

[snip]

>>   @@ -157,18 +157,26 @@ static int gmc_v10_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>>       if (!printk_ratelimit())
>>>           return 0;
>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +    if (task_info) {
>>> +        dev_err(adev->dev,
>>> +            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>> for process %s pid %d thread %s pid %d)\n",
>>> +            entry->vmid_src ? "mmhub" : "gfxhub",
>>> +            entry->src_id, entry->ring_id, entry->vmid,
>>> +            entry->pasid, task_info->process_name, task_info->tgid,
>>> +            task_info->task_name, task_info->pid);
>>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>>> +    } else {
>>> +        dev_err(adev->dev,
>>> +            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>> no process info)\n",
>>> +            entry->vmid_src ? "mmhub" : "gfxhub",
>>> +            entry->src_id, entry->ring_id, entry->vmid,
>>> +            entry->pasid);
>>
>> Can we avoid the duplication here? It's too easy for them to get out 
>> of sync. I think it's OK to change the message format so that the 
>> process into is printed on a separate line. E.g.:
>>
> That's exactly I thought, but then I was afraid of breaking any 
> existing scripts grepping for this exact text. I guess I can do this 
> change and see if anyone complaints :).

I don't think there are any ABI guarantees for log messages.

Regards,
   Felix


>
> - Shashank
>
>> dev_err(adev->dev,
>> -        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>> process %s pid %d thread %s pid %d)\n",
>> +        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>          entry->vmid_src ? "mmhub" : "gfxhub",
>>          entry->src_id, entry->ring_id, entry->vmid,
>> -        entry->pasid, task_info.process_name, task_info.tgid,
>> -        task_info.task_name, task_info.pid);
>> +         entry->pasid);
>> +    if (task_info) {
>> +        dev_err(adev->dev, "  in process %s pid %d thread %s pid %d\n",
>> +            task_info.process_name, task_info.tgid,
>> +            task_info.task_name, task_info.pid);
>> +    }
>>
>>
>>> +    }
>>>   -    dev_err(adev->dev,
>>> -        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>>> process %s pid %d thread %s pid %d)\n",
>>> -        entry->vmid_src ? "mmhub" : "gfxhub",
>>> -        entry->src_id, entry->ring_id, entry->vmid,
>>> -        entry->pasid, task_info.process_name, task_info.tgid,
>>> -        task_info.task_name, task_info.pid);
>>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>> from client 0x%x (%s)\n",
>>> -        addr, entry->client_id,
>>> -        soc15_ih_clientid_name[entry->client_id]);
>>> +            addr, entry->client_id,
>>> +            soc15_ih_clientid_name[entry->client_id]);
>>>         if (!amdgpu_sriov_vf(adev))
>>> hub->vmhub_funcs->print_l2_protection_fault_status(adev,
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index 23d7b548d13f..3dda6c310729 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -126,19 +126,28 @@ static int gmc_v11_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       }
>>>         if (printk_ratelimit()) {
>>> -        struct amdgpu_task_info task_info;
>>> -
>>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> +        struct amdgpu_task_info *task_info;
>>> +
>>> +        task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +        if (task_info) {
>>> +            dev_err(adev->dev,
>>> +                "[%s] page fault (src_id:%u ring:%u vmid:%u 
>>> pasid:%u, for process %s pid %d thread %s pid %d)\n",
>>> +                entry->vmid_src ? "mmhub" : "gfxhub",
>>> +                entry->src_id, entry->ring_id, entry->vmid,
>>> +                entry->pasid, task_info->process_name, 
>>> task_info->tgid,
>>> +                task_info->task_name, task_info->pid);
>>> +            amdgpu_vm_put_task_info_pasid(adev, task_info, 
>>> entry->pasid);
>>> +        } else {
>>> +            dev_err(adev->dev,
>>> +                "[%s] page fault (src_id:%u ring:%u vmid:%u 
>>> pasid:%u, no process info)\n",
>>> +                entry->vmid_src ? "mmhub" : "gfxhub",
>>> +                entry->src_id, entry->ring_id, entry->vmid,
>>> +                entry->pasid);
>>> +        }
>>
>> Same as above.
>>
>>
>>>   -        dev_err(adev->dev,
>>> -            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>> for process %s pid %d thread %s pid %d)\n",
>>> -            entry->vmid_src ? "mmhub" : "gfxhub",
>>> -            entry->src_id, entry->ring_id, entry->vmid,
>>> -            entry->pasid, task_info.process_name, task_info.tgid,
>>> -            task_info.task_name, task_info.pid);
>>>           dev_err(adev->dev, "  in page starting at address 
>>> 0x%016llx from client %d\n",
>>> -            addr, entry->client_id);
>>> +                addr, entry->client_id);
>>> +
>>>           if (!amdgpu_sriov_vf(adev))
>>> hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index ff4ae73d27ec..aa3887c3bb35 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>           gmc_v8_0_set_fault_enable_default(adev, false);
>>>         if (printk_ratelimit()) {
>>> -        struct amdgpu_task_info task_info;
>>> -
>>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> +        struct amdgpu_task_info *task_info;
>>> +
>>> +        task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +        if (task_info) {
>>> +            dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>>> process %s pid %d thread %s pid %d\n",
>>> +                entry->src_id, entry->src_data[0], 
>>> task_info->process_name,
>>> +                task_info->tgid, task_info->task_name, 
>>> task_info->pid);
>>> +            amdgpu_vm_put_task_info_pasid(adev, task_info, 
>>> entry->pasid);
>>> +        } else {
>>> +            dev_err(adev->dev, "GPU fault detected: %d 0x%08x (no 
>>> process info)\n",
>>> +                entry->src_id, entry->src_data[0]);
>>> +        }
>> Same as above.
>>
>>
>>>   -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>>> process %s pid %d thread %s pid %d\n",
>>> -            entry->src_id, entry->src_data[0], task_info.process_name,
>>> -            task_info.tgid, task_info.task_name, task_info.pid);
>>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>>> 0x%08X\n",
>>> -            addr);
>>> +                addr);
>>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>>> 0x%08X\n",
>>>               status);
>>> +
>>>           gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>>>                        entry->pasid);
>>>       }
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 2ac5820e9c92..075d633109e3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -549,7 +549,7 @@ static int gmc_v9_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>>       uint32_t status = 0, cid = 0, rw = 0;
>>> -    struct amdgpu_task_info task_info;
>>> +    struct amdgpu_task_info *task_info;
>>>       struct amdgpu_vmhub *hub;
>>>       const char *mmhub_cid;
>>>       const char *hub_name;
>>> @@ -626,15 +626,23 @@ static int gmc_v9_0_process_interrupt(struct 
>>> amdgpu_device *adev,
>>>       if (!printk_ratelimit())
>>>           return 0;
>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +    if (task_info) {
>>> +        dev_err(adev->dev,
>>> +            "[%s] %s page fault (src_id:%u ring:%u vmid:%u 
>>> pasid:%u, for process %s pid %d thread %s pid %d)\n",
>>> +            hub_name, retry_fault ? "retry" : "no-retry",
>>> +            entry->src_id, entry->ring_id, entry->vmid,
>>> +            entry->pasid, task_info->process_name, task_info->tgid,
>>> +            task_info->task_name, task_info->pid);
>>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>>> +    } else {
>>> +        dev_err(adev->dev,
>>> +            "[%s] %s page fault (src_id:%u ring:%u vmid:%u 
>>> pasid:%u, no process info)\n",
>>> +            hub_name, retry_fault ? "retry" : "no-retry",
>>> +            entry->src_id, entry->ring_id, entry->vmid,
>>> +            entry->pasid);
>>> +    }
>> Same as above.
>>
>>
>>>   -    dev_err(adev->dev,
>>> -        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>>> for process %s pid %d thread %s pid %d)\n",
>>> -        hub_name, retry_fault ? "retry" : "no-retry",
>>> -        entry->src_id, entry->ring_id, entry->vmid,
>>> -        entry->pasid, task_info.process_name, task_info.tgid,
>>> -        task_info.task_name, task_info.pid);
>>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>>> from IH client 0x%x (%s)\n",
>>>           addr, entry->client_id,
>>>           soc15_ih_clientid_name[entry->client_id]);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> index 3d68dd5523c6..515d1a1ff141 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>> @@ -2104,7 +2104,7 @@ static int sdma_v4_0_print_iv_entry(struct 
>>> amdgpu_device *adev,
>>>                             struct amdgpu_iv_entry *entry)
>>>   {
>>>       int instance;
>>> -    struct amdgpu_task_info task_info;
>>> +    struct amdgpu_task_info *task_info;
>>>       u64 addr;
>>>         instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>>> @@ -2116,15 +2116,23 @@ static int sdma_v4_0_print_iv_entry(struct 
>>> amdgpu_device *adev,
>>>       addr = (u64)entry->src_data[0] << 12;
>>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +    if (task_info) {
>>> +        dev_dbg_ratelimited(adev->dev,
>>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>> +            "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>> +            instance, addr, entry->src_id, entry->ring_id, 
>>> entry->vmid,
>>> +            entry->pasid, task_info->process_name, task_info->tgid,
>>> +            task_info->task_name, task_info->pid);
>>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>>> +    } else {
>>> +        dev_dbg_ratelimited(adev->dev,
>>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>> +            "pasid:%u, no process info\n",
>>> +            instance, addr, entry->src_id, entry->ring_id, 
>>> entry->vmid,
>>> +            entry->pasid);
>>> +    }
>> Same as above.
>>
>>
>>>   -    dev_dbg_ratelimited(adev->dev,
>>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>> -           instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>>> -           entry->pasid, task_info.process_name, task_info.tgid,
>>> -           task_info.task_name, task_info.pid);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> index 0f24af6f2810..d7e23bd90f7f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>>> @@ -1642,7 +1642,7 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>>> amdgpu_device *adev,
>>>                             struct amdgpu_iv_entry *entry)
>>>   {
>>>       int instance;
>>> -    struct amdgpu_task_info task_info;
>>> +    struct amdgpu_task_info *task_info;
>>>       u64 addr;
>>>         instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>>> @@ -1654,15 +1654,23 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>>> amdgpu_device *adev,
>>>       addr = (u64)entry->src_data[0] << 12;
>>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>>> +    if (task_info) {
>>> +        dev_dbg_ratelimited(adev->dev,
>>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>> +            "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>> +            instance, addr, entry->src_id, entry->ring_id, 
>>> entry->vmid,
>>> +            entry->pasid, task_info->process_name, task_info->tgid,
>>> +            task_info->task_name, task_info->pid);
>>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>>> +    } else {
>>> +        dev_dbg_ratelimited(adev->dev,
>>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>> +            "pasid:%u (no process info)\n",
>>> +            instance, addr, entry->src_id, entry->ring_id, 
>>> entry->vmid,
>>> +            entry->pasid);
>>> +    }
>> Same as above.
>>
>> Regards,
>>   Felix
>>
>>
>>>   -    dev_dbg_ratelimited(adev->dev,
>>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>>> -           instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>>> -           entry->pasid, task_info.process_name, task_info.tgid,
>>> -           task_info.task_name, task_info.pid);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c 
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> index d9953c2b2661..0dfe4b3bd18a 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>>> @@ -238,16 +238,16 @@ void 
>>> kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>>     void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t 
>>> pasid)
>>>   {
>>> -    struct amdgpu_task_info task_info;
>>> -
>>> -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>>> -    amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
>>> -    /* Report VM faults from user applications, not retry from 
>>> kernel */
>>> -    if (!task_info.pid)
>>> -        return;
>>> -
>>> -    kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>>> -              task_info.pid, task_info.task_name);
>>> +    struct amdgpu_task_info *task_info;
>>> +
>>> +    task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
>>> +    if (task_info) {
>>> +        /* Report VM faults from user applications, not retry from 
>>> kernel */
>>> +        if (task_info->pid)
>>> +            kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, 
>>> "%x:%s\n",
>>> +                     task_info->pid, task_info->task_name);
>>> +        amdgpu_vm_put_task_info_pasid(dev->adev, task_info, pasid);
>>> +    }
>>>   }
>>>     void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t 
>>> pid,
