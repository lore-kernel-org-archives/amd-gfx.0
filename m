Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4541FCC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A3E10F718;
	Tue, 13 Oct 2026 11:17:42 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E1E410F718
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tYmvtBYXAvqw7gAz/2AyyqXown7qjF+XammkSjXe/cfwnitqwHjFzBsAZFrAKgqMQDqG+fkboDvR/tDjdGw5UCI6/jX1fcWHu6vChh8j6Ka5qniBE/vAVjSfo2JuYNKqpmnkwjCUMVDvzxk+4WdwISntLdE/lnGngw6RLuQlEwlNeY/iImIrXyg9z1+eIPZ4VE6w5zMGiINX027HYG5jHEvp+OPU05Z1OuHKe6H3WpSNxwWeyJP8docEwAN2+b9F1NNApuopVUpWuRfUTBoTgoOeEn8JhySMizDQTp3YQgxtJSoo3aCxLEdsuT+jKZzZyZE0i7wE0Dz/nlUB3vFiHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWpL9ZmhZnVlPdrhvYLSMU7oOzl9W8x0XFTSEl1y3Do=;
 b=dDl3HxvrATKa36xWzX9fjTll51K/V14NwloajSoVFRWDJ5M4A5tMwpSQaFowcQi1q+uy6wfodQBjgm/2lMNn34KJ7FpdDC9peQVBC+FsPGmmba7s5k3Am4eM1L5gQ5JpQ53ZuaIxx9g24dP/ONpXHVcNHG2pzuUcVzLS7joVRZIM45wdNQiVz2KhMjHTwULju8R5bh4j41ovU+8TJjX6oK/3aJBK49p+7BB/CysjYYR+ETsE97imx91r9urKgqV6iLr2l5ViOIeTZy+MGSr2U7+wYfSnSdQJ0/WtsUAaOgleRmxSokz6VPJH9guWf1AgGTPOblxtSRUZEje+kxM8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWpL9ZmhZnVlPdrhvYLSMU7oOzl9W8x0XFTSEl1y3Do=;
 b=q0bU+9K3XtB/yb2saevuPd57pdeCBgJEVtFT5KHnS6i2eJkRDYqbUepN3TWybOabbdT4qGtrYAFSQp8K+uVUfCM6GrsSGfGCxil8yoNnhlFd6bPZ/7ULPWlrF/wqXI65whqzyV708fEF5dtb/0o6ZBcP/CRP05vfZWBFIUc9dy8=
