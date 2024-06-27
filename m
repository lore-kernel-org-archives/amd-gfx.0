Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC74C2BD09
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jun 2024 21:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 570CF10EB54;
	Thu, 27 Jun 2024 21:14:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jC7yltXr";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 240B210EB53
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jun 2024 21:14:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP1+2Qw1Oq/dUQLo3GsRXep2OIivQQT/r8xkDubSzJve+qaOwbGqWqfDVKPOgeD/2FXX5L7xhCUIgOx1qotedmbYkCUlNT3kf0AFO4csh9zB1KoSN9+eJZprMHT7neJfKGAUXbErbV/M+Ajjgn2uDgSA6FJfCt/nQqVaCeyqHn50GntMuZ52o1fATO8qrKkIWD9vlyXnTdlQbrZnh22xycDb8O9nMWYt9Zz/ESXlW7nqt8volxj4cHc+/96qQynCkeYss2lljhHYlYmS+ovZbNsegBIyYy6rPJd5HWZESzNjaSwxXlcR3lAmcfcrwcQkyO/uHnjS3hw3i8cQrsUWgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fON2NGXWQFJgqXPNGthuPq1przMNdTD+am0ghe4pXgc=;
 b=c6mrt28fswY/cW68oWkO/hFZfeRtJlSPH2Xv6PAhWj3Ytqp6jpbFGk88BfFVFKEep5HomYgmRrTmYNPS/kTZMp59bBCgvPkhmfALU5BDDYeCqsQmKNOHF9YN5Fh2QyRw4QMaBKEE8twdFo2WiHe83wjSVqeX14Yrc5Sa1pcEIzciUVbRqlMZCLFs7xvM5GkmbaPvDzoqRS606eH5fVZ2o/Tgdt1GqAHgPjbRzf86FkisXA3RpvcZ4qO+MSbbHrPXa+MImJAXNs9yRmXb5Z3RbFtYux0kgWf3UeOTd3FdGgfQv9eLg+L9trkesMTAU1GaPiIeLq/D70IHkRqpVE+Wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fON2NGXWQFJgqXPNGthuPq1przMNdTD+am0ghe4pXgc=;
 b=jC7yltXr9nK3cd3QP2v8vxWUx5CwtzVW/8K9VZsuieeJ6GDT8VUVceqDQ7cGFLAgdZAz5M49XkD7k20/Q+2u0NYs899pv1oTisDcIDyutSvQQImjFzSRBQLliaTklqcunjdDjA3/xBVB/yhiJhSNlmS/PuoRIhQpPVnT0JQNNwk=
Received: from BN9PR03CA0587.namprd03.prod.outlook.com (2603:10b6:408:10d::22)
 by PH7PR12MB8156.namprd12.prod.outlook.com (2603:10b6:510:2b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 21:13:59 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::99) by BN9PR03CA0587.outlook.office365.com
 (2603:10b6:408:10d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 21:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 21:13:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Jun
 2024 16:13:57 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 27 Jun 2024 16:13:56 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Teeger <gateeger@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 06/26] drm/amd/display: Revert Add workaround to restrict max
 frac urgent for DPM0
