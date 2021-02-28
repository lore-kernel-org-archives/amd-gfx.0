Return-Path: <SRS0=JjkA=H6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0D4C433E0
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 23:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66EBF64E38
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Feb 2021 23:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66EBF64E38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1078C6E442;
	Sun, 28 Feb 2021 23:06:04 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D936E442
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 23:06:03 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id lr13so24839573ejb.8
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Feb 2021 15:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=71dmCWGNogk0biRUdV8kY5V8yLc2YX1z0Y3FqDaE0Bo=;
 b=hQzshHgAsRS63gBDV3molexKmRsGR/rhemkgpjMgxXz7uJSWkzcey0QYSjPIBca94A
 u5tzoN9okilCzOyqAfJPt6PQaRHJuEeO7r3EmLypn8YCH7GO75oibBdSWKOOHEpIXIQV
 QBAS8PGtMblnKelxMSb7rK8+R90lkiqCqx5rrQ354pYyljhFfJ2Q/E75b7BcrTbE07Lu
 9Gvs1uZ9eHu/iQv1mfsytGOhUcA5i1RGszFs1rgU5CucSKiLPulB0BKrxVIKBwLeGkAy
 5besB+3q3VSU36X9Dn/Xp3h65t+hvdz0Jf/0jP6voDpc1ZpcEzTjRH0xCFYRio+XQ0Kx
 eKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=71dmCWGNogk0biRUdV8kY5V8yLc2YX1z0Y3FqDaE0Bo=;
 b=TzO6wE9FVkTj1KGHRs0gCvoezs7uAdG0m5LpFRGKSnVxi3q0iaY3GU83CPsEqO4twx
 MM0tq7jEaUGH9UFe01zA+mdacH3hFpHRWpFG/A/B1M8d3cpLMYjyQgW966AXjx/QeDgx
 y+BlUkKK25v+f0Yt8XnxOmRlcHGokypjwXj/LSnTG/Tz6XuP6LVtr3Y5AWtp2IRQmvUN
 AaHKzuCe2et5do7MuvCyaCji0Ll1K3bRUaLQpMj108XEQqfuSs80Fl8EG73OOE+IZNAx
 BarYUiSC8B5F9ma66egzNwcJBGSatjvLCXVIUmaMQ9m4lbu0sWUpcldPsFwMyJkwN672
 0VJA==
X-Gm-Message-State: AOAM5311sVu2XmfXVx4w3BAVFPKiEo4kYH+HZfGlFKSun1A79qHijz7h
 Q9xSF3c59AS4LbApcEHkuQl45gox4cRr9z/sSygcVvI4bYU=
X-Google-Smtp-Source: ABdhPJyRZA2ZYqM3VpsxFF0EB61OX7WGpS83n1yQMel7LCMqeMVEDeMEN1YHlW0blELCLPCzrRReICVc8Zq/UQURBWg=
X-Received: by 2002:a17:907:d86:: with SMTP id
 go6mr12856036ejc.337.1614553562324; 
 Sun, 28 Feb 2021 15:06:02 -0800 (PST)
MIME-Version: 1.0
References: <CA+gx7UpBhKc0uwLhtN6ZVjWbMJuJYSJ9mQwk_fHtEikh6t3oRQ@mail.gmail.com>
In-Reply-To: <CA+gx7UpBhKc0uwLhtN6ZVjWbMJuJYSJ9mQwk_fHtEikh6t3oRQ@mail.gmail.com>
From: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Date: Mon, 1 Mar 2021 00:05:51 +0100
Message-ID: <CAD=4a=U0JqDAuA-U2BD6=Rp3eLBFkSNTsFNy+cQnUX9aJVfmOQ@mail.gmail.com>
Subject: Re: 6900XT HDMI 2.1 -> Missing 4K120Hz
To: Adolfo Rodrigues <adolfotregosa@gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1428852632=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1428852632==
Content-Type: multipart/alternative; boundary="0000000000008da25305bc6d8bc3"

--0000000000008da25305bc6d8bc3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Which kernel version are you running?

Den s=C3=B6n 28 feb. 2021 kl 23:48 skrev Adolfo Rodrigues <
adolfotregosa@gmail.com>:

> Hi.
> I cannot find a way to enable 4K @ 120Hz over hdmi 2.1. It seams limited
> to HDMI 2.0b.. is it ?
>
> Under Windows 10 it works fine but not under linux. Why ?
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--0000000000008da25305bc6d8bc3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,he=
lvetica,sans-serif">Which kernel version are you running?<br></div></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Den s=C3=
=B6n 28 feb. 2021 kl 23:48 skrev Adolfo Rodrigues &lt;<a href=3D"mailto:ado=
lfotregosa@gmail.com">adolfotregosa@gmail.com</a>&gt;:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi.<div>I cannot fi=
nd a way to enable=C2=A04K @ 120Hz over hdmi 2.1. It seams limited to HDMI =
2.0b.. is it ?</div><div><br></div><div>Under Windows 10 it works fine but =
not under linux. Why ?</div><div><br></div><div><br></div></div>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a><br>
</blockquote></div>

--0000000000008da25305bc6d8bc3--

--===============1428852632==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1428852632==--
