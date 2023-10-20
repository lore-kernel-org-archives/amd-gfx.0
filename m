Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13038CDB474
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 15:12:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE99810E5C8;
	Fri, 20 Oct 2023 15:12:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0743010E5C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 15:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEtTJucsqwS2BKE9NpMXp8wtxlWEm6cwuOzOiQu1Ywe47TCWVHY+xeuoWX8uIboFAhNnSi0MR/xq8hywqY2YAX3Jp9/BDH3nUfIz0fsjTqqwazceGEYxC1VKmPEtpU0XUhY0raqI6Kl5QGqdVpVzGJ9bZmbIWWdSHJE2OOSMkOeBAHLX2IcbY50AtHfqHto0mGL8G0EqRm+IExQOBbma0Lwco9UEhhSHrY9m3lE81QMlgSD4Tz62OiT2obWVXh0h3Ldt2vmsM2XBhQqGWlkS/tFmusoeRaqfWAw9UmOqGK7oMlABdD3ccwvufQUdk4lCvdFMDaE1jDEW/Y4oU5X7KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUvxwWMVF9wjQ0U2d5ybqs9xaCjaebHl5GsHXF6lc/w=;
 b=biSMBfMefpw9CotV6Pfx+5d5kPgryE4JBBkeIjdothznw6lynCzIsw/8FfiuAhXDN+jzvtxTB2YYGFgZwSZv3Pv+MN+krEFGi0/j8aV+TsCDmB4G0EqLG3fT3b1myZotGeYZXD1leYAIheZVfGkaZeU2O9bl3+RbIQ/zYcguYZirNh0bJQFTQTT/M2a9VSTcqMfIUvpflCC5UanLnOR+NuwRLvas75yZCAhvAH4lPNevkbE0CYvJX7FA77kotLXSFVycN6AKQwSL4a7RzdMZODyd0L+WcAWQilvX9vcv0w3l1VoUA8aOwphXHWA5rqvuThiU3vfLI8IKwjvoEmqsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUvxwWMVF9wjQ0U2d5ybqs9xaCjaebHl5GsHXF6lc/w=;
 b=Wpp4qJOK8D4ZeXPWUeFP7J/eMkkBHSOjlQ2uOl6Glt0YE4QsrAGftY0I1ck3+iTRCx2kvrXtjvWW8cIYzKDzmJP60a2wQZiVtv0GAST32q8r+bg8NtndJSeGXkgOl0OlV8EDTvnAlIWEe1Y3lny4BiuOfXfd6ZdbHPaAYudCqnI=
Received: from BL1PR13CA0100.namprd13.prod.outlook.com (2603:10b6:208:2b9::15)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 20 Oct
 2023 15:12:04 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::f3) by BL1PR13CA0100.outlook.office365.com
 (2603:10b6:208:2b9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8 via Frontend
 Transport; Fri, 20 Oct 2023 15:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 15:12:04 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 10:12:03 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amdgpu: support the port num info based on the
 capability flag
Date: Fri, 20 Oct 2023 23:11:43 +0800
Message-ID: <20231020151143.19186-3-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231020151143.19186-1-shiwu.zhang@amd.com>
References: <20231020151143.19186-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: d7c4e06b-c601-4d44-c5fa-08dbd17eeb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMOi+zpsW04zQByEUHJUldzE+p6XcHnNhDj6TFojzoY0YRG/8z0kIxrnqUxW+YAuynffns21ZJAdWIoHBzo2LF080cNzBVFdaIps4MxaM9L8AZK2fsEib8VHbxB3KTcW7yZCjOKUZHInF730o7TCHH+2DWj0eDU8uBkUkuz200qv0Wfu+o7qG16fvB4mhT3jPFUbhy4crx5BJo1cq/Q29G3jILnptbif2PgjrjDOjKRA2rTu+66MGjSARyVcKiUaIRZhWGoV7bO3/cK4xMfJEYwVCzLv/SHCx3Fu2zjAJd4PB4ZT/9C7Hg6RKkYUAi25H31Ym7HPa3+Z/0TCzk+Hhve/IBOsAdA8GYBi8875L5Mxg2vXmqB2lWv3aFP7kDYRq/qnEoMjlvRogb9iszZ3tU39O7kdXByWyV49ujYQ7tvmum+BZUu+qNGMR/OF+PXaSpkcX1Ll3+9gu2HDwDUz+emo8flBAlJZQPbRmQYH1AQKRWrOiXdpm3Fy9ihg/5W1why913zjycepm8PEpcjPfv7kZwMirLP1Qr44dos/aTKvWPgilfzQsZ1WiMZfgtNUTtokAIInY6PN9+AY5QNuxC3M/OrbWtzvxTPGxJp43x+psbhUpbYzG4I6k+qeHmd1sPpYCHTE91gCvI0cQEOVqJCSRgRkFAOpaddm0CpAUjUylhWdBED3X/CDITFXM5VehVF27BmghuBPs5eD2sQx9OD45wztkD2dok+Jh0mNmh3glxt48eEN/su9uPTj92IgVJXo9TJrq4B6EUHwcb0njw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(336012)(2616005)(1076003)(47076005)(36860700001)(2906002)(40480700001)(86362001)(7696005)(36756003)(81166007)(82740400003)(356005)(83380400001)(44832011)(16526019)(26005)(316002)(426003)(6916009)(40460700003)(6666004)(8676002)(5660300002)(41300700001)(70206006)(8936002)(478600001)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:12:04.5044 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c4e06b-c601-4d44-c5fa-08dbd17eeb44
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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

XGMI TA will set the capability flag to indicate whether the port_num
info is supported or not. KGD checks the flag and accordingly picks up
the right buffer format and send the right command to TA to retrieve
the info.

v2: simplify the code by reusing the same statement (lijo)

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Acked-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 45 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  1 +
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index cea17ce9ac99..7eede4747fe2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1267,6 +1267,8 @@ int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool lo
 	xgmi_cmd->cmd_id = TA_COMMAND_XGMI__INITIALIZE;
 
 	ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
+	/* note down the capbility flag for XGMI TA */
+	psp->xgmi_context.xgmi_ta_caps = xgmi_cmd->caps_flag;
 
 	return ret;
 }
