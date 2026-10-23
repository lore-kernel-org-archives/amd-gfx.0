Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986D606A31B
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sVTbbaPY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12AF010EC99;
	Mon, 26 Oct 2026 08:43:36 +0000 (UTC)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B500C112A30
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 08:18:40 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6af8620a7d2so674311a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Oct 2026 01:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792743519; cv=none;
 d=google.com; s=arc-20260327;
 b=Kv3SP6K8BPzXJCoUVpsUCPu7yzJT5o7EzKdLpvMNki5zEzoJy8p76AmnhpnATzZA4b
 qOrqSon7jG5EYh03ZN375LNZ5LfuDnwsE8CTA2zChgqC5m+f++84Yl8WzG3452aw1Qsy
 xurq7+Qv1xOpcazzOmIBictLX7r54oTOQRNta3w87V5SnJxALyYDDYC3r60cezp4Wk+1
 ijQgVDb9JnZDacBtCAvQ8J2YIpPvzp7/Y/LeAJSm3FXRLE5lHdLI47bvKF0E6CAWFDbh
 HT8aLomE0Ip/QWhz7wlUuJEmzUIoYqXoVDW1GpzIEt7ZzNzPWGuiQGuxKqEkQdt19umF
 dAJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=juYsWNTs/9xa0MNCmCG9MckMTuP8cxPKiXqsXWxom3U=;
 fh=DYBgBcxJz8mp+cKTIU6yPY8dDh30nRhmXbE39i8q5A8=;
 b=QQQjtoz45M72Ofh+mT4jOPdGTjFrc5QhDJbGOQJ47lZ8nGXkUU8ZBoP7RA2WCALjv+
 5gKSoYxeHfbw4Mavp3O2i64Byv702uxpQQqKH3EfzX0TvoIv6Dp3XnS7F1vSQW/bkv4X
 p59SNK/8oSIaox1RcjQTtSSRXN0JuY0ZAeIsRalTQtCk51NJUwC91YPCB0aRd8FVibFR
 BEYwFxkfznLFYSwzscNUMmIoY5fLh8FPIWEXt/RomFnpT0bpo7ShepERL5qS8L5vptdm
 MFrZB+d2yBjiSsucLVXiWBeXcVf14l36y1RV96sd/9IjkaOO6jt+XjfZh8AVyQHmpRu9
 Iv6g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792743519; x=1793348319; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=juYsWNTs/9xa0MNCmCG9MckMTuP8cxPKiXqsXWxom3U=;
 b=sVTbbaPY8pSB9po8CgNqejKIqu8UvBQVsnGmIopxvQ9g3ObCxkoWHjnQYembpvSgOu
 AoYoErxxQH3THhPUZyMQDHna0AJCxt4mitHzdVOgqkHB1isFNfkEu3n17lkr3pB750QH
 2l0JiUE77lAlCcr7cCftDjpcMrAepVDE5vFGAtEDME/CqUoBRVgYvWfdElVThqNh+4cJ
 USgKVBtYnTsLenVXK+LZ87B0TuNeQbo/LTEXSTIqXoqrpwUKiScLFUAPc2ZNXzOi9N9D
 DiZ+KUXKGmaypYYsTRChqz/SXoFgffx2F2KHRnOq43Rpa+zevJdXU5tuWagbExj6yHt6
 Nc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792743519; x=1793348319;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=juYsWNTs/9xa0MNCmCG9MckMTuP8cxPKiXqsXWxom3U=;
 b=NflAFsYaKOw9UbZBJUJhIjSjYX5jX+Lj1TxKQpdEU5s8ySwWPJqoVv+2kTiiG27+YI
 4q70ui2fSX51ODlGnvH47TVCsKZW37Db4JCJM70T5EV8XCyF8H9mkp+Tgew+ylO69hP3
 gaE0VNf9mBeLE8rbaBh3wC4SRTJh4mjdWX26yJF0J53XO/zM0xGoWYiWijox82JBlOMh
 7gw7el9wJmm7Qz/LPvH2WrLYr2k5QwAhjwTdXWxyQkluFGOqdo0XcrcppeJ53bxIytPa
 NosfQuYJAd/uPLgchF/cO+OYjh+bF5+EF3RvAin4Z5IEghC/uqLPP+kSIUxcO2E8B4uG
 fasw==
