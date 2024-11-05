Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8C6D1267F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 10:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FEA910E123;
	Tue,  5 Nov 2024 10:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="shgka0iH";
	dkim-atps=neutral
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com
 [209.85.128.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D32E110E558
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 10:51:23 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id
 00721157ae682-6e5b7cd1ef5so44539057b3.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Nov 2024 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730803883; x=1731408683; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wFnUnciKF2xxhdw0g9UlvzkYqa9uqspkupSHos0NsU=;
 b=shgka0iHIdk1NVQ+U8317hQjo11PtPZsPdq74HyJzaFjB7K16BoM6mVZ0+26gLG5aX
 Zy/7aacEMMy8EGJxrv0QrYXjZt1dfldU6ozcw2FwOM6EpzmNM19xXgxxg7oNbCmZUvkY
 7iRIRcKzTRHiYcEyBOmBLL26H6mijfx+ZzpLCoPu/kLCsRcKRE2m0dlqYxiwolPfSWzH
 bw/pqga/1TclbpQRSs5+AP4r2XAYpGgi2sc+P5aRJDTQy2OtvcJaKKI+3tVUK67axTd6
 CK5TgRSFbxlozjoHn3WWIE3op/9q9I2G6Lch/+iEdzqJziyEfrahFnv19JpDcMqre8wc
 aAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730803883; x=1731408683;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wFnUnciKF2xxhdw0g9UlvzkYqa9uqspkupSHos0NsU=;
 b=NSyVsDxEKv/K53ortiJNl8VyuL3s6n3VmKlLuF0s6TU/PdMKT+f11gyCh85cKBFfkJ
 dFqJbltD56kxIGwciSlOjxx7VQxuYcpl9bYxMsBDSmtWryM9WnKkzZl9PAKOiYM9mbYh
 4i1129knFiZpmUTdYOg0iyzDmb5OO7IdtQknceYMIjQWzE8vZg79O6IM/LfCSHtHZ5S0
 zBNL/XPkWLrEOpRZZoqhbQn+RTGZzm4lq7Asx0smHZ1VX5sT4mCwHHMiQRpMhpLKHCHh
 icmKcneMP/qMai0TH+Z4jhiGFItVX7acAD6o3DcDc93B5ybB/1+9AeuTqPksZMf5s/mS
 cwqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFZoiKm6+Tj8OPzQKXq/1n/zo9qOTKFeMbJjNJv2kq0cZOYZ1W5w7TklABzhs/6/mhENU1U9fg@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz4OAFDVGw07FVOSmCLGyGOO5tynZ3vVnrvQF2x+BCqi3rurwbF
 olAeSW29w/hXgd1VQaMc2afcd1+ALRLnr3JaMMUQOM3pRDpegxEH5hmxUCeaLiRprkYUu7YQiHD
 hi7ILY+WRczPEZ38BjjuJkczH2SVfHJ6j9yllXA==
X-Google-Smtp-Source: AGHT+IHQFSqhKmwFB8KvMA0OA0g7K5yjBP9Ct2aeaH6/E5BqOA7hhimk5zgheZN6yBg6rUs9bzLqJRTFRGU/Y2suREU=
X-Received: by 2002:a05:690c:dc7:b0:6e7:d974:8d05 with SMTP id
 00721157ae682-6e9d88cf98bmr365969057b3.4.1730803882742; Tue, 05 Nov 2024
 02:51:22 -0800 (PST)
MIME-Version: 1.0
References: <20241101-tonyk-async_flip-v9-0-681814efbfbe@igalia.com>
 <20241101-tonyk-async_flip-v9-1-681814efbfbe@igalia.com>
 <D5CC3U00B7CG.IGKCIES8PC2J@kode54.net>
 <00a99b3e-3fad-42fb-8dc8-4f45d158c4c1@igalia.com>
 <D5E5ZXW1K0A7.1VT1XCR1HIEST@kode54.net>
In-Reply-To: <D5E5ZXW1K0A7.1VT1XCR1HIEST@kode54.net>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 5 Nov 2024 10:51:11 +0000
Message-ID: <CAA8EJpoEEo5tB00Yqoi7V2U=pRud1W44W3V8bJnr3N468EhQOw@mail.gmail.com>
Subject: Re: [PATCH RESEND v9 1/2] drm/atomic: Let drivers decide which planes
 to async flip
To: Christopher Snowhill <chris@kode54.net>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 kernel-dev@igalia.com, Simon Ser <contact@emersion.fr>, 
 Thomas Zimmermann <tzimmermann@suse.de>, joshua@froggi.es,
 ville.syrjala@linux.intel.com, 
 Daniel Stone <daniel@fooishbar.org>, Xaver Hugl <xaver.hugl@gmail.com>, 
 Harry Wentland <harry.wentland@amd.com>, Simona Vetter <simona@ffwll.ch>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>
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

On Tue, 5 Nov 2024 at 10:15, Christopher Snowhill <chris@kode54.net> wrote:
>
> On Mon Nov 4, 2024 at 12:52 PM PST, Andr=C3=A9 Almeida wrote:
> > Hi Christopher,
> >
> > Em 03/11/2024 03:36, Christopher Snowhill escreveu:
> > > On Fri Nov 1, 2024 at 11:23 AM PDT, Andr=C3=A9 Almeida wrote:
> > >> Currently, DRM atomic uAPI allows only primary planes to be flipped
> > >> asynchronously. However, each driver might be able to perform async
> > >> flips in other different plane types. To enable drivers to set their=
 own
> > >> restrictions on which type of plane they can or cannot flip, use the
> > >> existing atomic_async_check() from struct drm_plane_helper_funcs to
> > >> enhance this flexibility, thus allowing different plane types to be =
able
> > >> to do async flips as well.
> > >>
> > >> In order to prevent regressions and such, we keep the current policy=
: we
> > >> skip the driver check for the primary plane, because it is always
> > >> allowed to do async flips on it.
> > >>
> > >> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > >
> > > Should I do a R-b too?
> >
> > If you can review the code, it's always really appreciated.
>
> I mean, I did review your changes, they looked good to me. I just didn't
> know the protocol for reporting review in addition to testing.

Please respond with the R-B tag. Also ideally the Tested-by should
contain the reference to a platform which was used to test it.

>
> >
> > > The changes looked sound enough for me to feel
> > > like testing it as well. Tested Borderlands Game of the Year Enhanced=
 on
> > > my RX 7700 XT at maximum settings at 1080p165, and the tearing suppor=
t in
> > > labwc allowed it to reach over 700fps. No problems from the hardware
> > > cursor.
> >
> > Thanks for testing and reporting!
> >
> > >
> > > Tested-by: Christopher Snowhill <chris@kode54.net>
> > >
>


--=20
With best wishes
Dmitry
