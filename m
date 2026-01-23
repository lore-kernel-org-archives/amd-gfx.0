Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE74D778B0
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 19:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3A8510EBC3;
	Fri, 23 Jan 2026 19:41:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oj/+fGK1";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0D4E10EBC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 19:41:47 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12336c0ae91so302821c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 11:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769197307; cv=none;
 d=google.com; s=arc-20240605;
 b=L5riGWwu2zZAKOd3CJd4PlwNDAN45hh46iW7idz3luUXC6GE+A7I4SNDa3sDmbW6gE
 3RubL5V+yM2Wn4Q9os3Mu0+tfHjYund+XDlf5TrSFOlf5YawCa0AASfh+aeQxofpmXiu
 I3vS1aF+9kVOYYamm2NdWVzzwBrqqVNkblEimadifN9A7tV5GetfoNXPzUnIlhsRB22t
 eaHEksm+PEFx3bApVmEKwe+4Fzyv/jpiEx6HhbjTxL4qwXcCgdxbJMBWxAMgTN3Bu8f+
 0qxZqMlNf3spHZ6hNkkdNF4DBgC9U1aCPf6LUAkUhHiGe0i2+mCYOh+SgeOOiTRITdZr
 nCmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fM4V7Qlttc81MqOWGsEEBwKdyqSfdIs8cEOQqgbpEkU=;
 fh=AkyE3waVMN3L/X7ODHNAONz/4BJQQqdQKE2F1tK6AfI=;
 b=ir1VRc/eCnlBRxcnlRZhIGEmh0XQ9yGSNykUsXVphhlEJHILzWqZ0MyjfW5suTwSOZ
 lZxrBvQfVCS6fGOBGRR7XdlZcOPkKZT9tFvDsDLRmrO/lGr8XZGJJQOs9WAup0gt7bcM
 6gMWtCDW4bRqU5JAueSa0G1raWUUwQrRcpR3h/R5k0hMEpe8GX8NSTypZWcfGg+uYQwD
 yHEpbUEHKs1ufxmiNQmju2kLrvFH4+QBzDQehT7l2LHQSbiMIIWG0vs3UzQiSUbbJQD/
 4AuhDMxHXGPJH4gdym+WwKIb41CE+ttWAiJd4j+PUUEABoz+Z+pCXuNFSf2DY6jq9xPE
 WqLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769197307; x=1769802107; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fM4V7Qlttc81MqOWGsEEBwKdyqSfdIs8cEOQqgbpEkU=;
 b=Oj/+fGK1TCPbVlt+k5gx6yxHaYtBO1bgxGFj+12s1ZHa8kNuC5wbeQC3VQcf571O1M
 kaSpIfgCmVfdh5ohwINbObtCA/7YbozPw4bDdM7qDGUNuMaYaMhdSqoUgp6vV37w/ARc
 IyDl22dnHT0i//TOh1sFX6rWAnUvDMmjh15vnBF5io9xWxxjODz1p6k04ADIEjXUBQOY
 IeKZwZNmXPpO1wfWjzOm5wLsoiFJ0JpmZ4lShHnM5kYt97k5g4F3GpvsrZsRsOv3GhJz
 1lcH+1dGjwaVrwmxUcOgTGmPJgI8ANrrgE5bKP+igVIIsMKlfZZsMhwW5QWX+n0FaYpc
 wu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769197307; x=1769802107;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fM4V7Qlttc81MqOWGsEEBwKdyqSfdIs8cEOQqgbpEkU=;
 b=PreZUK6uKrGzmO4USNFDkYCLrMyZkpPFvf5RWfXBA7k9MZEFAHfSKXVCXoDB8YYg9/
 9qggwr9Sd289Zh2O4jMsITK6LmC/3JekIKuhGDgAn9/iZoRJleER2p6jflAZsMnd/HmD
 kwyPDLDkRPgH/9U169AtcCc28X155wN1joSMT6OkxGHaPAlvzV3fXgK/adSRdaW38w5I
 NfChjASqB2lJf1wqpuDZqOYxKz/VCwkMilvaP+FJkNT8iuF5uxMxaHHsC4bbGhOZ/0ww
 KC4qcMWhpv2JT8hnnWnF0rLqEmQBroXmxElKFsI68N26tr0UHgAk8p859GyVVIehaoNM
 BtwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm83JIEtcXwaNFMNxpQsJIBI2nFUhokGfH9DklTJt/Skfb1OGznIcpvtOKtzMkh7+hhR9qUFVv@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwSmoPtX62NTdmXJUismX1FCcJmoyWSnJ4rI+Ublufahj3dPhms
 FWI4gg6GTxJfriv2I804+7QTfhKnPUDLES5W/sw+bmnkQJiB/wM/IeCKHuqjwPTYyYWIw4r4+Aa
 Q3OEpexHNJXtRqBlsj5Tl5BTccP8A9bM=
