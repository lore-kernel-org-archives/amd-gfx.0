Return-Path: <SRS0=OBgM=3D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88605C33CB8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C2B24656
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jan 2020 17:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GKZ/yr0z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C2B24656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2456E44B;
	Tue, 14 Jan 2020 17:58:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A5656E447
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jan 2020 17:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvSkWmxwj3TXCKk7/KzI/CMWh798VGjkwNMCGl128770wiAzJLlR33xXmJfJxattaNyikVkW+K2iM79QFsWpPCsYIoMdcZD7JF+NEJ4dgzw25zpD78sHJuFw5YMjFVyTMUb41e2Qb+ByZXmHKZtZVuleXNyMsg0mkRUbq7oJyCK672GKlA+Qc6OXPtuM82bAhpUxqHA4R4I7JFTglW/Q4bsrz2senjgvzixG1VA1f0rp9ykrvURwxkIKUR8r2c8bnMax2vf1ofT1/ipolDPDpb/gKeD9StQeAjlK1JetNVi6neepX3rf0TX5+xZboI89yzuuq+2WCzwrJni1g8lmpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rsy3HI4r1fwZUzTFwErLtcpNbFjpDl0OAr79eozYFN4=;
 b=g5dKpFCpkmCjfE77k+LiwC0YOEIGySrHwSmJo9lGIcDgt2TrdMSLHToS+GGuOus63ZThNVSy05PP+yjEAK8ZuS3ePeFuv1zEQhWPCBopOS0JMX8+XULygRKtR+iGPJujsHSz/8BseMe1/ekLeYec39Jbuy/mf634tEd3exoT/fEApc6EVNHmKPMRopmJ2X+4KZI9ZF7TBe6nWwzf00BxXNEAY0bTFDwqcqLj5n+GF/UdHIM2/8SXlTI68jLAO4vmw/n7Lo1JPXrQF8YG6hxUiZt49ht2AeBGBpIMwk1FXtUL0a5V9sTmAKKzyclY50l9H46EK53Yp62ev6PBFUHRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rsy3HI4r1fwZUzTFwErLtcpNbFjpDl0OAr79eozYFN4=;
 b=GKZ/yr0z6eF8zheBnzytYiJh7ZW3EzDX0pfo0fP2ZHRb6VkGlLcEXEa2qg4czfy9zTQkonZA3opsqy36d49Nsod4OoZU/l6ECOLQi0Q2a9bOTEUg8b6rda8Ut5iO3u/cjj+QfEcWyw1JBoGyu3wr8Mk8iPh1eVWG89xL7/lUx7o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB3109.namprd12.prod.outlook.com (20.178.54.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Tue, 14 Jan 2020 17:58:34 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.015; Tue, 14 Jan 2020
 17:58:34 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu/vcn2.5: implement indirect DPG SRAM mode
Date: Tue, 14 Jan 2020 12:58:22 -0500
Message-Id: <1579024702-27996-7-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
References: <1579024702-27996-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::35) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0058.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2623.9 via Frontend
 Transport; Tue, 14 Jan 2020 17:58:33 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3866f29-9553-4315-4dcb-08d7991b5f78
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:|BYAPR12MB3109:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31096E92800F84D91C12052CE4340@BYAPR12MB3109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-Forefront-PRVS: 028256169F
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(136003)(366004)(39860400002)(199004)(189003)(8676002)(81156014)(6486002)(26005)(81166006)(186003)(956004)(2616005)(6666004)(6916009)(7696005)(52116002)(16526019)(66476007)(66946007)(66556008)(4326008)(8936002)(36756003)(2906002)(478600001)(5660300002)(86362001)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB3109;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPDAxq/ywSjHXeAJvo0lAy7m5GAQ9K4IBMkDLYpcu9HVbZ8zRycndl+J9W03jW1bZVKv/V60Cxr4P7V9M+TJ9/5yfR1/VlMjoV+TFURt3jmGOcsbysBW8hM8zkKtpNdrBVjt5bYDofgXSyTMe/+rlcQvVJBwV1y7huNZ+MX5zDV6WFxirBHd67Z3bE4S/U/ZXpCojsRl8t1y465YuprTz4M3ahzHDFXcDf57ZyInLRelq2IFj24ptVNH2kqr0KlFJg7n3E0pgGcuyNoR/A5xbgJRmZVQUDLKvOQseC2dSe7GV2mqzYm07/NfkjjOaSjcc31n2B6RhdSr36U+RQGdKEkmFAC7+3/7mRyTlKy1wODSp0sUW2GNJjcgUKFgiVCTRM66oOLhvbH7u0hkse+z/d1GLRkLe2Ai/DFZAaSa8M+dEFwlDzjJSny+WKa2oA9x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3866f29-9553-4315-4dcb-08d7991b5f78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 17:58:34.2470 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kHoY9CRp/ECE+qP21KuvNNqkpX7UvBtz51GRhvD1/p8M9qt5JUqe9n3vREgJ+xH
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

