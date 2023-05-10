Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848CBC7EE25
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 21:24:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D451710E546;
	Wed, 10 May 2023 21:24:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7E3610E53E
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 21:24:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5a8zl8u14CGJVV8uzQrXqp5PiiFauYaF1753g4jafVMp3LCeTxmJDharb6fj8qs1JuiHFrUflj9CADcN5zDhdrftdZcAAgbYOeiEQnf2lnLw0IGKZ4oG4naPzAFpfpK45Nkw3jMHzH61OrhqqdRlIQd1So6KgvIIvQ+AvHR7oqHKnfOYkpzo6eAqn0Sn/L2yVy2B2/ZdkwyeJHhTK4tKrg6Bvs5OE6SeRYKPZvKcYZHu7E1Vxa+SEjRukzhhCp0QskfWe32CpagURWI80xVNHBb3Wp8NStirN+zmSAxGvwkgrtpy1tHxYiAoR4nrfUdoFEH1JLu0XJKdeFuBis8DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfCZ/5WBJ2kfa8kaGIpSMcu9TGbdHlwCuUWL5nvlqm4=;
 b=DdQ5eeWjJwkkCB8zfTnHVEcSEwzcFRN6tZbHmsduyUFwNvJkPD5QYIYhjbFY6svdpz+A4Tkmo1Xx+qPcA/ia5N/3nCUgQwwTi07RSRBgsH1X1Ed0pzNmwupXlhPKStiH1gv6235QF+nWoYGOtWD99QZuYnjYVkRhIXG3eBD2yPxhzDWWDNBdlOz0FzjCXkGQH4PFghf1NM0lQ8ue5rJyJ0Kc5kz1LbRBLo69iF6Q2L0AckL0MN73Y1Uu7RGKrz1MK5spkguYGXxULcDFV/SQm1QvsmE8Ux3b3hJorMKiBO6ZUvZILkwuqvA8ironuFfuZGWlm1qlx5cpLSioflLy9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfCZ/5WBJ2kfa8kaGIpSMcu9TGbdHlwCuUWL5nvlqm4=;
 b=yrnwLljgiDLn0LiOuKrXkwa3k7MTPfrjOjMUkhMwbXP5vakvnW/CXcNEiVo8Aj7lkOiGDHxvxPgZAnf/F5zd5qTIf5TymOaHhQqY1jpYEytD9P6EHTAd8W3j7J5vf1I1gpq1ANyEwyt5rZ4VmKjQbzJgVWxow9cB6X36jmb7FrA=
Received: from MW4PR04CA0354.namprd04.prod.outlook.com (2603:10b6:303:8a::29)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Wed, 10 May
 2023 21:24:02 +0000
Received: from CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::7e) by MW4PR04CA0354.outlook.office365.com
 (2603:10b6:303:8a::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20 via Frontend
 Transport; Wed, 10 May 2023 21:24:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT033.mail.protection.outlook.com (10.13.174.247) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.21 via Frontend Transport; Wed, 10 May 2023 21:24:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 16:23:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/29] drm/amdgpu: KFD graphics interop support compute
 partition
Date: Wed, 10 May 2023 17:23:26 -0400
Message-ID: <20230510212333.2071373-22-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510212333.2071373-1-alexander.deucher@amd.com>
References: <20230510212333.2071373-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT033:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f16606c-8566-4a81-8507-08db519ce004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jhW2LElD6rdrOMNdredupUOTBURCL76AsXSSPLtqHyxQsowkkrt1yp3rQLrNcc8LkMqkNnmu825QTm356i5rm3XdUikD2BzbkRirYuEJ2K/0iCZpyum/bg+uNlq0EojuEB7oI59ZoDuNVoSlNqGTMGvwI7PQH0WkzJBmd6KC6PKC59I6nxuONSLNPzrxKOwFpR1yIEEcrP52ap3+X4OyLV731mNQF64zLrn40Ci4yhimH7SW5e/5ItVnC9gKnL08cuAIDa/GOYUEZQ/0nh5pnl9ew0hrnB5h0nTkYHLXTI0Puvh1UD279p9DcnG2sV9aG6QGdMJo8wELWuIVDt9pd3W9ELlp+qcvL84jXLh7nieInIrbBikTxA/b1g9lNjVTeAqj10TE8FzLV3YdqNJ7Q7BVujzVG36TOtIEi59vrjhTntbIKh/svgVDEm/FBOq82/IL7NNotRvrgduQpsovA7fSQ5VFnXdCIjoqdizNSVFKDTyknIzPrSRMooX9MjZr60hd2iMKEpXhei54BqVQyl+2/r/SajiEFhqphdahPYw268qoqVafX7TfKhteu4iLHaSZGAKIWsBosoAyXBYspQQcuFP4DeULr3mVPB4ElWRAQVZtvbm9XW8VcoDhfnx1oMA8Qy+q7PdQh6hcwrRESloIIU089DHqZOCc5dVeivnZwEg342LqIDPNF3Xj5Gjsi1kLRjy8QoXsoP6fjWpOtBwvddhCRgcqiCFHzcAqSE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(86362001)(81166007)(356005)(316002)(41300700001)(40480700001)(40460700003)(2906002)(36756003)(36860700001)(186003)(8936002)(8676002)(26005)(16526019)(5660300002)(478600001)(82740400003)(1076003)(426003)(336012)(54906003)(7696005)(6666004)(83380400001)(70586007)(4326008)(70206006)(82310400005)(6916009)(47076005)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 21:24:01.6479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f16606c-8566-4a81-8507-08db519ce004
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

