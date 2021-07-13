Return-Path: <SRS0=Y2YZ=MF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5009C07E95
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 09:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D17D61375
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jul 2021 09:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D17D61375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65CD06E063;
	Tue, 13 Jul 2021 09:06:58 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1F086E060
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 09:06:56 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 a5-20020a7bc1c50000b02901e3bbe0939bso1834084wmj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jul 2021 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=lch75avGerQ3fui/8NiI1IOlRO9vqgC0WZlUMg+WvhM=;
 b=ltM8t+nXXBypaS+qx4WXpEeUjfPmd2ZvckaXK95YuZJ+p4u5YTQTmbZCaCPw17qxvK
 W3phqdITu07Vq4Z7uOGO3TxUQ2S5xEvgp4IK+HfwGqBE/4gJ0GzN683y+pEU2Z1riXk2
 GYcB1/gQCQhV9jlntZfFubsnEj/U9lJOTC5lH6/cPgR0ybZux2luJx0IrSv43SCpoALc
 LkfONz4PIvzpuuLIEHYRHQTuvU0stbXdRueAfp/bSSmK/rJU/l3cr1+5qBGyZykhquD+
 Duq/tr6j15mfG4r1vCR73liDxS4/9vuI1yzo0LDTLvJrTbxbms9WxEBlsGrrZtbhhkQ7
 pYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=lch75avGerQ3fui/8NiI1IOlRO9vqgC0WZlUMg+WvhM=;
 b=BWYWKHeIfkdlUnfoZbsV8jHbgdKUtQGI9WczXD9FVgdiCKZqBRB6wv+dg7dfbzDSxJ
 06M1NtlKSrvssIYJVKq+TthIRflx9F34s0YkEhQBsOmy5nWPveeIzqWHsS1iCMeYzq9w
 W6oth+D3ssFxwqxRTgiyqIEgip7+h44qDy1acj+/7UwLch4jY+G6F8WkVatCunv37RbS
 MMjhHqidNYEw1LdtdDA/7US9FQjWdH9vxVTk4+Lvp9RuMvQ17M8GD6HlqNijOxYyMRMk
 QoC2mBqPUOQBBq6ZKAuhE0BTTpZBjXqcIk6dPw0uXF3UnWOxRtzXCzz91WlDw1Zy2AHe
 TFWg==
X-Gm-Message-State: AOAM530/31agfXkcA1ba5++ljQpJwqF9nTlRQXFwg89bqP1rhsyzk0TW
 GDNJL1SNrYiOrf54YTc8Gs3DLgsQLro=
X-Google-Smtp-Source: ABdhPJx3iRETTXp8xU6PLw+vdxCXEsrEHy2PqYDUlBibmWuSGJwizDAXFwSK9WlrMMc5H2efMrDfQQ==
X-Received: by 2002:a1c:f203:: with SMTP id s3mr18946124wmc.138.1626167215310; 
 Tue, 13 Jul 2021 02:06:55 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:7f5a:cff:4644:b698?
 ([2a02:908:1252:fb60:7f5a:cff:4644:b698])
 by smtp.gmail.com with ESMTPSA id f5sm18594389wrg.67.2021.07.13.02.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jul 2021 02:06:54 -0700 (PDT)
Subject: Re: [RFC PATCH v2] drm/amdgpu/ttm: optimize vram access in
 amdgpu_ttm_access_memory()
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210713032329.7393-1-kevin1.wang@amd.com>
 <8536eff2-c869-9b06-2586-0f3cef928a96@gmail.com>
 <CO6PR12MB54734AF103090E1C567E4EF7A2149@CO6PR12MB5473.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0bb6a0e8-5366-3625-9357-ca2335890abb@gmail.com>
Date: Tue, 13 Jul 2021 11:06:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CO6PR12MB54734AF103090E1C567E4EF7A2149@CO6PR12MB5473.namprd12.prod.outlook.com>
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
Content-Type: multipart/mixed; boundary="===============2064931324=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============2064931324==
Content-Type: multipart/alternative;
 boundary="------------A986A046A06A327DA64C9D3D"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------A986A046A06A327DA64C9D3D
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

