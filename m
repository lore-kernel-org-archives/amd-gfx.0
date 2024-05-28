Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7C0C25B78
	for <amd-gfx@archiver.kernel.org>; Tue, 28 May 2024 17:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5BF311246B;
	Tue, 28 May 2024 17:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E310lKxN";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 095B210FD7F
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 May 2024 17:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CClyC0ymXC/uL+R27AixTnq8d4pZpm43PWgTJ8pMd1YLjxl+y71gdjQE4nAfUXU63d/8mD6Nl+v4bHeKfp8fxNHS2plecQrBNIGDfuvYQK62ZowjwSgRaIwxcZDAkXmFNlkl5t4k7hgNx9+iQG+iTewQfmGDnVDC/+dssd2zytPEfADjVi3UUOSUy89Skn/8OXT4IZ2uE6ofGif9V2ryIvuv6UhFsCi4n1KakKuEdTiLHz1Otw7MOvtKh80V/9BE6Qe8Tq0rYblbhbumpxPHVZL3jOowBVyK9KOwzIuickLaJvG8Sp/ZPsju88zGEn6F2pNqsQ6udx4SvOXPH6tkzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGrBCkcE/M3+CyY1f4XovGwlhMhZ2VS49hOypuuNUg0=;
 b=kD1jcSgF03SlSpbQnpSHIoCf4DGqNEOSbKFYFHrMoz8gWzjB2rF3HtDMMMq32Ngl+vrRCKkF3hG63BJmQV3Eb8Zd5bTO8r0C0QPEJMNpU+bRjdswzQ5VIq/DTeg5obsAoVFOMJf6gfz7rtifw6JEDUrp3bIe/SFBJ8e/xIOFEnekwKaKeZuCuSu0iLkBHnIJtgQHjwLynUVp1BwjVALk5zmKV/SYjMHMoLIUmrqCYKUwH2iRENsGwCjCLrLTG/F4Z032mccQatEROXeVN46UY97/Zogwpizvl187OAI9o6U6GhaX04K8whQ+C76dXVtEqt720cSe50zWp4FFYOkFUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGrBCkcE/M3+CyY1f4XovGwlhMhZ2VS49hOypuuNUg0=;
 b=E310lKxN3t2kqz7BEkjmUSbiqsHdYMCeZGe3RZq5lka2vY3onM32/TRXC2RMnqvf5s2yg3+35SgYznoWLyElwDUZIFa0Vo3nVgJShsOWk4i/45vB7d74PvNfcL4yirgGCWe0VeJ2UmXQ1dnqqR/XjmJLxomnEyYey8CM8YBWmVA=
Received: from PH1PEPF000132F4.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::39)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 17:24:19 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2a01:111:f403:c802::) by PH1PEPF000132F4.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Tue, 28 May 2024 17:24:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 28 May 2024 17:24:18 +0000
Received: from MKM-L10-YUNXIA9.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 28 May
 2024 12:24:14 -0500
From: Yunxiang Li <Yunxiang.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>,
 <Likun.Gao@amd.com>, <Hawking.Zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH v2 09/10] drm/amdgpu: fix missing reset domain locks
