Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B189C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Oct 2022 07:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D817710ECB0;
	Mon, 17 Oct 2022 07:11:18 +0000 (UTC)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19C1710E4C9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 14:15:27 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id 70so5021587pjo.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=nxloFMgJyTROJisMRfHtqod4Gekn7f7TARQzQa8Kz/0=;
 b=JaKP1Le2yJGWDsIPY6pZtFJkjt5nvL8El3Eg/Saps1KvPVhO2Vwn8xihug1b6s8DMm
 vGQ8+pNrY1FhmCAjQG7cXjgHz/nIeFk6uRO70PXO4KdM9qHnwJH/ReoPmL6RoFJX9NJa
 SyzNuUfXaAPqZ2TCmgkeke7jKlUtEEDKJGfKPChgjklSSoCjajRCgcc0FjQ1qLuUUVdO
 4pIG28b92fVtzznvoeYTGCdsF9tFlJxjkPrK4bAwofPMTSHhFsq9cIffvXO2xk/fydvj
 E0hGgs+Q7/uZWu6jzZimvkvSThH5UL0wUj2xnFfwMKFEx0A0cHV0frn38RONOzoHBHnX
 NMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxloFMgJyTROJisMRfHtqod4Gekn7f7TARQzQa8Kz/0=;
 b=DQxT+NPtEA4e1ygBatfTAyEs3Qa5uF61O1qqIJu4mBU1VcQCKrrp559mnieSWLMDjz
 dobIIwbql/kuIOdH+o8rufhTPMFML9JStFDN/nCFxCp0pNyexLvC/XVzDouYJiNNXDqT
 o75IaBmk6bvRo7cQITzQ1jd4/YZnbADZJOTYIBGX+CyZ6plvsqdS6rDagt0xzGEj3WuT
 I0nP21R64Trg9cJ90XrKKDl5tzlOrHTGf26xHu+gIPoUVYGlRogqsYu7AXZzSj/VKid5
 IGgExh8ODAbHVpMX/qY0PZkYqP2DEcpWHi7v8muPOCxjY7fwMpoCuLx8zxnbBqIeNZ83
 GDSg==
X-Gm-Message-State: ACrzQf2HlIVsVYuZ7wdE6FLPt3jda+B8X0tJx/4/coD7WoQrpkvE6GVg
 uxZE9X9ThB25uYB/SSLBtCxROnF8sUA=
X-Google-Smtp-Source: AMsMyM5dX1cbLWgTAQ8zW4VblcqgSk3q86Tw3q71ZlXZW37smPTFJBliIVMeqcjRJyrGsQ9nDo/Kvg==
X-Received: by 2002:a17:902:e885:b0:183:dcb7:c4f8 with SMTP id
 w5-20020a170902e88500b00183dcb7c4f8mr5619862plg.160.1665756926527; 
 Fri, 14 Oct 2022 07:15:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 w206-20020a627bd7000000b00553d5920a29sm1767609pfc.101.2022.10.14.07.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Oct 2022 07:15:25 -0700 (PDT)
Date: Fri, 14 Oct 2022 07:15:24 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Yunxiang Li <Yunxiang.Li@amd.com>
Subject: Re: [PATCH] drm/amd/display: Fix vblank refcount in vrr transition
Message-ID: <20221014141524.GA4063757@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 17 Oct 2022 07:11:15 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 21, 2022 at 05:20:19PM -0400, Yunxiang Li wrote:
> manage_dm_interrupts disable/enable vblank using drm_crtc_vblank_off/on
> which causes drm_crtc_vblank_get in vrr_transition to fail, and later
> when drm_crtc_vblank_put is called the refcount on vblank will be messed
> up. Therefore move the call to after manage_dm_interrupts.
> 
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1247
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1380
> 

This patch results in a large number of compile errors
if CONFIG_DEBUG_FS=n. Reverting it fixes the problem.

This is an architecture independent problem.

Guenter

---
Building loongarch:defconfig ... failed
--------------
Error log:
<stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: In function 'amdgpu_dm_atomic_commit_tail':
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7969:14: warning: unused variable 'wait_for_vblank' [-Wunused-variable]
 7969 |         bool wait_for_vblank = true;
      |              ^~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7968:23: warning: unused variable 'flags' [-Wunused-variable]
 7968 |         unsigned long flags;
      |                       ^~~~~
