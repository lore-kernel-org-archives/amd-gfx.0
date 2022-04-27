Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CD7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 03:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E8CE10F3C3;
	Wed, 27 Apr 2022 03:02:00 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 705B610F3C4
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 03:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESFkFRSbGF+d3E//W1btD1/aB/0ReKH1vOgLYJnflUcbh32AcN0lU137CT9RFhQSDmNtQQqNjpyA4wObfVswwZeUvnvj4xGclI5R4w6G5/26Yz0Pei0lwTiGNSqoE2SXUelUQL4W5lIHj1jSNjej+sYopgz9XQFuoCTZ2oicV1eE1UWK9LcNZpkjRGBSI1DjQwR3xBP014bDlIv0iBT2NdC3vIch7eglwXFoYyRSJYtzb+7a2vtYVgIBp1f0BTSnK5zEpc7zNHwA7Nt0KHgmxjvuhe8g8c+O+KZjbjp6aX/k9LPRMnreRGKmguinqoEEr6NDRsEmP3AScX6C02AGqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n71X2guFtaEkJchuL7fqEP2f9HcALtx51c1AczhY8JQ=;
 b=hxczBr9b33Zon+eVDUO266M3f39Mk/OqBbgjEDhlo7X/wIpOl2g9uLAr2q/EXOK/i9YQR9T5OA/LblghNX30r98x0eGKyuY0Hs0nK2pjVz2yFHA2/UCD6qNnHzjrno2pkeWgJOOW+K6G1mzO3BUx8UKECl6Pjy/yHhUStuqzzV89Q9hcqXFQuc/GhAZ/WZ/zxH/pmN8LovMmmtj/cCRcAYmFADgAGIfz/sDGclAqc8wP9wLeaIUcl2qGXFgSooDyY5EY3kzyXIlK2ihQ645AXB/iH4i88C1FZPqQKvEWGdtPfpe9nnY3BzI2K+wd1lMWBlr6NNocPIQpcH/DnKs9Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n71X2guFtaEkJchuL7fqEP2f9HcALtx51c1AczhY8JQ=;
 b=n1yvSkgOXi2jP//F+n/r+QnomoIxkJ3V37P5SkgNa/ev7WlYLgczvhCc7z+9k7UplIS0L6SKBTSunjRF6jyVpZM4K9hhcjOaCUTMal+KXr7SWsEi4fMeh+V1m+9aFltDvSFXqZT1ojfWbkVEpr7t4r4YdJloRnNrUdokDYGYyX8=
