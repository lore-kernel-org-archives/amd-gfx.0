Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50442606A31D
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Oct 2026 17:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=RWX/RBjw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2411112C82;
	Fri, 23 Oct 2026 17:13:17 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010014.outbound.protection.outlook.com [52.101.56.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A94F112B81
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 14:06:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dZVzF70IIaVqo0alfbpFA7R7D2iJ3i0HIBwwohGHu58r1x+2HbngDl4gy+DBSTPYXkDtKH7VwH7fHDrlWgmpvszgEWBOrtScGvfInqqA+CWthVosy0BFyx9lSiuK86PtJvxzgWMBOdYVmdY4dI6677p28Pg06txryRHPJUANkH41HFdbnSrr8EVV6wpurxj6+wnLukLQQ5qkTJfxZ1cQGpm1d+j4DS/qZptZ7fc5oySCZ0n+q/cPYrqCUfzIF/CEJqwIXMRpDRZojl4qocC3PROSBsVb3XNucl9WX7L7Oj30Laa/Oh28cHWEfXd55b1CiHSKRc1dWtckA8D1aZH+8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvxZazWBUx0geWEAiOOADlDdoMSXtUErof6j/I0ECyo=;
 b=Q8hfIu9LzEemrnpgWW1tjf7eE/zIXv7aqHdUTUmVKo3+Xe+E87tzkOapoWVD/9NfybHxAkSHrKTV4K/UIuJUuSxBOrFZ6Eth5pGV4HD7HRmMFw8w3v/NLsvNuc9L93y+guPoL3ZnptU7+wps2Uf6glmM5HWZv00m8dWQUdXukkkzP6D6XjTM7jWG7zlcLD2YeMzamDOxJPvbdEKqpHd1qmgp/kjNF7uNsuBULt6qd/qXIOgNSqCyDpw6H9qk1RT+ct/B9HRxUnDDmNjUiisP+Fxqar/Zv6am28eGo3v3wF6ofofFYKMJqzuX+/57gWAE9zcENSTY9Si2XNGYk2Vygg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvxZazWBUx0geWEAiOOADlDdoMSXtUErof6j/I0ECyo=;
 b=RWX/RBjw5LWNDvy3YRMWTKWymnFPMzWO6QVTmHApt1sVCeIuVfRUuEWIieHEEOyr9iS8vpx2yoFOivP7EzoNzu3hwEHbH+8QAa/+A1WrwusJy3B0hi+9vfrdx+hEAwV0ZMFdR7H/AQYHa/PoW2nrKNK5eQaIPbRszLPtwWsSyXo=
Received: from SJ0PR03CA0245.namprd03.prod.outlook.com (2603:10b6:a03:3a0::10)
 by IA4PR12MB590810.namprd12.prod.outlook.com (2603:10b6:207:10f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 14:06:20 +0000
Received: from SJ1PEPF000037B7.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::30) by SJ0PR03CA0245.outlook.office365.com
 (2603:10b6:a03:3a0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 14:06:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037B7.mail.protection.outlook.com (10.167.244.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Fri, 23 Oct 2026 14:06:19 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 23 Oct
 2026 09:06:19 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 23 Oct 2026 09:06:19 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: drop async_gfx_ring parameter
Date: Fri, 23 Oct 2026 10:06:11 -0400
Message-ID: <20261023140611.3095340-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B7:EE_|IA4PR12MB590810:EE_
X-MS-Office365-Filtering-Correlation-Id: 4633de68-b054-4bcb-b407-08df310ecfe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|10067099003|5023799004|11063799006|56012099006|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: tbU5UnrT1O51ZmyPoSeO5RB789TnoewlD0C1HXEHBl0wV+gDwQ2IAc39g7Z+w36hOm+Chcixe/Fg0qhGcC2eGfYLFBYuCtbtJq72DYd5W7WgEJZ9piVzGX1vNwsajNU5rNkvTakiv5e3aao6t/wHfZtYWg9a07EYNbvkc9iOLM/XmDKWVBoyvaNATb6aW7yNA+UP7rUEMADZ7laPq6AQ56FDcVsCGbHBZw/SqD3H7mL5gAqBcDH3ceomv6wATj4r/sMz3G1zeRYfKgBNVqGZLOAZsdDIHYTgFAff2GYaVn6NzOIQ5EvCXv7wOsYgfqCXMEwnOI8MqEpvSRVW8mfcU61BP1Mk4kznf9UH3kqPuibZtJrb3F+yQ9EdS0XH8z6avis4gQc78uHHNDgH+daKP5kLaOxzYuLVpJWVfNfWhVJ6WYmxIWU4ht6UQGJ9Lo4z64UQ5+ie0nDXKkho3g0rF5y4e4SHoF1F+oIPzfCVT+GLfyPE/jN5gtvhOrFd8FVaG0p2mpMgQYatrFQarqeyIxqYMKqnPogXOKS4R5jRyDQ1P44HA6WBvNoTwt8MfirFit9d/OOsPRUcAtgZ6cRrY7Md/CpKiaVE9hcgcteUuS929gJf94kXqX64pcDxKkLyZ8pVvqdkqabmxG7elyTSW/iVhGgvX0XfkjTL7xc39tTMb8VqAlz0lJWjSKOH8jwzUYNFCOJilVsIhgOg7W0cwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(10067099003)(5023799004)(11063799006)(56012099006)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0lkPsNyuXgoDwWTsNZx7+D2vhgmBkIk3aQuHMCu9qDTzX1JujGJbmtLueh5NKlLb61VejxP/HTfWUogToM1uzteHra1m0SDFl9JPFmDxAEiKk1PLDFZOjF8lPWdNaljTdImtsy/Ey+KgwRGkq4hEWMcYS3DldEbM3nkLmVUBoW9GxHPGFFKEX4sDxUQVaFBFDADbGQdqqNueRLKhyDBaySKdwnK4eXw1AUpL8+ZV3x4wRwno/1l4FCTdzoKBX0ncrIbhOA7EIUASTRNmhtW0HEVyYnBe/RkWzvqytlednPFe99ZKLooYld+JoxMpIe4XFdMoSpQtsT3c8FQjvdjKNxuodBrTRH33E8plgKYxamra5rDPUATq46L1aAqUB2QnYxgV6Ci3UCQKO/fp8u0KnnBUiziJqTDJ9fqpxkNhiBRIbYJwc5QWpa7/HeKo+SHm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:06:19.5895 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4633de68-b054-4bcb-b407-08df310ecfe7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB590810
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It's been enabled by default since it was added.  It's
leftover from gfx10 bring up.  I doubt the disabled path
still works anymore.  Remove it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |   1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   9 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 145 +-------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  | 167 +-----------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |   3 -
 6 files changed, 15 insertions(+), 316 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5a32b54b1e9b8..16c7d1381ae6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -213,7 +213,6 @@ extern u64 amdgpu_ras_mask;
 extern int amdgpu_bad_page_threshold;
 extern bool amdgpu_ignore_bad_page_threshold;
 extern struct amdgpu_watchdog_timer amdgpu_watchdog_timer;
-extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
 extern int amdgpu_mes_log_enable;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e5634de077f1..cee7c0c772a55 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -224,7 +224,6 @@ int amdgpu_smu_pptable_id = -1;
 uint amdgpu_dc_feature_mask = DC_MULTI_MON_PP_MCLK_SWITCH_MASK | DC_FRL_MASK;
 uint amdgpu_dc_debug_mask;
 uint amdgpu_dc_visual_confirm;
-int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp = -1;
 int amdgpu_discovery = -1;
 int amdgpu_mes_log_enable;
@@ -668,14 +667,6 @@ MODULE_PARM_DESC(smu_memory_pool_size,
 	"reserve gtt for smu debug usage, 0 = disable,0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
 module_param_named(smu_memory_pool_size, amdgpu_smu_memory_pool_size, uint, 0444);
 
-/**
- * DOC: async_gfx_ring (int)
- * It is used to enable gfx rings that could be configured with different prioritites or equal priorities
- */
-MODULE_PARM_DESC(async_gfx_ring,
-	"Asynchronous GFX rings that could be configured with either different priorities (HP3D ring and LP3D ring), or equal priorities (0 = disabled, 1 = enabled (default))");
-module_param_named(async_gfx_ring, amdgpu_async_gfx_ring, int, 0444);
-
 /**
  * DOC: mcbp (int)
  * It is used to enable mid command buffer preemption. (0 = disabled, 1 = enabled, -1 auto (default))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 0ae6e990c3102..143d55fed4617 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -148,7 +148,7 @@ void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
 
 static bool amdgpu_gfx_is_graphics_multipipe_capable(struct amdgpu_device *adev)
 {
-	return amdgpu_async_gfx_ring && adev->gfx.me.num_pipe_per_me > 1;
+	return adev->gfx.me.num_pipe_per_me > 1;
 }
 
 static bool amdgpu_gfx_is_compute_multipipe_capable(struct amdgpu_device *adev)
@@ -447,7 +447,7 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 		}
 	}
 
-	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
+	if (adev->gfx.me.num_queue_per_pipe > 1) {
 		/* create MQD for each KGQ */
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
@@ -503,7 +503,7 @@ void amdgpu_gfx_mqd_sw_fini(struct amdgpu_device *adev, int xcc_id)
 	int i, j;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 
-	if (adev->asic_type >= CHIP_NAVI10 && amdgpu_async_gfx_ring) {
+	if (adev->gfx.me.num_queue_per_pipe > 1) {
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
 			kfree(adev->gfx.me.mqd_backup[i]);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 74b68b6048c89..456645d6b331f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -6447,35 +6447,11 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v10_0_cp_gfx_switch_pipe(struct amdgpu_device *adev,
-					 CP_PIPE_ID pipe)
-{
-	u32 tmp;
-
-	tmp = RREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL);
-	tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, pipe);
-
-	WREG32_SOC15(GC, 0, mmGRBM_GFX_CNTL, tmp);
-}
-
 static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 					  struct amdgpu_ring *ring)
 {
 	u32 tmp;
 
-	if (!amdgpu_async_gfx_ring) {
-		tmp = RREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL);
-		if (ring->use_doorbell) {
-			tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-						DOORBELL_OFFSET, ring->doorbell_index);
-			tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-						DOORBELL_EN, 1);
-		} else {
-			tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-						DOORBELL_EN, 0);
-		}
-		WREG32_SOC15(GC, 0, mmCP_RB_DOORBELL_CONTROL, tmp);
-	}
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(10, 3, 0):
 	case IP_VERSION(10, 3, 2):
