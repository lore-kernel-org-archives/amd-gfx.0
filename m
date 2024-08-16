Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B328C52D7D
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 22:58:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F33B910E858;
	Fri, 16 Aug 2024 22:58:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bXsZvt/h";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F143110E858
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 22:58:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZeEyJOegktRswlRo+uCvjogG5OA8zzkq07WSYbF2vIOGO8baZNvKjOWkG6TxlZytABuRhUu58aJT4vYR9zoQIfFTBPqUbR7c5WPuConIdB7ZBBltMAEF7sCPDCAFm65V8AzB1IsNZPF8+9/s5PFg/DQyy7RTTdEooJZBCChHPtbyvi8Is9J/iJJe24vypF8cZ176eFA/QY11tm7S+0j29gbAScjvWiUzJ8KDl4jN/c2pyqq3xGJMgkclsYSTZhrbBA7SKBIdd08h20LyL9AC7c61fgeq3qd4nVCu5C/CjAc3ysXncxmZVJ7bB59A3Q56yK1hDCnIXy+p/g91whTB/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnXvuGJgLjBPwV/dDcVApssrCxodhZG2pjuP+5LNNIc=;
 b=fllXmw4jvJ7c8lTuOXdJyJEJmkNh93jPFTVFwzRwLpaYAqtXmjZ7Ti/uuX+pKfmAl574JHwsS7ZGdE985zt9jDwqYEWKW/wcZa+lANsDveevyVRKrxe6DO6t1QH6lBaYaEUZJVg1Rh72T307Jdx41987aajzswd8wM1fdoLt/uCFBS/ddGhYmtb+E9m7pyZKsDeb+G5RlONgF2Ou+N39DCMfI1HI5K97SSylT+g4jWvmCKyXYvYoR2d+L9ZHvIJxN6bjacOr9FIw/Ckk7okDNbMOD/Ks/D0VhDTxRHZCQ+X6yva5eavZwQ2M85bBs3dG8QIsasXw8GEMBB7483Fq8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnXvuGJgLjBPwV/dDcVApssrCxodhZG2pjuP+5LNNIc=;
 b=bXsZvt/hAzcdguGBietUEHJM7hz1PLjpfAEBDE9cqt+bFwSG5NMeVesIeAFDyHLnY6u03KFRHjdPqNc6xqEahesLtZH22ScwfbcBivJAIhxv4BixRcLvLyI1tBxc1RKX5TPPrL6eHClWhZQ9nPgU88vTrP/Ah/w4kqSiXTQCkFc=
Received: from DS7PR03CA0194.namprd03.prod.outlook.com (2603:10b6:5:3b6::19)
 by DM4PR12MB6207.namprd12.prod.outlook.com (2603:10b6:8:a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Fri, 16 Aug
 2024 22:58:13 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:3b6:cafe::99) by DS7PR03CA0194.outlook.office365.com
 (2603:10b6:5:3b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 22:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Fri, 16 Aug 2024 22:58:13 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 17:58:12 -0500
From: <sunpeng.li@amd.com>
To: <chiahsuan.chung@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, <Harry.Wentland@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH 2/5] drm/amd/display: Go through dm for
 allow_idle_optimizations
