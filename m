Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB2660824D4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p8387JDT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3DD10E654;
	Mon,  2 Nov 2026 16:12:22 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 911C110E635
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:12:16 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-36a10095f3aso359549eec.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 08:12:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793635936; cv=none;
 d=google.com; s=arc-20260327;
 b=dmAVDAeOAKCQkQX1gdDvJrxKUnuuhCQTl0x+XXQSKcYIzOPamrfbdj/ZQnjfuASYnq
 n9zQw4RWKUxRp6NZTt+O8iRqHtYFN0jdK9eVJnoCnrKPbaXNlsvG+q2zTwl21y+EivbI
 7CMuFHhRPyTCn/22quSrl/vVLijbFDCdmxJVjmdmdVhD0B+GUV+skFS7+XdEwb5J/67B
 e3ykWicrPMFGdwwGby5M62uT+9PcUslRIJanUmT0nSrQFyVw1iyXEr/gMZOOD4k3rnu+
 U4I0gQbW915Qp3jUE+XyBZZUUsI4C8+2HP1LPZkuV+CJ78BG9LV+77WU3PEPX1xohQwp
 gubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zFpj8GxNJ/dJ+H/jIrqZY7FAX+IqubJO0enr8qbWibA=;
 fh=F+fOIDvBc/C5fO0RxqClZcASA3FFziV9XXgq7SNOwNA=;
 b=m1mBCl84CIB9DDxlF6vrEZGVdTuX72/l56xJAu6i9sFdzSVa2fulzcdQB9NKwA4yRa
 /qPIZ7MgzH1yA2XZui8JPOeVtLamiUbDQrADk2wZrMOUTruzu1Bxw0GvIqrPzlkpb0dV
 yzpnmlQijHtjfEFVbDF8LgYaSXrqb7re/yjfQ/DjFslUVRN/KBvD2esaE7RYERTyyD0d
 rTPUqYOTzphEq+S0PKHl6VlngqM8dBfV9CF7StxqMqQe12K6olQS6er8Eth5yRe1LdGa
 ix33oKiP3s/MylYPiR1gXLl8t9FPJ6zSuMmuD2rmnvcHlrUKnJZP6CBB0n483+U21BLw
 GhvQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793635936; x=1794240736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zFpj8GxNJ/dJ+H/jIrqZY7FAX+IqubJO0enr8qbWibA=;
 b=p8387JDTSwrPAPkMndNyO7fcx3+AHwOMrha2zhPOqY3r370pi8BLUemZeCe11qLByx
 CJLDdrUSWxdUr4IQ/jfKz5BkROD6dPkjZmxLyjs0AoojJc66zoE2aHphRb+vpKBG+Vk0
 odrIGxP5ZqE0E5v/00ih1j7kCPD5eZBzUzX52zz0bef7cV+pFFOfiMa0pTfQL4NdCp8W
 sc0R5nGKSXy7byvnMDBhu19WpULl20ebzUrW5PxIxrt3b0MY9JWHyZr6eA31HCW833mE
 t80CGZFL2fBHR6Z1fGRcSBMIJ4IffNIOQUYY4m90isUZ8LbeF396rs0gjAFl2Eb32tch
 c3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635936; x=1794240736;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zFpj8GxNJ/dJ+H/jIrqZY7FAX+IqubJO0enr8qbWibA=;
 b=Id6jgGbtuzEybNeP9KzuI4bBBz72rLCC9Ey+o9Dpach7djXYOM2RWWRcR/Hsj715M6
 ki4KkYkDErn0VNiOuD4HCSoPSY4oJv1EZu+e7D4dpWXGHFMuzXjkLHywvbA8rQC11+se
 xvuB5BPJHfQRILLsUDS70eH+VwzrpsjdiYwSzsKcRQC7TiswcemUYT86e51GA25X6KDs
 tHAEZzNwraMvG75grbIlWaNmqIwL75rex4RkYv4FnUBM8bETwoAja7T/6wAKETh4HtJ8
 aF5jMFlacrbMooa66h47TGmGAQ3RqIkHvgSqUpET9EMm476gBWKXdl+7e2EQKkjngh1k
 jGyw==
X-Gm-Message-State: AFq9FYKYqUw3kibo1wECkMe9jfgen0iDh/eP0VsHLfyCeMiY7Em+E3hM
 s5/wtSJHdy5e3qLVdVkvutyPVWpUB7IULFRM3v3OYhKyqhWHjltVwyCWSpsRCNM0ciPeDMQsrlp
 utu++x6uiRm4HsUvji7OYRukPYaJOP88=
