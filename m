Return-Path: <SRS0=xvO7=5P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E785C2D0EE
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D9BB20714
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2020 12:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="P0JesgBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D9BB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF7CD6E279;
	Mon, 30 Mar 2020 12:14:32 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38A6D6E26C
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2020 12:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7+1Gv2L6G/OmT6Mnv/fy3I7C5qvTN1WUonOfkP/cXveRMku/aM0NP2f4evdOtU6uOHVfxJsoC6ev+eDSj8NIiZznZZNo5mmVGCUmwqartt4wSdkpjE5QIOBoxtOZpexrE3JPYViPAwhk5x/fq+5ZKV93pvbwX9UwheRNpEB5otF209kCV2FBkDIZz+06/0bce/nnKDhpPyXOVZReiBjHB45W6T6lTxg8JgNmFy+MbOKXpXp35faHzlLpEspniKwfK0ZlzWaITOSWJbr8LrqO3BWAJk1p8QgqStt+j63WWUSxqBKWA7pT3sAOjd3y5Z++q3DDnzGmRfs2g/IfsxYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEOAFb1HfPjABam7zegu/KiMunuTc71mkolxCPm5efw=;
 b=ABJPaNaxXC0JlcsBIC67ym+YYDprEO+x5JCgEOMmgJu711r8DY3JwRZiMz+oNEwmBWm0wOrPHg6aqVJHVWbMqhjwGhB5Hhdbu2FgUqd8nI3n+rSigFI3kcyNSQ7KeDyPuwtW+e0Ll41abj1aKydi5W+eUXJCzdVbjJH3FOHsK+3A1pxQhN7M5aHETuaFFShwgwtdBH4YVGS9k/71uw4rDGtfLLVKHnWa/i5Cfrsky/T8i34KElk+YP7q2kc3ffH/hx7H4mpcwn5jg5rqcEP9XpszHrW6sqLxIxynSdvHrTbv3BmFzk50nDAT4bywd3HvZMUqOdOKzE/Kkyp5eJm/pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yEOAFb1HfPjABam7zegu/KiMunuTc71mkolxCPm5efw=;
 b=P0JesgBVgh+3XOZhqwN0ZPn+oDqrP+W41KNk+hjlt+Di09eTmUUks+V2bl60Z77gpUzidMthW1i06OAcT6AMtbS5suUhwIbhazeeVs4ag5kLZupd3cM6f0XppuSmgcYG7XuE9+DLHEj2b1d166/1IMu9a5MHoof+JtHD9FL0E5Y=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Zhu@amd.com; 
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM5PR12MB2358.namprd12.prod.outlook.com (2603:10b6:4:b3::34) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Mon, 30 Mar 2020 12:14:31 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::bcb9:8228:818:6129%3]) with mapi id 15.20.2856.019; Mon, 30 Mar 2020
 12:14:31 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu/vcn2.0: Add firmware w/r ptr reset sync
Date: Mon, 30 Mar 2020 08:13:37 -0400
Message-Id: <1585570418-13894-4-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
References: <1585570418-13894-1-git-send-email-James.Zhu@amd.com>
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2856.18 via Frontend Transport; Mon, 30 Mar 2020 12:14:30 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8162ba43-d958-4a47-4a4c-08d7d4a3e69b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2358:|DM5PR12MB2358:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23587B72C6FF352F3EDA7B3FE4CB0@DM5PR12MB2358.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-Forefront-PRVS: 0358535363
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(66946007)(81166006)(86362001)(8676002)(81156014)(8936002)(6486002)(2616005)(956004)(478600001)(66556008)(66476007)(52116002)(5660300002)(16526019)(4326008)(7696005)(316002)(2906002)(26005)(6916009)(186003)(36756003);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKyaHHvZvJQGvm4WNkWXFaBR8t9KJDT/gmyCi40YbvLkZ/aul8SyMT8HNVMBd/tkZbhQob2DxEIRR89Nzff4ZW9xgZ5ihfaSBtvsbxyXbRzjcOikcdSxY6yIv4bsxRoKa6i//Od6/CMTZxNya6QOADzG83rdV0CcDCyO3fyWdLkzP1ZllTp0PW8/7rgiLKaQ1OV/Xy6LyN9zki4dzM1ZcueDpfoXNk3jTJ9rKbh6qE6N0NJHChr7pXVwnLPvGPWe9VqqPq8nCvS+7nuQTeIcw+hxqXmg/NXtKvwtTwK7l9wAb+YuHqfzMqwkawuK6Ad3UUPQI/h7w5YROQ+HrXyNFml9EcYIUdW1WWjL6AZr34vAkghew9DR8Lxi/85GJTCrDqVEVplGrG8V2ItBt1AmZu8Jcov+Aty63DUpjuwWkGuf7COuT5NHUPfjt/yyYgO/
X-MS-Exchange-AntiSpam-MessageData: PHjuM0+E5KZZBNzvBniqgQLD5cHX37e9Bo+XhbMwubFFJn6L//3EtuXPwqDwVlQA4qY1LeNuT8RX1kkJQXrUQlhkeK4oOQT+uITywH5p7V67MnHWkPKFbA03FndA9MVw+lbosmwo1jAiCEstXX+svA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8162ba43-d958-4a47-4a4c-08d7d4a3e69b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2020 12:14:31.2387 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aJ+KgkzKXGVIRk7bqUNuAu/UD+tFa/pPrMBZQj+JRS460EFH652RKDtJoIfmqfcY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2358
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

