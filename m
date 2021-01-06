Return-Path: <SRS0=majj=GJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782FFC433E0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 13:02:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7403122DD3
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Jan 2021 13:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7403122DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 085596E08E;
	Wed,  6 Jan 2021 13:02:12 +0000 (UTC)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFF376E08E
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Jan 2021 13:02:10 +0000 (UTC)
Received: by mail-il1-x12a.google.com with SMTP id x15so3086832ilq.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Jan 2021 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=m7DqY8tQUt8ix3QOM9b8ek0hxEL6faH6j749wsj05wM=;
 b=I1duaJsBX3uHzY+9NWHPR5REwJs9796iWy2URyHUmMfXtQl0Xrsrb8hkEt/BlsNYNN
 UEfVBh8SaN0NwGId13mqpSigF7LbC0x+JVqMaiI5CzH5V1kRaeVm/qfUuPpcsejKlHiL
 7YDWvD+7VOrgWNgL8NLSlNbi5EoVjjHQbteGVnD9fO/v/cL/lGYJj3CZyJnTydu8/Wiz
 uudLKFGibmhrWT96Jf5QVNNVx//qv28Jgb2TlqlRAWZ1JsBIjAEL4FvHHSNdnBnYaPTn
 gK5k1BqfIgKSw5cSx9Ez9lcT/ZT9S2/t2+7viYcFqrPuj9jrlZZAHPZ47WhM94GDRhAh
 Oq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=m7DqY8tQUt8ix3QOM9b8ek0hxEL6faH6j749wsj05wM=;
 b=PhdzRqaeuhlwLiA3V9yYnSuUU1c6p1ksgqfQlpYlCxmq328MXUwGiXsls54MXHxl+7
 Rg8nv0AV4jfePT4xsIZfeV9HtxewL1YQ0FwIcFbNWeStdxr6Gx6YARkqS8oxUKQfvMtz
 ARi3+sFyCH7CrqUX+l8zII5hzNcCV9O2/nQN2wwDkk0QSx4ZAsitAWzFodSwV+/9NNoD
 6MwijfxsgWN9tF6Cn6Uxr5r+YZ9rK0FwTzq3XSNUgKOa/RCop+Jq7P0BINZ55v/zDgcq
 os4tTXxCjXUke+c6p5fXFLmXFg3jAicRfIeahovhkkswxlDxk8JTZle8OCpHfRdcflSm
 ANqg==
X-Gm-Message-State: AOAM533Wv0SpUNRlHC6v9l4kzsKX2c1HExzzMqidXvUTzn6ZTEZxqrfu
 N7rTynNadD23bXK45apqv1v9fIYO3Vr2LHvVHWJ4q8YvbUE=
X-Google-Smtp-Source: ABdhPJwdl/neyw55yk8EkWDWAwa5U0YIv15U3uVHRkjsRSRInCcZokw73uVZ2/a+ROFxZ1M71b1DHxTyKOYmZNNQUn8=
X-Received: by 2002:a05:6e02:ca5:: with SMTP id 5mr4019115ilg.40.1609938130187; 
 Wed, 06 Jan 2021 05:02:10 -0800 (PST)
MIME-Version: 1.0
References: <20210105220359.1392555-1-joshua@froggi.es>
 <CADnq5_NcKG9H-dK0Kh2ksF8et+fnFkMdsejkg_RWrNeJ1JS4ng@mail.gmail.com>
 <6d6b0ae7-f732-167b-2bc1-6e517f6c8e99@froggi.es>
 <9902861e-77bd-d6dc-7284-0ad9bcf117b6@amd.com>
 <a8f72dc6-8504-269e-56e8-699b20135a07@froggi.es>
 <4a3fe8b7-4248-e5c2-d6c0-5075596ca852@amd.com>
In-Reply-To: <4a3fe8b7-4248-e5c2-d6c0-5075596ca852@amd.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Wed, 6 Jan 2021 14:02:17 +0100
Message-ID: <CAP+8YyE2wBHAcn8H-Sr=+kKmE45kUhA=KBJL08ciZJESS4XSmA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: don't limit gtt size on apus
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexdeucher@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Joshua Ashton <joshua@froggi.es>
Content-Type: multipart/mixed; boundary="===============0451579218=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0451579218==
Content-Type: multipart/alternative; boundary="0000000000005c4dec05b83aee0e"

