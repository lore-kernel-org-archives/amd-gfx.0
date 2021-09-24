Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E354C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0D4E610FD
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E0D4E610FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A63B6E216;
	Fri, 24 Sep 2021 19:10:21 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D886E21C
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:10:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mK3G/YnzLAJ3B120RN/ySAnEbB3ZZOp7Dx3Gpx0ZaF7SdOJdnQ+5J044AToBDWAmL6EZqhYNSaVRIUGaQJsKTwecN0kRx0+QduINB3n+OsErbL5FQtdnBKz/1Fc/f05TpDGAkxDouCxJL2GSQbMbDUREhz+XvjkA7JJgQLhsVcuXBdr6xLD9p6EZF650jBDnleLmGTCA/QxrhQGg0EJJAXvIKfcCxqqLaiMavlyRxDd60JbycHdPomcPVqeNn2E/NHSnEgV+y3B7atAk0O4yOyXXH32cCzb1BX9vIP7iF3mi5KweZYm0/USe4JUno7UQrNxFTs5yrY/fsDjXYIx1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=tNFN4Cs/LxqKS2n9rvQOprNixDxmxyZJqIk52i1FUuw=;
 b=DagsEc6h3Qv8MTre+PvxITiIlgSbKsXM6og302+jWd0Leq2GtwAzIIr8F6zInonDy2EaWZma4T55n43HbV2oGioPElBfJYhRpoLnaZgiCKvUmf04tlHdqmMLE6HQ3vop587AXt/TRFJuiRuKdjCuKXY/rwqXX7RNbf22Un0TndiiTj+ZYTQf8qB8336clYB67dZe7inmikDb4P97KAsjIruIJl9YGy53QJgIG2UD8jhsFVMQ0Z49sQb8tNIMEoS5L3dCXpUe78knrLkVEfLdEQ0b6HFvyOmasl9/NvdgzvGGtq8O7heaxOfbWyeA5CM8VseSdx94hRkXc//18Hk1mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNFN4Cs/LxqKS2n9rvQOprNixDxmxyZJqIk52i1FUuw=;
 b=0KcTnUx2/ZG58sr4GZExc/FVUQBRL/FDc1WsEy57WqKJAh4P1Qpa5HZbK3SxosXYnyc8WEL1Jz7NVPGenRo9YprdI88dIOUClI/oUEy85guv/XrLpf7nqligNphwf3LTC7Gy/H3yGPwawdk03Ztp+BPxnVMDBp5uUTWT+sk0DX4=
Received: from CO2PR05CA0107.namprd05.prod.outlook.com (2603:10b6:104:1::33)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Fri, 24 Sep
 2021 19:10:15 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::78) by CO2PR05CA0107.outlook.office365.com
 (2603:10b6:104:1::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Fri, 24 Sep 2021 19:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:10:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:10:12 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:10:10 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Ilya <Ilya.Bakoulin@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 14/24] drm/amd/display: Add PPS immediate update flag for DCN2
