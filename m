Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4282C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 16:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B00214AF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 16:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gZT0mLJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B00214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13CF26EA55;
	Wed, 15 Jan 2020 16:52:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80FF6EA4E
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 16:52:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNtoLz+u60rIf3twfiohF2RFNfHOUVNgzdAxuw7Ny7m62DrYvNbV/tQXqsfxhlfPMe6n1q/DHvVi/NlCfO8TIZZZ9BuC3vDiGFvOHsSsoS14fgJZXX1eSHcDfN16+xZd6BzUH7Leh2VxL9R/0ILLd482JHAlunCQkf+PA6yHa0noNkSkNjhOyJ8Dc/tJHT2B67EHp+uTZWUkiTNmjWw8D7JfEWYRK7nBF1MY9OC08fWR/7RSfO/IRzXIv51UVwL1/7xlFiuyrS5dG58M9rzE8i6odaeu7qYGz6GErz33o1LqLc9mwWKI7qYqQOmqhM5DVd6LZr2yWoUEXUv7sghvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMvsLGPzZy3u8NEZrrmKsh5dNO5Ou5L8a0c1+Yu5Zbg=;
 b=JdVYWnY/OuEWgSqJj89cIaAeXRIjhhiiFqkxx/h2wR/vsVqF6uf5HuNSqywA9ifMjCIfVuFrVTkKY2h/bd8+CYCEolzwpO1MIJK3ymKAulhYQhoWYvgAoYd7HsYH+goiDAxFJsiqmXn4UeZJcDDFAvBQuVjCYz03yFfnGrTlbdEUX9kKLjeH5fcjAmNXWLwTYihf5HUfb7tfNxVbnfEiL6NqXJEdkyLmT43/xujBkHQwBVkDtGD8C+XfSJfdM3ocUCbafsy38T28wo98p2X84sqm89NaQJTVqWxx49+0CEqWEp5vn7GkmvDYNz57ulP2v/SXaVqDzJhnyIk/YJNUgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMvsLGPzZy3u8NEZrrmKsh5dNO5Ou5L8a0c1+Yu5Zbg=;
 b=gZT0mLJ5ZZy5YE2vmkPXhXi1JaquKMP8Y0PnThhC69c2Et4fynatOdFgfQy5jhpywNDs2ylkcZizr28XBur74Ih2nSGioWDvRhprTEK5c3elTK0/M8QkbOH5tX8o4kY4aNaLYD/nRgUjkMuMyoGdo2cTr2M10hh7FoHVMdifveU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3430.namprd12.prod.outlook.com (20.178.196.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Wed, 15 Jan 2020 16:52:09 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 16:52:09 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 2/6] drm/amdgpu/vcn: support multiple instance direct SRAM
 read and write
Date: Wed, 15 Jan 2020 11:51:55 -0500
Message-Id: <1579107115-2377-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579040596-12728-3-git-send-email-James.Zhu@amd.com>
References: <1579040596-12728-3-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::26) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0049.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.18 via Frontend
 Transport; Wed, 15 Jan 2020 16:52:08 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b773c3f-f638-4608-2391-08d799db42be
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:|BYAPR12MB3430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3430F720D35EAEC93FB51BD5E4370@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(199004)(189003)(8676002)(956004)(2616005)(6666004)(5660300002)(66476007)(66946007)(6486002)(81166006)(66556008)(26005)(8936002)(4326008)(186003)(36756003)(30864003)(16526019)(2906002)(316002)(52116002)(478600001)(86362001)(7696005)(81156014)(6916009);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3430;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNgi67AI5lJVcWWwmiO/ckbO0y6aWPz/Uy4IE6zc6igerCQ8e9gjhAUazMnyHd1PFVvS3I2SbVSYEjBVy245VHMjNy0HO3P0dQzrLIQKnBx0vpmA2TFenXkchN1qUmWShhWkO5tEy2FUncI7r2U5DNZTHoEIWsTEiltHRvAEsH31x1HfVah9ftwfRUqvqG7Ja/EpQDrNvJMtGh8/AJWvg0EhA259gZZy53zGxzh+/yM0dizCQMK8dpl4P6nXU00boD9GG9Ar5o5EqbiDCTFPzOf8u+pV/dg+nm2LlhEOYOrHSmWmJQvibwIZAhN8z87RM617EBIHl7lKBxnHFV0vqvX0lyxVI9SqSKXEMRp87fQ5fZnGFLa1i+ejjDFtHvDFV9h/Zi169XyOuPq02SuHPEOqeKr3XZYtfNd0uQboGFnATvojKhNypMG7RO/hUeAt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b773c3f-f638-4608-2391-08d799db42be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 16:52:09.5867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fg7VBu+6Eugv+JEg8cOLE+3ZAei6Q0Ef/cd88pA5CHjyRgM7ydoPcPP3PFmRRs3B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3430
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add multiple instance direct SRAM read and write support for vcn2.5

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 27 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 46 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 94 ++++++++++++++++-----------------
 3 files changed, 83 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 99df693..ca62d99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -165,15 +165,15 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 			dev_err(adev->dev, "(%d) failed to allocate vcn bo\n", r);
 			return r;
 		}
