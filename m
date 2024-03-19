Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4924DC54E60
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Mar 2024 13:08:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCD4510F735;
	Tue, 19 Mar 2024 13:08:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DwQ6NZ54";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9969510E935
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 13:08:27 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-1dddaa02d22so28018205ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Mar 2024 06:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710853707; x=1711458507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uLs38/+dPzzEpkDZUuWTV/LgD/Xpkbv/ICQoZ15mc6I=;
 b=DwQ6NZ54uIJAEG3HokXkYi6rcYSfpF9oynglOlIsA3IirzDPGwfOb8b934eX+CvHGI
 j1Prt4UfwSDhkVMXJsnovjT1+bBCYgitAxaqfSv+pSqnY+RhIl2heJqhE414vBGuGrpG
 dA6zRbbNzHVOEes1287XsfhRl1MFvCBxtKTiN079gXQJo+ElzCCkNnxy1if79mDevPzZ
 vmfRhYaZ9iKW+jZoGg9xFxqvWDg6uOLDFKq22K7wgzjMcyLDXnVD9wfM2JswZo0Di2uq
 yDqyCVwuxqFYRIoBTowyRWX/z8LqoY5F0anGpXHAx/7vG+fRgOUzKaq2bA9UyL2aDrZw
 l5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710853707; x=1711458507;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uLs38/+dPzzEpkDZUuWTV/LgD/Xpkbv/ICQoZ15mc6I=;
 b=tF0UllwIMo6MGXgzA1NWYy0T9TZEr8CY5sv2Kod2NV/Qso/1TrnKISojcV5aHVwfER
 /A7PJRrYY1d05yhFq81iIf9/vw6Gwb8ROCtqAAiCUYexbbHXX9bby5Tbcw0l9gETxnFE
 pZRq/TKleMYuHL2NXMPVbyPmfAE2J57WgGP65rCiQh1sqRZOZXPKCzZXj5j+NtGROIm7
 opvcT9/t5h4E50qCNeswyjudSgNt34++fh7JoekOQeA2dTMtKmkKim3ceBSUMySIsZkp
 T/lCN2Bc8R4TWDrfrfysH1BWLTZ87l7N5JARXEj5ThNCfN2ZBYnxCEoSUMJxKtv3b9Sy
 BcPA==
X-Gm-Message-State: AOJu0YzQ1+jPkSeJBSqBc7Ak8ReToSrDHdVyNnaCBfEGrbas20Vk+T/F
 ApV78wo75zRwskddqsxXUqHM1dZJTDNIaWIHMTyec2fxPcrGvGuyK9VmZW+2kZJ4lndwKmpzSgK
 7cujpG9kFbMQcCecSQohS3OMK+MOiIH7y
X-Google-Smtp-Source: AGHT+IGJ2as0B0hg0Q3JLfYLH/Vcvx9Yohnb/2mkzKvPQOFjWaZXeoaEN7L/3u/saIEmIIvZ02HWS15LKE6NO93AWn4=
X-Received: by 2002:a17:902:d48b:b0:1e0:26ac:8234 with SMTP id
 c11-20020a170902d48b00b001e026ac8234mr6697461plg.18.1710853706668; Tue, 19
 Mar 2024 06:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240319101501.2567966-1-Jun.Ma2@amd.com>
In-Reply-To: <20240319101501.2567966-1-Jun.Ma2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Mar 2024 09:08:14 -0400
Message-ID: <CADnq5_PAHP7it+mcjYESwvVoQoT1ALGFKpFtxZVJO57USLNAqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/pm: Don't use OD table on Arcturus
To: Ma Jun <Jun.Ma2@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Kenneth.Feng@amd.com, 
 Alexander.Deucher@amd.com, kevinyang.wang@amd.com
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

On Tue, Mar 19, 2024 at 6:22=E2=80=AFAM Ma Jun <Jun.Ma2@amd.com> wrote:
>
> OD is not supported on Arcturus, so the OD table
> should not be used.
>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 33 +++----------------
>  1 file changed, 5 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index a58708bcda89..dc3a5d863a04 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -1289,11 +1289,8 @@ static int arcturus_get_power_limit(struct smu_con=
text *smu,
>                                         uint32_t *max_power_limit,
>                                         uint32_t *min_power_limit)
>  {
> -       struct smu_11_0_powerplay_table *powerplay_table =3D
> -               (struct smu_11_0_powerplay_table *)smu->smu_table.power_p=
lay_table;
> -       struct smu_11_0_overdrive_table *od_settings =3D smu->od_settings=
;
>         PPTable_t *pptable =3D smu->smu_table.driver_pptable;
> -       uint32_t power_limit, od_percent_upper =3D 0, od_percent_lower =
=3D 0;
> +       uint32_t power_limit;
>
>         if (smu_v11_0_get_current_power_limit(smu, &power_limit)) {
>                 /* the last hope to figure out the ppt limit */
> @@ -1309,30 +1306,10 @@ static int arcturus_get_power_limit(struct smu_co=
ntext *smu,
>                 *current_power_limit =3D power_limit;
>         if (default_power_limit)
>                 *default_power_limit =3D power_limit;
> -
> -       if (powerplay_table) {
> -               if (smu->od_enabled &&
> -                               od_settings->cap[SMU_11_0_ODCAP_POWER_LIM=
IT]) {
> -                       od_percent_upper =3D le32_to_cpu(powerplay_table-=
>overdrive_table.max[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -                       od_percent_lower =3D le32_to_cpu(powerplay_table-=
>overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -               } else if (od_settings->cap[SMU_11_0_ODCAP_POWER_LIMIT]) =
{
> -                       od_percent_upper =3D 0;
> -                       od_percent_lower =3D le32_to_cpu(powerplay_table-=
>overdrive_table.min[SMU_11_0_ODSETTING_POWERPERCENTAGE]);
> -               }
> -       }
> -
> -       dev_dbg(smu->adev->dev, "od percent upper:%d, od percent lower:%d=
 (default power: %d)\n",
> -                                                       od_percent_upper,=
 od_percent_lower, power_limit);
> -
> -       if (max_power_limit) {
> -               *max_power_limit =3D power_limit * (100 + od_percent_uppe=
r);
> -               *max_power_limit /=3D 100;
> -       }
> -
> -       if (min_power_limit) {
> -               *min_power_limit =3D power_limit * (100 - od_percent_lowe=
r);
> -               *min_power_limit /=3D 100;
> -       }
> +       if (max_power_limit)
> +               *max_power_limit =3D power_limit;
> +       if (min_power_limit)
> +               *min_power_limit =3D power_limit;
>
>         return 0;
>  }
> --
> 2.34.1
>