X-Gm-Gg: AYBFou2odusrsijUuFN8+hmafJFgX0ThnUK6YxkDYGqSx1kNR08KXNqQ5IFeeDLXWzC
 wEC2oQZo4EBCbw0lHKALbCXceqrDN9GWwWT2nYwynWYmKrpJbiw81Uq6ZRTe0i0snFTm/zW/3Th
 j7my8TVVDVrBLy0kUsFapNJ7X/Z4jODHzb/MKE/XW4zFCa10tNZbhJNsq1aUczoNqvNSY4D1d+g
 ag5UDZ27OoNPk/p4/ctJCR2dmDAD39szDcbPCyj5TLlGmFjq8HgOpt6AoVpwXrDs5thzlPgnC5s
 f9aPR63CBeaTg/Eu868BpjL9F26kW7yqUNKRwdHrO7VOaQUZhP4Ql+FU1EKTBOeQlg1pROLICv5
 fhCjl2mh3+9Sp3AnQqPPcL551aXcX6Lo/f2SzQR4A0lD6FzIdZwD5HRi8OMbKBX/i3kqamS4uEs
 w+lqHKb6BydFlOkfVBuXroMkOtc92WR9xzmzqzH3z7/Ee4
X-Received: by 2002:a05:7022:7e0c:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-1ac5b7dcb2bmr26286891c88.2.1793635935581; Mon, 02 Nov 2026
 08:12:15 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <CADnq5_Pv0wkPx9AzooUf=dyWgQuneMc6K9-qcT6PW53Gg4L5rg@mail.gmail.com>
 <20261030165838.248622-1-shidlovskiyilya@gmail.com>
In-Reply-To: <20261030165838.248622-1-shidlovskiyilya@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 11:12:04 -0500
X-Gm-Features: AclHuK8ndl5BD8KPuwg5-BVgOcT4opWV5S-GX6-mBh_N-dROfvJUBJ9b7N_fywY
Message-ID: <CADnq5_P9TtDaJu2Q4BLr6U0SSd7KoTy-vW4NsS_7Gbn70L4d6A@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/amd: fix DCN3.2 flicker/hangs after OD_MCLK
 (VRAM overclock)
To: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Kenneth Feng <kenneth.feng@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Kevin Wang <kevin.wang@amd.com>
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied the series.  Thanks!

Alex

On Mon, Nov 2, 2026 at 3:07=E2=80=AFAM Ilya Shidlovskiy
<shidlovskiyilya@gmail.com> wrote:
>
> On DCN3.2 (Navi31, RX 7900 GRE here), raising the UCLK max through
> OD_MCLK makes the display flicker (full-width stripes) and eventually han=
g
> the whole system, if the current mode does not allow memory P-state
> switching. DC reads the UCLK DPM levels from PMFW only in init_hw, so aft=
er
> the OD commit it keeps asking for the old top level as UCLK hard min
> ("set UCLK min =3D max"). That is no longer the top level, so PMFW switch=
es
> UCLK outside of vblank.
>
> The series makes DC re-read the UCLK levels (bounding box and WM ranges
> included) after an OD commit/restore that changed UCLK, and on resume aft=
er
> the user OD settings are restored. It also refreshes the SMU driver's UCL=
K
> DPM table, so pp_dpm_mclk shows the real levels.
>
> Bug report and review of v1: https://gitlab.freedesktop.org/drm/amd/-/iss=
ues/6009
> (v1 was posted there as a comment, not to the list.)
>
> Changes in v3:
> - Rebased on top of Kevin Wang's "preserve committed OD features" patches
>   for SMU 13.0.0/13.0.7 and 14.0.2. v2 was based on an older
>   amd-staging-drm-next that did not have them yet, so it did not apply;
>   sorry about the wrong confirmation earlier. Only patch 2/3 needed a
>   conflict resolution: the UCLK check now uses Kevin's next_mask, with th=
e
>   same logic as before (details in the patch notes). Kenneth, please
>   double-check that your Reviewed-by still holds for it.
> - Added Kenneth's Reviewed-by.
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
> v3 is build-tested (W=3D1, no new warnings) against amd-staging-drm-next
> ba496bb83, which includes Kevin's patches. The hardware test is on
> an equivalent backport to the Ubuntu 7.3.0-9 kernel (same code, plus a
> small local backport of the user_od_feature_mask tracking, which Ubuntu
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
kported
> to the Ubuntu 7.3.0-9 amdgpu, LACT applying power cap / voltage offset at=
 boot):
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
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 +++++++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  6 ++++
>  .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  8 ++---
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 ++++++++++++
>  drivers/gpu/drm/amd/display/dc/dc.h           |  2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c           |  7 ++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 19 +++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  3 ++
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 30 +++++++++++++++++
>  9 files changed, 125 insertions(+), 4 deletions(-)
>
>
> base-commit: ba496bb837882eb1af58f41572fc289e46c77b8c
> --
> 2.55.0
>
