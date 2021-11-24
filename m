Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32DEC433FE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Nov 2021 14:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F233B6E850;
	Wed, 24 Nov 2021 14:12:49 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BBE56E500
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 14:12:48 +0000 (UTC)
Received: by mail-oi1-x22c.google.com with SMTP id m6so5621434oim.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Nov 2021 06:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K0TpYg38AlaVipZ1l9m5zTwDqsnVkJrrDMLbgASmEHI=;
 b=aH1eRDgfxuzThKVVNiC+YjE3jaehMTRqn4PxmDPp/Uff1F2bFn9gjBr/QcRXXn9kzM
 vLC9vSlrfBJCne4VoTm6C3C4Co9hR/GQnNWVHRV9nweSxDXrE1arbPfb9UB7LyvfY2Z7
 8eksBuvAL6otk04COqntAjRx6/2SaNuMF8QZw/KNzSXG5Epqv5SbGaPxVrzp89ii8VkB
 gXAd+pnuQSyzO2LWmKvW0YLtOwdTIHcw3kQzvJFXineU7INyfqbGRCz4b2HZp16Heolg
 Xa/sjcCFbK+pBHTAHGXUwn1fvVoezNs8VM3KeMoljcjmlTvt6xSeOjzlJa2VTftdsyZf
 EcBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K0TpYg38AlaVipZ1l9m5zTwDqsnVkJrrDMLbgASmEHI=;
 b=I+cU0oK0l47QDgE4HRj4gJqvVB1s5ZEjVtxxX1TfGipCwJycoywjcXgs/46weeaVVC
 wsLidw5D59gJ66AJ338nSr1TKHoCaohhJL/lTB+4HDqr9exzpMA/LncjHMXVnmXZTtfC
 NQ2pXz+Dsd5ZURFqhi4KbJkVGFcFkRocsRIeNOBijD5BTZxGN+T2Y95jJBkB+nuAENxt
 30QYB2PDkdiA2qmWG4PD8uVnmGjEDnoZE67By8TMNkdLTS1GYpiIYq4Espfx7kAIBpdU
 GLQhIhPyvX9yWBa5uCRErHgzbX/hbqaeLD8LxFnIhX6kRLIaeDh8L1HNUcBYezRKr2zA
 B9ug==
X-Gm-Message-State: AOAM530/ekvNxENvmU/m3zp+hJwIScOa4abADHDSB76Ij9I2bYOSPTAn
 JUz/qiM2ofnQbMlept9W2RYo/rK0Pj8NnjM9x+KujIL4
X-Google-Smtp-Source: ABdhPJxYSnoYPgPfhmUHDdxvmy6B9+RHd8xm9VxTimYk9ZtyamX+1s/1L3Zbr6Eie4TOKheINF9el1oituxlBIyOcgk=
X-Received: by 2002:a05:6808:300b:: with SMTP id
 ay11mr6370739oib.120.1637763167791; 
 Wed, 24 Nov 2021 06:12:47 -0800 (PST)
MIME-Version: 1.0
References: <20211124095415.11379-1-Jane.Jian@amd.com>
In-Reply-To: <20211124095415.11379-1-Jane.Jian@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Nov 2021 09:12:36 -0500
Message-ID: <CADnq5_M7E13CWGpGOCk0NFSufeVv-nFH1pWUBdNwft8og0DvNw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sriov/vcn: skip ip revision check case to ip
 init for SIENNA_CICHLID
To: Jane Jian <Jane.Jian@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Jingwen Chen <jingwen.chen2@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 24, 2021 at 4:54 AM Jane Jian <Jane.Jian@amd.com> wrote:
>
> [WHY]
> for sriov odd# vf will modify vcn0 engine ip revision(due to multimedia bandwidth feature),
> which will be mismatched with original vcn0 revision
>
> [HOW]
> add new version check for vcn0 disabled revision
>
> Signed-off-by: Jane Jian <Jane.Jian@amd.com>
> Change-Id: I1ace32acbf3a13c0baac958508da1324ec387a58
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c       | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 503995c7ff6c..1dabbcbc3970 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -925,6 +925,9 @@ static int amdgpu_discovery_set_mm_ip_blocks(struct amdgpu_device *adev)
>                 case IP_VERSION(3, 0, 33):
>                         amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
>                         break;
> +               case IP_VERSION(3, 0, 192):

You can probably just add this case to the above 3.0.33 case.

> +                       amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
> +                       break;
>                 default:
>                         dev_err(adev->dev,
>                                 "Failed to add vcn/jpeg ip block(UVD_HWIP:0x%x)\n",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> index 4f7c70845785..27125e5e3092 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
> @@ -143,6 +143,10 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>                     (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG))
>                         adev->vcn.indirect_sram = true;
>                 break;
> +       case IP_VERSION(3, 0, 192):
> +               if (amdgpu_sriov_vf(adev))

I think you can skip the sr-iov check here.

> +                       fw_name = FIRMWARE_SIENNA_CICHLID;
> +               break;
>         case IP_VERSION(3, 0, 2):
>                 fw_name = FIRMWARE_VANGOGH;
>                 break;
> --
> 2.17.1
>
