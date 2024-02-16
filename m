Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D731BC48BC4
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Feb 2024 15:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 349AC10EAD9;
	Fri, 16 Feb 2024 15:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3/qgjCTf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 749B710EA13
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Feb 2024 15:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UukoLukX/xTT/NdGFkE0jNYeLEjk1T4sUPr/6gQYBUS36/RA+FKKlE5ITka39A77zfPEf9ajpPsjMCY2VYKKqOPeNhw5Fmw5NADs8RclRTcL4khKCUbto7RFuqIQ9wFFHvvGyCxsCtnX85kSiEtdBH7YgUhHpEJ2RyKZNy1ZPA9EGPrIuRBDRSDBSgsb/Tx9XrG5afu5mRXlK+VHIl1I1nNeo6ZxC+fVF4ENBdAkDdq/b4nN5uUU0cRg4qpnvrO+gSoojpbre/cyoei7nbtEGlXgX3IOlgAxkw5+YJ4zlfsy0WguRApYapknfWg9DxDDb9S+j+6Gzlu8wNA93rO6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DGlTYNDLxj4+7vpGzzXE+O40s3gPb2OR2dnqPwPHQO8=;
 b=E3C9l0eLkbkKudY5WMRQTiT2w93Z4zCEtjSzETTsGA72qA9V/fA0y1peJM3WIyPi0gYGISHh/abcD3jwjkR7D0FOjrhLUxCnJoSCMAZ17IBK7p+JQ5PSOvD+wPr6kHlDNFonn3IOHWEioQIC1ukB8ZccHBTWYcXKCvBXCLw+vCODPfuY56wIPugXz1wUah1FBOB8x9eq+eJJTyDJUeN+SfFiIhYrJg/zesm3I9zgvLhNrop13ZFTOOF88KcYZJU4+MUF4VzBRqIHLxlLAsPfQSrLg8oYpSPHx1cU7k2z3pJBLx5t5vzswEHzIkgz1XOoeekYA4EsErCbUCwx7znX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DGlTYNDLxj4+7vpGzzXE+O40s3gPb2OR2dnqPwPHQO8=;
 b=3/qgjCTfNsIFtnkKtPgHTlCKnNEv5qxWNdOxI1Qa+qHFNlP6nqxuoemyp5yj6s0AStmbt7/kISDTcZyiJpfXZWt0+HILNTwM4xS1rlIY/5NV3LZCPmGKDKq2YmYcI6Je0fbleTfMpZo606QYWv7feMs/0pI75ISri7v/bZ9sDmY=
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 15:13:36 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::e7) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Fri, 16 Feb 2024 15:13:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 15:13:36 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 09:13:35 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add new accessors for GPU reset-affected
 critcal sections
Date: Fri, 16 Feb 2024 10:13:21 -0500
Message-ID: <20240216151322.473527-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbe8282-f9c0-4c32-37c0-08dc2f01d8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +FUE7m5FfHD1bFv+weuEPJ6+qwn0d5/fY19imGBjH/v6EY82pY0YNidd4XjTj72eXEYZuA+Ps75Jfvp8pRv+XDGHSCp6JySCM3zguKD3oiNgGssvEzlmHKtJzheRJNRJL/R8tIiAxx8dINULYLScqDPdQ1Jv4wBcaueKjps5rCjmF28a35hQBp/3TDEGFwpcNXHmB2xREJsqMdKG0XaMCNuv+mdHba/uBqzpzfoqBk1FQDnjZW99sB4/GcpKNvIiMtEqVIIGYjgvsN+4bHmPwwjcL47pSS5dfBwYKfeX8AGYMZ48sSCPs8GJBUGh9ySS8Ixe4mWK9kQ1JkMhFYBVeCVdDqLWDSkac3jTshJR1BUr+P+0bnStq8GbCcICsLzJNmfA47BvPK0MLnH24W0TxH2GyZ17PTW+Ly8QP/VDHYmLVvzzXWhcGxIhTKzh7V8iRfW4R1H8bDcdH0T+Laejg1XQsoZplRp1AxJEFD5Omkl0TE2mFdQYNEBSu9SbdOtynVOz+YMV/QKJizrHi3GJQhX6CJsD0cW3bYI4K+Dxn0geXgy6HUwv8KVHAeaAnKGz+xEbAQbysxqoyNdCNHTPj7hj6hiSXWZlFkQirYDiz9gRI5ohCkpW4UoZM85+22CbzIyDPSNcrVQOnx/QtawHzs9/FuxltZWZe5TJsxmrHZ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(186009)(36860700004)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(5660300002)(30864003)(8676002)(8936002)(6916009)(4326008)(70206006)(70586007)(2906002)(83380400001)(26005)(426003)(82740400003)(16526019)(356005)(336012)(81166007)(36756003)(86362001)(6666004)(316002)(7696005)(2616005)(1076003)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 15:13:36.0852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbe8282-f9c0-4c32-37c0-08dc2f01d8f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780
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

