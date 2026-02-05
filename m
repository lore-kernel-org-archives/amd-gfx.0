Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38494E9126C
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Feb 2026 06:52:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1A8C10E7CA;
	Thu,  5 Feb 2026 06:52:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m+pRu9EH";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A15910E7C9
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Feb 2026 06:52:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9hDA5GcZBOSOjiABMNMwvbQildQvBgoHl7r2nwgu4SIMMslDfBgAKRc1dELQHz0G3vhcJPlswmMGALFBtxe7pL681wIVRG43rRnfghOOgfQRFgNN7ul/TGsUeCsJA427HNHkY6ho0bj97qRMCaXqeiPQCns5i4BPC3pUE+aO/gXT9SGQYFBGIdL+9/rcievhCHFTQxgum3t1/lD0dR3Z5O15nbV3N1xm3PUzWQEHyqciXpAEFb8K3XmPjNyxGpJC3+WMTWYBEFrqTMolzCrWl3UbZKdzq6hYi8+HJ2dMj+RnpaxtNhbxRgsCfqBqJbZOrvannjw19Oe5wMZyiUQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QYoGRx4vOnrM2kHCTJP9P6yuY/v7TBAlZC0ONgoahR8=;
 b=Qlta2At3ickD3XAjhQD1tK0A8GLeAHrL0MjzesI6swnETmZAzmBCslOQOWoQwVkRcGpDyhxl4zkaNEcARjEiJEOLvcBVG+pDOFYCthFo2cgUSbK+qFZAZNN8JyxVzifS3RyQdQmw8mn7gXPAuWbx+ekcuNtb4BzbjIMfwj9bc3jLGfBLTNAhBOD8jvVqlfeXGZwoyMQaZjOk70MumkQmaHOdeUVSPkGiBDavEZqgro0yA0JvEYxCHahpbiQOMrQWZv5VgsmjJBWFypr3TUXyABRZ3YnROu79Cj9RQjlOy0FC4Gfyt5XUnAPu4YYFCuLEk3lKjrSGjJOJXnCYiypCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYoGRx4vOnrM2kHCTJP9P6yuY/v7TBAlZC0ONgoahR8=;
 b=m+pRu9EHc/WTHJnVZpBIUfgZNXC8CblclSlUuP4SDpoq1/p4qnGlNoYxVEirC5XXJFs8MjP+7qNOjLePfEz03dDSGjy63P8oX35w9b7C7T14aRDmAtlgTXkbnGJsBlKtUeFX6wNxJJ+oPpKZt17YGss7mlhyybzIVM3oHAloCo8=
