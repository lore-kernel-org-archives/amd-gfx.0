Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D428C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Jul 2025 19:20:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBD2610E0AB;
	Mon, 14 Jul 2025 19:20:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k6MsDlHa";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8716610E0AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Jul 2025 19:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+4BhKcyL43YXsvuIsnSlT541Uwv499+GctHQh0P+gGRH1cZi0K1UaKGAs9yDt3RalPKAEJw+qM8hKgW/IDvftxslkJttU6Yn175xiu9k3ApumeU8oadooy5VcDhP45/bIhwM5CZQaGH8WZqS5MyI26bMIP1WnvqngOR5XNp0EtqM5JLwur9ZwYToJ9ICLeuXLbN1fdud6q44VgqR+CIErWfe0e7n+tv3dfzeDE6iSGTrcwDtDcdrfLUhjvGYJXk0tIc1K4Xlp/gB8o1UQSxObzzb0p+ztxmlKrj7zELGEcDgXAq1h8mfYsJBWlzvXcGAcc+oGBJKRMhdoY01Kb3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0LeRoGjtVfXoQW77ybPcV1ppfXyeNGbmzoUnBIOqog=;
 b=Ab1w3E4kjU/5k8rJsQWNaLwKu/aaSy2ycbVT9f2imcT6+Q8DPOcQyBqGMct8f/rwKyfxTM5Z6Il93k8smlnOhtT02fSE+1/1smc8F6Rm79u7xvEdSYSlh2ikzK7VRHKZ/mEg6E7+FehrWpo9aKCZrrraQ3enGmdh/yLkc0w+1hMvhCiGcMcyqgbKoG3U7HzV741u9xnY74oWG8sUpJMtJhexq8k1jOdNeDLFQ6ayua2cvvi2zmCrwO3gghrJlEZ2Kok3HVCEneZKyMhoR1LPdS4lchUzKWR+cTaDJSPxoP8tqxiOoG72fk9iKlcp01q9JNADLNtpLL0VkmKo5qZdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0LeRoGjtVfXoQW77ybPcV1ppfXyeNGbmzoUnBIOqog=;
 b=k6MsDlHaJi0Arz0i3b2PtF7FWMMYk7UIH68KxmLdnfP11ptIiKvNib3vy6eEUOnl/DYpBN/lFhzVqc1wdUR9egfNndN+EgXGPgupzLQDq3Nv+Z+SuqblQvD8EWtk6kMo3QzltJ2XScDTCbiIXDboU5iLJO2NYcCAcEuBg175ADc=
Received: from BL1P223CA0028.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::33)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 19:20:47 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::8a) by BL1P223CA0028.outlook.office365.com
 (2603:10b6:208:2c4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 19:20:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 19:20:46 +0000
Received: from dogwood-dvt-marlim.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 14 Jul 2025 14:20:45 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <mario.limonciello@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd: Use drm_*() macros instead of DRM_*() for amdgpu_cs
Date: Mon, 14 Jul 2025 14:20:32 -0500
Message-ID: <20250714192032.32089-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b69f23f-cb17-41f1-bb3e-08ddc30b88ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CanPH0I3tVXC1qGZJpfDDoN23HSGXWCmtDekr0pl0JaOwnmz5l3MB9LeYZPB?=
 =?us-ascii?Q?KoWvBSPoA/AxdfQief9ZesrtUChT5WQYhd1Qz+DgxxIBXZTtmaQc8w5Tpr2M?=
 =?us-ascii?Q?qStJUu2DMrpKoqpjwocr3N+ZSvqFdJd051dcG9/T7+51eDwXY5Ucsdghw9zC?=
 =?us-ascii?Q?f//hm4X4YB+xS6mNbN7pT+Nj7nrhJ6r7st8jiO6gpVGeoAZLZFSMnd5FTLbZ?=
 =?us-ascii?Q?h5KC7qWGkYHyPFSn3S6BM1GexvJJZYr2WvO7Tif2qFxKZwsnawt6ur/r7Z+N?=
 =?us-ascii?Q?hCnLFjRgIghEHLavFf7XSa9rC0BMmOpnhhEThi32gUbdo8HhFEsaZSbxOTEY?=
 =?us-ascii?Q?J1TeMkGQfMxrFSMOEtfRbA3JGuLc5IZi10rXVtPAEMS4zvfQCD/B+1ltdr1a?=
 =?us-ascii?Q?0wttz35LkbIgZBF73eo+en4YBIomwQ+7xSoliPN+aGk77ZVCRNrVGNIzxpsb?=
 =?us-ascii?Q?Ndrpr/ri1l6/2kwf3Bk4YnUAWUqdmJRtl6RaBk3lgz+RHNUUebwnBM0t5mVV?=
 =?us-ascii?Q?LSNarG7Mcm6tFfWdopSrNi0ee4SgzleCrnQ7AV3ARQhKRY6HZi3Ph/iXcPpO?=
 =?us-ascii?Q?b3EqdOJvBEAoGWkkN1+dcalR40rmekh2ycF2NANAFd4FxIKBITX2lxg7HCTq?=
 =?us-ascii?Q?vHwMxZcOnRr9Yi1ZFs0fJOMxfUCsOwrDwFNxgkWYAocqLtPq/aTkkbVgVxOw?=
 =?us-ascii?Q?R1jqGd0xEy0G6b8ByT0Jqwh5XJYsIFhEVjBW6HuaDKlSBZ9J3l+PmTlkii76?=
 =?us-ascii?Q?NKi0T5wIQ7ETQqSSSr/GDauzQY9zpA/cLvy4Km0aYPMzjRXabLIkRq+aGgkl?=
 =?us-ascii?Q?qr02NEkPuI02vnYu3nLPoLna56cR7JrhS339iR6oZDJOR6kgvGL7d315rQMI?=
 =?us-ascii?Q?gB2mV5kZh0O90BCAI9RVx6cZ/lIl3VgrmBIs3GyzR4U7PWnEaD8QG9uvraz/?=
 =?us-ascii?Q?ekpHrGLuDv4jShCDpsRYuZ2BF7UbLhbaqxRaPtnaPb8ddj0AK0vLdUdK7/at?=
 =?us-ascii?Q?n4V2bBDOMyW1MaE0iMXZQ0UGl8wQt+/0T22t80Sg6IbcO1CXveFMo7uB2YHm?=
 =?us-ascii?Q?GV1d7BVgD9472r70SKcyLfnEpHlcBc4bdjJxqwqTIoClnjJegEUGQisnocji?=
 =?us-ascii?Q?hFxi8r9g3a4LY4WAp5Kmh7bBaajUQFZfT6Z/X4bDlZ73NFcvV/fs5MuLKh70?=
 =?us-ascii?Q?F7gAi1kN2PEfmFWQVomkZuW3ZK4mjTss3HawHxWxg+Z9WEr1eJh21Q9b2pA/?=
 =?us-ascii?Q?KnlMe+ha2xglvdYAurBL/wpOfBCNX5A4PZ7e3YblGAsNUZVl+4cpgr+crkc7?=
 =?us-ascii?Q?dR3TrXJ80V79y9dBUfQcu3bkdQVLcQqwABaxrVEC9LbnuE15VUd90XIm/yTv?=
 =?us-ascii?Q?4B82gH4KxhkqicaIetAvMal6uT5Qbjxa61laW0oV2BQnr7qhYg79j1O+m3sI?=
 =?us-ascii?Q?Qx/OGrnJU0abjn3t2LkO5JANpT/YQsJiJDG6gbopY2DYX3TM5vp3/uYFSAoh?=
 =?us-ascii?Q?Gj1u8ieTuWhXtZvmtoVNXvSv2tNd5+2R7Fwu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 19:20:46.1770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b69f23f-cb17-41f1-bb3e-08ddc30b88ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

Some of the IOCTL messages can be called for different GPUs and it might
not be obvious which one called them from a problem.  Using the drm_*()
macros the correct device will be shown in the messages.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 9ea0d9b71f48..245c2696abc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -395,7 +395,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 			   chunk_ib->ib_bytes : 0,
 			   AMDGPU_IB_POOL_DELAYED, ib);
 	if (r) {
-		DRM_ERROR("Failed to get ib !\n");
+		drm_err(&p->adev->ddev, "Failed to get ib !\n");
 		return r;
 	}
 
