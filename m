Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E4AC07E95
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 16:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449B8613D4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 16:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449B8613D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D53366E9C3;
	Fri, 16 Jul 2021 16:43:27 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C50786E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 16:43:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfk4aalRoTLNqyixa740x/OwyTwSLr6sFCOofc4v6H2BJcHPRYg3UwZb7+aldZUp+61EG+uXIMuFVaepyAzEFSZ0kjF41Y9MgcAZ4zCy0Y2p061phyV0jbV1oxumgbL4PUz4JA425h+37vpB0NvSA1M+DWFkMWhCpmwBH62Mc3JDpu/rOcuxzeVEYvj840xrXRubu6RUpYfclwud2zrOD1sLYTfsZuyf5u89PERbMmiluObvIK/m1RtMYS7t9/bq2wYHDkc0VSQ8MaL2zSRRHy2iz+F0hF7RZ61+XCiVxMATj3DRhXR6EhWIBqxiE3qdD+UaVEyGpr0or9UkjqjSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1zT3+J7j5zdRHKb0krZgOpxxYoy9p1W61CIKJ+eUWU=;
 b=DwwtKD4UtioMcLUUk07rqq8gIOVwoGMqKvwgnSbNN2xhy09ALO0hcnhtC+PuVn4VQsra5ulShSDHkoBaoBxG25xYiSTWCPvtL896e70OEdCNHxmgu5eASY9Yr80JhUEaDbNQPUBfKFapDkMONPrP+n2yJ2OFJuvtCu2Qp9hL6I7a8/Cw+8yvnSPwdb58qko8q9flyJf6LkLrbv0HAaoQlg3tDM6NnvYnVdElbN2zcO8EsIHn1LWHSEOJ5LZ6sV5QxpRyuoYgEcY2q1AwGg5uXg5coADZzHDmCI2mfQ4tz9S1pKMaOT7ofd0sz2ruqEEcMCCkLJePjqCi1XxeR5mEeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1zT3+J7j5zdRHKb0krZgOpxxYoy9p1W61CIKJ+eUWU=;
 b=QXWpiUo3Mz3f6unknTWvYMi4J6yXckJ1+otOBtJv6wVaojUL2DYPAlyH/fTomcNYT4YPUJUOrAGyIvkz7Fmw7Y5To3zZm8xjm+deI81XtCJwY5yTHu+TYIQHoTrk5wPEcXs8cd0kUzKGs0Q+tJ5yKSFBkRpcAXpn4AxzTnUodcc=
Received: from DM5PR07CA0134.namprd07.prod.outlook.com (2603:10b6:3:13e::24)
 by DM5PR12MB2535.namprd12.prod.outlook.com (2603:10b6:4:b5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19; Fri, 16 Jul
 2021 16:43:24 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13e::4) by DM5PR07CA0134.outlook.office365.com
 (2603:10b6:3:13e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 16:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 16:43:24 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 16 Jul
 2021 11:43:23 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu: add psp command to get num xgmi links between
 direct peers
Date: Fri, 16 Jul 2021 12:43:10 -0400
Message-ID: <20210716164312.896939-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 015e1450-e390-4769-28e6-08d94878d45b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2535:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2535F25289460E1400DB072D85119@DM5PR12MB2535.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /LwgZ7l/ovQCQ3UoNUNV4ajbKQyyDVWcAIHCmoh3gKHHuzP3QnPB5zTt8RM108tYQs/Z63sx4BINXLfj543Cy+uEgF2B87umkndCu5xU2v0eqVPBaSKbVski8gwxxbJwTBBJY0fW2wCX/B8Gh2QDiwru3OkV+9BXFBWUfEYo8ddkFntnRTRd4Hhe0H/+/xUIdg+K9GvB7XYyxgVoozIPlJt2EK58r/thxY0/EfHcy/u0qYtYkoYY8suGQ7u0580LiGVs5FsvxPsBAo2rg0RQlfBc4MHUiqZxID0xzTJ+O17MNINvjp2LCSBXC/g3i5mw5QFuZ5XOtKGenL+wSk4dEaWMKvnf/dGyR8n/p31PQiYKDG/mEw6XDjDWBPyYsjnOMF0wfOPZG0PdKAVkPz2yDrakMD28Ur1atRWF0xwVxLueEWr0tIxnOtzF1jjBL6ftwNGYEzV2ZzMnKMNineO07evZavo7NF+dubUpTXsz+qUXcpznG2AdhsvNfj9+QrYtKcAM57vuNkKwO/MLVo1MHh817nofbQ12lvE/dLwsgCiOBeyxxWu4a5YihOn/by/mfMs6Vw3uLwg/NZ9sm67QB8SMdiNCqmRgp9+TZ5lJ6v26VhqI9/T1X7dAw2gosx0ydCvzsGVT+3PJxiLV55+WbvlCXNnz70rUDmVmn2h0yJLkuLzz/lulix8ANplKSRiDYLzlS4eAGnnJhzWLWAB8yhtO9x/nmqLVNQ57srKU4HM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966006)(36840700001)(356005)(86362001)(82740400003)(47076005)(5660300002)(36860700001)(8936002)(6916009)(4326008)(1076003)(83380400001)(82310400003)(81166007)(44832011)(8676002)(2906002)(6666004)(336012)(316002)(478600001)(70206006)(36756003)(70586007)(2616005)(426003)(54906003)(16526019)(26005)(186003)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 16:43:24.4575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015e1450-e390-4769-28e6-08d94878d45b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2535
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The TA can now be invoked to provide the number of xgmi links connecting
a direct source and destination peer.
Non-direct peers will report zero links.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h | 14 +++++++++++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index dfb481a0780f..4d6752ec8adc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1074,6 +1074,12 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
 	return 0;
 }
 
