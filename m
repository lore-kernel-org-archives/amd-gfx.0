Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F07E607993B
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNzfbyja
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9989C10E08D;
	Mon,  2 Nov 2026 15:51:53 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A375E10F049
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 15:51:47 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2e853a56bb4so1335285ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 07:51:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793634707; cv=none;
 d=google.com; s=arc-20260327;
 b=g5g3hkTJCICvm86yX3v2Hb8aWhoLBsML7+PbqVz0/jP8Kmyqb0o+daEr0T8lk19p9z
 99U/zmctsBrn6ufaqkAgAGyzXcd0GhCxhPZV06/fPgYTl13myZxnj6xEJuT/p2dkG+fp
 53EAdUqgoQPRd7znK1fI1JV2z0OsLWlthHOMTsPv+567bzw/En2lYP7gdNmitpBBaiEo
 AFMNgSYI3/itlZr02EbSJGHiIJGr9EapBv3X+TV2S+n5b1F9BmFRMB6sEOYfz/BM1Ggz
 TIlwkAm5JZFvhXOhOTyRFsc0oPZ5Nt7QD0gQtLY/9+Er+A6iTNvjl52O+GJoCo+2TQMP
 d9Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nOCgKoJdIhSObbuGxZ7xKscGyZkjtDdaeTHB5AW5EkM=;
 fh=4Bv9XQawu6aFNJ0MIinLl1HlJPyYcdDTjb0EylH3pAo=;
 b=Q5SqmPCwiK2qR66OavXW7es+6jcrg6vkqzaBw4HT0qyG+RBt1V9C/wLib4H7Ura7u/
 BoIz4n7Fqn+vszxhPyhyS2B+wuKrMzsApr+/f2prnSWhXTMq3fxzBRmSXacewAyWGyMU
 i1dtuTDJkoWTEi25R9dst7MC/FYbqzhu1LFa2UiCm5wQD6NthSY8gDIlOLVTRwn7QyhI
 BMnJRzSWfDwxBrTcOP7smgjzay103j0N58ghM19EqSqxUbIEHicP0EJ2UK121BpBT6PK
 XdmRd3yX7ogIxjfNTzYhSCMoA7ELVL/BCiIMpQMAp9Zfs0NkAM0vGQg0Ho+qJvtbC4PQ
 s56Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793634707; x=1794239507; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nOCgKoJdIhSObbuGxZ7xKscGyZkjtDdaeTHB5AW5EkM=;
 b=hNzfbyjatZkU9Hfgbr6Lq6hfSHRcZvlS1JglBDC1CAO6Ygro6i0L1QT/OcOuEsQSq8
 IOPwMM213+NFNMbxK+bYZM010AK2rWK7FyBMfK14N2rjEwLY3ME1ZQX6VHy//+dQHjlw
 csAWDFHET6n2DQVCnOzp9DqCzct4vYsZXCVuEVHBXDgg60QBoIuKCe+jHAWNlTddDmkP
 5nnS6RPj6mwJ/FgRaLOXcodTTxVuG6trOpg0yTEFTR1vyCT3OFWeZndTF+vvQ7ZIZQx6
 6GWyuyQ1DInH2tONcIK5D1cin9m9t4AT/cqpTNqM9lEn1km0H1bkpcwyZFeNmtes0DYX
 Kmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793634707; x=1794239507;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nOCgKoJdIhSObbuGxZ7xKscGyZkjtDdaeTHB5AW5EkM=;
 b=mQ4lJW+TUs1ashZu0eZZCcgAqcakDon2YPwUYZrdrd0qsOr3X8Y9bZjDLvbGC3vXc0
 /IYkzs8tlhds4KvJGiPuqfU7tSkJsVNgNAVz0ph5e6i5Maw15od1aRyxbYSwRG5eargG
 ESYhlyJPW23KhhWeBHZRDUuzUSNIUjhLDg+SuCUcYM19gF0Bb3plHnCJtZRRgaHifQWx
 lZs9Xd7Ws5AP4fSxCdbemWRD418ULZfyFpbsaeKQHEmfYaU+bYGHm2bKbBvG9mHRRgR5
 D9VazSO2Ctn7M/U8ijiyrxGkcy74L5MZjehG4ZytGqkuHoAYgs4YkKf32DxiF6rgECk5
 AfJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfqYVZMbHoeOJa+dyh/KU9XgAKQk9uTXSm72VzZf5goRyXvQ7gxSR5JN573TQWD72/Fo4Mh3Xn@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9vur/tvUbWYAH86GjNiwv6ojwjQL7ATbcKmZ/DkSGl+aVKGzIL
 WQtHQQyNy5UlIALi2IY21IHfazYdtZrnAbsW1I/MLbFUWWl5QNVVcSLhQbQJlRL0nUisc9cEidw
 mmLcOkeVfh0vq9CjIu6cXbzCcHe6eReA=
