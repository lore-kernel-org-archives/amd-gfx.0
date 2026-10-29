Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C8606A31F
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C8uHhdLl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A113310E81F;
	Thu, 29 Oct 2026 13:49:01 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DC0110E81F
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 13:48:55 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-36a10095f3aso288772eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 06:48:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793281735; cv=none;
 d=google.com; s=arc-20260327;
 b=KLpS6HE/ZxRu2aIEB28Vj1E2fS/h24vqAGL4efiZgQdcpvdkKrt2aHSQVehLjJ++gE
 m5Pct5T/Zbo5GepICaQ9mo+bK+yn0B5/UKUj3n0vjjOdJTC5jbMmydyJT6fMz8BT9IaG
 O/QTL5piDuYBHcUEscRdAmCZgM/zgP26ecJf36Bk4Uy1FWQom7bZJk4x/gxLrjRXHvhA
 3Jw++f7IBVpyhRWrcBynID+4Gg1tFwODGtxJsmXgGTsuMrGsNb00fCSuR9DvDKzTx1uY
 9kxYFoMJBOwbItjzL9Kjd62h5AmSkGzITO7Cnrztm3mnybPIKSyDOE8jG+j4P5nx/ef9
 QrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=84fauaEdKC/nnQSRYrxTFBu50/AtcaLbMz8/yqBy0iM=;
 fh=L1Zq8pjd/jtaRIXlQv7/blW39adfknSOItCaajOVxU0=;
 b=p72jK/EGDBhRP5Xq0l7GRRFgcvJJkXP4hfeEoOgIhAf1HyWVTYT0OrjcqX98nBsLAS
 0VC45Gcl7BjBEP7OnDZ4RQcR2lDERtQPavH8mpEIJaCyHC9UYvPYHkjIya6yIWefw29t
 0QEWxu1O7ISc9KahM4pPSiW7FLu1WpaBniJ/jTW3Rqb+glIx+CRYfdMZMwNH2KgSWLRb
 /ijkaeMrOdvVSJkU/5DoB16vqvhMBUxAx1vsOSJj1GrlhTxOVcw+JLi9Yzj+lmvIgolG
 Onzq2VkiLXsNQOlGtIUEnGETflZrltNmMr5kEiu2bbSCPfQTbXuqk+k1w7VAMvwHFYJK
 FRuw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281735; x=1793886535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=84fauaEdKC/nnQSRYrxTFBu50/AtcaLbMz8/yqBy0iM=;
 b=C8uHhdLlRwR0x7cMvUfgP4mZ4p9o6jfquqbDdZRWKQXzt2gQbBWNNwa9H9qE4lgSs+
 WcK71saQjJ5nFy3z2sqoXZQ1d2cTbrGXK24Z2Hc3FZ0aJ5wHryisR60p9eHs7pBma/Yl
 e0+dP9YAnH/4LiGdQMKNcDUokE4a/CxOSzfHVMqK13H1GSIUrcfmuO3NeFXHt95jr7Rh
 VRE3+xRZOnuT4tyH1zcro+T6YXfKaGHPkzrR2PtjwgXklp+exBda9geXr82NQ1/rpsS8
 IZvefAVAgoZb5vbAQRxWiORN8tS3EbJM2ic6PCYHpcAjc7WzmV0BlACLynN8IF2w4Mwo
 rF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281735; x=1793886535;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=84fauaEdKC/nnQSRYrxTFBu50/AtcaLbMz8/yqBy0iM=;
 b=SyUT4CTVtnncIVk6ctJLSs8o4PGRyxZF1v8xNJ06PyvnQc3OFf94j0yI2VnTzwo7LP
 iMqKfoQwei1MKoxkDOSevG9OFMZaQMEyWXvp1VxsaSv2r/bUnSBI4SfsecWwSxNHdeP4
 JIG4Jee1ji7ASYNr291mauwwQNUC6xoGJK9DTvKCelk/x9EZxR1Aorck1W8f6JJpwb3K
 vU2G8iEZ0xZzM4zDfiWWKHyQHYIwf36VS4BsM/UU/UK5Z+Zxn/O2m9SoFOxTTIdpTKRu
 VVs12lBD0DI9ebLMqjlZFq5MhK8VnAeThQDIeHwWQvhhSVW1tDJVund48+3fVaoniHn+
 upVQ==
X-Gm-Message-State: AFq9FYJDHJ9tEyX8HMJ6nysEYFj9JU+/Snyv72ftuu67h5/zvCWLarT/
 8XbQE0V+nnZB25yUD6NxpEpmV1/eTUhkB40FqE+GrWRhvzqK/e/0gCSSuFr/EZoSAacr9os1mUp
 FcAohfgRq1TMrChd2A7qOkQtcSenk/Dc=
