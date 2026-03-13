Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 352FA106FD9D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 08:43:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5DCF10EB34;
	Fri, 13 Mar 2026 08:43:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CBHOFBnn";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013001.outbound.protection.outlook.com
 [40.107.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA4A10EB34
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 08:43:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUIjJBSCjvUyr1zPhE37HebXv4WcemeWsH/oFSaKPXGA93ZK18WmdsdIjuMNtkdqX7y85R+n/fd6psYZ20Tj6hGwpEZOogsDhhTAF/Pxqaetj3q/9YM4oWhtMgkp+wS3Dc0MUWKG1Gmz7/611cM1iH9BSZ3vOybuqGUiPJ/y38L8H2XjTV3/WaTCWjubxvPzKjbANMxYq2ebB3Ps91sLzsafQYL90xmIpliIsIAhGP+r5d19QbieGVdqtY3iep5UFqqAg3SudjD7YCNFaAYxJk9UcCUnAYNp0gxJTKm2SyGjfvEI+0IVt9VkMt5NPcXKJEapbkMF2qKT6jabN2NXNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m8eqdizTpAIPteL7GxUYcg9zI6JBKD4alNatB4LqUY=;
 b=Bki+ld3+ZW8yRSTLce35kX2+7r7NXDjdPTmG+e14Ph9WS4TguaoypCOLsNi69W2TOm8iT3A7vhL7mRw4sAh7ewtTrYjZqXVih+I3ACxXotQpnaNRT71iU1JJnV5oaX5WAyaEzW22xZO/Bz8U6hxOOPYohzd8RPrnS+8z7/5Cd9QB5RIbrkh0Xd1+jQnxaK/hkwnLLTR5urlWV4fLqt9jRJzpxuXcVXfMKbZHNUorur4pkcn0NEUnfeXcWWMMOkbRVgYerdixwxxGl9pmcNMcNpdxm+BVWymyHWuVfcPWpdyh3K0eP1OXKUXL3jQjyymiAcWPJGt7gam2Yswrn3P+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m8eqdizTpAIPteL7GxUYcg9zI6JBKD4alNatB4LqUY=;
 b=CBHOFBnn4WSk7P1m+gsPL5v993x/RojwDq56I3ZtdjMYFvY9aGjMrsT1TkQeVwKrSEn0hKXD0xZPWhRjlYB7f8i+YC/0AT2sfbIK5tT9lH9Hco5n8ripfDc7hB2tnF7xUb8wkq4GqRECTwgs8Z+HAa5YyyrNtNuoxP4C/QwcRIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.6; Fri, 13 Mar
 2026 08:43:06 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9700.009; Fri, 13 Mar 2026
 08:43:06 +0000
Message-ID: <86643e4a-15fb-414a-a06a-a3936413696b@amd.com>
Date: Fri, 13 Mar 2026 14:13:00 +0530
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
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <344dec42-00b1-4870-9f09-8b5fae61878b@ursulin.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0098.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: c07ba6af-a691-4264-60d3-08de80dc8bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: MyKrjbkZnVtmrMWid5csezVBeJrNmMV2n/3CaZtIA9mjueukPisfXcVg4+b9nHNioDx+utl90+5J00YCxxVha6t5Oq6+qRlKfxpDF5WAW6b6iPcmXQP4/p34v7EDdiJa2JMXKEGB1G6YlbkLqFnn7gac1X6ele6VrhPL6WnpbbDhQFOmbTvJFjplpnce4PSJCl55c4OfdEYLHWr3RSC3boibkuX5dAFd2tx2BR6C4w/knIEdiDqQpI0vV63KdkrpWe4hqysf7GZL60RrVLXx9N+agn51bUoasjwaiHQjLftRgQO9nlPMkpoDFFsresAtz22TxNo/58Cy6gPxFJNuhi5fjmpFQNnxyIeBBx/sMz69CCTYy2ejEvlnjtrtWglk71Ynbo3qU+r8J0eIo/motDcY+Ooh3IMJchp3Ei/WNW55XIfNKU8Yrt8hvPxZRDUrp1V7RfQWtOxYapzefd5tlOKS7dyXpqHzRPDScrHIuR+pHeUjlL0zEUEu0x/rEwCelrVHpoZn04p2oLSj4yrqvMUvXRbTIND0Z3FRMFRYbsZacPY0SmXhL5gYFlJBV/wbVwb2iN2ATPm9u2tKrIw/76Fyg67U8mYRpTa+2RXh8QAd+wRRLQSbryWLY2GoZgBwjXuted00QmIF+YqWzgE5ssqbk2IUR+3emVn4OnEQJYtPcbsuNPI0hu+s+PBWn1F3XyjumEOxlD+KpS8PsMqJpst7YcYOJqBgl6za4gWh/IA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWRtdjNFVS96MUxwYXhvZUhHcHJ6MmtWTUpnMnUxckpnb3I1bUUwY2xDaFNy?=
 =?utf-8?B?Nzh0Zy9JMUU3alJwenVMcG55VC9PNVVjUWFsTVJaMlRwcTExTUgrNXVqNGYy?=
 =?utf-8?B?eUJWNFVRYTlYUUZXbThxelZLVCtVSlhma2lVUmFNQWFZWkx2NlB3cWVJZGwr?=
 =?utf-8?B?azNqTG12aG1iYVV6Zm1JUldDVGhiMGlpQmVpTldCcmw2ZEg2TEZpZitkNEhq?=
 =?utf-8?B?NVZKMURxeTIvZVpPOVluVEpnbEd0QTF6R3RtL2d0djlQallXZE1mRWFNeDVv?=
 =?utf-8?B?SDNRY3JaaGFYNEd1WVlyTlkxN1lrSmhBcDl2NVZWYkVtakx5ZlpKWmd1U1g1?=
 =?utf-8?B?Y0lGaDFWQ2VNTmJKOVJvaFVtNXd3V1Z1SURLZDErVFJKdUpidjh0dDBNeitC?=
 =?utf-8?B?ZkFkY0J6djNFSEtKYWZneWJab2k3aU1qR1NlcVpVMGxuV3lZdEQ5YlpwSzBK?=
 =?utf-8?B?R1pabUNVRWNwZDQzUDAwSVh6cGhWaTBRS0wzajFvbHZiR0JFT2wvaVZ4Qy9E?=
 =?utf-8?B?VExpaDI5cjcrdVYxTVVpSUZNb1NHZEdkUjBmeFNweXE0Znpxd0NWSVE1ZEY5?=
 =?utf-8?B?aHVlb210WksxNStmcmVac2VMd2dFR2hVWk9tamxpRWJMUkErMnFUUXU2VEhl?=
 =?utf-8?B?NTVQbUNOYU1rbGpkT0FlSTJqSTVGSUZucnk5Wmk5OHhYSGpOZDJmMldkK2NQ?=
 =?utf-8?B?YklobDc4a2lwbnhSSjlFeEFvTk5iUUJieFprOTlxWm9CN0xRTUNJdVdGZE0v?=
 =?utf-8?B?dGs3ZXRLM2xOMWdBWmhqS0FoMlVkUmtvcnJvSCs0UkN4cnk2blQzQnJicmZU?=
 =?utf-8?B?bWl3enFDRDBQZkZDWFptejUvRCs5MjBZWFlJWi9OeVR1Zy8xMUpTS3hNMnJy?=
 =?utf-8?B?dnBFZHlCQVZOTWZaTHR2RGNybnR3aG9CWXpiNHZTbmsyRitOaWtBdTN3R1Vz?=
 =?utf-8?B?ZFYxdUswMXUxRXZ5YWxieFc0YVZybVNPLy9xYnhLVnhhNlhUT1NKZlUxVjl1?=
 =?utf-8?B?dWhuQUlmOTVQUno1azN0dk91VnFpRjlNSk5GejBPa1VaejZIM1krL2lsY2dF?=
 =?utf-8?B?RElyZVZ5R1dEcDB5MDJtRm0vVTBocjEzU0ZSTVJTam0zQnNlNko1azFjaFhr?=
 =?utf-8?B?dUVpREx3ck5xTHl0ek9ZVVN5eHNFSHByVGdIWWdpRkVpSUhGVnNTb0VzR1Qx?=
 =?utf-8?B?YlFURFV0QTNYVVB3bEZsV0U0YVFNMHBVdUhQR3F2VS9TRGt5Y0VxWlNhYzNV?=
 =?utf-8?B?ZFdGTno2Rmk1U3p4SFdaalZrQ3pwdmJoTXoybkM1eWoxb2pST3JFcnNWaHk5?=
 =?utf-8?B?bWhKbGpVZ1RqU3lIT2h5TFNMdWJMWmpyaWFaVGlxWWhiTlZSQ044Vjl6YTVN?=
 =?utf-8?B?eUtQVTMwbGErN1hvaFNmNnBxcExTYjJ3dTVMejJMcFA4ZnhoQk9yK3JXYkxY?=
 =?utf-8?B?TURFeTZsaGgwM1locFZRYlNZNm0rWjBLODYyNDBGMmJ5NnFHaC96RzlFSTV5?=
 =?utf-8?B?VFVQbXExd0hJSXZyWXgzb0ZnbUgramphVHVmVWxLVUVoblhrQk9PTk1UZzdV?=
 =?utf-8?B?dUs4dGtNUmlzZVQvK0J2dnhIMHZ0UTRoVDdlOWdyTE5uMkZIam5qVnhZblR5?=
 =?utf-8?B?K3VBUjlMamNsZGJNb3dVcEIzNGh0L3NCWTBPWlo2VXcya3d2OStJVFlQNCtJ?=
 =?utf-8?B?aTVJRzVTcmYvalhLR2xUS2pyRXRUSENTUUZIV2M1V3YvbXJsT1dvWDJseSta?=
 =?utf-8?B?ZWZTbjlmeXhHUVB4VUhBTkVYVW1oa3FudzNSUlR3bGcvNFVxcHMrM2N3MWk0?=
 =?utf-8?B?LzZMak4xNDdxSTh1RmpFKzBLRE0rdG9YSHJkeGFvQUd6RGMwSDFyd2VJWmUv?=
 =?utf-8?B?Tjg3bFkwWHBWOVRtWlY2KzcvWjQzZ0lrcGJNUWRLcGROS0pSZE9ITUYrM1VW?=
 =?utf-8?B?azdSQkplVWFyRjgrdWt6RFNKZ29UclVGVzh4TCtvRHNNb1FDQjVNV1lBK1Fn?=
 =?utf-8?B?L1NiTXdiTU10amh1b0MwOE5KK3ZvS3B0Ylpid0hTMGk5SWFPQ0xFZDhYTlc2?=
 =?utf-8?B?enFJY05nMFQ3QnBGTHFzWUR0Nm0xOHl1ZExIQzRsbGhSdlRGUkdkc1ErYmFT?=
 =?utf-8?B?bXVFeGhGaUoxaEsxOHhHOUtaTUJBaUp1bU13aUMxOUN2RlFrb3JVbjFFSDJQ?=
 =?utf-8?B?RWFkME52QnYyTVpmTzFaWmJveGtvUUFGZHBhWHVSc2lrWUpWS2tJTmxFV2pZ?=
 =?utf-8?B?alo0K3RxaDUxS2t2c1VaNlg3aGJKZ3krTUwyQ0hoUmx6bzJPUVdycEJHc2pu?=
 =?utf-8?B?VXpxSTJkbUQycUQ5TGorQm4vYXIvaGZzWTZnbWljQ0tLSU9TUXlaUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07ba6af-a691-4264-60d3-08de80dc8bad
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 08:43:06.0980 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1deo520RO+ZKReNOSt0o390Lw97AhGpNmtVMCjaWIXMeM6KYWsXkvweT5+9LwIiT0+nEnztadqCVDWtqOH/NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085
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


On 13-03-2026 02:07 pm, Tvrtko Ursulin wrote:
>
> On 13/03/2026 07:21, Sunil Khatri wrote:
>> An extra dma_fence_put() can drop the last reference to a fence while 
>> it is
>> still attached to a dma_resv object. This frees the fence prematurely 
>> via
>> dma_fence_release() while other users still hold the pointer.
>>
>> Later accesses through dma_resv iteration may then operate on the freed
>> fence object, leading to refcount underflow warnings and potential hangs
>> when walking reservation fences.
>>
>> Fix this by correcting the fence lifetime so the dma_resv object 
>> retains a
>> valid reference until it is done with the fence.
>>
>> [   31.133803] refcount_t: underflow; use-after-free.
>> [   31.133805] WARNING: lib/refcount.c:28 at 
>> refcount_warn_saturate+0x58/0x90, CPU#18: kworker/u96:1/188
>> [   31.133815] Modules linked in: snd_seq_dummy snd_hrtimer qrtr 
>> binfmt_misc nls_iso8859_1 snd_hda_codec_alc882 
>> snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_atihdmi 
>> snd_hda_codec_hdmi snd_hda_intel amd_atl snd_hda_codec intel_rapl_msr 
>> intel_rapl_common amdgpu snd_hda_core snd_intel_dspcfg amdxcp 
>> snd_intel_sdw_acpi drm_panel_backlight_quirks snd_hwdep gpu_sched 
>> drm_buddy snd_pcm drm_ttm_helper ttm drm_exec drm_suballoc_helper 
>> snd_seq_midi drm_client_lib snd_seq_midi_event drm_display_helper 
>> snd_rawmidi cec snd_seq edac_mce_amd ghash_clmulni_intel 
>> snd_seq_device aesni_intel rc_core drm_kms_helper gigabyte_wmi 
>> snd_timer wmi_bmof rapl k10temp video i2c_piix4 snd i2c_smbus 
>> input_leds soundcore joydev ccp mac_hid sch_fq_codel msr parport_pc 
>> ppdev lp parport drm efi_pstore nfnetlink dmi_sysfs autofs4 
>> hid_generic usbhid hid nvme igb ahci i2c_algo_bit dca libahci 
>> nvme_core wmi
>> [   31.133932] CPU: 18 UID: 0 PID: 188 Comm: kworker/u96:1 Not 
>> tainted 6.19.0-amd-staging-drm-next #28 PREEMPT(voluntary)
>> [   31.133937] Hardware name: Gigabyte Technology Co., Ltd. X570 
>> AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
>> [   31.133940] Workqueue: sdma1 drm_sched_run_job_work [gpu_sched]
>> [   31.133951] RIP: 0010:refcount_warn_saturate+0x58/0x90
>> [   31.133955] Code: 74 2f 83 fe 01 75 38 48 8d 3d a4 2c 91 01 67 48 
>> 0f b9 3a eb 36 48 8d 3d a6 2c 91 01 67 48 0f b9 3a eb 28 48 8d 3d a8 
>> 2c 91 01 <67> 48 0f b9 3a eb 1a 48 8d 3d aa 2c 91 01 67 48 0f b9 3a 
>> eb 0c 48
>> [   31.133959] RSP: 0018:ffffca16807dfd68 EFLAGS: 00010246
>> [   31.133962] RAX: ffff89e988f05600 RBX: 0000000000000000 RCX: 
>> 0000000000000000
>> [   31.133965] RDX: 0000000000000000 RSI: 0000000000000003 RDI: 
>> ffffffffa1fd2f30
>> [   31.133967] RBP: ffffca16807dfd68 R08: 0000000000000000 R09: 
>> 0000000000000000
>> [   31.133969] R10: 0000000000000000 R11: 0000000000000000 R12: 
>> ffff89e98edf1308
>> [   31.133971] R13: ffff89e9d3001380 R14: ffff89e9dab5f800 R15: 
>> ffff89e9dab5f880
>> [   31.133974] FS:  0000000000000000(0000) GS:ffff89ed0cc3e000(0000) 
>> knlGS:0000000000000000
>> [   31.133976] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   31.133979] CR2: 00007f3050081c28 CR3: 0000000117f06000 CR4: 
>> 0000000000350ef0
>> [   31.133982] Call Trace:
>> [   31.133985]  <TASK>
>> [   31.133989]  drm_sched_entity_pop_job+0x414/0x420 [gpu_sched]
>> [   31.133997]  drm_sched_run_job_work+0x15f/0x3c0 [gpu_sched]
>> [   31.134003]  process_scheduled_works+0x1f0/0x450
>> [   31.134011]  worker_thread+0x27f/0x370
>> [   31.134016]  kthread+0x1ed/0x210
>> [   31.134020]  ? __pfx_worker_thread+0x10/0x10
>> [   31.134023]  ? srso_return_thunk+0x5/0x5f
>> [   31.134027]  ? __pfx_kthread+0x10/0x10
>> [   31.134031]  ret_from_fork+0x10f/0x1b0
>> [   31.134035]  ? __pfx_kthread+0x10/0x10
>> [   31.134039]  ret_from_fork_asm+0x1a/0x30
>> [   31.134047]  </TASK>
>> [   31.134049] ---[ end trace 0000000000000000 ]---
>> ...
>> [   56.544104] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! 
>> [glxgears:cs0:3483]
>> [   56.544108] Modules linked in: snd_seq_dummy snd_hrtimer qrtr 
>> binfmt_misc nls_iso8859_1 snd_hda_codec_alc882 
>> snd_hda_codec_realtek_lib snd_hda_codec_generic snd_hda_codec_atihdmi 
>> snd_hda_codec_hdmi snd_hda_intel amd_atl snd_hda_codec intel_rapl_msr 
>> intel_rapl_common amdgpu snd_hda_core snd_intel_dspcfg amdxcp 
>> snd_intel_sdw_acpi drm_panel_backlight_quirks snd_hwdep gpu_sched 
>> drm_buddy snd_pcm drm_ttm_helper ttm drm_exec drm_suballoc_helper 
>> snd_seq_midi drm_client_lib snd_seq_midi_event drm_display_helper 
>> snd_rawmidi cec snd_seq edac_mce_amd ghash_clmulni_intel 
>> snd_seq_device aesni_intel rc_core drm_kms_helper gigabyte_wmi 
>> snd_timer wmi_bmof rapl k10temp video i2c_piix4 snd i2c_smbus 
>> input_leds soundcore joydev ccp mac_hid sch_fq_codel msr parport_pc 
>> ppdev lp parport drm efi_pstore nfnetlink dmi_sysfs autofs4 
>> hid_generic usbhid hid nvme igb ahci i2c_algo_bit dca libahci 
>> nvme_core wmi
>> [   56.544166] CPU: 9 UID: 0 PID: 3483 Comm: glxgears:cs0 Tainted: 
>> G        W           6.19.0-amd-staging-drm-next #28 PREEMPT(voluntary)
>> [   56.544170] Tainted: [W]=WARN
>> [   56.544171] Hardware name: Gigabyte Technology Co., Ltd. X570 
>> AORUS ELITE/X570 AORUS ELITE, BIOS F37c 05/12/2022
>> [   56.544172] RIP: 0010:dma_resv_iter_walk_unlocked+0x4e/0x180
>> [   56.544179] Code: 45 31 ed eb 0e 41 8b 46 08 41 3b 46 18 0f 83 23 
>> 01 00 00 49 8b 46 10 48 85 c0 74 20 48 8d 78 38 b9 ff ff ff ff f0 0f 
>> c1 48 38 <83> f9 01 75 07 e8 78 ce ff ff eb 06 0f 8c e3 00 00 00 41 
>> 8b 46 1c
>> [   56.544180] RSP: 0018:ffffca16865bb870 EFLAGS: 00000217
>> [   56.544182] RAX: ffff89e997f38d80 RBX: 0000000000000005 RCX: 
>> 0000000000000006
>> [   56.544183] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 
>> ffff89e997f38db8
>> [   56.544184] RBP: ffffca16865bb898 R08: 0000000000000000 R09: 
>> 0000000000000000
>> [   56.544185] R10: 0000000000000000 R11: 0000000000000000 R12: 
>> ffffca16865bb8c0
>> [   56.544186] R13: 0000000000000000 R14: ffffca16865bb8a8 R15: 
>> ffff89e997f38d80
>> [   56.544187] FS:  00007f8f8d3ff6c0(0000) GS:ffff89ed0c9fe000(0000) 
>> knlGS:0000000000000000
>> [   56.544189] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   56.544190] CR2: 00007f8f9b735020 CR3: 0000000117f06000 CR4: 
>> 0000000000350ef0
>> [   56.544191] Call Trace:
>> [   56.544193]  <TASK>
>> [   56.544197]  dma_resv_wait_timeout+0x55/0x190
>> [   56.544202]  amdgpu_bo_kmap+0x3a/0xa0 [amdgpu]
>> [   56.544502]  amdgpu_userq_fence_read_wptr+0x130/0x2e0 [amdgpu]
>> [   56.544670]  amdgpu_userq_signal_ioctl+0x1f6/0x5e0 [amdgpu]
>> [   56.544847]  ? srso_return_thunk+0x5/0x5f
>> [   56.544851]  ? amdgpu_userq_wait_ioctl+0xab7/0xb80 [amdgpu]
>> [   56.545021]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>> [   56.545190]  drm_ioctl_kernel+0xd9/0x150 [drm]
>> [   56.545222]  drm_ioctl+0x29a/0x4a0 [drm]
>> [   56.545245]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
>> [   56.545422]  ? srso_return_thunk+0x5/0x5f
>> [   56.545426]  amdgpu_drm_ioctl+0x46/0x90 [amdgpu]
>> [   56.545595]  __se_sys_ioctl+0x73/0xd0
>> [   56.545600]  __x64_sys_ioctl+0x1d/0x30
>> [   56.545602]  x64_sys_call+0x1715/0x2d00
>> [   56.545604]  do_syscall_64+0x7c/0x6a0
>> [   56.545608]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
>> [   56.545778]  ? srso_return_thunk+0x5/0x5f
>> [   56.545781]  ? amdgpu_drm_ioctl+0x6c/0x90 [amdgpu]
>> [   56.545950]  ? srso_return_thunk+0x5/0x5f
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 +-----
>>   1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> index 146ca6d7f4f5..442c08b69f7c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
>> @@ -882,12 +882,9 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>                    * be good for now
>>                    */
>>                   r = dma_fence_wait(fences[i], true);
>> -                if (r) {
>> -                    dma_fence_put(fences[i]);
>> +                if (r)
>>                       goto free_fences;
>> -                }
>>   -                dma_fence_put(fences[i]);
>>                   continue;
>>               }
>>   @@ -909,7 +906,6 @@ int amdgpu_userq_wait_ioctl(struct drm_device 
>> *dev, void *data,
>>               fence_info[cnt].va = fence_drv->va;
>>               fence_info[cnt].value = fences[i]->seqno;
>>   -            dma_fence_put(fences[i]);
>>               /* Increment the actual userq fence count */
>>               cnt++;
>>           }
>
> I have to say the commit message confused me a bit, but the fix looks 
> correct. I say confused because isn't it a simple case of 
> amdgpu_userq_wait_ioctl() doing a potential double put? First one when 
> the dma_fence_wait() above fails or succeeds, and the second one in 
> the unwind loop. Which means it was me who broke it yet again. :(
>
> Fixes: bea29bb0dd29 ("drm/amdgpu/userq: Consolidate wait ioctl exit 
> path")
>
> Right? But please double check because I am obviously having a bad 
> period.
Haha it happens and very easy to miss such things. But yes, this happens 
with that patch as it seems to be working fine for some time when i 
tested before. Yes that triggered that and doing the dma_put more in 
clean up too. It is getting fixes with this patch for sure.
>
> Regards,
>
> Tvrtko
>
