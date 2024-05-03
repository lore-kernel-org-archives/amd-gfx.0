Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D91C4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 13:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BDB112D56;
	Fri,  3 May 2024 13:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZaC65YLI";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C35112D56
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 13:51:13 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2b33e342c03so2234378a91.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714744273; x=1715349073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BAkT/iQhUfBLVKaeue42YJV/NXrPWrn6EoYraFnqsZk=;
 b=ZaC65YLIEuUSUIB6JXv/Tv0dPlxKIA+/FXZr47l1hZyfThjUkGfVELMjAts5GZs6fv
 WaUsn3+adIj+3d/ztlOqGuds1OB8i/ACTjxeuoQotq/DqloM6vPh8bYe9rffvwiUzFa+
 gAQyX1cmhPA7sVDZSFfhoddejiXkf9UBADDGsAsgAHW0QmU/H62yrY4vhhPZ9ugWz6mU
 XqXayRxiDGcTX/yTeHGyBT+UG7kpsQzYdF7oAnUuCLiuECp7VmxxKErGBdoQo8HhRD71
 eA0a6XbrWC6xXy2e1gd4JWwc9EMSKJFkAuwg/5YmK0MCtXYnH8Nwogyw2TLEcA+zFE2o
 Cuog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714744273; x=1715349073;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BAkT/iQhUfBLVKaeue42YJV/NXrPWrn6EoYraFnqsZk=;
 b=YStnwPl0r7wPTeMaxpw0eX1IRPgXADGSTBIgQAJW1HLTpCsYtuGl7Fm4D2HUArZWSE
 2KfkIk0X9Fw3ckHbMvcC+VVXs8xq9e003evNc8tEmD6m+g1bFfPQ6UvucgD6/QgwXkjq
 A/AByyQJpnEPShPvY452i94jUeEg2kSNMM7Xogxu90VJdRyDUE7nFCE8QcJbMkQQRive
 NiIjBQuTbQ1b2v9iZIiQJjgpkWkvcmEoa96LQy5tymh50RxNDZWcmjmW9aC7CvpTjsKW
 kK5FemStR4VqJq2pEHoslXNpGWU+6SNLjT3gXaV0nzC6VtQRBRpqrpNUWFyGaSX0wT8a
 Z++A==
X-Gm-Message-State: AOJu0YzgZSvSLxwykjfurdsxZP1oechyxQydO7ChlOe5qReTfcoLplIn
 SJ5BgZnWeN/h7f7Zgbh7jGcM6sGnqzsHki29Fbl458xzd+olPlF6g9T0NnoR0Rft7upvd/GYisp
 l7HK0K7K1l9Sxg1bSuMxy66yHFLI=
X-Google-Smtp-Source: AGHT+IF8BBlKMtU8HHLArmJCRcu/ax1427zKx0mz1bU5PUpQ+IeV/wVSLk0vhbbKBwPJ0v46Ps6ohHFa4U3gy9Kwbdk=
X-Received: by 2002:a17:90a:f3c8:b0:2b2:b99f:4d5b with SMTP id
 ha8-20020a17090af3c800b002b2b99f4d5bmr3151518pjb.18.1714744272663; Fri, 03
 May 2024 06:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240502191552.31905-1-mario.limonciello@amd.com>
In-Reply-To: <20240502191552.31905-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 May 2024 09:51:01 -0400
Message-ID: <CADnq5_POtCx+yD0zuhF4Lo3+Rtdfodm9d8OF-Ecx2en4oDF=Ew@mail.gmail.com>
Subject: Re: [PATCH] dm/amd/pm: Fix problems with reboot/shutdown for some SMU
 13.0.4/13.0.11 users
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Tim Huang <Tim.Huang@amd.com>
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

On Thu, May 2, 2024 at 3:22=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Limit the workaround introduced by commit 31729e8c21ec ("drm/amd/pm: fixe=
s
> a random hang in S4 for SMU v13.0.4/11") to only run in the s4 path.
>
> Cc: Tim Huang <Tim.Huang@amd.com>
> Fixes: 31729e8c21ec ("drm/amd/pm: fixes a random hang in S4 for SMU v13.0=
.4/11")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3351
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> I tested this on SMU 13.0.4 for ~85 cycles with this script, BIOS 1.1.0.2=
a and
> didn't observe any hangs.
>
> ```
> #!/bin/sh
> echo test_resume > /sys/power/disk
> i=3D1
> while [ : ]; do
>
>   echo "Starting cycle $i"
>   echo disk > /sys/power/state
>   echo "Ending cycle $i"
>   i=3D$((i+1))
>   sleep 5
> done
> ```
>
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> index 949131bd1ecb..4abfcd32747d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
> @@ -226,7 +226,7 @@ static int smu_v13_0_4_system_features_control(struct=
 smu_context *smu, bool en)
>         struct amdgpu_device *adev =3D smu->adev;
>         int ret =3D 0;
>
> -       if (!en && !adev->in_s0ix) {
> +       if (!en && adev->in_s4) {
>                 /* Adds a GFX reset as workaround just before sending the
>                  * MP1_UNLOAD message to prevent GC/RLC/PMFW from enterin=
g
>                  * an invalid state.
> --
> 2.43.0
>
