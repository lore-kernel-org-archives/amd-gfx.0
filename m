Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9E3C021A0
	for <amd-gfx@archiver.kernel.org>; Sun, 16 Feb 2025 02:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CB8110E1FE;
	Sun, 16 Feb 2025 02:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wNOf+COx";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2ABF10E1FE
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Feb 2025 02:43:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8fCRklg9ImpZzQ0Loah9wxzPU0aeb5XjFC9Ukz2hMqzWKLYMoIj18d5cxdKBJVTgEElvV6g3csmqam4dl3ec0gartDi0zhF0SHir0v4Mb5xI/akTRaCUmYsAYcMc82cljLEuf6+KkDVvBVIwx1hHYgWAOg9qKzDQ3sX5ZQSTRHvhLsBRXYIMVJLL1Xz4fzfeH8S4EmmRyrrRC5phn4ZRaml8dpfaKsfMvKiU144TaY7wGwm2i+BMgUbDhPY6HvY1N6u7zUR5s/KiPhf4FI2xnGgyvVp/+ZKiBfs35p/+f+ZHPu3nolM0kc7NWGIDC/55sUws9kU/gEIDzsfMnjnuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKidgzyJFo1QVhQqQdl1gx55c5cVR71CQMPme2s6+fI=;
 b=QeJ/eFmpKIJ1ee0QBdklJWP5E6ZHkouoagCPZql+I8sXejV7x1Tez9z9QcSnxlX1baGDT3UEJSIdUY8+uNAmrGZyTZtnoXYJ44ar1y9dscfRhTJDupSSjAxcTMkBUt3DBjrDs4WsFvrkbf58E9/Vy+2a2WKEM/3k6RqlSVJr7uVodF9W8UHZNzRHrV4NVRZR+wuqsVsRfB2jPH3UW+XGLYnfzScl0nkWm7feUal5iqQGPwd3k81z1q76HcKq30nXlhXlBuGtjI8FSmczYGE4b1ampCoFGgYNhHRAkJui/NCv1oR53PYA4OQ2nWSaY4O4lws6YhnwhGNt4V9lkZzRsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKidgzyJFo1QVhQqQdl1gx55c5cVR71CQMPme2s6+fI=;
 b=wNOf+COxfo0/i63roDodWxD5JjGnNR1sVOxCdbMwuinYG3HVKWM42A8bdvf2ZLVrnwOsyD0SMV8L9JthtZQ7gB7UiiEh7sfTS4A0e5ehRc8hzU6WlgR0TeXDTChgPqiQCEh86j9R6efUsxc5sm8LGKT0KE4Jelk1QfyfUmwnfgs=
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Sun, 16 Feb
 2025 02:43:22 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::87) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.11 via Frontend Transport; Sun,
 16 Feb 2025 02:43:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Sun, 16 Feb 2025 02:43:21 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 15 Feb 2025 20:43:18 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, lin cao <lin.cao@amd.com>, Jingwen Chen
 <Jingwen.Chen2@amd.com>, Victor Skvortsov <victor.skvortsov@amd.com>,
 "Zhigang Luo" <zhigang.luo@amd.com>
Subject: [PATCH v2] drm/amdgpu: Replace Mutex with Spinlock for RLCG register
 access to avoid Priority Inversion in SRIOV
