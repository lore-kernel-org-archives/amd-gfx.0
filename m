Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44187C433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 13:06:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C522422CE3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 13:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C522422CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB046E0DC;
	Wed,  6 Jan 2021 13:05:59 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F1666E0DC
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 13:05:58 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id c133so2373974wme.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 05:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=vVh8od44QB2+BRqK6OnTH08BLjIaK5ojTg9q+Gcd4Vw=;
 b=uD0SOX9U0gJB7w49FeyEFxwJo7w5CKIun4o/gf0E97h+W1OeohEAqf9PJpPdk/GkeZ
 yhSGiFw8b0xGS9leahUH0qSSHwuYnF31M1bzUiiBthajUo+cLk6YAw19XXV0oGh1Se1G
 xygnlC6ebWCKjeA9HTaANUWDNVVjTcAxvXb3sETicRZ5i/IWHpOQse+mpvfeKHaJzNVr
 W1PeYmeeF9ojMutVlX/e+5rxzhC4CHTnPjsIsL/kPhlVfbtoB4B57IvAepKSoz0BXSJf
 v6bIs9f8pLunnkP8l7wwxxld026HvR9XYiWLCGtpyBcnqNfYTe9AGCM3tL7E5bZbXSCU
 sYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=vVh8od44QB2+BRqK6OnTH08BLjIaK5ojTg9q+Gcd4Vw=;
 b=J78xLRfqVKcmFMBdFKyAfgVkIwN9PDTNqHSpQSayDZM6UrZHJzHkbO5hoSH0wBCZE7
 2mjgZgzkpsNgv4lGK+xHPwqp2Q02As2KfggMP+sld94HAcjUIgBBUOY3vGlLBOa20cDe
 pimJHHZIH2QYNSCsVH0T6GzaJFsuO50aFT+e0grjTirY0VToevAv/FzdoyA9h++qBzkW
 WfszhbwGC8VT11QLAPz3cqyfyJmHktBBjjXJe/s1WJ9yGJ9s6sP8EfJqzKRgzQbqACbs
 rt0s5iHrpQ6X20hD7BgqWsNTt4TXW4+GIMWSVIL7pE4vbpyiArdNQrMmX5/JEP7Gx72w
 5hfA==
X-Gm-Message-State: AOAM533GiigjNScxDYYdT9OkuulgrAM6BjfOsTJMC2tnh2ZfW1ih6zq+
 l4OAim4cGTHrGFTudMn4eTc=
X-Google-Smtp-Source: ABdhPJxS3yhb1sxsSrHiizIWK1vByj9EvT5Ql4SuWeCSt8PBAiAwj2Q8RcCrq78GCOgn7pQ7ugMHjA==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr3567862wmh.93.1609938356926; 
 Wed, 06 Jan 2021 05:05:56 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id i11sm2601270wmq.10.2021.01.06.05.05.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Jan 2021 05:05:56 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
 <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
 <9902861e-77bd-d6dc-7284-0ad9bcf117b6@amd.com>
 <a8f72dc6-8504-269e-56e8-699b20135a07@froggi.es>
 <4a3fe8b7-4248-e5c2-d6c0-5075596ca852@amd.com>
 <CAP+8YyE2wBHAcn8H-Sr=+kKmE45kUhA=KBJL08ciZJESS4XSmA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <66dc40b3-caed-6b3d-899d-32d1d0f74239@gmail.com>
Date: Wed, 6 Jan 2021 14:05:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAP+8YyE2wBHAcn8H-Sr=+kKmE45kUhA=KBJL08ciZJESS4XSmA@mail.gmail.com>
Content-Language: en-US
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
Reply-To: christian.koenig@amd.com
Cc: Alex Deucher <alexdeucher@gmail.com>, Joshua Ashton <joshua@froggi.es>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1122547009=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1122547009==
Content-Type: multipart/alternative;
 boundary="------------1A6D62AEEF05BEF2414F07DD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------1A6D62AEEF05BEF2414F07DD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.01.21 um 14:02 schrieb Bas Nieuwenhuizen:
