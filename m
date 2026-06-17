Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D3ECD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 13:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6032D10EA2B;
	Wed, 17 Jun 2026 13:26:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aHj5VKvs";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9C3410EA2B
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 13:26:56 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304d3d3d8f8so725826eec.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 06:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781702816; cv=none;
 d=google.com; s=arc-20240605;
 b=V4tzuSRyFUUiaA4htoPcboC976MBGZz3SBUQoMqvB2FAsHlDFM7HWwGjEq7lhf0wgJ
 xtXi3VL0+TKSVnAlemLfVjGXdbPomU1mNfVFPzojagl47lxwutW6d1d93ag9Mxgh0YKt
 faQOIwA3FZIbRxW9nCjo3BzFLU4aU4xNdWvX7zyysaA/kIiBAIS+UAvSDbaqm6JNXfT/
 0eXU4S5eV2wtZNs1d0ERDOZF25DClQgeGVER+NHzmq9XAyj1uvMOobw9GJpHqXvJ4oAB
 GdxuFJN81VoTS2b4JB6JBm6NMMMZuzH63VbYyJsvJpIJst51kenHuq+/Cewnu/ZLpScx
 sARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d760RHZipPX9D3p9udTZhAxLEnWTv8d7UEdllknH4To=;
 fh=IXZIt93hx99XblIzFBs1ZAFAnfy5ZlY+Yj+VwpjuspE=;
 b=W45f/8SBh4mFTT+ZNxCkjbYZsbObVmwNBKvKX1UdrlDL4Asfg8OFOLHGQADcxu3lEU
 tTMcZXK7Ub9CJ3sKz1k4hADXc5fHGsRQa/E9tTgAgTeBhJYk+Cwq4VE7SHUgNpjdDeP6
 CHcfPCiATnxyzlip+Uu1LrLvLUAYoQ/PhVsORCov7N/vFl5e/7QT/UUkDxEhzeSsLzW+
 2O0lVTQsg1svFlTOuMEQIVCAit3yobf3nDaTQIQYK9PRhEhRu2sB7MR/+R21uPVtbqsR
 KqRb39CrlPKa12+rZimSA6WnoQQ+Kc2WIytUotDfqlhKDsa0d63r8CCJIu/t3E2aQufi
 8O2w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781702816; x=1782307616; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d760RHZipPX9D3p9udTZhAxLEnWTv8d7UEdllknH4To=;
 b=aHj5VKvsgzwlSP//nSs0lWQK68TrYI6nIGapaLZZRyfJZvXXBQvQo9p44BwEbOxOBZ
 lPHMMXts47Geqg+VI5basZ0CSGpEVg8dZQJA6k9qw3XZM5dU1lbtRSR3d73AZLIHQgeB
 P6lJh4E+ccbO1JhWhK+/dN7sM6njfibhWjVOjUkyh4H6KM4+fq3yxOCTLD/TlgInRnh8
 IKroC3eWgiqWC1dgLSk8EkqppTNqw7Od1XfcVUyhqhtnRsfi/1LK3qD3+ODIVgYo/lib
 dLRFw+gXr82a2Gg1D1QBKOAD13fJhR1qHG583XGlHkLc+RJgB/u35Q/2oDp1L9wmt7Dc
 /62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781702816; x=1782307616;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d760RHZipPX9D3p9udTZhAxLEnWTv8d7UEdllknH4To=;
 b=SLzXY/FriI9WbBL7o7wzkzrt0mdzIo5Qnm7xDLwyXRVx141w77s83YwBC/zraprzZn
 Ci6wR3YwhL1Er7Vwq0959+vDNBdlBjrAbJOq+/lvd1eIhPLQ3sUhzQRKCm1St03tPq3O
 liN9aPJrYixrSMrse1l3gsZvGblRJRBo+U6C9yxGXZe6yyarjel3HLfM11xbzt9U9w8X
 h3Zh7W018b2kYOYu2KZqvE1iblDucpIGW6s2hzEPGFUMPsqCVUFauLPdgxz4JyxYv+GU
 0Ab3VwXkLALbViTq2MjHSKPkuzIcfputI41kpjDYqQyAcVPqR04oW3ZxJjD4XoHwXK4E
 mdyw==
X-Gm-Message-State: AOJu0YzlSzvAvQhGExdI0TxY0TvAYcEqyUaEEw3LbdFZFgd3y+MHA6Ud
 9JhKqYxR9+sxNi1+elsfRQ3Xv0BAvIFldrBIBBgh3K0J6rADhQ33bpP4FMkNfSD8lcWsxywETtQ
 yq68gtjvM2kym8x2GV8kLaJEkVmsNYFQ=
X-Gm-Gg: Acq92OGyd5RqtUpwTS2VuagLhAFvmMXiUiQwgXCqtLolFQmdUonYQH4321HG7ppZk9I
 pyyZzqB8UNHDGhfYt/eQmrLsz3I/kt0KXmCQklnyWQnAil7a4I1XPdjAHoAaqQtLKFKS0seE54H
 dpk30loKBI+rlyaBbQY4Lib8g+VpFifg1uRhdCELp6Ua5znYHyylsDSX6JSMBIVX3Y31TNYkJQ6
 T7I8su8xxjWhd+7U8CWZobN6wAoRRmmA/46vxVqJyZ34qpwfVFYK2Wjyw7PB/EL2ref3c6BTJC2
 stlym9KAs9FK6z8mvUY04jHR6TcPOvMM5bmoSmKGpOxaEqBgAAwVTjIu79SI6gPkFRc/EQ==
