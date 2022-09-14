Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE01ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D42ED10E84A;
	Wed, 14 Sep 2022 05:18:26 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45CAB10E84A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f58QrY+JMyK9ayEX3KFpBXsiir0COOP9LRdyz7J4eMb3PjeoNYP+O7HnjCKzOdJDDo6G5Lexgvys6R0cSsYV4rTKI9Xk253MFEDVvTn4DpeAdZTzdjkQIFTbYJpK3qH2FSsW6auilChD690n8kU1lVgz0KQRkAeuo+lfIHdkJ5yxHttgryNap/QOygdHlRkjTArh8zrV7qkDArgeohD70F1VmoDe8/aGG9/CZyUXUHR5Pw6Ds7Yj+2uUB2rdBhvyH/IvfzT/BYsNigxNGNNQWNGzVwndBMP5LH4ejyUKQxXjf9mKtihBfPsxDpdKu9OZxOQ0r2InADLsh3lMk65FpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR8eBPJyA+j6n3PlCReJALakn2M1jc9GnqaRXaIF48g=;
 b=n9rI6Ugkjf36TZNmaJLS7lu0n4pS0DPXpKFapkO2N4iUK1s4IN9oGLnzzVMPdFjq65QsaH1yjW8aRjD75OUI5fbBwc3ewQNXg5Ny6sVD5M2lQcLWEEzKztKqZGzU5OxNaZfFWLedP/2xWzd6lgSd/r3sU1BN6U1rb+XgiqZlS5KhiwAyzSy2uunml9qGwRNqsOI102PdW+FBKj1IcbMn16D36fJWcX0v2mGziBGfq+aVzLE/q2oLd1Po9bja4lVQO3Ux8V98grMKWWJ2C0O/irN1d5QHZzVkX7ZPOKbDJiVSt1vmLHzf6Sg+fiMrxMeL+T7k6NWUAh2s+wkoMywPBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR8eBPJyA+j6n3PlCReJALakn2M1jc9GnqaRXaIF48g=;
 b=hcu75XDiL8wS5WhmOMoghLfnLYEzhmhyd2OPq4iFSMfkieC71+lXgzGeou1AM2kQqVC7NnmY8xW3NZRjpXuVCq34c5nwOxb7tNksxxzH9inmmS0YlX1m9fPfq8imgXxF45YVyDwWt6vzRCE6TxmObRcoPIK16p46bqCObybizTg=
Received: from BN9PR03CA0034.namprd03.prod.outlook.com (2603:10b6:408:fb::9)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 05:18:19 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::b3) by BN9PR03CA0034.outlook.office365.com
 (2603:10b6:408:fb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:19 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:18:19 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:18:13 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 38/47] drm/amd/display: Disable OTG WA for the plane_state
 NULL case on DCN314
Date: Wed, 14 Sep 2022 13:10:37 +0800
Message-ID: <20220914051046.1131186-39-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 610139eb-391a-4b1d-fa63-08da9610898e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JTPdOGaT4IkvkaR2/0nutYngJzORl9ZxYMuHoUjuFMIquFf3ZfF2Z6khqLKK+cvbp3CwDAai8vW/sSNtHfaL8ROUerBlzoQ6YjlDeavGkIw9UxGAWYqSZA91vwUO+IG5D7ykG/HAu+QV5ExqKsLiujcOUli+R03AmlkBQEDy0pPSD+XxH2i4+1XeMzKzF6YzdDV1QDazraAakniSKhIyHwH+Ly6LSTZENP9PkagIwKhRKA6NErjESJH4L6+G55utED3dX8tuQkXDQhcqurMNhaaX3tBae/hcY8hcfm7WvJRpKile2QM+IVBj7bR0s38Sx7BUoAtILuEyZcdEStKLXdwbkUTUKelv0/hgUyo1QrA0qXr97dij/AfIzQytpTAsv4PyDybIck/7nNZ24T6J9bPk4qIFc2PUNAYsaUeS1fgQ94cLD1juSmFJU4XiWFqCvbL4JyEdpqnsGrVGc4/1PTtOy7Ccl8bMNJ/GE4U4ISqjaSzgKH7FaaSFot5hjZB2cONjwA9csE3IJnJjSeJaWrHHrKaiDwv+2ZNjm4du+n4wGcnsmmfVOhsQ/B+fve+foGMm2AsBacB6eO3LAGsj2BLQhocN1Sr6/1qzpVUVIotZy7+/1BA89G8uedCcsQVTtqJ4i/D11QMQ+xyryDHf5DJ8Czqbk+8WIaNJPNJEMoBvYriJ4yjtpM28VRVsrR9wzFpSLRMZohb7H0PijQ9R84P5UPEC4GZSSIE7/IpWZaSiRvTG+5L3KQsZwhzs6S+inBDYZF1/ARGL+ZSEBn8FGDR618wXOgMENc22cluET3I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(346002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(41300700001)(4326008)(8676002)(70586007)(47076005)(26005)(186003)(2616005)(356005)(1076003)(5660300002)(336012)(2906002)(6666004)(86362001)(54906003)(36860700001)(40480700001)(8936002)(316002)(36756003)(40460700003)(426003)(82310400005)(81166007)(7696005)(478600001)(82740400003)(83380400001)(70206006)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:19.7057 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 610139eb-391a-4b1d-fa63-08da9610898e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
This shouldn't trigger during tiled display hotplug/unplug but it does
because one of the tiles can end up with a NULL plane state.

This also doesn't guard against the hang that it was originally trying
to resolve, and can instead cause DIO corruption due to OTG sync
being lost.

[How]
This was reverted at one point out of DCN31 so revert it here too.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
index fd4b79746f4b..193a0f3de18d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn314/dcn314_clk_mgr.c
@@ -136,8 +136,7 @@ static void dcn314_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
-		if (pipe->stream && (pipe->stream->dpms_off || pipe->plane_state == NULL ||
-				     dc_is_virtual_signal(pipe->stream->signal))) {
+		if (pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))) {
 			if (disable) {
 				pipe->stream_res.tg->funcs->immediate_disable_crtc(pipe->stream_res.tg);
 				reset_sync_context_for_pipe(dc, context, i);
-- 
2.37.3

