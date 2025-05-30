Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA35C5B555
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1151310E832;
	Fri, 30 May 2025 09:04:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PqIWy1d5";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2078.outbound.protection.outlook.com [40.107.96.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44EBF10E81C
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRb+7m6D37kO/m9phVwRg8Gv9fmrMeTFTzJL+lKTIg6UQT6+6zUqlKC+f1MArY1cnD8DzGTkVaGHIrL5RYXDJC+IA1gdFC+WDaJq5SPANE6EYLQqmOefal76AkR1lSZSK61Ct9Japb4D/Dfi5LqVmzM5zRABkizLfg21ij2IG0qmRT5rm0OI4T7lWXPX1dGiw5TQ8f9CpXbaAmAsaOFRgl0UKCOF/5JqHiDVrlskOI7Rp/shmUC4S0yIUQ6SBZ388CuGxfJBBY+sQTaIaz2u749SC0xDIoOpYwrqbt24vDwsK0kDcdpJK29Zf+E19ayKrMcdc2BOCQy5KuM3Z3L7Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/gTfaORjaBCIeCC6Zpcn7VRYhuJGxTcO+e9aLSwplU=;
 b=K7zGNeMNyugm8ToYNHyav3KDRgCAJ2XueYgcSzy+yEphTwt0fz/RNqYK7Yvz1F4uVY4mCABpuZKelLW3+LO+AhPn/lvbiQSjau+SiAu45tipYqEDdcWHEUMEiJL34CL/tsqQdsOGR5m/Y/Jl7GuBsZ+nvDEm9MiqDv5PCuBOpkr8am0Q9EjgjwF44JQCwAM1kNkwW0guYvpUEYQPJA4fOaPQgUrnpl7mCdE681ruWKwqY6t/1kMbH1um5pWQSI9IrUtMAQrV+d7lSEZDJ88jN4nv/Voesi7nbV6OaC3oNneBB1Je0TwseQF1C+FZrj5NpAuXmYhx+8n1ss7R2N4VgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/gTfaORjaBCIeCC6Zpcn7VRYhuJGxTcO+e9aLSwplU=;
 b=PqIWy1d5GhDI2XOtXr96EqXCvNSVg2Em7roUT6lwO4zzLiNcMm07fAEthWBbSyokdhL3YxJCLfW2uUVDYlBdH5nk8g2imdeTpVlmpUEphLnmucc9CBFVTjBHl6EVo6sxedTdPwpUBS6EbnIfLTJqvahUmWSjcp5T2MYi2rN5SvE=
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Fri, 30 May
 2025 09:04:30 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::87) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Fri,
 30 May 2025 09:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:29 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:28 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:04:27 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 12/14] drm/amd/amdgpu: Implement HQD PQ address retrieval for
 GFX12
