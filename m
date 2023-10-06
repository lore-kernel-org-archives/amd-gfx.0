Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EFE4E81E01
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 14:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AEB910E500;
	Fri,  6 Oct 2023 14:34:34 +0000 (UTC)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 31E5510E503
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 14:34:33 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-57b9193b1aeso1657036eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Oct 2023 07:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696602872; x=1697207672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuTojRJ7Oy7g2Eyr3Ist/jvyX+wFK05YQ/2OPIF5J0A=;
 b=AzvixE694OszBWGxYVwqWularXkySmbbHiDlvBC+ocBMj30WHKMXoK3wWN2MY6PVqS
 HzDEmrX8ChP95zqyaHzVFErmv7qMDcyEik/WJT2WoprccKsy1YkeHNQaIAnSCIN857uN
 oV7m4ZDiGynQjURrY854j/xkQw0ay8NCST8vOq3VtPnulrys5H8AKgPpm4+vQJh6KP+1
 AwcozIWt6O77PD2XAFD/FVSOV/Y9vHc4j6wmQXQ2cGcqOtsFbcavcwHUHexZGE7mIuk+
 KZ8XyQtcFzhy3d/4CIXZ7Dk5lkqIyMOhmyY8hVx7F9GYgfEyoKBr/aI944AXn3u7pQGI
 /7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696602872; x=1697207672;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uuTojRJ7Oy7g2Eyr3Ist/jvyX+wFK05YQ/2OPIF5J0A=;
 b=R+/E2Keqo+0QzpQ9C14zKvjrj/I1yeQxMi+wALBOZ/aTt6pg94YrQZXqNNTVP8bDKF
 g5XLdwH2gsIu18KN+uwe9B0WGDdRsxrBaHB/rCknHO8vNoSHG26BAKWrp+hxJcFJQpTr
 Ij1AFZuMo6FIxY3e4NbYmJuXs4XOyOmmuYByuDq9KjPUJfbZuHN9H2n9ySVbt8HgcKb7
 5+6PuYFc9O3AtUVzrsgYVhi2B1tco55+iGzKTYRboodxx5lentGr+U58i5fOSGtJDq54
 G99oCIClE4MAFqDM2M0rLXwsNwSMOfse4owPQzJFdsJDraxcirL1XcPHCXlwYCV3MCux
 YZrA==
X-Gm-Message-State: AOJu0YyBlkBOSpp+t9avQRnjkHaJBRc3w13RIKyhaFvJF6nfQLWHAmmb
 KzIui1xCoBNlnjuJT27RnQidJ8Pps0gqHeQ/FWI=
X-Google-Smtp-Source: AGHT+IHix1MeyWEtQolkGgumm6N1kEMw4X9VwOzHx5nyfZowzXloLBIxasJyphIPwhCUQJv1uInjxz27v68vcmVC5xQ=
X-Received: by 2002:a05:6870:f815:b0:1d6:5664:8365 with SMTP id
 fr21-20020a056870f81500b001d656648365mr2973198oab.6.1696602872334; Fri, 06
 Oct 2023 07:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231006052149.1566154-1-lijo.lazar@amd.com>
 <PH7PR12MB599741EB6BA789C3D349682182C9A@PH7PR12MB5997.namprd12.prod.outlook.com>
 <BYAPR12MB4614CB22B5E7598DBC5F401797C9A@BYAPR12MB4614.namprd12.prod.outlook.com>
In-Reply-To: <BYAPR12MB4614CB22B5E7598DBC5F401797C9A@BYAPR12MB4614.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 6 Oct 2023 10:34:21 -0400
Message-ID: <CADnq5_MSwvAUQwPC8NyCqL+M1nhncxv0C=o=zY6EZKWM2uLKzA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "StDenis,
 Tom" <Tom.StDenis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Wang,
 Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 6, 2023 at 9:32=E2=80=AFAM Lazar, Lijo <Lijo.Lazar@amd.com> wro=
te:
>
> [AMD Official Use Only - General]
>
> Presently only a byte stream is intended. If version is needed, uint16_t =
pad can be converted to format/content revision.
>
> @Deucher, Alexander/@StDenis, Tom, any comments on keeping a version?

What version are you referring to in this case?  You already have the
pmfw version and the pmlog version.

Alex

>
> Thanks,
> Lijo
>
> -----Original Message-----
> From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> Sent: Friday, October 6, 2023 5:08 PM
> To: Lazar, Lijo <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>
> Subject: RE: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
>
> [AMD Official Use Only - General]
>
> Hi Lijo,
>
> I prefer to add a version field in header, which is used for compatible i=
n the future, what is your idea?
> When the user attempts to parse this node, they cannot accurately determi=
ne the format of the content.
>
> Best Regards,
> Kevin
>
> -----Original Message-----
> From: Lazar, Lijo <Lijo.Lazar@amd.com>
> Sent: Friday, October 6, 2023 1:22 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander=
.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Ale=
xander <Alexander.Deucher@amd.com>
> Subject: [PATCH v2 1/4] drm/amdgpu: add pmlog structure definition
>
> From: Alex Deucher <alexander.deucher@amd.com>
>
> Define the pmlog structures to be exposed via sysfs.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu=
/drm/amd/include/kgd_pp_interface.h
> index e0bb6d39f0c3..9905228fd89c 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -980,4 +980,19 @@ struct gpu_metrics_v2_4 {
>         uint16_t                        average_soc_current;
>         uint16_t                        average_gfx_current;
>  };
> +
> +struct amdgpu_pmlog_header {
> +       uint16_t structure_size;
> +       uint16_t pad;
> +       uint32_t mp1_ip_discovery_version;
> +       uint32_t pmfw_version;
> +       uint32_t pmlog_version;
> +};
> +
> +struct amdgpu_pmlog {
> +       struct amdgpu_pmlog_header common_header;
> +
> +       uint8_t data[];
> +};
> +
>  #endif
> --
> 2.25.1
>
>
