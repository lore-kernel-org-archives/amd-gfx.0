Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2B5D36137
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 512AD10E60C;
	Tue,  5 Nov 2024 20:24:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lLa860Fu";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D66D310E424
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+C+5OGommo5cczJrz2y5dXz9woDaCYO9Ar0TCktKiO5Tlz9yAEvOQ+gGHAoUktegv2IiCDpb0mXM2enMbLteK/9TjE+f0N8sdnmFovnY0W3LTG98WzYKKbNvBy51Cz/VCh61fc6hVa70Yg3t/GjkRTOuClT5vCoFGwuwwawsqf1mNNwe9MNlvXJjA8+D5+ZC87nKA6ynTG9G9qtQMHNCV8x5dj5lKZIkF4VQSZdI2WTweq8RQ5ICrApqtIQgwXQ1qa4iCtfI1++tiR9DaR8xmvu+Jx9IUbQhtxYjz2bryb+ttYeuUfsiDVrBKiOJnGI6dv1F0P8BFwJCfswSXutYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL3w5yvkN40CtkTxfbS2IKoYVFgTf1e2XCG3og3Wc8k=;
 b=bXGZu++Ex6FGSL9qJpgFfTzAn1orhdTSC/fl13/IgSBqEgbUHyhjHGgMcDhqN9sKsbimwyjuXND2CRXAzz/OD/5xOLvW0MHFykKH1H3r4/NPpNCznzKiEfvxPGUGJRttZW/lO25YfQgtjHZCkrHS85ME7cESS8DYVpDZjf4WT5BSGNB2UmfbonPxtS5Jg0XpHRaM7lqGiDPDNcAJ6M0siecBMft1SDksUml0fZ30e0lDxgybu7Tg+Xvws+letL2fEAVcoYhKLwHXG56aZtEhNayZJ6hWEbERblmvXCmbBnCgNDT07OoUgXZlKbifU+Oc4/tHfzWqc3/mtoxZcIqenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL3w5yvkN40CtkTxfbS2IKoYVFgTf1e2XCG3og3Wc8k=;
 b=lLa860FuHDy/S18DtKzNLOFzUIlK99vYooBChtIyCjA6RN95CH6aDQKdV7LxZciv3VrP95mig4gOwpKT/ryguj4rldYDLszPMJ0X/4fz1/mX8IOzz2q4MeRIy98mzn2ZH73c9WVq5aOY1/3alGvbpHdM9byAs201Rbbi+m1VEjs=
