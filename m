Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9EECA5FE6
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 19:33:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BC8A10F9E1;
	Fri,  2 Oct 2026 19:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gkOERmqw";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFD0210F9D2
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 19:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgtHyCKUFuQfOU9jVpg996KDpdh0bhx8/4jeq5oi3Vn9dvLfy6C+GzCp+ieH/sB08ejjt9bMDKYvNNKMmAuPcyLTainAc/8Z8GbfjznA3NByt6u/nudlvkdoY6NCLDUF8oI5k6mEQsA9WG+2cR7I4cBlj7G6UheqOn0++8I/qTQIYsGo0wtIFVMuzqjCvrgRm8UXUyXx2Pgfk3Vu6nHQD/chWwHVt8V9PLIligSWWEvdyNowMwCp+8dRDdEo1MQTpmMtgVTkSorMo4PCIg/r9Hk93tEXbwJwgl2sz+peYxcNTGCyoD7fqrVHcGvmLP1zm+Eh/m7fmKC0F7cbGkNt1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deQ0Z67GDWpBonZ7huiiVuHPbWPmQKMAvfJuT6R1KwY=;
 b=YRwmxV7Cr6694l1HrPtRsERM3AgL+6c4/D6QKf2IaAbjHFPK1t3hoAQ6B7eepQW0n1Xpf0nbdkvOZtprs1qeVzU9K3OzUtGpPcw0AOX7sdhv3vKK0vrEC3KBHzsfn2eSuVM2ZDEEJhtH+vOj82oipWuM66JUkh8fMZ029lUiOrm0Gm84m/igJJsgq+Tncqe6tdOVt0he9oEaMx+ebW63oZOkXYhPNp6o76asGed2z/6yYK+M7uvb9MJ86eiP+ye3OtCbGD2PC5F+dueU4BLf3aYjNr2DH0mQmhKZr2GdDTcRQyKQe1FIIlGV2/xhJSYlaKt2eRDl5OSt0LkRg/Yu3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deQ0Z67GDWpBonZ7huiiVuHPbWPmQKMAvfJuT6R1KwY=;
 b=gkOERmqwjh4ZklfdPujOXPg1LQ2oVG+getX0W7q+UQZ0JE9vtqJh70wcJpd5DnvUvST9EyQ6gPlQ3+N/ncjDn553/qeHlJdk2Cv+t8DPq8fk8h8ME0nigE1sLAJ1ysXYKvhFAisxSeeIWDhTHWXxBkuh4W04Mwej0NQMlPBAZn0=