@@ -1425,35 +1427,52 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 	/* Invoke xgmi ta again to get the link information */
 	if (psp_xgmi_peer_link_info_supported(psp)) {
 		struct ta_xgmi_cmd_get_peer_link_info *link_info_output;
+		struct ta_xgmi_cmd_get_extend_peer_link_info *link_extend_info_output;
 		bool requires_reflection =
 			(psp->xgmi_context.supports_extended_data &&
 			 get_extended_data) ||
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
 				IP_VERSION(13, 0, 6);
+		bool ta_port_num_support = psp->xgmi_context.xgmi_ta_caps &
+						EXTEND_PEER_LINK_INFO_CMD_FLAG;
 
-		link_info_output = &xgmi_cmd->xgmi_out_message.get_link_info;
 		/* popluate the shared output buffer rather than the cmd input buffer
 		 * with node_ids as the input for GET_PEER_LINKS command execution.
-		 * This is required for GET_PEER_LINKS only per xgmi ta implementation
+		 * This is required for GET_PEER_LINKS per xgmi ta implementation.
+		 * The same requirement for GET_EXTEND_PEER_LINKS command.
 		 */
-		for (i = 0; i < topology->num_nodes; i++) {
-			link_info_output->nodes[i].node_id = topology->nodes[i].node_id;
-		}
-		link_info_output->num_nodes = topology->num_nodes;
+		if (ta_port_num_support) {
+			link_extend_info_output = &xgmi_cmd->xgmi_out_message.get_extend_link_info;
+
+			for (i = 0; i < topology->num_nodes; i++)
+				link_extend_info_output->nodes[i].node_id = topology->nodes[i].node_id;
+
+			link_extend_info_output->num_nodes = topology->num_nodes;
+			xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_EXTEND_PEER_LINKS;
+		} else {
+			link_info_output = &xgmi_cmd->xgmi_out_message.get_link_info;
 
-		xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_PEER_LINKS;
-		ret = psp_xgmi_invoke(psp, TA_COMMAND_XGMI__GET_PEER_LINKS);
+			for (i = 0; i < topology->num_nodes; i++)
+				link_info_output->nodes[i].node_id = topology->nodes[i].node_id;
 
+			link_info_output->num_nodes = topology->num_nodes;
+			xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_PEER_LINKS;
+		}
+
+		ret = psp_xgmi_invoke(psp, xgmi_cmd->cmd_id);
 		if (ret)
 			return ret;
 
 		for (i = 0; i < topology->num_nodes; i++) {
+			uint8_t node_num_links = ta_port_num_support ?
+				link_extend_info_output->nodes[i].num_links : link_info_output->nodes[i].num_links;
 			/* accumulate num_links on extended data */
-			topology->nodes[i].num_links = get_extended_data ?
-					topology->nodes[i].num_links +
-							link_info_output->nodes[i].num_links :
-					((requires_reflection && topology->nodes[i].num_links) ? topology->nodes[i].num_links :
-					 link_info_output->nodes[i].num_links);
+			if (get_extended_data) {
+				topology->nodes[i].num_links = topology->nodes[i].num_links + node_num_links;
+			} else {
+				topology->nodes[i].num_links = (requires_reflection && topology->nodes[i].num_links) ?
+								topology->nodes[i].num_links : node_num_links;
+			}
 
 			/* reflect the topology information for bi-directionality */
 			if (requires_reflection && topology->nodes[i].num_hops)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 3e67ed63e638..7111dd32e66f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -189,6 +189,7 @@ struct psp_xgmi_context {
 	struct ta_context		context;
 	struct psp_xgmi_topology_info	top_info;
 	bool				supports_extended_data;
+	uint8_t				xgmi_ta_caps;
 };
 
 struct psp_ras_context {
-- 
2.17.1

