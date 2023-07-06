Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B108EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 18:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AF7110E495;
	Thu,  6 Jul 2023 18:19:41 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB1F10E489
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 18:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b00uLXYfPR/tIbpVhHbv6iSGC/THP9yptKjY+l1sHpnZyIPqnPY8tUq3Acn8yZNqaJlfUNTF1Dl7Kc2KY9mgLQWPGbv7qB+3DdhaWfmul19GDa6G3Bfu8YKpjLRRq1HYr+q7CTJJkylXJje4GvDUbCyT9RgNUa44U+x7RzC/vzPeqj2EN8sjhQQK4pZBgrb+4Hrcq2qddXu0h4WhTtIU0lNXcfLpjhNQsG0GUcsdQ6MlFLOVju2BWjxxWPKNY/qycHjgjaroP17Gs3JHJVQHuswqrc2fhyzaxo6324542eQ74U9O+7+pF1GfiY2yg8FiT5ApInN1/7/OfPzu8FtmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiASKN7TnwkPIsbARXb9B+ygUAQR8AS+2V7ahEPwL/c=;
 b=WVpCxMZ1m/3KsTo8yg4P4KtQis4uNBckpN+j35sRW34zOI09gA0bP7DBtLqgJ0Z3NIeYpn0RGkAiNUCiCSGOLvikUHy0Ido4kz+W3dbO5sBEY9VJGBIzl7n+D/HbUDrO/5Mkl2bjAU3U/Sa8WsevVZdBOAjakizyE2qs8sIRecJdSpuChuu3ZAEUqU0meFuOZF6OuJLTkmRbjTIcvkguX+CHqQEUV9vZzmqQ00QDmq6ZUoJaJfeoCDZ2+p1vn4aULOheQ+fxXdAzSbDho2E//pUuWrT5fPFERC135YpX6LUp63Ysl3CwP2936/5JOifh7wTRpBthAd06R2QNejwA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiASKN7TnwkPIsbARXb9B+ygUAQR8AS+2V7ahEPwL/c=;
 b=bKbcJxKoK0f4srvVbpydldKncuSFtQq/YbfifhLOfxJl6bICAoEqi/7BZF02A0i2BKS/86P+6q7/DawFLd629pa3fERKI2MYtrDWE8/OIcnVVyp7OY1JTnj40MO64mWg3mSxBzQB0u7c81NsCEw+Qr3HlFGaM0NZpggZlCtberg=