Received: from BN9PR03CA0277.namprd03.prod.outlook.com (2603:10b6:408:f5::12)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:22 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::33) by BN9PR03CA0277.outlook.office365.com
 (2603:10b6:408:f5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:22 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:14 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Fix Panel Replay not update screen
 correctly
Date: Tue, 5 Nov 2024 15:22:05 -0500
Message-ID: <20241105202341.154036-5-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: d35f7a79-74b4-4fa1-15fd-08dcfdd7d59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iHf9HV1qHnE6gmZPjZ/4Zlq7TwPXsEPVkOBA877627r5QZKoR8b/U0oke+wK?=
 =?us-ascii?Q?nX7YahZUB4gxbd/RCI0O7FRNOyVs905J88anE0lJVd8thR9CLFR4tsNGU3A3?=
 =?us-ascii?Q?qOLIOWO+ZKrwGwJWsQSoOTERZNvuBulfsjzfOMvZJQFKk52KCHj7d696yBnY?=
 =?us-ascii?Q?BW4KHAI0ApOwgKte310a4tSi57U+hpa7+Q05yDGRcMbCRk2uF2G+TXz9MO2g?=
 =?us-ascii?Q?cwvf88ntDiuNMY/tEwLvrnmb1/Bp35gK9Jaz7ju9ZN0GEENWHZ1g//ZlD0n3?=
 =?us-ascii?Q?+Z185e0ttrpfW65+MQbuc8iMw6CBoW6oNLu09yayZgVFSX5DkyyZVYmEJsjp?=
 =?us-ascii?Q?Ngd9cfifpwOTPN2Zt3jEtueSOJkIPbi5m3GakuisVNrsfyKLsQkoNVmtZMQs?=
 =?us-ascii?Q?oV0RsGH/vtwWQnHa1nsrDTEirm7ZCVunjVLVWaFJwppBbR5fe30tYGS9Fqeu?=
 =?us-ascii?Q?8b1t2hVtZg7lV6nQ8lGC5Y1XLYJsMyE974s5ppA2bOGtBJvRq9bCfKOyHNj8?=
 =?us-ascii?Q?+PhsBDDWQ5Knlm6/UN8P/20IVCL2L02+rKYeyxCorBOya21CCXKXS+qCWmqb?=
 =?us-ascii?Q?Utip/1oaSbEG1+2MnG1nm/XYr/mM0IdwoS+IzCq2kxsNwyf6JRMemGcoUi06?=
 =?us-ascii?Q?iQoLOZtsTZk3+2XZrXJN1qOJr7ONhrtFlZ0SWpD0ueXX1b1B9yRnuAZfMBpc?=
 =?us-ascii?Q?7PSESIGZy51vk1jNKskWJnbdDTf35xPu9yvl3LpPg6DujAqOqkLEmHiyaygM?=
 =?us-ascii?Q?mvnsv1UuXdka7LZ6RW9muKT5I0JSdKdvZRdvckCZr2UPQjwncIkRC8SBKrtm?=
 =?us-ascii?Q?MqBYmBg+08RFvcarVmx2dRBDliCqu7eXhIVlzi9V7y17ZJ/1VINyEbqv9FAM?=
 =?us-ascii?Q?RG5ZYw4J11vHqOQrSPKQ/UFQIZkMRMoveUVVz5QiVAqm79fCnv2ty+494tOQ?=
 =?us-ascii?Q?NB4ldA+qM51tEFTKQZhveHo3L3krosRZm6827Wfrj6dTXHlZpW5bhyoJi3gQ?=
 =?us-ascii?Q?2XrtD7UCHF3YGAkslt/7WVvJeUyLMimbCUCofHWNa0xcmtcWuvVhk5Yb9Bkg?=
 =?us-ascii?Q?A454Jrn237+abdGvSTW+Zy+odVb4v2KZttmqqQ/aN2PK2B7oiqy2ZfqtagUY?=
 =?us-ascii?Q?KA+7CnqiI8zFKrdKK9OuRfLohCTUzeu+9Yi6djQOrglQ9xDUQwnmQ5ay0MhE?=
 =?us-ascii?Q?o3GkeoNG6dIoFTEl/j3pRQddxo1TL2ROZcgZgNnEUlps9TbOtqmmg85+9kad?=
 =?us-ascii?Q?fOSgGreyrpSx8jic1Hd8WYGxjLg7ROzoNxjOaRFg/AGEZGENZd7VjveNJ5t7?=
 =?us-ascii?Q?BtIuz0ihU3GYs7rfpHYux8X+JI9hWT+ahetCqVqjlU9jCrjP/H+FaoZR+5bw?=
 =?us-ascii?Q?xP16O8qXQcH7h1fb5RBl04Bo3OsDSgZqnZwS/NKp/uHTSNrWAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:22.1752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d35f7a79-74b4-4fa1-15fd-08dcfdd7d59e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112
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

[Why]
In certain use case such as KDE login screen, there will be no atomic
commit while do the frame update.
If the Panel Replay enabled, it will cause the screen not updated and
looks like system hang.

[How]
Delay few atomic commits before enabled the Panel Replay just like PSR.

Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 111 +++++++++---------
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   5 +-
 2 files changed, 59 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 570640c25b4b..fdc1d2d1afd9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8863,6 +8863,56 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 	}
 }
 
+static void amdgpu_dm_enable_self_refresh(struct amdgpu_crtc *acrtc_attach,
+					  const struct dm_crtc_state *acrtc_state,
+					  const u64 current_ts)
+{
+	struct psr_settings *psr = &acrtc_state->stream->link->psr_settings;
+	struct replay_settings *pr = &acrtc_state->stream->link->replay_settings;
+	struct amdgpu_dm_connector *aconn =
+		(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
+
+	if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+		if (pr->config.replay_supported && !pr->replay_feature_enabled)
+			amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
+		else if (psr->psr_version != DC_PSR_VERSION_UNSUPPORTED &&
+			     !psr->psr_feature_enabled)
+			if (!aconn->disallow_edp_enter_psr)
+				amdgpu_dm_link_setup_psr(acrtc_state->stream);
+	}
+
+	/* Decrement skip count when SR is enabled and we're doing fast updates. */
+	if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
+	    (psr->psr_feature_enabled || pr->config.replay_supported)) {
+		if (aconn->sr_skip_count > 0)
+			aconn->sr_skip_count--;
+
+		/* Allow SR when skip count is 0. */
+		acrtc_attach->dm_irq_params.allow_sr_entry = !aconn->sr_skip_count;
+
+		/*
+		 * If sink supports PSR SU/Panel Replay, there is no need to rely on
+		 * a vblank event disable request to enable PSR/RP. PSR SU/RP
+		 * can be enabled immediately once OS demonstrates an
+		 * adequate number of fast atomic commits to notify KMD
+		 * of update events. See `vblank_control_worker()`.
+		 */
+		if (acrtc_attach->dm_irq_params.allow_sr_entry &&
+#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
+		    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
+#endif
+		    (current_ts - psr->psr_dirty_rects_change_timestamp_ns) > 500000000) {
+			if (pr->replay_feature_enabled && !pr->replay_allow_active)
+				amdgpu_dm_replay_enable(acrtc_state->stream, true);
+			if (psr->psr_version >= DC_PSR_VERSION_SU_1 &&
+			    !psr->psr_allow_active && !aconn->disallow_edp_enter_psr)
+				amdgpu_dm_psr_enable(acrtc_state->stream);
+		}
+	} else {
+		acrtc_attach->dm_irq_params.allow_sr_entry = false;
+	}
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -9191,9 +9241,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
 		mutex_lock(&dm->dc_lock);
