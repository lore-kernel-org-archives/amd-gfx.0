Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A62CC624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA81110EA47;
	Mon, 31 Aug 2026 18:28:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DRG2JiM8";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012012.outbound.protection.outlook.com [52.101.53.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D00710EA47
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQDdtiJwYbF1556tuxwWyuZt5RRB9bjPFZs4iOMg0DaTSVgJDX23MPo8GmbqqEZo44N+v10OhRRK2TqKLlHaeGrT8sTsjmMze2Y4Vr3sKqoyfqEj0fPinGG5yCtm7GgzsqPmqskHlxnb7gw/Gxl2f+HF13rrP+9NRUV7A8PDhqviO1xvoNIObhrBESviPcHbefBuTjqOxdq549ycIuZksXZzqWyd5jZuqLE+UQj3M576mtv/MSHoNzjTEcE6AlFwKwaW5W1uoWUaujRXA0mmBxhBaf0xTxeeFyuyOf02GOL4BQADsaCtqX2uNMGd9/PuSCALycIHruNUuwd81zOL4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdqsO3RwVVqERQoLkK4HMimWKF87hQEEMPj/rr7TbHA=;
 b=RUOLF6PRiAbhUZXrQd5QK/qkOgdGeuvOanOHKtTNm0jZECV9fB1uB4P4G7au1yjhxKksFX5i+S6bhq7iHKJQDEgxXwqKW5fKdqb9VruyeHlnPF8r7ubi8TDTXxZ7mwtX22aY2qGCiSj6f7eXnDAQF83f6uqmYnN43NpWQqo4ep3hfd3V040QDOJwKnNUcFsxBGmjhasaTIWG9heoiOLZUhviacVo6k1OHCwIRVWCHGrRtSuw17ZlV79gue99Ra9Lzcr2eFap7qcTaaFdUl7A7Ej1LSXDZyYEl/aVjWvqtYyXwk0yFV/502DJ7NUP2Mjx3xjHwVhM/x7ZRKdSSb+Flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdqsO3RwVVqERQoLkK4HMimWKF87hQEEMPj/rr7TbHA=;
 b=DRG2JiM8GYN6jo8UEGAHWSWN/pNCCbkU1ONefOHNFcUbBvsfDAtPs7wCPuendUbB11AR4C6Y1tjwmQJRJwe8vOS57mVQEMHf1CUr0Va/wSONASc60OEzAiYJl6TMf23pqabexklVWkSHlwmGpgF7Myu1PITiJ+GRWxMMBLGnf9w=
Received: from BN1PR14CA0017.namprd14.prod.outlook.com (2603:10b6:408:e3::22)
 by DS0PR12MB7536.namprd12.prod.outlook.com (2603:10b6:8:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Mon, 31 Aug
 2026 18:28:33 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:e3:cafe::7b) by BN1PR14CA0017.outlook.office365.com
 (2603:10b6:408:e3::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:33 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gangliang Xie <ganglxie@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 19/95] drm/amdgpu: add handler for nHT error
Date: Mon, 31 Aug 2026 14:26:38 -0400
Message-ID: <20260831182754.1089811-20-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DS0PR12MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: f3956284-05ee-4040-3ba9-08df078daa04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|11063799006|10067099003|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: bccwNGYtYMXUHp0dNCTHX3/kAPY6GuTdvVeqaB41GFlIP9qaoJ9BHPjXF7lYHqOaJ/zwtsUKWQaPtzG2J6gqtKLcitBFPQWFkvaEXQEQ3XRy3MhNe5BYkEBcQGNojDt6Gyo8KDLzNGwkvw87VBjyABfqtpKjvJJv3i4lurKECu4OgruMxqvBV1uZedMD/kQPgLW2KtmbVMMYOGxFx5kprRYKB+TJlzn+U2sj1xs4hPUzFY9BT1fj9xqzhOLWwgoiBZKIgYgPAiD8vHb4aV9LZK7Kzygjg12/aTr4LcEicsYnITHvAfCp+nF805Vp8gAu4IY7RqSO0w0VpvgLB6MNqBsQnEA+cnB9TvUtLsz6zbav5s0SOy2LAB6CQ0ZpPxOoPAfLr86E2/aub8t1ApFpUtfmvzr2Cx9r8FV50e1vGcnDYQC9cUuDhZRT5hWksDMVnEqSvIFf5kPcffCMGqfvJcVe0YBOSqZUPPAFSrnBRMxyugHzVwjuz5td523EqsneDjCiukZGG2cKS+zAHEvWWG4A6z2Q/7u99QsHaTjAE7rijqsUWpX2VCWOtw8nXiAt7CERQNanHvs6Zkks+7yW/bP26YQuQzpSJe1eM+t1Q7BpV/sG7hrbNAxf2E9c6LfwHriN+ofNORlJ9A4GDHuzydTgIDAP2qTDUei0kbdiKoyjTMjvQKzncIhAyG/7MB+uxrLxEoEQtmh8njZHjGnM9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(11063799006)(10067099003)(56012099006)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CXO1cvZ5JdvLmxIbIsQFiR2hMZg9ls98IRkt9B3+asOAh6SEONPoi5MDqXEwICFbssJFDsOV9LAY3ZukoKoxSTW+IU1Tq6Kv8SoD6S35EP9XOOFdu5fXnyqWI8jM95arLBcjjK9qUZ20v3gFE/1wSvY2lkbW94foN7USIccTNMQCOwF4kCs7QFVjkql2R6JHurPqZiryFBkwHPgTJVloCJkSIS/awozWGpqSfo4+VHF8+nykccqrco2ZdgW45VaEBz3VbFIaZLnSul/syd2cZNWHDHpHJQ6g3ocWtu8WHfJggjkvkv2+xz1CwqIWpwFQLZd8l0/44BDodZNVXnng/xgfqm4L9Cdl4zpkkrXBevoNNOLwLCBQouW+mbfcIPJ67zMUYyOhdBsmgivetyOrZCrAvzE5ROX8do6BPstJGWhfQ4NqJuFcKi1fykKpwf8Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:33.3649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3956284-05ee-4040-3ba9-08df078daa04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7536
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