In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_trace.h:39,
                 from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:41:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: At top level:
include/drm/drm_atomic.h:864:9: error: expected identifier or '(' before 'for'
  864 |         for ((__i) = 0;                                                 \
      |         ^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8317:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8317 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_atomic.h:865:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before '<' token
  865 |              (__i) < (__state)->dev->mode_config.num_crtc;              \
      |                    ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8317:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8317 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_atomic.h:866:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before '++' token
  866 |              (__i)++)                                                   \
      |                   ^~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8317:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8317 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from include/drm/drm_connector.h:32,
                 from include/drm/display/drm_dp_helper.h:30,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:39,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
                 from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:29:
include/drm/drm_util.h:63:53: error: expected identifier or '(' before 'else'
   63 | #define for_each_if(condition) if (!(condition)) {} else
      |                                                     ^~~~
include/drm/drm_atomic.h:867:17: note: in expansion of macro 'for_each_if'
  867 |                 for_each_if ((__state)->crtcs[__i].ptr &&               \
      |                 ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8317:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8317 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j)
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_atomic.h:864:9: error: expected identifier or '(' before 'for'
  864 |         for ((__i) = 0;                                                 \
      |         ^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8322:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8322 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_atomic.h:865:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before '<' token
  865 |              (__i) < (__state)->dev->mode_config.num_crtc;              \
      |                    ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8322:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8322 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_atomic.h:866:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before '++' token
  866 |              (__i)++)                                                   \
      |                   ^~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8322:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8322 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_util.h:63:53: error: expected identifier or '(' before 'else'
   63 | #define for_each_if(condition) if (!(condition)) {} else
      |                                                     ^~~~