Provide helper functions for code which needs to be mutually
exclusive with GPU resets.  While we are here, move
amdgpu_in_reset in amdgpu_reset.c since that is the more
logical location for it and add documentation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  2 -
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c |  1 +
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  5 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c     | 86 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h     |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      |  1 +
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c    |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  1 +
 .../drm/amd/pm/powerplay/inc/amd_powerplay.h  |  1 +
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |  1 +
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |  1 +
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  1 +
 33 files changed, 121 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 9246bca0a008..0e365cadcc3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1602,8 +1602,6 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
        return adev->gmc.tmz_enabled;
 }
 
-int amdgpu_in_reset(struct amdgpu_device *adev);
-
 extern const struct attribute_group amdgpu_vram_mgr_attr_group;
 extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
 extern const struct attribute_group amdgpu_flash_attr_group;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 69810b3f1c63..78bec0b6c502 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -22,6 +22,7 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_gfx_v10.h"
+#include "amdgpu_reset.h"
 #include "gc/gc_10_1_0_offset.h"
 #include "gc/gc_10_1_0_sh_mask.h"
 #include "athub/athub_2_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index ca4a6b82817f..717a6d10b01c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -22,6 +22,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_reset.h"
 #include "cikd.h"
 #include "cik_sdma.h"
 #include "gfx_v7_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index 0f3e2944edd7..d08e9c308835 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -22,6 +22,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_reset.h"
 #include "gfx_v8_0.h"
 #include "gca/gfx_8_0_sh_mask.h"
 #include "gca/gfx_8_0_d.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 5a35a8ca8922..b0ff1065491e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -21,6 +21,7 @@
  */
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
+#include "amdgpu_reset.h"
 #include "gc/gc_9_0_offset.h"
 #include "gc/gc_9_0_sh_mask.h"
 #include "vega10_enum.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index e2ae9ba147ba..0eed6bb213b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -27,6 +27,7 @@
 #include "amdgpu.h"
 #include "amdgpu_sched.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include <linux/nospec.h>
 
 #define to_amdgpu_ctx_entity(e)	\
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 1ef892bea488..ab0e0f416584 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6283,11 +6283,6 @@ void amdgpu_device_invalidate_hdp(struct amdgpu_device *adev,
 	amdgpu_asic_invalidate_hdp(adev, ring);
 }
 
