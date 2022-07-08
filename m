Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B9AC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 14:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93D6A10E37D;
	Fri,  8 Jul 2022 14:58:16 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2713610E418
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 14:58:16 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id f11so4005875plr.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jul 2022 07:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/jZvlm6zs6HPOVs3xik/bcUMtCf5XQujaX5qP+t7RvU=;
 b=iy7zUvc6bgD3pt1XlJfsfMxqHvn+RPEVOKWKsLHO9RwmAfWm0lvyuUkeyuWkNQiBxi
 uns3zsuLAwhVFJ+RXn4TD59U8ief49/zAVAIQ7+32b/CASzzMO1JD43Hb/kgeQjYnWVC
 CzmLKhlbN0FMCt7e11oqiA9uSk3La5j02PHPKYeWikhxXy4CMp1WWH/+hsro2EmliVmZ
 NgUn+xaMTSKxBsTEqWTbN3nRi1954QDw9ChWhG0n3A1ZucqfpY9hjHFN/vWao9xOnVk4
 aJU0jO8u6pq0RGUcR0l1Unzpf21rIYPXMrIB0O4oKPxWTVlSgXVA45pl8/MEGYX9NqXY
 b32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/jZvlm6zs6HPOVs3xik/bcUMtCf5XQujaX5qP+t7RvU=;
 b=cLTHx0p29YxSZOyGAaqIIGaWr4xwr605i5hcO27wvJh630ekqUSW46hJb2K0BKfdhz
 AFajydODGFPFg5XpQaXiNQA2zG1s7AHHQoZ5H17Ue8cCbG4IN45VMALR1Gfh6swIJxI9
 ix21zQMDtNotR79IL9iQi8KOtht+dAemygSkaVr3HBsbajZ8oUA7+rJol0T465lsnptg
 u/HlcaYYrF8DFjmwQBgcwzFSyitZBKj3T2Hvy0L5Zbm6r1LXe45wXrU+i0F+0pbHzqys
 IBrg/3SVcRe582+b6pRvb5o9z772GA7MOlTMk/O3TBNsu8CkZ/5IwM4DR0pfeFm1FstP
 4ZZQ==
X-Gm-Message-State: AJIora+ELH9ikzN6Fl8uXqbIZbWpsQNToOpxdYk6HcTSa0bousg+i4rS
 ULBtS859ITU4MmR2GjwD3DpO8WNmkgxFIqEgTRQ=
X-Google-Smtp-Source: AGRyM1ssScmMGy+nK09P9rU6l7IlLbyJ/c4QybQal/I08ie1ADRU8JE71ju85N3GzREwXeWqtbXRIpC0LxTMjeibnvg=
X-Received: by 2002:a17:902:d4c3:b0:16a:7696:971a with SMTP id
 o3-20020a170902d4c300b0016a7696971amr4101832plg.142.1657292295713; Fri, 08
 Jul 2022 07:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220506112312.347519-1-christian.koenig@amd.com>
 <CAAxE2A4Bny50ywdTXi0MBV_Pb-onx0yVhPOsb2Lk9XtbJ1R4rQ@mail.gmail.com>
 <CAAxE2A7wOfoWWh5VUFmnhyhNeCQ086trJR2BgT+nAmsYZJTbVg@mail.gmail.com>
 <d4f8f7fc-e3dc-fcf8-0543-62039c7460d3@gmail.com>
 <CAAxE2A60-rNUGB3PNL7kq6pJBWf7V-6cAE0Hx6zH31ad7z_1gA@mail.gmail.com>
 <CAAxE2A6BaiGfXXGnmCH9Zk36oWuOwk_84QBYbZ97QhyZQfwBKQ@mail.gmail.com>
 <CAAxE2A6wiL5fnegVo+tMsHBNb+HC3Nw=cmR4MdNVqLpEQYH1ug@mail.gmail.com>
 <11d9492c-f727-f149-d473-9cda4bab2760@gmail.com>
 <CAAxE2A5jc0FhpnM2tBskS2puKY-jidC_xdMTZhQ5p9U31O_0KA@mail.gmail.com>
 <62165c7c-892a-5b35-79dd-b90414ccb5cd@damsy.net>
 <12f757f0-29f5-858e-4723-0babb4b6f335@gmail.com>
In-Reply-To: <12f757f0-29f5-858e-4723-0babb4b6f335@gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 8 Jul 2022 10:58:02 -0400
Message-ID: <CAAxE2A6CV+t9k4VG_zc5uf8qYK07Db0kqChYH0C9MB-TK7MU8g@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000093401b05e34c6e7e"
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
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000093401b05e34c6e7e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christian, should we set this flag for GDS too? Will it help with GDS OOM
failures?

Marek