Received: from MW4PR04CA0051.namprd04.prod.outlook.com (2603:10b6:303:6a::26)
 by DS0PR12MB7826.namprd12.prod.outlook.com (2603:10b6:8:148::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Thu, 6 Jul
 2023 18:19:35 +0000
Received: from CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::9f) by MW4PR04CA0051.outlook.office365.com
 (2603:10b6:303:6a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.18 via Frontend
 Transport; Thu, 6 Jul 2023 18:19:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT049.mail.protection.outlook.com (10.13.175.50) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Thu, 6 Jul 2023 18:19:35 +0000
Received: from eric-hp-elitebook-845-g7.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 6 Jul 2023 13:19:33 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/6] drm/amdkfd: add kfd2kgd debugger callbacks for GC v9.4.3
Date: Thu, 6 Jul 2023 14:19:13 -0400
Message-ID: <20230706181918.189722-2-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706181918.189722-1-jinhuieric.huang@amd.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT049:EE_|DS0PR12MB7826:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0fa34e-be83-4f63-84b6-08db7e4d8d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vDOzNQkp2lTROLw6+uartGyaHA90LgpY6lq99nhg0Za2hH5E/wIeqvNnmUMva41okoiM9QLmoirwJPMHZnB1EAX60Nlkg82PTyju1dRH39wTcsR643w5m7Wi2m+34EsJtajwIQXwcpF4dfVidavpMFH0yOO2yH3auG+JzP7oOHv7rcDX1dXA/flcA+n4I1YHlwS2DcgR+IRo1qP/DwL6fWFVE2Npa2M79Io7jrgsLQyB9UMv1jF8qsFGs9VzK5PqcehCiyo0ivX/JS0/zOwNcZ7cs9ls2g1TkGS46qaI67x7FRElUMUbNzQYLaU1tcn4kmYTfnUcVBP3KNxcedUfXIoyiqVzMXt08STYJkhlIjikF6jscWQZaJro7bixv9Pmf7rsE9XSIKQ/lfR9j+R4xNQ5DXd2hyTt7z46TZWvMkGHbO/5GeFD/yQMuAVDGP/sec+TYbJKuCFkY1gh+9TbQ9QxYMgvS7hVxa0GRFV4w21tjYmotpsazclywQnMaVjctxcPt7SHHW0Y7THCJzBz/m3teGRCCxz/zJB2beEGqpGHsqaX7xPtmDSklDAafAR0HUawAlwZfDyPwsvnRMeofT3eZuZRAkQBXvEDV4T+EUMTh7RPXNGYe+Pf2dAYO1X9pNSOsU7YWP9DrXo1/phOTgCgmJcJmPKvC/mGdvEKVG8GeZaZ4koBp8aONZJ2mgtLO9lo1L8i/N5JTerxdI6hGvjY04wIdjyrYhCn6ZZ/Sy012dD08ESbAvYCD9aa1YaeCEGsXuPhThiMIbfCtWCxvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(1076003)(26005)(5660300002)(186003)(86362001)(16526019)(8676002)(8936002)(30864003)(41300700001)(7696005)(2906002)(82310400005)(66899021)(316002)(4326008)(81166007)(6916009)(478600001)(2616005)(36860700001)(336012)(426003)(82740400003)(40460700003)(70586007)(70206006)(356005)(6666004)(47076005)(40480700001)(36756003)(54906003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 18:19:35.1997 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0fa34e-be83-4f63-84b6-08db7e4d8d6d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7826
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
Cc: Eric Huang <jinhuieric.huang@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jonathan Kim <jonathan.kim@amd.com>

Implement the similarities as GC v9.4.2, and the difference
for GC v9.4.3 HW spec, i.e. xcc instance.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  10 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  30 ++++
 .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 152 +++++++++++++++++-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   9 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  10 +-
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  15 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   3 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   3 +-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |   9 +-
 12 files changed, 230 insertions(+), 26 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
index 60f9e027fb66..7d7eaed68531 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
@@ -23,6 +23,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_arcturus.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_amdkfd_aldebaran.h"
 #include "gc/gc_9_4_2_offset.h"
 #include "gc/gc_9_4_2_sh_mask.h"
 #include <uapi/linux/kfd_ioctl.h>
@@ -36,7 +37,7 @@
  * initialize the debug mode registers after it has disabled GFX off during the
  * debug session.
  */
-static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
+uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
 					    bool restore_dbg_registers,
 					    uint32_t vmid)
 {
@@ -50,7 +51,7 @@ static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
 }
 
 /* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
-static uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
+uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
 						bool keep_trap_enabled,
 						uint32_t vmid)
 {
@@ -107,7 +108,7 @@ static uint32_t kgd_aldebaran_set_wave_launch_trap_override(struct amdgpu_device
 	return data;
 }
 
-static uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
 					uint8_t wave_launch_mode,
 					uint32_t vmid)
 {
@@ -125,7 +126,8 @@ static uint32_t kgd_gfx_aldebaran_set_address_watch(
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst )
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
new file mode 100644
index 000000000000..ed349ff397bd
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
+					bool restore_dbg_registers,
+					uint32_t vmid);
+uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
+					bool keep_trap_enabled,
+					uint32_t vmid);
+uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device *adev,
+					uint8_t wave_launch_mode,
+					uint32_t vmid);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
index 5b4b7f8b92a5..1880162a4581 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
@@ -22,6 +22,7 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_amdkfd_gfx_v9.h"
+#include "amdgpu_amdkfd_aldebaran.h"
 #include "gc/gc_9_4_3_offset.h"
 #include "gc/gc_9_4_3_sh_mask.h"
 #include "athub/athub_1_8_0_offset.h"
@@ -32,6 +33,7 @@
 #include "soc15.h"
 #include "sdma/sdma_4_4_2_offset.h"
 #include "sdma/sdma_4_4_2_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
 
 static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 {
@@ -361,6 +363,142 @@ static int kgd_gfx_v9_4_3_hqd_load(struct amdgpu_device *adev, void *mqd,
 	return 0;
 }
 
+static int kgd_gfx_v9_4_3_validate_trap_override_request(
+				struct amdgpu_device *adev,
+				uint32_t trap_override,
+				uint32_t *trap_mask_supported)
+{
+	*trap_mask_supported &= KFD_DBG_TRAP_MASK_FP_INVALID |
+	                        KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+	                        KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+	                        KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+	                        KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+	                        KFD_DBG_TRAP_MASK_FP_INEXACT |
+	                        KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+	                        KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+	                        KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |
+	                        KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |
+	                        KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+	if (trap_override != KFD_DBG_TRAP_OVERRIDE_OR &&
+			trap_override != KFD_DBG_TRAP_OVERRIDE_REPLACE)
+		return -EPERM;
+
+	return 0;
+}
+
+static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)
+{
+	uint32_t trap_on_start = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;
+	uint32_t trap_on_end = (mask & KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;
+	uint32_t excp_en = mask & (KFD_DBG_TRAP_MASK_FP_INVALID |
+				KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
+				KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_FP_OVERFLOW |
+				KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
+				KFD_DBG_TRAP_MASK_FP_INEXACT |
+				KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
+				KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
+				KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);
+	uint32_t ret;
+
+	ret = REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL, EXCP_EN, excp_en);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START, trap_on_start);
+	ret = REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END, trap_on_end);
+
+	return ret;
+}
+
+static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)
+{
+	uint32_t ret = REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, EXCP_EN);
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_START))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;
+
+	if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL, TRAP_ON_END))
+		ret |= KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
+
+	return ret;
+}
+
+/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
+static uint32_t kgd_gfx_v9_4_3_set_wave_launch_trap_override(
+				struct amdgpu_device *adev,
+				uint32_t vmid,
+				uint32_t trap_override,
+				uint32_t trap_mask_bits,
+				uint32_t trap_mask_request,
+				uint32_t *trap_mask_prev,
+				uint32_t kfd_dbg_trap_cntl_prev)
+
+{
+	uint32_t data = 0;
+
+	*trap_mask_prev = trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);
+
+	data = (trap_mask_bits & trap_mask_request) |
+	       (*trap_mask_prev & ~trap_mask_request);
+	data = trap_mask_map_sw_to_hw(data);
+
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+	data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, EXCP_REPLACE, trap_override);
+
+	return data;
+}
+
+#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H - regTCP_WATCH0_ADDR_H)
+static uint32_t kgd_gfx_v9_4_3_set_address_watch(
+				struct amdgpu_device *adev,
+				uint64_t watch_address,
+				uint32_t watch_address_mask,
+				uint32_t watch_id,
+				uint32_t watch_mode,
+				uint32_t debug_vmid,
+				uint32_t inst)
+{
+	uint32_t watch_address_high;
+	uint32_t watch_address_low;
+	uint32_t watch_address_cntl;
+
+	watch_address_cntl = 0;
+	watch_address_low = lower_32_bits(watch_address);
+	watch_address_high = upper_32_bits(watch_address) & 0xffff;
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MODE,
+			watch_mode);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			MASK,
+			watch_address_mask >> 7);
+
+	watch_address_cntl = REG_SET_FIELD(watch_address_cntl,
+			TCP_WATCH0_CNTL,
+			VALID,
+			1);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			regTCP_WATCH0_ADDR_H) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_high);
+
+	WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			regTCP_WATCH0_ADDR_L) +
+			(watch_id * TCP_WATCH_STRIDE)),
+			watch_address_low);
+
+	return watch_address_cntl;
+}
+
+static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device *adev,
+				uint32_t watch_id)
+{
+	return 0;
+}
+
 const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
@@ -380,5 +518,17 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd = {
 	.set_vm_context_page_table_base =
 				kgd_gfx_v9_set_vm_context_page_table_base,
 	.program_trap_handler_settings =
-				kgd_gfx_v9_program_trap_handler_settings
+				kgd_gfx_v9_program_trap_handler_settings,
+	.build_grace_period_packet_info =
+				kgd_gfx_v9_build_grace_period_packet_info,
+	.get_iq_wait_times = kgd_gfx_v9_get_iq_wait_times,
+	.enable_debug_trap = kgd_aldebaran_enable_debug_trap,
+	.disable_debug_trap = kgd_aldebaran_disable_debug_trap,
+	.validate_trap_override_request =
+			kgd_gfx_v9_4_3_validate_trap_override_request,
+	.set_wave_launch_trap_override =
+			kgd_gfx_v9_4_3_set_wave_launch_trap_override,
+	.set_wave_launch_mode = kgd_aldebaran_set_wave_launch_mode,
+	.set_address_watch = kgd_gfx_v9_4_3_set_address_watch,
+	.clear_address_watch = kgd_gfx_v9_4_3_clear_address_watch
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 8ad7a7779e14..f1f2c24de081 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -968,7 +969,8 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
  *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
  */
 void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
