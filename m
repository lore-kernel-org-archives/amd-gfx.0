Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69353C61DFD
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE35710E819;
	Mon, 31 Aug 2026 18:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vvND8lnd";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF3710EA66
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o/tq/EzknRkW0GNyJx0qAKwH7ecjyk9O2laQsACB5rRMDLwZvgnSn4ghYx2fsvOxpwv+2zyPn6ih2HTe16oVV02Y8QV2mXgo+W6Xt+FUxJp533Z0jI+dxkTbCeEENvhTLyiWNHjfpZ7039j28EzoXu9EM+/C0uVUli6l1QShEHWr/Bar+vdupTeR3bTq34+VV0shx0i0gNQZs/TOsTVTv8dGDYpyE8ep6R31xJZ1qESHp8eqeJX9IJG8/X2uxL9MrfO7OPjcs486VUfF5OttKDUtl1GYTS7ILqW1xyeOlpKZsXDuR97K1FjAD+jJpmhXY3VjnbsYrL/Tn60aDj3w5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRSQWKaU07yLMWxvqr6V7dxjasqWf+vYmiTLWcsvYMY=;
 b=Hxk5st+1nh6/AEr8XY9EOt7Ri4nSKsgun3Xiiu02ITIn/KEFYiSHkUY6ZkuWIy7ulDR1cERnujFylCiuoqMlx9pe3DAdOGy7CmqHfB2BPc/yFcY9pO3wdxliT+2lSZVeOalAQVeHYpT71jXN40ilOGas7SUkUrAbc+6jwqfp+aB69xaualvJkP0n+oklBePYuYwQAqMcrD4UR93AeSwLq8r30suhg+DlSBUfypCVqK2SztTvX+n39fMZbYElCKYX9lHMchXdDKnUXHFov+wmeaSoxjU9GvBbfKuEs87j0LCS5kfQp5A5/2WHbh1FKZhO5Q0Y9EO+08IPMm6LGliTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRSQWKaU07yLMWxvqr6V7dxjasqWf+vYmiTLWcsvYMY=;
 b=vvND8lndwJG7rYhCvslmnFFkPChXkJicmC0PPOgFmloh8bv+25WqIvgvDNsMZgJelpj59WuVaCsGb9woNFjI7h4PLhhCHyZ6wL/cqd0DhMNw2iMmx4FwOYrxBQx9YJWka6zIKwB3zxW+VkTH3W4QfuyTsuRi6hunTmxiTol8LCo=
Received: from CH0PR04CA0101.namprd04.prod.outlook.com (2603:10b6:610:75::16)
 by MN0PR12MB5786.namprd12.prod.outlook.com (2603:10b6:208:375::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Mon, 31 Aug
 2026 18:28:59 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::4a) by CH0PR04CA0101.outlook.office365.com
 (2603:10b6:610:75::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 58/95] drm/amdgpu: Handle local GPUs in UALink import
