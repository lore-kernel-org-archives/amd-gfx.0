Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E63C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:04:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C79A10E3DB;
	Tue,  9 May 2023 22:04:46 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1783710E3D8
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:04:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQmobhCsXSldjH08Xmbru+xdCt5SUyIwzIxzhp7P5QA43jn1qeSM3MpOAXXcB34cmAhUcEHzub3VhV3lDGSQlDYzShft50YqgqBEaWlFcMzwYP66S+pvYgRX65MAGggVLSd+6uTKACOV9bsdmkjQpLeTB+IHNHPvLl+4QO7q1Qr2bJbHdLIBaUnDtkBowEG2tlIviN8h9tvGO23S8ENgssSwBHqWMZAn4LX4NZzOUSe0fRz93W1eUdyfwQ5X80FZe2SoL7MM/V2aaUXoqQyTemIkgR8sU0z+b6wDVOpa5h7lujif7ZdMlzWnshm/LCuYMWn1Y+Y2LhIUsJWm3E20hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yO8q2ockn+ORt0atc1FyGH9kKxXaOSf0ZdPGwlTTt0=;
 b=bOExW4WfiudnTjBKtDaFVWyliOB9sQwFRlh1xoJJdOOiATJnxt3i+SwbntKiEBxZh/3EJ/tuaInvsgflZ7JPrn6XoJphi9wVFzku8vVmiMRH40lGPpe20TO3iKF1cqdla1E15M6eJmSpuMUN4T2FK205XJnusS5ddR19VZFdDNdu7tXjl2FJzyzysXauq0sls+4zBAmYGZdAfb/4PcS7VvT43teT0+A14PgAXU4MYD/A5i3CRIoEobgHHClSAZ8kjatpdDjDqGUS+Qnm0xXgACfXbdTQY77LXWZgtsKb3/x3NQRz+8YZISrmI424BPoL7f1ziPQlduSVXzRLh7CnfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yO8q2ockn+ORt0atc1FyGH9kKxXaOSf0ZdPGwlTTt0=;
 b=xVoFTgQwQkXhD2aCD9qN9xMJqrgNBHo9XlvGP6fEHNE+BMYlFhDazXACxMbl3zrsju13EYATOZ+2qXiITk/NefKQZS13R4HZBWzgmuZHKkJKq9cKcWOTg22rxwgN+b4Pj+CYQ7VqBqzcaA9QH2OxUuu30tZRLKHd3XmvUwckzFg=
