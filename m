Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA8ECD6E7C
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jun 2026 17:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44F6112B8E;
	Fri,  5 Jun 2026 17:50:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CPPlxJ1t";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08A0B112B8E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jun 2026 17:50:40 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-136af97e62fso42594c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jun 2026 10:50:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780681839; cv=none;
 d=google.com; s=arc-20240605;
 b=Hk2Evb6nj6Z8QpNCnBi7AwNmvzjKz4pt8F+sCeAWsI0iCgLjJCFaf/lXYtxDcmqMS+
 jk8dGgVctDRUI+wbmAhJ0fa5sF9Ai6Hd/W8fdtXWK4+ylSuVIRKamuLqG4xs2aPuy7vs
 Tl/HOgKTs+TB3eYAWw4mHIBgZF5357YBMzAQp/DcgOXUaJUjxp97hvASVdrOY9LggCG/
 JHr3bGF3M4re0m+IiaGU5kq+vh2n7b9JhTmbDtw300rSA9gcmtP7lBB9TFaw3Rfw1vk+
 7eoVQm+LabdR2BNlwCEcSJzqknfHZR0RTP37Rgp2cHQD4//sWn9lg3ZgEn4sPmINMGQ1
 BDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x+m8kF6qn1g+egOCTiTUQJTHfIKS9Ys7wNcIecPTq28=;
 fh=H/VfgC4cZPyU8hANrSoOA2UIZImS8Otn1ShIpKh6jhI=;
 b=HnfFdNnTokzHrB0y5tHlcwBrDveDR/ITDNY6TSGC4WWXRqCUgzAW4/ZFT423aa72Y5
 zRpDDwKE23085r7+1GFEMt7Eh4vRXpjatKGtuTUcIavMHS8drI/V4rYv5O8Gf9IGZwyO
 d//xoBcWQP3N3miPpvTiRqms3GlCS99PeEwz2nCM56CFcQ3D6hK1TBFurN/TgY11xW60
 9FShUPIiiEMyjLzzy3eeSr09k/kiRe9YWLh3U1Lm6tnrUs95/hbqFmMhCpeAMB4oc7Z1
 ycjNe4xsurItoZqaZk3jiY4mBz8K/I0yWyAC3PIxzSsxjZQb0GvoF+k3KcK+2ZuW2qh9
 9jog==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780681839; x=1781286639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x+m8kF6qn1g+egOCTiTUQJTHfIKS9Ys7wNcIecPTq28=;
 b=CPPlxJ1tvV9OWEa4/F33YL5EdzQPpADRVVkNOp80yuZRdgiJ/3OBi+5iMLuHAo1u4G
 7eTbFG/p/++yfdhgO1+QM1kMuVPcrVel0rBcGq1qNf29trwA7MEI68HVPzekb7GRCGvi
 EC7oxz4U9ulwQuBF7WxZR+rBLfyYaRnu33uKDWjzPvAevb+4V9DF/66Ak3CFX72UuoVC
 94I/Xm6nUDr0uUUNR+c4uaeEDJVevDdbJdnNPpoAq/L49Ea4mZdnZiCZat4vg9l7RgHk
 2PSXABd9WOiujdxq0Z7PyW0IxR3HNP8z4qKDThD1Cej6gfcNYgJ2S+EBjtM013oqt6AO
 eqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780681839; x=1781286639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x+m8kF6qn1g+egOCTiTUQJTHfIKS9Ys7wNcIecPTq28=;
 b=PM2WMqbVBaukE0hEU6riiwJvgbtUk/DWN22qHNWEnjsDgZRh6h9hTrF1Zl+oz1qkB2
 UI/uYIAhAfNPJleL90tV0LuSEZH8Qw5ZaE/s0q15blmOwI9K4VwRzwIZ//svW6WNh/wZ
 leeD5SHiH/TPAiWY9vpIYuGuWWLDU1WWp0W8VibJjsh5XlsAWcXxCsXhYoxPszzE+fKV
 pljdomrBdzopPkqfgeSE/XvnzXggEnjeNzkdDvkx5UIUNoM3qr25AAI9BUyIhBuNDvs3
 NL6hQ/wdqBmxjJw+90vlZrOsCH3lNG0Nf27TsUzMcYS6qHtb+E4n8XxjNR7z3FxvDC18
 SVZQ==
X-Gm-Message-State: AOJu0Yx1b6qCUIPbjSpwRyDOUR7HOJeKorUozaVjqbBlxSNPOzVSqVYc
 eh31GK4lE/Gumd1Hx5ZcFuEPMpr1EndWpIUNQ3qpwJJKvIZEBG4tTDxzS69f9E98o33XrRGhXrB
 t7ataHgb5zIbMzJocmOIIo9yphv3KD0c=
