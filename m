Return-Path: <SRS0=DbcS=A4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29560C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2F9E20737
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jul 2020 17:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UQPvpVKM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2F9E20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07C26EE1B;
	Fri, 17 Jul 2020 17:38:27 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF69D6EE15
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jul 2020 17:38:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3HsVg8LeLDgZxi1JhacTKz6eiFrvQt/ZGLxntIjJ1CBqnX6fJOD4ICDPEd3Jx/uDPWjGd8PCb5gbG5Vwq4398+lyJZmYh4JBVIGqvDQLUL+U+fhCW1gcJZybM/YRNpeIJG3EJjhDIwsN48vpnQ6nv5ieH/aSrlJidistFpmgLA+rLFGh62Dmcj2x+ehMZOTXQ4nsbCZLR1melZVjP2hvCYYqKIMytk2qTwBihbscirn0jX9luKz4YpEOjicoyJpNdF7vfs9ZNOyDZ1kTrXx4l5Go3P1eYXWacTvhPA6ynez1yGD7S+FKGJj679xQzlgtT4w5F04IX+KsM4ng1SbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uhpk1uSuGNT6nxw0WyhB72TlebG5fdAgaa6DoN9/wA=;
 b=kUtGSRzhXQhcrSTQntrsUtptt8Tcv8I8xR3N1im5rVX8NsvzrS10Rod2gCBagL9YLjdgo/hL4uIlIamoWJdTKqZMCdOPAVsMMeW6pPFv5FoOcG4WOqv7SXN/9yigWoZlVU86ILKdReRo6xKPkYknf5saGgdGGLax0f7eYBrCZz/u7b/dKHS5M2zcGQcbUGEMWWDTkgc44pDBXkKq/HkWhQ77JwE3d93a53rUGBBbbJ7V8B8FJG6KXiVkS9KMpaWoQwwrt/OOtnqKW5s3k+6AM71ipu0UFGM7OmVrxVy1W3DA+g7ynH1uOuL5m0pc+NEEG99Gqsc+lxp1zjOsLvheDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uhpk1uSuGNT6nxw0WyhB72TlebG5fdAgaa6DoN9/wA=;
 b=UQPvpVKMbOXsbdESDf/+gOKJy8L4P9Wj+e5SDr+GJgrSYJwWCBlZgn5uA01zcpjaKEkwt/qYtQVBRxcmuUGhlvRELhgED9D/DFz5c1gtXjaw562xsOGM7Hr/iC9D5/0ClrG0hHB7Fn0Yu4ZLJGxe8UIqr8ZaiYj4VDrKRbk4jak=
