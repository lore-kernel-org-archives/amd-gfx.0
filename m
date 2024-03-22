Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9EAC47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 16:33:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B02961125E0;
	Fri, 22 Mar 2024 16:33:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BpFOUS4z";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39231125E0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 16:33:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URdZ4vnbhvLGEOLVtgC6Jd3qdVw4AjIFcQoQhAtTkcEoxL25QSy2nr1zi1uvhCmXDXcAA+VdGCMoSO9R2rjDVXBL4HkKPgcdcNXmfVzKbukGR0p7aNBdi4a44Lw2ST4PSnFmz3dH4VoQDejntPGrgIGO4DkpcVnS5fHYH1Wz9KbKeBkCwLjaIVeZE+KgNvmYqlU15cLWwiikK2RWf5y6i4sDRIqIDAm8JTJ0oZE50slJcJy8xCniXky5cN6fn2KdIYgWmwqydlw0444k5kvK4QSpDAVZfqYvXYjbdNU0AY6Z5uCF9SZ3z7zuwaGF3ItT8bELUfVknsOHrKk65Sdp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ttuQ3xTg7CmPmKC25+VY93a6MUFRPaJQe0nGqzb0DY=;
 b=LPLg/QIIIBOlATnM0PjUey2i09nHfFdTTrlaZa3/zxjJ7/W4nwq447wXBs27h2iaVZbgJ8VB9fmXTXvJgpQv5PtqTl2+NrPM0CI7W/WugSEeoW4i3rpiqDfwCxkcBypyPOLBLkNgFUkJ42LwV5iYS22jl1gc9jVcowQBU6Ozxwo7U/tZu6kNvRsC2WBBOrTs0GTlbgb+1f7Fl7kG+lCAJ4hQU3CKEBqB0V1DfKKzJM8iC+6+GS6t+4AisCZAQ1fpE76ftPULeMENajWqRBfOVE4eLdJZgZKisWN+wKQiM1bZvcngUhJajfKcAK5EXioKRf8sNPehK/qdhbpHD+iVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ttuQ3xTg7CmPmKC25+VY93a6MUFRPaJQe0nGqzb0DY=;
 b=BpFOUS4zL2sOlDPRuJP3VPyNNOrDnr5vxtu/E5DeVqIIldI9Kqwoh3KUT860MWkAFsQI4FFZ68IavAnMOZXSlPt6NhFxb3FF/4i7UvFJX2miUdWYNBvLPdzfeQE7HZyLkophfL0WoCxEd4coQg7nBrqHQ+6cF4TtIXNphfKQ4+Y=
