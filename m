Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775E9CD5BD5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 18:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AA410F56A;
	Thu, 28 May 2026 18:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iu4BGHxM";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36C2310F56A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 18:47:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksxYth1DoXjG8Dp1agXp6Ep9L1ilO1NbHkkJPegF0Zj/h7LJsMf83mIYc8z74zxdX9DISsPr0i19Y0VyT/KycRneCiVo5KprsJWqqWNwg3hXK+qtjsauOtG6SUEyHUGIQbSBx5O3zCnT67AZViQbWHSGMK3ni6EFJYICtxDCEQa8Y+amiGWswYdWdJm9EPr0+V/LKAV+6QTiAPr2ADybfchTIBIyc9IdRSdBUE3v4iTo2o0hwZGCtoys6QUkdLd5HIAuj0wulXPgAYRo+3bRHin81FlF4tciswTUBM52IbkZcYPKQ/VGNmx/xOOretCjYQxt7OeH0/9mFo9HdO5Qwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u4/2xvLNxI5vNmanD3r0Rj7fcshRKj+S9adfxfwU9c8=;
 b=EtFsBpFg2v+3LjrBhQTj58vRxq0SweaKgtFXjutSyr5WJUwSsGL+G52HJrgeyzwv/ErzEKWO3fMRZhbO+XpSBRCQ9IEimolZyO9AZalCvi9fFNPQTgXC2BaKF3+V+C+fmPk+aoeamg0U0qb6DLujgJi8dRhAGmNOBRPQXi1h65oiPhESXeKgE7XZxI4i4lYiS0UmWcuv1wffikXi1EgH6wKJxvPTyU9E5cSmGAUv3NLKuCmQ8PHJvJijuzxi6oNkIXgFAzZSKkB3Xi0ie0cGGcw5HoCBfa5q8e0WLn7n8k30HNvu65B91SS96AFxrBLRNPF0B6a9zt4JrGZ1JrB2Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u4/2xvLNxI5vNmanD3r0Rj7fcshRKj+S9adfxfwU9c8=;
 b=iu4BGHxMVI1bsZY9a+BJEUmg4TWWnvtmtpqDRVbvLVPg5L0h+clBqEcTV61GEKwAqSV/7ffqF9dnR8m67ofLkPvpeGUXDn2WBLbTfNR/G+WlofcIIulve/sDdG2Z+3Y99okkVz4t+DpaqobXCcTLY9S3d7MLpMAeiBHAXHBxFX4=
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by SA1PR12MB7149.namprd12.prod.outlook.com (2603:10b6:806:29c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 18:47:17 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::5e) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 18:47:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 28 May 2026 18:47:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 13:47:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 11:47:06 -0700
Received: from Xiaogang-ROCM-Dev.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 28 May 2026 13:47:06 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH 1/3] drm/amdkfd: Let driver decide buffer size at
 AMDKFD_IOC_GET_DMABUF_INFO ioctl
Date: Thu, 28 May 2026 13:46:54 -0500
Message-ID: <20260528184656.123149-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SA1PR12MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 759b04a1-c6c5-48d5-5577-08debce9899d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: kBeQsC3sxNwINI8GfTfDVwyvBGS6p/K8wqtK2Rv7UaPyZmj63PklpZZv5+r8aT4DqKD9hyxt2DMDRI4YPihlyjjAaUPryTXEPKIMN8Jt/rgsfsp3xBqbIgYKh0Zc17tq+HV7ANZgHfXNwRMTd+dTXxt0LmT5kNmhi+X89f7ZsLtwn8oHMxv9KvrJYNOYHXtYGCab5FXScro7NTyycTivZlgUX+JIUrdoV0fXei/tkbT2sa8DzulULRyOQl0jo/EjgOsO6xiC2wc2HHBW70/tcHeJsaX2pN3p/9tgoQl87P3FS5x+9Fs5+2Md+OZxJY1rF8CNxvg9C+2rv0kUMm3GkwZMD8Ue/dqfbrYL0L4uAnig+TU2wDYwXWgu38CzyOTg1V2HLzwfB7pNk1Idb2HFq5oNfotTW0c5VZ+FYb1LjZU7F4ButdKzxZNcxLq2VPaxKPb8ASkABUhAQVja9PFDrvRHjdsYjjlXprXxWQQ0LIwynOxM5bgg+6NH5TwvRk7Khnk84843xYDxPAEE2GvNNU0bBz0fKoW5TlNn4MP1ASUDaK+lSpol65wrUMIEicA7u3jVlkOupe/sKi2UQBdTftvXwHoQd7uG33Ib4mPH1Rw1VWWfoefGbKSZNCXSq5nfuj2QckSJwpt0UTv6vXyPq0/9fzMwliWuZbDAqnq599o5Imz8Qbh+jbkxWw4t8DXx2cVpyUAat9Csq2RQazKTIAFc9ieGFMzZ1bJaE58q9f0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lOHDzXt9rZy9t33NwNi5LeyWjQje70lZCUWT97+ggzylsDjJpAXmzzQ97DL8p4TY816sJ5mXH+3okMeCwKqvM4mzqaQ9fawUUgnZQeyOXVzGuoFHMdku/lNX7XGOu5qotLSoJ42L0LlN93VkouYsp8vmyA0d8dRzGJlN0F30+P9SZcehv9olMsT+hV7ASbLEqZQnAAU2RWOySWMPUVFKzSOQjTfunDhloI7E1K/Wa4C0TB6rGeCJQTmfM1UQWbT4uQiFg5FwQsb1jaO0ZMzYxKkTpNZNBJ3skhmhKYM/cz1JewRsy2EmXpkUEBLqPMCNfZh6+6+6Gs6Z703dnV9rcW4eTfrRiRI9lUaYxylAOlLClKZz4RBm3wY6d7c8wdl5gqpY8KcSuLAendJIIY+p7UxnV4ijoaM3ZtApb3+c6e4ZCRzN/p4Zk7KE6gyUGn/O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 18:47:15.4035 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759b04a1-c6c5-48d5-5577-08debce9899d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7149
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

