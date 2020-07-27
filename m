Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EDCC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 21:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26DC920838
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 21:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+/uxdL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26DC920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C4E89DC1;
	Mon, 27 Jul 2020 21:24:38 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89E5589DC1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 21:24:37 +0000 (UTC)
Received: from localhost (unknown [13.85.75.251])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id ED77F20838;
 Mon, 27 Jul 2020 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1595885077;
 bh=CI0zaCVXtCwm6kl4vbxepT61HWBSJwnzXur6ko1kHrM=;
 h=Date:From:To:To:To:To:CC:CC:Cc:Subject:In-Reply-To:References:
 From;
 b=Y+/uxdL/0w3G+CeBSah3MaUdlTAK4mK9ygatH4eKj5J43phQktsj/IbN40NIGfv9i
 g8+cv+X83a+zraTSQHZyUp2PsV7u3VeVfQSdiqcInBZiGUgbKeK5dR3CeIjyyXftXr
 99vBY3f56kUzHmpgpaRpDyyLbJL6vjtSWLmGZNHY=
Date: Mon, 27 Jul 2020 21:24:36 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Eryk Brol <eryk.brol@amd.com>
To: hersen wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 11/15] drm/amd/display: dchubbub p-state warning during
 surface planes switch
In-Reply-To: <20200724210618.2709738-12-eryk.brol@amd.com>
References: <20200724210618.2709738-12-eryk.brol@amd.com>
Message-Id: <20200727212436.ED77F20838@mail.kernel.org>
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, stable@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi

[This is an automated email]

This commit has been processed because it contains a -stable tag.
The stable tag indicates that it's relevant for the following trees: all

The bot has tested the following trees: v5.7.10, v5.4.53, v4.19.134, v4.14.189, v4.9.231, v4.4.231.

v5.7.10: Build OK!
v5.4.53: Build OK!
v4.19.134: Failed to apply! Possible dependencies:
    1e7e86c43f38 ("drm/amd/display: decouple front and backend pgm using dpms_off as backend enable flag")
    24f7dd7ea98d ("drm/amd/display: move pplib/smu notification to dccg block")
    4c5e8b541527 ("drm/amd/display: split dccg clock manager into asic folders")
    8c3db1284a01 ("drm/amdgpu: fill in amdgpu_dm_remove_sink_from_freesync_module")
    98e6436d3af5 ("drm/amd/display: Refactor FreeSync module")
    ad908423ef86 ("drm/amd/display: support 48 MHZ refclk off")
    c85e6e546edd ("drm/amd/display: Create new i2c resource")

v4.14.189: Failed to apply! Possible dependencies:
    1b0c0f9dc5ca ("drm/amdgpu: move userptr BOs to CPU domain during CS v2")
    1ed3d2567c80 ("drm/amdgpu: keep the MMU lock until the update ends v4")
    3fe89771cb0a ("drm/amdgpu: stop reserving the BO in the MMU callback v3")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    4c5e8b541527 ("drm/amd/display: split dccg clock manager into asic folders")
    60de1c1740f3 ("drm/amdgpu: use a rw_semaphore for MMU notifiers")
    9a18999640fa ("drm/amdgpu: move MMU notifier related defines to amdgpu_mn.h")
    9cca0b8e5df0 ("drm/amdgpu: move amdgpu_cs_sysvm_access_required into find_mapping")
    a216ab09955d ("drm/amdgpu: fix userptr put_page handling")
    b72cf4fca2bb ("drm/amdgpu: move taking mmap_sem into get_user_pages v2")
    ca666a3c298f ("drm/amdgpu: stop using BO status for user pages")

v4.9.231: Failed to apply! Possible dependencies:
    1cec20f0ea0e ("dma-buf: Restart reservation_object_wait_timeout_rcu() after writes")
    248a1d6f1ac4 ("drm/amd: fix include notation and remove -Iinclude/drm flag")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    4c5e8b541527 ("drm/amd/display: split dccg clock manager into asic folders")
    78010cd9736e ("dma-buf/fence: add an lockdep_assert_held()")
    f54d1867005c ("dma-buf: Rename struct fence to dma_fence")
    fedf54132d24 ("dma-buf: Restart reservation_object_get_fences_rcu() after writes")

v4.4.231: Failed to apply! Possible dependencies:
    0f477c6dea70 ("staging/android/sync: add sync_fence_create_dma")
    1f7371b2a5fa ("drm/amd/powerplay: add basic powerplay framework")
    248a1d6f1ac4 ("drm/amd: fix include notation and remove -Iinclude/drm flag")
    288912cb95d1 ("drm/amdgpu: use $(src) in Makefile (v2)")
    375fb53ec1be ("staging: android: replace explicit NULL comparison")
    395dec6f6bc5 ("Documentation: add doc for sync_file_get_fence()")
    4325198180e5 ("drm/amdgpu: remove GART page addr array")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    4c5e8b541527 ("drm/amd/display: split dccg clock manager into asic folders")
    62304fb1fc08 ("dma-buf/sync_file: de-stage sync_file")
    a1d29476d666 ("drm/amdgpu: optionally enable GART debugfs file")
    a8fe58cec351 ("drm/amd: add ACP driver support")
    b70f014d58b9 ("drm/amdgpu: change default sched jobs to 32")
    c784c82a3fd6 ("Documentation: add Sync File doc")
    d4cab38e153d ("staging/android: prepare sync_file for de-staging")
    d7fdb0ae9d11 ("staging/android: rename sync_fence to sync_file")
    f54d1867005c ("dma-buf: Rename struct fence to dma_fence")
    fac8434dab96 ("Documentation: Fix some grammar mistakes in sync_file.txt")
    fdba11f4079e ("drm/amdgpu: move all Kconfig options to amdgpu/Kconfig")


NOTE: The patch will not be queued to stable trees until it is upstream.

How should we proceed with this patch?

-- 
Thanks
Sasha
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
