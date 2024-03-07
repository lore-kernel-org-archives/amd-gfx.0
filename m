Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748D3C54E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 01:56:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4C7011368D;
	Thu,  7 Mar 2024 01:56:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LflQnoKV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 301E511368D
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 01:56:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhxTGCKauaOFdqPHgEeDgvST9VRBhL+Ozk1D7OUM3XfOegN4pXcIqvwGW7a5+RU9rLwyVaN4pF/9N2ZVHxGA1vgD04Hh/ufw+/ef1kyIzDQF5zZTCx4RLe/aytr8FHd8fCZtPbfj+IPG1meJ0vFQ4y5va/yHQT83YwYJ5zafjrnwnJ1WucVtS1gpWxGVGuP9tjPKFZ7SmpdWkjgxYKqFDShBwSUQgdyYyiDdfyI7APJBcJhfRT4s096KdNBEVZ88DutP96QhTTNsVUBBt7pmQjvpDND2wQqSAx4nxV0rhJoyoK4s5Dso5IPo6ub2oWS5IopdmBZRCkLpJu/I5oBwJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zMzdBqWffuABCYzks23hXs7Nm33gYOQog9JNnxRJB4=;
 b=MwT8BeUPlpjKMjqNF6uygRiLufo3MvVmO0+wOXPd/ISiJSWBh1Ic5cTo2iQv+RvdPk+C3QsXyf0uh1eC0jddqDgRcAwLGullagAY80+PQeDKxLVte5zM8k4awleMvUmydQ3fzlmOexPIvffkGWoT2P++cqt1VcEMLGUx1DXkZ4DYnFlDRWoxHEWaod83BxZNWPm1Mi8ahhswF8QLxGl3Tj7pveUEREbfpg80vGNFtmoJiedtctRpi78Hm1lOfH2Zv9+EmUJjRwsyfi9bj81XNGIp00UhSS76oK+IOY3vE2MjYbttxKtrZVH1O4PfovYl9o5aUBzL+Md3J8jfecocxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zMzdBqWffuABCYzks23hXs7Nm33gYOQog9JNnxRJB4=;
 b=LflQnoKV7JY2vODqp9VRi6eqvfNOfORlI8WvLW+Tixobd7CEeJMRxW+FsDrvV8+lLUtnOnKAUA1mLMpeOPAQbN5zq3+Inej0xIi/aLXRAuYc5DpOBLXzLnEZYmAqF/gQHvZq4jzMOc8lZ9UIW7voSqoq6FMM/LWEiHlv3QjmuY4=
