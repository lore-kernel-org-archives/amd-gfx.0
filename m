Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C58CD5BD2
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 10:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61C6110E0D4;
	Tue, 26 May 2026 10:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="II5lIHfS";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E25810E0D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 10:12:02 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4905e190c71so22538195e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779790321; x=1780395121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0eqLHCirYRSC23WXgv/uI5hiHASKf1PQtC12E/aDAbc=;
 b=II5lIHfSBsoUP/tkyWMC/GtSfpss9gPXf1hbgs4j5/ClZ1iHERg/AS+aXTevoZ+0Ix
 4h8r2m0GLNNKB/1meKV2re8Qz3qY40fUPfqFZ8ow9i8uML89Rku7txhVK6SRo+PYSVtZ
 JFT3DxQvUkMoJX/tunwG5sR3RrK1LO+GNN3TXQwJEtUdctbdOP00Gal0zY48izOmqBZr
 kMnVwaJFq+vouAeOwpFkeEqoh8uLpcw3xrh0L6M18Z/n2X6L+ORrkeowy3v6cE4P1tt1
 0lOHwOyFfACpY8kair+LFB/hFfD9CK4VUrH9pnwuHOBoIXGgosQszT8/LGWywm7XRxoi
 pMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779790321; x=1780395121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0eqLHCirYRSC23WXgv/uI5hiHASKf1PQtC12E/aDAbc=;
 b=kipde0N3UBeNjBU1vdyPLYIKSNSRta6xptP/gawFXV5Dhcq0bN0cr6qZ2WJZvQSmMp
 rmp0DAN5c2x7fhPTZZkyKVcnKSvPu6oPEBC79DSmQar05w+nG0LQlssgIIDMKJmj6HTQ
 ycEZNM1TY/CRUjfiZnpp84aIXKiuambiax4LUgn7yD5/LOaQsL/xfx7OyeNNwI/AiFot
 dsjqUlmt/YB1Ut3R+zkKn2EFAsNDxuv1QFqknPzGeKQTMgcPBtFY1GrQr1zol7aOzOsj
 BBPRzY51xNRljKFbMeSDumPhGnmvmpNsvcTF7Kj6E09Myqx0v4tgMdGBCg5AEUPGe5Uo
 fYbg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8RIn7283pl74lq6VwvB7RfNbuOVkw3dhi/IqW8iGrG6YKCu3y6s9YbiIY8/fseEDlz0uTP8cJm@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyenNLiSaa1O4Ti4BoqRMP/390KGq80qiU5OtSgMBE+7+S9NmR4
 jMN7U10pyfJzgAp2YASEdYLPL6tSj5NGD/9SRXg0opufcSd2RROAGz3P
X-Gm-Gg: Acq92OHv8OYwnNrcX9hoWsF5EVq4lwEMxtNwpxQA27J1T4l25/nVcdbF9AuIkF0B2Rp
 8mpcbBpdik+AG7fSMo+iPraB8Zv2hqOc9HUiFqxawsyOyCxrVFZ9iAHfIdNFaNFhwBKAlTnnHF5
 7+5iYIveySHaB7hIa+7D2KZzGib5nk2DGmDlsjBphubgFFEPknE/PGcxfyKmbntqXyXjHS7dUZL
 qQMECxLZNQtKE61Xf3fzmCBDHhJA3EvzCF8nCfxBVi4dTiuXUtOlx0fW1dRn97OBSMMFnayfZ0R
 S+Fpo6bQBDFG8JOL63o/c6xmnzTmPTa5Z3hKirhax8z7je+ppsIzpCmDReAU+YSUwmR1HxivoqN
 N6Fh6aIQ52CuBAWLtR8CtF4hzO5KgHaTyeQAzqeiTxbmWaNqo658DwIZr2hyOVuH5DztX/DUDHw
 PrdLLiFhMN44/mqeR1V7F7vv9ZA/myVfDDj+Yf+e+vZyH+r79BJheHogNJEClgfJDGb52V2T3ts
 8cMhoNaFusM2CCVyOerSX1P+hg2zQ==
X-Received: by 2002:a05:600c:4510:b0:48f:e230:72fc with SMTP id
 5b1f17b1804b1-490428ee268mr277815545e9.33.1779790320892; 
 Tue, 26 May 2026 03:12:00 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24EDFA00ACE56DB4A62D1E35.dsl.pool.telekom.hu.
 [2001:4c4e:24ed:fa00:ace5:6db4:a62d:1e35])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm36705494f8f.36.2026.05.26.03.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 03:12:00 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com, amd-gfx@lists.freedesktop.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Vock Natalie <natalie.vock@gmx.de>
Subject: Re: [PATCH 8/8] drm/amdgpu: restructure VM state machine v2
Date: Tue, 26 May 2026 12:11:59 +0200
Message-ID: <2389346.vFx2qVVIhK@timur-max>
In-Reply-To: <34270690-46ec-4212-92a8-8c782ab644b6@amd.com>
References: <20260427182723.1715-1-christian.koenig@amd.com>
 <2840173.vuYhMxLoTh@timur-max> <34270690-46ec-4212-92a8-8c782ab644b6@amd.com>
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

On 2026. m=C3=A1jus 26., kedd 10:51:38 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=C3=
=A1ri id=C5=91 Christian K=C3=B6nig=20
wrote:
> On 5/26/26 01:29, Timur Krist=C3=B3f wrote:
> > On 2026. =C3=A1prilis 27., h=C3=A9tf=C5=91 20:27:23 k=C3=B6z=C3=A9p-eur=
=C3=B3pai ny=C3=A1ri id=C5=91 Christian
> > K=C3=B6nig>=20
> > wrote:
> >> Instead of coming up with more sophisticated names for states a VM BO
> >> can be in, group them by the type of BO first and then by the state.
> >>=20
> >> So we end with BO type kernel, always_valid and individual and then
> >> states
> >> evicted, moved and idle.
> >>=20
> >> Not much functional change, except that evicted_user is moved back
> >> together with the other BOs again which makes the handling in
> >> amdgpu_vm_validate() a bit more complex.
> >>=20
> >> Also fixes a problem with user queues and amdgpu_vm_ready(). We didn't
> >> considered the VM ready when user BOs were not ideally placed, harmless
> >> performance impact for kernel queues but a complete show stopper for
> >> userqueues.
> >>=20
> >> v2: fix a few typos in comments, rename the BO types to make them more
> >>=20
> >>     descriptive, fix a couple of bugs found during testing
> >>=20
> >> v3: squashed together with revert to old status lock handling, looks
> >>=20
> >>     like the first patch still had some bug which this one here should
> >>     fix.
> >>     Fix a missing lock around debugfs printing.
> >>=20
> >> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >=20
> > Hi Christian,
> >=20
> > This patch regresses GPU recovery.
> > (Tested on SI, haven't had time to test other GPUs yet.)
> >=20
> > It hits the following warning:
> > WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c:635 at
> > amdgpu_vm_pde_update And then this error:
> > [drm:amdgpu_gem_va_update_vm [amdgpu]] *ERROR* Couldn't update BO_VA (-=
22)
> >=20
> > Please fix.
>=20
> Yeah that's a known issue. Fix is already pushed to amd-staging-drm-next.

Hi Christian,

Where is this fix? As far as I see "restructure VM state machine v2" is the=
 top=20
commit on amd-staging-drm-next right now.

Timur



