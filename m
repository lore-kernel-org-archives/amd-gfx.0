Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2CD8C28B2E
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Mar 2025 08:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA2710E71D;
	Wed, 12 Mar 2025 08:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u30MGemm";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504CB10E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Mar 2025 08:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YdzT35qycfQ3kIbnF24jOhEqs5Aoy/KkhiXw+O3fAJlXiKKZ11Ot1BjmMgyKVapFc2cGhKp5UbvsbdX4egsg5C1EVyv+GTNP9SM0CStuBBVkGu4bHVZ+mhTXZOzZY73O1UZbtYT8RRlsF3Ic3trDs2kC7C/w/bSNCoAsN3K/LhV0qfzMxm15NQYoK/ZId8vOYgJcmoDTVyghhcguMdsjycW+IK01df4hkUmhviIVcbkjaOCTWa5mmjQAUwzcKn+oXmr+XeyNTiGTsyzYuw393sUoHCWot+c3ru6fn2BPyUMnqnGNssNx1xGfPBjp6qCGTEtqtFPymmZSX5J8mwc0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZ4S/mc2/oNMG3zF5JoXWXRKyU/fBm/DrH1j5Wt0yws=;
 b=vpcXtsngyuBr3lm/Fl31SxN9E49xUXdG/rh6nxlnjiWsX5jFodfC6xEVcX0PHDLz1nUearh/IDSV7ExSlxDC9D3FIw3SCIH7bj5HgnMvHGfpqTpUkXWuqBYuyhyMC4smi2i+zZu4oVAB58SU4Z013ZSop+NSZCby0AXkBHYCDvlv3vXRLM+9OuDizK4CY5hqHJE0Cdso68cme/stlP/Hy7RK8LacjkAXElvjx2FDDV8T4PqbuMO1xQ2akiVfUjC6u4jlXdEF30kb2WCo887syfrnr5bx32VQT0eUIcxGnUkt0vFSOD5t0cmaKfPejTNAqRQYn9hrMAMmyi45AGuM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZ4S/mc2/oNMG3zF5JoXWXRKyU/fBm/DrH1j5Wt0yws=;
 b=u30MGemmNmYKMqcf90CgM5YaVBCE/hlQX4RjNOOfmjprJdJuriHbmPlu+Tq3SfCfSMXlvScRLQZnHcjTkHkJKXOCUCat226vBQE/UoL0d7NXF8QCbIpbiHfXUX8DPjUoSX1FuNX8SkbhaVVgWU3Sg7o5HCpmWCGdOuihCq67cOU=
