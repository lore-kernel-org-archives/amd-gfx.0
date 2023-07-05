Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC150EB64DA
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jul 2023 12:18:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 786A310E2BF;
	Wed,  5 Jul 2023 12:18:26 +0000 (UTC)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 432C610E134;
 Wed,  5 Jul 2023 02:42:57 +0000 (UTC)
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-c17534f4c63so7093227276.0; 
 Tue, 04 Jul 2023 19:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688524975; x=1691116975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VHY1Zlzp65TvZiR0boe033bDVC9iew9qAHr8hQ5HK44=;
 b=F2Imx01R9giMZddzkh9uY1nNb0+Iuc4PkiDccdGrPfyLUl7NVGC8lgFKB/+tfss3cC
 hj16bHA7rNQDVS+JXJR0ogmbBovo39BVgjTlVJHERcysGqhHnaGme3x9FF7CRC8BsM0W
 urY5SuS7GrtXSTvV7u0Y8WbM8no91vJtMBkd2GA7lHXsZEC5tcLu/M8xYyycxx1dfIQI
 hVUf8jwxS6V8Vq63huiftkAy9VqIVAz5KGojBHASQwjS2DipyZEufGk1v8Zlx0A1dTjS
 coU1x9d1Hip4kCZ2xN4pFWBbyqdCwYYgOpJ20FVqVxvC2zT47RRdnOiVTja31dMkvucG
 ryhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688524975; x=1691116975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VHY1Zlzp65TvZiR0boe033bDVC9iew9qAHr8hQ5HK44=;
 b=Wuuczk/gv6AeGGRABzYrOKY/cUPtSLzp9MGK6A8I04WlZIPMZPrKOWqR4Oe8XsTEbG
 58XQCW9lz0OSLpGxfE4Ff/ClswsP6ScmI74bwekVt1qgKc0EugNZ+38iqoacDJkNmVww
 VTCNBHJtM+znlA4L9HT+KE2aSOAAFb7EdzHFwMlf31j2wRJwpX+w5i2Y+9MjxwHVLMy2
 QGi02EWUgwzNUbptnXb0kQbdtGaNGPocCxRXRwME02BLyB4CTUPPD0QQKvpURkFuW5Pu
 53ZQ5L4BDLuYPLkNC9sEkOzLaD/sx9uv1yEifBYf58+AQgx9VuYGS9sFjlDcqwvtXPVA
 81+A==
X-Gm-Message-State: ABy/qLbTmmmwaVxMTjse3zccd8/gW72ia9AeLsleq/0iKIXczG3bWSLF
 1bNT+VxtuWBjDvujKr/LqCR/4r/G5EwKQkln8/I=
X-Google-Smtp-Source: APBJJlGI035ANDpYcO9uphsvVgfUxzA6K5kAZKgF2yLnxC++mnV0T1omNsS+ILv5TNYf804MrYBTtJKbCtneNIysylQ=
X-Received: by 2002:a25:ac96:0:b0:c12:e809:69e7 with SMTP id
 x22-20020a25ac96000000b00c12e80969e7mr12557646ybi.65.1688524975402; Tue, 04
 Jul 2023 19:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230701020917.143394-1-andrealmeid@igalia.com>
 <20230701020917.143394-7-andrealmeid@igalia.com>
 <20230703113836.60869599@eldfell>
 <5bc889d4-bccc-9d6d-fe35-da3e9627eaa0@igalia.com>
In-Reply-To: <5bc889d4-bccc-9d6d-fe35-da3e9627eaa0@igalia.com>
From: James Braden olin <bradenolinjames@gmail.com>
Date: Tue, 4 Jul 2023 21:42:43 -0500
Message-ID: <CABCz0QONtWj7DHp6bdvQm=05XC=bvnUq3a9Wkee6n_mu9CJ73Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] drm/doc: Define KMS atomic state set
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Content-Type: multipart/alternative; boundary="0000000000005a744405ffb45bd7"
X-Mailman-Approved-At: Wed, 05 Jul 2023 12:18:24 +0000
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
Cc: pierre-eric.pelloux-prayer@amd.com, kernel-dev@igalia.com,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
 Dave Airlie <airlied@gmail.com>, Italo Nicola <italonicola@collabora.com>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, wayland-devel@lists.freedesktop.org,
 Pekka Paalanen <ppaalanen@gmail.com>, Rob Clark <robdclark@gmail.com>,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 alexander.deucher@amd.com, joshua@froggi.es,
 Daniel Stone <daniel@fooishbar.org>, hwentlan@amd.com,
 christian.koenig@amd.com, ville.syrjala@linux.intel.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--0000000000005a744405ffb45bd7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Simulator cannot be changed

To join the meeting on Google Meet, click this link:
https://meet.google.com/ccm-jjwz-ehk

Or open Meet and enter this code: ccm-jjwz-ehk

On Mon, Jul 3, 2023, 11:33 AM Andr=C3=A9 Almeida <andrealmeid@igalia.com> w=
rote:

>
>
> Em 03/07/2023 05:38, Pekka Paalanen escreveu:
> > On Fri, 30 Jun 2023 23:09:17 -0300
> > Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> >
> >> Specify how the atomic state is maintained between userspace and
> >> kernel, plus the special case for async flips.
> >>
> >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
>
> [...]
>
> >
> > If you want to take these and need my Sob, that would be
> > Signed-off-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> >
> >
>
> Thank you very much! Your version is way better than mine, I'll use it
> in my next version.
>
> > Thanks,
> > pq
>

--0000000000005a744405ffb45bd7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Simulator cannot be changed=C2=A0<br><br><div data-smartm=
ail=3D"gmail_signature">To join the meeting on Google Meet, click this link=
: <br><a href=3D"https://meet.google.com/ccm-jjwz-ehk">https://meet.google.=
com/ccm-jjwz-ehk</a> <br> <br>Or open Meet and enter this code: ccm-jjwz-eh=
k</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Mon, Jul 3, 2023, 11:33 AM Andr=C3=A9 Almeida &lt;<a href=3D"mail=
to:andrealmeid@igalia.com">andrealmeid@igalia.com</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex"><br>
<br>
Em 03/07/2023 05:38, Pekka Paalanen escreveu:<br>
&gt; On Fri, 30 Jun 2023 23:09:17 -0300<br>
&gt; Andr=C3=A9 Almeida &lt;<a href=3D"mailto:andrealmeid@igalia.com" targe=
t=3D"_blank" rel=3D"noreferrer">andrealmeid@igalia.com</a>&gt; wrote:<br>
&gt; <br>
&gt;&gt; Specify how the atomic state is maintained between userspace and<b=
r>
&gt;&gt; kernel, plus the special case for async flips.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Andr=C3=A9 Almeida &lt;<a href=3D"mailto:andrealmei=
d@igalia.com" target=3D"_blank" rel=3D"noreferrer">andrealmeid@igalia.com</=
a>&gt;<br>
<br>
[...]<br>
<br>
&gt; <br>
&gt; If you want to take these and need my Sob, that would be<br>
&gt; Signed-off-by: Pekka Paalanen &lt;<a href=3D"mailto:pekka.paalanen@col=
labora.com" target=3D"_blank" rel=3D"noreferrer">pekka.paalanen@collabora.c=
om</a>&gt;<br>
&gt; <br>
&gt; <br>
<br>
Thank you very much! Your version is way better than mine, I&#39;ll use it =
<br>
in my next version.<br>
<br>
&gt; Thanks,<br>
&gt; pq<br>
</blockquote></div>

--0000000000005a744405ffb45bd7--
