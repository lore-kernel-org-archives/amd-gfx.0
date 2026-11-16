Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD73B606A31C
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Nov 2026 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=odi2wuKZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5A2810EEC2;
	Mon, 16 Nov 2026 09:28:47 +0000 (UTC)
Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 468AF10E988
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Nov 2026 07:42:02 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=J6P+SDzlyU/fh2AKrJ8vgmbOJ1hL9+YmuQ0XsXd3yOI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794814921; v=1; x=1795419721;
 b=odi2wuKZTXuKzYdJTex+ea0nKIfiWg0ZIclUp83TN0GKyWzT1BaZCxQC4HJiQUhv1foVpQzd
 nkgA+nWAqLRi+uWi6tVIysi9oPDG17Iswz0/RgNIXH+FQRGxHUdDTOLev8UwU1oEQMGYooZqc6z
 bS6gItE872IEAHvUHBaQ5PrY=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 0e17c37dcd4d9ef9;
 Mon, 16 Nov 2026 07:42:01 +0000
X-Mizu-Trace-ID: 0e17c37dcd4d9ef9
X-Migadu-Flow: FLOW_OUT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Nov 2026 07:42:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Jackie Liu" <liu.yun@linux.dev>
Message-ID: <eecbc1d7670554d2c11273331b6af9855d58d79d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] drm/amd/display: Fix logger leak on perf trace
 allocation failure
To: "Markus Elfring" <Markus.Elfring@web.de>, "Jackie Liu"
 <liuyun01@kylinos.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, "Alex Deucher"
 <alexander.deucher@amd.com>, "=?utf-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?="
 <christian.koenig@amd.com>, "Harry Wentland" <harry.wentland@amd.com>,
 "Leo Li" <sunpeng.li@amd.com>, "Wayne Lin" <Wayne.Lin@amd.com>
Cc: "LKML" <linux-kernel@vger.kernel.org>
In-Reply-To: <ae04eef3-ec99-4728-be84-8a71e16c0b4e@web.de>
References: <20261026111047.97178-1-liu.yun@linux.dev>
 <ae04eef3-ec99-4728-be84-8a71e16c0b4e@web.de>
X-Mailman-Approved-At: Mon, 16 Nov 2026 09:28:41 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

2026=E5=B9=B411=E6=9C=8816=E6=97=A5 14:57, "Markus Elfring" <Markus.Elfri=
ng@web.de mailto:Markus.Elfring@web.de?to=3D%22Markus%20Elfring%22%20%3CM=
arkus.Elfring%40web.de%3E > =E5=86=99=E5=88=B0:


>=20
>=20=E2=80=A6
>=20
>=20>=20
>=20> Free the logger before discarding dc_ctx and clear dc->dml.logger t=
o avoid
> >  leaving a dangling alias after the failed construction.
> >=20
>=20Would there be a need to complete the exception handling also after a=
 failed
> link_create_link_service() call in the implementation of the function =
=E2=80=9Cdc_construct_ctx=E2=80=9D?
> https://elixir.bootlin.com/linux/v7.4-rc1/source/drivers/gpu/drm/amd/di=
splay/dc/core/dc.c#L990-L1037

Hi Markus,

Thanks for taking a look.

The link_create_link_service() failure is already covered by the
caller's cleanup. dc->ctx is assigned before that call. On failure,
both the normal and virtual hardware paths reach the destruct_dc
label in dc_create(), where dc_destruct() releases the logger,
perf_trace, and context.

The perf_trace allocation failure happens before dc->ctx is assigned,
so dc_destruct() cannot reach the logger in that case. That is the
leak this patch addresses.

Using common cleanup labels for the early failure paths would be a
reasonable separate cleanup. For this stable-targeted fix, I would
prefer to keep the change limited to the missing logger cleanup.

Best regards,
Jackie

>=20
>=20How do you think about to avoid duplicate source code another bit?
>=20
>=20Regards,
> Markus
>
