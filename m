Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44736C433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D30619BD
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 13:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D30619BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 023C26E8EA;
	Tue, 30 Mar 2021 13:24:41 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E98086E883
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 09:07:52 +0000 (UTC)
Received: by mail-lf1-x133.google.com with SMTP id o126so22737204lfa.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 02:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A0U2Z9rQ2O4A+FKmyq8e7StGMrORBfwuhVEPPZCsRTU=;
 b=kaSm6PguyCQm0ShTHIpHbuTFr52ax4Ne1rD3HXfImclA9FFijkXeLYmx8HibjX7JjN
 XYgK0md4szgnLAG8q+GXZYB3kYwcyOh+eMFMtYXd19dN8sB/arFpta9BxXC+WpOFs1O8
 l83plwYIbMT9YHXhijLdn6ZPw+0Lk5ZLx/gaSqALZblZB3LSIAlnW+o6fgnYodrDCxHF
 mOnK8VdEo/bmUmrtINaKdRcRgqeLD2NZrwfibg9V6ajxeaorDZLmZXZr7/iW4s0XRhUG
 sgjMvRquD5riT5aMMOBYyEnVLEfggY/la98eaZZ2KTPD1DsmVnvqnU5D6m6sXH0Je1el
 IJ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A0U2Z9rQ2O4A+FKmyq8e7StGMrORBfwuhVEPPZCsRTU=;
 b=Ng4AbkxFklXKdePMg+ScjEB2uAvRrQvp3+F9UhvLfr712LDHt1Zu12EEg3H3GCpNrA
 Z0hJXidWxFQKUG1r0fQwdGK5aVPxeXfuVb2SYYjwx6BKpatOaIIt55Gk18NUhO6Ic0nC
 qxGhWnLpNa0hy+2ArDNqmMn9AhrgZYLJ5ZP65MgYD9/ktzCG28YZBYhwYkHYFAeMEYqi
 eKvJf/Elj8LQu2N1ilv9AfueHy7+LhB3836KjCTIzN8kN0uanp0+1/hKjLfJ/SLR5UWW
 zhlK2RvTCTprM8xlEZchZe/xUHSxaslb4yHCYKXql6FgjLjxkL1SsHhThb1e++lvGgni
 30OQ==
X-Gm-Message-State: AOAM531I6Uwqy85ScnKE5+FiGjoj+sIr8xANeblIfiPtq3+k5sqt4U96
 j5u3rbfn9dFGB+1zOccMN9Spj38tFr3+M4jEariilpkIXHTvPw==
X-Google-Smtp-Source: ABdhPJzUsVggCUk0hFzd5aBjMufyki2oJ6OrU2L0+qUGzgwCILfQ905D34XapS7MTOarUt/ZJG1rAAvq1FsO03lATSQ=
X-Received: by 2002:a05:6512:94d:: with SMTP id
 u13mr17659954lft.368.1617095271434; 
 Tue, 30 Mar 2021 02:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAHJvkbsexf7kM-11ZdrM+pHUUyvttB8fyJMfcsQAC1233jp8LA@mail.gmail.com>
 <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
In-Reply-To: <388b2a9d-0e63-b70f-28ed-6297a524fb76@amd.com>
From: Alberto Salvia Novella <es20490446e@gmail.com>
Date: Tue, 30 Mar 2021 11:07:40 +0200
Message-ID: <CAHJvkbuu5WB=QTu0EUgSGcoK6KMbP2j8NA0o+XTdtkwadNpsxg@mail.gmail.com>
Subject: Re: Interlaced resolutions hang the desktop
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
X-Mailman-Approved-At: Tue, 30 Mar 2021 13:24:40 +0000
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
Cc: alexander.deucher@amd.com, benh@kernel.crashing.org,
 linux-fbdev@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1027779371=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1027779371==
Content-Type: multipart/alternative; boundary="00000000000038d0f805bebd55db"

--00000000000038d0f805bebd55db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I guessed so.

The GPU is a Radeon HD5870, and the screen is an old Telefunken TV
(TLFK22LEDPVR1).

Since my real display got into repair I used this TV meanwhile, and to my
surprise it froze the system.

On Tue, 30 Mar 2021 at 10:15, Christian K=C3=B6nig <christian.koenig@amd.co=
m>
wrote:

> Hi Alberto,
>
> well what hardware do you have?
>
> Interlaced resolutions are not used any more on modern hardware, so they
> are not well tested.
>
> Regards,
> Christian.
>
> Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:
> > The entire desktop hangs after some minutes when using the module
> > "radeon" with an interlaced resolution.
> >
> > Easier to trigger by playing a video on Firefox, at least on kwin_x11.
> > Wayland didn't exhibit the problem.
> >
> > Other display drivers, from different computers I have tried, didn't
> > allow those interlaced resolutions all together. It seems they know
> > there will be problems.
>
>

--00000000000038d0f805bebd55db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I guessed so.</div><div><br></div><div>The GPU is a R=
adeon HD5870, and the screen is an old Telefunken TV (TLFK22LEDPVR1).</div>=
<div><br></div><div>Since my real display got into repair I used this TV me=
anwhile, and to my surprise it froze the system.<br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 30 Mar 20=
21 at 10:15, Christian K=C3=B6nig &lt;<a href=3D"mailto:christian.koenig@am=
d.com">christian.koenig@amd.com</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi Alberto,<br>
<br>
well what hardware do you have?<br>
<br>
Interlaced resolutions are not used any more on modern hardware, so they <b=
r>
are not well tested.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 30.03.21 um 10:04 schrieb Alberto Salvia Novella:<br>
&gt; The entire desktop hangs after some minutes when using the module <br>
&gt; &quot;radeon&quot; with an interlaced resolution.<br>
&gt;<br>
&gt; Easier to trigger by playing a video on Firefox, at least on kwin_x11.=
 <br>
&gt; Wayland didn&#39;t exhibit the problem.<br>
&gt;<br>
&gt; Other display drivers, from different computers I have tried, didn&#39=
;t <br>
&gt; allow those interlaced resolutions all together. It seems they know <b=
r>
&gt; there will be problems.<br>
<br>
</blockquote></div>

--00000000000038d0f805bebd55db--

--===============1027779371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1027779371==--