Received: from DS7PR03CA0218.namprd03.prod.outlook.com (2603:10b6:5:3ba::13)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:17:27 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::3b) by DS7PR03CA0218.outlook.office365.com
 (2603:10b6:5:3ba::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:17:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C3.mail.protection.outlook.com (10.167.23.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:17:27 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:20 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:17:12 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 10/30] drm/amd/display: Log PSR and Replay status after mode
 change
Date: Tue, 13 Oct 2026 19:07:57 +0800
Message-ID: <20261013111616.2267344-11-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 88bb95ba-1c72-4f88-849d-08df291b9067
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|261009223027099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: jKnzCpYu+gsFn790NBBXaWZDkMcpT9JwZlHLH3+PnAamoet+2peHBgsjtAsRCYyre+qhlYGt7pvyRZE1oS1pXEx8+PpJCvgcBXlx3GDiEAue2k7ZXlEe/qVEOdzL8ovhMZQNC8+yhInMq6sdcRyePCxdARBOwXmi8A0abcGiSh7LeSDQ/0WArKduGVc6DQaNjJ9Md/ZR8wpoDXgA0o9yRKwody+Nmm5iU9y2VU/RgbsktEsW+4Ze8MM/yoKhB8Bo/04bhp7+ASVG2gNBzIU/wrHm2yHUBurV/cXsaQZA0cNYBtb+i/eqEZ9FDw32dP28a5EhNfm1w79xt8q/SDxZFPVK6m+xKF5HBzGfaO31bloxtUl6kzY7QK0Md9P6jJWbuqFrlkZXz1DafGDcOQ1Cet6X0rWUjuCAsc3ftzNq8+VSzpkYYujCvqcpPcMluNhVokrF18tiqGzb4XzVhkJhxu07ATTUEFONylrYv2cZEVUdPWKxBKDRdvtLCuLRmj+cXks6ex4q3n+29WBPkZlLyu3QS+VmrxHN0TynVpftwqvyg2ngzc2a+7ZKWzKULgs1Pt1bYrjhD55xs7oKK4B/A+E/vRgv8QYKzt/8FY/7+CqQJsz4EWznIR1JzFpk5PeWjE9Al8iJbDjGZsExL1hSdYa+47cceYPilcFv9203eEmieI2jZuAZMnpIJBdzoxYvm4PTCbM5TK3VPlseMeAhag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(261009223027099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D/wWiuhLcHYKy8gp2/n1ivrtxt1+Az0F7JuVIbq0ZR7pCSB6QuVTbvMs5jNXs4E8vDohXiHpqeiBdjd451D1lgBdv3RLQ4TpRk326bMK1+x9btHkAwOru2y1JOdCEvMJcXqKeYICNsTSnqDu3NT9c3qZsuObYPWJPBt/fY5yDDKbhVDN8JIN+3diceneB5+Pcuzs2MVtjNL4r8egnt80gWZhVIH1E63Xa/KPPmCbEynucnHqR5NWWRiN9t9UUlTjW25BUm73B6IQQR3wAEnbrV5N8fUn8NYAEooF/vVxZFeL08VhArStt7cJVi6dEnxA3LhT+9IQMep4QWysiQTNTIfE3Ezo4kvnQibxiBbSqrxedl8I5YoeLadAh3TShdihzOQ1g+xk8OW+2Lk3x3ZCx52fzwKjq0Cx/qb52M4cZm+Ff9lWdPJITuoghjZ7AWnG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:17:27.2666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88bb95ba-1c72-4f88-849d-08df291b9067
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
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

[Why & How]
The PSR status log was emitted during hardware initialization, before the
power module completed PSR setup. This could report a stale PSR status.
Move the PSR log after mod_power_notify_mode_change() and add Replay status
logging at the same point.

Assisted-by: Cursor:GPT-5.6-Luna
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 ++++++++++++++-----
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c4fee73a02f9..3e3b0abcfff3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2616,13 +2616,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 				if (psr_feature_enabled) {
 					amdgpu_dm_set_psr_caps(link, aconnector);
-					drm_info(adev_to_drm(adev), "%s: PSR support %d, DC PSR ver %d, sink PSR ver %d DPCD caps 0x%x su_y_granularity %d\n",
-						 aconnector->base.name,
-						 link->psr_settings.psr_feature_enabled,
-						 link->psr_settings.psr_version,
-						 link->dpcd_caps.psr_info.psr_version,
-						 link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
-						 link->dpcd_caps.psr_info.psr2_su_y_granularity_cap);
 				}
 			}
 		}
@@ -4547,12 +4540,36 @@ STATIC_IFN_KUNIT void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_commit
 			continue;
 
 		if (new_crtc_state->active) {
+			struct amdgpu_dm_connector *aconnector =
+				(struct amdgpu_dm_connector *)
+				dm_new_crtc_state->stream->dm_stream_context;
+			struct dc_link *link = dm_new_crtc_state->stream->link;
+
 			amdgpu_dm_link_setup_replay(dm_new_crtc_state->stream,
 					&acrtc->dm_irq_params.vrr_params);
 			mod_power_notify_mode_change(dm->power_module,
 						dm_new_crtc_state->stream,
 						false);
 
+			if (link->replay_settings.config.replay_cap_support) {
+				drm_info(state->dev,
+					"%s: Replay enabled %d, Allow active %d, Config ver %d\n",
+					aconnector->base.name,
+					link->replay_settings.replay_feature_enabled,
+					link->replay_settings.replay_allow_active,
+					link->replay_settings.config.replay_version);
+			}
+			if (link->psr_settings.psr_version != DC_PSR_VERSION_UNSUPPORTED) {
+				drm_info(state->dev,
+					"%s: PSR support %d, DC PSR ver %d, Sink PSR ver %d, DPCD caps 0x%x, su_y_granularity %d\n",
+					aconnector->base.name,
+					link->psr_settings.psr_feature_enabled,
+					link->psr_settings.psr_version,
+					link->dpcd_caps.psr_info.psr_version,
+					link->dpcd_caps.psr_info.psr_dpcd_caps.raw,
+					link->dpcd_caps.psr_info.psr2_su_y_granularity_cap);
+			}
+
 			/*
 			 * Block PSR / Replay on the new stream until display settles post-modeset.
 			 * These events will be cleared by amdgpu_dm_enable_self_refresh() once
-- 
2.43.0