Date: Sun, 16 Feb 2025 08:13:05 +0530
Message-ID: <20250216024305.687247-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250214085755.662775-1-srinivasan.shanmugam@amd.com>
References: <20250214085755.662775-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4da12f-5ccf-42e1-8dc5-08dd4e33ad55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OXlHME1tWlZpNW5VN0VHSmdLQ3dvUXY2VzR4MlpBWGxERVpGczRyRHhqNjFZ?=
 =?utf-8?B?aElVSnk1SG9PWlRuM0tOSUc3c3ZZM0xCMlpRTlBMNGsvZnlTUVYwRE1icHI1?=
 =?utf-8?B?aTZZcXNFSnRJbVVvRGhEL3MyeE9odnV3RmhjaVNueE9EV3NlUnhGanJpMnFS?=
 =?utf-8?B?QXBSUDlSMllRdUhTMFJqNm4xYXBLdWg2WVlkblNNb3BVMjJrR3VtWTZvYzZF?=
 =?utf-8?B?ZXd1SGI1bnRUbmVEK25vaFdhcHA2SFZwZ2tXaGZ0RU5hRmFQSWRtdTQwNVp1?=
 =?utf-8?B?amdIUzVncUpsTXpvQUpESDhmci8vOXVveUg2NDRBc0tDemxHTGthVUZ2VVRR?=
 =?utf-8?B?TnhZMEtFS3JMZ0NyTmJtL0FuQTA5em5DVEl1MGxkNDV6dmdqcWcvT1ZiMnBH?=
 =?utf-8?B?cWpKVTNVL3BTMk1WL2xrRGQ3NWdLVzA0V3dFZXFiYWY0UHFUaWZ5RU50emFN?=
 =?utf-8?B?RUtTaU5vV0RUYzNEY2RTWE1mVm42cW52UHZiNkVscjZodjJhVzVmaFliZ3Fj?=
 =?utf-8?B?cWVUbVp1SFk1eU1wVXJyY2JBbFcwdG5KWU55NEZtQ0hOU3dyS3dPOWJYTWxN?=
 =?utf-8?B?blYycjVYVUFaNFRuL1FSM2xieUcyTkhsWmJoV05jUXpSTkFQVlNhR1I3c2tl?=
 =?utf-8?B?ZFpQb1QrbzZYRzJ1Qkc3ZkVwRnZRck1HYWxIanp6cE0ybHNoY3REc3lrbzBn?=
 =?utf-8?B?RlIxdGpMNWdNZkpiMU1TVGhtR2VpaEJJUGtkb0JQVDVIOGw3eWdCalNmRWpP?=
 =?utf-8?B?eWx4N1JrblNteFpGc2pUSHJxY0IrLzNJTFo2SmtiZWFKQWtuMUUwYmlKbmJZ?=
 =?utf-8?B?Skt6cnd1bnFqcllicUJvT0xZcGFLSDZnWEhBYUMzZE9PditiYmdmbVMxbHR2?=
 =?utf-8?B?bzJzRXdKVXJVbjltRHhzcnQzMkMwMlllSWhFeWh5MmdZSE9LOVB5UThEeldF?=
 =?utf-8?B?R2lsYWZQNmxzc0lIVEsybVRoVng3dU1hbU10UWxwTFFCdHE5bFJYQURIeGJz?=
 =?utf-8?B?OEREck5WZHJLRWRGdWtvdko5Yml2NHdHaVVkVXI5VjFkRjFkSU8rZmltTGVQ?=
 =?utf-8?B?RFRFNzBZUFo5VXFvbE1rckpqVWVFS0tJK1BnTTNHa2crZXltYlB3cE5ZYWZM?=
 =?utf-8?B?Vmc2Rkg2Zm1KeUpEVzFrUTFXS3RFL01mWlZrS0taYkltei9qRjlycCt2VEpX?=
 =?utf-8?B?c3l2TXhPZDllK0pwaUZKcDhpOTZkRTZGZ3R6amJ5RXRYTzZIbndTalJ3Y0gv?=
 =?utf-8?B?SlR2S3NqZGdTeVN5NTlhVEtseFBFbHhKQVpWdWVSS3pwZGhxcVVCQTFqWXVR?=
 =?utf-8?B?NnJnaU5NV1hVeEoyeHRFNldxMG1QOHF0VE1wYmloUjY4Vmh6ZEUrR2hUREJC?=
 =?utf-8?B?TkhjUkdDci9VdWNzVGlUVlQvWVpNajZIWEhGaXRMdysxZGxsQ0hhOVlXcHp4?=
 =?utf-8?B?U1FRWkUyc2tWc3YvWnZIYjZibUJ1bHc0eXgxZUVkR3JSMmJzSm9EK0VwOHJI?=
 =?utf-8?B?M0pXdTFqWXVUckNoMGJ5VGVEbGRkVnNINWQ0VENEMEcvdUNQYlRlSERLZ0RJ?=
 =?utf-8?B?U1Q1VXpKT2dFZ0M2ME1wWnc2dXBMR1RtK2t5U0sxcytQMzdlL25JeXdnSTFQ?=
 =?utf-8?B?THZscjJLZ2YySnhqak90eWZhWTZjZWluTmNsa1g4UFJaNUJzcEEydDFHVFZZ?=
 =?utf-8?B?L2ZSeHBKdzUyalpOYU9CdldVR3pDeElHelNzaFNkSUFJcDZ6b3haUVptcFlT?=
 =?utf-8?B?Y0pxcHAwQjc2cDgrWEViZnkwQ3N1alRKakFLSVh3Vis5Z1RtejFBcnlGa1Z5?=
 =?utf-8?B?MSsrVFZJYVgzMXpqaVZWWkUvbThUZGlWeE5XVGRCRUpkMVRhM0ttVnVJbFRE?=
 =?utf-8?B?c3ZEOEtTQVp3MkdCZ0d3T0FYYjhBTU40TzNaUTc5L1QzV251a3N4ZXJmb0k0?=
 =?utf-8?B?eko0ZXJBVUZwaGVKa2xVL09Tc2lPbGRpTjdvOXVNWEduQmU1eFppajVxUVVj?=
 =?utf-8?Q?ZASmXtQcVZfY0F1fiB9BFbe/HQkNSU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2025 02:43:21.3279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4da12f-5ccf-42e1-8dc5-08dd4e33ad55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
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

