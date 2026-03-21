Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A480B1099B3C
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 02:34:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39A1310E248;
	Sat, 21 Mar 2026 02:34:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QAgDjYRf";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A833510E249
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2026 02:34:27 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-126ea4b77adso2563319c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 19:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774060467; cv=none;
 d=google.com; s=arc-20240605;
 b=c8A5B8KeU6dF49roauP1FVAvGJTcyRGyeOs3aOStgmXBQ/vf0ZhLwUpSziYJyInbHw
 VNnlegAdNXcuT0OfWgetshNadwZDXD1mbs4ihHXooQF3nnp3tX8kMOj9nV+nkF5oRfta
 lC5+uSH8glZooyqsjJFzlroCFV1HERpjxEs/b54ArEwXgXDCOaxtdHbG1D87aHQYiYax
 NV8IS4w5L7c0lqlHmaLkTKwlGfy6xpVHlsZd0bW56if4LoF2UkLMcM5ysQIzuAAxBjjK
 r9JpZuCi6Q5xGXdfV4XCttLi0rnkSCBYF576cRoDBCbpnWvQch8BWpKaFuhNHwk3QO/c
 kRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4Q3kqLc2+DATRyIjfQQzda1s2xOQFKyxST9nwoPM2ss=;
 fh=06G8Jf2dL1fNZx7IHOd4sXnhxuzSBVJnzZy8pqZ4PeU=;
 b=gZqr6R2bMZEfpV51pm1w3opBJ3/fQFPvovVnmQMaPvVqrGPC8SXDS+5zwinSkuUPaD
 KEXUtN+l/F/ikaeTjVnWz4kaBV2Q9/uqxz7S78sD2WNQbeI9xx6qw+I/Ulcl82uuwbcu
 DPGfDKi1yjlupdQ7ZdjVZmIRveBRUl9Hus6RnSdk6if3ppdDO0Z90omR6hIlqzp7hl1V
 DfK6tN9D6Uzq4ty0ahO0PnstvxUhdY8WQEF8/r2GFJzQZxbP7QS92QQ2K8i77xJc1KKX
 JOAI2btl9YVTVl9buKgbXZ+eGucrw4LTdKJhqocWmbx/Ojd8JG/l7sbV5VJx2W0kwvGA
 CFfw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774060467; x=1774665267; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Q3kqLc2+DATRyIjfQQzda1s2xOQFKyxST9nwoPM2ss=;
 b=QAgDjYRfD42xcZ797LnwqgGxqkaq54xEkXLrB/e5qJqHI2n1cJp1ikXbGgoFKnunRg
 6XYUmrnOpRQMimRhuJ9b4tbDjLb1gikP1yaDAuDfbPmhPAOQO94a5lG/R3cmgtIaMN99
 o+/sixazLNS9cZQNKSOegqm/eDH2x3JxQLOSXVkQeIR54RZo6l5N03SEBucFd5tGvy99
 T4nm2LI/IL/2wip35UQiUaD88QvfIkxtPuOo5zhINeU3qLi/CVPCl035tiSRxqBHCaRi
 e5YxMAG+LoF8d2xDjFWfBNo3ge0/xytCn8E9Fes88ph7y4TuyoOoNQv0WmfIcGvZfSUX
 7t5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774060467; x=1774665267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4Q3kqLc2+DATRyIjfQQzda1s2xOQFKyxST9nwoPM2ss=;
 b=CeP9zrcJZwaoLGHmzfn+VnfAKu4VJ1kwM/RWEyJhFvpPOujUIUX8ckayMLOMAzVK8/
 8YzcHkWsxyANp4ZzRQUvxPu9f/1qit3oNa3iWfCJN2mAiV1TrEE1G70460e1LkCwJjBY
 +grvMsIVL69cyPNzASjaVBdi0GuVT7TVVR38lXobnDKBQpVGB7PSWA3I4Es5Uh7iCckq
 hPMHq7ZJu9TMYSxb38pH8S0DYaa7ttDTXTut1VreQq7NZ7mTBXaqoX6B9QfSXAcZ+3n9
 yT/vP3cKVvsYNAgbwwHnR4Z5ZkhIQYGnZR5dJxPUdZY4mgetlgrHYxxS00EpIKm31rRz
 wMGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmSxIIalCRDuAqlcSkD9jKEKD6HiGCNtbw9cmuf4RJqnSAHGQCjC+mvpluRjMvueQHNiCJMgaE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDmeo+HPJRtBlXc+80PlxRbPQj9nPqR3UptoPugr3P+tbwLYlX
 AgYhuwYNMyAW5cAu08bhpVvw5ASNFnWN+sVA8RVDZ6PGLx8czqgpS/xG9zPdjmC68OhV8QVu0ZT
 6bRQOkVX081etVsv8GBim87vbQ/CZDSs=
