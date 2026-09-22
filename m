Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03830C982FF
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 09:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A47F10EBD5;
	Tue, 22 Sep 2026 09:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L/RMJOCU";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F026E10E6AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 09:34:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kk5rv4r9F2thmuw2zbcVR7jj4LRPbvFztc1UdfKolpSVJxFludT+Oy6qFI0Z41H/neJ7hz1aGgrdEwE80q+DkvJyDAOdV/NsqE/nlFOxTTu5W5g1ctIdFvd88si/INhgBkeHn/b3wDLCs5UTVpJIhTjCqbSoDEDdKlVfGonFUkwI5hFpsyEND+JYcqp6qZf3Jcx2xcsWRTH0L3LhXq4OFkMr9IL2YAc+71a8nDUq8ytOYfF7eiyO0+p1VPBGWlzfgo9H82FFWfoDdC100rtQqwAUCXRiO0oNtCM/OMNst7USG7jPnrE5TP3RivRdTkR+3mkxGsMurR27exIZppjcHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gD6Sn75pi8rcUCzTj+DOfnqjr+4oSl/nePLuFOJTuY=;
 b=oT7/Doc38QZIWfVozP3+9kjVhPpRywt6QU6+4jghsKQNi4mcKD8ecgZm5WRSmsUwxi9dOzvGk0bkmUgKf7lkVD7dd1974cl2W6yI4tTF46UeTw0z0T1yZQn/k9ofgK0gdlmb8mcD0UXfhZcJS3kLynN/q/loeovXDtDLP0cCS7GJbbpF04lm4BS2asvQVk0meIT8b4UnoT8sI0/khlzHfq/51K8QgTVh4AkBwIMq+fFsHB6yk3sZ5e8OuDF/bl2JvAWODxOy63u67qaLSpZlFlIPmdxMus/vWM764Ycw7T+rGRWEvIok0PtKqrqv3KyOC1kxMoUODAHFGCy3n9Iwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gD6Sn75pi8rcUCzTj+DOfnqjr+4oSl/nePLuFOJTuY=;
 b=L/RMJOCUWqtXLHX1ahDJky+LnS0G0WDDa6f8sm+jBIiE6spZvU+d9eTfDMEzXlR+cpMS79iHCqI0cFg7ocDxLxIyksKZcYNvCG2x2lSyOKHDHU/O5dnu0oxYe64JzcZ+/9FDlX1sv1FgpMQr/XsaThyUz7JZ/aD21cfsChzLG+8=
Received: from BN0PR10CA0019.namprd10.prod.outlook.com (2603:10b6:408:143::8)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Tue, 22 Sep
 2026 09:34:16 +0000