Received: from PH7P221CA0047.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::19)
 by DS0PR12MB6581.namprd12.prod.outlook.com (2603:10b6:8:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 06:52:11 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:33c:cafe::6c) by PH7P221CA0047.outlook.office365.com
 (2603:10b6:510:33c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Thu,
 5 Feb 2026 06:52:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 06:52:11 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 5 Feb 2026 00:52:06 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <alexander.deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <yifan1.zhang@amd.com>, <perry.yuan@amd.com>
Subject: [PATCH 19/22] drm/amdgpu: Track PTL disable requests by source
Date: Thu, 5 Feb 2026 14:51:27 +0800
Message-ID: <20260205065130.654921-19-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260205065130.654921-1-perry.yuan@amd.com>
References: <20260205065130.654921-1-perry.yuan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|DS0PR12MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a63dec6-e0e4-47f9-b1c5-08de6483166b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gr6uvaFP9eVlykMhZNIu406oZba5o+LsKCMtpzuC6EPxGkxOYyjXGqeylXVy?=
 =?us-ascii?Q?mHQT2XKi5QTuz2XputNs7QnYOQnoR2NdyTxoemVpfC+7TS5B8Bi/UlPst7eA?=
 =?us-ascii?Q?VGbkqdAto6V8dIhW3e9cWyi3yE8zRiKBqQZqIYBaAZtTWloQmZTsKI5Z/krJ?=
 =?us-ascii?Q?mfrv79i3cHOVijkqCC7Yb+5uOOhLbAhSxS+k0qei0KcNHeIH0vkArfizCtlL?=
 =?us-ascii?Q?UCFfAGO1qqM8Wmi9SBAbLgWubB694I4f4R1SiCZR4+bGRL3pEmSrLP0uXi0U?=
 =?us-ascii?Q?jWZP68bPaES2BFbUdY8LxFsiZKxrBSNpkp7cp3M9utuUUCsqWVYkRTyB9xpX?=
 =?us-ascii?Q?J+JDXm/I089QwYktghuynDmARdcHvesrlVc3LUKGIDDgU42XprO51yPSetAD?=
 =?us-ascii?Q?E0MDZUA8rvGW02O9q3weW8awde8rz8SAdcqzEV/kRef/9lBn1ZswYdCr21mw?=
 =?us-ascii?Q?KCgL02kbo3dGszeYrlsxQrFU0QToSbtqqWY1jp/xeQ7dvqQIB9ZrjldF3hRp?=
 =?us-ascii?Q?6ajBPA8xmrr7+n4qkPZGUirrcosmlzlVM0KIZkA0FMspPUyLyBdxB0sKoe5i?=
 =?us-ascii?Q?FcBYZRZm+rP+bFlQAEeRgya9nKVmVK4+VKnutC4va+zGR6GlIfg5UI5aQR9k?=
 =?us-ascii?Q?fSKcj75QccNs23DbZ6JzDdQ12UJGOjc0JKxGEHQm4LgTZtlP+m/LB5IuBWoT?=
 =?us-ascii?Q?9cxWaqAmFu2ipFZ0yBkR5uyyohLNbRzr7XFncNdfdQLG9In+3DwLQ2D01Ne9?=
 =?us-ascii?Q?8YMPOuxj2dtJYyJCuIX9KUXPRjpuJnoHvGAB87IcjvDOTigeVdjCAD+y2bzc?=
 =?us-ascii?Q?e1LrH2m+oZ1OQib68y1CkGWwhi4OdPjSxRyBIQZhbm4sZBDaLqTP+gIPrynh?=
 =?us-ascii?Q?KxQDyu0MHZ878ZWvpeLQNmLXQ46Y57I8L/5TEELaTh8KCNKYwdkebQQvHuwK?=
 =?us-ascii?Q?JyBZBhKtp1vUb9PQZ9kJzoB0zR5MoAJRZpDq/FbYKra51zWMfb8Y7t8QoNjo?=
 =?us-ascii?Q?Y3mwqm53fo3m4g3+oP+ZB6foCM2Lu3JcsB8DAdMlO1WR1A7iQxbs7oyWDZrh?=
 =?us-ascii?Q?3oEwFIkKq9RLDMx1ILzun1CiFFsO5hGdabDpIV5X5GN1Qg42cawZPTVoCVCY?=
 =?us-ascii?Q?gdBPE0ayo+xddOG1SiZY8rttyUOD+OzneFBjyKQ0DtCkR67wYDBoawuJRpCh?=
 =?us-ascii?Q?ZAmCoUb0ZCUEF0X4TtF0jF2GEfYXgwuAxo27p6ohej/izI2+g66ACc5zC8K4?=
 =?us-ascii?Q?mflcb41orKg9d1Dcd8HwUpNZZ5q+0zLOiHYS+3nYTO59O6/ATNqhO9CVZ/oV?=
 =?us-ascii?Q?XEqCOFEx4sfkWJvqdQ0bRWK/14ZAFqxSei0aD+jgrCMCP9GuoA3xodri39Iv?=
 =?us-ascii?Q?E0T0VXwmfqlYVOPn0ywuyfMYTYJLBM9KT0hKH1RMMPOLkFn8J+dSmmey7f8N?=
 =?us-ascii?Q?AqCcBtSwXpzYw/3hKgAkaQ2ElJDRbDe6zjvuRRbcYL1ieKIPGyTm+uHKhFUh?=
 =?us-ascii?Q?ivnpYlvUYV+1UagvE2umgs7n/T6qlRoGJVk8us+O1SIwVjGf+QLqEV/v1OLz?=
 =?us-ascii?Q?Y6LsQLKhRnmIRm1ZC011F6S/mbx5lamtFY20znqH1W7vzMYpC1gMCdVhO8yp?=
 =?us-ascii?Q?U9nejEePmqnVFT+QsDDujob505GbQgHoxk63zkJq16PqQmoGmfxnRlQZY7hx?=
 =?us-ascii?Q?WwrEKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: p0QTBP4MMXkjeo7MhylhOyupea0uwl5p3DzlXGxmCJro+fNMHeyABhx0t3pgR6qC8ufgrUB5eRMUYFRrvuVOiZDKFOKT19bZ9KCq2+8kAvByiIdF/3chFqHmExrx3dePEPFIhWO3ap2LjvXqMM9xrS2nlkod6QiqQ70oc2WKE2GHsrsfR6qI95JSy0j2Hdt4Ipl9kiIK00zdGC+9Q/nbkJ1pStVmNQOJwBRoBgYObNo+yaVG5Mh2+A5oNuBOiEmHbR6EKnRLJLefXBkUl8oMrJ89kkOFLcDGSQd+6NkxK7V08aKElX0CWh3RnPUQYbnCuWyNQUOuFX+KKxcky78Lw+5ommZybwh3qPSbtj+4y02p/YsN2zHWbH1ejJr4WFz8gyO9im4IbBo53DJaY1h3zSmlMZFrbZ7UvnbMw9gXnxg+xWkWV5qUIovwssAlmiuZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 06:52:11.1966 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a63dec6-e0e4-47f9-b1c5-08de6483166b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6581
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

Use a bitmap to track PTL disable requests from sysfs and profiler.
PTL is only re-enabled once all sources have released their disable
requests, avoiding premature enablement.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c  | 32 +++++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h  |  8 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  4 +++
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 95af5f1d8f5b..3d7c1a788cf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1314,6 +1314,21 @@ int amdgpu_ptl_perf_monitor_ctrl(struct amdgpu_device *adev, u32 req_code,
 			ptl->fmt2 == ptl_fmt2)
 		return 0;
 
+	/* If enabling PTL, check disable bitmap */
+	if (req_code == PSP_PTL_PERF_MON_SET && *ptl_state == 1) {
+		if (!bitmap_empty(ptl->disable_bitmap,
+					AMDGPU_PTL_DISABLE_MAX)) {
+			dev_dbg(adev->dev,
+					"PTL enable blocked: SYSFS=%d, PROFILER=%d (ref=%d)\n",
+					test_bit(AMDGPU_PTL_DISABLE_SYSFS,
+						ptl->disable_bitmap),
+					test_bit(AMDGPU_PTL_DISABLE_PROFILER,
+						ptl->disable_bitmap),
+					atomic_read(&ptl->disable_ref));
+			return 0;
+		}
+	}
+
 	return psp_ptl_invoke(psp, req_code, ptl_state, &ptl_fmt1, &ptl_fmt2);
 }
 
