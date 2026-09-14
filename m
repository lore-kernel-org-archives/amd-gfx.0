Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326AEC88E6E
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 15:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC4210E561;
	Mon, 14 Sep 2026 15:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SvP26Iw1";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DAD010E561
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 15:32:07 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39931869b4aso348623a91.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 08:32:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789399926; cv=none;
 d=google.com; s=arc-20260327;
 b=bJ0Zqw5vgjtuKs/rPTE038amFGeelo9fzh2PBqh3RpJb19PuIIgoHNqm0b0FGavIoq
 Cwq3qm13JD0KWr1O00kY22ALmxmcyu/el1hIASuJaGN6W1OCzVKcCavIhoiafX5t6ujH
 1Lk0Bv7pjTlODlps1m7dB27oXEf6gK9GGZqEMhyZqTrzl+VKdGenIHlYp0BJ3VyBPRdG
 2t9ODSQ+fJFEL8/HLTKxEEwZE2s6FHhnW1xSTSeE8mMsOUN2c1quZDwem1ANFS7UiFf5
 JKudbi4J9auKmBQFYujFKAyU44vIEB/j+vf6uf6QXNAnbkWXC0pvGWIQk+tHS/z2JOGt
 j5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MitgSN7iq+XR082+kpNiIIOeDELUj0jZdl7Np52KGCw=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=n5LXNRiUX8fhpY83lm1LMD8eCckbVPQdSXsFdx9ERIavIOpZsm5/kX1E7TtbcX1YHv
 750ULxyft5i+jLwjED8cYREq4R01WzCb9CRcu5Q2UpaO6yjsCzlO62StK7gw8h370xz9
 EZ5gJVyc4/pj2ifgskZnzAcq7WnL6dRWBC/FlN8uGxSM+4M+IiCiJEGYTSVYU71iBVCE
 B6AvgztXJ1lo5JsBhhdWmCSWfg4vhCUzvBE9yZ2TbfQLs0iSOloyFivBsRE3TsGcD5OK
 KgZMOCJoCb7YWdqJMjG5xrU3XpSBqXexD704q+mfBC++j16guExaKYRC96C9st+Pc0y3
 Capw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789399926; x=1790004726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MitgSN7iq+XR082+kpNiIIOeDELUj0jZdl7Np52KGCw=;
 b=SvP26Iw15xh7erb1jxwYH0jvUaU4Rmj1dzf1D6tbt0Jko5wkpEnZX/PzCmoZNj0Ups
 6Qy5DF16HDfqSUOsYSDzyhiwZQCISX71uW884dzsszGz7DTybCjSl2gC4xhSswapnQsR
 pKTtxqBHIUq88YX3XS8AxrkeD6lWXknsvJg7+Lppqr11ccJr2LuE+pmDO7lnYnzC8n1b
 RAhKbT0lT+CigJACSEFwGaOyIYEjjhBoJ1Ug+exS9CwgPSJQ5Hf9D631TBrhAhY3N0JS
 kz3o90MkYsBJRaxLZdnSI2g+002xZmbZMS/1F70KmxHx0EZi/9QiGRQMjKwAdKYkzwH7
 62Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789399926; x=1790004726;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MitgSN7iq+XR082+kpNiIIOeDELUj0jZdl7Np52KGCw=;
 b=eyNjTDS/xGg+AyzX69kkmNO3iAP8NxXznI2K8BsDtQV7o3wm0aMGnYfdosdFrUiEU/
 wb1GCsZjzZqWWL8/zb3ZG0iwuocQ0poK0P9oxl9azKfZNYD9IqYS0vUAMgOb+QtMu10t
 Z8u7Q5s/3QcKt6eAbezWrpwezv/FRjzFeSE832EoaW3JgDcJo7lTZZx0CGXBkIuqNY/e
 2tRSqisadd6L24l1fI74BPu7tE8NA5sTxXzXenRxudkffmMdNX5boyTz8VdvcoVh4bPD
 Jqj3V+ptqtTt6ynqgRWkk5I0j6OKV7swhNklSdwSO3AYg+Covzw+/fFscsW9ZSL/Dxea
 6zAg==
X-Gm-Message-State: AFuF++nC7VzT3zdGLwoT+AYmZIejS8p6eYXVaV4q02H+OJI/o/93UiYR
 BJj/Yxjob7PDY+JYrptkwk7K5rp54tefZRVMTj+2pxYwb5nH6s99uptkM6rJuqd8R/PsvblDWfq
 r2hiyH8Az/rA08GWDygIdqnm694X/IN4=
X-Gm-Gg: AYBFou00yP2UWvBZpmUu3AzhIU68HC9U+2zi/ADHmJ1tJGA/S33F5z4WYVrVTdYh3dp
 1yNByDjVZ0Hrp0p0DYlUDEcR+XADMiTgWVuwJuZAhT86qo0816cHuNmpkTW5GlIy1zLdterZb4Z
 u1CaX/BVfPWAud3miaGPCm8wYcz5bTR9/eTttMiX908aYMXMLYE2OUq9lduHe1M9hm5lWAjqYOY
 /5pVjRY6p7csv+qkydgHZ13f/xk54ttjZunSfKdshdfvHcOriswbgxZ2nLk4kpsUJv0A/+Hw0Ke
 qordjQCoeSq569WlAdRjwSrAeBdMSOOhQY6LKwTrH2UVquFAbRcJ9Wrzkb9fOoGkOUEqOAmMzrs
 E7ADM+qql8B56kuvbOFEuxwYCYdPMORyF73hVpGxNfTqNyKzP4JfA