+static bool psp_xgmi_peer_link_info_supported(struct psp_context *psp)
+{
+	return psp->adev->asic_type == CHIP_ALDEBARAN &&
+				psp->ta_xgmi_ucode_version >= 0x2000000b;
+}
+
 int psp_xgmi_get_topology_info(struct psp_context *psp,
 			       int number_devices,
 			       struct psp_xgmi_topology_info *topology)
@@ -1117,6 +1123,23 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 		topology->nodes[i].sdma_engine = topology_info_output->nodes[i].sdma_engine;
 	}
 
+	/* Invoke xgmi ta again to get the link information */
+	if (psp_xgmi_peer_link_info_supported(psp)) {
+		struct ta_xgmi_cmd_get_peer_link_info_output *link_info_output;
+
+		xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_PEER_LINKS;
+
+		ret = psp_xgmi_invoke(psp, TA_COMMAND_XGMI__GET_PEER_LINKS);
+
+		if (ret)
+			return ret;
+
+		link_info_output = &xgmi_cmd->xgmi_out_message.get_link_info;
+		for (i = 0; i < topology->num_nodes; i++)
+			topology->nodes[i].num_links =
+					link_info_output->nodes[i].num_links;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 200d19139e73..f5b967b18e3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -116,6 +116,7 @@ struct psp_xgmi_node_info {
 	uint8_t					num_hops;
 	uint8_t					is_sharing_enabled;
 	enum ta_xgmi_assigned_sdma_engine	sdma_engine;
+	uint8_t					num_links;
 };
 
 struct psp_xgmi_topology_info {
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h b/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
index ac2c27b7630c..cce7127afeaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
@@ -33,7 +33,8 @@ enum ta_command_xgmi {
 	TA_COMMAND_XGMI__GET_NODE_ID			= 0x01,
 	TA_COMMAND_XGMI__GET_HIVE_ID			= 0x02,
 	TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO		= 0x03,
-	TA_COMMAND_XGMI__SET_TOPOLOGY_INFO		= 0x04
+	TA_COMMAND_XGMI__SET_TOPOLOGY_INFO		= 0x04,
+	TA_COMMAND_XGMI__GET_PEER_LINKS			= 0x0B
 };
 
 /* XGMI related enumerations */
@@ -75,6 +76,11 @@ struct ta_xgmi_node_info {
 	enum ta_xgmi_assigned_sdma_engine	sdma_engine;
 };
 
+struct ta_xgmi_peer_link_info {
+	uint64_t				node_id;
+	uint8_t					num_links;
+};
+
 struct ta_xgmi_cmd_initialize_output {
 	uint32_t	status;
 };
@@ -97,6 +103,11 @@ struct ta_xgmi_cmd_get_topology_info_output {
 	struct ta_xgmi_node_info	nodes[TA_XGMI__MAX_CONNECTED_NODES];
 };
 
+struct ta_xgmi_cmd_get_peer_link_info_output {
+	uint32_t			num_nodes;
+	struct ta_xgmi_peer_link_info	nodes[TA_XGMI__MAX_CONNECTED_NODES];
+};
+
 struct ta_xgmi_cmd_set_topology_info_input {
 	uint32_t			num_nodes;
 	struct ta_xgmi_node_info	nodes[TA_XGMI__MAX_CONNECTED_NODES];
@@ -115,6 +126,7 @@ union ta_xgmi_cmd_output {
 	struct ta_xgmi_cmd_get_node_id_output		get_node_id;
 	struct ta_xgmi_cmd_get_hive_id_output		get_hive_id;
 	struct ta_xgmi_cmd_get_topology_info_output	get_topology_info;
+	struct ta_xgmi_cmd_get_peer_link_info_output	get_link_info;
 };
 /**********************************************************/
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