Received: from CH0P223CA0016.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::34)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 2 Oct
 2026 19:33:14 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::6c) by CH0P223CA0016.outlook.office365.com
 (2603:10b6:610:116::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Fri, 2
 Oct 2026 19:33:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Fri, 2 Oct 2026 19:33:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 2 Oct
 2026 14:33:04 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 2 Oct 2026 14:33:03 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Roman Li <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>, Ivan Lipski
 <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>, James Lin
 <PingLei.Lin@amd.com>, Chenyu Chen <Chen-Yu.Chen@amd.com>
Subject: [PATCH 02/17] drm/amd/display: log MCM shaper and 3D LUT mode in the
 DTN log
Date: Fri, 2 Oct 2026 15:32:25 -0400
Message-ID: <20261002193240.3441018-3-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002193240.3441018-1-Roman.Li@amd.com>
References: <20261002193240.3441018-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 63182273-8b6a-4888-e162-08df20bbfec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: zwYNhTsmcyohewyp/o+ZmBV4yXHg2LXM2g7ZdZfrK53+6wmLdH6xjdPR6BrtnZDHIev2LBvohUb4EI0i0S/pNH8MFXZdMtvbdTcodreh5c6bruZ/i/qf7VaRgzhY0RXmRE2UFEcpJ1xny7TSKvlwf0FK7QjzZf+R4fYSMIIsdaPfgS2sWUZC3+hZuhdaksHVjD1usW473lDvPOjSAquPeYfaIY7pms0C+b9A6bzkTjJed2ijhVyvc/7GShu3ZWuLCU7WiqYxGcai3nYd9aK2q5TRF+Vf1Pq7cweNt22bluLGu+47zsnWaganS0fjIQg4CDNbwLO0hZr7Jj9wohXYAMSEOMCq9O2G0C5lVULLi96U4mX06sYd4ZZ/gcvQrqP+ERUYdbMPNEO8bjLBfIpzN3+Npav8Z5hzbKvdXQFLupNCh6JwFClju3VyHyNX3vEqstQHv/Xb3h79OjZybeyXYbQAJyGVU9ANPboV3X8fahRjbe4p8VAVeeqWa+mtQZIp8DZY3635P6f5KfJbLI5DBlodOdlwTwPazWjRRdjeHIVDmX068tqz5JnZC4SRmy9f35zhM2lvmS3GEmM8CEyozGh8ZOKT7fF+hFfSDp1bqILBFculMhOU4aemvdwMnkSpf8yw58pYIqiUuQj35OokK3Y3vpxaH5LHfPiUAynrKIqE8HzuRklWjHgSBj7bki+fihrz4slBY4GRtzOPadQQRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1VlZ2k8aM6GkiutliyDG+z5bCcT6nUqXmj5o2imVjOoEVgbx5T3wFWbk6dCIwR2euodbmC1gti2pK327ZcVM8AxejM0aSElEcebKHyRs+JMlwNkKnfyzH/PDhoyCdVKu+HZ3Ihdru1a2RzZkZPR/+d5lPpfyoBcU+j6UPzf34vBMMCRM7pU4EhWlyDviCMsQIjOPP3OYoyWHIdhDsJ/zvj7srlz5zYOuLiYiGXqdUZT9/9IIW+pZRFWeNwOi3HWKh4AIXN3iEyup36NA5dj3Y8Z2clPTvuN4kL6A+3SVvIROoqtVGHvIGFPL0yRj/ntVIh9Qvggv/jbFj656prgsFTj84Vjdv1eTj6PvTCTRg4R4U4AlF6eJ+TI67tN3PmoAeNDCvn5esaQRZkFMpC0Kyw/7dnLgkqeLGr1j2KQEd4rtOVshA7dkb5W9TrnM83HZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:33:11.4775 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63182273-8b6a-4888-e162-08df20bbfec6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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

From: Harry Wentland <harry.wentland@amd.com>

On DCN4 the per-plane MCM shaper and 3D LUT state wasn't visible in the
DTN log: dcn401 wired read_mpcc_state to mpc1_read_mpcc_state, which only
reads the base MPCC blend registers, and the MPCC section didn't print the
LUT fields even where they were populated.

Add mpc401_read_mpcc_state to also read MPCC_MCM_3DLUT_MODE (mode current
and size) and MPCC_MCM_SHAPER_CONTROL (mode current), and print SHAPER,
3DLUT and 3DLUT_SIZE columns in the MPCC section. Mode is 0 bypass, 1
RAM_A, 2 RAM_B; 3DLUT_SIZE is 0 for 17x17x17 and 1 for 9x9x9.

Assisted-by: Copilot:claude-opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c    |  6 +++---
 .../drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c | 18 +++++++++++++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 884319b22cc1..33f7ab4c6c15 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -542,16 +542,16 @@ static void dcn10_log_color_state(struct dc *dc,
 		 dc->caps.color.dpp.ogam_ram,
 		 dc->caps.color.dpp.ocsc);
 
-	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE\n");
+	DTN_INFO("MPCC:  OPP  DPP  MPCCBOT  MODE  ALPHA_MODE  PREMULT  OVERLAP_ONLY  IDLE  SHAPER  3DLUT  3DLUT_SIZE\n");
 	for (i = 0; i < pool->mpcc_count; i++) {
 		struct mpcc_state s = {0};
 
 		pool->mpc->funcs->read_mpcc_state(pool->mpc, i, &s);
 		if (s.opp_id != 0xf)
-			DTN_INFO("[%2d]:  %2xh  %2xh  %6xh  %4d  %10d  %7d  %12d  %4d\n",
+			DTN_INFO("[%2d]:  %2xh  %2xh  %6xh  %4d  %10d  %7d  %12d  %4d  %6d  %5d  %10d\n",
 				i, s.opp_id, s.dpp_id, s.bot_mpcc_id,
 				s.mode, s.alpha_mode, s.pre_multiplied_alpha, s.overlap_only,
-				s.idle);
+				s.idle, s.shaper_lut_mode, s.lut3d_mode, s.lut3d_size);
 	}
 	DTN_INFO("\n");
 	DTN_INFO("MPC Color Caps: gamut_remap:%d, 3dlut:%d, ogam_ram:%d, ocsc:%d\n\n",
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
index e59454090691..5f5c27eb1d64 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn401/dcn401_mpc.c
@@ -627,8 +627,24 @@ void mpc401_get_lut_mode(struct mpc *mpc,
 	}
 }
 
+static void mpc401_read_mpcc_state(
+		struct mpc *mpc,
+		int mpcc_inst,
+		struct mpcc_state *s)
+{
+	struct dcn401_mpc *mpc401 = TO_DCN401_MPC(mpc);
+
+	mpc1_read_mpcc_state(mpc, mpcc_inst, s);
+
+	REG_GET_2(MPCC_MCM_3DLUT_MODE[mpcc_inst],
+			MPCC_MCM_3DLUT_MODE_CURRENT, &s->lut3d_mode,
+			MPCC_MCM_3DLUT_SIZE, &s->lut3d_size);
+	REG_GET(MPCC_MCM_SHAPER_CONTROL[mpcc_inst],
+			MPCC_MCM_SHAPER_MODE_CURRENT, &s->shaper_lut_mode);
+}
+
 static const struct mpc_funcs dcn401_mpc_funcs = {
-	.read_mpcc_state = mpc1_read_mpcc_state,
+	.read_mpcc_state = mpc401_read_mpcc_state,
 	.insert_plane = mpc1_insert_plane,
 	.remove_mpcc = mpc1_remove_mpcc,
 	.mpc_init = mpc32_mpc_init,
-- 
2.34.1

