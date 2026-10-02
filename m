Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F18CCA5FD4
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 02:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0775A10E13A;
	Fri,  2 Oct 2026 02:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mt3u3JCn";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F5210E03A
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 02:59:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/MGCPPbea4ctJDU4kt69bwFxiamb5lOH2UOv5YJRRdu9lvyO0dS3WHUo5282AzJKx5wU2y/rkaeWRFV0lNiGWW2dkYVuHUVjYSRhL9+z4JRHGwu+OSJcOmH+CxLvswEiv84gciT+qM/eFtgd0e6GQ2p4lHH5sG6Zp+2UjNAdI+ZU77YT5G23sX7Uxauq8eVKIOZc0lT7Gofc9K3mBfwDNcK+fmqQEsF7d620Wnb0n+kPS7RGN4L45qdZD5rz74DPySDTpyrnPvOhHXFd9tqCxvSQRTBPbSKoixKz2Gqm42ZTjGjIK7iGkFtqlWTNMtChraiF7nLmLs+4IdpI2IROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PywHAzicqqyZ/4yCEt8HZ6coWwTLD22BvDwXga3Zbdc=;
 b=zTiB99JUpGZmDXoicCmgN+gAWBxWiZKQsvnd8JOwnRLLU9WkaOLlKhNgUbTa8Lt4n+7cnQ0txkjNfF050+gs7EMRSLeYexBvJg6alA05pxZZD0GwnhK199f4L7dkcikC4l2RI3SNG0WR7VrN3fPss0qhKt1clBvxa0oTHEE8uZRGx55WCpRzvW4v9ow4pAgW1WUFaEZj89szRNccUCYkElkN6/RnNPLDTOJOoC48wJvnS1Pvt7r4xSKLXdKhKpMp9n/Y/DUbI8xoostsdvUdgTXkSW7fvOpw+vvPlsC409sA8S1U9DQUn6iRWDpCQ1x4KCeWdclybdLsMbOXN4qzEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PywHAzicqqyZ/4yCEt8HZ6coWwTLD22BvDwXga3Zbdc=;
 b=mt3u3JCno9X51WxRSG9bMyxtCmrSztaqHxAjI7vrULxhGrbPrFjdS36wGZKaa0SyDzZ/x/HYceaYpk0ReJ47AaJjw40maDCbxnVyp1/BXSz2pbjOmi1VzUvvNTqB4+/14uv5t/pPkjgjBiPQ3YrycY46u6AVy85OccBnn54zyaE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8190.namprd12.prod.outlook.com (2603:10b6:208:3f2::7)
 by SA1PR12MB999251.namprd12.prod.outlook.com (2603:10b6:806:4dd::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 02:58:57 +0000
Received: from IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de]) by IA1PR12MB8190.namprd12.prod.outlook.com
 ([fe80::c581:f5cc:c58f:c5de%5]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 02:58:57 +0000
Message-ID: <47bfc751-1c4f-479b-a1b9-3a22aa3fab96@amd.com>
Date: Thu, 1 Oct 2026 22:58:54 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: copy debugfs register data outside the
 GRBM/SRBM locks
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 vitaly.prosyak@amd.com, tom.stdenis@amd.com
References: <20261001161307.24649-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: vitaly prosyak <vprosyak@amd.com>
In-Reply-To: <20261001161307.24649-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0467.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::23) To IA1PR12MB8190.namprd12.prod.outlook.com
 (2603:10b6:208:3f2::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8190:EE_|SA1PR12MB999251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5d531c-51dc-463d-71ab-08df20311a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|56012099006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kSytlk+d15IOkflAHunqpOqZ8m+oW7re1OQI1FGKGaHyTUdfRXh1nx3z8DlADk3qiambZgqtiyGiR32yfLcQoovoJLXwIutXkyx3lbp4d2DtMfIg/pnAQS+8Qj92nTnUKSVTD9kGKspiulnRHTgxSM8kEDxPx720bhiY14dZGzn4VEPnUI7Ny3sa6SJvcbObFNPKYeixZwsXR3QHJpSyvNE3s/Uy1oY3PmWTulgINIcooBEjpmkbXSBvq+SHjq1XnFdmel+jNKHKDUNy/qjaO2F2G+V8L7aKrxke9YMfNoJpte6nDfaww4En5zB5bZBiCX8Hz03rQL7ZjeGC10krDqlkVfW8yxmnDOfG5Qm+wlKq8dhcD71HVy+VnYGLI4t1TcC5CDZTYfPQF2n6x40tUW+BL+Q3oF7InOln8i41kYKJ6TbeUK3/lSVAiwMYYYNhWoCFnHTUvxeageIWvphLMzRQS4CQjNnW7EJQC7LPbCy8NTYMDdf4icVwB7HhPkTPRi15jlsK31TcAah/A4VqJBntCzT3VIHWEMKrdlGWXunmppriVYujMBWXoDNgQyJoB5V30WXFWREdA6PGgAsC6cSDIs7kR8b/LaUgnTUPEnRL9FqYgAmOKhiG9lewpZZLEYcNjQgVW+CpVM59bSntMTOpniWF7SmEF+ZZ4QjPWTc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8190.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTRwTktXa1FnTUFRYWkxRTVRVVI0bXE5YjRuTFhFNzc1WCszZ20xVkt3MUUz?=
 =?utf-8?B?M0FpdTJOYTk0dmVEMmV4UWFjQVpVTzFsTDFpcHJvMWhsYWk0MEs5dmFaSnRB?=
 =?utf-8?B?SllpTlB1R3ZScXhyUEZuWkdDWVpBMnRrLy9RSkdVMTJKM2YvNExjekVTV3ha?=
 =?utf-8?B?b1RJRFdRbHdna25iNzNCeGRtV2VyT25FRmJ2bWZJbWgvYTVpc1JDdkl1dEUr?=
 =?utf-8?B?WExlVXd4UjBuYmR4bnBJaEJPMTJFZC9WZUVmU0ZEN2tFcXpQRlZmZ3Y0bTlQ?=
 =?utf-8?B?REhsaytZcEI3azA0THFCazR2TnNTMHlrTnNoYVptQ081dkxtYVljV1VXbW4w?=
 =?utf-8?B?eXEyWHZUYzEvUWlsckI2V1MwbzdjWW1QZVFKSHdIOFRuWDZCU3FOTjhyS0xr?=
 =?utf-8?B?QWxkSW5BdnBhOHdjY1Zxako2K0tCM3lqUGdyYXo0S04xR2dQZUtsVitNRTlP?=
 =?utf-8?B?S2xLNXNsRFZ2UXhWN3ZXdWlXZ203TDJNVWs0VjNZWEVnNGxPdTd5b0ZZSGV0?=
 =?utf-8?B?c0wyRkwyU3RnajNlSnNpUGNhc3oyQmhnMVY3M2RxQ09meTl4SGZUTTA3c1Iz?=
 =?utf-8?B?NHo2dFJDNDNmZk9NdDdGeGtEVXdUcTVQcHZvR0tuc3FLN3dIbTlMNTZyL3Bm?=
 =?utf-8?B?dFJYbEdMaUtRbksxM3p3bHorRlluY2haNkZCbGJtVkJhL3hXUWZpS2wxZ3lo?=
 =?utf-8?B?WWd0VUpvSTFTT0M2V3VVUExZUE5nTklETHpuWm82Sm54RGZWTDNvNXdSdE9T?=
 =?utf-8?B?SGFlZUNKQnpBRVByeHZCa2FtdDN3cWlTTGtsemhIK0V2cWlWMTdnNkszSkov?=
 =?utf-8?B?SzI0cU1yNVNSa3JBVFVtYUwvckFnVlErWnBGVi9xV1MvNDRPUFFFVGZoazdC?=
 =?utf-8?B?QnBlblh5eC8yd1V5TEZGYUlMVVZUb0Q5QWRzYmtNUmp5NXlnL2p0NlA3dGZs?=
 =?utf-8?B?dmZEdkFwbXdSdUtvMDRMQXRMcm5zNlAzR3M2eE8vVEFVTmNVY0pDRnBncDFu?=
 =?utf-8?B?dWJlR0EvcTBwQ0M2bnRxamE2NmhOVmU3R3V5azBmQnVYdTNRUjFxcnhHbjdz?=
 =?utf-8?B?d3NIODZlWnVia0ZBWEdCNGtLWk1rZDZDSytGaUg1KzB4M0lCVUtPTHhUWC9y?=
 =?utf-8?B?ZVZyclpwaHFldlBLbGZrUExUTTlzQXVvdWVkVFNDTnA0RnVlV2s2c2tVU2NZ?=
 =?utf-8?B?VHl5Z1BST3VtbkpNeVhRbHhHZWdxSGVUN0ZidndoMHZzckg2dWlQTjNlc0dx?=
 =?utf-8?B?OUNpR0ZpMy9RU2RnMm1IKys0T3RGaWxscVYyd2MxSnVGWXI2TnUxQVlHVWlS?=
 =?utf-8?B?Nm5ZY1NlWTlJNEFJVk5RbGhpaE8rSlpwbHRHS3RNanRLUG1pNnRrbWZUY0F3?=
 =?utf-8?B?clVjSDR2U2ZDVm9lRXVCZUxTeFl1NHpwbHJyUFBnQ1dQQzlHb0lTVjRDUDdX?=
 =?utf-8?B?YzIwTHVoRzIyRWJKZDdFVm1uVGl1TU9SK1NXT0hGd1lhSURKaUxVR3pZVDUx?=
 =?utf-8?B?ZVhWeGIxRDE5VHlDdXJmQlFTQlYyNkMrMFVWMnVlcnVVWFN5OTYyV1lHQ2tt?=
 =?utf-8?B?R1pQdHhXbytrSTNZNVUwR1NhejQ4dEFKbS81Q1FEKzBkd2JFV1V3WEdDck1Y?=
 =?utf-8?B?d0JlR0xnZEJmV3o3cGpBZStsTHJlcTNPV21HY3F6eUJoSldWT3FVbGxiR0JU?=
 =?utf-8?B?Wk5ZVWIxTDIzclQzaDQxRk9mV1hZWlBORlo1N3hnUWZCZnhFQXVjWWpSbXVD?=
 =?utf-8?B?YWFUNGw3RWlxM0tmcEtzb0tIRFRkd0luVWtPd2l6M3B2T2hMTmNjQUFNNGN5?=
 =?utf-8?B?SXFXSUw3azZWMkMxNTRoSFJaSGJJbDBHZjFRQTFQb2c0bUxlQWRmTFFDbGd2?=
 =?utf-8?B?d3dHQjlTeWxPcjZFZFZTdnF2UWdLbm9ONHhSTWFlMW9ZNFNQWS9JdFZDQkNi?=
 =?utf-8?B?NzFGUk1nZC92S3hNS1FacmVFWUtWeVd5aGQ4T0gveGlqbG9hTk5vTXVhUi93?=
 =?utf-8?B?bmt3TkpJY1dZWnVmblpXb25JbXZ4blc4aENJbjY5MjB6WVJzRjlXSFhKZ1BQ?=
 =?utf-8?B?ZG9zM2tBc2d0RGJ1VXZrSUhmcGFVZTNtOUZRcnE5dmxIN3VGdHU5K2ExT29x?=
 =?utf-8?B?aUp0LytzT1hFNk5XR0Y2OFd2OUc4cEZVQWtCQUx6c0VNVFVoRldlUmRVTHdh?=
 =?utf-8?B?Q0llc0RGdnFtS3ppQWtsbkYyR1liUUoyKzBDQzZjNHAzVmc2UmZKaFlTYXR3?=
 =?utf-8?B?aHFEN2hZZ3dlNWNITithb3ZXSmgxODRReFFlUWk5ZzBGQlNlRUFTcmRkU09J?=
 =?utf-8?B?Y3JkU3gxaitGRmI2d0JtNnRVU1JYNlV1dEwrTU1Ua3ExNjl1M2xBUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5d531c-51dc-463d-71ab-08df20311a13
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8190.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 02:58:57.5361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Y2H0Bjt4Hou3A5jckvnOSdxs1+H2eHxG+xy36RHgPjeI2A9HFIt86LI1KJNEqN99ijC9wb2vr6AYczxMXMe8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999251
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

Thanks Mikhail ! Merged.

Vitaly

On 2026-10-01 12:13, Mikhail Gavrilov wrote:
> Reading or writing a register through the amdgpu_regs2 debugfs file
> with GRBM bank selection, which umr does for every banked access (a
> single "umr -b x x x -r <reg>" is enough, as is the wave dump with
> "-O halt_waves"), makes lockdep report a circular locking dependency,
> after which lockdep stays off until reboot:
>
>   WARNING: possible circular locking dependency detected
>   umr/63306 is trying to acquire lock:
>   ffff8882cf4b8350 (&mm->mmap_lock){++++}-{4:4}, at: __might_fault+0x9b/0x140
>   but task is already holding lock:
>   ffff8881aec010d0 (&amdgpu_grbm_lock_key){+.+.}-{4:4}, at: amdgpu_debugfs_regs2_op.isra.0+0x20d/0xd00 [amdgpu]
>   ...
>   Chain exists of:
>     &mm->mmap_lock --> &amdgpu_srbm_lock_key --> &amdgpu_grbm_lock_key
>   ...
>    __might_fault+0xc5/0x140
>    amdgpu_debugfs_regs2_op.isra.0+0x441/0xd00 [amdgpu]
>    full_proxy_write+0x10e/0x1d0
>    vfs_write+0x1d0/0xf50
>    ksys_write+0x116/0x250
>
> amdgpu_debugfs_regs2_op() and amdgpu_debugfs_process_reg_op() call
> get_user()/put_user() for every dword while holding grbm_idx_mutex or
> srbm_mutex, and pm.mutex if requested, so a fault there takes mmap_lock
> inside those locks. The lock hierarchy in amdgpu_lockdep.c puts
> srbm_mutex and grbm_idx_mutex below notifier_lock, which
> amdgpu_cs_submit() takes with the BO reservations held, and
> dma_resv_lockdep() orders the reservations inside mmap_lock. So
> mmap_lock is outside grbm_idx_mutex and srbm_mutex, and these two
> debugfs paths nest it the other way round. The copies under the locks
> are as old as the bank selection in both files; commit 1d0f5838b126
> ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
> only made them visible to lockdep.
>
> Copy the user buffer in before any of the locks is taken and the result
> out after all of them are dropped, as amdgpu_debugfs_wave_read(),
> amdgpu_debugfs_gpr_read() and amdgpu_debugfs_gprwave_read() already do.
> The buffer is sized by the count passed to read() or write(), so an
> access larger than PAGE_SIZE is now rejected with -EINVAL; umr reads and
> writes one register at a time. A fault on the user buffer of a write now
> fails with -EFAULT before any register is written, instead of after a
> partial write.
>
> Fixes: 566281595037 ("drm/amd/amdgpu: Add bank selection for MMIO debugfs (v3)")
> Fixes: 37df9560cd3e ("drm/amd/amdgpu: New debugfs interface for MMIO registers (v5)")
> Acked-by: Christian König <christian.koenig@amd.com>
> Acked-by: Tom St Denis <tom.stdenis@amd.com>
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>
> Notes:
>     v2:
>     - Fixes: point at the commits that introduced the user copies under the
>       locks, not at the lockdep annotation that made them visible
>       (Christian).
>     - Reject an access larger than PAGE_SIZE before allocating the buffer
>       (Vitaly); umr only does 4-byte accesses (Tom).
>     - Allocate the buffer with kmalloc() instead of kvmalloc() (Christian).
>     - amdgpu_debugfs_gprwave_read() needs no change: it already calls
>       put_user() after dropping grbm_idx_mutex.
>     - Christian's and Tom's Acked-by were given on v1; the size check and
>       kmalloc() are the only code changes since.
>     - The test notes went out as a separate reply to v1; they are part of
>       the patch mail now.
>     
>     v1: https://lore.kernel.org/amd-gfx/20260930154934.27981-1-mikhail.v.gavrilov@gmail.com/
>     
>     Tested v2 on Navi 31 (gfx1100), 7.3.0-rc5 at 551c722f4080, with lockdep.
>     
>     Without this patch the first GRBM-banked access through amdgpu_regs2
>     produces the report above: from the write branch when umr halts
>     waves, and from the read branch for a single
>     "umr -b x x x -r '*.gfx1100.regGRBM_STATUS'" on a fresh boot.
>     
>     With this patch, and with the chain from reservation_ww_class_mutex
>     through &amdgpu_notifier_lock_key down to &amdgpu_grbm_lock_key present
>     in /proc/lockdep, none of the following produced a report, and
>     debug_locks stayed 1:
>     - the banked read of GRBM_STATUS* above;
>     - "umr -O halt_waves -wa gfx_0.0.0" (banked SQ_CMD writes);
>     - writing SCRATCH_REG0 and reading it back through amdgpu_regs2 with
>       GRBM broadcast, and through amdgpu_regs with the bank bits in the
>       offset; both reads returned the value written.
>     A 4100-byte read of amdgpu_regs and of amdgpu_regs2 fails with EINVAL.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 77 ++++++++++++---------
>  1 file changed, 46 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index aca1a8045a..ab7ccfaea2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -121,6 +121,20 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>  
>  	*pos &= (1UL << 22) - 1;
>  
> +	if (size > PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * Access the user buffer only while none of the locks below are held:
> +	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
> +	 * inside it.
> +	 */
> +	u32 *data __free(kfree) = kmalloc(size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	if (!read && copy_from_user(data, buf, size))
> +		return -EFAULT;
> +
>  	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (r < 0) {
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -152,28 +166,16 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>  		mutex_lock(&adev->pm.mutex);
>  
>  	while (size) {
> -		uint32_t value;
> -
> -		if (read) {
> -			value = RREG32(*pos >> 2);
> -			r = put_user(value, (uint32_t *)buf);
> -		} else {
> -			r = get_user(value, (uint32_t *)buf);
> -			if (!r)
> -				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
> -		}
> -		if (r) {
> -			result = r;
> -			goto end;
> -		}
> +		if (read)
> +			data[result >> 2] = RREG32(*pos >> 2);
> +		else
> +			amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, data[result >> 2], 0);
>  
>  		result += 4;
> -		buf += 4;
>  		*pos += 4;
>  		size -= 4;
>  	}
>  
> -end:
>  	if (use_bank) {
>  		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
>  		mutex_unlock(&adev->grbm_idx_mutex);
> @@ -188,6 +190,10 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	amdgpu_virt_disable_access_debugfs(adev);
> +
> +	if (read && copy_to_user(buf, data, result))
> +		return -EFAULT;
> +
>  	return result;
>  }
>  
> @@ -238,11 +244,24 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>  	struct amdgpu_device *adev = rd->adev;
>  	ssize_t result = 0;
>  	int r;
> -	uint32_t value;
>  
>  	if (size & 0x3 || offset & 0x3)
>  		return -EINVAL;
>  
> +	if (size > PAGE_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * Access the user buffer only while none of the locks below are held:
> +	 * a fault takes mmap_lock, and grbm_idx_mutex and srbm_mutex nest
> +	 * inside it.
> +	 */
> +	u32 *data __free(kfree) = kmalloc(size, GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	if (write_en && copy_from_user(data, buf, size))
> +		return -EFAULT;
> +
>  	r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>  	if (r < 0) {
>  		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -281,24 +300,16 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>  		mutex_lock(&adev->pm.mutex);
>  
>  	while (size) {
> -		if (!write_en) {
> -			value = RREG32(offset >> 2);
> -			r = put_user(value, (uint32_t *)buf);
> -		} else {
> -			r = get_user(value, (uint32_t *)buf);
> -			if (!r)
> -				amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, value, rd->id.xcc_id);
> -		}
> -		if (r) {
> -			result = r;
> -			goto end;
> -		}
> +		if (!write_en)
> +			data[result >> 2] = RREG32(offset >> 2);
> +		else
> +			amdgpu_mm_wreg_mmio_rlc(adev, offset >> 2, data[result >> 2],
> +						rd->id.xcc_id);
>  		offset += 4;
>  		size -= 4;
>  		result += 4;
> -		buf += 4;
>  	}
> -end:
> +
>  	if (rd->id.use_grbm) {
>  		amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, rd->id.xcc_id);
>  		mutex_unlock(&adev->grbm_idx_mutex);
> @@ -317,6 +328,10 @@ static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user *buf, u32 off
>  	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>  
>  	amdgpu_virt_disable_access_debugfs(adev);
> +
> +	if (!write_en && copy_to_user(buf, data, result))
> +		return -EFAULT;
> +
>  	return result;
>  }
>  
>
> base-commit: 551c722f40809618230001baccf219193e22fc5a
