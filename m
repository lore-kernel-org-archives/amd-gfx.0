Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4288BD2E00A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 02:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EF310E70D;
	Wed, 23 Oct 2024 02:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ghHG+ZkQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA0210E70D
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 02:47:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ufSUvgpMwbjtzRtFZck6T4k84VFusMm55qN4A3d6dEarThGqRfyo5k6qNJmX5OnzRKE2jngLzpUHaO3n3E1puMSi2X3u7glO9/qxbBVqjTm8ZkkUa5q6Nw/EOc1VuIMSJUWrK3AUnor1qlibN0+YluZ+HkTzeItpsjuEdt5FyrIuhfi8P3ZVtsddWJ9B38A2jBmqXnG7yun0YA3aBoJrDYbmcICCSXw45yAmUOmp1pkfMCASczZx/DYxEHWFZRY61RZHsLsvxcgitjfWgRs9iZsRxpp8HJ8F3dgIE+oU2GX0MVzZ/3CWzjA6E/YLHfXVK4SQLTC4rElu240rlR59sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHwktKSADJvM6jgIWw9igmfC9CC5XdeBCmb+Ivadjc8=;
 b=Ko0Lsdk/xXPp+gRqRivkWGOzW4sofN9rRnQJByMJkWw5PFCIg1s8czp1J4hwTncpJfkjMQL2pqqaZSk+w3RUUDzp+KZ8qNyAJC82o9BiNYoT8eHMK9eKd1tV3slpb+2uSbBy4Uw1Nm5sKuj/sbi8hBSXPD7aSEwty1IseoyNLMVt5mvoQRT9p8+6wJmmOodbH76scfLLPRWI6P3sycGvj33Lh7M7nnobGlEGnr0tcUqmOQQBJlnL0/8AyWHRve4K1+z+Wo/hkMivQfNxhE3QkJHIwqre9HuPFHmp3M4H85ZaEvv1zQ5hFmK6y+vhvhhUaHGNMAZcYl6V2h4rib6rsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHwktKSADJvM6jgIWw9igmfC9CC5XdeBCmb+Ivadjc8=;
 b=ghHG+ZkQKMH6dWxm+L1UTSusZ6DAjggQYAiEx2jmm6lBnizybWVfsX8CEBzpUL+FswCU6O2obz/6BvFSWTLwN326Pyj18kdDIMLHPa9qAoenJi4SYesvHq7pTGvOljjtRhwYsqKEovKniCcVqk2+jcb29DOC5Z8JXHvF+52xFns=
