Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1BFC369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 04:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD9410E827;
	Wed, 16 Apr 2025 04:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M06o7hFt";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2351B10E839
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 04:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xiby2d1gd++dTHGxYITurraP+KhQCSsBZzx8bC0KyrT/EQeXa86osXYzN/W1nQqwuB03T/9Xt76+lB5SFejFVrshR2qg7uXLI926O9QK8TcSZKZ6/0ccvGX3iZ9jHNah7eb8I5W7McKlaWKzYL2EKNYWXYoWgSi+MX/AszTPhtK988H7O4U8wqvJHkkZKVJAnElDmXIvSfimtPCAinY6cWGo/ko3YqW2gPTDu4tz5MxsmnbmLZu2FhOHsw7yt+Xszhj4WF8+0VDE93amyxvNTraODuh9FuqToZDsN/HjidfSR4X1/Mf1SW3JKdOaQorzclX1eAq0Yl+EAp+qKtwHfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOSUTjZokd0qmySaemTfH4tzLtI4R+C9RZJnsMCufJs=;
 b=Aunnu1L85HoCE/g75A7OxchcyMELFOYOKJKRy1CELaSk+K1b9WhDwx5wwBaL4Srppn/yAkKWPOHusXfjwuLNuZRahncoaglHhnvwr0o0vZSIjPFt8RDghKutw/B1gFpesNOvGIpD1NrFJeLLFr2+LzNAfWKVKob7l7UnDWxip2S0kUxd7erqZu5b/my0x2RPe06OmYij+DzYV7qWaT3b02y9bdWI9frFY2gjFR5Iuz298kBX8wlCJ/+RV6r9Q0erft9fLXzIyr1asv6/5C2EE38f8DWHM0d2YUrFW3GkJmcjHCNMMjpoz/i7pGyY2kqJrIuCEXZ8b4rjzb7E1jThyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOSUTjZokd0qmySaemTfH4tzLtI4R+C9RZJnsMCufJs=;
 b=M06o7hFtPMAImZqWUZq7dcBuVn+SbmrRciCDCD97lBaipqqGv5o/AelSmVSH5R+EKi2tAO8LPThSU1IkGEMqvV0qWB/+iS6SdqJY5CoIBAqz+VgMSkWtT0Y5LovohqMfo9Atg2Sw19H02+Mif1l7xvkNZFn7z2VmGwr3xeVQJug=
