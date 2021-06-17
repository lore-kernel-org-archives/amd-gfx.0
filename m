Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3234BC49361
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC849613EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 08:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC849613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5FC6E8C0;
	Thu, 17 Jun 2021 08:39:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27BC16E8BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 08:39:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIo5nUF9L70qlQLWMAsHtUjHnvYqfmlNFIqC1miGk23EnAYw7uFXtE3DzlfSJSeeaimlzABTk8wEyXYtlO1+PLEBZR0QWEn4Ry00aXvgs1Bqxj/7EVKSVA6NLhjfHvLf2Z8T7pytGPx8736TAe/258V1RcTPkk3Dys7jZQEovDmOcO2rsrU8JRlpF8887L7zok2a4icBRVOQgWDGRfTjEs/r6GXMk8HVph5W3tbEAqcLThe8Ez7Mz8Ezz0jv1CPL3JveXbiy2DlxDo8Cn6jN8klNPPDMQnMSUWYN9g+OBZw/7VTxIhOwnd4JwBnhTAP5zKwP7UUslegcCfNp4xAI1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5dJ2hYgmAUZw/BuLimwuHfOY69u/wuhvlX0vPhk+2g=;
 b=GKNYefolIzANTnUVsUWkVmHiGgCyThP/rdXq75gltjI9yq1CUyKgAzmaFiG7njH1H1LrUXGlf4OC/NalVZ+L7TrhTpHLwXnCFbLQojkQ21pX6mk6TRctUsvdyLVt1p6VSkkoD6pgVtoaxDR2re4ooYD7kdX/xbC5NQZyb/z0iLbqHIUx58BbOyu7y1nWwBKIuNgM6eG4ouE61fv5jgqWrtHBnzqnj72NOVCdzce4OU1rdG8Myv1bvRGUeaQL24g3cG15tIcy4+CiXL42+/vO3WH2qSPGRrCr2pmAmqDuGoEMT9vDDBfWDGGMe5pSBxbre+LttdxNlYnCzmOHaiZr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5dJ2hYgmAUZw/BuLimwuHfOY69u/wuhvlX0vPhk+2g=;
 b=s/KX1LbHv0OxKked/NLFi3C2yJ/5hYZGoYrXL4KEOhfK3lUkEJlX/mIJot6cs9+s88/pqvhFDeUrzvSf79UN0JhkW63s+3/jzNuU/nyspjGyWI7fd+I08j1dVRgzZkuY1dV20lSXDHggYxfsmfwcTpuAPWEe1zpD2PWMssTvbLU=
Received: from BN9PR03CA0208.namprd03.prod.outlook.com (2603:10b6:408:f9::33)
 by DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Thu, 17 Jun
 2021 08:39:53 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::d0) by BN9PR03CA0208.outlook.office365.com
 (2603:10b6:408:f9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend
 Transport; Thu, 17 Jun 2021 08:39:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 08:39:53 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 17 Jun
 2021 03:39:52 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 2/7] drm/amdgpu: fix Navi1x tcp power gating hang when
 issuing lightweight invalidaiton
Date: Thu, 17 Jun 2021 16:39:18 +0800
Message-ID: <20210617083923.421052-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210617083923.421052-1-evan.quan@amd.com>
References: <20210617083923.421052-1-evan.quan@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ff23163-ed00-4277-baf8-08d9316b7a6a
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-Microsoft-Antispam-PRVS: <DM5PR12MB24702C5C5F8B4EAF2AAB8DEFE40E9@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HfDr+lRs6UYwHs60VEQaNisFlkiMqot0D+LK9+oh4DLcq3LdRPSFBxZ4dap8TODiwNw35mwMB1+tjI0AmeK+MtjSUMpdWuaNTuG/qiRA4GyH9kdiuvbjz+ZfxEJCoBkvjRAuBjH2RTYMkVWpyjeSQQ3BOeHSj65tanhlXKTQc4s1Z64WNGbv1lfANZ7FFfvip4cR43GuLr+6c6Vdsb0ZelpK+xjpW6ZqvB9hK6VMOZ4IaGl60uBz/fqafg+c7rFp0esx2E5fZ5GGn301Q0SlaGGt7CdNFP3UUNk1kPQ6EcOe2hV3ZYZvkPQc4DHWLd0f2lcv4r6MU9wgR5T6sgMf0rmcWaTNinXE7yCpqHxn/HX62kaO1FRGDxV76/HFitMio3jdDQKSyJqj596YrvpMjVBTob58K3gzyCQXQKF17dp6xhYzU2wIhtzU1UCLpGvFe/tew52o44NEZCBJCji/L5Srie9SarDC8FuKkVyxmXA6sm5SrgJI1GQuvWjTM+glN7fPCxgNIwhcbcQYPMBwiMx8/t8auwDpQ9pgQk9L3o1XZMbFpIRNef9i+uxLXbHxY5fTGFTgs/gYhNyD+o6qyzAfk2JtTgZentXEwzGkYawhsBu23V006S7DTpuaY+mx40s3cOjmrcCZgagOgigC2fUxEnelo2u0sncTFfNBg8D6Y3mtxFpGiwifs4yZ743wPppLmv9lByn0S4wEy2S/mmH5D/0tZmzGTv8/bShdntE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(36756003)(44832011)(47076005)(36860700001)(16526019)(6916009)(1076003)(186003)(316002)(54906003)(4326008)(478600001)(336012)(2906002)(356005)(81166007)(8936002)(70206006)(5660300002)(426003)(8676002)(83380400001)(26005)(86362001)(82310400003)(6666004)(82740400003)(7696005)(2616005)(70586007)(16393002)(32563001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 08:39:53.4282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff23163-ed00-4277-baf8-08d9316b7a6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix TCP hang when a lightweight invalidation happens on Navi1x.

Change-Id: I5000fefa9ec48a5e863372d298354bed1562b332
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
V1->V2:
  - Alex: use ARRAY_SIZE instead of hard code
  - limit the changes for Navi1x only
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 95 ++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 94942c6cae24..5cfd4800d5be 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -7970,6 +7970,97 @@ static void gfx_v10_0_update_fine_grain_clock_gating(struct amdgpu_device *adev,
 	}
 }
 
