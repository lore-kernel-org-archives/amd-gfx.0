Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FE5D2FEFA
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 22:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9089010E5CE;
	Tue, 27 Jan 2026 22:57:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CPYGo4Qf";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C1610E5CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 22:57:48 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b718524994so26081eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 14:57:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769554668; cv=none;
 d=google.com; s=arc-20240605;
 b=D0PgIN1/qWVpPyRJMTB91EWpOA68AFmmh/AqQ0FFoyJHJaLJowKqNqzpVi60dlJA5t
 fB6bDckHzPYfPqal0BXF7Q5HmnypeUNbID76ySLoE0elUysCXuj0g367a+xQHxrSEdSH
 Sn3swhDK56E2ZYpu3yS4kvuRyIKYZmRsscp1OoyVTEDCSvt27exODqmFubl9WehKoja7
 jdORlgflE6297vqzPIIOEQ871+QM1futgx1NGrxdkK3L2g5/O+2G2fMps9QS2NUECsHr
 efinXWnh5V4eCzaOyR1FPltyiKpcy+8AfaVqxwn5Ak/v7/K3QYrjKKfDzm0PQWc3BJ/m
 mF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dastR+txnDmXRBbBVeuAN64jXG1aCHDH1SoB/eaxcuI=;
 fh=WyFm/+CjlR0xHPlF9H6ggEG52xaMECQG86wsp75243o=;
 b=LgtVjarhq5n3UM5FHLH+ANdozHeqsdHOvyQMB62uuE3LhrLOdYsx8RhE3rxEcdPqYC
 DFvV/D5lJ+nPC0HFamk6cmIlxX8f8Jb46k1vHnB3MKjKyZKeO+7REYVGG+7/B9nIFHTO
 2ogOdLRa3v/5QpN5vxTocnX1/XXbYXWtd4Obb4giC5ygLqQBznPe8es75c8vd7b4TN3G
 EuMpZMC0+SstuPoNU2QTQk5KbD3jFNdGSM4cZKSjhREhLMUCEblxSv5dN8tcgSOunE5B
 rFSQ3r49u9z401BNPi4wbnQTSExTQce7N2k5gYpRw16kiUTiHLHxiQHElg9wKVVSy8J6
 pBtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769554668; x=1770159468; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dastR+txnDmXRBbBVeuAN64jXG1aCHDH1SoB/eaxcuI=;
 b=CPYGo4QfcML4tFJJnHYsZfBf03gbMOftuH4rXHGM9faG1SNEfRt5jkYIFxi7H1nk7D
 zzX4VcSafeFhk81TC8RAgZAsqEoJjYtvlp1Yq1uDRNmo65dmneb+nqzZe2NrbNlN7RJ0
 yuNkiXuFqg9bHJSmKmaqatt/pIMjOdPNXRNTnbPR/P9ugbj1hcoG8ui4Rcg5FWWrjQCZ
 GTobwUtEKv3jsHQSvkTFPztou2BhTzadunOV4LozNCFyPxigHFVyPVnRyBPrO1QKeL4b
 v3HwyHpzmUgIrdSOJWfWd9sQKZ2FonB2Wb1Er9rjtG3BN2Q0Y96efGcVJl4yiMlaOTWh
 5Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769554668; x=1770159468;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dastR+txnDmXRBbBVeuAN64jXG1aCHDH1SoB/eaxcuI=;
 b=hdrtPeJwjQyKRYAedjqYLLPizAa+8Nsz7szfOXdT+9i5KlRYgzL8Y3F06dlwxttTnx
 059IX2Pxtpgu8pVj0yHcjAdmSuYapg0rSXMJPxf7G2GUYqywTnlXXha8ABaVtmNleBzY
 A4JLhvKk+fmc2xItmL0hiJbRWuWZtel0/N6MT2eNAvx3XzORvW2LZGf4K017k0LJFctE
 6qBwp5je6zL31rsyy2mu7DzCFhUtesEnhb30NeTajR4bFWv5JKVajDldJTyVpKSBoXhm
 UmTMPaOjQcLs3E0umBFYmVmc4PtMgMqNjynzzG9msvsruj3HGUh2VM7J6s+neZILzKoG
 mtpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS+34L3UQ6yWHtO8KFWphlY4bWtqQkiy5X7kQ5ispe5PcLPA5rVOz3D6O21DQAFHeDirKyhvme@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxspk2mFY5hTGZEj4kknW3jYp9QcDHOQp+Xlczz++DTnIlc90hk
 Fb5+MDY2Qod2EAn45fVhNuhQA/CX+3ta3zm7fbCVALw/3lowSMKCmpQ3+GlcP8r0Hr27zfVPtzJ
 LWDyueobrYSVXbXCLLazst/a6HKYXDOA=
X-Gm-Gg: AZuq6aIJKWs5LyNHXdcZNWX1wlj2ZpH2HCtxyM7t7OWQ85Eo9PaFjuRwTOJorcC6nx+
 cdOv8eYw4BQozAWcbU2IjI5LLST01wJFFUMTXmTZRoYWj8ts2O6ZmoMBgrY6E70bohbux65PvBp
 F1zfEP7w1P4Vj3oDzrIGxMcF3EwNzb3ncTQk/4V7MZmcrSnlRDs2WyfTmaDKc0A4AHstG+fImJ5
 NrhiawC81Gy8qjxKAuY8zhG/86t0kxfFHiq/5JnYKqNirkI7UZukAXGgk+CCOrzNo34TAmq
X-Received: by 2002:a05:7023:b02:b0:122:8d:39d8 with SMTP id
 a92af1059eb24-124a9a0f8afmr118232c88.6.1769554667696; Tue, 27 Jan 2026
 14:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
 <2349754.vFx2qVVIhK@timur-hyperion>
 <a8b972be-7265-492f-9855-cdec94a0e0dc@amd.com>
 <aXUQKSJGkz7nzHJ4@hal-station.localdomain>
 <CADnq5_Ob8yiivco+szanSiXuRwdAu4xHMe=8OQSk+Ufqykgobg@mail.gmail.com>
 <aXlBx528d11lMJvl@hal-station>
In-Reply-To: <aXlBx528d11lMJvl@hal-station>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 27 Jan 2026 17:57:35 -0500
X-Gm-Features: AZwV_QjN7agKnLyYKe7Smi9fxSFoYzyznSj_J6HKhoMFANGlUSc0gJvc9OHavDM
Message-ID: <CADnq5_NXd7HYipJTW_riwQDjrZ7S-PW7oFJ=C94_FGAAesV3kA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 dri-devel@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Tue, Jan 27, 2026 at 5:53=E2=80=AFPM Hamza Mahfooz
<someguy@effective-light.com> wrote:
>
> On Mon, Jan 26, 2026 at 09:20:55AM -0500, Alex Deucher wrote:
> > I suspect just calling drm_crtc_send_vblank_event() here on the
> > relevant crtcs would be enough.
> >
>
> Seems like an interesting idea, though I would imagine we would still
> want to attempt a reset (of some kind) assuming that the subsequent page
> flip also experiences a timeout.

Is it actually a timeout or just missed interrupts?  I'm wondering if
some power feature races with the modeset and causes the interrupt to
get missed from time to time.

Alex