Date: Fri, 16 Aug 2024 18:57:51 -0400
Message-ID: <20240816225754.156098-2-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816225754.156098-1-sunpeng.li@amd.com>
References: <20240816225754.156098-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM4PR12MB6207:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec129fa-9a43-4d5a-178a-08dcbe46e84e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iweyceJT2/gJ3MqUIIZWNsOrybVwq+WNfhfeDvtL5RrkywEi/Oetz863+xMd?=
 =?us-ascii?Q?Nj7uOwzlmrV3x21zrFcwg3gG9ahtwRSUM4ynHxNrEiMZh35OTMvkan1i5Tzq?=
 =?us-ascii?Q?05rp+F+Wr8rljD/CC6NWcMnNPBEdXBFIGCg/3xfEG70R67x2ibX9ajjEOdsX?=
 =?us-ascii?Q?xQH+2WQJn6fKlTP6dHPeVqPCgSm/8553iIEbHjRL07xP0vpZWx9Sr+wZMLBG?=
 =?us-ascii?Q?iT5yOAnVxIH/Zy6SDoB2XOild4kU/osE8qBmfNNO2voYU/A/ij+japvShLk6?=
 =?us-ascii?Q?9MZfs0j2gdGe+FzT1Eb9vKWRtWZoFeGW95RlIbEOYa1blyvZgc1rz4fRNQc7?=
 =?us-ascii?Q?2tnTXXfoz6h7h4b4+rRUjdr9UYqh+c3yI08/yVLwbNN1AehsaLBBfrUknNdc?=
 =?us-ascii?Q?W2vXgMtBPSWwgGGYBvakAQlWOg+OxxOZYQzE4t0bsS8lNE58mI45shwya3a5?=
 =?us-ascii?Q?/7h10Bb7lhiOiZXA0Tbwae4ewNExRGfgfAZLRQU7rBvJHSC6Xn+AoVYiaE+z?=
 =?us-ascii?Q?VDrHUtniHNYawmpPB1o4+Y5ESzjFU7nV5kxOS3HANt+G438PVcXwt/hYRKgB?=
 =?us-ascii?Q?a/DA07ouPIy5A2hw30KfddefjrVtr4wIQ9gwykDBsFH/vnF6lCUJv9U+jd6o?=
 =?us-ascii?Q?HUY9D2Vayx50mJCGboGk8hRnfXwCLQjpkjsAEmeF+8d4+5UVkGiv1A9uJ/2s?=
 =?us-ascii?Q?HlkYawfhZDedeclp22BveDBsvEq6FqmTcO+tx8P1WFtqwBmoS3q/vN6X17hl?=
 =?us-ascii?Q?etlObQX/4xr7Flc91ns9p4/SMZWuCgK4+ducfhZ8GP2k2xQBXrL700tzqzUG?=
 =?us-ascii?Q?6RBb3yIbzCQYHOfu44TFSj+wFhAYOyDmsDlFjDGOqiRnXAMNnq7dq20vhI8D?=
 =?us-ascii?Q?NK+6Ywfdg0IpxQEsDz03C/Fm2wQdhaeUcw9HbQOU50T9hb8Yww6SijSHDKc6?=
 =?us-ascii?Q?0dctlRMYDCGP4mZ9Axpdr9fO58nVkww9mbubK2DzfvZZ24lr2XvsZOumcNgT?=
 =?us-ascii?Q?FKCeCp8xuXfm7E+Cs2b2cGxjvM/JhlVz9JmZJRTfJPLEWZd5mxu1ruuZIlB1?=
 =?us-ascii?Q?bGRgPKBqhk85KhO6f2Zztw7oYDOZa5ww/JseV/OovRiKafQy26ps1yPcRI29?=
 =?us-ascii?Q?FbXEo3utaBuyQmVIQvFRcWb1kAlgPTuNML8m5xV/i2PSwvq6D7CYCZnwk+kZ?=
 =?us-ascii?Q?KVzBuNGXUd1+e4yxHD920/eiosNDg049N/7KZe8GX31Sv6v5T4AxhbNoKav0?=
 =?us-ascii?Q?pBeJOnjNjzi07MYMGMR8g0bUgiH6NTvfpQpSnmjSQFPyaDv944VNvvHH9Biy?=
 =?us-ascii?Q?NTjGNPQR1KQ1juA4/061z7CUK5TqIR8D/F9/35yq1ECpfdLXUcKSn3yJ2zOG?=
 =?us-ascii?Q?Wg1X4a0J3+e6N+dm2WBU+z317LiKksgTYWg68BYfzVBpchuwZVWcOIBa4UDv?=
 =?us-ascii?Q?vpQIHU59sA64+Z8SGheIX963vE0x5lJ6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 22:58:13.2781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec129fa-9a43-4d5a-178a-08dcbe46e84e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6207
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

In preparation for enabling IPS debug flags that require DM changes,
a common entry point for allowing DC idle optimisations is needed.

[How]

Create an alias in DM for dc_allow_idle_optimizations(). Change all
calls to it into dm_allow_idle_optimizations().

No functional changes are intended.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  6 ++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c   |  8 ++++----
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c    |  2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c    |  2 +-
 5 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a18ecf8607232..2efa9f6e23015 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -246,6 +246,14 @@ static void handle_hpd_rx_irq(void *param);
 static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