-	}
 
-	if (adev->vcn.indirect_sram) {
-		r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
-			    AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.dpg_sram_bo,
-			    &adev->vcn.dpg_sram_gpu_addr, &adev->vcn.dpg_sram_cpu_addr);
-		if (r) {
-			dev_err(adev->dev, "(%d) failed to allocate DPG bo\n", r);
-			return r;
+		if (adev->vcn.indirect_sram) {
+			r = amdgpu_bo_create_kernel(adev, 64 * 2 * 4, PAGE_SIZE,
+					AMDGPU_GEM_DOMAIN_VRAM, &adev->vcn.inst[i].dpg_sram_bo,
+					&adev->vcn.inst[i].dpg_sram_gpu_addr, &adev->vcn.inst[i].dpg_sram_cpu_addr);
+			if (r) {
+				dev_err(adev->dev, "VCN %d (%d) failed to allocate DPG bo\n", i, r);
+				return r;
+			}
 		}
 	}
 
@@ -186,15 +186,14 @@ int amdgpu_vcn_sw_fini(struct amdgpu_device *adev)
 
 	cancel_delayed_work_sync(&adev->vcn.idle_work);
 
-	if (adev->vcn.indirect_sram) {
-		amdgpu_bo_free_kernel(&adev->vcn.dpg_sram_bo,
-				      &adev->vcn.dpg_sram_gpu_addr,
-				      (void **)&adev->vcn.dpg_sram_cpu_addr);
-	}
-
 	for (j = 0; j < adev->vcn.num_vcn_inst; ++j) {
 		if (adev->vcn.harvest_config & (1 << j))
 			continue;
+		if (adev->vcn.indirect_sram) {
+			amdgpu_bo_free_kernel(&adev->vcn.inst[i].dpg_sram_bo,
+						  &adev->vcn.inst[i].dpg_sram_gpu_addr,
+						  (void **)&adev->vcn.inst[i].dpg_sram_cpu_addr);
+		}
 		kvfree(adev->vcn.inst[j].saved_bo);
 
 		amdgpu_bo_free_kernel(&adev->vcn.inst[j].vcpu_bo,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 26c6623..5ce13c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -104,27 +104,27 @@
 		internal_reg_offset >>= 2;							\
 	})
 
-#define RREG32_SOC15_DPG_MODE_2_0(offset, mask_en) 						\
-	({ 											\
-		WREG32_SOC15(VCN, 0, mmUVD_DPG_LMA_CTL, 					\
-			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT | 				\
-			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT | 				\
-			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT)); 			\
-		RREG32_SOC15(VCN, 0, mmUVD_DPG_LMA_DATA); 					\
+#define RREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, mask_en) 					\
+	({											\
+		WREG32_SOC15(VCN, inst, mmUVD_DPG_LMA_CTL, 					\
+			(0x0 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |				\
+			mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |				\
+			offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));			\
+		RREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA);				\
 	})
 
