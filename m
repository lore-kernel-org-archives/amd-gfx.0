Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFA3C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5ADD10EB5E;
	Thu, 27 Jun 2024 21:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WbfA5b/P";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0570E10EB5B
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJPMEmu6EhpF4Otim8KKKLanzCCh1ntqyEqRP4vF62Yppb6ReBePy/ZAP5jeBgdVgZFATkhhp09Xd5fyVCtKPBQVus4sX02TRprD2G1QQof35Ml9s6uoNqk14l+rSbGXRnreXpn9ORWs773QT4nNDHW9smBxP8ihMFCAmUOAy3iai6iew32TFea291/ol/ROwaGTihi2sO4PkpV3jCCmnS+drJk3vcq41cg5990zz1rVQ5NEqLCjQpsSJJTfkI5lKUDv5CsktkDS0GUq6caLfJWJ2BHgBCZETDloQ9VhcrtSwn0pgKaUWmi+Dpdgvp6c2PuBFw5U5PfGSngPVMn3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kt04qmIn0NGlpCCBunZo6nzT3GA+pSTOhkb+3iJoS8=;
 b=cFTIRZeu52B7ZO5aVyRMEA9dQChIFlsAm+0PxqXvfabAsfyKKguMmB77UEohVAa79D3vnvwsVwyaOSR9ym0nLQYsmctObxaf95/Nsd7mW00V/aSCuW/Hr+jj9vnDREIKMPslwuUiwqw8SPDmtwiOrqHH/p626ruArQAbf0QSDyjow6t5g+7bt3Ds5i5/E/8TwbXpFKFFPzkc/uggZKn2MtTHS+pMlscnhez0d7GZe9cb/PIzV7CqvGFyPQuMKMrQAUZeMb0Gfd7FtJFb3Kue3mRtBuR+Tks2l1gTuviLn9OyXlBrEkA0+h69z6qM4jJLz68q9wPmOrUaCq+Nu3FeCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kt04qmIn0NGlpCCBunZo6nzT3GA+pSTOhkb+3iJoS8=;
 b=WbfA5b/PXPE65Hy3ebF31mTpkWXDh4fcXPmmFdTOjJVb88TpM8Sbhxl+LcMPycN96bzGd3pWMRd0/RfvujPBrbskItbxqXFi9z1jTiJGB8Ddq/GtEtRqR13281B6gMfyzbSa/2HDXWy7WjSmDWgN8Mm+CE9aVJg80E9M0fcKp1Q=
