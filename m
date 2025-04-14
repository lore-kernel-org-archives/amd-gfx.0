Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CECC369A2
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Apr 2025 18:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955D610E08F;
	Mon, 14 Apr 2025 18:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WxfAd8YK";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DA310E08F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Apr 2025 18:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PAXY78b780Ib/DEFZMwQ+cuR5b833W8F7WlVs5NJ6EOTop7Qo8bipDcKEAIdfeyZHrChwcUjn3aRt7Lhlogj+UpcHzP6sJW4Jxv2Hhamz/zpgqY0josL0IbD/a8RD5Prl/jvqmUUEo7Uj6ZH63yTxJmYgd8o0W7fjG4QPzY1Kd5oCWfSW5h1EkJvqZZmfPVHikxyHPBYda/O3oYC3peGMJnzb3aA9CREu6xQIr9jOZJbL5alyG/9qpKO7xTEIAOxmOAvCxYoB96T423O0K3wADb+IcD890KABM4E2TjLjfLsUBpmmfDgzSJIH5Itusu8Ma9/xgMZsrvt8p0y5Lf44Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOERvUKl6Xw9gM1bBY4nPskof6ai9CHS0CYXQO0b+2E=;
 b=VqgHhqUKIhaREOptVjzWiBqAP2Dg7mTHQLNPgJ5Q68Dk+Ivpf+zqo03g8CEvp85KGllbLZh22CqZL0s+bGmMwUIpJap1FjmObsJsyuIDjFGJV2hlDif+XJxMyHat2Vpp8h4QEuPppUI02aTK5q+9s2i+CLXZt3BieheCZIbNfuw6IZSR7nMbs+121AMQlLBQq1RWl1kBpmO21SdrUzxIkpv98jedsLMLvAajxhIGKvV8i8/UYSOWFCCWLQFEL7ME42le6imz3DTL1qGXNiLMfCntyirTwFmwfassiydgGil+3Zb1y6Rhr2hZ5j8Ytw2AQIzIbti8kbMq5CVb4YEc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOERvUKl6Xw9gM1bBY4nPskof6ai9CHS0CYXQO0b+2E=;
 b=WxfAd8YKUll4T49NiUGS887e1vA+JmnqPBAVR20bgd+OIetkScHKxq9PlwT5bzzFTmouv27qxE/MCBIYmE2d9feOdvw+9UciN8RuOtpioUnoOBaF2186+MLONdOPf3U2tWi6JC5DyXwYxpVxKq9scZB2F18EK55nBRZ7Wkxv+Rk=
