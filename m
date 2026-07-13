Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE156C4450A
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 18:27:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 501D310EAA5;
	Mon, 13 Jul 2026 18:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qD0aiWk5";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5638810EAA5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 18:27:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iy+Jdl3flQS3j80Uj97z50jwzGz3TRlj0WaD20AZV+hzYZd8Eu0GtwZI7vKFyEma82M9weEmRGbsVlPKY39UHXX8S7mcqjGaUN09x4xE/7fYn15O7iUnH2CVThAuu4P3AvUUFX5N9+1afA7Rdj39GVwuw0VfxX4ZG73cmoHJs8F2RsXOCIyJJj5o09SqEdh/O1L8X/pEaeaYvDk4KOVoCmUJIspfp6Wtc9675Tdjb+amcUV7vCdj/4J9ALYCmmqZKFyAaCvsSjqX5ylPqtv9oFaYcuDqADh8ZdU4EjyGB0Kim/0GgI8A2MU37sIIvE2Z46to92lw6mbKCBU4+MxCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I57pkuUGaIc2/+JmNu8pvtyWqf/W5kdmEFpLvbqj9mo=;
 b=FmcnYL9sWeGuud6077AFPBzNEBni1gowFNQNOe+f8Ygpcm0eaRFw1bjkOLDnJQUlPHVa4lPXrG36EloAs69ovzIs89yduDTpenKu+fm/Re/7Hrr0irkMARsbAXbb+DT0Aa5OmwWo+4LKRJsh2otHDlhNU8N3FlC1j8FvUcjxxqI5dsGqQQZcY08ZMVrKVVkCcB6atjDyE+qx188x7KHMVmAGk+SYa3poaFrDfIWbfBIUDWCbHG5ar9pVzK1tBw0YHJaH6hEVYXy5Mc/KPeDPP/Oh7lNP+qx7VbodU+Ed+1Jtfqazo53aja374qPA0XmRdNrM09Nu5FejKhNhRFl3vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I57pkuUGaIc2/+JmNu8pvtyWqf/W5kdmEFpLvbqj9mo=;
 b=qD0aiWk5HeHpWafsSq3FF2w5gfR1bCwqJWJg6++jO8H3tXhVQbQFJomzYl1D6xnZM+eZOR5q4qPczYAeAzlGJM1in2PzBRDfjSKU1w0angp47nooG91lrP75jZb6KHhEC8xwpP1e5NAb6SSzBPNWVgjQbcwiJPWOLGcNI9Q2UaY=
Received: from SJ0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::12)
 by IA1PR12MB8519.namprd12.prod.outlook.com (2603:10b6:208:44c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 18:27:48 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::e) by SJ0P220CA0005.outlook.office365.com
 (2603:10b6:a03:41b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 18:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 18:27:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:45 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 13 Jul
 2026 13:27:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 13 Jul 2026 13:27:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/14] drm/amdgpu/sdma5.2: add tlb invalidation buffer func
 callback
