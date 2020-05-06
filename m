Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27BEC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C260206E6
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 06:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="EnAfYiSl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C260206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EE5B89C27;
	Wed,  6 May 2020 06:39:33 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E51A689C27
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 06:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLU1zDuPt3FkYj6DW+VB0LCI9Xw/wUo3cRYK1KwnIjwxuMiSayDsumoLzc9bMvf8YAWftYExHRfbE3yJfUo8iox9JcvRQWIzSTOzYeQ82DLB81FAFD62tlZUjGEk8tDQrQPWLR27bItNEKvHAzZSB7qwgdAjN+7Ue/w8q8B4U8MYhzuS3HMtPd3/uGnL8mw2L9+CFpOwg3Yepbeb87NarIyU+Ep1ap4R1nHCIpffBwEWgCiKS9Vd9GOqf8WhcRVblUt3grLoddk/5BDlXd9XBpXPWytqIFZSNdW96Xn4+vPbmEeuDC+Qh20LLfJfqiq1ym2WViYC8Yu5LCjzzALbVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxxueTenuKlOKdHBiYBOsKtke2xj5j8rLAQnxZteLL0=;
 b=JRZqEBH++pVyCf1yQQlrZys9+tNg1ib4RoeAmaKYu2YCJArLQJYaSYqgHa5vjeM+4mlG6bxzFRBAl1u4SyN5kkm2hlzbkcCYkgwB+C/yAGFSTThp5wYs9C4fEVZjcl1Z+LjLndLzLtN4Yv18Uy40wROVwpvpp38X9rRbHLugiWPXF2m0bTPZpwL9aU94HtNON27Uqwq/48ja6gN0fC4H08FbkVcRmCStAX0WbOzJHRqVkqSGHiRLgy/tGlWpp75tUsGPtaHZpxGkhLGiTtx40ZnSe5tFCWCqzfi+0tZS78cdwSVLNUYD5XbJs7z4G/9Sn8feq3gLL0VSdAVVZvRACA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxxueTenuKlOKdHBiYBOsKtke2xj5j8rLAQnxZteLL0=;
 b=EnAfYiSlUgi94+OqMJKgp0jR4hdMRG6ihCAGnJUBHQN0dD1Da0lsu7eqalfEeK9pQDA6oXENJG2XNY7euyn1/w2kXXMDdAZ3aYdUOupprpqY81k2aCoyJxfQYkJsTGknEUlSFzSITfqeNO0cey7uxwJHmQ3Z/7KyMOSZgO0iOJ0=
