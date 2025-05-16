Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F1FC3ABC9
	for <amd-gfx@archiver.kernel.org>; Fri, 16 May 2025 20:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A6C110E049;
	Fri, 16 May 2025 20:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tGjIxwpG";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E26110EB9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 May 2025 20:50:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hq6F8idIYt0tYY0lstL5fKO/HWWGvVaGh881Q9lHXzjqnAIdAtk+Ggz/PXzfc7TgwhdSCGMzzft6GfU6RU/45egcE1MQ2jEcvwDdapArRunVqmBXRebJDpyRYblQRL8kqFrHcckFL6SwEnY3bNDL8sdXqB1Aa+5AhPaOdefCpm7YWaduzMOCNbxfJpVL2Z2V4MBQZmUD7jajw/CS9Tb9ufKeGxXo//spB+3zuNxXYEvfh97RVMRpjNasCx7uJMEH7o7NbYck42WUpsu3emGgqoRjT4ZB6ttH2YlS8/BA6lIkdDJoQKwd/K0/imBUS8U/jPZM0HIuuEZ7e0dkmuvW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DmbU4O2ML8BoFA91Mpg5efmlY9xzbO93T5YWHz5L3w=;
 b=icW+o2E+QtkxcStcFe4gTZK3FCJ8O/o/IGTzqq/LFhLsmEf5+e5IjsEYPrBX8Vd99bSUQZi07Z2+U8H/z8qLZrQglkCmj67GMwp8oSG7o5xFxWross6gNt07zlCwezVJLZkZfwnxAir5GPCFsu8tNeVM1C4A1x9GnorL76tgcHqyW/8/wKsTMTlc6aIJFDuHuI5wQmhXEbqmgSbNF55cz43M5RN24Z9vf4j3PqNEDq+Dp05OIxDTGToj3m+PsG3Lg8xD/9VhgEdDAJ+j8qZM62PPFBVTTFl7cFiiUxF9/kZWBgQ3la/VR9omd1C9ReBjHnlC/Lma8rykYbXHib7PwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DmbU4O2ML8BoFA91Mpg5efmlY9xzbO93T5YWHz5L3w=;
 b=tGjIxwpG6lehXbqyUYczG+xx8Z07gKfTIEufb6Qh/OVUUChpy2u5faZxLtK5uT92X2+cI8cGPCi6CmHDl/6ni43IQv+37zQ7x8jFQRrXtI157ARPzg3cC1hfXMAE030z9cuQNEj4KGZWmU/uBaoTiZyI5RUs3ATfcID8FO+mWR0=
