Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFA9C43332
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A70F20752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 22:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kjeGhoRC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A70F20752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A590C6E982;
	Wed, 18 Mar 2020 22:52:23 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690072.outbound.protection.outlook.com [40.107.69.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F2F66E97F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 22:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu7Tj7E6BXc6xyb69Q9HSDP4A9nc5TgbkeJzS+PK+88Z07FDo3YhvYCs/nCoyc+VLI87vQ9OMT+KJ/Uhd285iicbZxGISBv3ZajQnZKgdLI2UWic/ji+C3w81PLjjGYBajS15M4Ib/Yh10dG7AFCOUoov8jNYgx9AweYEADWNwwXCd3cKv58m5hBI5QTZQOWkLwj5vEDYrONoJ79KH/uUiNRQFsvIeLtX1bK7Yi+z0lA9j5PI9tXL4QOqFgZ6iqfjs/brs+XgCM2rYSYCr+LWfHJYsN7S3poN2Nz2zduHQgTRL97RA2KgrLsIkzf94F0ZLNyBSk4YKKhn6AG3yDjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nmotxlbZQe59ED0G57xjOgJiBLzDWZv8nHwunTyuQs=;
 b=mneohQV4pCeB4z2onj1JLFK2Err6JazrHgGY6vrsJBkBF3nTT45rMlGzkqqVDT37xaI9RrMyMF1hPEIBr9iA8LcLs3cEN7/rfukujFgd4pMpQtdJDYnqw12G4lM5Ab/qsi4x4eqSADqd6MZ7lzOxsh4ipDXYP7cDeMrNho9jQB6KREFebJ5hb/C1r3SSqnteGd34OtMrZ20GuG3jnOoUH5sITyhkq1fuUdibLArrhIoj/1iWLxIsQ9PaKG5b6Aab6gcL6CxYAhiEAFq5cdVNiwz1u55g9OGHXl/KWpZDreJLmkioCO3dT2PMdzVCSfasWr56DaNQ9aES+mGXihxiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nmotxlbZQe59ED0G57xjOgJiBLzDWZv8nHwunTyuQs=;
 b=kjeGhoRCMTAV3FmJA8h/Am/Nwrz98YM9P+QrbAzZ1ePU6H/CiCXptTf3HAKnZ8l4VKwgcgrK+XUXgu3M/i+AtRs2uSK+ERrhLlb1wWjHvvKwWuBlHHRVTe6bzsQTnuvxrJt9iif9V5Hny14XQFo0uMB1tYnzfwxroOVYqwRUz44=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SA0PR12MB4576.namprd12.prod.outlook.com (2603:10b6:806:93::13)
 by SA0PR12MB4415.namprd12.prod.outlook.com (2603:10b6:806:70::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.16; Wed, 18 Mar
 2020 22:52:21 +0000
Received: from SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047]) by SA0PR12MB4576.namprd12.prod.outlook.com
 ([fe80::8d47:3ca5:5a7c:c047%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 22:52:21 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: replace function prefix names
Date: Wed, 18 Mar 2020 17:51:14 -0500
Message-Id: <20200318225118.10756-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318225118.10756-1-alex.sierra@amd.com>
References: <20200318225118.10756-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0076.namprd05.prod.outlook.com
 (2603:10b6:803:22::14) To SA0PR12MB4576.namprd12.prod.outlook.com
 (2603:10b6:806:93::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN4PR0501CA0076.namprd05.prod.outlook.com (2603:10b6:803:22::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.11 via Frontend
 Transport; Wed, 18 Mar 2020 22:52:21 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 19c8656e-a023-4ea9-727f-08d7cb8f0497
X-MS-TrafficTypeDiagnostic: SA0PR12MB4415:|SA0PR12MB4415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB441588FE96EEDC1913ADE9F2FDF70@SA0PR12MB4415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(199004)(66476007)(66556008)(6486002)(81166006)(8676002)(44832011)(316002)(81156014)(956004)(2616005)(16526019)(26005)(186003)(8936002)(52116002)(86362001)(7696005)(66946007)(30864003)(478600001)(2906002)(6916009)(1076003)(4326008)(6666004)(36756003)(5660300002)(309714004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SA0PR12MB4415;
 H:SA0PR12MB4576.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fL2JoWHfBPUsCO77v301hDA9ZL8XX3a7UsFlBM7jPwCeLjQBI1RbOR7hPgp+C29bv3WjYVibZQHhgIyrBx+PyjpqgSCkGlWIjWpFgkaWrToMbWzT8ceKMaSZCmNVnsLzneJU98ZPDXFhQrySIL7eGAZ4mYS+syWQKClbrJ33MX5XxdwIDnGl7RV8KvZqrhNQFaErqg0r0uybJK1knV/zDqlHz+DzkkURQQY1pQ/7hjKmkvgiW/V1vK4emaJgrF7cqfSmbB82tQF5YWzCcVRueKsKGh/S4iuSxqyK5TAhKBLEXNBwzcGrmix146uFvV/zgmW1pKh5souKV4PLJdjReU4Xld3e7rxgMRcYKd62cwjUgZQlkkhrTJBgyt07C7ebhZA7g0fkKWDrn49TEscj4OSVH0rMBtnNsFL+lMTR+DWVMrG1BgL0evLT6yvN/Opd0AOb5nhUJiMzv0qnG1tcoKLEbxrkXMkDatG0DHxGHUNETE/HllXjag1GaSql1pv
X-MS-Exchange-AntiSpam-MessageData: 3bUe06rmrdo7/lLf2YKrGH1+uDuyVXCizIEDF9ZODU0D/zrN68wJiE/8f665z89i6uSuKouuGoP5+s1XWOtKyc4WbMzRhHgzZRA/bYb7CqXWIsWer0Cc7ncfHlCPYvaq4vXdn2gn2BshFWJuBMBT8w==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c8656e-a023-4ea9-727f-08d7cb8f0497
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 22:52:21.5374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXf2/4RP2tyoMBE9myPRQnhnWUx5ztsKXcZebEtapj2stR+wCrGK1TjjX2VQSzu6J+D7k/4fW+22gsGk44JPow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4415
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace function prefix name from vega10 to arcturus

Change-Id: Ic21713f2dda30a0bc28c7b525e20d5f1fcde96dd
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/arcturus_ih.c | 162 +++++++++++------------
 drivers/gpu/drm/amd/amdgpu/arcturus_ih.h |   8 +-
 2 files changed, 85 insertions(+), 85 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
index b8cd5c3c8a36..b687fcc4c9b6 100644
--- a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.c
@@ -35,16 +35,16 @@
 
 #define MAX_REARM_RETRY 10
 
-static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev);
+static void arcturus_ih_set_interrupt_funcs(struct amdgpu_device *adev);
 
 /**
- * vega10_ih_enable_interrupts - Enable the interrupt ring buffer
+ * arcturus_ih_enable_interrupts - Enable the interrupt ring buffer
  *
  * @adev: amdgpu_device pointer
  *
- * Enable the interrupt ring buffer (VEGA10).
+ * Enable the interrupt ring buffer (ARCTURUS).
  */
-static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
+static void arcturus_ih_enable_interrupts(struct amdgpu_device *adev)
 {
 	u32 ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
 
@@ -94,13 +94,13 @@ static void vega10_ih_enable_interrupts(struct amdgpu_device *adev)
 }
 
 /**
- * vega10_ih_disable_interrupts - Disable the interrupt ring buffer
+ * arcturus_ih_disable_interrupts - Disable the interrupt ring buffer
  *
  * @adev: amdgpu_device pointer
  *
- * Disable the interrupt ring buffer (VEGA10).
+ * Disable the interrupt ring buffer (ARCTURUS).
  */
-static void vega10_ih_disable_interrupts(struct amdgpu_device *adev)
+static void arcturus_ih_disable_interrupts(struct amdgpu_device *adev)
 {
 	u32 ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
 
@@ -163,7 +163,7 @@ static void vega10_ih_disable_interrupts(struct amdgpu_device *adev)
 	}
 }
 
-static uint32_t vega10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl)
+static uint32_t arcturus_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl)
 {
 	int rb_bufsz = order_base_2(ih->ring_size / 4);
 
@@ -186,7 +186,7 @@ static uint32_t vega10_ih_rb_cntl(struct amdgpu_ih_ring *ih, uint32_t ih_rb_cntl
 	return ih_rb_cntl;
 }
 
-static uint32_t vega10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
+static uint32_t arcturus_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
 {
 	u32 ih_doorbell_rtpr = 0;
 
@@ -206,7 +206,7 @@ static uint32_t vega10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
 }
 
 /**
- * vega10_ih_irq_init - init and enable the interrupt ring
+ * arcturus_ih_irq_init - init and enable the interrupt ring
  *
  * @adev: amdgpu_device pointer
  *
@@ -216,7 +216,7 @@ static uint32_t vega10_ih_doorbell_rptr(struct amdgpu_ih_ring *ih)
  * Called at device load and reume.
  * Returns 0 for success, errors for failure.
  */
-static int vega10_ih_irq_init(struct amdgpu_device *adev)
+static int arcturus_ih_irq_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ih_ring *ih;
 	u32 ih_rb_cntl, ih_chicken;
@@ -224,7 +224,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	u32 tmp;
 
 	/* disable irqs */
-	vega10_ih_disable_interrupts(adev);
+	arcturus_ih_disable_interrupts(adev);
 
 	adev->nbio.funcs->ih_control(adev);
 
@@ -234,7 +234,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_BASE_HI, (ih->gpu_addr >> 40) & 0xff);
 
 	ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL);
