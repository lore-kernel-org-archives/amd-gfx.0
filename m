Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3CC6C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 22:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F69410E5BD;
	Thu, 12 May 2022 22:17:17 +0000 (UTC)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18C9910E5BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 22:17:16 +0000 (UTC)
Received: by mail-yb1-xb2d.google.com with SMTP id i11so12244815ybq.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=338cOPtFdBWkTaPsMjYCiEGuykDm/ltjsP8g16VjU/8=;
 b=ghD83HuImj6t6NtxoYKJwiIsRSxkKRlIsV1WWCywIU9REnRp7HE+YV16ciqiCmX4fm
 P41muWZtEbNyw+R1zpUcK/iSUqDSazRjWfXhHHzpMd6NsD1rkjYgELAQakgDTIyAO8kC
 XU7/PopQ8mLuiButLUUheuwt2OPyPVKVbQ19zv+UFXjoA2+DaJ3SXpY6a7LPMSdxL5PF
 ybmikgjqYrPHQu6amPPqGG++TyNlQude1FiJeOuWwAUT93mw5l8Ww0VrxksyhT4ZXRWW
 gyoWiinJulHMxV0u2juy2wyfUMJrvXNd8OlMGtSXNfbQgMWNKG50LkIlBaRVxvHV5h+J
 V27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=338cOPtFdBWkTaPsMjYCiEGuykDm/ltjsP8g16VjU/8=;
 b=uusZAVJoMNB/bUobiTcBt9Gaf7abRDdZ33ZV61fevnGxa5xm1O3JyOvG6OcDXKS0/Y
 nbGYxL8XlUW46Ctq69Hkj4YeNJyNv6O9k7YHZE7PJycmzDyNiRjpHGeaOwFYyCcex92F
 Tn0OqPrTTyeTUeR8hhhf2nGzjGJpetRwG/QifyhjJ6Pq0S72zZhJcd2OnO+Wn4sJkzJG
 fapViXdu/lYCTotaAdz3IxsYE5k8bKl5oUBmF2gV4f/1nfkeRZZxje3BXAuFUq2Ec9aI
 UDGw9mNfd37UW6PwfUPMOS8DlrGUo2NTjvuqP6qKIutLSnif5Xck3GbKFzlfQS94SyoW
 zfpw==
X-Gm-Message-State: AOAM530fNkJCM/7TztoNpRNMc5Ujic4Hg+ZZJYJeSShxJsJXbrhU3Nh7
 8Wnd9ypVNdF1fYyM3faqqbNF73dg5rRRUVDn1rroqgdk
X-Google-Smtp-Source: ABdhPJy8hAL6nR+GvI2kmFJPyupc7camHAeuciPVXacFsla36I8/ySbuyZo19bKryJEKEnpX+oN27COQYo6f1/byd+8=
X-Received: by 2002:a25:2003:0:b0:64b:3622:3d2b with SMTP id
 g3-20020a252003000000b0064b36223d2bmr1892092ybg.580.1652393835321; Thu, 12
 May 2022 15:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <CAAxE2A4Bny50ywdTXi0MBV_Pb-onx0yVhPOsb2Lk9XtbJ1R4rQ@mail.gmail.com>
 <CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com>
 <d4f8f7fc-e3dc-fcf8-0543-62039c7460d3@gmail.com>
 <CAAxE2A60-rNUGB3PNL7kq6pJBWf7V-6cAE0Hx6zH31ad7z_1gA@mail.gmail.com>
 <CAAxE2A6BaiGfXXGnmCH9Zk36oWuOwk_84QBYbZ97QhyZQfwBKQ@mail.gmail.com>
 <CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com>
 <11d9492c-f727-f149-d473-9cda4bab2760@gmail.com>
In-Reply-To: <11d9492c-f727-f149-d473-9cda4bab2760@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 12 May 2022 18:17:02 -0400
Message-ID: <CAAxE2A5jc0FhpnM2tBskS2puKY-jidC_xdMTZhQ5p9U31O_0KA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000955e1705ded7eb91"
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

--000000000000955e1705ded7eb91
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Would it be better to set the VM_ALWAYS_VALID flag to have a greater
guarantee that the best placement will be chosen?

See, the main feature is getting the best placement, not being discardable.
The best placement is a hw design requirement due to using memory for uses
that are expected to have performance similar to onchip SRAMs. We need to
make sure the best placement is guaranteed if it's VRAM.

Marek

