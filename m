Return-Path: <SRS0=z2P7=BH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D654C433E3
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 16:22:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 345DA2074F
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2020 16:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jjz5Oyfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 345DA2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F2F06E237;
	Tue, 28 Jul 2020 16:22:50 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA48D6E237
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 16:22:49 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id a5so8917433wrm.6
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2020 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ci7NTM/ZGJ7n1pgJmUjXsJU597bm1V+sXNzz4NuDwHI=;
 b=Jjz5OyfgPYkK9rhnpXUeurdx0ZAmyyfGlbxHM/vD4h2Kn6z7OM1IA9fBOn2lSgbZDC
 bqkxbm+61a6SokEkxa1ijrWlEUilZ7Kzq0/OnRhrVp3n6SeXCuB+FpExj1KnzCyJye41
 cB0EeVM0/eIkj7j6XWmGi8v5Y7SIczmBh9bN/otUtHDCgW2APOXY9GJtY3uFHBQlsJYt
 PIVnYqXWNVyHpJ288HdfbEszlzYaSUQXmnKIfthnr+/WEnv+/95KlndY/q3QPxWVhAzv
 vP5An6AA5xkLY3xphcqsTQdvXWKcPHiLlyitw/Hm5SOK2q00Rz6P3wtvM27c1zfJuENg
 yTzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ci7NTM/ZGJ7n1pgJmUjXsJU597bm1V+sXNzz4NuDwHI=;
 b=pFUH5UFpnZ2XVKO5RadDd7dQ5TmnHFx/VwITLn5USX9xDhPtC3JxtDHq4bZsmsQwGD
 mEVkdRH6Fhb/bS3nlezeCml+RB3lATUocR3dJaY095pihFDG+6KjMjtNtGBcXynIqHNp
 fUFbeFx3N5Lbl+ltmx+ojCBDdUtAxZ5lf5ktZhHPGdukDuwt3MXAbENJc1bzbDDeFwt0
 OUQL5OOBt8b86z1bOcejm0BuTksa4RlKof6AlA5bPvGpMe/W6097ll1eCqqoKrcyzajV
 OaS5Z87HSsjNRCn1O3BgHXfRZC+8Rr/ryegyhWgRKzm9MVXJapdKt6myda3JxdwdTQnv
 rTGA==
X-Gm-Message-State: AOAM5318wQNdvL2ueh95Xk8l0V3mf3v7yqk7IUDa7l3xmqgL/o3HlNg6
 7X5mRLfXn/kr2xMC2T/ugToKeiag1Ac+Ux9FV50mnw==
X-Google-Smtp-Source: ABdhPJzL4J/9n60fIMkznIXZBfC4PvI6p1Lg8/qXziUL/BkM3mVcaBO3GUPFNlGA5S9L4o2WbmIjlf9f1T/c7Ik3yw8=
X-Received: by 2002:a5d:618e:: with SMTP id j14mr26769932wru.374.1595953368504; 
 Tue, 28 Jul 2020 09:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200728154318.29805-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200728154318.29805-1-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Jul 2020 12:22:36 -0400
Message-ID: <CADnq5_ODHqZj9sncQcJ6VxBbkAqFv-4ORJdm_1YxaYq68ZnQ8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: parse ta firmware for navy_flounder
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jul 28, 2020 at 11:43 AM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> Use the same case as sienna_cichlid
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index d488d250805d..e16874f30d5d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -179,12 +179,11 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
>                 }
>                 break;
>         case CHIP_SIENNA_CICHLID:
> +       case CHIP_NAVY_FLOUNDER:
>                 err = psp_init_ta_microcode(&adev->psp, chip_name);
>                 if (err)
>                         return err;
>                 break;
> -       case CHIP_NAVY_FLOUNDER:
> -               break;
>         default:
>                 BUG();
>         }
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
