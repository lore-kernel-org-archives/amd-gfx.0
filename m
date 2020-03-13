Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD67C10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 15:38:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A7E0206B7
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHDsxEgr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A7E0206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B79646EBFA;
	Fri, 13 Mar 2020 15:38:26 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 719F26EBFA
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 15:38:25 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id v11so12668799wrm.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 08:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LfR2THQ5Qq51uh97Fbh7ZNwv6fEJeVzcuyCMEq7CdEo=;
 b=UHDsxEgrt+MORP0dHeed7Wc5LknKgtNu/1oaLspIXSVuJ3GU6sTGdMrn/S2XQneOPU
 NBp8wa9fQcmQ4UklgUDR+LvmttcIExxCms+ANPcd53q8ZerYKH7/XQSmbOGIRajyEtWu
 h2Odl2venrwtUrLB0XJZFgHliqZinoIknzWHk/woRqNYlZdJ0yMnOFYoOl3n1VVPNzt8
 tCELYOZ4eMzYo870IKEd6whswX56U2ZwFg7PDTQPFe+xBgEg4Cnxq8QBYvw3mjItk9l5
 WTdBeJ+nryhtzhc7Tk//RkxQ1m32ff03iZRoKxGerq6vtWcp1nsro+ldQtUnFiIL9uy0
 UPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LfR2THQ5Qq51uh97Fbh7ZNwv6fEJeVzcuyCMEq7CdEo=;
 b=db2Y2OtR/XBaabUas1UQQHmhf0ixXzqzx0ooL5NN2/FhNkgHuH6AaI16i9Be+nJFBn
 KgvorPwn+AFE0ldpNwgtP5B+ijcENSIjF1Ww/aNm4TwIXFQw0I8HmfawGJeM9i7Ilswx
 74/PUfF29VL6vGEM/CbLzCshftT+5Qj3Sib4bDPd4MUK1FUcYfUALVv2b/n6963iwct+
 nzzXD2GKla/TCdqaPfMvu9xp6I1Zh8jrHuZagfuNEwh0LpKwGm2+nqApciwkq18ERPY0
 NBMLDQ4AERDW0J0bK2AjA89EwDpzgmQuhNJWkaxJFzSFJBsmJfWVs59aXlucgG2h1dUK
 ToqQ==
X-Gm-Message-State: ANhLgQ3v2nO8Ca8ycYWa6jZ+vbIdUgNrZu4HXo2RqcUVZXAz0Xb7+rk2
 nwoPaXFegkJ5dw4Llw6PW3JEhxCMlReXzE8LLJxulw==
X-Google-Smtp-Source: ADFU+vvwcbHSrHBji95nUMjxLj5ZyFbrE1VxMW3TRsBhVwtM6qcNcJXZqNjccAkpVKpjvTny6OsQ+ZeNvk5s4TJKl94=
X-Received: by 2002:adf:f74b:: with SMTP id z11mr19154624wrp.124.1584113903999; 
 Fri, 13 Mar 2020 08:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <1584111429-16165-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_Omf-e_OZExaCmASjs2WeNtp3sCKrcLGRhngDEhq+Vu+g@mail.gmail.com>
 <a50c30f4-0277-37b1-2abf-c7b58a656f44@amd.com>
In-Reply-To: <a50c30f4-0277-37b1-2abf-c7b58a656f44@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2020 11:38:12 -0400
Message-ID: <CADnq5_PcdeeoX_ZpRXHyn5ObdOnOgaCguQeWeVbssMJxr_JSqg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
To: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
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

