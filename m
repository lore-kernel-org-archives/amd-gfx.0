Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB4EC7115C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Jun 2025 05:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 003AE10E35E;
	Wed, 18 Jun 2025 05:53:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xUC+MGge";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D2A10E35E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Jun 2025 05:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPizLFCk0pDM+889qYJ9LOsZ/PZLPo94fzaP52kYPj5ZVLxgh6PBdQXjYzMx0pCrsukwwB5YazcFzo4ONt6C2DVn9WwK/3L3vWlPOTS9c/ta6NQ09dRNNsGQ9tSQdiUXhfAV9nOd2wjqr6Sl64FKNWcqlB69OmEqZiZdYM9kVsnoL4r0CP3XUitKfblNRCrSd0vBqXq03tGfh5jeKLyVGmq1hPI2DEZGmci2I28hzX52f907dW+zIY9AhFfjWQdnTKOUoUTw8cQJ8SVyfnrd6iV2E+PYdVzIogYlDDmNfjRZCaHGOh79/6v5bof3XNBMipMfnxejQWaoqFYi2K6JUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUZbt/q0ImzwuPBOhW9g4Mnfa5oMHZEEIS1D/wdZfQA=;
 b=EXMtTHl8pJaQJAPIy1ceBYijTG96wTPsSJJuNe8qm4fQNvbUwS8W0SNc9ihNnmOdaoPzNa6ikZ9OgxX+PAb0KMI78ZCc84FO0ac5soJLsdcEQfwD9BZIdxllrW84IfyPJIlZL990oJzb4bQhQZ7geUMc5PagmmcXfq8lZU87BIY1pBAl4LQjybZ9CKP7p17EsalaG3uXvx4VbnU6+8hOh3SQAWnuoWJbjt+3N3986I+X1cGfMU9vl9cPPaGzB5IVWqlRznf+/w8VVR0kIL9V40GRgs+xhBjo+EPuFKNd0UzXtvsYlZ1lcPJVUULiLp16d3j9kQ9Ghppd/lLh1Q/wWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUZbt/q0ImzwuPBOhW9g4Mnfa5oMHZEEIS1D/wdZfQA=;
 b=xUC+MGge6np2S+F1DMdu1GC9tTyIiEJt8VTDS1l0pqWfACtuO1xICmJT4BVOyxZDkMsNxivIIqs/EyI2RjdECaLz5HrfiQoXa3pfRNJxpOGbpUEo5myZGgzBT5atfxjwvL3cTYZ4Fi1QE/nbPBz+3snEcaiAI6iZObQIspNkS6s=
