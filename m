Return-Path: <SRS0=hrZh=AL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE718C433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 08:56:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89F6F206E2
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2020 08:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UXAFyTtB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89F6F206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12A6889DC2;
	Tue, 30 Jun 2020 08:56:03 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700081.outbound.protection.outlook.com [40.107.70.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F247F89DC2
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2020 08:56:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DqZdYVks7dZl2EstXMbD346E4il6G07ZRAy8nnX1i9gYobVQ4dhZl06AeFdvx4Jcyie2UwgZwsSWER8Rm+2/s6qBSa1EstUAiDayg4m40xmWBVbZ50WppXEdwpST7Mn0oZe6yuH2xkU0vLRfI6L4CbbxSA1opGzkjgoKJ5AYFLkd6LcLHtfb1be/3MDsVabKlArFU3LhjD/s9W1SKjxa/tFB8JYyS0jBNJ7U4DnzuGcydsXgUEgNJ9iM79ud7WQYN7CCpCfBYBh1AlCACyu18AYVPlfgPp4JJxxlf+Sz3Mnn1t4/QyZ5iFM7wyNrNZX9SOFuKbRl5tXUI/ZTXCBZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9leQqKLxZSgq8Oyk60g0VEUUleTP6vLYvhr5mYlgkXM=;
 b=aoc/2PUsMCY1gndMXdWCxlf9nyNaj5FhH2C9/gb+kdFB3LbF/IPkQClKD0CEwBq8haNAdH7YRFI70bU2KlySfE+stjKLL8NzE4WJriHtNbodfxc/HbPXohHhsBRkkuR7lgyM0A+U0aLzyepQqNB92615qx1a7N7Hw+4pJL+B7xqbjcV2xyWvGxPvvYffD0iZxsSBAgrVocHyd/8L/ek9kOL/Bv+TMpH3S00QTfJRkJiKCrr3bPcf6YaQbmT6hI46g0gbARgBW/dyVFI1NJZ0vwDZVclWAMzpo5baL8PFAzu91UgdCtYLyeY+5ZBjbZ7IQaJiFG11584uQnhATCI59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9leQqKLxZSgq8Oyk60g0VEUUleTP6vLYvhr5mYlgkXM=;
 b=UXAFyTtBmmz+el1KqnHQYv8XkH+g+hW8aAtjaFfQsaJFDZ8AueHWSGhjzSz2UM+kjjjEIM9jLKNBn470WMOxyhahPivn978ZZWYoNfjyaGy2GwIol+OEW1O37gY/C1m5OeVfvQWgU7Nolj1DrkLeYxi+Xd9T1X3oPwRUizkAUQw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB3691.namprd12.prod.outlook.com (2603:10b6:5:1c5::30) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20; Tue, 30 Jun 2020 08:55:59 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::81eb:c31f:a63a:20eb%8]) with mapi id 15.20.3153.020; Tue, 30 Jun 2020
 08:55:58 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] Revert "drm/amdgpu: support access regs outside of mmio bar"
