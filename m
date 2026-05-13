Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE691CD4F24
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86DAD10EEE5;
	Wed, 13 May 2026 14:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="grquSIs+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012029.outbound.protection.outlook.com [52.101.48.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A143010EEE6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yzby0vmG6I3akwse3VnndCXs2HP047mdiJlGzWfsWoFZvf1po4aCz0yAZHIuxdh+hpQcXOR8liAvmWhHPKasXLKRN3Wm9UbCNsAaKGZqCoBdiJiW+ob4xpWECHK8/aSGYtoWGunxC7ad5/WHkt7yflG5c4uk5hMxUvRn5YfLeOd83+IiYAwMCNzWu27d3Rw6LHqXedUpGtBmsjDyT1uQvSEyZztmsVJ2nsFEIAc94hNbUIDx6DVfB7C92dmFm9sPonbfwZVfmv5hoy8EiZF+9TzE2QLr4cQ2VYHfMMyYOFcKgqZvh5SgltTuDB4LFTNDIaOCH8RFD0KfT4O2Rw5ZIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUjlZCCbrq5TXh/vMrk9nq/m29iCtwTNDr8+/behgE4=;
 b=exHE1EQrSHAcYXBL/C5Q52j9q+gAhGmvuKM+jsw3tFtR5Y6XvC/W8YqWsBTD+VHiqLcE18xW2/FqQwc5nl9/Xpi8qizfZ5hJCMVEPi1UjJD5Px4ORaCuH6LkLHyPy1dHAeILn7NkwouIRC76PA5N551gsQsfQR3hwnzuIW++nFFdwLZ+FwN1n/zJuEwzhOhLUCw+PUq+nS9zcCKVo8h58lSuyLiPE9X15ndilYsObhVnqDfh3rv1Hx8fA8R6i32SC/Z2YlgiGPHtyKH9w6WRqL7X7M4/lE6Af4XAEpHlWtfIYvM+O1PPVWlD2JvfDnQiVvNprrXXkajzvutUSBw86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUjlZCCbrq5TXh/vMrk9nq/m29iCtwTNDr8+/behgE4=;
 b=grquSIs+ROh/tBh0hY6m+nxZr5EmAKi6eR8F3axv6ahX4fgONwWAYh0mmjqzt9+UscBzR4M/XGGJBTPiMLJlPqOrOqL6TTmHlZ+1EucK85Ou5CJkU0NFRIa5YUM6umXCRfLSAV+MdfGW17ydgji9wlG+WBQjzFtQHH2Iy3nr2x0=
