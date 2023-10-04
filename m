Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EB3E8FDC2
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 00:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3314F10E32C;
	Wed,  4 Oct 2023 00:56:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C017A10E328
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 00:56:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNMNO3FxMNB61MhBQmR4+FQwPFjFoczYvfLOEbVPb2LGppc30G5ooQMOqMRllwzx33LbwgckKJQBydAs/taMSHoM9/mmtpX4TTTzS5zulLolLKUNK+eobVGyoNtth0hOPLqOaZfBHSgv7BrRR6J9QZiMmCXNpgF7dbdhgovtn9UK1Re1R5xrXLCq6pQjJEPHfc9OC/0isHsYXKf5VN47FQrH3jqqppSeRz+EqMUCjnmSmV1bY6nbgoC+kQjf/WlAQd3KKVdsi4uw6jH8zfjnCmYG4qOGY88xn+ExqhDeGAJL9Ad+cZRBsEp/aESND7iN4X3xhxL1BMHf1dpLzlAc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JkLu3J4q+kdoGRgoTQJtY2vu7gmSUeLdlzFAb2T9KBU=;
 b=L2Ru+wxzTGr0gLT9IUnHylOwJ0F5sGkRSfAHfndKGq31zVpVpDlo9eWJ1uHVVqVw0jPAd3Vr4C1C7HUt96Mgsp1XGpC6MHS9+Eh2hPYzkzsYpcnC+GzvkuzGT/ohPe8UE/3/dW7KUsEB4b/vy2kkjv0OTs5B7pU9i23lIJrVdMpX9NYeO2p9p7vM1H47hq20VY2vhj5g0l51vru7klXuHS7iGoJ/aOp+sk+AU8LskcPjRbJer1MtgUaEj7u0P8QIz62uDYyO/5xAyaD3HpI/Evx0kNw6+Kmqctq21pIAksDNMxqMZC5JZaQZWB3dnHRsEJYtFPj5HmpCYyuCN2OREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JkLu3J4q+kdoGRgoTQJtY2vu7gmSUeLdlzFAb2T9KBU=;
 b=H1/mCu4fQSrN2t/2/NxAMI96kyx64qDrxPZxvmq3to0rz0vA0jKqrAUdBmNr+KBQINwlOBXcPJ1hv2iWR9aYl6GsfP6c68noqOQwowETaTP/wQ9lqDW1+FGZAZKit3l3y7SbLt3x+FtIdbB5XvVkMleRRG8w2NcsfK2PBnwPArE=