-int amdgpu_in_reset(struct amdgpu_device *adev)
-{
-	return atomic_read(&adev->reset_domain->in_gpu_reset);
-}
-
 /**
  * amdgpu_device_halt() - bring hardware to some kind of halt state
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index e114694d1131..9a6e7f401f9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -28,6 +28,7 @@
 #include "amdgpu_gfx.h"
 #include "amdgpu_rlc.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_xgmi.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3c2b1413058b..f3092a86d3a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -41,6 +41,7 @@
 #include "psp_v14_0.h"
 
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_securedisplay.h"
 #include "amdgpu_atomfirmware.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4baa300121d8..d1421bdb7f48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -162,6 +162,92 @@ void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
 	up_write(&reset_domain->sem);
 }
 
+/**
+ * amdgpu_in_reset() - check if we are in a GPU reset
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Check if we are in a GPU reset.  This function should only
+ * be used by functions that are part of the GPU reset sequence
+ * and recovery.  If functions want to be mutually exclusive
+ * with GPU resets they should enclose the relevant code in
+ * amdgpu_reset_domain_access_read_start() and
+ * amdgpu_reset_domain_access_read_end() or
+ * amdgpu_reset_domain_access_write_start() and
+ * amdgpu_reset_domain_access_write_end().
+ *
+ */
+int amdgpu_in_reset(struct amdgpu_device *adev)
+{
+	return atomic_read(&adev->reset_domain->in_gpu_reset);
+}
+
+/**
+ * amdgpu_reset_domain_access_read_start - call before accessing stuff that
+ *                                         might be affected by a GPU reset
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This function should be called before read access to anything that would
+ * be affected by a GPU reset. It must be paired with
+ * amdgpu_reset_domain_access_read_end().
+ *
+ * Returns any errors for taking the reset semaphore for reading.
+ */
+int amdgpu_reset_domain_access_read_start(struct amdgpu_device *adev)
+{
+	return down_read_killable(&adev->reset_domain->sem);
+}
+
+/**
+ * amdgpu_reset_domain_access_read_end - call after accessing stuff that
+ *                                       might be affected by a GPU reset
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This function should be called after read access to anything that would
+ * be affected by a GPU reset.  It must be paired with
+ * amdgpu_reset_domain_access_read_start().
+ *
+ */
+void amdgpu_reset_domain_access_read_end(struct amdgpu_device *adev)
+{
+	up_read(&adev->reset_domain->sem);
+}
+
+/**
+ * amdgpu_reset_domain_access_write_start - call before accessing stuff that
+ *                                          might be affected by a GPU reset
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This function should be called before write access to anything that would
+ * be affected by a GPU reset. It must be paired with
+ * amdgpu_reset_domain_access_write_end().
+ *
+ * Returns any errors for taking the reset semaphore for reading.
+ */
+int amdgpu_reset_domain_access_write_start(struct amdgpu_device *adev)
+{
+	return down_write_killable(&adev->reset_domain->sem);
+}
+
+/**
+ * amdgpu_reset_domain_access_write_end - call after accessing stuff that
+ *                                        might be affected by a GPU reset
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This function should be called after write access to anything that would
+ * be affected by a GPU reset.  It must be paired with
+ * amdgpu_reset_domain_access_write_start().
+ *
+ */
+void amdgpu_reset_domain_access_write_end(struct amdgpu_device *adev)
+{
+	up_write(&adev->reset_domain->sem);
+}
+
 #ifndef CONFIG_DEV_COREDUMP
 void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 		     struct amdgpu_reset_context *reset_context)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index 19899f6b9b2b..b0385cc35a80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -140,6 +140,12 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
 void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
 
+int amdgpu_in_reset(struct amdgpu_device *adev);
+int amdgpu_reset_domain_access_read_start(struct amdgpu_device *adev);
+void amdgpu_reset_domain_access_read_end(struct amdgpu_device *adev);
+int amdgpu_reset_domain_access_write_start(struct amdgpu_device *adev);
+void amdgpu_reset_domain_access_write_end(struct amdgpu_device *adev);
+
 void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 		     struct amdgpu_reset_context *reset_context);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 75c9fd2c6c2a..8a878c0fcaa4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -56,6 +56,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_sdma.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_hmm.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_res_cursor.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 0867fd9e15ba..8945f9347ae3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_ucode.h"
 
 static void amdgpu_ucode_print_common_hdr(const struct common_firmware_header *hdr)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 6ff7d3fb2008..4a43505b53f9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -32,6 +32,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "vi.h"
 #include "soc15.h"
 #include "nv.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index d6f808acfb17..114bf1178f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -25,6 +25,7 @@
 
 #include "soc15_common.h"
 #include "amdgpu_reg_state.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_xcp.h"
 #include "gfx_v9_4_3.h"
 #include "gfxhub_v1_2.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index b02d63328f1c..d6caac49dac6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