Received: from SA1PR05CA0015.namprd05.prod.outlook.com (2603:10b6:806:2d2::24)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 05:53:09 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:2d2:cafe::a6) by SA1PR05CA0015.outlook.office365.com
 (2603:10b6:806:2d2::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Wed,
 18 Jun 2025 05:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Wed, 18 Jun 2025 05:53:08 +0000
Received: from jasmine-meng.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 00:53:04 -0500
From: Meng Li <li.meng@amd.com>
To: amd-gfx <amd-gfx@lists.freedesktop.org>
CC: Perry Yuan <Perry.Yuan@amd.com>, Shimmer Huang <Shimmer.Huang@amd.com>,
 Koenig Christian <Koenig.Christian@amd.com>, Lazar Lijo <Lijo.Lazar@amd.com>, 
 Alexander Deucher <Alexander.Deucher@amd.com>, limeng12 <li.meng@amd.com>
Subject: [PATCH V2 1/1] drm/amd/amdgpu: Release xcp drm memory after unplug
Date: Wed, 18 Jun 2025 13:52:43 +0800
Message-ID: <20250618055243.1128889-2-li.meng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618055243.1128889-1-li.meng@amd.com>
References: <20250618055243.1128889-1-li.meng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: eb798558-48ad-433c-350c-08ddae2c6732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?innzy1FxzulaJpC9aq5f9/TWCi09/01nZHC04p35GSOrgbsulEYMcDgx1ufa?=
 =?us-ascii?Q?DFfkJLuN9X8gkKu+cokWrQ02JisiXyMUNImwLqFP4MgNhyD9jaY2s6jDGHNN?=
 =?us-ascii?Q?4/U2Yq9dMbQRRlK/nWCUoVHdmcvPEQnR59pKdeljWKtOXpLSp1P/jOW0Jx2k?=
 =?us-ascii?Q?Aj9tVjXk3y7uSvfXMXMz7Wh5AeYAy3c6EHLKgknkwRvOvk1MrZs6Jqbzd1Rp?=
 =?us-ascii?Q?rb++rcer6FZ6M13SDCWRt6KcnqiAMiBCSOit08ewZ8lSuN7TI+T6UuOQtdb5?=
 =?us-ascii?Q?hGltmg/zCAznT7kUuW3AT+RgdUsqq6d96Qf8etHcKoej7JirUb2qCwxR6DxO?=
 =?us-ascii?Q?aKG7V7VIrMz2Ojv+DTd3cSESDdhIkqEeztg5XpopgQaJXn+j7EGfu6RYhg4w?=
 =?us-ascii?Q?P0JCovZoLpwGiSsqWGc4L3x0mO1YFrflPu/oclIjQ58iSDV/AVM98aUHw+3S?=
 =?us-ascii?Q?Cz6BnGu1cDDFRDoT89/mKSI7M1tTp/guSewr1FHQaEYgcEQra8u5XcaBn+qL?=
 =?us-ascii?Q?GyzYvU70zEKtBv1BBfcdxHcT9xOpeIadlA/dx35yylTlJWiHdMbLJyCmFnDN?=
 =?us-ascii?Q?ltDE+gU5nhUVdq+0jKfGq3UXLfOezpMWudgVguARM+FOAlEPtdEy2dPiWd3h?=
 =?us-ascii?Q?vem4kLfCH3t35EYc82JL3F+VBpgwfCdxEZ6Gct7MoTDP3mJ7aAA+kqfc8GcA?=
 =?us-ascii?Q?YLWt8UmMYL3O6HpPLIKBiwdZmI1mEYgRWqyk9hKnki26swiyatwshcu4fLtT?=
 =?us-ascii?Q?HD5KFMATSoY+RvTyKovaAVZwFiWGc3Wwc1UfpZjRqUMkiEX5MKqDDlnjQLyT?=
 =?us-ascii?Q?AtVySv8s5LKes+XrhJKcMW+DXO+ogSJBAhS12O3rRCM3LIqD4iDr3TrQl3ln?=
 =?us-ascii?Q?9iWhCjFwR+lg9BKRiSyA+oAYmpuxV3SM3uwiBtFheY45YTcFbOVydfEpSo0S?=
 =?us-ascii?Q?HFWr79dymxeM4RBJQhhClZRvVWhtku4+teHbXhsRcrlW+Ld058H4/ATYhx2L?=
 =?us-ascii?Q?bLcp4Sm5k+CNRcETuGnU4PueqY4L5Eie9fWq1YNlKBmYdsAePcQAPgDi44bI?=
 =?us-ascii?Q?AuvHTkJfiz3aqzwn0gJgEoBXlqa4kr7FdnkcnjPpbx5aB9eC43sh//mrUirS?=
 =?us-ascii?Q?4O7aSa4LQdmBJhgVoQ1hFbs5ET5SIAnKSf3Y8d07Z8eN1XyLnx+6nMkIl/gG?=
 =?us-ascii?Q?GWZvsg8PS5WQLE0wvcz3vR8k2V0v2YUqyuHL6yeVCHguybjo78nX+WH3d3HW?=
 =?us-ascii?Q?rW5+RwjUgbQ4XpFVp77JGTqmurdsQXVk2mcKBGOHMzuxH2RIQc/1aJ2U/HVG?=
 =?us-ascii?Q?ZpJ/HDIsZq+0CCM1e9SfA9sIoMrU79WwaE0YiaztXTEJ0pvNr5NDjuUhvAmU?=
 =?us-ascii?Q?c1MBwWF+q2cE6sAO38HAh5xM3hQtRhc+9n0owmUQ5xRTlHvnoPy18KpjKpjK?=
 =?us-ascii?Q?lWbLPUdz2r/B8/Q/9om/X5tl5fM3Nj78cUuFa6OydBeAi+ph48s1v3sp3Fcg?=
 =?us-ascii?Q?gRhT6sPGBScl/GYl54FOKb7D1Io8/ZtlMq8v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 05:53:08.8940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb798558-48ad-433c-350c-08ddae2c6732
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |  1 +
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c | 63 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.h |  1 +
 3 files changed, 56 insertions(+), 9 deletions(-)

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
index faed84172dd4..8714458878cf 100644
--- a/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
+++ b/drivers/gpu/drm/amd/amdxcp/amdgpu_xcp_drv.c
@@ -45,18 +45,30 @@ static const struct drm_driver amdgpu_xcp_driver = {
 
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
+	//find a unused xcp_dev[]
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
@@ -72,8 +84,8 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
 		goto out_devres;
 	}
 
-	xcp_dev[pdev_num] = pxcp_dev;
-	xcp_dev[pdev_num]->pdev = pdev;
+	xcp_dev[i] = pxcp_dev;
+	xcp_dev[i]->pdev = pdev;
 	*ddev = &pxcp_dev->drm;
 	pdev_num++;
 
@@ -88,16 +100,49 @@ int amdgpu_xcp_drm_dev_alloc(struct drm_device **ddev)
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
+	//find the drm device
+	for (i = 0; i < MAX_XCP_PLATFORM_DEVICE; i++) {
+		if ((xcp_dev[i]) && (&xcp_dev[i]->drm == ddev)) {
+			//free
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