--0000000000005c4dec05b83aee0e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 6, 2021 at 1:54 PM Christian K=C3=B6nig <christian.koenig@amd.c=
om>
wrote:

> Am 06.01.21 um 13:47 schrieb Joshua Ashton:
> >
> >
> > On 1/6/21 7:52 AM, Christian K=C3=B6nig wrote:
> >> Am 05.01.21 um 23:31 schrieb Joshua Ashton:
> >>> On 1/5/21 10:10 PM, Alex Deucher wrote:
> >>>> On Tue, Jan 5, 2021 at 5:05 PM Joshua Ashton <joshua@froggi.es>
> wrote:
> >>>>>
> >>>>> Since commit 24562523688b ("Revert "drm/amd/amdgpu: set gtt size
> >>>>> according to system memory size only""), the GTT size was limited b=
y
> >>>>> 3GiB or VRAM size.
> >>>>
> >>>> The commit in question was to fix a hang with certain tests on APUs.
> >>>> That should be tested again before we re-enable this.  If it is fixe=
d,
> >>>> we should just revert the revert rather than special case dGPUs.
> >>>>
> >>>> Alex
> >>>>
> >>>
> >>> I think the commit before the revert (ba851eed895c) has some
> >>> fundamental problems:
> >>>
> >>> It was always specifying max(3GiB, 3/4ths RAM) of GTT, even if that
> >>> wouldn't fit into say, 1GiB or 2GiB of available RAM.
> >>>
> >>> Limiting GTT to min(max(3GiB, VRAM), 3/4ths RAM) size on dGPUs makes
> >>> sense also and is a sensible limit to avoid silly situations with
> >>> overallocation and potential OOM.
> >>>
> >>> This patch solves both of those issues.
> >>
> >> No, Alex is right this approach was already tried and it causes
> >> problems.
> >>
> >> Additional to that why should this be an issue? Even when VRAM is
> >> very small on APUs we still use 3GiB of GTT.
> >>
> >> Regards,
> >> Christian.
> >
> > The problem is that 3GiB of GTT isn't enough for most modern games.
>
> You seem to misunderstand what the GTT size means here. This is the
> amount of memory an application can lock down in a single command
> submissions.
>
> It is still possible for the game to use all of system memory for
> textures etc... it can just happen that some buffers are temporary
> marked as inaccessible for the GPU.
>

For Vulkan we (both RADV and AMDVLK) use GTT as the total size. Usage in
modern games is essentially "bindless" so there is no way to track at a
per-submission level what memory needs to be resident. (and even with
tracking applications are allowed to use all the memory in a single draw
call, which would be unsplittable anyway ...)