Received: from BN9PR03CA0142.namprd03.prod.outlook.com (2603:10b6:408:fe::27)
 by MW4PR12MB5628.namprd12.prod.outlook.com (2603:10b6:303:185::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:04:39 +0000
Received: from BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::73) by BN9PR03CA0142.outlook.office365.com
 (2603:10b6:408:fe::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:04:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT088.mail.protection.outlook.com (10.13.177.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:04:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:04:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Implement new dummy vram manager
Date: Tue, 9 May 2023 18:01:43 -0400
Message-ID: <20230509220144.474723-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509220144.474723-1-alexander.deucher@amd.com>
References: <20230509220144.474723-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT088:EE_|MW4PR12MB5628:EE_
X-MS-Office365-Filtering-Correlation-Id: 50c72a8a-d632-497e-e280-08db50d96290
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KI96BJfdUSXhqSH8FzMEEtqIsFVAsGTb59nrQJijDyfI92NzVtVKp/LHD6HCP0M4JhNxQfaJdIzs5FvvsRz03ooYQwl2sZ4rJ8HDOOlAWmqBkPx7xsZIjLEMSDJtiUfJLytQNPmhi/mxi4GtmrQf5uCrSDdEo0M/3rRDD16i1U4Jy4WjXItkyR6xPOVmLHcPMrVOf3+llnIEFQSYEl4XlatiPnTX4SHSc7DQYJOV2hzpO8LGeXUzDINeUmIMPqrjqLr/EWvZANfwXuWmOkaXbShEnuJqG3nj82J0q1VBkhYUkmZ88PwWo4p8ySS8rxLvxbl3ZtbrCsykkvWNRN67r3exmSWm/GBF0RJf2HqnAuZXttL+VP95qD7J8JSSAPH8Xy+1IssdX5yYCM7RwqwUW2EAgktyiypPgdiY49YXD0ntFblF2YDUBa3o4/y0e7pJ5tQOxhaVBeJDKkO7wvFkP/L9bA5ZnoarsU1VlAx3ERs4tQcXdjWr2Osou/K0qob2f6zXzBdatOluO3ITFpV070PDzkpXXIXYpDM0IEVEMRxokDZppn5mdSIIshRHKrStr6TiNNsz/Aiiv5RpmhTkCfDauu2H9kf6UQboyMq2AogsJ9iyCf51G+lTsro+dOqW6E/ApuJxMpcWSZQE0ev6jELIALuW8s5goivpfKhOoM3rVTwT5VLyWHeFmVZvLDqb2BS1UQMLSCmGvr5FxkPqEma/0zBT7/fcQ85Ad4ZHkf0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(316002)(54906003)(6666004)(70206006)(4326008)(6916009)(70586007)(7696005)(478600001)(40480700001)(356005)(82740400003)(2906002)(82310400005)(5660300002)(8936002)(41300700001)(8676002)(81166007)(16526019)(186003)(2616005)(36860700001)(1076003)(26005)(83380400001)(47076005)(336012)(426003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:04:39.4376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50c72a8a-d632-497e-e280-08db50d96290
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5628
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

This adds dummy vram manager to support ASICs that do not have a
dedicated or carvedout vram domain.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 67 ++++++++++++++++++--
 1 file changed, 60 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 43d6a9d6a538..89d35d194f2c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -370,6 +370,45 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 	return ret;
 }
 
+static void amdgpu_dummy_vram_mgr_debug(struct ttm_resource_manager *man,
+				  struct drm_printer *printer)
+{
+	DRM_DEBUG_DRIVER("Dummy vram mgr debug\n");
+}
+
+static bool amdgpu_dummy_vram_mgr_compatible(struct ttm_resource_manager *man,
+				       struct ttm_resource *res,
+				       const struct ttm_place *place,
+				       size_t size)
+{
+	DRM_DEBUG_DRIVER("Dummy vram mgr compatible\n");
+	return false;
+}
+
+static bool amdgpu_dummy_vram_mgr_intersects(struct ttm_resource_manager *man,
+				       struct ttm_resource *res,
+				       const struct ttm_place *place,
+				       size_t size)
+{
+	DRM_DEBUG_DRIVER("Dummy vram mgr intersects\n");
+	return true;
+}
+
+static void amdgpu_dummy_vram_mgr_del(struct ttm_resource_manager *man,
+				struct ttm_resource *res)
+{
+	DRM_DEBUG_DRIVER("Dummy vram mgr deleted\n");
+}
+
+static int amdgpu_dummy_vram_mgr_new(struct ttm_resource_manager *man,
+			       struct ttm_buffer_object *tbo,
+			       const struct ttm_place *place,
+			       struct ttm_resource **res)
+{
+	DRM_DEBUG_DRIVER("Dummy vram mgr new\n");
+	return -ENOSPC;
+}
+
 /**
  * amdgpu_vram_mgr_new - allocate new ranges
  *
@@ -817,6 +856,14 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	mutex_unlock(&mgr->lock);
 }
 
+static const struct ttm_resource_manager_func amdgpu_dummy_vram_mgr_func = {
+	.alloc	= amdgpu_dummy_vram_mgr_new,
+	.free	= amdgpu_dummy_vram_mgr_del,
+	.intersects = amdgpu_dummy_vram_mgr_intersects,
+	.compatible = amdgpu_dummy_vram_mgr_compatible,
+	.debug	= amdgpu_dummy_vram_mgr_debug
+};
+
 static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
 	.alloc	= amdgpu_vram_mgr_new,
 	.free	= amdgpu_vram_mgr_del,
@@ -841,17 +888,22 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	ttm_resource_manager_init(man, &adev->mman.bdev,
 				  adev->gmc.real_vram_size);
 
-	man->func = &amdgpu_vram_mgr_func;
-
-	err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
-	if (err)
-		return err;
-
 	mutex_init(&mgr->lock);
 	INIT_LIST_HEAD(&mgr->reservations_pending);
 	INIT_LIST_HEAD(&mgr->reserved_pages);
 	mgr->default_page_size = PAGE_SIZE;
 
+	if (!adev->gmc.is_app_apu) {
+		man->func = &amdgpu_vram_mgr_func;
+
+		err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
+		if (err)
+			return err;
+	} else {
+		man->func = &amdgpu_dummy_vram_mgr_func;
+		DRM_INFO("Setup dummy vram mgr\n");
+	}
+
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
 	return 0;
@@ -886,7 +938,8 @@ void amdgpu_vram_mgr_fini(struct amdgpu_device *adev)
 		drm_buddy_free_list(&mgr->mm, &rsv->allocated);
 		kfree(rsv);
 	}
-	drm_buddy_fini(&mgr->mm);
+	if (!adev->gmc.is_app_apu)
+		drm_buddy_fini(&mgr->mm);
 	mutex_unlock(&mgr->lock);
 
 	ttm_resource_manager_cleanup(man);
-- 
2.40.1

