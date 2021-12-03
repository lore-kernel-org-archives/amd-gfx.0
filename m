Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2147C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Dec 2021 03:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 186176EB7F;
	Fri,  3 Dec 2021 03:06:12 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2055.outbound.protection.outlook.com [40.107.102.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFEDA6EB75
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Dec 2021 03:06:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chZrs8UL2daGh8g01vE79cL5GsflwEDQDn0Tzx0++gD85N/bZ9K2977vEEsECQoL7RbC9flIvTkKEQQRUmcBY8auywf5evY2hCpLYmKZb58LnpvaQRjyYjRn7R/fVOXNDAbXmVddNjnwt5balpdQoYgBXuOmgYy7gMggWJOd3E0cl/VRrMMRYHDO/t55lPYbCk4NqmM8l9R1Fe2AccTBNQwUAK/Onc2ByPQ3CCekRlSmNkpzg6wfBoDAR7yQ4acvv/OShUuudivhOVu2rYMn2qrUsBWZ8kAa4ZET6NTgZJrXV4zs7eQD/o0jCmXSrLEliPJFxtdf7HNFp+F22nIquQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKtCbjbHJ8rXVRkhZUTtAFVYh5BFFIh7Gm+LSRS/T/k=;
 b=QULb5lU7wjwH+S9Qy4T+8Y1Bk3XheaP4OFYfNLNkMj9YyhyQYLTYiMg0FuICHZO7lq9Wnsp/65/Iw2D2V+mMJpqPmUqLL9uV/ObWLD1ghhkONPuikdk854wQ3WP/gj7tmSnDMZtwFcwJD5dCzmRrdDOTuqvHXooIbt+s50Mxz7HlqSuWZ74TjNsnynyRDKsUZELAHls4wxm1RAa+rrqWVBdY4OhwKzaQlVIGpkD8qvuJFVCOV+nkX+JZABm41dvkRcZxwnA2s5ZCAK2t0RJVzPoAi5LVuGc3oRsxxstfkQjwlxZTNFsHLqxFjnbkzKGotOvqlx0UxRI9+h/yw2ceLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKtCbjbHJ8rXVRkhZUTtAFVYh5BFFIh7Gm+LSRS/T/k=;
 b=nHiWDsCdhPJjFetEgN98L7XCxjNqgYZfq3mbWvAy+6RYPNyRxOeKWIY74qX620y1b3ghkz+DUJ1Y/Fc1/II9JFNgdgEDpihNXVKjnOjzSKd/WXe2dfn/UJYOUlfwJbImutCo14HG+U1Eq67ROuTe15oBZCp7sKWq6YTYcgEAiOI=
Received: from MWHPR19CA0069.namprd19.prod.outlook.com (2603:10b6:300:94::31)
 by MWHPR12MB1885.namprd12.prod.outlook.com (2603:10b6:300:114::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 3 Dec
 2021 03:06:08 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:94:cafe::f3) by MWHPR19CA0069.outlook.office365.com
 (2603:10b6:300:94::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24 via Frontend
 Transport; Fri, 3 Dec 2021 03:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:06:07 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 21:06:05 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V4 04/17] drm/amd/pm: do not expose those APIs used internally
 only in amdgpu_dpm.c
Date: Fri, 3 Dec 2021 11:05:27 +0800
Message-ID: <20211203030540.1710564-4-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211203030540.1710564-1-evan.quan@amd.com>
References: <20211203030540.1710564-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96b541d0-9880-4955-4585-08d9b609da24
X-MS-TrafficTypeDiagnostic: MWHPR12MB1885:
X-Microsoft-Antispam-PRVS: <MWHPR12MB18853320AF1C270BCFBD3CB7E46A9@MWHPR12MB1885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4HL7QvrpYWurDTl/1K9+5U6Qhw7t/YffQIQWmVWfFyUHBCU8HK8SHc6VZJJreWfd//FZYmXQbWc59k2q3OgaZh/Jx47HNclN2C36W88kONYo092WTVaZEO7lqh5iRljCEK2JFNKOITZhEk8q1aVJnxhYtkEl6qDbuTCzS97X/fC1BckN9g7eDhjbpuOTDpdhc20pAlFBLPqpta0Mn422FB6sED0BRqoZk2peCwSvWoBdotxkNsoCkeoQXNUn3vD1oiNYju+nn2cgPl9Rr2dhPzZkjMWDU83xn2SU+LSqQMDczqjPN9hvrTHHibt/9qrDjYxNV7fIj+2Yse3Q8Zwi4GMx4ZdBMvLsVkRDuiqDFNc12p08Gk4gdxvHyhUSVYPKzymuwmbyc0OoOS8xslIyEHWxbNAmPyiY4mdN4vY4hZO3S5xOSE1K4vzs94SabDbClOMpjMmJKTc7sIZRPk98sdfQCZPEwVHgy2Q8ITpD7VZAXCkxy36OTr14/faw/rkk3ozx9ecDqtkD3zjpGLEFTn/6vEmEHY5idKh2SgIsqBBAdrAhAkWZg+PA80UllAdnUXKoQFwax/qp8sDqTxeCNnxuziV4l4aNOPtviio9y1O52UtRbvrYahcigKfBoGwHPlNeE3bx52JP64LCudAgraHcY+/adsvJMcPP2hFoptoRkr662DlcN0v3uD++s/+Ov0q3g4/0KkWdwyIwNQ+uV2llgTG0qz2D1gwh59J0ddfM7oNQJrG94nbU3AskqZdWT1HDhRUdHeSdPfqHVRkKNZs/QxYJX1IxIkyulPd5es=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700001)(336012)(70586007)(83380400001)(7696005)(47076005)(5660300002)(508600001)(6916009)(70206006)(36860700001)(16526019)(2906002)(2616005)(316002)(186003)(4326008)(81166007)(8676002)(426003)(26005)(36756003)(8936002)(82310400004)(86362001)(1076003)(356005)(54906003)(44832011)(40460700001)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:06:07.8688 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b541d0-9880-4955-4585-08d9b609da24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1885
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
index 3a84c3995f2d..72a8cb70d36b 100644
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

