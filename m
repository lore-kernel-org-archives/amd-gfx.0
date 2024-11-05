Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071A8D36137
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9FC410E60A;
	Tue,  5 Nov 2024 20:24:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NX49EYNR";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BCDD10E60A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enn3caarq4JNoD3+JKrnkO7Ips24VhDdA/7e450xce6Bq4o14NTdh2rUKTEAYuwe/OzTokH+YQjFviqVUKgX+6k4pCIiJREk8NsZ2Fy5SHn0tkpFirUkOwsUjWSFmUAe0hHorXw35mA0upY+FujP7xExR1v6yntPHtH4lTm4qBIfep+BiwCio26nGRnCm83b8VBiKSahv9jKKSpBrStg56L+HX85QrKEsuwMTRGtLcnOoEAh4ukfYdc/UnTUqlhasfTCJh90eieeDd8sZyeSY8th9hyQqmSdha1hbBaKQgYSuQoEGaBYbq3IxZyW8v6aFBCAoh09Emfj4mgBLtAVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ymTpMHV6OiETqIt2ghEiBNZOENB/DibpOrkbHVjMX+k=;
 b=kCywTqEi2xvfE9jRfth8wpXeJPwMyaws9nx131SBAQZIK02bY6fwUAvcb4YWxPO76SirWYa9bm6lOBgoiT7Pn4aCfBjbtb5BZIZdm/x0dA3fjhoElJLkDkGPtkb7NoNTMr1AhadFRIH23MNv9rRpdbUqqCedLNHLM+Wn5ZFfJGrhELP3I4u2tKUOzFTOZJog6mZm5Y281qf4XmehlJGJ3uauEdAKJNkzrSTSdyJAMOHlOy4n5ciq+DZOnKHxr6DFqoUJZ4EiK/GXGV2csl0nyQACmBJkkvpxtanSGo3AP4nPKtansfI4p/8kl2DpWs+UZrMe8PMS2WogV4L85sAWDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymTpMHV6OiETqIt2ghEiBNZOENB/DibpOrkbHVjMX+k=;
 b=NX49EYNRYBlWSkfXqwjx+vsXxXZaFctr6U+IsJ/UDWJTEnRiOxojyHbLAvTAOsUOEh7Q/HluBUkEcuga3F+CCvVr0ZOWposv8tFeaHV2rG5WHLW//xTSjaxFFxNh7z2DbBIuKU1Lvyzw8Ns3lKFXGfpVNlGHXbbZ7PmK6t3UBNI=
Received: from BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:15 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::c7) by BL0PR05CA0020.outlook.office365.com
 (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:15 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:11 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 03/16] drm/amd/display: Change some variable name of psr
Date: Tue, 5 Nov 2024 15:22:04 -0500
Message-ID: <20241105202341.154036-4-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 8705c676-9d3b-4370-7e06-08dcfdd7d177
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?P/S/z0jvAF8WGgCNLOQQSVqSHrxGHbMzwgrlWvQ3hqRRXp0KeQmNBt8zfCvQ?=
 =?us-ascii?Q?2oWL1Ex/pRlPB444QJcYpK07AOdCSsgFLni/dxcdHcV33OWe2+lobyxix40F?=
 =?us-ascii?Q?zveD/woAaElaOCW3eogPKvfVS5+QvXEKGbVdsO1UDu4hP/EJ2p6knNXb6Yv1?=
 =?us-ascii?Q?pxJjObggmFcN5lBM+FoIeWiYyZS+F2YIEc4RcLB2ub/53fkwx3rGgfRkpEH5?=
 =?us-ascii?Q?0u+yXRWdNdRXSnGZVM5WpRP6Kmb2851LRDxNsZXQIi88BZd3SiGtYqJwt6Dg?=
 =?us-ascii?Q?yNjIT40aBOOf5BbkdFPrOY1B+kALy8FT14cAP6YJoDfBe+ASyVPrAdjrVPih?=
 =?us-ascii?Q?XuEex7AXoSQQlUBTPzGjF/3Y8M7+VIV01KC1HTMfrBfGRl/fNynljRYFNRWr?=
 =?us-ascii?Q?YFSJUwYRF8wAQL9ZNWTUmoHnj6N8WcbZy23xfXWIWpHMfdllFHO8m63KF+Er?=
 =?us-ascii?Q?jmnmkBVUUqI6XTG1jbq2JETINEJPFXoN2TzIMcolmP8+guYYrpOxmgNy3BWI?=
 =?us-ascii?Q?6IhmtdXnTUWXNxt2jjK2bauCeXymLokAXqAwBRmhXR2RGLPCaxxEvnNT2WvG?=
 =?us-ascii?Q?1BFeRsQV9VzZ1Irg7Gi1hlXlxntWaAewKrAZ7dbaNLq9xfIm3RytweGqM34c?=
 =?us-ascii?Q?ZP0u3Pyu0aAvELlVvXq0qiwy1aaGAmDd0MgUZwuc3/ddgjS20GwQiT4TlGiZ?=
 =?us-ascii?Q?UUs9lR7KDitAQuP/j6O0sUc3EwOk2a8XrMKqIuR53mBz+Vj2J3oXlyB1mJ9+?=
 =?us-ascii?Q?2YqJZSUGgKnyQfel1/LJexVyzGcdjQT9NhTaBXuV1Hg+USpLn2vLZedMzhs/?=
 =?us-ascii?Q?I6gdNQBHIpyxSs+BTYTInY1uEx9uYkz/aZ9EvyxlNU+7OXoMdvTOZn9VakoV?=
 =?us-ascii?Q?GHs9J5vNQXRCYAsB5nchRn+CH5mSEt+e1Bs/Sug+AOmori/XhDyAGE6amSOx?=
 =?us-ascii?Q?ggv8LhrLGA+A/4sOvRfIDsgiX2ZKrBnCPatkZc9wKIDp5VgytiNL/teAxltK?=
 =?us-ascii?Q?zlxAGCoaeSHsowiEPJ9KX9p6DUvSf7HTaZrmWY8n/XdXEnLkEVs1Fc2zgGUs?=
 =?us-ascii?Q?S+RqNUOoYIMZiL51CEuIHpbwYPQmkrOBkxm7abITWoc/TgJ/D7d3HBTGITjH?=
 =?us-ascii?Q?a4ODlhzw62CIJ2k9shfQjeegb/eDaaSeT5XXHRvUj3xb7guZK99DoDXFNPI5?=
 =?us-ascii?Q?+RpwFn4N31fcTDyAC+BNah00bEynU8al5BfiUXARYMigjaE62OznPQoJ0TCZ?=
 =?us-ascii?Q?Opb1dG41CvqZvkiU7PwZKEMsGrRz5JBVGSvAZAODRhzABOgEJ+cSH1+J+254?=
 =?us-ascii?Q?PcFolRVehhTHGDSVv3zVB5usHyXrCrlocZIP5fqylafYNZMOE+QnqJFpB2ma?=
 =?us-ascii?Q?FmvgVAToPvaHfHoNt7Y1HVp7rKP1jPWvbod3fJcD2GuVgpXDSw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:15.1645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8705c676-9d3b-4370-7e06-08dcfdd7d177
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575
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

