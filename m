Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AA5EB64D7
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jun 2023 13:39:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14A9010E042;
	Wed, 28 Jun 2023 13:39:56 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E4410E042
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 13:39:53 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1a1fa977667so5310492fac.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jun 2023 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687959590; x=1690551590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWVf/wDfV6BsotvIDWy9G+QBeSM9MGBMpI5rthzxGDs=;
 b=LCHgTtO0J5kgnnhUm9Qv5AD8+1ZUWP5Cmbyo14exrzaFCMiwAiBJi9Ia8becmauKrQ
 VggswBNpMAuerU4e2WvNQpdfT4VPnGi98QtVoTNJVj9q8c3hy0UROWiG3BKhSGY71fv0
 c3hoLJ2UqxsHGtDa7iS5gqOnb0ro9KhXMwk9k4txw3yCs8WLE6DpGlLZ+V8sIRo+0JiP
 9F4vz1wzif79s94ZNRoyQVn8dOIp2HsXdxlbK3i07vLOEgURjP0uSfKGVsM3dRl0teW1
 niCJPCK+wTKLDHVI7Fhxg2iKWOVD7QDlIG1Z0Vx0GtpFD8xYXG3LbH9BG1TmC2O0WwGG
 JEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687959590; x=1690551590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EWVf/wDfV6BsotvIDWy9G+QBeSM9MGBMpI5rthzxGDs=;
 b=JIStLp2QhINUWVeEiiYy7v52CjOO5uxd2ZpPc9a7xNr3kpZOwIHtNggBpTe/lw/uxs
 +eLDI81MJAWa47Iz7MzeR0rC90DrippRUnjo+/q1i0zDg51xj0am3xib3gZtKKRyeWgl
 bNOJBClnxBRR9w7TqdBHS78FpexPxPtClK++zXLnr+Dbl8kY+t4bFcRQ+B83sOHxZ6G5
 6xhKxVNkvs+fSpBjIiCy/BSQuU7EbpN5Jm2o/1iTg81iq3kMdsciGGhoO6EtKEmnVFWc
 67u8ktkDZxfufZ1WDvrY2SKj2cZsN5f57jayOslIjVHwGKvVNju41s29sDjKCPWRl534
 k+VQ==
X-Gm-Message-State: AC+VfDz0zv77t8Qv3iLYAo+ZCoBbDrSk+a6Ro+boWTluqWD2uCQUM8TB
 RrDeFMT14i/XxaRy5Nd6EmCzkkdpwCCyWqYJ6T8=
X-Google-Smtp-Source: ACHHUZ47W9xmaU380w6/CQgIsBWX9ssJCd8bls+L0C+YaMcUj0+NftQfRnHFNEyy3Uomy4JMwNTG02xYKoXGrT6HSqE=
X-Received: by 2002:a05:6870:3a2b:b0:1b0:f38:9102 with SMTP id
 du43-20020a0568703a2b00b001b00f389102mr12807345oab.7.1687959589952; Wed, 28
 Jun 2023 06:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230628123021.2286846-1-kevinyang.wang@amd.com>
In-Reply-To: <20230628123021.2286846-1-kevinyang.wang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 28 Jun 2023 09:39:38 -0400
Message-ID: <CADnq5_Mu6qOysGeAia9_FJYnQmbYWz9++tZjCRUbgMbsFwuC7w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: fix smu i2c data read risk
To: Yang Wang <kevinyang.wang@amd.com>
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jun 28, 2023 at 8:30=E2=80=AFAM Yang Wang <kevinyang.wang@amd.com> =
wrote:
>
> the smu driver_table is used for all types of smu
> tables data transcation (e.g: PPtable, Metrics, i2c, Ecc..).
>
> it is necessary to hold this lock to avoiding data tampering
> during the i2c read operation.
>
> Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c      | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c    | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c    | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/=
gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> index 9cd005131f56..3bb18396d2f9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
> @@ -2113,7 +2113,6 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2=
c_adap,
>         }
>         mutex_lock(&adev->pm.mutex);
>         r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, t=
rue);
> -       mutex_unlock(&adev->pm.mutex);
>         if (r)
>                 goto fail;
>
> @@ -2130,6 +2129,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2=
c_adap,
>         }
>         r =3D num_msgs;
>  fail:
> +       mutex_unlock(&adev->pm.mutex);
>         kfree(req);
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> index c94d825a871b..95f6d821bacb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
> @@ -3021,7 +3021,6 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_=
adap,
>         }
>         mutex_lock(&adev->pm.mutex);
>         r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, t=
rue);
> -       mutex_unlock(&adev->pm.mutex);
>         if (r)
>                 goto fail;
>
> @@ -3038,6 +3037,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_=
adap,
>         }
>         r =3D num_msgs;
>  fail:
> +       mutex_unlock(&adev->pm.mutex);
>         kfree(req);
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/dr=
ivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> index f7ed3e655e39..8fe2e1716da4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
> @@ -3842,7 +3842,6 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapt=
er *i2c_adap,
>         }
>         mutex_lock(&adev->pm.mutex);
>         r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, t=
rue);
> -       mutex_unlock(&adev->pm.mutex);
>         if (r)
>                 goto fail;
>
> @@ -3859,6 +3858,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapt=
er *i2c_adap,
>         }
>         r =3D num_msgs;
>  fail:
> +       mutex_unlock(&adev->pm.mutex);
>         kfree(req);
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> index e80f122d8aec..ce50ef46e73f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
> @@ -1525,7 +1525,6 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i=
2c_adap,
>         }
>         mutex_lock(&adev->pm.mutex);
>         r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, t=
rue);
> -       mutex_unlock(&adev->pm.mutex);
>         if (r)
>                 goto fail;
>
> @@ -1542,6 +1541,7 @@ static int aldebaran_i2c_xfer(struct i2c_adapter *i=
2c_adap,
>         }
>         r =3D num_msgs;
>  fail:
> +       mutex_unlock(&adev->pm.mutex);
>         kfree(req);
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 124287cbbff8..1d995f53aaab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -2320,7 +2320,6 @@ static int smu_v13_0_0_i2c_xfer(struct i2c_adapter =
*i2c_adap,
>         }
>         mutex_lock(&adev->pm.mutex);
>         r =3D smu_cmn_update_table(smu, SMU_TABLE_I2C_COMMANDS, 0, req, t=
rue);
> -       mutex_unlock(&adev->pm.mutex);
>         if (r)
>                 goto fail;
>
> @@ -2337,6 +2336,7 @@ static int smu_v13_0_0_i2c_xfer(struct i2c_adapter =
*i2c_adap,
>         }
>         r =3D num_msgs;
>  fail:
> +       mutex_unlock(&adev->pm.mutex);
>         kfree(req);
>         return r;
>  }
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> index 6ef12252beb5..1ac552142763 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
> @@ -1763,7 +1763,6 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter =
*i2c_adap,
>         }
>         mutex_lock(&adev->pm.mutex);
>         r =3D smu_v13_0_6_request_i2c_xfer(smu, req);
> -       mutex_unlock(&adev->pm.mutex);
>         if (r)
>                 goto fail;
>
> @@ -1780,6 +1779,7 @@ static int smu_v13_0_6_i2c_xfer(struct i2c_adapter =
*i2c_adap,
>         }
>         r =3D num_msgs;
>  fail:
> +       mutex_unlock(&adev->pm.mutex);
>         kfree(req);
>         return r;
>  }
> --
> 2.34.1
>
