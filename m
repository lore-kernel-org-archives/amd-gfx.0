Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CA9D68BF4
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 09:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FEA10E399;
	Thu, 18 Dec 2025 09:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YFJG+Izt";
	dkim-atps=neutral
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A231B10E374
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 03:14:56 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id
 98e67ed59e1d1-34e730f5fefso196129a91.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 19:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766027696; x=1766632496; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aMmDsg6PeqY3yDJKla0eomYe6OESw8tJFHAPUF0WDJQ=;
 b=YFJG+Izt9uC9/yrSy4DW5nqOBzX4C6QVJroqg6GNMXU0V7j4d+ENvApxZILTkyBI6p
 VhJIlSZZfd7P0sZtlVZoh0l509j+iC2eW9wdXu2gi/Q+oGjFcHsTaJ3xXwC72dTUKeQ3
 8xkuiIXeRgX4fw6M5mMb47RtyFoike0bvE6V/R5FMYuCM96doMSm5jzrls0YlX2TtaG/
 SeWaDu7M/VZUoWM8NnyedUw8sdQY5hd2zvA2VlcTUEu7TRe3HhMiSX3fOkzbSTP7YTOJ
 YLTCYVKGgF6dDr3Awk3t48YgJ+rNF8CWw9dgaOjYDdH8CLAIcogFoydSj3RXZnq0o+jL
 UfGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766027696; x=1766632496;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMmDsg6PeqY3yDJKla0eomYe6OESw8tJFHAPUF0WDJQ=;
 b=XlM71l0JJAWnMCATE2S/SFRE11b8gx0DrPQ370HpzzxTBhoxjdTYhzlnngM6Nw80Mz
 TDlHZ4ZW5oAWkWaQ5GrVONqGJBrOhaLw+NUZUsGAqW4MKUyr53zvbUeVqzKKRPEgKUrS
 LS8sGue3N2TnqDL7f4hHau3Odr9/EcDrY5vmqGApeXxoPKQjE9XhDdYpshrchIMMPXvD
 kC6pRdqnpQWvct/N94CRYCcKgQbsBrBNjKYZFcA7OGpfyoqufHL56PamBOEDlLMrctQ1
 MFR+uxO303o8iO+quogxY07cv0S1yCWhHCiT7okxKKh5FWHc1rk0rcgOfuVD0mT/0Ii8
 a5ZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW75wdfXmLV06Nr6rn4nOfC675C2HnQYpAntaTKArrt0XgMGJwoASzDojL0bpyeyyr2GOrBMNLx@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCwhr5Ky9nH6RUG4HwE432Swsx19Y2H8wmimRvUWGU+MI0EUiv
 5Q66vM8EhkC5V8VZmg9bmdXo8wX1LowfL3QX49/CqHDnJSl1cl11yKD9
X-Gm-Gg: AY/fxX7j09ldJ3/ugtvUnjIXYZCuWHaLTXrSKKQsQrBoW7lvjATQw3S+TQ2B5R58Rax
 YTzrW3iSaVKSSKn4mMA9IRUDGhctZKjuzFeR2gB1luHffGDse3KSskpAEL1EDt9KDSsFKSShJI8
 UOyrAx4iGpgG8gU6vy00m0AAuYf4aLHlcgtPmScBjKPcUDcbljnGOULDOcYOqciuk26AtRQvLFU
 NrzhF5K8qhoj27w85r2lJIpTmrfJlhkEVqZgxWadDyX13sgNfp31mDgO1sS7w15Z+/5y36KYc3U
 FIDnLAy4ZSjUbCuXFJX5KFZSfmV7pfY926wY6z37df17ZV9MDQ6WQHW0W0oUpMsBalGR10DKJ9E
 EQjJTEx84o6S5gjzT+6u0IPcSDmGcX1IhJJGRQtqvdrLdF4Mv/vd2x+ijHDW4xd5aI5Nclm4+mU
 JWO2Tlqlxpz94gkq0eEKqT4g==
