Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCB1606A32A
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=xSMrBdQf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFC9D10E705;
	Mon,  9 Nov 2026 18:47:06 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013001.outbound.protection.outlook.com
 [40.93.196.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4104A10E1BB
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pOT6o1W5Rxo3ZYlR7KTFm4BEtExXv0ocNuCpJMZSUhZa5nxAv+k4DANyROiRmUT4nz3ACkmy3UD5mzqy+GpIWC17QzLRtmEisVlyr3p7dfT++kkzxmpyDwG0CgtfXg079fJFpAx50xc+S/tu/LeJWgw3YeCNQr+8Ia65Wml+xzMuJrgDbZOlZ9dT8OfRPTuv0jKzUL780Auo7f0FLa8reE1+xDZEmSbV9ga5niiZeF5fHYQdqdS8LSgC3Yplm9v5Wb0TlbaBhKwq7D54cKq42m++QQ/LIHw13TKMOUxRrDEFxfXA9faqp3A6+7UclLLr0eVH4zr3FQn4Sk0a/KKNRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZQ/VhBrosK87130r7YZ9/iGPmJd/DNU1DqEyl6dr1E=;
 b=IjHkhOUn8OSIT0uVHg5AIHQd9EvH4lhWp+iQIxZEvl88WCKtUngEmKpt/CEwtJoy5uPR9n2p36+QbXxad7pfj6VLQyrtHFiCEIsSBGEVNCJleT+QW70fJB9MzD9RJmoEkgEr0WJIHgE3RT2rOdZj9cF6jPuWEcyo7hTrp3arUTSgttqdowu/1MLIc1ulTrh92kmOFiewsBKpOWRQuzwyQsRSv+uSherHSy1IsJGvawFTwIt5z3phGar7UfUV6hSs90CcKh0769LMrXyJ0X73EvCkcdpwv2AGjTUgRSpxGaJJ/6yOMwIE0hbGb2vHoWWLpcPcap2cR+RGch4+rtj0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZQ/VhBrosK87130r7YZ9/iGPmJd/DNU1DqEyl6dr1E=;
 b=xSMrBdQfCP8E9otWTZni1AtKJE+QYlDGUlOdPTNwkaJ9PfSGSaM5TcVz9T6hEDyWIsimOPWdqtaMRaUbo5Lu4tz7ne7rdgQSV/Z3ExX3+Ap1cgdHfH74cswgc0m9GO+ABAsz4MitWswGfP89E3eInA8hcqm2m/fRA0VCcIXiNQ0=
Received: from SJ0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:a03:33e::6)
 by CY8PR12MB7266.namprd12.prod.outlook.com (2603:10b6:930:56::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:46:50 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::4) by SJ0PR03CA0031.outlook.office365.com
 (2603:10b6:a03:33e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Mon, 9
 Nov 2026 18:46:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:46:50 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:48 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Likun Gao <Likun.Gao@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/8] drm/amdgpu: Add gfx v13 ip block
