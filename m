Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4673C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 20:53:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A8CB10E62C;
	Wed,  2 Nov 2022 20:53:38 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36B0210E63A
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 20:53:33 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-13b6c1c89bdso21611469fac.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Nov 2022 13:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rzv51xjwe/4pMW0GFnN45oROhk9IP7rHWqLvdqnWNbA=;
 b=cKAFO6NkPVFlzTVNHOjy5tjFIXQi+9anBHqsy/eHmqUPS8QB7+76nWuuykaeiyaA6Y
 05LjSOpMFsY8aK8Az6x7YaH8GfQWOajRWRkF+wEz1Z2EdC+ApDlgmRmJxA+QYfOiz9k5
 cmjchXuKhVMzqhTIZXGapZy3tym/RNZ+qQv8kz5dJXkOOahvw8y0f3Z66YGZPnDoTAbI
 jwkQTql5iHfTz3ZFEYvmFQqzzDhmE4dOnUFkgYj9VqKPigTmMfZGaMbRNf+0G1w4OObH
 CQuAH17H3kBda0zRXV4/JXy3gnB4qU08gCTWCm+0Ww6KlMSj30KkjpaNuKXLSkfQRCQN
 knQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rzv51xjwe/4pMW0GFnN45oROhk9IP7rHWqLvdqnWNbA=;
 b=ZEaIpMNG36LKshKmF+Lb3PI+hX/Z0iURAM5/H1smMtB5bdVujYGekE2tIBKtIQ95mz
 /jp/YwVw3DZ+l2ozlUxk/GgH0rZJ23/KsE/sriT5tRWwPQbMJJHe7VimayAtVnXYo4Wo
 zhPCTJK6HaVNUGZPe073L3xWioY481Xdo8f0PufIhZ8Lyd98GEUFo104S/IJD+FnkF9i
 xaY8+WkeGXfXFmHSe8QHCxucys+8+YGv3vWGuMm6I3l1ePNuEYd1fRdmVugjxag61XJL
 d6m1kwEgVxsF7w2XAtCXEQz72kePi4nvMlX9tHf04N+suW4/gai29qeJBBJmlAgT+Ug5
 1AfA==
X-Gm-Message-State: ACrzQf26v7v/UvYosZZAwA87TX+v+zl4SflA4lGNRtZ1Whhd+0MC7xwj
 wYYLe5/lBM9Fy/NbMwjgGzQcjRceoG6SVO8r/vQ=
X-Google-Smtp-Source: AMsMyM5Aq7+xJHT73wJq/SWEK13U2XCiU218RoBih30L6l/1jmBjbNCN9aLzqfpiWZ95RcMf3x0IJxhTR8K02wkPWZ4=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr16071727oao.96.1667422412344; Wed, 02
 Nov 2022 13:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221020154702.503934-24-Rodrigo.Siqueira@amd.com>
 <291a5ef1-d20b-43b2-9baa-9f1a5e75cc5b@amd.com>
In-Reply-To: <291a5ef1-d20b-43b2-9baa-9f1a5e75cc5b@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Nov 2022 16:53:20 -0400
Message-ID: <CADnq5_O90kkpHEKxaedBDge2h2B8f0D3MBDqvr2Wctwy3MRUvg@mail.gmail.com>
Subject: Re: [23/33] drm/amd/display: cursor update command incomplete
To: "Limonciello, Mario" <mario.limonciello@amd.com>
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
Cc: stylon.wang@amd.com, timur.kristof@gmail.com, Leo Li <Sunpeng.Li@amd.com>,
 Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, Max Tseng <max.tseng@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, agustin.gutierrez@amd.com,
 wayne.lin@amd.com, Alexander Deucher <Alexander.Deucher@amd.com>,
 Harry.Wentland@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 1, 2022 at 3:27 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 10/20/2022 10:46, Rodrigo Siqueira wrote:
> > From: Max Tseng <max.tseng@amd.com>
> >
> > Missing send cursor_rect width & Height into DMUB. PSR-SU would use
> > these information. But missing these assignment in last refactor commit
> >
> > Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
> > Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> > Signed-off-by: Max Tseng <max.tseng@amd.com>
> > ---
>
> This was reported to help fix a PSR-SU hang found in 6.1-rc1 and later.
>
> Reported-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2227
> Fixes: b73353f7f3d4 ("drm/amd/display: Use the same cursor info across
> features")
>
> Alex,
>
> Can you please queue this for a future fixes PR for 6.1?

Yes, queued up.

Alex

>
> Thanks,
>
> >   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > index 4996d2810edb..938dba5249d4 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hubp.c
> > @@ -623,6 +623,10 @@ void hubp2_cursor_set_attributes(
> >       hubp->att.size.bits.width    =3D attr->width;
> >       hubp->att.size.bits.height   =3D attr->height;
> >       hubp->att.cur_ctl.bits.mode  =3D attr->color_format;
> > +
> > +     hubp->cur_rect.w =3D attr->width;
> > +     hubp->cur_rect.h =3D attr->height;
> > +
> >       hubp->att.cur_ctl.bits.pitch =3D hw_pitch;
> >       hubp->att.cur_ctl.bits.line_per_chunk =3D lpc;
> >       hubp->att.cur_ctl.bits.cur_2x_magnify =3D attr->attribute_flags.b=
its.ENABLE_MAGNIFICATION;
>
