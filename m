Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A5A0C76196
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Apr 2023 15:17:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAAD110E0AE;
	Mon, 10 Apr 2023 15:17:31 +0000 (UTC)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B1010E0AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 15:17:30 +0000 (UTC)
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-1842eb46746so6225021fac.4
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Apr 2023 08:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1681139847; x=1683731847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ET1PZv7whrjV5CUzLUaEJuCJfJSOqA2Bb5EYPoXBFOM=;
 b=CLsC0KOzuyJdm8KCIai2DZmabA/mNRsnOOQ9lnX/odMTNFKE8r9ZFP6VMrlqqZyzu4
 ppFb/WI0ZItFRF87hGeSFI0qWIPKVYEVGjq9fUyyYU2vXq20wIf7yKmCNKkBxFMSBKcE
 5dPYSSAoqPY24jw0VJOsfIgDGRFnOia3cBjPRyTDnLw0Q+rcAkp1co5Z2MFvT70jfmoP
 qNw21ZwI24gW0Cb8SXObt+EoWp9aHWxMowLx827y66ItMuBYS6+8KgU+jeKacfoCW1q+
 tnIhBwxaUOEYoDf8TRePjfsKmWhCEewvbxrKCWEmuuELRQV0sYZsvDQ70dvMVB+SYW/u
 Lt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681139847; x=1683731847;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ET1PZv7whrjV5CUzLUaEJuCJfJSOqA2Bb5EYPoXBFOM=;
 b=j1lujJUsKLVSKkfQL6ykEVHlCQ2cWQw3EIaIINbS28M5SeURY1+OC6IvLmy021WaS2
 RkkuiC5PuMn4zmfF4FD93UtItMciQ5MOD+y12DNtYeDDEa85HO2fCtEWWtmhfPwncL/i
 rXWKPKOfKuZtEC0cphdbBghVsQ/eDa2kkb9+5MLOjDgjqtJ4Vrr2wOcTryeG/zAKBD+Z
 +keIG8vv704pwTSpWyT+sGstsxx74FFqe+/HS//vwq7/zF2h5ikLf9KkdcZaulvnvxaq
 V80NBgYswuRiciK9T3OVW+sn4g1VKvOvEdQ0GM6sFSYmCOkSoHVPEdDXVZHcPJ/HfCvD
 ISMQ==
X-Gm-Message-State: AAQBX9eU2wGVj2aZxMqGCN9uUHlUYk2b/gm5/VIzlnAiyCciJu41JNIW
 ZrjxvuyED52CpDqcEpE/pJy1MIKNOdShx3Sk6gzsjLqB
X-Google-Smtp-Source: AKy350Y4f21gQhdML7dUWEmcSaNdU2bKcNROvD9unU23WMLMO0R9W5YucFOxiZnLM/qfkc5womuXGK+dzQMAGUnXEYs=
X-Received: by 2002:a05:6870:b616:b0:17e:71a:7578 with SMTP id
 cm22-20020a056870b61600b0017e071a7578mr5065938oab.3.1681139847626; Mon, 10
 Apr 2023 08:17:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230407091623.23174-1-evan.quan@amd.com>
In-Reply-To: <20230407091623.23174-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Apr 2023 11:17:16 -0400
Message-ID: <CADnq5_NAd04mr3ubbKZSJNa1dGZZ2SW2UYZ34iR4C63=Sx4dBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: correct the pcie link state check for SMU13
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 7, 2023 at 5:17=E2=80=AFAM Evan Quan <evan.quan@amd.com> wrote:
>
> Update the driver implementations to fit those data exposed
> by PMFW.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I8579f6b22fb586bb52a6c97b8edfc13c493bd484
> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h         | 6 ++++++
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++--
>  3 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/d=
rm/amd/pm/swsmu/inc/smu_v13_0.h
> index 60c719a726ce..e9b14237ae19 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -62,6 +62,12 @@
>  #define CTF_OFFSET_HOTSPOT             5
>  #define CTF_OFFSET_MEM                 5
>
> +static const int pmfw_decoded_link_speed[5] =3D {1, 2, 3, 4, 5};
> +static const int pmfw_decoded_link_width[7] =3D {0, 1, 2, 4, 8, 12, 16};
> +
> +#define DECODE_GEN_SPEED(gen_speed_idx)                (pmfw_decoded_lin=
k_speed[gen_speed_idx])
> +#define DECODE_LANE_WIDTH(lane_width_idx)      (pmfw_decoded_link_width[=
lane_width_idx])
> +
>  struct smu_13_0_max_sustainable_clocks {
>         uint32_t display_clock;
>         uint32_t phy_clock;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index 29c5200356bb..48ba6e2c683c 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -1149,8 +1149,8 @@ static int smu_v13_0_0_print_clk_levels(struct smu_=
context *smu,
>                                         (pcie_table->pcie_lane[i] =3D=3D =
5) ? "x12" :
>                                         (pcie_table->pcie_lane[i] =3D=3D =
6) ? "x16" : "",
>                                         pcie_table->clk_freq[i],
> -                                       ((gen_speed - 1) =3D=3D pcie_tabl=
e->pcie_gen[i]) &&
> -                                       (lane_width =3D=3D link_width[pci=
e_table->pcie_lane[i]]) ?
> +                                       (gen_speed =3D=3D DECODE_GEN_SPEE=
D(pcie_table->pcie_gen[i])) &&
> +                                       (lane_width =3D=3D DECODE_LANE_WI=
DTH(link_width[pcie_table->pcie_lane[i]])) ?
>                                         "*" : "");
>                 break;
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> index 0559bc88f44c..c0067272651b 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
> @@ -1079,8 +1079,8 @@ static int smu_v13_0_7_print_clk_levels(struct smu_=
context *smu,
>                                         (pcie_table->pcie_lane[i] =3D=3D =
5) ? "x12" :
>                                         (pcie_table->pcie_lane[i] =3D=3D =
6) ? "x16" : "",
>                                         pcie_table->clk_freq[i],
> -                                       (gen_speed =3D=3D pcie_table->pci=
e_gen[i]) &&
> -                                       (lane_width =3D=3D pcie_table->pc=
ie_lane[i]) ?
> +                                       (gen_speed =3D=3D DECODE_GEN_SPEE=
D(pcie_table->pcie_gen[i])) &&
> +                                       (lane_width =3D=3D DECODE_LANE_WI=
DTH(pcie_table->pcie_lane[i])) ?
>                                         "*" : "");
>                 break;
>
> --
> 2.34.1
>