> > My laptop has a 128MiB carveout which is not possible to be configured
> > in the BIOS so I am stuck with that size without extra kernel
> > parameters which shouldn't be necessary.
>
> Did you ran into problems without the parameter?
>
> >
> > If you dislike the approach of keeping the extra check for dGPUs and
> > limiting GTT there, then I would say that we should use
> >     gtt_size =3D 3/4ths system memory
> > for all devices instead of
> >     gtt_size =3D max(3/4ths system memory, 3GiB)
> > as it was before the revert, as it is problematic on systems with <
> > 3GiB of system memory.
>
> Yeah, that's indeed not a good idea.
>
> Regards,
> Christian.
>
> >
> > - Joshie =F0=9F=90=B8=E2=9C=A8
> >
> >>
> >>>
> >>> - Joshie =F0=9F=90=B8=E2=9C=A8
> >>>
> >>>>
> >>>>>
> >>>>> This is problematic on APUs, especially with a small carveout
> >>>>> which can be as low as a fixed 128MiB, as there would be very a
> >>>>> limited
> >>>>> 3GiB available for video memory.
> >>>>> This obviously does not meet the demands of modern applications.
> >>>>>
> >>>>> This patch makes it so the GTT size heuristic always uses 3/4ths of
> >>>>> the system memory size on APUs (limiting the size by 3GiB/VRAM size
> >>>>> only on devices with dedicated video memory).
> >>>>>
> >>>>> Fixes: 24562523688b ("Revert drm/amd/amdgpu: set gtt size
> >>>>> according to
> >>>>> system memory size only")
> >>>>>
> >>>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> >>>>> ---
> >>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--
> >>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++++---
> >>>>>   2 files changed, 12 insertions(+), 5 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> index 72efd579ec5e..a5a41e9272d6 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> >>>>> @@ -192,8 +192,9 @@ module_param_named(gartsize, amdgpu_gart_size,
> >>>>> uint, 0600);
> >>>>>
> >>>>>   /**
> >>>>>    * DOC: gttsize (int)
> >>>>> - * Restrict the size of GTT domain in MiB for testing. The
> >>>>> default is -1 (It's VRAM size if 3GB < VRAM < 3/4 RAM,
> >>>>> - * otherwise 3/4 RAM size).
> >>>>> + * Restrict the size of GTT domain in MiB for testing. The
> >>>>> default is -1 (On APUs this is 3/4th
> >>>>> + * of the system memory; on dGPUs this is 3GiB or VRAM sized,
> >>>>> whichever is bigger,
> >>>>> + * with an upper bound of 3/4th of system memory.
> >>>>>    */
> >>>>>   MODULE_PARM_DESC(gttsize, "Size of the GTT domain in megabytes
> >>>>> (-1 =3D auto)");
> >>>>>   module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
> >>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> index 4d8f19ab1014..294f26f4f310 100644
> >>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>>>> @@ -1865,9 +1865,15 @@ int amdgpu_ttm_init(struct amdgpu_device
> >>>>> *adev)
> >>>>>                  struct sysinfo si;
> >>>>>
> >>>>>                  si_meminfo(&si);
> >>>>> -               gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_SIZE_MB <<
> >>>>> 20),
> >>>>> -                              adev->gmc.mc_vram_size),
> >>>>> -                              ((uint64_t)si.totalram *
> >>>>> si.mem_unit * 3/4));
> >>>>> +               gtt_size =3D (uint64_t)si.totalram * si.mem_unit * =
3/4;
> >>>>> +               /* If we have dedicated memory, limit our GTT size =
to
> >>>>> +                * 3GiB or VRAM size, whichever is bigger
> >>>>> +                */
> >>>>> +               if (!(adev->flags & AMD_IS_APU)) {
> >>>>> +                       gtt_size =3D
> >>>>> min(max(AMDGPU_DEFAULT_GTT_SIZE_MB << 20,
> >>>>> + adev->gmc.mc_vram_size),
> >>>>> +                               gtt_size);
> >>>>> +               }
> >>>>>          }
> >>>>>          else
> >>>>>                  gtt_size =3D (uint64_t)amdgpu_gtt_size << 20;
> >>>>> --
> >>>>> 2.30.0
> >>>>>
> >>>>> _______________________________________________
> >>>>> amd-gfx mailing list
> >>>>> amd-gfx@lists.freedesktop.org
> >>>>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cchrist=
ian.koenig%40amd.com%7C890f3f3bb9144929d52308d8b2413a35%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637455340521793984%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3Dix5qMEHXC%2BeOly4OlgZ4mbFPIGz37g0JPawHfh412wE%3D&amp;reserved=3D0
> >>>>>
> >>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000005c4dec05b83aee0e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jan 6, 2021 at 1:54 PM Christ=
ian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com">christian.ko=
enig@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Am 06.01.21 um 13:47 schrieb Joshua Ashton:<br>
&gt;<br>
&gt;<br>
&gt; On 1/6/21 7:52 AM, Christian K=C3=B6nig wrote:<br>
&gt;&gt; Am 05.01.21 um 23:31 schrieb Joshua Ashton:<br>
&gt;&gt;&gt; On 1/5/21 10:10 PM, Alex Deucher wrote:<br>
&gt;&gt;&gt;&gt; On Tue, Jan 5, 2021 at 5:05 PM Joshua Ashton &lt;<a href=
=3D"mailto:joshua@froggi.es" target=3D"_blank">joshua@froggi.es</a>&gt; wro=
te:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Since commit 24562523688b (&quot;Revert &quot;drm/amd/=
amdgpu: set gtt size<br>
&gt;&gt;&gt;&gt;&gt; according to system memory size only&quot;&quot;), the=
 GTT size was limited by<br>
&gt;&gt;&gt;&gt;&gt; 3GiB or VRAM size.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; The commit in question was to fix a hang with certain test=
s on APUs.<br>
&gt;&gt;&gt;&gt; That should be tested again before we re-enable this.=C2=
=A0 If it is fixed,<br>
&gt;&gt;&gt;&gt; we should just revert the revert rather than special case =
dGPUs.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Alex<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I think the commit before the revert (ba851eed895c) has some <=
br>
&gt;&gt;&gt; fundamental problems:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; It was always specifying max(3GiB, 3/4ths RAM) of GTT, even if=
 that <br>
