Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9129C2BA16
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90BBE10E6D1;
	Tue, 11 Jun 2024 16:53:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U1UkdSYa";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4462B10E6D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFROobd40YLIsJXlK5anC5yAH0h1StN3n27x6ThYVyEH8OfMbdoOZOeW9FHsZjEoAPpff2RfJvb1bKXqlFe3LcXVBOuz95WEO1ii7Ml5T5bwyn+cfV6WCY9bCSMQm7PmnRsCBVdIsTdkUIxgz9m7oXouCdg45qLax692IrsED3wwbYD8Azvm17fz8tI5s/QvFHsDFEgeahcFcqrxUMrR1xJJ63oi+3RtA1gnT8Bb1RiveZUdE0fGEgFV8GEgtovRv9ut8m00o4k9v3CfMQ+RGf3IeNWCgTEODHDz6/0tp9/p5U6wuaF1OAqUnVIVca1UBecY5eDfKRhpyGXlp3q2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f033tfPS2sCEgRl1WAK9UgnURi1y2YUZANQK6BIMIE=;
 b=aetV8DEIADp7IxInaC3tIkjbeX1qY6XFAbrohIAdnXI06McDktbAbemiFDMK6aLhwaHjULiMwy9pjH5zvkmA/oyiRFiH0iAY2Bqc3XUVpdtgHngjD/owkGWIyy2DlSNksFDngCFhqJb4NECssgdVIJvx/QdyIB06NMVaHRR6M2r5c2i+tvsRSBSZRKb2RA3WwH92EtO25s1wwz51FsLfolFm5TQY/Yx2XVuevL+CmVMwCHsV+Bh+tKseYWQKBbkGrXC9srJLyjzvQtfM3Bum2KHllElSsCXBTHUGy8rpv7FagTIw5tzDKcfQaNppQXqoaMaJFzln/B5lykJ5fAEz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f033tfPS2sCEgRl1WAK9UgnURi1y2YUZANQK6BIMIE=;
 b=U1UkdSYa1XCqJW3OAiE2dWpUK16MAuH84pNW4/i8JzEanwU9xO6zteLJaY2hplBRKohB58en4dOEsgcA/lu+QlUMKWJxqOeOW5njYcGmWcV8rUA00SufffCb3/gbF+8FOXUKeRDsa76v3X6qdvYVTKMkG0CoBd/kqAhL1WbBZFo=
Received: from BL1PR13CA0154.namprd13.prod.outlook.com (2603:10b6:208:2bd::9)
 by PH7PR12MB5656.namprd12.prod.outlook.com (2603:10b6:510:13b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:52:52 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:2bd:cafe::1a) by BL1PR13CA0154.outlook.office365.com
 (2603:10b6:208:2bd::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:51 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:49 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH 32/36] drm/amd/display: Remove redundant checks for context
