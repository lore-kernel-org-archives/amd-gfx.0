Return-Path: <SRS0=NWgq=46=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B254CC10DCE
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A3372074B
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2020 20:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UtlIwr3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A3372074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141436EC58;
	Fri, 13 Mar 2020 20:35:19 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F6C6EC58
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 20:35:17 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id t13so5307912wmi.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2020 13:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9Pnkh9/a9aRwMOL6kNtM5Gt1RUEVkpr3NoXEzVBy1cc=;
 b=UtlIwr3x1mzu9L2GM0oSncZR6sIE4FgR9R+XiUO9eJaCZncDNoi2azyW65Y3eTWvJ7
 yhQ3kpO4LLgdIZrVUwYq6vZ4vep0AYXaX9Y/cKIXumx5QIztX6oZ/VDs3lnvNI9eZ7GJ
 +n6NlHyebIrkDxj6bL7+NrIByb8M+nk15Kg/k/5Qbc5LGO426n/ZbmHrfahJYbhocAJr
 B8IecPis/FJ+h2K2+x2puSHyS0PLyf8bLmFFKq6zubfcdH62o5giwaakmX4MxzkE2MPZ
 VItbe0XQn01vEMwuEnmkMjTHESPDc2X+rDCrNN/heULzXgbrwEqan6bBDk70YbRi7kDS
 9iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9Pnkh9/a9aRwMOL6kNtM5Gt1RUEVkpr3NoXEzVBy1cc=;
 b=hkzFeMvWb2HFCvERIOD8KDkMqoj/XRGPW1L5z9PIGFzLz3+HHZB+EVBZ76gJaVvevZ
 677epQvESALVA6NZuyVKK7HtQvww6NT9Uv7+Bu8JsQjkFKnl+BCPfY+MNDLScmetjZnN
 hSuH1wTNu7X2kftLOpAjk1/APi6qvETd1s12C+YfXVmu6jYd4cSdTMKMPn05iS6p9Oc7
 nBMTse6TdwVKI/8rFpl7sCB0l1GSnLbzTHX5BPosNDgl99ZZsgDqdrAMWQpAe7GHqiYo
 MHDl8xjW7q25cziFg8p+BF3omvVoWadEiyB9UJISTBZh16ThDmSXmopKHJRfYJr5YXds
 IyoQ==
X-Gm-Message-State: ANhLgQ3uK26SXH+1sPozq6VcY/e5qM9I/WiAIueO7+HCBtkxhPRr1Bof
 Wwk/hTnfWF9Z9xlCgj1uZji26TWlrSK0pMF/ePM=
X-Google-Smtp-Source: ADFU+vvtgKizVg5L2cvcn6gFwIgVh78Dok5ZelkZiskSsSHQfvYCIrVeKdDCMw36vJy8nrjXxP/kBsFVfNSj72HGw/Q=
X-Received: by 2002:a05:600c:286:: with SMTP id
 6mr12766706wmk.56.1584131716306; 
 Fri, 13 Mar 2020 13:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <1584120001-30678-1-git-send-email-andrey.grodzovsky@amd.com>
 <CADnq5_P3FheHhJyOMUiYMq=AVPdqDxnKSf8CN=kNDdPPDob=YQ@mail.gmail.com>
 <9fb91951-aa8e-e5aa-241f-078f283adfbb@amd.com>
In-Reply-To: <9fb91951-aa8e-e5aa-241f-078f283adfbb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Mar 2020 16:35:05 -0400
Message-ID: <CADnq5_PMZ-FErHuF911=F0txW+5XyKfbN6s4h8DO2tO-KvKweg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Move EEPROM I2C adapter to amdgpu_device
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