+static void gfx_v10_0_apply_medium_grain_clock_gating_workaround(struct amdgpu_device *adev)
+{
+	uint32_t reg_data = 0;
+	uint32_t reg_idx = 0;
+	uint32_t i;
+
+	const uint32_t tcp_ctrl_regs[] = {
+		mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP12_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP12_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP12_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP12_CU1_TCP_CTRL_REG
+	};
+
+	const uint32_t tcp_ctrl_regs_nv12[] = {
+		mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA0_WGP11_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP00_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP01_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP02_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP10_CU1_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU0_TCP_CTRL_REG,
+		mmCGTS_SA1_WGP11_CU1_TCP_CTRL_REG,
+	};
+
+	const uint32_t sm_ctlr_regs[] = {
+		mmCGTS_SA0_QUAD0_SM_CTRL_REG,
+		mmCGTS_SA0_QUAD1_SM_CTRL_REG,
+		mmCGTS_SA1_QUAD0_SM_CTRL_REG,
+		mmCGTS_SA1_QUAD1_SM_CTRL_REG
+	};
+
+	if (adev->asic_type == CHIP_NAVI12) {
+		for (i = 0; i < ARRAY_SIZE(tcp_ctrl_regs_nv12); i++) {
+			reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG_BASE_IDX] +
+				  tcp_ctrl_regs_nv12[i];
+			reg_data = RREG32(reg_idx);
+			reg_data |= CGTS_SA0_WGP00_CU0_TCP_CTRL_REG__TCPI_LS_OVERRIDE_MASK;
+			WREG32(reg_idx, reg_data);
+		}
+	} else {
+		for (i = 0; i < ARRAY_SIZE(tcp_ctrl_regs); i++) {
+			reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_WGP00_CU0_TCP_CTRL_REG_BASE_IDX] +
+				  tcp_ctrl_regs[i];
+			reg_data = RREG32(reg_idx);
+			reg_data |= CGTS_SA0_WGP00_CU0_TCP_CTRL_REG__TCPI_LS_OVERRIDE_MASK;
+			WREG32(reg_idx, reg_data);
+		}
+	}
+
+	for (i = 0; i < ARRAY_SIZE(sm_ctlr_regs); i++) {
+		reg_idx = adev->reg_offset[GC_HWIP][0][mmCGTS_SA0_QUAD0_SM_CTRL_REG_BASE_IDX] +
+			  sm_ctlr_regs[i];
+		reg_data = RREG32(reg_idx);
+		reg_data &= ~CGTS_SA0_QUAD0_SM_CTRL_REG__SM_MODE_MASK;
+		reg_data |= 2 << CGTS_SA0_QUAD0_SM_CTRL_REG__SM_MODE__SHIFT;
+		WREG32(reg_idx, reg_data);
+	}
+}
+
 static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 					    bool enable)
 {
@@ -7986,6 +8077,10 @@ static int gfx_v10_0_update_gfx_clock_gating(struct amdgpu_device *adev,
 		gfx_v10_0_update_3d_clock_gating(adev, enable);
 		/* ===  CGCG + CGLS === */
 		gfx_v10_0_update_coarse_grain_clock_gating(adev, enable);
+
+		if ((adev->asic_type >= CHIP_NAVI10) &&
+		     (adev->asic_type <= CHIP_NAVI12))
+			gfx_v10_0_apply_medium_grain_clock_gating_workaround(adev);
 	} else {
 		/* CGCG/CGLS should be disabled before MGCG/MGLS
 		 * ===  CGCG + CGLS ===
-- 
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
