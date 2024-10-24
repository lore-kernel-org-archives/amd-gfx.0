Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4072BD0BB66
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Oct 2024 07:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D866510E8C1;
	Thu, 24 Oct 2024 07:39:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="soF/wt0D";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9C210E8C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Oct 2024 07:39:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR0DN7BTbJ4U8msNQb55EcPx2P4HRAcnpMRIRjwU9rJc54CPsW5t2eWjiatpyC12xJB/aLApIkVLeINJvsZTp9VKHNU0VAj1erOVpbZkOp3jQOdEBLBH3Dd8yLQBRWEqwFqcyye6gNG67CRPF1i1ZmwoxpbBaCtJa7puEXKtCTVCTGWXu9nSi5mSuG6Eu2k0deKKXTMvPkh0mCvxg+u7+YsXLClDrmz9lyihDDMpLFTvgPXAZNKU/QA7eV8lfH3KEMkU1jQmUAa3dYhvQ5Itvop0OsodCAo6wewt2EEJYu15CSIUnXyQfmKIqM3wKwKQGPZyboVPppOb6FvAg/8lzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VxjM07UfQavzvsL/5XpHq5b2Lv537i37WpTMhgim18=;
 b=Ve3uMOOrb1OkSelJ1z/Ql+oT7lSQo6Ef/7YYIaUrM5xi4JssyJvvMUvr05b3eoneEkNJNKGkOhvukVp5fW4oUbwguPR5/apBO9rsRoTPc4d3SWCvMsthfeOVhziQUjqGPeXXXqtKDHbYU5epM+U+O6kt5rVAwz2gEHTCxFcYFoE9NVneqsY+2K0eBryL1M4XaysiSaDazIHaQB4t76v/N9Je1jZcv67MqSKy3p0WrohaN6zDhTO6SjBBNZJnDLewp3VLME8L08f3bA5nYyhcn2MqhA1nADDAt+6fHp8PD7L12FXWviUYsD+hxhXagu85pA0Bg6sLnoTE+xcMGn6VNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VxjM07UfQavzvsL/5XpHq5b2Lv537i37WpTMhgim18=;
 b=soF/wt0DyXq3DxeE2M3O6yybOuPPWALeqrs54DIc6wkTRYBMyG4ib8dq1DZwe3wGhutd2fjUKGfrqSQdzJPVFvOzp5HRN0vtymZPhnzLEg8HdlH0Weklx4Ue95R6XRlO6CebpBLOzaLD5xlQw9UkrZlF0r/b4xC0AJ30W94cYbU=
Received: from BN6PR17CA0043.namprd17.prod.outlook.com (2603:10b6:405:75::32)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 07:39:48 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:405:75:cafe::c3) by BN6PR17CA0043.outlook.office365.com
 (2603:10b6:405:75::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Thu, 24 Oct 2024 07:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 07:39:48 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 02:39:47 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 24 Oct 2024 02:39:41 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH V3 2/5] drm/amdgpu: Add sysfs interface for sdma reset mask
Date: Thu, 24 Oct 2024 15:39:30 +0800
Message-ID: <20241024073933.2709389-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024073933.2709389-1-jesse.zhang@amd.com>
References: <20241024073933.2709389-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: ce7d5bd4-9ac0-4bb9-2aec-08dcf3ff0980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?czBPVaSzI+QEm2pB/cVo/J0gPzR5nyU+HHRWgVskJaAy93eXk/KL2BFai9CR?=
 =?us-ascii?Q?G902n+AlgaNK71WStN6cOpJ5smOcazkCB/pP3w5VfE3tYFnpLskEHXXZpwUH?=
 =?us-ascii?Q?Ww9rWYnLpMFIsFTE9f90BVKrYZqKaBai6F9mI1+YDg7sXS3JSwGSpdOjqnMi?=
 =?us-ascii?Q?YZNxzHRc6py/l0LeOS4uQgRrBL9kT9sSKmI+215f+so0IWlfRcXgZdFHzoro?=
 =?us-ascii?Q?FPhxxO1b0Sv4mLNGiaGpV+z2lp7mxZmi8hWgoz8WVtUelZ4849k9Ji5DnAoS?=
 =?us-ascii?Q?dHasTh83a+mIUB4VbeBlp//hwgWgW32/Zo6MjnT7kW3U8a/3pOMgREfMJDHl?=
 =?us-ascii?Q?v0zchKw3Kywo6lCPzjzdhPpUuwNe0pCYXktyXBuYQ9DFjAxM1lFrljGY0OAO?=
 =?us-ascii?Q?ixBRoC4cv+9SnNik3c8YchVpyrd2YVcg6pfktROfFAbMzYhSqtX2BuMDsnX3?=
 =?us-ascii?Q?oLs7xJEA9QIT4/JLMID3uaRXDiNYmF5UgNLWCJTGn+wqmFa9Zwix/8rqI4Mn?=
 =?us-ascii?Q?+ey7MSGvUIkXh8LHUbaQbOzWPnLEJL5NoQpFSoDlpzlwDS8P709Z1n0PrmZL?=
 =?us-ascii?Q?Aa/LO+EQc60CPwDBqiLRpRrKksbPxXuQ4rB5FLPluAdC3x+pljXnKnu7Cbh5?=
 =?us-ascii?Q?IYVN21QfhfJqE0Is4pEIgM9u7Mh60g/XRhpJrlCSmn41hD2W562Kq8pUzrkJ?=
 =?us-ascii?Q?qzWPMHHWyFH+UPBUq16j1KZ/pgBRFcFtKvq1xTVj9iQegOeFk2LM9noqgwXu?=
 =?us-ascii?Q?etIdSPDNCBKXNaAwhnifd7BGlPieb/JpUw0R6++7p9vL4EONCld8gizdHbC2?=
 =?us-ascii?Q?tuOS46x1/8Toq8G4yGT0XE2aFUVEtq3DkjX3m1LIooZuXFXl94kVOBTgZ6DR?=
 =?us-ascii?Q?fwoIRlerG3Ou+Cuj40lqBYeaZ/RrhVfBYtXRRfgPs/JKruStHRkWqBAbnAY2?=
 =?us-ascii?Q?mOgMCmI/1t1hA2mECxgL4qisZuiyU0BTpqGjNCzJEzLk6oeQ6hm6c0m/5bKE?=
 =?us-ascii?Q?ouWVPSzOzOZyzKVWktz7ttSKWd4UOf/PNN8tSBpRR3UYoxCiko+5emXyaFrm?=
 =?us-ascii?Q?vgBcOah4CeiRdYsQDQgCx1ZJfBYP79HRM+0lKA+lcckrtzes9s7Z+gtNBOXX?=
 =?us-ascii?Q?dE2CvYU2pkX7dfkpHdhpen6i9EWwyQNWYuXma7IGaCP/1I2SR8F+lQ5++V84?=
 =?us-ascii?Q?c274fkCham8wmrm3gwubijNte1f9jmBxXVCe4K2AX/RJsL1/QhkB7CBgl7fe?=
 =?us-ascii?Q?0UjR/0FsCqWLFpb82IRaTjXih6ChiWSXkwqMapwwn8uhpuGg4hUKS5bYdZ2V?=
 =?us-ascii?Q?q/jHE0CxsozXx2BQK06/Hjd2h2LbA2Q1LOA+RWosclTFmS5Ph/YJpxRRUXA/?=
 =?us-ascii?Q?AaSyK/a/HB9hDZxrXT2inXCLhNjCShziwbtbE/FVqspVGjjKjA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:39:48.0591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce7d5bd4-9ac0-4bb9-2aec-08dcf3ff0980
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

