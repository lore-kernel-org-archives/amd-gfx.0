Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F197C369BD
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 04:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BF010E822;
	Wed, 16 Apr 2025 04:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ujn9yoUW";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDB4110E837
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 04:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F5gagRU7n8kCY2C8RsTR63cWKNk4EkXex/uIzJNvLQFGI/8z3SxGZEf/tMb+iuosqL9xGrrhI6BOcDXDEYdMSW0/tyRxZgxaQj2Eey/OYBV9XA5z6k3++RcjyhPKCVxy09T5adRBu0n9i8Ip+YpLKHuCQMKs2eTBL9kLlW5/H48Y9XaKn+3i54FdvOVvYh9DcUmcBYpYLFFRJOrPj1oGRprRqaf4yZif2G9YpIxG7DRSGzrMRNnm/iJ5/SNTh7dk+dxCrqGjiB2IScasQSyMFdGNuMWo9e8m1DTon/rYUg2lIOX0M8tZoyFNqYcfvzOvKLntBdPXS1bHL/11MGO9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roalYcMVD29FnE7DwaIGtj80w6NdRsoCzbs/yHaNZKo=;
 b=FifZqxFundNgoMLIsjJ445tgWKcVPEQMlGFfj0yD2VtQ7azjnx7dFjlkASSxFW/emFyGZGkCc0pnWGjYMwMC/7tlSeMSwrKCi5GldsNsWdEXi6Zro8WKgtIqmzAKn7UIHSNKWsDt25SKBLK4CCOSajvJndlBoNRdhiEgR66vEyCohgRswJJj9ZfqS8ylalU6DIJ8HlqfZElLjVUsDUcLK/ibW01EzA0AzyJ+mTEN0w0983kBAyDztKo+5KsSn+AH7D8nvvXle18YnHW86QhDkVZrwCXOLnJGOMMgt/Lbz68J0icqfz/VSkDQYilaNd0BjoRkVQkDLDwM+zZei/NsUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roalYcMVD29FnE7DwaIGtj80w6NdRsoCzbs/yHaNZKo=;
 b=Ujn9yoUW5uUHAL9APTiwXVNmjd+tOpoQRhR6TbZPEGzCr1UMYBfftF8+Od8RZlJDjJFEknAiFjePajDA6xuHGt+Ke8YZad9utN7s6xCxc5esZPfe+2Qc2djp12w1roLp5SRv2ZcpkH0f+wbSk6VbBlz/bbe7dVT2z7Yum/JlPWQ=
