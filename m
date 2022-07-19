Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE1BC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Jul 2022 19:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B8F111B936;
	Tue, 19 Jul 2022 19:53:04 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09C2711B6CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 19:53:03 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id fy29so28065127ejc.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Jul 2022 12:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xKaj18NiNL3OAzIIlF53H9NSW/7VCa9w2TsLc9Ya6D0=;
 b=ToQoVKO0Bzs4uumr97bboAEWscy6hL4a6itdmVmlUwcKI+ce1HsWn7W2qbbpMU/Irr
 53kcxw+mSX1FIlGXDIyB+2QODAB7BsKJfN6/Ra1OreWXvtgizdRYfyyMnzaBlidqsUCO
 3FcvZEmAzCvRpXy1Pnq/PjR4HHnSHN3fANqjpGm9mW4IVHGBQlY8KjI4EEY85rym3Oua
 uu8hraJFQ4mfIncd1Ca866KP4+S7uaaj3TCKOJMd15qYtTkQKbjbtoYB13HBLHyGbFK+
 uXpeGfuC+aDnxeUrub9xmuMwuxzdsy8RBOmPZTdH4iVf6TroTiB6lbPtB2kNxp9Odi5Y
 ssvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xKaj18NiNL3OAzIIlF53H9NSW/7VCa9w2TsLc9Ya6D0=;
 b=ZFH+vZ8Z9EYX2APrHLTNl5Ajn565UWQaCHNJ7tX8r1/FpGLhARzgsRMWnZZGeg61c8
 mHoUpNh6949OocLaXmFG9eDPMNxyWpJzcbSIjgXdGnVLO0+sIgQ4R5tpkgY4sdSh3MO/
 U4Q42IsFVUTvblI3k/X3WP1/8J4huhM82BB3RlFXeE1biFwydkfGFF2fQO9g372/G2RP
 ZFcOti94+ZYJIA9+mzQ385GUlxGIoIUqkY9oIdLHc4B02LKX0Is3JTMFLo3yQLuS7ACs
 gify7yHKxJlI1JnJ4/rNNYoxG9flh/Xb1SSVjsP5zqzIEkU2L/fcHYj64VuBB5icG/AY
 KsxA==
X-Gm-Message-State: AJIora848nmxMvOF5xOcc4x1/MeJmynouy5IaCgFbiuiztpJLU2/wB+i
 Q85wXaWIRiHGXQhm61kxEsLNqEvw7IBLgfeCEkiMPaly
X-Google-Smtp-Source: AGRyM1uzDwNqyNhwG62b+djHyaMix2JfcGSNmyfBynoQII8bJ4Q3otZgmBFbfDjNkAaKM81Q4SrOAKwNsietVkJ2Ubo=
X-Received: by 2002:a17:907:2cf6:b0:72b:9d9b:2404 with SMTP id
 hz22-20020a1709072cf600b0072b9d9b2404mr31845029ejc.171.1658260381402; Tue, 19
 Jul 2022 12:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220708225549.2061140-1-alexander.deucher@amd.com>
In-Reply-To: <20220708225549.2061140-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 Jul 2022 15:52:50 -0400
Message-ID: <CADnq5_PFtZPHkUWUNa-iBofmZV=dVj4MMuEC8NYkDKMtgen-7g@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: add the IP discovery IP versions for HW
 INFO data
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

Ping on this series.

Alex

On Fri, Jul 8, 2022 at 6:56 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Use the former pad element to store the IP versions from the
> IP discovery table.  This allows userspace to get the IP
> version from the kernel to better align with hardware IP
> versions.
>
> Proposed mesa patch:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/17411/diffs?commit_id=c8a63590dfd0d64e6e6a634dcfed993f135dd075
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 24 ++++++++++++++++++++++++
>  include/uapi/drm/amdgpu_drm.h           |  3 ++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 4b44a4bc2fb3..7e03f3719d11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -473,6 +473,30 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
>
>         result->hw_ip_version_major = adev->ip_blocks[i].version->major;
>         result->hw_ip_version_minor = adev->ip_blocks[i].version->minor;
> +
> +       if (adev->asic_type >= CHIP_VEGA10) {
> +               switch (type) {
> +               case AMD_IP_BLOCK_TYPE_GFX:
> +                       result->ip_discovery_version = adev->ip_versions[GC_HWIP][0];
> +                       break;
> +               case AMD_IP_BLOCK_TYPE_SDMA:
> +                       result->ip_discovery_version = adev->ip_versions[SDMA0_HWIP][0];
> +                       break;
> +               case AMD_IP_BLOCK_TYPE_UVD:
> +               case AMD_IP_BLOCK_TYPE_VCN:
> +               case AMD_IP_BLOCK_TYPE_JPEG:
> +                       result->ip_discovery_version = adev->ip_versions[UVD_HWIP][0];
> +                       break;
> +               case AMD_IP_BLOCK_TYPE_VCE:
> +                       result->ip_discovery_version = adev->ip_versions[VCE_HWIP][0];
> +                       break;
> +               default:
> +                       result->ip_discovery_version = 0;
> +                       break;
> +               }
> +       } else {
> +               result->ip_discovery_version = 0;
> +       }
>         result->capabilities_flags = 0;
>         result->available_rings = (1 << num_rings) - 1;
>         result->ib_start_alignment = ib_start_alignment;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
> index 18d3246d636e..3a2674b4a2d9 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -1093,7 +1093,8 @@ struct drm_amdgpu_info_hw_ip {
>         __u32  ib_size_alignment;
>         /** Bitmask of available rings. Bit 0 means ring 0, etc. */
>         __u32  available_rings;
> -       __u32  _pad;
> +       /** version info: bits 23:16 major, 15:8 minor, 7:0 revision */
> +       __u32  ip_discovery_version;
>  };
>
>  struct drm_amdgpu_info_num_handles {
> --
> 2.35.3
>
