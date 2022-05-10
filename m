Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544A9C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 20:46:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC76D10E9FD;
	Tue, 10 May 2022 20:46:28 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A28D110E9FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 20:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqziV9HgaAQgQCA3iygPU8K1FcHhmgF/SOcyZMdt5l4tlNcrjOewox0Kw3G3vZsqNcx3RKcf0V5pAQMD26HCA6MGV003n9SZUS/ln2+j4I6xWgCrr4mrdVlWYI0TzU6qc0zptO4P06SMeIDFl9aPoU6Pxjz+RkwrajkRq/I2iNJij919So01t+73gvzmGTeaeeydYGiLAxZfnHcmPdRt+vbMG0kQyCfe4sf7vIelg3dwwnRUEjVtY3Bu6pEzml5Y3D88QPfT6jWtKs0lGi4axh0XWRx2C2aMhfD+N8Qop91nYNh/kBfyARKXVD4j3E7NqskYPqVhTgI6q+t1aL7dRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ff8YV8TtpJCR/kp6Kn7zhcK4IfDYJUEVpdvN8vPAMD4=;
 b=lw7vyalbFXw/zLgWtjgaIFMmM57jP0ek0pjZB4p/xZ8KbCswmQ5YFJSnBe55uWcoxwl6JiHpcabos0jyx+mAbtWh6um+Utpe8s2qhOqzrNiFoxYibGIVA22rxFPx5PUXOvkYegfqCWt6P3GmSslTKHOt/0ea35kX0pQQ7m3ejpQCojRF49ZBhTKzfm31WRUSYrWa6JLDMAs5sCZhmOYKst4S3Y557x/r0eG1MWri+KIwTCCozDyHesJn3byv73PWpfPjBS+rqs8SP8zDvTdpuvwmxw02SxVH07QI/VQ00Tm+BFbd4yM19s6ehnYUFJhBsO7E7BXCDzQYxkj/+o9M+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ff8YV8TtpJCR/kp6Kn7zhcK4IfDYJUEVpdvN8vPAMD4=;
 b=TwFXA9knBdcg5cog4nyTl5KOuTo+5WWWOWKfyKIOssF1VieCvHCqcMvyAaV6dhyigQH1/jmUgOzPRs4g7DZJ8XDCJUTDE6Fpe2WnRtzs6zFkRoXhwGEiuOeZhZ7QojuS9AviiaLHustpRN+O3NJT7HZTQrX0abTugM+0Doj1K/A=
