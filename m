Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D5CC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2669B2067C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 22:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c2UBL3vf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2669B2067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD6B6EC21;
	Fri, 21 Aug 2020 22:58:09 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700055.outbound.protection.outlook.com [40.107.70.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F57D6EC21
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 22:58:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFavZBomK/UBAfqBYgwu8jxP13bts0njob8D5dojoBiKIkRY8PyAmhXCMt/4LLOoQUmwPFQ06+LWiBrJEN7vQbKXLli4faIUniqVWFiLTrvP+bl0qc2cGhATzfCicz321iRc8OirdgCd0zJ67oGLZ42obn2/LXT+B7m7Og3+xdGPmyQaSJ836PzyvFQokJYAsOQD9zN/7/jQnYJcxI7A+WzxmXZraicC4YL2W3cnnIJRHY8fHsLWqiUjmSMtfR+/ZYI7uwpEUsfP8xe1zytdkHwoklxGbK8J14JOaVFlZxgyET+tA1K9CFH9MgThDQxrXL+qjtwGK58DiyeMDAR9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXVV+lknNLX5k/rMWN2wSC0drN48RbYM+kEcYdEF/YM=;
 b=TYFcG7gXrStpH0oIAq+5Q5f2rNWMnBxo4QcI3Q9sbrRe1ZCASkaYYSF3AguuMJh7dZAq52VL8ltuzX38cMeTF0k/TFXEKsYPmIKW1AExOwtRFQA17fYQ03ayo1zoulIF0iQfz5YAbW4nP3dXmoj7IHPXRpwM83x+Uxk3YPHUcrO5q5JHKfdUOI1jHNWCBTDPyx446RfvHEK/meZE6obBA2dyfjD116INzED6K5pSTZ5eG7EiUrgUWj6/NbJ1BQ3WYxy4LNs2QUPVqztf0Qr65s6auBFd4qhmL4wzg7Sb7/cbyvltskAxTAkT4RDLSrHNfHe7Ai6pix+rnItrxbFsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXVV+lknNLX5k/rMWN2wSC0drN48RbYM+kEcYdEF/YM=;
 b=c2UBL3vfhb3eXsixujloYJBe3/Ci43bQmsy0V9Vt2DlZXhxrDl5zbWFEear+je+Q2q6ln19elM/aAcAbdDRD726QiZ2pXwTF6FAFlW1FR7arN4+D2TJGzJo44hZ33Rr6hjHNz5a4IwisiStDFGTmMXrlez3OUgN4Xa1l4rFWvGg=
Received: from DM5PR06CA0072.namprd06.prod.outlook.com (2603:10b6:3:37::34) by
 BL0PR12MB2561.namprd12.prod.outlook.com (2603:10b6:207:3e::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.25; Fri, 21 Aug 2020 22:58:02 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:37:cafe::c8) by DM5PR06CA0072.outlook.office365.com
 (2603:10b6:3:37::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend
 Transport; Fri, 21 Aug 2020 22:58:01 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 22:58:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:01 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 17:58:00 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 17:57:55 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amd/display: Send H14b-VSIF specified in HDMI
Date: Fri, 21 Aug 2020 18:57:03 -0400
Message-ID: <20200821225709.136571-4-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821225709.136571-1-eryk.brol@amd.com>
References: <20200821225709.136571-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 663070be-1145-43ca-8cbe-08d84625a7d2
X-MS-TrafficTypeDiagnostic: BL0PR12MB2561:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2561C53BDDE0FA15B9543C24E55B0@BL0PR12MB2561.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DrKo0AybkgfkZOafG01VAEZ18qAg8uzp6y1XEleBOX/KnDUfm1nYeSFjKJZCMXEA3NnuG4hrkCij8pUX8+oB/nxXq+D7D5Y265i1ngiWdVJoBA2yJS7g5PlbysWPHdDB1vyLX0wmlI+AGdkE4/QqddktI9mj2nE18vW23H4YIPyEsEhzCOH6RIZ55dtCZ/vOzKfE8Roy1RkDOwT6TBWE8pEZ+3E/srbZCl6OkahFuJKbiWbbnyL8W2QjFW/Y+UXzSFS1SKld1rlW5bFEcqJGNcBJNfsxt7SCZQiOgasPx1NLY1/6zOCeuDUQ250n3uvH3OXWrd5rRGteWUoEaYihLrD8Z9VwtD7NZzIp7QEEoHgcrDkq11Ulvft4ofWv08qvLLgwtwL9otH3vTLPYbJGMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(44832011)(5660300002)(8936002)(6916009)(70206006)(426003)(2616005)(70586007)(1076003)(83380400001)(186003)(8676002)(6666004)(82740400003)(4326008)(316002)(36756003)(336012)(47076004)(356005)(86362001)(2906002)(478600001)(82310400002)(54906003)(81166007)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 22:58:01.5423 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 663070be-1145-43ca-8cbe-08d84625a7d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2561
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Roman Li <Roman.Li@amd.com>,
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Current function excludes the logic to generate H14b-VSIF. Now it
constructs HF-VSIF only and causes HDMI compliace test fail.

[How]
According to HDMI spec, source devices shall utilize the H14b-VSIF
whenever the signaling capabilities of the H14b-VSIF allow this.

Here keep the logic for HF-VSIF and add H14b-VSIF construction part.

Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Reviewed-by: Roman Li <Roman.Li@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 ++-
 .../amd/display/modules/inc/mod_info_packet.h    |  2 +-
 .../display/modules/info_packet/info_packet.c    | 16 ++--------------
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3f86a482f2a2..ee5271286825 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4757,7 +4757,8 @@ create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
 	update_stream_signal(stream, sink);
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
-		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket, false, false);
+		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
+
 	if (stream->link->psr_settings.psr_feature_enabled) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
index 13c57ff2abdc..1ab813b4fd14 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_info_packet.h
@@ -37,6 +37,6 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 		struct dc_info_packet *info_packet);
 
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue);
+		struct dc_info_packet *info_packet);
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 7cd8a43d1889..0fdf7a3e96de 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -421,15 +421,13 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
  *****************************************************************************
  */
 void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
