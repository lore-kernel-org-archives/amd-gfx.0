Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B37C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Dec 2021 03:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C7210ECFC;
	Mon, 13 Dec 2021 03:52:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903F510ECF9
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Dec 2021 03:52:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdWUwhVC7cLS4OiAy53aU2MIViRWdLOt/6/BKeUZamfYJ7dNuMyueH53diBYFaV5VdQ7WZPYvG4l6f+kA8CLclja81aYizwecwvK68tgwWo0GD289SOANZMCQZ88eUqS5yT0GK96rPKbQcTZObYKaKVGtFfvWKy4z9W8NisNJ19hbWvQCydrSejFQc6Lsd+vNnAWktnhXOQPZ8WJh8zsntm/4OGh9wxOyrbaz8msf/WnsuYCGjWTC3/dv2h3QEvvEhHwKSlbPHtrJYTs7Pr6bjiBrLrkblzoOnIAbQ0iLCkTT5UlpRzMpEKcpUsTpqv9JlDOJ2wEE3e+Cce1LSvJRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPv5DOXHlkcBa4CkR3c3d7oQ6y9PZH6z2PskEdCYm1o=;
 b=FuYM/V6zxc/qK4eM9y785hoV+MwYgjbM6ypC1lO5mZrlzXBSHXeuamYS2vD4fL3skZ9OYUBoBDPWcbe7Te1Uvk7yWWgQU8ZuHPgu17uQ9+GLC0ZZ8ZsAGTa0STRaW1Q5bG3m9bw9ZHQXyiZbVZfJeMfUF/HHnzGZtIWBDCXHrKZZnOtsg++XIyldAahj3tQPMNcwmoz3Bmzb8PD95SKZBYbae/vXFIeauTfidQE7F3aqaZjcS7NeMWnJcFbVchvdHxnUgMY6bJL9HUKUgY4e8cA5VGK8V8Llf+CpKFHiswS7053hrZAfOmX0uD3vHROmUrntmbu0cNJV7kzkPAebWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPv5DOXHlkcBa4CkR3c3d7oQ6y9PZH6z2PskEdCYm1o=;
 b=X+yk/D/TWir/J5d85f6U+STtdDNRMbuP28ldvU2QrPtJIuIVgiWfOZQN7CQEHOlSfisQDLMTL3tcHfN7DNHNR6wcQCs5Q3QtbZQPHqq7CpqdjHe/cyczxjNW3ioMJsl+egJNSsLt93YgLf4RizRJcLCliKSzfT3rtXcos/wUQHU=
Received: from DM6PR06CA0087.namprd06.prod.outlook.com (2603:10b6:5:336::20)
 by BN6PR12MB1492.namprd12.prod.outlook.com (2603:10b6:405:11::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Mon, 13 Dec
 2021 03:52:49 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::f4) by DM6PR06CA0087.outlook.office365.com
 (2603:10b6:5:336::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Mon, 13 Dec 2021 03:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Mon, 13 Dec 2021 03:52:49 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 21:52:47 -0600
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V5 04/16] drm/amd/pm: do not expose those APIs used internally
 only in amdgpu_dpm.c
Date: Mon, 13 Dec 2021 11:52:11 +0800
Message-ID: <20211213035223.772700-5-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211213035223.772700-1-evan.quan@amd.com>
References: <20211213035223.772700-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61410dd-05e2-4ebf-a9a1-08d9bdec0835
X-MS-TrafficTypeDiagnostic: BN6PR12MB1492:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB149201FA5BF5829989EEEC5EE4749@BN6PR12MB1492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:418;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4TS9/Bz2pNYIJCOc0tiWmq7QO6wHqZRsVA4BOHAlzTywlORkaaI2lh10d90h9y63QOtKLfWuoBxCDxIRfIrrdOLyoSav9u/wyHSN9H4puMIeGRJzqEXu2vSgVvBYATvnXY3APrP6DvzDELgszarSyVrdrcvox08seDAvslXp7R8gVUFiU4qj1CzXvX9O3mGHdAykO1E90zCgiPTQFmljA+VssmF51qB4jAbeowmfHj+rEoZuyW/S4pbz8urQaFdWl82CY2J6VgjL7D0RcrhKM01TJZwK6IFAC70AhM9rfrsRLMqMHwsbs6hVHHjN6NvewBWFUXzTkqgsyEdLjolFCeVuTZJS7L7Jy81OzxXhOTnFV47UvHtN0Szz3LhOFbxEE1ON71r9xCHJnSUv+BqqPEQaiIVucEYMmyXTk1BI7tyRDLqgESBUKT8dL8+LKFztbEkDUlFsOrCjln7NzOLlcPyBsyASbOpz7qPqP6gKQtv1j3OpmTqX0HJUIU8JkkoN93t9mg5zbj2E3sSEXoTLJr3utSIw7tj2r5mdOPVPro2zECwcQeUY4eKvMASvAlO8dqYBlHGNRFepIuo/LWDUT2ArZdkSBlDXFCPalf8Dom2QwN3kGfs+trlYaCCHJcOO6WksioZ1pJHtMdG+cJbBLlqf0ohvguYYp0AHjvIuNbJ7SL7/svfyHIHePHBRM2Z+sji7CKPQ25mUWxgYQ6IwhbP0ofp3uQqCjQhf+BhREd8GxcMHRVA8DLwWuo3GNhbrRZPPCrA4EAqHtfW6fcBD1Hin+2B7rgBxW1kmd3RPV0U=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700001)(356005)(40460700001)(54906003)(6666004)(82310400004)(81166007)(47076005)(36756003)(83380400001)(44832011)(7696005)(4326008)(8676002)(8936002)(86362001)(2616005)(16526019)(70586007)(336012)(1076003)(186003)(6916009)(70206006)(2906002)(316002)(426003)(36860700001)(508600001)(26005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 03:52:49.6520 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61410dd-05e2-4ebf-a9a1-08d9bdec0835
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1492
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
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com,
 Evan Quan <evan.quan@amd.com>
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
index a805202ce1ad..08770888cabb 100644
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

