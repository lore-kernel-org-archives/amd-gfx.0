Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E676D597A9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 21:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A287910E66A;
	Tue, 12 Nov 2024 21:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="naB+kewE";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E38D10E66A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 21:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WcR7clsVm8aEeoIFakdcgwWOXH4c7lsBGJcGO2XUCRC8hgrgzY3vcdos9G8EU/gyHTTQbQ/b3k58GIYySZ0serJxK/spaKndrwvYuoM/0asbSIgmXutlTfNc74uQmIxzAJiwT8opYqjUt5uywuWVRNzbKDltEsPG3sC52wftBqyVx3yrPEQ7HkxX4TB2T2kPDuwyh/8jLByDy9DMeShUmo7z7KoTsZfC1ca1NEXLVvO3DEXCs7LKbXuJf+1nMH+mHmw/ldlGc5CgXIaauShMQ7oShtU0+LdLR7sdmcX6BQsPzNeuCeYZveS+diPZLYargIL2ZaXggCTgJ0oDINwxHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dwEJGMUMGoMOW8TGFVQLA6PmLhm6YlriVi5CaPjJM8=;
 b=Seqx+GgWxdIo1k3rr1xj/SkAUyo542oOnUosh5G7TZKclUp0mAqk938fXivxVOxJMU24Qie00dFf5JxVlfP3J3KlC4NMu2AIDgePD3j2hhzEv1Il/6b95tSdLsYGnlLj6dZPRFMx3Kj4mzTBJSCQU2XG7qFBYWud0XUqlP7K9qDyWz6ko5F9JqmxSDbQv4Zc2CHHt+wRrO1RMByKx2/HKYxaY6aG/GsxPHAsJtaCeccMiC6zXRnp/8ApkiqBKFhmXB5OsB4aNElF65kS86e1Ws0b4+kim+s3ORNmIFY9MvSyxEOOlq/HflqrzSqj3pAKAJqMlM50kiPzVYPLrxFHlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dwEJGMUMGoMOW8TGFVQLA6PmLhm6YlriVi5CaPjJM8=;
 b=naB+kewEd5OaSk8tmkxz02tG7jVt7GXwqid/t63Mj4pNgBval6wVOBQfdsTgQKq/6iWuZidDG503tOyRxc1XcErFbjH051wv716CSM/N7qBv6Abs7jRUd9fS2NZPxWs9VRJJMjeSYyoZGmfsi6wKcJIRMsNIE5hVOQiSaJI/pqs=
Received: from BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) by MN2PR12MB4109.namprd12.prod.outlook.com
 (2603:10b6:208:1d9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 21:37:36 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2a01:111:f403:c901::1) by BL6PEPF00016415.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Tue, 12 Nov 2024 21:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 21:37:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 15:37:31 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <yaolu@kylinos.cn>, <jfalempe@redhat.com>, <harry.wentland@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 4/6] drm/amd/display/dc: add helper for panic updates
