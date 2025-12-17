Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C1ED65C70
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CB5310ED13;
	Wed, 17 Dec 2025 15:42:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c0HK1meB";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010044.outbound.protection.outlook.com [52.101.46.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208FE10ED13
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:42:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZ8t4HkRmlWP45mlTT390MvXuH9CaV4BvYPtsLRHyQkPAOviGE/RRz4s71m75PJSyoik8NRy6e7LHBOdydGPbl7YvONTPPMkqgKetJISkx9yWQlPPKtXUlI6RsnMZ3dk/YpMVNHdOMgHZwq4sMDE1TECwB8+53KnnRSJvwuGKTq+5gy6PV9KwnIKryg5tU+tbD9pbkbGjts0P1xcaaF2R8AZAmV+sCzdmLoiWV1XMqKcmJ5HTsFF0r0/fqBpnvVWahrUTEICmqgZ1YUEhtMXmpT2Pur66LdU1vlxtb9zK9BY7ZWBDIhkyQgCs9Dot+9QEzWDvIMbjRN1lNJ32Kw6Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4c95bCV/uLh9s7HTsmAFtG4g6mj87/yULNb8b7gKJA=;
 b=QPy96TgzHsU3z9fnSwlvQS9CKFV4iyNRSul5Q8SsktU/n0N7nJN68li0Sv0vqmdddiWkVN0YZyfeZj6GeEKKs26+eIvd9CrDF1CrKReodP0G7qDntLScLoR8/J9X4oyCudBDQ/Ia/pZmFliRmg50g8gbtFrKlomxyKs/vtyXX6zzwcMBqJbo+VqPVa8k+P/Z9gSWMfuJADPesOiAOReYTFPRxX9T/D9ifp5mIA1HUlEuMuitfSR9PmWjPXHP2j7/RgbqJx04RJlUtwfHWIRRnq+R9T+6+4zEGyxOwh0+TVIo30/A7sBcW6T1N0rsHzaWNtdtV/eKU4vQUnxMBmsrug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4c95bCV/uLh9s7HTsmAFtG4g6mj87/yULNb8b7gKJA=;
 b=c0HK1meB22yF3qL1lBlE6uXqw/ar01Bkuc+vdYbRlhBK/gbWEbh17epKjMGeVsvETa3FKWgAa6UjpijSscN5F4NQ0meUMtkrV7qR9/ybIKFP7YKqyLGsBY1uqFYwk0b481Wr3nkdI0UOj9pUofJ15h1+oABFgG6ipi6wEolZV58=
