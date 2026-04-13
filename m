Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC6FEBFD10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 07:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50A7510E34A;
	Mon, 13 Apr 2026 07:52:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5PEWmqB";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4402D10E34A
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 07:52:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VbF3bDe9BQ58wX72XI8kSu/rhSAKUHSRiORoaM+9eh2v+WiiSLFzY6HEitu07aF72ZM4V6Gxs5kJWhtNEzKGuPq6xSR1VAIXHp7WqNtNw8NnqDd8bQC614MvbaSF2xKWD4ikM0ip7IN8Gb67clRNZJRN8vWliWBoNuNTkZnkBkNjGnYENvAshYrt2T3c4bxIyMM3gQGzoKsa6jA8m8oPehMYsgPMQdSCYyqTeCVBcoB6XK9R+n2BUaMlS3HOaJv6LaYgBIo293Z/bHtxvqNBgzPCth/tGESYPlatyiucbOT4bfLSVw7tnLtIw496YOAo98YjfMn58BHyPtnNu6q5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHEWKRfH0mDrJXytmW8t3ReRlXvSG+iWgTNIKS8KdUE=;
 b=HF5w738o6KSh4BjYksnk+MtYfiT3QNIRKwUHmXItCX5ekjgTT48URxVhtRLfoLI5bGUEfP3G/tkKlq4e0jDfeEWvbCIp3lK38LcrGhhikNTRorc7iJGGQz9feb/E+ISB0FGvuhAoCJeDkivp50acikmnOOW4MOHG/7Hih0gJsFnJ87yoRFy+iqj5B3fZ4aSSH/XVcQndv0lfbFuzIiiPGjAAjFrleel091ZjGyZAHCgSWkqcRcYKL7LzPSgwVx0C93MRA6gDXG9x/Qyu7aO1cyE7d6fUYVbz/Z2hXb+CsZyNjFQMMA9VUIs6oAQTQ4c7zu/x4Fl26wzW7slM0U07dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHEWKRfH0mDrJXytmW8t3ReRlXvSG+iWgTNIKS8KdUE=;
 b=r5PEWmqBZwl71Jv0vABKki9zZ1MFALuRED0DRtofl42E+veXkxnLwP/S4Rl5ZvOnsUMB7SVjRzJKryMxte48hd3ASKIdZ4HLARpZppgreqbFd9UBq4W2SrnozZ5axK68TutKznG6IGuA+1uPQgZhuf59TZBCMWq1c4NQRk7ZLa0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH0PR12MB8578.namprd12.prod.outlook.com (2603:10b6:610:18e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.35; Mon, 13 Apr
 2026 07:52:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 07:52:50 +0000
Message-ID: <937605d0-f6f6-4679-85f6-1fedecf9180d@amd.com>
Date: Mon, 13 Apr 2026 09:52:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] drm/amdgpu: add job->pasid in check as amdgpu_job
 could be NULL
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260413062153.4050981-1-sunil.khatri@amd.com>
 <20260413062153.4050981-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260413062153.4050981-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0367.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH0PR12MB8578:EE_
