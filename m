Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59758C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jun 2022 16:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C381810F1D1;
	Thu,  2 Jun 2022 16:12:29 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2198E10F3C6
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jun 2022 16:12:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IiK5ZScj5QnbbRIr5QgTJxspMQo3nn6pwoVWfZniTQA1mTD9gKTMVoSWgE1H2XHsccTHSf6GBVECymrg55K/nOhHqi5JDQVBq+9l5phDWwOkkrAH2+M6IUehwiNSan2ov4GvdXc0j918aVh63DK4Tkp0MwAlLF8Hr4iAnmjU9buxLtbbc/q7Vf9H+hFsMSoCp2Wd8aLLbmISSVu+udGF/vIVFyUqvGXgMsPAHSIxAol31wfD/+XHXHXUBHuSlPo7mUPDlAuZrQMCH8VzF6jwiqAbbmpveKnNKG3stHLGgJxxlebGtNiqyBCLeEg3yBRAbFk4Mc+VzVdd26YX+xUTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZ0XD3ns64enCk6/k6JC+ZwejYoyEwpFKaZN+MPRYc0=;
 b=b0MYyPadj6mZkplgbjrCeveVOd2QhC8348DKJV/7X+QCOM/Jh2W9F/L17C5obAYlDWXiVXhsnjjRXl13XQjFPYOJBlYPXaZybGNwgYUQ2nZyN5nZQH0S/Mw8CI+EW7rWT7K2susdgIy3+UC/yl+nO6B8h91QwRijcyi/UzL4lEUiPaW98NmTXY8KsF4Oi7lX+211wAnKK+E+3x9WKeaAolhw+Rjwa6IppboQtvufQPrG0aUMsrBS2IDmySsZMBjHd7+q3LqmN1rrAfQZYOJafgaAGrTf6L9Pckeuy7wBAECwRqqctLachvVEiWsD99M0XuOb+wRZBxE/m3zhv9WL7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZ0XD3ns64enCk6/k6JC+ZwejYoyEwpFKaZN+MPRYc0=;
 b=Rm+Fg5EH/vKR11CfuF1lFV6H9sAFVTr7YuDVDJN4khNg9t4tJztEqO+iznZ70OQwsRA5FPfccKrKUJnUl1wTSwLtvVWPKScun9eHnrVWasEUg2inQbnLEfeu77Vjx6AT4Ev6E3rKM333CyxnrpZN8FWcwzsRiyIXgg4QzcG76ZI=
