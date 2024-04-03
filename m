Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 787ACCD129C
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:52:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937CF112E8D;
	Wed,  3 Apr 2024 19:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1mLNiIn";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69A37112E85
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqDxbs40eC/SI99h1LsvcyOhUPzhRckyYmegc7ZWoLzp0OUmLHnvocwpEAOCSc4MrOJNNMyN7pXnY5mHoy9s/3KeQlxi9ZOaa2+UqQo9D43cCqdPpzP/yqn7vMxoe6BRmgjxutQje8WYxxIfIFDGxgSJzANi3gEAf+wtiNbmdQ1m59EwOapcFrmZKXkuyfiedEVqV7cjyhFZCS/Y8c5aSK/FP67CKKG/axoYzinm/sytVIu3t7KMjtXZUgp21IWZFd3kL9gMAlBLSelMUn1ZKDxEu3YGM00wvrzrnJyNM6lCt2yqXwsQIKHj7563fwm1+Yh2NK10ymwFBpc2Ahq9HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csF+0lxhlVwCtEiuN5ZMkgDSd+2vXA6PEGlgK/8dZPo=;
 b=XgNW5W+oJbhsNZXTmZHBU7GLxuu3kvLyBRvWMppkWrkmAUzYkJa0r9ZFaVSTu7bWm8BixWzoLTJ9u0s3cFXg/FAlVZC+whY0NDUv7SDMAnf0QspBH8r3vM6XYaQpdhcRud0feR0TBkXgUgcsQcWc29z4KA4nUkk5NnyM1prnDGESYGWRneE042y1kw8B6+R0pm1Z1BVJ2/2i1cd/UX+st8/wAn4dx5aMjESEbTqAktG9WORYJW38yttdS/YfXNYCxcNc2zlPfXeVWUbCd4FKSrUIU/0/onX0ZsYPKxgHuuskIB2BApA6epuBV8li3Wo+d045KAd2FdOlEtmy65GBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csF+0lxhlVwCtEiuN5ZMkgDSd+2vXA6PEGlgK/8dZPo=;
 b=v1mLNiInGq0XvKlBf+LOBH85rT8bQht7spTL3Huq36qL5k0Bj2bl7ZP3FEPV3mJ2I9wi/hIK0k5mBptUaZ9XHZbqM5oStwyvQdga2TmEY3Q63KZl2RZU5Vf4ynjfci+xwJiSiDQJoOafMtsIuYODLZqUzy4CwoLFPS2wjaTqyKQ=
Received: from CH0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:610:74::7)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:55 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::bd) by CH0PR04CA0062.outlook.office365.com
 (2603:10b6:610:74::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:55 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:53 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH 27/28] drm/amd/display: Reorganize dwb header
