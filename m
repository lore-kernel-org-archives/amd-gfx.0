Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 455ACC83F03
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jul 2025 06:04:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDA4D10E738;
	Wed,  9 Jul 2025 06:04:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O2IsLvo+";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7732C10E72A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jul 2025 06:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FoT/BnnHUoAGzkVSjllxQPVa0z9jJ4R8zeFE3AtjjhGGwobhiVs9ljCUNKNis967nrqS1uFTTlMYbeYgjoi6G7UZpPKViWDt2RdEt+oM/PFEerDvu9J16wnjQ+0HClj2vwXOr3WvTwrcDyxztSN+MTZbzaXwkokzJJj+YKz9Wd6Dj1LTU1Fsoso2mX4QDDmqiV0VhVWTHaTw3gYGsTQuybKUKiecgOmvxTwdYXh9Shr5rV1fSEblrp6GUgr+TqKnjDR69d8/RiNCSeow/mtJ5wfRCjaIgxnYssV64FkReNW/66ZQuCprZC2tdCfCqZ0fWwNNm1btB9ik7NIK3EHtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1lBykR1S70um9eoT1HQsQXzGfQINdyw5V/Y/NoSkv0=;
 b=tOj0rFFQ6SYnnZwxL1fj+qE2Z6pWx8bh4t+AYgv6/BgMKr42IrdpPdMN8SLuBD+h9vOe9SmZhUJmW8y9TQXNzPFSWUP2RZai+Xthe9tHyZy8pFVznQn7ak9KdnZZxWlyQ/LuI71TO5Kw0pBvXk52mCBTeWdzLjfF+uNJ73wGCO9UeC6BcVlCfCbuZWIFZF+gTKby1IsIogBi98gI/jFGA+dLidBXZppPMx2UI8CIipMziNpHXs7eS1bpKjo4vUB/cqMtOCntMVsvxj2VrOFt1/hvh06sCZOUD25boTwQaaVnSPtoReB+78VlaSXZoL1fP9c+yty0pRK9sj6O7uAbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1lBykR1S70um9eoT1HQsQXzGfQINdyw5V/Y/NoSkv0=;
 b=O2IsLvo+mDshS0MrkosM0xj0vZCgZ6zdQyLwaBWQ6lIoiU+STqfylT36rpS5nhQ/TP2Qu8CloA0e12nZgxwEDv31qm+Z8e9R2ttVM8RyY91LJeA2/pd7lAgwGChvdbVTo1ExxKD2v4xJB9AXlNtmHLNqjYmT4X4SnsMcpQGRnj8=
