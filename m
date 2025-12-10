Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD20CD3B9A9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 07:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CA8910E687;
	Wed, 10 Dec 2025 07:14:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V/7Rf60E";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8035410E689
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 07:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJiFvMl94Z4YtfXGmyZcTZf63lGFkZbiu10Jb7vIoWE3393YrteKa+FLsk83XvEcB/11wWYL4kcg8XpdVvAs+OojgauZ5dzCbqi3DJ4SYVCTr+pWNdYldLvgei/6SVo3emfTfR8J8pbQJK6TJaWFWmvmCSYD6CTgetibzEniJ2qf8fwG1NPOg67AmxZO9W9Qe3lCLwpZdVlN/59gtXaRBvq11BWbXWUWERtLToRr9e6k7JHXPyXPCTK3hX+xMMT2pH1Xt5IR+88BVayvSyFG46XaNDIVOd7BeuHL6RvrmIMX4I+dE6tre0sY3sk+PwZBVZzZtK66BDUFGraoDdfM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKg7vmSNmQzWs/hlekBYLh/cq6tonL0/THooLg3QvVo=;
 b=J/EHFSYfgR+7jfFInC+rxcFMsDW+NrdbYSGrGjjbwd+bTC4coyDLYEb+oCmC8U8jVI9xDEIxDyDkBwfB15hqFm1HJDNvWIdGCjWyyJ78PhvHU8nJ0WAXYUqc3GqCfUUdSyHc42R3DLc9LRThGxIquWROj1QFPQ952y0sU79CGKfDbHNI4NQ82gpGFqq9460+baeX0nJK5c8DBpj0TeoRp4v2hNG+0wYoC7ZIum2j/95mbsidW3rgWVR176eUPMYABzD8WGJyWixjAmR/M3+rRJEGwHJS93icsRnkAxWbNk1YX7Ot/fW+RW9zvE/cwXEhnIVg4nx5NKkjdQBmsUd5FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKg7vmSNmQzWs/hlekBYLh/cq6tonL0/THooLg3QvVo=;
 b=V/7Rf60EN8N+L1s+kBd8rCQmWsx5tUMREHJAIOnDR3rGD51M+u9hBDxo/yd01kreKzMWqeQc98hqdQl23Bv8I8RRqvwXNrb7Q6TJqNe0AhaLao6p6mnyH3XeSztG3pqpwG3okPSHoShlu101wucKTIx2DhVoTiwFSLA2sjfL498=
