Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DB0D29C40
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jan 2026 16:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B66BC10E338;
	Mon, 19 Jan 2026 16:07:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RbyV4CSl";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68CAF10E4A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 16:07:47 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1233e05c77bso183196c88.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jan 2026 08:07:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768838867; cv=none;
 d=google.com; s=arc-20240605;
 b=iTdj4Q6ybU0MKsV2KOnqXZ1XRS51pyU9ytgy2xhS9qzvZzdhnDr7UZRx4lYM3PomX8
 qp/00+pxYcTrULkiULinhjXcUl+M9RmNykVOwNOCgGfe/hJo4+TcDkwar6Ab37+dixj4
 YblXn7SUK+94OkVeKCtt/8JtRnpmXxt2ZGUFoUQXRGK/qXnvOvEBCt2k/Wd5kcjrcsQs
 FRRgN16B/ufwdJGk09DdDsbeCxHWZHEv/mUNqzoikvjnypfHupuz7Thjy5z22Hu4BgJF
 JjqDeA0n3CqVVJulZHZ1TwSAYcn9Ln2dp4GWykMOQNjCLr4IsuSuhdH0OIG56m+B287v
 mjKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qbaj/fDRaiKGOljlG6RQUY1Wy+mpyX2rcVYCDkUh0n4=;
 fh=8AJQVp9Blf/6+0wqheef1+KkKuYzUmOHEA0ieDLovTA=;
 b=h/o7LtfLPj9yS2hEq7CyGLcxUcS0VTyd7ukTkoM/6CxPRpIMKPk3XWNCQqIvFygDZE
 ZHBW6Loiia0JIMPIvHg3OvKzOJ7qWnkllgF4ieu+xMqLsRkNHYSBMLts7TudLJmy6AKR
 gRAa6kr4CiOO2b+1/BM6TtVF4o6s80KT9S37bXSIwO7sup1f0SPWYFUxrqknNmFi4olX
 c3CzqtfGdA3FIpVQvG5osWdCzzyMF0Fds/B/ErsBLAonosdn72Bz7T0laz8+OlNRbYPo
 RTtUky9m9LHg+L1LgnBCk82WemdvwmMQw6ti9Y8/Cao2Ru0rjTlsDReES5rK8tF8KTxQ
 aAjQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768838867; x=1769443667; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qbaj/fDRaiKGOljlG6RQUY1Wy+mpyX2rcVYCDkUh0n4=;
 b=RbyV4CSllzaSKvMkrw8QU0/RESwv8UeKdCSokdnINjlDJXY3wrwUWDgAkf3mZhadVk
 N54WupFmlqZ/WWpFfid8HVTDLEY5uOnkKiLuazANGVSNLpcm/+3g0mwbtQ+2uQbKTh9J
 SLugKcCDgTObxNVsku0k/RNowhq9WxyTZzh0tNpo2ZcMiLTRcibd0RlXw5cYfO6Wf/sg
 goDZ1wj4QG27jZHfk32yQaRIqgg2e6yURwEY46fdgEO92mtD8oBB/pQla2Q5vFoKbOiQ
 lhdEx0XmCk5xxqv3LyE3YZ3Olx7Cwm2gIvIH4yg0IHEZWJ+WKgNUXZ6rCgzWXgD/pnBq
 Klhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768838867; x=1769443667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qbaj/fDRaiKGOljlG6RQUY1Wy+mpyX2rcVYCDkUh0n4=;
 b=spT3+dYwZWLLeRcwf7TTDSAbt0IVMKvwkdHnhxFPcMuv6BT2ntoP9vMte7j4OvIfZT
 89bClOMubida0VaX8RiXLrkWeSJ+bQWNm4QrXomBfmKyCuWve7MyPdG6GEY7e3GtTC0d
 gBNjjI3TU29+BpuvJpwDLH3el3Mn2EjxxzyJ+p1zeYhXyTprqYgg0JlK5oiTmZZ7wg/v
 JwUpCchRpCXLDDt/g8N7Co4fwLFjTlK9wJENq+G0pq8BFffRmH4N58thRysOaJT7HJUI
 gMlyy2ddMUccCPDWFn/n0i0YOS413FDWpjx7yyEdU9nOXRoLYK5cef4igjyE7jDiTZkT
 k/kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG9f8QFcktWnGk1Jc1GRmb0yrNzyDr5k+0XZDGDam31LSp6dQiKARLAXqiqyYbH7U7KgdhaSUt@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyO7i/ZWEak+vavPCMqxu+udV6HR/87yGUhIHOS41/EssrMVWT
 DlgMUJBDJlsrHecBWMzcBWhGbCZ3+YIExaZAjm+KZyW2D+MYw5NnkreRnB1fnaoOawZuLUHXiiI
 m3uAmQbJk6vMEkc6DNq+H6NXgHvYwG5g=
