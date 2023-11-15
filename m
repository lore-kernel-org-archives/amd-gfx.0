Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8102DC072A2
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Nov 2023 18:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E790410E129;
	Wed, 15 Nov 2023 18:10:45 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 444D310E126
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 18:10:44 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-6d64d8ce2c3so1066459a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Nov 2023 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700071843; x=1700676643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvVSilkTlmHKx1H7XRvFa1ycfaLcXw/q2OAB52G/jaE=;
 b=NA8dypWUEtbMz9kXW/DYLUZcpeVSNHkn6pjpLbYF16ye8foXZyGgeMs8W6Nsn9J9fz
 4GVHzmLD/KQgE+74V++2NqbyU8gRuWcIHqqQ9MxqPK3HZFaPcURmOLdT/3nCmOv+DCNN
 tjb2yu3bc/EexBbHMtZcAzkqUCskoGe+vyXEJB22NLkvtVPtASqi1eJxcBiGtR5SwQLP
 b2e+lxmj3MjsGHepAgjbp8j6P8SeGEhQaZttTxtPJDlMXwnS5zyjbDM9/2Ez1ZPERGLZ
 klskQIaHj0NqHMvuAl28Qg32Q7cvghm8cJK2RQw0e70k8Rnpr313VTRXYzbOJjwqJv1H
 nYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700071843; x=1700676643;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QvVSilkTlmHKx1H7XRvFa1ycfaLcXw/q2OAB52G/jaE=;
 b=BnvWO/dlypTi4ipvWhjO9wHBJxPW+yMzVD+shyZocKQZHb40miI48vnkbkWAtVWcvk
 r6CaJM9lLsW5buwH2SkNDKqQkki4OOyIvsQfrKNmOHTDQpNBS0lTMvZgbH6JDIXejJTv
 vkXk6+UkVZvSg3+N7bpxmx2hfQ0zYvui0MhbtzZM8lqnD20FJ8dRHjD3YzaZu64aTHjw
 4YTGZ5xwOGeRVRTmb47BvJeNqAgR5Ib1mn3tAHkuZuNuSEfrrWxXHVg7lSkJSVL0sIz+
 askUyynejLumWPkXz4eNBccbvmWoHwvsUAURh2CGLrqOhL0WSUoC/ahrAdfC9XLWgsCP
 KkeQ==
X-Gm-Message-State: AOJu0YzjiZ2rbQ7PFHFm/fWj8S/Iv6ij4RrfS4A9GfFGwxC5SQ+w0hs4
 wvopJsOYBHvlBwY274ln5sdGe/1QGe/s4a1Y5l8=
X-Google-Smtp-Source: AGHT+IE6PRuYzCSXcmeLGmx7kvaOAPrGi8m1Y1cQtZMC16aZEPjLnYO6nijHZ0Vn8Xz/EMHx682T/JqVNTRsg0wvdnc=
X-Received: by 2002:a05:6830:a84:b0:6b9:db20:4d25 with SMTP id
 n4-20020a0568300a8400b006b9db204d25mr6821491otu.1.1700071843389; Wed, 15 Nov
 2023 10:10:43 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNRb0QbF2pKLJMDhVOKxyGD6-E+8p-4QO6FOWa6zp22_A@mail.gmail.com>
 <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
In-Reply-To: <CABXGCsOqbLRHSkiz79NkVQ-wUtR7y-ZFHvhMw0+JJ_cY2AZmSw@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 15 Nov 2023 23:10:32 +0500
Message-ID: <CABXGCsPE9=Qp3Jg5hkRsTQoNgODnS_cXFU1d+hg3Baob40AaAA@mail.gmail.com>
Subject: Re: regression/bisected/6.7rc1: Instead of desktop I see a horizontal
 flashing bar with a picture of the desktop background on white screen
To: alvin.lee2@amd.com, hersenxs.wu@amd.com, daniel.wheeler@amd.com, 
 "Deucher, Alexander" <alexander.deucher@amd.com>, 
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Tue, Nov 14, 2023 at 11:03=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Tue, Nov 14, 2023 at 3:55=E2=80=AFPM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > Hi,
> > Yesterday came the 6.7-rc1 kernel.
> > And surprisingly it turned out it is not working with my LG C3.
> > I use this OLED TV as my primary monitor.
> > After login to GNOME I see a horizontal flashing bar with a picture of
> > the desktop background on white screen.
> > Demonstration: https://youtu.be/7F76VfRkrVo
> >
> > I made a bisection.
> > And bisect said that the first bad commit is:
> > commit ed6e2782e9747508888f671e1101250bb19045be
> > Author: Alvin Lee <alvin.lee2@amd.com>
> > Date:   Mon Oct 23 14:33:16 2023 -0400
> >
> >     drm/amd/display: For cursor P-State allow for SubVP
> >
> >     [Description]
> >     - Similar to FPO, SubVP should also force cursor P-State
> >       allow instead of relying on natural assertion
> >     - Implement code path to force and unforce cursor P-State
> >       allow for SubVP
> >
> >     Reviewed-by: Samson Tam <samson.tam@amd.com>
> >     Acked-by: Hersen Wu <hersenxs.wu@amd.com>
> >     Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
> >     Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >
> >  drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c | 17 ++-------=
--------
> >  1 file changed, 2 insertions(+), 15 deletions(-)
> >
> > My hardware specs: https://linux-hardware.org/?probe=3D1c989dab38
> >
> > --
> > Best Regards,
> > Mike Gavrilov.
>
> I forgot kernel logs. Not sure it would be helpful because I didn't
> notice anything unusual.
>

This only appears on 7900XTX and 120Hz.

--=20
Best Regards,
Mike Gavrilov.
