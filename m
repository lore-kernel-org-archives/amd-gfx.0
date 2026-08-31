Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14EBC624D5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8A5310E50F;
	Mon, 31 Aug 2026 18:28:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GrhYd57G";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012062.outbound.protection.outlook.com [52.101.43.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B18E10E50F
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ofMbC5CdcZq51A6s1PeoyB8k95nsi5tzXgiNw9uaks7s4AxW0GPM+jMimmSjchzEcUM/1dgCva4W9hVzUqF5+/XRfwFqyHxugGkQjqTE4HBRdmdzWff14/ZAzpmeWhq3AP8xWf9lrH+FIIPoc+Ld+p8Wa7kRMhuD1EDA9G+Eo4axoVPuMmmCHS0bulKEPyS1ZpEFtxJ3LnMVEetnFT/XEp4tbGXyAgJFog0lPLtgxY/nYthG4Oy/vrHDE+i24O8AoplO1mdXmjpE7qcFHv2NwUBulbPyZZRFKjDZIIpUwhJ/GPthesuq6DwTkirwF3VPg1XvG5cWGs5+AIgaOPyOmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTSx+FHEPalhBRd8kUU/ertGi8USlyWMeJ4UW93GErw=;
 b=eXIxCMemFryVmOgDmhS/E+vdMjtkV/LuKourBNtpCagC5AQcJ6DP6zL01P8avz7SVMteiyZ8qfD+dWCSDKKP+GdRvzRHTCuIrdN2k7lDlzla20nr5EOs7sQE5iMRDTpNYWhUPEip69hzOAM58eKogFfJpo5C18zQQafq69dKaTws1y2KhqKaJWqzbZFAd+rlWSQuxJI2rHbJstfQMOnDRttPTDE9WXc+N3zPs1m/jhgPp6rGnhQv7ln9F9fw89hMyl6yM8VwvpDH+AV1i+ClJ/rY6YfTL/4ZyqdZu+v5t8+5xImZCSKI+x59Vp9JQZjHFibWWIiLAhfyRlHOn3lmVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTSx+FHEPalhBRd8kUU/ertGi8USlyWMeJ4UW93GErw=;
 b=GrhYd57GnvJ7mGma/ud74CiJmBlKAUXPnxqW0iphZI8wjnghyhnagXQpP9B+q+L+egftl/TzrzzEzJ8g3V/qtIkytU75KRd0Xj7BldLv8YZZwFPJO8AwkzJdlQPL2xcUUddd/iwT9s7wWo5oaiwmPVQ4DTQaKhQI4xCJAllLa1k=
Received: from CH5P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::24)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:41 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::24) by CH5P220CA0012.outlook.office365.com
 (2603:10b6:610:1ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:30 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 38/95] drm/amdgpu: Add UALink remote command packets and SDMA
 dispatch