include/drm/drm_atomic.h:867:17: note: in expansion of macro 'for_each_if'
  867 |                 for_each_if ((__state)->crtcs[__i].ptr &&               \
      |                 ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8322:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8322 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, j) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8331:9: warning: data definition has no type or storage class
 8331 |         amdgpu_dm_commit_audio(dev, state);
      |         ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8331:9: error: type defaults to 'int' in declaration of 'amdgpu_dm_commit_audio' [-Werror=implicit-int]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8331:9: warning: parameter names (without types) in function declaration
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8331:9: error: conflicting types for 'amdgpu_dm_commit_audio'; have 'int()'
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7861:13: note: previous definition of 'amdgpu_dm_commit_audio' with type 'void(struct drm_device *, struct drm_atomic_state *)'
 7861 | static void amdgpu_dm_commit_audio(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8334:9: error: expected identifier or '(' before 'for'
 8334 |         for (i = 0; i < dm->num_of_edps; i++) {
      |         ^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8334:23: error: expected '=', ',', ';', 'asm' or '__attribute__' before '<' token
 8334 |         for (i = 0; i < dm->num_of_edps; i++) {
      |                       ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8334:43: error: expected '=', ',', ';', 'asm' or '__attribute__' before '++' token
 8334 |         for (i = 0; i < dm->num_of_edps; i++) {
      |                                           ^~
In file included from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/slab.h:15,
                 from drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:30:
include/linux/spinlock.h:379:1: error: expected identifier or '(' before 'do'
  379 | do {                                                            \
      | ^~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8344:9: note: in expansion of macro 'spin_lock_irqsave'
 8344 |         spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
      |         ^~~~~~~~~~~~~~~~~
include/linux/spinlock.h:381:3: error: expected identifier or '(' before 'while'
  381 | } while (0)
      |   ^~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8344:9: note: in expansion of macro 'spin_lock_irqsave'
 8344 |         spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
      |         ^~~~~~~~~~~~~~~~~
include/drm/drm_atomic.h:864:9: error: expected identifier or '(' before 'for'
  864 |         for ((__i) = 0;                                                 \
      |         ^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8345:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8345 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_atomic.h:865:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before '<' token
  865 |              (__i) < (__state)->dev->mode_config.num_crtc;              \
      |                    ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8345:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8345 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_atomic.h:866:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before '++' token
  866 |              (__i)++)                                                   \
      |                   ^~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8345:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8345 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
include/drm/drm_util.h:63:53: error: expected identifier or '(' before 'else'
   63 | #define for_each_if(condition) if (!(condition)) {} else
      |                                                     ^~~~
include/drm/drm_atomic.h:867:17: note: in expansion of macro 'for_each_if'
  867 |                 for_each_if ((__state)->crtcs[__i].ptr &&               \
      |                 ^~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8345:9: note: in expansion of macro 'for_each_new_crtc_in_state'
 8345 |         for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8352:32: error: expected declaration specifiers or '...' before '&' token
 8352 |         spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
      |                                ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8352:64: error: unknown type name 'flags'
 8352 |         spin_unlock_irqrestore(&adev_to_drm(adev)->event_lock, flags);
      |                                                                ^~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8355:9: warning: data definition has no type or storage class
 8355 |         drm_atomic_helper_commit_hw_done(state);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8355:9: error: type defaults to 'int' in declaration of 'drm_atomic_helper_commit_hw_done' [-Werror=implicit-int]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8355:9: warning: parameter names (without types) in function declaration
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8355:9: error: conflicting types for 'drm_atomic_helper_commit_hw_done'; have 'int()'
In file included from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:83:
include/drm/drm_atomic_helper.h:123:6: note: previous declaration of 'drm_atomic_helper_commit_hw_done' with type 'void(struct drm_atomic_state *)'
  123 | void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *state);
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8357:9: error: expected identifier or '(' before 'if'
 8357 |         if (wait_for_vblank)
      |         ^~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8360:9: warning: data definition has no type or storage class
 8360 |         drm_atomic_helper_cleanup_planes(dev, state);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8360:9: error: type defaults to 'int' in declaration of 'drm_atomic_helper_cleanup_planes' [-Werror=implicit-int]
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8360:9: warning: parameter names (without types) in function declaration
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8360:9: error: conflicting types for 'drm_atomic_helper_cleanup_planes'; have 'int()'
include/drm/drm_atomic_helper.h:108:6: note: previous declaration of 'drm_atomic_helper_cleanup_planes' with type 'void(struct drm_device *, struct drm_atomic_state *)'
  108 | void drm_atomic_helper_cleanup_planes(struct drm_device *dev,
      |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8363:9: error: expected identifier or '(' before 'if'
 8363 |         if (!adev->mman.keep_stolen_vga_memory)
      |         ^~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8365:31: error: expected declaration specifiers or '...' before '&' token
 8365 |         amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
      |                               ^
In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/loongarch/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:246,
                 from include/linux/build_bug.h:5,
                 from include/linux/container_of.h:5,
                 from include/linux/list.h:5,
                 from include/linux/preempt.h:11,
                 from include/linux/spinlock.h:56:
include/linux/stddef.h:8:14: error: expected declaration specifiers or '...' before '(' token
    8 | #define NULL ((void *)0)
      |              ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8365:67: note: in expansion of macro 'NULL'
 8365 |         amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
      |                                                                   ^~~~
include/linux/stddef.h:8:14: error: expected declaration specifiers or '...' before '(' token
    8 | #define NULL ((void *)0)
      |              ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8365:73: note: in expansion of macro 'NULL'
 8365 |         amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
      |                                                                         ^~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8372:9: error: expected identifier or '(' before 'for'
 8372 |         for (i = 0; i < crtc_disable_count; i++)
      |         ^~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8372:23: error: expected '=', ',', ';', 'asm' or '__attribute__' before '<' token
 8372 |         for (i = 0; i < crtc_disable_count; i++)
      |                       ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8372:46: error: expected '=', ',', ';', 'asm' or '__attribute__' before '++' token
 8372 |         for (i = 0; i < crtc_disable_count; i++)
      |                                              ^~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8374:38: error: expected ')' before '->' token
 8374 |         pm_runtime_mark_last_busy(dev->dev);
      |                                      ^~
      |                                      )
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8376:9: error: expected identifier or '(' before 'if'
 8376 |         if (dc_state_temp)
      |         ^~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8378:1: error: expected identifier or '(' before '}' token
 8378 | }
      | ^
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7861:13: warning: 'amdgpu_dm_commit_audio' defined but not used [-Wunused-function]
 7861 | static void amdgpu_dm_commit_audio(struct drm_device *dev,
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:7512:13: warning: 'amdgpu_dm_commit_planes' defined but not used [-Wunused-function]
 7512 | static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
      |             ^~~~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.o] Error 1
