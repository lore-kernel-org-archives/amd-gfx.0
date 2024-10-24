Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C526D0BB66
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 07:39:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FAFE10E8C0;
	Thu, 24 Oct 2024 07:39:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FvHtRdnl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5686110E8BF
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 07:39:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHoaneutOh9hkiDtpp73Vn4Pnu/FZziiLREYAxIv7Du7NUpFxnTcTyMZ61pDLufoE7kIt0pdxeCpYD6BgGa9SASZqSU2tPYddMl64ymxC9hQx7iDfYSIOkBkdFkFH/MPaS7lKgRfbi60jlDloiP40UDLEJDmlSBsnK/nAfyvRfRowXjknfnNbHp6HGeLy1JxEAqojmr/jNaZQOLi9K6laBMzMCVvNZWg6wdJzPAP1ylf5aUtUHZ0J3dYpWhwPFCONaN1q88gM3a5eGHm0bXdb7LLArrmxadTb9fZswiOYTikH5X3gqhTke6WsbQjFofygnx1b4IxQOTIW5UkfiJTFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muqjQNKU49y0Cy+tQ4XyRooY4NsKweiBi0boOfN0iJY=;
 b=xsdlFYLZlhf/Wqi8sUgLBRq4UTf43DX7Wx3AAupv/HlF3kJvAKLMHRFk8C+44DBxEI1lD3tV9T4snD5yAVbs6d2A66rVrVZAhaxKRaI5LlsmtPI8dR56a1N198J+ypdZbRmvMwD6U5ghX6yKU+PFimAHwZKJHdPRu9sJ52YWY+iVfeJC0HkSqHIgc3TyptAYni5QMZJzh3Kfnbus//DJJBtypP34eSqWYe7xYQtzP9Fw5RwDLlYFCVkmBs3wEG5QUGJeKQiDF+mTrLQEBYlLqf2Jktf6qx0gFBmx8IywXyemFTrmfO8IeG+X4WSHKTWtO7hTffoJhKx/wpR68RuiCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=muqjQNKU49y0Cy+tQ4XyRooY4NsKweiBi0boOfN0iJY=;
 b=FvHtRdnlNmagxrhlK6nF2Vbx3hAAavJ09Pv7cXKmPKKpzzngUH75nAgl0j20356D2RwEiFcdjKgP4fCCE0QjrzoNW4Ttr/eIIB1RPBdpyieWAjgksh2weIBWFxilP3pMTv+sRCymbyXQw6g+HixvZ+vYbeN9yqBOTkllz6gCNYM=
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by DS7PR12MB6094.namprd12.prod.outlook.com (2603:10b6:8:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 07:39:41 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::8a) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 07:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:39:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 02:39:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 02:39:40 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 24 Oct 2024 02:39:34 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V3 1/5] drm/amdgpu: Add sysfs interface for gc reset mask
Date: Thu, 24 Oct 2024 15:39:29 +0800
Message-ID: <20241024073933.2709389-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|DS7PR12MB6094:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a88b327-a48e-4c2a-f61c-08dcf3ff0593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3wS+yeW6XpaJN4APv6kwkOe82D3NHqr1vl6PtghStHh50LzP8pXusKkAA737?=
 =?us-ascii?Q?/+TFnFHt2ZmKmHzxLxk+x+PXJ2qr8e9ciBQY6YEgW3p5oCFHJjDLotOlspTp?=
 =?us-ascii?Q?5RXsBmw46QPyYcVs8xlXHbjcpeZC0ZHbuZdSOUwr5cGkiRl+e+aqykUlQOah?=
 =?us-ascii?Q?4rReSnlJQUaGpEKumgCno/V2iu8DReQxXGdyIe0/ZCWR3zPnrjKx89ZFIHu8?=
 =?us-ascii?Q?TF/ejnIjLE/p7k7dggGRgIGV24j3704rEtwAE2GpuHs4yjCrDzFeuOQ00t6O?=
 =?us-ascii?Q?1p0aB0Vy9sEJJ+SoMct0Hw2d2eHVyiBtt/GgoK/sBJRO+8PzB+v9QQujoAni?=
 =?us-ascii?Q?y+tO8rxJx1qnFPHnKeM+HlKxUiyM3s+HpmGltrlvgZrh7VodbArdEyeEJhC9?=
 =?us-ascii?Q?Mhiwe1tDodDdwes6paDFDs9XnLtyP4Jjq/4n5KpyXYCrlB2W+SQnU7zoR5rb?=
 =?us-ascii?Q?RzkstgXdQIZSP3OBpQB0Q7vNYuM7AbeeOiFzLWdEE7u21LkXHs1lVIeBgG7D?=
 =?us-ascii?Q?GCDNFMhrlUK/QpATZHGZDIURscTQ2Rya1FNJN/Qk8qDopp6FWCiSmkFLfJVx?=
 =?us-ascii?Q?qXg3Z3xTL10bxoUL6Av+IVP9OJhDMbaSP/NFKnskQxyNsNMdqE7kRIEvMdbY?=
 =?us-ascii?Q?WaWH667lfDm9LrljpOSEBjzyVIek/BM7EhTaZljdOwavrfTET4RFICcv+X45?=
 =?us-ascii?Q?3RCUfR80NWyCWNLOhhPWq5yXpijoADkBfKWN8zEgTYp8MVaYlaXB//iNvBeV?=
 =?us-ascii?Q?eqlw71ONa8HIv5r+IrynmUeobXURFQYn8udW9xbSnEUGMsIv45AVFprOOU15?=
 =?us-ascii?Q?0O9iutCOXsvWXluiUUlHqjAY7bdSIS6I4kUqNNHPqkSh0sK8Ujes8I5dZbUG?=
 =?us-ascii?Q?Ye7jJFkhFQ60Mbtg3YcsejGt4uCQOSsIIOF7/rsdvSpMct16q6Or0YCROGW1?=
 =?us-ascii?Q?qyUB+rT9OKX4YxMAcHIu4hDqKl1bsc6FukndgopZEm0/K9Oc7T40LwlaJxRq?=
 =?us-ascii?Q?/carPvqQMDf8v0SR2rY8tw/TMK26PAYRECQDqsrYPGVFnvg2UmyQnJD8E+Qo?=
 =?us-ascii?Q?QjgHJvtYRiXcrzfEax8tVOoCpdQ/xYvK6DN1l7C/SmbcAUoPj9Tx7TYaQY+u?=
 =?us-ascii?Q?WY/DWikgeLI1FSR50NX0olzK590SJOPT1l7By9Kq4rc0wTZwpQ0Jw9V1uy9S?=
 =?us-ascii?Q?b3aRF5j2FwP+GA438cOCoWukR+yhIODhp69FGnmDiye9V2lo4Y6ZjcMLAwhH?=
 =?us-ascii?Q?MPjwOCOvflBpMzcy4VkHWNXGeFeauQ8SMxFT8tlIDLJ23R6Hrw6t7ebDe+Ps?=
 =?us-ascii?Q?kjIp4LOGuI4zzmWJM702RywRhJTJlnynKIIgAbk4Dpu2S4UKDQjFqsOzxn8s?=
 =?us-ascii?Q?V9aHEACIV+Sf896qUfMdHMFhtRRkXbXJ++GbIF4qb2DsENF1Tw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:39:41.4935 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a88b327-a48e-4c2a-f61c-08dcf3ff0593
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6094
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

