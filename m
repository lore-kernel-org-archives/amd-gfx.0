Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DD07EA7940
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 19:19:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDFE10E371;
	Wed,  4 Feb 2026 19:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NC9GzfI8";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E600410E371
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 19:19:46 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-124abf957dcso13740c88.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 11:19:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232786; cv=none;
 d=google.com; s=arc-20240605;
 b=VFTl4tugrbXO93smzpCHs1MXuK0X638fHONfoTfyjoCXBVg2Z9yM7yXkNXMNAamqZP
 3cgHDhZzSDDVfNMWfiIXVSxoTtRRuPM8T8sInp/AsAWU/V3xJ/hZmhoSX3LFdInlkGKd
 b/3Ji4ZZoC4wp0YVq1kujC4NgL+gKQdID1ICd7pxEJ0vc1BncShg9gFjdYuECO0MuIQv
 n3iOpUwpDRdNstPunx/7hWOoCdovYn4vzjaiFJvybfiohqTiANwC5aJ90YydEPbgM2pu
 madhsKSGA6lfV1I/OReJ4b/T3ZIT0U898Squoue5NYQN6WvJZ/wsEEjkFZvXhfP20dYc
 TWpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=P1ZsIttKAJ6ifdYTAImzmSYdfvrP7bxC5yqcqnJCmMY=;
 fh=399vfL8Ey9jXNd1D6iTbBl+YA82IGBSmPnK1BVJ0tdQ=;
 b=NzVTHeoKG/kgj36UY0Gd+rkbujuVy6TDB8Oar46GGT2jBhLR89HsMMuNA7oxYjnpfr
 izNJRNW5+SA6hU8zfgkGYoPUYrXV7QZQs6tQA9HfbQ0IZL5Poy/C6wHGGfHXtEcbcxCV
 6up2QjNptUe8aesdnkOT94vo3QJO+2IN2yT2kXAm9MYfQzf7hQ6lkQqQ5nwmCkGz2oOe
 WW9YQzHHZMEby/1/au5UqedSuR/wR1hTHI9kYhDFsMchpeR6y/vs7pT5kmkl+nLhI2Pn
 PDDsMnHVgaAPRxkV9AGumBF3IGD3SHSZZxGGIbCfUrY+SlETzHr4yehLvzFQXwW7DQ7u
 Y9Qg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770232786; x=1770837586; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1ZsIttKAJ6ifdYTAImzmSYdfvrP7bxC5yqcqnJCmMY=;
 b=NC9GzfI8t2oaXXMa/PwAtBhfGaKXBo7bB8mlYNT7tp98/pjvSc+h/eH36sKd+baP0t
 pnOeoilG/aTRWoiOmeaIks5GjeLekd5Y7wJRuRb6VP9HnN0ZOI+E1Brq8vzJ4RuOGBsb
 b7SrayIYkRkyoTN2yq+rU8RBw3z1/BxFXiBcoVLrkQKCewkMSDExlOMDlofaP0M0frPS
 BpGiw1RZBz4pEISgWYqQDuCbCLJP3xvU8KSvEekk6OT7yDLFAUlIS0XQIZU+QdIUsX3c
 1KkYhlF3u+ZPZJM8a7VgLR1D72KTr8zg2Kyl68OiFQp0PcH911nQCSwXQ6B3KO0s1r4V
 lcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232786; x=1770837586;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P1ZsIttKAJ6ifdYTAImzmSYdfvrP7bxC5yqcqnJCmMY=;
 b=ZEI10aZK2ReB1/9CHcEephwXZ43W65p01qE4JfLcY7xSYSMOd8M2JqhW5XuCUBm2Jl
 DD7P+hdk+qLEa/nKiWyOAnT6UN+ruvVRlE35iuhc07UvnrWQE6bgwmoN4iZg7lYur/CA
 xCQOmvC7TYhwXYcqNBCh/P3oZ/cdl938inh6egwn8YEt51G7M/FTTeYou2Clav/vgLmm
 qL/8bU03qRtH+lFM1flQpgpU0ortIms4aUZ3sd02tjDttwuV8DG1XAbPNInkwLZcWjEq
 yisqsz0avBhkVOkImQ5YSad0fZasGAuvE9yxkExc7xAseW92GVPQ50nYqkTntit6qFJ1
 2aIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT7Yy9dFsTpTUbkoYcz55anppN0a3HL0xGXBC5mHqH7RqAy7iniK/G64Yvr0R401aBzDzlVy/7@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywk3VhhD6XQ7qdSd9ynKHkBJSM20ktg+Plk8hp6Zo3VkfNfCmtp
 Tvc3TGZ2kGKdQ/yHujooKghftuobv04tDT+k/ghSRB1Wu50cBwzWuGfaA2Ppwj/EUC3ohRESo4n
 1v5XlP2cX1Fi5PzPJ3I3wkcpHfVRIyrDQkbt3
