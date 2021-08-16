Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9D7C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 18:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE0160462
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 18:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5EE0160462
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8E6B89ECD;
	Mon, 16 Aug 2021 18:05:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF9189ECD
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 18:05:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvf1NqqAAWvECz4vMKfkBxvaqdyY2k6/l3mcAqhOLGUUPGsqnZ8QbE2tF66AcagnMMKr49xihpsHmj4NL1FxO/xERhkuAPI/5YcnT4aYKGjKtiXcQK382lshXP6KXjIIGQ5KloHMAPgHQk7xY1gOk0R4P7sWVYzpjhgkF06y/fdxe6QG1GyTga63FAeZXWPbOyyUmgUrIfnuaPopT4fqmeTkfkDM8D1zAJnmj0N6RweamgwP451M/vJsU4AwcIZk32we78pVOrzkKlr/8BnJpRvdvzAcW/BJOlhOCjNnInBVr0FTkehSanxN47zKmdcAezhnDqryEt11kQj7NTI6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjmWhf6SKgVazboNnJEkjg8qGYsIuoL8wpf3r8NT604=;
 b=TGtDQDoJt5M0tz4qgyFHVJU9Um0GW/JhuvvNBVcY9aL5b6QwzotinxCtvhfI+WfsNoEQrGt7yvrk9OhUs0hliPOAOJJbhyv4eWggNtQsJroS/zMasbFroKRdU/mws7XqKru/kyzBSQJiTyEldhWTvvMT2lmmmlrHIw05xLtK/QCnr1stKRE0+3GPtZ6eTLruRAQ1gznFbLNmgpUhEG1WTy6xrF9GAc4oURh7P6p+nWMnySPzLTvfwEdV2DOvKPzj580g4Ljgi5VxPzrLS4u0vPr7nhvIT0pinwZ0SKt3K4bpsqgstunzzanDcXu6KIO+LEH+9K6aKSmyBH77R+diKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SjmWhf6SKgVazboNnJEkjg8qGYsIuoL8wpf3r8NT604=;
 b=KTIfZq4h6lsTg3M9yiLgvxMX+UhSNEKTC1cLIN+OM3a8Q/Y5vxcMz4t6TD5aINmLmXo0GDgUrm+mhqOBJbYzLjr7+M8xszFsnuNFDzr3ChWr6xRSkx+lIt0JANYdKUSbJHVGjp4B2tvifGwYWIyDE0yibDbTctxwZyJkvBxaJys=
