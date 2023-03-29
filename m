Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427EBC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 15:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A6910EB70;
	Wed, 29 Mar 2023 15:48:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 685DD10EB72
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 15:48:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/BO6mo+w2f8zuehkpTdPmH4of5gh/cPkxrUwhyU4OC6WJDAsuLkM1//1BX971XRucL1DQnu+s/oPQC6I4FUTi6uxnaMqNcnmKUNvJvy7e0zldyNdCNULDmg2JkXRaTsuKTlJiqkdrP/hRjZEgLZ0SnzbgswyXGpAfqDJfiwTKRher+G775lNu+ApqxW3sXXw9tbxul1kOuEZSc6KOhC22WSnvjt7iYyS8rWTWa7wG/Id/SYBMynQmjCJbogdaA34evQv3CMggnErZTM/L67j5xSQor18Vl/W/o6JS820kbMvmjRevbUWxQyZ02EoMCgTKSQVQumjhVWCh/QxfeLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGXg5TaefojcF4MTSTN4bSaSPUVhBig6aFN74N8L+IU=;
 b=AzT2BzfJM5/S3CZcfz52ssZ/Z4+hwYpwGtGYRP43DLCmYKgvIVZZO24VyVLyl7URKcHi9ih0EBxsCiZEOu83Iqu/5gwgpqya0Ca3497zI8L4SBEPkQMnbh3zq7lUwP2ZV8B0SqHakqUR/zjkMxymv3wqnhU2AQFPkvJs3jpmn9upQQid5/DVZDPlcH2nfk0gVFlnPp1XUSeib3rBi45wh+eGMS27zLyIym7S+hYDpxhAU7a97jW48YwaQmhFgG9/B5pwUDQ0ElcvaBEiEIInBRsz8UQ+pOzK6y+mE9U00s7EOagHa73KJUiq1zcNTcG+2SHAtsdgfxMM7y2i86Gkbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGXg5TaefojcF4MTSTN4bSaSPUVhBig6aFN74N8L+IU=;
 b=Lgediz5OAbHHAc2c0CQw33vyt7cmRjAEzmRN+ORIjhWFD1IEeEBniUhaYVC+gsbt8CG39Pl/xK3SKp47LDCAN9RkN56vsOYZr8EIPyH4vrLUpcK+x0ZA5gIsKf1oUHXy//COX7SeSMhVj4BetpLqUUB7431h/6oG+qDX7OXsZVw=
Received: from DS7PR05CA0031.namprd05.prod.outlook.com (2603:10b6:8:2f::6) by
 DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.35; Wed, 29 Mar 2023 15:48:30 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::ef) by DS7PR05CA0031.outlook.office365.com
 (2603:10b6:8:2f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 15:48:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.11 via Frontend Transport; Wed, 29 Mar 2023 15:48:30 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 10:48:28 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/16] drm/amdgpu: create kernel doorbell page
