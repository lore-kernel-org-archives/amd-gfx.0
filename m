Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1446DC021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 17:10:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5A1310EB08;
	Fri, 21 Feb 2025 17:10:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="B6WK4sGe";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB07C10EB08
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 17:10:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K6pcT3owssCeA0bCOMTcadiexibXFyIMt/wOgnTg2rOvGhhlSwokZ9uw3ucPvDlXnbTmMK/Qu7s/WA1moreQ1KhIf4prg4Myh6AzZkdn6OeNYYkx0GQLy3j580Edoa497wwHRB8N2J6hjU1l0e0Q3zxgyLXYAXQzQzZmQ7nKV8F+bvRW0YctDcSJcxUK7PpAsU8mom3PRfobk1B//CwiCYhTSosZlEGYn+SD0U+kXZ5xIpS8oIoa0ejfz2p1X7BCNBbUra04zWoSNwCOYLKl8s1kxDonii6rThkg4QGmRrbzs7A24FCAKSn6hIDA97v8EUHqNTGB+MrhHm6Ocy2ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MWzA1jgptUG7lwIb0nxhRW668pPnLWdKcSOZOX0dLuo=;
 b=Lygu6U5pI8Or7ID68NR8s5g+4aq4n9bigCitZ77/cOdjDMbFP25o3EZOW7FfdYyYuSGLY9NEqlUP3gnTCr6ho/9R0TvWFsSosxOhmf1LwdEUmmGP7nnxaKiPYNM5jvA5NDh7u1aeC5j/PQw8qHDglfkO0KjDE/TEtCjaO7ji+yezRLdjhyDh+ikiCvkvlRWXUO35wk1QJ4XuYOmvp73w0R9rtegKRqOOuTQ/tbK0JQsWDlrD7nuhMY5Sl4Kla/S34ABvICdL9ZYnvBnTUFVf2fbfIIKcsKDGfki5iu0wU9oaHBAVwnaigB80G468D0khoPIUinQYQyhJLDrn18TA3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MWzA1jgptUG7lwIb0nxhRW668pPnLWdKcSOZOX0dLuo=;
 b=B6WK4sGeVJvtijGbKhfBP63KsXlOQL6D2BZgXsPFoELZIVQBidKgNqJ75rl1wN0hDYMt/lhHZBJNAEt3JCTywdxBnrSxUjW4aZ7y8Qjrtvyl+/j+KHg13ZKyJ0r0KXn3Cc77MgazBccfI7TxQRxrJMF/JExn7gRE21FQgkoQrI8=
Received: from CH0P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::21)
 by DM4PR12MB6397.namprd12.prod.outlook.com (2603:10b6:8:b4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 21 Feb
 2025 17:10:18 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::e8) by CH0P221CA0020.outlook.office365.com
 (2603:10b6:610:11c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 17:10:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 17:10:17 +0000
Received: from AUS-S16-AI-13.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 11:10:16 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>,
 Alex Hung <alex.hung@amd.com>
CC: Harry Wentland <Harry.Wentland@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 3/5] drm/amd/display: Avoid operating on copies of backlight
 caps