Received: from SA9PR13CA0035.namprd13.prod.outlook.com (2603:10b6:806:22::10)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Wed, 10 Dec
 2025 07:14:39 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::78) by SA9PR13CA0035.outlook.office365.com
 (2603:10b6:806:22::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.4 via Frontend Transport; Wed,
 10 Dec 2025 07:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:14:39 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 01:14:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: normalize reg addr as local xcc for gfx v12_1
Date: Wed, 10 Dec 2025 02:14:09 -0500
Message-ID: <20251210071415.19983-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210071415.19983-1-alexander.deucher@amd.com>
References: <20251210071415.19983-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: 712a29cd-55c2-4517-ae66-08de37bbc83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?z4dTl5j60sKXwGQZJxq0Bw1JqQ7SGBvmrOq6VYc1tV3Er3nkLXFUMzWz+7fu?=
 =?us-ascii?Q?Ydule8MQhNhXzaKGbKOAqxhKCbuU4OZOyH0khyFECPUlzeiFs8UfZg3h00et?=
 =?us-ascii?Q?PNtXfwUdmcQqa6B9B8abdYuldVkKf7UXj5RYMZbvOPT+qZOIZhhemyCzMYcQ?=
 =?us-ascii?Q?QgXxHdcLWYmGXfQHbe6lj+KDJoWcKuQpcDiidAJVe9h+CPtNo7Sw055TK8XK?=
 =?us-ascii?Q?Sq59bdXjvgAxrTXosy1O4E0nWQ3wbT+bhBWYH86AjBdWAQScCjFUHMzgMnx2?=
 =?us-ascii?Q?K06l2paH9kLRN1E/NmR3skqah1fM+8xWptIQYDvOS956TPZcIp3TegR2d22Z?=
 =?us-ascii?Q?9DidXFaV1X8+T3ACwkSDz8RYDBo0Hh2btNbmCMG2egw13Cov5NGZGYo+w2J0?=
 =?us-ascii?Q?pgI9EV+xqzNcKcJHX3VIxAWcc4rluUQj44MZM+0eOUl1l+itzsiVH8QQh0S5?=
 =?us-ascii?Q?fU+Sk5OU/WoqbBbEFVosjjaSGHiAt2e4cwyTW0vYPKrrMc5gs/8RdbvmHlPu?=
 =?us-ascii?Q?bnafuBO+/TJHJfB7tNUqyQnl5aNHRD35nBgD9PGb2a5VG87uzoUNNPJXYWZx?=
 =?us-ascii?Q?uO6PsN0w3inxwSjPITAeG/w9vyw4GcZdfGQmTwSg+vyqvcEDTJYcIEAkqNth?=
 =?us-ascii?Q?DHheyoz4yLKfWc2OkPuPTpuxSA1q88oXHjmn3x2bCxiel7wcRM0frStdMizP?=
 =?us-ascii?Q?e4Q2ULLwg8UA4WQJY2IltaDF+XaYDC3w6sQTsiHXIaRxp7mnvrrejolm+LQS?=
 =?us-ascii?Q?0Bg9b7Rr12O2igvpRAljl1hZEfjemu2fbV9sTaw7UyesCa4yb2bh7gu7FOeb?=
 =?us-ascii?Q?s1hssFtKdmBS0PbkupjuTkiF/EgDDh12Wfd+/F6wtYQIEbgnvlZfrdZSLqZN?=
 =?us-ascii?Q?vIMbX9GDDoW+77JiCVweOgiK7Y32x94/TknUjExVjLWAjM5YNW+KBdwfnLYS?=
 =?us-ascii?Q?t4wU2BLI3qgNnfjhNZWXy12RdFtNfuV9lEdmdEk3MfWpQYl0qMh3tii1L0RG?=
 =?us-ascii?Q?4luc3R4FF1UMXwjEWI1mlD8M7J+yUdxQybNzXr95NrfR3Aj4g3kqn5+teras?=
 =?us-ascii?Q?pTFyQpctM4uegBWlxisXWsM16oHLgOXhnG2H3ms3Sth87GjERhDveXfYGHTp?=
 =?us-ascii?Q?pd6wsfuyxnvDD7MvbEVrGZUSkUT4M2D/UFzihb7yjhEV5yU2lM8nrmAsOUvQ?=
 =?us-ascii?Q?mU6oxJtG2wG6go40hscCbCg7DppBRefnrbeTt2zarCFsKGAw09hPdDE11O1l?=
 =?us-ascii?Q?eg+mFtCCBFAP4ovbFjLsl+ij90RujWxHZl5ePQf7qul/U4tB5dH9OUyyCNxz?=
 =?us-ascii?Q?900EgPgj9ITYymZEvY3nlRguq1c700RkY27LfFNegWpkflOaYcjfB3RyUjSH?=
 =?us-ascii?Q?BCRsKG5mGTgq9Eti3rtstV1quvb8k6IVEjabHAWwzK1ZUVIcmD7OVirXapiV?=
 =?us-ascii?Q?7HPV0cNoeyh0kvEivNHVy3ccJ8NWWlqFkOReKpKzXUVgKF220ZeDFXdlsyHm?=
 =?us-ascii?Q?TBGo3yFKQKY3DVT2WjR/z84L4fBk9R2O4ZsXVjvooaeev6/ObJJ+5D7x2GD0?=
 =?us-ascii?Q?AilzRUugZD0scYuIyOM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:14:39.0363 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 712a29cd-55c2-4517-ae66-08de37bbc83c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
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

From: Likun Gao <Likun.Gao@amd.com>

Normalize registers address to local xcc address for gfx v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 26f8394bdce4b..f4b31752c6530 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -59,6 +59,13 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc.bin");
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
+#define XCC_REG_RANGE_0_LOW  0x1260     /* XCC gfxdec0 lower Bound */
+#define XCC_REG_RANGE_0_HIGH 0x3C00     /* XCC gfxdec0 upper Bound */
+#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
+#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+	(offset & 0xFFFF)
+
 static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
@@ -220,11 +227,30 @@ static void gfx_v12_1_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 		adev->gfx.kiq[i].pmf = &gfx_v12_1_kiq_pm4_funcs;
 }
 
+static uint32_t gfx_v12_1_normalize_xcc_reg_offset(uint32_t reg)
+{
+	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
+
+	/* If it is an XCC reg, normalize the reg to keep
+	   lower 16 bits in local xcc */
+
+	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
+		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH)))
+		return normalized_reg;
+	else
+		return reg;
+}
+
 static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				   int mem_space, int opt, uint32_t addr0,
 				   uint32_t addr1, uint32_t ref,
 				   uint32_t mask, uint32_t inv)
 {
+	if (mem_space == 0) {
+		addr0 = gfx_v12_1_normalize_xcc_reg_offset(addr0);
+		addr1 = gfx_v12_1_normalize_xcc_reg_offset(addr1);
+	}
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring,
 			  /* memory (1) or register (0) */
@@ -3338,6 +3364,8 @@ static void gfx_v12_1_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 {
 	struct amdgpu_device *adev = ring->adev;
 
+	reg = gfx_v12_1_normalize_xcc_reg_offset(reg);
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
@@ -3356,6 +3384,8 @@ static void gfx_v12_1_ring_emit_wreg(struct amdgpu_ring *ring,
 {
 	uint32_t cmd = 0;
 
+	reg = gfx_v12_1_normalize_xcc_reg_offset(reg);
+
 	switch (ring->funcs->type) {
 	case AMDGPU_RING_TYPE_KIQ:
 		cmd = (1 << 16); /* no inc addr */
-- 
2.52.0

