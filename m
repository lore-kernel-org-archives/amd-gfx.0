Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DABC47095
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0BA4613F4
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0BA4613F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 107A96E91B;
	Mon,  7 Jun 2021 16:14:06 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E42E6E91A;
 Mon,  7 Jun 2021 16:14:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BD69613C5;
 Mon,  7 Jun 2021 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623082444;
 bh=mL38B8L7m3iyZWRiJ81ZaCsFglFCjp7zhCV2YQ7Q84w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GG/SfNgSyMHl4PdwM15yR1Z4Zq0GAECUUV3BjTrryTIdxcbCYAU1NP39V84Cnugul
 jRPOHBAKKxLETQDAUnw62XtpLLcq8hnjW1joVJTRN7jpM1u+fS0+0AjOyBhTYd4m2b
 vFH5EByoDYHGR+lvHbbOMArqmZB88LzX5CGZ/HkjUjAW2GBjo0WLHwsV2sTKL3bkgm
 R0ZD0Wwv3JoEazO9R6Qc602Jx03Z7FY6FlopxWRKEoHcKy4GzZid9wp2xP+D5Hs4r/
 0TDblZkp5yFb6NV5ELB16MZvUK2elYb/KI968ztDn3QHeUoiljt1Sn/RwEJE6br/5d
 /L2Jg9gRxlZdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 35/39] drm/amd/amdgpu:save psp ring wptr to avoid
 attack
Date: Mon,  7 Jun 2021 12:13:14 -0400
Message-Id: <20210607161318.3583636-35-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210607161318.3583636-1-sashal@kernel.org>
References: <20210607161318.3583636-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Jingwen Chen <Jingwen.Chen2@amd.com>,
 Victor Zhao <Victor.Zhao@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Monk Liu <monk.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Victor Zhao <Victor.Zhao@amd.com>

[ Upstream commit 2370eba9f552eaae3d8aa1f70b8e9eec5c560f9e ]

[Why]
When some tools performing psp mailbox attack, the readback value
of register can be a random value which may break psp.

[How]
Use a psp wptr cache machanism to aovid the change made by attack.

v2: unify change and add detailed reason

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
Reviewed-by: Monk Liu <monk.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h | 1 +
 drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/psp_v3_1.c   | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 919d2fb7427b..60b7563f4c05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -73,6 +73,7 @@ struct psp_ring
 	uint64_t			ring_mem_mc_addr;
 	void				*ring_mem_handle;
 	uint32_t			ring_size;
+	uint32_t			ring_wptr;
 };
 
 /* More registers may will be supported */
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
index 6c5d9612abcb..cb764b554552 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
@@ -732,7 +732,7 @@ static uint32_t psp_v11_0_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 
@@ -746,6 +746,7 @@ static void psp_v11_0_ring_set_wptr(struct psp_context *psp, uint32_t value)
 	if (amdgpu_sriov_vf(adev)) {
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102, value);
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101, GFX_CTRL_CMD_ID_CONSUME_CMD);
+		psp->km_ring.ring_wptr = value;
 	} else
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
index f2e725f72d2f..908664a5774b 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
@@ -379,7 +379,7 @@ static uint32_t psp_v3_1_ring_get_wptr(struct psp_context *psp)
 	struct amdgpu_device *adev = psp->adev;
 
 	if (amdgpu_sriov_vf(adev))
-		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_102);
+		data = psp->km_ring.ring_wptr;
 	else
 		data = RREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67);
 	return data;
@@ -394,6 +394,7 @@ static void psp_v3_1_ring_set_wptr(struct psp_context *psp, uint32_t value)
 		/* send interrupt to PSP for SRIOV ring write pointer update */
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_101,
 			GFX_CTRL_CMD_ID_CONSUME_CMD);
+		psp->km_ring.ring_wptr = value;
 	} else
 		WREG32_SOC15(MP0, 0, mmMP0_SMN_C2PMSG_67, value);
 }
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
