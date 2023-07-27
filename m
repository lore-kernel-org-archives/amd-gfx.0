Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB27C001DC
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 19:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31CD110E5E6;
	Thu, 27 Jul 2023 19:10:06 +0000 (UTC)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC50510E5E6
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 19:10:03 +0000 (UTC)
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-1bb58b4c513so1019760fac.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 12:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690485003; x=1691089803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ErwObnQuCNnT//P2W8vtReez85NCU2L6VoB+u/V1RFI=;
 b=m/QPAvKLZWCaWoMgOep/C4jOD5Fy9NqNlEOPnbQmg/RwdGB4Z69uOmCBMLtCqvil8C
 L8sU80ipmfToBnxmrHjN1JUsB3ybzRiT/YaFRIgXed1I93zN/0UtCWr3cCPfJiaSexdi
 lF/m5YwSN53OsTmH+OL3l3H1RZHWrvLLl6CC9nlPVj8W3fX2x2jS5zmZVJdJnHgyenO7
 lpz7oX3ac8N3c3yU+Kj8EZeTiEghnv9/5UJSj26/XcN7SV+MryzzhixeCqyBSFM1D/o2
 p9e397MbrSi22GmzwCMWYSvzz7bBJqk2mRlgmSrLQBGvPotJjjVYIMKZyNHu42JbTfhJ
 aExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690485003; x=1691089803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ErwObnQuCNnT//P2W8vtReez85NCU2L6VoB+u/V1RFI=;
 b=GYhmgnlPpIvH75oj5Nk4Fzv6z1UNnhybGog+m4iZjoERSdwLTIa5FKoMXRUba1Y778
 hFaOSz4MupMA8F7LNOUpscNl9x4WxrMfBp9mnowdJmIJXUohoBRQXz9BRQFK9Ewxwv/d
 wYPRw060EGw7TSTXSJQFXYKFB8kOY39dwVeuTg5n2Gj9iyd8pUu1GuccfRV8PebRCYBL
 3CYA/4p1n/uWQkd8pXM71R4loRGb0E55nBjR7nkLuWzYaFo/U8GidSCUKc4bQujrGB2n
 ZCXqi2brovOM5+dimyq171zqEQZ56Qhx/5u58zAvshL+3p2PmyilyAorQQ7eUvP+h8TV
 RPgg==
X-Gm-Message-State: ABy/qLamUvEwD8esp0Y70igvA1pi88xKDGqOdTBpF6tdmPYVPhkyq4Mr
 26tq3WyJuZZNEGYRqH/kg/yCv/d9h2FKYtfLkMA=
X-Google-Smtp-Source: APBJJlHpp+osTaR4QLkcegdvYsSFKuzhU9rMSHx2/NaQq69YZU+aUgBG58jxN6KcU+7Yy97Z1F2EQrxeE8acdKYLKP0=
X-Received: by 2002:a05:6870:1fd0:b0:1b0:67a9:3092 with SMTP id
 gp16-20020a0568701fd000b001b067a93092mr359297oac.42.1690485003005; Thu, 27
 Jul 2023 12:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183630.17043-1-mario.limonciello@amd.com>
In-Reply-To: <20230727183630.17043-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Jul 2023 15:09:51 -0400
Message-ID: <CADnq5_NEFxz7Y0=XvY_BfViBWMj51EL0-ZFptXZa1ib+t3umXg@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amd: Disable S/G for APUs when 64GB or more host
 memory
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: roman.li@amd.com, amd-gfx@lists.freedesktop.org, Hamza.Mahfooz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 27, 2023 at 2:37=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Users report a white flickering screen on multiple systems that
> is tied to having 64GB or more memory.  When S/G is enabled pages
> will get pinned to both VRAM carve out and system RAM leading to
> this.
>
> Until it can be fixed properly, disable S/G when 64GB of memory or
> more is detected.  This will force pages to be pinned into VRAM.
> This should fix white screen flickers but if VRAM pressure is
> encountered may lead to black screens.  It's a trade-off for now.
>
> Fixes: 81d0bcf990093 ("drm/amdgpu: make display pinning more flexible (v2=
)")
> Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Cc: <stable@vger.kernel.org> # 6.1.y: bf0207e172703 ("drm/amdgpu: add S/G=
 display parameter")
> Cc: <stable@vger.kernel.org> # 6.4.y
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2735
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2->v3:
>  * Account for the VRAM carveout
> v1->v2:
>  * Fix updating mode_info as well
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 26 +++++++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++--
>  3 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index 93d0f4c7b560e..2e3c7c15cb8e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1313,6 +1313,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device =
*adev,
>  void amdgpu_device_pci_config_reset(struct amdgpu_device *adev);
>  int amdgpu_device_pci_reset(struct amdgpu_device *adev);
>  bool amdgpu_device_need_post(struct amdgpu_device *adev);
> +bool amdgpu_sg_display_supported(struct amdgpu_device *adev);
>  bool amdgpu_device_pcie_dynamic_switching_supported(void);
>  bool amdgpu_device_should_use_aspm(struct amdgpu_device *adev);
>  bool amdgpu_device_aspm_support_quirk(void);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index dc0e5227119b1..0d602abd32bad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1296,6 +1296,32 @@ bool amdgpu_device_need_post(struct amdgpu_device =
*adev)
>         return true;
>  }
>
> +/*
> + * On APUs with >=3D 64GB white flickering has been observed w/ SG enabl=
ed.
> + * Disable S/G on such systems until we have a proper fix.
> + * https://gitlab.freedesktop.org/drm/amd/-/issues/2354
> + * https://gitlab.freedesktop.org/drm/amd/-/issues/2735
> + */
> +bool amdgpu_sg_display_supported(struct amdgpu_device *adev)
> +{
> +       switch (amdgpu_sg_display) {
> +       case -1:
> +               break;
> +       case 0:
> +               return false;
> +       case 1:
> +               return true;
> +       default:
> +               return false;
> +       }
> +       if ((totalram_pages() << (PAGE_SHIFT - 10)) +
> +           (adev->gmc.real_vram_size / 1024) >=3D 64000000) {
> +               DRM_WARN("Disabling S/G due to >=3D64GB RAM\n");
> +               return false;
> +       }
> +       return true;
> +}
> +
>  /*
>   * Intel hosts such as Raptor Lake and Sapphire Rapids don't support dyn=
amic
>   * speed switching. Until we have confirmation from Intel that a specifi=
c host
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 77d970a2ee693..26c3eb7a9f882 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1639,9 +1639,8 @@ static int amdgpu_dm_init(struct amdgpu_device *ade=
v)
>                 }
>                 break;
>         }
> -       if (init_data.flags.gpu_vm_support &&
> -           (amdgpu_sg_display =3D=3D 0))
> -               init_data.flags.gpu_vm_support =3D false;
> +       if (init_data.flags.gpu_vm_support)
> +               init_data.flags.gpu_vm_support =3D amdgpu_sg_display_supp=
orted(adev);
>
>         if (init_data.flags.gpu_vm_support)
>                 adev->mode_info.gpu_vm_support =3D true;
> --
> 2.25.1
>