Received: from DM6PR06CA0018.namprd06.prod.outlook.com (2603:10b6:5:120::31)
 by MW3PR12MB4475.namprd12.prod.outlook.com (2603:10b6:303:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Wed, 6 May
 2020 06:39:29 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::8a) by DM6PR06CA0018.outlook.office365.com
 (2603:10b6:5:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Wed, 6 May 2020 06:39:29 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2979.27 via Frontend Transport; Wed, 6 May 2020 06:39:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:39:28 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 6 May 2020
 01:39:27 -0500
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 SATLEXMB01.amd.com (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 01:39:25 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>, 
 John Clements <John.Clements@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Guchun
 Chen" <Guchun.Chen@amd.com>, Dennis Li <Dennis.Li@amd.com>, Tao Zhou
 <Tao.Zhou1@amd.com>
Subject: [PATCH 1/4] drm/amdgpu: switch to common xgmi ta helpers
Date: Wed, 6 May 2020 14:39:20 +0800
Message-ID: <20200506063923.22772-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(39850400004)(376002)(46966005)(33430700001)(81166007)(6636002)(356005)(30864003)(5660300002)(36756003)(8936002)(110136005)(82740400003)(4326008)(33440700001)(47076004)(478600001)(8676002)(82310400002)(2906002)(70206006)(2616005)(1076003)(70586007)(316002)(86362001)(336012)(7696005)(6666004)(186003)(426003)(26005);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29fb4f35-99a4-4dfb-d1da-08d7f1883a2e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4475:
X-Microsoft-Antispam-PRVS: <MW3PR12MB4475248DA9C2005832BA5D02FCA40@MW3PR12MB4475.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o9PuxuKiLXXjhJOrArlsIc8mQ6tYvq6Jx5L4Fv5EvhP2aJ89j7kQt6zvIO9UGQJSqjqVtWA38l61kxKQCkNiwUDn3lDU0dIBn+aeGiTrzvGXcL5N+rCMfR0h2rs1Tg8qClvV3WoTLgJwwvbORU4AoVE7zqvr9VPbHKftOldH1kbFNuQ9TIlgctYKrOHEo9mc/XxL9ATN+GiEosw5FEjOYHI/FIiOxOeMCbyrhN8ApJ68i6psnhqhAYcNvL5NbsL3Do8KYeMZgDw7mVy5c2wbqaZyigMZyuACZCa2k1uf3p/1KeeGKLwssxB01R/uBHZZCBnpH9D000cWNCpqFvo3kw3HSWto+b7tihe48fpV7zEC4El3pioDj14bxvEoHh8B3tFd6kOPxw0GKfehEjNTGgdTMnjQ4FxuPfAbsthZBBxNQH9+p5dRUsmQn/A+2dL/NqzZV1ZZXs3GAE0MXxr6LFSl3mxsNPKyDe7Bh+Kx3nyV3ZSN2ji2o7nsQYFhVSgQlW+PFmz+zc7FSEZYBDQzJ1dWwkIb20WZVz2judTRcpOi194WZjifdoiIykFu5wqAbOvMoqpSYYgHXW/XXe251A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 06:39:28.9008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fb4f35-99a4-4dfb-d1da-08d7f1883a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4475
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

get_hive_id/get_node_id/get_topology_info/set_topology_info
are common xgmi command supported by TA for all the ASICs
that support xgmi link. They should be implemented as common
helper functions to avoid duplicated code per IP generation

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 115 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  24 +++----
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 121 --------------------------------
 3 files changed, 123 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index f061ad6..bb5b510 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -664,6 +664,121 @@ int psp_xgmi_initialize(struct psp_context *psp)
 	return ret;
 }
 
+int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id)
+{
+	struct ta_xgmi_shared_memory *xgmi_cmd;
+	int ret;
+
+	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp->xgmi_context.xgmi_shared_buf;
+	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
+
+	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_HIVE_ID;
+
+	/* Invoke xgmi ta to get hive id */
+	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
+	if (ret)
+		return ret;
+
+	*hive_id = xgmi_cmd->xgmi_out_message.get_hive_id.hive_id;
+
+	return 0;
+}
+
+int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
+{
+	struct ta_xgmi_shared_memory *xgmi_cmd;
+	int ret;
+
+	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp->xgmi_context.xgmi_shared_buf;
+	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
+
+	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_NODE_ID;
+
+	/* Invoke xgmi ta to get the node id */
+	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
+	if (ret)
+		return ret;
+
+	*node_id = xgmi_cmd->xgmi_out_message.get_node_id.node_id;
+
+	return 0;
+}
+
+int psp_xgmi_get_topology_info(struct psp_context *psp,
+			       int number_devices,
+			       struct psp_xgmi_topology_info *topology)
+{
+	struct ta_xgmi_shared_memory *xgmi_cmd;
+	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
+	struct ta_xgmi_cmd_get_topology_info_output *topology_info_output;
+	int i;
+	int ret;
+
+	if (!topology || topology->num_nodes > TA_XGMI__MAX_CONNECTED_NODES)
+		return -EINVAL;
+
+	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp->xgmi_context.xgmi_shared_buf;
+	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
+
+	/* Fill in the shared memory with topology information as input */
+	topology_info_input = &xgmi_cmd->xgmi_in_message.get_topology_info;
+	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO;
+	topology_info_input->num_nodes = number_devices;
+
+	for (i = 0; i < topology_info_input->num_nodes; i++) {
+		topology_info_input->nodes[i].node_id = topology->nodes[i].node_id;
+		topology_info_input->nodes[i].num_hops = topology->nodes[i].num_hops;
+		topology_info_input->nodes[i].is_sharing_enabled = topology->nodes[i].is_sharing_enabled;
+		topology_info_input->nodes[i].sdma_engine = topology->nodes[i].sdma_engine;
+	}
+
+	/* Invoke xgmi ta to get the topology information */
+	ret = psp_xgmi_invoke(psp, TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO);
+	if (ret)
+		return ret;
+
+	/* Read the output topology information from the shared memory */
+	topology_info_output = &xgmi_cmd->xgmi_out_message.get_topology_info;
+	topology->num_nodes = xgmi_cmd->xgmi_out_message.get_topology_info.num_nodes;
+	for (i = 0; i < topology->num_nodes; i++) {
+		topology->nodes[i].node_id = topology_info_output->nodes[i].node_id;
+		topology->nodes[i].num_hops = topology_info_output->nodes[i].num_hops;
+		topology->nodes[i].is_sharing_enabled = topology_info_output->nodes[i].is_sharing_enabled;
+		topology->nodes[i].sdma_engine = topology_info_output->nodes[i].sdma_engine;
+	}
+
+	return 0;
+}
+
+int psp_xgmi_set_topology_info(struct psp_context *psp,
+			       int number_devices,
+			       struct psp_xgmi_topology_info *topology)
+{
+	struct ta_xgmi_shared_memory *xgmi_cmd;
+	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
+	int i;
+
+	if (!topology || topology->num_nodes > TA_XGMI__MAX_CONNECTED_NODES)
+		return -EINVAL;
+
+	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp->xgmi_context.xgmi_shared_buf;
+	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
+
+	topology_info_input = &xgmi_cmd->xgmi_in_message.get_topology_info;
+	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__SET_TOPOLOGY_INFO;
+	topology_info_input->num_nodes = number_devices;
+
+	for (i = 0; i < topology_info_input->num_nodes; i++) {
+		topology_info_input->nodes[i].node_id = topology->nodes[i].node_id;
+		topology_info_input->nodes[i].num_hops = topology->nodes[i].num_hops;
+		topology_info_input->nodes[i].is_sharing_enabled = 1;
+		topology_info_input->nodes[i].sdma_engine = topology->nodes[i].sdma_engine;
+	}
+
+	/* Invoke xgmi ta to set topology information */
+	return psp_xgmi_invoke(psp, TA_COMMAND_XGMI__SET_TOPOLOGY_INFO);
+}
+
 // ras begin
 static int psp_ras_init_shared_buf(struct psp_context *psp)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 7fcd63d..263bd8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -95,12 +95,6 @@ struct psp_funcs
 			    enum psp_ring_type ring_type);
 	bool (*smu_reload_quirk)(struct psp_context *psp);
 	int (*mode1_reset)(struct psp_context *psp);
