Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F34D58CB1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 06:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DF2C10E042;
	Mon, 23 Mar 2026 06:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Rn0hFalb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012035.outbound.protection.outlook.com [52.101.43.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A720010E042
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 06:40:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtuHuGzL7KVE0D/9P8kl6qnoRQkXU6o5XQivHMXCT3/b6yDY8erBAxrJxVHaP7rfYCbpcHymoOnWzw91R7LyhmfEa7/rr5bNSY0/oVMWcYOHMkXmwJGhEK3oI6tiHOKi5P2t1EBAYA/04U8ZjUoWNyjLBMrb9WICIKg5DFMz8134iNKU5evUKLNQNPmUji14kQmTKePNjqjP5sDFcaS+r0DYhX0fL2eyZ/NTonjcKqznanp6AmRyx3w1getCU9MM1xzbN93EvRxsM14stDKa2hpd88gTDo1TQ92tS4GxFJv2K/0aZZGJmw8Je4n3CaTxw8URSMVuBq3TbV+cb66zlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xPFHwC3v2xWZdbaW+YMVrPwSm1pveI7Ks5tRewzOmo=;
 b=JC1IfMcvcpbQJ3b16oH8mDBSnOd4OB/3xznOJgLhGwEF85/IKWDz/pgn54oe+A81uc+xa5sRl9CoXLuAKztyrFp+ub9Z7HiLPm0EsXGHXGls/F7uX7Oh/Um8wiEmWcShDLGHu9BmCZTMOp3jahf1U0FYy3djZDg/1JTLf7XIaBwoX5GVU2bnKJXJbQtxLu9Dd7NV1yxrMuhKtLK6j8LB95XStUUnROjD6HvpcgFs0RHWgXGQwqhOSX3XX5TQh1Uy0+YdIc+GZ4ghIxeJddo+hzHaqOyrYa6ze+0sU+83uqqH7lM7f0NGfwo4mkg5WOIkAAgaVHfeyBIKA7dGfM2SSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xPFHwC3v2xWZdbaW+YMVrPwSm1pveI7Ks5tRewzOmo=;
 b=Rn0hFalb/LZGmK+AC4FPOUS2MJJRj1YsbMbwRekvi53Qb38+9xh4dnlCn5LbAuMZI/DGrRbQWWo6vZwA/sIx/tsMFNQ1I4qJtdj3nfj4X+wv3af+YAPJKDEH37XxrWb9LwSknt7xUOcURjOf5Cl6bLoV8N5d+vM2Et3D6/uP9Dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS4PR12MB9562.namprd12.prod.outlook.com (2603:10b6:8:27e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 06:40:36 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 06:40:35 +0000
Message-ID: <ec75ac69-1622-4585-b658-a50ace1727f0@amd.com>
Date: Mon, 23 Mar 2026 12:10:30 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260323061912.505329-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323061912.505329-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0063.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b3::14) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS4PR12MB9562:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eeea360-118a-40e1-19be-08de88a716e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: KIZhQBs6fdhUTVhdRHHElt9ISx80g7qrHsnHFkuoA0fg79nNqrImQwTcS74xiTeuYbxMdKqfNYXHWWq5Q26CU9P8DMTHM5YjKxUBkPsE2JkBY5LXTls7LtsSiNAZTdDfa2OM920URfvJgLYi1ScHxBzpcMBdjqBKQ4y/i6+dLu004kVsg6a6pP4zcaUv/a688MkwvdFmJKqnJbKr72ll6aJOeci+cosEGdb/5AR915WDFhW4AYmkadBJJwrPhRawP3//2wt4QrkIfuFYPXsjZGYhUhh712T7ZUfV/z5UQRZezHZSqkzesPIG+g5Cp4tv/h9Su3OrtvnSvCheGbrFBQF7yOTIQ3haF7hOxF3qqqYs4tz3ZcK6N4bkaNg+XYzvenHBAkeS7QjdJA2vW4twv8V0gRt1AG0QFlRfDeC4D4wGyX39Kxs6sEApr6DedxFA06cW5NBwIxLMff4WDyMZfxIGvZh28NAF28T7Pm1CASmaXREh1DIJfwD7iP8JeAydknoMXkv3lwnDkEA+BhxXD6G4sgVJu/GxpfNJWPh5d39ZAJhB0eN2jN5C2f1rZDNhfvqLqrbdrfvSKFEzjgyh4HRkFhNGDREwW+ukwbb41TFjt+/nim2vstO0vq1EbWYwFq//bhLzoga+1qkH/MJySk9MxCnmGa4pRdDoAtvPQdhabNFld6l2T0ZLhYScF3en6RUlIrZvHdWmxxtbwv4GU/bwdtzzMnfb9HCb5V1yKo9Y7Tlih3dN3Ib1d9CImCQw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzhJcThJTHZiMXNJTndQYlNqY2xyajh5TGlNaVBISzMyeDl3MmZJV0RFbkNJ?=
 =?utf-8?B?NzhZdDh1a0hERkZ6clZKSkdwelhNNGtmQXZQVXZCTEQ5TVptVlVtT0htWm1n?=
 =?utf-8?B?TmFNVG44Y3dwTndrTE9KcEYwa2xNTXV4a1JGRXdwZlY5S0kzYnByTzFPbXF3?=
 =?utf-8?B?THBqb0w4YXF5UEk4ZEpRdGtjOW1nVlZVNlJPTS9vL0pEQjVUcS92SkgyTDVT?=
 =?utf-8?B?Ni9xN3RSWjNxdnkvMlVVTFR6ak5yc3BCN1Vsb1FsV1pNcmJqVmM5UHQyM2hK?=
 =?utf-8?B?NXVsZEVnNFJmVXZQdmpETEFML2g3a0lRMUJ5cnlrNGZRdXVUMTcxZVVrSW5V?=
 =?utf-8?B?ZUdPeDh6eDA5UEt4MkZZT29oZFNGQzBiVmhaUUJaV2xjSHRCYU9OdHVmYnZB?=
 =?utf-8?B?aWNwNXZGckIxdklDUWd2UkFLZkxQUWR4NkRCRXJOWC83ZUZuVmFJWU1qdmRT?=
 =?utf-8?B?SEtsQWthTTViK0twcWdPSGNZdkJTZ0tINWJuVThKb2doU0p6ZU9ycFNaZjBN?=
 =?utf-8?B?dm5rS3MxSldPdVg3U2ppTmxUVWRIWTJudTdkbVAxeXlHQnh6L1BnNE9yQzFI?=
 =?utf-8?B?Zy8xejRmZmZYM0o5Qm9CRVIzMHZvMGhNc0w0cXZMY1JTTVRFbXRMOWtSTkdO?=
 =?utf-8?B?TnMwdVhwZktIdkFVSjNDa3cyT0pCRUhEdUpXYVF5am1QTFRCdVEvNUh6UlVH?=
 =?utf-8?B?YTFjVGtrVzUxSjFrbXZWK2RlSGVNc29tRk1kanh3ZVpjbllVMnArT01ScE4w?=
 =?utf-8?B?VUNVb2VQU2FWS1B0WVVJNXB4QVVkdHpzV056VndFWDl4cTlQU1Y1MWZyQTIz?=
 =?utf-8?B?WnY3bWJOYzhJS3VUV2kyZTRwRE9WTmc5Q29VVGtlWVNrQnk5TEtJZlgvNFph?=
 =?utf-8?B?UUhtcmlSaTloY2ppWFppVks1alppQVRDd3dzTTlQTURtaDMrcW95b3pHUEcr?=
 =?utf-8?B?SDlTdFI2TmxwcE1LSzc5RVdFNDRvUjVNb2FJaHkwWmhIMWZtZlJxeGdFb25r?=
 =?utf-8?B?eTFtUGtJakRCR3J6TzBZcElYVXZHYTBKVmRkbytXR0prRS9iWEtJYXVjSEll?=
 =?utf-8?B?bTlkeUwvNXJYOUVVa0RSYldYZTI5NThEVlRpUmRJQXAxT2tWNVJMQ0ZXZ3pt?=
 =?utf-8?B?dlZDNVFpdWdJWnU5eC9WV0xudE5ERlZjbHZFY2JlbXMrQ2s5MlRFc3VIZDNR?=
 =?utf-8?B?YjZqTy9hbU1CQXB2K2lDNTJNZG8xVkoyNGpaQ3lsZ00zNENuaDFHY3BDbEty?=
 =?utf-8?B?WTJHNzQ5anhOZSt1dW0rV1c4cGxwZVExblJZRWIvWVhnZjd0ckVJd1lWQUNr?=
 =?utf-8?B?ckhESThxR0puRTlNWG44MVRoOGE1amRGcEt1OUZ6ODBzSTdzMVdpNHlZeTJK?=
 =?utf-8?B?dGc3NGxHRjU0QmZENVhHNDJHZEJZNkhwNjkvQXNZcmtONTc0aENXTlNDVkVi?=
 =?utf-8?B?Y2RJL01oSSttaDQzdjNzd1dxS1BTL0lFaDEyaEt2aEx1UTJKVHQwVEpsNWY5?=
 =?utf-8?B?NmI1WndMbDA5dXM5N1VIL2FZeU5UUTU1aG5lNm1rMHBReGtLVEZBYkNmSTNy?=
 =?utf-8?B?THRvTlNsR3NFR25Ed3BOUzJ4Q1ZKaEIyejRpUXMxdGFPSEtyMFlBSWtiMkhl?=
 =?utf-8?B?Vi9GaWpFVWxRWm9aZmU2NWlOUkZDQyt6THl5cmVEQjBIVDkrZy9MTUZKZHdM?=
 =?utf-8?B?Rjl3eVdmd1JHN1lySi9kbDd4NmtPSHFSc2l5YTFqcEExcHIyTVcvOHNzcjJL?=
 =?utf-8?B?QkpDYjdONitQeWNRUnRNbml2Lyt4eFRiMGQ0aUYxU2J1MFN6eWtJU3BjQnY5?=
 =?utf-8?B?NElEN1N1clRrUzB6Sng1MjQxSDJOYnJMMVR2VCtXOEVxTWdTcTZpcXNQeDNH?=
 =?utf-8?B?RVc1K2pqRE1pQjdhZFZJYWlWaEt5SnFNNjd1d3dmOWw5NVdTNUUyck9pWFJY?=
 =?utf-8?B?ZXlxS3MyQzVlOENNbUFNZVVjeFpBM2dHZExGaEkzbzRORUVhQy80REZZeGhH?=
 =?utf-8?B?bjJvYTFRVEROUTJmWFVmYnZLeDFPTjZlVGJ3RFc5am5LY0M1TldRVWVzWFF3?=
 =?utf-8?B?c1FFWGZnYkpQRnpJYzdMWGtyWGlYWVZ6WElCdUhqZ1pJOHl0YlNrSWo4UjBP?=
 =?utf-8?B?R0RBMTk5SWVSWG44bUY2WFdmbFFYYVl3MC9wWE1Icm10KzF6NDd4RDcwVTRJ?=
 =?utf-8?B?anN1WVgvZWk2TEluQlVRSHBFaUtRTmhQcTlsQVBqK1BqMS9SVlV3bjBFTnND?=
 =?utf-8?B?T0xrR1FLekdhVmJTcnVRYjBwVlBwbzcwMEpYVFFvOVpzckx2aXUxb3B0WXht?=
 =?utf-8?B?SGkxWTZJR3BKQkF5TlI1Q1gzQmQvKy9hOFRTSzFyMVNJZ3JwMytPUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eeea360-118a-40e1-19be-08de88a716e1
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 06:40:35.9045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEFodCfDHvcWQzC7lzXKGLJYxscH8uuoSfdrY71VQHN7+5ksbrTThclZlu3Gc3mh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9562
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



On 23-Mar-26 11:48 AM, Jesse.Zhang wrote:
> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
> paths this pointer can be NULL, causing a kernel page fault from the deferred
> coredump workqueue.
> 
> Fix by checking ctx before printing VBIOS fields:
> 
> if ctx is valid, print full VBIOS information as before;
> otherwise print a fallback line:
> vbios info       : unavailable (atom_context is NULL).
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
> v2: add check !adev->bios (Lijo)
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index bbb5afd67b49..7896ddf46ae0 100644
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
> +	if (ctx) {
> +		drm_printf(p, "\nVBIOS Information\n");
> +		drm_printf(p, "vbios name       : %s\n", ctx->name);
> +		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> +		drm_printf(p, "vbios version    : %d\n", ctx->version);
> +		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> +		drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	} else {
> +		drm_printf(p, "vbios info       : unavailable (atom_context is NULL)\n");

On a second check, this cannot happen when vbios is available. Driver 
load will fail in that case

https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L2779

In other cases, we operate without VBIOS. For them, probably this may be 
avoided altogether (preferred) or mark the section as NA.

drm_printf(p, "\nVBIOS Information: NA\n");

Thanks,
Lijo


> +	}
>   }
>   
>   static ssize_t

