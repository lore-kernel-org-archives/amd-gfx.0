Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2DAC32771
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 16:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9BD7214AF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TKBrpD2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9BD7214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84EB06EA50;
	Wed, 15 Jan 2020 16:53:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C3B6EA4F
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 16:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOWgG0z3UXV5Myj1BUu7GlK8coakvI4jvhgrA4nbfCZD3V2e8MyIlmzFRrcLXwbLCwTJkB4HwVKaWQoV/xqMTAU7xhAl/mWhEiU9iiNR1RxYCHTgjEKzTMaUaG2LZg/V6K+ti0lPZIYTi9F7yJq3RM8QW5sSWuwds+MfYSLjTBtUVHbQ2w0r5oEO+kExlJKuBcZg9me9LDAhp+mo2BBqgcXj9oNEDd6jZH3NnL0cffbEV4kuEaVD5m2eq50U9VI/+TZARCgo32ULT/OG2Gw9WjaMtU0Svy0lERZ9QAeiJ0J3S+S0OoDAjFNqrrlW2Jw9fsny9kiEHuzCNVWcWqBCVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3W7WYhkJNx3GE45sVZrTyfM5WZGqUQYPi+Pw/ZoSwM=;
 b=kyNkpAZmLyaxnApqazmoyQQjMXsMbC7g6aiwhiXYST2TU2A6VIFT+xA3KzPde+ift/9wlwqhwrBkDe4SBjCGFKjnGlzGjS38YOMyurT+FlDV/EUvu9+EeIi5n36uVXJ45lwIykA/K39IPOYSlqIGaiQ1/SBp+jb3MUW+G+evau8dIpuS4x5R45GNxzNmu77RMnJiwaVUcBfeSM8dmve07EjibE4L135B7gHqeTFFYSPmYZFoze4C9MWmDoyoo0X07vmBdn8KUdYqoWYnCaPeKKijR5ZxGLHbDfjtwOmwhcWytLtJ1qpQ8MWnks8S45unaauKeIlfgStTThrcfpi3Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3W7WYhkJNx3GE45sVZrTyfM5WZGqUQYPi+Pw/ZoSwM=;
 b=TKBrpD2wjvBGVcSCYkhPzZxZLxZVF+zv5doLL0+d3C3KExk4uwaFHNaiVno7iyKdIzPaiaa/BensHEOKOgT9//iAhmhp/qTjiUFPlOYpszV9vNQgYQbAIddEIh6E0jHogREXrCiTY6w1wEOuSmoE3Xxk2brQtzzNn9qS50LsSxI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3430.namprd12.prod.outlook.com (20.178.196.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Wed, 15 Jan 2020 16:53:53 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 16:53:53 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 4/6] drm/amdgpu/vcn2.5: add DPG mode start and stop
Date: Wed, 15 Jan 2020 11:53:44 -0500
Message-Id: <1579107224-2471-2-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579107224-2471-1-git-send-email-James.Zhu@amd.com>
References: <1579040596-12728-4-git-send-email-James.Zhu@amd.com>
 <1579107224-2471-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::19) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0042.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.20 via Frontend
 Transport; Wed, 15 Jan 2020 16:53:52 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 48e82c81-e574-4cf5-1eb6-08d799db807f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3430:|BYAPR12MB3430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3430877CEBF373F84D62EEE6E4370@BYAPR12MB3430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
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
X-Microsoft-Antispam-Message-Info: U8/87yxSlI7ySuKJwFGUhesLTtZ4EOjvBXsh6PrsEnX12EpEYlZ93Pk9xFAYUAgQ3UQkvPZtunLP5y2SzvbYo04n/klwF3bapY3GLIo8FlxaoEEau1L+y019TJR8GV8EjvkJeAi9t3hgVpso+CuiXco0ehTEVOcwE+iXgGA2aBP7kvHe4NgrseTdHhH7rGnS6sC17w5zep7h7tIFGKjxTMhnRqg7XJBGh0KfpqnNZFsD7sKIWpfQXhUfkrGffJtSBech/aZ6LTFspA0Ucll1E3w85/kCRjcGvL7NFg2hO7jhw4ox4DcUzHPx/CwllZT7F7cOr92kQ8BWBc+IE0rOmiCd5cQzeQZqwH/b60jXJuETss2HYYC/Rsz8wYPurgALB9nRyzWt5E34K2MFZnGNi55utbeXn0zOeYMeSruXqOynjN8F6ZWcQvv31kWlp3Bp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e82c81-e574-4cf5-1eb6-08d799db807f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 16:53:53.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STut3N7BsJ/JuItwCdwKOXC1/Ws9DhEVTpnYt80mTELVj5ueyDbaxfFdvOB79ZNZ
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

