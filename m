Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D63E74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A438E10EB57;
	Tue,  3 Dec 2024 21:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XxKd7QsB";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 362A710EB57
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JqULGgHlgeME5/+2/QBG+CiOm/pzFV5jaXkU/3GLes3MgJejaN4iw2fv+s70U+o7GQ98pRHr72DA1l4WXLrfK/oS73aWfldVLUXa51tpittM0HJmiQFsMdQ02RIymmTGqO+4uwgUxWIVyhwy7ogZKVk3kQobn+7APMMUUe1T/31SFY48gw3EtTYzKTFu4v7eLgGmM0mOpqYkfV8ExMdE3rTE7eMORm5s1vhsaMjIyuPD6qFOGA/kPEII1Q5Wt2IREabRwIjQj987cC5RIUkEOFL5imUuhz4JIdnnL45/7oFDrXh2hdezsd1x1cE+wXi/5pX4S2y5FlsxqqYNFJVfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfHiuSstd+h0gKbnBiXvDk1OomP6k6EOs1JWGh0pP/4=;
 b=feLv1lbr8L6JZUtphu0CAW+63qyUP5jG7b1f0biV5GJQH3wReSMfQz31ABpB0HvoyqdDSzqVtAL4oVQt6YU3a2HzeXGteiuvBYXLjYHfA/V0T+Cqsyc4ovXBbXvymjWbUnQId/a2BPifjzyudiw5lfmHzbFzf3ZSYMquFRV5LPuYPWWMX7qdPfnriU5RZwmycYHAQMSp6FXC0f1yT4mQcM97hEnf3+PMOEIz1aUax2J3QcQkvsplMqcE6mgks1/dO/PEY24tDwtR1H/c/1/gXvFPiN6PGw4hBvIU9AJ54cKFUjwHL4KyINz1zQoi9+G84HoOKCqiArS3zxghgnfvaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfHiuSstd+h0gKbnBiXvDk1OomP6k6EOs1JWGh0pP/4=;
 b=XxKd7QsBWLol8Q9pcpswN0CkYa6glU26oL8GeBKJ1DysXBMQ/JoYqrrO3Yyx8H2VTc0xA3SztdMBb4WtWmvKjJTOiENX5gUvWCEuf8m1eH0Ku3696FHZgpzFgekw8U7skX6mL5Y01jY3mHV5H29sIuXALdJwdWjCrFZM3UY4bMc=
Received: from MN2PR05CA0056.namprd05.prod.outlook.com (2603:10b6:208:236::25)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:30 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::54) by MN2PR05CA0056.outlook.office365.com
 (2603:10b6:208:236::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Tue, 3
 Dec 2024 21:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:28 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:23 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 04/19] drm/amd/display: Adjust dc_stream_forward_crc_window to
 accept assignment of phy_id
Date: Tue, 3 Dec 2024 16:39:42 -0500
Message-ID: <20241203214120.1161810-5-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 88e91c9e-7f54-4d4e-d83d-08dd13e33f60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lGH0JaG6zXC0QrnaDHa5KyLlqPIkmtrrGgGUcY8teAJGFLMGJ4QrFrFsgZR4?=
 =?us-ascii?Q?/4kADBfzTsrhEcOHXcevQl293CxyNqRNkfBYshB0ekJzKD269di1XAhYsRLX?=
 =?us-ascii?Q?/tUD9M7pB/yKOOimJTjvi6BpyCvnacAxGmSZHek9YEpYBsKft2pKmvzCP/n5?=
 =?us-ascii?Q?qOSJbe6nqpEsmoZ105Jo91+5CUI/AhzZ1Xr1PRMFi415kkhIwdLn1RocqO4/?=
 =?us-ascii?Q?9WSZCSGT2e39nZbDHRvxkYos01lqETZIqXDAFibjdg4fIDbidSycDYAzRDg6?=
 =?us-ascii?Q?glBERgMU/FhQdzU7cK37Wd4RxVi6mbE8iZBJadwD1vbEbrFVtyOWA0+sfarG?=
 =?us-ascii?Q?bIme/macdfALyuojtadYY4pSU4OWabbTsEZYPIvq9r45ktOPYnRjE0RR7u3V?=
 =?us-ascii?Q?7NXBYcSVIVN+l8To5+PgGmc4HfuVDRHqtm4frPUwAD+0QM0I3f4AAaG6Yk+B?=
 =?us-ascii?Q?xNWK7iJdq8sLVhTYFfz/UAgkBTTSQmvq/lVZNDTo5DPWy3VDz7Jx9isLHdhp?=
 =?us-ascii?Q?fgjyjnMFjOm5UYdIeDRaaWgE6i3ZJ4IiD2Pz4KLN1+nBJxPgOiylYfMZBgn7?=
 =?us-ascii?Q?sKDdlzF9XahJ+IxeYLvexb/IkehmHZp0yUBtRty7ckDcFzbD2gc/ZBvB5hM/?=
 =?us-ascii?Q?dDp95Hxe3vUfyG4dBGjCWEfpg9aBq1mizAfbJfwWUiH1/FfyWiLVZMnZUog6?=
 =?us-ascii?Q?aDRUKbGigPbAE+j86cd+IUdtDWLQmtJClDdoVPXu6jfohkABfVN637pBVa39?=
 =?us-ascii?Q?vTJ18astNoS7B/YFB0xw6R9aOZhqdRYrdoCj1hLONPUzElxbBi/zG6FP1qG8?=
 =?us-ascii?Q?67r7sPNRXoJy2Q06eQPMdi/FbkAcbEBuVXnyNmPeoDix4HPelIcfmsCDyLTg?=
 =?us-ascii?Q?f1tPX3TKAehjtCmspsMLz8jGCxGJIpNI6iLOsZsXlfqL3r/WSuAqU69jpxvS?=
 =?us-ascii?Q?PE8uIePof21PsTE9yxt2beUAJiLqU+XB0l6U2kNAvmXZHv4PHGJ0WEpjOazo?=
 =?us-ascii?Q?0ew01JUczNp+qig+Vua2XxAKTHNZYtg0eujy/iJCtU9ci283Wt5VrzNRnb1g?=
 =?us-ascii?Q?6iOwVgiey9wmPIQ4PuqcNDCyOHlW6t6LooEhMOS3vsdA3wc0KwP5Z74lZyjT?=
 =?us-ascii?Q?e8275pVF81yTMk7iSnV93SGX14iBYDsuVoxltrVwxBrCmwH+CeAoRphb7PtF?=
 =?us-ascii?Q?rYoTgeUjKR6RgtzJJk4AxQ2/nP367TJE1T5L9w2Waq+wL0Wi18bsHQYfbcKf?=
 =?us-ascii?Q?XfKmChqrWy5OYRyKD6NP2YjYVmyxm+OvCd7Htve3xt7gG2jKfyvSkxKMmbR1?=
 =?us-ascii?Q?PQxEWZ8odYunCetmrkEtLfWg8JbWyCPH9dBD75bbTwlBinlX/slyTINh4iZ9?=
 =?us-ascii?Q?TCRdXX+XS08R6QJ6h3icJM81RQ0AMEpKkejuHVH5kR857cZhY2fKjVkJLWZQ?=
 =?us-ascii?Q?304ocge0nYs3uYWAfUIj5Lpz3Oe6X8iq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:29.7668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88e91c9e-7f54-4d4e-d83d-08dd13e33f60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
