Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBFDC4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 11:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A60310E633;
	Mon, 22 Jan 2024 11:42:40 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FBF10E633
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 11:42:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdqpWder7Levajn/0oBkhb2Yziy1hB2bpeuRIsTpttL1dmlLKavCkeFON4jhZRN/4FUYFw9/0jAe184bytBziYZ6vhO7KMVCafGaSzDdR2NbJ4gdNnD42mVZtjXbytptWI3w4eF6GaLQg+ZVzyyxCyEBfHophqo2/5+dvKFyO5A5479a9bUdR+y4bsMltKi6qsNEIBdoLZRW1RBrdQYev4ZtyFBaMVVXvr8+8LOUxqKKhsZt0HHgdLVJcIi2YpIiZuqOQvXYubnciJEV71edib6XTuN4SkRv/v3XZwDfaP/uR6s8TZozrAW27i7JttwR8zEnDHoV0CN1Mzdepm5uTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYeZlTpRyAtpfPuZ5oxn70Z6FWStzxvLSzjZ+TIEW1w=;
 b=OKLrxmURGoRZ+LHolTzaUAbQwkjZ76e0AABb1lX9fMBU1aRT/aCRyrh6ZwPrfdVkZ6lwtk8JgOIXDoXS4aLY2kegvsYVIYEgVNTTPOAwbz6RrJNXNfmZCuxW35ZbBhjdGI3M2Ve/rBdKKxGz4//5kSobOUEWM61W1whKzE3bJrUfHWWajVP96bnrWSx8TNPadH9R8UXPbDvPakCDviy5FZKJA3hAW1VhVXW3FUy5oalQ5U9HHFMfS+Fsy2k9UuuM0F/lUggBSCFfU7rq0jJB0iRz4IRu5o6BUvmIKVoi4a1B63pUClKarZRRI5Loebrxri4RKhYDg1XTh4IWk/fEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYeZlTpRyAtpfPuZ5oxn70Z6FWStzxvLSzjZ+TIEW1w=;
 b=Wu1Bion/zFJ4Tos5qqmVcMjdSMAaCUKM1qeQnhcqp4DSNUUibzXifsJ3UU/tZC9OW0xRyMGayvSQZnFq3I8sL/hirCgARf7MRx0fwBfui5VJ5D9+litNgKkK5zGJcN0T5z01rOyLZJVWYrGJQynToSy/HhjfyTM4Khn2IpJunqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.31; Mon, 22 Jan
 2024 11:42:32 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 11:42:32 +0000
