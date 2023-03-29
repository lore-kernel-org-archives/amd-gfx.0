Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FC7C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3879D10EC40;
	Wed, 29 Mar 2023 20:14:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7819510EC39
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:14:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDgkCAXmwiB49devyu1IPVVQlXh+b98uDIfNXDArsvnzH0VplQwvrcoxP4rtVeFG2DpU+MhsXCQNi/POGiJmUuWf1nGDAbCXHzqU5qb7uxDj5Py4GQS0jplVbOG8nyXV123WZRpxj8n1T3k6deDjrfyj1qigjzqFJDLSh81x0rNjiFJ7m97cXu/lgbHnhDzm8zsxH3UeOCmDYT5qdVPCXq/QaqIWvu3ArlWh4gM07YoI5U/dzeB913NUiX7AJ6fBqtepEuqsGMTGfOl08mkD8BAOnk8mY5t89yk4hpJogere0qqLoJrPqWOBcQFRXZhttMWCwzsSZWLBdfE1R5PWaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntzQSS+bdaxsVWvrWzUfzXvJw+uYWscZp13dnTZroYU=;
 b=PN/acCUIlvz7kTm8dfKlqHLhDp3WYljGH4TpH2I+4TN8eXz/MugcxTCRzj8sruigalBlmpZCajXMklnuGQrPH6sPXqyze3QZyf3SPoo4HF52WRfMC0adyAL43dkW4efnWdyL/YbGMNZIw2tLPreSharh/ZLb2OROA7A9d+VYbHMprMloILXNnpjop4ewVVjZcysV2to+J51Eqy1nATv2MDtKWM6O3KTVRh+b+oYqcBvZpQLR0VcLz2gW79f/Pg9KGwq1G5Rcn5vhwjB+Z6nnwL1aMcFGi9XRyspobGDpwcDU6Y1GdXz5/GUeHGKxTNx39D7pg23DiwgOTbHJsoPzHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntzQSS+bdaxsVWvrWzUfzXvJw+uYWscZp13dnTZroYU=;
 b=5VHHwkHCLHFfkMR7COzW4PXLR+xYr1AacW1vNKUlrPWtHrKSpt4bZWd+XAdl40T1ay53y96gOPw9Vkx3wiGBTmEu3PO3uyD4bnGcxX8Cfqj0VCnK2OQCQlbL2SbbTPmd7sZ5G3PBAlWcp8/SEAOAK6kK2dfAcJMtP4cXjz5GW7E=
Received: from MW2PR2101CA0025.namprd21.prod.outlook.com (2603:10b6:302:1::38)
 by CH0PR12MB5236.namprd12.prod.outlook.com (2603:10b6:610:d3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 20:14:49 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::e4) by MW2PR2101CA0025.outlook.office365.com
 (2603:10b6:302:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Wed, 29 Mar 2023 20:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6254.20 via Frontend Transport; Wed, 29 Mar 2023 20:14:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:14:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amdgpu: drop redundant csb init for gfx943
Date: Wed, 29 Mar 2023 16:14:20 -0400
Message-ID: <20230329201426.1982669-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329201426.1982669-1-alexander.deucher@amd.com>
References: <20230329201426.1982669-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT050:EE_|CH0PR12MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4b98c6-cfb7-4f12-bba2-08db30923f80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 22INSmrx69PN0eZM4RFQOI3NIFgBhrLOBHH70bbkAeOmLFAc6F44GkbtWehG6XHhJ+IL6qLVruk+7jIY0qWq1Vag5dkL2yUX3br88+s0BHh0gd2rIxpWDXTQtWfRzszJTERuIbvsyDobabwLzDAZl2K16LEJoHN0C75z3teUtuoiAypJQMC7FuVAWV7Y5hCFcYmTWN6pnIH0/UiAUX+FWmTEPZOYAfAlG2WcEc2d7RZqsssV+dfBlT5fTG+fPaapOxypdAFgJQyczZHiXnbM18iU//HFZw38YPAGAiWyUwmLtw57+yluI6yWcR7uCgz8xWfCfWbxQEgvbZQHkDnHR7cJM9pAdPhRTxXFZOm5xbVZHvO/pKTXn29mYDxFQKOegKGNtmMV1MCPDa2O13au0QrSzLBv40cL5y0cNHU9IYta06gZpIUMkMl3Csjbx0TLyQOh1q/7Tw4U5aBKtUdCcK3J2p70F7QjUkngb8L4q05gYo9UbCBs0ihQ2H7xZg3+ALja/4fK6o2yEEkLoh/cqTuet8LznMEVqjq5kUToU0ndm7Tx/Z2M8G1xdx1SdN2+y10JcXMmElZqVqz0sfjWiTxrcyDAF4Klvc5NYULFiGpzwVVU/J9X4b5i+JkPbbXxsi3z6n5pi547G6f8GCKF9mwPecgnZ8UzukRB6mGdz4kzWzVkQ5s4H2po2OYosc56K4wOdUCeL/KteWKloWac/LyBHa4QKPI4/TmtDTqV1hU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(451199021)(40470700004)(46966006)(36840700001)(6666004)(7696005)(26005)(1076003)(478600001)(6916009)(316002)(54906003)(47076005)(16526019)(36860700001)(186003)(426003)(70206006)(70586007)(336012)(8676002)(83380400001)(2616005)(4326008)(41300700001)(356005)(5660300002)(2906002)(82740400003)(40460700003)(81166007)(8936002)(40480700001)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:14:49.0254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4b98c6-cfb7-4f12-bba2-08db30923f80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5236
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Le Ma <le.ma@amd.com>

It's not required for compute pipeline and will cause soft lockup on emulation
due to long-time writing.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 99 -------------------------
 1 file changed, 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 2766e6ab5b1b..a2534ffc677e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -434,75 +434,6 @@ static int gfx_v9_4_3_init_microcode(struct amdgpu_device *adev)
 	return r;
 }
 