-	ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
+	ih_rb_cntl = arcturus_ih_rb_cntl(ih, ih_rb_cntl);
 	ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL, RPTR_REARM,
 				   !!adev->irq.msi_enabled);
 	if (amdgpu_sriov_vf(adev)) {
@@ -269,7 +269,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, 0);
 
 	WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR,
-		     vega10_ih_doorbell_rptr(ih));
+		     arcturus_ih_doorbell_rptr(ih));
 
 	ih = &adev->irq.ih1;
 	if (ih->ring_size) {
@@ -278,7 +278,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 			     (ih->gpu_addr >> 40) & 0xff);
 
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING1);
-		ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
+		ih_rb_cntl = arcturus_ih_rb_cntl(ih, ih_rb_cntl);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
 					   WPTR_OVERFLOW_ENABLE, 0);
 		ih_rb_cntl = REG_SET_FIELD(ih_rb_cntl, IH_RB_CNTL,
@@ -298,7 +298,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING1, 0);
 
 		WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING1,
-			     vega10_ih_doorbell_rptr(ih));
+			     arcturus_ih_doorbell_rptr(ih));
 	}
 
 	ih = &adev->irq.ih2;
@@ -308,7 +308,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 			     (ih->gpu_addr >> 40) & 0xff);
 
 		ih_rb_cntl = RREG32_SOC15(OSSSYS, 0, mmIH_RB_CNTL_RING2);
