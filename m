Return-Path: <SRS0=Wmcu=74=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2BDC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 19:02:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD022067B
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2020 19:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="chF4KUVa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD022067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0586E4CF;
	Mon, 15 Jun 2020 19:02:07 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F05896E4CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2020 19:02:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RAv4xcJdAIbbyg0JH6KzI96hyloeRhZqUsmVGNm1XeWpQhGq+zfEXRfdfj/N0kTZsNv3T6rLkPojZfnAhezu0KeseYwztNqp1sVSZBXmXBNdG/hd8d7M1KDfmf/3fSOtnrCPwvPJLm8z1BqNYKrMZS6BRb2mP2db56z7WEZC3XNv+MABaUCPH9r5W+AbMjjP9/lSH+qslR9e15wKFvowwErPY7DksbyKh296InD2MF833E5+geV5wKHg07y9CzAhbYvkkq4RPQSpA+5SrGE/4uKK3JF7EZn8dwOCGCul0m5vd4viORuwE+UOEaZ1mOCrPnNJKhQj/6AqDyANhWH5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvQTgPZvFD5cfnoFYt5a7ltvR1kBryF/6zoVKYJpLPA=;
 b=Zz8m+pgNzuo/xQMMZSOA0LOnOrDY0K6QfxV8/lB7JujbhP2oj67miW5CHzoM875EnzGGCyDH4jae/9jDHKeHh/M26C4sqgCotNDg91M12FTygO8uc9oQq6i6U8O0w5iew4hZ4q7Q6cO1U1wAw75b3rZKySdF1VvHHDttcu0y7gnRPcMkiOfEMTUSUV1MIvrJt6jM8uyfPhFW+FSj0rjxh/fm05ZZPbRnKMYP/SsXHYR8gVoy0tgmdhFT/tZ4dUUT5vz18FW56h+UGvnG/jrTIoQDl7MIAmUO2CqI2bY6eSkgxvii34EIrIYLl6EDro1PYgiJ9OYo8UmmF+YBBky9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvQTgPZvFD5cfnoFYt5a7ltvR1kBryF/6zoVKYJpLPA=;
 b=chF4KUVa8apDDp26263iQA3POVWV3UNCrBF+4MdEsUhrP85rP4jGACO5z2R2yYbnTOh95ciepQzeY1BbXttsFtiK7pXJP4/3MPYXwKo0xFp6aijNxVVEjWsYpn6WLftcaancHnwKCw6tGbXXgkXgFzhVXDc2Sf28GFQrxHxo8TE=