X-Gm-Gg: AY/fxX5Tba+8JCakE9fms17udjg5VRQa4oILZ9kWEKiANM7Gxr8D94GYXyS4YUGiCQW
 jv693/QlxgoTofPHEv5t+ipQX+adNTNwmOeiMpdeaRWkRrPeR7YNrZzTUBmwwJJap8N5tt7557c
 Gi5Soq4zin7N39KdvDDcrG5dCNgaHicx8/hc5EcxjgNys5kaPdjv+d7aac9ayivhZ2U4Fj2TmS3
 +KRnKTmBYpnGo/bI8z+jThtRkNuieu4pnYkOgRkb4Pn1djK2iAUTX46Clr5kl3d6kKcgb0J
X-Received: by 2002:a05:7023:a8e:b0:119:e55a:95a3 with SMTP id
 a92af1059eb24-1244a7a2266mr4526044c88.5.1768838866559; Mon, 19 Jan 2026
 08:07:46 -0800 (PST)
MIME-Version: 1.0
References: <97A9D651052AA8A7+20260119084403.1420962-1-liurunrun@uniontech.com>
In-Reply-To: <97A9D651052AA8A7+20260119084403.1420962-1-liurunrun@uniontech.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Jan 2026 11:07:34 -0500
X-Gm-Features: AZwV_QiaSJACqBg91UrPZBLMVc4s2iWPeLAMoh73ofm6h_RDkP4qnw_boTeip8A
Message-ID: <CADnq5_Nd1ok+fZUadHC6ukreUAJB-XE3NxUg29t8zfi3VXhb5A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix misspelling of "minimum" in dc_dsc.c
To: Runrun Liu <liurunrun@uniontech.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 zhanjun@uniontech.com, niecheng1@uniontech.com, kernel@uniontech.com, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

Alex

On Mon, Jan 19, 2026 at 8:57=E2=80=AFAM Runrun Liu <liurunrun@uniontech.com=
> wrote:
>
> Fix the typo "miniumum" =E2=86=92 "minimum" in a comment in dc_dsc.c.
>
> This typo is already listed in scripts/spelling.txt by commit
> 8c3200265787 ("scripts/spelling.txt: add several more common spelling
> mistakes").
>
> Suggested-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> Signed-off-by: Runrun Liu <liurunrun@uniontech.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/dr=
m/amd/display/dc/dsc/dc_dsc.c
> index e4144b244332..5b3584ad5b6b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> @@ -1157,7 +1157,7 @@ static bool setup_dsc_config(
>         if (!is_dsc_possible)
>                 goto done;
>
> -       /* increase miniumum slice count to meet sink slice width limitat=
ions */
> +       /* increase minimum slice count to meet sink slice width limitati=
ons */
>         min_slices_h =3D dc_fixpt_ceil(dc_fixpt_max(
>                         dc_fixpt_div_int(dc_fixpt_from_int(pic_width), ds=
c_common_caps.max_slice_width), // sink min
>                         dc_fixpt_from_int(min_slices_h))); // source min
> --
> 2.51.0
>
