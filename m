Return-Path: <SRS0=UmUD=E5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDEBC2D0E4
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 19:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FDCE20717
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2020 19:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mr+WE8N5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FDCE20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1236489EFF;
	Mon, 23 Nov 2020 19:50:21 +0000 (UTC)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8E2A89EFF
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 19:50:19 +0000 (UTC)
Received: by mail-pl1-x643.google.com with SMTP id p6so6996175plr.7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 11:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m3hTZEfpLLFOrL6r9X2Jw2evELszM9ku65E0lN63gv4=;
 b=mr+WE8N5E/Mkzwz0sSJJJBrjsgKtZnbO60lnEaQ4Ei2UKFSrEVwnPYRKxpNpt2h5Ir
 s6A5+PGgdEwrbYYHCHjHa2HQ3usO/yr/C0SMrGc0n9yJswk5u62ZHwUh0JKLBeUv2X8v
 bKDpJ5LtVJXj1r/AVySkTuIz7Pix7qdKuxG8NRO1axP2zPM93AvRKbQBFssrLTcOdw3j
 1b47J6fCXQXenLy/sykYR24SaW/DqJVo7aq5BYpZFAxZUDtRPKoxIZjT7vjwJJrhgjcv
 G1H41TtlBAfCdS+iXejyuUZR3gF9MoZoyEjrFdngIs6Ar62ZFwO1fboP71lJw9yZyLg3
 1Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m3hTZEfpLLFOrL6r9X2Jw2evELszM9ku65E0lN63gv4=;
 b=HB+DjTdnIS5drC5AWwBb6UGCxv5X/yUgXGIUP/dZacqkavez0prH3jL5/v0WE74NfK
 m5YtbKichg7wIzCOyIhjLtH5XcZZUd1WdOMsqDgZt8DgbWO8tviN/v+rkLlgekpkCZUR
 27AwLyyfiKlWmsUVpDJc4a1UARm+Qw5mvfCLPrnBefBDJkvc7CsoyhMNvYU0ctz9A34N
 Ko1WTQe8xpLiLtZr1TVQL/RAqKgAdlJ06jPG22e1N1SAcwwd0DDmQ+ZyX41t9KQcnfm1
 VA2deM1k17my9S4+KsOmW40makz2Yb+WlSMcK4Kq7MchuCCwFfl3g84oXT2ENALe1W3p
 fSCA==
X-Gm-Message-State: AOAM530BfVw2DMWf/quYkCidfXda86ilkYJ8QglDOajVAH53xungCVNe
 eL2zO2XiAUq+Bf40ypuVFDdIQ01bwn1Rk6fEZMY=
X-Google-Smtp-Source: ABdhPJyMy79TF9hnTeSapxOwS9nJGp+fjYn4LFTSIFs1LNty2RqfmppZMj4gSXYFftmd7GWI67v8dElSr1TC5mBH58g=
X-Received: by 2002:a17:902:6b04:b029:d8:d392:7791 with SMTP id
 o4-20020a1709026b04b02900d8d3927791mr879292plk.47.1606161019499; Mon, 23 Nov
 2020 11:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20201118132039.2336-1-christian.koenig@amd.com>
 <1a20a665-f859-6ed3-be98-48cb5b9fcf37@gmail.com>
In-Reply-To: <1a20a665-f859-6ed3-be98-48cb5b9fcf37@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 23 Nov 2020 14:49:43 -0500
Message-ID: <CAAxE2A5BLn0ygJc6nx5QPW1qWq6hpvQbzFm51pzan+jhe_BWWw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: unpack dma_fence_chain containers during sync
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
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
Cc: Pierre-Eric Pelloux-Prayer <Pierre-eric.Pelloux-prayer@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0820339194=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0820339194==
Content-Type: multipart/alternative; boundary="00000000000004f7d005b4cb81ba"

--00000000000004f7d005b4cb81ba
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

What is the behavior we should expect?

Marek

