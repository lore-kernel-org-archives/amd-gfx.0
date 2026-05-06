Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DECCD342C
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 07:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6F0410ECD5;
	Wed,  6 May 2026 07:03:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S+acRDAN";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87E4710ECD5
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 07:03:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1QJzj0P9dOqzWWfqjgqi28q98DgEWIhozJScJRUxSfMCJsgiJyI/kBKIuqAOJG5RhoN5Jjgev+zSbm9V5foiIDP5XClsdXGE8DXm9ufFj/8J7q/cgDiomgEMGWo2oNQ1HNw99FE1Y49b7yPIfyOV6T4ApX7/9UuwYOm0yLzw9z3xzRew7l1zd+a3o7/21j2wwvajt6KVaUe+UzbO063qjC3UpfaAHgQyvO7/Jzcti0PjfraMsomMe55Qy5zjoCBGf85Fmm0+iHDbZBhlQ/GYw5I0XtEvVAePyGyTD87devT7M6QWAuZyd7mo5XGfBAdQ37Tq0choly/54r3xe7AKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YP0Hj39ZRzNl8EQR74+vFiJAWAvnQno6InRnC8P+SwQ=;
 b=Q5Bprfla2PAQKofT5QPLSh7fkh6IByvV3ZnhPnDIWc7tES5vxScLpV11KNDPsuhaCLowVvvqgWIsOvkNzwj2NhxNwstD4LnKlCZbUMaeXREZiE1hyZye+0BC0equG6LMN7rPQnoNRk/C5TJpCcoFo5A17n88zn5wn7Eb+L1fCT4xmQRhvS0Xumwu4l785rpkyUu+5biSLuKSUIaR5e8IqkX8TKCTLMBaQRx75lKmFUxgs2kYuXRLxWoQg9f4b9kfTOFwidNa1QcZzi+6cZJxwcsZwLWzlz5gfNM1GhwaiNf/ks6C32N6z9DzE2V13Vt4+IxxD/VixMwVWKIL91JFCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YP0Hj39ZRzNl8EQR74+vFiJAWAvnQno6InRnC8P+SwQ=;
 b=S+acRDANGLTk2jJNv7kDo1HRGZ1PkvVr3SOdnr0e3LamqF1F/iWz/qAs9RWf1PghRtV8J1A+8y4YBA8DoQK0Cyw1Aj4jfJJC6lcB9rK39Pb22arb/WQqJFTr3fTdn3Y4rYSp8yC+wvSewOxiqSYJPMoFJr/5Ar9WNeGXM5vbU/0=
Received: from CYXPR02CA0034.namprd02.prod.outlook.com (2603:10b6:930:cc::22)
 by DS3PR12MB999241.namprd12.prod.outlook.com (2603:10b6:8:38e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 07:03:15 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::2b) by CYXPR02CA0034.outlook.office365.com
 (2603:10b6:930:cc::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.15 via Frontend Transport; Wed,
 6 May 2026 07:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Wed, 6 May 2026 07:03:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 6 May
 2026 02:03:11 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Wed, 6 May 2026 02:02:57 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 02/20] drm/amd/display: Fix white screen on boot with OLED
 panel
