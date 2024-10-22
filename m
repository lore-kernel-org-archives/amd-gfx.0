Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694BCD1CDAC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 07:59:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AB4810E602;
	Tue, 22 Oct 2024 07:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y07wbSnL";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E12A310E601
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:59:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQtGaWLoNdGmr3XzFmoa6FeG9HwwUGY5e29kHAm4LzUSFDOqp1t2Lx8639BvaY5mBvALTBvksxkZmLja8+TvUGeNJos/7Gvi7bPpCBuuOzREEF5i1usTyWaDyG/NMCeYjD5rFtICIeFSLlthTmm4nOl7oqaT6qLQ3j2op2/se+/LvUxefl2QgAVm8if4QsClxKCn/y7a/c80OtUfn5Sq8ay79ZAMmJJ6nsHW4lYptzZ9hzBxzMUVhpeOX7t/0TnNfslRkifXhD7x+dX/Q0rB8hXkqISO+I+fCHiNH8YKSPAlJODKvmJWdLOzIDgiKhnJmwfv6jVJO08dRkZnStExlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+L57OWT/+0n/oxvDjm/mCrp/+6GFUyDa4q/5uIl2vfw=;
 b=Z4CqCsf2lgdrjfJ9xyLGmyZzfFZruyrZ3+UqyX4frP+tK0e6uQ9Mvs63pTgBEJIsaq6Cv/biaIQaB4rHnGKJKnuqMKA8ftN6tberj2Dz1pQTB33EqDGQY/KBWheMntPCrQ2OTEL4VHS2yBD2IsNBknHMWUaTofZsdzCynsWcmTbhsrifGybhZXlUD4fvf+n0Oko8lbyez4VqWuxaPx1287e0in7V4PcnL1RilPkXgxg9vxiR5gdDphM+tezlQw/j+2R/KHyAGxd5rILS6zdDrWIeE2Cx33iT2XZK6OmUu+0iohpzHNVCsPESSD/kOOpMuRf3AWtSc57fGUxJS37ytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+L57OWT/+0n/oxvDjm/mCrp/+6GFUyDa4q/5uIl2vfw=;
 b=y07wbSnL3Qz+2VB0OXSHkUnzl0qiADO/qZ2slg/uAXJs8SkuWB/TUEpktJy+VYqvT3H3Ab3EkwysXb68bPFi6MHyVwPZ1Dq9NdPvHHkN0kdpDA5XfwlFqSsePh2WJgz2HftVZWn5NLd3YghHePSHLRxc4PbUQPMTb6uN1U6nawE=
