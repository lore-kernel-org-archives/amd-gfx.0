Return-Path: <SRS0=Ai3v=23=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD76C33C8C
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 23:00:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 102922075A
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2020 23:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk/2rx5E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 102922075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B88EF6E58A;
	Mon,  6 Jan 2020 23:00:41 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFD2A6E58A;
 Mon,  6 Jan 2020 23:00:39 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c9so51775916wrw.8;
 Mon, 06 Jan 2020 15:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5SFE8aHVyyWNJGPDJR8MJNQ8k0umnpOZUyXv23Akmbo=;
 b=Dk/2rx5Elya2hmlQQbVZjkBv1fapgKRFZdaJNG+j6+HdvMZJNe2FqIt1pDXpKA3UcE
 eJPqmhYGHfZqVMHX04uu79KB3epXspBthRAaCVoo6cnxPQcbxpqzggUzzPsdZt0XpfKQ
 DlaYCFzFPjKxX8W1QLFej9kElj8+VprBOKIgHDeI5bejItT11ovep41bhGALgzV6bQj8
 m/R1syTjAYjaYmGZtuvmqmpgN3xXbSRq8Fwo9fVXlAXFCBuQ5OIWLrtOJWHfuq6ID8K4
 QvW03fHKM0iLqJQAyhnI+mLQ4V3e24vK9llMh1kC8ylWawHbi6xDsiuO27PeFr+esYS4
 BKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5SFE8aHVyyWNJGPDJR8MJNQ8k0umnpOZUyXv23Akmbo=;
 b=G2A0hj7iTkRZwNOHsh9hW/WIrnHEeVnfCoGvfoowgN66/U2gqlwNIbrhhlkX/xelFU
 hrHRY8EYC5MQnscOzNVW4z2WmTC7LvS2FJ+yrU7DrdtiFFUdSLOrvMvZDhBzVU2CYg4Q
 ecRp65NRJatZ+GyneJx449OmE1fF9JS5jJbuQNUBCsga9GdVlOn7mhWuwRQdVIM1pn76
 oFO7c16GVPf8S+9//fraVdmkOTtXv9EKzo1uaqxjQol5q+9vxVj2JRjwt75/G4h91ztn
 3x5966DGGgdkTBdNpNKBN0lAi7zSdIqeAA/M4qFBWs3HRWEYaTYYJYJFfW9k4+9p11d6
 vutQ==
X-Gm-Message-State: APjAAAV8DoUHs3T5+JHmOUl1B7mSK7rXzS2805KsLZ2RNU+945vjF6AC
 G5cyTFZJ1oTm2LvYJM9LBv4zrUMsrsrIGEZzRcI=
X-Google-Smtp-Source: APXvYqymRlHoytIhKTQY1LQBNxQL+OyaHR+ELLG8BuTpT8MgpvcrcW1YiqpWbDHlNJtT7FflyPCgDaf0C6KRRubY/m8=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr92447550wru.154.1578351638427; 
 Mon, 06 Jan 2020 15:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20200103132035.27008-1-wambui.karugax@gmail.com>
In-Reply-To: <20200103132035.27008-1-wambui.karugax@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jan 2020 18:00:26 -0500
Message-ID: <CADnq5_MKfUHfO5y6tTkP7vyMq4UO9erhvc4WDfuBTdJ1J9uB5g@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: remove unnecessary braces around conditionals.
To: Wambui Karuga <wambui.karugax@gmail.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 3, 2020 at 2:34 PM Wambui Karuga <wambui.karugax@gmail.com> wrote:
>
> As single statement conditionals do not need to be wrapped around
> braces, the unnecessary braces can be removed.
>
> Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>

