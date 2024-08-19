Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F823C52D7C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 19:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D855E10E33B;
	Mon, 19 Aug 2024 19:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="feGAHZT9";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CCAF10E33B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 19:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qhwR0f4XW7vTXY8XVin63TGb+Z0nUwadlI5GuG8BUVnt2r9ZVVXHSMkXOn706aymFj3teUW/xGJjkIruBRcD6WMFUtzqYpqFUl/goFmNFossxq1H147PPpDXqk02qzQAdLlTKJ5mZDRIeRg4GRR9Ili4FUnyyjkMunKk3s9A8oGCJworrA7L7cUgKUyNz/VkVJoVWpWBACX0fT/k9XpM1jPiiXd+j8R/+U7OfMWix+uzcl9UwSjKtqrAs21QhFaqbFIZyt+Wsj1huBUypXHy2LzSIvfKbmkf7RgB6NgYGIb4Y2sNien4LQrZTyObYgmGmPvTP/0mIikN8eLfevkTYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnXvuGJgLjBPwV/dDcVApssrCxodhZG2pjuP+5LNNIc=;
 b=OmreX5OHfF9A+xF9U74fINzoc6uwrWfTgKpnkH/QvOxTTslXsMhVmP9d4df/gi7Qd9cwmUhxtNT1gwndjD1UzHRqz1Te6qp8h+JlFK+KbIMlAeHT3ym0jAFtjB1FH+0RfER7g1PyV8lFz6+mv0r3DD/9RxtOGISRT0pe6oeqsPezc9X+YsAFGYueX5LpZTJjncgfYw+BB0YpQnlmU93NwIXf2laVSw2+zAfx9scoHKd/50DkMWptdL7N+BPgHmDubW+pHnpvjP7NrfLFNAsGt0Fl6Ur1VFbPdM9HPRTEojBYpixcXL2FsJX2RwnBKbPijVVYGJKR/0vCDHP5ePYWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17)
 smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=temperror action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnXvuGJgLjBPwV/dDcVApssrCxodhZG2pjuP+5LNNIc=;
 b=feGAHZT9qaQe/KRELhfGsVG13CCSR7qu1O0dFlMWpaQqgsB/Vf2CPelS/Ut+gaOEkjN1LfHKFbTwZuzSlr4HciPv4Rre98MDHZIUi9S0Jm7TLkKbZD3Uo7Ybhqti0Xya37KgdMprWE7x8OFFEcmy4cc11gmrzjifmf50gm8vMK8=
Received: from MW4PR03CA0164.namprd03.prod.outlook.com (2603:10b6:303:8d::19)
 by DS7PR12MB8370.namprd12.prod.outlook.com (2603:10b6:8:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:23:04 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::30) by MW4PR03CA0164.outlook.office365.com
 (2603:10b6:303:8d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19 via Frontend
 Transport; Mon, 19 Aug 2024 19:23:04 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 19:23:02 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 14:22:55 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <chiahsuan.chung@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 2/5] drm/amd/display: Go through dm for
 allow_idle_optimizations
