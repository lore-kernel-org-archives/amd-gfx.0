Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E19C433EF
	for <amd-gfx@archiver.kernel.org>; Sun, 22 May 2022 08:03:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1F2610E440;
	Sun, 22 May 2022 08:03:06 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BC510E440
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 May 2022 08:03:05 +0000 (UTC)
Received: by mail-ej1-x635.google.com with SMTP id rs12so11157254ejb.13
 for <amd-gfx@lists.freedesktop.org>; Sun, 22 May 2022 01:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=ia5xChaIWjY5HtUWs+EdVNXPobZ93w/+/QOUR3NSeAU=;
 b=VJtny523IQ4s2h/SAlYDv6cbF3meo/J7o8y4v0kbsp5fSxziaVyYgN6isPzjMDY49p
 g8w8EvpXxUSljSjklrCVMKpWsxOrA/nbx7cKo3LTUiW9rB3tCmYXq9d0Ycs1QI7YIOTA
 XV8qFug5uvmKkd2GZGooFBCsT8jOOpuH49eOpFtBp7fSl8p23stQ+NmPV5SETu+5DHde
 moSvRQuZmcdK/WzJh62mCHnBr4e5dN8mDsr0rM36kalXrDc2XogZUQ0VNtO5tYJHaIaS
 Wegd6s9vHLYhl1PA15jOvh8Hiqz2xHjO4NL1x1qMhMUAcyLwWQ4Swq4VYkb9gd3ucvt8
 yBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=ia5xChaIWjY5HtUWs+EdVNXPobZ93w/+/QOUR3NSeAU=;
 b=Y3ZIk4GaIhGLVj5GaE5LvZs1pmQ19NW1rYS11IzRMbWGoN4N9CYXd1xEB5O5UXttEO
 iKwJE0sIrw3c90juG5a2UxgrknEfb2vs3UL/jeZHW+JdH3MaV0CW8Vy1DgEEnGAfBMwW
 e3871I6p/pV7ZViODOD7jNscfRbdBv0A27q5SS05eYUdYIJCEyktvxTT6uLTw64YD+4G
 7xEcNyvd4XRA9uZnP2fpCr5PobbPn8wOWDdttCLXBs5YKisLFFU6+xkrYjVYH1GMb3C7
 wI9RMKywf7wPZd6xJHYFB7f6CxZSGXAS4sVvQNsX97Ydz1Hp9Zkp+O1odnrq3x4D6qc7
 Aobw==
X-Gm-Message-State: AOAM5331qSoThE6xfOOWYhAT2Tqr/GHv88wnj0lMbEbzrcR7GLKSIXlJ
 7XkOUt/iis7+JKvi7NoY0+g=
X-Google-Smtp-Source: ABdhPJzWXnBm+4HjXQyoL8rb0aZwTzAClWZq/UojA8SghC9MxVPGSYly2PM23uIUzhMI3tvo4FIySw==
X-Received: by 2002:a17:907:3f07:b0:6fe:d41c:d4e1 with SMTP id
 hq7-20020a1709073f0700b006fed41cd4e1mr1084639ejc.669.1653206584116; 
 Sun, 22 May 2022 01:03:04 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:1fdf:8458:52e0:2b2b?
 ([2a02:908:1256:79a0:1fdf:8458:52e0:2b2b])
 by smtp.gmail.com with ESMTPSA id
 r2-20020a170906550200b006f3ef214de1sm4933119ejp.71.2022.05.22.01.03.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 May 2022 01:03:03 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------X0laUCfMF2dNG1M4RyqZMsN7"
