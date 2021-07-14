Return-Path: <SRS0=RZx8=MG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C56C07E9A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 19:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3B3613BE
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jul 2021 19:00:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3B3613BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801226E441;
	Wed, 14 Jul 2021 19:00:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D6F6E441
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jul 2021 19:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG87ZwYN0KpJxqHWsJROkHL/1ZjkbLISf267WvdVl0lI+8OI9xU7m7uQZsJeRpnond8cr6ZA2eK4FZeEdPtlLGAunVHNGdAKORbnbX/hWUrfztqNP+OHTaY9zNBGMS04bix6dqKe/U10pSw1484eg18iEL0NWpOrP9T9sugC4gLgFED/lO93Ne3yKohDj0Sm+uHq4axrfLWTL/9mrEzNGU5zbQev7KoWCMXritQAKj9moQJQdVVvD5VQKRn5IhebSEUk/P9GuTiYjaWnbdrh+M0esDVO6fN33w+gjg8flFMstVajYN3KGGMNufqyx4odamsj6YNoHUw5CZ8KAsEttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqmTjEvw6nzxsQnyBAf8gOQjY5HY1VBIwxK8GKhpjOM=;
 b=BAAssNcNJIf0c9N58JSg7IsL1RN5MDodUod+XgOSztF8p9R0voTQLeDFXFUKh/P4nIkmVtPKFWoxxyVQAhZtYM+Iw3onozEhtdFvDINaM+6NJ6nQFIKCk5f9rNW7ezrQkxZDwZqFxe8EtKLBRwxoiUv/raJWd4FpATpXscFFhtFh/BfNDI+w4NdeuI4GbkHc5zcZq6Ka2Q08+s/jddvId7f5HdbwazTriehycVlrQMb6PEcNsWuh8X5dR5PxeAispzp6RLWj8qSoJdTir3Y6TKqcXC23PGdwCzvwP1t8hwx3WIrYDJSZlplEFDj5d/w1iQXlj/pHo+amwl2b8YEoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqmTjEvw6nzxsQnyBAf8gOQjY5HY1VBIwxK8GKhpjOM=;
 b=bCbz5PkW1B7NcfF0j6AxR4kAmSH6ouDMr9KnUL0p3S7RsOX6SbzLryYyoMU9NtobazzqLMmohqQlrspss+WeXaGCVQTt+5J4rioWl+ouzrygsmrWWn3HnqqKf/fl1Dt1QhNZZMLSjNnSsePzlV5EAdtFCvRCTVUA4usNx6XRD/A=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.22; Wed, 14 Jul
 2021 19:00:26 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::8cb6:59d6:24d0:4dc3%9]) with mapi id 15.20.4331.021; Wed, 14 Jul 2021
 19:00:26 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH V2] drm/amdgpu/display: add support for multiple backlights
