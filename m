Return-Path: <SRS0=2AtA=PH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B11C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DFE60F8F
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Oct 2021 21:15:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37DFE60F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A289C6EB70;
	Tue, 19 Oct 2021 21:15:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2066.outbound.protection.outlook.com [40.107.95.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02A1C6E8E5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Oct 2021 21:15:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJeSQwk9xKkbBI1YC1s+ASlWOmRTkz7RCf1a16WKTSCIlkGo+X/7DGNFz7CeHne7xEpCCBIk1jQq2HSjVWhlIWYhPCikDhhVi2kWDUYvjFNlBUKFdDOlofCjmayblhM8q6iXF4Zb5LBbq4JEg6LGo22uxAith9vsh0ktmiJIMfb4gcNSui7o76vElFIAnMD/HxzrMa+aU9pVf1s0iwOwGb0k2Z3KKIRfuF09FP76hh2djKJbkGcNli3sXZSKL+DbJ0nRFAkh53CGEaYbHjelKn6G1CBZarJQDjuqJyZA1NiM3vhwme/OibzEyCft8KSJjMg0jhHcUCbmnzQx951qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=An+CboFiLNPoEhl3WnbfFm5mePiy5BKk7CUezCtfkmE=;
 b=eguP1W2bBeFpSJKOXg8AqjCNTUj+5hclcHnl0hz4lgAfer1JY75ok1HZj7SP5uZRefcrOIQNYVNXXgBl+6XNc2SRCQ38LxuAEDgE1aBw/fbKfzzmfjojnTrgin6g9QhVxU8XoeX0hxbV77sKvXXcNLLWYvrL4635suEoMMhxyZklqtpq1LkE2OC0KOSFBrNzJI/YPPJG8RcMn64kKdKKmF/5Pj2gpcXJnUSmafm9i7IFnhZ+1iRf3JtPSPetv1bW/xYViJVzr7UiDu18g7/gxa8i1MrFcF16VNi8KWJ8ToMrMG7REgChD//JcNNO7PGqIUQL/BUvl9gicUyXN0/a1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An+CboFiLNPoEhl3WnbfFm5mePiy5BKk7CUezCtfkmE=;
 b=G1nVy9Ia7vyP9N4Ct5eqzI5godX2dwMo7DDYyQwQYfw9pzaQfr6rzyOptozbZSLEjojDiaFK4bfsnFJE3M2zSyckUItC6pdYGXXucihpjUH3tY5nsSZu1wPkZpdIuffyzsxeTIWXPbJWfoRIrofBIvgR5McSbeemFPCQQJeOOow=
Received: from BN9PR03CA0327.namprd03.prod.outlook.com (2603:10b6:408:112::32)
 by DM6PR12MB3419.namprd12.prod.outlook.com (2603:10b6:5:3c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Tue, 19 Oct
 2021 21:15:02 +0000
Received: from BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::8b) by BN9PR03CA0327.outlook.office365.com
 (2603:10b6:408:112::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 21:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT031.mail.protection.outlook.com (10.13.177.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Tue, 19 Oct 2021 21:15:01 +0000
Received: from mkgs-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 16:14:58 -0500
From: Graham Sider <Graham.Sider@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <mukul.joshi@amd.com>, Graham Sider
 <Graham.Sider@amd.com>
Subject: [PATCH 10/13] drm/amdkfd: replace kgd_dev in get amdgpu_amdkfd funcs
Date: Tue, 19 Oct 2021 17:13:31 -0400
Message-ID: <20211019211334.1552825-10-Graham.Sider@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211019211334.1552825-1-Graham.Sider@amd.com>
References: <20211019211334.1552825-1-Graham.Sider@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1357acec-2f12-43d5-cbc5-08d99345835c
X-MS-TrafficTypeDiagnostic: DM6PR12MB3419:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3419E1390EEEA07DA92B9B4A8ABD9@DM6PR12MB3419.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wx7CQDmCl5or+jAYBhVCUPvSkGPeoRrliLv6H9QisSbeqVJqA12HQxpetNdoa8iKc01POcHC92OT+f/YMAXLz4PVFwkcr+Ai8amiapzWtKFQbiJanwceGBI6bs3i079magbIHiaEM9ev3L+95WcSI9pVTxyEqdr+vt4il/7OKdMiaxyOeJP45ZRIROKelzmogDCsGJBkCcc8qYahzZNxQP+ACEKN24CK07sH8KqvZxpEVQIpv7JLuF0NJfR3p5W1bQ4MHRh8J5vSlVpnuQvZGNYn7HpW4jRWO3XQ5GRz4nSvK7561ledQUq7rTNf1w0fqMGXwoJQnDNiecF1Fzl7Kz+kIe2y6PAVfKC2Jpnh81X+oWU2PPGf10M2pCXZOrEf8IxaaF8eLALXcmGByK0n7wnUTwoXYrUYXS7iYYCvW2BYSWxkt7sK7Un6UQ6bJEa95DnphjGPqWxMRHyFeH2L9UA75LmGvK6j2nbqMT/0iBgFhK8lJogMmvJLqjPexiwZl505T+M4LnVVT7jrOHM7OjOmgun+9phglH/Kple8WOHX4/exMpoFdCmpCsQLMmUDP7Vrwq1eMeI0Qyjrxpud3vVudDtY3f327gY+59iMz6xewFGyFjHJCi80gjBWT+yVqX4nR/7dczscIvIdhZ2dixsJ9ieX9xpMpM1dnyqpHyztWhy+L7+FBTKFI5hDcUdm70ktPgwwa4G4jaRHjLsAIGVX3nkp269uUckxPkWq9Fc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(5660300002)(2906002)(16526019)(6666004)(4326008)(186003)(26005)(1076003)(8676002)(6916009)(316002)(36756003)(81166007)(86362001)(30864003)(2616005)(70206006)(70586007)(336012)(82310400003)(7696005)(47076005)(54906003)(8936002)(508600001)(36860700001)(83380400001)(426003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 21:15:01.5109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1357acec-2f12-43d5-cbc5-08d99345835c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3419
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

Modified definitions:

- amdgpu_amdkfd_get_fw_version
- amdgpu_amdkfd_get_local_mem_info
- amdgpu_amdkfd_get_gpu_clock_counter
- amdgpu_amdkfd_get_max_engine_clock_in_mhz
- amdgpu_amdkfd_get_cu_info
- amdgpu_amdkfd_get_dmabuf_info
- amdgpu_amdkfd_get_vram_usage
- amdgpu_amdkfd_get_hive_id
- amdgpu_amdkfd_get_unique_id
- amdgpu_amdkfd_get_mmio_remap_phys_addr
- amdgpu_amdkfd_get_num_gws
- amdgpu_amdkfd_get_asic_rev_id
- amdgpu_amdkfd_get_noretry
- amdgpu_amdkfd_get_xgmi_hops_count
- amdgpu_amdkfd_get_xgmi_bandwidth_mbytes
- amdgpu_amdkfd_get_pcie_bandwidth_mbytes

Also replaces kfd_device_by_kgd with kfd_device_by_adev, now
searching via adev rather than kgd.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 73 +++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 38 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 16 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         | 16 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       | 14 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 18 ++---
 9 files changed, 82 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 69fc8f0d9c45..79a2e37baa59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -358,11 +358,9 @@ void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj)
 	amdgpu_bo_unref(&bo);
 }
 
-uint32_t amdgpu_amdkfd_get_fw_version(struct kgd_dev *kgd,
+uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 				      enum kgd_engine_type type)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	switch (type) {
 	case KGD_ENGINE_PFP:
 		return adev->gfx.pfp_fw_version;
@@ -395,11 +393,9 @@ uint32_t amdgpu_amdkfd_get_fw_version(struct kgd_dev *kgd,
 	return 0;
 }
 
-void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
+void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 				      struct kfd_local_mem_info *mem_info)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	memset(mem_info, 0, sizeof(*mem_info));
 
 	mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
@@ -424,19 +420,15 @@ void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
 		mem_info->mem_clk_max = 100;
 }
 
-uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct kgd_dev *kgd)
+uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	if (adev->gfx.funcs->get_gpu_clock_counter)
 		return adev->gfx.funcs->get_gpu_clock_counter(adev);
 	return 0;
 }
 
-uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
+uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	/* the sclk is in quantas of 10kHz */
 	if (amdgpu_sriov_vf(adev))
 		return adev->clock.default_sclk / 100;
@@ -446,9 +438,8 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd)
 		return 100;
 }
 
-void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info)
+void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev, struct kfd_cu_info *cu_info)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct amdgpu_cu_info acu_info = adev->gfx.cu_info;
 
 	memset(cu_info, 0, sizeof(*cu_info));
@@ -469,13 +460,12 @@ void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info)
 	cu_info->lds_size = acu_info.lds_size;
 }
 
-int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
-				  struct kgd_dev **dma_buf_kgd,
+int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
+				  struct amdgpu_device **dmabuf_adev,
 				  uint64_t *bo_size, void *metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
 				  uint32_t *flags)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct dma_buf *dma_buf;
 	struct drm_gem_object *obj;
 	struct amdgpu_bo *bo;
@@ -503,8 +493,8 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 		goto out_put;
 
 	r = 0;
-	if (dma_buf_kgd)
-		*dma_buf_kgd = (struct kgd_dev *)adev;
+	if (dmabuf_adev)
+		*dmabuf_adev = adev;
 	if (bo_size)
 		*bo_size = amdgpu_bo_size(bo);
 	if (metadata_buffer)