@@ -6503,109 +6479,6 @@ static void gfx_v10_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
 	}
 }
 
-static int gfx_v10_0_cp_gfx_resume(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring;
-	u32 tmp;
-	u32 rb_bufsz;
-	u64 rb_addr, rptr_addr, wptr_gpu_addr;
-
-	/* Set the write pointer delay */
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_DELAY, 0);
-
-	/* set the RB to use vmid 0 */
-	WREG32_SOC15(GC, 0, mmCP_RB_VMID, 0);
-
-	/* Init gfx ring 0 for pipe 0 */
-	mutex_lock(&adev->srbm_mutex);
-	gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
-
-	/* Set ring buffer size */
-	ring = &adev->gfx.gfx_ring[0];
-	rb_bufsz = order_base_2(ring->ring_size / 8);
-	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
-	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
-#ifdef __BIG_ENDIAN
-	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, BUF_SWAP, 1);
-#endif
-	WREG32_SOC15(GC, 0, mmCP_RB0_CNTL, tmp);
-
-	/* Initialize the ring buffer's write pointers */
-	ring->wptr = 0;
-	WREG32_SOC15(GC, 0, mmCP_RB0_WPTR, lower_32_bits(ring->wptr));
-	WREG32_SOC15(GC, 0, mmCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
-
-	/* set the wb address whether it's enabled or not */
-	rptr_addr = ring->rptr_gpu_addr;
-	WREG32_SOC15(GC, 0, mmCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
-	WREG32_SOC15(GC, 0, mmCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
-		     CP_RB_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-
-	wptr_gpu_addr = ring->wptr_gpu_addr;
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
-		     lower_32_bits(wptr_gpu_addr));
-	WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
-		     upper_32_bits(wptr_gpu_addr));
-
-	mdelay(1);
-	WREG32_SOC15(GC, 0, mmCP_RB0_CNTL, tmp);
-
-	rb_addr = ring->gpu_addr >> 8;
-	WREG32_SOC15(GC, 0, mmCP_RB0_BASE, rb_addr);
-	WREG32_SOC15(GC, 0, mmCP_RB0_BASE_HI, upper_32_bits(rb_addr));
-
-	WREG32_SOC15(GC, 0, mmCP_RB_ACTIVE, 1);
-
-	gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
-	mutex_unlock(&adev->srbm_mutex);
-
-	/* Init gfx ring 1 for pipe 1 */
-	if (adev->gfx.num_gfx_rings > 1) {
-		mutex_lock(&adev->srbm_mutex);
-		gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
-		/* maximum supported gfx ring is 2 */
-		ring = &adev->gfx.gfx_ring[1];
-		rb_bufsz = order_base_2(ring->ring_size / 8);
-		tmp = REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz - 2);
-		WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
-		/* Initialize the ring buffer's write pointers */
-		ring->wptr = 0;
-		WREG32_SOC15(GC, 0, mmCP_RB1_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(GC, 0, mmCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
-		/* Set the wb address whether it's enabled or not */
-		rptr_addr = ring->rptr_gpu_addr;
-		WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
-		WREG32_SOC15(GC, 0, mmCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
-			     CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_LO,
-			     lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15(GC, 0, mmCP_RB_WPTR_POLL_ADDR_HI,
-			     upper_32_bits(wptr_gpu_addr));
-
-		mdelay(1);
-		WREG32_SOC15(GC, 0, mmCP_RB1_CNTL, tmp);
-
-		rb_addr = ring->gpu_addr >> 8;
-		WREG32_SOC15(GC, 0, mmCP_RB1_BASE, rb_addr);
-		WREG32_SOC15(GC, 0, mmCP_RB1_BASE_HI, upper_32_bits(rb_addr));
-		WREG32_SOC15(GC, 0, mmCP_RB1_ACTIVE, 1);
-
-		gfx_v10_0_cp_gfx_set_doorbell(adev, ring);
-		mutex_unlock(&adev->srbm_mutex);
-	}
-	/* Switch to pipe 0 */
-	mutex_lock(&adev->srbm_mutex);
-	gfx_v10_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
-	mutex_unlock(&adev->srbm_mutex);
-
-	/* start the ring */
-	gfx_v10_0_cp_gfx_start(adev);
-
-	return 0;
-}
-
 static void gfx_v10_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 {
 	if (enable) {
@@ -7268,15 +7141,9 @@ static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!amdgpu_async_gfx_ring) {
-		r = gfx_v10_0_cp_gfx_resume(adev);
-		if (r)
-			return r;
-	} else {
-		r = gfx_v10_0_cp_async_gfx_ring_resume(adev);
-		if (r)
-			return r;
-	}
+	r = gfx_v10_0_cp_async_gfx_ring_resume(adev);
+	if (r)
+		return r;
 
 	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 		ring = &adev->gfx.gfx_ring[i];
@@ -7586,10 +7453,8 @@ static int gfx_v10_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		gfx_v10_0_set_powergating_state(ip_block, AMD_PG_STATE_UNGATE);
 
 	if (!adev->no_hw_access) {
-		if (amdgpu_async_gfx_ring) {
-			if (amdgpu_gfx_disable_kgq(adev, 0))
-				DRM_ERROR("KGQ disable failed\n");
-		}
+		if (amdgpu_gfx_disable_kgq(adev, 0))
+			DRM_ERROR("KGQ disable failed\n");
 
 		if (amdgpu_gfx_disable_kcq(adev, 0))
 			DRM_ERROR("KCQ disable failed\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index d44d21c0c332f..c9404aa3b5ad8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -3731,9 +3731,6 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 		     adev->gfx.config.max_hw_contexts - 1);
 	WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
 
-	if (!amdgpu_async_gfx_ring)
-		gfx_v11_0_cp_gfx_enable(adev, true);
-
 	ring = &adev->gfx.gfx_ring[0];
 	r = amdgpu_ring_alloc(ring, gfx_v11_0_get_csb_size(adev));
 	if (r) {
@@ -3794,143 +3791,6 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void gfx_v11_0_cp_gfx_switch_pipe(struct amdgpu_device *adev,
-					 CP_PIPE_ID pipe)
-{
-	u32 tmp;
-
-	tmp = RREG32_SOC15(GC, 0, regGRBM_GFX_CNTL);
-	tmp = REG_SET_FIELD(tmp, GRBM_GFX_CNTL, PIPEID, pipe);
-
-	WREG32_SOC15(GC, 0, regGRBM_GFX_CNTL, tmp);
-}
-
-static void gfx_v11_0_cp_gfx_set_doorbell(struct amdgpu_device *adev,
-					  struct amdgpu_ring *ring)
-{
-	u32 tmp;
-
-	tmp = RREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL);
-	if (ring->use_doorbell) {
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_OFFSET, ring->doorbell_index);
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_EN, 1);
-	} else {
-		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
-				    DOORBELL_EN, 0);
-	}
-	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_CONTROL, tmp);
-
-	tmp = REG_SET_FIELD(0, CP_RB_DOORBELL_RANGE_LOWER,
-			    DOORBELL_RANGE_LOWER, ring->doorbell_index);
-	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_LOWER, tmp);
-
-	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_UPPER,
-		     CP_RB_DOORBELL_RANGE_UPPER__DOORBELL_RANGE_UPPER_MASK);
-}
-
-static int gfx_v11_0_cp_gfx_resume(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *ring;
-	u32 tmp;
-	u32 rb_bufsz;
-	u64 rb_addr, rptr_addr, wptr_gpu_addr;
-
-	/* Set the write pointer delay */
-	WREG32_SOC15(GC, 0, regCP_RB_WPTR_DELAY, 0);
-
-	/* set the RB to use vmid 0 */
-	WREG32_SOC15(GC, 0, regCP_RB_VMID, 0);
-
-	/* Init gfx ring 0 for pipe 0 */
-	mutex_lock(&adev->srbm_mutex);
-	gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
-
-	/* Set ring buffer size */
-	ring = &adev->gfx.gfx_ring[0];
-	rb_bufsz = order_base_2(ring->ring_size / 8);
-	tmp = REG_SET_FIELD(0, CP_RB0_CNTL, RB_BUFSZ, rb_bufsz);
-	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, RB_BLKSZ, rb_bufsz - 2);
-	tmp = REG_SET_FIELD(tmp, CP_RB0_CNTL, KMD_QUEUE, 1);
-	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
-
-	/* Initialize the ring buffer's write pointers */
-	ring->wptr = 0;
-	WREG32_SOC15(GC, 0, regCP_RB0_WPTR, lower_32_bits(ring->wptr));
-	WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI, upper_32_bits(ring->wptr));
-
-	/* set the wb address whether it's enabled or not */
-	rptr_addr = ring->rptr_gpu_addr;
-	WREG32_SOC15(GC, 0, regCP_RB0_RPTR_ADDR, lower_32_bits(rptr_addr));
-	WREG32_SOC15(GC, 0, regCP_RB0_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
-		     CP_RB_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-
-	wptr_gpu_addr = ring->wptr_gpu_addr;
-	WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO,
-		     lower_32_bits(wptr_gpu_addr));
-	WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI,
-		     upper_32_bits(wptr_gpu_addr));
-
-	mdelay(1);
-	WREG32_SOC15(GC, 0, regCP_RB0_CNTL, tmp);
-
-	rb_addr = ring->gpu_addr >> 8;
-	WREG32_SOC15(GC, 0, regCP_RB0_BASE, rb_addr);
-	WREG32_SOC15(GC, 0, regCP_RB0_BASE_HI, upper_32_bits(rb_addr));
-
-	WREG32_SOC15(GC, 0, regCP_RB_ACTIVE, 1);
-
-	gfx_v11_0_cp_gfx_set_doorbell(adev, ring);
-	mutex_unlock(&adev->srbm_mutex);
-
-	/* Init gfx ring 1 for pipe 1 */
-	if (adev->gfx.num_gfx_rings > 1) {
-		mutex_lock(&adev->srbm_mutex);
-		gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID1);
-		/* maximum supported gfx ring is 2 */
-		ring = &adev->gfx.gfx_ring[1];
-		rb_bufsz = order_base_2(ring->ring_size / 8);
-		tmp = REG_SET_FIELD(0, CP_RB1_CNTL, RB_BUFSZ, rb_bufsz);
-		tmp = REG_SET_FIELD(tmp, CP_RB1_CNTL, RB_BLKSZ, rb_bufsz - 2);
-		WREG32_SOC15(GC, 0, regCP_RB1_CNTL, tmp);
-		/* Initialize the ring buffer's write pointers */
-		ring->wptr = 0;
-		WREG32_SOC15(GC, 0, regCP_RB1_WPTR, lower_32_bits(ring->wptr));
-		WREG32_SOC15(GC, 0, regCP_RB1_WPTR_HI, upper_32_bits(ring->wptr));
-		/* Set the wb address whether it's enabled or not */
-		rptr_addr = ring->rptr_gpu_addr;
-		WREG32_SOC15(GC, 0, regCP_RB1_RPTR_ADDR, lower_32_bits(rptr_addr));
-		WREG32_SOC15(GC, 0, regCP_RB1_RPTR_ADDR_HI, upper_32_bits(rptr_addr) &
-			     CP_RB1_RPTR_ADDR_HI__RB_RPTR_ADDR_HI_MASK);
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-		WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO,
-			     lower_32_bits(wptr_gpu_addr));
-		WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI,
-			     upper_32_bits(wptr_gpu_addr));
-
-		mdelay(1);
-		WREG32_SOC15(GC, 0, regCP_RB1_CNTL, tmp);
-
-		rb_addr = ring->gpu_addr >> 8;
-		WREG32_SOC15(GC, 0, regCP_RB1_BASE, rb_addr);
-		WREG32_SOC15(GC, 0, regCP_RB1_BASE_HI, upper_32_bits(rb_addr));
-		WREG32_SOC15(GC, 0, regCP_RB1_ACTIVE, 1);
-
-		gfx_v11_0_cp_gfx_set_doorbell(adev, ring);
-		mutex_unlock(&adev->srbm_mutex);
-	}
-	/* Switch to pipe 0 */
-	mutex_lock(&adev->srbm_mutex);
-	gfx_v11_0_cp_gfx_switch_pipe(adev, PIPE_ID0);
-	mutex_unlock(&adev->srbm_mutex);
-
-	/* start the ring */
-	gfx_v11_0_cp_gfx_start(adev);
-
-	return 0;
-}
-
 static void gfx_v11_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
 {
 	u32 data;
@@ -4722,9 +4582,6 @@ static int gfx_v11_0_kcq_resume(struct amdgpu_device *adev)
 {
 	int i, r;
 
-	if (!amdgpu_async_gfx_ring)
-		gfx_v11_0_cp_compute_enable(adev, true);
-
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		r = gfx_v11_0_kcq_init_queue(&adev->gfx.compute_ring[i]);
 		if (r)
@@ -4758,10 +4615,8 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 
 	gfx_v11_0_cp_set_doorbell_range(adev);
 
-	if (amdgpu_async_gfx_ring) {
-		gfx_v11_0_cp_compute_enable(adev, true);
-		gfx_v11_0_cp_gfx_enable(adev, true);
-	}
+	gfx_v11_0_cp_compute_enable(adev, true);
+	gfx_v11_0_cp_gfx_enable(adev, true);
 
 	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
 		r = amdgpu_mes_kiq_hw_init(adev, 0);
@@ -4774,15 +4629,9 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
-	if (!amdgpu_async_gfx_ring) {
-		r = gfx_v11_0_cp_gfx_resume(adev);
-		if (r)
-			return r;
-	} else {
-		r = gfx_v11_0_cp_async_gfx_ring_resume(adev);
-		if (r)
-			return r;
-	}
+	r = gfx_v11_0_cp_async_gfx_ring_resume(adev);
+	if (r)
+		return r;
 
 	if (adev->gfx.disable_kq) {
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
@@ -4792,8 +4641,7 @@ static int gfx_v11_0_cp_resume(struct amdgpu_device *adev)
 			if (r)
 				return r;
 		}
-		if (amdgpu_async_gfx_ring)
-			amdgpu_gfx_disable_kgq(adev, 0);
+		amdgpu_gfx_disable_kgq(adev, 0);
 	} else {
 		for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
 			ring = &adev->gfx.gfx_ring[i];
@@ -5116,8 +4964,7 @@ static int gfx_v11_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 
 	if (!adev->no_hw_access) {
-		if (amdgpu_async_gfx_ring &&
-		    !adev->gfx.disable_kq) {
+		if (!adev->gfx.disable_kq) {
 			if (amdgpu_gfx_disable_kgq(adev, 0))
 				DRM_ERROR("KGQ disable failed\n");
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index e3d3ca8e7900c..6f6bf2b0bf534 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -2411,9 +2411,6 @@ static int gfx_v12_1_xcc_kcq_resume(struct amdgpu_device *adev,
 	struct amdgpu_ring *ring = NULL;
 	int r = 0, i;
 
-	if (!amdgpu_async_gfx_ring)
-		gfx_v12_1_xcc_cp_compute_enable(adev, true, xcc_id);
-
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
 
-- 
2.56.0