Received: from BN9PR03CA0671.namprd03.prod.outlook.com (2603:10b6:408:10e::16)
 by DM5PR1201MB0012.namprd12.prod.outlook.com (2603:10b6:3:e7::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 27 Apr
 2022 03:01:56 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::62) by BN9PR03CA0671.outlook.office365.com
 (2603:10b6:408:10e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 03:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 03:01:56 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 22:01:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 20:01:54 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Tue, 26 Apr 2022 22:01:51 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amd/display: Add new DSC interface to disconnect from
 pipe
Date: Wed, 27 Apr 2022 11:00:56 +0800
Message-ID: <20220427030059.1242868-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220427030059.1242868-1-Wayne.Lin@amd.com>
References: <20220427030059.1242868-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8a3dc21-7536-485e-12c0-08da27fa49f3
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0012:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0012CE5A2E7FD1AE541DD707FCFA9@DM5PR1201MB0012.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiemcHxDPFrnCTkXTS7lJQFadrjVn8pACit7QQYiiR7GWw2ll97DPffZznb3I3RO2yuqQlODEQIp+vwNtp7L9e04+Pa4qzO31g84p//pIL7Ngf4pywH60X8ouQw5dXbjm4yp4+Z2bzloAPQgL6yf65r/yIFsIuLnEtn2hAprxLOIeYn3cSpIc7dKr/NUSmmobKunfLu3wuWlxaPNS9WrcgDaNKg6PbV+I/1ukD7k9F7sPKk0sJWt7Fq0999ZftV/UfuuCiH1eAtbsVJ8UbM4fvV2pZnG8g8uhldj8gANou1A4bna9Lq1dI6+eaE6S9JSxw2XtEgQuTD5yRlc4UuuckOLF28eejJkRABjmgzDdtkejI2si8KOqdttis4667FpzyjFjbo6tZM0FqV8/O4i2iYvq9+AK3N8w4eIoWMHO8eGzIc78uN9cTHp+ZRsVP9+XjpVuiY8ynYJ4ZXj/p4XPBK5t1WZRIm0OEA5O55OtfSHA+YkBhaiWaWNsmC2jLl3ZoUP1fY1UxRblvG22IJY72wkITHfwtiOBIJuTVJS1lXfpc5OygEAnhOidk6LLN4g3wuwlTIU9RCGc8q0VQORbvtwjMV8XSykA0dSUQHH5fMLXFYvA5dWvQHXaEdAtOL8JbrgFvuyfL4CMcjzdMEgOiWd3UEWrBR2dmCPEyDl8GcsrbV8s9DkbB59rJT6084++osLMwjeMttRGEJa7cPiWA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(81166007)(54906003)(86362001)(356005)(1076003)(2616005)(47076005)(8936002)(508600001)(40460700003)(2906002)(83380400001)(36860700001)(82310400005)(336012)(4326008)(426003)(5660300002)(70586007)(70206006)(8676002)(186003)(26005)(316002)(7696005)(6916009)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 03:01:56.1695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a3dc21-7536-485e-12c0-08da27fa49f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0012
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Eric Bernstein <eric.bernstein@amd.com>, Alvin Lee <alvin.lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Bernstein <eric.bernstein@amd.com>

[Why & How]
Add new DSC interface to disconnect from pipe.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Eric Bernstein <eric.bernstein@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 11 +++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h      |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index ef5c4c0f4d6c..c4f14aef0649 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -45,6 +45,7 @@ static void dsc2_set_config(struct display_stream_compressor *dsc, const struct
 static bool dsc2_get_packed_pps(struct display_stream_compressor *dsc, const struct dsc_config *dsc_cfg, uint8_t *dsc_packed_pps);
 static void dsc2_enable(struct display_stream_compressor *dsc, int opp_pipe);
 static void dsc2_disable(struct display_stream_compressor *dsc);
+static void dsc2_disconnect(struct display_stream_compressor *dsc);
 
 const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_get_enc_caps = dsc2_get_enc_caps,
@@ -54,6 +55,7 @@ const struct dsc_funcs dcn20_dsc_funcs = {
 	.dsc_get_packed_pps = dsc2_get_packed_pps,
 	.dsc_enable = dsc2_enable,
 	.dsc_disable = dsc2_disable,
+	.dsc_disconnect = dsc2_disconnect,
 };
 
 /* Macro definitios for REG_SET macros*/
@@ -276,6 +278,15 @@ static void dsc2_disable(struct display_stream_compressor *dsc)
 		DSC_CLOCK_EN, 0);
 }
 
+static void dsc2_disconnect(struct display_stream_compressor *dsc)
+{
+	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
+
+	DC_LOG_DSC("disconnect DSC %d", dsc->inst);
+
+	REG_UPDATE(DSCRM_DSC_FORWARD_CONFIG,
+		DSCRM_DSC_FORWARD_EN, 0);
+}
 
 /* This module's internal functions */
 static void dsc_log_pps(struct display_stream_compressor *dsc, struct drm_dsc_config *pps)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
index 346f0ba73e86..d7b8d586b523 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h
@@ -104,6 +104,7 @@ struct dsc_funcs {
 			uint8_t *dsc_packed_pps);
 	void (*dsc_enable)(struct display_stream_compressor *dsc, int opp_pipe);
 	void (*dsc_disable)(struct display_stream_compressor *dsc);
+	void (*dsc_disconnect)(struct display_stream_compressor *dsc);
 };
 
 #endif
-- 
2.36.0

