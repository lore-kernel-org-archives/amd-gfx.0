Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC29C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7360F24653
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eFhEZqU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7360F24653
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B00646EDA2;
	Tue, 21 Jan 2020 16:19:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AA76ED9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 16:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oX3MQyMTwGT5bKk51e6R2SmVAUNXnFUw6hf3WBdGaHJUr/c6BRrwOQ6ExIpMmn/THukjn6oKBwVPHDX951xqd0cN8IFznNcx/fJubWrHUlSYyX4Vm5ju0iC/JUPEba7PgkrAM+31CLAhhVnr8zae3WESMqouQ2Rp9+UpCOFNf6ckr1J9MIjnlmMGntj9EOT0eXpDo60yeLjepinC7hRa4o09WU5ct/+1MV7okve3ClZDFM9OMgcKCcpiWh7JzMjB3rTRxgElvpsripAXUzVj7d0oS7YJmYC6pdO9kvSbujPIeniIQUZu0iMdwlGILw9gaqywEQ5fsGMkXOw1w1gYKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPSfPEwTmrknRjJx4em10NVQzTcZq/9kcOwDFuPoLng=;
 b=Estssbh07cSG9aERV7Eyro5Qt6tVPHR1obtoO1Bu5o/+CaZaXgMteUxn5WMkm49NrDXccrP1h+0neWlnjW3IMFWVr3iCdxzqo3umxVQ23RHhFVotCvFL7OGOcMxlg8wFR1cXtrtbe4TYic6aYAJXsPED8WwzbCQMRw2oh1KyUX/mYaGDgfdjKzSH2oAdqrCfFB+kAobS0vbVtgpOFDPcVTosVqk8eOZi4WwX37bpbiG9JPzs9Y4pdllgjFClWaubHXICAk7P37mubaUPPZqh+Lw14zsLxrvvZFlEHHTB9+q1CekBGnE2zp7sII1mz21lyV99BF44jlB7J275BHugnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPSfPEwTmrknRjJx4em10NVQzTcZq/9kcOwDFuPoLng=;
 b=eFhEZqU794eVkCrKoGmydVeuIr2gW9YK5tMW+1dBdNx8ylvqQqzwg4s4I0y2nzqFxcbaIS4TPAA5r959KSpybzgJ+CjbOIYoZzRX8TKw5Zfvt5LokLLM6MBwcYCRh6HsJ8EwrfARj5QuNPjjMPBHnJM/pIi/kzGJXbBHB7Rsz60=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from BYAPR12MB3285.namprd12.prod.outlook.com (20.179.92.142) by
 BYAPR12MB2696.namprd12.prod.outlook.com (20.177.124.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.26; Tue, 21 Jan 2020 16:19:29 +0000
Received: from BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99]) by BYAPR12MB3285.namprd12.prod.outlook.com
 ([fe80::18a7:759:1dbb:ef99%7]) with mapi id 15.20.2644.027; Tue, 21 Jan 2020
 16:19:29 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdgpu/vcn: fix vcn2.5 instance issue
Date: Tue, 21 Jan 2020 11:19:15 -0500
Message-Id: <1579623556-30941-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
References: <1579623556-30941-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::39) To BYAPR12MB3285.namprd12.prod.outlook.com
 (2603:10b6:a03:134::14)
MIME-Version: 1.0
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.2644.19 via Frontend
 Transport; Tue, 21 Jan 2020 16:19:28 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ab8669df-9a5f-4fba-e017-08d79e8db0be
