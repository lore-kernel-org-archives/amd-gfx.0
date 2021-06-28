Return-Path: <SRS0=DKNW=LW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_FONT_LOW_CONTRAST,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F12C2B9F4
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 15:34:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63AC661465
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jun 2021 15:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63AC661465
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3BE899A5;
	Mon, 28 Jun 2021 15:34:42 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45EE2899A5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 15:34:40 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id h2so26589762edt.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jun 2021 08:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=bnbWD+J8SplZhuiPSpqxbbkLSwoS8/TISbOPmTgw47E=;
 b=b7btceCt4JqUgE++HUi5klaNeeAC5x+PYPi4gf3n8MRIck/Vy5ZIbXlL6UcaguFN6y
 aketovORC/BBC5IW+ZD3r67O5LKfkJ/qdg0mZTnTCfGQCfIfmScaYAX8//1hCtlYFrAb
 3IKpjd4ZRO8mEme99eHM92H1YaaBF8ixAyv87GTB4ZriOy0PUh1hpFMM9YJtxnofj4bT
 WOnVFULbKMfUZZfhhn0ZHprPZqzkbaRbu0WNtixhnj3i8JuX8c/yJQIWXE6GW6wLNacX
 ToqN56zbKJ4TxuWXN6lOD3eTCQPTuvAzeaTp9oADCYoiHlL+MSFk3W6yUpKos4Bc5f2D
 Dggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=bnbWD+J8SplZhuiPSpqxbbkLSwoS8/TISbOPmTgw47E=;
 b=InGOURZYW28Fz5cPd3a85L8v0W2ZMiG4o9+VHi0ig80xK3S5TO0HHphcBpMFS5vUIE
 x/B/Oad52UtxhZZXSkoJBA3s+eCInhN3WJbIUsLpAbGrkSWjbTQPMzS6jZu4vQLWTS4X
 uRSzAT7IqutexRcccJMdJCn4D1/OwcUdUxMHHviCnz8iJl+wKr3iGA9xB3fkouxDZK2x
 bylRjZQBRVorThVX3WI6OEKjNDo6AgAWcUBJmDUYo3JPWCv+pwItFFsy/cJfSLYjZSDF
 wMtZK7y2zJh6moqO8i+CAic/sYOH154LV+GAeuW0UgfqgSUjSlGv3PTupxdgRqsb9ucG
 Ra+w==
X-Gm-Message-State: AOAM531kNPTIwan2HfxPPXY7qzgYB/IxoASIgnzSyFSXyf6Bd2bMKMj/
 PVr2rpuD3/nxw4yTm3uk5qHNk2RbxKc=
X-Google-Smtp-Source: ABdhPJyDMg7NkPoAS/iRRx/p6kUcc5IEyqSsSQMDn8wZ8tz/EOimgni+cLbWgmznEWhwbEd4Be9DUw==
X-Received: by 2002:a05:6402:10c3:: with SMTP id
 p3mr31253783edu.175.1624894478935; 
 Mon, 28 Jun 2021 08:34:38 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:4650:114e:394c:f6d4?
 ([2a02:908:1252:fb60:4650:114e:394c:f6d4])
 by smtp.gmail.com with ESMTPSA id l26sm9958039edt.40.2021.06.28.08.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jun 2021 08:34:38 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: add non-aligned address supported in
 amdgpu_device_vram_access()
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210625032409.15715-1-kevin1.wang@amd.com>
 <878b44fb-a768-6bc2-2873-b7a75fc5ee1e@gmail.com>
 <CO6PR12MB54736D0FD916C1F0C3F0C42FA2039@CO6PR12MB5473.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d8cceefa-b837-855c-3741-a418b1049578@gmail.com>
Date: Mon, 28 Jun 2021 17:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CO6PR12MB54736D0FD916C1F0C3F0C42FA2039@CO6PR12MB5473.namprd12.prod.outlook.com>
Content-Language: en-US
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>, "Min, Frank" <Frank.Min@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1819303360=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1819303360==
Content-Type: multipart/alternative;
 boundary="------------E8F99616BE672B93507D7328"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E8F99616BE672B93507D7328
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kevin,

