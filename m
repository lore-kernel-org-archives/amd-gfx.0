Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419C6C021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 15:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3AB610EABD;
	Fri, 21 Feb 2025 15:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ETw41zNZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 671DC10EAB3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 15:43:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgtUs+ebv3yRR9TsR7itU/tBiMHL0N2+E1SABkAQjqkAuyBG62FowddOmZHaoHWfM+fXAVkf2KU/caAz7iMYwd17wQ6P8CLCP9XM/HHk8qjRQfjPtHd6mhQ82WDm8lF7loUCwYiTXrAQHJ6hV99S0XXZ8fj0HA0DgGKY4Ni5hnv+A+raoPGYCASYpMl0qPtRUzjN12egmQ2HtZu4Oo4FietgGv5urgZBW86N4zAwOl30cKmYd/p3GBck8tzd2f5MTGsqWZnUBFz72HXbMnB8ZT71AUd7r8PseznTXEmhuOkufKnbhnrFGCCnUeYyhj58llYl3eVRWFzltd7+VWvFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6fYoYWjHT8qHOpxP24OGqdDXxwZV6FMJOuT1zJipXE=;
 b=RTeWo2VDwxd72TPyWQQtHjVfy1w/nXgARyMGB2qcM4NpaCJZiqqfI4aqKkeP7Ro8MPJntIod3Vv5hVROvJ76b/SD1fLlHSsEHAhMAGwbI/Mha3rDL6b22D7IVVExsN7IKmJUaTsacjkissIvx6zX3MLgpcBArvCCsfsC3jcn7KxXebadLjFvVSxRjIFPbhByhowu7l+jvL8jt9mb3uikCqgGfV8lIqKEHr/w49hKEpuj2BkvWY1xhGfbGvehxJrf+vMbIC6ofoB48KqXSQ02Zx9IQDaRDMyKitqAH3tDQfILQH/q+KNPk8Xs3smmel/unetw8a2S2xh5TELwN/mQWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6fYoYWjHT8qHOpxP24OGqdDXxwZV6FMJOuT1zJipXE=;
 b=ETw41zNZPFSXTvAeYS0uLRJImSSk8HtaoJDshcfHdDhj0veGq+X5+74rMUCS1O0BCMtoNv1vqCyhFVcgDsCy0xE1nyZHUai8vO1T9mqS8fXU5f1vDMV8fU0mt+G0Mh4+OExV4Gx/y/pEkSMy3GOeWzhhaGIu54h1ZAoftlNfBEg=