Received: from BN0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:408:e6::19)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.17; Thu, 2 Jun
 2022 16:12:25 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::82) by BN0PR03CA0014.outlook.office365.com
 (2603:10b6:408:e6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Thu, 2 Jun 2022 16:12:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Thu, 2 Jun 2022 16:12:25 +0000
Received: from fedora.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 2 Jun
 2022 11:12:24 -0500
From: Luben Tuikov <luben.tuikov@amd.com>
To: <amd-gfx@lists.freedesktop.org>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: cleanup visible vram size handling
Date: Thu, 2 Jun 2022 12:12:10 -0400
Message-ID: <20220602161210.19380-4-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.36.1.74.g277cf0bc36
In-Reply-To: <20220602161210.19380-1-luben.tuikov@amd.com>
References: <20220602161210.19380-1-luben.tuikov@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85f59f53-1823-4755-9503-08da44b2aeed
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB321876D7A140EA2E6D33A02C99DE9@BN8PR12MB3218.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHZrB2jVZCKoCwsKkwWv/GSZiBnVK4HKfnHqfiRtIKZTBvP26tM8Ip/+MqO/20CIXpFyXhzPTRqTduRQ6FLRU1ajujahV2Xr0goe21veFP/ua/B2vNdxYEJy5TlRs2+vdj5XmNt8SQIUbguGoAnauhTzGeWz7V5Xu/QP6WHNgds4ZJdtLwmnJyWAweaWR1lgVlENrTJeroE0aoAebd5xr63M80Fw60F9x1txEXqJoryUo72mUUSjVz1uCcR0lYwFbZ75mG/kNgCvUgClbMGohDzEK7L0Nf/+DHxm8mM5leHRb60NaUS64/bwX5grNSFMe3LoU/QASn50A8v4X7VAUkNBKAV5ci/DpWVKTRFrnEixRbp+9Gt+tGhA3PtFwBblvgnr+6kGl08YdUv+C548GfODvAYONrM4pZamYNIeXRqVAL5YsneGoIQdwOOki83Nqq2J9db6ppiru5JXGVRvoPd3sCSbO1zsnDOpjROFCiMy1PQK+Yk/J7Vf+X/TkLCBhXCc9XPMFzka5sOveCu0mw407ymMXT1tlnUbOoe4s91JxJoTHNH8Xj4UFMueIuVbbhj7ZTzfcwMA52o376DWTRc7FQCocPTC31GzzWx9NLsZQfc2gbDVHPsx40jAn4pbW+4zkd91TpwL58Kya+CfzX1JKfbyxAhtKEO/6qdxcwNzyI8aQKNwnCHsZww+YDoDE4nOxuQ7nM5TFpa2I0sFOw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(6636002)(2616005)(44832011)(1076003)(2906002)(82310400005)(26005)(40460700003)(36756003)(110136005)(36860700001)(81166007)(70206006)(70586007)(316002)(86362001)(7696005)(356005)(8676002)(4326008)(336012)(6666004)(47076005)(426003)(66574015)(83380400001)(8936002)(508600001)(186003)(5660300002)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2022 16:12:25.5238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f59f53-1823-4755-9503-08da44b2aeed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
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
Cc: Luben Tuikov <luben.tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Christian König <christian.koenig@amd.com>

Centralize the limit handling and validation in one place instead
of spreading that around in different hw generations.

Signed-off-by: Christian König <christian.koenig@amd.com>
Acked-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 -------
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 3 ---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 3 ---
 6 files changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index aebc384531ac8f..689978dad1d58f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -201,6 +201,7 @@ uint64_t amdgpu_gmc_agp_addr(struct ttm_buffer_object *bo)
 void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 			      u64 base)
 {
+	uint64_t vis_limit = (uint64_t)amdgpu_vis_vram_limit << 20;
 	uint64_t limit = (uint64_t)amdgpu_vram_limit << 20;
 
 	mc->vram_start = base;
@@ -208,6 +209,12 @@ void amdgpu_gmc_vram_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc,
 	if (limit && limit < mc->real_vram_size)
 		mc->real_vram_size = limit;
 
+	if (vis_limit && vis_limit < mc->visible_vram_size)
+		mc->visible_vram_size = vis_limit;
+
+	if (mc->real_vram_size < mc->visible_vram_size)
+		mc->visible_vram_size = mc->real_vram_size;
+
 	if (mc->xgmi.num_physical_nodes == 0) {
 		mc->fb_start = mc->vram_start;
 		mc->fb_end = mc->vram_end;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index ba3221a25e7536..61006f9f9ed388 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1707,7 +1707,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 {
 	uint64_t gtt_size;
 	int r;
-	u64 vis_vram_limit;
 
 	mutex_init(&adev->mman.gtt_window_lock);
 
@@ -1730,12 +1729,6 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	/* Reduce size of CPU-visible VRAM if requested */
-	vis_vram_limit = (u64)amdgpu_vis_vram_limit * 1024 * 1024;
-	if (amdgpu_vis_vram_limit > 0 &&
-	    vis_vram_limit <= adev->gmc.visible_vram_size)
-		adev->gmc.visible_vram_size = vis_vram_limit;
-
 	/* Change the size here instead of the init above so only lpfn is affected */
 	amdgpu_ttm_set_buffer_funcs_status(adev, false);
 #ifdef CONFIG_64BIT
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9077dfccaf3cf9..851f415f2dba61 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -827,10 +827,7 @@ static int gmc_v10_0_mc_init(struct amdgpu_device *adev)
 	}
 #endif
 
-	/* In case the PCI BAR is larger than the actual amount of vram */
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
-	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
-		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
 	if (amdgpu_gart_size == -1)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index b309f3ab2917c3..0b95afececdc2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -389,10 +389,7 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 	}
 #endif
 
-	/* In case the PCI BAR is larger than the actual amount of vram */
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
-	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
-		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
 	if (amdgpu_gart_size == -1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 24a256cfd7ceb9..8256795f66461a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -587,10 +587,7 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	}
 #endif
 
-	/* In case the PCI BAR is larger than the actual amount of vram */
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
-	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
-		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
 	if (amdgpu_gart_size == -1) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 22761a3bb8181e..e246c999b44acd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1467,10 +1467,7 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	}
 
 #endif
-	/* In case the PCI BAR is larger than the actual amount of vram */
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
-	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
-		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
 	if (amdgpu_gart_size == -1) {
-- 
2.36.1.74.g277cf0bc36

