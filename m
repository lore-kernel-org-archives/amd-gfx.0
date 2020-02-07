Return-Path: <SRS0=+f/p=33=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7558DC35242
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF4720720
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2020 15:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y1tMW3SU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF4720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B08EF6FD05;
	Fri,  7 Feb 2020 15:50:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A1506FD00
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2020 15:50:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8MPV8W3qbW8XcdIBV7YCo3iyPUHwEGOWUZz9aVungc7pceESb/qsYFUKyRgDLuOuixuF3bqkdMYHK5KNqTNRIsF79IuwgNfX+n/HCHOm4U/yV5zJIbEoXdVzoPP1714HFcEWGpBClt/nh5pQBdXJeoZFH37NkEElbR9Q9TWVWfrfW+Q6/KuSg7foht4ALpIyIRJDjuzsKZPh2H34bOy10Hxiu61KatyqPBAHyW+rci/W9RcNWKSRbdUDkIp8qkNZT/YFv5boVlCNEUle/aFoac8GeIzX5QBY9lf8i2pI87eug39LDf50oLxV/gbmc0SnjeH5Rh90dpy1BFl044Xmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeUQFjSIkuOJRtJZPoN2FoGgEGkwY+VgXBA1G9gv/cA=;
 b=no8jq5zmi2NjB5dWO2zpS300RIXSj40gnTzCZSrbbmh/QHuyIYmdmYbyDW5XHdM53+YXA/zqaFwcFTtueC7PDnx04n1V6Pjm64S9BhVf+oTRtajHhUvIe/JEP3y0IcK0YB1yT64wvJKN0cwjzoc3vnqxmtR3RUtAuLVmA6GHMMOvSvrmWi4SQpci3YeZ8l5NYs4G9J1/B3/KwNC1h8STDkUWpX5/JhWRDGTjTo8hfRhqLkrlHWpEOFC1it7p0qvme3gzqJg85HNuf0DcSvZwXfQzyHMbK/kudinqr4IQ55xX7W69b6xoWkQwLQ5O6Qtt6gznTwvZXyw8ozi27BQTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WeUQFjSIkuOJRtJZPoN2FoGgEGkwY+VgXBA1G9gv/cA=;
 b=Y1tMW3SUk0wvlgXR9H8FAqjo9WWhULN47TsjONrfOEZyF7608Va2O9vV3q6vFd2+WK+7h8wsaCzFaB/b/co/qfnvCbCcNHqkLJFtSu0uJLeTbLNl991PX501ghnb13x6lFbslZxJqDSpHR52KHpO0qDiSST/Pe7xwQ/Wh5CZzdw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from DM5PR12MB2519.namprd12.prod.outlook.com (52.132.141.150) by
 DM5PR12MB2440.namprd12.prod.outlook.com (52.132.142.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 7 Feb 2020 15:50:45 +0000
Received: from DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43]) by DM5PR12MB2519.namprd12.prod.outlook.com
 ([fe80::3506:db14:d616:9f43%6]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 15:50:45 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/17] drm/amd/display: Pass override OUI in to dc_init_data
Date: Fri,  7 Feb 2020 10:49:57 -0500
Message-Id: <20200207155010.1070737-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
References: <20200207155010.1070737-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To DM5PR12MB2519.namprd12.prod.outlook.com
 (2603:10b6:4:b5::22)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Fri, 7 Feb 2020 15:50:43 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 531de227-8e2c-4c2d-f44d-08d7abe57d54
