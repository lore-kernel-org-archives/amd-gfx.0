Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33CFAC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 09:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A24A710E651;
	Fri, 20 May 2022 09:42:19 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D49110E71A
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 09:42:18 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id gi33so6094838ejc.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to;
 bh=Am6AcZ5UmCtCrvr263L+53gMrdRgzCbBaf0jsOxwg+M=;
 b=g5ji2DBxFWZYqTuwkRX5Tm9NeNW5bPwRcdEAIU4NM7YiM/XQRPnOit2B/tjdfUdinB
 iQ3y324aODwX/j+ooQZAjqLw/dEqRRVoZordQjbBm3AebTSWvXowaq+4d9WWCwKjbpNa
 FtNPfj8labrWr/muj8mLhJjDxoh2fJeV5YdeJUkIYzcsiBP9Sdli0Qtb6LlVFj3WlWh3
 sz7C3YS+2ouYGo7ieLqgiGV0EL0DDAObrqOviSHl4xfAz3QIxpe9II75LmH6dfQGmqMY
 RpdPH7a+A4JfaCdswK/cpvPfUMfVzA702PQlpfl5SqOfC1BU3nXQ2hcO63LYY8bdsJLA
 HdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to;
 bh=Am6AcZ5UmCtCrvr263L+53gMrdRgzCbBaf0jsOxwg+M=;
 b=Cz8hARZRGLK3grrNvOIXsLfogOc0He71h5Suy8CdppA18tQ8o+/HbWZSZ2rb1hdPYT
 1c1GSCUzrL/Lj6aSubonpWCoxzLkJTSr8TOotk2IcQsYHuLIrj9vA/HTF9TrjtQMzo4Q
 l9l3diNLv0+TGsSuoVa9U0vK7b2hdwOxeEIzcPmK1uUloWaKSfu9Re0p9sQpBRjyx/zQ
 +MwV5w5rYySX7VF/TXC2RUbI5uXPEC1B72zPi6WG5jEnKo49PNVOBIlFglKYWpBHfco9
 tRzZ9CQoZihHbsM2bGSOsvPA0GtQqCnftzNUsi4N7ltNdLBcCpN1c33XyrgkARk2c+pt
 NZuw==
X-Gm-Message-State: AOAM532EUWQ57uQdQbrnpb/xveSUjugUN4YgygXrnnhwFbjH31oDedwn
 JL6tuSmVCDU5ziQcCAA4iX4zEMj9ZoQ=
X-Google-Smtp-Source: ABdhPJwXqT/SUny0qHrX7KlMdn8KaGqhBp6puHZCqIWY2pR19tFlG6PCIgPVhAAZbtjCOuyTg7dftQ==
X-Received: by 2002:a17:907:2d0e:b0:6f4:e29e:5555 with SMTP id
 gs14-20020a1709072d0e00b006f4e29e5555mr7845368ejc.552.1653039736537; 
 Fri, 20 May 2022 02:42:16 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:66f:9303:6022:1507?
 ([2a02:908:1256:79a0:66f:9303:6022:1507])
 by smtp.gmail.com with ESMTPSA id
 k23-20020aa7d8d7000000b0042aa153e73esm4064181eds.12.2022.05.20.02.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 May 2022 02:42:16 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------8gr61cOfsZZ10VFMH4rthktL"
Message-ID: <151a0478-8dbb-49c7-ab45-99dd9a1fcc2d@gmail.com>
Date: Fri, 20 May 2022 11:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] drm/amdgpu: Adjust logic around GTT size
Content-Language: en-US
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220519143446.74326-1-alexander.deucher@amd.com>
 <981e5ec0-2073-3308-0f66-488300d36065@gmail.com>
 <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com>
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
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------8gr61cOfsZZ10VFMH4rthktL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

In theory we should allow much more than that. The problem is just that 
we can't.

We have the following issues:
1. For swapping out stuff we need to make sure that we can allocate 
temporary pages.
     Because of this TTM has a fixed 50% limit where it starts to unmap 
memory from GPUs.
     So currently even with a higher GTT limit you can't actually use this.

2. Apart from the test case of allocating textures with increasing power 
of two until it fails we also have a bunch of extremely stupid applications.
     E.g. stuff like looking at the amount of memory available and 
trying preallocate everything.

