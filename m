Return-Path: <SRS0=nko/=C3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC5FC43464
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 09:52:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 452F221D42
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2020 09:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jgrxpRWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 452F221D42
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2A9F6ECB7;
	Fri, 18 Sep 2020 09:52:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE7F56ECB7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2020 09:52:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRSn8OUb7JxmtIoKvrVD+IcwgKIvQSj6BcMrDqlsPCYR5/cN6j7ZpnRgsen/F5oehVg9OQ6qjAgkW9bwh1fArgnrhRChJRHJg2bMX/OD3XaCIIKc5KHmQIOQeagQ3Wj6bVvbybXQFQCRKOKdmUla6nbDq9DAsjmK1lLihU0aeDsDtWoyzTGM3I9MV2zgw0H8H+ZEoI5P3ZrEhI64weibOlweNhB2+TsaoQ9u89un+jTy4MzRD+XHzDbybahr3lTc1usssl7lnWefRzNOU54AU+dbTC2mCerjZMv6e8zyLoe2MfSSsDtMYSaIBZIJIeBMSQH21xgpv14rMF7Jo2Ogsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UubC9TluQsxziocUG9r4U9U6ZonUoEDekOaYlmatbw=;
 b=JO4/ouJHnQ31f0eGcUsALaNddH/y0HpTV4h9Uy4VMctrw/L1hqsm1lqhQR+Wjqbudr79MEtO0vDldrf2AkUmvYMYkyMjVMxBGwHc/FVOolWqTAPewZI5o94cLP1TD7x6qa+ba3FqurNetO1vGIbrOnmV1NLDtWGO/MfXNn4Vo9Ms2p6/fkwgAIvu+zozk0YlJZFYHASOx8CQB7M+F0Jh8Z9lVTN5pt86bPcXK8ZGjWMIrLFhPVdu4j5SfyUFeivGg6pK+r2y0qPTOt009kxYlYBv2eYQRXyYR36KPcPuptXvVa/DUYlMdb9k7l+2F+qHLN389MHqf9Hgfd6JSft9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UubC9TluQsxziocUG9r4U9U6ZonUoEDekOaYlmatbw=;
 b=jgrxpRWgLcfpjFttJ/2MQJWIHr2uQYVNrnEqggbCBjGbf1+bPlfnb8aP635+NNi2noELkLn/zN/nHMmznBDp+MZaergRWt9HAqWxyP1ArnXK3ihyjgE+d9prvracq5MXEvfXS8MWcwcKgtEhHejK4wtAU/p0StarYgU2Fk2V99c=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4075.namprd12.prod.outlook.com (2603:10b6:5:21d::8) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.19; Fri, 18 Sep 2020 09:52:18 +0000
Received: from DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233]) by DM6PR12MB4075.namprd12.prod.outlook.com
 ([fe80::b51c:2b0e:7e1:b233%9]) with mapi id 15.20.3391.014; Fri, 18 Sep 2020
 09:52:18 +0000
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Kevin Wang <kevin1.wang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: support indirect access reg outside of mmio
 bar (v2)