Date: Wed, 3 Apr 2024 15:49:17 -0400
Message-ID: <20240403195116.25221-28-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7656d6-5b13-4f18-48d4-08dc541783c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ns+q63LRNDf0boMRFx8PRgCvN8dSs7plnDP/P2DY9/ug5NBgECBx1dWcLEsiIGws04A4yGx7RgUgyFAOv+79bfha236QX/hzQcojl+aus43KIuc4RDhUV2JVdOgxHycIvoKxSy8fsH45MHXdSG2QUzXmrK8gEc6C9f065PbVOCz0iHZc/diwCYkWIoGq6sbENGx1lgiJF3srDWBLG9zp/9Gop1p5ygwYM2mB/0ijfH35FEDLHPaOlUqBqutXEUlVeoXZgor+EdYPypSE41EvgDeVzPbYZFyU3NglVRyVIp6Q+YnqRTgToPnLcE14Nbl6haJrS0UcUwkPK0TBFhSo1aIqd/l2ppkti2c1sB0XSfLrRvu+kIqx9EEzVipsH7mTNErLjpq2eIvWeIpQ1RwLnp615adWyZXCG8TWRF5SNcExbSCHhWhsOiS2Y3W4Pc+I+JpeHZYnHEyEHKEzLZeQ/oSw4Av0lg45XX2K5+24ZmnyJEqB2f+RGyXSDCXhSqv1zT4/T2gmk8c+dB+xIChFC+8v2M2336tKUMnVdh6MB7LqFbKOBCtF1wQUhQ/5O5XuEtquXFCnuU+odUQtIEG6pdUUYHKqJ2zHQf2eakMaQBbmrNvSR8vVfFbXN3aJhr98YFrrRseauJM4uA63qgobV6wHpq3xHC/NnAzBWjNZAnTCqXssBBVXqTB6S84bCNkosmDIYqE0OP1Xi3attOgxbTHcLmNf/1r2RYzojk+53ZwESY6eYQGG2/yT5kjluVMS
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:55.0646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7656d6-5b13-4f18-48d4-08dc541783c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit makes some small adjustments in the dwb header.

Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h | 30 +++++++++++++--------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
index 729ca0064e94..063efc8128a7 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dwb.h
@@ -147,9 +147,10 @@ struct dwb_caps {
 		unsigned int support_ogam	:1;
 		unsigned int support_wbscl	:1;
 		unsigned int support_ocsc	:1;
-		unsigned int support_stereo :1;
+		unsigned int support_stereo	:1;
+		unsigned int support_4k_120p	:1;
 	} caps;
-	unsigned int	 reserved2[9];	/* Reserved for future use, MUST BE 0. */
+	unsigned int	 reserved2[10];	/* Reserved for future use, MUST BE 0. */
 };
 
 struct dwbc {
@@ -166,8 +167,9 @@ struct dwbc {
 	bool dwb_is_drc;
 	int wb_src_plane_inst;/*hubp, mpcc, inst*/
 	uint32_t mask_id;
-    int otg_inst;
-    bool mvc_cfg;
+	int otg_inst;
+	bool mvc_cfg;
+	struct dc_dwb_params params;
 };
 
 struct dwbc_funcs {
@@ -192,6 +194,10 @@ struct dwbc_funcs {
 		struct dwbc *dwbc,
 		enum dwb_frame_capture_enable enable);
 
+	void (*dwb_set_scaler)(
+		struct dwbc *dwbc,
+		struct dc_dwb_params *params);
+
 	void (*set_stereo)(
 		struct dwbc *dwbc,
 		struct dwb_stereo_params *stereo_params);
@@ -205,9 +211,11 @@ struct dwbc_funcs {
 		struct dwbc *dwbc,
 		struct dwb_warmup_params *warmup_params);
 
-
+	bool (*dwb_get_mcifbuf_line)(
+		struct dwbc *dwbc, unsigned int *buf_idx,
+		unsigned int *cur_line,
+		unsigned int *over_run);
 #if defined(CONFIG_DRM_AMD_DC_FP)
-
 	void (*dwb_program_output_csc)(
 		struct dwbc *dwbc,
 		enum dc_color_space color_space,
@@ -216,17 +224,17 @@ struct dwbc_funcs {
 	bool (*dwb_ogam_set_output_transfer_func)(
 		struct dwbc *dwbc,
 		const struct dc_transfer_func *in_transfer_func_dwb_ogam);
-
+#endif
 	//TODO: merge with output_transfer_func?
 	bool (*dwb_ogam_set_input_transfer_func)(
 		struct dwbc *dwbc,
 		const struct dc_transfer_func *in_transfer_func_dwb_ogam);
-#endif
+
+	void (*get_drr_time_stamp)(
+		struct dwbc *dwbc, uint32_t *time_stamp);
+
 	bool (*get_dwb_status)(
 		struct dwbc *dwbc);
-	void (*dwb_set_scaler)(
-		struct dwbc *dwbc,
-		struct dc_dwb_params *params);
 };
 
 #endif
-- 
2.44.0

