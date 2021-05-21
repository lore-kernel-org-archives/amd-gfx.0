Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3735C4707C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96411611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96411611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78C66E520;
	Fri, 21 May 2021 17:37:13 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DBC36E51C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeB+vs9GlaYzBUQw07WSaD/AJHzh9q0/b9Md/4lRf7XUwHLX8PpKbpcsQoutEMhQatYKVjapLWg0oPuAQIgDE+5Ay5RZFc4kd2FsFunoJN4nYncvXED5UpCxuOGXWtG5siAVTheUMztJZ9TJxxUxlD/Fnrr3d1tt5ge+OGstmhcaA9F1Ex2ikzxM87pPEydE8edwCobilyPCYtVuUTR/v46LDgpFylD5UtYRIaWWrTGvKQDJ5uULQRQCq+Mdkt7rQoUBOxWtAYloqN+2UGv3NbuM2zz7xmnLHixbCE0lW1gqeaLcSPTPigougXQR9xrC5kcFZBLGQ5eU8225ixustw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJwdjnpdyxqQw0gKHGbTQ0XMxxbu7BLBOR6rdbAqIMo=;
 b=LhFBl/OouiFNBdtAjoNxGQn2z4Jm1FsClc8Zavu7eB+ltBvIInHy16trUScte32rsG2r/GbFUxKGYQW27CAH25yD6bIitM1GY9ojYvDrnyQvLZxXII3/XITQdVlOvaFWqOGaFuKPITpXOKRxse8LznjssM6MAGnta10e3yyIn0nvhR2PWxu60utkt67pekWftE6o8LPS9sW2EHuge9JelDOBWQ34zdRxRQsp0d9GvcPaqb8+4epHUMVDVh9ramFiTw226GhFqJNwG/0SHlts314aO8SNQRBD8NAkfx+I/bufrGCx2zS9WnPfEaBaU3p3u5bKONk+9If7UPwYncEpkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJwdjnpdyxqQw0gKHGbTQ0XMxxbu7BLBOR6rdbAqIMo=;
 b=G29JDonsnDkwHgccyenn6bT5QJKqc/TqmG5C9FB89XtceJ74e7aLHqGqhQoeYcRpIJ2GvPM04At1QXLJkwL/D5WGfTiq64jL80e1T96zlNgcsZRRSET2Zu6cmWC2DyDZ9t03T3cgT7i6q8relFxXPPOduzfmiHZ6LSiSoxEiSwQ=
Received: from BN9PR03CA0483.namprd03.prod.outlook.com (2603:10b6:408:130::8)
 by BN6PR12MB1827.namprd12.prod.outlook.com (2603:10b6:404:fd::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:36:59 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::37) by BN9PR03CA0483.outlook.office365.com
 (2603:10b6:408:130::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 17:36:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:36:59 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:36:58 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/15] drm/amd/display: disable desktop VRR when using older
 flip model
Date: Fri, 21 May 2021 13:36:33 -0400
Message-ID: <20210521173646.1140586-3-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b99575f-0d38-4875-a5b9-08d91c7f0968
X-MS-TrafficTypeDiagnostic: BN6PR12MB1827:
X-Microsoft-Antispam-PRVS: <BN6PR12MB18278ED83524852AAEFD6A7DFB299@BN6PR12MB1827.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PDCUNgp84qZBi4IU+Sj3QEru0uo3fZiKaL8jkyoA9a9pKCyYmW582g+0HvKzFS77ZFobpyLdtwTYI8nR5Vn8eQeb9IjXrkQMNtUpzDEOdWU3dPpV+YZV6aaHJ+CiGH2XQNw/WuIUPw/xFTFkvlf9mQFs84EaBsrnnsPQMUin9GGXn8g95e6Y/P8euKJx3XaifZjJIRQVJkRc36PSw3RE9YoAWgf2x3j2qNPsHDq6GFBjD5VB4R6xidoYWJiTnhulqhIbHIPD2wyaq9KhoT5npQfgFJ1Dn44xtPlQO0pDZKF3t/+Iv+luqGFPz3Tp2Pg+1UtgQAk6wEpO2grm3QJ2ADKYgf5fsXwmBv2ehIuJHKLcNvYxxmqBaALcbl5pk7v8ubMfoLSdNI6UIFNMeL6qBPBha7ZjhNRCYS2/RneHY4j+PVBsqn4iWiz80tRw2PxzM4r2mFNZExobhsI3POdDJIRw/OYKQsrOB+L7zSyMGjLkTd6iKeXG3NrvHWCNa8N5uwXtBq5nwROLsCPnlaZEyOs3xEQRv+wtmctHSjVuv9OX0bNPtp/rPm+w3NghIuXvP7griy6ZX5KhxTKpxmvPhyS0OauQMm30OODKeQp00qcZk6vg/NyG8CvmF4ez9kythLh/VlH+UPJbN43f3itwx6m/rrFmPo1CS9BNQ2zOT9OT/t+7/kvlrImmktfSB2g
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(39850400004)(36840700001)(46966006)(44832011)(26005)(70586007)(2616005)(8936002)(6916009)(426003)(70206006)(6666004)(5660300002)(82310400003)(36756003)(86362001)(8676002)(16526019)(186003)(4326008)(478600001)(1076003)(336012)(36860700001)(82740400003)(356005)(47076005)(316002)(83380400001)(2906002)(54906003)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:36:59.3483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b99575f-0d38-4875-a5b9-08d91c7f0968
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1827
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
Cc: Eryk.Brol@amd.com, hvanzyll <hvanzyll@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hvanzyll <hvanzyll@amd.com>

