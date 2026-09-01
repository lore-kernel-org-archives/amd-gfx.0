Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35809C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA0A110EEFB;
	Tue,  1 Sep 2026 20:11:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m1FgdjC2";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE36410EF03
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7XPHLUmA2Y8bfgwVG3XKX0tJr/2/xbM6YJVXWioUKVsmSQmGelwQYxuhUwb4OyQUAYht4xtSlEk084dlPmUc4XxxLYIrxkJKxLcrAG76y7fbTRWVRe2kdTDkSmx8QeJ2vuIKijo8RqucICXwc+xTX2+ohBo/iaKxOCIhklfpSztuE0YFKybMDeXLaWMOrafg8rlsh1gG55J9k01wg0uwEX9B3dNbejERh3CROEFyjfCwnV3NJtVCWCrewllKB4nhhLvSZip9KPv2tEDIENiEWoH0QoY0V6RcbctCcfaabyp/Mf/JRn+KZT0hvMa+Mb+Dp352X4WAAzRM3Sac7O0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNtQuHq8dFwbGF4wxtkGT33hkg9HYxUIo7MZ42e0214=;
 b=I4QwLtGu7BAqiwrQ7d7Mmmn2bX53OiV79zbqNSb2Der0KHSWx4YfRKdFmENMLTdgMgGOEP6rNArANGdUhATuITuIln6XRWb1MdkCnNp12SN6I27k7rOM3A41ECMPhfIoTXIeXJysK6ybTR834Nccop43y6vQDFeUwd8/pYFPVNQxXVC78RVv39YIf+RXqNmEfD9vkbKa9M7Q33bTK5dv1LY7n7e0SKXZXtcQ/TaHzVUnZM7T2yReJS0i3p92PdxBjXti33Jtkzk+MNudtEPnviufPp1PDLi0YPgNFF6b2Yx9BfvIpnI/IJS30R/7JH9eJoXS44jkkUAQZiNtbFiE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNtQuHq8dFwbGF4wxtkGT33hkg9HYxUIo7MZ42e0214=;
 b=m1FgdjC2Y6djIJAIvvhpc0BZ80IwyIwu6VXTrHmNqyGtftauiKKQ0iP+8kAE30610pKm8rZF57ieR+Zcovfk4hLsZMTnSSUCYBup0YB+pR12ewKRZda2LWJVy3p5Ki5SC+yT9kGUVY1x9kxLOUY7UC/V5xOfjUsGbHStLlLjeXo=
Received: from CH0PR13CA0040.namprd13.prod.outlook.com (2603:10b6:610:b2::15)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:11:00 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::ae) by CH0PR13CA0040.outlook.office365.com
 (2603:10b6:610:b2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:54 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/31] drm/amdgpu/sdma5.0: add tlb invalidation buffer func
 callback
Date: Tue, 1 Sep 2026 16:10:15 -0400
Message-ID: <20260901201034.2960437-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae0ba48-6db0-44e2-9fb1-08df0865247b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|10067099003|6133799003|22082099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: TQ9V/N78/FhCLO/rTpSrXpB2wFMOzFr5pMljZK+2nB2JfuYyJBqglzKW92bM9yauUarTtrFVjQE7vF3t+JZ3LDQscVGfWt90kkwQ2Q5U/oC6OamQ5Yad6xybht+WyXcjIW83r02Z6qLnVLYpt6S+841/PRJwQRKj0+T2tZD4AtLzeadcPDqfSIh6yiOQlLyqXMMcF01gXZngV4Jw70zWRc8oXcDzxgRju1k8on2+TRibsMy6PiEtxDLD683DXZqQRB6iVcokegHNIosO9W+LGFH+B+aHoOdJRuIzUncEjJdE3Y25f33AE6UQXYJrQGV24CuQLdRUQKxD3H19RRc+h7UF99TDlYQDKkGO950amP9Mk5JS+W5nzxBGvE9L463bhtDkIBYRPMKcv7k5XOaLSRji4C7qvut9mLUb7cmeOj9PmXK6w53Bf1+hMkH/8p4FUQZYC4wsUf+jvmucm9f+/UalLMCditHhO4gPJlNYSUqudl4vaHOupZitRi5ZEAE7m6b33pmtvxrhxCtbXWVw4qcP2h+XQwmFMwzXDTG+Ifff6l/9AUmmL2Z056JupIe2bageieiU/yLO3Td8BnAEcqRisQhp4wlFCuhugOV3KgGibf/ZegDBreO1ref932Rkd1xiS41oDPTtCf7w5uwdHXV5CSsc3KCD/VwwhtpP5LsH5LftpcAw6K2c2ftfQCq/Jcom82OvgtsRyuVyLBtBdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(10067099003)(6133799003)(22082099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fc8HBoLLu/jHeYzq4DMnHxL8Gi1sMM2gRE8bC/Ccvc4GGzLk9J/gx1mv5x6CbblvzDVEJVTm3VUdbzIpfGY5BZzFsoP4rFS+wVDpiFwaWOS++XSiAoPQVcbn6ae70oA0mMEUJnycmzgsNf6dL+kN0zcMcQL/IPwQbuzF16FU49Xvj69HlIb81gMSXXu8das97bTzBVMWD7UBFBGycgkS4gHtUSNqbzxP8r+qKY5dVJH1SfGKLEqu4r6TGhzXgZQ/RpsGvgaYF034SJ1qSUhCpeD9i+dD54a5chUod3HeoGMqvzI3l1CyAYLUGUOQWhDG7ZsuWW8sWcnEF7ZpD3CnCDwE0TV+SkJTaQwIrqvOoEElxOAfsTq8OZUZLaLFc2zjLZnxnNIFOMkzV2ESckTUaDoH+pnGVz8ulW9HgIXWq8W2T64zNEPweKhojwMUCw/U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:00.6250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae0ba48-6db0-44e2-9fb1-08df0865247b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 97fee70dc2f64..8cb579ecf522e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -2030,6 +2030,52 @@ static void sdma_v5_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v5_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
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
+static void sdma_v5_0_emit_tlb_inv(struct amdgpu_device *adev,
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
 static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 	.copy_max_bytes = 0x400000,
 	.copy_num_dw = 7,
@@ -2038,6 +2084,9 @@ static const struct amdgpu_buffer_funcs sdma_v5_0_buffer_funcs = {
 	.fill_max_bytes = 0x400000,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v5_0_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v5_0_emit_tlb_inv,
 };
 
 static void sdma_v5_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

