Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44E6C5DF81
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6B410E5A0;
	Mon, 24 Aug 2026 22:14:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZX/YKkwt";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011035.outbound.protection.outlook.com
 [40.93.194.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C5810E5A0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fr3y3RI1iyB5AmldFIQS+8Pa5tad+4+jAjFR0T5cNeEEQUViFRp/M2dZpeZ/QDBimzoxnxJ2AFqSrwDk0ciS7Jt7PCzIQGv8v0sVcTe3cAhpon3DApsp+753wzm1V8NHTtKpa5N3crMlUoHopvyujS1kPCzVRp+HDPf0JT1RGJOrD/aHrdFX6jtqJ8iK6cTRJ+3BjFDKehJj4Ck7GCeFCo0wt11hwlXcFJw4I5tqYyW8bSxyPx0Y9aPuhXBnffgKiJzlIre/GhgwWgZU+6vLimIX2aCJX6kpT/jObtdnb5CEa25pObZdm69gTUcNZir0oOGOV16l4YfVTIiwozKXyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsL0bcAlSiDYwRmrQlvSc4TfY0pkE9q9fQ5iF+OVt3E=;
 b=K2K7vrpbZhnIHdMS2w/1o1A5KWkcf9R56J2pOF6p65WW5LVkugOGZcIK4U7AfP363XtlbVq6KrwtahMLhoW/RvZexD+m056FjOd76H5l1zbKskgay27emDsBk2/nXvxCy1eBhjg5E2HaT5YvidMxQtl6hXafUIu3SoCukcTV9+F2a9U63RHNge5U3vlC3/z/9k46aQZb789yBSbeorVNk6nzrcraT9JLBBcdqonmFO1jo4l/Kh31UMbrfyLOzjPQ8hLOKGUiY1W6SvnLZTgPjjJy7v40CVaUMufciLSXtSJKiiYSFgiTa6ouLFRGUfujJwl8qpLOuXzP7n1FMQStHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsL0bcAlSiDYwRmrQlvSc4TfY0pkE9q9fQ5iF+OVt3E=;
 b=ZX/YKkwtb4gMJXK+S+uixy8YcLwD9agQSy89vRH0YoHKRr0i8S1GP6MmtWniZygSD6hiQI5GHbhFav8GyF5Fc0WDYtzccEoyYAzMwukyknKMuD2FoO8SXA0OHy7AQE0FdB+z51Eo76xjD7Ldt8CYX2EReiwdai+0ijnttlk97Nc=
Received: from BN9PR03CA0524.namprd03.prod.outlook.com (2603:10b6:408:131::19)
 by SJ0PR12MB8616.namprd12.prod.outlook.com (2603:10b6:a03:485::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Mon, 24 Aug
 2026 22:14:13 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::b) by BN9PR03CA0524.outlook.office365.com
 (2603:10b6:408:131::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:12 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:11 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:11 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/30] drm/amdgpu/sdma6: add tlb invalidation buffer func
 callback
Date: Mon, 24 Aug 2026 18:13:35 -0400
Message-ID: <20260824221352.1793542-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SJ0PR12MB8616:EE_
X-MS-Office365-Filtering-Correlation-Id: cf965d0a-1003-4cde-4773-08df022d06dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: /ih+f0xI5IktAjyhGmDGTH6FDLbnZOzKjoUtr7hsuor/O0eSA5UgLyV75kVfAdAU5IHtFks5zTAqW4H97WaFUifthyiqW7Kf44YjwXB1zqD/3Rh8GjPsM9HOjEkgnXYi+OzkMS8IDsy8X8Pb8XVWsufsY9iuf91l5IYsXWD7TXU54shYkYm7apUApjOceD14ZuTspGCE9Zlwc3O8PgNRoFFZ79RSIBBNlevndE7pKkwPDtAdLjeaNIRTaSNm97PVIV97dtytqCho2ixUkWVDIp+NW1mvgcVci1tQuHJQHwCxvs6mQ9V+q8jg9TvaLuHdsz+mXonHijOw3JN3Gu0U6IDRbau7k4Hg4uh1DIqvRPrkHVDVSm+vfjn175bRp6KuILdo4IjrWWGMGjrXA/+luhUQm7JXyqDHCK5MW0iA+VloJ8i02cNdhRDz3IOOtBL0Xe3voB01ct3UHtobcs7U0iCONl0qux88Q/RygYircyMxcAqZrvKph1xH8ZJi5mO9Y6poo5jKUC/GoMmGqyc2dX/vaX91nFHLNNHNA8IgMKNaczuGAgcOyXhbN+PE0H4oQQUlYUgS31G3onr1PeQO2NSMi3n+G4jHp/fvUvJKV3IS7p4Zm0IWvGXp0/dwtjRg6Mk0RE4tjeQQcwKSccf1CKAfjmtImcXv3RYSaGnbftd8fpCbMEviJo9wf9gLdNvtnce+lwBzmlQmhj0HJqsgvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 67sc4ev4CeAfoYSbI0VzmAHhrGiSTyG9PK/0QMKNeoKd8NuFndIJ7ikVopy0iGf8h5vFPvXKyfyuee/4tPYgAaa7HQQs1FjftYWpF6ignCuOf2U0QbLfUf+imy23lxO5eqMyD1RiyRcHxTy8A/GyNhGky0+OCTQm7IdcEKH4xdTmt5OHlOEaV1wWWs8YNGtb67JRH5aXK67h4hvD1yR6XbaWkbYyKUDDNvl+LW3YKXDUMdKTdLqUDdqpLl94270I4afOcLX1XXupmjHeDDeBD0/7LIkygf1+n5upa+8l41IuAsv86b5e9JKkHjnDY5U2kpXb0qtVNlyF9uMe42OdqZYvQ9vEYfSq9lX1YPGrKcej9+wa+CMneu8x5eqD5kueVjb/uqID12XtTB/sTSf4AlNbTfx2Xq6KPy1+oZGNBR3ouTxtfevm00kxETVWc27F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:12.1430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf965d0a-1003-4cde-4773-08df022d06dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8616
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 303fd7d1b7c88..7b84c996e2359 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1846,6 +1846,52 @@ static void sdma_v6_0_emit_fill_buffer(struct amdgpu_ib *ib,
 	ib->ptr[ib->length_dw++] = byte_count - 1;
 }
 
+/**
+ * sdma_v6_0_emit_tlb_inv - Invalidate TLB using the sDMA engine
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
+static void sdma_v6_0_emit_tlb_inv(struct amdgpu_device *adev,
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
 static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
 	.copy_max_bytes = 1 << 30,
 	.copy_num_dw = 7,
@@ -1854,6 +1900,9 @@ static const struct amdgpu_buffer_funcs sdma_v6_0_buffer_funcs = {
 	.fill_max_bytes = 1 << 30,
 	.fill_num_dw = 5,
 	.emit_fill_buffer = sdma_v6_0_emit_fill_buffer,
+
+	.tlb_inv_num_dw = 4,
+	.emit_tlb_inv = sdma_v6_0_emit_tlb_inv,
 };
 
 static void sdma_v6_0_set_buffer_funcs(struct amdgpu_device *adev)
-- 
2.55.0

