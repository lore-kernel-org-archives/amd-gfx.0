Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BBF606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 06:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NZai2qY4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D944D10F619;
	Wed, 25 Nov 2026 06:57:21 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2875F10F619
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 06:57:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SeIFLjj9CwPCYWDVq7OXXaobBuJDQpDFbARbcd+6IX3+4krc8FMhFrOAoHKLA90WhIXiWEZhF6dz5mxGfLST442o/tKzzFSYM2CfZxBDwB1kIDu4kMFgoJht+FQfrCYLDB5l50dUPDrzt4ctubxkxe79Faf+GM6sDiaM29JNGcrAq0td5mfbenH0MjFJ1r/h6avFToPXR6JtLmZrmJdoo01n2wPCUtLLPK456yLCkVkTtWXl+bjQV36b/Jn0CI1DWXpB6cYXOndpe9AKYCMAOp4Xu56s2y8D35fAH0FQg7Mxe91aq1a2NonNWfQapKYOsrKL7xZCFh8mD/PeKInt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ydj9T+DX2nihlHpvsto4/T1gsSfy/SGw7gyKQCssLvU=;
 b=CoVlvBl5ocz+nJieXuoahYHdkIRYX8EQf7UD4ZZ3S4kmEWFOyHbAXhtdTjvEFptlglUlpNSyHezCnU05aF15crZ0KBbJG7qCY1Q1lbNc4cXYl1wJWujYZEMqr5/3SaBrvSUhxvqc2Oqv4Zz1tlk3PQ0OdV/VFA4G9EIS/jyM1Jtvu/Va9/OHVmhDTABWTU45TOWKkffpplSDlLA76iUzza7Y+Fk/2FLygisMhCGYQLBWJOaCO7u2xddhpIDgs+5axm6/dvRfVKyPH92YBM0LHdwpAoIHDGng65jEjjmhM6AMFBmEZBpQz92yVyYIBl2Env3rdAL0bC9SW0NwkIC78Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ydj9T+DX2nihlHpvsto4/T1gsSfy/SGw7gyKQCssLvU=;
 b=NZai2qY4CJl0ROAQ3ykKrDKZY8LBlvzR5NesF9sbp6QC7LwX7gfxlyg2vSG/DaGDKbGLxmSw9o4GkZGmPzNYkLC1iF2z8JTu+WqUeGEfJOMQiiQ8IE4cuie+ZtOTRXYXyg45Kj0B66D6FOMdYTUpKrcc9eiK5C1Rwxxzsll/PdA=
