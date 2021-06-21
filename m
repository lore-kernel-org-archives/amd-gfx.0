Return-Path: <SRS0=3j8t=LP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A78BC48BC2
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FAA46134F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Jun 2021 19:24:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAA46134F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DA8D6E3EC;
	Mon, 21 Jun 2021 19:24:05 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5EEF89F99
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Jun 2021 19:24:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV6leH81EklBECxiAnTxs+GZGhHAGWCQdC8MBPxUHknQkxvgm5LHPx5kNuhfhWTJNufsuvd0AVXYKeJoRLXMCEFWHDDd30Ugg+g/WtaQV7K0YCy2nz4T6KoZfzOTMa9vnvSWkPJucDDUJEA41BImIBnrdYa0vfTocHsiqLy5sTCV0Cky6Zg2FfIT7mGT+67dYAT2TeD52Xe9+v6lrFHWh6n1dazAmOFvplFMGNBIraDvuGtWzi8thr/bw5+S6Q+yMc/9Y7f+zFTdOMEZ7BcpcqUoFOFRGhrEcJPU1fb8Vyka1sU/qA65Bhj8qloCr6tj/ZAckXbtmr1+fJ75/ehitw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De5UZXXOgWWQ2KrVdgI8nGGnFJxJLR/JFyjbt0lzIMY=;
 b=h91tPXqoK+wITkYeJKDqy4uO8/Z++oR/3Dc0z/chcsMnFvVlHdhEH512crtvEyLBZVumy+SCWFK10Ps5uKaCMwY7M3lG4K+BiHNs0BPwCBeI0SZv6U0k3E8do7JdpGDnkox//P+wBWS8y3YW79P2mZU1oEEfcilP8Jrj1Gc1LBnPGa+dsKVcYV2FjVn10VlTEYPZJHxDCfvdmibZCOwz7MxzgQ1YYqGLeMOIX9LSJ0Bm4lphZJZm5AFx5szJmSMnsvnjyf8BOnxftP8qeRNZa6V4Xar6962pWOB2hhy1oRezTXfxooRACQFlEnqd37StjxJBowncrpODSkifgiFH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=De5UZXXOgWWQ2KrVdgI8nGGnFJxJLR/JFyjbt0lzIMY=;
 b=ddaEK+DQfug9z7ysDIOyJuDNfzlfJsqj4E6NWzUrewXJ79qpizOT3ffr6+a9RqoXLxmftWQpY8AqB41QXB7oooBA3NVzxVfqbkyl2x7a0OMrZXfHj99o8j2j6g0dWtx6LTy8l1ukVwfHA7jUc/W4St3HUMrcu08/oMoqZsKEGW0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB4680.namprd12.prod.outlook.com (2603:10b6:4:a6::33) by
 DM5PR12MB2470.namprd12.prod.outlook.com (2603:10b6:4:b4::39) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.24; Mon, 21 Jun 2021 19:24:01 +0000
