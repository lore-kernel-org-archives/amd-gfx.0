Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90341094462
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4F410E2B0;
	Sat, 21 Mar 2026 09:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aR8GJdfQ";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F92110EBAC
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 17:48:31 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-64ad79dfb7cso2910797d50.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 10:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028910; cv=none;
 d=google.com; s=arc-20240605;
 b=EFnYSm+QXmfN+bVSLD7uLydrcoMC+fQUpbx5c5BcpLpcNpWybYw/sBxC/NfoxFn8QZ
 Dp/f3r7ZcNYrmbVZmqxB8uhiJrCvcRLN80W1eadPyl3Qb42IARA3F2KLGAwjIEwWBk84
 mqa9iAJR8FQ/Mk3lTDpY3LtrhnPbqLIyP9ue9K6npMMuj+sopivO3u6YkfalDA4VDdUg
 mSzVBuPJusGVUC2O+7zi8Hknep6d8UKMkht5x8Q+7248pSiPL1+/6Njf8xC8kjjJ5ILC
 greZyJbnmxSP5rXXAAL0l9XFxbHLrRgrzu9SaViYs1EgG30kXg5FYMbC59WwM4LPa7Pc
 dHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+0Ef+wM9iBGnlAV74+t5ecaaFq7fGhBfxH9EipXPT+0=;
 fh=EZ30pniOhT6tVCQF9ZBo1Q8IQGE9UZAvBUmtOsBgpzs=;
 b=GWn/X09UPDINNh0RFeIRAoDHCbMSH4O9MSY8ufZXj365Oer3K3+03tC9U5JFcGN97H
 nFabuXm77OsSNLK2Cmn21+T3TWAuDMpxZyyVxyTu5mefU/WW4Ws2G3nyWD2le9DjWL+c
 tGYc3w68PccrzGZEBaajGvHwsc3UfIbl2uy4srqJ01rvpQmbzUDMhs2SlRoUi19IL5LS
 Jfh8vlQnjW/xFXAbg/fnwfOmXYv/K4Umn5FiyeFUJ68ybNDty3JTHn7Qgh92tE3dp3qn
 bo94qQz9X4ElnGPioDzfD93q/81lF0farpolLTo4XNpSBgt5pzmGEwcz6ykBVUl5Yvze
 Mjqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774028910; x=1774633710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0Ef+wM9iBGnlAV74+t5ecaaFq7fGhBfxH9EipXPT+0=;
 b=aR8GJdfQHp5DtS0OsfAPafh10gpfyew81AJsWoYQGjH4kunZyKCK1m0sENjx4nk9uo
 p9iZHxhf6MwCUDgvpUQFs3zMccQKmltGaUJZM+AK3hj2LMfOe6d0HQ5DBZ9PRW73DJiS
 /3yMDFdjMppgRyDcQ8CO2c1u3aItcbpNlCdgjOJ25ImmYfjTfxTmj4r24Ffi+9mDZDp4
 LjdoBN7HznsJMMb0h1ETx5LvQvgNbsw/Cfn057OB1RRRwamoIc3X1utcVcPi318wAwBz
 UwItBrlHrNhlbQ5PPsCjdDAt+2fZ3bnj2PqakylVdkzUe3G2bPfFP5noG/PVyqg9T0V0
 EwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774028910; x=1774633710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+0Ef+wM9iBGnlAV74+t5ecaaFq7fGhBfxH9EipXPT+0=;
 b=pcGzmPTybdG9Ve7Hs+9V6H5OALFpEFNUHES5oVz564FqO+r6UrMjGt5EiUARvbi5F3
 qNaKl7N6vtY6XSTjisGnl3ZTES/5qh1/KrLMvH4mrQudoVx7ooB2W2QrZiVWYyynDXW0
 0bywrVOaTyfesPmmbznhKU63rqtiQcVtZwioJYoapb9uznck8EMT685tROrIgak/xlwM
 /WMjj3OoU0svB/rzqTNw9g1WS2VKqXt3qjGvdZsDVHyui9QxM5vyOeyGWaoHMNgHzP7s
 bYx55s1B7md+60CjqXynB96faqIjpdSNjjGXnLw57Q+SWObzTDV2lg47EDCRSUqjQUBa
 zE+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0T8wUVfBBCD5HDG1cwXpYwRVRhn4PI87J95r8zRWQ0SXNOI+R2KzaRNBm3VShsuBItIoJ8WIl@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAx/VWexfnSElV+LjmpjOXsE4PPV7A34PIKfP93OKgNs2zE58h
 ITDTnshaiL0e2OFRcYINbQugfGsRIGSHSu9iGA0OoBMCz28dLSUgIUy72OhmR6zeYv5JdChBPs0
 2wcxn8AXp60y9IRvWPD488GVqMlHKaQ0=