Received: from MWHPR17CA0061.namprd17.prod.outlook.com (2603:10b6:300:93::23)
 by DM4PR12MB5055.namprd12.prod.outlook.com (2603:10b6:5:38a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Mon, 16 Aug
 2021 18:05:55 +0000
Received: from CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:93:cafe::9b) by MWHPR17CA0061.outlook.office365.com
 (2603:10b6:300:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13 via Frontend
 Transport; Mon, 16 Aug 2021 18:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT016.mail.protection.outlook.com (10.13.175.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Mon, 16 Aug 2021 18:05:55 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 16 Aug
 2021 13:05:52 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <jonathan.kim@amd.com>, Hawking Zhang <hawking.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: get extended xgmi topology data
Date: Mon, 16 Aug 2021 14:05:41 -0400
Message-ID: <20210816180541.473721-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ae772a9-5cd0-40a4-743c-08d960e07e04
X-MS-TrafficTypeDiagnostic: DM4PR12MB5055:
X-Microsoft-Antispam-PRVS: <DM4PR12MB5055D622626E99EB43E43B4E85FD9@DM4PR12MB5055.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iymk8IEcQUh3T793ITbinZ+3qswnqlKCuGqaknMHwCm5R9fUysASWWhMaySDKD8wtGwbZfLy9FdGUJupntFclN5B2/BPQvIG+lPYJ/Luk1K3pbgjZenNTETTuUM7sF1pAuhA4tkdmUKTbZo9Nml/XdoXvLEPaNuU0iC/3vDrsmQquzYEE+EiIlN1plgJb9/nUQz9jUfAVbgcZu/+wzB7A1PTMl5/fQW347zaQjfeojcM5jMmy0Wgyipjo6hJR4o9wWsl75Li5GOvO9+kEOhM8FT4R6+7UcQ8ruZJlKiR2KqZr4WyJyu08Dnpx+iznZw1bEohk58k7+N86Ld/qf35hDUUS+DhIDrpHBP+DVde3ez56fzscZj2nsaEnm26dWin2wUA6E+rra8z81pOygoL0L9y3iPfYKRjRhR007wcEavZr49E6xsVKkqHpM+Mzv+J3fmqXsNzqvj5fnFjoJzLeMg2IvcyysUIag6V4Y8grUTh7OZlCgLc/u3ba5gC3d/VXSXMpZLc+wd1RdGzgtMRE+4eJ8WRMQvrvimYz8bXoSO7mtsusy1Gi7fgxIbt6GXJHriTonOGoDah96eh2G8INvbE3cHyzquTZun89f96GAALuHc1KV3y7JEenJ2rAZ5+lcvLFhRhkQrQbmqkhUXdAbBmx2SceHvbkWYp5+J44UM0nSRDrSD7tnWVx8uUfV3aCoKbpalo4jgx9iVrgb4Jn3xl0X/FOHvMgJFhyGB8cDAI/Ci8AOjUXO+v+cPdi55i7QBZ24Br3baJbExHc/zmeA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(136003)(39860400002)(46966006)(36840700001)(6666004)(7696005)(82310400003)(8936002)(34020700004)(70206006)(70586007)(6916009)(2906002)(8676002)(186003)(4326008)(426003)(44832011)(16526019)(336012)(316002)(2616005)(54906003)(478600001)(81166007)(47076005)(5660300002)(36860700001)(82740400003)(83380400001)(1076003)(356005)(26005)(86362001)(30864003)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2021 18:05:55.1118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae772a9-5cd0-40a4-743c-08d960e07e04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5055
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

The TA has a limit to the amount of data that can be retrieved from
GET_TOPOLOGY.  For setups that exceed this limit, the xGMI topology
needs to be re-initialized and data needs to be re-fetched from the
extended link records by setting a flag in the shared command buffer.

The number of hops and the number of links must be accumulated by the
driver. Other data points are all fetched from the first request.
Because the TA has already exceeded its link record limit, it
cannot hold bidirectional information.  Otherwise the driver would
have to do more than two fetches so the driver has to reflect the
topology information in the opposite direction.

v2: squashed with internal reviewed fix

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Reviewed-by: Hawking Zhang <hawking.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 92 +++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c | 58 ++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h  |  3 +-
 4 files changed, 145 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cf40609f39d4..3cf875ef813b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_psp.h"
 #include "amdgpu_ucode.h"
+#include "amdgpu_xgmi.h"
 #include "soc15_common.h"
 #include "psp_v3_1.h"
 #include "psp_v10_0.h"
@@ -1026,7 +1027,7 @@ int psp_xgmi_terminate(struct psp_context *psp)
 	return 0;
 }
 
-int psp_xgmi_initialize(struct psp_context *psp)
+int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta)
 {
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	int ret;
@@ -1036,6 +1037,9 @@ int psp_xgmi_initialize(struct psp_context *psp)
 	    !psp->xgmi.start_addr)
 		return -ENOENT;
 
