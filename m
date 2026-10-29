Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37106606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HriQq+W5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B383810E1B5;
	Thu, 29 Oct 2026 21:39:23 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A575410E1B5
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 21:39:17 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-36a10095f3aso14888eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 14:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793309957; cv=none;
 d=google.com; s=arc-20260327;
 b=jpGgvVEoVFFzrgAKd6kxhWEaFL/WB1YpIqYyfNV+JM+aZGm3Vfl7GPUqPUPm2d02hu
 06AZupUNvJubrZKIBLXay6tJ72y08UyZILxOXq12jtHMyFcbi5D7tx/wkwS7MyEPGJN8
 J3DwG5gozhiOnCmwM/8xM2jRaErGGGPKCLndB8X/GY4mtxcpjsU1hfyUL2oppzpdZBQu
 OYCUos85rl/dBNrSL9gEyTt8zJF6wFAdMXeOMbVdCXY/2xgHcHFyKinmXe/mdk+PRIG9
 ddNq3hR/rLsgHmYIMCV0iu5jj/OyVuEduDqRZjy5iB94XvtESPY5D3+DxWOY3V5eET5h
 YLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zkrnRdvSnU/Zay+uCxXdk+hxuwoOLZQUn0KaZqCFt6c=;
 fh=izUnR/BGWTJiF4grqvdHPNgQiNKoXgaxtutSNNXHj/M=;
 b=JZazLxMWi8dKz2IBdzAJQcT5RFtu1PBMtfI2psb81w1NIhNt86PiCqt49jOqPo7ccw
 W7M/Ddt3nY0LUuMw08PWN8JUCvSs0y9FvOXdaulrJ6zz/f2Q+R/zdYlYB/QFbYM0sj48
 JpG1D5z+mva5R90maE4MX9R5xv5h5+DFh7lcsV9icghzepsB0CiFNi2ZwY4dnhENMIwh
 wxayHj4HjFuZuLM6pPtwR47uFwEtz21PPXAaLzmD49FZivRAkZzoMnzhlEof/V3W0VAM
 liTfGHKoCMA0DjB8Zu+5Jhk6KqpYDecYfV2yHNaVLrbJLvZk/x7GjhoCwU+4szA/C7q2
 5JbQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793309957; x=1793914757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zkrnRdvSnU/Zay+uCxXdk+hxuwoOLZQUn0KaZqCFt6c=;
 b=HriQq+W5sw5tSslvlhcyd79VwYlkKXExl5Md9Bo8dMaiGm/ziCRFlDIFfOiHmoIq7Y
 xG11lJDouVsqdmNtmzg0c7Q0apNA3mKuH0mZ1wPRHDMdhxuq/rk4QMfQHtKBp3cL/rrO
 55cD9Oor1vsDLwH6T/v+hqggxGFNt5zB4u/Z7AUlDuCXI7rMW71pdwXLTBz0f10KK7TJ
 0pM8kr7ESMEfBc6VW9N+DWUss1qipdxK1/ICz/iEq/sLC2qZpeniq3oIIrQL80zSM+b3
 L5SAM7YqTIH2fXmmxisvkrElGSoL+QUMV/7XmUfp65UVqr+uLKS3vtzc5f6GGpRLjSBs
 3N0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793309957; x=1793914757;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zkrnRdvSnU/Zay+uCxXdk+hxuwoOLZQUn0KaZqCFt6c=;
 b=PE2M7V9mAYHPdgWMliiKFL8eK5I+40WndNKWHPxWQU8gzrvPHmIsw0thx8LbtMcA+i
 xVRiRJxzyq2xU6bweKWHAGAE8nOLT+dSXEH+rXzCA46Q7UpkJ3ehSNVMp57ZrsODrsdR
 uv3ouIHLacD7rvtGg5kTXGzmlv2YGAOD7qmdQfEQ0EAOtWPdajG06meg90IxHVQ6sM00
 n7DyLamSwa9ZUiBiCbNwdDLk127Z1oFbR41ikZ/Mo3C8MpcLsr2C45WcTH6gAVHKRmsp
 E+W4aePhrM7l3id8peeVciaPzNRz4sm0rlu1loE+GDftzE06elIvxEPlb4eO6wUuZCR3
 F7lg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfEEJhkIVOPJ5wrwE3rZTzmNNN7zyKUf58oxeGCfRlKq9v2L7693a9QJsVZYco2gLktbK6cLrK@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLvox9EckDz87QK9prUyIemp4zV28DUWj4JT121zk5H32XLP7ZL
 7FOdfpOWgVsxxIDaQfhu/tFnAqOniKRX5fl0TXHTW5JnrCA7WHZtDbw+pXcgZdn8G3cLCK2sBJH
 rrMEk0XETGLz3ftvNDt7BNu+ZCigKA7c=
