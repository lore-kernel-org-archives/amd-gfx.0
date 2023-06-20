Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23FC6EB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Jun 2023 17:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8067710E300;
	Tue, 20 Jun 2023 17:16:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD38810E2FC
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Jun 2023 17:16:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUYD9awDSADPgf7xmYxIfcI0CGGIGrZKIWKOyuhb8HeqL1WZgp66tp5O5DJmunp6N4vpKJvouphKLkByblTqBY7xWSCEFTynywyIiHI1pr/O9N9z8NT0uf0g0LOAq8Je0rbTcijcoLBYds7Vsu8ybe/moObv1hO2lgb8qvZPMP/19A3JJP2aVItwjs0NoXLJUVPKLNl2rrcplvJS37yUV9kD5kdE0LokbVKdkMGa87CmUwUxb0519wMCDLZq0rPoes2EjHgkaiuLbSgWSgEPkTq2hpp1ppi3HVP0CjeimMRY2dXKzQLzY3XiPMa1EcV5tu4ga5J+/x3JhrTiAcQ2/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc/ypnvbzO/y8U86c1zNW6qQn1GbZ0F/2lZsNC4XVps=;
 b=FBDxTw7LIvYA9WStISaBVFA6cYL3VsSEmM1L19cCIG5VK0jQBr1V2CeFQyqpEorxr8i4jV2gwC/P0ko+DKvEYJ2GZQVdl/sDMifqKw4JsEjoy2ksFE4suVImWe3f/14QcOkseas4eImDgn155TTFVjvzBW2+bdONT+1FPWaVLIJW81N0xivYLV/V9ubtzWEgArzRT/wgn4hOFaFUQIlX/M5PwJpreJx+B2AWsxWNi2QKtDfUHi+7pvxrafyAdei0GNUj59jPsvbAxeg3cAcQNELoSdU+He7l9aJnxQpgRBqojahWCLKGKYNW+HSkzq3xqTlfiFut01Xu/hX1/HG0hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc/ypnvbzO/y8U86c1zNW6qQn1GbZ0F/2lZsNC4XVps=;
 b=WAie26LsJZy3kxUZ/g6cE5K0LYUnqubPhIg/b4khc1XpclCDPXgHJUKDwutUodEXZAgudGey5roElaQdOIMEOvrEaCyVRSxA2WjofdKYRbbN3G6iK4T8clMeVSzGNINzFCWON7DsjvfBpSjPEI0vtAMt1y9IjzYx73DF748d+l0=
Received: from BY5PR17CA0026.namprd17.prod.outlook.com (2603:10b6:a03:1b8::39)
 by DM4PR12MB6111.namprd12.prod.outlook.com (2603:10b6:8:ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 17:16:33 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:1b8:cafe::20) by BY5PR17CA0026.outlook.office365.com
 (2603:10b6:a03:1b8::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Tue, 20 Jun 2023 17:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Tue, 20 Jun 2023 17:16:32 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 20 Jun
 2023 12:16:31 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 06/12] drm/amdgpu: create kernel doorbell pages
Date: Tue, 20 Jun 2023 19:16:02 +0200
Message-ID: <20230620171608.2131-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-1-shashank.sharma@amd.com>
References: <20230620171608.2131-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|DM4PR12MB6111:EE_
X-MS-Office365-Filtering-Correlation-Id: f42daf2d-7b13-4a08-ed83-08db71b2185a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: luDqDVwpaejkPmefhbM248jhKzrTv89PnIrl/CSgcukp2R8y5Gm1z8cvwL5/6AwkWU/W/GRYBa9CBcPnBUpYVrcjqjmgV1IAFmFc1Wbn1mVyxXesWCdDwuZT5M7UiTE3fvjnk4SyqKNvkvRNKB7Ss8VYy5xePLGeOPHUJaAOfxEzxrUUb2ZlreQ0JLgYlhFm4UNxy6g1m6chF3z6z+uLs03ctmgw6fHdcGv3C3EMbpzX8nvbEkLo4b9RfecJ82/WXYC4E3vhF2Pw9CGYVnPENsefgmq7wnhtsHurWIkDYKV4K/OJJZ9qMOS7pOfE/RUd7O+yQ3NfYA1YW8R/CVkJ04N1dzLLKbahHYNDrhhPIp7EP00PBbW9vcYwLvfwY41tbVK/Y5MCAPMkVhh/U9O+CbCd+OHZTTomMjcBGyUoGpi6+yz57gn0OOxfpVbDrcUHJtNZl/0pQz8DyqCAxs8B70AAweaKCz+GOXl3QCHs5lyGHqc3Mm+5lpzfnESOKHybEohk2LcI2YH27cacg31lr+7wLiQ50mpOM1mjpGvQ96dh8vHDvBu1ahPieesvvYlFCJ6duOpPH9KK/zSZ8Hq9P3oGydB92RxfHt2RaKuhorQiYrDbFE53kRzydhgjgKtHrTnPF4iFIkZOSWeOzkKBIMCWjv+nPzKGZl4t1ukGqwB9sLt64xhmUK0J4Qt6fldA0fXsamnblPtmBQSzvNOmmswmp/3r12vuCQNC/dRQQiXEFYI7qQCYkN/9lkbRY9IPoO6RGMffaJk6cr993ieuQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(4326008)(54906003)(478600001)(7696005)(40460700003)(1076003)(40480700001)(16526019)(186003)(6666004)(26005)(36756003)(2906002)(8676002)(41300700001)(70586007)(70206006)(6916009)(8936002)(316002)(5660300002)(44832011)(82310400005)(426003)(47076005)(83380400001)(86362001)(336012)(81166007)(356005)(2616005)(36860700001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:16:32.8849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f42daf2d-7b13-4a08-ed83-08db71b2185a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6111
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
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com,
 Shashank Sharma <shashank.sharma@amd.com>
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
index 783e2b8b086c..002899edb9d7 100644
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
index eb113e38f5e9..118f4bed32fd 100644
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
index 547ec35691fa..a403418d5eac 100644
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
index 6d1587bbda52..c48e97646541 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1854,6 +1854,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
2.40.1

