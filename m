Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0499C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Nov 2021 07:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A1D6F390;
	Tue, 30 Nov 2021 07:43:37 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2055.outbound.protection.outlook.com [40.107.212.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F33186EF31
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Nov 2021 07:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oYhRgKaijE9qT7mNZYtYOJOEbh/kECAYCPtNn4hAv4isIbEmHljDJIJlz79573kMsv8yTB2pNvUuAPcQwqV8zwnIF2Sb70hvhqM6XEbEUe9NOx1HpNS6lJtql3/Jk6CFNUttGKCG6c490QC07NGuJ2us5GV1/v5885IPcax/LaU5tse6cbDnemwQif+HLATvGIEc0+4DkpfP1Kbyz6/ZS4RKV7dJNNQAYLEx3ViCgiRDLodo+5uK5jAqjSS7CyRRj0nJc8qYuwWtDOxIo2uyhT2RgoWeRHKQE7e8osqbK7/NbSLvi4dAYrzbAt2gRF2tguz1rH2m9Xurq3die59MGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmCfcwkdJMH+nxVdauyDF8Y1uXknhcIwjiPF+Ot5oh0=;
 b=ZTYGY4dPaW40KzyQWLNICPM0r/GibslcBk35tmPLR+A6jF0Me8hFBVT8f6IyYkD6ErDullGi6mYCNJjf/JPa45VbR3BpO/nVwTHXEOk+00ormFe7shc1+EJj1xgV4R5gP21xBUl1iX3mFjhdZrxabmBCiexjBN3WO68krpz7ZExfr++mwEGnim/7KGJl/SmvBShW+MAL4jDqY8qkCyhw84tNnTWgHE84rRdkQr/r6QWLzzwH3dFfV7Zy6dui7naAjexB69+YXtOOymIiG1zGTk1K8mGRO/0hAnrzEPetME2/xvviefE7H4x3eE89J27eeTGzcMzZzs4iiojMUBVSTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmCfcwkdJMH+nxVdauyDF8Y1uXknhcIwjiPF+Ot5oh0=;
 b=zQJWlTLiaP7hvsMvYNBizWHVcm53bRbnwEeIaaac/Itej9GV5Aq9cq226H6ZIpTVmtZtspGg4ZCAk1v7C32PHYTPd0cSXS91PQK1LClrSg+H69e1gEY+ZelS9hPnZvNlfQkTSRnLv5GDEa5r1TZtat1ifBsvSdCmN+rZYfNFOuI=
Received: from BN9PR03CA0172.namprd03.prod.outlook.com (2603:10b6:408:f4::27)
 by MN2PR12MB4639.namprd12.prod.outlook.com (2603:10b6:208:a4::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 07:43:31 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::cf) by BN9PR03CA0172.outlook.office365.com
 (2603:10b6:408:f4::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 07:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4734.22 via Frontend Transport; Tue, 30 Nov 2021 07:43:32 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 30 Nov
 2021 01:43:29 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V2 04/17] drm/amd/pm: do not expose those APIs used internally
 only in amdgpu_dpm.c
Date: Tue, 30 Nov 2021 15:42:46 +0800
Message-ID: <20211130074259.1271965-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211130074259.1271965-1-evan.quan@amd.com>
References: <20211130074259.1271965-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae3ed129-2b0f-48d4-aaae-08d9b3d51bcc
X-MS-TrafficTypeDiagnostic: MN2PR12MB4639:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4639CD6871306A529CAC00EAE4679@MN2PR12MB4639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4gbRrqlRqnMFFjq/I/EDzgVtrhbqKdoQiwSdj98tZsAKjRz3bIbOHUiwLOIKCDXd2oZ8loznaVLM7bxgOg+9SNOH84v/QdGr9s9ldmPgrmzjsD+o2oeEoPR4lBqtkka4hn0xhDPn9D0Co9Yd4Od6lXqxJk23Mj5Bh/GtIfVgd/LaWKrgl5/RcaueurxB3Nyv8rVakWvkJYsJgxiNH9DySf7JzAka8r3kmzQ8lbdfC3sREx1OZhTAUvRt2H3OirI9tUumFvqAdA01Ft8t4cge442Py6vickaKKnG9H+ZRWXFOF4zQ0JMZObKmD0cn1t03E7zgPT/7zwqKi8Df31JAhWM4G/ZqcoB3IIZnrRNPU7Voc8WbaHH+bAznzk6bBjJYLxpNPCS/SKDVp2Q2Vq0cqvDtSqcrQelrdlveyQ5b2sDOxDMUi6OBQibyRlKATJJLjs/tbEdwYI+UADXhG1+n8IKa1y+fQXNtfNfCEZwBqLwrJlu9Eky66VUve48R5HTaT3i0fEX2qtBS+3+U7oqNQ+wEwOtcK6OYuMG2YXNx01dN030aSoL0JbBrfHEwfVVy3kAvs/xy7Ypyvu0Iqdrm91e51Ea3v/11wWLOSn8sM/Dl+IPztaTw8yDG4mzJ5T+H+aQespzq67A5qVEiY24lP4ibkcL2RjFOTFC13gf2Ufrn/BQ2r/36j6VZQ0V4Lp3u1Sz/dZkcPsEH8KDMxIPA5jSD8vaAJCtklVRlbrqMIZJ4/Dh0QDGSNZZmx8sYC5/OH9obAWHJZnnO+AYktuAx+lpNgR5YYgIteYlqLPo2qL8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(316002)(8936002)(86362001)(81166007)(26005)(8676002)(36756003)(4326008)(7696005)(40460700001)(1076003)(2906002)(356005)(16526019)(83380400001)(186003)(6666004)(70586007)(336012)(47076005)(426003)(36860700001)(5660300002)(508600001)(82310400004)(70206006)(2616005)(54906003)(44832011)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 07:43:32.5009 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3ed129-2b0f-48d4-aaae-08d9b3d51bcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4639
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, Kenneth.Feng@amd.com,
 christian.koenig@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move them to amdgpu_dpm.c instead.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I59fe0efcb47c18ec7254f3624db7a2eb78d91b8c
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 25 +++++++++++++++++++++++--
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h | 23 -----------------------
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 4aa5cca66048..52ac3c883a6e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -34,6 +34,27 @@
 
 #define WIDTH_4K 3840
 
+#define amdgpu_dpm_pre_set_power_state(adev) \
+		((adev)->powerplay.pp_funcs->pre_set_power_state((adev)->powerplay.pp_handle))
+
+#define amdgpu_dpm_post_set_power_state(adev) \
+		((adev)->powerplay.pp_funcs->post_set_power_state((adev)->powerplay.pp_handle))
+
+#define amdgpu_dpm_display_configuration_changed(adev) \
+		((adev)->powerplay.pp_funcs->display_configuration_changed((adev)->powerplay.pp_handle))
+
+#define amdgpu_dpm_print_power_state(adev, ps) \
+		((adev)->powerplay.pp_funcs->print_power_state((adev)->powerplay.pp_handle, (ps)))
+
+#define amdgpu_dpm_vblank_too_short(adev) \
+		((adev)->powerplay.pp_funcs->vblank_too_short((adev)->powerplay.pp_handle))
+
+#define amdgpu_dpm_enable_bapm(adev, e) \
+		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
+
+#define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
+		((adev)->powerplay.pp_funcs->check_state_equal((adev)->powerplay.pp_handle, (cps), (rps), (equal)))
+
 void amdgpu_dpm_print_class_info(u32 class, u32 class2)
 {
 	const char *s;
@@ -120,7 +141,7 @@ void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
 	pr_cont("\n");
 }
 
-void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
+static void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev)
 {
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct drm_crtc *crtc;
@@ -168,7 +189,7 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev)
 	return vblank_time_us;
 }
 
