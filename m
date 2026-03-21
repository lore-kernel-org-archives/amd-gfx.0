Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82544EC01A5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C28F010E418;
	Mon, 23 Mar 2026 08:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OqeQrTcq";
	dkim-atps=neutral
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com
 [74.125.224.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3717F10E196
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2026 13:57:40 +0000 (UTC)
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-64e87a81639so3181256d50.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Mar 2026 06:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774101459; cv=none;
 d=google.com; s=arc-20240605;
 b=f5JWqMFofs0n7Zv91jt4oFe04Df/VhSrUO7kEM55jVANmicBbJoVCMV0XVFieeDSp0
 EoTrUjG3kf7Obsu60GEJl5axxulF1VXPv0D1JCHJ5Jq9Z6EVLzDeoMsX0VN2qsdl5ioG
 lGoy3jFz7kqEZtEXrZPDdHIY4PQoq2nYuEFNORWduU2xqnHVZKvZWJ7QL/Y9EgvzBoMp
 2T0yq4lEHkLvWfDJcRqgE2PmxsRKordQ+fL3Y98EP6SxICX7sK4syUjb5o3uaYT+jQXh
 il+AhT9hXa3e/W7A02FHpSXyCsv/cXccl6I3C3du9fp8qO2G86JwPFxLa7AGkxvJJppI
 JFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7EPArrwVbc5ps73sNakpJn6v2WkMzJH48rSxaue61sE=;
 fh=0QnXiHIG+cb4jJpHURsNXvHURD4zvgsHRmbTgHjchNM=;
 b=ORc7Htkmgx4h7B5KTjv7ndOVj9qhJuIfN+uVfA4qmSgC90oZqrIGiIDCR+dnXEfNPx
 wxoTRbJLS6tUgVaf529ueyQF5QahAFdC5QXx4ybHby5XBMLxG19JT3ZhfTz801jjeFc3
 NiZsj/S8RyWD4R5+TRiozNBPhQAsKVcJSkaRq0/s+aX3mZRn7y9cI7vYwZhWfqdxYUg/
 l0XNLaRfe/LBF+ySUj9QRQjGvOf0wH3YbHHjbRrMGp/tiVFpIrIMgkjSiYMZTvht22vr
 /8RlRtHu+MiMh6dRQPBUr28qMV/w95D9310L3RpGl/reAwlXHMZK0xFemZiRw/V0Zb8F
 aing==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774101459; x=1774706259; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EPArrwVbc5ps73sNakpJn6v2WkMzJH48rSxaue61sE=;
 b=OqeQrTcqmyAZMuF7te2GIi2jgApHZUeIQUgcOhD0oO2uukKIicevUW6xk12BtY1TSj
 WK8kDMu0WRhmyFtp5qcpnMo5iLqnfzNbZGli36LgLD3Dsncj+aNZ5Gn7sP+BxXRREeRM
 67AXiv2ll/lWX5f2/XYIeXzw2NTbs2ukLuyyU10x9egZLubwP1J1jEnII+3YAEOh7uOk
 P5KqSmTxO65mDxZtkgq+QNxDjoXVS0QaaPri5lEKODVPzykFSe8Hu92kACp4TN9pUKzg
 PzU4Q/VpwKufC5HHzu2D2xgaqbOCh3Cz74b8pDygtOK+oQxBf5DbGYVos9Ofy2T6n1bG
 51Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774101459; x=1774706259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7EPArrwVbc5ps73sNakpJn6v2WkMzJH48rSxaue61sE=;
 b=cttkvQFqR0w2rvl/L86EkjPDDz2I2ahaLd2baI743MxcITjr+XcwBQdF1I6CoFLKFP
 n7GFBhBj2zRY8pgdJZLToifXlXT/Z+WF5zfuO9Cnyie2r2MPskj89ID3o0qmNkhEh3Ka
 ISgdKukh+JbOybo9gAF5+tN9+c3KWS6FsKg9dJ2ZfcfaIJkl6jqYQNjmXu4FDpwlZyUh
 c/umtEVbOkaPMSGr6PZpItdLUejeonZ2kM217nSaHi3/MpOSVoQr88RwyEusYkcRzQWk
 MrDleuv6QNDHbTauFZwYifaTvtplfY4BA1JJRUSeCdyLHWv8GWe8g1zYE4aBHOxaFtKx
 cGEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmIuk1poK219Uu/VXXfX5U6Gbq0u7Bh+dqAc5asc4ba0VjVEporWsCj9p27D/tgswPHhVpy2qu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwRxjDDY/sSv57nc/VX4gpa9pRQ2iSuqBG4loVzpdvowr1pdbZv
 o6HY2ATqGiDphSf/BskIurIHpTxeeKp1KfKveVBPabjXOWVbhQR9liduy+wulwCXEHAdHPjk4hv
 7NRZcrUFPzaj4ibzuFNBxWA0ZAO5TtiE=
X-Gm-Gg: ATEYQzwhJcVTV4MCcK+e1qF5PIM/xhjpQUSrKe+QWGznIyegOINiId+cCQV6vJYi9Gn
 9pzyde5rpXvEVMAtzu76VGew0xTNmd7uMZU4S+Oz3oYMCk8N1Cp36+7dbB/i2gFdWho1rvXAOgU
 3uxUeL08ohbMMW3rV2V6Yons6o50UhY58WFSYG76ie7Y7utCICHEt5l5wYWZtsFSRt9j4pkTCtF
 +/MQ6cmwcR3X7eaZ4sXeEW8akda96CEpqrHoLRYOEgksQ6v6VKWfZiesAaTgrry0BJE0Jg78vpI
 Pk3Q
X-Received: by 2002:a05:690e:430e:b0:64c:973e:874b with SMTP id
 956f58d0204a3-64eaa87157amr4846578d50.75.1774101458924; Sat, 21 Mar 2026
 06:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260313132103.2529746-1-jim.cromie@gmail.com>
 <20260313132103.2529746-64-jim.cromie@gmail.com>
 <177402491483.6181.11788631907510647484.b4-review@b4>
In-Reply-To: <177402491483.6181.11788631907510647484.b4-review@b4>
From: jim.cromie@gmail.com
Date: Sat, 21 Mar 2026 07:57:13 -0600
X-Gm-Features: AaiRm53vuyc7die3mB1r_bZxe4JdiA3Dmzfd_np6AsN6-8INJ152fSJj4AtuU3U
Message-ID: <CAJfuBxxOS7zohPDcgDAPmGBXyY8yGOZfkU_-V=5r-qXUBcpo5w@mail.gmail.com>
Subject: Re: [PATCH v11 63/65] drm_buddy: fix 64-bit truncation in power-of-2
 rounding
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
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:39 +0000
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

On Fri, Mar 20, 2026 at 10:43=E2=80=AFAM Louis Chauvet
<louis.chauvet@bootlin.com> wrote:
>
> On Fri, 13 Mar 2026 07:20:28 -0600, Jim Cromie <jim.cromie@gmail.com> wro=
te:
> > [...]
> > drm_test_buddy_alloc_exceeds_max_order() uses the on a u64 value,
> > where they silently truncate the 10GB allocation, giving unexpected
> > success in DRM-CI.  (see below the snip).
> >
> > Fix this by replacing the standard macros with safe 64-bit
> > power-of-two calculations using ilog2().
>
> This is a general DRM bug, if you send a new iteration, can you move it a=
t
> then start so it can be applied easly?
>

Yes.  I also sent it separately so it could be just picked up.

> >
> >
> > diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> > index b27761246d4b..ff158cc1d27e 100644
> > --- a/drivers/gpu/buddy.c
> > +++ b/drivers/gpu/buddy.c
> > @@ -915,7 +915,7 @@ static int __alloc_contig_try_harder(struct gpu_bud=
dy *mm,
> >       u64 modify_size;
> >       int err;
> >
> > -     modify_size =3D rounddown_pow_of_two(size);
> > +     modify_size =3D 1ULL << ilog2(size);
>
> Thanks for catching this issue!
>
> To avoid this kind of issue later / in other parts of the kernel, maybe y=
ou
> can change the macro itself to properly handle u64? I am thinking about
> something similar to ilog2[1]:
>
> ( \
>         (sizeof(n) <=3D 4) ?              \
>         __rounddown_pow_of_two_u32(n) : \
>         __rounddown_pow_of_two_u64(n)   \
> )
>
> [1]:https://elixir.bootlin.com/linux/v6.19.8/source/include/linux/log2.h#=
L156-L164
>

I will take a look, but if you have an itch, dont hesitate.

> --
> Louis Chauvet <louis.chauvet@bootlin.com>