Received: from MW4PR04CA0094.namprd04.prod.outlook.com (2603:10b6:303:83::9)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 15:43:45 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::76) by MW4PR04CA0094.outlook.office365.com
 (2603:10b6:303:83::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Fri,
 21 Feb 2025 15:43:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 15:43:44 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 09:43:39 -0600
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Navid Assadian <Navid.Assadian@amd.com>, Samson Tam
 <Samson.Tam@amd.com>
Subject: [PATCH 06/24] drm/amd/display: Add opp recout adjustment
Date: Fri, 21 Feb 2025 10:42:54 -0500
Message-ID: <20250221154312.1720736-7-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
References: <20250221154312.1720736-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 49dd217b-a58f-4b01-12f1-08dd528e863b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JcnHzdZHuR1/rlK5qFh8FyfeVdKvOuyIPm5mUp4eZZwEnmrc7vVWTDk9vNhO?=
 =?us-ascii?Q?1gEtk7/zZIA7eYwvZCU1mfzrwAx5X750Mpoy7e4xOOow1v0Itox8+kPh8jqj?=
 =?us-ascii?Q?Of4P7btVPwR1n6cp+YvOu9JUTL3f/fgmv8UCmyXkbX54mf9cFfEkzedupyJo?=
 =?us-ascii?Q?1HB/o3UqJz+EtGl3qVnw+xdXHAOZCCy8CMbJ0SKuXbKvCFBIMC/9CduCH4d2?=
 =?us-ascii?Q?Cv624zbpJc+/lmnfVzlIGadiUTXhKXEg88aTb4VLS/7jd9gGaFu6l8ZOSJ9A?=
 =?us-ascii?Q?lZwNzGWoOeoyNxfIIcg3ZAS3v+h/kY0zU+dClpwtevzfomaQrxO2m9s43SLv?=
 =?us-ascii?Q?/71v4ICNOg8A1lCOgJWg3u/wkZaWeL9Fmp4v7L4791gMgUwmm91HwmqUr+AU?=
 =?us-ascii?Q?yqAp1ERobdzET+b88VpuJIBVfY8Q2a1vY3Zhpa+6UILb2M8O+J0QwCK7tOLB?=
 =?us-ascii?Q?lK/d1bAvnoR047RB6pQMNEEB67+I2IhO4n3aws75KVbqrcAKAGpY50BO01eQ?=
 =?us-ascii?Q?F1UoQxwahoAqaaZcg1kS7eecnI4++L3mOy0U3y9XLtoExlNosjPXeGE6mWNt?=
 =?us-ascii?Q?Pl7U0NuQq8Gmm8uA/XEIfttXHhkirD3sl1B9EQwX9/d7qeY2YxO8glJCt9cl?=
 =?us-ascii?Q?J/DuW2MOCTUCjSVqyimO9ZsbcQ+WJHok2BZx95+RScg2mTILLroROeDu4x9i?=
 =?us-ascii?Q?NPLiruZaRMJJMSlVli/uQ1z8NzyEOTB97IgBGqJ64+8d1OmNEqsZi1H9Fry1?=
 =?us-ascii?Q?R/jQLfYVS81iVMIK5M35TUqPAFUj29utbtrZt6XV3259Z2f84gsUicInCU38?=
 =?us-ascii?Q?00VS/KITfYaDxEtcRp6/mWe2qHMv7N6+MXQmTGbw4Px2cZo5dmpapmyxdGos?=
 =?us-ascii?Q?w0V2r95Uh5AM1wpWze1og/AzNAwm0tVxadrdQV/VLNIxGzIQMgjdHzSBda7z?=
 =?us-ascii?Q?2A+ThBpXcFTepldKXqiR5tnRVPHgwjXALhreh62N62wH9OvLQOcu3xiwOrnT?=
 =?us-ascii?Q?OFiP0GL5nTMfcNRJM7km4skxBh2GI6eRa0VuoL97dW4pgZWR7fjjJR4X0Ha1?=
 =?us-ascii?Q?2gvrvT6NXCfLDwkG22tFFaYH5DuZKssuSFn0bf6aVfdk6vNnW8iucRZRbd1m?=
 =?us-ascii?Q?WGH/AeCP51TYXF3cZxyBLeujnuyqlxVezftkmW5sRC1k3pegq0MyirA1yAR4?=
 =?us-ascii?Q?GQix/8m+ObKdHPGgoKGzBOCkPq+WGZ66VSgfPUVVrmhHqAoQMvDPkXmkBcG0?=
 =?us-ascii?Q?PKLj1eexi1Zpta2mbf8vjGJsadfpfV7T0o0S2uyIZvy+FZ3Qy2Q/VQpMBg5K?=
 =?us-ascii?Q?unpuZxYnsgwD5Yfx78TMuyDpUt05iQ/xTK2Lh0bhZzM+x8BELVdEk+RzAqaS?=
 =?us-ascii?Q?pSz2OK3JbZV7R7/AlkRezAN8ghSdNyhnQxKtCmN6PjwAsT2NiJrNgwbrr3wf?=
 =?us-ascii?Q?hfqrb5ah84rP3CSb4e10Jz0aggRtW9gqMcOV35rDPcCSYF9cedUWYUQyoR5L?=
 =?us-ascii?Q?Vu0o7tK7b5EcDps=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 15:43:44.5768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49dd217b-a58f-4b01-12f1-08dd528e863b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734
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

From: Navid Assadian <Navid.Assadian@amd.com>

[Why]
For subsampled YUV output formats, more pixels can get fetched and be
used for scaling.

[How]
Add the adjustment to the calculated recout, so the viewport covers the
corresponding pixels on the source plane.

Signed-off-by: Navid Assadian <Navid.Assadian@amd.com>
Reviewed-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  | 31 +++++++++++++++----
 .../drm/amd/display/dc/sspl/dc_spl_types.h    | 10 ++++++
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
index 31495c9978b0..72a79288ab79 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c
@@ -76,6 +76,21 @@ static struct spl_rect shift_rec(const struct spl_rect *rec_in, int x, int y)
 	return rec_out;
 }
 
