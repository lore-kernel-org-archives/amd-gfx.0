Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0350C54E67
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Mar 2024 06:37:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EB9310F038;
	Wed, 20 Mar 2024 06:37:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zdEkN+oh";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6690310EEF8
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Mar 2024 06:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4vB1nARJR2tTq3CFe2HPrwUdJMF54S765PCSHN6PF1hXqcU1r9Hge0SEDwv3Ty6PnPpLsBy910h81UxkVgtj8Woakvla1ca253s/hBvdy9a7QOSduOdSJQvOdthgaH8JXF4oRSJlboWepTWaknABLdiUkKOopfyfrq3UiK2j18c40fbG80gdDJmVkhf9RwfO/dqr67qE5KRPg/g+K4f1jpdXhQBBV7i9Yh7YIMWIlKsrkVMc9HMWcwpZdcOOH/g/sKv30ykRLS4iCbPEiJAhJhZYq5KCrFRaSiIb6xqY3PN2KEJjZvCQOGq6N0EN3M4BoGAto8+Hk5GtwS7zXYB0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKEI+Ibyt2jIh4HVEmbTIwGNG27W0la9rFOMTKG4iwI=;
 b=gRjpp60Vtc1YTyEtPcWPr81M2uiwPsIZ5qMd2h7al6QhNNbgSE67BrAI9nDB93cBTa8hxQZddF03brvhWcuN1ZFkjG81aDMDvqGpqFjQDa1NJiNpXMIeXYKvRpay0pzh/1YaEpujCPLXhAgbZzethqh6T02HWy6aGV8kjRNbanwetCGvwqD15sbhR1qqsfc8wSPFLFfp9nPGfcVYTnctgJlh09mO5F0SqqAr9msri6LyvxobCjJSwhQiDt0wHCOvS4UdeEeU2W28Cb+KU2pnRFFpJMnIRGKK6+M0q1u2tfiYLmmanN54x6pysaAijMTzXocYdWlV+tVw8K/V4QNVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKEI+Ibyt2jIh4HVEmbTIwGNG27W0la9rFOMTKG4iwI=;
 b=zdEkN+ohFDktmZM9lfrvgUPFoHVeIr2R1CEMnbctn9zWo5L2eN5haepP0rrJA5HqQn1W8P9+0qGx4GOa7aFrBduHfGFfg0niQiu6G+J+i70eoUpVwtGzYA6liryHVUVaxXaDzoQb0k92PlGYBtl58zWysVrG9tnelYr0oKTKvXA=