Add firmware write/read point reset sync through shared memory

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 42 ++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 28ef7df..852795c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -92,6 +92,7 @@ static int vcn_v2_0_sw_init(void *handle)
 	struct amdgpu_ring *ring;
 	int i, r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	volatile struct amdgpu_fw_shared *fw_shared;
 
 	/* VCN DEC TRAP */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
@@ -174,6 +175,8 @@ static int vcn_v2_0_sw_init(void *handle)
 	if (r)
 		return r;
 
+	fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
+	fw_shared->present_flag_0 = cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG);
 	return 0;
 }
 
@@ -188,6 +191,9 @@ static int vcn_v2_0_sw_fini(void *handle)
 {
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
+
+	fw_shared->present_flag_0 = 0;
 
 	amdgpu_virt_free_mm_table(adev);
 
@@ -363,6 +369,15 @@ static void vcn_v2_0_mc_resume(struct amdgpu_device *adev)
 	WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_OFFSET2, 0);
 	WREG32_SOC15(UVD, 0, mmUVD_VCPU_CACHE_SIZE2, AMDGPU_VCN_CONTEXT_SIZE);
 
+	/* non-cache window */
+	WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW,
+		lower_32_bits(adev->vcn.inst->fw_shared_gpu_addr));
+	WREG32_SOC15(UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH,
+		upper_32_bits(adev->vcn.inst->fw_shared_gpu_addr));
+	WREG32_SOC15(UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0, 0);
+	WREG32_SOC15(UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0,
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
+
 	WREG32_SOC15(UVD, 0, mmUVD_GFX10_ADDR_CONFIG, adev->gfx.config.gb_addr_config);
 }
 
@@ -446,13 +461,16 @@ static void vcn_v2_0_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indirec
 
 	/* non-cache window */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW), 0, 0, indirect);
+		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_LOW),
+		lower_32_bits(adev->vcn.inst->fw_shared_gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH), 0, 0, indirect);
+		UVD, 0, mmUVD_LMI_VCPU_NC0_64BIT_BAR_HIGH),
+		upper_32_bits(adev->vcn.inst->fw_shared_gpu_addr), 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
 		UVD, 0, mmUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