Date: Mon, 31 Aug 2026 14:26:57 -0400
Message-ID: <20260831182754.1089811-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 997f7c9f-7a14-4d83-ef15-08df078daee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: vWLqpgKbIY5FfnpdIy4nGmR8Qdc810PrCwWtEHcv7+rWZLeXcziiwvfjzJMdIx5L45INabdJvV/09Htq78hazEfNSyFF4ZpaRIyK0h783MTK1j6kDlmKA9xTJkmZXKPOa2ZkakFDyXCjFEtJAQKrDzEOsDt7Ka5rd68YwU0PvEzNkV7g+GAIknB6yOsuWKAjun2gGiIV/70z5vnBlfPUceBdx53I2ckgGzjKB/9LIOvHB63cOt2YktJXGADxn3E1R5UHRJ0T1Ob1JE4t4KiYSDcSOL6ZQl7EjjP+y8LnHrFWV0bV238tAUvBg3pSucjQtoG/wshnPCde7iIy9/X+/oIL2XyY/lJdnERkyd9s0ZoozsfJgAnce5SIMxflndPFZvaqFyXKbdeYantgTY1o9Hw3CYUaxYWJVoZ3BvPf08KxSN75xSHmQ5cmYvbv2GgL4+aPbRy2xllU995wbvHBmEwAp/JXlNN1rtQhc36wFsAT6nj/b2laZVixRAdZUFwvNmuDISHiE2QKbvXt22FT+pbNryMZu86Z/wyL2C/CpI72sByY4szfVOwjg0WnvhbZi3dzJYhazrJScVrr94bXbkQwWsbog3dAzk8FFs+5gAwPT3/SFhIsgfTnAS2KAl1DybZyntwwKqODHynO/zZfLjmp9S9UWZDSuGGT/kY92IlGtPFX0W2rY8NoT3r9Xp07Nhn2hnJp81kkE67tR/723w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jvIMHGaxtGz18l09QXLSjcnAsU0i7U2LB+x94dDGqLjwGq16jFoIDMWWKrJ77dMrfvw0y+hFDPptdMOGVNsXwUOSUBxB9rgI2UyfocYJe5Yqe+x/wTko8Vj1sozC/U6hhWQLexnbThxJ+jwfMQcn9MCe5jw86EGAZysiuamZO1FjMtLpey15V00dKVnaJjErPr1n8Yp6Ka6eekAQ/Pc2eFLHxzs0k5goubKvn4l6pA0B75iumThhrEhxEbCw5s+1jRUHRAGilj8QSoJVuskMNSCmjobzPLBqZJluAMut4XCoHJvISFOBWsrmINB03wsk8IgpY380gAOFYDJMWFgPuhJCfJronba/HxdnQgULJ/ruRXFGwJ8tYN5Qz2+r05pyYGSaBsNGrMZShcOrO64M7+jYV4uVErscXYDXkjZmw8O/zuVsuk8v5kUyKo3hFklx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:41.5408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 997f7c9f-7a14-4d83-ef15-08df078daee3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
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

From: Philip Yang <Philip.Yang@amd.com>

Add 16-dword packet layouts for TLB shootdown, remote interrupt, and
writeback address update. The dispatch path issues three sequential SDMA
copies (ring entry, write pointer, doorbell) and polls the firmware
writeback buffer for the acknowledged sequence number.

v2: fix 32 bit build (Alex)

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 350 +++++++++++++++++++++
 1 file changed, 350 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index c8b01e9a2eabe..58bb506785c27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -27,6 +27,7 @@
 #include "amdgpu.h"
 #include "amdgpu_ualink.h"
 #include "amdgpu_xgmi.h"
+#include <linux/math.h>
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
@@ -2349,3 +2350,352 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	return r;
 }
 