Received: from DM5PR05CA0019.namprd05.prod.outlook.com (2603:10b6:3:d4::29) by
 BN6SPR00MB245.namprd12.prod.outlook.com (2603:10b6:404:22::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18; Mon, 15 Jun 2020 19:01:58 +0000
Received: from DM6NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::2d) by DM5PR05CA0019.outlook.office365.com
 (2603:10b6:3:d4::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.10 via Frontend
 Transport; Mon, 15 Jun 2020 19:01:58 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT056.mail.protection.outlook.com (10.13.173.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 19:01:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 15 Jun
 2020 14:01:57 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 15 Jun
 2020 14:01:57 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 15 Jun 2020 14:01:55 -0500
From: "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/display: Update bounding box states
Date: Mon, 15 Jun 2020 15:01:35 -0400
Message-ID: <20200615190135.16562-2-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200615190135.16562-1-Jerry.Zuo@amd.com>
References: <20200615190135.16562-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966005)(6916009)(426003)(83380400001)(4326008)(70206006)(70586007)(336012)(2616005)(5660300002)(81166007)(86362001)(47076004)(26005)(8936002)(82740400003)(8676002)(7696005)(54906003)(15650500001)(478600001)(356005)(186003)(1076003)(2906002)(36756003)(82310400002)(6666004)(316002);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1569343b-63f6-4490-caef-08d8115e9408
X-MS-TrafficTypeDiagnostic: BN6SPR00MB245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6SPR00MB245144A271280EB2EFF0051E59C0@BN6SPR00MB245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jsvsTkbXlJYCXGTaYd+7YLei1h8NXG+NUarVid+BBTO+iMMAswWhciM9/4wUrPD2YBcM0eB5yUob1phBQAhIFw//TXVNIcfiPeOJZYfIVTMriqwkaxtrw9veF9Exkx7ax4ue+BZhQF7uaJBjTCAV9o2UXDKKKpMksEupWbM/+MKKtnE4DQ/3732vvmEa2so8ljvHaz/z/azXQRvG5SAHbdvRgpvpZmAOkAZO7b7BxkChbCTT4SpI+BOo8HPGsncSy/kNTqgvoCZAiBY7Shvy6IbkjzrufHTsvDWd73C2i6pCTUni4pcVviMP2tROWOaFRkFruu/DyFcIDwMqS+IhoyUb0ErIZv8LEG2MfxMyIssQxrfFVwNZfLMewTOMSw237/q7+Yslrd/Nb4O9gUTvQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 19:01:58.0287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1569343b-63f6-4490-caef-08d8115e9408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6SPR00MB245
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
Cc: Alexander.Deucher@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>,
 harry.wentland@amd.com, Nicholas.Kazlauskas@amd.com,
 Alvin Lee <alvin.lee2@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
We need to update each p-state in the bounding box

[How]
Update states when assigning values to clocks

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c | 65 +++++++------------
 1 file changed, 23 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 821bde9a376e..27e84d90306b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -168,17 +168,18 @@ struct _vcs_dpi_ip_params_st dcn3_0_ip = {
 
 struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 	.clock_limits = {
-			/* State 0 should have clocks set below WM set B minimums */
 			{
 				.state = 0,
-			},
-			/* State 1 is max */
-			{
-				.state = 1,
+				.dispclk_mhz = 1217.0,
+				.dppclk_mhz = 1217.0,
+				.phyclk_mhz = 810.0,
+				.phyclk_d18_mhz = 667.0,
+				.socclk_mhz = 1200.0,
+				.dscclk_mhz = 405.6,
 			},
 		},
 	.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
-	.num_states = 2,
+	.num_states = 1,
 	.sr_exit_time_us = 12,
 	.sr_enter_plus_exit_time_us = 20,
 	.urgent_latency_us = 4.0,
@@ -204,6 +205,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_0_soc = {
 	.round_trip_ping_latency_dcfclk_cycles = 191,
 	.urgent_out_of_order_return_per_channel_bytes = 4096,
 	.channel_interleave_bytes = 256,
+	.num_banks = 8,
 	.gpuvm_min_page_size_bytes = 4096,
 	.hostvm_min_page_size_bytes = 4096,
 	.dram_clock_change_latency_us = 404,
@@ -2354,43 +2356,22 @@ static void dcn30_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
 			dcn3_0_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
 			dcn3_0_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
 			dcn3_0_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
-		}
-	}
 
-	/* Fill all states with max values of all other clocks */
-	for (i = 0; i < dcn3_0_soc.num_states; i++) {
-		/* Some clocks can come from bw_params, if so fill from bw_params[1], otherwise fill from dcn3_0_soc[1] */
-		/* Temporarily ignore bw_params values */
-
-		/* DTBCLK */
-		/*if (bw_params->clk_table.entries[0].dtbclk_mhz)
-			dcn3_0_soc.clock_limits[i].dtbclk_mhz = bw_params->clk_table.entries[1].dtbclk_mhz;
-		else*/
-			dcn3_0_soc.clock_limits[i].dtbclk_mhz = dcn3_0_soc.clock_limits[1].dtbclk_mhz;
-
-		/* DISPCLK */
-		/*if (bw_params->clk_table.entries[0].dispclk_mhz)
-			dcn3_0_soc.clock_limits[i].dispclk_mhz = bw_params->clk_table.entries[1].dispclk_mhz;
-		else*/
-			dcn3_0_soc.clock_limits[i].dispclk_mhz = dcn3_0_soc.clock_limits[1].dispclk_mhz;
-
-		/* DPPCLK */
-		/*if (bw_params->clk_table.entries[0].dppclk_mhz)
-			dcn3_0_soc.clock_limits[i].dppclk_mhz = bw_params->clk_table.entries[1].dppclk_mhz;
-		else*/
-			dcn3_0_soc.clock_limits[i].dppclk_mhz = dcn3_0_soc.clock_limits[1].dppclk_mhz;
-
-		/* PHYCLK */
-		/*if (bw_params->clk_table.entries[0].phyclk_mhz)
-			dcn3_0_soc.clock_limits[i].phyclk_mhz = bw_params->clk_table.entries[1].phyclk_mhz;
-		else*/
-			dcn3_0_soc.clock_limits[i].phyclk_mhz = dcn3_0_soc.clock_limits[1].phyclk_mhz;
-
-		/* These clocks cannot come from bw_params, always fill from dcn3_0_soc[1] */
-		/* FCLK, PHYCLK_D18, SOCCLK, DSCCLK */
-		dcn3_0_soc.clock_limits[i].phyclk_d18_mhz = dcn3_0_soc.clock_limits[1].phyclk_d18_mhz;
-		dcn3_0_soc.clock_limits[i].socclk_mhz = dcn3_0_soc.clock_limits[1].socclk_mhz;
-		dcn3_0_soc.clock_limits[i].dscclk_mhz = dcn3_0_soc.clock_limits[1].dscclk_mhz;
+			/* Fill all states with max values of all other clocks */
+			dcn3_0_soc.clock_limits[i].dtbclk_mhz = dcn3_0_soc.clock_limits[0].dtbclk_mhz;
+			dcn3_0_soc.clock_limits[i].dispclk_mhz = dcn3_0_soc.clock_limits[0].dispclk_mhz;
+			dcn3_0_soc.clock_limits[i].dppclk_mhz = dcn3_0_soc.clock_limits[0].dppclk_mhz;
+			dcn3_0_soc.clock_limits[i].phyclk_mhz = dcn3_0_soc.clock_limits[0].phyclk_mhz;
+			/* These clocks cannot come from bw_params, always fill from dcn3_0_soc[1] */
+			/* FCLK, PHYCLK_D18, SOCCLK, DSCCLK */
+			dcn3_0_soc.clock_limits[i].phyclk_d18_mhz = dcn3_0_soc.clock_limits[0].phyclk_d18_mhz;
+			dcn3_0_soc.clock_limits[i].socclk_mhz = dcn3_0_soc.clock_limits[0].socclk_mhz;
+			dcn3_0_soc.clock_limits[i].dscclk_mhz = dcn3_0_soc.clock_limits[0].dscclk_mhz;
+		}
+		/* re-init DML with updated bb */
+		dml_init_instance(&dc->dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
+		if (dc->current_state)
+			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_0_soc, &dcn3_0_ip, DML_PROJECT_DCN30);
 	}
 
 	/* re-init DML with updated bb */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
