Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D033C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Jul 2022 10:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0E38D66E;
	Mon, 11 Jul 2022 10:15:22 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFC38D672
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 10:15:21 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id a9so8005477ejf.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Jul 2022 03:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=hd1kelNNhLzGzlc1OmvNM3dfhFiWx+KQ+w65Lu1k51I=;
 b=bgk4ZrpAd+t/o3CqFTS5ZqS4htp6cdJfBuuxHBHbCJeCGtHGlQQXdUPazLYYTZj6pU
 DoqjxyIf2D0IUcYbN1+ZyFrolYfjZg7z8f23CPgq2PbTYVX4/rqipsYaOSDOg45S0Kzb
 qXz/WfXGFjxrxy7SKVhiJvV1DngTG4icEj8GzqtfKSrVfXUaQ+dM3FGv98tkrgb3p/8L
 CCDJySoVzmovcqqlWgAlF2fxcJkS7IgHOV5mKZ3KFUtSiV47+LFQFlmC/Zr4zrtX/fi2
 zJ4RfUfEvgwPi33mmO3XQqGENwlFUktdn7zD5v/v7zGydl8oMtLXJRO9yZzj1wEw8aCz
 mLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=hd1kelNNhLzGzlc1OmvNM3dfhFiWx+KQ+w65Lu1k51I=;
 b=tyXdO8wNG+MR1vuCY4uv+bEw1MZBHlBsPpfJyyqtLXYTP0b/RiEw8oOTMjf6JlwCXn
 DvVTNiLcAvrvcB8ga99iJNN3rEWg+mv4oGIoQLHoA3dmBRHTNqp/9n7lYe/QcefZJkJ2
 3Cwu9g/0K6AIWNdMtGYOV0DeJpbi9AjdndWJy5mrED36K6YLrN3UhmriJkaxG5W5n8FH
 B4zTvby8fx4foeq5xBv3NYi7h2YyA/rvvCpwQGT+/AwJMAeuQjYUM/wDjle/MypekHRT
 1FmlEbMlp6hkkZ3U8+QqBiKCTOpd2KsE+mjfD8lW69w+XsMFTJjZvsQ2ow3wIRQXV4Ns
 76Mg==
X-Gm-Message-State: AJIora/l39yMLbcBsGRpr0E1aKN7pkJhoGt8eFNJuK+vSqoBoAtK51OG
 pWH7C3ApMq/FNazrapic9AnVKJEjF+M=
X-Google-Smtp-Source: AGRyM1vTTyNFegwhBDKhXZiOmk71z6Ao/LwMDJh9xFZ/1H4gLzEvpQQKloe79a5LA/MzRxBzzE3ZLg==
X-Received: by 2002:a17:907:2be9:b0:72b:50b8:82d6 with SMTP id
 gv41-20020a1709072be900b0072b50b882d6mr5644081ejc.677.1657534519456; 
 Mon, 11 Jul 2022 03:15:19 -0700 (PDT)
Received: from [192.168.178.21] (p57b0bd9f.dip0.t-ipconnect.de.
 [87.176.189.159]) by smtp.gmail.com with ESMTPSA id
 la7-20020a170907780700b0072b592ee073sm759089ejc.147.2022.07.11.03.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jul 2022 03:15:18 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------7nuj9oasAcyLOQCuaxUGxBdR"
Message-ID: <e8174e58-c2d0-f3ac-18f0-9c7577eef079@gmail.com>
Date: Mon, 11 Jul 2022 12:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/3] drm/amdgpu: add AMDGPU_GEM_CREATE_DISCARDABLE
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
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
 <CAAxE2A6CV+t9k4VG_zc5uf8qYK07Db0kqChYH0C9MB-TK7MU8g@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A6CV+t9k4VG_zc5uf8qYK07Db0kqChYH0C9MB-TK7MU8g@mail.gmail.com>
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

This is a multi-part message in MIME format.
--------------7nuj9oasAcyLOQCuaxUGxBdR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

That would be redundant. GDS handling has always worked in the way that 
the storage is thrown away after an IB.