Add the sysfs interface for sdma:
sdma_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)
v3: add a generic helper which takes the ring as parameter
   and print the strings in the order they are applied (Christian)

   check amdgpu_gpu_recovery  before creating sysfs file itself,
   and initialize supported_reset_types in IP version files (Lijo)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 41 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  3 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   | 18 +++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   | 23 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   | 17 ++++++++++
 5 files changed, 102 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 183a976ba29d..7edcd989afce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -343,3 +343,44 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+static ssize_t amdgpu_get_sdma_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+
+	if (!adev)
+		return -ENODEV;
+
+	return amdgpu_show_reset_mask(buf, adev->sdma.supported_reset);
+}
+
+static DEVICE_ATTR(sdma_reset_mask, 0444,
+		   amdgpu_get_sdma_reset_mask, NULL);
+
+int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (!amdgpu_gpu_recovery)
+		return r;
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
+	if (!amdgpu_gpu_recovery)
+		return;
+
+	if (adev->sdma.num_instances)
+		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 087ce0f6fa07..7ce613de7ee0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -116,6 +116,7 @@ struct amdgpu_sdma {
 	struct ras_common_if	*ras_if;
 	struct amdgpu_sdma_ras	*ras;
 	uint32_t		*ip_dump;
+	uint32_t 		supported_reset;
 };
 
 /*
@@ -175,5 +176,7 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev, u32 instance,
 void amdgpu_sdma_destroy_inst_ctx(struct amdgpu_device *adev,
         bool duplicate);
 int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev);
+int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 6a675daf5620..728643efe203 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1452,6 +1452,19 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+		if (adev->sdma.instance[i].fw_version >= 35)
+			adev->sdma.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
+	adev->sdma.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
@@ -1459,6 +1472,10 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1470,6 +1487,7 @@ static int sdma_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, false);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e1413ccaf7e4..38cb5ebe1b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1357,6 +1357,24 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 4):
+		if (adev->sdma.instance[i].fw_version >= 76)
+			adev->sdma.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	case IP_VERSION(5, 2, 5):
+		if (adev->sdma.instance[i].fw_version >= 34)
+			adev->sdma.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
+	adev->sdma.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+
 	/* Allocate memory for SDMA IP Dump buffer */
 	ptr = kcalloc(adev->sdma.num_instances * reg_count, sizeof(uint32_t), GFP_KERNEL);
 	if (ptr)
@@ -1364,6 +1382,10 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1375,6 +1397,7 @@ static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 4856a093e23f..97c837dbb135 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1351,6 +1351,19 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(6, 0, 0):
+	case IP_VERSION(6, 0, 2):
+	case IP_VERSION(6, 0, 3):
+		if (adev->sdma.instance[i].fw_version >= 21)
+			adev->sdma.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
+	default:
+		break;
+	}
+	adev->sdma.supported_reset |=
+		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
+
 	if (amdgpu_sdma_ras_sw_init(adev)) {
 		dev_err(adev->dev, "Failed to initialize sdma ras block!\n");
 		return -EINVAL;
@@ -1366,6 +1379,9 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 #ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
 #endif
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 
 	return r;
 }
@@ -1378,6 +1394,7 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	kfree(adev->sdma.ip_dump);
-- 
2.25.1

