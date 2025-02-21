Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC4EC021B3
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 18:24:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 271AD10EB20;
	Fri, 21 Feb 2025 18:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LJ6LZl5k";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1581810EB1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 18:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4v+PLnwcAgOBpXkigmnXWXAE8FLYFOoFVW60/oG6tT2KJ9bu6mh2K/4jQCQEG6WoBByB8GNkO3k5t9VMDSOObPBqFP9QRDkAYUmiIo69TfvuXaexbh+locGiqm2YDTSdlxEtsAVFV1mD4iDXdDH6FGnFM3r9hPIB40vxsgYfk87hzZMCh1EkV0OH8y5NxBqfAMUqhxP9+ByH9AatWlEhINWaawPs/+akbZyZaSIpwt1l0s56JTc9KPhY1HAC5eq6XjdbzYktzFFOmrJ8Qe3Od6CcF8K7J6AqCOUy0TP+wpSyM9iSsAsQXIODCp48fHT+JVRxI8/1H22ffyok9+5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4vK+6YRuzjWGmBBAVIDTDDmsBqDD6vqsBTsY3ybGtY=;
 b=O/xldgeNr0r2gnqaghli0zGFhvqyAT9q0jbmc71kgrMbPhC7P9udwRl+aliB7NBw7wDZ/Xkz4yhb5emV1WeXont0p8HCgAY5f24Am1WvKIqkmLgKguB58IRqZAnT//sEfE4fEfz3TXBNG+oqkYnII3XrPSqa1TIuBOylN55FPV0zFMlNgNF1BLh4Bi/TvUglVrneG6Kb2EOv5GCljg0cSWOZNjc7ViL2o8Lv5bTouEMXeY66CLxKhX8XyKsD1eI5W1DfkALrptVg0f5Vmiowyp48JraWSOibuedxEvVpGW7xM28H9qAZWZsl06WODthSCyo6JAaCYbwJ366rVnE3kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4vK+6YRuzjWGmBBAVIDTDDmsBqDD6vqsBTsY3ybGtY=;
 b=LJ6LZl5kF0vWzw8JW/h/+62uCPJ7JNknJprmZuayopGipFLiabRnwsWSwqCk4RJ9eiFom8UiiSXj0s3mSy/oiQQOBk4AB8MqWReO11JHE7JRiZHaDJ/GpJuX/EaVGfleVS6rOb7ZzDla83+TMZYwb7zNNHfJ/BeZoUIh9KRJlxQ=
