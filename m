Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E02CAC592
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Sep 2025 15:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B34788FBD;
	Fri, 19 Sep 2025 15:14:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OZOm3rCy";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3F2188FBD
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 15:14:49 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-3308f4129fcso178596a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Sep 2025 08:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758294889; x=1758899689; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HX1VVA8HyB8zgPvl221Cy6GTMOJmqsABMEaGYcZeMh0=;
 b=OZOm3rCy5keOGg8/rghOt++dR4URMjNJh19TEvOOA56W8W6YkjsEBBK2EvJuRDy64f
 FNHLv1gRBED3k4wWKzXU3Z9oPCEOOcA3RAzmd20wU6XrccR9eVeUMUmQfhF7Jjs4obpC
 frRlfPxTiTq7xpfGfdykb68UxZlZLZ8Mq94ZfKE3PcTcyyZlhqTt9QcPBetimVyyOOjz
 zsSOAg5EacAGN93pw/uhGkEoZ2c1zhljf7vAXYNtmA/VWsi7B6f7j7Gkyd5WQfH7B0zY
 GSH+4N7wnX8ZB+zXFLMnjJeQ4Q/VqUI0vxP+pMrG5ums9XW4YgdDAuhTOxZNpgDcq6+f
 PoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758294889; x=1758899689;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HX1VVA8HyB8zgPvl221Cy6GTMOJmqsABMEaGYcZeMh0=;
 b=tajbOIUla720jWFpIvTdV8g1LY7Gl0O+gmJYKa/hDN4YzVoJeglhdMRgiJdTgooiLN
 4cXuBOeReSAL7uHmdT/QbsiitsBrAO03ABHV7VlAd9ogFhB9fhXIlLZPaMOEbBUXH2vD
 IEqiPkumEECKrq7kLYlkgPJ2OLZeoq1dsPVafw+inn9lJq6UeZD4cifK+sMw4sgVPpZY
 wQ8ifN+9LF1c1QeaKeaHMwcuq6o5AS+RcRBQ+HeXHHSvAdttJiCVMJy4UGscRI9uAifr
 r0qRQz5VXz06c94tcFMxpv8+m/ugi2c0xKcjx8cKfvb8Ht/0t/DCXHnwuk5wDIB8GLdf
 It4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlIeEB7lJArAeDk8k33z0BVCqtb7o5dihLAHaFRr+0f81cTSJNiMQgDPvVBILj4PDXBqyQ9h14@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3UoGrj/CFG/oYmNiN38ir030WsVV2ipQq4jNsxeIdCYDEZNiX
 cUvZEWPCCA6AYjh9rfZMYNAUTlb4mZkRLDYgkYtM0x1LpA+FpHBqB6G/EmYSR4xeQQor9+DyF4T
 rgbMauBWQ5rLvjp5MyMEzuBGaeaAENSk=
X-Gm-Gg: ASbGncsx/dGwvmIlXw65xt+zyTp2+aBLn7UwD6wRaNULo9CBRWgdzvLYE3vz9pEwwOa
 T8ygwC06+pRPwHkCi/nytIgT8AWDyUaWy3yTpPV2KlmMg+s445E1SLuVO8PDG7vDetRJDRSe+Rd
 UlL3v09jRmIVGJCeJ4c3OgyHI0MStppuP1dfgH5JIdmH+0fR3q1bFIX2ZBmDdC02Q3TsLmlWDQj
 3zqV7A=
X-Google-Smtp-Source: AGHT+IEpK19YMQrKSgSC6M+05pSsIfexMceH/zUKzST+uke0iAS8l6E8G2NRCRUoXsnzakwtmE+kjR5jN9K0W64PnCU=
X-Received: by 2002:a17:90b:3806:b0:330:7a07:edb5 with SMTP id
 98e67ed59e1d1-33097fdb384mr3207285a91.2.1758294888979; Fri, 19 Sep 2025
 08:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250919122147.2538-1-christian.koenig@amd.com>
In-Reply-To: <20250919122147.2538-1-christian.koenig@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Sep 2025 11:14:37 -0400
X-Gm-Features: AS18NWDax_H-URfnZ2YpMLiy12w8u0ozOcdgyxDkZOs1JXZBUEasaNqjRJmmcug
Message-ID: <CADnq5_MVAwcnASmtpjjH2rfju+odqfMvPtocAxTfSw6nsBjuYg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: remove leftover from enforcing isolation
 by VMID
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Alexander.Deucher@amd.com, James.Zhu@amd.com, srinivasan.shanmugam@amd.com,
 amd-gfx@lists.freedesktop.org
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

On Fri, Sep 19, 2025 at 8:21=E2=80=AFAM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Initially we enforced isolation by reserving a VMID, but that practice
> was now removed.
>
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ids.c
> index 5dd78a9cb12d..cbdf108612d2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -594,11 +594,6 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev=
)
>                         list_add_tail(&id_mgr->ids[j].list, &id_mgr->ids_=
lru);
>                 }
>         }
> -       /* alloc a default reserved vmid to enforce isolation */
> -       for (i =3D 0; i < (adev->xcp_mgr ? adev->xcp_mgr->num_xcps : 1); =
i++) {
> -               if (adev->enforce_isolation[i] !=3D AMDGPU_ENFORCE_ISOLAT=
ION_DISABLE)
> -                       amdgpu_vmid_alloc_reserved(adev, AMDGPU_GFXHUB(i)=
);
> -       }
>  }
>
>  /**
> --
> 2.43.0
>
