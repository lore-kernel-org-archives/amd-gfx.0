Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F713C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Oct 2022 21:28:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FDD10E065;
	Tue, 11 Oct 2022 21:28:44 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 501DE10E065
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Oct 2022 21:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNx6FbymmEpMS9VrRtC9Ry7ls0akiA1U0NOpi+1IiOk9yyu0cv8JTQ8g765uXkp3qpFUUF3CmBm6B2+5dVh/V3PJIMx4b/eWj830jPGVjwaWaF+pxLQXKHPPTpNWX7ser+k8rzwLucKYJ1347BLa2xt/WE19YAxxwJsr0j5uXgbNPaYCecNmQtJ2JeYN78cHhdidnAK6HxcRJEklkFnbIZX/C0IlwpSDAC9+p+JoUdy9IZNyBOE78iT/trSbSWdsih8jeFWIdKk2KZyUSZqcuVKqCWcekfcffPKwB+7G37+w9ns1zXsh0OOrWMT8moiG4NOqrwJso187CYlxg5mAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+KD50zEHfkeAnMW2p7Kx8TyqmR4rgI50bNJVkiEhv4=;
 b=JcsNn5+z30c1RZz7PlBNOrwllWivfMCiiUSUINAm+e9B9npQEZNYohLbC6vPiRNWSZD8c805IP1Buw9vEsQlNhTM34K38vyIh390kzQRioFS/MQEvI0DGxKUYSgfQk0IpZBXpV2ldKV+6ByHBdPksX94THfcHRZHzKui8HBVEbZsaCYrFguQItoZuRQhJPzsd6e2vt74Z8wTM00pYrnH76axuUQO6h1owwfroMSXHEk6acfjVmufHln5XlqA6t9klmF3SoNbAQrPBNVg6DSi7p8iWbVs/FRZllub1SQUFSW3SJeAUJ4jr1GheI2nr66jE2Y1p7FW7Nk87rpVshDgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+KD50zEHfkeAnMW2p7Kx8TyqmR4rgI50bNJVkiEhv4=;
 b=i8ZeNsPE42HUr0jhNpc44qWM2uCgYernhYz0KnzNxvPnvaqasqbhmMOZ6wf5VocsKezHIRknLcRUVwsquY3xXEOpHBs2st/0ZPhNqCM3P08/vQ0uVX5ozuwagCa8sPMrTLaD/dexU+iTs0D5Ki88BmaWJ1nYUFfjKhJVx5XLQX4=
