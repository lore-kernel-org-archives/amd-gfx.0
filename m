Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F294C0018A
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 14:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C991810EA0E;
	Fri,  3 Nov 2023 14:57:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::614])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4B910EA0A
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 14:57:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O5Vl9td8ghCfp+8gXYJAS8H2BzW4XjW10yTrZRuhKFcsPfCKGh2TJ8NSEmUgMVeyA89b1oUFqqq2P949nQPfuSvg8/BXHpkgKG84DGDpw8utqq9o5fiGu6e+BeA1MYB6KEE9KHjZrEF1xsZVPySQfoKB9uSUqCSYboitQRj+IJ+Y9n1p+PYgUFgEyvV5GuQu5hlM/dY20tlclwrbM4TOLJzqrXG00lNzcWhY/MuGS2uu62XFJ5pi2pRymc2I/dhLLlyNldj1O+4f8bTgAVkiP/gmUYKyqgrS09rhN0zouLQGcFYrKcgnKFT8j/kBtT7z9gFLEaHaErPkaCoBj/oe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAgwp6N8jelTo/cW3kQR3ad5J56dyWI7odXWpgklgSQ=;
 b=d8PdwCFqpyT7/nD4BiwjmLwTP9e3KdqAJDrzLceT6n0lemkvTb6prLTsMfavh2vOWf8IS6zkWTyMfFEA16QFX9FPg4QNskLVUlxIl0tGmzIYOT0DM/sxoiba5mZdUwH3wYeqZ/ggGxNrXgQTXVOqXpv4bidY2yNe22XreiqV1lsSCRJJPvYKZACekjMoqQUcnJsJrVvsfbQ5lBr/qh36CjS3Nu0mCVQ4gPnyi7jQQj9aqFXF1gc19EXyOxDzEolxbSHeaV0vbYx2ddQ6pYUDFNssCZ2O5oCNbVRqLVcPqgmlpe7ShGVYwbUncbYD3sMr27JNhAnNP6cOfprmT412+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAgwp6N8jelTo/cW3kQR3ad5J56dyWI7odXWpgklgSQ=;
 b=IFjwBZ/lFRQQhQsWkKYyD13M0z6jBvgFiSp1xDJUhSwh2H2kfRfqnbGcO6ibxXXGjNjANYOtm49kSZzeWWOQkgQydIwXEC+majuECDBuVcUv7v2cVg/mWlrNpzK2pFzfUtGc0KThpRtpZb/ahMvp5C88nVZg/D9MHgaX24l3Pyg=