&gt;&gt;&gt; wouldn&#39;t fit into say, 1GiB or 2GiB of available RAM.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Limiting GTT to min(max(3GiB, VRAM), 3/4ths RAM) size on dGPUs=
 makes <br>
&gt;&gt;&gt; sense also and is a sensible limit to avoid silly situations w=
ith <br>
&gt;&gt;&gt; overallocation and potential OOM.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; This patch solves both of those issues.<br>
&gt;&gt;<br>
&gt;&gt; No, Alex is right this approach was already tried and it causes <b=
r>
&gt;&gt; problems.<br>
&gt;&gt;<br>
&gt;&gt; Additional to that why should this be an issue? Even when VRAM is =
<br>
&gt;&gt; very small on APUs we still use 3GiB of GTT.<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;<br>
&gt; The problem is that 3GiB of GTT isn&#39;t enough for most modern games=
.<br>
<br>
You seem to misunderstand what the GTT size means here. This is the <br>
amount of memory an application can lock down in a single command <br>
submissions.<br>
<br>
It is still possible for the game to use all of system memory for <br>
textures etc... it can just happen that some buffers are temporary <br>
marked as inaccessible for the GPU.<br></blockquote><div><br></div><div>For=
 Vulkan we (both RADV and AMDVLK) use GTT as the total size. Usage in moder=
n games is essentially &quot;bindless&quot; so there is no way to track at =
a per-submission level what memory needs to be resident. (and even with tra=
cking applications are allowed to use all the memory in a single draw call,=
 which would be unsplittable anyway ...)<br></div><div> <br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; My laptop has a 128MiB carveout which is not possible to be configured=
 <br>
&gt; in the BIOS so I am stuck with that size without extra kernel <br>
&gt; parameters which shouldn&#39;t be necessary.<br>
<br>
Did you ran into problems without the parameter?<br>
<br>
&gt;<br>
&gt; If you dislike the approach of keeping the extra check for dGPUs and <=
br>
&gt; limiting GTT there, then I would say that we should use<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0gtt_size =3D 3/4ths system memory<br>
&gt; for all devices instead of<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0gtt_size =3D max(3/4ths system memory, 3GiB)<b=
r>
&gt; as it was before the revert, as it is problematic on systems with &lt;=
 <br>
&gt; 3GiB of system memory.<br>
<br>
Yeah, that&#39;s indeed not a good idea.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; - Joshie =F0=9F=90=B8=E2=9C=A8<br>
&gt;<br>
&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - Joshie =F0=9F=90=B8=E2=9C=A8<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This is problematic on APUs, especially with a small c=
arveout<br>
&gt;&gt;&gt;&gt;&gt; which can be as low as a fixed 128MiB, as there would =
be very a <br>
&gt;&gt;&gt;&gt;&gt; limited<br>
&gt;&gt;&gt;&gt;&gt; 3GiB available for video memory.<br>
&gt;&gt;&gt;&gt;&gt; This obviously does not meet the demands of modern app=
lications.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; This patch makes it so the GTT size heuristic always u=
ses 3/4ths of<br>
&gt;&gt;&gt;&gt;&gt; the system memory size on APUs (limiting the size by 3=
GiB/VRAM size<br>
&gt;&gt;&gt;&gt;&gt; only on devices with dedicated video memory).<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Fixes: 24562523688b (&quot;Revert drm/amd/amdgpu: set =
gtt size <br>
&gt;&gt;&gt;&gt;&gt; according to<br>
&gt;&gt;&gt;&gt;&gt; system memory size only&quot;)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Signed-off-by: Joshua Ashton &lt;<a href=3D"mailto:jos=
hua@froggi.es" target=3D"_blank">joshua@froggi.es</a>&gt;<br>
&gt;&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |=C2=A0=
 5 +++--<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++=