On Thu., May 12, 2022, 03:26 Christian K=C3=B6nig, <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 12.05.22 um 00:06 schrieb Marek Ol=C5=A1=C3=A1k:
>
> 3rd question: Is it worth using this on APUs?
>
>
> It makes memory management somewhat easier when we are really OOM.
>
> E.g. it should also work for GTT allocations and when the core kernel say=
s
> "Hey please free something up or I will start the OOM-killer" it's
> something we can easily throw away.
>
> Not sure how many of those buffers we have, but marking everything which
> is temporary with that flag is probably a good idea.
>
>
> Thanks,
> Marek
>
> On Wed, May 11, 2022 at 5:58 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> =
wrote:
>
>> Will the kernel keep all discardable buffers in VRAM if VRAM is not
>> overcommitted by discardable buffers, or will other buffers also affect =
the
>> placement of discardable buffers?
>>
>
> Regarding the eviction pressure the buffers will be handled like any othe=
r
> buffer, but instead of preserving the content it is just discarded on
> eviction.
>
>
>> Do evictions deallocate the buffer, or do they keep an allocation in GTT
>> and only the copy is skipped?
>>
>
> It really deallocates the backing store of the buffer, just keeps a dummy
> page array around where all entries are NULL.
>
> There is a patch set on the mailing list to make this a little bit more
> efficient, but even using the dummy page array should only have a few byt=
es
> overhead.
>
> Regards,
> Christian.
>
>
>> Thanks,
>> Marek
>>
>> On Wed, May 11, 2022 at 3:08 AM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com>=
 wrote:
>>
>>> OK that sounds good.
>>>
>>> Marek
>>>
>>> On Wed, May 11, 2022 at 2:04 AM Christian K=C3=B6nig <
>>> ckoenig.leichtzumerken@gmail.com> wrote:
>>>
>>>> Hi Marek,
>>>>
>>>> Am 10.05.22 um 22:43 schrieb Marek Ol=C5=A1=C3=A1k:
>>>>
>>>> A better flag name would be:
>>>> AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD
>>>>
>>>>
>>>> A bit long for my taste and I think the best placement is just a side
>>>> effect.
>>>>
>>>>
>>>> Marek
>>>>
>>>> On Tue, May 10, 2022 at 4:13 PM Marek Ol=C5=A1=C3=A1k <maraeo@gmail.co=
m> wrote:
>>>>
>>>>> Does this really guarantee VRAM placement? The code doesn't say
>>>>> anything about that.
>>>>>
>>>>
>>>> Yes, see the code here:
>>>>
>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> index 8b7ee1142d9a..1944ef37a61e 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>>>>> @@ -567,6 +567,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>>>>>>                 bp->domain;
>>>>>>         bo->allowed_domains =3D bo->preferred_domains;
>>>>>>         if (bp->type !=3D ttm_bo_type_kernel &&
>>>>>> +           !(bp->flags & AMDGPU_GEM_CREATE_DISCARDABLE) &&
>>>>>>             bo->allowed_domains =3D=3D AMDGPU_GEM_DOMAIN_VRAM)
>>>>>>                 bo->allowed_domains |=3D AMDGPU_GEM_DOMAIN_GTT;
>>>>>>
>>>>>
>>>> The only case where this could be circumvented is when you try to
>>>> allocate more than physically available on an APU.
>>>>
>>>> E.g. you only have something like 32 MiB VRAM and request 64 MiB, then
>>>> the GEM code will catch the error and fallback to GTT (IIRC).
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>
>

--000000000000955e1705ded7eb91
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Would it be better to set the VM_ALWAYS_VALID flag to hav=
e a greater guarantee that the best placement will be chosen?<div dir=3D"au=
to"><br></div><div dir=3D"auto">See, the main feature is getting the best p=
lacement, not being discardable. The best placement is a hw design requirem=
ent due to using memory for uses that are expected to have performance simi=
lar to onchip SRAMs. We need to make sure the best placement is guaranteed =
if it&#39;s VRAM.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Marek<=
/div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Thu., May 12, 2022, 03:26 Christian K=C3=B6nig, &lt;<a href=3D"mail=
to:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
 =20
   =20
 =20
  <div>
    Am 12.05.22 um 00:06 schrieb Marek Ol=C5=A1=C3=A1k:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">
        <div>3rd question: Is it worth using this on APUs?</div>
      </div>
    </blockquote>
    <br>
    It makes memory management somewhat easier when we are really OOM.<br>
    <br>
    E.g. it should also work for GTT allocations and when the core
    kernel says &quot;Hey please free something up or I will start the
    OOM-killer&quot; it&#39;s something we can easily throw away.<br>
    <br>
    Not sure how many of those buffers we have, but marking everything
    which is temporary with that flag is probably a good idea.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>Thanks,</div>
        <div>Marek<br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 11, 2022 at 5:58
          PM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" =
