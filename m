Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806B71094465
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Mar 2026 09:47:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED97410E383;
	Sat, 21 Mar 2026 09:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h+5GLWM7";
	dkim-atps=neutral
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com
 [74.125.224.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D4B10EAC1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 18:04:02 +0000 (UTC)
Received: by mail-yx1-f47.google.com with SMTP id
 956f58d0204a3-64aedd812baso2461728d50.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 11:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774029842; cv=none;
 d=google.com; s=arc-20240605;
 b=erPjyqqtj/L1LEf+oX+atrFs9u0y0ENWYbEQXFl4wedpIaR/Zfsyl9Q3pbiX18h9JD
 6pvlLuslyuGOZ5nSPk5z+NEDWLwr/I9bRm1+EyK3MNSshT5/8WTOJcde66Es5leOgm2B
 GnP57aDjgr7U7OTOctpILdtDHL0FaQXL8+8SqYtFoGs7JfNhguP1u1d8xHhxoFyuby5C
 EGdqeLIK5aAg4H+R9IFe0fy/znWsz/4HmD9Ea+/TH2OcYi5zxx0Z2mPPvwbRwE9paggh
 bo2PEzPZigy15YX2rHYvZNtvU2BsHXeMyQTknW1oTiEHp6YF/WHxPiCTAlBV77vC+lFo
 Eu8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=n0ReudbBcJ1VWJQ8xSvYlWUHawfsvlE3jFdIh1UvDJg=;
 fh=GPFPUAwWwpIgsl3gUe1t5r1Arwj1kiDu38cLJEdL0Y4=;
 b=Qfp+5ujembB3dKi6KeKa36D+bW3D0swXNOAAe7+SLyevPxeCwbPr1o+JjFlCwaHDbW
 Mul0gCnDKVSfwt/vdHL/3uedilYP2IpH0/MONICS/ePxInelYwafywP2PQZKqgkNQtGf
 qrGVU8NThmBMcZk/9TzjH3ymsvIX8z076P4/+rIDI9FNxh5OzLiz0PuBCSCbglltiydH
 JGsdU3jMWY/Pd/jyF1pv7Os03CdudzbYR4QaG9cCBaRrqM/X0PXtl52itmaIG06uVevd
 HDyxvvHy8HYdMnMvpoNBlYssI+lfrQFQ5biSHgQ4WfWXaPxHJpjkMbmI59Cko9OGEvg8
 AJVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774029842; x=1774634642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n0ReudbBcJ1VWJQ8xSvYlWUHawfsvlE3jFdIh1UvDJg=;
 b=h+5GLWM7gOz6wIV5N+PjMYBSto7oRLGWGaLrjUv4foO+8Eg7YmRwD3oc+T/saNv8OK
 2X/jZgLY+jrbBh61GzsZn2pUN3FwI7xDhcvjUkRHqX6ZEVqI6DbOh+JUpZ0U74L8Blky
 lgiY6xHshv3fhU5Jca0ADOaRaZqzNWyUT3UgHEQmCh6CFoA9Js5NSFujBfhmXzZc+uum
 67oA2f/mVvBHcpHBaWU9Zk+kkXBdQQh4/IIcagPgez6e4CdnR7GwCBmBUqA6MT/MLHM+
 H+xshFNwQWXhaZmOnfGJp6oTrkmMKmhdh0dZOWj0K2ocAwTma3mpOFBXbQPuXC4+pT1u
 ImjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774029842; x=1774634642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=n0ReudbBcJ1VWJQ8xSvYlWUHawfsvlE3jFdIh1UvDJg=;
 b=iNz0BcohirHbdRxnazhxOiK5P5y/YIzJJRvHNfkCWqt/U0dG60LZ2zBHQwJ4l5tUvv
 i5AKwC1b2PmUKNU5NcHzgqv0ij8r1H+Bobq8+UZORAn3L+sQiRcocCCLJqFmqTwLK7MX
 NpUWqhAoskQ1v6lCvzKgQ2/gkbjUNc4U7KZ5B/SKwB/2XVPiHibQL+Kj+Cm9Gv5Ykgi0
 VXpPskqaBTBG6aAo5Cf3uo2Ky+htz1GMkt7CY5wfB/s6DyE53JSBDQ4UgKbgIMm+dmza
 F+hCujwLXZArk5qF7B1/yMB9Gqst7cQQwbjn7XGKOGZatpHnR2PiNmSA9qfc6FsktFje
 /FXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBNtLH+UKB9FipqBJ7j5Rix6NjCnnKZtVxLkzXkmLnFiXVelhgNg9pDNeFcAqiVd490OPCFanr@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy2qLZKQS0Ggz2NmqQp2LViSSxHQQ6e9ZFSf8WrnQ6Z+gMQuqdV
 Qq9p5PYJMGhUrEPO6FKNTOPd50WbeiUVNqWc1sMMYNYV5PwAce8lyhPFChqasj2SnFkbW1ZruB6
 SDtKRIey7iIVP9rDc4EIG3yJqEHM4FXI=
X-Gm-Gg: ATEYQzykbBkVMeo+LXsoEufuV3hvny2ac9dNF3wenXa4UypNf6eO7f4CLH9rCYkn9/B
 hVGCOf/WHuCPK3i+9zkG1GW+ZAXZTOO6JEXTCYrm+hwc31WHu7aA5xZ/yCsYEwO5EC+mIC17Hb3
 r3azFPhm41CCnFXEaNpPWAjUwgS0KNIpWcYnKWepmb6bK5JyzEkwgS/WfycZRNzk1qSW4ft+Q6w
 4y/+z2shrYKkPA7+DFRbX20lJJ7XRlA6mkiy78WFRjs46W9dVDTfrYrC6Qq/699/rQ19C6g2tJ/
 P+27
X-Received: by 2002:a05:690e:74e:b0:64a:ce9a:ace2 with SMTP id
 956f58d0204a3-64eaa7f7bc9mr3212110d50.56.1774029841504; Fri, 20 Mar 2026
 11:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-32-jim.cromie@gmail.com>
 <177402491451.6181.5247342952148189934.b4-review@b4>
In-Reply-To: <177402491451.6181.5247342952148189934.b4-review@b4>
From: jim.cromie@gmail.com
Date: Fri, 20 Mar 2026 12:03:35 -0600
X-Gm-Features: AaiRm53l_YjOB-S5RZgL9xPfAK8bYaoK2HLT6VSg9ZSzbMdUrD-RUBzNTMJmVgQ
Message-ID: <CAJfuBxx748fTNk51joPgCUTqd8PmTG-mwp0YL3gTSzcnu5w8KA@mail.gmail.com>
Subject: Re: [PATCH v11 31/65] dyndbg: add
 DYNAMIC_DEBUG_CLASSMAP_USE_(dd_class_name, offset)
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
> On Fri, 13 Mar 2026 07:19:56 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > [...]
> > cases; perhaps a 3-X-3 of classmap-defns X classmap-users would get
> > too awkward and fiddly.
> >
> > This is an untested interface extension, so drop this patch if it
> > feels too speculative, knowing theres at least a notional solution
> > should the situation arise.
>
> I agree on the patch principle, the implementation seems good.
>
> Can you move this patch after the BROKEN removal? I think you should
> "stabilize" core features first so we can merge part of the series (and
> reduce patch count).
>

I'll do this.

> >
> >
> > diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
> > index e9fa0c8868db..2083a8546460 100644
> > --- a/lib/dynamic_debug.c
> > +++ b/lib/dynamic_debug.c
> > @@ -206,12 +206,17 @@ ddebug_find_valid_class(struct _ddebug_info const=
 *di, const char *query_class,
> >       return NULL;
> >  }
> >
> > -static bool ddebug_class_in_range(const int class_id, const struct _dd=
ebug_class_map *map)
> > +static bool ddebug_class_map_in_range(const int class_id, const struct=
 _ddebug_class_map *map)
>
> (that the rename I mentionned earlier)

I dont know what you mean here.

>
> --
> Louis Chauvet <louis.chauvet@bootlin.com>
