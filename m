Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2E0F532F4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 08:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA58A10E5FB;
	Tue, 24 Mar 2026 08:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jB2szlFk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36B410E5FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 08:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPDIYO2ImgKag5Qwxic0rtejZhBA/NFfVKTWvVdyuLQYgqjm2J0VbCYmrznn2QacDFyrf2KybbaMfiS72SD5r8xAUiOac4UI3VQVAJ00NRRqamN5YchDUni6Qyi3f0W0xymG2Cx/N/7HON9rnPqigdIwmAFFFkEToUPkH22flOqV7ZY/XZCJf9dlVXcD78E/i2zkhhvHKWQYxQovE1sijMxH0UGuLncOudfqexbKlxAYeC7juCGsPomgrRLomXugH886oS+/GlnEgkoG6o5kj095yWZhSa3LAlBe9ofFndiJ25dZiQmemZt5m5NEAXfj3kNsSbLCG2sIVvLfVD5I8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sVDubHgA/QNV6OLfMLl59J7pwjK7TwxuqkMpmFzkRA=;
 b=lwLeJ4CNCwBMy4/27b1szHAA9djfkDAxQTP+JMvkJZkFZinhTNM7Q1NmJpbC2+jJvdLmBsj1iNozsHbdsTggd/TtaVzUHN11ZINMKavRB+Bcum/zkNfTKkB/QK+/1RPz58NFL5v/0UOqf/9dsIE8ob0G+lEkbg3tyqD/GVIcNJlYSR/iqv0NemGcTHpIS8kAmw0c4GK64dl8VTRrpW5/mpN0Dt2jBxJaEM4/SiKySLlweR81KAMO0FIMjqhWDgSw+tRUljVT+HiWAvMgAoDGQqGyqRc8+cax7h+X5X+aJFGgNQTbKu00T/U/tiah7vuRHdSfsgm03EEPkDb1eTucyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sVDubHgA/QNV6OLfMLl59J7pwjK7TwxuqkMpmFzkRA=;
 b=jB2szlFkuWJ5BGz0jCm7F2VE11OOGOyWENtM+FVZx7xsY3/pWA9ZXcfKhlW8NqFMRLre00grhzo3IyttlWCEaj992MJWqc6d6EVRSnbbCvLQQQDhtSAlkOFsRynv5PCFL1/iX3+aVq8pLUBbAV4qGWWGEnHVSIIhjxtrGvCZTAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 08:39:34 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 08:39:34 +0000
