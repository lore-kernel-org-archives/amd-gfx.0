Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1069D1CDAC
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Oct 2024 07:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A15C710E604;
	Tue, 22 Oct 2024 07:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BwCf0YSv";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06D4610E604
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Oct 2024 07:59:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+Kut8WmtFfLGN6pXMDsgF9soKWKPDCxskHgy+Mx63v/R1CfFKfYS11ZJjhcIttwMGlOu8jR1pTADuys/Ld0NgPz14+L3B3LPvdBq4oPcY17RawNdwCudMv+npAgDrfFlmbh1nk/FAFj+kvNrfcjWGbmhFXhB706DzGGAUWa7yGAVF04w3QL5MwHY+iDqSpuf1Usjvg6XmTXJPI9mH1kcmzmBtjYl+vjOjOKDq2UQtH/AR4fk2Mv1sQceFD4h5/11zbbrWuRqpzzU8z9ZFf44r7gusqUy2xAJtwi9sfs1osTkcJiA2/yfS3hlrLi4XimBX2c1bm8nc+eBSrqzDMwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz45A0u0B3M0p26jDgEqidMiTsw/UGbpS2wlpvjYfZA=;
 b=IVFJkPTJ3ufErm9EQhrJhyI+79Qw73GQjYujBGYF3odGhrplGs1brlJUoNyhyIbAbZoX8p2NMZowZ8A99A3jj8Tq3AokSLd9PCNUUFrb/CQwFdYGotI3NAyqW9YWOjTIySlx6b/OuLM1wkyGqUf7AsFhxbPFYZ205fVIelLuiQTkj90WzD1fOxh7+EcwVKfnRKe1IOzIpLOTn7kD5BmP7TwsvGXcHk7DJ3W7HJhVbBrRV6DtREBapYM+hPgGNqB+vD0X1EAgbo/5HrY71ZdrJOGx2ID/XHJevBe8Brz1RvnnWSQ4Kri70U1nizozSBHBe8xOrOlM2CO/4Xu7hTvpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz45A0u0B3M0p26jDgEqidMiTsw/UGbpS2wlpvjYfZA=;
 b=BwCf0YSv9w0spYre+Q7bcj1eNkim5z9GWH2em6n4dgyenUlFL18FAuUH4QDEtyD82I7gLhBmfZsgVlKDg/pAziJ7F5jE6fP1qwTZLWngtZ3JolhzZ1ZN4XTNweCvSjI7+5pYHMHNBarLiOQYELZCyRvHPafrwn9q6TqWt0ZAq1I=
Received: from MN0PR02CA0029.namprd02.prod.outlook.com (2603:10b6:208:530::32)
 by PH7PR12MB6738.namprd12.prod.outlook.com (2603:10b6:510:1a9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 07:59:45 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::74) by MN0PR02CA0029.outlook.office365.com
 (2603:10b6:208:530::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.30 via Frontend
 Transport; Tue, 22 Oct 2024 07:59:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 07:59:44 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 02:59:43 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 02:59:37 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 5/5] drm/amdgpu: Add sysfs interface for jpeg reset mask
