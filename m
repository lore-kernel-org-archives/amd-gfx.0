Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28EBD2E00A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 02:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63C9610E0EB;
	Wed, 23 Oct 2024 02:44:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fy1Tsh1b";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1BF810E073
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 02:44:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yl5+YFOMofObxaJ4wITboW2vT1FDsFD+Q6yRN0I1JhXVuVUUBKXM4vc15iamV+uPH3T4L8CwuYJDEIzhc9NfDZLfyJAoUgnbs3pzB3RTD0g0SO1saKm5NUDr5ODZ0zNaVOAvSPb6F9wP9IAnx1EOF7sfdk6XRnAevDHOeoh7Byjmq69Qs4BVSKnYsDuTxWumPxGEi8YLps+l8GTNfYLZlP06yWYeBqRt/EaCwED7qGFlBilvu9Cg8/gXUdEAwQQI76sTRUJs30Lrj2aAqTdXI2WFGmzl8DUMc65xardlURolMsMCRT1B3Nx7LaFhseE8OSeKz6J1U2FfVJ4YkQsSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8oFh2mgySpoB1yKRnkHgU1ca2u8zcb3YMwla/Md+Qy4=;
 b=PHtERsaaJUQd6h2aauc4WfzKSsFO6sjGTM9jw7OntPT6XPGAXqcuoVm+XOVWrCbYu9yEIOY64lXezQUV14aVOlh5epGKJNgVmWMsq0VUw8djMpKXtTAIKY886mcxJ2pU+mDAAqTv0bY6grsoVj3kSEyLdFMliXhfeTSiREOu4Hj7T6fZQrk/aOn9yOodlRUwwxqyqtNxfUgWpwF0/NvSSXzX9K43Kp7EzF+AOgfAD3tFHJ91n17bccEaWlH7iOb6/s5Sgc42SgwUK0J+Qa+v5bmTDtKWwWK2dt7S3E8YOKahRlWbIbOfl4gEUVUliCBHJDGZksdFoFbcmF5s6eZrsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oFh2mgySpoB1yKRnkHgU1ca2u8zcb3YMwla/Md+Qy4=;
 b=fy1Tsh1b9e+LwbTL2pbYrmnp/fdwaqaywF1mIPTD5u9z82m6/Im5T1JE4w4giusBb3hRN9ZrETqJjHoJm8FzwWgkRi1m9JZj8YuLcpU1kqxhypRcRwbwLTBNUU+6qT+3GHSY9Tbkk2vTTkE5MimZUIZmmkYLvDgDz9ktqbcXE70=
Received: from PH0PR07CA0053.namprd07.prod.outlook.com (2603:10b6:510:e::28)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 02:43:58 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:510:e:cafe::69) by PH0PR07CA0053.outlook.office365.com
 (2603:10b6:510:e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Wed, 23 Oct 2024 02:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 02:43:58 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:43:57 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:43:44 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 21:43:38 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 2/5 V2] drm/amdgpu: Add sysfs interface for sdma reset mask