@@ -467,7 +467,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 
 	r = drm_syncobj_find_fence(p->filp, handle, point, flags, &fence);
 	if (r) {
-		DRM_ERROR("syncobj %u failed to find fence @ %llu (%d)!\n",
+		drm_err(&p->adev->ddev, "syncobj %u failed to find fence @ %llu (%d)!\n",
 			  handle, point, r);
 		return r;
 	}
@@ -901,7 +901,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 					 sizeof(struct page *),
 					 GFP_KERNEL);
 		if (!e->user_pages) {
-			DRM_ERROR("kvmalloc_array failure\n");
+			drm_err(&p->adev->ddev, "kvmalloc_array failure\n");
 			r = -ENOMEM;
 			goto out_free_user_pages;
 		}
@@ -982,7 +982,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	r = amdgpu_vm_validate(p->adev, &fpriv->vm, NULL,
 			       amdgpu_cs_bo_validate, p);
 	if (r) {
-		DRM_ERROR("amdgpu_vm_validate() failed.\n");
+		drm_err(&p->adev->ddev, "amdgpu_vm_validate() failed.\n");
 		goto out_free_user_pages;
 	}
 
@@ -1060,13 +1060,13 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
 		va_start = ib->gpu_addr & AMDGPU_GMC_HOLE_MASK;
 		r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
 		if (r) {
-			DRM_ERROR("IB va_start is invalid\n");
+			drm_err(&p->adev->ddev, "IB va_start is invalid\n");
 			return r;
 		}
 
 		if ((va_start + ib->length_dw * 4) >
 		    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
-			DRM_ERROR("IB va_start+ib_bytes is invalid\n");
+			drm_err(&p->adev->ddev, "IB va_start+ib_bytes is invalid\n");
 			return -EINVAL;
 		}
 
@@ -1234,7 +1234,7 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_leader_idx]);
 	if (r) {
 		if (r != -ERESTARTSYS)
-			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
+			drm_err(&p->adev->ddev, "amdgpu_ctx_wait_prev_fence failed.\n");
 		return r;
 	}
 
@@ -1447,7 +1447,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
 	if (r) {
-		DRM_ERROR_RATELIMITED("Failed to initialize parser %d!\n", r);
+		drm_err_ratelimited(dev, "Failed to initialize parser %d!\n", r);
 		return r;
 	}
 
@@ -1462,9 +1462,9 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	r = amdgpu_cs_parser_bos(&parser, data);
 	if (r) {
 		if (r == -ENOMEM)
-			DRM_ERROR("Not enough memory for command submission!\n");
+			drm_err(dev, "Not enough memory for command submission!\n");
 		else if (r != -ERESTARTSYS && r != -EAGAIN)
-			DRM_DEBUG("Failed to process the buffer list %d!\n", r);
+			drm_dbg(dev, "Failed to process the buffer list %d!\n", r);
 		goto error_fini;
 	}
 
-- 
2.50.1

