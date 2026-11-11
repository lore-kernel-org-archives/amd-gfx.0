Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F60606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 01:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kCCuEJlQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A328710F8A7;
	Wed, 11 Nov 2026 01:40:51 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013013.outbound.protection.outlook.com
 [40.93.201.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F24510F8A7
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 01:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAdSay744oBqkHbhf1gvR+SIxabY6Q4k4erAJBHYYsSEhILufMsXRFApA/Be/9CYmmoqfIreBM/sfR8T/doq7QSshrYQq4CBWxvHVKcWXPv1WWREyS5kq3xrFH7Ydb1fIzglMQ69/L/rIUrhRk6obbyItTXV2QRLoUN+Y9MQgeco0TTKq+RXUW6yxBveK0YoTZtEv09e6vhkRC6CvELdYSgDC4OnGKYSsotgYeZ0B/+PbxMd7JyfvQg9KNVhU70Hhgn8/KIqD1Gahhd4OWqI6Ysep0pdg0+v8G94DxhTguvtPPlLE+q9FSco7U7mH2AyTpLfUpv0IlvbzNIcVL0Qfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hq6gY3NxpwAydqIwK+RJbmrqK++yzB5+QJnCG8SvOMU=;
 b=IMmvh2hAu8Vv/pq+p6mwpY2J7C5O4aMEK/1rwnrnzw0fLv3OidR1izo2kSQte3XyBMOYBJrxndQBjiOvH9b8wsbzyHq8Au3tC17wctyjTMu7/wZ5bynxA57UsQ1GefKhCzwMi6F1OCqsQgm9Szm9BAFfRrU+yZX2vkdiPn8SuOQOdBfzLg/Xm41fncyYID03MT7g1a0Anz+G/Mm0P+lzWbXAvqtiknTC7jbGrk+0y5IauWaiHhK5X26baJFtuN+C8j347f7n2TRb34aVuKSg+tzUL1LxCn14wAr3GOmviRb1G/ABzv1CVSs/YHy6gAQCiwHPpmGDQL0Awkvhu4NGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hq6gY3NxpwAydqIwK+RJbmrqK++yzB5+QJnCG8SvOMU=;
 b=kCCuEJlQjBDCSvZ3DW3VjLA9ippWz3SmPnlxi7RsTyvu2NGEtzVHBUGzZj7GKG+cWCqVAxRgzXIWPLy7vKYVkONUDUWOXTtbjEoBP3ImeftwipVNCpda+1YyItEqnzNTJLd9aTbQDeY1F6r7uVlG6OGCsA+0hW0ROoxxZbSwyf0=
Received: from CH2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:610:53::32)
 by DS0PR12MB9039.namprd12.prod.outlook.com (2603:10b6:8:de::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 01:40:39 +0000
Received: from BN2PEPF0000A805.namprd02.prod.outlook.com
 (2603:10b6:610:53:cafe::a5) by CH2PR17CA0022.outlook.office365.com
 (2603:10b6:610:53::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 01:40:39 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A805.mail.protection.outlook.com (10.167.245.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 01:40:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:38 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 10 Nov
 2026 19:40:38 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 10 Nov 2026 19:40:29 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Eric Bernstein <Eric.Bernstein@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>, Eric Bernstein
 <eric.bernstein@amd.com>
Subject: [PATCH 04/74] drm/amd/display: Skip UPSP programming when UPSP regs
 are absent
Date: Wed, 11 Nov 2026 09:28:10 +0800
Message-ID: <20261111014100.3596072-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111014100.3596072-1-Wayne.Lin@amd.com>
References: <20261111014100.3596072-1-Wayne.Lin@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A805:EE_|DS0PR12MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 248ed885-b05c-4a1a-6f2c-08df3f94ca5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|10067099003|11063799006|261009223027099003|261102123227099003|56012099006|261021135927099003|261021123027099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: PLYBXEK73AFADfQYB1gCtiQ9hRzp7Cs2i7NBG6R6bw5aZZB37vDetq5chzWekpaOAzN2g7O4+ha43RyjSo5JmqWXk+0Sz7bH3y8i1nxZ1iUMZQmjoHT7LK/d+7UjfIhFAjXSU28QibOcn8G5FbnnSGd5owl+lOXojtdL7+Qf3M8zC8Hye6+bzcDa+sgA/Qjr+c6E9c80OfTbK3a0MAYtuRWI2us/jwW7JH5uHiaP0um7aCXGnYkDNgtvj/dPS1GD8ET6o16B0aGdNgHS4M8eV9sw/BLlzHBhf9keJQLGv10FXllD7RUfKkK1w5zJT306rcYa/8pVbjaBFNI67YfjqfHXLUObeuz8O3gbbs4LolWd1zF1x6v7cKb1oLvxYh80f6zjua01ViGAhMDU2ykCaIai3WDHP42oqQrcshqxIeO7SBqvubCSM1VLHlljC50DRpcwernHKkv4Yu9M7n4Rv0Smg6px594bsycyjRX5qfW2ujFnrYTumtRGjJ86V+T8N99mJNxav7PY5Onc5C7mCFMKeCLtOYsmLO3BBShZuQ1alMzoneJlHwKII03kzo/2hNJQhzb8+2cFYNBINM7rxoI5M6MizkpDjF3gI0p+XslgymgR/jfRXw2C1kuJauym+0BfHv7AkHLHFYiTGDR24J0j+Ph9bkEgfBUFomIJ19BttrqcHj2Cz4Ez6l0mSwfrBTZzkIRXu1OXqOL1jaWITQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(261102123227099003)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 45XX3u2OWn25PwzqBfBNBBllsTc+Aq/JtYZUw7v8TZgDOlZyeqOOJu8zDu87XOn1YS9Qk7Cg9uhxg0275lcrYiOBFuoMQ0KINfHVhjRN6l71Al3OpwdgtcVWxM6R0Q80iL+p0d80KNfYwVSdLvIqAQAR/lRo4LPQbnIdAm6s6IUM5UR1ISugKA6X9hLM6TdMhiOQNovV+fDhpj7ysjAKw7jMw3LtRYg+usQQrm6ijG+9jOBPlG7r3cuAZhRLUEA8iV47ihPm9pJSYYKjUBsfzjdt+182y0I40DgS3qNabqqWjE8vCNJx7Bs7+QP25eEIs15hia5Nt+O8pcHM1ez6aXrQc7T3/g0tsgyobb9y5/dYYdLcsWnGR/9jrLhzNQLmmTk9jrlMM74QLO0qdt4lJniyAsia0RCG1w+AS7CmmOjreUHHS8AJ7mPtLB9Yv/KK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 01:40:39.2395 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248ed885-b05c-4a1a-6f2c-08df3f94ca5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A805.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9039
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Eric Bernstein <Eric.Bernstein@amd.com>

why:
DPP60 is shared by ASICs without a UPSP block. On those, UPSP register
offsets are 0 but masks may be non-zero, causing writes to address 0.

how:
Gate UPSP register access in DPP60 on the CNVC_UPSP_MODE register offset
instead of the field mask.

Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c      | 2 +-
 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
index 2ba8218e2ac2..dfdbc539ac42 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
@@ -321,7 +321,7 @@ void dcn6_dpp_reset(struct dpp *dpp_base)
 	struct dcn60_dpp *dpp = TO_DCN60_DPP(dpp_base);
 
 	if (dpp->scl_data.upsp) {
-		if (dpp->tf_mask->UPSP_MODE) {
+		if (REG(CNVC_UPSP_MODE)) {
 			// Reset dpp registers used for upsp, lls
 			REG_WRITE(CNVC_UPSP_MODE, 0);
 			REG_WRITE(PRE_CSC_MODE, 0);
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
index d1a81e5616b3..b75eb2772799 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c
@@ -288,6 +288,10 @@ void dpp60_dscl_program_upsp(struct dpp *dpp_base,
 {
 	struct dcn60_dpp *dpp = TO_DCN60_DPP(dpp_base);
 
+	/* UPSP block is not present on all ASICs */
+	if (!REG(CNVC_UPSP_MODE))
+		return;
+
 	REG_SET_8(CNVC_UPSP_MODE, 0,
 			UPSP_MODE, dscl_prog_data->upsp_mode,
 			UPSP_V_NUM_TAPS, dscl_prog_data->upsp_v_num_taps,
-- 
2.43.0