@@ -524,32 +514,28 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 	return r;
 }
 
-uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd)
+uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
 	struct ttm_resource_manager *vram_man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
 
 	return amdgpu_vram_mgr_usage(vram_man);
 }
 
-uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd)
+uint64_t amdgpu_amdkfd_get_hive_id(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	return adev->gmc.xgmi.hive_id;
 }
 
-uint64_t amdgpu_amdkfd_get_unique_id(struct kgd_dev *kgd)
+uint64_t amdgpu_amdkfd_get_unique_id(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	return adev->unique_id;
 }
 
-uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src)
+uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
+					  struct amdgpu_device *src)
 {
-	struct amdgpu_device *peer_adev = (struct amdgpu_device *)src;
-	struct amdgpu_device *adev = (struct amdgpu_device *)dst;
+	struct amdgpu_device *peer_adev = src;
+	struct amdgpu_device *adev = dst;
 	int ret = amdgpu_xgmi_get_hops_count(adev, peer_adev);
 
 	if (ret < 0) {
@@ -561,16 +547,18 @@ uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *s
 	return  (uint8_t)ret;
 }
 
-int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min)
+int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
+					    struct amdgpu_device *src,
+					    bool is_min)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)dst, *peer_adev;
+	struct amdgpu_device *adev = dst, *peer_adev;
 	int num_links;
 
 	if (adev->asic_type != CHIP_ALDEBARAN)
 		return 0;
 
 	if (src)
-		peer_adev = (struct amdgpu_device *)src;
+		peer_adev = src;
 
 	/* num links returns 0 for indirect peers since indirect route is unknown. */
 	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
@@ -585,9 +573,8 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev
 	return (num_links * 16 * 25000)/BITS_PER_BYTE;
 }
 
-int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min)
+int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)dev;
 	int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
 							fls(adev->pm.pcie_mlw_mask)) - 1;
 	int gen_speed_shift = (is_min ? ffs(adev->pm.pcie_gen_mask &
@@ -643,31 +630,23 @@ int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min)
 	return (num_lanes_factor * gen_speed_mbits_factor)/BITS_PER_BYTE;
 }
 
-uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd)
+uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	return adev->rmmio_remap.bus_addr;
 }
 
-uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd)
+uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	return adev->gds.gws_size;
 }
 
-uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd)
+uint32_t amdgpu_amdkfd_get_asic_rev_id(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	return adev->rev_id;
 }
 
-int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd)
+int amdgpu_amdkfd_get_noretry(struct amdgpu_device *adev)
 {
-	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-
 	return adev->gmc.noretry;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 8d5c18953723..7e3697a7a5cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -209,29 +209,33 @@ int amdgpu_amdkfd_alloc_gws(struct amdgpu_device *adev, size_t size,
 void amdgpu_amdkfd_free_gws(struct amdgpu_device *adev, void *mem_obj);
 int amdgpu_amdkfd_add_gws_to_process(void *info, void *gws, struct kgd_mem **mem);
 int amdgpu_amdkfd_remove_gws_from_process(void *info, void *mem);
-uint32_t amdgpu_amdkfd_get_fw_version(struct kgd_dev *kgd,
+uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 				      enum kgd_engine_type type);
-void amdgpu_amdkfd_get_local_mem_info(struct kgd_dev *kgd,
+void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 				      struct kfd_local_mem_info *mem_info);
-uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct kgd_dev *kgd);
+uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
 
-uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct kgd_dev *kgd);
-void amdgpu_amdkfd_get_cu_info(struct kgd_dev *kgd, struct kfd_cu_info *cu_info);
-int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
-				  struct kgd_dev **dmabuf_kgd,
+uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
+void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev,
+			       struct kfd_cu_info *cu_info);
+int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
+				  struct amdgpu_device **dmabuf_adev,
 				  uint64_t *bo_size, void *metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
 				  uint32_t *flags);
-uint64_t amdgpu_amdkfd_get_vram_usage(struct kgd_dev *kgd);
-uint64_t amdgpu_amdkfd_get_hive_id(struct kgd_dev *kgd);
-uint64_t amdgpu_amdkfd_get_unique_id(struct kgd_dev *kgd);
-uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct kgd_dev *kgd);
-uint32_t amdgpu_amdkfd_get_num_gws(struct kgd_dev *kgd);
-uint32_t amdgpu_amdkfd_get_asic_rev_id(struct kgd_dev *kgd);
-int amdgpu_amdkfd_get_noretry(struct kgd_dev *kgd);
-uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct kgd_dev *dst, struct kgd_dev *src);
-int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct kgd_dev *dst, struct kgd_dev *src, bool is_min);
-int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct kgd_dev *dev, bool is_min);
+uint64_t amdgpu_amdkfd_get_vram_usage(struct amdgpu_device *adev);
+uint64_t amdgpu_amdkfd_get_hive_id(struct amdgpu_device *adev);
+uint64_t amdgpu_amdkfd_get_unique_id(struct amdgpu_device *adev);
+uint64_t amdgpu_amdkfd_get_mmio_remap_phys_addr(struct amdgpu_device *adev);
+uint32_t amdgpu_amdkfd_get_num_gws(struct amdgpu_device *adev);
+uint32_t amdgpu_amdkfd_get_asic_rev_id(struct amdgpu_device *adev);
+int amdgpu_amdkfd_get_noretry(struct amdgpu_device *adev);
+uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
+					  struct amdgpu_device *src);
+int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
+					    struct amdgpu_device *src,
+					    bool is_min);
+int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 7c4f14410a74..47acfef1aebd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -850,7 +850,7 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 	dev = kfd_device_by_id(args->gpu_id);
 	if (dev)
 		/* Reading GPU clock counter from KGD */
-		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(dev->kgd);
+		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(dev->adev);
 	else
 		/* Node without GPU resource */
 		args->gpu_clock_counter = 0;
@@ -1237,7 +1237,7 @@ bool kfd_dev_is_large_bar(struct kfd_dev *dev)
 	if (dev->use_iommu_v2)
 		return false;
 
