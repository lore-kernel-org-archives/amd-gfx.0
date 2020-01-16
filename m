Return-Path: <SRS0=9Rk5=3F=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6A4C47409
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E72BF2192A
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jan 2020 16:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiFyTes2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72BF2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B196D6EDEF;
	Thu, 16 Jan 2020 16:53:57 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94D2F6EDEF;
 Thu, 16 Jan 2020 16:53:56 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B9F5F2176D;
 Thu, 16 Jan 2020 16:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579193636;
 bh=NGeX31yHaJjulEnEI8CSs+W7be4cul/wAnLxIUgPJuw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=oiFyTes2Xy07hYbwxjsXWocdL9h2nTu+tlK9EI6o1RWAjgPxg4D2T3FZ1O9M1HKYm
 RbdlSp6flDNSuQp3WNGqQQuGGcVYfCwbih4/lXr856WQVvBoIw9qtWAa22UWffnmuX
 83+UTp59GVX+v1EPjGejWhLsY3r4UEIHYjzWnuL4=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 169/205] drm/radeon: fix bad DMA from
 INTERRUPT_CNTL2
Date: Thu, 16 Jan 2020 11:42:24 -0500
Message-Id: <20200116164300.6705-169-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
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
Cc: Sam Bobroff <sbobroff@linux.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sam Bobroff <sbobroff@linux.ibm.com>

[ Upstream commit 62d91dd2851e8ae2ca552f1b090a3575a4edf759 ]

The INTERRUPT_CNTL2 register expects a valid DMA address, but is
currently set with a GPU MC address.  This can cause problems on
systems that detect the resulting DMA read from an invalid address
(found on a Power8 guest).

Instead, use the DMA address of the dummy page because it will always
be safe.

Fixes: d8f60cfc9345 ("drm/radeon/kms: Add support for interrupts on r6xx/r7xx chips (v3)")
Fixes: 25a857fbe973 ("drm/radeon/kms: add support for interrupts on SI")
Fixes: a59781bbe528 ("drm/radeon: add support for interrupts on CIK (v5)")
Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/cik.c  | 4 ++--
 drivers/gpu/drm/radeon/r600.c | 4 ++--
 drivers/gpu/drm/radeon/si.c   | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 62eab82a64f9..897442754fd0 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -6969,8 +6969,8 @@ static int cik_irq_init(struct radeon_device *rdev)
 	}
 
 	/* setup interrupt control */
-	/* XXX this should actually be a bus address, not an MC address. same on older asics */
-	WREG32(INTERRUPT_CNTL2, rdev->ih.gpu_addr >> 8);
+	/* set dummy read address to dummy page address */
+	WREG32(INTERRUPT_CNTL2, rdev->dummy_page.addr >> 8);
 	interrupt_cntl = RREG32(INTERRUPT_CNTL);
 	/* IH_DUMMY_RD_OVERRIDE=0 - dummy read disabled with msi, enabled without msi
 	 * IH_DUMMY_RD_OVERRIDE=1 - dummy read controlled by IH_DUMMY_RD_EN
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index e937cc01910d..033bc466a862 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -3696,8 +3696,8 @@ int r600_irq_init(struct radeon_device *rdev)
 	}
 
 	/* setup interrupt control */
-	/* set dummy read address to ring address */
-	WREG32(INTERRUPT_CNTL2, rdev->ih.gpu_addr >> 8);
+	/* set dummy read address to dummy page address */
+	WREG32(INTERRUPT_CNTL2, rdev->dummy_page.addr >> 8);
 	interrupt_cntl = RREG32(INTERRUPT_CNTL);
 	/* IH_DUMMY_RD_OVERRIDE=0 - dummy read disabled with msi, enabled without msi
 	 * IH_DUMMY_RD_OVERRIDE=1 - dummy read controlled by IH_DUMMY_RD_EN
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 05894d198a79..1d8efb0eefdb 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -5997,8 +5997,8 @@ static int si_irq_init(struct radeon_device *rdev)
 	}
 
 	/* setup interrupt control */
-	/* set dummy read address to ring address */
-	WREG32(INTERRUPT_CNTL2, rdev->ih.gpu_addr >> 8);
+	/* set dummy read address to dummy page address */
+	WREG32(INTERRUPT_CNTL2, rdev->dummy_page.addr >> 8);
 	interrupt_cntl = RREG32(INTERRUPT_CNTL);
 	/* IH_DUMMY_RD_OVERRIDE=0 - dummy read disabled with msi, enabled without msi
 	 * IH_DUMMY_RD_OVERRIDE=1 - dummy read controlled by IH_DUMMY_RD_EN
-- 
2.20.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
