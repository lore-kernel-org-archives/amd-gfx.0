Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA89EEB64DC
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jul 2023 19:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDC5B10E2CA;
	Mon, 10 Jul 2023 19:27:48 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 278EF10E2C3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jul 2023 19:27:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6ZRxmwuQB9YjzQ0lJSj9khWvjmO3W9OfjmI1jd5BIbF9jV1ur80gUwuZjS4/4b2m2okVzz3LDNPgQVsi+bOAf+vQdYbtHG1oLquPA2K/Zqky5RtcJgF0PETcySOxD3GDqTqsfK/ZJ+fsj3B5ojnwDNxFclPx2UJl5uIX0DiV8UA4PiqJS5duxurYuPL0Uqe9m4ofAfgGMjVywMqlRLLQKlX4dJNc/VApi5IkH+dX1mqMTt487OxXoqhU2G50cDiqKROyiIXIZfRpVTc6sQ0fEZJMrQY6SbgRejDftPivMTmLw6kx5AwH+Qtl7PM5zLQa8hjMEkmm8tfdFbNKOovxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+js+OSNq/vxJtMaL8/qdbz3kUM8x4MXZi/8a6lKGdE=;
 b=kGltA0m+pC709FpPjUHavrRMozl27dWnpVyF4hLs0GJsLKw0fTuIXm+c97SsPjv64Q2xN59D3LLTYyF/UYTLNUOomOMdyXoZiNK+Yzh2y2OufveKJoyLdUl6sqBRfraA1uupHii6CUzHnqTe9xRF34Mg2UgI6aMSCSoWax+5BuvRoa5IF60bCkl4KCZ6AUlr4CMbk6FmWULudoF0ky3afpqh+QAelfQ9paIDeDAhaslQ+1HXIUMmS5igEkSTNdSzSHGFujLZDbItv6SbhLvGQ2TYY64WGNnEp5fo+KKut/B6874Bc55UI28eg8fAkX1ZGoMpgzwl17bc4IQzv1fzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+js+OSNq/vxJtMaL8/qdbz3kUM8x4MXZi/8a6lKGdE=;
 b=VuPPpoWdg6lJt8BOkTQP8J8nw0JG88tyTqeU7M9ycWYcDCHWBioARGy1shw6wcqirf6LHC1GKE9aG/0IMAWXMpww3k5QhOWsO1raU6kiuQu5uBM6t0Uq9g7kRYNkdfG3OcU7J/gHVEXfWy6EaVDoDG2rbGJbZ+Pcfd1LOP3l930=
Received: from DS7PR03CA0147.namprd03.prod.outlook.com (2603:10b6:5:3b4::32)
 by PH7PR12MB6860.namprd12.prod.outlook.com (2603:10b6:510:1b6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 19:27:40 +0000
Received: from DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::d0) by DS7PR03CA0147.outlook.office365.com
 (2603:10b6:5:3b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30 via Frontend
 Transport; Mon, 10 Jul 2023 19:27:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT096.mail.protection.outlook.com (10.13.173.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Mon, 10 Jul 2023 19:27:39 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:39 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 14:27:39 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.23 via Frontend
 Transport; Mon, 10 Jul 2023 14:27:39 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 07/10] drm/amd/display: Update replay for clk_mgr optimizations
Date: Mon, 10 Jul 2023 15:27:30 -0400
Message-ID: <20230710192733.1344403-8-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
References: <20230615203930.1715722-1-Bhawanpreet.Lakha@amd.com>
 <20230710192733.1344403-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT096:EE_|PH7PR12MB6860:EE_
X-MS-Office365-Filtering-Correlation-Id: 053a9684-3d43-4c71-fefc-08db817bb9a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/bU8VA/+rgU1EC7Q9gnY8Z4Ukfch76SSRvwQMlnwXl3fmPWe3HBQvQtGmhSj1U+FL2sFNFJtpoNZacwEOOelyhGjliE5jMmL8S4FhSx9z52m+dpW66PYef9+mHt984CZ6g1Z2Al4MT9DduDuoMc+zHPWymZpUMA6x7FOlxJ6tKo0SmtX8bz6pACqNPjyJhJoFyRKwbADAQQI9jNHwUCYj73GLXnr1lPyQKGOw+NYAROU7Yi4gEAAMnRDrkeKVVY6AdHjZb648yjr2TGN+DrDNt/qwHHOVxtax+Mjn8gBCMRQp9aeC6A3n8kLd73+nVyTAF1+L4wnhIMgOcgr7IJVTS7QOXmAX/uNfohUF01GJZCV4G8rssBVJUoOOXjp03rO62mKDJqW7wVKKDH2KaFExuGw7SMkioElrVYWPqY63Sb/4QMJf+krL0Q7or41Wo7Ak+SIphWDdrqpUX8xpKVVPRm30cx+HEodB7N2V6no+ZtzReVRzIFp2qn49AdmOzL8T4PGuyCTo72u2MmTWVRvOTuD7w4/LcCbPWwyMG89wSjmZHGu1WvzFGhTSndcsQe57LFGUw1E/FzCsFWgrXoYxxFrDS8yQySfJHH42wQY82O/5mUQL1ReNtT5RJtJbyspklif8cthquE1nzmEc4DjCHfKjfsjpP0TAb2qn++8j/7t/K+R0FKJhScHvh6r6piOD/TQp95G8DsS8+jvwPlIgQgn58XqxNQpCSd22+Wv6ZzEvLvfzGOLF//FNq+dLmMe2gOkK5/DCN0dr6DiRXWqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(5660300002)(8676002)(8936002)(83380400001)(36860700001)(2906002)(426003)(15650500001)(2616005)(47076005)(186003)(110136005)(336012)(478600001)(26005)(1076003)(41300700001)(40460700003)(81166007)(356005)(40480700001)(82740400003)(82310400005)(86362001)(70206006)(4326008)(6666004)(7696005)(316002)(6636002)(70586007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 19:27:39.7900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053a9684-3d43-4c71-fefc-08db817bb9a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6860
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
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add Replay calls to clk_mgr updates (just like PSR)

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 6127d6045336..3bb11dc1138f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -117,6 +117,7 @@ void clk_mgr_exit_optimized_pwr_state(const struct dc *dc, struct clk_mgr *clk_m
 				continue;
 			clk_mgr->psr_allow_active_cache = edp_link->psr_settings.psr_allow_active;
 			dc->link_srv->edp_set_psr_allow_active(edp_link, &allow_active, false, false, NULL);
+			dc->link_srv->edp_set_replay_allow_active(edp_link, &allow_active, false, false, NULL);
 		}
 	}
 
@@ -137,6 +138,8 @@ void clk_mgr_optimize_pwr_state(const struct dc *dc, struct clk_mgr *clk_mgr)
 				continue;
 			dc->link_srv->edp_set_psr_allow_active(edp_link,
 					&clk_mgr->psr_allow_active_cache, false, false, NULL);
+			dc->link_srv->edp_set_replay_allow_active(edp_link,
+                                        &clk_mgr->psr_allow_active_cache, false, false, NULL);
 		}
 	}
 
-- 
2.25.1

