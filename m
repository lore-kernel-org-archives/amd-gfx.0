Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E92CF3964
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Sep 2024 18:34:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6088E10E756;
	Thu, 19 Sep 2024 18:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fuaynap3";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F7110E756
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Sep 2024 18:34:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0xtPLIdnsbdPHxPtgKiUf/Sv0HE0R0HQyDXlG8kHDYo0mWCGhgIwELBiPUBWH3tALmd3OSVR4SCu8zNnBNb8MF8Ujid4yo+amh12v3uDT7zZXHV7/dMqG8JI0kRTesNWa+Ste2VIEOu+p96D8vY5i7+4Uchru8gFwNva9rAFIZnvMpSY4e7/RTOsPhW6n7IE0iWoi07A31NWUNZZwrAi6H5uobSl4ZEuBB9eWewzugKwRoDsV6u7DyMIOSVRXKgIbnTNPERAamUPBrIqxUQnwpmEAh++j2e4PYQgsgSoWMGCRffb9xJnobH14CnfJhpYosu3qBtEFCkYa0ENJWy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjAi8Yqyqef3YjI3tY1Md4OBqUVOmdmn4SeWHnLk5hc=;
 b=dzbrP3ele+5J2XooquTsmbfKUKSP8Qgbh5m6WhSOIr0gEysiM5nTOdHKoNCSUbO5GdSnIspkmqqHYjSuz+CjBD1Yn+mS9GQRD40PR1BDGcS4RHV+60/7C0D3/mPi2QyIANVYXfa75dcjrIuA7SB0sVF9fuRhgSAQJQdf4ntVtzAdIzhKdQlNGac+Tp+dxMvnd3r02cO682stW8aJdaKciusrmhsKeLhBeUFI8twAza//IliK6Vr369bm80rnbYu00ugQiPjoxKZzMceE4J3DVQ5R/Mt9gNzbvBGeyd3RvFrOoekP/STH6efHmHckPmjqwjlXym965XDgQz+dLg8Rfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjAi8Yqyqef3YjI3tY1Md4OBqUVOmdmn4SeWHnLk5hc=;
 b=Fuaynap3tFG+nAQfx3xLawIUbYpdXAm9K3OWF05cRmy3qSSE++Cl1xe1ANjy4HTGLTqdpebKdpxAzIfsN+0H23miOmp6OpJjTtpdp3bhDOAfPZ7qvdcUgMBa0aytYgQb1AFKpEunmGB/DSoG9CkEaVcsD+ZA2FEA9gEUrA6rC8I=
