Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EAE0C79FA1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 06:46:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE98710F4E8;
	Fri, 11 Sep 2026 06:46:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0X9Dw6WQ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A087110F4E8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 06:46:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MM3L114HZYO8pd6Poq8zQsxlzreZOU+PGPu7w1unhPxwsp6Wu7fbSlnSnjBE4yjKOHwaiuok6Q3wSO7CHH7vBhQOQDFt8FubB19CgQuOZKHH0LgZnsVTtoZhYaO6mX1KAB0D5qycrql+Rnsu7V3dY5gp6pzZsM1RaL6ZPDuPgehpkFZqko26/zv2PrDT36BU6JAGK7iKu0b0jbvPXuH2mWr0Bh2Vx33rKfoQW+eTt5QDk5y2KqfUdY0kUP+0w8b4h0kOKCeqptC8s9HvQYj5Zx5KCCDCf2kZHPH1q0Gg6vwChzQKcsk9tcDHYK2xN0tZQtZq5aIMNFEYkJISAcNhpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKMBAYHq1qvYXwfQoc5hCGeKg6M3LsTcK9Cm6erV7Mc=;
 b=IadCA1t4SzvtDQuW9lUvQvRcDby0pCtWlYpUE4VRv5RX7aBxfUl12XShcyFfHA3FytN+UFvERbVhPNb1xPNxOrEpIaWIEdnBCJ/xnboU/kGUK4VzjeBdZ6TOLFsl9ovBsANGtTtCFDV/Z+4ZMW3K4cSbd6Zkf396CDYfQ8/su3FDtD3FT73MhdGR8DJ/dM+1GyfapvJ98nKu6lusL9aJhA5OlZBXiqfT8KI4bQTecA8XCfyBKqdb0G16kyBMk/4vm7AwWEACsXa7SWTCyo+8LmDfxFzlt4L/AXI1ycXyUm0vaQ70euCWtOLjDaKVfKW4PLOszhLh8loZWxGOLQNudA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKMBAYHq1qvYXwfQoc5hCGeKg6M3LsTcK9Cm6erV7Mc=;
 b=0X9Dw6WQSmN0d7EUAz2clwmcbdScf1R7N0A8NBDRTUXbAzGYQ/ZV9KhUTK0f/7Ah7GMPLeu7Cv5Y65ti91zMJs1fF5zsJhUHdo/E4DlcGGFNmka7K5HqQ6E6kdSWTP9LySCOXoGdCjB9lZj4fP3WH7QRHNC95x0eEMCLxvlUVsw=
