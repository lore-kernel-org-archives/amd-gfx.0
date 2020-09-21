Return-Path: <SRS0=OtMv=C6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398B4C43463
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 12:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4AAC21789
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2020 12:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVBLhHqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4AAC21789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B1416E2DD;
	Mon, 21 Sep 2020 12:54:50 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 964976E2DD
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2020 12:54:49 +0000 (UTC)
Received: from localhost (unknown [70.37.104.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 479FE21BE5;
 Mon, 21 Sep 2020 12:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600692889;
 bh=dBJ/O9erG67+k4thH2mxUEzVqWsYJHRt34MLbl6xzbE=;
 h=Date:From:To:To:To:CC:Cc:Cc:Subject:In-Reply-To:References:From;
 b=qVBLhHqCZ3ytoX4zceilXI148WYpZK9SahD8mTV2j0aKCdJK49lqKOfgdAFKZp7nh
 lhDnpmzC25tiFiiCIbINCF0FvJ7Vxra1TugVHbRjNmFsKSlEAmNMBV9IXDdsX9CsPY
 abx9Rs26ZSuRO963Vecju20SuKBbePXFXrC74vBA=
Date: Mon, 21 Sep 2020 12:54:48 +0000
From: Sasha Levin <sashal@kernel.org>
To: Sasha Levin <sashal@kernel.org>
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display: [FIX] update clock under two conditions
In-Reply-To: <20200917143212.26346-1-qingqing.zhuo@amd.com>
References: <20200917143212.26346-1-qingqing.zhuo@amd.com>
Message-Id: <20200921125449.479FE21BE5@mail.kernel.org>
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

This commit has been processed because it contains a "Fixes:" tag
fixing commit: .

The bot has tested the following trees: v5.8.10, v5.4.66, v4.19.146, v4.14.198, v4.9.236, v4.4.236.

v5.8.10: Failed to apply! Possible dependencies:
    598c13b21e25 ("drm/amd/display: update clock when non-seamless boot stream exist")
    b7efa4f5cdb4 ("drm/amd/display: Move call to disable DPG")

v5.4.66: Failed to apply! Possible dependencies:
    3a4d180d4a9d ("drm/amd/display: Optimize clocks on clock change")
    598c13b21e25 ("drm/amd/display: update clock when non-seamless boot stream exist")
    6b5d7730d226 ("drm/amd/display: Add wait for flip not pending on pipe unlock")
    7f7652ee8c8c ("drm/amd/display: enable single dp seamless boot")
    9ae1b27f31d0 ("drm/amd/display: fix hotplug during display off")
    b6e881c94741 ("drm/amd/display: update navi to use new surface programming behaviour")
    ccce745c28d6 ("drm/amd/display: Enable Seamless Boot Transition for Multiple Streams")
    ce10a0f39b19 ("drm/amd/display: use vbios message to call smu for dpm level")
    f2988e67144a ("drm/amd/display: optimize bandwidth after commit streams.")

v4.19.146: Failed to apply! Possible dependencies:
    04a789bef315 ("drm/amd/display: add stream ID and otg instance in dc_stream_state")
    077d0b6ba211 ("drm/amd/display: Remove i2caux folder")
    097578091327 ("drm/amd/display: Set gamma not working on MPO planes")
    0cf5eb76e2b4 ("drm/amd/display: Add tracing to dc")
    1e7e86c43f38 ("drm/amd/display: decouple front and backend pgm using dpms_off as backend enable flag")
    37cd85ce3322 ("drm/amd/display: Remove dc_stream_state->status")
    56780940389a ("drm/amd/display: Remove redundant non-zero and overflow check")
    8c3db1284a01 ("drm/amdgpu: fill in amdgpu_dm_remove_sink_from_freesync_module")
    98e6436d3af5 ("drm/amd/display: Refactor FreeSync module")
    9b93eb475aa9 ("drm/amd/display: move clk_mgr files to right place")
    ad6756b4d773 ("drm/amd/display: Shift dc link aux to aux_payload")
    ccce745c28d6 ("drm/amd/display: Enable Seamless Boot Transition for Multiple Streams")
    ceb3dbb4690d ("drm/amd/display: remove sink reference in dc_stream_state")
    d82f99422b21 ("drm/amd/display: move edp fast boot optimization flag to stream")
    dc6c981d2027 ("drm/amd/display: Use DGAM ROM or RAM")
    eae5ffa9bd7b ("drm/amd/display: Switch ddc to new aux interface")
    fcee01b9f82d ("drm/amd/display: Add DCN2 clk mgr")

v4.14.198: Failed to apply! Possible dependencies:
    1b0c0f9dc5ca ("drm/amdgpu: move userptr BOs to CPU domain during CS v2")
    3fe89771cb0a ("drm/amdgpu: stop reserving the BO in the MMU callback v3")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    60de1c1740f3 ("drm/amdgpu: use a rw_semaphore for MMU notifiers")
    9a18999640fa ("drm/amdgpu: move MMU notifier related defines to amdgpu_mn.h")
    9b93eb475aa9 ("drm/amd/display: move clk_mgr files to right place")
    9cca0b8e5df0 ("drm/amdgpu: move amdgpu_cs_sysvm_access_required into find_mapping")
    a216ab09955d ("drm/amdgpu: fix userptr put_page handling")
    b72cf4fca2bb ("drm/amdgpu: move taking mmap_sem into get_user_pages v2")
    ca666a3c298f ("drm/amdgpu: stop using BO status for user pages")
    ccce745c28d6 ("drm/amd/display: Enable Seamless Boot Transition for Multiple Streams")
    fcee01b9f82d ("drm/amd/display: Add DCN2 clk mgr")

v4.9.236: Failed to apply! Possible dependencies:
    1cec20f0ea0e ("dma-buf: Restart reservation_object_wait_timeout_rcu() after writes")
    248a1d6f1ac4 ("drm/amd: fix include notation and remove -Iinclude/drm flag")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    78010cd9736e ("dma-buf/fence: add an lockdep_assert_held()")
    9b93eb475aa9 ("drm/amd/display: move clk_mgr files to right place")
    ccce745c28d6 ("drm/amd/display: Enable Seamless Boot Transition for Multiple Streams")
    f54d1867005c ("dma-buf: Rename struct fence to dma_fence")
    fcee01b9f82d ("drm/amd/display: Add DCN2 clk mgr")
    fedf54132d24 ("dma-buf: Restart reservation_object_get_fences_rcu() after writes")

v4.4.236: Failed to apply! Possible dependencies:
    0f477c6dea70 ("staging/android/sync: add sync_fence_create_dma")
    1f7371b2a5fa ("drm/amd/powerplay: add basic powerplay framework")
    248a1d6f1ac4 ("drm/amd: fix include notation and remove -Iinclude/drm flag")
    288912cb95d1 ("drm/amdgpu: use $(src) in Makefile (v2)")
    375fb53ec1be ("staging: android: replace explicit NULL comparison")
    395dec6f6bc5 ("Documentation: add doc for sync_file_get_fence()")
    4325198180e5 ("drm/amdgpu: remove GART page addr array")
    4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
    62304fb1fc08 ("dma-buf/sync_file: de-stage sync_file")
    9b93eb475aa9 ("drm/amd/display: move clk_mgr files to right place")
    a1d29476d666 ("drm/amdgpu: optionally enable GART debugfs file")
    a8fe58cec351 ("drm/amd: add ACP driver support")
    b70f014d58b9 ("drm/amdgpu: change default sched jobs to 32")
    c784c82a3fd6 ("Documentation: add Sync File doc")
    ccce745c28d6 ("drm/amd/display: Enable Seamless Boot Transition for Multiple Streams")
    d4cab38e153d ("staging/android: prepare sync_file for de-staging")
    d7fdb0ae9d11 ("staging/android: rename sync_fence to sync_file")
    f54d1867005c ("dma-buf: Rename struct fence to dma_fence")
    fac8434dab96 ("Documentation: Fix some grammar mistakes in sync_file.txt")
    fcee01b9f82d ("drm/amd/display: Add DCN2 clk mgr")
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
