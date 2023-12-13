Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE31DC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Dec 2023 06:14:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436A010E6F4;
	Wed, 13 Dec 2023 06:14:10 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::615])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F332910E6F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Dec 2023 06:14:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lN1lFu5vF4UPc60P6/bsFZEHkzo6w15XzvNJXLPJNfyPCjIQCdcW9+FMr5hov9s5/uN+f4M2ZcgKluf31v+74QY965RZ7ZX/k4w/CZpmGzT+A/lmFqqswnDWCeSNseBEaiDZMMFs/+pHH6uW9Lh9y+zoPuzDuUGrjPpu1G6kZDYmxI05lkhywelrPbcdXY6+/yJ41yBvN1SphuEiATC7emnLcbRyccsJDVZnm7nT3F1UA8t3cWy/7RfR9yOxffMVTIbaU3AVgYRFSK4Os7WvwJ1jSnVpCxH3+8kcWSRgwHUWGFl8yEyE7snuTMRMo8c1aO1bBqXfxu8ZWWWyOe5qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f9DQFvEUCMixgntwYiabZLTG/IQhZKaJ/qjM0FUnYfk=;
 b=M2IL+JSyBRxMYkVp7K1o/ztH8qZRGkiSXVcfpf+4+L1lC/t8/ZKOXmXiN4Nozci4YnIZoD1WJGuxcbnyQ3kSNsDuV/19MxWkssKN8wzKR3AHJmTjxMbPV+R7izNmWyadTC/A5lTf8hZCUCv6lMKHIDm5QJcQdlu+rYnK8MZC4K1yXzR+jH1txlW/jGS2PO0+A89PNa7ftja/GLs4LcetiB19YZbAh3TB0Li1XPXqWAtMM7LgBX+2tAo24iqfT81KcJWcyG/7ROt+1x46ORbJ+CGnFo79Kfyr/K6cXDc/KosTP0TLLXvTyU5h+lhqkvtTgl/8RfNjW43OzL0EvMwu5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f9DQFvEUCMixgntwYiabZLTG/IQhZKaJ/qjM0FUnYfk=;
 b=KQgz5hJSBjVKcIfNmjGBF4sV3BA9ftMkOceuBsUuoG+C5kKT9N1Uo9BmIcdMW8FH5k07o1doBtFKW1UVsOFRZL4i1+qSXjff/OFWElh1Rzc9++cHCx1dehzb74lWxY/qWB6tBkSSb7rVPY0aiQb7jEfX0yuuEmUreztriS/6vfY=
Received: from MW2PR16CA0017.namprd16.prod.outlook.com (2603:10b6:907::30) by
 CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 06:14:06 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::64) by MW2PR16CA0017.outlook.office365.com
 (2603:10b6:907::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Wed, 13 Dec 2023 06:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.7 via Frontend Transport; Wed, 13 Dec 2023 06:14:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:14:04 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 00:14:04 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 00:13:59 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/25] drm/amd/display: add debug option for ExtendedVBlank
 DLG adjust
Date: Wed, 13 Dec 2023 14:12:14 +0800
Message-ID: <20231213061227.1750663-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da792a6-fd9b-4725-abf8-08dbfba2b606
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4PGV3jGowsUgtECARn+WN9B/OVnnXvMJ8BBpJnWznYNIH4/fR2WLrUoRu7TiUb0XQUZBT5U4i4AQQfH6dgW6cpcP72/0Nkd5o5Eu4dXsmiJ5cw/3qho0HDCtdfQHS2jinJmG/D6frRLJRZQm7CDe401lmTR/Ndcdb34gHL1IBvWsyvwnOlPPRsSvRbbMKSs5ZvfR88Ksmlv83Y4/efddquoEvHkYEdu6kM3riAsCuVkmWhwtmhzTr99GRe1ctI0LZU4CsBpcl2+Rcu8/253xwP2p4lgyo58nS9YOXZeqr4gps0AuKZiYkHddEAwHmysRDX/8SlKZFDiQ787WavQ1YrYWI0JLhWiHcSv4gUQ0nFp5DeYWyUrPV4D7Bm6A2JNRtAAHiJVva9jptAk+om6ZINCUy8ooDcu295/vuDp7nqlVxyB1AdmOkEoAEXcdzA3HLgoQA9Bo1WnqqJyy5S/cH17TqKQwUnawNQmgG1K0QHB6N+plPsMQrWHvzCZhCJmkcuFKtESnOnygS49r5LOHvZQldCz593/Yq0NhuX/fl1wedO3YT1QTHP8YldrdEdxMvmBQiDLyhI9xFrU4fl4Ox7kXOyDZHJgeFY+FVDoCdBPld3VCllZtyOqt2uXomwVk8s6jSzey1hgfxKF9//Tb3RBnUsYH8Qp/dqPeFF3rIxyvjsrN8N3qL1SJiQJwpWNsVEBjoO6aai6gZvG25qRzQGltl6yKULBLsWSnVNQ4oA8HRHDYcjaqtdk6hJS1mQwI3omHj0HQqYQlSjIyQCGDrA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(83380400001)(2906002)(81166007)(356005)(41300700001)(478600001)(82740400003)(86362001)(54906003)(70586007)(40480700001)(426003)(70206006)(6916009)(316002)(6666004)(7696005)(8676002)(8936002)(4326008)(40460700003)(1076003)(36756003)(5660300002)(36860700001)(47076005)(336012)(26005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 06:14:05.8658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da792a6-fd9b-4725-abf8-08dbfba2b606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[why & how]
Add new option for debug usage

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                     | 1 +
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c87ec3e0a8cf..ce00a6eeb164 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -979,6 +979,7 @@ struct dc_debug_options {
 	unsigned int ips2_eval_delay_us;
 	unsigned int ips2_entry_delay_us;
 	bool disable_timeout;
+	bool disable_extblankadj;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 2c8eff815ec1..72c580ec650c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2221,7 +2221,8 @@ void dcn20_optimize_bandwidth(
 			dc->clk_mgr,
 			context,
 			true);
-	if (context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
+	if (context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW &&
+		!dc->debug.disable_extblankadj) {
 		for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
-- 
2.37.3