Received: from BN9PR03CA0876.namprd03.prod.outlook.com (2603:10b6:408:13c::11)
 by CY4PR12MB1430.namprd12.prod.outlook.com (2603:10b6:903:3e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 20:46:25 +0000
Received: from BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::a9) by BN9PR03CA0876.outlook.office365.com
 (2603:10b6:408:13c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Tue, 10 May 2022 20:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT046.mail.protection.outlook.com (10.13.177.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Tue, 10 May 2022 20:46:24 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 15:46:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 13:46:23 -0700
Received: from xiaoT.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Tue, 10 May 2022 15:46:21 -0500
From: David Zhang <dingchen.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 13/19] drm/amd/display: PSRSU+DSC WA for specific TCON
Date: Tue, 10 May 2022 16:45:02 -0400
Message-ID: <20220510204508.506089-14-dingchen.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510204508.506089-1-dingchen.zhang@amd.com>
References: <20220510204508.506089-1-dingchen.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5e6b88c2-b5c9-4994-24c0-08da32c625e5
X-MS-TrafficTypeDiagnostic: CY4PR12MB1430:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB14303FBDD201AE9859D3BCAE8DC99@CY4PR12MB1430.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1b98SNoMo03MvhJ/GfwxfHVBQ/fTEGusWa7wNUutrd71QmFW7TaCkw7Na02s8eHzzSJZUxz1FdV8ZdVmbrXMZr8jp3MkbOLdjG5mW1sw23kGVKq5M+AQTeM0EhKwXVrmOPuXAt8YSIOurMvG4OCD3vp9BEuu02t0rBTqIeI5OFVCSbXot9uGeUE+djuUhCBjnRkczanjTmEiM1gANW+2k+VIc7mWUG2pLZt0/tLzYGBdyHuNAqB9fFsvMmSkOBz+/zXeAg9a2dBXseGNr6c95ZfD6ljPfATU/tdCNTNoum6uxnLka5C0LjTDYVNMifIjJQzsk5ljsZ2xyuKj2I5Zhta6IQPWYm7+cbIpUyYFWhwRvFOoEXrTALywwf9i6aiJ1DHIC1Nhbd3tlWsM7UmCfkbil9KXDvY8f178INXPxU+BjzaXcgkPHNf82kWm+swN/x3XVIV/wTozpPdsQ+PNoyjT/7iE52zAxgqHoaEDitShMt/kHr56xbKK1WSUmT0ESgNM8aPp271FPHqNexdPVwh/JCGiK+Tdx2gukGh1N7vSvPc4pJBRYnqA3UPjMHhdLiR7a6dZVWHcCLUIe+yQyl26ANruiPBFBppGfu4UL5BlJVKkvDupdedlMPToV3pqIsFh0sbxzNvgQwdGK4ivaXZG0PwGL75W3ZA0LtKUPZOWMb0QDBTGR0M6df1Quqc8Q0vj/woUQ2YO95c4ZqYI7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(5660300002)(508600001)(83380400001)(8936002)(2616005)(1076003)(81166007)(86362001)(40460700003)(26005)(2906002)(7696005)(47076005)(6666004)(186003)(336012)(6916009)(82310400005)(36860700001)(316002)(356005)(54906003)(36756003)(4326008)(70206006)(70586007)(8676002)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 20:46:24.6252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e6b88c2-b5c9-4994-24c0-08da32c625e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1430
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
Cc: stylon.wang@amd.com, David Zhang <dingchen.zhang@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[why]
Some specific TCON chip has HW limitation to support PSRSU+DSC.

[how]
Force ffu mode when DSC enabled if we detect it is the specific
model from sink OUI DPCD. And disable ABM update for this case.

Signed-off-by: David Zhang <dingchen.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 251f2bbc96b9..5e7f70840e1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -108,6 +108,7 @@ struct psr_settings {
 	 */
 	bool psr_frame_capture_indication_req;
 	unsigned int psr_sdp_transmit_line_num_deadline;
+	uint8_t force_ffu_mode;
 	unsigned int psr_power_opt;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index e784002fe312..9ca0cbb0af9b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -349,6 +349,7 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->debug.u32All = 0;
 	copy_settings_data->debug.bitfields.visual_confirm	= dc->dc->debug.visual_confirm == VISUAL_CONFIRM_PSR;
 	copy_settings_data->debug.bitfields.use_hw_lock_mgr		= 1;
+	copy_settings_data->debug.bitfields.force_full_frame_update	= 0;
 
 	if (psr_context->su_granularity_required == 0)
 		copy_settings_data->su_y_granularity = 0;
@@ -363,6 +364,19 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
 	copy_settings_data->panel_inst = panel_inst;
 	copy_settings_data->dsc_enable_status = (pipe_ctx->stream->timing.flags.DSC == 1);
 
+	/**
+	 * WA for PSRSU+DSC on specific TCON, if DSC is enabled, force PSRSU as ffu mode(full frame update)
+	 * Note that PSRSU+DSC is still under development.
+	 */
+	if (copy_settings_data->dsc_enable_status &&
+		link->dpcd_caps.sink_dev_id == DP_DEVICE_ID_38EC11 &&
+		!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
+			sizeof(link->dpcd_caps.sink_dev_id_str)))
+		link->psr_settings.force_ffu_mode = 1;
+	else
+		link->psr_settings.force_ffu_mode = 0;
+	copy_settings_data->force_ffu_mode = link->psr_settings.force_ffu_mode;
+
 	if (link->fec_state == dc_link_fec_enabled &&
 		(!memcmp(link->dpcd_caps.sink_dev_id_str, DP_SINK_DEVICE_STR_ID_1,
 			sizeof(link->dpcd_caps.sink_dev_id_str)) ||
-- 
2.25.1