X-Gm-Gg: Acq92OF50ihWLKBqnwuAj1Jx4AN4EenIgc3Ly6okXF/V3FVx2ofohlx/Dvd+gF/E8da
 qmIkm+YSGtIgkoyDQOKCvRr94x28HrqW9wR85m0t47UZw+K7VRco85XYyBmuzbwR/0CdSy5aejE
 2TSLs/Q9ePLSxEor516fQrWFjUJLrSlqaO8Y62ojN1ryDR6Kg6aBtAsDgj4o6j74JqbAp0z8BeE
 KlsjuX/EmC5UyIwbYqXHyaNQzcdimg8PNvrKWsmLfyRDywCCd65Q+C+MeZsAW4qa1AFKnWJJN3/
 WCewB5LhU4uHW6ahC+JH2BtunCKp3XZ3blOK+GKMP9yP9daY7prZZPLVmDKhHquVr0fEK94auo7
 46EEhcO95Pf7dRYk=
X-Received: by 2002:a05:7022:211:b0:137:fea7:9297 with SMTP id
 a92af1059eb24-1380669e4f7mr944495c88.1.1780681839100; Fri, 05 Jun 2026
 10:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260605134400.956791-1-shahyan.soltani@amd.com>
 <20260605134400.956791-9-shahyan.soltani@amd.com>
In-Reply-To: <20260605134400.956791-9-shahyan.soltani@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jun 2026 13:50:27 -0400
X-Gm-Features: AVHnY4LO32910pJUgLgFRPomvGqy-DCbEDWqq3TmCZjhnHR0n6LVukRiZfbF2rA
Message-ID: <CADnq5_MZu7Oe9nPeyLp8se47M4kY+VSXQ2ZMGXyV02vzKfmvBg@mail.gmail.com>
Subject: Re: [PATCH 08/11] drm/amdgpu: move struct amdgpu_clock into
 amdgpu_mode.h
To: Shahyan Soltani <shahyan.soltani@amd.com>
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

On Fri, Jun 5, 2026 at 9:44=E2=80=AFAM Shahyan Soltani <shahyan.soltani@amd=
.com> wrote:
>
> Move struct amdgpu_clock from monolitic header file amdgpu.h into existin=
g amdgpu_mode.h file.
>
> This is part of the ongoing effort to reduce the size of amdgpu.h into th=
eir own respective
> separate headers.
>
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 18 ------------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 85d040184d13..8a6b6f43a320 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -368,24 +368,6 @@ bool amdgpu_read_bios(struct amdgpu_device *adev);
>  bool amdgpu_soc15_read_bios_from_rom(struct amdgpu_device *adev,
>                                      u8 *bios, u32 length_bytes);
>  void amdgpu_bios_release(struct amdgpu_device *adev);
> -/*
> - * Clocks
> - */
> -
> -#define AMDGPU_MAX_PPLL 3
> -
> -struct amdgpu_clock {
> -       struct amdgpu_pll ppll[AMDGPU_MAX_PPLL];
> -       struct amdgpu_pll spll;
> -       struct amdgpu_pll mpll;
> -       /* 10 Khz units */
> -       uint32_t default_mclk;
> -       uint32_t default_sclk;
> -       uint32_t default_dispclk;
> -       uint32_t dp_extclk;
> -       uint32_t max_pixel_clock;
> -};
> -
>  /*
>   * IRQS.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_mode.h
> index 8069fc41cc7f..f741cb407012 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h

This can probably stay in amdgpu.h.  amdgpu_mode.h is more about
display modesetting while this structure defines a clock parameters in
general (memory clock, GPU clock, as well as display clocks).

Alex

> @@ -221,6 +221,20 @@ struct amdgpu_pll {
>         uint32_t id;
>  };
>
> +#define AMDGPU_MAX_PPLL 3
> +
> +struct amdgpu_clock {
> +       struct amdgpu_pll ppll[AMDGPU_MAX_PPLL];
> +       struct amdgpu_pll spll;
> +       struct amdgpu_pll mpll;
> +       /* 10 Khz units */
> +       uint32_t default_mclk;
> +       uint32_t default_sclk;
> +       uint32_t default_dispclk;
> +       uint32_t dp_extclk;
> +       uint32_t max_pixel_clock;
> +};
> +
>  struct amdgpu_i2c_chan {
>         struct i2c_adapter adapter;
>         struct drm_device *dev;
> --
> 2.54.0
>
