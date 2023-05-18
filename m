Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EFFC77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 15:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4056810E253;
	Thu, 18 May 2023 15:50:29 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198DD10E1F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 15:50:27 +0000 (UTC)
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5500d15d2f2so1275521eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 08:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684425026; x=1687017026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QBS6Zzxft6iUQ60892yYdCx4obcKvkag5gWzjdptpwk=;
 b=JgVEbS3RtU0ua5IDChObrf+48c9SPyGCi6xv4njoB3KQCxn4VYK7fXn9OY5Nn/vEID
 6UYkQYg0CeG7ADXOhwqQw7lQwsfVZ+ivfmKiUscIH1K7xTTBHTEZmx+GK/0J2CNKUAvC
 IS0KP/nDtRp7+sulp74R+M5tq9WyI1KPaf/cs66HqFJPtN7Inq3Nb/8liTMeAv4HP04v
 ffz25ZQBXSS+QvOuO8pzVD2Ijz/doAJAsjTvl8LM/StEJ7st8zylhwD+9ZeDY/GlGsCm
 0IH4dxZGaSnu21gFf50L3sNmOEHK9HnW7mOj91Uwc9V5II1NnkU2LlosJiYCRYN8k5Ku
 4H7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684425026; x=1687017026;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QBS6Zzxft6iUQ60892yYdCx4obcKvkag5gWzjdptpwk=;
 b=gE8ooHnjehD5ByneO2gvPJInKzqnXdpLbxjmkVP0FsqZc2g33myuYmLV27RIGvdlUu
 LArFmELmZmHVixS97u0uBzNpyzxJjP9iAQ9Xv5BG7fY3y7hFl7eSXKb2VM+g2ZKeDbPI
 81NDbx3icBRS6DU1vdSAKiNVa8L6bwWExXPdWTeByWOR1jJA+6u7FhKTIyHgaqLCoVJT
 vWABPJ7JKLi7UuWp14vEEAdFyLpX4AR3/SiVuqaGilhCjWEXD/lISH09gOeADhov5PdV
 5vw2IrH9kLQ8fnKTq/IDS1umgQoe3nEJMm0n3Hu49oDU+uxRINrYShGmeqIa40QsEP+H
 iztA==
X-Gm-Message-State: AC+VfDzHSpSVxEkmQs/F7gAogh+z9ZvB59Yp0X9/3tJmO2oS8LAsgpiG
 Zun14j4PBuirt4TXuC5gA11wP5UKBme0PyI2B8OzZA3o
X-Google-Smtp-Source: ACHHUZ4vupk7D2aBzccm74kvzLsNA0AV1AliJX0BsWx4sIKbiH9Oikd+S3tuUrdC3SWkr4qiaSL0eCKrzoOlEWlCI18=
X-Received: by 2002:a4a:3442:0:b0:54f:6a7a:c6b with SMTP id
 n2-20020a4a3442000000b0054f6a7a0c6bmr14755968oof.8.1684425025779; Thu, 18 May
 2023 08:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230518150708.92286-1-mario.limonciello@amd.com>
 <20230518150708.92286-3-mario.limonciello@amd.com>
In-Reply-To: <20230518150708.92286-3-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 18 May 2023 11:50:14 -0400
Message-ID: <CADnq5_NCn0TdXpREKOpQ2YgsyFK4TuFmDVS_pebZ6qPkzM_EAA@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd: Update driver-misc.html for Rembrandt-R
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, May 18, 2023 at 11:07=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> AMD has added marketing information publicly for Rembrandt-R, so
> update the APU table with matching versions.
>
> Link: https://www.amd.com/en/product/13086
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  Documentation/gpu/amdgpu/apu-asic-info-table.csv | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/amdgpu/apu-asic-info-table.csv b/Documenta=
tion/gpu/amdgpu/apu-asic-info-table.csv
> index b5c67059e9be..2e76b427ba1e 100644
> --- a/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> +++ b/Documentation/gpu/amdgpu/apu-asic-info-table.csv
> @@ -5,7 +5,7 @@ Ryzen 4000 series, RENOIR, DCN 2.1, 9.3, VCN 2.2, 4.1.2, =
11.0.3
>  Ryzen 3000 series / AMD Ryzen Embedded V1*/R1* with Radeon Vega Gfx, RAV=
EN2, DCN 1.0, 9.2.2, VCN 1.0.1, 4.1.1, 10.0.1
>  SteamDeck, VANGOGH, DCN 3.0.1, 10.3.1, VCN 3.1.0, 5.2.1, 11.5.0
>  Ryzen 5000 series / Ryzen 7x30 series, GREEN SARDINE / Cezanne / Barcelo=
 / Barcelo-R, DCN 2.1, 9.3, VCN 2.2, 4.1.1, 12.0.1
> -Ryzen 6000 series / Ryzen 7x35 series, YELLOW CARP / Rembrandt / Rembran=
dt+, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
> +Ryzen 6000 series / Ryzen 7x35 series / Ryzen 7x36 series, YELLOW CARP /=
 Rembrandt / Rembrandt-R, 3.1.2, 10.3.3, VCN 3.1.1, 5.2.3, 13.0.3
>  Ryzen 7000 series (AM5), Raphael, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13.0.5
>  Ryzen 7x45 series (FL1), / Dragon Range, 3.1.5, 10.3.6, 3.1.2, 5.2.6, 13=
.0.5
>  Ryzen 7x20 series, Mendocino, 3.1.6, 10.3.7, 3.1.1, 5.2.7, 13.0.8
> --
> 2.34.1
>
