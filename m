Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC23C2D0E8
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6B520757
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 10:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HOtWwU9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6B520757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A75556EB6B;
	Fri,  3 Apr 2020 10:56:10 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C65236EB6B
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 10:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWm4Jms/FemyUGe6ifivQW3f3k+gWHpUOkNSuuLtNsFb+DIOgAfvhrtQqTK4Cnnyk9wmL7jN3QMQpfvgBA1fhGio222GdZsmaOm0iEKRNGYHMcy8julHyYTKj2l1xynD1+zR+lQ/sd2Xy1zuhToOKa2N9p9ewzSJaOdDyKC4tUCz0DiFg6dRC+bRyYULAOSZfuIkFz72lXw+pm+gNcGJflIH7+LAk7dqBTaUHS52T+U9oeikdvi92wdzawKqGSqoLoLwJnHp6NP3xjA7KuMO5JADILNp47iRx+Yr0GPNEpAbz2v4Nf3H8PJbCnY8t9mxyu2mwmc7u/uSUBACNhdvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IpSFfwJh2/zN4fiuzKWJT7JcZuNNEhrG8rbxOGx2qc=;
 b=beWPbIIeaaL9nKogPU1NqSUZh8S6PsLYnHQzq9zLctZvyaMqJizeQCI5aV1mgfeLFQUiilLCfADc6ebq372LTXeFFg7sTYoE9l5nAETKikDb3HMYQ2qDwUEd+Uo9Jr405d+kHkflahaAoy8oIBBV0EIF+aHoI/o42OtZA7V+aRR4vAgAmtbvIJEQImX7QfrLSAmoIpqdjDR8F8wGAjJ4mDC2OQeCosAE9HgwML3laGZ//8pnv3rV5oDNf0OpvOiDcynJ+f6qNGFjQ7tLQ+OI9cnU1OpBcxOHqQ/oUMmFgV21tNXlKpbhoXHtg0JnlQgJyORzR/qxsueOj2d/rfHZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IpSFfwJh2/zN4fiuzKWJT7JcZuNNEhrG8rbxOGx2qc=;
 b=HOtWwU9c7/6mhHE909X62sfWu4aPmvgCV5d7rAkoH//bYX7McEEQ1UgZAdGkylzjp71i8Q6UXyBUIYM4uCVNAKyE9+zcKr3cjaaZrLKM1+vYipM+KWg8oiqWBLSB4bqgkA20wVn6IZOB8VbY8jgybQnlNI3wZpBg7FOr9afiGus=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hawking.Zhang@amd.com; 
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3833.namprd12.prod.outlook.com (2603:10b6:5:1cf::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.19; Fri, 3 Apr 2020 10:56:08 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::796f:dc4e:4661:5273%6]) with mapi id 15.20.2878.014; Fri, 3 Apr 2020
 10:56:08 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/6] drm/amdgpu: support access regs outside of mmio bar
Date: Fri,  3 Apr 2020 18:55:30 +0800
Message-Id: <1585911330-27664-7-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
References: <1585911330-27664-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (180.167.199.189) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 10:56:07 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a526181b-2c56-41bf-b605-08d7d7bd9cf6
X-MS-TrafficTypeDiagnostic: DM6PR12MB3833:|DM6PR12MB3833:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB38337D603D42A3DEDA197914FCC70@DM6PR12MB3833.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 0362BF9FDB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(8936002)(36756003)(7696005)(66556008)(66946007)(5660300002)(81156014)(66476007)(52116002)(8676002)(81166006)(186003)(4326008)(2616005)(956004)(26005)(16526019)(86362001)(6666004)(478600001)(6916009)(6486002)(2906002)(316002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RvBmGqrddFs6jjFWHAo1n0H4K4mtWmUdd7GZWFFxO7YHBgDqfGxM6VnBd+0ZZdhhuxBfHa/OpEYH25G/7f1S2wWoyYKMrYCMeTzYhbPHUPt7DSXG/++7zR2sYWiHoEXnSInJOnxWQTFLSCZ+75fD61do18iHgzZ0yFJfcS9MAi8DRhGu3ih1leWlDdiVw4Vnd1KTkxObwjnFQLgY7Amy40mH0H1QyOZECge7ZrAV6yccuNliDM6U/9QozG+AJEaQBKSTuKIcKCwsSGfrji44l3fNGaya9GDpqEJoT7alA7nFoxreF0PXweu70Jv2KmM2stXjcB4J+vHiEmbTIyhgOsGy459TXey0xX5216J7xSCnmgX1HBheAWFcUA0SbJ7FusylkaucSd9K4/IlYwtZgaXQMyomG4mVTdTM/rRwUu0llYDgVnDjQ/riziAFugxR
X-MS-Exchange-AntiSpam-MessageData: wQePmeRDKkC2KS2x6L70GW6d6rAkSik32cbRdq9OtJfrxhpXD7vmzk5ZYMhcaBePG60c/LQGYXUCDHr8yiGK/H/r1faZeZOsWK5RHgQOQIdv5K8YXZGoEL+jv0/Ek0AIR8dRe84goFWBLnkHCgxqSA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a526181b-2c56-41bf-b605-08d7d7bd9cf6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 10:56:08.2431 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IME/YbFgAupapbTbJHlCU/++iyZjlt4K+a2mfSyB0b7CkNRdByblX6siY+BR7eEM8ZY1OHvuXz1l4Db5DlwQ8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3833
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
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add indirect access support to registers outside of
mmio bar.

Change-Id: I825c9c67dce8fa010e3072d65e45eae7bbd3b45a
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 18 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 +++++++++++-------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  |  4 +--
 3 files changed, 28 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4466d96..21a7307 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1007,10 +1007,10 @@ int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
 
 void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 			       uint32_t *buf, size_t size, bool write);
-uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
+uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t acc_flags);
+void amdgpu_device_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 			uint32_t acc_flags);
-void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
-		    uint32_t acc_flags);
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
@@ -1029,8 +1029,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
  */
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
 
-#define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
-#define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
+#define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
+#define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
 #define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
 #define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
@@ -1038,9 +1038,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
 
-#define RREG32(reg) amdgpu_mm_rreg(adev, (reg), 0)
-#define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_mm_rreg(adev, (reg), 0))
-#define WREG32(reg, v) amdgpu_mm_wreg(adev, (reg), (v), 0)
+#define RREG32(reg) amdgpu_device_rreg(adev, (reg), 0)
+#define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_device_rreg(adev, (reg), 0))
+#define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
 #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
@@ -1077,7 +1077,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 		tmp_ |= ((val) & ~(mask));			\
 		WREG32_PLL(reg, tmp_);				\
 	} while (0)
-#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_mm_rreg((adev), (reg), false))
+#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
 #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
 #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 23d75449..47ef8a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -298,10 +298,10 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 }
 
 /*
- * MMIO register access helper functions.
+ * device register access helper functions.
  */
 /**
- * amdgpu_mm_rreg - read a memory mapped IO register
+ * amdgpu_device_rreg - read a register
  *
  * @adev: amdgpu_device pointer
  * @reg: dword aligned register offset
@@ -309,8 +309,8 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
  *
  * Returns the 32 bit value from the offset specified.
  */
-uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
-			uint32_t acc_flags)
+uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
+			    uint32_t acc_flags)
 {
 	uint32_t ret;
 
@@ -319,15 +319,9 @@ uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 
 	if ((reg * 4) < adev->rmmio_size)
 		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
-	else {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
-		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
-		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
-	}
-	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
+	else
+		ret = adev->pcie_rreg(adev, reg);
+	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
 	return ret;
 }
 
@@ -373,24 +367,19 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 		BUG();
 }
 
-void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
+void static inline amdgpu_device_wreg_no_kiq(struct amdgpu_device *adev, uint32_t reg,
+					     uint32_t v, uint32_t acc_flags)
 {
-	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
+	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size)
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
-	else {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
-		writel(v, ((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
-		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
-	}
+	else
+		adev->pcie_wreg(adev, reg, v);
 }
 
 /**
- * amdgpu_mm_wreg - write to a memory mapped IO register
+ * amdgpu_device_wreg - write to a register
  *
  * @adev: amdgpu_device pointer
  * @reg: dword aligned register offset
@@ -399,13 +388,13 @@ void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg,
  *
  * Writes the value specified to the offset specified.
  */
-void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
-		    uint32_t acc_flags)
+void amdgpu_device_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
+			uint32_t acc_flags)
 {
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
-	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
+	amdgpu_device_wreg_no_kiq(adev, reg, v, acc_flags);
 }
 
 /*
@@ -424,7 +413,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
 			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v);
 	}
 
-	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
+	amdgpu_device_wreg_no_kiq(adev, reg, v, acc_flags);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 63e734a..5da20fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -35,7 +35,7 @@
 #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
 	 job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)
 
-TRACE_EVENT(amdgpu_mm_rreg,
+TRACE_EVENT(amdgpu_device_rreg,
 	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
 	    TP_ARGS(did, reg, value),
 	    TP_STRUCT__entry(
@@ -54,7 +54,7 @@ TRACE_EVENT(amdgpu_mm_rreg,
 		      (unsigned long)__entry->value)
 );
 
-TRACE_EVENT(amdgpu_mm_wreg,
+TRACE_EVENT(amdgpu_device_wreg,
 	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
 	    TP_ARGS(did, reg, value),
 	    TP_STRUCT__entry(
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