X-Gm-Gg: AYBFou2Fg5hM3fE2rDrqqjNetCAQXI6wKzEQbVCzDe8ic22wUFzElSva4ldHDzucrU9
 h+M0Z2iigH1cNeqOwDGGoJTXAdwjre+o3nrvkqinCPlZUXAlXo98upg8Pkh4VxvnCO/rCN6kGlF
 zmC73wFlRlJ4x4H96HVVl6GgXyRcyyRcxZWAbIZF8mEq0fSufhDMriywdC5AZ6eTIkCoSBnFfUc
 qxxeL6c0oJ0jJR5vLBa56S6R0eD4uoGs6zqDY4YfVWMZrJ8y/zXfSZajSOlx/gJ22ldBROf/5xU
 FeKdVbCTjCJWSAHAsR6JUXkqkckeAyKkAESgWV1gzvmc+GawJ4MyrxKzs0QwZunMUOqsC5XbKya
 Yv21UtFD9KWCxbIsm/3Bt1tXPYmRGppeGRcEPK+wChUEfqzIjbhrs16eNj9U7CtvhTr8RPB1t7Q
 a+A93MUUS4nu46qi+bd5HUlvnc
X-Received: by 2002:a17:903:37cf:b0:2e9:6468:2005 with SMTP id
 d9443c01a7336-2eb3648cd80mr155350785ad.2.1793634707021; Mon, 02 Nov 2026
 07:51:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260114163807.2525868-1-ingyujang25@korea.ac.kr>
 <20261101132405.1387745-1-ingyujang25@korea.ac.kr>
In-Reply-To: <20261101132405.1387745-1-ingyujang25@korea.ac.kr>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 10:51:35 -0500
X-Gm-Features: AclHuK_dNc-WbpSUdvsrzWpZry_6vBxHfWOCNfPxLRPLLxJ6Y7fVPrrrC1rt0jw
Message-ID: <CADnq5_MU1M1_7gsQFv_+B4r-YNa6yQ0WTCiO1_DAahwmshDWUg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: remove dead code in
 smu7_patch_dependency_tables_with_leakage()
To: Ingyu Jang <ingyujang25@korea.ac.kr>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 1, 2026 at 8:31=E2=80=AFAM Ingyu Jang <ingyujang25@korea.ac.kr>=
 wrote:
>
> The smu7_patch_*() helpers called in this function only call the void
> smu7_patch_ppt_v0_with_vdd_leakage() and always return 0, so the error
> checks on their return values can never be true.
>
> Make the helpers and smu7_patch_dependency_tables_with_leakage() return
> void, and remove the dead checks.
>
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>

Reviewed and applied.  Thanks!

Alex

