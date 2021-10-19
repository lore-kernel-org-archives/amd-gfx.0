Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3092C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:15:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AED3860ED3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 18:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AED3860ED3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0BD76E2C8;
	Tue, 19 Oct 2021 18:15:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E652A6E593
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 18:15:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AKQgm1t/D+7XrGgq9TFUMHoDObDjP/+hTmO3EHwtCdC53Gaco9Cyi+ajQaUoy7gYEBiGDwfZDR8JuX/bJ7STzr9nX1/xrkW8eszn3pZ2M4/jYg7rHKFxsyw2bKAStg5HTSFkpaWlpoYeiBEsUAzEg2rCt4QDmUiSX+oFXJ/qppqhKMw2lMHOuwIsyqBtCV9qQdm7ZJsrY4tulyWju2kiO1VrALjYqynkBic98eutwKhhlwzv9wwhjJ9Ofkh48QW81ecWsl4TQCMAhZnfv3479t9UecBfySJ/rOFdF1/tWx+kaCTQeo2yJUYCaC1cWZ0E8/NubgDryIzAbAHbvr+FKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YnCmbccspbgHVkq3mCVEJpJpc/xe4t7iCegXw1VgbOA=;
 b=W7q6qumjKrcmVe0DlpMmd1Tt0Nb7qDZMTDAMluJ3tyGAdX+kd1RZFUc2YnoKTkM7fy5iWbraviunTmpZLtbnjP6KlWVDkolBqsBTqyWlYGiotYVvuohm+63tYqtANmM/AnDzpyHlEnTeLIarNYKGvEXE/czMQqJC4mZZTG+54REUGklrfgCgf4aDyubEHTg71Dl5aQ7dfuoR4BYYyDLXd37p1crHiKYQWNgaZYVJYP8mOBwtKxrMWnYIAei8r88CF97Wm2X+zkgevAN8mxxsIf+y7fx5CkFqgL39XHYpVIkJVEnSsWWvWVF5tupq8ssSugjuiwvpEaHkXfFlR5aKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnCmbccspbgHVkq3mCVEJpJpc/xe4t7iCegXw1VgbOA=;
 b=LoiBXO5eO8lhfFIwL85QA7NupaO9A0lxkbvn+m2mq0S2AVdVHpiVbJJolDK2jCMhG9Mlcf/t3HYP9zkNDy7OqzpfDxN5nxgGetvctdzT8uuH3AXfpMEPKhVX9IslMRMT+CpqndS5PEXgtl6vI3GiEIF3pfy7t5ZuvIRK8D8bR78=
