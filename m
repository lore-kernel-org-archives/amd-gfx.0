Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B3FBC77B7F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 May 2023 13:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B3210E0EA;
	Tue, 16 May 2023 13:08:11 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27B6D10E0EA
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 13:08:09 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-38c35975545so9197740b6e.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 May 2023 06:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684242488; x=1686834488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HJHNd7bhq76oViGBMTkjpl95N0k1z7OPp4YBl+C87Us=;
 b=qmBLe+uH8dvCs29JY1IXue3ZtyXbco8Z7of3tCEwdOSEJdR4p12a40UNo6BNZv5Yzs
 at6E40druWqV2Fs/YtaAQkMAbLufbCjhAlXz3PXoyo6bnNyUlqAYCAvA7YEpDbVkn+11
 Md6kIyjzBnli6Hct05YIJkW6VnPFKxjjLbLsZ8VDd6VA8E9kIxWDcPRIuC7yz2NzQDcU
 TN7NM+jyKvT5zVQy+qnjbpEg+YJUD8i+8Ei8N/l/1O0ePbYolvfKMJ5d4daTx3ukGnnp
 qvDI95wH4meDTzbd6iHmRHjUzp2kgvdL/nviLXh04IunhfAeY/PslYgF93akUQc/v84g
 herQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684242488; x=1686834488;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HJHNd7bhq76oViGBMTkjpl95N0k1z7OPp4YBl+C87Us=;
 b=WQ20qcI8v2GOIRoBcGcAemdPevMxsK9D/aF/542AyAoHhQa4s1aC2XQg4dYCpoMjiR
 w/YAU/7oStdB3i7taf/pD3jAvQR9ASPLTzzxCzvs3ImRSyvHDA2g0S86DJjmNIUkmzEd
 +rCMruyk8y9cHqkKdy83uexLEGqiOIuJM44WC+OXTZ+P+YpeEgfWhUAtxluXP/Aaj3/m
 OZkd8F1udztTBsM7QdMyU+mBESLNGutyHfV4bU+UAzqXbIkzB0+Rojv/778Huk81SuNc
 UMWQHf/jTsJaIOonXF98Vs+WdXcZnFAMqWFFynUAb04xpxyGjwVYGkF/gAoPxbdVkoiY
 HwJw==
X-Gm-Message-State: AC+VfDy+BoRG1sIwUJ1Non5y0MX4Sk5nUyz6EIVnRHtS+DBzx3XSBI5I
 2AsO4rBZhk709ayr4jrvFern5Ez0GpNF+SoGykP4jz3G
X-Google-Smtp-Source: ACHHUZ5DykOsZ5BRf9OOCR6Cgnq+eFFzDg+rVXCqzXzIuegi57eVfigB/ZlA7+6vyG69ZLyfGXUZ/0q4ffaKoKqSPWk=
X-Received: by 2002:a05:6808:23c2:b0:394:65f4:f146 with SMTP id
 bq2-20020a05680823c200b0039465f4f146mr9658934oib.5.1684242487655; Tue, 16 May
 2023 06:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230516025105.795595-1-evan.quan@amd.com>
In-Reply-To: <20230516025105.795595-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 May 2023 09:07:56 -0400
Message-ID: <CADnq5_P6txuJ6aHQehxeH+y9iT7nbwuFXtHRDnbTcT9CWsWaVA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: add delay to avoid unintened shutdown due to
 hotspot temperature spark
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 15, 2023 at 10:52=E2=80=AFPM Evan Quan <evan.quan@amd.com> wrot=
e:
>
> There will be a double check for the hotspot temperature on delay
> expired. This can avoid unintended shutdown due to hotspot temperature
> spark.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> --
> v1->v2:
>   - add the proper millidegree Celsius to degree Celsius transform
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 14 ++++++++
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 34 +++++++++++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  2 ++
>  .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  9 ++---
>  .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  9 ++---

Can you extend this to the older powerplay code as well?

