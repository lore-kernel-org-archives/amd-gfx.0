Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F2BC71159
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 07:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1DCC10E9C2;
	Thu, 19 Jun 2025 07:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RhMgKvk2";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920FB10E9C2
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 07:29:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhAb01mCRHo3b1WMdm5FySJEFDCAO8+GYp7BVNypheGEgXe9P5tvtP0RMdtvA5soX8mTzKiTvYvb2jKSK0NsA9fSUEoIDRDDEDwPj71LZcpEEwGK11Fuka12uPN+pSXkAPCDJZ853UYHSUeyJdtCxNQNVDcCKQcQ2dNTBWtXzvjKry3myMycZBq2zuLwUF4vUhc0efBKc3CcT1dqhm3K2THh5EquVDrrrQ4C42zDiwcFH+T/0lbGCc7nuF/3c3nCtBC1ggxtiNNKsUHu2kzEO6k1WtTW/CXdWeV4EfmTLnIA2FdNXZR/ZvjgBhmzdIg5qS+DtQIPjXjvN5Pfpe3CFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAr0wjko0IOj17Xi9wMEvDbPyh93Hqq4gtCkpawg6aU=;
 b=VlOO8jUKd9jn43wFGg+zsx+srYqk8jFLaN8iukSBbIQHrZ8Px9vZj9q2tP89J9qp225ax9fSMm0l05L6T3jfZbZgddGDaccdcXaGlyrVV80RYFE0g69DT5NtMEyYk6SVaAnUjaTMmsvCPPsK+APGfUn9HHXSvLqCC699+UrNhx1/hMLXF4YUWNayhigh/3hIJsq7NZS3mU92WACyAuUXoningK+4/ftBoIJDn8CO1Z5djNe2rmp36PCqgpWDbRnT2gqplI2AJvaZjdXpWdpFOCzA4FMNkOp3+tZW2MbJyEHPrRq5MoQSgqwzpXe3OwSHBS9unxyqYw4NGUj1bKV2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAr0wjko0IOj17Xi9wMEvDbPyh93Hqq4gtCkpawg6aU=;
 b=RhMgKvk2lUaz22FFHT8nCyvKDCh674CdKScHStMm3VHMWBaGX2NsCrSCLAf5OLue05OyzRFXPdFuRZm2WbNOWpQvVebIeHH6qm9jHd5BW/rIm7V4thHcRN6C2G+qwL7Y3ysE6d9cMpscMhA3vxPCgZukVJYHUfSZ7ohaocGuUR4=
