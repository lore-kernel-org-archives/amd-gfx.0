Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62934C56208
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 19:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009E610E387;
	Thu,  6 Aug 2026 19:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KRRYfA7i";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBA4310E387
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 19:57:53 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38cfcb507a3so341011a91.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Aug 2026 12:57:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786046273; cv=none;
 d=google.com; s=arc-20260327;
 b=cFLolKniLn3ub9e+XhB9SGIp1c6/f8MUbj9lgseEpK2WuFSdiYAyd3Zd4zDPI64iVI
 Q86nhDRDTQADOmQrxQ6TwyGQ5nV/ICxpmG6onCWsGCjF8HR5IgvVGqaGMTIry7eWDNSC
 AwXR/0bjULIkevIe9hx6uPVDffIow3M5cweHbfpqj7aB3FTK6DTv0Wdm+1fwUO35mA4i
 O2ko5X6DEQszCJ3t1DNd1C2z/zM1I9FR0qvke+lOGjb11kyNSJrxoK1Kx0bdwp7qWyPi
 nbQ7aRtGW02o6Oho1Vzu0dvqLkkt2iyKSmjWzkdeMP0rE6NaY4+7C6/bWusxY3XxtUe+
 eD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0jmN24vuOk+KteCZoK3148dpEXxM8GXd8s0iMAv20qU=;
 fh=outNoO55/U/D/xH4q4axyRYi7fPugJt1BzfXOswabd0=;
 b=SxF8CGyO15m8VB25jbZZGwGrQgOJ4eHBa0LSX/mZa62ah0hS8gkfuFHkL8REKWkO2S
 w3bPZuOo/72JuyGoIR0C0cu0A9fAR25kUy5SMQydw5oZh0eo7MiwOdTJBXW/DLzee5uE
 w1pdUwO1qrpfiIKHhqXtSNuvCl4wAf6yZVlp6SFvgJZ23QmZcqoTx+hMXhjbrZJjmP/G
 MMFlOqIoZNc0qkEsq6Sjr6irUFtmi3swedZ4SLMedX5PmkwokZSycXMDo0ohhZowm9+X
 JOB7/aOszFWfgxnhQdZoj/VgYWaIA9cgsuMfWgtuAvfV7CjPNufJT8UPA8xMu8roRKK9
 BDgA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786046273; x=1786651073; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0jmN24vuOk+KteCZoK3148dpEXxM8GXd8s0iMAv20qU=;
 b=KRRYfA7iXFUA+M3Z9tOqg9AKbxlWzbgP42frcmBNghmb3gpRF9uxCY+KzzbHkLQGWA
 1gtbPtJn47KQwg7VH0xCCsIQOEv/BBKss0AtUgCjabZGvZhWrbLX/1gRRQljOh6Xcu2Q
 GZ5mjrbqoTK1uQ7Zk+fZTbnJf+9pzMe3kOkluvruGqQroXFpvF77e/ZsIx6Y7RjCklQh
 MsQXJyINaMTegZ9JMdoKyYp/xWZiuhOtgrBao0SzQ/vQ67/FOGTPUREZEbvsI76DJNS7
 18nBG0fdHksd0zBohFbYiB13bj4BDfd8yIcUKW8PXQnXLX+8a9e9pJ/53S5xxNLEtdw4
 yxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786046273; x=1786651073;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0jmN24vuOk+KteCZoK3148dpEXxM8GXd8s0iMAv20qU=;
 b=skZ5K1WElburfGWpubRu6HJPw4btgZVco+jffwgEaBPoSZTxRlPq+zryv5tawdWAok
 pb1hq/3qQWh90JeeLjU9DoNKR/1BEHeQp/T8JzxNz2LkAb1ASkFJRcOJGojMyKSePrxP
 kFt/92y8zXkrtuO+iaxDYXz0hrw7OXk0XKEk7PrDwuMWcU7BJcKkir4fEHSf3Sr96n8Y
 JPk+5QClU9Z8dPG4VAHU5KavhxpOoD8hviC27i1Ro0jToRFWUv7cMHqgIekBEwSaPDq1
 gSlQ2I5Y3u6XcomrfxTw4abkPdPSvbDhb1iLJFNOTAPe8AOBPnMC+Qk6QANswiOWDF6s
 yZ9w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqN/niAzJOBBalQHtuhs2cJhqmniAnY0519IQHMeMlesn0pC+W6zkHh7Ms0rGU8folk8zuK4A7r@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjPlqWcaUASPInkxF48rmbPeR2MjdLE4JI2Sw4L77Pxt74VoZB
 pFGnIHltqWpnxcnWUB4Tbi9XsYbVY8Kr5nnJW/SoI+YAh5hF5h1hghalaZ/5kJErPaAR3Xd5xVg
 9ARxm5gkQUW9AgWmB7JpdsMGsRtERnJc=
