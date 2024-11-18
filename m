Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72858D4922E
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 14:52:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C65310E4FE;
	Mon, 18 Nov 2024 14:52:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CIMfnFNL";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFD810E4F8
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 14:52:35 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-20ca17bf0d9so2321395ad.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 06:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731941555; x=1732546355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+GQicecLKVFkA4REsB8PO0yweiugf1pKcEalo34PjyM=;
 b=CIMfnFNLMEU8ahggj5Qd3kOQhIWndZcJSMhpqkM2l22+BkqcyfOIaLZec0V5lLuGcm
 WsR4PANy0c0lhe+SCG/dDCcEVawc6slK2h6K5A/fdPWkJHPvXrq7cALw5/0GiRaj7CzR
 1uC+l3UpuMkg6sSuRjjieJD9qjVcMCBKT1M2HifrgbaRBnUfwTJtU6yvyozxIDvAFFom
 Nk19S1ylS6sQPB0sXsdcxmCwvO95d0C95/KPuhni9zrKf8IKIyAIeY0+KAQKpZlwiwHe
 Esw735ehvoAR2AtRJpJdvF03KUCqB66evRVzrOj7eNa2DwnMRGwn3Rg7wX/gXbPqp8Ni
 p8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731941555; x=1732546355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+GQicecLKVFkA4REsB8PO0yweiugf1pKcEalo34PjyM=;
 b=WwTZ0D5AkEqKz3V2Dbi0dLqS5vPZVjJ3tUy+1FdjtojJ2p+8kC5U8/yOINwj36H2er
 TfvE4bF94bu85CgRQPn2+CmacT7eeYMgz6qmEEEjwzr0A3uBhm0EHzMqdsb7hJrbICDo
 wT6rtJ8xLvY2yuIidR04JxL7VqrqpUf4cNQzEVxEnJkPbk/JYlTAPnBZQhh1T9hx5aTR
 p0M6cLMybGEDCkOxwhg9fYbYXp0eDI9GkZCWf6mpgtfZm8G9HVmhWTYvN2tcszqrWIKy
 zw9VPQtT+97Q19A1P/P4hcq5aeYiiTO3ZWAv2tuQ+5jSwRqsWf0Ps5/IOmy3UkkZbfyq
 0mrA==
X-Gm-Message-State: AOJu0Yx+I4n9cDDJ/EhRdL6rM97uxnH5GO8eln/jwC8hZ7GXji81CCNp
 cVIlQZ7cS3Mw1p1WCj14HyvryuRaZhUHAAihZM6kh/NwxHoYySnUJT8JIRG79ZMOOhBfTyDheS6
 FNVbRhugwrvqFec3Go8FQI2tqXTM=
X-Google-Smtp-Source: AGHT+IGlUrkuIXqjmFtjKiorAP136PdCn8U4hJWzA2KzQHxL7gow9cvZtQW6mA5F/pD20mXzeFVr/ScEPA1yYLc4CnE=
X-Received: by 2002:a17:903:268c:b0:211:ee14:11bf with SMTP id
 d9443c01a7336-211ee141701mr49076505ad.12.1731941554942; Mon, 18 Nov 2024
 06:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20241118080114.428845-1-kenneth.feng@amd.com>
In-Reply-To: <20241118080114.428845-1-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Nov 2024 09:52:23 -0500
Message-ID: <CADnq5_Mixd5HbmOQSb=79GGfj91Ar43NQnxFS5FwMrN=N8aMgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: disable pcie speed switching on Intel
 platform for smu v14.0.2/3
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kevinyang.wang@amd.com
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

On Mon, Nov 18, 2024 at 3:04=E2=80=AFAM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> disable pcie speed switching on Intel platform for smu v14.0.2/3
> based on Intel's requirement.
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drive=
rs/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> index 59b369eff30f..337d3312ef30 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
> @@ -1472,6 +1472,14 @@ static int smu_v14_0_2_update_pcie_parameters(stru=
ct smu_context *smu,
>                 if (pcie_table->pcie_lane[i] > pcie_width_cap)
>                         pcie_table->pcie_lane[i] =3D pcie_width_cap;
>
> +               if (i < pcie_table->num_of_link_levels - 1 &&
> +                       !(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
> +                       if (pcie_table->pcie_gen[i] < pcie_gen_cap)
> +                               pcie_table->pcie_gen[i] =3D pcie_gen_cap;
> +                       if (pcie_table->pcie_lane[i] < pcie_width_cap)
> +                               pcie_table->pcie_lane[i] =3D pcie_width_c=
ap;
> +               }
> +
>                 smu_pcie_arg =3D i << 16;
>                 smu_pcie_arg |=3D pcie_table->pcie_gen[i] << 8;
>                 smu_pcie_arg |=3D pcie_table->pcie_lane[i];
> --
> 2.34.1
>