Received: from MN0PR03CA0021.namprd03.prod.outlook.com (2603:10b6:208:52f::35)
 by PH8PR12MB7325.namprd12.prod.outlook.com (2603:10b6:510:217::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 04:45:57 +0000
Received: from BN1PEPF0000468D.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::9f) by MN0PR03CA0021.outlook.office365.com
 (2603:10b6:208:52f::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Wed,
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
 2025 23:45:55 -0500
From: Felix Kuehling <felix.kuehling@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <yang.su2@amd.com>, <hao.zhou@amd.com>,
 <asher.song@amd.com>, <pak.lui@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Optimize DMABuf attachment with XGMI
Date: Wed, 16 Apr 2025 00:45:29 -0400
Message-ID: <20250416044529.1147595-3-felix.kuehling@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468D:EE_|PH8PR12MB7325:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b202de-7d07-4a81-c002-08dd7ca193e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PK1liw4Wa6qIwkBBgf5u7aDadPp+d/Q4+MwxuOxdmQtYppbsRtqGK5OIu8w7?=
 =?us-ascii?Q?ZZmBejStWdPJtNyisdPCAwsmxz43eyGduZbRfNFAoZkYARx4NdzWptkjlVZF?=
 =?us-ascii?Q?o/+3i8TG+FWnDqK+N1QFzg3t3XOqsigo/4BZqAx5lU6FaVGX0XA2BLFtUmVz?=
 =?us-ascii?Q?Tm8cBKJC+C29sSrcXsJXBonfzVOpJGZo8e0nuLOjlWaZtvClUUyCOeCCZKuX?=
 =?us-ascii?Q?DVlNMMTJ3FSuZn9ByKO9WHMKHy5vc7Dq/HTdNc46PL8m/HPADdHmSCQMxKX2?=
 =?us-ascii?Q?kDUFekYmi29hIltENUsmRDGQk3DwdkqKD+03qWbpgqrlK5yDMNhkYjr6xz2b?=
 =?us-ascii?Q?2O+BNQPGirPxroeoR9TfsVMK6R+ViN9fsZDz1xhfhH2JxdsWimwbPhX+qPDh?=
 =?us-ascii?Q?+ihsrOhb8+55VdT3p+j40h+uxxlAonOUYG9nbLOwq0FmMs2xktTbm+n9SZ7J?=
 =?us-ascii?Q?STiLtH1PoS5D6sfPOQeVP0ahPrdAelBKXZwYtUYCTB+nEQzCPsyLxw0H/E6l?=
 =?us-ascii?Q?yCQqihYyg4CkvhVf6XrWOIDtDnDSG2al9ggZck+1ubzM6jKUwbodOHExOpqs?=
 =?us-ascii?Q?KbTLbecfmtxIt8pGKlZEtTi7lhRcG8iVtF2bzpL4q5yXVBzX4A2E3CqKCKVJ?=
 =?us-ascii?Q?RghqxRuYGJEJVTCvx9Fg4E9q1x6/4SmEJHQfveFaO5aR2nQq65U9/4Rk7/IL?=
 =?us-ascii?Q?tAh2Q6UEMv3SNNfABN/NUKAc3K6nkkwHaqQyBQtDSPvV/Uuc4ixpOIDoglpG?=
 =?us-ascii?Q?DY01LAMk5ugKe/MGUcjVeuLekWndEh5DS3D/iHGZS/7Si55hgg8lKs1EM91d?=
 =?us-ascii?Q?CICvsWbvyRdlBFxLR0vmhbc3TLDihhJt5oWv9yqa1vvjK/N8aLwRUFgbAflw?=
 =?us-ascii?Q?109T+CPzDQFODsJGjaTBKpOCCWsewD4n3sePiNcMcBtUGN1LQwAyHLn9iroT?=
 =?us-ascii?Q?nyf9Z5SD6WvLIe3d3b7JWVL4lBjLM2se9UJ/NRHj6e3ejMb6FK9w+RFOBrvB?=
 =?us-ascii?Q?O24XwzfQptFCccyW2xf/nqOsueQ+fpoik6SJRIjBjTWDNQkZq5kxZzlA01pz?=
 =?us-ascii?Q?59wyHRHaFBjPoI0jhls5W3brjcTeQZaTXSA7RaChCUtwTaVejWnb4IPYDSgX?=
 =?us-ascii?Q?BvRBN7gSAlujIe5Q3HlaAeabo0GVzfBDwj68v5fLvQgVrsmWkceSi9ipQgpn?=
 =?us-ascii?Q?/bBNyf9T5m2pzmq290PTg874DCNs0KeOGvvRqrmHJiDxAFIoq1oqAmM9AqGN?=
 =?us-ascii?Q?jN4zRav/dWFcGQDMkRllNQ+yO4qgJnJ7vc+PWOc9XO41p/B+u7TZ/STGDNxu?=
 =?us-ascii?Q?nuLqZSGVuONQGyuyuDDolVVZyGcoj1gsXLnBixuiI8Myj9YMw65NYQ8iInvD?=
 =?us-ascii?Q?vh1bGIEMeI/Lm4Ovw78PKncOebnurYC8oHWNH5ovU/MIjs91IaaHGq70ttg7?=
 =?us-ascii?Q?T7+20tN4o0ageE4tP2tzKS8IQo42PKSswWULzhL19uOtuzqRU3qYllY8cOQA?=
 =?us-ascii?Q?v/Hc3IUnFb/jS0dadLWgNRAffXbvnKHOL3rz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 04:45:56.8991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b202de-7d07-4a81-c002-08dd7ca193e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7325
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

When peer memory is accessed through XGMI, it does not need to be visible
in the BAR and there is no need for SG-tables or DMA mappings.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index a72c17230fd37..d9284bee337ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -144,6 +144,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 	amdgpu_bo_unpin(bo);
 }
 
+/* Dummy SG table for XGMI attachments. It should never be dereferenced. If it
+ * is, it will be caught as a kernel oops.
+ */
+#define SGT_DUMMY ((struct sg_table *)1)
+
 /**
  * amdgpu_dma_buf_map - &dma_buf_ops.map_dma_buf implementation
  * @attach: DMA-buf attachment
@@ -160,9 +165,11 @@ static void amdgpu_dma_buf_unpin(struct dma_buf_attachment *attach)
 static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 					   enum dma_data_direction dir)
 {
+	struct amdgpu_device *attach_adev = dma_buf_attach_adev(attach);
 	struct dma_buf *dma_buf = attach->dmabuf;
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	bool is_xgmi = amdgpu_dmabuf_is_xgmi_accessible(attach_adev, bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct sg_table *sgt;
 	long r;
@@ -174,7 +181,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 
 		if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM &&
 		    attach->peer2peer) {
-			bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+			if (!is_xgmi)
+				bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 			domains |= AMDGPU_GEM_DOMAIN_VRAM;
 		}
 		amdgpu_bo_placement_from_domain(bo, domains);
@@ -197,6 +205,9 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
 		break;
 
 	case TTM_PL_VRAM:
+		if (is_xgmi)
+			return SGT_DUMMY;
+
 		r = amdgpu_vram_mgr_alloc_sgt(adev, bo->tbo.resource, 0,
 					      bo->tbo.base.size, attach->dev,
 					      dir, &sgt);
@@ -228,6 +239,9 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 				 struct sg_table *sgt,
 				 enum dma_data_direction dir)
 {
+	if (sgt == SGT_DUMMY)
+		return;
+
 	if (sg_page(sgt->sgl)) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
-- 
2.34.1

