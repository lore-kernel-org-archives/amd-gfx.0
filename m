Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB643C433ED
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 15:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BC361372
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 15:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BC361372
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA52B6ECC7;
	Thu,  1 Apr 2021 15:26:51 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4766E157
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 15:14:11 +0000 (UTC)
Received: by mail-lj1-x22c.google.com with SMTP id r20so2653380ljk.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Apr 2021 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nWYUinUR7NmXFMMupKn1JtvipC2KWvJQZn1hNyz4X6w=;
 b=i230k/ApNGxjhS7e4AVsCziz3//YHTgUgA/nkX+uYTSsqKJRqSOUoYVjrPEBLJ+dL0
 WMKNuu8L4Nlx7nOC8KFQrjBJD/rcwg1eMfsokOalshi4ui/5DzDlFgAwPHDDeOXRK33m
 zK5F7cwT9udkuwketDYfMLy0LmmLv5oHF5JpwsoGvJcN+J3oMSCCaNLypbz20FeQMyWB
 MR5Up+CpHu0FWhPce5j5jjO2jqm3Q7tqZJSkaWyeQfrHrXyzmfUryCH748fYb32vEKsE
 K2Sjzg3a4uctaaFCFCO52tCNT9e/gEQ1KjaEeud0fXOx2Ok0B8X6rruZH48zLo7ozcYm
 ZIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nWYUinUR7NmXFMMupKn1JtvipC2KWvJQZn1hNyz4X6w=;
 b=Wk7ZOzhT6kTURetV6ngyz9h4uDdSYqWJc4EadXDNmUoPcqCIJ/LZo+E83XRXxhP+i4
 3hk050XvktjBiprUxhxpb0Cl970Cx0h5buVU3l5yUHrNFkYjperWoZ3LcEfrRy0JSx6A
 LKsaJ9n/pAMAaUeiyet1GMpKZc/JbXmirJiknn5uQMcBIsdm6AaZK2nsEoim82qkszo9
 c1gdcDrDJmaObdAb3jgIylr0PP/ybAPmxa6IAeFhpUYxi8Rxfqa38JgpzOo20MaILYiR
 e5ZSX1gjln2ET2fiEGlyKYXWypsRmQMyw3kL0HZ6TNwTt6bUVe6FdihrHdNWXpX9sYlh
 K1rg==
X-Gm-Message-State: AOAM533eRngOh1J9DxHXI3PVUqV724qrAyOhPUAZzJ3oazKPdfOvyjro
 ncoXtWVnfWv2n/t6yFI7pXPG0sreCrPTSJDbnEY=
X-Google-Smtp-Source: ABdhPJz39XPbCeygmSkX1htRHr0QY3QsZu2noX74LqKXkKyrMIWlQVXdLXuDpyPv37iFb+GqjAxDzvxZEz6Hj1KgEoA=
X-Received: by 2002:a2e:8591:: with SMTP id b17mr5595069lji.230.1617290049495; 
 Thu, 01 Apr 2021 08:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
 <909002f5-691c-1cbb-1e44-a99217be8791@gmail.com>
 <CAHJvkbsMY689cK3uq_O+i6jiqgLmSAUcrD43oHxpSsVwyhJ1Mg@mail.gmail.com>
 <b1137716-d6dd-6572-3d45-d0063caef26e@amd.com>
 <CAHJvkbvkwAw2-pRo=rvnB98XxgtNCE-QAzv4HZ-KceH-vZkKoA@mail.gmail.com>
 <3d3563f3-f093-f293-e237-b87306a4cede@amd.com>
 <CAHJvkbvQ-JJ4vhc3MHNiQ2Jb7dpHUTQBcZ4L1KDnSV=WXDPsOA@mail.gmail.com>
 <7914f67b-e011-36ec-3f6d-1614ce96e3c4@amd.com>
 <CAHJvkbvQ3jTyoHfQjOkSqierLQfFTb7kqZwdfxs86yunvCvj6g@mail.gmail.com>
 <f000cbf3-cea2-c574-2b93-6c5f45ca28e2@amd.com>
 <CAHJvkbuxkJeXCqh3FYW2q7FREM9-6CQrJ0EYCLp0v_z4SL3h_A@mail.gmail.com>
 <0eee8e42-5da8-1ce3-bff7-fe6e2ab18cde@amd.com>
 <CAHJvkbvH+yf-O04Jj9CURjaFfaYE9CSzqBQPe5oPuy5U_f3hag@mail.gmail.com>
 <6a71add4-d2d0-c17a-de8a-6e2b6e248483@gmail.com>
 <CAHJvkbviwB3JLU84P+mb58rvxaKOahO+B9LPMw3n8nGKvTHAOg@mail.gmail.com>
 <e9dd4112-c0d6-8081-8f4a-e857b3097d58@amd.com>
 <CADnq5_PAYJs1GtnpaUuZZDho0Y04wDcCQ__JBOoDquOq6RQ4SA@mail.gmail.com>
