Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FBDEB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jun 2023 12:45:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6188010E0EB;
	Wed, 21 Jun 2023 12:45:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D9DA10E0EB
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jun 2023 12:45:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGjJVoqvjRDn3KjMwpU8R1ItOQtXQ3LEy317f0cykmc+yxrOsWhKIAm7C9/2eGFyOxZiO3D7bnYCXhlfMS7OxSrltNGO0LE7IXV7xAcx7U/JAt/WH4ZmY1a5cEuhAjlHODQm9oyvdLFRUKviOmJwQ3rxlLyUHY4l7poeIfuSmdSEifP/18IgYwEDkkPLUckvu2qot9Z9Q3h1e/jAsIuwsLfRQ6IfFXFuFzMPluJ+NsqvKjs7smOFGSO/oPoZjZxKBTFCtemPSk8WdL1nYVVJN3/nIO7NIBRd1vubY6Oa5WNkxznE+CQt/Yl48s/lhBtBa/6lceu5MDbccvwFho+lzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smF8zFzKQ3jgp1WIxAY9jg7PWtK8copY878/yJRFmF0=;
 b=GhylqyHOLYPax1WWs6braSBZm++E3S+Hw9U8/d5Oi0PGD+aebzB93JMbofxqElqFW6AtTxMV67zMCILWvvjksYxNVzs6yBBKejjbaTP4RhNzXi8xAtEyPqjX2YEssJzAZwHaHoP0QRsaWjWcvGK/20QkbEZuCt9sbgzs2gBnDfHozrhk3zMNNOrZzhNyu9KNSxlNYqdoYdKW6/NrOJHCfZY2CK2j/sUYfe4GxbqEuPy5ruxYL4DPWa8FqZN9gQhqBImACCSsO18IQVXV10Y20wvcAYKXidFGEdb5HtDkqQAQ80NKYE4G+qyuSWYgxo9swswMSRdQKZqJOgO/yEdIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smF8zFzKQ3jgp1WIxAY9jg7PWtK8copY878/yJRFmF0=;
 b=y279s0XZ9S9qgBGbdvCV6CQXX7tpzOaVv1VctihKug8xn1rBpLtQuNbCPn7Ub7Rfd/mPU9O/UMn+POp492ySgEzddjd6JCzjbczy4P6hJA4H04SQBIxMfdNwuU+im68kudiatHcMHwgGyi+A/C9chysBRDsC/IyuPWLwcWu+mWg=
Received: from SJ0PR03CA0169.namprd03.prod.outlook.com (2603:10b6:a03:338::24)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 12:45:00 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:338:cafe::19) by SJ0PR03CA0169.outlook.office365.com
 (2603:10b6:a03:338::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 12:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.41 via Frontend Transport; Wed, 21 Jun 2023 12:44:59 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 07:44:56 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 06/12] drm/amdgpu: create kernel doorbell pages
Date: Wed, 21 Jun 2023 14:44:44 +0200
Message-ID: <20230621124444.2248-1-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230620171608.2131-7-shashank.sharma@amd.com>
References: <20230620171608.2131-7-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT024:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2a67df-0e3e-45c7-ef3a-08db72555341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rf6gicFT5xrGWsk7A3PcGLsmAWA6mDgeDHS29y3s8g3gQJ7UiYqwE7XJdrG74ohZ/sX9+MX4H670aT+6NdUYjYd/uCc41PKAD9J4Io/WC3HmQhSxxire1Rgs0StbEvlMoJ/s107jzrNYJYr04WUUrP3o4gkVHzI/5cHRdyiEATcZ4q8gPtAKbc5LDA3h54yMEmF1zSaNuT8PNqWTjG6TaHx2BUPK7jlsQtD5cmH2Zh+1XI+U+G74y8MvX3KxsPibHfl8VINujmIQm3huInZFgxEI6WDDHn3Ue5dht0qWAYsolSZfMbZ27mrEnTvXRTPILI+OddGcThBPdi2M17gGz/Iu0fCCJm2XXUhecDySspjTGaE7mnT+plUc4+pY19zSuNMzo+FogTHD7mJxJcKE0lfJi25OM1d7L1ECdEQrMy8z06TNilP6L7tN1vGQJ1cfkl1wReAEkeDo0r24wL7GUlJTdTZwib3ouSmLGkwRvl1+h+jy0V3cgCP8kcq1lHWq0VLgRmlwPTvVJzgxqqbgu2iaDvObrYr1cy3Kb6UzdHQwGZ6OJhxtRsYHuDE4zJN8LoV4oBoHJrGHq0av8skIsbYffuytOT+oHLiOYH6s2hXjsg5Y3Hj+1AsY+17HsbbNu+7y9Koz1op2DiLeBxK4UIHO7Mne4TG+T3nB8nEK1eEhowYxyRBgjnpVel7ptLURVZ5z+dOTOCP63jwItgnEHKD1CvnaYwHXlJou4foYo/r5np9T9klvQ9B5Giv0lIip0F6hoPRr+07Z18TxQIJNtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(82740400003)(81166007)(356005)(47076005)(26005)(1076003)(83380400001)(426003)(186003)(2616005)(336012)(16526019)(44832011)(36860700001)(40480700001)(2906002)(41300700001)(5660300002)(8676002)(8936002)(36756003)(6666004)(7696005)(478600001)(4326008)(6916009)(70206006)(70586007)(40460700003)(316002)(54906003)(86362001)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 12:44:59.6892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2a67df-0e3e-45c7-ef3a-08db72555341
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124
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

V4: Move MES doorbell base init into MES related patch (Christian)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  8 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 52 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h       |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  7 +++
 4 files changed, 56 insertions(+), 14 deletions(-)

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
index eb113e38f5e9..dd6744eb5875 100644
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
@@ -103,11 +103,43 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
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
@@ -127,7 +159,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
 		adev->doorbell.base = 0;
 		adev->doorbell.size = 0;
 		adev->doorbell.num_kernel_doorbells = 0;
-		adev->doorbell.ptr = NULL;
 		return 0;
 	}
 
@@ -156,12 +187,6 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
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
 
@@ -174,6 +199,7 @@ int amdgpu_doorbell_init(struct amdgpu_device *adev)
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

