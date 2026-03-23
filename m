Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4797CEC01B1
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 09:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D64D110E4AF;
	Mon, 23 Mar 2026 09:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cO8wCT3p";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010020.outbound.protection.outlook.com [52.101.56.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 305B310E4B4
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 09:57:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiutMSXAQW5yFb6ggOYeQNykNo8vGl4gi3itK/Xn2uVx4Nsk5GpxThsrq9zgmXH7oJK2MNHFd0q7u0eX6fYxv+xxLpQqwHNDXkjHZAOaltr4tfoP++r3JAk+p9Hza3n2+ipqGPhvK845tw3J2v8ZY9p6QpbZ7MAOKenPAELH5S8531lDr2F8O184e2ylYgk1Q2gpvF8u/uB263Lm822b1KvavgKIwg/p2gnJAHWk0uIRT3Pu2fOIadDWOKNWs2+5zsLymQpzq1hYNx4tJeUFpceGPZjlWu1pWSDBzuTLsHNQODb3qr8jKRsvcPvooGPj4Jfwc8Td9oWaPpl/3qufZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Mw5m+rdrsHIFcczfWYqSwQXHxsJuF8AnJmnsPjRnL4=;
 b=Wxi2WuZFAGS1UisA/TdMMjQblwYle0MinBQdzb5uq25YamIRbVfALvnsMPl9mj17OWdsE9lggF0J1cnwjMmtbT381u8w0IuU3jIcJhaAhJW64qIO0ISLIQK9/lNrkQJa4QY7oBLedCbRwlkOQdUCaR4mGjV/BXZHhOFTMASPX+mvFjWJY9I3pfnHjtX0OzQeD6TuxS5sJ1DwgN1Eb7/MgCRwKr6vGQ1tpygjhYG9dOMY+UPM1cgojbEhe2mVeqOz8aVFLbvCE6IKWQ2coQ9h/jULH6uJO1Vd1Np+WZl/9Q0LFEL0kgp9Rtv0TJTdjYLcnu2jkIK6hDMXtd5B3TdCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Mw5m+rdrsHIFcczfWYqSwQXHxsJuF8AnJmnsPjRnL4=;
 b=cO8wCT3pAlL74zRAAWNdcgTuIKponGENb5HX+eMsXhCW+EMUa5GWCtfN5k9+YsTaoHHD6CgrZMPGxK/qp9OylT+1jDGIgBxg6BDlHguPh4+IvMu6FhGKO1qSS2MChKpUOqX3+frQ0NpeTpyWWY8EOQ1Sm0OUwtOcPi6RzHcmSfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 09:57:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 09:57:17 +0000