X-Gm-Message-State: AFq9FYLAPy7fFTs/xBX9riM2Zw6QPsed8BG7XSEJYJdY8bjDvWQIvwhv
 5gW+eU/uO0zwBXZnOTtL2zeQjqjzyBIhrNP1GJYuAfNfzN7SN937rBzOfGZ3Vo5kf3l3DpvYXHt
 ahkFfRQfbVm6TsP97uX9pKLSlFwrOHtc=
X-Gm-Gg: AYBFou0+h7J5d/vBj8ZhxVMOSW2CDsnEXbHtaSifnYvrJovWrOhp3fCzsTj22r1ymos
 A4RtKoo5RqOUFdfZ2rMdaAeH8KBtwxYy6D1R4714mCbugrgFDbMCSxU8pOiDMLKQ30eF9nDOVhn
 0iEgQpkjVcKHRYf7SJgL+NBJ/phh10S6/0TacaWNf5Ki12i8bBD33ajFTaH+ughN7YpeHIwsSyG
 MEugQ835xhWMhwfrUp0AjOC9sMiAitrxDtzshLCbTd1FH2M5lkiSyigAKH3zOOuoh9lW+twC9Ut
 Mr1BzcNPX2EqXvyH+MlWurbzu3xEbaWokFSTuaPm09GpYONOwduLOWlNdagiKRfcB9Pqd9NX5nm
 UxOgQs7pHVFMB7FyHs344aGRwPWrT8Z+hjJjq4rJr1WhmjYcZ7fXneYJ68hqF7CS0sPvYdc0JJf
 C9NTvrta5hVUjfI80=
X-Received: by 2002:aa7:cf14:0:b0:6b1:b97b:745 with SMTP id
 4fb4d7f45d1cf-6b432bd60bcmr2074924a12.29.1792743518717; Fri, 23 Oct 2026
 01:18:38 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022080925.13994-1-shidlovskiyilya@gmail.com>
 <MW4PR12MB6803EF32D2E8C32E163BCB638E642@MW4PR12MB6803.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB6803EF32D2E8C32E163BCB638E642@MW4PR12MB6803.namprd12.prod.outlook.com>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC00LvQvtCy0YHQutC40Lk=?=
 <shidlovskiyilya@gmail.com>
Date: Fri, 23 Oct 2026 11:18:26 +0300
X-Gm-Features: AclHuK__g7onYIWK4YCVcw355RZZbfTaTqNc_gVetLSql-wtgtDInFdW9dopA7g
Message-ID: <CAGjg405_42ftMLqZ_ttmvbgFLtUZou7vSsxQCo4usUgijes0cQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK
 (VRAM overclock)
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, 
 "Wentland, Harry" <Harry.Wentland@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:43:34 +0000
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
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Kenneth,

Yes, confirmed. The v2 series is based on amd-staging-drm-next at
77f548b12 (=E2=80=9Cdrm/amdgpu: keep PRT mappings off the VM state lists
again=E2=80=9D, 2026-10-20), which already contains Kevin=E2=80=99s =E2=80=
=9Cpreserve
committed OD features=E2=80=9D changes for SMU 13.0.0/13.0.7 and 14.0.2 (th=
e
user_od_feature_mask handling that patch 2/3 relies on). The commit
hashes in the public branch differ from the ones you quoted, but the
code is the same.

Thanks for the review!

Ilya

