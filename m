Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0868C3ABB6
	for <amd-gfx@archiver.kernel.org>; Mon,  5 May 2025 13:05:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A666A10E3DE;
	Mon,  5 May 2025 13:05:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="37wMhD4e";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AAF10E3EE
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 May 2025 13:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aK0K8k3Vfj9nKJ69Onoal4Qt0CO/uBUg6j8/aOKCU6mw7Fuz9V+sEJpCwY7LD+RHDEINhItUQH5C4lpBzvi97tGsZJWT3vc4iXyBT0OjSVlCoQZfTzbY2A8r3GW88oQKAMnOVjMp4bX/kMGllVlfZPVBbqIO+MlcmJq184o3vGUGR69QpfDbYxgyKVzw5eLkb3nloj+D7D/A4amNmisPadaBnZlHiSSF403fvNWsdVsEFS9BgE7KDKeg9Mm1nuFPKyyj9vSmAtfYDWdzyhKz1kfha+6p4IpGp5K5cHAeoaEgROPE4jFVgSA+Nf0YrxBhW8UfrolmfdabTPO0eDseCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6NCZpAxY+l2ufXt19B3cCk1s8ws+HbqmAxlYDM2Vg5I=;
 b=TF6yxPNEOrfV2mkNduCv+CQjm/TP+kLw9OZpG31o+/UPZNkRpyKLM8P30Db26eCMEqkuRzpMMfHr9TK0mCyQBl3fBaSUrmRJSZVqQGR7Zo5Jk5QxPO3H0ohrj6kEbJNDFV6/9qg9I6dntZ2p2uz+zxQFE9nspI7EgHg0wDxl/ZE1UiFuGtCwFJTJj8x1Pdr2U3MH0Qsi92EociKz5yCB9+JHfA1LoGo9y4qbiNgnDFuGEcDSOVxEljbnU5v8VdQLR9b87I0qjJPmjl63NZz5Ej9qaeVlSRYDgpGnXf6VozrozK/kZJj4ZatHlEvFbKCG9LbVLtRivSwDVwqKE5inPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6NCZpAxY+l2ufXt19B3cCk1s8ws+HbqmAxlYDM2Vg5I=;
 b=37wMhD4eqe5Z1FZTlRgxhbFhqiyhdGImibQdalPpUVUSPpRk1VAKsdZOgZO+C2JppqY4Mb0u+nyY6ZSAVCbipWH5Uhfbh+rARhPbmHSf1ADUIAXyQl5a4VdkCbHRwOuQS1u68n8i0dHsaE7T1YPUrOOIJ6GJCm5ddax8iz5U6mw=
Received: from CH2PR18CA0017.namprd18.prod.outlook.com (2603:10b6:610:4f::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Mon, 5 May
 2025 13:05:15 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::22) by CH2PR18CA0017.outlook.office365.com
 (2603:10b6:610:4f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Mon,
 5 May 2025 13:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 13:05:14 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 May
 2025 08:05:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] Revert "drm/amdgpu: Use generic hdp flush function"
