Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232B5CA5FC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 16:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9562B10E2CC;
	Wed, 30 Sep 2026 16:28:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ukNRAyl8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2372D10E0F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 16:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkHS+++K4ucGN0WoNmyysHmpL48Ho1yBem1GQyDK9WSuea6xUhVRUrF1PDBQH/8d27lZ8OeDGRYMwHD7gArYKVkaxkwfJp+9iOjIMbeidCB9KH1H0pQT9MNUMSKhF1nNQE1PG0PuykLhr0PDW57DStOZMMvpQ02XkIW79PS7m8k8OQGyZoInBSoQB8bShGinvFOMs83nUe9aMdERxJZVKlQv8+0VO6aBX+LYaLdgyg0HMyp5jPGP6DGc4PEyC+5K4wTb8beaRxOsvbpfPtpk8tmeYaj6NNWDDug5pSeO0uspyTu48wj9QC3KQl6WvoGwKvRY+e+4JHqpFBFiMZw/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jF9MlzgK32aCb8G18vcTpEb9dSSkzf4r6022qdcQB58=;
 b=Z1ZzArz03PR4Drtd1XSnHvCulca3Sa8S/OE7fSgK0W3fHxVQf/bmDsCko9OTR13JXPxMCd8Kb3XEcvypbT+gt1EhogNxG4YzUsmLygZYpXK38BikLxFd9GbrWpKCmnId1RRSTWC0hWnGYwen/e2TCN0yImYI2wV4XjZ2R+pTK2eTE54yDZ2eYxtjTga1rZEFOAuCMT/gbpgyERfq95laYKvL2Q01MkbeX4wemCQSVn6AVykCFKFJ3Q437b++0QmOk3UBHPZjKbpKV2BsTBZ6yTAwOe5po+7LMDTsU9+6hrYOb003DjXODHs6dF+CSNkS5NuHq5b21pZ8PEBdfoF7sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF9MlzgK32aCb8G18vcTpEb9dSSkzf4r6022qdcQB58=;
 b=ukNRAyl8rFVZBx/1/sEtNKqxSxulZ0Cko8f2Uy/bEjb1JwYmbmBdbAY1lZ66NkDBGKXuVQk76G+k8DivCOsabx6j5XblsTfY8H64pA/7U+dEC9PN6vvIkHg9DCB+1EEVBbrPZvEycM1aFDKCQbpDdYhPS50H4jVaYGGd5AgfH+k=
Received: from BN9PR03CA0943.namprd03.prod.outlook.com (2603:10b6:408:108::18)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Wed, 30 Sep
 2026 16:28:17 +0000
