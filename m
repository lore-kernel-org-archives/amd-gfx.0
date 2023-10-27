Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1D9C25B47
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Oct 2023 20:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57A5A10EA40;
	Fri, 27 Oct 2023 20:14:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 567E510EA40
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Oct 2023 20:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bnk8EmEfI2OnxAioPJfyhco8jXzWwWYMS2+nuNvQB/1bWJFaW1QvZIodAk4iyKWC7sS5dZTPgL1DDFb7Y0ijrVZLew4fL2GNIrTn4tMmqbMcWCdlDzSW4T3rIbfK4rzsh1/5OH7oKhP9iPtEFkhzEiPKS4dtMQibWvhgW7szHo1Ru1WyGllkTTwyA9OQ9qdlcQMDrcoU2g2HIN9u76IuXfcpMj+bdUoGaVA4ApYQFgLVSGFHOkSjxISaI32O1ESvrjEPMIf6il6wk7IMeGkfRFDryHgeeLPni4DsOjCv+U6Lihv8ZPbrU23q3AQ38MC+oJysNtQsHNRjpnEzwGCIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAgwp6N8jelTo/cW3kQR3ad5J56dyWI7odXWpgklgSQ=;
 b=HmBsR1Jaji+0F/d6tgTzztd6MyZwWoLAcx4adaVTGeST8kY6r6xSSL/qLhxl+wPRBhEAL7r94sM1L3ZfHDUaeL9g1ok2igk4wuQyF7m9Ul10vPJRNRRUZ8mOcNZWMSOlqNwUxQegywaNWzDe/Cu8U1+Lv9sOGH+HRLyL6XV9JPg1tdfpGZkDa6z3w0NAnrpPr6LWoBwwoW33mb8HRoo3kGurbqHVgT8qm3Y9mK9A4ryu4kRS4fJvSnpbnFFDEqgKIGbkdJGLFPW3ssd8Qy/BNUSyim9nvv8iT54pgYRfEY0A9BGwizeWOZKZOI1KuDjdakm6vyNp3GgE2v6AM2DgoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAgwp6N8jelTo/cW3kQR3ad5J56dyWI7odXWpgklgSQ=;
 b=fBfaI2k0uXUdIluKbJKx3057d10lvDYN7WCCfPMgVurbV3y00AK7ZxgcpiboHsKWQAc+Myc3xAvRf6v+XMKhwmyuueyt2qrTbjDm+EDSPj4Sv9CBu5vh6c0povH1bbuXA/mAVIn+ayxIQ3aFKMnzgk7mn+EcihbH/+OHSRsv1Qg=
Received: from CH2PR07CA0059.namprd07.prod.outlook.com (2603:10b6:610:5b::33)
 by BN9PR12MB5131.namprd12.prod.outlook.com (2603:10b6:408:118::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 20:14:39 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::7a) by CH2PR07CA0059.outlook.office365.com
 (2603:10b6:610:5b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22 via Frontend
 Transport; Fri, 27 Oct 2023 20:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Fri, 27 Oct 2023 20:14:39 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 27 Oct
 2023 15:14:38 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Change WREG32_RLC to WREG32_SOC15_RLC where inst
 != 0 (v2)
Date: Fri, 27 Oct 2023 16:13:39 -0400
Message-ID: <20231027201338.2384-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231025205242.40490-5-victorchengchi.lu@amd.com>
References: <20231025205242.40490-5-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|BN9PR12MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 99156a81-4340-4dcb-6b99-08dbd7295971
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RXD+IUF41KOSQfDIYNgnq29YPABtB4qA0pVfto1DHmB61APdrjGfu975R2pjk/TgCOLe1nWW9vl2Ngs1sgF+xgVu5lmwXKr3UFQ833t1qeP7MsVNNVAF6uo3NpHcRKqWXkX2z7ZT8cLdbDxoIVIWcZWcFtex+XHHBkaJNYG7sL3MIGqz1g2tfKnEZ74FO16Ll3eCv8Y7+i5W+x6tQGHUh12GzlYDfkn4X8AYSscXho2JWmZPEosMFBFmvKhoCSSdXzSm2LIEqhVWoQeMzmLzTMRHpc7OI7YzIzYx8hMZ1ILMIa+jeypYXNv+oysok0kei/eV2kvpkagnXEbe7lFB5QJzwhEM5OjDzRsDqCQt+RZ8UwsTgpddN1hM7PeJeXZQzjaohI/NmNsVuwZXvRbLSndrMdIN4h3FS+tTpAcEsnlkVGQv7uVw+IIbQRQLq+7Y3Y/2LPH4gT0VYmRmE9emHgeZddPrKr8H+xngB6CEeexQhhzWosjZxZGOw8kllygT2M8xE6pxALgXqtzeFh6FYRYpeu9944jUgG178Xrsi0OP6K7P+1p/t6PJXUr2l+nOpEQ/IautNvm+1+arInrx5ew7KLhXYgsELG/7EV+gikUM6cRRLllE91WYbgn4DJud8eiBPX1IeHY1027fo1WqfDshfWILY+9U6DlJxDPj4auifHuUK/x9c4CCXVq6pDjYPP3/mlVyePZ4jiP+XIZhTki2JBnxmxvDz9VqNe5m9s3J9mhXHiqh6C6vr6Un8B2xe3C+vkxZ3/lfubUPnCiluQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(41300700001)(4326008)(5660300002)(40460700003)(86362001)(2906002)(8676002)(83380400001)(7696005)(54906003)(16526019)(82740400003)(26005)(356005)(478600001)(81166007)(426003)(336012)(2616005)(6916009)(8936002)(316002)(1076003)(36860700001)(47076005)(70206006)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:14:39.6512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99156a81-4340-4dcb-6b99-08dbd7295971
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5131
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

