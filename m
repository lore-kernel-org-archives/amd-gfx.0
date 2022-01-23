Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9591AC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3705510EA1D;
	Sun, 23 Jan 2022 18:21:34 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E16D10E97C
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DftkV/u2sepRaWhG4sRYxVdQf9sxqZhtKoJsdc3zi67kB4kQLYlSMxzynY+TR8r1KL4OICsdEkJIAxF/oAvKo1h53IF+LTz8fQBxOm+grKgUeoAQVNJPb0Hw8NzKg3iUcl7B9qkDehCrjlEn9KJimHDfqLBr17tezhCBDJLnXSAtZhsTl/5pgTyqHkRsYuJYuGx4Db//tgk6USOjqf/6l2kGF/ywJBAJKYC4PDiTt+LSNEM6ia6HPXnYWffpvUuiutVsfX3/dm2xU7jWLVgAgWVn4yhjHcSGQodHTZ3t8Cy9cKjB//PUMZbKJZc28qO6lMp6aMFQOam++fPPB/NJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nd56oHwpSIC/QTN56bRhdVymadii09SMSTnzjtRhWe0=;
 b=ZPjSjQDUJjJ5csl8RoTkMtGCzYK/LGTj56tTLewW4wk9neGhGHnH+tOWeNNIxBqiI0sIUPcyZ4juXJCZFrDqSU+H1rYIQ6iPuCiWdv9F7svtCFR5/RMliEwg1WAqU69WZGjJqILImHd5dhLnjhMoe3UPB4WMxo+lqDNm9xtY7kaubixQGa9tQQ6gdI8Qfkueq4srnHXWNCG8oUOt7e8mpdCLiYDUnV1seLK6tRiFsoSd4kFBpQTvHiUY1x0ZQk6gTkdCMbbGKlyWPKjUyh6NTFOpOwYz29qnprnwF/QtT1tWJ5YE33Gn3QekL8FOY+6V+xLNNwPxq3l8w9HyBTEUVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nd56oHwpSIC/QTN56bRhdVymadii09SMSTnzjtRhWe0=;
 b=uFrRC3/rtznSnfdodr8LPPrxuKpNrm8k2jyM47gs57CfM1ABAYebh8k00l1nnY7YSm2ccLc4pyHtH2YHi0aXZrZM8G6ph/ErRJWisdE9NP2tK1Db4sgkBchvbK0v/kPeYJcktvH+GcbbAT85fXKL4XDGbmR8XuGBFF6wHZaVeBI=
Received: from BN9PR03CA0965.namprd03.prod.outlook.com (2603:10b6:408:109::10)
 by BN8PR12MB2850.namprd12.prod.outlook.com (2603:10b6:408:95::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Sun, 23 Jan
 2022 18:21:15 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::7b) by BN9PR03CA0965.outlook.office365.com
 (2603:10b6:408:109::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:15 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:12 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/24] drm/amd/display: Remove unnecessary function definition
Date: Sun, 23 Jan 2022 13:20:16 -0500
Message-ID: <20220123182021.4154032-20-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6f2ca4-3bca-47fe-69c7-08d9de9d24ae
X-MS-TrafficTypeDiagnostic: BN8PR12MB2850:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB2850BBB177D4577B000F2DBB985D9@BN8PR12MB2850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKTVjvcBMtOjMMEzISeO5gTY6/XARqqXeLWWH9/AVot1objNDrO+5133WMjHD1aZkO5LLgXoT+drJJBFow/Gl7Jo9kf9Osad/va3OYQVLQtkAwPEq1uWalsLuYkK2SCeae2lT6pGgtrtch3axRn29UM3tGheKFZ+UkhlBwMoOoZ4A64RnSor6DlB56d6g6IK6nAGG4sGVx9S5kEdVKtw2nkd00LG0VboGz8Dz8X4m8RauQAB4PM0+gWGMS/ZwqdrDL2ZaaenuqggOVHUH+8sTl2NBDGkYVbnMb98WpZrWo6lSp3ljwyCGOfnm8m0XEufviDAsht8VZ8XZdMiN18wmrfi5vqak9Ld6kr7y0TKjRhaiOGRx+rZt7qy9U+jxARCOm3k180G8+vojO4GqkZcnQA1KMAktk6v1i2fCPzfv2F/RMPR4qC6Y2zLLJLFKeQn6QbEnwOigQYp1YTt6U9iDYyTxb7Kmbb5NUUKKJO+s/VYi0cGsgFu6APcdxPQJJKIN5abZhW7pCiczNPVYgF+wOV2EjmBOtFyK2Z8Qc/BC7OCVZpVxYFQG2XToSO09SuiuAXqCMkug7vfwXaC1G3VrP0dxz8Vb71miZYRLnacEon25u9y9MkczxfLSe33998lqXwnwfSjORF1f6D3nB/QuQzCJr0eL5jPBEfCJEHVsntvDp4gTy6myOCSsL4wv5tgoayzmLolvWAEbVA9EjMo3CgML/KvWzz1pRqHwIIynHv+qTTQ2YQOLipIZBwUlwA33BmjbQ3cr5xQT6JyHHy88Zyex8YuJJnMeNbzrvEpccc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(8676002)(36860700001)(1076003)(40460700003)(70586007)(81166007)(426003)(6916009)(2616005)(16526019)(36756003)(336012)(8936002)(26005)(186003)(47076005)(356005)(54906003)(316002)(5660300002)(4326008)(86362001)(82310400004)(508600001)(70206006)(2906002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:15.5809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6f2ca4-3bca-47fe-69c7-08d9de9d24ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 5 -----
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h | 3 ---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c  | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index dec8604a0612..ed0a0e5fd805 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -355,11 +355,6 @@ void dcn30_prepare_bandwidth(struct dc *dc,
  	dcn20_prepare_bandwidth(dc, context);
 }
 
-void dcn30_optimize_bandwidth(struct dc *dc, struct dc_state *context)
-{
-	dcn20_optimize_bandwidth(dc, context);
-}
-
 void dcn30_disable_writeback(
 		struct dc *dc,
 		unsigned int dwb_pipe_inst)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index 357ee14711ad..73e7b690e82c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -50,9 +50,6 @@ void dcn30_disable_writeback(
 void dcn30_prepare_bandwidth(struct dc *dc,
  	struct dc_state *context);
 
-void dcn30_optimize_bandwidth(struct dc *dc,
-	struct dc_state *context);
-
 bool dcn30_mmhubbub_warmup(
 	struct dc *dc,
 	unsigned int num_dwb,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 73a416cba563..bb347319de83 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -60,7 +60,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
-	.optimize_bandwidth = dcn30_optimize_bandwidth,
+	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
 	.get_position = dcn10_get_position,
-- 
2.25.1

