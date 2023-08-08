Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 410D4C001DB
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Aug 2023 20:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEF7410E0DD;
	Tue,  8 Aug 2023 20:42:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::616])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A89710E0DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Aug 2023 20:42:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tacx0TwX/lP3cuehLms9ANNML4ssEjG1E12K7ob+whgwNoEQ79ftDdNccv7dg+TXhDrlqAEfhzx7sV6qRLCrEeFO2d2hBWMXUAhYjMtn8dHFVD7Gn39ToYeoCB4a30K7DIguXw42VOTWJdQ8WnQWrsk85lGX8/TTdq9c6HsM7G4Hfru4aFxmIwWccwP8FqRP3GV+cl1pNXh4IoVz3qSQ4CIZ5qG+DZOpge4tZYqF2t93Bjjg+Te1pUqBqLHsPbBpZ5K3eA1z+3rIwDJ05B+2IZ4ddzlBJ6IHdNgizK8Puffv5T/P2iCBKedsyXcCSyRC1mbN/3eX2A7h0I1tPhLjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghR9JrOX1fS1outo2AhWED6JIL3FNJME4/XRLoR2nw4=;
 b=EcO3R/lpGLPIzfPqhvo643Mzw6QYSPSjgz0N5QvycGFVuyCafF0M4mNsD6BL38YNrJmkuxJVCrCyJLug7zwgBzxeNimUy4y/uWc8Sm0PitJVRrpVnZDBIbf73GG3MQ02Ln2n1KOEbbpHxGokrvIUwAw3b+6+IsC2x9wn8xKzHo/Nr2yz67OwlaEfW8nVGKHns69CMFy+HIdrNt88O5oZb+I+S6+vsaV/QkvsdXWbnXmr2FJW0fUPda7zKCaJczH5weJaWHWxJ/9uQZpTHhdllkc/ZcpG6QyQrnlD3+HZEWKJeOPvGRs7qhenusITNFpGYy4nyZFe3AaqRskDp83SzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghR9JrOX1fS1outo2AhWED6JIL3FNJME4/XRLoR2nw4=;
 b=YqUYC3ZH1xCiUkcxIaGKqleTmr62PRrAH3dkmiaF2iM6ZCni3mZsH8EN5ijnO31kudbGPuhyGiBsixikd0mTRwniAVxo+UE+IrYo8KECXsNdnvrU0YYaFACq33wxPk4s8qT1MFs/zEIxN74Xt6R3ycTMIpztE0xbJNIW/d6wmiQ=
Received: from MW4PR04CA0068.namprd04.prod.outlook.com (2603:10b6:303:6b::13)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 20:42:39 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:303:6b:cafe::63) by MW4PR04CA0068.outlook.office365.com
 (2603:10b6:303:6b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 20:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 20:42:38 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 15:42:37 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: Add xcc instance parameter to *REG32_RLC
Date: Tue, 8 Aug 2023 16:39:39 -0400
Message-ID: <20230808203940.11407-1-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 574f3220-7863-4227-f852-08db98500116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZrEKzLOprGjzC+X7ZKLoWM9lfjTBPb0iCTlQe1IMo9PAb7/GjJT5O1HI+4ssf9064L+nc52amfb0TCVJfUHqjzA/4J4vzbMMBj7YCZS1qBSjOap8h/84JGM8OB9mivZmCJ8I2DzS93ICVkYdlala2jmYxEl0+QQOmf09r5CdcVYNdmw7n6GibISLh7Q6H4n2WF1xweYoEhtjm1n6BmKagZqxfDggLfnaby5fzjbjXC5QpjadG2PmCAWuriZqwCVkx/5+kSZAovQjQmXA9jI7g+dmIqMFChLyKjkdIONnEgrqU5FRgiDpqHOs3YuUWA0yQJO5nKLdDo58aDj5mBiLzmY2WHBlCrJSC+Abn54eerUarn7CLUFgsa7dwRisYeE0/NjROVFTiMeZ5AhmvCLszIac03dshYMny3eyoYAUU0gaQFTqjKFGdYj/DRAqt8jGrlSYGhp0LeKsEdEGqikhvWdIeIrCWn0srvb7Kq++9SfFL1mD858sgerXb+PdLi5dZO8QvYQpyVtF7OUzF6jiZbHUJ+VqeU00xbxiWrn7SV9LoNeaN5T6AE6LGKJdWZLLQcyv2sWtE27zogjQ3PAPXoB+m8xyAWv/yvGj63PRbdSVkajSOVOO8dZKJRjqR9DZhySAsLuDUu+8U/gZQKAcPLR/m/PJ2oGN5YMwnavgg9gqIcy/R7Sj1twbkEMlFq8gQ781W/57LdqcsLiSoXeDBeCQKo2xIDwoAmRs4K5cW8I0fNi5etNL0WXMODF9xHn8btiVwAsQeyGgAygtUkT6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(1800799003)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(81166007)(83380400001)(478600001)(356005)(82740400003)(54906003)(47076005)(26005)(2616005)(16526019)(1076003)(336012)(7696005)(426003)(70206006)(6916009)(70586007)(4326008)(36860700001)(5660300002)(40460700003)(41300700001)(30864003)(2906002)(316002)(8936002)(8676002)(86362001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 20:42:38.4739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574f3220-7863-4227-f852-08db98500116
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
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
Cc: victor.skvortsov@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WREG32/RREG32_RLC should specify the instance so the correct XCC's RLCG
interface can be used.

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  4 +--
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 25 +++++++--------
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |  4 +--
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 32 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  6 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  8 ++---
 7 files changed, 40 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index e2fed6edbdd0..4b6007de24ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -154,11 +154,11 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
+			watch_address_high, 0);
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			watch_address_low, 0);
 
 	return watch_address_cntl;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 490c8f5ddb60..218226c10b93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -300,14 +300,14 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
 
 	for (reg = hqd_base; reg <= hqd_end; reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_RLC(reg, mqd_hqd[reg - hqd_base], inst);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
 	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL),