Received: from BL1PR13CA0016.namprd13.prod.outlook.com (2603:10b6:208:256::21)
 by DM4PR12MB7621.namprd12.prod.outlook.com (2603:10b6:8:10a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 06:04:03 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::70) by BL1PR13CA0016.outlook.office365.com
 (2603:10b6:208:256::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 06:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 9 Jul 2025 06:04:02 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 01:03:59 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, Meng Li <li.meng@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, Alex Deucher
 <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH V5 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
Date: Wed, 9 Jul 2025 14:03:40 +0800
Message-ID: <20250709060340.2365660-2-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709060340.2365660-1-li.meng@amd.com>
References: <20250709060340.2365660-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|DM4PR12MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 4475ebfb-fbd7-4838-091e-08ddbeae67b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YkfstFNdOy06/hypmOFs50LE6Rmn14oIhudUINDBM7qBwyMK+ceq8GOP47E2?=
 =?us-ascii?Q?EljpMMKuxetKMS4f8hmRCSFjWtYEVNhrd9rWGd3YZUAjCMsUUkfEA7WD/t3I?=
 =?us-ascii?Q?RkvPzkKiG8vVFhsavC7DealsXHdqaYUmU2I7VV7hWLdZyK7MzL1Ci75ZY12T?=
 =?us-ascii?Q?q3o4/hKUNZac3E4m5RpHGzNUF9/rPWc7JcunE2RdXW304I0RLUAO0kFKbVQh?=
 =?us-ascii?Q?cycZ5hWDTinbJlTymPK8jEtLfWVwHEhSSSxOP2xBjiY6O9E2XCqRxvdLS6bc?=
 =?us-ascii?Q?WKscspVUVZvpnkNIJYe8uDnlH51PQlvc51jfqWRnvz0CSTEZnHfh9wAUqkm0?=
 =?us-ascii?Q?6OAkGSLqXgZ1ykU15zH7nZfJt9+lSKyWegUCtz79Ij3AQ3IVCn7HIjcSmAhS?=
 =?us-ascii?Q?iNe3rpiuT85F3jWTN7U+8FiroxggvTEZh9GtlVSZyOOecIQt9QgMPMuzC5Eb?=
 =?us-ascii?Q?LlLZqcUK2aQE8nnSQ6lKmJs5wcDn2uQp81XAeG6i9KqALWwQIvGYdrDcP3ss?=
 =?us-ascii?Q?6treTnmX/mfSPyHtiaWq3qXikLW7EvYQxqbiAAC0ixAJz/WUZoGUpAUY6/0/?=
 =?us-ascii?Q?E74ntbmLaudkBtJ9YdvrC2ez2S7O+0Uhi89RF60nuEWrVJIEnkJj6B/G7pMo?=
 =?us-ascii?Q?3suRTy5Rgp7wsGt6cWReg8HSqvYzX+f8h6ByAXd4hA2DqtWx+6q55vg26rfw?=
 =?us-ascii?Q?5ojfWR2ZgfSj7SozyUxuRnTcJzJdYiMRTuGFytky0OvtBpqQC595Ch+5em+l?=
 =?us-ascii?Q?k47CL8Pr+pXu2v0e0so/VG+ul9yq5BQkYoAKRA2P95w8zr+ubTKPrErRmjku?=
 =?us-ascii?Q?pCRvjIjtd02WmVyL3MSMar5JnWR0WluSW1061mQkpTgs/vONjwo8K8YKwCQL?=
 =?us-ascii?Q?wXo/Q5HOTsYVfC58/7Ge35G/4dTDMJIykgVGZp5OsjFr0sdXZ3TYdxJD/nHS?=
 =?us-ascii?Q?TiEWPe9ZLRjjuj+UMXjsT8gAcIiMJPYVlXWt46dYaJtBvO2IUcJwhP+pO7Tz?=
 =?us-ascii?Q?6GxtgXzTA+x706CxfJNJGyfBktmgulQE9k2UWU9sjKWAq3NUMvEFeu7HTUXn?=
 =?us-ascii?Q?eXniLWW6nBJojPzGx1++nVcu+010lr05TAAl8kxb/RHNTAhi/LefIIE11Mqs?=
 =?us-ascii?Q?yxm16IBmW1XqJgOtlyM5WaMp0xDIPey6eWLXdaFsH4s8ZbKSvPdh6LXqa5/x?=
 =?us-ascii?Q?dXZ9ex1WRufMldgkiEz9lV5joOkAQ0wEMnboaofvmnsn1Mose2gZDw1XMO2Q?=
 =?us-ascii?Q?dUG3/cG1zKg4WevMRFD5KwILPudSFzbeBXHFyDFDGeTRUD6P0+YRzNMT1AfI?=
 =?us-ascii?Q?QM0QJTzGWNN4l6GAYyd2zdqf4QN7dwoLjIgCIr4mdafWCibpW0izA2f7ocuX?=
 =?us-ascii?Q?dYlXbxvKy8rgoVzWKTJfBEhorH7T0j5CvkiAvDHIO7fB8dqdJ9cR//9774hC?=
 =?us-ascii?Q?LSe2fQ4pOI7UnzILuotMkBmB2XEhHFMupBajCAIYKS7SDlN/CT0qW39FVHbD?=
 =?us-ascii?Q?syRwHhk47S+d7S3AwHhQua5ubfU3t9y+L+dt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 06:04:02.9681 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4475ebfb-fbd7-4838-091e-08ddbeae67b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7621
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

Add a new API amdgpu_xcp_drm_dev_free().
After unplug xcp device, need to release xcp drm memory etc.

Co-developed-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
Signed-off-by: Meng Li <li.meng@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 56 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index c8fcafeb6864..e5717c657fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -394,6 +394,7 @@ void amdgpu_xcp_dev_unplug(struct amdgpu_device *adev)
 		p_ddev->primary->dev = adev->xcp_mgr->xcp[i].pdev;
 		p_ddev->driver =  adev->xcp_mgr->xcp[i].driver;
 		p_ddev->vma_offset_manager = adev->xcp_mgr->xcp[i].vma_offset_manager;
+		amdgpu_xcp_drm_dev_free(p_ddev);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
index 8bc36f04b1b7..44009aa8216e 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -46,18 +46,29 @@ static const struct drm_driver amdgpu_xcp_driver = {
 
 static int8_t pdev_num;
 static struct xcp_device *xcp_dev[MAX_XCP_PLATFORM_DEVICE];
+static DEFINE_MUTEX(xcp_mutex);
 
 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 {
 	struct platform_device *pdev;
 	struct xcp_device *pxcp_dev;
 	char dev_name[20];
-	int ret;
+	int ret, i;
+
+	guard(mutex)(&xcp_mutex);
 
 	if (pdev_num >= MAX_XCP_PLATFORM_DEVICE)
 		return -ENODEV;
 
-	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", pdev_num);
+	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+		if (!xcp_dev[i])
+			break;
+	}
+
+	if (i >= MAX_XCP_PLATFORM_DEVICE)
+		return -ENODEV;
+
+	snprintf(dev_name, sizeof(dev_name), "amdgpu_xcp_%d", i);
 	pdev = platform_device_register_simple(dev_name, -1, NULL, 0);
 	if (IS_ERR(pdev))
 		return PTR_ERR(pdev);
@@ -73,8 +84,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 		goto out_devres;
 	}
 
-	xcp_dev[pdev_num] = pxcp_dev;
-	xcp_dev[pdev_num]->pdev = pdev;
+	xcp_dev[i] = pxcp_dev;
+	xcp_dev[i]->pdev = pdev;
 	*ddev = &pxcp_dev->drm;
 	pdev_num++;
 
@@ -89,16 +100,43 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 }
 EXPORT_SYMBOL(amdgpu_xcp_drm_dev_alloc);
 