Date: Mon, 31 Aug 2026 14:27:17 -0400
Message-ID: <20260831182754.1089811-59-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|MN0PR12MB5786:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2a0cb2-d4ef-4fc4-d54c-08df078db93d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: DhLzBbEmqckpb9NEoZcnCdgZdD0qlP/ma0dGYtardHbcGDz9q2GQwvDnxo2r4m4xyT0+FAhYjAJKz3FkE4v5+GXdxDuj9GnIF1ShOtl9TmAcGMtLtZWCE8jvgHYsy3JpKh154w8drwXhEji2oy8Q5sKMxQAkPW/7IGt9Y7cywdO3MPq2DpAYfzjpzNZRkRbicCRPlAGhM8dZOHTwhXeJJvYh3r4o8HouEpIQLGhrOFuS5Sw/zEDcbnCFnrx6ESsMcgqCEZMmlRMVmkn3ZKCL3sYByLp9SMcSkHrp6PAGQC5PRu9i7f5AFriXWH5icMXYsnj9j3dhTyFO31IZC8pIzTlxrBizZ5Z7RivdeICcgrGgFSTvoD/lLNcTKbid4Cxh5kG1NFELq/GV0hmIEEtygqTCDErVCSseJjRqrf3SXUxN2yG0kEDu7NWDT8RVGXoKmsSzJNj8B9ph0Rx5FSV576rDzX8ewx1fHBfC3uXN5yTmV9h4UH6RTT6FC7EaZqqIWBioGmtrwRSqMVwGCLseiCsmQOsWsfDv2Sk/K8WWeidmfimjemCVNxnnrsKvQGdUPQEi0OawyTIQMQyOfmTqANWUA2LWLNdaJTM0XQJI9uI/6MJ3wra/e9LWxa7yVpAg227aFkaZT9kf/MgyQWUhmsVU8gEm4vLOsCC/625E5eptFHOgHnB+azHDgZyBp1zlkUm/Ghs1KBtXyCJZ2KVpCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FLrZKt3JyFlf2rPkEgIiir+CesUD47m3/KYynvhJ5TrE2tAVELcNtmXKp9pgOYMkv8rXL9NzvkQukGLxochzANtCQsX3ggIY1dxFIsuU7QBM7zFT0RHMlKRkghFd901Eb6bhtHY0uJVYbgwPWXpuDHqcAwnvIHxEeyd2YVmOVKh0PqlAo8NSUEYlLOeyazW9CmpovXdP6x0m9L4VCgKk3c+R8sc9MJp6oW+96GFZAVPDj3S30wsCB+whwSEYsnLcub/qT6wU54VeX0yrujE8euQRd7WDRhyLnuwtgNoWPL2oqqMQc7Y7YVQnC6sbiB0c6z2+EpWcZskLddFZsqPSZzq5x3C83soVja8G0quZLcvKJ3ZSt5Uzpt8FqyPpZoIgPcbJtPc+bTlr10OiIBZbqbL1e9xHGcnEU5JppRxma77ZzgXtdYcRcqo78N03bnh+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:58.9062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2a0cb2-d4ef-4fc4-d54c-08df078db93d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5786
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

From: Mukul Joshi <mukul.joshi@amd.com>

When the remote GPU is part of the local_accels array (same physical
pod), bypass the HELLO/NPA-REQ messaging protocol and directly look up
the exported BO in the peer's exporter xarray. Export it as a DMA-buf
and return the fd to user-space without creating an importer xarray
entry.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 100 +++++++++++++++++----
 1 file changed, 85 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 4e312eb3441d1..e21c48212f0a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -28,6 +28,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
+#include "amdgpu_dma_buf.h"
 #include <linux/math.h>
 #include <linux/sysfs.h>
 #include <linux/string.h>
@@ -571,6 +572,37 @@ static const struct kobj_type ualink_ppod_setup_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
+static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
+{
+	unsigned int i;
+
+	for (i = 0; i < mgpu_info.num_gpu; i++) {
+		struct amdgpu_device *peer_adev = mgpu_info.gpu_ins[i].adev;
+
+		if (peer_adev->ualink.info &&
+		    peer_adev->ualink.info->ppod.accel_id == accel_id)
+			return peer_adev;
+	}
+
+	return NULL;
+}
+
+static bool amdgpu_ualink_is_local_accel(struct amdgpu_device *adev,
+					 u32 accel_id)
+{
+	struct amdgpu_ualink_info *info = adev->ualink.info;
+	unsigned int i;
+
+	if (!info)
+		return false;
+
+	for (i = 0; i < info->n_local_accels; i++) {
+		if (info->local_accels[i] == accel_id)
+			return true;
+	}
+	return false;
+}
+
 #ifdef UALINK_ENABLE_DEPRECATED_CONFIG_SYSFS
 UALINK_VALUE_SHOW(vpod_config, vpod_id,   vpod.id,   "%u");
 UALINK_VALUE_SHOW(vpod_config, vpod_size, vpod.size, "%u");