In-Reply-To: <CADnq5_PAYJs1GtnpaUuZZDho0Y04wDcCQ__JBOoDquOq6RQ4SA@mail.gmail.com>
From: Alberto Salvia Novella <es20490446e@gmail.com>
Date: Thu, 1 Apr 2021 17:13:57 +0200
Message-ID: <CAHJvkbt_P4qb2QsxgOT3ToWt1a4u+2yHWqqyU8Vq=9D_to4Nfw@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Thu, 01 Apr 2021 15:26:51 +0000
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
Cc: "open list:EFIFB FRAMEBUFFER DRIVER" <linux-fbdev@vger.kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: multipart/mixed; boundary="===============0020835662=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0020835662==
Content-Type: multipart/alternative; boundary="000000000000e6264905beeaae22"

--000000000000e6264905beeaae22
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

There's no "xorg.conf" on my system.

On Wed, 31 Mar 2021 at 20:01, Alex Deucher <alexdeucher@gmail.com> wrote:

> Does disabling pageflipping via the xorg.conf help?
>
> Alex
>
> On Wed, Mar 31, 2021 at 1:40 PM Christian K=C3=B6nig
> <christian.koenig@amd.com> wrote:
> >
> > Yeah, agree that must be some kind of bug in the upper layer of the
> stack.
> >
> > Most likely some userspace component is not handling the specialties of
> interlacing correctly (different vblank timing every other frame).
> >
> > It probably only works on Intel and after restarting the display manage=
r
> by coincident.
> >
> > Sorry, but as I said this is a use case which basically nobody is using
> any more and because of this the different parts of the stack are not
> tested well enough for this.
> >
> > Christian.
> >
> > Am 31.03.21 um 17:47 schrieb Alberto Salvia Novella:
> >
> > Restarting the display manager service works and, more importantly,
> makes the bug no longer reproducible.
> >
> > Restarting the window manager doesn't work.
> >
> > Changing display manager makes the bug still reproducible.
> >
> > Maybe this is due to xorg-server, isn't it?
> >
> > On Wed, 31 Mar 2021 at 16:55, Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
> >>
> >> Well the hardware is working fine as far as I can see.
> >>
> >> Can you try to kill the X server over SSH and see if you then get some
> screen update?
> >>
> >> Regards,
> >> Christian.
> >>
> >> Am 31.03.21 um 16:52 schrieb Alberto Salvia Novella:
> >>
> >> Output.
> >>
> >> On Wed, 31 Mar 2021 at 16:36, Christian K=C3=B6nig <christian.koenig@a=
md.com>
> wrote:
> >>>
> >>> Mhm strange.
> >>>
> >>> Can you get me the output of "sudo cat
> /sys/kernel/debug/dri/0/radeon_fence_info" when the problem happens?
> >>>
> >>> Thanks,
> >>> Christian.
> >>>
> >>> Am 31.03.21 um 16:33 schrieb Alberto Salvia Novella:
> >>>
> >>> - The computer still replies to ping.
> >>> - The journal shows no errors, but a few warnings.
> >>> - The mouse doesn't freeze.
> >>>
> >>> On Wed, 31 Mar 2021 at 10:09, Christian K=C3=B6nig <
> christian.koenig@amd.com> wrote:
> >>>>
> >>>> Can you access the system over the network and see if there is
> anything in the system log?
> >>>>
> >>>> It sounds like the display stack has crashed, but when the sound
> keeps playing the system is most likely still responsive over network.
> >>>>
> >>>> Thanks,
> >>>> Christian.
> >>>>
> >>>> Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:
> >>>>
> >>>> What happens is this simple: after a few minutes, about 6 or so, the
> entire content of the screen stays still. In some minor situations only t=
he
> applications panel of KDE Plasma.
> >>>>
> >>>> If music is playing it continues playing, so only graphics are hung.
> Yet in most cases the power button won't shut down the computer, as it
> usually does.
> >>>>
> >>>> At least this is the case using kwin on x11, and not on wayland. It
> only happens on "radeon" and not on Intel or "radeonhd".
> >>>>
> >>>> On Wed, 31 Mar 2021 at 09:48, Christian K=C3=B6nig <
> christian.koenig@amd.com> wrote:
> >>>>>
> >>>>> Correct, but a TV is intended for videos only. That's why it
> implements only the lower HDMI standard.
> >>>>>
> >>>>> Interlaced transmits only halve the lines with each frame, so a 60H=
z
> mode effectively either becomes a 30Hz mode, halving the vertical
> resolution or adaptive motion compensated which the know visual artifacts=
.
> Depending on what the deinterlacing setting on your TV is.
> >>>>>
> >>>>> You could just add a progressive 1920x540@60 or 1920x1080@30 mode
> manually and would have the same effect with probably better quality. See
> https://de.wikipedia.org/wiki/Deinterlacing for reference.
> >>>>>
> >>>>> If you can give us some more information what is happening when the
> system freeze we could try to narrow this down, but we can't spend much
> time on a very specific use case in a driver which is in maintenance mode=
.
> >>>>>
> >>>>> Regards,
> >>>>> Christian.
> >>>>>
> >>>>> Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:
> >>>>>
> >>>>> 24fps is intended for video only. Anything interactive at 24fps, as
> just moving the mouse around, is extremely choppy.
> >>>>>
> >>>>> No way anyone would prefer that over an interlaced resolution or a
> lower resolution. That is, by far, the worst option.
> >>>>>
> >>>>> Just try it on your screen, set it to 24Hz or alike, and tell me
> your experience. You can't even tell where the mouse is going to go.
> >>>>>
> >>>>> On Wed, 31 Mar 2021 at 08:44, Christian K=C3=B6nig <
> christian.koenig@amd.com> wrote:
> >>>>>>
> >>>>>> Hi Alberto,
> >>>>>>
> >>>>>> well a frame rate of 24Hz is perfectly reasonable for a TV and
> desktop usage.
> >>>>>>
> >>>>>> This is probably caused by the TVs limited HDMI bandwidth and a
> refresh rate of 30/25 Hz for the interlaced mode isn't much better either=
.
> >>>>>>
> >>>>>> Regards,
> >>>>>> Christian.
> >>>>>>
> >>>>>> Am 30.03.21 um 22:59 schrieb Alberto Salvia Novella:
> >>>>>>
> >>>>>> The frame-rate at 24Hz is extremely poor for normal desktop usage.
> >>>>>>
> >>>>>> If the highest resolution, aka 1080p, uses that refresh rate then
> the desktop will default to that frame-rate.
> >>>>>>
> >>>>>> Other progressive modes don't exhibit any issue.
> >>>>>>
> >>>>>> On Tue, 30 Mar 2021 at 18:26, Christian K=C3=B6nig <
> christian.koenig@amd.com> wrote:
> >>>>>>>
> >>>>>>> Hi Alberto,
> >>>>>>>
> >>>>>>> I think the driver should only support resolutions that are
> progressive, but also at least of 50Hz.
> >>>>>>>
> >>>>>>>
> >>>>>>> Why do you think so?, the 24Hz resolution seems to be the native
> one of the display.
> >>>>>>>
> >>>>>>> Regards,
> >>>>>>> Christian.
> >>>>>>>
> >>>>>>> Am 30.03.21 um 17:37 schrieb Alberto Salvia Novella:
> >>>>>>>
> >>>>>>> This is why I'm using interlaced:
> >>>>>>>
> >>>>>>> $ xrandr
> >>>>>>> Screen 0: minimum 320 x 200, current 1920 x 1080, maximum 8192 x
> 8192
> >>>>>>> DisplayPort-0 disconnected (normal left inverted right x axis y
> axis)
> >>>>>>> HDMI-0 connected primary 1920x1080+0+0 (normal left inverted righ=
t
> x axis y axis) 16mm x 9mm
> >>>>>>>    1920x1080i    60.00*+  50.00    59.94
> >>>>>>>    1920x1080     24.00    23.98
> >>>>>>>    1280x720      60.00    50.00    59.94
> >>>>>>>    1024x768      75.03    70.07    60.00
> >>>>>>>    832x624       74.55
> >>>>>>>    800x600       72.19    75.00    60.32    56.25
> >>>>>>>    720x576       50.00
> >>>>>>>    720x576i      50.00
> >>>>>>>    720x480       60.00    59.94
> >>>>>>>    720x480i      60.00    59.94
> >>>>>>>    640x480       75.00    72.81    66.67    60.00    59.94
> >>>>>>>    720x400       70.08
> >>>>>>> DVI-0 disconnected (normal left inverted right x axis y axis)
> >>>>>>>
> >>>>>>> I think the driver should only support resolutions that are
> progressive, but also at least of 50Hz.
> >>>>>>>
> >>>>>>> On Tue, 30 Mar 2021 at 15:41, Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> Mhm, no idea why an interlaced resolution would cause a crash.
> Maybe some miscalculation in the display code.
> >>>>>>>>
> >>>>>>>> But apart from that if you just connected your PC to a TV I also
> wouldn't recommend using an interlaced resolution in the first place.
> >>>>>>>>
> >>>>>>>> See those resolutions only exists for backward compatibility wit=
h
> analog hardware.
> >>>>>>>>
> >>>>>>>> I think we would just disable those modes instead of searching
> for the bug.
> >>>>>>>>
> >>>>>>>> Regards,
> >>>>>>>> Christian.
> >>>>>>>>
> >>>>>>>> Am 30.03.21 um 11:07 schrieb Alberto Salvia Novella:
> >>>>>>>>
> >>>>>>>> I guessed so.
> >>>>>>>>
> >>>>>>>> The GPU is a Radeon HD5870, and the screen is an old Telefunken
> TV (TLFK22LEDPVR1).
> >>>>>>>>
> >>>>>>>> Since my real display got into repair I used this TV meanwhile,
> and to my surprise it froze the system.
> >>>>>>>>
> >>>>>>>> On Tue, 30 Mar 2021 at 10:15, Christian K=C3=B6nig <
> christian.koenig@amd.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Hi Alberto,
> >>>>>>>>>
> >>>>>>>>> well what hardware do you have?
> >>>>>>>>>
> >>>>>>>>> Interlaced resolutions are not used any more on modern hardware=
,
> so they
> >>>>>>>>> are not well tested.
> >>>>>>>>>
> >>>>>>>>> Regards,
> >>>>>>>>> Christian.
> >>>>>>>>>
> >>>>>>>>> Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
> >>>>>>>>> > The entire desktop hangs after some minutes when using the
> module
> >>>>>>>>> > "radeon" with an interlaced resolution.
> >>>>>>>>> >
> >>>>>>>>> > Easier to trigger by playing a video on Firefox, at least on
> kwin_x11.
> >>>>>>>>> > Wayland didn't exhibit the problem.
> >>>>>>>>> >
> >>>>>>>>> > Other display drivers, from different computers I have tried,
> didn't
> >>>>>>>>> > allow those interlaced resolutions all together. It seems the=
y
> know
> >>>>>>>>> > there will be problems.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> _______________________________________________
> >>>>>>>> amd-gfx mailing list
> >>>>>>>> amd-gfx@lists.freedesktop.org
> >>>>>>>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>>>>>>>
> >>>>>>>>
> >>>>>>>
> >>>>>>
> >>>>>
> >>>>
> >>>
> >>
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000e6264905beeaae22
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">There&#39;s no &quot;xorg.conf&quot; on my system.<br></di=
v><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On W=
ed, 31 Mar 2021 at 20:01, Alex Deucher &lt;<a href=3D"mailto:alexdeucher@gm=
ail.com">alexdeucher@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Does disabling pageflipping via the xorg.conf=
 help?<br>