Date: Mon, 5 May 2025 09:04:53 -0400
Message-ID: <20250505130459.1985637-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed2922f-443f-4af3-dfc1-08dd8bd57a1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1pNmpuReolUt5yppmQpfLFDzlVPqtCgayA7giN+ybfeKeWVjLKg8++a2gL74?=
 =?us-ascii?Q?wyLo3aJu7vPz854bHImvKuH/axlJIcItEtVZWFb5RHgRc5hkyrgK4bfg2ZPh?=
 =?us-ascii?Q?JJngu5PhSbuHziN8RSzphkmZG7PzfqtUiIfI5K6eaICy9Ms1V/TN24ymWVEA?=
 =?us-ascii?Q?BhiB/lcm9306JiD5ojv4/4iydUpstwGDAD9pa5ixOkxdQZ5hginXhi60HYhE?=
 =?us-ascii?Q?R25NBYYMtrJE1y5QN3iS4VHA0daWwSFIJpFsutepHtJWOXh7DMuD7wNmf/DY?=
 =?us-ascii?Q?txP0hE2xw0lC6HjqrZ8GDsUGT0vaVtuyQsZG0JQOiBjjfe73+i7z54VXY9Na?=
 =?us-ascii?Q?Ty5uCC3goPxi9WaOaaWVzemup4SyiSdMpoxsDQgw/NM369ZXcBeveI6LR8zs?=
 =?us-ascii?Q?kHoSdytHcpYPIwtRbDSuPXuf7voe6PVqbRBOfX+/A/5VeWKPQvgscHkh4nBz?=
 =?us-ascii?Q?MdaTyeQEYPK7Ll+KVi6XXDFAzARvLZONLXRALvO5Bl5yLqOG0FC1vpkAnm4g?=
 =?us-ascii?Q?pxDYbhS0f2dX8npP/M5UYKViRkMOTOxTkYaLWiSOZdXDnlolO2ISd42bLTAN?=
 =?us-ascii?Q?yzMZRqqwdDmqmuTZtqGo6p3UcbioXDnnk98hcQCem38Voo1rjQJZINIwFogx?=
 =?us-ascii?Q?r2bS8AAYVRSM0oTWI/313H+MvbpAjHmhefquWoF7m0xCJPdDuGO+GLMA1RUl?=
 =?us-ascii?Q?7lXWM7GUU1IAcOSZVS9QoCMSJFMdi0tU4Ohl3GfKHCy/0MaAdx/t2xiYGQVw?=
 =?us-ascii?Q?ee/2b40bxWAw3PoWH8dKe5WjhmuytxYLo9ASrmRV8exiWZD3qMRR7z7P67sE?=
 =?us-ascii?Q?pu0f5/RiDk5yDWFrkyHGOtooGPazbezFA21zY1ZDhq7Qrs5aHa15D553pMEE?=
 =?us-ascii?Q?55h7hNhS1KXb4gMDJlBh7pW7H9H+SF1HVpjOhKOdGwb+tr2E7R5sxFVu7S+g?=
 =?us-ascii?Q?8RUt2gjZ/FJSLl2RXMeiaW5wp+KPUEsLN716r46Tlcor4il3vdrd54lrMKUI?=
 =?us-ascii?Q?0mqLiaHZLXClSEtNekap33WrPQHSm81yxzHG7pas2m0YzNf8j6B7Jrvj/p+H?=
 =?us-ascii?Q?6JcmpOiZbUlQljhQaqobqaIKXsNHLqlDBjvwionX2v12dw9THB9lH7i1JuxK?=
 =?us-ascii?Q?J5T8qnNUhPJydJQGZpWUEFA6vRAClMjrbkFQL1C70CYCM87JS1SLjZDkKSo4?=
 =?us-ascii?Q?vy9hmytGQOlMuINGiHNnjy3sSkUoVXufyFQlYVbgoKmdTKFYkTs18ezoTH4S?=
 =?us-ascii?Q?pAkNAhbkwHypzFImTRv/J4sE9hZJdrxhtIV2on3l3WV5o8wb4JVqUCYNvTKP?=
 =?us-ascii?Q?wj1ulmfaxJQJ/RnM84u03fCfTMz3yOIEXlI8PMQq1VUmp2sRsK5jU5aS+XOn?=
 =?us-ascii?Q?Yo6QXcq78RJIAfAYwDbatwu6hAtSQYEqPwEK5EWAumZuFyoNA19qLU44lhBQ?=
 =?us-ascii?Q?m9DKZS/bqVKIy/YVTwsqUfghM7nvDsWTL1hnq6PHhxyAWFcBFirdozF1X5Q+?=
 =?us-ascii?Q?TH34gDoSnj6usOxWxSx8fUr88OnE8TPpOxqv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 13:05:14.8854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed2922f-443f-4af3-dfc1-08dd8bd57a1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
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

This reverts commit 18a878fd8aef0ec21648a3782f55a79790cd4073.

Revert this temporarily to make it easier to fix a regression
in the HDP handling.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c | 21 ---------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h |  2 --
 drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c   | 13 ++++++++++++-
 drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c   | 13 ++++++++++++-
 6 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
index 7fd8f09c28e66..b6cf801939aa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.c
@@ -22,7 +22,6 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
-#include <uapi/linux/kfd_ioctl.h>
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 {
@@ -47,23 +46,3 @@ int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev)
 	/* hdp ras follows amdgpu_ras_block_late_init_default for late init */
 	return 0;
 }