On Mon, Nov 23, 2020 at 7:31 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Ping, Pierre/Marek does this change works as expected?
>
> Regards,
> Christian.
>
> Am 18.11.20 um 14:20 schrieb Christian K=C3=B6nig:
> > This allows for optimizing the CPU round trip away.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27 +++++++++++++++++++++++=
+
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
> >   3 files changed, 29 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > index 79342976fa76..68f9a4adf5d2 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1014,7 +1014,7 @@ static int
> amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser *p,
> >               return r;
> >       }
> >
> > -     r =3D amdgpu_sync_fence(&p->job->sync, fence);
> > +     r =3D amdgpu_sync_fence_chain(&p->job->sync, fence);
> >       dma_fence_put(fence);
> >
> >       return r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> > index 8ea6c49529e7..d0d64af06f54 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
> > @@ -28,6 +28,8 @@
> >    *    Christian K=C3=B6nig <christian.koenig@amd.com>
> >    */
> >
> > +#include <linux/dma-fence-chain.h>
> > +
> >   #include "amdgpu.h"
> >   #include "amdgpu_trace.h"
> >   #include "amdgpu_amdkfd.h"
> > @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync,
> struct dma_fence *f)
> >       return 0;
> >   }
> >
> > +/**
> > + * amdgpu_sync_fence_chain - unpack dma_fence_chain and sync
> > + *
> > + * @sync: sync object to add fence to
> > + * @f: potential dma_fence_chain to sync to.
> > + *
> > + * Add the fences inside the chain to the sync object.
> > + */
> > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync, struct dma_fence
> *f)
> > +{
> > +     int r;
> > +
> > +     dma_fence_chain_for_each(f, f) {
> > +             if (dma_fence_is_signaled(f))
> > +                     continue;
> > +
> > +             r =3D amdgpu_sync_fence(sync, f);
> > +             if (r) {
> > +                     dma_fence_put(f);
> > +                     return r;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> >   /**
> >    * amdgpu_sync_vm_fence - remember to sync to this VM fence
> >    *
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> > index 7c0fe20c470d..b142175b65b6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
> > @@ -48,6 +48,7 @@ struct amdgpu_sync {
> >
> >   void amdgpu_sync_create(struct amdgpu_sync *sync);
> >   int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f);
> > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync, struct dma_fence
> *f);
> >   int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence
> *fence);
> >   int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync
> *sync,
> >                    struct dma_resv *resv, enum amdgpu_sync_mode mode,
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000004f7d005b4cb81ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>What is the behavior we should expect?</div><div><br>=
</div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, Nov 23, 2020 at 7:31 AM Christian K=C3=B6=
nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtz=
umerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Ping, Pierre/Marek does this change works as expected?<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 18.11.20 um 14:20 schrieb Christian K=C3=B6nig:<br>
&gt; This allows for optimizing the CPU round trip away.<br>
&gt;<br>
&gt; Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.ko=
enig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=A0|=C2=A0=
 2 +-<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27 ++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |=C2=A0 1 +<br>
&gt;=C2=A0 =C2=A03 files changed, 29 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cs.c<br>
&gt; index 79342976fa76..68f9a4adf5d2 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -1014,7 +1014,7 @@ static int amdgpu_syncobj_lookup_and_add_to_sync=
(struct amdgpu_cs_parser *p,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_fence(&amp;p-&gt;job-&gt;sync, =
fence);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_fence_chain(&amp;p-&gt;job-&gt;=
sync, fence);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sync.c<br>
&gt; index 8ea6c49529e7..d0d64af06f54 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
&gt; @@ -28,6 +28,8 @@<br>
&gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 Christian K=C3=B6nig &lt;<a href=3D"mailto=
:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&g=
t;<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#include &lt;linux/dma-fence-chain.h&gt;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#include &quot;amdgpu.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;amdgpu_trace.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;amdgpu_amdkfd.h&quot;<br>
&gt; @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, s=
truct dma_fence *f)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +/**<br>
&gt; + * amdgpu_sync_fence_chain - unpack dma_fence_chain and sync<br>
&gt; + *<br>
&gt; + * @sync: sync object to add fence to<br>
&gt; + * @f: potential dma_fence_chain to sync to.<br>
&gt; + *<br>
&gt; + * Add the fences inside the chain to the sync object.<br>
&gt; + */<br>
&gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync, struct dma_fenc=
e *f)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0int r;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0dma_fence_chain_for_each(f, f) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dma_fence_is_sign=
aled(f))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0continue;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_fen=
ce(sync, f);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0dma_fence_put(f);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0return r;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0/**<br>
&gt;=C2=A0 =C2=A0 * amdgpu_sync_vm_fence - remember to sync to this VM fenc=
e<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_sync.h<br>
&gt; index 7c0fe20c470d..b142175b65b6 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
&gt; @@ -48,6 +48,7 @@ struct amdgpu_sync {<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void amdgpu_sync_create(struct amdgpu_sync *sync);<br>
&gt;=C2=A0 =C2=A0int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma=
_fence *f);<br>
&gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync, struct dma_fenc=
e *f);<br>
&gt;=C2=A0 =C2=A0int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct =
dma_fence *fence);<br>
&gt;=C2=A0 =C2=A0int amdgpu_sync_resv(struct amdgpu_device *adev, struct am=
dgpu_sync *sync,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s=
truct dma_resv *resv, enum amdgpu_sync_mode mode,<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--00000000000004f7d005b4cb81ba--

--===============0820339194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0820339194==--