-	amdgpu_amdkfd_get_local_mem_info(dev->kgd, &mem_info);
+	amdgpu_amdkfd_get_local_mem_info(dev->adev, &mem_info);
 	if (mem_info.local_mem_size_private == 0 &&
 			mem_info.local_mem_size_public > 0)
 		return true;
@@ -1306,7 +1306,7 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
 			err = -EINVAL;
 			goto err_unlock;
 		}
-		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
+		offset = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->adev);
 		if (!offset) {
 			err = -ENOMEM;
 			goto err_unlock;
@@ -1664,7 +1664,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 {
 	struct kfd_ioctl_get_dmabuf_info_args *args = data;
 	struct kfd_dev *dev = NULL;
-	struct kgd_dev *dma_buf_kgd;
+	struct amdgpu_device *dmabuf_adev;
 	void *metadata_buffer = NULL;
 	uint32_t flags;
 	unsigned int i;
@@ -1684,15 +1684,15 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 	}
 
 	/* Get dmabuf info from KGD */
-	r = amdgpu_amdkfd_get_dmabuf_info(dev->kgd, args->dmabuf_fd,
-					  &dma_buf_kgd, &args->size,
+	r = amdgpu_amdkfd_get_dmabuf_info(dev->adev, args->dmabuf_fd,
+					  &dmabuf_adev, &args->size,
 					  metadata_buffer, args->metadata_size,
 					  &args->metadata_size, &flags);
 	if (r)
 		goto exit;
 
 	/* Reverse-lookup gpu_id from kgd pointer */
-	dev = kfd_device_by_kgd(dma_buf_kgd);
+	dev = kfd_device_by_adev(dmabuf_adev);
 	if (!dev) {
 		r = -EINVAL;
 		goto exit;
@@ -2050,7 +2050,7 @@ static int kfd_mmio_mmap(struct kfd_dev *dev, struct kfd_process *process,
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
 		return -EINVAL;
 
-	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->kgd);
+	address = amdgpu_amdkfd_get_mmio_remap_phys_addr(dev->adev);
 
 	vma->vm_flags |= VM_IO | VM_DONTCOPY | VM_DONTEXPAND | VM_NORESERVE |
 				VM_DONTDUMP | VM_PFNMAP;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index cfedfb1e8596..7143550becb0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1993,16 +1993,16 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		if (adev->asic_type == CHIP_ALDEBARAN) {
 			sub_type_hdr->minimum_bandwidth_mbs =
 					amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
-							kdev->kgd, NULL, true);
+							kdev->adev, NULL, true);
 			sub_type_hdr->maximum_bandwidth_mbs =
 					sub_type_hdr->minimum_bandwidth_mbs;
 		}
 	} else {
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
 		sub_type_hdr->minimum_bandwidth_mbs =
-				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, true);
+				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->adev, true);
 		sub_type_hdr->maximum_bandwidth_mbs =
-				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->kgd, false);
+				amdgpu_amdkfd_get_pcie_bandwidth_mbytes(kdev->adev, false);
 	}
 
 	sub_type_hdr->proximity_domain_from = proximity_domain;
@@ -2044,11 +2044,11 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 	sub_type_hdr->proximity_domain_from = proximity_domain_from;
 	sub_type_hdr->proximity_domain_to = proximity_domain_to;
 	sub_type_hdr->num_hops_xgmi =
-		amdgpu_amdkfd_get_xgmi_hops_count(kdev->kgd, peer_kdev->kgd);
+		amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev, peer_kdev->adev);
 	sub_type_hdr->maximum_bandwidth_mbs =
-		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, peer_kdev->kgd, false);
+		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, peer_kdev->adev, false);
 	sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
-		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->kgd, NULL, true) : 0;
+		amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, NULL, true) : 0;
 
 	return 0;
 }
@@ -2114,7 +2114,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	cu->flags |= CRAT_CU_FLAGS_GPU_PRESENT;
 	cu->proximity_domain = proximity_domain;
 