Message-ID: <4f773891-8a38-41d8-bf35-d0feedc2e6b6@amd.com>
Date: Mon, 22 Jan 2024 12:42:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: check flag ring->no_scheduler before usage
Content-Language: en-US
To: vitaly.prosyak@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
References: <20240121001951.75950-1-vitaly.prosyak@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240121001951.75950-1-vitaly.prosyak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 543d5d94-8fb4-48e8-fcf2-08dc1b3f3849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tdX5p2S2kSjl+Q0YMa7BseoWeyP9pcvMJfpUOtysKKAeuK50jChH02LcqswCNYEOWXWXmxypBFXGT335y3VbEY1lNsKTYMBGjT/XPWqBChlWv6i5EcJwbkZu3vL2rjJcoRmEi1jgj8AkIzND6zSihHvFNi7ca5ICCxtf1j2MlKbIhjP8MntbKvLyJp+NqNL8fQyBEkj274UITAssyPGTIOCvYIEyNXSJOaS5MwMyuvtx3sP0DFNkWmGLgLoDJViQV1v4h71NkwhDdA+hiAfzVY8m+nrj771hewRF8ZfN/MHSg4RYsgp7kAOdHMcLlsZ33P3cAfwRyulk34k7BJyNMgUOUAuM+yrHeZajIMNEBB1VxHupTTWzTDMFRWVdGBNOuoiKJwtCEmCcqyecvyt57j1Yz5AJPkYi6fDKE/HZc4DSvNoCwa2ZKfh4fnhkAy2eMxlBWBfnkSAeIXxeI5Jmxv/5uGTgbYA/kyR6GsiEIODRjSmcndZkdrf4/IIYht7W4/LFR1PtrXyZNGrAMI+ENQ4fofH148VNkK66HfPXKcKqMoB3QFsaubKLTrgS1ouk0XdFnLwcKEwFekHZcQZP1il+FWz6HKjrXIZHuXdwWV/Q9GiYwCcOe+5kpaV9HADJOicyS/1RA2ipYrqDtIxb0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(2616005)(83380400001)(6666004)(478600001)(6512007)(2906002)(6506007)(6486002)(41300700001)(31686004)(36756003)(86362001)(8676002)(316002)(66946007)(66556008)(66476007)(8936002)(5660300002)(6636002)(38100700002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWNGM0ZYM0RBcUVnNzF1TER4L2EybE9qK0dCdUdPMXl1aGRDZ1VSdTR1a0lZ?=
 =?utf-8?B?dmM3M25LTGdWcHBZeUZDUlJyeHBpU09saFVRYVJVTGxJbUhkWGVRaVA1K1lr?=
 =?utf-8?B?cENaT0s2MW82bGsweTVEODkwRWdpemtHY056dk1wZ3FRb29iRnRoTUhyLzcw?=
 =?utf-8?B?YWF0YXFpaWs0ZHNMcXFMTUpscGxkdEpVd3FEOG5idXRVSU9DeTAwTlM3dUti?=
 =?utf-8?B?OXBxdGNlM1pILzh4YlNXRVRaYS9RUlBua1BVT0gyajZUZ3FtZ0dUbUxQUnBV?=
 =?utf-8?B?elJJYnRGU0JPQWZFOUdSNGRadTVqZXM0bk5pelFUKzlFRXBkK2xlaFVZaHVW?=
 =?utf-8?B?bk4vRVpyWTZWQWplMUhMVk1FaFlYUjNIbVJUK2w5WHkva3Z4N0NRZUh3Qmow?=
 =?utf-8?B?NXo2Sk1FdnhqUG8vZklwcm1CbHpnTzc3NVdGQkVlSXBCR2V2ZThGdVF0R1Yy?=
 =?utf-8?B?SDRGMUxHd2haZjM3S0lnVlZZYUpxTzQrcHN2K2FXZjFZUjF6OS8wNFJoV2Y4?=
 =?utf-8?B?dndWNWxMRk5vTGtrYUc0OVBXN1FiaGVTTXg0VUdaQTNlRCs0SWtJVWJ3bzIw?=
 =?utf-8?B?YmRKUmhZQVVNRWZjRXRRdDVxQkRITndMcEZ5aldGQ3Vnc25ZbjFsRXYybEcz?=
 =?utf-8?B?TXlubzdSa2NrdThPdHhvQVpwUVdNME9WTEdOUlZkWkc3RWlMQWdWdko0SkE3?=
 =?utf-8?B?VkE4NVQ1RFRHcHpHN1NiWWhjVnhRVnczUDFTbmF0UUduMkdSUEd0T1NpdUo3?=
 =?utf-8?B?dXJzYnRNWnliNXJCQ2RXb3k4MHhkOWhxbkhCZ1RWZnlldjQvK1p1SGZxMU8y?=
 =?utf-8?B?eXIvNDZ0TFF5dCtTeW5aK0JveUcvSFJ4S0NIY1lKU3RwdzNkV2xzaVdpMDBi?=
 =?utf-8?B?Unhvc3daR0dEQUhIYjJrb2xTYlFBVmF3c2tJeFJmWWRnamdCUkJKSDg1NTRN?=
 =?utf-8?B?VzZEaTZPREtCWGJRMEs1YkxMZ3RuSVlQdEVMZVJINmNkcGdWanpaK1Z3bTNz?=
 =?utf-8?B?QjlCcU9nSU9WaGJGdG1XM3Yray9RdklnbEk4Y1pJT1Y5WTZ2MGd0MXlzZ1JN?=
 =?utf-8?B?Qjc0S1NHVmhKSWlyZUpkYWZsNnBWRVRaRWxiMko0UUNNOENMcC9UalhjaVpS?=
 =?utf-8?B?NnhOYVJ0UzdPU1Fob0NPTVd1SnBuM0JaZ3oyVW56VU9tUkF5VjBORWpoQjI5?=
 =?utf-8?B?VHVsak4wNGZHTDcrakRVcEROVHlpSmxlUTQvMUVaWEZZSkdLL1lnQSt5ZlA5?=
 =?utf-8?B?N21QS3VGWWtGb0hGNng2MGJmOWhJRDNrQW9CY1RYcktMMFZtSkNKcUE5czFR?=
 =?utf-8?B?bENYdVdiSWJZM3BWYlJFbGRSR2EzUnFURVQvczFPcy9RK3dMWnV3cWV1SlhH?=
 =?utf-8?B?MUhjNGNiNGxxZUp6MGk0TWV6b3BqMjNNeG1CSzRBdW0rQUVOaUNEdHBENXhw?=
 =?utf-8?B?MVd3SXFleU9aMEx3d1ZaOUhZNWxpU0xURUtNdTNQTGF4N1VzdU1SaUhWcWdH?=
 =?utf-8?B?WFFuYURrS0RBUE1NT0ZxbEZtZGE0RXdMbXY3Vmo4VnVXbUx4MC9yc2lLeWUz?=
 =?utf-8?B?YjF0Q04vQWZ2T2lIUENZczJaSlpDRlZteE5DTXFZTmlzd1VuYzZWUTgxQ21x?=
 =?utf-8?B?eWR6ektpRWI5a1pacWFYSkRjZ0NRQ1NzL25oeXV6bmdiekE5K3QrY1c3RmVQ?=
 =?utf-8?B?cmdxRTNaenBSNXhRQ0poQ29HY1pudFZPaVVwMTROdndQeHJDMU9QUzhLcnBp?=
 =?utf-8?B?d3h6UitUeFlseUxWQ3E3akdUM0RZN1lMbjJlRm9iVEg4M3VnNitwK1lmSnQ3?=
 =?utf-8?B?TEpsU0wvTmZibG5vT3d6N0ZqdXA1eEJqTzhlZXdmanVTSUdRUnVGc3ZFdHNU?=
 =?utf-8?B?S1Q3SVJ1K3BUU2FSR0VVMVZJLzhwazVROFlSOXJhVU8weU5sTTQ4cG1QYTdm?=
 =?utf-8?B?U3hXMk0zdHZZMnFjclQ1SGsxNGpmZDdZTUpyNlNPM0Jpd0RNZzE3S3cwcE04?=
 =?utf-8?B?aVoxUHNzWS9BTVRCcTRremRpWk9JQUI5aXplMVlSQ3ZYaFJUMHlPbCsrVHZG?=
 =?utf-8?B?YXhYbDhPb1BSUVVsTUN3Z0swWU8vR3MzOTR2MWJ4N0swdTdLakc4N2lvVVZI?=
 =?utf-8?Q?98UWSNW7cHd645BqvZXUN1C82?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543d5d94-8fb4-48e8-fcf2-08dc1b3f3849
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 11:42:32.3707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AAvmW9ccHIwxzqY3WauiaUuwmctmyfWx3DbB/J7Rg/GjGxJlR0ys8m+H4miKwQtr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037
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

Am 21.01.24 um 01:19 schrieb vitaly.prosyak@amd.com:
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
>     The issue started to appear after the following commit
>   11b3b9f461c5c4f700f6c8da202fcc2fd6418e1f (scheduler to variable number
>   of run-queues). The scheduler flag ready (ring->sched.ready) could not be
>   used to validate multiple scenarios, for example, check job is running,
>   gpu_reset, PCI errors etc. The reason is that after GPU reset, the flag
>   is set to true unconditionally even for those rings with an uninitialized scheduler.

That's probably a bug we should fix instead.

scheduler.ready means that the engines was initialized and should 
*never* be touched during GPU reset.

The only exception to this is when the GPU reset fails and we can't get 
the engine working again. In this case the scheduler.ready flag should 
be set to false.

The problem is that when we moved this flag into the scheduler we had 
some rings (like KIQ) which don't have a scheduler but still need to 
toggle this flag. We should probably look into cleaning that up instead.

Regards,
Christian.

>   As a result, we called drm_sched_stop, drm_sched_start for the uninitialized
>   schedule and NULL pointer dereference is occured. For example, the following
>   occurs on Navi10 during GPU reset:
>
>   [  354.231044] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
>   [  354.239152] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>   [  354.246047] RIP: 0010:__flush_work.isra.0+0x23a/0x250
>   [  354.251110] Code: 8b 04 25 40 2e 03 00 48 89 44 24 40 48 8b 73 40 8b 4b 30 e9 f9 fe ff ff 40 30 f6 4c 8b 36 e9 37 fe ff ff 0f 0b e9 3a ff ff ff <0f> 0b e9 33 ff ff ff 66
>   66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00
>   [  354.269876] RSP: 0018:ffffb234c00e3c20 EFLAGS: 00010246
>   [  354.275121] RAX: 0000000000000011 RBX: ffff9796d9796de0 RCX: 0000000000000000
>   [  354.282271] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff9796d9796de0
>   [  354.289420] RBP: ffff9796d9796de0 R08: ffff977780401940 R09: ffffffffa1a5c620
>   [  354.296570] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>   [  354.303720] R13: 0000000000000001 R14: ffff9796d97905c8 R15: ffff9796d9790230
>   [  354.310868] FS:  0000000000000000(0000) GS:ffff97865f040000(0000) knlGS:0000000000000000
>   [  354.318963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>   [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000000003506f0
>   [  354.324717] CR2: 00007fd5341fca50 CR3: 0000002c27a22000 CR4: 00000000003506f0
>   [  354.331859] Call Trace:
>   [  354.334320]  <TASK>
>   [  354.336433]  ? __flush_work.isra.0+0x23a/0x250
>   [  354.340891]  ? __warn+0x81/0x130
>   [  354.344139]  ? __flush_work.isra.0+0x23a/0x250
>   [  354.348594]  ? report_bug+0x171/0x1a0
>   [  354.352279]  ? handle_bug+0x3c/0x80
>   [  354.355787]  ? exc_invalid_op+0x17/0x70
>   [  354.359635]  ? asm_exc_invalid_op+0x1a/0x20
>   [  354.363844]  ? __flush_work.isra.0+0x23a/0x250
>   [  354.368307]  ? srso_return_thunk+0x5/0x5f
>   [  354.372331]  ? srso_return_thunk+0x5/0x5f
>   [  354.376351]  ? desc_read_finalized_seq+0x1f/0x70
>   [  354.380982]  ? srso_return_thunk+0x5/0x5f
>   [  354.385011]  ? _prb_read_valid+0x20e/0x280
>   [  354.389130]  __cancel_work_timer+0xd3/0x160
>   [  354.393333]  drm_sched_stop+0x46/0x1f0 [gpu_sched]
>   [  354.398143]  amdgpu_device_gpu_recover+0x318/0xca0 [amdgpu]
>   [  354.403995]  ? __drm_err+0x1/0x70 [drm]
>   [  354.407884]  amdgpu_job_timedout+0x151/0x240 [amdgpu]
>   [  354.413279]  drm_sched_job_timedout+0x76/0x100 [gpu_sched]
>   [  354.418787]  process_one_work+0x174/0x340
>   [  354.422816]  worker_thread+0x27b/0x3a0
>   [  354.426586]  ? __pfx_worker_thread+0x10/0x10
>   [  354.430874]  kthread+0xe8/0x120
>   [  354.434030]  ? __pfx_kthread+0x10/0x10
>   [  354.437790]  ret_from_fork+0x34/0x50
>   [  354.441377]  ? __pfx_kthread+0x10/0x10
>   [  354.445139]  ret_from_fork_asm+0x1b/0x30
>   [  354.449079]  </TASK>
>   [  354.451285] ---[ end trace 0000000000000000 ]---
>   [  354.455917] BUG: kernel NULL pointer dereference, address: 0000000000000008
>   [  354.462883] #PF: supervisor read access in kernel mode
>   [  354.468029] #PF: error_code(0x0000) - not-present page
>   [  354.473167] PGD 0 P4D 0
>   [  354.475705] Oops: 0000 [#1] PREEMPT SMP NOPTI
>   [  354.480066] CPU: 1 PID: 11 Comm: kworker/u64:0 Tainted: G        W          6.7.0-991912.1.zuul.e7596ab24dae4bb686e58b0f1e7842da #1
>   [  354.491883] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
>   [  354.499976] Workqueue: amdgpu-reset-dev drm_sched_job_timedout [gpu_sched]
>   [  354.506855] RIP: 0010:drm_sched_stop+0x61/0x1f0 [gpu_sched]
>
>    The solution is every place where we check the ready flag and check
>   for ring->no_scheduler. The ready flag serves the purpose in case an initialization
>   is failed, like starting the worker thread, etc.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c    |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 14 ++++++++------
>   3 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> index 899e31e3a5e8..70bbf602df34 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
> @@ -292,6 +292,8 @@ static int suspend_resume_compute_scheduler(struct amdgpu_device *adev, bool sus
>   
>   		if (!(ring && drm_sched_wqueue_ready(&ring->sched)))
>   			continue;
> +		if (ring->no_scheduler)
> +			continue;
>   
>   		/* stop secheduler and drain ring. */
>   		if (suspend) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index e485dd3357c6..35132aa2c0f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1678,7 +1678,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		struct amdgpu_ring *ring = adev->rings[i];
>   
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>   			continue;
>   		drm_sched_wqueue_stop(&ring->sched);
>   	}
> @@ -1694,7 +1694,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
>   	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
>   		struct amdgpu_ring *ring = adev->rings[i];
>   
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>   			continue;
>   		drm_sched_wqueue_start(&ring->sched);
>   	}
> @@ -1916,7 +1916,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
>   
>   	ring = adev->rings[val];
>   
> -	if (!ring || !ring->funcs->preempt_ib ||
> +	if (!ring || !ring->funcs->preempt_ib || ring->no_scheduler ||
>   	    !drm_sched_wqueue_ready(&ring->sched))
>   		return -EINVAL;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2df14f0e79d8..894b657df1d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5052,7 +5052,7 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
>   
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>   			continue;
>   
>   		spin_lock(&ring->sched.job_list_lock);
> @@ -5191,8 +5191,10 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
>   
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>   			continue;
> +		 if (ring->no_scheduler)
> +			 continue;
>   
>   		/* Clear job fence from fence drv to avoid force_completion
>   		 * leave NULL and vm flush fence in fence drv
> @@ -5658,7 +5660,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
>   
> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>   				continue;
>   
>   			drm_sched_stop(&ring->sched, job ? &job->base : NULL);
> @@ -5727,7 +5729,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = tmp_adev->rings[i];
>   
> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>   				continue;
>   
>   			drm_sched_start(&ring->sched, true);
> @@ -6082,7 +6084,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>   		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   			struct amdgpu_ring *ring = adev->rings[i];
>   
> -			if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +			if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>   				continue;
>   
>   			drm_sched_stop(&ring->sched, NULL);
> @@ -6224,7 +6226,7 @@ void amdgpu_pci_resume(struct pci_dev *pdev)
>   	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
>   		struct amdgpu_ring *ring = adev->rings[i];
>   
> -		if (!ring || !drm_sched_wqueue_ready(&ring->sched))
> +		if (!ring || ring->no_scheduler || !drm_sched_wqueue_ready(&ring->sched))
>   			continue;
>   
>   		drm_sched_start(&ring->sched, true);

