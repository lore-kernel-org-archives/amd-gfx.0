Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184B4C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 21:18:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C3110E1FA;
	Fri, 14 Apr 2023 21:18:07 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583B110E1FA
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 21:18:06 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-187bee46f9dso1869389fac.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 14:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1681507085; x=1684099085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+YIHToLKUiGMZSB+fx8qS+hpAOSKjSFHyLyyG/5RRQ=;
 b=jQWoHbsTfUJ/txoAmeAJYtAe3oUsmZNOYO4Daj4l+toN6zXQkATF3g3Wuj8J8/Gva7
 YZlf5/cpsmhAfcYCPDKzj/AcBOmOGURPEH70uuZqTlu4FAwvFl0ECgv1o0+J5qvxYp1V
 aocRW3saBUpkR6ajxJnlhQ142/SHETA7XlDbeMe10AYb46dqSOOKnUP7QemvdMHE2y30
 DeCOCscLMX5Lrm1v93liK5gthsLMoI8dR5rzcTGy+xnQUcEwBBfJhZGO6KcgGYZ5Oxoc
 LgnmEtz7R/6W7b/CvkyyfbtcHT6vGPmDyhWaK1AWeJt479EIk5c/DEex1SOwmPaEmWpn
 hMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681507085; x=1684099085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+YIHToLKUiGMZSB+fx8qS+hpAOSKjSFHyLyyG/5RRQ=;
 b=LdDvk0uMufTAN9XSmdUVEWZYy0GkjmOLjdbNBdBZNjmGNaHyYDv9mTPe/qMTngDQcm
 rXIFFmLWQMYAmFLgB7jIy8xDiULZ3l86tJHcDw/DrtLzbz7VQFasWHcma0e35CL/dCms
 GQ6kHRL+7eUBhtcw3QFVJ3TMl6EMCPoKzUw7kY15LM/5Ig8jl7bNFvMMm2P8goWHitnq
 69FSDGDj/PU6mSFUSwIINcRy7bJNIa5JJJF0CB+g2LWNNIN8/QITrG2aQfVb4iwGVdTk
 Dp7eq7YXnxaXhI40cVOO5p4xw8uceAuKPBY7XpSMmZQquetqCPtB90sB8APFY1Zs0EGm
 C/+w==
X-Gm-Message-State: AAQBX9dK6IUTqvk3vMN1iJhYCibUC8EJvWVGsjxEQk9kfZmZgQMdOHUn
 Cxd++Sajfm6keYwTsAejgpxzMgetbVAZCEHEWRw=
X-Google-Smtp-Source: AKy350Z5mlLzFRFPpJDilBwWprwDCd3+6HUChuL8vHBqwST4t8T8y9Ik7MX+HF0Zmc/NtzYFlH7SvJQIagx8U50+LaY=
X-Received: by 2002:a05:6870:b52c:b0:187:a080:bfd5 with SMTP id
 v44-20020a056870b52c00b00187a080bfd5mr2126197oap.3.1681507085007; Fri, 14 Apr
 2023 14:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230413142253.414333-1-bas@basnieuwenhuizen.nl>
 <20230413142253.414333-3-bas@basnieuwenhuizen.nl>
In-Reply-To: <20230413142253.414333-3-bas@basnieuwenhuizen.nl>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Apr 2023 17:17:53 -0400
Message-ID: <CADnq5_OAxFO0_7ZzkC5xoLHUzbjmv7+V37TrWUnadApv7GgOEQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] drm/amdgpu: Add support for querying the max ibs
 in a submission. (v3)
To: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
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
Cc: alexander.deucher@amd.com, maraeo@gmail.com, christian.koenig@amd.com,
 amd-gfx@lists.freedesktop.org, timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Apr 13, 2023 at 10:25=E2=80=AFAM Bas Nieuwenhuizen
<bas@basnieuwenhuizen.nl> wrote:
>
> This info would be used by radv to figure out when we need to
> split a submission into multiple submissions. radv currently has
> a limit of 192 which seems to work for most gfx submissions, but
> is way too high for e.g. compute or sdma.
>
> Userspace is available at
> https://gitlab.freedesktop.org/bnieuwenhuizen/mesa/-/commits/ib-rejection=
-v3
>
> v3: Completely rewrote based on suggestion of making it a separate query.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2498
> Signed-off-by: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>

Maybe a 4th patch to bump the driver version?

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 9 +++++++++
>  include/uapi/drm/amdgpu_drm.h           | 2 ++
>  2 files changed, 11 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 0efb38539d70..1a2e342af1c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1140,6 +1140,15 @@ int amdgpu_info_ioctl(struct drm_device *dev, void=
 *data, struct drm_file *filp)
>                 kfree(caps);
>                 return r;
>         }
> +       case AMDGPU_INFO_MAX_IBS: {
> +               uint32_t max_ibs[AMDGPU_HW_IP_NUM];
> +
> +               for (i =3D 0; i < AMDGPU_HW_IP_NUM; ++i)
> +                       max_ibs[i] =3D amdgpu_ring_max_ibs(i);
> +
> +               return copy_to_user(out, max_ibs,
> +                                   min((size_t)size, sizeof(max_ibs))) ?=
 -EFAULT : 0;
> +       }
>         default:
>                 DRM_DEBUG_KMS("Invalid request %d\n", info->query);
>                 return -EINVAL;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index b6eb90df5d05..6981e59a9401 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -876,6 +876,8 @@ struct drm_amdgpu_cs_chunk_data {
>         #define AMDGPU_INFO_VIDEO_CAPS_DECODE           0
>         /* Subquery id: Encode */
>         #define AMDGPU_INFO_VIDEO_CAPS_ENCODE           1
> +/* Query the max number of IBs per gang per submission */
> +#define AMDGPU_INFO_MAX_IBS                    0x22
>
>  #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT 0
>  #define AMDGPU_INFO_MMR_SE_INDEX_MASK  0xff
> --
> 2.40.0
>
