Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F21C77B61
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Apr 2023 03:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF89110E870;
	Wed, 26 Apr 2023 03:31:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EA210E870
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Apr 2023 03:31:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eq8lqD8v1rV48uX91xuiwMd6MovsZKfxNc/iz+CZz7jop8y4g3SVlAF0OHOUneTq8Ry90x4VlXrac6Qv6YYkG+m3Yl2ttFpRJvbm+vRJiqLma8odaISW4lRfHw31XWJ52MHF/VJDXbnnLn20eqVwY5OU2pZpb8JVN4iMFRYR1f3MYlFW/xiv1PttZ/x45da9zcKqjfuUvMjtMNA6ssV5hiKVhBW0rviHnZngqeou73xN67/Q/CieUrGeU96ZfkO77JC4aYldeFsl6guq6c9Y7tkAqj3ncEDj2vWHrs70nnSg2fPE8SZz8aiznck4ShArTfraNFULJ3jhZOgxsy1IGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nlmVW3R95hkD27HcI0CB7FzGXlxAdHUavkIlTTts1k=;
 b=DSE4ZOf7JOHAixPqLNLSgA2MLdRsLcvOt0BfKIYeRROxNBuN0/xJ45Uc/sVIW0jQ/YSR9agrpTeJn139Sn/s/L5g2qW1AMugeIs5x8Vc3qjFhZqDmfbF2UPrJbOPC9UaXijdQNN15udUDXwSKqXQm2pwygVNCm98DUTsx5QLTH7xWEiLhW+VhOpaN5VXwykLjxY4Z+Y4i1ETKH264xR2Nx4Zrx7emf4p0gznMANosm4fpj7p4rXfzthYIk/TDKWkBqeuieuzdnss4+zToyf/skZWmXRyQI748Qf3duEOPmBnT22CingZzlCdYooRgPeknHoFmqJGAU1CFMIALTO+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nlmVW3R95hkD27HcI0CB7FzGXlxAdHUavkIlTTts1k=;
 b=EU7RwIsxrANLQfq0Rw79fUECH/UmsjdiG9DSRvOebxoc9OqWEwrT9JU9w9YsAh8RhkqgBWVgIFFgYWYfsHrZnsjCPFZ8TW//pXEdyJ9D6h8Fjxc7sDPjYXvykKAyKvujZI1POitvlL1Wh2hXF5+gylcJey6KpfIZFPb/3Rbb3Ls=
Received: from DM6PR01CA0026.prod.exchangelabs.com (2603:10b6:5:296::31) by
 MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Wed, 26 Apr
 2023 03:31:38 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::c) by DM6PR01CA0026.outlook.office365.com
 (2603:10b6:5:296::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34 via Frontend
 Transport; Wed, 26 Apr 2023 03:31:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 03:31:38 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 25 Apr 2023 22:31:35 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <le.ma@amd.com>
Subject: [PATCH] drm/amdgpu: check correct allocated mqd_backup object after
 alloc
Date: Wed, 26 Apr 2023 11:31:21 +0800
Message-ID: <20230426033121.154649-1-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd7cad8-e2a6-493d-b03d-08db4606be88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dyu/XUYLxhw3i3fVRZ57cpsNLTUqYMGcRbEVk471HpLiwkx08c1U94zGJv52d9bvtcvhUuNfCb08I7hTryzuTrvXjjvxgnxwQ04RPn2iG/Sjxte6LRPCE0acJgVLkfxSHZ+01MA0GMxjNdIzkmjxNaYWlOwyqRI6hMrV/AcywlV09ND6M3dXd0XjuN8KGSpdsiwaUEaYI5gIkMa//QHGC0Av/goCmplz8p75iBONzt5QJOxd2eKCs055vI7WhH3nm28BNTzXkOVDyv/uV+GoPbRDLq5sscyJvywgPcIfLOYoHpKg/ZXtb6yzrchNT2ltMGzbifCOZUMfin25/MCwsOIiPFNyqg3zULHpGnb5BbTWevq7ZASOW4xE4BIq7w4K37sMv2lG1bu8uFwYwJnQLmlQKKb4DWCv3FlFFExZHcyw+T5rh6x4C1DmDA/l95qsQa1f07H3LHf9ZkFvY0/QaVAv2FBrUMr3Wm3hmMZtJL0LnvoWQWi7yLmkpdRetEM12nJ37heH/6IeNLWTNm1XJHm/kI6PzjCaBiTTIMlRI/FPMu4YMF2/cs9llhcKMqfP/pwGxjhkNIZEwmOmB2sw0+oEElY3//po0tklUijMP/hUSocWMpniNvbYMW9KO3qjl0pOVGV1IL+LoOrP0sQ2m8y0ADPSmg6DNMaA1mlE8KuRf8n6HI9bxjRfc3GFuFdD9ERkhVEs7qP/UFHge0zX91X/B9Ir61MmRIJaYpDWDecBtijUjNeYe8oy2v3lktiB
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(478600001)(16526019)(40460700003)(110136005)(6636002)(86362001)(36756003)(186003)(26005)(82310400005)(1076003)(40480700001)(4326008)(316002)(6666004)(82740400003)(44832011)(83380400001)(70206006)(70586007)(36860700001)(2906002)(41300700001)(336012)(8676002)(356005)(426003)(81166007)(7696005)(5660300002)(8936002)(47076005)(2616005)(36900700001)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 03:31:38.2653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd7cad8-e2a6-493d-b03d-08db4606be88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of the default one, check the right mqd_backup object.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Cc: Le Ma <le.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 2cf1f88fde48..66b9740ec376 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -379,7 +379,7 @@ int amdgpu_gfx_kiq_init(struct amdgpu_device *adev,
 int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 			   unsigned mqd_size, int xcc_id)
 {
-	int r, i;
+	int r, i, j;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[xcc_id];
 	struct amdgpu_ring *ring = &kiq->ring;
 
@@ -431,7 +431,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 	/* create MQD for each KCQ */
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		ring = &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_rings];
+		j = i + xcc_id * adev->gfx.num_compute_rings;
+		ring = &adev->gfx.compute_ring[j];
 		if (!ring->mqd_obj) {
 			r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
 						    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
@@ -443,8 +444,8 @@ int amdgpu_gfx_mqd_sw_init(struct amdgpu_device *adev,
 
 			ring->mqd_size = mqd_size;
 			/* prepare MQD backup */
-			adev->gfx.mec.mqd_backup[i + xcc_id * adev->gfx.num_compute_rings] = kmalloc(mqd_size, GFP_KERNEL);
-			if (!adev->gfx.mec.mqd_backup[i])
+			adev->gfx.mec.mqd_backup[j] = kmalloc(mqd_size, GFP_KERNEL);
+			if (!adev->gfx.mec.mqd_backup[j])
 				dev_warn(adev->dev, "no memory to create MQD backup for ring %s\n", ring->name);
 		}
 	}
-- 
2.25.1

