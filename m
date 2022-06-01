Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5959C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 01:35:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24003112A3D;
	Wed,  1 Jun 2022 01:35:07 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D9D7112A3D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 01:35:06 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id b8so184164edf.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 18:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=0scez/5n/rR8o8CGCCXwKZyFJ888RtC4UHEevKOtFZ0=;
 b=dbdkoRF1EtbQOtOi6QHOuWzVyTlg9D0COzr2KXgJ7rqrwV/U9QHc5IxV8I/N3VASz2
 vSTgcvMlvfeSbey1/HVtgmsBj5i1i7/rf2buZXOFI3nss7hHNSSODLjGuXE+NCi8ehto
 LLEYercMHCVrF3qu3ErtQ1DYW49KV2rsxFW3L+R/1TAzVUntzZmvCcOsKOjT15PITMLx
 +sk79TeEviYtMrEFcJlSbr8IdtRcu7tH2aIX+lX6POXGmyiKtTVccs+1QpKnzhAgCnbz
 keXc2ywhXMh4h+0QkhIqwm+0uBYoSIp1rCJRFA1KbK24MG4cZaJXQMTszXaEXyEkWefU
 mYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=0scez/5n/rR8o8CGCCXwKZyFJ888RtC4UHEevKOtFZ0=;
 b=q0ntIyALIHY+S7/KCGjP0o3jlGMz+Z8xm/YdCy3td0ss8QzUn8tmBS/mDgyZgEjt/M
 VnKGDwDQvMCAAozMl1QK9g3H+46xgFdsTV/jG5xoP1shkYXEEtZrXa7AU+i8OxbR5OMX
 yJFgA/Aixn+65O8lcvqUY1agvaideaoCWqTUb4M8vUodC5K6VlI8U4R5quKO6t1S+sML
 HATvFmaoXsAWlArVW0mxMtiIva0cb93tIw1SMKNOF2dcP/kzAE1tlyJ2STefXprwlYCF
 x9RXTf5pI/kBeX3IwgUtAL7LyujyruD5UcyFB04m3EJm4JxEfk9elV62PFFW8vQXrxHG
 iJwQ==
X-Gm-Message-State: AOAM532l0daGkf4lJO40YDCHwEJ/hbwZwjWsg10wpBl5803tJU4jkHz8
 cwzDCw2Z8pf4KBF5rD6mVnMuW3l6UFHdCLe6I3LTf0oNaOI=
X-Google-Smtp-Source: ABdhPJymBXBoHkD9h/vgiNWfSk1xzH1hCfGCntnR/V2uw0haIYQsC2L+51x98s6RwMOfrDfsN2sJJPruMzGUpjkK87A=
X-Received: by 2002:a05:6402:3514:b0:42d:d4ec:4a35 with SMTP id
 b20-20020a056402351400b0042dd4ec4a35mr12448128edd.62.1654047304476; Tue, 31
 May 2022 18:35:04 -0700 (PDT)
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 1 Jun 2022 11:34:53 +1000
Message-ID: <CAPM=9txG4VUjnt+KuXhGpoTTyZJJEdvL7wkS_58ZQz2EJu8H1Q@mail.gmail.com>
Subject: gcc 12.1.1 warnings around display writeback
To: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Harry Wentland <harry.wentland@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

I recently finally got my build box updated to a modern gcc, and I
started seeing

/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/amd/amdgpu/../display/dc=
/core/dc_stream.c:
In function =E2=80=98dc_stream_remove_writeback=E2=80=99:
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/amd/amdgpu/../display/dc=
/core/dc_stream.c:523:55:
warning: array subscript [0, 0] is outside array bounds of =E2=80=98struct
dc_writeback_info[1]=E2=80=99 [-Warray-bounds]
  523 |                                 stream->writeback_info[j] =3D
stream->writeback_info[i];
      |                                 ~~~~~~~~~~~~~~~~~~~~~~^~~
In file included from
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/amd/amdgpu/../display/dc=
/dc.h:1110,
                 from
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/amd/amdgpu/../display/dc=
/inc/core_types.h:29,
                 from
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/amd/amdgpu/../display/dc=
/basics/dc_common.h:29,
                 from
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/amd/amdgpu/../display/dc=
/core/dc_stream.c:30:
/home/airlied/devel/kernel/dim/src/drivers/gpu/drm/amd/amdgpu/../display/dc=
/dc_stream.h:230:34:
note: while referencing =E2=80=98writeback_info=E2=80=99
  230 |         struct dc_writeback_info writeback_info[MAX_DWB_PIPES];
      |                                  ^~~~~~~~~~~~~~

There's a bunch of code in dc_stream.c to handle multiple writeback
info, but MAX_DWB_PIPES is set to 1, will this ever be increased? can
we rip out the code that assumes it's > 1?

Dave.
