Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89694C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 18:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6102112BA4;
	Thu,  7 Jul 2022 18:03:05 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09432112A52
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 18:03:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7PtTNGErkcRclYS012r8FwRvYjjcNn9bLZU+c2fltSPf8AqJfu26d2Yr2GXTApQEia3XZpp4SQFGZufX8vEAhYlN0an0oZop1eeWsqa4B1BEeDZqVRy8Knn4qBEhGh2CuSK14ce3rvr5jxrg6YoRsIpGnbfCx65dvAn8gx09/ZKdiq+HrgmjGpmPa2a+iA/rcZB/3fcju1bk0q5eRmbT5zTsMioA3FHzIAb7Nz+2tOPSc2yf+LpYc6hTc9jcBDElzgtF5JSch6q/t+kXCeeekDzPQ3YXoCyXku1EK+p86/9p2b1eVdhuySkMzZBH9sr5LmA+QWKkZF7TVNe0U2xjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZs/XDLpYJtBys6slrOBj+cWmbHYzC0/N6PvWJgbs5U=;
 b=hmV0iPR6M9GGZrnN2PZ4cEiGymwVQW9948lDGBFQzSUn3AvEeIlhfR7x9+qdl2IXCI4Km0UOwEhIzrSjBs4ga33LLonfr34S61GEh+daxorRQtL0hqEYmuf4KPPzRWweA67Iol7qV6s2NhJlgaNcec8DcYT8MXTZmL7vH9joeAzD6K1MK7EjnSlkFNC8bWGggyx8yg2hNVHCNOjp1NxcmjVOhjocF9+/0QVeLKFrvhaVjH8+RishI7HWZ03XwFesQEzm0GiQxJHl49isSsO9wV9JA8rUDJcWT5bgzu2sS4LPanFfy0YOakJCic3PMLDpFEY1nS1qDxfUAjhXEjLB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZs/XDLpYJtBys6slrOBj+cWmbHYzC0/N6PvWJgbs5U=;
 b=lbMleQKAdNEH3G608qiBPgQUZCXRnQ58vq7M/lXwA1dDdAQJ0t2Y+GZiPtixFfNVu8cJbHS8JhgYSgbwquGHs6+LZ+W/oW9aiLizy4bEyR3W1cH6wN1KYsUx2eqLWJbMaoeiRBCz83YBJr0MzDtLjlYnpVxeVUZOlZWN+K51LO0=
Received: from MWHPR14CA0033.namprd14.prod.outlook.com (2603:10b6:300:12b::19)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 18:02:56 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12b:cafe::e7) by MWHPR14CA0033.outlook.office365.com
 (2603:10b6:300:12b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 7 Jul 2022 18:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 18:02:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 13:02:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 13:02:55 -0500
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 7 Jul 2022 13:02:54 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Add callback to set dig mode
Date: Thu, 7 Jul 2022 14:02:54 -0400
Message-ID: <20220707180254.1592836-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 905658b7-4301-4e14-2464-08da6042ebc1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9P4u2udN4N9pVWXccFXRFCrUIl2Ji7l5dpwsNWTb6gAKVJVqfKZtqD2HClptWfgiiXJ8q8qSWyPP+2cl81T7z8m+oGWgRuDQJASzmHZvbJpuuYEWG5v0wa9CkeMB2JaQGqz7BCuQgNGtKyVjszfQlfDOGOxX7j4dUlf6zIrTd7iBtkIGXG18xMQFwvR9KZX56gwyYy5r5L1TSELvBWq11hl4qoIbq3ZlgnyncQodiNdfxxBgdtWIYkvUlyLOsNy/lGQ601e8CwL1CWf51M34DO2UhFqfOGKYvWlyKmfLBqzG6HqtcZv/fLWD67Sky+WjUQswMfXJ9q0DEKDDvwmqpLEKlUHC9swSjTFUXK9P7n2FTjUZ+aQrz6pSxh+/S1F0SG9852CaSIMTQXzz5xn4fKb3vov//Ow/aFGvH1iAa+t5FdF2on8kI6pGn451t9tvn1C/8/foYF9NjTDAGocsJHycyu2B1pTn5/kg/JMx1ER4btVnn1sK4MXfpV10k0R3BGIrXgoXRNSeoxQwH6M439LaZyIGUv2Qbzz4KkM4/tr4N16OK5HUQgXPwjSi7/uuyDem6SSyoG0TMxR76UDo9+xpYmK2aBTs+9uAS8IrYIyTpwnIuDLv+dPacW2tmK/xUS9Y7vviEQW3pf2dlhxyJ0W/GR5TR2XReIOIdcQBWl3TDh1y0iiVupj3ZiaH8wJwkZRM5yUTgxA5FjZxenTwfdpjLf7oN90s6HVDtuJfaYP4Mxl3XZuZ5Czg+XX6fhE2Avj0k0oiyqFw2TDoeNVcE+VbUlOclDpXBhK3K+HAvQkyTD0Tz+LeN/gjLQcBCBqJ/HRuUGLAG41+of4gFCBXKpY+qx5GH7LvsULBnaShhiNbQCzVv0q/TPE3fBML8qR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(396003)(136003)(39860400002)(346002)(36840700001)(46966006)(40470700004)(40480700001)(47076005)(426003)(4326008)(186003)(478600001)(336012)(26005)(8676002)(6916009)(54906003)(70206006)(2616005)(70586007)(83380400001)(36756003)(7696005)(1076003)(40460700003)(86362001)(34020700004)(36860700001)(82310400005)(41300700001)(44832011)(5660300002)(2906002)(82740400003)(81166007)(316002)(356005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 18:02:56.3883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 905658b7-4301-4e14-2464-08da6042ebc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
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
Cc: Rodrigo.Siqueira@amd.com, aurabindo.pillai@amd.com, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why&How]
Add a missing callback to set DIG FIFO output pixel mode. This is used
when ODM combine is activated.

Fixes: e40fcd4afb3f ("drm/amd/display: add DCN32/321 specific files for Display Core")
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dcn32/dcn32_dio_stream_encoder.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index da7d2243664f..26648ce772da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -391,6 +391,16 @@ static void enc32_stream_encoder_reset_fifo(struct stream_encoder *enc)
 	}
 }
 
+static void enc32_set_dig_input_mode(struct stream_encoder *enc, unsigned int pix_per_container)
+{
+	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+
+	/* The naming of this field is confusing, what it means is the output mode of otg, which
+	 * is the input mode of the dig
+	 */
+	REG_UPDATE(DIG_FIFO_CTRL0, DIG_FIFO_OUTPUT_PIXEL_MODE, pix_per_container == 2 ? 0x1 : 0x0);
+}
+
 static const struct stream_encoder_funcs dcn32_str_enc_funcs = {
 	.dp_set_odm_combine =
 		enc32_dp_set_odm_combine,
@@ -436,6 +446,8 @@ static const struct stream_encoder_funcs dcn32_str_enc_funcs = {
 	.dp_set_dsc_pps_info_packet = enc3_dp_set_dsc_pps_info_packet,
 	.set_dynamic_metadata = enc2_set_dynamic_metadata,
 	.hdmi_reset_stream_attribute = enc1_reset_hdmi_stream_attribute,
+
+	.set_input_mode = enc32_set_dig_input_mode,
 };
 
 void dcn32_dio_stream_encoder_construct(
-- 
2.37.0

