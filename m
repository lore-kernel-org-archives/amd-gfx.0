Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A69C0032E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Oct 2023 02:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2D7310E112;
	Thu, 26 Oct 2023 02:30:22 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4CFF10E72E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Oct 2023 02:30:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NFOT0yFihhhJQamlxgzYGdHY2mHLq5H+ESgaxDrW7HP/IqOtLvtsYUyWOxhnpxmoX+C2DO8vFT08XtHTl78zBCpr6LB4CXFzJRrN2qTKvwlruUnqoN9A825SqxtpbXgwbiLi4EZmGALewYcFB460LTLWLdjvK9bRXB1y4bnDt6G5yJ55uu+ErOWgBlXxrBxZO1IFsRj8ywS+qN5cUhStVMIluOKi3An2yds1gf82eehmZ5b56avA5oywbD9TK4TqJuO+V0wPuTg9Irs7z9dacHLpVa/7semt/AtVsk0Ew7NgiNBhfSVG+ETCLUWVFxdXKyew8La/fcEJ2eWvftJQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYaekmf8K08N1WTqtZE39XnJrBbh+6CEx7rAF8PIGQI=;
 b=UvSGk/LSyAtFku+Yg35hckF3lz54LQ37t+nWewrh+Ab0Z2e9CpiUFaNAwO6uOIfq1j1Nh4JqNA6H7UM8vQIKFaXtIXuq0ah782zvqr2CM8Pevlpx5XO8qUGwgf0ibFtr9/uHgDFyV+x5nuV+/9TfkimEqcFRKvyvu/5gZpF+Yzw5oLehQAshQK/o0BZKukX7oatyTGIUzpcrcRHZxSuQis1X7D1H731H19pk2nLZ37MmS3rX5X5NS9L81PUe9t36AUtnNOJUoBb+QlPNyWKGi6R1ZFqg5zommvlTX08QM+DKTYEPR2h4Xya9iyMllbDGR3Uy2iM2/f2QCkMYrjItpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYaekmf8K08N1WTqtZE39XnJrBbh+6CEx7rAF8PIGQI=;
 b=27hdL9QDnGLLejx/kHxlur7rNa0gA8PCnjHDzXFNvzphC8hq+pq8OOaaZEx5GIjpR/c18JHusAXmZpwHQdR2U+CqH5UazUINFBQOAO0U7xBXpCdeW0+4L2QcydU5BVsfSgoxFDhoGbuWVT5FU5K58Qm9d1Qhuyx3//FE7n0OY5U=