+	if (!load_ta)
+		goto invoke;
+
 	if (!psp->xgmi_context.initialized) {
 		ret = psp_xgmi_init_shared_buf(psp);
 		if (ret)
@@ -1047,9 +1051,11 @@ int psp_xgmi_initialize(struct psp_context *psp)
 	if (ret)
 		return ret;
 
+invoke:
 	/* Initialize XGMI session */
 	xgmi_cmd = (struct ta_xgmi_shared_memory *)(psp->xgmi_context.xgmi_shared_buf);
 	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
+	xgmi_cmd->flag_extend_link_record = set_extended_data;
 	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__INITIALIZE;
 
 	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
@@ -1103,9 +1109,56 @@ static bool psp_xgmi_peer_link_info_supported(struct psp_context *psp)
 				psp->xgmi.feature_version >= 0x2000000b;
 }
 
+/*
+ * Chips that support extended topology information require the driver to
+ * reflect topology information in the opposite direction.  This is
+ * because the TA has already exceeded its link record limit and if the
+ * TA holds bi-directional information, the driver would have to do
+ * multiple fetches instead of just two.
+ */
+static void psp_xgmi_reflect_topology_info(struct psp_context *psp,
+					struct psp_xgmi_node_info node_info)
+{
+	struct amdgpu_device *mirror_adev;
+	struct amdgpu_hive_info *hive;
+	uint64_t src_node_id = psp->adev->gmc.xgmi.node_id;
+	uint64_t dst_node_id = node_info.node_id;
+	uint8_t dst_num_hops = node_info.num_hops;
+	uint8_t dst_num_links = node_info.num_links;
+
+	hive = amdgpu_get_xgmi_hive(psp->adev);
+	list_for_each_entry(mirror_adev, &hive->device_list, gmc.xgmi.head) {
+		struct psp_xgmi_topology_info *mirror_top_info;
+		int j;
+
+		if (mirror_adev->gmc.xgmi.node_id != dst_node_id)
+			continue;
+
+		mirror_top_info = &mirror_adev->psp.xgmi_context.top_info;
+		for (j = 0; j < mirror_top_info->num_nodes; j++) {
+			if (mirror_top_info->nodes[j].node_id != src_node_id)
+				continue;
+
+			mirror_top_info->nodes[j].num_hops = dst_num_hops;
+			/*
+			 * prevent 0 num_links value re-reflection since reflection
+			 * criteria is based on num_hops (direct or indirect).
+			 *
+			 */
+			if (dst_num_links)
+				mirror_top_info->nodes[j].num_links = dst_num_links;
+
+			break;
+		}
+
+		break;
+	}
+}
+
 int psp_xgmi_get_topology_info(struct psp_context *psp,
 			       int number_devices,
-			       struct psp_xgmi_topology_info *topology)
+			       struct psp_xgmi_topology_info *topology,
+			       bool get_extended_data)
 {
 	struct ta_xgmi_shared_memory *xgmi_cmd;
 	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
@@ -1118,6 +1171,7 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 
 	xgmi_cmd = (struct ta_xgmi_shared_memory *)psp->xgmi_context.xgmi_shared_buf;
 	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
+	xgmi_cmd->flag_extend_link_record = get_extended_data;
 
 	/* Fill in the shared memory with topology information as input */
 	topology_info_input = &xgmi_cmd->xgmi_in_message.get_topology_info;
@@ -1140,10 +1194,19 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 	topology_info_output = &xgmi_cmd->xgmi_out_message.get_topology_info;
 	topology->num_nodes = xgmi_cmd->xgmi_out_message.get_topology_info.num_nodes;
 	for (i = 0; i < topology->num_nodes; i++) {
-		topology->nodes[i].node_id = topology_info_output->nodes[i].node_id;
-		topology->nodes[i].num_hops = topology_info_output->nodes[i].num_hops;
-		topology->nodes[i].is_sharing_enabled = topology_info_output->nodes[i].is_sharing_enabled;
-		topology->nodes[i].sdma_engine = topology_info_output->nodes[i].sdma_engine;
+		/* extended data will either be 0 or equal to non-extended data */
+		if (topology_info_output->nodes[i].num_hops)
+			topology->nodes[i].num_hops = topology_info_output->nodes[i].num_hops;
+
+		/* non-extended data gets everything here so no need to update */
+		if (!get_extended_data) {
+			topology->nodes[i].node_id = topology_info_output->nodes[i].node_id;
+			topology->nodes[i].is_sharing_enabled =
+					topology_info_output->nodes[i].is_sharing_enabled;
+			topology->nodes[i].sdma_engine =
+					topology_info_output->nodes[i].sdma_engine;
+		}
+
 	}
 
 	/* Invoke xgmi ta again to get the link information */
@@ -1158,9 +1221,18 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 			return ret;
 
 		link_info_output = &xgmi_cmd->xgmi_out_message.get_link_info;
-		for (i = 0; i < topology->num_nodes; i++)
-			topology->nodes[i].num_links =
+		for (i = 0; i < topology->num_nodes; i++) {
+			/* accumulate num_links on extended data */
+			topology->nodes[i].num_links = get_extended_data ?
+					topology->nodes[i].num_links +
+							link_info_output->nodes[i].num_links :
 					link_info_output->nodes[i].num_links;
+
+			/* reflect the topology information for bi-directionality */
+			if (psp->xgmi_context.supports_extended_data &&
+					get_extended_data && topology->nodes[i].num_hops)
+				psp_xgmi_reflect_topology_info(psp, topology->nodes[i]);
+		}
 	}
 
 	return 0;
