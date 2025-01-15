Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B59C02183
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 14:05:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C509B10E6DC;
	Wed, 15 Jan 2025 14:05:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lir21DFI";
	dkim-atps=neutral
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CC4410E6DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 14:05:48 +0000 (UTC)
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2f45526dea0so1484635a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 06:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736949948; x=1737554748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVYwuIMekxoWZWciMDFLffbfjBOqBUvAuyXJhLL46Ns=;
 b=Lir21DFIq4YFkPdRQLHyzCHLjEo+6Svcx70MuUnT0CzCtKMGo8hoRAebmQ54RL3vCu
 aDgeZPT+IP/FNREmCA1MZ+a1SLfua0/3Exn6kBg0cBTXn6NRDxWlrpJTdpv40df4ULNE
 0Vfmvo6lFY0EncM9FDESJ+RBK+vpdBI+PzFyF7W2/Vp5S4Cq7zrMFwo06cZunRwpgkoD
 h5LkW/OwZDsBdjU0ak8fO+R5A6SlelBysbr2T1Jwmw2Q8y27mLCNXpvn2+8BcWsy4P7o
 YZD7XGzWPAlRCfEQvt9e4fuVJhujOla7COBhdFTLgq93M9/hdK3GQwLT/ytOg5B99LEp
 EPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949948; x=1737554748;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVYwuIMekxoWZWciMDFLffbfjBOqBUvAuyXJhLL46Ns=;
 b=D+8/dSJZ20Yh49z0uJBcs+xg9zmjk8uvlhFZ9GyyZE4HwS6DqjTlwUMx2TQZ4bF00c
 yzPkv+0T2oHKNpk8MtM/SoeVcdqnOgEAaYCNo6KcoXI+nUixdcXdfw+2ihkA+KTeJ46/
 mdbNY8YeRV6X6uuKccaEYGepfCQf1vvRIcVvfg2UPgDRad5py2OQ4TCq+6KP6PAYL4Lk
 brNjyVYfRQB5HrDaZmxC1s2OBXYTHorTjsG6WfYNtZZ/CR832cnz0pT/ARbEtasf5Tbb
 P/QtOBtkdmeZ2i7/z+1+LWtT3ntKEt5nhsfgePuHlju5yeuhgviF2mZLZ6usJl0Om0kv
 9UlA==
X-Gm-Message-State: AOJu0YywASUGNmKNo0TPNIl3nj9EnEb3Roj7TAGMNi+TGxeh+SqcMIRJ
 dJdtN2oMooMq5iU3dSTF9Uaw2oqR76rs/CH2TACet9jeFEs30PkGMHByBlbX1SvCwwHhpcRFO/C
 ALJuErM5fO3JRX/rf/epfwyGndIZE+g==
X-Gm-Gg: ASbGncv63OTrCA1MSrlGbjW3t8nU4ebuy/1YFQ6oZbM1WpNHPHqnNIHPNdJ0fm7LrtG
 qcPfVgT5aw8xwGmmfA14jo+PWwvkcDn3QDskQjg==
X-Google-Smtp-Source: AGHT+IG9gmKSKQFMxFj4IC+XHq15Nw42mr09QI1GB0vZDQw5tSBU1w6N3n9N1XOhNHccFCswmN9tNnGzJ+F1yuNhpkM=
X-Received: by 2002:a17:90a:d887:b0:2ee:6a70:c5d1 with SMTP id
 98e67ed59e1d1-2f548f1ef1bmr16007635a91.3.1736949947570; Wed, 15 Jan 2025
 06:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20250115094821.3736827-1-jesse.zhang@amd.com>
In-Reply-To: <20250115094821.3736827-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 15 Jan 2025 09:05:34 -0500
X-Gm-Features: AbW1kvaZ0f6VeZ2QGp3VTiwpIamn-Gpz-U0o5RtFa2r6pfhv-24Jnjo_S6ZdNoI
Message-ID: <CADnq5_MCFrWtuh67MHhxYxKA3CfwKGOf3rW0HwK7VY0F_2+X8Q@mail.gmail.com>
Subject: Re: [PATCH 3/3 V2] drm/amd/pm: Refactor SMU 13.0.6 SDMA reset
 firmware version checks
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Tim.Huang@amd.com,
 jiadong.zhu@amd.com, Lazar Lijo <Lijo.Lazar@amd.com>
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

On Wed, Jan 15, 2025 at 4:48=E2=80=AFAM Jesse.zhang@amd.com <jesse.zhang@am=
d.com> wrote:
>
> From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>
>
> This patch refactors the firmware version checks in `smu_v13_0_6_reset_sd=
ma`
> to support multiple SMU programs with different firmware version threshol=
ds.
>
> V2: return -EOPNOTSUPP for unspported pmfw
>
> Suggested-by: Lazar Lijo <Lijo.Lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 23 ++++++++++++++-----
>  1 file changed, 17 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 650aa9d0548a..f68282238303 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -2745,12 +2745,23 @@ static int smu_v13_0_6_reset_sdma(struct smu_cont=
ext *smu, uint32_t inst_mask)
>  {
>         struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
> -
> -       /* the message is only valid on SMU 13.0.6 with pmfw 85.121.00 an=
d above */
> -       if ((adev->flags & AMD_IS_APU) ||
> -           amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6=
) ||
> -           smu->smc_fw_version < 0x00557900)
> -               return 0;
> +       uint32_t smu_program;
> +
> +       smu_program =3D (smu->smc_fw_version >> 24) & 0xff;
> +       /* the message is only valid on SMU 13.0.6 with these pmfw and ab=
ove */
> +       if (amdgpu_ip_version(adev, MP1_HWIP, 0) !=3D IP_VERSION(13, 0, 6=
) ||
> +               ((smu_program =3D=3D 0) && (smu->smc_fw_version < 0x00557=
900)) ||
> +               ((smu_program =3D=3D 4) && (smu->smc_fw_version < 0x45570=
00)) ||
> +               ((smu_program =3D=3D 5) && (smu->smc_fw_version < 0x55512=
00)) ||
> +               ((smu_program =3D=3D 7) && (smu->smc_fw_version < 0x75507=
00))) {
> +               dev_err(smu->adev->dev,
> +               "ResetSDMA not supported: SMU program %u requires PMFW >=
=3D 0x%x\n"
> +               "Current PMFW version: 0x%x\n",smu_program,
> +               smu_program =3D=3D 0 ? 0x00557900 : smu_program =3D=3D 4 =
? 0x4557000 :
> +               smu_program =3D=3D 5 ? 0x5551200 : smu_program =3D=3D 7 ?=
 0x7550700 : 0,
> +               smu->smc_fw_version);
> +               return -EOPNOTSUPP;
> +       }
>
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                               SMU_MSG_ResetSDMA, inst_mas=
k, NULL);
> --
> 2.25.1
>
