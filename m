Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CF6AC3ABCC
	for <amd-gfx@archiver.kernel.org>; Tue, 13 May 2025 16:45:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1141110E142;
	Tue, 13 May 2025 16:45:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KPMwOudn";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8536710E142
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 16:45:53 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2300e7a3b71so2566865ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 May 2025 09:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747154753; x=1747759553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0xmLzICloPlzFUsUO7fW760fgd5Mj7zlVU6WQbW8kiA=;
 b=KPMwOudnnp0TUqxNJxUAFMECxcvjetyLtsjzpvvtPAj1YahQV/kFDB/Xw2PGM57Uyp
 9iYDSW7rQHc/qrslPrAeY78rTaBRnPn+GkehsOG6eQG2D6V+hmcGiHUON3CYI2HhrYjo
 EzBp+DKBsC2yva9Y5oODxDPVPM/4Eabptv567dP0TNAjdx3Ze3UWxC1SvoVKNBEO2mm1
 SA7BaKKpsZSOF8Jdn9Pdz+MgRlpyT9Burm5R2SZdtewIKayF2zMlT/ecYpxKrJyVHpHG
 7KBFnpU8KF7YUS9CROVrbYIrx8ZIPU3+Usa6ykNLGjdDsANw00Bm43G7F1kmMrpgoJuZ
 voAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747154753; x=1747759553;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xmLzICloPlzFUsUO7fW760fgd5Mj7zlVU6WQbW8kiA=;
 b=rLlmIyvqac1UTEtRC99INvOc9rAAaXh1PmKlt9yfG9GriQB7Tgtzyy9QbozULt/iL8
 aD43y4IeA6xBBwL7SmA6J0Z52ZVx0D7mbY6cD7z8/+PmRx9KxRk7OIHHDGCv8o8wihxq
 Gb9Rc/JkxA30pLAHy3LcMpauOzVsJruLF/xpD+8EoBTRQOzZcAQfpbuBNcAkDthXxbBH
 t1OF5QJQSBf46sL3ohdneWDT846/OUPru07xA+C3DJdtMv79Ove6UFSVq0aXKbU8IkM9
 7zlssV2WvtCekb+HgkyR3SPqfDJEQphOsIICXUXUPakrWKex/f+CLOMfWC1ovhwIdOmk
 FlaA==
X-Gm-Message-State: AOJu0YyxZ+eMHHSaOGnFgoQHQpirBjDuS2gi0tWwiS2aiMyBRh/euihF
 DFnOtO8WKxMjWwIigGzjHolbZjlV1mZY9ptf249lV7++oyNnYlpAyVlDILm11zHoMTD4/EPpfcS
 1NsYVAfQb8vhCyHdW+WExecnuuxpfwg==
X-Gm-Gg: ASbGncvSBytHZiemOPICOGGL+XpwB5p7iOn25u+1mgbg53Q6WNydxqzlZcnwcI1enAK
 2OKRq1zQEyq8yFuCMjXrX0ov/QAURNR1ubJhduX2/TPTNjn0xISBcpBWrdu7sOmgm6gaLvnyNsm
 xT0V3hzP9X0wb8k16zOHfDxW3q6HnxCt7r
X-Google-Smtp-Source: AGHT+IH7n6I9o6ERN+ZywvsYLTGHp64Jf/JnCGHZALi+g+UJFsAq9iH/ubp+X3mQyCtetxE2VgFXFEaRROJOIkCvcPo=
X-Received: by 2002:a17:903:8c4:b0:216:3dd1:5460 with SMTP id
 d9443c01a7336-231980befcemr926815ad.2.1747154752999; Tue, 13 May 2025
 09:45:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250513162912.634716-1-David.Wu3@amd.com>
 <20250513162912.634716-2-David.Wu3@amd.com>
In-Reply-To: <20250513162912.634716-2-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 13 May 2025 12:45:41 -0400
X-Gm-Features: AX0GCFuvIzjgjtA2VvH97wE2rCO3svGieD2ocWRUzBfqriHhNeF-n3HkAfEft6Q
Message-ID: <CADnq5_O2hf53Ky0H_wa+vcb7cecYzw439WTTdZZaTjQQ=DjBRA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: read back DB_CTRL register for VCN v4.0.0
 and v5.0.0
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Christian.Koenig@amd.com, 
 alexander.deucher@amd.com, leo.liu@amd.com, sonny.jiang@amd.com, 
 ruijing.dong@amd.com, stable@vger.kernel.org
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

On Tue, May 13, 2025 at 12:38=E2=80=AFPM David (Ming Qiang) Wu
<David.Wu3@amd.com> wrote:
>
> Similar to the previous changes made for VCN v4.0.5, the addition of
> register read-back support in VCN v4.0.0 and v5.0.0 is intended to
> prevent potential race conditions, even though such issues have not
> been observed yet. This change ensures consistency across different
> VCN variants and helps avoid similar issues on newer or closely
> related GPUs. The overhead introduced by this read-back is negligible.
>

Same comment here as on the previous patch.

Alex

> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 4 ++++
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 8fff470bce87..24d4077254df 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1121,6 +1121,8 @@ static int vcn_v4_0_start_dpg_mode(struct amdgpu_vc=
n_inst *vinst, bool indirect)
>         WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>                         ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__=
SHIFT |
>                         VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>
>         return 0;
>  }
> @@ -1282,6 +1284,8 @@ static int vcn_v4_0_start(struct amdgpu_vcn_inst *v=
inst)
>         WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>                      ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHI=
FT |
>                      VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
>
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_a=
ddr));
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v5_0_0.c
> index 27dcc6f37a73..d873128862e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
> @@ -793,6 +793,8 @@ static int vcn_v5_0_0_start_dpg_mode(struct amdgpu_vc=
n_inst *vinst,
>         WREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL,
>                 ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHIFT |
>                 VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, inst_idx, regVCN_RB1_DB_CTRL);
>
>         return 0;
>  }
> @@ -925,6 +927,8 @@ static int vcn_v5_0_0_start(struct amdgpu_vcn_inst *v=
inst)
>         WREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL,
>                      ring->doorbell_index << VCN_RB1_DB_CTRL__OFFSET__SHI=
FT |
>                      VCN_RB1_DB_CTRL__EN_MASK);
> +       /* Read DB_CTRL to flush the write DB_CTRL command. */
> +       RREG32_SOC15(VCN, i, regVCN_RB1_DB_CTRL);
>
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_LO, ring->gpu_addr);
>         WREG32_SOC15(VCN, i, regUVD_RB_BASE_HI, upper_32_bits(ring->gpu_a=
ddr));
> --
> 2.49.0
>