X-Gm-Gg: ATEYQzxtCJzuAqhUZtdFSjWTGUEgQe87yyrMam3E49p4Hf1U6gO4Umruk4mIo4MYNAn
 yzg8dOv1c0V9YZVfH4gYVtQinpOcRgcIXPVbobd/bTZig8uZA9xPmyCfwVnbwV7E+F3HI41E9H2
 QiPH8ulthnrD3PpD8YkVjMogRfpVMNNas+afKGRf66hHsqWyn6qasT5aM6uhD475ataxs3Bp5T1
 j9Lg3Mpflbom65CdlNx0chvPVNFDAdm4ckilVfSMuccd9CoV9cxPLL1Ff+3GUzokoJgD+E9yxeN
 YM3qWQxNPu1Gf+20g3flL/6iqzZzLMQyDyQyxI2K3w==
X-Received: by 2002:a05:7022:41a5:b0:11a:6424:f40f with SMTP id
 a92af1059eb24-12a726ddac3mr2231033c88.36.1774060466683; Fri, 20 Mar 2026
 19:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <8ba60a99-f69e-482e-bd68-f6bc36291c54@mailbox.org>
 <5797606.kQq0lBPeGt@workhorse>
In-Reply-To: <5797606.kQq0lBPeGt@workhorse>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Sat, 21 Mar 2026 03:33:50 +0100
X-Gm-Features: AaiRm51HklmEz7GrV_pORHHrZHyoKZT0POzQhQmu1DQijPkt8nqirfdRn2tKzuQ
Message-ID: <CAEsyxyhnALbkaF+9nav8FkW5gcJdtTw5CHhK3Hf8f=fymFiOKw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>,
 Marius Vlad <marius.vlad@collabora.com>
Content-Type: multipart/alternative; boundary="000000000000ed42d3064d7fa3d3"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000ed42d3064d7fa3d3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As somebody who writes software for neuroscience research, I would find
this new property very useful.

Even if the 'link bpc' is not the perfectly accurate answer in presence of
dithering or display stream compression, I think it could provide an idea
about the minimum precision available, so a DRM client can at least make
sure its minimum requirements are met. E.g., a 'link bpc' of 10 would at
least guarantee 10 bpc, and effectively a bit more if spatial dithering is
applied in addition. That said, I don't have practical experience with the
effects of DSC, I don't have any suitable hardware. Afaik it is not truly
lossless, but only (supposed to be, usually) perceptually lossless. It
would be great to have some property that informs clients if DSC is active
or not, or allow some control over that.

Also as somebody who has spent many hours of his life hunting down some
sysfs or debugfs files for reporting such numbers, the files usually being
differently named, at different paths, with different formats, or not
existing at all, depending on kernel version and gpu configuration. I'd
like to do less of that in the future.

