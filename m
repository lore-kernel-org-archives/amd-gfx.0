Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811EBC27C79
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 12:48:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD1B10E984;
	Thu, 20 Jun 2024 12:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S4TI7yMq";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B3B10E162
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 12:48:42 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-705cffc5bcfso863836b3a.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 05:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718887722; x=1719492522; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxQ9Pr73+o5m6AQLSD1Dhb2XiaaQFN0JbLAqOBEv1gg=;
 b=S4TI7yMqHO8IBb3/+7sYV58K26rOZqfnZgtE4KhLPAdmQUy8VAGzg0RbtNT1n80KFb
 7He0mcEueQL3MIvGYRyjI0ogaAxd2YIu//b3hCTOXg2f/vFhTeNc/ILZus8OMY4Pvetk
 PoMZ01uHgXm0LzKLIGtUdPmeTELr/CjJU/us4QU+LEHB+0vndzLl+inJGpLxwqvKYvnK
 xMmgYEANzODOPUd4Ohzb1guDRV6sd+v4XCXRPVDMN0TOlXGnM7tY1XBcoi4dirouOCW8
 064eMMbTZOzjQ8BBbYa1Lbo3QSMKGTXKtVuaeETudtiviVTNgyquThiYizAjLfSSLAUW
 Uihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718887722; x=1719492522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YxQ9Pr73+o5m6AQLSD1Dhb2XiaaQFN0JbLAqOBEv1gg=;
 b=g732nd2sStE+oZDlCnxh9u+CRlrVO2SSNQjPDomfKXAXwZHShkT/XV0D5jXOHXamjZ
 qBSEYKEanDB3mdvZvn+4YC75nZKI+8vmhm5HVLrS2wcxLGJqyIJ9u8/4Oq2CP0JO8lFP
 sALjnUqsdSrPVIGQoGRr+tK873jfoZM0dW8yNvKg7hAr+yHHmrb5OVx313btr1t2Rgc4
 dHt2RVAup46kCNvXGvyiR0Ip+I+nwp1Q04JnFYr7xyr34oFFco+LnJfHw3toOuXGuUzu
 sBGqYbuHhHIyUCp5SqxMrTmxEXsVW7SYNjw+jJMyQ4552jSWUFAfbQuhR9pdzq09/Yac
 W39w==
X-Gm-Message-State: AOJu0YwgQ9kMERdMqRYKYIkaXcfwS0hqv6QHh6/MuU6hXguMYfBjZogf
 q1/czBkzBBJxo2jmwdFO3zT8pKRfJ6/IOALWK8MECIm4/sPX2wgcgn6gqmbMYQTgGkAk6ML+ELO
 Lx9gTTKbdxadKdEQ/mttvsmwQAPx0Jw==
X-Google-Smtp-Source: AGHT+IEZ+7ZVA1jeik9+TyVMiyLGV6LaCbaPHic9vUg/va2+cT5HzUyeGoXVFNgrAi95WpuyKkSjny2RVvpLCHB1uwg=
X-Received: by 2002:a05:6a20:3b02:b0:1b8:54f8:3857 with SMTP id
 adf61e73a8af0-1bcbb56a498mr5731418637.30.1718887721526; Thu, 20 Jun 2024
 05:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240620012434.1742537-1-kenneth.feng@amd.com>
 <20240620012434.1742537-2-kenneth.feng@amd.com>
In-Reply-To: <20240620012434.1742537-2-kenneth.feng@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Jun 2024 08:48:30 -0400
Message-ID: <CADnq5_O94x_o9ewgecR+a5bO7X-id8VC2rtYQce1XpBnFYEmrg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm/amd/amdgpu: add module parameter for jpeg"
To: Kenneth Feng <kenneth.feng@amd.com>
Cc: amd-gfx@lists.freedesktop.org, sonny.jiang@amd.com
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

On Wed, Jun 19, 2024 at 9:32=E2=80=AFPM Kenneth Feng <kenneth.feng@amd.com>=
 wrote:
>
> This reverts commit 63400bcf5cb23b6a9b674eb3f2d733d826860065.
> Revert this due to a final solution in amdgu vcn:
> commit eef47ed5f703377781ce89eae4b9140325049873
> Author: Sonny Jiang <sonjiang@amd.com>
> Date:   Tue Jun 18 11:11:11 2024 -0400
>
> drm/amdgpu/jpeg5: reprogram doorbell setting after power up for each play=
back
>
> Doorbell needs to be configured after power up during each playback
>
> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 --
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 4 ----
>  3 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 6129f9f7a577..137a88b8de45 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -224,7 +224,6 @@ extern int amdgpu_mes;
>  extern int amdgpu_mes_log_enable;
>  extern int amdgpu_mes_kiq;
>  extern int amdgpu_uni_mes;
> -extern int amdgpu_jpeg_test;
>  extern int amdgpu_noretry;
>  extern int amdgpu_force_asic_type;
>  extern int amdgpu_smartshift_bias;
> @@ -1022,7 +1021,6 @@ struct amdgpu_device {
>
>         /* jpeg */
>         struct amdgpu_jpeg              jpeg;
> -       bool enable_jpeg_test;
>
>         /* vpe */
>         struct amdgpu_vpe               vpe;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index 4edcbd272fa4..df753ebfd109 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2302,8 +2302,6 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct=
 amdgpu_device *adev)
>                 case IP_VERSION(5, 0, 0):
>                         amdgpu_device_ip_block_add(adev, &vcn_v5_0_0_ip_b=
lock);
>                         amdgpu_device_ip_block_add(adev, &jpeg_v5_0_0_ip_=
block);
> -                       if (amdgpu_jpeg_test)
> -                               adev->enable_jpeg_test =3D true;
>                         break;
>                 default:
>                         dev_err(adev->dev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 60d5758939ae..802debd8d9f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -205,7 +205,6 @@ int amdgpu_force_asic_type =3D -1;
>  int amdgpu_tmz =3D -1; /* auto */
>  uint amdgpu_freesync_vid_mode;
>  int amdgpu_reset_method =3D -1; /* auto */
> -int amdgpu_jpeg_test;
>  int amdgpu_num_kcq =3D -1;
>  int amdgpu_smartshift_bias;
>  int amdgpu_use_xgmi_p2p =3D 1;
> @@ -941,9 +940,6 @@ module_param_named(freesync_video, amdgpu_freesync_vi=
d_mode, uint, 0444);
>  MODULE_PARM_DESC(reset_method, "GPU reset method (-1 =3D auto (default),=
 0 =3D legacy, 1 =3D mode0, 2 =3D mode1, 3 =3D mode2, 4 =3D baco/bamaco)");
>  module_param_named(reset_method, amdgpu_reset_method, int, 0644);
>
> -MODULE_PARM_DESC(jpeg_test, "jpeg test(0 =3D disable (default), 1 =3D en=
able)");
> -module_param_named(jpeg_test, amdgpu_jpeg_test, int, 0444);
> -
>  /**
>   * DOC: bad_page_threshold (int) Bad page threshold is specifies the
>   * threshold value of faulty pages detected by RAS ECC, which may
> --
> 2.34.1
>
