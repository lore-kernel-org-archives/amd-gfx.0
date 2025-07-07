Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A3C83F0A
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jul 2025 07:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6581710E422;
	Mon,  7 Jul 2025 07:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="avb+YsDS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD43E10E422
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jul 2025 07:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0/R7H6dSQQ80UNpO2VZCUL6FYjcbpXySXPXaFYFzcT9QvC0HvT7tv9fV0G3HWznCzydYD5LlfXREcH085T3HsBuL/xUCnaH35uIrWoPkRNevly+Hj8CrGhwbDGl7078gWG7/AuPqg52G/NoCzjw4LaGDiVpvsqdXqiSrHrLgDm3H9kRzNA8ZgmGLv376BPkn1/c4gg0VvJvwTVSuTZLplj5eiLDv5aO6Iv/dEosnfFDr58C7EBnFywSjMB6pBfuFIMxtjqJrENws6pYNt1Tdwp8XzbkM0ujcKy1/wNz5LfeZ90/BptkEv7Us+YHBN08l8dRvCP1aRHfmiLRuzc0CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xD6f3q5zBhUjfOkRRUHkHt/p3F6bfoBKCypZi2eklw=;
 b=xWIJPbsKlTSdrVrpIebgRIgv+SOV78zigJM1l4ufhmK9z3SzPQK7v5fqrmQG8235EFY+zlS2+bAsEUZYjcG0vO6tD38/ZqGw0Y4s6BdqPTrxzrYsn46c2bTc4KHdITLs7SI2SmkXIKd8fUXp6psZIasmlXWlMUoN3RGv7ybFRkdmWTNuFNkn9N9dPnr4XhIVfI83meTq05l7FE/OUBusBWhHMduF2abtkQoW9KXv6I/lRRuTWCl6OT7I80yiHuDkcxeA1/wHDLd7XmGi+L99ppge9U3TsrB9s6tcGSgGIzfxQ1nCbvrIZKIozgc5Ecl+x1ApPKk7my1EpjHFaCXM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xD6f3q5zBhUjfOkRRUHkHt/p3F6bfoBKCypZi2eklw=;
 b=avb+YsDSpToQcNgb4MT2TO97K8ktbE8kN77Swk3ovG8FhUfMHfI69sFGByLRfQs+MRRMBuYFRADjXUS67sWxAYv6EGZzwj8aujtqPrn6lTZG7Tn7fbgBeO/YGGMdKElq8j0bvxHSmlBnuD02XTXNzmRErupwkg8HTeJeXMJMSTw=
