Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57CEC77B72
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Apr 2023 16:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C04710E89A;
	Wed, 12 Apr 2023 16:26:37 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E787510E89A
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Apr 2023 16:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnDs+OvHy7GxBgUL0JKYq00tx15MrKmEqaxAqiGgaRtIeL8D+fU70anZYS1a5CA241lpy6iryqt4yo5wS5gNwe8QAROsBIwWRd1CERZ+5J2mGLrl1YGYMCMt1uadyoSEEI5DMX1+anhuYYar1DucV5WeoU4VFRlMwkQzkZy/ZrzYB8qseGeJWQtqr9zJR4JZudZnuP0OkoLmPAQex7pTQAgGvsYmXiskAqC3pbQUE+QAlTCVQwdza8U+ur5rL9Db2RoOncvTN8A1WAsTU8xsipmhcEnpvcvYkWe9wP93oFnuwr+DPLmuPD6HhoH1bkFUuZeIGjPwkHgmHHlPujY7EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MIeDsPmS1nf1yYwA6S58i+12gjpWKfaJM4qFBYMuLU=;
 b=jQImQbswxw+nmxUR36XkQP5PMfQqJ4qjQlvjLHm2vnuXxRspcGfXhaqCh4ly/iDXyL0SMo7LsJ/b7HShDgTRMjmmIX9RtwN0Ve7AMxkk36In4O1pqijcfEJ2DPDpxDIUwldyvrIYk5nyuHRKTh+rHqmZHMHbXrTAAL0tOGdU4kzBZamY8S+UbNkzEie1b1tubAsDpYEb4ng0tCSUmmay5vZUQOk9ZxK39gVyxWY2IWoMj6Psj6Cnb3hOmerXO+RCyA4i3NoRrNC4fetzXanvFH4KbLmgYzsmNliphd1kMmUsptXgkgffj1ShoL+O1l9+B8AD9k9G28vaxQl/sKCwRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MIeDsPmS1nf1yYwA6S58i+12gjpWKfaJM4qFBYMuLU=;
 b=FD7lnm7vpzbZOWBsVOb1RMY7so9KCLhk3zcK8mGLwt1xi16q1v3yiyYnN6p37/L32zmVv4bKjwZzJ7RkT5MfJcvzyNDg6xHSqIyeChYMr29McgCZYlooISozCrw/Ssbg6YbnX4LiZ2koJirG1wiiC6aPaB/02dRyxwPMh3Pi7J8=
Received: from BN9PR03CA0429.namprd03.prod.outlook.com (2603:10b6:408:113::14)
 by PH0PR12MB5629.namprd12.prod.outlook.com (2603:10b6:510:141::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Wed, 12 Apr
 2023 16:26:32 +0000
Received: from BL02EPF000100D3.namprd05.prod.outlook.com
 (2603:10b6:408:113:cafe::47) by BN9PR03CA0429.outlook.office365.com
 (2603:10b6:408:113::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 16:26:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.27 via Frontend Transport; Wed, 12 Apr 2023 16:26:31 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 12 Apr
 2023 11:26:29 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 06/12] drm/amdgpu: create kernel doorbell pages
Date: Wed, 12 Apr 2023 18:25:30 +0200
Message-ID: <20230412162537.1357-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230412162537.1357-1-shashank.sharma@amd.com>
References: <20230412162537.1357-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D3:EE_|PH0PR12MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c7475b-b533-4d12-c540-08db3b72ad15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vIJlxZZJfYiMsuTZYIZ9v/HnspkEcI3GSUV8QJK2UVZ0qXSFDVkij0PYWnpGMKJAylPLJpbnwxsz8vKZom0gzuJrj2nGul/uVF27CBuIgnkUlOEOwpNOtUJuxWDaSXQcLJw9ZESayDsTcZuTz4AQ/GdMKDChGSiInRlc3uSJLCQ03SMJ6dT2p2ehleWyf2XS7Kix53ZTLl28B4Vq5AcaPO46oc1NRnLMu1FC5gRLOwDnmz5bMGKVjrPpsEMXHqik+uwV5agIvtpVkcWFvmNPWaf8o0/BvmsURssM3mm3ftz1C42sukjWzxr2kPuxK+ZMnJtJL3jcspH4qx3YSc2HnfFxJrMwP/7vHaVe3oK0wjr+LPk+QWu15zlt7lTLyqsQRaTaIeu2Qp1nNVOFjPerE9XjfBXWKCafpLvuh3ZK1vzBkowrc/jC/4BLdSbZ9C2GoRYcIwwcAWuMijUgSv+IDZJfM3d6zCt55EsotomBhNesHmVh2r3FQb6m9v7O5/uC+8TNQVhjdYUuFgPNTlLakCyGOmEcJF29yYb++/eyzhMEaGhz91SVaWQEIaVtTnmALEnq+aRt4jdR8dIZYMGWrBynky2/BTBtI5el+gp7dHqdNHYqhqebCGOfxk7A0WDEQb3Zp9jfMxHZ1Y6WKAVlUZIhxE6x8UidPTXdcshnwmg7uvIIA5OkPMgKZoMChapMriXLAGr5gLoiaWHUFSDhyurWUGwhhCiKziC2mrOFKT8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(8936002)(336012)(426003)(6666004)(41300700001)(5660300002)(70586007)(36860700001)(7696005)(40480700001)(86362001)(82310400005)(478600001)(36756003)(4326008)(54906003)(8676002)(6916009)(70206006)(83380400001)(316002)(47076005)(186003)(2906002)(16526019)(81166007)(2616005)(356005)(26005)(82740400003)(1076003)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:26:31.8784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c7475b-b533-4d12-c540-08db3b72ad15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5629
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
Cc: mukul.joshi@amd.com, Shashank Sharma <shashank.sharma@amd.com>,
 arvind.yadav@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 contactshashanksharma@gmail.com, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch:
- creates a doorbell page for graphics driver usages.
- adds a few new varlables in adev->doorbell structure to
  keep track of kernel's doorbell-bo.
- removes the adev->doorbell.ptr variable, replaces it with
  kernel-doorbell-bo's cpu address.

V2: - Create doorbell BO directly, no wrappe functions (Alex)
    - no additional doorbell structure (Alex, Christian)
    - Use doorbell_cpu_ptr, remove ioremap (Christian, Alex)
    - Allocate one extra page of doorbells for MES (Alex)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  8 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 56 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
 4 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 3e77a6b4bd69..fbbff12a14cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -31,10 +31,15 @@ struct amdgpu_doorbell {
 	/* doorbell mmio */
 	resource_size_t		base;
 	resource_size_t		size;
-	u32 __iomem		*ptr;
 
 	/* Number of doorbells reserved for amdgpu kernel driver */
 	u32 num_kernel_doorbells;
+
+	/* Kernel doorbells */
+	struct amdgpu_bo *kernel_doorbells;
+
+	/* For CPU access of doorbells */
+	uint32_t *cpu_addr;
 };
 
 /* Reserved doorbells for amdgpu (including multimedia).
@@ -311,6 +316,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v);
  */
 int amdgpu_doorbell_init(struct amdgpu_device *adev);
 void amdgpu_doorbell_fini(struct amdgpu_device *adev);
+int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev);
 
 #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
 #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
