Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB50ECCF9EE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Sep 2024 20:00:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9046110E85D;
	Wed, 25 Sep 2024 20:00:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H6Op+JxD";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1AC10E86A
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Sep 2024 20:00:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HcKxA4qh8cxqtO7LPb8crDYZI2W9yLckmEPyGf2H+aaO1orNicffRqWTmTrLsbYa1+ivp+oQ7pfp7Dscl+lzIothWUIfprTjWsbpC8u53Ze+pev7UwiH33jyk8IU0EL4KxZZFXc3zIO5Ig3+REQ9X6wEv8ma3LiqunAruJpBz4jT3siMn9zlq3Y64vugSo+Hxtl+HeNZvXnsZSaGwGb/BjYbOAwisVexla/fs4I61vIJ7Arh+ff95rMCpimXFBi+NgTYuBdQNVnCZBGgL/EZg51rPXtX0OYK3Ow2nwAStSQH2XbiNP1cM3s2hE3Rfvx+52HVmK6K7bwdfF77Yp1Tkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ1V0JzQp1p0SUvzQ2cJbpTfCgsHqkauIxmuFJ7j70U=;
 b=ckyLzRy9KEfrjfH6vQMvC91tpWdbUzBkE2deriGIMAEa6mah4LtpWYaBrvKLTgzDoSe+pmbRLCy/Y9iVGKN7QbVc4gNfQKYaeZVhmpOalwdRTORgZg7aONmevGpAK+aVyINWF6PHcsD+U4d5dsJGlnyj33CDP3X0fT6dndPkDJU4OCIMubAYPWToU8dflg0NU3rteVbp7/O2QY9PB87933eNxRD8Ie+CN6tYvIE7mOQgBC+SenlNY2zMRCmPxvT/DOc7BFRk+pidAEY2TCP7JVo2Cbamd0BJ+cZeChe8qtLRP77DXk/+/Os8k/Nknjr30UGMKT345dpe7zvHT0pxzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ1V0JzQp1p0SUvzQ2cJbpTfCgsHqkauIxmuFJ7j70U=;
 b=H6Op+JxDqsz8s2ghsvavHNzuL8Y0gPjMjroXei++IaIzednklAyTnUHCEpJyammP0gFOB4NV5FZKypVf6eJCcT6UsJNfXH9J762ENnwPyER8hvAyilJqxKEjfQxeMi2fp8A65Nt1ua0XT37kc4lOH/0RilP2RYvCXrK1cXl2DCg=
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by MN0PR12MB5929.namprd12.prod.outlook.com (2603:10b6:208:37c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 20:00:14 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::9b) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Wed, 25 Sep 2024 20:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Wed, 25 Sep 2024 20:00:14 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 25 Sep 2024 15:00:12 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 08/08] drm/amdgpu: add vm root BO lock before accessing the
 vm