Date: Mon, 9 Nov 2026 13:46:34 -0500
Message-ID: <20261109184641.3656885-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184641.3656885-1-alexander.deucher@amd.com>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|CY8PR12MB7266:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e17413-10de-4ece-07ee-08df3e91d0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|6133799003|10067099003|3023799007|5023799004|11063799006|56012099006|261028144727099003|261009220027099003|261102123227099003|261009221727099003|261022115727099003|261022113327099003|261022105027099003|261022075727099003|261021123027099003|261021133027099003|261021121427099003|261021135927099003|261021130227099003|261026135527099003|261026130827099003|261026140227099003|261009223027099003|261009221227099003|261009223327099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: yjPJfppLjtPwGvpg71/Prbtf54Xc4eQ85x6BrzVp6J3AV2CUWFGt9QPmEa9FCO4VEWrf0iOwBhxzKq10ErolWjW4Xa/wIyXboil8sPk742HYm1+2rKjWuZlosTnqmvI/BBjYaR7i4cA1N8WjMNyQPNxhchpQHg4UqxomCrX4SQUYmkbgxHlBLWqLjiKkm8t4ObhW+qN8PZM7WMlOQVOo+P9o/WZIidx6d2bACiYCRQORpM0zCq67emjpQS0AiMNU3MVjw4c0NNgKbHsS3tpckm6k/Ep+CKWLD/E8gbQN4LJM+xe1t9yMho1qQ0J/mzsGittRNBHHXdLKJ2I+HMDubsikkSrXkP/gIQsv4YpHWVjQXXq/0FImBqDk5qnNbjETD5tbp7fNOiPEQ9Td/ICCfvTnrKdRN2epWcE7XTNAG/J7/2Tny4VNNHWXgAh/Wtt5p9XPRusBy/qbeVInYB6rOpPuUrlZCkbYe+9uEJB9qAu7vlYaqTlfHUW13+n6cVMs3pGtE1z/c2rg6VZoRFXGt1JglxpNoesDHo+vcktKBeo/yW7l4Ooy94vmkMp5G6DgfTcotM+iV7S2FnCU0og+qAxQ4kTzc3/7ZHlrsbxstnHThWUB5lXRA+bRXVEmepX5C58Lepocza/M2lbRxf2Pb8lsdwLvza7sYU3qqDbxMYhBdYvLTOjSqKG2ZOPTpLl5lXWLobZMZVqS4xSdwFOOiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(5023799004)(11063799006)(56012099006)(261028144727099003)(261009220027099003)(261102123227099003)(261009221727099003)(261022115727099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021133027099003)(261021121427099003)(261021135927099003)(261021130227099003)(261026135527099003)(261026130827099003)(261026140227099003)(261009223027099003)(261009221227099003)(261009223327099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WfjbMMY0eFdbbtzAFepmR1aqH5GhPvIFSdauFzLvL9+ysxlBybAvBhmZ7iWuDVr+bZk//2rXCdZ+KPplC5h0YLRqroJPlLljPR9Ie83W6GB3w1hZPK4aLd2ByYHaJJCBfP94A5Nso+JLilY63pgo6iIS29iNJG8EiZPVc3MuQHQUX7jY6IeQmyjTnTUChm69eLYh+nwrPVmTvtlP0tmmMtmbrACM/BMCY7wvSRqLIzeEwlsxp01RY8aRYCUadn9W6zTzOMz74Gr0ZxWXGIws/O11RrKzHG8iDt3EqnyzrH0dc68J7VGizrK7JYPz5MBXDF8TqUmslxpdluGx9F0XM2td+ZaaSpug9S4YI9QckoGMb+4WbIvP9Q9qFFcA7qGamxxPUjj17Duv94TImIRw4vAXS2k0AV6gb6j1M/yW/wuijRhuT9tp7jSMbKlF2Gcf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:50.0385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e17413-10de-4ece-07ee-08df3e91d0a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7266
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Min <Frank.Min@amd.com>

Add gfx v13 ip block.
V2: Re-emit the unprocessed state after resetting the queue.
Drop the soft_recovery callbacks as the queue reset replaces
it. Kernel gfx queues do not need to be reinitialized or
remapped after a reset.  Align with gfx12.

v2: rebase (Alex)
v3: squash in MQD updates
v4: rebase (Alex)
v5: squash in various fixes

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    7 +
 drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h |  121 +
 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c        | 5799 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h        |   31 +
 drivers/gpu/drm/amd/amdgpu/nvd.h              |    2 +
 drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h       |  680 ++
 .../include/asic_reg/gc/gc_13_0_1_sh_mask.h   |    2 +
 include/uapi/drm/amdgpu_drm.h                 |    1 +
 9 files changed, 6645 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 92236baf43498..b4ee78f9943aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -171,7 +171,8 @@ amdgpu-y += \
 	gfx_v12_1.o \
 	imu_v12_0.o \
 	imu_v12_1.o \
-	imu_v13_0.o
+	imu_v13_0.o \
+	gfx_v13_0.o
 
 # add async DMA block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9d500e4d01951..c929356c2e795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -90,6 +90,7 @@
 #include "gfx_v11_0.h"
 #include "gfx_v12_0.h"
 #include "gfx_v12_1.h"
+#include "gfx_v13_0.h"
 #include "sdma_v5_0.h"
 #include "sdma_v5_2.h"
 #include "sdma_v6_0.h"
@@ -3155,6 +3156,9 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(12, 1, 0):
 		amdgpu_device_ip_block_add(adev, &gfx_v12_1_ip_block);
 		break;
+	case IP_VERSION(13, 0, 1):
+		amdgpu_device_ip_block_add(adev, &gfx_v13_0_ip_block);
+		break;
 	default:
 		dev_err(adev->dev, "Failed to add gfx ip block(GC_HWIP:0x%x)\n",
 			amdgpu_ip_version(adev, GC_HWIP, 0));
@@ -3810,6 +3814,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(12, 1, 0):
 		adev->family = AMDGPU_FAMILY_GC_12_0_0;
 		break;
+	case IP_VERSION(13, 0, 1):
+		adev->family = AMDGPU_FAMILY_GC_13_0_0;
+		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h
new file mode 100644
index 0000000000000..6448adf16d87d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/clearstate_gfx13.h
@@ -0,0 +1,121 @@
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
+#ifndef __CLEARSTATE_GFX13_H_
+#define __CLEARSTATE_GFX13_H_
+
+static const unsigned int gfx13_SECT_CONTEXT_def_1[] = {
+0x00000000, //mmSC_MEM_TEMPORAL
+0x00000000, //mmSC_MEM_SPEC_READ
+0x00000000, //mmPA_SC_VPORT_0_TL
+0x00000000, //mmPA_SC_VPORT_0_BR
+0x00000000, //mmPA_SC_VPORT_1_TL
+0x00000000, //mmPA_SC_VPORT_1_BR
+0x00000000, //mmPA_SC_VPORT_2_TL
+0x00000000, //mmPA_SC_VPORT_2_BR
+0x00000000, //mmPA_SC_VPORT_3_TL
+0x00000000, //mmPA_SC_VPORT_3_BR
+0x00000000, //mmPA_SC_VPORT_4_TL
+0x00000000, //mmPA_SC_VPORT_4_BR
+0x00000000, //mmPA_SC_VPORT_5_TL
+0x00000000, //mmPA_SC_VPORT_5_BR
+0x00000000, //mmPA_SC_VPORT_6_TL
+0x00000000, //mmPA_SC_VPORT_6_BR
+0x00000000, //mmPA_SC_VPORT_7_TL
+0x00000000, //mmPA_SC_VPORT_7_BR
+0x00000000, //mmPA_SC_VPORT_8_TL
+0x00000000, //mmPA_SC_VPORT_8_BR
+0x00000000, //mmPA_SC_VPORT_9_TL
+0x00000000, //mmPA_SC_VPORT_9_BR
+0x00000000, //mmPA_SC_VPORT_10_TL
+0x00000000, //mmPA_SC_VPORT_10_BR
+0x00000000, //mmPA_SC_VPORT_11_TL
+0x00000000, //mmPA_SC_VPORT_11_BR
+0x00000000, //mmPA_SC_VPORT_12_TL
+0x00000000, //mmPA_SC_VPORT_12_BR
+0x00000000, //mmPA_SC_VPORT_13_TL
+0x00000000, //mmPA_SC_VPORT_13_BR
+0x00000000, //mmPA_SC_VPORT_14_TL
+0x00000000, //mmPA_SC_VPORT_14_BR
+0x00000000, //mmPA_SC_VPORT_15_TL
+0x00000000, //mmPA_SC_VPORT_15_BR
+};
+
+static const unsigned int gfx13_SECT_CONTEXT_def_2[] = {
+0x00000000, //mmPA_CL_PROG_NEAR_CLIP_Z
+0x00000000, //mmPA_RATE_CNTL
+};
+
+static const unsigned int gfx13_SECT_CONTEXT_def_3[] = {
+0x00000000, //mmCP_PERFMON_CNTX_CNTL
+};
+
+static const unsigned int gfx13_SECT_CONTEXT_def_4[] = {
+0x00000000, //mmCONTEXT_RESERVED_REG0
+0x00000000, //mmCONTEXT_RESERVED_REG1
+0x00000000, //mmPA_SC_CLIPRECT_0_EXT
+0x00000000, //mmPA_SC_CLIPRECT_1_EXT
+0x00000000, //mmPA_SC_CLIPRECT_2_EXT
+0x00000000, //mmPA_SC_CLIPRECT_3_EXT
+};
+
+static const unsigned int gfx13_SECT_CONTEXT_def_5[] = {
+0x00000000, //mmPA_SC_HIZ_INFO
+0x00000000, //mmPA_SC_HIS_INFO
+0x00000000, //mmPA_SC_HIZ_BASE
+0x00000000, //mmPA_SC_HIZ_BASE_EXT
+0x00000000, //mmPA_SC_HIZ_SIZE_XY
+0x00000000, //mmPA_SC_HIS_BASE
+0x00000000, //mmPA_SC_HIS_BASE_EXT
+0x00000000, //mmPA_SC_HIS_SIZE_XY
+0x00000000, //mmPA_SC_BINNER_OUTPUT_TIMEOUT_CNTL
+0x00000000, //mmPA_SC_BINNER_DYNAMIC_BATCH_LIMIT
+0x00000000, //mmPA_SC_HISZ_CONTROL
+};
+
+static const unsigned int gfx13_SECT_CONTEXT_def_6[] = {
+0x00000000, //mmCB_MEM0_INFO
+0x00000000, //mmCB_MEM1_INFO
+0x00000000, //mmCB_MEM2_INFO
+0x00000000, //mmCB_MEM3_INFO
+0x00000000, //mmCB_MEM4_INFO
+0x00000000, //mmCB_MEM5_INFO
+0x00000000, //mmCB_MEM6_INFO
+0x00000000, //mmCB_MEM7_INFO
+};
+
+static const struct cs_extent_def gfx13_SECT_CONTEXT_defs[] = {
+    {gfx13_SECT_CONTEXT_def_1, 0x0000a03e, 34 },
+    {gfx13_SECT_CONTEXT_def_2, 0x0000a0cc, 2 },
+    {gfx13_SECT_CONTEXT_def_3, 0x0000a0d8, 1 },
+    {gfx13_SECT_CONTEXT_def_4, 0x0000a0db, 6 },
+    {gfx13_SECT_CONTEXT_def_5, 0x0000a2e5, 11 },
+    {gfx13_SECT_CONTEXT_def_6, 0x0000a3c0, 8 },
+    { 0, 0, 0 }
+};
+
+static const struct cs_section_def gfx13_cs_data[] = {
+    { gfx13_SECT_CONTEXT_defs, SECT_CONTEXT },
+    { 0, SECT_NONE }
+};
+
+#endif /* __CLEARSTATE_GFX13_H_ */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
new file mode 100644
index 0000000000000..41e85d8bd9bd2
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
@@ -0,0 +1,5799 @@
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
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include "amdgpu.h"
+#include "amdgpu_gfx.h"
+#include "amdgpu_psp.h"
+#include "amdgpu_smu.h"
+#include "imu_v13_0.h"
+#include "soc_v2_0.h"
+#include "soc_v2_0_d.h"
+
+#include "gc/gc_13_0_1_offset.h"
+#include "gc/gc_13_0_1_sh_mask.h"
+#include "soc24_enum.h"
+#include "ivsrcid/gfx/irqsrcs_gfx_13_0_1.h"	//TODO: check with model definition
+
+#include "soc15.h"
+#include "clearstate_gfx13.h"
+#include "v13_structs.h"
+#include "gfx_v13_0.h"
+#include "nbif_v7_10.h"
+#include "mes_userqueue.h"
+#include "amdgpu_userq_fence.h"
+
+#define GFX13_NUM_GFX_RINGS	2
+#define GFX13_MEC_HPD_SIZE	2048
+
+#define RLCG_UCODE_LOADING_START_ADDRESS	0x00002000L
+
+#define regCP_GFX_MQD_CONTROL_DEFAULT                                             0x00000100
+#define regCP_GFX_HQD_VMID_DEFAULT                                                0x00000000
+#define regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT                                      0x00000000
+#define regCP_GFX_HQD_QUANTUM_DEFAULT                                             0x00000a01
+#define regCP_GFX_HQD_CNTL_DEFAULT                                                0x00f00000
+#define regCP_RB_DOORBELL_CONTROL_DEFAULT                                         0x00000000
+#define regCP_GFX_HQD_RPTR_DEFAULT                                                0x00000000
+
+#define regCP_HQD_EOP_CONTROL_DEFAULT                                             0x00000006
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_MQD_CONTROL_DEFAULT                                                 0x00000100
+#define regCP_HQD_PQ_CONTROL_DEFAULT                                              0x00308509
+#define regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT                                     0x00000000
+#define regCP_HQD_PQ_RPTR_DEFAULT                                                 0x00000000
+#define regCP_HQD_PERSISTENT_STATE_DEFAULT                                        0x0be06501
+#define regCP_HQD_IB_CONTROL_DEFAULT                                              0x00100000
+
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_pfp.bin");
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_me.bin");
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_mec.bin");
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_rlc.bin");
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_toc.bin");
+
+static const struct amdgpu_hwip_reg_entry gc_reg_list_13_0[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
+	SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	/* SE status registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE3)
+};
+
+static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_13[] = {
+	/* compute registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+};
+
+static const struct amdgpu_hwip_reg_entry gc_gfx_queue_reg_list_13[] = {
+	/* gfx queue registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_ACTIVE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_VMID),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUEUE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUANTUM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_CSMD_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_DEQUEUE_REQUEST),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_MAPPED),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_QUE_MGR_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_HQ_CONTROL0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HQD_HQ_STATUS0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_MQD_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_MQD_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR_POLL_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR_POLL_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_HEADER_DUMP),
+};
+
+static const struct soc15_reg_golden golden_settings_gc_13_0_rev0[] = {
+
+};
+
+static const struct soc15_reg_golden golden_settings_gc_13_0[] = {
+};
+
+#define DEFAULT_SH_MEM_CONFIG \
+	((SH_MEM_ADDRESS_MODE_64 << SH_MEM_CONFIG__ADDRESS_MODE__SHIFT) | \
+	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
+	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
+
+static void gfx_v13_0_disable_gpa_mode(struct amdgpu_device *adev);
+static void gfx_v13_0_set_ring_funcs(struct amdgpu_device *adev);
+static void gfx_v13_0_set_irq_funcs(struct amdgpu_device *adev);
+static void gfx_v13_0_set_rlc_funcs(struct amdgpu_device *adev);
+static void gfx_v13_0_set_mqd_funcs(struct amdgpu_device *adev);
+static void gfx_v13_0_set_imu_funcs(struct amdgpu_device *adev);
+static int gfx_v13_0_get_cu_info(struct amdgpu_device *adev,
+				 struct amdgpu_cu_info *cu_info);
+static uint64_t gfx_v13_0_get_gpu_clock_counter(struct amdgpu_device *adev);
+static void gfx_v13_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
+				   u32 sh_num, u32 instance, int xcc_id);
+static u32 gfx_v13_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev);
+
+static void gfx_v13_0_ring_emit_frame_cntl(struct amdgpu_ring *ring, bool start, bool secure);
+static void gfx_v13_0_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+				     uint32_t val);
+static int gfx_v13_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev);
+static void gfx_v13_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
+					   uint16_t pasid, uint32_t flush_type,
+					   bool all_hub, uint8_t dst_sel);
+static void gfx_v13_0_set_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v13_0_unset_safe_mode(struct amdgpu_device *adev, int xcc_id);
+static void gfx_v13_0_update_perf_clk(struct amdgpu_device *adev,
+				      bool enable);
+
+static void gfx_v13_0_kiq_set_resources(struct amdgpu_ring *kiq_ring,
+					uint64_t queue_mask)
+{
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
+	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
+			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
+	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
+	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
+	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
+	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
+	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
+	amdgpu_ring_write(kiq_ring, 0);
+}
+
+static void gfx_v13_0_kiq_map_queues(struct amdgpu_ring *kiq_ring,
+				     struct amdgpu_ring *ring)
+{
+	uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
+	uint64_t wptr_addr = ring->wptr_gpu_addr;
+	uint32_t me = 0, eng_sel = 0;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_COMPUTE:
+		me = 0;
+		eng_sel = 0;
+		break;
+	case AMDGPU_RING_TYPE_GFX:
+		me = 0;
+		eng_sel = 4;
+		break;
+	case AMDGPU_RING_TYPE_MES:
+		me = 2;
+		eng_sel = 5;
+		break;
+	default:
+		WARN_ON(1);
+	}
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3_MAP_QUEUES_EXT_ENG_SEL(0) | /* legacy engine = 0, sdma = 1 */
+			  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* specified queue = 0, hws queue = 1 */
+			  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
+			  PACKET3_MAP_QUEUES_GWS_ENABLE(0) |
+			  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
+			  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
+			  PACKET3_MAP_QUEUES_ME((me)) |
+			  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
+			  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
+			  PACKET3_MAP_QUEUES_ENGINE_SEL(eng_sel) |
+			  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
+	amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
+	amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
+	amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
+	amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
+	amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
+}
+
+static void gfx_v13_0_kiq_unmap_queues(struct amdgpu_ring *kiq_ring,
+				       struct amdgpu_ring *ring,
+				       enum amdgpu_unmap_queues_action action,
+				       u64 gpu_addr, u64 seq)
+{
+	struct amdgpu_device *adev = kiq_ring->adev;
+	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+
+	if (adev->enable_mes && !adev->gfx.kiq[0].ring.sched.ready) {
+		amdgpu_mes_unmap_legacy_queue(adev, ring, action,
+					      gpu_addr, seq, 0);
+		return;
+	}
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_UNMAP_QUEUES, 4));
+	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_UNMAP_QUEUES_ACTION(action) |
+			  PACKET3_UNMAP_QUEUES_QUEUE_SEL(0) |
+			  PACKET3_UNMAP_QUEUES_ENGINE_SEL(eng_sel) |
+			  PACKET3_UNMAP_QUEUES_NUM_QUEUES(1));
+	amdgpu_ring_write(kiq_ring,
+		  PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(ring->doorbell_index));
+
+	if (action == PREEMPT_QUEUES_NO_UNMAP) {
+		amdgpu_ring_write(kiq_ring, lower_32_bits(gpu_addr));
+		amdgpu_ring_write(kiq_ring, upper_32_bits(gpu_addr));
+		amdgpu_ring_write(kiq_ring, seq);
+	} else {
+		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_write(kiq_ring, 0);
+		amdgpu_ring_write(kiq_ring, 0);
+	}
+}
+
+static void gfx_v13_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
+				       struct amdgpu_ring *ring,
+				       u64 addr, u64 seq)
+{
+	uint32_t eng_sel = ring->funcs->type == AMDGPU_RING_TYPE_GFX ? 4 : 0;
+
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_QUERY_STATUS, 5));
+	amdgpu_ring_write(kiq_ring,
+			  PACKET3_QUERY_STATUS_CONTEXT_ID(0) |
+			  PACKET3_QUERY_STATUS_INTERRUPT_SEL(0) |
+			  PACKET3_QUERY_STATUS_COMMAND(2));
+	amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
+			  PACKET3_QUERY_STATUS_DOORBELL_OFFSET(ring->doorbell_index) |
+			  PACKET3_QUERY_STATUS_ENG_SEL(eng_sel));
+	amdgpu_ring_write(kiq_ring, lower_32_bits(addr));
+	amdgpu_ring_write(kiq_ring, upper_32_bits(addr));
+	amdgpu_ring_write(kiq_ring, lower_32_bits(seq));
+	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
+}
+
+static void gfx_v13_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
+					  uint16_t pasid,
+					  uint32_t flush_type,
+					  bool all_hub)
+{
+	gfx_v13_0_ring_invalidate_tlbs(kiq_ring, pasid, flush_type, all_hub, 1);
+}
+
+static const struct kiq_pm4_funcs gfx_v13_0_kiq_pm4_funcs = {
+	.kiq_set_resources = gfx_v13_0_kiq_set_resources,
+	.kiq_map_queues = gfx_v13_0_kiq_map_queues,
+	.kiq_unmap_queues = gfx_v13_0_kiq_unmap_queues,
+	.kiq_query_status = gfx_v13_0_kiq_query_status,
+	.kiq_invalidate_tlbs = gfx_v13_0_kiq_invalidate_tlbs,
+	.set_resources_size = 8,
+	.map_queues_size = 7,
+	.unmap_queues_size = 6,
+	.query_status_size = 7,
+	.invalidate_tlbs_size = 2,
+};
+
+static void gfx_v13_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.kiq[0].pmf = &gfx_v13_0_kiq_pm4_funcs;
+}
+
+static void gfx_v13_0_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
+				   int mem_space, int opt, uint32_t addr0,
+				   uint32_t addr1, uint32_t ref,
+				   uint32_t mask, uint32_t inv)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
+	amdgpu_ring_write(ring,
+			  /* memory (1) or register (0) */
+			  (WAIT_REG_MEM_MEM_SPACE(mem_space) |
+			   WAIT_REG_MEM_OPERATION(opt) | /* wait */
+			   WAIT_REG_MEM_FUNCTION(3) |  /* equal */
+			   WAIT_REG_MEM_ENGINE(eng_sel)));
+
+	if (mem_space)
+		BUG_ON(addr0 & 0x3); /* Dword align */
+	amdgpu_ring_write(ring, addr0);
+	amdgpu_ring_write(ring, addr1);
+	amdgpu_ring_write(ring, ref);
+	amdgpu_ring_write(ring, mask);
+	amdgpu_ring_write(ring, inv); /* poll interval */
+}
+
+static int gfx_v13_0_ring_test_ring(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t scratch = SOC15_REG_OFFSET(GC, 0, regSCRATCH_REG0);
+	uint32_t tmp = 0;
+	unsigned i;
+	int r;
+
+	WREG32(scratch, 0xCAFEDEAD);
+	r = amdgpu_ring_alloc(ring, 5);
+	if (r) {
+		dev_err(adev->dev,
+			"amdgpu: cp failed to lock ring %d (%d).\n",
+			ring->idx, r);
+		return r;
+	}
+
+	if (ring->funcs->type == AMDGPU_RING_TYPE_KIQ) {
+		gfx_v13_0_ring_emit_wreg(ring, scratch, 0xDEADBEEF);
+	} else {
+		amdgpu_ring_write(ring, PACKET3(PACKET3_SET_UCONFIG_REG, 1));
+		amdgpu_ring_write(ring, scratch -
+				  PACKET3_SET_UCONFIG_REG_START);
+		amdgpu_ring_write(ring, 0xDEADBEEF);
+	}
+	amdgpu_ring_commit(ring);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		tmp = RREG32(scratch);
+		if (tmp == 0xDEADBEEF)
+			break;
+		if (amdgpu_emu_mode == 1)
+			msleep(1);
+		else
+			udelay(1);
+	}
+
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+	return r;
+}
+
+static int gfx_v13_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	struct dma_fence *f = NULL;
+	unsigned index;
+	uint64_t gpu_addr;
+	volatile uint32_t *cpu_ptr;
+	long r;
+
+	/* MES KIQ fw hasn't indirect buffer support for now */
+	if (adev->enable_mes_kiq &&
+	    ring->funcs->type == AMDGPU_RING_TYPE_KIQ)
+		return 0;
+
+	r = amdgpu_wb_get(adev, &index);
+	if (r)
+		return r;
+
+	gpu_addr = adev->wb.gpu_addr + (index * 4);
+	adev->wb.wb[index] = cpu_to_le32(0xCAFEDEAD);
+	cpu_ptr = &adev->wb.wb[index];
+
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL, NULL, 16,
+				     AMDGPU_IB_POOL_DIRECT,
+				     AMDGPU_KERNEL_JOB_ID_GFX_RING_TEST,
+				     &job);
+	if (r) {
+		dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
+		goto err1;
+	}
+	ib = &job->ibs[0];
+
+	ib->ptr[0] = PACKET3(PACKET3_WRITE_DATA, 3);
+	ib->ptr[1] = WRITE_DATA_DST_SEL(5) | WR_CONFIRM;
+	ib->ptr[2] = lower_32_bits(gpu_addr);
+	ib->ptr[3] = upper_32_bits(gpu_addr);
+	ib->ptr[4] = 0xDEADBEEF;
+	ib->length_dw = 5;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r) {
+		amdgpu_job_free(job);
+		goto err2;
+	}
+
+	r = dma_fence_wait_timeout(f, false, timeout);
+	if (r == 0) {
+		r = -ETIMEDOUT;
+		goto err2;
+	} else if (r < 0) {
+		goto err2;
+	}
+
+	if (le32_to_cpu(*cpu_ptr) == 0xDEADBEEF)
+		r = 0;
+	else
+		r = -EINVAL;
+err2:
+	dma_fence_put(f);
+err1:
+	amdgpu_wb_free(adev, index);
+	return r;
+}
+
+static void gfx_v13_0_free_microcode(struct amdgpu_device *adev)
+{
+	amdgpu_ucode_release(&adev->gfx.pfp_fw);
+	amdgpu_ucode_release(&adev->gfx.me_fw);
+	amdgpu_ucode_release(&adev->gfx.rlc_fw);
+	amdgpu_ucode_release(&adev->gfx.mec_fw);
+
+	kfree(adev->gfx.rlc.register_list_format);
+}
+
+static int gfx_v13_0_init_toc_microcode(struct amdgpu_device *adev, const char *ucode_prefix)
+{
+	const struct psp_firmware_header_v1_0 *toc_hdr;
+	int err = 0;
+
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
+				   AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_toc.bin", ucode_prefix);
+	if (err)
+		goto out;
+
+	toc_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.toc_fw->data;
+	adev->psp.toc.fw_version = le32_to_cpu(toc_hdr->header.ucode_version);
+	adev->psp.toc.feature_version = le32_to_cpu(toc_hdr->sos.fw_version);
+	adev->psp.toc.size_bytes = le32_to_cpu(toc_hdr->header.ucode_size_bytes);
+	adev->psp.toc.start_addr = (uint8_t *)toc_hdr +
+			le32_to_cpu(toc_hdr->header.ucode_array_offset_bytes);
+	return 0;
+out:
+	amdgpu_ucode_release(&adev->psp.toc_fw);
+	return err;
+}
+
+static int gfx_v13_0_init_microcode(struct amdgpu_device *adev)
+{
+	char ucode_prefix[15];
+	int err;
+	const struct rlc_firmware_header_v2_0 *rlc_hdr;
+	uint16_t version_major;
+	uint16_t version_minor;
+
+	DRM_DEBUG("\n");
+
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
+
+	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_pfp.bin", ucode_prefix);
+	if (err)
+		goto out;
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P1_STACK);
+
+	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_me.bin", ucode_prefix);
+	if (err)
+		goto out;
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME_P0_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_ME_P1_STACK);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   AMDGPU_UCODE_REQUIRED,
+					   "amdgpu/%s_rlc.bin", ucode_prefix);
+		if (err)
+			goto out;
+		rlc_hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
+		version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
+		version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
+		err = amdgpu_gfx_rlc_init_microcode(adev, version_major, version_minor);
+		if (err)
+			goto out;
+	}
+
+	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_mec.bin", ucode_prefix);
+	if (err)
+		goto out;
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P0_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P4_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P5_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P6_STACK);
+	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_MEC_P7_STACK);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO)
+		err = gfx_v13_0_init_toc_microcode(adev, ucode_prefix);
+
+	/* only one MEC for gfx 13 */
+	adev->gfx.mec2_fw = NULL;
+
+	if (adev->gfx.imu.funcs) {
+		if (adev->gfx.imu.funcs->init_microcode) {
+			err = adev->gfx.imu.funcs->init_microcode(adev);
+			if (err)
+				dev_err(adev->dev, "Failed to load imu firmware!\n");
+		}
+	}
+
+out:
+	if (err) {
+		amdgpu_ucode_release(&adev->gfx.pfp_fw);
+		amdgpu_ucode_release(&adev->gfx.me_fw);
+		amdgpu_ucode_release(&adev->gfx.rlc_fw);
+		amdgpu_ucode_release(&adev->gfx.mec_fw);
+	}
+
+	return err;
+}
+
+static u32 gfx_v13_0_get_csb_size(struct amdgpu_device *adev)
+{
+	u32 count = 0;
+	const struct cs_section_def *sect = NULL;
+	const struct cs_extent_def *ext = NULL;
+
+	count += 1;
+
+	for (sect = gfx13_cs_data; sect->section != NULL; ++sect) {
+		if (sect->id == SECT_CONTEXT) {
+			for (ext = sect->section; ext->extent != NULL; ++ext)
+				count += 2 + ext->reg_count;
+		} else
+			return 0;
+	}
+
+	return count;
+}
+
+static void gfx_v13_0_get_csb_buffer(struct amdgpu_device *adev, u32 *buffer)
+{
+	u32 count = 0, clustercount = 0, i;
+	const struct cs_section_def *sect = NULL;
+	const struct cs_extent_def *ext = NULL;
+
+	if (adev->gfx.rlc.cs_data == NULL)
+		return;
+	if (buffer == NULL)
+		return;
+
+	count += 1;
+
+	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
+		if (sect->id == SECT_CONTEXT) {
+			for (ext = sect->section; ext->extent != NULL; ++ext) {
+				clustercount++;
+				buffer[count++] = ext->reg_count;
+				buffer[count++] = ext->reg_index;
+
+				for (i = 0; i < ext->reg_count; i++)
+					buffer[count++] = cpu_to_le32(ext->extent[i]);
+			}
+		} else
+			return;
+	}
+
+	buffer[0] = clustercount;
+}
+
+static void gfx_v13_0_rlc_fini(struct amdgpu_device *adev)
+{
+	/* clear state block */
+	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
+			&adev->gfx.rlc.clear_state_gpu_addr,
+			(void **)&adev->gfx.rlc.cs_ptr);
+
+	/* jump table block */
+	amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
+			&adev->gfx.rlc.cp_table_gpu_addr,
+			(void **)&adev->gfx.rlc.cp_table_ptr);
+}
+
+static void gfx_v13_0_init_rlcg_reg_access_ctrl(struct amdgpu_device *adev)
+{
+	struct amdgpu_rlcg_reg_access_ctrl *reg_access_ctrl;
+
+	reg_access_ctrl = &adev->gfx.rlc.reg_access_ctrl[0];
+
+	reg_access_ctrl->grbm_cntl =
+		SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_CNTL);
+	reg_access_ctrl->grbm_idx =
+		SOC15_REG_OFFSET(GC, 0, regGRBM_GFX_INDEX);
+
+	reg_access_ctrl->vfi_cmd =
+		SOC15_REG_OFFSET(GC, 0, regRLC_VFI_CMD);
+	reg_access_ctrl->vfi_stat =
+		SOC15_REG_OFFSET(GC, 0, regRLC_VFI_STAT);
+	reg_access_ctrl->vfi_addr =
+		SOC15_REG_OFFSET(GC, 0, regRLC_VFI_ADDR);
+	reg_access_ctrl->vfi_data =
+		SOC15_REG_OFFSET(GC, 0, regRLC_VFI_DATA);
+	reg_access_ctrl->vfi_grbm_cntl =
+		SOC15_REG_OFFSET(GC, 0, regRLC_VFI_GRBM_GFX_CNTL);
+	reg_access_ctrl->vfi_grbm_idx =
+		SOC15_REG_OFFSET(GC, 0, regRLC_VFI_GRBM_GFX_INDEX);
+	reg_access_ctrl->vfi_grbm_cntl_data = 0;
+	reg_access_ctrl->vfi_grbm_idx_data = 0;
+
+	adev->gfx.rlc.rlcg_reg_access_supported = true;
+
+}
+
+static int gfx_v13_0_rlc_init(struct amdgpu_device *adev)
+{
+	const struct cs_section_def *cs_data;
+	int r;
+
+	adev->gfx.rlc.cs_data = gfx13_cs_data;
+
+	cs_data = adev->gfx.rlc.cs_data;
+
+	if (cs_data) {
+		/* init clear state block */
+		r = amdgpu_gfx_rlc_init_csb(adev);
+		if (r)
+			return r;
+	}
+
+	/* init spm vmid with 0xf */
+	if (adev->gfx.rlc.funcs->update_spm_vmid)
+		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0, adev->vm_manager.spm_vmid);
+
+	return 0;
+}
+
+static void gfx_v13_0_mec_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->gfx.mec.mec_fw_obj, NULL, NULL);
+	amdgpu_bo_free_kernel(&adev->gfx.mec.mec_fw_data_obj, NULL, NULL);
+}
+
+static void gfx_v13_0_me_init(struct amdgpu_device *adev)
+{
+	bitmap_zero(adev->gfx.me.queue_bitmap, AMDGPU_MAX_GFX_QUEUES);
+
+	amdgpu_gfx_graphics_queue_acquire(adev);
+}
+
+static int gfx_v13_0_mec_init(struct amdgpu_device *adev)
+{
+	int r;
+	u32 *hpd;
+	size_t mec_hpd_size;
+
+	bitmap_zero(adev->gfx.mec_bitmap[0].queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES);
+
+	/* take ownership of the relevant compute queues */
+	amdgpu_gfx_compute_queue_acquire(adev);
+	mec_hpd_size = adev->gfx.num_compute_rings * GFX13_MEC_HPD_SIZE;
+
+	if (mec_hpd_size) {
+		r = amdgpu_bo_create_reserved(adev, mec_hpd_size, PAGE_SIZE,
+					      AMDGPU_GEM_DOMAIN_GTT,
+					      &adev->gfx.mec.hpd_eop_obj,
+					      &adev->gfx.mec.hpd_eop_gpu_addr,
+					      (void **)&hpd);
+		if (r) {
+			dev_warn(adev->dev, "(%d) create HDP EOP bo failed\n", r);
+			gfx_v13_0_mec_fini(adev);
+			return r;
+		}
+
+		memset(hpd, 0, mec_hpd_size);
+
+		amdgpu_bo_kunmap(adev->gfx.mec.hpd_eop_obj);
+		amdgpu_bo_unreserve(adev->gfx.mec.hpd_eop_obj);
+	}
+
+	return 0;
+}
+
+static uint32_t wave_read_ind(struct amdgpu_device *adev, uint32_t wave, uint32_t address)
+{
+	WREG32_SOC15(GC, 0, regSQ_IND_INDEX,
+		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
+		(address << SQ_IND_INDEX__INDEX__SHIFT));
+	return RREG32_SOC15(GC, 0, regSQ_IND_DATA);
+}
+
+static void wave_read_regs(struct amdgpu_device *adev, uint32_t wave,
+			   uint32_t thread, uint32_t regno,
+			   uint32_t num, uint32_t *out)
+{
+	WREG32_SOC15(GC, 0, regSQ_IND_INDEX,
+		(wave << SQ_IND_INDEX__WAVE_ID__SHIFT) |
+		(regno << SQ_IND_INDEX__INDEX__SHIFT) |
+		(thread << SQ_IND_INDEX__WORKITEM_ID__SHIFT) |
+		(SQ_IND_INDEX__AUTO_INCR_MASK));
+	while (num--)
+		*(out++) = RREG32_SOC15(GC, 0, regSQ_IND_DATA);
+}
+
+static void gfx_v13_0_read_wave_data(struct amdgpu_device *adev,
+				     uint32_t xcc_id,
+				     uint32_t simd, uint32_t wave,
+				     uint32_t *dst, int *no_fields)
+{
+	/* in gfx13 the SIMD_ID is specified as part of the INSTANCE
+	 * field when performing a select_se_sh so it should be
+	 * zero here */
+	WARN_ON(simd != 0);
+
+	/* type 4 wave data */
+	dst[(*no_fields)++] = 4;
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATUS);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_LO);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_PC_HI);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_LO);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXEC_HI);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID1);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_HW_ID2);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_GPR_ALLOC);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_LDS_ALLOC);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_STS2);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_IB_DBG1);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_M0);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_MODE);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_STATE_PRIV);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXCP_FLAG_PRIV);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_EXCP_FLAG_USER);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_TRAP_CTRL);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_ACTIVE);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_VALID_AND_IDLE);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_DVGPR_ALLOC_LO);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_DVGPR_ALLOC_HI);
+	dst[(*no_fields)++] = wave_read_ind(adev, wave, ixSQ_WAVE_SCHED_MODE);
+}
+
+static void gfx_v13_0_read_wave_sgprs(struct amdgpu_device *adev,
+				      uint32_t xcc_id, uint32_t simd,
+				      uint32_t wave, uint32_t start,
+				      uint32_t size, uint32_t *dst)
+{
+	WARN_ON(simd != 0);
+
+	wave_read_regs(
+		adev, wave, 0, start + SQIND_WAVE_SGPRS_OFFSET, size,
+		dst);
+}
+
+static void gfx_v13_0_read_wave_vgprs(struct amdgpu_device *adev,
+				      uint32_t xcc_id, uint32_t simd,
+				      uint32_t wave, uint32_t thread,
+				      uint32_t start, uint32_t size,
+				      uint32_t *dst)
+{
+	wave_read_regs(
+		adev, wave, thread,
+		start + SQIND_WAVE_VGPRS_OFFSET, size, dst);
+}
+
+static void gfx_v13_0_select_me_pipe_q(struct amdgpu_device *adev,
+				       u32 me, u32 pipe, u32 q, u32 vm, u32 xcc_id)
+{
+	soc_v2_0_grbm_select(adev, me, pipe, q, vm);
+}
+
+/* all sizes are in bytes */
+#define MQD_SHADOW_BASE_SIZE      73728
+#define MQD_SHADOW_BASE_ALIGNMENT 256
+#define MQD_FWWORKAREA_SIZE       484
+#define MQD_FWWORKAREA_ALIGNMENT  256
+
+static void gfx_v13_0_get_gfx_shadow_info_nocheck(struct amdgpu_device *adev,
+						  struct amdgpu_gfx_shadow_info *shadow_info)
+{
+	/* for gfx */
+	shadow_info->shadow_size = MQD_SHADOW_BASE_SIZE;
+	shadow_info->shadow_alignment = MQD_SHADOW_BASE_ALIGNMENT;
+	shadow_info->csa_size = MQD_FWWORKAREA_SIZE;
+	shadow_info->csa_alignment = MQD_FWWORKAREA_ALIGNMENT;
+	/* for compute */
+	shadow_info->eop_size = GFX13_MEC_HPD_SIZE;
+	shadow_info->eop_alignment = 256;
+}
+
+static int gfx_v13_0_get_gfx_shadow_info(struct amdgpu_device *adev,
+					 struct amdgpu_gfx_shadow_info *shadow_info,
+					 bool skip_check)
+{
+	if (adev->gfx.cp_gfx_shadow || skip_check) {
+		gfx_v13_0_get_gfx_shadow_info_nocheck(adev, shadow_info);
+		return 0;
+	}
+
+	memset(shadow_info, 0, sizeof(struct amdgpu_gfx_shadow_info));
+	return -EINVAL;
+}
+
+static const struct amdgpu_gfx_funcs gfx_v13_0_gfx_funcs = {
+	.get_gpu_clock_counter = &gfx_v13_0_get_gpu_clock_counter,
+	.select_se_sh = &gfx_v13_0_select_se_sh,
+	.read_wave_data = &gfx_v13_0_read_wave_data,
+	.read_wave_sgprs = &gfx_v13_0_read_wave_sgprs,
+	.read_wave_vgprs = &gfx_v13_0_read_wave_vgprs,
+	.select_me_pipe_q = &gfx_v13_0_select_me_pipe_q,
+	.update_perfmon_mgcg = &gfx_v13_0_update_perf_clk,
+	.get_gfx_shadow_info = &gfx_v13_0_get_gfx_shadow_info,
+	.get_hdp_flush_mask = &amdgpu_gfx_get_hdp_flush_mask,
+};
+
+static int gfx_v13_0_gpu_early_init(struct amdgpu_device *adev)
+{
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		adev->gfx.config.max_hw_contexts = 8;
+		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
+		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
+		adev->gfx.config.sc_hiz_tile_fifo_size = 0;
+		adev->gfx.config.sc_earlyz_tile_fifo_size = 0x4C0;
+		break;
+	default:
+		BUG();
+		break;
+	}
+
+	return 0;
+}
+
+static int gfx_v13_0_gfx_ring_init(struct amdgpu_device *adev, int ring_id,
+				   int me, int pipe, int queue)
+{
+	int r;
+	struct amdgpu_ring *ring;
+	unsigned int irq_type;
+
+	ring = &adev->gfx.gfx_ring[ring_id];
+
+	ring->me = me;
+	ring->pipe = pipe;
+	ring->queue = queue;
+
+	ring->ring_obj = NULL;
+	ring->use_doorbell = true;
+
+	if (!ring_id)
+		ring->doorbell_index = adev->doorbell_index.gfx_ring0 << 1;
+	else
+		ring->doorbell_index = adev->doorbell_index.gfx_ring1 << 1;
+	ring->vm_hub = AMDGPU_GFXHUB(0);
+	sprintf(ring->name, "gfx_%d.%d.%d", ring->me, ring->pipe, ring->queue);
+
+	irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + ring->pipe;
+	r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
+			     AMDGPU_RING_PRIO_DEFAULT, NULL);
+	if (r)
+		return r;
+	return 0;
+}
+
+static int gfx_v13_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
+				       int mec, int pipe, int queue)
+{
+	int r;
+	unsigned irq_type;
+	struct amdgpu_ring *ring;
+	unsigned int hw_prio;
+
+	ring = &adev->gfx.compute_ring[ring_id];
+
+	/* mec0 is me1 */
+	ring->me = mec + 1;
+	ring->pipe = pipe;
+	ring->queue = queue;
+
+	ring->ring_obj = NULL;
+	ring->use_doorbell = true;
+	ring->doorbell_index = (adev->doorbell_index.mec_ring0 + ring_id) << 1;
+	ring->eop_gpu_addr = adev->gfx.mec.hpd_eop_gpu_addr
+				+ (ring_id * GFX13_MEC_HPD_SIZE);
+	ring->vm_hub = AMDGPU_GFXHUB(0);
+	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
+
+	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
+		+ ring->pipe;
+	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
+			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
+	/* type-2 packets are deprecated on MEC, use type-3 instead */
+	r = amdgpu_ring_init(adev, ring, 1024, &adev->gfx.eop_irq, irq_type,
+			     hw_prio, NULL);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static struct {
+	SOC24_FIRMWARE_ID	id;
+	unsigned int		offset;
+	unsigned int		size;
+	unsigned int		size_x16;
+} rlc_autoload_info[SOC24_FIRMWARE_ID_MAX];
+
+#define RLC_TOC_OFFSET_DWUNIT   8
+#define RLC_SIZE_MULTIPLE       1024
+#define RLC_TOC_UMF_SIZE_inM	23ULL
+#define RLC_TOC_FORMAT_API	165ULL
+
+static void gfx_v13_0_parse_rlc_toc(struct amdgpu_device *adev, void *rlc_toc)
+{
+	RLC_TABLE_OF_CONTENT_V2 *ucode = rlc_toc;
+
+	while (ucode && (ucode->id > SOC24_FIRMWARE_ID_INVALID)) {
+		rlc_autoload_info[ucode->id].id = ucode->id;
+		rlc_autoload_info[ucode->id].offset =
+			ucode->offset * RLC_TOC_OFFSET_DWUNIT * 4;
+		rlc_autoload_info[ucode->id].size =
+			ucode->size_x16 ? ucode->size * RLC_SIZE_MULTIPLE * 4 :
+					  ucode->size * 4;
+		ucode++;
+	}
+}
+
+static uint32_t gfx_v13_0_calc_toc_total_size(struct amdgpu_device *adev)
+{
+	uint32_t total_size = 0;
+	SOC24_FIRMWARE_ID id;
+
+	gfx_v13_0_parse_rlc_toc(adev, adev->psp.toc.start_addr);
+
+	for (id = SOC24_FIRMWARE_ID_RLC_G_UCODE; id < SOC24_FIRMWARE_ID_MAX; id++)
+		total_size += rlc_autoload_info[id].size;
+
+	/* In case the offset in rlc toc ucode is aligned */
+	if (total_size < rlc_autoload_info[SOC24_FIRMWARE_ID_MAX-1].offset)
+		total_size = rlc_autoload_info[SOC24_FIRMWARE_ID_MAX-1].offset +
+			rlc_autoload_info[SOC24_FIRMWARE_ID_MAX-1].size;
+	if (total_size < (RLC_TOC_UMF_SIZE_inM << 20))
+		total_size = RLC_TOC_UMF_SIZE_inM << 20;
+
+	return total_size;
+}
+
+static int gfx_v13_0_rlc_autoload_buffer_init(struct amdgpu_device *adev)
+{
+	int r;
+	uint32_t total_size;
+
+	total_size = gfx_v13_0_calc_toc_total_size(adev);
+
+	r = amdgpu_bo_create_reserved(adev, total_size, 64 * 1024,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->gfx.rlc.rlc_autoload_bo,
+				      &adev->gfx.rlc.rlc_autoload_gpu_addr,
+				      (void **)&adev->gfx.rlc.rlc_autoload_ptr);
+
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create fw autoload bo\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_rlc_backdoor_autoload_copy_ucode(struct amdgpu_device *adev,
+						       SOC24_FIRMWARE_ID id,
+						       const void *fw_data,
+						       uint32_t fw_size)
+{
+	uint32_t toc_offset;
+	uint32_t toc_fw_size;
+	char *ptr = adev->gfx.rlc.rlc_autoload_ptr;
+
+	if (id <= SOC24_FIRMWARE_ID_INVALID || id >= SOC24_FIRMWARE_ID_MAX)
+		return;
+
+	toc_offset = rlc_autoload_info[id].offset;
+	toc_fw_size = rlc_autoload_info[id].size;
+
+	if (fw_size == 0)
+		fw_size = toc_fw_size;
+
+	if (fw_size > toc_fw_size)
+		fw_size = toc_fw_size;
+
+	memcpy(ptr + toc_offset, fw_data, fw_size);
+
+	if (fw_size < toc_fw_size)
+		memset(ptr + toc_offset + fw_size, 0, toc_fw_size - fw_size);
+}
+
+static void
+gfx_v13_0_rlc_backdoor_autoload_copy_toc_ucode(struct amdgpu_device *adev)
+{
+	void *data;
+	uint32_t size;
+	uint32_t *toc_ptr;
+
+	data = adev->psp.toc.start_addr;
+	size = rlc_autoload_info[SOC24_FIRMWARE_ID_RLC_TOC].size;
+
+	toc_ptr = (uint32_t *)data + size / 4 - 2;
+	*toc_ptr = (RLC_TOC_FORMAT_API << 24) | 0x1;
+
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RLC_TOC,
+						   data, size);
+}
+
+static void
+gfx_v13_0_rlc_backdoor_autoload_copy_gfx_ucode(struct amdgpu_device *adev)
+{
+	const __le32 *fw_data;
+	uint32_t fw_size;
+	const struct gfx_firmware_header_v2_0 *cpv2_hdr;
+	const struct rlc_firmware_header_v2_0 *rlc_hdr;
+	const struct rlc_firmware_header_v2_1 *rlcv21_hdr;
+	const struct rlc_firmware_header_v2_2 *rlcv22_hdr;
+	uint16_t version_major, version_minor;
+
+	/* pfp ucode */
+	cpv2_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.pfp_fw->data;
+	/* instruction */
+	fw_data = (const __le32 *)(adev->gfx.pfp_fw->data +
+		le32_to_cpu(cpv2_hdr->ucode_offset_bytes));
+	fw_size = le32_to_cpu(cpv2_hdr->ucode_size_bytes);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_PFP,
+						   fw_data, fw_size);
+	/* data */
+	fw_data = (const __le32 *)(adev->gfx.pfp_fw->data +
+		le32_to_cpu(cpv2_hdr->data_offset_bytes));
+	fw_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_PFP_P0_STACK,
+						   fw_data, fw_size);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_PFP_P1_STACK,
+						   fw_data, fw_size);
+	/* me ucode */
+	cpv2_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.me_fw->data;
+	/* instruction */
+	fw_data = (const __le32 *)(adev->gfx.me_fw->data +
+		le32_to_cpu(cpv2_hdr->ucode_offset_bytes));
+	fw_size = le32_to_cpu(cpv2_hdr->ucode_size_bytes);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_ME,
+						   fw_data, fw_size);
+	/* data */
+	fw_data = (const __le32 *)(adev->gfx.me_fw->data +
+		le32_to_cpu(cpv2_hdr->data_offset_bytes));
+	fw_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_ME_P0_STACK,
+						   fw_data, fw_size);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_ME_P1_STACK,
+						   fw_data, fw_size);
+	/* mec ucode */
+	cpv2_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.mec_fw->data;
+	/* instruction */
+	fw_data = (const __le32 *) (adev->gfx.mec_fw->data +
+		le32_to_cpu(cpv2_hdr->ucode_offset_bytes));
+	fw_size = le32_to_cpu(cpv2_hdr->ucode_size_bytes);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_MEC,
+						   fw_data, fw_size);
+	/* data */
+	fw_data = (const __le32 *) (adev->gfx.mec_fw->data +
+		le32_to_cpu(cpv2_hdr->data_offset_bytes));
+	fw_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_MEC_P0_STACK,
+						   fw_data, fw_size);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_MEC_P1_STACK,
+						   fw_data, fw_size);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_MEC_P2_STACK,
+						   fw_data, fw_size);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RS64_MEC_P3_STACK,
+						   fw_data, fw_size);
+
+	/* rlc ucode */
+	rlc_hdr = (const struct rlc_firmware_header_v2_0 *)
+		adev->gfx.rlc_fw->data;
+	fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+			le32_to_cpu(rlc_hdr->header.ucode_array_offset_bytes));
+	fw_size = le32_to_cpu(rlc_hdr->header.ucode_size_bytes);
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RLC_G_UCODE,
+						   fw_data, fw_size);
+
+	version_major = le16_to_cpu(rlc_hdr->header.header_version_major);
+	version_minor = le16_to_cpu(rlc_hdr->header.header_version_minor);
+	if (version_major == 2) {
+		if (version_minor >= 1) {
+			rlcv21_hdr = (const struct rlc_firmware_header_v2_1 *)adev->gfx.rlc_fw->data;
+
+			fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+					le32_to_cpu(rlcv21_hdr->save_restore_list_gpm_offset_bytes));
+			fw_size = le32_to_cpu(rlcv21_hdr->save_restore_list_gpm_size_bytes);
+			gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RLCG_SCRATCH,
+						   fw_data, fw_size);
+
+			fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+					le32_to_cpu(rlcv21_hdr->save_restore_list_srm_offset_bytes));
+			fw_size = le32_to_cpu(rlcv21_hdr->save_restore_list_srm_size_bytes);
+			gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RLC_SRM_ARAM,
+						   fw_data, fw_size);
+		}
+		if (version_minor >= 2) {
+			rlcv22_hdr = (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_fw->data;
+
+			fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+					le32_to_cpu(rlcv22_hdr->rlc_iram_ucode_offset_bytes));
+			fw_size = le32_to_cpu(rlcv22_hdr->rlc_iram_ucode_size_bytes);
+			gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RLX6_UCODE,
+						   fw_data, fw_size);
+
+			fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+					le32_to_cpu(rlcv22_hdr->rlc_dram_ucode_offset_bytes));
+			fw_size = le32_to_cpu(rlcv22_hdr->rlc_dram_ucode_size_bytes);
+			gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_RLX6_DRAM_BOOT,
+						   fw_data, fw_size);
+		}
+	}
+}
+
+static void
+gfx_v13_0_rlc_backdoor_autoload_copy_sdma_ucode(struct amdgpu_device *adev)
+{
+	const __le32 *fw_data;
+	uint32_t fw_size;
+	const struct sdma_firmware_header_v3_0 *sdma_hdr;
+
+	sdma_hdr = (const struct sdma_firmware_header_v3_0 *)
+		adev->sdma.instance[0].fw->data;
+	fw_data = (const __le32 *) (adev->sdma.instance[0].fw->data +
+			le32_to_cpu(sdma_hdr->ucode_offset_bytes));
+	fw_size = le32_to_cpu(sdma_hdr->ucode_size_bytes);
+
+	gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, SOC24_FIRMWARE_ID_SDMA_UCODE_TH0,
+						   fw_data, fw_size);
+}
+
+static void
+gfx_v13_0_rlc_backdoor_autoload_copy_mes_ucode(struct amdgpu_device *adev)
+{
+	const __le32 *fw_data;
+	unsigned fw_size;
+	const struct mes_firmware_header_v1_0 *mes_hdr;
+	int pipe, ucode_id, data_id;
+
+	for (pipe = 0; pipe < 2; pipe++) {
+		if (pipe == 0) {
+			ucode_id = SOC24_FIRMWARE_ID_RS64_MES_P0;
+			data_id  = SOC24_FIRMWARE_ID_RS64_MES_P0_STACK;
+		} else {
+			ucode_id = SOC24_FIRMWARE_ID_RS64_MES_P1;
+			data_id  = SOC24_FIRMWARE_ID_RS64_MES_P1_STACK;
+		}
+
+		mes_hdr = (const struct mes_firmware_header_v1_0 *)
+			adev->mes.fw[pipe]->data;
+
+		fw_data = (const __le32 *)(adev->mes.fw[pipe]->data +
+				le32_to_cpu(mes_hdr->mes_ucode_offset_bytes));
+		fw_size = le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
+
+		gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, ucode_id, fw_data, fw_size);
+
+		fw_data = (const __le32 *)(adev->mes.fw[pipe]->data +
+				le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes));
+		fw_size = le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
+
+		gfx_v13_0_rlc_backdoor_autoload_copy_ucode(adev, data_id, fw_data, fw_size);
+	}
+}
+
+static int gfx_v13_0_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
+{
+	uint32_t rlc_g_offset, rlc_g_size;
+	uint64_t gpu_addr;
+
+	/* RLC autoload sequence 2: copy ucode */
+	gfx_v13_0_rlc_backdoor_autoload_copy_sdma_ucode(adev);
+	gfx_v13_0_rlc_backdoor_autoload_copy_gfx_ucode(adev);
+	gfx_v13_0_rlc_backdoor_autoload_copy_mes_ucode(adev);
+	gfx_v13_0_rlc_backdoor_autoload_copy_toc_ucode(adev);
+
+	rlc_g_offset = rlc_autoload_info[SOC24_FIRMWARE_ID_RLC_G_UCODE].offset;
+	rlc_g_size = rlc_autoload_info[SOC24_FIRMWARE_ID_RLC_G_UCODE].size;
+	gpu_addr = adev->gfx.rlc.rlc_autoload_gpu_addr + rlc_g_offset - adev->gmc.vram_start;
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_BOOTLOADER_ADDR_HI, upper_32_bits(gpu_addr));
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_BOOTLOADER_ADDR_LO, lower_32_bits(gpu_addr));
+
+	WREG32_SOC15(GC, 0, regGFX_IMU_RLC_BOOTLOADER_SIZE, rlc_g_size);
+
+	if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+		/* RLC autoload sequence 3: load IMU fw */
+		if (adev->gfx.imu.funcs->load_microcode)
+			adev->gfx.imu.funcs->load_microcode(adev);
+		/* RLC autoload sequence 4 init IMU fw */
+		if (adev->gfx.imu.funcs->setup_imu)
+			adev->gfx.imu.funcs->setup_imu(adev);
+		if (adev->gfx.imu.funcs->start_imu)
+			adev->gfx.imu.funcs->start_imu(adev);
+
+		/* RLC autoload sequence 5 disable gpa mode */
+		gfx_v13_0_disable_gpa_mode(adev);
+	} else {
+		/* unhalt rlc to start autoload without imu */
+		DRM_ERROR("rlc regs are not valid\n");
+
+		WREG32_SOC15(GC, 0, regRLC_CNTL, RLC_CNTL__RLC_ENABLE_F32_MASK);
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_alloc_ip_dump(struct amdgpu_device *adev)
+{
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_13_0);
+	uint32_t *ptr;
+	uint32_t inst;
+
+	ptr = kcalloc(reg_count, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
+		adev->gfx.ip_dump_core = NULL;
+	} else {
+		adev->gfx.ip_dump_core = ptr;
+	}
+
+	/* Allocate memory for compute queue registers for all the instances */
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_13);
+	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
+		adev->gfx.mec.num_queue_per_pipe;
+
+	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
+		adev->gfx.ip_dump_compute_queues = NULL;
+	} else {
+		adev->gfx.ip_dump_compute_queues = ptr;
+	}
+
+	/* Allocate memory for gfx queue registers for all the instances */
+	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_13);
+	inst = adev->gfx.me.num_me * adev->gfx.me.num_pipe_per_me *
+		adev->gfx.me.num_queue_per_pipe;
+
+	ptr = kcalloc(reg_count * inst, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR("Failed to allocate memory for GFX Queues IP Dump\n");
+		adev->gfx.ip_dump_gfx_queues = NULL;
+	} else {
+		adev->gfx.ip_dump_gfx_queues = ptr;
+	}
+}
+
+static int gfx_v13_0_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	int i, j, k, r, ring_id = 0;
+	unsigned num_compute_rings;
+	int xcc_id = 0;
+	struct amdgpu_device *adev = ip_block->adev;
+	int num_queue_per_pipe = 1; /* we only enable 1 KGQ per pipe */
+
+	INIT_DELAYED_WORK(&adev->gfx.idle_work, amdgpu_gfx_profile_idle_work_handler);
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		adev->gfx.me.num_me = 1;
+		adev->gfx.me.num_pipe_per_me = 2;
+		adev->gfx.me.num_queue_per_pipe = 8;
+		adev->gfx.mec.num_mec = 2;
+		adev->gfx.mec.num_pipe_per_mec = 4;
+		adev->gfx.mec.num_queue_per_pipe = 8;
+		break;
+	default:
+		adev->gfx.me.num_me = 1;
+		adev->gfx.me.num_pipe_per_me = 1;
+		adev->gfx.me.num_queue_per_pipe = 1;
+		adev->gfx.mec.num_mec = 1;
+		adev->gfx.mec.num_pipe_per_mec = 4;
+		adev->gfx.mec.num_queue_per_pipe = 8;
+		break;
+	}
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		if (!adev->gfx.disable_uq) {
+			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
+			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
+		}
+		break;
+	default:
+		break;
+	}
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		adev->gfx.enable_cleaner_shader = true;
+		break;
+	default:
+		adev->gfx.enable_cleaner_shader = false;
+		break;
+	}
+
+	if (adev->gfx.num_compute_rings) {
+		/* recalculate compute rings to use based on hardware configuration */
+		num_compute_rings = (adev->gfx.mec.num_pipe_per_mec *
+				     adev->gfx.mec.num_queue_per_pipe) / 2;
+		adev->gfx.num_compute_rings = min(adev->gfx.num_compute_rings,
+						  num_compute_rings);
+	}
+
+	/* EOP Event */
+	r = amdgpu_irq_add_id(adev, SOC_V2_0_IH_CLIENTID_GRBM_CP,
+			      GFX_13_0_1__SRCID__CP_EOP_INTERRUPT,
+			      &adev->gfx.eop_irq);
+	if (r)
+		return r;
+
+	/* Bad opcode Event */
+	r = amdgpu_irq_add_id(adev, SOC_V2_0_IH_CLIENTID_GRBM_CP,
+			      GFX_13_0_1__SRCID__CP_BAD_OPCODE_ERROR,
+			      &adev->gfx.bad_op_irq);
+	if (r)
+		return r;
+
+	/* Privileged reg */
+	r = amdgpu_irq_add_id(adev, SOC_V2_0_IH_CLIENTID_GRBM_CP,
+			      GFX_13_0_1__SRCID__CP_PRIV_REG_FAULT,
+			      &adev->gfx.priv_reg_irq);
+	if (r)
+		return r;
+
+	/* Privileged inst */
+	r = amdgpu_irq_add_id(adev, SOC_V2_0_IH_CLIENTID_GRBM_CP,
+			      GFX_13_0_1__SRCID__CP_PRIV_INSTR_FAULT,
+			      &adev->gfx.priv_inst_irq);
+	if (r)
+		return r;
+
+	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
+
+	gfx_v13_0_me_init(adev);
+
+	r = gfx_v13_0_rlc_init(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to init rlc BOs!\n");
+		return r;
+	}
+
+	r = gfx_v13_0_mec_init(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to init MEC BOs!\n");
+		return r;
+	}
+
+	if (adev->gfx.num_gfx_rings) {
+		/* set up the gfx ring */
+		ring_id = 0;
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.me.num_pipe_per_me; k++) {
+					if (!amdgpu_gfx_is_me_queue_enabled(adev, i, k, j))
+						continue;
+
+					r = gfx_v13_0_gfx_ring_init(adev, ring_id,
+								    i, k, j);
+					if (r)
+						return r;
+					ring_id++;
+				}
+			}
+		}
+	}
+
+	if (adev->gfx.num_compute_rings) {
+		ring_id = 0;
+		/* set up the compute queues - allocate horizontally across pipes */
+		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
+			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
+				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec; k++) {
+					if (!amdgpu_gfx_is_mec_queue_enabled(adev,
+									     0, i, k, j))
+						continue;
+
+					r = gfx_v13_0_compute_ring_init(adev, ring_id,
+									i, k, j);
+					if (r)
+						return r;
+
+					ring_id++;
+				}
+			}
+		}
+	}
+
+	adev->gfx.gfx_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.gfx_ring[0]);
+	adev->gfx.compute_supported_reset =
+		amdgpu_get_soft_full_reset_mask(&adev->gfx.compute_ring[0]);
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+	default:
+		break;
+	}
+
+	if (!adev->enable_mes_kiq) {
+		r = amdgpu_gfx_kiq_init(adev, GFX13_MEC_HPD_SIZE, 0);
+		if (r) {
+			dev_err(adev->dev, "Failed to init KIQ BOs!\n");
+			return r;
+		}
+
+		r = amdgpu_gfx_kiq_init_ring(adev, xcc_id);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v13_compute_mqd), 0);
+	if (r)
+		return r;
+
+	/* allocate visible FB for rlc auto-loading fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
+		r = gfx_v13_0_rlc_autoload_buffer_init(adev);
+		if (r)
+			return r;
+	}
+
+	r = gfx_v13_0_gpu_early_init(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_gfx_sysfs_init(adev);
+	if (r)
+		return r;
+
+	gfx_v13_0_alloc_ip_dump(adev);
+
+	return 0;
+}
+
+static void gfx_v13_0_pfp_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->gfx.pfp.pfp_fw_obj,
+			      &adev->gfx.pfp.pfp_fw_gpu_addr,
+			      (void **)&adev->gfx.pfp.pfp_fw_ptr);
+
+	amdgpu_bo_free_kernel(&adev->gfx.pfp.pfp_fw_data_obj,
+			      &adev->gfx.pfp.pfp_fw_data_gpu_addr,
+			      (void **)&adev->gfx.pfp.pfp_fw_data_ptr);
+}
+
+static void gfx_v13_0_me_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->gfx.me.me_fw_obj,
+			      &adev->gfx.me.me_fw_gpu_addr,
+			      (void **)&adev->gfx.me.me_fw_ptr);
+
+	amdgpu_bo_free_kernel(&adev->gfx.me.me_fw_data_obj,
+			       &adev->gfx.me.me_fw_data_gpu_addr,
+			       (void **)&adev->gfx.me.me_fw_data_ptr);
+}
+
+static void gfx_v13_0_rlc_autoload_buffer_fini(struct amdgpu_device *adev)
+{
+	amdgpu_bo_free_kernel(&adev->gfx.rlc.rlc_autoload_bo,
+			&adev->gfx.rlc.rlc_autoload_gpu_addr,
+			(void **)&adev->gfx.rlc.rlc_autoload_ptr);
+}
+
+static int gfx_v13_0_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	int i;
+	struct amdgpu_device *adev = ip_block->adev;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+		amdgpu_ring_fini(&adev->gfx.gfx_ring[i]);
+	for (i = 0; i < adev->gfx.num_compute_rings; i++)
+		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
+
+	amdgpu_gfx_mqd_sw_fini(adev, 0);
+
+	if (!adev->enable_mes_kiq) {
+		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[0].ring);
+		amdgpu_gfx_kiq_fini(adev, 0);
+	}
+
+	gfx_v13_0_pfp_fini(adev);
+	gfx_v13_0_me_fini(adev);
+	gfx_v13_0_rlc_fini(adev);
+	gfx_v13_0_mec_fini(adev);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO)
+		gfx_v13_0_rlc_autoload_buffer_fini(adev);
+
+	gfx_v13_0_free_microcode(adev);
+
+	amdgpu_gfx_sysfs_fini(adev);
+
+	kfree(adev->gfx.ip_dump_core);
+	kfree(adev->gfx.ip_dump_compute_queues);
+	kfree(adev->gfx.ip_dump_gfx_queues);
+
+	return 0;
+}
+
+static void gfx_v13_0_select_se_sh(struct amdgpu_device *adev, u32 se_num,
+				   u32 sh_num, u32 instance, int xcc_id)
+{
+	u32 data;
+
+	if (instance == 0xffffffff)
+		data = REG_SET_FIELD(0, GRBM_GFX_INDEX,
+				     INSTANCE_BROADCAST_WRITES, 1);
+	else
+		data = REG_SET_FIELD(0, GRBM_GFX_INDEX, INSTANCE_INDEX,
+				     instance);
+
+	if (se_num == 0xffffffff)
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_BROADCAST_WRITES,
+				     1);
+	else
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SE_INDEX, se_num);
+
+	if (sh_num == 0xffffffff)
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SA_BROADCAST_WRITES,
+				     1);
+	else
+		data = REG_SET_FIELD(data, GRBM_GFX_INDEX, SA_INDEX, sh_num);
+
+	WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX, data);
+}
+
+static u32 gfx_v13_0_get_sa_active_bitmap(struct amdgpu_device *adev)
+{
+	u32 gc_disabled_sa_mask, gc_user_disabled_sa_mask, sa_mask;
+	gc_disabled_sa_mask = RREG32_SOC15(GC, 0, regCC_GC_SA_UNIT_DISABLE);
+	gc_disabled_sa_mask = REG_GET_FIELD(gc_disabled_sa_mask,
+					    CC_GC_SA_UNIT_DISABLE,
+					    SA_DISABLE);
+	gc_user_disabled_sa_mask = RREG32_SOC15(GC, 0, regGC_USER_SA_UNIT_DISABLE);
+	gc_user_disabled_sa_mask = REG_GET_FIELD(gc_user_disabled_sa_mask,
+						 GC_USER_SA_UNIT_DISABLE,
+						 SA_DISABLE);
+
+	sa_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_sh_per_se *
+					    adev->gfx.config.max_shader_engines);
+
+	return sa_mask & (~(gc_disabled_sa_mask | gc_user_disabled_sa_mask));
+}
+
+static u32 gfx_v13_0_get_rb_active_bitmap(struct amdgpu_device *adev)
+{
+	u32 gc_disabled_rb_mask, gc_user_disabled_rb_mask;
+	u32 rb_mask;
+
+	gc_disabled_rb_mask = RREG32_SOC15(GC, 0, regCC_RB_BACKEND_DISABLE);
+	gc_disabled_rb_mask = REG_GET_FIELD(gc_disabled_rb_mask,
+					    CC_RB_BACKEND_DISABLE,
+					    BACKEND_DISABLE);
+	gc_user_disabled_rb_mask = RREG32_SOC15(GC, 0, regGC_USER_RB_BACKEND_DISABLE);
+	gc_user_disabled_rb_mask = REG_GET_FIELD(gc_user_disabled_rb_mask,
+						 GC_USER_RB_BACKEND_DISABLE,
+						 BACKEND_DISABLE);
+	rb_mask = amdgpu_gfx_create_bitmask(adev->gfx.config.max_backends_per_se *
+					    adev->gfx.config.max_shader_engines);
+
+	return rb_mask & (~(gc_disabled_rb_mask | gc_user_disabled_rb_mask));
+}
+
+static void gfx_v13_0_setup_rb(struct amdgpu_device *adev)
+{
+	u32 rb_bitmap_per_sa;
+	u32 rb_bitmap_width_per_sa;
+	u32 max_sa;
+	u32 active_sa_bitmap;
+	u32 global_active_rb_bitmap;
+	u32 active_rb_bitmap = 0;
+	u32 i;
+
+	/* query sa bitmap from SA_UNIT_DISABLE registers */
+	active_sa_bitmap = gfx_v13_0_get_sa_active_bitmap(adev);
+	/* query rb bitmap from RB_BACKEND_DISABLE registers */
+	global_active_rb_bitmap = gfx_v13_0_get_rb_active_bitmap(adev);
+
+	/* generate active rb bitmap according to active sa bitmap */
+	max_sa = adev->gfx.config.max_shader_engines *
+		 adev->gfx.config.max_sh_per_se;
+	rb_bitmap_width_per_sa = adev->gfx.config.max_backends_per_se /
+				 adev->gfx.config.max_sh_per_se;
+	rb_bitmap_per_sa = amdgpu_gfx_create_bitmask(rb_bitmap_width_per_sa);
+
+	for (i = 0; i < max_sa; i++) {
+		if (active_sa_bitmap & (1 << i))
+			active_rb_bitmap |= (rb_bitmap_per_sa << (i * rb_bitmap_width_per_sa));
+	}
+
+	active_rb_bitmap &= global_active_rb_bitmap;
+	adev->gfx.config.backend_enable_mask = active_rb_bitmap;
+	adev->gfx.config.num_rbs = hweight32(active_rb_bitmap);
+}
+
+static void gfx_v13_0_init_compute_vmid(struct amdgpu_device *adev)
+{
+	int i;
+	uint32_t sh_mem_bases;
+	uint32_t data;
+
+	/*
+	 * Configure apertures:
+	 * LDS:         0x20000000'00000000 - 0x20000001'00000000 (4GB)
+	 * Scratch:     0x10000000'00000000 - 0x11ffffff'ffffffff (128PB 57-bit)
+	 */
+	sh_mem_bases = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE_NATIVE,
+			(adev->gmc.private_aperture_start >> 58));
+	sh_mem_bases = REG_SET_FIELD(sh_mem_bases, SH_MEM_BASES, SHARED_BASE,
+			(adev->gmc.shared_aperture_start >> 48));
+
+	mutex_lock(&adev->srbm_mutex);
+	for_each_uq_gfx_vmid(i, adev) {
+		soc_v2_0_grbm_select(adev, 0, 0, 0, i);
+		/* CP and shaders */
+		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
+		WREG32_SOC15(GC, 0, regSH_MEM_BASES, sh_mem_bases);
+
+		/* Enable trap for each kfd vmid. */
+		data = RREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL);
+		data = REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN, 1);
+		WREG32_SOC15(GC, 0, regSPI_GDBG_PER_VMID_CNTL, data);
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static void gfx_v13_0_tcp_harvest(struct amdgpu_device *adev)
+{
+	/* TODO: harvest feature to be added later. */
+}
+
+static void gfx_v13_0_get_tcc_info(struct amdgpu_device *adev)
+{
+}
+
+static void gfx_v13_0_constants_init(struct amdgpu_device *adev)
+{
+	u32 tmp;
+	int i;
+
+	if (!amdgpu_sriov_vf(adev))
+		WREG32_FIELD15_PREREG(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
+
+	gfx_v13_0_setup_rb(adev);
+	gfx_v13_0_get_cu_info(adev, &adev->gfx.cu_info);
+	gfx_v13_0_get_tcc_info(adev);
+	adev->gfx.config.pa_sc_tile_steering_override = 0;
+
+	/* Set whether texture coordinate truncation is conformant. */
+	tmp = RREG32_SOC15(GC, 0, regVTS_CNTL2);
+	adev->gfx.config.ta_cntl2_truncate_coord_mode =
+		REG_GET_FIELD(tmp, VTS_CNTL2, TRUNCATE_COORD_MODE);
+
+	/* Program DB_RING_CONTROL for multiple GFX pipes
+	 * Default power up value is 1.
+	 * Possible values:
+	 * 0 - split occlusion counters between gfx pipes
+	 * 1 - all occlusion counters to pipe 0
+	 * 2 - all occlusion counters to pipe 1
+	 */
+	WREG32_FIELD15_PREREG(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
+			      (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
+
+	/* XXX SH_MEM regs */
+	/* where to put LDS, scratch, GPUVM in FSA64 space */
+	mutex_lock(&adev->srbm_mutex);
+	for_each_vmid_and_zero(i, adev, AMDGPU_GFXHUB(0)) {
+		soc_v2_0_grbm_select(adev, 0, 0, 0, i);
+		/* CP and shaders */
+		WREG32_SOC15(GC, 0, regSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
+		if (i != 0) {
+			tmp = REG_SET_FIELD(0, SH_MEM_BASES, PRIVATE_BASE_NATIVE,
+				(adev->gmc.private_aperture_start >> 58));
+			tmp = REG_SET_FIELD(tmp, SH_MEM_BASES, SHARED_BASE,
+				(adev->gmc.shared_aperture_start >> 48));
+			WREG32_SOC15(GC, 0, regSH_MEM_BASES, tmp);
+		}
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+
+	mutex_unlock(&adev->srbm_mutex);
+
+	gfx_v13_0_init_compute_vmid(adev);
+}
+
+static u32 gfx_v13_0_get_cpg_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	if (me != 0)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING0);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING1);
+	default:
+		return 0;
+	}
+}
+
+static u32 gfx_v13_0_get_cpc_int_cntl(struct amdgpu_device *adev,
+				      int me, int pipe)
+{
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+	if (me != 1)
+		return 0;
+
+	switch (pipe) {
+	case 0:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
+	case 1:
+		return SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE1_INT_CNTL);
+	default:
+		return 0;
+	}
+}
+
+static void gfx_v13_0_enable_gui_idle_interrupt(struct amdgpu_device *adev,
+					       bool enable)
+{
+	u32 tmp, cp_int_cntl_reg;
+	int i, j;
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			cp_int_cntl_reg = gfx_v13_0_get_cpg_int_cntl(adev, i, j);
+
+			if (cp_int_cntl_reg) {
+				tmp = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CNTX_EMPTY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, CMP_BUSY_INT_ENABLE,
+						    enable ? 1 : 0);
+				tmp = REG_SET_FIELD(tmp, CP_INT_CNTL_RING0, GFX_IDLE_INT_ENABLE,
+						    enable ? 1 : 0);
+				WREG32_SOC15_IP(GC, cp_int_cntl_reg, tmp);
+			}
+		}
+	}
+}
+
+static int gfx_v13_0_init_csb(struct amdgpu_device *adev)
+{
+	uint32_t reg_val = 0;
+
+	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
+
+	WREG32_SOC15(GC, 0, regCP_CLR_STATE_ADDR_HI,
+			adev->gfx.rlc.clear_state_gpu_addr >> 32);
+	WREG32_SOC15(GC, 0, regCP_CLR_STATE_ADDR_LO,
+			adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
+
+	reg_val = REG_SET_FIELD(reg_val, CP_CLR_STATE_CNTL, VMID, 0);
+	reg_val = REG_SET_FIELD(reg_val, CP_CLR_STATE_CNTL, SIZE, adev->gfx.rlc.clear_state_size);
+	WREG32_SOC15(GC, 0, regCP_CLR_STATE_CNTL, adev->gfx.rlc.clear_state_size);
+
+	if (adev->gfx.num_gfx_rings > 1) {
+		mutex_lock(&adev->srbm_mutex);
+		soc_v2_0_grbm_select(adev, 0, 1, 0, 0);
+
+		WREG32_SOC15(GC, 0, regCP_CLR_STATE_ADDR_HI,
+				adev->gfx.rlc.clear_state_gpu_addr >> 32);
+		WREG32_SOC15(GC, 0, regCP_CLR_STATE_ADDR_LO,
+				adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
+
+		reg_val = REG_SET_FIELD(reg_val, CP_CLR_STATE_CNTL, VMID, 0);
+		reg_val = REG_SET_FIELD(reg_val, CP_CLR_STATE_CNTL, SIZE, adev->gfx.rlc.clear_state_size);
+		WREG32_SOC15(GC, 0, regCP_CLR_STATE_CNTL, adev->gfx.rlc.clear_state_size);
+
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_rlc_stop(struct amdgpu_device *adev)
+{
+	u32 tmp = RREG32_SOC15(GC, 0, regRLC_CNTL);
+
+	tmp = REG_SET_FIELD(tmp, RLC_CNTL, RLC_ENABLE_F32, 0);
+	WREG32_SOC15(GC, 0, regRLC_CNTL, tmp);
+}
+
+static void gfx_v13_0_rlc_reset(struct amdgpu_device *adev)
+{
+	WREG32_FIELD15_PREREG(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
+	udelay(50);
+	WREG32_FIELD15_PREREG(GC, 0, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
+	udelay(50);
+}
+
+static void gfx_v13_0_rlc_smu_handshake_cntl(struct amdgpu_device *adev,
+					     bool enable)
+{
+	uint32_t rlc_pg_cntl;
+
+	rlc_pg_cntl = RREG32_SOC15(GC, 0, regRLC_PG_CNTL);
+
+	if (!enable) {
+		/* RLC_PG_CNTL[23] = 0 (default)
+		 * RLC will wait for handshake acks with SMU
+		 * GFXOFF will be enabled
+		 * RLC_PG_CNTL[23] = 1
+		 * RLC will not issue any message to SMU
+		 * hence no handshake between SMU & RLC
+		 * GFXOFF will be disabled
+		 */
+		rlc_pg_cntl |= RLC_PG_CNTL__SMU_HANDSHAKE_DISABLE_MASK;
+	} else
+		rlc_pg_cntl &= ~RLC_PG_CNTL__SMU_HANDSHAKE_DISABLE_MASK;
+	WREG32_SOC15(GC, 0, regRLC_PG_CNTL, rlc_pg_cntl);
+}
+
+static void gfx_v13_0_rlc_start(struct amdgpu_device *adev)
+{
+	/* TODO: enable rlc & smu handshake until smu
+	 * and gfxoff feature works as expected */
+	if (!(amdgpu_pp_feature_mask & PP_GFXOFF_MASK))
+		gfx_v13_0_rlc_smu_handshake_cntl(adev, false);
+
+	WREG32_FIELD15_PREREG(GC, 0, RLC_CNTL, RLC_ENABLE_F32, 1);
+	udelay(50);
+}
+
+static void gfx_v13_0_rlc_enable_srm(struct amdgpu_device *adev)
+{
+	uint32_t tmp;
+
+	/* enable Save Restore Machine */
+	tmp = RREG32(SOC15_REG_OFFSET(GC, 0, regRLC_SRM_CNTL));
+	tmp |= RLC_SRM_CNTL__AUTO_INCR_ADDR_MASK;
+	tmp |= RLC_SRM_CNTL__SRM_ENABLE_MASK;
+	WREG32(SOC15_REG_OFFSET(GC, 0, regRLC_SRM_CNTL), tmp);
+}
+
+static void gfx_v13_0_load_rlcg_microcode(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_0 *hdr;
+	const __le32 *fw_data;
+	unsigned i, fw_size;
+
+	hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
+	fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+			   le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	WREG32_SOC15(GC, 0, regRLC_F32_IRAM_ADDR,
+		     RLCG_UCODE_LOADING_START_ADDRESS);
+
+	for (i = 0; i < fw_size; i++)
+		WREG32_SOC15(GC, 0, regRLC_F32_IRAM_DATA,
+			     le32_to_cpup(fw_data++));
+
+	WREG32_SOC15(GC, 0, regRLC_F32_IRAM_ADDR, adev->gfx.rlc_fw_version);
+}
+
+static void gfx_v13_0_load_rlc_iram_dram_microcode(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_2 *hdr;
+	const __le32 *fw_data;
+	unsigned i, fw_size;
+	u32 tmp;
+
+	hdr = (const struct rlc_firmware_header_v2_2 *)adev->gfx.rlc_fw->data;
+
+	fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+			le32_to_cpu(hdr->rlc_iram_ucode_offset_bytes));
+	fw_size = le32_to_cpu(hdr->rlc_iram_ucode_size_bytes) / 4;
+	WREG32_SOC15(GC, 0, regRLC_XT_IRAM_ADDR, 0);
+
+	for (i = 0; i < fw_size; i++) {
+		if ((amdgpu_emu_mode == 1) && (i % 100 == 99))
+			msleep(1);
+		WREG32_SOC15(GC, 0, regRLC_XT_IRAM_DATA,
+				le32_to_cpup(fw_data++));
+	}
+
+	WREG32_SOC15(GC, 0, regRLC_XT_IRAM_ADDR, adev->gfx.rlc_fw_version);
+
+	fw_data = (const __le32 *)(adev->gfx.rlc_fw->data +
+			le32_to_cpu(hdr->rlc_dram_ucode_offset_bytes));
+	fw_size = le32_to_cpu(hdr->rlc_dram_ucode_size_bytes) / 4;
+
+	WREG32_SOC15(GC, 0, regRLC_XT_DRAM_ADDR, 0);
+	for (i = 0; i < fw_size; i++) {
+		if ((amdgpu_emu_mode == 1) && (i % 100 == 99))
+			msleep(1);
+		WREG32_SOC15(GC, 0, regRLC_XT_DRAM_DATA,
+				le32_to_cpup(fw_data++));
+	}
+
+	WREG32_SOC15(GC, 0, regRLC_XT_IRAM_ADDR, adev->gfx.rlc_fw_version);
+
+	tmp = RREG32_SOC15(GC, 0, regRLC_XT_CNTL);
+	tmp = REG_SET_FIELD(tmp, RLC_XT_CNTL, PDEBUG_ENABLE, 1);
+	tmp = REG_SET_FIELD(tmp, RLC_XT_CNTL, BRESET, 0);
+	WREG32_SOC15(GC, 0, regRLC_XT_CNTL, tmp);
+}
+
+static int gfx_v13_0_rlc_load_microcode(struct amdgpu_device *adev)
+{
+	const struct rlc_firmware_header_v2_0 *hdr;
+	uint16_t version_major;
+
+	if (!adev->gfx.rlc_fw)
+		return -EINVAL;
+
+	hdr = (const struct rlc_firmware_header_v2_0 *)adev->gfx.rlc_fw->data;
+	amdgpu_ucode_print_rlc_hdr(&hdr->header);
+
+	version_major = le16_to_cpu(hdr->header.header_version_major);
+
+	if (version_major == 2) {
+		gfx_v13_0_load_rlcg_microcode(adev);
+		gfx_v13_0_load_rlc_iram_dram_microcode(adev);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int gfx_v13_0_rlc_resume(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		gfx_v13_0_init_csb(adev);
+
+		if (!amdgpu_sriov_vf(adev)) /* enable RLC SRM */
+			gfx_v13_0_rlc_enable_srm(adev);
+	} else {
+		if (amdgpu_sriov_vf(adev)) {
+			gfx_v13_0_init_csb(adev);
+			return 0;
+		}
+
+		adev->gfx.rlc.funcs->stop(adev);
+
+		/* disable CG */
+		WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL, 0);
+
+		/* disable PG */
+		WREG32_SOC15(GC, 0, regRLC_PG_CNTL, 0);
+
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			/* legacy rlc firmware loading */
+			r = gfx_v13_0_rlc_load_microcode(adev);
+			if (r)
+				return r;
+		}
+
+		gfx_v13_0_init_csb(adev);
+
+		adev->gfx.rlc.funcs->start(adev);
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_config_gfx_rs64(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *pfp_hdr;
+	const struct gfx_firmware_header_v2_0 *me_hdr;
+	const struct gfx_firmware_header_v2_0 *mec_hdr;
+	uint32_t mec_id, pipe_id, tmp;
+
+	mec_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.mec_fw->data;
+	me_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.me_fw->data;
+	pfp_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.pfp_fw->data;
+
+	/* config pfp program start addr */
+	for (pipe_id = 0; pipe_id < 2; pipe_id++) {
+		soc_v2_0_grbm_select(adev, 0, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_NATIVE,
+			(pfp_hdr->ucode_start_addr_hi << 30) |
+			(pfp_hdr->ucode_start_addr_lo >> 2));
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_HI_NATIVE,
+			pfp_hdr->ucode_start_addr_hi >> 2);
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+
+	/* reset pfp pipe */
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, PFP_PIPE0_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, PFP_PIPE1_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+
+	/* clear pfp pipe reset */
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, PFP_PIPE0_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, PFP_PIPE1_RESET, 0);
+	WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+
+	/* config me program start addr */
+	for (pipe_id = 0; pipe_id < 2; pipe_id++) {
+		soc_v2_0_grbm_select(adev, 0, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_NATIVE,
+			(me_hdr->ucode_start_addr_hi << 30) |
+			(me_hdr->ucode_start_addr_lo >> 2));
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_HI_NATIVE,
+			me_hdr->ucode_start_addr_hi >> 2);
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+
+	/* reset me pipe */
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, ME_PIPE0_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, ME_PIPE1_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+
+	/* clear me pipe reset */
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, ME_PIPE0_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, ME_PIPE1_RESET, 0);
+	WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+
+	/* config mec program start addr */
+	for (mec_id = 0; mec_id < adev->gfx.mec.num_mec; mec_id++) {
+		for (pipe_id = 0; pipe_id < adev->gfx.mec.num_pipe_per_mec; pipe_id++) {
+			soc_v2_0_grbm_select(adev, mec_id + 1, pipe_id, 0, 0);
+			WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START,
+						mec_hdr->ucode_start_addr_lo >> 2 |
+						mec_hdr->ucode_start_addr_hi << 30);
+			WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START_HI,
+						mec_hdr->ucode_start_addr_hi >> 2);
+		}
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+
+	/* reset mec pipe */
+	tmp = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC2_PIPE0_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC2_PIPE1_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC2_PIPE2_RESET, 1);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC2_PIPE3_RESET, 1);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
+
+	/* clear mec pipe reset */
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC2_PIPE0_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC2_PIPE1_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC2_PIPE2_RESET, 0);
+	tmp = REG_SET_FIELD(tmp, CP_MEC_RS64_CNTL, MEC2_PIPE3_RESET, 0);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, tmp);
+}
+
+static void gfx_v13_0_set_pfp_ucode_start_addr(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *cp_hdr;
+	unsigned pipe_id, tmp;
+
+	cp_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.pfp_fw->data;
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		soc_v2_0_grbm_select(adev, 0, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_NATIVE,
+			     (cp_hdr->ucode_start_addr_hi << 30) |
+			     (cp_hdr->ucode_start_addr_lo >> 2));
+		WREG32_SOC15(GC, 0, regCP_PFP_PRGRM_CNTR_START_HI_NATIVE,
+			     cp_hdr->ucode_start_addr_hi>>2);
+
+		/*
+		 * Program CP_ME_CNTL to reset given PIPE to take
+		 * effect of CP_PFP_PRGRM_CNTR_START.
+		 */
+		tmp = RREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL);
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL,
+					PFP_PIPE0_RESET, 1);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL,
+						PFP_PIPE1_RESET, 1);
+		WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+
+		/* Clear pfp pipe0 reset bit. */
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL,
+					PFP_PIPE0_RESET, 0);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL,
+					PFP_PIPE1_RESET, 0);
+		WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static void gfx_v13_0_set_me_ucode_start_addr(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *cp_hdr;
+	unsigned pipe_id, tmp;
+
+	cp_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.me_fw->data;
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		soc_v2_0_grbm_select(adev, 0, pipe_id, 0, 0);
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_NATIVE,
+			     (cp_hdr->ucode_start_addr_hi << 30) |
+			     (cp_hdr->ucode_start_addr_lo >> 2) );
+		WREG32_SOC15(GC, 0, regCP_ME_PRGRM_CNTR_START_HI_NATIVE,
+			     cp_hdr->ucode_start_addr_hi>>2);
+
+		/*
+		 * Program CP_ME_CNTL to reset given PIPE to take
+		 * effect of CP_ME_PRGRM_CNTR_START.
+		 */
+		tmp = RREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL);
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL,
+					ME_PIPE0_RESET, 1);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL,
+					ME_PIPE1_RESET, 1);
+		WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+
+		/* Clear pfp pipe0 reset bit. */
+		if (pipe_id == 0)
+			tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL,
+					ME_PIPE0_RESET, 0);
+		else
+			tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL,
+					ME_PIPE1_RESET, 0);
+		WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static void gfx_v13_0_set_mec_ucode_start_addr(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *cp_hdr;
+	unsigned mec_id, pipe_id;
+
+	cp_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.mec_fw->data;
+	mutex_lock(&adev->srbm_mutex);
+	for (mec_id = 0; mec_id < adev->gfx.mec.num_mec; mec_id++) {
+		for (pipe_id = 0; pipe_id < adev->gfx.mec.num_pipe_per_mec; pipe_id++) {
+			soc_v2_0_grbm_select(adev, mec_id + 1, pipe_id, 0, 0);
+			WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START,
+				cp_hdr->ucode_start_addr_lo >> 2 |
+				cp_hdr->ucode_start_addr_hi << 30);
+			WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START_HI,
+				cp_hdr->ucode_start_addr_hi >> 2);
+		}
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static int gfx_v13_0_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
+{
+	uint32_t cp_status;
+	uint32_t bootload_status;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		cp_status = RREG32_SOC15(GC, 0, regCP_STAT);
+		bootload_status = RREG32_SOC15(GC, 0, regRLC_RLCS_BOOTLOAD_STATUS);
+
+		if ((cp_status == 0) &&
+		    (REG_GET_FIELD(bootload_status,
+			RLC_RLCS_BOOTLOAD_STATUS, BOOTLOAD_COMPLETE) == 1)) {
+			break;
+		}
+		udelay(1);
+		if (amdgpu_emu_mode)
+			msleep(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		dev_err(adev->dev, "rlc autoload: gc ucode autoload timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
+		gfx_v13_0_set_pfp_ucode_start_addr(adev);
+		gfx_v13_0_set_me_ucode_start_addr(adev);
+		gfx_v13_0_set_mec_ucode_start_addr(adev);
+	}
+
+	return 0;
+}
+
+static int gfx_v13_0_cp_gfx_enable(struct amdgpu_device *adev, bool enable)
+{
+	int i = 0, timeout;
+	u32 tmp = 0;
+
+	timeout = adev->usec_timeout;
+	if (amdgpu_emu_mode)
+		timeout = adev->usec_timeout/10000; /* 1s */
+
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL);
+	if (!enable) {
+		tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, PFP_INVALIDATE_ICACHE, 1);
+		tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, ME_INVALIDATE_ICACHE, 1);
+
+		tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, PFP_PIPE0_RESET, 1);
+		tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, PFP_PIPE1_RESET, 1);
+		tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, ME_PIPE0_RESET, 1);
+		tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, ME_PIPE1_RESET, 1);
+	}
+
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, ME_HALT, enable ? 0 : 1);
+	tmp = REG_SET_FIELD(tmp, CP_ME_RS64_CNTL, PFP_HALT, enable ? 0 : 1);
+	WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, tmp);
+
+	for (i = 0; i < timeout; i++) {
+		if (RREG32_SOC15(GC, 0, regCP_STAT) == 0)
+			break;
+		udelay(1);
+		if (amdgpu_emu_mode)
+			msleep(1);
+	}
+
+	if (i >= timeout)
+		DRM_ERROR("failed to %s cp gfx\n", enable ? "unhalt" : "halt");
+
+	return 0;
+}
+
+static int gfx_v13_0_cp_gfx_load_pfp_microcode_rs64(struct amdgpu_device *adev)
+{
+	int r;
+	const struct gfx_firmware_header_v2_0 *pfp_hdr;
+	const __le32 *fw_ucode, *fw_data;
+	unsigned i, pipe_id, fw_ucode_size, fw_data_size;
+	uint32_t tmp;
+	uint32_t usec_timeout = 50000;  /* wait for 50ms */
+
+	pfp_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.pfp_fw->data;
+
+	amdgpu_ucode_print_gfx_hdr(&pfp_hdr->header);
+
+	/* instruction */
+	fw_ucode = (const __le32 *)(adev->gfx.pfp_fw->data +
+		le32_to_cpu(pfp_hdr->ucode_offset_bytes));
+	fw_ucode_size = le32_to_cpu(pfp_hdr->ucode_size_bytes);
+	/* data */
+	fw_data = (const __le32 *)(adev->gfx.pfp_fw->data +
+		le32_to_cpu(pfp_hdr->data_offset_bytes));
+	fw_data_size = le32_to_cpu(pfp_hdr->data_size_bytes);
+
+	/* 64kb align */
+	r = amdgpu_bo_create_reserved(adev, fw_ucode_size,
+				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->gfx.pfp.pfp_fw_obj,
+				      &adev->gfx.pfp.pfp_fw_gpu_addr,
+				      (void **)&adev->gfx.pfp.pfp_fw_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create pfp ucode fw bo\n", r);
+		gfx_v13_0_pfp_fini(adev);
+		return r;
+	}
+
+	r = amdgpu_bo_create_reserved(adev,
+				      ALIGN(fw_data_size, 64 * 1024) * adev->gfx.me.num_pipe_per_me,
+				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->gfx.pfp.pfp_fw_data_obj,
+				      &adev->gfx.pfp.pfp_fw_data_gpu_addr,
+				      (void **)&adev->gfx.pfp.pfp_fw_data_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create pfp data fw bo\n", r);
+		gfx_v13_0_pfp_fini(adev);
+		return r;
+	}
+
+	memcpy(adev->gfx.pfp.pfp_fw_ptr, fw_ucode, fw_ucode_size);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		memcpy(adev->gfx.pfp.pfp_fw_data_ptr + pipe_id * ALIGN(fw_data_size, 64 * 1024) / 4, fw_data, fw_data_size);
+	}
+
+	amdgpu_bo_kunmap(adev->gfx.pfp.pfp_fw_obj);
+	amdgpu_bo_kunmap(adev->gfx.pfp.pfp_fw_data_obj);
+	amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_obj);
+	amdgpu_bo_unreserve(adev->gfx.pfp.pfp_fw_data_obj);
+
+	if (amdgpu_emu_mode == 1)
+		amdgpu_device_flush_hdp(adev, NULL);
+
+	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_NATIVE_LO,
+		lower_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
+	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_NATIVE_HI,
+		upper_32_bits(adev->gfx.pfp.pfp_fw_gpu_addr));
+
+	tmp = RREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_NATIVE_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_NATIVE_CNTL, VMID, 0);
+	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_NATIVE_CNTL, CACHE_POLICY, 0);
+	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_BASE_NATIVE_CNTL, EXE_DISABLE, 0);
+	WREG32_SOC15(GC, 0, regCP_PFP_IC_BASE_NATIVE_CNTL, tmp);
+
+	/*
+	 * Programming any of the CP_PFP_IC_BASE registers
+	 * forces invalidation of the ME L1 I$. Wait for the
+	 * invalidation complete
+	 */
+	for (i = 0; i < usec_timeout; i++) {
+		tmp = RREG32_SOC15(GC, 0, regCP_PFP_IC_OP_NATIVE_CNTL);
+		if (1 == REG_GET_FIELD(tmp, CP_PFP_IC_OP_NATIVE_CNTL,
+			INVALIDATE_CACHE_COMPLETE))
+			break;
+		udelay(1);
+		if (amdgpu_emu_mode)
+			msleep(1);
+	}
+
+	if (i >= usec_timeout) {
+		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		return -EINVAL;
+	}
+
+	/* Prime the L1 instruction caches */
+	tmp = RREG32_SOC15(GC, 0, regCP_PFP_IC_OP_NATIVE_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_PFP_IC_OP_NATIVE_CNTL, PRIME_ICACHE, 1);
+	WREG32_SOC15(GC, 0, regCP_PFP_IC_OP_NATIVE_CNTL, tmp);
+	/* Waiting for cache primed*/
+	for (i = 0; i < usec_timeout; i++) {
+		tmp = RREG32_SOC15(GC, 0, regCP_PFP_IC_OP_NATIVE_CNTL);
+		if (1 == REG_GET_FIELD(tmp, CP_PFP_IC_OP_NATIVE_CNTL,
+			ICACHE_PRIMED))
+			break;
+		udelay(1);
+		if (amdgpu_emu_mode)
+			msleep(1);
+	}
+
+	if (i >= usec_timeout) {
+		dev_err(adev->dev, "failed to prime instruction cache\n");
+		return -EINVAL;
+	}
+
+	gfx_v13_0_set_pfp_ucode_start_addr(adev);
+
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		soc_v2_0_grbm_select(adev, 0, pipe_id, 0, 0);
+
+		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE0_LO,
+			     lower_32_bits(adev->gfx.pfp.pfp_fw_data_gpu_addr +
+					   pipe_id * ALIGN(fw_data_size, 64 * 1024)));
+
+		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE0_HI,
+			     upper_32_bits(adev->gfx.pfp.pfp_fw_data_gpu_addr +
+					   pipe_id * ALIGN(fw_data_size, 64 * 1024)));
+
+		tmp = RREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE_CNTL);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_RS64_DC_BASE_CNTL, VMID, 0);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_RS64_DC_BASE_CNTL, CACHE_POLICY, 0);
+		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE_CNTL, tmp);
+
+		/* Invalidate the data caches */
+		tmp = RREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_OP_CNTL);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_RS64_DC_OP_CNTL, INVALIDATE_DCACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_OP_CNTL, tmp);
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return 0;
+}
+
+static int gfx_v13_0_cp_gfx_load_me_microcode_rs64(struct amdgpu_device *adev)
+{
+	int r;
+	const struct gfx_firmware_header_v2_0 *me_hdr;
+	const __le32 *fw_ucode, *fw_data;
+	unsigned i, pipe_id, fw_ucode_size, fw_data_size;
+	uint32_t tmp;
+	uint32_t usec_timeout = 50000;  /* wait for 50ms */
+
+	me_hdr = (const struct gfx_firmware_header_v2_0 *)
+		adev->gfx.me_fw->data;
+
+	amdgpu_ucode_print_gfx_hdr(&me_hdr->header);
+
+	/* instruction */
+	fw_ucode = (const __le32 *)(adev->gfx.me_fw->data +
+		le32_to_cpu(me_hdr->ucode_offset_bytes));
+	fw_ucode_size = le32_to_cpu(me_hdr->ucode_size_bytes);
+	/* data */
+	fw_data = (const __le32 *)(adev->gfx.me_fw->data +
+		le32_to_cpu(me_hdr->data_offset_bytes));
+	fw_data_size = le32_to_cpu(me_hdr->data_size_bytes);
+
+	/* 64kb align*/
+	r = amdgpu_bo_create_reserved(adev, fw_ucode_size,
+				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->gfx.me.me_fw_obj,
+				      &adev->gfx.me.me_fw_gpu_addr,
+				      (void **)&adev->gfx.me.me_fw_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create me ucode bo\n", r);
+		gfx_v13_0_me_fini(adev);
+		return r;
+	}
+
+	r = amdgpu_bo_create_reserved(adev,
+				      ALIGN(fw_data_size, 64 * 1024) * adev->gfx.me.num_pipe_per_me,
+				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->gfx.me.me_fw_data_obj,
+				      &adev->gfx.me.me_fw_data_gpu_addr,
+				      (void **)&adev->gfx.me.me_fw_data_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create me data bo\n", r);
+		gfx_v13_0_me_fini(adev);
+		return r;
+	}
+
+	memcpy(adev->gfx.me.me_fw_ptr, fw_ucode, fw_ucode_size);
+
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		memcpy(adev->gfx.me.me_fw_data_ptr + pipe_id * ALIGN(fw_data_size, 64 * 1024) / 4, fw_data, fw_data_size);
+	}
+
+	amdgpu_bo_kunmap(adev->gfx.me.me_fw_obj);
+	amdgpu_bo_kunmap(adev->gfx.me.me_fw_data_obj);
+	amdgpu_bo_unreserve(adev->gfx.me.me_fw_obj);
+	amdgpu_bo_unreserve(adev->gfx.me.me_fw_data_obj);
+
+	if (amdgpu_emu_mode == 1)
+		amdgpu_device_flush_hdp(adev, NULL);
+
+	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_NATIVE_LO,
+		lower_32_bits(adev->gfx.me.me_fw_gpu_addr));
+	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_NATIVE_HI,
+		upper_32_bits(adev->gfx.me.me_fw_gpu_addr));
+
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_IC_BASE_NATIVE_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_NATIVE_CNTL, VMID, 0);
+	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_NATIVE_CNTL, CACHE_POLICY, 0);
+	tmp = REG_SET_FIELD(tmp, CP_ME_IC_BASE_NATIVE_CNTL, EXE_DISABLE, 0);
+	WREG32_SOC15(GC, 0, regCP_ME_IC_BASE_NATIVE_CNTL, tmp);
+
+	/*
+	 * Programming any of the CP_ME_IC_BASE registers
+	 * forces invalidation of the ME L1 I$. Wait for the
+	 * invalidation complete
+	 */
+	for (i = 0; i < usec_timeout; i++) {
+		tmp = RREG32_SOC15(GC, 0, regCP_ME_IC_OP_NATIVE_CNTL);
+		if (1 == REG_GET_FIELD(tmp, CP_ME_IC_OP_NATIVE_CNTL,
+			INVALIDATE_CACHE_COMPLETE))
+			break;
+		udelay(1);
+		if (amdgpu_emu_mode)
+			msleep(1);
+	}
+
+	if (i >= usec_timeout) {
+		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		return -EINVAL;
+	}
+
+	/* Prime the instruction caches */
+	tmp = RREG32_SOC15(GC, 0, regCP_ME_IC_OP_NATIVE_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_ME_IC_OP_NATIVE_CNTL, PRIME_ICACHE, 1);
+	WREG32_SOC15(GC, 0, regCP_ME_IC_OP_NATIVE_CNTL, tmp);
+
+	/* Waiting for instruction cache primed*/
+	for (i = 0; i < usec_timeout; i++) {
+		tmp = RREG32_SOC15(GC, 0, regCP_ME_IC_OP_NATIVE_CNTL);
+		if (1 == REG_GET_FIELD(tmp, CP_ME_IC_OP_NATIVE_CNTL,
+			ICACHE_PRIMED))
+			break;
+		udelay(1);
+		if (amdgpu_emu_mode)
+			msleep(1);
+	}
+
+	if (i >= usec_timeout) {
+		dev_err(adev->dev, "failed to prime instruction cache\n");
+		return -EINVAL;
+	}
+
+	gfx_v13_0_set_me_ucode_start_addr(adev);
+
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe_id = 0; pipe_id < adev->gfx.me.num_pipe_per_me; pipe_id++) {
+		soc_v2_0_grbm_select(adev, 0, pipe_id, 0, 0);
+
+		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE1_LO,
+			     lower_32_bits(adev->gfx.me.me_fw_data_gpu_addr +
+					   pipe_id * ALIGN(fw_data_size, 64 * 1024)));
+		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE1_HI,
+			     upper_32_bits(adev->gfx.me.me_fw_data_gpu_addr +
+					   pipe_id * ALIGN(fw_data_size, 64 * 1024)));
+
+		tmp = RREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE_CNTL);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_RS64_DC_BASE_CNTL, VMID, 0);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_RS64_DC_BASE_CNTL, CACHE_POLICY, 0);
+		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_BASE_CNTL, tmp);
+
+		/* Invalidate the data caches */
+		tmp = RREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_OP_CNTL);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_RS64_DC_OP_CNTL, INVALIDATE_DCACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_GFX_RS64_DC_OP_CNTL, tmp);
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return 0;
+}
+
+static int gfx_v13_0_cp_gfx_load_microcode(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (!adev->gfx.me_fw || !adev->gfx.pfp_fw)
+		return -EINVAL;
+
+	gfx_v13_0_cp_gfx_enable(adev, false);
+
+	r = gfx_v13_0_cp_gfx_load_pfp_microcode_rs64(adev);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to load pfp fw\n", r);
+		return r;
+	}
+
+	r = gfx_v13_0_cp_gfx_load_me_microcode_rs64(adev);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to load me fw\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
+static int gfx_v13_0_cp_gfx_start(struct amdgpu_device *adev)
+{
+	/* init the CP */
+	WREG32_SOC15(GC, 0, regCP_MAX_CONTEXT,
+		     adev->gfx.config.max_hw_contexts - 1);
+	WREG32_SOC15(GC, 0, regCP_DEVICE_ID, 1);
+
+	return 0;
+}
+
+static void gfx_v13_0_cp_compute_enable(struct amdgpu_device *adev, bool enable)
+{
+	u32 data;
+
+	data = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_INVALIDATE_ICACHE,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_PIPE0_RESET,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_PIPE1_RESET,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_PIPE2_RESET,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_PIPE3_RESET,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_PIPE0_ACTIVE,
+						 enable ? 1 : 0);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_PIPE1_ACTIVE,
+			                         enable ? 1 : 0);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_PIPE2_ACTIVE,
+						 enable ? 1 : 0);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_PIPE3_ACTIVE,
+						 enable ? 1 : 0);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC_HALT,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_PIPE0_RESET,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_PIPE1_RESET,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_PIPE2_RESET,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_PIPE3_RESET,
+						 enable ? 0 : 1);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_PIPE0_ACTIVE,
+						 enable ? 1 : 0);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_PIPE1_ACTIVE,
+						 enable ? 1 : 0);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_PIPE2_ACTIVE,
+						 enable ? 1 : 0);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_PIPE3_ACTIVE,
+						 enable ? 1 : 0);
+	data = REG_SET_FIELD(data, CP_MEC_RS64_CNTL, MEC2_HALT,
+						 enable ? 0 : 1);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, data);
+
+	adev->gfx.kiq[0].ring.sched.ready = enable;
+
+	if (amdgpu_emu_mode == 1)
+		msleep(50);
+
+	udelay(50);
+}
+
+static int gfx_v13_0_cp_compute_load_microcode_rs64(struct amdgpu_device *adev)
+{
+	const struct gfx_firmware_header_v2_0 *mec_hdr;
+	const __le32 *fw_ucode, *fw_data;
+	u32 tmp, fw_ucode_size, fw_data_size;
+	u32 mec_id, pipe_id, i, usec_timeout = 500; /* Wait for 50 ms */
+	u32 *fw_ucode_ptr, *fw_data_ptr;
+	int r;
+
+	if (!adev->gfx.mec_fw)
+		return -EINVAL;
+
+	gfx_v13_0_cp_compute_enable(adev, false);
+
+	mec_hdr = (const struct gfx_firmware_header_v2_0 *)adev->gfx.mec_fw->data;
+	amdgpu_ucode_print_gfx_hdr(&mec_hdr->header);
+
+	fw_ucode = (const __le32 *) (adev->gfx.mec_fw->data +
+				le32_to_cpu(mec_hdr->ucode_offset_bytes));
+	fw_ucode_size = le32_to_cpu(mec_hdr->ucode_size_bytes);
+
+	fw_data = (const __le32 *) (adev->gfx.mec_fw->data +
+				le32_to_cpu(mec_hdr->data_offset_bytes));
+	fw_data_size = le32_to_cpu(mec_hdr->data_size_bytes);
+
+	r = amdgpu_bo_create_reserved(adev, fw_ucode_size,
+				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->gfx.mec.mec_fw_obj,
+				      &adev->gfx.mec.mec_fw_gpu_addr,
+				      (void **)&fw_ucode_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
+		gfx_v13_0_mec_fini(adev);
+		return r;
+	}
+
+	r = amdgpu_bo_create_reserved(adev,
+				      ALIGN(fw_data_size, 64 * 1024) *
+				      adev->gfx.mec.num_pipe_per_mec * adev->gfx.mec.num_mec,
+				      64 * 1024, AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->gfx.mec.mec_fw_data_obj,
+				      &adev->gfx.mec.mec_fw_data_gpu_addr,
+				      (void **)&fw_data_ptr);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create mec fw ucode bo\n", r);
+		gfx_v13_0_mec_fini(adev);
+		return r;
+	}
+
+	memcpy(fw_ucode_ptr, fw_ucode, fw_ucode_size);
+	for (mec_id = 0; mec_id < adev->gfx.mec.num_mec; mec_id++) {
+		for (pipe_id = 0; pipe_id < adev->gfx.mec.num_pipe_per_mec; pipe_id++) {
+			memcpy(fw_data_ptr +
+			       (mec_id * adev->gfx.mec.num_pipe_per_mec * ALIGN(fw_data_size, 64 * 1024) +
+			       pipe_id * ALIGN(fw_data_size, 64 * 1024)) / 4, fw_data, fw_data_size);
+		}
+	}
+
+	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_obj);
+	amdgpu_bo_kunmap(adev->gfx.mec.mec_fw_data_obj);
+	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_obj);
+	amdgpu_bo_unreserve(adev->gfx.mec.mec_fw_data_obj);
+
+	tmp = RREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_NATIVE_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_NATIVE_CNTL, VMID, 0);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_NATIVE_CNTL, EXE_DISABLE, 0);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_BASE_NATIVE_CNTL, CACHE_POLICY, 0);
+	WREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_NATIVE_CNTL, tmp);
+
+	mutex_lock(&adev->srbm_mutex);
+	for (mec_id = 0; mec_id < adev->gfx.mec.num_mec; mec_id++) {
+		for (pipe_id = 0; pipe_id < adev->gfx.mec.num_pipe_per_mec; pipe_id++) {
+			soc_v2_0_grbm_select(adev, mec_id + 1, pipe_id, 0, 0);
+
+			WREG32_SOC15(GC, 0, regCP_MEC_MDBASE_LO,
+				lower_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
+					      (mec_id * adev->gfx.mec.num_pipe_per_mec * ALIGN(fw_data_size, 64 * 1024) +
+					      pipe_id * ALIGN(fw_data_size, 64 * 1024))));
+			WREG32_SOC15(GC, 0, regCP_MEC_MDBASE_HI,
+				upper_32_bits(adev->gfx.mec.mec_fw_data_gpu_addr +
+					      (mec_id * adev->gfx.mec.num_pipe_per_mec * ALIGN(fw_data_size, 64 * 1024) +
+					      pipe_id * ALIGN(fw_data_size, 64 * 1024))));
+
+			WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START,
+				mec_hdr->ucode_start_addr_lo >> 2 |
+				mec_hdr->ucode_start_addr_hi << 30);
+			WREG32_SOC15(GC, 0, regCP_MEC_RS64_PRGRM_CNTR_START_HI,
+				mec_hdr->ucode_start_addr_hi >> 2);
+
+			WREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_NATIVE_LO,
+				lower_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
+			WREG32_SOC15(GC, 0, regCP_CPC_IC_BASE_NATIVE_HI,
+				upper_32_bits(adev->gfx.mec.mec_fw_gpu_addr));
+		}
+	}
+	mutex_unlock(&adev->srbm_mutex);
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	/* Trigger an invalidation of the L1 instruction caches */
+	tmp = RREG32_SOC15(GC, 0, regCP_CPC_IC_OP_NATIVE_CNTL);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_OP_NATIVE_CNTL, INVALIDATE_CACHE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_CPC_IC_OP_NATIVE_CNTL, PRIME_ICACHE, 0);
+	WREG32_SOC15(GC, 0, regCP_CPC_IC_OP_NATIVE_CNTL, tmp);
+
+	/* Wait for invalidation complete */
+	for (i = 0; i < usec_timeout; i++) {
+		tmp = RREG32_SOC15(GC, 0, regCP_CPC_IC_OP_NATIVE_CNTL);
+		if (1 == REG_GET_FIELD(tmp, CP_CPC_IC_OP_NATIVE_CNTL,
+				       INVALIDATE_CACHE_COMPLETE))
+			break;
+		udelay(1);
+		if (amdgpu_emu_mode == 1)
+			msleep(1);
+	}
+
+	if (i >= usec_timeout) {
+		dev_err(adev->dev, "failed to invalidate instruction cache\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_kiq_setting(struct amdgpu_ring *ring)
+{
+	uint32_t tmp;
+	struct amdgpu_device *adev = ring->adev;
+
+	/* tell RLC which is KIQ queue */
+	tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
+	tmp &= 0xffffff00;
+	tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
+	WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp | 0x80);
+}
+
+static void gfx_v13_0_cp_set_doorbell_range(struct amdgpu_device *adev)
+{
+	/* set graphics engine doorbell range */
+	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_LOWER,
+		     (adev->doorbell_index.gfx_ring0 * 2) << 2);
+	WREG32_SOC15(GC, 0, regCP_RB_DOORBELL_RANGE_UPPER,
+		     (adev->doorbell_index.gfx_userqueue_end * 2) << 2);
+
+	/* set compute engine doorbell range */
+	WREG32_SOC15(GC, 0, regCP_MEC_DOORBELL_RANGE_LOWER,
+		     (adev->doorbell_index.kiq * 2) << 2);
+	WREG32_SOC15(GC, 0, regCP_MEC_DOORBELL_RANGE_UPPER,
+		     (adev->doorbell_index.userqueue_end * 2) << 2);
+}
+
+static int gfx_v13_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
+				  struct amdgpu_mqd_prop *prop)
+{
+	struct v13_gfx_mqd *mqd = m;
+	uint64_t hqd_gpu_addr, wb_gpu_addr;
+	uint32_t tmp;
+	uint32_t rb_bufsz;
+
+	/* set up gfx hqd wptr */
+	mqd->cp_gfx_hqd_wptr = 0;
+	mqd->cp_gfx_hqd_wptr_hi = 0;
+
+	/* set the pointer to the MQD */
+	mqd->cp_mqd_base_addr = prop->mqd_gpu_addr & 0xfffffffc;
+	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
+
+	/* set up mqd control */
+	tmp = regCP_GFX_MQD_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, VMID, 0);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, PRIV_STATE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_MQD_CONTROL, CACHE_POLICY, 0);
+	mqd->cp_gfx_mqd_control = tmp;
+
+	/* set up gfx_hqd_vimd with 0x0 to indicate the ring buffer's vmid */
+	tmp = regCP_GFX_HQD_VMID_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_VMID, VMID, 0);
+	mqd->cp_gfx_hqd_vmid = 0;
+
+	/* set up default queue priority level
+	 * 0x0 = low priority, 0x1 = high priority */
+	tmp = regCP_GFX_HQD_QUEUE_PRIORITY_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUEUE_PRIORITY, PRIORITY_LEVEL, 0);
+	mqd->cp_gfx_hqd_queue_priority = tmp;
+
+	/* set up time quantum */
+	tmp = regCP_GFX_HQD_QUANTUM_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_QUANTUM, QUANTUM_EN, 1);
+	mqd->cp_gfx_hqd_quantum = tmp;
+
+	/* set up gfx hqd base. this is similar as CP_RB_BASE */
+	hqd_gpu_addr = prop->hqd_base_gpu_addr >> 8;
+	mqd->cp_gfx_hqd_base = hqd_gpu_addr;
+	mqd->cp_gfx_hqd_base_hi = upper_32_bits(hqd_gpu_addr);
+
+	/* set up hqd_rptr_addr/_hi, similar as CP_RB_RPTR */
+	wb_gpu_addr = prop->rptr_gpu_addr;
+	mqd->cp_gfx_hqd_rptr_addr = wb_gpu_addr & 0xfffffffc;
+	mqd->cp_gfx_hqd_rptr_addr_hi =
+		upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	/* set up rb_wptr_poll addr */
+	wb_gpu_addr = prop->wptr_gpu_addr;
+	mqd->cp_rb_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
+	mqd->cp_rb_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	/* set up the gfx_hqd_control, similar as CP_RB0_CNTL */
+	rb_bufsz = order_base_2(prop->queue_size / 4) - 1;
+	tmp = regCP_GFX_HQD_CNTL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_BLKSZ, rb_bufsz - 2);
+
+#ifdef __BIG_ENDIAN
+	tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, BUF_SWAP, 1);
+#endif
+	if (prop->tmz_queue) {
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_MATCH, 1);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, TMZ_STATE, 1);
+	}
+	if (prop->kernel_queue) {
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, KMD_QUEUE, 1);
+	} else {
+		tmp = REG_SET_FIELD(tmp, CP_GFX_HQD_CNTL, RB_NON_PRIV, 1);
+	}
+
+	mqd->cp_gfx_hqd_cntl = tmp;
+
+	/* set up cp_doorbell_control */
+	tmp = regCP_RB_DOORBELL_CONTROL_DEFAULT;
+	if (prop->use_doorbell) {
+		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+				    DOORBELL_OFFSET, prop->doorbell_index);
+		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+				    DOORBELL_EN, 1);
+	} else
+		tmp = REG_SET_FIELD(tmp, CP_RB_DOORBELL_CONTROL,
+				    DOORBELL_EN, 0);
+	mqd->cp_rb_doorbell_control = tmp;
+
+	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
+	mqd->cp_gfx_hqd_rptr = regCP_GFX_HQD_RPTR_DEFAULT;
+
+	/* active the queue */
+	mqd->cp_gfx_hqd_active = 1;
+
+	/* set gfx UQ items */
+	mqd->shadow_base_lo = lower_32_bits(prop->shadow_addr);
+	mqd->shadow_base_hi = upper_32_bits(prop->shadow_addr);
+	mqd->fw_work_area_base_lo = lower_32_bits(prop->csa_addr);
+	mqd->fw_work_area_base_hi = upper_32_bits(prop->csa_addr);
+	mqd->fence_addr_lo = lower_32_bits(prop->fence_address);
+	mqd->fence_addr_hi = upper_32_bits(prop->fence_address);
+
+	return 0;
+}
+
+static int gfx_v13_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct v13_gfx_mqd *mqd = ring->mqd_ptr;
+	int mqd_idx = ring - &adev->gfx.gfx_ring[0];
+
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
+		memset((void *)mqd, 0, sizeof(*mqd));
+		mutex_lock(&adev->srbm_mutex);
+		soc_v2_0_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		amdgpu_ring_init_mqd(ring);
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+		if (adev->gfx.me.mqd_backup[mqd_idx])
+			memcpy_fromio(adev->gfx.me.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+	} else {
+		/* restore mqd with the backup copy */
+		if (adev->gfx.me.mqd_backup[mqd_idx])
+			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
+		/* reset the ring */
+		ring->wptr = 0;
+		*(u64 *)ring->wptr_cpu_addr = 0;
+		amdgpu_ring_clear_ring(ring);
+	}
+
+	return 0;
+}
+
+static int gfx_v13_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		r = gfx_v13_0_kgq_init_queue(&adev->gfx.gfx_ring[i], false);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_gfx_enable_kgq(adev, 0);
+	if (r)
+		return r;
+
+	return gfx_v13_0_cp_gfx_start(adev);
+}
+
+static int gfx_v13_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
+				      struct amdgpu_mqd_prop *prop)
+{
+	struct v13_compute_mqd *mqd = m;
+	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
+	uint32_t tmp;
+
+	mqd->header = 0xC0310800;
+	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se3 = 0xffffffff;
+
+	mqd->compute_misc_reserved = 0x00000003;
+
+	eop_base_addr = prop->eop_gpu_addr >> 8;
+	mqd->cp_hqd_eop_base_addr_lo = eop_base_addr;
+	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
+
+	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
+	tmp = regCP_HQD_EOP_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
+			(order_base_2(GFX13_MEC_HPD_SIZE / 4) - 1));
+
+	mqd->cp_hqd_eop_control = tmp;
+
+	/* enable doorbell? */
+	tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
+
+	if (prop->use_doorbell) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_OFFSET, prop->doorbell_index);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_EN, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_SOURCE, 0);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_HIT, 0);
+	} else {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_EN, 0);
+	}
+
+	mqd->cp_hqd_pq_doorbell_control = tmp;
+
+	/* disable the queue if it's active */
+	mqd->cp_hqd_dequeue_request = 0;
+	mqd->cp_hqd_pq_rptr = 0;
+	mqd->cp_hqd_pq_wptr_lo = 0;
+	mqd->cp_hqd_pq_wptr_hi = 0;
+
+	/* set the pointer to the MQD */
+	mqd->cp_mqd_base_addr_lo = prop->mqd_gpu_addr & 0xfffffffc;
+	mqd->cp_mqd_base_addr_hi = upper_32_bits(prop->mqd_gpu_addr);
+
+	/* set MQD vmid to 0 */
+	tmp = regCP_MQD_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
+	mqd->cp_mqd_control = tmp;
+
+	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
+	hqd_gpu_addr = prop->hqd_base_gpu_addr >> 8;
+	mqd->cp_hqd_pq_base_lo = hqd_gpu_addr;
+	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
+
+	/* set up the HQD, this is similar to CP_RB0_CNTL */
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
+			    (order_base_2(prop->queue_size / 4) - 1));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
+			    (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
+			    prop->allow_tunneling);
+	if (prop->kernel_queue) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	}
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, NO_UPDATE_RPTR, 1);
+	if (prop->tmz_queue)
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TMZ, 1);
+	mqd->cp_hqd_pq_control = tmp;
+
+	/* set the wb address whether it's enabled or not */
+	wb_gpu_addr = prop->rptr_gpu_addr;
+	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
+	mqd->cp_hqd_pq_rptr_report_addr_hi =
+		upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
+	wb_gpu_addr = prop->wptr_gpu_addr;
+	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffffc;
+	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	tmp = 0;
+	/* enable the doorbell if requested */
+	if (prop->use_doorbell) {
+		tmp = regCP_HQD_PQ_DOORBELL_CONTROL_DEFAULT;
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_OFFSET, prop->doorbell_index);
+
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_EN, 1);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_SOURCE, 0);
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_HIT, 0);
+	}
+
+	mqd->cp_hqd_pq_doorbell_control = tmp;
+
+	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
+	mqd->cp_hqd_pq_rptr = regCP_HQD_PQ_RPTR_DEFAULT;
+
+	/* set the vmid for the queue */
+	mqd->cp_hqd_vmid = 0;
+
+	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE, PRELOAD_SIZE, 0x65);
+	mqd->cp_hqd_persistent_state = tmp;
+
+	/* set MIN_IB_AVAIL_SIZE */
+	tmp = regCP_HQD_IB_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 1);
+	mqd->cp_hqd_ib_control = tmp;
+
+	/* set static priority for a compute queue/ring */
+	mqd->cp_hqd_pipe_priority = prop->hqd_pipe_priority;
+	mqd->cp_hqd_queue_priority = prop->hqd_queue_priority;
+
+	mqd->cp_hqd_active = prop->hqd_active;
+
+	/* set UQ fenceaddress */
+	mqd->fence_addr_lo = lower_32_bits(prop->fence_address);
+	mqd->fence_addr_hi = upper_32_bits(prop->fence_address);
+
+	return 0;
+}
+
+static int gfx_v13_0_kiq_init_register(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct v13_compute_mqd *mqd = ring->mqd_ptr;
+	int j;
+
+	/* inactivate the queue */
+	if (amdgpu_sriov_vf(adev))
+		WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, 0);
+
+	/* disable wptr polling */
+	WREG32_FIELD15_PREREG(GC, 0, CP_PQ_WPTR_POLL_CNTL, EN, 0);
+
+	/* write the EOP addr */
+	WREG32_SOC15(GC, 0, regCP_HQD_EOP_BASE_ADDR,
+	       mqd->cp_hqd_eop_base_addr_lo);
+	WREG32_SOC15(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI,
+	       mqd->cp_hqd_eop_base_addr_hi);
+
+	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
+	WREG32_SOC15(GC, 0, regCP_HQD_EOP_CONTROL,
+	       mqd->cp_hqd_eop_control);
+
+	/* enable doorbell? */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL,
+	       mqd->cp_hqd_pq_doorbell_control);
+
+	/* disable the queue if it's active */
+	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+		for (j = 0; j < adev->usec_timeout; j++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		if (amdgpu_emu_mode == 1)
+			msleep(1);
+		}
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST,
+		       mqd->cp_hqd_dequeue_request);
+		WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR,
+		       mqd->cp_hqd_pq_rptr);
+		WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO,
+		       mqd->cp_hqd_pq_wptr_lo);
+		WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI,
+		       mqd->cp_hqd_pq_wptr_hi);
+	}
+
+	/* set the pointer to the MQD */
+	WREG32_SOC15(GC, 0, regCP_MQD_BASE_ADDR,
+	       mqd->cp_mqd_base_addr_lo);
+	WREG32_SOC15(GC, 0, regCP_MQD_BASE_ADDR_HI,
+	       mqd->cp_mqd_base_addr_hi);
+
+	/* set MQD vmid to 0 */
+	WREG32_SOC15(GC, 0, regCP_MQD_CONTROL,
+	       mqd->cp_mqd_control);
+
+	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE,
+	       mqd->cp_hqd_pq_base_lo);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE_HI,
+	       mqd->cp_hqd_pq_base_hi);
+
+	/* set up the HQD, this is similar to CP_RB0_CNTL */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL,
+	       mqd->cp_hqd_pq_control);
+
+	/* set the wb address whether it's enabled or not */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR_REPORT_ADDR,
+		mqd->cp_hqd_pq_rptr_report_addr_lo);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
+		mqd->cp_hqd_pq_rptr_report_addr_hi);
+
+	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR,
+	       mqd->cp_hqd_pq_wptr_poll_addr_lo);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+	       mqd->cp_hqd_pq_wptr_poll_addr_hi);
+
+	/* enable the doorbell if requested */
+	if (ring->use_doorbell) {
+		WREG32_SOC15(GC, 0, regCP_MEC_DOORBELL_RANGE_LOWER,
+			(adev->doorbell_index.kiq * 2) << 2);
+		WREG32_SOC15(GC, 0, regCP_MEC_DOORBELL_RANGE_UPPER,
+			(adev->doorbell_index.userqueue_end * 2) << 2);
+	}
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL,
+	       mqd->cp_hqd_pq_doorbell_control);
+
+	/* reset read and write pointers, similar to CP_RB0_WPTR/_RPTR */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO,
+	       mqd->cp_hqd_pq_wptr_lo);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI,
+	       mqd->cp_hqd_pq_wptr_hi);
+
+	/* set the vmid for the queue */
+	WREG32_SOC15(GC, 0, regCP_HQD_VMID, mqd->cp_hqd_vmid);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE,
+	       mqd->cp_hqd_persistent_state);
+
+	/* activate the queue */
+	WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE,
+	       mqd->cp_hqd_active);
+
+	if (ring->use_doorbell)
+		WREG32_FIELD15_PREREG(GC, 0, CP_PQ_STATUS, DOORBELL_ENABLE, 1);
+
+	return 0;
+}
+
+static int gfx_v13_0_kiq_init_queue(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct v13_compute_mqd *mqd = ring->mqd_ptr;
+	int mqd_idx = AMDGPU_MAX_COMPUTE_RINGS;
+
+	gfx_v13_0_kiq_setting(ring);
+
+	if (amdgpu_in_reset(adev)) { /* for GPU_RESET case */
+		/* reset MQD to a clean status */
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
+
+		/* reset ring buffer */
+		ring->wptr = 0;
+		amdgpu_ring_clear_ring(ring);
+
+		mutex_lock(&adev->srbm_mutex);
+		soc_v2_0_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v13_0_kiq_init_register(ring);
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	} else {
+		memset((void *)mqd, 0, sizeof(*mqd));
+		if (amdgpu_sriov_vf(adev) && adev->in_suspend)
+			amdgpu_ring_clear_ring(ring);
+		mutex_lock(&adev->srbm_mutex);
+		soc_v2_0_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		amdgpu_ring_init_mqd(ring);
+		gfx_v13_0_kiq_init_register(ring);
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+	}
+
+	return 0;
+}
+
+static int gfx_v13_0_kcq_init_queue(struct amdgpu_ring *ring, bool reset)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct v13_compute_mqd *mqd = ring->mqd_ptr;
+	int mqd_idx = ring - &adev->gfx.compute_ring[0];
+
+	if (!reset && !amdgpu_in_reset(adev) && !adev->in_suspend) {
+		memset((void *)mqd, 0, sizeof(*mqd));
+		mutex_lock(&adev->srbm_mutex);
+		soc_v2_0_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		amdgpu_ring_init_mqd(ring);
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy_fromio(adev->gfx.mec.mqd_backup[mqd_idx], mqd, sizeof(*mqd));
+	} else {
+		/* restore MQD to a clean status */
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy_toio(mqd, adev->gfx.mec.mqd_backup[mqd_idx], sizeof(*mqd));
+		/* reset ring buffer */
+		ring->wptr = 0;
+		*(u64 *)ring->wptr_cpu_addr = 0;
+		amdgpu_ring_clear_ring(ring);
+	}
+
+	return 0;
+}
+
+static int gfx_v13_0_kiq_resume(struct amdgpu_device *adev)
+{
+	gfx_v13_0_kiq_init_queue(&adev->gfx.kiq[0].ring);
+	adev->gfx.kiq[0].ring.sched.ready = true;
+	return 0;
+}
+
+static int gfx_v13_0_kcq_resume(struct amdgpu_device *adev)
+{
+	int i, r;
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		r = gfx_v13_0_kcq_init_queue(&adev->gfx.compute_ring[i], false);
+		if (r)
+			return r;
+	}
+
+	return amdgpu_gfx_enable_kcq(adev, 0);
+}
+
+static int gfx_v13_0_cp_resume(struct amdgpu_device *adev)
+{
+	int r, i;
+	struct amdgpu_ring *ring;
+
+	if (!(adev->flags & AMD_IS_APU))
+		gfx_v13_0_enable_gui_idle_interrupt(adev, false);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		/* legacy firmware loading */
+		r = gfx_v13_0_cp_gfx_load_microcode(adev);
+		if (r)
+			return r;
+
+		r = gfx_v13_0_cp_compute_load_microcode_rs64(adev);
+		if (r)
+			return r;
+	}
+
+	gfx_v13_0_cp_set_doorbell_range(adev);
+
+	gfx_v13_0_cp_compute_enable(adev, true);
+	gfx_v13_0_cp_gfx_enable(adev, true);
+
+	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
+		r = amdgpu_mes_kiq_hw_init(adev, 0);
+	else
+		r = gfx_v13_0_kiq_resume(adev);
+	if (r)
+		return r;
+
+	r = gfx_v13_0_kcq_resume(adev);
+	if (r)
+		return r;
+
+	r = gfx_v13_0_cp_async_gfx_ring_resume(adev);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+		ring = &adev->gfx.gfx_ring[i];
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+	}
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+		ring = &adev->gfx.compute_ring[i];
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_cp_enable(struct amdgpu_device *adev, bool enable)
+{
+	gfx_v13_0_cp_gfx_enable(adev, enable);
+	gfx_v13_0_cp_compute_enable(adev, enable);
+}
+
+static int gfx_v13_0_gfxhub_enable(struct amdgpu_device *adev)
+{
+	int r;
+	bool value;
+
+	r = adev->gfxhub.funcs->gart_enable(adev);
+	if (r)
+		return r;
+
+	amdgpu_device_flush_hdp(adev, NULL);
+
+	value = (amdgpu_vm_fault_stop == AMDGPU_VM_FAULT_STOP_ALWAYS) ?
+		false : true;
+
+	adev->gfxhub.funcs->set_fault_enable_default(adev, value);
+	/* TODO investigate why this and the hdp flush above is needed,
+	 * are we missing a flush somewhere else? */
+	adev->gmc.gmc_funcs->flush_gpu_tlb(adev, 0, AMDGPU_GFXHUB(0), 0);
+
+	return 0;
+}
+
+static int get_gb_addr_config(struct amdgpu_device *adev)
+{
+	u32 gb_addr_config;
+
+	gb_addr_config = RREG32_SOC15(GC, 0, regGB_ADDR_CONFIG);
+	if (gb_addr_config == 0)
+		return -EINVAL;
+
+	adev->gfx.config.gb_addr_config_fields.num_pkrs =
+		1 << REG_GET_FIELD(gb_addr_config, GB_ADDR_CONFIG, NUM_PKRS);
+
+	adev->gfx.config.gb_addr_config = gb_addr_config;
+
+	adev->gfx.config.gb_addr_config_fields.num_pipes = 1 <<
+			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
+				      GB_ADDR_CONFIG, NUM_PIPES);
+
+	adev->gfx.config.max_tile_pipes =
+		adev->gfx.config.gb_addr_config_fields.num_pipes;
+
+	adev->gfx.config.gb_addr_config_fields.max_compress_frags = 1 <<
+			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
+				      GB_ADDR_CONFIG, MAX_COMPRESSED_FRAGS);
+	adev->gfx.config.gb_addr_config_fields.num_rb_per_se = 1 <<
+			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
+				      GB_ADDR_CONFIG, NUM_RB_PER_SE);
+	adev->gfx.config.gb_addr_config_fields.num_se = 1 <<
+			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
+				      GB_ADDR_CONFIG, NUM_SHADER_ENGINES);
+	adev->gfx.config.gb_addr_config_fields.pipe_interleave_size = 1 << (8 +
+			REG_GET_FIELD(adev->gfx.config.gb_addr_config,
+				      GB_ADDR_CONFIG, PIPE_INTERLEAVE_SIZE));
+
+	return 0;
+}
+
+static void gfx_v13_0_disable_gpa_mode(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(GC, 0, regCPC_PSP_DEBUG);
+	data |= CPC_PSP_DEBUG__GPA_OVERRIDE_MASK;
+	WREG32_SOC15(GC, 0, regCPC_PSP_DEBUG, data);
+
+	data = RREG32_SOC15(GC, 0, regCPG_PSP_DEBUG);
+	data |= CPG_PSP_DEBUG__GPA_OVERRIDE_MASK;
+	WREG32_SOC15(GC, 0, regCPG_PSP_DEBUG, data);
+}
+
+static void gfx_v13_0_init_golden_registers(struct amdgpu_device *adev)
+{
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		soc15_program_register_sequence(adev,
+						golden_settings_gc_13_0,
+						(const u32)ARRAY_SIZE(golden_settings_gc_13_0));
+
+		if (adev->rev_id == 0)
+			soc15_program_register_sequence(adev,
+					golden_settings_gc_13_0_rev0,
+					(const u32)ARRAY_SIZE(golden_settings_gc_13_0_rev0));
+		break;
+	default:
+		break;
+	}
+}
+
+static int gfx_v13_0_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
+		if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+			/* RLC autoload sequence 1: Program rlc ram */
+			if (adev->gfx.imu.funcs->program_rlc_ram)
+				adev->gfx.imu.funcs->program_rlc_ram(adev);
+		}
+		/* rlc autoload firmware */
+		r = gfx_v13_0_rlc_backdoor_autoload_enable(adev);
+		if (r)
+			return r;
+	} else {
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+				if (adev->gfx.imu.funcs->load_microcode)
+					adev->gfx.imu.funcs->load_microcode(adev);
+				if (adev->gfx.imu.funcs->setup_imu)
+					adev->gfx.imu.funcs->setup_imu(adev);
+				if (adev->gfx.imu.funcs->start_imu)
+					adev->gfx.imu.funcs->start_imu(adev);
+			}
+
+			/* disable gpa mode in backdoor loading */
+			gfx_v13_0_disable_gpa_mode(adev);
+		}
+	}
+
+	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) ||
+	    (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)) {
+		r = gfx_v13_0_wait_for_rlc_autoload_complete(adev);
+		if (r) {
+			dev_err(adev->dev, "(%d) failed to wait rlc autoload complete\n", r);
+			return r;
+		}
+	}
+
+	if (!amdgpu_emu_mode)
+		gfx_v13_0_init_golden_registers(adev);
+
+	adev->gfx.is_poweron = true;
+
+	if (get_gb_addr_config(adev))
+		DRM_WARN("Invalid gb_addr_config !\n");
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP)
+		gfx_v13_0_config_gfx_rs64(adev);
+
+	r = gfx_v13_0_gfxhub_enable(adev);
+	if (r)
+		return r;
+
+	if ((adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT ||
+	     adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) &&
+	     (amdgpu_dpm == 1)) {
+		/**
+		 * For gfx 13, rlc firmware loading relies on smu firmware is
+		 * loaded firstly, so in direct type, it has to load smc ucode
+		 * here before rlc.
+		 */
+		r = amdgpu_pm_load_smu_firmware(adev, NULL);
+		if (r)
+			return r;
+	}
+
+	gfx_v13_0_constants_init(adev);
+
+	if (adev->nbio.funcs->gc_doorbell_init)
+		adev->nbio.funcs->gc_doorbell_init(adev);
+
+	r = gfx_v13_0_rlc_resume(adev);
+	if (r)
+		return r;
+
+	/*
+	 * init golden registers and rlc resume may override some registers,
+	 * reconfig them here
+	 */
+	gfx_v13_0_tcp_harvest(adev);
+
+	r = gfx_v13_0_cp_resume(adev);
+	if (r)
+		return r;
+
+	return r;
+}
+
+static int gfx_v13_0_set_userq_eop_interrupts(struct amdgpu_device *adev,
+					      bool enable)
+{
+	unsigned int irq_type;
+	int m, p, r;
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_GFX]) {
+		for (m = 0; m < adev->gfx.me.num_me; m++) {
+			for (p = 0; p < adev->gfx.me.num_pipe_per_me; p++) {
+				irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq, irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+				if (r) {
+					if (!enable)
+						return r;
+					goto err_gfx;
+				}
+			}
+		}
+	}
+
+	if (adev->userq_funcs[AMDGPU_HW_IP_COMPUTE]) {
+		for (m = 0; m < adev->gfx.mec.num_mec; ++m) {
+			for (p = 0; p < adev->gfx.mec.num_pipe_per_mec; p++) {
+				irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+					+ (m * adev->gfx.mec.num_pipe_per_mec)
+					+ p;
+				if (enable)
+					r = amdgpu_irq_get(adev, &adev->gfx.eop_irq, irq_type);
+				else
+					r = amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+				if (r) {
+					if (!enable)
+						return r;
+					goto err_compute;
+				}
+			}
+		}
+	}
+
+	return 0;
+
+err_compute:
+	for (p--; p >= 0; p--) {
+		irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+			+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+		amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+	}
+	for (m--; m >= 0; m--) {
+		for (p = adev->gfx.mec.num_pipe_per_mec - 1; p >= 0; p--) {
+			irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
+				+ (m * adev->gfx.mec.num_pipe_per_mec) + p;
+			amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+		}
+	}
+	m = adev->gfx.me.num_me;
+err_gfx:
+	for (p--; p >= 0; p--) {
+		irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+		amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+	}
+	for (m--; m >= 0; m--) {
+		for (p = adev->gfx.me.num_pipe_per_me - 1; p >= 0; p--) {
+			irq_type = AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP + p;
+			amdgpu_irq_put(adev, &adev->gfx.eop_irq, irq_type);
+		}
+	}
+	return r;
+}
+
+static int gfx_v13_0_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	uint32_t tmp;
+
+	cancel_delayed_work_sync(&adev->gfx.idle_work);
+
+	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
+	amdgpu_irq_put(adev, &adev->gfx.bad_op_irq, 0);
+	gfx_v13_0_set_userq_eop_interrupts(adev, false);
+
+	if (!adev->no_hw_access) {
+		if (amdgpu_gfx_disable_kgq(adev, 0))
+			DRM_ERROR("KGQ disable failed\n");
+
+		if (amdgpu_gfx_disable_kcq(adev, 0))
+			DRM_ERROR("KCQ disable failed\n");
+
+		amdgpu_mes_kiq_hw_fini(adev, 0);
+	}
+
+	if (amdgpu_sriov_vf(adev)) {
+		gfx_v13_0_cp_gfx_enable(adev, false);
+		/* Program KIQ position of RLC_CP_SCHEDULERS during destroy */
+		tmp = RREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS);
+		tmp &= 0xffffff00;
+		WREG32_SOC15(GC, 0, regRLC_CP_SCHEDULERS, tmp);
+
+		return 0;
+	}
+	gfx_v13_0_cp_enable(adev, false);
+	gfx_v13_0_enable_gui_idle_interrupt(adev, false);
+
+	adev->gfxhub.funcs->gart_disable(adev);
+
+	adev->gfx.is_poweron = false;
+
+	return 0;
+}
+
+static int gfx_v13_0_suspend(struct amdgpu_ip_block *ip_block)
+{
+	return gfx_v13_0_hw_fini(ip_block);
+}
+
+static int gfx_v13_0_resume(struct amdgpu_ip_block *ip_block)
+{
+	return gfx_v13_0_hw_init(ip_block);
+}
+
+static int gfx_v13_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
+{
+	unsigned i;
+	u32 tmp;
+	struct amdgpu_device *adev = ip_block->adev;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* read MC_STATUS */
+		tmp = RREG32_SOC15(GC, 0, regGRBM_STATUS) &
+			GRBM_STATUS__GUI_ACTIVE_MASK;
+
+		if (!REG_GET_FIELD(tmp, GRBM_STATUS, GUI_ACTIVE))
+			return 0;
+		udelay(1);
+		if (amdgpu_emu_mode == 1)
+			msleep(1);
+	}
+	return -ETIMEDOUT;
+}
+
+static uint64_t gfx_v13_0_get_gpu_clock_counter(struct amdgpu_device *adev)
+{
+	uint64_t clock = 0;
+	uint64_t clock_counter_lo, clock_counter_hi_pre, clock_counter_hi_after;
+
+	if (amdgpu_sriov_vf(adev)) {
+		amdgpu_gfx_off_ctrl(adev, false);
+		mutex_lock(&adev->gfx.gpu_clock_mutex);
+		clock_counter_hi_pre = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
+		clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		clock_counter_hi_after = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_HI);
+		if (clock_counter_hi_pre != clock_counter_hi_after)
+			clock_counter_lo = (uint64_t)RREG32_SOC15(GC, 0, regCP_MES_MTIME_LO);
+		mutex_unlock(&adev->gfx.gpu_clock_mutex);
+		amdgpu_gfx_off_ctrl(adev, true);
+
+		return (clock_counter_hi_after << 32ULL) | clock_counter_lo;
+	}
+
+	if (adev->smuio.funcs &&
+	    adev->smuio.funcs->get_gpu_clock_counter)
+		clock = adev->smuio.funcs->get_gpu_clock_counter(adev);
+	else
+		dev_warn(adev->dev, "query gpu clock counter is not supported\n");
+
+	return clock;
+}
+
+static int gfx_v13_0_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	switch (amdgpu_user_queue) {
+	case 0:
+	default:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = true;
+		break;
+	case 1:
+		adev->gfx.disable_kq = false;
+		adev->gfx.disable_uq = false;
+		break;
+	case -1:
+	case 2:
+		adev->gfx.disable_kq = true;
+		adev->gfx.disable_uq = false;
+		break;
+	}
+
+	adev->gfx.funcs = &gfx_v13_0_gfx_funcs;
+
+	if (adev->gfx.disable_kq) {
+		adev->gfx.num_gfx_rings = 0;
+		adev->gfx.num_compute_rings = 0;
+	} else {
+		adev->gfx.num_gfx_rings = GFX13_NUM_GFX_RINGS;
+		adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
+						  AMDGPU_MAX_COMPUTE_RINGS);
+	}
+
+	gfx_v13_0_set_kiq_pm4_funcs(adev);
+	gfx_v13_0_set_ring_funcs(adev);
+	gfx_v13_0_set_irq_funcs(adev);
+	gfx_v13_0_set_rlc_funcs(adev);
+	gfx_v13_0_set_mqd_funcs(adev);
+	gfx_v13_0_set_imu_funcs(adev);
+
+	gfx_v13_0_init_rlcg_reg_access_ctrl(adev);
+
+	return gfx_v13_0_init_microcode(adev);
+}
+
+static int gfx_v13_0_late_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_reg_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.priv_inst_irq, 0);
+	if (r)
+		return r;
+
+	r = amdgpu_irq_get(adev, &adev->gfx.bad_op_irq, 0);
+	if (r)
+		return r;
+
+	r = gfx_v13_0_set_userq_eop_interrupts(adev, true);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static bool gfx_v13_0_is_rlc_enabled(struct amdgpu_device *adev)
+{
+	uint32_t rlc_cntl;
+
+	/* if RLC is not enabled, do nothing */
+	rlc_cntl = RREG32_SOC15(GC, 0, regRLC_CNTL);
+	return (REG_GET_FIELD(rlc_cntl, RLC_CNTL, RLC_ENABLE_F32)) ? true : false;
+}
+
+static void gfx_v13_0_set_safe_mode(struct amdgpu_device *adev,
+				    int xcc_id)
+{
+	uint32_t data;
+	unsigned i;
+
+	data = RLC_SAFE_MODE__CMD_MASK;
+	data |= (1 << RLC_SAFE_MODE__MESSAGE__SHIFT);
+
+	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, data);
+
+	/* wait for RLC_SAFE_MODE */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (!REG_GET_FIELD(RREG32_SOC15(GC, 0, regRLC_SAFE_MODE),
+				   RLC_SAFE_MODE, CMD))
+			break;
+		udelay(1);
+		if (amdgpu_emu_mode == 1)
+			msleep(1);
+	}
+}
+
+static void gfx_v13_0_unset_safe_mode(struct amdgpu_device *adev,
+				      int xcc_id)
+{
+	WREG32_SOC15(GC, 0, regRLC_SAFE_MODE, RLC_SAFE_MODE__CMD_MASK);
+}
+
+static void gfx_v13_0_update_perf_clk(struct amdgpu_device *adev,
+				      bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_PERF_CLK))
+		return;
+
+	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+}
+
+static void gfx_v13_0_update_spm_vmid(struct amdgpu_device *adev,
+				      int xcc_id,
+				      unsigned vmid)
+{
+	u32 reg, data;
+
+	reg = SOC15_REG_OFFSET(GC, 0, regRLC_SPM_MC_CNTL);
+	if (amdgpu_sriov_is_pp_one_vf(adev))
+		data = RREG32_NO_KIQ(reg);
+	else
+		data = RREG32(reg);
+
+	data &= ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
+	data |= (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) << RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
+
+	if (amdgpu_sriov_is_pp_one_vf(adev))
+		WREG32_SOC15_NO_KIQ(GC, 0, regRLC_SPM_MC_CNTL, data);
+	else
+		WREG32_SOC15(GC, 0, regRLC_SPM_MC_CNTL, data);
+}
+
+static const struct amdgpu_rlc_funcs gfx_v13_0_rlc_funcs = {
+	.is_rlc_enabled = gfx_v13_0_is_rlc_enabled,
+	.set_safe_mode = gfx_v13_0_set_safe_mode,
+	.unset_safe_mode = gfx_v13_0_unset_safe_mode,
+	.init = gfx_v13_0_rlc_init,
+	.get_csb_size = gfx_v13_0_get_csb_size,
+	.get_csb_buffer = gfx_v13_0_get_csb_buffer,
+	.resume = gfx_v13_0_rlc_resume,
+	.stop = gfx_v13_0_rlc_stop,
+	.reset = gfx_v13_0_rlc_reset,
+	.start = gfx_v13_0_rlc_start,
+	.update_spm_vmid = gfx_v13_0_update_spm_vmid,
+};
+
+#if 0
+static void gfx_v13_cntl_power_gating(struct amdgpu_device *adev, bool enable)
+{
+	/* TODO */
+}
+
+static void gfx_v13_cntl_pg(struct amdgpu_device *adev, bool enable)
+{
+	/* TODO */
+}
+#endif
+
+static int gfx_v13_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					   enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool enable = (state == AMD_PG_STATE_GATE);
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		amdgpu_gfx_off_ctrl(adev, enable);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_update_sdma_clock_gating(struct amdgpu_device *adev,
+						 bool enable)
+{
+	u32 data;
+
+	if (adev->sdma.num_instances > 0) {
+		data = RREG32_SOC15(GC, 0, regSDMA0_SDMA_RLC_CGCG_CTRL);
+		data = REG_SET_FIELD(data, SDMA0_SDMA_RLC_CGCG_CTRL,
+				     CGCG_INT_ENABLE, enable);
+		WREG32_SOC15(GC, 0, regSDMA0_SDMA_RLC_CGCG_CTRL, data);
+	}
+
+	if (adev->sdma.num_instances > 1) {
+		data = RREG32_SOC15(GC, 0, regSDMA1_SDMA_RLC_CGCG_CTRL);
+		data = REG_SET_FIELD(data, SDMA1_SDMA_RLC_CGCG_CTRL,
+				     CGCG_INT_ENABLE, enable);
+		WREG32_SOC15(GC, 0, regSDMA1_SDMA_RLC_CGCG_CTRL, data);
+	}
+
+	if (adev->sdma.num_instances > 2) {
+		data = RREG32_SOC15(GC, 0, regSDMA2_SDMA_RLC_CGCG_CTRL);
+		data = REG_SET_FIELD(data, SDMA2_SDMA_RLC_CGCG_CTRL,
+				     CGCG_INT_ENABLE, enable);
+		WREG32_SOC15(GC, 0, regSDMA2_SDMA_RLC_CGCG_CTRL, data);
+	}
+
+	if (adev->sdma.num_instances > 3) {
+		data = RREG32_SOC15(GC, 0, regSDMA3_SDMA_RLC_CGCG_CTRL);
+		data = REG_SET_FIELD(data, SDMA3_SDMA_RLC_CGCG_CTRL,
+				     CGCG_INT_ENABLE, enable);
+		WREG32_SOC15(GC, 0, regSDMA3_SDMA_RLC_CGCG_CTRL, data);
+	}
+}
+
+static void gfx_v13_0_update_coarse_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags &
+	      (AMD_CG_SUPPORT_GFX_CGCG |
+	      AMD_CG_SUPPORT_GFX_CGLS |
+	      AMD_CG_SUPPORT_GFX_3D_CGCG |
+	      AMD_CG_SUPPORT_GFX_3D_CGLS)))
+		return;
+
+	if (enable) {
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+		/* unset CGCG override */
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGCG_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_CGLS_OVERRIDE_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG ||
+		    adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
+			data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_GFX3D_CG_OVERRIDE_MASK;
+
+		/* update CGCG override bits */
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+
+		/* enable cgcg FSM(0x0000363F) */
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL);
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG) {
+			data &= ~RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD_MASK;
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				 RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+		}
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS) {
+			data &= ~RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY_MASK;
+			data |= (0x000F << RLC_CGCG_CGLS_CTRL__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
+				 RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
+		}
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL, data);
+
+		/* Program RLC_CGCG_CGLS_CTRL_3D */
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D);
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG) {
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD_MASK;
+			data |= (0x36 << RLC_CGCG_CGLS_CTRL_3D__CGCG_GFX_IDLE_THRESHOLD__SHIFT) |
+				 RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		}
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS) {
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY_MASK;
+			data |= (0xf << RLC_CGCG_CGLS_CTRL_3D__CGLS_REP_COMPANSAT_DELAY__SHIFT) |
+				 RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
+		}
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D, data);
+
+		/* set IDLE_POLL_COUNT(0x00900100) */
+		def = data = RREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_CNTL);
+
+		data &= ~((uint32_t)CP_RB_WPTR_POLL_CNTL__POLL_FREQUENCY_MASK | (uint32_t)CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT_MASK);
+		data |= (0x0100 << CP_RB_WPTR_POLL_CNTL__POLL_FREQUENCY__SHIFT) |
+			(0x0090 << CP_RB_WPTR_POLL_CNTL__IDLE_POLL_COUNT__SHIFT);
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regCP_RB_WPTR_POLL_CNTL, data);
+
+		data = RREG32_SOC15(GC, 0, regCP_INT_CNTL);
+		data = REG_SET_FIELD(data, CP_INT_CNTL, CNTX_BUSY_INT_ENABLE, 1);
+		data = REG_SET_FIELD(data, CP_INT_CNTL, CNTX_EMPTY_INT_ENABLE, 1);
+		data = REG_SET_FIELD(data, CP_INT_CNTL, CMP_BUSY_INT_ENABLE, 1);
+		data = REG_SET_FIELD(data, CP_INT_CNTL, GFX_IDLE_INT_ENABLE, 1);
+		WREG32_SOC15(GC, 0, regCP_INT_CNTL, data);
+
+		gfx_v13_0_update_sdma_clock_gating(adev, true);
+	} else {
+		gfx_v13_0_update_sdma_clock_gating(adev, false);
+		/* Program RLC_CGCG_CGLS_CTRL */
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL);
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGCG)
+			data &= ~RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK;
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_CGLS)
+			data &= ~RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK;
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL, data);
+
+		/* Program RLC_CGCG_CGLS_CTRL_3D */
+		def = data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D);
+
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGCG)
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK;
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_3D_CGLS)
+			data &= ~RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK;
+
+		if (def != data)
+			WREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D, data);
+	}
+}
+
+static void gfx_v13_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+	uint32_t data, def;
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_GFX_MGCG | AMD_CG_SUPPORT_GFX_MGLS)))
+		return;
+
+	/* It is disabled by HW by default */
+	if (enable) {
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG) {
+			/* 1 - RLC_CGTT_MGCG_OVERRIDE */
+			def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+			data &= ~(RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+				  RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
+				  RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
+
+			if (def != data)
+				WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+		}
+	} else {
+		if (adev->cg_flags & AMD_CG_SUPPORT_GFX_MGCG) {
+			def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+			data |= (RLC_CGTT_MGCG_OVERRIDE__RLC_CGTT_SCLK_OVERRIDE_MASK |
+				 RLC_CGTT_MGCG_OVERRIDE__GRBM_CGTT_SCLK_OVERRIDE_MASK |
+				 RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK);
+
+			if (def != data)
+				WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+		}
+	}
+}
+
+static void gfx_v13_0_update_repeater_fgcg(struct amdgpu_device *adev,
+					   bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_REPEATER_FGCG))
+		return;
+
+	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~(RLC_CGTT_MGCG_OVERRIDE__GFXIP_REPEATER_FGCG_OVERRIDE_MASK |
+				  RLC_CGTT_MGCG_OVERRIDE__RLC_REPEATER_FGCG_OVERRIDE_MASK);
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_REPEATER_FGCG_OVERRIDE_MASK |
+				RLC_CGTT_MGCG_OVERRIDE__RLC_REPEATER_FGCG_OVERRIDE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+}
+
+static void gfx_v13_0_update_sram_fgcg(struct amdgpu_device *adev,
+				       bool enable)
+{
+	uint32_t def, data;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_GFX_FGCG))
+		return;
+
+	def = data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+
+	if (enable)
+		data &= ~RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+	else
+		data |= RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK;
+
+	if (def != data)
+		WREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE, data);
+}
+
+static int gfx_v13_0_update_gfx_clock_gating(struct amdgpu_device *adev,
+					    bool enable)
+{
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	gfx_v13_0_update_coarse_grain_clock_gating(adev, enable);
+
+	gfx_v13_0_update_medium_grain_clock_gating(adev, enable);
+
+	gfx_v13_0_update_repeater_fgcg(adev, enable);
+
+	gfx_v13_0_update_sram_fgcg(adev, enable);
+
+	gfx_v13_0_update_perf_clk(adev, enable);
+
+	if (adev->cg_flags &
+	    (AMD_CG_SUPPORT_GFX_MGCG |
+	     AMD_CG_SUPPORT_GFX_CGLS |
+	     AMD_CG_SUPPORT_GFX_CGCG |
+	     AMD_CG_SUPPORT_GFX_3D_CGCG |
+	     AMD_CG_SUPPORT_GFX_3D_CGLS))
+		gfx_v13_0_enable_gui_idle_interrupt(adev, enable);
+
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+
+	return 0;
+}
+
+static int gfx_v13_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					   enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(13, 0, 1):
+		gfx_v13_0_update_gfx_clock_gating(adev,
+						  state == AMD_CG_STATE_GATE);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_get_clockgating_state(struct amdgpu_ip_block *ip_block, u64 *flags)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int data;
+
+	/* AMD_CG_SUPPORT_GFX_MGCG */
+	data = RREG32_SOC15(GC, 0, regRLC_CGTT_MGCG_OVERRIDE);
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_MGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_MGCG;
+
+	/* AMD_CG_SUPPORT_REPEATER_FGCG */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_REPEATER_FGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_REPEATER_FGCG;
+
+	/* AMD_CG_SUPPORT_GFX_FGCG */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__GFXIP_FGCG_OVERRIDE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_FGCG;
+
+	/* AMD_CG_SUPPORT_GFX_PERF_CLK */
+	if (!(data & RLC_CGTT_MGCG_OVERRIDE__PERFMON_CLOCK_STATE_MASK))
+		*flags |= AMD_CG_SUPPORT_GFX_PERF_CLK;
+
+	/* AMD_CG_SUPPORT_GFX_CGCG */
+	data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL);
+	if (data & RLC_CGCG_CGLS_CTRL__CGCG_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_GFX_CGCG;
+
+	/* AMD_CG_SUPPORT_GFX_CGLS */
+	if (data & RLC_CGCG_CGLS_CTRL__CGLS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_GFX_CGLS;
+
+	/* AMD_CG_SUPPORT_GFX_3D_CGCG */
+	data = RREG32_SOC15(GC, 0, regRLC_CGCG_CGLS_CTRL_3D);
+	if (data & RLC_CGCG_CGLS_CTRL_3D__CGCG_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_GFX_3D_CGCG;
+
+	/* AMD_CG_SUPPORT_GFX_3D_CGLS */
+	if (data & RLC_CGCG_CGLS_CTRL_3D__CGLS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_GFX_3D_CGLS;
+}
+
+static u64 gfx_v13_0_ring_get_rptr_gfx(struct amdgpu_ring *ring)
+{
+	/* gfx13 is 32bit rptr*/
+	return *(uint32_t *)ring->rptr_cpu_addr;
+}
+
+static u64 gfx_v13_0_ring_get_wptr_gfx(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u64 wptr;
+
+	/* XXX check if swapping is necessary on BE */
+	if (ring->use_doorbell) {
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+	} else {
+		wptr = RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR);
+		wptr += (u64)RREG32_SOC15(GC, 0, regCP_GFX_HQD_WPTR_HI) << 32;
+	}
+
+	return wptr;
+}
+
+static void gfx_v13_0_ring_set_wptr_gfx(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		/* XXX check if swapping is necessary on BE */
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+			     ring->wptr);
+		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	} else {
+		WREG32_SOC15(GC, 0, regCP_RB0_WPTR,
+			     lower_32_bits(ring->wptr));
+		WREG32_SOC15(GC, 0, regCP_RB0_WPTR_HI,
+			     upper_32_bits(ring->wptr));
+	}
+}
+
+static u64 gfx_v13_0_ring_get_rptr_compute(struct amdgpu_ring *ring)
+{
+	/* gfx13 hardware is 32bit rptr */
+	return *(uint32_t *)ring->rptr_cpu_addr;
+}
+
+static u64 gfx_v13_0_ring_get_wptr_compute(struct amdgpu_ring *ring)
+{
+	u64 wptr;
+
+	/* XXX check if swapping is necessary on BE */
+	if (ring->use_doorbell)
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+	else
+		BUG();
+	return wptr;
+}
+
+static void gfx_v13_0_ring_set_wptr_compute(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* XXX check if swapping is necessary on BE */
+	if (ring->use_doorbell) {
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+			     ring->wptr);
+		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	} else {
+		BUG(); /* only DOORBELL method supported on gfx13 now */
+	}
+}
+
+static void gfx_v13_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	u32 ref_and_mask, reg_mem_engine;
+	if (!adev->gfx.funcs->get_hdp_flush_mask) {
+		dev_err(adev->dev, "%s: gfx hdp flush is not supported.\n", __func__);
+		return;
+	}
+
+	adev->gfx.funcs->get_hdp_flush_mask(ring, &ref_and_mask, &reg_mem_engine);
+
+	gfx_v13_0_wait_reg_mem(ring, reg_mem_engine, 0, 1,
+			       adev->nbio.funcs->get_hdp_flush_req_offset(adev),
+			       adev->nbio.funcs->get_hdp_flush_done_offset(adev),
+			       ref_and_mask, ref_and_mask, 0x20);
+}
+
+static void gfx_v13_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
+				       struct amdgpu_job *job,
+				       struct amdgpu_ib *ib,
+				       uint32_t flags)
+{
+	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
+	u32 header, control = 0;
+
+	BUG_ON(ib->flags & AMDGPU_IB_FLAG_CE);
+
+	header = PACKET3(PACKET3_INDIRECT_BUFFER, 2);
+
+	control |= ib->length_dw | (vmid << 24);
+
+	amdgpu_ring_write(ring, header);
+	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	amdgpu_ring_write(ring,
+#ifdef __BIG_ENDIAN
+		(2 << 0) |
+#endif
+		lower_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, control);
+}
+
+static void gfx_v13_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
+					   struct amdgpu_job *job,
+					   struct amdgpu_ib *ib,
+					   uint32_t flags)
+{
+	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
+	u32 control = INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 24);
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_INDIRECT_BUFFER, 2));
+	BUG_ON(ib->gpu_addr & 0x3); /* Dword align */
+	amdgpu_ring_write(ring,
+#ifdef __BIG_ENDIAN
+				(2 << 0) |
+#endif
+				lower_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, control);
+}
+
+static void gfx_v13_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+				     u64 seq, unsigned flags)
+{
+	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
+	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+
+	/* RELEASE_MEM - flush caches, send int */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RELEASE_MEM, 6));
+	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_GCR_SEQ |
+				 PACKET3_RELEASE_MEM_GCR_GL2_WB |
+				 PACKET3_RELEASE_MEM_CACHE_POLICY(3) |
+				 PACKET3_RELEASE_MEM_EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) |
+				 PACKET3_RELEASE_MEM_EVENT_INDEX(5)));
+	amdgpu_ring_write(ring, (PACKET3_RELEASE_MEM_DATA_SEL(write64bit ? 2 : 1) |
+				 PACKET3_RELEASE_MEM_INT_SEL(int_sel ? 2 : 0)));
+
+	/*
+	 * the address should be Qword aligned if 64bit write, Dword
+	 * aligned if only send 32bit data low (discard data high)
+	 */
+	if (write64bit)
+		BUG_ON(addr & 0x7);
+	else
+		BUG_ON(addr & 0x3);
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring, lower_32_bits(seq));
+	amdgpu_ring_write(ring, upper_32_bits(seq));
+	amdgpu_ring_write(ring, 0);
+}
+
+static void gfx_v13_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
+{
+	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
+	uint32_t seq = ring->fence_drv.sync_seq;
+	uint64_t addr = ring->fence_drv.gpu_addr;
+
+	gfx_v13_0_wait_reg_mem(ring, usepfp, 1, 0, lower_32_bits(addr),
+			       upper_32_bits(addr), seq, 0xffffffff, 4);
+}
+
+static void gfx_v13_0_ring_invalidate_tlbs(struct amdgpu_ring *ring,
+				   uint16_t pasid, uint32_t flush_type,
+				   bool all_hub, uint8_t dst_sel)
+{
+	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(ring,
+			  PACKET3_INVALIDATE_TLBS_DST_SEL(dst_sel) |
+			  PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			  PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			  PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+}
+
+static void gfx_v13_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
+					 unsigned vmid, uint64_t pd_addr)
+{
+	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+
+	/* compute doesn't have PFP */
+	if (ring->funcs->type == AMDGPU_RING_TYPE_GFX) {
+		/* sync PFP to ME, otherwise we might get invalid PFP reads */
+		amdgpu_ring_write(ring, PACKET3(PACKET3_PFP_SYNC_ME, 0));
+		amdgpu_ring_write(ring, 0x0);
+	}
+}
+
+static void gfx_v13_0_ring_emit_fence_kiq(struct amdgpu_ring *ring, u64 addr,
+					  u64 seq, unsigned int flags)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	/* we only allocate 32bit for each seq wb address */
+	BUG_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+
+	/* write fence seq to the "addr" */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
+	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
+				 WRITE_DATA_DST_SEL(5) | WR_CONFIRM));
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring, lower_32_bits(seq));
+
+	if (flags & AMDGPU_FENCE_FLAG_INT) {
+		/* set register to trigger INT */
+		amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
+		amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
+					 WRITE_DATA_DST_SEL(0) | WR_CONFIRM));
+		amdgpu_ring_write(ring, SOC15_REG_OFFSET(GC, 0, regCPC_INT_STATUS));
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 0x20000000); /* src_id is 178 */
+	}
+}
+
+static void gfx_v13_0_ring_emit_cntxcntl(struct amdgpu_ring *ring,
+					 uint32_t flags)
+{
+	uint32_t dw2 = 0;
+
+	dw2 |= 0x80000000; /* set load_enable otherwise this package is just NOPs */
+	if (flags & AMDGPU_HAVE_CTX_SWITCH) {
+		/* set load_global_config & load_global_uconfig */
+		dw2 |= 0x8001;
+		/* set load_cs_sh_regs */
+		dw2 |= 0x01000000;
+		/* set load_per_context_state & load_gfx_sh_regs for GFX */
+		dw2 |= 0x10002;
+	}
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_CONTEXT_CONTROL, 1));
+	amdgpu_ring_write(ring, dw2);
+	amdgpu_ring_write(ring, 0);
+}
+
+static unsigned gfx_v13_0_ring_emit_init_cond_exec(struct amdgpu_ring *ring,
+						   uint64_t addr)
+{
+	unsigned ret;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COND_EXEC, 3));
+	amdgpu_ring_write(ring, lower_32_bits(addr));
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	/* discard following DWs if *cond_exec_gpu_addr==0 */
+	amdgpu_ring_write(ring, 0);
+	ret = ring->wptr & ring->buf_mask;
+	/* patch dummy value later */
+	amdgpu_ring_write(ring, 0);
+
+	return ret;
+}
+
+static int gfx_v13_0_ring_preempt_ib(struct amdgpu_ring *ring)
+{
+	int i, r = 0;
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &kiq->ring;
+	unsigned long flags;
+
+	if (adev->enable_mes)
+		return -EINVAL;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
+		return -EINVAL;
+
+	spin_lock_irqsave(&kiq->ring_lock, flags);
+
+	if (amdgpu_ring_alloc(kiq_ring, kiq->pmf->unmap_queues_size)) {
+		spin_unlock_irqrestore(&kiq->ring_lock, flags);
+		return -ENOMEM;
+	}
+
+	/* assert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, false);
+
+	/* assert IB preemption, emit the trailing fence */
+	kiq->pmf->kiq_unmap_queues(kiq_ring, ring, PREEMPT_QUEUES_NO_UNMAP,
+				   ring->trail_fence_gpu_addr,
+				   ++ring->trail_seq);
+	amdgpu_ring_commit(kiq_ring);
+
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
+
+	/* poll the trailing fence */
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (ring->trail_seq ==
+		    le32_to_cpu(*(ring->trail_fence_cpu_addr)))
+			break;
+		udelay(1);
+		if (amdgpu_emu_mode == 1)
+			msleep(1);
+	}
+
+	if (i >= adev->usec_timeout) {
+		r = -EINVAL;
+		DRM_ERROR("ring %d failed to preempt ib\n", ring->idx);
+	}
+
+	/* deassert preemption condition */
+	amdgpu_ring_set_preempt_cond_exec(ring, true);
+	return r;
+}
+
+static void gfx_v13_0_ring_emit_frame_cntl(struct amdgpu_ring *ring,
+					   bool start,
+					   bool secure)
+{
+	uint32_t v = secure ? FRAME_TMZ : 0;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_FRAME_CONTROL, 0));
+	amdgpu_ring_write(ring, v | FRAME_CMD(start ? 0 : 1));
+}
+
+static void gfx_v13_0_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
+				     uint32_t reg_val_offs)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
+	amdgpu_ring_write(ring, 0 |	/* src: register*/
+				(5 << 8) |	/* dst: memory */
+				(1 << 20));	/* write confirm */
+	amdgpu_ring_write(ring, reg);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, lower_32_bits(adev->wb.gpu_addr +
+				reg_val_offs * 4));
+	amdgpu_ring_write(ring, upper_32_bits(adev->wb.gpu_addr +
+				reg_val_offs * 4));
+}
+
+static void gfx_v13_0_ring_emit_wreg(struct amdgpu_ring *ring,
+				     uint32_t reg,
+				     uint32_t val)
+{
+	uint32_t cmd = 0;
+
+	switch (ring->funcs->type) {
+	case AMDGPU_RING_TYPE_GFX:
+		cmd = WRITE_DATA_ENGINE_SEL(1) | WR_CONFIRM;
+		break;
+	case AMDGPU_RING_TYPE_KIQ:
+		cmd = (1 << 16); /* no inc addr */
+		break;
+	default:
+		cmd = WR_CONFIRM;
+		break;
+	}
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
+	amdgpu_ring_write(ring, cmd);
+	amdgpu_ring_write(ring, reg);
+	amdgpu_ring_write(ring, 0);
+	amdgpu_ring_write(ring, val);
+}
+
+static void gfx_v13_0_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+					uint32_t val, uint32_t mask)
+{
+	gfx_v13_0_wait_reg_mem(ring, 0, 0, 0, reg, 0, val, mask, 0x20);
+}
+
+static void gfx_v13_0_ring_emit_reg_write_reg_wait(struct amdgpu_ring *ring,
+						   uint32_t reg0, uint32_t reg1,
+						   uint32_t ref, uint32_t mask)
+{
+	int usepfp = (ring->funcs->type == AMDGPU_RING_TYPE_GFX);
+
+	gfx_v13_0_wait_reg_mem(ring, usepfp, 0, 1, reg0, reg1,
+			       ref, mask, 0x20);
+}
+
+static void
+gfx_v13_0_set_gfx_eop_interrupt_state(struct amdgpu_device *adev,
+				      uint32_t me, uint32_t pipe,
+				      enum amdgpu_interrupt_state state)
+{
+	uint32_t cp_int_cntl, cp_int_cntl_reg;
+
+	if (!me) {
+		switch (pipe) {
+		case 0:
+			cp_int_cntl_reg = SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING0);
+			break;
+		case 1:
+			cp_int_cntl_reg = SOC15_REG_OFFSET(GC, 0, regCP_INT_CNTL_RING1);
+			break;
+		default:
+			dev_err(adev->dev, "invalid me pipe %d\n", pipe);
+			return;
+		}
+	} else {
+		dev_err(adev->dev, "invalid me %d\n", me);
+		return;
+	}
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+					    TIME_STAMP_INT_ENABLE, 0);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+					    GENERIC0_INT_ENABLE, 0);
+		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+					    TIME_STAMP_INT_ENABLE, 1);
+		cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+					    GENERIC0_INT_ENABLE, 1);
+		WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+		break;
+	default:
+		break;
+	}
+}
+
+static void gfx_v13_0_set_compute_eop_interrupt_state(struct amdgpu_device *adev,
+						     int me, int pipe,
+						     enum amdgpu_interrupt_state state)
+{
+	u32 mec_int_cntl, mec_int_cntl_reg;
+
+	/*
+	 * amdgpu controls only the first MEC. That's why this function only
+	 * handles the setting of interrupts for this specific MEC. All other
+	 * pipes' interrupts are set by amdkfd.
+	 */
+
+	if (me == 1) {
+		switch (pipe) {
+		case 0:
+			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE0_INT_CNTL);
+			break;
+		case 1:
+			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE1_INT_CNTL);
+			break;
+		case 2:
+			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE2_INT_CNTL);
+			break;
+		case 3:
+			mec_int_cntl_reg = SOC15_REG_OFFSET(GC, 0, regCP_ME1_PIPE3_INT_CNTL);
+			break;
+		default:
+			dev_err(adev->dev, "invalid mec pipe %d\n", pipe);
+			return;
+		}
+	} else {
+		dev_err(adev->dev, "invalid mec %d\n", me);
+		return;
+	}
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
+		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+					     TIME_STAMP_INT_ENABLE, 0);
+		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+					     GENERIC0_INT_ENABLE, 0);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
+		break;
+	case AMDGPU_IRQ_STATE_ENABLE:
+		mec_int_cntl = RREG32_SOC15_IP(GC, mec_int_cntl_reg);
+		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+					     TIME_STAMP_INT_ENABLE, 1);
+		mec_int_cntl = REG_SET_FIELD(mec_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+					     GENERIC0_INT_ENABLE, 1);
+		WREG32_SOC15_IP(GC, mec_int_cntl_reg, mec_int_cntl);
+		break;
+	default:
+		break;
+	}
+}
+
+static int gfx_v13_0_set_eop_interrupt_state(struct amdgpu_device *adev,
+					    struct amdgpu_irq_src *src,
+					    unsigned type,
+					    enum amdgpu_interrupt_state state)
+{
+	switch (type) {
+	case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
+		gfx_v13_0_set_gfx_eop_interrupt_state(adev, 0, 0, state);
+		break;
+	case AMDGPU_CP_IRQ_GFX_ME0_PIPE1_EOP:
+		gfx_v13_0_set_gfx_eop_interrupt_state(adev, 0, 1, state);
+		break;
+	case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP:
+		gfx_v13_0_set_compute_eop_interrupt_state(adev, 1, 0, state);
+		break;
+	case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE1_EOP:
+		gfx_v13_0_set_compute_eop_interrupt_state(adev, 1, 1, state);
+		break;
+	case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE2_EOP:
+		gfx_v13_0_set_compute_eop_interrupt_state(adev, 1, 2, state);
+		break;
+	case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE3_EOP:
+		gfx_v13_0_set_compute_eop_interrupt_state(adev, 1, 3, state);
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int gfx_v13_0_eop_irq(struct amdgpu_device *adev,
+			     struct amdgpu_irq_src *source,
+			     struct amdgpu_iv_entry *entry)
+{
+	u32 doorbell_offset = entry->src_data[0];
+
+	DRM_DEBUG("IH: CP EOP\n");
+
+	if (!adev->gfx.disable_kq) {
+		u8 me_id = (entry->ring_id & 0x0c) >> 2;
+		u8 pipe_id = (entry->ring_id & 0x03) >> 0;
+		u8 queue_id = (entry->ring_id & 0x70) >> 4;
+		struct amdgpu_ring *ring;
+		int i;
+
+		switch (me_id) {
+		case 0:
+			/*
+			 * MES splits gfx HQDs per (me,pipe): KGQ owns queue=0,
+			 * userq gfx owns queue>=1 (see amdgpu_mes_get_hqd_mask).
+			 * Require a strict (me,pipe,queue) match so userq gfx
+			 * EOPs fall through to amdgpu_userq_process_fence_irq().
+			 */
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if ((ring->me == me_id) &&
+				    (ring->pipe == pipe_id) &&
+				    (ring->queue == queue_id)) {
+					amdgpu_fence_process(ring);
+					return 0;
+				}
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				/* Per-queue interrupt is supported for MEC starting from VI.
+				 * The interrupt can only be enabled/disabled per pipe instead
+				 * of per queue.
+				 */
+				if ((ring->me == me_id) &&
+				    (ring->pipe == pipe_id) &&
+				    (ring->queue == queue_id)) {
+					amdgpu_fence_process(ring);
+					return 0;
+				}
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (adev->enable_mes && doorbell_offset)
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
+
+	return 0;
+}
+
+static int gfx_v13_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
+					      struct amdgpu_irq_src *source,
+					      unsigned int type,
+					      enum amdgpu_interrupt_state state)
+{
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+	case AMDGPU_IRQ_STATE_ENABLE:
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v13_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v13_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    PRIV_REG_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int gfx_v13_0_set_bad_op_fault_state(struct amdgpu_device *adev,
+					    struct amdgpu_irq_src *source,
+					    unsigned type,
+					    enum amdgpu_interrupt_state state)
+{
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+	case AMDGPU_IRQ_STATE_ENABLE:
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v13_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    OPCODE_ERROR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+				/* MECs start at 1 */
+				cp_int_cntl_reg = gfx_v13_0_get_cpc_int_cntl(adev, i + 1, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_ME1_PIPE0_INT_CNTL,
+								    OPCODE_ERROR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		break;
+	default:
+		break;
+	}
+	return 0;
+}
+
+static int gfx_v13_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
+					       struct amdgpu_irq_src *source,
+					       unsigned int type,
+					       enum amdgpu_interrupt_state state)
+{
+	u32 cp_int_cntl_reg, cp_int_cntl;
+	int i, j;
+
+	switch (state) {
+	case AMDGPU_IRQ_STATE_DISABLE:
+	case AMDGPU_IRQ_STATE_ENABLE:
+		for (i = 0; i < adev->gfx.me.num_me; i++) {
+			for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+				cp_int_cntl_reg = gfx_v13_0_get_cpg_int_cntl(adev, i, j);
+
+				if (cp_int_cntl_reg) {
+					cp_int_cntl = RREG32_SOC15_IP(GC, cp_int_cntl_reg);
+					cp_int_cntl = REG_SET_FIELD(cp_int_cntl, CP_INT_CNTL_RING0,
+								    PRIV_INSTR_INT_ENABLE,
+								    state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+					WREG32_SOC15_IP(GC, cp_int_cntl_reg, cp_int_cntl);
+				}
+			}
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void gfx_v13_0_handle_priv_fault(struct amdgpu_device *adev,
+					struct amdgpu_iv_entry *entry)
+{
+	u8 me_id, pipe_id, queue_id;
+	struct amdgpu_ring *ring;
+	int i;
+
+	me_id = (entry->ring_id & 0x0c) >> 2;
+	pipe_id = (entry->ring_id & 0x03) >> 0;
+	queue_id = (entry->ring_id & 0x70) >> 4;
+
+	if (!adev->gfx.disable_kq) {
+		switch (me_id) {
+		case 0:
+			for (i = 0; i < adev->gfx.num_gfx_rings; i++) {
+				ring = &adev->gfx.gfx_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		case 1:
+		case 2:
+			for (i = 0; i < adev->gfx.num_compute_rings; i++) {
+				ring = &adev->gfx.compute_ring[i];
+				if (ring->me == me_id && ring->pipe == pipe_id &&
+				    ring->queue == queue_id)
+					drm_sched_fault(&ring->sched);
+			}
+			break;
+		default:
+			BUG();
+			break;
+		}
+	}
+}
+
+static int gfx_v13_0_priv_reg_irq(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  struct amdgpu_iv_entry *entry)
+{
+	DRM_ERROR("Illegal register access in command stream\n");
+	gfx_v13_0_handle_priv_fault(adev, entry);
+	return 0;
+}
+
+static int gfx_v13_0_bad_op_irq(struct amdgpu_device *adev,
+				struct amdgpu_irq_src *source,
+				struct amdgpu_iv_entry *entry)
+{
+	DRM_ERROR("Illegal opcode in command stream \n");
+	gfx_v13_0_handle_priv_fault(adev, entry);
+	return 0;
+}
+
+static int gfx_v13_0_priv_inst_irq(struct amdgpu_device *adev,
+				   struct amdgpu_irq_src *source,
+				   struct amdgpu_iv_entry *entry)
+{
+	DRM_ERROR("Illegal instruction in command stream\n");
+	gfx_v13_0_handle_priv_fault(adev, entry);
+	return 0;
+}
+
+static void gfx_v13_0_emit_mem_sync(struct amdgpu_ring *ring)
+{
+	const unsigned int gcr_cntl =
+			PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(1) |
+			PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(1) |
+			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_INV(1) |
+			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_WB(1) |
+			PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_INV(1) |
+			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(1) |
+			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(1) |
+			PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(1);
+
+	/* ACQUIRE_MEM - make one or more surfaces valid for use by the subsequent operations */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_ACQUIRE_MEM, 6));
+	amdgpu_ring_write(ring, 0); /* CP_COHER_CNTL */
+	amdgpu_ring_write(ring, 0xffffffff);  /* CP_COHER_SIZE */
+	amdgpu_ring_write(ring, 0xffffff);  /* CP_COHER_SIZE_HI */
+	amdgpu_ring_write(ring, 0); /* CP_COHER_BASE */
+	amdgpu_ring_write(ring, 0);  /* CP_COHER_BASE_HI */
+	amdgpu_ring_write(ring, 0x0000000A); /* POLL_INTERVAL */
+	amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
+}
+
+static void gfx_v13_ring_insert_nop(struct amdgpu_ring *ring, uint32_t num_nop)
+{
+	/* Header itself is a NOP packet */
+	if (num_nop == 1) {
+		amdgpu_ring_write(ring, ring->funcs->nop);
+		return;
+	}
+
+	/* Max HW optimization till 0x3ffe, followed by remaining one NOP at a time*/
+	amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3ffe)));
+
+	/* Header is at index 0, followed by num_nops - 1 NOP packet's */
+	amdgpu_ring_insert_nop(ring, num_nop - 1);
+}
+
+static void gfx_v13_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
+{
+	/* Emit the cleaner shader */
+	amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
+	amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zero */
+}
+
+static void gfx_v13_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	uint32_t i, j, k, reg, index = 0;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_13_0);
+
+	if (!adev->gfx.ip_dump_core)
+		return;
+
+	for (i = 0; i < reg_count; i++)
+		drm_printf(p, "%-50s \t 0x%08x\n",
+			   gc_reg_list_13_0[i].reg_name,
+			   adev->gfx.ip_dump_core[i]);
+
+	/* print compute queue registers for all instances */
+	if (!adev->gfx.ip_dump_compute_queues)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_13);
+	drm_printf(p, "\nnum_mec: %d num_pipe: %d num_queue: %d\n",
+		   adev->gfx.mec.num_mec,
+		   adev->gfx.mec.num_pipe_per_mec,
+		   adev->gfx.mec.num_queue_per_pipe);
+
+	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+				drm_printf(p, "\nmec %d, pipe %d, queue %d\n", i, j, k);
+				for (reg = 0; reg < reg_count; reg++) {
+					drm_printf(p, "%-50s \t 0x%08x\n",
+						   gc_cp_reg_list_13[reg].reg_name,
+						   adev->gfx.ip_dump_compute_queues[index + reg]);
+				}
+				index += reg_count;
+			}
+		}
+	}
+
+	/* print gfx queue registers for all instances */
+	if (!adev->gfx.ip_dump_gfx_queues)
+		return;
+
+	index = 0;
+	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_13);
+	drm_printf(p, "\nnum_me: %d num_pipe: %d num_queue: %d\n",
+		   adev->gfx.me.num_me,
+		   adev->gfx.me.num_pipe_per_me,
+		   adev->gfx.me.num_queue_per_pipe);
+
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			for (k = 0; k < adev->gfx.me.num_queue_per_pipe; k++) {
+				drm_printf(p, "\nme %d, pipe %d, queue %d\n", i, j, k);
+				for (reg = 0; reg < reg_count; reg++) {
+					drm_printf(p, "%-50s \t 0x%08x\n",
+						   gc_gfx_queue_reg_list_13[reg].reg_name,
+						   adev->gfx.ip_dump_gfx_queues[index + reg]);
+				}
+				index += reg_count;
+			}
+		}
+	}
+}
+
+static void gfx_v13_ip_dump(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	uint32_t i, j, k, reg, index = 0;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_13_0);
+
+	if (!adev->gfx.ip_dump_core)
+		return;
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (i = 0; i < reg_count; i++)
+		adev->gfx.ip_dump_core[i] = RREG32(SOC15_REG_ENTRY_OFFSET(gc_reg_list_13_0[i]));
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	/* dump compute queue registers for all instances */
+	if (!adev->gfx.ip_dump_compute_queues)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_13);
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.mec.num_mec; i++) {
+		for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
+			for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
+				/* ME0 is for GFX so start from 1 for CP */
+				soc_v2_0_grbm_select(adev, adev->gfx.me.num_me + i, j, k, 0);
+				for (reg = 0; reg < reg_count; reg++) {
+					adev->gfx.ip_dump_compute_queues[index + reg] =
+						RREG32(SOC15_REG_ENTRY_OFFSET(
+							gc_cp_reg_list_13[reg]));
+				}
+				index += reg_count;
+			}
+		}
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	/* dump gfx queue registers for all instances */
+	if (!adev->gfx.ip_dump_gfx_queues)
+		return;
+
+	index = 0;
+	reg_count = ARRAY_SIZE(gc_gfx_queue_reg_list_13);
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&adev->srbm_mutex);
+	for (i = 0; i < adev->gfx.me.num_me; i++) {
+		for (j = 0; j < adev->gfx.me.num_pipe_per_me; j++) {
+			for (k = 0; k < adev->gfx.me.num_queue_per_pipe; k++) {
+				soc_v2_0_grbm_select(adev, i, j, k, 0);
+
+				for (reg = 0; reg < reg_count; reg++) {
+					adev->gfx.ip_dump_gfx_queues[index + reg] =
+						RREG32(SOC15_REG_ENTRY_OFFSET(
+							gc_gfx_queue_reg_list_13[reg]));
+				}
+				index += reg_count;
+			}
+		}
+	}
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
+static bool gfx_v13_pipe_reset_support(struct amdgpu_device *adev)
+{
+	/* Disable the pipe reset until the CPFW fully support it.*/
+	dev_warn_once(adev->dev, "The CPFW hasn't support pipe reset yet.\n");
+	return false;
+}
+
+static int gfx_v13_reset_gfx_pipe(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r;
+
+	if (!gfx_v13_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	gfx_v13_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc_v2_0_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+	switch (ring->pipe) {
+	case 0:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_RS64_CNTL,
+						PFP_PIPE0_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_RS64_CNTL,
+						ME_PIPE0_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_RS64_CNTL,
+						PFP_PIPE0_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_RS64_CNTL,
+						ME_PIPE0_RESET, 0);
+
+		break;
+	case 1:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_RS64_CNTL,
+						PFP_PIPE1_RESET, 1);
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_ME_RS64_CNTL,
+						ME_PIPE1_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_RS64_CNTL,
+						PFP_PIPE1_RESET, 0);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_ME_RS64_CNTL,
+						ME_PIPE1_RESET, 0);
+		break;
+	default:
+		break;
+	}
+
+	WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, reset_pipe);
+	WREG32_SOC15(GC, 0, regCP_ME_RS64_CNTL, clean_pipe);
+
+
+	r = (RREG32(SOC15_REG_OFFSET(GC, 0, regCP_GFX_RS64_INSTR_PNTR1)) << 2) -
+					RS64_FW_UC_START_ADDR_LO;
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v13_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev, "The ring %s pipe reset: %s\n", ring->name,
+			r == 0 ? "successfully" : "failed");
+	/* Sometimes the ME start pc counter can't cache correctly, so the
+	 * PC check only as a reference and pipe reset result rely on the
+	 * later ring test.
+	 */
+	return 0;
+}
+
+static int gfx_v13_0_reset_kgq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+	bool use_mmio = false;
+	int r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmio, 0);
+	if (r) {
+		dev_warn(adev->dev, "reset via MES failed and try pipe reset %d\n", r);
+		r = gfx_v13_reset_gfx_pipe(ring);
+		if (r)
+			return r;
+	}
+
+	if (use_mmio) {
+		r = gfx_v13_0_kgq_init_queue(ring, true);
+		if (r) {
+			dev_err(adev->dev, "failed to init kgq\n");
+			return r;
+		}
+
+		r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		if (r) {
+			dev_err(adev->dev, "failed to remap kgq\n");
+			return r;
+		}
+	}
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
+static int gfx_v13_0_reset_compute_pipe(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t reset_pipe = 0, clean_pipe = 0;
+	int r = 0;
+
+	if (!gfx_v13_pipe_reset_support(adev))
+		return -EOPNOTSUPP;
+
+	gfx_v13_0_set_safe_mode(adev, 0);
+	mutex_lock(&adev->srbm_mutex);
+	soc_v2_0_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+
+	reset_pipe = RREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL);
+	clean_pipe = reset_pipe;
+
+	switch (ring->pipe) {
+	case 0:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						MEC_PIPE0_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						MEC_PIPE0_RESET, 0);
+		break;
+	case 1:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						MEC_PIPE1_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						MEC_PIPE1_RESET, 0);
+		break;
+	case 2:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						MEC_PIPE2_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						MEC_PIPE2_RESET, 0);
+		break;
+	case 3:
+		reset_pipe = REG_SET_FIELD(reset_pipe, CP_MEC_RS64_CNTL,
+						MEC_PIPE3_RESET, 1);
+		clean_pipe = REG_SET_FIELD(clean_pipe, CP_MEC_RS64_CNTL,
+						MEC_PIPE3_RESET, 0);
+		break;
+	default:
+		break;
+	}
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, reset_pipe);
+	WREG32_SOC15(GC, 0, regCP_MEC_RS64_CNTL, clean_pipe);
+	r = (RREG32_SOC15(GC, 0, regCP_MEC_RS64_INSTR_PNTR) << 2) - RS64_FW_UC_START_ADDR_LO;
+
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+	gfx_v13_0_unset_safe_mode(adev, 0);
+
+	dev_info(adev->dev, "The ring %s pipe resets: %s\n", ring->name,
+			r == 0 ? "successfully" : "failed");
+	/* Need the ring test to verify the pipe reset result.*/
+	return 0;
+}
+
+static int gfx_v13_0_reset_kcq(struct amdgpu_ring *ring,
+			       unsigned int vmid,
+			       struct amdgpu_fence *timedout_fence)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
+
+	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, true, 0);
+	if (r) {
+		dev_warn(adev->dev, "fail(%d) to reset kcq  and try pipe reset\n", r);
+		r = gfx_v13_0_reset_compute_pipe(ring);
+		if (r)
+			return r;
+	}
+
+	r = gfx_v13_0_kcq_init_queue(ring, true);
+	if (r) {
+		dev_err(adev->dev, "failed to init kcq\n");
+		return r;
+	}
+	r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+	if (r) {
+		dev_err(adev->dev, "failed to remap kcq\n");
+		return r;
+	}
+
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+}
+
+static void gfx_v13_0_ring_begin_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_profile_ring_begin_use(ring);
+
+	amdgpu_gfx_enforce_isolation_ring_begin_use(ring);
+}
+
+static void gfx_v13_0_ring_end_use(struct amdgpu_ring *ring)
+{
+	amdgpu_gfx_profile_ring_end_use(ring);
+
+	amdgpu_gfx_enforce_isolation_ring_end_use(ring);
+}
+
+static const struct amd_ip_funcs gfx_v13_0_ip_funcs = {
+	.name = "gfx_v13_0",
+	.early_init = gfx_v13_0_early_init,
+	.late_init = gfx_v13_0_late_init,
+	.sw_init = gfx_v13_0_sw_init,
+	.sw_fini = gfx_v13_0_sw_fini,
+	.hw_init = gfx_v13_0_hw_init,
+	.hw_fini = gfx_v13_0_hw_fini,
+	.suspend = gfx_v13_0_suspend,
+	.resume = gfx_v13_0_resume,
+	.wait_for_idle = gfx_v13_0_wait_for_idle,
+	.set_clockgating_state = gfx_v13_0_set_clockgating_state,
+	.set_powergating_state = gfx_v13_0_set_powergating_state,
+	.get_clockgating_state = gfx_v13_0_get_clockgating_state,
+	.dump_ip_state = gfx_v13_ip_dump,
+	.print_ip_state = gfx_v13_ip_print,
+};
+
+static const struct amdgpu_ring_funcs gfx_v13_0_ring_funcs_gfx = {
+	.type = AMDGPU_RING_TYPE_GFX,
+	.align_mask = 0xff,
+	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
+	.support_64bit_ptrs = true,
+	.secure_submission_supported = true,
+	.get_rptr = gfx_v13_0_ring_get_rptr_gfx,
+	.get_wptr = gfx_v13_0_ring_get_wptr_gfx,
+	.set_wptr = gfx_v13_0_ring_set_wptr_gfx,
+	.emit_frame_size = /* totally 242 maximum if 16 IBs */
+		5 + /* COND_EXEC */
+		7 + /* PIPELINE_SYNC */
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
+		2 + /* VM_FLUSH */
+		8 + /* FENCE for VM_FLUSH */
+		5 + /* COND_EXEC */
+		7 + /* HDP_flush */
+		4 + /* VGT_flush */
+		31 + /*	DE_META */
+		3 + /* CNTX_CTRL */
+		5 + /* HDP_INVL */
+		8 + 8 + /* FENCE x2 */
+		8 + /* gfx_v13_0_emit_mem_sync */
+		2, /* gfx_v13_0_ring_emit_cleaner_shader */
+	.emit_ib_size =	4, /* gfx_v13_0_ring_emit_ib_gfx */
+	.emit_ib = gfx_v13_0_ring_emit_ib_gfx,
+	.emit_fence = gfx_v13_0_ring_emit_fence,
+	.emit_pipeline_sync = gfx_v13_0_ring_emit_pipeline_sync,
+	.emit_vm_flush = gfx_v13_0_ring_emit_vm_flush,
+	.emit_hdp_flush = gfx_v13_0_ring_emit_hdp_flush,
+	.test_ring = gfx_v13_0_ring_test_ring,
+	.test_ib = gfx_v13_0_ring_test_ib,
+	.insert_nop = gfx_v13_ring_insert_nop,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.emit_cntxcntl = gfx_v13_0_ring_emit_cntxcntl,
+	.init_cond_exec = gfx_v13_0_ring_emit_init_cond_exec,
+	.preempt_ib = gfx_v13_0_ring_preempt_ib,
+	.emit_frame_cntl = gfx_v13_0_ring_emit_frame_cntl,
+	.emit_wreg = gfx_v13_0_ring_emit_wreg,
+	.emit_reg_wait = gfx_v13_0_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = gfx_v13_0_ring_emit_reg_write_reg_wait,
+	.emit_mem_sync = gfx_v13_0_emit_mem_sync,
+	.reset = gfx_v13_0_reset_kgq,
+	.emit_cleaner_shader = gfx_v13_0_ring_emit_cleaner_shader,
+	.begin_use = gfx_v13_0_ring_begin_use,
+	.end_use = gfx_v13_0_ring_end_use,
+};
+
+static const struct amdgpu_ring_funcs gfx_v13_0_ring_funcs_compute = {
+	.type = AMDGPU_RING_TYPE_COMPUTE,
+	.align_mask = 0xff,
+	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
+	.support_64bit_ptrs = true,
+	.get_rptr = gfx_v13_0_ring_get_rptr_compute,
+	.get_wptr = gfx_v13_0_ring_get_wptr_compute,
+	.set_wptr = gfx_v13_0_ring_set_wptr_compute,
+	.emit_frame_size =
+		7 + /* gfx_v13_0_ring_emit_hdp_flush */
+		5 + /* hdp invalidate */
+		7 + /* gfx_v13_0_ring_emit_pipeline_sync */
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
+		2 + /* gfx_v13_0_ring_emit_vm_flush */
+		8 + 8 + 8 + /* gfx_v13_0_ring_emit_fence x3 for user fence, vm fence */
+		8 + /* gfx_v13_0_emit_mem_sync */
+		2, /* gfx_v13_0_ring_emit_cleaner_shader */
+	.emit_ib_size =	7, /* gfx_v13_0_ring_emit_ib_compute */
+	.emit_ib = gfx_v13_0_ring_emit_ib_compute,
+	.emit_fence = gfx_v13_0_ring_emit_fence,
+	.emit_pipeline_sync = gfx_v13_0_ring_emit_pipeline_sync,
+	.emit_vm_flush = gfx_v13_0_ring_emit_vm_flush,
+	.emit_hdp_flush = gfx_v13_0_ring_emit_hdp_flush,
+	.test_ring = gfx_v13_0_ring_test_ring,
+	.test_ib = gfx_v13_0_ring_test_ib,
+	.insert_nop = gfx_v13_ring_insert_nop,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.emit_wreg = gfx_v13_0_ring_emit_wreg,
+	.emit_reg_wait = gfx_v13_0_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = gfx_v13_0_ring_emit_reg_write_reg_wait,
+	.emit_mem_sync = gfx_v13_0_emit_mem_sync,
+	.reset = gfx_v13_0_reset_kcq,
+	.emit_cleaner_shader = gfx_v13_0_ring_emit_cleaner_shader,
+	.begin_use = gfx_v13_0_ring_begin_use,
+	.end_use = gfx_v13_0_ring_end_use,
+};
+
+static const struct amdgpu_ring_funcs gfx_v13_0_ring_funcs_kiq = {
+	.type = AMDGPU_RING_TYPE_KIQ,
+	.align_mask = 0xff,
+	.nop = PACKET3(PACKET3_NOP, 0x3FFF),
+	.support_64bit_ptrs = true,
+	.get_rptr = gfx_v13_0_ring_get_rptr_compute,
+	.get_wptr = gfx_v13_0_ring_get_wptr_compute,
+	.set_wptr = gfx_v13_0_ring_set_wptr_compute,
+	.emit_frame_size =
+		7 + /* gfx_v13_0_ring_emit_hdp_flush */
+		5 + /*hdp invalidate */
+		7 + /* gfx_v13_0_ring_emit_pipeline_sync */
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 5 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 7 +
+		2 + /* gfx_v13_0_ring_emit_vm_flush */
+		8 + 8 + 8, /* gfx_v13_0_ring_emit_fence_kiq x3 for user fence, vm fence */
+	.emit_ib_size =	7, /* gfx_v13_0_ring_emit_ib_compute */
+	.emit_ib = gfx_v13_0_ring_emit_ib_compute,
+	.emit_fence = gfx_v13_0_ring_emit_fence_kiq,
+	.emit_hdp_flush = gfx_v13_0_ring_emit_hdp_flush,
+	.test_ring = gfx_v13_0_ring_test_ring,
+	.test_ib = gfx_v13_0_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.emit_rreg = gfx_v13_0_ring_emit_rreg,
+	.emit_wreg = gfx_v13_0_ring_emit_wreg,
+	.emit_reg_wait = gfx_v13_0_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = gfx_v13_0_ring_emit_reg_write_reg_wait,
+};
+
+static void gfx_v13_0_set_ring_funcs(struct amdgpu_device *adev)
+{
+	int i;
+
+	adev->gfx.kiq[0].ring.funcs = &gfx_v13_0_ring_funcs_kiq;
+
+	for (i = 0; i < adev->gfx.num_gfx_rings; i++)
+		adev->gfx.gfx_ring[i].funcs = &gfx_v13_0_ring_funcs_gfx;
+
+	for (i = 0; i < adev->gfx.num_compute_rings; i++)
+		adev->gfx.compute_ring[i].funcs = &gfx_v13_0_ring_funcs_compute;
+}
+
+static const struct amdgpu_irq_src_funcs gfx_v13_0_eop_irq_funcs = {
+	.set = gfx_v13_0_set_eop_interrupt_state,
+	.process = gfx_v13_0_eop_irq,
+};
+
+static const struct amdgpu_irq_src_funcs gfx_v13_0_priv_reg_irq_funcs = {
+	.set = gfx_v13_0_set_priv_reg_fault_state,
+	.process = gfx_v13_0_priv_reg_irq,
+};
+
+static const struct amdgpu_irq_src_funcs gfx_v13_0_bad_op_irq_funcs = {
+	.set = gfx_v13_0_set_bad_op_fault_state,
+	.process = gfx_v13_0_bad_op_irq,
+};
+
+static const struct amdgpu_irq_src_funcs gfx_v13_0_priv_inst_irq_funcs = {
+	.set = gfx_v13_0_set_priv_inst_fault_state,
+	.process = gfx_v13_0_priv_inst_irq,
+};
+
+static void gfx_v13_0_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
+	adev->gfx.eop_irq.funcs = &gfx_v13_0_eop_irq_funcs;
+
+	adev->gfx.priv_reg_irq.num_types = 1;
+	adev->gfx.priv_reg_irq.funcs = &gfx_v13_0_priv_reg_irq_funcs;
+
+	adev->gfx.bad_op_irq.num_types = 1;
+	adev->gfx.bad_op_irq.funcs = &gfx_v13_0_bad_op_irq_funcs;
+
+	adev->gfx.priv_inst_irq.num_types = 1;
+	adev->gfx.priv_inst_irq.funcs = &gfx_v13_0_priv_inst_irq_funcs;
+}
+
+static void gfx_v13_0_set_imu_funcs(struct amdgpu_device *adev)
+{
+	if (adev->flags & AMD_IS_APU)
+		adev->gfx.imu.mode = MISSION_MODE;
+	else
+		adev->gfx.imu.mode = DEBUG_MODE;
+
+	adev->gfx.imu.funcs = &gfx_v13_0_imu_funcs;
+}
+
+static void gfx_v13_0_set_rlc_funcs(struct amdgpu_device *adev)
+{
+	adev->gfx.rlc.funcs = &gfx_v13_0_rlc_funcs;
+}
+
+static void gfx_v13_0_set_mqd_funcs(struct amdgpu_device *adev)
+{
+	/* set gfx eng mqd */
+	adev->mqds[AMDGPU_HW_IP_GFX].mqd_size =
+		sizeof(struct v13_gfx_mqd);
+	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
+		gfx_v13_0_gfx_mqd_init;
+	/* set compute eng mqd */
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
+		sizeof(struct v13_compute_mqd);
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
+		gfx_v13_0_compute_mqd_init;
+}
+
+static void gfx_v13_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
+							  u32 bitmap)
+{
+	u32 data;
+
+	if (!bitmap)
+		return;
+
+	data = bitmap << GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
+	data &= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
+
+	WREG32_SOC15(GC, 0, regGC_USER_SHADER_ARRAY_CONFIG, data);
+}
+
+static u32 gfx_v13_0_get_wgp_active_bitmap_per_sh(struct amdgpu_device *adev)
+{
+	u32 data, wgp_bitmask;
+	data = RREG32_SOC15(GC, 0, regCC_GC_SHADER_ARRAY_CONFIG);
+	data |= RREG32_SOC15(GC, 0, regGC_USER_SHADER_ARRAY_CONFIG);
+
+	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS_MASK;
+	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_WGPS__SHIFT;
+
+	wgp_bitmask =
+		amdgpu_gfx_create_bitmask(adev->gfx.config.max_cu_per_sh >> 1);
+
+	return (~data) & wgp_bitmask;
+}
+
+static u32 gfx_v13_0_get_cu_active_bitmap_per_sh(struct amdgpu_device *adev)
+{
+	u32 wgp_idx, wgp_active_bitmap;
+	u32 cu_bitmap_per_wgp, cu_active_bitmap;
+
+	wgp_active_bitmap = gfx_v13_0_get_wgp_active_bitmap_per_sh(adev);
+	cu_active_bitmap = 0;
+
+	for (wgp_idx = 0; wgp_idx < 16; wgp_idx++) {
+		/* if there is one WGP enabled, it means 2 CUs will be enabled */
+		cu_bitmap_per_wgp = 3 << (2 * wgp_idx);
+		if (wgp_active_bitmap & (1 << wgp_idx))
+			cu_active_bitmap |= cu_bitmap_per_wgp;
+	}
+
+	return cu_active_bitmap;
+}
+
+static int gfx_v13_0_get_cu_info(struct amdgpu_device *adev,
+				 struct amdgpu_cu_info *cu_info)
+{
+	int i, j, k, counter, active_cu_number = 0;
+	u32 mask, bitmap;
+	unsigned disable_masks[8 * 2];
+
+	if (!adev || !cu_info)
+		return -EINVAL;
+
+	amdgpu_gfx_parse_disable_cu(adev, disable_masks, 8, 2);
+
+	mutex_lock(&adev->grbm_idx_mutex);
+	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
+		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+			bitmap = i * adev->gfx.config.max_sh_per_se + j;
+			if (!((gfx_v13_0_get_sa_active_bitmap(adev) >> bitmap) & 1))
+				continue;
+			mask = 1;
+			counter = 0;
+			gfx_v13_0_select_se_sh(adev, i, j, 0xffffffff, 0);
+			if (i < 8 && j < 2)
+				gfx_v13_0_set_user_wgp_inactive_bitmap_per_sh(
+					adev, disable_masks[i * 2 + j]);
+			bitmap = gfx_v13_0_get_cu_active_bitmap_per_sh(adev);
+
+			/**
+			 * GFX13 could support more than 4 SEs, while the bitmap
+			 * in cu_info struct is 4x4 and ioctl interface struct
+			 * drm_amdgpu_info_device should keep stable.
+			 * So we use last two columns of bitmap to store cu mask for
+			 * SEs 4 to 7, the layout of the bitmap is as below:
+			 *    SE0: {SH0,SH1} --> {bitmap[0][0], bitmap[0][1]}
+			 *    SE1: {SH0,SH1} --> {bitmap[1][0], bitmap[1][1]}
+			 *    SE2: {SH0,SH1} --> {bitmap[2][0], bitmap[2][1]}
+			 *    SE3: {SH0,SH1} --> {bitmap[3][0], bitmap[3][1]}
+			 *    SE4: {SH0,SH1} --> {bitmap[0][2], bitmap[0][3]}
+			 *    SE5: {SH0,SH1} --> {bitmap[1][2], bitmap[1][3]}
+			 *    SE6: {SH0,SH1} --> {bitmap[2][2], bitmap[2][3]}
+			 *    SE7: {SH0,SH1} --> {bitmap[3][2], bitmap[3][3]}
+			 */
+			cu_info->bitmap[0][i % 4][j + (i / 4) * 2] = bitmap;
+
+			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
+				if (bitmap & mask)
+					counter++;
+
+				mask <<= 1;
+			}
+			active_cu_number += counter;
+		}
+	}
+	gfx_v13_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff, 0);
+	mutex_unlock(&adev->grbm_idx_mutex);
+
+	cu_info->number = active_cu_number;
+	cu_info->simd_per_cu = NUM_SIMD_PER_CU;
+
+	return 0;
+}
+
+const struct amdgpu_ip_block_version gfx_v13_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_GFX,
+	.major = 13,
+	.minor = 0,
+	.rev = 1,
+	.funcs = &gfx_v13_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h b/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h
new file mode 100644
index 0000000000000..c02f10f8e269c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.h
@@ -0,0 +1,31 @@
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
+
+#ifndef __GFX_V13_0_H__
+#define __GFX_V13_0_H__
+
+extern const struct amdgpu_ip_block_version gfx_v13_0_ip_block;
+
+int gfx_v13_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req);
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index 56f1bfac0b208..46fb0213a2f0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -602,8 +602,10 @@
  * 7. WPTR_ADDR_HI [31:0]
  */
 /* CONTROL */