Date: Fri, 21 Feb 2025 11:10:00 -0600
Message-ID: <20250221171002.209895-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221171002.209895-1-mario.limonciello@amd.com>
References: <20250221171002.209895-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM4PR12MB6397:EE_
X-MS-Office365-Filtering-Correlation-Id: 9079498a-7520-4951-c0d8-08dd529a9dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4UFICBOsTb5d1BAq3bqS6erViXTuj13fQqsQRJpk1s9kfX81CauwajI7SiIi?=
 =?us-ascii?Q?JubdCRJFjAfNTwMQrK8w+oC5le2dBmDesXCVjW+GMhZvqgcW/Bz5M8cTY3Og?=
 =?us-ascii?Q?/M5D1nXReJvB1YQAdObEHklWe9gqyEEmAd/pWQnEni4Fi3ggfI+j5JjziOlT?=
 =?us-ascii?Q?RpnaE5orHIQr3uFfbJy8+U6gURaenFcB4rk5/78CXYXxRy9B3FR6JL3srrM6?=
 =?us-ascii?Q?03fjiz5I8lynS9sCwizGS4Fj8CrBwkjguMsy8+pvrG8uqJJ1ln4Hxqe3UYa4?=
 =?us-ascii?Q?2h0Wf2gI0oYdwfinaEa6MC5mTtQFksqQMxo5z5lE3MDgtdmJd/N+Ywt2Tyfw?=
 =?us-ascii?Q?voS8izRcgPe3JzmpYlwtugPT/VNnyqD/Mpyl4mQv5PhBEjmXldWsW8qcYWSB?=
 =?us-ascii?Q?La/+Ju0OSO3TLaHdVEEvjzYMTbJm7ORB5Rtj9qKwuh7NhRuakMGhXv9VNZk2?=
 =?us-ascii?Q?+hSmCNE8y/FWkSjcWLAizVxRl/aqw9HF/LC4ts7NSKzDomy42H4qlJ7CXGS1?=
 =?us-ascii?Q?+mGJ5FnCiXsLPCSLWkBNvZ1WWkloftNaT6waogq7nj4+oSigousZkpmLgHnV?=
 =?us-ascii?Q?QJ6xe5b2SXDIyujj8LLlO6HzIbn/Xhmx1kG7SysAlUWYWB3TAwdD3PtSC8DB?=
 =?us-ascii?Q?DGJUpvy4whoQgEtIXeo8tL/u3VU2qvghEs4fg9/v+SROvpjez+t2IRM5QHNk?=
 =?us-ascii?Q?01AYh8sG69ZOR+HaSYB0dqKVWBUXLMivqd8XiFq4vWZguUFrOU+no3L9JJeX?=
 =?us-ascii?Q?jr+QJOgonjCcEDzSKFjXAjb8xsUkWyzT70gV+5sHUsTnO4flLeXCZp9Kj1aC?=
 =?us-ascii?Q?Z5Ji1LkjTZ3sidtCia3g+ToMVcobBSWCrOYrqILUBaSduK4ntVjezbrEAAAJ?=
 =?us-ascii?Q?LbU6LvlUfAyuLD+89sx63oexXhi5twcyLO+bGLjdZl0ieGG8vZ8whds4tWqg?=
 =?us-ascii?Q?MUqP++gfvhlffYK/o9MqJqdh5nD6JgqN1NUiDrZNBq3b14k/Zs4bSkfk8T1v?=
 =?us-ascii?Q?f+0x/Jzwoj9cRCGFpdl7YJbmjavAjQhE8eMASMJHqto93vR59/A1JzwfxdIO?=
 =?us-ascii?Q?dwWoDi2jiRUsKNVU2kJK1KKJ1u+aIaqQocTjpB/k3HbNCFvgrYwy9XLFIa1x?=
 =?us-ascii?Q?hN4TQmk8kxQqabCs0fVg9KxB8unC1A+mZCjsYge3BktYPc42MF5jiC21pQ/K?=
 =?us-ascii?Q?iSK5t+b5JmvrLyBwggt84wYd46D8CwhBM0AWPW8/dn+rcJSuxq5nobMPaC2g?=
 =?us-ascii?Q?6IGMm8DSwlBFvW8vzr7gczUIIe8TKKyRPihlkuv7i9aa9meOtLBvLzxCXH1z?=
 =?us-ascii?Q?VIaxshLwO46kAvfHw/ASXiUaFoKOYcPCPAggGD0+Elc1gWOK0UPowFZn77rS?=
 =?us-ascii?Q?4Bm2lFkAXQBBPHMvxOtYMVw/rB0YbXt3H9i0Z42EL8Ws9eNSd382c9kuICVG?=
 =?us-ascii?Q?N6A5NIW1eGWUi7l1QOUXWGtvSEFs+OipF44OzvUVFMgehoCjDrHiVo6Le/MR?=
 =?us-ascii?Q?OIGIgqm4MllWxgk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 17:10:17.9482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9079498a-7520-4951-c0d8-08dd529a9dac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
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