X-Gm-Gg: AZuq6aKNG3xZNx9BqScv0x75gAP0nhil+iVOB665kpgSMqQFLYHLcMoQRTVSGsS88mJ
 EkH4vgCs/VVev0fYepB1kpr13K/cL1TfcHuJVKv6cNzTvvuj7j3mOR2r9iA6pMjmvG88iqQ0KNX
 6sQTwZvqZuZKFhynoCuxdwV/aA0aQ0AazmrORgJTRvx5nwSTRY0rgsL53fvPtmNamrxuDJJEK+V
 cBinlsH8JvSBEHlxEoyndD9S32ea39lfjM0C0LF7NE+EYLGdK+uEjKaLmXAkTRSE1E7okaz
X-Received: by 2002:a05:7022:301:b0:119:e56a:4fff with SMTP id
 a92af1059eb24-1247dbffc9amr1029257c88.4.1769197306543; Fri, 23 Jan 2026
 11:41:46 -0800 (PST)
MIME-Version: 1.0
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
 <aXOJRWALUJLcGWqh@hal-station.localdomain>
In-Reply-To: <aXOJRWALUJLcGWqh@hal-station.localdomain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 23 Jan 2026 14:41:34 -0500
X-Gm-Features: AZwV_QgIlpADFNOPq37tQrn2l3FRpM0FiOTKdfkPdEEdOybAHxouyd6R1aMoyPI
Message-ID: <CADnq5_P0QUmKNHyrs5qBkE+EWh1-i5U0+vNRqvwPwqqQPfNqZw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Jan 23, 2026 at 9:52=E2=80=AFAM Hamza Mahfooz
<someguy@effective-light.com> wrote:
>
> On Fri, Jan 23, 2026 at 02:52:44PM +0100, Christian K=C3=B6nig wrote:
> > I can only see two reasons why you could run into a timeout:
> >
> > 1. A dma_fence never signals.
> >       How that should be handled is already well documented and doesn't=
 require any of this.
> >
> > 2. A coding error in the vblank or page flip handler leading to waiting=
 forever.
> >       In that case calling back into the driver doesn't help either.
> >
> > So as far as I can see the whole approach doesn't make any sense at all=
.
>
> It appears that resetting display firmware is able to put at least a
> subset of these systems back into a consistent (usable) state. Though, I
> don't have a reliable way to reproduce the issue that I'm seeing so I
> can't say for sure what it boils down to.

I'm not at all an expert on KMS, but I took a quick look at the in and
out fences in KMS, and I think I know what might be going on.  The out
fence is signalled by calling drm_crtc_send_vblank_event() from the
interrupt handler for the vblank/pageflip interrupt.  If that
interrupt gets missed somehow, that never gets called and userspace
will wait forever.  As a safety measure, maybe add a worker thread
that gets scheduled when the atomic commit happens and then in the
interrupt handler we cancel the worker.  If the interrupt never
happens, the worker will eventually run and call
drm_crtc_send_vblank_event() and get things unstuck.

Alex