Message-ID: <08cef5ab-1874-4f34-b9b6-a4355bdcef58@amd.com>
Date: Mon, 23 Mar 2026 10:57:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com
References: <20260323065621.554621-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260323065621.554621-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0403.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 6db7e0ba-422d-45c5-7812-08de88c2910f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: O2jkF+tnfDxvNtkxkJU3MpakCMtoQ+EXy5vuhHzpnM+3I0uStrbmTscq1UarDjIKEqpxGEbEqlIH4weJC3GdEu/vu2E4/iloPGEq3KnentoOG155JVZO9cRJBT6BuwdlouQ9iC+E9GXPV1qOd9/2KDpIcAzyv+dRwE/snYj89+1zdVepruHvr0jTP20yhxTpMroxdZ2fCpPU9mWiRWamrNN3pi0YAzi+OMZNMO+W5YLZgmkEkLrUlYPGtjrI5nq7BGwOffQbG5q0ZQrm7brM8WIPOYsasb/RGf/ETx+Qm5916LInlvyWRbQ3uKv66hBPCcipQDNCMG64gbaQkj2EeYWoLo8zzPJabHSdit5WSCxkJaVOtgbXhGA8D1CDrgQnG+WsTstY9jv1RzTiSCqiwzAQPQuGJCAy4nvt+6w0L0QsYRFvF5SU70wkd9+LTvoI6Y6b/JMvwM7MD+118eEQf1qqpvmiyBVOWBFD7Md9jY0A9XuEsXW/xFoC0AmzC9NOwLFOm3FBAuVO1U+28h0U/OpcIC/VA13mCCufNJ4I1z4ujIEudJYoqnaqvzlVWUUmCHSb1UDI4gR8HbQN13AFNaO979I7AdqUuiuQ6I18mUaj1H86dPYlOCo1MLxYellvpVzJbTxjDvWXN8fvBoWKi1OBI8PpKRd852bev6NXywD2zUjFPhiOD3Mu/zK87SZmX+7y2xwZgKEr8kkM2Rm96kZ6np73/6wYdNb63jrjWZw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cE1OcXFkMlUrWjdHd1Y3UFJGU3NzNVBaYzltTUQ0QUZuWnJuYXZQQTI2WVl0?=
 =?utf-8?B?QWFsS01oSEFnVzNueU9VVjVLS2NvMkRnMlhJS1NTS3Zxc0pNMlJwQkVtTmJS?=
 =?utf-8?B?S2xSY3dhK3c1ZFc1dElXYUROdTlYODVLQkpVcEFFWFh1aG1vUko0eVMycGpN?=
 =?utf-8?B?c2JFQjk3MWJqQUk1MFFtL2VSRk9HcmptN2pydDhmOWMzNzdJdUN0UUVwSzBT?=
 =?utf-8?B?NjdBUnRYNGdiTXE3bDE1bUdIRDBrN2tiTVNCQ2JMbkFpNHd1VXRNdjRhMlBz?=
 =?utf-8?B?K0RnSnNpMVRpUlhhZm4vV2taQVEyYnJpWW5MVUhnZXl0UDlEN1REMUNKL2pZ?=
 =?utf-8?B?bGhhbXdvaVMxY3pTaVZySlk2aWNaRHczcmVUVGV6SEpMNWVLNW9Rc2FPWFhq?=
 =?utf-8?B?dExvNEsweEZtcFd0bTNWeTRuWjRLQ2RRSnZRUmNvVTMvOExtaENHSjBLVGo1?=
 =?utf-8?B?cmk2M0RGTmlsQmpaOGwwWUMvSDNIeDVWcmRKa1ZMS29RVndDd2llN2ZTb2tX?=
 =?utf-8?B?OGIrRG9lQUV5VjFRUG9GSnY3clUwdWpuMUZVMmVOZFdCckRYZ0ZjemVNNXpU?=
 =?utf-8?B?VlUxTWtWbCtiOVY0OHRVeEZrdVNTcEw0UzJ3cGs5OElGbWN5eTRCblBwUTJx?=
 =?utf-8?B?YkVBeWpKUTFoMFRFQnRycFhWTkNnQVRJbUtEYnlXSWM5UDA2WURKMDRMNDNv?=
 =?utf-8?B?QThhd29lOVA3WlN5ekphMFlmeXM5SXd2WXQzOXJPcjVCdEZHNEZYUm1hbGlh?=
 =?utf-8?B?U0RSUzhUVE5UNHhsUmtLYkhnUnNRWnFnQVg2M3NJOHIvNFBSZzR4VG1Sak5j?=
 =?utf-8?B?MnZtVFRjNTdVZFpLcmU3dnhYdnB4ZnpwcVlUWWt1NW5IOVF3TTd5VUp2aHJR?=
 =?utf-8?B?SjdzUXJIODliWlhkZVRSWmFjODVpRXdoWEcrWFFOWDhHWW9JbUVHdnhjT0pt?=
 =?utf-8?B?dElYQXBlcnVtOSswUDIxc2xlNDI5bWxrcFE0d1FQTlhLVzEzSHBGZVA0Mm10?=
 =?utf-8?B?MmtPVk9Bcm4yRlpqRTN3MW9MRnlWWFo5TitxRDNXTzd5aEFiK0IwaVYyY01L?=
 =?utf-8?B?TzRGdHJiMjd6ZTJLTW1Fc2hlT1Y1a0dJbUV0SzY0OFlIRlZYelhXeGJ2dTRu?=
 =?utf-8?B?cUdqSVFmSEg2KzdTcnV3eGl2ZkpJTHp4LzFBNEV0aXBGOGdGbEdmZklzeXpu?=
 =?utf-8?B?RzhKSmh2dXRXVjhhQ29raUlrOG5OeURHQ2ROOTFPdEl0V3RIamI5cFFiR1Vq?=
 =?utf-8?B?TWZXelQvTXZFNTRFUE82bFRvSmZZVmlJMVNqN1Nyc3FxMG5zN0NUN01jemp2?=
 =?utf-8?B?OWpuazNhYUgyWEhCODJ0YUpibUp6bkkzMHRGMGxLV0g4dFlBa0N3VGJDSlB1?=
 =?utf-8?B?eDFrY2ZLd0J5RUNWRjluKzJud0ozMnJlS3dENXpsOU15Ly9IMWNhMCtnQkpO?=
 =?utf-8?B?NVJpcFFUa0srODdvQUlZRVg0cEJIdzFHdzFFcjJJVW1xU1kyVUVDRTVpV3VF?=
 =?utf-8?B?anVTQmdBRUJwb2diVVhjYVVDSlBmK0FKc2FOMEp2ZjFuMVVzVVNiQ0ZDV0Ir?=
 =?utf-8?B?YkhwdEFiOEl5dFdNbU1WcURFVlNFaytwSEcvSHZLWFBBRnUyZmc5NmlaSWMy?=
 =?utf-8?B?Z0laVFVLcUpyclpWSDhURzkyNmJ1QTJmMVZwTWNVeDY0V0F0enA3elFuNEU1?=
 =?utf-8?B?RE5aQUNPT0U1OUpjK1Mya09FbEFlM0VCU1JHUTQ5NHJSR1Q3WHhpdFJpU0Rp?=
 =?utf-8?B?c3UwNmM0OUN0QUdTSXJMOFNjYXhVTzF4NHVaeThubFRKYzhERlBGSTd1T3Qv?=
 =?utf-8?B?dThFZXVrTEhYby91Qk9sb3B0ZVh0anA5TnU5dDhRMXEzdkhoTkRxZnlhNjJt?=
 =?utf-8?B?V3NwUGc5a2kyZFJjUEhvdWJpOEphbENzU0hvb3l1cjJtRkRiakZ2K0JteFlP?=
 =?utf-8?B?eEtHUjV3MVhWMWk5bTkyVUEyY2VUMWIxa05oY1lpNGVtT0pwanZMRGJhTEQz?=
 =?utf-8?B?UWcyTHFGemxHMkNqYW1vSjB2UFUzdG8vcVMra1RYTkV5bEFKamY4RjUxcTZ5?=
 =?utf-8?B?ZjlUSis3eVhBaENFelNKSERISSt4RmZUbFIrVitnZFZmTmdNcE5lTDM2ckJF?=
 =?utf-8?B?bHYwLzlpZE4xaEgrbEVVaFdjM3hlK05KeHhnaWZPUGtsNElONWZhRDZMb2xn?=
 =?utf-8?B?N0xlS2NQSlpwSHdzcWJidjRlUVJqdlF1VVZTMFNpZ1dGaHFEcitpMk5GTmVa?=
 =?utf-8?B?THY5bURyazFtUDE4VTBQb1QvVnl6Qm93RlJWKzRWTm9xSG1uUnNqMTV0WU5H?=
 =?utf-8?Q?5hhydM7i2VLH6n1uWX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db7e0ba-422d-45c5-7812-08de88c2910f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 09:57:17.3608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PNxn56fRIjy9sNiUspDSNRHd+pV70NuGEEXXe+fFm3IdAzXB+NqqigqgnLYi8yvZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277
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

On 3/23/26 07:56, Jesse.Zhang wrote:
> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
> paths this pointer can be NULL, causing a kernel page fault from the deferred
> coredump workqueue.

I don't think that this is correct, just checking for NULL doesn't fix the issue.

We should rather make sure that we don't release the VBIOS information during teardown before the dump is completed.

Otherwise it can be that we manage to grab the pointer but free it a moment later and then try to print freed up memory here.

Regards,
Christian.

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
> v2: add check !adev->bios and chang the log  (Lijo)
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index bbb5afd67b49..29078c08f264 100644
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
> +	if (ctx) {
> +		drm_printf(p, "\nVBIOS Information\n");
> +		drm_printf(p, "vbios name       : %s\n", ctx->name);
> +		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> +		drm_printf(p, "vbios version    : %d\n", ctx->version);
> +		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> +		drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	} else if (adev->bios) {
> +		drm_printf(p, "\nVBIOS Information: NA\n");
> +	}
>  }
>  
>  static ssize_t

