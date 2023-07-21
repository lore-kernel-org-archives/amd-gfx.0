Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11697EB64DC
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 12:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8343910E65C;
	Fri, 21 Jul 2023 12:06:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7298D10E65C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 12:06:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDiPBrgx9h3dw1Ka4sWzuT1ga6iUi0m8jQTRKQoi/zf8hUbZG4rd/j+WwgBVzm+H1LpMTRRIHTGakzq2zUgpNxDb7AaopF6N8+9cYA397EfrIaxZZyu+ATDhpvR6NBNfQwXhDyBULH9yiMjFmu6ddW6Ou7G5/VRlEuCV7FnP/wLIXXVlL2rluTgL7X3sPh0gvWXWXH50bUaYjcd+w6d6IypgU91AdNYZ+uJggz0y/Be9XaKXfe+GnEV6LGx4QRAwl1MCQ1sTNoSig1Pplpa4VWf00LZjbCLFJRhqgThkSPDPek/yECVxH9baYRr3lNJ1TZwzESM7kCciSm2AzPb0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y28387GHIPH/PR7DzTMqWGFGVJqjVZOO8hQMZ6mCcdw=;
 b=ildxVMCA+ggBDgjjPZPRwnR1WpOgtEVqiqhUn03nT7rKnkmoNf+HdH/hOGx8TtMiwYU0/MhLvapbUJDK+lRyhaRg2pyQZrRy2zG1di8uIK510RRBaPKlq/jTC7TSRBcd/VbppChdoMw1q+4iODx0RwOh1Ch1DdY7OaZXmYy35Nwr+hgO1xfqW1cpwEfBcXQQDhenQ7JkEK2istPrZDDElbCGSEzZka9xLAc6IVDJtErx26X8cr1uqDYr/xr5ZNfScJ3TKu1jwS3njkWG0bPhy6r/TUfXOJzmAxIoSpHFlxJQxrFoaxW2nBudcEqhGff4j2GuElYY5IVLg6av1V/KMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y28387GHIPH/PR7DzTMqWGFGVJqjVZOO8hQMZ6mCcdw=;
 b=Xx6/0LM/ku3EGLfLGQoHbcF3yF5dX7Hk+H4pgvWadhTDY5QZJaBZhAzQkd91x0YkMrCuHErpKFv1VWoCZ/99XuK3zA4XYjA6/VxabghhC6HMVHvYlaHa97uPJFlT2MzMHidbtHONHUDRZ+Ew/3Xz5x4736erH12TUVk13iuDoiI=