-		ih_rb_cntl = vega10_ih_rb_cntl(ih, ih_rb_cntl);
+		ih_rb_cntl = arcturus_ih_rb_cntl(ih, ih_rb_cntl);
 
 		if (amdgpu_sriov_vf(adev)) {
 			if (psp_reg_program(&adev->psp, PSP_REG_IH_RB_CNTL_RING2,
@@ -325,7 +325,7 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR_RING2, 0);
 
 		WREG32_SOC15(OSSSYS, 0, mmIH_DOORBELL_RPTR_RING2,
-			     vega10_ih_doorbell_rptr(ih));
+			     arcturus_ih_doorbell_rptr(ih));
 	}
 
 	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
@@ -340,37 +340,37 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
-	vega10_ih_enable_interrupts(adev);
+	arcturus_ih_enable_interrupts(adev);
 
 	return ret;
 }
 
 /**
- * vega10_ih_irq_disable - disable interrupts
+ * arcturus_ih_irq_disable - disable interrupts
  *
  * @adev: amdgpu_device pointer
  *
- * Disable interrupts on the hw (VEGA10).
+ * Disable interrupts on the hw (ARCTURUS).
  */
-static void vega10_ih_irq_disable(struct amdgpu_device *adev)
+static void arcturus_ih_irq_disable(struct amdgpu_device *adev)
 {
-	vega10_ih_disable_interrupts(adev);
+	arcturus_ih_disable_interrupts(adev);
 
 	/* Wait and acknowledge irq */
 	mdelay(1);
 }
 
 /**
- * vega10_ih_get_wptr - get the IH ring buffer wptr
+ * arcturus_ih_get_wptr - get the IH ring buffer wptr
  *
  * @adev: amdgpu_device pointer
  *
  * Get the IH ring buffer wptr from either the register
- * or the writeback memory buffer (VEGA10).  Also check for
+ * or the writeback memory buffer (ARCTURUS).  Also check for
  * ring buffer overflow and deal with it.
  * Returns the value of the wptr.
  */