Add two sysfs interfaces for gfx and compute:
gfx_reset_mask
compute_reset_mask

These interfaces are read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
    and print the strings in the order they are applied (Christian)

    check amdgpu_gpu_recovery  before creating sysfs file itself,
    and initialize supported_reset_types in IP version files (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  8 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 37 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c    | 66 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h    |  4 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  6 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c     | 14 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c    | 12 ++++
 7 files changed, 147 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..aea1031d7b84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -300,6 +300,12 @@ extern int amdgpu_wbrf;
 #define AMDGPU_RESET_VCE			(1 << 13)
 #define AMDGPU_RESET_VCE1			(1 << 14)
 
+/* reset mask */
+#define AMDGPU_RESET_TYPE_FULL (1 << 0) /* full adapter reset, mode1/mode2/BACO/etc. */
+#define AMDGPU_RESET_TYPE_SOFT_RESET (1 << 1) /* IP level soft reset */
+#define AMDGPU_RESET_TYPE_PER_QUEUE (1 << 2) /* per queue */
+#define AMDGPU_RESET_TYPE_PER_PIPE (1 << 3) /* per pipe */
+
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
@@ -1466,6 +1472,8 @@ struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
 struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 					    struct dma_fence *gang);
 bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
+ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
+ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
 
 /* atpx handler */
 #if defined(CONFIG_VGA_SWITCHEROO)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index ef715b2bbcdb..cd1e3f018893 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6684,3 +6684,40 @@ uint32_t amdgpu_device_wait_on_rreg(struct amdgpu_device *adev,
 	}
 	return ret;
 }
+
+ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring)
+{
+	ssize_t size = 0;
+
+	if (!ring)
+		return size;
+
+	if (amdgpu_device_should_recover_gpu(ring->adev))
+		size |= AMDGPU_RESET_TYPE_FULL;
+
+	if (unlikely(!ring->adev->debug_disable_soft_recovery) &&
+	    !amdgpu_sriov_vf(ring->adev) && ring->funcs->soft_recovery)
+		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
+
+	return size;
+}
+
+ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset)
+{
+	ssize_t size = 0;
+
+	if (supported_reset & AMDGPU_RESET_TYPE_SOFT_RESET)
+		size += sysfs_emit_at(buf, size, "soft ");
+
+	if (supported_reset & AMDGPU_RESET_TYPE_PER_QUEUE)
+		size += sysfs_emit_at(buf, size, "queue ");
+
+	if (supported_reset & AMDGPU_RESET_TYPE_PER_PIPE)
+		size += sysfs_emit_at(buf, size, "pipe ");
+
+	if (supported_reset & AMDGPU_RESET_TYPE_FULL)
+		size += sysfs_emit_at(buf, size, "full ");
+
+	size += sysfs_emit_at(buf, size, "\n");
+	return size;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e96984c53e72..6de1f3bf6863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1588,6 +1588,32 @@ static ssize_t amdgpu_gfx_set_enforce_isolation(struct device *dev,
 	return count;
 }
 
+static ssize_t amdgpu_gfx_get_gfx_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->gfx.gfx_supported_reset);
+}
+
+static ssize_t amdgpu_gfx_get_compute_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->gfx.compute_supported_reset);
+}
+
 static DEVICE_ATTR(run_cleaner_shader, 0200,
 		   NULL, amdgpu_gfx_set_run_cleaner_shader);
 