I'm working on this for years, but there aren't easy solutions to those 
issues. Felix has opted out for adding a separate domain for KFD 
allocations, but sooner or later we need to find a solution which works 
for everybody.

Christian.

Am 20.05.22 um 11:14 schrieb Marek Olšák:
> Ignore the silly tests. We only need to make sure games work. The 
> current minimum requirement for running modern games is 8GB of GPU 
> memory. Soon it will be 12GB. APUs will need to support that.
>
> Marek
>
> On Fri., May 20, 2022, 03:52 Christian König, 
> <ckoenig.leichtzumerken@gmail.com> wrote:
>
>     Am 19.05.22 um 16:34 schrieb Alex Deucher:
>     > The current somewhat strange logic is in place because certain
>     > GL unit tests for large textures can cause problems with the
>     > OOM killer since there is no way to link this memory to a
>     > process.  The problem is this limit is often too low for many
>     > modern games on systems with more memory so limit the logic to
>     > systems with less than 8GB of main memory.  For systems with 8
>     > or more GB of system memory, set the GTT size to 3/4 of system
>     > memory.
>
>     It's unfortunately not only the unit tests, but some games as well.
>
>     3/4 of total system memory sounds reasonable to be, but I'm 100% sure
>     that this will break some tests.
>
>     Christian.
>
>     >
>     > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     > ---
>     >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25
>     ++++++++++++++++++++-----
>     >   1 file changed, 20 insertions(+), 5 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     > index 4b9ee6e27f74..daa0babcf869 100644
>     > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     > @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct amdgpu_device
>     *adev)
>     >       /* Compute GTT size, either bsaed on 3/4th the size of RAM
>     size
>     >        * or whatever the user passed on module init */
>     >       if (amdgpu_gtt_size == -1) {
>     > +             const u64 eight_GB = 8192ULL * 1024 * 1024;
>     >               struct sysinfo si;
>     > +             u64 total_memory, default_gtt_size;
>     >
>     >               si_meminfo(&si);
>     > -             gtt_size = min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>     > -                            adev->gmc.mc_vram_size),
>     > -                            ((uint64_t)si.totalram *
>     si.mem_unit * 3/4));
>     > -     }
>     > -     else
>     > +             total_memory = (u64)si.totalram * si.mem_unit;
>     > +             default_gtt_size = total_memory * 3 / 4;
>     > +             /* This somewhat strange logic is in place because
>     certain GL unit
>     > +              * tests for large textures can cause problems
>     with the OOM killer
>     > +              * since there is no way to link this memory to a
>     process.
>     > +              * The problem is this limit is often too low for
>     many modern games
>     > +              * on systems with more memory so limit the logic
>     to systems with
>     > +              * less than 8GB of main memory.
>     > +              */
>     > +             if (total_memory < eight_GB) {
>     > +                     gtt_size =
>     min(max((AMDGPU_DEFAULT_GTT_SIZE_MB << 20),
>     > + adev->gmc.mc_vram_size),
>     > +                                    default_gtt_size);
>     > +             } else {
>     > +                     gtt_size = default_gtt_size;
>     > +             }
>     > +     } else {
>     >               gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>     > +     }
>     >
>     >       /* Initialize GTT memory pool */
>     >       r = amdgpu_gtt_mgr_init(adev, gtt_size);
>