From: Gangliang Xie <ganglxie@amd.com>

add handler for nHT error

v2:
	add EA ill op check

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  | 44 +++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6722213db8f01..f5fb2e585e8ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -478,6 +478,7 @@ struct amdgpu_gfx {
 	struct amdgpu_irq_src		sq_irq;
 	struct amdgpu_irq_src		rlc_gc_fed_irq;
 	struct amdgpu_irq_src		rlc_poison_irq;
+	struct amdgpu_irq_src		pmr_ea_irq;
 	struct sq_work			sq_work;
 
 	/* gfx status */
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 82ac39239d789..0c52eb5e8e288 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1499,6 +1499,13 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	/* pmr ea error */
+	r = amdgpu_irq_add_id(adev, SOC_V1_0_IH_CLIENTID_GFX,
+				GFX_12_1_0__SRCID__PMR_EA_ERROR_INTERRUPT,
+				&adev->gfx.pmr_ea_irq);
+	if (r)
+		return r;
+
 	adev->gfx.gfx_current_status = AMDGPU_GFX_NORMAL_MODE;
 
 	r = gfx_v12_1_rlc_init(adev);
@@ -4062,6 +4069,36 @@ static int gfx_v12_1_rlc_poison_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int gfx_v12_1_pmr_ea_irq(struct amdgpu_device *adev,
+				  struct amdgpu_irq_src *source,
+				  struct amdgpu_iv_entry *entry)
+{
+	uint32_t ras_blk = RAS_BLOCK_ID__GFX;
+	struct ras_ih_info ih_info = {0};
+	uint32_t ctx_id = entry->src_data[0];
+	int i, num_xcc;
+
+	if (ctx_id & 0x1) {
+		/* request RLC MCA logging here
+		 * nHT CTO status clearing is handled by RLC firmware
+		 */
+
+		ih_info.block = ras_blk;
+		ih_info.reset = AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+		amdgpu_ras_mgr_dispatch_interrupt(adev, &ih_info);
+	}
+
+	if (ctx_id & 0x2) {
+		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+		/* ea_ill_op_status will be cleared in a future update */
+		for (i = 0; i < num_xcc; i++)
+			dev_warn(adev->dev,
+				"an EA illegal-op is detected and need to clear ea_ill_op_status\n");
+	}
+
+	return 0;
+}
+
 static void gfx_v12_1_emit_mem_sync(struct amdgpu_ring *ring)
 {
 	const unsigned int gcr_cntl =
@@ -4190,6 +4227,10 @@ static const struct amdgpu_irq_src_funcs gfx_v12_1_rlc_poison_irq_funcs = {
 	.process = gfx_v12_1_rlc_poison_irq,
 };
 
+static const struct amdgpu_irq_src_funcs gfx_v12_1_pmr_ea_irq_funcs = {
+	.process = gfx_v12_1_pmr_ea_irq,
+};
+
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->gfx.eop_irq.num_types = AMDGPU_CP_IRQ_LAST;
@@ -4203,6 +4244,9 @@ static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev)
 
 	adev->gfx.rlc_poison_irq.num_types = 1;
 	adev->gfx.rlc_poison_irq.funcs = &gfx_v12_1_rlc_poison_irq_funcs;
+
+	adev->gfx.pmr_ea_irq.num_types = 1;
+	adev->gfx.pmr_ea_irq.funcs = &gfx_v12_1_pmr_ea_irq_funcs;
 }
 
 static void gfx_v12_1_set_imu_funcs(struct amdgpu_device *adev)
-- 
2.55.0