My LRU patch set should have helped with GDS out of memory errors, but 
I'm not sure how far along we are with rebasing amd-staging-drm-next.

Christian.

Am 08.07.22 um 16:58 schrieb Marek Olšák:
> Christian, should we set this flag for GDS too? Will it help with GDS 
> OOM failures?
>
> Marek
>
> On Fri., May 13, 2022, 07:26 Christian König, 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     Exactly that's what we can't do.
>
>     See the kernel must always be able to move things to GTT or
>     discard. So
>     when you want to guarantee that something is in VRAM you must at the
>     same time say you can discard it if it can't.
>
>     Christian.
>
>     Am 13.05.22 um 10:43 schrieb Pierre-Eric Pelloux-Prayer:
>     > Hi Marek, Christian,
>     >
>     > If the main feature for Mesa of AMDGPU_GEM_CREATE_DISCARDABLE is
>     > getting the best placement, maybe we should have 2 separate flags:
>     >   * AMDGPU_GEM_CREATE_DISCARDABLE: indicates to the kernel that
>     it can
>     > discards the content on eviction instead of preserving it
>     >   * AMDGPU_GEM_CREATE_FORCE_BEST_PLACEMENT (or
>     > AMDGPU_GEM_CREATE_NO_GTT_FALLBACK ? or
>     AMDGPU_CREATE_GEM_AVOID_GTT?):
>     > tells the kernel that this bo really needs to be in VRAM
>     >
>     >
>     > Pierre-Eric
>     >
>     > On 13/05/2022 00:17, Marek Olšák wrote:
>     >> Would it be better to set the VM_ALWAYS_VALID flag to have a
>     greater
>     >> guarantee that the best placement will be chosen?
>     >>
>     >> See, the main feature is getting the best placement, not being
>     >> discardable. The best placement is a hw design requirement due to
>     >> using memory for uses that are expected to have performance
>     similar
>     >> to onchip SRAMs. We need to make sure the best placement is
>     >> guaranteed if it's VRAM.
>     >>
>     >> Marek
>     >>
>     >> On Thu., May 12, 2022, 03:26 Christian König,
>     >> <ckoenig.leichtzumerken@gmail.com
>     >> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>     >>
>     >>     Am 12.05.22 um 00:06 schrieb Marek Olšák:
>     >>>     3rd question: Is it worth using this on APUs?
>     >>
>     >>     It makes memory management somewhat easier when we are
>     really OOM.
>     >>
>     >>     E.g. it should also work for GTT allocations and when the core
>     >> kernel says "Hey please free something up or I will start the
>     >> OOM-killer" it's something we can easily throw away.
>     >>
>     >>     Not sure how many of those buffers we have, but marking
>     >> everything which is temporary with that flag is probably a good
>     idea.
>     >>
>     >>>
>     >>>     Thanks,
>     >>>     Marek
>     >>>
>     >>>     On Wed, May 11, 2022 at 5:58 PM Marek Olšák <maraeo@gmail.com
>     >>> <mailto:maraeo@gmail.com>> wrote:
>     >>>
>     >>>         Will the kernel keep all discardable buffers in VRAM
>     if VRAM
>     >>> is not overcommitted by discardable buffers, or will other
>     buffers
>     >>> also affect the placement of discardable buffers?
>     >>>
>     >>
>     >>     Regarding the eviction pressure the buffers will be handled
>     like
>     >> any other buffer, but instead of preserving the content it is just
>     >> discarded on eviction.
>     >>
>     >>>
>     >>>         Do evictions deallocate the buffer, or do they keep an
>     >>> allocation in GTT and only the copy is skipped?
>     >>>
>     >>
>     >>     It really deallocates the backing store of the buffer, just
>     keeps
>     >> a dummy page array around where all entries are NULL.
>     >>
>     >>     There is a patch set on the mailing list to make this a little
>     >> bit more efficient, but even using the dummy page array should
>     only
>     >> have a few bytes overhead.
>     >>
>     >>     Regards,
>     >>     Christian.
>     >>
>     >>>
>     >>>         Thanks,
>     >>>         Marek
>     >>>
>     >>>         On Wed, May 11, 2022 at 3:08 AM Marek Olšák
>     >>> <maraeo@gmail.com <mailto:maraeo@gmail.com>> wrote:
>     >>>
>     >>>             OK that sounds good.
>     >>>
>     >>>             Marek
>     >>>
>     >>>             On Wed, May 11, 2022 at 2:04 AM Christian König
>     >>> <ckoenig.leichtzumerken@gmail.com
>     >>> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>     >>>
>     >>>                 Hi Marek,
>     >>>
>     >>>                 Am 10.05.22 um 22:43 schrieb Marek Olšák:
>     >>>>                 A better flag name would be:
>     >>>> AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD
>     >>>
>     >>>                 A bit long for my taste and I think the best
>     >>> placement is just a side effect.
>     >>>
>     >>>>
>     >>>>                 Marek
>     >>>>
>     >>>>                 On Tue, May 10, 2022 at 4:13 PM Marek Olšák
>     >>>> <maraeo@gmail.com <mailto:maraeo@gmail.com>> wrote:
>     >>>>
>     >>>>                     Does this really guarantee VRAM
>     placement? The
>     >>>> code doesn't say anything about that.
>     >>>>
>     >>>
>     >>>                 Yes, see the code here:
>     >>>
>     >>>>
>     >>>>                         diff --git
>     >>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     >>>>                         index 8b7ee1142d9a..1944ef37a61e 100644
>     >>>>                         ---
>     >>>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     >>>>                         +++
>     >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>     >>>>                         @@ -567,6 +567,7 @@ int
>     >>>> amdgpu_bo_create(struct amdgpu_device *adev,
>     >>>> bp->domain;
>     >>>> bo->allowed_domains =
>     >>>> bo->preferred_domains;
>     >>>>                                 if (bp->type !=
>     ttm_bo_type_kernel &&
>     >>>>                         +  !(bp->flags &
>     >>>> AMDGPU_GEM_CREATE_DISCARDABLE) &&
>     >>>> bo->allowed_domains ==
>     >>>> AMDGPU_GEM_DOMAIN_VRAM)
>     >>>> bo->allowed_domains |= AMDGPU_GEM_DOMAIN_GTT;
>     >>>>
>     >>>
>     >>>                 The only case where this could be circumvented is
>     >>> when you try to allocate more than physically available on an APU.
>     >>>
>     >>>                 E.g. you only have something like 32 MiB VRAM and
>     >>> request 64 MiB, then the GEM code will catch the error and
>     fallback
>     >>> to GTT (IIRC).
>     >>>
>     >>>                 Regards,
>     >>>                 Christian.
>     >>>
>     >>
>

--------------7nuj9oasAcyLOQCuaxUGxBdR
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    That would be redundant. GDS handling has always worked in the way
    that the storage is thrown away after an IB.<br>
    <br>
    My LRU patch set should have helped with GDS out of memory errors,
    but I'm not sure how far along we are with rebasing
    amd-staging-drm-next.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 08.07.22 um 16:58 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A6CV+t9k4VG_zc5uf8qYK07Db0kqChYH0C9MB-TK7MU8g@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">Christian, should we set this flag for GDS too?
        Will it help with GDS OOM failures?
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri., May 13, 2022, 07:26
          Christian König, &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Exactly
          that's what we can't do.<br>
          <br>
          See the kernel must always be able to move things to GTT or
          discard. So <br>
          when you want to guarantee that something is in VRAM you must
          at the <br>
          same time say you can discard it if it can't.<br>
          <br>
          Christian.<br>
          <br>
          Am 13.05.22 um 10:43 schrieb Pierre-Eric Pelloux-Prayer:<br>
          &gt; Hi Marek, Christian,<br>
          &gt;<br>
          &gt; If the main feature for Mesa of
          AMDGPU_GEM_CREATE_DISCARDABLE is <br>
          &gt; getting the best placement, maybe we should have 2
          separate flags:<br>
          &gt;   * AMDGPU_GEM_CREATE_DISCARDABLE: indicates to the
          kernel that it can <br>
          &gt; discards the content on eviction instead of preserving it<br>
          &gt;   * AMDGPU_GEM_CREATE_FORCE_BEST_PLACEMENT (or <br>
          &gt; AMDGPU_GEM_CREATE_NO_GTT_FALLBACK ? or
          AMDGPU_CREATE_GEM_AVOID_GTT?): <br>
          &gt; tells the kernel that this bo really needs to be in VRAM<br>
          &gt;<br>
          &gt;<br>
          &gt; Pierre-Eric<br>
          &gt;<br>
          &gt; On 13/05/2022 00:17, Marek Olšák wrote:<br>
          &gt;&gt; Would it be better to set the VM_ALWAYS_VALID flag to
          have a greater <br>
          &gt;&gt; guarantee that the best placement will be chosen?<br>
          &gt;&gt;<br>
          &gt;&gt; See, the main feature is getting the best placement,
          not being <br>
          &gt;&gt; discardable. The best placement is a hw design
          requirement due to <br>
          &gt;&gt; using memory for uses that are expected to have
          performance similar <br>
          &gt;&gt; to onchip SRAMs. We need to make sure the best
          placement is <br>
          &gt;&gt; guaranteed if it's VRAM.<br>
          &gt;&gt;<br>
          &gt;&gt; Marek<br>
          &gt;&gt;<br>
          &gt;&gt; On Thu., May 12, 2022, 03:26 Christian König, <br>
          &gt;&gt; &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>
          <br>
          &gt;&gt; &lt;mailto:<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;&gt;
          wrote:<br>
          &gt;&gt;<br>
          &gt;&gt;     Am 12.05.22 um 00:06 schrieb Marek Olšák:<br>
          &gt;&gt;&gt;     3rd question: Is it worth using this on APUs?<br>
          &gt;&gt;<br>
          &gt;&gt;     It makes memory management somewhat easier when
          we are really OOM.<br>
          &gt;&gt;<br>
          &gt;&gt;     E.g. it should also work for GTT allocations and
          when the core <br>
          &gt;&gt; kernel says "Hey please free something up or I will
          start the <br>
          &gt;&gt; OOM-killer" it's something we can easily throw away.<br>
          &gt;&gt;<br>
          &gt;&gt;     Not sure how many of those buffers we have, but
          marking <br>
          &gt;&gt; everything which is temporary with that flag is
          probably a good idea.<br>
          &gt;&gt;<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;     Thanks,<br>
          &gt;&gt;&gt;     Marek<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;     On Wed, May 11, 2022 at 5:58 PM Marek Olšák
          &lt;<a href="mailto:maraeo@gmail.com" target="_blank"
            rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">maraeo@gmail.com</a> <br>
          &gt;&gt;&gt; &lt;mailto:<a href="mailto:maraeo@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;&gt;
          wrote:<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;         Will the kernel keep all discardable
          buffers in VRAM if VRAM <br>
          &gt;&gt;&gt; is not overcommitted by discardable buffers, or
          will other buffers <br>
          &gt;&gt;&gt; also affect the placement of discardable buffers?<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;<br>
          &gt;&gt;     Regarding the eviction pressure the buffers will
          be handled like <br>
          &gt;&gt; any other buffer, but instead of preserving the
          content it is just <br>
          &gt;&gt; discarded on eviction.<br>
          &gt;&gt;<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;         Do evictions deallocate the buffer, or do
          they keep an <br>
          &gt;&gt;&gt; allocation in GTT and only the copy is skipped?<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;<br>
          &gt;&gt;     It really deallocates the backing store of the
          buffer, just keeps <br>
          &gt;&gt; a dummy page array around where all entries are NULL.<br>
          &gt;&gt;<br>
          &gt;&gt;     There is a patch set on the mailing list to make
          this a little <br>
          &gt;&gt; bit more efficient, but even using the dummy page
          array should only <br>
          &gt;&gt; have a few bytes overhead.<br>
          &gt;&gt;<br>
          &gt;&gt;     Regards,<br>
          &gt;&gt;     Christian.<br>
          &gt;&gt;<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;         Thanks,<br>
          &gt;&gt;&gt;         Marek<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;         On Wed, May 11, 2022 at 3:08 AM Marek
          Olšák <br>
          &gt;&gt;&gt; &lt;<a href="mailto:maraeo@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">maraeo@gmail.com</a>
          &lt;mailto:<a href="mailto:maraeo@gmail.com" target="_blank"
            rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;&gt;
          wrote:<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;             OK that sounds good.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;             Marek<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;             On Wed, May 11, 2022 at 2:04 AM
          Christian König <br>
          &gt;&gt;&gt; &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>
          <br>
          &gt;&gt;&gt; &lt;mailto:<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;&gt;
          wrote:<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;                 Hi Marek,<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;                 Am 10.05.22 um 22:43 schrieb
          Marek Olšák:<br>
          &gt;&gt;&gt;&gt;                 A better flag name would be:<br>
          &gt;&gt;&gt;&gt;                
          AMDGPU_GEM_CREATE_BEST_PLACEMENT_OR_DISCARD<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;                 A bit long for my taste and I
          think the best <br>
          &gt;&gt;&gt; placement is just a side effect.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt;                 Marek<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt;                 On Tue, May 10, 2022 at 4:13
          PM Marek Olšák <br>
          &gt;&gt;&gt;&gt; &lt;<a href="mailto:maraeo@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">maraeo@gmail.com</a>
          &lt;mailto:<a href="mailto:maraeo@gmail.com" target="_blank"
            rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">maraeo@gmail.com</a>&gt;&gt;
          wrote:<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt;                     Does this really
          guarantee VRAM placement? The <br>
          &gt;&gt;&gt;&gt; code doesn't say anything about that.<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;                 Yes, see the code here:<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt;                         diff --git <br>
          &gt;&gt;&gt;&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
          <br>
          &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
          &gt;&gt;&gt;&gt;                         index
          8b7ee1142d9a..1944ef37a61e 100644<br>
          &gt;&gt;&gt;&gt;                         --- <br>
          &gt;&gt;&gt;&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
          &gt;&gt;&gt;&gt;                         +++ <br>
          &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
          &gt;&gt;&gt;&gt;                         @@ -567,6 +567,7 @@
          int <br>
          &gt;&gt;&gt;&gt; amdgpu_bo_create(struct amdgpu_device *adev,<br>
          &gt;&gt;&gt;&gt;                                        
          bp-&gt;domain;<br>
          &gt;&gt;&gt;&gt;                                
          bo-&gt;allowed_domains = <br>
          &gt;&gt;&gt;&gt; bo-&gt;preferred_domains;<br>
          &gt;&gt;&gt;&gt;                                 if
          (bp-&gt;type != ttm_bo_type_kernel &amp;&amp;<br>
          &gt;&gt;&gt;&gt;                         +         
           !(bp-&gt;flags &amp; <br>
          &gt;&gt;&gt;&gt; AMDGPU_GEM_CREATE_DISCARDABLE) &amp;&amp;<br>
          &gt;&gt;&gt;&gt;                                    
          bo-&gt;allowed_domains == <br>
          &gt;&gt;&gt;&gt; AMDGPU_GEM_DOMAIN_VRAM)<br>
          &gt;&gt;&gt;&gt; bo-&gt;allowed_domains |=
          AMDGPU_GEM_DOMAIN_GTT;<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;                 The only case where this could be
          circumvented is <br>
          &gt;&gt;&gt; when you try to allocate more than physically
          available on an APU.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;                 E.g. you only have something like
          32 MiB VRAM and <br>
          &gt;&gt;&gt; request 64 MiB, then the GEM code will catch the
          error and fallback <br>
          &gt;&gt;&gt; to GTT (IIRC).<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;                 Regards,<br>
          &gt;&gt;&gt;                 Christian.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------7nuj9oasAcyLOQCuaxUGxBdR--