Received: from DM6PR14CA0058.namprd14.prod.outlook.com (2603:10b6:5:18f::35)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 02:30:18 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::fa) by DM6PR14CA0058.outlook.office365.com
 (2603:10b6:5:18f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19 via Frontend
 Transport; Thu, 26 Oct 2023 02:30:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Thu, 26 Oct 2023 02:30:18 +0000
Received: from canli-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 25 Oct
 2023 21:30:16 -0500
From: Candice Li <candice.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Identify data parity error corrected in replay
 mode
Date: Thu, 26 Oct 2023 10:30:03 +0800
Message-ID: <20231026023003.642684-1-candice.li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 87fbf78c-19de-41b7-ea16-08dbd5cb7e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SggWJDnRkmXarI9Z5C1VQ/s9MuDk/NYnU01GUA0J6BVSKd2RuQIfJd/Ie+Nfh4hW7uejHQFurhU97l2/2E1D0vGUDYX3eaT+fxI1x+n58PluKt236rG8WKXMWqnfBtStkTZk9TjHjriA8qSEpnIJcPOo0NeQ6D+y5CCNWiVL+HyIymozp11KEzmQ+jByxpffC3WVVzDpk2FbOd245gf2jRedBAnOioDMiw5ZNYMl7V8SMWJ+yI0P9GkCZjmY/InH4acTQhcbbb0jERpZvkNIwcW73xfDJKd+mXDq1k28zyYUrrrz1dCnPy3qxBZpZbqYiLFbDmDks7KmT2jvFVzv07Y/ku+1jFwTpeCTKMugtEGVwTGuyKOunTC+zCayIPSE+YravviSvta3p0OHWJHe2Onwk8LILGOIObE31YwReXWe/VhZdTjQ8wjMJrE/4k9f4BSVQ8VXE7wlJX3GnfY4BTlWtsvDajR6WushBzdE1IVCn4uUBiRXyj5o0fDm03Kn54EzRScjDbm+gvxRrkc6GMWExEMHuOu27RtBQqC98K+tviAPZB2hehJ757dNGcrHgSQZ+RuWmnfqT9uuILz2wbz5WxEeMkr9dihAdmYEbPzKBDmxdDBj1tL4723HXpoichyzJEFwxbfHpq+g5I6z/HaJ0tmLUzFHIH+4DCSfRH1Gz07fu+0T0+MFDwJ4sEfkTc28qW+RUqdMMUrkEVHWWa4BY69C/wZ+a0BR52qFDlZRH+2kT5reW2lCJp2T3RBUE7xhMBhlpntRpkbDR0rFsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(376002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(82310400011)(46966006)(36840700001)(40470700004)(40460700003)(44832011)(40480700001)(7696005)(6666004)(478600001)(54906003)(2616005)(70206006)(70586007)(1076003)(6916009)(316002)(86362001)(47076005)(36860700001)(426003)(336012)(81166007)(82740400003)(26005)(356005)(8936002)(16526019)(8676002)(83380400001)(4326008)(36756003)(5660300002)(41300700001)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:30:18.0467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fbf78c-19de-41b7-ea16-08dbd5cb7e90
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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
Cc: Tao Zhou <tao.zhou1@amd.com>, Candice Li <candice.li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use ErrorCodeExt field to identify data parity error in replay mode.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 32 ++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 025e6aeb058d43..743d2f68b09020 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -88,6 +88,27 @@ static void umc_v12_0_reset_error_count(struct amdgpu_device *adev)
 		umc_v12_0_reset_error_count_per_channel, NULL);
 }
 
+static bool umc_v12_0_is_uncorrectable_error(uint64_t mc_umc_status)
+{
+	return ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1));
+}
+
+static bool umc_v12_0_is_correctable_error(uint64_t mc_umc_status)
+{
+	return (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1 ||
+		(REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 &&
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 0) ||
+		/* Identify data parity error in replay mode */
+		((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) == 0x5 ||
+		REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, ErrorCodeExt) == 0xb) &&
+		!(umc_v12_0_is_uncorrectable_error(mc_umc_status)))));
+}
+
 static void umc_v12_0_query_correctable_error_count(struct amdgpu_device *adev,
 						   uint64_t umc_reg_offset,
 						   unsigned long *error_count)
@@ -104,10 +125,7 @@ static void umc_v12_0_query_correctable_error_count(struct amdgpu_device *adev,
 	mc_umc_status =
 		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
 
-	if (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1 &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, CECC) == 1 ||
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UECC) == 1 &&
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 0)))
+	if (umc_v12_0_is_correctable_error(mc_umc_status))
 		*error_count += 1;
 }
 
@@ -125,11 +143,7 @@ static void umc_v12_0_query_uncorrectable_error_count(struct amdgpu_device *adev
 	mc_umc_status =
 		RREG64_PCIE_EXT((mc_umc_status_addr + umc_reg_offset) * 4);
 
-	if ((REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Val) == 1) &&
-	    (REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, Deferred) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, PCC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, UC) == 1 ||
-	    REG_GET_FIELD(mc_umc_status, MCA_UMC_UMC0_MCUMC_STATUST0, TCC) == 1))
+	if (umc_v12_0_is_uncorrectable_error(mc_umc_status))
 		*error_count += 1;
 }
 
-- 
2.25.1

