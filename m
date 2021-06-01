Return-Path: <SRS0=H3yO=K3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09A4C4708F
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 14:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D74961364
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jun 2021 14:11:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D74961364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F8416E2BC;
	Tue,  1 Jun 2021 14:11:50 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CCBB6E2BC
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jun 2021 14:11:49 +0000 (UTC)
Received: by mail-ej1-x630.google.com with SMTP id ci15so18573016ejc.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Jun 2021 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4CGPkbcnjI9Yw0DNiTyYqp3G4alQJfcfm1Ng4gC345E=;
 b=FJQ4L4/yHWeUz7XneLmjLBInqmekY7xWQyHW+g6Org1LGg0LeeCP7/FKvrm70T4fZy
 C1IzEtREDWglSuyXjerzUIz/zY1jEjloz3j45x8iNSJoc1xkLAimrNu6X6iONrN4vUp3
 gJgINerR56YKnjEgxKAZtC8BR4W5F1F/9sXxctFXyTGssk8/fG/Yi2O9JL+kAyVfFZIK
 X//6ERVe1BF3QUWpyvpPhCdQjsMxqc/mpBtqmLieLkmDMvIisGr5jiXXHTAAMg4pb1w4
 HYQ5tzNSg7+S/AdGNzzV/tl4yaaIO+HAaKZy6qi+U3d7wW1Q7uehSNnce5dvV2JHxBSL
 1UZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4CGPkbcnjI9Yw0DNiTyYqp3G4alQJfcfm1Ng4gC345E=;
 b=gCF7mQPXStFI4CqoExOxKvFugNi0E6G7NLZ8hhJyNyfsUdm7FPF1h1I8xjSBLB3WKV
 IF4xZTu74Uu/crQJqkdu3XOZdZWTctZN2fG97PnTbscHkyCLTze2u2bMgiOZURDINpq8
 6RSyzwu5r9QgKup+ZLr5gayIOuAuydFNJVTS0hg+6YFuVu3qNkItqzem+75z1fDDyVsb
 uaic1ATSMYuln+t5HYrPEfWK7IYJT6VvWKZ/bXdNb5oTXDprRW0RmHQ5ApnldQooQdDi
 bEXoGEbxRKnqvHI/LWnH87A46Hi9BKzHRPl0oioY29pVXOSAPJKid4pyPc2JqeMvkiS5
 bw8g==
X-Gm-Message-State: AOAM530ckMurMtBioh4QXdGAbG27WFxvDV3YPD6I4vP59d44v4/eW15Y
 VrbBAAlyVu9bKrSjYmZKHLlBXrHXPiHHwnBVrSw=
X-Google-Smtp-Source: ABdhPJx4odrJWMkoqQlo2QxG0AX3wyRrmZHUnkNe8xCG03fPpSI2RBlvprGkalpMEdnYGC0FCuk0kVVmuT+8hEP3dTc=
X-Received: by 2002:a17:906:5d0a:: with SMTP id
 g10mr29000514ejt.349.1622556707965; 
 Tue, 01 Jun 2021 07:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210601140011.1806131-1-alexander.deucher@amd.com>
In-Reply-To: <20210601140011.1806131-1-alexander.deucher@amd.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Date: Tue, 1 Jun 2021 16:11:36 +0200
Message-ID: <CAEsyxyh5byKUF7X7CKWJphFgugJtAxzM2+ocqA+9qWkqxkS+Lw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: bump driver version
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 1, 2021 at 4:00 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> For 16bpc display support.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Mario Kleiner <mario.kleiner.de@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index c21710d72afc..f576426e24fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -95,9 +95,10 @@
>   * - 3.39.0 - DMABUF implicit sync does a full pipeline sync
>   * - 3.40.0 - Add AMDGPU_IDS_FLAGS_TMZ
>   * - 3.41.0 - Add video codec query
> + * - 3.42.0 - Add 16bpc fixed point display support
>   */
>  #define KMS_DRIVER_MAJOR       3
> -#define KMS_DRIVER_MINOR       41
> +#define KMS_DRIVER_MINOR       42
>  #define KMS_DRIVER_PATCHLEVEL  0
>
>  int amdgpu_vram_limit;
> --
> 2.31.1
>

Reviewed-by: Mario Kleiner <mario.kleiner.de@gmail.com>

Thanks Alex.
-mario
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