-
-void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
-			      struct amdgpu_ring *ring)
-{
-	if (!ring || !ring->funcs->emit_wreg) {
-		WREG32((adev->rmmio_remap.reg_offset +
-			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
-			       2,
-		       0);
-		RREG32((adev->rmmio_remap.reg_offset +
-			KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
-		       2);
-	} else {
-		amdgpu_ring_emit_wreg(ring,
-				      (adev->rmmio_remap.reg_offset +
-				       KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >>
-					      2,
-				      0);
-	}
-}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
index 4cfd932b7e91e..7b8a6152dc8d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hdp.h
@@ -44,6 +44,4 @@ struct amdgpu_hdp {
 };
 
 int amdgpu_hdp_ras_sw_init(struct amdgpu_device *adev);
-void amdgpu_hdp_generic_flush(struct amdgpu_device *adev,
-			      struct amdgpu_ring *ring);
 #endif /* __AMDGPU_HDP_H__ */
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
index e6c0d86d34865..f1dc13b3ab38e 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
@@ -36,6 +36,17 @@
 #define HDP_MEM_POWER_CTRL__RC_MEM_POWER_LS_EN_MASK     0x00020000L
 #define mmHDP_MEM_POWER_CTRL_BASE_IDX   0
 
+static void hdp_v4_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
+}
+
 static void hdp_v4_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -169,7 +180,7 @@ struct amdgpu_hdp_ras hdp_v4_0_ras = {
 };
 
 const struct amdgpu_hdp_funcs hdp_v4_0_funcs = {
-	.flush_hdp = amdgpu_hdp_generic_flush,
+	.flush_hdp = hdp_v4_0_flush_hdp,
 	.invalidate_hdp = hdp_v4_0_invalidate_hdp,
 	.update_clock_gating = hdp_v4_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v4_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
index 8bc001dc9f631..43195c0797480 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v5_0.c
@@ -27,6 +27,17 @@
 #include "hdp/hdp_5_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static void hdp_v5_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
+}
+
 static void hdp_v5_0_invalidate_hdp(struct amdgpu_device *adev,
 				    struct amdgpu_ring *ring)
 {
@@ -206,7 +217,7 @@ static void hdp_v5_0_init_registers(struct amdgpu_device *adev)
 }
 
 const struct amdgpu_hdp_funcs hdp_v5_0_funcs = {
-	.flush_hdp = amdgpu_hdp_generic_flush,
+	.flush_hdp = hdp_v5_0_flush_hdp,
 	.invalidate_hdp = hdp_v5_0_invalidate_hdp,
 	.update_clock_gating = hdp_v5_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v5_0_get_clockgating_state,
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
index ec20daf4272c5..a88d25a06c29b 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -30,6 +30,17 @@
 #define regHDP_CLK_CNTL_V6_1	0xd5
 #define regHDP_CLK_CNTL_V6_1_BASE_IDX 0
 
+static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
+}
+
 static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -138,7 +149,7 @@ static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v6_0_funcs = {
-	.flush_hdp = amdgpu_hdp_generic_flush,
+	.flush_hdp = hdp_v6_0_flush_hdp,
 	.update_clock_gating = hdp_v6_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v6_0_get_clockgating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
index ed1debc035073..49f7eb4fbd117 100644
--- a/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v7_0.c
@@ -27,6 +27,17 @@
 #include "hdp/hdp_7_0_0_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
 
+static void hdp_v7_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg) {
+		WREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+		RREG32((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2);
+	} else {
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	}
+}
+
 static void hdp_v7_0_update_clock_gating(struct amdgpu_device *adev,
 					 bool enable)
 {
@@ -126,7 +137,7 @@ static void hdp_v7_0_get_clockgating_state(struct amdgpu_device *adev,
 }
 
 const struct amdgpu_hdp_funcs hdp_v7_0_funcs = {
-	.flush_hdp = amdgpu_hdp_generic_flush,
+	.flush_hdp = hdp_v7_0_flush_hdp,
 	.update_clock_gating = hdp_v7_0_update_clock_gating,
 	.get_clock_gating_state = hdp_v7_0_get_clockgating_state,
 };
-- 
2.49.0