For mst streams under same topology, stream->link->link_enc_hw_inst are the same and
hence can't distinguish the crc window setting.

[How]
Firstly adjust dc_stream_forward_crc_window to accept assignment of phy_id. Follow up
another patch to determine the phy_id at dm layer.

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 6 ++++--
 drivers/gpu/drm/amd/display/dc/core/dc.c              | 4 ++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h            | 1 +
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index f936a35fa9eb..2679ce9a0980 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -89,6 +89,7 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_st
 	struct amdgpu_display_manager *dm = &drm_to_adev(drm_dev)->dm;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	bool was_activated;
+	uint8_t phy_id = stream->link->link_enc_hw_inst;
 
 	spin_lock_irq(&drm_dev->event_lock);
 	was_activated = acrtc->dm_irq_params.window_param.activated;
@@ -106,7 +107,7 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_st
 		/* stop ROI update on this crtc */
 		flush_work(&dm->secure_display_ctxs[crtc->index].notify_ta_work);
 		flush_work(&dm->secure_display_ctxs[crtc->index].forward_roi_work);
-		dc_stream_forward_crc_window(stream, NULL, true);
+		dc_stream_forward_crc_window(stream, NULL, phy_id, true);
 	}
 }
 
@@ -175,7 +176,8 @@ amdgpu_dm_forward_crc_window(struct work_struct *work)
 	stream = to_amdgpu_crtc(crtc)->dm_irq_params.stream;
 
 	mutex_lock(&dm->dc_lock);
-	dc_stream_forward_crc_window(stream, &secure_display_ctx->rect, false);
+	dc_stream_forward_crc_window(stream, &secure_display_ctx->rect,
+		stream->link->link_enc_hw_inst, false);
 	mutex_unlock(&dm->dc_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index dc14c0d05e8f..d3bcb646545c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -579,7 +579,7 @@ dc_stream_forward_dmcu_crc_window(struct dmcu *dmcu,
 
 bool
 dc_stream_forward_crc_window(struct dc_stream_state *stream,
-		struct rect *rect, bool is_stop)
+		struct rect *rect, uint8_t phy_id, bool is_stop)
 {
 	struct dmcu *dmcu;
 	struct dc_dmub_srv *dmub_srv;
@@ -598,7 +598,7 @@ dc_stream_forward_crc_window(struct dc_stream_state *stream,
 	if (i == MAX_PIPES)
 		return false;
 
-	mux_mapping.phy_output_num = stream->link->link_enc_hw_inst;
+	mux_mapping.phy_output_num = phy_id;
 	mux_mapping.otg_output_num = pipe->stream_res.tg->inst;
 
 	dmcu = dc->res_pool->dmcu;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 413970588a26..c46fe603c665 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -541,6 +541,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
 #if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 bool dc_stream_forward_crc_window(struct dc_stream_state *stream,
 		struct rect *rect,
+		uint8_t phy_id,
 		bool is_stop);
 #endif
 
-- 
2.47.1

