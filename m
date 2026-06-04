Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B42CD6E79
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAD63112846;
	Thu,  4 Jun 2026 14:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ac+0jloX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BAF112843
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVaZr9Z72mwwN1U3ppu/qUVMXWxJrhkJzuKTlpUdMkNgh1AEJSkd7sxVkKOAmS5opDEXsxeKimbOMpf1IgaGZroJt+XdAkeAIG9OXft/59NWPxCKxiv3KLlReehkPMGEkWR9EE1C4D8IRAHyQw0+BTSc+kf8DTwhKVj932o4zy7LH7Pg/U60KB8RS10sW3cOTvi0DHuCWVDo5+wFJi/GuN1Jpyn0+P1fCF3FEEryEQZs6KqTcw5IUgnF4MZ/b7zWa9JyoTsIdnOquS+lWDu5VT3JbzLSDWipqCAz0fhNFjDmDaTM/w4rl2cdqz+pZkxHfIGgtqDZ++27istVhe0M2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lBLHAmwi+VMMSpuwEM9dro0ASh+FHILp9b6lve2W4o8=;
 b=Ov++ym0Vy/Yg+oBgUZ6iD/+WvuESuAGf1eB8VXPQOrO7gcNYNexR+zQrVumK5nwKOq0DDq5sWV8uyWI43G3JX17HSuoMh3kg+TZV+scy/8Qxg6oeb11PtSWYdyFj8RUYLX9EAPU3znLPTf2HcKk6g6Hzyj+1QouLHkMi9rL7PJSxA6du+8xbLCu0UwfpcPOFH9qDFaDzfEQ9+hwktx83MLpJztv1Qsnk2XJsnLxCX/h3bymD3TRGkFBzDGjAHkiD4EPsOuo45fNpNrVF3kB7XZdS+EG82ah2tAdgD81xOof8oKLGKuymU/pjibWprgYeDQ1xvyh2DcOf657wRFWztg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lBLHAmwi+VMMSpuwEM9dro0ASh+FHILp9b6lve2W4o8=;
 b=Ac+0jloXpIcXlCr1xpcG8UC4TRqSJirzCvyT2ouuPIC/bcS8z6oY4PbMeUgSyeX/4t/TrJyGcMSv5pabJMUgTIc0/rDnkHZ7d5XOslkxYSuN7/Yizg0JbKzZMYdwakVzv+URkKxqp4Zna+thh46pI4odqxRkZIXQZcgsUm51j38=
Received: from BN9P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::20)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 4 Jun 2026
 14:55:18 +0000
Received: from BN1PEPF00004688.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::a2) by BN9P223CA0015.outlook.office365.com
 (2603:10b6:408:10b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:55:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004688.mail.protection.outlook.com (10.167.243.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:07 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH 18/24] drm/amd/display: Add detect reason to
 handle_hpd_irq_helper
Date: Thu, 4 Jun 2026 10:52:12 -0400
Message-ID: <20260604145428.809959-19-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004688:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: fda6b845-df71-4ea8-6768-08dec2494b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: V3gyrnfWQrhA0AkaTi0b7z7twmGbXyC83teCItDTmZYJn89lpv8ziBgEkKX7f19AQew5JtSTtLE9YxeeIG8CDISuPP3TO6ZCkJzF4Ai696ob8pgK+1ZpQDFKqhnuQPaDiWAmruMsJj8FZMx6D4Nco7G/0y0AuRbMfX9YqCL0TOmY8z9OG6lOqZIgkZzV7ifm/dwWZAgcP6OCZZZIqlQiOkciTZ4qja+VYKy/aYPHS1oSNzH3gSw3hT57NTxy6ReDdxP8icuYZxiUoS1G18TKk3bqns1B5A+gpqLVaQ3l+kSfhfZZnOkZtjfKy0znqKzRz3Qz0y04bk9EcHXo9qByF1tY336UejUKq1kD5UnEhj1qUzX1q0fASXOBgZFvmlWwjrNt7olBKms0kZimtvDhp4rEMlUrJPdbuRi22m+2rK0pFgZ8FM7Qrqs6G00g1gUi8Ig1HXtbq3J8W+QUI/slAHTPFjKDW1a4NahwsRwy4gVqIYNe0J90sWTF9OPzDgBGT5Buu4MGGEBwnr7sGVlPPnWq+KB3M2grjdwy6phl5Xxwi0OsZEKjxktWU4yG0Jzb9zQCqWacy9HW77xettM+j9NLQedajzzwW0jwfHwivZIygJUzDXHuJUeeJrIlCaL3s71q9QMAPB3i7iJ3O7llJ8NJVum4czEPeYC+m4RJt+TjODc5BmmfCt9XllBgTD25Q3FJty/D1XJ42iaQt5bbjEZLCCCl6e0nrBEdVzgJHP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: REKlHHlpd2kpk6SiqEa84BrCi1a+DGir9eDfxJsd0nx/l83MofW/iWFiU0hLHv/qN3Z1+qhXz5GRnBUZrjZolGETYzk6kX4NpsSgJH5ArKaY/c/SAkIl5pqbjj0hKjEvoYJMTGaYeZOEVH9L3sDZRKpODmURSqFZlEQIfk+gjznStoU6ojFjSm/4T640a0VDLwcZ3f6FoieIvaZL5dkTsb0o/qfZVodJb8LZJJgpiF8Of/0DNlHnMw886yboA9FTOvqSjOI/6J8Sxv/uiGZwiiBeQJn9MbN3QCOYLdNdniKlIqF3oRFJmm+e3bSYZp/Bb7Tdj1rC29QaTO0LO/klC2QEhW27Ey3fDewA8ElZpoGAQW0Wn3mVOiM7PAhzCs26BtECvn6pFr3JpAl/+72jFGxwKA/e7PuKhN+UIwQ0ZmQ1HJJKzW6vgjxJKIk4pvH9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:18.5472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda6b845-df71-4ea8-6768-08dec2494b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004688.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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

From: Timur Kristóf <timur.kristof@gmail.com>

This makes it possible to reuse the function for other purposes
in the next few commits, such as HPD RX.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 46993b5ae688..52cfe32f14b8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -242,7 +242,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state);
 static int amdgpu_dm_atomic_check(struct drm_device *dev,
 				  struct drm_atomic_state *state);
 
