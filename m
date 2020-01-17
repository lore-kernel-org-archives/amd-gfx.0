Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B2DC33C9E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 22:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1700C2464B
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 22:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/0qGfxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1700C2464B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEC576F956;
	Fri, 17 Jan 2020 22:50:21 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34FA26F958
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 22:49:43 +0000 (UTC)
Received: by mail-oi1-x233.google.com with SMTP id a67so23675958oib.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 14:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8lrn3rnQyOfjQDBPcoqXhjZoHVf1BxPOsWquFC/JuUI=;
 b=J/0qGfxKI5KsoQRdDklhoHLTRcET0nUYFEMV8AieA/HccG3ovvdoQuTt+E1cX+Ml6R
 m1GtifKYtQwWa/b6kYIombzJ/wV8Knr7jBXl7F9b+HH2zrI5X9B0I3BsL6qX7xUJ4hNL
 E7diIA36rfokLCl780MgzliJCQlVL1+XvaQzFUzdi+cOX7OlZRuBMFrkOT5ooApNhfgL
 rYkYOwO28Q4MGroz0cz9S+R4XXnRscgZ6toswyxJ7b3BgFXuGXzKnBaMVa0XWrrMONTC
 cBDld/BBhaOfYlonTjziPQ9BU5Yccr/z7BxjmF4oJzGG87CoDQbXxmv/hVhAs7lRbBuS
 iulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8lrn3rnQyOfjQDBPcoqXhjZoHVf1BxPOsWquFC/JuUI=;
 b=d5B6DMEhQEtfxWGUYEcljoGW5RLwqDuqEA72v1k8ZeYJzvWWrCdz8WjqZm+NUqy0wb
 CRgrWcpXfSL7tisyBPWqgwO/wQrRQgk1WNto3Gut/sRPSvFscabQC7k8wQhasnIPkmLS
 fX3qZXsf11fcmZ4YhddmJa8WQs5yZWy+jFFZyjHGDUGvYOtSReGpf5jJtA9vHGwpA0HD
 IUt5M9ON3VAR8tk73Y2gUo6pCn7hBl9rzj/4o8zncmBTzlj+cjPJcSOwutmCHWvJD/s2
 3pLgs7i76zI/R9mAnsM83ZomvEgzQNGTChz1j2bFFy6fcGgkx6sc/UwaTUVi3lV6EIZG
 pOnQ==
X-Gm-Message-State: APjAAAXgEJ+3HZf0l4EcOEcL7khaan0g5s1izp52s+8URe62gT8abWIF
 TxeuPMfLitoh6XJlEU421jx/TrpU86RfZIlF5sg=
X-Google-Smtp-Source: APXvYqzpRpq5CBwlKh0S9vdwjUDLPSsK3YI++nmxQu5qheeUruf3cW3pFblwXpH/7vz1rf8Lp3OsPzXy9KokDLmQmTE=
X-Received: by 2002:a54:4117:: with SMTP id l23mr5053455oic.140.1579301382430; 
 Fri, 17 Jan 2020 14:49:42 -0800 (PST)
MIME-Version: 1.0
References: <CANDnon=0S6yCCz17jUXKJ9eR_URpF2Mg9Rty4awmcDeKb0kF1w@mail.gmail.com>
 <CAD=4a=V0-k7+FU+fYgDJxeWtNJgdDXS49Qjie0KETKp6YWWjeQ@mail.gmail.com>
In-Reply-To: <CAD=4a=V0-k7+FU+fYgDJxeWtNJgdDXS49Qjie0KETKp6YWWjeQ@mail.gmail.com>
From: =?UTF-8?Q?Martin_B=C3=A5ngens?= <marbangens@gmail.com>
Date: Fri, 17 Jan 2020 23:49:00 +0100
Message-ID: <CANDnon=a_JcrTKMv+4KqBj5kHqYjX7TNkHzqqJXu1_0XQMrDJQ@mail.gmail.com>
Subject: Re: Radeon rx 590 Fatboy on Linux still don't work
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
X-Mailman-Approved-At: Fri, 17 Jan 2020 22:50:21 +0000
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1151587226=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1151587226==
Content-Type: multipart/alternative; boundary="000000000000e4a7fd059c5dc1a5"

--000000000000e4a7fd059c5dc1a5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think so because Ubuntu worked but games lagged and wasn't playable I
could give pop os a go too

Den fre 17 jan. 2020 kl 23:00 skrev Ernst Sj=C3=B6strand <ernstp@gmail.com>=
:

> Could it be something platform related? "Socket 2011 for 2nd
> Generation Core=E2=84=A2 i7 Processors " is probably not very well tested
> these days. It should work of course.
>
> Den fre 17 jan. 2020 kl 18:48 skrev Martin B=C3=A5ngens <marbangens@gmail=
.com>:
> >
> > I still have problems with my video card. I don't think this is about
> throttling beaus I only see the problem with specific games. Like all gam=
es
> after 2010 and most games after 2005. I don't know what information to gi=
ve
> you developers. I have time to do anything just tell me if you need me to
> test something.
> >
> > when I play for example Balck Mesa Xen on steam after about 5-10 min
> xorg will crash and sometimes the Linux kernel too
> >
> > I have attached a picture show what the screen looks like and a dmesg
> log I recorded right after Xorg crashed
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--000000000000e4a7fd059c5dc1a5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I think so because Ubuntu worked but games lagged and wasn=
&#39;t playable I could give pop os a go too<br></div><br><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">Den fre 17 jan. 2020 kl 23:=
00 skrev Ernst Sj=C3=B6strand &lt;<a href=3D"mailto:ernstp@gmail.com">ernst=
p@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Could it be something platform related? &quot;Socket 2011 for 2nd<br>
Generation Core=E2=84=A2 i7 Processors &quot; is probably not very well tes=
ted<br>
these days. It should work of course.<br>
<br>
Den fre 17 jan. 2020 kl 18:48 skrev Martin B=C3=A5ngens &lt;<a href=3D"mail=
to:marbangens@gmail.com" target=3D"_blank">marbangens@gmail.com</a>&gt;:<br=
>
&gt;<br>
&gt; I still have problems with my video card. I don&#39;t think this is ab=
out throttling beaus I only see the problem with specific games. Like all g=
ames after 2010 and most games after 2005. I don&#39;t know what informatio=
n to give you developers. I have time to do anything just tell me if you ne=
ed me to test something.<br>
&gt;<br>
&gt; when I play for example Balck Mesa Xen on steam after about 5-10 min x=
org will crash and sometimes the Linux kernel too<br>
&gt;<br>
&gt; I have attached a picture show what the screen looks like and a dmesg =
log I recorded right after Xorg crashed<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd=
-gfx@lists.freedesktop.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--000000000000e4a7fd059c5dc1a5--

--===============1151587226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1151587226==--