Date: Mon, 13 Jul 2026 14:27:25 -0400
Message-ID: <20260713182732.630947-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713182732.630947-1-alexander.deucher@amd.com>
References: <20260713182732.630947-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|IA1PR12MB8519:EE_
X-MS-Office365-Filtering-Correlation-Id: f0cd0487-56f8-421f-9adf-08dee10c70ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|6133799003|56012099006|11063799006|22082099003;
X-Microsoft-Antispam-Message-Info: sMNdlqxMOxNGl1pCHL/Mq3HVktUgc/raLosun+1HhBM7MNnXZ24IgfY3ErsWjjfLQtvCoxbwJBVtqUETBNUiGFyk7Zd3kgSWjkc8FZiUDymFEiR7dOdPrgI0lScMco9xxtr2epyMF2HDg9TQgALGQaR9YDmme0rmLpH4NwIGhrJqQlweq4YYZK9u1cTw4s/utXi3JDAs6KquHsK+iw2rNY8VH/Gzqb+G9jZoGKMUsbiZhiD38mF2+yFiYEM/iB5BlOz5iJbEXVWRiximEZ/LdGJOS8v+m3Bcbvk0qjo2Xf2gTENiOrZU8qApygPhjFIZyNCxAAX5z4Y6kI9NrQrd3y52775JZ536Av/V5EsDJEu/4VI2zWH6RDTWwP5UrJnddrcNug2be5qr9J9lpRJNZJtblJBetO4XFh3JXhZEpuEamvXf017X+CDJLfRsTQE7RtCrthOKsIkrCXKhlEk5zY1/7aHf6+ssH2g/BAp52LlMnzt8kAYUmts2nbMZ3kq+sPbhg40HP6jSv+IgUV6ovqwpgOy9uDRD8lHhyn97Ejloz/uYaFkBhHk1k8b8WWXsTO9IX2JHGlmDV87KO37Pg1IlncrurdwuYm0Taw5DlpHPgeUcVUB0ffWMuEpLAzcuarzDh7cEy9uaKoU+7FndkcFVnxUremYkrFcViJfde7pbVmGKY/IX8zB/a/zbWGgnu5WGLC6osh4yx+bKmHnTCg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(6133799003)(56012099006)(11063799006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WbqYXjW57sb/j9oGsciFCupCCqLFHikJxxqQgbXHuwF7s3oJeUadS/poZP0Jc9ki7KEYL843TX+oFvpC+USmy77iNa0IK/bcFKw/FzxlEWv4CvndmFOWcHRtW4+RU77BbLQT3c1IC0y7ECM+2ZCkY4D7LIFAADzBrz2SZzWnirh5Keu6XzexJDxmzUznZm/ijkI+aYNgA74YpXfa2X08TDku/XJhIpHNb5g0zLp4759ICL1V94g11myyn47ksuxrQX0FG0MPL8pRJ2m230/ORU16/bUIlnTDNSOma53GbbM8Jl75JNFj9JQsfr8W8rSYgXzoT6urIDGqtxuFWoN26C4Du5WaWlu/8/TXLpwlfshWvgKutZVBaOnX0UTnIbyZW6UXr03CO+zDNR5Q8ZrjJ4eET2kPcE2+0DjFjoq80pRRgB4SZGdODTYPaee9Opov
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 18:27:48.2593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0cd0487-56f8-421f-9adf-08dee10c70ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8519
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

Will be used for TLB invalidation.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index e112e3e2ed26b..e6a5dcc1f4c9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2053,6 +2053,52 @@ static void sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v5_2_emit_tlb_inv - Invalidate TLB using the sDMA engine
+ *
+ * @adev: amdgpu device structure
+ * @ib: indirect buffer to fill
+ * @vmid: vmid to target
+ * @vmhub: vmhub to target
+ * @eng: invalidation engine to use
+ * @flush_type: type of flush (lightweight, heavyweight)
+ * @xcc_inst: XCC to target
+ *
+ * Invalidate TLB using the DMA engine.
+ */
+static void sdma_v5_2_emit_tlb_inv(struct amdgpu_device *adev,
+				   struct amdgpu_ib *ib,
+				   unsigned int vmid,
+				   u32 vmhub,
+				   u32 eng,
+				   u32 flush_type,
+				   u32 xcc_inst)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
+	u32 mmhub_eng, gfxhub_eng;
+
+	if (AMDGPU_IS_GFXHUB(vmhub)) {
+		mmhub_eng = 0x1f;
+		gfxhub_eng = eng;
+	} else {
+		mmhub_eng = eng;
+		gfxhub_eng = 0x1f;
+	}
+
+	/* Trigger invalidation. */
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_HEADER_OP(SDMA_OP_POLL_REGMEM) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_SUB_OP(SDMA_SUBOP_VM_INVALIDATION) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_GFX_ENG_ID(gfxhub_eng) |
+		 SDMA_PKT_VM_INVALIDATION_HEADER_MM_ENG_ID(mmhub_eng));
+	ib->ptr[ib->length_dw++] = inv_req;
+	ib->ptr[ib->length_dw++] = 0xFFFFFFFF;
+	ib->ptr[ib->length_dw++] =
+		(SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_INVALIDATEACK(1 << vmid) |
+		 SDMA_PKT_VM_INVALIDATION_ADDRESSRANGEHI_ADDRESSRANGEHI(0x1F));
+}
+
 static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
@@ -2061,6 +2107,9 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
 	.fill_max_bytes = 1 << 30, /* HW supports 1 << 30, but PAL uses 1 << 22 */
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_2_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v5_2_emit_tlb_inv,
 };
 
 static void sdma_v5_2_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