Received: from PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::29)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:42:13 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:510:d3:cafe::d3) by PH0P220CA0024.outlook.office365.com
 (2603:10b6:510:d3::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:42:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Wed, 17 Dec 2025 15:42:12 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:42:03 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Enable support for PSP 15_0_0
Date: Wed, 17 Dec 2025 10:41:50 -0500
Message-ID: <20251217154151.2018978-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217154151.2018978-1-alexander.deucher@amd.com>
References: <20251217154151.2018978-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7e1c92-a519-48d8-f4c3-08de3d82d89b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N+K1xNgt2NabrZ3E+J7Yc2jFjU1rdvENggNklR7Yk1VTP5GIQDXIq6FNUC+f?=
 =?us-ascii?Q?1kCzfrRixMrFG9OGPqT4bdySbmw5aoxII53TYz5gVkrknPfBFaLEC+sYDd+u?=
 =?us-ascii?Q?tHnk40LthlhbJxK/DepLsfs47coMfHiD/bNKvuijZ6lMWmVWH2D4lAohN1F0?=
 =?us-ascii?Q?bsUAaBD14HMbMAKHLVkf45AF2GCSFPvKRXTYGf8VGbngJDUyUGwEP4n1GwGn?=
 =?us-ascii?Q?3EFFkZDMNxY+mYdm4IUV2+daw4m87wEXAOY18/+6hvR6574PmktpQdmJE+lE?=
 =?us-ascii?Q?/zbj2CjnTnaaY5fEAmr+5HO2IyptbnWzzfQpQnsLRJY1SIioW44vYhML42gr?=
 =?us-ascii?Q?7yv4RYQ2ckIRBOs0hcpIKWZx/u4ZXMjka0aZqd0lFHvbO1qhQekisDrytYZ6?=
 =?us-ascii?Q?ag0Nu45jQ5DXQNoQNf8Ld/siTsFCd9mtRn9MQkw5AFEtzs6lKnMSNYOLoQw1?=
 =?us-ascii?Q?WPUtbIcvp8/1b4fx3L5R00F0yWPqE6zSwvSg+7Ub016K9nkCigDlZC/+Atk9?=
 =?us-ascii?Q?DynYiBIv6MnZEmBFOp+JfjCZ2kUivdocWcHdcS/zqbHKjmlzgZeolijox1iG?=
 =?us-ascii?Q?xF1AwDU9nrHiGJwdyedN5PjoN9R1dW8wBD+SqlZyKHzRBiLEYpODP2Y2dA73?=
 =?us-ascii?Q?N9t4lEg81mn6XUXeA0U7ZYN7fcYFXUa2p2T9Za9N2CY84GODn5qnSNzKtKiC?=
 =?us-ascii?Q?A7nrzb4/TZ7tVe9Jb4ODN1GZjbi7ZI5RRG0EbWQLAFqavDqaW/2LsjCIqBb+?=
 =?us-ascii?Q?dJET7Vwr5nKeB2KoH0FRPxx4CqeCGOcoyJxLpqjEhpowl8XRFrtgQnIb+b7M?=
 =?us-ascii?Q?BimzlkS7dXWH2FOwSOV90hn0I6DQ5Y11a9gL82zQOyBx/bZ2R3GcbukIdsh6?=
 =?us-ascii?Q?WJWDkyVNM3TOJ0oU4ZNgH/BWzcQJ4xqGWWhyd5BQtmBmTgayfamkNWDpvKPS?=
 =?us-ascii?Q?perIGrlDrcwZZ59EECLhyVWdwnG6qYzVrAOVTXpSJ4kDTVNvkSK9W9DMU5/r?=
 =?us-ascii?Q?tY/nv1OQoS5ZWZEV0IXnpmpRfW7XWGpSuf5WzpjClhkF/GaUBve0aWYD0gVq?=
 =?us-ascii?Q?ZktX3xSVy7VZIu023l18DB/nRQQDvSzD9TawEY7cN32UXM+en5AO+wSNAMqI?=
 =?us-ascii?Q?2yklhCQCp4DVlGVYJ0bzDSuhfhNKMjelNGUTaSIHbnZMKwKsQ2/0TDDZ12DJ?=
 =?us-ascii?Q?GRBh017McRySUHVo0ITFeN3DORu/js4tMION/BCv49rl1aH3my/BaK86STPE?=
 =?us-ascii?Q?XBm/f28BZzz3U5Kg1NmyLL+YnafJGric3FsqkvZZJwjGdrzR0w9T0gtckzDA?=
 =?us-ascii?Q?dbBYD3exy9RA7enj45VczSslFOtDhtY9IKZ07ufV7YGLfp3eDoSwhr8crZR+?=
 =?us-ascii?Q?m99A80id8+gEqy4fOWzLHxzCkcC9bumTQhGao8JrJZLFwXz74EZu0RiVC9Re?=
 =?us-ascii?Q?5VjNl0lTV2dWpeA4GVQ1HPCpmydEEK9H4fPjluSlKr00xGsIByVeh0ZSBD/7?=
 =?us-ascii?Q?n+rTdn0tM1Kz5/DSpJthYPwAQKm3QcdI0b2Q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:42:12.0995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7e1c92-a519-48d8-f4c3-08de3d82d89b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660
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

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Add support for PSP v 15.0.0.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       |  18 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |   1 +
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c        | 202 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h        |  30 +++
 6 files changed, 254 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/psp_v15_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 4b9cb9b681b65..a17b0c3efd4f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -136,6 +136,7 @@ amdgpu-y += \
 	psp_v13_0.o \
 	psp_v13_0_4.o \
 	psp_v14_0.o \
+	psp_v15_0.o \
 	psp_v15_0_8.o
 
 # add DCE block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 43e6216ca30f7..43fde853a3989 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2168,6 +2168,9 @@ static int amdgpu_discovery_set_psp_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 5):
 		amdgpu_device_ip_block_add(adev, &psp_v14_0_ip_block);
 		break;
+	case IP_VERSION(15, 0, 0):
+		amdgpu_device_ip_block_add(adev, &psp_v15_0_ip_block);
+		break;
 	case IP_VERSION(15, 0, 8):
 		amdgpu_device_ip_block_add(adev, &psp_v15_0_8_ip_block);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 4522fd77bbc36..08fb72adc9e9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -39,6 +39,7 @@
 #include "psp_v13_0.h"
 #include "psp_v13_0_4.h"
 #include "psp_v14_0.h"
+#include "psp_v15_0.h"
 #include "psp_v15_0_8.h"
 
 #include "amdgpu_ras.h"
@@ -260,6 +261,10 @@ static int psp_early_init(struct amdgpu_ip_block *ip_block)
 		psp_v14_0_set_psp_funcs(psp);
 		psp->boot_time_tmr = false;
 		break;
+	case IP_VERSION(15, 0, 0):
+		psp_v15_0_0_set_psp_funcs(psp);
+		psp->boot_time_tmr = false;
+		break;
 	case IP_VERSION(15, 0, 8):
 		psp_v15_0_8_set_psp_funcs(psp);
 		break;
@@ -905,6 +910,7 @@ static bool psp_skip_tmr(struct psp_context *psp)
 	case IP_VERSION(13, 0, 10):
 	case IP_VERSION(13, 0, 12):
 	case IP_VERSION(13, 0, 14):
+	case IP_VERSION(15, 0, 0):
 	case IP_VERSION(15, 0, 8):
 		return true;
 	default:
@@ -2927,7 +2933,7 @@ static int psp_prep_load_ip_fw_cmd_buf(struct psp_context *psp,
 
 	ret = psp_get_fw_type(psp, ucode, &cmd->cmd.cmd_load_ip_fw.fw_type);
 	if (ret)
-		dev_err(psp->adev->dev, "Unknown firmware type\n");
+		dev_err(psp->adev->dev, "Unknown firmware type %d\n", ucode->ucode_id);
 	return ret;
 }
 
@@ -3091,6 +3097,8 @@ static int psp_load_non_psp_fw(struct psp_context *psp)
 			     IP_VERSION(11, 0, 11) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
 			     IP_VERSION(11, 0, 12) ||
+		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
+			     IP_VERSION(15, 0, 0) ||
 		     amdgpu_ip_version(adev, MP0_HWIP, 0) ==
 			     IP_VERSION(15, 0, 8)) &&
 		    (ucode->ucode_id == AMDGPU_UCODE_ID_SDMA1 ||
@@ -4547,6 +4555,14 @@ const struct amdgpu_ip_block_version psp_v14_0_ip_block = {
 	.funcs = &psp_ip_funcs,
 };
 
+const struct amdgpu_ip_block_version psp_v15_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_PSP,
+	.major = 15,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &psp_ip_funcs,
+};
+
 const struct amdgpu_ip_block_version psp_v15_0_8_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_PSP,
 	.major = 15,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 973998a2dc95e..79a49cba8d406 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -540,6 +540,7 @@ extern const struct amdgpu_ip_block_version psp_v12_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v13_0_4_ip_block;
 extern const struct amdgpu_ip_block_version psp_v14_0_ip_block;