--------------8gr61cOfsZZ10VFMH4rthktL
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    In theory we should allow much more than that. The problem is just
    that we can't.<br>
    <br>
    We have the following issues:<br>
    1. For swapping out stuff we need to make sure that we can allocate
    temporary pages.<br>
        Because of this TTM has a fixed 50% limit where it starts to
    unmap memory from GPUs.<br>
        So currently even with a higher GTT limit you can't actually use
    this.<br>
    <br>
    2. Apart from the test case of allocating textures with increasing
    power of two until it fails we also have a bunch of extremely stupid
    applications.<br>
        E.g. stuff like looking at the amount of memory available and
    trying preallocate everything.<br>
    <br>
    I'm working on this for years, but there aren't easy solutions to
    those issues. Felix has opted out for adding a separate domain for
    KFD allocations, but sooner or later we need to find a solution
    which works for everybody.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 20.05.22 um 11:14 schrieb Marek
      Olšák:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAxE2A7iJT19myNfU8TbqqounG=Yvm1_N4aakvTbPipRxrg1gA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="auto">Ignore the silly tests. We only need to make sure
        games work. The current minimum requirement for running modern
        games is 8GB of GPU memory. Soon it will be 12GB. APUs will need
        to support that.
        <div dir="auto"><br>
        </div>
        <div dir="auto">Marek</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Fri., May 20, 2022, 03:52
          Christian König, &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true" class="moz-txt-link-freetext">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0 0 0
          .8ex;border-left:1px #ccc solid;padding-left:1ex">Am 19.05.22
          um 16:34 schrieb Alex Deucher:<br>
          &gt; The current somewhat strange logic is in place because
          certain<br>
          &gt; GL unit tests for large textures can cause problems with
          the<br>
          &gt; OOM killer since there is no way to link this memory to a<br>
          &gt; process.  The problem is this limit is often too low for
          many<br>
          &gt; modern games on systems with more memory so limit the
          logic to<br>
          &gt; systems with less than 8GB of main memory.  For systems
          with 8<br>
          &gt; or more GB of system memory, set the GTT size to 3/4 of
          system<br>
          &gt; memory.<br>
          <br>
          It's unfortunately not only the unit tests, but some games as
          well.<br>
          <br>
          3/4 of total system memory sounds reasonable to be, but I'm
          100% sure <br>
          that this will break some tests.<br>
          <br>
          Christian.<br>
          <br>
          &gt;<br>
          &gt; Signed-off-by: Alex Deucher &lt;<a
            href="mailto:alexander.deucher@amd.com" target="_blank"
            rel="noreferrer" moz-do-not-send="true"
            class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
          &gt; ---<br>
          &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 25
          ++++++++++++++++++++-----<br>
          &gt;   1 file changed, 20 insertions(+), 5 deletions(-)<br>
          &gt;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt; index 4b9ee6e27f74..daa0babcf869 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
          &gt; @@ -1801,15 +1801,30 @@ int amdgpu_ttm_init(struct
          amdgpu_device *adev)<br>
          &gt;       /* Compute GTT size, either bsaed on 3/4th the size
          of RAM size<br>
          &gt;        * or whatever the user passed on module init */<br>
          &gt;       if (amdgpu_gtt_size == -1) {<br>
          &gt; +             const u64 eight_GB = 8192ULL * 1024 * 1024;<br>
          &gt;               struct sysinfo si;<br>
          &gt; +             u64 total_memory, default_gtt_size;<br>
          &gt;   <br>
          &gt;               si_meminfo(&amp;si);<br>
          &gt; -             gtt_size =
          min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
          &gt; -                            adev-&gt;gmc.mc_vram_size),<br>
          &gt; -                            ((uint64_t)si.totalram *
          si.mem_unit * 3/4));<br>
          &gt; -     }<br>
          &gt; -     else<br>
          &gt; +             total_memory = (u64)si.totalram *
          si.mem_unit;<br>
          &gt; +             default_gtt_size = total_memory * 3 / 4;<br>
          &gt; +             /* This somewhat strange logic is in place
          because certain GL unit<br>
          &gt; +              * tests for large textures can cause
          problems with the OOM killer<br>
          &gt; +              * since there is no way to link this
          memory to a process.<br>
          &gt; +              * The problem is this limit is often too
          low for many modern games<br>
          &gt; +              * on systems with more memory so limit the
          logic to systems with<br>
          &gt; +              * less than 8GB of main memory.<br>
          &gt; +              */<br>
          &gt; +             if (total_memory &lt; eight_GB) {<br>
          &gt; +                     gtt_size =
          min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20),<br>
          &gt; +                                       
          adev-&gt;gmc.mc_vram_size),<br>
          &gt; +                                    default_gtt_size);<br>
          &gt; +             } else {<br>
          &gt; +                     gtt_size = default_gtt_size;<br>
          &gt; +             }<br>
          &gt; +     } else {<br>
          &gt;               gtt_size = (uint64_t)amdgpu_gtt_size
          &lt;&lt; 20;<br>
          &gt; +     }<br>
          &gt;   <br>
          &gt;       /* Initialize GTT memory pool */<br>
          &gt;       r = amdgpu_gtt_mgr_init(adev, gtt_size);<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------8gr61cOfsZZ10VFMH4rthktL--