-				data);
+				data, inst);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -337,26 +337,25 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
 		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO),
-		       lower_32_bits(guessed_wptr));
+		       lower_32_bits(guessed_wptr), inst);
 		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI),
-		       upper_32_bits(guessed_wptr));
+		       upper_32_bits(guessed_wptr), inst);
 		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uintptr_t)wptr));
+		       lower_32_bits((uintptr_t)wptr), inst);
 		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
-			upper_32_bits((uintptr_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
-		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id,
-			       queue_id));
+			upper_32_bits((uintptr_t)wptr), inst);
+		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
+		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id), inst);
 	}
 
 	/* Start the EOP fetcher */
 	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
-			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1), inst);
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data, inst);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -497,12 +496,12 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
+			watch_address_high, inst);
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			watch_address_low, inst);
 
 	return watch_address_cntl;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index d67d003bada2..a89902d6dc35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -771,11 +771,11 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
+			watch_address_high, 0);
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			watch_address_low, 0);
 
 	return watch_address_cntl;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 28963726bc97..93d6719e89dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -91,8 +91,8 @@ void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 {
 	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid, inst);
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config, inst);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases, inst);
 	/* APE1 no longer exists on GFX9 */
 
 	kgd_gfx_v9_unlock_srbm(adev, inst);
@@ -239,14 +239,14 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_RLC(reg, mqd_hqd[reg - hqd_base], inst);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
 	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL),
-					data);
+					data, inst);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -276,13 +276,13 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
 		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO),
-		       lower_32_bits(guessed_wptr));
+		       lower_32_bits(guessed_wptr), inst);
 		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI),
-		       upper_32_bits(guessed_wptr));
+		       upper_32_bits(guessed_wptr), inst);
 		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uintptr_t)wptr));
+		       lower_32_bits((uintptr_t)wptr), inst);
 		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
-		       upper_32_bits((uintptr_t)wptr));
+		       upper_32_bits((uintptr_t)wptr), inst);
 		WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_PQ_WPTR_POLL_CNTL1,
 		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
@@ -290,10 +290,10 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 	/* Start the EOP fetcher */
 	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
-			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1), inst);
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data, inst);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -556,7 +556,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 		break;
 	}
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type, inst);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
@@ -855,15 +855,15 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_cntl);
+			watch_address_cntl, 0);
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
+			watch_address_high, 0);
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			watch_address_low, 0);
 
 	/* Enable the watch point */
 	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
@@ -873,7 +873,7 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_cntl);
+			watch_address_cntl, 0);
 
 	return 0;
 }
@@ -887,7 +887,7 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
 
 	WREG32_RLC((SOC15_REG_OFFSET(GC, 0, mmTCP_WATCH0_CNTL) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_cntl);
+			watch_address_cntl, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 458faf657042..5ea1497b8300 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2485,11 +2485,11 @@ static void gfx_v9_0_init_csb(struct amdgpu_device *adev)
 	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
 	/* csib */
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_HI),
-			adev->gfx.rlc.clear_state_gpu_addr >> 32);
+			adev->gfx.rlc.clear_state_gpu_addr >> 32, 0);
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_ADDR_LO),
-			adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
+			adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc, 0);
 	WREG32_RLC(SOC15_REG_OFFSET(GC, 0, mmRLC_CSIB_LENGTH),
-			adev->gfx.rlc.clear_state_size);
+			adev->gfx.rlc.clear_state_size, 0);
 }
 
 static void gfx_v9_1_parse_ind_reg_list(int *register_list_format,
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 158e611474ca..cca7bbc9fae9 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -469,7 +469,7 @@ void soc15_program_register_sequence(struct amdgpu_device *adev,
 			reg == SOC15_REG_OFFSET(GC, 0, mmPA_SC_ENHANCE) ||
 			reg == SOC15_REG_OFFSET(GC, 0, mmPA_SC_ENHANCE_1) ||
 			reg == SOC15_REG_OFFSET(GC, 0, mmSH_MEM_CONFIG))
-			WREG32_RLC(reg, tmp);
+			WREG32_RLC(reg, tmp, 0);
 		else
 			(entry->hwip == GC_HWIP) ?
 				WREG32_SOC15_IP(GC, reg, tmp) : WREG32(reg, tmp);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index c75e9cd5c98b..148eb2603b9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -107,8 +107,8 @@
 	(adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + (reg) + (offset)), \
 	#reg, expected_value, mask)
 
-#define WREG32_RLC(reg, value) \
-	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, 0)
+#define WREG32_RLC(reg, value, inst) \
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, inst)
 
 #define WREG32_RLC_EX(prefix, reg, value, inst) \
 	do {							\
@@ -139,8 +139,8 @@
 	__WREG32_SOC15_RLC__((adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg), value, AMDGPU_REGS_RLC, GC_HWIP, inst)
 
 /* for GC only */
-#define RREG32_RLC(reg) \
-	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
+#define RREG32_RLC(reg, inst) \
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP, inst)
 
 #define WREG32_RLC_NO_KIQ(reg, value, hwip) \
 	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
-- 
2.34.1

