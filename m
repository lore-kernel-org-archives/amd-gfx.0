Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4A9C64ED6
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 16:16:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3602010E92C;
	Tue, 14 Feb 2023 16:15:59 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63E8A10E924
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 16:15:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKlp3T7xtJRtw7arZXTcJMs3Er3CPbrtKe2goiA7SnRlXz+9evsRTm807nzrd1RKfuDfymiYQPVKgeyby8kUY0vrGqfzR752nb3lEOe4chshihjpC49LXdHvs2E/UCg2xVJax1fF8mFaNWYY+SVV3JEYL/Fi//q2RDkaNaVyg0hN0h963OPiuzd67r50Z8HAi51bictA3S90Q81MC3+sheCZ4unS2QjYgN/pbG2PpVANpCGTY6hf07bNuU1QwDUn6vzvGhrMP/Obe4Syh7/D0Q+EDmE1c+o/0taPCOHDgM9ONSklG4Br0b0mzTq4WXX2qggYwAGxj6k5e/Eqj0cEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8cbnVT5posFuhMDVIJps11hOEWWQAqq4PGzh4K8ye8=;
 b=gFWQvqtTkKDk9drUdbmxSyfG6LtiKT3Gz9jnhuHveiEgRIMZ2pqC6XMBzWVFIBsQknWWgelkOM61jyH5zeE4LPrdbda+LDDvmzdImbzlQFGtzkDWgIIDwPtV/b4jQnpKmNQd1zRFjLSMuZvMFS/D+TfLsbY+sH43asQF4hQ85tX5R5pp3kwV8AIJoeOn0jmcv0aEuz+/aHhRv2K/Tm4P4Po0k9DiGJxTimwDMZS7H0p+CcWsaZwKd1mDiKXqsQ34ozxEUXfJXFMLVDNUint+Bh1/uxEW2xQ7bPPxz3MLJQsOkFFAGuB+ibSdmtUEHHqXhooV3wKZB8wo+Diub9UMIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8cbnVT5posFuhMDVIJps11hOEWWQAqq4PGzh4K8ye8=;
 b=I8jrjk7gNOky+x8xRrlAY3HCT5Z4voLVzwAsP93aX2g+Jg641zGUKXegh58FsIFfTw0HACbj0nNQq+v3z5d8IZtxMz06lZjHpnPaeesKSebRBZBd1eizJLdWDHlb/L6ka5ruo3K7oXoF2aN/ayBQXzUG+saYWgIOGUs/AB33c14=
Received: from MW2PR16CA0055.namprd16.prod.outlook.com (2603:10b6:907:1::32)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 14 Feb
 2023 16:15:51 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::a2) by MW2PR16CA0055.outlook.office365.com
 (2603:10b6:907:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 16:15:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 16:15:50 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 10:15:49 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 4/8] drm/amdgpu: rename doorbell variables