Received: from BY1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::12)
 by DS0PR12MB7873.namprd12.prod.outlook.com (2603:10b6:8:142::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 21 Feb
 2025 18:24:08 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:a03:59d:cafe::2b) by BY1P220CA0010.outlook.office365.com
 (2603:10b6:a03:59d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.17 via Frontend Transport; Fri,
 21 Feb 2025 18:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 18:24:07 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 12:24:06 -0600
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH] drm/amdgpu: simplify xgmi peer info calls
Date: Fri, 21 Feb 2025 13:23:59 -0500
Message-ID: <20250221182359.2777228-1-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|DS0PR12MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: aa69ad3f-07ba-42d5-1add-08dd52a4ee13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HGZKDWygNxpfWjtko05k2VtPQmXVYsqSIq/DrJL1vGVRUPidttVfuU5/mJ5L?=
 =?us-ascii?Q?am79Urs/Ba6Rj0NXAuvHUZ9Ip4TqkOjDVJvk3D8OLuqLfhcV6IM7DWwCLa2s?=
 =?us-ascii?Q?BuBv0WPFqeQSfr+9pJNftH13xp29oWUE7FqY+d05sNcQvoxuFuGST6YAlKYl?=
 =?us-ascii?Q?9TZ0EFTtVfNS3+u/hfyLzmEB8L/Zi5r20n1bCThlDOX3cn1c34532kQ7B4PE?=
 =?us-ascii?Q?kvVfe8JY3iNi9TjkgxfUsc9NCWczLnJUM9wkZpH1+jSDowxGmN1LQa9qRRjK?=
 =?us-ascii?Q?Yb0wXgSOKBTucoaCg3/olHG94fsRt+rC6jbmT0WzH6p3gg/f7rHOESxohsbU?=
 =?us-ascii?Q?s/xefZkyj5hamlZTOeWahJiSrIXrlx0cVIvWQIPo01728ZNE43Kl9oo6y12y?=
 =?us-ascii?Q?+JH/qLNOCjdCC3zEMOPxIKi443/C8WtMtrLsz1rLwkxVpPn6p3Hosa8aGAYp?=
 =?us-ascii?Q?ku+usMBa0CihHjeA40aTyr+K6wnC8jMLnNjDC3jWfmiglQYaqCeXBzCfP0Kx?=
 =?us-ascii?Q?DrDL1rNiTRj9lqutLDIx4G6M8q9kEr/XLF/Ed3CqGXbethVStdI+KPNyhjrL?=
 =?us-ascii?Q?1ye0+6qDhVSJf3r+IminUZoeejZQ482k8Q6uVU5mQdzVcHjfGQKZNQo0CCJW?=
 =?us-ascii?Q?J+L6lwTs7AsPPWpEaZSMSXjIxVV987/hE28suBqj1J0zPyP9aAtqSi0574UF?=
 =?us-ascii?Q?S4LjTd5MOQLb23L+n9sY9O8uQsi6braRXNKprr9K4T0MRCqeBug4E3HBz/eE?=
 =?us-ascii?Q?bo8ctpDZk/+fhtYUFIsOq4oHKXaK4fqo7SF+y0aJJAWZeZnVCkxB90k+e8wx?=
 =?us-ascii?Q?V/hyBsVhTYb6R92h9wKqAMpG7/nvi151A2i+/5khGtnKnRUocLIPili6wAAh?=
 =?us-ascii?Q?94+/o0XzRJ/oqafNrI+UoWlS9igb7/HZu26RDr2JlJL/4SVZCzMbfVszwfPw?=
 =?us-ascii?Q?DJghDI20u4qaevydpZ+O2DZ6cvJ6bf2zmy/cLEQV8giGuBBNcqRtSooPgkBB?=
 =?us-ascii?Q?cZDaSwOIufqlYaASu1wvtsbidF8vkWvkxqMeRwmSx2sF38DHQNHskstY9Z8m?=
 =?us-ascii?Q?aKBq+c8Y+YOYLhC14v3/6sTE2XXP8lFPLyHff4ogA/dmjuh7bwSxVDTGBNrO?=
 =?us-ascii?Q?waFIKMQYSua8EaioO5X1eOefU3QUYOJmydMvjJa7upC6kHa24gH80FSUr1Fl?=
 =?us-ascii?Q?0MdhfOj49LTfOQzO4wju7Te68yPvO5+f5y/QZZrYQxlwZsgK19nRyQ/uyddc?=
 =?us-ascii?Q?ICoV10EaE0SfLd6EaoWSnDByLN/X3cscutzEwWzeKUagqyhTPrMbBDKATDXu?=
 =?us-ascii?Q?hBIsWNoqr/etwd6ARyXHjF0DGfVTDPonOKgZ4jMok0Zeq9Ed86KY7TsLQvNU?=
 =?us-ascii?Q?aLgufcenKSBG1df+EHfZyQUAg4XZOSknbScIWcIVk+qjUnGzsM8aSuPtLv3z?=
 =?us-ascii?Q?NRmWKCGwpHPiqvrB/nGdxVJKfX2IkaTt/SFSDTKauqNoLw2SMzRYRyT4HVQQ?=
 =?us-ascii?Q?drloMd4B30df/O4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 18:24:07.7259 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa69ad3f-07ba-42d5-1add-08dd52a4ee13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7873
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

Deprecate KFD XGMI peer info calls in favour of calling directly from
simplified XGMI peer info functions.

v2: generalize bandwidth interface to return range in one call

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 42 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  5 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 58 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h   | 24 +++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c      | 27 ++++++----
 5 files changed, 84 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0312231b703e..4cec3a873995 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -555,48 +555,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 	return r;
 }
 
-uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
-					  struct amdgpu_device *src)
-{
-	struct amdgpu_device *peer_adev = src;
-	struct amdgpu_device *adev = dst;
-	int ret = amdgpu_xgmi_get_hops_count(adev, peer_adev);
-
-	if (ret < 0) {
-		DRM_ERROR("amdgpu: failed to get  xgmi hops count between node %d and %d. ret = %d\n",
-			adev->gmc.xgmi.physical_node_id,
-			peer_adev->gmc.xgmi.physical_node_id, ret);
-		ret = 0;
-	}
-	return  (uint8_t)ret;
-}
-
-int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
-					    struct amdgpu_device *src,
-					    bool is_min)
-{
-	struct amdgpu_device *adev = dst, *peer_adev;
-	int num_links;
-
-	if (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2))
-		return 0;
-
-	if (src)
-		peer_adev = src;
-
-	/* num links returns 0 for indirect peers since indirect route is unknown. */
-	num_links = is_min ? 1 : amdgpu_xgmi_get_num_links(adev, peer_adev);
-	if (num_links < 0) {
-		DRM_ERROR("amdgpu: failed to get xgmi num links between node %d and %d. ret = %d\n",
-			adev->gmc.xgmi.physical_node_id,
-			peer_adev->gmc.xgmi.physical_node_id, num_links);
-		num_links = 0;
-	}
-
-	/* Aldebaran xGMI DPM is defeatured so assume x16 x 25Gbps for bandwidth. */
-	return (num_links * 16 * 25000)/BITS_PER_BYTE;
-}
-
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min)
 {
 	int num_lanes_shift = (is_min ? ffs(adev->pm.pcie_mlw_mask) :
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 55d539967695..b6ca41859b53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -254,11 +254,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct amdgpu_device *adev, int dma_buf_fd,
 				  uint64_t *bo_size, void *metadata_buffer,
 				  size_t buffer_size, uint32_t *metadata_size,
 				  uint32_t *flags, int8_t *xcp_id);
-uint8_t amdgpu_amdkfd_get_xgmi_hops_count(struct amdgpu_device *dst,
-					  struct amdgpu_device *src);
-int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
-					    struct amdgpu_device *src,
-					    bool is_min);
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
 int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
 					uint32_t *payload);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