-static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
+static u32 arcturus_ih_get_wptr(struct amdgpu_device *adev,
 			      struct amdgpu_ih_ring *ih)
 {
 	u32 wptr, reg, tmp;
@@ -425,14 +425,14 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 }
 
 /**
- * vega10_ih_decode_iv - decode an interrupt vector
+ * arcturus_ih_decode_iv - decode an interrupt vector
  *
  * @adev: amdgpu_device pointer
  *
  * Decodes the interrupt vector at the current rptr
  * position and also advance the position.
  */
-static void vega10_ih_decode_iv(struct amdgpu_device *adev,
+static void arcturus_ih_decode_iv(struct amdgpu_device *adev,
 				struct amdgpu_ih_ring *ih,
 				struct amdgpu_iv_entry *entry)
 {
@@ -468,12 +468,12 @@ static void vega10_ih_decode_iv(struct amdgpu_device *adev,
 }
 
 /**
- * vega10_ih_irq_rearm - rearm IRQ if lost
+ * arcturus_ih_irq_rearm - rearm IRQ if lost
  *
  * @adev: amdgpu_device pointer
  *
  */
-static void vega10_ih_irq_rearm(struct amdgpu_device *adev,
+static void arcturus_ih_irq_rearm(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
 {
 	uint32_t reg_rptr = 0;
@@ -500,13 +500,13 @@ static void vega10_ih_irq_rearm(struct amdgpu_device *adev,
 }
 
 /**
- * vega10_ih_set_rptr - set the IH ring buffer rptr
+ * arcturus_ih_set_rptr - set the IH ring buffer rptr
  *
  * @adev: amdgpu_device pointer
  *
  * Set the IH ring buffer rptr.
  */
-static void vega10_ih_set_rptr(struct amdgpu_device *adev,
+static void arcturus_ih_set_rptr(struct amdgpu_device *adev,
 			       struct amdgpu_ih_ring *ih)
 {
 	if (ih->use_doorbell) {
@@ -515,7 +515,7 @@ static void vega10_ih_set_rptr(struct amdgpu_device *adev,
 		WDOORBELL32(ih->doorbell_index, ih->rptr);
 
 		if (amdgpu_sriov_vf(adev))
-			vega10_ih_irq_rearm(adev, ih);
+			arcturus_ih_irq_rearm(adev, ih);
 	} else if (ih == &adev->irq.ih) {
 		WREG32_SOC15(OSSSYS, 0, mmIH_RB_RPTR, ih->rptr);
 	} else if (ih == &adev->irq.ih1) {
@@ -526,7 +526,7 @@ static void vega10_ih_set_rptr(struct amdgpu_device *adev,
 }
 
 /**
- * vega10_ih_self_irq - dispatch work for ring 1 and 2
+ * arcturus_ih_self_irq - dispatch work for ring 1 and 2
  *
  * @adev: amdgpu_device pointer
  * @source: irq source
@@ -534,7 +534,7 @@ static void vega10_ih_set_rptr(struct amdgpu_device *adev,
  *
  * Update the WPTR from the IV and schedule work to handle the entries.
  */
-static int vega10_ih_self_irq(struct amdgpu_device *adev,
+static int arcturus_ih_self_irq(struct amdgpu_device *adev,
 			      struct amdgpu_irq_src *source,
 			      struct amdgpu_iv_entry *entry)
 {
@@ -555,26 +555,26 @@ static int vega10_ih_self_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static const struct amdgpu_irq_src_funcs vega10_ih_self_irq_funcs = {
-	.process = vega10_ih_self_irq,
+static const struct amdgpu_irq_src_funcs arcturus_ih_self_irq_funcs = {
+	.process = arcturus_ih_self_irq,
 };
 
-static void vega10_ih_set_self_irq_funcs(struct amdgpu_device *adev)
+static void arcturus_ih_set_self_irq_funcs(struct amdgpu_device *adev)
 {
 	adev->irq.self_irq.num_types = 0;
-	adev->irq.self_irq.funcs = &vega10_ih_self_irq_funcs;
+	adev->irq.self_irq.funcs = &arcturus_ih_self_irq_funcs;
 }
 
-static int vega10_ih_early_init(void *handle)
+static int arcturus_ih_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	vega10_ih_set_interrupt_funcs(adev);
-	vega10_ih_set_self_irq_funcs(adev);
+	arcturus_ih_set_interrupt_funcs(adev);
+	arcturus_ih_set_self_irq_funcs(adev);
 	return 0;
 }
 
-static int vega10_ih_sw_init(void *handle)
+static int arcturus_ih_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 	int r;
@@ -610,7 +610,7 @@ static int vega10_ih_sw_init(void *handle)
 	return r;
 }
 
-static int vega10_ih_sw_fini(void *handle)
+static int arcturus_ih_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -622,61 +622,61 @@ static int vega10_ih_sw_fini(void *handle)
 	return 0;
 }
 
-static int vega10_ih_hw_init(void *handle)
+static int arcturus_ih_hw_init(void *handle)
 {
 	int r;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	r = vega10_ih_irq_init(adev);
+	r = arcturus_ih_irq_init(adev);
 	if (r)
 		return r;
 
 	return 0;
 }
 
-static int vega10_ih_hw_fini(void *handle)
+static int arcturus_ih_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	vega10_ih_irq_disable(adev);
+	arcturus_ih_irq_disable(adev);
 
 	return 0;
 }
 
-static int vega10_ih_suspend(void *handle)
+static int arcturus_ih_suspend(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	return vega10_ih_hw_fini(adev);
+	return arcturus_ih_hw_fini(adev);
 }
 
-static int vega10_ih_resume(void *handle)
+static int arcturus_ih_resume(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	return vega10_ih_hw_init(adev);
+	return arcturus_ih_hw_init(adev);
 }
 
-static bool vega10_ih_is_idle(void *handle)
+static bool arcturus_ih_is_idle(void *handle)
 {
 	/* todo */
 	return true;
 }
 
-static int vega10_ih_wait_for_idle(void *handle)
+static int arcturus_ih_wait_for_idle(void *handle)
 {
 	/* todo */
 	return -ETIMEDOUT;
 }
 
-static int vega10_ih_soft_reset(void *handle)
+static int arcturus_ih_soft_reset(void *handle)
 {
 	/* todo */
 
 	return 0;
 }
 
-static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
+static void arcturus_ih_update_clockgating_state(struct amdgpu_device *adev,
 					       bool enable)
 {
 	uint32_t data, def, field_val;
@@ -703,55 +703,55 @@ static void vega10_ih_update_clockgating_state(struct amdgpu_device *adev,
 	}
 }
 
-static int vega10_ih_set_clockgating_state(void *handle,
+static int arcturus_ih_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	vega10_ih_update_clockgating_state(adev,
+	arcturus_ih_update_clockgating_state(adev,
 				state == AMD_CG_STATE_GATE);
 	return 0;
 
 }
 
-static int vega10_ih_set_powergating_state(void *handle,
+static int arcturus_ih_set_powergating_state(void *handle,
 					  enum amd_powergating_state state)
 {
 	return 0;
 }
 
-const struct amd_ip_funcs vega10_ih_ip_funcs = {
-	.name = "vega10_ih",
-	.early_init = vega10_ih_early_init,
+const struct amd_ip_funcs arcturus_ih_ip_funcs = {
+	.name = "arcturus_ih",
+	.early_init = arcturus_ih_early_init,
 	.late_init = NULL,
-	.sw_init = vega10_ih_sw_init,
-	.sw_fini = vega10_ih_sw_fini,
-	.hw_init = vega10_ih_hw_init,
-	.hw_fini = vega10_ih_hw_fini,
-	.suspend = vega10_ih_suspend,
-	.resume = vega10_ih_resume,
-	.is_idle = vega10_ih_is_idle,
-	.wait_for_idle = vega10_ih_wait_for_idle,
-	.soft_reset = vega10_ih_soft_reset,
-	.set_clockgating_state = vega10_ih_set_clockgating_state,
-	.set_powergating_state = vega10_ih_set_powergating_state,
+	.sw_init = arcturus_ih_sw_init,
+	.sw_fini = arcturus_ih_sw_fini,
+	.hw_init = arcturus_ih_hw_init,
+	.hw_fini = arcturus_ih_hw_fini,
+	.suspend = arcturus_ih_suspend,
+	.resume = arcturus_ih_resume,
+	.is_idle = arcturus_ih_is_idle,
+	.wait_for_idle = arcturus_ih_wait_for_idle,
+	.soft_reset = arcturus_ih_soft_reset,
+	.set_clockgating_state = arcturus_ih_set_clockgating_state,
+	.set_powergating_state = arcturus_ih_set_powergating_state,
 };
 
-static const struct amdgpu_ih_funcs vega10_ih_funcs = {
-	.get_wptr = vega10_ih_get_wptr,
-	.decode_iv = vega10_ih_decode_iv,
-	.set_rptr = vega10_ih_set_rptr
+static const struct amdgpu_ih_funcs arcturus_ih_funcs = {
+	.get_wptr = arcturus_ih_get_wptr,
+	.decode_iv = arcturus_ih_decode_iv,
+	.set_rptr = arcturus_ih_set_rptr
 };
 
-static void vega10_ih_set_interrupt_funcs(struct amdgpu_device *adev)
+static void arcturus_ih_set_interrupt_funcs(struct amdgpu_device *adev)
 {
-	adev->irq.ih_funcs = &vega10_ih_funcs;
+	adev->irq.ih_funcs = &arcturus_ih_funcs;
 }
 
-const struct amdgpu_ip_block_version vega10_ih_ip_block = {
+const struct amdgpu_ip_block_version arcturus_ih_ip_block = {
 	.type = AMD_IP_BLOCK_TYPE_IH,
 	.major = 4,
 	.minor = 0,
 	.rev = 0,
-	.funcs = &vega10_ih_ip_funcs,
+	.funcs = &arcturus_ih_ip_funcs,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h
index 54daf8cf6ff3..56da58ac0e97 100644
--- a/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/arcturus_ih.h
@@ -21,10 +21,10 @@
  *
  */
 
-#ifndef __VEGA10_IH_H__
-#define __VEGA10_IH_H__
+#ifndef __ARCTURUS_IH_H__
+#define __ARCTURUS_IH_H__
 
-extern const struct amd_ip_funcs vega10_ih_ip_funcs;
-extern const struct amdgpu_ip_block_version vega10_ih_ip_block;
+extern const struct amd_ip_funcs arcturus_ih_ip_funcs;
+extern const struct amdgpu_ip_block_version arcturus_ih_ip_block;
 
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