-	int (*xgmi_get_node_id)(struct psp_context *psp, uint64_t *node_id);
-	int (*xgmi_get_hive_id)(struct psp_context *psp, uint64_t *hive_id);
-	int (*xgmi_get_topology_info)(struct psp_context *psp, int number_devices,
-				      struct psp_xgmi_topology_info *topology);
-	int (*xgmi_set_topology_info)(struct psp_context *psp, int number_devices,
-				      struct psp_xgmi_topology_info *topology);
 	int (*ras_trigger_error)(struct psp_context *psp,
 			struct ta_ras_trigger_error_input *info);
 	int (*ras_cure_posion)(struct psp_context *psp, uint64_t *mode_ptr);
@@ -316,16 +310,6 @@ struct amdgpu_psp_funcs {
 		((psp)->funcs->smu_reload_quirk ? (psp)->funcs->smu_reload_quirk((psp)) : false)
 #define psp_mode1_reset(psp) \
 		((psp)->funcs->mode1_reset ? (psp)->funcs->mode1_reset((psp)) : false)
-#define psp_xgmi_get_node_id(psp, node_id) \
-		((psp)->funcs->xgmi_get_node_id ? (psp)->funcs->xgmi_get_node_id((psp), (node_id)) : -EINVAL)
-#define psp_xgmi_get_hive_id(psp, hive_id) \
-		((psp)->funcs->xgmi_get_hive_id ? (psp)->funcs->xgmi_get_hive_id((psp), (hive_id)) : -EINVAL)
-#define psp_xgmi_get_topology_info(psp, num_device, topology) \
-		((psp)->funcs->xgmi_get_topology_info ? \
-		(psp)->funcs->xgmi_get_topology_info((psp), (num_device), (topology)) : -EINVAL)
-#define psp_xgmi_set_topology_info(psp, num_device, topology) \
-		((psp)->funcs->xgmi_set_topology_info ?	 \
-		(psp)->funcs->xgmi_set_topology_info((psp), (num_device), (topology)) : -EINVAL)
 #define psp_rlc_autoload(psp) \
 		((psp)->funcs->rlc_autoload_start ? (psp)->funcs->rlc_autoload_start((psp)) : 0)
 #define psp_mem_training_init(psp) \
@@ -369,6 +353,14 @@ int psp_update_vcn_sram(struct amdgpu_device *adev, int inst_idx,
 int psp_xgmi_initialize(struct psp_context *psp);
 int psp_xgmi_terminate(struct psp_context *psp);
 int psp_xgmi_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
+int psp_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id);
+int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id);
+int psp_xgmi_get_topology_info(struct psp_context *psp,
+			       int number_devices,
+			       struct psp_xgmi_topology_info *topology);
+int psp_xgmi_set_topology_info(struct psp_context *psp,
+			       int number_devices,
+			       struct psp_xgmi_topology_info *topology);
 
 int psp_ras_invoke(struct psp_context *psp, uint32_t ta_cmd_id);
 int psp_ras_enable_features(struct psp_context *psp,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 97c80f1..4f6c0df 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -524,123 +524,6 @@ static int psp_v11_0_mode1_reset(struct psp_context *psp)
 	return 0;
 }
 
