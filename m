Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07634C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 11:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDD310E572;
	Mon, 28 Feb 2022 11:46:20 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2AB110E220
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 06:44:01 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 g7-20020a17090a708700b001bb78857ccdso13942707pjk.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Feb 2022 22:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=LFM3xQAlKa2wocS//5bDLbaQD/FO4cn4eZFhETITPIw=;
 b=jzLKGyucroxlqXTM659Cn1CbNLy639yddFT5y+xZabf6as6svAWoKzwaY04CqBUGdm
 wjlKJW8Ygs9eqGiCyBMAl0kLmBshDffcFZ7jUhrwlrG0S06rYnv/qj3T/P1+cIbYOBcu
 O1WyFfnC3BXD23WPwtoVykMYF2gsKTag8012QkKaWfMbxeqDSxMSvV0jnp1l6VTL5uGA
 S7THECptC+mlyijfOnqsCkSZfR9gEB+OS/jCSRpnKUdWYxhPf8as673as5hiONqheKaR
 guAnoCht83ocnJC8XFODSSO17J7Gh89NCXnHAswF3GcqHbTqlESAEVCLBKuwcOs/fFJF
 Ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=LFM3xQAlKa2wocS//5bDLbaQD/FO4cn4eZFhETITPIw=;
 b=m6365Z0v2ieQY6lSHOb0/VBOQ/hYj7ZqtJTH27BtQiwz0lNhVJzivGMqziu1TPfx/v
 1hbmuNt0+mPaXb2iEyaOBG0f+i/Qs5FWFH3dkQo8jKNH3HYp3GXfmjpQoCnIML4TcVsL
 fJ+GUThkDDcwVdWgbp9wO7K3f13F7XO7U+ygJU86u+roj57Kb2Kz8RSqvl9gnLbEdebv
 y4oK46cSvG7z/TIiteaCo9Cdhm1+up4JRY71qG5dWeNrsMva7NwBBlYcTs4KI064PXbm
 wcGshswAI1bsubgDXhPzO+o7ssvrHnAdgaEF2lQHoNHxR+4AvVWlonWPgI2rarkrNJJl
 k3gw==
X-Gm-Message-State: AOAM530XiIOfaHy1PmIIPfE/Gh963MUBz9nrPw/ngxiraAZ5aTr6I96U
 IOJ2YQJOXF+vDNfeuGNWswF3ELC+TpeKvWpILhDtipA3TpE=
X-Google-Smtp-Source: ABdhPJxtjBGtelklDhssfqac8BbvwMy6jmIg3xAzpMambwSwGIveCZdYwbkjPzJ27YJsLw/q/Gzhdd+4aGHmxHnuWBU=
X-Received: by 2002:a17:90a:a884:b0:1bc:347b:5cff with SMTP id
 h4-20020a17090aa88400b001bc347b5cffmr15282878pjq.224.1646030641548; Sun, 27
 Feb 2022 22:44:01 -0800 (PST)
MIME-Version: 1.0
References: <CAALKErFVZt9+5pPuDYj=zcaB9xr0=iWN4whQR2WRVK6vGe=bdQ@mail.gmail.com>
 <CAHbf0-G8Rm-Q665mrEOOds109ojvng7qA4DseJsAYq01UfaJtQ@mail.gmail.com>
In-Reply-To: <CAHbf0-G8Rm-Q665mrEOOds109ojvng7qA4DseJsAYq01UfaJtQ@mail.gmail.com>
From: Alex fxmbsw7 Ratchev <fxmbsw7@gmail.com>
Date: Mon, 28 Feb 2022 07:43:45 +0100
Message-ID: <CAALKErHVGydCZ3V2ZSNz9BCZTXCxOxgjJdmjX5BY6MyAA5xXbQ@mail.gmail.com>
Subject: Re: kernel amdgpu problems
To: Mike Lothian <mike@fireburn.co.uk>, amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000add34105d90e5f8c"
X-Mailman-Approved-At: Mon, 28 Feb 2022 11:46:19 +0000
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

--000000000000add34105d90e5f8c
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 28, 2022 at 12:22 AM Mike Lothian <mike@fireburn.co.uk> wrote:

> On Sat, 26 Feb 2022 at 10:01, Alex fxmbsw7 Ratchev <fxmbsw7@gmail.com>
> wrote:
> >
> > i have observed at least two major problems of using amdgpu
> >
> > 1. cant be built-in instead of module, display stays blank
>
> Are you remembering to add in the firmware to the kernel image too?
>

i copied all from official linux-firmware.gif to /lib/firmware

>
> There's a good guide at
> https://wiki.gentoo.org/wiki/AMDGPU#Known_firmware_blobs
>
> I've successfully used AMDGPU builtin on Tonga, Raven, Renoir and Navy
> Flounder systems
>
> I've never used kexec so have no suggestions for that
>

it may be back then when i compiled it inline not as module i didnt include
firmware in the initrd so that may been that

about kexec, i dunno, X dri doesnt work after first kexec, after second
screen at all is blank

driver init problems ..

cheers..

--000000000000add34105d90e5f8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Feb 28, 2022 at 12:22 AM Mike=
 Lothian &lt;<a href=3D"mailto:mike@fireburn.co.uk">mike@fireburn.co.uk</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On S=
at, 26 Feb 2022 at 10:01, Alex fxmbsw7 Ratchev &lt;<a href=3D"mailto:fxmbsw=
7@gmail.com" target=3D"_blank">fxmbsw7@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; i have observed at least two major problems of using amdgpu<br>
&gt;<br>
&gt; 1. cant be built-in instead of module, display stays blank<br>
<br>
Are you remembering to add in the firmware to the kernel image too?<br></bl=
ockquote><div><br></div><div>i copied all from official linux-firmware.gif =
to /lib/firmware=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
There&#39;s a good guide at <a href=3D"https://wiki.gentoo.org/wiki/AMDGPU#=
Known_firmware_blobs" rel=3D"noreferrer" target=3D"_blank">https://wiki.gen=
too.org/wiki/AMDGPU#Known_firmware_blobs</a><br>
<br>
I&#39;ve successfully used AMDGPU builtin on Tonga, Raven, Renoir and Navy<=
br>
Flounder systems<br>
<br>
I&#39;ve never used kexec so have no suggestions for that<br></blockquote><=
div><br></div><div>it may be back then when i compiled it inline not as mod=
ule i didnt include firmware in the initrd so that may been that</div><div>=
<br></div><div>about kexec, i dunno, X dri doesnt work after first kexec, a=
fter second screen at all is blank</div><div><br></div><div>driver init pro=
blems ..</div><div><br></div><div>cheers..=C2=A0</div></div></div>

--000000000000add34105d90e5f8c--
