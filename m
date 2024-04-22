Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FBDC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7912112C00;
	Mon, 22 Apr 2024 15:30:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jLU8aUvS";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03E9112C01
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UZ9yoO+fn/e+JK/72Lammw9xPe9FeQW5WCCFqw3eJ5FmFg06d/Q69Gleog4wUUVB0fZETKdRvnL+EYIb+z0IEx6SLl2acbIj49kLmaDyBmrzvYLsmYNLHv42rEFO7Xs7/BVBR4CJ7DOjng5pGBr8IwXwxNo4VN3eykui9NS/W7c/8mbhHUx957Tzq6MHwUKcHv835g7LyhG6BFbcANvRqEQ0AfFSBLoAXei4RlonOUdVrPeiTPfmn8qn/MnhEcgrgmTkZ/4GmIWq/VRDNHQrmbpG7iLODjWlNbSJd3dbB5p7K1kwqIZb7eTQ86HmE1RHvxQETg5FQQuEPctlFaiItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvxQU4MGMrV3EDRumUjLoQxKWQREufZRyQtuxZywuW8=;
 b=l/Eu6Lb73UuVeBtsavau/jK2bv9vXbfHYxzBsduT2DO3h/TTErvHgE53VhEV000QgNj8vXTESwvxxi1x1+U3uLzHPOJ/IHWaOsfAdQa5DxpstrlE7fZQc9bQsd7xn3nx+CcvU617DK5hkNwKjKX6jXsCXay+Zy8mw31KtRgGLhFlxXOri4mkFkRlwBN5N9wPzk+XOUgBrol/oO5kB63mM7hbeJwWZF6uUcKUWdPWdfFR+H6iBO72D6EbfqOAqI1q5tkrmioUP9r/T64CseQRMEZV33UzYHj3Tb10dlmSAfWG6YBHsmplAdk04qQQlALPURufo7cAI1hq9kiqReWhlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvxQU4MGMrV3EDRumUjLoQxKWQREufZRyQtuxZywuW8=;
 b=jLU8aUvSIjPOkeN7vo88lNyUXEj/48bkjXC4ULBAPZEaxK1kfC2wOrqstYnDtxDnEus/vDb8n3eavOhfXAyaZhF3qlyY2aEZ4PMo3sF/mlld89VZ+XndzEFOUFj3EzBynv/HVpGlQX7xp9J5IWHNL91WD2koYBEiCOA4nVsqbJM=
Received: from SN4PR0501CA0049.namprd05.prod.outlook.com
 (2603:10b6:803:41::26) by SA1PR12MB8886.namprd12.prod.outlook.com
 (2603:10b6:806:375::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:30:54 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::47) by SN4PR0501CA0049.outlook.office365.com
 (2603:10b6:803:41::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:53 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:52 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 08:30:52 -0700
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:46 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 27/37] drm/amd/display: Add condition for dp_set_dsc_config
 call
