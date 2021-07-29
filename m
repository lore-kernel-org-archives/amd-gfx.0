Return-Path: <SRS0=5qjI=MV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80102C4320A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5044860F46
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jul 2021 20:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5044860F46
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F3546EE62;
	Thu, 29 Jul 2021 20:37:34 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16976EE60
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jul 2021 20:37:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0kvZ1OWsd6IkUcuH/RpUcXv1KwEJpINlFrgsRiYCbn8hVV1MXCsV8g7U2yEJ0mJS6G63ZA7+PUTgsbgVJovhC3IjQ9dQ61MWd+mWh82uzizFUMjQsregUX9OLErmbZrB1UA56NeMpZXhuiWj+kKGjFjI7srbEPiYBAZetZMM4+sXtOZs++IJD4692wFagaiq8LueRgrh93v06jRQZU1bnWf/Vsz7GQT8/ch5SHJDGHzoXv1+vcz0XS47G8oZcC9+kHogrjWVperto+YYjY7NyDqDs2G0M46Z71+15yKeGIlZveM+hIlYpxYxaB+Kpc6oF+lha53JZtD4akuZdYyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ELjb+DB7JCyy/M7ptROagBrz9j6OIK4wBLAMhATwQ=;
 b=ZgMYBJU/0drVa1yGU9Cmr47HKu+4wyRVu94KVfCw/m33AXXHQHsrYHZfnfJsB78y3zOkZ2HJYUVw0ouwgGltqwp8dcVXI4GRhMrh8f8ZF6yOM/ZSkbU1E/xYj3AmY4u2OmfO6TtIZfD6adwNournd3kLSR1oiHqnD6IZb8Pd0i5X26+WHbB1Xd+qTujYq+1dGY/KoHy3rm+gVwOjcHJ3a71AADaukJpdRTN6HeajUu/18kMEzWBDtYmW2EVqnDIUNS/g5LwVl0g/dnL0jG//e52ZyJyyiFii/BYCcweO+W64Bw/adCbysUYbc6bWWCsEV+0tNNcDNpnMuf8eaLCTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/ELjb+DB7JCyy/M7ptROagBrz9j6OIK4wBLAMhATwQ=;
 b=qhwXaSmfR4Q/ar0g54HyJl6+rWIARqyeMs11CZndn1wfE2k7+ZE6QECNzitdWwChDHW4Ipkb/3dXtLfQaGscdOcu+yY4I1Zv4nxhGlzR8gOjIYynkTsNnB6s8+tgq0MLAy4y82G2ugHMp84mVT0ICbmS6BWI/yPdSm0luLALqKI=
Received: from DM6PR21CA0024.namprd21.prod.outlook.com (2603:10b6:5:174::34)
 by BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 29 Jul
 2021 20:37:30 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::85) by DM6PR21CA0024.outlook.office365.com
 (2603:10b6:5:174::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.6 via Frontend
 Transport; Thu, 29 Jul 2021 20:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 20:37:30 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 15:37:29 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 29 Jul
 2021 13:37:29 -0700
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Thu, 29 Jul 2021 15:37:23 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amd/display: workaround for hard hang on HPD on
 native DP
Date: Thu, 29 Jul 2021 16:37:10 -0400
Message-ID: <20210729203712.1566129-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
References: <20210729203712.1566129-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6387e459-dfff-4364-5b14-08d952d0af8b
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51120D86697A2091D2D4022A8BEB9@BL1PR12MB5112.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etlCnvHf7sIlOm6LV1ctJ0K+3/abNr74zwQxKOJEyhyr28Z5cAnVbNw4bqw4r1gYq7AlD/GSIrGxShqSOYtmbj+WO3TLVy6N2ntwJy8OK2GM87WlDeakhaNPJtLZj3jlGh4QteyVtsngr4HZw/Ql4ujkkvdoZoDHlkaXGtCzl+Oo4Jx7PuuhQnTF2eJy+PkLGRGMl2oSqN7da/io2NaLaTfMyW666aR4LJb8xGzHWq5cvuZrJdq34Kkixz+2KMiH9DQNj/j87kghdBCkrjN7vPvTQnf10LcalpWBKUOo3eg+PL19aTN1gLGYXe6xKcFFqL5EYsfyUUi0OyaNDV44pU4V3JsdiQ2+6ZyJgEoz7VABhUtF9kpuIgxJIO0BXvFK6yCtpCUEd5QEEVIUke7kJb1H69yssKVengOn2LgUqelVxDBbHIhRJxh8+98zZg4I810MnhKbfT8BLIimt8cPElyIKc9vrNKnRJqRyKbhIm7C/cz0rg5RclQPr/P9l/3x/89vF8LgNhhnPg3voRGZj4+go/tmo2H8T/aGBpfYtSR0U55w5//ahdcFy0IsQdSRP9BpDCyaGYjpIPKmjhsyYTKfJa+Yt58V2os00cgmIoOWQ86fpRiMlET9tUXkKTYoGF9Ek6GJuOaEJhHIeApuinc4+GZR0KbVZYlpKyNTNmSGvCDUjqQ2x3mYiCkXmPLBKtXF79TQLo0LfjanLCbl9kz35Q0mnvGrl3UBrkqI9B0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70586007)(1076003)(70206006)(5660300002)(6666004)(81166007)(186003)(86362001)(26005)(44832011)(4326008)(8936002)(508600001)(8676002)(2616005)(6916009)(2906002)(7696005)(47076005)(36756003)(426003)(54906003)(83380400001)(82310400003)(316002)(36860700001)(356005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 20:37:30.0467 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6387e459-dfff-4364-5b14-08d952d0af8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5112
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
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

[Why]
HPD disable and enable sequences are not mutually exclusive
on Linux. For HPDs that spans over 1s (i.e. HPD low = 1s),
part of the disable sequence (specifically, a request to SMU
to lower refclk) could come right before the call to PHY
enable, causing DMUB to access an unresponsive PHY
and thus a hard hang on the system.

[How]
Disable 48mhz refclk off on native DP.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index c6f494f0dcea..6185f9475fa2 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -66,9 +66,11 @@ int rn_get_active_display_cnt_wa(
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_stream_state *stream = context->streams[i];
 
+		/* Extend the WA to DP for Linux*/
 		if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A ||
 				stream->signal == SIGNAL_TYPE_DVI_SINGLE_LINK ||
-				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK)
+				stream->signal == SIGNAL_TYPE_DVI_DUAL_LINK ||
+				stream->signal == SIGNAL_TYPE_DISPLAY_PORT)
 			tmds_present = true;
 	}
 
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