Received: from CH2PR14CA0032.namprd14.prod.outlook.com (2603:10b6:610:56::12)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 07:29:50 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::3a) by CH2PR14CA0032.outlook.office365.com
 (2603:10b6:610:56::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.33 via Frontend Transport; Thu,
 19 Jun 2025 07:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 07:29:49 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Jun
 2025 02:29:46 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, limeng12 <li.meng@amd.com>,
 Jiang Liu <gerry@linux.alibaba.com>
Subject: [PATCH V2 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
Date: Thu, 19 Jun 2025 15:29:29 +0800
Message-ID: <20250619072929.1132699-2-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250619072929.1132699-1-li.meng@amd.com>
References: <20250619072929.1132699-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccd62df-db2e-42f7-9314-08ddaf0312e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?47HNMbnBsLBGI4jiG3PyTGf1rpTKRagQjIjbkbCMiuvVk4CkjSHiu2vpK5AK?=
 =?us-ascii?Q?DPWVsGFaNQvTiJ4H3MwgjNWNSMFGSUH7gW/zZ/cjVVH0BmqIxr4y+UStYw8G?=
 =?us-ascii?Q?KDlEvsxbFU6Ij8L94NHGZDJGZZfPWCuyKkX/NVR8jsWTXtL+gaqpC9nXP2wD?=
 =?us-ascii?Q?7NmHsA9TPDChbr/1HqtR5ntRZOGxElpJRFTWwPw08mnCCugyUb9qWqbij4wq?=
 =?us-ascii?Q?4ANpSC7R2jaUoncHWCr50ujTnZ/VlnWTobsVbRGVD7P+hN2ps3p1x3k3D5si?=
 =?us-ascii?Q?CXZzhDiNyxBeNxc2ig9gpLEOHkxsjz6GZ9TBOTCHVh2JpMaWxSB7oFpyXY3t?=
 =?us-ascii?Q?FRpmAaDvRFJQhmMD2okAFsQmSyFRd7G/Pm5hDe6DUHvry4sT5wgwoUrOrl3U?=
 =?us-ascii?Q?WJA6IDf6+Ypjn3cou+2z342m6hjnfxo0Mj/Mv+yH7Tal4N+5/N9lLhVmpIvr?=
 =?us-ascii?Q?VulNKgxb37D/yGUKeAfHpyf7V6boik9oqUdbSGGQdD5jgzyvR8rZrrrk5Npv?=
 =?us-ascii?Q?+5mkbrVmKpCELeD+hxAYAqSrb3TId5kKZNXSEBSGJ9GHnfPbhHg8iAqGJdM9?=
 =?us-ascii?Q?fnBmX3vMVobuLm7F8iduPd2IzOO0QiAOIcRxwySubdK1Mm8WrXDy8yUQhVIU?=
 =?us-ascii?Q?c+8W4HQQQsDQTZvzndbh0QP///NpRS0zMQn9Ai0NZIM+3JzCI3sEDTXd+7qK?=
 =?us-ascii?Q?TG6uH08Kf07o9ByeN1hqxDn2YEGzVExXxq1kmG7X8/ekhTF4nS80Zmh9xRKt?=
 =?us-ascii?Q?MWutQs53UYAuAEhGgBWfEeE02qmXVx4I53/pe9As4PpQNvsOsKytm6+awnpN?=
 =?us-ascii?Q?uVVPUVDZtokgYKd3AqVOxmIzI0nwGTZS3dXk3r64F6jROGxcQsVjhK2Q2UHg?=
 =?us-ascii?Q?Qfxmq3ex5ObUBXl6SK0PILklvo87irL1X9+V43KJPAZC5rspdjRhrP0NIq8Z?=
 =?us-ascii?Q?EkhI/BOooPRTw1cHgfXh5UWWxpB+LSHzmQFIzkjeJXhgtzj5+JmoZzkDd+4+?=
 =?us-ascii?Q?gPhTHDvDHIh5YpFZKdF2VlwaoLHSZm1LvM/Co4s99Oial/CNAxsO467DToL5?=
 =?us-ascii?Q?a11TJUjG8/dtU4JuRqa0+Lv1xE/ivvbZ6kbtPa/wDMbzjdR5uabPtD+ur1fO?=
 =?us-ascii?Q?6sZ/bWbLPXdGx4vvzUphF/apNrLGZ/vMhavji9LEx70cArfZwNXO5SbQGij2?=
 =?us-ascii?Q?V+/gNfbhsfaMqKw2Kd8HSF//A2prVO30cNdKzS7b8DF9wuxkPOnr6KEsGbPL?=
 =?us-ascii?Q?3SlToiVkKAaOoC7d3NQvNQInGm2rG6UdgP0dv5bRoDp50UGHZAlsy2LXU/Lh?=
 =?us-ascii?Q?MebV7cwZ4v4ERTiVwmXUdTBlhzjZPtEsnmowwdpPKNnxd5+kgdNguAgZdstF?=
 =?us-ascii?Q?fUEyYrUnOxtPz7xPL5aMuvVjRCDv21Dvy50zGOUKS46Mh2py1A8Vcwo8olIT?=
 =?us-ascii?Q?pNOUAzyGLHj7u3qKkEwM3ghBznBgdfv8IQKLCZjy1WVf5knb4pb1gU1ct8BK?=
 =?us-ascii?Q?5JPPMsfMuA4V9opnCDA7MRSBK074U6aK0AsG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:29:49.2414 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd62df-db2e-42f7-9314-08ddaf0312e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
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

From: limeng12 <li.meng@amd.com>

Add a new API amdgpu_xcp_drm_dev_free().
After unplug xcp device, need to release xcp drm memory etc.

Signed-off-by: Meng Li <li.meng@amd.com>
Co-developed-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 60 +++++++++++++++++----
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 322816805bfb..70c44961af95 100644
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
index faed84172dd4..3a8f3dd19a12 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -45,18 +45,29 @@ static const struct drm_driver amdgpu_xcp_driver = {
 
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
@@ -72,8 +83,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 		goto out_devres;
 	}
 
-	xcp_dev[pdev_num] = pxcp_dev;
-	xcp_dev[pdev_num]->pdev = pdev;
+	xcp_dev[i] = pxcp_dev;
+	xcp_dev[i]->pdev = pdev;
 	*ddev = &pxcp_dev->drm;
 	pdev_num++;
 
@@ -88,16 +99,47 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
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
+	int8_t i = MAX_XCP_PLATFORM_DEVICE;
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
+	int8_t i = 0;
+
+	guard(mutex)(&xcp_mutex);
+
+	if (pdev_num > 0) {
+		for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+			free_xcp_dev(i);
+			if (pdev_num == 0)
+				break;
+		}
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

