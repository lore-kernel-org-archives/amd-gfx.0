Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD9BC5DF9C
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 19:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B3B210E190;
	Mon, 24 Aug 2026 19:54:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eKAep9Op";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3CC10E190
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 19:54:26 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c167aa9500dso598966866b.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 12:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787601265; x=1788206065; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Hxvdx4txbbv/8ZSMg0yHCgDVIvaQhuzkC7iU4t4hZyQ=;
 b=eKAep9OpcBdIiVqs2LCcWeX8S9jag64+IKTLQMc6k+Cl09OeKG0FbRcM6HgZFraM+S
 m9WYhvqrOoXwvbjl0DbwpBzrx+2k9VpGvpoMtaeiHheAZ/gGOltLLO5HDK3MTbXvIqDO
 MA9EE4Xq5iW9tXAWgYsSkLVv61LIKnDpnqcbBty6xlOYE3/8I1vx7QtPreU45F+mVS1n
 0TjOhebCsjJX4dq/FWUxaThidcPJOzbZ8uYNOQ60aLAqsZtgiPTbY5TdsJKeZXs7Q3q8
 BPcKeqGd/guaJ3R508+doggwRyZr10U6dZbp16WSqaYENo9GMZqBZzBHqWg7/tUYv0c4
 1psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601265; x=1788206065;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Hxvdx4txbbv/8ZSMg0yHCgDVIvaQhuzkC7iU4t4hZyQ=;
 b=F7RCxSmzvsaSVLJAm0aNAHwH2eRim0fZ7SyGmFv4VQ0vDt8zIIxc4GfZQEaASaimQ0
 w4y6/1EkkAsxVIoKxdYyWgZ6Yo3BFdjINTr/6KTYs4BUsn3aJT7galByJm1lswNpjDi8
 Hgb7Jt574FzPFslIdp7QtOuf4+ywa7QbY/i+6hkcECrryk5DKcZuHKNu8iPSwiv2z0b5
 BZ/17crbe+H1/dvkDTERs5OwPbPtnQ14Orm6OI/k7uI3ZYqC14QP+Bim3mMVbb4ZfXQb
 d5E+keua2V1Xeo2COHbq/HJ5AHdiFg0E38NP+ypZbJH1YsKTLE6gcAoz+iGGePoddzrf
 FtWA==
X-Gm-Message-State: AFuF++nb9re41ULHkc3HMVUSpp8OHb5NazDsr1FjouJCs7Jur9AgxLD0
 44w7izMqVndSznOibWDx0jDyytgCUC/dlCRZjwkzuNpvt4QkAT03O86O
X-Gm-Gg: AR+sD1166D05EvTIxyTSaTbOg8iIfzhcZGpovQYKz9FSgsZ4WqyJEWADGAgVJO50Fv3
 bmD9SXhL5feD2T36LBlqhXtquj9Qj0/JFgLx/K8qIVGV6ZE9bKjILj8lotp1RC2uotbVvPVxUM/
 6Q2ww19ZmfYEEKGedcSRoFk//D9KyHMr6tVV6UQSkBUfdk4e3+PCGvxKPG4ubseyqgReEvyis4j
 krbyqH6SAwBfde6nmnwAX55Y6j1su4rF9Pstcobx3F9zF7Zeq9KresKI8xqNURGfqWOCbls6b5j
 qsyhQPZB7ssPxw8tCvvv+0cbB+SOoDyMbSRtLDgcjpgDdZDt8vUIzub/TIrSQLlRhXJeOmSxUkp
 jxv2OZCPkKwKlcDp6JHPP0zcCrWeSQbO1YQ34yBrt2RTJmQ/gGidDsr62MIJdrHk19YoW5KRbjD
 U/r14I8lTlaq6LP1wLqlY2IyOjQxmTRosLvWwsh4lVoA/53AhuNm1K5DO/dPeoVMYdPsCom00In
 quW+F77mfrGRT19ltVnxys6L+oQ4BMz4SfFRKCmsRrDcw==
X-Received: by 2002:a17:907:b048:20b0:c20:1c9c:b36f with SMTP id
 a640c23a62f3a-c246a4b154amr2287380566b.8.1787601264909; 
 Mon, 24 Aug 2026 12:54:24 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B960C.dsl.pool.telekom.hu.
 [94.27.150.12]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249629a901sm1574464966b.25.2026.08.24.12.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:54:24 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Petr Belyaev <upcfrost@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Subject: Re: [PATCH] drm/amd/pm/smu7: Don't send VddC_Request on CI