<br>
Alex<br>
<br>
On Wed, Mar 31, 2021 at 1:40 PM Christian K=C3=B6nig<br>
&lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian=
.koenig@amd.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Yeah, agree that must be some kind of bug in the upper layer of the st=
ack.<br>
&gt;<br>
&gt; Most likely some userspace component is not handling the specialties o=
f interlacing correctly (different vblank timing every other frame).<br>
&gt;<br>
&gt; It probably only works on Intel and after restarting the display manag=
er by coincident.<br>
&gt;<br>
&gt; Sorry, but as I said this is a use case which basically nobody is usin=
g any more and because of this the different parts of the stack are not tes=
ted well enough for this.<br>
&gt;<br>
&gt; Christian.<br>
&gt;<br>
&gt; Am 31.03.21 um 17:47 schrieb Alberto Salvia Novella:<br>
&gt;<br>
&gt; Restarting the display manager service works and, more importantly, ma=
kes the bug no longer reproducible.<br>
&gt;<br>
&gt; Restarting the window manager doesn&#39;t work.<br>
&gt;<br>
&gt; Changing display manager makes the bug still reproducible.<br>
&gt;<br>
&gt; Maybe this is due to xorg-server, isn&#39;t it?<br>
&gt;<br>
&gt; On Wed, 31 Mar 2021 at 16:55, Christian K=C3=B6nig &lt;<a href=3D"mail=
to:ckoenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerk=
en@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Well the hardware is working fine as far as I can see.<br>
&gt;&gt;<br>
&gt;&gt; Can you try to kill the X server over SSH and see if you then get =
some screen update?<br>
&gt;&gt;<br>
&gt;&gt; Regards,<br>
&gt;&gt; Christian.<br>
&gt;&gt;<br>
&gt;&gt; Am 31.03.21 um 16:52 schrieb Alberto Salvia Novella:<br>
&gt;&gt;<br>
&gt;&gt; Output.<br>
&gt;&gt;<br>
&gt;&gt; On Wed, 31 Mar 2021 at 16:36, Christian K=C3=B6nig &lt;<a href=3D"=
mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd.com=
</a>&gt; wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Mhm strange.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Can you get me the output of &quot;sudo cat /sys/kernel/debug/=
dri/0/radeon_fence_info&quot; when the problem happens?<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Am 31.03.21 um 16:33 schrieb Alberto Salvia Novella:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; - The computer still replies to ping.<br>
&gt;&gt;&gt; - The journal shows no errors, but a few warnings.<br>
&gt;&gt;&gt; - The mouse doesn&#39;t freeze.<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; On Wed, 31 Mar 2021 at 10:09, Christian K=C3=B6nig &lt;<a href=
=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig@amd=
.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Can you access the system over the network and see if ther=
e is anything in the system log?<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; It sounds like the display stack has crashed, but when the=
 sound keeps playing the system is most likely still responsive over networ=