X-Gm-Gg: ATEYQzxwxTHehsjl0f08txESXbbRuBimJAFWn7dz3JKu4Nb+TJo8l+JVQPF2V+6hB10
 J5CA/6X/oaFbbRgzrqFuNtdPoPTmFjKSQggEi/b392gYPEgn3bWpUUNfJ7PiwXltQn5UclN76p+
 QlGXg2+aqDz9BeYzkLZTSUGTWwKHxonczCKWEkLRb7uWkSsWvAelXTetu0kWfXyVi4IcTsKM4IW
 EpcRS/aKpnN6qrmXo3sthP9zX1nDw22DScKhboRc2Em8FAmsdqaLvMV99/TusvHFPzGa0LFOH/I
 bFrq
X-Received: by 2002:a53:ec8b:0:b0:64c:b12f:f02f with SMTP id
 956f58d0204a3-64eaa85b7bemr2817354d50.76.1774028910527; Fri, 20 Mar 2026
 10:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-23-jim.cromie@gmail.com>
 <177402491440.6181.10370884123666440440.b4-review@b4>
In-Reply-To: <177402491440.6181.10370884123666440440.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 11:48:04 -0600
X-Gm-Features: AaiRm53q7raCfT2VIY8VRpmfB57j5ltDj3LlcQ8Lkb1cOQPVeem0bJxBrAwha0Y
Message-ID: <CAJfuBxzAuWYMs32FUcz7TAHzQxr3Pmo8xeZ=-c4BpVG-zpAMQw@mail.gmail.com>
Subject: Re: [PATCH v11 22/65] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: airlied@gmail.com, simona@ffwll.ch, jbaron@akamai.com, 
 gregkh@linuxfoundation.org, mripard@kernel.org, tzimmermann@suse.de, 
 maarten.lankhorst@linux.intel.com, jani.nikula@intel.com, 
 ville.syrjala@linux.intel.com, christian.koenig@amd.com, 
 matthew.auld@intel.com, arunpravin.paneerselvam@amd.com, 
 skhan@linuxfoundation.org, pmladek@suse.com, ukaszb@chromium.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 21 Mar 2026 09:47:17 +0000
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

On Fri, Mar 20, 2026 at 10:42=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:47 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 80160028461a..74ed18a038bd 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -81,10 +84,18 @@ struct _ddebug_class_map {
> >       enum ddebug_class_map_type map_type;
> >  };
> >
> > +struct _ddebug_class_user {
> > +     char *mod_name;
> > +     struct _ddebug_class_map *map;
> > +     const int offset;       /* user offset to re-number the used map =
*/
> > +};
>
> Is it usefull at this point?
>
> > @@ -137,6 +223,25 @@ struct _ddebug_class_param {
> > [ ... skip 14 lines ... ]
> > +     extern struct _ddebug_class_map _var;                           \
> > +     static struct _ddebug_class_user __aligned(8) __used            \
> > +     __section("__dyndbg_class_users") _uname =3D {                   =
 \
> > +             .mod_name =3D KBUILD_MODNAME,                            =
 \
> > +             .map =3D &(_var),                                        =
 \
> > +             .offset =3D _offset                                      =
 \
>
> I think this offset is useless at this point, or did I miss something?

It is unused yet, it gets used later (patch ~31) in _USE_
to deconflict class-ids when its needed.

I squashed it in here to reduce churn later, and because it is closely
related in function to the offset in class_maps, so I thought it would be
easier to explain in context.

>
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index e8ffc2b5b330..66f4bfe39e89 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -1190,6 +1292,22 @@ static void ddebug_attach_module_classes(struct =
ddebug_table *dt, struct _ddebug
> > [ ... skip 13 lines ... ]
> > +             return -EINVAL;
> > +     }
> > +     *reserved_ids |=3D range;
> > +     return 0;
> > +}
> > +
>
> Can you introduce this function when it is used?
>

not sure I follow,
the ddebug_attach_module_classes is from v1 (committed code),
its basically going away in v2 (candidate, at rev11 now)

> --
> Louis Chauvet <louis.chauvet@bootlin.com>