Received: from MW4PR04CA0099.namprd04.prod.outlook.com (2603:10b6:303:83::14)
 by CY8PR12MB8364.namprd12.prod.outlook.com (2603:10b6:930:7f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 06:57:13 +0000
Received: from EA8PEPF0000000A.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::a7) by MW4PR04CA0099.outlook.office365.com
 (2603:10b6:303:83::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 06:57:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 EA8PEPF0000000A.mail.protection.outlook.com (10.167.249.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 06:57:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:08 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 00:57:08 -0600
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 00:56:59 -0600
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Chris Park
 <chris.park@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 13/27] drm/amd/display: Set HDMI bypass earlier
Date: Wed, 25 Nov 2026 14:55:02 +0800
Message-ID: <20261125065631.3889665-14-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125065631.3889665-1-chen-yu.chen@amd.com>
References: <20261125065631.3889665-1-chen-yu.chen@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF0000000A:EE_|CY8PR12MB8364:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6805a4-b4d2-4997-5bd4-08df4ac1552d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|261022105027099003|261026121527099003|10067099003|261026140227099003|261022075727099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|261009221227099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: u5gQzsMHlocj5D+PLy30rUxJ8/owprjPMiYzJRtZF0/Co/IPZuJsAGH9VdY8G9aBXkjFJIlsBqCKbz+vEXGHrJ6oUsnjDDBjXtUA8wka8h8aG0Knt06Rno+C8aAUQtS7UPan/7O7TnpD4LkGTV/MzyiZhomM56zd744T9P0/bze6BIr2AmgC4E/gmbMiYTH0jEoOkm2mejUXGpndYjSN2cmv2MtuWKL68TcfyQ3LDROlNykKD/+B68/RxknMhguG5UEk2hJAuztZpq4FtP/svDJW4WGHynSpkfjn2bUspVsrvKVVTXHtt/MP2ndjaRmRiLDDOiQNeoZW6kR8Jlr/WUOtKuyykkw8JyElqGo9v06tBjTdtX/lFR/aseQ7NUJz0j8deZfgTB0mz6tWoF2Fp5jxsppHq9WJIvxf9LfwgDWOHsYLMqQRGnYgNiLlC75oXwjejpZzGAUiCq/1cmyQksYVilNNnMD2mfX0HBncUCNxpDcVxc8D8aqOYImL7UdTRKuRw1O+PsQOqTWPiJtNRIZVoJNgaFrPkhSFO+mYmHQ+MznR1/gCRY1uc8GEDm60A14kjhfRsCVeEGae18proyiA9Zq+ug5xLV7+vZ2Y1JRYk3h+WL9gxs1IqUUSPCsHPyH9RJRr8tWta7Jnq8weWmrB8/7tyJhIS8sjK9LDN5DXPBtMtAe5R+h9GSveeP6HxHvsaHhqFm+Fds9mdj+emA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(261022105027099003)(261026121527099003)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(261009221227099003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OBHU2kX+ObDd80iKugINoQEiFteSuGAtgSIWhkqKGWtkYM3k5CD8vnEBidiBDBBBhptgZvw7iv8u8nxU+K1Vkcf4A6eUcoOhPgGUByDFqRfQBZo8kTVNlA7ATyM553MnxRHW1clXd8Tos/63dh3ISWhbSOgi8w0x+Xg2uZlzhu/uEqf8fQMZRjb4lNfu6P0+96q5vOhFhvNIHf/8r7Xx4ij/Qm9CwBKfvY5n8qNCYkeWA8FPjYhu5M9AeXXDEse/tRmBWYnNPxiDzBubvl0xuJ/qG+2WZdraRQmKrquacadQ6ZfWryU+SZT02Yr2dB4TUewRgS73UcYRyHj4CJboDH5+wIRZKk55cqqsdU8pp93xha7KmqXNlT1mvcRelmLXoV4o9odhFXpIoqv/fOK5Dd10eYQnQfpSnV+wrSd5S0QiRnzcmSTPcy412kd+6+QI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 06:57:12.6768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6805a4-b4d2-4997-5bd4-08df4ac1552d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF0000000A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8364
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Charlene Liu <Charlene.Liu@amd.com>

[Why]
This is a HW-required change.

[How]
Enable the existing TMDS double-buffer bypass before the first
metadata packet-enable write. FRL behavior remains unchanged.

This mitigates lost updates but does not prevent V_UPDATE collisions.

Only update DCN42 or later for now.

Cc: Roman Li <roman.li@amd.com>
Cc: Chris Park <chris.park@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c     | 15 +++++++++++++++
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.h     |  4 ++++
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c       |  2 +-
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c       |  2 +-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
index 4616b6f76aeb..86111cebc944 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.c
@@ -436,6 +436,21 @@ void enc401_stream_encoder_enable(
 	}
 }
 
+void enc401_stream_encoder_enable_with_hdmi_db_bypass(
+	struct stream_encoder *enc,
+	enum signal_type signal,
+	bool enable)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	if (enable && signal == SIGNAL_TYPE_HDMI_TYPE_A) {
+		/* Bypass HDMI double buffering before enabling the stream. */
+		REG_UPDATE(HDMI_DB_CONTROL, HDMI_DB_DISABLE, 1);
+	}
+
+	enc401_stream_encoder_enable(enc, signal, enable);
+}
+
 void enc401_stream_encoder_dp_set_stream_attribute(
 	struct stream_encoder *enc,
 	struct dc_crtc_timing *crtc_timing,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
index d6b00cd246b1..dea7f941675d 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn401/dcn401_dio_stream_encoder.h
@@ -226,6 +226,10 @@ void enc401_stream_encoder_enable(
 	struct stream_encoder *enc,
 	enum signal_type signal,
 	bool enable);
+void enc401_stream_encoder_enable_with_hdmi_db_bypass(
+	struct stream_encoder *enc,
+	enum signal_type signal,
+	bool enable);
 void enc401_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container);
 void enc401_stream_encoder_map_to_link(
 		struct stream_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
index b7671d41ea24..98dc158e7094 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn42/dcn42_dio_stream_encoder.c
@@ -552,7 +552,7 @@ static const struct stream_encoder_funcs dcn42_str_enc_funcs = {
 	.dp_set_dsc_pps_info_packet = enc42_dp_set_dsc_pps_info_packet,
 	.set_dynamic_metadata = enc401_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc42_reset_hdmi_stream_attribute,
-	.enable_stream = enc401_stream_encoder_enable,
+	.enable_stream = enc401_stream_encoder_enable_with_hdmi_db_bypass,
 
 	.set_input_mode = enc401_set_dig_input_mode,
 	.enable_fifo = enc35_enable_fifo,
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
index b645914c1c71..3fc503681177 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stream_encoder.c
@@ -506,7 +506,7 @@ static const struct stream_encoder_funcs dcn60_str_enc_funcs = {
 	.dp_set_dsc_pps_info_packet = enc60_dp_set_dsc_pps_info_packet,
 	.set_dynamic_metadata = enc401_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc60_reset_hdmi_stream_attribute,
-	.enable_stream = enc401_stream_encoder_enable,
+	.enable_stream = enc401_stream_encoder_enable_with_hdmi_db_bypass,
 
 	.set_input_mode = enc401_set_dig_input_mode,
 	.enable_fifo = enc35_enable_fifo,
-- 
2.43.0

