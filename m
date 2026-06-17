Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE3CD98E4
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 13:44:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87C510E929;
	Wed, 17 Jun 2026 13:44:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pBJyR2qM";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DABE10E929
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 13:44:02 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-304f8e80b7eso445877eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 06:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781703841; cv=none;
 d=google.com; s=arc-20240605;
 b=NVw5siVVaR1miR1fGNxPUT1D+xI7BphgHpiM5qJ5MxJtIaNAjWxgytodGgeT+bv380
 mDnmtVkh3Aq4cDc6/AINahXJqiUxsJb2YgaCXw3f3cN9gpXEscULTdndWLftBy5WTfwD
 cYGMgNploMhA/BL5pdDv5x3UKh/T0tBWsvI2ipQ1WbMmZLXm5h1QQAOYKAdZn02iN/KD
 +Q81s3cnOPU0SzVpG56wH2eA8kACxbj9ScCf+3Z2U2oLvTuEws2hz4osIaW3QIQm/GDe
 gVsgcsbwtSc0dQe6qMUFrhmtT1gVF3HCrWeWxFSp209xDNfn9sfqxlzdl/w+6oU+saGK
 inpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xqiQ0MOwNKQI4wxxnrcszlc+jKBDbTWbG2ja2M8I8Ms=;
 fh=hu6edWbrNIbeIZ0Tkzb9Dvke4+sCsh4tKagiLtEFVz0=;
 b=iENJkoat0pXI4qZ9n2jLvT9kzve6vioi/3+Efm4nCFsxtfaHyIZP2s9B6fLKjFjCUh
 XiaM0wOimAZRdG/4rB7YZUOXVoeSowjClljey5K3LBqWRMjd5d9LO3P24c6aGq45NUSB
 1cTTH47RkAXTtvtNeYhKITnPnX2esxUVWJWCxxDo7XWLHgwYFsrbXaFxVkRtmZODM7ck
 4rDtFpK3Z3U2covATWVLOOnd3gvbMEffqUkNiyrwMdkM2JVZVztRwjPhLBPlbT6l6NJ9
 mhDI07571ElW80QAUgvMT3ucbfa6mek0KHOrwLXVJcX51ejAa0gJ57JfrvhvTJmHLEn6
 ULKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781703841; x=1782308641; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqiQ0MOwNKQI4wxxnrcszlc+jKBDbTWbG2ja2M8I8Ms=;
 b=pBJyR2qMNuuuPMhuWK4+nFko/D1t6EoyieQZvBnLi+9nh+bEAR4838DspftUv2jePR
 cIrQ4Yy63cFpjhp+S1jazK8rKrc+LxvGaqCGXdHQp2E3oDLOOoCxV3WkP438zD5x87nF
 xUIKa94jHOKHpFJ+u/oMY6eoDs//lpCjgtuBqOnLxSIFZgVA+XZtsDB8FfSJMzzTJpW5
 CdZQAu9eXtt0hobbmX8Agx/vL/ENbsGNlmJeAEtWERgqdwy5pUpHam0aKqLOuPOVFhQV
 ZkG7Rh5YoxjJYDojT/ZtCtC1XefI16Z0XQUj2WJ7lttmwn0yvf6sBt+U5a3jTQg8eaYD
 vVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781703841; x=1782308641;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xqiQ0MOwNKQI4wxxnrcszlc+jKBDbTWbG2ja2M8I8Ms=;
 b=UZeXD/Nvxkirw90OEuKq6sVndXotBMx7HSEpy/sjs66rTVtTGU9eh6wfp03wIJWK9U
 nCP5yMWDO7Ga4eQ5otYuoLlyqYAYMmDD/tCzUhc+vyJWZyIXmqq2L+7RBBkiufdxpmQj
 nK2Xp70nYoyS/l+oSsZAvs9oKsqBhcoK6P7CFPZpdjsuE5VPNghSRlzWhwWJ+JJ2VcSd
 GxNnZjcsUcWnT+xgmILW7QqW+KZhzZFJT0yUxDFdkkzvFkpu+CPSBZAbnQnEBy6uHD5g
 kTBhL8RBgSR7Yb3ErK8C7fOdX1Lt1PLiae1BTm2XlFB0ukwSASimPddTYxvAMtws/e06
 /Pdg==