k.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Thanks,<br>
&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Am 31.03.21 um 10:05 schrieb Alberto Salvia Novella:<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; What happens is this simple: after a few minutes, about 6 =
or so, the entire content of the screen stays still. In some minor situatio=
ns only the applications panel of KDE Plasma.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; If music is playing it continues playing, so only graphics=
 are hung. Yet in most cases the power button won&#39;t shut down the compu=
ter, as it usually does.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; At least this is the case using kwin on x11, and not on wa=
yland. It only happens on &quot;radeon&quot; and not on Intel or &quot;rade=
onhd&quot;.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; On Wed, 31 Mar 2021 at 09:48, Christian K=C3=B6nig &lt;<a =
href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.koenig=
@amd.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Correct, but a TV is intended for videos only. That&#3=
9;s why it implements only the lower HDMI standard.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Interlaced transmits only halve the lines with each fr=
ame, so a 60Hz mode effectively either becomes a 30Hz mode, halving the ver=
tical resolution or adaptive motion compensated which the know visual artif=
acts. Depending on what the deinterlacing setting on your TV is.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; You could just add a progressive 1920x540@60 or 1920x1=
080@30 mode manually and would have the same effect with probably better qu=
ality. See <a href=3D"https://de.wikipedia.org/wiki/Deinterlacing" rel=3D"n=
oreferrer" target=3D"_blank">https://de.wikipedia.org/wiki/Deinterlacing</a=
> for reference.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; If you can give us some more information what is happe=
ning when the system freeze we could try to narrow this down, but we can&#3=
9;t spend much time on a very specific use case in a driver which is in mai=
ntenance mode.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Am 31.03.21 um 09:21 schrieb Alberto Salvia Novella:<b=
r>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; 24fps is intended for video only. Anything interactive=
 at 24fps, as just moving the mouse around, is extremely choppy.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; No way anyone would prefer that over an interlaced res=