Received: from PH7P220CA0037.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::18)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.17; Thu, 19 Sep
 2024 18:34:47 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:510:32b:cafe::24) by PH7P220CA0037.outlook.office365.com
 (2603:10b6:510:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Thu, 19 Sep 2024 18:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 19 Sep 2024 18:34:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 13:34:46 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 13:34:45 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Zhongwei <Zhongwei.Zhang@amd.com>, "Nicholas
 Kazlauskas" <nicholas.kazlauskas@amd.com>
Subject: [PATCH 05/21] drm/amd/display: Monitor patch to call blank_stream()
 before otg off
Date: Thu, 19 Sep 2024 14:33:23 -0400
Message-ID: <20240919183435.1896209-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
References: <20240919183435.1896209-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f1650b7-72f6-40fe-9955-08dcd8d9bd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jo8q3PsYUPSL0aR9VbcFgBqUYhOgPbKA23WZ66kyMpPL+jtWZRgTsrEg1yDk?=
 =?us-ascii?Q?SdiyEfLB9gHSIGWpUZut7nCKtw+aLSgD5k7p4d5DzCYwi5FVGqPkQCJ5aQZ7?=
 =?us-ascii?Q?rWgWEgfK54g4hLDiy5zh6FGYWl3i6FlJiWOGTtH/IIHKo7IwCUd6U9uE6i2Z?=
 =?us-ascii?Q?rJxMSFDIMrdJuLd1+26+c/qCN6E+9+fCDd87isBcsgY4oWKjlJEZWqlV0Ec0?=
 =?us-ascii?Q?K4dxdQSqSOuZVSMsOBWYzjP5Vglwd8Y76pKh/0vrHYI4hqY8o/AIehcDNRhY?=
 =?us-ascii?Q?mD9zsnuWF68eUCxjd7omP3mKuGVOX8S4ZTUdRKyuhyQHM62f0R7Fk8xZpCbW?=
 =?us-ascii?Q?uTI1ecbw7Y3ampdhcagiXrFAlbr60nR7AS8FoTLgnmX54I0+IKm1XOjlWsI0?=
 =?us-ascii?Q?sV0Ukzl+681Dwsl1/99zfSEGWV1pWJhxmu9ngbtJifQT8yGAU0KtTEgyaQtA?=
 =?us-ascii?Q?5VlL18Bc2XLxbOMQil8oGeuO6dZq68ei+CpG4688gQGyrNATmJMxrTRLopna?=
 =?us-ascii?Q?ZM48obOGw7wS7UD03zGsmPIcq7bbrqQYQiJ+Xl2KefzX0ScUyovHwjfZl8xj?=
 =?us-ascii?Q?uZTUW5TMOXAo/3PqCqsPxUeMGCDkQgHqmSIaMzNktWQHqOFf0ipzGi6F1f3L?=
 =?us-ascii?Q?7z0M9zFrpPpB5GnBIt58+jeZIrN08aCWIR2pr6iNk0IvTNXQxS4jTLPIIU+k?=
 =?us-ascii?Q?XDI6KqAEYiNbPdjp56j4q25Pizm1iL1RTVQkgRTmEbAOQvJolnclVDYACJ9v?=
 =?us-ascii?Q?BYbR3Dl6MNOfIOEkMZJBrTBJJHGBHW7cVVROd/Shmjs2vT7Rp2LNgAc2+73t?=
 =?us-ascii?Q?Xks8QGN+cQvMoSBYTcwOKAFrLSn6g4l4SN9XUAtlrgFS6b7QRBZ4Mj7fJTFi?=
 =?us-ascii?Q?hA6NKFx9KqrWsrj3NmgSrjqPmeeeEvDCRHN76mQWkyD/xrBJbqSb64pHJ7dB?=
 =?us-ascii?Q?ZttXqiBDqLbiNS/Upf+Ihj3u0gXKBJy3rNkrpNyYi4knPFj+9ZfHKcreKGa4?=
 =?us-ascii?Q?Pz0nkQpLMFeffOTzbLMO7qG55PJ7rHpfJvTGIZjKUD4bWPavbdKrFMpoKj6W?=
 =?us-ascii?Q?hn4/jx4gcaxEA1P011i0cp3Wt7VbvNsj+DQFqsQZFkSd4A2f7nXX0h+S8SjS?=
 =?us-ascii?Q?PAJa7Fdvosfq2P63o8PrMgcHge7RsvlL98ffXzYHdo9LJg5RgAWDneMDSfxa?=
 =?us-ascii?Q?z2YYPNTmQGcXXYEtMMDYgy8FLJiHK317tOj4IVp2uPe/oATBfCXOlz6uuObZ?=
 =?us-ascii?Q?NSUQEY0J1QK/SZaGJ2qIM91UYfoylF5zr9L6FqJ7piweFDSZ/oZRxTqpxLwB?=
 =?us-ascii?Q?xlLqCCVjSu32SbQIMC0CBHSrE8tlkzgN0c4ekbSNHn06vrpjTjmh4XxkdAPK?=
 =?us-ascii?Q?wiJ1jIgSCTheFg8x59yIBdX2Mt34DYuEaV6M2DiwmlqTuIOvjS+nSCsQOyqG?=
 =?us-ascii?Q?HBukz50S3B/Zt/UAgvGG75YOTzIQM8Yb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 18:34:47.0208 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1650b7-72f6-40fe-9955-08dcd8d9bd0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709
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

From: Zhongwei <Zhongwei.Zhang@amd.com>

[Why]
Turning off OTG before DIG is on and backlight is on, might cause:

DIG FIFO underflow.
EDP output unexpected video data. That might violate EDP spec.
EDP spec requires black light should be off before validate
video data is turned off.

Currently garbage issue only occurs in one type of EDP to MIPI converter.

[How]
Add monitor patch to call blank_stream() before disable_crtc().
That will be no impact for current sequence.

If there are more types of EDP panels meeting this issue later,
we might remove this monitor patch and fix the current sequence.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Zhongwei <Zhongwei.Zhang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_types.h               | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index fd6dca735714..2bbafd1cdce4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -178,6 +178,7 @@ struct dc_panel_patch {
 	unsigned int skip_avmute;
 	unsigned int mst_start_top_delay;
 	unsigned int remove_sink_ext_caps;
+	uint8_t blankstream_before_otg_off;
 };
 
 struct dc_edid_caps {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index 3d4b31bd9946..bfc78a42bc2a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -517,6 +517,11 @@ static void dcn31_reset_back_end_for_pipe(
 
 	dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
+	if ((!pipe_ctx->stream->dpms_off || pipe_ctx->stream->link->link_status.link_active)
+		&& pipe_ctx->stream->sink && pipe_ctx->stream->sink->edid_caps.panel_patch.blankstream_before_otg_off) {
+		dc->hwss.blank_stream(pipe_ctx);
+	}
+
 	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
 			pipe_ctx->stream_res.tg,
 			OPTC_DSC_DISABLED, 0, 0);
-- 
2.46.0