X-Gm-Gg: AR+sD13Z1KiFJdrlQJLKE4aLRA+AyCjXu8ZhqAlqRQb2CUNKU+HD4TTvwahWnK6gKPe
 IcP+9v8VaOWdveU+sGTvgCR9dsSsurwZEtnpZcNtAYJXfTXpIYKjPG37eaxuasQxee2NrWEGQgN
 uAFrY0I4idSYFn4hcwleFbkPPNYbxNdg8AAmB2/0/WmFGzOIWDdcSNOqtESNAttQdrfwstIu4eL
 O0qLMjD6yHVFkNh+YE3YOvF/hCLkpDWMxY8no0vWtw2jMpsaL1oBAAtlP/yt3+lsPZVHg1mWvhO
 CnM0biNZ4HsT5cE/QYrsW6L2qYNfOljUFQ/WVhNbJ3173PSg7Y4kf9unUBpmhEw8dBZoLXk5QCb
 nMdNLOMIzzBuhcRG8kuOgtcWsyQ5X0LHy+6x5nuhBYQ==
X-Received: by 2002:a17:90b:3803:b0:38e:55ec:e436 with SMTP id
 98e67ed59e1d1-3903b9c95aamr12293156a91.0.1786046273207; Thu, 06 Aug 2026
 12:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260806132526.2810055-1-Shubhankar.MilindSardeshpande@amd.com>
In-Reply-To: <20260806132526.2810055-1-Shubhankar.MilindSardeshpande@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Aug 2026 15:57:41 -0400
X-Gm-Features: AUfX_mzz4WvJQ26IFHqAupOUYUJZul49jdjR94Abkch3ZskVpyA86Cb5jhT9WV8
Message-ID: <CADnq5_NPj=RTLd0Gw-mvtn7O+oTm0XWAcCkz1SYZ2Vg_sSGoPw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Enable GFXOFF functionality for SMU IP v15.0.5
To: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
Cc: Alexander.Deucher@amd.com, Pratik.Vishwakarma@amd.com, 
 Christian.Koenig@amd.com, Lijo.Lazar@amd.com, amd-gfx@lists.freedesktop.org, 
 Veerabadhran.Gopalakrishnan@amd.com
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

On Thu, Aug 6, 2026 at 9:43=E2=80=AFAM Shubhankar Milind Sardeshpande
<Shubhankar.MilindSardeshpande@amd.com> wrote:
>
> Add clockgating and powergating flags for GC 11.5.6
> and allow/disallow GFXOFF for SMU 15.0.5
>
> Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpa=
nde@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/soc21.c            | 21 +++++++++++++++++--
>  .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |  1 +
>  2 files changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amd=
gpu/soc21.c
> index 1f9a9c46377a..5a6c84c802f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc21.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
> @@ -825,8 +825,25 @@ static int soc21_common_early_init(struct amdgpu_ip_=
block *ip_block)
>                 adev->external_rev_id =3D adev->rev_id + 0x1;
>                 break;
>         case IP_VERSION(11, 5, 6):
> -               adev->cg_flags =3D 0;
> -               adev->pg_flags =3D 0;
> +               adev->cg_flags =3D AMD_CG_SUPPORT_GFX_CGCG |
> +                       AMD_CG_SUPPORT_GFX_CGLS |
> +                       AMD_CG_SUPPORT_GFX_MGCG |
> +                       AMD_CG_SUPPORT_GFX_FGCG |
> +                       AMD_CG_SUPPORT_REPEATER_FGCG |
> +                       AMD_CG_SUPPORT_GFX_PERF_CLK |
> +                       AMD_CG_SUPPORT_GFX_3D_CGCG |
> +                       AMD_CG_SUPPORT_GFX_3D_CGLS |
> +                       AMD_CG_SUPPORT_MC_MGCG |
> +                       AMD_CG_SUPPORT_MC_LS |
> +                       AMD_CG_SUPPORT_HDP_LS |
> +                       AMD_CG_SUPPORT_HDP_DS |
> +                       AMD_CG_SUPPORT_HDP_SD |
> +                       AMD_CG_SUPPORT_ATHUB_MGCG |
> +                       AMD_CG_SUPPORT_ATHUB_LS |
> +                       AMD_CG_SUPPORT_IH_CG |
> +                       AMD_CG_SUPPORT_BIF_MGCG |
> +                       AMD_CG_SUPPORT_BIF_LS;
> +               adev->pg_flags =3D AMD_PG_SUPPORT_GFX_PG;
>                 adev->external_rev_id =3D adev->rev_id + 0xd0;
>                 break;
>         case IP_VERSION(11, 7, 0):
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c b/drivers/gpu=
/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> index 14d0eb296a00..4c0236196de4 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c
> @@ -583,6 +583,7 @@ int smu_v15_0_gfx_off_control(struct smu_context *smu=
, bool enable)
>
>         switch (amdgpu_ip_version(adev, MP1_HWIP, 0)) {
>         case IP_VERSION(15, 0, 0):
> +       case IP_VERSION(15, 0, 5):
>         case IP_VERSION(15, 0, 9):
>                 if (!(adev->pm.pp_feature & PP_GFXOFF_MASK))
>                         return 0;
> --
> 2.43.0
>