Message-ID: <e2900bd8-5737-44c7-a13e-aa0feb41a44d@amd.com>
Date: Tue, 24 Mar 2026 14:09:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260324073817.662295-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260324073817.662295-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ad::13) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|PH7PR12MB5619:EE_
X-MS-Office365-Filtering-Correlation-Id: c98b068d-fd25-4dc7-78c1-08de8980dff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: lz4e4fGsDMfk2ILUqA6O4hhwkXlMVWBZ7i+zdKuuSdBoWGQViKlT6tKSVssXHv+Zf73/sJyRa2Zaac1WfRoXSaHJHOWfkZ38ywDly5SvwGdaX1cdTqHwXtpWaHicZXWNxgYPrvUXSPK1yILFuqOkY3zhzuCIlJaWRVqoydK4F8sibCszn7Eae4upyqRbYq49gkZpEgDjCQ4hk7ZSSNcfJMGyTdk/sJsYJ6l9iKq8G3lueucVdRAflgYw+ZM1UA/RCn4gjgdRPROGATINuH35S3at0/LPGxeB5qZSxSXkdNjT+HQRDr/kHOWJZMGN6Z+ZjARffD7Q1U9K4VQxahX1TEwQyA2xzJPfRIBXklnEr0qqHWXJy3sxUVMjPFUMPsjphHTis/ffPwZGq9ucc0/d28E1GBjS/vvkP2s38CrSsozOYJt0mCz3oH6ou06Zhw+mQ/xKVoEp5qcDsib208ULotXj/nDt2pX/Oe90MI9P2tFSGf/1+t20UCcMBdqhIgXNdPN5VDNn5ogYDA27dPoll8OXhrpYL+OwXnhSg+HMp/U6Pf+vN6iwTB/pSWpXcOIiBjV+Sp54CVPHC3dSeRAiLP0qI3VL4JTOoIIvA6Mez75YwWkO6Iv+ZmpbN+t2xRJN4vaUfWbb/Se3LAKEPQ/LO6/R+s3QzLDQBdkxSgYQWot9JBP3J4EuikpLBmxznjMXEU082/FnQXVvuSzPVxzWfUYNHalDxJuRtknut6lp/5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWd1UXQvT0s5TndDUUhLTlV4cUNhT1VUUWJhTm5GTkh2cm1udkNWWWZ2YU16?=
 =?utf-8?B?ZndpUTZCbnNHUzJPOGVMaFR6bzRaeFBSM1pXTmNPZ1VjK0JESXpuTGFsMTd6?=
 =?utf-8?B?MXVyVVNORmJub2xRdFdPM3hRZENmVmNqT3dOWVJ3bituSG80Uis0allCVVln?=
 =?utf-8?B?N3dtU2t4TnJWNE1wRS94WTQ1dzFBalZvVjZxNCtCWVlvMFJIQVE5ZllVcE5W?=
 =?utf-8?B?SGhnb21BZS9oLzdSdGJST1BjakJNbFphTTFmdUVsQ21sY3BmMC9pcTVJWVow?=
 =?utf-8?B?d3ZSVXJtYVk0NElTTGNKdHVhV0x2bDQzUVB2S3h4L0daTDUyZkxhc1dGM2s2?=
 =?utf-8?B?NDdnRzZVd3piMUhFMmpvTnoyUnptN0ZBNGxMM1hoZGdRaW5GWm0yMU45ZXln?=
 =?utf-8?B?Y2FLd3AxZXFrcEZaaXorbjdVd1lLZnA2VVVBK1ZIMEd3WlBaOGJKUnR6bU5O?=
 =?utf-8?B?ZmdpNys4RjRiYTgzbmZ4dURneVJpWDJlaFlORjkvaXB4dElWcmRpOGdMaklL?=
 =?utf-8?B?NnRNcWdHQVd1WjdUNzc5WmVYSExybGdyTlQxaUszcDExUkhPUU5La09iV1hy?=
 =?utf-8?B?Wi93Y25OR2gwc20yQ0Z1bm9TdmJxdytSQ2VOTzBJa0NtdUJnRGhxQnZ5Q044?=
 =?utf-8?B?aFFDNjF4Sm56SlpRQTBaa2tMbjdjWHA1QkMrSHJqMnkwbk4rV0tFeGdxUmdr?=
 =?utf-8?B?SXJvenIvMm4vWk9wS2VKYllBNDJoVHRNR1ZkTzZlQmNadm9vTDd5YVdsUzlY?=
 =?utf-8?B?ZTE4T25OT21OL1QwZDFJYzYwclpMUDZZL3NLMU9PT2NHaGMvSE1pclh1QUNL?=
 =?utf-8?B?YmszSG5YVlFSZWF4Y2RtZkJxK0xscWd2MldJNlI0aENmd0paazRQOWNJSll6?=
 =?utf-8?B?MllGd1o3Rml6UlhvdnF4UzFkZFJMekMzUk5oZzBBTlR4cytZQUFBcGhzQlAr?=
 =?utf-8?B?cmtqR0owVmRaVkVBWC91L3RMV3JBUmtmVGliN2p3dng1Q1V0VXo5RVRXK0Qv?=
 =?utf-8?B?MGdGMXAwajRIRUtnR0ozQUZYWUJhaHY0MFdKVHdscWVMZHJ1OThsZFI5R2Mv?=
 =?utf-8?B?YytCUXdaM0hhZitkSkpOTzdoRHIybS8rUmFxQUdsbWZ2UXRaUDdvdjV6V3hC?=
 =?utf-8?B?L3ZEb1NWa1lYNEpUb0xMS1NwbENTSGJYYmtpSTRSVjFzaWJWWHAzUmx4OWRH?=
 =?utf-8?B?R3cwNVUxaVVkRkpHNzRQeFhPZzNDMEtWYTE5U2tZUnRndU5tLzZyZ3FwNEMr?=
 =?utf-8?B?Q3U1RWE4UnpLTkJOMmVEaUI3RXJVdVRjU1MzR1hjWWhwYzlNR0YvNlhWRG5l?=
 =?utf-8?B?em5jUVVuTTh2aTFqUlJqWERianFPdUNrNFBnc2RJMUZTeFpnM0xCLy9rWXhi?=
 =?utf-8?B?S2VjWklvL0R3RnV1NUxHQXZvTDBpL1VvVTdIM3ErTXVXdGQxMVFmczVvTGY1?=
 =?utf-8?B?Szl2TjhJUXJXOXpXK1piZ3ppbjdnY2ZTdnRNOEFUZng0WWlRNUJET2IrY0lR?=
 =?utf-8?B?N2RvOVhLdG80SDFvVGRqcTJQMjRlZmJvUUdkZmhoOEY0VFJObHpNbXJ5TEpV?=
 =?utf-8?B?VDlnRmEzK1EvRkxMZk11YlVzNzhaZXBGazkyTXFyU3djdUo1eFdhZlMzMGpq?=
 =?utf-8?B?L0ZtRi9TZlByRW8wdnorbE5ubFM4VmFnbHpTU0poRis1TUhhR1JvR3pGdVYy?=
 =?utf-8?B?b2JxNWx1Zi9wWWNDVERsdHBaU042UXRSVVVUYWZzU09jeUQvcXFBYWxaNjl0?=
 =?utf-8?B?bEtjR0RWcDZVWVZtUVlUS2tZTlh3VXNRbWl3TllNUTdoeGVZUjZBd25GOU9N?=
 =?utf-8?B?UVo4a0tOS0JlOWtIdlBwSzBRVnJmZHpMWTcrTmJxc0Q5STdhU1pLeDk0d0I5?=
 =?utf-8?B?bmM1eFRaQWN3MGdxdFlPMlNwZWw4TkswQ1p4NTJMUFh0aFg2TFVTRDFVVWh2?=
 =?utf-8?B?SUZhMzBwVFY1OWpmdUtZYnozSGRtUGM1T2ozUTRFbVZJMENUaG52ZEFJcVlY?=
 =?utf-8?B?NCtaVEJDaTF0K2pzNm9PbUQ0T2JiMk5saUQ4RU5aZndPcU5GVmJRMmIveDRo?=
 =?utf-8?B?Zjd3MXZKWmFlc0FxYVhkRllQY1J1T2dXc1d0dGYyUUp4MGNBV240NlFlMkFG?=
 =?utf-8?B?M1JXZVZXQmFESlVMakt5RE9sclVSV3duc04ydU92alorQ05rNG5UZUNxMWJ4?=
 =?utf-8?B?c0lEMjhTUVNyWnRqQnIvazVjNHQxM0FDTU42OFBEenJ0dGxyMStiODZJYnBW?=
 =?utf-8?B?RzBMb0xQeGhVUDdtS0tSc2pPNGtiZGNabURjT09GKzY5UkkyTXNBTG1yNGxv?=
 =?utf-8?B?VUVhVkc0N01LNmNoZXRGZDduU3VVamQ1NW9BeVFRTlllUXBkaWRHQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c98b068d-fd25-4dc7-78c1-08de8980dff8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 08:39:34.3624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iviCzK7E1HG5uDUFtWEQvbQd0DfSgws4+h8V/Pi3Ic9aKW9iBP17pBlVxRNCqo59
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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



