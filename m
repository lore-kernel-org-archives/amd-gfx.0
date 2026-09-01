Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02F1C624D6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A01D810EEF0;
	Tue,  1 Sep 2026 20:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uof0gsuk";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EBE210EECF
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:10:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1YkSlA5FPj2oOPSSzSnbiBMDgDFAPIX8BBu4QzvCav/F7wc88/9f5Kro7s8KQXmvNg9YfKviulsW6EVrz8US9JCgMMF+bV5iFNAdrgAzzXbrB6lX+Oy3ZkpP5m3lIXJMgNRbB8c9yRVXZrHGoQrJSmA5/qLXzVBLm1gqsQRRRBpX0Tc0rPkUKba4DJv6MHRWt6fjmDaOQ33TXlq9ejp8eugtCZhNnW9V1UgPD1aPydgK8itML14CIBhmHYeBglCx6V5GTsPxRiD4Ww6dpHoDSa+KIygkkUctzUMuw7+B6ILE5teCp8P4Mvk8PXmsP7cVsKTZKvZRwMylf2wHjWnNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHSPlCKEF+sja88zj6Xv7Tuy58jWiRjAi4zKg46UUEM=;
 b=hnsZBcIOb27ONCWxTQ0WMDjpfKO2XIaVkykWwv1YYsOLebIvEUZXQ2pLqTEdUqWlSJVnwF67IbcGZ6PzGvAswe1p6mG3ZunkAWziXQu9/K/SpJJ+O4zQxtvQ8kiVj6Jwy2s3Tr84HG9823pMjnkicG0Ddg606YpNh65TIdgqoPP4xPG9CJDIq+zjycOCszlKDn2tRRmTq6yuEHu5ak1vp4ESAqwBCtvsr87+l8iNJVimsUdgc3JYaZNhzL2PPjZXpaDFpqqUkvoRFoqQrNmPH6KgnV4sNBgBXn5NazV1I6tXh78AjjqGr9conBLaB2Pnrjj0O8aCuKRed8SeToL6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JHSPlCKEF+sja88zj6Xv7Tuy58jWiRjAi4zKg46UUEM=;
 b=uof0gsuk5bBHDhgD91wF8lMhlHkkqiAW1Dj2+RrOk2lMeYaN3wW7mJjCg/TKiD2HXEANiKzyDwePoaWLY/DAFMrp2+UebFmM87wdB85bR3YhdO1qpAywvNZ3HryqubuJ4+LoA04XKyu1T3Mei6UABhgRgm4RfgPNpVzTWbCsQug=
Received: from PH7P220CA0179.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:33b::27)
 by PH0PR12MB999112.namprd12.prod.outlook.com (2603:10b6:510:38c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 20:10:55 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:510:33b:cafe::9d) by PH7P220CA0179.outlook.office365.com
 (2603:10b6:510:33b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:10:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:10:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:10:53 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:10:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/31] drm/amdgpu: add a buffer funcs callback for TLB
 invalidation