=D0=BF=D1=82, 23 =D0=BE=D0=BA=D1=82. 2026=E2=80=AF=D0=B3. =D0=B2 05:31, Fen=
g, Kenneth <Kenneth.Feng@amd.com>:
>
> AMD General
>
> Could you also please confirm this series is rebased on the below two com=
mits?
> commit 5cd40ce699014025614140294b8e3b7a847e6472
> Author: Kevin Wang <kevin.wang@amd.com>
> Date:   Thu Oct 15 14:02:09 2026 +0800
>     drm/amd/pm: preserve committed OD features for SMU 13.0.0/13.0.7
>
> commit 5a3833e7dd532ac02b4747d1b0d717dd49e87aa6
> Author: Kevin Wang <kevin.wang@amd.com>
> Date:   Thu Oct 15 14:02:31 2026 +0800
>     drm/amd/pm: preserve committed OD features for SMU 14.0.2
>
> These two commits have the related code modified for another issue.
>
> With this confirmed, Series is Reviewed-by: Kenneth Feng <kenneth.feng@am=
d.com>
>
> Thanks.
>
>
> -----Original Message-----
> From: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
> Sent: Thursday, October 22, 2026 4:09 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>; Feng, Kenneth <Kenneth.=
Feng@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander =
<Alexander.Deucher@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> Subject: [PATCH v2 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK (=
VRAM overclock)
>
> [You don't often get email from shidlovskiyilya@gmail.com. Learn why this=
 is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> On DCN3.2 (Navi31, RX 7900 GRE here), raising the UCLK max through OD_MCL=
K makes the display flicker (full-width stripes) and eventually hang the wh=
ole system, if the current mode does not allow memory P-state switching. DC=
 reads the UCLK DPM levels from PMFW only in init_hw, so after the OD commi=
t it keeps asking for the old top level as UCLK hard min ("set UCLK min =3D=
 max"). That is no longer the top level, so PMFW switches UCLK outside of v=
blank.
>
> The series makes DC re-read the UCLK levels (bounding box and WM ranges
> included) after an OD commit/restore that changed UCLK, and on resume aft=
er the user OD settings are restored. It also refreshes the SMU driver's UC=
LK DPM table, so pp_dpm_mclk shows the real levels.
>
> Bug report and review of v1: https://gitlab.freedesktop.org/drm/amd/-/iss=
ues/6009
> (v1 was posted there as a comment, not to the list.)
>
> Changes in v2:
> - Only act when the user has customized UCLK (user_od_feature_mask &
>   PP_OD_FEATURE_UCLK_BIT), instead of on every OD commit (Kenneth).
>   PP_OD_FEATURE_UCLK_BIT is ASIC specific, so the check is done in the
>   smu13.0.0 code, which sets a flag that the generic code reads.
> - The SMU patch now comes before the DC patch, which depends on it.
> - Rebased on amd-staging-drm-next.
> - Added Leo's ack for the display parts.
>
> Testing:
> v2 is build-tested against amd-staging-drm-next. The hardware test is on =
an equivalent backport to the Ubuntu 7.3.0-9 kernel (same code, plus a smal=
l local backport of the user_od_feature_mask tracking, which Ubuntu
> 7.3 does not have yet).
>
> Hardware: RX 7900 GRE (Navi31, SMU 13.0.0), 5120x1440@144 (DSC, ODM 4:1)
> + 2560x1440@100, UCLK OD max 1124 -> 1300 MHz, toggled via LACT.
>
> v1 results:
> - On OD commit, DC logs the new max UCLK (1300 MHz). pp_dpm_mclk shows
>   1300 as the top level, and the current level stays at 1300 (20/20
>   samples, no drops to 772).
> - About 4 minutes of heavy window switching on the 5120x1440@144 output:
>   no stripes, no hang, no amdgpu errors.
> - 3 OC on/off toggles: one short flash exactly at the switch (memory
>   retraining during scanout, expected), then clean.
> - Same scenario with the stock module: stripes, then a full system hang.
>
> v2 results:
> v2 hardware test (same RX 7900 GRE, 5120x1440@144 + 2560x1440@100; v2 bac=
kported to the Ubuntu 7.3.0-9 amdgpu, LACT applying power cap / voltage off=
set at boot):
> - boot and login with stock VRAM: no "DC memclk states refreshed" at all,=
 so
>   non-UCLK OD commits (power cap, voltage offset) no longer touch DC; the
>   short login flash seen with v1 is gone;
> - VRAM OC on (OD_MCLK 1300): exactly one refresh, "max UCLK 1300 MHz";
>   pp_dpm_mclk top level 1300 and current level 1300 (12/12 samples);
> - VRAM OC off: exactly one refresh, "max UCLK 1124 MHz";
> - desktop stays clean, no stripes, no hangs.
>
> Known limitations (unchanged from v1):
> - The OD commit itself still happens during scanout, hence the single
>   flash at the switch.
> - Only DCN3.2/SMU 13.0.0 is handled. Other ASICs with OD_MCLK probably
>   need the same hook in their ppt code.
>
> Ilya Shidlovskiy (3):
>   drm/amd/display: dcn32: rebuild WM range table when memclk states
>     change
>   drm/amd/pm: smu13.0.0: refresh the UCLK DPM table after an OD_MCLK
>     change
>   drm/amd: let DC re-read UCLK DPM levels after an OD_MCLK change
>
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++  =
.../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++  .../display/dc/clk=
_mgr/dcn32/dcn32_clk_mgr.c  |  8 ++---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 ++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 +++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++  .../drm/amd/pm/sw=
smu/smu13/smu_v13_0_0_ppt.c  | 33 ++++++++++++++++++-
>  9 files changed, 127 insertions(+), 5 deletions(-)
>
>
> base-commit: 77f548b127c6de34ce271fa09ba270cb1ef9f2da
> --
> 2.55.0
>
