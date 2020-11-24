Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D4FC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 02:10:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7A3206E0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 02:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IB+emShT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7A3206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E74F06E17D;
	Tue, 24 Nov 2020 02:10:11 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A25A6E17D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2020 02:10:11 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id x24so4626538pfn.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 18:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0N7dKkQuqZCdHHiiRWfSSRpQD0pZXsSBdS8pXpxUcJo=;
 b=IB+emShTc5mR9Nn5RJ4pBGHBPzXbvmg0wL2e/Dalx/sItXZZS/Ov18pUFvyXuqI6n5
 dl7lwOb2fsKMXzKlS0OKReeu1giCPh8cVRrIA8k+m1Ht/5A4jeqpX3Db5TmOZY0QGyZd
 EyXL9wmDxXIBbeUemfFedE5zia2R7h5pjIr8MwQ7yS44PT+V5O0t9AUqyoahZ03v33Ox
 w4rKb9pt3MpmCXomSjP2+L4sEdzffxt190ORK8/VBJHTOWCFWARIS0ozSStK16hA5n/W
 xGiU3KELHgj9SSPe72zLcEYU8rakO8JtzlM3FRTzo2O07IUJiB+PD8S8f7CWdGRdNqLw
 DdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0N7dKkQuqZCdHHiiRWfSSRpQD0pZXsSBdS8pXpxUcJo=;
 b=BIPmxbka6h51xju64OQCsmzaKjCqvwrbKiI/T3l4War6/7Sc3jtAqDWK0n36c+uLvP
 Vh3RgAxi+dtsBlcsLvEvXVUOrD/bGWsVUyWqf85sTFyN0dMxE/nYeCFGzaxOZ00L6LcF
 95J9SgxHrPAiWqhULT7VvZrT/mmJbEGGKtmXy1wPmEHwNk2uIURgohhpXGYAto2bOj7f
 77lslGtqqyhFQBn68oByQB3GIw4XzkZLuO90J2UG535giYChgQSrJNKN90xlRm2IsFQM
 4sewpHJh4rlltmvpK0MaoQ/bku6MJIa98e0Ub84rZDIWdK3gM0hZiHSe7iZmnI4NYExa
 34kg==
X-Gm-Message-State: AOAM530HXvAbvKt+vcjlnxwmBzloRX2i0r3rVDOulxioEy6mtCHGmSeq
 /oztJ+qIUCR8BJrlOizZT13gcrBf3EF8AHtDz0WOpR53huI=
X-Google-Smtp-Source: ABdhPJy/Zp3A6maUMJFVZs359QwqjHCyRty0L790zrcduGXu/feY47iP93yD3SV31hbj/o6XwJnnEIPpkGKCWbe5yN8=
X-Received: by 2002:a63:d312:: with SMTP id b18mr1914099pgg.233.1606183810637; 
 Mon, 23 Nov 2020 18:10:10 -0800 (PST)
MIME-Version: 1.0
References: <20201118132039.2336-1-christian.koenig@amd.com>
 <1a20a665-f859-6ed3-be98-48cb5b9fcf37@gmail.com>
 <CAAxE2A5BLn0ygJc6nx5QPW1qWq6hpvQbzFm51pzan+jhe_BWWw@mail.gmail.com>
 <53b5d31f-e533-0fb3-0907-76d2f3730af3@gmail.com>
In-Reply-To: <53b5d31f-e533-0fb3-0907-76d2f3730af3@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Mon, 23 Nov 2020 21:09:34 -0500
Message-ID: <CAAxE2A4MThFV0Whms5QGHmXNhhw-9++naxWV0n=HqinJAOupSw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: unpack dma_fence_chain containers during sync
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
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
Content-Type: multipart/mixed; boundary="===============1218029218=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1218029218==
Content-Type: multipart/alternative; boundary="0000000000007a250405b4d0cfc7"

--0000000000007a250405b4d0cfc7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pierre-Loup, does this do what you requested?

Thanks,
Marek