X-MS-Office365-Filtering-Correlation-Id: dfccc24b-b7f7-4f0e-c548-08de9931a956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: vuW0gCL8l6VRxqfbN/tYnNXPUoYK8sF+xawRdtVjGk3w66dFGoiCdTamiqlGHTzBtXcOUlZTAAVVsSYVnsy1o3IjROtoOX6Fo9ExTXPcVyBL4zpW8MzF8lsoM+mCtJQMa8zcBizVB0Eh7uhpsYxmzKpCJQnrDMc3bbF1RtDkERrJt4KPb6tjhb41+aJE/ugdbQ3ZOXoxfxeTC/Bow/h52zLBmkQXdBAg2V7ZZ2HKFqUdJDdlvLE4ilquC0HPFwX+QuDxAM96e0uWc5bUMfXx+3ST8rhn/1J67AZQNjrNc3rK0ANx2khF55cbFfrqDA42gDM2iTqcCZpqW8YcqIpY2xZOoGOCin3m7Sbw2waHTupbW64pczy6g8PlCUSPPyhu2zXpJjOOTp4QYjXERU4rnzdy2M3l90ajnYUnCnVM1TCb2CIVYl19E1lmv1U/GXNqn588M4+/jE0VS2CfrdTy6KpDKCJmPjoKQQaxooFzQrQ2DhNJ7wgpj4HRP2K0mrzasQ6w1PZtgKSGKURqS5WUns+Ponzei/j3zj2hw2eUfyyY5ejqIHfLKdtD0BVe4eS5rI29n333oWbkApcliAR2BxQDZcDN6p4rgDUS6/YGWHwDdOFJevjq8nwHma8Y16i+FqJsima2T46h+JxqNd10vTQ+XQsz9/B9HOTd4j5afboTnugS4rnyC66hy0utGMVpc5micw22QAgIwmRhWjrtnNBfDX4VWOi72oKhXJ48pIw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGpNWk4wSForRkI4aHREanF4amxod0ZHd0xEbHdIT3grU1IvU25lTUptTVJT?=
 =?utf-8?B?TTBUczdXdlJnVG1aMms5ZytrOUFIbUV1UE42WDFvcUdUeEorQkU5NEU3azVl?=
 =?utf-8?B?blVtYmZwUHJ1eGV3eUhxdE9BSnNGWDRXMnYrd092Qkg5ZEc4WVp4bW1mT2Iv?=
 =?utf-8?B?c2FqbjgwL1JxMVBXeXZuNHRwcnBlNk14czdEeGxhWWxlWG05ems4SGo3OW53?=
 =?utf-8?B?dC8yMnpaVkdnWkc5ckJsQko4NTJxYmgxQ2xndTNrcVl0MHlBcnhXZkphMGZp?=
 =?utf-8?B?dWc5VjFDQVBkRll2NHJ3WGZhSDhWZjVuWi8xcXZkaU11anI3MEJ0OXplM3Mw?=
 =?utf-8?B?eUdVTkdRcDZKNitLb2M1K25zNXQvOW8vZ256dDQ3d1g5V2xncHNOQ0s3c0k1?=
 =?utf-8?B?S1dSOVQ2dldrUkpIaVQ4Yzh2L3V2d3FVTjNxNXlhWFFFMFhXSXdDMkdOOFZj?=
 =?utf-8?B?d0h4eHcrU2xXNElaa0Z6ZzJsTzhVRTJOdDBzRnkyMlpkOUV5ZW8zdlBRTHpL?=
 =?utf-8?B?MlNaU2xYcG1NQTVxeU40dWZuZGRnYnU0MnROU2F0R3V4bDRzbUtIcXJnWk1E?=
 =?utf-8?B?UDgxVUZoeDE0a2ZOdW15Z0JLRVNOMHFGa3poN2ZKMitVSWlVZU5UU3VhVlpY?=
 =?utf-8?B?eHpHbkdpdDdPQUtkcUVCcDFJbkI3RWdoUUFDNE43MEdXdFA2clQ1QWxTOGw5?=
 =?utf-8?B?QkdSZTdyaHFQNlJqblZ3SjNwem85bS8rV2FjWm5LNFpSUldHQVdySFU3QXA0?=
 =?utf-8?B?Y0licmhweVF2bnE4dVc5NnkxUFFielY5a1hiS2dFTmh5VXdwTGlTVmVTVFUr?=
 =?utf-8?B?TlJxWk5ZdmRJd1JBTTNYeHJlQW9KVVdvN2JURmFUTjlxVi93c2RxRTlSTTBj?=
 =?utf-8?B?NEE2bWNkMzdYbjdGdlhCNEQva1FmQ0loeUtseERDcnd4ZWpCN1RwTE1kV0Jy?=
 =?utf-8?B?U01MQUZhR3Brejc3U0tlY1oxUzZ6RmJlQ2xhQnB1OVJxTFZxbEVqSHNNT05D?=
 =?utf-8?B?djBEZEhUbTFsc2l0T1pKeXAxa2dDTXN3U2l0NERjaEtJNFZFYkVleURzMFo1?=
 =?utf-8?B?dGU0cWVOR1AxY3R3d3hyangvcEgyUGRZOFFWZWhBQ094MUY1WDVFZXhtbUJa?=
 =?utf-8?B?VWs1Y1RjbEF3Y3VKbDYvZk1KRTVkVXVCYnNJd2srY250L0RNbWRLN1ZqcFhm?=
 =?utf-8?B?QkVuT2I3N3FRRlA4NFJBaVkrMWV4a3kzU3lmdDRwVnpTVHNKSzg3WEZhTm9Z?=
 =?utf-8?B?SStoRy9OblVVVFZRdVgwTEp2UHpSMFZtcjhyaGkvbUFzZTNnNDB1M1Fzd1Zk?=
 =?utf-8?B?MndvRXFLNlpkMG1zMW5lTURUNklmS3E1Ym04bnZxZnQza0FLUThDVWNwOVVm?=
 =?utf-8?B?VXFSUE9tMmpnMEtRbGhhdzYwTHI1Vmh1UlVMWHBaY3lrbTB5aERNdlVUaFJY?=
 =?utf-8?B?eVQ5SmJMNWZBaHNTdTFpOVhvdkI5L0pJS2E3MFg2Rm00V2JURHdaR21hNjk5?=
 =?utf-8?B?VGdQMzJIZ1dHWmVOaDRsTC9JZnYzWE1XbWVtNWN2SG90RzFDanZ5U2tmUFN2?=
 =?utf-8?B?SXVLSnBTbFYzRG9IOEJRd2loQ284R3lrNUtwNStQaEJacWcyRlhHenpxTXkw?=
 =?utf-8?B?aFZtZEMvZ2oyTFVITmNqV3puV0laQlZxNThWTmZGbnAweWNnU3JXaVN2UGZa?=
 =?utf-8?B?bnllZTRXTnZVS0c4bTViVEd1UjNhZTYxdFc2NUc5dmtwL212d1orOStnak4x?=
 =?utf-8?B?cWw2bkg5NHk4NTcySWQ4cm5ZTDBWQmdpbDJjdEwrQUlRLzI5UzM1SVhYUWpM?=
 =?utf-8?B?SHpBMFowQ0kzQjkwOVRaWmowWmVMSjh1MGtwOWFIMyt0MkN0VG1oN2lQenpk?=
 =?utf-8?B?cG9GWnhQMnZBeWFJTzhsVlpiQTJ4VlZPTFVneVNybVF1WVhPbi9aTGt6UWpk?=
 =?utf-8?B?UGQ3Wjl0bXI5YWExYlNrNTJPemFWRXk2MlB3OC9BcCtnRUQzOTIxWnM5b2JR?=
 =?utf-8?B?MC9GYzl6NjZjT0tVVmExL3dES3B6R0duWjJpYWpuMjVuZEduNHR2Y1NlemZS?=
 =?utf-8?B?Um5scW83VHlHQTcyZ2MxK0Z3cTh5ZG90TkdMTVFEVUUrQU85TDRlSkliUDM1?=
 =?utf-8?B?Q0NYbDNvV2NpWFdncWFndUtJM1lXdVpobm1wYTZpbXdtcVNxUlZWcHVha3ZG?=
 =?utf-8?B?a2h5c2syMlBWSmVCWmc0ckxjQ1B4OHE3TlQ0ZTE5SUVPWlRZN202SlhpbU82?=
 =?utf-8?B?aEJiQWl1QkZvN3dvOFNWVUkzWEdPYXZDMEZFUytBYXRVTTFjcWZpcXJ3RGVu?=
 =?utf-8?Q?IHNOjFq0rKzUxpgshf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfccc24b-b7f7-4f0e-c548-08de9931a956
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 07:52:50.7809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q4UnYaXNoJfQJtlUs6wPpPwXKt6Xmwvi+6dscs8MfPmHSY117iJAOiwcdi4kE+Sf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8578
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

