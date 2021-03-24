Return-Path: <SRS0=J6fF=IW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF492C433E2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 15:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FD2761A06
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Mar 2021 15:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FD2761A06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 471866EC64;
	Wed, 24 Mar 2021 15:25:32 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37CEC6EC54
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 15:25:30 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id g20so13123568wmk.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Mar 2021 08:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=38XNAPAOtkSkDub8Za/ZC9xfQoP9/8c9e+Q5QlscP/8=;
 b=KvE2KNqC2oVZztYTGjx3aQERdJ08vE8iyMLxhQxCv02mEEStzFkAiHxyUI4g+adCCh
 omb6hePHhsBnLbuqkFXMzYyxEsw3xn/t/nnR10mUiMotu4jxBsMXMIgR0I94/2SU8nXH
 s6WzYLqmic/ecuOV0nuSM7zjiuBWaaSoDqn6Yj9gxTpzn+705xd18WZsokk6zfiq9k0M
 koh9hDbU8UoP6TSe/fKceFlKIw+Y3dUvVdTV9w4mz9tJ2jFZCjawzNsbVx8NaeWfw/0g
 MtC/j6HFi8rlwwNenw7CLaCB1TJcPskV1VN8G9snomnpGcH3RnH7GEuwGqI0DShjg4Fc
 0AUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=38XNAPAOtkSkDub8Za/ZC9xfQoP9/8c9e+Q5QlscP/8=;
 b=KKFS2jCkX6Ghsa3/uEN3mOAEI6fAQy8xniu3XWDz7liBE9wNrktCsgsFAs1Ofa6kj3
 NKFws3jDWybCuZiNqA1TkGkd0fmYIhfRIREZdZJUqk5X7lBusn9IOdVf6t/sG4IsqpHl
 j6yT6OXaC35aIS3L4wYyeATXUT7elAdaRpdI9dZeAi0LLoeSxgoPf/q5nMku5TgMha98
 PKJbUERD+UKk1g81tAS/Gat1l1mK+xAq9WeByeLbacFqrOjygH94Wo554hyYuDNjVRin
 KOEyoxJh5w6tAPrtPlh9GFueYijgYoRWHTibMK6BBT7DGoIQovP0cqZnd2/G4EM3TILj
 4+5Q==
X-Gm-Message-State: AOAM532OL+rEX3ClTT7zml6SMJX/nC8enWyvaJHHdyr/j5Nm97NyrLM3
 nMiU0OlWFVDrdrFwHM1irSkRdU2E7KqORTFb6JHNmA==
X-Google-Smtp-Source: ABdhPJzoolMahZmBdLfU/dhyVUVupB+MiFH3y+ebygFNeE31+7fpUNu7+kLQSo6yEf8vtfNKqu9LHExiEP9ZZfjNjJk=
X-Received: by 2002:a05:600c:2946:: with SMTP id
 n6mr3469952wmd.52.1616599528721; 
 Wed, 24 Mar 2021 08:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210310161444.1015500-1-markyacoub@chromium.org>
 <CADnq5_P9aYcedOP2qduSz7VN1fCSnmQEtPa+FdjYu9Co7TwPog@mail.gmail.com>
 <CAC0gqY7Y2WxtAZ3GnWmASPYq7ahYTfmPhOHAAX5UjMNS9k098w@mail.gmail.com>
 <b4070483-5aa5-c712-6435-dcb4a206ca76@daenzer.net>
 <CAP+8YyExtmmZbFfAO_YR=XWHE+HbH6m7JqyJV4LB_hbGwsihBA@mail.gmail.com>
 <CAPj87rP+WkUPbS3yyGGfy0SRm_hsnCCUav99Dg2Q+tXCiJ5D+A@mail.gmail.com>
 <CAJUqKUqQ0yrxpr+QVRXYXMk1hBRNByD0TP6mM0oLY54jDZimbw@mail.gmail.com>
In-Reply-To: <CAJUqKUqQ0yrxpr+QVRXYXMk1hBRNByD0TP6mM0oLY54jDZimbw@mail.gmail.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 24 Mar 2021 15:25:03 +0000
Message-ID: <CAPj87rMGcha9jGe3rRH8OvMxYSo42z1d0ZCxhRUxz+aAXMow2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Ensure that the modifier requested is
 supported by plane.
To: Mark Yacoub <markyacoub@chromium.org>
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
Cc: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Mark Yacoub <markyacoub@google.com>
Content-Type: multipart/mixed; boundary="===============0472619537=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0472619537==
Content-Type: multipart/alternative; boundary="000000000000a7684705be49e8d9"

--000000000000a7684705be49e8d9
Content-Type: text/plain; charset="UTF-8"

Hi Mark,

On Wed, 24 Mar 2021 at 14:58, Mark Yacoub <markyacoub@chromium.org> wrote:

> So you mean it would make more sense to be more explicit in handling
> DRM_FORMAT_MOD_INVALID as an incoming modifier (which will, just like
> DRM_FORMAT_MOD_LINEAR, will return true in
> dm_plane_format_mod_supported)?
>

That's correct. Not passing any modifiers is the same as explicitly passing
INVALID, both of which mean 'the driver will figure it out somehow'; that
driver-specific determination is not the same as explicit LINEAR.

(I cannot regret enough that INVALID is not 0.)

Cheers,
Daniel

--000000000000a7684705be49e8d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Mark,</div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Wed, 24 Mar 2021 at 14:58, Mark Yacoub &lt=
;<a href=3D"mailto:markyacoub@chromium.org">markyacoub@chromium.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">So you m=
ean it would make more sense to be more explicit in handling<br>
DRM_FORMAT_MOD_INVALID as an incoming modifier (which will, just like<br>
DRM_FORMAT_MOD_LINEAR, will return true in<br>
dm_plane_format_mod_supported)?<br></blockquote><div><br></div><div>That&#3=
9;s correct. Not passing any modifiers is the same as explicitly passing IN=
VALID, both of which mean &#39;the driver will figure it out somehow&#39;; =
that driver-specific determination is not the same as explicit LINEAR.</div=
><div><br></div><div>(I cannot regret enough that INVALID is not 0.)</div><=
div><br></div><div>Cheers,</div><div>Daniel</div></div></div>

--000000000000a7684705be49e8d9--

--===============0472619537==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0472619537==--
