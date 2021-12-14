Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A5AC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Dec 2021 19:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FF1910E150;
	Tue, 14 Dec 2021 19:22:09 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC4D510E150
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 19:22:08 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 h19-20020a9d3e53000000b0056547b797b2so22012342otg.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Dec 2021 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9yLYDwGx5cg1ntky6MqjaHTJ+/4qss8QGpdcFwkthKk=;
 b=OyoK+02PlCZX6XlJjNmNZqCTRxarLsNJBXiyftLt5nBAr1pw4dXDJMdhgIELyqvRzX
 DWvsMC8PBdSp6+84tPYRWeacv+DZjtKIByr4ZRdJuWpQqu3GOVHkWUUkuTNq5eifq6uT
 cSo5As3kNwMgY6s9gjbcUk++0te2sDT4UpQn8y+YqvRmzfOS9xiGjJJ/+AmON7jBQre1
 7y4048RBZqhoLN2MqU4YEYD3zOyr9Ah+6J1nzT50oEE86kZ+8MgiU4NY+Z0O8KgxxCgz
 ne5HPdsBAr3uF+J3UpWLPqQEYIciRegfJB1uSykmdbmcC+b8pluRaKgMi339y+poTBIP
 piNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9yLYDwGx5cg1ntky6MqjaHTJ+/4qss8QGpdcFwkthKk=;
 b=yf4OdyjmnivbUcDD0zBsYBmDc09wcbgHlOzJ3uiRexnjq7S8kbXS/vJYD5VKs4JdDW
 OMVnDPSWf+sMDkNcOWpJPY3dc+30UAv6gIwGsoEIiYWawyd7euZdkK/0IxxNai8LIH9e
 CrYoH36x6lwTBqkXEzp8/x3JV4Ew0yh2hXOpPL3MX2eOs0uNx/FXNE64HYNaUTnnZzXO
 sQO+iUpjAO88X40/nJKiisozRqom5OANNs53WESO6EPEOh2n4gorYYHQT/i8ysYmezua
 +4zRMGlvsxnUTigEK+VEEwSzyrklmQwgEwR8xJW2w//Y12mVAHHdZ/6xo8PMOkwxv3gb
 Qd4Q==
X-Gm-Message-State: AOAM533Xw/ivnoEHGOGAXIlpXcJhzuX2FLnmadbZgOSYP5mruY5ACclH
 5WETED+VORFcQ7lCngvQIVRtnwjD+XisNK14xQt+g3iF
X-Google-Smtp-Source: ABdhPJy5U8ShA6A8T2UdYV4soDwnZEFxnsVVCvAPqLjBAiCU8aWLy2PA0B1Ma4odPJoR+NRUXKdi38oG13Ho0yJpWlI=
X-Received: by 2002:a9d:67c1:: with SMTP id c1mr5907475otn.299.1639509728008; 
 Tue, 14 Dec 2021 11:22:08 -0800 (PST)
MIME-Version: 1.0
References: <20211213233030.6719-1-ydirson@free.fr>
In-Reply-To: <20211213233030.6719-1-ydirson@free.fr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 14 Dec 2021 14:21:56 -0500
Message-ID: <CADnq5_Mn+WeLWNoe6FdN=4Ssbfi2v6o=XorQrzwxdda2Hgk7mg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Enrich amdgpu docs from recent threads
To: Yann Dirson <ydirson@free.fr>
Content-Type: text/plain; charset="UTF-8"
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
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Dec 13, 2021 at 6:30 PM Yann Dirson <ydirson@free.fr> wrote:
>
> This series is basically bringing Alex' descriptions of the hardware and
> driver internals into the doc.
>
> Changes in v3:
> * camel case in titles (Rodrigo Siqueira)
> * link DCN description to DC doc (Rodrigo Siqueira)
> * links to email archive in commit messages (Rodrigo Siqueira)
> * acronym expansion in intro (Rodrigo Siqueira)
> * new commits for kerneldoc content fixes
>
> Changes in v2:
> * fix typos (Harry Wentland)
> * get rid of double headings
>
> Yann Dirson (4):
>   Documentation/gpu: include description of AMDGPU hardware structure
>   Documentation/gpu: include description of some of the GC
>     microcontrollers
>   amdgpu: fix some kernel-doc markup
>   amdgpu: fix some comment typos
>
>  Documentation/gpu/amdgpu/display/index.rst    |   2 +
>  Documentation/gpu/amdgpu/driver-core.rst      | 117 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |   6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c            |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +-
>  include/uapi/drm/amdgpu_drm.h                 |   2 +-
>  8 files changed, 128 insertions(+), 9 deletions(-)
>
> --
> 2.31.1
>
