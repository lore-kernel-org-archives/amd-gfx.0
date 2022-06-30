Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3340EC43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8893F11A3A4;
	Thu, 30 Jun 2022 19:14:04 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D69011A21C
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PpMMYxoccL4HhS/T5HLLxI4VfroYfb76kIwqMPeu2PFL0sbj0CGNSGV9yNXdL7sQKQTzRV4b1nGdOlHdQXgjzQlKdaORfpC42+79EpUUZuOqFv3+EHdk0ZsscB3Rh1J0Toz/93mkLBTb49r4oaHLg8K3Z+Pb5POveUEyIqGEZXjTmPWeiuDcbJddc7KQRCyBF4eo3MyPJlOgnbd+Za2WwrgE5E3ns5vRMwFhQR32CSbRPvDGGekWwpSjNfWGeWlC1QxhHQrBrNPakGhZGhVmD8snWp5DcSbLn/eY6wkM/2ZK/oaaCK76f8jOXvM943rWeP1qzmnEv1LOaUCzFs4T2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jO5IjxQTMC8O3ecuhOcXuHlpl0G2TkNVP4ar+CjNEnY=;
 b=gu+lG9kttIm4p2LLqzGBDBOFbSflSxmCSVjOZ+jsR4RBwPAtktCudJySqdXByUwB1HIQrKa7HC5oJ/9LPdaiOpTRlOzjh6eTqcpfm2QyHf9l3UTgM56U2+1+ZbBsnc0S4KuOUrJzF0cwQ/4YRJC30ApDJirbxLas7Ng626V0yBhMl5PVSMG6TrZGVbBUaWx4TTLk1lV4z95iTkluq/0FtUoHd0fRO64WnJEDD47nxbyi3ttNHpGVbIslA+rnsP1n1R+8wp5WgiBGhcbZJSL1kmNEnMIrhLuY5JPoaKJwPM9+H/en9pHaaG8hDNUTtClkZv9HmiclrEpJafTZ0GSHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jO5IjxQTMC8O3ecuhOcXuHlpl0G2TkNVP4ar+CjNEnY=;
 b=tvaGkgRZM0b0Y2OFnT//7vwPiyh/l/5a1i06w6gVkA+rHV3g+X6KYCr+UPWUoHon05wd8ar/3Pa+cGlwYVCtJDDnRFdlPXwaXnBFABydlMVonCp6Mgc1FtDPlRJDQKSPlJjoV+1DLiAI/qHg2xcnSuAjgJqGNDNV2X2j0pLZtlA=
Received: from BN9PR03CA0531.namprd03.prod.outlook.com (2603:10b6:408:131::26)
 by MN0PR12MB5812.namprd12.prod.outlook.com (2603:10b6:208:378::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:14:01 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::69) by BN9PR03CA0531.outlook.office365.com
 (2603:10b6:408:131::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:01 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:00 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/40] drm/amd/display: Fix stream->link_enc unassigned during
 stream removal
Date: Thu, 30 Jun 2022 15:12:54 -0400
Message-ID: <20220630191322.909650-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 566f5bfb-a374-4558-5da2-08da5accb0e7
X-MS-TrafficTypeDiagnostic: MN0PR12MB5812:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tp1kbIzs8lasAz+YYSsFIxEJLN8c3SqP4IFNnzqk0U3SoQ46jJVCcdHwRXPA5UV5st3cbcOmSXpbzMEMFF+28Ro2cmweNiDjF6o/LCcJOXtUhrSFW9NyRvyRzYRvU6bYzwTLMOf4i84qzY66DqqIHLV+ds7bYNt00cg4Me+YSfDUtiIuumytw+THRKEAN6zo8oG7B5s9os1E+zeltX9PtybeSJBa7smeZ/pCy5R4zjerdf38Htwe0cpL7zo2Lu2A2HBxRCIP+1Bg7PuvWTzdXi65Ju+3sima+08TOBsP9uCYk5/kVBrcnGIlK6yFuMog9chfFrrniKNQRwlS5g9+oWS5OM51mdtJdvkz0CO6hBV7mI/xsTFUizhuwi7O/cs3kgeaplUtgJoONTukTL7ETzcmSmdr89D8RMZKIr0m+UbAE11uJty6XgvgMmxeKyWUqYxSWlPAkIjpZd6sF3XOFXe0HuLyKOC3d6lviQvuicNJMCyyzYO2Is+0FfgFaRz5BDUmWRDFUTs0p82yNEMx0oqelRw9Ni1MZSIQdeSHvXrl93xfTqIVdPF3+v73M21Gf/WkDG/K4ndIMVnQcA1zdTZjy6pcioKnCxkK6ZecFc/xvL2MAAPt+NA0OMXhqsGf08ZREPvjGlg2qEKlQ/CNY3bbbSY/IZ4NzkQS5cbCWWVKyhssp+AvUrDvESBoHg06YxtiQ3yzWM16A9dpEMjnWrHnF8kQFztjKCPB5Gyc5XFcdF9qY3bPmxbrFKQE6gd/Pyv1P6yTqpirTcBsLdvlvM9XXnqIgTTBlSq88AMP9l3cH6usQynJ7z9MYM++wIh65a6bwI9jwht541K1MqEO7GzIZouKOm9u+lOgGqORd+c=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(376002)(39860400002)(136003)(36840700001)(46966006)(40470700004)(40480700001)(7696005)(1076003)(186003)(426003)(36756003)(82740400003)(40460700003)(70206006)(83380400001)(26005)(2906002)(81166007)(356005)(70586007)(8676002)(82310400005)(478600001)(2616005)(316002)(6916009)(16526019)(4326008)(336012)(54906003)(41300700001)(5660300002)(86362001)(6666004)(8936002)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:01.3502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566f5bfb-a374-4558-5da2-08da5accb0e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5812
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
Found when running igt@kms_atomic.

Userspace attempts to do a TEST_COMMIT when 0 streams which calls
dc_remove_stream_from_ctx. This in turn calls link_enc_unassign which
ends up modifying stream->link = NULL directly, causing the global
link_enc to be removed preventing further link activity and future link
validation from passing.

[How]
We take care of link_enc unassignment at the start of
link_enc_cfg_link_encs_assign so this call is no longer necessary.

Fixes global state from being modified while unlocked.

Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 28803ca9e3f2..332110bb1286 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1994,9 +1994,6 @@ enum dc_status dc_remove_stream_from_ctx(
 				dc->res_pool,
 			del_pipe->stream_res.stream_enc,
 			false);
-	/* Release link encoder from stream in new dc_state. */
-	if (dc->res_pool->funcs->link_enc_unassign)
-		dc->res_pool->funcs->link_enc_unassign(new_ctx, del_pipe->stream);
 
 	if (is_dp_128b_132b_signal(del_pipe)) {
 		update_hpo_dp_stream_engine_usage(
-- 
2.25.1

