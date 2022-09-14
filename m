Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D692ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D658010E83C;
	Wed, 14 Sep 2022 05:15:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4032010E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEWHSPcmXbgFyLgrVXYkDtL6zszF//LH7IPGXIm/3gJ7dFdXWYRkvGB/3yDRpH4WnL6x0ww1uceZwomr6MvWf0AbQqJktR58bSXb8lrQAdpAy47yc6WIaSajRLqkP1kqCiY8N9cQYVvTAgRRJ1BKqEf8kzsvGCijQtP/Ac4YiLUOqJA7OpkFldA3+F5/wX9D8wzI0eA7fsweR9p6+CX470dWP6cXbBeGNGf79gKP88Kh+Y36MPY2h4EsEIPmaX9feqPhUw9JooMxpfST5lvBVr0TMpDDmosY48BZgOpgu78nf6RJuF3rGGJFglQdNMD1yKMMX5FsXD2HXsfPl9nwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwC3hZUYMiQHw2mwi+01IbMKeIyE28Nc3a0pwSIGXZw=;
 b=l0GpxCMO4fhvycPKdQ8/nM1euYXg7PluocpLZL84smBbCiAHh3aE+HDxK1+Zf5PwHKRUzpbX7F/C/u9iKcMrL45/cBBHPiWzpn2qmZclry9lFeJ2KLeV3MGn2Etz39OfVM7rplmgdvSdJ78IJtXHKyLb8uJJ4TrFeekHHJCllM54a9BkYxhK/u5/rUAnfqLRX1XzEQs+X/rdXyW3x+vjs/aExPVpGW3Qm8LdVqmDs7vcG9WEC4i+tyaAPQkcWmuIaspiI35Bdhfq/AxGr/s00xrufcbUSxOgEYFPMa2KE3fpwbX0BZqejkasueMJm5h48f5lQ4ST74cARktEFPtdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hwC3hZUYMiQHw2mwi+01IbMKeIyE28Nc3a0pwSIGXZw=;
 b=FYzA8vfS4r75oc/Xek5/6Q/gNGmAiCigKC2FqSE9FYtfyeuTioWlF5IqXDP1VOgRmVNWhYrgN4WlnOSuDe/Y3HIjILiE9MOHCXwnu3Rc7BpJ7DzqasRjaQuMS/OemTfybfqSCA+pKKXHmpa8+eSSKNLdptnEclGjydqX6tB2pPg=
Received: from MW4PR03CA0276.namprd03.prod.outlook.com (2603:10b6:303:b5::11)
 by CH0PR12MB5154.namprd12.prod.outlook.com (2603:10b6:610:b9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Wed, 14 Sep
 2022 05:15:42 +0000
Received: from CO1PEPF00001A63.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::bf) by MW4PR03CA0276.outlook.office365.com
 (2603:10b6:303:b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Wed, 14 Sep 2022 05:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A63.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:15:41 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:15:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 13 Sep
 2022 22:14:50 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:14:44 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 21/47] drm/amd/display: skip audio setup when audio stream
 is enabled
Date: Wed, 14 Sep 2022 13:10:20 +0800
Message-ID: <20220914051046.1131186-22-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A63:EE_|CH0PR12MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a0e4a6-208d-4f85-a274-08da96102b55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CFZMKLkBrZGOnyKb+579fEKzbrgvrxw3/DTAyZFISbxbIonqApxn+8jzXK3li6BQkf8YtCGb3ZsE2rlmqY/Kb3ddE4wTThHsoWlvMvHwIn1GvsuKlG4UwouS9uEi8YaPhlwgsy1+jvR/s8XwJ5d3az20T221qTfkZeOu4TjFlfSeQdCZdNGIcmm1dtSqlsRhqiaxuE5y6LU+0iQvWMPjbL9z56viG7YjKIi39N83yuelQw/NGuiSncUDNqIp5dh4r+EBK03oXPgNG85JQCKLGndCAo58UCGGZSzrxNfP57A87WQefc1lTjNGg7ob6D4EI7UWclPa9sTWaMBuZnV5HXmJducWOVrBn919Tj2m+E7F09QVbukqIaFSc08T2hyfZheD2jcGtmrjmzf/M1YDpiGvLE7F2RppBEfHhzEbdFIdZW3qj0E7hxgKgTqHNArFFXAiAD5C/iiPgNmIBt2p1iEv2/1IZesAAKRxlyyVBdA3VXEnkRT/GtAqDBRqVfXdqiIqh38NcLLjCbehNHfo1/d0o6pxeSvRdi/wOcfmekqvrj0K/PcSOl2Q0q+8tOwxZznDQu0QpWEgtDVUDGlWFQ1LvnkO/u4b1psZ4UU4unTzE6o1QE1tPcOuR2VnwLDcf+r7zRPHmkkb2WOr/zA5tc/Vu4ZZfP4w2AWIWnD9/aySnU9M+06N2d4t0EVq5OblUYp4g1S35or2WK4CU24He5Z2Lx7krXMzUUVtDK7qtaaVkLK6//+w1DRn8S+NrghRus9OChau4+Fspw7UmxZvrWilMqQqBsuAa2nYFe7ABixfSWvxBYd7QsdvOV534nz
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(478600001)(41300700001)(70206006)(26005)(4326008)(86362001)(2906002)(36756003)(82310400005)(47076005)(40480700001)(186003)(54906003)(82740400003)(2616005)(8676002)(356005)(40460700003)(6916009)(6666004)(36860700001)(316002)(70586007)(81166007)(1076003)(8936002)(83380400001)(336012)(426003)(7696005)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:15:41.5147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a0e4a6-208d-4f85-a274-08da96102b55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A63.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5154
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, zhikzhai <zhikai.zhai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhikzhai <zhikai.zhai@amd.com>

[why]
We have minimal pipe split transition method to avoid pipe
allocation outage.However, this method will invoke audio setup
which cause audio output stuck once pipe reallocate.

[how]
skip audio setup for pipelines which audio stream has been enabled

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: zhikzhai <zhikai.zhai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 70ac0b31baba..55c98dbfcc1c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2178,7 +2178,8 @@ static void dce110_setup_audio_dto(
 			continue;
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
-		if (pipe_ctx->stream_res.audio != NULL) {
+		if (pipe_ctx->stream_res.audio != NULL &&
+			pipe_ctx->stream_res.audio->enabled == false) {
 			struct audio_output audio_output;
 
 			build_audio_output(context, pipe_ctx, &audio_output);
@@ -2218,7 +2219,8 @@ static void dce110_setup_audio_dto(
 			if (!dc_is_dp_signal(pipe_ctx->stream->signal))
 				continue;
 
-			if (pipe_ctx->stream_res.audio != NULL) {
+			if (pipe_ctx->stream_res.audio != NULL &&
+				pipe_ctx->stream_res.audio->enabled == false) {
 				struct audio_output audio_output;
 
 				build_audio_output(context, pipe_ctx, &audio_output);
-- 
2.37.3

