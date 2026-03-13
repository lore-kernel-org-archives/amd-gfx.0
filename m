Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E80B105F7A4
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 12:13:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20FA910EBCB;
	Fri, 13 Mar 2026 12:13:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qaojDlkU";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4813010EBCB
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 12:13:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qmq4fjDAaHxmqkOlfkHOOKZGY0moI3DeJggv1+2WDsXN7N56COizgSwS2s5xzGsigoRmHIlb/9N7Px+o9BTU4syvyDjlPEBS+7gVkr79PQkzmMBWPw3vHp8mGLsC+MhpBY21TxTXO8bkr2H07ajKIxaLQ30Yll8IezbwVhL54r3CY9mcf5JQ6/Gk0sBpx7IDfhZknlME7XqZ00ARS4FsCu4Q3uDTiie8iGUjTdP74oBDwPu58HTRnqCLj4Cc21PVGQnpYJ6kZw/zFXcVqmNc+ClGCtgZRlyYgdL7gJkyAPz5M1sV0zrt1YTLjedWnKRrCpOzrEAh1STEuJFZXxFMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l1n0cOaJ72y8Y8r7sVYR/UskAvh1FiQ8va2dbEgi3JM=;
 b=aotD/u3b29HHm7ds1/tKoVzGkDIbSmFN7oy9YGK/UTDQRFKGMQRbSJetqm+7lnExeat980ZAb3D+reuj9AYjrQwBe7Tx2RiIk66cVqsdWUIaREUVNj5KLbCVY8bQHdrDAk3ThL0d8FuPJfR5y9hXW9YnDn25dbqlI8Hbp4dYNUsmt2hMD5u5+EFUd8bQI0mYJsOYHHyFpC65o6ukl4rZuL096NNQcnS0SkAQNGKtuJwmc2WF5/kI424StmfZ6+0y2WfXR5Dim0Z5hl0oCZA+2MsYN3eJYHMMeHF2ujWe3o9MFcynTU6/NAq9s38O7n7wERVDvGCHkVgRi+ieJt/f3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1n0cOaJ72y8Y8r7sVYR/UskAvh1FiQ8va2dbEgi3JM=;
 b=qaojDlkUnBDAGh4Bosts/0pNccw/CsLrS51mYuBkPA9zhqo3Y2qcc7OocgQGW5u+XVEZbZf9EyIbu6EsGrYj7qkukokwLGJI5CWBCiRBBk5tHrsv+r4i2CHQsE22vozW89BoLdPvgWZDqgHFuHkgNlUSp5456Km4X2VB7dS1sz0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by EAYPR12MB999155.namprd12.prod.outlook.com (2603:10b6:303:2be::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Fri, 13 Mar
 2026 12:13:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 12:13:35 +0000
Message-ID: <f21d56a4-eedd-4825-b4a2-7b5ffce6b9e0@amd.com>
Date: Fri, 13 Mar 2026 13:13:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] drm/amdgpu/userq: fix dma_fence refcount underflow
 in userq path
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260313072140.3327678-1-sunil.khatri@amd.com>
 <20260313072140.3327678-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260313072140.3327678-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0135.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|EAYPR12MB999155:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c8942b2-2f25-44c6-134a-08de80f9f34b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: iTZZo6a+0MHLLYMYx5J+hMVy9sKJ45F3bWUezNkO3485lRkBM3JAHSDxz5u58S0BFl+uIbqhbZmqfQwCWejDagf/yBA1nc2DYj+eMS7vq1qnVnNRRF8PKGZMtThHFaizSlRKzIHt5NUiuCa7cFfBNwjcLx2So3FaEFfcWYiI8MDIW553g5vgBKH1jEFGl/NZAOw4zd3y30CcOb+3z0LuPTZe1xkmdpE8cNvqXmYjFBMz88d7WxxbG/DdMoNnahj3UA3yjsE7bdV3flNNRuROAimD/QhZ5L8+7jlxQJj4lAx3iDxQjcfqtBFExWJU+8pgoofFrINgUPkBrn/dK7/TK2nI4BjQ7VvEJELI8TexxcAGl80wxZMXjW9JtrwTtE7YoKHNzOApu5GiOc2hBGxg9AmUV1YZr43NmHrHZNHkIB7atptC6ZMXSgvvRpN6C1nFghAlq0oPz80FS2ZEhmAfH1OHxZSupXCLhuHWpftHz3ikWk1y+TaIi/41DTFd/sbPHftqa6Kbx6vsTzvnzzAK4HF0MhmWGRGZwWfrJaCOszAu79xCSQJn9qL0ZfrWCqzcCZo9/jZ/Y49S+O+crLVPbAMkjrytJR3mVKVbw5Rku/RnhW10U6buki95CMLkZd8RAN3I9MgrY4FlBFqTKY1hlFYGUW4n6C9obJUJ44uOdKVRobpUFevh76hne43qEWd6CUnko4QNnn1+Wx7VscxxRiMbNNjYOvHrWBiBc0u1mkg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WkFvYWRYTk03NmFGdEtNY2hKaDB1NXhPMmUzaFdoeGR3QzltN3c2QkswcXBU?=
 =?utf-8?B?QnU5ZEE0dmppOTRTMnNrWU1nWjMxNTIvTXY5RWFlcGl0eGxHMTdFYkJVMjFH?=
 =?utf-8?B?Zy9xSEFWbjk1VXNsQVlXOWtkQkRSZVRRTXZJOHBHWUxTeElvM1BvZmx1WDJF?=
 =?utf-8?B?MWVlQ2I0OVBzWTJyTVl0R0N3R2krMC83eEtwdVRGVFpDUWtQTDNyQnA2cDl5?=
 =?utf-8?B?WDhxU0VjTjUyS3l1SjlzbGpIZXV4MC9hUjd3Z1pVRkVUV25jVHIveFFEYlhl?=
 =?utf-8?B?VjJXOTl5V1JxeFRMVHlRMmdMakVuMzBrZnkyRmFmd1VIbEJ3L1NtQTM5OVRs?=
 =?utf-8?B?MVhGSExKV25mQnpWYUJMTGx2N3V3ZThhTit3dEJyZkM5a1R5aWdaMU5Pb1RO?=
 =?utf-8?B?Y0UvbktMN3FSOGhCaUJoRGlIY0JvOUlsUkcwSzhVOUl2OC9xMjNoSjZaRkdD?=
 =?utf-8?B?dHNlWWhIQi9NUGdsS1Y0czlhUGsrVTc2NFQ5UVlzZUhGczQwaVUzTEgrSldI?=
 =?utf-8?B?ektMSmFTSUhoaXBmTEtWOHhJSU5VSElrNjMrdi9BTERFZXN6TXdWQWMwaTZ0?=
 =?utf-8?B?bnJPbFU5N0JNZjZxS2Ira29pNnkzQVpvNng2dFd3WU5LQ0paYmoyeDhaR0VV?=
 =?utf-8?B?Qm9wYjVHbkVHS0FVbWFLT04wTVZYQ3FJVlhFZnRFWWFFVFI1bUJ5ZnZ0emJp?=
 =?utf-8?B?TWZRWUxkYi9Mc0Y5TTN2alBKelFzeXJGVExhV1diY3BXRmg5TEdhdWRYZHZu?=
 =?utf-8?B?VFZGRjRVSm1oR2VHV3ZOamxyOG5Pc3hMQi9Dak5XNmgvMEtlL0ZyVkIvekxj?=
 =?utf-8?B?WEFXdHN0dUFrUUdoNUdIZnJXQ05Uci91Wmw1b3VXc0NoZDVwUmhTcHJFTG9Q?=
 =?utf-8?B?N080QlZQb1QxZ2R4cTdWSTBlT3VMc0NsTk1TUVBKTXNpdjliaVdVczdzMmpq?=
 =?utf-8?B?eFVoRlpBejJrK1lIMFBMdXM0UUJmaUZxclQ2RjU2SkxJNHF5N0tSTDViZzNF?=
 =?utf-8?B?MG9MWjg0KzVWYmx3cnBuREQwVllLV2J1MWY4S1QzSGV0eWJaRUUxRk9rcG1a?=
 =?utf-8?B?R2U5b0NaelNtK0hyQmdhcnplVUhXRXV6VXR1d1ZRTzdhaHhIZXR6Wnh6U2tn?=
 =?utf-8?B?U1pDdk51eDV3UWExa2Voayt6V0lNaUJXSE5JcHJ6Q2c3b2NRV1Y4MmFGU1hp?=
 =?utf-8?B?eEdQMG9zdXBERUtiOVlqSkMxeS80U1M2N2c5WE15eXk2YnFLRXRUZ040Vmsx?=
 =?utf-8?B?b080UjROeDk2eVBKQ1QvSkR6OEN3R3ZWdFNTV0RKR05LZGtPeXA1K282NDlI?=
 =?utf-8?B?V0h1czIyc2g2VVQ5TzFDSFJvTzAzUWdwT0JvTTE5Rk56R29mcXlkcVNobGpT?=
 =?utf-8?B?a0FHWHo1VEh0U3VNZDhPMlEybUFiRkQ5WmZ1ZWljVmliY3JpaG9XN3pMc1lw?=
 =?utf-8?B?Sy9yZ1NudWFsNDB3NU9kcHduSko1bW03bmFvSUJWWEN3VS84RW5lNUNPUEVR?=
 =?utf-8?B?YTJVZnM3eSt6SUUzOUpjNU55WnRjaU82Y0MyS2d1K1NJVWNyaUEzQXJHWk04?=
 =?utf-8?B?Snc3MUtVR05adHFLOTA5a3IxVnpDNEpJdXZ0bGRmQjZGRXdBN0hjMHZXSzJC?=
 =?utf-8?B?WEViZlYyQ3lEQTZpam9jcG9zZnhvdncrbkJ1WE9QZXlseXNHWXBrNjN3UjlB?=
 =?utf-8?B?cEtEZWFsWVoxcktXb1pJTXQrWUdwTWk1STBabFRpQURWOERjdXdZOElvZDJv?=
 =?utf-8?B?ckZWcjF2Nk1wa1l4cURySVVqMngraU9xQTR1OWpLNXZMbWZ5ai9jNncwYWJy?=
 =?utf-8?B?MmVYUG1wd0E0ZzF5aGhWaW9sZ0g1bjVSUUQ2UERzbVRjV0ZKUkJVZmN1aldt?=
 =?utf-8?B?SHp5dU1SZWlDMTNIS05PZjd3OU5MNU10SlVRanZ1NjhxTXduZW9Zc0JLM3B5?=
 =?utf-8?B?UHNpOGo3MVFMZVFXem5ZLzIyd1lyTlFKaFpzb1Z1YkhaUlNuRUdTaGdFdzNC?=
 =?utf-8?B?elFrSWxLWjV4cWVERlNZdERuY29GejYxbFZJbkxJVXF4cUg3MDJxbXY3S0Q1?=
 =?utf-8?B?R2hkaHB5VlRiY1FSUEl6QW05QlF0NHlyaHJyUlpIRGF6dFFWRGhMbHJYWHFk?=
 =?utf-8?B?UW1mNy93REFvVXU2ZGRtM1F6RDFMSzB2Ky9VOTVWY05GckV6eUdBaitVMEFz?=
 =?utf-8?B?U0J2eTRhN0hLRVl4VlFueG1rMWJJWVJPSHVZUi8wWVpuNmduaG53WTh2dFMw?=
 =?utf-8?B?OHRGZkRPSjVEeGF4MkFHYmFheXRISXZPRC91ZWZ1dVFZQzJsV0xHTUU5NkNC?=
 =?utf-8?Q?z95J8Z47GLCjKjBN1G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c8942b2-2f25-44c6-134a-08de80f9f34b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 12:13:35.1668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmV2jGO0VR5iWZJsHysPt5QETbZpVuCQ8yf+9UHKUh0M392iPjWqChKrg/KjtHAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR12MB999155
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