Received: from BN7PEPF00000090.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::6f) by BN0PR10CA0019.outlook.office365.com
 (2603:10b6:408:143::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 09:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF00000090.mail.protection.outlook.com (10.167.245.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:34:16 +0000
Received: from ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 04:34:14 -0500
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Alexander.Deucher@amd.com>, <felix.kuehling@amd.com>
CC: <Ray.Huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [RFC 04/10] drm/amdgpu: implement reservation mechanism for PMC
Date: Tue, 22 Sep 2026 17:34:30 +0800
Message-ID: <20260922093436.596947-5-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922093436.596947-1-lingshan.zhu@amd.com>
References: <20260922093436.596947-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF00000090:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 14feb2d0-c4b9-4e78-7997-08df188cabac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7hW7OzzjiRKV++pmsI21jHUSxYU9e2XNrukr3KGiRaUO8w5VUtduutX+5HeVnR+9RWUK+k5KsjMX5T98GZwuh8XFQCoffdX4DFQxCWr5EpG/seoBD6eS1DqvOBz+4C81+aLlTbH0tYBu0Md3g4F7gYgQ3yLxCxEAGSYPfCB+XqRMl4rpO7daSXdPNOaSzwBcuoh4UUqj50POGFLKYOsvMkNLo7bdj0nv859naFz1zoN48gIpqVtdgOGSzz3SzpKFiBsuuc/5mmDrxWdf9oZImy3o8su6X5xZW11SuoXQ3iBm7fGmzTS5x2fTak08snRRX3n/2gph0mWUGGEBcQ1iHJA6luL1vPrxLi9b54yBlE9IeC/4uOefJ3sh84XP9SEWWQfcN5W46Jinlh94W3zO8QheJPjqxfIvreGTSuDmxdRPrFlMQPm2wRibGR9NZl2iZGasQ0HJKusG+P56uO6s5ozYWBYe+zYRd4R54d/FPdVUNaSqbM5aR/0V0egCwdEM6NauhHZMxD1PfW3axkyYHkvusEImwLMCTW5hq49v+ugyawo+SN0Mw1CTQVMCKsFUSdpeVyUY+eiI/nYV8SH/MBy1gBYEcFhlxSY0G5nJ1QytZc60d4g61VvJORO/AS+pBCaEeMEcEqTxuikPV2qLX8ZJIzjO4FY1MfXV6ZRypTfkJq5u0pxGNeTD0VNG4oBF/i2RSIGTkQJe9YNlGwlRPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5voPlfwU+EuxvrVvUn2+7hrsIr9XwA7kbXKmwDNOfrXId8QGWflUpBdPHsfv9kFl9lZxoLRbu4r7s5OHf4QojEoxVX8mpiwboc+f/apToaJErFv6cwIuPPu2gPZE4DPDmmPNVR9jO3docciSvqA7siYaO9MkHt//lvtrFw1ib1M04IHfSz9lAdwDwgj7Sxbl3IUSAckYLBrKwJP31WPhZPCwux4HRrL8O9+QTSg3joezH7gdfmazOch4GwlcTBiqd+mAZtxmLrZzzyQlS9tHQ8mQiUh0U3CVEkneJARaoc5N3kc0W++73/GtJKn4C2xTGGiYUq4WCwUnP5nRQ/oHTtKRFEbxdKHP7IEUgdTj6RMt9+CK1Ra3R29ucm2ok3E6rEItt/vTeFYcGb76b+k6Zr+H5AoOMGBakl/Ip7xIFYYruOaO/3d6CxrEZ2vtvHoh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:34:16.4192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14feb2d0-c4b9-4e78-7997-08df188cabac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF00000090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325
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

This commit implements reserving (take the profiling ownership)
and releasing (release the profiling ownership) of PMC.

A reservation can also be cleared by AMDGPU_PROFILER_CLEAR_RESERVATION
in case the owner can no longer release it, e.g., it crashes.

Releasing is separated from reserving path by design,
because the ownership needs to be kept during set_perfcount
to avoid racings.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c | 73 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h |  3 +
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a98c4a47e196..3dc563a64639 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2988,6 +2988,7 @@ static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 		amdgpu_evf_mgr_flush_suspend(&fpriv->evf_mgr);
 		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 		amdgpu_evf_mgr_fini(&fpriv->evf_mgr);
+		amdgpu_profiler_release_device(drm_to_adev(dev), file_priv);
 		drm_dev_exit(idx);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
index feff37279575..6464af0d1b10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.c
@@ -29,6 +29,54 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_profiler.h"
 
+static int amdgpu_profiler_reserve_device(struct amdgpu_device *adev,
+					  struct drm_file *filp)
+{
+	int ret;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (!adev->pmc_profiler.owner) {
+		adev->pmc_profiler.owner = filp;
+		ret = 0;
+	} else if (adev->pmc_profiler.owner == filp)
+		ret = -EALREADY;
+	else
+		ret = -EPERM;
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
+int amdgpu_profiler_release_device(struct amdgpu_device *adev,
+				   struct drm_file *filp)
+{
+	int ret;
+
+	mutex_lock(&adev->pmc_profiler.lock);
+
+	if (adev->pmc_profiler.owner == filp) {
+		adev->pmc_profiler.owner = NULL;
+		ret = 0;
+	} else
+		ret = -EPERM;
+
+	mutex_unlock(&adev->pmc_profiler.lock);
+
+	return ret;
+}
+
+/* Clear the reservation in case the owner that can no longer release
+ * the device, this function does not take the reserveion, nor touch the PMC state.
+ */
+static void amdgpu_profiler_clear_reservation(struct amdgpu_device *adev)
+{
+	mutex_lock(&adev->pmc_profiler.lock);
+	adev->pmc_profiler.owner = NULL;
+	mutex_unlock(&adev->pmc_profiler.lock);
+}
+
 static int amdgpu_profiler_check_access(struct drm_device *dev)
 {
 	if (!perfmon_capable())
@@ -40,6 +88,29 @@ static int amdgpu_profiler_check_access(struct drm_device *dev)
 	return 0;
 }
 
+static int amdgpu_profiler_reserve(struct drm_device *dev, struct drm_file *filp,
+				   u8 reserve)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int ret;
+
+	ret = amdgpu_profiler_check_access(dev);
+	if (ret)
+		return ret;
+
+	switch (reserve) {
+	case AMDGPU_PROFILER_RELEASE:
+		return amdgpu_profiler_release_device(adev, filp);
+	case AMDGPU_PROFILER_RESERVE:
+		return amdgpu_profiler_reserve_device(adev, filp);
+	case AMDGPU_PROFILER_CLEAR_RESERVATION:
+		amdgpu_profiler_clear_reservation(adev);
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int amdgpu_profiler_pmc(struct drm_device *dev, struct drm_file *filp,
 			       bool enable)
 {
@@ -61,7 +132,7 @@ int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *f
 		args->version = AMDGPU_PROFILER_VERSION_NUM;
 		return 0;
 	case AMDGPU_PROFILER_OP_RESERVE:
-		return -EOPNOTSUPP;
+		return amdgpu_profiler_reserve(dev, filp, args->reserve);
 	case AMDGPU_PROFILER_OP_PMC:
 		return amdgpu_profiler_pmc(dev, filp, args->perfcount_enable);
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
index c27b5f9b3ff0..048ce84f0ef2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_profiler.h
@@ -28,6 +28,9 @@
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
 
+struct amdgpu_device;
+
+int amdgpu_profiler_release_device(struct amdgpu_device *adev, struct drm_file *filp);
 int amdgpu_profiler_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
 
 #endif /* __AMDGPU_PROFILER_H__ */
-- 
2.55.0

