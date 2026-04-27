Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE4DFF8873
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 12:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117CB10EC03;
	Tue, 28 Apr 2026 12:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mvuGjftL";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9626D10E8D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:43:37 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12c726f46baso13290272c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777315417; cv=none;
 d=google.com; s=arc-20240605;
 b=S7Qlv4TtPqSIEwZGZelOVpLass5+G+gBma31h2m2h4/mYnubBS4dREtOAwuW3lEAeE
 xJc8c1sgv2YfHyZMM3Ali6xNx4fr3C3Oz9UDtgKH8WtBoeOIumlHiQxWyjCZZC+LOnAv
 jv3NasqNRPcwINkPILAOwiBW2moiW31aHz+Gu8wqSmolMR5BrR56vO6OLdy29jPx+iy4
 TaY4wCcvlbyCpnVYMLEt/VGwRIeKl2cCpjgMJMT9gVi19EhvELs/G6IWbH0QyhYuw/bT
 TeQm8s7VnRY4N6WxnPMbmeZb+Oh6pUtVEdQuIctUxXb5Xn+V0eBj+ab+idhy16DBz4b5
 mKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OYBOTrPcD4VwGJB8VC+hyleunBq5Kx/G47TfslKHNM4=;
 fh=WPPTvEVtOCp8jvE+zV0Bk6ewAcFBSSW6d8hg4sHuvh8=;
 b=HK1E7iqcMlLv0az2SNPP4QREmgsXJcbsbmBadBsdHHX4tYobabUkQErml7jdBY0sKF
 diuFp2KHhrFEydrEsRzV/59F874JxlTFdHcmYOhaDe8N0CeSnXJSmgvBA6eyXdUDxZfb
 knclLtVD7+NKer3RVattnk/tq8dYtt5sSf+15RbEd4aw37eya4lQboo1eEbRUkWtPggH
 KgWu/ZBvFINZ0P31HCa56cok3UNvmz0ISxXAj0kB5iRFRrytGP0FS2x66EiQYWfvbv7f
 0w7Mz/r33PTa69pKeZ5tt/vEbbysQ/Jl0GJqbnw+MTQWJ99D/u7qdS1HEBvdGAn4KPGi
 a08A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777315417; x=1777920217; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OYBOTrPcD4VwGJB8VC+hyleunBq5Kx/G47TfslKHNM4=;
 b=mvuGjftLkqGsrxxJVFgjInN+L0aRwIvWZCag0y5wOXo8vGUQ0Nk3hPLQ2VSwB+tihu
 sRUBXUsphvthTZVeD4xa12digHaP9HAbzocgJWMmDINPUsYK7DSFPkqWlswvVYu31fuN
 RDr7tppAgHluVa+8i57bSG7kAy68i3dV2O41nqOFjIDJnJH3uXccc0t1mQZFicXN3mjw
 e6iyFP5EvFtul6MMYyWgfMSywvE5EkEiWSXqeD/7fWzarbiRMOMrrTzObN0+6wrbBAS3
 /O/olBNa9qYDPWU+8qFbE53QvSsJ3j0wz53k8f0yMm1ttgs4qwdxGoV7ZrTCuh1DOp0T
 DQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777315417; x=1777920217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYBOTrPcD4VwGJB8VC+hyleunBq5Kx/G47TfslKHNM4=;
 b=bmtpOC4TmG73F4AE0GVQNFSZYgefmrURf1vGnkBXhmysERBmzZIkr6KuBnk/E+Kmxr
 uWostt6m8PzaA/z7kRxNrKyqqMSt6ed4eRxR6ATs7ap6JXoC35f19QxRtiINYyQyG+86
 D94CKRhLNcf8ljoZVGvyEG2Dkam6G+cyKel6vnYlC9QflHQNzrNZzOX4gxZv7gCezqd9
 ferPmsTZ4jhXfeq+VfSYE3a9b2/t9mKh6km/hOquC+yvQmwnd2LurdiuPH+WdyYjpX5K
 HgVs/sY/oXzooA/5PvvngAn4NMr35C4guhBCHSfcoFVbm3yUXs+JiG5XEKSRh1j6t9e1
 NXpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wlu9cZ+/nqgC7O+2cNMWpzBxtsSPdMA64bbtjt0oAcwqBuok6QT7ZB3nM7fR0Bo63K8fr6Dez@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+PXeJK/o0B9FzCpGx+RkXZjM3w6NDmSSzBc3abCgs4VDZwXp7
 WtHK0Ib2eaGlVLxxUA+uQZ/CPVSmi72yuK1GNkkdVak3zOYbHYF4vlc7CknDkg8MWIuN8Njfo5E
 P4D7kAwiePWnJcpH41CZvYYYuTpLjmeg=
