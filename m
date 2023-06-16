Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146B3EB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 12:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2644E10E614;
	Fri, 16 Jun 2023 12:47:17 +0000 (UTC)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D2610E622
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 12:47:14 +0000 (UTC)
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-558cf19575dso402921eaf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686919634; x=1689511634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4M70utfNWiSd56mHJg2tP551CWaio5hTlZ4noMCF1II=;
 b=naxY8lcxv8hShoQBHGFxJRxvaIY/blbaj4QkrDaR85bvMttOzR3h9W5NghJ8KmH1PP
 c3G9LZLYN7I8FeI9FBvCqYJRp8rmXE93ONhrcM+gRW//s0/1RJJrXdG8hPc5aW8JWqYG
 RJhCRwFk+ACw9oQzlMZcONTL9kJkP9S2nrdLGDLk/AG7EUcFItOyy6vPOh4lf45QLCfn
 3oaxnv+20a3M5sK54CIG/xCb3faqgY/ZixXTqCCn6WGiUdK5OV7HkfqyJv3GHb+K5huo
 ntuwBfQhf6xT6CIEu4T11VcMlb+hCiyv2pxVuqUjwfOr0nGnVv6+q5TB5KAQZWsFIjic
 8rnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686919634; x=1689511634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4M70utfNWiSd56mHJg2tP551CWaio5hTlZ4noMCF1II=;
 b=e6qZhwUetBDr9uMPpsWioPY8Lrda5/UVpLRTjjBNambQNA4nNyaek+KwRhZk9fKHR3
 72oG+22jWjoqo7VZnW2Ari62T9I3eYbQv8UTUKpbN6SO4/EzGBCv9cxCgODw19msbNK1
 FwsglYpJIWES1d98fdeZ8zGHiA0AfYPBwwhTFieGblSWahRiq31nVZi8Do7eog0BJIjb
 xEnIHAZcSKXXwnletcq4F+q2aCzSV8yYYyP+2oAaF4DWJn8hjl7KnbSRLe4kHv4+XlHL
 BvdxuUuexSxOi1Lls+IoD/vGZKOWuNyzeYgypdbUtvE2XGo9/fiI2shBBSnBPnMEmXPM
 2unw==
X-Gm-Message-State: AC+VfDz7jclayJ77qxXj40+pMhqH07riFcMGLRHnFIlxtGl6NCim6G3Q
 Q8v+AFyOYkk7TfG+ymtvTLhmJfOixM0E4PuiDMo=
X-Google-Smtp-Source: ACHHUZ5YUjzL6SDSvnYqAV/NbYStWLoJITNh2Q5KXdzJKjWaG7JvEnV4H5OmNhVW9XD0Fe7Q208nHWgcL0sdbh87q4U=
X-Received: by 2002:a4a:d557:0:b0:558:c15c:f62e with SMTP id
 q23-20020a4ad557000000b00558c15cf62emr1753819oos.8.1686919633760; Fri, 16 Jun
 2023 05:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230616012015.3699013-1-evan.quan@amd.com>
 <20230616012015.3699013-2-evan.quan@amd.com>
In-Reply-To: <20230616012015.3699013-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Jun 2023 08:47:02 -0400
Message-ID: <CADnq5_Nw=GJMZwDde1P38Okr5UcO2izW+v4RLvU_XfLwKYvyyA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/pm: update the LC_L1_INACTIIVY setting to
 address possible noise issue
To: Evan Quan <evan.quan@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jun 15, 2023 at 9:20=E2=80=AFPM Evan Quan <evan.quan@amd.com> wrote=
:
>
> It is proved that insufficient LC_L1_INACTIIVY setting can cause audio
> noise on some platform. With the LC_L1_INACTIIVY increased to 4ms, the
> issue can be resolved.
>
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c b/drivers/gpu/drm/amd=
/amdgpu/nbio_v2_3.c
> index 7ba47fc1917b..4038455d7998 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -345,7 +345,7 @@ static void nbio_v2_3_init_registers(struct amdgpu_de=
vice *adev)
>  }
>
>  #define NAVI10_PCIE__LC_L0S_INACTIVITY_DEFAULT         0x00000000 // off=
 by default, no gains over L1
> -#define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT          0x00000009 // 1=
=3D1us, 9=3D1ms
> +#define NAVI10_PCIE__LC_L1_INACTIVITY_DEFAULT          0x0000000A // 1=
=3D1us, 9=3D1ms, 10=3D4ms
>  #define NAVI10_PCIE__LC_L1_INACTIVITY_TBT_DEFAULT      0x0000000E // 400=
ms
>
>  static void nbio_v2_3_enable_aspm(struct amdgpu_device *adev,
> --
> 2.34.1
>
