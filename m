Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D9C7C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 19:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7064D10EDCA;
	Fri, 28 Apr 2023 19:20:39 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D5610EDCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 19:20:36 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-506c04dd879so85421a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 12:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682709634; x=1685301634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jfT87RgWPNkUCBU/b7u8FyaDVGUhRsiXnT63fm10TqQ=;
 b=bBYP9hOnWXR1igX1yqEuvIBwjRvPrs9FmEQ68LJEDsOCnAZB4iOnjv4zy5c1EGKgWn
 HodxB6DzrIVap6UZ7mBxnwBHte/XnmXv3xaXGqCqVy7DAsvhXNvnbAM/JT6dRjeIkOOo
 U21xKVGBjMq99BwsLX8XPa8mAtRaWfHBj0vLCD7zlAgEO3jNxKX2UJt5az4U9pMtwUEc
 3wq+svusvsCn5uRl0jt5bxyffbEd6yZQaiNE7Sk+A9sGsPZRttcLYLFL6Usn49nsQOhh
 VuXDf6Cn2U1P+2SJpnAfvXKir7IJtOS+rSUIEGqdSre4oUdvx7Fp9onV0CVB2MTm0w/z
 gEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682709634; x=1685301634;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfT87RgWPNkUCBU/b7u8FyaDVGUhRsiXnT63fm10TqQ=;
 b=Fe4Zz0IcNnSiH9SoW6zVF7Nsbs2slyzYr/mb70Jf/FbtDar0vql81f7fwP+MJn5THY
 fltSoWVaP0TJ8oyNBBCu+gqASsanqjAu+SG7He3yxL3hO+ciaNADe11SbVq2t6kkilrZ
 KQb9tqY5zUAC9Z+/ETcDYtdknv5vuBbuSZrO/WZBUwMtOAF7jLm4wephIKELr6RosA82
 2zE23q1N1JlYAsEF9pKsswp1u61Mu+ye2z263bNg1hymUQMaU9sqplrsHSHBlltKSwQO
 pRruuljMRqZswn4t3J8vLBMwKP+RLhlt2vC6nFLoPHb1jg/yzWmvxJaQc/M6fcxL3yes
 CSsQ==
X-Gm-Message-State: AC+VfDxsZ77apf78ngfsqHkZu75H/txiY4yiL/Q7inh0ftetDyn+l78v
 /J1EN1ciHCVn5EUJVXV23SMxlkRWF5e8Lo1DJtzxxNcBW60=
X-Google-Smtp-Source: ACHHUZ6aI1OZZ673OSfUfJQ31yNFfFoyeYCNNVWTgMk08as6C+vWLLjXXQfNF6Q6qpwmhFxmXewph/SYiFq5YqbtCmI=
X-Received: by 2002:aa7:d3ca:0:b0:4fe:9555:3a57 with SMTP id
 o10-20020aa7d3ca000000b004fe95553a57mr5868133edr.16.1682709634181; Fri, 28
 Apr 2023 12:20:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
 <a5bc4356-444a-b9f7-0679-b540117b8aa2@amd.com>
In-Reply-To: <a5bc4356-444a-b9f7-0679-b540117b8aa2@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Fri, 28 Apr 2023 15:20:22 -0400
Message-ID: <CAAxE2A7F5Qz7kMx2rrWv3m-nov7Zg+kr71bFQbY09J1G6i3xuA@mail.gmail.com>
Subject: Re: drm/amd/display: disable display DCC with retiling due to worse
 power consumption
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Content-Type: multipart/alternative; boundary="000000000000016d8505fa6a5ea5"
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--000000000000016d8505fa6a5ea5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

git send-email doesn't work for me since Gmail broke it some number of
years ago.

The code contains a detailed comment, so that the commit message doesn't
need it (it would be identical). It's better to put comments in the code
than the commit.

Marek

On Fri, Apr 28, 2023, 10:16 Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:

>
> Hey Marek,
>
> On 4/28/23 05:47, Marek Ol=C5=A1=C3=A1k wrote:
> > Hi,
> >
> > It's attached for review.
>
> Please send this to the mailing list using git-send-email(1). Also,
> please include a commit description and it would be helpful if you
> included "Link:"s to any relevant issues that you are tracking in
> association with this patch.
>
> >
> > Thanks,
> > Marek
> --
> Hamza
>
>

--000000000000016d8505fa6a5ea5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>git send-email doesn&#39;t work for me since Gmail b=
roke it some number of years ago.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">The code contains a detailed comment, so that the commit message =
doesn&#39;t need it (it would be identical). It&#39;s better to put comment=
s in the code than the commit.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Marek<br><br><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr=
" class=3D"gmail_attr">On Fri, Apr 28, 2023, 10:16 Hamza Mahfooz &lt;<a hre=
f=3D"mailto:hamza.mahfooz@amd.com">hamza.mahfooz@amd.com</a>&gt; wrote:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex"><br>
Hey Marek,<br>
<br>
On 4/28/23 05:47, Marek Ol=C5=A1=C3=A1k wrote:<br>
&gt; Hi,<br>
&gt; <br>
&gt; It&#39;s attached for review.<br>
<br>
Please send this to the mailing list using git-send-email(1). Also,<br>
please include a commit description and it would be helpful if you<br>
included &quot;Link:&quot;s to any relevant issues that you are tracking in=
<br>
association with this patch.<br>
<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Marek<br>
-- <br>
Hamza<br>
<br>
</blockquote></div></div></div>

--000000000000016d8505fa6a5ea5--