Received: from BL1PR13CA0124.namprd13.prod.outlook.com (2603:10b6:208:2bb::9)
 by LV3PR12MB9118.namprd12.prod.outlook.com (2603:10b6:408:1a1::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 14:57:16 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::b5) by BL1PR13CA0124.outlook.office365.com
 (2603:10b6:208:2bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.10 via Frontend
 Transport; Fri, 3 Nov 2023 14:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 14:57:16 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 09:57:13 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Change WREG32_RLC to WREG32_SOC15_RLC where
 inst != 0 (v2)
Date: Fri, 3 Nov 2023 10:56:54 -0400
Message-ID: <20231103145654.2651-4-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231103145654.2651-1-victorchengchi.lu@amd.com>
References: <513b2282-2f88-d837-ff37-6bd04641e833@amd.com>
 <20231103145654.2651-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|LV3PR12MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d13135-e958-4bf4-87ec-08dbdc7d2bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfjaH7OvnqId1uYU10jie14plSAdISQSlqlAkKjDLuMdsRxvuDuMAePK2XImKJECNje1J2oj5g2fMXxNHIsO1aiViajGEHq5fmwspNzcduqQw5ou2jglcD+VRxG+QFDGwjcRQP3ZrZAOCOa1FsdIp6VTRDVW5sVJndCut1DmqKLPVRZhzaWraDiKJezuEWTjvk222jopHJkMTa5bViun7enR9BYzhe9xTPSguaY1JVyumrn4LMlrlqFD1ezTbyGxRCblOtqLLyPzCUU5ru3NV5s9rk86tm8ynEjQq3BB8rm7KzmBio6HUeqJnNLmilAMpRRaD5SMYBrKVlN7ebo2isPVm2RvkqeMq/pPI2pPm6YCfKLn5f4q9NIXdWrT1/UME2j0LqxvpBkT8nckUR5KBzw2H47EyN9hRpBbJIojxOr0ikZhpqjFuUSFmfDl34tsCczQ6C7I0XB0u/hKNo+HKib8sXIcxe528GwycN0dMEGrYyfMB0vP8JMNRo6oMAkTa+t2/vBUT38SyFF5zVq+TCp+Ef0sUObKLSkoLzX54qF6RFFFKu8X35FdXznDEZMewpLmZhR8RJXE23/or2JQtxQa5bthj3JuGfgf4+AGJdclWU6HMvxKUi2nw0WbomNpVzKNqnvvfj22QCngy9JRp1SQuyD0KA930OcqEcb7ByRxalGqL0T2hwSpu7wuXJCQ7SW9RGZKSvf35+orNvFDe8FX7WoR9TQqFQLzgQZMf6tiL3+9lEW3Vt/kBz3d6Bb3xao3yqCXIvi9Npb+lReXZQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(82310400011)(1800799009)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(6916009)(41300700001)(316002)(54906003)(70586007)(70206006)(8676002)(8936002)(4326008)(5660300002)(40480700001)(478600001)(81166007)(47076005)(82740400003)(83380400001)(2906002)(16526019)(426003)(86362001)(336012)(26005)(36756003)(1076003)(7696005)(2616005)(40460700003)(36860700001)(356005)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 14:57:16.2463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d13135-e958-4bf4-87ec-08dbdc7d2bac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9118
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com,
 Victor Lu <victorchengchi.lu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

W/RREG32_RLC is hardedcoded to use instance 0. W/RREG32_SOC15_RLC
should be used instead when inst != 0.

v2: rebase

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 38 ++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 40 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  2 +-
 3 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 80309d39737a..f6598b9e4faa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -306,8 +306,7 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL),
-				data);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL, data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -336,27 +335,24 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO),
-		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI),
-		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
-			regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO,
+			lower_32_bits(guessed_wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI,
+			upper_32_bits(guessed_wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR,
+			lower_32_bits((uintptr_t)wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 			upper_32_bits((uintptr_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
-		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id,
-			       queue_id));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1,
+			(uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR),
-	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
-			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR,
+	       REG_SET_FIELD(m->cp_hqd_eop_rptr, CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE, data);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -494,15 +490,15 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 			VALID,
 			1);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
+			watch_address_high, inst);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+	WREG32_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			watch_address_low, inst);
 
 	return watch_address_cntl;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 9285789b3a42..00fbc0f44c92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -91,8 +91,8 @@ void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 {
 	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid, inst);
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG, sh_mem_config);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmSH_MEM_BASES, sh_mem_bases);
 	/* APE1 no longer exists on GFX9 */
 
 	kgd_gfx_v9_unlock_srbm(adev, inst);
@@ -245,8 +245,7 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL),
-					data);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL, data);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -275,25 +274,24 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO),
-		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI),
-		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
-		       upper_32_bits((uintptr_t)wptr));
-		WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_PQ_WPTR_POLL_CNTL1,
-		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO,
+			lower_32_bits(guessed_wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI,
+			upper_32_bits(guessed_wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR,
+			lower_32_bits((uintptr_t)wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+			upper_32_bits((uintptr_t)wptr));
+		WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_PQ_WPTR_POLL_CNTL1,
+			(uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR),
-	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
-			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR,
+	       REG_SET_FIELD(m->cp_hqd_eop_rptr, CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE, data);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -556,7 +554,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 		break;
 	}
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_SOC15_RLC(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST, type);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
@@ -908,8 +906,8 @@ void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
 					uint32_t inst)
 
 {
-	*wait_times = RREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
-			mmCP_IQ_WAIT_TIME2));
+	*wait_times = RREG32_SOC15_RLC(GC, GET_INST(GC, inst),
+			mmCP_IQ_WAIT_TIME2);
 }
 
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index c75e9cd5c98b..4607df23fe27 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -140,7 +140,7 @@
 
 /* for GC only */
 #define RREG32_RLC(reg) \
-	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP, 0)
 
 #define WREG32_RLC_NO_KIQ(reg, value, hwip) \
 	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
-- 
2.34.1

