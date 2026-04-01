Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF17D35162
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 11:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 934A510EF37;
	Wed,  1 Apr 2026 11:43:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="DUoZlh8z";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE9AB10EF37
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 11:43:54 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-89fc4147f2eso75554646d6.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Apr 2026 04:43:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775043834; cv=none;
 d=google.com; s=arc-20240605;
 b=EQ8uDPoe7HtjGhn7OnK+icJe6xdq2jEl0C6UvNuzreiTHSHbap5N/bVUaR9YMvKi2L
 TpIW9Gwpc7Og+aTrZ2yqFP3lD4qT0JzXk8khdRGdJlBg8wcDfjjjoXKtMTRnEjNQX232
 dfTb+5pqxi6Q3Amyr7sj+7E/iEe+npQAvG2i0/+mUR77pniRW4TofdE4Va/W6gSJU5bZ
 gTn/BPsbFGGvhryR4wo5qDhoEPvm8fvwhzlWJ/GTH0JnB0mg2SP70UPye+s4Q4zAA9o6
 aTMGQG8F+oJILEQr/upfLGrAbp3xie3/cUaT3zYUIXEpY/x4szSWFtlwBAuAJqAI280C
 eDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=mSr4C1kBGr9jdXVtih2R82H4XWKW+kzt2DSLVfDJkzU=;
 fh=KphiYKAwjL0crdr3g0Pt/UY8LOoBi1CO6ZN2t6dsy5w=;
 b=OWojPLv5BSWKDfcRaJNzvQKdckcoT+oLgmXMEpCMrlOnWN2dB4xYs2KdSeIXVtjeYQ
 9it1DUG/yzSDOurrs5OMhUhBLtNucde5lXDOJ9QdC1bjxQKhla1EOvgwwf3jw/aGo0Sb
 SBlZOCaccp1PylTJ04gqwotZKOjeuOWN6IdGnq1chVtnbgC8N66FYFjnuIIkqp87vYn0
 HHFQbvrOsTASLMDTJ3y6o4HDawtRCFTsODi9axUOVc3uJlR1ueAK3ymrQLXyuRJiReq8
 DlPL74wbVtyOITr8M7fZvuMHF0gLL/erAiJUjy64EM2qPZJ/TKfAnhJrJJpngPcrBR1z
 Pv2A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1775043834; x=1775648634;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mSr4C1kBGr9jdXVtih2R82H4XWKW+kzt2DSLVfDJkzU=;
 b=DUoZlh8zCUx2NTth54uUu3vi0uGOax58ZQg+0GvfyrB7ZZWzWJ/IgCSwkQE7ww4k9T
 a1r0ACN1Y/eewhJ6qOk0Yhwx20GIIkLoXv6/Z3VMvxw+UHnhqB8oBQuOJ0ypIs2QpTKo
 /OR6A2mqi3fh64YYPwWkdoSkZZLRznRn+srrxlMpLpU8zyluJmM07OKwdzDunjis0eT0
 wQQ21XrYEjbPM6XKTXxjAig7Km63GGukIaxzjE6bqr89IQFewddXlBMoRMPgaxMfFTub
 I/eGIm7HxSESv9Xd/AN/b44KKmo/qOsFdk396S8h06o3gIo/BJx83Zgpb67X0eNZ66qD
 PSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775043834; x=1775648634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mSr4C1kBGr9jdXVtih2R82H4XWKW+kzt2DSLVfDJkzU=;
 b=cDE1qc3VSUbhA2a0WYC06J3g70+t19qbrCV3HevUEsL5jXllEJCSWDIs0AJLbU/qCA
 aCOZwQupyorCSxwxwx0iYlfxkkiB6Jzlj5i1rEWxNT4rQA0rkRKuYYO29XWHmdZNfLHv
 XLI1OqqS4wi8ficzvUfwu2C4Tkbf2ijMxMl0wrY8s2naM+DEQMSR0KDmg6TB/yc+4DH/
 9UKCAbqbkHslENT0YfsbU9aWODx9JbpSamwX9aaxkGXg/AwK49pWaW3hMG+LGDqseVlL
 Mgnnro9QPxGbGM6d32PscjzJINQ02i471TFIPw3xYwZi8393u5G1zQIhq0CHf4w+vmHh
 TKJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUap6/Ducrg3zC7V5RDMEuaxOPwyPrdPGOI/KWWBKcWgAfJQrbKe115mZTiSiFV88kVDzug12ct@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlrTB9X6YwDOxLsGyyWdt9N3gIl2lqmi55/SU3wl6pGSAPNjQ/
 RJvVa4OWNE7uytmhRf30qUoOOpJe9CAHDlqwYfLNW6889gH05au66v5iqI7jxph48Ngtg0dInFm
 QF8XUMX9aGiRrjVZd+4GyVIEjhzi78KMYXtDdTpoc+w==