+#              define PACKET3_MAP_QUEUES_EXT_ENG_SEL(x)     ((x) << 2)
 #              define PACKET3_MAP_QUEUES_QUEUE_SEL(x)       ((x) << 4)
 #              define PACKET3_MAP_QUEUES_VMID(x)            ((x) << 8)
+#              define PACKET3_MAP_QUEUES_GWS_ENABLE(x)      ((x) << 12)
 #              define PACKET3_MAP_QUEUES_QUEUE(x)           ((x) << 13)
 #              define PACKET3_MAP_QUEUES_PIPE(x)            ((x) << 16)
 #              define PACKET3_MAP_QUEUES_ME(x)              ((x) << 18)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h b/drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h
new file mode 100644
index 0000000000000..34902c6aa2c77
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v2_0_d.h
@@ -0,0 +1,680 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+
+#ifndef SOC_V2_0_D_H
+#define SOC_V2_0_D_H
+
+/**
+ * Navi's PM4 definitions
+ */
+#define	PACKET_TYPE0	0
+#define	PACKET_TYPE1	1
+#define	PACKET_TYPE2	2
+#define	PACKET_TYPE3	3
+
+#define CP_PACKET_GET_TYPE(h) (((h) >> 30) & 3)
+#define CP_PACKET_GET_COUNT(h) (((h) >> 16) & 0x3FFF)
+#define CP_PACKET0_GET_REG(h) ((h) & 0xFFFF)
+#define CP_PACKET3_GET_OPCODE(h) (((h) >> 8) & 0xFF)
+#define PACKET0(reg, n)	((PACKET_TYPE0 << 30) |				\
+			 ((reg) & 0xFFFF) |			\
+			 ((n) & 0x3FFF) << 16)
+#define CP_PACKET2			0x80000000
+#define		PACKET2_PAD_SHIFT		0
+#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
+
+#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
+
+#define PACKET3(op, n)	((PACKET_TYPE3 << 30) |				\
+			 (((op) & 0xFF) << 8) |				\
+			 ((n) & 0x3FFF) << 16)
+
+#define PACKET3_COMPUTE(op, n) (PACKET3(op, n) | 1 << 1)
+
+/* Packet 3 types */
+#define	PACKET3_NOP					0x10
+#define	PACKET3_SET_BASE				0x11
+#define		PACKET3_BASE_INDEX(x)                  ((x) << 0)
+#define			CE_PARTITION_BASE		3
+#define	PACKET3_CLEAR_STATE				0x12
+#define	PACKET3_INDEX_BUFFER_SIZE			0x13
+#define	PACKET3_DISPATCH_DIRECT				0x15
+#define	PACKET3_DISPATCH_INDIRECT			0x16
+#define	PACKET3_INDIRECT_BUFFER_END			0x17
+#define	PACKET3_INDIRECT_BUFFER_CNST_END		0x19
+#define	PACKET3_ATOMIC_GDS				0x1D
+#define	PACKET3_ATOMIC_MEM				0x1E
+#define 	PACKET3_ATOMIC_MEM__ATOMIC(x) ((((unsigned)(x)) & 0x7F) << 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_ATOMIC_MEM__ADDR_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__ADDR_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__SRC_DATA_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__SRC_DATA_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__CMP_DATA_LO(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__CMP_DATA_HI(x) (((unsigned)(x)))
+#define 	PACKET3_ATOMIC_MEM__LOOP_INTERVAL(x) ((((unsigned)(x)) & 0x1FFF) << 0)
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SINGLE_PASS_ATOMIC 0
+#define 	PACKET3_ATOMIC_MEM__COMMAND__LOOP_UNTIL_COMPARE_SATISFIED 1
+#define 	PACKET3_ATOMIC_MEM__COMMAND__WAIT_FOR_WRITE_CONFIRMATION 2
+#define 	PACKET3_ATOMIC_MEM__COMMAND__SEND_AND_CONTINUE 3
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__LRU 0
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__STREAM 1
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__NOA 2
+#define 	PACKET3_ATOMIC_MEM__CACHE_POLICY__BYPASS 3
+#define	PACKET3_OCCLUSION_QUERY				0x1F
+#define	PACKET3_SET_PREDICATION				0x20
+#define	PACKET3_REG_RMW					0x21
+#define	PACKET3_COND_EXEC				0x22
+#define	PACKET3_PRED_EXEC				0x23
+#define	PACKET3_DRAW_INDIRECT				0x24
+#define	PACKET3_DRAW_INDEX_INDIRECT			0x25
+#define	PACKET3_INDEX_BASE				0x26
+#define	PACKET3_DRAW_INDEX_2				0x27
+#define	PACKET3_CONTEXT_CONTROL				0x28
+#define	PACKET3_INDEX_TYPE				0x2A
+#define	PACKET3_DRAW_INDIRECT_MULTI			0x2C
+#define	PACKET3_DRAW_INDEX_AUTO				0x2D
+#define	PACKET3_NUM_INSTANCES				0x2F
+#define	PACKET3_DRAW_INDEX_MULTI_AUTO			0x30
+#define	PACKET3_INDIRECT_BUFFER_PRIV			0x32
+#define	PACKET3_INDIRECT_BUFFER_CNST			0x33
+#define	PACKET3_COND_INDIRECT_BUFFER_CNST		0x33
+#define	PACKET3_STRMOUT_BUFFER_UPDATE			0x34
+#define	PACKET3_DRAW_INDEX_OFFSET_2			0x35
+#define	PACKET3_DRAW_PREAMBLE				0x36
+#define	PACKET3_WRITE_DATA				0x37
+#define		WRITE_DATA_DST_SEL(x)                   ((x) << 8)
+		/* 0 - register
+		 * 1 - memory (sync - via GRBM)
+		 * 2 - gl2
+		 * 3 - gds
+		 * 4 - reserved
+		 * 5 - memory (async - direct)
+		 */
+#define		WR_ONE_ADDR                             (1 << 16)
+#define		WR_CONFIRM                              (1 << 20)
+#define		WRITE_DATA_CACHE_POLICY(x)              ((x) << 25)
+		/* 0 - LRU
+		 * 1 - Stream
+		 */
+#define		WRITE_DATA_ENGINE_SEL(x)                ((x) << 30)
+		/* 0 - me
+		 * 1 - pfp
+		 * 2 - ce
+		 */
+#define 	PACKET3_WRITE_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_WRITE_DATA__ADDR_INCR(x) ((((unsigned)(x)) & 0x1) << 16)
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define 	PACKET3_WRITE_DATA__DST_GDS_ADDR(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_WRITE_DATA__DST_MEM_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_WRITE_DATA__MODE(x) ((((unsigned)(x)) & 0x1) << 21)
+#define 	PACKET3_WRITE_DATA__AID_ID(x) ((((unsigned)(x)) & 0x3) << 22)
+#define 	PACKET3_WRITE_DATA__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 24)
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_LO(x) ((unsigned)(x))
+#define 	PACKET3_WRITE_DATA__DST_MMREG_ADDR_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_WRITE_DATA__DST_SEL__TC_L2 2
+#define 	PACKET3_WRITE_DATA__DST_SEL__GDS 3
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY 5
+#define 	PACKET3_WRITE_DATA__DST_SEL__MEMORY_MAPPED_ADC_PERSISTENT_STATE 6
+#define 	PACKET3_WRITE_DATA__ADDR_INCR__INCREMENT_ADDRESS 0
+#define 	PACKET3_WRITE_DATA__ADDR_INCR__DO_NOT_INCREMENT_ADDRESS 1
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_WRITE_CONFIRMATION 0
+#define 	PACKET3_WRITE_DATA__WR_CONFIRM__WAIT_FOR_WRITE_CONFIRMATION 1
+#define 	PACKET3_WRITE_DATA__MODE__PF_VF_DISABLED 0
+#define 	PACKET3_WRITE_DATA__MODE__PF_VF_ENABLED 1
+#define 	PACKET3_WRITE_DATA__TEMPORAL__RT 0
+#define 	PACKET3_WRITE_DATA__TEMPORAL__NT 1
+#define 	PACKET3_WRITE_DATA__TEMPORAL__HT 2
+#define 	PACKET3_WRITE_DATA__TEMPORAL__LU 3
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__LRU 0
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__STREAM 1
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__NOA 2
+#define 	PACKET3_WRITE_DATA__CACHE_POLICY__BYPASS 3
+#define	PACKET3_DRAW_INDEX_INDIRECT_MULTI		0x38
+#define	PACKET3_MEM_SEMAPHORE				0x39
+#              define PACKET3_SEM_USE_MAILBOX       (0x1 << 16)
+#              define PACKET3_SEM_SEL_SIGNAL_TYPE   (0x1 << 20) /* 0 = increment, 1 = write 1 */
+#              define PACKET3_SEM_SEL_SIGNAL	    (0x6 << 29)
+#              define PACKET3_SEM_SEL_WAIT	    (0x7 << 29)
+#define	PACKET3_DRAW_INDEX_MULTI_INST			0x3A
+#define	PACKET3_COPY_DW					0x3B
+#define	PACKET3_WAIT_REG_MEM				0x3C
+#define		WAIT_REG_MEM_FUNCTION(x)                ((x) << 0)
+		/* 0 - always
+		 * 1 - <
+		 * 2 - <=
+		 * 3 - ==
+		 * 4 - !=
+		 * 5 - >=
+		 * 6 - >
+		 */
+#define		WAIT_REG_MEM_MEM_SPACE(x)               ((x) << 4)
+		/* 0 - reg
+		 * 1 - mem
+		 */
+#define		WAIT_REG_MEM_OPERATION(x)               ((x) << 6)
+		/* 0 - wait_reg_mem
+		 * 1 - wr_wait_wr_reg
+		 */
+#define		WAIT_REG_MEM_ENGINE(x)                  ((x) << 8)
+		/* 0 - me
+		 * 1 - pfp
+		 */
+#define		PACKET3_WAIT_REG_MEM__FUNCTION(x) ((((unsigned)(x)) & 0x7) << 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_SPACE(x) ((((unsigned)(x)) & 0x3) << 4)
+#define		PACKET3_WAIT_REG_MEM__OPERATION(x) ((((unsigned)(x)) & 0x3) << 6)
+#define		PACKET3_WAIT_REG_MEM__MES_INTR_PIPE(x) ((((unsigned)(x)) & 0x3) << 22)
+#define		PACKET3_WAIT_REG_MEM__MES_ACTION(x) ((((unsigned)(x)) & 0x1) << 24)
+#define		PACKET3_WAIT_REG_MEM__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_WAIT_REG_MEM__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define		PACKET3_WAIT_REG_MEM__REG_POLL_ADDR(x) ((((unsigned)(x)) & 0X3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR1(x) ((((unsigned)(x)) & 0X3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__MEM_POLL_ADDR_HI(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__REG_WRITE_ADDR2(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__REFERENCE(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__MASK(x) ((unsigned)(x))
+#define		PACKET3_WAIT_REG_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define		PACKET3_WAIT_REG_MEM__OPTIMIZE_ACE_OFFLOAD_MODE(x) ((((unsigned)(x)) & 0x1) << 31)
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__ALWAYS_PASS 0
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_REF_VALUE 1
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__LESS_THAN_EQUAL_TO_THE_REF_VALUE 2
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__EQUAL_TO_THE_REFERENCE_VALUE 3
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__NOT_EQUAL_REFERENCE_VALUE 4
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_OR_EQUAL_REFERENCE_VALUE 5
+#define 	PACKET3_WAIT_REG_MEM__FUNCTION__GREATER_THAN_REFERENCE_VALUE 6
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__REGISTER_SPACE 0
+#define 	PACKET3_WAIT_REG_MEM__MEM_SPACE__MEMORY_SPACE 1
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_REG_MEM 0
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WR_WAIT_WR_REG 1
+#define 	PACKET3_WAIT_REG_MEM__OPERATION__WAIT_MEM_PREEMPTABLE 3
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__LRU 0
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__STREAM 1
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__NOA 2
+#define 	PACKET3_WAIT_REG_MEM__CACHE_POLICY__BYPASS 3
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__RT 0
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__NT 1
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__HT 2
+#define 	PACKET3_WAIT_REG_MEM__TEMPORAL__LU 3
+#define	PACKET3_INDIRECT_BUFFER				0x3F
+#define		INDIRECT_BUFFER_VALID                   (1 << 23)
+#define		INDIRECT_BUFFER_CACHE_POLICY(x)         ((x) << 28)
+		/* 0 - LRU
+		 * 1 - Stream
+		 * 2 - Bypass
+		 */
+#define		INDIRECT_BUFFER_PRE_ENB(x)		((x) << 21)
+#define		INDIRECT_BUFFER_PRE_RESUME(x)           ((x) << 30)
+#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_INDIRECT_BUFFER__IB_BASE_HI(x) ((unsigned)(x))
+#define 	PACKET3_INDIRECT_BUFFER__IB_SIZE(x) ((((unsigned)(x)) & 0xFFFFF) << 0)
+#define 	PACKET3_INDIRECT_BUFFER__CHAIN(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_INDIRECT_BUFFER__OFFLOAD_POLLING(x) ((((unsigned)(x)) & 0x1) << 21)
+#define 	PACKET3_INDIRECT_BUFFER__VALID(x) ((((unsigned)(x)) & 0x1) << 23)
+#define 	PACKET3_INDIRECT_BUFFER__VMID(x) ((((unsigned)(x)) & 0xF) << 24)
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 28)
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 28)
+#define 	PACKET3_INDIRECT_BUFFER__PRIV(x) ((((unsigned)(x)) & 0x1) << 31)
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__RT 0
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__NT 1
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__HT 2
+#define 	PACKET3_INDIRECT_BUFFER__TEMPORAL__LU 3
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__LRU 0
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__STREAM 1
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__NOA 2
+#define 	PACKET3_INDIRECT_BUFFER__CACHE_POLICY__BYPASS 3
+#define	PACKET3_COND_INDIRECT_BUFFER			0x3F
+#define	PACKET3_COPY_DATA				0x40
+#define 	PACKET3_COPY_DATA__SRC_SEL(x) ((((unsigned)(x)) & 0xF) << 0)
+#define 	PACKET3_COPY_DATA__DST_SEL(x) ((((unsigned)(x)) & 0xF) << 8)
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 13)
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 13)
+#define 	PACKET3_COPY_DATA__COUNT_SEL(x) ((((unsigned)(x)) & 0x1) << 16)
+#define 	PACKET3_COPY_DATA__WR_CONFIRM(x) ((((unsigned)(x)) & 0x1) << 20)
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS(x) ((((unsigned)(x)) & 0x1) << 29)
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define 	PACKET3_COPY_DATA__SRC_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_COPY_DATA__SRC_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_COPY_DATA__SRC_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_COPY_DATA__IMM_DATA(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_MEMTC_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_IMM_DATA(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET(x) ((((unsigned)(x)) & 0x3FFFF) << 0)
+#define 	PACKET3_COPY_DATA__DST_32B_ADDR_LO(x) ((((unsigned)(x)) & 0x3FFFFFFF) << 2)
+#define 	PACKET3_COPY_DATA__DST_64B_ADDR_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_COPY_DATA__DST_GDS_ADDR_LO(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_COPY_DATA__DST_ADDR_HI(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__MODE(x) ((((unsigned)(x)) & 0x1) << 21)
+#define 	PACKET3_COPY_DATA__AID_ID(x) ((((unsigned)(x)) & 0x3) << 23)
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL(x) ((((unsigned)(x)) & 0x3) << 25)
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_LO(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__SRC_REG_OFFSET_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_LO(x) ((unsigned)(x))
+#define 	PACKET3_COPY_DATA__DST_REG_OFFSET_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_COPY_DATA__SRC_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2_OBSOLETE 1
+#define 	PACKET3_COPY_DATA__SRC_SEL__TC_L2 2
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS 3
+#define 	PACKET3_COPY_DATA__SRC_SEL__PERFCOUNTERS 4
+#define 	PACKET3_COPY_DATA__SRC_SEL__IMMEDIATE_DATA 5
+#define 	PACKET3_COPY_DATA__SRC_SEL__ATOMIC_RETURN_DATA 6
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA0 7
+#define 	PACKET3_COPY_DATA__SRC_SEL__GDS_ATOMIC_RETURN_DATA1 8
+#define 	PACKET3_COPY_DATA__SRC_SEL__GPU_CLOCK_COUNT 9
+#define 	PACKET3_COPY_DATA__SRC_SEL__SYSTEM_CLOCK_COUNT 10
+#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REGISTER 0
+#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2 2
+#define 	PACKET3_COPY_DATA__DST_SEL__GDS 3
+#define 	PACKET3_COPY_DATA__DST_SEL__PERFCOUNTERS 4
+#define 	PACKET3_COPY_DATA__DST_SEL__TC_L2_OBSOLETE 5
+#define 	PACKET3_COPY_DATA__DST_SEL__MEM_MAPPED_REG_DC 6
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__RT 0
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__NT 1
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__HT 2
+#define 	PACKET3_COPY_DATA__SRC_TEMPORAL__LU 3
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__LRU 0
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__STREAM 1
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__NOA 2
+#define 	PACKET3_COPY_DATA__SRC_CACHE_POLICY__BYPASS 3
+#define 	PACKET3_COPY_DATA__COUNT_SEL__32_BITS_OF_DATA 0
+#define 	PACKET3_COPY_DATA__COUNT_SEL__64_BITS_OF_DATA 1
+#define 	PACKET3_COPY_DATA__WR_CONFIRM__DO_NOT_WAIT_FOR_CONFIRMATION 0
+#define 	PACKET3_COPY_DATA__WR_CONFIRM__WAIT_FOR_CONFIRMATION 1
+#define 	PACKET3_COPY_DATA__MODE__PF_VF_DISABLED 0
+#define 	PACKET3_COPY_DATA__MODE__PF_VF_ENABLED 1
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__RT 0
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__NT 1
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__HT 2
+#define 	PACKET3_COPY_DATA__DST_TEMPORAL__LU 3
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__LRU 0
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__STREAM 1
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__NOA 2
+#define 	PACKET3_COPY_DATA__DST_CACHE_POLICY__BYPASS 3
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__DEFAULT 0
+#define 	PACKET3_COPY_DATA__PQ_EXE_STATUS__PHASE_UPDATE 1
+#define	PACKET3_CP_DMA					0x41
+#define	PACKET3_PFP_SYNC_ME				0x42
+#define	PACKET3_SURFACE_SYNC				0x43
+#define	PACKET3_ME_INITIALIZE				0x44
+#define	PACKET3_COND_WRITE				0x45
+#define	PACKET3_EVENT_WRITE				0x46
+#define		EVENT_TYPE(x)                           ((x) << 0)
+#define		EVENT_INDEX(x)                          ((x) << 8)
+		/* 0 - any non-TS event
+		 * 1 - ZPASS_DONE, PIXEL_PIPE_STAT_*
+		 * 2 - SAMPLE_PIPELINESTAT
+		 * 3 - SAMPLE_STREAMOUTSTAT*
+		 * 4 - *S_PARTIAL_FLUSH
+		 */
+#define		PACKET3_EVENT_WRITE__EVENT_TYPE(x) ((((unsigned)(x)) & 0x3F) << 0)
+#define		PACKET3_EVENT_WRITE__EVENT_INDEX(x) ((((unsigned)(x)) & 0xF) << 8)
+#define		PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE(x) ((((unsigned)(x)) & 0x3) << 29)
+#define		PACKET3_EVENT_WRITE__OFFLOAD_ENABLE(x) ((((unsigned)(x)) & 0x1) << 0)
+#define 	PACKET3_EVENT_WRITE__ADDRESS_LO(x) ((((unsigned)(x)) & 0x1FFFFFFF) << 3)
+#define 	PACKET3_EVENT_WRITE__ADDRESS_HI(x) ((unsigned)(x))
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__OTHER 0
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_PIPELINESTAT 2
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__CS_PARTIAL_FLUSH 4
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS 8
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS1 9
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS2 10
+#define 	PACKET3_EVENT_WRITE__EVENT_INDEX__SAMPLE_STREAMOUTSTATS3 11
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__LEGACY_MODE 0
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE1 1
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__NEW_MODE 2
+#define 	PACKET3_EVENT_WRITE__SAMP_PLST_CNTR_MODE__MIXED_MODE3 3
+#define	PACKET3_EVENT_WRITE_EOP				0x47
+#define	PACKET3_EVENT_WRITE_EOS				0x48
+#define	PACKET3_RELEASE_MEM				0x49
+#define		PACKET3_RELEASE_MEM_EVENT_TYPE(x)	((x) << 0)
+#define		PACKET3_RELEASE_MEM_EVENT_INDEX(x)	((x) << 8)
+#define		PACKET3_RELEASE_MEM_GCR_GLM_WB		(1 << 12)
+#define		PACKET3_RELEASE_MEM_GCR_GLM_INV		(1 << 13)
+#define		PACKET3_RELEASE_MEM_GCR_GLV_INV		(1 << 14)
+#define		PACKET3_RELEASE_MEM_GCR_GL1_INV		(1 << 15)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_US		(1 << 16)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_RANGE	(1 << 17)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_DISCARD	(1 << 19)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_INV		(1 << 20)
+#define		PACKET3_RELEASE_MEM_GCR_GL2_WB		(1 << 21)
+#define		PACKET3_RELEASE_MEM_GCR_SEQ		(1 << 22)
+#define		PACKET3_RELEASE_MEM_CACHE_POLICY(x)	((x) << 25)
+		/* 0 - cache_policy__me_release_mem__lru
+		 * 1 - cache_policy__me_release_mem__stream
+		 * 2 - cache_policy__me_release_mem__noa
+		 * 3 - cache_policy__me_release_mem__bypass
+		 */
+#define		PACKET3_RELEASE_MEM_EXECUTE		(1 << 28)
+
+#define		PACKET3_RELEASE_MEM_DATA_SEL(x)		((x) << 29)
+		/* 0 - discard
+		 * 1 - send low 32bit data
+		 * 2 - send 64bit data
+		 * 3 - send 64bit GPU counter value
+		 * 4 - send 64bit sys counter value
+		 */
+#define		PACKET3_RELEASE_MEM_INT_SEL(x)		((x) << 24)
+		/* 0 - none
+		 * 1 - interrupt only (DATA_SEL = 0)
+		 * 2 - interrupt when data write is confirmed
+		 */
+#define		PACKET3_RELEASE_MEM_DST_SEL(x)		((x) << 16)
+		/* 0 - MC
+		 * 1 - TC/L2
+		 */
+
+
+
+#define	PACKET3_PREAMBLE_CNTL				0x4A
+#              define PACKET3_PREAMBLE_BEGIN_CLEAR_STATE     (2 << 28)
+#              define PACKET3_PREAMBLE_END_CLEAR_STATE       (3 << 28)
+#define	PACKET3_DMA_DATA				0x50
+/* 1. header
+ * 2. CONTROL
+ * 3. SRC_ADDR_LO or DATA [31:0]
+ * 4. SRC_ADDR_HI [31:0]
+ * 5. DST_ADDR_LO [31:0]
+ * 6. DST_ADDR_HI [7:0]
+ * 7. COMMAND [31:26] | BYTE_COUNT [25:0]
+ */
+/* CONTROL */
+#              define PACKET3_DMA_DATA_ENGINE(x)     ((x) << 0)
+		/* 0 - ME
+		 * 1 - PFP
+		 */
+#              define PACKET3_DMA_DATA_SRC_CACHE_POLICY(x) ((x) << 13)
+		/* 0 - LRU
+		 * 1 - Stream
+		 */
+#              define PACKET3_DMA_DATA_DST_SEL(x)  ((x) << 20)
+		/* 0 - DST_ADDR using DAS
+		 * 1 - GDS
+		 * 3 - DST_ADDR using L2
+		 */
+#              define PACKET3_DMA_DATA_DST_CACHE_POLICY(x) ((x) << 25)
+		/* 0 - LRU
+		 * 1 - Stream
+		 */
+#              define PACKET3_DMA_DATA_SRC_SEL(x)  ((x) << 29)
+		/* 0 - SRC_ADDR using SAS
+		 * 1 - GDS
+		 * 2 - DATA
+		 * 3 - SRC_ADDR using L2
+		 */
+#              define PACKET3_DMA_DATA_CP_SYNC     (1 << 31)
+/* COMMAND */
+#              define PACKET3_DMA_DATA_CMD_SAS     (1 << 26)
+		/* 0 - memory
+		 * 1 - register
+		 */
+#              define PACKET3_DMA_DATA_CMD_DAS     (1 << 27)
+		/* 0 - memory
+		 * 1 - register
+		 */
+#              define PACKET3_DMA_DATA_CMD_SAIC    (1 << 28)
+#              define PACKET3_DMA_DATA_CMD_DAIC    (1 << 29)
+#              define PACKET3_DMA_DATA_CMD_RAW_WAIT  (1 << 30)
+#define	PACKET3_CONTEXT_REG_RMW				0x51
+#define	PACKET3_GFX_CNTX_UPDATE				0x52
+#define	PACKET3_BLK_CNTX_UPDATE				0x53
+#define	PACKET3_INCR_UPDT_STATE				0x55
+#define	PACKET3_ACQUIRE_MEM				0x58
+/* 1.  HEADER
+ * 2.  COHER_CNTL [30:0]
+ * 2.1 ENGINE_SEL [31:31]
+ * 2.  COHER_SIZE [31:0]
+ * 3.  COHER_SIZE_HI [7:0]
+ * 4.  COHER_BASE_LO [31:0]
+ * 5.  COHER_BASE_HI [23:0]
+ * 7.  POLL_INTERVAL [15:0]
+ * 8.  GCR_CNTL [18:0]
+ */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLI_INV(x) ((x) << 0)
+		/*
+		 * 0:NOP
+		 * 1:ALL
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_RANGE(x) ((x) << 2)
+		/*
+		 * 0:ALL
+		 * 1:reserved
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_WB(x) ((x) << 4)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLM_INV(x) ((x) << 5)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_WB(x) ((x) << 6)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLK_INV(x) ((x) << 7)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GLV_INV(x) ((x) << 8)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL1_INV(x) ((x) << 9)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_US(x) ((x) << 10)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_RANGE(x) ((x) << 11)
+		/*
+		 * 0:ALL
+		 * 1:VOL
+		 * 2:RANGE
+		 * 3:FIRST_LAST
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_DISCARD(x)  ((x) << 13)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_INV(x) ((x) << 14)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_GL2_WB(x) ((x) << 15)
+#define 	PACKET3_ACQUIRE_MEM_GCR_CNTL_SEQ(x) ((x) << 16)
+		/*
+		 * 0: PARALLEL
+		 * 1: FORWARD
+		 * 2: REVERSE
+		 */
+#define 	PACKET3_ACQUIRE_MEM_GCR_RANGE_IS_PA  (1 << 18)
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_SIZE_HI(x) ((((unsigned)(x)) & 0xFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_LO(x) ((unsigned)(x))
+#define 	PACKET3_ACQUIRE_MEM__COHER_BASE_HI(x) ((((unsigned)(x)) & 0xFFFFFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__POLL_INTERVAL(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_ACQUIRE_MEM__GCR_CNTL(x) ((((unsigned)(x)) & 0x7FFFF) << 0)
+#define	PACKET3_REWIND					0x59
+#define	PACKET3_INTERRUPT				0x5A
+#define	PACKET3_GEN_PDEPTE				0x5B
+#define	PACKET3_INDIRECT_BUFFER_PASID			0x5C
+#define	PACKET3_PRIME_UTCL2				0x5D
+#define	PACKET3_LOAD_UCONFIG_REG			0x5E
+#define	PACKET3_LOAD_SH_REG				0x5F
+#define	PACKET3_LOAD_CONFIG_REG				0x60
+#define	PACKET3_LOAD_CONTEXT_REG			0x61
+#define	PACKET3_LOAD_COMPUTE_STATE			0x62
+#define	PACKET3_LOAD_SH_REG_INDEX			0x63
+#define	PACKET3_SET_CONFIG_REG				0x68
+#define		PACKET3_SET_CONFIG_REG_START			0x00002000
+#define		PACKET3_SET_CONFIG_REG_END			0x00002c00
+#define	PACKET3_SET_CONTEXT_REG				0x69
+#define		PACKET3_SET_CONTEXT_REG_START			0x0000a000
+#define		PACKET3_SET_CONTEXT_REG_END			0x0000a400
+#define	PACKET3_SET_CONTEXT_REG_INDEX			0x6A
+#define	PACKET3_SET_VGPR_REG_DI_MULTI			0x71
+#define	PACKET3_SET_SH_REG_DI				0x72
+#define	PACKET3_SET_CONTEXT_REG_INDIRECT		0x73
+#define	PACKET3_SET_SH_REG_DI_MULTI			0x74
+#define	PACKET3_GFX_PIPE_LOCK				0x75
+#define	PACKET3_SET_SH_REG				0x76
+#define		PACKET3_SET_SH_REG_START			0x00002c00
+#define		PACKET3_SET_SH_REG_END				0x00003000
+#define 	PACKET3_SET_SH_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define 	PACKET3_SET_SH_REG__VMID_SHIFT(x) ((((unsigned)(x)) & 0x1F) << 23)
+#define 	PACKET3_SET_SH_REG__INDEX(x) ((((unsigned)(x)) & 0xF) << 28)
+#define 	PACKET3_SET_SH_REG__INDEX__DEFAULT 0
+#define 	PACKET3_SET_SH_REG__INDEX__INSERT_VMID 1
+#define	PACKET3_SET_SH_REG_OFFSET			0x77
+#define	PACKET3_SET_QUEUE_REG				0x78
+#define	PACKET3_SET_UCONFIG_REG				0x79
+#define		PACKET3_SET_UCONFIG_REG_START			0x0000c000
+#define		PACKET3_SET_UCONFIG_REG_END			0x0000c400
+#define 	PACKET3_SET_UCONFIG_REG__REG_OFFSET(x) ((((unsigned)(x)) & 0xFFFF) << 0)
+#define	PACKET3_SET_UCONFIG_REG_INDEX			0x7A
+#define	PACKET3_FORWARD_HEADER				0x7C
+#define	PACKET3_SCRATCH_RAM_WRITE			0x7D
+#define	PACKET3_SCRATCH_RAM_READ			0x7E
+#define	PACKET3_LOAD_CONST_RAM				0x80
+#define	PACKET3_WRITE_CONST_RAM				0x81
+#define	PACKET3_DUMP_CONST_RAM				0x83
+#define	PACKET3_INCREMENT_CE_COUNTER			0x84
+#define	PACKET3_INCREMENT_DE_COUNTER			0x85
+#define	PACKET3_WAIT_ON_CE_COUNTER			0x86
+#define	PACKET3_WAIT_ON_DE_COUNTER_DIFF			0x88
+#define	PACKET3_SWITCH_BUFFER				0x8B
+#define	PACKET3_DISPATCH_DRAW_PREAMBLE			0x8C
+#define	PACKET3_DISPATCH_DRAW_PREAMBLE_ACE		0x8C
+#define	PACKET3_DISPATCH_DRAW				0x8D
+#define	PACKET3_DISPATCH_DRAW_ACE			0x8D
+#define	PACKET3_GET_LOD_STATS				0x8E
+#define	PACKET3_DRAW_MULTI_PREAMBLE			0x8F
+#define	PACKET3_FRAME_CONTROL				0x90
+#			define FRAME_TMZ	(1 << 0)
+#			define FRAME_CMD(x) ((x) << 28)
+			/*
+			 * x=0: tmz_begin
+			 * x=1: tmz_end
+			 */
+#define	PACKET3_INDEX_ATTRIBUTES_INDIRECT		0x91
+#define	PACKET3_WAIT_REG_MEM64				0x93
+#define	PACKET3_COND_PREEMPT				0x94
+#define	PACKET3_HDP_FLUSH				0x95
+#define	PACKET3_COPY_DATA_RB				0x96
+#define	PACKET3_INVALIDATE_TLBS				0x98
+#              define PACKET3_INVALIDATE_TLBS_DST_SEL(x)     ((x) << 0)
+#              define PACKET3_INVALIDATE_TLBS_ALL_HUB(x)     ((x) << 4)
+#              define PACKET3_INVALIDATE_TLBS_PASID(x)       ((x) << 5)
+#              define PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(x)  ((x) << 29)
+#define	PACKET3_AQL_PACKET				0x99
+#define	PACKET3_DMA_DATA_FILL_MULTI			0x9A
+#define	PACKET3_SET_SH_REG_INDEX			0x9B
+#define	PACKET3_DRAW_INDIRECT_COUNT_MULTI		0x9C
+#define	PACKET3_DRAW_INDEX_INDIRECT_COUNT_MULTI		0x9D
+#define	PACKET3_DUMP_CONST_RAM_OFFSET			0x9E
+#define	PACKET3_LOAD_CONTEXT_REG_INDEX			0x9F
+#define	PACKET3_SET_RESOURCES				0xA0
+/* 1. header
+ * 2. CONTROL
+ * 3. QUEUE_MASK_LO [31:0]
+ * 4. QUEUE_MASK_HI [31:0]
+ * 5. GWS_MASK_LO [31:0]
+ * 6. GWS_MASK_HI [31:0]
+ * 7. OAC_MASK [15:0]
+ * 8. GDS_HEAP_SIZE [16:11] | GDS_HEAP_BASE [5:0]
+ */
+#              define PACKET3_SET_RESOURCES_VMID_MASK(x)     ((x) << 0)
+#              define PACKET3_SET_RESOURCES_UNMAP_LATENTY(x) ((x) << 16)
+#              define PACKET3_SET_RESOURCES_QUEUE_TYPE(x)    ((x) << 29)
+#define PACKET3_MAP_PROCESS				0xA1
+#define PACKET3_MAP_QUEUES				0xA2
+/* 1. header
+ * 2. CONTROL
+ * 3. CONTROL2
+ * 4. MQD_ADDR_LO [31:0]
+ * 5. MQD_ADDR_HI [31:0]
+ * 6. WPTR_ADDR_LO [31:0]
+ * 7. WPTR_ADDR_HI [31:0]
+ */
+/* CONTROL */
+#              define PACKET3_MAP_QUEUES_EXT_ENG_SEL(x)     ((x) << 2)
+#              define PACKET3_MAP_QUEUES_QUEUE_SEL(x)       ((x) << 4)
+#              define PACKET3_MAP_QUEUES_VMID(x)            ((x) << 8)
+#              define PACKET3_MAP_QUEUES_GWS_ENABLE(x)      ((x) << 12)
+#              define PACKET3_MAP_QUEUES_QUEUE(x)           ((x) << 13)
+#              define PACKET3_MAP_QUEUES_PIPE(x)            ((x) << 16)
+#              define PACKET3_MAP_QUEUES_ME(x)              ((x) << 18)
+#              define PACKET3_MAP_QUEUES_QUEUE_TYPE(x)      ((x) << 21)
+#              define PACKET3_MAP_QUEUES_ALLOC_FORMAT(x)    ((x) << 24)
+#              define PACKET3_MAP_QUEUES_ENGINE_SEL(x)      ((x) << 26)
+#              define PACKET3_MAP_QUEUES_NUM_QUEUES(x)      ((x) << 29)
+/* CONTROL2 */
+#              define PACKET3_MAP_QUEUES_CHECK_DISABLE(x)   ((x) << 1)
+#              define PACKET3_MAP_QUEUES_DOORBELL_OFFSET(x) ((x) << 2)
+#define	PACKET3_UNMAP_QUEUES				0xA3
+/* 1. header
+ * 2. CONTROL
+ * 3. CONTROL2
+ * 4. CONTROL3
+ * 5. CONTROL4
+ * 6. CONTROL5
+ */
+/* CONTROL */
+#              define PACKET3_UNMAP_QUEUES_ACTION(x)           ((x) << 0)
+		/* 0 - PREEMPT_QUEUES
+		 * 1 - RESET_QUEUES
+		 * 2 - DISABLE_PROCESS_QUEUES
+		 * 3 - PREEMPT_QUEUES_NO_UNMAP
+		 */
+#              define PACKET3_UNMAP_QUEUES_QUEUE_SEL(x)        ((x) << 4)
+#              define PACKET3_UNMAP_QUEUES_ENGINE_SEL(x)       ((x) << 26)
+#              define PACKET3_UNMAP_QUEUES_NUM_QUEUES(x)       ((x) << 29)
+/* CONTROL2a */
+#              define PACKET3_UNMAP_QUEUES_PASID(x)            ((x) << 0)
+/* CONTROL2b */
+#              define PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET0(x) ((x) << 2)
+/* CONTROL3a */
+#              define PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET1(x) ((x) << 2)
+/* CONTROL3b */
+#              define PACKET3_UNMAP_QUEUES_RB_WPTR(x)          ((x) << 0)
+/* CONTROL4 */
+#              define PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET2(x) ((x) << 2)
+/* CONTROL5 */
+#              define PACKET3_UNMAP_QUEUES_DOORBELL_OFFSET3(x) ((x) << 2)
+#define	PACKET3_QUERY_STATUS				0xA4
+/* 1. header
+ * 2. CONTROL
+ * 3. CONTROL2
+ * 4. ADDR_LO [31:0]
+ * 5. ADDR_HI [31:0]
+ * 6. DATA_LO [31:0]
+ * 7. DATA_HI [31:0]
+ */
+/* CONTROL */
+#              define PACKET3_QUERY_STATUS_CONTEXT_ID(x)       ((x) << 0)
+#              define PACKET3_QUERY_STATUS_INTERRUPT_SEL(x)    ((x) << 28)
+#              define PACKET3_QUERY_STATUS_COMMAND(x)          ((x) << 30)
+/* CONTROL2a */
+#              define PACKET3_QUERY_STATUS_PASID(x)            ((x) << 0)
+/* CONTROL2b */
+#              define PACKET3_QUERY_STATUS_DOORBELL_OFFSET(x)  ((x) << 2)
+#              define PACKET3_QUERY_STATUS_ENG_SEL(x)          ((x) << 25)
+#define	PACKET3_RUN_LIST				0xA5
+#define	PACKET3_MAP_PROCESS_VM				0xA6
+
+#define PACKET3_RUN_CLEANER_SHADER                      0xD2
+/* 1. header
+ * 2. RESERVED [31:0]
+ */
+
+/* GFX11 */
+#define	PACKET3_SET_Q_PREEMPTION_MODE			0xF0
+#              define PACKET3_SET_Q_PREEMPTION_MODE_IB_VMID(x)  ((x) << 0)
+#              define PACKET3_SET_Q_PREEMPTION_MODE_INIT_SHADOW_MEM    (1 << 0)
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_sh_mask.h
index 3e2c67f94067e..d4d92921aca65 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_13_0_1_sh_mask.h
@@ -42972,8 +42972,10 @@
 #define SQ_DEBUG_STS_GLOBAL2__SQ_IND_ACCESS_RD_WR_SWITCH_MASK                                                 0x80000000L
 //SH_MEM_BASES
 #define SH_MEM_BASES__PRIVATE_BASE__SHIFT                                                                     0x0
+#define SH_MEM_BASES__PRIVATE_BASE_NATIVE__SHIFT                                                              0xa
 #define SH_MEM_BASES__SHARED_BASE__SHIFT                                                                      0x10
 #define SH_MEM_BASES__PRIVATE_BASE_MASK                                                                       0x0000FFFFL
+#define SH_MEM_BASES__PRIVATE_BASE_NATIVE_MASK                                                                0x0000FC00L
 #define SH_MEM_BASES__SHARED_BASE_MASK                                                                        0xFFFF0000L
 //SH_MEM_CONFIG
 #define SH_MEM_CONFIG__ADDRESS_MODE__SHIFT                                                                    0x0
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index 29009f6aabde9..894fca0a79cc9 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -1689,6 +1689,7 @@ struct drm_amdgpu_info_uq_metadata {
 #define AMDGPU_FAMILY_GC_11_5_0			150 /* GC 11.5.0 */
 #define AMDGPU_FAMILY_GC_11_5_4			154 /* GC 11.5.4 */
 #define AMDGPU_FAMILY_GC_12_0_0			152 /* GC 12.0.0 */
+#define AMDGPU_FAMILY_GC_13_0_0			153 /* GC 13.0.0 */
 
 /*
  * Definition of user options
-- 
2.56.0