On Mon, Nov 23, 2020 at 3:17 PM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> That the CPU round trip is gone now.
>
> Christian.
>
> Am 23.11.20 um 20:49 schrieb Marek Ol=C5=A1=C3=A1k:
>
> What is the behavior we should expect?
>
> Marek
>
> On Mon, Nov 23, 2020 at 7:31 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Ping, Pierre/Marek does this change works as expected?
>>
>> Regards,
>> Christian.
>>
>> Am 18.11.20 um 14:20 schrieb Christian K=C3=B6nig:
>> > This allows for optimizing the CPU round trip away.
>> >
>> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  2 +-
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27 ++++++++++++++++++++++=
++
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  1 +
>> >   3 files changed, 29 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > index 79342976fa76..68f9a4adf5d2 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
>> > @@ -1014,7 +1014,7 @@ static int
>> amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser *p,
>> >               return r;
>> >       }
>> >
>> > -     r =3D amdgpu_sync_fence(&p->job->sync, fence);
>> > +     r =3D amdgpu_sync_fence_chain(&p->job->sync, fence);
>> >       dma_fence_put(fence);
>> >
>> >       return r;
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> > index 8ea6c49529e7..d0d64af06f54 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
>> > @@ -28,6 +28,8 @@
>> >    *    Christian K=C3=B6nig <christian.koenig@amd.com>
>> >    */
>> >
>> > +#include <linux/dma-fence-chain.h>
>> > +
>> >   #include "amdgpu.h"
>> >   #include "amdgpu_trace.h"
>> >   #include "amdgpu_amdkfd.h"
>> > @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync,
>> struct dma_fence *f)
>> >       return 0;
>> >   }
>> >
>> > +/**
>> > + * amdgpu_sync_fence_chain - unpack dma_fence_chain and sync
>> > + *
>> > + * @sync: sync object to add fence to
>> > + * @f: potential dma_fence_chain to sync to.
>> > + *
>> > + * Add the fences inside the chain to the sync object.
>> > + */
>> > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync, struct dma_fenc=
e
>> *f)
>> > +{
>> > +     int r;
>> > +
>> > +     dma_fence_chain_for_each(f, f) {
>> > +             if (dma_fence_is_signaled(f))
>> > +                     continue;
>> > +
>> > +             r =3D amdgpu_sync_fence(sync, f);
>> > +             if (r) {
>> > +                     dma_fence_put(f);
>> > +                     return r;
>> > +             }
>> > +     }
>> > +     return 0;
>> > +}
>> > +
>> >   /**
>> >    * amdgpu_sync_vm_fence - remember to sync to this VM fence
>> >    *
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>> > index 7c0fe20c470d..b142175b65b6 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
>> > @@ -48,6 +48,7 @@ struct amdgpu_sync {
>> >
>> >   void amdgpu_sync_create(struct amdgpu_sync *sync);
>> >   int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)=
;
>> > +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync, struct dma_fenc=
e
>> *f);
>> >   int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence
>> *fence);
>> >   int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync
>> *sync,
>> >                    struct dma_resv *resv, enum amdgpu_sync_mode mode,
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>
>

--0000000000007a250405b4d0cfc7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Pierre-Loup, does this do what you requested?</div><d=
iv><br></div><div>Thanks,</div><div>Marek<br></div></div><br><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 23, 2020 at =
3:17 PM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    <div>That the CPU round trip is gone now.<br>
      <br>
      Christian.<br>
      <br>
      Am 23.11.20 um 20:49 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>What is the behavior we should expect?</div>
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 23, 2020 at 7:31
          AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumer=
ken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Ping,
          Pierre/Marek does this change works as expected?<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          Am 18.11.20 um 14:20 schrieb Christian K=C3=B6nig:<br>
          &gt; This allows for optimizing the CPU round trip away.<br>
          &gt;<br>
          &gt; Signed-off-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:ch=
ristian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com</a>&gt;<=
br>
          &gt; ---<br>
          &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c=C2=A0 =C2=
=A0|=C2=A0 2 +-<br>
          &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 27
          ++++++++++++++++++++++++<br>
          &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |=C2=A0=
 1 +<br>
          &gt;=C2=A0 =C2=A03 files changed, 29 insertions(+), 1 deletion(-)=
<br>
          &gt;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; index 79342976fa76..68f9a4adf5d2 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
          &gt; @@ -1014,7 +1014,7 @@ static int
          amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser
          *p,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return=
 r;<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt; -=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_sync_fence(&amp;p-&gt;job-=
&gt;sync,
          fence);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0r =3D
          amdgpu_sync_fence_chain(&amp;p-&gt;job-&gt;sync, fence);<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0dma_fence_put(fence);<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
          &gt; index 8ea6c49529e7..d0d64af06f54 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c<br>
          &gt; @@ -28,6 +28,8 @@<br>
          &gt;=C2=A0 =C2=A0 *=C2=A0 =C2=A0 Christian K=C3=B6nig &lt;<a href=
=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd=
.com</a>&gt;<br>
          &gt;=C2=A0 =C2=A0 */<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt; +#include &lt;linux/dma-fence-chain.h&gt;<br>
          &gt; +<br>
          &gt;=C2=A0 =C2=A0#include &quot;amdgpu.h&quot;<br>
          &gt;=C2=A0 =C2=A0#include &quot;amdgpu_trace.h&quot;<br>
          &gt;=C2=A0 =C2=A0#include &quot;amdgpu_amdkfd.h&quot;<br>
          &gt; @@ -169,6 +171,31 @@ int amdgpu_sync_fence(struct
          amdgpu_sync *sync, struct dma_fence *f)<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
          &gt;=C2=A0 =C2=A0}<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt; +/**<br>
          &gt; + * amdgpu_sync_fence_chain - unpack dma_fence_chain and
          sync<br>
          &gt; + *<br>
          &gt; + * @sync: sync object to add fence to<br>
          &gt; + * @f: potential dma_fence_chain to sync to.<br>
          &gt; + *<br>
          &gt; + * Add the fences inside the chain to the sync object.<br>
          &gt; + */<br>
          &gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
          struct dma_fence *f)<br>
          &gt; +{<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0int r;<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0dma_fence_chain_for_each(f, f) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (dma_fen=
ce_is_signaled(f))<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0continue;<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D amdgp=
u_sync_fence(sync, f);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br=
>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0dma_fence_put(f);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return r;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt;=C2=A0 =C2=A0/**<br>
          &gt;=C2=A0 =C2=A0 * amdgpu_sync_vm_fence - remember to sync to th=
is VM
          fence<br>
          &gt;=C2=A0 =C2=A0 *<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
          &gt; index 7c0fe20c470d..b142175b65b6 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h<br>
          &gt; @@ -48,6 +48,7 @@ struct amdgpu_sync {<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt;=C2=A0 =C2=A0void amdgpu_sync_create(struct amdgpu_sync *sync=
);<br>
          &gt;=C2=A0 =C2=A0int amdgpu_sync_fence(struct amdgpu_sync *sync, =
struct
          dma_fence *f);<br>
          &gt; +int amdgpu_sync_fence_chain(struct amdgpu_sync *sync,
          struct dma_fence *f);<br>
          &gt;=C2=A0 =C2=A0int amdgpu_sync_vm_fence(struct amdgpu_sync *syn=
c,
          struct dma_fence *fence);<br>
          &gt;=C2=A0 =C2=A0int amdgpu_sync_resv(struct amdgpu_device *adev,=
 struct
          amdgpu_sync *sync,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 struct dma_resv *resv, enum
          amdgpu_sync_mode mode,<br>
          <br>
          _______________________________________________<br>
          amd-gfx mailing list<br>
          <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank=
">amd-gfx@lists.freedesktop.org</a><br>
          <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailma=
n/listinfo/amd-gfx</a><br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--0000000000007a250405b4d0cfc7--

--===============1218029218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1218029218==--
