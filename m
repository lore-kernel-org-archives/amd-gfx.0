Return-Path: <SRS0=L9B0=GG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB80FC433DB
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Jan 2021 11:06:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A80F120771
	for <amd-gfx@archiver.kernel.org>; Sun,  3 Jan 2021 11:06:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80F120771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00BDA89B48;
	Sun,  3 Jan 2021 11:06:24 +0000 (UTC)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BCBD89B48
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Jan 2021 11:06:23 +0000 (UTC)
Received: by mail-qt1-x831.google.com with SMTP id u21so16622357qtw.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 03 Jan 2021 03:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e3Q+7IaKcr7FnV1l73LX/HRu1A9iTYWLfnCxnaapXZ0=;
 b=PUiZBReEEGVRm3E8395/5Hac2uPefoBWQ6GhkSr95Q/v8Dr5bkY8zLQ/NFe8I4OH3L
 IEshA6DgDLAkprx1vu5tdcqvA24Y5v8tP0GASynQLaRovuzSgk4r+Z0UMpuhc9mkcu2F
 3psejd3JfOoJmvCCredNgzreEeUak6XZHm5ktZueM2g50AIw984UG3Uw0nzax0pGXYLn
 XB4BnHgaiK63mBrFVgg/JszTeg2qk5CRxCMB4iq9+7f/8mSpeVWu/n3zbvfEsfiOiNTT
 RTiojQNAfCT0vIcL/QKEBTWWJPcFE0GfO0zYfclTSL+tVZuh0HbhTjp2Mg3XBxd+QDXf
 YJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e3Q+7IaKcr7FnV1l73LX/HRu1A9iTYWLfnCxnaapXZ0=;
 b=alsYMfDcxiV0j2jCCjAi8pYlGp8gzBqQXZMkk+CjGaoyc1jm4uZNOEUHELPStM48g7
 vBid09H/V+WZ5qv3wjS8I6KRwYOw4YxjdZrvgoD2MaGodjDZTTFpJe2kpHMvkVp6ZLEj
 MCv2qJ0XBgW8bUq2m1OvPKaOUGcGVsfmX5owal9HgdoGcbecOK5SHO2VOu3WD+93RCGG
 CQb1qOisl4Lir0wu3JXlpPp544HGmHeRQ3LLQbrvlkqBMEE5+byymxHWMHmdFZxQfOTF
 W3I55o/7ePaLGEoPt5Mh6ZM8GGwPBdD49nOaOFF+LeQpg3vrK3rCuBFaj69e8qnWsvWJ
 AIXA==
X-Gm-Message-State: AOAM531mVJQbzHW1VK54rV4E2GPTVeblYTepxPF75sCPExS+t7M3vN5X
 aQtukkfwWFl+3PSqYTbsNG6xx9wBpUqHjEJwIcZlsA==
X-Google-Smtp-Source: ABdhPJz2+CydjgYuvgA4bqOfcbPXQPg/qliGmblo0T2EXYpg6ELueXK1X0lTvBvMYjsuCJ1lB4ow7QIVMrkMXIFSqZ4=
X-Received: by 2002:ac8:396d:: with SMTP id t42mr65990927qtb.273.1609671982031; 
 Sun, 03 Jan 2021 03:06:22 -0800 (PST)
MIME-Version: 1.0
References: <CAM0ywnxwE9bRafJJZcg4w8GooXiDrJKV0gt+p9XJv=Y6HrmA0w@mail.gmail.com>
In-Reply-To: <CAM0ywnxwE9bRafJJZcg4w8GooXiDrJKV0gt+p9XJv=Y6HrmA0w@mail.gmail.com>
From: Mike Lothian <mike@fireburn.co.uk>
Date: Sun, 3 Jan 2021 11:07:17 +0000
Message-ID: <CAHbf0-EyfNYkcvBhnBt=rTsCTLbJATApE2sZwfyRizN6JrS4iw@mail.gmail.com>
Subject: Re: amdgpu does not support 3840x2160@30Hz on kaveri apu
To: Davide Corrado <davide@davidecorrado.eu>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1202142884=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1202142884==
Content-Type: multipart/alternative; boundary="000000000000b1c46005b7fcf633"

--000000000000b1c46005b7fcf633
Content-Type: text/plain; charset="UTF-8"

Hi

You're probably best reporting the bug here:

https://gitlab.freedesktop.org/drm/amd/-/issues

