Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF15AC88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 06:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7057E10E1DD;
	Tue, 15 Sep 2026 06:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YU4GLd9i";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012036.outbound.protection.outlook.com [52.101.48.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F45910E1DD
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 06:41:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KE14cu1WyqQz7TZcq8wWqB2ceckpcmW1ZzoavJguOrEiRojrt35+v/274NFjvxzYjnCkGrf1+1Qa3Kuxw6GRYUQRo9wDB/uCsq/Y9L5gO5RIHgpPe59Iv+CIp59zo2CbW9I2YcfLTcoCrZ4jpadWn/7qyN7YMwjY8qk/UVBFnvPxiOeyN2K+f7t2qcrWBQS/AF6p4gH6TcXCnFjLXfJGDrluqbzxs2T3MRTKyolImQWB8h3nUV89uo39EGExPgnBG73grhdu69hWxkm1pxJB7GBxOGBzlHXhdgvbn+6RlaNBh8Ep7Z7iUFdT2p+yK7mVOAhlAR4FhmzcDy97hNOR9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1HKBDZb8Y1/Vg3fMPHj1Kmwd9NhoKlPbVpdKOvLh2U=;
 b=x+Oozwkt38dGz241oT04NhR+k85l2itSjLywq5uvHqEpRTpUyWjSEv3hgLta/EHpDMnaQHH0UFFp6X9LO+pl3Ef8hU8Tmz40dUB3+euiaA2xQQ8Gf365nyvXD+Ek+Ey+ypFjlVPoqIw3ewrNyfYrgCbQjOvqocNtG9DeOL9qZu2GjJAwIdMzTHysO5YUwkOYIXAP1mTrZ/r8bchWyK04OJi/Vd0SGXQDNowIeE9PmK2AL8fVF8/X4Fj/bddAUFMUbOfnU+Es67Gxti3RgMTMC17rqG8rnPkXPMazVbK1Rq2f2crEHsWNFj0MB1SF+bZQsNdV/DNsSOkIFDfe0zIJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1HKBDZb8Y1/Vg3fMPHj1Kmwd9NhoKlPbVpdKOvLh2U=;
 b=YU4GLd9iKnnTMo92Z916Q8msQwh8wHTXJVxCFnU6hDsiC9AjEhEabGovOddCXBuNg7pszuEfBtmcWXS0wY9YVhZ0SBPhrTrhhN5utoBtLKnZ/rnLT1/sbcCd7EigLM2VqdvPTtbVYf2+3BYthYSXPnIw7kBR/DUtS5DZGdBCAgs=
Received: from BY1P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::9)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 06:41:33 +0000
Received: from SJ1PEPF000037B9.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::91) by BY1P220CA0024.outlook.office365.com
 (2603:10b6:a03:5c3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 06:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037B9.mail.protection.outlook.com (10.167.244.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 06:41:33 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 01:41:30 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Lijo Lazar
 <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH] drm/amdgpu: Fix NULL dereference in
 amdgpu_ualink_info_set_accel_state
Date: Tue, 15 Sep 2026 12:11:12 +0530
Message-ID: <20260915064113.454895-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037B9:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c867a93-6fff-4004-772f-08df12f461cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: oAPduKpJ7npnF2e1ioPGGtD2bhVklBXv7Z/y2hfsFpAQ0GANsr07raqyPkkatfbb6KL7zDba3NFjy/fUSRc48WCrjWgy0r1fR71pJU0i+1EFkiCCS500RGdaapeAdhzGxFIlgl5Wqczi/Oun3w5nP9zfgRWX47eyixxLsGueUn3njJ5A0CEdZ15mVm440mvTr1nsVyjb6Z3peNHdzJd+AB0Bhifa+T5Ih7JwbVWA7PKpK+S4TYpGlGKyIcsRlLDx+15SQhMgK0+cohHLOO7rYRpi5/pt0SXoxOuEKQ8INApLTtFx/y+Maup3diIvLHu2zhptqSX8g6h3yIppVv7M1+zHSleFVGzEhhztL27Kj2Mq8lUNetUTdIC5YmAoPLzfy0zQBgeO8bvtDf0WBZLtTvTPAKdnpSX3yq0VkN6BMQ76Xnw2f8qwoa96sFmEO/ZvQhMeBQoy20nWHtj5xePzuhgGtMu42lFpW9R46y7RAA3hRMWZx1kZ8KTiwafF3hKh2XVja7LJgMGBPZjgGDra7XmAN3o4ILfGy9s2SNw60tDvOruJZu4o52MfKSCx6WeZL6sSDXbP80fJ5Pt8ei2+l5D7iujvBgAiQj/oKq9tGG1pL1AA3dnGppLq0v1dcjKwHc7UM6RvaIH/uKr6tQ3Ix0MYpyRVTMMe+/7LgwDOl5aQr8HUoD4pUzTgPjvQA7QQeRlW1+qJWC83Amp8mmaTKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 27TAtPopJ9O7s/5+0A/TQ9qp5YVsSJe/c6Xl5fi/hTCdRqx9A1KtW6FaXmCFrsxBFHRaOGQaDHODmr0PYOx10vTceAGLtoWzVcErKon9KSOPZDCtCZLPxX8bVWBPREFLyMQuYoAjhaO7FJBaWv/D5EWAHu6xFvG6buntDsn9u8rLV5r4PNnwYE2uWuIujJJXGoSgdvfu6X1cZnlW83vvM9gCm1klS08N3WB7/WPqM5Elx7Ca2YVNmbz9Us46JQBGCd9j867xyOeQR7oUHh+maIFwSpClOzdfeBK2S8USoL5CYGDz0K9ECwD2QNdmgL6h1jqtQadvW6U5zKTn8yT6748ombZKCX8E8l21F/ZcBn7HR6B+gGnvjYRqnu9pWlaNSGeb+S/DVsYDQyAvbcPCfCDVP4VdwIcSiwSXV37FyEJGi2mYopJZCyRwYEI7XboF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:41:33.1203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c867a93-6fff-4004-772f-08df12f461cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037B9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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

Commit bb2545b351c3 ("drm/amdgpu: Improve ualink state transitions")
introduced an access to info->accel_state before checking whether info
is NULL.

Move the access after the NULL check to avoid a potential NULL pointer
dereference.

Fixes: bb2545b351c3 ("drm/amdgpu: Improve ualink state transitions")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f4a4432c2c5d..3b0d5138a349 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -161,7 +161,7 @@ amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
 				   struct amdgpu_ualink_info *info,
 				   enum psp_gfx_ual_config_state cfg_state)
 {
-	enum amdgpu_ualink_accel_state cur = info->accel_state;
+	enum amdgpu_ualink_accel_state cur;
 	enum amdgpu_ualink_accel_state target;
 	bool ppod_validated;
 	bool vpod_validated;
@@ -169,6 +169,8 @@ amdgpu_ualink_info_set_accel_state(struct amdgpu_device *adev,
 	if (!info)
 		return;
 
+	cur = info->accel_state;
+
 	ppod_validated = cur >= AMDGPU_UALINK_ACCEL_STATE_PPOD_CONFIGURED &&
 			 cur <= AMDGPU_UALINK_ACCEL_STATE_ACTIVE;
 	vpod_validated = cur >= AMDGPU_UALINK_ACCEL_STATE_VPOD_CONFIGURED &&
-- 
2.34.1