@@ -2817,7 +2889,7 @@ static int psp_resume(void *handle)
 	}
 
 	if (adev->gmc.xgmi.num_physical_nodes > 1) {
-		ret = psp_xgmi_initialize(psp);
+		ret = psp_xgmi_initialize(psp, false, true);
 		/* Warning the XGMI seesion initialize failure
 		 * Instead of stop driver initialization
 		 */
@@ -3123,6 +3195,7 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 		adev->psp.sos.size_bytes = le32_to_cpu(sos_hdr->sos.size_bytes);
 		adev->psp.sos.start_addr = ucode_array_start_addr +
 				le32_to_cpu(sos_hdr->sos.offset_bytes);
+		adev->psp.xgmi_context.supports_extended_data = false;
 	} else {
 		/* Load alternate PSP SOS FW */
 		sos_hdr_v1_3 = (const struct psp_firmware_header_v1_3 *)adev->psp.sos_fw->data;
@@ -3137,6 +3210,7 @@ static int psp_init_sos_base_fw(struct amdgpu_device *adev)
 		adev->psp.sos.size_bytes = le32_to_cpu(sos_hdr_v1_3->sos_aux.size_bytes);
 		adev->psp.sos.start_addr = ucode_array_start_addr +
 			le32_to_cpu(sos_hdr_v1_3->sos_aux.offset_bytes);
+		adev->psp.xgmi_context.supports_extended_data = true;
 	}
 
 	if ((adev->psp.sys.size_bytes == 0) || (adev->psp.sos.size_bytes == 0)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 2cd84e21592a..2a448f6cde76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -143,6 +143,7 @@ struct psp_xgmi_context {
 	uint64_t                        xgmi_shared_mc_addr;
 	void                            *xgmi_shared_buf;
 	struct psp_xgmi_topology_info	top_info;
+	bool				supports_extended_data;
 };
 
 struct psp_ras_context {
@@ -433,14 +434,15 @@ int psp_gpu_reset(struct amdgpu_device *adev);
 int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 			uint64_t cmd_gpu_addr, int cmd_size);
 
-int psp_xgmi_initialize(struct psp_context *psp);
+int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool load_ta);
 int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
 int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id);
 int psp_xgmi_get_topology_info(struct psp_context *psp,
 			       int number_devices,
-			       struct psp_xgmi_topology_info *topology);
+			       struct psp_xgmi_topology_info *topology,
+			       bool get_extended_data);
 int psp_xgmi_set_topology_info(struct psp_context *psp,
 			       int number_devices,
 			       struct psp_xgmi_topology_info *topology);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index 2e47bc446700..dda4f0c5c4e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -498,6 +498,32 @@ int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
 	return	-EINVAL;
 }
 
