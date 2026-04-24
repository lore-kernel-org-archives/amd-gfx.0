Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269A7FF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 08:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8382410E627;
	Mon, 27 Apr 2026 08:37:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="MpeN7uA0";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5498510E408
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 16:33:28 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-48374014a77so104902935e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2026 09:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777048407; x=1777653207; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rigkqYAlhoqFqeCkHJ7xy8GFb3SiN14JzSLZL9wmVyo=;
 b=MpeN7uA0ovuhwgxNHdX/E81XG0oUWtMlL3XIy3B3pXjmPD6sQobgfC147vnatpUfAI
 U7PNYL4tvV8np1hUVp4LnM9WMx3sR356T0b1CbaHfBHnAAUSyWWiu0PfMWhsjAi93DK0
 w3VJTcaM+j81yXX1z8t3tcT80dL+r44E8GSxpk9n6lkXtLNX/XebIGO50HgBjuJGSXmY
 qa4SH4XVm2fxQCz3EHGsQWFV5pUTPyzMWJ2zj5rjKY0cLywx6e2DKN4Ptbynk7TOceD3
 AhOYMUj+cWstCiTmH79TGMZozvMA+aaNq07EQmOOfPacTne7isFBmxLuzE/eKLIyEzW3
 Ss3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777048407; x=1777653207;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rigkqYAlhoqFqeCkHJ7xy8GFb3SiN14JzSLZL9wmVyo=;
 b=IzJ2HSW9cmXEGH9OxMoXfDpzqQv3tMsY2fpzRNhXoUyOLwL2f/pgWi5a4rZrTggKRg
 /41IR5pWQpjsT5/7GlMwNFLJVP4OaihcaymMj2NECNU2RozavUjg3V6ITGAzLkl8lcFc
 gwV6XKS6LvL4ZzGZo4p71bkdmEuAcXr/uOIdJ8uEKnod6eq4xCF6Ubdc1OqZZM8YDmYB
 BYAX8L7wW+bVi1Uv0BuFs7EKCeLegmuVH1orntJL0eoShMRQmEq2rLa65/iFLiKfykET
 2DgKEGLia7bInwVApyhT6dUfJHp/DH0LezGxjWpg/wWBVtDfJAClQnX3104T3lTWKZld
 o5pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Bi2p8bmmoEzR4EeobwMaekfy7tmcvFTTNVlGNnvbLFiMQbij7bcOiM4D1QbwS9bj1yJ7yyDSZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxnkhERbG1RCSuZNC7xPh9nbSlAxjObUdaVSwwG9Jnhk6QjQDqg
 HjLubUdBTSnfz9WuroehMndy5zPoN/JRaHFCweoC9/73njBXPlnbFGv/xNByEfpuuiQ=
X-Gm-Gg: AeBDieunxs6YedewgNcKd9JXekrli7ACwMuRZMz7KTSN+Kk9nmQUvpwx7petx81BVbi
 EKJXOckuhiL2Qioc/58Kpfe0tFkScA26vxDwn1HxU1c6vy9DnXiYuMPFwTGaSS59GV68iSczJ7j
 SBDkgdcePUuB1QGJEyrTzltnJeE+MusMIkEto4HQy8dxxwkcItJP8ayRE7cQURGV5dadp+4S+Ci
 ATxOd+a0+lCEFBp8VEMQVqVeYN4sj4DD2lQOB1Uve309gNmwQRwnca1wswTy/zeZhKdCdWjnQUd
 Dp3zc1mEl65/BgBE+XK04IgC2fxZ1R/GzQz6huzfTWGFH2cXPjac2Mtpwem/+T5NCtwrmMDrZLH
 NiNtJ6MC74yauheav7ECgct78DWSCnYeJiIYAJ9f8MqeH77p17IeP4oohymdxTnnPZtZAmuMhU0
 A/6UIfUc/SD0EvSla0UTeWgbpDjhmXTH8Sbt/F1Kol/BE56IL3w9lu9w==
X-Received: by 2002:a05:600c:c0c8:b0:487:21c7:2885 with SMTP id
 5b1f17b1804b1-488fb73d9ffmr351003145e9.5.1777048406745; 
 Fri, 24 Apr 2026 09:33:26 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891c08faffsm702405535e9.1.2026.04.24.09.33.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:33:26 -0700 (PDT)
Date: Fri, 24 Apr 2026 18:33:24 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 intel-xe@lists.freedesktop.org, Natalie Vock <natalie.vock@gmx.de>, 
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 cgroups@vger.kernel.org, 
 Huang Rui <ray.huang@amd.com>, Matthew Brost <matthew.brost@intel.com>, 
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 David Airlie <airlied@gmail.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
Message-ID: <soifu3hpmugejzevzggs57dreexuoammqkufegpjfvr6dzkt7u@7chmb3ppce6d>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
 <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
 <4b647952-0038-4878-b67e-6c7fc7ab27a6@linux.intel.com>
 <398623a092c65ce4e53d1713112fa39ac0979fd7.camel@linux.intel.com>
 <8ecda206-d290-4895-bf57-346419afdc3c@linux.intel.com>
 <3b662522e17e380953d9b981d8c2febecf42455e.camel@linux.intel.com>
 <4f74cacc-ff98-426f-ac31-c25e6cbec314@linux.intel.com>
 <fb353b64e9084bc8fff01f8d5cc45701a2a60a60.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dosxmscoevitfoas"
Content-Disposition: inline
In-Reply-To: <fb353b64e9084bc8fff01f8d5cc45701a2a60a60.camel@linux.intel.com>
X-Mailman-Approved-At: Mon, 27 Apr 2026 08:37:19 +0000
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


--dosxmscoevitfoas
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
MIME-Version: 1.0

On Wed, Apr 22, 2026 at 12:36:50PM +0200, Thomas Hellstr=F6m <thomas.hellst=
rom@linux.intel.com> wrote:
> > The task writing to max will not trigger a reclaim,
> > only set the new max value.
>=20
> I still read *synchronous* reclaim.
>=20
> >=20
> > But when a process, part of the affected cgroup, tries to allocate
> > memory,
> > it will be forced to reclaim memory until below max again.=20
> >=20
> > This is a workflow where instead of the updater doing all
> > the evictions, the evictions handled by a process in the cgroup
> > itself.
>=20
> But kswapd is still used to do background per-cgroup reclaim in this
> case, right?

kswapd is driven by the global zone watermarks, it would only reclaim in
the cgroup proportionally to its usage to fulfill that global "limit".
The actual memcg's memory.max doesn't affect kswapd, it's really when
reclaim is triggered upon hitting the limit from within the memcg.

(The background per-cgroup analogy of kswapd for memcgs is proactive
memory.reclaim but there's no dedicated kthread, it's up to the user to
decide when and what to write into memory.reclaim.)

HTH,
Michal

--dosxmscoevitfoas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaeubUBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ai0HQD+Jgif2K031TYm0YfdjAty
B0TzqcqwBBNpvrgnUgC67EkA/14ZknnuVjDttRPWZYhls33OFy1aAPEoFVVOc+Zd
XuMF
=AICI
-----END PGP SIGNATURE-----

--dosxmscoevitfoas--