Received: from MN0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::34)
 by CH3PR12MB9732.namprd12.prod.outlook.com (2603:10b6:610:253::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 16 May
 2025 20:50:56 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::51) by MN0P221CA0014.outlook.office365.com
 (2603:10b6:208:52a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.20 via Frontend Transport; Fri,
 16 May 2025 20:50:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8746.27 via Frontend Transport; Fri, 16 May 2025 20:50:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 15:50:55 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 16 May 2025 15:50:55 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Steven J Abner
 <pheonix.sja@att.net>
Subject: [PATCH] drm/amd/display: Add module param to limit max_bpc
Date: Fri, 16 May 2025 16:50:50 -0400
Message-ID: <20250516205050.562938-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CH3PR12MB9732:EE_
X-MS-Office365-Filtering-Correlation-Id: bb733e9f-9ccc-40ec-68a5-08dd94bb5ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IuIai6vbqB/qh1p4Xg3NDD+8MylY6zd2B73dYXxFTE1H7u18YJoZfHzjWk4y?=
 =?us-ascii?Q?nUkSS4jCSnZgiCgnEtPU+XlguYkNycVwqsIPHjsRIvLXx8jGKEX5fvmHKeUP?=
 =?us-ascii?Q?pLnsyi2xi7zeSLknm9dDmVH5Iyfu3gwqPBolbZOYwHT3ZJO7KsNl81VQuzTS?=
 =?us-ascii?Q?D854L9KFLRdtr0uwF4q7K+nr742eje4j1q9gt0YSgbXL8ve41udgmuA82O25?=
 =?us-ascii?Q?AX+szSZe/oqJl1Lr0qLnDYJe497iyMxp4wvrDUsly1eZ6cwD2qeSgmjXl3Gg?=
 =?us-ascii?Q?/zPov0c+gnlK/p4rlRSiVnrw086pRj1z7ZAOL2YQADBpxfkAgIcKr1FX6QjR?=
 =?us-ascii?Q?thhMEkanRxZTmJcoHszOnX2DWQ3leuoQhQtnepdJtwRpyiyIIkKZAJ5nRJtb?=
 =?us-ascii?Q?B6q9AaoEIcwnkppgFheh3TxLjWT6B33lt+W7KWNhzKG8NrwIKSecrGTkjwb9?=
 =?us-ascii?Q?b6kWcnoc9m2TzrMxaiZpiXLpHr+/6kseh7EFjUDTdiXKwhqlywrvRNTPmgRo?=
 =?us-ascii?Q?TdhnCzBYndYe7UYwitVmTV0xl6L2z3lt0KGHsD7rt6Unxgp4tNvYvDq5r8dl?=
 =?us-ascii?Q?ZAe3HRG/IhsPqvUf4R4nmgRms/BK1l5znASXdZNB2qkxu0G8bkEzBG9boG2O?=
 =?us-ascii?Q?pId/u7GTaPvEkhfa5DdAJPnUwxYBlP88xXAVe/Jb8HvbABgcg2+EvrRpys5s?=
 =?us-ascii?Q?R82VWQVQeIgFPtNb9BB67urMIcC2k15wsiDge745yPUzLRvAAywb+vcem1B/?=
 =?us-ascii?Q?HHh1e4P4hawFN4P5fjl0T8itxjEjN+QBFPuTzffPWZxrkyhPEKzkl1B/ydpb?=
 =?us-ascii?Q?2xaN9X1p6A64eQNv99ynxBqIAEa8W0T2t5SmXLWd1X1x8BeRy5n3/JLnrnzk?=
 =?us-ascii?Q?SHYtOZn8JY1TQdqgMOibR8v7J4zTYSzIBQsvgKkITJg4igGgvOq5TiGZMQ77?=
 =?us-ascii?Q?1MeOnyCcg9gSsmU2G//RpJH/skFA6IndbDjTDUetAqUQxELeqgm6LldE4NAB?=
 =?us-ascii?Q?Ldtl8uJ1pj6/7XqKnHcYdd+q4SqWF0t142dtaUlynMf8ujqc9gBtiqcC62j/?=
 =?us-ascii?Q?oS81CtH5DbHNdMS7lvY7fnXMscsYUG8MFrYpHn62mAgZoZ2fKkDDmz2ryG2j?=
 =?us-ascii?Q?E0W6BRfMA/uS4wXoE8eVHMh8y2ITeaTlbDDqgfUrjlHYXOI1Ux9j9YBHLzxH?=
 =?us-ascii?Q?Z0oYQx9FhayZrrUh05iJkZBpt6p/nzFwb7KDSf5m82M2L0TLS1vslOOftPCS?=
 =?us-ascii?Q?PJziSnGzD2qSUcvrRkeIy3eVKXH2LkhcyWz33SxAGWWbr2sHHXtn9r9SihT+?=
 =?us-ascii?Q?Q+ZwFAxJRyfRiZpCrLa8TKeDlptBotTlk/NQBrt3opV7JQgnuLcdYt96kdT8?=
 =?us-ascii?Q?lboPief+PdqA3a6IR7RHRCuWzNFiFeWU0NoLfBc4Ld7ybRLHghck79GjzGzr?=
 =?us-ascii?Q?09Ux4/QYSNw5qd+9ViSNv4kPF2atzHJECDf8JUI1vVALX7kUsEJ4ef6wIcZM?=
 =?us-ascii?Q?vxWzvFvYY9OtYkCQZYYiLr55Kzu5i8pk+rPO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 20:50:55.7860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb733e9f-9ccc-40ec-68a5-08dd94bb5ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9732
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

Some users are reporting issues with displays not
lighting up after we made 16 bpc the default maximum
for outputs. It's difficult to debug these issues
when we can't repro them, but it'd be good to give
people the ability to help themselves.

Introduce a new amdgpu.max_bpc module param that
can be set to 8, 10, 12, 14, or 16 so users with
problematic configurations can force the output
bitdepth to a value that works for them.

Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Cc: Steven J Abner <pheonix.sja@att.net>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 15 +++++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 836ea081088a..35d877dabf9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -272,6 +272,7 @@ extern int amdgpu_rebar;
 
 extern int amdgpu_wbrf;
 extern int amdgpu_user_queue;
+extern int amdgpu_max_connector_bpc;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 4ddd08ce8885..06a889b8216f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -244,6 +244,7 @@ int amdgpu_damage_clips = -1; /* auto */
 int amdgpu_umsch_mm_fwlog;
 int amdgpu_rebar = -1; /* auto */
 int amdgpu_user_queue = -1;
+int amdgpu_max_connector_bpc = -1; /* auto */
 
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_CORE",
@@ -1126,6 +1127,20 @@ module_param_named(rebar, amdgpu_rebar, int, 0444);
 MODULE_PARM_DESC(user_queue, "Enable user queues (-1 = auto (default), 0 = disable, 1 = enable, 2 = enable UQs and disable KQs)");
 module_param_named(user_queue, amdgpu_user_queue, int, 0444);
 
+/**
+ * DOC: max_bpc (int)
+ * Set the maximum connector bit-depth in bits per colors. Possible values:
+ *
+ * - -1 = auto (ASIC specific default)
+ * -  8 = 8 bpc
+ * -  10 = 10 bpc
+ * -  12 = 12 bpc
+ * -  14 = 14 bpc
+ * -  16 = 16 bpc
+ */
+MODULE_PARM_DESC(max_bpc, "Set maximum connector bpc (-1 = auto (default), 8 = 8 bpc, 10 = 10 bpc, 12 = 12 bpc, 14 = 14 bpc, 16 = 16 bpc)");
+module_param_named(max_bpc, amdgpu_max_connector_bpc, int, 0444);
+
 /* These devices are not supported by amdgpu.
  * They are supported by the mach64, r128, radeon drivers
  */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 4b4e9241619f..4d928984c2cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8393,7 +8393,16 @@ void amdgpu_dm_connector_init_helper(struct amdgpu_display_manager *dm,
 	if (!aconnector->mst_root)
 		drm_connector_attach_max_bpc_property(&aconnector->base, 8, 16);
 
-	aconnector->base.state->max_bpc = 16;
+	if (amdgpu_max_connector_bpc != 8 &&
+	    amdgpu_max_connector_bpc != 10 &&
+	    amdgpu_max_connector_bpc != 12 &&
+	    amdgpu_max_connector_bpc != 14 &&
+	    amdgpu_max_connector_bpc != 16) {
+		drm_err(&adev->ddev, "max_bpc connector override of %d is incorrect. Needs to be 8, 10, 12, 14, or 16\n", amdgpu_max_connector_bpc);
+		amdgpu_max_connector_bpc = -1;
+	}
+
+	aconnector->base.state->max_bpc = amdgpu_max_connector_bpc == -1 ? 16 : amdgpu_max_connector_bpc;
 	aconnector->base.state->max_requested_bpc = aconnector->base.state->max_bpc;
 
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
-- 
2.49.0

