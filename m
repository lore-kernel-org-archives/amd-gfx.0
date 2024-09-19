Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14BFCF3963
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 564B310E752;
	Thu, 19 Sep 2024 18:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QpbDHiE8";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8262910E752
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:34:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbskItQ6qRMV7T/ot63o6t7Qdd5vRIJs+ein1tHLnR8Fki1bimMeTI9PN1d8uvEAhVtSi01Pfd1Bw2Q2n5KxlX/oFEYCZxRVffauO/RUbJx5Tdp6sgjqGyHpPE4zyJ8yqMfvw7drx7VRzNH9hODCdFCeL43y+gAm5OeS3hyusyIeUqC1a3xbJWwriPHA2A9Ntira5bSscNc+fnIxjZrEuiroa26NXYx2UQKCD4HFrFVu6Lp/yzcbCICJQhn0070nrSqNkT3GDIyWleVeHRwvIuwHOX3o8+ZMjYiZ6UNcxA2htwES47a+gYls90msuL8jOiFdjkC9rKIneFBfvWiJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1Kkjcos33q1W5Xn+YjkUJxthuhN5HHimLfQ8ITaz2M=;
 b=PAnEajKg8lYH3J6FSr63ZF1k1A1dvdUNmblerRW10X8ZSHD5Bu55Biias8iIRf6fMMyUVxIKDv8r7jekhxNt3iKbgWqJFlGZQp4nNCtBsVR1LNUCZSue/dNBy4ZsQ7wXj8m/u17jbGk2+Lsrs72kpEhHaZC1zrdieW/zpkY6i2m9VjIliTk1uWahvwrxsAFrRFy/xv7G/H5hxVAVoe+GUJa2URHBKJoXzQNcfGB6FPbqUywUkVuuKN+xQu+FQ2OmkuXmM/7CjljILz78+LLQxbhVpFNA8g1S97yVWKgnr5KbaHRXvFxI1q4qzOZX6YOgsng9JivkRu/uhBxcUk2PnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1Kkjcos33q1W5Xn+YjkUJxthuhN5HHimLfQ8ITaz2M=;
 b=QpbDHiE8pm74jLeeubEsdknqzkw59+07NwCfu564XzTrchP/IVp8LetWgFB79n+rnSFDAV8DO3XRTu7YGjOaqk+gZtb1JwHOTWCEnqueMJ+NeAKBHQijvaTzsyfTy9GXr3oEjEiqW1fLlwQ5mTApviK0/bCSlUspl7ffHGcW0uI=