Received: from BYAPR01CA0040.prod.exchangelabs.com (2603:10b6:a03:94::17) by
 CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 02:47:17 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:94:cafe::79) by BYAPR01CA0040.outlook.office365.com
 (2603:10b6:a03:94::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.34 via Frontend
 Transport; Wed, 23 Oct 2024 02:47:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 02:47:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:47:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 21:46:46 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 22 Oct 2024 21:46:40 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>
Subject: [PATCH 5/5 V2] drm/amdgpu: Add sysfs interface for jpeg reset mask
Date: Wed, 23 Oct 2024 10:46:39 +0800
Message-ID: <20241023024639.2578878-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c801c3d-08c2-4f3c-c01d-08dcf30d01eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NM5NNMwoU+mR9xi2R9x/zxj28qRqLom7x0/gpmExb/O1rBzObrRkpa055dWM?=
 =?us-ascii?Q?SByUs1GOMeuJPf3LaTDZX5/CnrorGJwvyTWcguIyTBZ//0bAT+2ZAThugJ0+?=
 =?us-ascii?Q?a94QguGKJxz16oFw54bSXOqtsw4vuZIgcFOUdRPfbi0z1Js0KY/7ln3QTI2w?=
 =?us-ascii?Q?1oNb4rpVsB2nkC0Yt4n4J/nCMileI9U/NJVF4Fkhl+g4mKN5208jid5W619z?=
 =?us-ascii?Q?Pv1ya9VQhox+8nK9gu4lzCjxd2J9WBa1mZ9+OHuJ5jyKiKYcarf4Jyc5x3s5?=
 =?us-ascii?Q?zoTDmmwlYw1DxTWVb5rJNDqMhmtSHodcoypAdDIvrj+lKtOE7c3MIKvHK83x?=
 =?us-ascii?Q?ms75+e+Tk276VMqnuLGWoSKLBAS+7E9musf43rVK3q1qLoSD8cdxDaAYnQYk?=
 =?us-ascii?Q?mTnJ7Os/1P4jIw7j/FUASydjQWPPMqB3Nu/7oJ3vgIRBabPOvQzuHqWvIQbD?=
 =?us-ascii?Q?3Q/RJuj/MhNK0MbPz8OVIOCmJccd4wp8n+MkibUAVHSi78lMUHB+p3erCNln?=
 =?us-ascii?Q?+r1JlZc0UWUubDgvKfWLs5sNOVSJ57+XV478PfTRlMf73Rv+yolnK+8sOeVC?=
 =?us-ascii?Q?5GtbILkR49qzA3me5OTg4AVm/EoLb/Juo2K4o/T5YkG/NP0a2NVLrNB5Um/7?=
 =?us-ascii?Q?hH7TPhqoDKsvkx+QBEQzeiiyyBCs6WJYKJtfwajxoDr3mQ2JHA9Yp2OxQI9u?=
 =?us-ascii?Q?uV30thC3gaj8RypZyWeyMV40tM/y2dezEvX701I6KBeVVLUUolkcpgQTpZuy?=
 =?us-ascii?Q?3NLhl4wMPgJIRcxaC7qjZy1C9ta2VVIGwM81ipKyh3qww+6yy0vAuCxBVhX5?=
 =?us-ascii?Q?3Z37cBaKhNW7juZ1HVjMnW6uQt6Riq4OJxEZkYhKRbRpsqT2pIglmm/GsGR0?=
 =?us-ascii?Q?q80NTBRARMBdclHIqoxAgf1kcD3ue+27mDGC5eEVA4M8deusywa6bsNlUKSG?=
 =?us-ascii?Q?06ZUuZc2rTQRCbqnDj66bgrTNX4w7FtQCe+Me6n1fBDATrgPpK4fSD9/Yfwa?=
 =?us-ascii?Q?lvFXGihqu1KE3t8P8HQMUy46Br4W4yTGomIXq6nNAI9OvVn7UW5rVsIj3Cjf?=
 =?us-ascii?Q?mxhrf92KKDYUDkdBUN2nF6J5uQTIaGvH30QbkPwq28Sqsjf4eLyyMxjrq95G?=
 =?us-ascii?Q?z/acWjGriMgsTgKPl73C+TqjclL9kwvGLNNPukRgcUxmUwijRFH0rIs2K25m?=
 =?us-ascii?Q?a05UN7nsXq7cNhFjuhE6R3g2CUHDCYcBQAdun8LuOzl7JwC86lPx7EDglIP3?=
 =?us-ascii?Q?xU4sfuYDgjJ9C6rtbdWLcfrvp11khdnscc3oxVNV6W+3KELuMVFkrx5xvltH?=
 =?us-ascii?Q?7wqnVSNEWBcvCVDcYJxMpOpCWR1f8LGV+YyofDej8/XjAStr02kSBsqvJ/LH?=
 =?us-ascii?Q?ITzaHZMbmmsdhngLrGhg4af99/sb3whSICVAkTCil30Vho85ZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 02:47:17.0713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c801c3d-08c2-4f3c-c01d-08dcf30d01eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212
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

Add the sysfs interface for jpeg:
jpeg_reset_mask

The interface is read-only and show the resets supported by the IP.
For example, full adapter reset (mode1/mode2/BACO/etc),
soft reset, queue reset, and pipe reset.

V2: the sysfs node returns a text string instead of some flags (Christian)

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
index 95e2796919fc..eda71e9b1199 100644
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

