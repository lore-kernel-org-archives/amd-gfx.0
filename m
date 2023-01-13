Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C0C54EBD
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jan 2023 14:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E66D10EA07;
	Fri, 13 Jan 2023 14:45:39 +0000 (UTC)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B74510E191
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 14:45:38 +0000 (UTC)
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-15eeec85280so1359859fac.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jan 2023 06:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pOEdK6Jk16UoY1TNrYVh/E2UAtLn7eRFKluM4jz1XHM=;
 b=KZTydsAzAFHW/pSTz2+IB18i4jGrlcu6Srk6bDYMUloCTIBBCSfwPTSwR6vFq+SaZJ
 OFb1bf8tcqQ+C5o57nshbrHOaWAUogmvSrJFAWPn8fdLgMoQmgC2rR30VAqFegg0Jb/S
 TDmdN/xu0kyKWzHyFpwpiB4bFlXhvBo+taDWDrN3/c/JeoSUnTJJtV80JIBw6npBaTSr
 QqFPeV6hBfNSmm2qQ0pHrB/spNHnp/Ne2v0ZVOAnNLgCJN3O83ptAORIvxnvFpHKQEcF
 cylz3eSSzK7DhwwQ+3/8Xo5JaaaJRvEUU8FD9LQETjMp7xnkzWJLysdKADQ6zY2IZBSg
 M1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pOEdK6Jk16UoY1TNrYVh/E2UAtLn7eRFKluM4jz1XHM=;
 b=l3ugDUNKjhhscRyO16AYKQqaQBvmufdJ8Uwr7E5h6bcBTwm7IujMEF4iI1yRdlOvlA
 SyVtNdGMwsE+l17+JVxWYcR4vZyhiDisfQsyUERvcSv/5EFGpRi9FqgaevYAKD/A4wmX
 bOueyJN70fML7bIh3lSX4UFuaAE6qEhZxk3edK/9XSesHn3jOWoxG0P/SEaCbW+h84Ec
 UezmAJKZG4zZgBCZVrhfmrcItsM2dK7sW5Eb+5a6kji6aDhiNP7i5f3Q1jD4VNcotRv7
 g1XdsbPo+diKVrM3vYKtY9EpLmUkRAOiLU46565LgxA8tURvnh/yKIJKMHwZrZYu01BE
 /+qQ==
X-Gm-Message-State: AFqh2koqrv5ll4WrqM1G1/VBQ6IIr6T1KLTuTnsTr1I/2Umc8GIiXBcP
 a+bPzoiQZtDUWOgspHaIHDGYshL0puY7bGp4C5NdFlCj
X-Google-Smtp-Source: AMrXdXu4OVuhKqtHy88iJzZrvBdYmyVL9kRg2sc3Cwl6OEY8+t0icQyBiZJOYQn3vxSJVc+8hTLFju2rPV4he/jCZio=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr3218967oab.96.1673621137594; Fri, 13
 Jan 2023 06:45:37 -0800 (PST)
MIME-Version: 1.0
References: <DM4PR12MB515254D7E44C0DA90F3A907FE3C29@DM4PR12MB5152.namprd12.prod.outlook.com>
 <BL1PR12MB52373015FC820A8B41AB45C9F0C29@BL1PR12MB5237.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB52373015FC820A8B41AB45C9F0C29@BL1PR12MB5237.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jan 2023 09:45:26 -0500
Message-ID: <CADnq5_NAd1OcL0GNaVX=XptCoAv-pbiJGmQm=6yadtL6UNhAfQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Renoir/Cezanne GPU power reporting issue
To: "Liu, Aaron" <Aaron.Liu@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Jesse\(Jie\)" <Jesse.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jan 12, 2023 at 9:11 PM Liu, Aaron <Aaron.Liu@amd.com> wrote:
>
> Reviewed-by: Aaron Liu aaron.liu@amd.com
>
>
>
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang, Jesse(Jie)
> Sent: Friday, January 13, 2023 10:07 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: Renoir/Cezanne GPU power reporting issue
>
>
>
> [AMD Official Use Only - General]
>
>
>
>
>
>     drm/amdgpu: Correct the power calcultion for Renior/Cezanne.
>
>     From smu firmware,the value of power is transferred  in units of watts.
>
>     Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2321
>
>     Fixes: 137aac26a2ed ("drm/amdgpu/smu12: fix power reporting on renoir")
>
>
>
>     Acked-by: Alex Deucher alexander.deucher@amd.com
>
>     Signed-off-by: Jesse Zhang Jesse.Zhang@amd.com
>
>
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>
> index 85e22210963f..96a49a3b3ad9 100644
>
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
>
> @@ -1171,6 +1171,7 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>
>         int ret = 0;
>
>         uint32_t apu_percent = 0;
>
>         uint32_t dgpu_percent = 0;
>
> +       struct amdgpu_device *adev = smu->adev;
>
>
>
>
>
>         ret = smu_cmn_get_metrics_table(smu,
>
> @@ -1196,7 +1197,11 @@ static int renoir_get_smu_metrics_data(struct smu_context *smu,
>
>                 *value = metrics->AverageUvdActivity / 100;
>
>                 break;
>
>         case METRICS_AVERAGE_SOCKETPOWER:
>
> -               *value = (metrics->CurrentSocketPower << 8) / 1000;
>
> +               if (((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 1)) && (adev->pm.fw_version >= 0x40000f))
>
> +                       || ((adev->ip_versions[MP1_HWIP][0] == IP_VERSION(12, 0, 0)) && (adev->pm.fw_version >= 0x373200)))
>
> +                       *value = metrics->CurrentSocketPower << 8;
>
> +               else
>
> +                       *value = (metrics->CurrentSocketPower << 8) / 1000;
>
>                 break;
>
>         case METRICS_TEMPERATURE_EDGE:
>
>                 *value = (metrics->GfxTemperature / 100) *
