Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0AFC624D7
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22EC510EF0E;
	Tue,  1 Sep 2026 20:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bb12bIVo";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6EB310EF0F
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sG1Kob8zCf9bdsKvgi0tojmeMY95v4MOJCaKJwJdvDaLXyqEycyFCGYR5ccdwR1cHSoabTBUtIFhE0E2i9/ff79HBt6LM4oEK7flZvgXansHfGFqCqXROhnAwew8XxH0jQtU9EumpSP52jHTutvvTiMS1PLro06k5gMGN58+aXBz64t/Ut5gMe/DsudXmmwFaeJXWUt/mGwEBWgdJ/SoYZAGldYgV4o3hFgjCuLSA4Bf9dgO8GVsgA7ECtn6r5/96DiRgU3CdJLGV1vkbZ3lEgET++7Gsc8TC8d+RWcpiaBbc4a1WPJNshyyanpDFbhDrDJFNNsA40WjQVofan/6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+YRF8426SyHkcRMLFuKlYUf467LZxM6VGz1Y20NvnA=;
 b=H/Dn7CN60VxQEsuv66b0iwhKGVtca+tke/GaXdRfgzvwRWJEq9PApZhAAMilL51a8INDFSDtWuCLgmHuuu1UD5xX+DxVtnsmx1sC57pSGiikGNNcb/CbmccIb/xIYVMVE5fFxIv4EJAmeSlJvDaaC1dj3OmhPcrXmKrsJKheyhDBoe20Q44kENlrTXNL9rNeEB30TrmE1AqKnhFOgBrL/obCiiB/ajQZMbntAx9xJyFo8Zr3MqGnpmmD7yIN7kyJbt/pZWtScjZIbAfI8Qr8FI0Vs5tZ0yE19rYm0sI2Wq1Fja7eYBUsiGHcQgEc+VKqf4YjxMbLY84CtT/gFc/ieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+YRF8426SyHkcRMLFuKlYUf467LZxM6VGz1Y20NvnA=;
 b=Bb12bIVoz6NW2J7YCZwo4VJId0gTimrGKw0Pvy/VrPSuYaHZvLJD6SbgI9/ElPfUiD4DJV94uJ69AAyOM3KParnaQiW34mBHgZD3wzTByBydr8NMIQ91o6h9S06uWsW1QbG5C75F109ZXOSY0VFyDJOGXtgdIwciZPIDowKEQQI=
Received: from CH0PR13CA0039.namprd13.prod.outlook.com (2603:10b6:610:b2::14)
 by SA1PR12MB6946.namprd12.prod.outlook.com (2603:10b6:806:24d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:04 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::5b) by CH0PR13CA0039.outlook.office365.com
 (2603:10b6:610:b2::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/31] drm/amdgpu/sdma7: add tlb invalidation buffer func
 callback
Date: Tue, 1 Sep 2026 16:10:18 -0400
Message-ID: <20260901201034.2960437-16-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|SA1PR12MB6946:EE_
X-MS-Office365-Filtering-Correlation-Id: d11705a1-a8ea-487e-57ee-08df08652678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OTtDISZ8e5XD67VcTBp3jMR/bPnpVA7aqRFpHBHqO+58XjrA93Bh6E1r+DjYF7IfV1+yrW+JYLdD/p+96tbErgFGGw51dSu9trxvmJOQh7GTNJkd5k6/UicYQA6pJKQLE37fhQrthKw3EpzdDOua8Vf/FE6SgafT+D7jxioXd1GRLInOpQ6JKlhaU6ceK47a+huA4qFZa3kmFKPwkQEvtVpAez10vJS1J3nV4eLcyQpgUSANSqt9GhpNEOIxRvvSAXLBgk3DI9PYg3v/DBeXMh01Ly7+aXa4QYXL0NaNRgXkCgP+3PCm6DuewVOY7RTZociwFIEt6LGBVOYUxUHhahg4VqmxtAebc2E2yd4tS3Hvalhxmdpya//fT8iG6DaFgqN0EfTD7QYa6WnvBubWCzxr1lwVvbGFJ+ci9h4Vp/Q7HWtlOikJdOtUyaGWmZjn7/DqTPw+lssHIUF9xY1KDEqDu30BvaL7AfZlMOWjacVbfrI9WbDWCJm3GkcBZfwXEGnfW5yMkJB8nMx5bJ99gKNjle5YMbbc+qgnTtXgv/uvAQq+oau+AikHSD/8e4yxFHDwYZvjgvViHqHRJql1NHP64Mj3zzhf5hFRGdIIKSbRg+iuKVfD2PVzsSsXq8OiianjUvm7vQM31dy6zrLCOxPBGdXq2mNvinj0HdISbcadDKykb63FVIouJaUZ3X/O5lquVEkq+SiDFa4XRQss/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dB1UrFjwvLNdnZ7bvO71K4voI/b7Ce1ln/q+2ad/PV4HayxkKU8PafvAe3jIPJZoZXalHPJkak4EHIoHAJHgrA3BgPDeTPZOt3+b6nmpeWSp1/S6Hp7uGTtm5Q7DM0T0WYzaUabGxO0COfdavxaoxofSTesjmssjNSJgbjx7v6Gs9tOyEXjsnqDPG8mRd99QrtgfAGxy4c37R9uH2S/TO3Ya0+7N5kcJ98tGf32eea+mPuGXIBpzCetqV/3y1ndW45tP3hsy0Pcq+rU/Kh/4bIkLhDE4kwXLiITc84M8YL7vZTGoQNiBgqr40NFTv7U3LnbLt17TnsRuzG3UBaHRnEvNE+wMIqg3QAT/I3o+ZOcN1BAWVAjsQKlDLvwzqgPCV5ffOBE97uEoeVQJvMCRLqlqKzUPpaWU1FvNotjtZR1jQQ1IqW5W7TG0YnN01upR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:03.9595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d11705a1-a8ea-487e-57ee-08df08652678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6946
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 48 ++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index d5552f206e4dc..dab2d08d8766b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1796,6 +1796,52 @@ static void sdma_v7_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v7_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
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
+static void sdma_v7_0_emit_tlb_inv(struct amdgpu_device *adev,
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
 static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 8,
@@ -1803,6 +1849,8 @@ static const struct amdgpu_buffer_funcs sdma_v7_0_buffer_funcs = {
 	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v7_0_emit_fill_buffer,
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v7_0_emit_tlb_inv,
 };
 
 static void sdma_v7_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

