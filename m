Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4183F106FD9F
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9586C10EB46;
	Fri, 13 Mar 2026 08:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C/qRvzgI";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE93C10EB3B
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 08:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tWOhaDqTLPh6BV0QmWJvufKZAreHc3HQj5GZ85HHWIqhjRzRUVRnpQuYM/Ufz477+sCyLp5XoaoDRjA73/BFuyECMvQJCQF5gJhf06M88ZDhuRrYUdJsEcaLj7LdzMxmKDfGcoEQaJuZfzhKFUX5wV+Jm9wdl6J2OzBkDJpFku6sLSb8H7HQsCwCbVRCkVoWI8i7FSg6DIpk3+AuHAKeY3SqvmD02tLpgRl3c+d5mb2SMvzJIU8fXRMz5rWQla07Qi63N/Fve60ZRYGHlzQPLBGR+toKNuwMm/brTAxcbKQFvAb9N3kMbv0xsnacabml5syuTvYnFaFordtwEFurmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X23KBlTER02kL3bY/Xkz7Qa7jz1g5zO/ctDHLTSaymM=;
 b=vqqhGnWPWcwzWQD8mk2e848KG6okYJxL0sWG/RGHQvm+cVRSx+956Z3eb2Gpw2T0V6kTv4zhrMrK6YWguSqXQeaL4H6vZFxKSjD3dBZWxDyjg5VJG8Zq7CCdH+r237jV51Xx3XmhTM/DoJRQIUkzeMSCtxInFy3U8dw6hZnZjKy6CUqy1/A8Vi6269Ufx83Z3VmCZWBkMBKuNH0EOv/Z6ubTXZJp81lbszNY+aFGZDbOQlBU4lTmzP8fXXLv2B31zQgD/cq0vma6xR6qu8XmAnBpi7/Fe7qny3jY3NpRISOah5qwtoPxF5a9vCLMmApymefZM7MAawSYqwTwvjWHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X23KBlTER02kL3bY/Xkz7Qa7jz1g5zO/ctDHLTSaymM=;
 b=C/qRvzgIvpiDmxnrFlOoeGnyiP8PA+CSLX+L3qrRTuUMz3uPB92Kt+hhxj17xNYeZouHHHed17a/c+kOvWpp0C5WsDU60FvqsCRrvYA9A4aonqK0TRynVoxC9wzxdtHgZClNMfHGVIpSSG3nZcNxXkOvkc4dY6fnE1waqCN1Nq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ2PR12MB9116.namprd12.prod.outlook.com (2603:10b6:a03:557::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 08:53:10 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Fri, 13 Mar 2026
 08:53:10 +0000
Message-ID: <609153ab-f4b9-4501-8f8c-970847746870@amd.com>
Date: Fri, 13 Mar 2026 14:23:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drm/amdgpu/userq: fix dma_fence refcount underflow
 in userq path
To: Tvrtko Ursulin <tursulin@ursulin.net>, Sunil Khatri
 <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260313072140.3327678-1-sunil.khatri@amd.com>
 <20260313072140.3327678-3-sunil.khatri@amd.com>
 <344dec42-00b1-4870-9f09-8b5fae61878b@ursulin.net>
 <86643e4a-15fb-414a-a06a-a3936413696b@amd.com>
 <a28f8697-da5a-4128-93b2-a06243cc6524@ursulin.net>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <a28f8697-da5a-4128-93b2-a06243cc6524@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::10) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ2PR12MB9116:EE_