+static void spl_opp_adjust_rect(struct spl_rect *rec, const struct spl_opp_adjust *adjust)
+{
+	if ((rec->x + adjust->x) >= 0)
+		rec->x += adjust->x;
+
+	if ((rec->y + adjust->y) >= 0)
+		rec->y += adjust->y;
+
+	if ((rec->width + adjust->width) >= 1)
+		rec->width += adjust->width;
+
+	if ((rec->height + adjust->height) >= 1)
+		rec->height += adjust->height;
+}
+
 static struct spl_rect calculate_plane_rec_in_timing_active(
 		struct spl_in *spl_in,
 		const struct spl_rect *rec_in)
@@ -723,13 +738,15 @@ static void spl_handle_3d_recout(struct spl_in *spl_in, struct spl_rect *recout)
 	}
 }
 
-static void spl_clamp_viewport(struct spl_rect *viewport)
+static void spl_clamp_viewport(struct spl_rect *viewport, int min_viewport_size)
 {
+	if (min_viewport_size == 0)
+		min_viewport_size = MIN_VIEWPORT_SIZE;
 	/* Clamp minimum viewport size */
-	if (viewport->height < MIN_VIEWPORT_SIZE)
-		viewport->height = MIN_VIEWPORT_SIZE;
-	if (viewport->width < MIN_VIEWPORT_SIZE)
-		viewport->width = MIN_VIEWPORT_SIZE;
+	if (viewport->height < min_viewport_size)
+		viewport->height = min_viewport_size;
+	if (viewport->width < min_viewport_size)
+		viewport->width = min_viewport_size;
 }
 
 static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
@@ -1764,6 +1781,8 @@ static bool spl_calculate_number_of_taps(struct spl_in *spl_in, struct spl_scrat
 	spl_calculate_recout(spl_in, spl_scratch, spl_out);
 	/* depends on pixel format */
 	spl_calculate_scaling_ratios(spl_in, spl_scratch, spl_out);
+	/* Adjust recout for opp if needed */
+	spl_opp_adjust_rect(&spl_scratch->scl_data.recout, &spl_in->basic_in.opp_recout_adjust);
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	spl_calculate_viewport_size(spl_in, spl_scratch);
 
@@ -1800,7 +1819,7 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 	// Handle 3d recout
 	spl_handle_3d_recout(spl_in, &spl_scratch.scl_data.recout);
 	// Clamp
-	spl_clamp_viewport(&spl_scratch.scl_data.viewport);
+	spl_clamp_viewport(&spl_scratch.scl_data.viewport, spl_in->min_viewport_size);
 
 	// Save all calculated parameters in dscl_prog_data structure to program hw registers
 	spl_set_dscl_prog_data(spl_in, &spl_scratch, spl_out, enable_easf_v, enable_easf_h, enable_isharp);
diff --git a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
index 467af9dd90de..0130673ceee6 100644
--- a/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
+++ b/drivers/gpu/drm/amd/display/dc/sspl/dc_spl_types.h
@@ -427,6 +427,14 @@ struct spl_out	{
 
 // SPL inputs
 
+// opp extra adjustment for rect
+struct spl_opp_adjust {
+	int x;
+	int y;
+	int width;
+	int height;
+};
+
 // Basic input information
 struct basic_in	{
 	enum spl_pixel_format format; // Pixel Format
@@ -444,6 +452,7 @@ struct basic_in	{
 		} num_slices_recout_width;
 	} num_h_slices_recout_width_align;
 	int mpc_h_slice_index; // previous mpc_combine_v - split_idx
+	struct spl_opp_adjust opp_recout_adjust;
 	// Inputs for adaptive scaler - TODO
 	enum spl_transfer_func_type tf_type; /* Transfer function type */
 	enum spl_transfer_func_predefined tf_predefined_type; /* Transfer function predefined type */
@@ -535,6 +544,7 @@ struct spl_in	{
 	bool is_hdr_on;
 	int h_active;
 	int v_active;
+	int min_viewport_size;
 	int sdr_white_level_nits;
 	enum sharpen_policy sharpen_policy;
 };
-- 
2.34.1

