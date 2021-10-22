Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEC2C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65CA561073
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 09:32:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 65CA561073
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14D0C6E926;
	Fri, 22 Oct 2021 09:32:50 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2080.outbound.protection.outlook.com [40.107.100.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D88289FA0
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 09:32:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfOUMkcWKz+dpIme67bEbydmsZ81uVWNoGbasl0qVzCWAS10Nc5A1rT/x2NBSJaw/MplPtC8bhKldOa+ZREHl7vp5/1D6I0MEvhh1kCkc7tiKjwur+N2TEJ/ezK3Tm1rVBHoZdOZRNxVeagq6fBTnMDvtPKWOCYFdI39rfgoQrrDspn29lx2YSUEky1e4ARakWJFnKLU1SB7DTsGUpiHtgUbv6DBLHhfk0tRSQrQXlC8ffI2/4hk/XFi5UP3y+ZJJJxP7WgVBfqExoOqv4mA94dpQw9g7PjCDCbqQ0AS2E5bX42HJxn6yMW9CT6NEuAYPGh/XudOlhiltTHzIbfB3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z9CTri0pSDIB16Rgq8N/FqN6u8WJ4pmuqvPCiYthKLU=;
 b=g8u751jLjq5VuQ6cLKX0w9kNWlL/cWsbyO+P/j1YMyugw8VvKvLGYEVIvprni7YUvhhzO6DieRA6FhCastdozN1B7HhVhGBgCaR+vfOxoyWI6D8ugnPozSUayJPSG+ADJy/e129VpUTCMLFpaSVg+I2y7iTvo86vfNLD5KaZfFkMJ5M9rAHDTfcY3kVPUTZFxUKBnQ1Livm8Yjoow+uRxEpQNbM7Ol64b9zrJTs5hT56/4ZFZdkwkO4zJPUnBXCA/notRgnApUYIc32jDBSKOkege/F76Zr1d2T8FvICLTlM+ay3JYerRfILmcbejtXUSwdeF/ZXqayeTgtnREfVsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9CTri0pSDIB16Rgq8N/FqN6u8WJ4pmuqvPCiYthKLU=;
 b=uSo0fotZ+67HKGOnFUqr8nbq4oJy7IMtBo+lDfcSTA6rwhINJSh/z+z1sObUmHR5TLAP1Sl34ADFaETP4Tw6L76CrBf98HEL/wysXGyRoZOrW6sIoRKCXteCouGpb6iKMlB/I5t5rU1a7GdNugg6EulYg0JLUeu5GAeroFuhfw8=
Received: from DS7PR06CA0042.namprd06.prod.outlook.com (2603:10b6:8:54::23) by
 BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Fri, 22 Oct 2021 09:32:46 +0000
Received: from DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::22) by DS7PR06CA0042.outlook.office365.com
 (2603:10b6:8:54::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 09:32:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT005.mail.protection.outlook.com (10.13.172.238) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Fri, 22 Oct 2021 09:32:45 +0000
Received: from brihaspati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 04:32:43 -0500
From: Nirmoy Das <nirmoy.das@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Christian.Koenig@amd.com>, <andrey.grodzovsky@amd.com>,
 <lijo.lazar@amd.com>, Nirmoy Das <nirmoy.das@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: do not pass ttm_resource_manager to
 vram_mgr
Date: Fri, 22 Oct 2021 11:32:30 +0200
Message-ID: <20211022093231.7787-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211022093231.7787-1-nirmoy.das@amd.com>
References: <20211022093231.7787-1-nirmoy.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e0d252-17c4-4ff1-a6ed-08d9953ee772
X-MS-TrafficTypeDiagnostic: BY5PR12MB4051:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4051B14D9FE9E0797C3513688B809@BY5PR12MB4051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LddzfOJfl09oeubHJiv5R5el1/zzNFRe1BAhjvezTlRyToQjPLMPDlOIMJCUJ4rqLAJu3YqshybXhAQ+b2+Qlns+gkG5+hXU6km+T0uIIEQOZbcUp2CYFJPhx2veEJxieFNxNTn9vsTLS+uRM0wnVJk/kFc29LUFI7Q5f8uwDziGBO9Cl95KQWYq1DJl7kAZsKxouBxjyW40Jyz0dDxYZjcIo8HpBA5Cc1eFWyG+XE609Znss0MOiUlha6Yb20NmbrmrbXowr/Bv9z2R8nj4ibdk2HvI7CHBndCtbhzLGBp3yvFgGRpTqHej2naltoRA9+smk0uC/3NIfoupCkLGPHYyM2a1aXVCLzV/k/HmMMUpzCdOgdrPRsbqi7CYka7eU3yBVQU7qDNKkB476uv5Y/o/9FlfhyiuucCoz9ALxIR4fQD9DifJ5wKXzIovcvHaSZXiaVVHE4QRlCleURWbWOP3eYf7tEXNF2q02RYyViwQqapGC4V8n4NkBbnzYVkgG22Mht+cY0g0s9SW/kXypTtKlKB5ZaZW1THHkMwLEyXQXUHXdGSXruVWlzZNZg9IbrL2eipekjG+0YE3GTdRC5bGFNX+fj1sAuywNu03rTeVTTF5bZPx3LYAzE64LEwd1D3BtSIsnikPBSN2vL2olCNcLoc4D7knrHIc/yuRGCBwLAomKj91a6GocGPIBtTOxj3UGdJWv3M9DWjY5dPqpOJWQvwLABh2fTvb9z0BZPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(2906002)(8936002)(30864003)(7696005)(186003)(70586007)(6916009)(83380400001)(426003)(54906003)(81166007)(316002)(70206006)(5660300002)(36860700001)(36756003)(86362001)(82310400003)(336012)(44832011)(508600001)(1076003)(4326008)(16526019)(26005)(8676002)(6666004)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 09:32:45.2198 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e0d252-17c4-4ff1-a6ed-08d9953ee772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
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

v2: pass adev's vram_mgr instead of adev

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c   |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c       |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c      | 10 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c      |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c     |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 40 ++++++++------------
 7 files changed, 31 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7077f21f0021..df818e145d9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -531,9 +531,8 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);