Received: from BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47) by
 CH2PR12MB4327.namprd12.prod.outlook.com (2603:10b6:610:7d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Mon, 14 Apr 2025 18:22:45 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a02:80:cafe::10) by BYAPR01CA0034.outlook.office365.com
 (2603:10b6:a02:80::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Mon,
 14 Apr 2025 18:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 18:22:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 13:22:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/userq: rework driver parameter
Date: Mon, 14 Apr 2025 14:22:29 -0400
Message-ID: <20250414182229.3043275-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|CH2PR12MB4327:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf9bba2-d3ca-42af-be64-08dd7b815a18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0MvGLrfU3cex3+CfXePVNX1NotSpAjzslojGDZhU/qm9Y33GueEYL9u0Gd5I?=
 =?us-ascii?Q?EH8ScmBu07exXZByeq8VGQjG+rjzspOdaK6i4GtnTt8k9m27IDH3B0lZrvJi?=
 =?us-ascii?Q?v88gEeP2sx0G5yY0hOlbJH3sGgpdF1b+J/u5MhcWWfpMiGeqIy7J24aOjnVw?=
 =?us-ascii?Q?29pMh9J/NILX5peQnDkhGeWOwxRvU/X5gmPj/z8ryc6I4bDmjYZU4kMihm7Y?=
 =?us-ascii?Q?BrBNoYy2jI0ClQV615h0m+fOmBo3Am5U9Dh+eh9ttWwTneBrTPOlMXmXk3lO?=
 =?us-ascii?Q?73MjxTq8znFrgTQb9REvUSwv7KJr7NX27kYkTddqYaku2v6aok+49NVKbbHW?=
 =?us-ascii?Q?sudufytKG3HBAQk9K2CxUy8enOL2VKoGZyVzewEZ25Q1kT89VtCUlr9RmmZQ?=
 =?us-ascii?Q?95nIatjRaTLwOM8LbYFIFdC2KvxtMjOJamhlIojhd0g3ApHMgHu3zVL9AzCf?=
 =?us-ascii?Q?6+yNQ1yJ9oVcA1F2XTMXZ9yzJK7ETN7a7Fx9nwIIiWG50laTdGel6u6cL5Ha?=
 =?us-ascii?Q?YqNF8B1tvyOUMD8Njgrt2aCTVX5UmIafdxlqP0rkkU37QY1TeoOszSUeypTn?=
 =?us-ascii?Q?efndLRrHhznKyiL8x1vlG5kXiQBepG+ebtDMRyIgv+Yvo8iXfLnLfiHKXWFN?=
 =?us-ascii?Q?PONtVbl2rdjP+v+V3VeOMLRKvvPuqmw40wVxeqOis04PSBuUR7hscd9Fv+1n?=
 =?us-ascii?Q?DSQ72emuCr+h7qU+4VARfPDOMT2TikjLhEgMXUHcS45BnO9vG/xFdoqyFIbn?=
 =?us-ascii?Q?3NLaSFtL7UIkkNYIhfE9wTdPoOXbiMO/11fvv33HqztCmUG9skvLRvovzNCB?=
 =?us-ascii?Q?hoRf4FgUz6OW8H9yd2WUEfUfdP9Xg5B1bCFzuhJoUZYBChwVTt4L6Wb0xgQz?=
 =?us-ascii?Q?RjOdTZZQeWKkxeT539/KbhKGoIKqnkuP6hEd9d6/fObK11LN5sRA4pErQ4Z+?=
 =?us-ascii?Q?F9eRzYo8gyM8ykmRI3ekkR6CHUFEtymy8J97PKoPekiX8Irg78vv/6c1O5EH?=
 =?us-ascii?Q?XP4/ZrpUqUWnh4OMqIYvOLCUrWPiVWUit7XueBe0ombUx6JAny6VBcWX7dB4?=
 =?us-ascii?Q?ow4RrI9Cvj61nJMQWJHyL/Z28zHYuuiU7ftv4BODIqexiYIUytT5IirSJZOw?=
 =?us-ascii?Q?DjvCkvJtZv/tqsyi3VyhKvggZY4Ci/J9zl+4wGqYiQSrdUECjvQw4tiITv5E?=
 =?us-ascii?Q?BfjgJoqjD2LOHextVib5+PeX+rz6lkoYt3hf8ue/08i4ia472sJx9e46QlsR?=
 =?us-ascii?Q?LsAxng3efJsKIWJ+U6bGTu8MEFdSw5BfsGgN1g2vZF1QXIWYGTxHNcqOHYdF?=
 =?us-ascii?Q?E4+J1YIwnREfOVFhcMKKtJzjaoS/V3ibpHUHMBzB7+1BeDUjKlvmc506q/V9?=
 =?us-ascii?Q?8+HcQI/ZN2dyV0GysRmX4HxFCRK2yVAfSBv3yYG2v4aGx6g+yW22e0WyjD4c?=
 =?us-ascii?Q?/nzAIijmWdpecxXdy171VLRV6WhwQ5btpvD6FWD0zTUBf/o4c6ZHVhWx8+JK?=
 =?us-ascii?Q?f1hsUc+cGXqr/7BynfJzW6X04AM+uzUI9Lj4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 18:22:44.7484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf9bba2-d3ca-42af-be64-08dd7b815a18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4327
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

Replace disable_kq parameter with user_queue parameter.
The parameter has the following logic:
 -1 = auto (ASIC specific default)
  0 = user queues disabled
  1 = user queues enabled and kernel queues enabled (if supported)
  2 = user queues enabled and kernel queues disabled

The default behavior (-1) is currently the same as 0 for current
ASICs.  To enable user queues (in addition to kernel queues) set
user_queue=1. To enable user queues and disable kernel queues
(to make all resources available to user queues), set user_queue=2.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 15 +++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c   | 20 +++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c   | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   | 18 ++++++++++++++++--
 8 files changed, 77 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index fd5df6394279a..41875bd735a5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -271,7 +271,7 @@ extern int amdgpu_agp;
 extern int amdgpu_rebar;
 
 extern int amdgpu_wbrf;
-extern int amdgpu_disable_kq;
+extern int amdgpu_user_queue;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a117cd95b9dcd..e24b0c730baf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -242,7 +242,7 @@ int amdgpu_wbrf = -1;
 int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
-int amdgpu_disable_kq = -1;
+int amdgpu_user_queue = -1;
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1114,12 +1114,15 @@ MODULE_PARM_DESC(rebar, "Resizable BAR (-1 = auto (default), 0 = disable, 1 = en
 module_param_named(rebar, amdgpu_rebar, int, 0444);
 
 /**
- * DOC: disable_kq (int)
- * Disable kernel queues on systems that support user queues.
- * (0 = kernel queues enabled, 1 = kernel queues disabled, -1 = auto (default setting))
+ * DOC: user_queue (int)
+ * Enable user queues on systems that support user queues.
+ * -1 = auto (ASIC specific default)
+ *  0 = user queues disabled
+ *  1 = user queues enabled and kernel queues enabled (if supported)
+ *  2 = user queues enabled and kernel queues disabled
  */
-MODULE_PARM_DESC(disable_kq, "Disable kernel queues (-1 = auto (default), 0 = enable KQ, 1 = disable KQ)");
-module_param_named(disable_kq, amdgpu_disable_kq, int, 0444);
+MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disable, 1 = enable, 2 = enable UQs and disable KQs)");
+module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 70b64bb1847c9..ed54095e6ad69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -487,6 +487,7 @@ struct amdgpu_gfx {
 	struct mutex                    workload_profile_mutex;
 
 	bool				disable_kq;
+	bool				disable_uq;
 };
 
 struct amdgpu_gfx_ras_reg_entry {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 0b1fbcf0b4d0e..e768605253074 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -132,6 +132,7 @@ struct amdgpu_sdma {
 	uint32_t 		supported_reset;
 	struct list_head	reset_callback_list;
 	bool			no_user_submission;
+	bool			disable_uq;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 40d3c05326c02..496e83cb89177 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1632,7 +1632,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 3):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (0 && !adev->gfx.disable_uq) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
@@ -1646,7 +1646,7 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 3):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (0 && !adev->gfx.disable_uq) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
@@ -5215,8 +5215,22 @@ static int gfx_v11_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (amdgpu_disable_kq == 1)
+	switch (amdgpu_user_queue) {
+	case -1:
+	case 0:
+	default:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = true;
+		break;
+	case 1:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = false;
+		break;
+	case 2:
 		adev->gfx.disable_kq = true;
+		adev->gfx.disable_uq = false;
+		break;
+	}
 
 	adev->gfx.funcs = &gfx_v11_0_gfx_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ff56368df66ea..9cfe50016dab7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1418,7 +1418,7 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(12, 0, 1):
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
-		if (0) {
+		if (0 && !adev->gfx.disable_uq) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
@@ -3823,8 +3823,22 @@ static int gfx_v12_0_early_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (amdgpu_disable_kq == 1)
+	switch (amdgpu_user_queue) {
+	case -1:
+	case 0:
+	default:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = true;
+		break;
+	case 1:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = false;
+		break;
+	case 2:
 		adev->gfx.disable_kq = true;
+		adev->gfx.disable_uq = false;
+		break;
+	}
 
 	adev->gfx.funcs = &gfx_v12_0_gfx_funcs;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index c3d53974e7f53..6bb36187a53dc 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1269,8 +1269,22 @@ static int sdma_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	if (amdgpu_disable_kq == 1)
+	switch (amdgpu_user_queue) {
+	case -1:
+	case 0:
+	default:
+		adev->sdma.no_user_submission = false;
+		adev->sdma.disable_uq = true;
+		break;
+	case 1:
+		adev->sdma.no_user_submission = false;
+		adev->sdma.disable_uq = false;
+		break;
+	case 2:
 		adev->sdma.no_user_submission = true;
+		adev->sdma.disable_uq = false;
+		break;
+	}
 
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r)
@@ -1351,7 +1365,7 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	/* add firmware version checks here */
-	if (0)
+	if (0 && !adev->sdma.disable_uq)
 		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 #endif
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index e1a6b15338506..943c6446a0a73 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1254,8 +1254,22 @@ static int sdma_v7_0_early_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	if (amdgpu_disable_kq == 1)
+	switch (amdgpu_user_queue) {
+	case -1:
+	case 0:
+	default:
+		adev->sdma.no_user_submission = false;
+		adev->sdma.disable_uq = true;
+		break;
+	case 1:
+		adev->sdma.no_user_submission = false;
+		adev->sdma.disable_uq = false;
+		break;
+	case 2:
 		adev->sdma.no_user_submission = true;
+		adev->sdma.disable_uq = false;
+		break;
+	}
 
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
 	if (r) {
@@ -1326,7 +1340,7 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	/* add firmware version checks here */
-	if (0)
+	if (0 && !adev->sdma.disable_uq)
 		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
 #endif
 
-- 
2.49.0