On 24-Mar-26 1:07 PM, Jesse Zhang wrote:
> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
> paths this pointer can be NULL, causing a kernel page fault from the deferred
> coredump workqueue.
> 
> Fix by checking ctx before printing VBIOS fields:
> 
> if ctx is valid, print full VBIOS information as before;
> This prevents NULL-dereference crashes while preserving coredump output.
> 
> Observed page fault log:
> [  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
> [  667.941517] amdgpu 0002:01:00.0: Dumping IP State
> [  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
> [  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
> [  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
> [  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
> [  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
> [  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
> [  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
> [  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
> [  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
> [  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
> [  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
> [  668.008035] PKRU: 55555554
> [  668.008040] Call Trace:
> [  668.008045]  <TASK>
> [  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/card16/device/devcoredump/data
> [  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
> [  668.031950] amdgpu 0003:01:00.0: Dumping IP State
> [  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
> [  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
> [  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
> [  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
> [  668.095863]  process_scheduled_works+0xa6/0x420
> [  668.095880]  worker_thread+0x12a/0x270
> [  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/card24/device/devcoredump/data
> [  668.107441]  kthread+0x10d/0x230
> [  668.107451]  ? __pfx_worker_thread+0x10/0x10
> [  668.107458]  ? __pfx_kthread+0x10/0x10
> [  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
> [  668.118630]  ret_from_fork+0x17c/0x1f0
> [  668.118640]  ? __pfx_kthread+0x10/0x10
> [  668.118647]  ret_from_fork_asm+0x1a/0x30
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index bbb5afd67b49..5aa46480f05f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>   	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>   		   adev->vpe.feature_version, adev->vpe.fw_version);
>   
> -	drm_printf(p, "\nVBIOS Information\n");
> -	drm_printf(p, "vbios name       : %s\n", ctx->name);
> -	drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> -	drm_printf(p, "vbios version    : %d\n", ctx->version);
> -	drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> -	drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	if (adev->bios) {
> +		drm_printf(p, "\nVBIOS Information\n");
> +		drm_printf(p, "vbios name       : %s\n", ctx->name);
> +		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> +		drm_printf(p, "vbios version    : %d\n", ctx->version);
> +		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> +		drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	}else {
> +		drm_printf(p, "\nVBIOS Information: NA\n");
> +	}
>   }
>   
>   static ssize_t