Applied. thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/atombios_crtc.c     |  3 +--
>  drivers/gpu/drm/radeon/atombios_dp.c       |  3 +--
>  drivers/gpu/drm/radeon/atombios_encoders.c |  9 ++++-----
>  drivers/gpu/drm/radeon/radeon_connectors.c |  4 ++--
>  drivers/gpu/drm/radeon/radeon_vce.c        |  4 ++--
>  drivers/gpu/drm/radeon/radeon_vm.c         | 16 ++++++++--------
>  6 files changed, 18 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
> index da2c9e295408..be583695427a 100644
> --- a/drivers/gpu/drm/radeon/atombios_crtc.c
> +++ b/drivers/gpu/drm/radeon/atombios_crtc.c
> @@ -244,9 +244,8 @@ static void atombios_blank_crtc(struct drm_crtc *crtc, int state)
>
>         atom_execute_table(rdev->mode_info.atom_context, index, (uint32_t *)&args);
>
> -       if (ASIC_IS_DCE8(rdev)) {
> +       if (ASIC_IS_DCE8(rdev))
>                 WREG32(vga_control_regs[radeon_crtc->crtc_id], vga_control);
> -       }
>  }
>
>  static void atombios_powergate_crtc(struct drm_crtc *crtc, int state)
> diff --git a/drivers/gpu/drm/radeon/atombios_dp.c b/drivers/gpu/drm/radeon/atombios_dp.c
> index 6f38375c77c8..39b342b5c495 100644
> --- a/drivers/gpu/drm/radeon/atombios_dp.c
> +++ b/drivers/gpu/drm/radeon/atombios_dp.c
> @@ -816,9 +816,8 @@ void radeon_dp_link_train(struct drm_encoder *encoder,
>         dp_info.use_dpencoder = true;
>         index = GetIndexIntoMasterTable(COMMAND, DPEncoderService);
>         if (atom_parse_cmd_header(rdev->mode_info.atom_context, index, &frev, &crev)) {
> -               if (crev > 1) {
> +               if (crev > 1)
>                         dp_info.use_dpencoder = false;
> -               }
>         }
>
>         dp_info.enc_id = 0;
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
> index 2a7be5d5e7e6..cc5ee1b3af84 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -1885,11 +1885,10 @@ atombios_set_encoder_crtc_source(struct drm_encoder *encoder)
>                         if (ASIC_IS_AVIVO(rdev))
>                                 args.v1.ucCRTC = radeon_crtc->crtc_id;
>                         else {
> -                               if (radeon_encoder->encoder_id == ENCODER_OBJECT_ID_INTERNAL_DAC1) {
> +                               if (radeon_encoder->encoder_id == ENCODER_OBJECT_ID_INTERNAL_DAC1)
>                                         args.v1.ucCRTC = radeon_crtc->crtc_id;
> -                               } else {
> +                               else
>                                         args.v1.ucCRTC = radeon_crtc->crtc_id << 2;
> -                               }
>                         }
>                         switch (radeon_encoder->encoder_id) {
>                         case ENCODER_OBJECT_ID_INTERNAL_TMDS1:
> @@ -2234,9 +2233,9 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
>                 DRM_ERROR("Got encoder index incorrect - returning 0\n");
>                 return 0;
>         }
> -       if (rdev->mode_info.active_encoders & (1 << enc_idx)) {
> +       if (rdev->mode_info.active_encoders & (1 << enc_idx))
>                 DRM_ERROR("chosen encoder in use %d\n", enc_idx);
> -       }
> +
>         rdev->mode_info.active_encoders |= (1 << enc_idx);
>         return enc_idx;
>  }
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 90d2f732affb..fe12d9d91d7a 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -700,9 +700,9 @@ static int radeon_connector_set_property(struct drm_connector *connector, struct
>                         else
>                                 ret = radeon_legacy_get_tmds_info_from_combios(radeon_encoder, tmds);
>                 }
> -               if (val == 1 || !ret) {
> +               if (val == 1 || !ret)
>                         radeon_legacy_get_tmds_info_from_table(radeon_encoder, tmds);
> -               }
> +
>                 radeon_property_change_mode(&radeon_encoder->base);
>         }
>
> diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
> index 59db54ace428..5e8006444704 100644
> --- a/drivers/gpu/drm/radeon/radeon_vce.c
> +++ b/drivers/gpu/drm/radeon/radeon_vce.c
> @@ -388,9 +388,9 @@ int radeon_vce_get_create_msg(struct radeon_device *rdev, int ring,
>                 ib.ptr[i] = cpu_to_le32(0x0);
>
>         r = radeon_ib_schedule(rdev, &ib, NULL, false);
> -       if (r) {
> +       if (r)
>                 DRM_ERROR("radeon: failed to schedule ib (%d).\n", r);
> -       }
> +
>
>         if (fence)
>                 *fence = radeon_fence_ref(ib.fence);
> diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
> index e0ad547786e8..f60fae0aed11 100644
> --- a/drivers/gpu/drm/radeon/radeon_vm.c
> +++ b/drivers/gpu/drm/radeon/radeon_vm.c
> @@ -296,9 +296,9 @@ struct radeon_bo_va *radeon_vm_bo_find(struct radeon_vm *vm,
>         struct radeon_bo_va *bo_va;
>
>         list_for_each_entry(bo_va, &bo->va, bo_list) {
> -               if (bo_va->vm == vm) {
> +               if (bo_va->vm == vm)
>                         return bo_va;
> -               }
> +
>         }
>         return NULL;
>  }
> @@ -323,9 +323,9 @@ struct radeon_bo_va *radeon_vm_bo_add(struct radeon_device *rdev,
>         struct radeon_bo_va *bo_va;
>
>         bo_va = kzalloc(sizeof(struct radeon_bo_va), GFP_KERNEL);
> -       if (bo_va == NULL) {
> +       if (bo_va == NULL)
>                 return NULL;
> -       }
> +
>         bo_va->vm = vm;
>         bo_va->bo = bo;
>         bo_va->it.start = 0;
> @@ -947,9 +947,9 @@ int radeon_vm_bo_update(struct radeon_device *rdev,
>
>         if (mem) {
>                 addr = (u64)mem->start << PAGE_SHIFT;
> -               if (mem->mem_type != TTM_PL_SYSTEM) {
> +               if (mem->mem_type != TTM_PL_SYSTEM)
>                         bo_va->flags |= RADEON_VM_PAGE_VALID;
> -               }
> +
>                 if (mem->mem_type == TTM_PL_TT) {
>                         bo_va->flags |= RADEON_VM_PAGE_SYSTEM;
>                         if (!(bo_va->bo->flags & (RADEON_GEM_GTT_WC | RADEON_GEM_GTT_UC)))
> @@ -1233,9 +1233,9 @@ void radeon_vm_fini(struct radeon_device *rdev, struct radeon_vm *vm)
>         struct radeon_bo_va *bo_va, *tmp;
>         int i, r;
>
> -       if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
> +       if (!RB_EMPTY_ROOT(&vm->va.rb_root))
>                 dev_err(rdev->dev, "still active bo inside vm\n");
> -       }
> +
>         rbtree_postorder_for_each_entry_safe(bo_va, tmp,
>                                              &vm->va.rb_root, it.rb) {
>                 interval_tree_remove(&bo_va->it, &vm->va);
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
