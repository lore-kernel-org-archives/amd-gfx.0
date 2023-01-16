Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC45C54EBE
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jan 2023 13:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30B9610E032;
	Mon, 16 Jan 2023 13:51:32 +0000 (UTC)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B7110E03D
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 13:51:29 +0000 (UTC)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-15ed38a9b04so10257005fac.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jan 2023 05:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6AN1hciLHtE8NjF6MqwI5BHLs0Uwr6NEg43L1FYTYPU=;
 b=oBnwn5Gt3TWlDabJB7XBEUJRtpOqd5p/Kbr/WqiUxgf1paw1GiRc+SwyO54C6Ynsyt
 QSTirgCQw+elPq7biWxAq4AoCzeGhxd9cu83FZSd4W0/CKct76+VlcFxIDukdqyl7iXg
 QGk4skVEu9lpgBgDxPcA5ps52iP7w3BBRHe0NtyU5xnOIUe1yCwOpshoDXiTZjNKnwKE
 VtxQw1DGMoU9rVAfNRB8EWATF4fGrQ8veOB2FaU+sHpV//GeJ5J3NRs+1NPVOZjsHFcV
 eQWXRQJatrE4qOZ+sVM6BzJn5omEd0zOpyHT3KcVKY2wFHCwervLNPrfM1RDXVa8OvpW
 B/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6AN1hciLHtE8NjF6MqwI5BHLs0Uwr6NEg43L1FYTYPU=;
 b=EaRN8XPI9oWb99cpk5gjdwTImr2o0P57om6PWVB5weg9Ih4aXj/AGorN2ZCyamIn3D
 423qh66RFQUi89ouhXgzgw8pqLFTCzE0nP29heykW8QZLfDc44mlCtprd8orYmDeYWl2
 Jiwf0KGjQq0AqF13Jutv3MIPUeaFBVARAd1NrR9ncFzlzdauYnQZy/iMhWKc6Zv81HpD
 YOb18pSu3tX4c9Oqic+TT/ZmsZqOhPgtINPD8BQz7w8nLRb7GFvxKMVRqssEwGeQ45zF
 on3XWkQ+FsMZS9BFW1G2+E3fHXZorPp9GMNIwqvIGBuxsEFvqcdxb/WGWcRpugaZFfKD
 g8BA==
X-Gm-Message-State: AFqh2ko0fdEhRh6RRtWWGqdaDY5+iJNIEiGdFIO/zt4pr9V1deiBRsEu
 zZhoxggPMSFPYAZisC+twuPvwo69wQF/SJPFpkk=
X-Google-Smtp-Source: AMrXdXv0IZV4g2aM2FK6lOG6p9uHkKY2MfxuLI596Fw41ZhSYxGwcsqZnQ24fQN0g58nhQQT7k0aHQzjso5cpZGID0s=
X-Received: by 2002:a05:6870:c59c:b0:150:d9aa:4011 with SMTP id
 ba28-20020a056870c59c00b00150d9aa4011mr3885295oab.96.1673877088792; Mon, 16
 Jan 2023 05:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20230115192144.4566-1-mario.limonciello@amd.com>
In-Reply-To: <20230115192144.4566-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Jan 2023 08:51:17 -0500
Message-ID: <CADnq5_OW7rmBqGbW=X+LHGkhW6Dr5tC628JPboAg7cP+uHct1Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amd: Adjust legacy IP discovery for
 Picasso/Raven/Raven2
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sun, Jan 15, 2023 at 2:22 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The switch/case statement currently combines 10.0.0 and 10.0.1, but
> 10.0.1 is only used for Raven 2.  So split the two cases up to
> make this clearer.

Keep the logic as is.  We don't know the revision id which is used to
differentiate the raven variants until after IP discovery so we can't
assign the proper IP versions for each raven variant and raven asics
don't have an IP discovery table (it's hardcoded in
amdgpu_discovery.c).

Alex

>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> index c03824d0311bd..0d950ae14b27c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
> @@ -1074,15 +1074,11 @@ static const char *amdgpu_ucode_legacy_naming(struct amdgpu_device *adev, int bl
>                         }
>                         break;
>                 case IP_VERSION(10, 0, 0):
> +                       if (adev->apu_flags & AMD_APU_IS_PICASSO)
> +                               return "picasso";
> +                       return "raven";
>                 case IP_VERSION(10, 0, 1):
> -                       if (adev->asic_type == CHIP_RAVEN) {
> -                               if (adev->apu_flags & AMD_APU_IS_RAVEN2)
> -                                       return "raven2";
> -                               else if (adev->apu_flags & AMD_APU_IS_PICASSO)
> -                                       return "picasso";
> -                               return "raven";
> -                       }
> -                       break;
> +                       return "raven2";
>                 case IP_VERSION(11, 0, 0):
>                         return "navi10";
>                 case IP_VERSION(11, 0, 2):
> --
> 2.25.1
>
