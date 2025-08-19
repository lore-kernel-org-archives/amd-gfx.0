Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0162CA0EEB
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Aug 2025 13:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7001210E5F0;
	Tue, 19 Aug 2025 13:17:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A+Eq/JcV";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1125C10E5F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 13:17:06 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-24498e93b8fso2681245ad.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Aug 2025 06:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755609425; x=1756214225; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpWvlWapLEQh9xT7EisLgC/BexiUkkitroZ2vGUFE3g=;
 b=A+Eq/JcVmOif6tc5bDcFgzdX2lR1DxokqCkgwHZQqmDITaJtMDVz+aCXhvyvtpzt6o
 b9R6JnDuMFxJaehocG5w+5Ntnkc3xvbtE0EZP+j3Tuvusc6Y5nCxbwkM4htKrhgjO5jP
 bMB9aEOJ+PEnsp1Nq5ITiR8RadkaAO/6RU3IG6KjFnqZBpG3zSNJ1KchtXMJ68bb8NVC
 qo4VYKU/4HSXp2LIsmwPP2gtDmLag0WqcwfOXMKgLf4Ie54OIucmx750ijOioxoDZRGK
 1aqCcDM4cxLWfngeY0NmawUKGBVvazEhiVo5WvHqV/eAsLbzt5SPNuU3IppBw09pbtuj
 ZvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755609425; x=1756214225;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpWvlWapLEQh9xT7EisLgC/BexiUkkitroZ2vGUFE3g=;
 b=vGEwaB2261GExisfDdDq5/ko+R03ppLg+46hJoUn9xHaE6S54qVC8xBJSCe9N4Er8p
 7Xdruwes+RmDPGL8lPx8L98NZAlFI4wPYqA2an3oZ+dK68aZy8SSTQjGsmxQGwvGEK/4
 5lVVAUQT4B4hpmdUVO12008UVOqLXO49Jyi3UAIoWEHWtBITNpDQ7L70NGbwkYgUZGbU
 L3tmM89lk0A7H1T3sHDYsUT88Nqa6c37lM8Y5CpcQEVDdG6d2fYXAk4hWjDjknxPiFiA
 HqjNKzyMGk8vX9I+X+/Ma2keXZ/O7QHu7mYXwt9sRiXAowJZw+Ydw0HjAhOlsB0ylyNX
 knNw==
X-Gm-Message-State: AOJu0YydpTmp0m+XbE1FAtvOSN3Q8uKEAFjeNI7441lPYzjHUhrqTcG4
 alztLzYWGyoDcQHE0MiWTAiW6ZigI7rT8fkCJYyJ7EcqxwJxMQ76bkd6naMFw+9EiydMPkjfzGm
 M/gdDcCBNpu+euv4IdBs9xgsim3NFgW91IQ==
X-Gm-Gg: ASbGnctzh50ur6mwHcQfjGdoNzj7m/NyzxZI6sd7+rm5aZPj+F5q+X1tyz4SDkT4s3V
 WZu2kglS0OOkCCIckwSwpdU8W2OK/wAKarttpaXn2jBGHSO6wfQWwM4yppou+7QDV8Vejywk06Q
 07Ke+blIP/7SOSnivNYmv2fvbEXdsTJLNx4fE3/Tvr+HhfgHWwUQpjCsaNikcfA+t1sEE4qUkJJ
 8LRQmHrbMo3nzITTA==
X-Google-Smtp-Source: AGHT+IF7lh2ZJiruN36k2IQYhGJ2yx8MjRIrg2vIaNZWcNOZdvs5mm4M+UYhiIB6XTge3Z3mBNQFxuGXgRPw8kreICU=
X-Received: by 2002:a17:902:f547:b0:240:1879:c2fd with SMTP id
 d9443c01a7336-245e02ba0ecmr18641245ad.2.1755609425457; Tue, 19 Aug 2025
 06:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250819090056.444457-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250819090056.444457-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Aug 2025 09:16:54 -0400
X-Gm-Features: Ac12FXy0z9l_w7mv9sb2lUdYF5UyYcCPE_ElguMozsu8llEen-h0PURLgoHM7lA
Message-ID: <CADnq5_PdRi9yhi7zqmqMdWn2cRjFcErKy8O17SM4T9Pua068EQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: Add VCN reset message support for SMU v13.0.12
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, lijo.lazar@amd.com,
 leo.liu@amd.com, sonny.jiang@amd.com
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

On Tue, Aug 19, 2025 at 5:08=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This commit adds support for VCN reset functionality in SMU v13.0.12 by:
>
> 1. Adding two new PPSMC messages in smu_v13_0_12_ppsmc.h:
>    - PPSMC_MSG_ResetVCN (0x5E)
>    - PPSMC_MSG_CPPipeReset (0x5F)
>    - Updates PPSMC_Message_Count to 0x60 to account for new messages
>
> 2. Adding message mapping for ResetVCN in smu_v13_0_12_ppt.c:
>    - Maps SMU_MSG_ResetVCN to PPSMC_MSG_ResetVCN
>
> These changes enable proper VCN reset handling through the SMU firmware
> interface for compatible AMD GPUs.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h | 4 +++-
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c         | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.=
h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> index aff2776a8b6f..037529eb70bb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
> @@ -120,7 +120,9 @@
>  #define PPSMC_MSG_GetBadPageSeverity                0x5B
>  #define PPSMC_MSG_GetSystemMetricsTable             0x5C
>  #define PPSMC_MSG_GetSystemMetricsVersion           0x5D
> -#define PPSMC_Message_Count                         0x5E
> +#define PPSMC_MSG_ResetVCN                          0x5E
> +#define PPSMC_MSG_CPPipeReset                       0x5F
> +#define PPSMC_Message_Count                         0x60
>
>  //PPSMC Reset Types for driver msg argument
>  #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> index 32fd0be05cff..a3eb19f702d0 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
> @@ -136,6 +136,7 @@ const struct cmn2asic_msg_mapping smu_v13_0_12_messag=
e_map[SMU_MSG_MAX_COUNT] =3D
>         MSG_MAP(RmaDueToBadPageThreshold,            PPSMC_MSG_RmaDueToBa=
dPageThreshold,        0),
>         MSG_MAP(SetThrottlingPolicy,                 PPSMC_MSG_SetThrottl=
ingPolicy,             0),
>         MSG_MAP(ResetSDMA,                           PPSMC_MSG_ResetSDMA,=
                       0),
> +       MSG_MAP(ResetVCN,                            PPSMC_MSG_ResetVCN, =
                       0),
>         MSG_MAP(GetStaticMetricsTable,               PPSMC_MSG_GetStaticM=
etricsTable,           1),
>         MSG_MAP(GetSystemMetricsTable,               PPSMC_MSG_GetSystemM=
etricsTable,           0),
>  };
> --
> 2.49.0
>