Received: from CH0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:76::9)
 by SJ5PPF665EE4E73.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::996) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Mon, 7 Jul
 2025 07:08:30 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::61) by CH0PR04CA0004.outlook.office365.com
 (2603:10b6:610:76::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 07:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 7 Jul 2025 07:08:29 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 02:08:27 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, Meng Li <li.meng@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>, Alex Deucher
 <alexander.deucher@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH V4 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
Date: Mon, 7 Jul 2025 15:08:07 +0800
Message-ID: <20250707070807.2034235-2-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707070807.2034235-1-li.meng@amd.com>
References: <20250707070807.2034235-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SJ5PPF665EE4E73:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a1d455-938b-42dc-9644-08ddbd2513bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6Vs8V6n6wi6O6I0U5f3ox8a3d3XXEjde45YdRETRJZykJcEdM8m+jo89nkuN?=
 =?us-ascii?Q?gryCu8acwdtdhOOoH/r67RW0fIoHCb98AGap4g61MG8niFEY25G7lor90lUK?=
 =?us-ascii?Q?1oxsQfJPsGp2nJ4cTQdrWnzSDzgu/PIxLZ/3G+ywTYXbDmsVyKBcCJGGTfHy?=
 =?us-ascii?Q?cNH0ZEuEsWWAGpIz4/pYo4BPx3fJCiiZyF26yTweTmAFumuVhuGYtSfEBMCb?=
 =?us-ascii?Q?HJlmaGr5cHCnRts9lmhMxlHU85LvcQmqTlLrNFSB57LzVi5Zg5vwl+9JdEeI?=
 =?us-ascii?Q?qpBjYiAGnQJHDBbqFHojA7s/bLuVQRMUSZq5mqqheOAFoc19blTlT2V0SY9R?=
 =?us-ascii?Q?/YYXZzm5ZheXMc6fAhRbW8Kz0Fy3+FmoZ3D+xWOFES9byWWzwAi42H9MZAaq?=
 =?us-ascii?Q?vXfR/WNHjC8ffQNz8OwWM/SPHMF21Q3e+pOum2ZUktvumEg/RkQTUT9VtZ/j?=
 =?us-ascii?Q?3TIFuKQIH8AJDp/2mwzxgTY21L5t1Bikr8aKTtmpqavsM25x+gtB4TDbQ3dn?=
 =?us-ascii?Q?pZqk7yh8KzGbdvTNG+wtTy/l9G4puJHzaxc5iwNMTX2q0BfkVem0moPYT/qh?=
 =?us-ascii?Q?3WZxqkGhMJVvO4TtGxgro8MsmziF+EpKLSYWS4i1sjgq+NMfCTYtVKZzdEnc?=
 =?us-ascii?Q?CQBZAiGje3qt37sOzdGl4uyp4fmNZIacufw9wnrFlNgqqmwsDvHgCulhlYIL?=
 =?us-ascii?Q?bhJtcxv+fmojsJZcyKzPVzZtHXmQcxbL/tcIgRKaMCKaas//zvGzkAZsOcpi?=
 =?us-ascii?Q?Th6m46OYCEBXmEG7cOzwoMq7ywE3aZnjxvKOwp38BZ1s0ZT1f4S79kUe1r9f?=
 =?us-ascii?Q?afwoYpIIF0SttweW7lQZV19Qp6+6K2QtphP0hljElKqMoiHRPMBYvRdQlusq?=
 =?us-ascii?Q?k/HV1aRSQ3EWHCN4/KTygeP0Pve8eCRDeVQmgO9PM4d73DYTUUnIDTLJ7jWr?=
 =?us-ascii?Q?2f4tQzrstBF73XvD3EhvX0I6jTrAvW97pRFowvTaIjuJ3NwDP+fqTA/2zxe+?=
 =?us-ascii?Q?8fEy1Z6SHo48OefEJQN7usuMgjvCfWXXbgyTTJfLACVYGJgrl4rZNGVXlPCN?=
 =?us-ascii?Q?zBZLrryk4qFfJWbXV7BHvCqH53uyHbELe9hpqKvQniyv/eLuVxpofE8hsnZQ?=
 =?us-ascii?Q?CrQ22EDWPGDJJHIdlXXPEEFYWstfNknSaS8+NzHsQ7UaSiieyuSt3FP5vWYb?=
 =?us-ascii?Q?zJVtXRl1GC9UPhT3VkeYV56dR8cBDFaqekL+KX/y+dnhbyWwXqyyyPEl8X4e?=
 =?us-ascii?Q?NSPNZGdMVKquXzAJaBl9KBg18/oPXG0kky4OJXmEGtMy5kXqW3anWJwtPFUF?=
 =?us-ascii?Q?n8C1+whwHwYnOd1PilTgwKo+vPkHFW2UfeoTmqIrcK2usvL/RiCmwsTgjnZC?=
 =?us-ascii?Q?I9HB4J7eSOdWAbRXWguhe4vrCm1tqLKIWUH3iRBEfkkU0EfQeloeeTNdvhlY?=
 =?us-ascii?Q?5rme6iRbXunOHI2tXKX4aO5YzeMIhFXBRF0Ov7e6nNg0Gkm1m0h6tEJo5swQ?=
 =?us-ascii?Q?60FySuziFV5peYi0B4DA9QWO9V9fyrCrndy5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 07:08:29.8504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a1d455-938b-42dc-9644-08ddbd2513bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF665EE4E73
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
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 58 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 51 insertions(+), 9 deletions(-)

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
index 8bc36f04b1b7..447f46c29015 100644
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
 
@@ -89,16 +100,45 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
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
+		if (pdev_num == 0)
+			break;
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