Add DPG mode start and stop functions for vcn2.5

v2: Correct firmware ucode index in vcn_v2_5_mc_resume_dpg_mode

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 290 +++++++++++++++++++++++++++++++++-
 1 file changed, 288 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index fa90249..c3ff336 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -286,7 +286,8 @@ static int vcn_v2_5_hw_init(void *handle)
 
 done:
 	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully.\n");
+		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
+			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
 	return r;
 }
@@ -309,7 +310,9 @@ static int vcn_v2_5_hw_fini(void *handle)
 			continue;
 		ring = &adev->vcn.inst[i].ring_dec;
 
-		if (RREG32_SOC15(VCN, i, mmUVD_STATUS))
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+	        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+	         RREG32_SOC15(VCN, i, mmUVD_STATUS)))
 			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
 		ring->sched.ready = false;
@@ -418,6 +421,78 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 	}
 }
 
+static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+{
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t offset;
+
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		offset = 0;
+	} else {
+		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		offset = size;
+		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0),
+			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
+	}
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+
+	/* cache window 1: stack */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+
+	/* cache window 2: context */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+
+	/* non-cache window */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+}
+
 /**
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
@@ -536,6 +611,54 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
 	}
 }
 
+static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
+		uint8_t sram_sel, int inst_idx, uint8_t indirect)
+{
+	uint32_t reg_data = 0;
+
+	/* enable sw clock gating control */
+	if (adev->cg_flags & AMD_CG_SUPPORT_VCN_MGCG)
+		reg_data = 1 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	else
+		reg_data = 0 << UVD_CGC_CTRL__DYN_CLOCK_MODE__SHIFT;
+	reg_data |= 1 << UVD_CGC_CTRL__CLK_GATE_DLY_TIMER__SHIFT;
+	reg_data |= 4 << UVD_CGC_CTRL__CLK_OFF_DELAY__SHIFT;
+	reg_data &= ~(UVD_CGC_CTRL__UDEC_RE_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_CM_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_IT_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_DB_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_MP_MODE_MASK |
+		 UVD_CGC_CTRL__SYS_MODE_MASK |
+		 UVD_CGC_CTRL__UDEC_MODE_MASK |
+		 UVD_CGC_CTRL__MPEG2_MODE_MASK |
+		 UVD_CGC_CTRL__REGS_MODE_MASK |
+		 UVD_CGC_CTRL__RBC_MODE_MASK |
+		 UVD_CGC_CTRL__LMI_MC_MODE_MASK |
+		 UVD_CGC_CTRL__LMI_UMC_MODE_MASK |
+		 UVD_CGC_CTRL__IDCT_MODE_MASK |
+		 UVD_CGC_CTRL__MPRD_MODE_MASK |
+		 UVD_CGC_CTRL__MPC_MODE_MASK |
+		 UVD_CGC_CTRL__LBSI_MODE_MASK |
+		 UVD_CGC_CTRL__LRBBM_MODE_MASK |
+		 UVD_CGC_CTRL__WCB_MODE_MASK |
+		 UVD_CGC_CTRL__VCPU_MODE_MASK |
+		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
+
+	/* turn off clock gating */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_CGC_GATE), 0, sram_sel, indirect);
+
+	/* turn on SUVD clock gating */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
+
+	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
+}
+
 /**
  * vcn_v2_5_enable_clock_gating - enable VCN clock gating
  *
@@ -598,6 +721,130 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
 	}
 }
 
+static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+{
+	struct amdgpu_ring *ring;
+	uint32_t rb_bufsz, tmp;
+
+	/* disable register anti-hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS), 1,
+		~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
+	/* enable dynamic power gating mode */
+	tmp = RREG32_SOC15(UVD, inst_idx, mmUVD_POWER_STATUS);
+	tmp |= UVD_POWER_STATUS__UVD_PG_MODE_MASK;
+	tmp |= UVD_POWER_STATUS__UVD_PG_EN_MASK;
+	WREG32_SOC15(UVD, inst_idx, mmUVD_POWER_STATUS, tmp);
+
+	/* enable clock gating */
+	vcn_v2_5_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
+
+	/* enable VCPU clock */
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
+	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* disable master interupt */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MASTINT_EN), 0, 0, indirect);
+
+	/* setup mmUVD_LMI_CTRL */
+	tmp = (0x8 | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
+		UVD_LMI_CTRL__REQ_MODE_MASK |
+		UVD_LMI_CTRL__CRC_RESET_MASK |
+		UVD_LMI_CTRL__MASK_MC_URGENT_MASK |
+		UVD_LMI_CTRL__DATA_COHERENCY_EN_MASK |
+		UVD_LMI_CTRL__VCPU_DATA_COHERENCY_EN_MASK |
+		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
+		0x00100000L);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_CTRL), tmp, 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MPC_CNTL),
+		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MPC_SET_MUXA0),
+		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MPC_SET_MUXB0),
+		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MPC_SET_MUX),
+		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
+
+	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_CTRL2), 0, 0, indirect);
+
+	/* unblock VCPU register access */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
+
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* enable master interrupt */
+	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MASTINT_EN),
+		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
+
+	ring = &adev->vcn.inst[inst_idx].ring_dec;
+	/* force RBC into idle state */
+	rb_bufsz = order_base_2(ring->ring_size);
+	tmp = REG_SET_FIELD(0, UVD_RBC_RB_CNTL, RB_BUFSZ, rb_bufsz);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_BLKSZ, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_FETCH, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_NO_UPDATE, 1);
+	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
+	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_CNTL, tmp);
+
+	/* set the write pointer delay */
+	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR_CNTL, 0);
+
+	/* set the wb address */
+	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_RPTR_ADDR,
+		(upper_32_bits(ring->gpu_addr) >> 2));
+
+	/* programm the RB_BASE for ring buffer */
+	WREG32_SOC15(UVD, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(UVD, inst_idx, mmUVD_LMI_RBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_RPTR, 0);
+
+	WREG32_SOC15(UVD, inst_idx, mmUVD_SCRATCH2, 0);
+
+	ring->wptr = RREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_RPTR);
+	WREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR,
+		lower_32_bits(ring->wptr));
+
+	return 0;
+}
+
 static int vcn_v2_5_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
