Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 964E0C531D0
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2026 20:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D16A10F1EA;
	Thu, 23 Jul 2026 20:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zTBF6urt";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8754D10F1EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2026 20:19:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WXtVqAdQ4kzjC8fgJW+6IQqDiZsyfof+bqAjOs1BhiTex0DvusC6+7vhxIvonVeqolA1Btrs8Ye9lgKR6yv1bMROhA6rZSB343t7MmnQhFje690+aNVBhYvnVtSHot+Xy10+OpdSKP5s+6f4xn4oGznqVMYZEeWy+EdmA/ulUcatsVIa5n/2dKNTUfHIdlTVxGyCUjBcG4FQ1A1ahs1Li+674wMTroPOAaCgHTcE9Fk8oW/1EfoW/vvKvrXRQ63StV7M5SHV8t97UYOJVcsl0/IKJovjPoVkuiJr7DxecEK3zabS6GiHpa2NtziXTz9c8RU76R9pZMMKxoRSEZ/crg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnwDUxuF/Oshq1lyF42xuZSU+4P8BGfrWjhOt1Mlg68=;
 b=XyGGy+VMzytwsCcnmiCR2YckYr7IAsEqTzobGfh3LhRwUBm++q5RjWtzRlNuNYDFpNMHwHHtJSX0RIRfZNLkXc7akW+x/Um+CaJINY9mnSaaM5uwVOafctdqFiJ8ZCg0ynIvirS2Pd2/wXkWDqcGgqpMdyz/QS1nRtgyuiveZ3R0w2N12xJ8UNXY1DFK0g8jkdlZZPISVEiVm8Yd1OzNdg1T/xSkChz14IkiFtqnjXg6z24RfaJInXkMyjTsxGywmGosTZgP5cFHIoCGoKgcWtWvXPTmkDBDvTBWfFegpjrn+8WFZHmcZa+l9v7l2Bfov25oWgdVx7WkX5jn5t87uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnwDUxuF/Oshq1lyF42xuZSU+4P8BGfrWjhOt1Mlg68=;
 b=zTBF6urtYCflGTpzeQqO2Umgp/oBxRJuuRnmSqTynh7i3m8HlASIm7PvrjI8eb26ekHstjG1RE03NARIdUZIdaGJ9D56M4kvzxIdi52CDU862HSv7xmRBgOT4EOYgEhXdTEnLA1nFOduV/CMRQ5Veo0f7y63hI5Q4kRR1Krw0ns=