Received: from BN9PR03CA0917.namprd03.prod.outlook.com (2603:10b6:408:107::22)
 by PH0PR12MB5403.namprd12.prod.outlook.com (2603:10b6:510:eb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 18:15:11 +0000
Received: from BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::6d) by BN9PR03CA0917.outlook.office365.com
 (2603:10b6:408:107::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend
 Transport; Tue, 19 Oct 2021 18:15:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT062.mail.protection.outlook.com (10.13.177.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 18:15:10 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 13:15:05 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>, Nirmoy Das
 <nirmoy.das@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: do not pass ttm_resource_manager to vram_mgr
Date: Tue, 19 Oct 2021 20:14:48 +0200
Message-ID: <20211019181449.12356-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211019181449.12356-1-nirmoy.das@amd.com>
References: <20211019181449.12356-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ebdb723-a271-46e3-eb18-08d9932c6353
X-MS-TrafficTypeDiagnostic: PH0PR12MB5403:
X-Microsoft-Antispam-PRVS: <PH0PR12MB540323E4EE18B27618E7E7BC8BBD9@PH0PR12MB5403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3d9MxfV7hAX3ridMybajCxR7kEd3p+A3KGxBCupV7dYFo2ZeUGPukzoXugkSRtDVO6B0QcI+C1uTQlH4AvZiQKdyEn51qiwb8YnUuNM3ps1i8wUIW95FehIvfaEGcQYiB/EUd6vFxyw/RuHI4rBlSdSbhMb+KGHqvyjh33xaY9zP0H3v6Z2d//EkHuLBmrn68uGnmNnyTsF1dYDnFisoBv8iNNzOtvwUXLWaNmnyXduUW6ax0wsK1DgY6IsHODuvSf/zrTQsXs1z4DT5IdukJRv1agA2rMdXW096hfT3wlutnBsQcUacy4oD8e1X1Cfz7sL2ncMP0vcMYU/hw1jlfY5fYLIe3sy3aq9DPn3cAA1gcoNjjex6yAtFnYLA0282HazPG4Cdy9Hwgj4XzQNBOeO2UngfcT3y65kDpD4uDOSuaoPEwK/DwlF+EzXRo9M5Wr4ZUjNaVfqWXQ+c0y4DQSl3eTvg6pT4XYd2GIK10FpJf4wtt4I8d34IfvJKu7GoKAmKN6R8kvQjJtMKBgZS4HNMIg5Rmpd5Daa/bj/riKmk53GY3AOQZ4ZHRmIPG8HWGeGuhis9itWKFM7lObWBFCcmRlXH9BjUdwfUNbONc5dD1fg2j0p0GAcPdjlG2kDv73QwL1oUYoyvjxKztpYUDHXfuAG2umXyCLvNCtG2dX/9WM5MrZLfbqGwdt9feXpisQGE/MjB/vVWuThjQH16av3mh0wE8ees0aQitQcS7VM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(2906002)(426003)(186003)(47076005)(356005)(86362001)(36860700001)(83380400001)(82310400003)(7696005)(26005)(336012)(81166007)(70206006)(6666004)(44832011)(30864003)(508600001)(316002)(54906003)(1076003)(6916009)(4326008)(36756003)(8676002)(70586007)(5660300002)(8936002)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 18:15:10.3479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ebdb723-a271-46e3-eb18-08d9932c6353
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5403
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

Do not allow exported amdgpu_vram_mgr_*() to accept
any ttm_resource_manager pointer. Also there is no need
to force other module to call a ttm function just to
eventually call vram_mgr functions.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c       |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 10 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  8 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c     |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 54 ++++++++++++--------
 7 files changed, 49 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7077f21f0021..4837c579a787 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -531,9 +531,8 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 
-	return amdgpu_vram_mgr_usage(vram_man);
+	return amdgpu_vram_mgr_usage(adev);
 }
 
 uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 76fe5b71e35d..f4084ca8b614 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -298,7 +298,6 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 {
 	s64 time_us, increment_us;
 	u64 free_vram, total_vram, used_vram;
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 	/* Allow a maximum of 200 accumulated ms. This is basically per-IB
 	 * throttling.
 	 *
@@ -315,7 +314,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	}
 
 	total_vram = adev->gmc.real_vram_size - atomic64_read(&adev->vram_pin_size);
-	used_vram = amdgpu_vram_mgr_usage(vram_man);
+	used_vram = amdgpu_vram_mgr_usage(adev);
 	free_vram = used_vram >= total_vram ? 0 : total_vram - used_vram;
 
 	spin_lock(&adev->mm_stats.lock);
@@ -362,7 +361,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc)) {
 		u64 total_vis_vram = adev->gmc.visible_vram_size;
 		u64 used_vis_vram =
-		  amdgpu_vram_mgr_vis_usage(vram_man);
+		  amdgpu_vram_mgr_vis_usage(adev);
 
 		if (used_vis_vram < total_vis_vram) {
 			u64 free_vis_vram = total_vis_vram - used_vis_vram;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b9b38f70e416..34674ccabd67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -672,10 +672,10 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		ui64 = atomic64_read(&adev->num_vram_cpu_page_faults);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VRAM_USAGE:
-		ui64 = amdgpu_vram_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
+		ui64 = amdgpu_vram_mgr_usage(adev);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VIS_VRAM_USAGE:
-		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
+		ui64 = amdgpu_vram_mgr_vis_usage(adev);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_GTT_USAGE:
 		ui64 = amdgpu_gtt_mgr_usage(adev);
@@ -709,8 +709,6 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	}
 	case AMDGPU_INFO_MEMORY: {
 		struct drm_amdgpu_memory_info mem;
-		struct ttm_resource_manager *vram_man =
-			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 		struct ttm_resource_manager *gtt_man =
 			ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
 		memset(&mem, 0, sizeof(mem));
@@ -719,7 +717,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			atomic64_read(&adev->vram_pin_size) -
 			AMDGPU_VM_RESERVED_VRAM;
 		mem.vram.heap_usage =
-			amdgpu_vram_mgr_usage(vram_man);
+			amdgpu_vram_mgr_usage(adev);
 		mem.vram.max_allocation = mem.vram.usable_heap_size * 3 / 4;
 
 		mem.cpu_accessible_vram.total_heap_size =
@@ -729,7 +727,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			    atomic64_read(&adev->visible_pin_size),
 			    mem.vram.usable_heap_size);
 		mem.cpu_accessible_vram.heap_usage =
-			amdgpu_vram_mgr_vis_usage(vram_man);
+			amdgpu_vram_mgr_vis_usage(adev);
 		mem.cpu_accessible_vram.max_allocation =
 			mem.cpu_accessible_vram.usable_heap_size * 3 / 4;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08133de21fdd..2e339d37ba35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1804,8 +1804,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
-		status = amdgpu_vram_mgr_query_page_status(
-				ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+		status = amdgpu_vram_mgr_query_page_status(adev,
 				data->bps[i].retired_page);
 		if (status == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
@@ -1906,8 +1905,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			goto out;
 		}
 
-		amdgpu_vram_mgr_reserve_range(
-			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+		amdgpu_vram_mgr_reserve_range(adev,
 			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
 			AMDGPU_GPU_PAGE_SIZE);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6e337cacef51..99861418a52e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -129,11 +129,11 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt);
-uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
-uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man);
-int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
+uint64_t amdgpu_vram_mgr_usage(struct amdgpu_device *adev);
+uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_device *adev);
+int amdgpu_vram_mgr_reserve_range(struct amdgpu_device *adev,
 				  uint64_t start, uint64_t size);
-int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_query_page_status(struct amdgpu_device *adev,
 				      uint64_t start);
 
 int amdgpu_ttm_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 88c4177b708a..4806ab817c02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -548,7 +548,6 @@ static void amdgpu_virt_populate_vf2pf_ucode_info(struct amdgpu_device *adev)
 static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 {
 	struct amd_sriov_msg_vf2pf_info *vf2pf_info;
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 
 	vf2pf_info = (struct amd_sriov_msg_vf2pf_info *) adev->virt.fw_reserve.p_vf2pf;
 
@@ -571,8 +570,8 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->driver_cert = 0;
 	vf2pf_info->os_info.all = 0;
 
-	vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(vram_man) >> 20;
-	vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(vram_man) >> 20;
+	vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(adev) >> 20;
+	vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(adev) >> 20;
 	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
 	vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7b2b0980ec41..7348b744c929 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -96,10 +96,8 @@ static ssize_t amdgpu_mem_info_vram_used_show(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct ttm_resource_manager *man;
 
-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_usage(man));
+	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_usage(adev));
 }
 
 /**
@@ -116,10 +114,8 @@ static ssize_t amdgpu_mem_info_vis_vram_used_show(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct ttm_resource_manager *man;
 
-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_vis_usage(man));
+	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_vis_usage(adev));
 }
 
 /**
@@ -263,18 +259,22 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 /**
  * amdgpu_vram_mgr_reserve_range - Reserve a range from VRAM
  *
- * @man: TTM memory type manager
+ * @adev: amdgpu_device pointer
  * @start: start address of the range in VRAM
  * @size: size of the range
  *
  * Reserve memory from start addess with the specified size in VRAM
  */
-int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_reserve_range(struct amdgpu_device *adev,
 				  uint64_t start, uint64_t size)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct ttm_resource_manager *man;
+	struct amdgpu_vram_mgr *mgr;
 	struct amdgpu_vram_reservation *rsv;
 
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
+	mgr = to_vram_mgr(man);
+
 	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
 	if (!rsv)
 		return -ENOMEM;
@@ -294,7 +294,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 /**
  * amdgpu_vram_mgr_query_page_status - query the reservation status
  *
- * @man: TTM memory type manager
+ * @adev: amdgpu_device pointer
  * @start: start address of a page in VRAM
  *
  * Returns:
@@ -302,13 +302,17 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
  *	0: the page has been reserved
  *	-ENOENT: the input page is not a reservation
  */
-int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_query_page_status(struct amdgpu_device *adev,
 				      uint64_t start)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct ttm_resource_manager *man;
+	struct amdgpu_vram_mgr *mgr;
 	struct amdgpu_vram_reservation *rsv;
 	int ret;
 
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
+	mgr = to_vram_mgr(man);
+
 	spin_lock(&mgr->lock);
 
 	list_for_each_entry(rsv, &mgr->reservations_pending, node) {
@@ -632,13 +636,18 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
 /**
  * amdgpu_vram_mgr_usage - how many bytes are used in this domain
  *
- * @man: TTM memory type manager
+ * @adev: amdgpu_device pointer
  *
  * Returns how many bytes are used in this domain.
  */
-uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man)
+uint64_t amdgpu_vram_mgr_usage(struct amdgpu_device *adev)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct ttm_resource_manager *man;
+	struct amdgpu_vram_mgr *mgr;
+
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
+	mgr = to_vram_mgr(man);
+
 
 	return atomic64_read(&mgr->usage);
 }
@@ -646,13 +655,17 @@ uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man)
 /**
  * amdgpu_vram_mgr_vis_usage - how many bytes are used in the visible part
  *
- * @man: TTM memory type manager
+ * @adev: amdgpu_device pointer
  *
  * Returns how many bytes are used in the visible part of VRAM
  */
-uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man)
+uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_device *adev)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct ttm_resource_manager *man;
+	struct amdgpu_vram_mgr *mgr;
+
+	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
+	mgr = to_vram_mgr(man);
 
 	return atomic64_read(&mgr->vis_usage);
 }
@@ -669,14 +682,15 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 				  struct drm_printer *printer)
 {
 	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
+	struct amdgpu_device *adev = to_amdgpu_device(mgr);
 
 	spin_lock(&mgr->lock);
 	drm_mm_print(&mgr->mm, printer);
 	spin_unlock(&mgr->lock);
 
 	drm_printf(printer, "man size:%llu pages, ram usage:%lluMB, vis usage:%lluMB\n",
-		   man->size, amdgpu_vram_mgr_usage(man) >> 20,
-		   amdgpu_vram_mgr_vis_usage(man) >> 20);
+		   man->size, amdgpu_vram_mgr_usage(adev) >> 20,
+		   amdgpu_vram_mgr_vis_usage(adev) >> 20);
 }
 
 static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
-- 
2.32.0