-void amdgpu_xcp_drv_release(void)
+static void free_xcp_dev(int8_t index)
 {
-	for (--pdev_num; pdev_num >= 0; --pdev_num) {
-		struct platform_device *pdev = xcp_dev[pdev_num]->pdev;
+	if ((index < MAX_XCP_PLATFORM_DEVICE) && (xcp_dev[index])) {
+		struct platform_device *pdev = xcp_dev[index]->pdev;
 
 		devres_release_group(&pdev->dev, NULL);
 		platform_device_unregister(pdev);
-		xcp_dev[pdev_num] = NULL;
+
+		xcp_dev[index] = NULL;
+		pdev_num--;
+	}
+}
+
+void amdgpu_xcp_drm_dev_free(struct drm_device *ddev)
+{
+	int8_t i;
+
+	guard(mutex)(&xcp_mutex);
+
+	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+		if ((xcp_dev[i]) && (&xcp_dev[i]->drm == ddev)) {
+			free_xcp_dev(i);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL(amdgpu_xcp_drm_dev_free);
+
+void amdgpu_xcp_drv_release(void)
+{
+	int8_t i;
+
+	guard(mutex)(&xcp_mutex);
+
+	for (i = 0; pdev_num && i < MAX_XCP_PLATFORM_DEVICE; i++) {
+		free_xcp_dev(i);
 	}
-	pdev_num = 0;
 }
 EXPORT_SYMBOL(amdgpu_xcp_drv_release);
 
diff --git a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
index c1c4b679bf95..580a1602c8e3 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h
@@ -25,5 +25,6 @@
 #define _AMDGPU_XCP_DRV_H_
 
 int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev);
+void amdgpu_xcp_drm_dev_free(struct drm_device *ddev);
 void amdgpu_xcp_drv_release(void);
 #endif /* _AMDGPU_XCP_DRV_H_ */
-- 
2.43.0