Date: Thu, 27 Jun 2024 17:13:09 -0400
Message-ID: <20240627211329.26386-7-Jerry.Zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|PH7PR12MB8156:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b3efba3-8ab5-470c-03de-08dc96ee0fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dz7vPb4W1tbDMCNhU6tIIyf2+1Yz9aruZtVIElxGPKA5LEJ6e19bZtkXN/9w?=
 =?us-ascii?Q?oEYzwy4xVDByWg8NCIoV731oBh073I0hNsOxsnnknGRVoATSP8Jj9ieVHp9v?=
 =?us-ascii?Q?9BGKZ6ZNbhzGt+YHrzo86AC9U8SRJMIcm+LcxrAlqv8ycJAWmeT3T/MJmwhW?=
 =?us-ascii?Q?iRK8GrRR/QFpUy5tsF2C22/lcE99ExzsTIiXvqFRarrU+r2XK1x3yV1tx/Ge?=
 =?us-ascii?Q?LS/e7bTW0UvIH4CbGNrGYC87AqzuMkw6XMI/Oglf3nxwXi0zHtf4RzXHDt5X?=
 =?us-ascii?Q?07xukPBpR2VHnq8AN16DutOR2Ue8TcGsrazNYgj8WENUi6RmecmDqc7JwQKZ?=
 =?us-ascii?Q?n4tBiUj5tjdiMirvfE9KkYOg5CsQSLWHeiDjRcVDhsdxv4WqQXKCBKBdrk4y?=
 =?us-ascii?Q?TxX/u5mXz5YcH3QfRgmksmDvRTQgUnCWHZAYRndSYtf5bTLBhu8LkzzIvdGB?=
 =?us-ascii?Q?+JQ0ok2xyBqOlzVT22NPT78Zr1rE8Yqs7+EwmAPaQ48IIdPLBsW8o5Kcu1Ey?=
 =?us-ascii?Q?wC7OFl4D35jr3wVzRZ2rceepzfFWZbwlW81WFcs48+YpATbmQ4wZJks4GJa7?=
 =?us-ascii?Q?YEWl+uL/LMxtApvgYIbFEgyituxs2cC9OqHFO5SsmetbnrvmTIbVmOtKtJfi?=
 =?us-ascii?Q?i/P6fMNh8068WeFAuw0UtlJttt7qme33RfEbTG4Tu0+Lu0XRmMz+7q7Op3uF?=
 =?us-ascii?Q?XBI4B/YRsIjuY3GdHaY1UQomLN+/R3pNfWe1vxyt7XDvaXFp6B8rNwW1adWY?=
 =?us-ascii?Q?VYBy3simKx0Sf/wRfu0whbJ85vwDDOOjTC89zAPYB7yMmpTb1RWdcMvFYyM3?=
 =?us-ascii?Q?vvJoa1s9exjnReWbl95Flg7VWzFvIuQEDOAhqI/ntVBzNqXDYEp7BEPdMI+z?=
 =?us-ascii?Q?cjhEuPQWucbZTlHB5TwLKQe8t7kzQNr/O+i0u/BAD7TBSt/KpYFzE5HkHlXg?=
 =?us-ascii?Q?2p4WGcGapkv1AjWe8O5Sw0GSKqojNP0I2C4nsHkpyzV7CkMtEubsiCPTvGgg?=
 =?us-ascii?Q?OLwcgqqCj5IYRyMwRdTywRX5flE/Z1GQn6qZyG+qNmAsBxrULURAD7n05l9M?=
 =?us-ascii?Q?FwMK9xT3OSRSdVfBz5DrpRaMvqmKZ0PrE+vXZ4lFrizV8BR3bS3uJE1lk9f1?=
 =?us-ascii?Q?nkghJxroG0pr8MOl/HOmXchHbXwcfhMWegyBITtsRauIryD5BGNOo0/tB2Y4?=
 =?us-ascii?Q?pIp5qbNsry5uBolESSvwO3i5jie2T0+c0gWp07VjnKnZMn3Hrn8MZjANyslo?=
 =?us-ascii?Q?c9X819eGF47PQr8lWI4FNTqlz2NxOTJKnh7o0gs0kPzmfQOiGA6Qo93RtVcb?=
 =?us-ascii?Q?LHyt28UCivce3ZO1Vk2shJcHJgjwkwtVyECWqRx1+d0yaN4JoWbPzjqVq7/E?=
 =?us-ascii?Q?911j2CtvWs+bQGiuLjZ+/iI9vCyZiaNQzdLHgO9GozWbxFRvwVAXQAx98Xh1?=
 =?us-ascii?Q?Nzjbcv9rlhLiYOBQKanrMjmXopKrq5Su?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 21:13:58.6541 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b3efba3-8ab5-470c-03de-08dc96ee0fa9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8156
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

From: Teeger <gateeger@amd.com>

This reverts commit a698d910ea7714e512261fa due to multiple issues found.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Teeger <gateeger@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml2_wrapper.c    | 15 ---------------
 .../gpu/drm/amd/display/dc/dml2/dml2_wrapper.h    |  2 --
 .../display/dc/resource/dcn35/dcn35_resource.c    |  2 --
 3 files changed, 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index c58235121474..d5dcc8b77281 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -626,21 +626,6 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 
 	if (result) {
 		unsigned int lowest_state_idx = s->mode_support_params.out_lowest_state_idx;
-		double min_fclk_mhz_for_urgent_workaround = (double)dml2->config.min_fclk_for_urgent_workaround_khz / 1000.0;
-		double max_frac_urgent = (double)dml2->config.max_frac_urgent_for_min_fclk_x1000 / 1000.0;
-
-		if (min_fclk_mhz_for_urgent_workaround > 0.0 && max_frac_urgent > 0.0 &&
-		    (dml2->v20.dml_core_ctx.mp.FractionOfUrgentBandwidth > max_frac_urgent ||
-		     dml2->v20.dml_core_ctx.mp.FractionOfUrgentBandwidthImmediateFlip > max_frac_urgent)) {
-			unsigned int forced_lowest_state_idx = lowest_state_idx;
-
-			while (forced_lowest_state_idx < dml2->v20.dml_core_ctx.states.num_states &&
-			       dml2->v20.dml_core_ctx.states.state_array[forced_lowest_state_idx].fabricclk_mhz <= min_fclk_mhz_for_urgent_workaround) {
-				forced_lowest_state_idx += 1;
-			}
-			lowest_state_idx = forced_lowest_state_idx;
-		}
-
 		out_clks.dispclk_khz = (unsigned int)dml2->v20.dml_core_ctx.mp.Dispclk_calculated * 1000;
 		out_clks.p_state_supported = s->mode_support_info.DRAMClockChangeSupport[0] != dml_dram_clock_change_unsupported;
 		if (in_dc->config.use_default_clock_table &&
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 6e3d52eb45c7..023325e8f6e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -237,8 +237,6 @@ struct dml2_configuration_options {
 	bool use_clock_dc_limits;
 	bool gpuvm_enable;
 	struct dml2_soc_bb *bb_from_dmub;
-	int max_frac_urgent_for_min_fclk_x1000;
-	int min_fclk_for_urgent_workaround_khz;
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
index 1ce0f9ecff9c..ddf251901fb3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
@@ -2153,8 +2153,6 @@ static bool dcn35_resource_construct(
 
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN3_2_DET_SEG_SIZE;/*todo*/
-	dc->dml2_options.max_frac_urgent_for_min_fclk_x1000 = 900;
-	dc->dml2_options.min_fclk_for_urgent_workaround_khz = 400 * 1000;
 
 	if (dc->config.sdpif_request_limit_words_per_umc == 0)
 		dc->config.sdpif_request_limit_words_per_umc = 16;/*todo*/
-- 
2.34.1