On 4/13/26 08:21, Sunil Khatri wrote:
> In below stack job->pasid is accessed while job is NULL. Access it
> within the check when job is non NULL.
> 
> Failure call stack.
> [  222.653622] BUG: kernel NULL pointer dereference, address: 000000000000014c
> [  222.653625] #PF: supervisor read access in kernel mode
> [  222.653628] #PF: error_code(0x0000) - not-present page
> [  222.653630] PGD 0 P4D 0
> [  222.653635] Oops: Oops: 0000 [#1] SMP NOPTI
> [  222.653639] CPU: 1 UID: 0 PID: 12 Comm: kworker/u96:0 Not tainted 6.19.0-amd-staging-drm-next #271 PREEMPT(voluntary)
> [  222.653644] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
> [  222.653646] Workqueue: amdgpu-reset-dev amdgpu_userq_reset_work [amdgpu]
> [  222.653961] RIP: 0010:amdgpu_coredump+0x8b/0x470 [amdgpu]
> [  222.654158] Code: 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c0 31 c9 31 ff 31 d2 31 f6 45 31 c0 45 31 db e9 8c a9 1a e2 88 58 48 44 88 68 49 <41> 8b b7 4c 01 00 00 89 b0 80 00 00 00 4d 85 ff 48 89 45 d0 0f 84
> [  222.654161] RSP: 0018:ffffce68c0147c00 EFLAGS: 00010282
> [  222.654165] RAX: ffff8bc337407740 RBX: 0000000000000000 RCX: 0000000000000000
> [  222.654167] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [  222.654170] RBP: ffffce68c0147c48 R08: 0000000000000000 R09: 0000000000000000
> [  222.654172] R10: ffff8bc337407740 R11: ffffffffc10dda10 R12: ffff8bc2d2e00000
> [  222.654174] R13: 0000000000000001 R14: ffff8bc2d2e5b368 R15: 0000000000000000
> [  222.654176] FS:  0000000000000000(0000) GS:ffff8bc64a5fe000(0000) knlGS:0000000000000000
> [  222.654179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  222.654182] CR2: 000000000000014c CR3: 0000000135eca000 CR4: 0000000000350ef0
> [  222.654184] Call Trace:
> [  222.654187]  <TASK>
> [  222.654190]  ? amdgpu_ip_block_resume+0x28/0x70 [amdgpu]
> [  222.654376]  ? srso_return_thunk+0x5/0x5f
> [  222.654382]  amdgpu_device_reinit_after_reset+0x184/0x320 [amdgpu]
> [  222.654552]  amdgpu_do_asic_reset+0x129/0x160 [amdgpu]
> [  222.654720]  amdgpu_device_asic_reset+0x92/0x710 [amdgpu]
> [  222.654890]  amdgpu_device_gpu_recover+0x2ae/0x3d0 [amdgpu]
> [  222.655060]  amdgpu_userq_reset_work+0x76/0xa0 [amdgpu]
> [  222.655229]  process_scheduled_works+0x1f0/0x450
> [  222.655235]  worker_thread+0x27f/0x370
> 
> Fixes: f9839cc47e53d ("drm/amdgpu: store ib info for devcoredump")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Vitaly stumbled over the same issue, but his patch fixed a couple of more things.

I think we should push that one here first and then rebase Vitaly's patch on top of it.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index 3f1cc2265645..3d7aa6b09815 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -511,7 +511,6 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  
>  	coredump->skip_vram_check = skip_vram_check;
>  	coredump->reset_vram_lost = vram_lost;
> -	coredump->pasid = job->pasid;
>  
>  	if (job && job->pasid) {
>  		struct amdgpu_task_info *ti;
> @@ -521,6 +520,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
>  			coredump->reset_task_info = *ti;
>  			amdgpu_vm_put_task_info(ti);
>  		}
> +		coredump->pasid = job->pasid;
>  		coredump->num_ibs = job->num_ibs;
>  		for (i = 0; i < job->num_ibs; ++i) {
>  			coredump->ibs[i].gpu_addr = job->ibs[i].gpu_addr;

