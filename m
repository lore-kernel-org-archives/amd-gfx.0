Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A95C61CE2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3EF410E885;
	Mon, 24 Aug 2026 22:14:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zK2Qv6Yk";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52D2410E86B
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJAsG6r6pggtZPJqAR2+Dh11sbxLdwC2hnqGWfw5Oh+BT/p3zc6VECdAgTicrL+MFcmuhBjQAhaMJG1kf73WBYxZxF+KNu/McxR541jQNGz9Tw+h9y1LIzp/xGyv5B5g4fRoRcTF0McEie9YEZmReHkYSQQxeK35OPRzuTgu34gYPTqDDlI76QyXgEw9rLyzqDXoq4TnbEGT+1zYLbXJxbflrUuUWGRWF605Tdk1dnm2xcRVIVkwFQ7OjdP6CcnXLniOkhJO1pDhA2vR2GiZDT2eHdxNcewEBVYY0Eg/gRal3O2I4aF7ZXoEXdBoM8Tw/dacGuWc5sZOJ434o2nOZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+YRF8426SyHkcRMLFuKlYUf467LZxM6VGz1Y20NvnA=;
 b=pKyQeW/YtQZyIeB5yT9qMCvAgNxRJ6hydpoERYiCx8HrJyb7jo472Z9GUTM7fxzOb9clP/cwajR5znAKbeza7vLxk3F2MWaM8UvTlK0kBCyQRR3hxJjwHeCSjZ+3wu+y4GXWpEy24xQZLGSN9DCLxHhI6mc4lTnJ1lKQGkPNYxs1pyjZ40EB016v/iSSy5px8ofJtmzCMKVB9Wp4q9nsuYLnVRASHBPVeVpQ4gXKQUfKhqz7FVQh1nwbXJcYWymjYDXIOqPHjtSjXYNs1LPpQTonS5VDF2pgMy0SSGngIngA7R8J9arg08kJNyw2GXA04RmXlbYB6qI6DfH27nxO1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+YRF8426SyHkcRMLFuKlYUf467LZxM6VGz1Y20NvnA=;
 b=zK2Qv6YkBU34dUyUojGRmX4Riv9Gmy+epcg6SSPTf41+yTxmC7fgCyZUi5wJonTNjJlxC6A9XbmFvZfgia3+Dpqw/p/n0tIXRUIaio3bJW7s0wXVd8qNVYczumFKLiVJ9VZuWgU/uw/TKM4S2VunCsTdOm9h1Jven2E1Xwb6RRU=
Received: from BN9PR03CA0524.namprd03.prod.outlook.com (2603:10b6:408:131::19)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:13 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::b) by BN9PR03CA0524.outlook.office365.com
 (2603:10b6:408:131::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:13 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/30] drm/amdgpu/sdma7: add tlb invalidation buffer func
 callback
Date: Mon, 24 Aug 2026 18:13:36 -0400
Message-ID: <20260824221352.1793542-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f52a9c6-1d80-4dcc-fe88-08df022d07cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|6133799003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: vebR2ruOHgNSK6hOWbkvMHDDKG8JZQRbRzvLaXjr3gg3c55xymPu7CsyPZglGBQ67dONUEbjr79pIcwvx4G2QMTc50MaKmvsqopylmMnAJahtEHaYUE/AIwMuguP71KKRt8IzleMR5LJLfaqvt31k+16zyjiDgLyuUJJNwSqqurjAMUYFZp8GoITOhWLVXONwCMT/VmROFx7TrZdKrRnauat6B/ptIrWoqadJUumKENPuf8lf+78JHzx/2PCGK573oM+lic/WqZDwFmEuAulNMjvqwJCOWsw8RI6EAYlhnRz16o47o8vHaXZtvDw980RtetFqzcWz3rZ1LY6qiUzl39xkH7LFrjxqn1rH6gKA+SaNMX5v3IftNRdMghJqHvEbA+q1TkvW4gLyl35uzyLDiugljSQX0Ut9VQ6qGDuV1STKzcOuW6O+DFaQg+3yQ15yG29ifbIluBW9oikmtnFAZxh0V2S2P/HRbkjLx1tmdLTJ/OwJCYC3yI+MuJqTh21EKXnotlKwvWt+Q/+KxqfqI3alcl7mjxEtaQ3dGWLOhLKkw8KrTiG/Vo634ZaHWg8UYy1qvA9z/2aMccQsK27a0+SzK+c8klUxXS8mnHy5LUz8uCstK9K2+UG8/IsR2KHSeVwuwmEeWnYq4fIoOLJNMASVRyRygjCMxq4yNdYb6aU3hQmH19ZGbLzl6WUBGjjW2Eoykp5rZaGwys8uXfDAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JScqYokXELojnOW6g+CBZfhekLO9fVzUiKDcM4QW/NIhOKnMKcQUxVSFCj4LXhlIJVmAWbt3rIwZ2TsaknZS4H7CE4ZJ0K9hbf2hOHoqpR0KAGxWrvC7KXJcz6qXrPgygUnd6Hw44tu9rxlPuEn+mA98CdsIU7pvDjgWn9ULn8/wnoTVANKdrgzaic+7M8O8JxcaS4ZT3ndgSrWGh/EnENcwDiR8FP9lu3Hvsj7anwQF9fQuJYRWvJ82QajgoqCvI2Trkw/fJsMHpVeqGpbLO7x/PFoujrs1cieKs4D3VmybO6ztspYtA/vC9dilqtVqhcFi/C95mZewa+iFwAr0XxSkfYKG9HqKvDH6X3KDV6AfXWaeym8WgSyVGXqqsL3jZEQh0vZlGQAomJId8mWY6FF6xsQe0V+oNWvGvwB9hXOR980Xt9OMfSiQvoB6hhaI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:13.7141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f52a9c6-1d80-4dcc-fe88-08df022d07cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494
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

