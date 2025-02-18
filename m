Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0A0C021A9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B9910E60F;
	Tue, 18 Feb 2025 04:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="smlhSLj8";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 357FF10E608
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:59:02 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7F575A41D03;
 Tue, 18 Feb 2025 04:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B28A1C4CEE8;
 Tue, 18 Feb 2025 04:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854741;
 bh=7qWYM1wNznh6IJeNqQ7uOKi6LbSRXiAAL1rgnqtxpBs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=smlhSLj81Ia6btthwpbO8LjIx92CjUFmEIrRnz8NggrBMWeDA8HBxiYvwtpSlb53q
 BaXrJ5Tt4Mk3IIBUO+ccI9FpZ2RgjcHag2dMVfejDEcSyX+mk7dJO4FRRBgiVqznWl
 iumtmQ2i5iwibgKlZxCuOsir9tWQZPpihfC7Tk764IYi8Go2vLUVDCmDpa5Ey2o2Fo
 GDjohu6K1DjeYdnXi2VQMNDfEM0mtD3qcNsqiRmXRi5rlbPQLtRbrd4irvSyqEv3Sx
 Rr7CfSXi4Yn16ElZMhwbqDCnPCJPsJ6Cg0r253Ce0tSOBSmY5/vY7YQwdAVi5B+tbr
 3kOBAUoYciWTA==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 08/13] drm/amd/display: Change amdgpu_dm_irq_resume_*() to void
Date: Mon, 17 Feb 2025 22:58:35 -0600
Message-ID: <20250218045840.2469890-9-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250218045840.2469890-1-superm1@kernel.org>
References: <20250218045840.2469890-1-superm1@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mario Limonciello <mario.limonciello@amd.com>

amdgpu_dm_irq_resume_early() and amdgpu_dm_irq_resume_late() don't
have any error flows. Change the return type from integer to void.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 7 ++-----
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h | 4 ++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 3224eae295eb4..2fec00e5d7491 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -513,7 +513,7 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
 }
 
-int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
+void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 {
 	int src;
 	struct list_head *hnd_list_h, *hnd_list_l;
@@ -532,11 +532,9 @@ int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-
-	return 0;
 }
 
-int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
+void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 {
 	int src;
 	struct list_head *hnd_list_h, *hnd_list_l;
@@ -558,7 +556,6 @@ int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev)
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-	return 0;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index c37bcd631e104..ba17c23b27064 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -97,7 +97,7 @@ void amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
  * amdgpu_dm_irq_resume - enable ASIC interrupt during resume.
  *
  */
-int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev);
-int amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
+void amdgpu_dm_irq_resume_early(struct amdgpu_device *adev);
+void amdgpu_dm_irq_resume_late(struct amdgpu_device *adev);
 
 #endif /* __AMDGPU_DM_IRQ_H__ */
-- 
2.43.0

