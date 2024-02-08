Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2E3C4828F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Feb 2024 22:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F8110EF03;
	Thu,  8 Feb 2024 22:12:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kxpaSwqx";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4458710EEFF
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Feb 2024 22:12:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3uIOfU10pYv6Prw+CzEdA46sCioECoRKdzy7fbzt7+0i7i3jP6JNC4RE9t+mTAjxLkBRKNf+DThvuXXxkXz2JLb6IkYI2aTcrREPEghaVgT1NBPlohzQ0eNA+cfFqi1d0g9m5skKGIt8Tibpzrk5AFRZJsWYrdqUKlK+PkdYOYmWwDI1Zjah7DCC5utqIip8RQTbGmxZdgviIf0dQuvEGtt0f9YrbWfbX2ne2pSNsYcIdRz0gUTECDOFM8GwX116qrsn1jMcI5u/+zZ83Qe61fto74IE4m4MFeiSvqAm+Vyd+a2R/6VUbOw+pWAKuUCz3u2gcMvvhSzEE7ST+eGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebtynea6L4nq+Fptw+dhZWlC+X0VyCIL5qgTw2eRrG4=;
 b=aTIue/0oJTc0pDsAXjy8QCa56wBcNsuF1Yp59/OZ6dvHYk+SFPcX5xKFnrCPM9C0h9KryB3hSrB14i2BZ8N+rlO9hYN6Ia91XhPIkUlzOWWKm7nQSAgkFag6bdYUytgcTRHSc9mYUpkkizRwIu7UAqu85GffYfBWxu8Ds6SvASqqgJ9dE4ZMhx+FmxenZBO1i2tOyLmBcaKTWWc1Qm96ycirl5BHSUal1byEBdI4ty5myERQ4qUJzL8+Ndc3ocrrTPLX83wSpk3zClYWfG0GS2R3sG5/Dcjnixk5W2VKhJokcLyRPGAim40VLjg4HfxChOCEp6CJAhKHfpvPAImxJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebtynea6L4nq+Fptw+dhZWlC+X0VyCIL5qgTw2eRrG4=;
 b=kxpaSwqx9UtC1UOLhqrTqyIJI0K+WvtiafdD/uVLP6BQz9/ltr/H5GU7+S26TnzHZdaZqlXAAZgwWAP3zYY9fWeFmijKxQ3hSTmYrH0gakminJcVGrZYbLkuclOFteb6ykjiBsZOwExhmhx16tLT3qGElZpeFv9K1VEa8agxrMY=
Received: from MN2PR01CA0006.prod.exchangelabs.com (2603:10b6:208:10c::19) by
 MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 22:12:21 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::ab) by MN2PR01CA0006.outlook.office365.com
 (2603:10b6:208:10c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42 via Frontend
 Transport; Thu, 8 Feb 2024 22:12:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 22:12:19 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 8 Feb
 2024 16:12:18 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] drm/amdgpu: make damage clips support configurable
