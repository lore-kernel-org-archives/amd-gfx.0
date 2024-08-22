Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37649C3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 16:19:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C11D610EB5D;
	Thu, 22 Aug 2024 16:19:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLHMeKhs";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2360D10EB5D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 16:19:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObTUgApHaA4et7YeNFcvDWoxsXB1SWMfj7ugOonrg5qJPiPOIwr+yzQ2R6XdzzEB5JWCPbnQ6lIJicyB7ICTrmluBTdua8+nrMkwNq6myGCN8K9nOsspv0xCYkcBsHwVKZGLt3snBxNZ2BqHKsOh5sH8U2pVVU0XrT76dgINOFI4i2sJVr0icjnr4qHi9U7XMqKzSCofWWQc3+MKjB+3kLxPd9YNZk9GT3TeK5lQUDZpGqlfuqcnSh52cVaM3lep8troMLSBMu8RqIxaooYHqCpk0dr16lsNrVO1YkKpe1pzKLliU1sxKN1BVASzNiyQouotvoMkL/flVc7A9RRlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GF9zy4H1Zz3JH2ZtOPhT5QNfYaxz9dX7XRMDhzHVsGo=;
 b=B6YSjxnm1cdZB73jFfOxRSQdKXzkX+rjN/IorquLEm57JnVLLqi9E4ZtR+LS+6pay0Is3d+/QS6CCBOCSZRhga0QF+ezu/dxc6LhpVC4Dn9y8eCNlV5L2FaRU95e9ptdFlK4fmzRXbF7NespWkVW8c1BWpc8NzUttrUdHIma2T1z3y4hUdYwP9Un0E7OSArwOVuC9nj1kKVs4Ra3LFXvV5oMHybAXXeAHogcUUF5LdD/6TVZYgePfL/nJjZ8wwMlurD2OkVNeQnbf6+uGW61pLKabnAy/FKIFqG3XIb+zXFtqjdshPT7e5C/HcTefvF/pR5utyShM1qIkY7iXBuIWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GF9zy4H1Zz3JH2ZtOPhT5QNfYaxz9dX7XRMDhzHVsGo=;
 b=OLHMeKhsz09OkHtKsFXilxsAJ0rBEMTOpu4YTQXk2tKWXzc8Je7QX+b+RDP10FpCJlpJG7V4/bVUvhQKPsiwMus0ItDD6SAOHNFEBVuCOcbTmnWQHHzn9BDVy6LsMNva4KbbX22exfXhPb+JOTgBwRogthbXAT+DuEywuU9qJcw=
Received: from BY5PR04CA0028.namprd04.prod.outlook.com (2603:10b6:a03:1d0::38)
 by SJ1PR12MB6338.namprd12.prod.outlook.com (2603:10b6:a03:455::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 16:19:19 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::c0) by BY5PR04CA0028.outlook.office365.com
 (2603:10b6:a03:1d0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Thu, 22 Aug 2024 16:19:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Thu, 22 Aug 2024 16:19:18 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Aug
 2024 11:19:16 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH v4 1/3] drm/amd/display: use drm_crtc_vblank_on_config()
