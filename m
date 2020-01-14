Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E77C33C9E
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 18:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D7524655
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 18:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="N/HgqEsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D7524655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E53466E027;
	Tue, 14 Jan 2020 18:59:03 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690082.outbound.protection.outlook.com [40.107.69.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485CB6E027
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 18:59:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVkytA9RP7xqd8IH3+ntdGVqfIXgiOCmzXqorf0hvOzp9/HcPcXHGIo4fLrQlHgd4uXjn4Na4cQS25jTle2dJLNXnnxQn5EG1mSV+CzMKbUwU4nKUzYAupy4ofo9Ybliem3a45rFruWdvxEDUrl+p5LD/BZrEfg8Db5njVrH3YWJJHdQRt7buiGxU3tU6/TGWHoi1MWqvdEs+ER4GOS6c3wIsNgP3R5nIloSLbt6p1DpIaGehtmIqANHG5DhrTBA5KPeLL8MJspg4m0Iw7lm9a7/v0f38YF1QuDU8pVFo3PTVJuv1de8lt1BYU+fbZ2jfsz7DawxTa2NqFp5uN0Ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deNwFyDiUco5mxI+UtfEWwpe+l0AGpoG0OubkpLSRZ4=;
 b=B2Sd+TW1+L7fg4EW3NvBhf5N9Sby37pffqQ3KYIpvInbZT/I19HiILaVm6ss+myvaCANhFxYAv8n0McThQ2n65pdGE1yfgQW07xLL371/pxcUGEfcly3l5S9zzyrMvLulzSktuTpfakevXSERcODRA5fCrU6Ekf/AkPrUCph0IMxv+shOmjsr9IvMW+r4LvmkXKDPZK4RQBeOMT+jBqFLaInb38SGZWYEDVbjRmQICkvRrwwLpV9/PYs+Ed01cykjthcmn5TqaQCtGvUM7IMb4EAOFNecMGj81vpIcisBqT4zsF8MxDjcioHAwPS1QIHF2RCOyS4DJnkTw0ueup7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deNwFyDiUco5mxI+UtfEWwpe+l0AGpoG0OubkpLSRZ4=;
 b=N/HgqEsF6QvK+FgnlqwLDnWMun34FSf3YwXOMCg+eqK3H5w7Fu8WfAKjkJDoRDuCk1vfW36TGUOREVatT4VDnPDNGl1vGq6jj0s3C9Q86I+aTeX/q+EMX/icooBCIiykwoOzDHtruI5tc26PznsZYtTxDonXXc5IEIl8JeE/f6o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3109.namprd12.prod.outlook.com (20.178.54.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 18:59:01 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 18:59:01 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/6] drm/amdgpu/vcn2.5: add DPG mode start and stop
Date: Tue, 14 Jan 2020 13:58:53 -0500
Message-Id: <1579028333-885-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579024702-27996-4-git-send-email-James.Zhu@amd.com>
References: <1579024702-27996-4-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21)
 To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YT1PR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2644.18 via Frontend Transport; Tue, 14 Jan 2020 18:59:00 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42ced861-375e-4d63-e1f1-08d79923d134
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:|BYAPR12MB3109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3109EB8ECB5169DF94E9C06CE4340@BYAPR12MB3109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(199004)(189003)(81156014)(8676002)(6486002)(81166006)(26005)(186003)(956004)(2616005)(6916009)(6666004)(7696005)(52116002)(16526019)(66476007)(66946007)(66556008)(4326008)(8936002)(36756003)(478600001)(5660300002)(2906002)(30864003)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3109;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WNWxwtTpT32UDGsRdJopp4x7CEpQe5Lf5FZPrpt+vOcSHvTOBrcQ5+uWKSNXk4zbu2ZvQlrwhh14JfybQF7/lFu79/gjbx+w3uZBxa+EM21GBOd5KoIvoLfpzUrKtK837hJTNiK1e1rZK3S70gTcyoX3iTrZuwwZxXNGoGmcWoZuxtSDaewSEPsbMMCpPaEToNDDCqvGKbBPJ64QBGVt9XROGE8geugBz7yaJuy8Hk/Pbsw2hBkcZAzEusL5DbM7phAZzqt5yNscSx5zi5Jf71tYsPdYiRP7vtqWJqYokKIWjp7Nfft1ZAJG7z41nHtuuWTGciyDVTN5zMf61dQ9S7eoDRhmBEkfx+T3ELoZwQ7KulDcc9RCJ5L+nLSRrtE5fhLABVNZMOMmiPm6hXkexRU4aySVALyCUAhDCZ90EDqsdLzhGPM0x+CoCUegZ22F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42ced861-375e-4d63-e1f1-08d79923d134
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 18:59:01.1202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tDL084wDWXFH8PQlQ1DrysFY1/V2WKVE6DoclQx+aWb/aWyMPP+QBTBLLLelKpx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3109
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 295 +++++++++++++++++++++++++++++++++-
 1 file changed, 293 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index fa90249..5921e8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -48,6 +48,11 @@
 #define mmUVD_LMI_RBC_IB_64BIT_BAR_HIGH_INTERNAL_OFFSET 	0x3b5
 #define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET			0x25c
 