@@ -621,21 +653,6 @@ static bool check_vpod_info(struct amdgpu_device *adev,
 	return true;
 }
 
-static struct amdgpu_device *find_peer_adev(unsigned int accel_id)
-{
-	unsigned int i;
-
-	for (i = 0; i < mgpu_info.num_gpu; i++) {
-		struct amdgpu_device *peer_adev = mgpu_info.gpu_ins[i].adev;
-
-		if (peer_adev->ualink.info &&
-		    peer_adev->ualink.info->ppod.accel_id == accel_id)
-			return peer_adev;
-	}
-
-	return NULL;
-}
-
 static bool check_local_vpod_integrity(struct amdgpu_device *adev)
 {
 	struct amdgpu_ualink_info *info = adev->ualink.info;
@@ -3102,6 +3119,55 @@ static int amdgpu_ualink_do_import_handle(struct amdgpu_device *adev,
 	return r;
 }
 
+static int amdgpu_ualink_local_import(struct amdgpu_device *adev,
+				      u32 remote_acc_id,
+				      struct amdgpu_ualink_handle *handle,
+				      int *fd_out)
+{
+	struct amdgpu_ualink_exp_xa_node *exp_xa_node;
+	struct amdgpu_device *peer_adev;
+	int fd;
+
+	mutex_lock(&mgpu_info.mutex);
+	peer_adev = find_peer_adev(remote_acc_id);
+	mutex_unlock(&mgpu_info.mutex);
+	if (!peer_adev) {
+		dev_err(adev->dev,
+			"IMPORT LOCAL: peer adev not found for AccId:%u\n",
+			remote_acc_id);
+		return -ENODEV;
+	}
+
+	xa_lock(&peer_adev->ualink.exp_xa);
+	exp_xa_node = xa_load(&peer_adev->ualink.exp_xa, handle->handle_lo);
+	if (!exp_xa_node ||
+	    exp_xa_node->handle.handle_hi != handle->handle_hi ||
+	    !amdgpu_ualink_exp_xa_entry_get(exp_xa_node)) {
+		xa_unlock(&peer_adev->ualink.exp_xa);
+		dev_err(adev->dev,
+			"IMPORT LOCAL: handle:%llx:%llx not found in peer exp_xa\n",
+			handle->handle_hi, handle->handle_lo);
+		return -EINVAL;
+	}
+	xa_unlock(&peer_adev->ualink.exp_xa);
+
+	get_dma_buf(exp_xa_node->dmabuf);
+	/* Get a new fd for the DMABuf */
+	fd = dma_buf_fd(exp_xa_node->dmabuf, O_CLOEXEC | O_RDWR);
+	if (fd < 0) {
+		dev_err(adev->dev,
+			"IMPORT LOCAL: dma-buf fd failed handle:%llx:%llx\n",
+			handle->handle_hi, handle->handle_lo);
+		dma_buf_put(exp_xa_node->dmabuf);
+		amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+		return fd;
+	}
+
+	amdgpu_ualink_exp_xa_entry_put(exp_xa_node);
+	*fd_out = fd;
+	return 0;
+}
+
 int amdgpu_ualink_import_handle(struct drm_device *dev,
 				const struct amdgpu_ualink_handle *ualink_handle,
 				int *fd_out)
@@ -3121,6 +3187,10 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 		return -EINVAL;
 	}
 
+	if (amdgpu_ualink_is_local_accel(adev, remote_acc_id))
+		return amdgpu_ualink_local_import(adev, remote_acc_id,
+						  &handle, fd_out);
+
 	xa_lock(&adev->ualink.imp_xa);
 	imp_xa_node = xa_load(&adev->ualink.imp_xa, handle.handle_lo);
 
-- 
2.55.0