Date: Thu, 8 Feb 2024 17:11:52 -0500
Message-ID: <20240208221152.34944-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b32f433-f077-4965-5556-08dc28f30438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8vLRb0GVb/zLxEWAiRqt/OC9VWz8HMhXl2ugkoI5KyXC9WlO/r1td+0uS411pOUvVQoiKRDt6uVrhH2ojhiGT9V3kGxEkm3uyCxKmagWBoisEcv/Vr6o+I94CLiwNrjx8g058dzzu68hORyhmosb8yIG2zQgFf4uq0/BHWCiGbM5ibPXVoiCtNn5W3moWKqVdbmDZazRJoyO8PY+ydyiqZckWLo4JIf86t+3aBHvxCNrsQzsY7I43XtNPO1BWCnhumQmM9DQnSlyY2Tse1q73qT0BmF7nadsselWUAnauucZ2PYr28VpyG9XIpkd2jMkR9q/SK7qiqcIyDEA8S5iQYUGAYMCkCPxF+6D2Cm980YBzIP65UWXr762d6+iXu1D/do8VBfYtfpCPIAtgEyr06tTsKHW/bUgRI/k5lxQtgAXsrDCohYWVB7dQNQkXTcAl7aul2XTSZJc7XZ4f1rJmt++Bjk56y4at/RGSNQWDJ7TC3OKsf+DQ3m7cszYzuLXqBiFQoNodR3c3Y2BNCkfZAdEVkFgAQ8LV4jvFWMPe24FB410Uo/bnqaQN6Af+llpbKZpEu0F9t0XiOJb+/8LT3ctefYwDtEC5gZ57peq/s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(46966006)(36840700001)(40470700004)(6916009)(82740400003)(4326008)(316002)(81166007)(54906003)(356005)(426003)(16526019)(6666004)(70206006)(83380400001)(26005)(5660300002)(478600001)(2906002)(86362001)(44832011)(336012)(8936002)(2616005)(70586007)(1076003)(8676002)(41300700001)(36756003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 22:12:19.2263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b32f433-f077-4965-5556-08dc28f30438
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000
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

We have observed that there are quite a number of PSR-SU panels on the
market that are unable to keep up with what user space throws at them,
resulting in hangs and random black screens. So, make damage clips
support configurable and disable it by default for PSR-SU displays.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           | 13 +++++++++++++
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 312dfaec7b4a..1291b8eb9dff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -198,6 +198,7 @@ extern uint amdgpu_dc_debug_mask;
 extern uint amdgpu_dc_visual_confirm;
 extern uint amdgpu_dm_abm_level;
 extern int amdgpu_backlight;
+extern int amdgpu_damage_clips;
 extern struct amdgpu_mgpu_info mgpu_info;
 extern int amdgpu_ras_enable;
 extern uint amdgpu_ras_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 161ecf9b4174..2b75aeb8280f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -211,6 +211,7 @@ int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
 int amdgpu_agp = -1; /* auto */
 int amdgpu_wbrf = -1;
+int amdgpu_damage_clips = -1; /* auto */
 
 static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work);
 
@@ -859,6 +860,18 @@ int amdgpu_backlight = -1;
 MODULE_PARM_DESC(backlight, "Backlight control (0 = pwm, 1 = aux, -1 auto (default))");
 module_param_named(backlight, amdgpu_backlight, bint, 0444);
 
+/**
+ * DOC: damageclips (int)
+ * Enable or disable damage clips support. If damage clips support is disabled,
+ * we will force full frame updates, irrespective of what user space sends to
+ * us.
+ *
+ * Defaults to -1.
+ */
+MODULE_PARM_DESC(damageclips,
+		 "Damage clips support (0 = disable, 1 = enable, -1 auto (default))");
+module_param_named(damageclips, amdgpu_damage_clips, int, 0444);
+
 /**
  * DOC: tmz (int)
  * Trusted Memory Zone (TMZ) is a method to protect data being written
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b3a5e730be24..fbe2aa40c21a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5253,6 +5253,7 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 				struct drm_plane_state *new_plane_state,
 				struct drm_crtc_state *crtc_state,
 				struct dc_flip_addrs *flip_addrs,
+				bool is_psr_su,
 				bool *dirty_regions_changed)
 {
 	struct dm_crtc_state *dm_crtc_state = to_dm_crtc_state(crtc_state);
@@ -5277,6 +5278,10 @@ static void fill_dc_dirty_rects(struct drm_plane *plane,
 	num_clips = drm_plane_get_damage_clips_count(new_plane_state);
 	clips = drm_plane_get_damage_clips(new_plane_state);
 
+	if (num_clips && (!amdgpu_damage_clips || (amdgpu_damage_clips < 0 &&
+						   is_psr_su)))
+		goto ffu;
+
 	if (!dm_crtc_state->mpo_requested) {
 		if (!num_clips || num_clips > DC_MAX_DIRTY_RECTS)
 			goto ffu;
@@ -8411,6 +8416,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
 					    &bundle->flip_addrs[planes_count],
+					    acrtc_state->stream->link->psr_settings.psr_version ==
+					    DC_PSR_VERSION_SU_1,
 					    &dirty_rects_changed);
 
 			/*
-- 
2.43.0