Date: Fri, 30 May 2025 17:00:13 +0800
Message-ID: <20250530090322.3589364-12-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d7e38d-815d-47fd-97f0-08dd9f58fc82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9J/KTKcc/DZiDapFBDu9V0sHxCox7cIXajxP8C4KUn0bxo4ai9jfaJqXeVge?=
 =?us-ascii?Q?7KCGEC0CNvEAFVAkOwTHb9ScFKciG6cDdFYXJh84dJMQTfHEIimHg9oOFdO+?=
 =?us-ascii?Q?pJcues3z3UGfeDa43EmAvZH1sTjFKZHJ8WoKFBRT794QtTkbunYHDZlE4hCd?=
 =?us-ascii?Q?Vi8viDbYKIB2qmrgnzTM2DcG+AgXUFm/EAjzBsdITKNGeJ/BNQWzgTqzLoa6?=
 =?us-ascii?Q?YOyaCdFdmYaT1Da4vGU0o+H4WxdpienoQm7vPL2fG4OgUzsi4Cf/aUIY5xjw?=
 =?us-ascii?Q?SdY6rSLSAduvPa+LUB4JeHclYBeSf9kuGDgU3w+5ytZqLSiqP1yXM7Qcqf3U?=
 =?us-ascii?Q?x2LQCF+eoDpwmrqrl+ovxFkOCMpwvetBpU4w+oHaiQxyzrl/EkBwyHnJL6TB?=
 =?us-ascii?Q?PHZHMZnLthSgcFmMXc6ksW3b63pEI/eB8X9ukL0dODjIgn0469NJKHCgZlbX?=
 =?us-ascii?Q?REctCj3tsUVeAVmh17pDM7rOaKhBJA7wB5X0kvM4X6wBPtBW0Ggz0MWJiLGx?=
 =?us-ascii?Q?hesF9CdZvmHa3Ly7PAe1+jLpPaqhdEFVzii+x4pUUjSA9bwpAnxaIgSgJF6f?=
 =?us-ascii?Q?N8a8RFGfc6pSKbgaM/1caqHjNmqC5o0fxcyQAKUGcn8KamCII5gMlEhH2RMF?=
 =?us-ascii?Q?pBAFiXt7f3SVj0/Nb9F6CcKaNzOm6lGFc/9X8GJPF+jtPyH4gFYUQqwovHo1?=
 =?us-ascii?Q?0ZkhEmV9SdTQ6t5DMgcUeQb/4/HWrkCF/ItOp+lWvxqdkou7MSafQ+/ZZ+KU?=
 =?us-ascii?Q?lz6DqRndXqg+eiHEi3pgcTP562qAlZUqGfVwNqwbvSDtWa6jtWlbqSFdKiST?=
 =?us-ascii?Q?nJeU0/fNVPMmEalc0+7pV8Aqtd3Vjh84f++y9feOQ5mKFevVjeZJFCtNXIFh?=
 =?us-ascii?Q?kZQxh2vAoZYh9nABwfNg9Eoc4MNvvWWF04pqP33HNZXF3LIESod7eQGif6ew?=
 =?us-ascii?Q?feELfhzDFapnEFUvrZDZZSk9FXUD1oYEDGYtl262/isrXheThTNeW0yYz2cM?=
 =?us-ascii?Q?6k7MsX9omT9thPpnJtQic7yaLiSbWSXzkPepyARMqNuNyvGcUHw117g5QRou?=
 =?us-ascii?Q?680Ni7AMNMFtZyicvnGn0ZDNhUZEMSyAI4H6lfI7FOILIB1IRrMQDNnlvDdX?=
 =?us-ascii?Q?ubZbIHacMXOcOsxBf4BvRwVR/5wpaEBo2BU9TYqxwCg4CzCcYGyivL1w41OZ?=
 =?us-ascii?Q?O5agjbl+fUamZfjdA+37um2t0E0MpmRI5HIKv1OBnNLBGFEjR2TrMPspQAaa?=
 =?us-ascii?Q?xRNOUEZpJ7vVrsmnbdX/pZW7flGvTOUilVsoi2+No+CTtsJOn63nx/pOWFtH?=
 =?us-ascii?Q?4GljS1b9oH1f0JqL+8os5usyQfSSi2a9TNHgU7knA5QZXSs32YtgkgN9oaG0?=
 =?us-ascii?Q?wOo0gGYhLrrqHUsSmWVWK0DuhVAxIryQMQzVP5qyCKjbvCvHsRPm7T8dWJNV?=
 =?us-ascii?Q?mAtCtbVNS59TJu0aGzAYYMJS+mABiqoPtL28qGguqmrJg3t7X91bBwYVFv7f?=
 =?us-ascii?Q?Ot1FkJLsqxOJI91XnZvu8wD4KNRMifbHtqg0?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:29.8397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d7e38d-815d-47fd-97f0-08dd9f58fc82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593
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

This commit adds HQD PQ address lookup functionality for GFX12.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index f09d96bfee16..34a20a67c00b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3047,6 +3047,51 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static uint64_t gfx_v12_0_hqd_get_pq_addr(struct amdgpu_device *adev, uint32_t queue_type,
+                    uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+                    uint32_t xcc_id, uint32_t *vmid)
+{
+	uint32_t low = 0, high = 0, active = 0;
+	uint64_t queue_addr = 0;
+
+	mutex_lock(&adev->srbm_mutex);
+	/* Enter safe mode to safely access HQD registers */
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
+
+
+	/* Select the specific ME/PIPE/QUEUE to access its HQD registers */
+	soc24_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		active = RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE);
+		if (!(active & 1))
+			goto unlock_out;
+
+		*vmid = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+		low = RREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE);
+		high = RREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE_HI);
+
+		queue_addr = (((uint64_t)high << 32) | low) << 8;
+	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		active = RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE);
+		if (!(active & 1))
+			goto unlock_out;
+
+		*vmid = RREG32_SOC15(GC, 0, regCP_HQD_VMID);
+		low = RREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE);
+		high = RREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE_HI);
+
+		queue_addr = (((uint64_t)high << 32) | low) << 8;
+	}
+
+unlock_out:
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return queue_addr;
+}
+
 static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5672,11 +5717,15 @@ static void gfx_v12_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_gfx_mqd);
 	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
 		gfx_v12_0_gfx_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_GFX].hqd_get_pq_addr =
+		gfx_v12_0_hqd_get_pq_addr;
 	/* set compute eng mqd */
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
 		sizeof(struct v12_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].hqd_get_pq_addr =
+		gfx_v12_0_hqd_get_pq_addr;
 }
 
 static void gfx_v12_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

