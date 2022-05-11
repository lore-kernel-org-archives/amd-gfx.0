Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1A8C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 21:59:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5E710E289;
	Wed, 11 May 2022 21:59:23 +0000 (UTC)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F19D110E289
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 21:59:21 +0000 (UTC)
Received: by mail-pl1-x631.google.com with SMTP id m12so3155861plb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 14:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PV6LB4fLp64Ga6iSyrlbuDzhb4mbzwbfCScCROyuNbQ=;
 b=INXXgRBRvpRb82/k2r05BX2aVwKfAkuGxHoz0L5vQtEF/S3FfWEguXBahPkreM1ypd
 qaNrusWM+s2OXc8do8obJSnG1CXkbnpsGZ5IXaeE5FuDyqlMQ4JZvf6Tfk57W9tZnvgQ
 +heEBKw6Rk44eM2TE3gOibLZidi9sjoVZXpO7uAmLoYhfXmzPvJgT0IKoYBlr4kUxK6c
 XZwguIS1pfMekyj/kv6FoiyyyIKD++DrzMz6LwqBvjyOS7F+Tq0XL7yFt2s6fm779HkT
 zLk6vvLjLDUj8siLIOgP0R+8B4NUOM1oxEgwvWajlpvClNJOCfZ7VJ/Myl/fzEIASWvH
 Zhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PV6LB4fLp64Ga6iSyrlbuDzhb4mbzwbfCScCROyuNbQ=;
 b=TG0lIU+aU6zsWu/5r7R0hg6Yd8SnRQfFt8Q2xfR8duGAZ2KnGBHu5ZeNsbfESxk4Om
 R+C3h9Ohh8kdrYY4r6unKn50aFGjKgYucjlPmOJswava+280hU5nDSScDnH9t+OZpLro
 dZLIOw2netIRpY1zLpRDucbJJC9NMCd+jpMkx/QP5hA/xim2nxwNjSdCSWJ8TFwF3IH2
 emuQvJhX8WgKLgBGvgxMLOEasWs1OifFR9GavKjYi6nD58qOou0HYreSK6RDbdCYZ6bH
 avZVEXcoeekkiiz86wkn6CFyvBZd/ZX0/1q1v+YPjPsvFOumhZ48DfD04ig9VBXITt6G
 aA7A==
X-Gm-Message-State: AOAM533eGVVtkbm10OLY67VJdP+PlVt6kUx9TdTPKpsneKzrsRZ4exQ3
 R0gGYm2aHLFXcqo0ya0E6BHMjG7UQyoUopi/Y+SPhWe1
X-Google-Smtp-Source: ABdhPJxA48JFvnKe8h2vy9f2rBMDknP1ZaPz4ALL041ccqXwiSVbH8qngNF0coNQtHx8JgFH+FxRmXVlJ1ZkXN2d2AY=
X-Received: by 2002:a17:902:d3d3:b0:15d:1eb8:c820 with SMTP id
 w19-20020a170902d3d300b0015d1eb8c820mr27847518plb.96.1652306361536; Wed, 11
 May 2022 14:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <CAAxE2A4Bny50ywdTXi0MBV_Pb-onx0yVhPOsb2Lk9XtbJ1R4rQ@mail.gmail.com>
 <CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com>
 <d4f8f7fc-e3dc-fcf8-0543-62039c7460d3@gmail.com>
 <CAAxE2A60-rNUGB3PNL7kq6pJBWf7V-6cAE0Hx6zH31ad7z_1gA@mail.gmail.com>
In-Reply-To: <CAAxE2A60-rNUGB3PNL7kq6pJBWf7V-6cAE0Hx6zH31ad7z_1gA@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 11 May 2022 17:58:45 -0400
Message-ID: <CAAxE2A6BaiGfXXGnmCH9Zk36oWuOwk_84QBYbZ97QhyZQfwBKQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000bd544605dec38d23"
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000bd544605dec38d23
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Will the kernel keep all discardable buffers in VRAM if VRAM is not
overcommitted by discardable buffers, or will other buffers also affect the
placement of discardable buffers?

Do evictions deallocate the buffer, or do they keep an allocation in GTT
and only the copy is skipped?

Thanks,
Marek

