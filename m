Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B685C5AC67
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2026 13:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA4510E0A5;
	Tue, 11 Aug 2026 13:16:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qu7CaLWn";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DCB010E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 13:16:23 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so302908a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2026 06:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786454183; cv=none;
 d=google.com; s=arc-20260327;
 b=fk0EiAb/o2q0zrYVTMpTFpsjhvLy1xMYBhuYNbWkebaG+ecx+Rz1sZn4caAP0tqaX3
 d4RngG5zjK5lYj5pQeoMuRm5COChiJJY2bQ+2I99ZlNZR4eDYRu0cavnlCFRzGCPiPIv
 ezMoiD1vh/FSyJdzqks7jcYW8iYvDBrnV1yA+RePTlFYyxcMuOL812FkokXzhz3c5N4X
 66pM3QUwZQSnO8up4TdR6KHrx6yT5jIC3An886nNUbBz+FSOAibsbJu9eqmhjRiU9zvR
 9ackBQon1jLwmIMBdJQ5k8ybM9RYhMX7LXVzMTv+yuHGp8woLxjZNrR+iTMMgF7HMfsq
 S8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ev6XRcmgwBZsfUeHIalmAmZfaC051dG2iHjaimxcgRY=;
 fh=UXReYgOH978Q8YRGufbWWMgVMgvD+MB3VBXBHmVssj8=;
 b=TMqSRXVlJu03vnZG0l2UlT7F3PUN5u0GmyXz2Cy+QJg5JhfXmZkz9HHhz2sDAjJRdB
 w+QxkpVcXA8F4mmdmd3zf8KjBZnqgyvTqVUb6jmUf3tPMsHGucgZuJkD1JBV6Ec6Eg2x
 ZiqA8sqU2Xl8LzPqf14fkVKu9dPSytuU08zfNkuHHzoUZaieuSNO9KLxo2cQKprYm516
 FM4B8gyob9u/Tbj7PZ+cTIuYax5amiTNRb7LWBJwOhEO6uwZXX3mZC+kmbz1EizWmoBj
 BNJ7/O45uqAKz8HJdUHULP/WRf5Kq2oS6qgLR+B2qbjEo+KWNoOi3GhOJkgt8w5RBOSi
 RFWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786454183; x=1787058983; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ev6XRcmgwBZsfUeHIalmAmZfaC051dG2iHjaimxcgRY=;
 b=Qu7CaLWnoeWUDoAYeGnY7Nfz564QkgZvV4yOIjo5c+rkDVWgL+K9dARv+csNzXqdAI
 bh12npPxtudCNJyDG+UeA6NBA4HXD9Shbfbf11Xp2yE1lpMEpkMSqrpBBsr0dfDzy3d8
 VWzGF1y34IpMUt2kvK/bO07oHvxSvHSAN0V8KUldyFlu47tP4j0wZiHmC1TTIkUlPZNV
 5XpNUPg4wsyHMrSm0e3j61vVgkbzxvJZJxZRrnJGe5SGcOVyBg5OIpo8cDVVxM93D7Uv
 Xm7l8ZrREcxts1iAN6obWpNGZ86Kemn5DYoEhLRymXLqvf/0sMHYJj7a+p1QGPeQYDQn
 KNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786454183; x=1787058983;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ev6XRcmgwBZsfUeHIalmAmZfaC051dG2iHjaimxcgRY=;
 b=dC2yPT8fUmjbYBcDkbNiXHl/x5hPPVivv6HMgL18Z/Ttym3z7xC4Zfw3D3JT8LG53/
 jteaVnBlUMk1zf6/nMWLL4cseoxsQ7lSmc/XLZeglWcYgeDKrAmigsTIA44xIHXpfmLD
 iKrNmOiJ1mpfYH7WrhS7fKmyp0wLdCBxj9FprURfNnC3q0zDUJwtuvV+mi9gg30/T02B
 jVTXCjhcD5skiFHGR3LVRsMKwPkDjyeOs42XB2SwO1/3pJaoqxghw3ZDULDmmGrsDfXh
 YMdCuY+BEFdcT9+bODvSvXfQzxdcgpZXmtz/rkQYhsTETv7voouQvZxzzOTbThVD03Zm
 msIg==
X-Gm-Message-State: AOJu0Yy4DEcA5B6eW347huwFnP4JeTU/qXFTahkbUZnhfYhRqTNXh/Ej
 4Gn98W8l5P2XXH+NCfqGjFdi2QZnt2CPN0mrpLnJrxEcRRJCUsNcNijNdcL4wiBSdha74kFV0YL
 qHTZIVulEnO6HzpfXXByIGf248jOS+Wo=