Date: Wed, 23 Oct 2024 10:43:37 +0800
Message-ID: <20241023024337.2578496-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: ce8d4573-724a-4846-61b1-08dcf30c8b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bw673ZkDaW1vDEnSnuzclCjSzUmYcLlLwPAzY0L+pODNcIzwRpI00ywiM0Ko?=
 =?us-ascii?Q?qcz24rRi1RRl7kNQEge1gqVRBUcqsnxIDV7y1sCr1CzPEaQgVi8j8uaEUrI1?=
 =?us-ascii?Q?wbUhmRHjl71cMsns8TEBGWRT78tJdM3iIOJy4UaPHVsYqVwcTWTCeBfbb+DJ?=
 =?us-ascii?Q?u7AWK8xTeohlKf07Plz4NPvrHAdoNGI5MMeJy3Id+HZ0qeYedlmM1Evwqhu8?=
 =?us-ascii?Q?ZXg2kMJUoSY+hTyyat6PERIXl/yQlFRs4aCjPElM2JwkxTWLbSsBDr09awP3?=
 =?us-ascii?Q?kCcExHrHpjWEcndU8M8W8BFgWiUFho8ILrGPouFAN+8ECqhbagHKWncWbxbC?=
 =?us-ascii?Q?e1DO3M7UlE16ce7no3daIMK0NbLde011cODjQ0prVsDkb6JsxVwiYaJIn6L5?=
 =?us-ascii?Q?ImzlK6G1gm4ltDAY1o3I+2biT9vw6xy/elknYHrp+XRVEvoI0SthnKqpriZ0?=
 =?us-ascii?Q?nX+B+kG2b9Y4mPMQCf2fyn68vKNl/hEEqTTgOT+FTAHW3uJHSzGhrmYpXZcO?=
 =?us-ascii?Q?CY+4RCra2shlGX8nryCqS/TLu5U0d/IobKaHbRc+/qABWm0a+9bsu6WQP21y?=
 =?us-ascii?Q?/CW++VKc7yPvkAxcrc7jX45IpJswETCeT8mGEpBKkAbm3F3711he5ry2SEet?=
 =?us-ascii?Q?DM6/V7tEzpKTFtbfepWunF8Ps2hATW37ieOE0YVGnD6/GJ6Uj39Wfnin1qaS?=
 =?us-ascii?Q?KsdEY6baxdodFXlgZqEznzQLte5OBPAPQYxoy/slH/lv/pl4ikc09oEzuVKS?=
 =?us-ascii?Q?AEMKrNDrMCuTronAD1rMm/d0a0Jgdjro4pT2PU9lSZX5L2RPr1O7V4fjkABP?=
 =?us-ascii?Q?zLHb5G9UUTl2Azz/DWnowvn/KKVKvb4By0Sp8M8Um/vff/9Pawa7heeogTk8?=
 =?us-ascii?Q?tgwruUNXxN3Sa7AHNsxq+0edlYdxLXyeOT32P7m7j+9bzab6AxfFakTL99Ic?=
 =?us-ascii?Q?DnYrL45oyVa9HTUp527t4CYPwHiThbp5IhzcqgP6Ti1Ild89OoFFh4qBZ1mR?=
 =?us-ascii?Q?rMd7uG9NTAOfDKoRKb7QmkPOCSiJww15YF/NjM9TOufL2kI84fN5G2Dueywp?=
 =?us-ascii?Q?6La5H8558zr+33QuvuOVbZP+VkbJwSxj+HeIhsLB1lESwE5LyNM3fRAzbA5g?=
 =?us-ascii?Q?Qdq0H/eXYo5bvoiV7nZ8z6kYnuyCYIPB47yP/mVajLyGcce1CjeY85FPMCH1?=
 =?us-ascii?Q?CYiOPihSkUNU3RweESDvMiL1ZwTSnfid1P4Nxt7YlqRJGkiWFHa5HfeZqExX?=
 =?us-ascii?Q?gMgC3x4U+TDncEKyt9keuWfLnQt1CIwYcEXO+tUVMqojWp85G8m/f4YAHgLp?=
 =?us-ascii?Q?VNBW2PvlJKcyR4j6NBcaT3nL0p4uMyMZcqu8bzSMpgfOEg0GZP3EPFUFIEbD?=
 =?us-ascii?Q?HWFMebpuuH08l6toRsDo4jOi0l1vYlaih6Y8E5Nkzlf+a5hN1A=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:43:58.3188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce8d4573-724a-4846-61b1-08dcf30c8b6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
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

V2: the sysfs node returns a text string instead of some flags (Christian)

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 48 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h |  2 +
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c   |  5 +++
 10 files changed, 90 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 183a976ba29d..f20b7285f5fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -343,3 +343,51 @@ int amdgpu_sdma_ras_sw_init(struct amdgpu_device *adev)
 
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
+		size += sysfs_emit_at(buf, size, "full ");
+
+	if (amdgpu_gpu_recovery && unlikely(!adev->debug_disable_soft_recovery)
+			&& !amdgpu_sriov_vf(adev) && ring->funcs->soft_recovery)
+		size += sysfs_emit_at(buf, size, "soft ");
+
+	if (amdgpu_gpu_recovery && ring->funcs->reset)
+		size += sysfs_emit_at(buf, size, "queue ");
+
+	size += sysfs_emit_at(buf, size, "\n");
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
index 69fba087e09c..1fcf7e977143 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1149,6 +1149,10 @@ static int sdma_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev)
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
index c1f98f6cf20d..19fe25cbb24e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1926,6 +1926,10 @@ static int sdma_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1940,6 +1944,7 @@ static int sdma_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 2, 2) ||
 	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 0))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 9c7cea0890c9..320b1e63b78b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1442,6 +1442,10 @@ static int sdma_v4_4_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1456,6 +1460,7 @@ static int sdma_v4_4_2_sw_fini(struct amdgpu_ip_block *ip_block)
 			amdgpu_ring_fini(&adev->sdma.instance[i].page);
 	}
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 2) ||
 	    amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 4, 5))
 		amdgpu_sdma_destroy_inst_ctx(adev, true);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 6a675daf5620..00dcae89119e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1459,6 +1459,10 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1470,6 +1474,7 @@ static int sdma_v5_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, false);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e1413ccaf7e4..dab4210c4401 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1364,6 +1364,10 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1375,6 +1379,7 @@ static int sdma_v5_2_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 4856a093e23f..e90d9ab65017 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1367,6 +1367,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_v11_0_funcs;
 #endif
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1378,6 +1382,7 @@ static int sdma_v6_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	kfree(adev->sdma.ip_dump);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 24f24974ac1d..650bb470426f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1317,6 +1317,10 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
+	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return r;
 }
 
@@ -1328,6 +1332,7 @@ static int sdma_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->sdma.num_instances; i++)
 		amdgpu_ring_fini(&adev->sdma.instance[i].ring);
 
+	amdgpu_sdma_sysfs_reset_mask_fini(adev);
 	amdgpu_sdma_destroy_inst_ctx(adev, true);
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
-- 
2.25.1

