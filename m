Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EDAC5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:46:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 280AE10F4D4;
	Fri, 21 Aug 2026 19:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Winrz+kr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com (unknown
 [52.101.46.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9D9610F4D4
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:46:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d30i3MAHsZzDBMOHF4ibrV+x0nmhUHzEKfxi+JMHtFtS06vYZH1feyJOzF2XvU+l9EwfVWvIgjbjtHcmlhJRaPV/GmdZ1q6tomOb4PAxqhoULlhb1AuTtkPJMSroLPiv46fgq8owwGTmKqsmIL5KN9gwLkrd0f1KgoqyccoJYA09x5vE50z86WVolbgL5C9FDiQ675lXG6lAK8C4+NCvagskG0slIz0Smx5ZaCr0O0qpRV7ie80hP2DK+d+RrEsdsiZE+D3aT4HMycXLfsoHNZZxipJXwKYEbZtlJw1+Y6bAQk33k++lgqqAd73q2+P9rYYqgkRZPKsbiysXHOgcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4wx0nmSNpISF0/cMbwXH5pS0jbNw6tOvQ87j9Wvo1g=;
 b=h1gVeaX1lAxI4pWcpmCkbRDOicC8ZcZ6G3ExSLGRi0UxnqaIPif4XwcosnSmonpomeOvvlDz6nfzR9NP5g2f0+z1UCz/SLMKwpUub8vvW/XcT/BsDmReiT0emrPkoVHs07HMumRkN3dIfeNOlGNejsIsQclZojWQ50G0szg9CYruOfTCyKO2ZisotU1m3xYfpbCjjSzA7/czDcRpLaE821oPDNBjNR3W4rzqDAj3jjJ0LAvompl5WKcZgxhicb8n8O/spKcgtmluJ7szYVXNelv5+oULqvc7uVx+TSC68KVc+4aYB+XvAIakDvV1KXNUpUfVx/pZ+UVVtD61sO6FlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4wx0nmSNpISF0/cMbwXH5pS0jbNw6tOvQ87j9Wvo1g=;
 b=Winrz+krm82Zo6CCEZh68lzYkC49HgjtL4mLsDQ3uakWr5Q+tci/DGJ3E3CfHUuhJefHqVjVMvRpOehXOOA6wJplk4qoT3JWkaO/0UdPO2ByOtYqd2GUoylQxJPrYHJask0XaDayJ6dGhrslxJ+6kIXc5uqRzbGm1p6aOfBl+fo=
Received: from DS1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:454::12) by
 IA0PR12MB8253.namprd12.prod.outlook.com (2603:10b6:208:402::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Fri, 21 Aug 2026 19:35:45 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:8:454:cafe::63) by DS1P222CA0007.outlook.office365.com
 (2603:10b6:8:454::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:43 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:34 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 38/95] drm/amdgpu: Add UALink remote command packets and SDMA
 dispatch
Date: Fri, 21 Aug 2026 15:34:01 -0400
Message-ID: <20260821193458.808626-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA0PR12MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ea4400-203b-4dfb-1850-08deffbb63f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|3023799007|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: m7xWpLTp0QZvylHrscGkk1oRowFfF1DiRUO6ERP9YxX+e9fKYhbxyixHv8MmECuEy2SrtXNg/q4FmNComR5h56mryseSjvsdZW0cwOT+3SnIyA26yu+I8MJsUdtVPA7P2YfpBUap5j4SqOhL+eemKUxFJpLblMKCAGJhwwDpkl3XbvDLy6hyffJVvBSv9VQEEAxplMgPozfuC7h45b2M7Ze9/PjDKrl9gCyYHYoqXSaYst7DaN61zUUnInPJpNlOEuJbcMyzE8BsW/VpxwKCIcgJGdaUpq3VFbc3i2t1ev+RSDIPUmF4YwNe127vsXMf5EL0m6KfahT/qGqaGYPmw15aCvQOXJfZu7E1hbYTnpGnnJlk1+gMlPAAhziTwkmNeAhLw82czI3k8DTIJYgpqfH3W7uDIuoHVb/QTspg8THVMvb3DIWW0TSix1NDvNtUJkJNR0OqTSq+iFFGaYrWiBY7c07j22oiSOahPKyfo65Tnm9Tnmo56Ro3aZiX2DUdccwfMUDgqXirKDPy1poVXKoBgk9GcE/LoA0mCFxFiUZ8Ath7DAo8BoO3VDYqgKulX+emiNHFXTZQvQZ58HXn3R0te76sMMdSVpHT6oiEr4226jFVOeZROt3uAm1wECngAAZpl3llNK7mvhdTvsJGxEc2RboCQSj5VrCVC/UxeIA94M8FXtM8sUpLzkz8RfvEpZKfmxU26W/dRetHoHRiCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(3023799007)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XbjvanFA9ML/ldFmOgS1iNBLkHwD2AgH6qkcARKQ/qhTCcYaidA/B1bjSwulySCt5LJNqE6ghg68kln4HUqm6lJHgG2CBe9XCpUeh6/OVg7VK2B/eVl1bNVR1Y62FqgGcgMivD7P/17bu5y0mHLwaEx1lwnHymIKV5RStTauEgoE7QANs80IZ35HmcYM+JDkNFBZi7FMA/Bh55j4KiuaxHMULg7w5eyjr4ejZZxss7BlBoVvsO5MYxU4gpf6KNRq39DDEDydpYuEaPowqNo96GrlrMvHVvgipAaipBUHc7pug89Gea5GpTW7P6eU5u3FX4w6ZJWnDHzLykPec3UYUIsWKFz6mn0Zf7apgn9IpYqFQghL1yHht9l49QdqtBbNi1SrWEVN73UGazD1l+AQ3WFZ++27EteHHK/5T8zO+AzepudvjB1wgt+e8w1oBEHW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:43.3046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ea4400-203b-4dfb-1850-08deffbb63f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8253
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

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 347 +++++++++++++++++++++
 1 file changed, 347 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d212416213960..913d53fe91fc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2304,3 +2304,350 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
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
+	u32 seq, ndw, ndw_copy_cmd;
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
+	dev_dbg(adev->dev, "src 0x%llx to npa gart rb 0x%llx wptr 0x%llx doorbell 0x%llx seq 0x%x\n",
+		src, ring->rb_npa_gart + (ring->wptr % ring->rb_size) * 64,
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
+	amdgpu_emit_copy_buffer(adev, ib, src,
+				ring->rb_npa_gart + (ring->wptr % ring->rb_size) * 64,
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