-	amdgpu_amdkfd_get_cu_info(kdev->kgd, &cu_info);
+	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
 	cu->num_simd_per_cu = cu_info.simd_per_cu;
 	cu->num_simd_cores = cu_info.simd_per_cu * cu_info.cu_active_number;
 	cu->max_waves_simd = cu_info.max_waves_per_simd;
@@ -2145,7 +2145,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	 * report the total FB size (public+private) as a single
 	 * private heap.
 	 */
-	amdgpu_amdkfd_get_local_mem_info(kdev->kgd, &local_mem_info);
+	amdgpu_amdkfd_get_local_mem_info(kdev->adev, &local_mem_info);
 	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
 			sub_type_hdr->length);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index a90ec8de213b..00c726123207 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -894,7 +894,7 @@ static int kfd_gws_init(struct kfd_dev *kfd)
 		|| (kfd->device_info->asic_family == CHIP_ALDEBARAN
 			&& kfd->mec2_fw_version >= 0x28))
 		ret = amdgpu_amdkfd_alloc_gws(kfd->adev,
-				amdgpu_amdkfd_get_num_gws(kfd->kgd), &kfd->gws);
+				amdgpu_amdkfd_get_num_gws(kfd->adev), &kfd->gws);
 
 	return ret;
 }
@@ -911,11 +911,11 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	unsigned int size, map_process_packet_size;
 
 	kfd->ddev = ddev;
-	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
+	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_MEC1);
-	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
+	kfd->mec2_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_MEC2);
-	kfd->sdma_fw_version = amdgpu_amdkfd_get_fw_version(kfd->kgd,
+	kfd->sdma_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_SDMA1);
 	kfd->shared_resources = *gpu_resources;
 
@@ -996,9 +996,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 		goto kfd_doorbell_error;
 	}
 
-	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->kgd);
+	kfd->hive_id = amdgpu_amdkfd_get_hive_id(kfd->adev);
 
-	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->kgd);
+	kfd->noretry = amdgpu_amdkfd_get_noretry(kfd->adev);
 
 	if (kfd_interrupt_init(kfd)) {
 		dev_err(kfd_device, "Error initializing interrupts\n");
@@ -1016,7 +1016,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	 */
 	if (kfd_gws_init(kfd)) {
 		dev_err(kfd_device, "Could not allocate %d gws\n",
-			amdgpu_amdkfd_get_num_gws(kfd->kgd));
+			amdgpu_amdkfd_get_num_gws(kfd->adev));
 		goto gws_error;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index c021519af810..7b4118915bf6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -100,7 +100,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	struct kfd_cu_info cu_info;
 	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
 	int i, se, sh, cu;
-	amdgpu_amdkfd_get_cu_info(mm->dev->kgd, &cu_info);
+	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
 
 	if (cu_mask_count > cu_info.cu_active_number)
 		cu_mask_count = cu_info.cu_active_number;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c8bd062fb954..499db2099775 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -969,7 +969,7 @@ struct kfd_topology_device *kfd_topology_device_by_proximity_domain(
 struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_id(uint32_t gpu_id);
 struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev);
-struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd);
+struct kfd_dev *kfd_device_by_adev(const struct amdgpu_device *adev);
 int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_dev **kdev);
 int kfd_numa_node_to_apic_id(int numa_node_id);
 void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 243dd1efcdbf..d8462bd3b4a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -118,7 +118,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
 		return ret;
 
 	pqn->q->gws = mem;
-	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->kgd) : 0;
+	pdd->qpd.num_gws = gws ? amdgpu_amdkfd_get_num_gws(dev->adev) : 0;
 
 	return pqn->q->device->dqm->ops.update_queue(pqn->q->device->dqm,
 							pqn->q);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index dd593ad0614a..31610b4a3e2e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -113,7 +113,7 @@ struct kfd_dev *kfd_device_by_pci_dev(const struct pci_dev *pdev)
 	return device;
 }
 
-struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd)
+struct kfd_dev *kfd_device_by_adev(const struct amdgpu_device *adev)
 {
 	struct kfd_topology_device *top_dev;
 	struct kfd_dev *device = NULL;
@@ -121,7 +121,7 @@ struct kfd_dev *kfd_device_by_kgd(const struct kgd_dev *kgd)
 	down_read(&topology_lock);
 
 	list_for_each_entry(top_dev, &topology_device_list, list)
-		if (top_dev->gpu && top_dev->gpu->kgd == kgd) {
+		if (top_dev->gpu && top_dev->gpu->adev == adev) {
 			device = top_dev->gpu;
 			break;
 		}
@@ -531,7 +531,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 		sysfs_show_32bit_prop(buffer, offs, "sdma_fw_version",
 				      dev->gpu->sdma_fw_version);
 		sysfs_show_64bit_prop(buffer, offs, "unique_id",
-				      amdgpu_amdkfd_get_unique_id(dev->gpu->kgd));
+				      amdgpu_amdkfd_get_unique_id(dev->gpu->adev));
 
 	}
 
@@ -1106,7 +1106,7 @@ static uint32_t kfd_generate_gpu_id(struct kfd_dev *gpu)
 	if (!gpu)
 		return 0;
 
-	amdgpu_amdkfd_get_local_mem_info(gpu->kgd, &local_mem_info);
+	amdgpu_amdkfd_get_local_mem_info(gpu->adev, &local_mem_info);
 
 	local_mem_size = local_mem_info.local_mem_size_private +
 			local_mem_info.local_mem_size_public;
@@ -1189,7 +1189,7 @@ static void kfd_fill_mem_clk_max_info(struct kfd_topology_device *dev)
 	 * for APUs - If CRAT from ACPI reports more than one bank, then
 	 *	all the banks will report the same mem_clk_max information
 	 */
-	amdgpu_amdkfd_get_local_mem_info(dev->gpu->kgd, &local_mem_info);
+	amdgpu_amdkfd_get_local_mem_info(dev->gpu->adev, &local_mem_info);
 
 	list_for_each_entry(mem, &dev->mem_props, list)
 		mem->mem_clk_max = local_mem_info.mem_clk_max;
@@ -1372,7 +1372,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	 * needed for the topology
 	 */
 
-	amdgpu_amdkfd_get_cu_info(dev->gpu->kgd, &cu_info);
+	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
 
 	strncpy(dev->node_props.name, gpu->device_info->asic_name,
 			KFD_TOPOLOGY_PUBLIC_NAME_SIZE);
@@ -1384,13 +1384,13 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.vendor_id = gpu->pdev->vendor;
 	dev->node_props.device_id = gpu->pdev->device;
 	dev->node_props.capability |=
-		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->kgd) <<
+		((amdgpu_amdkfd_get_asic_rev_id(dev->gpu->adev) <<
 			HSA_CAP_ASIC_REVISION_SHIFT) &
 			HSA_CAP_ASIC_REVISION_MASK);
 	dev->node_props.location_id = pci_dev_id(gpu->pdev);
 	dev->node_props.domain = pci_domain_nr(gpu->pdev->bus);
 	dev->node_props.max_engine_clk_fcompute =
-		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->kgd);
+		amdgpu_amdkfd_get_max_engine_clock_in_mhz(dev->gpu->adev);
 	dev->node_props.max_engine_clk_ccompute =
 		cpufreq_quick_get_max(0) / 1000;
 	dev->node_props.drm_render_minor =
@@ -1404,7 +1404,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 				gpu->device_info->num_sdma_queues_per_engine;
 	dev->node_props.num_gws = (dev->gpu->gws &&
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
-		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
+		amdgpu_amdkfd_get_num_gws(dev->gpu->adev) : 0;
 	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
 
 	kfd_fill_mem_clk_max_info(dev);
-- 
2.25.1