On Fri., May 13, 2022, 07:26 Christian K=C3=B6nig, <
ckoenig.leichtzumerken@gmail.com> wrote:

> Exactly that's what we can't do.
>
> See the kernel must always be able to move things to GTT or discard. So
> when you want to guarantee that something is in VRAM you must at the
> same time say you can discard it if it can't.
>
> Christian.
>
> Am 13.05.22 um 10:43 schrieb Pierre-Eric Pelloux-Prayer:
> > Hi Marek, Christian,
> >
> > If the main feature for Mesa of AMDGPU_GEM_CREATE_DISCARDABLE is
> > getting the best placement, maybe we should have 2 separate flags:
> >   * AMDGPU_GEM_CREATE_DISCARDABLE: indicates to the kernel that it can
> > discards the content on eviction instead of preserving it
> >   * AMDGPU_GEM_CREATE_FORCE_BEST_PLACEMENT (or
> > AMDGPU_GEM_CREATE_NO_GTT_FALLBACK ? or AMDGPU_CREATE_GEM_AVOID_GTT?):
> > tells the kernel that this bo really needs to be in VRAM
> >
> >
> > Pierre-Eric
> >
> > On 13/05/2022 00:17, Marek Ol=C5=A1=C3=A1k wrote:
> >> Would it be better to set the VM_ALWAYS_VALID flag to have a greater
> >> guarantee that the best placement will be chosen?
> >>
> >> See, the main feature is getting the best placement, not being
> >> discardable. The best placement is a hw design requirement due to
> >> using memory for uses that are expected to have performance similar
> >> to onchip SRAMs. We need to make sure the best placement is
> >> guaranteed if it's VRAM.
> >>
> >> Marek
> >>
> >> On Thu., May 12, 2022, 03:26 Christian K=C3=B6nig,
> >> <ckoenig.leichtzumerken@gmail.com
> >> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
> >>
> >>     Am 12.05.22 um 00:06 schrieb Marek Ol=C5=A1=C3=A1k:
> >>>     3rd question: Is it worth using this on APUs?
> >>
> >>     It makes memory management somewhat easier when we are really OOM.
> >>
> >>     E.g. it should also work for GTT allocations and when the core
> >> kernel says "Hey please free something up or I will start the
> >> OOM-killer" it's something we can easily throw away.
> >>
> >>     Not sure how many of those buffers we have, but marking
> >> everything which is temporary with that flag is probably a good idea.
> >>
> >>>
> >>>     Thanks,
> >>>     Marek
> >>>
> >>>     On Wed, May 11, 2022 at 5:58 PM Marek Ol=C5=A1=C3=A1k <maraeo@gma=
il.com
> >>> <mailto:maraeo@gmail.com>> wrote:
> >>>
> >>>         Will the kernel keep all discardable buffers in VRAM if VRAM
> >>> is not overcommitted by discardable buffers, or will other buffers
> >>> also affect the placement of discardable buffers?
> >>>
> >>
> >>     Regarding the eviction pressure the buffers will be handled like
> >> any other buffer, but instead of preserving the content it is just
> >> discarded on eviction.
> >>
> >>>
> >>>         Do evictions deallocate the buffer, or do they keep an
> >>> allocation in GTT and only the copy is skipped?
> >>>
> >>
> >>     It really deallocates the backing store of the buffer, just keeps
> >> a dummy page array around where all entries are NULL.
> >>
> >>     There is a patch set on the mailing list to make this a little
> >> bit more efficient, but even using the dummy page array should only
> >> have a few bytes overhead.
> >>
> >>     Regards,
> >>     Christian.
> >>
> >>>
> >>>         Thanks,
> >>>         Marek
> >>>
> >>>         On Wed, May 11, 2022 at 3:08 AM Marek Ol=C5=A1=C3=A1k
> >>> <maraeo@gmail.com <mailto:maraeo@gmail.com>> wrote:
> >>>
> >>>             OK that sounds good.
> >>>
> >>>             Marek
> >>>
> >>>             On Wed, May 11, 2022 at 2:04 AM Christian K=C3=B6nig
> >>> <ckoenig.leichtzumerken@gmail.com
> >>> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
> >>>
> >>>                 Hi Marek,
> >>>
> >>>                 Am 10.05.22 um 22:43 schrieb Marek Ol=C5=A1=C3=A1k:
> >>>>                 A better flag name would be:
> >>>>                 AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD
> >>>
> >>>                 A bit long for my taste and I think the best
> >>> placement is just a side effect.
> >>>
> >>>>
> >>>>                 Marek
> >>>>
> >>>>                 On Tue, May 10, 2022 at 4:13 PM Marek Ol=C5=A1=C3=A1=
k
> >>>> <maraeo@gmail.com <mailto:maraeo@gmail.com>> wrote:
> >>>>
> >>>>                     Does this really guarantee VRAM placement? The
> >>>> code doesn't say anything about that.
> >>>>
> >>>
> >>>                 Yes, see the code here:
> >>>
> >>>>
> >>>>                         diff --git
> >>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>                         index 8b7ee1142d9a..1944ef37a61e 100644
> >>>>                         ---
> >>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>                         +++
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>>>                         @@ -567,6 +567,7 @@ int
> >>>> amdgpu_bo_create(struct amdgpu_device *adev,
> >>>>                                         bp->domain;
> >>>>                                 bo->allowed_domains =3D
> >>>> bo->preferred_domains;
> >>>>                                 if (bp->type !=3D ttm_bo_type_kernel=
 &&
> >>>>                         +           !(bp->flags &
> >>>> AMDGPU_GEM_CREATE_DISCARDABLE) &&
> >>>>                                     bo->allowed_domains =3D=3D
> >>>> AMDGPU_GEM_DOMAIN_VRAM)
> >>>> bo->allowed_domains |=3D AMDGPU_GEM_DOMAIN_GTT;
> >>>>
> >>>
> >>>                 The only case where this could be circumvented is
> >>> when you try to allocate more than physically available on an APU.
> >>>
> >>>                 E.g. you only have something like 32 MiB VRAM and
> >>> request 64 MiB, then the GEM code will catch the error and fallback
> >>> to GTT (IIRC).
> >>>
> >>>                 Regards,
> >>>                 Christian.
> >>>
> >>
>
>

--00000000000093401b05e34c6e7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Christian, should we set this flag for GDS too? Will it h=
elp with GDS OOM failures?<div dir=3D"auto"><br></div><div dir=3D"auto">Mar=
ek</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri., May 13, 2022, 07:26 Christian K=C3=B6nig, &lt;<a href=3D"m=
ailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leichtzumerken@gmail.com</a=
>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Exactly that&#39;s wha=
t we can&#39;t do.<br>
<br>
See the kernel must always be able to move things to GTT or discard. So <br=
>
when you want to guarantee that something is in VRAM you must at the <br>
same time say you can discard it if it can&#39;t.<br>
<br>
Christian.<br>
<br>
Am 13.05.22 um 10:43 schrieb Pierre-Eric Pelloux-Prayer:<br>
&gt; Hi Marek, Christian,<br>
&gt;<br>
&gt; If the main feature for Mesa of AMDGPU_GEM_CREATE_DISCARDABLE is <br>
&gt; getting the best placement, maybe we should have 2 separate flags:<br>
&gt; =C2=A0 * AMDGPU_GEM_CREATE_DISCARDABLE: indicates to the kernel that i=
t can <br>
&gt; discards the content on eviction instead of preserving it<br>
&gt; =C2=A0 * AMDGPU_GEM_CREATE_FORCE_BEST_PLACEMENT (or <br>
&gt; AMDGPU_GEM_CREATE_NO_GTT_FALLBACK ? or AMDGPU_CREATE_GEM_AVOID_GTT?): =
<br>
&gt; tells the kernel that this bo really needs to be in VRAM<br>
&gt;<br>
&gt;<br>
&gt; Pierre-Eric<br>
&gt;<br>
&gt; On 13/05/2022 00:17, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt;&gt; Would it be better to set the VM_ALWAYS_VALID flag to have a great=
er <br>
&gt;&gt; guarantee that the best placement will be chosen?<br>
&gt;&gt;<br>
&gt;&gt; See, the main feature is getting the best placement, not being <br=
>
&gt;&gt; discardable. The best placement is a hw design requirement due to =
<br>
&gt;&gt; using memory for uses that are expected to have performance simila=
r <br>
&gt;&gt; to onchip SRAMs. We need to make sure the best placement is <br>
&gt;&gt; guaranteed if it&#39;s VRAM.<br>
&gt;&gt;<br>
&gt;&gt; Marek<br>
&gt;&gt;<br>
&gt;&gt; On Thu., May 12, 2022, 03:26 Christian K=C3=B6nig, <br>
&gt;&gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"=
_blank" rel=3D"noreferrer">ckoenig.leichtzumerken@gmail.com</a> <br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" tar=
get=3D"_blank" rel=3D"noreferrer">ckoenig.leichtzumerken@gmail.com</a>&gt;&=
gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Am 12.05.22 um 00:06 schrieb Marek Ol=C5=A1=C3=
=A1k:<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 3rd question: Is it worth using this on APU=
s?<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 It makes memory management somewhat easier when=
 we are really OOM.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 E.g. it should also work for GTT allocations an=
d when the core <br>
&gt;&gt; kernel says &quot;Hey please free something up or I will start the=
 <br>
&gt;&gt; OOM-killer&quot; it&#39;s something we can easily throw away.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Not sure how many of those buffers we have, but=
 marking <br>
&gt;&gt; everything which is temporary with that flag is probably a good id=
ea.<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 Thanks,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 Marek<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0 On Wed, May 11, 2022 at 5:58 PM Marek Ol=C5=
=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=3D=
"noreferrer">maraeo@gmail.com</a> <br>
&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:maraeo@gmail.com" target=3D"_blan=
k" rel=3D"noreferrer">maraeo@gmail.com</a>&gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Will the kernel kee=
p all discardable buffers in VRAM if VRAM <br>
&gt;&gt;&gt; is not overcommitted by discardable buffers, or will other buf=
fers <br>
&gt;&gt;&gt; also affect the placement of discardable buffers?<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Regarding the eviction pressure the buffers wil=
l be handled like <br>
&gt;&gt; any other buffer, but instead of preserving the content it is just=
 <br>
&gt;&gt; discarded on eviction.<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Do evictions deallo=
cate the buffer, or do they keep an <br>
&gt;&gt;&gt; allocation in GTT and only the copy is skipped?<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 It really deallocates the backing store of the =
buffer, just keeps <br>
&gt;&gt; a dummy page array around where all entries are NULL.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 There is a patch set on the mailing list to mak=
e this a little <br>
&gt;&gt; bit more efficient, but even using the dummy page array should onl=
y <br>
&gt;&gt; have a few bytes overhead.<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Regards,<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Christian.<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thanks,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Marek<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On Wed, May 11, 202=
2 at 3:08 AM Marek Ol=C5=A1=C3=A1k <br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank" rel=
=3D"noreferrer">maraeo@gmail.com</a> &lt;mailto:<a href=3D"mailto:maraeo@gm=
ail.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>&gt;&gt; =
wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 OK that sounds good.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 Marek<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 On Wed, May 11, 2022 at 2:04 AM Christian K=C3=B6nig <br>
&gt;&gt;&gt; &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=
=3D"_blank" rel=3D"noreferrer">ckoenig.leichtzumerken@gmail.com</a> <br>
&gt;&gt;&gt; &lt;mailto:<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com"=
 target=3D"_blank" rel=3D"noreferrer">ckoenig.leichtzumerken@gmail.com</a>&=
gt;&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Hi Marek,<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Am 10.05.22 um 22:43 schrieb Marek Ol=C5=A1=
=C3=A1k:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A better flag name would be:<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCA=
RD<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 A bit long for my taste and I think the best=
 <br>
&gt;&gt;&gt; placement is just a side effect.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Marek<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 On Tue, May 10, 2022 at 4:13 PM Marek Ol=
=C5=A1=C3=A1k <br>
&gt;&gt;&gt;&gt; &lt;<a href=3D"mailto:maraeo@gmail.com" target=3D"_blank" =
rel=3D"noreferrer">maraeo@gmail.com</a> &lt;mailto:<a href=3D"mailto:maraeo=
@gmail.com" target=3D"_blank" rel=3D"noreferrer">maraeo@gmail.com</a>&gt;&g=
t; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Does this really =
guarantee VRAM placement? The <br>
&gt;&gt;&gt;&gt; code doesn&#39;t say anything about that.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Yes, see the code here:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 diff --git <br>
&gt;&gt;&gt;&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 index 8b7ee1142d9a..1944ef37a61e 100644<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 --- <br>
&gt;&gt;&gt;&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +++ <br>
&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 @@ -567,6 +567,7 @@ int <br>
&gt;&gt;&gt;&gt; amdgpu_bo_create(struct amdgpu_device *adev,<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bp-&gt;domai=
n;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;allowed_domains =3D <br>
&gt;&gt;&gt;&gt; bo-&gt;preferred_domains;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bp-&gt;type !=3D ttm_bo_type_kernel =
&amp;&amp;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0!(bp-&gt;flags &amp; <br>
&gt;&gt;&gt;&gt; AMDGPU_GEM_CREATE_DISCARDABLE) &amp;&amp;<br>
&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 bo-&gt;allowed_domains =3D=
=3D <br>
&gt;&gt;&gt;&gt; AMDGPU_GEM_DOMAIN_VRAM)<br>
&gt;&gt;&gt;&gt; bo-&gt;allowed_domains |=3D AMDGPU_GEM_DOMAIN_GTT;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The only case where this could be circumvent=
ed is <br>
&gt;&gt;&gt; when you try to allocate more than physically available on an =
APU.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 E.g. you only have something like 32 MiB VRA=
M and <br>
&gt;&gt;&gt; request 64 MiB, then the GEM code will catch the error and fal=
lback <br>
&gt;&gt;&gt; to GTT (IIRC).<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Regards,<br>
&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
<br>
</blockquote></div>

--00000000000093401b05e34c6e7e--
