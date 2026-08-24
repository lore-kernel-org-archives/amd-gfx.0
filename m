Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD2EC61CE2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AE1F10E862;
	Mon, 24 Aug 2026 22:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fYv+ztTa";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC8310E5B0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLYjSSxHONG7LEDGOoN6WcEhWAE34JhFclMp1s6oFEgU7RBj2iYTq/d1KTOGL5a9JDpESuayn1besZ2UrB2LoeF2LBEEtW1lRFDO6dVgrSIkylhWFb9dZS/PgtRa9pY4tYjNoISlwj6yCr3h9TJn9tvikU5yWZaf9zqxmMJqWyqE0g2CBBqNWM3bK2IKFc8XOH8oQJOevc6b1OaJJaLH/kvjfRcTrm+7PUQRnU2FeHMcRWVWjAtVaFt21Av6wMOn2pUulxMgg3pesex1AmXQMIame9TTANdYLhI++ivnbFVWegr+HtV3cWZ+KxmjEs/r6vFk1KhtxRHZYbeyc6YAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV0KLw0vfkpOEQL7WBme9t6DHPQRcQAYJ/200bop1WI=;
 b=T8oQh0Xt4WWp5ss+wvhDdAc6DReGGkm6amhhNZpzARhDoAf5kCng5tH6bRf9zaqhRWurvbWiLrO1lrsvrybY2pKoKYi/riALwLun6m7XY4Xl0ov1Q0hAj1GV3WrCzuNQy8HuFZ02sTzfwr3S0sxvibrIOJJiHXqiHtDCnm9rsrld3w5DRmVJMcs5n55HeLAdwwD6ZxkCDRDnbsnnGW8zCewVsu5D/kxjFF9r57txZCUo0ZjEyWZsQXyTVGKtEWx1FuTCKbE+fL2GN5u+tGUn85csLUkKjGtppd9sEcsMk73yHRjQTizHwCWKxxlwhEE17ewwdMadyHkTU3Xe1RdWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV0KLw0vfkpOEQL7WBme9t6DHPQRcQAYJ/200bop1WI=;
 b=fYv+ztTaG4Skb2qivrw1hyVTLYIOs1OoEZbA1cGZWSRtOgMa5714GKGNavpllK2CfMeyOqqutzGRmxHNRaHf9OUzJFhyXIEEL0i0dd7fbJ1HNkb4Rj6dzyO/lbJY4KXRC3HQde81UOG/Dkopl2TqGH7yBKZlLAJj2yo7WkuewiI=
Received: from DS1PR03CA0026.namprd03.prod.outlook.com (2603:10b6:8:233::13)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:12 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:233:cafe::53) by DS1PR03CA0026.outlook.office365.com
 (2603:10b6:8:233::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 12/30] drm/amdgpu/sdma5.2: add tlb invalidation buffer func
 callback
Date: Mon, 24 Aug 2026 18:13:34 -0400
Message-ID: <20260824221352.1793542-13-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3e58a6-bdd4-4f33-d4b1-08df022d06ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: SbSFCreVw0VHlATxnvRcwYzwAD5rA75lottWVUeVuHefofo74YaTW1WzV6zYV7C7vL16lGg8oA8AyuUBibZj2C8ZHVhGFQ7faYboAn5cC673fZxO8oFtC2VXc3jm9DPeyEYaU4FXpLJ8b6UehAXls7iCcnJgWlXfhhkCZQftRjw8oTxHhWn96Qb4w2AAALpF59x5SPltJ7UZx3N+SuGoscuxtnXc4FskjK3zyWmGPNa3XSyCPf2FiBuVg7dPZGvocQabmX16tsyxEIeew6sWerBK3ANlE3DbdtSucrTt2Rp9O+7ZIHbZ98PATPh/UvmGgMqo3/0UPkWlXPd3c2mXG/osFBkxPWvGNCcdy5HYGq53y79a0UuVYjg3E/cHMBVGcQSIFhJwkz3eiN1D0gZIbpf2XSvs2dsn4+N7yr39OoGCljZ8N5rIHL5Lz4rQK+o3lMsFjNE+TrE2dC3qj+L86l2pXFI/8UNQfPmYFdB7M5liHMMGXH4H6w6nUxcJzKog5wCNWZ+lLA/UD0GGcExw8FWhxORai/3Ehh6AuVNgyYBxE1hQ06CmNbDEjNJzrNgGbwzdo5HxOqoXa/zCTg+5yP1czzBVy7bUurAspitpF95adn9b/7/cQ8kGWFyzp+bZzHIaRF91bO1n/3OgDlD1+DblWSpcaxWzJ7wr5qQh+pT4swdO2zStX5OEbqeqtAbE4YePIjajkldMQbsB3T1NlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LH8IhiEAA4o61J39PPabzq7Q1xR1w0aylftyH+I5+DG2SO+XdT7+wiPcIGBZ7hzKyKcOQkc7+2HRJbJ5YAWY9OhZe1uIl53ro7zFORpEbIVE9cdpYJ2sdNB30qFluiaEi9Vpf7jLdkwuODmNBfj2gmyUn+szs6tecuIpGrQNOZZQpmhMRfQ3chabCbVTMM4cRwJxF9SDsnA1y9nSkCrDq/9qlr1PV8Fhv1xM80/jN2PuhHV2ptq7mAbIolXnGx91tGda4WY3Bdb3IGx775872UTY2y8CgVVMNCd9CUeK6lQZSobMgAw7z59hkGMPydY52aRQqWBRT/piy5twDKXIid8dDL+Q+96s9Rkd7TlGTjQh0H2c6MOBFpCRNOOATT/pRZaPxxrg1oy4rEwhmUzqg+BHTzl1eydmcDTVzwHZMr7wGUonMfYfz9stmhe/jqKq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:12.2230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3e58a6-bdd4-4f33-d4b1-08df022d06ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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
index 35cdf6c149f86..a10086de35957 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -2038,6 +2038,52 @@ static void sdma_v5_2_emit_fill_buffer(struct amdgpu_ib *ib,
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
@@ -2046,6 +2092,9 @@ static const struct amdgpu_buffer_funcs sdma_v5_2_buffer_funcs = {
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