>
>
> On Wed, Jan 6, 2021 at 1:54 PM Christian König 
> <christian.koenig@amd.com <mailto:christian.koenig@amd.com>> wrote:
>
>     Am 06.01.21 um 13:47 schrieb Joshua Ashton:
>     >
>     >
>     > On 1/6/21 7:52 AM, Christian König wrote:
>     >> Am 05.01.21 um 23:31 schrieb Joshua Ashton:
>     >>> On 1/5/21 10:10 PM, Alex Deucher wrote:
>     >>>> On Tue, Jan 5, 2021 at 5:05 PM Joshua Ashton
>     <joshua@froggi.es <mailto:joshua@froggi.es>> wrote:
>     >>>>>
>     >>>>> Since commit 24562523688b ("Revert "drm/amd/amdgpu: set gtt size
>     >>>>> according to system memory size only""), the GTT size was
>     limited by
>     >>>>> 3GiB or VRAM size.
>     >>>>
>     >>>> The commit in question was to fix a hang with certain tests
>     on APUs.
>     >>>> That should be tested again before we re-enable this.  If it
>     is fixed,
>     >>>> we should just revert the revert rather than special case dGPUs.
>     >>>>
>     >>>> Alex
>     >>>>
>     >>>
>     >>> I think the commit before the revert (ba851eed895c) has some
>     >>> fundamental problems:
>     >>>
>     >>> It was always specifying max(3GiB, 3/4ths RAM) of GTT, even if
>     that
>     >>> wouldn't fit into say, 1GiB or 2GiB of available RAM.
>     >>>
>     >>> Limiting GTT to min(max(3GiB, VRAM), 3/4ths RAM) size on dGPUs
>     makes
>     >>> sense also and is a sensible limit to avoid silly situations with
>     >>> overallocation and potential OOM.
>     >>>
>     >>> This patch solves both of those issues.
>     >>
>     >> No, Alex is right this approach was already tried and it causes
>     >> problems.
>     >>
>     >> Additional to that why should this be an issue? Even when VRAM is
>     >> very small on APUs we still use 3GiB of GTT.
>     >>
>     >> Regards,
>     >> Christian.
>     >
>     > The problem is that 3GiB of GTT isn't enough for most modern games.
>
>     You seem to misunderstand what the GTT size means here. This is the
>     amount of memory an application can lock down in a single command
>     submissions.
>
>     It is still possible for the game to use all of system memory for
>     textures etc... it can just happen that some buffers are temporary
>     marked as inaccessible for the GPU.
>
>
> For Vulkan we (both RADV and AMDVLK) use GTT as the total size. Usage 
> in modern games is essentially "bindless" so there is no way to track 
> at a per-submission level what memory needs to be resident. (and even 
> with tracking applications are allowed to use all the memory in a 
> single draw call, which would be unsplittable anyway ...)

Yeah, that is a really good point.

The issue is that we need some limitation since 3/4 of system memory is 
way to much and the max texture size test in piglit can cause a system 
crash.