kfd_ioctl_get_dmabuf use the amdgpu bo xcp_id to get the gpu_id of the
KFD node from the exported dmabuf_adev, and then create kfd bo on the
correct adev and KFD node when importing the amdgpu bo to KFD.

Remove function kfd_device_by_adev, it is not needed as it is the same
result as dmabuf_adev->kfd.dev->nodes[0]->id.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 14 ++++++--------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 18 ------------------
 5 files changed, 10 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index bbbfe9ec4adf..00edb13d2124 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -498,7 +498,7 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  struct amdgpu_device **dmabuf_adev,
 				  uint64_t *bo_size, void *metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
-				  uint32_t *flags)
+				  uint32_t *flags, int8_t *xcp_id)
 {
 	struct dma_buf *dma_buf;
 	struct drm_gem_object *obj;
@@ -542,6 +542,8 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
 			*flags |= KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC;
 	}
+	if (xcp_id)
+		*xcp_id = bo->xcp_id;
 
 out_put:
 	dma_buf_put(dma_buf);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 05c54776951b..4e6221bccffe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -241,7 +241,7 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  struct amdgpu_device **dmabuf_adev,
 				  uint64_t *bo_size, void *metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
-				  uint32_t *flags);
+				  uint32_t *flags, int8_t *xcp_id);
 uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
 					  struct amdgpu_device *src);
 int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 8c86d69938ea..344b238d6771 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1499,6 +1499,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 	struct amdgpu_device *dmabuf_adev;
 	void *metadata_buffer = NULL;
 	uint32_t flags;
+	int8_t xcp_id;
 	unsigned int i;
 	int r;
 
@@ -1519,17 +1520,14 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 	r = amdgpu_amdkfd_get_dmabuf_info(dev->adev, args->dmabuf_fd,
 					  &dmabuf_adev, &args->size,
 					  metadata_buffer, args->metadata_size,
-					  &args->metadata_size, &flags);
+					  &args->metadata_size, &flags, &xcp_id);
 	if (r)
 		goto exit;
 
-	/* Reverse-lookup gpu_id from kgd pointer */
-	dev = kfd_device_by_adev(dmabuf_adev);
-	if (!dev) {
-		r = -EINVAL;
-		goto exit;
-	}
-	args->gpu_id = dev->id;
+	if (xcp_id >= 0)
+		args->gpu_id = dmabuf_adev->kfd.dev->nodes[xcp_id]->id;
+	else
+		args->gpu_id = dmabuf_adev->kfd.dev->nodes[0]->id;
 	args->flags = flags;
 
 	/* Copy metadata buffer to user mode */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 214d950f948e..44f4d5509db6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1068,7 +1068,6 @@ struct kfd_topology_device *kfd_topology_device_by_proximity_domain_no_lock(
 struct kfd_topology_device *kfd_topology_device_by_id(uint32_t gpu_id);
 struct kfd_node *kfd_device_by_id(uint32_t gpu_id);
 struct kfd_node *kfd_device_by_pci_dev(const struct pci_dev *pdev);
-struct kfd_node *kfd_device_by_adev(const struct amdgpu_device *adev);
 static inline bool kfd_irq_is_from_node(struct kfd_node *node, uint32_t node_id,
 					uint32_t vmid)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index a8e25aecf839..dbb6159344b3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -125,24 +125,6 @@ struct kfd_node *kfd_device_by_pci_dev(const struct pci_dev *pdev)
 	return device;
 }
 
-struct kfd_node *kfd_device_by_adev(const struct amdgpu_device *adev)
-{
-	struct kfd_topology_device *top_dev;
-	struct kfd_node *device = NULL;
-
-	down_read(&topology_lock);
-
-	list_for_each_entry(top_dev, &topology_device_list, list)
-		if (top_dev->gpu && top_dev->gpu->adev == adev) {
-			device = top_dev->gpu;
-			break;
-		}
-
-	up_read(&topology_lock);
-
-	return device;
-}
-
 /* Called with write topology_lock acquired */
 static void kfd_release_topology_device(struct kfd_topology_device *dev)
 {
-- 
2.40.1