olution or a lower resolution. That is, by far, the worst option.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; Just try it on your screen, set it to 24Hz or alike, a=
nd tell me your experience. You can&#39;t even tell where the mouse is goin=
g to go.<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt; On Wed, 31 Mar 2021 at 08:44, Christian K=C3=B6nig &lt=
;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christian.ko=
enig@amd.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Hi Alberto,<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; well a frame rate of 24Hz is perfectly reasonable =
for a TV and desktop usage.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; This is probably caused by the TVs limited HDMI ba=
ndwidth and a refresh rate of 30/25 Hz for the interlaced mode isn&#39;t mu=
ch better either.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Am 30.03.21 um 22:59 schrieb Alberto Salvia Novell=
a:<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; The frame-rate at 24Hz is extremely poor for norma=
l desktop usage.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; If the highest resolution, aka 1080p, uses that re=
fresh rate then the desktop will default to that frame-rate.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; Other progressive modes don&#39;t exhibit any issu=
e.<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt; On Tue, 30 Mar 2021 at 18:26, Christian K=C3=B6nig=
 &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank">christia=
n.koenig@amd.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi Alberto,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I think the driver should only support resolut=
ions that are progressive, but also at least of 50Hz.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Why do you think so?, the 24Hz resolution seem=
s to be the native one of the display.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Am 30.03.21 um 17:37 schrieb Alberto Salvia No=
vella:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; This is why I&#39;m using interlaced:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; $ xrandr<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; Screen 0: minimum 320 x 200, current 1920 x 10=
80, maximum 8192 x 8192<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; DisplayPort-0 disconnected (normal left invert=
ed right x axis y axis)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; HDMI-0 connected primary 1920x1080+0+0 (normal=
 left inverted right x axis y axis) 16mm x 9mm<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 1920x1080i=C2=A0 =C2=A0 60.00*+=