Date: Wed, 6 May 2026 12:31:00 +0800
Message-ID: <20260506043342.2164710-3-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|DS3PR12MB999241:EE_
X-MS-Office365-Filtering-Correlation-Id: c752c57c-d802-43eb-88a3-08deab3d8b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: JVNtDut+748MqKR1h3141sQQZurNO9UtTuUlHF04j5yW0OMpF9Pt47qdpNew51qfAkx0uN8zTRWZWXBzfP0nGOALkkIjVHikeubtbLQhZA0N1JfgBo5jWlHZpqNkoXYQ0gKfhGu8vlw3RuNY47nYbkc6Lu/yKT4KIEnfWX46TQgnVy2YHjfpp0AmLdccgXb8oobB0Ngltk63Cm1aeZM++kLMZM3DYk4kWi3ufjeKEbBN9pE+PJnQLw9KuVPkFXld5md6XnEMZbxj6TNJ8UXBA5BrY+Bn1gDRZR42jqnn0I/7T+Iz2Y8iqjDlLFAWBElELNOF4R00xORMqJRSlu2wNxRyZDZ2t1FpL7nGoXkfcD3nnCQdI//ENT2OJMou1SXyMyU3vm0dIzw84rLtvab8+VlGD8LH0J7xuss26/4SPARy/fY23oO5SQ5cv7dKqyECnBKuMHrr4zIST6HSCLVRZVoAGDescGkzdIF+28vDZb7V7JXvS8kqudulkdnWk3yn91XmmEwnx2Iaf4S8kYPzVE1J5+UIEmN55/YEMEp2HKJ8DRMF9kT+2tr0/8DdCkthMRdhQ0eTkyjFrei53grbYfJNRmIreqbeuaj3dLTUdRmYoWxiTfe639/NIsNe83SJa590JmretMU0sRHXKZJuLvqMm9+yp+Blw/OUAcir51HQBTu64xhM3qXppGeVgO+alI5b3KfRkz5OSqZoHzLoqKiYZrLY4NZ3zoHvlukz/dc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zz+r7a4x53hVkwgMBim2npapzRb7kDv1GsX73S1WmXzN8VBHJ8756kBqHINlaT+BG99759BCwzS2lIWJvecsS6O5QmdC5KHjSlH2/3dYeEkI85jwxHw5oD++PrfoRh8o/lwIcRUTN1sGA5KTcS9tjy6umoFmAfDZDk+/wm+TRDbB7MOYdcHVL3T/CpGCyGZTaLY1BUcuN7Kv6C3avS6g7d2GxE5xXjjl88UXKjcqya3ndn0BjP7iHBXqu5kVVJwL7F1PmtYeM81MO2wSkJ37vdRJJiu+57UGbLuOwjA/EfDPBReEt/BmH0N8ck9/HKEL2a6GKEhknjEuwMPblVPaOwVbQpWnbHxPjUj0OEsnNpmkdjlxXz6tHIYLEJVxV29B8F2bON4a8AG6VpWWA+jLqKsTTpo76XnxTyyJN48VCaxWM/mRqfC9XL95SomLBhdB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 07:03:15.1360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c752c57c-d802-43eb-88a3-08deab3d8b52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB999241
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

From: Ray Wu <ray.wu@amd.com>

[Why]
During mode change, replay_event_general_ui may remain set on the old
stream while replay_event_hw_programming is set. This can re-enable
Replay too early before hardware programming is complete.

[How]
Clear replay_event_general_ui in the mode-change path when setting
replay_event_hw_programming to keep Replay blocked until programming
finishes, avoiding white screen on OLED panels after boot.

Reviewed-by: Sunpeng Li <sunpeng.li@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e42a5eecdf46..7ff1af3528dd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10086,8 +10086,6 @@ static void amdgpu_dm_enable_self_refresh(struct amdgpu_display_manager *dm,
 			amdgpu_dm_psr_set_event(dm, acrtc_state->stream, false,
 				psr_event_hw_programming, false);
 
-			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, true,
-				replay_event_general_ui, true);
 			amdgpu_dm_replay_set_event(dm, acrtc_state->stream, false,
 				replay_event_hw_programming, false);
 		}
@@ -10616,6 +10614,8 @@ static void amdgpu_dm_mod_power_update_streams(struct drm_atomic_state *state,
 					psr_event_hw_programming, true);
 				amdgpu_dm_replay_set_event(dm, dm_old_crtc_state->stream, true,
 					replay_event_hw_programming, true);
+				amdgpu_dm_replay_set_event(dm, dm_old_crtc_state->stream, false,
+					replay_event_general_ui, false);
 			}
 		}
 
@@ -10669,6 +10669,18 @@ static void amdgpu_dm_mod_power_setup_streams(struct drm_atomic_state *state,
 			mod_power_notify_mode_change(dm->power_module,
 						dm_new_crtc_state->stream,
 						false);
+
+			/*
+			 * Block PSR / Replay on the new stream until display settles post-modeset.
+			 * These events will be cleared by amdgpu_dm_enable_self_refresh() once
+			 * allow_sr_entry becomes true.
+			 */
+			amdgpu_dm_psr_set_event(dm, dm_new_crtc_state->stream, true,
+				psr_event_hw_programming, true);
+
+			amdgpu_dm_replay_set_event(dm, dm_new_crtc_state->stream, true,
+				replay_event_hw_programming | replay_event_general_ui,
+				true);
 		}
 	}
 
-- 
2.43.0

