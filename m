Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA67CAC598
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Sep 2025 21:45:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5903F10E368;
	Mon, 15 Sep 2025 21:45:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X8jnO/rc";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C44A210E368
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 21:45:30 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-260f41a85f3so4815425ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Sep 2025 14:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757972730; x=1758577530; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hgjQuP4Me3guJDVcSDtwLqdLj9Ad4VyHioffhsnvnuU=;
 b=X8jnO/rcUhn3kXQMJ9+aC9/S7Xm1xLTnZ6p2lMTn68wS6Da8tXzJvtMBXaajJhGt6Q
 AhpEM8GdCdU2STq5Q3VHNBoKl/3XtYqngzfUph4rylBRfU6eUOxtPb6LAAbQmvxIIf2B
 VW1nne2boKG6Fw8RXsi+WC/0gsg76/vUfcWYJUJ8CuY1HxWxw0GCrC1N861BTIBVon23
 mcxeMGk9woaA9ZUKEf17x5LSly5AC8+7mdBMlm1hBnUdgTDzfQvdKHRHj8W46eUn/u0h
 h8fj0nutPPppnBEVfNkGEm7gl681U5Djd+XJ5BgXNc5Wtegd0jghzWWV3JCk76OE9u0D
 5v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757972730; x=1758577530;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hgjQuP4Me3guJDVcSDtwLqdLj9Ad4VyHioffhsnvnuU=;
 b=T83BBlQ/KeSHIZTclqqVSPsjMlJmRkq5dIcGez63sWz+clkBT+dcvYOqkKaeFBe01K
 nl4WzsuYvdo9NwLR4pObGwuKu0H+nPoWc9+jw0PWb7vP8JRa6DgjMdLnZV+Uc416+G5+
 Ab7ow+YLYO+UdOy58SoPQEQVb7a6VYozDwqsY6xwAJGHOsztuMc1wyGRrrw2g3I0+u4z
 lmZ5yJ9qcLVuZ/kkjfdjiBJ6M+/wfT1ipuz6eCkrTAuQQ5+PorYW8cj29fxDJrDKyd19
 GWkVXPcOOr0QAc3+UR/clju1OaWERas6J+aUGq2HAk++/Bz2KVhpRXN0s8kqPZAEZPHo
 plsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcCcIWS4XOWZuNGA0e/nzTRVNGkpeL2UQbxcr1VOAAff9SrRk6Kgj8hN3qe0BX5qN3a1Z8nEEU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwofP35mMjt97IONOwD2GU+bCGkBwDbw+Lm4wIWQEkUvEssgkkv
 e8ysWfrVBUuJ22ObJ9VqsNwDJA5u5UJkKhaaA66TNIb1SF8lRhGiiZsb3TKb/JJS7lQMecVErlt
 Me31yXttPwSIZYcpkAHIYmVQGkGaO3DA=
X-Gm-Gg: ASbGncuzKylKNHuRDLt5BtOcx1Ze9+w9j57CqY8IyUvISjAiJnHlso9WRBru4mrDDUa
 0C38gvmaQQpypjrxjDXZXYGIbdedkSS4iMt3hX4l8WU1QB3LRS4n9KXvQHz7+P62z0gwiWUcrzx
 +tcC1Vz6hcRVB3Oskzc2Mi8uK7yhjwVuqtxR2ETiBnrBAH5NJs4pCRZbn4Fv+lpThEQ9wO3iEAp
 0iADmZ4Oo0avcu59w==
X-Google-Smtp-Source: AGHT+IHw3Z18XHstUu2o5MDyyGsJMQUZc09lyWpgCR+3iBlFcxOGkW7iUUBCOCFrQn0WS7ZaeI8Iju8q0S+OmEonvrg=
X-Received: by 2002:a17:903:1a8b:b0:25a:4437:dbb7 with SMTP id
 d9443c01a7336-25d25e85badmr85747195ad.4.1757972730212; Mon, 15 Sep 2025
 14:45:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250913052109.2638-1-bold.zone2373@fastmail.com>
In-Reply-To: <20250913052109.2638-1-bold.zone2373@fastmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Sep 2025 17:45:18 -0400
X-Gm-Features: Ac12FXyeEWmkZqa6wbMn8t2Wun6mfw4KJJSTBJD8vx8rr6MmHrmXg4LFyNCd8yc
Message-ID: <CADnq5_N9r+hyu6ARUGeYnsSPNNBM-bq0YV5mQoH6vp2yXdXZhg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use kmalloc_array() instead of kmalloc()
To: James Flowers <bold.zone2373@fastmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, roman.li@amd.com, alvin.lee2@amd.com, 
 skhan@linuxfoundation.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-kernel-mentees@lists.linux.dev
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

On Sat, Sep 13, 2025 at 1:31=E2=80=AFAM James Flowers
<bold.zone2373@fastmail.com> wrote:
>
> Documentation/process/deprecated.rst recommends against the use of kmallo=
c
> with dynamic size calculations due to the risk of overflow and smaller
> allocation being made than the caller was expecting. This could lead to
> buffer overflow in code similar to the memcpy in
> amdgpu_dm_plane_add_modifier().
>
> Signed-off-by: James Flowers <bold.zone2373@fastmail.com>
> ---
> I see that in amdgpu_dm_plane_get_plane_modifiers, capacity is initialize=
d to
> only 128, but it is probably preferable to refactor.
>
> Tested on a Steam Deck OLED with no apparent regressions using these test=
 suites from
> igt-gpu-tools:
> 1) kms_plane
> 2) amd_plane
> 3) amd_fuzzing
> 4) testdisplay
>
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/dr=
ivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index b7c6e8d13435..b587d2033f0b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -146,7 +146,7 @@ static void amdgpu_dm_plane_add_modifier(uint64_t **m=
ods, uint64_t *size, uint64
>
>         if (*cap - *size < 1) {
>                 uint64_t new_cap =3D *cap * 2;
> -               uint64_t *new_mods =3D kmalloc(new_cap * sizeof(uint64_t)=
, GFP_KERNEL);
> +               uint64_t *new_mods =3D kmalloc_array(new_cap, sizeof(uint=
64_t), GFP_KERNEL);
>
>                 if (!new_mods) {
>                         kfree(*mods);
> @@ -732,7 +732,7 @@ static int amdgpu_dm_plane_get_plane_modifiers(struct=
 amdgpu_device *adev, unsig
>         if (adev->family < AMDGPU_FAMILY_AI)
>                 return 0;
>
> -       *mods =3D kmalloc(capacity * sizeof(uint64_t), GFP_KERNEL);
> +       *mods =3D kmalloc_array(capacity, sizeof(uint64_t), GFP_KERNEL);
>
>         if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
>                 amdgpu_dm_plane_add_modifier(mods, &size, &capacity, DRM_=
FORMAT_MOD_LINEAR);
> --
> 2.51.0
>