X-Gm-Gg: ATEYQzyBDvgsKg4uCMTRA60SaIW+N3D1vDle7RnxagqkGP44wJjvnhYaGIgriztM3dZ
 l+Q7LD/fQ4xgNkx485d/L7f1c0UlkWP1o8YFMFEOjHHUveGn/QcxIvyYbEY5gGEkft2EgrP/65Y
 e0hPx0p41IpJDntvSG2WgpYv85Rnbq31ldgzmmpQRTGOfNId0mk4rt7yOwZyka9DuDKT0241V/1
 RQq1rY6UzTvesm7Q9sM99ZdC0kwji+7EbZjWYQeD18ECLbf5HHtroOSqFDKBTsqqwjL8rNV/Pk0
 UN1GrbJI+jeKHoi1/LTqotExnH3PCGomr6AhrCqelA==
X-Received: by 2002:a05:6214:6017:b0:89c:e38f:6b6c with SMTP id
 6a1803df08f44-8a436a1fcd9mr47907356d6.3.1775043833750; Wed, 01 Apr 2026
 04:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260319-link-bpc-v5-0-5306cd04a708@collabora.com>
 <4265353.aeNJFYEL58@workhorse>
 <254c20a4-cce3-4c8e-9902-514586f3e694@mailbox.org>
 <5416161.aeNJFYEL58@workhorse>
 <792c4540-d690-4453-a32e-62e23e78d628@mailbox.org>
 <9d525fe4-b091-4cd9-b977-de19ffe4b957@amd.com>
 <20260331155028.71246d7a@fluorite>
 <dc7f59af-05d0-4942-b21b-b85289f7eee1@amd.com>
 <CAPj87rOz=QvQE1CqshspTPkC5nSXW_WAxUf1rwa=w4zmPdgtQQ@mail.gmail.com>
 <acz9H5RtaGUUx6Cl@intel.com>
In-Reply-To: <acz9H5RtaGUUx6Cl@intel.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 1 Apr 2026 12:43:42 +0100
X-Gm-Features: AQROBzCdXxrvf8UgyLJsezxbKvCf1uhBJ-Iz0urPdALgrRljTD4OL7pKkrh1Hr8
Message-ID: <CAPj87rNTNT9227TjrqmDOY6-TNjvuGJTDgjBXF3467Ea8vwzYg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add "link bpc" DRM property
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
 Pekka Paalanen <pekka.paalanen@collabora.com>, 
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Daniel Stone <daniels@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 kernel@collabora.com, Derek Foreman <derek.foreman@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>
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

Hi,

On Wed, 1 Apr 2026 at 12:10, Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
> On Wed, Apr 01, 2026 at 09:40:15AM +0100, Daniel Stone wrote:
> > The end game of this isn't Weston logging something to stdout, it's to
> > surface things to userspace so it can guide the kernel into making a
> > good decision for usecases that may not be ones the silicon vendor
> > decided was 'probably the best thing' however many years ago.
>
> I think the problem here is that no one even tried to make a
> real userspace implementation. So it's very hard to judge if this
> new property is actually usable in the end, or if it will just end
> up as historical baggage that we have to carry around forever.
>
> IMO just having userspace log what the kernel said does not fulfill
> the "userspace implementation must be ready before new drm uapi is
> merged" requirement.

Sure. To be honest it seemed pretty obviously reflective of 'max bpc'.
Derek is working on a Weston implementation which uses 'link bpc' as
part of a control loop with 'max bpc' now, which should hopefully
satisfy that.

Cheers,
Daniel
