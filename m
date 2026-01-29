Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A872D49C89
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 09:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 342B910E9A1;
	Fri, 30 Jan 2026 09:22:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dUJ4OEDi";
	dkim-atps=neutral
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com
 [209.85.219.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF0B10E8A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 16:42:01 +0000 (UTC)
Received: by mail-qv1-f52.google.com with SMTP id
 6a1803df08f44-8887ac841e2so10465166d6.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 08:42:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769704920; cv=none;
 d=google.com; s=arc-20240605;
 b=AQWKfnouS3owU2G3Z0pEHVdbN9hwdyjJqlsviChMyB5yiz3FKKDDpRaibsz65oaq9d
 7CtCpjAOuMru4AUzoHxUEVR9CY/7xC6XPuOhjHCo2dXpAknrhRLN/yaafC3Lqr4Dl3Ip
 hEhIkuZ+MHfQyz1H+PbpEtyZE54X+OTIc3k5oZ9CiwDhOkaKEQYFXaPjmVqA/n5AKG3v
 aoP3F63/yNVd3Z4RY4TQGn9ixZbjpRabqShaNfoeXNr+AHmtH0LOv/ANB1PxkfHwVJiV
 PmpHqJw2MDnVlGY+YkomqjdWAcFurbkzPk5NeqnShmAX+OzYI9Pe6sjIBTIqwc/JLgej
 9d6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UTUVbcd/Q4jnC5ImuUSFgP8oQOyNCkpI89jF1YQHUqo=;
 fh=8NodEL50WTGj65LWq/0beDR0rXMpIRoSEwR8NWsyC2w=;
 b=EiteYQuklm2P92T/n5MRPW3UoOwyLbudmO0SUbpvlIRVMv0esH6m/DJjFl3N3vKJvM
 Im9cU/r2M4SK4zqvbsWVOqqcCi+sAAgjFXKudmlNPxoIiewtfyWWrE6WP8MbBOzAfjzS
 u52qH5UwMfnQM/YUDkWIpc2Mw5qfoqD/98l9sZELNZIpA+cDUJnCGLPfLW080yQbEuvA
 ps1UTJn41rg+VUY11mHzUr6s0G98YT1D14NZLHRTZQYRZoevUqyK5rWEdn0/5AxPUxjH
 NgJvI4J7Wzbj/xbe0bit2YoN1JoPCHJ6CKsAR863gyD/+vluQtPvFlv43IQI8BIyOerw
 Efsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769704920; x=1770309720; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UTUVbcd/Q4jnC5ImuUSFgP8oQOyNCkpI89jF1YQHUqo=;
 b=dUJ4OEDi39mLvT/k5aXlWuI7/z4GEiwVKnQ6hJyS1CIBmLrGxW6gBQm5T4ChI+VzV1
 LpAVYsWpFxlIcMGE3J05E1J98yjHMOsBeCN66vcQvC2VGLukFRufSDCUdY+Nw3aIJCs5
 B9q8Gp7NefNlpJXsg0Akt6E9vstJT6wckbRmu2+cOizPQKnULqSB4CKYYLJ+8/iNeJWQ
 wg67CqULymHhAAOMWEL8mcldO78sY/T7VRi9mBHbU2FV8lTPGXt6dyba+37eGW5bE0P8
 iMFEC7+NYpkUFtBI8ZSqj/75qagdy3XD8CnbYsrMY21R4npPjfALmrNimCbH2Ss2JrcZ
 FnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769704920; x=1770309720;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTUVbcd/Q4jnC5ImuUSFgP8oQOyNCkpI89jF1YQHUqo=;
 b=kgbAqZ08CHAHwAqRVbOVBZkxGyiRqSGGr4Tc+WBj4NaOc+DYCHWViQKwE+FJXdZNJy
 YydJItoI9qCwQ0gh7mMmcY9r5Pj/VrLZtnAEPj3qT2ucbC4UR/Gpzf7jDN0va9WrhPkr
 c1NEuvXuO8cIHPol7XihQYHVqFanSWJSz/hTzS3jqbWdKzfqbiQdyvSS9TxaelMhTo4m
 lFY5HoU9PrLfsDtRlk4+pIQv0QCt5qyG1tdlovyEDphuNdzT2gqybW9WXC8NitZI4Oai
 7SBfpUMB/AaPLIcP0hitpnxSs3E502sfIbBQRAWEMDlYVMSPtFFKopYD39VPA/t0MFq7
 54tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXG09Jk8rb5r1sxcijmeAjcqMqqslXLnuFkuBIc28goUWWF8Q0/VQuKfOtfVDdCh543s8sigdaT@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCscQN2kEcGUeMWi5ixUgXueX0QV02NHvbcNZx+EiLl5jEE4Ex
 5rnntkk66Dfzy5xUfPc0ORm79Ws4snrti4J9j6Kmt+nSoi1E5yld74WfdrR0FqcFfhO93tzi0PP
 776bRC8uXWVL8GIPbhC4wKKjUMlJuW6s=
X-Gm-Gg: AZuq6aKqwf/UaLoIq2Pc+04mEazzxqBxnatZif3ZVDI0Mj8qk7jnYNP0S4AfY4U/7MF
 3oGWcar8DpLuW8lujrhjBL0X/+hQ4k2ZaV0/P9U074DrImopsyrKNojmEY9tLU/0Gw2h9fk6zlZ
 LmrPcn7SmOnj8VWw7AdDmpV0XZ3w9v2JnSdQj6yuq/7NkKZpSmNdIuhUK91t02ztq7zXDtRxESA
 fDnaAgy5ZgRHNuE6irlgXJdtt91h1u1mU49pIiwCP5gWAA/uz+DAiVwzPE/RYHWDV5uPXr9
X-Received: by 2002:a05:6214:765:b0:890:754b:1396 with SMTP id
 6a1803df08f44-894cc9472cemr136001506d6.57.1769704920164; Thu, 29 Jan 2026
 08:42:00 -0800 (PST)
MIME-Version: 1.0
References: <CAFqHKTnSUndwTs-cc8SZxST48UBj6_oKf0Bzt_mMSsj6=g-xww@mail.gmail.com>
 <923ab7ae-0963-472e-995e-760c30978274@amd.com>
 <31babc28-0e69-46e5-94cd-8856e9ad6550@amd.com>
In-Reply-To: <31babc28-0e69-46e5-94cd-8856e9ad6550@amd.com>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 29 Jan 2026 08:41:48 -0800
X-Gm-Features: AZwV_QgOegN2_JQ1MaXI7zJ3zc-NfBU0ZhSluXQW6M3h8P4l86-IKVydfZW541U
Message-ID: <CAFqHKTmeGC_7FiuU73yCUxkXdQ78Q-6NXT43aHOqBjSE4beUog@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm: Introduce drm_crtc_vblank_prepare()
To: Leo Li <sunpeng.li@amd.com>
Cc: Harry.Wentland@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
 simona@ffwll.ch, 
 Mario Limonciello <superm1@kernel.org>, ville.syrjala@linux.intel.com
Content-Type: multipart/alternative; boundary="0000000000001fae9206498989d4"
X-Mailman-Approved-At: Fri, 30 Jan 2026 09:22:26 +0000
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

--0000000000001fae9206498989d4
Content-Type: text/plain; charset="UTF-8"

Leo,

Appreciate it, thanks

Cheers,
Derek

On Thu, Jan 29, 2026, 08:40 Leo Li <sunpeng.li@amd.com> wrote:

>
>
> On 2026-01-29 10:15, Leo Li wrote:
> >
> >
> > On 2026-01-28 23:43, Derek John Clark wrote:
> >>> From: Leo Li <sunpeng.li@amd.com>
> >>>
> >>> Some drivers need to perform sleepable operations prior to enabling
> >>> vblank interrupts. A display hardware spin-up from a low-power state
> >>> that requires synchronization with the rest of the driver, for example.
> >>>
> >>> To support this, introduce a DRM-internal drm_crtc_vblank_prepare()
> >>> helper that calls back into the driver -- if implemented -- for DRM to
> >>> do such preparation work before enabling vblank.
> >>>
> >>> v3:
> >>> * Unexport drm_crtc_vblank_prepare() and make it DRM internal
> >>> * Drop warnings in drm core for vblank_prepare(), drivers can do so in
> >>>  their implementations
> >>> * Drop unnecessary crtc null checks
> >>> * Check for drm_dev_has_vblank()
> >>> * Rebase on latest drm-misc-next
> >>>
> >>> v4:
> >>> * EXPORT function to fix build error on DRM_KMS_HELPER=m
> >>>
> >>> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> >>
> >> Hi Leo.
> >>
> >> I wanted to know what branch this series applies to. I'm trying to
> >> troubleshoot a possible vblank issue on the Legion Go 2 and was
> >> pointed towards this patch series. Unfortunately I can't get it to
> >> apply cleanly to drm/drm-fixes, drm/drm-next or stable/linux-6.18.y
> >
> > Hi Derek,
> >
> > This applies to drm-misc-next, here:
> > https://gitlab.freedesktop.org/drm/misc/kernel/-/tree/drm-misc-next
> >
> > Thanks,
> > Leo
>
> FYI, in case you run into the same issue, I had to blacklist my wifi
> driver:
> modprobe.blacklist=mt7925e in my kernel cmdline for drm-misc-next to boot.
>
> -Leo
>
> >
> >>
> >>
> >> From commit 15392f76405ecb953216b437bed76ffa49cefb7b (HEAD,
> >> drm/drm-next, drm/HEAD):
> >> $ b4 shazam
> https://lore.kernel.org/dri-devel/20260127194143.176248-1-sunpeng.li@amd.com/
> >> Grabbing thread from
> >>
> lore.kernel.org/all/20260127194143.176248-1-sunpeng.li@amd.com/t.mbox.gz
> >> Checking for newer revisions
> >> Grabbing search results from lore.kernel.org
> >> Analyzing 2 messages in the thread
> >> Analyzing 0 code-review messages
> >> Checking attestation on all messages, may take a moment...
> >> ---
> >>   [PATCH v4 1/2] drm: Introduce drm_crtc_vblank_prepare()
> >>   [PATCH v4 2/2] drm/amd/display: Implement prepare_vblank_enable
> callback
> >>   ---
> >>   NOTE: install dkimpy for DKIM signature verification
> >> ---
> >> Total patches: 2
> >> ---
> >> Applying: drm: Introduce drm_crtc_vblank_prepare()
> >> Applying: drm/amd/display: Implement prepare_vblank_enable callback
> >> Patch failed at 0002 drm/amd/display: Implement prepare_vblank_enable
> callback
> >> error: patch failed:
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c:277
> >> error: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c: patch
> >> does not apply
> >>
> >>
> >> Thanks,
> >> Derek
> >
>
>

--0000000000001fae9206498989d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Leo,=C2=A0<div dir=3D"auto"><br></div><div dir=3D"auto">A=
ppreciate it, thanks=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Cheers,</div><div dir=3D"auto">Derek</div></div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, =
Jan 29, 2026, 08:40 Leo Li &lt;<a href=3D"mailto:sunpeng.li@amd.com">sunpen=
g.li@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 2026-01-29 10:15, Leo Li wrote:<br>
&gt; <br>
&gt; <br>
&gt; On 2026-01-28 23:43, Derek John Clark wrote:<br>
&gt;&gt;&gt; From: Leo Li &lt;<a href=3D"mailto:sunpeng.li@amd.com" target=
=3D"_blank" rel=3D"noreferrer">sunpeng.li@amd.com</a>&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Some drivers need to perform sleepable operations prior to ena=
bling<br>
&gt;&gt;&gt; vblank interrupts. A display hardware spin-up from a low-power=
 state<br>
&gt;&gt;&gt; that requires synchronization with the rest of the driver, for=
 example.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; To support this, introduce a DRM-internal drm_crtc_vblank_prep=
are()<br>
&gt;&gt;&gt; helper that calls back into the driver -- if implemented -- fo=
r DRM to<br>
&gt;&gt;&gt; do such preparation work before enabling vblank.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v3:<br>
&gt;&gt;&gt; * Unexport drm_crtc_vblank_prepare() and make it DRM internal<=
br>
&gt;&gt;&gt; * Drop warnings in drm core for vblank_prepare(), drivers can =
do so in<br>
&gt;&gt;&gt;=C2=A0 their implementations<br>
&gt;&gt;&gt; * Drop unnecessary crtc null checks<br>
&gt;&gt;&gt; * Check for drm_dev_has_vblank()<br>
&gt;&gt;&gt; * Rebase on latest drm-misc-next<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; v4:<br>
&gt;&gt;&gt; * EXPORT function to fix build error on DRM_KMS_HELPER=3Dm<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Signed-off-by: Leo Li &lt;<a href=3D"mailto:sunpeng.li@amd.com=
" target=3D"_blank" rel=3D"noreferrer">sunpeng.li@amd.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Hi Leo.<br>
&gt;&gt;<br>
&gt;&gt; I wanted to know what branch this series applies to. I&#39;m tryin=
g to<br>
&gt;&gt; troubleshoot a possible vblank issue on the Legion Go 2 and was<br=
>
&gt;&gt; pointed towards this patch series. Unfortunately I can&#39;t get i=
t to<br>
&gt;&gt; apply cleanly to drm/drm-fixes, drm/drm-next or stable/linux-6.18.=
y<br>
&gt; <br>
&gt; Hi Derek,<br>
&gt; <br>
&gt; This applies to drm-misc-next, here:<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/drm/misc/kernel/-/tree/drm-m=
isc-next" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.fr=
eedesktop.org/drm/misc/kernel/-/tree/drm-misc-next</a><br>
&gt; <br>
&gt; Thanks,<br>
&gt; Leo<br>
<br>
FYI, in case you run into the same issue, I had to blacklist my wifi driver=
:<br>
modprobe.blacklist=3Dmt7925e in my kernel cmdline for drm-misc-next to boot=
.<br>
<br>
-Leo<br>
<br>
&gt; <br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; From commit 15392f76405ecb953216b437bed76ffa49cefb7b (HEAD,<br>
&gt;&gt; drm/drm-next, drm/HEAD):<br>
&gt;&gt; $ b4 shazam <a href=3D"https://lore.kernel.org/dri-devel/202601271=
94143.176248-1-sunpeng.li@amd.com/" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://lore.kernel.org/dri-devel/20260127194143.176248-1-sunpeng.=
li@amd.com/</a><br>
&gt;&gt; Grabbing thread from<br>
&gt;&gt; <a href=3D"http://lore.kernel.org/all/20260127194143.176248-1-sunp=
eng.li@amd.com/t.mbox.gz" rel=3D"noreferrer noreferrer" target=3D"_blank">l=
ore.kernel.org/all/20260127194143.176248-1-sunpeng.li@amd.com/t.mbox.gz</a>=
<br>
&gt;&gt; Checking for newer revisions<br>
&gt;&gt; Grabbing search results from <a href=3D"http://lore.kernel.org" re=
l=3D"noreferrer noreferrer" target=3D"_blank">lore.kernel.org</a><br>
&gt;&gt; Analyzing 2 messages in the thread<br>
&gt;&gt; Analyzing 0 code-review messages<br>
&gt;&gt; Checking attestation on all messages, may take a moment...<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0[PATCH v4 1/2] drm: Introduce drm_crtc_vblank_prepare(=
)<br>
&gt;&gt;=C2=A0 =C2=A0[PATCH v4 2/2] drm/amd/display: Implement prepare_vbla=
nk_enable callback<br>
&gt;&gt;=C2=A0 =C2=A0---<br>
&gt;&gt;=C2=A0 =C2=A0NOTE: install dkimpy for DKIM signature verification<b=
r>
&gt;&gt; ---<br>
&gt;&gt; Total patches: 2<br>
&gt;&gt; ---<br>
&gt;&gt; Applying: drm: Introduce drm_crtc_vblank_prepare()<br>
&gt;&gt; Applying: drm/amd/display: Implement prepare_vblank_enable callbac=
k<br>
&gt;&gt; Patch failed at 0002 drm/amd/display: Implement prepare_vblank_ena=
ble callback<br>
&gt;&gt; error: patch failed: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_=
dm_crtc.c:277<br>
&gt;&gt; error: drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c: pat=
ch<br>
&gt;&gt; does not apply<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Thanks,<br>
&gt;&gt; Derek<br>
&gt; <br>
<br>
</blockquote></div>

--0000000000001fae9206498989d4--