-	return amdgpu_vram_mgr_usage(vram_man);
+	return amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
 }

 uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 76fe5b71e35d..7e745164a624 100644
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
+	used_vram = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
 	free_vram = used_vram >= total_vram ? 0 : total_vram - used_vram;

 	spin_lock(&adev->mm_stats.lock);
@@ -362,7 +361,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc)) {
 		u64 total_vis_vram = adev->gmc.visible_vram_size;
 		u64 used_vis_vram =
-		  amdgpu_vram_mgr_vis_usage(vram_man);
+		  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);

 		if (used_vis_vram < total_vis_vram) {
 			u64 free_vis_vram = total_vis_vram - used_vis_vram;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 603ce32db5c5..b426e03ad630 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -672,10 +672,10 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		ui64 = atomic64_read(&adev->num_vram_cpu_page_faults);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VRAM_USAGE:
-		ui64 = amdgpu_vram_mgr_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
+		ui64 = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VIS_VRAM_USAGE:
-		ui64 = amdgpu_vram_mgr_vis_usage(ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM));
+		ui64 = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_GTT_USAGE:
 		ui64 = amdgpu_gtt_mgr_usage(&adev->mman.gtt_mgr);
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
+			amdgpu_vram_mgr_usage(&adev->mman.vram_mgr);
 		mem.vram.max_allocation = mem.vram.usable_heap_size * 3 / 4;

 		mem.cpu_accessible_vram.total_heap_size =
@@ -729,7 +727,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			    atomic64_read(&adev->visible_pin_size),
 			    mem.vram.usable_heap_size);
 		mem.cpu_accessible_vram.heap_usage =
-			amdgpu_vram_mgr_vis_usage(vram_man);
+			amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
 		mem.cpu_accessible_vram.max_allocation =
 			mem.cpu_accessible_vram.usable_heap_size * 3 / 4;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 08133de21fdd..4114e0d35e82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1804,8 +1804,7 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 			.size = AMDGPU_GPU_PAGE_SIZE,
 			.flags = AMDGPU_RAS_RETIRE_PAGE_RESERVED,
 		};
-		status = amdgpu_vram_mgr_query_page_status(
-				ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+		status = amdgpu_vram_mgr_query_page_status(&adev->mman.vram_mgr,
 				data->bps[i].retired_page);
 		if (status == -EBUSY)
 			(*bps)[i].flags = AMDGPU_RAS_RETIRE_PAGE_PENDING;
@@ -1906,8 +1905,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
 			goto out;
 		}

-		amdgpu_vram_mgr_reserve_range(
-			ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM),
+		amdgpu_vram_mgr_reserve_range(&adev->mman.vram_mgr,
 			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT,
 			AMDGPU_GPU_PAGE_SIZE);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index af1c4e414979..ee8ab7846905 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -129,11 +129,11 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt);
-uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
-uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man);
-int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
+uint64_t amdgpu_vram_mgr_usage(struct amdgpu_vram_mgr *mgr);
+uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr);
+int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 				  uint64_t start, uint64_t size);
-int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 				      uint64_t start);

 int amdgpu_ttm_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 99c149397aae..a3c7a19047e8 100644
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
+	vf2pf_info->fb_usage = amdgpu_vram_mgr_usage(&adev->mman.vram_mgr) >> 20;
+	vf2pf_info->fb_vis_usage = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
 	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
 	vf2pf_info->fb_vis_size = adev->gmc.visible_vram_size >> 20;

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index 7b2b0980ec41..7a2b487db57c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -96,10 +96,9 @@ static ssize_t amdgpu_mem_info_vram_used_show(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct ttm_resource_manager *man;

-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_usage(man));
+	return sysfs_emit(buf, "%llu\n",
+			  amdgpu_vram_mgr_usage(&adev->mman.vram_mgr));
 }

 /**
@@ -116,10 +115,9 @@ static ssize_t amdgpu_mem_info_vis_vram_used_show(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	struct ttm_resource_manager *man;

-	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
-	return sysfs_emit(buf, "%llu\n", amdgpu_vram_mgr_vis_usage(man));
+	return sysfs_emit(buf, "%llu\n",
+			  amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr));
 }

 /**
@@ -263,16 +261,15 @@ static void amdgpu_vram_mgr_do_reserve(struct ttm_resource_manager *man)
 /**
  * amdgpu_vram_mgr_reserve_range - Reserve a range from VRAM
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_vram_mgr pointer
  * @start: start address of the range in VRAM
  * @size: size of the range
  *
- * Reserve memory from start addess with the specified size in VRAM
+ * Reserve memory from start address with the specified size in VRAM
  */
-int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 				  uint64_t start, uint64_t size)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct amdgpu_vram_reservation *rsv;

 	rsv = kzalloc(sizeof(*rsv), GFP_KERNEL);
@@ -285,7 +282,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,

 	spin_lock(&mgr->lock);
 	list_add_tail(&mgr->reservations_pending, &rsv->node);
-	amdgpu_vram_mgr_do_reserve(man);
+	amdgpu_vram_mgr_do_reserve(&mgr->manager);
 	spin_unlock(&mgr->lock);

 	return 0;
@@ -294,7 +291,7 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
 /**
  * amdgpu_vram_mgr_query_page_status - query the reservation status
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_vram_mgr pointer
  * @start: start address of a page in VRAM
  *
  * Returns:
@@ -302,10 +299,9 @@ int amdgpu_vram_mgr_reserve_range(struct ttm_resource_manager *man,
  *	0: the page has been reserved
  *	-ENOENT: the input page is not a reservation
  */
-int amdgpu_vram_mgr_query_page_status(struct ttm_resource_manager *man,
+int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 				      uint64_t start)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
 	struct amdgpu_vram_reservation *rsv;
 	int ret;

@@ -632,28 +628,24 @@ void amdgpu_vram_mgr_free_sgt(struct device *dev,
 /**
  * amdgpu_vram_mgr_usage - how many bytes are used in this domain
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_vram_mgr pointer
  *
  * Returns how many bytes are used in this domain.
  */
-uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man)
+uint64_t amdgpu_vram_mgr_usage(struct amdgpu_vram_mgr *mgr)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
-
 	return atomic64_read(&mgr->usage);
 }

 /**
  * amdgpu_vram_mgr_vis_usage - how many bytes are used in the visible part
  *
- * @man: TTM memory type manager
+ * @mgr: amdgpu_vram_mgr pointer
  *
  * Returns how many bytes are used in the visible part of VRAM
  */
-uint64_t amdgpu_vram_mgr_vis_usage(struct ttm_resource_manager *man)
+uint64_t amdgpu_vram_mgr_vis_usage(struct amdgpu_vram_mgr *mgr)
 {
-	struct amdgpu_vram_mgr *mgr = to_vram_mgr(man);
-
 	return atomic64_read(&mgr->vis_usage);
 }

@@ -675,8 +667,8 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	spin_unlock(&mgr->lock);

 	drm_printf(printer, "man size:%llu pages, ram usage:%lluMB, vis usage:%lluMB\n",
-		   man->size, amdgpu_vram_mgr_usage(man) >> 20,
-		   amdgpu_vram_mgr_vis_usage(man) >> 20);
+		   man->size, amdgpu_vram_mgr_usage(mgr) >> 20,
+		   amdgpu_vram_mgr_vis_usage(mgr) >> 20);
 }

 static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
--
2.32.0

