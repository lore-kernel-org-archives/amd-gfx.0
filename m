Return-Path: <SRS0=rOad=5B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E6DC18E5B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 17:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C84E2205ED
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2020 17:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA4w9GpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84E2205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 878AF6E212;
	Mon, 16 Mar 2020 17:41:43 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0F76E212
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 17:41:42 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id f7so19045869wml.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2020 10:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yMLcoqz/70ELVfhHxjE/pwW76VmoFx2bBXPCk0xiNKM=;
 b=WA4w9GpYyHWo14oWqnYIoMA2I3OCHugNrK7TTl/2S6HJxVGTWk5iIZ5xMyCFeIQbn3
 FIRBtzhcxNpG1fVjDDABtc/nm6ty51vFk1lyq7eATmDDmiPsb7oeqF9FkCip+QeZxCTo
 SQaB7riUyqUZ2lVLJnKmnLotw12XEq4flySwqGF79f7HeNmfTuwLvL/1hWWW3VI9PbJB
 a1vwUbTkfLMTzhG13YK158nMx+EiA7m6tcw2uUQ//fBdTfbi4+M9L6Lqtqk6MsIf4mP7
 Hk6gqUEndpw+KxpqXTU6bBo0dwAKo3gdEt6KVZQ6DED2A1OC6zS5iAu7UBs8NWqzl15y
 bYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yMLcoqz/70ELVfhHxjE/pwW76VmoFx2bBXPCk0xiNKM=;
 b=PDGdACOwr8t+T6RxkUtc4ySeitv4J8IW+dRgx2oDk/Clf9xY/H+PdMlSXCWuGBDhAM
 Ou55Pzk5i0RsGei1wRvmkbCtuiCunOszunU8/j95AOnA1DUfpXk4WCL4oDfQdd0SAU8r
 VERuHu638X4zQoZwprn3jyXh6NPv/6MAG7Jx0uWKxK+IkkV1F9RjnPdVveeydntG68Ff
 PtJw3N9xB5BwPvKmQQgDraXszuffaEGITJxwpgdmEQzDgBTZZ1GO1aHV4wuqwoHdSHe4
 TmvFsgInhEAScRYe5c1sC+CpulBNSGm1uHBtJcwYa5o4yliHiUip121tyEzoTnHo+61V
 wx7Q==
X-Gm-Message-State: ANhLgQ3P6Eg6fy6WZHrsF7hc07B2JJvKN4BNyTXnCukIlg9hDg4PQWv1
 pBN1+3jS3xa9eHkf/qfj6BOVbUMcirtAdMT8odc=
X-Google-Smtp-Source: ADFU+vvrtdXaEyOMqqq2x5YUeRgQsnJuEO1SZI2Q1Ne3sEh68cEY0Op+0zBkElT7zXQBDcM3jeChdpCvEEejlmWXMH8=
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr215081wmk.79.1584380500881;
 Mon, 16 Mar 2020 10:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <1584155137-9628-1-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1584155137-9628-1-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2020 13:41:29 -0400
Message-ID: <CADnq5_O0=Jzs743dT93usLZ7hDeZfw1N7bnQd+h84FuORbBp-Q@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Russell,
 Kent" <Kent.Russell@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 13, 2020 at 11:05 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Puts the i2c adapter in common place for sharing by RAS
