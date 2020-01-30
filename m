Return-Path: <SRS0=GnFq=3T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2A8C2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 20:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101C720674
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jan 2020 20:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu9BA+rG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101C720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E126E904;
	Thu, 30 Jan 2020 20:50:22 +0000 (UTC)
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com
 [IPv6:2607:f8b0:4864:20::144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945D66E904
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 20:50:21 +0000 (UTC)
Received: by mail-il1-x144.google.com with SMTP id i7so4281787ilr.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jan 2020 12:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to;
 bh=m+JZQiClx9yZqbBuURbIhBr7e9LxqvKYQPkA6OFhZaY=;
 b=Xu9BA+rGAGmI4TJYURTcxZYNLtXb6yM8B3g4yeHk8AhrE8caI3wYjd7Fvt9B7W4Nu9
 r/uWaorfw+pxE4Bexyg4HVBt996YglhaZSfep610l8dBH/ymQWfRz3lAMX7zjuA/tEW0
 Jc8Lt37ei0tKT74HgoxqlOP1lvyD7vG6uEQIaopW8Yqy8DSsWPFPYQFlH+KKvg19QrAh
 AMO2mL+2O3qsWmtdIiiwEbx3B0BrHvHNUnShjHoYfeS1EOoEdttENWN1ng8Cpxl3G0gD
 KpZ/Gjf2C8BTy22nv29TxTsvWJR76bTA24raogmW8EUNz+3IPoi3jfL4FaNan/Q1/a3X
 NQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to;
 bh=m+JZQiClx9yZqbBuURbIhBr7e9LxqvKYQPkA6OFhZaY=;
 b=MZPG023c7ohRKnma70PPdR9KmkoMJyQ9zBbpglVS7n3SGQ+xkM+cNPfPYUZ3mV9vFl
 Qc/1wx9dBUyouAp5TtDnmzlTyU92MiHzz1htvILPf+boESvDa0tmnBeBVU00gMnfchFM
 H62E8tyD6xP7JnKj7ZWA9nXj9ELMu4ixqjsO2PrLq6zIgufen29OQUCoDj6Wm1uboVCE
 NNRtA3SQVDRYcapLfOLlbxW2zriTS6xBLBx72GZ5zj0WkzE9fQm5cuee2+RTTRCVavK8
 RNyXxWKJJtj+LBmXljAF1DEm+fC970xIhdxTAm+WpRusr+CagkeAJGeXYx92FBpYmZgw
 g4QQ==
X-Gm-Message-State: APjAAAVmpNKfr19CHmGgMXr08ox77OmG08xohBV9axs85r0atcR1h6ui
 71Qx8Qwb3WxmWGe8jPqggwE=
X-Google-Smtp-Source: APXvYqySNa1A3ujXqKcqJLB0ZRVpNqxeo62EMimuTPgkOO7JTFwLlizmi28UP6EvIiHwQpPo5EYyog==
X-Received: by 2002:a92:9ad3:: with SMTP id c80mr6292518ill.141.1580417419740; 
 Thu, 30 Jan 2020 12:50:19 -0800 (PST)
Received: from ?IPv6:2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b?
 ([2602:ae:10d1:b00:6d4:c4ff:fe4a:ea6b])
 by smtp.gmail.com with ESMTPSA id e23sm2251497ild.37.2020.01.30.12.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 12:50:19 -0800 (PST)
Subject: Re: [PATCH 3/3] drm/amdgpu/smu_v11_0: Correct behavior of restoring
 default tables (v2)
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20200129181752.609344-1-alexander.deucher@amd.com>
 <20200129181752.609344-3-alexander.deucher@amd.com>
From: Matt Coffin <mcoffin13@gmail.com>
Autocrypt: addr=mcoffin13@gmail.com; keydata=
 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
 tuwClJVHcEqY1gkUE/HKR1MQFfXl979G/1Ql1g==
Message-ID: <0dadb477-f12a-4b84-c856-240a89690901@gmail.com>
Date: Thu, 30 Jan 2020 13:50:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200129181752.609344-3-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: multipart/mixed; boundary="===============1397194817=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1397194817==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HLu4trWSeheSX1MT9uzT7V7U2PPesI8RV"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HLu4trWSeheSX1MT9uzT7V7U2PPesI8RV
Content-Type: multipart/mixed; boundary="6XUtstpk5jKBo2M5m7ekQKrDDrm7YckFq"

--6XUtstpk5jKBo2M5m7ekQKrDDrm7YckFq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

It's worth noting here that I don't have a vega20 card to test with, so
it might be prudent to get a Tested-by from someone that has access to on=
e.

It *should* work since it's so similar to the navi10 code, but it is
moderately un-tested.

On 1/29/20 11:17 AM, Alex Deucher wrote:
> From: Matt Coffin <mcoffin13@gmail.com>
>=20
> Previously, the syfs functionality for restoring the default powerplay
> table was sourcing it's information from the currently-staged powerplay=

> table.
>=20
> This patch adds a step to cache the first overdrive table that we see o=
n
> boot, so that it can be used later to "restore" the powerplay table
>=20
> v2: sqaush my original with Matt's fix
>=20
> Bug: https://gitlab.freedesktop.org/drm/amd/issues/1020
> Signed-off-by: Matt Coffin <mcoffin13@gmail.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  .../gpu/drm/amd/powerplay/inc/amdgpu_smu.h    |  1 +
>  drivers/gpu/drm/amd/powerplay/navi10_ppt.c    |  7 +++++
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c     |  6 ++++
>  drivers/gpu/drm/amd/powerplay/vega20_ppt.c    | 28 ++++++-------------=

>  4 files changed, 22 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/g=
pu/drm/amd/powerplay/inc/amdgpu_smu.h
> index b0591a8dda41..1e33c3e9b98d 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -273,6 +273,7 @@ struct smu_table_context
>  	uint8_t                         thermal_controller_type;
> =20
>  	void				*overdrive_table;
> +	void                            *boot_overdrive_table;
>  };
> =20
>  struct smu_dpm_context {
> diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/d=
rm/amd/powerplay/navi10_ppt.c
> index d2d45181ae23..26cfccc57331 100644
> --- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
> @@ -2063,6 +2063,13 @@ static int navi10_od_edit_dpm_table(struct smu_c=
ontext *smu, enum PP_OD_DPM_TABL
>  			return ret;
>  		od_table->UclkFmax =3D input[1];
>  		break;
> +	case PP_OD_RESTORE_DEFAULT_TABLE:
> +		if (!(table_context->overdrive_table && table_context->boot_overdriv=
e_table)) {
> +			pr_err("Overdrive table was not initialized!\n");
> +			return -EINVAL;
> +		}
> +		memcpy(table_context->overdrive_table, table_context->boot_overdrive=
_table, sizeof(OverDriveTable_t));
> +		break;
>  	case PP_OD_COMMIT_DPM_TABLE:
>  		navi10_dump_od_table(od_table);
>  		ret =3D smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, (void *)od_tab=
le, true);
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/dr=
m/amd/powerplay/smu_v11_0.c
> index 02f8c9cb89d9..0dc49479a7eb 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -1882,6 +1882,12 @@ int smu_v11_0_set_default_od_settings(struct smu=
_context *smu, bool initialize,
>  			pr_err("Failed to export overdrive table!\n");
>  			return ret;
>  		}
> +		if (!table_context->boot_overdrive_table) {
> +			table_context->boot_overdrive_table =3D kmemdup(table_context->over=
drive_table, overdrive_table_size, GFP_KERNEL);
> +			if (!table_context->boot_overdrive_table) {
> +				return -ENOMEM;
> +			}
> +		}
>  	}
>  	ret =3D smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context->=
overdrive_table, true);
>  	if (ret) {
> diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/d=
rm/amd/powerplay/vega20_ppt.c
> index 38febd5ca4da..4ad8d6c14ee5 100644
> --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> @@ -1706,22 +1706,11 @@ static int vega20_set_default_od_settings(struc=
t smu_context *smu,
>  	struct smu_table_context *table_context =3D &smu->smu_table;
>  	int ret;
> =20
> -	if (initialize) {
> -		if (table_context->overdrive_table)
> -			return -EINVAL;
> -
> -		table_context->overdrive_table =3D kzalloc(sizeof(OverDriveTable_t),=
 GFP_KERNEL);
> -
> -		if (!table_context->overdrive_table)
> -			return -ENOMEM;
> -
> -		ret =3D smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0,
> -				       table_context->overdrive_table, false);
> -		if (ret) {
> -			pr_err("Failed to export over drive table!\n");
> -			return ret;
> -		}
> +	ret =3D smu_v11_0_set_default_od_settings(smu, initialize, sizeof(Ove=
rDriveTable_t));
> +	if (ret)
> +		return ret;
> =20
> +	if (initialize) {
>  		ret =3D vega20_set_default_od8_setttings(smu);
>  		if (ret)
>  			return ret;
> @@ -2778,12 +2767,11 @@ static int vega20_odn_edit_dpm_table(struct smu=
_context *smu,
>  		break;
> =20
>  	case PP_OD_RESTORE_DEFAULT_TABLE:
> -		ret =3D smu_update_table(smu, SMU_TABLE_OVERDRIVE, 0, table_context-=
>overdrive_table, false);
> -		if (ret) {
> -			pr_err("Failed to export over drive table!\n");
> -			return ret;
> +		if (!(table_context->overdrive_table && table_context->boot_overdriv=
e_table)) {
> +			pr_err("Overdrive table was not initialized!\n");
> +			return -EINVAL;
>  		}
> -
> +		memcpy(table_context->overdrive_table, table_context->boot_overdrive=
_table, sizeof(OverDriveTable_t));
>  		break;
> =20
>  	case PP_OD_COMMIT_DPM_TABLE:
>=20


--6XUtstpk5jKBo2M5m7ekQKrDDrm7YckFq--

--HLu4trWSeheSX1MT9uzT7V7U2PPesI8RV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwz6NkrTNYgbdBT2N4mzKau7FyAcFAl4zQYYACgkQ4mzKau7F
yAfKcw//dy+aym9JAqzTfST6yWt1bfrjWFO4Y12nOXZ7lqf6N5/fZGGUNdJd36Rx
ZJ0JLoMVs0ytYx8XKBx/GrrrDe8dK2yprixzIb3IVjZ1LxlutbFOrXkhtY/1WoGa
3eNiwD9C8mj1n3f0p2+dI1WRujUHQg/Ypu8AmL5GPs0zqB7uVKRJgJ0hI3Rv9HCW
d7d2Om8D3IBMMEXZL9Ul9g0hIHYqJJy3cq6aNLCxKfGhenm4nk9mrYGIDIuKPw+i
2teAyJLVpD6EWz0fn0bdnoViBHy+qPVHrgyil7fA9Nb+qqlAlfDqHjqsPRpCPLXI
2OjvbJ4oDH6R0warw51r/o+pPJQHcdFi9a9DHEsRFzGzL/+8AQaMK9TBfT5xgQyh
6HLobYGuRDthsN/cU3+ndHwBsXep+SGAMhYRx4GWpU85+UCLPu2wAsp5IW6ndwfT
cVJNUm949hnVKg/H4DCC6r/zvC/GcuRdOfB1j2V+BF9XFBMytbVEQehoXFePXIVI
5IIMp3UL23bGpg9Gqkewxoosam52YzUlBE2/SMD5DL4EzS0AAQn14q5Oe8uEcKgD
kcU8RC7rxrO+y0xDonZ2e0NS7ffZUa7bU02Clcea3sPnJlEKDN699El3oiGFjlTE
HpEzPr2I8dg/ld97u4+HPFTieXIC+IJ8L1POB0GnplR1pEwPfg8=
=vDNB
-----END PGP SIGNATURE-----

--HLu4trWSeheSX1MT9uzT7V7U2PPesI8RV--

--===============1397194817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1397194817==--
