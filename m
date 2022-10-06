Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BEFC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:27:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C2210E8B7;
	Thu,  6 Oct 2022 21:27:56 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6055410E8AF
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3uhcPGrW+VjQ5GzdeM+td+UEUXxE9IUpR91j3T0bDSy5ZtXVsDHXmDtcIoauZoDHIwGATLAmSqlkAh3wqPZjhOE15EPgQ2MEfZ5D8facWu7t4cIgzgkiKgNQZDtyAopgS2JoYwzZ7MqolzsF9I9XSc36k+niwxySQfY3aKuT9NnD5VNdCe6aNrDq8ioSKPKAorbD8Yq1h8MkHyewqgyvL0KqG7roVr9NCRtwQpiEb/tlxc6cHxkbXMWoLWQLLB0aR70MTYXneQ8VxnMAiCxb6d+ZwhBYCg1oyYsgJfW3Lp/xmD+n+kbWe17RUoGPsolQYNSvN203+2JLriyRgZASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cwik2bFyou21rexZUYnm/luh+FBiPIR63EGBsbHCtcA=;
 b=lAtaNt4ovS0F7brKjvktJGegxrQv/HnPTjnPBD8Kaop8cGAw+Vg4kq6lHKf0K9fqa4gw8VT1Pwf1HGuNWw1tGUf5+BaABJD1xwnbfOi1p09cmnv7GhqBS63k+nQJggm3ZXqfhqVfIJr6tRN/3XfvvWXk2hWd1c+09C4CJbZMm++a8X5b6EooA3nSEWo15tR5qrE5qqSN4bHh2NxszldGKw/nn4wnzqJrk5wiMhWG0hOylPaY4TX71jDtyMM75EGhBazhcqQbFfKqeNjzJ+1unTxGC0hRYs+CT3HV+vwa6HQ0PMsxuwntew3ZsqWyuZxWQStGbAWMn36THciz5emRMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cwik2bFyou21rexZUYnm/luh+FBiPIR63EGBsbHCtcA=;
 b=LYQ3bcp18oanSNf29fTRa376cW9frnA61mWeSw/emmDjmPiXQB3MV3TQDsEkicsGu1E3biAw7UKIq87r1xpbNm9lG1ZXMWhLRNsZLmGbBy4AseSrMYgz7kxwOp8ATz55EPhI2b+zc2yPCMb68WBnFBQjEVmN9Fn2pggVBLdQw7k=
Received: from BN8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:408:c0::25)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Thu, 6 Oct
 2022 21:27:37 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::9a) by BN8PR15CA0012.outlook.office365.com
 (2603:10b6:408:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:37 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:36 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/23] drm/amd/display: Do not trigger timing sync for phantom
 pipes
