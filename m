Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11302606A31E
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Bh+QQckc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A645D10E7A9;
	Mon, 23 Nov 2026 09:57:05 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C5D10E7A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 09:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SRI59Va8KPda+7B/Q84J9MW/GIx854+ISfhhshHnkzWBGj03qbU1B1QQHzqZz/ST7EKdLhvmbRTvfyB0k9LIRPrEp8PqISCEpGWPCnHHIgF0abxBqruWzMmDwuXPKbZ2pqf4nBXgN+8u/WpuSZDQ5oaWHll4jPNaOOtsvqv5CIoABXjMRwhnXpIiHpCpO6mq3bW1N+xHh3btr6cAOVfwQlJv0lRBz5HKbsEyo/z95Q+hM+YSRSGEvoVmOoZnsoxIV+bHbBR9A1KDRFC0BSjNhlxqb+1Wv88Ktd0l7olw0NanF2iFQ9W4iA+prwDVNQfap5G0QfhBMDVDcZMdgSusiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUoM3WsCulob8PM44ZXbxxpHWWTP5zY4Sym0G8GI/Is=;
 b=ZQ71/x3D8uVO1ULjJIIwh79RhhbtxcyLJqin2a3XU7GFANzEZe7nalVwBBzKOtBcpmVnMGDArTdjJVb4QU8J3jnZ/ul8nChH/oQYCludzLjssDbvmXz4kHr6rCVfl0O8suphQyOUUqNQzBRvPkObONqfcZzawpHBK+EfzAr3sIOR4vseiWGquqFgixtYlbrCdc4HRsxXUSe/vGf5Oc5EYdbBngaHzNDVAceM+5vTSn0ZHLb6ENWlap/QfGR5ksS/sV+Fgsl8Ny9uiNtzyToXKS2hTXFPS0CKJfdTARKZ8e8qqOB+ZTLPNotKY4zEqHlP/2cv0qzMVKSPQMf9qtL87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUoM3WsCulob8PM44ZXbxxpHWWTP5zY4Sym0G8GI/Is=;
 b=Bh+QQckcPekuPtsnT9KqPzWmC/UzXk0p93Egr1NkJRWXnTwfLYzjlgEiPO2k5ZAo82tqolDfpNbps5kzMApSskyCVAOy3itmMe8yGURu3OAgJUxeV5c2IoiK8jQHYCs4uw7t8rw759R4M1lnPP7D8z4NrF5Wc2E8J8fpkg4157k=
