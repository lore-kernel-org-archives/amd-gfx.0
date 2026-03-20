Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AC8109446A
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B883E10E374;
	Sat, 21 Mar 2026 09:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nKjWhvAP";
	dkim-atps=neutral
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com
 [74.125.224.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D354510EA6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 17:36:34 +0000 (UTC)
Received: by mail-yx1-f48.google.com with SMTP id
 956f58d0204a3-64e9f9226a7so1883007d50.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 10:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774028194; cv=none;
 d=google.com; s=arc-20240605;
 b=CvKX8uIRlGxxjH+vc37wMan/ajrkDIMqxqItpachhDxDs60UUR7CIGcMz2rKE2Jznc
 uL8E+iE5L4YNlaSUqDNh8GzQof3F5L5YmKRGZspoX3bvLfx5cPtVNc/9b7AJ804jVlU1
 +vZxqXL2FLC4ha/Vn0Hq1lMs4g62zSHQypV7Um+tcaFRQGPlpXR5v8lveom/Kp6DSep5
 H13/OLu+gOfz8hB/ZfoED+0l40lFB5UdwU7tgpaub7424zA+wEE2VnJbpKOe7bRSye8L
 iwKVwe5h95dFRnFQPDkD2Mg8kBInRJbJu+491j7WkF4NAvNguAqQf/zabsJhaz+h5EfF
 Nkcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BgGZTOzZCC8ovn7k66XyuhZliqBNi9YYaqpJPuy2zpc=;
 fh=NT8CXuqei8WGZjD84foO1CuEjQDsCKyYoCT/xmUi4mI=;
 b=UAWVr+8jzuqxRS4a5aTO5d35gWk8rOPn/srE4RpMA7pjdn6R7FvfSM0rd0+++Flw7R
 6ZX6ziPZ96086WGSZ3ij5W2s6Zc4zvb1eBaIJbgvFyK+jNscxaUkdSaGwrtBRX7sPPN9
 ktiey09jPnMxRxFNnGkZYuTRyh16ewWhkU3Bnkt3siOvyvlFewpA4CK6FdrNvwIlIiRI
 JAhF8YMmBY4YHFBXI6x+hISP6tFvHs/1fU/OWPByXai21CSWj65Mti8HSCa80p629qyS
 7j+pAmubEkIBHnq+8LzVO96mw9SR5A6k9xoIlPZAi98gEpa9G6rnhFi/Kq502FsN++YJ
 7ArA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774028194; x=1774632994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgGZTOzZCC8ovn7k66XyuhZliqBNi9YYaqpJPuy2zpc=;
 b=nKjWhvAPSaT3zuQMVGrpua3VamU6vnb1satxxSu70jcVV6JAEq8VyCoH0OH6IyPOuh
 A5n2nSbKsLv5wtlcw9A44XJ+jDLbDAB49M28EFttNNiAyLLgRwtLOhtnaMIxPJcsqJI7
 wSPvIGCpEfQgjVIWllXn2fSiOt+OyayVHu4VK+wCERcQh4gkBvXkj2ouu0KnwjgVuujI
 5tFujABDlFp2qWRqPa52VVIFDz+yhfZmjw6175rpyGB2M9OaoO938gxal6XRKiR5efkb
 VZ+P5RmoQBXO8w2Bii1mQZyIwWLkSZhg7o2Ih2xg43LpwtIEm7cPpFRS28J5L1GQEgQr
 Q34Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774028194; x=1774632994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BgGZTOzZCC8ovn7k66XyuhZliqBNi9YYaqpJPuy2zpc=;
 b=rsbi8DYV/nMWo2VoOro8qWelerg3uJMegvxbbt3EtdtAiTnSNpdokyU/v8lxF81IoA
 9KbWXOn0eXkerJIA+N4MO1qAF6Ok1BqJMef4knidyuNqvS7sKMH8MNCOSYxZ7YbHyve4
 6g0Ri6XNyrbkOLm8YSkpwACEQOdMFrMRzRKuGIvtvEF/Znf3n0PhNNZ9dNBlwdiynkeA
 Qp3CypEAL+KJ2BUUUcK0j7EoqWHgnbrDoyQLxY1cXYEkuKoHe1AY9sTdGFF9srsdG0/t
 Gx0k6FAtJKL/z0NZjqUNxTlNiLbNZFdK9b6b2RAyA4Zk9msvF5s3InvIKZiXZ/NlSoLj
 CVtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnL06FZIlEiaHTxJkKG73WTisGeCtABUj/GpiWjW3uXU9soZtNc1V4Mb9X2PW4cwyzsn3iIZcU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwisxDlmUvj7KXqhfGfA4MIke9/uzLY+/YItf2aZ+fd1mcIG63S
 DiQrWNlY2badQ0ATZ1o17EjsCTP/X3FLRzkMLGiZiIbfXM3OZkKyNzHmu3a+zceK1OvhQpoo2Ww
 7u7/L9yzr8VzrihCD493zyVUpUbxipYQ=
X-Gm-Gg: ATEYQzxx4Xe6wPWopoJ2wWYqeG9/JMEGNDe8fX2sIY6GBah2BHQ5XIytKcUVKf4HsVa
 fLmUJjGoG03i3WAh2knoxU3+L57X2bF75n1vFAaWCQoijSHAnhgfSvQXI/g6fgOIgHZ9ilVK53P
 YDLMquWUpnqCgTl0qK0dNAfkpO0GW9Saqu82xs4TuynTj8JkvE9QU4EAJaO23YxC4ijuWVX10FA
 bkqH+UygvujyRds1vKRcwrVXGzpmkBgqNuJ8+KyqxtzsUn0d0w1sBcrcX+SWvX99JmZcJdvjDDn
 prd6
X-Received: by 2002:a53:bb08:0:b0:64c:9c10:c09 with SMTP id
 956f58d0204a3-64eaa7b37demr3014158d50.51.1774028193589; Fri, 20 Mar 2026
 10:36:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-17-jim.cromie@gmail.com>
 <177402491432.6181.1032037030316089534.b4-review@b4>
In-Reply-To: <177402491432.6181.1032037030316089534.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 11:36:07 -0600
X-Gm-Features: AaiRm523rwSycvdGB1zaTykXeTcT9kD3zP9a6PiLV5_LFsq_fGCRDaXzKyLP7BM
Message-ID: <CAJfuBxy4Tqg5nsgLHgYFEX0F=3h_XkSD5skmy+GypoTBwB+a1w@mail.gmail.com>
Subject: Re: [PATCH v11 16/65] dyndbg,
 module: make proper substructs in _ddebug_info
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

On Fri, Mar 20, 2026 at 10:41=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:19:41 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debu=
g.h
> > index 9fd36339db52..b84518b70a6e 100644
> > --- a/include/linux/dynamic_debug.h
> > +++ b/include/linux/dynamic_debug.h
> > @@ -83,30 +83,42 @@ enum class_map_type {
> > [ ... skip 3 lines ... ]
> > -struct ddebug_class_map {
> > -     struct module *mod;
> > -     const char *mod_name;   /* needed for builtins */
> > +struct _ddebug_class_map {
> > +     struct module *mod;     /* NULL for builtins */
> > +     const char *mod_name;
>
> mod_name is not needed for builtins anymore?

it is needed still for builtins, because the mod ptr is null,
which can supply mod_name for loadable modules.
I can restore the comment if you think its still helpful / not redundant.

>
> > @@ -125,8 +137,8 @@ struct ddebug_class_param {
> >   */
> >  #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)          \
> >       static const char *_var##_classnames[] =3D { __VA_ARGS__ };      =
 \
> > -     static struct ddebug_class_map __aligned(8) __used              \
> > -             __section("__dyndbg_classes") _var =3D {                 =
 \
> > +     static struct _ddebug_class_map __aligned(8) __used             \
>
> Maybe a dumb question: in a previous patch you added ALIGN(8) for the sam=
e
> __section, both are really needed?

its a different macro, so I think it is needed.
Note that the macro is deprecated, and will be removed
as soon as DRM uses are dropped.

>
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index cb7bfe8729a7..f47fdb769d7a 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -1254,18 +1255,18 @@ static void ddebug_attach_module_classes(struct=
 ddebug_table *dt, struct _ddebug
> > [ ... skip 13 lines ... ]
> >               }
> >       }
> >       if (nc) {
> > -             dt->num_classes =3D nc;
> > +             dt->info.maps.len =3D nc;
> >               vpr_info("module:%s attached %d classes\n", dt->mod_name,=
 nc);
>
> IIUC, maps and classes are the same thing, can you do a s/classes/maps/ i=
n
> the vpr_*?

yes - class_maps is probably clearest - closest match to code too.

>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
