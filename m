Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8FDC3DA45
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:40:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD7710E8C9;
	Wed, 10 Jul 2024 19:40:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MR2+ZWY6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680A710E8CA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:40:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+Ox2EwyR0/Ff03h084l8X/5dF1A4TjOlrG9iZSiNeh30btivQPZiT2M8NTIBk4RebNLNyFec00z02n1sTBv2f7L3K0hb7gePZO1dk/bI9Jiw2Z7Ho5VIPtttfxgDDtIjNkjO77MnFGeJW+ph06PRLye7l9pQO/W64izn+h1p9u2NnbbxXU4UcVaq2bk3fnuR5Iq8/dmlqmnKHJOAG561EQCB5vnvtwp5bznKHqiav319OKfas26MyYn8IiJCZpPlEZlVaG3z6ILYhgIeRk9I5aTEwEmTORhOcSJsYH/a55CDcsS5SCqng74Z6wrtQdkXIwaQh0oGgQ9jffyso34kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZkOzOEiefbUUBJQUREtnwZxvL9Vp61RNMCwGUg14Y4=;
 b=QtE8BxdaK8T7CZEvzoSno3KH4IBAJYXuUZzMyFex8J0Wc42RyTgG6AQz+n9Z55a/Yc2y6MOlqi2stErwYczrWQ1ngu4O/qJHTPNo+aCvOXtsemlM2dVAFHx7SaGdAS/CG9yTABorgKRYOjpd4CbG2w95Ye+EalekRdO4LdrnrhQWR44NCmqSH2RXOeN3OsmRQ5lkvZgik1RAD14DvII+lXKrYNB82/INRkZiwnwne73Is71eE2r2TzaYA1L5iVC2wWL8NwMSVXJUmnnlwojcJg8rXABt2AuItAz0ZzZ+gZJ8SkbYwUu3SDIAl08JCtK02pStf/T3OF8oQ0xhYBvzQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZkOzOEiefbUUBJQUREtnwZxvL9Vp61RNMCwGUg14Y4=;
 b=MR2+ZWY6OWca/4D9gCZXZ/yiCMXgsP6H0YYl5obNWd+MPcjjYT13qhLqTh2lKVx10kIfOnUMKMJhQH8d1k2pT8cMUZEGkXNbYHtYymkv5HJY+encPCUQ59/sdtDPlJD4A3+lDUQ8Eiexp50ExJ3OdGJ5iKV1FeaZY1YXJPC/b8E=
