Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FA9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510DD61283
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 510DD61283
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A636E40B;
	Fri, 19 Nov 2021 19:44:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 477646E40B
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiQIQO25GUeATGu2hF+/VkegardEFtb319zHNchgr18JVAdGL2FxQ+OhqXS1RF35dGd5v/MuO7Clj6P+700GXTdaxcv5G64bTa2S0jE2v399Ra00vLJsC8UxQgp9xzHL8hFl3vM/tSfXVyzVNRwX1gx3RQ0uf1bMxTUy6TU/eKmk7XmQwGL3VAK/HYfB8UhFSY30aksoDEyANytp1lVCWfjH8DMQS6EpS2WkdBrRcuTdaN0xA54Nd+j1yq9wtyHYDfZtTVuGzMNQGKID8AhaOID0B0du9sWli3yrAGMUbyRw26iJYBJgW/WDR+qrYbfoL5THhytGB8llAE74MoNKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T2ewF2HrcCOC3goJrCe5OhePDhYRMtwYiDKRnN6gozo=;
 b=T5K+WSjgkejgVx4RwZaveg0wVrk+1zvDGEPwZdla84FQjfJO1zi0Txdj9LKZwifTGssUKPPyHmDDSmkcB4Lj1v+WzxHQi4SBhOWfDzxS0egYOX3vaWcSUfEZki/m8fBkzpscQ5ylSsl3YxG9dI1czQE+IYad8d3LjimwE9JRPyf56xrrLprgg66fjjBZN7bssNH0IsdCKnBRHQqCf53UCvFUzBWMLOxGpPE0fk5mVf1awPKQ/XkCQ3WdlSPEOFVWrGcmfHA7zjuu/DrF30vBGoArnWRb5Y5fKrQOlqLuph9j0DfXBrxk1A03vF9LNKMWlpF6WM5mCyHvxqIZ5PciNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2ewF2HrcCOC3goJrCe5OhePDhYRMtwYiDKRnN6gozo=;
 b=RdTP6849L4KghxK9uGcIPjhe0t35ug3Ih/UZejpm6IeoVZnwbBbvcl1sc3SyBAcUm9X2lxhCjTtV99mOhA/QuNaqDUwDC7rbE+lXD2DPD9f3oE9ICBDE5mBwyS6pk2B/KUXXS+nB3k1hQLeU5GgwEAb7dY0MwMzidDaNxfBYkW8=
Received: from MW4PR03CA0280.namprd03.prod.outlook.com (2603:10b6:303:b5::15)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Fri, 19 Nov
 2021 19:44:08 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::90) by MW4PR03CA0280.outlook.office365.com
 (2603:10b6:303:b5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 19:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:44:07 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:44:01 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/16] drm/amd/display: Fixed DSC would not PG after removing
 DSC stream
Date: Fri, 19 Nov 2021 14:43:35 -0500
Message-ID: <20211119194339.97573-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2fbeec5-baca-4801-a299-08d9ab94f390
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26039BD95F743DFF1EEDC1A7FB9C9@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0sxbEM0El4rG9uw7VFzQGdoZl1wSxgKdonxIMvdagHEvmlN7tTfeTPd+pX7AUvqRA7O9FW34KHhuyYdBVoH3seWzKycUyh5NKm/82h/B6MDzjcYDLZUKHZmKLyp1oLr9xloC4zIDqj59w5Z+MBPFO/TXCx1hYWM7NR60yzBACNX/49L4BwRVmDxk8lb71duowTspSo0bdJwUk2zE6ZP25WFtTrW/7xM9jlaMJfABY7u3K9T0LLdYfIct/77orvldyGp0x0boLvUL8aO/ioZlgL6AQT+WtyiBD7FzVP/Itvz0aiwaloKneR2kNz1SLSeUhAx1wUILxUHVjYDQTU122WOh2x9affr5ukynzwENaveyNh7MJfmFEjOFheDWSTCoTh0XEZ2raXR6oCEgIkrAcMLExp1TsPzAOhGstTILcpFoOqQqphYUZHw8ishntc+AliNF8oswFZA6oT8lvJC4jg9zPA+ntY8jtHh6zfLuyCmiQfwPGAtydBt2JEZs2QPcNeB/MttfZXgw115Fum2y2mnBldRs4ZCAXPegyGcbehWi4ho4woQctv24JwwhzPKg9tJXkiqWy6nUVHWEc9X0QIPAmdzfQfGkm2HMNB38DaglQF47U2bLxMNZS3tOJ7m29Fy/UDfttXlZ22mfcfnjbUik1wzttVkiG2+mosPh9mgEyAwrvu2KMevx+11B8HOB5FTvGKjyn8y2EoL3HP3B/wsX+Bxrs+aT2T/UM6KG3Uw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(44832011)(6666004)(426003)(83380400001)(81166007)(70206006)(6916009)(47076005)(316002)(336012)(356005)(70586007)(54906003)(82310400003)(26005)(2616005)(8936002)(4326008)(86362001)(5660300002)(186003)(8676002)(2906002)(1076003)(16526019)(36860700001)(508600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:44:07.7908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fbeec5-baca-4801-a299-08d9ab94f390
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
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
Cc: stylon.wang@amd.com, Anthony
 Koo <Anthony.Koo@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Yi-Ling Chen <Yi-Ling.Chen2@amd.com>, wayne.lin@amd.com, mikita.lipski@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>

[WHY]
Due to pass the wrong parameter down to the enable_stream_gating(),
it would cause the DSC of the removing stream would not be PG.

[HOW]
To pass the correct parameter down th the enable_stream_gating().

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Yi-Ling Chen <Yi-Ling.Chen2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c        | 2 +-
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index d342c04f5f30..a2b925cc4132 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1639,7 +1639,7 @@ void dcn10_reset_hw_ctx_wrap(
 
 			dcn10_reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
 			if (hws->funcs.enable_stream_gating)
-				hws->funcs.enable_stream_gating(dc, pipe_ctx);
+				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
 			if (old_clk)
 				old_clk->funcs->cs_power_down(old_clk);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 4f88376a118f..e6af99ae3d9f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2270,7 +2270,7 @@ void dcn20_reset_hw_ctx_wrap(
 
 			dcn20_reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
 			if (hws->funcs.enable_stream_gating)
-				hws->funcs.enable_stream_gating(dc, pipe_ctx);
+				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
 			if (old_clk)
 				old_clk->funcs->cs_power_down(old_clk);
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index a668feff30b8..4206ce5bf9a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -565,7 +565,7 @@ void dcn31_reset_hw_ctx_wrap(
 
 			dcn31_reset_back_end_for_pipe(dc, pipe_ctx_old, dc->current_state);
 			if (hws->funcs.enable_stream_gating)
-				hws->funcs.enable_stream_gating(dc, pipe_ctx);
+				hws->funcs.enable_stream_gating(dc, pipe_ctx_old);
 			if (old_clk)
 				old_clk->funcs->cs_power_down(old_clk);
 		}
-- 
2.25.1