X-Gm-Gg: AYBFou2rhTEriAvwJ3VpKi/Bp2HnaV3t7vajX+uY9k4RnKqhK0zzaoOspRqS4jFEsKQ
 SsPvqMVEY5OD76XOXIV1kS6uHOOdu0fN3ZQn49llqiz7hQT9a6vq89Blb++A/sqrisYee22bBjz
 gDFL1C6xOel4K3SlycTR8kTK4OidkvlCxlpKhrb3tjJc97MR8j0NzcNHHfYwhVfkbpSioWhEVEt
 51KCEGjwrOYXldQQw+9aDrFjdwvsMIykQYfEw6LYf1VWLIVwau1vfdVglm11Yv2hISMaZeu72Xn
 z3WpBfXB1NPpbcniVPL/6KlaZ6b9EqYcfYM7qheOVy69SOwl8CaZhpZ3rN8U2sZLVt6LpcQ8NDy
 wBY/KsC9cRksMq1OeXOpE+KEBdJfQOwlILCg1ZRQD+b9zImv0q5WBGiHwiruQoCK+RaUVvffRHr
 MuI0KdcX8ytxfymNqZ4NZRQB9f
X-Received: by 2002:a05:7022:eb46:10b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-1ac4fd01362mr764952c88.0.1793309956732; Thu, 29 Oct 2026
 14:39:16 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
 <MW4PR12MB6803EF32D2E8C32E163BCB638E642@MW4PR12MB6803.namprd12.prod.outlook.com>
 <CAGjg405_42ftMLqZ_ttmvbgFLtUZou7vSsxQCo4usUgijes0cQ@mail.gmail.com>
In-Reply-To: <CAGjg405_42ftMLqZ_ttmvbgFLtUZou7vSsxQCo4usUgijes0cQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 17:39:04 -0400
X-Gm-Features: AclHuK-s99YJLtDsvu1d_dH2NtQb3-6xfVyVT0gtWhF5sjgGQwzviVNNIfdkVds
Message-ID: <CADnq5_Pv0wkPx9AzooUf=dyWgQuneMc6K9-qcT6PW53Gg4L5rg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK
 (VRAM overclock)
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC00LvQvtCy0YHQutC40Lk=?=
 <shidlovskiyilya@gmail.com>
Cc: "Feng, Kenneth" <Kenneth.Feng@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Li,
 Sun peng (Leo)" <Sunpeng.Li@amd.com>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 5:01=E2=80=AFAM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=
=B8=D0=B4=D0=BB=D0=BE=D0=B2=D1=81=D0=BA=D0=B8=D0=B9
<shidlovskiyilya@gmail.com> wrote:
>
> Hi Kenneth,
>
> Yes, confirmed. The v2 series is based on amd-staging-drm-next at
> 77f548b12 (=E2=80=9Cdrm/amdgpu: keep PRT mappings off the VM state lists
> again=E2=80=9D, 2026-10-20), which already contains Kevin=E2=80=99s =E2=
=80=9Cpreserve
> committed OD features=E2=80=9D changes for SMU 13.0.0/13.0.7 and 14.0.2 (=
the
> user_od_feature_mask handling that patch 2/3 relies on). The commit
> hashes in the public branch differ from the ones you quoted, but the
> code is the same.
>
> Thanks for the review!

Can you double check that you sent out the right patches?  This series
doesn't seem to apply with the aforementioned patches in place.

Thanks!

Alex