-#define WREG32_SOC15_DPG_MODE_2_0(offset, value, mask_en, indirect)				\
-	do { 											\
-		if (!indirect) { 								\
-			WREG32_SOC15(VCN, 0, mmUVD_DPG_LMA_DATA, value); 			\
-			WREG32_SOC15(VCN, 0, mmUVD_DPG_LMA_CTL, 				\
-				(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT | 			\
-				 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT | 			\
-				 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT)); 		\
-		} else { 									\
-			*adev->vcn.dpg_sram_curr_addr++ = offset; 				\
-			*adev->vcn.dpg_sram_curr_addr++ = value; 				\
-		} 										\
+#define WREG32_SOC15_DPG_MODE_2_0(inst_idx, offset, value, mask_en, indirect)			\
+	do {											\
+		if (!indirect) {								\
+			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA, value);			\
+			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 				\
+				(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |			\
+				 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |			\
+				 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));		\
+		} else {									\
+			*adev->vcn.inst[inst_idx].dpg_sram_curr_addr++ = offset;		\
+			*adev->vcn.inst[inst_idx].dpg_sram_curr_addr++ = value;			\
+		}										\
 	} while (0)
 
 enum engine_status_constants {
@@ -173,6 +173,10 @@ struct amdgpu_vcn_inst {
 	struct amdgpu_ring	ring_enc[AMDGPU_VCN_MAX_ENC_RINGS];
 	struct amdgpu_irq_src	irq;
 	struct amdgpu_vcn_reg	external;
+	struct amdgpu_bo	*dpg_sram_bo;
+	void			*dpg_sram_cpu_addr;
+	uint64_t		dpg_sram_gpu_addr;
+	uint32_t		*dpg_sram_curr_addr;
 };
 
 struct amdgpu_vcn {
@@ -184,10 +188,6 @@ struct amdgpu_vcn {
 	struct dpg_pause_state pause_state;
 
 	bool			indirect_sram;
-	struct amdgpu_bo	*dpg_sram_bo;
-	void			*dpg_sram_cpu_addr;
-	uint64_t		dpg_sram_gpu_addr;
-	uint32_t		*dpg_sram_curr_addr;
 
 	uint8_t	num_vcn_inst;
 	struct amdgpu_vcn_inst	 inst[AMDGPU_MAX_VCN_INSTANCES];
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index dcdc7ad..9ff59ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -356,88 +356,88 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		if (!indirect) {
-			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo), 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi), 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		} else {
-			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
-			WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		}
 		offset = 0;
 	} else {
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
 		offset = size;
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
 	if (!indirect)
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
 	else
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
 	if (!indirect) {
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	} else {
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	}
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
 	/* cache window 2: context */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
 
 	/* non-cache window */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
 
 	/* VCN global tiling registers */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
@@ -583,19 +583,19 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		 UVD_CGC_CTRL__WCB_MODE_MASK |
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__SCPU_MODE_MASK);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
 
 	/* turn off clock gating */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
 
 	/* turn on SUVD clock gating */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
 }
 
@@ -759,7 +759,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	WREG32_SOC15(UVD, 0, mmUVD_POWER_STATUS, tmp);
 
 	if (indirect)
-		adev->vcn.dpg_sram_curr_addr = (uint32_t*)adev->vcn.dpg_sram_cpu_addr;
+		adev->vcn.inst->dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst->dpg_sram_cpu_addr;
 
 	/* enable clock gating */
 	vcn_v2_0_clock_gating_dpg_mode(adev, 0, indirect);
@@ -768,11 +768,11 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__MIF_WR_LOW_THRESHOLD_BP_MASK;
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* disable master interupt */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
 
 	/* setup mmUVD_LMI_CTRL */
@@ -784,28 +784,28 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		0x00100000L);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_MPC_CNTL),
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_MPC_SET_MUXA0),
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_MPC_SET_MUXB0),
 		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_MPC_SET_MUX),
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
@@ -813,29 +813,29 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 
 	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
 
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
 
 	/* release VCPU reset to boot */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_SOFT_RESET), 0, 0, indirect);
 
 	/* enable LMI MC and UMC channels */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_LMI_CTRL2),
 		0x1F << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT, 0, indirect);
 
 	/* enable master interrupt */
-	WREG32_SOC15_DPG_MODE_2_0(SOC15_DPG_MODE_OFFSET_2_0(
+	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-		psp_update_vcn_sram(adev, 0, adev->vcn.dpg_sram_gpu_addr,
-				    (uint32_t)((uintptr_t)adev->vcn.dpg_sram_curr_addr -
-					       (uintptr_t)adev->vcn.dpg_sram_cpu_addr));
+		psp_update_vcn_sram(adev, 0, adev->vcn.inst->dpg_sram_gpu_addr,
+				    (uint32_t)((uintptr_t)adev->vcn.inst->dpg_sram_curr_addr -
+					       (uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
 
 	/* force RBC into idle state */
 	rb_bufsz = order_base_2(ring->ring_size);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
