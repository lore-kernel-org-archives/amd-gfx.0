Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9CEC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 15:21:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5C022072E
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsL/SS87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C022072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE046EA31;
	Fri, 10 Jan 2020 15:21:38 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5476C6EA31
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 15:21:37 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id d16so2157720wre.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 07:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H9PRyN+elviaeFZrZ9l+EN8QCB8bVo6PvKf5iwa3rFQ=;
 b=QsL/SS87EVXKSCKumtYa70ysF8QHp6MsnfADjX9M0eH6RAT/rXvtVoPXekbDQVzT28
 KpF7LOzn7JPNRwHVzmFvyTJzG5B1Vfor1BzsbfVNiSGqdiU/7XGW0NsNMOy9+R65e7Qp
 bC79791oijgXkWSCI+fj/Df20YPx85GZyRFlaHUCcQHpxWnJUfIhfcCD8ri584gS02zn
 rB3gFuHJhzmokjZBmLFEZ2c2phHiUfqFqOv6pveAsbwIRBUjj3k6s2ldsxzB6DumMzt6
 hq5+nxhSDsb9s57IXGhkpXPrzcgeKQAr8B5gXgKm4/ZwM42ax6Qf7NBKiVkUA2dwRo6F
 17Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H9PRyN+elviaeFZrZ9l+EN8QCB8bVo6PvKf5iwa3rFQ=;
 b=eoNmXKMmlKJ63vl4GAI+5UtEdT6bgVwHPzE7jYHwtTdlFfuTTTt9/S2ocbQF3PRa8i
 sZziMYLpcVKxqdoPal6N+TDSL0gqEHy3NzdrpOviS2A36CtElXc2d6KGyQOVM6Lkt8Su
 Or7JeUY1xYGbWGfW3arbvhnvUEE8drY+8KyAQsogdcX8xXOPCxbcH0523LefZqUoLTFI
 0J09+GbGtUYEeRg/nt5pQm5p210cIFFmsPQOGTLune06ccCwwKgqeZItgWv0Ke/vsfeB
 UKdrKjwuFZHcAIt5GWZxCv7uyXNlk0mMg5R1CFNjBKU/J5ll5xJ/JT6M5+k3BlCtbYW1
 je2g==
X-Gm-Message-State: APjAAAUndivsLu3LF4CSveKtOguAZOeK5RJP+avimW1c0m/ZHm6/Z4U4
 Nwtjdwj1sJvbKkIxzBePG/pbtgHAIcy6cYw5f08=
X-Google-Smtp-Source: APXvYqxeFaaRrDTikY82hi9VifbDvWa7WYahA064jR53nF2u4IIgK1UDqjFoJPe9y2ByR5yvxgDSPdgn+/zBmAcfX1k=
X-Received: by 2002:a5d:46c7:: with SMTP id g7mr4113624wrs.11.1578669695890;
 Fri, 10 Jan 2020 07:21:35 -0800 (PST)
MIME-Version: 1.0
References: <20200110053010.29132-1-tianci.yin@amd.com>
In-Reply-To: <20200110053010.29132-1-tianci.yin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 10 Jan 2020 10:21:24 -0500
Message-ID: <CADnq5_MARkJDJed6obmFaj4eyyqXscbAcy4k85iLYnso2=MW6w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix modprobe failure of the secondary GPU
 when GDDR6 training enabled(V4)
To: Tianci Yin <tianci.yin@amd.com>
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
Cc: Long Gang <Gang.Long@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>,
 Xiaojie Yuan <xiaojie.yuan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 10, 2020 at 12:30 AM Tianci Yin <tianci.yin@amd.com> wrote:
>
> From: "Tianci.Yin" <tianci.yin@amd.com>
>
> [why]
> In dual GPUs scenario, stolen_size is assigned to zero on the secondary GPU,
> since there is no pre-OS console using that memory. Then the bottom region of
> VRAM was allocated as GTT, unfortunately a small region of bottom VRAM was
> encroached by UMC firmware during GDDR6 BIST training, this cause page fault.
>
> [how]
> Forcing stolen_size to 3MB, then the bottom region of VRAM was
> allocated as stolen memory, GTT corruption avoid.
>
> Change-Id: I310a72ba0402994defbe50839842a8edb025a868
> Signed-off-by: Tianci.Yin <tianci.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 27 ++++++++++++++++++++++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> index c91dd602d5f1..e4b2f9bcaeb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
> @@ -60,6 +60,11 @@
>   */
>  #define AMDGPU_GMC_FAULT_TIMEOUT       5000ULL
>
> +/*
> + * Default stolen memory size, 1024 * 768 * 4
> + */
> +#define AMDGPU_STOLEN_VGA_DEFAULT_SIZE 0x300000ULL

It would be better to call this
AMDGPU_STOLEN_BIST_TRAINING_DEFAULT_SIZE.  Also, I sounds like we are
probably going to have to assume that all of vram could be touched and
adjust our sequnce appropriately.  I think we are just getting lucky
with this size because most imporant kernel structures are in the
lower area of vram.

Alex

> +
>  struct firmware;
>
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 5ad89bb6f3ba..14961f1ebfab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -566,7 +566,12 @@ static int gmc_v10_0_late_init(void *handle)
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>         int r;
>
> -       amdgpu_bo_late_init(adev);
> +       /*
> +        * Can't free the stolen VGA memory when it might be used for memory
> +        * training again.
> +        */
> +       if (!adev->fw_vram_usage.mem_train_support)
> +               amdgpu_bo_late_init(adev);
>
>         r = amdgpu_gmc_allocate_vm_inv_eng(adev);
>         if (r)
> @@ -750,6 +755,19 @@ static int gmc_v10_0_sw_init(void *handle)
>
>         adev->gmc.stolen_size = gmc_v10_0_get_vbios_fb_size(adev);
>
> +       /*
> +        * In dual GPUs scenario, stolen_size is assigned to zero on the
> +        * secondary GPU, since there is no pre-OS console using that memory.
> +        * Then the bottom region of VRAM was allocated as GTT, unfortunately a
> +        * small region of bottom VRAM was encroached by UMC firmware during
> +        * GDDR6 BIST training, this cause page fault.
> +        * The page fault can be fixed by forcing stolen_size to 3MB, then the
> +        * bottom region of VRAM was allocated as stolen memory, GTT corruption
> +        * avoid.
> +        */
> +       adev->gmc.stolen_size = max(adev->gmc.stolen_size,
> +                                   AMDGPU_STOLEN_VGA_DEFAULT_SIZE);
> +
>         /* Memory manager */
>         r = amdgpu_bo_init(adev);
>         if (r)
> @@ -789,6 +807,13 @@ static void gmc_v10_0_gart_fini(struct amdgpu_device *adev)
>  static int gmc_v10_0_sw_fini(void *handle)
>  {
>         struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> +       void *stolen_vga_buf;
> +
> +       /*
> +        * Free the stolen memory if it wasn't already freed in late_init
> +        * because of memory training.
> +        */
> +       amdgpu_bo_free_kernel(&adev->stolen_vga_memory, NULL, &stolen_vga_buf);
>
>         amdgpu_vm_manager_fini(adev);
>         gmc_v10_0_gart_fini(adev);
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