Received: from BN9PR03CA0462.namprd03.prod.outlook.com (2603:10b6:408:139::17)
 by SJ0PR12MB6942.namprd12.prod.outlook.com (2603:10b6:a03:449::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.26; Fri, 21 Jul
 2023 12:06:32 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::be) by BN9PR03CA0462.outlook.office365.com
 (2603:10b6:408:139::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 12:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 12:06:31 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 21 Jul
 2023 07:06:31 -0500
Received: from stanley-test.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Fri, 21 Jul 2023 07:06:29 -0500
From: Stanley.Yang <Stanley.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Hawking.Zhang@amd.com>,
 <Tao.Zhou1@amd.com>, <YiPeng.Chai@amd.com>, <Candice.Li@amd.com>
Subject: [PATCH Review 1/1] drm/amdgpu: Fix out of range
Date: Fri, 21 Jul 2023 20:06:27 +0800
Message-ID: <20230721120627.608176-1-Stanley.Yang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|SJ0PR12MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: fa04f664-7ee4-436c-bd45-08db89e2ebd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rix+FaUOuJkrnbGZ5Ye/K9e1fmwPOpmJPISNJFTVmovwoEN3tJ+NhihtulXf255CS+1INj5bxVvGaUPq64j/yHNh7zoFTijiawGzySdXduScAAxvGICxFh9WOwwzUA/DLedbhQaa9Hn/HC+xcWXebg21dXQ8SYUIu9C64FmmaUZHn/LNUQseaerkKDRw+gWITINIpsgz81VCCANZG2mJ2u7vHtCC71VSCZ2rzu3X3vi7eoe4WMdI68vEIgRvEqbvb/nEL1E2CMnMtfKT2fTzu2/waiZp6J7Au2snaFE/+68+xzZ06+yG4dYkkVItWpMQQz+4gF7iEA6TFl4hAdHzT/Zg5TL5gCVz3rhoadnvrI1qfdEHBVEmcsCbIFHbH1c+XAC7v64bTKyreMN0k964ToPIaGkd5cYYTG/zkKA91ho5EGp6/dReaaiXuxDQ1wK+GQB4qJJnkrG9ukdhDDRP6MimzJD/EDyczDbRGcMfQ9vXKvOBV7hfWeRh/J6BJm1/r7WLbeWk5XyzSR/KgWLAFIIXDapJo7AZlOnTAkThAnCE1danAc7Plz75IBzI7cf/uMQ7ITGIlG3lL95DTuzz66h7V3wKLk1g2eAPcbn7ArQLeU5e6UoxYfC51eXftsrVGeFSO2rmgHdrxA3DLtyKoJXUt30cJe/t4DjG6I06ck+y/hv+XLu2Gfvmq2WmdTvmhSI9x2utIx9ZZfDVJcjLG3s+ZIlDcFMTSH4BsA8R+RRi/CHPHSCdNmNrj+DG66vS3B9TVv/tFAsLpTD1B9sgXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(376002)(346002)(136003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(2906002)(36860700001)(40460700003)(83380400001)(2616005)(47076005)(426003)(356005)(81166007)(86362001)(36756003)(82740400003)(186003)(336012)(110136005)(1076003)(41300700001)(26005)(40480700001)(7696005)(4326008)(316002)(6636002)(70586007)(70206006)(8676002)(8936002)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 12:06:31.4593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa04f664-7ee4-436c-bd45-08db89e2ebd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6942
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
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The xcc index should be refer to xcc_mask, convert xcc_mask
to counts then calculate device instance.

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 9053435488c5..cd833cd3ebd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1076,19 +1076,21 @@ static void gfx_v9_4_3_xcc_unset_safe_mode(struct amdgpu_device *adev,
 static void gfx_v9_4_3_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
 {
 	int xcc_id;
+	int num_xcc, dev_inst;
 	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
 
-	for (xcc_id = 0; xcc_id < AMDGPU_MAX_RLC_INSTANCES; xcc_id++) {
-		if (((1 << xcc_id) & adev->gfx.xcc_mask) == 0)
-			continue;
-		reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[GET_INST(GC, xcc_id)];
-		reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG0);
-		reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG1);
-		reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG2);
-		reg_access_ctrl->scratch_reg3 = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regSCRATCH_REG3);
-		reg_access_ctrl->grbm_cntl = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_CNTL);
-		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regGRBM_GFX_INDEX);
-		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_SPARE_INT);
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
+		dev_inst = GET_INST(GC, xcc_id);
+
+		reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[dev_inst];
+		reg_access_ctrl->scratch_reg0 = SOC15_REG_OFFSET(GC, dev_inst, regSCRATCH_REG0);
+		reg_access_ctrl->scratch_reg1 = SOC15_REG_OFFSET(GC, dev_inst, regSCRATCH_REG1);
+		reg_access_ctrl->scratch_reg2 = SOC15_REG_OFFSET(GC, dev_inst, regSCRATCH_REG2);
+		reg_access_ctrl->scratch_reg3 = SOC15_REG_OFFSET(GC, dev_inst, regSCRATCH_REG3);
+		reg_access_ctrl->grbm_cntl = SOC15_REG_OFFSET(GC, dev_inst, regGRBM_GFX_CNTL);
+		reg_access_ctrl->grbm_idx = SOC15_REG_OFFSET(GC, dev_inst, regGRBM_GFX_INDEX);
+		reg_access_ctrl->spare_int = SOC15_REG_OFFSET(GC, dev_inst, regRLC_SPARE_INT);
 	}
 }
 
-- 
2.25.1