X-MS-TrafficTypeDiagnostic: BYAPR12MB2696:|BYAPR12MB2696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2696641A9F394DD968541C0EE40D0@BYAPR12MB2696.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-Forefront-PRVS: 0289B6431E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(199004)(189003)(6916009)(30864003)(36756003)(86362001)(81156014)(8936002)(2906002)(81166006)(8676002)(498600001)(52116002)(6666004)(7696005)(26005)(186003)(4326008)(16526019)(66556008)(6486002)(66476007)(5660300002)(66946007)(956004)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2696;
 H:BYAPR12MB3285.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/kB5r3Cwa79HmJZs+Yih3jNxgev9D2e3trXf7QlqT5vgDZ7FiL6RzWn6iOerK0fccGGa6ydhWYX3sKn+ogsitDkDtQJLr2SqYV9Uk08uR0HVD6SxIkZUKB/GbRsehquem44xq/GKZUz3zGaqj1OmKJuqMMWKmeL+GYGk2cXD39/S1ML6/hlzOPeCEbQl3zRX6uPflIPnHwNvZn4iqa380y/kp+5l6u1BuC9I/fyxWhdnpf5CXGv1wkwkayEgheXqeOdODVemhr9yDAc5/4aLcs2H4u9ycx5CKsoWXaXrADeirPssEvzOneYkQK7Xa6m2phjRurDgoIDOPtlnsTuIJE0Yb9c4V7SJLZsE/CZfDCWkz0f4ZO7n9p9g8fsFlVAi6dzuvBZ1bTAQHITfIW3tK7VKSAqZSAsYh547UID43p3Qnrm1nEnbM2ghk+N9YL8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab8669df-9a5f-4fba-e017-08d79e8db0be
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 16:19:29.2429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DA/oZU7CPUm8EFRHt96WfkiYYbWymoZYMrkpKD00+dTou5CV3YCLamDM/SW5/ahu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2696
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

Fix vcn2.5 instance issue, vcn0 and vcn1 have same register offset

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  4 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   | 86 ++++++++++++++++----------------
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 88 ++++++++++++++++-----------------
 3 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index c4984c5..60fe3c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -86,12 +86,12 @@
 			(sram_sel << UVD_DPG_LMA_CTL__SRAM_SEL__SHIFT)); 		\
 	} while (0)
 
-#define SOC15_DPG_MODE_OFFSET_2_0(ip, inst, reg) 						\
+#define SOC15_DPG_MODE_OFFSET_2_0(ip, reg) 							\
 	({											\
 		uint32_t internal_reg_offset, addr;						\
 		bool video_range, aon_range;							\
 												\
-		addr = (adev->reg_offset[ip##_HWIP][inst][reg##_BASE_IDX] + reg);		\
+		addr = (adev->reg_offset[ip##_HWIP][0][reg##_BASE_IDX] + reg);			\
 		addr <<= 2; 									\
 		video_range = ((((0xFFFFF & addr) >= (VCN_VID_SOC_ADDRESS_2_0)) && 		\
 				((0xFFFFF & addr) < ((VCN_VID_SOC_ADDRESS_2_0 + 0x2600)))));	\
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index e2ad5afe..ad11c8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -352,88 +352,88 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		if (!indirect) {
 			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_lo), 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN].tmr_mc_addr_hi), 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+				UVD, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		} else {
 			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
+				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
+				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, 0, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+				UVD, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		}
 		offset = 0;
 	} else {
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst->gpu_addr), 0, indirect);
 		offset = size;
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_OFFSET0),
+			UVD, mmUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
 	if (!indirect)
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+			UVD, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
 	else
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
+			UVD, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
 	if (!indirect) {
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst->gpu_addr + offset), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+			UVD, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	} else {
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
+			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
+			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, 0, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+			UVD, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	}
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+		UVD, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
 	/* cache window 2: context */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		UVD, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		UVD, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst->gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+		UVD, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+		UVD, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
 
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
+		UVD, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
+		UVD, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+		UVD, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
+		UVD, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		UVD, mmUVD_GFX10_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 /**
@@ -579,19 +579,19 @@ static void vcn_v2_0_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__SCPU_MODE_MASK);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
+		UVD, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
 
 	/* turn off clock gating */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_CGC_GATE), 0, sram_sel, indirect);
+		UVD, mmUVD_CGC_GATE), 0, sram_sel, indirect);
 
 	/* turn on SUVD clock gating */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
