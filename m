Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE11CD3423
	for <amd-gfx@archiver.kernel.org>; Mon,  4 May 2026 09:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 597AF10E065;
	Mon,  4 May 2026 09:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RNZceS+6";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013019.outbound.protection.outlook.com
 [40.107.201.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514BA10E065
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 May 2026 09:01:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V8CwPtu3hUUa0UsGORMlAYmDCNEYv1v8rEuSPCHTMvQiIdnUlwCAabf4PHI8vTERhvxudGp+YpCr9eUFz76P5BtHYtQuC6j2awYhs9XS/3zbKg3fNOxVCQOh8t1LBwfSoNeX4QirXnLPv06UfwcEnbM+vWar7jARDgHHMYKqtbPq4USk1LADkHLiIeCUqZEuF0OUURgZeCoFRCWhn8RA/AW4YZcKnG2lcOdB+c2X/7NyHhkyORQGiaTBl875P9NYSGv6Kkb0X2F+zylWVj35MOpg0bl6XtlxCEL6Vm16PP1A15yWHvvr+hgzxPXRXKfFjqHP3XeaDY3yPsmud+hBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP/XVfTziXdXWn87l+cKgGm4WfWIqmb5juHx26RpLoM=;
 b=kmAmZvHvYA487uYcgVXz3Pg4OP+HAziqpOTdTlUYPQpt5R4GQKFzkdJ6UBX9c6s98scFyY6Z8BBujBr99g9UXyndthF1ZJSfWttCafsJAL0VtQwpMl196Na0qfSMqmCTeLjckZAo4zCcVWBSzBcZlCrCSeqVcRDvLYlQT6Svlrds/4i4fbu8ZVKXKrHq6AOMosNjqR8gi/x38+Y3a20syVtBgcChk/ttGpRrRA+mwqn/ZGdGWBcuRUXRL2Lu/8+blwie+Aivy0IaPYTs/I8xg/bYU7CJCYe44oc3FO/XIstxBjfGpj/qwQcxlsTGZ/pZiUcxIntRlV7JmjCe4ajTQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP/XVfTziXdXWn87l+cKgGm4WfWIqmb5juHx26RpLoM=;
 b=RNZceS+6yU6FCHuEGwAbPUhuN8YpmaAcBjcxoW9JGFdKvPmk/stKb4UnSwGZJqDR35CT+SKXwiS1nebs0F7x5kNyIm66GYomgEouW3QUiVRrggW47Bl+b2xvs75MRN+/KF+/wr26b9JJ000igJ0CH8n/zMbRM9EJVGRrwMvrHFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:01:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 09:01:24 +0000
Message-ID: <dcd83794-5387-4892-991f-4933845048db@amd.com>
Date: Mon, 4 May 2026 11:01:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] drm/amdgpu/userq_fence: NOTIFY MES on SDMA UMQ
 submit