Date: Mon, 19 Aug 2024 15:22:14 -0400
Message-ID: <20240819192217.18799-2-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819192217.18799-1-sunpeng.li@amd.com>
References: <20240819192217.18799-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|DS7PR12MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a8fc60-2706-47b0-cdad-08dcc08457f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xvnmdmK0JTcw3pYQII8s8TikGTjMjHGC8fxrY/4ikgTl4cbXas5XmJuJxouV?=
 =?us-ascii?Q?tTWIKampdgM45FuOZnZCXfsLi7gx/06sWWIt3Op0j4QdzEWGsnB36O5AB84z?=
 =?us-ascii?Q?+AVluMqlinZmvz6wQZBgtShtloT1QW7WiMEk2xgHC04VSBDgLiJ4RZrygSd6?=
 =?us-ascii?Q?+mqorkjjop0t/iaaQhXV6zfOmA+7/Bj7EPWwSnMS0s7uDyyB0Mu/NuRuF1rz?=
 =?us-ascii?Q?oLM5pjmwCGI3ySARNapGCS7W5fpOyeNt2JmwZbdtK0mQHiXDGWTGRhgN33eT?=
 =?us-ascii?Q?SIggE+rd/ng/HR7T80ZuHu2rU+iiOkrxwtIPk1AeJRBSCxBz+83HR6hkPCUz?=
 =?us-ascii?Q?EX7FlceUiTiGA57fBcZ95PKTzY07KIaGhQsbSZzWaOzZPVdWZhWp/WEZyxZg?=
 =?us-ascii?Q?7I02GqvhWFAv08NQUjg8yjkC+2ZOA9JphXlZI9JARHH9L1X2H4O1Ie9NaJGk?=
 =?us-ascii?Q?MzB5+IBLxPdvu88Qx8PgaDGMBFtkNUaKP1vYUm3AODs0fjUA7cZsxFAmks9a?=
 =?us-ascii?Q?obQXlISnVhCTz1LrcLboNK2bN7BaQhtTld8oUr5/6U6tCFU9W10YTdy/2Sq/?=
 =?us-ascii?Q?b2S2xEmevh9OuuvHadt+wuO8Wb2lve0W3mcyGgeSYzkNPi+nvJwkxz06ibg2?=
 =?us-ascii?Q?g3vGE8Eichvp8+eTWXTDSI8zLsuN7vrtiHor6Fs9SWVlMbnVDuHDLots0HmH?=
 =?us-ascii?Q?pn45j0d5WfbD3MdVyxdh8j7r3AXWPRVb5albT5ahjmncsi7HeRzGQFzTiT0t?=
 =?us-ascii?Q?8cxKLczahS3NPp7j+n8TzE6c8ma3OI1Qo5jxM7BiMY7HPWA4LSG1yPAomqas?=
 =?us-ascii?Q?yykTdAINEdKLsDWy3t174fFdsNZ69DKs5DM2wkZWAzPWpXzukTEFf/HIR+6F?=
 =?us-ascii?Q?U/lG6swLStNHMMdZzIR8EEfsHCrQdJ0j6cBFv+psqog6wrYKLac5gb76uCu/?=
 =?us-ascii?Q?EENESj4/dH55OGDjLth0xapJQmoXivPTGuFfsb4/uats9KZ1vomtBJAZNmkA?=
 =?us-ascii?Q?bf7nnVKXgeZue48QIWdEkfQdyz5Xc4Seu7tHO6K9irbEApn22UQQB32BqL+2?=
 =?us-ascii?Q?1vZ21ThObC5M4QoCBYzBerycuZz7olS7ttKu3Qf/ko2jGBv+JZs1Wqnu7k99?=
 =?us-ascii?Q?RS8OCpxhCj1JmpGVe0k9vosx4cjXhwK4PIIODk+VWCdiBwZl5+B36TnISqe3?=
 =?us-ascii?Q?ZG2MkMyrZJkUIXoxT4qLXZ2AaTuhanctVfV/UqXD8WMzB1SrGtQWMVV2tx3q?=
 =?us-ascii?Q?2HsOtdx2C1wd5BjtJi4AybMcXCCZoNNGLGYxqr/EC0SiUK6b+KdXMEhav/7D?=
 =?us-ascii?Q?zUhUgTN/R9ePba2xo4oyIFO8TNe1LFsLHq1lWsW99TBvYZq4bZrl7AW3IBh+?=
 =?us-ascii?Q?neAljQJsYcACcFfiATbG6iX61vtAl10Aj96oOsP2pkwAByVLCn4dp/vL2H7E?=
 =?us-ascii?Q?BaxNwqh1IJ5HiRgicQ4AAHQEshgzv/O2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:23:02.2501 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a8fc60-2706-47b0-cdad-08dcc08457f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8370
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