Received: from BN9PR03CA0516.namprd03.prod.outlook.com (2603:10b6:408:131::11)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 06:37:22 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::4f) by BN9PR03CA0516.outlook.office365.com
 (2603:10b6:408:131::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 06:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 06:37:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 01:37:21 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 01:37:18 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Chaitanya Dhere <chaitanya.dhere@amd.com>
Subject: [PATCH 19/22] drm/amd/display: Modify DHCUB waterwark structures and
 functions
Date: Wed, 20 Mar 2024 14:35:53 +0800
Message-ID: <20240320063556.1326615-20-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
References: <20240320063556.1326615-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: a553502b-f6db-4e16-c6f5-08dc48a832a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7tngJX9oM6Tqitphnn1TTlrqwex9hdjtK6W6qM7Kpp3kdaTAVIDgXXfYZVCtFlD6UviojoszjZRzIzS28p2pluODlPC1gdJRaXb00cnG28lDwSTxuCRamQqnpTzloYVA4ZFSieNxgbegEZ5CibH4K4fbgvT9O1Fgakj/YS81h8Cnhpb6biPgz38gsZNQGidRWJKU1FtWHVRgKkq2wmHEJ2eWzhiHrDnfErJTHh/8MqfcBI8j16t9T5eIw9m69oZs63JpKKScrZU8qm8Z7Nuywy/q6wfkVdgz3LfhCgio6+b8B4H+I93K9tq6ZD70M56XgUUyLA5OaPe3SNNojlbwL2Nj7W74CzZNygKj28pfMXM/ktEdL/0bnh9pFEdfsgxXnN4HtLUPtJ46i+0oMUFJkBaanPLgzFgP8gsouUea9YT053zdR8NGr6pTG2EJWTh7wWIQhj2i06xtGSU/Nsrbne315T6XhQzZ1Gs7SszdtLTeNkh66LJ2+C6nZvW66Ci4y/LTTptlFjjLc5appaZrL4ZNjnUjsfzmLa7tgCfLE4aacJdtzqpKCR5eVDzcufFXSRAMsdATYF73lvp58zJElnU5y4HfTl6ZUZ8h/4cG1AQr1Ga4gTLqZIE+jU7Vag4ooPff9wN5EwiFJok70PyfS7xLINfQ0gzUSSyEo5te1bHYNKe+3f/tQFuU7rj6QpqCoXw+xqQvukMq4vRujzfjoZYXPgLM4TsDJTY52glMN+jBH57aMFQhIqmKBUS/Lr6J
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 06:37:22.0664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a553502b-f6db-4e16-c6f5-08dc48a832a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
Converting the watermark set structure to a union and modifying some interfaces
to accommodate future usage.

Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c  |  8 ++++----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h  | 10 +++++-----
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h  |  2 +-
 .../drm/amd/display/dc/dcn201/dcn201_hubbub.c    |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c  |  8 ++++----
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h  |  8 ++++----
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h  |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c  |  8 ++++----
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c  | 10 +++++-----
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h  |  8 ++++----
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c  |  4 ++--
 .../drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c  | 16 ++++++++++------
 drivers/gpu/drm/amd/display/dc/inc/core_types.h  |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h |  2 +-
 .../gpu/drm/amd/display/dc/inc/hw/mem_input.h    | 12 +++++++-----
 17 files changed, 56 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
index d51f1ce02874..d9ade9ee0aeb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.c
@@ -242,7 +242,7 @@ void hubbub1_wm_change_req_wa(struct hubbub *hubbub)
 
 bool hubbub1_program_urgent_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -356,7 +356,7 @@ bool hubbub1_program_urgent_watermarks(
 
 bool hubbub1_program_stutter_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -501,7 +501,7 @@ bool hubbub1_program_stutter_watermarks(
 
 bool hubbub1_program_pstate_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -582,7 +582,7 @@ bool hubbub1_program_pstate_watermarks(
 
 bool hubbub1_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index 4201b7627030..d1f9e63944c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -409,7 +409,7 @@ struct dcn10_hubbub {
 	const struct dcn_hubbub_shift *shifts;
 	const struct dcn_hubbub_mask *masks;
 	unsigned int debug_test_index_pstate;
-	struct dcn_watermark_set watermarks;
+	union dcn_watermark_set watermarks;
 };
 
 void hubbub1_update_dchub(
@@ -423,7 +423,7 @@ void hubbub1_wm_change_req_wa(struct hubbub *hubbub);
 
 bool hubbub1_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
@@ -446,17 +446,17 @@ void hubbub1_construct(struct hubbub *hubbub,
 
 bool hubbub1_program_urgent_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 bool hubbub1_program_stutter_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 bool hubbub1_program_pstate_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
index 6eebcb22e317..c6f859871d11 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.c
@@ -570,7 +570,7 @@ void hubbub2_get_dchub_ref_freq(struct hubbub *hubbub,
 
 static bool hubbub2_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
index 2f6146bf1d32..24a9c45988ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubbub.h
@@ -85,7 +85,7 @@ struct dcn20_hubbub {
 	const struct dcn_hubbub_shift *shifts;
 	const struct dcn_hubbub_mask *masks;
 	unsigned int debug_test_index_pstate;
-	struct dcn_watermark_set watermarks;
+	union dcn_watermark_set watermarks;
 	int num_vmid;
 	struct dcn20_vmid vmid[16];
 	unsigned int detile_buf_size;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
index 037d265431c6..09ea65acb2c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hubbub.c
@@ -52,7 +52,7 @@
 
 static bool hubbub201_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
index aeb0e0d9b70a..2546224b326a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.c
@@ -140,7 +140,7 @@ int hubbub21_init_dchub(struct hubbub *hubbub,
 
 bool hubbub21_program_urgent_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -334,7 +334,7 @@ bool hubbub21_program_urgent_watermarks(
 
 bool hubbub21_program_stutter_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -487,7 +487,7 @@ bool hubbub21_program_stutter_watermarks(
 
 bool hubbub21_program_pstate_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -573,7 +573,7 @@ bool hubbub21_program_pstate_watermarks(
 
 bool hubbub21_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
index d8eb2bb7282c..ab2ce0313529 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubbub.h
@@ -127,22 +127,22 @@ int hubbub21_init_dchub(struct hubbub *hubbub,
 		struct dcn_hubbub_phys_addr_config *pa_config);
 bool hubbub21_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 bool hubbub21_program_urgent_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 bool hubbub21_program_stutter_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 bool hubbub21_program_pstate_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
index 152c9c5733f1..6a5af3da4b45 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.c
@@ -95,7 +95,7 @@ int hubbub3_init_dchub_sys_ctx(struct hubbub *hubbub,
 
 bool hubbub3_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
index 7b597908b937..ca6233e8f1f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hubbub.h
@@ -124,7 +124,7 @@ bool hubbub3_get_dcc_compression_cap(struct hubbub *hubbub,
 
 bool hubbub3_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
index 5b5b5e0775fa..b906db6e7355 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubbub.c
@@ -172,7 +172,7 @@ static uint32_t convert_and_clamp(
 
 static bool hubbub31_program_urgent_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -362,7 +362,7 @@ static bool hubbub31_program_urgent_watermarks(
 
 static bool hubbub31_program_stutter_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -635,7 +635,7 @@ static bool hubbub31_program_stutter_watermarks(
 
 static bool hubbub31_program_pstate_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -717,7 +717,7 @@ static bool hubbub31_program_pstate_watermarks(
 
 static bool hubbub31_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 88dfc907553d..515c4c2b4c21 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -167,7 +167,7 @@ static uint32_t convert_and_clamp(
 
 bool hubbub32_program_urgent_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -357,7 +357,7 @@ bool hubbub32_program_urgent_watermarks(
 
 bool hubbub32_program_stutter_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -503,7 +503,7 @@ bool hubbub32_program_stutter_watermarks(
 
 bool hubbub32_program_pstate_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -656,7 +656,7 @@ bool hubbub32_program_pstate_watermarks(
 
 bool hubbub32_program_usr_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -750,7 +750,7 @@ void hubbub32_force_usr_retraining_allow(struct hubbub *hubbub, bool allow)
 
 static bool hubbub32_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
index f073839a4b6d..e439ba0fa30f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
@@ -118,25 +118,25 @@
 
 bool hubbub32_program_urgent_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
 bool hubbub32_program_stutter_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
 bool hubbub32_program_pstate_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
 bool hubbub32_program_usr_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
index 339bf0c722dd..6293173ba2b9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_hubbub.c
@@ -111,7 +111,7 @@ static uint32_t convert_and_clamp(
 
 static bool hubbub35_program_stutter_z8_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
@@ -297,7 +297,7 @@ static void hubbub35_get_dchub_ref_freq(struct hubbub *hubbub,
 
 static bool hubbub35_program_watermarks(
 		struct hubbub *hubbub,
-		struct dcn_watermark_set *watermarks,
+		union dcn_watermark_set *watermarks,
 		unsigned int refclk_mhz,
 		bool safe_to_lower)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 1530b1f8f8be..f983041ce9a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1910,9 +1910,11 @@ static void dcn20_program_pipe(
 			dc->res_pool->hubbub->funcs->force_wm_propagate_to_pipes(dc->res_pool->hubbub);
 	}
 
-	if (dc->res_pool->hubbub->funcs->program_det_size && pipe_ctx->update_flags.bits.det_size)
-		dc->res_pool->hubbub->funcs->program_det_size(
-			dc->res_pool->hubbub, pipe_ctx->plane_res.hubp->inst, pipe_ctx->det_buffer_size_kb);
+	if (pipe_ctx->update_flags.bits.det_size) {
+		if (dc->res_pool->hubbub->funcs->program_det_size)
+			dc->res_pool->hubbub->funcs->program_det_size(
+				dc->res_pool->hubbub, pipe_ctx->plane_res.hubp->inst, pipe_ctx->det_buffer_size_kb);
+	}
 
 	if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw)
 		dcn20_update_dchubp_dpp(dc, pipe_ctx, context);
@@ -2073,9 +2075,11 @@ void dcn20_program_front_end_for_ctx(
 			 * turned on (i.e. in an MCLK switch) which can come in too late and cause issues with
 			 * DET allocation.
 			 */
-			if (hubbub->funcs->program_det_size && (context->res_ctx.pipe_ctx[i].update_flags.bits.disable ||
-					(context->res_ctx.pipe_ctx[i].plane_state && dc_state_get_pipe_subvp_type(context, &context->res_ctx.pipe_ctx[i]) == SUBVP_PHANTOM)))
-				hubbub->funcs->program_det_size(hubbub, dc->current_state->res_ctx.pipe_ctx[i].plane_res.hubp->inst, 0);
+			if ((context->res_ctx.pipe_ctx[i].update_flags.bits.disable ||
+					(context->res_ctx.pipe_ctx[i].plane_state && dc_state_get_pipe_subvp_type(context, &context->res_ctx.pipe_ctx[i]) == SUBVP_PHANTOM))) {
+				if (hubbub->funcs->program_det_size)
+					hubbub->funcs->program_det_size(hubbub, dc->current_state->res_ctx.pipe_ctx[i].plane_res.hubp->inst, 0);
+			}
 			hws->funcs.plane_atomic_disconnect(dc, dc->current_state, &dc->current_state->res_ctx.pipe_ctx[i]);
 			DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index a66676c00c6c..3f6876aafee0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -499,7 +499,7 @@ struct dcn_bw_writeback {
 
 struct dcn_bw_output {
 	struct dc_clocks clk;
-	struct dcn_watermark_set watermarks;
+	union dcn_watermark_set watermarks;
 	struct dcn_bw_writeback bw_writeback;
 	int compbuf_size_kb;
 	unsigned int mall_ss_size_bytes;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 2ae7484d18af..305fdc127bfc 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -160,7 +160,7 @@ struct hubbub_funcs {
 
 	bool (*program_watermarks)(
 			struct hubbub *hubbub,
-			struct dcn_watermark_set *watermarks,
+			union dcn_watermark_set *watermarks,
 			unsigned int refclk_mhz,
 			bool safe_to_lower);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
index b72fb314d804..86c12cd6f47d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mem_input.h
@@ -50,11 +50,13 @@ struct dcn_watermarks {
 	uint32_t usr_retraining_ns;
 };
 
-struct dcn_watermark_set {
-	struct dcn_watermarks a;
-	struct dcn_watermarks b;
-	struct dcn_watermarks c;
-	struct dcn_watermarks d;
+union dcn_watermark_set {
+	struct {
+		struct dcn_watermarks a;
+		struct dcn_watermarks b;
+		struct dcn_watermarks c;
+		struct dcn_watermarks d;
+	}; // legacy
 };
 
 struct dce_watermarks {
-- 
2.34.1