-static u32 gfx_v9_4_3_get_csb_size(struct amdgpu_device *adev)
-{
-	u32 count = 0;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-
-	/* begin clear state */
-	count += 2;
-	/* context control state */
-	count += 3;
-
-	for (sect = gfx9_cs_data; sect->section != NULL; ++sect) {
-		for (ext = sect->section; ext->extent != NULL; ++ext) {
-			if (sect->id == SECT_CONTEXT)
-				count += 2 + ext->reg_count;
-			else
-				return 0;
-		}
-	}
-
-	/* end clear state */
-	count += 2;
-	/* clear state */
-	count += 2;
-
-	return count;
-}
-
-static void gfx_v9_4_3_get_csb_buffer(struct amdgpu_device *adev,
-				    volatile u32 *buffer)
-{
-	u32 count = 0, i;
-	const struct cs_section_def *sect = NULL;
-	const struct cs_extent_def *ext = NULL;
-
-	if (adev->gfx.rlc.cs_data == NULL)
-		return;
-	if (buffer == NULL)
-		return;
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_BEGIN_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CONTEXT_CONTROL, 1));
-	buffer[count++] = cpu_to_le32(0x80000000);
-	buffer[count++] = cpu_to_le32(0x80000000);
-
-	for (sect = adev->gfx.rlc.cs_data; sect->section != NULL; ++sect) {
-		for (ext = sect->section; ext->extent != NULL; ++ext) {
-			if (sect->id == SECT_CONTEXT) {
-				buffer[count++] =
-					cpu_to_le32(PACKET3(PACKET3_SET_CONTEXT_REG, ext->reg_count));
-				buffer[count++] = cpu_to_le32(ext->reg_index -
-						PACKET3_SET_CONTEXT_REG_START);
-				for (i = 0; i < ext->reg_count; i++)
-					buffer[count++] = cpu_to_le32(ext->extent[i]);
-			} else {
-				return;
-			}
-		}
-	}
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_PREAMBLE_CNTL, 0));
-	buffer[count++] = cpu_to_le32(PACKET3_PREAMBLE_END_CLEAR_STATE);
-
-	buffer[count++] = cpu_to_le32(PACKET3(PACKET3_CLEAR_STATE, 0));
-	buffer[count++] = cpu_to_le32(0);
-}
-
 static void gfx_v9_4_3_mec_fini(struct amdgpu_device *adev)
 {
 	amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NULL);
@@ -1117,22 +1048,8 @@ static void gfx_v9_4_3_enable_save_restore_machine(struct amdgpu_device *adev,
 	WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id), RLC_SRM_CNTL, SRM_ENABLE, 1);
 }
 
-static void gfx_v9_4_3_init_csb(struct amdgpu_device *adev, int xcc_id)
-{
-	adev->gfx.rlc.funcs->get_csb_buffer(adev, adev->gfx.rlc.cs_ptr);
-	/* csib */
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_CSIB_ADDR_HI),
-			adev->gfx.rlc.clear_state_gpu_addr >> 32);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_CSIB_ADDR_LO),
-			adev->gfx.rlc.clear_state_gpu_addr & 0xfffffffc);
-	WREG32_RLC(SOC15_REG_OFFSET(GC, GET_INST(GC, xcc_id), regRLC_CSIB_LENGTH),
-			adev->gfx.rlc.clear_state_size);
-}
-
 static void gfx_v9_4_3_init_pg(struct amdgpu_device *adev, int xcc_id)
 {
-	gfx_v9_4_3_init_csb(adev, xcc_id);
-
 	/*
 	 * Rlc save restore list is workable since v2_1.
 	 * And it's needed by gfxoff feature.
@@ -1224,20 +1141,6 @@ static void gfx_v9_4_3_unset_safe_mode(struct amdgpu_device *adev, int xcc_id)
 
 static int gfx_v9_4_3_rlc_init(struct amdgpu_device *adev)
 {
-	const struct cs_section_def *cs_data;
-	int r;
-
-	adev->gfx.rlc.cs_data = gfx9_cs_data;
-
-	cs_data = adev->gfx.rlc.cs_data;
-
-	if (cs_data) {
-		/* init clear state block */
-		r = amdgpu_gfx_rlc_init_csb(adev);
-		if (r)
-			return r;
-	}
-
 	/* init spm vmid with 0xf */
 	if (adev->gfx.rlc.funcs->update_spm_vmid)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, 0xf);
@@ -2412,8 +2315,6 @@ static const struct amdgpu_rlc_funcs gfx_v9_4_3_rlc_funcs = {
 	.set_safe_mode = gfx_v9_4_3_set_safe_mode,
 	.unset_safe_mode = gfx_v9_4_3_unset_safe_mode,
 	.init = gfx_v9_4_3_rlc_init,
-	.get_csb_size = gfx_v9_4_3_get_csb_size,
-	.get_csb_buffer = gfx_v9_4_3_get_csb_buffer,
 	.resume = gfx_v9_4_3_rlc_resume,
 	.stop = gfx_v9_4_3_rlc_stop,
 	.reset = gfx_v9_4_3_rlc_reset,
-- 
2.39.2