Date: Tue, 28 May 2024 13:23:39 -0400
Message-ID: <20240528172340.34517-10-Yunxiang.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528172340.34517-1-Yunxiang.Li@amd.com>
References: <20240528172340.34517-1-Yunxiang.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 971d94a7-5d2a-4602-0dfa-08dc7f3b0186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|376005|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CtcRnRKB97CBLffgUrR1Ik4sGUQlcDt7smf6y5sjEV3V0kcp/X8w7WSL3pS6?=
 =?us-ascii?Q?TWxg1HiRNeHMNZ3sd0KGynRcugmfjnN+UdI7Y/I8OU+jdgBzVZE3YEUpm3Jc?=
 =?us-ascii?Q?t6lMpfMToca0oTHJNSo/CyC+fWH3+YogJ9wuvWZFNHNDoycmt31wdIGA0FL8?=
 =?us-ascii?Q?oiVTqGN4O5EAf+vB8jkIg0fV21JoV7WbnBB91C8lo8mEujsRskPad2/zBJUn?=
 =?us-ascii?Q?dR1E2qXbRHbCEdLdXfGYFyAReZtkLy5f7xoh7h5DDuyDhkRrw1q6h9ZLesZD?=
 =?us-ascii?Q?8X/W48zDkBXCYNSJG457tFtgdjF+n+50Vy0WebP8yUCpUewBRMuOrqWYad4J?=
 =?us-ascii?Q?qKbp4Mr3w6hVaWSS3x9IRVA8TSAlmZrBH6kFVyOLoFmTix+Hgw5HIypyMCnT?=
 =?us-ascii?Q?NW5mgiXQUPt73v9f2Chrtgv7D2+2aNsEjAImWfpwY0u/hJFTP8OCw1uTJiPg?=
 =?us-ascii?Q?f/kqJJScBwN35tOonJmADw51ccVlWpZi3+UtHbl/9+YdjLlDsB3m2G9PhRk4?=
 =?us-ascii?Q?iwCSpF+cG4D+VdJM46YDkJ9cWDRZgtX1oJQuGa9eoNKqM8F9qLNEANRa459n?=
 =?us-ascii?Q?HYi2pUOWQ7oASgXZc8CrprJqyiYSgf5zlTLcIASzcZnoLe5Zw+/4bPm/IGeI?=
 =?us-ascii?Q?afP7XP0dDbhBvh//Rau8w6mwCErkQn938eJCVyT5f9+coXo7l+oEn4Iuo9nr?=
 =?us-ascii?Q?sPJD8ch6DgaosW64/cFGpNR/l6DHEwty0eS3ssl6ZxtmJ6EFHnShFvxG9GnX?=
 =?us-ascii?Q?TPyXn22tscWpvbEdHz4IC1dnL4KlxGh2icT49n5Eepljm76i8TiPgOT9lwr+?=
 =?us-ascii?Q?H0bT06buHGwHEp7ymyUCzOzfT0fe324PEa5srr9Rm7EPWCi+23IFmWvZnh6Q?=
 =?us-ascii?Q?huINosaFQ5H6kU0Kd3tQp4H6O0G54bOy662QCCivqZ3AjBAwQ7YkqOeDt4KR?=
 =?us-ascii?Q?OazzZe9y7BmFgrV1vNEVUHm4zLvA19iAdDi5M4dHGVy7tczsLrNUkcIJRC2i?=
 =?us-ascii?Q?voZS5JIpCDVO8HTQUXwPx/NV7s8N96xlhLSZvgYY4jOnY3Nf0wTHV977/peX?=
 =?us-ascii?Q?nVo4jkAa9ECKIM3uPYucJCY3Fmsz/SPEDThsowj0nAcDMjVq15TFzQQY91T/?=
 =?us-ascii?Q?1/VllImfzbCvCSdF19rp1BEhls/+xWLpymAF3uGm6A3NTTGe825RijKGzNZ9?=
 =?us-ascii?Q?36wzfRgjhBbimR0MsAAY9tfP+G2T1T3UlIQXr9ZpjCbjjdAhh3eGMVsb/zvO?=
 =?us-ascii?Q?ToERncdsp7kRmyVWWCcJp6cl1YcEvBw7EQC2RKO67Gn25qZmVE+yAZ7jKzPt?=
 =?us-ascii?Q?V72aaEn2YnpXeHsLwf0sWS1nv8SHJGdvoW8/S876iylk2j+X7PwfP2WGDMN+?=
 =?us-ascii?Q?Zj00b50=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 17:24:18.4190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 971d94a7-5d2a-4602-0dfa-08dc7f3b0186
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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

These functions are missing the lock for reset domain.

Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c               | 4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c                | 8 ++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 9 +++++++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index eb172388d99e..ddc5e9972da8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -34,6 +34,7 @@
 #include <asm/set_memory.h>
 #endif
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
@@ -401,13 +402,14 @@ void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
 {
 	int i;
 
-	if (!adev->gart.ptr)
+	if (!adev->gart.ptr || !down_read_trylock(&adev->reset_domain->sem))
 		return;
 
 	mb();
 	amdgpu_device_flush_hdp(adev, NULL);
 	for_each_set_bit(i, adev->vmhubs_mask, AMDGPU_MAX_VMHUBS)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
+	up_read(&adev->reset_domain->sem);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e4742b65032d..52a3170d15b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -307,8 +307,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		dev_dbg(adev->dev, "Skip scheduling IBs in ring(%s)",
 			ring->name);
 	} else {
-		r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, job,
-				       &fence);
+		r = -ETIME;
+		if (down_read_trylock(&adev->reset_domain->sem)) {
+			r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs,
+					       job, &fence);
+			up_read(&adev->reset_domain->sem);
+		}
 		if (r)
 			dev_err(adev->dev,
 				"Error scheduling IBs (%d) in ring(%s)", r,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 86ea610b16f3..21f5a1fb3bf8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -28,6 +28,7 @@
 #include "kfd_priv.h"
 #include "kfd_kernel_queue.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_reset.h"
 
 static inline struct process_queue_node *get_queue_by_qid(
 			struct process_queue_manager *pqm, unsigned int qid)
@@ -87,8 +88,12 @@ void kfd_process_dequeue_from_device(struct kfd_process_device *pdd)
 		return;
 
 	dev->dqm->ops.process_termination(dev->dqm, &pdd->qpd);
-	if (dev->kfd->shared_resources.enable_mes)
-		amdgpu_mes_flush_shader_debugger(dev->adev, pdd->proc_ctx_gpu_addr);
+	if (dev->kfd->shared_resources.enable_mes &&
+	    down_read_trylock(&dev->adev->reset_domain->sem)) {
+		amdgpu_mes_flush_shader_debugger(dev->adev,
+						 pdd->proc_ctx_gpu_addr);
+		up_read(&dev->adev->reset_domain->sem);
+	}
 	pdd->already_dequeued = true;
 }
 
-- 
2.34.1

