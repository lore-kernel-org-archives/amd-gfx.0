Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D777EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Dec 2021 22:15:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276996E106;
	Mon,  6 Dec 2021 22:15:24 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1FB16E106
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Dec 2021 22:15:22 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id s139so24040012oie.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Dec 2021 14:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pWTixaxm4mR1CEL/LwTeTj32eijM/LG6T194lqxv5NY=;
 b=iEmOQAJRuqBXhOpHXX/R7UCy24aToWr3ttgsIbhvCRtYgj+o3au3kbzveMKAEMiZpq
 hnTvblJQXI7uuEM+YliJid8wV/u86QFQryg8OWxX0i3raYb7YWihOiHA4fjwUhT8lyRl
 BCjqi5zKepbbYnqjUHUhW3cYitSocH0IDo2e1WQhCzpzcs9KlP/eLUGLVkY3MXno1VvZ
 LcBYhTVTsD3GTn1oKNdIBsO4PtFvKtIY13wOySqMqhZTKuUPxkGHU9+zgHYNNTifPJgG
 AH6pfiQkYjZO9/LB5fI57+al5LHgVWzLlSzvElveFWsD2sq5lmO+nomSOWpGW2CdibLx
 tzhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pWTixaxm4mR1CEL/LwTeTj32eijM/LG6T194lqxv5NY=;
 b=whZpigwAV4R9+M+HUKGz1JhYdyCRbQXHLAO55QSLX9u8RuNWGB0THZar4K8TGVR+4M
 NitW2sIXUr8UuxGYKT9b/KT8WB6mI9CfutVQBJpr2WUNB8F0iQICb5SrZXj4ZvVXKo3G
 w+cKdodi89/f8Xbzf48CWlEq5irOvAynkq6N0RmWnhMLe6E/HxcU8XuZeT+DlmW5H3F3
 oio17OoxST1iJ16lkYHqnMxbDRhhFTGGTjYdqzx15y3qaOWIls7puZb7tqowPEJSXLRO
 RsVesXiB8wQhJI1+hPi8HSwjTjWeI4ugGuCwL55ilarSLQEvMl8Mvv/jdg43BiO7q0yW
 YkTg==
X-Gm-Message-State: AOAM533EJKdV0UZkPxJhuY82Ug5HRvs4H7jWfKfauK+Kjv7zwPnTuXaR
 SnW91gP6RBMLAenEzGzbTypz4QxIuujsMn4+QGY=
X-Google-Smtp-Source: ABdhPJwVGOvpBA23tSyqVsutpIo3ddDlz0qsWOYH+Zh5u+UGCQQBxT7Yi+1/+YG3bLfCxUykPzvk4AANGKbIHJ1sYvE=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr1523788oib.120.1638828922085; 
 Mon, 06 Dec 2021 14:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20211017113500.7033-1-cssk@net-c.es>
 <4217d1f5-e189-e3a5-547a-9ae205c3d539@amd.com>
 <YatMeIUyVJnoT3JG@gineta.localdomain>
In-Reply-To: <YatMeIUyVJnoT3JG@gineta.localdomain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Dec 2021 17:15:11 -0500
Message-ID: <CADnq5_MVpupUnkHrb9xFZOvVR9qVhUob06jsC72CUW_xY4nbuA@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/amdgpu replace drm_detect_hdmi_monitor() with
 drm_display_info.is_hdmi
To: Claudio Suarez <cssk@net-c.es>
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Do you have push rights to drm-misc?  IIRC, these patches depend on
the is_hdmi changes that recently went into drm-misc, so these patches
should probably go upstream via drm-misc rather than amdgpu.

Alex

On Mon, Dec 6, 2021 at 5:21 AM Claudio Suarez <cssk@net-c.es> wrote:
>
>
> Hello,
>
> These patches
>
> https://www.mail-archive.com/amd-gfx@lists.freedesktop.org/msg69247.html
>
> are not uploaded to the linux source. I suppose I have to ping here.
>
> Best regards,
> Claudio Suarez.
>
>
>
>
> On Mon, Oct 18, 2021 at 09:37:13AM -0400, Harry Wentland wrote:
> > On 2021-10-17 07:34, Claudio Suarez wrote:
> > >
> > > From the TODO list Documentation/gpu/todo.rst
> > > -----------------------
> > > Once EDID is parsed, the monitor HDMI support information is available through
> > > drm_display_info.is_hdmi. Many drivers still call drm_detect_hdmi_monitor() to
> > > retrieve the same information, which is less efficient.
> > >
> > > Audit each individual driver calling drm_detect_hdmi_monitor() and switch to
> > > drm_display_info.is_hdmi if applicable.
> > > -----------------------
> > > The task is divided in three small patches. The last patch depends on the
> > > first one.
> > >
> >
> > Thanks.
> >
> > This series is
> > Reviewed-by: Harry Wentland <harry.wentland@amd.com>
> >
> > Harry
> >
> > >
> > >
> > > Claudio Suarez (3):
> > >   drm/amdgpu: update drm_display_info correctly when the edid is read
> > >   drm/amdgpu: use drm_edid_get_monitor_name() instead of duplicating the
> > >     code
> > >   drm/amdgpu: replace drm_detect_hdmi_monitor() with
> > >     drm_display_info.is_hdmi
> > >
> > >  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 17 +++++----
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_encoders.c  |  4 +-
> > >  .../gpu/drm/amd/amdgpu/atombios_encoders.c    |  6 +--
> > >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  3 +-
> > >  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 37 +++++--------------
> > >  drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
> > >  drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  2 +-
> > >  8 files changed, 29 insertions(+), 44 deletions(-)
> > >
> >
>
>