Received: from BN2PEPF00004FC1.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::7a) by BN9PR03CA0943.outlook.office365.com
 (2603:10b6:408:108::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Wed,
 30 Sep 2026 16:28:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC1.mail.protection.outlook.com (10.167.243.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 16:28:16 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 11:28:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 11:28:14 -0500
Received: from flamewok (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server id 15.2.2562.49 via Frontend Transport;
 Wed, 30 Sep 2026 11:28:13 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <xaver.hugl@gmail.com>, <harry.wentland@amd.com>, <alex.hung@amd.com>, Leo
 Li <sunpeng.li@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amd/display: Fix direct scanout alpha on some DRM_FORMATs
Date: Wed, 30 Sep 2026 12:25:38 -0400
Message-ID: <20260930162803.555299-1-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC1:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: ff02da25-cd4d-4348-bba6-08df1f0fd4da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: BiKQ8mPzbDkrmmWNMeGMCOsxrpnK/TJ6c35ymBBIyDx2Gcw1AzXgBxKA8viJVxsZs8/z7hlGk6PKa59Q1nObX9PEdP4uun8SVaE/Hz+7lZ5p7BAb55skxa6tKccGW/KfvAH7mLXxMW6Kn4qpTtOR2V4zX5MiRcLSCAwXa/5XGjRxAalYwhenShFalq8BN1xNsWS8Xs87hG8jt7WYo83NGiZ58HHelIXSS30vMrtg9/oVr1VWe9vwHL9fqELZsBKR99hxjCxLFRQ0fP9pQZ265IsuelVlh5T8FEi/RD7N4ctk24dGn5PTavTzX/D/JS4zRHaxyKemG9L3DzqM0613hFRmmKK4VEaHFRvhHQcGjj5J5yBSwUk4mK9FbVku49gcWoZX1ixwHAEOvoj/145+RNmifVJcfN91r/14Eh0U6q0qNPO8xuOQV7rVopoRnRjZoJa9qnyXI/2625IxMQDkBNgzHbrIvbNWexv2nQLJeir7Ur0i+IXVoRil5p4zr20Vuh3KlCVn4fp81ZRlW0uqMgJRKPHovobozX6MOr3P4H2W/adkwDih1Grq9dOUrE9xiAmz243XH/8RpYGL+eVPsgbdo8ml2B/RHq+qaG43qwpr2IIvrJnOAGDjjsIgIq1KjR6p+P8W19BoaKmA+fxaZLCa+Fp4M2jQtlOqVHCD4Ay0fgIF4kxYn/8iLm+Us3iGj4XuxfW7cIupXSA2MGPyzA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: J5STgUi+7yhWZsEYqATPjZWFDvUICHYSmfkdOMfVfZJ+3sFJEfBdKzA4n6f+HdYfZbFrhIgtxFfmQbmZN9MCJE/cfrEp3NsulOJwpYDKgqig/626+1A9MagSFPNqXhINQNd4Yd3M9tcKkLJXX1CuMVzlrTh5SD2jp9wXcwlYB09hAEmuo1/XRvmnB95bLouv0nx8P2L6ymOLes6s5OzHH9x9dVziyarbH5NFEbqX/lbU3VcEoDXxweHeGMeqfIEScbG1Qc2OT/mfcRc+rsnnc2xugqKcQSumufrzplyU8eJ7XZ63U4jYUR0eDEXl9IP7AY29rZnyXSj87N3fzU1ENfIzPSTJRzmM85PK09tjKKRmoKz7kkXBjYLMVzNt0eESS1MBWnlDFpTanYWfJx6JpNWR6KJBh7mLBmz1aQPvpg+chtxBLOJE0wfNlvndNf1/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 16:28:16.5561 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff02da25-cd4d-4348-bba6-08df1f0fd4da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
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

DM was declaring it's own list of has_alpha DRM formats to check against
for enabling alpha blending, when the format->has_alpha already does
that for us.

The self-declared list missed some has_alpha formats, causing
direct-scanout planes with such formats to appear opaque.

[How]

Drop the self-declared list, instead use the format->has_alpha field
directly.

Cc: stable@vger.kernel.org
Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   | 20 +------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 0b5c4be1b3ec1..df6784d58c382 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -113,25 +113,7 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 
 	if (plane_state->pixel_blend_mode == DRM_MODE_BLEND_PREMULTI ||
 		plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE) {
-		static const uint32_t alpha_formats[] = {
-			DRM_FORMAT_ARGB8888,
-			DRM_FORMAT_RGBA8888,
-			DRM_FORMAT_ABGR8888,
-			DRM_FORMAT_ARGB2101010,
-			DRM_FORMAT_ABGR2101010,
-			DRM_FORMAT_ARGB16161616,
-			DRM_FORMAT_ABGR16161616,
-			DRM_FORMAT_ARGB16161616F,
-		};
-		uint32_t format = plane_state->fb->format->format;
-		unsigned int i;
-
-		for (i = 0; i < ARRAY_SIZE(alpha_formats); ++i) {
-			if (format == alpha_formats[i]) {
-				*per_pixel_alpha = true;
-				break;
-			}
-		}
+		*per_pixel_alpha = plane_state->fb->format->has_alpha;
 
 		if (*per_pixel_alpha && plane_state->pixel_blend_mode == DRM_MODE_BLEND_COVERAGE)
 			*pre_multiplied_alpha = false;
-- 
2.55.0