Date: Fri, 18 Sep 2020 17:51:50 +0800
Message-Id: <1600422710-27228-3-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600422710-27228-1-git-send-email-Hawking.Zhang@amd.com>
References: <1600422710-27228-1-git-send-email-Hawking.Zhang@amd.com>
X-ClientProxiedBy: HK2PR04CA0085.apcprd04.prod.outlook.com
 (2603:1096:202:15::29) To DM6PR12MB4075.namprd12.prod.outlook.com
 (2603:10b6:5:21d::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hawzhang-All-Series.amd.com (58.247.170.242) by
 HK2PR04CA0085.apcprd04.prod.outlook.com (2603:1096:202:15::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3391.13 via Frontend Transport; Fri, 18 Sep 2020 09:52:16 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b6363cd7-4b83-46f1-7cd0-08d85bb887af
X-MS-TrafficTypeDiagnostic: DM6PR12MB4297:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4297FC79BB3FA31050127F4CFC3F0@DM6PR12MB4297.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0ayktI3YffJh6j/GPzKiVznSsaKFUWiHuzlSad/7KfVDx2gbbhUoZKTwApTRDL3pqJ3DOnVigoBbQBOcBTxlUvhxiOqqOcLcPTIHsI1OT62PHAOAt16hWy7JpFz6EUo7ESBvFx4RmWHUqfadTic0xUpE/ei6tN+yCckPkPv85pfRA+RVZ+E02M2xs7j8zlUAecCrCyluol4QmhplHzn+DhWm59gBL4d1mr7TKgxawRg/Wrrr1+3s0P4U1vqhN9spqC+oFgvQ2ykReZXQ3pqkgboXI7dSFGXk1GrNGtmJfKGuiVoNw+PDDtKNsqwtox1tJIJaprMFE/EORd08wYInMBfK+3p/FYiNgaqCVSU6f1+zDAVJM1414933GM7r4Y3
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4075.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(110136005)(66946007)(6486002)(5660300002)(16526019)(36756003)(4326008)(6636002)(478600001)(83380400001)(316002)(8676002)(52116002)(7696005)(86362001)(956004)(2906002)(186003)(6666004)(8936002)(66556008)(26005)(66476007)(2616005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zJYSAn0tUpOo614OyFX7V4elRTrsNrTYqe3wdRFJe2q6LZzqavbQTCUJvrmsLXiJgnKqJrVO29ks74px7e5QX/++XOfxP3bV9qWf7bqj37b+KZjMQUOt7r3bnGlcl0VBbo4/6Kdn6aknpVasqUHlt9h66F6kppAgRhCAzPWE/s8Mk7Q9NySSGPQnxSq2qPixWhhapkhnv/UVHb8cuR3N1muxH0Ywc1CVis6Cw10IDA1eNXSKbsGpVEzhJF0JE7XaO5WUpJ9+FuVXmwnMSo+2avXHwxFLXYsomihYeU4FcFpbOyRtiK0VIUaaEBxzRaA4L7OdRHpk85dL7gEYCTF7SNoXniHYtkXrNzOGZC1/XtoUVBDNs4jgvLuIMXJUaFkqe4RAopHY9uBnpCYpXljRc3nR9ynejQtUFwx+mjIQpUXDjxxFthpZIIrRygWW5Qil6aasQYanTuC4LyxSJNDF6jIRFfCfpfUpEpHt2aiR3jVzqtZ3I5f4VmQYPZr5OIAcQ42fHr5ZON/uOpSCTcIwGoFFF1AgugCnGulFXTH5aiglHIDaU7WXwblHTnI2YzXgJMQX0UlBkTS7ZpV9e/4CoAkdkiiaC59hmWu9mjgSM9V5KPgvfjqDkea9/itwCVxz7C1gD1tRzjertq7x6cgVjA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6363cd7-4b83-46f1-7cd0-08d85bb887af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2020 09:52:18.4735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCz8FTaLisUvDArn9txX5NLqruPMySkZ+aSZfTszyzIPVw5QnJLQ6ETbfcZQO14HikLRSWg5cAJj+004JbDwdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297
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

support both direct and indirect accessor in unified
helper functions.

v2: Retire indirect mmio access via mm_index/data

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         | 23 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 96 +++++++++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   |  4 +-
 4 files changed, 51 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 40ee44b..50341f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,12 +1019,13 @@ int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
 
 void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 			       uint32_t *buf, size_t size, bool write);
-uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
+uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
+			    uint32_t reg, uint32_t acc_flags);
+void amdgpu_device_wreg(struct amdgpu_device *adev,
+			uint32_t reg, uint32_t v,
 			uint32_t acc_flags);
-void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
-		    uint32_t acc_flags);
-void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
-		    uint32_t acc_flags);
+void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
+			     uint32_t reg, uint32_t v);
 void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value);
 uint8_t amdgpu_mm_rreg8(struct amdgpu_device *adev, uint32_t offset);
 
@@ -1054,8 +1055,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
  */
 #define AMDGPU_REGS_NO_KIQ    (1<<1)
 
-#define RREG32_NO_KIQ(reg) amdgpu_mm_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
-#define WREG32_NO_KIQ(reg, v) amdgpu_mm_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
+#define RREG32_NO_KIQ(reg) amdgpu_device_rreg(adev, (reg), AMDGPU_REGS_NO_KIQ)
+#define WREG32_NO_KIQ(reg, v) amdgpu_device_wreg(adev, (reg), (v), AMDGPU_REGS_NO_KIQ)
 
 #define RREG32_KIQ(reg) amdgpu_kiq_rreg(adev, (reg))
 #define WREG32_KIQ(reg, v) amdgpu_kiq_wreg(adev, (reg), (v))
@@ -1063,9 +1064,9 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
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
@@ -1111,7 +1112,7 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 		WREG32_SMC(_Reg, tmp);                          \
 	} while (0)
 
-#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_mm_rreg((adev), (reg), false))
+#define DREG32_SYS(sqf, adev, reg) seq_printf((sqf), #reg " : 0x%08X\n", amdgpu_device_rreg((adev), (reg), false))
 #define RREG32_IO(reg) amdgpu_io_rreg(adev, (reg))
 #define WREG32_IO(reg, v) amdgpu_io_wreg(adev, (reg), (v))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index abe0c27..2d125b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -267,7 +267,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
 		} else {
 			r = get_user(value, (uint32_t *)buf);
 			if (!r)
-				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value, 0);
+				amdgpu_mm_wreg_mmio_rlc(adev, *pos >> 2, value);
 		}
 		if (r) {
 			result = r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 77785b2..beef764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -303,10 +303,10 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
 }
 
 /*
- * MMIO register access helper functions.
+ * register access helper functions.
  */
 /**
- * amdgpu_mm_rreg - read a memory mapped IO register
+ * amdgpu_device_rreg - read a memory mapped IO or indirect register
  *
  * @adev: amdgpu_device pointer
  * @reg: dword aligned register offset
@@ -314,33 +314,27 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
  *
  * Returns the 32 bit value from the offset specified.
  */
