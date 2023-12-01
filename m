Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA2B0C4167B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Dec 2023 14:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E09EC10E11A;
	Fri,  1 Dec 2023 14:01:01 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3573E10E11A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Dec 2023 14:00:18 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6d84ddd642fso289213a34.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 01 Dec 2023 06:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701439217; x=1702044017; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4h0GzYhSoUOQbMnxxD9Owb7UN6jQfA/M3JhpWVqQyM=;
 b=KnpCRPRr7DIAXCB/lbLcmMnkZMi4QODnm+ompV/WfBaZLDU8NmP7vMCtn9OMF774f8
 QfFn3t4ZDOFvddg1NThYMkMMfYeWizvYFAoe/QIW5xt69kckSegDZYcHR8BR0FJr9OYV
 ITTxlqg5vzC4p8uFRPr85JDFpqz0OStIn4UDzRA1IN3sYSIDgH9+4Orbhb0i8WCNYei0
 +SNDqA7jCAeI5Qk49tcUY3HfLZ6DjZWP725yuwVDNwTkz8kr6nZaQMYir2vkE2vgOcXi
 lm/y9IHz2pKIgknhp3gmcfIQSOmJxIfH5sicXmSXrdL417I0YI4XBs2+0rvKvHA1Wqnm
 9iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701439217; x=1702044017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x4h0GzYhSoUOQbMnxxD9Owb7UN6jQfA/M3JhpWVqQyM=;
 b=SNx7ZtVv/TxaqmzXQ07qTbe2oG/RJVlG6dhdbDdGVsaLmZlrEndZoNxDKSVYYx5fkW
 ROKULYOVfYd9PnmyLYsXVbkPDJsNVQwm0Oe43R0KHFkqmbwHqFFrux7xJ29va2MwItfD
 2kVd2pEXLdo5UQABg6kMSeqf/y2CoRcsiHO9ZkUuQrmho9WZbodjy+Z7v44purw/64Ea
 JmWZ15OE3qpFiBK9f6LJV8ffRTvd6RNaENq/yBIRbpkpgyfCjZ4sroWVUbDj+uIVHkgT
 gtsE5qWHfyO+9sxoueejhD90tYiKbhE4kRsnaXliEfKzhcQBk6RfmxbgQqXd/TWkh2dq
 VMNw==
X-Gm-Message-State: AOJu0YwFxOjSjiMed0EFkJgDWJkNR7KbHpsqbJtJzJ6bd7m6jSp20Sxe
 31uhKuoYJOAkSWxUtn7QF3ZGKEIdFXxvIL5g18Rd5ZVX
X-Google-Smtp-Source: AGHT+IF83ZslT2JGYy2ccG0II9MD2TFOVXEneNjyiH+yZKgomFUCY1wgovideO0Riw4IYDfrC1xEIZeteP1GYTukQ/Q=
X-Received: by 2002:a05:6870:be89:b0:1f5:ccc2:b21e with SMTP id
 nx9-20020a056870be8900b001f5ccc2b21emr32325156oab.41.1701439217291; Fri, 01
 Dec 2023 06:00:17 -0800 (PST)
MIME-Version: 1.0
References: <20231201073636.1190113-1-lijo.lazar@amd.com>
 <20231201073636.1190113-3-lijo.lazar@amd.com>
In-Reply-To: <20231201073636.1190113-3-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 1 Dec 2023 09:00:05 -0500
Message-ID: <CADnq5_M7WdSgJc2Gd8zZi2Pb-2RxWMryN5diFk7CjCbUTNcmyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Avoid querying DRM MGCG status
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Dec 1, 2023 at 3:32=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> MP0 v13.0.6 SOCs don't support DRM MGCG.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amd=
gpu/soc15.c
> index 9043ebf1e161..15033efec2ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -1430,7 +1430,8 @@ static void soc15_common_get_clockgating_state(void=
 *handle, u64 *flags)
>         if (adev->hdp.funcs && adev->hdp.funcs->get_clock_gating_state)
>                 adev->hdp.funcs->get_clock_gating_state(adev, flags);
>
> -       if (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, 2=
)) {
> +       if ((amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, =
2)) &&
> +           (amdgpu_ip_version(adev, MP0_HWIP, 0) !=3D IP_VERSION(13, 0, =
6))) {
>                 /* AMD_CG_SUPPORT_DRM_MGCG */
>                 data =3D RREG32(SOC15_REG_OFFSET(MP0, 0, mmMP0_MISC_CGTT_=
CTRL0));
>                 if (!(data & 0x01000000))
> --
> 2.25.1
>