+#include "amdgpu_reset.h"
 #include "nv.h"
 #include "nvd.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 2fb1342d5bd9..de8291121a2e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -28,6 +28,7 @@
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
 #include "amdgpu_psp.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_smu.h"
 #include "amdgpu_atomfirmware.h"
 #include "imu_v11_0.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index ea174b76ee70..ce6e86a6f000 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -29,6 +29,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_ring.h"
 #include "vi.h"
 #include "vi_structs.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 169d45268ef6..a590bff32f1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -33,6 +33,7 @@
 #include "soc15d.h"
 #include "amdgpu_atomfirmware.h"
 #include "amdgpu_pm.h"
+#include "amdgpu_reset.h"
 
 #include "gc/gc_9_0_offset.h"
 #include "gc/gc_9_0_sh_mask.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
index 065b2bd5f5a6..dc2a60242a0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
@@ -30,6 +30,7 @@
 
 #include "gfx_v9_4_2.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_gfx.h"
 
 #define SE_ID_MAX 8
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aace4594a603..75c1a744dee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -24,6 +24,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
+#include "amdgpu_reset.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "soc15_common.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 6c68135cac9f..b9dae3edb26b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -26,6 +26,7 @@
 #include <drm/drm_cache.h>
 
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_atomfirmware.h"
 #include "gmc_v11_0.h"
 #include "umc_v8_10.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 1e5ad1e08d2a..b066da5e0d25 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "soc15_common.h"
 #include "nv.h"
 #include "gc/gc_10_1_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 26d71a22395d..0f59a7556d0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -24,6 +24,7 @@
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "soc15_common.h"
 #include "soc21.h"
 #include "gc/gc_11_0_0_offset.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fec5a3d1c4bc..c79e3d4e1270 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -27,6 +27,7 @@
 #include <linux/pci.h>
 
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_xcp.h"
 #include "amdgpu_ucode.h"
 #include "amdgpu_trace.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b9ac3d2f8029..41c43d9e604d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -48,6 +48,7 @@
 #include "vid.h"
 #include "amdgpu.h"
 #include "amdgpu_display.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_ucode.h"
 #include "atom.h"
 #include "amdgpu_dm.h"
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index e23a0a276e33..116726c2ec1b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -28,6 +28,7 @@
 
 #include "dc.h"
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_dm_psr.h"
 #include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_crtc.h"
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 087d57850304..8d7d6a507d3a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -27,6 +27,7 @@
 #include "amdgpu_drv.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_dpm.h"
+#include "amdgpu_reset.h"
 #include "atom.h"
 #include <linux/pci.h>
 #include <linux/hwmon.h>
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
index fe3665965416..8fb624a03bde 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/amd_powerplay.h
@@ -31,5 +31,6 @@
 #include "dm_pp_interface.h"
 #include "kgd_pp_interface.h"
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 
 #endif /* _AMD_POWERPLAY_H_ */
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index eedb9a4f7e2d..b2fb822156c3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -28,6 +28,7 @@
 #include <linux/reboot.h>
 
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_smu.h"
 #include "smu_internal.h"
 #include "atom.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 4cd43bbec910..d534ad6710ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -26,6 +26,7 @@
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_dpm.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_smu.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index f1440869d1ce..b6ef8925922c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -26,6 +26,7 @@
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_dpm.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_smu.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 29c102fe650d..bc58b8e67819 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -25,6 +25,7 @@
 
 #include <linux/firmware.h>
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_smu.h"
 #include "atomfirmware.h"
 #include "amdgpu_atomfirmware.h"
-- 
2.42.0