-		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_settings.psr_allow_active)
-			amdgpu_dm_psr_disable(acrtc_state->stream);
+		if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
+			if (acrtc_state->stream->link->replay_settings.replay_allow_active)
+				amdgpu_dm_replay_disable(acrtc_state->stream);
+			if (acrtc_state->stream->link->psr_settings.psr_allow_active)
+				amdgpu_dm_psr_disable(acrtc_state->stream);
+		}
 		mutex_unlock(&dm->dc_lock);
 
 		/*
@@ -9234,57 +9287,7 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			dm_update_pflip_irq_state(drm_to_adev(dev),
 						  acrtc_attach);
 
-		if (acrtc_state->update_type > UPDATE_TYPE_FAST) {
-			if (acrtc_state->stream->link->replay_settings.config.replay_supported &&
-					!acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
-				struct amdgpu_dm_connector *aconn =
-					(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
-				amdgpu_dm_link_setup_replay(acrtc_state->stream->link, aconn);
-			} else if (acrtc_state->stream->link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED &&
-					!acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
-
-				struct amdgpu_dm_connector *aconn = (struct amdgpu_dm_connector *)
-					acrtc_state->stream->dm_stream_context;
-
-				if (!aconn->disallow_edp_enter_psr)
-					amdgpu_dm_link_setup_psr(acrtc_state->stream);
-			}
-		}
-
-		/* Decrement skip count when SR is enabled and we're doing fast updates. */
-		if (acrtc_state->update_type == UPDATE_TYPE_FAST &&
-		    acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
-			struct amdgpu_dm_connector *aconn =
-				(struct amdgpu_dm_connector *)acrtc_state->stream->dm_stream_context;
-
-			if (aconn->sr_skip_count > 0)
-				aconn->sr_skip_count--;
-
-			/* Allow SR when skip count is 0. */
-			acrtc_attach->dm_irq_params.allow_sr_entry = !aconn->sr_skip_count;
-
-			/*
-			 * If sink supports PSR SU/Panel Replay, there is no need to rely on
-			 * a vblank event disable request to enable PSR/RP. PSR SU/RP
-			 * can be enabled immediately once OS demonstrates an
-			 * adequate number of fast atomic commits to notify KMD
-			 * of update events. See `vblank_control_worker()`.
-			 */
-			if (acrtc_state->stream->link->psr_settings.psr_version >= DC_PSR_VERSION_SU_1 &&
-			    acrtc_attach->dm_irq_params.allow_sr_entry &&
-#ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
-			    !amdgpu_dm_crc_window_is_activated(acrtc_state->base.crtc) &&
-#endif
-			    !acrtc_state->stream->link->psr_settings.psr_allow_active &&
-			    !aconn->disallow_edp_enter_psr &&
-			    (timestamp_ns -
-			    acrtc_state->stream->link->psr_settings.psr_dirty_rects_change_timestamp_ns) >
-			    500000000)
-				amdgpu_dm_psr_enable(acrtc_state->stream);
-		} else {
-			acrtc_attach->dm_irq_params.allow_sr_entry = false;
-		}
-
+		amdgpu_dm_enable_self_refresh(acrtc_attach, acrtc_state, timestamp_ns);
 		mutex_unlock(&dm->dc_lock);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 31441f0ec4b0..64a041c2af05 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -265,11 +265,10 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	 * where the SU region is the full hactive*vactive region. See
 	 * fill_dc_dirty_rects().
 	 */
-	if (vblank_work->stream && vblank_work->stream->link) {
+	if (vblank_work->stream && vblank_work->stream->link && vblank_work->acrtc) {
 		amdgpu_dm_crtc_set_panel_sr_feature(
 			vblank_work, vblank_work->enable,
-			vblank_work->acrtc->dm_irq_params.allow_sr_entry ||
-			vblank_work->stream->link->replay_settings.replay_feature_enabled);
+			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
 	if (dm->active_vblank_irq_count == 0)
-- 
2.46.1

