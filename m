Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652E2E8B36C
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 21:48:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5DD610E5B7;
	Tue,  3 Feb 2026 21:48:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="STG9slgo";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0265C10E356
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 21:48:55 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-658f1fde4bfso407473a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 13:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770155334; x=1770760134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOyw3MaQo4lDd393arkCTn4hcIpFAf6muvV/CwKSO1E=;
 b=STG9slgoXkvqDXWJp1qZ/XValWAmmckQP/kz3a4Q2yLNCTr7IimdMztZ0V2Nj0vIhN
 yViC3E0+zrqs5sNdCTJz5wvvjzBvEFA7i1qI6zyErRkAQxZljIw5U2cvGY3PfgklISfw
 ucqpc9AjxJ2irjtpoAygIcmJQ5kHMyo8I6efcxxIQYo4bMm+kccxGwUMxE5uqmQ0iJv2
 hh09IJDjw1AneVRyM8S5hj57n3RSqBwPWF1r7K99C/MI48jBjqRvqwreJDbY/jmofSWl
 1z3gqFfuCdyqNKiN5OkypbVMpj00dIoAKIkrif/Gzkhvng5mbXWW+xt7PgJ6sbN+5nDU
 7xlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770155334; x=1770760134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EOyw3MaQo4lDd393arkCTn4hcIpFAf6muvV/CwKSO1E=;
 b=RtinG5md6/j0lA8boML0reLRQ4t2jK/RWcyVWMosPC0c2Ep+D2oIj5VbTdgtSQKG2/
 RimFGkBrvXSAifxK48zHNebVz9wo+PJKX4ufKi+YaJe8CFYL3FBCH44nIBzChDufz6SO
 omY1nBg/tJ2XTXw1HjfxpGocwKr8843PFU2J6119/8b7A9bMfcMnKWplgrx+8UVW/UqA
 2I2V3G5hi4iDIXBVUTxDzxjbhfkEsIqVsgNnEMAqOvaeIAJ7cuoFviOTlBT2M5f51/sb
 kG8A9hSF5FcSLtwDbT0jjkLqJU5mgGaQAFYn/J11oMZIE5UuHGTtcMdKhRsOYUUtoeI8
 6lLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9ApREgUrjEI4kAEDlrFAD9qDXk/5ykZ79iLTzbQTKUjtkl7HAMgLXBXKa+aTlfuMJLb+r3hm6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzODfG5XBxhKEm3f5OM+zFN+2qUt/jtjCbdbQ9Lw2i36rbox+Ox
 LULdkhUFaVybWSc5i4kqDyNXGH2GJXGlasVHyzT2+Pba201G/gujb3Xg
X-Gm-Gg: AZuq6aLnMTAQ85AXxz7UzO6o5hdI+7k8oRaUsn1bqWV1nT18x/FkIdjoaIq8i7r7nSr
 dHawJHi0xvD+nZNM332FhaqUM9VdUW1oslyrY30l/1bdNDHqcIdpJA6CXKmJe40w3vcaMuMfAUY
 zkSJeKg6FQgwLZQp2MHdabSQVezo/CzS4YsY44qpYtbWq20JlwLiIQ9bbxQsLhhXVnHzfAU6PXN
 4e3ya+/oE3EJ2yVGHbOdewuktKTicQtd6GpNu/kIQ4S6cgGhQZsIcu4GEl7DgWsg35zXiMq49p7
 reiewWQDYQVnXoU1/ySSF+UfW/T/LyIFDA5bRehZVi37j7O55HCTq8XDtrf+E8WcKopI3cWWS5m
 gOpyZV9zyTSnToKkMBJG+/qddL00h/vNNt0HKqGhFjtxImwM+cDlNFHYEY1eGFyqzoFQVEZg+MQ
 9mN6bz2//EZSDWNn/DzdXovKRUS3DfkOPQ0KsMxYWJtTGAGEKNvqNO
X-Received: by 2002:a17:907:9449:b0:b88:1e2:ed49 with SMTP id
 a640c23a62f3a-b8e9f95d967mr62528166b.8.1770155334110; 
 Tue, 03 Feb 2026 13:48:54 -0800 (PST)
