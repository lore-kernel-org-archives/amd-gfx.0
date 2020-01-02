Return-Path: <SRS0=MtTs=2X=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D511CC2D0DC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 10:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D8E2085B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2020 10:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0y07jaV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D8E2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051F389FEC;
	Thu,  2 Jan 2020 10:29:20 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA54589FEC
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2020 10:29:18 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id d16so38748539wre.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Jan 2020 02:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pdMatIxq5HYYRrIdFUXP24ZnlSDU6x6qAohthZEYXPg=;
 b=c0y07jaViF0I/HT2zpJTEZwcGY7lTAEUN5Y5SV8+foBIQ4MWmkm+bYBUEOA0H3OaUH
 ud7NRc3tjPphZesqxxYgtjlistF0ZS4/+y/nkOOht3qQmY0lFxlWjK8F/3yVWLhYHGQ4
 IdV02U6XE5dQtapiwlaAJlSgHaWIxgI4ntWGsWyIFa1AdlbNqcZGzymAbzx5BMysDTmh
 hw8taOZJXsnl1LXiLuXk9p5Flc9y6JV/buB8dgZ9f5quh1RfhwaNoKcUCG9PfZj+yyNC
 jmFtq/HRGidXLD3oguvawR2zP9mT/yWok/WKRzepsdEYQcYa4XNjgVY3gdnffJLqzXTu
 Zs/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pdMatIxq5HYYRrIdFUXP24ZnlSDU6x6qAohthZEYXPg=;
 b=dKdSxiihwDOYalybjsJTInPV9WAQqUoVefQLwKBCyLehCYB4etAQbwanMzaShTSlOK
 vVC25q0akngSLQQdzxrW1MUm1bxsWuwrSlc6Jy5n8ntktx9Jml/O01tKc3Wb8dVMP+nX
 G0+LAFFCsRtorGK/0VJ9R4Y/NNelzaNRUmPnWOSWUAB4VDfDYCX2KflQ9cwJw+2khnvo
 0gGSZ0ePGtN0sqep0TJXVXNT8YhgcmWZ1o4sfrcUsCcgNrorTAF9vDFf+cJToidTvIeO
 UnUA4v5c4iuBcf+n4DWpS1DVzIvrOlcZbPhjjbC72lcSYDzDdXPWPYmuynINItb5pCRy
 FIBA==
X-Gm-Message-State: APjAAAXxHgwm3G4v0NzoAxCmJ+imB1CaC/OoTxbZwXv/ntj4MIVN0YpB
 OxZ/rkF+PZjxtbTbgQL9o8eP4hj0K89LU0ASWkhI3UxX
X-Google-Smtp-Source: APXvYqzizd3EO/a21E3fW8WMV8hg804RXKSgPEeWLvTQGEoY4IuEDLikR8oMgjinyliYES9NtC+jAOV1cJRl7PTl+y0=
X-Received: by 2002:adf:fe90:: with SMTP id l16mr86374420wrr.265.1577960957438; 
 Thu, 02 Jan 2020 02:29:17 -0800 (PST)
MIME-Version: 1.0
References: <CAGzVRjxUUoF=m6-NvnRoqagLRAWQvTDVHA7Hkr=UA-_wRRyAZQ@mail.gmail.com>
 <MN2PR12MB3598F90268C4C6602532C94C8E200@MN2PR12MB3598.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3598F90268C4C6602532C94C8E200@MN2PR12MB3598.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Yusuf_Alt=C4=B1parmak?= <yusufalti1997@gmail.com>
Date: Thu, 2 Jan 2020 13:29:06 +0300
Message-ID: <CAGzVRjyxvOYZvQLfEa0WRmcY6Zi+MxqRotUiN1d3OOwD-5GQ-w@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1424115230=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1424115230==
Content-Type: multipart/alternative; boundary="000000000000566f7a059b25aa8c"

--000000000000566f7a059b25aa8c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

First you could check if the binary =E2=80=98polaris12_smc.bin=E2=80=99 is =
in your system:
> /lib/firmware/../amdgpu/
>
'polaris12_smc.bin' exists in my /lib/firmware/amdgpu folder. There are
also 18 other binaries which starts with 'polaris12_'.

If it=E2=80=99s there, then does this happen after a warm reset?
>

This does happen when booting up the board with ramdisk image (initrfs
stage).

Regards.

>

--000000000000566f7a059b25aa8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hello,</div><div><br></div></div><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div lang=3D"EN-US"><div class=3D"gmail-m_-4215317245418845344WordSection1">
<p class=3D"MsoNormal">First you could check if the binary =E2=80=98polaris=
12_smc.bin=E2=80=99 is in your system: /lib/firmware/../amdgpu/</p></div></=
div></blockquote><div>&#39;polaris12_smc.bin&#39; exists in my /lib/firmwar=
e/amdgpu folder. There are also 18 other binaries which starts with &#39;po=
laris12_&#39;.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div lang=3D"EN-US"><div class=3D"gmail-m_-4215317245418845344Wo=
rdSection1"><p class=3D"MsoNormal"><u></u><u></u></p>
<p class=3D"MsoNormal">If it=E2=80=99s there, then does this happen after a=
 warm reset?</p></div></div></blockquote><div><br></div><div>This does happ=
en when booting up the board with ramdisk image (initrfs stage).</div><div>=
<br></div><div>Regards.<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div lang=3D"EN-US"><div class=3D"gmail-m_-4215317245418845344WordS=
ection1"><div><div>
</div>
</div>
</div>
</div>

</blockquote></div></div>

--000000000000566f7a059b25aa8c--

--===============1424115230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1424115230==--
