Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BABDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 18:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 648636124A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 18:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 648636124A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C327C6E038;
	Wed, 22 Sep 2021 18:15:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C2A56E038
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 18:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0HhoZFSApEACrMqan5Mavi34go1cR7M/1SlI9bBwNUZMb6Uevb05PI2xauqmkOe1e8ahlAgO8DkmUjmBTANUBOwed8/uOr6MgXvIlum3HKkM8gHK9O+i29wKZU7YHREHZ7UWN7T9wToUKIkG9px4+TavgDpct9g6k4rKWcl+b6HgHDX7zRbmKh+ou10fabJCEFyLYJm9iV7DoNQU05I11XgJAx1DVDecEs8PLGa1+uzhx9eA+AwaZ8uyqp7psWEvOTglx7Kak0G2xuETQAdogDOcE5aQQ6njFKhoCWwwZeF11j0BzDp0OQUobYwSvuBz8IrAXBB0dO4t546UkTU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=/q5iK5HLysEaQANDPvTHNPDOQiz656wvdxrJzfD4bOE=;
 b=CJRS/c2Jb2mM8A5rw/hzl+kWn3e3dLAvVhK12T1182IUSI4TQGeODM/whh6TDXLYtilhjB8hg8x+bpO9ItdUQvqRllSZqHXgmbw3i4xYBvmHwT0KbCsyp5LPle3WNpON1Dsk8kYsYo/K0rZ1KBAISsEuspgWZAjdmSh2LJpIxLUHQ1z+fQZfLW3NNfYFn2j0KepKBVPQ3EYUIrmK/FKWYKSp3oO8QkmxvjhKE0KxBx6/v+92FiKwEgMYN4mMYhAJkEOoyBLuZr3XRLgKl4QbuLscFchzna3ognziZsCL60/Oi69Zv/nZGmwDc3z5PKrtrcNoQVG/A1gl2ebKTyfeig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/q5iK5HLysEaQANDPvTHNPDOQiz656wvdxrJzfD4bOE=;
 b=5Rcm/XArBxC5ROjNJQ0uPGluoHBYXZ3WQ+5FcMQVyeNNhIvZOhn6NFXbevyV2oAHdH4OoLihFE4CYyURsdUgIC7NBwhf1WjvdtUtRAEhPyybyUZBEzkKN6grTylK44YMXX0U8elN9VWyufC8cDvKqWknxz0h1roaB04Fd10Tnwk=
Received: from BN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:e4::20)
 by CY4PR1201MB0023.namprd12.prod.outlook.com (2603:10b6:910:1f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Wed, 22 Sep
 2021 18:15:21 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::b7) by BN0PR02CA0015.outlook.office365.com
 (2603:10b6:408:e4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Wed, 22 Sep 2021 18:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 18:15:20 +0000
Received: from pswarnak-Sharkstooth.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 22 Sep 2021 13:15:18 -0500
From: <Praful.Swarnakar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <harry.wentland@amd.com>,
 <hersenxs.wu@amd.com>, <sunpeng.li@amd.com>, Praful Swarnakar
 <Praful.Swarnakar@amd.com>
Subject: [PATCH] drm/amd/display: Fix Display Flicker on embedded panels
Date: Wed, 22 Sep 2021 23:28:23 +0530
Message-ID: <20210922175823.2160290-1-Praful.Swarnakar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: edb1ae30-6c4b-4d92-c733-08d97df4f082
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0023:
X-Microsoft-Antispam-PRVS: <CY4PR1201MB002385B9B56734C0416594308FA29@CY4PR1201MB0023.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NEv5IKMYRN8F+NbU40Kw+Y/p6nsMY1YMZ+O5LBqp6hZAAEUGSlkI4tbOprn9BWC+7YKkdylCmqSbbw3jd0JFa2pAbvVnMqyuK9Ct9y7g55Wkq65uSU8+GY+wpo69QmkgqUbzbzbtnPhj+GoNmKuueKFQiWQH9j5scDPhnSNfSQHKSDKTRayYJhw2/rCVK9+x2ashRPiKpsGIiIsFwYXQCfZyHqAgTptZj7ccibp2XSGwn8788VTq7aU6mn0zELuNmvebCo/SKUfIT/xzaaz142711mbaglnL3gqmDBNHEdgeLXyYh0EYfUWKgKxnrr2kv2fslufXlurHuZjSw94sPZ0tKAw2rg4cfkRdvEsWWvMJih5Gi60rLKk/m9rAdXFyJNSGkcqfSP0PyTCK1oa9jMu3e6EII8/wQq0XThyjQ/79pI4uwakPL3z/n5RiAgdKhyebloZgb7HeKygyP3YBa1B0UI3XQm9iKfB1PyJ23DnzrNWQRoqXHUTrJyRfLExSRIYIgTVjSJJak3L8lFTqQR5jYkv1jdGwgqNDMEfx5JZ8D41yZqGr6UZd22yn0TdSiFv6Qjws3SjZKlkM4LyCtHKsi0OUXQJM4YYhrZF9Ms0BfzFA4aRAJyIVk6kr5VRyxEgTt7FNJTyjjjnAwy2YbqVSr2VsoGPQkQH+dfM4L6ApqE871KN2J7EQ4NHLllLqugTyLDe9x8it476FjGG80FH/rtr9WefcMB3zx2+VIRI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(508600001)(426003)(81166007)(316002)(336012)(356005)(83380400001)(1076003)(36860700001)(186003)(2876002)(8676002)(2616005)(70586007)(36756003)(8936002)(4326008)(2906002)(16526019)(70206006)(54906003)(5660300002)(47076005)(7696005)(6666004)(86362001)(6916009)(82310400003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 18:15:20.9800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edb1ae30-6c4b-4d92-c733-08d97df4f082
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0023
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Praful Swarnakar <Praful.Swarnakar@amd.com>

[Why]
ASSR is dependent on Signed PSP Verstage to enable Content
Protection for eDP panels. Unsigned PSP verstage is used
during development phase causing ASSR to FAIL.
As a result, link training is performed with
DP_PANEL_MODE_DEFAULT instead of DP_PANEL_MODE_EDP for
eDP panels that causes display flicker on some panels.

[How]
- Do not change panel mode, if ASSR is disabled
- Just report and continue to perform eDP link training
with right settings further.

Signed-off-by: Praful Swarnakar <Praful.Swarnakar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 6421c896f2a1..120c9955cafb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2419,14 +2419,13 @@ bool perform_link_training_with_retries(
 		if (panel_mode == DP_PANEL_MODE_EDP) {
 			struct cp_psp *cp_psp = &stream->ctx->cp_psp;
 
-			if (cp_psp && cp_psp->funcs.enable_assr) {
-				if (!cp_psp->funcs.enable_assr(cp_psp->handle, link)) {
-					/* since eDP implies ASSR on, change panel
-					 * mode to disable ASSR
-					 */
-					panel_mode = DP_PANEL_MODE_DEFAULT;
-				}
-			}
+			if (cp_psp && cp_psp->funcs.enable_assr)
+				/* ASSR is bound to fail with unsigned PSP
+				 * verstage used during devlopment phase.
+				 * Report and continue with eDP panel mode to
+				 * perform eDP link training with right settings
+				 */
+				cp_psp->funcs.enable_assr(cp_psp->handle, link);
 		}
 #endif
 
-- 
2.25.1