-u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
+static u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
 {
 	struct drm_device *dev = adev_to_drm(adev);
 	struct drm_crtc *crtc;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index fea203a79cb4..6681b878e75f 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -259,27 +259,6 @@ enum amdgpu_pcie_gen {
 	AMDGPU_PCIE_GEN_INVALID = 0xffff
 };
 
-#define amdgpu_dpm_pre_set_power_state(adev) \
-		((adev)->powerplay.pp_funcs->pre_set_power_state((adev)->powerplay.pp_handle))
-
-#define amdgpu_dpm_post_set_power_state(adev) \
-		((adev)->powerplay.pp_funcs->post_set_power_state((adev)->powerplay.pp_handle))
-
-#define amdgpu_dpm_display_configuration_changed(adev) \
-		((adev)->powerplay.pp_funcs->display_configuration_changed((adev)->powerplay.pp_handle))
-
-#define amdgpu_dpm_print_power_state(adev, ps) \
-		((adev)->powerplay.pp_funcs->print_power_state((adev)->powerplay.pp_handle, (ps)))
-
-#define amdgpu_dpm_vblank_too_short(adev) \
-		((adev)->powerplay.pp_funcs->vblank_too_short((adev)->powerplay.pp_handle))
-
-#define amdgpu_dpm_enable_bapm(adev, e) \
-		((adev)->powerplay.pp_funcs->enable_bapm((adev)->powerplay.pp_handle, (e)))
-
-#define amdgpu_dpm_check_state_equal(adev, cps, rps, equal) \
-		((adev)->powerplay.pp_funcs->check_state_equal((adev)->powerplay.pp_handle, (cps), (rps), (equal)))
-
 #define amdgpu_dpm_reset_power_profile_state(adev, request) \
 		((adev)->powerplay.pp_funcs->reset_power_profile_state(\
 			(adev)->powerplay.pp_handle, request))
@@ -412,8 +391,6 @@ void amdgpu_dpm_print_cap_info(u32 caps);
 void amdgpu_dpm_print_ps_status(struct amdgpu_device *adev,
 				struct amdgpu_ps *rps);
 u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
-u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
-void amdgpu_dpm_get_active_displays(struct amdgpu_device *adev);
 int amdgpu_dpm_read_sensor(struct amdgpu_device *adev, enum amd_pp_sensors sensor,
 			   void *data, uint32_t *size);
 
-- 
2.29.0

