Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D7FCD54BE
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 19:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5C8A10E31C;
	Mon, 25 Sep 2023 19:52:52 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F117110E31C
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 19:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgCD82hCvfz7ARcFFLQn4xTHyvJ2PIwAxFgMBdIMT7WVZXs87w5CrogFWliZMU139M/1QX5V9+RxNaOUDp1mjudYh32bS0mkOiiluKsE+F7yaWH4xcgvMUKkWt1dtG3TOmNeyyfP5P2lF5diqQHCrT4zSjicopDTFtN3rhxhhRLVTBDMbv4dwN9qCAIec7/Df6As3Wl2BakJrYxWbf0tBh+EbPq3W9qSn8ROceFLDYKEictuynnpKKnpz/OewmQgbKRiX8pCMst/Z9WYNe/+kf3ZBun7RN4805xF9im5oeKh7Nuf3ThFoALkH9a7IpZB6zZeuXVSaqmu/VRjB4Z8Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW9BE2srO7smII1OOjdvOQKlGtzuFYxI4yWsUl3yuNA=;
 b=m60O8tpUTY8xvTNn+UkwTKxdP5GJSzPtz+kcogJ90icQ7a+IH889xxshaKzcblApqzmmnYlOzwu95LngitH36YtECD3qlJihQRGITvIp3UmWVBcfflN3NbZz8VgZc1Z5QgVA2r3unnrNsznKCj2VPnyLClg3E6JJWBIUkgDz/JJZeCSrdR6OpcvoPiVbj8OM7ZHhFE7VDSeM4VAQLSxfPGrFog0/rI9pDW+l/tpqUOvUCqoUsr1EyXIV39hGMuhOVbqPnoP1Xv7fOZHXdW+NYLfTkTk0ZpnMwRRutLuM2b2beBOIsxA6vVr+4JTBIUazYBr9UY7yvvyNQFLkO2421A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW9BE2srO7smII1OOjdvOQKlGtzuFYxI4yWsUl3yuNA=;
 b=0S9wElZZ5U4YW2OmHQwx/0BHVY77hFXq/WRSIh9KlJUQdCuayF+QeatJIuorwsdgvB1tRSS8VLVMedP0+dgBBnPasP3KTezehR9ytRyvinfEhN8eX8tGRiB4H3M6uu70tBx00vvLEgwCiRF/IGIv814TGij8ZwnLqxd1z8WPCGE=
Received: from SJ0PR13CA0123.namprd13.prod.outlook.com (2603:10b6:a03:2c6::8)
 by SN7PR12MB6815.namprd12.prod.outlook.com (2603:10b6:806:265::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Mon, 25 Sep
 2023 19:52:49 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::f4) by SJ0PR13CA0123.outlook.office365.com
 (2603:10b6:a03:2c6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9 via Frontend
 Transport; Mon, 25 Sep 2023 19:52:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.17 via Frontend Transport; Mon, 25 Sep 2023 19:52:48 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 25 Sep
 2023 14:52:41 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/8] drm/amd: Drop error message about failing to load SDMA
 firmware