Received: from MN2PR06CA0002.namprd06.prod.outlook.com (2603:10b6:208:23d::7)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:40:25 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::f0) by MN2PR06CA0002.outlook.office365.com
 (2603:10b6:208:23d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19 via Frontend
 Transport; Wed, 10 Jul 2024 19:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:40:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:40:19 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:40:18 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Daniel Sa <daniel.sa@amd.com>, Nevenko Stupar
 <nevenko.stupar@amd.com>
Subject: [PATCH 43/50] drm/amd/display: Set Cursor Matrix to bypass instead of
 Input Plane
Date: Wed, 10 Jul 2024 15:37:00 -0400
Message-ID: <20240710193707.43754-44-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: d16bda17-9962-4230-4711-08dca11824c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MLUsktD0J+Myjajmk0OftfnHrZ9gOPVXDbhqrtGmZiaY7VYpXR6XxNW7hhoL?=
 =?us-ascii?Q?HMtSTye4YCtBs0PIYCkb9pSZcnAx2PITLMsxi/w+3ZSHHgq14G7ebhVO3j9G?=
 =?us-ascii?Q?+RqbUvKSsdMLKO0Tfxq5gZ4TIGw6WaUtH/gZ+uG9+20yQQ7pX8q+MId9C4+u?=
 =?us-ascii?Q?YlEaL5JrzIuvD2HjivHxdZHs2fi5AnHQv1TmoxLDEqkiqKRKdwMv3KbfKScO?=
 =?us-ascii?Q?OkRBNIGUceahVVt9RihbKVI8HmmVSlMc+NtraIYVlhaDHC7hDIenujQl9YwT?=
 =?us-ascii?Q?29uGM+n07KxE1jBvsmjaGeoho/+zoR6IVH29BOj+a5K7UbLtt1yjAyMWtFwC?=
 =?us-ascii?Q?s6RWbS8L/24a4Ichn89w2wSu/vw7ZkNru92xgqSUlrCh/sTd95mlOIwkK4yz?=
 =?us-ascii?Q?fGhJPaiTURCNLEdEKZGMo6QDfcoEnrWEzXGKSIA8GLgPSvLFbAdgX4DM4d9e?=
 =?us-ascii?Q?uoQ5p7qItyptRbFsg39EEGtIzD211eB/W7ybyN0+MWUNU/vmasKC4YJ50v24?=
 =?us-ascii?Q?zJEB/Uc9jr8aIX2/QlHxlS+P9mPVGMkLnVkiAeby2+vp3W+jhgRFBUXgzTsl?=
 =?us-ascii?Q?1YBj1vdzSfPYqiT1IY2LTQy8x3MbtbpYr1Q3OgC8dS5a+x8wsyJkCpIWLtDD?=
 =?us-ascii?Q?deKY+LvatoprKk/+tGiMnn3fyMMgXC03TH+hB9pCaeFp7grdnhngFjaY6jwI?=
 =?us-ascii?Q?y9EIi8SDrMuzrklartZrl9j1KzVJ3aKm93RMRG2bSoE4aKv0QDbXnEpueUmk?=
 =?us-ascii?Q?Tec+5lTpZK2rlKyDNqHSewmtXyEDeOxL7KdzdDWOEaTevlzJFDcRniaPFpsh?=
 =?us-ascii?Q?ljr/qcCzS0lReh1VOd0urQiL/XZMDNLk9owyQYFxVR3dJCMgtY63goDoHkGI?=
 =?us-ascii?Q?mxXnxVSoKDMSjcdB2zE70Z9BxhJY6ByI+6nJll0ZnHGLISiu6CsnItHlfGGC?=
 =?us-ascii?Q?Kzx0ItGkCyh14gGOT3b3Yk0WVPNkq1gpCvJ4nA7i5cll8F9sWfyDX+/gb47G?=
 =?us-ascii?Q?5jgTl8j96x/uGluo36Z9ncOi75oqwZXx7pErnUA8MXOeOTDhg0K58rXR+YK+?=
 =?us-ascii?Q?6qzLVCVb7iE2VuFhBnpNYR73FvsNu9Q4afDYwih6fDc/nx6Hg9j4SgOjpYVk?=
 =?us-ascii?Q?kOSozL0lH4XoEJBxopMNueLThhkbs09Gr8ijyU2JhJammV+b4N2TH6BDS+wJ?=
 =?us-ascii?Q?4kB9lJRQoXz9BO4WvOj3tPsl4tyYgGU/Sx2HzcciNliWZzSPsJTMkI9qUCW8?=
 =?us-ascii?Q?gXc21giLWpbrQOZik842xsQ8hASRsTks2MCv80gPx8l6qbiAQ64FwRMpA8Gj?=
 =?us-ascii?Q?BpQ/Q/DHOFi9MLM4wxeS91jgJKPWvIIl5R6zfpz8b5WKrWcB8RxRQRiRRFKv?=
 =?us-ascii?Q?N8QU9t6eaHigaSb6yNEY0rA6tZ9MCt+OCWl58dq+eFlotBMHzQ/9SwO94x+F?=
 =?us-ascii?Q?1NnTHJlsL+vAXv3Ef3NgdUpRfsrBHv5T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:40:24.5710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d16bda17-9962-4230-4711-08dca11824c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710
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

From: Daniel Sa <daniel.sa@amd.com>

why:
When the cursor disappears/reappears on fullscreen video, there is a
short transitional period where the cursor's color matrix is using the
same format as the video plane. This sets the cursor to the wrong color
momentarily before the UI plane appears, correcting the color.

how:
Instead of defaulting to using the color space from the input plane,
default to bypass mode.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Daniel Sa <daniel.sa@amd.com>
---
 .../drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index d0f8c9ff5232..92b34fe47f74 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -246,16 +246,6 @@ void dpp401_set_cursor_matrix(
 	enum dc_color_space color_space,
 	struct dc_csc_transform cursor_csc_color_matrix)
 {
-	struct dpp_input_csc_matrix cursor_tbl_entry;
-	unsigned int i;
-
-	if (cursor_csc_color_matrix.enable_adjustment == true) {
-		for (i = 0; i < 12; i++)
-			cursor_tbl_entry.regval[i] = cursor_csc_color_matrix.matrix[i];
-
-		cursor_tbl_entry.color_space = color_space;
-		dpp401_program_cursor_csc(dpp_base, color_space, &cursor_tbl_entry);
-	} else {
-		dpp401_program_cursor_csc(dpp_base, color_space, NULL);
-	}
+	//Since we don't have cursor matrix information, force bypass mode by passing in unknown color space
+	dpp401_program_cursor_csc(dpp_base, COLOR_SPACE_UNKNOWN, NULL);
 }
-- 
2.34.1