Received: from BL1PR13CA0387.namprd13.prod.outlook.com (2603:10b6:208:2c0::32)
 by CYYPR12MB8872.namprd12.prod.outlook.com (2603:10b6:930:c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 20:19:47 +0000
Received: from BL02EPF00021F6A.namprd02.prod.outlook.com
 (2603:10b6:208:2c0:cafe::5d) by BL1PR13CA0387.outlook.office365.com
 (2603:10b6:208:2c0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Thu,
 23 Jul 2026 20:19:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6A.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 20:19:47 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 15:19:17 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, "Huang, Leon" <Leon.Huang1@amd.com>, Robin Chen
 <robin.chen@amd.com>
Subject: [PATCH 39/49] drm/amd/display: Add get replay residency function
Date: Thu, 23 Jul 2026 16:13:47 -0400
Message-ID: <20260723201908.373300-40-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723201908.373300-1-jerry.zuo@amd.com>
References: <20260723201908.373300-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6A:EE_|CYYPR12MB8872:EE_
X-MS-Office365-Filtering-Correlation-Id: e8496c74-d1e9-4f1f-c4d8-08dee8f7be06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XzvmoAYY6a0ERC89GlUicgybEv4DZ7Wz5i8W9HO+nPXd9Uin58uh+435zTVv7CD1vLk71nlwXe4Yn50iaWy3PHmKG0uRRQvNlkKtW9AAW5/BrZAM43fRS3KY4sIzzX/O0bUnAluo0iYfD1cEJAasA/Pyc0sGBotWlsYAKgtRW/JAV3wVJQSx5EBuYrYZxfpbrcTF7Hf/zoi6NWMidk58fq6HBeW542i5ntbmt6Fm9fUaAPirK27ddJdx12lSJts844EJWyWQvIAYFCmASEYv/ZE6fMSYenTvBKoIr8SwAwtgpLSB4wXIXVQntHe7oSMgzlAX+d2v8Sy9/UOIFdxeyyWcFVZM0kFACU5rkV1IvjB6jsWX/Y3fDAlFfqi/qKvHxdXljyN4qOelCI0m9nmK05kCWih76/+uK5dJomsEZyj65M42Bih8avJRMLqGKA4Ro5qLQgH4+sIjvbf+KsvkeL0R/4I5NiJBM1qCU84d6IfRk+AmpD243xICunzC4Vsb7USKiikxY975c9BX/IQFPrUfZZoJ/gJ/DSc1CFtN+E3Z4buQOg0oO5YSnypEmJNOBh8w3rp7uQcbu30IY5Nr1qy6ugVEeGOwjYr+yVOCokuoRGiCjDSDMZLivvVdZBkHfOkV1uyfdH4s3hMjqJxja2ehM/QP3voxwIlQEl95liMveTL0RmwiY50tcBIAqrtdd2KLBSYw+Bvxjc2xv5+mqg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GAUf+sTVxm5CvbNkBEsNaOoOjmvatxAeQHxSMfCuQNgjFqFyVHTo4zXyu7cXm1Qw+lB81T0afhBRN+zjcGFds1eZ4h/0aDHljnx1j0SquYM8RemASKayJ4jr47eHqJz5m9C8eoX6axXZ3qVBM90AfvV/+SPCWB+VdWrC0hxH3TmUXYcLYalzoQRUis/vZ83nmmhVpixSVLbYS2wI2y4X/h6IVMzVLPHRbX+JZHUdK9SSmFDlR4jl7CsgFfSyfpbVh7sNFjC5q8DeTIsgWfdDnpprkUXM39+d1d1lRDJHg0cTisnbw/qw/coCA7XjfqFLn8w8ysGe75PiL3xm31BjPUC8h2DXYHefhYlzazPgI1SOCn5u/yJuQj27EhIMYQvyI3bt5faCkHe9IsmBD9a58lM8SaPfT09L0I1BZVcePAZRQMoJ0NEmbJm0vH+iISrG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 20:19:47.5424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8496c74-d1e9-4f1f-c4d8-08dee8f7be06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8872
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

From: "Huang, Leon" <Leon.Huang1@amd.com>

[Why&How]
Add dc interface to export link service function for getting Replay
residency

Reviewed-by: Robin Chen <robin.chen@amd.com>
Signed-off-by: Huang, Leon <Leon.Huang1@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h                   | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
index f25d4b3e11ac..14fc4ef482f1 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_exports.c
@@ -534,6 +534,13 @@ bool dc_link_set_pr_general_cmd(struct dc_link *link,
 	return link->dc->link_srv->dp_pr_set_general_cmd(link, general_cmd_data);
 }
 
+void dc_link_edp_replay_residency(const struct dc_link *link,
+		unsigned int *residency, bool is_start, enum pr_residency_mode mode)
+{
+	if (link && link->dc && link->dc->link_srv)
+		link->dc->link_srv->edp_replay_residency(link, residency, is_start, mode);
+}
+
 bool dc_link_get_pr_state(const struct dc_link *link, uint64_t *state)
 {
 	return link->dc->link_srv->dp_pr_get_state(link, state);
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 07ebd98f0d3b..8eaa219132a6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2984,6 +2984,14 @@ bool dc_link_update_pr_state(struct dc_link *link,
 bool dc_link_set_pr_general_cmd(struct dc_link *link,
 		struct dmub_cmd_pr_general_cmd_data *general_cmd_data);
 
+/*
+ * Measure Panel Replay residency for the given link.
+ * mode: PR_RESIDENCY_MODE_PHY, PR_RESIDENCY_MODE_ALPM, or
+ *       PR_RESIDENCY_MODE_ENABLEMENT_PERIOD
+ */
+void dc_link_edp_replay_residency(const struct dc_link *link,
+		unsigned int *residency, bool is_start, enum pr_residency_mode mode);
+
 /*
  * Get Panel Replay state:
  *
-- 
2.53.0