@@ -1602,6 +1628,12 @@ static DEVICE_ATTR(current_compute_partition, 0644,
 static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
+static DEVICE_ATTR(gfx_reset_mask, 0444,
+		   amdgpu_gfx_get_gfx_reset_mask, NULL);
+
+static DEVICE_ATTR(compute_reset_mask, 0444,
+		   amdgpu_gfx_get_compute_reset_mask, NULL);
+
 int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_xcp_mgr *xcp_mgr = adev->xcp_mgr;
@@ -1702,6 +1734,40 @@ void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
 			    cleaner_shader_size);
 }
 
+int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (!amdgpu_gpu_recovery)
+		return r;
+
+	if (adev->gfx.num_gfx_rings) {
+		r = device_create_file(adev->dev, &dev_attr_gfx_reset_mask);
+		if (r)
+			return r;
+	}
+
+	if (adev->gfx.num_compute_rings) {
+		r = device_create_file(adev->dev, &dev_attr_compute_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_gpu_recovery)
+		return;
+
+	if (adev->gfx.num_gfx_rings)
+		device_remove_file(adev->dev, &dev_attr_gfx_reset_mask);
+
+	if (adev->gfx.num_compute_rings)
+		device_remove_file(adev->dev, &dev_attr_compute_reset_mask);
+}
+
 /**
  * amdgpu_gfx_kfd_sch_ctrl - Control the KFD scheduler from the KGD (Graphics Driver)
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index f710178a21bc..fb0e1adf6766 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -424,6 +424,8 @@ struct amdgpu_gfx {
 	/* reset mask */
 	uint32_t                        grbm_soft_reset;
 	uint32_t                        srbm_soft_reset;
+	uint32_t 			gfx_supported_reset;
+	uint32_t 			compute_supported_reset;
 
 	/* gfx off */
 	bool                            gfx_off_state;      /* true: enabled, false: disabled */
@@ -582,6 +584,8 @@ void amdgpu_gfx_sysfs_isolation_shader_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work);
 void amdgpu_gfx_enforce_isolation_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_gfx_enforce_isolation_ring_end_use(struct amdgpu_ring *ring);
+int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 9da95b25e158..446e37768397 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4806,6 +4806,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 	}
+	/* TODO: Check the version that supports fully queue reset */
+	adev->gfx.gfx_supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 
 	ring_id = 0;
 	/* set up the compute queues - allocate horizontally across pipes */
@@ -4825,6 +4828,9 @@ static int gfx_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 	}
+	/* TODO: Check the version that supports fully queue reset */
+	adev->gfx.compute_supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
 
 	r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE, 0);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5aff8f72de9c..3b23402dfb47 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1560,6 +1560,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_v11_0_funcs;
 		adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_v11_0_funcs;
 #endif
+		if ((adev->gfx.me_fw_version >= 2280) &&
+		    (adev->gfx.mec_fw_version >= 2410)) {
+			adev->gfx.compute_supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.gfx_supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		}
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1663,6 +1668,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 	}
+	adev->gfx.gfx_supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
 
 	ring_id = 0;
 	/* set up the compute queues - allocate horizontally across pipes */
@@ -1682,6 +1689,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			}
 		}
 	}
+	adev->gfx.compute_supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
 
 	if (!adev->enable_mes_kiq) {
 		r = amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
@@ -1721,6 +1730,10 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init (adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -1783,6 +1796,7 @@ static int gfx_v11_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v11_0_free_microcode(adev);
 
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 016290f00592..b9d5a79ba85c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1067,6 +1067,11 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
 			}
 		}
+
+		if (adev->gfx.mec_fw_version >= 155) {
+			adev->gfx.compute_supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+			adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_PIPE;
+		}
 		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
@@ -1157,6 +1162,9 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	adev->gfx.compute_supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
 	r = gfx_v9_4_3_gpu_early_init(adev);
 	if (r)
 		return r;
@@ -1175,6 +1183,9 @@ static int gfx_v9_4_3_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -1200,6 +1211,7 @@ static int gfx_v9_4_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v9_4_3_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
 	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 
 	kfree(adev->gfx.ip_dump_core);
 	kfree(adev->gfx.ip_dump_compute_queues);
-- 
2.25.1