Date: Mon, 22 Apr 2024 11:27:36 -0400
Message-ID: <20240422152817.2765349-28-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2e9e12-be92-49c3-f260-08dc62e132ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JeYyqrCaxPyUEaBSb3NBxCG8pK34sKdhzFQ9fCHdr5pOzYaM0VHtHGTv07eC?=
 =?us-ascii?Q?2oTeGNXKwnx6ITk2s3CotE+S9gaKJG/4Hw8i7n9Lvakh6fPRbY7SOjdNGIME?=
 =?us-ascii?Q?RNcKegnnRaFugjUz0ptpSicrypQEHVDeWRsVw3j4WCecOI6tb9HIoE0hbd6w?=
 =?us-ascii?Q?UFpikVFeqwQozW78omztZ5ElOrjJOTc2JvJOmQ4iAwwj8fkeafOwVuOqzbPh?=
 =?us-ascii?Q?Z32v8Xr8JFPlfMHv2um4toYdULmhjeBJEMLHyMM1IXMCvEeJwJCAWWmEm1ej?=
 =?us-ascii?Q?uIfU3ymyTexdkVTqIIcDrH2Wf/YoTnSoc/5lupbsql+E99frKHgAGKIs1Lvl?=
 =?us-ascii?Q?RiEElRVLBksTMSDB7p6u7XCbT8ymbQDdTVMWbKdfoQ5FB8O3mEuwdXuzJwpG?=
 =?us-ascii?Q?AxRAUoRxRhkSQvJT8Nign7uBrdT+3sNsz/szt5kSZEuQXTo1NSPEAqgDiyga?=
 =?us-ascii?Q?La8ljtH4GXqEGZIFTfrp8R63A7CzaB9mzgzvcC9QXsIVbh9gdHfmkM6VletO?=
 =?us-ascii?Q?ym4MBVktXXyldmykg4iqZeV6nSvc9OumWcJsXoWEg8EFwioCRGdTtnZpzMdd?=
 =?us-ascii?Q?ceDnW+dN2PpUBKHUxS+AtvshGdLlHhKiwTKzKJZ0pvEvLmVZH1xWJkMooAMt?=
 =?us-ascii?Q?4dgKzOxR1pGh655hz/wF0uNMtbs9tOnGgWYj4V/kcsr9nEsEV5DS2OfnEYbD?=
 =?us-ascii?Q?Z4GxNjOTOt+u8/fMky7kCbs/tdXvOK0Lfazmr2rqzEr/z1T4kkukVX4/D4f/?=
 =?us-ascii?Q?IbqoGD0gzYGQGKhCxEnxuoDL8mitTngC4yejX7d2WtILqLZBlmIUogKREeau?=
 =?us-ascii?Q?DEkFTgW6wlGtzREwrdnNMLHRNftuw6ok58MpAF9kXXX6ctgE28lTjVjxDv8m?=
 =?us-ascii?Q?OizZnaKzGIzK4CG1B0lu9J9PtJhuG/Ggi6/XgeURmvgHC7KG2nVHQc6FQ6DD?=
 =?us-ascii?Q?3tz8gpiyHc67MkDU+sSVUbj70IGHXkj4qqfHCmIEWYGSjbBjuDdnxK7G0Oe0?=
 =?us-ascii?Q?6BbQ0GqRM+QK5J7zxk/EzxfQGIXHsVu/QFsrCCrUAVKKEslVo++S1kf90JII?=
 =?us-ascii?Q?BPRHBMjsMjv2MkeeIa7DihB6b5acnhqacmSuEJKa605lSI2rl/GVEUb4Ji+F?=
 =?us-ascii?Q?nX+KNOxmlD1YwHYYjtpKj6gA6vdmGEAZjz6gF+jG/VZqhYpQ+fw7LQPr5+KF?=
 =?us-ascii?Q?tLeXJ7JyQkCSf/QBRcSwbhe35SOPb4ron8KUttx6Ytl9D0+f2vMsBIsnlfvL?=
 =?us-ascii?Q?mx3dySC19FM/dtcht/422USkoj6jXuDx7WXs1m0bulhZsvAGILtn3FoU6J2D?=
 =?us-ascii?Q?daw91cOzRmKrJiyNozjdsyXA9X+NPObqCXAqRodU1AaWzMQUpYVSq+Eb8Gv+?=
 =?us-ascii?Q?FWTVqNTphSqtK5olEvqItkiNvca2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:53.6501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2e9e12-be92-49c3-f260-08dc62e132ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
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

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

Not every ASIC implements dp_set_dsc_config. Add condition to prevent
calls to unimplemented function.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 087423be3151..e490dddd0424 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -838,10 +838,11 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 		if (dc_is_dp_signal(stream->signal) && !dp_is_128b_132b_signal(pipe_ctx)) {
 			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
 			dsc_optc_config_log(dsc, &dsc_optc_cfg);
-			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
-									optc_dsc_mode,
-									dsc_optc_cfg.bytes_per_pixel,
-									dsc_optc_cfg.slice_width);
+			if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
+										optc_dsc_mode,
+										dsc_optc_cfg.bytes_per_pixel,
+										dsc_optc_cfg.slice_width);
 
 			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
 		}
@@ -868,9 +869,10 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 										NULL,
 										true);
 			else {
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
-						pipe_ctx->stream_res.stream_enc,
-						OPTC_DSC_DISABLED, 0, 0);
+				if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
+					pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
+							pipe_ctx->stream_res.stream_enc,
+							OPTC_DSC_DISABLED, 0, 0);
 				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
 							pipe_ctx->stream_res.stream_enc, false, NULL, true);
 			}
-- 
2.44.0

