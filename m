Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C00C44501
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 15:43:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8E310EE31;
	Tue,  7 Jul 2026 15:43:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JX40hj2g";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A00B910EE29
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 15:42:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ebrnnH9FXhExYDckHFAUqgW2EdeP/n1b2RZoRKBY5EtPWZ2L/ND0rI52VD6oPxfDJ7gf+CqXdCEdAN6QI9KOolj0h6YCCSxWptlKhV7FtPqnmCyxQSkFh+odWdrc+136kKTum7lDXt2MdaWck7D9VxSyD7oARadZsoR0fpt5e07sMJtQ2O3nV+4ri0cDB1uV6V8PgSEyTpP6TfKzSxspPdeIbWOQwwyeXgVjWVuxFBLXtLcXRIMOIMS7NyEuUzr+447V8mhRxK+RerQYgtlUQ1sTFfxlHuVigKGCH+0s5MvIPX8neRQnqy+N4h2WwkohwL3+9X8ajGTHO9+/3cYZsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I83M3y5Hc2QpwZBum5VwkLR7+icCE7GbOuFz6Fh4C/Y=;
 b=EpfZyhbKmPdpImYEBOJ6KPP/KrUAajgRhAS99Ua9cdxrSLpHuMOW5SeCsiWtdEQMOHBsAQ96d+X3pYPJ+uiej/BM2uqqzLijk6FwbdDtblXsP6YluApWFy6MqEdas7OE9pwPE+PT7Fz8FhEUeGG3wIosCZh/Q86gmacWbxyezCwDX95k/zIlW9Gl+BhTlK7+HT6MCJIgpFT37E6dV38BdWmtl7lPQ9omXh1CcMEdVeUC1CA0xx+0mBRlXCgl5191qMhHq9O4zVN+GRjZbRbUmbl29t0+Bu8R859rO27Vb7/3sZvCDesyloiw/ZX2FtjczVnzRblAhujLz7FvqZ5bBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I83M3y5Hc2QpwZBum5VwkLR7+icCE7GbOuFz6Fh4C/Y=;
 b=JX40hj2gl/zj+dn2jjR94RBh6MCcNY+kDCFKwj+rNNYAG82fXwDIj31ZlzmX+nk1pcKqe80GijtCgv6PMFKeWb/7/L011AkmdH1s7PrFkVDi5nHBfsBWrcxgoYkZkYYQe8JU9bCj0wvFaEMdhf8BhCBl2ZhcTJf/6LYgeVMySaU=
Received: from MN2PR16CA0040.namprd16.prod.outlook.com (2603:10b6:208:234::9)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 15:42:47 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:234::4) by MN2PR16CA0040.outlook.office365.com
 (2603:10b6:208:234::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Tue, 7
 Jul 2026 15:42:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 15:42:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:36 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 10:42:36 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 10:42:35 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/30] drm/amdgpu/gfx12: drop all BUG()s
Date: Tue, 7 Jul 2026 11:42:02 -0400
Message-ID: <20260707154203.2603209-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260707154203.2603209-1-alexander.deucher@amd.com>
References: <20260707154203.2603209-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: eaddc94d-586b-46e9-f6ce-08dedc3e64ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|376014|36860700016|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: O259c6sB60YGBsYAvaSxw65UOgNnmPrEOh0XBKdP2zjUQKpRe8C4peLR7k4JRvx5j8DdwKjYaKnHjt++o7SHBjEO3wxOL3AJLN5Oe6CL+IBfSH0n6xH8jqwBFgcoBRrBXS6u3wtsOq9AGNiRct1xNX8GDxMA+G1uwtjTICVVfkgGxYvsEi4kHkl4J14wfmq9+ofq+1rUJwJ+TzAzXWzGcxKE9EtBCv3+0WFjCtiu1I1XgkkkQBy8v113Vyw/GX4qkt604QBausKJoyD0sedMBUGxOt9ZbgPGzya99XAXgbPxgfAf0xhqcnMOMkMIBSXjpsc3LwCeSiPGdX5x5TK4K97opQG7nedAWo38IagHvnXTSVrukjmBBi+DHV/tNInqUxOnG8JGtcwuhNNPzrt3IMJozYjIyZDm+qXs38FuPNULKIHol8704nIa2/udqLyDGc/+6xc1mpjtiSmadlCbJWUFVYylt0+6npST0bJyaXFcsJ94FokpGJ7L+cXj2qunaHDUM+1DdgTu7WQZatOcQ4tgjdG2vsyfrQ0lfShtJpA2bvT1AnZ4detyflgfIDY9vOoUpq9mVi7PrXVWxPQH5R0eTCXgbBxfsl/dfLl4BRZ7voF8BLqWtITm7uGaDosEkuGwOLZ6actKW1w7JirCreaW32aMdi0hcCskPO1J8ArJC2/R4oW88Z2uHORWcbkOY2rAq2P0DHHLb5JJxHO3yQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(36860700016)(18002099003)(11063799006)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: imzq1blFkDQRN/o0DyuUDV0HHM9tYtx3Dmzj+JJhT+90W/WjmaeZZmUcmbVISqE9izdgSNsK1tRedL6SV02aC1/HgRn3NZIYGdhy+yunzXrdOSP66vJ0OX15sAO+uJOqNsfn2aefqV3DcRs9FqzbW+qJ92M52wiLBFMjoj7NDorQdvWOnJYeg4j0HwzZ/HMnjvAUrwpwuc22ZQUPWtrbOttRlwsfeA67Ivvi76EKmWHw2oyhfMiZeRoqOkFoOLL/Pfz+HkYQHG0JkM1v6EIuzTgyiij76rMvKUVmNY1gzzCp5hxtBRTEAZV1N52nQmXHsADZ8ZbAMgdQS6pgLLADJd/fkp2TeUAm2YqAR0oDqf44rqV0P9AwyBmK6PMVJxGOaH5nviy0Fh+gAE7t7yM7sXU/CZeJ+w7cHngF2aV/BF5fapxNhTXEGF4CfDgw96od
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 15:42:47.2215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaddc94d-586b-46e9-f6ce-08dedc3e64ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121
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

There's no need to crash the kernel for these cases.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index dbf0cbbbe8561..995e8caa054b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -964,8 +964,7 @@ static int gfx_v12_0_gpu_early_init(struct amdgpu_device *adev)
 		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
 		break;
 	default:
-		BUG();
-		break;
+		return -EINVAL;
 	}
 
 	return 0;
@@ -4469,13 +4468,16 @@ static u64 gfx_v12_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
 
 static u64 gfx_v12_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
 {
+	struct amdgpu_device *adev = ring->adev;
 	u64 wptr;
 
 	/* XXX check if swapping is necessary on BE */
-	if (ring->use_doorbell)
+	if (ring->use_doorbell) {
 		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
-	else
-		BUG();
+	} else {
+		dev_warn(adev->dev, "gfx_v12_0_ring_get_wptr_compute() requires doorbell!\n");
+		wptr = 0;
+	}
 	return wptr;
 }
 
@@ -4489,7 +4491,7 @@ static void gfx_v12_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
 			     ring->wptr);
 		WDOORBELL64(ring->doorbell_index, ring->wptr);
 	} else {
-		BUG(); /* only DOORBELL method supported on gfx12 now */
+		dev_warn(adev->dev, "gfx_v12_0_ring_set_wptr_compute() requires doorbell!\n");
 	}
 }
 
@@ -5084,7 +5086,6 @@ static void gfx_v12_0_handle_priv_fault(struct amdgpu_device *adev,
 			}
 			break;
 		default:
-			BUG();
 			break;
 		}
 	}
-- 
2.55.0