Received: from DS7P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25b::12) by
 SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 09:56:49 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:8:25b:cafe::2b) by DS7P221CA0012.outlook.office365.com
 (2603:10b6:8:25b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 09:56:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 09:56:48 +0000
Received: from marui-Super-Server.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 03:56:46 -0600
From: Heng Zhou <Heng.Zhou@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, <Christian.Koenig@amd.com>, <Emily.Deng@amd.com>,
 <Victor.Zhao@amd.com>, <Felix.Kuehling@amd.com>, <phasta@kernel.org>,
 <HaiJun.Chang@amd.com>, <Heng.Zhou@amd.com>, <James.Zhu@amd.com>
Subject: [PATCH] drm/amdkfd: rebuild CWSR trap buffers after hibernation
Date: Mon, 23 Nov 2026 17:56:05 +0800
Message-ID: <20261123095605.162656-1-Heng.Zhou@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 220937b4-f514-4fc1-71ce-08df49481781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|6133799003|18002099003|261009223027099003|261021130227099003|261021135927099003|261021123027099003|261021121427099003|261021133027099003|261022105027099003|261026130827099003|261026121527099003|261026135527099003|261026140227099003|261102123227099003|261022115727099003|261022113327099003|261022075727099003|261028144727099003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: J24DtU/4lzhiX3VPKE52mZHLN5DApzxGxYQBYKYFONCqJGHtgXqq/XN34Yl/Mhv27XTqetD/swylii4nY6adzM2CV/t8PBLCao99L4RI/UC0rorsMk4E140BPLhKDTMBqkoQSxwlNmXmgLDfDBIS2QQtY+d/5pb7e1QjeVr3CSiMSw+RmbNGVDw9gCadk9/+0X0Qaim9modedjy/XnBvWyCF/qsqxOCEIUd2ZDVWPefiZQh/azW+YnZ5cma1T90QaLTlPMecxPHznNj5EkCmapP7KE/EuJgTuhIqWXoUcroT3gVCoL3yRlMAkaMgulRxODgf3KGbdeg7jISBQFE+W5ucnTvgJpGpemRDSXCmlGxX5soc3BfZtqUE5WYuHUCPxgyPt4a9QzFjdNbW90SG9rb1tSGADg9L39hvF/nOXJjoXyTwO2lZiZC66ifRciQxYBA8bpCzqcVetQXrnoTt1xHbA2BY8TCxRTkYMS9it16NNjYbTrcdpslfXPG+J98G9jkHE+mSJkYhf5ZTrmFbKQ1gTG7xNibg+2jTsa6dg/h02trXsTywizB3Z/5IIsib0bvlShlPHCcG0e5yeMtyEfK0oRi844VPEAkZZbI5/0axBireHMgMNXrP6yK2paCsS61UYy0izeN28ipPUetnJLuOMVAIgTjHb0DudS6oPcOoiMccpa5CtgSHEaCEfZG7nf/rLCt7o1+rsMl8bxt9Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(6133799003)(18002099003)(261009223027099003)(261021130227099003)(261021135927099003)(261021123027099003)(261021121427099003)(261021133027099003)(261022105027099003)(261026130827099003)(261026121527099003)(261026135527099003)(261026140227099003)(261102123227099003)(261022115727099003)(261022113327099003)(261022075727099003)(261028144727099003)(56012099006)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wBZfbrROrP69KGw6zGojh0KcSNKx1hmlQrv39EfXkWmEXHcVBblHK7KSdHsCMZr8yVnBOCmuG4uKXWAxJ9Qk9rFqYCQSq51ft9uHpZJqm7TCXygzzrPQCI5D4KdLY1832qtyoYNAGds95HUIuUov4DsNzUken7XqKU8IRksQDtqSR+jgvinb+/vvskn6tTpCcrYdqiRyJeq0NxnT7ykaro3bmI+Ii1GkNqJAmab3YiJufeo60JpMYja3y4UtS9c+n9NxBtFBIpv6aNUlbuqRPl1IpWEwyR9DHwMfpiZmYwOrXVo3oUcdERaWuTVoC2cnaIqkIh0hbUbI80cH/ByzsYR5lC9giFHCTW+fj4rG6GmSuyLhIZ0GzijOiGaoOrENRZzBf3Bqn+p0PaBkIZHcdj7074O/3K/1/hUZjSUzMK8ArjqmV/iXtfI0T7MdMGuf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:56:48.9966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 220937b4-f514-4fc1-71ce-08df49481781
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The CWSR trap buffer can reside in pinned VRAM, which is skipped by
TTM eviction during hibernation. Restoring the process GPUVM mappings
does not restore the buffer contents. This can lead to SQ errors and
failed queue preemption after resume.

Keep the second-level TBA/TMA and trap flags in system memory. Rebuild
the buffer from the trap ISA and saved TMA values and flush HDP before
restoring process queues.

Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  7 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 31 ++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index d8631847f0eb..a719c3be0db1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -723,6 +723,13 @@ struct qcm_process_device {
 	uint64_t cwsr_base;
 	uint64_t tba_addr;
 	uint64_t tma_addr;
+	/*
+	 * CPU copies of the second-level TBA/TMA and trap flags.
+	 * Keep them in sync with the first-level TMA for hibernation restore.
+	 */
+	uint64_t cwsr_second_level_tba;
+	uint64_t cwsr_second_level_tma;
+	uint64_t cwsr_tma_flags;
 
 	/* IB memory */
 	struct kgd_mem *ib_mem;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index dd938788bdd9..307851d3d882 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1590,6 +1590,8 @@ void kfd_process_set_trap_handler(struct qcm_process_device *qpd,
 		/* KFD trap handler is bound, record as second-level TBA/TMA
 		 * in first-level TMA. First-level trap will jump to second.
 		 */
+		qpd->cwsr_second_level_tba = tba_addr;
+		qpd->cwsr_second_level_tma = tma_addr;
 		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
 			     uint64_t, tba_addr);
 		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
@@ -1660,12 +1662,40 @@ void kfd_process_set_trap_debug_flag(struct qcm_process_device *qpd,
 				     bool enabled)
 {
 	if (!iosys_map_is_null(&qpd->cwsr_map)) {
+		qpd->cwsr_tma_flags = enabled;
 		iosys_map_wr(&qpd->cwsr_map,
 			     KFD_CWSR_TMA_OFFSET + 2 * sizeof(uint64_t),
 			     uint64_t, enabled);
 	}
 }
 
+static void kfd_process_rebuild_cwsr(struct kfd_process *p)
+{
+	struct kfd_process_device *pdd;
+	struct qcm_process_device *qpd;
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		pdd = p->pdds[i];
+		qpd = &pdd->qpd;
+
+		if (!pdd->dev->adev->in_s4 || !qpd->cwsr_base ||
+		    iosys_map_is_null(&qpd->cwsr_map))
+			continue;
+
+		iosys_map_memset(&qpd->cwsr_map, 0, 0, KFD_CWSR_TBA_TMA_SIZE);
+		iosys_map_memcpy_to(&qpd->cwsr_map, 0, pdd->dev->kfd->cwsr_isa,
+				    pdd->dev->kfd->cwsr_isa_size);
+		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET,
+			     uint64_t, qpd->cwsr_second_level_tba);
+		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + sizeof(uint64_t),
+			     uint64_t, qpd->cwsr_second_level_tma);
+		iosys_map_wr(&qpd->cwsr_map, KFD_CWSR_TMA_OFFSET + 2 * sizeof(uint64_t),
+			     uint64_t, qpd->cwsr_tma_flags);
+		amdgpu_device_flush_hdp(pdd->dev->adev, NULL);
+	}
+}
+
 /*
  * On return the kfd_process is fully operational and will be freed when the
  * mm is released
@@ -2301,6 +2331,7 @@ int kfd_resume_all_processes(void)
 	int ret = 0, idx = srcu_read_lock(&kfd_processes_srcu);
 
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		kfd_process_rebuild_cwsr(p);
 		if (restore_process_helper(p)) {
 			pr_err("Restore process pid %d failed during resume\n",
 			      p->lead_thread->pid);
-- 
2.43.0