Date: Tue, 11 Jun 2024 12:51:35 -0400
Message-ID: <20240611165204.195093-33-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|PH7PR12MB5656:EE_
X-MS-Office365-Filtering-Correlation-Id: fba1a197-4efd-4ad5-06e0-08dc8a36eed4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6lB4izE5JHNbHuvs8jnrgnRIXMf09axaB+qgd34lG7bCQSD4QEkUF4ZYjfk8?=
 =?us-ascii?Q?uxDjxtk/Mv6zC25rQiXnZhH1g6QqzgEdKw3de9omwshyhew99USPBRavkXkX?=
 =?us-ascii?Q?PG1QW0bWJdpehouqVcwdXNPj/fYxOBfDglvJrt/Fj0K98rjJJU8N361U7LXP?=
 =?us-ascii?Q?Pah2ynM2UkrgtROM9d2JqyRT5aboSE0011ffAoMpWtz0PEaeI1vE+M+05MVQ?=
 =?us-ascii?Q?BYpptHR9O0+7uHZUemG3F7+dL0wd1kH9H5iPLJNX04Ey7Je9FGRYVVvlWHtj?=
 =?us-ascii?Q?87ZxgIa2+rTHG3WbyNCYmeULmkX8ldZUGtPMme0r5nw6bqJJWCY393ROD2QC?=
 =?us-ascii?Q?DB4AKDP/9/yBh/8yNDuD9dkuPag0/b/cQkZE2wzmTaGTVnX9L1cijYO3/3oZ?=
 =?us-ascii?Q?zD3b8c7g+MJc5K30nTbK+vq75/ByCoYsQy7oelKdFTk0dOBFMDLrhtmXvuZz?=
 =?us-ascii?Q?esDF4aBgj+q7gRF6PyZZAxczWG9oWrY35RRsPFXWkFPqac7xW8CJTfQJGlm6?=
 =?us-ascii?Q?4QQBaYkZ2n1ijCzfYwNZg2j8/oSqDlPeLWE/1uwf4BAGwr9Ap/L5HXxWLs1Y?=
 =?us-ascii?Q?pbOiCbzH7+6WR497Yf/GRxPDtTKfttxWccVtptZ2x+QiYcV76oWOclt4CbtV?=
 =?us-ascii?Q?OCvgdWLbbiTT2bZ+7JqSB7OwCKtHTEigHrdQ6sOz7ZYExTJ7AOfZCsyNxvWO?=
 =?us-ascii?Q?ZTKAVw0S5jEaspTYCuUS3GWo9OYp/a0/9QWamPHKxcuh9laNa9/M+tuZXpN4?=
 =?us-ascii?Q?OOaUfVpSsfYb6DL8T/sBaPX5LwIsJ/bywhY//aujzV+p/ln5RfJDj3gJMsk1?=
 =?us-ascii?Q?n040V8aiJTvMACSgulpDPPb4K/Pd8i1TgMIcAi8ph3PlGwuyYk4RJSVEjWl5?=
 =?us-ascii?Q?QLfmqmYSHpM8LYj3gkdAjFGQgekf60J0I8z5DojBAdXoR5LSuGZEC5fVoH+7?=
 =?us-ascii?Q?AgINQBvHREJbbPcnN/aD7tT6SZ2G1ISe9KV+7q7m1gosuOPXb94WFjDQ+TGD?=
 =?us-ascii?Q?tqLKdUH7zWh/2c2toptXo7rZXfe+CqiSDtf3I+j0PRAU2WRtk9O2TqqI80om?=
 =?us-ascii?Q?9sTa9v3z5BcI+PFRlBvQHorA1QiunG9ofU+OK/twFF4VPzVm0z96EBbBRonN?=
 =?us-ascii?Q?ttHU1Z7JxApKeZL/iyhD4qwhJvmJ4TM/Nq5pWSSbDuYQhxFPEEJIhunOkaMY?=
 =?us-ascii?Q?CjGXyQCW0PBObGnjRUDUBWW5wwoCZCwS3Khtn+DFfLGiD6UxxiEXnCz5FYy1?=
 =?us-ascii?Q?qcV/enuQaizC28SvsDzrzmIOara6wh/vC0pkSfBLu/CgTVAl8gT3j3VAzebG?=
 =?us-ascii?Q?eTxA2MDxjMUjBKm0E5GY1Oun5vj4SpX3qXvF96zfxDuqm0WfwIfbYTZzlHWl?=
 =?us-ascii?Q?ezuKNlvAYSdpVfdnwjy844rzkm0MMGSzz8S055buWdrA1aAk3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:51.7476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba1a197-4efd-4ad5-06e0-08dc8a36eed4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5656
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

From: Alex Hung <alex.hung@amd.com>

The null checks for context are redundant as it was already
dereferenced previously, as reported by Coverity; therefore
the null checks are removed.

This fixes 2 REVERSE_INULL issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c    | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 33318a112282..5037474bf95c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -505,7 +505,7 @@ void set_p_state_switch_method(
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 	bool enable_subvp;
 
-	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !vba || !context)
+	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !vba)
 		return;
 
 	if (vba->DRAMClockChangeSupport[vba->VoltageLevel][vba->maxMpcComb] !=
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 17ea15682d3a..19b61290ef9e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -573,10 +573,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 	bool need_recalculation = false;
 	uint32_t cstate_enter_plus_exit_z8_ns;
 
-	if (!context)
-		return true;
-
-	else if (context->stream_count == 0) {
+	if (context->stream_count == 0) {
 		unsigned int lowest_state_idx = 0;
 
 		out_clks.p_state_supported = true;
-- 
2.45.1