Received: from CH0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:610:32::22)
 by MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Fri, 11 Sep
 2026 06:46:09 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::a3) by CH0PR07CA0017.outlook.office365.com
 (2603:10b6:610:32::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 06:46:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 06:46:08 +0000
Received: from amd-03.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 01:46:06 -0500
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <Stanley.Yang@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>
Subject: [PATCH 4/6] drm/amd/ras: add MP1 RAS feature status query
Date: Fri, 11 Sep 2026 14:44:08 +0800
Message-ID: <20260911064410.1693567-4-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
References: <20260911064410.1693567-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: b8131543-a751-462c-4b28-08df0fd05c72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|10067099003|56012099006|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: 8t6Auba423ED2IjBF54HxvW5phSwAHnS/GoXSTIHWeq+wcVP/tzF/hxaVRHaNO88KRiZplLB6e+dYyvZtRSfh74j713Ko7JksP+P2Qc4tONQtT1f5LphDUzaLZ4I7l3yQLcksMDRhyLrVSM1tJc85SKxVfUiZ4GPrpWhVFyfk8Nefw75HZrqp0fUgsyNnP3vEgW6Krk/8waqhjTK5KwHj1rbHyGRuegBbwqjojsHoe4B7i3TQsi0ZVFYLrxsGK/cvt3bn/8AC7tkTIQ9EoQLyJOkNTCa1kqpbwBA6K6r02aWtV70PbXEnqN34IrosnVvv6hZ7fXm12YLMZn99S8mXGvMg4sFtT8TgRD8vLWJJSBm3P4AWb/bun1X9pdXaF37IUC+Te1tpez/DR4g9XWJ1QOtbnR8iGGZTXC/WPD5IPbAlRhspU2KL9mZkbWL2FHYkzRXUJMsI6UnDzIgcR5XukJAhI5B2Nr0RNEib11ZEVnUvECWFSJ9+ROuZiPAaN3PuQlDs+U6sJBdozQdnz5to/sDjDSuFOrAsdqB54AJUqpHIy6sDIbZ9yV/7ajA4Y9euKBYumB9tzUgOdsKFeC0Rd6cDD8gbqXH8ah7y3wG7s8ZtvaK4xWUjzoBAj0aIDZmBVEaA8MuhoQHpNzI8SZemd0KiYzUViPVTHXXbkaXTby2TbB9E7gxqHl+LPt16NEaD2msBE/GSgwx30NwaNsFCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kgbzsHq2YyLc9g0PnodB5Oto471y8dQV+d2/tD4WidTMV8EjAnx3vPDaRUXRU9WKxIf4dxe9/3MLGhbxfaswWi6WT7h8vbH6UvdguxKuScVWVoOusEF9ZTgS6sOIfsrVQ0ueoGnDqZ0EIYZhvCbgxFelXBsOhKNApdD6B4c8xZTzaRQvSTMyFtCjTqosimlRTzbqwDFo9JFJEwtrQuerSJEVY8wwmj5/mLmJt751tKou5sqC8GU6E630evS/t1nZI2EGXOsuojb4t4RTi1zNvYY1f2b58emyR5KfVUTfqWDJMSCjcS08CDrDogZkNFhb20JGjSixhacTMN1Z6V/pnVbfv6hJQlxHJLmakmpTIYJBz1u8jeqku/g3bSqeFO8aSiFPEGCIU6lG3rxYUivN19RDBaduN6uFCyhW3/IlKyWr3iMvTYPGBg5jRsOsz5sX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:46:08.7957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8131543-a751-462c-4b28-08df0fd05c72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077
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

Add a generic MP1 interface to query the status of RAS-related
SMU features, including the PMFW EEPROM feature.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
---
 drivers/gpu/drm/amd/ras/core/ras.h            |  2 ++
 drivers/gpu/drm/amd/ras/core/ras_mp1.c        | 13 +++++++++
 drivers/gpu/drm/amd/ras/core/ras_mp1.h        |  7 +++++
 .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c  | 28 +++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index fcea457d5cbe..47fa30f94a2a 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -216,6 +216,8 @@ struct ras_mp1_sys_func {
 	int (*mp1_set_debug_mode)(struct ras_core_context *ras_core, bool enable);
 	int (*mp1_send_ras_msg)(struct ras_core_context *ras_core, u32 msg_id,
 		u32 *params, u32 num_params, u32 *read_args, u32 num_read_args);
+	int (*check_ras_feature_status)(struct ras_core_context *ras_core,
+		enum ras_mp1_feature_id feature_id, u32 *status);
 };
 
 struct ras_eeprom_param_config {
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.c b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
index 0f5140abb6a8..4c180027850f 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.c
@@ -183,6 +183,19 @@ int ras_mp1_set_debug_mode(struct ras_core_context *ras_core, bool enable)
 	return mp1->ip_func->set_debug_mode(ras_core, enable);
 }
 
+int ras_mp1_check_feature_status(struct ras_core_context *ras_core,
+		enum ras_mp1_feature_id feature_id, u32 *status)
+{
+	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
+
+	if (!mp1->sys_func ||
+	    !mp1->sys_func->check_ras_feature_status)
+		return -EOPNOTSUPP;
+
+	return mp1->sys_func->check_ras_feature_status(ras_core,
+				feature_id, status);
+}
+
 int ras_mp1_sw_init(struct ras_core_context *ras_core)
 {
 	struct ras_mp1 *mp1 = &ras_core->ras_mp1;
diff --git a/drivers/gpu/drm/amd/ras/core/ras_mp1.h b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
index 410530fb8ada..b872fc975866 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_mp1.h
+++ b/drivers/gpu/drm/amd/ras/core/ras_mp1.h
@@ -28,6 +28,11 @@
 #define MAX_UE_BANKS_PER_QUERY  12
 #define MAX_CE_BANKS_PER_QUERY  12
 
+enum ras_mp1_feature_id {
+	RAS_MP1_FEATURE_PMFW_EEPROM,
+	RAS_MP1_FEATURE_MAX
+};
+
 enum ras_mp1_msg_id {
 	RAS_MP1_MSG_QueryValidMcaCount,
 	RAS_MP1_MSG_McaBankDumpDW,
@@ -122,4 +127,6 @@ int ras_mp1_reset_ras_table(struct ras_core_context *ras_core,
 int ras_mp1_get_record_count(struct ras_core_context *ras_core, u32 *count);
 int ras_mp1_get_record(struct ras_core_context *ras_core,
 		u32 idx, struct eeprom_err_record *rec);
+int ras_mp1_check_feature_status(struct ras_core_context *ras_core,
+		enum ras_mp1_feature_id feature_id, u32 *status);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
index eb7ffa354541..d8a446d0179e 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1.c
@@ -25,6 +25,10 @@
 #include "amdgpu_reset.h"
 #include "ras.h"
 
+static const enum smu_feature_mask ras_smu_feature_masks[RAS_MP1_FEATURE_MAX] = {
+	[RAS_MP1_FEATURE_PMFW_EEPROM] = SMU_FEATURE_HROM_EN_BIT,
+};
+
 static const enum smu_message_type ras_smu_msg_maps[RAS_MP1_MSG_MAX] = {
 	[RAS_MP1_MSG_QueryValidMcaCount] = SMU_MSG_QueryValidMcaCount,
 	[RAS_MP1_MSG_McaBankDumpDW] = SMU_MSG_McaBankDumpDW,
@@ -49,6 +53,29 @@ static enum smu_message_type
 	return ras_smu_msg_maps[msg_id];
 }
 
+static int amdgpu_ras_check_ras_feature_status(struct ras_core_context *ras_core,
+		enum ras_mp1_feature_id feature_id, u32 *status)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)ras_core->dev;
+	u32 res = 0;
+
+	if (!status || (feature_id >= RAS_MP1_FEATURE_MAX))
+		return -EINVAL;
+
+	if (down_read_trylock(&adev->reset_domain->sem)) {
+		if (amdgpu_smu_ras_feature_is_enabled(adev,
+				ras_smu_feature_masks[feature_id]))
+			res = 1;
+		up_read(&adev->reset_domain->sem);
+	} else {
+		return -RAS_CORE_GPU_IN_MODE1_RESET;
+	}
+
+	*status = res;
+
+	return 0;
+}
+
 static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core, u32 msg_id,
 		u32 *params, u32 num_params, u32 *read_args, u32 num_read_args)
 {
@@ -73,4 +100,5 @@ static int amdgpu_ras_send_mp1_msg(struct ras_core_context *ras_core, u32 msg_id
 
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func = {
 	.mp1_send_ras_msg = amdgpu_ras_send_mp1_msg,
+	.check_ras_feature_status = amdgpu_ras_check_ras_feature_status,
 };
-- 
2.43.0