Date: Tue, 14 Feb 2023 17:15:06 +0100
Message-ID: <20230214161510.2153-5-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230214161510.2153-1-shashank.sharma@amd.com>
References: <20230214161510.2153-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 5610a174-dcdc-456f-f5f3-08db0ea6bd76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k8xBXgHuLr+F1IZ0ZN0AFSGbtge9boW9YLZ9Hx5Wl0CsjavlvcQ+6ae9wBK/pk8+A7YxhwapyQwRg5dnZbW8J7wOLXS5sOXwdPqwXPKrSBL2OQfytkKzQDHyfaeobMWJsCFF9sBJkNOiw+jSChzFvyATr6vODODqV1mTxamctDQBxugPz3e7Vewd8Sx7tTtlMJe/38OB815532+22b6yIK+waCaAZDgTNPb+jq0lJdAPYxTkgpIdQAUylDQavcr1dl/aFUVdM3NRBGvNdjF+pf6dbj0eSULfEb8Us5n+fiZmYfkTp99bACfBRdP1fOjWvp3GsGr3gnE0fM/yWgTZQsGKRECn7FQhdfaH4SoUxPbHpnQXCCeltCMU7OYN0u+p6FiIjmILjDmedbkIezmP6Mc65r9WhP5yefZSeJhPbeATm5o/4iBrqmjK256LGs1o0wybVnYSflendxjVzfbZAnj1opOgPQz/gh/qtSAmwiDyVkt1/n65hJ8s22VpehLYDU/nS2Xl4Ab9/8B+FSOvVY8tYWd4o64uqHUC0eeVV4JLnxowYo8ARXYB7kR8oP4d2MOeddD/8TmwzO1Do4HcGFwJ8IrqK7QAY3usliUQEdjPdigvwyF8ro2A/VOHdY/L9pleDrEkH872RxWtmqStLZRfxUH8Y1p/8xB/CVJTQe4zAs5XN1GOgI8NR0uGRlCBfmNvwnBzEHQPXduvspmFkexXIIJuB9pnhfPoh2N59EY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(451199018)(36840700001)(40470700004)(46966006)(83380400001)(54906003)(36756003)(86362001)(82310400005)(186003)(26005)(1076003)(426003)(47076005)(7696005)(40480700001)(40460700003)(16526019)(2906002)(70586007)(30864003)(44832011)(70206006)(4326008)(8936002)(36860700001)(8676002)(6916009)(41300700001)(2616005)(478600001)(336012)(5660300002)(6666004)(81166007)(82740400003)(356005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:15:50.7701 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5610a174-dcdc-456f-f5f3-08db0ea6bd76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch:
- renames the adev->doorbell.base to adev->doorbell.doorbell_aper_base
- renames the adev->doorbell.size to adev->doorbell.doorbell_aper_size
- moves the adev->doorbell.ptr to adev->mman.doorbell_aper_base_kaddr

rest of the changes are just to accommodate these variable name changes.

V2: Mered 2 patches into this one doorbell clean-up patch.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  8 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c   | 34 ++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c       |  4 +--
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c       |  4 +--
 12 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 58689b2a2d1c..0493c64e9d0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -106,13 +106,13 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 		 * not initialized as AMDGPU manages the whole
 		 * doorbell space.
 		 */
-		*aperture_base = adev->doorbell.base;
+		*aperture_base = adev->doorbell.doorbell_aper_base;
 		*aperture_size = 0;
 		*start_offset = 0;
-	} else if (adev->doorbell.size > adev->doorbell.num_doorbells *
+	} else if (adev->doorbell.doorbell_aper_size > adev->doorbell.num_doorbells *
 						sizeof(u32)) {
-		*aperture_base = adev->doorbell.base;
-		*aperture_size = adev->doorbell.size;
+		*aperture_base = adev->doorbell.doorbell_aper_base;
+		*aperture_size = adev->doorbell.doorbell_aper_size;
 		*start_offset = adev->doorbell.num_doorbells * sizeof(u32);
 	} else {
 		*aperture_base = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 45588b7919fe..43c1b67c2778 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -597,7 +597,7 @@ u32 amdgpu_mm_rdoorbell(struct amdgpu_device *adev, u32 index)
 		return 0;
 
 	if (index < adev->doorbell.num_doorbells) {
-		return readl(adev->doorbell.ptr + index);
+		return readl(adev->mman.doorbell_aper_base_kaddr + index);
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -620,7 +620,7 @@ void amdgpu_mm_wdoorbell(struct amdgpu_device *adev, u32 index, u32 v)
 		return;
 
 	if (index < adev->doorbell.num_doorbells) {
-		writel(v, adev->doorbell.ptr + index);
+		writel(v, adev->mman.doorbell_aper_base_kaddr + index);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -641,7 +641,7 @@ u64 amdgpu_mm_rdoorbell64(struct amdgpu_device *adev, u32 index)
 		return 0;
 
 	if (index < adev->doorbell.num_doorbells) {
-		return atomic64_read((atomic64_t *)(adev->doorbell.ptr + index));
+		return atomic64_read((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index));
 	} else {
 		DRM_ERROR("reading beyond doorbell aperture: 0x%08x!\n", index);
 		return 0;
@@ -664,7 +664,7 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
 		return;
 
 	if (index < adev->doorbell.num_doorbells) {
-		atomic64_set((atomic64_t *)(adev->doorbell.ptr + index), v);
+		atomic64_set((atomic64_t *)(adev->mman.doorbell_aper_base_kaddr + index), v);
 	} else {
 		DRM_ERROR("writing beyond doorbell aperture: 0x%08x!\n", index);
 	}
@@ -1035,10 +1035,10 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 
 	/* No doorbell on SI hardware generation */
 	if (adev->asic_type < CHIP_BONAIRE) {
-		adev->doorbell.base = 0;
-		adev->doorbell.size = 0;
+		adev->doorbell.doorbell_aper_base = 0;
+		adev->doorbell.doorbell_aper_size = 0;
 		adev->doorbell.num_doorbells = 0;
-		adev->doorbell.ptr = NULL;
+		adev->mman.doorbell_aper_base_kaddr = NULL;
 		return 0;
 	}
 
@@ -1048,15 +1048,15 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 	amdgpu_asic_init_doorbell_index(adev);
 
 	/* doorbell bar mapping */
-	adev->doorbell.base = pci_resource_start(adev->pdev, 2);
-	adev->doorbell.size = pci_resource_len(adev->pdev, 2);
+	adev->doorbell.doorbell_aper_base = pci_resource_start(adev->pdev, 2);
+	adev->doorbell.doorbell_aper_size = pci_resource_len(adev->pdev, 2);
 
 	if (adev->enable_mes) {
 		adev->doorbell.num_doorbells =
-			adev->doorbell.size / sizeof(u32);
+			adev->doorbell.doorbell_aper_size / sizeof(u32);
 	} else {
 		adev->doorbell.num_doorbells =
-			min_t(u32, adev->doorbell.size / sizeof(u32),
+			min_t(u32, adev->doorbell.doorbell_aper_size / sizeof(u32),
 			      adev->doorbell_index.max_assignment+1);
 		if (adev->doorbell.num_doorbells == 0)
 			return -EINVAL;
@@ -1071,10 +1071,10 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
 			adev->doorbell.num_doorbells += 0x400;
 	}
 
-	adev->doorbell.ptr = ioremap(adev->doorbell.base,
-				     adev->doorbell.num_doorbells *
-				     sizeof(u32));
-	if (adev->doorbell.ptr == NULL)
+	adev->mman.doorbell_aper_base_kaddr = ioremap(adev->doorbell.doorbell_aper_base,
+						      adev->doorbell.num_doorbells *
+						      sizeof(u32));
+	if (adev->mman.doorbell_aper_base_kaddr == NULL)
 		return -ENOMEM;
 
 	return 0;
@@ -1089,8 +1089,8 @@ static int amdgpu_device_doorbell_init(struct amdgpu_device *adev)
  */
 static void amdgpu_device_doorbell_fini(struct amdgpu_device *adev)
 {
-	iounmap(adev->doorbell.ptr);
-	adev->doorbell.ptr = NULL;
+	iounmap(adev->mman.doorbell_aper_base_kaddr);
+	adev->mman.doorbell_aper_base_kaddr = NULL;
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
index 7199b6b0be81..526b6b4a86dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
@@ -26,9 +26,8 @@
  */
 struct amdgpu_doorbell {
 	/* doorbell mmio */
-	resource_size_t		base;
-	resource_size_t		size;
-	u32 __iomem		*ptr;
+	resource_size_t		doorbell_aper_base;
+	resource_size_t		doorbell_aper_size;
 	u32			num_doorbells;	/* Number of doorbells actually reserved for amdgpu. */
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 0c546245793b..b79fb369f0f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -126,7 +126,7 @@ static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
 		roundup(doorbell_start_offset,
 			amdgpu_mes_doorbell_process_slice(adev));
 
-	doorbell_aperture_size = adev->doorbell.size;
+	doorbell_aperture_size = adev->doorbell.doorbell_aper_size;
 	doorbell_aperture_size =
 			rounddown(doorbell_aperture_size,
 				  amdgpu_mes_doorbell_process_slice(adev));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 929bc8abac28..967b265dbfa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -51,6 +51,7 @@ struct amdgpu_mman {
 	struct ttm_device		bdev;
 	bool				initialized;
 	void __iomem			*vram_aper_base_kaddr;
+	u32 __iomem			*doorbell_aper_base_kaddr;
 
 	/* buffer handling */
 	const struct amdgpu_buffer_funcs	*buffer_funcs;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f202b45c413c..7722da8e7cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3526,7 +3526,7 @@ static int gfx_v9_0_kiq_init_register(struct amdgpu_ring *ring)
 		 */
 		if (check_if_enlarge_doorbell_range(adev))
 			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
-					(adev->doorbell.size - 4));
+					(adev->doorbell.doorbell_aper_size - 4));
 		else
 			WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
 					(adev->doorbell_index.userqueue_end * 2) << 2);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
index aa761ff3a5fa..c5fd58d5fef9 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
@@ -173,9 +173,9 @@ static void nbio_v2_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			     lower_32_bits(adev->doorbell.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			     upper_32_bits(adev->doorbell.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, mmBIF_BX_PF_DOORBELL_SELFRING_GPA_APER_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 15eb3658d70e..9d716ec71f28 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -169,9 +169,9 @@ static void nbio_v4_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			     lower_32_bits(adev->doorbell.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			     upper_32_bits(adev->doorbell.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
index 37615a77287b..19e175cc7340 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_1.c
@@ -121,9 +121,9 @@ static void nbio_v6_1_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			     lower_32_bits(adev->doorbell.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			     upper_32_bits(adev->doorbell.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, mmBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
index 31776b12e4c4..bb2f1857b1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -175,10 +175,10 @@ static void nbio_v7_2_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 
 		WREG32_SOC15(NBIO, 0,
 			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			lower_32_bits(adev->doorbell.base));
+			lower_32_bits(adev->doorbell.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0,
 			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			upper_32_bits(adev->doorbell.base));
+			upper_32_bits(adev->doorbell.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
index 19455a725939..ee1982bb06aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
@@ -223,9 +223,9 @@ static void nbio_v7_4_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 		      REG_SET_FIELD(tmp, DOORBELL_SELFRING_GPA_APER_CNTL, DOORBELL_SELFRING_GPA_APER_SIZE, 0);
 
 		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			     lower_32_bits(adev->doorbell.base));
+			     lower_32_bits(adev->doorbell.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			     upper_32_bits(adev->doorbell.base));
+			     upper_32_bits(adev->doorbell.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, mmDOORBELL_SELFRING_GPA_APER_CNTL, tmp);
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
index def89379b51a..180d50bcb40f 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c
@@ -132,10 +132,10 @@ static void nbio_v7_7_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 
 		WREG32_SOC15(NBIO, 0,
 			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
-			lower_32_bits(adev->doorbell.base));
+			lower_32_bits(adev->doorbell.doorbell_aper_base));
 		WREG32_SOC15(NBIO, 0,
 			regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
-			upper_32_bits(adev->doorbell.base));
+			upper_32_bits(adev->doorbell.doorbell_aper_base));
 	}
 
 	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
-- 
2.34.1