=C2=A0 50.00=C2=A0 =C2=A0 59.94<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 1920x1080=C2=A0 =C2=A0 =C2=A024.0=
0=C2=A0 =C2=A0 23.98<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 1280x720=C2=A0 =C2=A0 =C2=A0 60.0=
0=C2=A0 =C2=A0 50.00=C2=A0 =C2=A0 59.94<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 1024x768=C2=A0 =C2=A0 =C2=A0 75.0=
3=C2=A0 =C2=A0 70.07=C2=A0 =C2=A0 60.00<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 832x624=C2=A0 =C2=A0 =C2=A0 =C2=
=A074.55<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 800x600=C2=A0 =C2=A0 =C2=A0 =C2=
=A072.19=C2=A0 =C2=A0 75.00=C2=A0 =C2=A0 60.32=C2=A0 =C2=A0 56.25<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 720x576=C2=A0 =C2=A0 =C2=A0 =C2=
=A050.00<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 720x576i=C2=A0 =C2=A0 =C2=A0 50.0=
0<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 720x480=C2=A0 =C2=A0 =C2=A0 =C2=
=A060.00=C2=A0 =C2=A0 59.94<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 720x480i=C2=A0 =C2=A0 =C2=A0 60.0=
0=C2=A0 =C2=A0 59.94<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 640x480=C2=A0 =C2=A0 =C2=A0 =C2=
=A075.00=C2=A0 =C2=A0 72.81=C2=A0 =C2=A0 66.67=C2=A0 =C2=A0 60.00=C2=A0 =C2=
=A0 59.94<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;=C2=A0 =C2=A0 720x400=C2=A0 =C2=A0 =C2=A0 =C2=
=A070.08<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; DVI-0 disconnected (normal left inverted right=
 x axis y axis)<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; I think the driver should only support resolut=