Received: from MN2PR05CA0025.namprd05.prod.outlook.com (2603:10b6:208:c0::38)
 by MN0PR12MB6152.namprd12.prod.outlook.com (2603:10b6:208:3c4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Wed, 4 Oct
 2023 00:56:46 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:c0:cafe::74) by MN2PR05CA0025.outlook.office365.com
 (2603:10b6:208:c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.24 via Frontend
 Transport; Wed, 4 Oct 2023 00:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 00:56:46 +0000
Received: from ubuntu22.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 19:56:44 -0500
From: Victor Lu <victorchengchi.lu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/6] drm/amdgpu: Add new macro WREG32_RLC_XCC (v2)
Date: Tue, 3 Oct 2023 20:56:15 -0400
Message-ID: <20231004005616.108476-5-victorchengchi.lu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004005616.108476-1-victorchengchi.lu@amd.com>
References: <20231004005616.108476-1-victorchengchi.lu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN0PR12MB6152:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fdeef59-c99f-4c50-43a1-08dbc474c88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uxm4HVFVgoOB7Mx9fjpSkYjdWnZ8CzqMEghnGbTXTiRPmbDSMp3DTHSbgfmuK6U3/wowQCCk2nST1LMFdH/01JPC6G7vbovNDmEat6KSaUVwi8N/3Odnemb9+eSLhLWwtieUEMUe1zR8ujkHvLyTS+35pW8yrZJhb1qH46GSCHgJXYluzMLJWga4qh29sMED6nCci98lqOZw0HE4lNWfM+SWsNy4bYDrfGE495NwSVxRdOdYNm7ljTBM9Do3vOOePIwAYKLt+FXyf4F59aj3V9+9WQrhiOaN3amGa9I8i5m/iUM0vX0JxXIbAnWz70QIsYoGpm+tW1X5TSjLptFAmyUgmxKGiHXw1iLw7m/FJ95ePvk6QNe5S56vLqC3jfjhAYgDeprDfKcwmtBFcO0EUDgXSiglCyGWpMAfOQWyrCKoLLdn9sde6Rj9GgajIvJgNbuA3N8pMLyj8Krq0Vyho3rKEEpR1TLN30GNtmwnwPoUUhKn7Mu1wrlsT9FuaAsGXYeryivt7iqvoknEQVo3KYvFUhRfN6z3yVA7MjCyMCfeAsgQYzhKAM1FT/v0eUKumxlnb6C/C3tYV/mZ6+pwQfR40tQHBzj7Si39cw+S+3dazuayynGWofZtwNRPVvtR+41HfHQ7kikRin/30DTjPmcV6HVho4WPKgtEeaveVgkok9dxUU+Bs5j43Gz80k6JuOrXZU5Oq4x5a0jtJy4aiqVt/NE1PZEs1LA7VZlL2m84ytOTQ4KI/zMh2zkwREnixBgtP+ASwU8+YkJoSAyWSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(36840700001)(40470700004)(46966006)(47076005)(1076003)(478600001)(6666004)(83380400001)(36860700001)(26005)(336012)(16526019)(7696005)(426003)(356005)(82740400003)(81166007)(40480700001)(36756003)(2906002)(4326008)(8676002)(8936002)(40460700003)(2616005)(5660300002)(41300700001)(316002)(70206006)(6916009)(70586007)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 00:56:46.2605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fdeef59-c99f-4c50-43a1-08dbc474c88e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6152
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
Cc: lijo.lazar@amd.com, davis.ming@amd.com, victorchengchi.lu@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

WREG32_RLC does not specify the correct XCC so the RLCG interface does
not work.

Define WREG32_RLC_XCC to be like WREG32_RLC but include a parameter to
specify the XCC.

v2: Add new macro WREG32_RLC_XCC instead of modifying exiting WREG32_RLC
    macro

Original v1 title: "drm/amdgpu: Add xcc instance parameter to *REG32_RLC"

Signed-off-by: Victor Lu <victorchengchi.lu@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 41 +++++++++----------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 34 +++++++--------
 drivers/gpu/drm/amd/amdgpu/soc15_common.h     |  8 +++-
 3 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 490c8f5ddb60..084dbc41b579 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -300,14 +300,14 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	hqd_end = SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_AQL_DISPATCH_ID_HI);
 
 	for (reg = hqd_base; reg <= hqd_end; reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_RLC_XCC(reg, mqd_hqd[reg - hqd_base], inst);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL),
-				data);
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_DOORBELL_CONTROL),
+				data, inst);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -336,27 +336,26 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 		guessed_wptr += m->cp_hqd_pq_wptr_lo & ~(queue_size - 1);
 		guessed_wptr += (uint64_t)m->cp_hqd_pq_wptr_hi << 32;
 
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO),
-		       lower_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI),
-		       upper_32_bits(guessed_wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR),
-		       lower_32_bits((uintptr_t)wptr));
-		WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_LO),
+		       lower_32_bits(guessed_wptr), inst);
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_HI),
+		       upper_32_bits(guessed_wptr), inst);
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_PQ_WPTR_POLL_ADDR),
+		       lower_32_bits((uintptr_t)wptr), inst);
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
-			upper_32_bits((uintptr_t)wptr));
-		WREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
-		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id,
-			       queue_id));
+			upper_32_bits((uintptr_t)wptr), inst);
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_PQ_WPTR_POLL_CNTL1),
+		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id), inst);
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR),
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
-			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1), inst);
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data);
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), regCP_HQD_ACTIVE), data, inst);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -494,15 +493,15 @@ static uint32_t kgd_gfx_v9_4_3_set_address_watch(
 			VALID,
 			1);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+	WREG32_RLC_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_H) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_high);
+			watch_address_high, inst);
 
-	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+	WREG32_RLC_XCC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
 			regTCP_WATCH0_ADDR_L) +
 			(watch_id * TCP_WATCH_STRIDE)),