Received: from BN9PR03CA0746.namprd03.prod.outlook.com (2603:10b6:408:110::31)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 07:59:24 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::90) by BN9PR03CA0746.outlook.office365.com
 (2603:10b6:408:110::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Tue, 22 Oct 2024 07:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 07:59:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:59:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:59:23 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 02:59:16 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Add sysfs interface for sdma reset mask
Date: Tue, 22 Oct 2024 15:59:06 +0800
Message-ID: <20241022075909.2530386-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022075909.2530386-1-jesse.zhang@amd.com>
References: <20241022075909.2530386-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: a84a424d-dbac-4cf3-a654-08dcf26f71ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zpWH1JIIS5wffvKxTxsZz/0BgSX5KltzzCiP9QREwxNL9mBtJZs07d4Gwhpg?=
 =?us-ascii?Q?c2/tuX/234nddEhi5DUVTglmLgPDGl1aQbAF7DxFnYhS3VCF8kd8Q+b5Nl9Z?=
 =?us-ascii?Q?hvbW9Z6kMimt+x7puTE6Xld7wL5CPJrYuaqsG32mK7iE2x0z95zw/Lt47OnQ?=
 =?us-ascii?Q?CEfmsZ1gj/sdhJCXIZS89vQiK14HnQ89jenYWQpSjE+uC4SmiNQOfLJW7Qng?=
 =?us-ascii?Q?jf5CHoTByh+c43zIcnF77A4/V1NA9aqgSSbdd9bXppe650YoFW8/rocoypQO?=
 =?us-ascii?Q?4hwiYAj5WS/2cV6mFXoxZfDnVg9yrNBKCfqZFqMdYoN9P3uln7+nDwAlGZEB?=
 =?us-ascii?Q?ta4lzvI3++pSPTKBTZHDO+QsiOErQU+DcE7IZAeAMrcBQnE0sT7bG1VYeMK5?=
 =?us-ascii?Q?6L057va88m/AJ65lzZqIYkp71Qy0uSSeqRy9c0X1gLLWI/FKraLcQnTlNNOP?=
 =?us-ascii?Q?/5Y90DlWhP9mexnxYs0mhPg1Z7kG7u3eQ2eh/RgzCtkM3QMFssyx6Or7lwdu?=
 =?us-ascii?Q?XjdiddKX8yutvoZNHccatLTqx+kzDvErf161HcrNggPlXSATXRK1k6bMgsUE?=
 =?us-ascii?Q?+42dbvNqs6kBsIXCk/vs0uOYYCZRLFfm2/8wDq1B9gaDjC9tEaJiAa6BoKto?=
 =?us-ascii?Q?/kD14X8Z/1NY+l9r9FTVClEZ9GDE/vnAQuVWRAot0EAHN6w525iixUhwLjQG?=
 =?us-ascii?Q?mgO/tR5CG38vOGBMdd2HykQFv0P4BpHpAARDLykXlIoNJqNkS1vwflC0O+yD?=
 =?us-ascii?Q?XJyDRqHR/St706PqSyn35TnEoX99O9PyyA1cZzT/pxVxAtBzGDWanLuqDU5G?=
 =?us-ascii?Q?my6ihHpGaV/c3w4OVB6xMRbsTsg2N4xj+a9ZOp2fETZaP5dQFSKh+uYpwqnB?=
 =?us-ascii?Q?Plu/WFTvWd7nWhpigE3muDbVPwlDaatiLDTP3xQkwUuVSMx65dOLxHZIXDYQ?=
 =?us-ascii?Q?2ZJWaareoAyZw604F3BEmXs/DNY6dXQxUA5l6iR7jgMW4uareG8ejnp0XpY6?=
 =?us-ascii?Q?N85y0+b46cBuUyOMyovehgLPBr73F7heUaDF17X9f7UkSqqNMTCBHTMLQm04?=
 =?us-ascii?Q?gl5eYLYlJ7DsqgYgNeRyDenCmF/sCdbmezRQbPgG6/xWq0zN9V1d5TCwsPxN?=
 =?us-ascii?Q?0t7gLDd9CXbJgpM7UihYA6n5yR2f54YeyuwQK4NX5IZdkG/mFObNy/tq7zD5?=
 =?us-ascii?Q?E3SsC/20Sbnohod1arhFt4ewikH9e6Cnf2PI6s7E1CVY0w7wpIMbmucfL158?=
 =?us-ascii?Q?aEgZBBHDZTlx7SpVGmkkJ0EKENVlZQLX9U7j735gVyahcTZAK0yWSWdxAIAu?=
 =?us-ascii?Q?+3ASyzFDAPFKgMuv+9KG/Ev5yfWTvIaWkS45KtL3E/qkqF4z/BYbUy/oBgcj?=
 =?us-ascii?Q?s6gEVxvsg4LF/EfhFY1o9PDCMTjDHiSYSQnfgWLM7Ua4XAgq/A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:59:24.1483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a84a424d-dbac-4cf3-a654-08dcf26f71ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
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

Add the sysfs interface for sdma:
sdma_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 49 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  3 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  3 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  3 ++
 10 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 183a976ba29d..90156669ac66 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -343,3 +343,52 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+static ssize_t amdgpu_get_sdma_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = &adev->sdma.instance[0].ring;
+
+	if (!adev || !ring)
+		return -ENODEV;
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		size |= AMDGPU_RESET_TYPE_FULL;
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size |= AMDGPU_RESET_TYPE_SOFT_RESET;
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset)
+		size |= AMDGPU_RESET_TYPE_PER_QUEUE;
+
+	size = sysfs_emit_at(buf, 0, "%lu\n", size);
+	return size;
+}
+
+static DEVICE_ATTR(sdma_reset_mask, 0444,
+		   amdgpu_get_sdma_reset_mask, NULL);
+
+int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->sdma.num_instances) {
+		r = device_create_file(adev->dev, &dev_attr_sdma_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->sdma.num_instances)
+		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 087ce0f6fa07..3058548d0733 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -175,5 +175,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 10fd772cb80f..bd04310cb2b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -863,6 +863,10 @@ static int sdma_v2_4_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -874,6 +878,7 @@ static int sdma_v2_4_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	sdma_v2_4_free_microcode(adev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 69fba087e09c..9d9dc29132e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1149,6 +1149,10 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1160,6 +1164,7 @@ static int sdma_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	sdma_v3_0_free_microcode(adev);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index c1f98f6cf20d..c06ab97ec2b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1926,6 +1926,8 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+
 	return r;
 }
 
@@ -1940,6 +1942,7 @@ static int sdma_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 2, 2) ||
 	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 0))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c7cea0890c9..02e906ecd6fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1442,6 +1442,8 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+
 	return r;
 }
 
@@ -1456,6 +1458,7 @@ static int sdma_v4_4_2_sw_fini(struct amdgpu_ip_block *ip_block)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2) ||
 	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 6a675daf5620..80c2ce5d9e3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1459,6 +1459,8 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+
 	return r;
 }
 
@@ -1470,6 +1472,7 @@ static int sdma_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, false);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e1413ccaf7e4..089cdb4aba0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1364,6 +1364,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	return r;
 }
 
@@ -1375,6 +1376,7 @@ static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 4856a093e23f..68d42cfe8841 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1367,6 +1367,8 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
 #endif
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+
 	return r;
 }
 
@@ -1378,6 +1380,7 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 24f24974ac1d..6cd01b352313 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1317,6 +1317,8 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+
 	return r;
 }
 
@@ -1328,6 +1330,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
-- 
2.25.1