See below.

Am 13.07.21 um 10:32 schrieb Wang, Kevin(Yang):
>
> [AMD Official Use Only]
>
>
> <comments inline>
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Tuesday, July 13, 2021 3:11 PM
> *To:* Wang, Kevin(Yang) <Kevin1.Wang@amd.com>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Lazar, Lijo <Lijo.Lazar@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Min, Frank <Frank.Min@amd.com>; Koenig, 
> Christian <Christian.Koenig@amd.com>; Zhang, Hawking 
> <Hawking.Zhang@amd.com>
> *Subject:* Re: [RFC PATCH v2] drm/amdgpu/ttm: optimize vram access in 
> amdgpu_ttm_access_memory()
> Am 13.07.21 um 05:23 schrieb Kevin Wang:
> > 1. using vram aper to access vram if possible
> > 2. avoid MM_INDEX/MM_DATA is not working when mmio protect feature is
> > enabled.
> >
> > Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 126 +++++++++++++++++-------
> >   1 file changed, 89 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index 2aa2eb5de37a..8f6f605bc459 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1407,6 +1407,91 @@ static bool 
> amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
> >        return ttm_bo_eviction_valuable(bo, place);
> >   }
> >
> > +static void amdgpu_ttm_vram_mm_align_access(struct amdgpu_device 
> *adev, loff_t pos,
> > +                                         uint32_t *value, bool write)
>
> Please drop the _vram_ and _align_ part from the name. Just
> amdgpu_device_mm_access.
>
> [kevin]: I will correct it in next patch.
>
> > +{
> > +     unsigned long flags;
> > +
> > +     BUG_ON(!IS_ALIGNED(pos, 4));
> > +
> > + spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> > +     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) | 0x80000000);
> > +     WREG32_NO_KIQ(mmMM_INDEX_HI, pos >> 31);
> > +     if (write)
> > +             WREG32_NO_KIQ(mmMM_DATA, *value);
> > +     else
> > +             *value = RREG32_NO_KIQ(mmMM_DATA);
> > + spin_unlock_irqrestore(&adev->mmio_idx_lock, flags);
> > +}
>
> That should still be in amdgpu_device.c and you completely messed up the
> drm_dev_enter()/drm_dev_exit() annotation.
>
> Looks like you are working on an old branch where that is not yet merged?
>
> [kevin]: yes, I'm working on amd-staging-drm-next branch, the 
> following patch (from drm-next-misc) is not merged into this branch.

Ok then just wait a bit. Alex wanted to update the amd-staging-drm-next 
branch in the next few days.

There is an internal mail thread about that, maybe ping him on this.

Christian.