Implement indirect DPG SRAM mode for vcn2.5

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 15 ++++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 69 +++++++++++++++++++++++----------
 3 files changed, 62 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index ca62d99..ab51f0e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -75,6 +75,9 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
 		break;
 	case CHIP_ARCTURUS:
 		fw_name = FIRMWARE_ARCTURUS;
+		if ((adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) &&
+		    (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
+			adev->vcn.indirect_sram = true;
 		break;
 	case CHIP_RENOIR:
 		fw_name = FIRMWARE_RENOIR;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 34ff75c..ff78ddc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -138,11 +138,16 @@
 
 #define WREG32_SOC15_DPG_MODE_2_5(inst_idx, offset, value, mask_en, indirect)				\
 	do {											\
-		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA, value);			\
-		WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 				\
-			(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |			\
-			 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |			\
-			 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));		\
+		if (!indirect) {								\
+			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_DATA, value);			\
+			WREG32_SOC15(VCN, inst_idx, mmUVD_DPG_LMA_CTL, 				\
+				(0x1 << UVD_DPG_LMA_CTL__READ_WRITE__SHIFT |			\
+				 mask_en << UVD_DPG_LMA_CTL__MASK_EN__SHIFT |			\
+				 offset << UVD_DPG_LMA_CTL__READ_WRITE_ADDR__SHIFT));		\
+		} else {									\
+			*adev->vcn.inst[inst_idx].dpg_sram_curr_addr++ = offset;				\
+			*adev->vcn.inst[inst_idx].dpg_sram_curr_addr++ = value;				\
+		}										\
 	} while (0)
 
 enum engine_status_constants {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 8de51c9..54a28d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -438,14 +438,23 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 
 	/* cache window 0: fw */
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
-		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
-			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
-			(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi), 0, indirect);
-		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		if (!indirect) {
+			WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo), 0, indirect);
+			WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi), 0, indirect);
+			WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		} else {
+			WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
+			WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
+			WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+		}
 		offset = 0;
 	} else {
 		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
@@ -460,19 +469,31 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
-	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+	if (!indirect)
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+	else
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
-	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
-		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
-		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
-	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
-
+	if (!indirect) {
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+	} else {
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
+		WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
+			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+	}
 	WREG32_SOC15_DPG_MODE_2_5(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
@@ -745,6 +766,9 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	tmp |= UVD_POWER_STATUS__UVD_PG_EN_MASK;
 	WREG32_SOC15(UVD, inst_idx, mmUVD_POWER_STATUS, tmp);
 
+	if (indirect)
+		adev->vcn.inst[inst_idx].dpg_sram_curr_addr = (uint32_t*)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr;
+
 	/* enable clock gating */
 	vcn_v2_5_clock_gating_dpg_mode(adev, 0, inst_idx, indirect);
 
@@ -820,6 +844,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		UVD, inst_idx, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
+	if (indirect)
+		psp_update_vcn_sram(adev, inst_idx, adev->vcn.inst[inst_idx].dpg_sram_gpu_addr,
+				    (uint32_t)((uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_curr_addr -
+					       (uintptr_t)adev->vcn.inst[inst_idx].dpg_sram_cpu_addr));
+
 	ring = &adev->vcn.inst[inst_idx].ring_dec;
 	/* force RBC into idle state */
 	rb_bufsz = order_base_2(ring->ring_size);
@@ -868,7 +897,7 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
-			return vcn_v2_5_start_dpg_mode(adev, i, 0);
+			return vcn_v2_5_start_dpg_mode(adev, i, adev->vcn.indirect_sram);
 
 		/* disable register anti-hang mechanism */
 		WREG32_P(SOC15_REG_OFFSET(UVD, i, mmUVD_POWER_STATUS), 0,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