@@ -610,6 +857,9 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+			return vcn_v2_5_start_dpg_mode(adev, i, 0);
+
 		/* disable register anti-hang mechanism */
 		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -973,6 +1223,35 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
 	return vcn_v2_5_mmsch_start(adev, &adev->virt.mm_table);
 }
 
+static int vcn_v2_5_stop_dpg_mode(struct amdgpu_device *adev, int inst_idx)
+{
+	int ret_code = 0;
+	uint32_t tmp;
+
+	/* Wait for power status to be 1 */
+	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 1,
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+
+	/* wait for read ptr to be equal to write ptr */
+	tmp = RREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR);
+	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+
+	tmp = RREG32_SOC15(UVD, inst_idx, mmUVD_RB_WPTR2);
+	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_RB_RPTR2, tmp, 0xFFFFFFFF, ret_code);
+
+	tmp = RREG32_SOC15(UVD, inst_idx, mmUVD_RBC_RB_WPTR) & 0x7FFFFFFF;
+	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_RBC_RB_RPTR, tmp, 0xFFFFFFFF, ret_code);
+
+	SOC15_WAIT_ON_RREG(UVD, inst_idx, mmUVD_POWER_STATUS, 1,
+		UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
+
+	/* disable dynamic power gating mode */
+	WREG32_P(SOC15_REG_OFFSET(UVD, inst_idx, mmUVD_POWER_STATUS), 0,
+			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
+
+	return 0;
+}
+
 static int vcn_v2_5_stop(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
@@ -981,6 +1260,12 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+			r = vcn_v2_5_stop_dpg_mode(adev, i);
+			goto power_off;
+		}
+
 		/* wait for vcn idle */
 		SOC15_WAIT_ON_RREG(VCN, i, mmUVD_STATUS, UVD_STATUS__IDLE, 0x7, r);
 		if (r)
@@ -1030,6 +1315,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 	}
 
+power_off:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_uvd(adev, false);
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