X-Gm-Gg: AR+sD13zQ1IHbdBaKWO3tkdF2juxkCKur1DKaX5EXVT9mzmi4mDv4Fh9vqgy1vh2Mbg
 f8HDYRnQexAPU3LZ9zRu/W1VUfwAZ8viVObC2wAuTTtpxxjT6jjhX6u8gDvK9GK6qD1+EX0D+qn
 9eYZZjwv6ZssaA5JKqNZn7iKHOY1JUzTzf5zaMs8WHH+tu0u4pVzrLrPG0d0WHqKRvKZGsS8Epe
 0EB/D+LWzzYj9RbuyOkx+NFJpp/4et5H7828C0M+KS/w4CCDOZSG4mPye2ea4JndGSijioHlwEC
 S/TMWoEFXp4L7S5HpOAbvmVZEzx/Q5p0B4+nkMsDkB5AUmJH1awUQlrgZKEFWm7ekBh2bhV6u9k
 NUXnZLPFOUoEERoYj0pNuFIP9nsSwpA==
X-Received: by 2002:a17:90b:394b:b0:390:af7c:fe5e with SMTP id
 98e67ed59e1d1-392ec89db39mr2512614a91.2.1786454182962; Tue, 11 Aug 2026
 06:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260810200401.1203733-1-David.Wu3@amd.com>
In-Reply-To: <20260810200401.1203733-1-David.Wu3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Aug 2026 09:16:09 -0400
X-Gm-Features: AUfX_mxGkx7bWRcy4es-KfcE3G26ET-XTbclVukZkjxUmcrju4MU--sSh-ZF6XY
Message-ID: <CADnq5_O5nEp=WJ+GQ8hMy-bifVMeLh1ar9GhW3aYrV3o3QChgw@mail.gmail.com>
Subject: Re: [PATCH v2] amdgpu/vcn: vcn dec_msg integer overflow fix
To: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, leo.liu@amd.com
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

On Mon, Aug 10, 2026 at 4:40=E2=80=AFPM David (Ming Qiang) Wu <David.Wu3@am=
d.com> wrote:
>
> if supplied msg[2] in the header is too large around
> 0x40000000, 4 times of this unsigned 32 bit value will
> overflow and the test could pass.
>
> v2: using kernel helpers to check the overflow.
>     this needs 2 checks: multiplication and addition
>
> Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v3_0.c
> index 81bba3ec2a93..7a301cfe91ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> @@ -1910,7 +1910,7 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser=
 *p, struct amdgpu_job *job,
>         struct ttm_operation_ctx ctx =3D { false, false };
>         struct amdgpu_device *adev =3D p->adev;
>         struct amdgpu_bo_va_mapping *map;
> -       uint32_t *msg, num_buffers, len_dw;
> +       uint32_t *msg, num_buffers, len_dw, mul, total;
>         struct amdgpu_bo *bo;
>         uint64_t start, end;
>         unsigned int i;
> @@ -1965,7 +1965,9 @@ static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser=
 *p, struct amdgpu_job *job,
>         num_buffers =3D msg[2];
>
>         /* Verify that all indices fit within the claimed length. Each in=
dex is 4 DWORDs */
> -       if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +       if (check_mul_overflow(num_buffers, 4u, &mul) ||
> +           check_add_overflow(6u, mul, &total) ||
> +           total > len_dw) {
>                 DRM_ERROR("VCN message has too many buffers!\n");
>                 r =3D -EINVAL;
>                 goto out;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/=
amdgpu/vcn_v4_0.c
> index 0cce78b205a8..413854fcf84a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
> @@ -1826,7 +1826,7 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser=
 *p, struct amdgpu_job *job,
>         struct ttm_operation_ctx ctx =3D { false, false };
>         struct amdgpu_device *adev =3D p->adev;
>         struct amdgpu_bo_va_mapping *map;
> -       uint32_t *msg, num_buffers, len_dw;
> +       uint32_t *msg, num_buffers, len_dw, mul, total;
>         struct amdgpu_bo *bo;
>         uint64_t start, end;
>         unsigned int i;
> @@ -1881,7 +1881,9 @@ static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser=
 *p, struct amdgpu_job *job,
>         num_buffers =3D msg[2];
>
>         /* Verify that all indices fit within the claimed length. Each in=
dex is 4 DWORDs */
> -       if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
> +       if (check_mul_overflow(num_buffers, 4u, &mul) ||
> +           check_add_overflow(6u, mul, &total) ||
> +           total > len_dw) {
>                 DRM_ERROR("VCN message has too many buffers!\n");
>                 r =3D -EINVAL;
>                 goto out;
> --
> 2.43.0
>