> ---
> Changes in v2:
> - Make the smu7_patch_*() helpers and
>   smu7_patch_dependency_tables_with_leakage() return void, as suggested
>   by Alex Deucher.
> - Rebase onto current mainline.
>
> Link to v1: https://lore.kernel.org/all/20260114163807.2525868-1-ingyujan=
g25@korea.ac.kr/
>
>  .../drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c   | 117 +++++-------------
>  1 file changed, 30 insertions(+), 87 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> index bdf1e489369e6..dafe25b1efb65 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -2672,8 +2672,8 @@ static void smu7_patch_ppt_v0_with_vdd_leakage(stru=
ct pp_hwmgr *hwmgr,
>  }
>
>
> -static int smu7_patch_vddc(struct pp_hwmgr *hwmgr,
> -                             struct phm_clock_voltage_dependency_table *=
tab)
> +static void smu7_patch_vddc(struct pp_hwmgr *hwmgr,
> +                           struct phm_clock_voltage_dependency_table *ta=
b)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2682,12 +2682,10 @@ static int smu7_patch_vddc(struct pp_hwmgr *hwmgr=
,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                 &data->vddc_leakage);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_vddci(struct pp_hwmgr *hwmgr,
> -                              struct phm_clock_voltage_dependency_table =
*tab)
> +static void smu7_patch_vddci(struct pp_hwmgr *hwmgr,
> +                            struct phm_clock_voltage_dependency_table *t=
ab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2696,12 +2694,10 @@ static int smu7_patch_vddci(struct pp_hwmgr *hwmg=
r,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                         &data->vddci_leak=
age);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_vce_vddc(struct pp_hwmgr *hwmgr,
> -                                 struct phm_vce_clock_voltage_dependency=
_table *tab)
> +static void smu7_patch_vce_vddc(struct pp_hwmgr *hwmgr,
> +                               struct phm_vce_clock_voltage_dependency_t=
able *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2710,13 +2706,11 @@ static int smu7_patch_vce_vddc(struct pp_hwmgr *h=
wmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                         &data->vddc_leaka=
ge);
> -
> -       return 0;
>  }
>
>
> -static int smu7_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
> -                                 struct phm_uvd_clock_voltage_dependency=
_table *tab)
> +static void smu7_patch_uvd_vddc(struct pp_hwmgr *hwmgr,
> +                               struct phm_uvd_clock_voltage_dependency_t=
able *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2725,12 +2719,10 @@ static int smu7_patch_uvd_vddc(struct pp_hwmgr *h=
wmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                         &data->vddc_leaka=
ge);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
> -                                        struct phm_phase_shedding_limits=
_table *tab)
> +static void smu7_patch_vddc_shed_limit(struct pp_hwmgr *hwmgr,
> +                                      struct phm_phase_shedding_limits_t=
able *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2739,12 +2731,10 @@ static int smu7_patch_vddc_shed_limit(struct pp_h=
wmgr *hwmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].Voltage,
>                                                         &data->vddc_leaka=
ge);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_samu_vddc(struct pp_hwmgr *hwmgr,
> -                                  struct phm_samu_clock_voltage_dependen=
cy_table *tab)
> +static void smu7_patch_samu_vddc(struct pp_hwmgr *hwmgr,
> +                                struct phm_samu_clock_voltage_dependency=
_table *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2753,12 +2743,10 @@ static int smu7_patch_samu_vddc(struct pp_hwmgr *=
hwmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                                         &data->vddc_leaka=
ge);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_acp_vddc(struct pp_hwmgr *hwmgr,
> -                                 struct phm_acp_clock_voltage_dependency=
_table *tab)
> +static void smu7_patch_acp_vddc(struct pp_hwmgr *hwmgr,
> +                               struct phm_acp_clock_voltage_dependency_t=
able *tab)
>  {
>         uint16_t i;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2767,12 +2755,10 @@ static int smu7_patch_acp_vddc(struct pp_hwmgr *h=
wmgr,
>                 for (i =3D 0; i < tab->count; i++)
>                         smu7_patch_ppt_v0_with_vdd_leakage(hwmgr, &tab->e=
ntries[i].v,
>                                         &data->vddc_leakage);
> -
> -       return 0;
>  }
>
> -static int smu7_patch_limits_vddc(struct pp_hwmgr *hwmgr,
> -                                 struct phm_clock_and_voltage_limits *ta=
b)
> +static void smu7_patch_limits_vddc(struct pp_hwmgr *hwmgr,
> +                                  struct phm_clock_and_voltage_limits *t=
ab)
>  {
>         uint32_t vddc, vddci;
>         struct smu7_hwmgr *data =3D (struct smu7_hwmgr *)(hwmgr->backend)=
;
> @@ -2787,11 +2773,9 @@ static int smu7_patch_limits_vddc(struct pp_hwmgr =
*hwmgr,
>                                                    &data->vddci_leakage);
>                 tab->vddci =3D vddci;
>         }
> -
> -       return 0;
>  }
>
> -static int smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_le=
akage_table *tab)
> +static void smu7_patch_cac_vddc(struct pp_hwmgr *hwmgr, struct phm_cac_l=
eakage_table *tab)
>  {
>         uint32_t i;
>         uint32_t vddc;
> @@ -2804,63 +2788,22 @@ static int smu7_patch_cac_vddc(struct pp_hwmgr *h=
wmgr, struct phm_cac_leakage_ta
>                         tab->entries[i].Vddc =3D (uint16_t)vddc;
>                 }
>         }
> -
> -       return 0;
>  }
>
> -static int smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *hw=
mgr)
> +static void smu7_patch_dependency_tables_with_leakage(struct pp_hwmgr *h=
wmgr)
>  {
> -       int tmp;
> -
> -       tmp =3D smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_o=
n_sclk);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_o=
n_mclk);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency=
_on_mclk);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_o=
n_display_clock);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_vol=
tage_dependency_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_vol=
tage_dependency_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_v=
oltage_dependency_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_vol=
tage_dependency_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_p=
hase_shed_limits_table);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock=
_voltage_on_ac);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock=
_voltage_on_dc);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       tmp =3D smu7_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_t=
able);
> -       if (tmp)
> -               return -EINVAL;
> -
> -       return 0;
> +       smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_sclk);
> +       smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_mclk);
> +       smu7_patch_vddci(hwmgr, hwmgr->dyn_state.vddci_dependency_on_mclk=
);
> +       smu7_patch_vddc(hwmgr, hwmgr->dyn_state.vddc_dependency_on_displa=
y_clock);
> +       smu7_patch_vce_vddc(hwmgr, hwmgr->dyn_state.vce_clock_voltage_dep=
endency_table);
> +       smu7_patch_uvd_vddc(hwmgr, hwmgr->dyn_state.uvd_clock_voltage_dep=
endency_table);
> +       smu7_patch_samu_vddc(hwmgr, hwmgr->dyn_state.samu_clock_voltage_d=
ependency_table);
> +       smu7_patch_acp_vddc(hwmgr, hwmgr->dyn_state.acp_clock_voltage_dep=
endency_table);
> +       smu7_patch_vddc_shed_limit(hwmgr, hwmgr->dyn_state.vddc_phase_she=
d_limits_table);
> +       smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage=
_on_ac);
> +       smu7_patch_limits_vddc(hwmgr, &hwmgr->dyn_state.max_clock_voltage=
_on_dc);
> +       smu7_patch_cac_vddc(hwmgr, hwmgr->dyn_state.cac_leakage_table);
>  }
>
>
> --
> 2.34.1
>
