Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27862C43458
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jun 2026 16:33:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6286810E40B;
	Sun, 28 Jun 2026 16:33:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pnakaaTY";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A00810E40B
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jun 2026 16:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kgx0+drOf8wf1pMFl/3hgXpKM1Zi645K/ZJ3ucnelw3q4iFj6pz4Wj4Yw+H/gzpfAXYazMYYObLfdd5GzCYnb+Tio5LZbl1wqDlauFUuJkbxgCZ8D4i5j6PHAiqc23asSZYRBvLRWR44tCfZbbN6x1ZzT3NVpeHFwHa3aejEWbkp0B9a4JC4KJuFSVl9HjTh2BAtQJElOf/RsBmmx+ezH6ywv67LHvQr/QAbO41CqgrN4MIYUgMyp4C30fdcUGmPpWY7W8/BEjhlP4ugv57mjD14rAjGr4Xajt3y8Drk+VNnNtQBsE5rkBQ4p1rUY95N+4jOoDJVY//eu8HMIoFo+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck1/2T1ev/ybvFO3AE9KeyakkDWtW9JfPqLpU/4ebu0=;
 b=I1kq1HD/vJ1PtfZjlli5N989T2UPRn85I0PkQftYNOj1KrTOtMGZo23rYLlJ5ke3ygzkFZUY7u7HeGFak+hIckmo6O8dkwols4TahovvwRC5djACVn9VjLI44FxFf6rNNnqrBXxYwR7cvPEIecw+92RzI53GRyxCSbmTHzttXDGodp/LreW5GKU/ER60Um9B/pFvFWDOHJsQrUy3uY1e2kfB02ePN+4X/7hPXO35n7Z9KwtQ7JcOtmRPU7A3R4o9t06V3JtBAcCXjuIx6g7fBk4kLF3y8Pj2aiwgeC4HS76jfQuals8Tvtxx5fDUxJY23ZiNOPlPsD6mtBcw7qE5XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck1/2T1ev/ybvFO3AE9KeyakkDWtW9JfPqLpU/4ebu0=;
 b=pnakaaTYZmW81X5Xicfi67ysoQrOaScieYeCS9q3JHcH3jcnSK6nhwxsdner2iT56jUTkO1UfdCbDyq7ZO1yEvy2agL13kXcd+mW+cnyFKOi55XcGoe5srKKg5ABdpVrigeMsfYRp436QnEgMTcjCY3ehAtmlQgEGJ2wkNiLoV4=
