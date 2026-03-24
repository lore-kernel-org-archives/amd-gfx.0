Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88B66E9A74E
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 09:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B28B10E46F;
	Tue, 24 Mar 2026 09:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WkMHAE4P";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8493A10E46F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 09:42:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNG0USHwtPAtQWrM6NXIWERyypGLVL617qlHkioHlq9y4dCUlin7Rur7USqAoMDEyW8SgQ/+P1iQOZVs6nogN2expf3DV1bU0MgK5lyAWo+objjPvv76l6wO0/GamNDzr9PEjxQoqvi+aAo4yZbIco1b8RIpcs44mM8URqz6lQGDF6j5szREa4dULircq+qkue/KjCFDB08GhsnGMbBPgfXVyMlu9HfaHHam8dhwNPu1Vj76cmj+AIM6LG7CFJIAKtk5zRa1vqdTCOsgkzUp5UktWYgGrbeG8MFuP9vGdnOzwd0CSZjkRI+Ec365ig2V+JXl0cfkRsjqgU3hOaFL3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMAzX95HnzkR5riGM3foivC5V17YdvPQv3K3nu292fU=;
 b=EwHSNCyoVH6MCYXgT7WnNUvBgG8Ff69IREq72wcIQgRKgc2CO296SvsbokoE9HuRCfL+lE7RHtYJL58IpNjNDpXqIbkc6sNUvFv7J+Z8slbebzlSRDao+NPKx3k7t8DFKPB1RDTrnib6qtVYfTc+noWze/xu3LMT1TnZcDAEOmW6ZgcjJE9yd3QX/7iPBB3553pFOjN/GqqYFjiWn3VAgnbKswzUxxOaiBhabQvZwJo0Oocb/gcaBbWH7I2YDxOsKHRRdiIRn5jfpDw2+YnpM2U7zBCHtKga6VrW0PeBA6KoiA8eAlM8PjZj0401cjmYZI2+O7oaAGFyochLmmKHQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMAzX95HnzkR5riGM3foivC5V17YdvPQv3K3nu292fU=;
 b=WkMHAE4PPIoLP3UF32o1e+hKrtHJBMZEmj5vvPsw5UCB5dpwiZLqM4rGtZGt9cQi7t0gTBelfQmMOW+9ZEMc8IijVM4jEIosABsuZy0w0fpxptNbnl3MsB4VUjudHg2cyI9q2N4YRqRzSBwSeul0L9LpYmcIW01loWwIZLxW8Ds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:42:22 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:42:21 +0000