Received: from BYAPR05CA0041.namprd05.prod.outlook.com (2603:10b6:a03:74::18)
 by CY5PR12MB6528.namprd12.prod.outlook.com (2603:10b6:930:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 01:56:07 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::97) by BYAPR05CA0041.outlook.office365.com
 (2603:10b6:a03:74::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6 via Frontend
 Transport; Thu, 7 Mar 2024 01:56:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 01:56:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 19:56:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 19:56:05 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 6 Mar 2024 19:56:04 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Christian Koenig
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Joonkyo
 Jung <joonkyoj@yonsei.ac.kr>, Dokyung Song <dokyungs@yonsei.ac.kr>,
 <jisoo.jang@yonsei.ac.kr>, <yw9865@yonsei.ac.kr>
Subject: [PATCH] drm/amdgpu: fix use-after-free bug
Date: Wed, 6 Mar 2024 20:55:57 -0500
Message-ID: <20240307015557.21005-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|CY5PR12MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: 26db2598-5c3d-454b-aadb-08dc3e49c0f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41RQE8IO5ubczyCqooAahMnWW1qgeEFWlyJelXqQyhk9rk0JeV63ehsaOPBuxa2ihJdnBy/osRpbUhGpdWyKeFU6g6tIsVafAW/jjsAgSnLqDB9AuHS1fnIcKdcRa62nL05eLBYIKEeerg8iw1JMBPHvW5xt5cyzEfMnLHW+xNGlfkrOZDTDk/vNHCZ5UjD63jTnh0AqBn5AQNVJuOq0WFtda2kTGfRd7x06RjCA8Gm+s6ELFxZ5BprbgNXnmQIf6arULWrM9r4euTImp4tfeFiz84/PYxBrz2/eV9KPbw+Me0My2zrLFpyzUZGN4sOVhf+o4IQ0W7Y+QjSFrHt6sWKgZ945n6ZWBkhvxFhgyAtgZMSn9lQX0zXh8AigP/oj55Lkpy5Xidf6YSnBgPguQ2C0E34QG9/d1t42lB1ct/trqOu1Qibhl2e4jvvD4teBukN6h8TadTz3Rfn2cp0AmIY55/i7v+IRYx0n4KfGpGgZHohba7FQxheAS0Avr0sR9kOSmjDVW6j7rfMDAPN7vmGIegl6Lvlvpj/zJyCSFul942y/j5AZDY9/PMW+Ihqo79dQS7YgUF12NgnplflgAw3IvWyFU8TeVW0sup12GPrCpBBwwyMDQrEaxvWhT7CZLgT9elp/rf4ape4etrd3aBfXw/Q6dXZ9GKfiLPaHWAyqlng22f/X94oDX9Bk1OE5IKOm/ZZSZb1EbFm6NO+J+2XHgdFY0U5UrPGEOmW0GLSdOptjlctuosp/HxtNQlVU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 01:56:06.9378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26db2598-5c3d-454b-aadb-08dc3e49c0f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6528
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The bug can be triggered by sending a single amdgpu_gem_userptr_ioctl
to the AMDGPU DRM driver on any ASICs with an invalid address and size.
The bug was reported by Joonkyo Jung <joonkyoj@yonsei.ac.kr>.
For example the following code:

static void Syzkaller1(int fd)
{
	struct drm_amdgpu_gem_userptr arg;
	int ret;

	arg.addr = 0xffffffffffff0000;
	arg.size = 0x80000000; /*2 Gb*/
	arg.flags = 0x7;
	ret = drmIoctl(fd, 0xc1186451/*amdgpu_gem_userptr_ioctl*/, &arg);
}

Due to the address and size are not valid there is a failure in
amdgpu_hmm_register->mmu_interval_notifier_insert->__mmu_interval_notifier_insert->
check_shl_overflow, but we even the amdgpu_hmm_register failure we still call
amdgpu_hmm_unregister into  amdgpu_gem_object_free which causes access to a bad address.
The following stack is below when the issue is reproduced when Kazan is enabled:

[  +0.000014] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
[  +0.000009] RIP: 0010:mmu_interval_notifier_remove+0x327/0x340
[  +0.000017] Code: ff ff 49 89 44 24 08 48 b8 00 01 00 00 00 00 ad de 4c 89 f7 49 89 47 40 48 83 c0 22 49 89 47 48 e8 ce d1 2d 01 e9 32 ff ff ff <0f> 0b e9 16 ff ff ff 4c 89 ef e8 fa 14 b3 ff e9 36 ff ff ff e8 80
[  +0.000014] RSP: 0018:ffffc90002657988 EFLAGS: 00010246
[  +0.000013] RAX: 0000000000000000 RBX: 1ffff920004caf35 RCX: ffffffff8160565b
[  +0.000011] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8881a9f78260
[  +0.000010] RBP: ffffc90002657a70 R08: 0000000000000001 R09: fffff520004caf25
[  +0.000010] R10: 0000000000000003 R11: ffffffff8161d1d6 R12: ffff88810e988c00
[  +0.000010] R13: ffff888126fb5a00 R14: ffff88810e988c0c R15: ffff8881a9f78260
[  +0.000011] FS:  00007ff9ec848540(0000) GS:ffff8883cc880000(0000) knlGS:0000000000000000
[  +0.000012] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000010] CR2: 000055b3f7e14328 CR3: 00000001b5770000 CR4: 0000000000350ef0
[  +0.000010] Call Trace:
[  +0.000006]  <TASK>
[  +0.000007]  ? show_regs+0x6a/0x80
[  +0.000018]  ? __warn+0xa5/0x1b0
[  +0.000019]  ? mmu_interval_notifier_remove+0x327/0x340
[  +0.000018]  ? report_bug+0x24a/0x290
[  +0.000022]  ? handle_bug+0x46/0x90
[  +0.000015]  ? exc_invalid_op+0x19/0x50
[  +0.000016]  ? asm_exc_invalid_op+0x1b/0x20
[  +0.000017]  ? kasan_save_stack+0x26/0x50
[  +0.000017]  ? mmu_interval_notifier_remove+0x23b/0x340
[  +0.000019]  ? mmu_interval_notifier_remove+0x327/0x340
[  +0.000019]  ? mmu_interval_notifier_remove+0x23b/0x340
[  +0.000020]  ? __pfx_mmu_interval_notifier_remove+0x10/0x10
[  +0.000017]  ? kasan_save_alloc_info+0x1e/0x30
[  +0.000018]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? __kasan_kmalloc+0xb1/0xc0
[  +0.000018]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? __kasan_check_read+0x11/0x20
[  +0.000020]  amdgpu_hmm_unregister+0x34/0x50 [amdgpu]
[  +0.004695]  amdgpu_gem_object_free+0x66/0xa0 [amdgpu]
[  +0.004534]  ? __pfx_amdgpu_gem_object_free+0x10/0x10 [amdgpu]
[  +0.004291]  ? do_syscall_64+0x5f/0xe0
[  +0.000023]  ? srso_return_thunk+0x5/0x5f
[  +0.000017]  drm_gem_object_free+0x3b/0x50 [drm]
[  +0.000489]  amdgpu_gem_userptr_ioctl+0x306/0x500 [amdgpu]
[  +0.004295]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
[  +0.004270]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? __this_cpu_preempt_check+0x13/0x20
[  +0.000015]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? sysvec_apic_timer_interrupt+0x57/0xc0
[  +0.000020]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[  +0.000022]  ? drm_ioctl_kernel+0x17b/0x1f0 [drm]
[  +0.000496]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
[  +0.004272]  ? drm_ioctl_kernel+0x190/0x1f0 [drm]
[  +0.000492]  drm_ioctl_kernel+0x140/0x1f0 [drm]
[  +0.000497]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
[  +0.004297]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
[  +0.000489]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? __kasan_check_write+0x14/0x20
[  +0.000016]  drm_ioctl+0x3da/0x730 [drm]
[  +0.000475]  ? __pfx_amdgpu_gem_userptr_ioctl+0x10/0x10 [amdgpu]
[  +0.004293]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
[  +0.000506]  ? __pfx_rpm_resume+0x10/0x10
[  +0.000016]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? __kasan_check_write+0x14/0x20
[  +0.000010]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? _raw_spin_lock_irqsave+0x99/0x100
[  +0.000015]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  +0.000014]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? srso_return_thunk+0x5/0x5f
[  +0.000011]  ? preempt_count_sub+0x18/0xc0
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000010]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[  +0.000019]  amdgpu_drm_ioctl+0x7e/0xe0 [amdgpu]
[  +0.004272]  __x64_sys_ioctl+0xcd/0x110
[  +0.000020]  do_syscall_64+0x5f/0xe0
[  +0.000021]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  +0.000015] RIP: 0033:0x7ff9ed31a94f
[  +0.000012] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
[  +0.000013] RSP: 002b:00007fff25f66790 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
[  +0.000016] RAX: ffffffffffffffda RBX: 000055b3f7e133e0 RCX: 00007ff9ed31a94f
[  +0.000012] RDX: 000055b3f7e133e0 RSI: 00000000c1186451 RDI: 0000000000000003
[  +0.000010] RBP: 00000000c1186451 R08: 0000000000000000 R09: 0000000000000000
[  +0.000009] R10: 0000000000000008 R11: 0000000000000246 R12: 00007fff25f66ca8
[  +0.000009] R13: 0000000000000003 R14: 000055b3f7021ba8 R15: 00007ff9ed7af040
[  +0.000024]  </TASK>
[  +0.000007] ---[ end trace 0000000000000000 ]---

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
Cc: Dokyung Song <dokyungs@yonsei.ac.kr>
Cc: <jisoo.jang@yonsei.ac.kr>
Cc: <yw9865@yonsei.ac.kr>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 9 ++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index bf8e6653341f..d5bc302b3bb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1068,6 +1068,12 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 	if (ret) {
 		pr_err("%s: Failed to register MMU notifier: %d\n",
 		       __func__, ret);
+		if (ret == -EOVERFLOW || ret == -EINVAL)
+			/*
+			 * To avoid call mmu_interval_notifier_remove with
+			 * RB_EMPTY_NODE(&interval_sub->interval_tree.rb)
+			 */
+			bo->notifier.mm = NULL;
 		goto out;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 6bbab141eaae..644a9cfd7758 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -453,8 +453,15 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		goto release_object;
 
 	r = amdgpu_hmm_register(bo, args->addr);
-	if (r)
+	if (r) {
+		if (r == -EOVERFLOW || r == -EINVAL)
+			/*
+			 * To avoid call mmu_interval_notifier_remove with
+			 * RB_EMPTY_NODE(&interval_sub->interval_tree.rb)
+			 */
+			bo->notifier.mm = NULL;
 		goto release_object;
+	}
 
 	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
 		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
-- 
2.25.1

