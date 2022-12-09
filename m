Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B2BC4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 16:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2E4D10E56E;
	Fri,  9 Dec 2022 16:37:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0A1A10E562
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 16:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOdaX27Dmx5CEdZdOBuMDJisGzPkdrhvhIjzwwKxwwXwyB30Q5bqE6+s3V5zBW6dIpw4iGfskV6gUIFniU/wmNwkbKuMBae8EOds4NpB6As3dI3NV0PvY+2K/mh7tlYjC9Y8cWsjqMQMz2wM6Z8I1EVmWJKGmEd7M7uSsIIwy4RLW+fawaekKh7HC+TeFh9g7mqdIMljGYavMn9A84KmDp6f1JlUfiNLmrrt5YV4v06Up99695CvEXDOs01xpfdY/oQTmQ2v19UsQhOzxI4sl9WECDbMD6UWh8nc7Jv6+VI+0bqySGL3oOAf333TJLs/3iv7qwl3dsGXj06sNJquQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGW2tpCv+iHrVJqoXX+7jdSGRGn3S+ta3RJ7sGo9nq8=;
 b=MtVtt/T2lC35GFqelm0Y2VWXrLqP4tpE7cyI45mt7sVYhG91hd55AA5rOxEkdIh5ES3ljCAIwdmeDN6sThiabUY+TiREKViNFXTe24VpJQVhOH6gWN303HLhu8EeA9poa+XLGvYoY8d0mUIY95rWsGGUq13uWvu7xWG+728dIzG6Z5JRNMExZtYng6OgUnvnO5ooMT8jIsV7E+nAcisktMESf1LeqCkl1VLEOVOwBZJ2245uSn9Gc6ErypjB5lzC43FEUsi/e+AzMuHRmn0xHMMga5cXtWJ1MNieQPPL7c23qknN9/d16gzXWzi9fbo5pK1vCXA9jkrqPoyTftWReA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGW2tpCv+iHrVJqoXX+7jdSGRGn3S+ta3RJ7sGo9nq8=;
 b=Xw6jwTqxIb/ydxlxunFv8Lj+Nwjn0id+5hFREsBYUu9WC0IKFYURZ0wLsKy9l3BBSFvxmfZZ0R4M5YolcNEBcIAIuzYIcyI8Sy1Jf+XrostakB8c1ePMmSHtM7jsDzCw9exD/qHY74u8ZsHE11XyeW203L6XuI+qWYXLg5h+G0c=
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 16:37:30 +0000
Received: from CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::bd) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 16:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT085.mail.protection.outlook.com (10.13.174.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 16:37:29 +0000
Received: from jasdeep-System-Product-Name.phub.net.cable.rogers.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 9 Dec 2022 10:37:27 -0600
From: jdhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/23] drm/amd/display: Block FPO / SubVP (DRR) on HDMI VRR
 configs
Date: Fri, 9 Dec 2022 11:36:36 -0500
Message-ID: <20221209163647.25704-13-jdhillon@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221209163647.25704-1-jdhillon@amd.com>
References: <20221209163647.25704-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT085:EE_|BN9PR12MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b6935d7-9201-4ca4-fe2e-08dada03a9ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G9I1mMB60jzNumgcu7Ta4VZjNfzut4ZsdKJEJc9uMmm6+EL0UVM7S6BEtlUv5vVu+2GzwF/gTKD0Pyu/L4e0rYNp1UhOfwwWNBoV4vyPb9x+bFdVv7EIU8jTsVW1q3CpTmt4CZ30ZCcVM8VdJW5X1G0i/JPt9AZ3Q3bYDn5pBWjR+WrmC+GtvtDjLKUZ/tOhg7low9uIXzc4pgtuvqqu0HFtA0ud8tlPa1xxIqMrSuX/rZxJQtO2NpwNV1RYiHScBymdCQvh9WWnFi5gQVJrWPCSrxCaKJUSWuS62CUXAXhSOWlrfi2fnJEdfsTZgmxo24k/dahu6toYx4RMxg5Ac4Dbn0Ogcmv3qaZ+vXDFxiM6LSbTXP+Ja3wnktoGQIJ6fhEME5pB6Cbfte4fFKKJ7L7GdwTctRF54mKxOBdqhy7wLG2DHkIKc7L7sCNR/wn9JMd/qHesVuowlgxYUPrtjBnktm/yxOoJ2+8NlD+K2Pg+ZsGzTnXZi22J9P0uP727kjWiehIsq/TQpnkmzHLfzXjw8T2Izvx0cihW6vy9EA3Hm2PEUIS7tg9sjm2p6zMo0ouzUqM1Sv3jIz9+AurqV8pk6yluGjBu9vTWKXOWkVH++OJqCy35ocTFTKo0Xv/7/vbNQbKTEfqO/7zCgYgouLUeBe1L1qCh9I38sdLFq88nXldmKYyJTPNffs9YgWCluAhSzdSEghJ36MhCQq2hBXAvt8NS37pm44U+6291DKs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(336012)(2616005)(1076003)(16526019)(40480700001)(2906002)(83380400001)(40460700003)(54906003)(36756003)(81166007)(5660300002)(8936002)(6916009)(70206006)(316002)(4326008)(70586007)(356005)(41300700001)(8676002)(6666004)(47076005)(426003)(82310400005)(82740400003)(186003)(478600001)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 16:37:29.6667 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b6935d7-9201-4ca4-fe2e-08dada03a9ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT085.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
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
 qingqing.zhuo@amd.com, Jasdeep Dhillon <jdhillon@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Nevenko Stupar <Nevenko.Stupar@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- Current policy does not support HDMI VRR by default, so we
  cannot enable FPO / SubVP (DRR) cases

Reviewed-by: Nevenko Stupar <Nevenko.Stupar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 2 +-
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6a6e4c844316..37c6be337a85 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8359,7 +8359,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 			new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
 			old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
 		}
-		
+
 		if (old_crtc_state)
 			pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
 			old_crtc_state->enable,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index ff5f3ef8be0a..815cf13ebe11 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -979,8 +979,11 @@ static bool subvp_vblank_schedulable(struct dc *dc, struct dc_state *context)
 	}
 	// Use ignore_msa_timing_param flag to identify as DRR
 	if (found && context->res_ctx.pipe_ctx[vblank_index].stream->ignore_msa_timing_param) {
-		// SUBVP + DRR case
-		schedulable = subvp_drr_schedulable(dc, context, &context->res_ctx.pipe_ctx[vblank_index]);
+		// SUBVP + DRR case -- don't enable SubVP + DRR for HDMI VRR cases
+		if (context->res_ctx.pipe_ctx[vblank_index].stream->allow_freesync)
+			schedulable = subvp_drr_schedulable(dc, context, &context->res_ctx.pipe_ctx[vblank_index]);
+		else
+			schedulable = false;
 	} else if (found) {
 		main_timing = &subvp_pipe->stream->timing;
 		phantom_timing = &subvp_pipe->stream->mall_stream_config.paired_stream->timing;
@@ -1195,7 +1198,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 					    pipe->stream->mall_stream_config.type == SUBVP_NONE) {
 						non_subvp_pipes++;
 						// Use ignore_msa_timing_param flag to identify as DRR
-						if (pipe->stream->ignore_msa_timing_param) {
+						if (pipe->stream->ignore_msa_timing_param && pipe->stream->allow_freesync) {
 							drr_pipe_found = true;
 							drr_pipe_index = i;
 						}
-- 
2.34.1

