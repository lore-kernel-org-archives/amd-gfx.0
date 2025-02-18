Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFD8C021AA
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 04:59:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDBE10E607;
	Tue, 18 Feb 2025 04:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SnEfoA2u";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9813010E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 04:58:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7BDF5A41D03;
 Tue, 18 Feb 2025 04:57:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C9BC4CEE6;
 Tue, 18 Feb 2025 04:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739854736;
 bh=QISbIKn3wJePvygzivdGs1R7GxEMB7D1AYeA5UVo99s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SnEfoA2uRsI/vfa+m6AfrbpEwTS4o+sLaKazbF0cQ/QjmYeLgj2VwXU3IxoRM68sF
 VYNgo9NYdJ0WVNJFJ5vuwpr3x43MZPxNj/3m+2xzFl23xn3ls2VOunN4NipvgwlYeh
 Av8PeKPBeThgTE50TKlQOURdTVfkQju/1F4tK3jRbNdNS9AW+yAvIzOAUPUW0K1vYU
 WD22S/3DmF8VI+KZGuKBcy77JSrDVFvVqFiwwxsZytDJNebALzkcgDuetvUdCBQ9ss
 a3+oeoEANr/ON0Kg9tKihCQYzstczyv+LkNmJHc4rRVktSR/7j323CvvVKQWIBlpYP
 UKINW/bZrAifg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 01/13] drm/amd/display: Change amdgpu_dm_irq_suspend() to void
Date: Mon, 17 Feb 2025 22:58:28 -0600
Message-ID: <20250218045840.2469890-2-superm1@kernel.org>
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

amdgpu_dm_irq_suspend() doesn't have any error flows and always
returns zero.

Change the function to void.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 3 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
index 3390f0d8420a0..058a94345245f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
@@ -473,7 +473,7 @@ void amdgpu_dm_irq_fini(struct amdgpu_device *adev)
 	unregister_all_irq_handlers(adev);
 }
 
-int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
+void amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 {
 	int src;
 	struct list_head *hnd_list_h;
@@ -511,7 +511,6 @@ int amdgpu_dm_irq_suspend(struct amdgpu_device *adev)
 	}
 
 	DM_IRQ_TABLE_UNLOCK(adev, irq_table_flags);
-	return 0;
 }
 
 int amdgpu_dm_irq_resume_early(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
index 2349238a626b1..c37bcd631e104 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h
@@ -90,7 +90,7 @@ void amdgpu_dm_hpd_fini(struct amdgpu_device *adev);
  * amdgpu_dm_irq_suspend - disable ASIC interrupt during suspend.
  *
  */
-int amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
+void amdgpu_dm_irq_suspend(struct amdgpu_device *adev);
 
 /**
  * amdgpu_dm_irq_resume_early - enable HPDRX ASIC interrupts during resume.
-- 
2.43.0

