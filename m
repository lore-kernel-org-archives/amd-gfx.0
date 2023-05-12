Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF79C77B7C
	for <amd-gfx@archiver.kernel.org>; Fri, 12 May 2023 03:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52F310E57B;
	Fri, 12 May 2023 03:18:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC3EF10E57B
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 May 2023 03:18:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMw0BualHTb43/qcX6kxpuEKmqVSY5f40sS4bSv1ZALo3bYsuy2DGF0iS2rEl9KUCm1HhGuBfEY/pQDH2HdLxE5zid9HPVPziJFSPRWWPMEa/IfsTj27vYSBK1tnFmBQHjS+PEGLlqgU90e1SYOUvaQVPi3zOKYrR8wu/WBs9DejfxbAyA5dJrgxG6KHPgK+xllOPoDHqLeR4QOx+ajsi7IT/tGThHVi3reB3wDOq9bXtNH5JGtkm+qqA9ZX0SlWuCCtlV6GGq26jjOecnvsIHTb/mqfCPaOAabaokdQWsQ+FvbqatvZjPWA7Ju8tqdbbQjMI7s5gAr5V90LIbkrcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MVK2h/AHe0c6AIiaORVp8oCPzrbeZ2QDItYD33I6zw=;
 b=Jl20nI8qk62KX0PIG+KmA9hPw18Q/p45G+W6RBg6i6cmAFIZdb8rwD8F9Kn8JnDhb4KgShgp8WztrJsnzpdlbWeQJmSSOkxdcMJ2EDa4jGW2EJrnNgddbGRB0+C/6g3urLIDGJHnB14oT6bxnRmhqVPsFyakbsItdwraazn+r4IIt6RJAyEIM5wG7+nYygk4SpWPn0SjX70qoNSdmCW6JBZm5tVM+GVY7EQ64pyvOBbOXk8LVLHX1HpMbUcWWFyu3jSpOSW5w2wi3Kf34/dSjkzF2aMOugECPhxaAUWG2GeYC3DK7iz3WjeFro0T+5mejpunuFfE0aGe80eQuEgNEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MVK2h/AHe0c6AIiaORVp8oCPzrbeZ2QDItYD33I6zw=;
 b=yGBoE/mm21mrr3CbpIAgijx7BhCs93F8xzXJ7SgeE1WesFEi0gGHFgi2FEx+XKNIOjGlmiwcYLJAldYbUAVnmWh+MbTj07tSZAEPPv1Fsva9UwYs07YR0M3ajfH2Vd25/F/Z+sToJrXjduuoNY7jtgcOSsVVbtATxFh+RzpXPyw=