+extern const struct amdgpu_ip_block_version psp_v15_0_ip_block;
 extern const struct amdgpu_ip_block_version psp_v15_0_8_ip_block;
 
 int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
new file mode 100644
index 0000000000000..3aca293e2f0c4
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.c
@@ -0,0 +1,202 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+ *
+ */
+#include <drm/drm_drv.h>
+#include <linux/vmalloc.h>
+#include "amdgpu.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_ucode.h"
+#include "soc15_common.h"
+#include "psp_v15_0.h"
+
+#include "mp/mp_15_0_0_offset.h"
+#include "mp/mp_15_0_0_sh_mask.h"
+
+MODULE_FIRMWARE("amdgpu/psp_15_0_0_toc.bin");
+
+static int psp_v15_0_0_init_microcode(struct psp_context *psp)
+{
+	struct amdgpu_device *adev = psp->adev;
+	char ucode_prefix[30];
+	int err = 0;
+
+	amdgpu_ucode_ip_version_decode(adev, MP0_HWIP, ucode_prefix, sizeof(ucode_prefix));
+
+	err = psp_init_toc_microcode(psp, ucode_prefix);
+	if (err)
+		return err;
+
+	return 0;
+}
+
+static int psp_v15_0_0_ring_stop(struct psp_context *psp,
+			       enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+				   0x80000000, 0x80000000, false);
+	} else {
+		/* Write the ring destroy command*/
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64,
+			     GFX_CTRL_CMD_ID_DESTROY_RINGS);
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+		/* Wait for response flag (bit 31) */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+	}
+
+	return ret;
+}
+
+static int psp_v15_0_0_ring_create(struct psp_context *psp,
+				 enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	unsigned int psp_ring_reg = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		ret = psp_v15_0_0_ring_stop(psp, ring_type);
+		if (ret) {
+			DRM_ERROR("psp_v14_0_ring_stop_sriov failed!\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_102 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_103 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_103, psp_ring_reg);
+
+		/* Write the ring initialization command to C2PMSG_101 */
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_INIT_GPCOM_RING);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_101 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_101),
+				   0x80000000, 0x8000FFFF, false);
+
+	} else {
+		/* Wait for sOS ready for ring creation */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x80000000, false);
+		if (ret) {
+			DRM_ERROR("Failed to wait for trust OS ready for ring creation\n");
+			return ret;
+		}
+
+		/* Write low address of the ring to C2PMSG_69 */
+		psp_ring_reg = lower_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_69, psp_ring_reg);
+		/* Write high address of the ring to C2PMSG_70 */
+		psp_ring_reg = upper_32_bits(ring->ring_mem_mc_addr);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_70, psp_ring_reg);
+		/* Write size of ring to C2PMSG_71 */
+		psp_ring_reg = ring->ring_size;
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_71, psp_ring_reg);
+		/* Write the ring initialization command to C2PMSG_64 */
+		psp_ring_reg = ring_type;
+		psp_ring_reg = psp_ring_reg << 16;
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_64, psp_ring_reg);
+
+		/* there might be handshake issue with hardware which needs delay */
+		mdelay(20);
+
+		/* Wait for response flag (bit 31) in C2PMSG_64 */
+		ret = psp_wait_for(psp, SOC15_REG_OFFSET(MP0, 0, regMPASP_SMN_C2PMSG_64),
+				   0x80000000, 0x8000FFFF, false);
+	}
+
+	return ret;
+}
+
+static int psp_v15_0_0_ring_destroy(struct psp_context *psp,
+				  enum psp_ring_type ring_type)
+{
+	int ret = 0;
+	struct psp_ring *ring = &psp->km_ring;
+	struct amdgpu_device *adev = psp->adev;
+
+	ret = psp_v15_0_0_ring_stop(psp, ring_type);
+	if (ret)
+		DRM_ERROR("Fail to stop psp ring\n");
+
+	amdgpu_bo_free_kernel(&adev->firmware.rbuf,
+			      &ring->ring_mem_mc_addr,
+			      (void **)&ring->ring_mem);
+
+	return ret;
+}
+
+static uint32_t psp_v15_0_0_ring_get_wptr(struct psp_context *psp)
+{
+	uint32_t data;
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102);
+	else
+		data = RREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67);
+
+	return data;
+}
+
+static void psp_v15_0_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (amdgpu_sriov_vf(adev)) {
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_102, value);
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_101,
+			     GFX_CTRL_CMD_ID_CONSUME_CMD);
+	} else
+		WREG32_SOC15(MP0, 0, regMPASP_SMN_C2PMSG_67, value);
+}
+
+static const struct psp_funcs psp_v15_0_0_funcs = {
+	.init_microcode = psp_v15_0_0_init_microcode,
+	.ring_create = psp_v15_0_0_ring_create,
+	.ring_stop = psp_v15_0_0_ring_stop,
+	.ring_destroy = psp_v15_0_0_ring_destroy,
+	.ring_get_wptr = psp_v15_0_0_ring_get_wptr,
+	.ring_set_wptr = psp_v15_0_0_ring_set_wptr,
+};
+
+void psp_v15_0_0_set_psp_funcs(struct psp_context *psp)
+{
+	psp->funcs = &psp_v15_0_0_funcs;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
new file mode 100644
index 0000000000000..ebd612103526f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+ *
+ */
+#ifndef __PSP_V15_0_0_H__
+#define __PSP_V15_0_0_H__
+
+#include "amdgpu_psp.h"
+
+void psp_v15_0_0_set_psp_funcs(struct psp_context *psp);
+
+#endif
-- 
2.52.0