the primary use of amdgpu_device_vram_access() is to gate direct kernel 
access to VRAM using the MM_INDEX/MM_DATA registers or aperture. It 
should by design never deal with data sizes != 4 bytes.

The amdgpu_ttm_access_memory() is for debug access to the backing store 
of BOs and also needs to handle per byte access.

What we can do is to also use amdgpu_device_vram_access() in 
amdgpu_device_vram_access() for the masked access, which would also 
solve a hot plug bug as far as I can see here.

But moving the byte access logic into amdgpu_device_vram_access() makes 
no sense at all.

Regards,
Christian.

Am 28.06.21 um 16:43 schrieb Wang, Kevin(Yang):
>
> [AMD Official Use Only]
>
>
> Hi Chris,
>
> amdgpu_ttm_access_memory(struct ttm_buffer_object *bo, unsigned long 
> offset, void *buf, int len,  int write)
>
> the above function will be called from kernel side (likes 
> 'get_user_pages' code path),  and the function should accept 
> non-aligned addresses.
> without this patch, this function will be using MM_INDEX/DATA to 
> handle aligned address whether in visible memory or not.
> for this kind of case , I think the driver should check whether VRAM 
> aperture works first, then using MM_INDEX/DATA as a backup option.
>
> for this patch, I only extend amdgpu_device_vram_access() function to 
> support un-aligned case, and the new function is fully compatible with 
> the old code logic.
> I can't understand why you give a NAK about this patch, I think it's a 
> good optimization, how do you think?
> thanks.
>
> Best Regards,
> Kevin
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Monday, June 28, 2021 10:10 PM
> *To:* Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: add non-aligned address supported 
> in amdgpu_device_vram_access()
> Am 25.06.21 um 05:24 schrieb Kevin Wang:
> > 1. add non-aligned address support in amdgpu_device_vram_access()
> > 2. reduce duplicate code in amdgpu_ttm_access_memory()
> >
> > because the MM_INDEX{HI}/DATA are protected register, it is not working
> > in sriov environment when mmio protect feature is enabled (in some 
> asics),
> > and the old function amdgpu_ttm_access_memory() will force using 
> MM_INDEX/DATA
> > to handle non-aligned address by default, it will cause the 
> register(MM_DATA)
> > is always return 0.
> >
> > with the patch, the memory will be accessed in the aper way first.
> > (in visible memory or enable pcie large-bar feature), then using
> > MM_INDEX{HI}/MM_DATA to access rest vram memroy.
>
> Well NAK to the whole approach.
>
> The amdgpu_device_vram_access() are intentionally *NOT* using the VRAM
> aperture nor providing byte wise access.
>
> And yes that this doesn't work under SRIOV is completely intentional as
> well.
>
> What we could do is to use the aperture in amdgpu_ttm_access_memory()
> for unaligned access if that is indeed a problem.
>
> Regards,
> Christian.
>
>
> >
> > Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69 ++++++++++++++++------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 42 ++-----------
> >   3 files changed, 58 insertions(+), 55 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index d14b4968a026..8095d9a9c857 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1103,7 +1103,7 @@ void amdgpu_device_fini(struct amdgpu_device 
> *adev);
> >   int amdgpu_gpu_wait_for_idle(struct amdgpu_device *adev);
> >
> >   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> > -                            uint32_t *buf, size_t size, bool write);
> > +                            void *buf, size_t size, bool write);
> >   uint32_t amdgpu_device_rreg(struct amdgpu_device *adev,
> >                            uint32_t reg, uint32_t acc_flags);
> >   void amdgpu_device_wreg(struct amdgpu_device *adev,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index e6702d136a6d..2047e3c2b365 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -280,6 +280,54 @@ bool amdgpu_device_supports_smart_shift(struct 
> drm_device *dev)
> > amdgpu_acpi_is_power_shift_control_supported());
> >   }
> >
> > +static inline void 
> amdgpu_device_vram_mmio_align_access_locked(struct amdgpu_device 
> *adev, loff_t pos,
> > + uint32_t *value, bool write)
> > +{
> > +     BUG_ON(!IS_ALIGNED(pos, 4));
> > +
> > +     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> > +     WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> > +     if (write)
> > +             WREG32_NO_KIQ(mmMM_DATA, *value);
> > +     else
> > +             *value = RREG32_NO_KIQ(mmMM_DATA);
> > +}
> > +
> > +static void amdgpu_device_vram_mmio_access_locked(struct 
> amdgpu_device *adev, loff_t pos,
> > + void *buf, size_t size, bool write)
> > +{
> > +     while (size) {
> > +             uint64_t aligned_pos = ALIGN_DOWN(pos, 4);
> > +             uint64_t bytes = 4 - (pos & 0x3);
> > +             uint32_t shift = (pos & 0x3) * 8;
> > +             uint32_t mask = 0xffffffff << shift;
> > +             uint32_t value = 0;
> > +
> > +             if (size < bytes) {
> > +                     mask &= 0xffffffff >> (bytes - size) * 8;
> > +                     bytes = size;
> > +             }
> > +
> > +             if (mask != 0xffffffff) {
> > + amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, 
> &value, false);
> > +                     if (write) {
> > +                             value &= ~mask;
> > +                             value |= (*(uint32_t *)buf << shift) & 
> mask;
> > + amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, 
> &value, true);
> > +                     } else {
> > +                             value = (value & mask) >> shift;
> > +                             memcpy(buf, &value, bytes);
> > +                     }
> > +             } else {
> > + amdgpu_device_vram_mmio_align_access_locked(adev, aligned_pos, 
> buf, write);
> > +             }
> > +
> > +             pos += bytes;
> > +             buf += bytes;
> > +             size -= bytes;
> > +     }
> > +}
> > +
> >   /*
> >    * VRAM access helper functions
> >    */
> > @@ -294,13 +342,11 @@ bool amdgpu_device_supports_smart_shift(struct 
> drm_device *dev)
> >    * @write: true - write to vram, otherwise - read from vram
> >    */
> >   void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
> > -                            uint32_t *buf, size_t size, bool write)
> > +                            void *buf, size_t size, bool write)
> >   {
> >        unsigned long flags;
> > -     uint32_t hi = ~0;
> >        uint64_t last;
> >
> > -
> >   #ifdef CONFIG_64BIT
> >        last = min(pos + size, adev->gmc.visible_vram_size);
> >        if (last > pos) {
> > @@ -321,25 +367,12 @@ void amdgpu_device_vram_access(struct 
> amdgpu_device *adev, loff_t pos,
> >                        return;
> >
> >                pos += count;
> > -             buf += count / 4;
> > +             buf += count;
> >                size -= count;
> >        }
> >   #endif
> > -
> > spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> > -     for (last = pos + size; pos < last; pos += 4) {
> > -             uint32_t tmp = pos >> 31;
> > -
> > -             WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> > -             if (tmp != hi) {
> > -                     WREG32_NO_KIQ(mmMM_INDEX_HI, tmp);
> > -                     hi = tmp;
> > -             }
> > -             if (write)
> > -                     WREG32_NO_KIQ(mmMM_DATA, *buf++);
> > -             else
> > -                     *buf++ = RREG32_NO_KIQ(mmMM_DATA);
> > -     }
> > +     amdgpu_device_vram_mmio_access_locked(adev, pos, buf, size, 
> write);
> > spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> >   }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 6297363ab740..cf5b8bdc2dd3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1430,8 +1430,6 @@ static int amdgpu_ttm_access_memory(struct 
> ttm_buffer_object *bo,
> >        struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
> >        struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
> >        struct amdgpu_res_cursor cursor;
> > -     unsigned long flags;
> > -     uint32_t value = 0;
> >        int ret = 0;
> >
> >        if (bo->mem.mem_type != TTM_PL_VRAM)
> > @@ -1439,41 +1437,13 @@ static int amdgpu_ttm_access_memory(struct 
> ttm_buffer_object *bo,
> >
> >        amdgpu_res_first(&bo->mem, offset, len, &cursor);
> >        while (cursor.remaining) {
> > -             uint64_t aligned_pos = cursor.start & ~(uint64_t)3;
> > -             uint64_t bytes = 4 - (cursor.start & 3);
> > -             uint32_t shift = (cursor.start & 3) * 8;
> > -             uint32_t mask = 0xffffffff << shift;
> > -
> > -             if (cursor.size < bytes) {
> > -                     mask &= 0xffffffff >> (bytes - cursor.size) * 8;
> > -                     bytes = cursor.size;
> > -             }
> > +             amdgpu_device_vram_access(adev, cursor.start,
> > +                                       buf, cursor.size,
> > +                                       write);
> >
> > -             if (mask != 0xffffffff) {
> > - spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> > -                     WREG32_NO_KIQ(mmMM_INDEX, 
> ((uint32_t)aligned_pos) | 0x80000000);
> > -                     WREG32_NO_KIQ(mmMM_INDEX_HI, aligned_pos >> 31);
> > -                     value = RREG32_NO_KIQ(mmMM_DATA);
> > -                     if (write) {
> > -                             value &= ~mask;
> > -                             value |= (*(uint32_t *)buf << shift) & 
> mask;
> > - WREG32_NO_KIQ(mmMM_DATA, value);
> > -                     }
> > - spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> > -                     if (!write) {
> > -                             value = (value & mask) >> shift;
> > -                             memcpy(buf, &value, bytes);
> > -                     }
> > -             } else {
> > -                     bytes = cursor.size & ~0x3ULL;
> > - amdgpu_device_vram_access(adev, cursor.start,
> > - (uint32_t *)buf, bytes,
> > - write);
> > -             }
> > -
> > -             ret += bytes;
> > -             buf = (uint8_t *)buf + bytes;
> > -             amdgpu_res_next(&cursor, bytes);
> > +             ret += cursor.size;
> > +             buf += cursor.size;
> > +             amdgpu_res_next(&cursor, cursor.size);
> >        }
> >
> >        return ret;
>


--------------E8F99616BE672B93507D7328
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Hi Kevin,<br>
    <br>
    the primary use of amdgpu_device_vram_access() is to gate direct
    kernel access to VRAM using the MM_INDEX/MM_DATA registers or
    aperture. It should by design never deal with data sizes != 4 bytes.<br>
    <br>
    The amdgpu_ttm_access_memory() is for debug access to the backing
    store of BOs and also needs to handle per byte access.<br>
    <br>
    What we can do is to also use amdgpu_device_vram_access() in
    amdgpu_device_vram_access() for the masked access, which would also
    solve a hot plug bug as far as I can see here.<br>
    <br>
    But moving the byte access logic into amdgpu_device_vram_access()
    makes no sense at all.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 28.06.21 um 16:43 schrieb Wang,
      Kevin(Yang):<br>
    </div>
    <blockquote type="cite"
cite="mid:CO6PR12MB54736D0FD916C1F0C3F0C42FA2039@CO6PR12MB5473.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:10pt;color:#0000FF;margin:15pt;"
        align="Left">
        [AMD Official Use Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">Hi Chris,</span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">amdgpu_ttm_access_memory(struct
            ttm_buffer_object *bo, unsigned long offset, void *buf, int
            len, </span><span style="font-family: &quot;segoe ui&quot;,
            &quot;segoe ui web (west european)&quot;, &quot;segoe
            ui&quot;, -apple-system, blinkmacsystemfont, roboto,
            &quot;helvetica neue&quot;, sans-serif; font-size: 12pt;
            color: rgb(50, 49, 48); background-color: rgba(0, 0, 0, 0);"> int
            write)  </span><br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">the above function
            will be called from kernel side (likes 'get_user_pages' code
            path),  and the function should</span><span
            style="font-family: &quot;segoe ui&quot;, &quot;segoe ui web
            (west european)&quot;, &quot;segoe ui&quot;, -apple-system,
            blinkmacsystemfont, roboto, &quot;helvetica neue&quot;,
            sans-serif; font-size: 12pt; color: rgb(50, 49, 48);
            background-color: rgba(0, 0, 0, 0);"> accept non-aligned
            addresses.</span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <span style="font-family: &quot;segoe ui&quot;, &quot;segoe ui
            web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">without this
            patch, this function will be using MM_INDEX/DATA to handle
            aligned address whether </span><span style="font-family:
            &quot;segoe ui&quot;, &quot;segoe ui web (west
            european)&quot;, &quot;segoe ui&quot;, -apple-system,
            blinkmacsystemfont, roboto, &quot;helvetica neue&quot;,
            sans-serif; font-size: 12pt; color: rgb(50, 49, 48);
            background-color: rgba(0, 0, 0, 0);">in visible memory or
            not.</span></div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
        </div>
        <div><span style="font-family: &quot;segoe ui&quot;, &quot;segoe
            ui web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">for this kind of
            case , I think the driver should check whether VRAM aperture
            works first, then using MM_INDEX/DATA a</span><span
            style="font-family: &quot;segoe ui&quot;, &quot;segoe ui web
            (west european)&quot;, &quot;segoe ui&quot;, -apple-system,
            blinkmacsystemfont, roboto, &quot;helvetica neue&quot;,
            sans-serif; font-size: 12pt; color: rgb(50, 49, 48);
            background-color: rgba(0, 0, 0, 0);">s a backup option.</span></div>
        <div><br>
        </div>
        <div><span style="font-family: &quot;segoe ui&quot;, &quot;segoe
            ui web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">for this patch, I
            only extend amdgpu_device_vram_access() function to support
            un-aligned case, </span><span style="font-family:
            &quot;segoe ui&quot;, &quot;segoe ui web (west
            european)&quot;, &quot;segoe ui&quot;, -apple-system,
            blinkmacsystemfont, roboto, &quot;helvetica neue&quot;,
            sans-serif; font-size: 12pt; color: rgb(50, 49, 48);
            background-color: rgba(0, 0, 0, 0);">and the new function is
            fully compatible with the old code logic.</span></div>
        <div><span style="font-family: &quot;segoe ui&quot;, &quot;segoe
            ui web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">I can't understand
            why you give a NAK about this patch, </span><span
            style="font-family: &quot;segoe ui&quot;, &quot;segoe ui web
            (west european)&quot;, &quot;segoe ui&quot;, -apple-system,
            blinkmacsystemfont, roboto, &quot;helvetica neue&quot;,
            sans-serif; font-size: 12pt; color: rgb(50, 49, 48);
            background-color: rgba(0, 0, 0, 0);">I think it's a good
            optimization, how do you think?</span></div>
        <div><span style="font-family: &quot;segoe ui&quot;, &quot;segoe
            ui web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">thanks.</span></div>
        <div><br>
        </div>
        <div><span style="font-family: &quot;segoe ui&quot;, &quot;segoe
            ui web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">Best Regards,</span></div>
        <div><span style="font-family: &quot;segoe ui&quot;, &quot;segoe
            ui web (west european)&quot;, &quot;segoe ui&quot;,
            -apple-system, blinkmacsystemfont, roboto, &quot;helvetica
            neue&quot;, sans-serif; font-size: 12pt; color: rgb(50, 49,
            48); background-color: rgba(0, 0, 0, 0);">Kevin</span><br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Monday, June 28, 2021 10:10 PM<br>
            <b>To:</b> Wang, Kevin(Yang) <a class="moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com">&lt;Kevin1.Wang@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH] drm/amdgpu: add non-aligned
            address supported in amdgpu_device_vram_access()</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="PlainText">Am 25.06.21 um 05:24 schrieb Kevin
                Wang:<br>
                &gt; 1. add non-aligned address support in
                amdgpu_device_vram_access()<br>
                &gt; 2. reduce duplicate code in
                amdgpu_ttm_access_memory()<br>
                &gt;<br>
                &gt; because the MM_INDEX{HI}/DATA are protected
                register, it is not working<br>
                &gt; in sriov environment when mmio protect feature is
                enabled (in some asics),<br>
                &gt; and the old function amdgpu_ttm_access_memory()
                will force using MM_INDEX/DATA<br>
                &gt; to handle non-aligned address by default, it will
                cause the register(MM_DATA)<br>
                &gt; is always return 0.<br>
                &gt;<br>
                &gt; with the patch, the memory will be accessed in the
                aper way first.<br>
                &gt; (in visible memory or enable pcie large-bar
                feature), then using<br>
                &gt; MM_INDEX{HI}/MM_DATA to access rest vram memroy.<br>
                <br>
                Well NAK to the whole approach.<br>
                <br>
                The amdgpu_device_vram_access() are intentionally *NOT*
                using the VRAM <br>
                aperture nor providing byte wise access.<br>
                <br>
                And yes that this doesn't work under SRIOV is completely
                intentional as <br>
                well.<br>
                <br>
                What we could do is to use the aperture in
                amdgpu_ttm_access_memory() <br>
                for unaligned access if that is indeed a problem.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                <br>
                &gt;<br>
                &gt; Signed-off-by: Kevin Wang
                <a class="moz-txt-link-rfc2396E" href="mailto:kevin1.wang@amd.com">&lt;kevin1.wang@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2
                +-<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 69
                ++++++++++++++++------<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 42
                ++-----------<br>
                &gt;   3 files changed, 58 insertions(+), 55
                deletions(-)<br>
                &gt;<br>
                &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
                b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; index d14b4968a026..8095d9a9c857 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h<br>
                &gt; @@ -1103,7 +1103,7 @@ void
                amdgpu_device_fini(struct amdgpu_device *adev);<br>
                &gt;   int amdgpu_gpu_wait_for_idle(struct amdgpu_device
                *adev);<br>
                &gt;   <br>
                &gt;   void amdgpu_device_vram_access(struct
                amdgpu_device *adev, loff_t pos,<br>
                &gt; -                            uint32_t *buf, size_t
                size, bool write);<br>
                &gt; +                            void *buf, size_t
                size, bool write);<br>
                &gt;   uint32_t amdgpu_device_rreg(struct amdgpu_device
                *adev,<br>
                &gt;                            uint32_t reg, uint32_t
                acc_flags);<br>
                &gt;   void amdgpu_device_wreg(struct amdgpu_device
                *adev,<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; index e6702d136a6d..2047e3c2b365 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                &gt; @@ -280,6 +280,54 @@ bool
                amdgpu_device_supports_smart_shift(struct drm_device
                *dev)<br>
                &gt;               
                amdgpu_acpi_is_power_shift_control_supported());<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; +static inline void
                amdgpu_device_vram_mmio_align_access_locked(struct
                amdgpu_device *adev, loff_t pos,<br>
                &gt;
                +                                                           
                uint32_t *value, bool write)<br>
                &gt; +{<br>
                &gt; +     BUG_ON(!IS_ALIGNED(pos, 4));<br>
                &gt; +<br>
                &gt; +     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) |
                0x80000000);<br>
                &gt; +     WREG32_NO_KIQ(mmMM_INDEX_HI, pos &gt;&gt;
                31);<br>
                &gt; +     if (write)<br>
                &gt; +             WREG32_NO_KIQ(mmMM_DATA, *value);<br>
                &gt; +     else<br>
                &gt; +             *value = RREG32_NO_KIQ(mmMM_DATA);<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +static void
                amdgpu_device_vram_mmio_access_locked(struct
                amdgpu_device *adev, loff_t pos,<br>
                &gt; +                                              
                void *buf, size_t size, bool write)<br>
                &gt; +{<br>
                &gt; +     while (size) {<br>
                &gt; +             uint64_t aligned_pos =
                ALIGN_DOWN(pos, 4);<br>
                &gt; +             uint64_t bytes = 4 - (pos &amp; 0x3);<br>
                &gt; +             uint32_t shift = (pos &amp; 0x3) * 8;<br>
                &gt; +             uint32_t mask = 0xffffffff &lt;&lt;
                shift;<br>
                &gt; +             uint32_t value = 0;<br>
                &gt; +<br>
                &gt; +             if (size &lt; bytes) {<br>
                &gt; +                     mask &amp;= 0xffffffff
                &gt;&gt; (bytes - size) * 8;<br>
                &gt; +                     bytes = size;<br>
                &gt; +             }<br>
                &gt; +<br>
                &gt; +             if (mask != 0xffffffff) {<br>
                &gt; +                    
                amdgpu_device_vram_mmio_align_access_locked(adev,
                aligned_pos, &amp;value, false);<br>
                &gt; +                     if (write) {<br>
                &gt; +                             value &amp;= ~mask;<br>
                &gt; +                             value |= (*(uint32_t
                *)buf &lt;&lt; shift) &amp; mask;<br>
                &gt; +                            
                amdgpu_device_vram_mmio_align_access_locked(adev,
                aligned_pos, &amp;value, true);<br>
                &gt; +                     } else {<br>
                &gt; +                             value = (value &amp;
                mask) &gt;&gt; shift;<br>
                &gt; +                             memcpy(buf,
                &amp;value, bytes);<br>
                &gt; +                     }<br>
                &gt; +             } else {<br>
                &gt; +                    
                amdgpu_device_vram_mmio_align_access_locked(adev,
                aligned_pos, buf, write);<br>
                &gt; +             }<br>
                &gt; +<br>
                &gt; +             pos += bytes;<br>
                &gt; +             buf += bytes;<br>
                &gt; +             size -= bytes;<br>
                &gt; +     }<br>
                &gt; +}<br>
                &gt; +<br>
                &gt;   /*<br>
                &gt;    * VRAM access helper functions<br>
                &gt;    */<br>
                &gt; @@ -294,13 +342,11 @@ bool
                amdgpu_device_supports_smart_shift(struct drm_device
                *dev)<br>
                &gt;    * @write: true - write to vram, otherwise - read
                from vram<br>
                &gt;    */<br>
                &gt;   void amdgpu_device_vram_access(struct
                amdgpu_device *adev, loff_t pos,<br>
                &gt; -                            uint32_t *buf, size_t
                size, bool write)<br>
                &gt; +                            void *buf, size_t
                size, bool write)<br>
                &gt;   {<br>
                &gt;        unsigned long flags;<br>
                &gt; -     uint32_t hi = ~0;<br>
                &gt;        uint64_t last;<br>
                &gt;   <br>
                &gt; -<br>
                &gt;   #ifdef CONFIG_64BIT<br>
                &gt;        last = min(pos + size,
                adev-&gt;gmc.visible_vram_size);<br>
                &gt;        if (last &gt; pos) {<br>
                &gt; @@ -321,25 +367,12 @@ void
                amdgpu_device_vram_access(struct amdgpu_device *adev,
                loff_t pos,<br>
                &gt;                        return;<br>
                &gt;   <br>
                &gt;                pos += count;<br>
                &gt; -             buf += count / 4;<br>
                &gt; +             buf += count;<br>
                &gt;                size -= count;<br>
                &gt;        }<br>
                &gt;   #endif<br>
                &gt; -<br>
                &gt;       
                spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags);<br>
                &gt; -     for (last = pos + size; pos &lt; last; pos +=
                4) {<br>
                &gt; -             uint32_t tmp = pos &gt;&gt; 31;<br>
                &gt; -<br>
                &gt; -             WREG32_NO_KIQ(mmMM_INDEX,
                ((uint32_t)pos) | 0x80000000);<br>
                &gt; -             if (tmp != hi) {<br>
                &gt; -                     WREG32_NO_KIQ(mmMM_INDEX_HI,
                tmp);<br>
                &gt; -                     hi = tmp;<br>
                &gt; -             }<br>
                &gt; -             if (write)<br>
                &gt; -                     WREG32_NO_KIQ(mmMM_DATA,
                *buf++);<br>
                &gt; -             else<br>
                &gt; -                     *buf++ =
                RREG32_NO_KIQ(mmMM_DATA);<br>
                &gt; -     }<br>
                &gt; +     amdgpu_device_vram_mmio_access_locked(adev,
                pos, buf, size, write);<br>
                &gt;       
                spin_unlock_irqrestore(&amp;adev-&gt;mmio_idx_lock,
                flags);<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                &gt; index 6297363ab740..cf5b8bdc2dd3 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                &gt; @@ -1430,8 +1430,6 @@ static int
                amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,<br>
                &gt;        struct amdgpu_bo *abo =
                ttm_to_amdgpu_bo(bo);<br>
                &gt;        struct amdgpu_device *adev =
                amdgpu_ttm_adev(abo-&gt;tbo.bdev);<br>
                &gt;        struct amdgpu_res_cursor cursor;<br>
                &gt; -     unsigned long flags;<br>
                &gt; -     uint32_t value = 0;<br>
                &gt;        int ret = 0;<br>
                &gt;   <br>
                &gt;        if (bo-&gt;mem.mem_type != TTM_PL_VRAM)<br>
                &gt; @@ -1439,41 +1437,13 @@ static int
                amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,<br>
                &gt;   <br>
                &gt;        amdgpu_res_first(&amp;bo-&gt;mem, offset,
                len, &amp;cursor);<br>
                &gt;        while (cursor.remaining) {<br>
                &gt; -             uint64_t aligned_pos = cursor.start
                &amp; ~(uint64_t)3;<br>
                &gt; -             uint64_t bytes = 4 - (cursor.start
                &amp; 3);<br>
                &gt; -             uint32_t shift = (cursor.start &amp;
                3) * 8;<br>
                &gt; -             uint32_t mask = 0xffffffff &lt;&lt;
                shift;<br>
                &gt; -<br>
                &gt; -             if (cursor.size &lt; bytes) {<br>
                &gt; -                     mask &amp;= 0xffffffff
                &gt;&gt; (bytes - cursor.size) * 8;<br>
                &gt; -                     bytes = cursor.size;<br>
                &gt; -             }<br>
                &gt; +             amdgpu_device_vram_access(adev,
                cursor.start,<br>
                &gt; +                                       buf,
                cursor.size,<br>
                &gt; +                                       write);<br>
                &gt;   <br>
                &gt; -             if (mask != 0xffffffff) {<br>
                &gt; -                    
                spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags);<br>
                &gt; -                     WREG32_NO_KIQ(mmMM_INDEX,
                ((uint32_t)aligned_pos) | 0x80000000);<br>
                &gt; -                     WREG32_NO_KIQ(mmMM_INDEX_HI,
                aligned_pos &gt;&gt; 31);<br>
                &gt; -                     value =
                RREG32_NO_KIQ(mmMM_DATA);<br>
                &gt; -                     if (write) {<br>
                &gt; -                             value &amp;= ~mask;<br>
                &gt; -                             value |= (*(uint32_t
                *)buf &lt;&lt; shift) &amp; mask;<br>
                &gt; -                            
                WREG32_NO_KIQ(mmMM_DATA, value);<br>
                &gt; -                     }<br>
                &gt; -                    
                spin_unlock_irqrestore(&amp;adev-&gt;mmio_idx_lock,
                flags);<br>
                &gt; -                     if (!write) {<br>
                &gt; -                             value = (value &amp;
                mask) &gt;&gt; shift;<br>
                &gt; -                             memcpy(buf,
                &amp;value, bytes);<br>
                &gt; -                     }<br>
                &gt; -             } else {<br>
                &gt; -                     bytes = cursor.size &amp;
                ~0x3ULL;<br>
                &gt; -                    
                amdgpu_device_vram_access(adev, cursor.start,<br>
                &gt; -                                              
                (uint32_t *)buf, bytes,<br>
                &gt; -                                              
                write);<br>
                &gt; -             }<br>
                &gt; -<br>
                &gt; -             ret += bytes;<br>
                &gt; -             buf = (uint8_t *)buf + bytes;<br>
                &gt; -             amdgpu_res_next(&amp;cursor, bytes);<br>
                &gt; +             ret += cursor.size;<br>
                &gt; +             buf += cursor.size;<br>
                &gt; +             amdgpu_res_next(&amp;cursor,
                cursor.size);<br>
                &gt;        }<br>
                &gt;   <br>
                &gt;        return ret;<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------E8F99616BE672B93507D7328--

--===============1819303360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1819303360==--