-					uint32_t *wait_times)
+					uint32_t *wait_times,
+					uint32_t inst)
 
 {
 	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
@@ -978,7 +980,8 @@ void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 						uint32_t wait_times,
 						uint32_t grace_period,
 						uint32_t *reg_offset,
-						uint32_t *reg_data)
+						uint32_t *reg_data,
+						uint32_t inst)
 {
 	*reg_data = wait_times;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
index e6b70196071a..ecaead24e8c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
@@ -44,12 +44,16 @@ uint32_t kgd_gfx_v10_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_id);
-void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
+void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
+				uint32_t *wait_times,
+				uint32_t inst);
 void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
-					       uint32_t *reg_data);
+					       uint32_t *reg_data,
+					       uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index 91c3574ebed3..77ca5cbfb601 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 51d93fb13ea3..7b1eea493377 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid)
+					uint32_t debug_vmid,
+					uint32_t inst)
 {
 	uint32_t watch_address_high;
 	uint32_t watch_address_low;
@@ -903,10 +904,12 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
  *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
  */
 void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
-					uint32_t *wait_times)
+					uint32_t *wait_times,
+					uint32_t inst)
 
 {
-	*wait_times = RREG32(SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2));
+	*wait_times = RREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			mmCP_IQ_WAIT_TIME2));
 }
 
 void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device *adev,