RLCG Register Access is a way for virtual functions to safely access GPU
registers in a virtualized environment., including TLB flushes and
register reads. When multiple threads or VFs try to access the same
registers simultaneously, it can lead to race conditions. By using the
RLCG interface, the driver can serialize access to the registers. This
means that only one thread can access the registers at a time,
preventing conflicts and ensuring that operations are performed
correctly. Additionally, when a low-priority task holds a mutex that a
high-priority task needs, ie., If a thread holding a spinlock tries to
acquire a mutex, it can lead to priority inversion. register access in
amdgpu_virt_rlcg_reg_rw especially in a fast code path is critical.

The call stack shows that the function amdgpu_virt_rlcg_reg_rw is being
called, which attempts to acquire the mutex. This function is invoked
from amdgpu_sriov_wreg, which in turn is called from
gmc_v11_0_flush_gpu_tlb.

The [ BUG: Invalid wait context ] indicates that a thread is trying to
acquire a mutex while it is in a context that does not allow it to sleep
(like holding a spinlock).

Fixes the below:

[  253.013423] =============================
[  253.013434] [ BUG: Invalid wait context ]
[  253.013446] 6.12.0-amdstaging-drm-next-lol-050225 #14 Tainted: G     U     OE
[  253.013464] -----------------------------
[  253.013475] kworker/0:1/10 is trying to lock:
[  253.013487] ffff9f30542e3cf8 (&adev->virt.rlcg_reg_lock){+.+.}-{3:3}, at: amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.013815] other info that might help us debug this:
[  253.013827] context-{4:4}
[  253.013835] 3 locks held by kworker/0:1/10:
[  253.013847]  #0: ffff9f3040050f58 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x3f5/0x680
[  253.013877]  #1: ffffb789c008be40 ((work_completion)(&wfc.work)){+.+.}-{0:0}, at: process_one_work+0x1d6/0x680
[  253.013905]  #2: ffff9f3054281838 (&adev->gmc.invalidate_lock){+.+.}-{2:2}, at: gmc_v11_0_flush_gpu_tlb+0x198/0x4f0 [amdgpu]
[  253.014154] stack backtrace:
[  253.014164] CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Tainted: G     U     OE      6.12.0-amdstaging-drm-next-lol-050225 #14
[  253.014189] Tainted: [U]=USER, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
[  253.014203] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 11/18/2024
[  253.014224] Workqueue: events work_for_cpu_fn
[  253.014241] Call Trace:
[  253.014250]  <TASK>
[  253.014260]  dump_stack_lvl+0x9b/0xf0
[  253.014275]  dump_stack+0x10/0x20
[  253.014287]  __lock_acquire+0xa47/0x2810
[  253.014303]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.014321]  lock_acquire+0xd1/0x300
[  253.014333]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.014562]  ? __lock_acquire+0xa6b/0x2810
[  253.014578]  __mutex_lock+0x85/0xe20
[  253.014591]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.014782]  ? sched_clock_noinstr+0x9/0x10
[  253.014795]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.014808]  ? local_clock_noinstr+0xe/0xc0
[  253.014822]  ? amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.015012]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.015029]  mutex_lock_nested+0x1b/0x30
[  253.015044]  ? mutex_lock_nested+0x1b/0x30
[  253.015057]  amdgpu_virt_rlcg_reg_rw+0xf6/0x330 [amdgpu]
[  253.015249]  amdgpu_sriov_wreg+0xc5/0xd0 [amdgpu]
[  253.015435]  gmc_v11_0_flush_gpu_tlb+0x44b/0x4f0 [amdgpu]
[  253.015667]  gfx_v11_0_hw_init+0x499/0x29c0 [amdgpu]
[  253.015901]  ? __pfx_smu_v13_0_update_pcie_parameters+0x10/0x10 [amdgpu]
[  253.016159]  ? srso_alias_return_thunk+0x5/0xfbef5
[  253.016173]  ? smu_hw_init+0x18d/0x300 [amdgpu]
[  253.016403]  amdgpu_device_init+0x29ad/0x36a0 [amdgpu]
[  253.016614]  amdgpu_driver_load_kms+0x1a/0xc0 [amdgpu]
[  253.017057]  amdgpu_pci_probe+0x1c2/0x660 [amdgpu]
[  253.017493]  local_pci_probe+0x4b/0xb0
[  253.017746]  work_for_cpu_fn+0x1a/0x30
[  253.017995]  process_one_work+0x21e/0x680
[  253.018248]  worker_thread+0x190/0x330
[  253.018500]  ? __pfx_worker_thread+0x10/0x10
[  253.018746]  kthread+0xe7/0x120
[  253.018988]  ? __pfx_kthread+0x10/0x10
[  253.019231]  ret_from_fork+0x3c/0x60
[  253.019468]  ? __pfx_kthread+0x10/0x10
[  253.019701]  ret_from_fork_asm+0x1a/0x30
[  253.019939]  </TASK>

