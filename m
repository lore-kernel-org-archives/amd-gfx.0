Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632F9C76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:45:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C680610F33F;
	Fri, 31 Mar 2023 22:44:58 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 147E610F33F
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az66vEzSoZUUVsvMC8Lm/nNlv69C6YsGnjS5XxJoqJjf6guIHmrbOxtvrNtLVU8BO2ncbS6Om954IGvQyzmN1HFxhj2bbe/ewaX5Je8wcp7XxprUbhXSQcgDNQU8ImujuKJ0FnY9rdTbQrILNDfTF51JydfBD2boY+i48t0ebxs4hHACFwldSFK2V0cezcT+JxnY+NgPQBcovB4oEpcuKQqGm6wFwzp+7AzqdGDbmFBljrudk0A0aO3Yu7Ra5mvh6ew/GjMNSX5MLOqM9aYqDFePYSWzCcMKKkm6/OlkrzE7cLvj3JeO2Ml7hgPedtVP5eJetErluft6auCIjWT9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oW7hjxTElzyRA0tEtBMY0sLpCdP5j3x0WuVPoiPXT10=;
 b=EvMU3Xy5XpDrgPdojZ16Rivd2P6I74GuG8c2BZHanjOP+9ewDbHB2umWfm3pEagrb6cADYUo9NEVrAputvjdllW7icDKdsTuE3Y0w6a6nx8aPdMJtNB9EHSRKhfqapejSNPBxXPXv8/nJiov+XoXNW/fxDNEp6fRnZAnqaYd2QGsicQ/H14ylRuIPG24LhzTgfYVMi+Ua5kVCgTUAwCoB/IbT+bIkZQJ7RKxe89T/HZgBGLgU1FsEi9ZXE79qFQQhUiWvS++xw8bCObm/Lg2GgJER/qKGfHdstbeh1gezk5aGRXAMg5L8HeIWJSM1BfhHegEIviKH2d3vFUCUiFbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oW7hjxTElzyRA0tEtBMY0sLpCdP5j3x0WuVPoiPXT10=;
 b=HYpopxTQ0krLs+oWMIheLDCs1acJ6AmSXXe8sKrx0Jk8FX+XUMoJd4fQXEN8ZB8WLzY6BsJsXaJQMeFe7klup8B9GsOSKf99u9Tz9ZToyMPoMhyPCCfr2br7N7dPdeMjLdqsNO0n1bt2KXV33VHEUCc4+ob7ESMMFR/anLb7XJk=