Received: from SJ0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:a03:2c0::15)
 by DS0PR12MB999106.namprd12.prod.outlook.com (2603:10b6:8:301::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Sun, 28 Jun
 2026 16:33:01 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::c) by SJ0PR13CA0010.outlook.office365.com
 (2603:10b6:a03:2c0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Sun, 28
 Jun 2026 16:33:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 16:33:01 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 11:32:58 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix DM I2C teardown race
Date: Mon, 29 Jun 2026 02:32:39 +1000
Message-ID: <20260628163239.1599449-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260628161719.1598835-1-geoffrey.mcrae@amd.com>
References: <20260628161719.1598835-1-geoffrey.mcrae@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DS0PR12MB999106:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb19b6e-5b6a-4bfb-97ee-08ded532eba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xgyGsgSjQVqDqLfP/qOUq5TfhCgGpRiDR7UiXXzTHliyFnhHEMNk0j24cZft+aX9UB+EHAd39pPa2c0vdlrjibXKeXMZJfwxmiLKamoT7eAH1iuwDs6dhz39bXUV62MLUiWIABMrt22mWUi508pH9HTqsHRHR9AHV47CvS+0Y6pvKVLwn6FajyqWVD4RQbjyTy/+6cMWDbOG73Okae4ZVNaIaHrOJj79NQhoTN65k5QJfxsegCCx5ghzDw43FuWxYXpM7VqxFrS/83pLvLrIBdA9J+aKU+mZmqSSWtVeFKL1YPY0ls3PaPges+xmlP0Ey/KHo0jYy4UFEygmo9M5VwR/MQiiX6L/OWzkX83a7w5Zexj9mc7t/XIclyzbTfHs8UAYeDDwH/oNIWR0ee6YfMfN9V+R5qFe3pIk3r+58BlQtVTB9YElJaJUcY7uSOpK3Rdanm+7vymn/9nPZ83H3QBOgjvs7A/vCTXe2gwxN0yPQjtOKNOlhg5wDIeK9HIA0OohL9y/iEWtO4Fzs+zFv940NkPmPYDFxuV+MTFSpINweCT6VcBYDWy8ym7CQRTXFelJHifwbzaWuAgFicb1ZmMsexOI9wT07uifIFh87RUnJcHUd4fbcJ/oZ3EAyyg9n943zYJSHBBZXm03hd+2GBY0dIE9CiHfGungyy+Wz4ygb8tDmA84xla127NMEjN6tb1wY7urun5WfWBR7u/5LA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gll3+HLlAcdFogU9zDqWs44n2VIOsPVkbsAGEKC+N6OBXolwFH3i69Ic86yHWG4dlGe5yQ2ZLdpZWnb3jGpUAFGrMvYYOzuyEOX9YEp8FSLb/0Y9bCTP+WuMnQ5+IwMcGSgeUqWm5uwMxkmgCplor8DdQSpoYSMF7pQLs0kKhHUFTZDhwvnRHi8cjqKgKSIdU1y4+MsAGteBYIuDKX4P/p7JJGt1+fm7hmflGtDvm2gBIsfCjaHYjFq5fpLvT0H8lwto2+mAAvrNsWFTbUhUPhsXDFclw4GKdMTwXuaEoHq15muaYtHeSCnJGjk2WTvXp7ZkbLay2dZAgir8tZhtJIq4W4GmEKA8pm2cFkemZVVm6el8cJM30FWR7hGB+oM6tqF9ydcPMI5hvcgHLiNAzJQ9CE91Ga3XyCxHMOQHqYCHlP1Bs2ltgHZ4UX6CLNXv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 16:33:01.0759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb19b6e-5b6a-4bfb-97ee-08ded532eba0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999106
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

DM I2C adapters can remain visible to userspace while DM teardown is
already in progress. A concurrent i2c-dev transfer may then enter
amdgpu_dm_i2c_xfer() after the backing DM state has been torn down,
leading to a NULL pointer dereference.

Create a devres group around the DM I2C adapter lifetime and release it
at the start of dm_hw_fini(), before HPD, IRQ, and DM state are torn
down. This removes the I2C adapters first and waits for in-flight users
to drain before the structures used by amdgpu_dm_i2c_xfer() disappear.

This fixes a teardown ordering race seen during device removal:

BUG: kernel NULL pointer dereference
RIP: amdgpu_dm_i2c_xfer+0x122/0x1c0 [amdgpu]
Call Trace:
__i2c_transfer
i2c_transfer
i2cdev_ioctl_rdwr

Fixes: 5b3eca05cfb0 ("drm/amd/display: Use devm_i2c_add_adapter to simplify i2c cleanup logic")
Signed-off-by: Geoffrey McRae <geoffrey.mcrae@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 +++++++++++++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  7 +++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b97ceabe6173..5613dc9903fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1496,17 +1496,26 @@ static int dm_hw_init(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
+	adev->dm.i2c_devres_group = devres_open_group(adev->dev, NULL, GFP_KERNEL);
+	if (!adev->dm.i2c_devres_group)
+		return -ENOMEM;
+
 	/* Create DAL display manager */
 	r = amdgpu_dm_init(adev);
 	if (r)
-		return r;
+		goto err_release_i2c;
 	amdgpu_dm_hpd_init(adev);
 
 	r = dm_oem_i2c_hw_init(adev);
 	if (r)
 		drm_info(adev_to_drm(adev), "Failed to add OEM i2c bus\n");
 
+	devres_close_group(adev->dev, adev->dm.i2c_devres_group);
 	return 0;
+
+err_release_i2c:
+	devres_release_group(adev->dev, adev->dm.i2c_devres_group);
+	return r;
 }
 
 /**
@@ -1521,6 +1530,9 @@ static int dm_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	if (adev->dm.i2c_devres_group)
+		devres_release_group(adev->dev, adev->dm.i2c_devres_group);
+
 	amdgpu_dm_hpd_fini(adev);
 
 	amdgpu_dm_irq_fini(adev);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 909ee71d6d59..13a18e1ed576 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -688,6 +688,13 @@ struct amdgpu_display_manager {
 	 */
 	void *bb_from_dmub;
 
+	/**
+	 * @i2c_devres_group:
+	 *
+	 * Devres group for DM i2c adapter lifetime management.
+	 */
+	void *i2c_devres_group;
+
 	/**
 	 * @oem_i2c:
 	 *
-- 
2.43.0