Received: from DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7]) by DM5PR12MB4680.namprd12.prod.outlook.com
 ([fe80::1d06:dcde:55f9:3eb7%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 19:24:01 +0000
From: Jonathan Kim <jonathan.kim@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: add psp command to get num xgmi links between
 direct peers
Date: Mon, 21 Jun 2021 15:23:45 -0400
Message-Id: <20210621192348.2775943-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::16) To DM5PR12MB4680.namprd12.prod.outlook.com
 (2603:10b6:4:a6::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jonathan-KFD.amd.com (165.204.55.251) by
 YTOPR0101CA0039.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Mon, 21 Jun 2021 19:24:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6b3322c-67f7-48ef-7959-08d934ea1fc7
X-MS-TrafficTypeDiagnostic: DM5PR12MB2470:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24702ABCDDE2567FC73F7BED850A9@DM5PR12MB2470.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZykv+fV93L4QP2OLpqY1+kPcf0BbW7K5vzGPdHi8mMBqlX6ngYm1yi/tiX/UuMIqZH8ugQI4o+lbzEyNkunCG7xylvB9uC+lWwdJ8GVUGGW+5wM9w0ryB/bTTnvajavnP9YjocIK4Qcu1PGkT9bcNJYlF1i/SkbOW90+Ch7QoHwfhO45Qi+75jHIan1QbJVOafCOnjxe2U+UOfyEyrHg6gy5YZKOCDtwhVQgbo/f01GONaN2zCDwPt8zZrnVZ42hHTvvN5o9/Q5TQMaPU4fXArEr1pYFEYXuJfQ2W+hcMGwNi/AMQg5J1GTkoZGcPX6bPGWGn9geCdfSdYEx1tbcdxfEjdIMaVpK56axe/hxCvJNQH7h4kJvW6yi3NmM5DqbQAH/Bb4cHI8v8sIREoX5ynGwas4sIjalwx+xmdg6AWbXE2wA+aL41NdMtA71jozicZ5FO7stJEfMrq94d2yuF/bWUzRtIqKDrkxA7XRFbFnbjJpKV6FpHxPgAif+ikCL5DfgpO9Q6hebCfDR/eeEdNeU6E76Ly+8LK7LFVgKyuvD6h8Xh/gBBce6vJ96PVC06dD4wThxFlIn5OYhS5kZ4nPjHZgIriOV2OFmwQCyLl+IR0odavN6LSbInC22zkLyFYz1FZFZeoWqCj5urJjt0RcBo11PacOHDL+LkGL8wI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB4680.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(66946007)(5660300002)(6666004)(2616005)(6486002)(8936002)(1076003)(7696005)(2906002)(86362001)(83380400001)(26005)(52116002)(16526019)(38350700002)(6916009)(956004)(36756003)(186003)(38100700002)(498600001)(44832011)(66476007)(4326008)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A4SIyWQwjJoMTJE3POe8L0u78/IYJtM2/YVs3AOOUgVwefjSYzm/HdXORQf8?=
 =?us-ascii?Q?+J116kvnFhSuEtLIRCbZRPVO1F9U05cobOI5OhpFQFZ6yhfbJjU51o4WyFBq?=
 =?us-ascii?Q?J5AjL5n+5c7G1GSB4ni0Ly3HqjG4lq4W1caf+8WztRjiq8e2MTrghuSUQ/OU?=
 =?us-ascii?Q?32nG3zTh4y9V6hLszQX8X6ZSJ87UbIL8QMtnD7FB4Bg/03tbfzA3jee+RRFE?=
 =?us-ascii?Q?ov4si9vHhTxqoJ9XA/+b5QptuNottIUlR1POxkvCmJSBipeqHpDHWycotuYI?=
 =?us-ascii?Q?AQ0kvLUp3taisrNBCNt9Z8/KMlkpIN9jXFJdCPEzzEYjaw+9p8lPjdO378AP?=
 =?us-ascii?Q?RmXBpgX6ZTeRQQK4pr9k+nLWuYKocWoaWb1qeJKHZc6CovkBjEKfhLOOiul2?=
 =?us-ascii?Q?swp8hvZlKGe0CSf+ilOy/ajmYJICMu6zelNN3uzyAz0ogq2/2aflVG2kHhkW?=
 =?us-ascii?Q?dSJp8FV+0ciDFNEbJg5KN2l+RLGWOgZCXICdNwG9uc2XSaoXxEXsKkno3svL?=
 =?us-ascii?Q?wUSTUjesXNweCV2HJa4j2et8nBmv10JVl8dOr2Lwtffh2jyln7swHXZOtdEM?=
 =?us-ascii?Q?shITqzyRLbiMh2KXNS6Ae9mBjiDXBQS42zsmg5L3wG3nEhwkHqcGUye8hr4r?=
 =?us-ascii?Q?A/F2k0h5Z32K9X5DYFAZ7iHMEMHhvTHb76+wEIbLbk9ib0L6LCBMet7JrxHq?=
 =?us-ascii?Q?EodD17cYJ7omItCmzi6MGyN/FIlkUvDYD0tCSmBEtrQNleil39277ALBZSV2?=
 =?us-ascii?Q?KgOknsWr74solRIFxj3s/s/J+wlS0dHOLkg9KW0RLQjSPBuNyLpbTKfhTC4h?=
 =?us-ascii?Q?q8ovPkZ2p1Oo2dE4O9Te6wiufX/MDWjL5rY96kJ5cQ5rLFJtEjBUCWW5rUBk?=
 =?us-ascii?Q?B8pN58Qo+34/uTAIFOCn21JVPslTN/5hOb+9zlCQonpjjgFe5QKx74L5llc3?=
 =?us-ascii?Q?EM+pDTdFgMyqeY90iP0lqlvW1cYq07uYiRk54u4eLVz/PlWyWo44KpRMbFk5?=
 =?us-ascii?Q?RMKRsztfLkbk8MOGqifuAj5KBcfsr0/r0uG1jhwGt/G7ztW2eK8BU5trOkNp?=
 =?us-ascii?Q?ITfDEHOsDRQwKllZmPYNHchSqO4BH7aPIJF8csbAr2oJ0F98nq8Va2dP97ES?=
 =?us-ascii?Q?hujir4E/tLmjZh3QF3dAy9AyZ/fNXb7GIHCyGJtq1ch0Jenk1HcaYQLlqw3T?=
 =?us-ascii?Q?OL/hzBENHVAqCCsK6pw4Qp4r32j53WS9YpyNiAtcSF34xGW1TLXKqC6qAii/?=
 =?us-ascii?Q?Dfvv/jlU5h2B/fEUJ/zwb0B+iuzbPOm5vG6h2uFJt/SmMn3gMyIqCZeywoPs?=
 =?us-ascii?Q?bd6JeIPYyWC73F9Uy9FIuuhS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b3322c-67f7-48ef-7959-08d934ea1fc7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4680.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 19:24:01.1662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XNBWub8OMmkFtPASA4V2dLraoJACRcUSvo9WUu7zOfFMO8yOugAW04Do4iBfPArM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2470
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
Cc: Felix.Kuehling@amd.com, Jonathan Kim <jonathan.kim@amd.com>,
 Hawking.Zhang@amd.com
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
index 40da29d8ec1e..2af9a7a9b7de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1037,6 +1037,12 @@ int psp_xgmi_get_node_id(struct psp_context *psp, uint64_t *node_id)
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
@@ -1080,6 +1086,23 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
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
index e5dcc6713861..13f1b869f67e 100644
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