+		UVD, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
+		UVD, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
 }
 
 /**
@@ -764,11 +764,11 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__MIF_WR_LOW_THRESHOLD_BP_MASK;
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+		UVD, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* disable master interupt */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MASTINT_EN), 0, 0, indirect);
+		UVD, mmUVD_MASTINT_EN), 0, 0, indirect);
 
 	/* setup mmUVD_LMI_CTRL */
 	tmp = (UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
@@ -780,28 +780,28 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		0x00100000L);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_CTRL), tmp, 0, indirect);
+		UVD, mmUVD_LMI_CTRL), tmp, 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MPC_CNTL),
+		UVD, mmUVD_MPC_CNTL),
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MPC_SET_MUXA0),
+		UVD, mmUVD_MPC_SET_MUXA0),
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MPC_SET_MUXB0),
+		UVD, mmUVD_MPC_SET_MUXB0),
 		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MPC_SET_MUX),
+		UVD, mmUVD_MPC_SET_MUX),
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
@@ -809,22 +809,22 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	vcn_v2_0_mc_resume_dpg_mode(adev, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
+		UVD, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
+		UVD, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
 
 	/* release VCPU reset to boot */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_SOFT_RESET), 0, 0, indirect);
+		UVD, mmUVD_SOFT_RESET), 0, 0, indirect);
 
 	/* enable LMI MC and UMC channels */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_CTRL2),
+		UVD, mmUVD_LMI_CTRL2),
 		0x1F << UVD_LMI_CTRL2__RE_OFLD_MIF_WR_REQ_NUM__SHIFT, 0, indirect);
 
 	/* enable master interrupt */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_MASTINT_EN),
+		UVD, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 740a291..42ca36c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -435,88 +435,88 @@ static void vcn_v2_5_mc_resume_dpg_mode(struct amdgpu_device *adev, int inst_idx
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) {
 		if (!indirect) {
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_lo), 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 				(adev->firmware.ucode[AMDGPU_UCODE_ID_VCN + inst_idx].tmr_mc_addr_hi), 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+				UVD, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		} else {
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
+				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW), 0, 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
+				UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH), 0, 0, indirect);
 			WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-				UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
+				UVD, mmUVD_VCPU_CACHE_OFFSET0), 0, 0, indirect);
 		}
 		offset = 0;
 	} else {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
+			UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
+			UVD, mmUVD_LMI_VCPU_CACHE_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr), 0, indirect);
 		offset = size;
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET0),
+			UVD, mmUVD_VCPU_CACHE_OFFSET0),
 			AMDGPU_UVD_FIRMWARE_OFFSET >> 3, 0, indirect);
 	}
 
 	if (!indirect)
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
+			UVD, mmUVD_VCPU_CACHE_SIZE0), size, 0, indirect);
 	else
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
+			UVD, mmUVD_VCPU_CACHE_SIZE0), 0, 0, indirect);
 
 	/* cache window 1: stack */
 	if (!indirect) {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
+			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW),
 			lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
+			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH),
 			upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset), 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+			UVD, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	} else {
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
+			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_LOW), 0, 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
+			UVD, mmUVD_LMI_VCPU_CACHE1_64BIT_BAR_HIGH), 0, 0, indirect);
 		WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-			UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
+			UVD, mmUVD_VCPU_CACHE_OFFSET1), 0, 0, indirect);
 	}
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
+		UVD, mmUVD_VCPU_CACHE_SIZE1), AMDGPU_VCN_STACK_SIZE, 0, indirect);
 
 	/* cache window 2: context */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
+		UVD, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_LOW),
 		lower_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
+		UVD, mmUVD_LMI_VCPU_CACHE2_64BIT_BAR_HIGH),
 		upper_32_bits(adev->vcn.inst[inst_idx].gpu_addr + offset + AMDGPU_VCN_STACK_SIZE), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
+		UVD, mmUVD_VCPU_CACHE_OFFSET2), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
+		UVD, mmUVD_VCPU_CACHE_SIZE2), AMDGPU_VCN_CONTEXT_SIZE, 0, indirect);
 
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
+		UVD, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
+		UVD, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
+		UVD, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
+		UVD, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
+		UVD, mmUVD_GFX8_ADDR_CONFIG), adev->gfx.config.gb_addr_config, 0, indirect);
 }
 
 /**
@@ -670,19 +670,19 @@ static void vcn_v2_5_clock_gating_dpg_mode(struct amdgpu_device *adev,
 		 UVD_CGC_CTRL__VCPU_MODE_MASK |
 		 UVD_CGC_CTRL__MMSCH_MODE_MASK);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
+		UVD, mmUVD_CGC_CTRL), reg_data, sram_sel, indirect);
 
 	/* turn off clock gating */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_CGC_GATE), 0, sram_sel, indirect);
