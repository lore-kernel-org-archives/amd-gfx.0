Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FCAC624D3
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C0110E5E0;
	Sat,  5 Sep 2026 10:06:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nL4MuUos";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 730E110E5E0
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qHkb/B2gG4mbkIHv8Su44OrPPfIsbH04egUyxC/6WS41R1OeuE9kqP/xC0k+B4wQmn/UIotv440GC6x6qxPK6JBNuYEuNfIEErTGB/DeIou0VPJX4Itf5aOxzEbq/iC/5fEG9u8ntTkpmPX9plNhsgp0dnOpzHRGpoaBbzOxMhE643x5BoSwMf2tXx0NoRGC/plgblNJuoU5O05Lw8p8F6U+1pq9v75q6Ts/pMWf+5Hshrg64n3q03n+bfAoP3IaTUwnSczQ3HC43ezoySpoKRBjo2ql63ImSUBQBa/HJKvXLwojY0lgp8hg7OubwKdwEIwRj5covs7FT+cqvApd9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY1i3RdDJJ1tXnzZTsffYhoBiDoHZgwIYKxHm6p+AIo=;
 b=TVNLCWQWuwh7VxhK3hfn9SGA2T/rdl7Mp1dhs29fQoq59pwc7A+WwucwNQbiwDD/an1fE6MhZtOutaDXE/wv5megJgpTIurTExV6X+becsE6Xk5Utt2giwYsT/vPxwGs/xa6QHIeSUGkNvyFXankWb9s51BuyIGwDbZVHMAgfpXaRPlgAIAFs0b1SRwXfAhFJrSCF/IG6oRdgPPE6dYOxj1YP5iaoJSgHIkbisQWosALfUTXC2+0wIAXlW3mMlesB4tmNoHUoQQzMCM0TIstgDbTu3ZGLPy5VPmWdhCaW3Wr0ZU70TVFVkbokb1rJfzXOvQp7NuFkgjdyKXUsSMmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY1i3RdDJJ1tXnzZTsffYhoBiDoHZgwIYKxHm6p+AIo=;
 b=nL4MuUosUakpnCcss/+cuXp5dDXTMjTbvGySw55aBIHqFR1iB8th/InyTvDPv4lajfjRP0MJHld3KUNEfABtp/lAYqtWVEDFsPmTt4Krpyx4r6nyBGzc8mEpLjZQCQgOTgHVjHMkRWC9aGPUCZRLWEYHsO2uW/ine9pj2Zijr0U=
Received: from DS1PR02CA0028.namprd02.prod.outlook.com (2603:10b6:8:44a::9) by
 CH3PR12MB8971.namprd12.prod.outlook.com (2603:10b6:610:177::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 10:06:30 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:8:44a:cafe::90) by DS1PR02CA0028.outlook.office365.com
 (2603:10b6:8:44a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:30 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:29 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 11/13] drm/amdgpu: Drop nbio v7_11_x support from nbif v6_3_1
Date: Sat, 5 Sep 2026 18:05:36 +0800
Message-ID: <20260905100538.12877-12-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|CH3PR12MB8971:EE_
X-MS-Office365-Filtering-Correlation-Id: e266bb73-3655-4235-5c30-08df0b355b8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|22082099003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: g9Mmu7YCIe4w0G7ICf6rnoaY+xkb4OJeA9yLyCrUXBos7jI29LHEjq8iE273jW7egNkv5h7+a3F+Wofqltm+1/UATPFxzLvHYS/h5nr58MRddjG9qBrJWjpPdMfa/t/1AWCn/f0pTW+W2A07hpHIHS0Uu06VYaxOuxpCyD98iEQwQkFtbOHxRZFwbECOfry2kVEJcyMo8ul4caOGDT9zwcvyaE0eBPIqpqbO/V7UAdVX6v1mWsWfR+NiVMXemnK3O89r2pG/IzO5TW3zmze9/4yF1EsOTnLBNuIciibFNCB3ams8xYgRYdFSdmpDYnS1XcDfpveMXCj7+/ospjTcibXL3bKCSQwOHr2tl+jzfp6Zny2Njt0FkQHojB7onsPalMc6kP3Riq09y+2uk5W0oCJRrBCno0s/bqScFOyN2yQS3wPQLyAqwHTa7/CpiMeOWdzoqALkP8cdNiuttoN2vzBhHfuupVuOWx10PhVEWP3UQFeHwpdq9ACT7wQli4ggWLsk8iLSriqSf4wnQGLOe+dZ9o+ZmuvZuAcTaH/iR6mJcq9Yi7dokGYh7XmfM0xZmCLBPpiZaTSiSRy8evWZR7jc7EcFTAsjqS28OKe7mitF36zGbgG1VxoKO/V62EvZy1vKeat4LucSU8vAtNh55cTdhOaW+yNwmVjiCUceKdO8F9ibWN3fVWW5lvyzYfS6BbHFlMsmYeARyaFWeCx0fw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(22082099003)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2V34VIkkd5of4UJQsghFfZApPYw0saVn5GFWf/32E64DOLK17KvllpZgcYQ9L+cIc7lZCyRsnTKR/XodC5rq3E71WSoo7l0jtd6q5ncIdGTnT/HZMoWmZ/zjuC9Bu3w/ePOj8T9P5r+BHyN66aT/SLlU6dMVtaTW1sESOPuQ0pHBCUoy9yzm5RBWg0GmX9peUW9KNW3u97MiL8LK4s8+6bH+3hE7VyRrA7PyeuDX4EIfyRDan8njWAZblLmqZRikdvn3uDdqLwRqimqbAMFAdMaHDlt1Kuj6V7O5wywc0xhy8nCT0bxNIXNFuW059LvVRwyq7eigv8KXFbIUDuldJJhJrcGpV31VJLacfug3/+6ga9ezx9+CkZ1OHXkgFlHbPziuqrFEIhL9V2HjZkM0mT7ORPIpkCSxkSlvBHaC7JuAdfmLl96/uMtpcWsaSXZZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:30.6635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e266bb73-3655-4235-5c30-08df0b355b8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8971
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