Date: Tue, 30 Jun 2020 16:55:41 +0800
Message-Id: <20200630085541.9048-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: HK2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:202:16::11) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-System-Product-Master.amd.com (58.247.170.242) by
 HK2PR02CA0127.apcprd02.prod.outlook.com (2603:1096:202:16::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21 via Frontend Transport; Tue, 30 Jun 2020 08:55:57 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5ddc1c2f-30ab-4e46-45b8-08d81cd36857
X-MS-TrafficTypeDiagnostic: DM6PR12MB3691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3691C7EBFF67899ABBB7B65CFC6F0@DM6PR12MB3691.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:175;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1HYyYqaWDyPm4wpX5dcDGtkA3cW8NyOiizhl5Sgsgzt6Fw48xaBVw+2qjyuGLeI02FcWWNQmV6LmgulHhF1e+wwGaGKNRqOFEAyHHK0ddW6V6smaY5sSTp6dtip3JEdvN1nuKlNIB1FkcX6J4GY6T/f99kjZoZn/LlhYOiKNYOz/oqcNAhvp4iGUHCzg/UgGbDL62Ql/U7E4CJIOkR/eB1HuZnR4psri3L/6wS2yho/m3yuvKkEAwuRYZ7gqZpFrUV1YKDES7fBxEyNnUHnxYnpU9PLdYPO2w9Fye9kGuMkhJfJ01fJtp9birPOod6mecpMgBCuxVMMiixtGGH7gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(366004)(6666004)(2616005)(86362001)(956004)(52116002)(26005)(6486002)(478600001)(186003)(1076003)(83380400001)(36756003)(7696005)(5660300002)(6916009)(4326008)(316002)(8676002)(66476007)(66556008)(2906002)(66946007)(8936002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KkhyYAwDYgeeUyy0sX6qa0LwZOpWBn2Ix7I4w6h3vbOU2FHwTv7jNnAd6w65nBuipKQ4fw7AVPQKP/u9pD++ab4QJrrw7JJYEop7VBG/eKOTpmXcZWXfGx1ycURHPCex1NWejKC1MmRLRVnAjVLE8azwUk6BsT1AB/6hs+BQirIQn+qbMLPtgHlgSnSrMp6oU5Ax2WVxB8gPkY0WPSQlYEhwDmHZTZgMT1vCc1A274BPKPTh74BJ3uW9uDizN/9vDK2PbzbQzfG5MZ5cWgSX8RaU9+E0iJyJqyUjCIwI6AeyHnoe9GpVWqR19L70RV55x3y7+DI63frfwJgMbMINl8ZnhDTuDKb19roMiMpD/yEwktjJe/kIP1sr5kmJEhqGVHxHWV8/V6jOSOCUI/P8gNA15dplRlF6SZGS40vM6Os/NDbmjbPy82BhfMgmfNECNOcb7XXf9TbmBQRjo0wE/lyX+8WwiheGT1QySrflTNDALK8vHAUHkoTXysVQyxh+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ddc1c2f-30ab-4e46-45b8-08d81cd36857
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 08:55:58.8327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57r/gVpPj1wg9SOcvFXufGONJ+UiApNfficz5HxR0iFmev219f5oSLT2jW2oP3STj5t8osapZmC+Qn/l/+hMYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3691
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

This reverts commit e318290d4845026623924a42435eafd101f669ac.
Fallback to a stable base until we have a correct new one

Signed-off-by:Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 19 ++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 45 +++++++++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  |  4 +--
 3 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 110234d..80f32b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1013,10 +1013,10 @@ int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
 
 void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 			       uint32_t *buf, size_t size, bool write);
-uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
-			    uint32_t acc_flags);
-void amdgpu_device_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
+uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
 			uint32_t acc_flags);
+void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
+		    uint32_t acc_flags);
 void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
 		    uint32_t acc_flags);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
@@ -1035,8 +1035,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
  */
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
 
-#define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
-#define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
+#define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
+#define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
 #define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
 #define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
@@ -1044,9 +1044,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define RREG8(reg) amdgpu_mm_rreg8(adev, (reg))
 #define WREG8(reg, v) amdgpu_mm_wreg8(adev, (reg), (v))
 
-#define RREG32(reg) amdgpu_device_rreg(adev, (reg), 0)
-#define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_device_rreg(adev, (reg), 0))
-#define WREG32(reg, v) amdgpu_device_wreg(adev, (reg), (v), 0)
+#define RREG32(reg) amdgpu_mm_rreg(adev, (reg), 0)
+#define DREG32(reg) printk(KERN_INFO "REGISTER: " #reg " : 0x%08X\n", amdgpu_mm_rreg(adev, (reg), 0))
+#define WREG32(reg, v) amdgpu_mm_wreg(adev, (reg), (v), 0)
 #define REG_SET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define REG_GET(FIELD, v) (((v) << FIELD##_SHIFT) & FIELD##_MASK)
 #define RREG32_PCIE(reg) adev->pcie_rreg(adev, (reg))