Date: Thu, 22 Aug 2024 11:58:20 -0400
Message-ID: <20240822161856.174600-2-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822161856.174600-1-hamza.mahfooz@amd.com>
References: <20240822161856.174600-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|SJ1PR12MB6338:EE_
X-MS-Office365-Filtering-Correlation-Id: e0c01962-ff99-43f1-d587-08dcc2c62cc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SMgn0mUEf9aZC8WcYId8e6zV6e+sP1IYFZOcAFA6ftk6C9bUqRzzFvbcnRAs?=
 =?us-ascii?Q?ahLGvVqjYBGTT+5eWP7RBMJFolTombzC/flWXKyPZ0tczQBbfWVELdIcV4Un?=
 =?us-ascii?Q?R3M9fOkUi3/hat3w+z8Sn++0jYppv56xjaEzIHw+cMLEUglUGEDhOnZNZFGe?=
 =?us-ascii?Q?IW+0LxUqUun05N9cX2LfMrhfjBgyIHYVGXMubWtqodhC3pSBWNSPMD8PUTX+?=
 =?us-ascii?Q?BFyN/ovuQDeapPCC+ac0Yd8GSG+Vy82MNxPwYP4AMlil2hCtsUwSrdIV1vby?=
 =?us-ascii?Q?NR5g0wibQsf5awddfXf/mQEEnLIyfPMAOT42UTo75BeYCWc7Tizfkkn9XT20?=
 =?us-ascii?Q?jWf4KPxfiwZoA2tKf0c/IkQ9hsn1JGyUtk5bYGKhOvIrarqfHZ+LbnegMBqL?=
 =?us-ascii?Q?ZLpHeKgSeunJyYDyG8d1g/eV65hF+/v+J2DhhN53x21l/CPEQiEMY004BpvX?=
 =?us-ascii?Q?yyG55xMSdxdnGiiCrGxOj9kahTesxHD+C6jBH+CiZcozk1cEj5dtPuAdJUxI?=
 =?us-ascii?Q?AqJ14TFFU2TZc5qjEDCQjbfUDc+zs3PYWW6iPmN37/MhJyUUgayPeR5gyNLz?=
 =?us-ascii?Q?1N3Rm8gKs7+kZtScFzy0GQNjQb0uwGwvEUk8Rt55/Pk70lFFaog8K1yhTw1k?=
 =?us-ascii?Q?ecHL1f+Jj1yEDF/aNfSKNtPvYxod1wD3BQAiRSO5h0tvuICuG4fHE60u3xcS?=
 =?us-ascii?Q?whA8xi5nUbBbU22+U1+v2EV88/TDo59iv6pav5neLsIY6IY846aBawL45OqJ?=
 =?us-ascii?Q?HN5fWkcKMninmvVEDgVXqQ/HcW/p0SlPBQYhk6JfhPNn5qQNywjVZEI0hp3y?=
 =?us-ascii?Q?TLDGTCa7kXPK5yX/LDAAR/uynFbLMKqh1Jjw/xe0Htjqa4oJ2y8Oo6JCHWNS?=
 =?us-ascii?Q?Y8cAdDUaeyt4q5FzgSBZHtAogZV969Lm1F0/N89lnVZd4yPVq0uA0OqcbH5o?=
 =?us-ascii?Q?PSyNAsWwkec5MoMV7j4P5oJqsLKNlQhb1gsHMmDD/EaOwTkHICypaanWEqYq?=
 =?us-ascii?Q?U+rnCjXR2hwp/Eqnwf90hwyG93+DsH99DhqU/zY8QpgdFZv41M0336yrPBnH?=
 =?us-ascii?Q?OIUx1ZmczXZB7BQHgul44l6H/WSDuoRyQ1hcDT19yTOrlt5eSmtxx0HR33w2?=
 =?us-ascii?Q?UfyZPMruNvAd2fy4/4PCNBHlU8OtIoUTwZF40mcpyFBo386N3ILohnjaA7IL?=
 =?us-ascii?Q?M00FYYV6e5pwzcIU77+tA4eEZi9V0lduh8xnaT6z9Z2Rn0C6wt9c4I9DbR1D?=
 =?us-ascii?Q?qi70Zbn3nSwzxTXx9pCj1UD3NZy5QUDMaQMykZmRmi3pFA5c683k2G1gLaPL?=
 =?us-ascii?Q?CBR2mGGtxZGE8cW99QkCEHBsCctnJ9On/2+tWt5e+0TeZ4KdW4tkwFz+sX5f?=
 =?us-ascii?Q?qxLVV7INN9sCBZfRzaZBQNeWl/i3zz6dWd1RKsDJfubUmcI4n6VZja/FjTvK?=
 =?us-ascii?Q?IBjMwQ8VPnEBbp0++wIr0IN/YATzkGE9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 16:19:18.8565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0c01962-ff99-43f1-d587-08dcc2c62cc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6338
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

Hook up drm_crtc_vblank_on_config() in amdgpu_dm. So, that we can enable
PSR and other static screen optimizations more quickly, while avoiding
stuttering issues that are accompanied by the following dmesg error:

[drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3

This also allows us to mimic how vblanking is handled by the windows
amdgpu driver.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
v3: use a less conservative policy

v4: drop TODO, use simplified calculation from Michel, use
    DIV64_U64_ROUND_UP() and use a different policy.
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 36 +++++++++++++------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e7929f24ae4..00d4c97e8d26 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4934,12 +4934,6 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 
 				if (psr_feature_enabled)
 					amdgpu_dm_set_psr_caps(link);
-
-				/* TODO: Fix vblank control helpers to delay PSR entry to allow this when
-				 * PSR is also supported.
-				 */
-				if (link->psr_settings.psr_feature_enabled)
-					adev_to_drm(adev)->vblank_disable_immediate = false;
 			}
 		}
 		amdgpu_set_panel_orientation(&aconnector->base);
@@ -8232,7 +8226,7 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
 
 static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 struct amdgpu_crtc *acrtc,
-				 bool enable)
+				 struct dm_crtc_state *acrtc_state)
 {
 	/*
 	 * We have no guarantee that the frontend index maps to the same
@@ -8244,9 +8238,28 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 		amdgpu_display_crtc_idx_to_irq_type(
 			adev,
 			acrtc->crtc_id);
+	struct drm_vblank_crtc_config config = {0};
+	struct dc_crtc_timing *timing;
+	int offdelay;
+
+	if (acrtc_state) {
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+		    IP_VERSION(3, 5, 0)) {
+			drm_crtc_vblank_on(&acrtc->base);
+		} else {
+			timing = &acrtc_state->stream->timing;
+
+			/* at least 2 frames */
+			offdelay = DIV64_U64_ROUND_UP((u64)20 *
+						      timing->v_total *
+						      timing->h_total,
+						      timing->pix_clk_100hz);
+
+			config.offdelay_ms = offdelay ?: 30;
+			drm_crtc_vblank_on_config(&acrtc->base,
+						  &config);
+		}
 
-	if (enable) {
-		drm_crtc_vblank_on(&acrtc->base);
 		amdgpu_irq_get(
 			adev,
 			&adev->pageflip_irq,
@@ -9320,7 +9333,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		if (old_crtc_state->active &&
 		    (!new_crtc_state->active ||
 		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
-			manage_dm_interrupts(adev, acrtc, false);
+			manage_dm_interrupts(adev, acrtc, NULL);
 			dc_stream_release(dm_old_crtc_state->stream);
 		}
 	}
@@ -9835,7 +9848,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
 			dc_stream_retain(dm_new_crtc_state->stream);
 			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
-			manage_dm_interrupts(adev, acrtc, true);
+			manage_dm_interrupts(adev, acrtc,
+					     to_dm_crtc_state(new_crtc_state));
 		}
 		/* Handle vrr on->off / off->on transitions */
 		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
-- 
2.46.0