Date: Wed, 14 Jul 2021 15:00:12 -0400
Message-Id: <20210714190012.1169489-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
X-ClientProxiedBy: BL1PR13CA0104.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::19) To BL1PR12MB5144.namprd12.prod.outlook.com
 (2603:10b6:208:316::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BL1PR13CA0104.namprd13.prod.outlook.com (2603:10b6:208:2b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Wed, 14 Jul 2021 19:00:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 179dcc26-55f8-4484-7e22-08d946f9a432
X-MS-TrafficTypeDiagnostic: BL1PR12MB5237:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5237FBFC69FC8C4C06597A6FF7139@BL1PR12MB5237.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:181;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9809iAyQAzcYwO3i4e2u1LpnoFPaI1/josfTDSu0H3tcoZdrwzmbeXQ2iiyY46oFz/uyyZaGPOvpd5pfbZL+ZgviUFeriLzQjs+sZaU48okygXLnuhgNT99DFuIsPb5EDieTV9+58HAVQ62Ygg9VfYWWUfINAEiHNsYF85uyYQvLV1cakBKmBsfx4XqPhvno0V86faKfUnLqB05DtkwUZdykaZnu8x+D8jLO4vfectfB/wf7wUvYUONnyKORf5g/p86kaXYmWr6i7arM5Ab5R9Qvr3rRJDDggo12DEHoCJ5Kpv+yR6pXAwq2Z5RH8qO6L2gE2KTGdYoePvBTZBRz2sHtoc8wpYpe1d0mEwt1QIyKQpiAaLBnwqUPQThMcWioQyynVNWHe7KbYu7luKKoY1jUsHJlxNSfHZ2lDfhbeYyz6qUJCSMsmOTHjvv+Yasd3aX88QAwgYUYvG5Qzbrt/SRkyl0c1Iy1bdMqQgSmQ8M4XPHIGWFCNLGJxN+PGrH2WS7vc99wi/YKn6pGaLUoDhypM5XZ2TV1v8ELjulO/xv0qdSeL0NebNgWX+c0iDeoQL4S+bZ/J97P0WrYghJa8oIperjQPQqGfpdiPal9ZouT+TEgJPSCSey9+EU8gat+ifxchS8IMtYADI1m4tjdyQJA4NWDqtpn+WfoFc1L72011FshVO76jsdntjAjNbWUM8Bi/EQ1NMElRWLh72kWlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(6512007)(66946007)(54906003)(38100700002)(6506007)(30864003)(8676002)(478600001)(36756003)(66556008)(86362001)(66476007)(186003)(6916009)(2906002)(38350700002)(6666004)(5660300002)(83380400001)(316002)(4326008)(8936002)(956004)(1076003)(2616005)(26005)(52116002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SFyfGAF0EoJ1i8ojDpOXPPkNPsUMuOVgyG1hAgmt2P17xGMg5aFeNhtmehEd?=
 =?us-ascii?Q?3v5P6WVubKvJaLtC+RGlzqATOYSZABTpWGSAs4SP5YVwDNLHs6WnUUxSWi67?=
 =?us-ascii?Q?C0zQr8Chw8pzJtEUoL6lGZ5IMcr7R2lbs+pu011NcrjUsmTij9SaKu/78Uh+?=
 =?us-ascii?Q?wnsfRmocf+VwWX24ZtHk857+bnDtslFcClZ4uAV+4hPJnL6LMWtQVjWDUSsf?=
 =?us-ascii?Q?x99QF7C/6eMqJHiW63po512UYyb6Y6ix2omUTw3XK3cP8SU9wJ+Rh5iXUj4K?=
 =?us-ascii?Q?IjYZoAQE0TAYAJW5CkfbHHZqbUq2pugqTMxbH7xNuZFkPXqzMUTufU1hhNLS?=
 =?us-ascii?Q?DlnwuY9cJM5pVW+QmnBAEng7jkYaftELyJbTGMu6EE22G8acR2wONn6UwKjq?=
 =?us-ascii?Q?s7sOySQ2TobiRTIsS9Hl83aD9KOEONd+3LXJinVSRAWfgtWqmaAYaV1UFFZP?=
 =?us-ascii?Q?kdfUXY1H94ElpnoZv67aVPy9l3wmQDLeNG7yoDLrk4Q1bttI3+JVuvLZvwrg?=
 =?us-ascii?Q?bL2q7RVxqdR0Hm2YW391F+EoNRLDiu42qqPnWoo7uKOX1GQ4Ol1okqDqRIO9?=
 =?us-ascii?Q?RQ4onm8kr4Cr4ccUDdzjCOuzoBsNeJx5okkGAuyczGdAqQO722Q0I33d1YVW?=
 =?us-ascii?Q?zk/kpb+AEF/zDvNwHlBX3QRc1ExnTC/eSitI8l7oogJy2PVUiGcQczy5bP4t?=
 =?us-ascii?Q?ZtI0wAvFwF5Q60NzxMy88QbICUNF3DPyIyUS8KEplukznrVzfngSTlwK7vBd?=
 =?us-ascii?Q?24YRCkLJ9at6DQjKZ4NZGs723ejjv3AMveLnwIGwjpf3aSzhSs8zV5XBBanO?=
 =?us-ascii?Q?lKoDf8xcp1J23eky+V0qgsqBhfkUfPsRpNZ6jWhgNIy7OT4yT8OOClKpsd4M?=
 =?us-ascii?Q?5tUwD59ZsUUp4m+QEPkDBKbmo/lOQKnHfvnReVl6eoEsgdpO++QlPxx06eo1?=
 =?us-ascii?Q?3kwqS6sFqIs6N6T742xV9D9dq+tAUkdq3TfaL8lnnkSROhgyqn9kXJbPUk+n?=
 =?us-ascii?Q?717GMLQrVmAY1zFZX3/k/U9iZOxUm/hJ4wUDFJozSJ1lOf19M4eLUwtY7XTC?=
 =?us-ascii?Q?fvDM2UAHJwUxU79UnSM5jeYyL9rO+KhvRUb6YMv1dhqY37TJZzbhVWfbbXIX?=
 =?us-ascii?Q?6Wzx00+k+lQZ5jmBKzbHGdHZkCSGs4nFnosf8M0863KAgTGhQTtuaSfAoXck?=
 =?us-ascii?Q?7/0TphEZw995n6BSy4Oq780zMjkMcH7b74TSyfPbXaSLMX9whghU9xlmt0JU?=
 =?us-ascii?Q?QES5E2ZCXGyICX/vC0frt4rHAXCSNfSmxM/nQGn989nF/F+h1l3SUqk9v+gt?=
 =?us-ascii?Q?bn/Fh8ryIrmiv4nIRnvcWxKw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179dcc26-55f8-4484-7e22-08d946f9a432
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 19:00:26.6653 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhvFTr8yjd76wx08wiSeXU54TgBz3jEd8HVo2R5/P2XgWi9Sbvv4S6ao46TMs5OJ1ew3m7ViQhTGHKwVgkUOEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5237
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
Cc: Alex Deucher <alexander.deucher@amd.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On platforms that support multiple backlights, register
each one separately.  This lets us manage them independently
rather than registering a single backlight and applying the
same settings to both.

v2: fix typo:
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c      |   4 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 147 ++++++++++--------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +-
 3 files changed, 84 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 59373c697b00..9122dcf42c46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -854,8 +854,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		if (amdgpu_device_has_dc_support(adev)) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
-			if (dm->backlight_dev)
-				atif->bd = dm->backlight_dev;
+			if (dm->backlight_dev[0])
+				atif->bd = dm->backlight_dev[0];
 #endif
 		} else {
 			struct drm_encoder *tmp;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5cdb0e75d36b..2d48bb09645f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2412,6 +2412,7 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	static const u8 pre_computed_values[] = {
 		50, 51, 52, 53, 55, 56, 57, 58, 59, 61, 62, 63, 65, 66, 68, 69,
 		71, 72, 74, 75, 77, 79, 81, 82, 84, 86, 88, 90, 92, 94, 96, 98};
+	int i;
 
 	if (!aconnector || !aconnector->dc_link)
 		return;
@@ -2423,7 +2424,13 @@ static void update_connector_ext_caps(struct amdgpu_dm_connector *aconnector)
 	conn_base = &aconnector->base;
 	adev = drm_to_adev(conn_base->dev);
 	dm = &adev->dm;
-	caps = &dm->backlight_caps;
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (link == dm->backlight_link[i])
+			break;
+	}
+	if (i >= dm->num_of_edps)
+		return;
+	caps = &dm->backlight_caps[i];
 	caps->ext_caps = &aconnector->dc_link->dpcd_sink_ext_caps;
 	caps->aux_support = false;
 	max_cll = conn_base->hdr_sink_metadata.hdmi_type1.max_cll;
@@ -3423,35 +3430,36 @@ static int amdgpu_dm_mode_config_init(struct amdgpu_device *adev)
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 
-static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm)
+static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
+					    int bl_idx)
 {
 #if defined(CONFIG_ACPI)
 	struct amdgpu_dm_backlight_caps caps;
 
 	memset(&caps, 0, sizeof(caps));
 
-	if (dm->backlight_caps.caps_valid)
+	if (dm->backlight_caps[bl_idx].caps_valid)
 		return;
 
 	amdgpu_acpi_get_backlight_caps(&caps);
 	if (caps.caps_valid) {
-		dm->backlight_caps.caps_valid = true;
+		dm->backlight_caps[bl_idx].caps_valid = true;
 		if (caps.aux_support)
 			return;
-		dm->backlight_caps.min_input_signal = caps.min_input_signal;
-		dm->backlight_caps.max_input_signal = caps.max_input_signal;
+		dm->backlight_caps[bl_idx].min_input_signal = caps.min_input_signal;
+		dm->backlight_caps[bl_idx].max_input_signal = caps.max_input_signal;
 	} else {
-		dm->backlight_caps.min_input_signal =
+		dm->backlight_caps[bl_idx].min_input_signal =
 				AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-		dm->backlight_caps.max_input_signal =
+		dm->backlight_caps[bl_idx].max_input_signal =
 				AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 	}
 #else
-	if (dm->backlight_caps.aux_support)
+	if (dm->backlight_caps[bl_idx].aux_support)
 		return;
 
-	dm->backlight_caps.min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
-	dm->backlight_caps.max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+	dm->backlight_caps[bl_idx].min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
+	dm->backlight_caps[bl_idx].max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
 #endif
 }
 