Received: from BN9PR03CA0293.namprd03.prod.outlook.com (2603:10b6:408:f5::28)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 03:18:19 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::32) by BN9PR03CA0293.outlook.office365.com
 (2603:10b6:408:f5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 03:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.23 via Frontend Transport; Fri, 12 May 2023 03:18:19 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 11 May
 2023 22:18:17 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: fix possible power mode mismatch between driver
 and PMFW
Date: Fri, 12 May 2023 11:18:01 +0800
Message-ID: <20230512031801.471234-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: e4c5e5c3-d6e5-45f9-4c03-08db52978907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLFXWbfXP4QJdWinxTgmyB/msWBn11e0Z8zZl+Lv36TxZ96UlyWHvuPLwFPohktiB68jP9rx1fLs1jLnNp1GVAPyKhYbCSFBFcahTfo8klyd43S2Aa6LpkMMCFwmVhJpzKmSW0/+E+3I25hDJNGm6rxMMwM/IfZ/NHlt9MlExIRi/OlUbRhdX+87y8+eUQNtgZlx4bPpxUHstIRzcniD3rxfe25eqS60iBpY5lelUGMxkO5jkfNBOTNXVgIa8zKr9+oD9kf58R1GlSEt5DC/e+h///F8wNZ0Crnlg5Rn1D60MeBWiVtM2HTrQqp1fIcZiTIXrN1C32cM0HoV1zb96P6rDxnlOq+SF3IVx3Ki38mQOJt0ydvVkaTe6Cn6DimCpFfp9yxv8mA0rT815aiCC3TC2DXf96BoSevPUSrMWRAnER4GaRMnAiK1pO2Ie7qsWVVdOyk/nOOCK1/Ab6Gu3UXml+fBOQM6Av0JUUBxe9zhuu/aYj+rlUfvmxJeo77czcsG9ENl6h9V6U5g7phgK81Vc/ITVA4/kOQ2tazBtuHp/Oca3oeRIS4e2/RImEdOzrMpBqGC4U3v03DlmUoGDXAUkOZ/UgUkK0Vh+lpk5sK6RdqNNx0hoSsF04gE5Lw8pdnN7Fso1nm+GkfQbgV4EHt/cORE5C1suOPgEeiHvkSie92Jg3V7nHzRsgRXUwCvwO5Ksp5oADEb2IokFlqQLOredwtYSiDo3vk7Ydy9pW5fE2BNbKlTvEJCTNBbuHlv228LA1y95q/7M3tvr3D/UQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199021)(40470700004)(46966006)(36840700001)(54906003)(478600001)(2906002)(70206006)(70586007)(2616005)(316002)(6666004)(41300700001)(4326008)(6916009)(8936002)(8676002)(5660300002)(44832011)(26005)(186003)(1076003)(16526019)(83380400001)(426003)(336012)(47076005)(7696005)(36860700001)(81166007)(356005)(82740400003)(40460700003)(82310400005)(86362001)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 03:18:19.5084 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c5e5c3-d6e5-45f9-4c03-08db52978907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 kenneth.feng@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

PMFW may boots the ASIC with a different power mode from the system's
real one. Notify PMFW explicitly the power mode the system in. This
is needed only when ACDC switch via gpio is not supported.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 18 +++++++++++++++++
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 20 +------------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  1 +
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5633c5797e85..2ddf5198e5c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -733,6 +733,24 @@ static int smu_late_init(void *handle)
 		return ret;
 	}
 
+	/*
+	 * Explicitly notify PMFW the power mode the system in. Since
+	 * the PMFW may boot the ASIC with a different mode.
+	 * For those supporting ACDC switch via gpio, PMFW will
+	 * handle the switch automatically. Driver involvement
+	 * is unnecessary.
+	 */
+	if (!smu->dc_controlled_by_gpio) {
+		ret = smu_set_power_source(smu,
+					   adev->pm.ac_power ? SMU_POWER_SOURCE_AC :
+					   SMU_POWER_SOURCE_DC);
+		if (ret) {
+			dev_err(adev->dev, "Failed to switch to %s mode!\n",
+				adev->pm.ac_power ? "AC" : "DC");
+			return ret;
+		}
+	}
+
 	if ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 1)) ||
 	    (adev->ip_versions[MP1_HWIP][0] == IP_VERSION(13, 0, 3)))
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c4000518dc56..275f708db636 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3413,26 +3413,8 @@ static int navi10_post_smu_init(struct smu_context *smu)
 		return 0;
 
 	ret = navi10_run_umc_cdr_workaround(smu);
-	if (ret) {
+	if (ret)
 		dev_err(adev->dev, "Failed to apply umc cdr workaround!\n");
-		return ret;
-	}
-
-	if (!smu->dc_controlled_by_gpio) {
-		/*
-		 * For Navi1X, manually switch it to AC mode as PMFW
-		 * may boot it with DC mode.
-		 */
-		ret = smu_v11_0_set_power_source(smu,
-						 adev->pm.ac_power ?
-						 SMU_POWER_SOURCE_AC :
-						 SMU_POWER_SOURCE_DC);
-		if (ret) {
-			dev_err(adev->dev, "Failed to switch to %s mode!\n",
-					adev->pm.ac_power ? "AC" : "DC");
-			return ret;
-		}
-	}
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 3d9ff46706fb..98a33f8ee209 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1770,6 +1770,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_funcs = {
 	.enable_mgpu_fan_boost = smu_v13_0_7_enable_mgpu_fan_boost,
 	.get_power_limit = smu_v13_0_7_get_power_limit,
 	.set_power_limit = smu_v13_0_set_power_limit,
+	.set_power_source = smu_v13_0_set_power_source,
 	.get_power_profile_mode = smu_v13_0_7_get_power_profile_mode,
 	.set_power_profile_mode = smu_v13_0_7_set_power_profile_mode,
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
-- 
2.34.1