X-Gm-Gg: AZuq6aIY4nKHYNV2eNx7nk5eKP29d/cAIRQm4PmfqbZW/xVdBa8S2AC0k/sxDcx2uKw
 /0WGNCmGEumzz3B/flMhofmSz+75AT7bZQURhaL8Fn3tEqhbKaNkO93VrNvfl1PIZK0T17GSVV0
 mn0aAI/ZDEAlnVPsrIy8ya3iZNdFUkY8QFhHDYQbTO9hhbxZrVToWC/V8SRFfiUv3BHe5nHEyJR
 7EixmGDzYxtCVuVtxvvThYAJkLwXAQmHioDG4XOVCxi7FZSHJnw38AiRTTF305TWch4okreEYMq
 qjhTeXA=
X-Received: by 2002:a05:7022:606:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-126f4781de8mr1014063c88.2.1770232786086; Wed, 04 Feb 2026
 11:19:46 -0800 (PST)
MIME-Version: 1.0
References: <20260204044338.96093-1-Pratik.Vishwakarma@amd.com>
 <20260204044338.96093-2-Pratik.Vishwakarma@amd.com>
In-Reply-To: <20260204044338.96093-2-Pratik.Vishwakarma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 14:19:34 -0500
X-Gm-Features: AZwV_Qgn9S33bkZEughClP_9fT-klO-E-ohxElCvvS_OGPVS4wfUAyY1wakkwzI
Message-ID: <CADnq5_Oke+hDJAgOAwAF6m4-9VgnU-Pkv-jhcQS0MNCwf-Hw1g@mail.gmail.com>
Subject: Re: [PATCH v2 02/11] drm/amd/swsmu: Add new param regs for SMU15
To: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 3, 2026 at 11:44=E2=80=AFPM Pratik Vishwakarma
<Pratik.Vishwakarma@amd.com> wrote:
>
> Some SMU messages have changed to multi reg read/write
> Initialize during smu_early_init
>
> Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> index c3f22844ba2f..d58b0bc2bf78 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
> @@ -52,6 +52,12 @@
>  #define mmMP1_SMN_C2PMSG_32                    0x0060
>  #define mmMP1_SMN_C2PMSG_32_BASE_IDX               1
>
> +#define mmMP1_SMN_C2PMSG_33                   0x0061
> +#define mmMP1_SMN_C2PMSG_33_BASE_IDX                  1
> +
> +#define mmMP1_SMN_C2PMSG_34                   0x0062
> +#define mmMP1_SMN_C2PMSG_34_BASE_IDX                  1
> +
>  /* MALLPowerController message arguments (Defines for the Cache mode con=
trol) */
>  #define SMU_MALL_PMFW_CONTROL 0
>  #define SMU_MALL_DRIVER_CONTROL 1
> @@ -1347,7 +1353,9 @@ static void smu_v15_0_0_init_msg_ctl(struct smu_con=
text *smu)
>         ctl->config.msg_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG=
_30);
>         ctl->config.resp_reg =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMS=
G_31);
>         ctl->config.arg_regs[0] =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2=
PMSG_32);
> -       ctl->config.num_arg_regs =3D 1;
> +       ctl->config.arg_regs[1] =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2=
PMSG_33);
> +       ctl->config.arg_regs[2] =3D SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2=
PMSG_34);
> +       ctl->config.num_arg_regs =3D 3;
>         ctl->ops =3D &smu_msg_v1_ops;
>         ctl->default_timeout =3D adev->usec_timeout * 20;
>         ctl->message_map =3D smu_v15_0_0_message_map;
> --
> 2.43.0
>