Attach the output of dmesg from both Radeon and AMDGPU and the compositor /
Wayland logs (as you're not using X)

Cheers

Mike



On Sun, 3 Jan 2021, 06:32 Davide Corrado, <davide@davidecorrado.eu> wrote:

> hello, I'd like to report this issue that I am having since I updated my
> display (samsung U28E590). The amdgpu does not support the native
> resolution of my new monitor, which is 3840x2160*.* Using a HDMI or DVI
> connection (I tried both, same results), the maximum supported refresh is
> 30Hz, so I'm stuck with that (don't have a displayport). The radeon module
> works fine, I'm having this issue just when I use amdgpu (which I'd like
> to, because performance is better).
>
> Some info of my hardware:
>
> cpu: AMD A10-7870K Radeon R7, 12 Compute Cores 4C+8G
> kernel version (I tried different ones and different linux distros, same
> results!): 5.9.16-200.fc33.x86_64 #1 SMP Mon Dec 21 14:08:22 UTC 2020
> x86_64 x86_64 x86_64 GNU/Linux
> Monitor: Samsung U28E590.
>
> description:
> If I boot the system using amdgpu and no video mode selection, the system
> boots but I don't get a screen during boot and in wayland. I can connect
> using ssh, so the system is running fine, just no display; If I force a
> full HD resolution with "video:" in the kernel line, I can see the boot
> process but the screen disappears when wayland starts (because the default
> resolution is 3840x2160@30Hz). Using a full HD monitor results in no
> issues, so it must be related to this very 4k resolution.
>
> As I have already stated, radeon module works with the same
> software/hardware configuration.
> thanks you so much for your time :-)
>
> --
> Davide Corrado
> UNIX Team Leader
>
> Via Abramo Lincoln, 25
> 20129 Milano
>
> Tel +39 3474259950
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000b1c46005b7fcf633
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi<div dir=3D"auto"><br></div><div dir=3D"auto">You&#39;r=
e probably best reporting the bug here:</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues"=
>https://gitlab.freedesktop.org/drm/amd/-/issues</a></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Attach the output of dmesg from both Radeon an=
d AMDGPU and the compositor / Wayland logs (as you&#39;re not using X)</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Cheers</div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Mike</div><div dir=3D"auto"><br></div><div di=
r=3D"auto"><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Sun, 3 Jan 2021, 06:32 Davide Corrado, &lt;<a href=
=3D"mailto:davide@davidecorrado.eu">davide@davidecorrado.eu</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>hello, I&#39;=
d like to report this issue that I am having since I updated my display (sa=
msung U28E590). The amdgpu does not support the native resolution of my new=
 monitor, which is 3840x2160<i>.</i> Using a HDMI or DVI connection (I trie=
d both, same results), the maximum supported refresh is 30Hz, so I&#39;m st=
uck with that (don&#39;t have a displayport). The radeon module works fine,=
 I&#39;m having this issue just when I use amdgpu (which I&#39;d like to, b=
ecause performance is better).</div><div><br></div><div>Some info of my har=
dware:</div><div><br></div><div>cpu: AMD A10-7870K Radeon R7, 12 Compute Co=
res 4C+8G</div><div>kernel version (I tried different ones and different li=
nux distros, same results!): 5.9.16-200.fc33.x86_64 #1 SMP Mon Dec 21 14:08=
:22 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux</div><div>Monitor: Samsung U28E=
590.</div><div><br></div><div>description:<br></div><div>If I boot the syst=
em using amdgpu and no video mode selection, the system boots but I don&#39=
;t get a screen during boot and in wayland. I can connect using ssh, so the=
 system is running fine, just no display; If I force a full HD resolution w=
ith &quot;video:&quot; in the kernel line, I can see the boot process but t=
he screen disappears when wayland starts (because the default resolution is=
 3840x2160@30Hz). Using a full HD monitor results in no issues, so it must =
be related to this very 4k resolution.<br></div><div><br></div><div>As I ha=
ve already stated, radeon module works with the same software/hardware conf=
iguration.<br></div>thanks you so much for your time :-)<br><div><div><br>-=
- <br><div dir=3D"ltr" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">Davide Co=
rrado<br><div>UNIX Team Leader<span><br></span></div><div><br></div>Via Abr=
amo Lincoln, 25<br>20129 Milano<br><br>Tel +39 3474259950<br></div></div></=
div></div></div></div></div></div></div></div></div>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank" rel=3D"n=
oreferrer">amd-gfx@lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailm=
an/listinfo/amd-gfx</a><br>
</blockquote></div>

--000000000000b1c46005b7fcf633--

--===============1202142884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1202142884==--
