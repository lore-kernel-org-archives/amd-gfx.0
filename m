Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E84C27C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 06:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 484B710E2A1;
	Wed, 26 Jun 2024 06:02:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ofyOX9SW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89CAA10E2A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 06:02:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCsdEeDjCL6bW4G+uTKlpMGqML44pNN6Kjl2gZKcX2gNN9cw/2FhmxMz7D98S1hhAnuS0dcV9KUwf/ihI/aDWOzA7yjhxhRQFXv1Wqdn7NacyMDWvDAMEBz/tGXMkKPALNqpIEBsxS1jTcPOnl2tJuY4U5wCVHwKXsE13X0v74ypAcJb5NL7bn5yarfekfdVBxu+ItWZV9xvFMGrjNTNRdh05Fdra6Ymh+SJU+bbOT6i6r1gTgEKFEpH6/hNfGk9C+fFP0IjihosQJWO7C5Z0khIwDWFW7mKeyZ/sgE8P8kmGzKxqMPyyifh8StunSsGZ/w5XzgYYJfoLFglesX0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68Zr0gISw58aro7WeEI6pZJkA8qRpRGu3StXLmZCT0Q=;
 b=WiZlFLaAE+Vev9jO5L0CsWDn9UkA+9lWLiZVtV8JGpa4n1nlw1eQWzLf75cSXnKd0j9gVHsaZ4KhLguiAYQta8RKnQo7/MI9QA/5jaycURItTSot7rah9/Tr+HyQAW9OnreCOB6w1TGAt+sCmoyL/NMamJat8wIzeURgtC9G0Pzzezg8i8d1RKxxjR4QFQBWzU2Y2ONdBCykBJzIhRcubCz0+rVSoDtlzyn1aSKrWyGyfpgCLQnQcAu4jqc35S987SIu2Cy0rtM3Ej9RrxzuqJ6xYe3Ir8EMza0mM9a36x2qungDcvBz3oDQSNjJhFt2N0Zm8nLes5ekGy5Le0Eetg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68Zr0gISw58aro7WeEI6pZJkA8qRpRGu3StXLmZCT0Q=;
 b=ofyOX9SWCOY2FK5yJlMn2AP7yptEwDjmMWcwC5WszLdOrjnPVQcMqtvtJI/b88kj/AMCJzAEEqtr1DHX7p3FpwFaO1RGmCpFudNL39LBavynGtKE5IxAyai2r8NvQZghtuA3hRNf6YW5nP6Hs3qMMdIMhwhNsElwu06gW7N1wQA=