Message-ID: <7de98c6b-0934-25f4-955f-3362d1cbe954@gmail.com>
Date: Sun, 22 May 2022 10:03:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
 <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
 <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
 <CAP+8YyHE79regLR47v29G_qmitR-WOfjOQR-R1nNf5aMVVqFbA@mail.gmail.com>
 <67d39c05-d798-9515-5dec-7a2c4eb534d0@gmail.com>
 <CAAxE2A7opvBLs-VgfyNSSRRctmomZjM7y0C5s8FNuhR2V2Mt5w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A7opvBLs-VgfyNSSRRctmomZjM7y0C5s8FNuhR2V2Mt5w@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------X0laUCfMF2dNG1M4RyqZMsN7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Well, it's not arguing. I'm just pointing out the problems.

Those issues were discovered because I'm trying to raise the limit for a 
couple of years now.

I've also already hacked together the necessary functionality, but 
upstreaming them has caused other issues which I don't have time to solve.

If you have time to tackle those, I'm happy to push the necessary 
patches upstream.

Regards,
Christian.

Am 20.05.22 um 23:36 schrieb Marek Olšák:
> We don't have to care about case 2 here. Broken apps will be handled 
> by app profiles. The problem is that some games don't work with the 
> current limit on the most powerful consumer APU we've ever made 
> (Rembrandt) with precisely the games that the APU was made for, and 
> instead of increasing the limit, we continue arguing about some TTM 
> stuff that doesn't help anything right now.
>
> Marek
>
> On Fri., May 20, 2022, 14:25 Christian König, 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     Am 20.05.22 um 19:41 schrieb Bas Nieuwenhuizen:
>     > On Fri, May 20, 2022 at 11:42 AM Christian König
>     > <ckoenig.leichtzumerken@gmail.com> wrote:
>     >> In theory we should allow much more than that. The problem is
>     just that we can't.
>     >>
>     >> We have the following issues:
>     >> 1. For swapping out stuff we need to make sure that we can
>     allocate temporary pages.
>     >>      Because of this TTM has a fixed 50% limit where it starts
>     to unmap memory from GPUs.
>     >>      So currently even with a higher GTT limit you can't
>     actually use this.
>     >>
>     >> 2. Apart from the test case of allocating textures with
>     increasing power of two until it fails we also have a bunch of
>     extremely stupid applications.
>     >>      E.g. stuff like looking at the amount of memory available
>     and trying preallocate everything.
>     > I hear you but we also have an increasing number of games that don't
>     > even start with 3 GiB. At some point (which I'd speculate has
>     already
>     > been reached, I've seen a number of complaints of games that ran on
>     > deck but not on desktop linux because on deck we set amdgpu.gttsize)
>     > we have more games broken due to the low limit than there would be
>     > apps broken due to a high limit.
>
>     That's a really good argument, but the issue is that it is
>     fixable. It's
>     just that nobody had time to look into all the issues.
>
>     If started efforts to fix this years ago, but there was always
>     something
>     more important going on.
>
>     So we are left with the choice of breaking old applications or new
>     applications or getting somebody working on fixing this.
>
>     Christian.
>
>     >
>     >> I'm working on this for years, but there aren't easy solutions
>     to those issues. Felix has opted out for adding a separate domain
>     for KFD allocations, but sooner or later we need to find a
>     solution which works for everybody.
>     >>
>     >> Christian.
>     >>
>     >> Am 20.05.22 um 11:14 schrieb Marek Olšák:
>     >>
>     >> Ignore the silly tests. We only need to make sure games work.
>     The current minimum requirement for running modern games is 8GB of
>     GPU memory. Soon it will be 12GB. APUs will need to support that.
>     >>
>     >> Marek
>     >>
>     >> On Fri., May 20, 2022, 03:52 Christian König,
>     <ckoenig.leichtzumerken@gmail.com> wrote:
>     >>> Am 19.05.22 um 16:34 schrieb Alex Deucher:
>     >>>> The current somewhat strange logic is in place because certain
>     >>>> GL unit tests for large textures can cause problems with the
>     >>>> OOM killer since there is no way to link this memory to a
>     >>>> process.  The problem is this limit is often too low for many
>     >>>> modern games on systems with more memory so limit the logic to
>     >>>> systems with less than 8GB of main memory. For systems with 8
>     >>>> or more GB of system memory, set the GTT size to 3/4 of system
>     >>>> memory.
>     >>> It's unfortunately not only the unit tests, but some games as
>     well.
>     >>>
>     >>> 3/4 of total system memory sounds reasonable to be, but I'm
>     100% sure
>     >>> that this will break some tests.
>     >>>
>     >>> Christian.
>     >>>
>     >>>> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     >>>> ---
>     >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25
>     ++++++++++++++++++++-----
>     >>>>    1 file changed, 20 insertions(+), 5 deletions(-)
>     >>>>
>     >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     >>>> index 4b9ee6e27f74..daa0babcf869 100644
>     >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     >>>> @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct
>     amdgpu_device *adev)
>     >>>>        /* Compute GTT size, either bsaed on 3/4th the size of
>     RAM size
>     >>>>         * or whatever the user passed on module init */
>     >>>>        if (amdgpu_gtt_size == -1) {
>     >>>> +             const u64 eight_GB = 8192ULL * 1024 * 1024;
>     >>>>                struct sysinfo si;
>     >>>> +             u64 total_memory, default_gtt_size;
>     >>>>
>     >>>>                si_meminfo(&si);
>     >>>> -             gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB
>     << 20),
>     >>>> - adev->gmc.mc_vram_size),
>     >>>> - ((uint64_t)si.totalram * si.mem_unit * 3/4));
>     >>>> -     }
>     >>>> -     else
>     >>>> +             total_memory = (u64)si.totalram * si.mem_unit;
>     >>>> +             default_gtt_size = total_memory * 3 / 4;
>     >>>> +             /* This somewhat strange logic is in place
>     because certain GL unit
>     >>>> +              * tests for large textures can cause problems
>     with the OOM killer
>     >>>> +              * since there is no way to link this memory to
>     a process.
>     >>>> +              * The problem is this limit is often too low
>     for many modern games
>     >>>> +              * on systems with more memory so limit the
>     logic to systems with
>     >>>> +              * less than 8GB of main memory.
>     >>>> +              */
>     >>>> +             if (total_memory < eight_GB) {
>     >>>> +                     gtt_size =
>     min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>     >>>> + adev->gmc.mc_vram_size),
>     >>>> + default_gtt_size);
>     >>>> +             } else {
>     >>>> +                     gtt_size = default_gtt_size;
>     >>>> +             }
>     >>>> +     } else {
>     >>>>                gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>     >>>> +     }
>     >>>>
>     >>>>        /* Initialize GTT memory pool */
>     >>>>        r = amdgpu_gtt_mgr_init(adev, gtt_size);
>