Received: from MW4PR04CA0383.namprd04.prod.outlook.com (2603:10b6:303:81::28)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 22:44:49 +0000
Received: from CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::7e) by MW4PR04CA0383.outlook.office365.com
 (2603:10b6:303:81::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Fri, 31 Mar 2023 22:44:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT094.mail.protection.outlook.com (10.13.174.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6277.15 via Frontend Transport; Fri, 31 Mar 2023 22:44:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 31 Mar
 2023 17:44:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/11] drm/amdgpu: Add reset_ras_error_status for mmhub v1_8
Date: Fri, 31 Mar 2023 18:44:25 -0400
Message-ID: <20230331224425.8755-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331224425.8755-1-alexander.deucher@amd.com>
References: <20230331224425.8755-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT094:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 51038811-07e0-40d3-019b-08db32398891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rt2OxW+99q7HRJ+vwyqjzVYqP9sX0Pue/bYfCvSBhz3rH1YFnJwU8rG0dH9zMAnME30fYPGwAwj8k2L31PEL4hTogOnGcFz4+rLJx6nN3JUH2rM1ySKx4CjesSP4MFT4iTsokN0f/6oWfrg/5zc4w4cWTkTaWEo4ba70f5/Qgu1POfYo3PLaytzN0y/PC2CqCd/ns/ySsPGjsRcqlxaGAbQBTdjN+uiNlqDbkpKurHVg84rIEFSrC91UqPMle3aFtr0DG6Gsia7XSuVdxSwuFYc1Idw/w0q5SyWMa/uhCcKvi+V1sVhbjZglO6tsYzSRmGLylI5Pop02kt/dpHG+sAFZ1Um5KwKeYAv93Oip/K4tHRdHsjmEb+buLtjaRW6tDinbTf/nSrWYq4ic2XDv+aQbeLEjSRDzDdNBTdoIZskpm1FAiwwypW0ttZvt6ylvdZLNtQmtTPKIEyn5e9hGMM+j7jhEbRh+4SulNrXNGJZ5jGIChSS/3cTdVKw8BAIIlVAG+pcvgf6eJy0Y5GLADhTkDxlfn5yRBw/G+SMuK7pyrynNpyPBo6KcOSv+vO0o/84zmVyqUFIJ+7BALELsGaff1eiwR7LcvuFBASJcMMoXAog907w8avffyGbU4KZDHt+00yRNYS6M6FgHwilH7N12LUnXKC554ttjPJ81so+ele4rU6HydHO4B/d5WC261q+lVCK7u0sBkaVZk9MS8o0Te+jU5iNYe9OX9/ip24Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(36860700001)(5660300002)(83380400001)(70206006)(426003)(2616005)(8936002)(336012)(1076003)(7696005)(316002)(16526019)(478600001)(54906003)(186003)(2906002)(6666004)(26005)(36756003)(4326008)(82310400005)(86362001)(8676002)(40460700003)(41300700001)(81166007)(356005)(6916009)(82740400003)(70586007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 22:44:48.7223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51038811-07e0-40d3-019b-08db32398891
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT094.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hawking Zhang <Hawking.Zhang@amd.com>

Add reset_ras_error_status callback for mmhub
v1_8. It will be used to reset mmhub error status.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 91 +++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 3f4db860ed09..5c962dba8ece 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -756,3 +756,94 @@ static void mmhub_v1_8_query_ras_error_status(struct amdgpu_device *adev)
 	for_each_inst(i, inst_mask)
 		mmhub_v1_8_inst_query_ras_err_status(adev, i);
 }
+
+static const uint32_t mmhub_v1_8_mmea_cgtt_clk_cntl_reg[] = {
+	regMMEA0_CGTT_CLK_CTRL,
+	regMMEA1_CGTT_CLK_CTRL,
+	regMMEA2_CGTT_CLK_CTRL,
+	regMMEA3_CGTT_CLK_CTRL,
+	regMMEA4_CGTT_CLK_CTRL,
+};
+
+static void mmhub_v1_8_inst_reset_ras_err_status(struct amdgpu_device *adev,
+						 uint32_t mmhub_inst)
+{
+	uint32_t mmea_cgtt_clk_cntl_addr_dist;
+	uint32_t mmea_err_status_addr_dist;
+	uint32_t reg_value;
+	uint32_t i;
+
+	/* reset mmea ras err status */
+	mmea_cgtt_clk_cntl_addr_dist = regMMEA1_CGTT_CLK_CTRL - regMMEA0_CGTT_CLK_CTRL;
+	mmea_err_status_addr_dist = regMMEA1_ERR_STATUS - regMMEA0_ERR_STATUS;
+	for (i = 0; i < ARRAY_SIZE(mmhub_v1_8_mmea_err_status_reg); i ++) {
+		/* force clk branch on for response path
+		 * set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN = 1 */
+		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
+						regMMEA0_CGTT_CLK_CTRL,
+						i * mmea_cgtt_clk_cntl_addr_dist);
+		reg_value = REG_SET_FIELD(reg_value, MMEA0_CGTT_CLK_CTRL,
+					  SOFT_OVERRIDE_RETURN, 1);
+		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
+				    regMMEA0_CGTT_CLK_CTRL,
+				    i * mmea_cgtt_clk_cntl_addr_dist,
+				    reg_value);
+
+		/* set MMEA0_ERR_STATUS.CLEAR_ERROR_STATUS = 1 */
+		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
+						regMMEA0_ERR_STATUS,
+						i * mmea_err_status_addr_dist);
+		reg_value = REG_SET_FIELD(reg_value, MMEA0_ERR_STATUS,
+					  CLEAR_ERROR_STATUS, 1);
+		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
+				    regMMEA0_ERR_STATUS,
+				    i * mmea_err_status_addr_dist,
+				    reg_value);
+
+		/* set MMEA0_CGTT_CLK_CTRL.SOFT_OVERRIDE_RETURN = 0 */
+		reg_value = RREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
+						regMMEA0_CGTT_CLK_CTRL,
+						i * mmea_cgtt_clk_cntl_addr_dist);
+		reg_value = REG_SET_FIELD(reg_value, MMEA0_CGTT_CLK_CTRL,
+					  SOFT_OVERRIDE_RETURN, 0);
+		WREG32_SOC15_OFFSET(MMHUB, mmhub_inst,
+				    regMMEA0_CGTT_CLK_CTRL,
+				    i * mmea_cgtt_clk_cntl_addr_dist,
+				    reg_value);
+	}
+
+	/* reset mm_cane ras err status
+	 * force clk branch on for response path
+	 * set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET = 1 */
+	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
+	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
+				  SOFT_OVERRIDE_ATRET, 1);
+	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL, reg_value);
+
+	/* set MM_CANE_ERR_STATUS.CLEAR_ERROR_STATUS = 1 */
+	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS);
+	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ERR_STATUS,
+				  CLEAR_ERROR_STATUS, 1);
+	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ERR_STATUS, reg_value);
+
+	/* set MM_CANE_ICG_CTRL.SOFT_OVERRIDE_ATRET = 0 */
+	reg_value = RREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL);
+	reg_value = REG_SET_FIELD(reg_value, MM_CANE_ICG_CTRL,
+				  SOFT_OVERRIDE_ATRET, 0);
+	WREG32_SOC15(MMHUB, mmhub_inst, regMM_CANE_ICG_CTRL, reg_value);
+}
+
+static void mmhub_v1_8_reset_ras_error_status(struct amdgpu_device *adev)
+{
+	uint32_t inst_mask;
+	uint32_t i;
+
+	if (!amdgpu_ras_is_supported(adev, AMDGPU_RAS_BLOCK__MMHUB)) {
+		dev_warn(adev->dev, "MMHUB RAS is not supported\n");
+		return;
+	}
+
+	inst_mask = adev->aid_mask;
+	for_each_inst(i, inst_mask)
+		mmhub_v1_8_inst_reset_ras_err_status(adev, i);
+}
-- 
2.39.2