amdkfd driver needs allocate buffer to return bo metadata to user space. The
buffer size is controlled by user currently. It is a potential security issue
that hostile value (e.g. 2 GiB) lets any render-group user trigger order-MAX
allocation / OOM in kernel context.

This patch first finds bo metadata size. If the size is smaller than user
provided value drive can safely allocate buffer in kernel space and copy to
user space buffer. If not, driver will let user know, not allocate and copy.
User will redo with new buffer in user space.

This patch lets driver decide buffer allocation size to avoid potential hostile
size from user space.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 23 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c   | 10 ++--------
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 7b10bbe28caf..1b4d1a974143 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -533,7 +533,7 @@ uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev)
 
 int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  struct amdgpu_device **dmabuf_adev,
-				  uint64_t *bo_size, void *metadata_buffer,
+				  uint64_t *bo_size, void **metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
 				  uint32_t *flags, int8_t *xcp_id)
 {
@@ -568,9 +568,24 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 		*dmabuf_adev = adev;
 	if (bo_size)
 		*bo_size = amdgpu_bo_size(bo);
-	if (metadata_buffer)
-		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
-					   metadata_size, &metadata_flags);
+	if (metadata_buffer) {
+		/* first get metadata_size by buffer = NULL */
+		r = amdgpu_bo_get_metadata(bo, NULL, 0,
+					   metadata_size, NULL);
+
+		/* user buf_size is bigger than bo metadata_size
+		 * allocate a buf at kernel space and copy */
+		if (*metadata_size <= buffer_size) {
+			*metadata_buffer = kzalloc(*metadata_size, GFP_KERNEL);
+
+			if (!*metadata_buffer)
+				return -ENOMEM;
+
+			r = amdgpu_bo_get_metadata(bo, *metadata_buffer, *metadata_size,
+						   NULL, &metadata_flags);
+		} else
+			r = -EINVAL;
+	}
 	if (flags) {
 		*flags = (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) ?
 				KFD_IOC_ALLOC_MEM_FLAGS_VRAM
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 2bf6a31c194d..7b67367a9a53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -262,7 +262,7 @@ uint64_t amdgpu_amdkfd_get_gpu_clock_counter(struct amdgpu_device *adev);
 uint32_t amdgpu_amdkfd_get_max_engine_clock_in_mhz(struct amdgpu_device *adev);
 int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  struct amdgpu_device **dmabuf_adev,
-				  uint64_t *bo_size, void *metadata_buffer,
+				  uint64_t *bo_size, void **metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
 				  uint32_t *flags, int8_t *xcp_id);
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 881ea252b3ad..fc75d0009a57 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1545,16 +1545,10 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 	if (!dev)
 		return -EINVAL;
 
-	if (args->metadata_ptr) {
-		metadata_buffer = kzalloc(args->metadata_size, GFP_KERNEL);
-		if (!metadata_buffer)
-			return -ENOMEM;
-	}
-
 	/* Get dmabuf info from KGD */
 	r = amdgpu_amdkfd_get_dmabuf_info(dev->adev, args->dmabuf_fd,
 					  &dmabuf_adev, &args->size,
-					  metadata_buffer, args->metadata_size,
+					  &metadata_buffer, args->metadata_size,
 					  &args->metadata_size, &flags, &xcp_id);
 	if (r)
 		goto exit;
@@ -1566,7 +1560,7 @@ static int kfd_ioctl_get_dmabuf_info(struct file *filep,
 	args->flags = flags;
 
 	/* Copy metadata buffer to user mode */
-	if (metadata_buffer) {
+	if (metadata_buffer && args->metadata_ptr) {
 		r = copy_to_user((void __user *)args->metadata_ptr,
 				 metadata_buffer, args->metadata_size);
 		if (r != 0)
-- 
2.34.1