X-Gm-Gg: AeBDietZgawGlG4aIRpMGfG82Kqwj022DI+jGDI3cZPbRP//Cpki1PZbR10rI5qfsdy
 Xhq/HUdohcXh9n4BQJOyuFNkt1ibqcJ4IXGn2u+BEKW0Rp+RFrChLgnktcyXfhapnb/8TvnZ1gQ
 54CsEsnUL+vZUeAQIXreRq+hYgMbjuX+KBPiuMkywrioMi7XOPvBEIKXQoKooEBAgtdysphJTSQ
 zkMGdw6jV81yKHAnWitTW/V6uVHVL8P3FdM13Y9xKCL1xoBNrFsP3a3zyP8D+l+L+iKRVdka11S
 TAyiYItNUXXQ//5ysubhnnsHoZWH6uZiy8M=
X-Received: by 2002:a05:7022:6607:b0:12d:b8e5:5ee with SMTP id
 a92af1059eb24-12ddd995dc2mr21859c88.23.1777315416649; Mon, 27 Apr 2026
 11:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAMYTvdA+yCqU4_9mzMUkX_3S=myExKMBCyB88dYWCMwA1edsrw@mail.gmail.com>
 <6c48aff5-b6ee-40af-98f0-c26ded3095bc@leemhuis.info>
 <ed3171ef-eda8-4907-a35b-2e2b8185e574@leemhuis.info>
 <2730559.vYhyI6sBWr@timur-hyperion>
 <CAMYTvdCtpKsHAjBtZOK8MK4dYJUTUMCwgsur50Np3+yJhnic+A@mail.gmail.com>
In-Reply-To: <CAMYTvdCtpKsHAjBtZOK8MK4dYJUTUMCwgsur50Np3+yJhnic+A@mail.gmail.com>
From: Brandon Taylor <br.ta.2818@gmail.com>
Date: Mon, 27 Apr 2026 13:43:23 -0500
X-Gm-Features: AVHnY4I1Jl8m3BPMFboy5tVgTNawO9HU13LZsAhZ41TMCKnEf3IgIoCyGDroImk
Message-ID: <CAMYTvdAV763Sq_WDhWRj0r-OHiiO9Os7kOdusNgh8xM8AhQPmQ@mail.gmail.com>
Subject: Re: [REGRESSION] amdgpu error -22 first encountered in kernel 6.19,
 not fixed in 7.0
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 Linux regressions mailing list <regressions@lists.linux.dev>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000001032cc0650757ec9"
X-Mailman-Approved-At: Tue, 28 Apr 2026 12:54:19 +0000
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

--0000000000001032cc0650757ec9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sometimes I hate copy-and-paste with a passion... Here's the correct link.
https://gitlab.freedesktop.org/drm/amd/-/work_items?show=3DeyJpaWQiOiI1MjIw=
IiwiZnVsbF9wYXRoIjoiZHJtL2FtZCIsImlkIjoxNTAxNzl9

On Mon, Apr 27, 2026, 12:17 PM Brandon Taylor <br.ta.2818@gmail.com> wrote:

> > I'm happy to help, there is no need for personal insults.
>
> Sorry if I came across as insulting; that was most definitely not my
> intention. I simply know Linus' penchant for going insane when an
> error is found in his kernel. But I'm thinking Timur's probably right;
> this may merely be a "me" problem, with my particular GPU.
>
> At any rate, I've created the issue ticket as requested, and here it
> is. https://gitlab.freedesktop.org/drm/amd/-/work-items/5220
>
> Brandon Taylor
>
> On Mon, Apr 27, 2026 at 9:01=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof=
@gmail.com>
> wrote:
> >
> > Hi,
> >
> > Thank you Thorsten for forwarding this to me, indeed I am working on
> improving
> > the driver for these GPUs. See my replies below.
> >
> > On Monday, April 27, 2026 11:37:53=E2=80=AFAM Central European Summer T=
ime
> Thorsten
> > Leemhuis wrote:
> > > [note: please remove Timo Lindfors when replying to this mail and
> > > include Timur Krist=C3=B3f =E2=80=93 sorry everyone and especially Ti=
mo, my mailers
> > > address book tricked me]
> > >
> > > On 4/27/26 11:35, Linux regression tracking (Thorsten Leemhuis) wrote=
:
> > > > On 4/26/26 01:22, Brandon Taylor wrote:
> > > >> I have an AMD Radeon R9 270X GPU (yes, I know it's old) which used
> to
> > > >> default to the `radeon` firmware
> > > >
> > > > FYI, as using the wrong terms can lead to confusion while dealing
> with
> > > > bugs: that's not a firmware, that's the driver (sometimes also call=
ed
> > > > kernel module)
> >
> > - "radeon" is the old kernel driver for these GPUs that didn't support
> Vulkan
> > and therefore was mostly useless for gaming.
> > - "amdgpu" is the new driver, which supports Vulkan and offers better
> perf,
> > this is the default since Linux 6.19.
> >
> > I don't think this is a firmware issue.
> >
> > > >
> > > >> on kernel versions up to and
> > > >> including 6.18. I could manually change this behavior to use the n=
ew
> > > >> `amdgpu` firmware by setting `radeon.si_support=3D0
> amdgpu.si_support=3D1`
> > > >> as kernel parameters in the GRUB bootloader. Everything worked fin=
e,
> > > >> and I was able to play my Windows games without any problems.
> > > >>
> > > >> That was, until kernel version 6.19 came out.>
> > > >> 6.19, from what I was able to Google, was supposed to have AMD GPU=
s
> to
> > > >> default to the new `amdgpu` firmware. Unfortunately, when I update=
d
> > > >> the kernel and rebooted, I got a black screen.
> > > >>
> > > >> Further Google searches led me to reboot, set `nomodeset` in the
> > > >> kernel parameters, switch to a TTY, login, and investigate the
> output
> > > >> of a `dmesg` command =E2=80=94 and what I saw ... Well, let's just=
 say it's
> > > >> the kind of thing that would make Linus go Chernobyl:
> > > >>
> > > >> `amdgpu: probe with driver amdgpu failed with error -22`
> > > >
> >
> > I am sorry this happened and understand the frustration.
> >
> > Please open an issue here:
> > https://gitlab.freedesktop.org/drm/amd/-/work_items/new
> > and upload your full dmesg log. Please ping me personally @Venemo on th=
at
> > issue after you opened it so we can start investigating what is wrong
> there.
> >
> > I got curious so I plugged in my R9 270X right now. I am typing this
> email on
> > a computer with a Radeon R9 270X using Linux 6.19.12 on Fedora 43 and i=
t
> works
> > fine. We are going to need to need more details in order to diagnose
> what the
> > problem really is. We might ask you to test some proposed fixes,
> considering
> > that the issue doesn't happen on my R9 270X, I don't have a way to
> verify it.
> >
> > > >> Now, I hope to God that this email finds whoever is responsible fo=
r
> > > >> breaking this `amdgpu` firmware before the same thing happens to
> Linus
> > > >> via Fedora 44, and he goes berserk. I realize that's not a heck of=
 a
> > > >> lot of time, but God only knows HOW many Linux users with AMD GPUs
> are
> > > >> pissed off by this kind of issue =E2=80=94 and I for one can only =
imagine
> how
> > > >> Linus' reaction will compare when it happens to HIM!
> >
> > I'm happy to help, there is no need for personal insults.
> >
> > (Note that the issue clearly doesn't affect all AMD GPUs and it clearly
> doesn't
> > even affect all R9 270X GPUs.)
> >
> > Thanks & best regards,
> > Timur
> >
> >
> >
>

--0000000000001032cc0650757ec9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Sometimes I hate copy-and-paste with a passion... Here&#3=
9;s the correct link. <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/w=
ork_items?show=3DeyJpaWQiOiI1MjIwIiwiZnVsbF9wYXRoIjoiZHJtL2FtZCIsImlkIjoxNT=
AxNzl9">https://gitlab.freedesktop.org/drm/amd/-/work_items?show=3DeyJpaWQi=
OiI1MjIwIiwiZnVsbF9wYXRoIjoiZHJtL2FtZCIsImlkIjoxNTAxNzl9</a></div><br><div =
class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, Apr 27, 2026, 12:17 PM Brandon Taylor &lt;<a href=3D"mailto:=
br.ta.2818@gmail.com">br.ta.2818@gmail.com</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex">&gt; I&#39;m happy to help, there is no need for per=
sonal insults.<br>
<br>
Sorry if I came across as insulting; that was most definitely not my<br>
intention. I simply know Linus&#39; penchant for going insane when an<br>
error is found in his kernel. But I&#39;m thinking Timur&#39;s probably rig=
ht;<br>
this may merely be a &quot;me&quot; problem, with my particular GPU.<br>
<br>
At any rate, I&#39;ve created the issue ticket as requested, and here it<br=
>
is. <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/work-items/5220" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.freedesktop.or=
g/drm/amd/-/work-items/5220</a><br>
<br>
Brandon Taylor<br>
<br>
On Mon, Apr 27, 2026 at 9:01=E2=80=AFAM Timur Krist=C3=B3f &lt;<a href=3D"m=
ailto:timur.kristof@gmail.com" target=3D"_blank" rel=3D"noreferrer">timur.k=
ristof@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; Thank you Thorsten for forwarding this to me, indeed I am working on i=
mproving<br>
&gt; the driver for these GPUs. See my replies below.<br>
&gt;<br>
&gt; On Monday, April 27, 2026 11:37:53=E2=80=AFAM Central European Summer =
Time Thorsten<br>
&gt; Leemhuis wrote:<br>
&gt; &gt; [note: please remove Timo Lindfors when replying to this mail and=
<br>
&gt; &gt; include Timur Krist=C3=B3f =E2=80=93 sorry everyone and especiall=
y Timo, my mailers<br>
&gt; &gt; address book tricked me]<br>
&gt; &gt;<br>
&gt; &gt; On 4/27/26 11:35, Linux regression tracking (Thorsten Leemhuis) w=
rote:<br>
&gt; &gt; &gt; On 4/26/26 01:22, Brandon Taylor wrote:<br>
&gt; &gt; &gt;&gt; I have an AMD Radeon R9 270X GPU (yes, I know it&#39;s o=
ld) which used to<br>
&gt; &gt; &gt;&gt; default to the `radeon` firmware<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; FYI, as using the wrong terms can lead to confusion while de=
aling with<br>
&gt; &gt; &gt; bugs: that&#39;s not a firmware, that&#39;s the driver (some=
times also called<br>
&gt; &gt; &gt; kernel module)<br>
&gt;<br>
&gt; - &quot;radeon&quot; is the old kernel driver for these GPUs that didn=
&#39;t support Vulkan<br>
&gt; and therefore was mostly useless for gaming.<br>
&gt; - &quot;amdgpu&quot; is the new driver, which supports Vulkan and offe=
rs better perf,<br>
&gt; this is the default since Linux 6.19.<br>
&gt;<br>
&gt; I don&#39;t think this is a firmware issue.<br>
&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;&gt; on kernel versions up to and<br>
&gt; &gt; &gt;&gt; including 6.18. I could manually change this behavior to=
 use the new<br>