Received: from PH7P220CA0044.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::22)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 18:34:39 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::fd) by PH7P220CA0044.outlook.office365.com
 (2603:10b6:510:32b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:38 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:37 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Jun Lei
 <jun.lei@amd.com>
Subject: [PATCH 02/21] drm/amd/display: disable adaptive scaler and sharpener
 when integer scaling is enabled
Date: Thu, 19 Sep 2024 14:33:20 -0400
Message-ID: <20240919183435.1896209-3-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: f29bdf44-d92b-4c42-e33a-08dcd8d9b866
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YUN7KQfA2LhrXnv+gtouM7Z6mzzt2Gf6r7iijvNHKYWpXcHjU+17l0/m890Z?=
 =?us-ascii?Q?sQa7fxvunnjQ4MDN5/UxqA7F7xLK6AqagJBvkTklGl3/LdmimlfVGo8Qg4JB?=
 =?us-ascii?Q?S1t/NQXxHMsg4bgHFwDLBShsr9JFdwuAMO8dhNmbE4HaZngdrpb+nZr7lgPr?=
 =?us-ascii?Q?08mBIFh9GO6ugUFjtTC/GefVqUer/SLJ5UuWymUxj69lRfZrYVcAn7ldW8vm?=
 =?us-ascii?Q?zfxqW4F0zg9jBd0B7S/jUvMo/dNPX0T3JzNX3BJmyLNXUjbcBQIXtdHQR1Ij?=
 =?us-ascii?Q?9Yh6ZmGsayzEnh+H4WcwJmVlHSPwvrkBKglvSCF6C/wi1OXQ36IjR4V1VyYN?=
 =?us-ascii?Q?xzBih4FGsx4IQ+Oo3jDQXFXXsniDes5xCa3xyTKTVZ9ttXeDOmZAzzYQn1NM?=
 =?us-ascii?Q?tS/4MLeUWzMneqKoqn3V6aLwHM8OktQg6roNE8on0R48VDICLlCCDUcI36qM?=
 =?us-ascii?Q?2hnAPWXhwDyVtCbaLlGedIB0SHcs7UWzneKXS02/efLnqApU1luhvYftLVSq?=
 =?us-ascii?Q?2yXtGddI/egbTYXVTVAbwLrjg0WVLVbZyWi4Z81zBepO/bYoj3uU3RpD/2bB?=
 =?us-ascii?Q?wDxB3MoM6F3jjVcL03VXHvHby2CHRCSmOfCGzKaB2iFuG8qwyEi8bshWdkHs?=
 =?us-ascii?Q?O8C7m05bDFex3KftH0bMuPy3Yztlsdg/zJGFJ2XjSshYBlxCGJtiy3N6OkPC?=
 =?us-ascii?Q?xcfoKTE//z/S26MD20kb845/TjgDS60wONPY+13Q/ASo5VlBeC9DcczcP/W+?=
 =?us-ascii?Q?2VS33pMcl6PSpcdOmhnyXQDzWWoKwshEJgshVK6PnifdOk2N6ZIsh9A9d/7z?=
 =?us-ascii?Q?ipDvNWoVJq/UEiZfWi0ASu33QC97H8ZUUThjnOGOhJVr7xH57jem4CrmRs7t?=
 =?us-ascii?Q?PRD60axeXRNda7f/JV3USEySNFPMTkjKWjSFaWiKJIFS21NRyjMZi5/geBSm?=
 =?us-ascii?Q?0wz9Bcj/ZFNLN6gceOeWn7mY6Kyzg+7ohjeIxe0cTsoyI4blUjqYXcQYbW/Y?=
 =?us-ascii?Q?hhDb8LCvRP7oAHa5kGS2CivnQVbjwaqROI5Us/xiDKlBAzbpdVf9w5L4Lwr8?=
 =?us-ascii?Q?R0CWEwaXaipZOcz2gNRjhULX0NxPANdy70K5bI8d97tk/8E4MmHDmS0kSxai?=
 =?us-ascii?Q?dm84vdjTglr4iQ1TvnmZVqo/lSdcjL9oJ47MUGcV7y/wcNGsIbclA8POGXWn?=
 =?us-ascii?Q?WqDnz6rDwZgjYB3vsVk9btKybhlRQ+OMb3IqSqSJkpowyO9aqaLPqtBeiCRS?=
 =?us-ascii?Q?wYNpjs3Pd07lwVp2l+Gmhg3RoG/wvDeIU4EYyuU0l5sz0bwl3Wyy6fJqA1lm?=
 =?us-ascii?Q?tMVDs1SlKms/JKSEKnJiCwM9y0887L5Rk8Yqg0ViS56dOv85T6iKQZM3FxTs?=
 =?us-ascii?Q?f7z6ERjtHT6ilVZLPB0/ipoeQyjv+U++XJvaER0PI6lLP/CJPtmpBU/yy0M3?=
 =?us-ascii?Q?bAmYrCfVs2bClcxEKF0LhSx+8ep+u52c?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:39.2239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f29bdf44-d92b-4c42-e33a-08dcd8d9b866
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422
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

From: Samson Tam <Samson.Tam@amd.com>

[Why & How]
When integer scaling is enabled, set taps to 1 and disable adaptive
 scaler and sharpener.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_spl_translate.c |  1 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c       | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
index 603552dbd771..20fd0afca8cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_spl_translate.c
@@ -38,6 +38,7 @@ static void populate_spltaps_from_taps(struct spl_taps *spl_scaling_quality,
 	spl_scaling_quality->h_taps = scaling_quality->h_taps;
 	spl_scaling_quality->v_taps_c = scaling_quality->v_taps_c;
 	spl_scaling_quality->v_taps = scaling_quality->v_taps;
+	spl_scaling_quality->integer_scaling = scaling_quality->integer_scaling;
 }
 static void populate_taps_from_spltaps(struct scaling_taps *scaling_quality,
 		const struct spl_taps *spl_scaling_quality)
diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index 014e8a296f0c..c38a5c8646e8 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -885,6 +885,18 @@ static bool spl_get_optimal_number_of_taps(
 		spl_scratch->scl_data.viewport.width > max_downscale_src_width)
 		return false;
 
+	/* Disable adaptive scaler and sharpener when integer scaling is enabled */
+	if (spl_in->scaling_quality.integer_scaling) {
+		spl_scratch->scl_data.taps.h_taps = 1;
+		spl_scratch->scl_data.taps.v_taps = 1;
+		spl_scratch->scl_data.taps.v_taps_c = 1;
+		spl_scratch->scl_data.taps.h_taps_c = 1;
+		*enable_easf_v = false;
+		*enable_easf_h = false;
+		*enable_isharp = false;
+		return true;
+	}
+
 	/* Check if we are using EASF or not */
 	skip_easf = enable_easf(spl_in, spl_scratch);
 
-- 
2.46.0