ions that are progressive, but also at least of 50Hz.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, 30 Mar 2021 at 15:41, Christian K=C3=
=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com" target=3D"_b=
lank">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Mhm, no idea why an interlaced resolution =
would cause a crash. Maybe some miscalculation in the display code.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; But apart from that if you just connected =
your PC to a TV I also wouldn&#39;t recommend using an interlaced resolutio=
n in the first place.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; See those resolutions only exists for back=
ward compatibility with analog hardware.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I think we would just disable those modes =
instead of searching for the bug.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Am 30.03.21 um 11:07 schrieb Alberto Salvi=
a Novella:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; I guessed so.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; The GPU is a Radeon HD5870, and the screen=
 is an old Telefunken TV (TLFK22LEDPVR1).<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Since my real display got into repair I us=
ed this TV meanwhile, and to my surprise it froze the system.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; On Tue, 30 Mar 2021 at 10:15, Christian K=
=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@amd.com" target=3D"_blank"=
>christian.koenig@amd.com</a>&gt; wrote:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Hi Alberto,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; well what hardware do you have?<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Interlaced resolutions are not used an=
y more on modern hardware, so they<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; are not well tested.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Regards,<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Christian.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; Am 30.03.21 um 10:04 schrieb Alberto S=
alvia Novella:<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; The entire desktop hangs after so=
me minutes when using the module<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; &quot;radeon&quot; with an interl=
aced resolution.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Easier to trigger by playing a vi=
deo on Firefox, at least on kwin_x11.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Wayland didn&#39;t exhibit the pr=
oblem.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; Other display drivers, from diffe=
rent computers I have tried, didn&#39;t<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; allow those interlaced resolution=
s all together. It seems they know<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; &gt; there will be problems.<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; __________________________________________=
_____<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; amd-gfx mailing list<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"mailto:amd-gfx@lists.freedeskto=
p.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt; <a href=3D"https://lists.freedesktop.org/m=
ailman/listinfo/amd-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--000000000000e6264905beeaae22--

--===============0020835662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0020835662==--