Received: from BN7PR02CA0012.namprd02.prod.outlook.com (2603:10b6:408:20::25)
 by BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Fri, 17 Jul
 2020 17:38:22 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::2b) by BN7PR02CA0012.outlook.office365.com
 (2603:10b6:408:20::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17 via Frontend
 Transport; Fri, 17 Jul 2020 17:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3195.18 via Frontend Transport; Fri, 17 Jul 2020 17:38:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:21 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 17 Jul
 2020 12:38:21 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jul 2020 12:38:20 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Implement AMD VSIF V3
Date: Fri, 17 Jul 2020 13:38:04 -0400
Message-ID: <20200717173813.11674-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717173813.11674-1-qingqing.zhuo@amd.com>
References: <20200717173813.11674-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(316002)(44832011)(81166007)(1076003)(356005)(54906003)(86362001)(2906002)(6666004)(4326008)(8936002)(36756003)(83380400001)(2616005)(26005)(478600001)(8676002)(336012)(426003)(47076004)(5660300002)(82310400002)(186003)(82740400003)(70586007)(6916009)(70206006);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57668d1d-14de-443a-b651-08d82a783348
X-MS-TrafficTypeDiagnostic: BY5PR12MB4099:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4099E3A5BD569B22561EBA57FB7C0@BY5PR12MB4099.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ala1raikSvSQ1ksQ0+XfTSO/QKmGoJY6cJHPADoG/L/mU5/KfGJZoVNw9RA0DCTJjk+LJ4y2GMpsfNfQSJwB5HUXYJRl/5VdSzW6h7HhOEG/YdHOhfBNaZoSW+vxEyOtusahFcm5vfU8OXMb4Dy5l6G9TdfHI8QU5sUQNfempphyvm9qbm+N8v/bEauo0Yh/ao6geGJa3ZWP8Lgr5KOC9Itz4uVfp8iYBTvu58htwvN2u0ib/DbVRJq4GlajuIAe8kV2x873b5G8EcxIRRaOU8/UJgZDY8qFmIA3wmMIW5ek8/4cTLo8kjtf7wqZJ0ZGhPzfU0TEwhBvTl9dktItn0uxt+8ZIOEzRCTronrTeDSuoW70MpvZdPbkdiD3fV7uvQmFZD/t7nxMzB7TWZ390w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 17:38:21.7340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57668d1d-14de-443a-b651-08d82a783348
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Reza Amini <Reza.Amini@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Reza Amini <Reza.Amini@amd.com>

[Why]
To support V3

[How]
Generate new VSIF for V3

Signed-off-by: Reza Amini <Reza.Amini@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 19 +++++++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  7 ++++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  6 +++
 .../amd/display/modules/freesync/freesync.c   | 41 +++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index d6989d115c5c..41c278519b67 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -244,6 +244,25 @@ struct dc_stream_status *dc_stream_get_status(
 	return dc_stream_get_status_from_state(dc->current_state, stream);
 }
 
+#ifndef TRIM_FSFT
+/**
+ * dc_optimize_timing() - dc to optimize timing
+ */
+bool dc_optimize_timing(
+	struct dc_crtc_timing *timing,
+	unsigned int max_input_rate_in_khz)
+{
+	//optimization is expected to assing a value to these:
+	//timing->pix_clk_100hz
+	//timing->v_front_porch
+	//timing->v_total
+	//timing->fast_transport_output_rate_100hz;
+	timing->fast_transport_output_rate_100hz = timing->pix_clk_100hz;
+
+	return true;
+}
+#endif
+
 
 /**
  * dc_stream_set_cursor_attributes() - Update cursor attributes and set cursor surface address
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index b7a8c71e3e39..1a87bc3da826 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -713,6 +713,9 @@ struct dc_crtc_timing_flags {
 	uint32_t LTE_340MCSC_SCRAMBLE:1;
 
 	uint32_t DSC : 1; /* Use DSC with this timing */
+#ifndef TRIM_FSFT
+	uint32_t FAST_TRANSPORT: 1;
+#endif
 };
 
 enum dc_timing_3d_format {
@@ -772,6 +775,10 @@ struct dc_crtc_timing {
 	enum dc_aspect_ratio aspect_ratio;
 	enum scanning_type scan_type;
 
+#ifndef TRIM_FSFT
+	uint32_t fast_transport_output_rate_100hz;
+#endif
+
 	struct dc_crtc_timing_flags flags;
 	struct dc_dsc_config dsc_cfg;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index f2ed9bc5a319..f599a72dab50 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -419,6 +419,12 @@ struct dc_stream_status *dc_stream_get_status_from_state(
 struct dc_stream_status *dc_stream_get_status(
 	struct dc_stream_state *dc_stream);
 
+#ifndef TRIM_FSFT
+bool dc_optimize_timing(
+	struct dc_crtc_timing *timing,
+	unsigned int max_input_rate_in_khz);
+#endif
+
 /*******************************************************************************
  * Cursor interfaces - To manages the cursor within a stream
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index d3a5ba9ee782..7a2500fbf3f2 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -760,9 +760,35 @@ static void build_vrr_infopacket_v2(enum signal_type signal,
 
 	infopacket->valid = true;
 }
+#ifndef TRIM_FSFT
+static void build_vrr_infopacket_fast_transport_data(
+	bool ftActive,
+	unsigned int ftOutputRate,
+	struct dc_info_packet *infopacket)
+{
+	/* PB9 : bit7 - fast transport Active*/
+	unsigned char activeBit = (ftActive) ? 1 << 7 : 0;
+
+	infopacket->sb[1] &= ~activeBit;  //clear bit
+	infopacket->sb[1] |=  activeBit;  //set bit
+
+	/* PB13 : Target Output Pixel Rate [kHz] - bits 7:0  */
+	infopacket->sb[13] = ftOutputRate & 0xFF;
+
+	/* PB14 : Target Output Pixel Rate [kHz] - bits 15:8  */
+	infopacket->sb[14] = (ftOutputRate >> 8) & 0xFF;
+
+	/* PB15 : Target Output Pixel Rate [kHz] - bits 23:16  */
+	infopacket->sb[15] = (ftOutputRate >> 16) & 0xFF;
+
+}
+#endif
 
 static void build_vrr_infopacket_v3(enum signal_type signal,
 		const struct mod_vrr_params *vrr,
+#ifndef TRIM_FSFT
+		bool ftActive, unsigned int ftOutputRate,
+#endif
 		enum color_transfer_func app_tf,
 		struct dc_info_packet *infopacket)
 {
@@ -773,6 +799,13 @@ static void build_vrr_infopacket_v3(enum signal_type signal,
 
 	build_vrr_infopacket_fs2_data(app_tf, infopacket);
 
+#ifndef TRIM_FSFT
+	build_vrr_infopacket_fast_transport_data(
+			ftActive,
+			ftOutputRate,
+			infopacket);
+#endif
+
 	build_vrr_infopacket_checksum(&payload_size, infopacket);
 
 	infopacket->valid = true;
@@ -795,7 +828,15 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 
 	switch (packet_type) {
 	case PACKET_TYPE_FS_V3:
+#ifndef TRIM_FSFT
+		build_vrr_infopacket_v3(
+				stream->signal, vrr,
+				stream->timing.flags.FAST_TRANSPORT,
+				stream->timing.fast_transport_output_rate_100hz,
+				app_tf, infopacket);
+#else
 		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket);
+#endif
 		break;
 	case PACKET_TYPE_FS_V2:
 		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