On Fri, Mar 13, 2020 at 11:22 AM Andrey Grodzovsky
<Andrey.Grodzovsky@amd.com> wrote:
>
>
> On 3/13/20 11:10 AM, Alex Deucher wrote:
> > On Fri, Mar 13, 2020 at 10:57 AM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >> Puts the i2c adapter in common place for sharing by RAS
> >> and upcoming nvmlDeviceGetSerial from FRU EEPROM feature.
> >>
> >> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu.h            |  3 ++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 35 +++++++++++++++++++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 48 +++++---------------------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  2 --
> >>   drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c     | 14 ++++----
> >>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   |  2 +-
> >>   6 files changed, 55 insertions(+), 49 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> index c00831f..f807237 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> >> @@ -979,6 +979,9 @@ struct amdgpu_device {
> >>
> >>          bool                            pm_sysfs_en;
> >>          bool                            ucode_sysfs_en;
> >> +
> >> +       /* Used for I2C access to various EEPROMs on relevant ASICs */
> >> +       struct i2c_adapter eeprom_accessor;
> > Maybe call this smu_i2c?  Since it's not really eeprom only.  Also
> > maybe put it in struct amdgpu_pm?
>
> amdgpu_pm makes sense for MI-100 where we go through amdgpu_pm interface to send SMU message
> but for MI-60 where we do I2C directly  it seems to me at least that this has nothing to with amdgpu_pm
>

Well for vega20, you still have to take the i2c lock in the smu, so we
need to make sure the SMU is initialized first.  So I think it makes
sense.

Alex

> Andrey
>
>
> >
> >>   };
> >>
> >>   static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_bo_device *bdev)
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index a35c899..80fcc16 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> @@ -68,6 +68,8 @@
> >>   #include <linux/suspend.h>
> >>   #include <drm/task_barrier.h>
> >>
> >> +#include "smu_v11_0_i2c.h"
> >> +
> >>   MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
> >>   MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
> >>   MODULE_FIRMWARE("amdgpu/raven_gpu_info.bin");
> >> @@ -1848,6 +1850,33 @@ static int amdgpu_device_fw_loading(struct amdgpu_device *adev)
> >>          return r;
> >>   }
> >>
> >> +static int amdgpu_eeprom_init(struct amdgpu_device *adev)
> >> +{
> >> +       switch (adev->asic_type) {
> >> +       case CHIP_VEGA20:
> >> +               return smu_v11_0_i2c_eeprom_control_init(&adev->eeprom_accessor);
> >> +       case CHIP_ARCTURUS:
> >> +               return smu_i2c_eeprom_init(&adev->smu, &adev->eeprom_accessor);
> >> +       default:
> >> +               return 0;
> >> +       }
> >> +}
> >> +
> >> +void amdgpu_eeprom_fini(struct amdgpu_device *adev)
> >> +{
> >> +
> >> +       switch (adev->asic_type) {
> >> +       case CHIP_VEGA20:
> >> +               smu_v11_0_i2c_eeprom_control_fini(&adev->eeprom_accessor);
> >> +               return;
> >> +       case CHIP_ARCTURUS:
> >> +               smu_i2c_eeprom_fini(&adev->smu, &adev->eeprom_accessor);
> >> +               return;
> >> +       default:
> >> +               return;
> >> +       }
> >> +}
> >> +
> > Please put these in a separate amdgpu_eeprom.c/h files or call their
> > contents directly from their respective powerplay SMU files for each
> > asic since they are tied to SMU init anyway.
> >
> >>   /**
> >>    * amdgpu_device_ip_init - run init for hardware IPs
> >>    *
> >> @@ -1936,6 +1965,10 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
> >>          if (r)
> >>                  goto init_failed;
> >>
> >> +       r = amdgpu_eeprom_init(adev);
> >> +       if (r)
> >> +               goto init_failed;
> >> +
> >>          /*
> >>           * retired pages will be loaded from eeprom and reserved here,
> >>           * it should be called after amdgpu_device_ip_hw_init_phase2  since
> >> @@ -2196,6 +2229,8 @@ static int amdgpu_device_ip_fini(struct amdgpu_device *adev)
> >>
> >>          amdgpu_ras_pre_fini(adev);
> >>
> >> +       amdgpu_eeprom_fini(adev);
> >> +
> >>          if (adev->gmc.xgmi.num_physical_nodes > 1)
> >>                  amdgpu_xgmi_remove_device(adev);
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> >> index ed15b1f..14f6571 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> >> @@ -25,7 +25,6 @@
> >>   #include "amdgpu.h"
> >>   #include "amdgpu_ras.h"
> >>   #include <linux/bits.h>
> >> -#include "smu_v11_0_i2c.h"
> >>   #include "atom.h"
> >>
> >>   #define EEPROM_I2C_TARGET_ADDR_VEGA20          0xA0
> >> @@ -124,6 +123,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
> >>                                   unsigned char *buff)
> >>   {
> >>          int ret = 0;
> >> +       struct amdgpu_device *adev = to_amdgpu_device(control);
> >>          struct i2c_msg msg = {
> >>                          .addr   = 0,
> >>                          .flags  = 0,
> >> @@ -137,7 +137,7 @@ static int __update_table_header(struct amdgpu_ras_eeprom_control *control,
> >>
> >>          msg.addr = control->i2c_address;
> >>
> >> -       ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
> >> +       ret = i2c_transfer(&adev->eeprom_accessor, &msg, 1);
> >>          if (ret < 1)
> >>                  DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
> >>
> >> @@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
> >>                          .buf    = buff,
> >>          };
> >>
> >> +       /* Verify i2c adapter is initialized */
> >> +       if (!adev->eeprom_accessor.algo)
> >> +               return -ENOENT;
> >> +
> >>          if (!__get_eeprom_i2c_addr(adev, &control->i2c_address))
> >>                  return -EINVAL;
> >>
> >>          mutex_init(&control->tbl_mutex);
> >>
> >> -       switch (adev->asic_type) {
> >> -       case CHIP_VEGA20:
> >> -               ret = smu_v11_0_i2c_eeprom_control_init(&control->eeprom_accessor);
> >> -               break;
> >> -
> >> -       case CHIP_ARCTURUS:
> >> -               ret = smu_i2c_eeprom_init(&adev->smu, &control->eeprom_accessor);
> >> -               break;
> >> -
> >> -       default:
> >> -               return 0;
> >> -       }
> >> -
> >> -       if (ret) {
> >> -               DRM_ERROR("Failed to init I2C controller, ret:%d", ret);
> >> -               return ret;
> >> -       }
> >> -
> >>          msg.addr = control->i2c_address;
> >> -
> >>          /* Read/Create table header from EEPROM address 0 */
> >> -       ret = i2c_transfer(&control->eeprom_accessor, &msg, 1);
> >> +       ret = i2c_transfer(&adev->eeprom_accessor, &msg, 1);
> >>          if (ret < 1) {
> >>                  DRM_ERROR("Failed to read EEPROM table header, ret:%d", ret);
> >>                  return ret;
> >> @@ -303,23 +288,6 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
> >>          return ret == 1 ? 0 : -EIO;
> >>   }
> >>
> >> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control)
> >> -{
> >> -       struct amdgpu_device *adev = to_amdgpu_device(control);
> >> -
> >> -       switch (adev->asic_type) {
> >> -       case CHIP_VEGA20:
> >> -               smu_v11_0_i2c_eeprom_control_fini(&control->eeprom_accessor);
> >> -               break;
> >> -       case CHIP_ARCTURUS:
> >> -               smu_i2c_eeprom_fini(&adev->smu, &control->eeprom_accessor);
> >> -               break;
> >> -
> >> -       default:
> >> -               return;
> >> -       }
> >> -}
> >> -
> >>   static void __encode_table_record_to_buff(struct amdgpu_ras_eeprom_control *control,
> >>                                            struct eeprom_table_record *record,
> >>                                            unsigned char *buff)
> >> @@ -476,7 +444,7 @@ int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
> >>                  control->next_addr += EEPROM_TABLE_RECORD_SIZE;
> >>          }
> >>
> >> -       ret = i2c_transfer(&control->eeprom_accessor, msgs, num);
> >> +       ret = i2c_transfer(&adev->eeprom_accessor, msgs, num);
> >>          if (ret < 1) {
> >>                  DRM_ERROR("Failed to process EEPROM table records, ret:%d", ret);
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> >> index ca78f81..7e8647a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h
> >> @@ -44,7 +44,6 @@ struct amdgpu_ras_eeprom_table_header {
> >>
> >>   struct amdgpu_ras_eeprom_control {
> >>          struct amdgpu_ras_eeprom_table_header tbl_hdr;
> >> -       struct i2c_adapter eeprom_accessor;
> >>          uint32_t next_addr;
> >>          unsigned int num_recs;
> >>          struct mutex tbl_mutex;
> >> @@ -79,7 +78,6 @@ struct eeprom_table_record {
> >>   }__attribute__((__packed__));
> >>
> >>   int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control);
> >> -void amdgpu_ras_eeprom_fini(struct amdgpu_ras_eeprom_control *control);
> >>   int amdgpu_ras_eeprom_reset_table(struct amdgpu_ras_eeprom_control *control);
> >>
> >>   int amdgpu_ras_eeprom_process_recods(struct amdgpu_ras_eeprom_control *control,
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> >> index c902f26..1df57ba 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> >> @@ -46,8 +46,7 @@
> >>   #define I2C_NO_STOP    1
> >>   #define I2C_RESTART    2
> >>
> >> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
> >> -#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
> >> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, eeprom_accessor))
> >>
> >>   static void smu_v11_0_i2c_set_clock_gating(struct i2c_adapter *control, bool en)
> >>   {
> >> @@ -592,7 +591,8 @@ static uint32_t smu_v11_0_i2c_eeprom_write_data(struct i2c_adapter *control,
> >>
> >>   static void lock_bus(struct i2c_adapter *i2c, unsigned int flags)
> >>   {
> >> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
> >> +       struct amdgpu_device *adev = to_amdgpu_device(i2c);
> >> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
> >>
> >>          if (!smu_v11_0_i2c_bus_lock(i2c)) {
> >>                  DRM_ERROR("Failed to lock the bus from SMU");
> >> @@ -610,7 +610,8 @@ static int trylock_bus(struct i2c_adapter *i2c, unsigned int flags)
> >>
> >>   static void unlock_bus(struct i2c_adapter *i2c, unsigned int flags)
> >>   {
> >> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c);
> >> +       struct amdgpu_device *adev = to_amdgpu_device(i2c);
> >> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
> >>
> >>          if (!smu_v11_0_i2c_bus_unlock(i2c)) {
> >>                  DRM_ERROR("Failed to unlock the bus from SMU");
> >> @@ -630,7 +631,8 @@ static int smu_v11_0_i2c_eeprom_i2c_xfer(struct i2c_adapter *i2c_adap,
> >>                                struct i2c_msg *msgs, int num)
> >>   {
> >>          int i, ret;
> >> -       struct amdgpu_ras_eeprom_control *control = to_eeprom_control(i2c_adap);
> >> +       struct amdgpu_device *adev = to_amdgpu_device(i2c_adap);
> >> +       struct amdgpu_ras_eeprom_control *control = &adev->psp.ras.ras->eeprom_control;
> >>
> >>          if (!control->bus_locked) {
> >>                  DRM_ERROR("I2C bus unlocked, stopping transaction!");
> >> @@ -679,7 +681,7 @@ int smu_v11_0_i2c_eeprom_control_init(struct i2c_adapter *control)
> >>          control->class = I2C_CLASS_SPD;
> >>          control->dev.parent = &adev->pdev->dev;
> >>          control->algo = &smu_v11_0_i2c_eeprom_i2c_algo;
> >> -       snprintf(control->name, sizeof(control->name), "RAS EEPROM");
> >> +       snprintf(control->name, sizeof(control->name), "AMDGPU EEPROM");
> >>          control->lock_ops = &smu_v11_0_i2c_i2c_lock_ops;
> >>
> >>          res = i2c_add_adapter(control);
> >> diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> >> index 61596e8..94edb29 100644
> >> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> >> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> >> @@ -41,7 +41,7 @@
> >>   #include <linux/pci.h>
> >>   #include "amdgpu_ras.h"
> >>
> >> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
> >> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, eeprom_accessor))
> >>
> >>   #define CTF_OFFSET_EDGE                        5
> >>   #define CTF_OFFSET_HOTSPOT             5
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7C5742bd5089f541184ff508d7c760c33e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637197090716969372&amp;sdata=GWCh4fy1nKfoUJm4VvS5iBKIU6i1NzcBjUNF3bs81ms%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