@@ -3502,41 +3510,31 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
 }
 
 static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
+					 int bl_idx,
 					 u32 user_brightness)
 {
 	struct amdgpu_dm_backlight_caps caps;
-	struct dc_link *link[AMDGPU_DM_MAX_NUM_EDP];
-	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
+	struct dc_link *link;
+	u32 brightness;
 	bool rc;
-	int i;
 
-	amdgpu_dm_update_backlight_caps(dm);
-	caps = dm->backlight_caps;
+	amdgpu_dm_update_backlight_caps(dm, bl_idx);
+	caps = dm->backlight_caps[bl_idx];
 
-	for (i = 0; i < dm->num_of_edps; i++) {
-		dm->brightness[i] = user_brightness;
-		brightness[i] = convert_brightness_from_user(&caps, dm->brightness[i]);
-		link[i] = (struct dc_link *)dm->backlight_link[i];
-	}
+	dm->brightness[bl_idx] = user_brightness;
+	brightness = convert_brightness_from_user(&caps, dm->brightness[bl_idx]);
+	link = (struct dc_link *)dm->backlight_link[bl_idx];
 
 	/* Change brightness based on AUX property */
 	if (caps.aux_support) {
-		for (i = 0; i < dm->num_of_edps; i++) {
-			rc = dc_link_set_backlight_level_nits(link[i], true, brightness[i],
-				AUX_BL_DEFAULT_TRANSITION_TIME_MS);
-			if (!rc) {
-				DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", i);
-				break;
-			}
-		}
+		rc = dc_link_set_backlight_level_nits(link, true, brightness,
+						      AUX_BL_DEFAULT_TRANSITION_TIME_MS);
+		if (!rc)
+			DRM_DEBUG("DM: Failed to update backlight via AUX on eDP[%d]\n", bl_idx);
 	} else {
-		for (i = 0; i < dm->num_of_edps; i++) {
-			rc = dc_link_set_backlight_level(dm->backlight_link[i], brightness[i], 0);
-			if (!rc) {
-				DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", i);
-				break;
-			}
-		}
+		rc = dc_link_set_backlight_level(link, brightness, 0);
+		if (!rc)
+			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
 	}
 
 	return rc ? 0 : 1;
@@ -3545,33 +3543,41 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
 static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
+	int i;
 
-	amdgpu_dm_backlight_set_level(dm, bd->props.brightness);
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (bd == dm->backlight_dev[i])
+			break;
+	}
+	if (i >= AMDGPU_DM_MAX_NUM_EDP)
+		i = 0;
+	amdgpu_dm_backlight_set_level(dm, i, bd->props.brightness);
 
 	return 0;
 }
 