X-Received: by 2002:a05:7023:b06:b0:137:d966:d890 with SMTP id
 a92af1059eb24-1398f6ce9f3mr754832c88.7.1781702816075; Wed, 17 Jun 2026
 06:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260617102925.12599-1-Priya.Hosur@amd.com>
In-Reply-To: <20260617102925.12599-1-Priya.Hosur@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2026 09:26:44 -0400
X-Gm-Features: AVVi8CfQNNg_qEkUu8zW3qrb7du6s3uq2CzjLDBsLBWbwdsS-yOkfbu81sie0NQ
Message-ID: <CADnq5_N9uDcnpVdimszrwe-YmivmzTBz2GaGVH5UU+ff7hnt7w@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting
 via VCLK level index
To: Priya Hosur <Priya.Hosur@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo.Lazar@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 Mario.Limonciello@amd.com, Kenneth.Feng@amd.com, Pratik.Vishwakarma@amd.com, 
 Veerabadhran.Gopalakrishnan@amd.com
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

On Wed, Jun 17, 2026 at 6:49=E2=80=AFAM Priya Hosur <Priya.Hosur@amd.com> w=
rote:
>
> SmuMetrics_t has no DclkFrequency field but DCLK and VCLK have
> separate DPM clock tables with different frequencies at each level.
>
> Introduce smu_v14_0_0_find_clk_level(), a shared helper that
> finds the closest DPM level for a given target frequency in a
> frequency array.
>
> For METRICS_AVERAGE_DCLK, use the helper to find the DPM level
> whose VCLK frequency matches the reported VclkFrequency and
> return the DCLK frequency at that same level index, since both
> clocks share the same level count (VcnClkLevelsEnabled /
> Vcn0ClkLevelsEnabled).
>
> The original code returned 0 for METRICS_AVERAGE_DCLK, which broke
> the active-level marker in pp_dpm_dclk entirely.
>
> Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> index 2fe006de927a..b206a4d0376b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
> @@ -260,6 +260,35 @@ static int smu_v14_0_0_system_features_control(struc=
t smu_context *smu, bool en)
>         return ret;
>  }
>
> +/**
> + * smu_v14_0_0_find_clk_level - find the closest DPM level for a frequen=
cy
> + * @freqs: array of frequencies (one per DPM level)
> + * @count: number of valid entries in @freqs
> + * @target: the frequency to match
> + *
> + * Returns the index of the DPM level whose frequency is closest to @tar=
get.
> + * If an exact match exists it is preferred; otherwise the nearest level=
 by
> + * absolute difference is returned.
> + */
> +static uint8_t smu_v14_0_0_find_clk_level(const uint32_t *freqs, uint8_t=
 count,
> +                                          uint32_t target)
> +{
> +       uint8_t i, closest =3D 0;
> +       uint32_t best_diff =3D U32_MAX;
> +
> +       for (i =3D 0; i < count; i++) {
> +               uint32_t diff =3D abs((int)target - (int)freqs[i]);
> +
> +               if (diff < best_diff) {
> +                       best_diff =3D diff;
> +                       closest =3D i;
> +               }
> +               if (freqs[i] =3D=3D target)
> +                       return i;
> +       }
> +       return closest;
> +}
> +
>  static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
>                                             MetricsMember_t member,
>                                             uint32_t *value)
> @@ -284,7 +313,30 @@ static int smu_v14_0_0_get_smu_metrics_data(struct s=
mu_context *smu,
>                 *value =3D metrics->VclkFrequency;
>                 break;
>         case METRICS_AVERAGE_DCLK:
> +               /*
> +                * SmuMetrics_t has no DclkFrequency field.  DCLK and VCL=
K
> +                * share the same DPM level count, so find the DPM level
> +                * whose VCLK matches the reported VclkFrequency and retu=
rn
> +                * the DCLK frequency at that level.
> +                */
>                 *value =3D 0;
> +               if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) =3D=3D IP_V=
ERSION(14, 0, 1)) {
> +                       DpmClocks_t_v14_0_1 *clk_table =3D smu->smu_table=
.clocks_table;
> +                       uint8_t lvl =3D smu_v14_0_0_find_clk_level(
> +                                       clk_table->VClocks0,
> +                                       clk_table->Vcn0ClkLevelsEnabled,
> +                                       metrics->VclkFrequency);
> +
> +                       *value =3D clk_table->DClocks0[lvl];
> +               } else {
> +                       DpmClocks_t *clk_table =3D smu->smu_table.clocks_=
table;
> +                       uint8_t lvl =3D smu_v14_0_0_find_clk_level(
> +                                       clk_table->VClocks,
> +                                       clk_table->VcnClkLevelsEnabled,
> +                                       metrics->VclkFrequency);
> +
> +                       *value =3D clk_table->DClocks[lvl];
> +               }
>                 break;
>         case METRICS_AVERAGE_UCLK:
>                 *value =3D metrics->MemclkFrequency;
> --
> 2.43.0
>
