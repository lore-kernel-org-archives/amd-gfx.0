Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5A7C04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 10:17:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCF06113569;
	Wed,  8 May 2024 10:17:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="mhZ6FP0f";
	dkim-atps=neutral
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9588E113569
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 10:17:05 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4VZ9zy0Wqvz9sqj;
 Wed,  8 May 2024 12:17:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1715163422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kqixmISPPEyrTS5FDHfF3IVapKDY38x5UwfXRZ6ai4E=;
 b=mhZ6FP0fr0Zu3ehAQAKrc5j8RCOF2YY1pWYR+r3LvUBpdUKiix69RTIjn/UwxSCaDI7Ch9
 mYP7V6cMwivWa0PLHQy0rHbMcId3S4XqT8sGlVMXxxHfRv65Yjemc3nx2Peuo09igl7NjT
 3vKksNW/lXYXV6LNyPStOHOkKCVotXhFhnudQSRNELKb87HD781nsQRli31f2PH2Aw5L3M
 fsIxZA7H/sTK2gLFooTAm9lPN7iJo+GLrGnxECWbcB1/6BzQkKdh4LOzoydkz9gazqF9bd
 SeigFhJw+9MYfQ0ptp4SXypFhVpXiarfgde8cKmdgygUNrfoQvVgkq6jPXU0tw==
Message-ID: <47c31c39-9ca0-46b6-93cd-e5c4c002fe23@mailbox.org>
Date: Wed, 8 May 2024 12:17:00 +0200
MIME-Version: 1.0
Subject: Re: [patch] problems with "fix visible VRAM handling during faults"
To: Jeremy Day <jsday@noreason.ca>
Cc: christian.koenig@amd.com, amd-gfx@lists.freedesktop.org
References: <20240507123907.3a39163546b4643c5d834522@noreason.ca>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20240507123907.3a39163546b4643c5d834522@noreason.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9df879f2390180d63d1
X-MBO-RS-META: 6prbq46irzi5fkrwz8fkdm1krjqkuein
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

On 2024-05-07 18:39, Jeremy Day wrote:
> This is just to report that I've had usually well-behaved applications
> sometimes having problems with memory access violations since kernel
> version 6.9-rc5.  This past weekend I stumbled across a way to reliably
> reproduce the problem in the form of a Skyrim save file which causes a
> crash shortly after loading the game on affected kernels.
> 
> Things go back to running smoothly only if I revert one of the changes
> in 5th April's "[PATCH] drm/amdgpu: fix visible VRAM handling during
> faults" as follows.
> 
> Patch is against v6.9-rc7.  It restores the check for partially
> visible-to-cpu memory in amdgpu_bo_fault_reserve_notify.  Things
> seem stable again with this change.

Does this instead of your patch help by any chance?


diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 109fe557a02b..29c197c00018 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -427,7 +427,7 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,

        amdgpu_res_first(res, 0, res->size, &cursor);
        while (cursor.remaining) {
-               if ((cursor.start + cursor.size) >= adev->gmc.visible_vram_size)
+               if ((cursor.start + cursor.size) > adev->gmc.visible_vram_size)
                        return false;
                amdgpu_res_next(&cursor, cursor.size);
        }


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

