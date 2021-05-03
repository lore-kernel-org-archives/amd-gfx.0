Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C386EC433B4
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:36:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E9A3613DD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 16:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E9A3613DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E02116E8FB;
	Mon,  3 May 2021 16:36:28 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9A76E8FB;
 Mon,  3 May 2021 16:36:27 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFC30613D8;
 Mon,  3 May 2021 16:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620059786;
 bh=Vd1HgjghEDtwEry470TixI2MTVg9CAJYBAjQx2k8iOI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h32bVU+4DG6RTFB87YOMZKF7Gvm0VzdQYVCcJmuj5fhGSPg6asyae5CHAhI3E99Vs
 dzBjfzjyb+KEj7u8RjfsOjsVXU5PfqfB6KqSuII9Ryi0meSNTOl5mDyqecMm5hsbX2
 HN0Neyp/7xAMaOQnFko6Vo6dhMYuCtfBen7t4N5dfICWH79ZcJyYl76qkd9pqvTNvv
 PBrKDBzatBFXCIKewWWpZ4OMNpQUKpXes0M9GVx39IBjbrnVBWucgXTH2tJbUc0dcq
 ves13YX2Sir0jP32WRbvFXVxBJmiISNnsCUT2Q59CzD6MZvDldTHtpv8FChur0Hz+0
 RDbMy8dIC47Wg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.12 047/134] drm/amdgpu: enable retry fault wptr
 overflow
Date: Mon,  3 May 2021 12:33:46 -0400
Message-Id: <20210503163513.2851510-47-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210503163513.2851510-1-sashal@kernel.org>
References: <20210503163513.2851510-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Philip Yang <Philip.Yang@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit b672cb1eee59efe6ca5bb2a2ce90060a22860558 ]

If xnack is on, VM retry fault interrupt send to IH ring1, and ring1
will be full quickly. IH cannot receive other interrupts, this causes
deadlock if migrating buffer using sdma and waiting for sdma done while
handling retry fault.

Remove VMC from IH storm client, enable ring1 write pointer overflow,
then IH will drop retry fault interrupts and be able to receive other
interrupts while driver is handling retry fault.

IH ring1 write pointer doesn't writeback to memory by IH, and ring1
write pointer recorded by self-irq is not updated, so always read
the latest ring1 write pointer from register.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 32 +++++++++-----------------
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c | 32 +++++++++-----------------
 2 files changed, 22 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 88626d83e07b..ca8efa5c6978 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -220,10 +220,8 @@ static int vega10_ih_enable_ring(struct amdgpu_device *adev,
 	tmp = vega10_ih_rb_cntl(ih, tmp);
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
-	if (ih == &adev->irq.ih1) {
-		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
+	if (ih == &adev->irq.ih1)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
-	}
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
 			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
@@ -265,7 +263,6 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 	u32 ih_chicken;
 	int ret;
 	int i;
-	u32 tmp;
 
 	/* disable irqs */
 	ret = vega10_ih_toggle_interrupts(adev, false);
@@ -291,15 +288,6 @@ static int vega10_ih_irq_init(struct amdgpu_device *adev)
 		}
 	}
 
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
-			    CLIENT18_IS_STORM_CLIENT, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL, tmp);
-
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL, tmp);
-
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
@@ -345,11 +333,17 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	wptr = le32_to_cpu(*ih->wptr_cpu);
-	ih_regs = &ih->ih_regs;
+	if (ih == &adev->irq.ih) {
+		/* Only ring0 supports writeback. On other rings fall back
+		 * to register-based code with overflow checking below.
+		 */
+		wptr = le32_to_cpu(*ih->wptr_cpu);
 
-	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
-		goto out;
+		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+			goto out;
+	}
+
+	ih_regs = &ih->ih_regs;
 
 	/* Double check that the overflow wasn't already cleared. */
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
@@ -440,15 +434,11 @@ static int vega10_ih_self_irq(struct amdgpu_device *adev,
 			      struct amdgpu_irq_src *source,
 			      struct amdgpu_iv_entry *entry)
 {
-	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
-
 	switch (entry->ring_id) {
 	case 1:
-		*adev->irq.ih1.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih1_work);
 		break;
 	case 2:
-		*adev->irq.ih2.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih2_work);
 		break;
 	default: break;
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 5a3c867d5881..75b06e1964ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -220,10 +220,8 @@ static int vega20_ih_enable_ring(struct amdgpu_device *adev,
 	tmp = vega20_ih_rb_cntl(ih, tmp);
 	if (ih == &adev->irq.ih)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RPTR_REARM, !!adev->irq.msi_enabled);
-	if (ih == &adev->irq.ih1) {
-		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_ENABLE, 0);
+	if (ih == &adev->irq.ih1)
 		tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, RB_FULL_DRAIN_ENABLE, 1);
-	}
 	if (amdgpu_sriov_vf(adev)) {
 		if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)) {
 			dev_err(adev->dev, "PSP program IH_RB_CNTL failed!\n");
@@ -297,7 +295,6 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 	u32 ih_chicken;
 	int ret;
 	int i;
-	u32 tmp;
 
 	/* disable irqs */
 	ret = vega20_ih_toggle_interrupts(adev, false);
@@ -326,15 +323,6 @@ static int vega20_ih_irq_init(struct amdgpu_device *adev)
 		}
 	}
 
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_STORM_CLIENT_LIST_CNTL,
-			    CLIENT18_IS_STORM_CLIENT, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_STORM_CLIENT_LIST_CNTL, tmp);
-
-	tmp = RREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL);
-	tmp = REG_SET_FIELD(tmp, IH_INT_FLOOD_CNTL, FLOOD_CNTL_ENABLE, 1);
-	WREG32_SOC15(OSSSYS, 0, mmIH_INT_FLOOD_CNTL, tmp);
-
 	pci_set_master(adev->pdev);
 
 	/* enable interrupts */
@@ -380,11 +368,17 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	u32 wptr, tmp;
 	struct amdgpu_ih_regs *ih_regs;
 
-	wptr = le32_to_cpu(*ih->wptr_cpu);
-	ih_regs = &ih->ih_regs;
+	if (ih == &adev->irq.ih) {
+		/* Only ring0 supports writeback. On other rings fall back
+		 * to register-based code with overflow checking below.
+		 */
+		wptr = le32_to_cpu(*ih->wptr_cpu);
 
-	if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
-		goto out;
+		if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+			goto out;
+	}
+
+	ih_regs = &ih->ih_regs;
 
 	/* Double check that the overflow wasn't already cleared. */
 	wptr = RREG32_NO_KIQ(ih_regs->ih_rb_wptr);
@@ -476,15 +470,11 @@ static int vega20_ih_self_irq(struct amdgpu_device *adev,
 			      struct amdgpu_irq_src *source,
 			      struct amdgpu_iv_entry *entry)
 {
-	uint32_t wptr = cpu_to_le32(entry->src_data[0]);
-
 	switch (entry->ring_id) {
 	case 1:
-		*adev->irq.ih1.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih1_work);
 		break;
 	case 2:
-		*adev->irq.ih2.wptr_cpu = wptr;
 		schedule_work(&adev->irq.ih2_work);
 		break;
 	default: break;
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