Date: Thu, 26 Sep 2024 01:29:28 +0530
Message-ID: <20240925195928.142001-8-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240925195928.142001-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MN0PR12MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e8c37f-80c9-4f24-a2de-08dcdd9cabc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S1CPJDoxyxSsdxY0fyfmoSYbkLV0AIQA3h7ls4SCmCb3PEkRQ7JO0xwxW5fa?=
 =?us-ascii?Q?h9dOStKYrtS1p34RFMc/Jxrx0iGp6Fvoj+HDTLhUqNwHEbhBmdOsc/DE/yT+?=
 =?us-ascii?Q?Qh9r0jd4Acipcdh+3uVGZzBnjY4UfiJwAsxrrIzH8c4va/KxCZ+cqWIaZXSC?=
 =?us-ascii?Q?MUkCKszr7pjVGoAWhPfvAnEDujDqAgsW/pCfSUZhjy0Lz3ijgvawGkOLvfQH?=
 =?us-ascii?Q?TDtanq/vOULIa0of/oKZ2YkyinKAeGcsQxd1Coum5AP22eDwBcSCoxWQaxye?=
 =?us-ascii?Q?2m+ns4/3YOuPMmM1GMdf0OWBNEWDffJI2g8e6r0d3BlvL0td3gbVvYxAH3n5?=
 =?us-ascii?Q?B96sZIOXRxFhgw3J2QNm7zHA5jLnleTIYIZTLyBz9FwuF+kJ6U43aX0xZze9?=
 =?us-ascii?Q?Fr+0GOCm8yhj7FcFbrr95lkbCYpJqCdWPsKMK3x9jyQla/trswNnjblVqRYJ?=
 =?us-ascii?Q?DmJteQO62IpbXrdGXtX/VbTInZlIX4OMYXj32Hcj++aWySf7gGRb1ysfkzmG?=
 =?us-ascii?Q?l9twDp9sLc0qNhrCjPuwjSwvuh50YJJuYefD3TSKJqIOrIHOC9BSunU3ZBE0?=
 =?us-ascii?Q?4//yDhuQiM2M9BrUI3Y9F7V/cFA01ysf24yyavhJRiMY/9R/cS8NxJE9lduU?=
 =?us-ascii?Q?dh6quQtIcuSJCjvyXjA/PLX1Jjg7Ss/nAGnreW6UBpD2DPQRb2j+BONVMAgN?=
 =?us-ascii?Q?cDK/BE4FfdtM073NwE/svF2f0SHL2j4M9RqfnvCqoTbg4XucZ2bUfZzYWK73?=
 =?us-ascii?Q?y+cCm2a/077cCH7Ba/o2b8+b+Fp2vsoDoIF2W65d0EfN3C3QDv1HcDBA7nRG?=
 =?us-ascii?Q?kmfY0BjbSAPmTbfEOGx3/8J3h0imPOJzzdFVrb/+47bRrOoWzwVWN1+OATy4?=
 =?us-ascii?Q?mKofFKMqlNTJGp3OQ4Iuj2ITJ4vk42zG9/dLm2uGXqkHMMVZg2sx5pgPGxNa?=
 =?us-ascii?Q?JJK3TcXOEf9RI/dr2Y0k62f27HRyWkdgB4X84LwefkiMOw3hb/JUYr4s0UlL?=
 =?us-ascii?Q?RwrUgoypRg/m5QqhrIbrhpAmIYOfymK9pxQMptKYk1TTpKLLq0tYqqMa5ybI?=
 =?us-ascii?Q?SOPfOh7vQgrS44RVJZV1zGRxgJ0jcSMrivUK9Dr/7Qo3MqNqDBho03KgBHe9?=
 =?us-ascii?Q?4QM71xfBrXaNTPfWWEN3GvibOaFyBVgU9WrEAop35O6BARAVQKA0WhX3ySbD?=
 =?us-ascii?Q?xDdS4W05GyeaGnwdRETwk567pQkxgE6hBI1IApAttlAVmqDsRJyRKLC61L9l?=
 =?us-ascii?Q?Wiaz/ssy35mfWYYaGYAur7iVJmkMVcqCt+hLzZ6W16LQJmO6fYuCc90Ml0Mh?=
 =?us-ascii?Q?RGrD83ExWv2RHf9/Zdu29MK52qhyuCkMcFiYm/HMX9IxB/ihPsCpgNXb1E2F?=
 =?us-ascii?Q?IOvX+9D9i1NEGLENGWOB0XLJR75rLd6ElQWWTJxSjVi5P4QuSYhJ+v38IiaB?=
 =?us-ascii?Q?p1b4nXMsWbYvpqd+LUj5FybG2oJvEBQ0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 20:00:14.4788 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e8c37f-80c9-4f24-a2de-08dcdd9cabc4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5929
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

Add a vm root BO lock before accessing the userqueue VM.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 43429661f62d..52722b738316 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -320,7 +320,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 /**
  * amdgpu_userq_fence_read_wptr - Read the userq wptr value
  *
- * @filp: drm file private data structure
  * @queue: user mode queue structure pointer
  * @wptr: write pointer value
  *
@@ -330,23 +329,27 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
  *
  * Returns wptr value on success, error on failure.
  */
-static int amdgpu_userq_fence_read_wptr(struct drm_file *filp,
-					struct amdgpu_usermode_queue *queue,
+static int amdgpu_userq_fence_read_wptr(struct amdgpu_usermode_queue *queue,
 					u64 *wptr)
 {
-	struct amdgpu_fpriv *fpriv = filp->driver_priv;
 	struct amdgpu_bo_va_mapping *mapping;
-	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo *bo;
 	u64 addr, *ptr;
 	int r;
 
+	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
+	if (r)
+		return r;
+
 	addr = queue->userq_prop->wptr_gpu_addr;
 	addr &= AMDGPU_GMC_HOLE_MASK;
 
-	mapping = amdgpu_vm_bo_lookup_mapping(vm, addr >> PAGE_SHIFT);
-	if (!mapping)
+	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
+	amdgpu_bo_unreserve(queue->vm->root.bo);
+	if (!mapping) {
+		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
 		return -EINVAL;
+	}
 
 	bo = mapping->bo_va->base.bo;
 	r = amdgpu_bo_reserve(bo, true);
@@ -448,7 +451,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 		goto exec_fini;
 	}
 
-	r = amdgpu_userq_fence_read_wptr(filp, queue, &wptr);
+	r = amdgpu_userq_fence_read_wptr(queue, &wptr);
 	if (r)
 		goto exec_fini;
 
-- 
2.34.1