-		struct dc_info_packet *info_packet, int ALLMEnabled, int ALLMValue)
+		struct dc_info_packet *info_packet)
 {
 		unsigned int length = 5;
 		bool hdmi_vic_mode = false;
 		uint8_t checksum = 0;
 		uint32_t i = 0;
 		enum dc_timing_3d_format format;
-		bool bALLM = (bool)ALLMEnabled;
-		bool bALLMVal = (bool)ALLMValue;
 
 		info_packet->valid = false;
 		format = stream->timing.timing_3d_format;
@@ -442,20 +440,13 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 				&& format == TIMING_3D_FORMAT_NONE)
 			hdmi_vic_mode = true;
 
-		if ((format == TIMING_3D_FORMAT_NONE) && !hdmi_vic_mode && !bALLM)
+		if ((format == TIMING_3D_FORMAT_NONE) && !hdmi_vic_mode)
 			return;
 
 		info_packet->sb[1] = 0x03;
 		info_packet->sb[2] = 0x0C;
 		info_packet->sb[3] = 0x00;
 
-		if (bALLM) {
-			info_packet->sb[1] = 0xD8;
-			info_packet->sb[2] = 0x5D;
-			info_packet->sb[3] = 0xC4;
-			info_packet->sb[4] = HF_VSIF_VERSION;
-		}
-
 		if (format != TIMING_3D_FORMAT_NONE)
 			info_packet->sb[4] = (2 << 5);
 
@@ -490,9 +481,6 @@ void mod_build_hf_vsif_infopacket(const struct dc_stream_state *stream,
 		info_packet->hb1 = 0x01;
 		info_packet->hb2 = (uint8_t) (length);
 
-		if (bALLM)
-			info_packet->sb[5] = (info_packet->sb[5] & ~0x02) | (bALLMVal << 1);
-
 		checksum += info_packet->hb0;
 		checksum += info_packet->hb1;
 		checksum += info_packet->hb2;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
