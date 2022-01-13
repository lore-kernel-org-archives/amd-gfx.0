Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B125C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jan 2022 09:44:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88DAA10FF76;
	Thu, 13 Jan 2022 09:44:37 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64A3789D53
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 09:44:36 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 a1-20020a17090a688100b001b3fd52338eso9236329pjd.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jan 2022 01:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p2XMzbBQjwW2hx/1bJAlmu8DNl3VlCTbTmtTvs1HKdQ=;
 b=sgLoGkz01hpZ513v3xEBTJO4YXazIJg9HYz0Ijw0OtM805EuQ6WfiIaPrI2V8bWfU7
 PaFYOmn54dp/Q/8f0CnUKUvjJVfOyUUBHShabNqZouJ9uXwwqulB4R0VjPW1TZVE3M+z
 xs2QLmJTlimxywzjcMvnCi2QwRVroOd9UM3TTYir5WsFzJFL4r87K/QJCqQx+YoFvYv0
 fiLkmjxy6kyB5Ggr0Q/+HU6YGvCyo+XIeY/tew6H+mWAkiRdPCkyw++dV0oBQ5brIx3g
 V8ZQLdNBc39XZnVIT9DFPKmCtnRjxH6qmAXYfcSCHf7xfiQcvUBWfFcONxdMmnkExODZ
 XGyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=p2XMzbBQjwW2hx/1bJAlmu8DNl3VlCTbTmtTvs1HKdQ=;
 b=gWSfKtb8+cKrzrwPBS3wGX0xlZBCU97fVNVu9SWVvb5VU5TkEpoKmLe0Ii34l4J9U/
 OEgAsMQoMnEj/sUCL55UeTAwDfVuryjtWAbdabK0rwsMqbUy7ZazALD2gaN6qSExWEl9
 JIALZPSKtRP+87WQqNBgvk8N/zhwqGd6AJsqOzcIfVAvKNqgxkmXbW42XC935b7fak+c
 xSgVTRcJGro3dLIABL4HaCOF4Fn86nsHVjbja8uX6H90PSe1OnKHxMMC6TjAxbbxymLc
 MXONX9R1Ujf9qOAVa46xTslZj0OWuanLQgzg4WMP1zfiC9ItfMzQEoKg5k6j2QMENKbM
 hYvQ==
X-Gm-Message-State: AOAM533jE7d1GWH+Mh3D1rNQLOxXsC4YXYtx40rOni6ViXh5Xnx1xD7W
 JhV1jPKnzHDZelNDF0Le5ExLRA==
X-Google-Smtp-Source: ABdhPJw9HSf4DIolGlkgj/zyF2Kb7dNrSd+8P16LFtdLMslnsz37xKEfwmB+QwE5Eps5KmyIYR3/XA==
X-Received: by 2002:a17:902:9693:b0:149:1ce6:c284 with SMTP id
 n19-20020a170902969300b001491ce6c284mr3900970plp.119.1642067075969; 
 Thu, 13 Jan 2022 01:44:35 -0800 (PST)
Received: from aqua.hq.igel.co.jp (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id rm4sm2207154pjb.4.2022.01.13.01.44.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jan 2022 01:44:35 -0800 (PST)
From: Tomohito Esaki <etom@igel.co.jp>
To: dri-devel@lists.freedesktop.org
Subject: [RFC PATCH v2 0/3] Add support modifiers for drivers whose planes
 only support linear layout
Date: Thu, 13 Jan 2022 18:44:16 +0900
Message-Id: <20220113094419.12433-1-etom@igel.co.jp>
X-Mailer: git-send-email 2.25.1
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
Cc: David Airlie <airlied@linux.ie>, nouveau@lists.freedesktop.org,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <mdaenzer@redhat.com>,
 Daniel Stone <daniel@fooishbar.org>, Lee Jones <lee.jones@linaro.org>,
 Tomohito Esaki <etom@igel.co.jp>, Rob Clark <robdclark@chromium.org>,
 Evan Quan <evan.quan@amd.com>, amd-gfx@lists.freedesktop.org,
 Ben Skeggs <bskeggs@redhat.com>, Petr Mladek <pmladek@suse.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Abhinav Kumar <abhinavk@codeaurora.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Takanari Hayama <taki@igel.co.jp>, Sean Paul <seanpaul@chromium.org>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mark Yacoub <markyacoub@chromium.org>, Qingqing Zhuo <qingqing.zhuo@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, linux-kernel@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>, Simon Ser <contact@emersion.fr>,
 Alex Deucher <alexander.deucher@amd.com>,
 Damian Hobson-Garcia <dhobsong@igel.co.jp>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Some drivers whose planes only support linear layout fb do not support format
modifiers.
These drivers should support modifiers, however the DRM core should handle this
rather than open-coding in every driver.

In this patch series, these drivers expose format modifiers based on the
following suggestion[1].

On Thu, Nov 18, 2021 at 01:02:11PM +0000, Daniel Stone wrote:
> I think the best way forward here is:
>   - add a new mode_config.cannot_support_modifiers flag, and enable
> this in radeon (plus any other drivers in the same boat)
>   - change drm_universal_plane_init() to advertise the LINEAR modifier
> when NULL is passed as the modifier list (including installing a
> default .format_mod_supported hook)
>   - remove the mode_config.allow_fb_modifiers hook and always
> advertise modifier support, unless
> mode_config.cannot_support_modifiers is set


[1] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20190509054518.10781-1-etom@igel.co.jp/#24602575


v2:
* rebase to the latest master branch (5.16.0+) + "drm/plane: Make format_mod_supported truly optional" patch [2]
  [2] https://patchwork.freedesktop.org/patch/467940/?series=98255&rev=3

v1: https://www.spinics.net/lists/dri-devel/msg327352.html
* The initial patch set


Tomohito Esaki (3):
  drm: add support modifiers for drivers whose planes only support
    linear layout
  drm: set fb_modifiers_not_supported flag in legacy drivers
  drm: replace allow_fb_modifiers with fb_modifiers_not_supported

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  6 ++---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v11_0.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         |  2 ++
 drivers/gpu/drm/drm_framebuffer.c             |  6 ++---
 drivers/gpu/drm/drm_ioctl.c                   |  2 +-
 drivers/gpu/drm/drm_plane.c                   | 22 +++++++++----------
 drivers/gpu/drm/nouveau/nouveau_display.c     |  6 +++--
 drivers/gpu/drm/radeon/radeon_display.c       |  2 ++
 .../gpu/drm/selftests/test-drm_framebuffer.c  |  1 -
 include/drm/drm_mode_config.h                 | 18 +++++----------
 include/drm/drm_plane.h                       |  3 +++
 13 files changed, 40 insertions(+), 33 deletions(-)

-- 
2.25.1