-static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector);
+static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+				  enum dc_detect_reason reason);
 static void handle_hpd_rx_irq(void *param);
 
 static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
@@ -890,7 +891,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		if (notify->type == DMUB_NOTIFICATION_HPD) {
 			if (hpd_aconnector->dc_link->hpd_status == (notify->hpd_status == DP_HPD_PLUG))
 				drm_warn(adev_to_drm(adev), "DMUB reported hpd status unchanged. link_index=%u\n", link_index);
-			handle_hpd_irq_helper(hpd_aconnector);
+			handle_hpd_irq_helper(hpd_aconnector, DETECT_REASON_HPD);
 		} else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
 			handle_hpd_rx_irq(hpd_aconnector);
 		}
@@ -4355,7 +4356,8 @@ static void hdmi_hpd_debounce_work(struct work_struct *work)
 	}
 }
 
-static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
+static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector,
+				  enum dc_detect_reason reason)
 {
 	struct drm_connector *connector = &aconnector->base;
 	struct drm_device *dev = connector->dev;
@@ -4402,7 +4404,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 		dm_restore_drm_connector_state(dev, connector);
 		drm_modeset_unlock_all(dev);
 
-		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
+		if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
+		    reason == DETECT_REASON_HPDRX)
 			drm_kms_helper_connector_hotplug_event(connector);
 	} else if (debounce_required) {
 		/*
@@ -4434,7 +4437,7 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 
 		scoped_guard(mutex, &adev->dm.dc_lock) {
 			dc_exit_ips_for_hw_access(dc);
-			ret = dc_link_detect(aconnector->dc_link, DETECT_REASON_HPD);
+			ret = dc_link_detect(aconnector->dc_link, reason);
 		}
 		if (ret) {
 			/* w/a delay for certain panels */
@@ -4445,7 +4448,8 @@ static void handle_hpd_irq_helper(struct amdgpu_dm_connector *aconnector)
 			dm_restore_drm_connector_state(dev, connector);
 			drm_modeset_unlock_all(dev);
 
-			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED)
+			if (aconnector->base.force == DRM_FORCE_UNSPECIFIED ||
+			    reason == DETECT_REASON_HPDRX)
 				drm_kms_helper_connector_hotplug_event(connector);
 		}
 	}
@@ -4455,7 +4459,7 @@ static void handle_hpd_irq(void *param)
 {
 	struct amdgpu_dm_connector *aconnector = (struct amdgpu_dm_connector *)param;
 
-	handle_hpd_irq_helper(aconnector);
+	handle_hpd_irq_helper(aconnector, DETECT_REASON_HPD);
 
 }
 
-- 
2.54.0

