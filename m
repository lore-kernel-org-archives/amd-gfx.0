Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778E3C001DF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 15:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9B310E5C6;
	Fri, 20 Oct 2023 15:12:05 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E41510E5C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 15:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMM36IjuLhT7DcD9nRJq4av3C/C7VYbsUg30uABqRJzMAM6xBtKa9Ybhc1bqw90pEOg6+bYD9hc6LhTbCxPLLEAV4QgVOQpxgJg/Cpm1CSZPMFDumn7CMSMSqGTI1ubzUGgDw9sT6sqK85VMX2q2aF0T63vP0SOBlvACYvrDz4e90UeShdtNinQ7pRKY1o0dFyh2bxigGKDeW/twn/xfeUEmAFmS0Hmdh2MPBFcqzPPdpOHUIfpDD9SuXuFWzwzDy3uSUyukfSy/P8RMETaFWnowPZzZtTX7c2NnTZakqY5ui8eCojWBo7uYXjIMnsN8e9zL6QOfknCfY9D5EUMQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WHoRVYZ8vTZrMA0cDKZiu7doFAxatLhhZiI3NbLPgI=;
 b=aDHK7APTK4R5db/Y7zoWB4DbdO+MYx7A2CaSNMAArPsV+FUJexjsgAvEeCvFQn4EomeMUobNiccyLInlJrkipHWaGebr2CTXJX1P00FFdVPgVoqcutUfE+eV6AQkj+hq/kHwMQhrms4CIfHy0zwIsIhQLJDpqVpUR29Xwaq/ErOwCc6PMggQGKkO1K/vmLNSy0dAHhPakuVSRoc3tPNVJ9g1fkD1ZHGcLOUhDDCJPbpV1UF3yhXj/JEuc8lcR8gBpwQyuzhI7JJ28Dv/U25pASEMjfKn7ajNoV/kzKjZhmbz5rUh8CjOmfG9+QHfmQoxZgk6LPhB0Sx9dP3ZiqEBwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WHoRVYZ8vTZrMA0cDKZiu7doFAxatLhhZiI3NbLPgI=;
 b=gyr7O6BO1k/UHUDGQUimY40PZAgHRDqzkUP46ySVRwcKKN7Zwbawp1gBLayvsZm8zM2I0gnfhOp8DHxtorQqPBdSTEj39AL0mJsc1IjalEEM2GR3xEaoDAvw5XY/GUf4XwF9LLuutaqh6HzE9LBnyfWqdSPpFSYrkS//COua3AI=
Received: from MN2PR22CA0003.namprd22.prod.outlook.com (2603:10b6:208:238::8)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Fri, 20 Oct
 2023 15:12:00 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::72) by MN2PR22CA0003.outlook.office365.com
 (2603:10b6:208:238::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 15:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 15:12:00 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 10:11:59 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: update the xgmi ta interface header
Date: Fri, 20 Oct 2023 23:11:41 +0800
Message-ID: <20231020151143.19186-1-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a944336-98dc-47b7-9169-08dbd17ee8d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BAJdeZtb3Gk8VYff2v7XwkA/4pKwDAL7wVFKW0IIG0fzHv3JofoM6KJ+VakPcgHw66uqYqLDxtdbfVt9rsyJidkNMCA+MNmAjNMeB0LV/VRrdpBA5KrWtGq+g7+3CU0m1rhKuLyoQmRMn78/GGY4CAodaTtcqCYVFI/fN1BAotQT3hm+BjXOD4CtYszQHwnNjp6IVp14Mod8hO9uRF4o2x9d9zF6bSR4LRZkiDbCujbPAE0wE54HgV3RzGpP0tBPt98enCDQvpcKLl9uEC+a2cXysGtigiTU5iY5h/fo47cB8qnl0WmxswdEhBc7TqmksDS+QDj2vX58WHWTVBqtjzwxVx5DfDhXWxG35kbC9nwE9WFGk71lLFwtfaOajkoE7Pckb0f60antGS0UM6TiQgm+IgpV3GGDHqCALqUGsb1qjVMN9m4oi/PlWl5zkULKCjNFnFnxe0ozNpGDMYeiDlwCrdLkOMMvVuuk5qRgy/TI/+N/PvvFKBhvdA06qu0uk1rQgf9cFVeRn5gq2JlUiCuaNI8d0DJjTdUksMn2VmIXd/b7eNM/nHMbEUWpveszXdrx+3K61yNMpUd/qAkZ24pjDJ97OOrVs6KEhE9231/rlfCZBf4LZ0f6yI5TsxLlzOOac9+1puXxjyYRA7LxDQNyZp7YtMoc6dyIZLniNdNG/mM7qNF1rJYu22blAPNSJyYQ5j2nOMIr6NLk076hswBkc/HxZEuVvhWCjHy4XbB+4g0BOxAS3pCX4T2DdUNh/2gexEnalO+bg7D5xHfjjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799009)(36840700001)(40470700004)(46966006)(336012)(70586007)(26005)(478600001)(70206006)(6916009)(6666004)(1076003)(426003)(81166007)(316002)(8676002)(2906002)(8936002)(36756003)(41300700001)(44832011)(15650500001)(5660300002)(356005)(82740400003)(36860700001)(16526019)(83380400001)(2616005)(47076005)(86362001)(7696005)(66899024)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:12:00.4721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a944336-98dc-47b7-9169-08dbd17ee8d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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

