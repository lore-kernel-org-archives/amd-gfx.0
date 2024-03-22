Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DABEC47DD9
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Mar 2024 18:00:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C66B61126B4;
	Fri, 22 Mar 2024 18:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E4/xpoFR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE161126B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Mar 2024 18:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcFNVwFCNqm8Vr3k8vHjk943QTvbjWfalyh5IjGLdZ16yvrqGaKKeh+1cMY4utRCCUjbsOiXr6eMblcYDGCr5W9NOw+9WB7ZuO/WxxrGmZF6WGdoI823CGNTJzdrfSaikohtR6qKg0OXKwXH/zVPCHVaxB0eog1thr3pPVOsNvfkI1et2Y3mZkovLO9dGZ2m+3p8GEbFBbWIF64pBEuy206J0dEdPmoSMtSTBfOG98MaNBNnZxllUdZ+FbXFTEFeHyBv7cT0CTpmJ9RuGi1avW+F458upgEkckF7Bu9QM67Gl1pRk8+B/LEQVCgGAiWlDlBUOFAH2OJ4suu9iSOIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kfoVYmAeUpEFzMrhg/bjNxp420MtRH5D6NsaVBbQ6U=;
 b=hd28//dJa0zty4ed8ganFoct3zOKLkLCB1xjGw1sfcJAECD8ds4PJbSyiO5JUQ4XdTn+gWMElR3cQoSpFRz186yT61YvcWZ7NNRW+LcjtHak0jxqpLyNQLN6OHYZvP5iKnBIqfn8w8D4jUHUcf853GFIJg76Cv8TPuchP/RcVq7WABLwo0/2E4j2bOhjyYNeDuXRbl71lsuul5KGkx6dy57UNr5hLvOJ3fS8wpbcg9kYWM0sO6IKkODMFoKQFQI7vdL/Fw78G3qcLn+0SPatVt0fUaNsj5RD5aN0qpgU8mpzgRvUDRa8k2nc7aC82vsEzEwiMw8ZGlobqQfVmqvG2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kfoVYmAeUpEFzMrhg/bjNxp420MtRH5D6NsaVBbQ6U=;
 b=E4/xpoFRX5Hz6q0dreApsbTS/mmI508NI4oq5wwzJu5bxolr3LygFMmmrvyLVgUGf1KGvCGzCJTA24ndedLC7Lk3nX7A1CUhBHodF1SypYn1FEkmMGU7PbIucZ4D/xCNMoYembBU+/jQJeVsf0CKJ6H632evPLnc831JLsEgcxU=
Received: from CH0PR03CA0427.namprd03.prod.outlook.com (2603:10b6:610:10e::30)
 by DM4PR12MB6398.namprd12.prod.outlook.com (2603:10b6:8:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 18:00:35 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::c3) by CH0PR03CA0427.outlook.office365.com
 (2603:10b6:610:10e::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Fri, 22 Mar 2024 18:00:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 18:00:35 +0000
Received: from shaoyunl-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 13:00:33 -0500
From: shaoyunl <shaoyun.liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: shaoyunl <shaoyun.liu@amd.com>
Subject: [PATCH] drm/amdgpu : Add mes_log_enable to control mes log feature
Date: Fri, 22 Mar 2024 14:00:21 -0400
Message-ID: <20240322180021.391680-1-shaoyun.liu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DM4PR12MB6398:EE_
X-MS-Office365-Filtering-Correlation-Id: ad858173-8126-4328-25c9-08dc4a99f94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUywD1PClU/S2GKVFkSp4B6uq6YYw/dryhG1GznQblWTpqVXXi0OyPww84A4/9diUGLyB+2Oqcnzr3DRa6dj0MiUMAlG6eFJASrktTKlO8eItAM5MoBZ7wCWpyYdCT65HY73bNfbCGce9/wfZ4qrYCb1Agd8tQbQoOXODSdXyTq9dwcKDMOGcJ9MyP4ide3i4eUO9NpabTc+31X/MWqP/zuDtq9PhLBAFZDwGkQsCnYs+WvFO4Sq/OR/ooZ/1vFHFljCRA0rP0wlGwtqmBY73ZyYA8FHdxN3TeHAdtRpBknZps9BfMVlPU31Zrp/qijlAFwasUGEim6gWNPTKfrKN4xqRPbTqZ8o38xYKdIyERoFS7Ke0aaIsElCYOBQoGzr/0+trJkL7CSsrziRpmjJwdOTKU5+3LVTaR5VFx0iK8MgOl2ArJJ2yMJfpgRPRoqvHti3Mqe8fO8iL0XleaSRdZJXM/iopIDYsqDkW0nadNTj15eKuyrMdE0NTvbMmqWL8AySqwwtch2VqDemfKZKKaL57bWGyWJJL4a+FfhwjEQmcnEVX1yk2gNrmzai88O8CmKgA33w2BWfhzrbu8lBKJ7NcMLEeAVgV/wRBMkHp0h4jwhnldzwv4SRGJTlbF1jOQwPCb+K8jgLHbQ880Z+vjOeML9Y5z2OLIaxbRGp2DNiNPM/dwfABYceZ3BBr8IedF6NgwmrxWKqpX4tb18IGQCwDwuazc72G4iLPOuxRKzgsVqJv1x0Wak3XLe1RZvnIvaYq+H4/vQHsacFAm5ilA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400014)(43062008);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 18:00:35.0419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad858173-8126-4328-25c9-08dc4a99f94a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6398
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
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |  7 +++++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9c62552bec34..b3b84647207e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -210,6 +210,7 @@ extern int amdgpu_async_gfx_ring;
 extern int amdgpu_mcbp;
 extern int amdgpu_discovery;
 extern int amdgpu_mes;
+extern int amdgpu_mes_log_enable;
 extern int amdgpu_mes_kiq;
 extern int amdgpu_noretry;
 extern int amdgpu_force_asic_type;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 80b9642f2bc4..e4277298cf1a 100644
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
+module_param_named(mes_log_enable, amdgpu_mes_log_enable, int, 0444);
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