Received: from SA0PR11CA0021.namprd11.prod.outlook.com (2603:10b6:806:d3::26)
 by CH3PR12MB8482.namprd12.prod.outlook.com (2603:10b6:610:15b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:00:30 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::56) by SA0PR11CA0021.outlook.office365.com
 (2603:10b6:806:d3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Wed,
 12 Mar 2025 08:00:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 08:00:29 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 03:00:28 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 12 Mar 2025 03:00:16 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang
 <jesse.zhang@amd.com>
Subject: [PATCH 2/7] drm/amd/amdgpu: Implement SDMA soft reset directly for
 sdma v5
Date: Wed, 12 Mar 2025 15:59:58 +0800
Message-ID: <20250312080003.3224976-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312080003.3224976-1-jesse.zhang@amd.com>
References: <20250312080003.3224976-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|CH3PR12MB8482:EE_
X-MS-Office365-Filtering-Correlation-Id: fc8fccdd-2066-49cb-5a1d-08dd613bf4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/CFVvXspDXGbmIaTVcHrzNS0b1P3TU0RTsBxu9nfLzq4yl1Znlk6Bmnx8nRc?=
 =?us-ascii?Q?vS4gjEAJD/eN1huyQpK54Hfx9C8WMxASR7VWc3ae52EQI6cTrwzkMjkQMLbH?=
 =?us-ascii?Q?xZuaaxslzAZwmC8pNi5STWnyoKm5lbSDZHcXBzO/qCMC45p2m2pcc/xKGiy4?=
 =?us-ascii?Q?OvBB/iz8ZD7bp7Z0NosmjaegTB9jMYFaME9Y6H1DBlifd9tIuTTEKfH8iDt3?=
 =?us-ascii?Q?vdUeN007sEOLfUC7PDUoOzIeL99psd9Bjq/YlKkv3z+Oay8/XEJQyfeiye8i?=
 =?us-ascii?Q?kKvDyd5CPfi72ng0awk2IfR/BiRdPbyQlOzT09i54i3CkjSwNVSSoq5gdIiU?=
 =?us-ascii?Q?ROG6Avio4FvHE3YStx7YfzYjz7rA04KcONPNyVr3f9KCdCPHDkWNZJqoNTkW?=
 =?us-ascii?Q?5+ucES4u5/o1xDP+EE3qixNbwyGSoTAl4J6ZMJIWFx1MEwuLO11yJebTJ43H?=
 =?us-ascii?Q?qAuDbcFCdxTTmGcwJpnAmS8FYziefQQiukV9NjX2qdC/dHvrDFTx+uyoMWG4?=
 =?us-ascii?Q?DLxEYTIa0ZkoJS4KBTMb6o69mU/DPxnLdbmywUnKayFHDFr4bebo+MpTUm/Q?=
 =?us-ascii?Q?KHR9qlS8GBVJtPBXCXyNdXst6aub+6wMHzeh6l+W7UeC1+4Zr2dCpVdnDvPc?=
 =?us-ascii?Q?bZH5LSf0LHMonfv57hwGmeEt3478QqM/F7uozcuzHWgk3E2D42BEdAM7CX9t?=
 =?us-ascii?Q?YCW4xRpvZmADsI1OH82Ym90CfSOKgJr+6jNWmolakFiwqk9npvc6hamHbYhL?=
 =?us-ascii?Q?f6rLvbSAJ4vz0g6ikTdGtRWErtC74ujPThYd4Xa2tCl9EO+Ds0E5Zs75VQnc?=
 =?us-ascii?Q?6gK7YQpEMTJRmRYngNvpeJ7lQ62ZuSAixZGBlZULjddTs/iegAVAe/diVteQ?=
 =?us-ascii?Q?GBCiXWQ35InBVAlm8j53w/9N4Oc5dIO8Ft8ghVjhmeaB+7grVF8hvnZaYf0d?=
 =?us-ascii?Q?0ckdGlJ1ET3/vh3+ijQIxNyK0XMmudwqIFTCLK1FOEaMDdNC8DRbpkaksRiH?=
 =?us-ascii?Q?KkW44VCc+ERPJ53vmW4Z+BBzLl1zQ+ZzaL0wdTuCkjXlpzq3z3/iq3dT42HF?=
 =?us-ascii?Q?Prnx21RKFxOeBsr+Y2SgIsDoBEP8mHR+1sdtenJ7POBbbUggztDPPvpWmykU?=
 =?us-ascii?Q?KyuhuEQ8acLgbAw0/mcTqUvRL7puvZBPb/uhHr4VcYlYjaeXGa+KKZIU7v4d?=
 =?us-ascii?Q?Oqx4X+lC5yPwRkWWDn+PML5KGEG0QR29+IRSI1DPUjbnaCaSoh4Q9QRbyiXs?=
 =?us-ascii?Q?Bh0+BDBC0VJsK49ST1xidk8W1JuIioOPiEKpAMKrnx3uWieiC6JyIpftgLkU?=
 =?us-ascii?Q?hkXyNfAsmXIIywglfiGdEf1kDQSOPqPgn6p3YnPM08CxDXmW0bW7EMzVk2pY?=
 =?us-ascii?Q?eXZxPwtb9TP3FPI/vGkzYeZE79Y4OriTxTolQhfp++9O5IMbopbAD9CeI2Dc?=
 =?us-ascii?Q?uNQmkQ70MYVZ/oyVXxnTzOdh6y2s6tZcKUfpOuI7g0QIr+bgJ95+a92AS1a6?=
 =?us-ascii?Q?7lifkTSeiacZ2Uo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:00:29.2359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8fccdd-2066-49cb-5a1d-08dd613bf4ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8482
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

This patch introduces a new function `amdgpu_sdma_soft_reset` to handle SDMA soft resets directly,
rather than relying on the DPM interface.

1. **New `amdgpu_sdma_soft_reset` Function**:
   - Implements a soft reset for SDMA engines by directly writing to the hardware registers.
   - Handles SDMA versions 4.x and 5.x separately:
     - For SDMA 4.x, the existing `amdgpu_dpm_reset_sdma` function is used for backward compatibility.
     - For SDMA 5.x, the driver directly manipulates the `GRBM_SOFT_RESET` register to reset the specified SDMA instance.

2. **Integration into `amdgpu_sdma_reset_engine`**:
   - The `amdgpu_sdma_soft_reset` function is called during the SDMA reset process, replacing the previous call to `amdgpu_dpm_reset_sdma`.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 46 +++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index b1f4a11ad0c9..c01154313a92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -26,6 +26,8 @@
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
 #include "amdgpu_reset.h"
+#include "gc/gc_10_1_0_offset.h"
+#include "gc/gc_10_3_0_sh_mask.h"
 
 #define AMDGPU_CSA_SDMA_SIZE 64
 /* SDMA CSA reside in the 3rd page of CSA */
@@ -528,6 +530,48 @@ void amdgpu_sdma_register_on_reset_callbacks(struct amdgpu_device *adev, struct
 	list_add_tail(&funcs->list, &adev->sdma.reset_callback_list);
 }
 
+static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
+{
+	u32 soft_reset;
+	int r = 0;
+
+	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
+	case IP_VERSION(4, 4, 2):
+	case IP_VERSION(4, 4, 4):
+	case IP_VERSION(4, 4, 5):
+		/* For SDMA 4.x, use the existing DPM interface for backward compatibility */
+		r = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+		break;
+	case IP_VERSION(5, 0, 0):
+	case IP_VERSION(5, 0, 1):
+	case IP_VERSION(5, 0, 2):
+	case IP_VERSION(5, 0, 5):
+	case IP_VERSION(5, 2, 0):
+	case IP_VERSION(5, 2, 2):
+	case IP_VERSION(5, 2, 4):
+	case IP_VERSION(5, 2, 5):
+	case IP_VERSION(5, 2, 6):
+	case IP_VERSION(5, 2, 3):
+	case IP_VERSION(5, 2, 1):
+	case IP_VERSION(5, 2, 7):
+		/* For SDMA 5.x, directly manipulate the GRBM_SOFT_RESET register */
+		soft_reset = RREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET);
+		soft_reset |= 1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << instance_id;
+		/* Issue the soft reset */
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+
+		udelay(50);
+		/* Clear the soft reset bit */
+		soft_reset &= ~(1 << GRBM_SOFT_RESET__SOFT_RESET_SDMA0__SHIFT << instance_id);
+		WREG32_SOC15(GC, 0, mmGRBM_SOFT_RESET, soft_reset);
+		break;
+	default:
+		break;
+	}
+
+	return r;
+}
+
 /**
  * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
  * @adev: Pointer to the AMDGPU device
@@ -567,7 +611,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id, b
 
 	gfx_ring->funcs->stop_queue(adev, instance_id);
 	/* Perform the SDMA reset for the specified instance */
-	ret = amdgpu_dpm_reset_sdma(adev, 1 << instance_id);
+	ret = amdgpu_sdma_soft_reset(adev, instance_id);
 	if (ret) {
 		dev_err(adev->dev, "Failed to reset SDMA instance %u\n", instance_id);
 		goto exit;
-- 
2.25.1