Date: Tue, 1 Sep 2026 16:10:14 -0400
Message-ID: <20260901201034.2960437-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH0PR12MB999112:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b41a4b-2a29-4ee4-4477-08df086520b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|6133799003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: ghEmOvonWVKhp69QV5RVIDYV3gRyZb7gGpmkY+aBNAUfOD0gy7vGQR5iuGDcpkoYcLVamDdgWf0kdbfLYVaLZbnDOcpqiuZWuUMJoZ+k04mLKrKrkAH+6NrUyq253ogL0ZPP2zu54A1BcKO/DNWyd4DEbEJjqj02EeMt7trv4LK+2WMDJFap40rm5WqWDcdTTXjMKUSlwgiIeQI/doA5ZPQJYRslHrf+hjcvFJACe4wIJccUrrXAe2hEcQhZRdQTdbIMkLFjqUP1+qyf2ko8Ibp+kuqOkdRYWfXbS5rXglFYOxXPBdloisMBOAnTVJWS91QweFqxVGi6bVbU+ccs78TbJF8jGI4kdi3Ri7+456NCPRUoBePkvinl2HuMltQIs5fGxFO14nNw65X7Mk3tWrLLz1xw6+jhWuXnRGAaHwOabqMSnHs24M5RV/wNycFrLBpFyVcFJMr13re5qt2VYoP5NfO5A42lJs+rSjnOPzmMBsIVbT9G30qQmhbGgi5khC0Nc6MUWki29ScQXYbvPYkdV70gvgXtfdeEkKM3ZDtJAgQ7PQ5yZILxBQiKpK5J6KBN/SjC7RtuXtAwizKvJssBWbwnyk3sSWoMAP2w4TN8x6/8l283ZE4XuRWOOiYCYVCR8Rc0rWmhzM/Y3HS8XzzFiwDxXnFvpgW9m6TQxRh/lHlgPGH8ix0+AVi1/dhKkD4Xs1JF69SW1mzxTsHNMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9sEJ8P4Zq2ZuK/nRukiR1UQ8gaBs5Q0tHivKVTbh6KiLRcXmYBc9oPD5f46emhHNaLGLKe0Qdqy5baeyQhtyQdjpO+v+x3fIo1o2jp6VucfP0r3IfQUnwS7wxnRVpmtVSYJR5KKU7ScFTv+SeE4uQaiLDgS4pXTQzJzDSj/5SDxMkuTFEe5rVpNhWeyNwsaCxI4kv5FtkjkKYiuSb/pov2SX2RCrY4JofNCi2rimgAnxVrX+ldg0ZXZneZ0yTVEmAzcZ3kOb2LN5JpxUG0m9117+drKnbKwGCf8R3h1zYeMG+ljydHMc9sDEvjmW4ir581UPoq9oD79hjfwZBD0eSkh/DG6CTrvJwzASggYR/xJuZn/H/1wZ0amWICluEpNt88lK1/er0Av/UywGRGtvKBWqAzG7GyxA5T3FmsG09LQvFydcetF1yFvczNefCgPP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:10:54.2476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b41a4b-2a29-4ee4-4477-08df086520b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999112
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

Use this interface to issue TLB invalidations using
SDMA.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index 4f4e56022c970..4ab92d287675a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -155,6 +155,23 @@ struct amdgpu_buffer_funcs {
 				 uint64_t dst_offset,
 				 /* number of byte to fill */
 				 uint32_t byte_count);
+
+	/* number of dw to reserve per operation */
+	unsigned	tlb_inv_num_dw;
+
+	/* used for buffer clearing */
+	void (*emit_tlb_inv)(struct amdgpu_device *adev,
+			     struct amdgpu_ib *ib,
+			     /* vmid to target */
+			     unsigned int vmid,
+			     /* vmhub to target */
+			     u32 vmhub,
+			     /* inv eng to target */
+			     u32 eng,
+			     /* flush type */
+			     u32 flush_type,
+			     /* XCC to target */
+			     u32 xcc_inst);
 };
 
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
@@ -162,6 +179,7 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 
 #define amdgpu_emit_copy_buffer(adev, ib, s, d, b, t) (adev)->mman.buffer_funcs->emit_copy_buffer((ib),  (s), (d), (b), (t))
 #define amdgpu_emit_fill_buffer(adev, ib, s, d, b) (adev)->mman.buffer_funcs->emit_fill_buffer((ib), (s), (d), (b))
+#define amdgpu_emit_tlb_inv(adev, ib, v, h, e, f, x) (adev)->mman.buffer_funcs->emit_tlb_inv((adev), (ib), (v), (h), (e), (f), (x))
 
 struct amdgpu_sdma_instance *
 amdgpu_sdma_get_instance_from_ring(struct amdgpu_ring *ring);
-- 
2.55.0