+/*
+ * nHT Firmware Error code
+ *
+ * Success				0x0
+ * FIFO overflow			0x1
+ * Invalid RB command			0x2
+ * Timeout				0x3
+ * Invalid metadata entry		0x4
+ * RB overflow				0x5
+ * Invalid wptr address			0x6
+ * Interrupt cookie send failure	0x7
+ * Invalid RB address			0x8
+ * Invalid writeback address		0x9
+ */
+static void amdgpu_ualink_remote_error(struct amdgpu_device *adev, u32 status)
+{
+	const char *fw_err_code_msg[] = {
+		"Unknown FW error status",
+		"FIFO overflow",		/* error code 1 */
+		"Invalid RB command",
+		"Timeout",
+		"Invalid metadata entry",
+		"RB overflow",
+		"Invalid wptr address",
+		"Interrupt cookie send failure",
+		"Invalid RB address",
+		"Invalid writeback address"	/* error code 9 */
+		};
+
+	if (status >= ARRAY_SIZE(fw_err_code_msg))
+		status = 0;
+
+	dev_err(adev->dev, "remote error %s\n", fw_err_code_msg[status]);
+	return;
+}
+
+/**
+ * amdgpu_ualink_remote_wait_timeout - Wait for remote operation completion
+ * @remote_accel_id: remote accelator id to wait for reply
+ * @adev: amdgpu device pointer
+ * @wb_cpu: CPU virtual address of writeback buffer
+ * @seq: Sequence number to wait for
+ *
+ * Polls the writeback buffer waiting for the sequence number to reach or
+ * exceed the expected value. The writeback buffer contains status and data
+ * fields updated by firmware to indicate completion and error conditions.
+ *
+ * Return: 0 on success
+ *         -ETIME on timeout
+ *         -ECOMM on firmware return error status
+ */
+static long amdgpu_ualink_remote_wait_timeout(struct amdgpu_device *adev,
+					      u32 remote_accel_id,
+					      struct amdgpu_ualink_wb *wb_cpu,
+					      u32 seq)
+{
+	/* 2 seconds timeout, long enough for FW to reply */
+	ktime_t timeout = ktime_add_us(ktime_get(), 2 * USEC_PER_SEC);
+	u32 status, data;
+	u64 rptr;
+
+	while (true) {
+		data = READ_ONCE(wb_cpu->data);
+		if (data >= seq) {
+			status = READ_ONCE(wb_cpu->status);
+			rptr = READ_ONCE(wb_cpu->rptr);
+			break;
+		}
+
+		if (ktime_after(ktime_get(), timeout)) {
+			dev_dbg(adev->dev, "remote %d wait timeout\n", remote_accel_id);
+			return -ETIME;
+		}
+
+		usleep_range(10, 50);
+	}
+
+	if (status) {
+		dev_dbg(adev->dev, "remote %u status 0x%x wb data 0x%x seq 0x%x rptr 0x%llx\n",
+			remote_accel_id, status, data, seq, rptr);
+
+		amdgpu_ualink_remote_error(adev, status);
+		return -ECOMM;
+	}
+
+	dev_dbg(adev->dev, "remote %u succeed seq 0x%x wb data 0x%x rptr 0x%llx\n",
+		remote_accel_id, seq, data, rptr);
+	return 0;
+}
+
+#define AMDGPU_UALINK_REMOTE_OP_TLB_INV		0x1
+#define AMDGPU_UALINK_REMOTE_OP_INT		0x2
+#define AMDGPU_UALINK_REMOTE_OP_UPDATE_WB	0x3
+
+static void amdgpu_ualink_emit_shootdown(u32 **cpu_addr_p, u32 wb_data,
+					 u32 dw0,  u32 dw1, u32 dw2, u32 dw3)
+{
+	u64 addr = (((u64)dw1 << 32) | (u64)dw2) << AMDGPU_GPU_PAGE_SHIFT;
+	u32 *cpu_addr = *cpu_addr_p;
+	u32 flush_type = dw0;
+	u32 size_in_pages = dw3;
+	u32 cmd;
+
+	cmd = AMDGPU_UALINK_REMOTE_OP_TLB_INV;
+	cmd |= 1 << 28;	/* headptr update */
+	cmd |= 1 << 29;	/* wb enable */
+
+	*cpu_addr++ = cmd;
+	*cpu_addr++ = wb_data;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0; /* metadata */
+	*cpu_addr++ = 0; /* metadata */
+
+	pr_debug("NPA addr 0x%llx npages 0x%x\n", addr, size_in_pages);
+
+	/* Always shootdown everything with full address size s-field coding */
+	addr = GENMASK_ULL(51, 11);
+
+	*cpu_addr++ = lower_32_bits(addr) | flush_type;
+	*cpu_addr++ = upper_32_bits(addr);
+
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr_p = cpu_addr;
+}
+
+static void amdgpu_ualink_emit_interrupt(u32 **cpu_addr_p, u32 wb_data,
+					 u32 dw0, u32 dw1, u32 dw2, u32 dw3)
+{
+	u32 *cpu_addr = *cpu_addr_p;
+	u32 cmd;
+
+	cmd = AMDGPU_UALINK_REMOTE_OP_INT;
+	cmd |= 1 << 28;	/* headptr_update */
+	cmd |= 1 << 29; /* wb enable */
+
+	*cpu_addr++ = cmd;
+	*cpu_addr++ = wb_data;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0; /* metadata */
+	*cpu_addr++ = 0; /* metadata */
+	/* updated by f/w, overwrite PASID with GPU ID */
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	/* IH ContextID 4 dwords */
+	*cpu_addr++ = dw0;
+	*cpu_addr++ = dw1;
+	*cpu_addr++ = dw2;
+	*cpu_addr++ = dw3;
+	*cpu_addr_p = cpu_addr;
+}
+
+static void amdgpu_ualink_emit_update_wb_addr(u32 **cpu_addr_p, u32 wb_data,
+					      u32 dw0, u32 dw1, u32 dw2, u32 dw3)
+{
+	u32 *cpu_addr = *cpu_addr_p;
+	u32 cmd;
+
+	cmd = AMDGPU_UALINK_REMOTE_OP_UPDATE_WB;
+	cmd |= 1 << 28;	/* headptr update */
+	cmd |= 1 << 29;	/* wb enable */
+
+	*cpu_addr++ = cmd;
+	*cpu_addr++ = wb_data;
+	*cpu_addr++ = dw1 & 0xFFFFFFFC;	/* lower32 wb_npa */
+	*cpu_addr++ = dw0 & 0xFFFFF;	/* upper32 wb_npa */
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0; /* metadata */
+	*cpu_addr++ = 0; /* metadata */
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr++ = 0;
+	*cpu_addr_p = cpu_addr;
+}
+
+/*
+ * Function proto to generate packet using above different emit_ functions
+ */
+typedef void (*ualink_emit_packet)(u32 **cpu_addr_p, u32 wb, u32 dw0,
+				   u32 dw1, u32 dw2, u32 dw3);
+
+static int amdgpu_ualink_send_command(struct amdgpu_device *adev,
+				      u32 remote_accel_id,
+				      struct amdgpu_ualink_ring *ring,
+				      struct amdgpu_ualink_wb *wb_cpu,
+				      ualink_emit_packet emit_func,
+				      u32 dw0, u32 dw1, u32 dw2, u32 dw3)
+{
+	struct amdgpu_ualink_remote *remote = to_remote(adev);
+	struct amdgpu_ualink_peer *peer;
+	struct amdgpu_ring *sdma_ring;
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	u32 seq, ndw, ndw_copy_cmd, rem;
+	u64 doorbell_npa_gart;
+	u32 *src_cpu;
+	u64 src;
+	int r;
+
+	peer = &remote->peer[remote_accel_id];
+
+	/*
+	 * 3 sdma copy commands: write data to ring buffer, update wptr, ring doorbell
+	 *
+	 * insert 2 NOP commands to break SDMA back-to-back copy command overlap, to
+	 * ensure the ordering of 3 sdma copy commands execution.
+	 */
+
+	/* buffer after sdma commands, starting at 8 dwords boundary */
+	ndw_copy_cmd = ALIGN(3 * adev->mman.buffer_funcs->copy_num_dw + 2, 8);
+
+	 /* remote command 16 dwords, wptr 2 dwords, doorbell 1 dword */
+	ndw = ndw_copy_cmd + 16 + 2 + 1;
+	r = amdgpu_job_alloc_with_ib(adev, &peer->entity, AMDGPU_FENCE_OWNER_VM,
+				     ndw * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER, &job);
+	if (r)
+		return r;
+
+	mutex_lock(&peer->lock);
+
+	ring->rptr = READ_ONCE(wb_cpu->rptr);
+
+	if (WARN_ON_ONCE(ring->rptr > ring->wptr)) {
+		dev_err(adev->dev, "accel_id %u ring overflow wptr 0x%llx rptr 0x%llx\n",
+			remote_accel_id, ring->wptr, ring->rptr);
+		r = -EFAULT;
+		goto unlock_free;
+	}
+
+	if ((ring->wptr + 1 - ring->rptr) >= ring->rb_size) {
+		dev_err(adev->dev, "accel_id %u command ring full wptr 0x%llx rptr 0x%llx\n",
+			remote_accel_id, ring->wptr, ring->rptr);
+		r = -ENOSPC;
+		goto unlock_free;
+	}
+
+	ib = &job->ibs[0];
+	src = ib->gpu_addr + ndw_copy_cmd * 4;
+	src_cpu = ib->ptr + ndw_copy_cmd;
+
+	seq = ++ring->seq;
+
+	div_u64_rem(ring->wptr, ring->rb_size, &rem);
+	dev_dbg(adev->dev, "src 0x%llx to npa gart rb 0x%llx wptr 0x%llx doorbell 0x%llx seq 0x%x\n",
+		src, ring->rb_npa_gart + rem * 64,
+		ring->wptr_npa_gart, ring->doorbell_npa_gart, seq);
+
+	dev_dbg(adev->dev, "ring wptr 0x%llx rptr 0x%llx\n", ring->wptr, ring->rptr);
+
+	/* remote command packet */
+	emit_func(&src_cpu, seq, dw0, dw1, dw2, dw3);
+
+	/* wptr value */
+	*src_cpu++ = lower_32_bits(ring->wptr + 1);
+	*src_cpu++ = upper_32_bits(ring->wptr + 1);
+
+	/* doorbell value */
+	*src_cpu++ = lower_32_bits(ring->wptr + 1);
+
+	/*
+	 * Add an offset to the doorbell address that cycles through different
+	 * values of bit 11:8 to use different DXS ports.
+	 */
+	peer->dxs_port = (peer->dxs_port + 1) & 0xF;
+	doorbell_npa_gart = ring->doorbell_npa_gart | (peer->dxs_port << 8);
+	dev_dbg(adev->dev, "dxs_port 0x%x, doorbell_npa_gart 0x%llx -> 0x%llx\n",
+		peer->dxs_port, ring->doorbell_npa_gart, doorbell_npa_gart);
+
+	sdma_ring = &adev->sdma.instance[0].ring;
+
+	/*
+	 * SDMA commands copy from ib to NPA, insert NOPs to ensure SDMA copy commands
+	 * execution doesn't overlap, doorbell update is after data and wptr update
+	 * finished.
+	 */
+	div_u64_rem(ring->wptr, ring->rb_size, &rem);
+	amdgpu_emit_copy_buffer(adev, ib, src,
+				ring->rb_npa_gart + rem * 64,
+				64, 0);
+
+	ib->ptr[ib->length_dw++] = sdma_ring->funcs->nop;
+
+	amdgpu_emit_copy_buffer(adev, ib, src + 64, ring->wptr_npa_gart, 8, 0);
+
+	ib->ptr[ib->length_dw++] = sdma_ring->funcs->nop;
+
+	amdgpu_emit_copy_buffer(adev, ib, src + 72, doorbell_npa_gart, 4, 0);
+
+	amdgpu_ring_pad_ib(sdma_ring, ib);
+	WARN_ON(ib->length_dw > ndw_copy_cmd);
+
+	fence = amdgpu_job_submit(job);
+	r = dma_fence_wait_timeout(fence, false, AMDGPU_FENCE_JIFFIES_TIMEOUT);
+	dma_fence_put(fence);
+	if (r <= 0) {
+		dev_dbg(adev->dev, "remote %u sdma fence wait return r %d\n",
+			remote_accel_id, r);
+
+		if (r == 0)
+			r = -ETIME;
+
+		mutex_unlock(&peer->lock);
+		return r;
+	}
+
+	/*
+	 * poll remote completion writeback data
+	 */
+	r = amdgpu_ualink_remote_wait_timeout(adev, remote_accel_id, wb_cpu, seq);
+
+	/* increase local copy ring wptr, only if FW not timeout */
+	if (r != -ETIME)
+		ring->wptr++;
+
+	/*
+	 * Release ring lock after the remote FW handle command completes to
+	 * prevent race conditions.
+	 */
+	mutex_unlock(&peer->lock);
+	return r;
+
+
+unlock_free:
+	mutex_unlock(&peer->lock);
+	amdgpu_job_free(job);
+	dev_dbg(adev->dev, "ret r = %d\n", r);
+	return r;
+}
+
-- 
2.55.0