From: Tom Chung <chiahsuan.chung@amd.com>

Panel Replay feature may also use the same variable with PSR.
Change the variable name and make it not specify for PSR.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 +++++++++----------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |  2 +-
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7a1b5d5beeaf..570640c25b4b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6790,7 +6790,7 @@ create_stream_for_sink(struct drm_connector *connector,
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
-		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
+		aconnector->sr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
 	}
 finish:
@@ -9016,7 +9016,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			 * during the PSR-SU was disabled.
 			 */
 			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
-			    acrtc_attach->dm_irq_params.allow_psr_entry &&
+			    acrtc_attach->dm_irq_params.allow_sr_entry &&
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 			    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
 #endif
@@ -9251,27 +9251,27 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			}
 		}
 
-		/* Decrement skip count when PSR is enabled and we're doing fast updates. */
+		/* Decrement skip count when SR is enabled and we're doing fast updates. */
 		if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
 		    acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
 			struct amdgpu_dm_connector *aconn =
 				(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
 
-			if (aconn->psr_skip_count > 0)
-				aconn->psr_skip_count--;
+			if (aconn->sr_skip_count > 0)
+				aconn->sr_skip_count--;
 
-			/* Allow PSR when skip count is 0. */
-			acrtc_attach->dm_irq_params.allow_psr_entry = !aconn->psr_skip_count;
+			/* Allow SR when skip count is 0. */
+			acrtc_attach->dm_irq_params.allow_sr_entry = !aconn->sr_skip_count;
 
 			/*
-			 * If sink supports PSR SU, there is no need to rely on
-			 * a vblank event disable request to enable PSR. PSR SU
+			 * If sink supports PSR SU/Panel Replay, there is no need to rely on
+			 * a vblank event disable request to enable PSR/RP. PSR SU/RP
 			 * can be enabled immediately once OS demonstrates an
 			 * adequate number of fast atomic commits to notify KMD
 			 * of update events. See `vblank_control_worker()`.
 			 */
 			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
-			    acrtc_attach->dm_irq_params.allow_psr_entry &&
+			    acrtc_attach->dm_irq_params.allow_sr_entry &&
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 			    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
 #endif
@@ -9282,7 +9282,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			    500000000)
 				amdgpu_dm_psr_enable(acrtc_state->stream);
 		} else {
-			acrtc_attach->dm_irq_params.allow_psr_entry = false;
+			acrtc_attach->dm_irq_params.allow_sr_entry = false;
 		}
 
 		mutex_unlock(&dm->dc_lock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 25e95775c45c..6464a8378387 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -727,7 +727,7 @@ struct amdgpu_dm_connector {
 	/* Cached display modes */
 	struct drm_display_mode freesync_vid_base;
 
-	int psr_skip_count;
+	int sr_skip_count;
 	bool disallow_edp_enter_psr;
 
 	/* Record progress status of mst*/
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 8b5bea799a24..31441f0ec4b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -268,7 +268,7 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	if (vblank_work->stream && vblank_work->stream->link) {
 		amdgpu_dm_crtc_set_panel_sr_feature(
 			vblank_work, vblank_work->enable,
-			vblank_work->acrtc->dm_irq_params.allow_psr_entry ||
+			vblank_work->acrtc->dm_irq_params.allow_sr_entry ||
 			vblank_work->stream->link->replay_settings.replay_feature_enabled);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
index 5c9303241aeb..6a7ecc1e4602 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq_params.h
@@ -33,7 +33,7 @@ struct dm_irq_params {
 	struct mod_vrr_params vrr_params;
 	struct dc_stream_state *stream;
 	int active_planes;
-	bool allow_psr_entry;
+	bool allow_sr_entry;
 	struct mod_freesync_config freesync_config;
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.46.1

