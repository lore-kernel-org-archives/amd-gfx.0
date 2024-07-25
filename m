Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D87C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7982010E89E;
	Thu, 25 Jul 2024 18:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rrwsThlW";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6A6110E89B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyYq6zOhlLnP5yLcG/TMCCJzEnfORuIMX0PPfGTuo6Lyd9NsqLDdQgCZBbPa6QLbOTBcK3nuQywIYDAPH6QE/tILqn48FoO6n73xfmXy8JHXfQvSDCy3ZOoSdcJUzf0NolTDy9gdsB8TCzcfMLHEFu6K3zrpMI9zbgduiJX1WI7RYFII+g1rsFzwztT+sqqsnHAQh2IzcS94PEje5AoxVbguOUL68C6bi51GuwNfiQuOLUDO8A6ssButfJV7BeAJRb7m/rIMpn/iINuxwkO8FsUw9REfuy+LVN3deFiYXKCZCzCVWMEYJERKU8I3QVbsaKcU36cPB0u5wzmFh49WIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncVk+8QU/xE8N5kA/1ylzVCay3+wpGevS9A7R97A0m4=;
 b=fRC+JTfaD4c0/atdeck8oJqoaP2LYMNBDhIr/Q3lVHDy88l8vHb0Cdn0xRHK75/35hdNi5XsxAek0ajal1Rw41VDGGR6U2R2mJJhoI+e/34ts79l9PFRObH1CNnbGfpRdjolGexV68vO/6/UIF9tQjuhJiGIUdJ0eoes4fwya3fm2+QpsIxdJXMHhVWR0hlYqJ3VPgja5OHgRnKZ/4yGXcdO4KS9Dc0fucM25+5e1B8KbvGdzgeG4kqJmC1bX4yahUvJuxbbBwQ0LFQovijdVkrxNuYp5M8Hi1+8YTzWBDct/I7qhAm3K2d9lYa9lwf7cMyINryYZdyck0qTkaKAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncVk+8QU/xE8N5kA/1ylzVCay3+wpGevS9A7R97A0m4=;
 b=rrwsThlWOIXJezHU8ZS2q3CqoE7ZSHdGS1XW/gOogCLOY6w5/0yjJjxmdrv05lsw+P2L5RUujZW+QUDH9w7DX1x+UJ3zHyWx9kULS9zz7XlmeDesvU5E86vHX6domaMnozLi6dV6W5RiiHrSfE89t2VZrWtok6jmKM7j69WPAQg=
Received: from CH0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:610:33::35)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Thu, 25 Jul
 2024 18:03:48 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:33:cafe::f7) by CH0PR08CA0030.outlook.office365.com
 (2603:10b6:610:33::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:48 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:45 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>, 
 Austin Zheng <Austin.Zheng@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 07/39] drm/amd/display: Add option to disable unbounded req in
 DML21