Date: Fri, 24 Sep 2021 15:09:24 -0400
Message-ID: <20210924190934.1193379-15-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 661e6361-b874-41e5-d887-08d97f8ef06f
X-MS-TrafficTypeDiagnostic: BY5PR12MB4178:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41783773AF45C54A527B363AEBA49@BY5PR12MB4178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t81oMGN5VvatqgnKH9MjMzVdmN1wgFos0ZkL7eA4CMWrivVVd+AJjK+rSsTH/YLUeVlXvjpe+Z/0XEQz0mnSCPJAg52sve37TDjqQPZGAbmWJP3nKWIX5H41HHn91FOfKCRMfUlfEeGiLCZM6NMT94qAF1+HSohXMoMV617bzP9hbvWeCiCPVo5CBqCgZxVg06ryX1P60vA+kKFDbsGPuzsKTsePrvxHBzx6VFX8mDTmHfd2S/UJCHwg7uChTEKHwr4GFVHIAeVmJhP7NE3vj57g7DpnJe5j+cJ01ytxWHbK2M0wC1PootD24+Z3KKEjRslRZ88nm13qfBDBLo3CvcnJhRTGlHzvnvj1QDy1fGq9NqFp4cvpu8HIOXgdzADthwWplcXJ+Wdu41YF5qtHvePlzr0NuD9YhlNgOyV2CQ0+IMNNRIs7JSBTFGBQQdUFcfjMuxPlsAeSecwwO9u4ZlF2M1dajQfFhUE7ic9I55be3hhVyoDYtiq/zpG+IhHFRGaabq+c3VTXykYjs8wT25MqDqnZP3A8M2yxjK50ylGn9OIXfxGwo3oHt0GJAIq2DIFCF0h0lWwxqehtPGvicPSb3xMvWbhKh/zuXrZCnnUI/gQ8gTpi9s2EbPQL7EgDPIz6ktWYwOvwGYrG/hqVoisc+tBFyltNR+D5PBVHc9G7RwJustz+GDPO1oz7mUGhvpvuMwU6EQKjJqOP7vTKLdeFnJebAPJsdeS1xHFDJhdgiWSuY8E/Q72lorUB7yJPHw0YQP6XwxIz3C11I0WZgw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(86362001)(5660300002)(83380400001)(70206006)(426003)(356005)(4326008)(6916009)(47076005)(82310400003)(26005)(6666004)(186003)(2616005)(15650500001)(36860700001)(336012)(81166007)(54906003)(508600001)(2906002)(7696005)(70586007)(36756003)(1076003)(8676002)(316002)(8936002)(14773001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:10:14.4052 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661e6361-b874-41e5-d887-08d97f8ef06f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178
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

From: Ilya <Ilya.Bakoulin@amd.com>

[Why]
This change is needed for DCN2 to make use of the immediate_update
flag. With this flag, update to PPS will be immediate, rather than
always taking place on dig_update signal.

[How]
Set AFMT_GENERIC7_FRAME/IMMEDIATE_UPDATE bits depending on flag
value.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Ilya <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c        | 5 +++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c  | 9 ++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
index f6e747f25ebe..c90b8516dcc1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_optc.c
@@ -467,6 +467,11 @@ void optc2_lock_doublebuffer_enable(struct timing_generator *optc)
 			(h_blank_start - 200 - 1) / optc1->opp_count,
 			MASTER_UPDATE_LOCK_DB_Y,
 			v_blank_start - 1);
+
+	REG_SET_3(OTG_VUPDATE_KEEPOUT, 0,
+		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, 0,
+		MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, 100,
+		OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, 1);
 }
 
 void optc2_lock_doublebuffer_disable(struct timing_generator *optc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index 11c50b508754..aab25ca8343a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -211,7 +211,8 @@ static void enc2_stream_encoder_stop_hdmi_info_packets(
 /* Update GSP7 SDP 128 byte long */
 static void enc2_update_gsp7_128_info_packet(
 	struct dcn10_stream_encoder *enc1,
-	const struct dc_info_packet_128 *info_packet)
+	const struct dc_info_packet_128 *info_packet,
+	bool immediate_update)
 {
 	uint32_t i;
 
@@ -266,7 +267,9 @@ static void enc2_update_gsp7_128_info_packet(
 		REG_WRITE(AFMT_GENERIC_7, *content++);
 	}
 
-	REG_UPDATE(AFMT_VBI_PACKET_CONTROL1, AFMT_GENERIC7_FRAME_UPDATE, 1);
+	REG_UPDATE_2(AFMT_VBI_PACKET_CONTROL1,
+			AFMT_GENERIC7_FRAME_UPDATE, !immediate_update,
+			AFMT_GENERIC7_IMMEDIATE_UPDATE, immediate_update);
 }
 
 /* Set DSC-related configuration.
@@ -309,7 +312,7 @@ static void enc2_dp_set_dsc_pps_info_packet(struct stream_encoder *enc,
 		pps_sdp.hb2 = 127;
 		pps_sdp.hb3 = 0;
 		memcpy(&pps_sdp.sb[0], dsc_packed_pps, sizeof(pps_sdp.sb));
-		enc2_update_gsp7_128_info_packet(enc1, &pps_sdp);
+		enc2_update_gsp7_128_info_packet(enc1, &pps_sdp, immediate_update);
 
 		/* Enable Generic Stream Packet 7 (GSP) transmission */
 		//REG_UPDATE(DP_SEC_CNTL,
-- 
2.25.1

