Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BC6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 19:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EED7460FD7
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 19:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EED7460FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A34FE6E44D;
	Mon, 27 Sep 2021 19:40:41 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59F876E44D
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 19:40:40 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 67-20020a9d0449000000b00546e5a8062aso25911041otc.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Sep 2021 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=tX+EEphZPycJ14p76BFV82Dt+LS3Am8HwxGDvfItml0=;
 b=drkxz8oD5pGaAKEg4pK/iN4LiqUI8DwDJn7sSSIyVV858Lz0sY+fNln6vvaBtbe0Vy
 p8Cegi2o8pziaEgntz1qAOq1/4LeSk++GTOBRR0vCehsVj1kCHda+Vuj7obT+V2ODurL
 t/esVapRM/yl3cTAWI8PjsEU2z/LaSGKlr9pzEoIZBhJEayA/7ya24qrwDs6ZEhUisnw
 flMSLmBPwGMsaE2wIfb8KJuMW9uYplEbTyvkim2e/oxHpZ48r57U4cKdvAZ2INlQrzC3
 vHZTWInavD6lo3sj4cGkeE0PX9VFD1zkTDzOdY/lRvxnTK5YeS4Al5tsySJ8ajYWE6ZD
 iFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=tX+EEphZPycJ14p76BFV82Dt+LS3Am8HwxGDvfItml0=;
 b=0JzChvNKwWakFf85uR+NgWSNJXZM2NmBn3l6qveStLB1QhOEagr4RzbAJdbjJCz7V1
 zNbZzuqVx7zcsBFfGr/Q33zVx1vGAImctRrtqQNPoTisax68HZpiRQ4YymMC1+1RgII/
 wzNdYcJrSF11rvBxb4aMtmFj73Cl59q6oXXJnKSuQYzIQfcjMA7YEJuaNGxttgMZ74Y3
 UWAQnwW4OX+FLz5YpnKo4pwxRNMYuezDYzo1nBuUDNBiYz+eCjitYzoTHHwM7s2PJjL/
 N9OY6zMzwktwSdLE+QD+oYs62QLf0FICPbuTMcX/u3HDuNu2HNIUckzgaNvV5eVwfiY1
 BrIg==
X-Gm-Message-State: AOAM53352zW6GfHHFKNlyWSt2SzetQUpwjqSmcPjl3I8koJIQaaays7g
 Dvb5aJR29uCYI43bj7mIX61h90mCeREY+MdRSsGUqHGO
X-Google-Smtp-Source: ABdhPJzgj/RzVBrIOD+lLeDRcM1o2wgoZ1hbyLh2NnpqmX94bx9r3bPjaRT5cxFLWbu+Xg/JOBy35hm9E2W48NJvGqM=
X-Received: by 2002:a9d:6d14:: with SMTP id o20mr1528754otp.357.1632771639628; 
 Mon, 27 Sep 2021 12:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210926212719.45595-1-ernstp@gmail.com>
In-Reply-To: <20210926212719.45595-1-ernstp@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 27 Sep 2021 15:40:28 -0400
Message-ID: <CADnq5_PRMhrWBhF5LTVbLpbZnxaiychgEzT8-TgsQF-Uo56YVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Validate ip discovery blob
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
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

Applied with minor updates to the error messages.

Thanks!

Alex

On Sun, Sep 26, 2021 at 5:27 PM Ernst Sj=C3=B6strand <ernstp@gmail.com> wro=
te:
>
> We use the number_instance index that we get from the fw discovery blob
> to index into an array for example.
>
> Signed-off-by: Ernst Sj=C3=B6strand <ernstp@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index ada7bc19118a..b3fc46ba8144 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -245,6 +245,20 @@ void amdgpu_discovery_fini(struct amdgpu_device *ade=
v)
>         adev->mman.discovery_bin =3D NULL;
>  }
>
> +static int amdgpu_discovery_validate_ip(const struct ip *ip)
> +{
> +       if (ip->number_instance >=3D HWIP_MAX_INSTANCE) {
> +               DRM_ERROR("Unexpected number_instance from ip discovery b=
lob\n");
> +               return -EINVAL;
> +       }
> +       if (le16_to_cpu(ip->hw_id) >=3D HW_ID_MAX) {
> +               DRM_ERROR("Unexpected hw_id from ip discovery blob\n");
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  int amdgpu_discovery_reg_base_init(struct amdgpu_device *adev)
>  {
>         struct binary_header *bhdr;
> @@ -290,6 +304,10 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_dev=
ice *adev)
>
>                 for (j =3D 0; j < num_ips; j++) {
>                         ip =3D (struct ip *)(adev->mman.discovery_bin + i=
p_offset);
> +
> +                       if (amdgpu_discovery_validate_ip(ip))
> +                               goto next_ip;
> +
>                         num_base_address =3D ip->num_base_address;
>
>                         DRM_DEBUG("%s(%d) #%d v%d.%d.%d:\n",
> @@ -321,6 +339,7 @@ int amdgpu_discovery_reg_base_init(struct amdgpu_devi=
ce *adev)
>
>                         }
>
> +next_ip:
>                         ip_offset +=3D sizeof(*ip) + 4 * (ip->num_base_ad=
dress - 1);
>                 }
>         }
> --
> 2.30.2
>