Date: Thu, 6 Oct 2022 17:26:34 -0400
Message-ID: <20221006212650.561923-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT038:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9e7660-b030-4091-9149-08daa7e19775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WaB+MgkfNJBkle1L/6beozAWusx009S1yamec9FtUhdJWv188C0F7slw7pGjYnXe3UOSt7AOKkoVPRsrMMuK5HVr5lJ1hOnLhZD/51ZlMkbxJXfbkz5yAlOlPyLY9z9CdBLatl+pnhKg9GsndMVonXJXNwrfWtTlZWe8ZMfhHBW/IyHy2GNnmfIocFcA6C5cvowhZv3CFIr6uWhc5b/E0soON92+xHMO36OmlYQXLIzyJ6mZobk86nULpMwHHz/MHWSKDkRtvk0A0JjyEntEO4qpiZ+Vh6Xiqj8UQ9TNP+6J3gtrbXwvZ6XX8oX8300un+PLYGi7A982kWnF5lWrV9NzXb23cHVKRPxQ66MiuGJuzwREKSuCniH9CB6hndVoC2BH0+J//oY0iii8eDPMK5H/Zg5l9WtibjKgnQ6O4ivSbyg/mxHMTQNnJUeZnnvvu47V3pPPUYkqc8Xib030ZD2PGph/2C5epBHSVe8wEG0YN3IBjx4muvsDbVHdBipWIN41JtxquZcz05lNtQC1vvmuGhadwZfjp0cvfZvXQEkTeRHfx1o1M+8cLmKsplPeaIN7sWcA6d7b+1fSNhizDmZ+K5oSel3J8A2Q6s+IqFFK5Ak/diw4Z/P8LbsbkLgmHiytQqs6znEtWSFEDZtSF5t9644ihgd2J9ectNHsLV+8QFW1sVmZCTk2+yjKB1N9ncjpI4bovdH/RYz3plNSsPoFmw33n95F4KnYUbv3+xYnn+XIqaLqD2vDiITn3DKbXtV+pu2xuVyqRBKA9+R6UpreKuPs4kLOvCc+GgNVvzvD4c0XGMeksGilaSFHMKbq
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(346002)(136003)(451199015)(46966006)(40470700004)(36840700001)(82740400003)(36860700001)(8936002)(41300700001)(336012)(86362001)(47076005)(356005)(83380400001)(81166007)(426003)(2906002)(1076003)(2616005)(26005)(16526019)(186003)(54906003)(4326008)(40460700003)(316002)(6916009)(70586007)(70206006)(8676002)(478600001)(5660300002)(44832011)(36756003)(82310400005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:37.6110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9e7660-b030-4091-9149-08daa7e19775
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
Doing timing sync seqence for phantom pipes
will not go through since they are not fully
programmed like normal pipes. Skip the sequence
on such pipes

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 26 ++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index f4b3ec32a331..305e0c545374 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2244,6 +2244,9 @@ void dcn10_enable_timing_synchronization(
 	DC_SYNC_INFO("Setting up OTG reset trigger\n");
 
 	for (i = 1; i < group_size; i++) {
+		if (grouped_pipes[i]->stream && grouped_pipes[i]->stream->mall_stream_config.type == SUBVP_PHANTOM)
+			continue;
+
 		opp = grouped_pipes[i]->stream_res.opp;
 		tg = grouped_pipes[i]->stream_res.tg;
 		tg->funcs->get_otg_active_size(tg, &width, &height);
@@ -2254,13 +2257,21 @@ void dcn10_enable_timing_synchronization(
 	for (i = 0; i < group_size; i++) {
 		if (grouped_pipes[i]->stream == NULL)
 			continue;
+
+		if (grouped_pipes[i]->stream && grouped_pipes[i]->stream->mall_stream_config.type == SUBVP_PHANTOM)
+			continue;
+
 		grouped_pipes[i]->stream->vblank_synchronized = false;
 	}
 
-	for (i = 1; i < group_size; i++)
+	for (i = 1; i < group_size; i++) {
+		if (grouped_pipes[i]->stream && grouped_pipes[i]->stream->mall_stream_config.type == SUBVP_PHANTOM)
+			continue;
+
 		grouped_pipes[i]->stream_res.tg->funcs->enable_reset_trigger(
 				grouped_pipes[i]->stream_res.tg,
 				grouped_pipes[0]->stream_res.tg->inst);
+	}
 
 	DC_SYNC_INFO("Waiting for trigger\n");
 
@@ -2268,12 +2279,21 @@ void dcn10_enable_timing_synchronization(
 	 * synchronized. Look at last pipe programmed to reset.
 	 */
 
-	wait_for_reset_trigger_to_occur(dc_ctx, grouped_pipes[1]->stream_res.tg);
-	for (i = 1; i < group_size; i++)
+	if (grouped_pipes[1]->stream && grouped_pipes[1]->stream->mall_stream_config.type != SUBVP_PHANTOM)
+		wait_for_reset_trigger_to_occur(dc_ctx, grouped_pipes[1]->stream_res.tg);
+
+	for (i = 1; i < group_size; i++) {
+		if (grouped_pipes[i]->stream && grouped_pipes[i]->stream->mall_stream_config.type == SUBVP_PHANTOM)
+			continue;
+
 		grouped_pipes[i]->stream_res.tg->funcs->disable_reset_trigger(
 				grouped_pipes[i]->stream_res.tg);
+	}
 
 	for (i = 1; i < group_size; i++) {
+		if (grouped_pipes[i]->stream && grouped_pipes[i]->stream->mall_stream_config.type == SUBVP_PHANTOM)
+			continue;
+
 		opp = grouped_pipes[i]->stream_res.opp;
 		tg = grouped_pipes[i]->stream_res.tg;
 		tg->funcs->get_otg_active_size(tg, &width, &height);
-- 
2.25.1

