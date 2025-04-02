Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8225C3601F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54D3710E832;
	Wed,  2 Apr 2025 16:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q7E2ajav";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FCEB10E825
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uipVQRFeUonpCV9v+IuPiyOP6U84uvMMl/FVrZ4i+sXEH5xWYf5amjjbrISI/Deh/PDqlMaxI2GFjWUWSqBkxp41h9Ztj8qtQFilsrEeb/t5Dx+cnLoBVJZWm9IwHIRKqtkaBtBC8iP0c9TUBEWCMIuV1QWR0PFhgAuCodG2m2qzsYCv/kIr+xY8z6454YitxNneB9S/GU0vLajld+DOsRZceDE++la96Cdem8fs1gXIBbcrcI8aqVbS/Z0S2gx1K2wNXoIpkb8SN/TYO/tcJtZCTr10SPhRI5CZxDOh2pA1y/VI1jZ/M9LBy0+POwMkZrZZSHSNIlIwMI+ikybkOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL1eYN5Vu/njfLYKGKNH2qlWaHzzBXno85zMnDrJkn4=;
 b=iWOBc1hVUC+ELadw8T1QVRwSRW+VPLaOjLBMIwjOI4HSkiWElJjKKZO1RTTA5LqNKEdcwNXg0EpQ76+R7UXEhpLoLMcHQc4kYshIJPP/c9WeBwiU4spX9M8efuPYdri+8XgGDUchCdUcc+iuBQssX5UsujGtZpoTSi3HhbJWqkYdRrPtHslYpl8rJCLTiWjogj3WJP2M/F2ZjvO+LYrhiYJJbAb98Qs7CcJABmh/2WEXAe1t4YM613zfcvnh8aQcEVEtNq4S7NiN8BcJGipmi5nfoH73WneiRb/QFkr+oSIALpC+IonvOShAgC5rSAo7vg862Xy8QYRCukMOZ1kciQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL1eYN5Vu/njfLYKGKNH2qlWaHzzBXno85zMnDrJkn4=;
 b=q7E2ajavddgQAsHH23lyoEPKrQPuPSQHu1jvinI5ZCqbdNr/A+qOSuuHMO+9zwuXmpddKxm51Qf4i65kAHWbNJAzXyFVQWtTu4Y6li+ZCtARNjRnTKdcj18mS3rfL507PhcK4rqgQK0UXBCzxU3B/uUzQAaC6Mq/6SLbPyd9Bx4=
Received: from CH2PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:59::22)
 by DS7PR12MB9504.namprd12.prod.outlook.com (2603:10b6:8:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 16:13:41 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::fa) by CH2PR03CA0012.outlook.office365.com
 (2603:10b6:610:59::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 16:13:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:40 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:39 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 04/16] drm/amd/display: Adjust all dev_*() messages to drm_*()
Date: Wed, 2 Apr 2025 12:13:08 -0400
Message-ID: <20250402161320.983072-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|DS7PR12MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 66cc3dcf-3eb3-4285-8a8f-08dd72015526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ik+e/Sxeg1+7EhhlyvliijIdObiFS0CirI8dozaOJ8+d5NQVwbO88tfl5vK1?=
 =?us-ascii?Q?SmYb6T+I8LIiR4YXyVDJ4KhwfUNillyk+1t4dvFT5sKA71so/JKOPmQDCij4?=
 =?us-ascii?Q?PWT+H2Mw3Ibakx45LRDJvUEa15nYQWN3Z2ooscr+KT4nkF5UUV+EW4kgQ2bJ?=
 =?us-ascii?Q?xwEfq0lmEg8PvqCbGBzlVG/doz2MRrejbzio9ZZoql9uFZ0obudYp2zsv1t5?=
 =?us-ascii?Q?MNKAbRvHW85DBGpzZYmdnYyUuwocvJo9WlJU4rn+GCtelbvB6sfM28Jz/++P?=
 =?us-ascii?Q?moBsQykhlsn6bZYPa+5AYbPKP/rj3sEeBAZzFCJ7cX7J8FB1OzbL2B77rUhF?=
 =?us-ascii?Q?tZFTktua7UfS1Y4BBeoLYZcZZQgrTxTjFs38c7vEs3xyepz2i7QFKpIxIAsf?=
 =?us-ascii?Q?j+SATsPGyhTW5hHr/XQq/wLl5bHqdMe6wCOndkIvmBYVJnC67LRiondiz1ZE?=
 =?us-ascii?Q?umQw0Aivzktsp15yraHIfIpm7hxI5trN9v+/UTo1+snXvIvTxaUzzf5gVmBT?=
 =?us-ascii?Q?CE0YLc8/xu5hrJTG6mqFgG6jtj+nWcauBVwz+ajfmOFbEuhm0/q3rJZuC6l8?=
 =?us-ascii?Q?on5nP+ZsREPuSK1/or4DPMJQrs4wVZHxd2Icd6bbyrLOYS+KlkXYOwzAOyPu?=
 =?us-ascii?Q?I7STZrB90xRhgjABvdICtlamOz83N4ivk9Rx8Xpzm0W0HaCoTdOutkFYgkjv?=
 =?us-ascii?Q?+s6NxVJV/5KO9aG81kEO7JWUIHSlMyglEwKnyrX+U8Yg/1/br3ZhbmoRWW34?=
 =?us-ascii?Q?qRDgsXj9pdUUOJHqPO5pou06SeSPTiXZeEXgdEqy3mEefaMMQTT4yGk2cTHc?=
 =?us-ascii?Q?s3yDEWCsnAgFflXWReheVwUq+P7teNOmLVptxabdx7nU0DY7CqJ25LVOQ88k?=
 =?us-ascii?Q?hgPwJT+93FvNGgWOuKF9Pt5Z2yBulELB5iIJr5t/MHJFS3tDP1kLfF3aPuNZ?=
 =?us-ascii?Q?/qZgGm92BTzDPZad2OXBRKp5aJMb7RUyAqQ/UBcqjl0W4e5O07djlI8Ku6Jn?=
 =?us-ascii?Q?0vsQMZusfT4QyeLaWiIRTAvwKXed33ZFcalBLgtwkY6coxSsou8T1MJ8DPoR?=
 =?us-ascii?Q?gop7YGi8MoGDJwVHk+vAM2uZGfCTGmtNy6Dr1E5Dq1fIy4xX6se0KzXc86f/?=
 =?us-ascii?Q?IPDdKFXsevm9J9VxtXdCJM2alAMoTxOXQG8SQrpihiIs5IWS1sLRGeDvVk/H?=
 =?us-ascii?Q?Jotsc0njpBILqOEYYR+ud1MniOwCY+2CcN1bNDK4LgiOWQHzkxSSWjA1TH88?=
 =?us-ascii?Q?xjVV7r9NmSkVFepy2TXroAP9xpfXFdrwI7a65RxxBzRgkJBc+fzk2YUgs/7O?=
 =?us-ascii?Q?USoZli0k/jDNYb2Aj+Lsl4FjqUAHn3g7JUChgAoMrYj1Iq+AHzmGDGGxemg0?=
 =?us-ascii?Q?L73YpeuMZ3UtXVV01IU0sj48m4lVt1PLHIOPxp5AAPPs/d93K28iYO44Aakn?=
 =?us-ascii?Q?QzxVdh7rEvcdpRwtfZD/xBZKp5PmbL/cuKUlxhrtc7e3W+TMGooKVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:40.4976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cc3dcf-3eb3-4285-8a8f-08dd72015526
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9504
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