index c98b6b35cfdf..a4545edfed8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
@@ -818,28 +818,66 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
  * num_hops[2:0] = number of hops
  */
 int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
-		struct amdgpu_device *peer_adev)
+			       struct amdgpu_device *peer_adev)
 {
 	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
 	uint8_t num_hops_mask = 0x7;
 	int i;
 
+	if (!adev->gmc.xgmi.supported)
+		return 0;
+
 	for (i = 0 ; i < top->num_nodes; ++i)
 		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
 			return top->nodes[i].num_hops & num_hops_mask;
-	return	-EINVAL;
+
+	dev_err(adev->dev, "Failed to get xgmi hops count for peer %d.\n",
+		peer_adev->gmc.xgmi.physical_node_id);
+
+	return 0;
 }
 
-int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
-		struct amdgpu_device *peer_adev)
+int amdgpu_xgmi_get_bandwidth(struct amdgpu_device *adev, struct amdgpu_device *peer_adev,
+			      enum amdgpu_xgmi_bw_mode bw_mode, enum amdgpu_xgmi_bw_unit bw_unit,
+			      uint32_t *min_bw, uint32_t *max_bw)
 {
-	struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
-	int i;
+	bool peer_mode = bw_mode == AMDGPU_XGMI_BW_MODE_PER_PEER;
+	int unit_scale = bw_unit == AMDGPU_XGMI_BW_UNIT_MBYTES ? 1000 : 1;
+	int speed = 25, num_lanes = 16, num_links = !peer_mode ? 1 : -1;
 
-	for (i = 0 ; i < top->num_nodes; ++i)
-		if (top->nodes[i].node_id == peer_adev->gmc.xgmi.node_id)
-			return top->nodes[i].num_links;
-	return	-EINVAL;
+	*min_bw = 0;
+	*max_bw = 0;
+
+	if (!adev->gmc.xgmi.supported)
+		return -ENODATA;
+
+	if (peer_mode && !peer_adev)
+		return -EINVAL;
+
+	if (peer_mode) {
+		struct psp_xgmi_topology_info *top = &adev->psp.xgmi_context.top_info;
+		int i;
+
+		for (i = 0 ; i < top->num_nodes; ++i) {
+			if (top->nodes[i].node_id != peer_adev->gmc.xgmi.node_id)
+				continue;
+
+			num_links =  top->nodes[i].num_links;
+			break;
+		}
+	}
+
+	if (num_links == -1) {
+		dev_err(adev->dev, "Failed to get number of xgmi links for peer %d.\n",
+			peer_adev->gmc.xgmi.physical_node_id);
+	} else if (num_links) {
+		int per_link_bw = (speed * num_lanes * unit_scale)/BITS_PER_BYTE;
+
+		*min_bw = per_link_bw;
+		*max_bw = num_links * per_link_bw;
+	}
+
+	return 0;
 }
 
 bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
index d1282b4c6348..924da0bec509 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.h
@@ -55,6 +55,22 @@ struct amdgpu_pcs_ras_field {
 	uint32_t pcs_err_shift;
 };
 
+/**
+ * Bandwidth range reporting comes in two modes.
+ *
+ * PER_LINK - range for any xgmi link
+ * PER_PEER - range of max of single xgmi link to max of multiple links based on source peer
+ */
+enum amdgpu_xgmi_bw_mode {
+	AMDGPU_XGMI_BW_MODE_PER_LINK = 0,
+	AMDGPU_XGMI_BW_MODE_PER_PEER
+};
+
+enum amdgpu_xgmi_bw_unit {
+	AMDGPU_XGMI_BW_UNIT_GBYTES = 0,
+	AMDGPU_XGMI_BW_UNIT_MBYTES
+};
+
 extern struct amdgpu_xgmi_ras  xgmi_ras;
 struct amdgpu_hive_info *amdgpu_get_xgmi_hive(struct amdgpu_device *adev);
 void amdgpu_put_xgmi_hive(struct amdgpu_hive_info *hive);