-			watch_address_low);
+			watch_address_low, inst);
 
 	return watch_address_cntl;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51011e8ee90d..2a4f1a1b2196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -91,8 +91,8 @@ void kgd_gfx_v9_program_sh_mem_settings(struct amdgpu_device *adev, uint32_t vmi
 {
 	kgd_gfx_v9_lock_srbm(adev, 0, 0, 0, vmid, inst);
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases);
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_CONFIG), sh_mem_config, inst);
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmSH_MEM_BASES), sh_mem_bases, inst);
 	/* APE1 no longer exists on GFX9 */
 
 	kgd_gfx_v9_unlock_srbm(adev, inst);
@@ -239,14 +239,14 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
 
 	for (reg = hqd_base;
 	     reg <= SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI); reg++)
-		WREG32_RLC(reg, mqd_hqd[reg - hqd_base]);
+		WREG32_RLC_XCC(reg, mqd_hqd[reg - hqd_base], inst);
 
 
 	/* Activate doorbell logic before triggering WPTR poll. */
 	data = REG_SET_FIELD(m->cp_hqd_pq_doorbell_control,
 			     CP_HQD_PQ_DOORBELL_CONTROL, DOORBELL_EN, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL),
-					data);
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_DOORBELL_CONTROL),
+					data, inst);
 
 	if (wptr) {
 		/* Don't read wptr with get_user because the user
@@ -275,25 +275,25 @@ int kgd_gfx_v9_hqd_load(struct amdgpu_device *adev, void *mqd,
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
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_LO),
+		       lower_32_bits(guessed_wptr), inst);
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_HI),
+		       upper_32_bits(guessed_wptr), inst);
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR),
+		       lower_32_bits((uintptr_t)wptr), inst);
+		WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+		       upper_32_bits((uintptr_t)wptr), inst);
 		WREG32_SOC15(GC, GET_INST(GC, inst), mmCP_PQ_WPTR_POLL_CNTL1,
 		       (uint32_t)kgd_gfx_v9_get_queue_mask(adev, pipe_id, queue_id));
 	}
 
 	/* Start the EOP fetcher */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR),
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_EOP_RPTR),
 	       REG_SET_FIELD(m->cp_hqd_eop_rptr,
-			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1));
+			     CP_HQD_EOP_RPTR, INIT_FETCHER, 1), inst);
 
 	data = REG_SET_FIELD(m->cp_hqd_active, CP_HQD_ACTIVE, ACTIVE, 1);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data);
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_ACTIVE), data, inst);
 
 	kgd_gfx_v9_release_queue(adev, inst);
 
@@ -556,7 +556,7 @@ int kgd_gfx_v9_hqd_destroy(struct amdgpu_device *adev, void *mqd,
 		break;
 	}
 
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type);
+	WREG32_RLC_XCC(SOC15_REG_OFFSET(GC, GET_INST(GC, inst), mmCP_HQD_DEQUEUE_REQUEST), type, inst);
 
 	end_jiffies = (utimeout * HZ / 1000) + jiffies;
 	while (true) {
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15_common.h b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
index c75e9cd5c98b..19b233189e73 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15_common.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15_common.h
@@ -110,6 +110,9 @@
 #define WREG32_RLC(reg, value) \
 	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, 0)
 
+#define WREG32_RLC_XCC(reg, value, inst) \
+	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_RLC, GC_HWIP, inst)
+
 #define WREG32_RLC_EX(prefix, reg, value, inst) \
 	do {							\
 		if (amdgpu_sriov_fullaccess(adev)) {    \
@@ -140,7 +143,10 @@
 
 /* for GC only */
 #define RREG32_RLC(reg) \
-	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP)
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP, 0)
+
+#define RREG32_RLC_XCC(reg, inst) \
+	__RREG32_SOC15_RLC__(reg, AMDGPU_REGS_RLC, GC_HWIP, inst)
 
 #define WREG32_RLC_NO_KIQ(reg, value, hwip) \
 	__WREG32_SOC15_RLC__(reg, value, AMDGPU_REGS_NO_KIQ | AMDGPU_REGS_RLC, hwip, 0)
-- 
2.34.1