-static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm)
+static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm,
+					 int bl_idx)
 {
 	struct amdgpu_dm_backlight_caps caps;
+	struct dc_link *link = (struct dc_link *)dm->backlight_link[bl_idx];
 
-	amdgpu_dm_update_backlight_caps(dm);
-	caps = dm->backlight_caps;
+	amdgpu_dm_update_backlight_caps(dm, bl_idx);
+	caps = dm->backlight_caps[bl_idx];
 
 	if (caps.aux_support) {
-		struct dc_link *link = (struct dc_link *)dm->backlight_link[0];
 		u32 avg, peak;
 		bool rc;
 
 		rc = dc_link_get_backlight_level_nits(link, &avg, &peak);
 		if (!rc)
-			return dm->brightness[0];
+			return dm->brightness[bl_idx];
 		return convert_brightness_to_user(&caps, avg);
 	} else {
-		int ret = dc_link_get_backlight_level(dm->backlight_link[0]);
+		int ret = dc_link_get_backlight_level(link);
 
 		if (ret == DC_ERROR_UNEXPECTED)
-			return dm->brightness[0];
+			return dm->brightness[bl_idx];
 		return convert_brightness_to_user(&caps, ret);
 	}
 }
@@ -3579,8 +3585,15 @@ static u32 amdgpu_dm_backlight_get_level(struct amdgpu_display_manager *dm)
 static int amdgpu_dm_backlight_get_brightness(struct backlight_device *bd)
 {
 	struct amdgpu_display_manager *dm = bl_get_data(bd);
+	int i;
 
-	return amdgpu_dm_backlight_get_level(dm);
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (bd == dm->backlight_dev[i])
+			break;
+	}
+	if (i >= AMDGPU_DM_MAX_NUM_EDP)
+		i = 0;
+	return amdgpu_dm_backlight_get_level(dm, i);
 }
 
 static const struct backlight_ops amdgpu_dm_backlight_ops = {
@@ -3594,31 +3607,28 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
 {
 	char bl_name[16];
 	struct backlight_properties props = { 0 };
-	int i;
 
-	amdgpu_dm_update_backlight_caps(dm);
-	for (i = 0; i < dm->num_of_edps; i++)
-		dm->brightness[i] = AMDGPU_MAX_BL_LEVEL;
+	amdgpu_dm_update_backlight_caps(dm, dm->num_of_edps);
+	dm->brightness[dm->num_of_edps] = AMDGPU_MAX_BL_LEVEL;
 
 	props.max_brightness = AMDGPU_MAX_BL_LEVEL;
 	props.brightness = AMDGPU_MAX_BL_LEVEL;
 	props.type = BACKLIGHT_RAW;
 
 	snprintf(bl_name, sizeof(bl_name), "amdgpu_bl%d",
-		 adev_to_drm(dm->adev)->primary->index);
+		 adev_to_drm(dm->adev)->primary->index + dm->num_of_edps);
 
-	dm->backlight_dev = backlight_device_register(bl_name,
-						      adev_to_drm(dm->adev)->dev,
-						      dm,
-						      &amdgpu_dm_backlight_ops,
-						      &props);
+	dm->backlight_dev[dm->num_of_edps] = backlight_device_register(bl_name,
+								       adev_to_drm(dm->adev)->dev,
+								       dm,
+								       &amdgpu_dm_backlight_ops,
+								       &props);
 
-	if (IS_ERR(dm->backlight_dev))
+	if (IS_ERR(dm->backlight_dev[dm->num_of_edps]))
 		DRM_ERROR("DM: Backlight registration failed!\n");
 	else
 		DRM_DEBUG_DRIVER("DM: Registered Backlight device: %s\n", bl_name);
 }