Received: from timur-max.localnet (185.180.91.41.zt.hu. [185.180.91.41])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8e9feeff5csm32034966b.34.2026.02.03.13.48.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 13:48:53 -0800 (PST)
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
Date: Tue, 03 Feb 2026 22:48:52 +0100
Message-ID: <27239220.1r3eYUQgxm@timur-max>
In-Reply-To: <2f9bc706-02d6-4dec-a56c-53abc5d43f46@amd.com>
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2285353.hkbZ0PkbqX@timur-hyperion>
 <2f9bc706-02d6-4dec-a56c-53abc5d43f46@amd.com>
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

On 2026. janu=C3=A1r 29., cs=C3=BCt=C3=B6rt=C3=B6k 13:59:00 k=C3=B6z=C3=A9p=
=2Deur=C3=B3pai t=C3=A9li id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 1/29/26 13:06, Timur Krist=C3=B3f wrote:
> > On Thursday, January 29, 2026 12:38:30=E2=80=AFPM Central European Stan=
dard Time
> >=20
> > Christian K=C3=B6nig wrote:
> >>> However, just like we do with ring timeouts, we also need to be prepa=
red
> >>> for the situation where a page flip timeout happens and we should try=
 to
> >>> recover from it. And if it isn't recoverable, fall back to GPU reset.
> >>=20
> >> No, that is clearly a bad idea.
> >=20
> > I don't see why it's "clearly" a bad idea. It's not clear to me at all,
> > please clarify it for me.
>=20
> The GPU resets are necessary because we allow Turing complete programs to=
 be
> submitted by userspace and that in turn is then messing up the HW state a=
nd
> we need to reset it to get into a known working state again (e.g. classic
> reset signal in electronics).
>=20
> But in this case here when you see a frozen picture on the screen then th=
at
> means the CRTC is still working, e.g. power is there, clocks are running,
> hblank, vblank is happening ... this doesn't looks like a HW failure at
> all.

I don't see why that is an argument against performing a reset.
Regardless of whether the display is Turing complete or not, it can freeze =
up,=20
and resetting it will allow the system to recover.

>=20
> After the input from Michel I'm pretty sure that what we have here is just
> messed up SW state, e.g. the DC/DM code has no fallback handling and not
> only misses the HW event but also blocks all further page flip requests
> from userspace which would resolve the issue.

The display HW can hang in other ways, as already explained in this thread.=
=20
Also the amdgpu_dm code already acknowledges that the DMU and SMU can hang.=
=20
Those would be fixed by a reset.

> >> CRTCs are fixed function devices that GPU
> >> reset helps here is just pure coincident.
> >=20
> > Currently, the driver doesn't handle page flip timeouts at all, which
> > means
> > that if it happens, there is 0% chance of recovering from it.
>=20
> Yeah and I completely agree that this is the absolutely worse thing we can
> do.
> > If the GPU reset improves that chance to non-zero, it's already an
> > improvement, and already more than what AMD did to address this problem
> > for
> > the past few years. I just find it incredibly disrespectful towards the
> > community that AMD proposes a solution that they neglect to implement,
> > then
> > when somebody from the community steps up to implement it, it's rejecte=
d.
>=20
> Well, I've heard about this problem just a few days ago.

Harry presented the problem and the proposed solution at XDC, and the displ=
ay=20
team already merged some patches which are intended to hook up to the GPU=20
recovery, see:
dm_helpers_dmu_timeout()
dm_helpers_smu_timeout()

Do you disagree with how these are handled as well?

>=20
> >> What we can certainly do is to improve the error handling, e.g. that t=
he
> >> system doesn't sit there forever after a page flip timeout.
> >=20
> > Sure.
> >=20
> >> Let's maybe try a complete different approach. We force a page flip
> >> timeout, and see if the system can handle that or not.
> >>=20
> >> E.g. every 300 page flip we just fail to signal and see if things still
> >> work after the timeout.
> >=20
> > How do you propose to do that?
>=20
> I need to dig a bit into the DAL/DC code and see how the signaling path
> actually goes.
>=20
> Going to give that a try tomorrow.
>=20

Have you had any luck?