In this field of application it is often very important to know about the
actual precision of "what goes out of the computer", e.g., visual test
stimuli. Scientists use different methods to verify their experimental
stimulation setups, of different levels of rigorosity, including
photometers, colorimeters etc. to measure the actual light emitted by a
display. But knowing if things work, or where in the pipeline from app to
photon they break or degrade, if they break, is useful, and the more the
software can help with this, or warn about problems, the better for us.

Even if Wayland compositors wouldn't pick this up quickly, if it is a drm
connector property, I think it would be accessible under a native X11
X-Server via RandR output properties -- and my kind of applications still
heavily relies on native X11, as the Wayland eco system currently is not
ready for the more demanding or non-trivial use cases in this field. Also,
those properties are read-accessible to non-root, non-drm masters, so
applications like mine could read the property even under leased drm
connectors (Vulkan/WSI/display, OpenGL/EGL/drm), or probably even under a
running Wayland desktop if Wayland protocol lacks the means to do so.

In the scenarios used by my app, the app often knows what an optimal
setting for 'max bpc' or reported value from such a 'link bpc' would be, so
it can be used to reconfigure things (under X11 RandR, or as a drm master),
adapt to the situation, or at least warn the user if they are about to ruin
their experimental data collection, possibly guide them a bit in
troubleshooting.