Date: Tue, 12 Nov 2024 16:37:14 -0500
Message-ID: <20241112213716.49355-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112213716.49355-1-alexander.deucher@amd.com>
References: <20241112213716.49355-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|MN2PR12MB4109:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d542b15-9235-4520-21cf-08dd036239d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WlCqtJ+Eakvjns3/SqFz0Fin0rcNKqNImD4uQtX3Tc6axkqyTTLugdJbw3WG?=
 =?us-ascii?Q?eirKvMnmb0QMyCwa9CDmFvFTPy0nV+X/cxcFugq50ePsg+IRCVQOzLlh+MGA?=
 =?us-ascii?Q?r/BbxrDSFtc5XQUlWNfZK5FkNkjvsy32GHysBfbt2VgB3ELP4ZDrODrsHmh+?=
 =?us-ascii?Q?woblptIxvn7r9fSdRpW8j8MwU6pmjXQJT5bpCaLNs8XkxJBZr1DciHPKH9lI?=
 =?us-ascii?Q?oAstlZNjfCp2SfHmwhyn5Rozh6YALst8i12VTZDV3S1S6kN97knI4mORh0n3?=
 =?us-ascii?Q?UwZ5xb1z4f9OGVvgn/0h4Do/s4bivFgjP8i0axECsyixKEeZh10igR9cncz9?=
 =?us-ascii?Q?m9qk+Qfg/EVvs+NB77Sh9WCpy4BLFRYyiKOvH4fE6TRB8Lr66Xa0OUip1OQA?=
 =?us-ascii?Q?8qOm8kYh/z5zGKPKgeDWpo94w1HnOHBB23CbbHsvC8OJbTer5i/h7TzY/I3L?=
 =?us-ascii?Q?0ya3rd3as6mP2LlXpbQ9HIRyAONv3yAzkPGLDShZGyBFuwny98Wts3zFhECR?=
 =?us-ascii?Q?zSMlilyKKtX0KnL5ajq+wN/+Grc9gxGU1x1WWVTlb3JbLA+agdZLIyrs15//?=
 =?us-ascii?Q?BMQ1qxcjyllKDXyK+OMY3gx3oKqs51ioSahjLwq5CchdXGPM+zbtxsUpx5EY?=
 =?us-ascii?Q?W/AIDTWWUwb8d1O6Ti99xfHFuksxTWL15aFO4I+zI4pucaQEJtf6gxsQM7tn?=
 =?us-ascii?Q?/4OzVsRMuJRadsLNd6DTNl4qo3CK/fdBfD/d7/jiiEmNNARTVl4khPLGfjqv?=
 =?us-ascii?Q?n7gGz+njXFk+uVX1HwbHL3BDIjbW2itwShpTICIsTnJrOQOy4bSMjRURvSmb?=
 =?us-ascii?Q?fVA/Wm0oOiKZ1xrI+cJzA8msx2lmDke8tesIskzA/jMExmGEOh0Q1xhBo2g8?=
 =?us-ascii?Q?6AbOdxKEjNIb4TaQzPIN9FYMNv5UZW4hI5+hj6lFoYSzbUqJzbx7KLf+IA6K?=
 =?us-ascii?Q?axlGdxeVdGYqLSjxVBNnqhKMwqMkAbYHtO8j1cSzsLHSncwkQigkeEM//50E?=
 =?us-ascii?Q?cfpNop+VIRMPvgaBvogOAgV63rFuP6H4E8jagM/mVLniJkIv3jy3vmIfIXp5?=
 =?us-ascii?Q?IhMQF7O+agkhofH2qCL9Xb5ouMaBPLJmdjgzVovB/dKtf0+5zA33JUjpM8Eo?=
 =?us-ascii?Q?web/csr8ebphl7hVZXo/CdOqb+ZmYnRBvTuxFwyQXMKuUJXN/UsOmhlV6sBZ?=
 =?us-ascii?Q?WsE2IIKPUTaHsA6nKt7vFt0V8W1L4RbMtWepGZkCCxxBVklIBVubTnlTEP01?=
 =?us-ascii?Q?b1WyjjBTsOUZDJRc71Py/U4nonYuBK9yTDPZXhIo7R218ds1X5FFnNDzr+Im?=
 =?us-ascii?Q?DivzVXufQc5iQeaJpJ3gVl1M20AQUr8bkefuIARcajXG2CZK6uGCB+RnBIcG?=
 =?us-ascii?Q?cmkcNmDDxHRE+wqK27+EwMuxfiV+Y3+mg3od3wAWb8unlgjpkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 21:37:36.7307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d542b15-9235-4520-21cf-08dd036239d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4109
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

Add a DC helper for panic updates.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Lu Yao <yaolu@kylinos.cn>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_surface.c  | 46 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |  3 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
index ccbb15f1638c..50faeba498c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -277,4 +277,50 @@ void dc_3dlut_func_retain(struct dc_3dlut *lut)
 	kref_get(&lut->refcount);
 }
 
+void dc_plane_force_update_for_panic(struct dc_plane_state *plane_state,
+				     bool clear_tiling)
+{
+	struct dc *dc;
+	int i;
+
+	if (!plane_state)
+		return;
+
+	dc = plane_state->ctx->dc;
+
+	if (!dc || !dc->current_state)
+		return;
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx)
+			continue;
+
+		if (dc->ctx->dce_version >= DCE_VERSION_MAX) {
+			struct hubp *hubp = pipe_ctx->plane_res.hubp;
+			if (!hubp)
+				continue;
+			/* if framebuffer is tiled, disable tiling */
+			if (clear_tiling && hubp->funcs->hubp_clear_tiling)
+				hubp->funcs->hubp_clear_tiling(hubp);
+
+			/* force page flip to see the new content of the framebuffer */
+			hubp->funcs->hubp_program_surface_flip_and_addr(hubp,
+									&plane_state->address,
+									true);
+		} else {
+			struct mem_input *mi = pipe_ctx->plane_res.mi;
+			if (!mi)
+				continue;
+			/* if framebuffer is tiled, disable tiling */
+			if (clear_tiling && mi->funcs->mem_input_clear_tiling)
+				mi->funcs->mem_input_clear_tiling(mi);
+
+			/* force page flip to see the new content of the framebuffer */
+			mi->funcs->mem_input_program_surface_flip_and_addr(mi,
+									   &plane_state->address,
+									   true);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_plane.h b/drivers/gpu/drm/amd/display/dc/dc_plane.h
index bd37ec82b42d..fabcefeda288 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_plane.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_plane.h
@@ -34,4 +34,7 @@ const struct dc_plane_status *dc_plane_get_status(
 void dc_plane_state_retain(struct dc_plane_state *plane_state);
 void dc_plane_state_release(struct dc_plane_state *plane_state);
 
+void dc_plane_force_update_for_panic(struct dc_plane_state *plane_state,
+				     bool clear_tiling);
+
 #endif /* _DC_PLANE_H_ */
-- 
2.47.0