index 4b934aadcce6..8be2dfa8fa74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
@@ -39,7 +39,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 		return 0;
 
 	if (index < adev->doorbell.num_kernel_doorbells)
-		return readl(adev->doorbell.ptr + index);
+		return readl(adev->doorbell.cpu_addr + index);
 
 	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 	return 0;
@@ -61,7 +61,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 		return;
 
 	if (index < adev->doorbell.num_kernel_doorbells)
-		writel(v, adev->doorbell.ptr + index);
+		writel(v, adev->doorbell.cpu_addr + index);
 	else
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 }
@@ -81,7 +81,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 		return 0;
 
 	if (index < adev->doorbell.num_kernel_doorbells)
-		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
+		return atomic64_read((atomic64_t *)(adev->doorbell.cpu_addr + index));
 
 	DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 	return 0;
@@ -103,11 +103,47 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 		return;
 
 	if (index < adev->doorbell.num_kernel_doorbells)
-		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
+		atomic64_set((atomic64_t *)(adev->doorbell.cpu_addr + index), v);
 	else
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 }
 
+/**
+ * amdgpu_doorbell_create_kernel_doorbells - Create kernel doorbells for graphics
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Creates doorbells for graphics driver usages.
+ * returns 0 on success, error otherwise.
+ */
+int amdgpu_doorbell_create_kernel_doorbells(struct amdgpu_device *adev)
+{
+	int r;
+	int size;
+
+	/* Reserve first num_kernel_doorbells (page-aligned) for kernel ops */
+	size = ALIGN(adev->doorbell.num_kernel_doorbells * sizeof(u32), PAGE_SIZE);
+
+	/* Allocate an extra page for MES kernel usages (ring test) */
+	adev->mes.db_start_dw_offset = size / sizeof(u32);
+	size += PAGE_SIZE;
+
+	r = amdgpu_bo_create_kernel(adev,
+				    size,
+				    PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_DOORBELL,
+				    &adev->doorbell.kernel_doorbells,
+				    NULL,
+				    (void **)&adev->doorbell.cpu_addr);
+	if (r) {
+		DRM_ERROR("Failed to allocate kernel doorbells, err=%d\n", r);
+		return r;
+	}
+
+	adev->doorbell.num_kernel_doorbells = size / sizeof(u32);
+	return 0;
+}
+
 /*
  * GPU doorbell aperture helpers function.
  */
@@ -127,7 +163,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
 		adev->doorbell.base = 0;
 		adev->doorbell.size = 0;
 		adev->doorbell.num_kernel_doorbells = 0;
-		adev->doorbell.ptr = NULL;
 		return 0;
 	}
 
@@ -156,12 +191,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
 	if (adev->asic_type >= CHIP_VEGA10)
 		adev->doorbell.num_kernel_doorbells += 0x400;
 
-	adev->doorbell.ptr = ioremap(adev->doorbell.base,
-				     adev->doorbell.num_kernel_doorbells *
-				     sizeof(u32));
-	if (adev->doorbell.ptr == NULL)
-		return -ENOMEM;
-
 	return 0;
 }
 
@@ -174,6 +203,7 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
  */
 void amdgpu_doorbell_fini(struct amdgpu_device *adev)
 {
-	iounmap(adev->doorbell.ptr);
-	adev->doorbell.ptr = NULL;
+	amdgpu_bo_free_kernel(&adev->doorbell.kernel_doorbells,
+			      NULL,
+			      (void **)&adev->doorbell.cpu_addr);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 97c05d08a551..8880f3e3702e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -128,6 +128,9 @@ struct amdgpu_mes {
 	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
 	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
 
+	/* MES doorbells */
+	uint32_t			db_start_dw_offset;
+
 	/* ip specific functions */
 	const struct amdgpu_mes_funcs   *funcs;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index da65b72cba77..05dfa2fcb334 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1865,6 +1865,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Create a boorbell page for kernel usages */
+	r = amdgpu_doorbell_create_kernel_doorbells(adev);
+	if (r) {
+		DRM_ERROR("Failed to initialize kernel doorbells.\n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
-- 
2.40.0

