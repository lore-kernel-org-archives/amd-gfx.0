Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB46CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 19:44:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE7310E233;
	Wed, 20 Aug 2025 19:44:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PfM5lpMB";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0942789A5D
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 19:44:06 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-244581cd072so240375ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755719045; x=1756323845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o1ZA97+j8vrSXfE/ccO46+5y8cZm3LeNzLG0vDj5bA0=;
 b=PfM5lpMBDkvmmj5VFsTgh5sE/JUbIZTLgb5qXpx/6trhgHcqxbBTd/UpNcqRck5+zU
 3aHXtjc103ldlPgYL0sjwgiucOEPXHh6/OyJWWOUasI+4II5mUspQRSosWJxKdODS0kY
 3KuBqr6UzVhi1N3s6GqwPMp4Sium4+w3OXEx4CJJdrDjMjzGMl15YQndW1c+AB4pEJCC
 mNVEOecKIbFAqlr/Xk0N8AaR4cgH7S+2TzhdODsXyd0cWBd+uMGoV0b3Pf5yfNTsV1dY
 8d2jpvxPTnS5jdpVytVQshBJ4dLnNqxu4QVrpzBh/16UI0Kpmj6t7KOYeByh7d8FHDek
 nTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755719045; x=1756323845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o1ZA97+j8vrSXfE/ccO46+5y8cZm3LeNzLG0vDj5bA0=;
 b=IM/9Jhlal6J0aokTIbCYA1ih7CTDyBDm8Yn888wn0ylWe5hTN0pFIG2mVoOFXnRCzb
 q7KR5j5spUePfiGOLUgmEjMtXR89NIoLoC5Ijce3bTGb04MVo6XmX3eAIV9dwda6lwjT
 wzG8S0ZiZ3em7BoDmE1QfhteS5ZQk4CGZXp6vykCXVmqAazuXc/4h1SsM7fL8oJg13/g
 G9djrCbzEajIv3e0kIt46CoicmUxgfCxvARGRkAQMayCRhEoKfcHblk39haRWLj/N2jl
 qETiOIqMqRPq7CXG4wuSV8szOurFqM14+qmCBayn9gXCs/uVlZ9bOWxTpcAuVirfVhGq
 rksw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoiGjidTrk9aRGaUyCoOhqRg97O8P2i4EKxREcbIK3NN3QiEA80xyWmvG+O8S91Pm8C5GmVO9f@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDMrczfeuUzVux76kUePlW3zQZRG0R8FgL00nekXjPt3IJ4RRI
 YT2TrdiwI2NQybcIl6cLvg03t1h5v8igt9MmJO8y+eXDR7+r1GB5+L9ylzAeIe1mvCnQ9VtKaYV
 rWO1pmjiF7vN1k4gtjAuc9g0ijze7Rk0nEA==
X-Gm-Gg: ASbGncusPEmYYEv6tfkK3iXuJLecORyUCsrdj4L1eAiCnuV//DhvsY3nDEKidjEOlEL
 GC42ACpQ4p8WgRPI4qZbo8yaBol+ybtAS7xD8J/drMoWrMHeoJCwYgovVu7hmszqzy8TU/Mxhaq
 Vhau4P05x/i1jcYXfYI3IFxGqcK2rehmAHCxxwJVUP7rkWgPR8p4B/nqH09J5JRsVLfVCPi8YTi
 ezw6i4=
X-Google-Smtp-Source: AGHT+IGaj9K+zGyowsW0BM4o1gWxeK8C5VjUlH954qbVJsDFPRCRYLBeTZOEwG2ZC5iRaQoqZk8+gGJDLg+GwxD4wHw=
X-Received: by 2002:a17:903:248:b0:242:d237:a8da with SMTP id
 d9443c01a7336-245ef1734acmr26352165ad.5.1755719045392; Wed, 20 Aug 2025
 12:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250813193658.2444953-1-alexander.deucher@amd.com>
 <CADnq5_PqnUUxF7Suj0fg4Q6F6ELa8ugT78gFWHd5Djg1GGB8hg@mail.gmail.com>
 <45a4074e-860a-4c82-8fa2-6423286a2268@amd.com>
In-Reply-To: <45a4074e-860a-4c82-8fa2-6423286a2268@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 15:43:53 -0400
X-Gm-Features: Ac12FXwyPZHgGTR7smQ1I7RETvNUrFNTexGS14Os2TzRiyVJVBcjIFlClAu-JgI
Message-ID: <CADnq5_Mhdg6-7xOkofj0NT8MiFyv-EKcmZLObSApLjWX7Z-zrg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/vcn: drop extra cancel_delayed_work_sync()
To: "Wu, David" <David.Wu3@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Wed, Aug 20, 2025 at 3:29=E2=80=AFPM Wu, David <David.Wu3@amd.com> wrote=
:
>
> [AMD Official Use Only - AMD Internal Distribution Only]
>
>
> one thing I noticed:
>    amdgpu_vcn_suspend() also gets called in vcn_v2_5_sw_fini() for exampl=
e
>    where there isn't cancel_delayed_work_sync() call. Does the removal wo=
rk in this case?

The sw callbacks are not supposed to touch any hardware, so that's
wrong to begin with.  That said, this should never end up doing
anything because we've already cancelled the delayed worker in hw_fini
and after hw_fini the hw is stopped so no work should be outstanding.

Alex

>
> David
> On 8/20/2025 2:36 PM, Alex Deucher wrote:
>
> Ping?
>
> On Wed, Aug 13, 2025 at 3:37=E2=80=AFPM Alex Deucher <alexander.deucher@a=
md.com> wrote:
>
> We already call this in the hw_fini() methods for all
> VCN instances, so no need to call it again in
> amdgpu_vcn_suspend().
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vcn.c
> index 9a76e11d1c184..fd8ebf4b5a824 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -357,8 +357,6 @@ int amdgpu_vcn_suspend(struct amdgpu_device *adev, in=
t i)
>         if (adev->vcn.harvest_config & (1 << i))
>                 return 0;
>
> -       cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
> -
>         /* err_event_athub and dpc recovery will corrupt VCPU buffer, so =
we need to
>          * restore fw data and clear buffer in amdgpu_vcn_resume() */
>         if (in_ras_intr || adev->pcie_reset_ctx.in_link_reset)
> --
> 2.50.1
>
>