Received: from DS0PR17CA0022.namprd17.prod.outlook.com (2603:10b6:8:191::21)
 by DM4PR12MB5772.namprd12.prod.outlook.com (2603:10b6:8:63::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Fri, 22 Mar
 2024 16:33:17 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::c6) by DS0PR17CA0022.outlook.office365.com
 (2603:10b6:8:191::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 16:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 16:33:17 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 11:33:16 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log feature
Date: Fri, 22 Mar 2024 12:33:04 -0400
Message-ID: <20240322163304.86840-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|DM4PR12MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbd2dd9-1484-489b-a57c-08dc4a8dc749
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9N0FpGIQGk2/p8lVQJegsC6gvAz5hUcB1d+k3393leneXMaRnkFkAYtTIyPzvHEGlZxdfXqOKFWqTL5ylatcWJYtsNnGB8cd16rI8rnQEPkUD9nBprai2l03R5wpczdj4zIrBrwTieeIqTlS2txDLHEK/lESJ7ZI9PwmMx+ctIXO1prPs78FvBY6f538Svf7ZDtM9z6APEiD0KKOZFBir3ZMK7AMHjXs/QblayE7yebY/mL9nILzudA6kY8wHuBzaRZGlvGbuJyIfJRHIdtqPmIXt5mJNaWWYDx4hBOPRg/BGOozLlkVWRkEn6eX8p9oOWqq+sX6fvSpfVOkg/zOh/WNug0vOdIGk5x7jLLZzs7JYouubNc4lKziXlqlp2oJ7rlBgKl8YMyxIMTSgeRFE4WPo6d9knsNZFQTBto4Grpm712DYekgSRkYG9FuTguKR6eKwcc+Xkmfph5OCcYW/OX+RdR9IAxDTxE5cWKbf4Bs+nCh+nF8NxozbPPfd/2Xj5Y3hP4nF/9xSD6bnhvoVVOx74QyDNriV8RaiBJCQDBmtl8yGeWaBmiookFxoXai+lp0RMoJjg8ssnMAYH1Mp36+DZ1XoLQouMr61yOW389WtLpD1R1CrRthUWnUhJhlPE4OdWINGfOJgMGrtEwDQTU+VNN2aDT0egBgaMML9DS+V1VLgy20lkJhGbkngc6jO/9Mi2np6TY48OBumvdoKfAjykn3s2kztUO4muSl/SxyoFfvEDwpB/G+Tz76qjt1K6H3u4xriU+Q41pkWWF9Hg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014)(43062008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 16:33:17.3323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbd2dd9-1484-489b-a57c-08dc4a8dc749
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5772
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The MES log might slow down the performance for extra step of log the data,
disable it by default and introduce a parameter can enable it when necessary

Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  7 +++++--
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80b9642f2bc4..7584f1ea469e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -195,6 +195,7 @@ int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp = -1;
 int amdgpu_discovery = -1;
 int amdgpu_mes;
+int amdgpu_mes_log_enable = 0;
 int amdgpu_mes_kiq;
 int amdgpu_noretry = -1;
 int amdgpu_force_asic_type = -1;
@@ -667,6 +668,15 @@ MODULE_PARM_DESC(mes,
 	"Enable Micro Engine Scheduler (0 = disabled (default), 1 = enabled)");
 module_param_named(mes, amdgpu_mes, int, 0444);
 
+/**
+ * DOC: mes_log_enable (int)
+ * Enable Micro Engine Scheduler log. This is used to enable/disable MES internal log.
+ * (0 = disabled (default), 1 = enabled)
+ */
+MODULE_PARM_DESC(mes_log_enable,
+	"Enable Micro Engine Scheduler log (0 = disabled (default), 1 = enabled)");
+module_param_named(mes, amdgpu_mes_log_enable, int, 0444);
+
 /**
  * DOC: mes_kiq (int)
  * Enable Micro Engine Scheduler KIQ. This is a new engine pipe for kiq.
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 78dfd027dc99..9ace848e174c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -100,6 +100,9 @@ static int amdgpu_mes_event_log_init(struct amdgpu_device *adev)
 {
 	int r;
 
+	if (!amdgpu_mes_log_enable)
+		return 0;
+
 	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
 				    AMDGPU_GEM_DOMAIN_GTT,
 				    &adev->mes.event_log_gpu_obj,
@@ -1561,7 +1564,7 @@ void amdgpu_debugfs_mes_event_log_init(struct amdgpu_device *adev)
 #if defined(CONFIG_DEBUG_FS)
 	struct drm_minor *minor = adev_to_drm(adev)->primary;
 	struct dentry *root = minor->debugfs_root;
-	if (adev->enable_mes)
+	if (adev->enable_mes && amdgpu_mes_log_enable)
 		debugfs_create_file("amdgpu_mes_event_log", 0444, root,
 				    adev, &amdgpu_debugfs_mes_event_log_fops);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 072c478665ad..63f281a9984d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -411,8 +411,11 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
 	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
 	mes_set_hw_res_pkt.oversubscription_timer = 50;
-	mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
-	mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr;
+	if (amdgpu_mes_log_enable) {
+		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
+		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr =
+					mes->event_log_gpu_addr;
+	}
 
 	return mes_v11_0_submit_pkt_and_poll_completion(mes,
 			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
-- 
2.34.1