Date: Wed, 29 Mar 2023 17:47:46 +0200
Message-ID: <20230329154753.1261-10-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230329154753.1261-1-shashank.sharma@amd.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT047:EE_|DS7PR12MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dd9b281-1d1b-4dfd-f01a-08db306d0b5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CailEYYhadKW2dBstehIJ9TBqwa7IBZigglbXEqfp8w7SDiADgZM56RFwbBWFicPFGuxVw0xEjGvbz1eCSun4d31+yPt4vBQUbMJvlVv9u1oKrhJ8NDyTFV5ORPdaED9seiVv8ZpSW8adAGM2xUAfi1J60d5t2+UvF5jqnSs4fSvlCc0wfqWqWadIowBN37X4lcDRdwkE1SPpoP0yAbVQIfpkQ/IonRPRb5d+lxlLbe5l4RKw9d6CmGe1yycjLCyx+JglpuaIMaWghNeeqBc90sRbnefnZTj0ukZtPuITERTCho5v54Dew4nxpJpzHJtK364rnPqYMLRpEjTtTcStYBU4S9hsaX1C/DdWBhB4Mhja9NJq+RF+O+j3XwMw2ff7QrLJXgXuy0Zc4GCcoiRTmPqJWrhPVRAYN/Nof/rz0jXzTKQj3QV4UQFMY5pyeh1Rw3pNqaIcpR5RcLzoXykwOGFlaTbr+3VT0KGtWuDhROg99JPv4FRYcJBPvylW/nDgmAxLFZMHHNEXnR/z0rnlF7zTu0sCo8wWD0f58zkx6Bc0q8CUQypixvbeqlDv0lmS5X0XK0U5ua1UmZqz7PwxgCrQ2h5xTgE1VD9AqYwSWkPtFPideMe72lxMbriCbsELMaOkwj+XnFxYLzEtwgI5a/PcEGwFBOrvaIwyyGiZgDaV3IGgOllBYGZnV3PpOAsJOffpmHJhyF6/NZpY462hLIdNbFoadNQZS0728Cr8rU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(83380400001)(2616005)(47076005)(336012)(426003)(16526019)(26005)(1076003)(478600001)(6666004)(7696005)(54906003)(6916009)(316002)(70586007)(186003)(70206006)(8676002)(81166007)(4326008)(356005)(82740400003)(41300700001)(2906002)(8936002)(5660300002)(44832011)(36756003)(82310400005)(86362001)(40460700003)(40480700001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 15:48:30.2419 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dd9b281-1d1b-4dfd-f01a-08db306d0b5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8252
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
Cc: Mukul
 Joshi <mukul.joshi@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch:
- creates a doorbell page for graphics driver usages.
- removes the adev->doorbell.ptr variable, replaces it with
  kernel-doorbell-bo's cpu address.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 16 ++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 44 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
 3 files changed, 57 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 6581b78fe438..10a9bb10e974 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -49,10 +49,13 @@ struct amdgpu_doorbell {
 	/* doorbell mmio */
 	resource_size_t		base;
 	resource_size_t		size;
-	u32 __iomem		*ptr;
+	u32	__iomem		*ptr;
 
 	/* Number of doorbells reserved for amdgpu kernel driver */
 	u32 num_kernel_doorbells;
+
+	/* For kernel doorbell pages */
+	struct amdgpu_doorbell_obj kernel_doorbells;
 };
 
 /* Reserved doorbells for amdgpu (including multimedia).
@@ -369,6 +372,17 @@ void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
 int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
 				struct amdgpu_doorbell_obj *db_obj);
 
+/**
+ * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Creates doorbells for graphics driver
+ *
+ * returns 0 on success, error otherwise.
+ */
+int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
+
 #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
 #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
 #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 8be15b82b545..b46fe8b1378d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -160,6 +160,38 @@ int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
 	return 0;
 }
 
+/**
+ * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Creates doorbells for graphics driver
+ *
+ * returns 0 on success, error otherwise.
+ */
+int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
+{
+	int r;
+	struct amdgpu_doorbell_obj *kernel_doorbells = &adev->doorbell.kernel_doorbells;
+
+	kernel_doorbells->doorbell_bitmap = bitmap_zalloc(adev->doorbell.num_kernel_doorbells,
+							  GFP_KERNEL);
+	if (!kernel_doorbells->doorbell_bitmap) {
+		DRM_ERROR("Failed to create kernel doorbell bitmap\n");
+		return -ENOMEM;
+	}
+
+	kernel_doorbells->size = adev->doorbell.num_kernel_doorbells * sizeof(u32);
+	r = amdgpu_doorbell_alloc_page(adev, kernel_doorbells);
+	if (r) {
+		bitmap_free(kernel_doorbells->doorbell_bitmap);
+		DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
 /*
  * GPU doorbell aperture helpers function.
  */
@@ -179,7 +211,6 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 		adev->doorbell.base = 0;
 		adev->doorbell.size = 0;
 		adev->doorbell.num_kernel_doorbells = 0;
-		adev->doorbell.ptr = NULL;
 		return 0;
 	}
 
@@ -208,12 +239,7 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	if (adev->asic_type >= CHIP_VEGA10)
 		adev->doorbell.num_kernel_doorbells += 0x400;
 
-	adev->doorbell.ptr = ioremap(adev->doorbell.base,
-				     adev->doorbell.num_kernel_doorbells *
-				     sizeof(u32));
-	if (adev->doorbell.ptr == NULL)
-		return -ENOMEM;
-
+	adev->doorbell.ptr = ioremap(adev->doorbell.base, adev->doorbell.size);
 	return 0;
 }
 
@@ -226,6 +252,6 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
  */
 void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
 {
-	iounmap(adev->doorbell.ptr);
-	adev->doorbell.ptr = NULL;
+	bitmap_free(adev->doorbell.kernel_doorbells.doorbell_bitmap);
+	amdgpu_doorbell_free_page(adev, &adev->doorbell.kernel_doorbells);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 203d77a20507..75c6852845c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1866,6 +1866,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Create a boorbell page for kernel usages */
+	r = amdgpu_doorbell_create_kernel_doorbells(adev);
+	if (r) {
+		DRM_ERROR("Failed to initialize kernel doorbells. \n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
-- 
2.40.0

