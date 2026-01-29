Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E26D61010
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73D4610E854;
	Thu, 29 Jan 2026 12:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DBKF/koT";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EB8010E853
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 12:06:34 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4359a302794so647979f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769688393; x=1770293193; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6QTOQktx+T8aTDWlJDPhGlWk3qvhIQsNrxNsbMFHUik=;
 b=DBKF/koT6XPHq1PxPXjLq8IwrY+oyMJzklMVTfF85789ow1o1HrplZ2PXUnE/dvuiN
 CJtAC8ZZXb+JyVcFRXTsewfX0j9dTaIn+YEaIAwHAGNzE6zPRdKfWZNrFuK08u+OQXgp
 10noOqeJqlJ32c0DWaWqCGZLqE+58nv0RQJmz74x2TSI/Tu8spNkZYuPDjlOE7juHPsz
 8YOxiGmMW0MQ2TkwAhM9nvYgz+ZBZVT7RbZfaIjgacXfmCHw7MBRXcjIsb4/Xlp8y2AJ
 R2n/rdak+D598HWWcF6idicq8JNHe8Yn9fVu122EnvpmNgRMHkcjWAuKn8nG/4UILAnj
 ftfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769688393; x=1770293193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6QTOQktx+T8aTDWlJDPhGlWk3qvhIQsNrxNsbMFHUik=;
 b=rnG0WbMesqQUAb2GsKS/Karz7LpNcM8uE7RSMpDbMM98mrAOLpKggLKgFi5v2/iqjk
 LZRc4Qv7XMKxVQo3UmsW/rBVCYaEm+kq1TvX41FJVYj1oHGIc+BVamFC4abCLk9nerQ8
 pZxpXbWZFSfAXzgOrdav/vMPdP6CAYsIeQggVmstfwn8v0GHQ+ctwYNzT4o9R5zq+yVj
 vDDkSNCZetuf7h2sQguRZX6tQeIuymluoQxoDZiFM6jTO7A08hfyjyGOVJ0DMUlJNqHq
 2D7W51y/xIS10bi87sHwnDR8UpcYxyyqeEp95gRNAMgS39AwXbOIGY6alH4x3JNCj980
 gHFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGrJh3SaAeoqy4RLMiljie/cuLNjaDbkDCvQQ5AKCA52FQXl0Rd10G0AOR7YQvwPTJrxrwUq1g@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywe/Wl0d2Smc7wypSCdiIN/CjcUi08LqLPBn9dJW5HpxYFnRKRB
 dRBviQKqB5lA1GzWoSCF1ZFd1xb05uDtvlo5CaakcW46eMFDySG0USLz
X-Gm-Gg: AZuq6aJU4GafL4VwdBXToHJBZWJHH76LaJZPx8M0pT64ujU6Lp0POrzET+H+6xTYsdE
 mz4XBc6KlJoDGd1B3PjiI4+hTjvJvFdVqYfXRjpYN9XnXNQuQxVcLhDMPoBsk+kjQQKcmgHJ76K
 ilVKdQ6SetG/lxYqOPGLX1sAY0J18dMyqrbXlLN2TrahtRArU64+drxbLmVuAkObDmJT8Uf4ae2
 pJapUXNQUIJRtVet0n+GHl3msoQYZh9lFAszfWM5q77jsNK/WxdQI7s/80yR2dh2qjduoCo0Iy7
 zZ/vDbWSXYlBQjAS8uvNv+RS/UwKizgDqTSJdQp/IccqR2JY8+fDAOO7wfzVHK8P2BS+Fj/gBaK
 kMx6KdUX78jqJZIgoJO8jsJsWR059dQVWCc18CCrzp+wKEyytTbBjH+T8iJ5ktxgkGVk1OYzeHM
 9IChoVtoOfXF/aT35evRNmENn37+yiu6AxCgnCS5rkNHUeGWfm7IDx8O4gCog=
X-Received: by 2002:a05:6000:258a:b0:430:fdc8:8bbd with SMTP id
 ffacd0b85a97d-435dd0b3702mr13425165f8f.41.1769688392626; 
 Thu, 29 Jan 2026 04:06:32 -0800 (PST)
Received: from timur-hyperion.localnet (5401DF8B.dsl.pool.telekom.hu.
 [84.1.223.139]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e131ce93sm13719217f8f.24.2026.01.29.04.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:06:31 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>,
 Hamza Mahfooz <someguy@effective-light.com>,
 Michel =?UTF-8?B?RMOkbnplcg==?= <michel.daenzer@mailbox.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Melissa Wen <mwen@igalia.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
Date: Thu, 29 Jan 2026 13:06:30 +0100
Message-ID: <2285353.hkbZ0PkbqX@timur-hyperion>
In-Reply-To: <30f2480d-016f-417e-9ddf-7805e4943e7b@amd.com>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2719069.vYhyI6sBWr@timur-hyperion>
 <30f2480d-016f-417e-9ddf-7805e4943e7b@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Thursday, January 29, 2026 12:38:30=E2=80=AFPM Central European Standard=
 Time=20
Christian K=C3=B6nig wrote:
> >=20
> > However, just like we do with ring timeouts, we also need to be prepared
> > for the situation where a page flip timeout happens and we should try to
> > recover from it. And if it isn't recoverable, fall back to GPU reset.
>=20
> No, that is clearly a bad idea.

I don't see why it's "clearly" a bad idea. It's not clear to me at all, ple=
ase=20
clarify it for me.

> CRTCs are fixed function devices that GPU
> reset helps here is just pure coincident.

Currently, the driver doesn't handle page flip timeouts at all, which means=
=20
that if it happens, there is 0% chance of recovering from it.

If the GPU reset improves that chance to non-zero, it's already an=20
improvement, and already more than what AMD did to address this problem for=
=20
the past few years. I just find it incredibly disrespectful towards the=20
community that AMD proposes a solution that they neglect to implement, then=
=20
when somebody from the community steps up to implement it, it's rejected.

> What we can certainly do is to improve the error handling, e.g. that the
> system doesn't sit there forever after a page flip timeout.

Sure.

>=20
> Let's maybe try a complete different approach. We force a page flip timeo=
ut,
> and see if the system can handle that or not.
>=20
> E.g. every 300 page flip we just fail to signal and see if things still w=
ork
> after the timeout.

How do you propose to do that?



