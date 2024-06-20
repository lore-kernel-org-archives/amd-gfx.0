Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B501C2BB85
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:27:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8046810EB2C;
	Thu, 20 Jun 2024 16:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iWsI8MXD";
	dkim-atps=neutral
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com
 [209.85.160.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EDE710EB2C
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:27:12 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id
 586e51a60fabf-25ca30072eeso590295fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 09:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718900831; x=1719505631; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CggI56rSbhMmPiiwpPqpkPEEua/oCfumSm/hQcYxetw=;
 b=iWsI8MXDyNJwC42SPss5n0vMXPNbHoR4UtCVJD+HSmpkPLAkys5IRwEzRjQFagbyWM
 x9Ko9xoGj4JuN31te0nyQ+TIt4oB0W5yNV3y8pkWhnbXs30jpZbiqfecAgrC8yymyDXY
 zmuVZq+Ao1tVo+VTGgMD0EhWc7G+4GpgzbG1sp0Vm9WbkqpajWM815Tf8WlC+cYEdcbb
 c6u/yCpjsOwhWJY1R8iIJ6WwwfRQ1l0srUQv0tFHeb5c87Qhy+qD/qwccsugaRhnquoW
 3/NHv6IYBrlZzLjQVI/vKJHCPZQbCjM3gnGxYKmdFGQ9HZYYkig74hcxxJtwqcTF7ckh
 ieaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718900831; x=1719505631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CggI56rSbhMmPiiwpPqpkPEEua/oCfumSm/hQcYxetw=;
 b=QcxGdfOZ+tdZ6aW+1vfYO0YFhOr0b6AV9r8QnmUA6gW6iiIZ6k2tI5YZY5hy2le9rS
 VKUAMahmGQ3Ve9kvpPqE7jMUHoI2hWYneJG0sAeZnNO1immZbSgGELjUY6kiny4LLPmB
 ZmruJ1I7IbbIorTokATuKoZza7vb0g44a6tl62u9cVl3dRFt7/2isw5DfDV95lDAeogC
 PJ86ug3D8sWYI5SgOqr0pdGTuAecHaB+1Ihhn139GHwqa2cwQILDDkG5P4mgWxJKVGz0
 LDeDw3kKMkhSKkoyoT9lBPq94f5oVTYYya8qp0leo9TP0kxl/30YaMgnG2iUy3cgM+ba
 BRiQ==
X-Gm-Message-State: AOJu0YxmhAfA8WVdc/SVi7WY3PSdUSTEk3pIndHptaK1IDEaU5YMbUjW
 Nd7hQOp5KJxRrLts0gBUYkFajNRTEiBCoUrCYzqLEfo6ayrFk0ccjkJ4uaR1YokYOuEtpF4VAvr
 RKCMfRC3xQyD8mclGC2eL/chTRZ4=
X-Google-Smtp-Source: AGHT+IFJKV4yVZc5ZFKIyuQXfP+EIOb294fo67240BUzzpBvi2tAkrnMo4T9eOTDdT5XZ3+pTcxeAcCCEzLqsEfo24M=
X-Received: by 2002:a05:6871:5c9:b0:254:6e4e:23d7 with SMTP id
 586e51a60fabf-25c94d722a6mr6917439fac.50.1718900830925; Thu, 20 Jun 2024
 09:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240620135521.230223-1-danijel.slivka@amd.com>
In-Reply-To: <20240620135521.230223-1-danijel.slivka@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 12:26:54 -0400
Message-ID: <CADnq5_MtPPRm3ZaemDRLcARtWOtty9ah74dBAwEedzYf35bm4A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: clear IH_RB_W/RPTR during enabling interrupts
 in sriov case
To: Danijel Slivka <danijel.slivka@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 20, 2024 at 10:12=E2=80=AFAM Danijel Slivka <danijel.slivka@amd=
.com> wrote:
>
> Clearing the IH_RB_W/RPTR during interrupts disable is not clearing
> the RB_OVERFLOW bit.
> Adding workaround to clear the wptr when enabling interrupts in case
> RB_OVERFLOW bit is set.
>
> Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v6_0.c
> index 3cb64c8f7175..d6212a98ca99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -147,6 +147,12 @@ static int ih_v6_0_toggle_ring_interrupts(struct amd=
gpu_device *adev,
>         }
>
>         if (enable) {
> +               if (amdgpu_sriov_vf(adev) &&
> +                   REG_GET_FIELD(RREG32(ih_regs->ih_rb_wptr), IH_RB_WPTR=
, RB_OVERFLOW)) {
> +                       /* clear rptr, wptr*/
> +                       WREG32(ih_regs->ih_rb_rptr, 0);
> +                       WREG32(ih_regs->ih_rb_wptr, 0);
> +               }
>                 ih->enabled =3D true;
>         } else {
>                 /* set rptr, wptr to 0 */

These already get cleared in the else case and this function gets
called at the start of ih_v6_0_irq_init() so these should already be
cleared by the time we get here.

Alex