@@ -1084,7 +1084,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 		WREG32_PLL(reg, tmp_);				\
 	} while (0)
 
-
 #define WREG32_SMC_P(_Reg, _Val, _Mask)                         \
 	do {                                                    \
 		u32 tmp = RREG32_SMC(_Reg);                     \
@@ -1093,7 +1092,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 		WREG32_SMC(_Reg, tmp);                          \
 	} while (0)
 
-#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
+#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_mm_rreg((adev), (reg), false))
 #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
 #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a4e965..7a61085 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -301,10 +301,10 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 }
 
 /*
- * device register access helper functions.
+ * MMIO register access helper functions.
  */
 /**
- * amdgpu_device_rreg - read a register
+ * amdgpu_mm_rreg - read a memory mapped IO register
  *
  * @adev: amdgpu_device pointer
  * @reg: dword aligned register offset
@@ -312,8 +312,8 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
  *
  * Returns the 32 bit value from the offset specified.
  */
-uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
-			    uint32_t acc_flags)
+uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
+			uint32_t acc_flags)
 {
 	uint32_t ret;
 
@@ -322,9 +322,15 @@ uint32_t amdgpu_device_rreg(struct amdgpu_device *adev, uint32_t reg,
 
 	if ((reg * 4) < adev->rmmio_size)
 		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
-	else
-		ret = adev->pcie_rreg(adev, (reg * 4));
-	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
+	else {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
+		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
+		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
+		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+	}
+	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
 	return ret;
 }
 
@@ -370,19 +376,24 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 		BUG();
 }
 
-void static inline amdgpu_device_wreg_no_kiq(struct amdgpu_device *adev, uint32_t reg,
-					     uint32_t v, uint32_t acc_flags)
+void static inline amdgpu_mm_wreg_mmio(struct amdgpu_device *adev, uint32_t reg, uint32_t v, uint32_t acc_flags)
 {
-	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
+	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
 
 	if ((reg * 4) < adev->rmmio_size)
 		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
-	else
-		adev->pcie_wreg(adev, (reg * 4), v);
+	else {
+		unsigned long flags;
+
+		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
+		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
+		writel(v, ((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
+		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
+	}
 }
 
 /**
- * amdgpu_device_wreg - write to a register
+ * amdgpu_mm_wreg - write to a memory mapped IO register
  *
  * @adev: amdgpu_device pointer
  * @reg: dword aligned register offset
@@ -391,13 +402,13 @@ void static inline amdgpu_device_wreg_no_kiq(struct amdgpu_device *adev, uint32_
  *
  * Writes the value specified to the offset specified.
  */
-void amdgpu_device_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
-			uint32_t acc_flags)
+void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
+		    uint32_t acc_flags)
 {
 	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev))
 		return amdgpu_kiq_wreg(adev, reg, v);
 
-	amdgpu_device_wreg_no_kiq(adev, reg, v, acc_flags);
+	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
 }
 
 /*
@@ -416,7 +427,7 @@ void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t
 			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v);
 	}
 
-	amdgpu_device_wreg_no_kiq(adev, reg, v, acc_flags);
+	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 5da20fc..63e734a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -35,7 +35,7 @@
 #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
 	 job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)
 
-TRACE_EVENT(amdgpu_device_rreg,
+TRACE_EVENT(amdgpu_mm_rreg,
 	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
 	    TP_ARGS(did, reg, value),
 	    TP_STRUCT__entry(
@@ -54,7 +54,7 @@ TRACE_EVENT(amdgpu_device_rreg,
 		      (unsigned long)__entry->value)
 );
 
-TRACE_EVENT(amdgpu_device_wreg,
+TRACE_EVENT(amdgpu_mm_wreg,
 	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
 	    TP_ARGS(did, reg, value),
 	    TP_STRUCT__entry(
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
