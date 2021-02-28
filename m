Return-Path: <SRS0=JjkA=H6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8DCC433DB
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 23:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2191164E27
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 23:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2191164E27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D078289D39;
	Sun, 28 Feb 2021 23:12:30 +0000 (UTC)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD09789D39
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 23:12:29 +0000 (UTC)
Received: by mail-pj1-x1036.google.com with SMTP id u12so10230730pjr.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 15:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5dMesOqEuKIOWOVg5pDq60Ghp6RHNn9TdiW++CrYxaQ=;
 b=nj6KlTJ4R6qyoKvMYjPkSDoTZ8oVevjQH4yKh7KKUGBgCUmixos//ZJOAFADxRjo7q
 yddeZOASywsB65uf0fDcA8LV4+9WxgJYGdhKQe1fG3lortfNcBmR+Okj2ngq41rXtvv9
 LSJw0F3ruulnaPRUFKQ3R2m/StlmcKJBf9b6g90in+rDr4CcgO3l59grVfHXeTRYc5hs
 ikFS98TdZQZ0dSNZc7C3HtBvaFhIWAaXNiN6gn+j9Djhv0EAhIcWgTtrOlujKmm79bUS
 9ODvpbvOPoaBC9qGKFUlTsHbLGbB0CIx7noy9Ip08m3Nr/8vN+EyuSAhnfk/H0PDH0HU
 vE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5dMesOqEuKIOWOVg5pDq60Ghp6RHNn9TdiW++CrYxaQ=;
 b=rS49zAd9rdqG93dSZ+RGLZMj70yWO+g+8SP2hxoNY9A6OHT1pP/LKuIaPBJmBi4GGv
 twUkMbwiVQZZk71bJtmzqOoq1YjYYAE4yprOXlU5dE/fdG8HaCw5ZoASYdo8nzCHfymt
 YCZ7NHqx8UZdRkRy+VVJc4dOvZeZCW/dy9PMkmdjBIoPSlAfTDmBVRX1PL1LmPOlroCK
 IziT/jYVHFBlJbojMwjn8UBLEV5Gp/nWmntYufzxzMSX4uHj6d86kJnXRMBSPu7K2XH4
 Pv38zNC1ZqAfegLji93DmxiKwswjxiCiKl87rqL48nXOeXoweSZwymJotUyX5IMlk+eq
 6GZQ==
X-Gm-Message-State: AOAM5310O7SgQZ/xMD/A4ojrHL7S+nZ9alA0G7UQ6+qmN1GxDb2agBho
 QBVAbcKWQ6+GgDZyb/shbYDdweC23rZohaLTc9rWrYsqRU5p8w==
X-Google-Smtp-Source: ABdhPJygZOuiphV+qfqT1opkn7O2pd/9Ab3Md9VM1OqMhRCkFnpqbQ0Ot2fLmvsHqmd30XQaQ/hWh2/oCB0FQKy9BFA=
X-Received: by 2002:a17:90b:3716:: with SMTP id
 mg22mr7451580pjb.157.1614553949379; 
 Sun, 28 Feb 2021 15:12:29 -0800 (PST)
MIME-Version: 1.0
References: <CA+gx7UpBhKc0uwLhtN6ZVjWbMJuJYSJ9mQwk_fHtEikh6t3oRQ@mail.gmail.com>
 <CAD=4a=U0JqDAuA-U2BD6=Rp3eLBFkSNTsFNy+cQnUX9aJVfmOQ@mail.gmail.com>
In-Reply-To: <CAD=4a=U0JqDAuA-U2BD6=Rp3eLBFkSNTsFNy+cQnUX9aJVfmOQ@mail.gmail.com>
From: Adolfo Rodrigues <adolfotregosa@gmail.com>
Date: Sun, 28 Feb 2021 23:12:18 +0000
Message-ID: <CA+gx7UqiRXc8j8Ns=fV1bpqfCZnbadcStLVxA6muEFaDCDr1ww@mail.gmail.com>
Subject: Re: 6900XT HDMI 2.1 -> Missing 4K120Hz
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0913682126=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0913682126==
Content-Type: multipart/alternative; boundary="0000000000009f9ee205bc6da222"

--0000000000009f9ee205bc6da222
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

atm, 5.10.0-14-generic (latest ofered by kubuntu 21.04 daily) but I
did try 5.11.0-051100-generic
from https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.11/ and no change.

On Sun, Feb 28, 2021 at 11:06 PM Ernst Sj=C3=B6strand <ernstp@gmail.com> wr=
ote:

> Which kernel version are you running?
>
> Den s=C3=B6n 28 feb. 2021 kl 23:48 skrev Adolfo Rodrigues <
> adolfotregosa@gmail.com>:
>
>> Hi.
>> I cannot find a way to enable 4K @ 120Hz over hdmi 2.1. It seams limited
>> to HDMI 2.0b.. is it ?
>>
>> Under Windows 10 it works fine but not under linux. Why ?
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>
>

--0000000000009f9ee205bc6da222
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">atm,=C2=A0<span style=3D"font-family:monospace"><span styl=
e=3D"color:rgb(0,0,0)">5.10.0-14-generic (latest ofered by kubuntu 21.04 da=
ily) but I did try=C2=A0</span></span>5.11.0-051100-generic from<font color=
=3D"#000000" face=3D"monospace">=C2=A0</font><a href=3D"https://kernel.ubun=
tu.com/~kernel-ppa/mainline/v5.11/" target=3D"_blank">https://kernel.ubuntu=
.com/~kernel-ppa/mainline/v5.11/</a>=C2=A0and no change.<br></div><br><div =
class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Feb 28,=
 2021 at 11:06 PM Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp@gmail.c=
om">ernstp@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"=
font-family:arial,helvetica,sans-serif">Which kernel version are you runnin=
g?<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">Den s=C3=B6n 28 feb. 2021 kl 23:48 skrev Adolfo Rodrigues &lt;<=
a href=3D"mailto:adolfotregosa@gmail.com" target=3D"_blank">adolfotregosa@g=
mail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr">Hi.<div>I cannot find a way to enable=C2=A04K @ 120Hz ov=
er hdmi 2.1. It seams limited to HDMI 2.0b.. is it ?</div><div><br></div><d=
iv>Under Windows 10 it works fine but not under linux. Why ?</div><div><br>=
</div><div><br></div></div>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>
</blockquote></div>

--0000000000009f9ee205bc6da222--

--===============0913682126==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0913682126==--