Date: Mon, 24 Aug 2026 21:54:23 +0200
Message-ID: <1yPzq_47RDeA43NJ6QXmAg@gmail.com>
In-Reply-To: <CAKzDyZvprPt9QmsDuuqVcvisz1KLKMfmWQrpMtcUWnXeOn8MEA@mail.gmail.com>
References: <20260824144714.182835-1-upcfrost@gmail.com>
 <GoS-FsT8QACGf_8gWuUlnQ@gmail.com>
 <CAKzDyZvprPt9QmsDuuqVcvisz1KLKMfmWQrpMtcUWnXeOn8MEA@mail.gmail.com>
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

On Monday, August 24, 2026 6:11:48=E2=80=AFPM Central European Summer Time =
Petr=20
Belyaev wrote:
> Hi,
>=20
> You're right, and I withdraw the patch - hadn't considered that gating
> it off would regress the systems it was added for.
> Apologies also for the M380 claim; I thought it was VI from the commit
> message rather than checking.

Unfortunately, it is difficult to find information about which graphics car=
d uses=20
which GPU exactly, and the information online (Wikipedia, Techpowerup) is=20
sometimes wrong.

> To reproduce:
> Stock 6.18.41, Bonaire XTX 1002:6658 rev 00 (XFX 1682:7260), VBIOS
> 113-260XT-HY12832-D5-2G-10, SMC firmware 11.35.0 from bonaire_smc.bin.
> DC is not enabled here (amdgpu.dc left at the default).
> I'm getting roughly 40 "failed to send message 15f ret is 0" messages
> per boot, ~1.9s each.
> gitlab: https://gitlab.freedesktop.org/drm/amd/-/work_items/5678

Thank you Petr. Let's continue the conversation on the GitLab.

>=20
> On Mon, Aug 24, 2026 at 5:07=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof=
@gmail.com>=20
wrote:
> > On Monday, August 24, 2026 4:47:14=E2=80=AFPM Central European Summer T=
ime Petr
> >=20
> > Belyaev wrote:
> > > smu7_upload_dpm_level_enable_mask() calls
> > > smu7_apply_minimum_dce_voltage_request() unconditionally, which sends
> > > PPSMC_MSG_VddC_Request to the SMC. CI SMC firmware does not implement
> > > that message: it is only defined in smu7_ppsmc.h, tonga_ppsmc.h and
> > > fiji_ppsmc.h, and there is no CI equivalent. The SMC therefore never
> > > writes SMC_RESP, PHM_WAIT_FIELD_UNEQUAL() spins until it gives up, and
> > > every call burns the full ~1.9s response timeout.
> >=20
> > Hi,
> >=20
> > I'm sorry but this is wrong.
> > I added the VDDC request specifically to solve an issue with a Bonaire
> > GPU.
> > That system will boot into a black screen without requesting a high eno=
ugh
> > voltage for the display engine. This patch would regress that.
> >=20
> > > Nothing downstream notices, because ci_send_msg_to_smc() returns 0
> > > regardless of the outcome. The only effects are the delay and
> > >=20
> > >   amdgpu: failed to send message 15f ret is 0
> > >=20
> > > in dmesg. On a Radeon R7 260X (BONAIRE, 1002:6658) this is 40 messages
> > > per boot: 32 during the boot-time modeset, which becomes ~59s of blank
> > > screen, and 8 more on every DPMS wake, adding ~15s before the display
> > > comes back.
> >=20
> > How do you reproduce this issue, and on which kernel version?
> > I've tested this patch on two different Bonaire chips and a Hawaii chip,
> > and haven't seen this error message. In fact I am running an R9 390X
> > right now and I don't see this error message in my logs.
> >=20
> > > Commit 0138610c1413 ("drm/amd/pm/smu7: Fix SMU7 voltage dependency on
> > > display clock") extended this feature to CI, which the previous
> > > implementation had deliberately excluded -- the old call site was
> > > guarded by pp_table_version =3D=3D PP_TABLE_V1 with an adjacent comme=
nt
> > > reading "TO DO for v0 iceland and Ci". That commit was verified on a
> > > Radeon R9 M380, which is VI, so the CI path went untested.
> >=20
> > The CI path definitely did not go untested.
> > R9 M380 is Bonaire (it's in an old iMac).
> > You can see all the details here:
> > https://gitlab.freedesktop.org/drm/amd/-/work_items/3425#note_3338643
> >=20
> > Best regards,
> > Timur