+		UVD, mmUVD_CGC_GATE), 0, sram_sel, indirect);
 
 	/* turn on SUVD clock gating */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
+		UVD, mmUVD_SUVD_CGC_GATE), 1, sram_sel, indirect);
 
 	/* turn on sw mode in UVD_SUVD_CGC_CTRL */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
+		UVD, mmUVD_SUVD_CGC_CTRL), 0, sram_sel, indirect);
 }
 
 /**
@@ -772,11 +772,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	tmp |= UVD_VCPU_CNTL__BLK_RST_MASK;
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+		UVD, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* disable master interupt */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MASTINT_EN), 0, 0, indirect);
+		UVD, mmUVD_MASTINT_EN), 0, 0, indirect);
 
 	/* setup mmUVD_LMI_CTRL */
 	tmp = (0x8 | UVD_LMI_CTRL__WRITE_CLEAN_TIMER_EN_MASK |
@@ -788,28 +788,28 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 		(8 << UVD_LMI_CTRL__WRITE_CLEAN_TIMER__SHIFT) |
 		0x00100000L);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_CTRL), tmp, 0, indirect);
+		UVD, mmUVD_LMI_CTRL), tmp, 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MPC_CNTL),
+		UVD, mmUVD_MPC_CNTL),
 		0x2 << UVD_MPC_CNTL__REPLACEMENT_MODE__SHIFT, 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MPC_SET_MUXA0),
+		UVD, mmUVD_MPC_SET_MUXA0),
 		((0x1 << UVD_MPC_SET_MUXA0__VARA_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXA0__VARA_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXA0__VARA_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXA0__VARA_4__SHIFT)), 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MPC_SET_MUXB0),
+		UVD, mmUVD_MPC_SET_MUXB0),
 		((0x1 << UVD_MPC_SET_MUXB0__VARB_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUXB0__VARB_2__SHIFT) |
 		 (0x3 << UVD_MPC_SET_MUXB0__VARB_3__SHIFT) |
 		 (0x4 << UVD_MPC_SET_MUXB0__VARB_4__SHIFT)), 0, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MPC_SET_MUX),
+		UVD, mmUVD_MPC_SET_MUX),
 		((0x0 << UVD_MPC_SET_MUX__SET_0__SHIFT) |
 		 (0x1 << UVD_MPC_SET_MUX__SET_1__SHIFT) |
 		 (0x2 << UVD_MPC_SET_MUX__SET_2__SHIFT)), 0, indirect);
@@ -817,26 +817,26 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_device *adev, int inst_idx, boo
 	vcn_v2_5_mc_resume_dpg_mode(adev, inst_idx, indirect);
 
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
+		UVD, mmUVD_REG_XX_MASK), 0x10, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
+		UVD, mmUVD_RBC_XX_IB_REG_CHECK), 0x3, 0, indirect);
 
 	/* enable LMI MC and UMC channels */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_LMI_CTRL2), 0, 0, indirect);
+		UVD, mmUVD_LMI_CTRL2), 0, 0, indirect);
 
 	/* unblock VCPU register access */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
+		UVD, mmUVD_RB_ARB_CTRL), 0, 0, indirect);
 
 	tmp = (0xFF << UVD_VCPU_CNTL__PRB_TIMEOUT_VAL__SHIFT);
 	tmp |= UVD_VCPU_CNTL__CLK_EN_MASK;
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_VCPU_CNTL), tmp, 0, indirect);
+		UVD, mmUVD_VCPU_CNTL), tmp, 0, indirect);
 
 	/* enable master interrupt */
 	WREG32_SOC15_DPG_MODE_2_0(inst_idx, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, inst_idx, mmUVD_MASTINT_EN),
+		UVD, mmUVD_MASTINT_EN),
 		UVD_MASTINT_EN__VCPU_EN_MASK, 0, indirect);
 
 	if (indirect)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