On Fri, Mar 13, 2020 at 4:27 PM Andrey Grodzovsky
<Andrey.Grodzovsky@amd.com> wrote:
>
>
> On 3/13/20 2:29 PM, Alex Deucher wrote:
> > On Fri, Mar 13, 2020 at 1:20 PM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >> Puts the i2c adapter in common place for sharing by RAS
> >> and upcoming data read from FRU EEPROM feature.
> >>
> >> v2:
> >> Move i2c adapter to amdgpu_pm and rename it.
> >>
> >> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     | 35 +++++++++++++++++++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h        |  2 ++
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 48 +++++---------------------
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.h |  2 --
> >>   drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c     | 14 ++++----
> >>   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c   |  2 +-
> >>   6 files changed, 54 insertions(+), 49 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> >> index a35c899..c04107b 100644
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
> >> +               return smu_v11_0_i2c_eeprom_control_init(&adev->pm.smu_i2c);
> >> +       case CHIP_ARCTURUS:
> >> +               return smu_i2c_eeprom_init(&adev->smu, &adev->pm.smu_i2c);
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
> >> +               smu_v11_0_i2c_eeprom_control_fini(&adev->pm.smu_i2c);
> >> +               return;
> >> +       case CHIP_ARCTURUS:
> >> +               smu_i2c_eeprom_fini(&adev->smu, &adev->pm.smu_i2c);
> >> +               return;
> >> +       default:
> >> +               return;
> >> +       }
> >> +}
> >> +
> > I think maybe you missed my comments on this part.  I think it would
> > make sense move these function calls into the relevant SMU sw init
> > code.  E.g., call smu_v11_0_i2c_eeprom_control_fini() into
> > vega20_smu_init() in vega20_smumgr.c.  then add the whole switch
> > statement to smu_sw_init() in
> > amdgpu_smu.c for VEGA20 (alternative powerplay code) and ARCTURUS.
> > And the clean up in vega20_smu_fini() and smu_sw_fini()
> >
> > Alex
>
>
> Sorry, missed that indeed. For the ARCTURUS use case at least i am
> worried it might brake the code because from the comment here
> https://elixir.bootlin.com/linux/v5.6-rc5/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L1907
> i remember that smu_i2c_eeprom_init (ARCTURUS init call) must be called
> after HW init fully done and SMU is active while SW init happens way
> earlier.

ras_recovery_init can stay there, it does a lot of other stuff.
smu_i2c_eeprom_init() and smu_v11_0_i2c_eeprom_control_init() don't
actually touch the hw, they just create the i2c device.  It doesn't
get used until we actually try and access the EEPROM.

Alex

>
> Andrey
>
>
> >
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
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> >> index 1685794..936d85a 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dpm.h
> >> @@ -448,6 +448,8 @@ struct amdgpu_pm {
> >>          /* powerplay feature */
> >>          uint32_t pp_feature;
> >>
> >> +       /* Used for I2C access to various EEPROMs on relevant ASICs */
> >> +       struct i2c_adapter smu_i2c;
> >>   };
> >>
> >>   #define R600_SSTU_DFLT                               0
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
> >> index ed15b1f..c009609 100644
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
> >> +       ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
> >>          if (ret < 1)
> >>                  DRM_ERROR("Failed to write EEPROM table header, ret:%d", ret);
> >>
> >> @@ -251,33 +251,18 @@ int amdgpu_ras_eeprom_init(struct amdgpu_ras_eeprom_control *control)
> >>                          .buf    = buff,
> >>          };
> >>
> >> +       /* Verify i2c adapter is initialized */
> >> +       if (!adev->pm.smu_i2c.algo)
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
> >> +       ret = i2c_transfer(&adev->pm.smu_i2c, &msg, 1);
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
> >> +       ret = i2c_transfer(&adev->pm.smu_i2c, msgs, num);
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
> >> index c902f26..9bffbab 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/smu_v11_0_i2c.c
> >> @@ -46,8 +46,7 @@
> >>   #define I2C_NO_STOP    1
> >>   #define I2C_RESTART    2
> >>
> >> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
> >> -#define to_eeprom_control(x) container_of(x, struct amdgpu_ras_eeprom_control, eeprom_accessor)
> >> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
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
> >> index 61596e8..3c55a2d 100644
> >> --- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> >> +++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
> >> @@ -41,7 +41,7 @@
> >>   #include <linux/pci.h>
> >>   #include "amdgpu_ras.h"
> >>
> >> -#define to_amdgpu_device(x) (container_of(x, struct amdgpu_ras, eeprom_control.eeprom_accessor))->adev
> >> +#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
> >>
> >>   #define CTF_OFFSET_EDGE                        5
> >>   #define CTF_OFFSET_HOTSPOT             5
> >> --
> >> 2.7.4
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx@lists.freedesktop.org
> >> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Candrey.grodzovsky%40amd.com%7Cd2dc864bf8084e145daf08d7c77c899a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637197210006888820&amp;sdata=vw%2BE2j%2Fx8mkaTEvRyHMB4xRwRslv7sHMIBXZ92i7YqY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