>
> Ilya
>
> =D0=BF=D1=82, 23 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 05:31, F=
eng, Kenneth <Kenneth.Feng@amd.com>:
> >
> > AMD General
> >
> > Could you also please confirm this series is rebased on the below two c=
ommits?
> > commit 5cd40ce699014025614140294b8e3b7a847e6472
> > Author: Kevin Wang <kevin.wang@amd.com>
> > Date:   Thu Oct 15 14:02:09 2026 +0800
> >     drm/amd/pm: preserve committed OD features for SMU 13.0.0/13.0.7
> >
> > commit 5a3833e7dd532ac02b4747d1b0d717dd49e87aa6
> > Author: Kevin Wang <kevin.wang@amd.com>
> > Date:   Thu Oct 15 14:02:31 2026 +0800
> >     drm/amd/pm: preserve committed OD features for SMU 14.0.2
> >
> > These two commits have the related code modified for another issue.
> >
> > With this confirmed, Series is Reviewed-by: Kenneth Feng <kenneth.feng@=
amd.com>
> >
> > Thanks.
> >
> >
> > -----Original Message-----
> > From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
> > Sent: Thursday, October 22, 2026 4:09 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>; Feng, Kenneth <Kennet=
h.Feng@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexande=
r <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> > Subject: [PATCH v2 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK=
 (VRAM overclock)
> >
> > [You don't often get email from shidlovskiyilya@gmail.com. Learn why th=
is is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > On DCN3.2 (Navi31, RX 7900 GRE here), raising the UCLK max through OD_M=
CLK makes the display flicker (full-width stripes) and eventually hang the =
whole system, if the current mode does not allow memory P-state switching. =
DC reads the UCLK DPM levels from PMFW only in init_hw, so after the OD com=
mit it keeps asking for the old top level as UCLK hard min ("set UCLK min =
=3D max"). That is no longer the top level, so PMFW switches UCLK outside o=
f vblank.
> >
> > The series makes DC re-read the UCLK levels (bounding box and WM ranges
> > included) after an OD commit/restore that changed UCLK, and on resume a=
fter the user OD settings are restored. It also refreshes the SMU driver's =
UCLK DPM table, so pp_dpm_mclk shows the real levels.
> >
> > Bug report and review of v1: https://gitlab.freedesktop.org/drm/amd/-/i=
ssues/6009
> > (v1 was posted there as a comment, not to the list.)
> >
> > Changes in v2:
> > - Only act when the user has customized UCLK (user_od_feature_mask &
> >   PP_OD_FEATURE_UCLK_BIT), instead of on every OD commit (Kenneth).
> >   PP_OD_FEATURE_UCLK_BIT is ASIC specific, so the check is done in the
> >   smu13.0.0 code, which sets a flag that the generic code reads.
> > - The SMU patch now comes before the DC patch, which depends on it.
> > - Rebased on amd-staging-drm-next.
> > - Added Leo's ack for the display parts.
> >
> > Testing:
> > v2 is build-tested against amd-staging-drm-next. The hardware test is o=
n an equivalent backport to the Ubuntu 7.3.0-9 kernel (same code, plus a sm=
all local backport of the user_od_feature_mask tracking, which Ubuntu
> > 7.3 does not have yet).
> >
> > Hardware: RX 7900 GRE (Navi31, SMU 13.0.0), 5120x1440@144 (DSC, ODM 4:1=
)
> > + 2560x1440@100, UCLK OD max 1124 -> 1300 MHz, toggled via LACT.
> >
> > v1 results:
> > - On OD commit, DC logs the new max UCLK (1300 MHz). pp_dpm_mclk shows
> >   1300 as the top level, and the current level stays at 1300 (20/20
> >   samples, no drops to 772).
> > - About 4 minutes of heavy window switching on the 5120x1440@144 output=
:
> >   no stripes, no hang, no amdgpu errors.
> > - 3 OC on/off toggles: one short flash exactly at the switch (memory
> >   retraining during scanout, expected), then clean.
> > - Same scenario with the stock module: stripes, then a full system hang=
.
> >
> > v2 results:
> > v2 hardware test (same RX 7900 GRE, 5120x1440@144 + 2560x1440@100; v2 b=
ackported to the Ubuntu 7.3.0-9 amdgpu, LACT applying power cap / voltage o=
ffset at boot):
> > - boot and login with stock VRAM: no "DC memclk states refreshed" at al=
l, so
> >   non-UCLK OD commits (power cap, voltage offset) no longer touch DC; t=
he
> >   short login flash seen with v1 is gone;
> > - VRAM OC on (OD_MCLK 1300): exactly one refresh, "max UCLK 1300 MHz";
> >   pp_dpm_mclk top level 1300 and current level 1300 (12/12 samples);
> > - VRAM OC off: exactly one refresh, "max UCLK 1124 MHz";
> > - desktop stays clean, no stripes, no hangs.
> >
> > Known limitations (unchanged from v1):
> > - The OD commit itself still happens during scanout, hence the single
> >   flash at the switch.
> > - Only DCN3.2/SMU 13.0.0 is handled. Other ASICs with OD_MCLK probably
> >   need the same hook in their ppt code.
> >
> > Ilya Shidlovskiy (3):
> >   drm/amd/display: dcn32: rebuild WM range table when memclk states
> >     change
> >   drm/amd/pm: smu13.0.0: refresh the UCLK DPM table after an OD_MCLK
> >     change
> >   drm/amd: let DC re-read UCLK DPM levels after an OD_MCLK change
> >
> >  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++=
  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++  .../display/dc/c=
lk_mgr/dcn32/dcn32_clk_mgr.c  |  8 ++---
> >  drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++
> >  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
> >  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 ++++
> >  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 +++++++++++
> >  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++  .../drm/amd/pm/=
swsmu/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-
> >  9 files changed, 127 insertions(+), 5 deletions(-)
> >
> >
> > base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
> > --
> > 2.55.0
> >