X-Gm-Gg: AYBFou0fNF7fQjzAyrw5PnDkWrJgUGr28V0wIHATN2ibd91SOTk909e1noxJmxwJtst
 mGDqQqPbqI4KqlvXpUI9ZdMJZa27zI/LEDhhVYaIlcbaYQ4s3bLbkmbYA+66vzeAtc4Wkg+H9Xz
 VkidZ12sU+XaO3FqtkyAw+FAMvuhrFPmRiELIkGZrkDvoNGOkFy2a/P3ICha3O3PK0J/P3vFEVy
 mQcwN5Aj/giJK1wWIkprO9kDCzwlofnMKFX75sZ09xumfuT0Z2VWifOGJ+SVlbwtznAOR1GP0HE
 MMR63Lxz1uOP9BRIfyYnRXRKEBJVLsJJetWRGjaK+0gL3r7x5Nn1tAq77vwTNFEFFNPXJTKtBxp
 r06pd/dQ0KdDUZk1OpzYA1zJU0M2Z0u4ozq3OC66udrQtsT1risYfVy5xiAEzE4xQFcgNIB1jtW
 5m76rxxVBEhGvuiWUsQedbZ9w=
X-Received: by 2002:a05:701b:4247:20b0:14b:edb2:c3bc with SMTP id
 a92af1059eb24-1a6c20ec25amr11361416c88.0.1793281734495; Thu, 29 Oct 2026
 06:48:54 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028143804.24239-1-Milan.Milicevic@amd.com>
In-Reply-To: <20261028143804.24239-1-Milan.Milicevic@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 09:48:42 -0400
X-Gm-Features: AclHuK-5mK8ubWy10ngTb-7Rt_aO2y9gSnxr-ZABnYopgbtEJ4Ut0S6wG_COtoM
Message-ID: <CADnq5_O8MEf72sMHo+oB2iU46tq9+G7+j9xr2TMHwSyrTwMpTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: publish IH enabled before PSP programs
 IH_RB_CNTL
To: Milan Milicevic <Milan.Milicevic@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Danijel.Slivka@amd.com, 
 Alexander.Deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 28, 2026 at 10:46=E2=80=AFAM Milan Milicevic
<Milan.Milicevic@amd.com> wrote:
>
> On SR-IOV, programming IH_RB_CNTL through PSP is slow enough for the
> first MSI to arrive before ih->enabled is set. amdgpu_ih_process()
> then drops the interrupt, rptr stays at 0, and RPTR_REARM never
> generates another edge, so every ring hits the fence fallback timer.
>
> Set ih->enabled before psp_reg_program() on the indirect IH path for
> Navi10 and IH v6.0, and clear it if programming fails.
>
> Change-Id: Ifc89c858149df78f78888f5649118c77195c7463

Drop the Change-Id line.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Signed-off-by: Danijel Slivka <Danijel.Slivka@amd.com>
> Signed-off-by: Milan Milicevic <Milan.Milicevic@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/ih_v6_0.c   | 13 ++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/navi10_ih.c | 13 ++++++++++++-
>  2 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/a=
mdgpu/ih_v6_0.c
> index 8dee48649650..478b7169f44c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> @@ -168,8 +168,19 @@ static int ih_v6_0_toggle_ring_interrupts(struct amd=
gpu_device *adev,
>                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enab=
le ? 1 : 0));
>
>         if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) =
{
> -               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)=
)
> +               /*
> +                * PSP programming of IH_RB_CNTL is slow enough for MSI t=
o
> +                * arrive before this call returns. Publish ih->enabled f=
irst
> +                * so amdgpu_ih_process() consumes that IV and rearms.
> +                */
> +               if (enable) {
> +                       ih->enabled =3D true;
> +                       smp_wmb();
> +               }
> +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)=
) {
> +                       ih->enabled =3D false;
>                         return -ETIMEDOUT;
> +               }
>         } else {
>                 WREG32(ih_regs->ih_rb_cntl, tmp);
>         }
> diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd=
/amdgpu/navi10_ih.c
> index ab12ce8da3dc..fa5148ae526d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> @@ -194,8 +194,19 @@ static int navi10_ih_toggle_ring_interrupts(struct a=
mdgpu_device *adev,
>                 tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, ENABLE_INTR, (enab=
le ? 1 : 0));
>
>         if (amdgpu_sriov_vf(adev) && amdgpu_sriov_reg_indirect_ih(adev)) =
{
> -               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)=
)
> +               /*
> +                * PSP programming of IH_RB_CNTL is slow enough for MSI t=
o
> +                * arrive before this call returns. Publish ih->enabled f=
irst
> +                * so amdgpu_ih_process() consumes that IV and rearms.
> +                */
> +               if (enable) {
> +                       ih->enabled =3D true;
> +                       smp_wmb();
> +               }
> +               if (psp_reg_program(&adev->psp, ih_regs->psp_reg_id, tmp)=
) {
> +                       ih->enabled =3D false;
>                         return -ETIMEDOUT;
> +               }
>         } else {
>                 WREG32(ih_regs->ih_rb_cntl, tmp);
>         }
> --
> 2.43.0
>