--------------X0laUCfMF2dNG1M4RyqZMsN7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Well, it's not arguing. I'm just pointing out the problems.<br>
    <br>
    Those issues were discovered because I'm trying to raise the limit
    for a couple of years now.<br>
    <br>
    I've also already hacked together the necessary functionality, but
    upstreaming them has caused other issues which I don't have time to
    solve.<br>
    <br>
    If you have time to tackle those, I'm happy to push the necessary
    patches upstream.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 20.05.22 um 23:36 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A7opvBLs-VgfyNSSRRctmomZjM7y0C5s8FNuhR2V2Mt5w@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">We don't have to care about case 2 here. Broken
        apps will be handled by app profiles. The problem is that some
        games don't work with the current limit on the most powerful
        consumer APU we've ever made (Rembrandt) with precisely the
        games that the APU was made for, and instead of increasing the
        limit, we continue arguing about some TTM stuff that doesn't
        help anything right now.
        <div dir="auto">
          <div dir="auto"><br>
          </div>
          <div dir="auto">Marek</div>
        </div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri., May 20, 2022, 14:25
          Christian König, &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Am 20.05.22
          um 19:41 schrieb Bas Nieuwenhuizen:<br>
          &gt; On Fri, May 20, 2022 at 11:42 AM Christian König<br>
          &gt; &lt;<a href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
          &gt;&gt; In theory we should allow much more than that. The
          problem is just that we can't.<br>
          &gt;&gt;<br>
          &gt;&gt; We have the following issues:<br>
          &gt;&gt; 1. For swapping out stuff we need to make sure that
          we can allocate temporary pages.<br>
          &gt;&gt;      Because of this TTM has a fixed 50% limit where
          it starts to unmap memory from GPUs.<br>
          &gt;&gt;      So currently even with a higher GTT limit you
          can't actually use this.<br>
          &gt;&gt;<br>
          &gt;&gt; 2. Apart from the test case of allocating textures
          with increasing power of two until it fails we also have a
          bunch of extremely stupid applications.<br>
          &gt;&gt;      E.g. stuff like looking at the amount of memory
          available and trying preallocate everything.<br>
          &gt; I hear you but we also have an increasing number of games
          that don't<br>
          &gt; even start with 3 GiB. At some point (which I'd speculate
          has already<br>
          &gt; been reached, I've seen a number of complaints of games
          that ran on<br>
          &gt; deck but not on desktop linux because on deck we set
          amdgpu.gttsize)<br>
          &gt; we have more games broken due to the low limit than there
          would be<br>
          &gt; apps broken due to a high limit.<br>
          <br>
          That's a really good argument, but the issue is that it is
          fixable. It's <br>
          just that nobody had time to look into all the issues.<br>
          <br>
          If started efforts to fix this years ago, but there was always
          something <br>
          more important going on.<br>
          <br>
          So we are left with the choice of breaking old applications or
          new <br>
          applications or getting somebody working on fixing this.<br>
          <br>
          Christian.<br>
          <br>
          &gt;<br>
          &gt;&gt; I'm working on this for years, but there aren't easy
          solutions to those issues. Felix has opted out for adding a
          separate domain for KFD allocations, but sooner or later we
          need to find a solution which works for everybody.<br>
          &gt;&gt;<br>
          &gt;&gt; Christian.<br>
          &gt;&gt;<br>
          &gt;&gt; Am 20.05.22 um 11:14 schrieb Marek Olšák:<br>
          &gt;&gt;<br>
          &gt;&gt; Ignore the silly tests. We only need to make sure
          games work. The current minimum requirement for running modern
          games is 8GB of GPU memory. Soon it will be 12GB. APUs will
          need to support that.<br>
          &gt;&gt;<br>
          &gt;&gt; Marek<br>
          &gt;&gt;<br>
          &gt;&gt; On Fri., May 20, 2022, 03:52 Christian König, &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
          &gt;&gt;&gt; Am 19.05.22 um 16:34 schrieb Alex Deucher:<br>
          &gt;&gt;&gt;&gt; The current somewhat strange logic is in
          place because certain<br>
          &gt;&gt;&gt;&gt; GL unit tests for large textures can cause
          problems with the<br>
          &gt;&gt;&gt;&gt; OOM killer since there is no way to link this
          memory to a<br>
          &gt;&gt;&gt;&gt; process.  The problem is this limit is often
          too low for many<br>
          &gt;&gt;&gt;&gt; modern games on systems with more memory so
          limit the logic to<br>
          &gt;&gt;&gt;&gt; systems with less than 8GB of main memory. 
          For systems with 8<br>
          &gt;&gt;&gt;&gt; or more GB of system memory, set the GTT size
          to 3/4 of system<br>
          &gt;&gt;&gt;&gt; memory.<br>
          &gt;&gt;&gt; It's unfortunately not only the unit tests, but
          some games as well.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; 3/4 of total system memory sounds reasonable to
          be, but I'm 100% sure<br>
          &gt;&gt;&gt; that this will break some tests.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt; Christian.<br>
          &gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt; Signed-off-by: Alex Deucher &lt;<a
            href="mailto:alexander.deucher@amd.com" target="_blank"
            rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
          &gt;&gt;&gt;&gt; ---<br>
          &gt;&gt;&gt;&gt;    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |
          25 ++++++++++++++++++++-----<br>
          &gt;&gt;&gt;&gt;    1 file changed, 20 insertions(+), 5
          deletions(-)<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt;&gt;&gt;&gt; index 4b9ee6e27f74..daa0babcf869 100644<br>
          &gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt;&gt;&gt;&gt; @@ -1801,15 +1801,30 @@ int
          amdgpu_ttm_init(struct amdgpu_device *adev)<br>
          &gt;&gt;&gt;&gt;        /* Compute GTT size, either bsaed on
          3/4th the size of RAM size<br>
          &gt;&gt;&gt;&gt;         * or whatever the user passed on
          module init */<br>
          &gt;&gt;&gt;&gt;        if (amdgpu_gtt_size == -1) {<br>
          &gt;&gt;&gt;&gt; +             const u64 eight_GB = 8192ULL *
          1024 * 1024;<br>
          &gt;&gt;&gt;&gt;                struct sysinfo si;<br>
          &gt;&gt;&gt;&gt; +             u64 total_memory,
          default_gtt_size;<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt;                si_meminfo(&amp;si);<br>
          &gt;&gt;&gt;&gt; -             gtt_size =
          min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
          &gt;&gt;&gt;&gt; -                           
          adev-&gt;gmc.mc_vram_size),<br>
          &gt;&gt;&gt;&gt; -                           
          ((uint64_t)si.totalram * si.mem_unit * 3/4));<br>
          &gt;&gt;&gt;&gt; -     }<br>
          &gt;&gt;&gt;&gt; -     else<br>
          &gt;&gt;&gt;&gt; +             total_memory = (u64)si.totalram
          * si.mem_unit;<br>
          &gt;&gt;&gt;&gt; +             default_gtt_size = total_memory
          * 3 / 4;<br>
          &gt;&gt;&gt;&gt; +             /* This somewhat strange logic
          is in place because certain GL unit<br>
          &gt;&gt;&gt;&gt; +              * tests for large textures can
          cause problems with the OOM killer<br>
          &gt;&gt;&gt;&gt; +              * since there is no way to
          link this memory to a process.<br>
          &gt;&gt;&gt;&gt; +              * The problem is this limit is
          often too low for many modern games<br>
          &gt;&gt;&gt;&gt; +              * on systems with more memory
          so limit the logic to systems with<br>
          &gt;&gt;&gt;&gt; +              * less than 8GB of main
          memory.<br>
          &gt;&gt;&gt;&gt; +              */<br>
          &gt;&gt;&gt;&gt; +             if (total_memory &lt; eight_GB)
          {<br>
          &gt;&gt;&gt;&gt; +                     gtt_size =
          min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
          &gt;&gt;&gt;&gt; +                                       
          adev-&gt;gmc.mc_vram_size),<br>
          &gt;&gt;&gt;&gt; +                                   
          default_gtt_size);<br>
          &gt;&gt;&gt;&gt; +             } else {<br>
          &gt;&gt;&gt;&gt; +                     gtt_size =
          default_gtt_size;<br>
          &gt;&gt;&gt;&gt; +             }<br>
          &gt;&gt;&gt;&gt; +     } else {<br>
          &gt;&gt;&gt;&gt;                gtt_size =
          (uint64_t)amdgpu_gtt_size &lt;&lt; 20;<br>
          &gt;&gt;&gt;&gt; +     }<br>
          &gt;&gt;&gt;&gt;<br>
          &gt;&gt;&gt;&gt;        /* Initialize GTT memory pool */<br>
          &gt;&gt;&gt;&gt;        r = amdgpu_gtt_mgr_init(adev,
          gtt_size);<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------X0laUCfMF2dNG1M4RyqZMsN7--