To: Alex Deucher <alexdeucher@gmail.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
References: <20260430161146.2851078-1-Jesse.Zhang@amd.com>
 <20260430161146.2851078-10-Jesse.Zhang@amd.com>
 <CADnq5_N_PwKyX4-gmDc7xWWB3AL0CVYJXzomgOXER0c72-c_oA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_N_PwKyX4-gmDc7xWWB3AL0CVYJXzomgOXER0c72-c_oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a686e6-2f7a-46ed-fe9a-08dea9bbb7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: +NmO8N2fWgq3gF0c8DLnITEA4IKiyUdqI8gsNDO73DI8x4VmYoufIccxIrem8FYEdAE3DpJRabJrq68+ZUZfuOPSuTskHZIKU873Rkpwuyy+TfreddDrJoI4yh0d8c3UP3dq5F6GSTVdpDdIlG7OHkxpTBPjuo1hHDZJst4taNn65ne3CPpx5lUJ1H8bMhEMM5dlWHC/5o8UbnO2b9VA2I1PXzYQ+hD02+9sR1DN6hsaCFSK0QSgFlKCd2iJfK825w1c7pU0yzXGnvDZaZtRl/x/96sIExoZU5/IsySXj/+5814ZemYIccNDTSgWu3FETFfSiUW3PNSsaozcfzrpjAuXItpqnFkB31ucaUb5v2MH4R14kcyLhl9KRjI87ua1FA3RgDtJY7F8T8PLEPtGICZlgb0GDUMbRK05Z8OTFL3j+kIyOluiWjhHRYntlGZSQoD5DCHIJPePfw+Vxx0/rv6G5J8ciAy4aZr+y7b9tGNHuCExhqkZehg1EZOvjNrHc+ruM/gCAGcmYCzHoYMucd7D+mR5Aj+4nT13FKty2LIodCfi0kqwOMWC6FwgV/UFkaTXNNp1CyCQHBXEIas9TvHg08WwoXA9YRqEPJItpDWu8paP8jz44fZv3KCCYQYN5Yj/b+HTRSlzkzkiP5rYMq5zFEm7XZy8+N8+QrLBA6DEHJWQzU+SDQj1c4rmZZpn
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d09qem8zNkR5cHJPQ2o4SzV6T2RCYkpXblJMZGZ6ZjVwSFVmQmdNMVRZNHhl?=
 =?utf-8?B?YmxwelFlSlY4L01OMEF1QzVnc25iVlJ0QmIxb0FUZ1VoTlF1MURzb05TWjRW?=
 =?utf-8?B?TG9aeC8ySE9VM1RqdW1jOE9KRFltR1E4NWlDMllRRlREN25za3NXdDRrbGxB?=
 =?utf-8?B?bDAxd3p0OG9HL2cwM0hpdUlTRDZ3RW1VZGhwZVZnNVdYWjhxQUdsNERINkRP?=
 =?utf-8?B?Tzg5akNUbkN3cDMrQmFOY2YydjVCLzNrb3RuYmcybVBBQmZsNHhkbmQxeUxJ?=
 =?utf-8?B?MHNGRDljbm9xYkp3L0hQSVlINzlOK09KNy9EREh4UHk3V0Mxbnk5QmhXeEN4?=
 =?utf-8?B?RjArM3huNWh5ZUF0d0JNM2pCeVJKWWkxQlRFeWF5bTlGNXZPMmNvV0QzTVJI?=
 =?utf-8?B?VGdVYjZaSG9XV0FGZGEzOFpIVWlrQTdrcHF0MEg2cHVzZmdPZlB3M280SkJW?=
 =?utf-8?B?WlluRmdESmUvMUYrakM0TnJDbmJUblVFL3N4MERFYWozbW5IUmdGekUxS3p1?=
 =?utf-8?B?cXJFVGFuaHN4ejltYVJlWVh4THUvQTNmVXFMLzFhcjZ3RzlZS01SYnk3MTY3?=
 =?utf-8?B?NFZmcjBWN0diYlJjeWlHakxRYzlCSlNIbnU5eUtuTUo0SWZDdUplOGFnUTZu?=
 =?utf-8?B?QmNHNXBUVUM3WExnVjJSMzdDdlk1V1RXKzdqQ0FJdDVabVplSStiLytBSG5C?=
 =?utf-8?B?eWVSZUtTT21tdzZNWUkwN0pOZHdMRjBPRm52bTY1U1ZDVmRaYk8rTHpxSWhY?=
 =?utf-8?B?c3VvYnFYcmdQMW9Yb25FYm9CUmdsRHdmQVRLWlJubXZLTkEwejlicC8waEFv?=
 =?utf-8?B?SW8xQWMwOTErNXc4bXVJV0ZFOWtJSEhPajQ4cG9FOXRiOTg2ckMxSm1oREhX?=
 =?utf-8?B?ZHltU2QrQ3g1RXUwVGhPQ2p6Y25kK3Y4MmVxdFY1K0F0c0ppd1J2K1J4eHhE?=
 =?utf-8?B?ZktyekFCcHhscEJZQ3JGRUNHdEVWOUJQWmF5YWt6dmpsNHpnUFR1R25OSStX?=
 =?utf-8?B?RWdmYTNKUlpwcnBjL2V1UGNlYkFVQUl5Mm95VjB1L205TThPVVVCY3dZV0lW?=
 =?utf-8?B?alpNOHNGcVNHakNxY3M2ZWgyemVJTVdrTkFqbXBMMU9IRmFWL3Z2Q2VpaHQ4?=
 =?utf-8?B?anlGMTBXSTJ3RFlkb240dkc1VTQ1Z0thU0hza3dyQ29hemg2THQ4RUpqclNF?=
 =?utf-8?B?OXpvZG1jYzh0Sm9TMDRMcHhsRlVaQ054SzdBeXRqNGxXQWxVVWRzdnBiRTRJ?=
 =?utf-8?B?eXd1TG9Xd0JldWRxejFNUDZjeUFEeEtENVVLbmZRNUFmR0YrZnh1cmMycEY5?=
 =?utf-8?B?TE9BNUlHVmNaQTA1VXgwZ0tGVUw4cnR5RkdNNmh3RVQ5bDYzdVZGQmViallV?=
 =?utf-8?B?UmFyRGRIV1RvR3BWQ0VpOTgrWFY2QkcxRENXREd6N24vTTl3QVF5UDZjVGd3?=
 =?utf-8?B?cE1VaTdOMWRCM1BZYm5RY3luYm81VzZlZVNyUis5NVc5S0V2L3NUUWNGRDlp?=
 =?utf-8?B?cHhsTG9DQWJwclk5T0tFSlc0MGdVNjZUek9BOUFwYzIySk02WVlVMGxyWHZY?=
 =?utf-8?B?dHRMeWlLdVBXN0xMaFlyQ3RoWUx5WTRVV1dieGh1Z1Q2UUplbzhDa2xxNTUr?=
 =?utf-8?B?OFAzQnFjN2w4bVRKbUhWeXVnMzVXaDQxQ1VuM1hHM1VNY3hiUGpXeVozS1lk?=
 =?utf-8?B?TzJ6VnFKTVluUnZReUtiSU1Fa2wxZGpjWmVJTHZVVUNBNWt5WjV1VWlqazJF?=
 =?utf-8?B?L09qLzR3ZGhGTXRBeVVFallsNXQ5UkNxZlF3M0JLUUJJOTQxOGZMZVVkcXBi?=
 =?utf-8?B?d2FUdzBlSXhnVkUyS2FtUXptUlg3NlBZNmpQUkREanl4ZU5BSUhrOEFGSU9J?=
 =?utf-8?B?dmlWcEFDakQ4UnJGdVJQNGs0bCtZMksrQkh4QWhxaGoxajdQVU1kVjJ4RElU?=
 =?utf-8?B?ODY5aThwMExFcXROVmZhVDc2K2o5WDhlZ25BQUpKSXBIL2tXTXg2K251UzdS?=
 =?utf-8?B?TWdzTkdjMWgrQWd0bVU3SGV1blByNDVvSkdZR2ZsM1Y5cFlkcThQeC9LbS93?=
 =?utf-8?B?Wi94TXpWQllPVVpCVkhGeDJEU1BaeTdQN2hqaHNhb0k2OHpVbEhIZGk0WEx4?=
 =?utf-8?B?TDl2UGV5ak8ycnpMOVY1cHBod2ExWWQ0V0ZmbjBkVXcyTFpoYmN3dnN5QUU0?=
 =?utf-8?B?d0wzWHJGN0NtWStTRm1oNWNpMDFvcVFCVFBoQ1AyZHU5NjRMeXV3Smo1a0FX?=
 =?utf-8?B?Y0VHRXo2cG1qSEtwN3o3Ty9JNzVwQVVGbVo1Zm5jaU14TW9sTDJxVG9SSmJm?=
 =?utf-8?Q?nzirApl46HwpfMfs6f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a686e6-2f7a-46ed-fe9a-08dea9bbb7f5
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:01:24.7356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJ2+m+w2QhhdnCUb05Pix+ClmB1oRtzJPnIg1MWpbavpptnoTQLFyEonUFLGP8po
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
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