The alternative is a better OOM handling, so that an application which 
uses to much system memory through the driver stack has a more likely 
chance to get killed. Cause currently that is either X or Wayland :(

Christian.

>
>
>     > My laptop has a 128MiB carveout which is not possible to be
>     configured
>     > in the BIOS so I am stuck with that size without extra kernel
>     > parameters which shouldn't be necessary.
>
>     Did you ran into problems without the parameter?
>
>     >
>     > If you dislike the approach of keeping the extra check for dGPUs
>     and
>     > limiting GTT there, then I would say that we should use
>     >     gtt_size = 3/4ths system memory
>     > for all devices instead of
>     >     gtt_size = max(3/4ths system memory, 3GiB)
>     > as it was before the revert, as it is problematic on systems with <
>     > 3GiB of system memory.
>
>     Yeah, that's indeed not a good idea.
>
>     Regards,
>     Christian.
>
>     >
>     > - Joshie 🐸✨
>     >
>     >>
>     >>>
>     >>> - Joshie 🐸✨
>     >>>
>     >>>>
>     >>>>>
>     >>>>> This is problematic on APUs, especially with a small carveout
>     >>>>> which can be as low as a fixed 128MiB, as there would be very a
>     >>>>> limited
>     >>>>> 3GiB available for video memory.
>     >>>>> This obviously does not meet the demands of modern applications.
>     >>>>>
>     >>>>> This patch makes it so the GTT size heuristic always uses
>     3/4ths of
>     >>>>> the system memory size on APUs (limiting the size by
>     3GiB/VRAM size
>     >>>>> only on devices with dedicated video memory).
>     >>>>>
>     >>>>> Fixes: 24562523688b ("Revert drm/amd/amdgpu: set gtt size
>     >>>>> according to
>     >>>>> system memory size only")
>     >>>>>
>     >>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es
>     <mailto:joshua@froggi.es>>
>     >>>>> ---
>     >>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--
>     >>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++++---
>     >>>>>   2 files changed, 12 insertions(+), 5 deletions(-)
>     >>>>>
>     >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     >>>>> index 72efd579ec5e..a5a41e9272d6 100644
>     >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>     >>>>> @@ -192,8 +192,9 @@ module_param_named(gartsize,
>     amdgpu_gart_size,
>     >>>>> uint, 0600);
>     >>>>>
>     >>>>>   /**
>     >>>>>    * DOC: gttsize (int)
>     >>>>> - * Restrict the size of GTT domain in MiB for testing. The
>     >>>>> default is -1 (It's VRAM size if 3GB < VRAM < 3/4 RAM,
>     >>>>> - * otherwise 3/4 RAM size).
>     >>>>> + * Restrict the size of GTT domain in MiB for testing. The
>     >>>>> default is -1 (On APUs this is 3/4th
>     >>>>> + * of the system memory; on dGPUs this is 3GiB or VRAM sized,
>     >>>>> whichever is bigger,
>     >>>>> + * with an upper bound of 3/4th of system memory.
>     >>>>>    */
>     >>>>>   MODULE_PARM_DESC(gttsize, "Size of the GTT domain in
>     megabytes
>     >>>>> (-1 = auto)");
>     >>>>>   module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
>     >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     >>>>> index 4d8f19ab1014..294f26f4f310 100644
>     >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>     >>>>> @@ -1865,9 +1865,15 @@ int amdgpu_ttm_init(struct amdgpu_device
>     >>>>> *adev)
>     >>>>>                  struct sysinfo si;
>     >>>>>
>     >>>>>                  si_meminfo(&si);
>     >>>>> -               gtt_size =
>     min(max((AMDGPU_DEFAULT_GTT_SIZE_MB <<
>     >>>>> 20),
>     >>>>> - adev->gmc.mc_vram_size),
>     >>>>> - ((uint64_t)si.totalram *
>     >>>>> si.mem_unit * 3/4));
>     >>>>> +               gtt_size = (uint64_t)si.totalram *
>     si.mem_unit * 3/4;
>     >>>>> +               /* If we have dedicated memory, limit our
>     GTT size to
>     >>>>> +                * 3GiB or VRAM size, whichever is bigger
>     >>>>> +                */
>     >>>>> +               if (!(adev->flags & AMD_IS_APU)) {
>     >>>>> +                       gtt_size =
>     >>>>> min(max(AMDGPU_DEFAULT_GTT_SIZE_MB << 20,
>     >>>>> + adev->gmc.mc_vram_size),
>     >>>>> + gtt_size);
>     >>>>> +               }
>     >>>>>          }
>     >>>>>          else
>     >>>>>                  gtt_size = (uint64_t)amdgpu_gtt_size << 20;
>     >>>>> --
>     >>>>> 2.30.0
>     >>>>>
>     >>>>> _______________________________________________
>     >>>>> amd-gfx mailing list
>     >>>>> amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     >>>>>
>     https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C890f3f3bb9144929d52308d8b2413a35%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637455340521793984%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ix5qMEHXC%2BeOly4OlgZ4mbFPIGz37g0JPawHfh412wE%3D&amp;reserved=0
>
>     >>>>>
>     >>
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------1A6D62AEEF05BEF2414F07DD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Am 06.01.21 um 14:02 schrieb Bas
      Nieuwenhuizen:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAP+8YyE2wBHAcn8H-Sr=+kKmE45kUhA=KBJL08ciZJESS4XSmA@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">
        <div dir="ltr"><br>
        </div>
        <br>
        <div class="gmail_quote">
          <div dir="ltr" class="gmail_attr">On Wed, Jan 6, 2021 at 1:54
            PM Christian König &lt;<a
              href="mailto:christian.koenig@amd.com"
              moz-do-not-send="true">christian.koenig@amd.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">Am 06.01.21 um 13:47
            schrieb Joshua Ashton:<br>
            &gt;<br>
            &gt;<br>
            &gt; On 1/6/21 7:52 AM, Christian König wrote:<br>
            &gt;&gt; Am 05.01.21 um 23:31 schrieb Joshua Ashton:<br>
            &gt;&gt;&gt; On 1/5/21 10:10 PM, Alex Deucher wrote:<br>
            &gt;&gt;&gt;&gt; On Tue, Jan 5, 2021 at 5:05 PM Joshua
            Ashton &lt;<a href="mailto:joshua@froggi.es" target="_blank"
              moz-do-not-send="true">joshua@froggi.es</a>&gt; wrote:<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; Since commit 24562523688b ("Revert
            "drm/amd/amdgpu: set gtt size<br>
            &gt;&gt;&gt;&gt;&gt; according to system memory size
            only""), the GTT size was limited by<br>
            &gt;&gt;&gt;&gt;&gt; 3GiB or VRAM size.<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; The commit in question was to fix a hang
            with certain tests on APUs.<br>
            &gt;&gt;&gt;&gt; That should be tested again before we
            re-enable this.  If it is fixed,<br>
            &gt;&gt;&gt;&gt; we should just revert the revert rather
            than special case dGPUs.<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; Alex<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; I think the commit before the revert
            (ba851eed895c) has some <br>
            &gt;&gt;&gt; fundamental problems:<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; It was always specifying max(3GiB, 3/4ths RAM)
            of GTT, even if that <br>
            &gt;&gt;&gt; wouldn't fit into say, 1GiB or 2GiB of
            available RAM.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Limiting GTT to min(max(3GiB, VRAM), 3/4ths
            RAM) size on dGPUs makes <br>
            &gt;&gt;&gt; sense also and is a sensible limit to avoid
            silly situations with <br>
            &gt;&gt;&gt; overallocation and potential OOM.<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; This patch solves both of those issues.<br>
            &gt;&gt;<br>
            &gt;&gt; No, Alex is right this approach was already tried
            and it causes <br>
            &gt;&gt; problems.<br>
            &gt;&gt;<br>
            &gt;&gt; Additional to that why should this be an issue?
            Even when VRAM is <br>
            &gt;&gt; very small on APUs we still use 3GiB of GTT.<br>
            &gt;&gt;<br>
            &gt;&gt; Regards,<br>
            &gt;&gt; Christian.<br>
            &gt;<br>
            &gt; The problem is that 3GiB of GTT isn't enough for most
            modern games.<br>
            <br>
            You seem to misunderstand what the GTT size means here. This
            is the <br>
            amount of memory an application can lock down in a single
            command <br>
            submissions.<br>
            <br>
            It is still possible for the game to use all of system
            memory for <br>
            textures etc... it can just happen that some buffers are
            temporary <br>
            marked as inaccessible for the GPU.<br>
          </blockquote>
          <div><br>
          </div>
          <div>For Vulkan we (both RADV and AMDVLK) use GTT as the total
            size. Usage in modern games is essentially "bindless" so
            there is no way to track at a per-submission level what
            memory needs to be resident. (and even with tracking
            applications are allowed to use all the memory in a single
            draw call, which would be unsplittable anyway ...)<br>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    Yeah, that is a really good point.<br>
    <br>
    The issue is that we need some limitation since 3/4 of system memory
    is way to much and the max texture size test in piglit can cause a
    system crash.<br>
    <br>
    The alternative is a better OOM handling, so that an application
    which uses to much system memory through the driver stack has a more
    likely chance to get killed. Cause currently that is either X or
    Wayland :(<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAP+8YyE2wBHAcn8H-Sr=+kKmE45kUhA=KBJL08ciZJESS4XSmA@mail.gmail.com">
      <div dir="ltr">
        <div class="gmail_quote">
          <div> <br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px
            0.8ex;border-left:1px solid
            rgb(204,204,204);padding-left:1ex">
            <br>
            &gt; My laptop has a 128MiB carveout which is not possible
            to be configured <br>
            &gt; in the BIOS so I am stuck with that size without extra
            kernel <br>
            &gt; parameters which shouldn't be necessary.<br>
            <br>
            Did you ran into problems without the parameter?<br>
            <br>
            &gt;<br>
            &gt; If you dislike the approach of keeping the extra check
            for dGPUs and <br>
            &gt; limiting GTT there, then I would say that we should use<br>
            &gt;     gtt_size = 3/4ths system memory<br>
            &gt; for all devices instead of<br>
            &gt;     gtt_size = max(3/4ths system memory, 3GiB)<br>
            &gt; as it was before the revert, as it is problematic on
            systems with &lt; <br>
            &gt; 3GiB of system memory.<br>
            <br>
            Yeah, that's indeed not a good idea.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            &gt;<br>
            &gt; - Joshie 🐸✨<br>
            &gt;<br>
            &gt;&gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; - Joshie 🐸✨<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; This is problematic on APUs, especially
            with a small carveout<br>
            &gt;&gt;&gt;&gt;&gt; which can be as low as a fixed 128MiB,
            as there would be very a <br>
            &gt;&gt;&gt;&gt;&gt; limited<br>
            &gt;&gt;&gt;&gt;&gt; 3GiB available for video memory.<br>
            &gt;&gt;&gt;&gt;&gt; This obviously does not meet the
            demands of modern applications.<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; This patch makes it so the GTT size
            heuristic always uses 3/4ths of<br>
            &gt;&gt;&gt;&gt;&gt; the system memory size on APUs
            (limiting the size by 3GiB/VRAM size<br>
            &gt;&gt;&gt;&gt;&gt; only on devices with dedicated video
            memory).<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; Fixes: 24562523688b ("Revert
            drm/amd/amdgpu: set gtt size <br>
            &gt;&gt;&gt;&gt;&gt; according to<br>
            &gt;&gt;&gt;&gt;&gt; system memory size only")<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; Signed-off-by: Joshua Ashton &lt;<a
              href="mailto:joshua@froggi.es" target="_blank"
              moz-do-not-send="true">joshua@froggi.es</a>&gt;<br>
            &gt;&gt;&gt;&gt;&gt; ---<br>
            &gt;&gt;&gt;&gt;&gt;  
            drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--<br>
            &gt;&gt;&gt;&gt;&gt;  
            drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++++---<br>
            &gt;&gt;&gt;&gt;&gt;   2 files changed, 12 insertions(+), 5
            deletions(-)<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c <br>
            &gt;&gt;&gt;&gt;&gt;
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt;&gt;&gt;&gt;&gt; index 72efd579ec5e..a5a41e9272d6 100644<br>
            &gt;&gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt;&gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
            &gt;&gt;&gt;&gt;&gt; @@ -192,8 +192,9 @@
            module_param_named(gartsize, amdgpu_gart_size, <br>
            &gt;&gt;&gt;&gt;&gt; uint, 0600);<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;   /**<br>
            &gt;&gt;&gt;&gt;&gt;    * DOC: gttsize (int)<br>
            &gt;&gt;&gt;&gt;&gt; - * Restrict the size of GTT domain in
            MiB for testing. The <br>
            &gt;&gt;&gt;&gt;&gt; default is -1 (It's VRAM size if 3GB
            &lt; VRAM &lt; 3/4 RAM,<br>
            &gt;&gt;&gt;&gt;&gt; - * otherwise 3/4 RAM size).<br>
            &gt;&gt;&gt;&gt;&gt; + * Restrict the size of GTT domain in
            MiB for testing. The <br>
            &gt;&gt;&gt;&gt;&gt; default is -1 (On APUs this is 3/4th<br>
            &gt;&gt;&gt;&gt;&gt; + * of the system memory; on dGPUs this
            is 3GiB or VRAM sized, <br>
            &gt;&gt;&gt;&gt;&gt; whichever is bigger,<br>
            &gt;&gt;&gt;&gt;&gt; + * with an upper bound of 3/4th of
            system memory.<br>
            &gt;&gt;&gt;&gt;&gt;    */<br>
            &gt;&gt;&gt;&gt;&gt;   MODULE_PARM_DESC(gttsize, "Size of
            the GTT domain in megabytes <br>
            &gt;&gt;&gt;&gt;&gt; (-1 = auto)");<br>
            &gt;&gt;&gt;&gt;&gt;   module_param_named(gttsize,
            amdgpu_gtt_size, int, 0600);<br>
            &gt;&gt;&gt;&gt;&gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c <br>
            &gt;&gt;&gt;&gt;&gt;
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
            &gt;&gt;&gt;&gt;&gt; index 4d8f19ab1014..294f26f4f310 100644<br>
            &gt;&gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
            &gt;&gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
            &gt;&gt;&gt;&gt;&gt; @@ -1865,9 +1865,15 @@ int
            amdgpu_ttm_init(struct amdgpu_device <br>
            &gt;&gt;&gt;&gt;&gt; *adev)<br>
            &gt;&gt;&gt;&gt;&gt;                  struct sysinfo si;<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;                  si_meminfo(&amp;si);<br>
            &gt;&gt;&gt;&gt;&gt; -               gtt_size =
            min(max((AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; <br>
            &gt;&gt;&gt;&gt;&gt; 20),<br>
            &gt;&gt;&gt;&gt;&gt; -                             
            adev-&gt;gmc.mc_vram_size),<br>
            &gt;&gt;&gt;&gt;&gt; -                             
            ((uint64_t)si.totalram * <br>
            &gt;&gt;&gt;&gt;&gt; si.mem_unit * 3/4));<br>
            &gt;&gt;&gt;&gt;&gt; +               gtt_size =
            (uint64_t)si.totalram * si.mem_unit * 3/4;<br>
            &gt;&gt;&gt;&gt;&gt; +               /* If we have dedicated
            memory, limit our GTT size to<br>
            &gt;&gt;&gt;&gt;&gt; +                * 3GiB or VRAM size,
            whichever is bigger<br>
            &gt;&gt;&gt;&gt;&gt; +                */<br>
            &gt;&gt;&gt;&gt;&gt; +               if (!(adev-&gt;flags
            &amp; AMD_IS_APU)) {<br>
            &gt;&gt;&gt;&gt;&gt; +                       gtt_size = <br>
            &gt;&gt;&gt;&gt;&gt; min(max(AMDGPU_DEFAULT_GTT_SIZE_MB
            &lt;&lt; 20,<br>
            &gt;&gt;&gt;&gt;&gt; + adev-&gt;gmc.mc_vram_size),<br>
            &gt;&gt;&gt;&gt;&gt; +                              
            gtt_size);<br>
            &gt;&gt;&gt;&gt;&gt; +               }<br>
            &gt;&gt;&gt;&gt;&gt;          }<br>
            &gt;&gt;&gt;&gt;&gt;          else<br>
            &gt;&gt;&gt;&gt;&gt;                  gtt_size =
            (uint64_t)amdgpu_gtt_size &lt;&lt; 20;<br>
            &gt;&gt;&gt;&gt;&gt; -- <br>
            &gt;&gt;&gt;&gt;&gt; 2.30.0<br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt;&gt;
            _______________________________________________<br>
            &gt;&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
            &gt;&gt;&gt;&gt;&gt; <a
              href="mailto:amd-gfx@lists.freedesktop.org"
              target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
            &gt;&gt;&gt;&gt;&gt; <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C890f3f3bb9144929d52308d8b2413a35%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637455340521793984%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=ix5qMEHXC%2BeOly4OlgZ4mbFPIGz37g0JPawHfh412wE%3D&amp;amp;reserved=0"
              rel="noreferrer" target="_blank" moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7Cchristian.koenig%40amd.com%7C890f3f3bb9144929d52308d8b2413a35%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637455340521793984%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=ix5qMEHXC%2BeOly4OlgZ4mbFPIGz37g0JPawHfh412wE%3D&amp;amp;reserved=0</a>
            <br>
            &gt;&gt;&gt;&gt;&gt;<br>
            &gt;&gt;<br>
            <br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a href="mailto:amd-gfx@lists.freedesktop.org"
              target="_blank" moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
            <a
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
              rel="noreferrer" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </blockquote>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------1A6D62AEEF05BEF2414F07DD--

--===============1122547009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1122547009==--