Update the header file to the v20.00.00.13

v1: rename TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO to
TA_COMMAND_XGMI__GET_TOPOLOGY_INFO

And also rename struct ta_xgmi_cmd_get_peer_link_info_output to
ta_xgmi_cmd_get_peer_link_info accordingly

v2: add structs to support xgmi GET_EXTEND_PEER_LINK command

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  6 +--
 drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h | 62 +++++++++++++++++++------
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7158d478eeea..0c7900f0d906 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1388,7 +1388,7 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 
 	/* Fill in the shared memory with topology information as input */
 	topology_info_input = &xgmi_cmd->xgmi_in_message.get_topology_info;
-	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO;
+	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_TOPOLOGY_INFO;
 	topology_info_input->num_nodes = number_devices;
 
 	for (i = 0; i < topology_info_input->num_nodes; i++) {
@@ -1399,7 +1399,7 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 	}
 
 	/* Invoke xgmi ta to get the topology information */
-	ret = psp_xgmi_invoke(psp, TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO);
+	ret = psp_xgmi_invoke(psp, TA_COMMAND_XGMI__GET_TOPOLOGY_INFO);
 	if (ret)
 		return ret;
 
@@ -1424,7 +1424,7 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 
 	/* Invoke xgmi ta again to get the link information */
 	if (psp_xgmi_peer_link_info_supported(psp)) {
-		struct ta_xgmi_cmd_get_peer_link_info_output *link_info_output;
+		struct ta_xgmi_cmd_get_peer_link_info *link_info_output;
 		bool requires_reflection =
 			(psp->xgmi_context.supports_extended_data &&
 			 get_extended_data) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h b/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
index da815a93d46e..d5748032674e 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2018-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-
 #ifndef _TA_XGMI_IF_H
 #define _TA_XGMI_IF_H
 
@@ -28,20 +27,31 @@
 #define RSP_ID_MASK (1U << 31)
 #define RSP_ID(cmdId) (((uint32_t)(cmdId)) | RSP_ID_MASK)
 
+#define EXTEND_PEER_LINK_INFO_CMD_FLAG 1
+
 enum ta_command_xgmi {
+	/* Initialize the Context and Session Topology */
 	TA_COMMAND_XGMI__INITIALIZE			= 0x00,
+	/* Gets the current GPU's node ID */
 	TA_COMMAND_XGMI__GET_NODE_ID			= 0x01,
+	/* Gets the current GPU's hive ID */
 	TA_COMMAND_XGMI__GET_HIVE_ID			= 0x02,
-	TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO		= 0x03,
+	/* Gets the Peer's topology Information */
+	TA_COMMAND_XGMI__GET_TOPOLOGY_INFO		= 0x03,
+	/* Sets the Peer's topology Information */
 	TA_COMMAND_XGMI__SET_TOPOLOGY_INFO		= 0x04,
-	TA_COMMAND_XGMI__GET_PEER_LINKS			= 0x0B
+	/* Gets the total links between adjacent peer dies in hive */
+	TA_COMMAND_XGMI__GET_PEER_LINKS			= 0x0B,
+	/* Gets the total links and connected port numbers between adjacent peer dies in hive */
+	TA_COMMAND_XGMI__GET_EXTEND_PEER_LINKS		= 0x0C
 };
 
 /* XGMI related enumerations */
 /**********************************************************/;
-enum ta_xgmi_connected_nodes {
-	TA_XGMI__MAX_CONNECTED_NODES			= 64
-};
+enum { TA_XGMI__MAX_CONNECTED_NODES = 64 };
+enum { TA_XGMI__MAX_INTERNAL_STATE = 32 };
+enum { TA_XGMI__MAX_INTERNAL_STATE_BUFFER = 128 };
+enum { TA_XGMI__MAX_PORT_NUM = 8 };
 
 enum ta_xgmi_status {
 	TA_XGMI_STATUS__SUCCESS				= 0x00,
@@ -81,6 +91,18 @@ struct ta_xgmi_peer_link_info {
 	uint8_t					num_links;
 };
 
+struct xgmi_connected_port_num {
+	uint8_t		dst_xgmi_port_num;
+	uint8_t		src_xgmi_port_num;
+};
+
+/* support both the port num and num_links */
+struct ta_xgmi_extend_peer_link_info {
+	uint64_t				node_id;
+	uint8_t					num_links;
+	struct xgmi_connected_port_num		port_num[TA_XGMI__MAX_PORT_NUM];
+};
+
 struct ta_xgmi_cmd_initialize_output {
 	uint32_t	status;
 };
@@ -103,16 +125,21 @@ struct ta_xgmi_cmd_get_topology_info_output {
 	struct ta_xgmi_node_info	nodes[TA_XGMI__MAX_CONNECTED_NODES];
 };
 
-struct ta_xgmi_cmd_get_peer_link_info_output {
+struct ta_xgmi_cmd_set_topology_info_input {
 	uint32_t			num_nodes;
-	struct ta_xgmi_peer_link_info	nodes[TA_XGMI__MAX_CONNECTED_NODES];
+	struct ta_xgmi_node_info	nodes[TA_XGMI__MAX_CONNECTED_NODES];
 };
 
-struct ta_xgmi_cmd_set_topology_info_input {
+/* support XGMI TA w/ and w/o port_num both so two similar structs defined */
+struct ta_xgmi_cmd_get_peer_link_info {
 	uint32_t			num_nodes;
-	struct ta_xgmi_node_info	nodes[TA_XGMI__MAX_CONNECTED_NODES];
+	struct ta_xgmi_peer_link_info	nodes[TA_XGMI__MAX_CONNECTED_NODES];
 };
 
+struct ta_xgmi_cmd_get_extend_peer_link_info {
+	uint32_t				num_nodes;
+	struct ta_xgmi_extend_peer_link_info nodes[TA_XGMI__MAX_CONNECTED_NODES];
+};
 /**********************************************************/
 /* Common input structure for XGMI callbacks */
 union ta_xgmi_cmd_input {
@@ -126,16 +153,23 @@ union ta_xgmi_cmd_output {
 	struct ta_xgmi_cmd_get_node_id_output		get_node_id;
 	struct ta_xgmi_cmd_get_hive_id_output		get_hive_id;
 	struct ta_xgmi_cmd_get_topology_info_output	get_topology_info;
-	struct ta_xgmi_cmd_get_peer_link_info_output	get_link_info;
+	struct ta_xgmi_cmd_get_peer_link_info		get_link_info;
+	struct ta_xgmi_cmd_get_extend_peer_link_info	get_extend_link_info;
 };
-/**********************************************************/
 
 struct ta_xgmi_shared_memory {
 	uint32_t			cmd_id;
 	uint32_t			resp_id;
 	enum ta_xgmi_status		xgmi_status;
+
+	/* if the number of xgmi link record is more than 128, driver will set the
+	 * flag 0 to get the first 128 of the link records and will set to 1, to get
+	 * the second set
+	 */
 	uint8_t				flag_extend_link_record;
-	uint8_t				reserved0[3];
+	/* bit0: port_num info support flag for GET_EXTEND_PEER_LINKS commmand */
+	uint8_t				caps_flag;
+	uint8_t				reserved[2];
 	union ta_xgmi_cmd_input		xgmi_in_message;
 	union ta_xgmi_cmd_output	xgmi_out_message;
 };
-- 
2.17.1

