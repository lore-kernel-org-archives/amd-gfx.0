Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D7DC531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 02:55:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A9710F27A;
	Fri, 24 Jul 2026 02:55:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J+iyXTl7";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1655510F27A
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 02:55:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=psCTE27ZHGm4bTaWHI2hr8NYGjUYTNZtGSWPdRu2c/hBEjlujJQJfz+CRZtQCEKLlZ6ieLjbPut7312EZNZyKYIOCiCeXvESpgn1J1pdE6046QP9ivmP4Bz67uynDBH1BL4DZqYDOjj0r1wFoKua5nx0UxBPzcyDnE1eZXaGYllG2YYvgBChDo18ftN3mhvH0Hi1fbv1lA1UIfyNAWxtqyAQsdH54jv8XdZZnxL9lgxCrdxkU4hMFwRZoVF1Q9e4X1xbo7S7Q2tetxOQpnimP5srxHVjJHtYlrdATYhWwPHmtPCP4lTN0htkgykubld32oMXU/9xt4N+R3KBZzdtlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sriTKcP5eBRIpCsErbQ+hx0nk/dEJt9cok+r7XwaFm4=;
 b=L9JzOwB7x8RTt7xTS06P6bhFMeis2nadrU5VDokRru/b9pSuF+x2m1Kaq5ipBIadjL2SAcO9eD9j/oDio2T4FY00yvvKoC2xxv/yt17L64G/MyBLAAVKVJ89H+XjzVOuYcUkA7CsLP3SLTZdqbdtbHFZYNrY0VPOAFIplk/dTWJ5di4qXGL0LE95ZVkFcOqmdf3macLMnIhfFpbylqAh22lH9vPmmPV26mvApSpfQvTIilLKNazNEyl3WK+wvBNejZB0qzUrj4DlhbQ7URNzNuZgXoCuGart0bx8lefAU2H6yMf8pu5s6CeafMMUcVHEDa9qqu0THM+3DiOmmpeJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sriTKcP5eBRIpCsErbQ+hx0nk/dEJt9cok+r7XwaFm4=;
 b=J+iyXTl7+l4EqGkBZG/zoqd5d3yzZsZJmSgBUvKJuO+u1TKrtipPIJXsaV8V63oTjQOttUm1bwXvlqlC++fQ7zAXW9bHuGXLRtjkFeXk5pvIn6HQubRkFaEzP6jIiSUccWVgrXlN+tRI5hwjCLQlIg3hsPubJFRLCoQek0b+dck=