On Wed, May 11, 2022 at 3:08 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wr=
ote:

> OK that sounds good.
>
> Marek
>
> On Wed, May 11, 2022 at 2:04 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Hi Marek,
>>
>> Am 10.05.22 um 22:43 schrieb Marek Ol=C5=A1=C3=A1k:
>>
>> A better flag name would be:
>> AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD
>>
>>
>> A bit long for my taste and I think the best placement is just a side
>> effect.
>>
>>
>> Marek
>>
>> On Tue, May 10, 2022 at 4:13 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>=
 wrote:
>>
>>> Does this really guarantee VRAM placement? The code doesn't say anythin=
g
>>> about that.
>>>
>>
>> Yes, see the code here:
>>
>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> index 8b7ee1142d9a..1944ef37a61e 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>> @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>>>                 bp->domain;
>>>>         bo->allowed_domains =3D bo->preferred_domains;
>>>>         if (bp->type !=3D ttm_bo_type_kernel &&
>>>> +           !(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE) &&
>>>>             bo->allowed_domains =3D=3D AMDGPU_GEM_DOMAIN_VRAM)
>>>>                 bo->allowed_domains |=3D AMDGPU_GEM_DOMAIN_GTT;
>>>>
>>>
>> The only case where this could be circumvented is when you try to
>> allocate more than physically available on an APU.
>>
>> E.g. you only have something like 32 MiB VRAM and request 64 MiB, then
>> the GEM code will catch the error and fallback to GTT (IIRC).
>>
>> Regards,
>> Christian.
>>
>

--000000000000bd544605dec38d23
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Will the kernel keep all discardable buffers in VRAM =
if VRAM is not overcommitted by discardable buffers, or will other buffers =
also affect the placement of discardable buffers?</div><div><br></div><div>=
Do evictions deallocate the buffer, or do they keep an allocation in GTT an=
d only the copy is skipped?</div><div><br></div><div>Thanks,</div><div>Mare=
k<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"g=
mail_attr">On Wed, May 11, 2022 at 3:08 AM Marek Ol=C5=A1=C3=A1k &lt;<a hre=
f=3D"mailto:maraeo@gmail.com" target=3D"_blank">maraeo@gmail.com</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D=
"ltr"><div>OK that sounds good.</div><div><br></div><div>Marek<br></div></d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Wed, May 11, 2022 at 2:04 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
 =20
   =20
 =20
  <div>
    Hi Marek,<br>
    <br>
    <div>Am 10.05.22 um 22:43 schrieb Marek
      Ol=C5=A1=C3=A1k:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>A better flag name would be:</div>
        <div>AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD</div>
      </div>
    </blockquote>
    <br>
    A bit long for my taste and I think the best placement is just a
    side effect.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, May 10, 2022 at 4:13
          PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" =
target=3D"_blank">maraeo@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir=3D"ltr">
            <div>Does this really guarantee VRAM placement? The code
              doesn&#39;t say anything about that.</div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
    Yes, see the code here:<br>
    <br>
    <blockquote type=3D"cite">
      <div class=3D"gmail_quote">
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
          <div class=3D"gmail_quote">
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              index 8b7ee1142d9a..1944ef37a61e 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct
              amdgpu_device *adev,<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bp-&g=
t;domain;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;allowed_domains =3D bo-&gt=
;preferred_domains;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bp-&gt;type !=3D ttm_bo_type_=
kernel &amp;&amp;<br>
              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(bp-&gt;flags &amp=
;
              AMDGPU_GEM_CREATE_DISCARDABLE) &amp;&amp;<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;allowed_doma=
ins =3D=3D
              AMDGPU_GEM_DOMAIN_VRAM)<br>
              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&g=
t;allowed_domains |=3D
              AMDGPU_GEM_DOMAIN_GTT;<br>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
    The only case where this could be circumvented is when you try to
    allocate more than physically available on an APU.<br>
    <br>
    E.g. you only have something like 32 MiB VRAM and request 64 MiB,
    then the GEM code will catch the error and fallback to GTT (IIRC).<br>
    <br>
    Regards,<br>
    Christian.<br>
  </div>

</blockquote></div>
</blockquote></div>

--000000000000bd544605dec38d23--