X-MS-Office365-Filtering-Correlation-Id: 59e868a8-a20a-49ee-bb27-08de80ddf3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: USbcuExGrJ1Vv1XmlIhx6qy3ttmre06iT2oovXRgWdIBh89f+s2lNMwCEFBtCeaORbtpZuTDQSCjqwROy6AkDTy++wptH1Ye0MerDX8dTXGJAfOdjlaBrMswONVMeR5VGguMpghJTuL1Q4TyBoYstLkIJxxZyXGeQiBYQQsEr9sCCNKT+dYtsjYj0h9GPZUssZ6iSpJCEJYdpjmUzzWpd+/r7god0axeNms871BHlNm0ADubjVj4UQkechG+uvl53fCmJ1x5GZ/Ik3B3L/fl+DtzLPY4EUel14qQPcFDHKSrbKESl8aSFgLBwhRSq4wnZiMgh59CBGlAjxYy6JdUEgVQXDxx2yEr8uooASW3ykDgg5aRCAXL37knbs6vk14GTWhghC+bE1xPuoqcILgMiJ6o3FQcQS8DfkSlV4u/XKY9kRa3zy5+byFewTYRNjflnlMlri+KABfcejjHIEoP50AuOvU9+6s8xLkQ3/bp2rt/0lwLGQJCVhUpsKNFXhIwN31Je2D3ecxG2fHRQxAUsbVwytORc0q9mmSGYtlcCrvlE0g5xVSvH+gi3clYVhPyfWlduBMHwJRVeo61lq1mEuKqV+JUzDG5ImCCuB3NX6P4tVNBSVK6m0CaY27USKwp6FtGO7sBU/qNHKfT2eEtQLcUKEL0iiZmk1b4mupUcpmLqNdaXzqy9xRtzNhxO5/Ztk3ZchUfmdFcLAc7w0MGELGoYbF/O6CEI0QyHVfLg/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDNqNEx2dUV4S2V4SmtXSXZxUUJzeENRcy9OOWFkZzB2bVNXZk03c3dTYzFx?=
 =?utf-8?B?SWtzRVlVVmI1aG96c2l2Z2NlbVFkQmFGSE5EYXpYTGMzVDNtOE5UTWNza1E5?=
 =?utf-8?B?NitkZzkzeHJsVEc5anJMVysrTXBhMkNrMnpSdmhvR0ZPVzRWT1pHNndFTXhC?=
 =?utf-8?B?b3VXUmFqOTNxaHU5OEkyZEsxbGxYNVc3VVA3a3cwazFqMnRqZEc4MEVPTkNI?=
 =?utf-8?B?QTdneG5SVTFrWC9ENHczNWdIL3lTMUxNaHdWVC8waTZHZHd4UlZVSUZUT2lQ?=
 =?utf-8?B?NE9JU2RZbFBhZ3A0SWh0MTRTcHZUMXJqYTZ2RTZmSnc5Tnk4cW8rZDZGK205?=
 =?utf-8?B?RkpLaVlYT1VEMkFSSmZaVlptK3JwMmo5Ri9CeURWYk9Yd0xUM0I1bEpHUjNs?=
 =?utf-8?B?Q0N0eUxlelc1ZU1DQTYrOGxveG5aN1UzdTdvK1B2ZFc4WmdteU5sZjN6LzlK?=
 =?utf-8?B?MjVudWJiMXBodEQvVTFqUXNnSC9IVWNqNmhZOUtPem1wL3FRMkpKT1piOHQw?=
 =?utf-8?B?MzFTNnZPNzg1b0dEY2N0a0YxTEtRSncyeHlVcG5IYmpWRWFsTEhNeFArb29n?=
 =?utf-8?B?czVqSC92YmQ1TlcxVlFlSFVNeU5reFBldDlTNXc0U0hsOFl2ZlVhaXNyelRz?=
 =?utf-8?B?cXAwWXg5Qkt4ajJWcUM5VG80enlTTnY4Vi9FUVN0NGhWdHl0K3Q4NlA3Tlpy?=
 =?utf-8?B?MjJXMzhQcm9hakYvbEpqTDliTTA4V1JMN1RIN09uV2NwL3RSUko5VE9TVnZi?=
 =?utf-8?B?c1h3N0lRc0NBL0l1VUNHeGMvMzNDN0F1azlwdnowSmViNnp6TytJVjR1NExu?=
 =?utf-8?B?eEtaclpiS203VVl5VUM2NmdNaUVKc3JVckU5bHdiM251THhMdENuNmFpT2FB?=
 =?utf-8?B?WEFvcVpOdnVLK3RZbGpoQTNsT1lhSVI4U1Z2Q25KNDRERktrUDRQejNCem03?=
 =?utf-8?B?V0Y0Nmx3UWs5dHl5RHpCOW5mRFkzMUR3T2hkcHVMUWRDUGJMOEluYVFPb0F0?=
 =?utf-8?B?K3RienRiZG5BbUZqMHZiWFUwUHZmTkltc2FjbmFLYTlRQkhqM3FqcTlDYVF1?=
 =?utf-8?B?dHpjc01KSmx3NFNUdU41dGJsOG1rc3lRcHVBWmc5UVBkNkpncDdOWnJ1REYx?=
 =?utf-8?B?bzljajE1d3VxRUNaYzd0NjArRURlUVpycTNoMmRSZHJvaDhuUkdXM1pMYUho?=
 =?utf-8?B?RjVNdEJaZ0p4S3ZQQ0hVL0RtT0g0cmJMa0NqSXAxQVVZcS9ZMmRKNlNJc1JG?=
 =?utf-8?B?b2hEaFAveVllQkxSOHZ0dUlkdEo0QnNKUnlkekcxaVllVm1NSU16cXBZQkVM?=
 =?utf-8?B?Sk9SN3o3V2pjejUvUTUxbU8vd0lyYjY4UUxyZGg1ODRHYmh0SktwcE0wNlJu?=
 =?utf-8?B?eUdoUkhRc0Jwd0twSFJ3K3l1bW1HM3h6cGs5KzJtNWJTc3NqTHV5Nm9OL1pV?=
 =?utf-8?B?ZW5RQkNBMmlnZk1EVk1jU1p5YUFHcVFZN0RFN0RCeWtMUnVVTHlnVVV5bGFO?=
 =?utf-8?B?Z1grM0FJd0t2V3NnZy91Z1MvbVM0c2pxcWVyeFRaTkUxWUV1eFlHWVMydGZs?=
 =?utf-8?B?ZlFiQTZaK3h3aDdnbHBrMXlaU1llRHdpUlFsdHFJRW1BbXFLWFMyR09RL2xG?=
 =?utf-8?B?Y0F2QlVrekozcDlFWDZoNHN5TlhocnFkZThsQVJUaFFncC9KR0I5ZjEyNjJj?=
 =?utf-8?B?RWxiMFdUN2hEOUhxSHJvZlBUMVc2eWlDRjdzcG1lK01ielIrVmFQVTV0QWlE?=
 =?utf-8?B?RVk1VWNJMUdJQlVtVnR2M0VMTTMwVGFaek1BT2d5Z0c5S0x1UHM2TXhwVTVR?=
 =?utf-8?B?S3lMaFhLWTFuM0I0U3pjeE5NcWhMUkI1b1lydFlrWEVVYjJvaTE2UnVEVmJ3?=
 =?utf-8?B?ZnErM2xZSXhhZjlFQUdTRUM0S0lBMWQ2ajdMdEdTWGZmOEpkS0JGeHprWkV6?=
 =?utf-8?B?cUppV2JDQklVRXo3ZEc0UWJwNXo3N0lUcEdyeE5KZDVIMU83WlZFL3ZJZnJM?=
 =?utf-8?B?L281MWswaXYydkxlVVU2alIwRUhtS2RaeUl2VzhKWkR6aExaQVRyVTFPT0ZH?=
 =?utf-8?B?NUNpa1MrZTNScnN6ekJiVkVxa2dFM0pzaEpKZGx2dkVaUFYvMG9MSFZRbWQ4?=
 =?utf-8?B?KzZIRXl4SStTWHVLM2c5RE84Nk8wSzNhTmE5cUpRYUxTMzlBUmk4VERKWmF0?=
 =?utf-8?B?K0hrVGdxczVtcHBjOTdJcHNYUzF2RTkxQmg5UTE2UFNBd09PODM4bWxyRWVC?=
 =?utf-8?B?MU5EY3JUelM4dDNFMjhnUnFjazY0YSt4bm1JMlYvZnpKaWk4YnNEVDEreGVs?=
 =?utf-8?B?V0VIT3BTRVhjcklwRytheU9RaGpybVBGYUtxaE1OT3hHUlBsOUw2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e868a8-a20a-49ee-bb27-08de80ddf3e7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:53:10.2450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAfM/vfSyXBSbn/bIJUcmf4QMt0FJOTjbqwiMcU6ZehS+wRl6Om2o9GWnOPB/1RsDcmvszbA+aGyLio6njbX5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9116
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