> and upcoming data read from FRU EEPROM feature.
>
> v2:
> Move i2c adapter to amdgpu_pm and rename it.
>
> v3: Move i2c adapter init to ASIC specific code and get rid
> of the switch case in amdgpu_device
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h            |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c     | 48 ++++------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h     |  2 -
>  drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c         | 14 ++++---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c         | 10 +++++
>  drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       |  4 +-
>  .../gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c   | 11 +++++
>  7 files changed, 41 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> index 1685794..936d85a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> @@ -448,6 +448,8 @@ struct amdgpu_pm {
>         /* powerplay feature */
>         uint32_t pp_feature;
>
> +       /* Used for I2C access to various EEPROMs on relevant ASICs */
> +       struct i2c_adapter smu_i2c;
>  };
>
>  #define R600_SSTU_DFLT                               0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> index ed15b1f..c009609 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> @@ -25,7 +25,6 @@
>  #include "amdgpu.h"
>  #include "amdgpu_ras.h"
>  #include <linux/bits.h>
> -#include "smu_v11_0_i2c.h"
>  #include "atom.h"
>
>  #define EEPROM_I2C_TARGET_ADDR_VEGA20          0xA0
> @@ -124,6 +123,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>                                  unsigned char *buff)
>  {
>         int ret = 0;
> +       struct amdgpu_device *adev = to_amdgpu_device(control);
>         struct i2c_msg msg = {
>                         .addr   = 0,
>                         .flags  = 0,
> @@ -137,7 +137,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
>
>         msg.addr = control->i2c_address;
>
> -       ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
> +       ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
>         if (ret < 1)
>                 DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
>
> @@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>                         .buf    = buff,
>         };
>
> +       /* Verify i2c adapter is initialized */
> +       if (!adev->pm.smu_i2c.algo)
> +               return -ENOENT;
> +
>         if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
>                 return -EINVAL;
>
>         mutex_init(&control->tbl_mutex);
>
> -       switch (adev->asic_type) {
> -       case CHIP_VEGA20:
> -               ret = smu_v11_0_i2c_eeprom_control_init(&control->eeprom_accessor);
> -               break;
> -
> -       case CHIP_ARCTURUS:
> -               ret = smu_i2c_eeprom_init(&adev->smu, &control->eeprom_accessor);
> -               break;
> -
> -       default:
> -               return 0;
> -       }
> -
> -       if (ret) {
> -               DRM_ERROR("Failed to init I2C controller, ret:%d", ret);
> -               return ret;
> -       }
> -
>         msg.addr = control->i2c_address;
> -
>         /* Read/Create table header from EEPROM address 0 */
> -       ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
> +       ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
>         if (ret < 1) {
>                 DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
>                 return ret;
> @@ -303,23 +288,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
>         return ret == 1 ? 0 : -EIO;
>  }
>
> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control)
> -{
> -       struct amdgpu_device *adev = to_amdgpu_device(control);
> -
> -       switch (adev->asic_type) {
> -       case CHIP_VEGA20:
> -               smu_v11_0_i2c_eeprom_control_fini(&control->eeprom_accessor);
> -               break;
> -       case CHIP_ARCTURUS:
> -               smu_i2c_eeprom_fini(&adev->smu, &control->eeprom_accessor);
> -               break;
> -
> -       default:
> -               return;
> -       }
> -}
> -
>  static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
>                                           struct eeprom_table_record *record,
>                                           unsigned char *buff)
> @@ -476,7 +444,7 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
>                 control->next_addr += EEPROM_TABLE_RECORD_SIZE;
>         }
>
> -       ret = i2c_transfer(&control->eeprom_accessor, msgs, num);
> +       ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
>         if (ret < 1) {
>                 DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> index ca78f81..7e8647a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> @@ -44,7 +44,6 @@ struct amdgpu_ras_eeprom_table_header {
>
>  struct amdgpu_ras_eeprom_control {
>         struct amdgpu_ras_eeprom_table_header tbl_hdr;
> -       struct i2c_adapter eeprom_accessor;
>         uint32_t next_addr;
>         unsigned int num_recs;
>         struct mutex tbl_mutex;
> @@ -79,7 +78,6 @@ struct eeprom_table_record {
>  }__attribute__((__packed__));
>
>  int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control);
>  int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
>
>  int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> index c902f26..9bffbab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> @@ -46,8 +46,7 @@
>  #define I2C_NO_STOP    1
>  #define I2C_RESTART    2
>
> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
> -#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>
>  static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
>  {
> @@ -592,7 +591,8 @@ static uint32_t smu_v11_0_i2c_eeprom_write_data(struct i2c_adapter *control,
>
>  static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
>  {
> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
> +       struct amdgpu_device *adev = to_amdgpu_device(i2c);
> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>
>         if (!smu_v11_0_i2c_bus_lock(i2c)) {
>                 DRM_ERROR("Failed to lock the bus from SMU");
> @@ -610,7 +610,8 @@ static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
>
>  static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
>  {
> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
> +       struct amdgpu_device *adev = to_amdgpu_device(i2c);
> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>
>         if (!smu_v11_0_i2c_bus_unlock(i2c)) {
>                 DRM_ERROR("Failed to unlock the bus from SMU");
> @@ -630,7 +631,8 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
>                               struct i2c_msg *msgs, int num)
>  {
>         int i, ret;
> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c_adap);
> +       struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
>
>         if (!control->bus_locked) {
>                 DRM_ERROR("I2C bus unlocked, stopping transaction!");
> @@ -679,7 +681,7 @@ int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
>         control->class = I2C_CLASS_SPD;
>         control->dev.parent = &adev->pdev->dev;
>         control->algo = &smu_v11_0_i2c_eeprom_i2c_algo;
> -       snprintf(control->name, sizeof(control->name), "RAS EEPROM");
> +       snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
>         control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
>
>         res = i2c_add_adapter(control);
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 8de8436..0273c63 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -932,6 +932,13 @@ static int smu_sw_init(void *handle)
>                 return ret;
>         }
>
> +       if (adev->smu.ppt_funcs->i2c_eeprom_init) {
> +               ret = smu_i2c_eeprom_init(smu, &adev->pm.smu_i2c);
> +
> +               if (ret)
> +                       return ret;
> +       }
> +
>         return 0;
>  }
>
> @@ -941,6 +948,9 @@ static int smu_sw_fini(void *handle)
>         struct smu_context *smu = &adev->smu;
>         int ret;
>
> +       if (adev->smu.ppt_funcs->i2c_eeprom_fini)
> +               smu_i2c_eeprom_fini(smu, &adev->pm.smu_i2c);
> +
>         kfree(smu->irq_source);
>         smu->irq_source = NULL;
>
> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> index 61596e8..c6d3bef 100644
> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> @@ -41,7 +41,7 @@
>  #include <linux/pci.h>
>  #include "amdgpu_ras.h"
>
> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
>
>  #define CTF_OFFSET_EDGE                        5
>  #define CTF_OFFSET_HOTSPOT             5
> @@ -2190,7 +2190,7 @@ static int arcturus_i2c_eeprom_control_init(struct i2c_adapter *control)
>         control->class = I2C_CLASS_SPD;
>         control->dev.parent = &adev->pdev->dev;
>         control->algo = &arcturus_i2c_eeprom_i2c_algo;
> -       snprintf(control->name, sizeof(control->name), "RAS EEPROM");
> +       snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
>
>         res = i2c_add_adapter(control);
>         if (res)
> diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> index 49e5ef3..16aa171 100644
> --- a/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/smumgr/vega20_smumgr.c
> @@ -33,6 +33,8 @@
>  #include "smu7_smumgr.h"
>  #include "vega20_hwmgr.h"
>
> +#include "smu_v11_0_i2c.h"
> +
>  /* MP Apertures */
>  #define MP0_Public                     0x03800000
>  #define MP0_SRAM                       0x03900000
> @@ -406,6 +408,7 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
>         struct vega20_smumgr *priv;
>         unsigned long tools_size = 0x19000;
>         int ret = 0;
> +       struct amdgpu_device *adev = hwmgr->adev;
>
>         struct cgs_firmware_info info = {0};
>
> @@ -505,6 +508,10 @@ static int vega20_smu_init(struct pp_hwmgr *hwmgr)
>         priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].version = 0x01;
>         priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size = sizeof(DpmActivityMonitorCoeffInt_t);
>
> +       ret = smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
> +       if (ret)
> +               goto err4;
> +
>         return 0;
>
>  err4:
> @@ -537,6 +544,9 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
>  {
>         struct vega20_smumgr *priv =
>                         (struct vega20_smumgr *)(hwmgr->smu_backend);
> +       struct amdgpu_device *adev = hwmgr->adev;
> +
> +       smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
>
>         if (priv) {
>                 amdgpu_bo_free_kernel(&priv->smu_tables.entry[TABLE_PPTABLE].handle,
> @@ -560,6 +570,7 @@ static int vega20_smu_fini(struct pp_hwmgr *hwmgr)
>                 kfree(hwmgr->smu_backend);
>                 hwmgr->smu_backend = NULL;
>         }
> +
>         return 0;
>  }
>
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