Date: Tue, 22 Oct 2024 15:59:09 +0800
Message-ID: <20241022075909.2530386-5-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241022075909.2530386-1-jesse.zhang@amd.com>
References: <20241022075909.2530386-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|PH7PR12MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fff372-581c-4ead-fbe9-08dcf26f7db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wccp5GRy5L9gi1eMIExfZ8VBiw9Zw0SetcAcjG+huHTTrEhc7lNjVT6YSlC8?=
 =?us-ascii?Q?l5LV45u81otwkH8IFSsekcXC/WBMo+bfyJAEGpmPMV7Qdj21Bc+qG9lNYOgR?=
 =?us-ascii?Q?uIj+0Rb1eYxS5bmhi+DE+hGibi+UpCIGTkw9PmLT22xZSuMl1xbLPD+IynS9?=
 =?us-ascii?Q?cPhEZ4/icGMaC8hTl84l7AIDjP7trv5PW/LupLvCbhbt/f89AI4Nsjru0gDy?=
 =?us-ascii?Q?i0TqoBYV0WQzZtc2gQEOmOAHs6ALs1VRD8NLkI3Ih4mQpFAWXDiCddoeI8Is?=
 =?us-ascii?Q?KV8LD9GkVTpV6yRjyS3Z1dV8sqhLI54T8Dj6Iduz4r3LxoWbXfQWRHxyqUPI?=
 =?us-ascii?Q?2pcqEKvtGg2UakJQmr/JJe7gEaCwaEvbs8xpUy297zQvAEag564/3o/OP2J7?=
 =?us-ascii?Q?/Lb7Q6bg/6Wk4635BmrLqFKIBtKaj4kj/qFbXYomut2Y7l6noIVSwHWCi/lr?=
 =?us-ascii?Q?Xuk6BfN1HBbi5gYD1LB8YDvUYwyAxK/JVCtzMRCKMZa01bvB2TOOdz+E+ZL5?=
 =?us-ascii?Q?YSiuRR5bn034XHZqHMr9weVdiJlaxotDChjSvZdROfw2QtndMels1JEFbXld?=
 =?us-ascii?Q?xT3Tyk9zWPylRmtlLo/hktCnj7+VtvP079eOzBm36ExVAzvbm3sXBpiqPy+Q?=
 =?us-ascii?Q?wze6J+d5tSjougFN/+Jaz/8Dy3+I24kTrkuw3g8gF9/QY7CbJEHsdGmvjtO7?=
 =?us-ascii?Q?/r3BfCWSyS+8tkZuLYTFy4DtVLqNfheshlDNIz7x7nlhqGg0V0FN8lQRntIE?=
 =?us-ascii?Q?euRp6bMHN21ah0as+v15D65ATC089HF/ddQsCr6qqYsJo6QuCCyxSZpBDC7v?=
 =?us-ascii?Q?VZmJ5XnvQBHdviGgNpIUwy7V7Qq7e/Io4/6sIOJ6hw0ob/OaNd5jajeYpru3?=
 =?us-ascii?Q?7B2cVmavCFwlJaGbEetCk0Vjw45TgHj3QH1yB1y+9t5Q60E4MPpE7LO3qAl2?=
 =?us-ascii?Q?X31XE5Q6H5kpx6PELgU3AsPYrB/eBM4KF+aDmQ0zb3irTvC1wzzV5MnmifBB?=
 =?us-ascii?Q?7QX6OILPSP55xNVAEpMe7YQ95hUXuonYZYric13VtbaZit0W7fq7bOByS1vu?=
 =?us-ascii?Q?v6flrzAi5SWQ7lo9q+I19cHK1TFPcJgNqBs88oYSYizVj+6kvL/y4vKxpn4n?=
 =?us-ascii?Q?s8JERMuxwoq90B4FcoNUotM9NWNhqHGOv/YGshdaLg+tQQMo4GQzZshA+ixV?=
 =?us-ascii?Q?GaQ+3o2zPkI/bGcSAxIA1zxQo6fQSOuA/w1mqixPsn9tDVStjjPoO86eaVkp?=
 =?us-ascii?Q?/WLA4w4O7KLXKGt044LKLDNgk8qcXmSGG8E5PBjkfC2Ol1utCFotf3O72ZFf?=
 =?us-ascii?Q?ZK+q2lFZB9MaSUOX9590g9DV6vF3O4661G/sappw7FIEkbSd5RUTGPe8RMGc?=
 =?us-ascii?Q?DCBpu73UCPsXj6qn4Y2S0bYyDc1WOb9dV8LGWP9nzbY7OKjR2w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 07:59:44.3709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fff372-581c-4ead-fbe9-08dcf26f7db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6738
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

Add the sysfs interface for jpeg:
jpeg_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by:Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 48 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  2 +
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   |  5 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c |  5 +++
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c |  4 ++
 6 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 95e2796919fc..34742232af47 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -415,3 +415,51 @@ void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev)
 			    &amdgpu_debugfs_jpeg_sched_mask_fops);
 #endif
 }
+
+static ssize_t amdgpu_get_jpeg_reset_mask(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct drm_device *ddev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(ddev);
+	ssize_t size = 0;
+	struct amdgpu_ring *ring = adev->jpeg.inst[0].ring_dec;
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
+static DEVICE_ATTR(jpeg_reset_mask, 0444,
+		   amdgpu_get_jpeg_reset_mask, NULL);
+
+int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
+{
+	int r = 0;
+
+	if (adev->jpeg.num_jpeg_inst) {
+		r = device_create_file(adev->dev, &dev_attr_jpeg_reset_mask);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
+{
+	if (adev->jpeg.num_jpeg_inst)
+		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 819dc7a0af99..f5e1c98a4764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -150,5 +150,7 @@ int amdgpu_jpeg_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_psp_update_sram(struct amdgpu_device *adev, int inst_idx,
 			       enum AMDGPU_UCODE_ID ucode_id);
 void amdgpu_debugfs_jpeg_sched_mask_init(struct amdgpu_device *adev);
+int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev);
+void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev);
 
 #endif /*__AMDGPU_JPEG_H__*/
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 20e1fe89c463..c0b86a742a94 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -124,6 +124,10 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -143,6 +147,7 @@ static int jpeg_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 2a53537db135..2a25f7fffbd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -159,6 +159,10 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -178,6 +182,7 @@ static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index ef2d4237925b..0e06c477f6b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -153,6 +153,10 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
 		adev->jpeg.inst[i].external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, i, regUVD_JPEG_PITCH);
 	}
 
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
+
 	return 0;
 }
 
@@ -172,6 +176,7 @@ static int jpeg_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 7954a6fae464..9190572a9302 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -100,6 +100,9 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
 	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
 	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
+	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
+	if (r)
+		return r;
 	return 0;
 }
 
@@ -119,6 +122,7 @@ static int jpeg_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
 	return r;
-- 
2.25.1