Received: from CY5PR15CA0249.namprd15.prod.outlook.com (2603:10b6:930:66::16)
 by MN6PR12MB8565.namprd12.prod.outlook.com (2603:10b6:208:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 06:01:58 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::58) by CY5PR15CA0249.outlook.office365.com
 (2603:10b6:930:66::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.23 via Frontend
 Transport; Wed, 26 Jun 2024 06:01:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 06:01:55 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 01:01:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 01:01:54 -0500
Received: from jane-sm-stand.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Jun 2024 01:01:52 -0500
From: Jane Jian <Jane.Jian@amd.com>
To: <Lijo.Lazar@amd.com>, <christian.koenig@amd.com>, <Haijun.Chang@amd.com>, 
 <Victor.Zhao@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Jane Jian <Jane.Jian@amd.com>
Subject: [PATCH] drm/amdgpu: normalize registers as local xcc to read/write in
 gfx_v9_4_3
Date: Wed, 26 Jun 2024 14:01:51 +0800
Message-ID: <20240626060151.2554500-1-Jane.Jian@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|MN6PR12MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: fd921ba6-b82a-4e89-f474-08dc95a57bc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|1800799022|82310400024|36860700011|376012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UMg8QAC5ApCIN8LImFOdXthUDqADYcpovByBqvvtaBW2gns6jNZAH0KJuQYZ?=
 =?us-ascii?Q?UNd+ohywtJjUuG00Mefqoe+lSoHIyuB+YnwI3+mZEqetiDwaWTOI3WTp+UOM?=
 =?us-ascii?Q?Vcob0Z3nUtuulbr0N71qwAXDKY0SKbiYs4LPdF0rHsd+Pv7vuLs3m5hiJ1Lu?=
 =?us-ascii?Q?1/oJhj8aMBDVdsuNkldXEJu7yFweBTwE8f5gumlvbgh6qhyb4c43P4otvZFa?=
 =?us-ascii?Q?lGCt/rcc1z831LTd3v69aHn7RJH5Xuq0XkLdTDogZdihGjt+TgH7ZB44KCdG?=
 =?us-ascii?Q?LjCCGvDskx40zFskRXKZBU9pt9d/738ZLBo0ndDhu3uNLpPSoegUm2DYgnQz?=
 =?us-ascii?Q?WOYZC5LSa0Hqkpv7NWQk/OEeAyfEcXHQy+jLQbQIRwzPb0c7tZ/rqRwWjuQK?=
 =?us-ascii?Q?i19TvmKHENrgbB58edU1QBjaIxy2rJ0e9s6IBqtikSO5oO2yNvWW++UcWGjR?=
 =?us-ascii?Q?sFXEo7zvpGa1Z/ooBaPAV81WbXlZ1/+i/EF4WfjF4xOj/8jSyzslP0E1xdQP?=
 =?us-ascii?Q?iYVA5J6dIX9pVkGRVItN0nBKpqX3ah1+UmXXR0g/FfcZK6O/mAmTtEYkTW3m?=
 =?us-ascii?Q?F7Bt6d3q2noGKGE4EOTBk+vPxTAasYViXfX+Fcu+aT0cO0AN8oPn/Ajp3S/T?=
 =?us-ascii?Q?4659QgiffZ8VH/oRfZ+sz+qlehRsBU+Xk3HNpMF34y41ZroUT8V56vtrWC6J?=
 =?us-ascii?Q?BXzRWsHeKu0mZ3HaawHKFgDTG9OOBqvrlQCYQfRvf2LcvQGmuk1YfzelljV6?=
 =?us-ascii?Q?PVEZiAjb6FJJ2U/ir7onDLxLgVJRo/dmfSV0KznrRjggEJtNT8ok4Lpek05a?=
 =?us-ascii?Q?fJ9ursRMQV7orOwU1bXq3gM6OaTFnW+t1v25rULO31DrWhndzjuPaVEGwazs?=
 =?us-ascii?Q?XG6lEghnN67M65qhIHJBwI6H0BsBR08px/8a8o8g8UNxLRrQLERQFDp9x5fD?=
 =?us-ascii?Q?zTD/KdkVcay0crIB15BmjaRIxESlijEBMfmYQGReJJppwMPJ9j0ZzZxVv+se?=
 =?us-ascii?Q?VzRRcRgWIX/EVLUiDCXad2mSwbh73DGLwHVEV4Z1437L+XpHRay6DP8lAVXI?=
 =?us-ascii?Q?lkNRIE+YEj8HrUCigvwVSnD2RYtrbYtrkp8evDfk6h+DYGoo2JjPDKAoCV5C?=
 =?us-ascii?Q?iyichCNKPsUWeR0L05vWQ+dnMfuI7PZ/Y8S3vEKVFdj6auAxuX61o70dB7zq?=
 =?us-ascii?Q?GtsoJ0BG0tONX0624yO7QyOxY7zS+m5QnzKcxoh1yjPWChjE0/ATDtHudzxn?=
 =?us-ascii?Q?BpXDxl/mxd8ciSapYAerqIiz+LqalKVfOIPrK2iA9EFIuv4Si0dvJrSosFAC?=
 =?us-ascii?Q?I5qKKEDCFpml2fnwD6CB04Lzy1tpQer/5dvX4IbvFzlJnu3cjDIsgOe1tUyO?=
 =?us-ascii?Q?eS9YOpSOirK2C79lmwbiwQCccGyT00N3KBAnq72xGFVBfHDerERXQYqQ2dhY?=
 =?us-ascii?Q?c3h499FpcXc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 06:01:55.7231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd921ba6-b82a-4e89-f474-08dc95a57bc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8565
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

[WHY]
sriov has the higher bit violation when flushing tlb

[HOW]
normalize the registers to keep lower 16-bit(dword aligned) to aviod higher bit violation
RLCG will mask xcd out and always assume it's accessing its own xcd

v2
add check in wait mem that only do the normalization on regspace

Signed-off-by: Jane Jian <Jane.Jian@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 33 +++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8d8763ebe027..1149595a02d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -55,6 +55,14 @@ MODULE_FIRMWARE("amdgpu/gc_9_4_4_rlc.bin");
 #define mmSMNAID_XCD1_MCA_SMU 0x38430400	/* SMN AID XCD1 */
 #define mmSMNXCD_XCD0_MCA_SMU 0x40430400	/* SMN XCD XCD0 */
 
+#define XCC_REG_RANGE_0_LOW  0x2000     /* XCC gfxdec0 lower Bound */
+#define XCC_REG_RANGE_0_HIGH 0x3400     /* XCC gfxdec0 upper Bound */
+#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
+#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
+
+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+	(offset & 0xFFFF)
+
 struct amdgpu_gfx_ras gfx_v9_4_3_ras;
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev);
@@ -217,9 +225,24 @@ static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 	}
 }
 
+static uint32_t gfx_v9_4_3_normalize_xcc_reg_offset(uint32_t reg)
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
 static void gfx_v9_4_3_write_data_to_reg(struct amdgpu_ring *ring, int eng_sel,
 				       bool wc, uint32_t reg, uint32_t val)
 {
+	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, WRITE_DATA_ENGINE_SEL(eng_sel) |
 				WRITE_DATA_DST_SEL(0) |
@@ -234,6 +257,12 @@ static void gfx_v9_4_3_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				  uint32_t addr1, uint32_t ref, uint32_t mask,
 				  uint32_t inv)
 {
+	/* Only do the normalization on regspace */
+	if (mem_space == 0) {
+		addr0 = gfx_v9_4_3_normalize_xcc_reg_offset(addr0);
+		addr1 = gfx_v9_4_3_normalize_xcc_reg_offset(addr1);
+	}
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
 	amdgpu_ring_write(ring,
 				 /* memory (1) or register (0) */
@@ -2725,6 +2754,8 @@ static void gfx_v9_4_3_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 {
 	struct amdgpu_device *adev = ring->adev;
 
+	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
+
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
 				(5 << 8) |	/* dst: memory */
@@ -2742,6 +2773,8 @@ static void gfx_v9_4_3_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
 {
 	uint32_t cmd = 0;
 
+	reg = gfx_v9_4_3_normalize_xcc_reg_offset(reg);
+
 	switch (ring->funcs->type) {
 	case AMDGPU_RING_TYPE_GFX:
 		cmd = WRITE_DATA_ENGINE_SEL(1) | WR_CONFIRM;
-- 
2.34.1