Received: from CH2PR12CA0013.namprd12.prod.outlook.com (2603:10b6:610:57::23)
 by SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Wed, 13 May
 2026 14:33:38 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::e6) by CH2PR12CA0013.outlook.office365.com
 (2603:10b6:610:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Wed,
 13 May 2026 14:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:37 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 07:33:36 -0700
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:36 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Leon Huang <Leon.Huang1@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 18/28] drm/amd/display: Fix clear PSR config flow
Date: Wed, 13 May 2026 10:29:40 -0400
Message-ID: <20260513143213.1852892-20-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: e4dbc66c-b94c-4f50-08d3-08deb0fc9efa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|11063799003|56012099003|18002099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: SmndqpsFvB2m+qXZ4rymrRzEzb3XxuLRUe6IrJtYcv8UlNoSWg/rCDaJ9hzMrHb8qbntnLvaR3gsNnKxP/cC8cLue13pBiAdXbi53I2BzWOrHbG4YvYroTEJzJOZ6V/fp70v2y0qmi0QT7f7caszz3LiAVPhQc2LdkkftgAB/FiBoFm8qm+hsZ/1vuzZT5NM347ekZWq+NQ3aF7NvrvSf9VSOilsQ7zrZIKlSo7uo7e76Xqu/ujEklmdOy+/b4iQPQGS1tJjk8SymGlA1V+ZTq+2abPnxNPY+j3PNRTA7DqLLcoi7BrO7DPrtpx6QJoHTBZFXx6687md6ojgFNpZl/fTeQ3ElkmbOvxvTNyiWlB8FoOEABHl3Y+Banien1seMhNI2zMr99TYASS1pQmHhp01bVEBdmbRv6Udq0xKKY4Syx3dGR+X7P4AIj856tX/4seZcj7UextbKb0L9z8rb9CCh4dGTTBdBzDHd0SqGOR96KsOHXdrh/WYsBNmpQCZmq9oUVX9NHRzBHQqCVIouPmku2VqJXBXP8j0MiSW0y9uduKVUGaWiWDmnFMqzKlfwEZacz+JJOUqlhlJ9e4q8TwBireGSDd5RWpWCDWhqVdyWGWrTti47TyqmKcE0eiW2VHrlxHZriMO20EMfzBqgatvXODvnabOX6xirJhSkkOW1nQhkr/C6XWfUD7I2HheYARq7rn3J83P+8j+p6LLJ+K1vOsd+3q7vc8Qbc+KAQY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799003)(56012099003)(18002099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5jtNObZ1f3fWny9ttvNYyU+SfkKT+wgK9OvKenhEQcwAN5eQ8zhh2UYX8xsNbmS1YsZjkqsemNkrLUisCdgKcwm5Dk1TEjTVIowWBScVcJjlU+EFXwHQhopGVKewc47eGKsZ9lgXX8rACXyHn1wNSn7Un0XV3lg4x8+r5w2KfKN7vu9ytQxTbCNe40T4dmHDwZGw3Zr7HKFslPaUtSjlIwTxbWL/O04aQm4E4JQicac+Jzxau3rmwY57MZ8L9bLsLTlVezLvevhY2lIrsT9WZeKGvP3AO65EsngjaHYUA/5RCMCDPbJzQW5uorZiOCNlzl2srVn4Omyiy4KvppCx8ca+cajhmjzwAaCMAynBuWa15gSwL2Q1xdnMDkakTnnjC4F4btl9euYSveUBhoK0T1e+2fQzatGGXJnz8gHhh0dm3qjXQV7nHSNXGBRYF846
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:37.8345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4dbc66c-b94c-4f50-08d3-08deb0fc9efa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222
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

From: Leon Huang <Leon.Huang1@amd.com>

[Why]
PSR config was being cleared unconditionally during setup, even
when PSR was going to be enabled. A magic number was also used
instead of a macro for DPCD access.

[How]
In PSR setup, clear PSR config when PSR is not enabled.
And use macro definition instead of magic number to access
specific DPCD.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Leon Huang <Leon.Huang1@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../link/protocols/link_edp_panel_control.c   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index e06a9ac65286..dd21a4c45561 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -713,17 +713,17 @@ bool edp_setup_psr(struct dc_link *link,
 			sizeof(link->dpcd_caps.psr_info.psr_version));
 	}
 
-	//Clear PSR cfg
-	memset(&psr_configuration, 0, sizeof(psr_configuration));
-	dm_helpers_dp_write_dpcd(
-		link->ctx,
-		link,
-		DP_PSR_EN_CFG,
-		&psr_configuration.raw,
-		sizeof(psr_configuration.raw));
-
-	if (link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED)
+	if (link->psr_settings.psr_version == DC_PSR_VERSION_UNSUPPORTED) {
+		//Clear PSR cfg
+		memset(&psr_configuration, 0, sizeof(psr_configuration));
+		dm_helpers_dp_write_dpcd(
+			link->ctx,
+			link,
+			DP_PSR_EN_CFG,
+			&psr_configuration.raw,
+			sizeof(psr_configuration.raw));
 		return false;
+	}
 
 	dc = link->ctx->dc;
 	dmcu = dc->res_pool->dmcu;
@@ -765,7 +765,7 @@ bool edp_setup_psr(struct dc_link *link,
 	dm_helpers_dp_write_dpcd(
 		link->ctx,
 		link,
-		368,
+		DP_PSR_EN_CFG,
 		&psr_configuration.raw,
 		sizeof(psr_configuration.raw));
 
-- 
2.43.0

