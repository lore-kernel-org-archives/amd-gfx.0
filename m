Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6DD606A329
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T9wrq6TV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 469838933E;
	Wed,  4 Nov 2026 15:32:19 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013065.outbound.protection.outlook.com
 [40.93.196.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A376D10E168
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 15:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZRLbe6jztOQnTn8gmMm91xrSjkguBcCk9oL48B1/mLrac5KJeiGWVFI1VpsD10r30ug+8u4jrqaiCzqKZVnXNzI2eJ141J+XYAZfEDXi0XW3+7GTwpcgP4SEUhuXUDGo9Mzqzay8bUl7AeVcpeNPmhT/ZbSXMbNpc9mXVoyvCotvsaRl7Jj+M4eTw+mqeFN0zDa3lB236uM2C6IY1ewas4RY5XATkf/Zjcir+cxEdkoV+pJLdF3SnYlRrIAXXBxH3cC7Z9kj5ONChJ768PqbzqpxW+O0RCOYYL+biEsEwpug13OeLDQHVpLXyOIdKlOV1xQXGOpQihnfbnbhPqSXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uEQn7kAf+bsVQ6qb00ceAe8a/G38nZ59KHtQLDcCg/M=;
 b=dmb+3w+e0aZCjSqD2WhriTBfkVzzzWC80aWuzBfy12j7HYe8oIdRkt6t+WHG1iGBP8PIhJt158/8jWe47QQI4PNUMg0B1g4ONoa7G6p7RomC60LXYOVNtWtKIB87Us0NqDheYCKUdRkhhz+axPDRrW176UnQ8FsrPlKFHWMPztG4bWrM/mQjlA9SyRF28PG1ZNFI7G4AyWRbHepgvVKQtSd/Uf0PZhmnSqs+HG1aB/O7EH5WdskWmmudU49kTHdpgOgc5muvZJ6Zi3ZuB5XbSdZN2DvZ9GPDYvY5ztQsghwt/qlBCx7mJNDGdjMnkvK7EKIMBFTmhCCn7DHedVlT0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uEQn7kAf+bsVQ6qb00ceAe8a/G38nZ59KHtQLDcCg/M=;
 b=T9wrq6TVo2E8ZxIiY8e9TOQ8WH2HBVf/eU7lcZzdcseBFKTFN97KWgTErbHSNkwKkuYrJb3CtNCIP1+8zBgWTFul+RZzX9A92Rt+TkuRZFmEN1G/LcVWVrVPPiJ2FJAMLyd2xdwPfDimTNNgQITaxm0Y1qzsrkfD0CM+r/G6yCY=
Received: from MN2PR06CA0007.namprd06.prod.outlook.com (2603:10b6:208:23d::12)
 by PH8PR12MB6724.namprd12.prod.outlook.com (2603:10b6:510:1cf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 15:32:07 +0000
Received: from MN1PEPF00079400.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::15) by MN2PR06CA0007.outlook.office365.com
 (2603:10b6:208:23d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 15:32:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF00079400.mail.protection.outlook.com (10.167.249.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 15:32:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 09:32:05 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 09:32:05 -0600
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Wed, 4 Nov 2026 09:32:03 -0600
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>
CC: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 James Lin <pinglei.lin@amd.com>
Subject: [PATCH] drm/amdgpu: return cached hw vblank count when reset blocks
 the read
Date: Wed, 4 Nov 2026 05:13:00 +0800
Message-ID: <20261103211302.2899044-1-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF00079400:EE_|PH8PR12MB6724:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b23aeb2-39ff-43de-0855-08df3a88c825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|261009223027099003|261022105027099003|261026140227099003|11063799006|56012099006|261021123027099003|261026121527099003|261021121427099003|261102123227099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: LF0bRAl7EQSh9OWx5eLipiHAw3eigxsVWmE1jos4op74Kea0fRXJGfLQzTyQJClk8p/scwfOWCMiItO2hO/bDkvEOy4f7lGNBrNOyWkQF0H9ylndiho5JjHja9UHOkwYhIkK/rfSrQ63swwxk5oD+H9DSi7hMsopKNMDFzIHufm/2g4uZ2Pz9g4/NXcTWMwiJmBfcfYE+7yKjHiurgiDxFt1pHx2IltNrp0rWzBz12U5sZhykE/RWDVEpBns3ICUUh06BvLnRqGm9XNYW8/w2xLFDxGlX27ixzUgylkp0M7ePHTSeb63+ZJRsfOZ6mCIG4FMd9sXvx6b5HpBXIvIt3wJsxwi+YwUhahxBcJdWfogj9tG9zLBcK3XevCU87fZ8bN75f48RV9sMnVh8X3sIVUxc9BemQnjcPiKcmmcPuMnq87S5jo0Z/ZEHkTxXuqFFJT5HTPy+SBMNmIJsde0rtbjpJcnpHMXfalutMKBhz16ufYqbZaJn694+iFst85rzV5eJ2JNAH/IsA92XyFYB7o5pMRDFkovSKWuwDZu4zKubi1cHw8JubD3P87POubkH84+J89sKhIbDMn0TtEwET87Ac98InZMmoAACrYk5dd9DydvGwBYsT66jWcu7lXeGsvNoqI7Aj9mhV2xZRlIr5vCkB2wdEa09QRpc2AiAGjMmnNz0cMxEahL5cxNmXIO3imBa22ScwBTEC+mOVRDJQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(261009223027099003)(261022105027099003)(261026140227099003)(11063799006)(56012099006)(261021123027099003)(261026121527099003)(261021121427099003)(261102123227099003)(261028144727099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kj+U7daCLteKaLTzAIyWUhrbeRqh3aXNDxx7F/2u7DUTgq6hxX17nYPGeS66tkdlVKwbQB3JzTtMPZkPLo2bDjTdnN67i4a+g/b4qet4CMabijPbLBhCs9HJz0naYzSoPv2zNUCzAWzAZqdHuvALAJVhGEkQY9syKAxxUCj2B43FPUg37/G43ss/ApeXP9aKZqHVi+DA4shfcuvWff9dXAm4Wj+Y2fpiTo4dPkZxG+ZMRpPra/kWlA35c2OO4U62an3krppzTf31k+mzvcF/xoacpJHN81TCDPvI1XxHXBYW/HUMyauVe2igSkUPE8NkRfJf1UjYdn7MVPjEb7YcMunLiGu6sc7uz7Ws35XBumD5hKFRK7wk2vk/02JDGuqhXF1lRFiG7TWkRrkV4/UaJN1B4Xn5dLqCTrwlpttKbkxblivojW0UjuEUH4PIRTzc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 15:32:05.7242 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b23aeb2-39ff-43de-0855-08df3a88c825
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF00079400.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6724
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: James Lin <pinglei.lin@amd.com>

amdgpu_get_vblank_counter_kms() is DRM's hardware ->get_vblank_counter
callback, so drm_update_vblank_count() stores its return value into
vblank->last and derives diff = cur_vblank - vblank->last.

Commit f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads
against GPU reset") made the callback fall back to
drm_crtc_vblank_count() when the reset semaphore is held. That returns
DRM's software vblank count, which is a different numeric domain than
the hardware counter. It poisons vblank->last, so a later update hits
diff == 0 while cur_vblank != vblank->last and trips
drm_WARN_ON_ONCE() in drm_update_vblank_count(). Reset still succeeds,
but the WARN fails the mode1_reset dmesg check.

Return the cached hardware value vblank->last via drm_crtc_vblank_crtc()
instead, so the core sees "no new vblanks" and keeps its accounting
consistent. vblank->last is protected by drm_device.vbl_lock, already
held across this callback.

Fixes: f2bc71d16e73 ("drm/amdgpu: serialize vblank counter reads against GPU reset")
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 14a72a406d37..365b4fc86a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1699,9 +1699,18 @@ u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc)
 		DRM_ERROR("Invalid crtc %u\n", pipe);
 		return -EINVAL;
 	}
-	if (!down_read_trylock(&adev->reset_domain->sem))
-		return drm_crtc_vblank_count(crtc);
 
+	/*
+	 * A GPU reset is in progress and the display hardware cannot be read
+	 * safely. Return the hardware counter value DRM already cached rather
+	 * than the software vblank count: the core feeds this callback's
+	 * result back into vblank->last, and a software count lives in a
+	 * different numeric domain, which later trips
+	 * drm_WARN_ON_ONCE(cur_vblank != vblank->last) in
+	 * drm_update_vblank_count().
+	 */
+	if (!down_read_trylock(&adev->reset_domain->sem))
+		return drm_crtc_vblank_crtc(crtc)->last;
 
 	/* The hw increments its frame counter at start of vsync, not at start
 	 * of vblank, as is required by DRM core vblank counter handling.
-- 
2.43.0

