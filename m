Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FE3C43458
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jun 2026 16:17:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47BF210E076;
	Sun, 28 Jun 2026 16:17:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ubu0oOv8";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011048.outbound.protection.outlook.com [52.101.62.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90FA910E076
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jun 2026 16:17:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZ2ySReeJvi51TBD6ZVZMPspjyOpFfk29IVhBLNjE1egYSuv1+WTM3oTJxd93EwsdR0P/p7tIWW+QKr32Eqqhcv2AbzsXDjKa3iwUt27XVjRhUcicQsEBXQcr/owgVmlbJbz1xZvMt6aP6yffnOYwf4Rt/iV6BmInWxQHGDyJcKSMWzJEzEqWC1YoXRQ/d8G80UIbe+hFQN8gX22Ovw5rwAlyLaO/bO+rk1FwGt8RIDkG8x33fwPuRjjkkFKuC01bs37FMQmKgSBlx6S24uLfjx1gBpjVIiAHG3QoJqF5x3MSoLPGnp1Q9Ni2UHz3o2ToYqle7JZaoUm2JEzQJJ8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPK0EcDWv1Baa9l+N0ye1DFhxVPrm4RjejFQegX6OLs=;
 b=YjRLjpaWzKNF8Tutw2lfBT8lyNS4zgpbX+7NsHaBMLcM58rFqkGLTDala+y57KgTePF/qUKQHmLy4rfZjHWCMlZ3s8FjGGCiLKiEs3r7GXHyco2zT67kUdCSLvlNLck4hA2Cz0qFOFKLExx/m7puUsUngK7bMgIXBqiTrRjC2sL5Keq+UwEcqKBUsHh7Ti+cL4JaV00sl7CrD672EYur/a0y0RvncpVRMGsdagRIXw0PwacYlGCufZk4LZLMoXvpLLaCRcuV0lG2+lx5kWvTZMiJsWxScxG6rtzHlVeF+LVSGFMf4g0+/YMxqOJExNdt/5bFpcvf0ejUHZ2p/8PqJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPK0EcDWv1Baa9l+N0ye1DFhxVPrm4RjejFQegX6OLs=;
 b=ubu0oOv87PIrNEqdiiGbxY7EMzFsCTgEEffoQYvingFtNPt+Q1rjEDKB3AK1Y7RVjdTIzSVF39Y08tvLoSsg2VQ8sR22R6aoWWyiVNE6EGL70P8K7oCbg0iofI/cTrSTW8N9MeyQgc7lNOJc/HiU7E4jMCPIIcSsaHGrcjvKqvk=
Received: from DS1P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:242::13) by
 SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Sun, 28 Jun
 2026 16:17:35 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:242:cafe::58) by DS1P221CA0018.outlook.office365.com
 (2603:10b6:8:242::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Sun,
 28 Jun 2026 16:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Sun, 28 Jun 2026 16:17:34 +0000
Received: from amd.com (10.180.168.240) by satlexmb07.amd.com (10.181.42.216)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 28 Jun
 2026 11:17:30 -0500
From: Geoffrey McRae <geoffrey.mcrae@amd.com>
To: <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <amd-gfx@lists.freedesktop.org>, "Geoffrey
 McRae" <geoffrey.mcrae@amd.com>
Subject: [PATCH] drm/amd/display: Fix i2c devres group teardown race
Date: Mon, 29 Jun 2026 02:17:18 +1000
Message-ID: <20260628161719.1598835-1-geoffrey.mcrae@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|SA1PR12MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb3f4ac-cd4a-452d-3187-08ded530c37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: en68d56t1YULnqSSFe+YazuZffqpwv5BYw5U4v9DJPt8NZLuGCZXEoeKmX1NeohjPD+/ZJOOhWuFyhSb+4JXIg+ti+5qym89ALVW6h+OBz2gD1wcmx2ZNjXT2hdFEp7XnNLaI4Wc7dgO2g4uZpmTU/9/vRqOAchob/5RLaFqFkphu59RcXEu9GhNR8b4Sa54f3/BD7UQX3K6b5QSfQricJlfgSUjUGsLtfOCyffmlgliLtFkppfUoLrHoNBcwG4wRgCUZqmlrkItzIIEkwSfDlTNOVbXwx460oGXpzl2Ap3UM6An5VjscreQlNNkrjjhxQ4rCw9nbt09ZTHEvQP1FNPQdJBHiFw2UYbN+poP4OCiRL4jLE7CG9qr5i0zoGsmb6kpytgX6u3cu03hCNbdO6aSOGJEo6nDchRc5KB+os7D0dF9Q6THqZyFkHXlr0zNXZXym2xX4NyATPJm2dNDQkXH26vAHqxleBLd2BuLwDGL+X4grZq+1WhSo6fEehb4Vp8ZJbFYJ9Dx45i2tEJ++JYIp0k+p5F5SBgvCQJtrd2lTiYDTUhJ9PlwPW1zGHiW5ymHyg8MBxJE7twXmQNfRCjq2k0hc0kMI9nDdIzlL086kqYJl0UO0bT7gtcio0sZdsl18yRvXCV5RUu38XLZGwTO9aIGBpQwImrPDoLxfFj+GqZERmXhqt706jprIk6bIjGh1G4HYfSc9Q5eIDF9+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ERLazliHOIhpwDgzLRa2pV1dOn/gcySSe9SYfE9E1pe6rXjcXIRTR6L2IBw0jnB8HA9oeWfSX8Q34bsRLH2V19Myn75mKWqsgzReQLxIlxFdzu5jiVWJtwlJRMkA+jrvcwegESG7lI95pKpka+jsE7wLnc+wvDPxdVcWfNxGpza/fk81Ezdlbm/Sfxjud7HRyS0ny52ItJmfzjMbX1csGB3X0q2DkkK9Y7CeVB4kNjFvtWqa4TbMYXj9BqVl/Edx4S+n0K1WFammBJqML9rum6IxUwOQct+w/UQBgmPV6Wby8BQd5eov0GxzcMD2SIj622sr725kzshyuKVdF796/YdTKjCf/va60v0b+X529zf5f1xsreWIaJPMN0BDT3AcAoY5twq0SDIUddP8r1FeVn+SiY6KrKkVtq6PTqUiLNAZaUhxdyv1u/xM+96ub2KG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 16:17:34.7810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb3f4ac-cd4a-452d-3187-08ded530c37f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
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

When tearing down the AMDGPU display manager, the i2c devres group
was being released before the i2c adapters were fully torn down.
This caused a race condition where i2c transfers could still be in
progress during device teardown, leading to a NULL pointer dereference.

The fix ensures that the i2c devres group is properly closed during
initialization and released during teardown, maintaining proper
lifetime management of i2c adapters.

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