Fixes: e864180ee49b ("drm/amdgpu: Add lock around VF RLCG interface")
Cc: lin cao <lin.cao@amd.com>
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>
Cc: Victor Skvortsov <victor.skvortsov@amd.com>
Cc: Zhigang Luo <zhigang.luo@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2: s/spin_trylock/spin_lock_irqsave to be safe (Christian). 

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 5 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index eab530778fbd..14125cc3a937 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4251,7 +4251,6 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->grbm_idx_mutex);
 	mutex_init(&adev->mn_lock);
 	mutex_init(&adev->virt.vf_errors.lock);
-	mutex_init(&adev->virt.rlcg_reg_lock);
 	hash_init(adev->mn_hash);
 	mutex_init(&adev->psp.mutex);
 	mutex_init(&adev->notifier_lock);
@@ -4277,6 +4276,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	spin_lock_init(&adev->se_cac_idx_lock);
 	spin_lock_init(&adev->audio_endpt_idx_lock);
 	spin_lock_init(&adev->mm_stats.lock);
+	spin_lock_init(&adev->virt.rlcg_reg_lock);
 	spin_lock_init(&adev->wb.lock);
 
 	xa_init_flags(&adev->userq_xa, XA_FLAGS_LOCK_IRQ);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 2056efaf157d..e6f0152e5b08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -1017,6 +1017,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	void *scratch_reg2;
 	void *scratch_reg3;
 	void *spare_int;
+	unsigned long flags;
 
 	if (!adev->gfx.rlc.rlcg_reg_access_supported) {
 		dev_err(adev->dev,
@@ -1038,7 +1039,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 	scratch_reg2 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg2;
 	scratch_reg3 = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->scratch_reg3;
 
-	mutex_lock(&adev->virt.rlcg_reg_lock);
+	spin_lock_irqsave(&adev->virt.rlcg_reg_lock, flags);
 
 	if (reg_access_ctrl->spare_int)
 		spare_int = (void __iomem *)adev->rmmio + 4 * reg_access_ctrl->spare_int;
@@ -1097,7 +1098,7 @@ u32 amdgpu_virt_rlcg_reg_rw(struct amdgpu_device *adev, u32 offset, u32 v, u32 f
 
 	ret = readl(scratch_reg0);
 
-	mutex_unlock(&adev->virt.rlcg_reg_lock);
+	spin_unlock_irqrestore(&adev->virt.rlcg_reg_lock, flags);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index 270a032e2d70..0f3ccae5c1ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -279,7 +279,8 @@ struct amdgpu_virt {
 	/* the ucode id to signal the autoload */
 	uint32_t autoload_ucode_id;
 
-	struct mutex rlcg_reg_lock;
+	/* Spinlock to protect access to the RLCG register interface */
+	spinlock_t rlcg_reg_lock;
 
 	union amd_sriov_ras_caps ras_en_caps;
 	union amd_sriov_ras_caps ras_telemetry_en_caps;
-- 
2.34.1