Received: from MN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:52f::29)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.30; Wed, 16 Apr
 2025 04:45:56 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::af) by MN0PR03CA0019.outlook.office365.com
 (2603:10b6:208:52f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.35 via Frontend Transport; Wed,
 16 Apr 2025 04:45:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468D.mail.protection.outlook.com (10.167.243.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 04:45:56 +0000
Received: from Harpoon.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 23:45:54 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Allow P2P access through XGMI
Date: Wed, 16 Apr 2025 00:45:28 -0400
Message-ID: <20250416044529.1147595-2-felix.kuehling@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416044529.1147595-1-felix.kuehling@amd.com>
References: <20250416044529.1147595-1-felix.kuehling@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 146ce899-0df0-4ec4-c2db-08dd7ca193ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4K7vN7JgrJ978r1n9mc7vMTJc92Aqtb81/p44EvWOj9miGCRALJ9Lqa0dOox?=
 =?us-ascii?Q?MqhnTJ67VZsymZuU1ak9TVq5dcF2xJzYzTybwKPUx4Aa1A0mzmoRGpCOatmF?=
 =?us-ascii?Q?XORWtFLDQKfl3DFK6wIBeYWrKpu6BvBURgey7N/pmjtIqLoyXHtluuxiu/Al?=
 =?us-ascii?Q?QLKxQlt3zGNWXR12dmAciKTiJncH1GL7qLCBHvbiOTsS19lT89FaIjNpDgYP?=
 =?us-ascii?Q?QHIUKx1rLfzI0kqxZwlWfP83AH4ZeBiKmaChwuO3xXet97FlqljcP3tY45SP?=
 =?us-ascii?Q?xFYWHC6DBIDXBze9wsJ59lneQIcSlVBfIzQeGdSG3oO1fQ9Mw95FiOcfTdqt?=
 =?us-ascii?Q?YH1j/MGxVo/QtTc9A485GiiUSVhKDcU+J2DYHdF6ERTAiNubGEaYqpfD/ZxA?=
 =?us-ascii?Q?g4vZQOdYVUpT5yu+1dAULC1LL9hyZReFzUtQBfxrMtB2sqAZj1loM0VV/2ZS?=
 =?us-ascii?Q?Mvda55XlVHxc4/W8TfZ1wMzyZW7v9Z3DwgPTr9GfV9TQ/ZvZb5BVwK2UE7T5?=
 =?us-ascii?Q?5Q+vNJpKHZC9bo0VdCYLuQm09nMczw0iuI1HnlgmHkeVgw65GXyne7SuEUQT?=
 =?us-ascii?Q?XS7XrjShhuZc8x/Hle73tkY/D3F4gGtA5nWwwm0DvP4q+zyggiAYQBOdWln1?=
 =?us-ascii?Q?wGRqAsOHAH6jEwztqu0g8QVLRlFgssBkB0XIy+DKVa5VonBqPeJ+kKGxELH4?=
 =?us-ascii?Q?uJgM0/l0lrLlGKhPsoWMazWBLkCAUilpAPVBEnJfenvyaCtMO+ty93Oc0Mj9?=
 =?us-ascii?Q?zG7YjdNQoT7XNnfNcLyJlYPU6uMMK58DKOp34s4+vMa/dwZ4f3/g9IFq4Vsr?=
 =?us-ascii?Q?9A25Oh0lQH8aZI+dZ/SumLciYJGYDpepWfmmxVE8ynr/wr2kKV+sSFaBH2Cr?=
 =?us-ascii?Q?Er4K/e7mj+5MQqT3tDDW4elrrxYj1Nj0JmZPzLEKRw07KUF4uEdOWl/ZoAMc?=
 =?us-ascii?Q?yOPDj1Klp7vmH/smLKXQUijXACuKnk9hiHOVCHNirkqdl3YBNgt91idxiz1K?=
 =?us-ascii?Q?ta6q63Ru/YZ6UOz+ESSy49VnFSmSLEz20e/Cz2smiHKmcSpwnFCoINzLRp7J?=
 =?us-ascii?Q?0eNB7NCQgJMy5PU8P0wn5EUOs11PYFkmnWhufLOCrE2VtzIzVNHI5PS0f2pL?=
 =?us-ascii?Q?+ph9zT/tjg1WpeHhUeGbWkG2upKtqiu5PE7IEBNh9I5XbD0D/ua4WvWK0HzX?=
 =?us-ascii?Q?cAcVLpYeFVGiChMPv8he6mB+OPiyBRzZbXbcIHvdBBvRvaIyEZtJnQ4uymN/?=
 =?us-ascii?Q?f1aS/eJhRtQmaSyK+WhTXPudj0E0UNkgsAaB2raFL0OEhSXtnJXAjExlWDEl?=
 =?us-ascii?Q?MgtGv/mBUxAvk3+UbYVW9kHbMA5tkBeQNWK9IjRjFIGoAhgjIyLmvRRFBck2?=
 =?us-ascii?Q?vqcs1AswIDrUgRZzLInRpe789+ATQ3zSmZS4l/AlgWYACqnTVZrY4xUC8PK4?=
 =?us-ascii?Q?oRUdLs6v0fKGoZDRTzmhzkzcr0+7leTQVCHssD2JNNY+UVZQ7chYdMf/2mwp?=
 =?us-ascii?Q?fU/NOaSMmyVjYd+8g3sCzfFK+gaKnVMPyPP8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 04:45:56.5138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 146ce899-0df0-4ec4-c2db-08dd7ca193ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
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

If peer memory is accessible through XGMI, allow leaving it in VRAM
rather than forcing its migration to GTT on DMABuf attachment.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 31 ++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 9abe592968ab3..a72c17230fd37 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -43,6 +43,30 @@
 #include <linux/dma-fence-array.h>
 #include <linux/pci-p2pdma.h>
 
+static const struct dma_buf_attach_ops amdgpu_dma_buf_attach_ops;
+
+/**
+ * dma_buf_attach_adev - Helper to get adev of an attachment
+ *
+ * @attach: attachment
+ *
+ * Returns:
+ * A struct amdgpu_device * if the attaching device is an amdgpu device or
+ * partition, NULL otherwise.
+ */
+static struct amdgpu_device *dma_buf_attach_adev(struct dma_buf_attachment *attach)
+{
+	if (attach->importer_ops == &amdgpu_dma_buf_attach_ops) {
+		struct drm_gem_object *obj = attach->importer_priv;
+		struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+		struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+
+		return adev;
+	}
+
+	return NULL;
+}
+
 /**
  * amdgpu_dma_buf_attach - &dma_buf_ops.attach implementation
  *
@@ -54,11 +78,13 @@
 static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 				 struct dma_buf_attachment *attach)
 {
+	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
 	struct drm_gem_object *obj = dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
-	if (pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
+	if (!amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo) &&
+	    pci_p2pdma_distance(adev->pdev, attach->dev, false) < 0)
 		attach->peer2peer = false;
 
 	amdgpu_vm_bo_update_shared(bo);
@@ -477,6 +503,9 @@ bool amdgpu_dmabuf_is_xgmi_accessible(struct amdgpu_device *adev,
 	struct drm_gem_object *obj = &bo->tbo.base;
 	struct drm_gem_object *gobj;
 
+	if (!adev)
+		return false;
+
 	if (obj->import_attach) {
 		struct dma_buf *dma_buf = obj->import_attach->dmabuf;
 
-- 
2.34.1