But I could imagine regular desktop use cases, where a Wayland compositor
can somewhat know what good minimum values for 'link bpc' would be, and
maybe adapt, or give the user a hint about potentially degraded quality,
and what to do about it ("Check your cables", "Reduce video resolution or
refresh rate", "Run with less displays",...).

Similar to Nicolas rgb 10 bpc vs. yuv 10 bpc example for video playback:
While all these are critical for apps like mine, or other pro apps
depending on color quality, I'd assume a Wayland compositor could use the
same constraints, even if the worst case desktop scenario may only be an
underwhelmed user, if their HDR videos don't look as spiffy as they hoped.

- A HDR-10 display mode on a true HDR sink implies one really wants a 'link
bpc' of at least 10 bpc, especially given the large nonlinearity of EOTF's
like Perceptual Quantizer, or things will look poor. In a scientific
research setting that would not just be a bummer, but degradation would be
an absolute show stopper. Something one wants to fix, be it by
checking/swapping cables, or maybe by selecting a video mode with lower
bandwidth requirements, etc.

- Same is true for wide color gamut WCG color spaces, where one wants more
than 8 bits to resolve the larger color volume fine enough for good results=
.

- I'd also assume or hope that a wayland client asking for a fullscreen
(=3Dpossibly direct scanout capable) RGB10 framebuffer or fp16 fb or even
RGBA16 fb would imply to the compositor that that client really wants to
get at 10 bpc or even 12+ bpc out of the display connector. So having a too
low link bpc would be a reason to possibly notify the user.

Excuse the verbose reply, but at least from my corner of applications this
would have a big thumbs up.

Thanks,
-mario

On Fri, Mar 20, 2026 at 7:09=E2=80=AFPM Nicolas Frattaroli <
nicolas.frattaroli@collabora.com> wrote:

> On Friday, 20 March 2026 15:32:37 Central European Standard Time Michel
> D=C3=A4nzer wrote:
> > On 3/19/26 13:28, Nicolas Frattaroli wrote:
> > > This series adds a new "link bpc" DRM property. It reflects the displ=
ay
> > > link's actual achieved output bits per component, considering any
> > > degradation of the bit depth done by drivers for bandwidth or other
> > > reasons. The property's value is updated during an atomic commit, whi=
ch
> > > is also when it fires an uevent if it changed to let userspace know.
> > >
> > > There's a weston implementation at [1] which makes use of this new
> > > property to warn when a user's requested bpc could not be reached.
> > >
> > > [1]:
> https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1850
> >
> > I see no description of a real-world use case, either in this series
> > or in the weston MR, beyond logging a message when the "link bpc" &
> > "max bpc" property values don't match. They are not expected to match
> > in general, so I have a hard time seeing the usefulness of that.
>
> Hello,
>
> these are valid concerns. The problem being addressed is related to
> userspace being able to detect whether the link has degraded due to,
> say, a sketchy cable.
>
> This patch started out as a method of forcing the output link's BPC
> value to a certain value, but this is not desirable. The max bpc
> property is already used to restrict the link's bpc due to sketchy
> hardware that advertises a higher max bpc than it can actually
> achieve.
>
> This adds the other side of the equation, where userspace isn't
> necessarily keen on blindly accepting the combination of output
> link parameters the kernel degraded to. This allows userspace to
> detect that an explicitly chosen value it tried did not work, and
> try again with a different color format/VRR/bpc/etc.
>
> A particular real-world use case is for playback of video content.
> When playing back YUV 4:2:0 10-bit video content in a full-screen
> setting, having RGB 10-bit degrade to YUV 4:2:0 10-bit rather than
> RGB 8-bit is more desirable. However, this is a tradeoff only
> userspace knows to make; the kernel doesn't necessarily know that
> the framebuffer it has been handed as RGB 10-bit is secretly just
> a video player's playback of YUV 4:2:0 10-bit content. As for
> the property that let's userspace actually set the output color
> format, that's a separate series of mine.
>
> I agree that the weston implementation isn't a great showcase,
> but it's actually supposed to compare link bpc with an explicitly
> set max bpc config value, not the property value. The config value
> exists to request a certain bpc.
>
> > Moreover, there's no description of what exactly the "link bpc" propert=
y
> > value means, e.g. vs things like DSC or dithering, or how a compositor =
/
> > user would determine which value they need / want under given
> circumstances.
>
> I agree that I should've expanded on this after splitting it out of the
> HDMI patch. It's the output BPC as HDMI understands it. That means DSC is
> not
> a factor. I don't know if any display protocols do dithering at the
> protocol level, I only know some monitors dither internally, which isn't
> something that can be detected.
>
> > In summary, I'm skeptical that this will be useful in practice in the
> > current form. I do see potential for spurious bug reports based on the
> > "link bpc" property having the "wrong" value though.
>
> Kind regards,
> Nicolas Frattaroli
>
>
>

--000000000000ed42d3064d7fa3d3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>As somebody who writes software for neuroscience rese=
arch, I would find this new property very useful.</div><div><br></div><div>=
Even if the &#39;link bpc&#39; is not the perfectly accurate answer in pres=
ence of dithering or display stream compression, I think it could provide a=
n idea about the minimum precision available,=C2=A0so a DRM client can at l=
east make sure its=C2=A0minimum requirements are met. E.g., a &#39;link bpc=
&#39; of 10 would at least guarantee 10 bpc, and effectively a bit more if =
spatial dithering is applied in addition. That said, I don&#39;t have pract=
ical experience with the effects of DSC, I don&#39;t have any suitable hard=
ware. Afaik it is not truly lossless, but only (supposed to be, usually) pe=
rceptually lossless. It would be great to have some property that informs c=
lients if DSC is active or not, or allow some control over that.</div><div>=
<br></div><div>Also as somebody who has spent many hours of his life huntin=
g down some sysfs or debugfs files for reporting such numbers, the files us=
ually being differently named, at different paths, with different formats, =
or not existing at all, depending on kernel version and gpu configuration. =
I&#39;d like to do less of that in the future.</div><div><br></div><div>In =
this field of application it is often very important to know about the actu=
al precision of &quot;what goes out of the computer&quot;, e.g., visual tes=
t stimuli. Scientists use different methods to verify their experimental st=
imulation setups,=C2=A0of different levels of rigorosity, including photome=
ters, colorimeters etc. to measure the actual light emitted by a display. B=
ut knowing if things work, or where in the pipeline from app to photon they=
 break or degrade, if they break, is useful, and the more the software can =
help with this, or warn about problems, the better for us.</div><div><br></=
div><div>Even if Wayland compositors wouldn&#39;t pick this up quickly, if =
it is a drm connector property, I think it would be accessible under a nati=
ve X11 X-Server via RandR output properties -- and my kind of applications =
still heavily relies on native X11, as the Wayland eco system currently is =
not ready for the more demanding or non-trivial use cases in this field. Al=
so, those properties are read-accessible to non-root, non-drm masters, so a=
pplications like mine could read the property even under leased drm connect=
ors (Vulkan/WSI/display, OpenGL/EGL/drm), or probably even under a running =
Wayland desktop if Wayland protocol lacks the means to do so.</div><div><br=
></div><div>In the scenarios used by my app, the app often knows what an op=
timal setting for &#39;max bpc&#39; or reported value from such a &#39;link=
 bpc&#39; would be, so it can be used to reconfigure things (under X11 Rand=
R, or as a drm master), adapt to the situation, or at least warn the user i=
f they are about to ruin their experimental data collection, possibly guide=
 them a bit in troubleshooting.</div><div><br></div><div>But I could imagin=