@@ -1100,7 +1103,8 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 		uint32_t wait_times,
 		uint32_t grace_period,
 		uint32_t *reg_offset,
-		uint32_t *reg_data)
+		uint32_t *reg_data,
+		uint32_t inst)
 {
 	*reg_data = wait_times;
 
@@ -1116,7 +1120,8 @@ void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 			SCH_WAVE,
 			grace_period);
 
-	*reg_offset = SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
+	*reg_offset = SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
+			mmCP_IQ_WAIT_TIME2);
 }
 
 void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 5f54bff0db49..936e501908ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -89,12 +89,16 @@ uint32_t kgd_gfx_v9_set_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
 					uint32_t watch_id);
-void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t *wait_times);
+void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
+				uint32_t *wait_times,
+				uint32_t inst);
 void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
 					       uint32_t wait_times,
 					       uint32_t grace_period,
 					       uint32_t *reg_offset,
-					       uint32_t *reg_data);
+					       uint32_t *reg_data,
+					       uint32_t inst);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index fff3ccc04fa9..24083db44724 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -466,7 +466,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 				watch_address_mask,
 				*watch_id,
 				watch_mode,
-				pdd->dev->vm_info.last_vmid_kfd);
+				pdd->dev->vm_info.last_vmid_kfd,
+				0);
 	amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
 
 	if (!pdd->dev->kfd->shared_resources.enable_mes)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index f515cb8f30ca..a2bff3f01359 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1621,7 +1621,7 @@ static int initialize_cpsch(struct device_queue_manager *dqm)
 
 	if (dqm->dev->kfd2kgd->get_iq_wait_times)
 		dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
-					&dqm->wait_times);
+					&dqm->wait_times, 0);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 29a2d0499b67..8fda16e6fee6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -298,7 +298,8 @@ static int pm_set_grace_period_v9(struct packet_manager *pm,
 			pm->dqm->wait_times,
 			grace_period,
 			&reg_offset,
-			&reg_data);
+			&reg_data,
+			0);
 
 	if (grace_period == USE_DEFAULT_GRACE_PERIOD)
 		reg_data = pm->dqm->wait_times;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index d0df3381539f..8433f99f6667 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -315,16 +315,19 @@ struct kfd2kgd_calls {
 					uint32_t watch_address_mask,
 					uint32_t watch_id,
 					uint32_t watch_mode,
-					uint32_t debug_vmid);
+					uint32_t debug_vmid,
+					uint32_t inst);
 	uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
 			uint32_t watch_id);
 	void (*get_iq_wait_times)(struct amdgpu_device *adev,
-			uint32_t *wait_times);
+			uint32_t *wait_times,
+			uint32_t inst);
 	void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
 			uint32_t wait_times,
 			uint32_t grace_period,
 			uint32_t *reg_offset,
-			uint32_t *reg_data);
+			uint32_t *reg_data,
+			uint32_t inst);
 	void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
 			int *wave_cnt, int *max_waves_per_cu, uint32_t inst);
 	void (*program_trap_handler_settings)(struct amdgpu_device *adev,
-- 
2.34.1

