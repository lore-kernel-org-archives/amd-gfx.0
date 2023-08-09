Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10179EB64DD
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Aug 2023 12:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C3710E423;
	Wed,  9 Aug 2023 12:20:23 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF8710E423
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Aug 2023 12:20:22 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-56c7f47ec42so4820297eaf.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Aug 2023 05:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691583621; x=1692188421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k11+OSwdJjYLMuvlahKsy7p54ybUxXGfOC2pjlBLcms=;
 b=mb2/iCMFBPmf5EIVU+KTVfXd3i180kdg0SxiwvQPdr2kGXNC2/VvpxyE4MZfhdkm5R
 f01Xnq1nyMLZwlAehvZx0VbxuUdIU3KqoRU5MQGM8kC2/YfYajlmx+2ZXxJbHRziDSXP
 NCAgUE11isON4O1Y41m9hngEqVKwWAYmawZH/hBPCzOOuM38bUjbkgmzt0kk/P0h6vND
 xn9MJNM11PUoJQHwHa6FEwtD9Q1HfICBJU8wUbM3v8Fd8jn+zy7Gc+EotWBn3SyWxU4P
 ftd6BKS+AZ3gMXC5ujvSN8d8ZmoR2AzxH1Ljl3vEnVoPDfv4yKa9ML+55U/rX0R4qmu+
 C5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691583621; x=1692188421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k11+OSwdJjYLMuvlahKsy7p54ybUxXGfOC2pjlBLcms=;
 b=lu/aTVTr1HI22Jz+ALivwaDPzlTtrqo1FeVA5nQjrz4mSqEk+Q2lUrsAMJ9OVftSDz
 8X2mJxlJdfyEf3HHdmJJm4oxjDbeVQC+k/IBHmjk68yBidEZ1oNF32XPDkJ3B9mUI8rM
 4zV5/62lXry4uUY7lyhE/tndYK1/rC/TKkI3fiAWYNg1gFD1NyoUofpiTDlC9YUJuySH
 L5olhs/k3Zf11os39mILyMRvr7JrEEPZjn1pjlXPeoh1CTR6GYA586pgHuUj2UX+K7TK
 XJkK67NwAcR9ms3fW930JjE0VOt9D6APtGoZMd5F29ly3eRrN7t4AUTj2On2ILc6uzFf
 m8fw==
X-Gm-Message-State: AOJu0YzvB7V73aPhp2JbobfeUu9VmCm9WSABl8KwtDJOzFKG5XKa7Zk+
 JUjy+jS/bfFmi71VOvDxoOZJ8jCaXgyXigEoUCRgopp4
X-Google-Smtp-Source: AGHT+IFuFFn4eB2wnExAr+dA3ZjlAGzlWXY+l5HXwXloUqrmA+CkRfk/ENTur013KRc3rW0C+llZMX8ndxsbk0HlCVw=
X-Received: by 2002:a05:6808:3a6:b0:3a7:8e05:1697 with SMTP id
 n6-20020a05680803a600b003a78e051697mr2448774oie.59.1691583621231; Wed, 09 Aug
 2023 05:20:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230809101235.285114-1-kenneth.feng@amd.com>
In-Reply-To: <20230809101235.285114-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 9 Aug 2023 08:20:09 -0400
Message-ID: <CADnq5_Ot96o8RdopafMVOT6jZKgfkuxTOT4CVQJ6k8aBVPNBSw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: disallow the fan setting if there is no
 fan on smu 13.0.0
To: Kenneth Feng <kenneth.feng@amd.com>
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
Cc: lijo.lazar@amd.com, maisam.arif@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Aug 9, 2023 at 6:12=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com> =
wrote:
>
> drm/amd/pm: disallow the fan setting if there is no fan on smu 13.0.0
> V2: depend on pm.no_fan to check
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

You can still read the fan speed though right?  Don't we want to just
not expose the ability to manually set the fan speed?

Alex

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> index fddcd834bcec..0fb6be11a0cc 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
> @@ -331,6 +331,7 @@ static int smu_v13_0_0_check_powerplay_table(struct s=
mu_context *smu)
>         struct smu_13_0_0_powerplay_table *powerplay_table =3D
>                 table_context->power_play_table;
>         struct smu_baco_context *smu_baco =3D &smu->smu_baco;
> +       PPTable_t *pptable =3D smu->smu_table.driver_pptable;
>  #if 0
>         PPTable_t *pptable =3D smu->smu_table.driver_pptable;
>         const OverDriveLimits_t * const overdrive_upperlimits =3D
> @@ -371,6 +372,9 @@ static int smu_v13_0_0_check_powerplay_table(struct s=
mu_context *smu)
>         table_context->thermal_controller_type =3D
>                 powerplay_table->thermal_controller_type;
>
> +       smu->adev->pm.no_fan =3D
> +               !(pptable->SkuTable.FeaturesToRun[0] & (1 << FEATURE_FAN_=
CONTROL_BIT));
> +
>         return 0;
>  }
>
> --
> 2.34.1
>