nbio v7_11_4 and v7_11_5 now have dedicated implementations.
Select nbio v7_11_4 function and HDP flush tables during IP
discovery, and remove the version-specific register offsets
and doorbell handling from nbif v6_3_1.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c      | 89 +++----------------
 2 files changed, 19 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 7710a8ed3d44..905332144836 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -45,6 +45,7 @@
 #include "nbio_v7_4.h"
 #include "nbio_v7_9.h"
 #include "nbio_v7_11.h"
+#include "nbio_v7_11_4.h"
 #include "nbio_v7_11_5.h"
 #include "hdp_v4_0.h"
 #include "vega10_ih.h"
@@ -3794,10 +3795,13 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->nbio.hdp_flush_reg = &nbio_v7_7_hdp_flush_reg;
 		break;
 	case IP_VERSION(6, 3, 1):
-	case IP_VERSION(7, 11, 4):
 		adev->nbio.funcs = &nbif_v6_3_1_funcs;
 		adev->nbio.hdp_flush_reg = &nbif_v6_3_1_hdp_flush_reg;
 		break;
+	case IP_VERSION(7, 11, 4):
+		adev->nbio.funcs = &nbio_v7_11_4_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_11_4_hdp_flush_reg;
+		break;
 	case IP_VERSION(7, 11, 5):
 		adev->nbio.funcs = &nbio_v7_11_5_funcs;
 		adev->nbio.hdp_flush_reg = &nbio_v7_11_5_hdp_flush_reg;
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
index a74b17a47fd2..766cfbde55aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -30,33 +30,6 @@
 #include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10                                 0x4f0aeb
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10_BASE_IDX                        3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10                                0x4f0aec
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL1_nbif_4_10_BASE_IDX                       3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10                                 0x4f0aed
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10_BASE_IDX                        3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10                                0x4f0aee
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL1_nbif_4_10_BASE_IDX                       3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10                                 0x4f0aef
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10_BASE_IDX                        3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10                                0x4f0af0
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL1_nbif_4_10_BASE_IDX                       3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10                                 0x4f0af1
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10_BASE_IDX                        3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10                                0x4f0af2
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL1_nbif_4_10_BASE_IDX                       3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10                                 0x4f0af3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10_BASE_IDX                        3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10                                0x4f0af4
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL1_nbif_4_10_BASE_IDX                       3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10                                 0x4f0af5
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10_BASE_IDX                        3
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10                                0x4f0af6
-#define regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL1_nbif_4_10_BASE_IDX                       3
-#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10                                    0x0021
-#define regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10_BASE_IDX                           2
-
 static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
 {
 	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
@@ -69,10 +42,7 @@ static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
 {
 	u32 tmp;
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
-		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0_nbif_4_10);
-	else
-		tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+	tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
 
 	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
 	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
@@ -130,12 +100,8 @@ static void nbif_v6_3_1_sdma_doorbell_range(struct amdgpu_device *adev,
 						       S2A_DOORBELL_PORT2_RANGE_SIZE,
 						       0);
 
-		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
-			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL_nbif_4_10,
-				     doorbell_range);
-		else
-			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
-				     doorbell_range);
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+			     doorbell_range);
 	}
 }
 
@@ -146,8 +112,6 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 	u32 doorbell_range;
 
 	if (instance) {
-		if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
-			return;
 		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
 	} else {
 		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL);
@@ -180,15 +144,10 @@ static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
 					       S2A_DOORBELL_PORT4_RANGE_SIZE,
 					       0);
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL_nbif_4_10,
-			     doorbell_range);
-	} else {
-		if (instance)
-			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
-		else
-			WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
-	}
+	if (instance)
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+	else
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
 }
 
 static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
@@ -229,24 +188,14 @@ static void nbif_v6_3_1_vpe_doorbell_range(struct amdgpu_device *adev,
 					       0);
 	}
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4) ||
-		amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 5)) {
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL_nbif_4_10, doorbell_range);
-	} else {
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
-	}
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
 
 }
 
 static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4)) {
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL_nbif_4_10, 0x30000007);
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL_nbif_4_10, 0x3000000d);
-	} else {
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
-	}
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
 }
 
 static void nbif_v6_3_1_enable_doorbell_aperture(struct amdgpu_device *adev,
@@ -311,12 +260,8 @@ static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
 						  S2A_DOORBELL_PORT1_RANGE_SIZE,
 						  0);
 
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL_nbif_4_10,
-			     ih_doorbell_range);
-	else
-		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
-			     ih_doorbell_range);
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+		     ih_doorbell_range);
 }
 
 static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
@@ -371,18 +316,12 @@ static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *adev)
 
 static u32 nbif_v6_3_1_get_pcie_index_offset(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX);
-	else
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
 }
 
 static u32 nbif_v6_3_1_get_pcie_data_offset(struct amdgpu_device *adev)
 {
-	if (amdgpu_ip_version(adev, NBIO_HWIP, 0) == IP_VERSION(7, 11, 4))
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA);
-	else
-		return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
 }
 
 const struct nbio_hdp_flush_reg nbif_v6_3_1_hdp_flush_reg = {
-- 
2.17.1