From: Mario Limonciello <mario.limonciello@amd.com>

[Why]
dev_*() messages don't show that they are from a driver in drm
subsystem.

[How]
Change all dev_*() messages to drm_*() messages.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c      | 10 +++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c    |  4 ++--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1533d0a623ce..65162e581fae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2479,7 +2479,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		return 0;
 	}
 	if (r) {
-		dev_err(adev->dev, "amdgpu_dm: Can't validate firmware \"%s\"\n",
+		drm_err(adev_to_drm(adev), "amdgpu_dm: Can't validate firmware \"%s\"\n",
 			fw_name_dmcu);
 		amdgpu_ucode_release(&adev->dm.fw_dmcu);
 		return r;
@@ -3028,13 +3028,13 @@ static int dm_oem_i2c_hw_init(struct amdgpu_device *adev)
 	if (oem_ddc_service) {
 		oem_i2c = create_i2c(oem_ddc_service, true);
 		if (!oem_i2c) {
-			dev_info(adev->dev, "Failed to create oem i2c adapter data\n");
+			drm_info(adev_to_drm(adev), "Failed to create oem i2c adapter data\n");
 			return -ENOMEM;
 		}
 
 		r = i2c_add_adapter(&oem_i2c->base);
 		if (r) {
-			dev_info(adev->dev, "Failed to register oem i2c\n");
+			drm_info(adev_to_drm(adev), "Failed to register oem i2c\n");
 			kfree(oem_i2c);
 			return r;
 		}
@@ -3077,7 +3077,7 @@ static int dm_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = dm_oem_i2c_hw_init(adev);
 	if (r)
-		dev_info(adev->dev, "Failed to add OEM i2c bus\n");
+		drm_info(adev_to_drm(adev), "Failed to add OEM i2c bus\n");
 
 	return 0;
 }
@@ -5619,7 +5619,7 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 	/* if there is no object header, skip DM */
 	if (!amdgpu_atom_parse_data_header(ctx, index, NULL, NULL, NULL, &data_offset)) {
 		adev->harvest_ip_mask |= AMD_HARVEST_IP_DMU_MASK;
-		dev_info(adev->dev, "No object header, skipping DM\n");
+		drm_info(adev_to_drm(adev), "No object header, skipping DM\n");
 		return -ENOENT;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 071a5f9ebf2a..56bc2644e492 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -948,13 +948,13 @@ static int amdgpu_dm_plane_helper_prepare_fb(struct drm_plane *plane,
 	adev = amdgpu_ttm_adev(rbo->tbo.bdev);
 	r = amdgpu_bo_reserve(rbo, true);
 	if (r) {
-		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
+		drm_err(adev_to_drm(adev), "fail to reserve bo (%d)\n", r);
 		return r;
 	}
 
 	r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
 	if (r) {
-		dev_err(adev->dev, "reserving fence slot failed (%d)\n", r);
+		drm_err(adev_to_drm(adev), "reserving fence slot failed (%d)\n", r);
 		goto error_unlock;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 0d5fefb0f591..d9527c05fc87 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -102,13 +102,13 @@ static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector
 
 	r = amdgpu_bo_reserve(rbo, true);
 	if (r) {
-		dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
+		drm_err(adev_to_drm(adev), "fail to reserve bo (%d)\n", r);
 		return r;
 	}
 
 	r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
 	if (r) {
-		dev_err(adev->dev, "reserving fence slot failed (%d)\n", r);
+		drm_err(adev_to_drm(adev), "reserving fence slot failed (%d)\n", r);
 		goto error_unlock;
 	}
 
-- 
2.34.1

