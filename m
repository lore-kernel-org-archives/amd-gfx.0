Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E20C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 13:48:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 804A210E111;
	Thu,  1 Jun 2023 13:48:04 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8C210E111
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 13:48:02 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-39831cb47c6so260872b6e.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Jun 2023 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685627281; x=1688219281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlJ/lpWBSgTkC0VVeox8vg13xPL7K2r0HDbFlpvqmPg=;
 b=hgL38lrfLxPsXbMXZ1CWuaxT5GpocTjZheGRbzkW2bH03NjKSG5eZZ+yqS9Pmb5d/8
 wnR0AZZjG6U4HpJ7pskcoNomd3WCU3/zwVlhecIwG0WJBlzMTksIJbAL6ZqZTyQZIoJY
 3XCCiKb3tiecNxSqNijprbNURADZF2tU0LfasII0tQltVQ56DVY28TzQQePwfb3C24+Q
 ZSrWjPLH40Zs6vI3SdbIP3DXsGXSeGLOFQnQUOATl0HibSGfdcssvJqI/TnVeBk0DVKO
 hG95ZCiq23LUh9fReejjJGuCZ4ujNm9L6BYZBxDmLlFZjsH342jtDD8sQB38aL91U+Cv
 E5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685627281; x=1688219281;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlJ/lpWBSgTkC0VVeox8vg13xPL7K2r0HDbFlpvqmPg=;
 b=bcEWtdu8YRB/Kqdn7lxP03Coz3S9NtvNALjj0L9M6+I6na67mVaFHWPLeeyYryLTyn
 Udver0oVr+goFEiLSVo5Z++9UbmtvL1omGRXn3f414F0NRvfwWOa5SsUsR84Gblvvi5d
 MxeXRztHIcI8RsG+eyuj3iy8HNKkvw/rOGGRQKh7Umwrc0Z8jCH8fQJHcUmbVqe4/8aW
 P27xVL7XsRG22rq2w8QUtn7uNV5/voMU9cbRzhCqB1JrMOx9wt0CsLnbWR0DATDBIfE7
 kLke0YljcS/ulvaJKLcVYAkIfCe9MDiYSTELXXvxJ5eVi0Jjz6jQjCZ9pkydfF92lYkg
 HyyQ==
X-Gm-Message-State: AC+VfDw3jrJMilPkt/npmSht3DihGEG32B0+0Pd7CVcwj/0gWI8ljwgQ
 pns817E3gZzti373SGsF/CUORNhZUOEnCne24LinxIOv
X-Google-Smtp-Source: ACHHUZ7nuvUV/E8oTIUYCeeoq76zbtTp4oTcAf/XjkmX4jKbybVtFcovAbqRnpXKltCRovGv8cyB3xD0GyoxDytOKQg=
X-Received: by 2002:a05:6808:1988:b0:398:59be:9997 with SMTP id
 bj8-20020a056808198800b0039859be9997mr6046989oib.24.1685627280742; Thu, 01
 Jun 2023 06:48:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230601015905.49427-1-evan.quan@amd.com>
In-Reply-To: <20230601015905.49427-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Jun 2023 09:47:49 -0400
Message-ID: <CADnq5_O_U9oXRwJrfUEFhuT6aidakZWAZm2gwcnU7BPauiKCaw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enable legacy OD support for SMU13
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, May 31, 2023 at 9:59=E2=80=AFPM Evan Quan <evan.quan@amd.com> wrote=
:
>
> Enable the following OD features support for SMU13:
> - Maxinum and minimum gfxclk frequency settings
> - Maxinum and minimum uclk frequency settings
> - Voltage offset settings for gfxclk v/f curve line
>   - This is quite different from previous generations/ASICs. For SMU13,
>     there are six anchor points defined on the v/f curve. And what user
>     configurable are the voltage offsets for those anchor points.
>
> Evan Quan (4):
>   drm/amd/pm: update SMU13 header files for coming OD support
>   drm/amd/pm: fulfill SMU13 OD settings init and restore
>   drm/amd/pm: fulfill the OD support for SMU13.0.0
>   drm/amd/pm: fulfill the OD support for SMU13.0.7
>
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c            |  26 +-
>  .../gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h  |  16 +-
>  .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     |  18 +-
>  .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     |  29 +-
>  .../amd/pm/swsmu/inc/smu_v13_0_7_pptable.h    |  16 +-
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  13 +-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 488 +++++++++++++++++-
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 487 ++++++++++++++++-
>  8 files changed, 1038 insertions(+), 55 deletions(-)
>
> --
> 2.34.1
>