-		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0), 0, 0, indirect);
+		UVD, 0, mmUVD_VCPU_NONCACHE_SIZE0),
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE_2_0(0, SOC15_DPG_MODE_OFFSET_2_0(
@@ -777,6 +795,7 @@ static void vcn_v2_0_enable_static_power_gating(struct amdgpu_device *adev)
 
 static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 {
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 
@@ -880,6 +899,8 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
 		UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 		~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
+	fw_shared->multi_queue.decode_queue_mode |= fw_queue_ring_reset;
+
 	/* set the write pointer delay */
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR_CNTL, 0);
 
@@ -902,6 +923,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 		lower_32_bits(ring->wptr));
 
+	fw_shared->multi_queue.decode_queue_mode &= ~fw_queue_ring_reset;
 	/* Unstall DPG */
 	WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -910,6 +932,7 @@ static int vcn_v2_0_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 
 static int vcn_v2_0_start(struct amdgpu_device *adev)
 {
+	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
 	struct amdgpu_ring *ring = &adev->vcn.inst->ring_dec;
 	uint32_t rb_bufsz, tmp;
 	uint32_t lmi_swap_cntl;
@@ -1044,6 +1067,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	tmp = REG_SET_FIELD(tmp, UVD_RBC_RB_CNTL, RB_RPTR_WR_EN, 1);
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_CNTL, tmp);
 
+	fw_shared->multi_queue.decode_queue_mode |= fw_queue_ring_reset;
 	/* programm the RB_BASE for ring buffer */
 	WREG32_SOC15(UVD, 0, mmUVD_LMI_RBC_RB_64BIT_BAR_LOW,
 		lower_32_bits(ring->gpu_addr));
@@ -1056,20 +1080,25 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	ring->wptr = RREG32_SOC15(UVD, 0, mmUVD_RBC_RB_RPTR);
 	WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 			lower_32_bits(ring->wptr));
+	fw_shared->multi_queue.decode_queue_mode &= ~fw_queue_ring_reset;
 
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode |= fw_queue_ring_reset;
 	ring = &adev->vcn.inst->ring_enc[0];
 	WREG32_SOC15(UVD, 0, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
 	WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
 	WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO, ring->gpu_addr);
 	WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
 	WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~fw_queue_ring_reset;
 
+	fw_shared->multi_queue.encode_lowlatency_queue_mode |= fw_queue_ring_reset;
 	ring = &adev->vcn.inst->ring_enc[1];
 	WREG32_SOC15(UVD, 0, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
 	WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
 	WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO2, ring->gpu_addr);
 	WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
 	WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
+	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~fw_queue_ring_reset;
 
 	return 0;
 }
@@ -1191,6 +1220,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				UVD_POWER_STATUS__UVD_POWER_STATUS_MASK, ret_code);
 
 			if (!ret_code) {
+				volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared_cpu_addr;
 				/* pause DPG */
 				reg_data |= UVD_DPG_PAUSE__NJ_PAUSE_DPG_REQ_MASK;
 				WREG32_SOC15(UVD, 0, mmUVD_DPG_PAUSE, reg_data);
@@ -1205,6 +1235,7 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 					   UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK,
 					   ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 				/* Restore */
+				fw_shared->multi_queue.encode_generalpurpose_queue_mode |= fw_queue_ring_reset;
 				ring = &adev->vcn.inst->ring_enc[0];
 				ring->wptr = 0;
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO, ring->gpu_addr);
@@ -1212,7 +1243,9 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE, ring->ring_size / 4);
 				WREG32_SOC15(UVD, 0, mmUVD_RB_RPTR, lower_32_bits(ring->wptr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR, lower_32_bits(ring->wptr));
+				fw_shared->multi_queue.encode_generalpurpose_queue_mode &= ~fw_queue_ring_reset;
 
+				fw_shared->multi_queue.encode_lowlatency_queue_mode |= fw_queue_ring_reset;
 				ring = &adev->vcn.inst->ring_enc[1];
 				ring->wptr = 0;
 				WREG32_SOC15(UVD, 0, mmUVD_RB_BASE_LO2, ring->gpu_addr);
@@ -1220,9 +1253,12 @@ static int vcn_v2_0_pause_dpg_mode(struct amdgpu_device *adev,
 				WREG32_SOC15(UVD, 0, mmUVD_RB_SIZE2, ring->ring_size / 4);
 				WREG32_SOC15(UVD, 0, mmUVD_RB_RPTR2, lower_32_bits(ring->wptr));
 				WREG32_SOC15(UVD, 0, mmUVD_RB_WPTR2, lower_32_bits(ring->wptr));
+				fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~fw_queue_ring_reset;
 
+				fw_shared->multi_queue.decode_queue_mode |= fw_queue_ring_reset;
 				WREG32_SOC15(UVD, 0, mmUVD_RBC_RB_WPTR,
 					   RREG32_SOC15(UVD, 0, mmUVD_SCRATCH2) & 0x7FFFFFFF);
+				fw_shared->multi_queue.decode_queue_mode &= ~fw_queue_ring_reset;
 				/* Unstall DPG */
 				WREG32_P(SOC15_REG_OFFSET(UVD, 0, mmUVD_POWER_STATUS),
 					   0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
