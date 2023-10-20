Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BF9C0032E
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Oct 2023 15:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B81210E5C9;
	Fri, 20 Oct 2023 15:12:11 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D15D10E5C8
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Oct 2023 15:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3/AqWg9SMQvloCHTYX9w4IOM3pFlKte3IhCpogAisAp0O2WZa/a2tzyiH07lRS0FBDo5uNOaiDTZ6VhYHlRJqCKbORyahAAToG6x1CUu4Eg6Exs9BTurdEwPL5l3+7Hy19jopK4bd7vmkaOMajlvJBxqPiEBtiPLQtj0SVRWpMqdRtbknCLrYG6k+13GczRII+H2a2YvIBMMdLIOu9J2MW7ymzQYpJEmXk/p9DlwoCBfrcnEnQqvB2MVgfJYJeKxudWmIV/M1gXtqyaynUGKcky6Dk5TmOlPugYHnBcyRGkAnqJ9kHoj17NG8l1dncBiDBCuG/EYKv0i6XNAhYTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9evBUK6Y2L8F6Wh97/Zn4omSg8eMWNTzF7jKf8IMSjc=;
 b=e1j1oqSrVMNs8w5682X9FHmswKutR85qk/9t0nmOgbKDTXij9LgIfRgnY7DP/740HuLdCnhut2/4YGhtd40e/yE+tTBHeikv0b28emsttdRbCHst1HWatZVcDxaMeBSKE0V6WTYXhxVfnDYJQO0suBsFLYFmJjZqBKnd1VlLSPiXJKE7/WIhWBTPYn75xAqIBcycmdmudbr8lurr9jcYOFCtFi8z+Iw59t54B+El6jEylN5RKHjmpgbS/KsC1MW5CBjnpXhkhaJ3++1Mi+FL+IzU+SDV1loQOcF9pc3o9iKtVqnCa2RTXO9iE459iJY+DOA0Fd70Ni8g0a5M1IfK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9evBUK6Y2L8F6Wh97/Zn4omSg8eMWNTzF7jKf8IMSjc=;
 b=BeC5u0YPxTZQ/57KmiEqGHUAt+4XBgZAv939669gjoyALivw1CdEU6KnRPamwJt7tsNB6rfcFf84wNtcfbh4jGh64Ppyejek9PvuWfVX9Gpn7/ACUoUW1+PgtOgxjKozuSn4h+o0YinGPit+417AFMio9n9sae26gnL+ykn1/Ts=
Received: from BL1PR13CA0101.namprd13.prod.outlook.com (2603:10b6:208:2b9::16)
 by SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 15:12:04 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:2b9:cafe::3d) by BL1PR13CA0101.outlook.office365.com
 (2603:10b6:208:2b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8 via Frontend
 Transport; Fri, 20 Oct 2023 15:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 15:12:03 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 10:12:02 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: prepare the output buffer for GET_PEER_LINKS
 command
Date: Fri, 20 Oct 2023 23:11:42 +0800
Message-ID: <20231020151143.19186-2-shiwu.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SA0PR12MB4461:EE_
X-MS-Office365-Filtering-Correlation-Id: d7620a41-9ad1-442f-cb2f-08dbd17eeac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECxehpTng4yRFwdDlKXqx8c6lvs1zlMebvJX8PpMPpwUXkBS/bewjErNuO9SRoKkuL+J/hAPibhEYVVtKWv5KcZFeNmoSTBi1ig1Du9nLztXOHFWqOcGOIvJbLmO63Uap5YbsC0GnEghfcNnLl90p8RZcFDxJNB2AiAzgZDY/YRaciCUhl0rvDs9tOFMo7+V+/yzDSJewq1a+nypE8ZSWMsDzLlfKjkkT7DQaUcg66q9WIrqT9LnW/UF7iGR34Qfqn2Eat95/aA27Qr9UCh4C9hGxOoBIZ84Ngz6oWjSjwRM8Xn2voHEh4kNHenSD7Xwqr2oYlLP1HBJhSgo4AKZye9npm8KpRJPhKfdwXr6clNKmYHG/V1jW6iUk7SbIqnlVau/GoJa1zyUJx78Z0QBC3wyK61mNw2arDI8iQxVtRuvdF2KGWUNhO6edDd4/yJ9awtN7daRKuNZTu9uEk7pPkpkRLT7efb9fT1cokb74XXdtky9YcaAvWQ89vTEw/0901sKNV4xLWvay/kXSSm8WsvhurAmbSmrv41wFSAni8ylsrQnLRF5e+wO8NQeXUXKY3dI5VXj2/hUryfr+By9S1lKFQ92p9Ipq1z8PORxmJhZvPyIbOA8FyO4zim3UgaHgZ4OnAYgWrV6JsTOsVLBDKSj1MHCHC3CGLoRBg48KBuevnxQ3CYxToz+xsVmkAZU/Kjy1lNQngKW8vW7+W/cHeETYD+NLctO3ZYKvu5+oMEJ6Kj6ytfnfTOSoJdvI2k3DeC/TxIHLvH+It5glIk5cQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(36756003)(40460700003)(36860700001)(6916009)(316002)(70586007)(70206006)(86362001)(356005)(82740400003)(81166007)(83380400001)(2616005)(336012)(426003)(26005)(1076003)(16526019)(6666004)(7696005)(44832011)(2906002)(478600001)(5660300002)(47076005)(8676002)(41300700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:12:03.7075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7620a41-9ad1-442f-cb2f-08dbd17eeac8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4461
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

Per the xgmi ta implementation, KGD needs to fill in node_ids
in concern into the shared command output buffer rather than the
command input buffer.

Input buffer is not used for GET_PEER_LINKS command execution.

In this way, xgmi ta can reuse the node info in the output buffer
just filled in and populate the same buffer with link info directly.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 0c7900f0d906..cea17ce9ac99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1431,14 +1431,22 @@ int psp_xgmi_get_topology_info(struct psp_context *psp,
 			amdgpu_ip_version(psp->adev, MP0_HWIP, 0) ==
 				IP_VERSION(13, 0, 6);
 
-		xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_PEER_LINKS;
+		link_info_output = &xgmi_cmd->xgmi_out_message.get_link_info;
+		/* popluate the shared output buffer rather than the cmd input buffer
+		 * with node_ids as the input for GET_PEER_LINKS command execution.
+		 * This is required for GET_PEER_LINKS only per xgmi ta implementation
+		 */
+		for (i = 0; i < topology->num_nodes; i++) {
+			link_info_output->nodes[i].node_id = topology->nodes[i].node_id;
+		}
+		link_info_output->num_nodes = topology->num_nodes;
 
+		xgmi_cmd->cmd_id = TA_COMMAND_XGMI__GET_PEER_LINKS;
 		ret = psp_xgmi_invoke(psp, TA_COMMAND_XGMI__GET_PEER_LINKS);
 
 		if (ret)
 			return ret;
 
-		link_info_output = &xgmi_cmd->xgmi_out_message.get_link_info;
 		for (i = 0; i < topology->num_nodes; i++) {
 			/* accumulate num_links on extended data */
 			topology->nodes[i].num_links = get_extended_data ?
-- 
2.17.1