Date: Mon, 25 Sep 2023 14:52:01 -0500
Message-ID: <20230925195207.124850-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925195207.124850-1-mario.limonciello@amd.com>
References: <20230925195207.124850-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|SN7PR12MB6815:EE_
X-MS-Office365-Filtering-Correlation-Id: 586c20a5-41c8-404f-274a-08dbbe00feb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DbvXikJANKL8Uz3cJKqyAcsnG0OSMSrnHyIxmSrDlo9gSpwVJCZ/Lcu/X4W4Ece5QkaSrwF/VjDrIlWDZpt/w0ztK1qdXrikd+KtzLnLZ49qnm8ZpUMvz1U1tRxfRnqdNnKeFclBggSeCTL+fwFs2cBinR1pxaQJJ5X7aQ9CqezhXoi0soBlKgjVtqgc3dzAiIGMQCOvWTKsNdS48yrFcUHNrQ6oxfEpBCYQMiDy1XyJ2bARYl0xmcPMisPXsyWw/2dcw20I+uN4gPnrJkmERxz4esstl4QF3xF+L8A3g8x+YjGC9XOA0W4P+q2Growdt+HBfnf4BARAwZp2NKUUipNuNKi+X8PrnpWAJUMqGFlzdyNyeU5e9/OQUC5LRRXKKgBiFsIM+L1OSTpx1q+1jwtMgwlVldXQGkSMNlSJIUf2AP1bFqhjhu+hxOgmn21Mnf75kCZ+qecCvvNfYT5PbqFZ0TrHIwgsDGRpYcPO38gI98O6Fg9qVMRs32MjAO1SW7HAbvHimPT2P1thF0qpH15Dg49IOLym7+RCxaHnhrWhzyCvi1EVXHbLeekhOqO1jC3kCbNtWu+UZXq1MGMDzqwSBVIR/NxS19s3vVly6ZtfHtmfhJVOy9PllU8Y76Srtl41msY70FOl/iMpYfkl49UIGvbrmAIz7JodV22PKSbT8u5NM+wvrM96WLq1E0+sOEaRiJBZ99uJ1XwFqLf0cz+i6YVWrsc8Anuq/DVWmRLkzC2U56wNZg5BFUBgjqveWf12CbactsJUqG3dQ5qUuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(82310400011)(1800799009)(451199024)(186009)(46966006)(40470700004)(36840700001)(336012)(8676002)(26005)(83380400001)(7696005)(6666004)(2616005)(47076005)(44832011)(426003)(41300700001)(40460700003)(70586007)(316002)(70206006)(86362001)(1076003)(4326008)(6916009)(5660300002)(8936002)(2906002)(16526019)(81166007)(36756003)(356005)(82740400003)(36860700001)(40480700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 19:52:48.3860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 586c20a5-41c8-404f-274a-08dbbe00feb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6815
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The error path for SDMA firmware loading is unnecessarily noisy.
When a firmware is missing 3 errors show up:
```
amdgpu 0000:07:00.0: Direct firmware load for amdgpu/green_sardine_sdma.bin failed with error -2
[drm:sdma_v4_0_early_init [amdgpu]] *ERROR* Failed to load sdma firmware!
[drm:amdgpu_device_init [amdgpu]] *ERROR* early_init of IP block <sdma_v4_0> failed -19
```

The error code for the device init is bubbled up already, remove the
second one.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    | 4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 4 +---
 8 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 52598fbc9b39..4193289ae82f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -943,10 +943,8 @@ static int cik_sdma_sw_init(void *handle)
 	int r, i;
 
 	r = cik_sdma_init_microcode(adev);
-	if (r) {
-		DRM_ERROR("Failed to load sdma firmware!\n");
+	if (r)
 		return r;
-	}
 
 	/* SDMA trap event */
 	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 224,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 51afc92994a8..4dd944a93cf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -852,10 +852,8 @@ static int sdma_v2_4_sw_init(void *handle)
 		return r;
 
 	r = sdma_v2_4_init_microcode(adev);
-	if (r) {
-		DRM_ERROR("Failed to load sdma firmware!\n");
+	if (r)
 		return r;
-	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 344202870aeb..dc7aab68ed66 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1130,10 +1130,8 @@ static int sdma_v3_0_sw_init(void *handle)
 		return r;
 
 	r = sdma_v3_0_init_microcode(adev);
-	if (r) {
-		DRM_ERROR("Failed to load sdma firmware!\n");
+	if (r)
 		return r;
-	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 8562ac7f7ff0..dff66e1ae7ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1720,10 +1720,8 @@ static int sdma_v4_0_early_init(void *handle)
 	int r;
 
 	r = sdma_v4_0_init_microcode(adev);
-	if (r) {
-		DRM_ERROR("Failed to load sdma firmware!\n");
+	if (r)
 		return r;
-	}
 
 	/* TODO: Page queue breaks driver reload under SRIOV */
 	if ((amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 0, 0)) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 1cadd3cb26a9..3b6990ef403a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1246,10 +1246,8 @@ static int sdma_v4_4_2_early_init(void *handle)
 	int r;
 
 	r = sdma_v4_4_2_init_microcode(adev);
-	if (r) {
-		DRM_ERROR("Failed to load sdma firmware!\n");
+	if (r)
 		return r;
-	}
 
 	/* TODO: Page queue breaks driver reload under SRIOV */
 	if (sdma_v4_4_2_fw_support_paging_queue(adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index e0527e5ed7d1..7e837acffa6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1368,10 +1368,8 @@ static int sdma_v5_0_sw_init(void *handle)
 		return r;
 
 	r = sdma_v5_0_init_microcode(adev);
-	if (r) {
-		DRM_ERROR("Failed to load sdma firmware!\n");
+	if (r)
 		return r;
-	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 0ccb7523bc55..86661f9653fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1232,10 +1232,8 @@ static int sdma_v5_2_sw_init(void *handle)
 	}
 
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
-	if (r) {
-		DRM_ERROR("Failed to load sdma firmware!\n");
+	if (r)
 		return r;
-	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 4d6de77d289e..2c0c2e9f2783 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1283,10 +1283,8 @@ static int sdma_v6_0_sw_init(void *handle)
 		return r;
 
 	r = amdgpu_sdma_init_microcode(adev, 0, true);
-	if (r) {
-		DRM_ERROR("Failed to load sdma firmware!\n");
+	if (r)
 		return r;
-	}
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		ring = &adev->sdma.instance[i].ring;
-- 
2.34.1

