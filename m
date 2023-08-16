Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2451FC27C42
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 21:46:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C392B10E10E;
	Wed, 16 Aug 2023 21:46:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C96610E10E
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 21:46:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTRxGWquhhJYALMaKjH+9qH2QebYGVWIkifwvhxxD9EqBBkTIujMWWTDtXk760hP0wLsnlXK6AIj2W2shKPbm0piqoFnDamNd6c9vMf+R1GcRi5FdLB9yqzSvMb4j6dsSVZuf64eVyhj+2yqOX4MXtyUMMgTOIIvJfLGHh+cu/tNWD6FVccs31J/NAZUcDiGVS6ICUJmUvcM3Ax7nKJ19tCd7IrJw0Y3k/IphVAMZpcWcdlEeWsgZR9L12dj5+zTqNNywUDO0XBhe7iZAYpoh7VC302fUP3pHQxKUQcF6p/HfHHmX+OmJPxaIjsO6p0EHX8MFPAeOnKP4uMw9EIabA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iylGs22NrIS6BkEjpHltjKtE2c6BdXh+G7zTX7o3MYg=;
 b=ZrEuJdKLP1QDv5L0smd1s+KcyK5N4lrBTfaivzdh42W/R1vnyJJpYRzC2v2WSZodYcHas4oyw9cM1DPBM0rRpR5PcaRseYZ5QnWyeqxPyhXdlrRSfOxVAmdoJU2B0dF13HV+DU5wBDhQcfTxLNwiWKt36cSETMEfg/vDs4cnpYak+nHGL6ZQh6UqubAQ9HTG87KMpwZ9baz0wmB7B2zilI6GFjLXG33uW3sRQeL0HrG2PcY1KciIo4d8flJt1n2q+UzN0crG5FUUYP91fKgr2nfOoNzKQs0rRrG9oOP/36D9zZ++1PHHRO5e7vzW0q0KC8j8ctMmeJn6STHbpOgDGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iylGs22NrIS6BkEjpHltjKtE2c6BdXh+G7zTX7o3MYg=;
 b=qjIPEfSLA9dUCsDXrcAYXm1ivQVguNTgkwzGYrDFbA2bs/ofbbW5+8IPF8Qq6k92Ine6vqbD+s1wtzbI1nKxjLy0GqmAEdUiacVvBfkEpVMRaZjIilUkMpPCIdGBp3eMYdnBJkvvYwjqTJnuQYqDc9RSNGtrZtCDZlCV0spp2E4=
Received: from SA1P222CA0085.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::28)
 by CY5PR12MB6132.namprd12.prod.outlook.com (2603:10b6:930:24::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 21:46:49 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:35e:cafe::52) by SA1P222CA0085.outlook.office365.com
 (2603:10b6:806:35e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 21:46:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 21:46:48 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 16:46:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: use 6.1.0 register offset for HDP CLK_CNTL
Date: Wed, 16 Aug 2023 17:46:35 -0400
Message-ID: <20230816214635.826323-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CY5PR12MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 915d4945-68cd-4008-2c6b-08db9ea24b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFOnwdAKdJWfw1kNShUlSbQLlOvptsYlHlnBILaFY9kt/yJjmvpw5DabAORnxPvLzhdNMNNf5XTuBSb2w5eqvJBzEvgMiq5SYPWYmDOhadEH9eHpGKbjCJzMwdNU2daKTKcOjLAcA5z3lCyKBRI3n8Wz4+6Q16oZSoWAIyuFkNhJJQFqDxUOCtRG4DNQCM6tSp7DL06RNA+1PShlQTQFbqIZTB54JnmulesoWOeNi7KOkaJCebci66KgM15SG+3xuFyOGt01wBHwc3Abl8lzMfJf/WaAPk8HMLkiLCl/XnwQwn5E+OAr5HiJAY/upg6uTvweEaDMBOy4n5QZbxcMZ9UAjnpgLlENOfpeUL+cDNvtgGMaPd7JFGE/tfr8bNt3AD6If+FL8ejAu6h1OcrYPbHdqXFAtXkdjYqAYeHMX7XAgCBL0hcMfUPOfQ7sDIVwSYZD/V/XWFcic/qG1KIDlm9QRqhyXM8rw574C/dZWX2eqBG+ShCfEMwSevEFuDdoEoYzl09/BC/0pm+0fEnEsGLWEBNFYcx4mBm3Wz+KVPnydpvbiWXkqTh9GNgqxKkgxW2pwAPeLgAXwIqu+E5Zp//Lb5IGaH4//99g+9AGCgVDzspqEDlhQD5lOXZ8rknKV9bKZJ/2HHaXanaeWLdXf61AeD9zbcmjPweZvWJ04njw3KOs5tt3NmOcwET9vw7YNnhG4/OVIpBGlgBLc96tJjrojFmjIle7OxHSauxw/DzoO67QpxvIfDKrrlRVvYOtzA8etzsTZMQvw8aJUJ1txw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(36860700001)(41300700001)(54906003)(82740400003)(356005)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 21:46:48.7540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915d4945-68cd-4008-2c6b-08db9ea24b4b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6132
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Lang Yu <Lang.Yu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Use 6.1.0 register offset and remove unused variable.

v2: clean up logic (Alex)

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index 063eba619f2f..6f20f9889a78 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -28,6 +28,9 @@
 #include "hdp/hdp_6_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+#define regHDP_CLK_CNTL_V6_1	0xd5
+#define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
+
 static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
 				struct amdgpu_ring *ring)
 {
@@ -40,7 +43,7 @@ static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
 static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
-	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
+	uint32_t hdp_clk_cntl;
 	uint32_t hdp_mem_pwr_cntl;
 
 	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
@@ -48,14 +51,20 @@ static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
 				AMD_CG_SUPPORT_HDP_SD)))
 		return;
 
-	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0,regHDP_CLK_CNTL);
+	if (adev->ip_versions[HDP_HWIP][0] == IP_VERSION(6, 1, 0))
+		hdp_clk_cntl = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL_V6_1);
+	else
+		hdp_clk_cntl = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
 	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
 
 	/* Before doing clock/power mode switch,
 	 * forced on IPH & RC clock */
 	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
 				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
-	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+	if (adev->ip_versions[HDP_HWIP][0] == IP_VERSION(6, 1, 0))
+		WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL_V6_1, hdp_clk_cntl);
+	else
+		WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
 
 	/* disable clock and power gating before any changing */
 	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
@@ -117,7 +126,10 @@ static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
 	/* disable IPH & RC clock override after clock/power mode changing */
 	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
 				     RC_MEM_CLK_SOFT_OVERRIDE, 0);
-	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+	if (adev->ip_versions[HDP_HWIP][0] == IP_VERSION(6, 1, 0))
+		WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL_V6_1, hdp_clk_cntl);
+	else
+		WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
 }
 
 static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
-- 
2.41.0