X-MS-TrafficTypeDiagnostic: DM5PR12MB2440:|DM5PR12MB2440:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24403B37F2B8D5DA7A1D9E5F981C0@DM5PR12MB2440.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(199004)(189003)(8676002)(36756003)(2906002)(66556008)(186003)(6916009)(81156014)(81166006)(8936002)(16526019)(66946007)(66476007)(5660300002)(478600001)(19627235002)(6486002)(1076003)(956004)(2616005)(4326008)(7696005)(26005)(54906003)(316002)(6666004)(52116002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2440;
 H:DM5PR12MB2519.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uMvrYMg9FOKD4WelqCrcskk8In/3C1/MePex3+/s973N8bzg1NQ2FTwLr8I8Ka7brzazC6gOmjsvrqymADvWHCjMgN/XEpOtgVy/kKx1ToqU8XW8AWOGE/d7IsDQy5M4g57yfFCmCyLXsfYI+UtSEEj8tyLHDDfQY9A2tRgfYOmUyMxRAqVCY08iFuqMTc4UE6x0HmOv7FD6LBQzqpoP/NcUKgypmSz6pcLBNnpuCDzOHU53uPKulrM4XObMqRHKy1uGinmpfzL15cgiqtSduv1tvfH8MakkBdFq2hMOyhQ++DayvVvvpRDVu8M1uRMjoVK2RUU+EnWqUFo3bd4Mk8UYyoSenRT9IaN3FVXksASKEGadc0TwD/fVFrmY18vRWxYILwsL9t6zL22Cj0UVrBpoHwyNI8wGN50QY5fPbEbGzIz6pRQc6/6u1iwNFzUN
X-MS-Exchange-AntiSpam-MessageData: hN5g6GLdMqfPuCjYuUYnA5zzj659eqzU2d5B4ZGC6BhO9fYLRxnC6AAMm2P1KuArU7Mo/Zd4TdKbMU1hQbge1M88xtdujDPBusGt07SBZctCY1sPf4c5iAtVr/K+3HV1Jn1a+LajArM7OOZHBrAMUA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 531de227-8e2c-4c2d-f44d-08d7abe57d54
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 15:50:43.7293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1S1CyCS6bl+qDU2szlLJ6AM9fpNVTr5X7263XEwjTvtpPjvPSmMDMUBeplodhahDLYgvpmSGXOrb5gyuQOdXKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2440
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Harry.Wentland@amd.com, Calvin Hou <Calvin.Hou@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Calvin Hou <Calvin.Hou@amd.com>

[WHY]
Vendor dongle requires propietary OUI and handshake sequence.

[HOW]
Add a new structure to dc_init_data, to allow creator to pass
an override vendor_oui. This value will be written to DP_SOURCE_OUI
instead of AMD signature, when dpcd_set_source_specific_data is
called.

Signed-off-by: Calvin Hou <Calvin.Hou@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 41 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 14 +++++++
 4 files changed, 41 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 40878b86a05d..7513aa71da38 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -701,7 +701,7 @@ static bool dc_construct(struct dc *dc,
 		dc_ctx->created_bios = true;
 	}
 
-
+	dc->vendor_signature = init_params->vendor_signature;
 
 	/* Create GPIO service */
 	dc_ctx->gpio_service = dal_gpio_service_create(
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c5b45d17e8cd..3bc05fa93ed5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -4179,25 +4179,32 @@ void dp_set_fec_enable(struct dc_link *link, bool enable)
 
 void dpcd_set_source_specific_data(struct dc_link *link)
 {
-	struct dpcd_amd_signature amd_signature;
 	const uint32_t post_oui_delay = 30; // 30ms
 
-	amd_signature.AMD_IEEE_TxSignature_byte1 = 0x0;
-	amd_signature.AMD_IEEE_TxSignature_byte2 = 0x0;
-	amd_signature.AMD_IEEE_TxSignature_byte3 = 0x1A;
-	amd_signature.device_id_byte1 =
-			(uint8_t)(link->ctx->asic_id.chip_id);
-	amd_signature.device_id_byte2 =
-			(uint8_t)(link->ctx->asic_id.chip_id >> 8);
-	memset(&amd_signature.zero, 0, 4);
-	amd_signature.dce_version =
-			(uint8_t)(link->ctx->dce_version);
-	amd_signature.dal_version_byte1 = 0x0; // needed? where to get?
-	amd_signature.dal_version_byte2 = 0x0; // needed? where to get?
-
-	core_link_write_dpcd(link, DP_SOURCE_OUI,
-			(uint8_t *)(&amd_signature),
-			sizeof(amd_signature));
+	if (!link->dc->vendor_signature.is_valid) {
+		struct dpcd_amd_signature amd_signature;
+		amd_signature.AMD_IEEE_TxSignature_byte1 = 0x0;
+		amd_signature.AMD_IEEE_TxSignature_byte2 = 0x0;
+		amd_signature.AMD_IEEE_TxSignature_byte3 = 0x1A;
+		amd_signature.device_id_byte1 =
+				(uint8_t)(link->ctx->asic_id.chip_id);
+		amd_signature.device_id_byte2 =
+				(uint8_t)(link->ctx->asic_id.chip_id >> 8);
+		memset(&amd_signature.zero, 0, 4);
+		amd_signature.dce_version =
+				(uint8_t)(link->ctx->dce_version);
+		amd_signature.dal_version_byte1 = 0x0; // needed? where to get?
+		amd_signature.dal_version_byte2 = 0x0; // needed? where to get?
+
+		core_link_write_dpcd(link, DP_SOURCE_OUI,
+				(uint8_t *)(&amd_signature),
+				sizeof(amd_signature));
+
+	} else {
+		core_link_write_dpcd(link, DP_SOURCE_OUI,
+				link->dc->vendor_signature.data.raw,
+				sizeof(link->dc->vendor_signature.data.raw));
+	}
 
 	// Sink may need to configure internals based on vendor, so allow some
 	// time before proceeding with possibly vendor specific transactions
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 6e2e5e24daaf..8c88706040a7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -527,6 +527,7 @@ struct dc {
 	struct compressor *fbc_compressor;
 
 	struct dc_debug_data debug_data;
+	struct dpcd_vendor_signature vendor_signature;
 
 	const char *build_id;
 	struct vm_helper *vm_helper;
@@ -573,6 +574,7 @@ struct dc_init_data {
 	 * available in FW
 	 */
 	const struct gpu_info_soc_bounding_box_v1_0 *soc_bounding_box;
+	struct dpcd_vendor_signature vendor_signature;
 };
 
 struct dc_callback_init {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index f762f35f529d..bb2730e9521e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -432,6 +432,20 @@ struct dp_sink_hw_fw_revision {
 	uint8_t ieee_fw_rev[2];
 };
 
+struct dpcd_vendor_signature {
+	bool is_valid;
+
+	union dpcd_ieee_vendor_signature {
+		struct {
+			uint8_t ieee_oui[3];/*24-bit IEEE OUI*/
+			uint8_t ieee_device_id[6];/*usually 6-byte ASCII name*/
+			uint8_t ieee_hw_rev;
+			uint8_t ieee_fw_rev[2];
+		};
+		uint8_t raw[12];
+	} data;
+};
+
 struct dpcd_amd_signature {
 	uint8_t AMD_IEEE_TxSignature_byte1;
 	uint8_t AMD_IEEE_TxSignature_byte2;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
