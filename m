Return-Path: <SRS0=+Fjx=BT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D40BC433DF
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 15:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1748B206C3
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Aug 2020 15:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OibV+d1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1748B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB2D86E172;
	Sun,  9 Aug 2020 15:53:06 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 101616E172
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Aug 2020 15:53:06 +0000 (UTC)
Received: from localhost (unknown [70.37.104.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AF3DD206B6;
 Sun,  9 Aug 2020 15:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1596988385;
 bh=bvzSHpepcIpsk01JPm9/jnJXQQBNbZgDPOOUGXrs9zk=;
 h=Date:From:To:To:To:To:CC:Cc:Cc:Subject:In-Reply-To:References:
 From;
 b=OibV+d1BMmpxoJNs5u7y4xANzls9uXo1GYSp1zUjDHf+bKoNatL8T0rsI5gqhnG+l
 tEtQqe21eyz75TXFFH5a60qk5oI1X4u+fiLjTiT+YV84SZV3tMsb40R22zN68nrNy8
 XAeTxrU3Kbe/UvjS2ek/C6SR0EUeNVN4nifSYKjM=
Date: Sun, 09 Aug 2020 15:53:05 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: Jaehyun Chung <jaehyun.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 9/9] drm/amd/display: Blank stream before destroying HDCP
 session
In-Reply-To: <20200805174058.11736-10-qingqing.zhuo@amd.com>
References: <20200805174058.11736-10-qingqing.zhuo@amd.com>
Message-Id: <20200809155305.AF3DD206B6@mail.kernel.org>
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

The bot has tested the following trees: v5.8, v5.7.13, v5.4.56, v4.19.137, v4.14.192, v4.9.232, v4.4.232.

v5.8: Build OK!
v5.7.13: Failed to apply! Possible dependencies:
    4cf7c42739cc ("drm/amd/display: Set/Reset avmute when disable/enable stream")

v5.4.56: Failed to apply! Possible dependencies:
    2b77dcc5e5aa ("drm/amd/display: rename core_dc to dc")
    2f752e914d94 ("drm/amd/display: Remove connect DIG FE to its BE during timing programming")
    48af9b91b129 ("drm/amd/display: Don't allocate payloads if link lost")
    4cf7c42739cc ("drm/amd/display: Set/Reset avmute when disable/enable stream")
    7f7652ee8c8c ("drm/amd/display: enable single dp seamless boot")
    8cc426d79be1 ("drm/amd/display: Program DSC during timing programming")
    9ae1b27f31d0 ("drm/amd/display: fix hotplug during display off")
    ab4a4072f260 ("drm/amd/display: exit PSR during detection")
    d4252eee1f7c ("drm/amd/display: Add debugfs entry to force YUV420 output")
    d462fcf5012b ("drm/amd/display: Update hdcp display config")
    e0d08a40a63b ("drm/amd/display: Add debugfs entry for reading psr state")
    e78a312f81c8 ("drm/amd/display: use requested_dispclk_khz instead of clk")
    ef5a7d266e82 ("drm/amd/display: skip enable stream on disconnected display")

v4.19.137: Failed to apply! Possible dependencies:
    11c3ee48bd7c ("drm/amdgpu/display: add support for LVDS (v5)")
    1a9e3d4569fc ("drm/amd/display: Set DSC before DIG front-end is connected to its back-end")
    1e7e86c43f38 ("drm/amd/display: decouple front and backend pgm using dpms_off as backend enable flag")
    2f752e914d94 ("drm/amd/display: Remove connect DIG FE to its BE during timing programming")
    4cf7c42739cc ("drm/amd/display: Set/Reset avmute when disable/enable stream")
    8c3db1284a01 ("drm/amdgpu: fill in amdgpu_dm_remove_sink_from_freesync_module")
    98e6436d3af5 ("drm/amd/display: Refactor FreeSync module")
    aa9c4abe466a ("drm/amd/display: Refactor FPGA-specific link setup")

v4.14.192: Failed to apply! Possible dependencies:
    1b0c0f9dc5ca ("drm/amdgpu: move userptr BOs to CPU domain during CS v2")
    2f752e914d94 ("drm/amd/display: Remove connect DIG FE to its BE during timing programming")
    3fe89771cb0a ("drm/amdgpu: stop reserving the BO in the MMU callback v3")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    4cf7c42739cc ("drm/amd/display: Set/Reset avmute when disable/enable stream")
    60de1c1740f3 ("drm/amdgpu: use a rw_semaphore for MMU notifiers")
    71021265a6f0 ("drm/amd/display: Clear test pattern when enabling stream")
    9a18999640fa ("drm/amdgpu: move MMU notifier related defines to amdgpu_mn.h")
    9cca0b8e5df0 ("drm/amdgpu: move amdgpu_cs_sysvm_access_required into find_mapping")
    a216ab09955d ("drm/amdgpu: fix userptr put_page handling")
    b72cf4fca2bb ("drm/amdgpu: move taking mmap_sem into get_user_pages v2")
    ca666a3c298f ("drm/amdgpu: stop using BO status for user pages")

v4.9.232: Failed to apply! Possible dependencies:
    1cec20f0ea0e ("dma-buf: Restart reservation_object_wait_timeout_rcu() after writes")
    248a1d6f1ac4 ("drm/amd: fix include notation and remove -Iinclude/drm flag")
    2f752e914d94 ("drm/amd/display: Remove connect DIG FE to its BE during timing programming")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    4cf7c42739cc ("drm/amd/display: Set/Reset avmute when disable/enable stream")
    71021265a6f0 ("drm/amd/display: Clear test pattern when enabling stream")
    78010cd9736e ("dma-buf/fence: add an lockdep_assert_held()")
    f54d1867005c ("dma-buf: Rename struct fence to dma_fence")
    fedf54132d24 ("dma-buf: Restart reservation_object_get_fences_rcu() after writes")

v4.4.232: Failed to apply! Possible dependencies:
    0f477c6dea70 ("staging/android/sync: add sync_fence_create_dma")
    1f7371b2a5fa ("drm/amd/powerplay: add basic powerplay framework")
    248a1d6f1ac4 ("drm/amd: fix include notation and remove -Iinclude/drm flag")
    288912cb95d1 ("drm/amdgpu: use $(src) in Makefile (v2)")
    2f752e914d94 ("drm/amd/display: Remove connect DIG FE to its BE during timing programming")
    375fb53ec1be ("staging: android: replace explicit NULL comparison")
    395dec6f6bc5 ("Documentation: add doc for sync_file_get_fence()")
    4325198180e5 ("drm/amdgpu: remove GART page addr array")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    4cf7c42739cc ("drm/amd/display: Set/Reset avmute when disable/enable stream")
    62304fb1fc08 ("dma-buf/sync_file: de-stage sync_file")
    71021265a6f0 ("drm/amd/display: Clear test pattern when enabling stream")
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
