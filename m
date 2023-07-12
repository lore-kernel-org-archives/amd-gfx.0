Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47592C001DC
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Jul 2023 17:12:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF44810E59E;
	Wed, 12 Jul 2023 17:12:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C4D10E599
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Jul 2023 17:12:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQYiULyuPDy+jA3lENiQ9zC/uVT279ZVlFAmvJirEeemI0rxGj9l0okX15MHn1vgi8Q1RB6fnlXr4o0m6eRajqHs1Ty0/PYywDxPkemVaLMg4wacCAlyzJ40AEbSqDiNyqN86QIf7xprWjtLRVWGI2BigI/8fbzzuDNpCtjmUPkTl491bWAW2CBpIs8iJkdxxg77I+iiQotwmxpQfmmkvGdiYDjwoOECsnzxxvngQoMGoMNz/ESiICs8olTrwi7bUwSYAAexKKYK3WqW731Q0ZpVMdBKrL5wLtyWLdig559D+G+gAzCb0Xhkfa+ffdShdQVmTwkXNmNnOWueVufApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sVGIZnZ+kHcrqPZ8bugaeepgbYn7OTMFHtfud2/EW0=;
 b=MwXg0NOeME3Uf0mTHgbDAUKoyz6BYklw9HYtMNWptcIn+zmG0qHIzh9KjOVw+UJmqcFQ+RsoukXx4QnkkfmsjVpkVjdD5QLPwkXNNICfqHgrQEwMz4C34cLpjSAkT5zem4za8cmgxTq+sMMT48/WYMnfmMtzHjNYM7PZWrVd13hndlM8iCeUFXnwy9sUyjdyCQYUK9g+rsG0aidXpPpuNWV19b+gXq1FoDlxWwPge3ZODZyYhR/74iSPjm7ntfEoKA3A6TsFEApZcCoi7bIHNtgp1UQLotZllow8Os2LQ9u0DcWhmIFDN0prfsbt8JuH1oiiOplHnf8uCtDC1KQZsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sVGIZnZ+kHcrqPZ8bugaeepgbYn7OTMFHtfud2/EW0=;
 b=kX8rkXoUglmbWI9Jtoa959lysLpgt5RJddd0BjDfwvXeT+fKrtw4URDbxcbszckJDihxXLT9NMMiXtzuxeKEGFdCbVdMEwvNpmOb3Lz2yCmJoY6Ody7ZFNd5yL8DqC7sb9LBrxXqZGfTpMvWuyBLBccSRJsOUC7xUdHKz7ZIpXU=
Received: from BN0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:408:ec::7)
 by MW6PR12MB7069.namprd12.prod.outlook.com (2603:10b6:303:238::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 17:12:04 +0000
Received: from BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::ef) by BN0PR04CA0092.outlook.office365.com
 (2603:10b6:408:ec::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22 via Frontend
 Transport; Wed, 12 Jul 2023 17:12:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT084.mail.protection.outlook.com (10.13.176.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 17:12:03 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 12:12:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 12 Jul
 2023 10:12:01 -0700
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Wed, 12 Jul 2023 12:11:58 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/33] drm/amd/display: Setup stream encoder before link
 enable for TMDS
Date: Thu, 13 Jul 2023 01:11:05 +0800
Message-ID: <20230712171137.3398344-2-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
References: <20230712171137.3398344-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT084:EE_|MW6PR12MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba41a61-107c-43e7-16e1-08db82fb1d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iCN5QMSUXgkbKWx9N1mE7MF6pFJTTLw/YooBb7d8VCzJ2hhPXtNrYc0Ts0BDGsunSJ+Hzgd85v8T0Fet2GUWf/rXQgpehmDLtzBs0C+3L4JYzxiZS74ZEXCW97tmrDxwKDBRU0bwiHVORZiLuBz5CG+PKhF/Dy4COwsZoPLgr2k/UERNinkuxWHXaj5WE78+6kvFWENJU69dhh6m5Hn92gUXuzMh1qkIGo5/JwPTMTgfuU56PA/b/uoYIUWz8vfLomn3jR5BMLmtA8O+JrmzZdDAXUp34vysYHwpyEi7u23VlzRkrYWLN9YAn8b+Y6EqjNwGxZ8kuI+ZRdS3kcqpgyKHOR0HGAaiONqdkJylrNtrbs+C7LaEh1s0PGPhC2eYfof7zVTXsXw4hF3+j8YUEux8NW3ANPE7z2NZ4K8k1/FNsx2i4pd2EYml+2HfJon5HKk+O/7W/zPDDxokXjVRn1K1FaRo4A7RiaBHQTfhx71eYx/wD6Cr0ufU7ru/Sn+bFZC0KJQQPAPZVyWlE0oircO+aPL70k76jCnoK0jMRIr7R44l4yjYWXzGXDJ5u9tEvwiYDW28bugoNl7RpsNnlISxoC5Ng3lYLwEY7ekvLds+TCC3Tl58elHuc+IpFXs09qer4QxnYNF4bcN2x8GZG6nJVtGABBMoaMc/Z4rlM8foU9IRCpBdIrWEwm49V202igO8XsiZYYFzUfR5EpJmAs0pd9VNG5VwzgUBdroldY+NZsfUGmIOEgYJfa2N9WOUqbKvtYkS6803KrCEnm13aw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(336012)(2616005)(41300700001)(26005)(1076003)(83380400001)(36860700001)(186003)(47076005)(426003)(478600001)(81166007)(82740400003)(356005)(54906003)(86362001)(7696005)(40460700003)(6666004)(6916009)(4326008)(40480700001)(70586007)(70206006)(316002)(8936002)(82310400005)(8676002)(36756003)(5660300002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 17:12:03.7601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba41a61-107c-43e7-16e1-08db82fb1d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7069
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
Cc: stylon.wang@amd.com, Alan
 Liu <haoping.liu@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, JinZe Xu <jinze.xu@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: JinZe Xu <jinze.xu@amd.com>

[Why]
HDMI spec requires TMDS clock to be not more than 340MHz. Stream encoder ensure
this requirement but driver enable stream encoder later than PHY. So PHY will
output full speed TMDS clock first.

[How]
Enable stream encoder first in TMDS case.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Alan Liu <haoping.liu@amd.com>
Signed-off-by: JinZe Xu <jinze.xu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_dpms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 1a7b93e41e35..d8fcff0e5319 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -1971,6 +1971,7 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 	bool is_vga_mode = (stream->timing.h_addressable == 640)
 			&& (stream->timing.v_addressable == 480);
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 
 	if (stream->phy_pix_clk == 0)
 		stream->phy_pix_clk = stream->timing.pix_clk_100hz / 10;
@@ -2010,6 +2011,12 @@ static void enable_link_hdmi(struct pipe_ctx *pipe_ctx)
 	if (stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR422)
 		display_color_depth = COLOR_DEPTH_888;
 
+	/* We need to enable stream encoder for TMDS first to apply 1/4 TMDS
+	 * character clock in case that beyond 340MHz.
+	 */
+	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
+		link_hwss->setup_stream_encoder(pipe_ctx);
+
 	dc->hwss.enable_tmds_link_output(
 			link,
 			&pipe_ctx->link_res,
-- 
2.34.1