X-Google-Smtp-Source: AGHT+IHSjhEce/oXMOW5vM6ZF5lLLUz2/oBcTOMxDFFo21mOBhpjs2cfzbOckN+Zo7VcHVKH3Yx+8g==
X-Received: by 2002:a17:90b:2ccf:b0:340:cb18:922 with SMTP id
 98e67ed59e1d1-34abd71f7e6mr19045388a91.14.1766027695922; 
 Wed, 17 Dec 2025 19:14:55 -0800 (PST)
Received: from archie.me ([210.87.74.117]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c1d2d9ae134sm730773a12.1.2025.12.17.19.14.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 19:14:55 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
 id 75FB1420A930; Thu, 18 Dec 2025 10:14:51 +0700 (WIB)
Date: Thu, 18 Dec 2025 10:14:51 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux AMDGPU <amd-gfx@lists.freedesktop.org>,
 Linux DRI Development <dri-devel@lists.freedesktop.org>,
 Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
 Linux Media <linux-media@vger.kernel.org>,
 linaro-mm-sig@lists.linaro.org, kasan-dev@googlegroups.com,
 Linux Virtualization <virtualization@lists.linux.dev>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Linux Network Bridge <bridge@lists.linux.dev>,
 Linux Networking <netdev@vger.kernel.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Alexander Potapenko <glider@google.com>,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Taimur Hassan <Syed.Hassan@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>,
 George Shen <george.shen@amd.com>, Aric Cyr <aric.cyr@amd.com>,
 Cruise Hung <Cruise.Hung@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>,
 Dominik Kaszewski <dominik.kaszewski@amd.com>,
 David Hildenbrand <david@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Max Kellermann <max.kellermann@ionos.com>,
 "Nysal Jan K.A." <nysal@linux.ibm.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Alexey Skidanov <alexey.skidanov@intel.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Vitaly Wool <vitaly.wool@konsulko.se>,
 Harry Yoo <harry.yoo@oracle.com>, Mateusz Guzik <mjguzik@gmail.com>,
 NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, Ivan Lipski <ivan.lipski@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, Lyude Paul <lyude@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Luben Tuikov <luben.tuikov@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Roopa Prabhu <roopa@cumulusnetworks.com>, Mao Zhu <zhumao001@208suo.com>,
 Shaomin Deng <dengshaomin@cdjrlc.com>,
 Charles Han <hanchunchao@inspur.com>, Jilin Yuan <yuanjilin@cdjrlc.com>,
 Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 George Anthony Vernon <contact@gvernon.com>
Subject: Re: [PATCH 00/14] Assorted kernel-doc fixes
Message-ID: <aUNxq6Xk2bGzeBVO@archie.me>
References: <20251215113903.46555-1-bagasdotme@gmail.com>
 <20251216140857.77cf0fb3@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V23DYTy9ofvlaB8B"
Content-Disposition: inline
In-Reply-To: <20251216140857.77cf0fb3@kernel.org>
X-Mailman-Approved-At: Thu, 18 Dec 2025 09:00:47 +0000
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


--V23DYTy9ofvlaB8B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 16, 2025 at 02:08:57PM -0800, Jakub Kicinski wrote:
> On Mon, 15 Dec 2025 18:38:48 +0700 Bagas Sanjaya wrote:
> > Here are assorted kernel-doc fixes for 6.19 cycle. As the name
> > implies, for the merging strategy, the patches can be taken by
> > respective maintainers to appropriate fixes branches (targetting
> > 6.19 of course) (e.g. for mm it will be mm-hotfixes).
>=20
> Please submit just the relevant changes directly to respective
> subsystems. Maintainers don't have time to sort patches for you.
> You should know better.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--V23DYTy9ofvlaB8B
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaUNxpwAKCRD2uYlJVVFO
o1nDAP9D8xQeBKhU5vgUY1uZdEmdnOr8lzFR748Q3fszwHYA2AD+Lmk5pycZlTp2
pDdOJDlTqJohju9NNAPmvm1zT37zzwE=
=Ar/g
-----END PGP SIGNATURE-----

--V23DYTy9ofvlaB8B--