Date: Thu, 25 Jul 2024 12:00:51 -0600
Message-ID: <20240725180309.105968-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: ce3db57b-870b-4e21-0a28-08dcacd4224b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qQTUQlxdijG/aYRKSBdwAasyjUoRJaRF/jy9o/8xRlSmG9LYVCJxSgHS8uoF?=
 =?us-ascii?Q?IqOfGo4trmGfVV5O4bA/NJOl64HuVCuRp+xIqQB2M+qHhFupxgcuF2K8IA/t?=
 =?us-ascii?Q?7JUKTgjtRu8dkvFnFz+nqu+IqoA4xYPr6PDb0fY0knzZkhTYff6uV76x9+W7?=
 =?us-ascii?Q?BsK0aW6+EZmpiiaUIVv4UTIK1FyedXYWCbVOf49YKr18fUa+HPGgpL2oiTec?=
 =?us-ascii?Q?I1FW8ufA+4JGLQNd+jkA+dcaLufBBzZyQS3aqPs/t+lPNmG7gIn1SEORiZhZ?=
 =?us-ascii?Q?ZosnpDdsOEI0OXG5YjeZXD9rQllbV7ghqFw/PBDjLtg7roCLaJCNF+VGzX95?=
 =?us-ascii?Q?mhNhtb5lYUvCjEpja9Rd4/XmEn2fIj7eeGF6PwzMyZlgwDXKpSCEQCuz4/vr?=
 =?us-ascii?Q?EedRELIkWpabyEPixyvoKEQND/2la7kLY6ScC8pwRF4TGrWNaXH6dgrZXm0f?=
 =?us-ascii?Q?KeZcisawsObvnpEXCskPg8RvkDbKoX8CuqsUqYNEvL3T2tiQ1OAwpJjz4FS0?=
 =?us-ascii?Q?HBXhfCnauPHONR57Qj8pP5yRs8DCnbjbkAs4EQ/2EUmYd8x8O0jLTIfIxSfr?=
 =?us-ascii?Q?Z4K3thPyh4Eu0Zdh7hnwux+ypcw3QLJH3MFAj7Mp1MYooqa7fJVbNph5by0S?=
 =?us-ascii?Q?9xDnZUqWGfNjlAoqnWTdKyRMV7g41O13bgNE28DanFshElSbNaP1TEu2KcCX?=
 =?us-ascii?Q?X/U1bBE4REbcNahHK7Iw3Fw9DfEkXZ4D+v5m8EJ4ddhLQK3xNG3Bcr/9qEK6?=
 =?us-ascii?Q?Gr/Nd2294+ovXRp5L4PdEYtHeG7qbhHoaUXrlul7Dkd4/sjQNNx21K/KrCR3?=
 =?us-ascii?Q?8jKY7ohGsAbhjcxS60CJpY8O6NmV/ePgYTp+STYt6ge0bVrskxob6QOECAHa?=
 =?us-ascii?Q?p/tWteFJjfLYs2biQYJTDo+5obKxPz25tF2GSiBcRUdvkWfUhuoDAWSXNRyQ?=
 =?us-ascii?Q?BQHv8auHaCBKgo4JrQ28zqrbRFEeTw/a5G2v2H/oF1z8oQjVkOlHnYGRmrV3?=
 =?us-ascii?Q?d1hqqM8C0cInlkEDEMLwpNq0Nl8QriEFwLWeqZFOGyNZGuUl8zv6UjKmUOaP?=
 =?us-ascii?Q?DMS6jNtVawcAPi9YQOgx1n1MCGwTuziLmltqdEgsh1hsyJCUCykE5EZ2gXXJ?=
 =?us-ascii?Q?D7mD2+dYMzRJhXLE+jB4Lp0CegFu30zNv7TjUfkJFKLy17YEQQe0MXf3AsWV?=
 =?us-ascii?Q?PGpu5sn7xrT43kqpldJgqK73QsleCQoIWVAf/RnoCrB0WvhBxvnkNWPBUiYf?=
 =?us-ascii?Q?chl6TOJfXs/oLvl5zFRVkG49CiCdxTdKJnopg4NuKsMw6zCiBOnxHUMxElcF?=
 =?us-ascii?Q?wH/l0+tqUyX+1tFJ3Fq0oiUDaBAKkKdtFCMRRrC4EShFLTxq9Ksd2g+VLWPS?=
 =?us-ascii?Q?voDl0P2d/b32uuGDYVjdfAqdNhy3LLE0E9x2/3drV2VWXapsxnlB/lCwpbq7?=
 =?us-ascii?Q?x3XcKvaMa+FY69UWTqWYqFOsNbfHGbrI?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:48.5967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3db57b-870b-4e21-0a28-08dcacd4224b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293
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

From: Alvin Lee <Alvin.Lee2@amd.com>

Use debug option for disabling unbounded req in DML21

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index 0f34688e4058..65776602648d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -959,6 +959,11 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 	dml_dispcfg->minimize_det_reallocation = true;
 	dml_dispcfg->overrides.enable_subvp_implicit_pmo = true;
 
+	if (in_dc->debug.disable_unbounded_requesting) {
+		dml_dispcfg->overrides.hw.force_unbounded_requesting.enable = true;
+		dml_dispcfg->overrides.hw.force_unbounded_requesting.value = false;
+	}
+
 	for (stream_index = 0; stream_index < context->stream_count; stream_index++) {
 		disp_cfg_stream_location = map_stream_to_dml21_display_cfg(dml_ctx, context->streams[stream_index]);
 
-- 
2.43.0

