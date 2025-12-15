Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14BCD5B864
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD7C10E4F4;
	Mon, 15 Dec 2025 18:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lzp82kgg";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011029.outbound.protection.outlook.com
 [40.93.194.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9C3010E4DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLin8fZfQ5eI4KuyVQOGvrl0dXUDWYYgNepq5SBAfhfaqaTkEROrPM/uls3lhcsyGv9cChlT7xu2zb4mSUhq8wI8XIaQEe/qnOxcjeu1na3Wu9Jx4DSAJWVsG51fp3zV6AkPgl97wgkNt0opbYucI22PmzW8H816TCZ8e1oT8thXY5DdGbHO+aGlSLRA15f7vIsyPhtxpMeCDNdwQ7gkiYxLMeRIK78ipA8upELWe9vJA+boHuss2tyEcV7AQHb04CFoaJJ9gpgt6CgqfJfK1KC5ggXySVxGMNnKeIer0NQgIElVojYqjB4kgNwoNrdVd50PNbLHWMj9lUw8SioYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjC6GMkWZpgn1vE12DOCQ6mPVdMDgw2OPpx7s/phjxk=;
 b=gLdii+GLrClYh+Pf6nDNKvJBvU+0cmR0spVos0cElmXTZnCYA6ZEmREiVJXKdNO6urPmF/Xkjz6tmRgkiNzT4MHj9VRZYOih/56ypZT6g1RBbMfSafyZG0G5QieQljNv+MmpYtxQomG2LEa/lTleIDPUADttjHKO8Cp4wYJ7ZdoKCn53dGGSZawrXYxny+vdVFJFfquF8sWabItyj//Mvd9+H0mCqIfCYOfYZ6Lo9/CeRe+CDO+hfm8ANz5+JXrSxi5wxuBgwXJ4YE/jPwHW2HKz2lBPw7I3td6EqCeoZDhuQcR4EqIMFPw+7keA44vTo2cCxIAescaMdPtXpiMqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjC6GMkWZpgn1vE12DOCQ6mPVdMDgw2OPpx7s/phjxk=;
 b=lzp82kggKAYsONVBe53aZbbLuHbwyLFEfFv7cjKy/MUJiSPTIsihA1aLPOXz9BCkhkmO9fCfCoGdkhVW80NYD0Sr5SYGSfz6h4TvjxZIXh8wV2dKVaVnzA9jN+w9W2n+6z2/7iuZ6nIxIxwpXFzBpxtaIH8L7uf5M8KwipuovNg=
Received: from BL1PR13CA0234.namprd13.prod.outlook.com (2603:10b6:208:2bf::29)
 by MN0PR12MB6176.namprd12.prod.outlook.com (2603:10b6:208:3c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:32 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::8e) by BL1PR13CA0234.outlook.office365.com
 (2603:10b6:208:2bf::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:31 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:29 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: make normalize reg addr to common func for soc v1
Date: Mon, 15 Dec 2025 13:16:04 -0500
Message-ID: <20251215181607.29132-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|MN0PR12MB6176:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a32313-2400-4284-22a0-08de3c061305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oj9OKoBKPTK7Prgd96g7dIfuamSGFFL1MG5ivNcRasWTwY6DtGJswxrdU8py?=
 =?us-ascii?Q?QMDpFC70IDgucCajEvyMrCcdORaUw/rW5+QOTuMSShS1S6AxvySKQe+yfcDp?=
 =?us-ascii?Q?jvJaIgU3ObrvhC/vsbFToF08b+ZMdiPUPwbVCWMZHY1fUs0fDuiDGpJmJymT?=
 =?us-ascii?Q?2iGQ2B7qpifQwnPHW8gHX0/kCqHvp0pVysQ50eGp7sYhm62IhcfGuzXdpEF4?=
 =?us-ascii?Q?UPB/atqtWGShKczRYhe55CLSnz2m3qd6KppnGkF/k1mMgUtSHptNP9rHUbUt?=
 =?us-ascii?Q?tkPBUH7EuCQihZe9cYAdmnqotH4v+M1/8UwloKNvGWt6jxyrQ0ukRfst+tnL?=
 =?us-ascii?Q?Nv5glLrX7Evd1v2DldGG02/8zLZlSh0vTnEWjpMywS7fEsIyANugtuGVYDGe?=
 =?us-ascii?Q?BUiXqFzf37xQxBoDTU8G0CYSbo78rhPemWDrtnUiZs9bykwtZeer/MwKodgv?=
 =?us-ascii?Q?85D22MQfdx7+vd8pfZEGEtm46UW+pLexgrwvnCajNr5lsQoByY4Kl+CuDJKW?=
 =?us-ascii?Q?Ofcz5oi3P2IPAUlobIRcva5XlgWnZqhM45ryBl216/sHFZbYMLjP/U4cdJug?=
 =?us-ascii?Q?o7oTPS3x8AuK2GPHxqQjXyvYenm5jnwO0lfug47nyX3XZVxmLSFDesRQy7Xg?=
 =?us-ascii?Q?0OE4gJYiQ1dhRJs2kgE4PrZstAvKXFkeyWv6+0NevblixLYiHux1oshzItZx?=
 =?us-ascii?Q?ycibK2cdJZoKS+sPRa36OOgMZGMuIP8LqCPByMMBgioYEn0zvCYhJNqP9P4v?=
 =?us-ascii?Q?muahzdE5+I8WjDEXhMJg7I/Zx6ddV2ZdLNGGfNXAwius4synTzow6LVO+WYA?=
 =?us-ascii?Q?GTibb2JjX2SwwHbpZkajRyYDO5HB/foEiRKXsklu8dToVgc1rgei6jzqR+7u?=
 =?us-ascii?Q?eSDekwEza8yhpT06kvXpLFzIlfocJkyauKqJdSSEak0D2nn/nLu53VZInKt8?=
 =?us-ascii?Q?i04AmT5w4upBe8aUCFBMGXHhD+UafhBmnEQozZSl8vKCitt93WLj30XvKQoM?=
 =?us-ascii?Q?9zTo/teOMSF9kfbA/SSKgYUKT+/jfiOhASXBt/HerT9tVPy+Eyu2nxRAjeG8?=
 =?us-ascii?Q?39RuQ2rscT6l6eMjpO/VtTcezwqDNc+C25SdrsFC51WeF/tCQQb2UGEVQTtZ?=
 =?us-ascii?Q?W3YX6XFdtOV8LfuUg9VrruEOM8tyYQFpAub+eULomb5vUsvuEaIC/f8ap3Us?=
 =?us-ascii?Q?zO81plXkMx/1zpk6BP0nmNBdX6046YMvcTVX8wSj6eOLDtjyrstbtCFwIPbL?=
 =?us-ascii?Q?0zXztDOIyoY1tVIBUjE7F7bbE8aqNybbnPxugHe++0WjDlhtK35pSDfp15lB?=
 =?us-ascii?Q?yggVGCZWPnnPk949gchh5PKjgCKOV3pCpY3zACKPxMd/yK+KWFF4cxwnuUc1?=
 =?us-ascii?Q?FLJDagfRM9ALQBi98OlZEuGK9lBjUcL8I+pgd8OHr7h+mDp5A7xn6ZZdHqXL?=
 =?us-ascii?Q?kxLw2tLjux7QFjbQDjm7VmNfnYZZQSowW9TVzcYGWt3lOKjiC8mBAE3eQ95X?=
 =?us-ascii?Q?CZtcE+tOImd1krEQ/O8g4pDUJm7Ub5m7VEyzIBQw3AM8sinwOxoDxblKb8I3?=
 =?us-ascii?Q?T2ol0vA85EC7vkagHug=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:31.9324 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a32313-2400-4284-22a0-08de3c061305
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6176
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

Normalize registers address to local xcc address for sdma v7_1.
Merge normalize register address function to an common function
for soc v1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 29 ++++----------------------
 drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 22 +++++++------------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c |  5 +++--
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c  | 29 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.h  |  2 ++
 5 files changed, 45 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index c43f9a9fe662a..277db5ef9ca74 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -59,13 +59,6 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc.bin");
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
 	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
-#define XCC_REG_RANGE_0_LOW  0x1260     /* XCC gfxdec0 lower Bound */
-#define XCC_REG_RANGE_0_HIGH 0x3C00     /* XCC gfxdec0 upper Bound */
-#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
-#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
-#define NORMALIZE_XCC_REG_OFFSET(offset) \
-	(offset & 0xFFFF)
-
 static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
@@ -228,28 +221,14 @@ static void gfx_v12_1_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 		adev->gfx.kiq[i].pmf = &gfx_v12_1_kiq_pm4_funcs;
 }
 
-static uint32_t gfx_v12_1_normalize_xcc_reg_offset(uint32_t reg)
-{
-	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
-
-	/* If it is an XCC reg, normalize the reg to keep
-	   lower 16 bits in local xcc */
-
-	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
-		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH)))
-		return normalized_reg;
-	else
-		return reg;
-}
-
 static void gfx_v12_1_wait_reg_mem(struct amdgpu_ring *ring, int eng_sel,
 				   int mem_space, int opt, uint32_t addr0,
 				   uint32_t addr1, uint32_t ref,
 				   uint32_t mask, uint32_t inv)
 {
 	if (mem_space == 0) {
-		addr0 = gfx_v12_1_normalize_xcc_reg_offset(addr0);
-		addr1 = gfx_v12_1_normalize_xcc_reg_offset(addr1);
+		addr0 = soc_v1_0_normalize_xcc_reg_offset(addr0);
+		addr1 = soc_v1_0_normalize_xcc_reg_offset(addr1);
 	}
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
@@ -3426,7 +3405,7 @@ static void gfx_v12_1_ring_emit_rreg(struct amdgpu_ring *ring, uint32_t reg,
 {
 	struct amdgpu_device *adev = ring->adev;
 
-	reg = gfx_v12_1_normalize_xcc_reg_offset(reg);
+	reg = soc_v1_0_normalize_xcc_reg_offset(reg);
 
 	amdgpu_ring_write(ring, PACKET3(PACKET3_COPY_DATA, 4));
 	amdgpu_ring_write(ring, 0 |	/* src: register*/
@@ -3446,7 +3425,7 @@ static void gfx_v12_1_ring_emit_wreg(struct amdgpu_ring *ring,
 {
 	uint32_t cmd = 0;
 
-	reg = gfx_v12_1_normalize_xcc_reg_offset(reg);
+	reg = soc_v1_0_normalize_xcc_reg_offset(reg);
 
 	switch (ring->funcs->type) {
 	case AMDGPU_RING_TYPE_KIQ:
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
index 16e9dd56b0c86..17d7b1731b9ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -45,15 +45,8 @@ static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, uint32_t xcc_id);
 #define MES_EOP_SIZE   2048
 
 #define regCP_HQD_IB_CONTROL_MES_12_1_DEFAULT 0x100000
-#define XCC_REG_RANGE_0_LOW  0x1260     /* XCC gfxdec0 lower Bound */
-#define XCC_REG_RANGE_0_HIGH 0x3C00     /* XCC gfxdec0 upper Bound */
-#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
-#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
 #define XCC_MID_MASK 0x41000000
 
-#define NORMALIZE_XCC_REG_OFFSET(offset) \
-	(offset & 0x3FFFF)
-
 static void mes_v12_1_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -508,10 +501,9 @@ static uint32_t mes_v12_1_get_xcc_from_reg(uint32_t reg_offset)
 static void mes_v12_1_get_rrmt(uint32_t reg, uint32_t xcc_id,
 				 struct RRMT_OPTION *rrmt_opt)
 {
-	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
+	uint32_t normalized_reg = soc_v1_0_normalize_xcc_reg_offset(reg);
 
-	if (((normalized_reg >= XCC_REG_RANGE_0_LOW) && (normalized_reg < XCC_REG_RANGE_0_HIGH)) ||
-		((normalized_reg >= XCC_REG_RANGE_1_LOW) && (normalized_reg < XCC_REG_RANGE_1_HIGH))) {
+	if (soc_v1_0_normalize_xcc_reg_range(normalized_reg)) {
 		rrmt_opt->xcd_die_id = mes_v12_1_get_xcc_from_reg(reg);
 		rrmt_opt->mode = (xcc_id == rrmt_opt->xcd_die_id) ?
 			 MES_RRMT_MODE_LOCAL_XCD : MES_RRMT_MODE_REMOTE_XCD;
@@ -548,7 +540,7 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 				   &misc_pkt.read_reg.rrmt_opt);
 		if (misc_pkt.read_reg.rrmt_opt.mode != MES_RRMT_MODE_REMOTE_MID) {
 			misc_pkt.read_reg.reg_offset =
-				NORMALIZE_XCC_REG_OFFSET(misc_pkt.read_reg.reg_offset);
+				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.read_reg.reg_offset);
 		}
 		break;
 	case MES_MISC_OP_WRITE_REG:
@@ -560,7 +552,7 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 				   &misc_pkt.write_reg.rrmt_opt);
 		if (misc_pkt.write_reg.rrmt_opt.mode != MES_RRMT_MODE_REMOTE_MID) {
 			misc_pkt.write_reg.reg_offset =
-				NORMALIZE_XCC_REG_OFFSET(misc_pkt.write_reg.reg_offset);
+				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.write_reg.reg_offset);
 		}
 		break;
 	case MES_MISC_OP_WRM_REG_WAIT:
@@ -575,7 +567,7 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 				   &misc_pkt.wait_reg_mem.rrmt_opt1);
 		if (misc_pkt.wait_reg_mem.rrmt_opt1.mode != MES_RRMT_MODE_REMOTE_MID) {
 			misc_pkt.wait_reg_mem.reg_offset1 =
-				NORMALIZE_XCC_REG_OFFSET(misc_pkt.wait_reg_mem.reg_offset1);
+				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.wait_reg_mem.reg_offset1);
 		}
 		break;
 	case MES_MISC_OP_WRM_REG_WR_WAIT:
@@ -594,11 +586,11 @@ static int mes_v12_1_misc_op(struct amdgpu_mes *mes,
 
 		if (misc_pkt.wait_reg_mem.rrmt_opt1.mode != MES_RRMT_MODE_REMOTE_MID) {
 			misc_pkt.wait_reg_mem.reg_offset1 =
-				NORMALIZE_XCC_REG_OFFSET(misc_pkt.wait_reg_mem.reg_offset1);
+				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.wait_reg_mem.reg_offset1);
 		}
 		if (misc_pkt.wait_reg_mem.rrmt_opt2.mode != MES_RRMT_MODE_REMOTE_MID) {
 			misc_pkt.wait_reg_mem.reg_offset2 =
-				NORMALIZE_XCC_REG_OFFSET(misc_pkt.wait_reg_mem.reg_offset2);
+				soc_v1_0_normalize_xcc_reg_offset(misc_pkt.wait_reg_mem.reg_offset2);
 		}
 		break;
 	case MES_MISC_OP_SET_SHADER_DEBUGGER:
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 6ffe05cc1d1eb..5bc45c3e00d18 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -42,6 +42,7 @@
 #include "sdma_v7_1.h"
 #include "v12_structs.h"
 #include "mes_userqueue.h"
+#include "soc_v1_0.h"
 
 MODULE_FIRMWARE("amdgpu/sdma_7_1_0.bin");
 
@@ -1220,7 +1221,7 @@ static void sdma_v7_1_ring_emit_wreg(struct amdgpu_ring *ring,
 	 * Use Register WRITE command instead, which OPCODE is same as SRBM WRITE
 	 */
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_SRBM_WRITE));
-	amdgpu_ring_write(ring, reg << 2);
+	amdgpu_ring_write(ring, soc_v1_0_normalize_xcc_reg_offset(reg) << 2);
 	amdgpu_ring_write(ring, val);
 }
 
@@ -1229,7 +1230,7 @@ static void sdma_v7_1_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
 {
 	amdgpu_ring_write(ring, SDMA_PKT_COPY_LINEAR_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* equal */
-	amdgpu_ring_write(ring, reg << 2);
+	amdgpu_ring_write(ring, soc_v1_0_normalize_xcc_reg_offset(reg) << 2);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, val); /* reference */
 	amdgpu_ring_write(ring, mask); /* mask */
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 23544cef4101c..baa353ee7d1c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -34,6 +34,13 @@
 #include "gc/gc_12_1_0_sh_mask.h"
 #include "mp/mp_15_0_8_offset.h"
 
+#define XCC_REG_RANGE_0_LOW  0x1260     /* XCC gfxdec0 lower Bound */
+#define XCC_REG_RANGE_0_HIGH 0x3C00     /* XCC gfxdec0 upper Bound */
+#define XCC_REG_RANGE_1_LOW  0xA000     /* XCC gfxdec1 lower Bound */
+#define XCC_REG_RANGE_1_HIGH 0x10000    /* XCC gfxdec1 upper Bound */
+#define NORMALIZE_XCC_REG_OFFSET(offset) \
+	(offset & 0xFFFF)
+
 /* Initialized doorbells for amdgpu including multimedia
  * KFD can use all the rest in 2M doorbell bar */
 static void soc_v1_0_doorbell_index_init(struct amdgpu_device *adev)
@@ -784,3 +791,25 @@ int soc_v1_0_init_soc_config(struct amdgpu_device *adev)
 
 	return 0;
 }
+
+bool soc_v1_0_normalize_xcc_reg_range(uint32_t reg)
+{
+	if (((reg >= XCC_REG_RANGE_0_LOW) && (reg < XCC_REG_RANGE_0_HIGH)) ||
+	    ((reg >= XCC_REG_RANGE_1_LOW) && (reg < XCC_REG_RANGE_1_HIGH)))
+		return true;
+	else
+		return false;
+}
+
+uint32_t soc_v1_0_normalize_xcc_reg_offset(uint32_t reg)
+{
+	uint32_t normalized_reg = NORMALIZE_XCC_REG_OFFSET(reg);
+
+	/* If it is an XCC reg, normalize the reg to keep
+	 * lower 16 bits in local xcc */
+
+	if (soc_v1_0_normalize_xcc_reg_range(normalized_reg))
+		return normalized_reg;
+	else
+		return reg;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
index 23517c3a3d1bc..296b653db987d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.h
@@ -30,5 +30,7 @@ void soc_v1_0_grbm_select(struct amdgpu_device *adev,
 			  u32 queue, u32 vmid,
 			  int xcc_id);
 int soc_v1_0_init_soc_config(struct amdgpu_device *adev);
+bool soc_v1_0_normalize_xcc_reg_range(uint32_t reg);
+uint32_t soc_v1_0_normalize_xcc_reg_offset(uint32_t reg);
 
 #endif
-- 
2.52.0