+
+void dm_allow_idle_optimizations_internal(struct dc *dc,
+					  bool allow,
+					  char const *caller_name)
+{
+	dc_allow_idle_optimizations_internal(dc, allow, caller_name);
+}
+
 /*
  * dm_vblank_get_counter
  *
@@ -296,7 +304,7 @@ static int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
 	}
 
 	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
-		dc_allow_idle_optimizations(dc, false);
+		dm_allow_idle_optimizations(dc, false);
 
 	/*
 	 * TODO rework base driver to use values directly.
@@ -2883,7 +2891,7 @@ static int dm_suspend(void *handle)
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
 
-		dc_allow_idle_optimizations(adev->dm.dc, false);
+		dm_allow_idle_optimizations(adev->dm.dc, false);
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
 
@@ -2911,7 +2919,7 @@ static int dm_suspend(void *handle)
 	hpd_rx_irq_work_suspend(dm);
 
 	if (adev->dm.dc->caps.ips_support)
-		dc_allow_idle_optimizations(adev->dm.dc, true);
+		dm_allow_idle_optimizations(adev->dm.dc, true);
 
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
@@ -9421,7 +9429,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 
 	/* Allow idle optimization when vblank count is 0 for display off */
 	if (dm->active_vblank_irq_count == 0)
-		dc_allow_idle_optimizations(dm->dc, true);
+		dm_allow_idle_optimizations(dm->dc, true);
 	mutex_unlock(&dm->dc_lock);
 
 	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 2d7755e2b6c32..3fc3c12b3a4a1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1007,4 +1007,10 @@ void *dm_allocate_gpu_mem(struct amdgpu_device *adev,
 
 bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 
+void dm_allow_idle_optimizations_internal(struct dc *dc,
+					  bool allow,
+					  char const *caller_name);
+#define dm_allow_idle_optimizations(dc, allow) \
+	dm_allow_idle_optimizations_internal(dc, allow, __func__)
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index a2cf2c066a76d..5b0d426ad50db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -203,7 +203,7 @@ static void amdgpu_dm_idle_worker(struct work_struct *work)
 			mutex_unlock(&idle_work->dm->dc_lock);
 			break;
 		}
-		dc_allow_idle_optimizations(idle_work->dm->dc, false);
+		dm_allow_idle_optimizations(idle_work->dm->dc, false);
 
 		mutex_unlock(&idle_work->dm->dc_lock);
 		fsleep(HPD_DETECTION_TIME_uS);
@@ -216,7 +216,7 @@ static void amdgpu_dm_idle_worker(struct work_struct *work)
 		}
 
 		if (idle_work->enable)
-			dc_allow_idle_optimizations(idle_work->dm->dc, true);
+			dm_allow_idle_optimizations(idle_work->dm->dc, true);
 		mutex_unlock(&idle_work->dm->dc_lock);
 	}
 	idle_work->dm->idle_workqueue->running = false;
@@ -253,7 +253,7 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 
 	if (dm->active_vblank_irq_count > 0) {
 		DRM_DEBUG_KMS("Allow idle optimizations (MALL): false\n");
-		dc_allow_idle_optimizations(dm->dc, false);
+		dm_allow_idle_optimizations(dm->dc, false);
 	}
 
 	/*
@@ -275,7 +275,7 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 
 	if (dm->active_vblank_irq_count == 0) {
 		DRM_DEBUG_KMS("Allow idle optimizations (MALL): true\n");
-		dc_allow_idle_optimizations(dm->dc, true);
+		dm_allow_idle_optimizations(dm->dc, true);
 	}
 
 	mutex_unlock(&dm->dc_lock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 3390f0d8420a0..48a4c493a70a0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -730,7 +730,7 @@ static inline int dm_irq_state(struct amdgpu_device *adev,
 	st = (state == AMDGPU_IRQ_STATE_ENABLE);
 
 	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
-		dc_allow_idle_optimizations(dc, false);
+		dm_allow_idle_optimizations(dc, false);
 
 	dc_interrupt_set(adev->dm.dc, irq_source, st);
 	return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index f40240aafe988..fdf1d4c7b9300 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -192,7 +192,7 @@ void amdgpu_dm_psr_enable(struct dc_stream_state *stream)
 	dc_link_set_psr_allow_active(link, &psr_enable, false, false, &power_opt);
 
 	if (link->ctx->dc->caps.ips_support)
-		dc_allow_idle_optimizations(link->ctx->dc, true);
+		dm_allow_idle_optimizations(link->ctx->dc, true);
 }
 
 /*
-- 
2.46.0