Message-ID: <ad42e9d3-826e-41fe-9810-49824cc9a741@amd.com>
Date: Tue, 24 Mar 2026 10:42:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com
References: <20260324012618.626710-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260324012618.626710-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: da5174c2-1464-4838-9244-08de8989a5ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: zznR0sPnLDXrv31qAo/SzD+wu0LyaU4m7YVw6owSrWc+W7I2MSErN0mH5dXY48/rSVhJPBJcp729k0dndbejvyA1vNF0vlqfFT4dT3KP5QJz7G7txoOkpHqigjoi2BAe9u23IfVR+GanlY3TZoOnt+pmQlsnv5SZqiV2aGsQru162f7j44N4tMcgR/iYynWCwKcclxZAcRZyvtceFG5JVTYspchA/DBSxBRH0TKxrqst6lxou7IZu8CQB80Lnox9bgzo494LTMOefkrbDXiLJ2Cv+ddl4hBlMdiHAVgfrOjTPJ7guAzzKpYwFROg5WG6maN44KbH4g7iCRqYhHUzQr1cQDIUdt5B30zbIuEWtFWdurU2LE974yQxAgXtujRViSsAENLC6D0djHHg7cFMyG+b5SKP9XlBnjTEIL2iztYr3Edz1o4IhSZv+1vjlXOmorh1HuGBOM+z8Z9VxQoRivSPTE7RAXLRj+DCkQn1QhKyS1JKSPz4EGyAVLZTrsX8fZJxM05PRyoJM6xcX7jtgpgcCCsAT64z7RYCi/TllLV6W7pglacb7ro/lo2Hvknaw+xbE/88eBH78UhKQQxpdTsOgWNsw2JNxsil5lvIxQJOgADHoFlEDEf/p/62vT7fJgAhh45uaD2rSl60S5jz0FqHQnKF1ltvCN5YcZtQDiilDGdDo3prq5l0j8EW8i8K0eE7alGl/K4KZzHsZG4UgGDhAeHtvnKgIXZB2ROJiN4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU9GcVRZS3FxOU4xM1pOUEZJZmtHMXJ0bjdSWkZwT0had2h2VXF4amNvNzZX?=
 =?utf-8?B?eXg1YWkvZ0l1T09MdURZbXBNRkZBZThNTDBqQWNoQ2xja29tRnlWeENJTE9q?=
 =?utf-8?B?MThaSlluMUNlVTBDcEQ2Y290a2tsNm1QRTFydWRKb2xmMzArbFBEYmlVb05p?=
 =?utf-8?B?L1ZCR2J6QlQwenNadUpuRzVnVUdnUU1vQTV3SDN4Ykd3Z2dlejVVMmdFdDF5?=
 =?utf-8?B?NnpQUjhXNkhtT2JHRndrOEJKRlVPdStUNkZVT2pqV2hGS2NCSFVZbVVtK29q?=
 =?utf-8?B?bGovVzJPTU5LZVRUN2hjVDBrQnduYWNrTU5BNU1MVWVqcWZIYmNnYlFrUXQ2?=
 =?utf-8?B?ajJVVkJndG1ybDF5d29VL1lKeUlLZUVTeG4vWUMza1QxeGF5TUpxS0ZEV1VI?=
 =?utf-8?B?cHh0UHk3Y2lwZitKR3o5Q2kvRVFZcVoyYjBhbjlWbXNzZ3dGekhNVjNMTGpK?=
 =?utf-8?B?UUZFRjB0WlRzK1RQSW4ySWUzK3VSUEFyRklGWlZjZmowYW12WDViOGRhS25m?=
 =?utf-8?B?V3IzYTVGbVIyUUk5dVNRRXlFbFU3clEvSHh5bERSbzZPckZUM2x4b2pROVNS?=
 =?utf-8?B?cDFHeVk4QTEyaUI3bkNBek1JZ2JEV3EzbHNvUFpLdGN4UFl6bklrZEQ1QWNs?=
 =?utf-8?B?bDAvUmdONDU5MzR1dDZ4bmZnUFo4Nkp0cnF2T0dkRDFVSzIweHJwUFVRZEVH?=
 =?utf-8?B?QzR2K0FSL3RRM010cnJyTFMrZmJrL1lhUDJvcy85WkJxbEVJaEtSTHBlWE9M?=
 =?utf-8?B?L01OZk1BZ1AycXJiZm5pdC9jSnhnV1JCaDF2UkpoR2Q3RW94YkE5d1U2SE5i?=
 =?utf-8?B?UEVIbTJKWUptZ2ROOGt5Tjl6N2YwdWRremkzajRqWjFLNTlpN3Z6K2NyUUZQ?=
 =?utf-8?B?QVNsa0NaamxOTkNVSzg2QjVhOVY3cHRvakR4RWNGaHpyeFBMRFNvc0E5WHla?=
 =?utf-8?B?Q3VucW1IWjJaa0lvdnZIZU80WkR6d21rWjdDYUlPMnduNEw2ZUw4NXRIcGFw?=
 =?utf-8?B?ZjBjaTF5V1Nrb1V3RWJCRjdJWnZZQnk4b1pWOTNiU0xiK3llZDNCdDBUNVVm?=
 =?utf-8?B?TEIvcHRxM01LSkRQRGhWSTVIZnR3NjNsNzQxWmZ1V2RJZFhxRVRPYUNmM0Nl?=
 =?utf-8?B?NmNuenNTMllvZHplTngwUDhod3VweFJRbFM0c2pCNExCdDNQZXNtZlF2T3Bi?=
 =?utf-8?B?YU1jMDd6MVdrWFpzd1BzZHFCemZsa1h6M0J5eVFyTzdlR1lXbTdtYmxHUDR6?=
 =?utf-8?B?Skd6Vi9vYkZuTHhWSXBlWUE5ZGFTRTdKaWFNRDRXR2lGMDh1b3ZzVmNtZklj?=
 =?utf-8?B?UDVXU0h3a2lLTno4UnBmc253NS9qbGMvZHpGTU5zUTdKeTdZVlpKUGdMZzNW?=
 =?utf-8?B?MUVRK3I1dGpOS0hZcE9LY2xkc0pLYnBReVg0aDkxRXh5R08ybytMaGQxV01i?=
 =?utf-8?B?cU9sY0tWbEZ0b21mMnJOdzNmQm5MTGVSbGg2WkUvT2xFV254Mnc2Um1oUjFR?=
 =?utf-8?B?cWxwZlBFQjd4bXN1enptVk4vMWduQURocjJQdEFrcHN2d0w4V2YzR0pqS2V1?=
 =?utf-8?B?ZjgrcGRzSlBUNERraVB0ZEZzMVgrdkFxUk9LN3hwSmI2YlU0cmExZGxKRWRT?=
 =?utf-8?B?czFOWTlZcnF6U2Y2b2k4Z0xkb0lPZUNkM2lZTkJLZEdCN3BXN0ZNVDBGVTNQ?=
 =?utf-8?B?aUZPNWY4L0pQdTRKWGpjVlllc2E3ZWdxTS83Z1RMdDRBcDA1bEFEVzk4TEhK?=
 =?utf-8?B?Sy92UTlXRGlIbXREbFIyWEtZelp0NlFLbEFlRWR5WnR2RW5IRFZhMkIwNVpx?=
 =?utf-8?B?eXRvMTNlcXVzZWV6MmFxNnc3TjVoNy9jeFZsc3pUY0lpdlZtTG80R1ZTOS9l?=
 =?utf-8?B?YzkwRDNoS0wzcEs0cGJ3Q1pMcC9hQTI1MGprS2d1eDlOdGc2b3J2eW5GRWd4?=
 =?utf-8?B?dmtmVHZGVFVzMnZwQnBTQnZrVG5VVHZhcUNNaDNsRVQwY3FyWUVjcVd3UzM2?=
 =?utf-8?B?YTY4eGtNZ0FycThKaVpNYkdyZUJwWlJ0Mkc2anVOeXZNd01kZlR5U3F1ODZQ?=
 =?utf-8?B?Q2xkZE8rTlAvZGFCTnNuR1ZMWnBSWlFDUjBTYjFxbEU0L0ZMemM3Y3hSbWdP?=
 =?utf-8?B?ckM3a0M0RHQ4bnc0RXE0UnBpMHU0dU1id1BNS0UxN1NrZ3gvUjg1aDduY2hr?=
 =?utf-8?B?T2hVLzExTDFPVHR1cENtc0NoVmZuMWJKWGQrbXVSQW5BMmZtb2lhT3NBaGkx?=
 =?utf-8?B?dC9JKzl2UGhxYnltV2RacWd0S3p6dmNGMndzUmxON25LRURBQkpiVFM3eWdN?=
 =?utf-8?Q?iwe6iGCscpD49N3qno?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da5174c2-1464-4838-9244-08de8989a5ba
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:42:21.8246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6xOGVDfcZLTlEZlqM4LJleweuCcfmOi8EPfClv/PO034+tO457Ay9vtcW8IjFYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
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

On 3/24/26 02:26, Jesse.Zhang wrote:
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
> v4: fix the race concern without introducing VBIOS snapshot state.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++++
>  2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index bbb5afd67b49..5aa46480f05f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>  	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>  		   adev->vpe.feature_version, adev->vpe.fw_version);
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
>  }
>  
>  static ssize_t
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fbe553c38583..69f4549e6271 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4260,6 +4260,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>  	/* free i2c buses */
>  	amdgpu_i2c_fini(adev);
>  
> +#ifdef CONFIG_DEV_COREDUMP
> +	/* Make sure deferred coredump formatting is done before tearing down VBIOS/ATOM. */
> +	flush_work(&adev->coredump_work);
> +#endif

Looks correct to me of hand, but I'm not very familiar with this part of the code.

@Pierre-Eric and @Sunil can you take a look as well? You two have done more with devcoredump then me.

Thanks,
Christian.


>  	if (adev->bios) {
>  		if (amdgpu_emu_mode != 1)
>  			amdgpu_atombios_fini(adev);