On 13-03-2026 02:20 pm, Tvrtko Ursulin wrote:
>
> On 13/03/2026 08:43, Khatri, Sunil wrote:
>>
>> On 13-03-2026 02:07 pm, Tvrtko Ursulin wrote:
>>>
>>> On 13/03/2026 07:21, Sunil Khatri wrote:
>>>> An extra dma_fence_put() can drop the last reference to a fence 
>>>> while it is
>>>> still attached to a dma_resv object. This frees the fence 
>>>> prematurely via
>>>> dma_fence_release() while other users still hold the pointer.
>>>>
>>>> Later accesses through dma_resv iteration may then operate on the 
>>>> freed
>>>> fence object, leading to refcount underflow warnings and potential 
>>>> hangs
>>>> when walking reservation fences.
>>>>
>>>> Fix this by correcting the fence lifetime so the dma_resv object 
>>>> retains a
>>>> valid reference until it is done with the fence.
>>>>
>>>> [   31.133803] refcount_t: underflow; use-after-free.
>>>> [   31.133805] WARNING: lib/refcount.c:28 at 
>>>> refcount_warn_saturate+0x58/0x90, CPU#18: kworker/u96:1/188
>>>> [   31.133815] Modules linked in: snd_seq_dummy snd_hrtimer qrtr 
>>>> binfmt_misc nls_iso8859_1 snd_hda_codec_alc882 
>>>> snd_hda_codec_realtek_lib snd_hda_codec_generic 
>>>> snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel amd_atl 
>>>> snd_hda_codec intel_rapl_msr intel_rapl_common amdgpu snd_hda_core 
>>>> snd_intel_dspcfg amdxcp snd_intel_sdw_acpi 
>>>> drm_panel_backlight_quirks snd_hwdep gpu_sched drm_buddy snd_pcm 
>>>> drm_ttm_helper ttm drm_exec drm_suballoc_helper snd_seq_midi 
>>>> drm_client_lib snd_seq_midi_event drm_display_helper snd_rawmidi 
>>>> cec snd_seq edac_mce_amd ghash_clmulni_intel snd_seq_device 
>>>> aesni_intel rc_core drm_kms_helper gigabyte_wmi snd_timer wmi_bmof 
>>>> rapl k10temp video i2c_piix4 snd i2c_smbus input_leds soundcore 
>>>> joydev ccp mac_hid sch_fq_codel msr parport_pc ppdev lp parport drm 
>>>> efi_pstore nfnetlink dmi_sysfs autofs4 hid_generic usbhid hid nvme 
>>>> igb ahci i2c_algo_bit dca libahci nvme_core wmi
>>>> [   31.133932] CPU: 18 UID: 0 PID: 188 Comm: kworker/u96:1 Not 
>>>> tainted 6.19.0-amd-staging-drm-next #28 PREEMPT(voluntary)
>>>> [   31.133937] Hardware name: Gigabyte Technology Co., Ltd. X570 
>>>> AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
>>>> [   31.133940] Workqueue: sdma1 drm_sched_run_job_work [gpu_sched]
>>>> [   31.133951] RIP: 0010:refcount_warn_saturate+0x58/0x90
>>>> [   31.133955] Code: 74 2f 83 fe 01 75 38 48 8d 3d a4 2c 91 01 67 
>>>> 48 0f b9 3a eb 36 48 8d 3d a6 2c 91 01 67 48 0f b9 3a eb 28 48 8d 
>>>> 3d a8 2c 91 01 <67> 48 0f b9 3a eb 1a 48 8d 3d aa 2c 91 01 67 48 0f 
>>>> b9 3a eb 0c 48
>>>> [   31.133959] RSP: 0018:ffffca16807dfd68 EFLAGS: 00010246
>>>> [   31.133962] RAX: ffff89e988f05600 RBX: 0000000000000000 RCX: 
>>>> 0000000000000000
>>>> [   31.133965] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 
>>>> ffffffffa1fd2f30
>>>> [   31.133967] RBP: ffffca16807dfd68 R08: 0000000000000000 R09: 
>>>> 0000000000000000
>>>> [   31.133969] R10: 0000000000000000 R11: 0000000000000000 R12: 
>>>> ffff89e98edf1308
>>>> [   31.133971] R13: ffff89e9d3001380 R14: ffff89e9dab5f800 R15: 
>>>> ffff89e9dab5f880
>>>> [   31.133974] FS:  0000000000000000(0000) 
>>>> GS:ffff89ed0cc3e000(0000) knlGS:0000000000000000
>>>> [   31.133976] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   31.133979] CR2: 00007f3050081c28 CR3: 0000000117f06000 CR4: 
>>>> 0000000000350ef0
>>>> [   31.133982] Call Trace:
>>>> [   31.133985]  <TASK>
>>>> [   31.133989]  drm_sched_entity_pop_job+0x414/0x420 [gpu_sched]
>>>> [   31.133997]  drm_sched_run_job_work+0x15f/0x3c0 [gpu_sched]
>>>> [   31.134003]  process_scheduled_works+0x1f0/0x450
>>>> [   31.134011]  worker_thread+0x27f/0x370
>>>> [   31.134016]  kthread+0x1ed/0x210
>>>> [   31.134020]  ? __pfx_worker_thread+0x10/0x10
>>>> [   31.134023]  ? srso_return_thunk+0x5/0x5f
>>>> [   31.134027]  ? __pfx_kthread+0x10/0x10
>>>> [   31.134031]  ret_from_fork+0x10f/0x1b0
>>>> [   31.134035]  ? __pfx_kthread+0x10/0x10
>>>> [   31.134039]  ret_from_fork_asm+0x1a/0x30
>>>> [   31.134047]  </TASK>
>>>> [   31.134049] ---[ end trace 0000000000000000 ]---
>>>> ...
>>>> [   56.544104] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! 
>>>> [glxgears:cs0:3483]
>>>> [   56.544108] Modules linked in: snd_seq_dummy snd_hrtimer qrtr 
>>>> binfmt_misc nls_iso8859_1 snd_hda_codec_alc882 
>>>> snd_hda_codec_realtek_lib snd_hda_codec_generic 
>>>> snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel amd_atl 
>>>> snd_hda_codec intel_rapl_msr intel_rapl_common amdgpu snd_hda_core 
>>>> snd_intel_dspcfg amdxcp snd_intel_sdw_acpi 
>>>> drm_panel_backlight_quirks snd_hwdep gpu_sched drm_buddy snd_pcm 
>>>> drm_ttm_helper ttm drm_exec drm_suballoc_helper snd_seq_midi 
>>>> drm_client_lib snd_seq_midi_event drm_display_helper snd_rawmidi 
>>>> cec snd_seq edac_mce_amd ghash_clmulni_intel snd_seq_device 
>>>> aesni_intel rc_core drm_kms_helper gigabyte_wmi snd_timer wmi_bmof 
>>>> rapl k10temp video i2c_piix4 snd i2c_smbus input_leds soundcore 
>>>> joydev ccp mac_hid sch_fq_codel msr parport_pc ppdev lp parport drm 
>>>> efi_pstore nfnetlink dmi_sysfs autofs4 hid_generic usbhid hid nvme 
>>>> igb ahci i2c_algo_bit dca libahci nvme_core wmi
>>>> [   56.544166] CPU: 9 UID: 0 PID: 3483 Comm: glxgears:cs0 Tainted: 
>>>> G        W           6.19.0-amd-staging-drm-next #28 
>>>> PREEMPT(voluntary)
>>>> [   56.544170] Tainted: [W]=WARN
>>>> [   56.544171] Hardware name: Gigabyte Technology Co., Ltd. X570 
>>>> AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
>>>> [   56.544172] RIP: 0010:dma_resv_iter_walk_unlocked+0x4e/0x180
>>>> [   56.544179] Code: 45 31 ed eb 0e 41 8b 46 08 41 3b 46 18 0f 83 
>>>> 23 01 00 00 49 8b 46 10 48 85 c0 74 20 48 8d 78 38 b9 ff ff ff ff 
>>>> f0 0f c1 48 38 <83> f9 01 75 07 e8 78 ce ff ff eb 06 0f 8c e3 00 00 
>>>> 00 41 8b 46 1c
>>>> [   56.544180] RSP: 0018:ffffca16865bb870 EFLAGS: 00000217
>>>> [   56.544182] RAX: ffff89e997f38d80 RBX: 0000000000000005 RCX: 
>>>> 0000000000000006
>>>> [   56.544183] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
>>>> ffff89e997f38db8
>>>> [   56.544184] RBP: ffffca16865bb898 R08: 0000000000000000 R09: 
>>>> 0000000000000000
>>>> [   56.544185] R10: 0000000000000000 R11: 0000000000000000 R12: 
>>>> ffffca16865bb8c0
>>>> [   56.544186] R13: 0000000000000000 R14: ffffca16865bb8a8 R15: 
>>>> ffff89e997f38d80
>>>> [   56.544187] FS:  00007f8f8d3ff6c0(0000) 
>>>> GS:ffff89ed0c9fe000(0000) knlGS:0000000000000000
>>>> [   56.544189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>> [   56.544190] CR2: 00007f8f9b735020 CR3: 0000000117f06000 CR4: 
>>>> 0000000000350ef0
>>>> [   56.544191] Call Trace:
>>>> [   56.544193]  <TASK>
>>>> [   56.544197]  dma_resv_wait_timeout+0x55/0x190
>>>> [   56.544202]  amdgpu_bo_kmap+0x3a/0xa0 [amdgpu]
>>>> [   56.544502]  amdgpu_userq_fence_read_wptr+0x130/0x2e0 [amdgpu]
>>>> [   56.544670]  amdgpu_userq_signal_ioctl+0x1f6/0x5e0 [amdgpu]
>>>> [   56.544847]  ? srso_return_thunk+0x5/0x5f
>>>> [   56.544851]  ? amdgpu_userq_wait_ioctl+0xab7/0xb80 [amdgpu]
>>>> [   56.545021]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>> [   56.545190]  drm_ioctl_kernel+0xd9/0x150 [drm]
>>>> [   56.545222]  drm_ioctl+0x29a/0x4a0 [drm]
>>>> [   56.545245]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>>>> [   56.545422]  ? srso_return_thunk+0x5/0x5f
>>>> [   56.545426]  amdgpu_drm_ioctl+0x46/0x90 [amdgpu]
>>>> [   56.545595]  __se_sys_ioctl+0x73/0xd0
>>>> [   56.545600]  __x64_sys_ioctl+0x1d/0x30
>>>> [   56.545602]  x64_sys_call+0x1715/0x2d00
>>>> [   56.545604]  do_syscall_64+0x7c/0x6a0
>>>> [   56.545608]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
>>>> [   56.545778]  ? srso_return_thunk+0x5/0x5f
>>>> [   56.545781]  ? amdgpu_drm_ioctl+0x6c/0x90 [amdgpu]
>>>> [   56.545950]  ? srso_return_thunk+0x5/0x5f
>>>>
>>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +-----
>>>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/ 
>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> index 146ca6d7f4f5..442c08b69f7c 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>>>> @@ -882,12 +882,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>                    * be good for now
>>>>                    */
>>>>                   r = dma_fence_wait(fences[i], true);
>>>> -                if (r) {
>>>> -                    dma_fence_put(fences[i]);
>>>> +                if (r)
>>>>                       goto free_fences;
>>>> -                }
>>>>   -                dma_fence_put(fences[i]);
>>>>                   continue;
>>>>               }
>>>>   @@ -909,7 +906,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>>>> *dev, void *data,
>>>>               fence_info[cnt].va = fence_drv->va;
>>>>               fence_info[cnt].value = fences[i]->seqno;
>>>>   -            dma_fence_put(fences[i]);
>>>>               /* Increment the actual userq fence count */
>>>>               cnt++;
>>>>           }
>>>
>>> I have to say the commit message confused me a bit, but the fix 
>>> looks correct. I say confused because isn't it a simple case of 
>>> amdgpu_userq_wait_ioctl() doing a potential double put? First one 
>>> when the dma_fence_wait() above fails or succeeds, and the second 
>>> one in the unwind loop. Which means it was me who broke it yet 
>>> again. :(
>>>
>>> Fixes: bea29bb0dd29 ("drm/amdgpu/userq: Consolidate wait ioctl exit 
>>> path")
>>>
>>> Right? But please double check because I am obviously having a bad 
>>> period.
>> Haha it happens and very easy to miss such things. But yes, this 
>> happens with that patch as it seems to be working fine for some time 
>> when i tested before. Yes that triggered that and doing the dma_put 
>> more in clean up too. It is getting fixes with this patch for sure.
>
> I forgot a:
>
> Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
>
> But please improve the commit message because the bug is much simpler 
> than it currently describes. Simple double put in all cases if I am 
> not blind.
Sure
>
> Btw does something from IGT catch these bugs?

IGT Still passes the test. I ran glxgears test with multiple threads, 
but i think a single thread should also catch this as it is seen every 
time. I run such with every commit i push in userq since there is no CI 
validation in userqueues yet.

Regards

Sunil Khatri

>
> Regards,
>
> Tvrtko
>