X-Gm-Message-State: AOJu0YyPOEiiu24FyMtcbuDaqUxAVzXCP/HG4qUT+6Jo3A+0eh7JnVoq
 NEsjHGBJcIL7qNb6gYzUrXpFwEZ5Zzhy7ddNsvUgFqv5MSH68OpFDVMZBz8M2CokD2YXjC3sq2r
 KNRz4Vi/oO1T19WEOpoV0bzaCI2qktz8=
X-Gm-Gg: Acq92OHGPqeTwJQH7hmk9h3Fn7tSgZ20+4LaOxh145o88dl/gq4klmqNIQprVBSo7Uv
 rsDjb/q/2vrhM7CVBzkWq4RctrGsoAcuDvzHwMvDdOLxUfewnP1zURbqjaOqmYPKXjk5xZ3TqCm
 x9J6rllz4Uz/vzZn08eCRG4q+XhYe9P64BgyJJNNVI7HCl/kVS62SVfBubl6ozgrC/zjZ+Cu/G1
 UbdPbUllTQDvx+kIPen1j4mqux0ifkj9WqdE5E9cNcbhIKgzQz3hz4aEhNoSUyIaJA2KTp/zQzg
 MSmfkgLe1RXkNWTUtyXnt/gEdMPei8+h4Ycbf5I9JNPos8P5Zk+TPbEB1FE=
X-Received: by 2002:a05:7022:622:b0:137:ec1a:f405 with SMTP id
 a92af1059eb24-1398f56699bmr724075c88.0.1781703841445; Wed, 17 Jun 2026
 06:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260617085435.723531-1-lijo.lazar@amd.com>
In-Reply-To: <20260617085435.723531-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 17 Jun 2026 09:43:48 -0400
X-Gm-Features: AVVi8CdCCHHDKRuhIsyQBRDWBAmu0P3rOn5ENC4NQ3czD4H_jxFQX6qmIpU2GjE
Message-ID: <CADnq5_OA3bsCc7hkWbyaAvPjJDutn30APTfaU+WPAmTW+CGMcw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix kobject cleanup in xcp sysfs
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Asad.Kamal@amd.com, candice.li@amd.com
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

On Wed, Jun 17, 2026 at 4:55=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wro=
te:
>
> Fix the indexing issue. Release the kobject whose init/add failed, and
> unwind the successfully added ones.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.c
> index 14cef0264c17..d0d494e00cfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
> @@ -904,7 +904,7 @@ static void amdgpu_xcp_cfg_sysfs_init(struct amdgpu_d=
evice *adev)
>  {
>         struct amdgpu_xcp_res_details *xcp_res;
>         struct amdgpu_xcp_cfg *xcp_cfg;
> -       int i, r, j, rid, mode;
> +       int i, r, rid, mode;
>
>         if (!adev->xcp_mgr)
>                 return;
> @@ -950,14 +950,16 @@ static void amdgpu_xcp_cfg_sysfs_init(struct amdgpu=
_device *adev)
>                                          &xcp_cfg_res_sysfs_ktype,
>                                          &xcp_cfg->kobj, "%s",
>                                          xcp_res_names[rid]);
> -               if (r)
> +               if (r) {
> +                       kobject_put(&xcp_res->kobj);
>                         goto err;
> +               }
>         }
>
>         adev->xcp_mgr->xcp_cfg =3D xcp_cfg;
>         return;
>  err:
> -       for (j =3D 0; j < i; j++) {
> +       while (i--) {
>                 xcp_res =3D &xcp_cfg->xcp_res[i];
>                 kobject_put(&xcp_res->kobj);
>         }
> --
> 2.49.0
>
