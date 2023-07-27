Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360A4C00528
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jul 2023 18:02:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12A610E5D9;
	Thu, 27 Jul 2023 18:02:30 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B1F510E5D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 18:02:28 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-565a8d74daeso760076eaf.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jul 2023 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690480947; x=1691085747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uciLMjWxRGQ4hsAralhUZgwU70hmgX933XcfCJy/huk=;
 b=U7W79ZK5BF23xfAWERLfFnzJfPnlJi+1+7rBwNanJSz2efE7XgtYfoXAyn4L21VKQF
 PS1AMSvf19maNuUnszfc60RuXhulCN8kvkzyGGwZDp4qI6puuNlYGhMXJxgMwIi65ZoV
 Ipid3m5tV8y7UcMi3UW6yvG3hiOupVSDMhUMBVUFoChOGgGdI9uqI3UIGWK+hoP9+0v4
 xV/DlXrcIz6q0oMpnMu0YVg45QjYYYDs351gyQpJB42JP6Wb81po/QMbSvHqt2ZCu2Wm
 gCTVjUDcee0yjJ8uIuXwBtgNKupAYSNSIsnJaiGilVD4nsmJJBbEnI4FqLAHRtaywyrT
 jc0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690480947; x=1691085747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uciLMjWxRGQ4hsAralhUZgwU70hmgX933XcfCJy/huk=;
 b=AI9M8izn9LjWJoJg7iyzMuK97k3fl0oj5H5xR2DiNNTvBNflIBJzyJ0o+Bc1yPNVAK
 3Dgv6AJFCijBm2lsaGdcac3+fMbAI7+wsqy2C61GEBwPWS7SavDvs/HVICRP5kurZ1pr
 5Xb121EuqDG/qUotpgMUoqFBuZRpqUKhTCV1/2HKuTJ7XTQ9YU4Ljr/srV50iHeDY9St
 Lgf5xSkOAm3tDSly/ZNhV1n3zPfmUXy5HJWEe71IcE+5+ZVW9Lb7bXUfT990DV8HCq1r
 2sHobUXybSjwLz7IScoj3VRmchaxwdqxsz9OmWPLZuAC1ZqfgUkSPJO7ke2TJEF4CdK0
 dzjQ==
X-Gm-Message-State: ABy/qLbQi9iCAhf68/Rpg/eEc0bq9JZ2P7xkK2LQ1mtGGAB7HZgKKQFB
 3lE24RQf3lHPzKJpnsgbE2wQ1/LIP5iHjLAOuu5CB9vZRe0=
X-Google-Smtp-Source: APBJJlEnYE7fiQPBQ9nbg6byQxQjtXQ7b11gPwwomoF1WfAQRKctixYEgcjoUzy/tS+qL9j62PhFFXY5ZyMzk5Deq4A=
X-Received: by 2002:a4a:e791:0:b0:569:aaaf:ed1c with SMTP id
 x17-20020a4ae791000000b00569aaafed1cmr2909163oov.2.1690480947240; Thu, 27 Jul
 2023 11:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230727172857.12780-1-mario.limonciello@amd.com>
In-Reply-To: <20230727172857.12780-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Jul 2023 14:02:16 -0400
Message-ID: <CADnq5_OJ86xy3LOJo44tCWGWsGGAPc87epc3gSpkpbQefYKi5A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd: Disable S/G for APUs when 64GB or more host
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

On Thu, Jul 27, 2023 at 1:29=E2=80=AFPM Mario Limonciello
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
> ---
> v1->v2:
>  * Fix updating mode_info as well
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 25 +++++++++++++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 ++--
>  3 files changed, 28 insertions(+), 3 deletions(-)
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
> index dc0e5227119b1..a4e36b178d86c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1296,6 +1296,31 @@ bool amdgpu_device_need_post(struct amdgpu_device =
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
> +       if (totalram_pages() << (PAGE_SHIFT - 10) >=3D 64000000) {

Does totalram_pages() return the amount of physical ram or the amount
of usable ram (i.e., minus carveout, firmware reservations, etc.)?
Assuming it does the right thing here:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


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
