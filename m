Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7707C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 07:08:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586FD10E09A;
	Wed, 11 May 2022 07:08:54 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8477810E09A
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 07:08:52 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id m12so1027629plb.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 00:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x9ZcrY6B7KTAt3K75WSxUmpf/Km31dET+pZ6pTSeuKA=;
 b=hGw+dxrPhn1ikV9cpUnDvmZi1YSmzoGyR2j5rjHBipFBf9dLa9eUswBY0QqnuBOcaz
 Wgo7Wvzu7/X9rxlZNfN6RWwuxm7+M9MTn9SsOK4OMzSJ7A5OI+P2qpUjMqr8E9VnW9pD
 5llRK+ng6BoJUxfdhMzILw8Hehcj1bXSV5km4Bfb/IW9J36NHweIl1ZH7EXjPORx17u8
 fVK8zut7BmuGWFluzP3p5IBdMM4hDzL1vL4SQI7XObJHW7mCrwZyku7pg8nuHiVpNP4R
 /sAAlhuYop1a/LmDPuct9lUXm97/1/vwo2e/hkXUfpfdKVFAP1HJMb0qCKAYeDFOxhYi
 hj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x9ZcrY6B7KTAt3K75WSxUmpf/Km31dET+pZ6pTSeuKA=;
 b=emI3mongEBsNaFyNXu/lL025t1ajgHSS9g1o4+2gI5G64K9ZRUbl7orbkhpsVSvcCP
 hGVZZVQzBpeOy12vBY2h1uxMXSP1OIyhV7i0eFsmJJ72qXPdf8UbFXpyWyT7L3PTzGct
 q0fZShpvZHjlY80GqZXcH/R5nuX5gVt3oufryfc/SfZaIaikUljR3ME+zLwvgNIU6cMH
 6k7dbPrQZzg63nL4oU5iLuFRtye2alNg61uqk1+7xFk2akoFymlYh7EDKSqcNhRZwgsx
 eGLMjkItUz6R7ss0QF5ATAe70WmFQSeC9OpuKDo2/x6BT6zzSa5mPgB4EIqKzai84qq+
 EPmQ==
X-Gm-Message-State: AOAM532PCgX94hjTeayE/dq9+ZebZOR8WWLWHZDN66x23UyCMaRtY1PT
 fb3gLLylgHfeWQVGavlA0qblcEG6TGnzrvsyVFr7J3AF
X-Google-Smtp-Source: ABdhPJzLMb56AQso/bTjLnm22jRpOE6RmFbn1FKU+UOUAliUHcuB75xvcz6IIDluXeBGXftsrj80UlJgNZSEf/v4iSs=
X-Received: by 2002:a17:903:18a:b0:15e:c983:7c2e with SMTP id
 z10-20020a170903018a00b0015ec9837c2emr23565564plg.29.1652252932118; Wed, 11
 May 2022 00:08:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <CAAxE2A4Bny50ywdTXi0MBV_Pb-onx0yVhPOsb2Lk9XtbJ1R4rQ@mail.gmail.com>
 <CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com>
 <d4f8f7fc-e3dc-fcf8-0543-62039c7460d3@gmail.com>
In-Reply-To: <d4f8f7fc-e3dc-fcf8-0543-62039c7460d3@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 11 May 2022 03:08:16 -0400
Message-ID: <CAAxE2A60-rNUGB3PNL7kq6pJBWf7V-6cAE0Hx6zH31ad7z_1gA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000191baf05deb71de5"
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

--000000000000191baf05deb71de5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

OK that sounds good.

Marek

On Wed, May 11, 2022 at 2:04 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Hi Marek,
>
> Am 10.05.22 um 22:43 schrieb Marek Ol=C5=A1=C3=A1k:
>
> A better flag name would be:
> AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD
>
>
> A bit long for my taste and I think the best placement is just a side
> effect.
>
>
> Marek
>
> On Tue, May 10, 2022 at 4:13 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> =
wrote:
>
>> Does this really guarantee VRAM placement? The code doesn't say anything
>> about that.
>>
>
> Yes, see the code here:
>
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 8b7ee1142d9a..1944ef37a61e 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>>                 bp->domain;
>>>         bo->allowed_domains =3D bo->preferred_domains;
>>>         if (bp->type !=3D ttm_bo_type_kernel &&
>>> +           !(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE) &&
>>>             bo->allowed_domains =3D=3D AMDGPU_GEM_DOMAIN_VRAM)
>>>                 bo->allowed_domains |=3D AMDGPU_GEM_DOMAIN_GTT;
>>>
>>
> The only case where this could be circumvented is when you try to allocat=
e
> more than physically available on an APU.
>
> E.g. you only have something like 32 MiB VRAM and request 64 MiB, then th=
e
> GEM code will catch the error and fallback to GTT (IIRC).
>
> Regards,
> Christian.
>

--000000000000191baf05deb71de5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>OK that sounds good.</div><div><br></div><div>Marek<b=
r></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Wed, May 11, 2022 at 2:04 AM Christian K=C3=B6nig &lt;<a href=3D=
"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
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

--000000000000191baf05deb71de5--
