Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F791C43458
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B2710F6BD;
	Thu,  9 Jul 2026 21:02:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4kU3x2Zb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9A610F6BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfQALMLkDMcWPfmjFXrXNxEE/MRI6am8DvBi24JhNz7aLmlohppbrx8nxnY+UgxEGP1oawZAP5nJsaQLCR+E3g490SZ4QoFWQLCvRFMa/+jklVaikvYOyE0NHZx/r1UD7P/STa/wPiM9C80C+cXrZbpYeMNnfi0iscOVxvJR5oCdkTEXsVakyiqvtSTK7K4YL1zer8dxieG6bIaSvsIESsUK4OMIHNyouRj5/fgYze06Q9oRGpwTZCDtoEmtwPEmHVVehlOA5Ff+pO4KIbv0hU2TRMZAbMCsFR/vMOEJtQQz1WGipZ5MDmmtMmX/k2o6LgtvMtd1TasOtBmXoh5ZPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KRDdjV1VvTaS4Ac79c7OiLTFKi1bZtYRKyQrviccaY=;
 b=AVWSc/wUwL7w0N7IEnxki5x+Axbos8eLu7ae3VGpanGwrBfgWhfjaiFEUWPip3qTYCab1oUacKSFL+ffaiAl1q7dGuZg6JSr4I6fcJUBn+X9YWOzaXmDpdP2+/b268xC9XscIRO2sWDkZoFvgCdRbaRxmt5e6qf5CIW64oTGq4gtyKNo2SBWSwO/wjdukqjPrMaEwl1W2di/VWgv45tIVy/0XasUBfe3BGxL9WXe68WBcJAUvM0LYahg/+8ShGPIUXK/QrY0LtYKfXLONTeqGBtXAIdWTw6pNAmpK4cXLfREd7b8iiCuIyWRdJMyNjqzwUtFkm7F71sNnEUETefbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KRDdjV1VvTaS4Ac79c7OiLTFKi1bZtYRKyQrviccaY=;
 b=4kU3x2ZbzCmUmAKRunxM/A9L0bGviV9kf/0Tpm/AZgMZ/Mf+EZv2MGhV51S8VH4u/yIswKzp11EDoAUh2Q7W1ePexySNo8nS/1lXNortPquGwvZ2Pboq0sWowjjefXhHkteRaAcd8GIwQQKlpqajrTY58ElhJSXsEQc3KyfNySQ=
Received: from BL1P223CA0038.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::7)
 by IA0PR12MB7752.namprd12.prod.outlook.com (2603:10b6:208:442::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:02:07 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::9a) by BL1P223CA0038.outlook.office365.com
 (2603:10b6:208:5b6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:07 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:47 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhuvanachandra Pinninti
 <BhuvanaChandra.Pinninti@amd.com>, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 George Zhang <george.zhang@amd.com>
Subject: [PATCH 16/80] drm/amd/display: Fix dc_stream_remove_writeback
 dropping wrong writeback entries.
Date: Thu, 9 Jul 2026 16:47:44 -0400
Message-ID: <20260709205936.5719-17-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA0PR12MB7752:EE_
X-MS-Office365-Filtering-Correlation-Id: 87b548a5-0ccb-4345-fc08-08deddfd55ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: aoJQSjlUuDJEvHL6sA4TfWtQ8BHT/ejGvFRDSpCKjIAwS+f+EZq+K1XVWnPhyu1JgkwiebOD4Qw27mhgAt2j7NFzyEaasc8fannNFC7sWNgPdAVsSUdnTsIngnBUjJwJ7/dSVChNp1FOpcP+3tYame0qJsrpn7nMlpqFnmjEHk0dSYYGN8JzStrXW7CBtz3mBmtue5puz2DbEOmD9NfCd1CTcbn2B8qPxGDt/iKtIoRLMak7rNp0wgQCGhFADDhlQGbuLfv/leiNbLN3dB/LUu5X+COaModliBbkSQ3CQWuGWCEefrMmVQC2iyTb0ZQ5o6jWRFJyB4Cj9UIbMEWn9El2cQwONItVfeEbOih1a6EmLk8kA2wKsIBRvgWBwcBqkeOpTECC2WhBacgKoTHza1Z1vqwHZokX/jyaR+TXRaLP8gyMapRSSr19z2VGjrVU5Fndcaf3rY5K6nNRzwluF86eYnJJPFuBhXLzpISDRZzCwbGRjC7Oi86XpV2j36HT6zjGtef9stheuAgoXVLg38NbL5PM3bsdKEOE4Y8wxCF+XoeoemtIwaMhawIeJESzYQ71jQmFgH8Ed9P7Ue86GpagPQ1AleZda448rseaL3httoZAmbwf3GAw+Zr5YzcXQVQocN2KIwdZWoryafFA1tiRr7N2uSUQyrxctbzbjD5MbpM+1TbKF/fy2VUrW56g7cM9XxzeNgbm2qru1pkQwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iWfVjw+MtwrRGP0oaM3FL1mNd/q+vXmfCyL20g2YJEqUIzbkCSibXhE85nd5unlcE5SgKAnYKoV33u7v7usgwI2zRsECNUZBHG6UCKWGw/SIpUb/5VSu+xHfpkWm96N0qgbF6/ab+dX9mWf5uXj3O7kEn1RTWufC1NFvE+hRTcduD8I/sSCtYg/W8yJyHucsbT2vcNrV9b6A9SrSoUe9gz0pM5at5SNb/N+B1KhsEQy73ENePHzNjQK7HTLOoisSABOd6XIypFGaCPaj8dBAkXuUch/VuNkBWtZIucpk5+p/o+V4rOcIkq/XJTc/MaOaLBX85MPG8fc94NsuZJZxc775Aox0w4GhE1gLmUq0VmV0azUiPNCfwe6Yy4s5jPU7ve00PBSoDq7QCy9OpLNsJUgPcKTctm7bocB1NIWq1whXoLMlfo7HDkJNfHJ0S2b8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:07.0816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b548a5-0ccb-4345-fc08-08deddfd55ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7752
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

From: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>

[why]
The matching entry was disabled but still copied during compaction, so a
removed pipe could survive and overwrite a valid entry, leaving num_wb_info
wrong.

[how]
Skip every entry matching dwb_pipe_inst and compact only survivors. Covered
by test_dc_stream_writeback_drc_and_remove.And added new test cases for coverage.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Bhuvanachandra Pinninti <BhuvanaChandra.Pinninti@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 21 ++++++++-----------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 1b2c22545be3..ce045ef6347c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -720,20 +720,17 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		return false;
 	}

-	/* remove writeback info for disabled writeback pipes from stream */
+	/* remove writeback info for the requested writeback pipe from stream */
 	for (i = 0, j = 0; i < stream->num_wb_info; i++) {
-		if (stream->writeback_info[i].wb_enabled) {
-
-			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
-				stream->writeback_info[i].wb_enabled = false;
+		/* drop every entry that targets the pipe being removed */
+		if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
+			continue;

-			/* trim the array */
-			if (j < i) {
-				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
-						sizeof(struct dc_writeback_info));
-				j++;
-			}
-		}
+		/* keep this entry, compacting it down when earlier entries were removed */
+		if (j != i)
+			memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
+					sizeof(struct dc_writeback_info));
+		j++;
 	}
 	stream->num_wb_info = j;

--
2.55.0