@@ -62,10 +78,10 @@ int amdgpu_xgmi_update_topology(struct amdgpu_hive_info *hive, struct amdgpu_dev
 int amdgpu_xgmi_add_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_remove_device(struct amdgpu_device *adev);
 int amdgpu_xgmi_set_pstate(struct amdgpu_device *adev, int pstate);
-int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev,
-		struct amdgpu_device *peer_adev);
-int amdgpu_xgmi_get_num_links(struct amdgpu_device *adev,
-		struct amdgpu_device *peer_adev);
+int amdgpu_xgmi_get_hops_count(struct amdgpu_device *adev, struct amdgpu_device *peer_adev);
+int amdgpu_xgmi_get_bandwidth(struct amdgpu_device *adev, struct amdgpu_device *peer_adev,
+			      enum amdgpu_xgmi_bw_mode bw_mode, enum amdgpu_xgmi_bw_unit bw_unit,
+			      uint32_t *min_bw, uint32_t *max_bw);
 bool amdgpu_xgmi_get_is_sharing_enabled(struct amdgpu_device *adev,
 					struct amdgpu_device *peer_adev);
 uint64_t amdgpu_xgmi_get_relative_phy_addr(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 70b3ae0b74fe..4a7180b46b71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2133,9 +2133,6 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		bool ext_cpu = KFD_GC_VERSION(kdev) != IP_VERSION(9, 4, 3);
 		int mem_bw = 819200, weight = ext_cpu ? KFD_CRAT_XGMI_WEIGHT :
 							KFD_CRAT_INTRA_SOCKET_WEIGHT;
-		uint32_t bandwidth = ext_cpu ? amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(
-							kdev->adev, NULL, true) : mem_bw;
-
 		/*
 		 * with host gpu xgmi link, host can access gpu memory whether
 		 * or not pcie bar type is large, so always create bidirectional
@@ -2144,8 +2141,16 @@ static int kfd_fill_gpu_direct_io_link_to_cpu(int *avail_size,
 		sub_type_hdr->flags |= CRAT_IOLINK_FLAGS_BI_DIRECTIONAL;
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_XGMI;
 		sub_type_hdr->weight_xgmi = weight;
-		sub_type_hdr->minimum_bandwidth_mbs = bandwidth;
-		sub_type_hdr->maximum_bandwidth_mbs = bandwidth;
+		if (ext_cpu) {
+			amdgpu_xgmi_get_bandwidth(kdev->adev, NULL,
+						  AMDGPU_XGMI_BW_MODE_PER_LINK,
+						  AMDGPU_XGMI_BW_UNIT_MBYTES,
+						  &sub_type_hdr->minimum_bandwidth_mbs,
+						  &sub_type_hdr->maximum_bandwidth_mbs);
+		} else {
+			sub_type_hdr->minimum_bandwidth_mbs = mem_bw;
+			sub_type_hdr->maximum_bandwidth_mbs = mem_bw;
+		}
 	} else {
 		sub_type_hdr->io_interface_type = CRAT_IOLINK_TYPE_PCIEXPRESS;
 		sub_type_hdr->minimum_bandwidth_mbs =
@@ -2198,12 +2203,12 @@ static int kfd_fill_gpu_xgmi_link_to_gpu(int *avail_size,
 
 	if (use_ta_info) {
 		sub_type_hdr->weight_xgmi = KFD_CRAT_XGMI_WEIGHT *
-			amdgpu_amdkfd_get_xgmi_hops_count(kdev->adev, peer_kdev->adev);
-		sub_type_hdr->maximum_bandwidth_mbs =
-			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev,
-							peer_kdev->adev, false);
-		sub_type_hdr->minimum_bandwidth_mbs = sub_type_hdr->maximum_bandwidth_mbs ?
-			amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(kdev->adev, NULL, true) : 0;
+			amdgpu_xgmi_get_hops_count(kdev->adev, peer_kdev->adev);
+		amdgpu_xgmi_get_bandwidth(kdev->adev, peer_kdev->adev,
+					  AMDGPU_XGMI_BW_MODE_PER_PEER,
+					  AMDGPU_XGMI_BW_UNIT_MBYTES,
+					  &sub_type_hdr->minimum_bandwidth_mbs,
+					  &sub_type_hdr->maximum_bandwidth_mbs);
 	} else {
 		bool is_single_hop = kdev->kfd == peer_kdev->kfd;
 		int weight = is_single_hop ? KFD_CRAT_INTRA_SOCKET_WEIGHT :
-- 
2.34.1

