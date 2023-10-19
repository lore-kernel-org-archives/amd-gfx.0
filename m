Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89B8CDB482
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 09:31:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69FE910E4B1;
	Thu, 19 Oct 2023 09:31:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D2910E4B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 09:31:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TA7frg7o+MQxIDbVSDhqbAlEAy0EbLphrR4pXtgww9u7ocanW7uiJyr9DFB8L3zLjkqTmAYThtylNI2YmiEgetcv2k/Va/I4/618GF7oZ1aCP+qgAno/oqz/noOLd8cQOJecsuFSfz6z30jICNjtELNkR9Mye1587suZ91Xvex1HwkD0rmiIs1UN2rGD7o//2WSEPxCClagc+6R2YFXpB0euy2eK9xp022m4UVFbJj7dErvUakb0vV1kpB7PWiH4w9i+0OwXaVTtOjOTsQNoTBY0ASQD6/U7PFRpu9Aq1DJNiqFqoethxrByhgV5xbz2cgKcI4Mq1UzaWHBzKiGSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+NbcT2Qhvw+tgaiIRaiVFnWUB1WoguQ7NfPRhKObkU=;
 b=JNF0pY9HaXm7i7PMG8Kh3e8clGDkzoPy7Xx0D4TExYqfYeGt7Zr+y2S/JwELAU7VMHSZJQo8mej+gPfEXv6E0A27ONFc8U+LzAGN8zF/Q6PhtoaR3z1KSex7YHlWByaLm5GUzSH0gZNERChx1iF8Z8Nq0NgoAh3aJuXQt5SIlk1CCN7bkZi7GWRHNyG+o7LrgH5tIknWHSZjz/cGJkLPOE9JwIxX/LAVBWvt7zXpSEgi+cEsDcOOh/AobwF/ho70DpQLHJd7mj6FVKB4NIi8qn1SIeIrRMZRcXT2pwEtN1dSCYrXNqEfJKGQb2EAAIiB910S+5qf/QfDlFUitFjyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+NbcT2Qhvw+tgaiIRaiVFnWUB1WoguQ7NfPRhKObkU=;
 b=DzzpGKpV5LBNnH7C3FfXX0GeJy7YXOPs8gWUgWOAUy67uU9lnoPMnxp7whXo/hnx2y0oEvi/jH+rZGow090bijRNz1PcnKsnWgcbSeGsP7OF5QR83/R9Nk0StmVfu2fwheqW8/m5CeAHEg9GDJ5BLovjfmbn1HQKxTSqDGEL2PE=
