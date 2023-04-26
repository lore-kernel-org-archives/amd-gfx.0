Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454EDC77B78
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 16:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D40E110E20C;
	Wed, 26 Apr 2023 16:27:54 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::607])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9B310E20C
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 16:27:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVXIMTYYA3RwMX0t8gRr0eZIwD2x33KsD6NijxEJQY37lkR+Kq1h2QVqCtry/MhOGYg/iqrXHxtNMx8symJhE7i0gzisocuTO2ou5Wbm2ETQ9Pbg8y3tfQbrgtngo2eLyJYzcALevZtcPrpSOaQ7aznNVoLwtYsb9um3BfkFNp+ulXuNOPs3zr8vvWahzzq/4rOKOYqBC8pC3H6x7P3byexySUI+J0ZL8cwgVyBzWHZ8eQ/8r8YBv0tnyOeZgr1BfcinoboAnWkIpKae5Apl1aRZL78J61M5OB/Zqepsl1MnJNR3v0MgvSj/63uqbxaRlHFJ+COdv8+u55gbCPDS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqJIfFnPLzCjX11kPmnhyZTOYkw0ppBW2n9QbpgZtLY=;
 b=MOK7cYlGp04DGxr5ocojr1Bm7a+brs7OvNdLl3AD2GIbPccqpYY98mpK5xFtusRCaR8784aFxAE86Qzt2gzR7QG1KlJULZ0Z8XBUpMYQUVNmIsjcHGBgDLtR0VVTCaR7+soeHvhCEUQjcXC4Rk4wU7fJyRJNj/wWpRajHrgAPSU4W1ZSFSoGktkmgjTc89wrlTvEBpLllwPCkSzVKzosoRgSIsCQ1SIYHk+XbCV8dmEogAGGZDLPnrCBjIDpHy74brwF1mQYod3AIShtnDBV2f2QelMd0FkCGnj3HXgib4hNJjMdXljySyGscG5Os1XqiGRThr6kF6L8uQZV1USeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqJIfFnPLzCjX11kPmnhyZTOYkw0ppBW2n9QbpgZtLY=;
 b=uhuDLYNsYxA+E2uTlIDmvqcL9/4+Ns9cLF872WEHlJsRLNQLruSnptJoRmrfgB5HuoExvB7lJGMRRcFQ8Dz7tp48cjtt0ixAjizK1km2/QiqODfoLh1g0H5Y3GmS0GmnkFtGhqsn6M05FS5vf8yfE30J2b5EaHgqE9bNQBURcHg=
Received: from DS7PR03CA0358.namprd03.prod.outlook.com (2603:10b6:8:55::7) by
 MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 16:27:50 +0000
Received: from DS1PEPF0000E638.namprd02.prod.outlook.com
 (2603:10b6:8:55:cafe::a) by DS7PR03CA0358.outlook.office365.com
 (2603:10b6:8:55::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 16:27:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0000E638.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.19 via Frontend Transport; Wed, 26 Apr 2023 16:27:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 26 Apr
 2023 11:27:49 -0500
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 26 Apr 2023 11:27:45 -0500
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/8] drm/amd/display: Workaround wrong HDR colorimetry with
 some receivers
Date: Thu, 27 Apr 2023 00:27:05 +0800
Message-ID: <20230426162712.895717-2-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426162712.895717-1-HaoPing.Liu@amd.com>
References: <20230426162712.895717-1-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E638:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd5b5af-8607-4937-2387-08db46732d30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J/JAQuDc88/OaDA8wr3LceNkvBr6QhwMJYMZIuYiqB5RKOZbnTVhTHfetSEzPXt/YDuNtaT0A794Exn6t2Leu0SxjyQg0TSRwhcV6LsXldkc5KGJnzVgDO2hdEpVDJQZ7k9vlwzVtueLaXGkjCvpmAoOiP8ON748GrYCGC8YYGLadpWqbYicBLyn4JAbIrYZWtQXilo26TO/Q+Jf7Zn5CW7jTTffLvP8ibwG3tZG+kWSbAI52yKVu9+kLDJ0kESraKNRm8NzIB7whyFPaIBRUWWDA8KyCMPLsw/wNYKPJtKYLudSkk6xafWtCQ7lEY3JiWetvC0lGh5cFIbKM9hnqxicUVkrpu7ZC89W5YJHNmCIohbCmGwKRCUEJGASIJ01H8Eca/Sh3JqaB+nRg8ZoyC44+pEpeKvt4MWq8wgNZvu/l23xxqrlpzmofKavwNhPGZSCcTlhQH5ByBOevU6fBTL0Gnvl0LMgHdnDqdE8l/ZXVG4rBgrIuXw7k3SMphMN336fhUHCfsbbdPPeZfnVhzE6abCaFiIW5PZmMx7P0zvDclnQtvyro27BWsjNWT3jKqrRNflnPLxjHfBB3MOBxhgb4tSuBRcP4lx90pYNtgltllDrqgNSUb5Y6I83K+AsriDj2JHiHqwbIE2Xvy9Pe3Fsh/4rGSfDbT43LEC6UZCe7oSiFDinrEdCwt1M1nOzc9FFazyTECjhRbnC/brfRp7h1xruAGa5jDP3X5BYpKI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199021)(40470700004)(36840700001)(46966006)(47076005)(82310400005)(36756003)(86362001)(2906002)(40480700001)(7696005)(6666004)(36860700001)(186003)(83380400001)(336012)(426003)(2616005)(1076003)(26005)(6916009)(4326008)(70586007)(70206006)(478600001)(40460700003)(81166007)(316002)(5660300002)(356005)(82740400003)(54906003)(41300700001)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 16:27:49.5588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd5b5af-8607-4937-2387-08db46732d30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E638.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
 Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Alan Liu <HaoPing.Liu@amd.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[Why]
Some scalers do not pick up color space updates unless the DP link
is disabled/re-enabled which can result in incorrect/washed out
HDR colors in some cases.

[How]
Call set_dpms_on to disable the link, re-train and re-enable with the
updated output color space.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 7 +++++++
 drivers/gpu/drm/amd/display/dc/dc.h      | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1fe040544051..7b68ff0f9c4a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3268,6 +3268,13 @@ static void commit_planes_do_stream_update(struct dc *dc,
 						dc->hwss.prepare_bandwidth(dc, dc->current_state);
 					dc->link_srv->set_dpms_on(dc->current_state, pipe_ctx);
 				}
+			} else if (pipe_ctx->stream->link->wa_flags.blank_stream_on_ocs_change && stream_update->output_color_space
+					&& !stream->dpms_off && dc_is_dp_signal(pipe_ctx->stream->signal)) {
+				/*
+				 * Workaround for firmware issue in some receivers where they don't pick up
+				 * correct output color space unless DP link is disabled/re-enabled
+				 */
+				dc->link_srv->set_dpms_on(dc->current_state, pipe_ctx);
 			}
 
 			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4424e7abb801..892e3adb99d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1506,6 +1506,7 @@ struct dc_link {
 		/* Forced DPIA into TBT3 compatibility mode. */
 		bool dpia_forced_tbt3_mode;
 		bool dongle_mode_timing_override;
+		bool blank_stream_on_ocs_change;
 	} wa_flags;
 	struct link_mst_stream_allocation_table mst_stream_alloc_table;
 
-- 
2.34.1