Received: from PH7PR17CA0057.namprd17.prod.outlook.com (2603:10b6:510:325::6)
 by PH0PR12MB8052.namprd12.prod.outlook.com (2603:10b6:510:28b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.31; Thu, 27 Jun
 2024 21:14:36 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::1a) by PH7PR17CA0057.outlook.office365.com
 (2603:10b6:510:325::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:14:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:14:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:14:34 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:14:34 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Ryan Seto <ryanseto@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 15/26] drm/amd/display: Add available bandwidth calculation
 for audio (#16909)
Date: Thu, 27 Jun 2024 17:13:18 -0400
Message-ID: <20240627211329.26386-16-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627211329.26386-1-Jerry.Zuo@amd.com>
References: <20240627211329.26386-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|PH0PR12MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8116cf-3060-4b2f-2487-08dc96ee25b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s6vymtkMbe+ghlVgvyWDM1997L+SW56O+QwmKL8UlvVFit2LpM7rV60IAngO?=
 =?us-ascii?Q?ZAB+To/JAuKcZ+0llOMFnHJAhfABXZQQOPAYtSmYrNqwaO0bHxjeRYLLibhi?=
 =?us-ascii?Q?oqsE+cy5YmX9/Ow4TSvA2R9q4MoSPun6+MY0ecg4svl7eb6aVGwXNsvJUFwR?=
 =?us-ascii?Q?DSPvDutFUfKlXQ60AnsOFXLN4WVrhPydCmkR3dA2WScG8LeuOFLuZ2GC9iqv?=
 =?us-ascii?Q?etIKU7+uFdCz9ELiXLrghglDU2OGH461XrkB3uiM6oGihkpexbvlgj2aEJac?=
 =?us-ascii?Q?c69+FUmEgoHUO5PfdU9H02l4OjPTXAUciroKoov0J5A0Vi4N1VLZA3n4Z1G3?=
 =?us-ascii?Q?E1m5U7a+JWjQdzhEBoTZtLlNQ/SJVFY+jM34xsrS+/8Az6XRawTmhmzIyM7k?=
 =?us-ascii?Q?RtbG8nHOQGmbTNKWAsRk/17P1V7NQIKMuZGA+ndsQT/gj2vqCPGEMt4zRQX3?=
 =?us-ascii?Q?cwBsxRrlLKj/fDnF+oKeqqOr/+Mauz7xu/y6T5ZpIaBUHzukL3njOoT1tMPR?=
 =?us-ascii?Q?cXF453X/IYhvp7PD2/wl6UN0T7zzQRClJARJ5aQMc+mQYjToWljEG0Yj6diC?=
 =?us-ascii?Q?32KhBy5WO9ZOg8V8ksqucDGqhs4/oWR1IH9roRSqG19YnHYWD/bR2ZDF5r2k?=
 =?us-ascii?Q?l7TZ2c8cgWpzHmLUJ0+8FVRUnPMhaKjI4jke7310P9o66f0TRXCf1O5XlrdE?=
 =?us-ascii?Q?NabHIdXLlEKWCaH3zEF+JYUd9kNYBWuZmQ7ZsYG2Nv8VhWvrkc3lTUTKFJrd?=
 =?us-ascii?Q?q74v6003WEBQcqRerthNKsAuvfsDpf0W+SbVX/BVrBA+/WB22Oc7zxdOjLng?=
 =?us-ascii?Q?DW73uJHUega3ifwPem+woY0c5/2E/MxaOtu+dAIoRbA+wS3iXlpnedKcpQtt?=
 =?us-ascii?Q?NMeDxLiN8uHKA9tTvEkfTVFUaeGC6XRMOMwRPFShthIRpjysdpGrz+FJs7GP?=
 =?us-ascii?Q?Ohr9FqobG/qYkWNRUBDeT6zFVszudYt8Pi+hcuvE+fS9sjSmD6pe3qDo2XQI?=
 =?us-ascii?Q?n+6w/mVwnb0HSNkjrJW9wYhuHf7etfkIn9Xq9GPU8fzfX3bRwAWaLSjCOy7Y?=
 =?us-ascii?Q?8q+a2MurSz7YwVRf+sJNG+y+m9tW7Qq+ifY67HV4i/5qUpxVgR08tDty41HD?=
 =?us-ascii?Q?dA3cuhfgwccg97v2pVeff+MJOOuTpJW7loAqv/Ce8iM3mt1IgywmYSqF09+q?=
 =?us-ascii?Q?5i9l/QkE2OMVHUL95srQc1oJ6rMbI0lXl7JVbDiCHBjwYx0hpkfmID2WA7XE?=
 =?us-ascii?Q?VcKgZs2eQL0ReYCNCLdsEdX3mKsUPqG8div4ToamHh9lMVLVlaqilqQ/GFhW?=
 =?us-ascii?Q?fMFD4mTf8mdCjWByHg5vZY3kxI22NJ/Rq17cq1i5WzvoEc7AJy3Ma0Ci8Ps1?=
 =?us-ascii?Q?NlNbnLxTxxuOotjXX/+8TFSnz8MAbXAgdSUcihlaWx0NCHz3nvwnfPSZ68Jh?=
 =?us-ascii?Q?wDpjGEvBb35uvAiJGeQvRdAPRzPZRkVT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:14:35.6253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8116cf-3060-4b2f-2487-08dc96ee25b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8052
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

From: Ryan Seto <ryanseto@amd.com>

[Why]
Audio for 8K 240Hz monitor was not available when it should be

[How]
Added calculation based on stream state

Co-authored-by: Ryan Seto <ryanseto@amd.com>
Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Ryan Seto <ryanseto@amd.com>
---
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |  3 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 62 +++++++++++++++++--
 2 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
index c3deb4ab3992..cf5f84fb9c69 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_audio.c
@@ -455,7 +455,8 @@ static uint32_t calculate_available_hblank_bw_in_symbols(
 	available_hblank_bw -= crtc_info->dsc_num_slices * 4; /* EOC overhead */
 
 	if (available_hblank_bw < dp_link_info->hblank_min_symbol_width)
-		available_hblank_bw = dp_link_info->hblank_min_symbol_width;
+		/* Each symbol takes 4 frames */
+		available_hblank_bw = 4 * dp_link_info->hblank_min_symbol_width;
 
 	if (available_hblank_bw < 12)
 		available_hblank_bw = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 1b410aff6c56..1f2eb2f727dc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1305,13 +1305,65 @@ static void populate_audio_dp_link_info(
 
 	dp_link_info->link_bandwidth_kbps = dc_fixpt_floor(link_bw_kbps);
 
-	/* HW minimum for 128b/132b HBlank is 4 frame symbols.
-	 * TODO: Plumb the actual programmed HBlank min symbol width to here.
+	/* Calculates hblank_min_symbol_width for 128b/132b
+	 * Corresponding HBLANK_MIN_SYMBOL_WIDTH register is calculated as:
+	 *   floor(h_blank * bits_per_pixel / 128)
 	 */
-	if (dp_link_info->encoding == DP_128b_132b_ENCODING)
-		dp_link_info->hblank_min_symbol_width = 4;
-	else
+	if (dp_link_info->encoding == DP_128b_132b_ENCODING) {
+		struct dc_crtc_timing *crtc_timing = &pipe_ctx->stream->timing;
+
+		uint32_t h_active = crtc_timing->h_addressable + crtc_timing->h_border_left
+				+ crtc_timing->h_border_right;
+		uint32_t h_blank = crtc_timing->h_total - h_active;
+
+		uint32_t bpp;
+
+		if (crtc_timing->flags.DSC) {
+			bpp = crtc_timing->dsc_cfg.bits_per_pixel;
+		} else {
+			/* When the timing is using DSC, dsc_cfg.bits_per_pixel is in 16th bits.
+			 * The bpp in this path is scaled to 16th bits so the final calculation
+			 * is correct for both cases.
+			 */
+			bpp = 16;
+			switch (crtc_timing->display_color_depth) {
+			case COLOR_DEPTH_666:
+				bpp *= 18;
+				break;
+			case COLOR_DEPTH_888:
+				bpp *= 24;
+				break;
+			case COLOR_DEPTH_101010:
+				bpp *= 30;
+				break;
+			case COLOR_DEPTH_121212:
+				bpp *= 36;
+				break;
+			default:
+				bpp = 0;
+				break;
+			}
+
+			switch (crtc_timing->pixel_encoding) {
+			case PIXEL_ENCODING_YCBCR422:
+				bpp = bpp * 2 / 3;
+				break;
+			case PIXEL_ENCODING_YCBCR420:
+				bpp /= 2;
+				break;
+			default:
+				break;
+			}
+		}
+
+		/* Min symbol width = floor(h_blank * (bpp/16) / 128) */
+		dp_link_info->hblank_min_symbol_width = dc_fixpt_floor(
+				dc_fixpt_div(dc_fixpt_from_int(h_blank * bpp),
+						dc_fixpt_from_int(128 / 16)));
+
+	} else {
 		dp_link_info->hblank_min_symbol_width = 0;
+	}
 }
 
 static void build_audio_output(
-- 
2.34.1

