Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D7CC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jun 2024 09:28:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECF1310E10B;
	Thu, 13 Jun 2024 09:28:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hHf1uMBh";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3D2C10E849;
 Wed, 12 Jun 2024 12:46:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0F11561456;
 Wed, 12 Jun 2024 12:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDFBC3277B;
 Wed, 12 Jun 2024 12:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1718196365;
 bh=6YNNmQnC4JTVzdIwmf2tyhvgCDDO0S11IAMboG8FPJ8=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=hHf1uMBhqwiQkZfX/tTcTdAMkKqHAepJT6wfH1bgxPcQdM4mnVnE9nEy1jP9T4dk+
 nawiZjfFRLH67/wjjdJ6Fu91yBtmM/vqZQRqpZkWbArocxo7izHakuHRXHh9t4/+PU
 eCyir89nyPIwwVKj7AiTTdyE3tydRfLyg4ej7hlk=
Subject: Patch "Revert "drm/amdgpu: init iommu after amdkfd device init"" has
 been added to the 5.15-stable tree
To: Prike.Liang@amd.com, W_Armin@gmx.de, Xinhui.Pan@amd.com,
 alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org, bkauler@gmail.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 gregkh@linuxfoundation.org, sashal@kernel.org, yifan1.zhang@amd.com
Cc: <stable-commits@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 12 Jun 2024 14:45:39 +0200
In-Reply-To: <20240523173031.4212-1-W_Armin@gmx.de>
Message-ID: <2024061239-rehydrate-flyable-343e@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Mailman-Approved-At: Thu, 13 Jun 2024 09:28:51 +0000
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


This is a note to let you know that I've just added the patch titled

    Revert "drm/amdgpu: init iommu after amdkfd device init"

to the 5.15-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     revert-drm-amdgpu-init-iommu-after-amdkfd-device-init.patch
and it can be found in the queue-5.15 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From W_Armin@gmx.de  Wed Jun 12 14:43:21 2024
From: Armin Wolf <W_Armin@gmx.de>
Date: Thu, 23 May 2024 19:30:31 +0200
Subject: Revert "drm/amdgpu: init iommu after amdkfd device init"
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: stable@vger.kernel.org, bkauler@gmail.com, yifan1.zhang@amd.com, Prike.Liang@amd.com, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Message-ID: <20240523173031.4212-1-W_Armin@gmx.de>

From: Armin Wolf <W_Armin@gmx.de>

This reverts commit 56b522f4668167096a50c39446d6263c96219f5f.

A user reported that this commit breaks the integrated gpu of his
notebook, causing a black screen. He was able to bisect the problematic
commit and verified that by reverting it the notebook works again.
He also confirmed that kernel 6.8.1 also works on his device, so the
upstream commit itself seems to be ok.

An amdgpu developer (Alex Deucher) confirmed that this patch should
have never been ported to 5.15 in the first place, so revert this
commit from the 5.15 stable series.

Reported-by: Barry Kauler <bkauler@gmail.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20240523173031.4212-1-W_Armin@gmx.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2487,6 +2487,10 @@ static int amdgpu_device_ip_init(struct
 	if (r)
 		goto init_failed;
 
+	r = amdgpu_amdkfd_resume_iommu(adev);
+	if (r)
+		goto init_failed;
+
 	r = amdgpu_device_ip_hw_init_phase1(adev);
 	if (r)
 		goto init_failed;
@@ -2525,10 +2529,6 @@ static int amdgpu_device_ip_init(struct
 	if (!adev->gmc.xgmi.pending_reset)
 		amdgpu_amdkfd_device_init(adev);
 
-	r = amdgpu_amdkfd_resume_iommu(adev);
-	if (r)
-		goto init_failed;
-
 	amdgpu_fru_get_product_info(adev);
 
 init_failed:


Patches currently in stable-queue which might be from W_Armin@gmx.de are

queue-5.15/revert-drm-amdgpu-init-iommu-after-amdkfd-device-init.patch