+#define mmUVD_RBC_XX_IB_REG_CHECK 					0x026b
+#define mmUVD_RBC_XX_IB_REG_CHECK_BASE_IDX 				1
+#define mmUVD_REG_XX_MASK 						0x026c
+#define mmUVD_REG_XX_MASK_BASE_IDX 					1
+
 #define VCN25_MAX_HW_INSTANCES_ARCTURUS			2
 
 static void vcn_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev);
@@ -286,7 +291,8 @@ static int vcn_v2_5_hw_init(void *handle)
 
 done:
 	if (!r)
-		DRM_INFO("VCN decode and encode initialized successfully.\n");
+		DRM_INFO("VCN decode and encode initialized successfully(under %s).\n",
+			(adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)?"DPG Mode":"SPG Mode");
 
 	return r;
 }
@@ -309,7 +315,9 @@ static int vcn_v2_5_hw_fini(void *handle)
 			continue;
 		ring = &adev->vcn.inst[i].ring_dec;
 
-		if (RREG32_SOC15(VCN, i, mmUVD_STATUS))
+		if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
+	        (adev->vcn.cur_state != AMD_PG_STATE_GATE &&
+	         RREG32_SOC15(VCN, i, mmUVD_STATUS)))
 			vcn_v2_5_set_powergating_state(adev, AMD_PG_STATE_GATE);
 
 		ring->sched.ready = false;
@@ -418,6 +426,78 @@ static void vcn_v2_5_mc_resume(struct amdgpu_device *adev)
 	}
 }
 
+static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx, bool indirect)
+{
+	uint32_t size = AMDGPU_GPU_PAGE_ALIGN(adev->vcn.fw->size + 4);
+	uint32_t offset;
+
+	/* cache window 0: fw */
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		offset = 0;
+	} else {
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
+		offset = size;
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0),
+			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
+	}
+
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+
+	/* cache window 1: stack */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+
+	/* cache window 2: context */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+
+	/* non-cache window */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
+
+	/* VCN global tiling registers */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+}
+
 /**
  * vcn_v2_5_disable_clock_gating - disable VCN clock gating
  *
@@ -536,6 +616,54 @@ static void vcn_v2_5_disable_clock_gating(struct amdgpu_device *adev)
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
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
+
+	/* turn off clock gating */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_CGC_GATE), 0, sram_sel, indirect);
+
+	/* turn on SUVD clock gating */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
+
+	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
+}
+
 /**
  * vcn_v2_5_enable_clock_gating - enable VCN clock gating
  *
@@ -598,6 +726,130 @@ static void vcn_v2_5_enable_clock_gating(struct amdgpu_device *adev)
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
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* disable master interupt */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
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
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_CTRL), tmp, 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MPC_CNTL),
+		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MPC_SET_MUXA0),
+		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
+		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
+		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MPC_SET_MUXB0),
+		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
+		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
+		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_MPC_SET_MUX),
+		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
+		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
+		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
+
+	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
+
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
+
+	/* enable LMI MC and UMC channels */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_LMI_CTRL2), 0, 0, indirect);
+
+	/* unblock VCPU register access */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
+
+	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
+	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+
+	/* enable master interrupt */
+	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
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
@@ -610,6 +862,9 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
+		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
+			return vcn_v2_5_start_dpg_mode(adev, i, 0);
+
 		/* disable register anti-hang mechanism */
 		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
@@ -973,6 +1228,35 @@ static int vcn_v2_5_sriov_start(struct amdgpu_device *adev)
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
@@ -981,6 +1265,12 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
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
@@ -1030,6 +1320,7 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
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