+++++++---<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 2 files changed, 12 insertions(+), 5 deletions(=
-)<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c <=
br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt;&gt;&gt;&gt; index 72efd579ec5e..a5a41e9272d6 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -192,8 +192,9 @@ module_param_named(gartsize, amdgp=
u_gart_size, <br>
&gt;&gt;&gt;&gt;&gt; uint, 0600);<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 /**<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0 * DOC: gttsize (int)<br>
&gt;&gt;&gt;&gt;&gt; - * Restrict the size of GTT domain in MiB for testing=
. The <br>
&gt;&gt;&gt;&gt;&gt; default is -1 (It&#39;s VRAM size if 3GB &lt; VRAM &lt=
; 3/4 RAM,<br>
&gt;&gt;&gt;&gt;&gt; - * otherwise 3/4 RAM size).<br>
&gt;&gt;&gt;&gt;&gt; + * Restrict the size of GTT domain in MiB for testing=
. The <br>
&gt;&gt;&gt;&gt;&gt; default is -1 (On APUs this is 3/4th<br>
&gt;&gt;&gt;&gt;&gt; + * of the system memory; on dGPUs this is 3GiB or VRA=
M sized, <br>
&gt;&gt;&gt;&gt;&gt; whichever is bigger,<br>
&gt;&gt;&gt;&gt;&gt; + * with an upper bound of 3/4th of system memory.<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0 */<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 MODULE_PARM_DESC(gttsize, &quot;Size of the GTT=
 domain in megabytes <br>
&gt;&gt;&gt;&gt;&gt; (-1 =3D auto)&quot;);<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0 module_param_named(gttsize, amdgpu_gtt_size, in=
t, 0600);<br>
&gt;&gt;&gt;&gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c <=
br>
&gt;&gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt;&gt; index 4d8f19ab1014..294f26f4f310 100644<br>
&gt;&gt;&gt;&gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt;&gt;&gt;&gt;&gt; @@ -1865,9 +1865,15 @@ int amdgpu_ttm_init(struct amdg=
pu_device <br>
&gt;&gt;&gt;&gt;&gt; *adev)<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct sysinfo si;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 si_meminfo(&amp;si);<br>
&gt;&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gtt_size =3D min(max((AMDGPU_DEFAULT_GTT_=
SIZE_MB &lt;&lt; <br>
&gt;&gt;&gt;&gt;&gt; 20),<br>
&gt;&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev-&gt;gmc.mc_vram_size)=
,<br>
&gt;&gt;&gt;&gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ((uint64_t)si.totalram * <=
br>
&gt;&gt;&gt;&gt;&gt; si.mem_unit * 3/4));<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gtt_size =3D (uint64_t)si.totalram * si.m=
em_unit * 3/4;<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If we have dedicated memory, limit our=
 GTT size to<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * 3GiB or VRAM size, whichever is b=
igger<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(adev-&gt;flags &amp; AMD_IS_APU)) {=
<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 gtt_size =3D <br>
&gt;&gt;&gt;&gt;&gt; min(max(AMDGPU_DEFAULT_GTT_SIZE_MB &lt;&lt; 20,<br>
&gt;&gt;&gt;&gt;&gt; + adev-&gt;gmc.mc_vram_size),<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gtt_size);<br>
&gt;&gt;&gt;&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else<=
br>
&gt;&gt;&gt;&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gtt_size =3D (uint64_t)amdgpu_gt=
t_size &lt;&lt; 20;<br>
&gt;&gt;&gt;&gt;&gt; -- <br>
&gt;&gt;&gt;&gt;&gt; 2.30.0<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; _______________________________________________<br>
&gt;&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" targe=
t=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt;&gt;&gt;&gt; <a href=3D"https://nam11.safelinks.protection.outlook.=
com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-g=
fx&amp;amp;data=3D04%7C01%7Cchristian.koenig%40amd.com%7C890f3f3bb9144929d5=
2308d8b2413a35%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637455340521793=
984%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=3Dix5qMEHXC%2BeOly4OlgZ4mbFPIGz37g=
0JPawHfh412wE%3D&amp;amp;reserved=3D0" rel=3D"noreferrer" target=3D"_blank"=
>https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.=
freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D04%7C01%7Cchr=
istian.koenig%40amd.com%7C890f3f3bb9144929d52308d8b2413a35%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637455340521793984%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
amp;sdata=3Dix5qMEHXC%2BeOly4OlgZ4mbFPIGz37g0JPawHfh412wE%3D&amp;amp;reserv=
ed=3D0</a> <br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div></div>

--0000000000005c4dec05b83aee0e--

--===============0451579218==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0451579218==--