target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir=3D"ltr">
            <div>Will the kernel keep all discardable buffers in VRAM if
              VRAM is not overcommitted by discardable buffers, or will
              other buffers also affect the placement of discardable
              buffers?</div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
    Regarding the eviction pressure the buffers will be handled like any
    other buffer, but instead of preserving the content it is just
    discarded on eviction.<br>
    <br>
    <blockquote type=3D"cite">
      <div class=3D"gmail_quote">
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir=3D"ltr">
            <div><br>
            </div>
            <div>Do evictions deallocate the buffer, or do they keep an
              allocation in GTT and only the copy is skipped?</div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
    It really deallocates the backing store of the buffer, just keeps a
    dummy page array around where all entries are NULL.<br>
    <br>
    There is a patch set on the mailing list to make this a little bit
    more efficient, but even using the dummy page array should only have
    a few bytes overhead.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div class=3D"gmail_quote">
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div dir=3D"ltr">
            <div><br>
            </div>
            <div>Thanks,</div>
            <div>Marek<br>
            </div>
          </div>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 11, 2022 at
              3:08 AM Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>&gt;
              wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
              <div dir=3D"ltr">
                <div>OK that sounds good.</div>
                <div><br>
                </div>
                <div>Marek<br>
                </div>
              </div>
              <br>
              <div class=3D"gmail_quote">
                <div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 11, 2022
                  at 2:04 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:cko=
enig.leichtzumerken@gmail.com" target=3D"_blank" rel=3D"noreferrer">ckoenig=
.leichtzumerken@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                  <div> Hi Marek,<br>
                    <br>
                    <div>Am 10.05.22 um 22:43 schrieb Marek Ol=C5=A1=C3=A1k=
:<br>
                    </div>
                    <blockquote type=3D"cite">
                      <div dir=3D"ltr">
                        <div>A better flag name would be:</div>
                        <div>AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD</d=
iv>
                      </div>
                    </blockquote>
                    <br>
                    A bit long for my taste and I think the best
                    placement is just a side effect.<br>
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
                        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, May
                          10, 2022 at 4:13 PM Marek Ol=C5=A1=C3=A1k &lt;<a =
href=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=3D"noreferrer">marae=
o@gmail.com</a>&gt;
                          wrote:<br>
                        </div>
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                          <div dir=3D"ltr">
                            <div>Does this really guarantee VRAM
                              placement? The code doesn&#39;t say anything
                              about that.</div>
                          </div>
                        </blockquote>
                      </div>
                    </blockquote>
                    <br>
                    Yes, see the code here:<br>
                    <br>
                    <blockquote type=3D"cite">
                      <div class=3D"gmail_quote">
                        <blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
br>
                          <div class=3D"gmail_quote">
                            <blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"> diff
                              --git
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
                              index 8b7ee1142d9a..1944ef37a61e 100644<br>
                              ---
                              a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<=
br>
                              +++
                              b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<=
br>
                              @@ -567,6 +567,7 @@ int
                              amdgpu_bo_create(struct amdgpu_device
                              *adev,<br>
                              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bp-&gt;domain;<br>
                              =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;allowed_do=
mains =3D
                              bo-&gt;preferred_domains;<br>
                              =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bp-&gt;type !=
=3D
                              ttm_bo_type_kernel &amp;&amp;<br>
                              +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(b=
p-&gt;flags &amp;
                              AMDGPU_GEM_CREATE_DISCARDABLE) &amp;&amp;<br>
                              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-=
&gt;allowed_domains =3D=3D
                              AMDGPU_GEM_DOMAIN_VRAM)<br>
                              =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 bo-&gt;allowed_domains |=3D
                              AMDGPU_GEM_DOMAIN_GTT;<br>
                            </blockquote>
                          </div>
                        </blockquote>
                      </div>
                    </blockquote>
                    <br>
                    The only case where this could be circumvented is
                    when you try to allocate more than physically
                    available on an APU.<br>
                    <br>
                    E.g. you only have something like 32 MiB VRAM and
                    request 64 MiB, then the GEM code will catch the
                    error and fallback to GTT (IIRC).<br>
                    <br>
                    Regards,<br>
                    Christian.<br>
                  </div>
                </blockquote>
              </div>
            </blockquote>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000955e1705ded7eb91--