On 5/1/26 15:30, Alex Deucher wrote:
> On Thu, Apr 30, 2026 at 12:29 PM Jesse Zhang <Jesse.Zhang@amd.com> wrote:
>>
>> From: "Jesse.zhang" <Jesse.zhang@amd.com>
>>
>> Pair the userspace aggregated-doorbell ring (added by the
>> AMDGPU_INFO_DOORBELL / AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL ABI in
>> the previous patches) with a kernel-side
>> MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE in amdgpu_userq_signal_ioctl
>> for SDMA UMQs.
>>
>> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> 
> How will this work if the user doesn't use this IOCTL?  protected
> fences are optional.  An application can create a user queue and never
> use a protected fence.  Why don't KFD SDMA queues need this special
> treatment?

Yeah agree that whole approach doesn't work.

What we could do is similar to the MM queues that userspace need to signal both a per queue doorbell and an aggregated one for the queue type.

Regards,
Christian.

> 
> Alex
> 
>> ---
>>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 29 +++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index a58342c2ac44..50e275b51c9e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -598,6 +598,35 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
>>         /* drop the reference acquired in fence creation function */
>>         dma_fence_put(fence);
>>
>> +       /*
>> +        * SDMA UMQ wake: SDMA has no CP_UNMAPPED_DOORBELL HW intercept, so
>> +        * once MES gangs the queue out (after the first IB's PROTECTED_FENCE
>> +        * idles the queue), per-queue doorbell rings hit a mapped-out HW
>> +        * slot and are silently dropped — FENCE IRQ never fires.
>> +        *
>> +        * Userspace rings the priority's MES aggregated doorbell directly
>> +        * via the agdb_bo mmap (see AMDGPU_INFO_DOORBELL +
>> +        * AMDGPU_GEM_GLOBAL_AGGREGATED_DOORBELL).  That alone, however, is
>> +        * not enough on current MES12 firmware — MES will not scan the
>> +        * priority's queue list unless its hasReadyQueues flag is set.
>> +        * NOTIFY_WORK_ON_UNMAPPED_QUEUE flips that flag, so MES then
>> +        * processes the doorbell ring and re-MAP_QUEUEs the SDMA UMQ.
>> +        *
>> +        * This is a kernel-side companion to the userspace agg doorbell
>> +        * ring; remove once firmware learns to wake on bare aggregated
>> +        * doorbell.
>> +        */
>> +       if (queue && queue->queue_type == AMDGPU_HW_IP_DMA &&
>> +           adev->enable_mes && adev->mes.funcs->misc_op) {
>> +               struct mes_misc_op_input op = { 0 };
>> +
>> +               op.op = MES_MISC_OP_NOTIFY_WORK_ON_UNMAPPED_QUEUE;
>> +               op.notify_work.priority_level = AMDGPU_MES_PRIORITY_LEVEL_NORMAL;
>> +               amdgpu_mes_lock(&adev->mes);
>> +               (void)adev->mes.funcs->misc_op(&adev->mes, &op);
>> +               amdgpu_mes_unlock(&adev->mes);
>> +       }
>> +
>>  exec_fini:
>>         drm_exec_fini(&exec);
>>  put_gobj_write:
>> --
>> 2.49.0
>>