Making a copy of the backlight caps structure between uses is unnecessary.
Refer to pointers to the same structure when using it.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 50 ++++++++-----------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d21448ea700..70c8d800e173 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4646,47 +4646,39 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 					    int bl_idx)
 {
 #if defined(CONFIG_ACPI)
-	struct amdgpu_dm_backlight_caps caps;
-
-	memset(&caps, 0, sizeof(caps));
+	struct amdgpu_dm_backlight_caps *caps = &dm->backlight_caps[bl_idx];
 
-	if (dm->backlight_caps[bl_idx].caps_valid)
+	if (caps->caps_valid)
 		return;
 
-	amdgpu_acpi_get_backlight_caps(&caps);
+	amdgpu_acpi_get_backlight_caps(caps);
 
 	/* validate the firmware value is sane */
-	if (caps.caps_valid) {
-		int spread = caps.max_input_signal - caps.min_input_signal;
+	if (caps->caps_valid) {
+		int spread = caps->max_input_signal - caps->min_input_signal;
 
-		if (caps.max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
-		    caps.min_input_signal < 0 ||
+		if (caps->max_input_signal > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
+		    caps->min_input_signal < 0 ||
 		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
 		    spread < AMDGPU_DM_MIN_SPREAD) {
 			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
-				      caps.min_input_signal, caps.max_input_signal);
-			caps.caps_valid = false;
+				      caps->min_input_signal, caps->max_input_signal);
+			caps->caps_valid = false;
 		}
 	}
 
-	if (caps.caps_valid) {
-		dm->backlight_caps[bl_idx].caps_valid = true;
-		if (caps.aux_support)
-			return;
-		dm->backlight_caps[bl_idx].min_input_signal = caps.min_input_signal;
-		dm->backlight_caps[bl_idx].max_input_signal = caps.max_input_signal;
-	} else {
-		dm->backlight_caps[bl_idx].min_input_signal =
-				AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-		dm->backlight_caps[bl_idx].max_input_signal =
-				AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	if (!caps->caps_valid) {
+		caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+		caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+		caps->caps_valid = true;
 	}
 #else
-	if (dm->backlight_caps[bl_idx].aux_support)
+	if (caps->aux_support)
 		return;
 
-	dm->backlight_caps[bl_idx].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-	dm->backlight_caps[bl_idx].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	caps->caps_valid = true;
 #endif
 }
 
@@ -4740,19 +4732,19 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 					 int bl_idx,
 					 u32 user_brightness)
 {
-	struct amdgpu_dm_backlight_caps caps;
+	struct amdgpu_dm_backlight_caps *caps;
 	struct dc_link *link;
 	u32 brightness;
 	bool rc, reallow_idle = false;
 
 	amdgpu_dm_update_backlight_caps(dm, bl_idx);
-	caps = dm->backlight_caps[bl_idx];
+	caps = &dm->backlight_caps[bl_idx];
 
 	dm->brightness[bl_idx] = user_brightness;
 	/* update scratch register */
 	if (bl_idx == 0)
 		amdgpu_atombios_scratch_regs_set_backlight_level(dm->adev, dm->brightness[bl_idx]);
-	brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
+	brightness = convert_brightness_from_user(caps, dm->brightness[bl_idx]);
 	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
 	/* Change brightness based on AUX property */
@@ -4762,7 +4754,7 @@ static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 		reallow_idle = true;
 	}
 
-	if (caps.aux_support) {
+	if (caps->aux_support) {
 		rc = dc_link_set_backlight_level_nits(link, true, brightness,
 						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
 		if (!rc)
-- 
2.48.1

