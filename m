Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DE9CA1013
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Sep 2025 15:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC7610EA7E;
	Thu,  4 Sep 2025 15:16:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VffD2WVQ";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EDB010EA7E
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Sep 2025 15:15:58 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b520539e95bso21829a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Sep 2025 08:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756998958; x=1757603758; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9Jq0Qss5RqOroarhNVXi84lrn3E/aL/e2HhwPAXgdE=;
 b=VffD2WVQBNQBbNUNNbullSSxJ/PY3m1VJOCf6lUwTOpIIqUpxYQ8gwHOZ8Jo6VnyVp
 b2iGyl52uxeeyKUZkRWPFtIvzRdLnTUVS0NKugJYa0vn+R7885EQZPueCILC4PHQNgK8
 1AlwteiSvaeBLTTSjBb8s6KFNcYMxuEq7HWRnTlx4bYoiFhr2CoVqYZlyoZWgodmfrKy
 2jUYH2+1P9SEjbBY0J83pQl1cyWeUNZT8ynednTV7fraknGttcfCgVwa9C2BNs5JMbkB
 z+tvA+tMT603+y9HILNf7vh75oEQ814Jzg/UNXFeCg4coUBCZa/9lDZWayMWUff5T39/
 xLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756998958; x=1757603758;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A9Jq0Qss5RqOroarhNVXi84lrn3E/aL/e2HhwPAXgdE=;
 b=RQONtcgaWtk7C32BWXfnfB5+AvGDngxIJv1/7yposPjdr7ZcON9FrfzvvoIPBidMEX
 TSuzORJuT2ye1v9jv844/Jk2XKtozWspKt6JYaSE480y+zuqrDKO18ILvK4iapMu6hhU
 UkSjPhwl8sjyuTeuV9Ex424f9o7H8Je7qMNGh0+MYS8kODtFIgjJjq0ULtLdeueDIJj0
 c+FEU2NHHxI2gBZBq31zDCwNT+wfUtcS/8Vd27y6VS0yo81HVOW65FCHrCl36Jioy2S7
 ZF3Fj9IOuZm1lB3c+ZG6yZWpL2nvbvJfPjvRYKT8uvOsE4Bvm00J5lK6n+aKXtDteEFh
 NfBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/jG5BoAqG0M0GH+XLF+NPCJ48xafpeJp+HfvRzon/jRTPdMQaNNmC0NRa+/al2vqF3ICxj59x@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAv9WjgGVGfKCxZwb7yto1ZlRGzLOebEhSUkyBrb1p37H7DOgI
 II23BgdH/zNe6XP+sYWwV7vVIA8EUnNyHO3XiU8aQ9dOz9tJEbFhcXoBDjgQEy8WmfhTPpjjXWY
 FHiSPgVPnfNopI2ADI+axbwjXG4/kApI=
X-Gm-Gg: ASbGncvotGvOm+OisKOFH2/qE/f2MaSdeu1z8K7y8PfDblYXwW9yf7wQQZXdYAvOt4F
 /Efbbw4dyA8VDQgw+Htn8VgaD9C71FEBrfL8gt1xHFPczfiIJC7rxu0pnGsQLcsz7uQQxzip4/p
 AM+kr7CcDjs06fOQz89c2hORMAej/Cuw74sGXIz+Y3eqCMsziQxV1XxtH+nSuIMkwvXQHYGzppZ
 g0d1tQGc9q46LDYew==
X-Google-Smtp-Source: AGHT+IF65tvTv3v42r1JI9j62M5o5qPYw1oDc/yG7KI7ueINNwA7BlbdkkzA9BhPG147OhT975Nb20L/xrlEM5e+oLE=
X-Received: by 2002:a17:902:f54d:b0:24c:e213:ca4a with SMTP id
 d9443c01a7336-24ce213cdacmr9525015ad.2.1756998957514; Thu, 04 Sep 2025
 08:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250904145807.556882-1-rongqianfeng@vivo.com>
In-Reply-To: <20250904145807.556882-1-rongqianfeng@vivo.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Sep 2025 11:15:46 -0400
X-Gm-Features: Ac12FXxv0FUvBauKct_Lpu4EMKY0aLOZVPk2DGipspAwts4gAS5Q2uAmVAt2310
Message-ID: <CADnq5_Mxryr36q_Sj1xPQEmBsnMmxoAo_hksrqewH0=Ae7_pvw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: use int type to store negative error codes
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 "Dr. David Alan Gilbert" <linux@treblig.org>, Lijo Lazar <lijo.lazar@amd.com>, 
 Boyuan Zhang <boyuan.zhang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Thu, Sep 4, 2025 at 10:58=E2=80=AFAM Qianfeng Rong <rongqianfeng@vivo.co=
m> wrote:
>
> Use int instead of uint32_t for 'ret' variable to store negative error
> codes or zero returned by other functions.
>
> Storing the negative error codes in unsigned type, doesn't cause an issue
> at runtime but can be confusing. Additionally, assigning negative error
> codes to unsigned type may trigger a GCC warning when the -Wsign-conversi=
on
> flag is enabled.
>
> No effect on runtime.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c  | 2 +-
>  drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c | 2 +-
>  drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drive=
rs/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> index 9a821563bc8e..14ccd743ca1d 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
> @@ -1032,7 +1032,7 @@ static int smu10_print_clock_levels(struct pp_hwmgr=
 *hwmgr,
>                         data->clock_vol_info.vdd_dep_on_fclk;
>         uint32_t i, now, size =3D 0;
>         uint32_t min_freq, max_freq =3D 0;
> -       uint32_t ret =3D 0;
> +       int ret =3D 0;
>
>         switch (type) {
>         case PP_SCLK:
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c b/driv=
ers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> index baf51cd82a35..0d4cbe4113a0 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu7_smumgr.c
> @@ -401,7 +401,7 @@ int smu7_request_smu_load_fw(struct pp_hwmgr *hwmgr)
>  int smu7_check_fw_load_finish(struct pp_hwmgr *hwmgr, uint32_t fw_type)
>  {
>         struct smu7_smumgr *smu_data =3D (struct smu7_smumgr *)(hwmgr->sm=
u_backend);
> -       uint32_t ret;
> +       int ret;
>
>         ret =3D phm_wait_on_indirect_register(hwmgr, mmSMC_IND_INDEX_11,
>                                         smu_data->soft_regs_start + smum_=
get_offsetof(hwmgr,
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> index e97b0cf19197..3baf20f4c373 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
> @@ -470,7 +470,7 @@ static int renoir_od_edit_dpm_table(struct smu_contex=
t *smu,
>  static int renoir_set_fine_grain_gfx_freq_parameters(struct smu_context =
*smu)
>  {
>         uint32_t min =3D 0, max =3D 0;
> -       uint32_t ret =3D 0;
> +       int ret =3D 0;
>
>         ret =3D smu_cmn_send_smc_msg_with_param(smu,
>                                                                 SMU_MSG_G=
etMinGfxclkFrequency,
> --
> 2.34.1
>