e regular desktop use cases, where a Wayland compositor can somewhat know w=
hat good minimum values for &#39;link bpc&#39; would be, and maybe adapt, o=
r give the user a hint about potentially degraded quality, and what to do a=
bout it (&quot;Check your cables&quot;, &quot;Reduce video resolution or re=
fresh rate&quot;, &quot;Run with less displays&quot;,...).</div><div><br></=
div><div>Similar to Nicolas rgb 10 bpc vs. yuv 10 bpc example for video pla=
yback: While all these are critical for apps like mine, or other pro apps d=
epending on color quality, I&#39;d assume a Wayland compositor could use th=
e same constraints, even if the worst case desktop scenario may only be an =
underwhelmed user, if their HDR videos don&#39;t look as spiffy as they hop=
ed.</div><div><br></div><div>- A HDR-10 display mode on a true HDR sink imp=
lies one really wants a &#39;link bpc&#39; of at least 10 bpc, especially g=
iven the large nonlinearity of EOTF&#39;s like Perceptual Quantizer, or thi=
ngs will look poor. In a scientific research setting that would not just be=
 a bummer, but degradation would be an absolute show stopper. Something one=
 wants to fix, be it by checking/swapping cables, or maybe by selecting a v=
ideo mode with lower bandwidth requirements, etc.</div><div><br></div><div>=
- Same is true for wide color gamut=C2=A0WCG color spaces, where one wants =
more than 8 bits to resolve the larger color volume fine enough for good re=
sults.</div><div><br></div><div>- I&#39;d also assume or hope that a waylan=
d client asking for a fullscreen (=3Dpossibly direct scanout capable) RGB10=
 framebuffer or fp16 fb or even RGBA16 fb would imply to the compositor tha=
t that client really wants to get at 10 bpc or even 12+ bpc out of the disp=
lay connector. So having a too low link bpc would be a reason to possibly n=
otify the user.</div><div><br></div><div>Excuse the verbose reply, but at l=
east from my corner of applications this would have a big thumbs up.</div><=
div><br></div><div>Thanks,</div><div>-mario</div></div><br><div class=3D"gm=
ail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On F=
ri, Mar 20, 2026 at 7:09=E2=80=AFPM Nicolas Frattaroli &lt;<a href=3D"mailt=
o:nicolas.frattaroli@collabora.com">nicolas.frattaroli@collabora.com</a>&gt=
; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Frid=
ay, 20 March 2026 15:32:37 Central European Standard Time Michel D=C3=A4nze=
r wrote:<br>
&gt; On 3/19/26 13:28, Nicolas Frattaroli wrote:<br>
&gt; &gt; This series adds a new &quot;link bpc&quot; DRM property. It refl=
ects the display<br>
&gt; &gt; link&#39;s actual achieved output bits per component, considering=
 any<br>