Received: from MN0PR04CA0013.namprd04.prod.outlook.com (2603:10b6:208:52d::18)
 by PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:55:39 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::78) by MN0PR04CA0013.outlook.office365.com
 (2603:10b6:208:52d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 02:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 02:55:38 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 21:55:37 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: fix torn gpu metrics reads
Date: Fri, 24 Jul 2026 10:55:22 +0800
Message-ID: <20260724025522.800587-2-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724025522.800587-1-kevinyang.wang@amd.com>
References: <20260724025522.800587-1-kevinyang.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: b77eba71-d0ee-4fef-9c65-08dee92f0acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TOe2Dsvr19Dt7jmRv7Oax9aqJ+6o1NlHM2nMyQtTed//joML6ry8Q5hMixLj7WCKbLhLp6jERE2rkcSDlhMRqKErobW0yI+uNLsuzZmqe0jQty8KEi4FCLK55wVPBJsxy0AcLeSM70Llw2KlhOVcL1vZWmrjMs2GCCFmikTmf++HAm4KEomtCWKtBQqkFnwm27UPOqrSt01MKHPrSsrYPJetruhKcij87n/ET6s9IhU0oDl1h8tdgvBU5pYr1OuatcUflbnYNJVYQ0YthqaEBt4AqSnk1esbuafLWwQCULGLX0DYR4Nu7NMd0le63teZFi4E0CYw+JqJQxXnMHY0e3pDtdklXAgwuIoPJZ6babILuijxdvCBxU3gTtK5OxLcUwf75LjMU6iqk/qzwYTm41L/G6A2GYHrEKXi4ph5vN1J+mwRD7s68ALGdWEYxkZS3JhbXtFA/+IYNeeQXDWfAIKy+hv4PCy7P5FtYkPy5caNWov41EM7nQx7UuNPlP1FYdwk3B0AFqOmhNW70+KJR2sNSV1yOUY7HIKM2mxJhJdCWdHaWU4W7Se1GNwMnwuk95L+oBwkGhnI7tQVnbjwkcUoa9u7Qa/7/rpO/QfYZRno25n7GnjPoIpSLWyzfEYwVUWPSRW4Gb8bbIP4F+7onJp3fDnpa9P+EGp9xkY6szFpIXoC8tEqnY48uccIGdq4TXENAi4UZwsPVuUJg5zIKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xEiTW0jBM7TFVnCxFKLeHYJdDGvlzwQ4ijMx/TxV1Kvb9BWFW5D38r8msLkE2lN86Khk2VF6LGzFef0aZubvtLPX8djAboqHFj5pU9/7//5UR6Yj9X6+QDDAO2iZMRrMyjXYEb9iXcHDHwOuRJxZv85tiCy91fuVJI61XiOqw/H+vHt46WQ5zTnY8FPJlsLAHGQ1FuTyBmRHXfnIgE2S76jwgn5sFe7Ydqss1K0eNddlUgbu3ySOYgljBnQLTZSOQotzGCirRFTiGV7yhwyY5hs1DyyoIGqK57cYdZ17HVByvkBquapIiVLxjuL4XPJF/DEdUjP9dAgW+V98W0u4WghRvRDBYNvDWspyF7cM+tVfWhzMMd/7tZm0Qc1O+bNVxmqvMeYxzvoh3waRxp6iULhZ95twfTAx1Lx9q9F3Zsk2GsNfVJLuxuPHRJNIyGz1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:55:38.6611 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b77eba71-d0ee-4fef-9c65-08dee92f0acb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356
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

amdgpu_dpm_get_gpu_metrics() returns a pointer to the shared metrics cache
after dropping adev->pm.mutex. The sysfs path then copies from that pointer.
Another reader can refresh the cache in place during the copy and return a
snapshot containing data from two generations.

Pass caller-provided storage through the DPM interface and copy the metrics
while the mutex is held. This keeps the cache pointer private and makes each
sysfs read observe one complete sample.

Fixes: 25c933b1c4fc ("drm/amd/powerplay: add new sysfs interface for retrieving gpu metrics(V2)")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 12 +++++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      |  8 +-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  3 ++-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index df863a451f26..8f59ea12fe0e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1434,17 +1434,23 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
+ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
+				   size_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
+	void *table;
+	ssize_t ret;
 
 	if (!pp_funcs->get_gpu_metrics)
 		return 0;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
-					table);
+					&table);
+	if (ret > 0) {
+		ret = min_t(ssize_t, ret, size);
+		memcpy(buf, table, ret);
+	}
 	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index d473976ddae5..e4fc33e3c951 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1781,7 +1781,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	void *gpu_metrics;
 	ssize_t size = 0;
 	int ret;
 
@@ -1789,15 +1788,10 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	if (ret)
 		return ret;
 
-	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
+	size = amdgpu_dpm_get_gpu_metrics(adev, buf, PAGE_SIZE - 1);
 	if (size <= 0)
 		goto out;
 
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
-
-	memcpy(buf, gpu_metrics, size);
-
 out:
 	amdgpu_pm_put_access(adev);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index a1d1c9f5b1d4..8e8a052e1d53 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -518,7 +518,8 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 				      char *buf);
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size);
-int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
+				   size_t size);
 ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 				   void *table);
 ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,
-- 
2.47.3