>  6 files changed, 55 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 39192eba3ff8..4cd873659365 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -243,6 +243,7 @@ extern int amdgpu_num_kcq;
>  #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
>  extern int amdgpu_vcnfw_log;
>  extern int amdgpu_sg_display;
> +extern uint amdgpu_ctf_delay;
>
>  #define AMDGPU_VM_MAX_NUM_CTX                  4096
>  #define AMDGPU_SG_THRESHOLD                    (256*1024*1024)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 749eeb9a2976..6c699fefdf92 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -198,6 +198,7 @@ int amdgpu_smartshift_bias;
>  int amdgpu_use_xgmi_p2p =3D 1;
>  int amdgpu_vcnfw_log;
>  int amdgpu_sg_display =3D -1; /* auto */
> +uint amdgpu_ctf_delay =3D 50; /* in ms */
>
>  static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *wo=
rk);
>
> @@ -973,6 +974,19 @@ MODULE_PARM_DESC(smu_pptable_id,
>         "specify pptable id to be used (-1 =3D auto(default) value, 0 =3D=
 use pptable from vbios, > 0 =3D soft pptable id)");
>  module_param_named(smu_pptable_id, amdgpu_smu_pptable_id, int, 0444);
>
> +/**
> + * DOC: ctf_delay (uint)
> + * On SW CTF triggerred, to protect the chip from over-heated and possib=
le damage, we usually
> + * trigger a system shutdown. However, considering there may be a hotspo=
t temperature spark
> + * momentarily hitting the SW CTF setting point, a delay is added to avo=
id unintended shutdown.
> + * On the delay expired, the shutdown will be performed if the hotspot t=
emp is still
> + * bigger than the SW CTF setting. Otherwise, nothing will be done.
> + * The default setting for the delay is 50ms.
> + */
> +MODULE_PARM_DESC(ctf_delay,
> +               "the delay(default 50ms) enforced before real action take=
n on ctf triggerred");
> +module_param_named(ctf_delay, amdgpu_ctf_delay, uint, 0444);

I think we can probably drop this.  I don't see a need for users to
adjust this and it could be bad for the hardware if it gets set too
long.

> +
>  /* These devices are not supported by amdgpu.
>   * They are supported by the mach64, r128, radeon drivers
>   */
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/=
amd/pm/swsmu/amdgpu_smu.c
> index 3c860939031e..71153b335ad9 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> @@ -24,6 +24,7 @@
>
>  #include <linux/firmware.h>
>  #include <linux/pci.h>
> +#include <linux/reboot.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_smu.h"
> @@ -1070,6 +1071,34 @@ static void smu_interrupt_work_fn(struct work_stru=
ct *work)
>                 smu->ppt_funcs->interrupt_work(smu);
>  }
>
> +static void smu_swctf_delayed_work_handler(struct work_struct *work)
> +{
> +       struct smu_context *smu =3D
> +               container_of(work, struct smu_context, swctf_delayed_work=
.work);
> +       struct smu_temperature_range *range =3D
> +                               &smu->thermal_range;
> +       struct amdgpu_device *adev =3D smu->adev;
> +       uint32_t hotspot_tmp, size;
> +
> +       /*
> +        * If the hotspot temperature is confirmed as below SW CTF settin=
g point
> +        * after the delay enforced, nothing will be done.
> +        * Otherwise, a graceful shutdown will be performed to prevent fu=
rther damage.
> +        */
> +       if (smu->ppt_funcs->read_sensor &&
> +           !smu->ppt_funcs->read_sensor(smu,
> +                                        AMDGPU_PP_SENSOR_HOTSPOT_TEMP,
> +                                        &hotspot_tmp,
> +                                        &size) &&
> +           range->software_shutdown_temp &&
> +           hotspot_tmp / 1000 < range->software_shutdown_temp)
> +               return;
> +
> +       dev_emerg(adev->dev, "ERROR: GPU over temperature range(SW CTF) d=
etected!\n");
> +       dev_emerg(adev->dev, "ERROR: System is going to shutdown due to G=
PU SW CTF!\n");
> +       orderly_poweroff(true);
> +}
> +
>  static int smu_sw_init(void *handle)
>  {
>         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
> @@ -1358,6 +1387,9 @@ static int smu_smc_hw_setup(struct smu_context *smu=
)
>                 return ret;
>         }
>
> +       INIT_DELAYED_WORK(&smu->swctf_delayed_work,
> +                         smu_swctf_delayed_work_handler);
> +
>         ret =3D smu_enable_thermal_alert(smu);
>         if (ret) {
>           dev_err(adev->dev, "Failed to enable thermal alert!\n");
> @@ -1592,6 +1624,8 @@ static int smu_smc_hw_cleanup(struct smu_context *s=
mu)
>                 return ret;
>         }
>
> +       cancel_delayed_work_sync(&smu->swctf_delayed_work);
> +
>         ret =3D smu_disable_dpms(smu);
>         if (ret) {
>                 dev_err(adev->dev, "Fail to disable dpm features!\n");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/=
drm/amd/pm/swsmu/inc/amdgpu_smu.h
> index 4ce394903c07..18101ec0ae6e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
> @@ -573,6 +573,8 @@ struct smu_context
>         u32 debug_param_reg;
>         u32 debug_msg_reg;
>         u32 debug_resp_reg;
> +
> +       struct delayed_work             swctf_delayed_work;
>  };
>
>  struct i2c_adapter;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index e1ef88ee1ed3..4c3c682bf7a0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1412,13 +1412,8 @@ static int smu_v11_0_irq_process(struct amdgpu_dev=
ice *adev,
>         if (client_id =3D=3D SOC15_IH_CLIENTID_THM) {
>                 switch (src_id) {
>                 case THM_11_0__SRCID__THM_DIG_THERM_L2H:
> -                       dev_emerg(adev->dev, "ERROR: GPU over temperature=
 range(SW CTF) detected!\n");
> -                       /*
> -                        * SW CTF just occurred.
> -                        * Try to do a graceful shutdown to prevent furth=
er damage.
> -                        */
> -                       dev_emerg(adev->dev, "ERROR: System is going to s=
hutdown due to GPU SW CTF!\n");
> -                       orderly_poweroff(true);
> +                       schedule_delayed_work(&smu->swctf_delayed_work,
> +                                             msecs_to_jiffies(amdgpu_ctf=
_delay));
>                 break;
>                 case THM_11_0__SRCID__THM_DIG_THERM_H2L:
>                         dev_emerg(adev->dev, "ERROR: GPU under temperatur=
e range detected\n");
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index 0bc0a6e97b5a..a5447119d5f5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1377,13 +1377,8 @@ static int smu_v13_0_irq_process(struct amdgpu_dev=
ice *adev,
>         if (client_id =3D=3D SOC15_IH_CLIENTID_THM) {
>                 switch (src_id) {
>                 case THM_11_0__SRCID__THM_DIG_THERM_L2H:
> -                       dev_emerg(adev->dev, "ERROR: GPU over temperature=
 range(SW CTF) detected!\n");
> -                       /*
> -                        * SW CTF just occurred.
> -                        * Try to do a graceful shutdown to prevent furth=
er damage.
> -                        */
> -                       dev_emerg(adev->dev, "ERROR: System is going to s=
hutdown due to GPU SW CTF!\n");
> -                       orderly_poweroff(true);
> +                       schedule_delayed_work(&smu->swctf_delayed_work,
> +                                             msecs_to_jiffies(amdgpu_ctf=
_delay));
>                         break;
>                 case THM_11_0__SRCID__THM_DIG_THERM_H2L:
>                         dev_emerg(adev->dev, "ERROR: GPU under temperatur=
e range detected\n");
> --
> 2.34.1
>