Received: from MW4PR04CA0115.namprd04.prod.outlook.com (2603:10b6:303:83::30)
 by DS7PR12MB5934.namprd12.prod.outlook.com (2603:10b6:8:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 11 Oct
 2022 21:28:39 +0000
Received: from CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::a6) by MW4PR04CA0115.outlook.office365.com
 (2603:10b6:303:83::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.19 via Frontend
 Transport; Tue, 11 Oct 2022 21:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT101.mail.protection.outlook.com (10.13.175.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Tue, 11 Oct 2022 21:28:38 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 11 Oct
 2022 16:28:36 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: switch to select_se_sh wrapper for gfx v9_0
Date: Tue, 11 Oct 2022 17:28:20 -0400
Message-ID: <20221011212820.2669221-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT101:EE_|DS7PR12MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d50039c-3ec0-4fe3-f211-08daabcf8fe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UE3RkpT84F697n1un92ObK0UdUffovOYww1v8NDwmiKhe8+gcVUTcMG+4E6xjyxlRdWp1pg+1M5lrraKq+EEGYGzZcBc1ziTG5H12SqjTPcvOsvAquM4iqwz/1tAOYRwXicIJugxqus2KCejVd9t91qfx6xMGzVAp7sWfYLHzqjAnKOiL5h3i2dNq22P4M7tWk2+zW5bzCd8GpDp9JCSOyygsBBLctc/gOac2tNPGBcwem1FmDS889skC7sm4VamBOGjvAI3JuRZgKH3HVxlCxalXFuGXmnBif/118HtA6k6zg1Gl/YF97fvglGCY6nFCpZHjgF0g+KxphLPmALxK2Z9aenF9p96i1hj5BEN5M1t48BCYs/9rMMMgzNzcVNiEWXp8M2QmE+VKgp0c9cC7Vj7HRnp7klJ1neyAWexFglYnR6dG0Rv6z18b9C9Ng8lvVgGb8q7r2sYsjMd5N3FCeKn7iWWthGeGMFn6KxXid9R9CjI1jMP+lFh7z1ldMBMgNru/EGoxnVHGYDnAcTLDuQEonuxtB2qz7w/rYOZLIpAbRtAayiToHE91+EUJupppPVesmJq14bD92CoGViVX1PJe/6kfJrA9zfGjx6Ffv69uNCxJSIi294XawcZmjFZzSH1DWlkx8bfh7MKYT4/neQyQ0p7dUuW1AZ0Z/MpIJQGIYNCLkTVS6DZhMQ9vuxJXAeABIMPlbwdEXc2BRy08IIVcKKRqmmbj3ANKx3YuCEs2LkCX0bAxPsysjArl1tMu0qgwG7MsFeQXgUD4zpGYrtxxoya0IQyPciCUIUDEOLKhKxgN95HZf9SWwSR9pUx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(6916009)(54906003)(36756003)(86362001)(336012)(8936002)(16526019)(5660300002)(36860700001)(426003)(1076003)(186003)(2616005)(47076005)(356005)(81166007)(70206006)(7696005)(6666004)(8676002)(478600001)(70586007)(82310400005)(316002)(40460700003)(4326008)(83380400001)(82740400003)(41300700001)(2906002)(40480700001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2022 21:28:38.4991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d50039c-3ec0-4fe3-f211-08daabcf8fe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5934
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

To allow invoking ip specific callbacks

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  4 +--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         | 28 +++++++++----------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 81e3b528bbc9..e92b93557c13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -787,7 +787,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
 		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
 
-			gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
 			queue_map = RREG32_SOC15(GC, 0, mmSPI_CSQ_WF_ACTIVE_STATUS);
 
 			/*
@@ -820,7 +820,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 		}
 	}
 
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	soc15_grbm_select(adev, 0, 0, 0, 0);
 	unlock_spi_csq_mutexes(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 0320be4a5fc6..456c8e189b7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1564,7 +1564,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
 			mask = 1;
 			cu_bitmap = 0;
 			counter = 0;
-			gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k ++) {
 				if (cu_info->bitmap[i][j] & mask) {
@@ -1583,7 +1583,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
 			cu_info->ao_cu_bitmap[i][j] = cu_bitmap;
 		}
 	}
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
 }
 
@@ -1605,7 +1605,7 @@ static void gfx_v9_0_init_lbpw(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	/* set mmRLC_LB_INIT_CU_MASK thru broadcast mode to enable all SE/SH*/
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	WREG32_SOC15(GC, 0, mmRLC_LB_INIT_CU_MASK, 0xffffffff);
 
 	/* set mmRLC_LB_PARAMS = 0x003F_1006 */
@@ -1654,7 +1654,7 @@ static void gfx_v9_4_init_lbpw(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->grbm_idx_mutex);
 	/* set mmRLC_LB_INIT_CU_MASK thru broadcast mode to enable all SE/SH*/
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	WREG32_SOC15(GC, 0, mmRLC_LB_INIT_CU_MASK, 0xffffffff);
 
 	/* set mmRLC_LB_PARAMS = 0x003F_1006 */
@@ -2324,13 +2324,13 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
 			data = gfx_v9_0_get_rb_active_bitmap(adev);
 			active_rbs |= data << ((i * adev->gfx.config.max_sh_per_se + j) *
 					       rb_bitmap_width_per_sh);
 		}
 	}
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	adev->gfx.config.backend_enable_mask = active_rbs;
@@ -2467,14 +2467,14 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 	mutex_lock(&adev->grbm_idx_mutex);
 	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
 		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
 			for (k = 0; k < adev->usec_timeout; k++) {
 				if (RREG32_SOC15(GC, 0, mmRLC_SERDES_CU_MASTER_BUSY) == 0)
 					break;
 				udelay(1);
 			}
 			if (k == adev->usec_timeout) {
-				gfx_v9_0_select_se_sh(adev, 0xffffffff,
+				amdgpu_gfx_select_se_sh(adev, 0xffffffff,
 						      0xffffffff, 0xffffffff);
 				mutex_unlock(&adev->grbm_idx_mutex);
 				DRM_INFO("Timeout wait for RLC serdes %u,%u\n",
@@ -2483,7 +2483,7 @@ static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)
 			}
 		}
 	}
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	mask = RLC_SERDES_NONCU_MASTER_BUSY__SE_MASTER_BUSY_MASK |
@@ -6482,7 +6482,7 @@ static void gfx_v9_0_reset_ras_error_count(struct amdgpu_device *adev)
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
 		for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
 			for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
-				gfx_v9_0_select_se_sh(adev, j, 0x0, k);
+				amdgpu_gfx_select_se_sh(adev, j, 0x0, k);
 				RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
 			}
 		}
@@ -6544,7 +6544,7 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	for (i = 0; i < ARRAY_SIZE(gfx_v9_0_edc_counter_regs); i++) {
 		for (j = 0; j < gfx_v9_0_edc_counter_regs[i].se_num; j++) {
 			for (k = 0; k < gfx_v9_0_edc_counter_regs[i].instance; k++) {
-				gfx_v9_0_select_se_sh(adev, j, 0, k);
+				amdgpu_gfx_select_se_sh(adev, j, 0, k);
 				reg_value =
 					RREG32(SOC15_REG_ENTRY_OFFSET(gfx_v9_0_edc_counter_regs[i]));
 				if (reg_value)
@@ -6559,7 +6559,7 @@ static void gfx_v9_0_query_ras_error_count(struct amdgpu_device *adev,
 	err_data->ce_count += sec_count;
 	err_data->ue_count += ded_count;
 
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	gfx_v9_0_query_utc_edc_status(adev, err_data);
@@ -6963,7 +6963,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 			mask = 1;
 			ao_bitmap = 0;
 			counter = 0;
-			gfx_v9_0_select_se_sh(adev, i, j, 0xffffffff);
+			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff);
 			gfx_v9_0_set_user_cu_inactive_bitmap(
 				adev, disable_masks[i * adev->gfx.config.max_sh_per_se + j]);
 			bitmap = gfx_v9_0_get_cu_active_bitmap(adev);
@@ -6996,7 +6996,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 			cu_info->ao_cu_bitmap[i % 4][j + i / 4] = ao_bitmap;
 		}
 	}
-	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
+	amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
-- 
2.37.3