+/*
+ * Devices that support extended data require the entire hive to initialize with
+ * the shared memory buffer flag set.
+ *
+ * Hive locks and conditions apply - see amdgpu_xgmi_add_device
+ */
+static int amdgpu_xgmi_initialize_hive_get_data_partition(struct amdgpu_hive_info *hive,
+							bool set_extended_data)
+{
+	struct amdgpu_device *tmp_adev;
+	int ret;
+
+	list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+		ret = psp_xgmi_initialize(&tmp_adev->psp, set_extended_data, false);
+		if (ret) {
+			dev_err(tmp_adev->dev,
+				"XGMI: Failed to initialize xgmi session for data partition %i\n",
+				set_extended_data);
+			return ret;
+		}
+
+	}
+
+	return 0;
+}
+
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 {
 	struct psp_xgmi_topology_info *top_info;
@@ -512,7 +538,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 
 	if (!adev->gmc.xgmi.pending_reset &&
 	    amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_PSP)) {
-		ret = psp_xgmi_initialize(&adev->psp);
+		ret = psp_xgmi_initialize(&adev->psp, false, true);
 		if (ret) {
 			dev_err(adev->dev,
 				"XGMI: Failed to initialize xgmi session\n");
@@ -575,7 +601,7 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 		/* get latest topology info for each device from psp */
 		list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
 			ret = psp_xgmi_get_topology_info(&tmp_adev->psp, count,
-					&tmp_adev->psp.xgmi_context.top_info);
+					&tmp_adev->psp.xgmi_context.top_info, false);
 			if (ret) {
 				dev_err(tmp_adev->dev,
 					"XGMI: Get topology failure on device %llx, hive %llx, ret %d",
@@ -585,6 +611,34 @@ int amdgpu_xgmi_add_device(struct amdgpu_device *adev)
 				goto exit_unlock;
 			}
 		}
+
+		/* get topology again for hives that support extended data */
+		if (adev->psp.xgmi_context.supports_extended_data) {
+
+			/* initialize the hive to get extended data.  */
+			ret = amdgpu_xgmi_initialize_hive_get_data_partition(hive, true);
+			if (ret)
+				goto exit_unlock;
+
+			/* get the extended data. */
+			list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgmi.head) {
+				ret = psp_xgmi_get_topology_info(&tmp_adev->psp, count,
+						&tmp_adev->psp.xgmi_context.top_info, true);
+				if (ret) {
+					dev_err(tmp_adev->dev,
+						"XGMI: Get topology for extended data failure on device %llx, hive %llx, ret %d",
+						tmp_adev->gmc.xgmi.node_id,
+						tmp_adev->gmc.xgmi.hive_id, ret);
+					goto exit_unlock;
+				}
+			}
+
+			/* initialize the hive to get non-extended data for the next round. */
+			ret = amdgpu_xgmi_initialize_hive_get_data_partition(hive, false);
+			if (ret)
+				goto exit_unlock;
+
+		}
 	}
 
 	if (!ret && !adev->gmc.xgmi.pending_reset)
diff --git a/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h b/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
index cce7127afeaa..da815a93d46e 100644
--- a/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/ta_xgmi_if.h
@@ -134,7 +134,8 @@ struct ta_xgmi_shared_memory {
 	uint32_t			cmd_id;
 	uint32_t			resp_id;
 	enum ta_xgmi_status		xgmi_status;
-	uint32_t			reserved;
+	uint8_t				flag_extend_link_record;
+	uint8_t				reserved0[3];
 	union ta_xgmi_cmd_input		xgmi_in_message;
 	union ta_xgmi_cmd_output	xgmi_out_message;
 };
-- 
2.25.1