&gt; &gt; &gt;&gt; `amdgpu` firmware by setting `radeon.si_support=3D0 amdg=
pu.si_support=3D1`<br>
&gt; &gt; &gt;&gt; as kernel parameters in the GRUB bootloader. Everything =
worked fine,<br>
&gt; &gt; &gt;&gt; and I was able to play my Windows games without any prob=
lems.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; That was, until kernel version 6.19 came out.&gt;<br>
&gt; &gt; &gt;&gt; 6.19, from what I was able to Google, was supposed to ha=
ve AMD GPUs to<br>
&gt; &gt; &gt;&gt; default to the new `amdgpu` firmware. Unfortunately, whe=
n I updated<br>
&gt; &gt; &gt;&gt; the kernel and rebooted, I got a black screen.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Further Google searches led me to reboot, set `nomodeset=
` in the<br>
&gt; &gt; &gt;&gt; kernel parameters, switch to a TTY, login, and investiga=
te the output<br>
&gt; &gt; &gt;&gt; of a `dmesg` command =E2=80=94 and what I saw ... Well, =
let&#39;s just say it&#39;s<br>
&gt; &gt; &gt;&gt; the kind of thing that would make Linus go Chernobyl:<br=
>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; `amdgpu: probe with driver amdgpu failed with error -22`=
<br>
&gt; &gt; &gt;<br>
&gt;<br>
&gt; I am sorry this happened and understand the frustration.<br>
&gt;<br>
&gt; Please open an issue here:<br>
&gt; <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/work_items/new" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.freedesktop.or=
g/drm/amd/-/work_items/new</a><br>
&gt; and upload your full dmesg log. Please ping me personally @Venemo on t=
hat<br>
&gt; issue after you opened it so we can start investigating what is wrong =
there.<br>
&gt;<br>
&gt; I got curious so I plugged in my R9 270X right now. I am typing this e=
mail on<br>
&gt; a computer with a Radeon R9 270X using Linux 6.19.12 on Fedora 43 and =
it works<br>
&gt; fine. We are going to need to need more details in order to diagnose w=
hat the<br>
&gt; problem really is. We might ask you to test some proposed fixes, consi=
dering<br>
&gt; that the issue doesn&#39;t happen on my R9 270X, I don&#39;t have a wa=
y to verify it.<br>
&gt;<br>
&gt; &gt; &gt;&gt; Now, I hope to God that this email finds whoever is resp=
onsible for<br>
&gt; &gt; &gt;&gt; breaking this `amdgpu` firmware before the same thing ha=
ppens to Linus<br>
&gt; &gt; &gt;&gt; via Fedora 44, and he goes berserk. I realize that&#39;s=
 not a heck of a<br>
&gt; &gt; &gt;&gt; lot of time, but God only knows HOW many Linux users wit=
h AMD GPUs are<br>
&gt; &gt; &gt;&gt; pissed off by this kind of issue =E2=80=94 and I for one=
 can only imagine how<br>
&gt; &gt; &gt;&gt; Linus&#39; reaction will compare when it happens to HIM!=
<br>
&gt;<br>
&gt; I&#39;m happy to help, there is no need for personal insults.<br>
&gt;<br>
&gt; (Note that the issue clearly doesn&#39;t affect all AMD GPUs and it cl=
early doesn&#39;t<br>
&gt; even affect all R9 270X GPUs.)<br>
&gt;<br>
&gt; Thanks &amp; best regards,<br>
&gt; Timur<br>
&gt;<br>
&gt;<br>
&gt;<br>
</blockquote></div>

--0000000000001032cc0650757ec9--