&gt; &gt; degradation of the bit depth done by drivers for bandwidth or oth=
er<br>
&gt; &gt; reasons. The property&#39;s value is updated during an atomic com=
mit, which<br>
&gt; &gt; is also when it fires an uevent if it changed to let userspace kn=
ow.<br>
&gt; &gt; <br>
&gt; &gt; There&#39;s a weston implementation at [1] which makes use of thi=
s new<br>
&gt; &gt; property to warn when a user&#39;s requested bpc could not be rea=
ched.<br>
&gt; &gt; <br>
&gt; &gt; [1]: <a href=3D"https://gitlab.freedesktop.org/wayland/weston/-/m=
erge_requests/1850" rel=3D"noreferrer" target=3D"_blank">https://gitlab.fre=
edesktop.org/wayland/weston/-/merge_requests/1850</a><br>
&gt; <br>
&gt; I see no description of a real-world use case, either in this series<b=
r>
&gt; or in the weston MR, beyond logging a message when the &quot;link bpc&=
quot; &amp;<br>
&gt; &quot;max bpc&quot; property values don&#39;t match. They are not expe=
cted to match<br>
&gt; in general, so I have a hard time seeing the usefulness of that.<br>
<br>
Hello,<br>
<br>
these are valid concerns. The problem being addressed is related to<br>
userspace being able to detect whether the link has degraded due to,<br>
say, a sketchy cable.<br>
<br>
This patch started out as a method of forcing the output link&#39;s BPC<br>
value to a certain value, but this is not desirable. The max bpc<br>
property is already used to restrict the link&#39;s bpc due to sketchy<br>
hardware that advertises a higher max bpc than it can actually<br>
achieve.<br>
<br>
This adds the other side of the equation, where userspace isn&#39;t<br>
necessarily keen on blindly accepting the combination of output<br>
link parameters the kernel degraded to. This allows userspace to<br>
detect that an explicitly chosen value it tried did not work, and<br>
try again with a different color format/VRR/bpc/etc.<br>
<br>
A particular real-world use case is for playback of video content.<br>
When playing back YUV 4:2:0 10-bit video content in a full-screen<br>
setting, having RGB 10-bit degrade to YUV 4:2:0 10-bit rather than<br>
RGB 8-bit is more desirable. However, this is a tradeoff only<br>
userspace knows to make; the kernel doesn&#39;t necessarily know that<br>
the framebuffer it has been handed as RGB 10-bit is secretly just<br>
a video player&#39;s playback of YUV 4:2:0 10-bit content. As for<br>
the property that let&#39;s userspace actually set the output color<br>
format, that&#39;s a separate series of mine.<br>
<br>
I agree that the weston implementation isn&#39;t a great showcase,<br>
but it&#39;s actually supposed to compare link bpc with an explicitly<br>
set max bpc config value, not the property value. The config value<br>
exists to request a certain bpc.<br>
<br>
&gt; Moreover, there&#39;s no description of what exactly the &quot;link bp=
c&quot; property<br>
&gt; value means, e.g. vs things like DSC or dithering, or how a compositor=
 / <br>
&gt; user would determine which value they need / want under given circumst=
ances.<br>
<br>
I agree that I should&#39;ve expanded on this after splitting it out of the=
<br>
HDMI patch. It&#39;s the output BPC as HDMI understands it. That means DSC =
is not<br>
a factor. I don&#39;t know if any display protocols do dithering at the<br>
protocol level, I only know some monitors dither internally, which isn&#39;=
t<br>
something that can be detected.<br>
<br>
&gt; In summary, I&#39;m skeptical that this will be useful in practice in =
the<br>
&gt; current form. I do see potential for spurious bug reports based on the=
<br>
&gt; &quot;link bpc&quot; property having the &quot;wrong&quot; value thoug=
h.<br>
<br>
Kind regards,<br>
Nicolas Frattaroli<br>
<br>
<br>
</blockquote></div>

--000000000000ed42d3064d7fa3d3--