Received: from DM6PR03CA0067.namprd03.prod.outlook.com (2603:10b6:5:100::44)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 09:31:07 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:100:cafe::9a) by DM6PR03CA0067.outlook.office365.com
 (2603:10b6:5:100::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23 via Frontend
 Transport; Thu, 19 Oct 2023 09:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.21 via Frontend Transport; Thu, 19 Oct 2023 09:31:07 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 04:31:06 -0500
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Thu, 19 Oct 2023 04:31:05 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Add timeout for sync wait
Date: Thu, 19 Oct 2023 17:31:03 +0800
Message-ID: <20231019093103.100939-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 96a56d0f-4993-44ff-38de-08dbd0861f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uIg4MFwAcFeBs5Nq4O0t1S+0bKKalLBHGu4Y0fKxe9XbfikFE71afMls1abfsK7ysYhYXwaIDTolwOnbnia2vCedjPJDuskX5sqJYb2oh9GRSPBex03uhQPO3UyXfXZqx+EBUhR9YxTQiSaaTXFxFW1xksRy9+5c5oR538I4BOoY6rkixUd6Xy6rcfKKkaAdjAeJH863giRIZqRC5KIHMAb+hkFwQKQZP/8R3EgCe68NB6uKE2XHn8s1Q2HagK+gg3Mdg+emCgBZXoo8XiUqK3a1gvwUvHxpulA0IHB6sx72782UByaSwKsDc8OSXubqBw/zVCZZmYrkVpI4IsnCi0SEsSAnss8+yl4RympeXdw9TwTmc4KSlGHkp7hxAWNZ7lydUSl/o8KeZidfWt1gSqyJbgk5JjWBoR/lwyFb7bBM9mNzG227rss8NRmkchEkE3qqvtyYC7ZhGNE9K91w4pcZNLzxBi3VA2DrQAlAVeaPwqMUN/2UTu4kExFY49ulQUumkcYd+HE96xnCeiaBmv4M06TS0aDu/25EzyVW5H0NrxvctFNv1O1zy1nwyFxoTnSA5dd/3wZ/qPGzucYdh56atvTd4nYR3wo98MKo6tG/OkyZ/HuP5g0N9wviXGVwvcuPWsD8nRIyJXOQndxy9WifxJxUpX7uG139JMBVe/OZQayiar6jzeocdROk0S4T5zVLfCHlE5rZ3xjnvrqhzJfFYT9Tp4MDoVFJvkJEZrp0K3k/nlakQwsAOMo+c0mtK90bQD3q9enY4eaZpkgNlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(47076005)(336012)(426003)(36756003)(82740400003)(1076003)(81166007)(2616005)(356005)(478600001)(26005)(83380400001)(4326008)(86362001)(5660300002)(70586007)(70206006)(316002)(6916009)(2906002)(7696005)(8936002)(41300700001)(8676002)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 09:31:07.0118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a56d0f-4993-44ff-38de-08dbd0861f36
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
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
Cc: Emily Deng <Emily.Deng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Issue: Dead heappen during gpu recover

[56433.829492] amdgpu 0000:04:00.0: amdgpu: GPU reset begin!
[56550.499625] INFO: task kworker/u80:0:10 blocked for more than 120 seconds.
[56550.520215]       Tainted: G           OE      6.2.0-34-generic #34~22.04.1-Ubuntu
[56550.542883] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[56550.566313] task:kworker/u80:0   state:D stack:0     pid:10    ppid:2      flags:0x00004000
[56550.591318] Workqueue: kfd_restore_wq restore_process_worker [amdgpu]
[56550.611391] Call Trace:
[56550.618698]  <TASK>
[56550.624968]  __schedule+0x2b7/0x5f0
[56550.635416]  schedule+0x68/0x110
[56550.645090]  schedule_timeout+0x151/0x160
[56550.657096]  ? amdgpu_vm_bo_update+0x46e/0x660 [amdgpu]
[56550.673245]  dma_fence_default_wait+0x1a2/0x1e0
[56550.686818]  ? __pfx_dma_fence_default_wait_cb+0x10/0x10
[56550.702728]  dma_fence_wait_timeout+0x117/0x140
[56550.716301]  amdgpu_sync_wait+0x62/0xa0 [amdgpu]
[56550.730654]  amdgpu_amdkfd_gpuvm_restore_process_bos+0x59e/0x770 [amdgpu]
[56550.751668]  ? newidle_balance+0x298/0x490
[56550.763936]  restore_process_worker+0x42/0x270 [amdgpu]
[56550.780183]  process_one_work+0x21f/0x440
[56550.792193]  worker_thread+0x50/0x3f0
[56550.803165]  ? __pfx_worker_thread+0x10/0x10
[56550.815934]  kthread+0xee/0x120
[56550.825342]  ? __pfx_kthread+0x10/0x10
[56550.836548]  ret_from_fork+0x2c/0x50
[56550.847262]  </TASK>
[ 1935.215502] Call Trace:
[ 1935.222827]  <TASK>
[ 1935.229121]  __schedule+0x23d/0x5a0
[ 1935.239583]  schedule+0x4e/0xc0
[ 1935.248983]  schedule_timeout+0x103/0x140
[ 1935.261002]  __wait_for_common+0xae/0x150
[ 1935.273008]  ? usleep_range_state+0x90/0x90
[ 1935.285546]  wait_for_completion+0x24/0x30
[ 1935.297813]  __flush_work.isra.0+0x175/0x280
[ 1935.310611]  ? worker_detach_from_pool+0xc0/0xc0
[ 1935.324436]  flush_delayed_work+0x31/0x50
[ 1935.336455]  kfd_suspend_all_processes+0x96/0x150 [amdgpu]
[ 1935.353429]  kgd2kfd_suspend+0xb8/0xe0 [amdgpu]
[ 1935.367469]  kgd2kfd_pre_reset+0x81/0xf0 [amdgpu]
[ 1935.382036]  amdgpu_amdkfd_pre_reset+0x1a/0x30 [amdgpu]
[ 1935.398156]  amdgpu_device_gpu_recover.cold+0x210/0xcf2 [amdgpu]
[ 1935.416722]  amdgpu_job_timedout+0x19f/0x1e0 [amdgpu]
[ 1935.432367]  drm_sched_job_timedout+0x6f/0x120 [amd_sched]
[ 1935.448792]  process_one_work+0x22b/0x3d0
[ 1935.460806]  worker_thread+0x53/0x420
[ 1935.471777]  ? process_one_work+0x3d0/0x3d0
[ 1935.484307]  kthread+0x12a/0x150
[ 1935.493993]  ? set_kthread_struct+0x50/0x50
[ 1935.506513]  ret_from_fork+0x22/0x30

It is because the amdgpu_sync_wait is waiting for the bad job's fence, and
never return, so the recover couldn't continue.


Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index dcd8c066bc1f..c922867c5675 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -406,9 +406,19 @@ int amdgpu_sync_wait(struct amdgpu_sync *sync, bool intr)
 	int i, r;
 
 	hash_for_each_safe(sync->fences, i, tmp, e, node) {
-		r = dma_fence_wait(e->fence, intr);
-		if (r)
-			return r;
+		struct drm_sched_fence *s_fence = to_drm_sched_fence(e->fence);
+
+		if (s_fence) {
+			r = dma_fence_wait_timeout(e->fence, intr, s_fence->sched->timeout);
+			if (r == 0)
+				r = -ETIMEDOUT;
+			if (r < 0)
+				return r;
+		} else {
+			r = dma_fence_wait(e->fence, intr);
+			if (r)
+				return r;
+		}
 
 		amdgpu_sync_entry_free(e);
 	}
-- 
2.36.1