X-Received: by 2002:a17:90b:1d4f:b0:38f:aa76:88b with SMTP id
 98e67ed59e1d1-39dec1c3dabmr4709481a91.4.1789399926337; Mon, 14 Sep 2026
 08:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260914022002.2005150-1-mario.limonciello@amd.com>
In-Reply-To: <20260914022002.2005150-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 11:31:54 -0400
X-Gm-Features: AcwNN1U6eUF5w6OdLWCAuqyJNMwdLG0nyLPNvCpzb2vuGyBCVhC8owfeKyR45IU
Message-ID: <CADnq5_MTPUWZ9n0iEnUT_07bfO2wpNHskvMLRY-cQDZWboP8og@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: restore eDP panel power sequencer on Apple
 DCE3.2 iMacs
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Sun, Sep 13, 2026 at 10:20=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The Apple iMac10,1 and iMac11,2 (RV730/DCE3.2) drive their internal eDP
> panel through an LVTMA power sequencer whose enable bit (PWRSEQ_EN in
> LVTMA_PWRSEQ_CNTL) is programmed exactly once, by EFI at cold boot.
> Apple's minimal ATOM tables never touch it afterwards, so any GPU
> re-initialisation - S3 resume or a GPU-lockup reset - clears PWRSEQ_EN
> and the panel comes back dark while the rest of the GPU resumes fine.
>
> The driver never programs this register itself; on every other radeon
> board the platform firmware maintains it across a re-POST, which is why
> this only bites the Apple machines. Re-assert PWRSEQ_EN in the eDP
> DPMS-on path when it is found cleared; the hardware then runs the
> DIGON->DE->VARY_BL->BLON power-on sequence on its own. Both failure
> paths pass through here, as radeon_gpu_reset() restores the modeset
> state via radeon_resume_kms(), so a single site covers resume and reset.
>
> The write is gated to Apple parts and to exactly DCE3.2 (ASIC_IS_DCE32
> is >=3D RV730, so DCE4+ must be excluded - Apple also shipped DCE5, e.g.
> the 2011 MacBook Pro, where the register lives at a different offset).
> It is skipped when the sequencer is already enabled, so lit panels,
> DCE4+ boards and non-Apple boards are untouched. DCE3.2 places the
> register 0x18 above the documented R600 offset.
>
> Only iMac11,2 is verified on hardware; iMac10,1 shares the same RV730
> design and Apple EFI behaviour.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5719
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/radeon/atombios_encoders.c | 36 ++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index 8b3f8303a967e..5b9c72bf40994 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -1646,6 +1646,38 @@ radeon_atom_encoder_dpms_avivo(struct drm_encoder =
*encoder, int mode)
>         }
>  }
>
> +/*
> + * Apple's EFI enables the internal eDP panel power sequencer
> + * (LVTMA_PWRSEQ_CNTL) exactly once, at cold boot, and its minimal ATOM =
tables
> + * never touch it afterwards.  Any GPU re-initialisation - S3 resume or =
a GPU
> + * reset - clears PWRSEQ_EN, so the panel comes back dark on the DCE3.2 =
iMacs
> + * (iMac10,1 / iMac11,2, RV730).  Re-assert PWRSEQ_EN when we find it cl=
eared;
> + * the hardware then runs the DIGON->DE->VARY_BL->BLON power-on sequence=
 itself.
> + * DCE3.2 places the register 0x18 above the R600 offset.
> + *
> + * This is restricted to Apple DCE3.2 parts: the register lives at a dif=
ferent
> + * offset on DCE4+ (which Apple also shipped, e.g. the 2011 MacBook Pro)=
, and
> + * non-Apple boards program the sequencer from their own firmware.  The
> + * read-modify-write only fires when the sequencer is actually disabled,=
 so a
> + * lit panel is never disturbed.
> + *
> + * https://gitlab.freedesktop.org/drm/amd/-/issues/5719
> + */
> +static void radeon_atom_apple_edp_pwrseq_restore(struct radeon_device *r=
dev)
> +{
> +       u32 pwrseq_cntl =3D R600_LVTMA_PWRSEQ_CNTL + 0x18;
> +
> +       if (rdev->pdev->subsystem_vendor !=3D PCI_VENDOR_ID_APPLE)
> +               return;
> +       if (!ASIC_IS_DCE32(rdev) || ASIC_IS_DCE4(rdev))
> +               return;
> +
> +       if (!(RREG32(pwrseq_cntl) & AVIVO_LVTMA_PWRSEQ_EN))
> +               WREG32(pwrseq_cntl, AVIVO_LVTMA_PWRSEQ_EN |
> +                                   AVIVO_LVTMA_SYNCEN_OVRD |
> +                                   AVIVO_LVTMA_DIGON);
> +}
> +
>  static void
>  radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
>  {
> @@ -1711,6 +1743,10 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *e=
ncoder, int mode)
>                                 atombios_dig_encoder_setup(encoder, ATOM_=
ENCODER_CMD_DP_VIDEO_ON, 0);
>                 }
>                 if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) =
{
> +                       /* restore the panel power sequencer on Apple eDP=
 iMacs
> +                        * that lose it across resume/reset (see helper a=
bove)
> +                        */
> +                       radeon_atom_apple_edp_pwrseq_restore(rdev);
>                         if (rdev->mode_info.bl_encoder)
>                                 atombios_set_backlight_level(radeon_encod=
er, dig->backlight_level);
>                         else
> --
> 2.43.0
>