-
 #endif
 
 static int initialize_plane(struct amdgpu_display_manager *dm,
@@ -3675,10 +3685,10 @@ static void register_backlight_device(struct amdgpu_display_manager *dm,
 		 * DM initialization because not having a backlight control
 		 * is better then a black screen.
 		 */
-		if (!dm->backlight_dev)
+		if (!dm->backlight_dev[dm->num_of_edps])
 			amdgpu_dm_register_backlight_device(dm);
 
-		if (dm->backlight_dev) {
+		if (dm->backlight_dev[dm->num_of_edps]) {
 			dm->backlight_link[dm->num_of_edps] = link;
 			dm->num_of_edps++;
 		}
@@ -6198,6 +6208,7 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 	const struct dc_link *link = aconnector->dc_link;
 	struct amdgpu_device *adev = drm_to_adev(connector->dev);
 	struct amdgpu_display_manager *dm = &adev->dm;
+	int i;
 
 	/*
 	 * Call only if mst_mgr was iniitalized before since it's not done
@@ -6208,12 +6219,11 @@ static void amdgpu_dm_connector_destroy(struct drm_connector *connector)
 
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
-
-	if ((link->connector_signal & (SIGNAL_TYPE_EDP | SIGNAL_TYPE_LVDS)) &&
-	    link->type != dc_connection_none &&
-	    dm->backlight_dev) {
-		backlight_device_unregister(dm->backlight_dev);
-		dm->backlight_dev = NULL;
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if ((link == dm->backlight_link[i]) && dm->backlight_dev[i]) {
+			backlight_device_unregister(dm->backlight_dev[i]);
+			dm->backlight_dev[i] = NULL;
+		}
 	}
 #endif
 
@@ -9191,8 +9201,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 #if defined(CONFIG_BACKLIGHT_CLASS_DEVICE) ||		\
 	defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE)
 	/* restore the backlight level */
-	if (dm->backlight_dev && (amdgpu_dm_backlight_get_level(dm) != dm->brightness[0]))
-		amdgpu_dm_backlight_set_level(dm, dm->brightness[0]);
+	for (i = 0; i < dm->num_of_edps; i++) {
+		if (dm->backlight_dev[i] &&
+		    (amdgpu_dm_backlight_get_level(dm, i) != dm->brightness[i]))
+			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
+	}
 #endif
 	/*
 	 * send vblank event on all events not handled in flip and
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 9522d4ca299e..ab1670b16b02 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -365,13 +365,13 @@ struct amdgpu_display_manager {
 
 	spinlock_t irq_handler_list_table_lock;
 
-	struct backlight_device *backlight_dev;
+	struct backlight_device *backlight_dev[AMDGPU_DM_MAX_NUM_EDP];
 
 	const struct dc_link *backlight_link[AMDGPU_DM_MAX_NUM_EDP];
 
 	uint8_t num_of_edps;
 
-	struct amdgpu_dm_backlight_caps backlight_caps;
+	struct amdgpu_dm_backlight_caps backlight_caps[AMDGPU_DM_MAX_NUM_EDP];
 
 	struct mod_freesync *freesync_module;
 #ifdef CONFIG_DRM_AMD_DC_HDCP
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
