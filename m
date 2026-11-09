Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6EF606A330
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pGDUJORY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82B9010E181;
	Mon,  9 Nov 2026 18:47:01 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012021.outbound.protection.outlook.com [52.101.43.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE9610E5C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpYD3EpXis+qckySG8SWQ+9qSbB5t0MsTdG/k4rimKlraDRYdNuxeR/hXOXtAqWGoF0KBagAbXs5yzFo20sV7GHnvr2aOj8daFBR7VyS3JrgIPYkdquvmO4srgq56qvu5AVQfprRht3ioKN/9se5GTwyo5RUYsKk1v6gQ99nFOd9zrVm6lpHsWacvOFXtnipEq7refaa/Bkup8/yEVwtZPkaUhnkjFYSlTY/JO/wNfrZu/ZB+Nnvpam+gb389Mq/+vJJKFj8oHuWSVCr5+nYZWFOdkPperyD0r+nf6ljoq0WC7CnGQ3JWwUqwZzlLalTWIj72KaNXIpc2dJ2I1bsgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C0qosJ348LtEkUlfYqLfMBXWy0SJvwITSU8bmwJqiqw=;
 b=eMHB2FfaxJAgtehQlZFr1jl8qtLmxMp1B/cISXceVLgVJ+RcJSQojAfJ/fXcX+Any27f7lWT3fvpdQr0KbCnoqUlmZ3WZh43In8N7V/2wSQplxNJ6LeGI2YZfByJ52MYvxmWVTpJU/K8rMQJEs8MVvK/mCVPwKajANz5bIlkcry28a7AqYOIbXZwkhfKofadkVLRgtGIpkd9Av00O4e8pZYgQ+0VY0cr9dJVeQvu3gU5GBLBKLWtNClN2IKreGfl2eoppaWYsbk583c6MXoInt+aEJ6/wqZr9h5Mgvcz0TmsKw3HFaku3Ap0w5PCDffYLIOp0Pge1UNNWdnWCJ2Lfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C0qosJ348LtEkUlfYqLfMBXWy0SJvwITSU8bmwJqiqw=;
 b=pGDUJORY+d6dacs8AvEREDzvaApZnG2DbRWjTEkbz/paO/Tbchc7jyxN65cga+atqdKi02Y1uBeKT9wfqx+muMF6Gve+1S7D3DPvYfQEq/I/jHX5NDwTJYuvY8cgg6vudI5/NQvW3z6eZjJ9qYjaDwJb06u3giRjpM9GoIQu01c=
Received: from PH8PR22CA0013.namprd22.prod.outlook.com (2603:10b6:510:2d1::11)
 by SN7PR12MB8792.namprd12.prod.outlook.com (2603:10b6:806:341::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Mon, 9 Nov
 2026 18:46:51 +0000
Received: from PH4PEPF0000B611.namprd21.prod.outlook.com
 (2603:10b6:510:2d1:cafe::6c) by PH8PR22CA0013.outlook.office365.com
 (2603:10b6:510:2d1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Mon, 9
 Nov 2026 18:46:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH4PEPF0000B611.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.0 via Frontend Transport; Mon, 9 Nov 2026 18:46:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:50 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:49 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/8] drm/amdgpu: add mes v13 ip block
Date: Mon, 9 Nov 2026 13:46:35 -0500
Message-ID: <20261109184641.3656885-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184641.3656885-1-alexander.deucher@amd.com>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B611:EE_|SN7PR12MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b728dcf-0b30-45cc-d8e9-08df3e91d111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|261026140227099003|261026130827099003|11063799006|261021123027099003|261026121527099003|56012099006|261026135527099003|261021135927099003|261009223027099003|261022105027099003|261021121427099003|261022113327099003|261021130227099003|261022075727099003|261022115727099003|261021133027099003|261028144727099003|261102123227099003|6133799003|18002099003|22082099003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: dsks5LiThud5bf5Y2hxk573lvziFnoD2Jnh8oW3J0hMpMDbXvinHB3Zd2YNS9NRk/wCuhDoSvynXlv5XGbDRLaQVE9W//WTYrr+dGvyRu5WLp10qqbBXjpudGQkae/OPt1uLDEYjWFQ2UlW1ySkz/Jm/NxIerYUFUqnYKKtY138IeNx+lA5A2GAs0AG5yekmBQ896YcFnGZNpmqSd5ucmpSKPEj9ylWm4pGgom2mdDIFMedDJR0258Dvt23Amow/PZlLWjqtgwh+TspNFhy1MCQgBPsGM6YnqKXrQSUZLxIVFOFPoA/IXkxI1hEbZ5SHon2AJ0kHouep0328FY4Pa2LjG7tHyMj57B12BXa50QB1Uwjnn3nt7WhVMlLHgLSaFtI0GoQa7xnh2W5RQ6x1CDcGENSBrIPRa6rhNHb+UbK7wG4X5+0tLy9LmT3fnzoE2BCCmO6fgDB6HxAHp5uk3gjCzDypoXZOGZRC+uLDc4kjZshZ2fcZJxW4Nfs/KdLyedtpOLIXEJTGLqXUB7ny/3n2KHXPhuhecVB5viFGcmnoxQO9tbXECkXsXY5uTgjcvcSKShRdsOT+sEbNbMU3LdjPL+suSyS90haBLu/X5h/wHC7Id2K8Qr1JvStdmaCK20oOds9x+ljmeegadtoNduXHx0D8fA9cY/disOyNDaBRhAZaM46xkT6fnyibWbwjk+0XI7J8PpWJmseMGFcflA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(261026140227099003)(261026130827099003)(11063799006)(261021123027099003)(261026121527099003)(56012099006)(261026135527099003)(261021135927099003)(261009223027099003)(261022105027099003)(261021121427099003)(261022113327099003)(261021130227099003)(261022075727099003)(261022115727099003)(261021133027099003)(261028144727099003)(261102123227099003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xJKjqOwTACO/TZYu/Uujl2rNM5HH+B3d1qO/V2wWCFrEKZf6jU20IGoPnbLt0yHqmjDN2c1/s3/oe6rrnKUIPez1AuE7F2QmhReb9jzbOZq4IGOq59cBIbKoardYqrLO3bF15plGu9fY/h8Dh97BK2FpL81NFtak/rsp0xZ08tFk4Pzc2Gr53EstjHN0BcovhDkwUrjoo0RWwSXibBd5/qoJQ9cOwgIM22FkLR2vRMfoFe2J37CHLj21pnuChyGx97r7UtlHQuzffjhMcpbTDr2xxIcjHrJqTw9rJTAq9pDCSnW/tXT+SlyJyYASLxVSyhhqvYxMramafFqk7s0wwC1HiXEkpiccdSitr2SNQ1CZ3p35kIb68u8VIeIwPaiE4sYDZAI2jRbSdx6kExnPgq/OGWa0/u9izciaAXONSoOLDJc3a6K4vvzV3QpjHx48
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:50.7559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b728dcf-0b30-45cc-d8e9-08df3e91d111
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH4PEPF0000B611.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8792
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

add mes v13 ip block

v2: squash in MQD update
v3: rebase (Alex)
v4: squash in various fixes

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |    3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |    8 +
 drivers/gpu/drm/amd/amdgpu/mes_v13_0.c        | 1856 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_v13_0.h        |   29 +
 drivers/gpu/drm/amd/include/mes_v13_api_def.h |  886 ++++++++
 5 files changed, 2781 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v13_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/mes_v13_0.h
 create mode 100644 drivers/gpu/drm/amd/include/mes_v13_api_def.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index b4ee78f9943aa..4585e484ddf4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -194,7 +194,8 @@ amdgpu-y += \
 	amdgpu_mes.o \
 	mes_v11_0.o \
 	mes_v12_0.o \
-	mes_v12_1.o
+	mes_v12_1.o \
+	mes_v13_0.o
 
 # add GFX userqueue support
 amdgpu-y += mes_userqueue.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index c929356c2e795..9b286c78454cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -115,6 +115,7 @@
 #include "mes_v11_0.h"
 #include "mes_v12_0.h"
 #include "mes_v12_1.h"
+#include "mes_v13_0.h"
 #include "smuio_v11_0.h"
 #include "smuio_v11_0_6.h"
 #include "smuio_v13_0.h"
@@ -3394,6 +3395,13 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		adev->enable_mes_kiq = true;
 		adev->enable_uni_mes = true;
 		break;
+	case IP_VERSION(13, 0, 1):
+		amdgpu_device_ip_block_add(adev, &mes_v13_0_ip_block);
+		adev->enable_mes = false;
+		adev->enable_mes_kiq = false;
+		if (amdgpu_uni_mes)
+			adev->enable_uni_mes = false;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v13_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v13_0.c
new file mode 100644
index 0000000000000..6daa6910952a5
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v13_0.c
@@ -0,0 +1,1856 @@
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
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include "amdgpu.h"
+#include "gfx_v13_0.h"
+#include "soc15_common.h"
+#include "soc_v2_0.h"
+#include "gc/gc_13_0_1_offset.h"
+#include "gc/gc_13_0_1_sh_mask.h"
+#include "gc/gc_11_0_0_default.h"
+#include "v13_structs.h"
+#include "mes_v13_api_def.h"
+
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_mes1.bin");
+MODULE_FIRMWARE("amdgpu/gc_13_0_1_uni_mes.bin");
+
+static int mes_v13_0_hw_init(struct amdgpu_ip_block *ip_block);
+static int mes_v13_0_hw_fini(struct amdgpu_ip_block *ip_block);
+static int mes_v13_0_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id);
+static int mes_v13_0_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
+
+#define MES_EOP_SIZE   2048
+
+static void mes_v13_0_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr,
+			     ring->wptr);
+		WDOORBELL64(ring->doorbell_index, ring->wptr);
+	} else {
+		BUG();
+	}
+}
+
+static u64 mes_v13_0_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	return *ring->rptr_cpu_addr;
+}
+
+static u64 mes_v13_0_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	u64 wptr;
+
+	if (ring->use_doorbell)
+		wptr = atomic64_read((atomic64_t *)ring->wptr_cpu_addr);
+	else
+		BUG();
+	return wptr;
+}
+
+static const struct amdgpu_ring_funcs mes_v13_0_ring_funcs = {
+	.type = AMDGPU_RING_TYPE_MES,
+	.align_mask = 1,
+	.nop = 0,
+	.support_64bit_ptrs = true,
+	.get_rptr = mes_v13_0_ring_get_rptr,
+	.get_wptr = mes_v13_0_ring_get_wptr,
+	.set_wptr = mes_v13_0_ring_set_wptr,
+	.insert_nop = amdgpu_ring_insert_nop,
+};
+
+static const char *mes_v13_0_opcodes[] = {
+	"SET_HW_RSRC",
+	"SET_SCHEDULING_CONFIG",
+	"ADD_QUEUE",
+	"REMOVE_QUEUE",
+	"PERFORM_YIELD",
+	"SET_GANG_PRIORITY_LEVEL",
+	"SUSPEND",
+	"RESUME",
+	"RESET",
+	"SET_LOG_BUFFER",
+	"CHANGE_GANG_PRORITY",
+	"QUERY_SCHEDULER_STATUS",
+	"unused",
+	"SET_DEBUG_VMID",
+	"MISC",
+	"UPDATE_ROOT_PAGE_TABLE",
+	"AMD_LOG",
+	"SET_SE_MODE",
+	"SET_GANG_SUBMIT",
+	"SET_HW_RSRC_1",
+};
+
+static const char *mes_v13_0_misc_opcodes[] = {
+	"WRITE_REG",
+	"INV_GART",
+	"QUERY_STATUS",
+	"READ_REG",
+	"WAIT_REG_MEM",
+	"SET_SHADER_DEBUGGER",
+	"NOTIFY_WORK_ON_UNMAPPED_QUEUE",
+	"NOTIFY_TO_UNMAP_PROCESSES",
+};
+
+static const char *mes_v13_0_get_op_string(union MESAPI__MISC *x_pkt)
+{
+	const char *op_str = NULL;
+
+	if (x_pkt->header.opcode < ARRAY_SIZE(mes_v13_0_opcodes))
+		op_str = mes_v13_0_opcodes[x_pkt->header.opcode];
+
+	return op_str;
+}
+
+static const char *mes_v13_0_get_misc_op_string(union MESAPI__MISC *x_pkt)
+{
+	const char *op_str = NULL;
+
+	if ((x_pkt->header.opcode == MES_SCH_API_MISC) &&
+	    (x_pkt->opcode < ARRAY_SIZE(mes_v13_0_misc_opcodes)))
+		op_str = mes_v13_0_misc_opcodes[x_pkt->opcode];
+
+	return op_str;
+}
+
+static int mes_v13_0_submit_pkt_and_poll_completion(struct amdgpu_mes *mes,
+					    int pipe, void *pkt, int size,
+					    int api_status_off)
+{
+	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
+	signed long timeout = 2100000; /* 2100 ms */
+	struct amdgpu_device *adev = mes->adev;
+	struct amdgpu_ring *ring = &mes->ring[pipe];
+	spinlock_t *ring_lock = &mes->ring_lock[pipe];
+	struct MES_API_STATUS *api_status;
+	union MESAPI__MISC *x_pkt = pkt;
+	const char *op_str, *misc_op_str;
+	unsigned long flags;
+	u64 status_gpu_addr;
+	u32 seq, status_offset;
+	u64 *status_ptr;
+	signed long r;
+	int ret;
+
+	if (x_pkt->header.opcode >= MES_SCH_API_MAX)
+		return -EINVAL;
+
+	if (amdgpu_emu_mode) {
+		timeout *= 100;
+	} else if (amdgpu_sriov_vf(adev)) {
+		/* Worst case in sriov where all other 15 VF timeout, each VF needs about 600ms */
+		timeout = 15 * 600 * 1000;
+	}
+
+	ret = amdgpu_wb_get(adev, &status_offset);
+	if (ret)
+		return ret;
+
+	status_gpu_addr = adev->wb.gpu_addr + (status_offset * 4);
+	status_ptr = (u64 *)&adev->wb.wb[status_offset];
+	*status_ptr = 0;
+
+	spin_lock_irqsave(ring_lock, flags);
+	r = amdgpu_ring_alloc(ring, (size + sizeof(mes_status_pkt)) / 4);
+	if (r)
+		goto error_unlock_free;
+
+	seq = ++ring->fence_drv.sync_seq;
+	r = amdgpu_fence_wait_polling(ring,
+				      seq - ring->fence_drv.num_fences_mask,
+				      timeout);
+	if (r < 1)
+		goto error_undo;
+
+	api_status = (struct MES_API_STATUS *)((char *)pkt + api_status_off);
+	api_status->api_completion_fence_addr = status_gpu_addr;
+	api_status->api_completion_fence_value = 1;
+
+	amdgpu_ring_write_multiple(ring, pkt, size / 4);
+
+	memset(&mes_status_pkt, 0, sizeof(mes_status_pkt));
+	mes_status_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_status_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
+	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+	mes_status_pkt.api_status.api_completion_fence_addr =
+		ring->fence_drv.gpu_addr;
+	mes_status_pkt.api_status.api_completion_fence_value = seq;
+
+	amdgpu_ring_write_multiple(ring, &mes_status_pkt,
+				   sizeof(mes_status_pkt) / 4);
+
+	amdgpu_ring_commit(ring);
+	spin_unlock_irqrestore(ring_lock, flags);
+
+	op_str = mes_v13_0_get_op_string(x_pkt);
+	misc_op_str = mes_v13_0_get_misc_op_string(x_pkt);
+
+	if (misc_op_str)
+		dev_dbg(adev->dev, "MES(%d) msg=%s (%s) was emitted\n",
+			pipe, op_str, misc_op_str);
+	else if (op_str)
+		dev_dbg(adev->dev, "MES(%d) msg=%s was emitted\n",
+			pipe, op_str);
+	else
+		dev_dbg(adev->dev, "MES(%d) msg=%d was emitted\n",
+			pipe, x_pkt->header.opcode);
+
+	r = amdgpu_fence_wait_polling(ring, seq, timeout);
+	if (r < 1 || !*status_ptr) {
+
+		if (misc_op_str)
+			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s (%s)\n",
+				pipe, op_str, misc_op_str);
+		else if (op_str)
+			dev_err(adev->dev, "MES(%d) failed to respond to msg=%s\n",
+				pipe, op_str);
+		else
+			dev_err(adev->dev, "MES(%d) failed to respond to msg=%d\n",
+				pipe, x_pkt->header.opcode);
+
+		while (halt_if_hws_hang)
+			schedule();
+
+		r = -ETIMEDOUT;
+		goto error_wb_free;
+	}
+
+	amdgpu_wb_free(adev, status_offset);
+	return 0;
+
+error_undo:
+	dev_err(adev->dev, "MES ring buffer is full.\n");
+	amdgpu_ring_undo(ring);
+
+error_unlock_free:
+	spin_unlock_irqrestore(ring_lock, flags);
+
+error_wb_free:
+	amdgpu_wb_free(adev, status_offset);
+	return r;
+}
+
+static int convert_to_mes_queue_type(int queue_type)
+{
+	if (queue_type == AMDGPU_RING_TYPE_GFX)
+		return MES_QUEUE_TYPE_GFX;
+	else if (queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		return MES_QUEUE_TYPE_COMPUTE;
+	else if (queue_type == AMDGPU_RING_TYPE_SDMA)
+		return MES_QUEUE_TYPE_SDMA;
+	else if (queue_type == AMDGPU_RING_TYPE_MES)
+		return MES_QUEUE_TYPE_SCHQ;
+	else
+		BUG();
+	return -1;
+}
+
+static int convert_to_mes_priority_level(int priority_level)
+{
+	switch (priority_level) {
+	case AMDGPU_MES_PRIORITY_LEVEL_LOW:
+		return AMD_PRIORITY_LEVEL_LOW;
+	case AMDGPU_MES_PRIORITY_LEVEL_NORMAL:
+	default:
+		return AMD_PRIORITY_LEVEL_NORMAL;
+	case AMDGPU_MES_PRIORITY_LEVEL_MEDIUM:
+		return AMD_PRIORITY_LEVEL_MEDIUM;
+	case AMDGPU_MES_PRIORITY_LEVEL_HIGH:
+		return AMD_PRIORITY_LEVEL_HIGH;
+	case AMDGPU_MES_PRIORITY_LEVEL_REALTIME:
+		return AMD_PRIORITY_LEVEL_REALTIME;
+	}
+}
+
+static int mes_v13_0_add_hw_queue(struct amdgpu_mes *mes,
+				  struct mes_add_queue_input *input)
+{
+	struct amdgpu_device *adev = mes->adev;
+	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
+	uint32_t vm_cntx_cntl = hub->vm_cntx_cntl;
+
+	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
+
+	mes_add_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_add_queue_pkt.header.opcode = MES_SCH_API_ADD_QUEUE;
+	mes_add_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_add_queue_pkt.process_id = input->process_id;
+	mes_add_queue_pkt.page_table_base_addr = input->page_table_base_addr;
+	mes_add_queue_pkt.process_va_start = input->process_va_start;
+	mes_add_queue_pkt.process_va_end = input->process_va_end;
+	mes_add_queue_pkt.process_quantum = input->process_quantum;
+	mes_add_queue_pkt.process_context_addr = input->process_context_addr;
+	mes_add_queue_pkt.gang_quantum = input->gang_quantum;
+	mes_add_queue_pkt.gang_context_addr = input->gang_context_addr;
+	mes_add_queue_pkt.inprocess_gang_priority =
+		convert_to_mes_priority_level(input->inprocess_gang_priority);
+	mes_add_queue_pkt.gang_global_priority_level =
+		convert_to_mes_priority_level(input->gang_global_priority_level);
+	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
+
+	mes_add_queue_pkt.wptr_addr = input->wptr_mc_addr;
+
+	mes_add_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_add_queue_pkt.paging = input->paging;
+	mes_add_queue_pkt.vm_context_cntl = vm_cntx_cntl;
+	mes_add_queue_pkt.gws_base = input->gws_base;
+	mes_add_queue_pkt.gws_size = input->gws_size;
+	mes_add_queue_pkt.trap_handler_addr = input->tba_addr;
+	mes_add_queue_pkt.tma_addr = input->tma_addr;
+	mes_add_queue_pkt.trap_en = input->trap_en;
+	mes_add_queue_pkt.skip_process_ctx_clear = input->skip_process_ctx_clear;
+	mes_add_queue_pkt.is_kfd_process = input->is_kfd_process;
+
+	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
+	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
+	mes_add_queue_pkt.gds_size = input->queue_size;
+
+	/* For KFD, gds_size is re-used for queue size (needed in MES for AQL queues) */
+	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
+	mes_add_queue_pkt.gds_size = input->queue_size;
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes,
+			AMDGPU_MES_SCHED_PIPE,
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
+			offsetof(union MESAPI__ADD_QUEUE, api_status));
+}
+
+static int mes_v13_0_remove_hw_queue(struct amdgpu_mes *mes,
+				     struct mes_remove_queue_input *input)
+{
+	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
+
+	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
+
+	mes_remove_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_remove_queue_pkt.header.opcode = MES_SCH_API_REMOVE_QUEUE;
+	mes_remove_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_remove_queue_pkt.gang_context_addr = input->gang_context_addr;
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes,
+			AMDGPU_MES_SCHED_PIPE,
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+}
+
+int gfx_v13_0_request_gfx_index_mutex(struct amdgpu_device *adev,
+				      bool req)
+{
+	u32 i, tmp, val;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		/* Request with MeId=2, PipeId=0 */
+		tmp = REG_SET_FIELD(0, CP_GFX_INDEX_MUTEX, REQUEST, req);
+		tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX, CLIENTID, 4);
+		WREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX, tmp);
+
+		val = RREG32_SOC15(GC, 0, regCP_GFX_INDEX_MUTEX);
+		if (req) {
+			if (val == tmp)
+				break;
+		} else {
+			tmp = REG_SET_FIELD(tmp, CP_GFX_INDEX_MUTEX,
+					    REQUEST, 1);
+
+			/* unlocked or locked by firmware */
+			if (val != tmp)
+				break;
+		}
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int mes_v13_0_reset_queue_mmio(struct amdgpu_mes *mes, uint32_t queue_type,
+				      uint32_t me_id, uint32_t pipe_id,
+				      uint32_t queue_id, uint32_t vmid)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t value, reg;
+	int i, r = 0;
+
+	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		dev_info(adev->dev, "reset gfx queue (%d:%d:%d: vmid:%d)\n",
+			 me_id, pipe_id, queue_id, vmid);
+
+		mutex_lock(&adev->gfx.reset_sem_mutex);
+		gfx_v13_0_request_gfx_index_mutex(adev, true);
+		/* all se allow writes */
+		WREG32_SOC15(GC, 0, regGRBM_GFX_INDEX,
+			     (uint32_t)(0x1 << GRBM_GFX_INDEX__SE_BROADCAST_WRITES__SHIFT));
+		value = REG_SET_FIELD(0, CP_VMID_RESET, RESET_REQUEST, 1 << vmid);
+		if (pipe_id == 0)
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE0_QUEUES, 1 << queue_id);
+		else
+			value = REG_SET_FIELD(value, CP_VMID_RESET, PIPE1_QUEUES, 1 << queue_id);
+		WREG32_SOC15(GC, 0, regCP_VMID_RESET, value);
+		gfx_v13_0_request_gfx_index_mutex(adev, false);
+		mutex_unlock(&adev->gfx.reset_sem_mutex);
+
+		mutex_lock(&adev->srbm_mutex);
+		soc_v2_0_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on gfx hqd deactivate\n");
+			r = -ETIMEDOUT;
+		}
+
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		dev_info(adev->dev, "reset compute queue (%d:%d:%d)\n",
+			 me_id, pipe_id, queue_id);
+		mutex_lock(&adev->srbm_mutex);
+		soc_v2_0_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 0x2);
+		WREG32_SOC15(GC, 0, regSPI_COMPUTE_QUEUE_RESET, 0x1);
+
+		/* wait till dequeue take effects */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on hqd deactivate\n");
+			r = -ETIMEDOUT;
+		}
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	} else if (queue_type == AMDGPU_RING_TYPE_SDMA) {
+		dev_info(adev->dev, "reset sdma queue (%d:%d:%d)\n",
+			 me_id, pipe_id, queue_id);
+		switch (me_id) {
+		case 3:
+			reg = SOC15_REG_OFFSET(GC, 0,
+					       regSDMA3_SDMA_QUEUE_RESET_REQ);
+			break;
+		case 2:
+			reg = SOC15_REG_OFFSET(GC, 0,
+					       regSDMA2_SDMA_QUEUE_RESET_REQ);
+			break;
+		case 1:
+			reg = SOC15_REG_OFFSET(GC, 0,
+					       regSDMA1_SDMA_QUEUE_RESET_REQ);
+			break;
+		case 0:
+			reg = SOC15_REG_OFFSET(GC, 0,
+					       regSDMA0_SDMA_QUEUE_RESET_REQ);
+			break;
+		default:
+			dev_err(adev->dev, "invalid SDMA instance %u\n", me_id);
+			r = -EINVAL;
+			goto out;
+		}
+
+		value = 1 << queue_id;
+		WREG32(reg, value);
+		/* wait for queue reset done */
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32(reg) & value))
+				break;
+			udelay(1);
+		}
+		if (i >= adev->usec_timeout) {
+			dev_err(adev->dev, "failed to wait on sdma queue reset done\n");
+			r = -ETIMEDOUT;
+		}
+	}
+
+out:
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	return r;
+}
+
+static int mes_v13_0_map_legacy_queue(struct amdgpu_mes *mes,
+				      struct mes_map_legacy_queue_input *input)
+{
+	union MESAPI__ADD_QUEUE mes_add_queue_pkt;
+	int pipe;
+
+	memset(&mes_add_queue_pkt, 0, sizeof(mes_add_queue_pkt));
+
+	mes_add_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_add_queue_pkt.header.opcode = MES_SCH_API_ADD_QUEUE;
+	mes_add_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_add_queue_pkt.pipe_id = input->pipe_id;
+	mes_add_queue_pkt.queue_id = input->queue_id;
+	mes_add_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_add_queue_pkt.mqd_addr = input->mqd_addr;
+	mes_add_queue_pkt.wptr_addr = input->wptr_addr;
+	mes_add_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_add_queue_pkt.map_legacy_kq = 1;
+
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
+			offsetof(union MESAPI__ADD_QUEUE, api_status));
+}
+
+static int mes_v13_0_unmap_legacy_queue(struct amdgpu_mes *mes,
+			struct mes_unmap_legacy_queue_input *input)
+{
+	union MESAPI__REMOVE_QUEUE mes_remove_queue_pkt;
+	int pipe;
+
+	memset(&mes_remove_queue_pkt, 0, sizeof(mes_remove_queue_pkt));
+
+	mes_remove_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_remove_queue_pkt.header.opcode = MES_SCH_API_REMOVE_QUEUE;
+	mes_remove_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_remove_queue_pkt.doorbell_offset = input->doorbell_offset;
+	mes_remove_queue_pkt.gang_context_addr = 0;
+
+	mes_remove_queue_pkt.pipe_id = input->pipe_id;
+	mes_remove_queue_pkt.queue_id = input->queue_id;
+
+	if (input->action == PREEMPT_QUEUES_NO_UNMAP) {
+		mes_remove_queue_pkt.preempt_legacy_gfx_queue = 1;
+		mes_remove_queue_pkt.tf_addr = input->trail_fence_addr;
+		mes_remove_queue_pkt.tf_data =
+			lower_32_bits(input->trail_fence_data);
+	} else {
+		mes_remove_queue_pkt.unmap_legacy_queue = 1;
+		mes_remove_queue_pkt.queue_type =
+			convert_to_mes_queue_type(input->queue_type);
+	}
+
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_remove_queue_pkt, sizeof(mes_remove_queue_pkt),
+			offsetof(union MESAPI__REMOVE_QUEUE, api_status));
+}
+
+static int mes_v13_0_suspend_gang(struct amdgpu_mes *mes,
+				  struct mes_suspend_gang_input *input)
+{
+	return 0;
+}
+
+static int mes_v13_0_resume_gang(struct amdgpu_mes *mes,
+				 struct mes_resume_gang_input *input)
+{
+	return 0;
+}
+
+static int mes_v13_0_query_sched_status(struct amdgpu_mes *mes, int pipe)
+{
+	union MESAPI__QUERY_MES_STATUS mes_status_pkt;
+
+	memset(&mes_status_pkt, 0, sizeof(mes_status_pkt));
+
+	mes_status_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_status_pkt.header.opcode = MES_SCH_API_QUERY_SCHEDULER_STATUS;
+	mes_status_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_status_pkt, sizeof(mes_status_pkt),
+			offsetof(union MESAPI__QUERY_MES_STATUS, api_status));
+}
+
+static int mes_v13_0_misc_op(struct amdgpu_mes *mes,
+			     struct mes_misc_op_input *input)
+{
+	union MESAPI__MISC misc_pkt;
+	int pipe;
+
+	if (mes->adev->enable_uni_mes)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	memset(&misc_pkt, 0, sizeof(misc_pkt));
+
+	misc_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	misc_pkt.header.opcode = MES_SCH_API_MISC;
+	misc_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	switch (input->op) {
+	case MES_MISC_OP_READ_REG:
+		misc_pkt.opcode = MESAPI_MISC__READ_REG;
+		misc_pkt.read_reg.reg_offset = input->read_reg.reg_offset;
+		misc_pkt.read_reg.buffer_addr = input->read_reg.buffer_addr;
+		break;
+	case MES_MISC_OP_WRITE_REG:
+		misc_pkt.opcode = MESAPI_MISC__WRITE_REG;
+		misc_pkt.write_reg.reg_offset = input->write_reg.reg_offset;
+		misc_pkt.write_reg.reg_value = input->write_reg.reg_value;
+		break;
+	case MES_MISC_OP_WRM_REG_WAIT:
+		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
+		misc_pkt.wait_reg_mem.op = WRM_OPERATION__WAIT_REG_MEM;
+		misc_pkt.wait_reg_mem.reference = input->wrm_reg.ref;
+		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
+		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
+		misc_pkt.wait_reg_mem.reg_offset2 = 0;
+		break;
+	case MES_MISC_OP_WRM_REG_WR_WAIT:
+		misc_pkt.opcode = MESAPI_MISC__WAIT_REG_MEM;
+		misc_pkt.wait_reg_mem.op = WRM_OPERATION__WR_WAIT_WR_REG;
+		misc_pkt.wait_reg_mem.reference = input->wrm_reg.ref;
+		misc_pkt.wait_reg_mem.mask = input->wrm_reg.mask;
+		misc_pkt.wait_reg_mem.reg_offset1 = input->wrm_reg.reg0;
+		misc_pkt.wait_reg_mem.reg_offset2 = input->wrm_reg.reg1;
+		break;
+	case MES_MISC_OP_SET_SHADER_DEBUGGER:
+		pipe = AMDGPU_MES_SCHED_PIPE;
+		misc_pkt.opcode = MESAPI_MISC__SET_SHADER_DEBUGGER;
+		misc_pkt.set_shader_debugger.process_context_addr =
+				input->set_shader_debugger.process_context_addr;
+		misc_pkt.set_shader_debugger.flags.u32all =
+				input->set_shader_debugger.flags.u32all;
+		misc_pkt.set_shader_debugger.spi_gdbg_per_vmid_cntl =
+				input->set_shader_debugger.spi_gdbg_per_vmid_cntl;
+		memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
+				input->set_shader_debugger.tcp_watch_cntl,
+				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
+		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
+		break;
+	case MES_MISC_OP_CHANGE_CONFIG:
+		misc_pkt.opcode = MESAPI_MISC__CHANGE_CONFIG;
+		misc_pkt.change_config.opcode =
+				MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS;
+		misc_pkt.change_config.option.bits.limit_single_process =
+				input->change_config.option.limit_single_process;
+		break;
+
+	default:
+		DRM_ERROR("unsupported misc op (%d) \n", input->op);
+		return -EINVAL;
+	}
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes, pipe,
+			&misc_pkt, sizeof(misc_pkt),
+			offsetof(union MESAPI__MISC, api_status));
+}
+
+static int mes_v13_0_set_hw_resources_1(struct amdgpu_mes *mes, int pipe)
+{
+	union MESAPI_SET_HW_RESOURCES_1 mes_set_hw_res_1_pkt;
+	int i;
+
+	memset(&mes_set_hw_res_1_pkt, 0, sizeof(mes_set_hw_res_1_pkt));
+
+	mes_set_hw_res_1_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_set_hw_res_1_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC_1;
+	mes_set_hw_res_1_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+	mes_set_hw_res_1_pkt.mes_kiq_unmap_timeout = 0xa;
+
+	for (i = 0; i < MAX_SDMA_PIPES_13_0; i++)
+		mes_set_hw_res_1_pkt.sdma_hqd_mask[i] =
+			mes->sdma_hqd_mask[i];
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_set_hw_res_1_pkt, sizeof(mes_set_hw_res_1_pkt),
+			offsetof(union MESAPI_SET_HW_RESOURCES_1, api_status));
+}
+
+static int mes_v13_0_set_hw_resources(struct amdgpu_mes *mes, int pipe)
+{
+	int i;
+	struct amdgpu_device *adev = mes->adev;
+	union MESAPI_SET_HW_RESOURCES mes_set_hw_res_pkt;
+
+	memset(&mes_set_hw_res_pkt, 0, sizeof(mes_set_hw_res_pkt));
+
+	mes_set_hw_res_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_set_hw_res_pkt.header.opcode = MES_SCH_API_SET_HW_RSRC;
+	mes_set_hw_res_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE) {
+		mes_set_hw_res_pkt.vmid_mask_mmhub = adev->vm_manager.vmid_uq_mask_mmhub;
+		mes_set_hw_res_pkt.vmid_mask_gfxhub = adev->vm_manager.vmid_uq_mask_gfxhub;
+		mes_set_hw_res_pkt.gds_size = adev->gds.gds_size;
+		mes_set_hw_res_pkt.paging_vmid = 0;
+
+		for (i = 0; i < MAX_COMPUTE_PIPES; i++)
+			mes_set_hw_res_pkt.compute_hqd_mask[i] =
+				mes->compute_hqd_mask[i];
+
+		for (i = 0; i < MAX_GFX_PIPES; i++)
+			mes_set_hw_res_pkt.gfx_hqd_mask[i] =
+				mes->gfx_hqd_mask[i];
+
+		for (i = 0; i < AMD_PRIORITY_NUM_LEVELS; i++)
+			mes_set_hw_res_pkt.aggregated_doorbells[i] =
+				mes->aggregated_doorbells[i];
+	}
+
+	mes_set_hw_res_pkt.g_sch_ctx_gpu_mc_ptr =
+		mes->sch_ctx_gpu_addr[pipe];
+	mes_set_hw_res_pkt.query_status_fence_gpu_mc_ptr =
+		mes->query_status_fence_gpu_addr[pipe];
+
+	for (i = 0; i < 5; i++) {
+		mes_set_hw_res_pkt.gc_base[i] = adev->reg_offset[GC_HWIP][0][i];
+		mes_set_hw_res_pkt.mmhub_base[i] =
+				adev->reg_offset[MMHUB_HWIP][0][i];
+		mes_set_hw_res_pkt.osssys_base[i] =
+		adev->reg_offset[OSSSYS_HWIP][0][i];
+	}
+
+	mes_set_hw_res_pkt.disable_reset = 1;
+	mes_set_hw_res_pkt.disable_mes_log = 1;
+	mes_set_hw_res_pkt.use_different_vmid_compute = 1;
+	mes_set_hw_res_pkt.enable_reg_active_poll = 1;
+	mes_set_hw_res_pkt.enable_level_process_quantum_check = 1;
+
+	/*
+	 * Keep oversubscribe timer for sdma . When we have unmapped doorbell
+	 * handling support, other queue will not use the oversubscribe timer.
+	 * handling  mode - 0: disabled; 1: basic version; 2: basic+ version
+	 */
+	mes_set_hw_res_pkt.oversubscription_timer = 50;
+
+	mes_set_hw_res_pkt.unmapped_doorbell_handling = 1;
+
+	if (amdgpu_mes_log_enable) {
+		mes_set_hw_res_pkt.enable_mes_event_int_logging = 1;
+		mes_set_hw_res_pkt.event_intr_history_gpu_mc_ptr = mes->event_log_gpu_addr +
+				pipe * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE);
+	}
+
+	if (adev->enforce_isolation[0] == AMDGPU_ENFORCE_ISOLATION_ENABLE)
+		mes_set_hw_res_pkt.limit_single_process = 1;
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_set_hw_res_pkt, sizeof(mes_set_hw_res_pkt),
+			offsetof(union MESAPI_SET_HW_RESOURCES, api_status));
+}
+
+static void mes_v13_0_init_aggregated_doorbell(struct amdgpu_mes *mes)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t data;
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL1);
+	data &= ~(CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL1__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL1__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_LOW] <<
+		CP_MES_DOORBELL_CONTROL1__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL1__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL1, data);
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL2);
+	data &= ~(CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL2__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL2__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_NORMAL] <<
+		CP_MES_DOORBELL_CONTROL2__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL2__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL2, data);
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL3);
+	data &= ~(CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL3__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL3__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_MEDIUM] <<
+		CP_MES_DOORBELL_CONTROL3__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL3__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL3, data);
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL4);
+	data &= ~(CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL4__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL4__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_HIGH] <<
+		CP_MES_DOORBELL_CONTROL4__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL4__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL4, data);
+
+	data = RREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL5);
+	data &= ~(CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET_MASK |
+		  CP_MES_DOORBELL_CONTROL5__DOORBELL_EN_MASK |
+		  CP_MES_DOORBELL_CONTROL5__DOORBELL_HIT_MASK);
+	data |= mes->aggregated_doorbells[AMDGPU_MES_PRIORITY_LEVEL_REALTIME] <<
+		CP_MES_DOORBELL_CONTROL5__DOORBELL_OFFSET__SHIFT;
+	data |= 1 << CP_MES_DOORBELL_CONTROL5__DOORBELL_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_MES_DOORBELL_CONTROL5, data);
+
+	data = 1 << CP_HQD_GFX_CONTROL__DB_UPDATED_MSG_EN__SHIFT;
+	WREG32_SOC15(GC, 0, regCP_HQD_GFX_CONTROL, data);
+}
+
+
+static void mes_v13_0_enable_unmapped_doorbell_handling(
+		struct amdgpu_mes *mes, bool enable)
+{
+	struct amdgpu_device *adev = mes->adev;
+	uint32_t data = RREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL);
+
+	/*
+	 * The default PROC_LSB settng is 0xc which means doorbell
+	 * addr[16:12] gives the doorbell page number. For kfd, each
+	 * process will use 2 pages of doorbell, we need to change the
+	 * setting to 0xd
+	 */
+	data &= ~CP_UNMAPPED_DOORBELL__PROC_LSB_MASK;
+	data |= 0xd <<  CP_UNMAPPED_DOORBELL__PROC_LSB__SHIFT;
+
+	data |= (enable ? 1 : 0) << CP_UNMAPPED_DOORBELL__ENABLE__SHIFT;
+
+	WREG32_SOC15(GC, 0, regCP_UNMAPPED_DOORBELL, data);
+}
+
+static int mes_v13_0_reset_hw_queue(struct amdgpu_mes *mes,
+				    struct mes_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+	int pipe;
+
+	if (input->use_mmio)
+		return mes_v13_0_reset_queue_mmio(mes, input->queue_type,
+						  input->me_id, input->pipe_id,
+						  input->queue_id, input->vmid);
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+
+	if (input->legacy_gfx) {
+		mes_reset_queue_pkt.reset_legacy_gfx = 1;
+		mes_reset_queue_pkt.pipe_id_lp = input->pipe_id;
+		mes_reset_queue_pkt.queue_id_lp = input->queue_id;
+		mes_reset_queue_pkt.mqd_mc_addr_lp = input->mqd_addr;
+		mes_reset_queue_pkt.doorbell_offset_lp = input->doorbell_offset;
+		mes_reset_queue_pkt.wptr_addr_lp = input->wptr_addr;
+		mes_reset_queue_pkt.vmid_id_lp = input->vmid;
+	} else {
+		mes_reset_queue_pkt.reset_queue_only = 1;
+		mes_reset_queue_pkt.doorbell_offset = input->doorbell_offset;
+	}
+
+	if (input->is_kq)
+		pipe = AMDGPU_MES_KIQ_PIPE;
+	else
+		pipe = AMDGPU_MES_SCHED_PIPE;
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes, pipe,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
+static int mes_v13_0_detect_and_reset_hung_queues(struct amdgpu_mes *mes,
+						  struct mes_detect_and_reset_queue_input *input)
+{
+	union MESAPI__RESET mes_reset_queue_pkt;
+
+	memset(&mes_reset_queue_pkt, 0, sizeof(mes_reset_queue_pkt));
+
+	mes_reset_queue_pkt.header.type = MES_API_TYPE_SCHEDULER;
+	mes_reset_queue_pkt.header.opcode = MES_SCH_API_RESET;
+	mes_reset_queue_pkt.header.dwsize = API_FRAME_SIZE_IN_DWORDS;
+
+	mes_reset_queue_pkt.queue_type =
+		convert_to_mes_queue_type(input->queue_type);
+	mes_reset_queue_pkt.doorbell_offset_addr =
+		mes->hung_queue_db_array_gpu_addr[0];
+
+	if (input->detect_only)
+		mes_reset_queue_pkt.hang_detect_only = 1;
+	else
+		mes_reset_queue_pkt.hang_detect_then_reset = 1;
+
+	return mes_v13_0_submit_pkt_and_poll_completion(mes, AMDGPU_MES_SCHED_PIPE,
+			&mes_reset_queue_pkt, sizeof(mes_reset_queue_pkt),
+			offsetof(union MESAPI__RESET, api_status));
+}
+
+static const struct amdgpu_mes_funcs mes_v13_0_funcs = {
+	.add_hw_queue = mes_v13_0_add_hw_queue,
+	.remove_hw_queue = mes_v13_0_remove_hw_queue,
+	.map_legacy_queue = mes_v13_0_map_legacy_queue,
+	.unmap_legacy_queue = mes_v13_0_unmap_legacy_queue,
+	.suspend_gang = mes_v13_0_suspend_gang,
+	.resume_gang = mes_v13_0_resume_gang,
+	.misc_op = mes_v13_0_misc_op,
+	.reset_hw_queue = mes_v13_0_reset_hw_queue,
+	.detect_and_reset_hung_queues = mes_v13_0_detect_and_reset_hung_queues,
+};
+
+static int mes_v13_0_allocate_ucode_buffer(struct amdgpu_device *adev,
+					   enum amdgpu_mes_pipe pipe)
+{
+	int r;
+	const struct mes_firmware_header_v1_0 *mes_hdr;
+	const __le32 *fw_data;
+	unsigned fw_size;
+
+	mes_hdr = (const struct mes_firmware_header_v1_0 *)
+		adev->mes.fw[pipe]->data;
+
+	fw_data = (const __le32 *)(adev->mes.fw[pipe]->data +
+		   le32_to_cpu(mes_hdr->mes_ucode_offset_bytes));
+	fw_size = le32_to_cpu(mes_hdr->mes_ucode_size_bytes);
+
+	r = amdgpu_bo_create_reserved(adev, fw_size,
+				      PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->mes.ucode_fw_obj[pipe],
+				      &adev->mes.ucode_fw_gpu_addr[pipe],
+				      (void **)&adev->mes.ucode_fw_ptr[pipe]);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create mes fw bo\n", r);
+		return r;
+	}
+
+	memcpy(adev->mes.ucode_fw_ptr[pipe], fw_data, fw_size);
+
+	amdgpu_bo_kunmap(adev->mes.ucode_fw_obj[pipe]);
+	amdgpu_bo_unreserve(adev->mes.ucode_fw_obj[pipe]);
+
+	return 0;
+}
+
+static int mes_v13_0_allocate_ucode_data_buffer(struct amdgpu_device *adev,
+						enum amdgpu_mes_pipe pipe)
+{
+	int r;
+	const struct mes_firmware_header_v1_0 *mes_hdr;
+	const __le32 *fw_data;
+	unsigned fw_size;
+
+	mes_hdr = (const struct mes_firmware_header_v1_0 *)
+		adev->mes.fw[pipe]->data;
+
+	fw_data = (const __le32 *)(adev->mes.fw[pipe]->data +
+		   le32_to_cpu(mes_hdr->mes_ucode_data_offset_bytes));
+	fw_size = le32_to_cpu(mes_hdr->mes_ucode_data_size_bytes);
+
+	r = amdgpu_bo_create_reserved(adev, fw_size,
+				      64 * 1024,
+				      AMDGPU_GEM_DOMAIN_VRAM,
+				      &adev->mes.data_fw_obj[pipe],
+				      &adev->mes.data_fw_gpu_addr[pipe],
+				      (void **)&adev->mes.data_fw_ptr[pipe]);
+	if (r) {
+		dev_err(adev->dev, "(%d) failed to create mes data fw bo\n", r);
+		return r;
+	}
+
+	memcpy(adev->mes.data_fw_ptr[pipe], fw_data, fw_size);
+
+	amdgpu_bo_kunmap(adev->mes.data_fw_obj[pipe]);
+	amdgpu_bo_unreserve(adev->mes.data_fw_obj[pipe]);
+
+	return 0;
+}
+
+static void mes_v13_0_free_ucode_buffers(struct amdgpu_device *adev,
+					 enum amdgpu_mes_pipe pipe)
+{
+	amdgpu_bo_free_kernel(&adev->mes.data_fw_obj[pipe],
+			      &adev->mes.data_fw_gpu_addr[pipe],
+			      (void **)&adev->mes.data_fw_ptr[pipe]);
+
+	amdgpu_bo_free_kernel(&adev->mes.ucode_fw_obj[pipe],
+			      &adev->mes.ucode_fw_gpu_addr[pipe],
+			      (void **)&adev->mes.ucode_fw_ptr[pipe]);
+}
+
+static void mes_v13_0_enable(struct amdgpu_device *adev, bool enable)
+{
+	uint64_t ucode_addr;
+	uint32_t pipe, data = 0;
+
+	if (enable) {
+		mutex_lock(&adev->srbm_mutex);
+		for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+			soc_v2_0_grbm_select(adev, 3, pipe, 0, 0);
+			if (amdgpu_mes_log_enable) {
+				u32 log_size = AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE;
+				/* In case uni mes is not enabled, only program for pipe 0 */
+				if (adev->mes.event_log_size >= (pipe + 1) * log_size) {
+					WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO,
+						     lower_32_bits(adev->mes.event_log_gpu_addr +
+						     pipe * log_size + AMDGPU_MES_LOG_BUFFER_SIZE));
+					WREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI,
+						     upper_32_bits(adev->mes.event_log_gpu_addr +
+						     pipe * log_size + AMDGPU_MES_LOG_BUFFER_SIZE));
+					dev_info(adev->dev, "Setup CP MES MSCRATCH address : 0x%x. 0x%x\n",
+						 RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_HI),
+						 RREG32_SOC15(GC, 0, regCP_MES_MSCRATCH_LO));
+				}
+			}
+
+			data = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
+			if (pipe == 0)
+				data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
+			else
+				data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET, 1);
+			WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
+
+			ucode_addr = adev->mes.uc_start_addr[pipe] >> 2;
+			WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START,
+				     lower_32_bits(ucode_addr));
+			WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START_HI,
+				     upper_32_bits(ucode_addr));
+
+			/* unhalt MES and activate one pipe each loop */
+			data = REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE, 1);
+			if (pipe)
+				data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE, 1);
+			dev_info(adev->dev, "program CP_MES_CNTL : 0x%x\n", data);
+
+			WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
+
+		}
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+
+		if (amdgpu_emu_mode)
+			msleep(100);
+		else if (adev->enable_uni_mes)
+			udelay(500);
+		else
+			udelay(50);
+	} else {
+		data = RREG32_SOC15(GC, 0, regCP_MES_CNTL);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACTIVE, 0);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE, 0);
+		data = REG_SET_FIELD(data, CP_MES_CNTL,
+				     MES_INVALIDATE_ICACHE, 1);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET, 1);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_HALT, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_CNTL, data);
+	}
+}
+
+static void mes_v13_0_set_ucode_start_addr(struct amdgpu_device *adev)
+{
+	uint64_t ucode_addr;
+	int pipe;
+
+	mes_v13_0_enable(adev, false);
+
+	mutex_lock(&adev->srbm_mutex);
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		/* me=3, queue=0 */
+		soc_v2_0_grbm_select(adev, 3, pipe, 0, 0);
+
+		/* set ucode start address */
+		ucode_addr = adev->mes.uc_start_addr[pipe] >> 2;
+		WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START,
+				lower_32_bits(ucode_addr));
+		WREG32_SOC15(GC, 0, regCP_MES_PRGRM_CNTR_START_HI,
+				upper_32_bits(ucode_addr));
+
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	}
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+/* This function is for backdoor MES firmware */
+static int mes_v13_0_load_microcode(struct amdgpu_device *adev,
+				    enum amdgpu_mes_pipe pipe, bool prime_icache)
+{
+	int r;
+	uint32_t data;
+
+	mes_v13_0_enable(adev, false);
+
+	if (!adev->mes.fw[pipe])
+		return -EINVAL;
+
+	r = mes_v13_0_allocate_ucode_buffer(adev, pipe);
+	if (r)
+		return r;
+
+	r = mes_v13_0_allocate_ucode_data_buffer(adev, pipe);
+	if (r) {
+		mes_v13_0_free_ucode_buffers(adev, pipe);
+		return r;
+	}
+
+	mutex_lock(&adev->srbm_mutex);
+	/* me=3, pipe=0, queue=0 */
+	soc_v2_0_grbm_select(adev, 3, pipe, 0, 0);
+
+	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_CNTL, 0);
+
+	/* set ucode fimrware address */
+	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_LO,
+		     lower_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
+	WREG32_SOC15(GC, 0, regCP_MES_IC_BASE_HI,
+		     upper_32_bits(adev->mes.ucode_fw_gpu_addr[pipe]));
+
+	/* set ucode instruction cache boundary to 2M-1 */
+	WREG32_SOC15(GC, 0, regCP_MES_MIBOUND_LO, 0x1FFFFF);
+
+	/* set ucode data firmware address */
+	WREG32_SOC15(GC, 0, regCP_MES_MDBASE_LO,
+		     lower_32_bits(adev->mes.data_fw_gpu_addr[pipe]));
+	WREG32_SOC15(GC, 0, regCP_MES_MDBASE_HI,
+		     upper_32_bits(adev->mes.data_fw_gpu_addr[pipe]));
+
+	/* Set data cache boundary CP_MES_MDBOUND_LO */
+	WREG32_SOC15(GC, 0, regCP_MES_MDBOUND_LO, 0x7FFFF);
+
+	if (prime_icache) {
+		/* invalidate ICACHE */
+		data = RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+		data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
+		data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+
+		/* prime the ICACHE. */
+		data = RREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL);
+		data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
+		WREG32_SOC15(GC, 0, regCP_MES_IC_OP_CNTL, data);
+	}
+
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return 0;
+}
+
+static int mes_v13_0_allocate_eop_buf(struct amdgpu_device *adev,
+				      enum amdgpu_mes_pipe pipe)
+{
+	int r;
+	u32 *eop;
+
+	r = amdgpu_bo_create_reserved(adev, MES_EOP_SIZE, PAGE_SIZE,
+			      AMDGPU_GEM_DOMAIN_GTT,
+			      &adev->mes.eop_gpu_obj[pipe],
+			      &adev->mes.eop_gpu_addr[pipe],
+			      (void **)&eop);
+	if (r) {
+		dev_warn(adev->dev, "(%d) create EOP bo failed\n", r);
+		return r;
+	}
+
+	memset(eop, 0,
+	       adev->mes.eop_gpu_obj[pipe]->tbo.base.size);
+
+	amdgpu_bo_kunmap(adev->mes.eop_gpu_obj[pipe]);
+	amdgpu_bo_unreserve(adev->mes.eop_gpu_obj[pipe]);
+
+	return 0;
+}
+
+static int mes_v13_0_mqd_init(struct amdgpu_ring *ring)
+{
+	struct v13_mes_mqd *mqd = ring->mqd_ptr;
+	uint64_t hqd_gpu_addr, wb_gpu_addr, eop_base_addr;
+	uint32_t tmp;
+
+	mqd->header = 0xC0310800;
+	mqd->compute_pipelinestat_enable = 0x00000001;
+	mqd->compute_static_thread_mgmt_se0 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se1 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se2 = 0xffffffff;
+	mqd->compute_static_thread_mgmt_se3 = 0xffffffff;
+	mqd->compute_misc_reserved = 0x00000007;
+
+	eop_base_addr = ring->eop_gpu_addr >> 8;
+
+	/* set the EOP size, register value is 2^(EOP_SIZE+1) dwords */
+	tmp = regCP_HQD_EOP_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_EOP_CONTROL, EOP_SIZE,
+			(order_base_2(MES_EOP_SIZE / 4) - 1));
+
+	mqd->cp_hqd_eop_base_addr_lo = lower_32_bits(eop_base_addr);
+	mqd->cp_hqd_eop_base_addr_hi = upper_32_bits(eop_base_addr);
+	mqd->cp_hqd_eop_control = tmp;
+
+	/* disable the queue if it's active */
+	ring->wptr = 0;
+	mqd->cp_hqd_pq_rptr = 0;
+	mqd->cp_hqd_pq_wptr_lo = 0;
+	mqd->cp_hqd_pq_wptr_hi = 0;
+
+	/* set the pointer to the MQD */
+	mqd->cp_mqd_base_addr_lo = ring->mqd_gpu_addr & 0xfffffffc;
+	mqd->cp_mqd_base_addr_hi = upper_32_bits(ring->mqd_gpu_addr);
+
+	/* set MQD vmid to 0 */
+	tmp = regCP_MQD_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_MQD_CONTROL, VMID, 0);
+	mqd->cp_mqd_control = tmp;
+
+	/* set the pointer to the HQD, this is similar CP_RB0_BASE/_HI */
+	hqd_gpu_addr = ring->gpu_addr >> 8;
+	mqd->cp_hqd_pq_base_lo = lower_32_bits(hqd_gpu_addr);
+	mqd->cp_hqd_pq_base_hi = upper_32_bits(hqd_gpu_addr);
+
+	/* set the wb address whether it's enabled or not */
+	wb_gpu_addr = ring->rptr_gpu_addr;
+	mqd->cp_hqd_pq_rptr_report_addr_lo = wb_gpu_addr & 0xfffffffc;
+	mqd->cp_hqd_pq_rptr_report_addr_hi =
+		upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	/* only used if CP_PQ_WPTR_POLL_CNTL.CP_PQ_WPTR_POLL_CNTL__EN_MASK=1 */
+	wb_gpu_addr = ring->wptr_gpu_addr;
+	mqd->cp_hqd_pq_wptr_poll_addr_lo = wb_gpu_addr & 0xfffffff8;
+	mqd->cp_hqd_pq_wptr_poll_addr_hi = upper_32_bits(wb_gpu_addr) & 0xffff;
+
+	/* set up the HQD, this is similar to CP_RB0_CNTL */
+	tmp = regCP_HQD_PQ_CONTROL_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, QUEUE_SIZE,
+			    (order_base_2(ring->ring_size / 4) - 1));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
+			    ((order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1) << 8));
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, 1);
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, NO_UPDATE_RPTR, 1);
+	mqd->cp_hqd_pq_control = tmp;
+
+	/* enable doorbell */
+	tmp = 0;
+	if (ring->use_doorbell) {
+		tmp = REG_SET_FIELD(tmp, CP_HQD_PQ_DOORBELL_CONTROL,
+				    DOORBELL_OFFSET, ring->doorbell_index);
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
+	mqd->cp_hqd_pq_doorbell_control = tmp;
+
+	mqd->cp_hqd_vmid = 0;
+	/* activate the queue */
+	mqd->cp_hqd_active = 1;
+
+	tmp = regCP_HQD_PERSISTENT_STATE_DEFAULT;
+	tmp = REG_SET_FIELD(tmp, CP_HQD_PERSISTENT_STATE,
+			    PRELOAD_SIZE, 0x55);
+	mqd->cp_hqd_persistent_state = tmp;
+
+	mqd->cp_hqd_ib_control = regCP_HQD_IB_CONTROL_DEFAULT;
+	mqd->cp_hqd_iq_timer = regCP_HQD_IQ_TIMER_DEFAULT;
+	mqd->cp_hqd_quantum = regCP_HQD_QUANTUM_DEFAULT;
+
+	mqd->cp_hqd_suspend_cntl_stack_offset = BIT(15);
+
+	return 0;
+}
+
+static void mes_v13_0_queue_init_register(struct amdgpu_ring *ring)
+{
+	struct v13_mes_mqd *mqd = ring->mqd_ptr;
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t data = 0;
+
+	mutex_lock(&adev->srbm_mutex);
+	soc_v2_0_grbm_select(adev, 3, ring->pipe, 0, 0);
+
+	/* set CP_HQD_VMID.VMID = 0. */
+	data = RREG32_SOC15(GC, 0, regCP_HQD_VMID);
+	data = REG_SET_FIELD(data, CP_HQD_VMID, VMID, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_VMID, data);
+
+	/* set CP_HQD_PQ_DOORBELL_CONTROL.DOORBELL_EN=0 */
+	data = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+			     DOORBELL_EN, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
+
+	/* set CP_MQD_BASE_ADDR/HI with the MQD base address */
+	WREG32_SOC15(GC, 0, regCP_MQD_BASE_ADDR, mqd->cp_mqd_base_addr_lo);
+	WREG32_SOC15(GC, 0, regCP_MQD_BASE_ADDR_HI, mqd->cp_mqd_base_addr_hi);
+
+	/* set CP_MQD_CONTROL.VMID=0 */
+	data = RREG32_SOC15(GC, 0, regCP_MQD_CONTROL);
+	data = REG_SET_FIELD(data, CP_MQD_CONTROL, VMID, 0);
+	WREG32_SOC15(GC, 0, regCP_MQD_CONTROL, 0);
+
+	/* set CP_HQD_PQ_BASE/HI with the ring buffer base address */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE, mqd->cp_hqd_pq_base_lo);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE_HI, mqd->cp_hqd_pq_base_hi);
+
+	/* set CP_HQD_PQ_RPTR_REPORT_ADDR/HI */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR_REPORT_ADDR,
+		     mqd->cp_hqd_pq_rptr_report_addr_lo);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR_REPORT_ADDR_HI,
+		     mqd->cp_hqd_pq_rptr_report_addr_hi);
+
+	/* set CP_HQD_PQ_CONTROL */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_CONTROL, mqd->cp_hqd_pq_control);
+
+	/* set CP_HQD_PQ_WPTR_POLL_ADDR/HI */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR,
+		     mqd->cp_hqd_pq_wptr_poll_addr_lo);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI,
+		     mqd->cp_hqd_pq_wptr_poll_addr_hi);
+
+	/* set CP_HQD_PQ_DOORBELL_CONTROL */
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL,
+		     mqd->cp_hqd_pq_doorbell_control);
+
+	/* set CP_HQD_PERSISTENT_STATE.PRELOAD_SIZE=0x53 */
+	WREG32_SOC15(GC, 0, regCP_HQD_PERSISTENT_STATE, mqd->cp_hqd_persistent_state);
+
+	/* set CP_HQD_ACTIVE.ACTIVE=1 */
+	WREG32_SOC15(GC, 0, regCP_HQD_ACTIVE, mqd->cp_hqd_active);
+
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
+static int mes_v13_0_kiq_enable_queue(struct amdgpu_device *adev)
+{
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq[0];
+	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[0].ring;
+	int r;
+
+	if (!kiq->pmf || !kiq->pmf->kiq_map_queues)
+		return -EINVAL;
+
+	r = amdgpu_ring_alloc(kiq_ring, kiq->pmf->map_queues_size);
+	if (r) {
+		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
+		return r;
+	}
+
+	kiq->pmf->kiq_map_queues(kiq_ring, &adev->mes.ring[0]);
+
+	r = amdgpu_ring_test_ring(kiq_ring);
+	if (r) {
+		DRM_ERROR("kfq enable failed\n");
+		kiq_ring->sched.ready = false;
+	}
+	return r;
+}
+
+static int mes_v13_0_queue_init(struct amdgpu_device *adev,
+				enum amdgpu_mes_pipe pipe)
+{
+	struct amdgpu_ring *ring;
+	int r;
+
+	if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
+		ring = &adev->gfx.kiq[0].ring;
+	else
+		ring = &adev->mes.ring[pipe];
+
+	if ((adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) &&
+	    (amdgpu_in_reset(adev) || adev->in_suspend)) {
+		*(ring->wptr_cpu_addr) = 0;
+		*(ring->rptr_cpu_addr) = 0;
+		amdgpu_ring_clear_ring(ring);
+	}
+
+	r = mes_v13_0_mqd_init(ring);
+	if (r)
+		return r;
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE) {
+		if (adev->enable_uni_mes)
+			r = amdgpu_mes_map_legacy_queue(adev, ring, 0);
+		else
+			r = mes_v13_0_kiq_enable_queue(adev);
+		if (r)
+			return r;
+	} else {
+		mes_v13_0_queue_init_register(ring);
+	}
+
+	if (((pipe == AMDGPU_MES_SCHED_PIPE) && !adev->mes.sched_version) ||
+	    ((pipe == AMDGPU_MES_KIQ_PIPE) && !adev->mes.kiq_version)) {
+		/* get MES scheduler/KIQ versions */
+		mutex_lock(&adev->srbm_mutex);
+		soc_v2_0_grbm_select(adev, 3, pipe, 0, 0);
+
+		if (pipe == AMDGPU_MES_SCHED_PIPE)
+			adev->mes.sched_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+		else if (pipe == AMDGPU_MES_KIQ_PIPE && adev->enable_mes_kiq)
+			adev->mes.kiq_version = RREG32_SOC15(GC, 0, regCP_MES_GP3_LO);
+
+		soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+	}
+
+	return 0;
+}
+
+static int mes_v13_0_ring_init(struct amdgpu_device *adev, int pipe)
+{
+	struct amdgpu_ring *ring;
+
+	ring = &adev->mes.ring[pipe];
+
+	ring->funcs = &mes_v13_0_ring_funcs;
+
+	ring->me = 3;
+	ring->pipe = pipe;
+	ring->queue = 0;
+
+	ring->ring_obj = NULL;
+	ring->use_doorbell = true;
+	ring->eop_gpu_addr = adev->mes.eop_gpu_addr[pipe];
+	ring->no_scheduler = true;
+	sprintf(ring->name, "mes_%d.%d.%d", ring->me, ring->pipe, ring->queue);
+
+	if (pipe == AMDGPU_MES_SCHED_PIPE)
+		ring->doorbell_index = adev->doorbell_index.mes_ring0 << 1;
+	else
+		ring->doorbell_index = adev->doorbell_index.mes_ring1 << 1;
+
+	return amdgpu_ring_init(adev, ring, 1024, NULL, 0,
+				AMDGPU_RING_PRIO_DEFAULT, NULL);
+}
+
+static int mes_v13_0_kiq_ring_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+
+	spin_lock_init(&adev->gfx.kiq[0].ring_lock);
+
+	ring = &adev->gfx.kiq[0].ring;
+
+	ring->me = 3;
+	ring->pipe = 1;
+	ring->queue = 0;
+
+	ring->adev = NULL;
+	ring->ring_obj = NULL;
+	ring->use_doorbell = true;
+	ring->doorbell_index = adev->doorbell_index.mes_ring1 << 1;
+	ring->eop_gpu_addr = adev->mes.eop_gpu_addr[AMDGPU_MES_KIQ_PIPE];
+	ring->no_scheduler = true;
+	sprintf(ring->name, "mes_kiq_%d.%d.%d",
+		ring->me, ring->pipe, ring->queue);
+
+	return amdgpu_ring_init(adev, ring, 1024, NULL, 0,
+				AMDGPU_RING_PRIO_DEFAULT, NULL);
+}
+
+static int mes_v13_0_mqd_sw_init(struct amdgpu_device *adev,
+				 enum amdgpu_mes_pipe pipe)
+{
+	int r, mqd_size = sizeof(struct v13_mes_mqd);
+	struct amdgpu_ring *ring;
+
+	if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE)
+		ring = &adev->gfx.kiq[0].ring;
+	else
+		ring = &adev->mes.ring[pipe];
+
+	if (ring->mqd_obj)
+		return 0;
+
+	r = amdgpu_bo_create_kernel(adev, mqd_size, PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
+				    &ring->mqd_gpu_addr, &ring->mqd_ptr);
+	if (r) {
+		dev_warn(adev->dev, "failed to create ring mqd bo (%d)", r);
+		return r;
+	}
+
+	memset(ring->mqd_ptr, 0, mqd_size);
+
+	/* prepare MQD backup */
+	adev->mes.mqd_backup[pipe] = kmalloc(mqd_size, GFP_KERNEL);
+	if (!adev->mes.mqd_backup[pipe])
+		dev_warn(adev->dev,
+			 "no memory to create MQD backup for ring %s\n",
+			 ring->name);
+
+	return 0;
+}
+
+static int mes_v13_0_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int pipe, r;
+
+	adev->mes.funcs = &mes_v13_0_funcs;
+	adev->mes.kiq_hw_init = &mes_v13_0_kiq_hw_init;
+	adev->mes.kiq_hw_fini = &mes_v13_0_kiq_hw_fini;
+	adev->mes.enable_legacy_queue_map = !!adev->enable_uni_mes;
+
+	adev->mes.event_log_size = adev->enable_uni_mes ?
+		(AMDGPU_MAX_MES_PIPES * (AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE)) :
+		(AMDGPU_MES_LOG_BUFFER_SIZE + AMDGPU_MES_MSCRATCH_SIZE);
+	r = amdgpu_mes_init(adev);
+	if (r)
+		return r;
+
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		r = mes_v13_0_allocate_eop_buf(adev, pipe);
+		if (r)
+			return r;
+
+		r = mes_v13_0_mqd_sw_init(adev, pipe);
+		if (r)
+			return r;
+
+		if (!adev->enable_uni_mes && pipe == AMDGPU_MES_KIQ_PIPE) {
+			r = mes_v13_0_kiq_ring_init(adev);
+		}
+		else {
+			r = mes_v13_0_ring_init(adev, pipe);
+			if (r)
+				return r;
+			r = amdgpu_bo_create_kernel(adev, AMDGPU_GPU_PAGE_SIZE, PAGE_SIZE,
+						    AMDGPU_GEM_DOMAIN_VRAM,
+						    &adev->mes.resource_1[pipe],
+						    &adev->mes.resource_1_gpu_addr[pipe],
+						    &adev->mes.resource_1_addr[pipe]);
+			if (r) {
+				dev_err(adev->dev, "(%d) failed to create mes resource_1 bo pipe[%d]\n", r, pipe);
+				return r;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int mes_v13_0_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int pipe;
+
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		amdgpu_bo_free_kernel(&adev->mes.resource_1[pipe],
+				      &adev->mes.resource_1_gpu_addr[pipe],
+				      &adev->mes.resource_1_addr[pipe]);
+
+		kfree(adev->mes.mqd_backup[pipe]);
+
+		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
+				      &adev->mes.eop_gpu_addr[pipe],
+				      NULL);
+		amdgpu_ucode_release(&adev->mes.fw[pipe]);
+
+		if (adev->enable_uni_mes || pipe == AMDGPU_MES_SCHED_PIPE) {
+			amdgpu_bo_free_kernel(&adev->mes.ring[pipe].mqd_obj,
+					      &adev->mes.ring[pipe].mqd_gpu_addr,
+					      &adev->mes.ring[pipe].mqd_ptr);
+			amdgpu_ring_fini(&adev->mes.ring[pipe]);
+		}
+	}
+
+	if (!adev->enable_uni_mes) {
+		amdgpu_bo_free_kernel(&adev->gfx.kiq[0].ring.mqd_obj,
+				      &adev->gfx.kiq[0].ring.mqd_gpu_addr,
+				      &adev->gfx.kiq[0].ring.mqd_ptr);
+		amdgpu_ring_fini(&adev->gfx.kiq[0].ring);
+	}
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		mes_v13_0_free_ucode_buffers(adev, AMDGPU_MES_KIQ_PIPE);
+		mes_v13_0_free_ucode_buffers(adev, AMDGPU_MES_SCHED_PIPE);
+	}
+
+	amdgpu_mes_fini(adev);
+	return 0;
+}
+
+static void mes_v13_0_kiq_dequeue_sched(struct amdgpu_device *adev)
+{
+	uint32_t data;
+	int i;
+
+	mutex_lock(&adev->srbm_mutex);
+	soc_v2_0_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
+
+	/* disable the queue if it's active */
+	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
+		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
+		for (i = 0; i < adev->usec_timeout; i++) {
+			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
+				break;
+			udelay(1);
+		}
+	}
+	data = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_EN, 0);
+	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
+				DOORBELL_HIT, 1);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
+
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
+	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
+
+	soc_v2_0_grbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	adev->mes.ring[0].sched.ready = false;
+}
+
+static void mes_v13_0_kiq_setting(struct amdgpu_ring *ring)
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
+static int mes_v13_0_kiq_hw_init(struct amdgpu_device *adev, uint32_t xcc_id)
+{
+	int r = 0;
+	struct amdgpu_ip_block *ip_block;
+
+	if (adev->enable_uni_mes)
+		mes_v13_0_kiq_setting(&adev->mes.ring[AMDGPU_MES_KIQ_PIPE]);
+	else
+		mes_v13_0_kiq_setting(&adev->gfx.kiq[0].ring);
+
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+
+		r = mes_v13_0_load_microcode(adev, AMDGPU_MES_SCHED_PIPE, false);
+		if (r) {
+			DRM_ERROR("failed to load MES fw, r=%d\n", r);
+			return r;
+		}
+
+		r = mes_v13_0_load_microcode(adev, AMDGPU_MES_KIQ_PIPE, true);
+		if (r) {
+			DRM_ERROR("failed to load MES kiq fw, r=%d\n", r);
+			return r;
+		}
+
+		mes_v13_0_set_ucode_start_addr(adev);
+
+	} else if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO)
+		mes_v13_0_set_ucode_start_addr(adev);
+
+	mes_v13_0_enable(adev, true);
+
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_MES);
+	if (unlikely(!ip_block)) {
+		dev_err(adev->dev, "Failed to get MES handle\n");
+		return -EINVAL;
+	}
+
+	r = mes_v13_0_queue_init(adev, AMDGPU_MES_KIQ_PIPE);
+	if (r)
+		goto failure;
+
+	if (adev->enable_uni_mes) {
+		r = mes_v13_0_set_hw_resources(&adev->mes, AMDGPU_MES_KIQ_PIPE);
+		if (r)
+			goto failure;
+
+		mes_v13_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_KIQ_PIPE);
+	}
+
+	if (adev->mes.enable_legacy_queue_map) {
+		r = mes_v13_0_hw_init(ip_block);
+		if (r)
+			goto failure;
+	}
+
+	return r;
+
+failure:
+	mes_v13_0_hw_fini(ip_block);
+	return r;
+}
+
+static int mes_v13_0_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id)
+{
+	if (adev->mes.ring[0].sched.ready) {
+		if (adev->enable_uni_mes)
+			amdgpu_mes_unmap_legacy_queue(adev,
+				      &adev->mes.ring[AMDGPU_MES_SCHED_PIPE],
+				      RESET_QUEUES, 0, 0, 0);
+		else
+			mes_v13_0_kiq_dequeue_sched(adev);
+
+		adev->mes.ring[0].sched.ready = false;
+	}
+
+	mes_v13_0_enable(adev, false);
+
+	return 0;
+}
+
+static int mes_v13_0_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+	struct amdgpu_device *adev = ip_block->adev;
+
+	if (adev->mes.ring[0].sched.ready)
+		goto out;
+
+	if (!adev->enable_mes_kiq) {
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			r = mes_v13_0_load_microcode(adev,
+					     AMDGPU_MES_SCHED_PIPE, true);
+			if (r) {
+				DRM_ERROR("failed to MES fw, r=%d\n", r);
+				return r;
+			}
+
+			mes_v13_0_set_ucode_start_addr(adev);
+
+		} else if (adev->firmware.load_type ==
+			   AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
+
+			mes_v13_0_set_ucode_start_addr(adev);
+		}
+
+		mes_v13_0_enable(adev, true);
+	}
+
+	/* Enable the MES to handle doorbell ring on unmapped queue */
+	mes_v13_0_enable_unmapped_doorbell_handling(&adev->mes, true);
+
+	r = mes_v13_0_queue_init(adev, AMDGPU_MES_SCHED_PIPE);
+	if (r)
+		goto failure;
+
+	r = mes_v13_0_set_hw_resources(&adev->mes, AMDGPU_MES_SCHED_PIPE);
+	if (r)
+		goto failure;
+
+	if ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x4b)
+		mes_v13_0_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE);
+
+	mes_v13_0_init_aggregated_doorbell(&adev->mes);
+
+	r = mes_v13_0_query_sched_status(&adev->mes, AMDGPU_MES_SCHED_PIPE);
+	if (r) {
+		DRM_ERROR("MES is busy\n");
+		goto failure;
+	}
+
+	r = amdgpu_mes_update_enforce_isolation(adev);
+	if (r)
+		goto failure;
+
+out:
+	/*
+	 * Disable KIQ ring usage from the driver once MES is enabled.
+	 * MES uses KIQ ring exclusively so driver cannot access KIQ ring
+	 * with MES enabled.
+	 */
+	adev->gfx.kiq[0].ring.sched.ready = false;
+	adev->mes.ring[0].sched.ready = true;
+
+	return 0;
+
+failure:
+	mes_v13_0_hw_fini(ip_block);
+	return r;
+}
+
+static int mes_v13_0_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	return 0;
+}
+
+static int mes_v13_0_suspend(struct amdgpu_ip_block *ip_block)
+{
+	return mes_v13_0_hw_fini(ip_block);
+}
+
+static int mes_v13_0_resume(struct amdgpu_ip_block *ip_block)
+{
+	return mes_v13_0_hw_init(ip_block);
+}
+
+static int mes_v13_0_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int pipe, r;
+
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		r = amdgpu_mes_init_microcode(adev, pipe);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static const struct amd_ip_funcs mes_v13_0_ip_funcs = {
+	.name = "mes_v13_0",
+	.early_init = mes_v13_0_early_init,
+	.late_init = NULL,
+	.sw_init = mes_v13_0_sw_init,
+	.sw_fini = mes_v13_0_sw_fini,
+	.hw_init = mes_v13_0_hw_init,
+	.hw_fini = mes_v13_0_hw_fini,
+	.suspend = mes_v13_0_suspend,
+	.resume = mes_v13_0_resume,
+};
+
+const struct amdgpu_ip_block_version mes_v13_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_MES,
+	.major = 13,
+	.minor = 0,
+	.rev = 1,
+	.funcs = &mes_v13_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v13_0.h b/drivers/gpu/drm/amd/amdgpu/mes_v13_0.h
new file mode 100644
index 0000000000000..c268d1a9c2838
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v13_0.h
@@ -0,0 +1,29 @@
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
+#ifndef __MES_V13_0_H__
+#define __MES_V13_0_H__
+
+extern const struct amdgpu_ip_block_version mes_v13_0_ip_block;
+
+#endif
diff --git a/drivers/gpu/drm/amd/include/mes_v13_api_def.h b/drivers/gpu/drm/amd/include/mes_v13_api_def.h
new file mode 100644
index 0000000000000..1b7aa5c40eb19
--- /dev/null
+++ b/drivers/gpu/drm/amd/include/mes_v13_api_def.h
@@ -0,0 +1,886 @@
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
+#ifndef __MES_API_DEF_H__
+#define __MES_API_DEF_H__
+
+#pragma pack(push, 8)
+
+#define MES_API_VERSION 0x14
+
+/* Maximum log buffer size for MES. Needs to be updated if MES expands MES_EVT_INTR_HIST_LOG_12 */
+#define  AMDGPU_MES_LOG_BUFFER_SIZE  0xC000
+
+/* Driver submits one API(cmd) as a single Frame and this command size is same for all API
+ * to ease the debugging and parsing of ring buffer.
+ */
+enum {API_FRAME_SIZE_IN_DWORDS = 64};
+
+/* To avoid command in scheduler context to be overwritten whenenver mutilple interrupts come in,
+ * this creates another queue
+ */
+enum {API_NUMBER_OF_COMMAND_MAX   = 32};
+
+enum MES_API_TYPE {
+	MES_API_TYPE_SCHEDULER = 1,
+	MES_API_TYPE_MAX
+};
+
+enum MES_SCH_API_OPCODE {
+	MES_SCH_API_SET_HW_RSRC			= 0,
+	MES_SCH_API_SET_SCHEDULING_CONFIG	= 1, /* agreegated db, quantums, etc */
+	MES_SCH_API_ADD_QUEUE			= 2,
+	MES_SCH_API_REMOVE_QUEUE		= 3,
+	MES_SCH_API_PERFORM_YIELD		= 4,
+	MES_SCH_API_SET_GANG_PRIORITY_LEVEL	= 5, /* For windows GANG = Context */
+	MES_SCH_API_SUSPEND			= 6,
+	MES_SCH_API_RESUME			= 7,
+	MES_SCH_API_RESET			= 8,
+	MES_SCH_API_SET_LOG_BUFFER		= 9,
+	MES_SCH_API_CHANGE_GANG_PRORITY		= 10,
+	MES_SCH_API_QUERY_SCHEDULER_STATUS	= 11,
+	MES_SCH_API_SET_DEBUG_VMID		= 13,
+	MES_SCH_API_MISC			= 14,
+	MES_SCH_API_UPDATE_ROOT_PAGE_TABLE	= 15,
+	MES_SCH_API_AMD_LOG			= 16,
+	MES_SCH_API_SET_SE_MODE			= 17,
+	MES_SCH_API_SET_GANG_SUBMIT		= 18,
+	MES_SCH_API_SET_HW_RSRC_1               = 19,
+
+	MES_SCH_API_MAX = 0xFF
+};
+
+union MES_API_HEADER {
+	struct {
+		uint32_t type	  : 4; /* 0 - Invalid; 1 - Scheduling; 2 - TBD */
+		uint32_t opcode   : 8;
+		uint32_t dwsize   : 8; /* including header */
+		uint32_t reserved : 12;
+	};
+
+	uint32_t u32All;
+};
+
+enum MES_AMD_PRIORITY_LEVEL {
+	AMD_PRIORITY_LEVEL_LOW		= 0,
+	AMD_PRIORITY_LEVEL_NORMAL	= 1,
+	AMD_PRIORITY_LEVEL_MEDIUM	= 2,
+	AMD_PRIORITY_LEVEL_HIGH		= 3,
+	AMD_PRIORITY_LEVEL_REALTIME	= 4,
+
+	AMD_PRIORITY_NUM_LEVELS
+};
+
+enum MES_QUEUE_TYPE {
+	MES_QUEUE_TYPE_GFX,
+	MES_QUEUE_TYPE_COMPUTE,
+	MES_QUEUE_TYPE_SDMA,
+
+	MES_QUEUE_TYPE_MAX,
+	MES_QUEUE_TYPE_SCHQ = MES_QUEUE_TYPE_MAX,
+};
+
+struct MES_API_STATUS {
+	uint64_t api_completion_fence_addr;
+	uint64_t api_completion_fence_value;
+};
+
+/*
+ * MES will set api_completion_fence_value in api_completion_fence_addr
+ * when it can successflly process the API. MES will also trigger
+ * following interrupt when it finish process the API no matter success
+ * or failed.
+ *     Interrupt source id 181 (EOP) with context ID (DW 6 in the int
+ *     cookie) set to 0xb1 and context type set to 8. Driver side need
+ *     to enable TIME_STAMP_INT_ENABLE in CPC_INT_CNTL for MES pipe to
+ *     catch this interrupt.
+ *     Driver side also need to set enable_mes_fence_int = 1 in
+ *     set_HW_resource package to enable this fence interrupt.
+ * when the API process failed.
+ *     lowre 32 bits set to 0.
+ *     higher 32 bits set as follows (bit shift within high 32)
+ *         bit 0  -  7    API specific error code.
+ *         bit 8  - 15    API OPCODE.
+ *         bit 16 - 23    MISC OPCODE if any
+ *         bit 24 - 30    ERROR category (API_ERROR_XXX)
+ *         bit 31         Set to 1 to indicate error status
+ *
+ */
+enum { MES_SCH_ERROR_CODE_HEADER_SHIFT_12 = 8 };
+enum { MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 = 16 };
+enum { MES_ERROR_CATEGORY_SHIFT_12 = 24 };
+enum { MES_API_STATUS_ERROR_SHIFT_12 = 31 };
+
+enum MES_ERROR_CATEGORY_CODE_12 {
+	MES_ERROR_API                = 1,
+	MES_ERROR_SCHEDULING         = 2,
+	MES_ERROR_UNKNOWN            = 3,
+};
+
+#define MES_ERR_CODE(api_err, opcode, misc_op, category) \
+			((uint64) (api_err | opcode << MES_SCH_ERROR_CODE_HEADER_SHIFT_12 | \
+			misc_op << MES_SCH_ERROR_CODE_MISC_OP_SHIFT_12 | \
+			category << MES_ERROR_CATEGORY_SHIFT_12 | \
+			1 << MES_API_STATUS_ERROR_SHIFT_12) << 32)
+
+enum { MAX_COMPUTE_PIPES = 8 };
+enum { MAX_GFX_PIPES	 = 2 };
+enum { MAX_SDMA_PIPES	 = 2 };
+enum { MAX_SDMA_PIPES_13_0  = 4 };
+
+enum { MAX_COMPUTE_HQD_PER_PIPE		= 8 };
+enum { MAX_GFX_HQD_PER_PIPE		= 8 };
+enum { MAX_SDMA_HQD_PER_PIPE		= 10 };
+enum { MAX_SDMA_HQD_PER_PIPE_11_0	= 8 };
+
+
+enum { MAX_QUEUES_IN_A_GANG = 8 };
+
+enum VM_HUB_TYPE {
+	VM_HUB_TYPE_GC = 0,
+	VM_HUB_TYPE_MM = 1,
+
+	VM_HUB_TYPE_MAX,
+};
+
+enum { VMID_INVALID = 0xffff };
+
+enum { MAX_VMID_GCHUB = 16 };
+enum { MAX_VMID_MMHUB = 16 };
+
+enum SET_DEBUG_VMID_OPERATIONS {
+	DEBUG_VMID_OP_PROGRAM	= 0,
+	DEBUG_VMID_OP_ALLOCATE	= 1,
+	DEBUG_VMID_OP_RELEASE	= 2,
+	DEBUG_VMID_OP_VM_SETUP	= 3 // used to set up the debug vmid page table in the kernel queue case (mode 1)
+};
+
+enum MES_MS_LOG_CONTEXT_STATE {
+	MES_LOG_CONTEXT_STATE_IDLE		= 0,
+	MES_LOG_CONTEXT_STATE_RUNNING		= 1,
+	MES_LOG_CONTEXT_STATE_READY		= 2,
+	MES_LOG_CONTEXT_STATE_READY_STANDBY	= 3,
+	MES_LOG_CONTEXT_STATE_INVALID		= 0xF,
+};
+
+enum MES_MS_LOG_OPERATION {
+	MES_LOG_OPERATION_CONTEXT_STATE_CHANGE		= 0,
+	MES_LOG_OPERATION_QUEUE_NEW_WORK		= 1,
+	MES_LOG_OPERATION_QUEUE_UNWAIT_SYNC_OBJECT	= 2,
+	MES_LOG_OPERATION_QUEUE_NO_MORE_WORK		= 3,
+	MES_LOG_OPERATION_QUEUE_WAIT_SYNC_OBJECT	= 4,
+	MES_LOG_OPERATION_QUEUE_INVALID			= 0xF,
+};
+
+struct MES_LOG_CONTEXT_STATE_CHANGE {
+	uint64_t			h_context;
+	enum MES_MS_LOG_CONTEXT_STATE	new_context_state;
+};
+
+struct MES_LOG_QUEUE_NEW_WORK {
+	uint64_t	h_queue;
+	uint64_t	reserved;
+};
+
+struct MES_LOG_QUEUE_UNWAIT_SYNC_OBJECT {
+	uint64_t	h_queue;
+	uint64_t	h_sync_object;
+};
+
+struct MES_LOG_QUEUE_NO_MORE_WORK {
+	uint64_t	h_queue;
+	uint64_t	reserved;
+};
+
+struct MES_LOG_QUEUE_WAIT_SYNC_OBJECT {
+	uint64_t	h_queue;
+	uint64_t	h_sync_object;
+};
+
+struct MES_LOG_ENTRY_HEADER {
+	uint32_t first_free_entry_index;
+	uint32_t wraparound_count;
+	uint64_t number_of_entries;
+	uint64_t reserved[2];
+};
+
+struct MES_LOG_ENTRY_DATA {
+	uint64_t gpu_time_stamp;
+	uint32_t operation_type; /* operation_type is of MES_LOG_OPERATION type */
+	uint32_t reserved_operation_type_bits;
+	union {
+		struct MES_LOG_CONTEXT_STATE_CHANGE context_state_change;
+		struct MES_LOG_QUEUE_NEW_WORK queue_new_work;
+		struct MES_LOG_QUEUE_UNWAIT_SYNC_OBJECT queue_unwait_sync_object;
+		struct MES_LOG_QUEUE_NO_MORE_WORK queue_no_more_work;
+		struct MES_LOG_QUEUE_WAIT_SYNC_OBJECT queue_wait_sync_object;
+		uint64_t all[2];
+	};
+};
+
+struct MES_LOG_BUFFER {
+	struct MES_LOG_ENTRY_HEADER header;
+	struct MES_LOG_ENTRY_DATA	entries[];
+};
+
+enum MES_SWIP_TO_HWIP_DEF {
+	MES_MAX_HWIP_SEGMENT = 8,
+};
+
+union MESAPI_SET_HW_RESOURCES {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		vmid_mask_mmhub;
+		uint32_t		vmid_mask_gfxhub;
+		uint32_t		gds_size;
+		uint32_t		paging_vmid;
+		uint32_t		compute_hqd_mask[MAX_COMPUTE_PIPES];
+		uint32_t		gfx_hqd_mask[MAX_GFX_PIPES];
+		uint32_t		sdma_hqd_mask[MAX_SDMA_PIPES];
+		uint32_t		aggregated_doorbells[AMD_PRIORITY_NUM_LEVELS];
+		uint64_t		g_sch_ctx_gpu_mc_ptr;
+		uint64_t		query_status_fence_gpu_mc_ptr;
+		uint32_t		gc_base[MES_MAX_HWIP_SEGMENT];
+		uint32_t		mmhub_base[MES_MAX_HWIP_SEGMENT];
+		uint32_t		osssys_base[MES_MAX_HWIP_SEGMENT];
+		struct MES_API_STATUS	api_status;
+		union {
+			struct {
+				uint32_t disable_reset : 1;
+				uint32_t use_different_vmid_compute : 1;
+				uint32_t disable_mes_log   : 1;
+				uint32_t apply_mmhub_pgvm_invalidate_ack_loss_wa : 1;
+				uint32_t apply_grbm_remote_register_dummy_read_wa : 1;
+				uint32_t second_gfx_pipe_enabled : 1;
+				uint32_t enable_level_process_quantum_check : 1;
+				uint32_t legacy_sch_mode : 1;
+				uint32_t disable_add_queue_wptr_mc_addr : 1;
+				uint32_t enable_mes_event_int_logging : 1;
+				uint32_t enable_reg_active_poll : 1;
+				uint32_t use_disable_queue_in_legacy_uq_preemption : 1;
+				uint32_t send_write_data : 1;
+				uint32_t os_tdr_timeout_override : 1;
+				uint32_t use_rs64mem_for_proc_gang_ctx : 1;
+				uint32_t halt_on_misaligned_access : 1;
+				uint32_t use_add_queue_unmap_flag_addr : 1;
+				uint32_t enable_mes_sch_stb_log : 1;
+				uint32_t limit_single_process : 1;
+				uint32_t unmapped_doorbell_handling: 2;
+				uint32_t enable_mes_fence_int: 1;
+				uint32_t reserved : 10;
+			};
+			uint32_t uint32_all;
+		};
+	uint32_t	oversubscription_timer;
+	uint64_t	doorbell_info;
+	uint64_t	event_intr_history_gpu_mc_ptr;
+	uint64_t	timestamp;
+	uint32_t	os_tdr_timeout_in_sec;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union HWS_PAGING_SDMA_INFO {
+    struct {
+        uint32_t user_paging_sdma_enable : 1;
+        uint32_t user_paging_sdma_pipe_id : 3;
+        uint32_t user_paging_sdma_queue_id : 4;
+        uint32_t reserved : 24;
+    };
+    uint32_t uint32_all;
+};
+
+union MESAPI_SET_HW_RESOURCES_1 {
+	struct {
+		union MES_API_HEADER                header;
+		struct MES_API_STATUS               api_status;
+		uint64_t                            timestamp;
+		union {
+			struct {
+				uint32_t enable_mes_info_ctx : 1;
+				uint32_t reserved : 31;
+			};
+			uint32_t uint32_all;
+		};
+		uint64_t                            mes_info_ctx_mc_addr;
+		uint32_t                            mes_info_ctx_size;
+		/* unit is 100ms */
+		uint32_t                            mes_kiq_unmap_timeout;
+		uint32_t                            sdma_hqd_mask[MAX_SDMA_PIPES_13_0];
+		union  HWS_PAGING_SDMA_INFO         hws_paging_sdma_info;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__ADD_QUEUE {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		process_id;
+		uint64_t		page_table_base_addr;
+		uint64_t		process_va_start;
+		uint64_t		process_va_end;
+		uint64_t		process_quantum;
+		uint64_t		process_context_addr;
+		uint64_t		gang_quantum;
+		uint64_t		gang_context_addr;
+		uint32_t		inprocess_gang_priority;
+		enum MES_AMD_PRIORITY_LEVEL gang_global_priority_level;
+		uint32_t		doorbell_offset;
+		uint64_t		mqd_addr;
+		/* From MES_API_VERSION 2, mc addr is expected for wptr_addr */
+		uint64_t		wptr_addr;
+		uint64_t		h_context;
+		uint64_t		h_queue;
+		enum MES_QUEUE_TYPE	queue_type;
+		uint32_t		gds_base;
+		union {
+			/* backwards compatibility with Linux, remove union once they use kfd_queue_size */
+			uint32_t	gds_size;
+			uint32_t	kfd_queue_size;
+		};
+		uint32_t		gws_base;
+		uint32_t		gws_size;
+		uint32_t		oa_mask;
+		uint64_t		trap_handler_addr;
+		uint32_t		vm_context_cntl;
+
+		struct {
+			uint32_t paging	 : 1;
+			uint32_t debug_vmid  : 4;
+			uint32_t program_gds : 1;
+			uint32_t is_gang_suspended : 1;
+			uint32_t is_tmz_queue : 1;
+			uint32_t map_kiq_utility_queue : 1;
+			uint32_t is_kfd_process : 1;
+			uint32_t trap_en : 1;
+			uint32_t is_aql_queue : 1;
+			uint32_t skip_process_ctx_clear : 1;
+			uint32_t map_legacy_kq : 1;
+			uint32_t exclusively_scheduled : 1;
+			uint32_t is_long_running : 1;
+			uint32_t is_dwm_queue : 1;
+			uint32_t reserved	 : 15;
+		};
+		struct MES_API_STATUS	api_status;
+		uint64_t		tma_addr;
+		uint32_t		sch_id;
+		uint64_t		timestamp;
+		uint32_t		process_context_array_index;
+		uint32_t		gang_context_array_index;
+		uint32_t		pipe_id;	//used for mapping legacy kernel queue
+		uint32_t		queue_id;
+		uint32_t		alignment_mode_setting;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__REMOVE_QUEUE {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		doorbell_offset;
+		uint64_t		gang_context_addr;
+
+		struct {
+			uint32_t reserved01		  : 1;
+			uint32_t unmap_kiq_utility_queue  : 1;
+			uint32_t preempt_legacy_gfx_queue : 1;
+			uint32_t unmap_legacy_queue	  : 1;
+			uint32_t reserved		  : 28;
+		};
+		struct MES_API_STATUS		api_status;
+
+		uint32_t			pipe_id;
+		uint32_t			queue_id;
+
+		uint64_t			tf_addr;
+		uint32_t			tf_data;
+
+		enum MES_QUEUE_TYPE		queue_type;
+		uint64_t			timestamp;
+		uint32_t			gang_context_array_index;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_SCHEDULING_CONFIG {
+	struct {
+		union MES_API_HEADER	header;
+		/* Grace period when preempting another priority band for this priority band.
+		 * The value for idle priority band is ignored, as it never preempts other bands.
+		 */
+		uint64_t		grace_period_other_levels[AMD_PRIORITY_NUM_LEVELS];
+
+		/* Default quantum for scheduling across processes within a priority band. */
+		uint64_t		process_quantum_for_level[AMD_PRIORITY_NUM_LEVELS];
+
+		/* Default grace period for processes that preempt each other within a priority band.*/
+		uint64_t		process_grace_period_same_level[AMD_PRIORITY_NUM_LEVELS];
+
+		/* For normal level this field specifies the target GPU percentage in situations when it's starved by the high level.
+		 * Valid values are between 0 and 50, with the default being 10.
+		 */
+		uint32_t		normal_yield_percent;
+
+		struct MES_API_STATUS	api_status;
+		uint64_t		timestamp;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__PERFORM_YIELD {
+	struct {
+		union MES_API_HEADER	header;
+		uint32_t		dummy;
+		struct MES_API_STATUS	api_status;
+		uint64_t		timestamp;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__CHANGE_GANG_PRIORITY_LEVEL {
+	struct {
+		union MES_API_HEADER		header;
+		uint32_t			inprocess_gang_priority;
+		enum MES_AMD_PRIORITY_LEVEL gang_global_priority_level;
+		uint64_t			gang_quantum;
+		uint64_t			gang_context_addr;
+		struct MES_API_STATUS		api_status;
+		uint32_t			doorbell_offset;
+		uint64_t			timestamp;
+		uint32_t			gang_context_array_index;
+		struct {
+			uint32_t		queue_quantum_scale	: 2;
+			uint32_t		queue_quantum_duration	: 8;
+			uint32_t		apply_quantum_all_processes : 1;
+			uint32_t		reserved		: 21;
+		};
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SUSPEND {
+	struct {
+		union MES_API_HEADER	header;
+		/* false - suspend all gangs; true - specific gang */
+		struct {
+			uint32_t	suspend_all_gangs : 1;
+			uint32_t	reserved : 31;
+		};
+		/* gang_context_addr is valid only if suspend_all = false */
+
+		uint64_t		gang_context_addr;
+
+		uint64_t		suspend_fence_addr;
+		uint32_t		suspend_fence_value;
+
+		struct MES_API_STATUS	api_status;
+
+		union {
+			uint32_t return_value; // to be removed
+			uint32_t sch_id;       //keep the old return_value temporarily for compatibility
+		};
+		uint32_t		doorbell_offset;
+		uint64_t		timestamp;
+		enum MES_QUEUE_TYPE	legacy_uq_type;
+		enum MES_AMD_PRIORITY_LEVEL legacy_uq_priority_level;
+		uint32_t		gang_context_array_index;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__RESUME {
+	struct {
+		union MES_API_HEADER	header;
+		/* false - resume all gangs; true - specified gang */
+		struct {
+			uint32_t	resume_all_gangs : 1;
+			uint32_t	reserved : 31;
+		};
+		/* valid only if resume_all_gangs = false */
+		uint64_t		gang_context_addr;
+
+		struct MES_API_STATUS	api_status;
+		uint32_t		doorbell_offset;
+		uint64_t		timestamp;
+		uint32_t		gang_context_array_index;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__RESET {
+	struct {
+		union MES_API_HEADER		header;
+
+		struct {
+			/* Only reset the queue given by doorbell_offset (not entire gang) */
+			uint32_t		reset_queue_only : 1;
+			/* Hang detection first then reset any queues that are hung */
+			uint32_t		hang_detect_then_reset : 1;
+			/* Only do hang detection (no reset) */
+			uint32_t		hang_detect_only : 1;
+			/* Reset HP and LP kernel queues not managed by MES */
+			uint32_t		reset_legacy_gfx : 1;
+			/* Fallback to use conneceted queue index when CP_CNTX_STAT method fails (gfx pipe 0) */
+			uint32_t		use_connected_queue_index : 1;
+			/* For gfx pipe 1 */
+			uint32_t		use_connected_queue_index_p1 : 1;
+			uint32_t		reserved : 26;
+		};
+
+		uint64_t			gang_context_addr;
+
+		/* valid only if reset_queue_only = true */
+		uint32_t			doorbell_offset;
+
+		/* valid only if hang_detect_then_reset = true */
+		uint64_t			doorbell_offset_addr;
+		enum MES_QUEUE_TYPE		queue_type;
+
+		/* valid only if reset_legacy_gfx = true */
+		uint32_t			pipe_id_lp;
+		uint32_t			queue_id_lp;
+		uint32_t			vmid_id_lp;
+		uint64_t			mqd_mc_addr_lp;
+		uint32_t			doorbell_offset_lp;
+		uint64_t			wptr_addr_lp;
+
+		uint32_t			pipe_id_hp;
+		uint32_t			queue_id_hp;
+		uint32_t			vmid_id_hp;
+		uint64_t			mqd_mc_addr_hp;
+		uint32_t			doorbell_offset_hp;
+		uint64_t			wptr_addr_hp;
+
+		struct MES_API_STATUS		api_status;
+		uint32_t			active_vmids;
+		uint64_t			timestamp;
+
+		uint32_t			gang_context_array_index;
+
+		uint32_t			connected_queue_index;
+		uint32_t			connected_queue_index_p1;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_LOGGING_BUFFER {
+	struct {
+		union MES_API_HEADER		header;
+		/* There are separate log buffers for each queue type */
+		enum MES_QUEUE_TYPE		log_type;
+		/* Log buffer GPU Address */
+		uint64_t			logging_buffer_addr;
+		/* number of entries in the log buffer */
+		uint32_t			number_of_entries;
+		/* Entry index at which CPU interrupt needs to be signalled */
+		uint32_t			interrupt_entry;
+
+		struct MES_API_STATUS		api_status;
+		uint64_t			timestamp;
+		uint32_t			vmid;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+enum MES_API_QUERY_MES_OPCODE {
+	MES_API_QUERY_MES__GET_CTX_ARRAY_SIZE,
+	MES_API_QUERY_MES__CHECK_HEALTHY,
+	MES_API_QUERY_MES__MAX,
+};
+
+enum { QUERY_MES_MAX_SIZE_IN_DWORDS = 20 };
+
+struct MES_API_QUERY_MES__CTX_ARRAY_SIZE {
+	uint64_t	proc_ctx_array_size_addr;
+	uint64_t	gang_ctx_array_size_addr;
+};
+
+struct MES_API_QUERY_MES__HEALTHY_CHECK {
+	uint64_t	healthy_addr;
+};
+
+union MESAPI__QUERY_MES_STATUS {
+	struct {
+		union MES_API_HEADER		header;
+		enum MES_API_QUERY_MES_OPCODE	subopcode;
+		struct MES_API_STATUS		api_status;
+		uint64_t			timestamp;
+		union {
+			struct MES_API_QUERY_MES__CTX_ARRAY_SIZE	ctx_array_size;
+			struct MES_API_QUERY_MES__HEALTHY_CHECK	healthy_check;
+			uint32_t data[QUERY_MES_MAX_SIZE_IN_DWORDS];
+		};
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_DEBUG_VMID {
+	struct {
+		union MES_API_HEADER	header;
+		struct MES_API_STATUS	api_status;
+		union {
+			struct {
+			uint32_t use_gds   : 1;
+			uint32_t operation : 2;
+			uint32_t reserved  : 29;
+			} flags;
+			uint32_t u32All;
+		};
+		uint32_t		reserved;
+		uint32_t		debug_vmid;
+		uint64_t		process_context_addr;
+		uint64_t		page_table_base_addr;
+		uint64_t		process_va_start;
+		uint64_t		process_va_end;
+		uint32_t		gds_base;
+		uint32_t		gds_size;
+		uint32_t		gws_base;
+		uint32_t		gws_size;
+		uint32_t		oa_mask;
+
+		uint64_t		output_addr; // output addr of the acquired vmid value
+
+		uint64_t		timestamp;
+
+		uint32_t		process_vm_cntl;
+		enum MES_QUEUE_TYPE	queue_type;
+
+		uint32_t		process_context_array_index;
+
+		uint32_t		alignment_mode_setting;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+enum MESAPI_MISC_OPCODE {
+	MESAPI_MISC__WRITE_REG,
+	MESAPI_MISC__INV_GART,
+	MESAPI_MISC__QUERY_STATUS,
+	MESAPI_MISC__READ_REG,
+	MESAPI_MISC__WAIT_REG_MEM,
+	MESAPI_MISC__SET_SHADER_DEBUGGER,
+	MESAPI_MISC__NOTIFY_WORK_ON_UNMAPPED_QUEUE,
+	MESAPI_MISC__NOTIFY_TO_UNMAP_PROCESSES,
+	MESAPI_MISC__QUERY_HUNG_ENGINE_ID,
+	MESAPI_MISC__CHANGE_CONFIG,
+	MESAPI_MISC__LAUNCH_CLEANER_SHADER,
+	MESAPI_MISC__SETUP_MES_DBGEXT,
+
+	MESAPI_MISC__MAX,
+};
+
+enum {MISC_DATA_MAX_SIZE_IN_DWORDS = 20};
+
+struct WRITE_REG {
+	uint32_t	reg_offset;
+	uint32_t	reg_value;
+};
+
+struct READ_REG {
+	uint32_t reg_offset;
+	uint64_t buffer_addr;
+	union {
+		struct {
+			uint32_t read64Bits : 1;
+			uint32_t reserved : 31;
+		} bits;
+		uint32_t all;
+	} option;
+};
+
+struct INV_GART {
+	uint64_t	inv_range_va_start;
+	uint64_t	inv_range_size;
+};
+
+struct QUERY_STATUS {
+	uint32_t context_id;
+};
+
+enum WRM_OPERATION {
+	WRM_OPERATION__WAIT_REG_MEM,
+	WRM_OPERATION__WR_WAIT_WR_REG,
+
+	WRM_OPERATION__MAX,
+};
+
+struct WAIT_REG_MEM {
+	enum WRM_OPERATION op;
+	/* only function = equal_to_the_reference_value and mem_space = register_space supported for now */
+	uint32_t reference;
+	uint32_t mask;
+	uint32_t reg_offset1;
+	uint32_t reg_offset2;
+};
+
+struct SET_SHADER_DEBUGGER {
+	uint64_t process_context_addr;
+	union {
+		struct {
+			uint32_t single_memop : 1; // SQ_DEBUG.single_memop
+			uint32_t single_alu_op : 1; // SQ_DEBUG.single_alu_op
+			uint32_t reserved : 30;
+		};
+		uint32_t u32all;
+	} flags;
+	uint32_t spi_gdbg_per_vmid_cntl;
+	uint32_t tcp_watch_cntl[4]; // TCP_WATCHx_CNTL
+	uint32_t trap_en;
+};
+
+struct SET_GANG_SUBMIT {
+	uint64_t gang_context_addr;
+	uint64_t slave_gang_context_addr;
+	uint32_t gang_context_array_index;
+	uint32_t slave_gang_context_array_index;
+};
+
+enum MESAPI_MISC__CHANGE_CONFIG_OPTION {
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_LIMIT_SINGLE_PROCESS = 0,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_ENABLE_HWS_LOGGING_BUFFER = 1,
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_CHANGE_TDR_CONFIG    = 2,
+
+	MESAPI_MISC__CHANGE_CONFIG_OPTION_MAX = 0x1F
+};
+
+struct CHANGE_CONFIG {
+	enum MESAPI_MISC__CHANGE_CONFIG_OPTION opcode;
+	union {
+		struct  {
+			uint32_t limit_single_process : 1;
+			uint32_t enable_hws_logging_buffer : 1;
+			uint32_t reserved : 30;
+		} bits;
+		uint32_t all;
+	} option;
+
+	struct {
+		uint32_t tdr_level;
+		uint32_t tdr_delay;
+	} tdr_config;
+};
+
+union MESAPI__MISC {
+	struct {
+		union MES_API_HEADER	header;
+		enum MESAPI_MISC_OPCODE opcode;
+		struct MES_API_STATUS	api_status;
+		union {
+			struct WRITE_REG write_reg;
+			struct INV_GART inv_gart;
+			struct QUERY_STATUS query_status;
+			struct READ_REG read_reg;
+			struct WAIT_REG_MEM wait_reg_mem;
+			struct SET_SHADER_DEBUGGER set_shader_debugger;
+			enum MES_AMD_PRIORITY_LEVEL queue_sch_level;
+			struct CHANGE_CONFIG change_config;
+			uint32_t data[MISC_DATA_MAX_SIZE_IN_DWORDS];
+		};
+		uint64_t		timestamp;
+		uint32_t		doorbell_offset;
+		uint32_t		os_fence;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__UPDATE_ROOT_PAGE_TABLE {
+	struct {
+		union MES_API_HEADER		header;
+		uint64_t			page_table_base_addr;
+		uint64_t			process_context_addr;
+		struct MES_API_STATUS		api_status;
+		uint64_t			timestamp;
+		uint32_t			process_context_array_index;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI_AMD_LOG {
+	struct {
+		union MES_API_HEADER		header;
+		uint64_t			p_buffer_memory;
+		uint64_t			p_buffer_size_used;
+		struct MES_API_STATUS		api_status;
+		uint64_t			timestamp;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+enum MES_SE_MODE {
+	MES_SE_MODE_INVALID	= 0,
+	MES_SE_MODE_SINGLE_SE	= 1,
+	MES_SE_MODE_DUAL_SE	= 2,
+	MES_SE_MODE_LOWER_POWER	= 3,
+};
+
+union MESAPI__SET_SE_MODE {
+	struct {
+		union MES_API_HEADER header;
+		/* the new SE mode to apply*/
+		enum MES_SE_MODE new_se_mode;
+		/* the fence to make sure the ItCpgCtxtSync packet is completed */
+		uint64_t cpg_ctxt_sync_fence_addr;
+		uint32_t cpg_ctxt_sync_fence_value;
+		/* log_seq_time - Scheduler logs the switch seq start/end ts in the IH cookies */
+		union {
+			struct {
+				uint32_t log_seq_time : 1;
+				uint32_t reserved : 31;
+			};
+			uint32_t uint32_all;
+		};
+		struct MES_API_STATUS api_status;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+union MESAPI__SET_GANG_SUBMIT {
+	struct {
+		union MES_API_HEADER	header;
+		struct MES_API_STATUS	api_status;
+		struct SET_GANG_SUBMIT	set_gang_submit;
+	};
+
+	uint32_t max_dwords_in_api[API_FRAME_SIZE_IN_DWORDS];
+};
+
+#pragma pack(pop)
+
+#endif
-- 
2.56.0

