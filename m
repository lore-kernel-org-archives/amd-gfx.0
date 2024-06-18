Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE4CC2BA1A
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jun 2024 10:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 120A710E10B;
	Tue, 18 Jun 2024 10:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b1Opb+E4";
	dkim-atps=neutral
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com
 [209.85.219.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E663110E618
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 10:07:45 +0000 (UTC)
Received: by mail-yb1-f180.google.com with SMTP id
 3f1490d57ef6-e0272692096so478117276.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jun 2024 03:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718705265; x=1719310065; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCx7fOAnUmTX/Xe4ctYyfLYc6JY69uTQO3mrnLIZgkE=;
 b=b1Opb+E4Vu4Y4JgedY8yk3C7uuGBpuruiw4gS55pkz/n+JOpTE29XlBNM2Apn6RW42
 zQqn9YIi2o9BRp4YisEkcrFQ2NGY/ruEQcPb8rdEWL2N79BF72ban/YduAmkerloUH7A
 82JSAOk2s79HlClSolE8zI1KAP0n1qtQwaBH0f58LghjUjTzc3IsO3KgA1v2UTVaxWWR
 hlup8ejy6Vxb5KxpzrlLj8M3ih9wayiXPywXOQAAxez8bYyxeDQB6xN4Kqo+f+pYnCOW
 NQ0nmMdLO2otnQPvl/i88ya4U9UR0ESf+3oA0Bijx3AtDm2+oRfLj70Mn5KhckLMgvxU
 DMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718705265; x=1719310065;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCx7fOAnUmTX/Xe4ctYyfLYc6JY69uTQO3mrnLIZgkE=;
 b=Mvpp2hMziN8RKoB9AJwRBQxAe7X1OO+W0fdmxiU0EjJz3Ko/AFzPCe0H6bd30T6CAm
 5MggAB2rZ7hSuw9KW1bxS1NYUAuFisfn+TANTTgRQGnn99ftihkQ0xa0A+lGDVGbpNr9
 TXJE89MuApTCUN0AtaVfmYsnDNCnAzjNRYRMYzjPCbPo8GoThVbV9a21mAMOlhqnvnhh
 tLtlsvO6c5z8WQqwSQ6CgbKzUik+ruJuwUa2j9qTH8pl/dpRHUIuNv/xZjxmVFraRw8T
 MYXbltJ2yH3u8Pml0zA9K8z46fx95qLbeUQgwGTLtjYz21J+FX7PcOkcq2CSAwb09rQW
 Z8CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjCkmV48wz9nuFBKyzm4uwysxBNcJX3j2y1JVNXEAe9yrlW1QubE97cAyZEPNHUQQiTcByBw1jANcZ6wAevJKHr+Ux987ChEKYxYiIOA==
X-Gm-Message-State: AOJu0YwjZPHKCyPlRaGmn6RQ8Qm0gTgfn5liolqsg6sZEanMi9gAFWGD
 6r8xdSseblOLtnJb2khqoR8fN6V0Y9dRUDwtIUIr46N7XtE4yXUKZL7tnVOURwP0XrQE0ggFg/+
 RkjhHUuXqwYvL6Q2afeJrBwFywkFJwD9jeta5tA==
X-Google-Smtp-Source: AGHT+IFJ0kiksoEZDocVzYOcTdne8U7N6C+jsZexpeus6Jap6pxdsUb8A3nFZ7pup6bdeGO4XrwkK9/1Lawl6Ll+PGk=
X-Received: by 2002:a25:abe1:0:b0:de4:828:b73c with SMTP id
 3f1490d57ef6-dff154d21d2mr9969203276.54.1718705264631; Tue, 18 Jun 2024
 03:07:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240618030024.500532-1-andrealmeid@igalia.com>
 <20240618030024.500532-3-andrealmeid@igalia.com> <878qz2h9pp.fsf@intel.com>
In-Reply-To: <878qz2h9pp.fsf@intel.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 18 Jun 2024 13:07:33 +0300
Message-ID: <CAA8EJpqM4iaG3PKM5c0Op7Y7c1SRDrOCk_oOnwG8YfdCxC8w6g@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] drm: Support per-plane async flip configuration
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com, Melissa Wen <mwen@igalia.com>, alexander.deucher@amd.com,
 christian.koenig@amd.com, Simon Ser <contact@emersion.fr>, 
 Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
 Daniel Stone <daniel@fooishbar.org>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Dave Airlie <airlied@gmail.com>, ville.syrjala@linux.intel.com, 
 Xaver Hugl <xaver.hugl@gmail.com>, Joshua Ashton <joshua@froggi.es>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Sam Ravnborg <sam@ravnborg.org>, Boris Brezillon <bbrezillon@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Karol Herbst <kherbst@redhat.com>, 
 Lyude Paul <lyude@redhat.com>
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

On Tue, 18 Jun 2024 at 12:38, Jani Nikula <jani.nikula@linux.intel.com> wro=
te:
>
> On Tue, 18 Jun 2024, Andr=C3=A9 Almeida <andrealmeid@igalia.com> wrote:
> > Drivers have different capabilities on what plane types they can or
> > cannot perform async flips. Create a plane::async_flip field so each
> > driver can choose which planes they allow doing async flips.
> >
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> >  include/drm/drm_plane.h | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/include/drm/drm_plane.h b/include/drm/drm_plane.h
> > index 9507542121fa..0bebc72af5c3 100644
> > --- a/include/drm/drm_plane.h
> > +++ b/include/drm/drm_plane.h
> > @@ -786,6 +786,11 @@ struct drm_plane {
> >        * @kmsg_panic: Used to register a panic notifier for this plane
> >        */
> >       struct kmsg_dumper kmsg_panic;
> > +
> > +     /**
> > +      * @async_flip: indicates if a plane can do async flips
> > +      */
>
> When is it okay to set or change the value of this member?
>
> If you don't document it, people will find creative uses for this.

Maybe it's better to have a callback instead of a static field? This
way it becomes clear that it's only relevant at the time of the
atomic_check().

> > +     bool async_flip;
> >  };
> >
> >  #define obj_to_plane(x) container_of(x, struct drm_plane, base)
>
> --
> Jani Nikula, Intel



--=20
With best wishes
Dmitry