-uint32_t amdgpu_mm_rreg(struct amdgpu_device *adev, uint32_t reg,
-			uint32_t acc_flags)
+uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
+			    uint32_t reg, uint32_t acc_flags)
 {
 	uint32_t ret;
 
 	if (adev->in_pci_err_recovery)
 		return 0;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev) &&
-	    down_read_trylock(&adev->reset_sem)) {
-		ret = amdgpu_kiq_rreg(adev, reg);
-		up_read(&adev->reset_sem);
-		return ret;
-	}
-
-	if ((reg * 4) < adev->rmmio_size)
-		ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
-	else {
-		unsigned long flags;
+	if ((reg * 4) < adev->rmmio_size) {
+		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		    amdgpu_sriov_runtime(adev) &&
+		    down_read_trylock(&adev->reset_sem)) {
+			ret = amdgpu_kiq_rreg(adev, reg);
+			up_read(&adev->reset_sem);
+		} else
+			ret = readl(((void __iomem *)adev->rmmio) + (reg * 4));
+	} else
+		ret = adev->pcie_rreg(adev, reg * 4);
 
-		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
-		ret = readl(((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
-		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
-	}
+	trace_amdgpu_device_rreg(adev->pdev->device, reg, ret);
 
-	trace_amdgpu_mm_rreg(adev->pdev->device, reg, ret);
 	return ret;
 }
 
@@ -394,29 +388,8 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
 		BUG();
 }
 
-static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,
-				       uint32_t reg, uint32_t v,
-				       uint32_t acc_flags)
-{
-	if (adev->in_pci_err_recovery)
-		return;
-
-	trace_amdgpu_mm_wreg(adev->pdev->device, reg, v);
-
-	if ((reg * 4) < adev->rmmio_size)
-		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
-	else {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->mmio_idx_lock, flags);
-		writel((reg * 4), ((void __iomem *)adev->rmmio) + (mmMM_INDEX * 4));
-		writel(v, ((void __iomem *)adev->rmmio) + (mmMM_DATA * 4));
-		spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
-	}
-}
-
 /**
- * amdgpu_mm_wreg - write to a memory mapped IO register
+ * amdgpu_device_wreg - write to a memory mapped IO or indirect register
  *
  * @adev: amdgpu_device pointer
  * @reg: dword aligned register offset
@@ -425,20 +398,25 @@ static inline void amdgpu_mm_wreg_mmio(struct amdgpu_device *adev,
  *
  * Writes the value specified to the offset specified.
  */
-void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
-		    uint32_t acc_flags)
+void amdgpu_device_wreg(struct amdgpu_device *adev,
+			uint32_t reg, uint32_t v,
+			uint32_t acc_flags)
 {
 	if (adev->in_pci_err_recovery)
 		return;
 
-	if (!(acc_flags & AMDGPU_REGS_NO_KIQ) && amdgpu_sriov_runtime(adev) &&
-	    down_read_trylock(&adev->reset_sem)) {
-		amdgpu_kiq_wreg(adev, reg, v);
-		up_read(&adev->reset_sem);
-		return;
-	}
+	if ((reg * 4) < adev->rmmio_size) {
+		if (!(acc_flags & AMDGPU_REGS_NO_KIQ) &&
+		    amdgpu_sriov_runtime(adev) &&
+		    down_read_trylock(&adev->reset_sem)) {
+			amdgpu_kiq_wreg(adev, reg, v);
+			up_read(&adev->reset_sem);
+		} else
+			writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
+	} else
+		adev->pcie_wreg(adev, reg * 4, v);
 
-	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
+	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);
 }
 
 /*
@@ -446,21 +424,19 @@ void amdgpu_mm_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
  *
  * this function is invoked only the debugfs register access
  * */
-void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev, uint32_t reg, uint32_t v,
-		    uint32_t acc_flags)
+void amdgpu_mm_wreg_mmio_rlc(struct amdgpu_device *adev,
+			     uint32_t reg, uint32_t v)
 {
 	if (adev->in_pci_err_recovery)
 		return;
 
 	if (amdgpu_sriov_fullaccess(adev) &&
-		adev->gfx.rlc.funcs &&
-		adev->gfx.rlc.funcs->is_rlcg_access_range) {
-
+	    adev->gfx.rlc.funcs &&
+	    adev->gfx.rlc.funcs->is_rlcg_access_range) {
 		if (adev->gfx.rlc.funcs->is_rlcg_access_range(adev, reg))
 			return adev->gfx.rlc.funcs->rlcg_wreg(adev, reg, v);
-	}
-
-	amdgpu_mm_wreg_mmio(adev, reg, v, acc_flags);
+	} else
+		writel(v, ((void __iomem *)adev->rmmio) + (reg * 4));
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
