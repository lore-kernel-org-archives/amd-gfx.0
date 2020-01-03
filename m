Return-Path: <SRS0=CYQS=2Y=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0484BC2D0CE
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 06:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6763217F4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jan 2020 06:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2ETgF/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6763217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B2D6E18E;
	Fri,  3 Jan 2020 06:14:22 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 309DA6E18E
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jan 2020 06:14:21 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id d73so7465936wmd.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2020 22:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sFMV8FsFHEOXH0Vpd9V2X+tEtl4hMhJVDXJWXVqLDzg=;
 b=e2ETgF/iaVOr5hgJhFU5BqDJUWmbWOU0m4pkQPl4KMqd7VdOSok6L0s4cs3arMlZ7Y
 R69VfJgof1oC4ADet+M1lQlSXW9rP4kBIB8cMSZ95pCST721yz+tQVCLANpug80SiPZo
 S1CnxRkk+zzW6UuY+19UHZGR4LxBCq8wN5IBJgCC1xBXQWTFSeZIyemx/K06j6mvkem0
 A+QiUacmKx5lWDVE+gmnh4loHh78c4VYx3dpOhM8CnUd1G3Roa737f+bm+Jlsptqn/gT
 CtXCVbswWON+2AiDv1zYrBmzG/bvV7Xp7XHy9zsULbQEX0Mft/PxrJSyMoVL6qi1qHwO
 eszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sFMV8FsFHEOXH0Vpd9V2X+tEtl4hMhJVDXJWXVqLDzg=;
 b=VdSsDpeVf1dYptFsIY3ikDQhcdairVit7hNAsye5HppQDqHTuGbRRktKbNE46KJZ8a
 mDlloTUSw40lzWrx5HLV3aZcHS77AesFnU1lOJWscQZhgQP4ZQ7gUFoTwMhL3IQuxMa9
 U7rYkmazVDED/KImVFN3S9EtND8iJiP/wHFUoznTA7VzViGTcXo+agTLuB7jfE/uAF7k
 IJ9bQsrC3/6HpN+7a1o4bJWjD4ujZ/6TyrzprLkFR4J3OXscRXOe8mnm7ygJYxY7eG61
 WhTyJjoUvA7FLc/aRokW3QWkVdc6ikVmFRkPHCqN8G9/kaQWlZnbJGcfN5WHIF7bNqTB
 WN5Q==
X-Gm-Message-State: APjAAAWZz35YabBigyqPCcX+7MBrM5PcNO7b86YfigOOQy11QGi4wxex
 GLEk0wjlwYl7bwYuDm2nmYe6OyYU2jhNp13IoJg=
X-Google-Smtp-Source: APXvYqzfI25XlC1Sim3R59Vos9AVofJ0HMD7TR5ftW65vDuVz421Fa1eizWObAEMPfcG9k0KoiEi8TgJLk70c7umB78=
X-Received: by 2002:a7b:c246:: with SMTP id b6mr17486243wmj.75.1578032059768; 
 Thu, 02 Jan 2020 22:14:19 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjxUUoF=m6-NvnRoqagLRAWQvTDVHA7Hkr=UA-_wRRyAZQ@mail.gmail.com>
 <MN2PR12MB3598F90268C4C6602532C94C8E200@MN2PR12MB3598.namprd12.prod.outlook.com>
 <CAGzVRjyxvOYZvQLfEa0WRmcY6Zi+MxqRotUiN1d3OOwD-5GQ-w@mail.gmail.com>
In-Reply-To: <CAGzVRjyxvOYZvQLfEa0WRmcY6Zi+MxqRotUiN1d3OOwD-5GQ-w@mail.gmail.com>
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Fri, 3 Jan 2020 09:14:08 +0300
Message-ID: <CAGzVRjw46E2=v+wZQp5j+bLR8uRkjYz9Z=NDdoZ5kF4kgtmQVg@mail.gmail.com>
Subject: Re: [Error] amdgpu powerplay ip block error with -22.
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============0509903197=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0509903197==
Content-Type: multipart/alternative; boundary="0000000000005de4ce059b36387e"

--0000000000005de4ce059b36387e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Still can't find a solution about this. Anyone can help me about this ?

Regards.


Yusuf Alt=C4=B1parmak <yusufalti1997@gmail.com>, 2 Oca 2020 Per, 13:29 tari=
hinde
=C5=9Funu yazd=C4=B1:

> Hello,
>
> First you could check if the binary =E2=80=98polaris12_smc.bin=E2=80=99 i=
s in your system:
>> /lib/firmware/../amdgpu/
>>
> 'polaris12_smc.bin' exists in my /lib/firmware/amdgpu folder. There are
> also 18 other binaries which starts with 'polaris12_'.
>
> If it=E2=80=99s there, then does this happen after a warm reset?
>>
>
> This does happen when booting up the board with ramdisk image (initrfs
> stage).
>
> Regards.
>
>>

--0000000000005de4ce059b36387e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>Still can&#39;t find =
a solution about this. Anyone can help me about this ?</div><div><br></div>=
<div>Regards.<br></div><div dir=3D"ltr"><br></div><div dir=3D"ltr"><br></di=
v><div dir=3D"ltr">Yusuf Alt=C4=B1parmak &lt;<a href=3D"mailto:yusufalti199=
7@gmail.com" target=3D"_blank">yusufalti1997@gmail.com</a>&gt;, 2 Oca 2020 =
Per, 13:29 tarihinde =C5=9Funu yazd=C4=B1:<br></div><div class=3D"gmail_quo=
te"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div=
 dir=3D"ltr"><div>Hello,</div><div><br></div></div><div class=3D"gmail_quot=
e"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div lang=3D"EN-US"><d=
iv>
<p class=3D"MsoNormal">First you could check if the binary =E2=80=98polaris=
12_smc.bin=E2=80=99 is in your system: /lib/firmware/../amdgpu/</p></div></=
div></blockquote><div>&#39;polaris12_smc.bin&#39; exists in my /lib/firmwar=
e/amdgpu folder. There are also 18 other binaries which starts with &#39;po=
laris12_&#39;.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div lang=3D"EN-US"><div><p class=3D"MsoNormal"><u></u><u></u></=
p>
<p class=3D"MsoNormal">If it=E2=80=99s there, then does this happen after a=
 warm reset?</p></div></div></blockquote><div><br></div><div>This does happ=
en when booting up the board with ramdisk image (initrfs stage).</div><div>=
<br></div><div>Regards.<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div lang=3D"EN-US"><div><div><div>
</div>
</div>
</div>
</div>

</blockquote></div></div>
</blockquote></div></div>

--0000000000005de4ce059b36387e--

--===============0509903197==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0509903197==--