@@ -1351,9 +1366,10 @@ static ssize_t ptl_enable_store(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	struct psp_context *psp = &adev->psp;
 	struct amdgpu_ptl *ptl = &adev->psp.ptl;
-	bool enable, cur_enabled;
 	uint32_t ptl_state, fmt1, fmt2;
 	int ret;
+	bool enable;
+	bool bit_changed = false;
 
 	mutex_lock(&ptl->mutex);
 	if (sysfs_streq(buf, "enabled") || sysfs_streq(buf, "1")) {
@@ -1369,18 +1385,22 @@ static ssize_t ptl_enable_store(struct device *dev,
 	fmt2 = ptl->fmt2;
 	ptl_state = enable ? 1 : 0;
 
-	cur_enabled = READ_ONCE(psp->enabled);
-	if (cur_enabled == enable) {
-		mutex_unlock(&psp->mutex);
-		return count;
-	}
+	if (enable)
+		bit_changed = test_and_clear_bit(AMDGPU_PTL_DISABLE_SYSFS,
+				ptl->disable_bitmap);
 
 	ret = amdgpu_ptl_perf_monitor_ctrl(adev, PSP_PTL_PERF_MON_SET, &ptl_state, &fmt1, &fmt2);
 	if (ret) {
 		dev_err(adev->dev, "Failed to set PTL err = %d\n", ret);
+		if (enable && bit_changed)
+			set_bit(AMDGPU_PTL_DISABLE_SYSFS, ptl->disable_bitmap);
 		mutex_unlock(&ptl->mutex);
 		return ret;
 	}
+
+	if (!enable)
+		set_bit(AMDGPU_PTL_DISABLE_SYSFS, ptl->disable_bitmap);
+
 	mutex_unlock(&ptl->mutex);
 
 	return count;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 0997b13a5f41..2de7815c7516 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -31,6 +31,7 @@
 #include "ta_ras_if.h"
 #include "ta_rap_if.h"
 #include "ta_secureDisplay_if.h"
+#include <linux/bitops.h>
 
 #define PSP_FENCE_BUFFER_SIZE	0x1000
 #define PSP_CMD_BUFFER_SIZE	0x1000
@@ -382,6 +383,12 @@ struct psp_ptl_perf_req {
 	uint32_t pref_format2;
 };
 
+enum amdgpu_ptl_disable_source {
+	AMDGPU_PTL_DISABLE_SYSFS = 0,
+	AMDGPU_PTL_DISABLE_PROFILER,
+	AMDGPU_PTL_DISABLE_MAX,
+};
+
 struct amdgpu_ptl {
 	enum amdgpu_ptl_fmt		fmt1;
 	enum amdgpu_ptl_fmt		fmt2;
@@ -390,6 +397,7 @@ struct amdgpu_ptl {
 	/* PTL disable reference counting */
 	atomic_t			disable_ref;
 	struct mutex			mutex;
+	DECLARE_BITMAP(disable_bitmap, AMDGPU_PTL_DISABLE_MAX);
 };
 
 struct psp_context {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index c276ef6801d0..f375dffcbdf6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1814,6 +1814,8 @@ int kfd_ptl_disable_request(struct kfd_process_device *pdd,
 			goto out;
 		}
 	}
+
+	set_bit(AMDGPU_PTL_DISABLE_PROFILER, ptl->disable_bitmap);
 	pdd->ptl_disable_req = true;
 
 out:
@@ -1834,9 +1836,11 @@ int kfd_ptl_disable_release(struct kfd_process_device *pdd,
 		goto out;
 
 	if (atomic_dec_return(&ptl->disable_ref) == 0) {
+		clear_bit(AMDGPU_PTL_DISABLE_PROFILER, ptl->disable_bitmap);
 		ret = kfd_ptl_control(pdd, true);
 		if (ret) {
 			atomic_inc(&ptl->disable_ref);
+			set_bit(AMDGPU_PTL_DISABLE_PROFILER, ptl->disable_bitmap);
 			dev_warn(adev->dev, "Failed to enable PTL on release: %d\n", ret);
 			goto out;
 		}
-- 
2.34.1