-/* TODO: Fill in follow functions once PSP firmware interface for XGMI is ready.
- * For now, return success and hack the hive_id so high level code can
- * start testing
- */
-static int psp_v11_0_xgmi_get_topology_info(struct psp_context *psp,
-	int number_devices, struct psp_xgmi_topology_info *topology)
-{
-	struct ta_xgmi_shared_memory *xgmi_cmd;
-	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
-	struct ta_xgmi_cmd_get_topology_info_output *topology_info_output;
-	int i;
-	int ret;
-
-	if (!topology || topology->num_nodes > TA_XGMI__MAX_CONNECTED_NODES)
-		return -EINVAL;
-
-	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp->xgmi_context.xgmi_shared_buf;
-	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
-
-	/* Fill in the shared memory with topology information as input */
-	topology_info_input = &xgmi_cmd->xgmi_in_message.get_topology_info;
-	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO;
-	topology_info_input->num_nodes = number_devices;
-
-	for (i = 0; i < topology_info_input->num_nodes; i++) {
-		topology_info_input->nodes[i].node_id = topology->nodes[i].node_id;
-		topology_info_input->nodes[i].num_hops = topology->nodes[i].num_hops;
-		topology_info_input->nodes[i].is_sharing_enabled = topology->nodes[i].is_sharing_enabled;
-		topology_info_input->nodes[i].sdma_engine = topology->nodes[i].sdma_engine;
-	}
-
-	/* Invoke xgmi ta to get the topology information */
-	ret = psp_xgmi_invoke(psp, TA_COMMAND_XGMI__GET_GET_TOPOLOGY_INFO);
-	if (ret)
-		return ret;
-
-	/* Read the output topology information from the shared memory */
-	topology_info_output = &xgmi_cmd->xgmi_out_message.get_topology_info;
-	topology->num_nodes = xgmi_cmd->xgmi_out_message.get_topology_info.num_nodes;
-	for (i = 0; i < topology->num_nodes; i++) {
-		topology->nodes[i].node_id = topology_info_output->nodes[i].node_id;
-		topology->nodes[i].num_hops = topology_info_output->nodes[i].num_hops;
-		topology->nodes[i].is_sharing_enabled = topology_info_output->nodes[i].is_sharing_enabled;
-		topology->nodes[i].sdma_engine = topology_info_output->nodes[i].sdma_engine;
-	}
-
-	return 0;
-}
-
-static int psp_v11_0_xgmi_set_topology_info(struct psp_context *psp,
-	int number_devices, struct psp_xgmi_topology_info *topology)
-{
-	struct ta_xgmi_shared_memory *xgmi_cmd;
-	struct ta_xgmi_cmd_get_topology_info_input *topology_info_input;
-	int i;
-
-	if (!topology || topology->num_nodes > TA_XGMI__MAX_CONNECTED_NODES)
-		return -EINVAL;
-
-	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp->xgmi_context.xgmi_shared_buf;
-	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
-
-	topology_info_input = &xgmi_cmd->xgmi_in_message.get_topology_info;
-	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__SET_TOPOLOGY_INFO;
-	topology_info_input->num_nodes = number_devices;
-
-	for (i = 0; i < topology_info_input->num_nodes; i++) {
-		topology_info_input->nodes[i].node_id = topology->nodes[i].node_id;
-		topology_info_input->nodes[i].num_hops = topology->nodes[i].num_hops;
-		topology_info_input->nodes[i].is_sharing_enabled = 1;
-		topology_info_input->nodes[i].sdma_engine = topology->nodes[i].sdma_engine;
-	}
-
-	/* Invoke xgmi ta to set topology information */
-	return psp_xgmi_invoke(psp, TA_COMMAND_XGMI__SET_TOPOLOGY_INFO);
-}
-
-static int psp_v11_0_xgmi_get_hive_id(struct psp_context *psp, uint64_t *hive_id)
-{
-	struct ta_xgmi_shared_memory *xgmi_cmd;
-	int ret;
-
-	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp->xgmi_context.xgmi_shared_buf;
-	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
-
-	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_HIVE_ID;
-
-	/* Invoke xgmi ta to get hive id */
-	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
-	if (ret)
-		return ret;
-
-	*hive_id = xgmi_cmd->xgmi_out_message.get_hive_id.hive_id;
-
-	return 0;
-}
-
-static int psp_v11_0_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
-{
-	struct ta_xgmi_shared_memory *xgmi_cmd;
-	int ret;
-
-	xgmi_cmd = (struct ta_xgmi_shared_memory*)psp->xgmi_context.xgmi_shared_buf;
-	memset(xgmi_cmd, 0, sizeof(struct ta_xgmi_shared_memory));
-
-	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_NODE_ID;
-
-	/* Invoke xgmi ta to get the node id */
-	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
-	if (ret)
-		return ret;
-
-	*node_id = xgmi_cmd->xgmi_out_message.get_node_id.node_id;
-
-	return 0;
-}
-
 static int psp_v11_0_ras_trigger_error(struct psp_context *psp,
 		struct ta_ras_trigger_error_input *info)
 {
@@ -995,10 +878,6 @@ static const struct psp_funcs psp_v11_0_funcs = {
 	.ring_stop = psp_v11_0_ring_stop,
 	.ring_destroy = psp_v11_0_ring_destroy,
 	.mode1_reset = psp_v11_0_mode1_reset,
-	.xgmi_get_topology_info = psp_v11_0_xgmi_get_topology_info,
-	.xgmi_set_topology_info = psp_v11_0_xgmi_set_topology_info,
-	.xgmi_get_hive_id = psp_v11_0_xgmi_get_hive_id,
-	.xgmi_get_node_id = psp_v11_0_xgmi_get_node_id,
 	.ras_trigger_error = psp_v11_0_ras_trigger_error,
 	.ras_cure_posion = psp_v11_0_ras_cure_posion,
 	.rlc_autoload_start = psp_v11_0_rlc_autoload_start,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
