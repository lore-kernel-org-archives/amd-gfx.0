Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 876FEC88E6E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 16:00:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D468710EF2A;
	Mon, 14 Sep 2026 16:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sZ+y546/";
	dkim-atps=neutral
Received: from mail-pz2-f24.google.com (mail-pz2-f24.google.com
 [74.125.228.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42DD010EFAD
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 16:00:54 +0000 (UTC)
Received: by mail-pz2-f24.google.com with SMTP id
 41be03b00d2f7-cc4c1847d64so61859a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789401654; cv=none;
 d=google.com; s=arc-20260327;
 b=U10U3VDWKjMx0EYd4+X9Psi+GJ4/Ok588rHJ1xg7K+7oSoAafnT3sTynM+8dSUU5Fo
 xw8GeS1pw0M+FLj9UTghneAkAfnAo61yrwsiAT4kCkKh5duRDr9Y1yWBSNqdmHLk7arB
 9w8Ly+jlOKGGGvx8VaSMCs2yQHjgQGcYa6RLPrfurNg8oH/Ta19ESGiPgF4j5s1Nww8W
 t3V4rDF38AZbg6+lVcl0MjRG2X6dJ+kOTNK0QdkH2KGb4zfXAJilCTiImSDshycNgfV8
 VqN869jHZ86zeYx10STE2qhzVkzc2pqVAT1Gnt6uM4JShIpkOKl4h1bMCiUgbKiNQK3+
 I4Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DY2MERo4pqi0K0VhneHvwSpwoimTnvKFD3fY4QkQorI=;
 fh=BnIxZSY380/7wz/65n6Z+oJX7hesMSUG0oAf7PWQNm0=;
 b=ZWC7Y4Xar8IppLSdDHcNvsPUUvPz4MvmfPxFQV5CvlNCulumTChBP2HBPCD3Kjhbsd
 YrfTZqs3VpLwz5Y/syrmjw9EdIuxLfIdQw26PzQ6RQazH8uDjtgXmnrst0N4JqD4JyX0
 v42MVksKEzowCVx1kn0c0gERLXWnTjlKbEoHokgt+9t9+ezorhATizaPAdqowQcanhOW
 5bVK9lRMVlPSVjyDnLHW3Bs9OFuyUoww1sHiUgWkCgshkomUukMtcxwvqOtk7gD/nzX2
 51XAdD0UVQ1RmeqMwjKdEY1BcnUsDgYmcs+IEKf8tG1BolPELmVp1u3Rof83YpzZbhbx
 O7bw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789401654; x=1790006454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DY2MERo4pqi0K0VhneHvwSpwoimTnvKFD3fY4QkQorI=;
 b=sZ+y546/Biw2v9r6xnQ32GNjw1C/V+WKTTMGaTU9nsqygVnJ1cRZ1bzcDphopwzkjX
 HFtyl4gZGGAOU6sdJAy5K0mVjxS/RSYfJ8hqMNq6H2IaNbjNIrGObC5/xTPMdsRFmFHf
 qmXPTOBdb4Mv7pSOGDroBDnwcOsVcN1PhlMPy6yNgwDbnjgHzfGGeosheG5CMqpT3ymL
 jFuzSLnM5U6KPo66rsH0gxUNDaIHsvAVxKoff+ycfzWiLV/YeoaVKsLUiqTGtRq5KYbM
 SusaKoN5hfwGRp04DnMyF2gZ0rOWpFb2TMpStU8jtGHWNVt4kOIu/xpjd8rKsLNVeCJN
 QsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789401654; x=1790006454;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DY2MERo4pqi0K0VhneHvwSpwoimTnvKFD3fY4QkQorI=;
 b=aDpH2tmmt1z1mSBC20S8OaM6vv2cSXERwSKZ6UKnAcmJC4oZMKyE1FETU/Ftj8TxM1
 BdeYboovLuucx9FOVTviB4+G8y5YEAcgo73ScTUEgAJiHzHgUVJe6GOuJsEQe+oQ3fnZ
 DWuTazVilxyX6PoXQN/di/qKLbkdEkp/bEI6zoVuyH08+Vn+o7aNZVmOz/dlpcAVbQ5f
 zC+4fHOiAwvZuTRDwolOTRnQRb2ZXFemna4OUzYPKzFxqAMz0oBi50wNh3iRB66lGYnL
 RIKtoCQcJQsjcGg7ni3q9sXcj8uFERCCmOqHeYhfMs4ZkJr+xNLh+Nm3eUqA2gG0J0ck
 ARbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzis1D7o8/xQN9EElaB3tfTySy/5Ev/qxI8RkfNhfhs8U1wn24O1fk4LyrZ0Pv+HbDYB7eEU+Fo@lists.freedesktop.org
X-Gm-Message-State: AFuF++m0CjNnA3lT/qKfqqjTw4G+xaSfj71h4+9WjD6u1Vx/dZEhJA/3
 udQMCyCXftRWlSXPtYee3NU9Syc86elJ1REKmf95hSvNey0FX9NFEcSjUz9XMYOXxnOdkmPVJ1N
 mxoiS1COLz+VSu9M2M5lF/giGdd2kBEY=
X-Gm-Gg: AYBFou3w0UI1912caK43TRtp99UZOulq6Cwl+90VBL3rCnuO/J4BlQdc3MYd+gzC5CG
 k0NRVcU2GiJHppKGqblSwzL+SmFLI3Fkk82OXHL2BP3mMy+Z95SG8elN+P8ZXF7Pljl/vq0P/qz
 WEbXWpd3jqdQm6DxtRT3rHCDMrFYrQGN9xR4+nhScefZ4rlkbSjzXAHnpaEnL6JvxQxLjsd7ori
 dp8Re/3EQzi3xaL6dKDt0cKSPu81DJvvNvgA2ZpEzvJW9V+K57jYkhqpJ4z8fdJSebeGSLu2KgO
 pmcH89G8UHBfFFjOg8G1BB8Z+QXqshbQC6dBKF466+ubLDR7H+WwPzTEWI/w8HO70bCJ8wLtwvu
 HFmiBBEJGZ8rqT9OuT77p9b3O5MwccM66KeQngYdP7w==
X-Received: by 2002:a17:90b:1d4f:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-39dec1c3dabmr4866025a91.4.1789401653630; Mon, 14 Sep 2026
 09:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260914132920.10127-1-harimishal1@gmail.com>
In-Reply-To: <20260914132920.10127-1-harimishal1@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 12:00:40 -0400
X-Gm-Features: AcwNN1Wxf9uW0Stp_OdrSiy6kLoKP1kUMtA3NKxerasiMRbBAeEiR0U57Nj_bA4
Message-ID: <CADnq5_PKDe2dtDVsfzjNFwu+tjoH5DzE+GU7x+O8X=ymbDAmKg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: bound SCLK FCW range entries to the table size
To: Hari Mishal <harimishal1@gmail.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Hawking Zhang <Hawking.Zhang@amd.com>, Xiang Liu <xiang.liu@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Yang Wang <kevinyang.wang@amd.com>, 
 Asad Kamal <asad.kamal@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

Applied.  Thanks!

On Mon, Sep 14, 2026 at 10:36=E2=80=AFAM Hari Mishal <harimishal1@gmail.com=
> wrote:
>
> atomctrl_get_smc_sclk_range_table() copies ucSclkEntryNum entries from
> the VBIOS SMU_Info table into pp_atom_ctrl_sclk_range_table. Both the
> source (asSclkFcwRangeEntry[]) and destination (table->entry[]) arrays
> are fixed at MAX_SCLK_RANGE (8) entries, but ucSclkEntryNum is an
> unchecked u8 read straight from the VBIOS, so it can be up to 255. The
> destination is stack-allocated in both callers
> (polaris10_get_sclk_range_table(), vegam_get_sclk_range_table()), so a
> count above 8 overflows a stack buffer, not just a heap read.
>
> Reject counts above MAX_SCLK_RANGE rather than clamping to it. Only
> one version of this VBIOS struct (ATOM_SMU_INFO_V2_1) has ever
> existed, so a count above 8 corresponds to no legitimate table format
> and means either a corrupted or a tampered VBIOS.
>
> Fixes: a23eefa2f461 ("drm/amd/powerplay: enable dpm for baffin.")
> Assisted-by: gkh_clanker_t1000
> Signed-off-by: Hari Mishal <harimishal1@gmail.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index 4b796d60b03d..3217ad3c1d17 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -1025,6 +1025,9 @@ int atomctrl_get_smc_sclk_range_table(struct pp_hwm=
gr *hwmgr, struct pp_atom_ctr
>         if (!psmu_info)
>                 return -EINVAL;
>
> +       if (psmu_info->ucSclkEntryNum > MAX_SCLK_RANGE)
> +               return -EINVAL;
> +
>         for (i =3D 0; i < psmu_info->ucSclkEntryNum; i++) {
>                 table->entry[i].ucVco_setting =3D psmu_info->asSclkFcwRan=
geEntry[i].ucVco_setting;
>                 table->entry[i].ucPostdiv =3D psmu_info->asSclkFcwRangeEn=
try[i].ucPostdiv;
> --
> 2.43.0
>