[WHY]
OS uses older flip model which does not work with desktop
VRR causing memory allocations at the wrong IRQ level.

[HOW]
Checks added to flip model to verify model is 2.2 or greater when
doing any of the desktop VRR checks for full updates. This
prevents full updates when VRR changes until a mode change.

Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 ++
 .../amd/display/modules/freesync/freesync.c   | 29 ++++++++++++-------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 13dae7238a58..0ab1a33dae84 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -179,6 +179,9 @@ struct dc_stream_state {
 
 	bool use_vsc_sdp_for_colorimetry;
 	bool ignore_msa_timing_param;
+
+	bool freesync_on_desktop;
+
 	bool converter_disable_audio;
 	uint8_t qs_bit;
 	uint8_t qy_bit;
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 3f4f44b44e6a..b99aa232bd8b 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -516,7 +516,8 @@ bool mod_freesync_get_v_position(struct mod_freesync *mod_freesync,
 }
 
 static void build_vrr_infopacket_data_v1(const struct mod_vrr_params *vrr,
-		struct dc_info_packet *infopacket)
+		struct dc_info_packet *infopacket,
+		bool freesync_on_desktop)
 {
 	/* PB1 = 0x1A (24bit AMD IEEE OUI (0x00001A) - Byte 0) */
 	infopacket->sb[1] = 0x1A;
@@ -542,10 +543,16 @@ static void build_vrr_infopacket_data_v1(const struct mod_vrr_params *vrr,
 			vrr->state != VRR_STATE_UNSUPPORTED)
 		infopacket->sb[6] |= 0x02;
 
-	/* PB6 = [Bit 2 = FreeSync Active] */
-	if (vrr->state != VRR_STATE_DISABLED &&
+	if (freesync_on_desktop) {
+		/* PB6 = [Bit 2 = FreeSync Active] */
+		if (vrr->state != VRR_STATE_DISABLED &&
 			vrr->state != VRR_STATE_UNSUPPORTED)
-		infopacket->sb[6] |= 0x04;
+			infopacket->sb[6] |= 0x04;
+	} else {
+		if (vrr->state == VRR_STATE_ACTIVE_VARIABLE ||
+			vrr->state == VRR_STATE_ACTIVE_FIXED)
+			infopacket->sb[6] |= 0x04;
+	}
 
 	// For v1 & 2 infoframes program nominal if non-fs mode, otherwise full range
 	/* PB7 = FreeSync Minimum refresh rate (Hz) */
@@ -824,13 +831,14 @@ static void build_vrr_infopacket_checksum(unsigned int *payload_size,
 
 static void build_vrr_infopacket_v1(enum signal_type signal,
 		const struct mod_vrr_params *vrr,
-		struct dc_info_packet *infopacket)
+		struct dc_info_packet *infopacket,
+		bool freesync_on_desktop)
 {
 	/* SPD info packet for FreeSync */
 	unsigned int payload_size = 0;
 
 	build_vrr_infopacket_header_v1(signal, infopacket, &payload_size);
-	build_vrr_infopacket_data_v1(vrr, infopacket);
+	build_vrr_infopacket_data_v1(vrr, infopacket, freesync_on_desktop);
 	build_vrr_infopacket_checksum(&payload_size, infopacket);
 
 	infopacket->valid = true;
@@ -839,12 +847,13 @@ static void build_vrr_infopacket_v1(enum signal_type signal,
 static void build_vrr_infopacket_v2(enum signal_type signal,
 		const struct mod_vrr_params *vrr,
 		enum color_transfer_func app_tf,
-		struct dc_info_packet *infopacket)
+		struct dc_info_packet *infopacket,
+		bool freesync_on_desktop)
 {
 	unsigned int payload_size = 0;
 
 	build_vrr_infopacket_header_v2(signal, infopacket, &payload_size);
-	build_vrr_infopacket_data_v1(vrr, infopacket);
+	build_vrr_infopacket_data_v1(vrr, infopacket, freesync_on_desktop);
 
 	build_vrr_infopacket_fs2_data(app_tf, infopacket);
 
@@ -953,12 +962,12 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 #endif
 		break;
 	case PACKET_TYPE_FS_V2:
-		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket);
+		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
 		break;
 	case PACKET_TYPE_VRR:
 	case PACKET_TYPE_FS_V1:
 	default:
-		build_vrr_infopacket_v1(stream->signal, vrr, infopacket);
+		build_vrr_infopacket_v1(stream->signal, vrr, infopacket, stream->freesync_on_desktop);
 	}
 
 	if (true == pack_sdp_v1_3 &&
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