>
> drm/amdgpu: Guard against write accesses after device removal
>
> This should prevent writing to memory or IO ranges possibly
> already allocated for other uses after our device is removed.
>
> v5:
> Protect more places wher memcopy_to/form_io takes place
> Protect IB submissions
>
> v6: Switch to !drm_dev_enter instead of scoping entire code
> with brackets.
>
> v7:
> Drop guard of HW ring commands emission protection since they
> are in GART and not in MMIO.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
>
> > +
> > +static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, 
> loff_t pos,
> > +                                   void *buf, size_t size, bool write)
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
> > + amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, &value, false);
> > +                     if (write) {
> > +                             value &= ~mask;
> > +                             value |= (*(uint32_t *)buf << shift) & 
> mask;
> > + amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, &value, true);
> > +                     } else {
> > +                             value = (value & mask) >> shift;
> > +                             memcpy(buf, &value, bytes);
> > +                     }
> > +             } else {
> > + amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, buf, write);
> > +             }
> > +
> > +             pos += bytes;
> > +             buf += bytes;
> > +             size -= bytes;
> > +     }
> > +}
> > +
> > +static void amdgpu_ttm_vram_access(struct amdgpu_device *adev, 
> loff_t pos,
> > +                                void *buf, size_t size, bool write)
> > +{
> > +     uint64_t last;
> > +
> > +#ifdef CONFIG_64BIT
> > +     last = min(pos + size, adev->gmc.visible_vram_size);
> > +     if (last > pos) {
> > +             void __iomem *addr = adev->mman.aper_base_kaddr + pos;
> > +             size_t count = last - pos;
> > +
> > +             if (write) {
> > +                     memcpy_toio(addr, buf, count);
> > +                     mb();
> > +                     amdgpu_device_flush_hdp(adev, NULL);
> > +             } else {
> > + amdgpu_device_invalidate_hdp(adev, NULL);
> > +                     mb();
> > +                     memcpy_fromio(buf, addr, count);
> > +             }
> > +
> > +             if (count == size)
> > +                     return;
> > +
> > +             pos += count;
> > +             buf += count;
> > +             size -= count;
> > +     }
> > +#endif
>
> I would put this as a separate function into amdgpu_device.c.
>
> But all of this should only be the second step since we need a much
> smaller patch for backporting first.
>
> > +
> > +     amdgpu_ttm_vram_mm_access(adev, pos, buf, size, write);
> > +}
> > +
> >   /**
> >    * amdgpu_ttm_access_memory - Read or Write memory that backs a 
> buffer object.
> >    *
> > @@ -1426,8 +1511,6 @@ static int amdgpu_ttm_access_memory(struct 
> ttm_buffer_object *bo,
> >        struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
> >        struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
> >        struct amdgpu_res_cursor cursor;
> > -     unsigned long flags;
> > -     uint32_t value = 0;
> >        int ret = 0;
> >
> >        if (bo->mem.mem_type != TTM_PL_VRAM)
> > @@ -1435,41 +1518,10 @@ static int amdgpu_ttm_access_memory(struct 
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
> > -
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
>
> This here is the problematic part and should use
> amdgpu_ttm_vram_access() instead.
>
> That should be implemented first since we might need to backport that.
>
> Regards,
> Christian.
>
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
> > +             amdgpu_ttm_vram_access(adev, cursor.start, buf, 
> cursor.size, write);
> > +             ret += cursor.size;
> > +             buf += cursor.size;
> > +             amdgpu_res_next(&cursor, cursor.size);
> >        }
> >
> >        return ret;
>


--------------A986A046A06A327DA64C9D3D
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    See below.<br>
    <br>
    <div class="moz-cite-prefix">Am 13.07.21 um 10:32 schrieb Wang,
      Kevin(Yang):<br>
    </div>
    <blockquote type="cite"
cite="mid:CO6PR12MB54734AF103090E1C567E4EF7A2149@CO6PR12MB5473.namprd12.prod.outlook.com">
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
          &lt;comments inline&gt;</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Tuesday, July 13, 2021 3:11 PM<br>
            <b>To:</b> Wang, Kevin(Yang) <a class="moz-txt-link-rfc2396E" href="mailto:Kevin1.Wang@amd.com">&lt;Kevin1.Wang@amd.com&gt;</a>;
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Lazar, Lijo <a class="moz-txt-link-rfc2396E" href="mailto:Lijo.Lazar@amd.com">&lt;Lijo.Lazar@amd.com&gt;</a>; Deucher,
            Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Min, Frank
            <a class="moz-txt-link-rfc2396E" href="mailto:Frank.Min@amd.com">&lt;Frank.Min@amd.com&gt;</a>; Koenig, Christian
            <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>; Zhang, Hawking
            <a class="moz-txt-link-rfc2396E" href="mailto:Hawking.Zhang@amd.com">&lt;Hawking.Zhang@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [RFC PATCH v2] drm/amdgpu/ttm: optimize
            vram access in amdgpu_ttm_access_memory()</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="PlainText">Am 13.07.21 um 05:23 schrieb Kevin
                Wang:<br>
                &gt; 1. using vram aper to access vram if possible<br>
                &gt; 2. avoid MM_INDEX/MM_DATA is not working when mmio
                protect feature is<br>
                &gt; enabled.<br>
                &gt;<br>
                &gt; Signed-off-by: Kevin Wang
                <a class="moz-txt-link-rfc2396E" href="mailto:kevin1.wang@amd.com">&lt;kevin1.wang@amd.com&gt;</a><br>
                &gt; ---<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 126
                +++++++++++++++++-------<br>
                &gt;   1 file changed, 89 insertions(+), 37 deletions(-)<br>
                &gt;<br>
                &gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                &gt; index 2aa2eb5de37a..8f6f605bc459 100644<br>
                &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
                &gt; @@ -1407,6 +1407,91 @@ static bool
                amdgpu_ttm_bo_eviction_valuable(struct ttm_buffer_object
                *bo,<br>
                &gt;        return ttm_bo_eviction_valuable(bo, place);<br>
                &gt;   }<br>
                &gt;   <br>
                &gt; +static void amdgpu_ttm_vram_mm_align_access(struct
                amdgpu_device *adev, loff_t pos,<br>
                &gt; +                                         uint32_t
                *value, bool write)<br>
                <br>
                Please drop the _vram_ and _align_ part from the name.
                Just <br>
                amdgpu_device_mm_access.</div>
              <div class="PlainText"><br>
              </div>
              <div class="PlainText">[kevin]: I will correct it in next
                patch.</div>
              <div class="PlainText"><br>
                &gt; +{<br>
                &gt; +     unsigned long flags;<br>
                &gt; +<br>
                &gt; +     BUG_ON(!IS_ALIGNED(pos, 4));<br>
                &gt; +<br>
                &gt; +    
                spin_lock_irqsave(&amp;adev-&gt;mmio_idx_lock, flags);<br>
                &gt; +     WREG32_NO_KIQ(mmMM_INDEX, ((uint32_t)pos) |
                0x80000000);<br>
                &gt; +     WREG32_NO_KIQ(mmMM_INDEX_HI, pos &gt;&gt;
                31);<br>
                &gt; +     if (write)<br>
                &gt; +             WREG32_NO_KIQ(mmMM_DATA, *value);<br>
                &gt; +     else<br>
                &gt; +             *value = RREG32_NO_KIQ(mmMM_DATA);<br>
                &gt; +    
                spin_unlock_irqrestore(&amp;adev-&gt;mmio_idx_lock,
                flags);<br>
                &gt; +}<br>
                <br>
                That should still be in amdgpu_device.c and you
                completely messed up the <br>
                drm_dev_enter()/drm_dev_exit() annotation.<br>
                <br>
                Looks like you are working on an old branch where that
                is not yet merged?</div>
              <div class="PlainText"><br>
              </div>
              <div class="PlainText">[kevin]: yes, I'm working on
                amd-staging-drm-next branch, the following patch (from
                drm-next-misc) is not merged into this branch.</div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
    Ok then just wait a bit. Alex wanted to update the
    amd-staging-drm-next branch in the next few days.<br>
    <br>
    There is an internal mail thread about that, maybe ping him on this.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CO6PR12MB54734AF103090E1C567E4EF7A2149@CO6PR12MB5473.namprd12.prod.outlook.com">
      <div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="PlainText"><br>
              </div>
              drm/amdgpu: Guard against write accesses after device
              removal
              <div><br>
              </div>
              <div>This should prevent writing to memory or IO ranges
                possibly</div>
              <div>already allocated for other uses after our device is
                removed.</div>
              <div><br>
              </div>
              <div>v5:</div>
              <div>Protect more places wher memcopy_to/form_io takes
                place</div>
              <div>Protect IB submissions</div>
              <div><br>
              </div>
              <div>v6: Switch to !drm_dev_enter instead of scoping
                entire code</div>
              <div>with brackets.</div>
              <div><br>
              </div>
              <div>v7:</div>
              <div>Drop guard of HW ring commands emission protection
                since they</div>
              <div>are in GART and not in MMIO.</div>
              <div><br>
              </div>
              <div>Signed-off-by: Andrey Grodzovsky
                <a class="moz-txt-link-rfc2396E" href="mailto:andrey.grodzovsky@amd.com">&lt;andrey.grodzovsky@amd.com&gt;</a></div>
              Reviewed-by: Alex Deucher
              <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
              <div class="PlainText"><span
                  style="box-sizing:border-box;font-family:&quot;Segoe
                  UI&quot;, system-ui, &quot;Apple Color Emoji&quot;,
                  &quot;Segoe UI Emoji&quot;, sans-serif;font-size:14px"></span><br>
                <br>
                &gt; +<br>
                &gt; +static void amdgpu_ttm_vram_mm_access(struct
                amdgpu_device *adev, loff_t pos,<br>
                &gt; +                                   void *buf,
                size_t size, bool write)<br>
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
                amdgpu_ttm_vram_mm_align_access(adev, aligned_pos,
                &amp;value, false);<br>
                &gt; +                     if (write) {<br>
                &gt; +                             value &amp;= ~mask;<br>
                &gt; +                             value |= (*(uint32_t
                *)buf &lt;&lt; shift) &amp; mask;<br>
                &gt; +                            
                amdgpu_ttm_vram_mm_align_access(adev, aligned_pos,
                &amp;value, true);<br>
                &gt; +                     } else {<br>
                &gt; +                             value = (value &amp;
                mask) &gt;&gt; shift;<br>
                &gt; +                             memcpy(buf,
                &amp;value, bytes);<br>
                &gt; +                     }<br>
                &gt; +             } else {<br>
                &gt; +                    
                amdgpu_ttm_vram_mm_align_access(adev, aligned_pos, buf,
                write);<br>
                &gt; +             }<br>
                &gt; +<br>
                &gt; +             pos += bytes;<br>
                &gt; +             buf += bytes;<br>
                &gt; +             size -= bytes;<br>
                &gt; +     }<br>
                &gt; +}<br>
                &gt; +<br>
                &gt; +static void amdgpu_ttm_vram_access(struct
                amdgpu_device *adev, loff_t pos,<br>
                &gt; +                                void *buf, size_t
                size, bool write)<br>
                &gt; +{<br>
                &gt; +     uint64_t last;<br>
                &gt; +<br>
                &gt; +#ifdef CONFIG_64BIT<br>
                &gt; +     last = min(pos + size,
                adev-&gt;gmc.visible_vram_size);<br>
                &gt; +     if (last &gt; pos) {<br>
                &gt; +             void __iomem *addr =
                adev-&gt;mman.aper_base_kaddr + pos;<br>
                &gt; +             size_t count = last - pos;<br>
                &gt; +<br>
                &gt; +             if (write) {<br>
                &gt; +                     memcpy_toio(addr, buf,
                count);<br>
                &gt; +                     mb();<br>
                &gt; +                     amdgpu_device_flush_hdp(adev,
                NULL);<br>
                &gt; +             } else {<br>
                &gt; +                    
                amdgpu_device_invalidate_hdp(adev, NULL);<br>
                &gt; +                     mb();<br>
                &gt; +                     memcpy_fromio(buf, addr,
                count);<br>
                &gt; +             }<br>
                &gt; +<br>
                &gt; +             if (count == size)<br>
                &gt; +                     return;<br>
                &gt; +<br>
                &gt; +             pos += count;<br>
                &gt; +             buf += count;<br>
                &gt; +             size -= count;<br>
                &gt; +     }<br>
                &gt; +#endif<br>
                <br>
                I would put this as a separate function into
                amdgpu_device.c.<br>
                <br>
                But all of this should only be the second step since we
                need a much <br>
                smaller patch for backporting first.<br>
                <br>
                &gt; +<br>
                &gt; +     amdgpu_ttm_vram_mm_access(adev, pos, buf,
                size, write);<br>
                &gt; +}<br>
                &gt; +<br>
                &gt;   /**<br>
                &gt;    * amdgpu_ttm_access_memory - Read or Write
                memory that backs a buffer object.<br>
                &gt;    *<br>
                &gt; @@ -1426,8 +1511,6 @@ static int
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
                &gt; @@ -1435,41 +1518,10 @@ static int
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
                &gt; -<br>
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
                <br>
                This here is the problematic part and should use <br>
                amdgpu_ttm_vram_access() instead.<br>
                <br>
                That should be implemented first since we might need to
                backport that.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
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
                &gt; +             amdgpu_ttm_vram_access(adev,
                cursor.start, buf, cursor.size, write);<br>
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

--------------A986A046A06A327DA64C9D3D--

--===============2064931324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2064931324==--