On 3/13/26 08:21, Sunil Khatri wrote:
> An extra dma_fence_put() can drop the last reference to a fence while it is
> still attached to a dma_resv object. This frees the fence prematurely via
> dma_fence_release() while other users still hold the pointer.
> 
> Later accesses through dma_resv iteration may then operate on the freed
> fence object, leading to refcount underflow warnings and potential hangs
> when walking reservation fences.
> 
> Fix this by correcting the fence lifetime so the dma_resv object retains a
> valid reference until it is done with the fence.
> 
> [   31.133803] refcount_t: underflow; use-after-free.
> [   31.133805] WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x58/0x90, CPU#18: kworker/u96:1/188
> [   31.133815] Modules linked in: snd_seq_dummy snd_hrtimer qrtr binfmt_misc nls_iso8859_1 snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel amd_atl snd_hda_codec intel_rapl_msr intel_rapl_common amdgpu snd_hda_core snd_intel_dspcfg amdxcp snd_intel_sdw_acpi drm_panel_backlight_quirks snd_hwdep gpu_sched drm_buddy snd_pcm drm_ttm_helper ttm drm_exec drm_suballoc_helper snd_seq_midi drm_client_lib snd_seq_midi_event drm_display_helper snd_rawmidi cec snd_seq edac_mce_amd ghash_clmulni_intel snd_seq_device aesni_intel rc_core drm_kms_helper gigabyte_wmi snd_timer wmi_bmof rapl k10temp video i2c_piix4 snd i2c_smbus input_leds soundcore joydev ccp mac_hid sch_fq_codel msr parport_pc ppdev lp parport drm efi_pstore nfnetlink dmi_sysfs autofs4 hid_generic usbhid hid nvme igb ahci i2c_algo_bit dca libahci nvme_core wmi
> [   31.133932] CPU: 18 UID: 0 PID: 188 Comm: kworker/u96:1 Not tainted 6.19.0-amd-staging-drm-next #28 PREEMPT(voluntary)
> [   31.133937] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
> [   31.133940] Workqueue: sdma1 drm_sched_run_job_work [gpu_sched]
> [   31.133951] RIP: 0010:refcount_warn_saturate+0x58/0x90
> [   31.133955] Code: 74 2f 83 fe 01 75 38 48 8d 3d a4 2c 91 01 67 48 0f b9 3a eb 36 48 8d 3d a6 2c 91 01 67 48 0f b9 3a eb 28 48 8d 3d a8 2c 91 01 <67> 48 0f b9 3a eb 1a 48 8d 3d aa 2c 91 01 67 48 0f b9 3a eb 0c 48
> [   31.133959] RSP: 0018:ffffca16807dfd68 EFLAGS: 00010246
> [   31.133962] RAX: ffff89e988f05600 RBX: 0000000000000000 RCX: 0000000000000000
> [   31.133965] RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffffa1fd2f30
> [   31.133967] RBP: ffffca16807dfd68 R08: 0000000000000000 R09: 0000000000000000
> [   31.133969] R10: 0000000000000000 R11: 0000000000000000 R12: ffff89e98edf1308
> [   31.133971] R13: ffff89e9d3001380 R14: ffff89e9dab5f800 R15: ffff89e9dab5f880
> [   31.133974] FS:  0000000000000000(0000) GS:ffff89ed0cc3e000(0000) knlGS:0000000000000000
> [   31.133976] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.133979] CR2: 00007f3050081c28 CR3: 0000000117f06000 CR4: 0000000000350ef0
> [   31.133982] Call Trace:
> [   31.133985]  <TASK>
> [   31.133989]  drm_sched_entity_pop_job+0x414/0x420 [gpu_sched]
> [   31.133997]  drm_sched_run_job_work+0x15f/0x3c0 [gpu_sched]
> [   31.134003]  process_scheduled_works+0x1f0/0x450
> [   31.134011]  worker_thread+0x27f/0x370
> [   31.134016]  kthread+0x1ed/0x210
> [   31.134020]  ? __pfx_worker_thread+0x10/0x10
> [   31.134023]  ? srso_return_thunk+0x5/0x5f
> [   31.134027]  ? __pfx_kthread+0x10/0x10
> [   31.134031]  ret_from_fork+0x10f/0x1b0
> [   31.134035]  ? __pfx_kthread+0x10/0x10
> [   31.134039]  ret_from_fork_asm+0x1a/0x30
> [   31.134047]  </TASK>
> [   31.134049] ---[ end trace 0000000000000000 ]---
> ...
> [   56.544104] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [glxgears:cs0:3483]
> [   56.544108] Modules linked in: snd_seq_dummy snd_hrtimer qrtr binfmt_misc nls_iso8859_1 snd_hda_codec_alc882 snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_atihdmi snd_hda_codec_hdmi snd_hda_intel amd_atl snd_hda_codec intel_rapl_msr intel_rapl_common amdgpu snd_hda_core snd_intel_dspcfg amdxcp snd_intel_sdw_acpi drm_panel_backlight_quirks snd_hwdep gpu_sched drm_buddy snd_pcm drm_ttm_helper ttm drm_exec drm_suballoc_helper snd_seq_midi drm_client_lib snd_seq_midi_event drm_display_helper snd_rawmidi cec snd_seq edac_mce_amd ghash_clmulni_intel snd_seq_device aesni_intel rc_core drm_kms_helper gigabyte_wmi snd_timer wmi_bmof rapl k10temp video i2c_piix4 snd i2c_smbus input_leds soundcore joydev ccp mac_hid sch_fq_codel msr parport_pc ppdev lp parport drm efi_pstore nfnetlink dmi_sysfs autofs4 hid_generic usbhid hid nvme igb ahci i2c_algo_bit dca libahci nvme_core wmi
> [   56.544166] CPU: 9 UID: 0 PID: 3483 Comm: glxgears:cs0 Tainted: G        W           6.19.0-amd-staging-drm-next #28 PREEMPT(voluntary)
> [   56.544170] Tainted: [W]=WARN
> [   56.544171] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
> [   56.544172] RIP: 0010:dma_resv_iter_walk_unlocked+0x4e/0x180
> [   56.544179] Code: 45 31 ed eb 0e 41 8b 46 08 41 3b 46 18 0f 83 23 01 00 00 49 8b 46 10 48 85 c0 74 20 48 8d 78 38 b9 ff ff ff ff f0 0f c1 48 38 <83> f9 01 75 07 e8 78 ce ff ff eb 06 0f 8c e3 00 00 00 41 8b 46 1c
> [   56.544180] RSP: 0018:ffffca16865bb870 EFLAGS: 00000217
> [   56.544182] RAX: ffff89e997f38d80 RBX: 0000000000000005 RCX: 0000000000000006
> [   56.544183] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff89e997f38db8
> [   56.544184] RBP: ffffca16865bb898 R08: 0000000000000000 R09: 0000000000000000
> [   56.544185] R10: 0000000000000000 R11: 0000000000000000 R12: ffffca16865bb8c0
> [   56.544186] R13: 0000000000000000 R14: ffffca16865bb8a8 R15: ffff89e997f38d80
> [   56.544187] FS:  00007f8f8d3ff6c0(0000) GS:ffff89ed0c9fe000(0000) knlGS:0000000000000000
> [   56.544189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   56.544190] CR2: 00007f8f9b735020 CR3: 0000000117f06000 CR4: 0000000000350ef0
> [   56.544191] Call Trace:
> [   56.544193]  <TASK>
> [   56.544197]  dma_resv_wait_timeout+0x55/0x190
> [   56.544202]  amdgpu_bo_kmap+0x3a/0xa0 [amdgpu]
> [   56.544502]  amdgpu_userq_fence_read_wptr+0x130/0x2e0 [amdgpu]
> [   56.544670]  amdgpu_userq_signal_ioctl+0x1f6/0x5e0 [amdgpu]
> [   56.544847]  ? srso_return_thunk+0x5/0x5f
> [   56.544851]  ? amdgpu_userq_wait_ioctl+0xab7/0xb80 [amdgpu]
> [   56.545021]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [   56.545190]  drm_ioctl_kernel+0xd9/0x150 [drm]
> [   56.545222]  drm_ioctl+0x29a/0x4a0 [drm]
> [   56.545245]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
> [   56.545422]  ? srso_return_thunk+0x5/0x5f
> [   56.545426]  amdgpu_drm_ioctl+0x46/0x90 [amdgpu]
> [   56.545595]  __se_sys_ioctl+0x73/0xd0
> [   56.545600]  __x64_sys_ioctl+0x1d/0x30
> [   56.545602]  x64_sys_call+0x1715/0x2d00
> [   56.545604]  do_syscall_64+0x7c/0x6a0
> [   56.545608]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
> [   56.545778]  ? srso_return_thunk+0x5/0x5f
> [   56.545781]  ? amdgpu_drm_ioctl+0x6c/0x90 [amdgpu]
> [   56.545950]  ? srso_return_thunk+0x5/0x5f
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the entire series.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 146ca6d7f4f5..442c08b69f7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -882,12 +882,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  				 * be good for now
>  				 */
>  				r = dma_fence_wait(fences[i], true);
> -				if (r) {
> -					dma_fence_put(fences[i]);
> +				if (r)
>  					goto free_fences;
> -				}
>  
> -				dma_fence_put(fences[i]);
>  				continue;
>  			}
>  
> @@ -909,7 +906,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
>  			fence_info[cnt].va = fence_drv->va;
>  			fence_info[cnt].value = fences[i]->seqno;
>  
> -			dma_fence_put(fences[i]);
>  			/* Increment the actual userq fence count */
>  			cnt++;
>  		}

