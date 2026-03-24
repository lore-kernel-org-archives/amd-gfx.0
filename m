Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0060F54AC0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 14:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E7E10E6E6;
	Tue, 24 Mar 2026 14:13:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e17adTV8";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010051.outbound.protection.outlook.com [52.101.85.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E977510E6E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 14:13:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgqsVqfLR6RCxmf7XTVjs2rzEySVh/+wGW3mnpz897ypbeJjeeNS5RR+JwVuGSxqdrFUmn6W0/QC+ICA3zxI0L6NujeIRQtYZyTezrAGdYOiNCxBi8QR7B3fBdhlS6zrE36OQ+0jbkIvVFRKdq2z3GIzsLnOpN9Wr0T3waNc4eVnz6OFzzBQbi5jBzfKtDRjVxYsgNmCawZiH+4Ar7aJx40mcKR/6yG+BG5qalSwfLYfzVc0HfwXgj3Y8SyOTAk749mGYVdx1GeWp2h61e4iZ02V1KBTav6jN9XxcU0LBtE6+0mIawV9qUNofH55LBZnxf4j4NIPxLKkaWzpvcsEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tj7Op+W5gW6PBp37Em8LaxkibiSXWc1PFz0sAu/mN+0=;
 b=ILzUmNauC6s8GteBGu7KCXXfmu1B4GxcuU9gW+ACfVg5tKOM0fBkgK2xsqwyW36u2B0bqgpfZ3phKvflCXIXIyXS/sCT1EKgdbvblIwk7CpDRxzjeHVsOCugCkz//2ErjuXVxRU2qcn7KlZEnBg6Mwugd/LX3VBz7EKbu36iakryhZRW6pR43VjU80ZQA1ZVwweqRoZrYqMAVwMqkZKR8hhYhc+1z1ywun+xcYcqQqyJcrjbIFZcKM9f1rPGcndPjDgvznj5SuZNpTw1CnNUdPBuEbeSgSkOm1Q8Mo289NjKhcrFfhRmJfxLJXpS3mk2sr0+0MUIzko/S8xC8tfyFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tj7Op+W5gW6PBp37Em8LaxkibiSXWc1PFz0sAu/mN+0=;
 b=e17adTV85o5PmOCL29TVa5viP6HzqQAiTSYtGEjMOA8hHflWpdc2SlqerVhAvrGA1TIT8rC5JF/04f+PJ2YWHBFAbaj23DEJAnNbQWb59JCYF5dUD4roQ53rdYXsaC/93ydLHgFHcIsWMIVa2+DMq7oFGURk2I87SwRneMc3Acs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7771.namprd12.prod.outlook.com (2603:10b6:8:138::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 14:13:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 14:13:03 +0000
Message-ID: <e9cc8d81-5838-48f9-ad01-b43d90620091@amd.com>
Date: Tue, 24 Mar 2026 15:13:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Fix NULL bo_va dereference in VA clear path
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260324135710.2079864-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260324135710.2079864-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0282.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: fd3e0f6e-9ea4-40e3-432b-08de89af7680
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: SJlxZELtLsfdRuUTQ5nNjUNyzAXKViW4trrUW3Xyy+CjyvLiqxuVQrk0CVkKa/Kq9T/EAy3Lvpx4p8dawwY2BpiFJJprbxuLlbZ+axhcDUdFfTmI85UDOna82vNil9VC567d7wqAIPzzCBX912kD3gWjTOLKzXTYi2GSsFhzzsgRCowTzpJu/G+lWAgzFrHqde0cuLSCwpcP/ZTpDgN4tKP4lCoy3TfWOI0NA3FjSyB49+A+EJmcCVUTAAHXVJ3rMtIwUbXJR3lPSRu87Yt4Ui6tbghBtPpuxp8ZB1TV4XROb6fikgEUJF7HocaTdcPkD4tddu7heOdVA2lRb7FU0sbcfnEgJj8OaiccLtC3XfOluuBgCjXVpArHRk4gKoVeRENelmAmy8+8hWYiZsKROIKux5gvchH0tj8couQR2/psbmzWh81/QDBFqnYK4lHCvx8l48QiscnPNV6UNNwxl7TdHdRWAWu7nJXqVRtkgJBoFyirFjHg+7kr31BZcVoK7/ePjm42ExtyGYhI08f6eJydOtJcmhHC4Me22wqRZQ5WiyaRLZ6Q7xTQ3YDEz31Wqj5ISiQocErf7v5/3E0msSFmxi2xsZfsYQkme5mBLpoSlZN1D1ufmucYhrL8zqF1LjA4xvzxAOHyaeDc40VOPwcUQ9yP1IHrb/HbuMZJkjHSBnzXgRtzTh/p/vpdqHC51ZZpz3Y8NRoSQ+iLGncpuQqT/GhDoz2FSM8139puanQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dCtTQUpaK2xEYzV2MGlmTFUzZXgxbjFrN0hVclNuR2UzTk9acmxPdmJGNDVt?=
 =?utf-8?B?RmlrcVAyVVd6YmszU1MrMFc0cXJLWVcxSDF2dUNzZFJjQnp1UzZFa3pJYW9M?=
 =?utf-8?B?N2ZCMzdWT1lKTmtXZmlhSUlzRkl3cUlDVGc2bWlsRENFVmV0ck52K050R1NK?=
 =?utf-8?B?bHZxRmJrQmUxUzh5NkRKSzlyZVlMUGgxZ1dsMzRJSFV6d3JQRFlsRjNIRzdl?=
 =?utf-8?B?ZVpqdjhNWkI5STVYNndrbjBDbTlUL3U1cFNSLzRFK2lJK2NZczVCSlFuRkZM?=
 =?utf-8?B?TlBwTHhLTTd4Vno2V0toMDBYVGUxQWVpZ2IxQmF4RndGYmd3R2Q0ZUdia2NE?=
 =?utf-8?B?ZUliSGRETTF6UWM5NnJ4a3hZdnlvNk5FK01DT25lUnJJM0VQazVBVklmY3ZM?=
 =?utf-8?B?M2I4d3lUNEZEcElqNVc3NUlDUHpnRTVIYnZJZWc3UzdhR0svd1RSVFhFeWpD?=
 =?utf-8?B?d2o0NEUyNlF0L0NqWlVSU3dRODVhY0hmOWZWbFVUN3cxSmNHeHRVekVwSk52?=
 =?utf-8?B?NlF3Yld2WENtNWR6dGF3c3BDc1lENWtHUHJYdjV2T2lzVFJRaWtBdlZEaE44?=
 =?utf-8?B?ZkF0WFZvMmtBK041eWFER2ZQSnhqL0pZMlJzL3NxOUFQeVAwYi8rNURGajM0?=
 =?utf-8?B?QmRCUnVrWlZsS3BDZWx3SnZPY2JrSUQwQzUvTWxWYjRWSmptc0pqTDkzQnJM?=
 =?utf-8?B?VGViMnBzdWNEV1ZGWXBLNTJvWFVNTGROT0lDVFEyajUwTGZPN3hNU3FsRFc5?=
 =?utf-8?B?YU04eUlzakJJck9DQmhWeHN1eEpSbGlxUGxWM0JCUWIvWlNNZGRPeG9TdTFa?=
 =?utf-8?B?RWlHbTRrZ2xCNjhTWUVHbXZsM1hJcjNCMHBDZWJ2RDJjbWcveUhWVkRRVENa?=
 =?utf-8?B?d0U4N1NkNTEza0pxV0FRbkh6ekY2RkFlaHlxOEtYSWVPMWE3NlExVGtDU2VO?=
 =?utf-8?B?enNFeEJiTjdPMDNsNGxRd1JQaGpDdjcwMVJ1Vk1oWm8xbjdwZGs3Vm1tRm1s?=
 =?utf-8?B?RGFrTGlUSERHMVJGM29FUDdYNy9oOVd4Z01rNDFqSHdFWThzN3paY05qN3gr?=
 =?utf-8?B?Q3lNeXVZVHR0dW5ZVy9JVDk1OXhYaTdCRkJPQzQzalVQdG9SN2p6dUNTT2ZM?=
 =?utf-8?B?UUQ4M0Q4d0MyaUpwS2ZRL0ZmekVZSXdDM0tuTG5pZEVTK2lobDF5RW1obXlD?=
 =?utf-8?B?TzJuNVhEMzM5RlV5dlQwZlZhZVJ0Z3RWMDNBZ2tGY1hMVmJ6K2VJZDNYckp0?=
 =?utf-8?B?b2J5cHptM1grcGs4T29MNG5ldUU5RE1YTU94a3M1ZDRFVENlWWk3aWwzc0xt?=
 =?utf-8?B?R1BtVW1YZVhwakY0c01idjRadVIrME0rcTVRTWRVZndPRWZDNTdrZHkxNGhL?=
 =?utf-8?B?Wkt0dW9DZGZZdCt2YlNPdDk5Tzh4TmJ1YzJwejVBdURJMFZFemlaWjdSWEdz?=
 =?utf-8?B?ZkhabjhabWZLbEZHWkluTFJPZWVlKzFkRnd3L0VkV0oyY3lxckIrUm9uMjZZ?=
 =?utf-8?B?RDNEOWV3aUlGSjljdlBrUkxWV3luSnBHSUJlMS9HWlFLMk5lQVNDa3l5RXpP?=
 =?utf-8?B?c1ZyRElRQW1QUVY4d0xUR0FWY3dTSTZlVGZSY1FwbVFFQmoxRUhKbFpleDhy?=
 =?utf-8?B?QWIxRDJodjY3M3hkMkExcWZOMWhUZmxMYUtXWG9ISkxraVV1dzZqQzJJUG9m?=
 =?utf-8?B?S1NMR1RheHg2Q3hxaHdjWFpuYU5oV2QyYUlKdzQvUmdJTy91YWoxRVhLQjhn?=
 =?utf-8?B?QlYvYlRLWExyWkJ4d0VqR2RwMDR1djZBMVFjYmZEdGZ6bzk0S2pqQlBvSjFp?=
 =?utf-8?B?ZmdFSERrbklDZFgwQmp5ZTRBVHZnaThmSVpiUUlnV3lZeU5EQlRJY3ArRFJt?=
 =?utf-8?B?cUptdUZIOGtZVW5PSlVlY3hFNDhkSXFoS0d3U1dKOWJoeUx1WmxtakpGSDFy?=
 =?utf-8?B?a0ovYkNabUlHZml3dWZTZjNHVit0S2dVK3JHbHl6aThNcjgrTFBDdkJJZ3hD?=
 =?utf-8?B?ZHBWTDJYOVlQS01SVVZnRnVNTkVWeFNCSGd1bDZBekQ4U2xqaW52VVg1YndG?=
 =?utf-8?B?RG12dUtiRTlSK1dVMm1jTDViZ3ZkSmJZcUtOdit0bmpLdHdEUS9icndWVEha?=
 =?utf-8?B?c2JHV21QVWxTNHVrRjdyNi9TWXo1Y3h2MnBldU82c1Y0Uzk1QTBDYzJhRS9W?=
 =?utf-8?B?ZVhaMzhsbHYxQjBZN3ZQcWZZc29NVXVCOHNoejhFVUxKQ0gvVVNaRFlzTVFS?=
 =?utf-8?B?UjgwVFRFVWVlTU42MGE1UE1RcnRaeXN0U2dwVG56K3preEpabkluL1Vad25q?=
 =?utf-8?Q?79Gmd5IZ4W0Sz8iGCO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3e0f6e-9ea4-40e3-432b-08de89af7680
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 14:13:03.7873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UYHkixcuVcrQ7UkWAN7PqlaEN85/XY2xeMvvLBRshrWoSmt1ipt5Hh8xWj8KGojd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7771
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

On 3/24/26 14:57, Srinivasan Shanmugam wrote:
> amdgpu_gem_va_ioctl() can call amdgpu_gem_va_update_vm() with
> bo_va == NULL for AMDGPU_VA_OP_CLEAR.
> 
> CLEAR operates on a VM address range and is not associated with a
> specific BO. In this case, the update helper should perform only
> VM-level updates and must not access BO-specific fields.
> 
> Currently, bo_va may be dereferenced in the MAP/REPLACE handling
> paths without explicitly guarding against NULL, which can lead to
> a NULL pointer dereference when CLEAR is processed.
> 
> Fix this by making amdgpu_gem_va_update_vm() explicitly handle
> bo_va == NULL:
> - Guard BO-specific accesses with bo_va checks
> - Warn if MAP/REPLACE ever reaches the helper with NULL bo_va
> - Keep VM update path unchanged for CLEAR
> 
> This keeps CLEAR on the common update path while ensuring safe
> handling of NULL bo_va.
> 
> Crash signature:
> [  325.716062] [IGT] amd_bo: executing
> [  325.779102] ==================================================================
> [  325.786483] BUG: KASAN: null-ptr-deref in amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.795105] Write of size 4 at addr 0000000000000000 by task amd_bo/7893
> [  325.801997]
> [  325.803595] CPU: 12 UID: 0 PID: 7893 Comm: amd_bo Not tainted 6.19.0-1314135.2.zuul.928a0cbbebc74c4f8d5a99a4d0a7ca55 #1 PREEMPT(voluntary)
> [  325.803602] Hardware name: TYAN B8021G88V2HR-2T/S8021GM2NR-2T, BIOS V1.03.B10 04/01/2019
> [  325.803606] Call Trace:
> [  325.803609]  <TASK>
> [  325.803612]  dump_stack_lvl+0x64/0x80
> [  325.803623]  kasan_report+0xb8/0xf0
> [  325.803631]  ? amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.804427]  kasan_check_range+0x105/0x1b0
> [  325.804432]  amdgpu_gem_va_ioctl+0x380/0x1130 [amdgpu]
> [  325.805229]  ? __pfx_amdgpu_gem_create_ioctl+0x10/0x10 [amdgpu]
> [  325.806022]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.806815]  ? __pfx___drm_dev_dbg+0x10/0x10 [drm]
> [  325.806894]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.807686]  drm_ioctl_kernel+0x13d/0x2b0 [drm]
> [  325.807767]  ? __pfx_file_has_perm+0x10/0x10
> [  325.807777]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
> [  325.807857]  drm_ioctl+0x4be/0xae0 [drm]
> [  325.807936]  ? __pfx_amdgpu_gem_va_ioctl+0x10/0x10 [amdgpu]
> [  325.808728]  ? __pfx_sock_write_iter+0x10/0x10
> [  325.808737]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
> [  325.808816]  ? ioctl_has_perm.constprop.0.isra.0+0x2ad/0x490
> [  325.808823]  ? __pfx_ioctl_has_perm.constprop.0.isra.0+0x10/0x10
> [  325.808827]  ? _raw_spin_lock_irqsave+0x86/0xd0
> [  325.808835]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [  325.808841]  amdgpu_drm_ioctl+0xce/0x180 [amdgpu]
> [  325.809622]  __x64_sys_ioctl+0x139/0x1c0
> [  325.809630]  do_syscall_64+0x64/0x880
> [  325.809638]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  325.809645] RIP: 0033:0x7f205fd12e1d
> [  325.809650] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10 c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00 00 00
> [  325.809654] RSP: 002b:00007ffe9032b510 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [  325.809660] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f205fd12e1d
> [  325.809663] RDX: 00007ffe9032b5b0 RSI: 00000000c0406448 RDI: 0000000000000006
> [  325.809665] RBP: 00007ffe9032b560 R08: 0000000100000000 R09: 000000000000000e
> [  325.809668] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000c0406448
> [  325.809670] R13: 0000000000000006 R14: 0000000000001000 R15: 0000000000000001
> [  325.809675]  </TASK>
> [  325.809678] ==================================================================
> 
> Fixes: dc54d3d1744d ("drm/amdgpu: implement AMDGPU_VA_OP_CLEAR v2")
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index b0ba2bdaf43a..145cb222d5cf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -759,9 +759,15 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> -	/* For MAP/REPLACE we also need to update the BO mappings. */
> +    /* For MAP/REPLACE we also need to update the BO mappings.
> +     * CLEAR operates on the VM address range only and can come in with
> +     * bo_va == NULL.
> +     */
>  	if (operation == AMDGPU_VA_OP_MAP ||
>  	    operation == AMDGPU_VA_OP_REPLACE) {
> +		if (WARN_ON_ONCE(!bo_va))
> +			goto error;
> +
>  		r = amdgpu_vm_bo_update(adev, bo_va, false);
>  		if (r)
>  			goto error;
> @@ -772,7 +778,8 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> -	if ((operation == AMDGPU_VA_OP_MAP ||
> +	if (bo_va &&
> +	    (operation == AMDGPU_VA_OP_MAP ||
>  	     operation == AMDGPU_VA_OP_REPLACE) &&

Something else must be broken here. We already check operation == AMDGPU_VA_OP_MAP or AMDGPU_VA_OP_REPLACE.

That should be enough to Ensure that bo_va isn't NULL.

Regards,
Christian.

>  	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
>  

