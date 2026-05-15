Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0DFCD4851
	for <amd-gfx@archiver.kernel.org>; Fri, 15 May 2026 22:02:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E45A10F635;
	Fri, 15 May 2026 22:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YH+ihS6v";
	dkim-atps=neutral
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE1AB10F61D
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 22:02:08 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-56d90654608so24116e0c.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 May 2026 15:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778882528; cv=none;
 d=google.com; s=arc-20240605;
 b=VPRatgSoadNIqxVpNQp09QuiYsSVA3uSTeqhceAXe3d8E5IkJOa3gxntzc4VGO/Psb
 2whNHE+/Vf/nQ3cM2LCFzMoDS90jBIVhXfV2jMueLNmK5NWs5lUv1E7HsWK+CIH5HFiL
 k/2gPWPfwak0mChZM3/KoD2PWdTThL8pAO21L+9/WroYmWxGvCoP8ar7GsBcjz7JP7bU
 v8aq+Wd+xstAJMb4yyLGbgBQISH8eXvjypwhADw7IjytHgjxy/YC/Yb90SXHywGRvcII
 +shsBS970QNdM3UPEbcN8Xsv4JlTM3JOEmx59VKSA8abqdcBhDMllGPRITVvBs8P8P4O
 jPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=eBR53BbOgZTmuDwtp4Typ0cSR31FzCx3/5xraAvMA14=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=CBzTImfmoBmJQeS8F0GEmbWHoTA9XEOdboh3ZytZ/32OM5k7GW6BZ97UCvW55CIE/2
 NTFmkegH5xLE8APJarl/AvYDdQ2ildVEimjnT06FbwyGZW1TioF52M9IWJXuFWNchds0
 CiPJANEVXpuEigM7m5l8Ca5WcGDde5so9j/r/uLcuQ9t5vBLdicegTStNfSZUXwCWJcg
 gyNMnbDWnRueizfy+dom4oyzJQeIbrsKl5dRkR3Rcy26KCutfmQWgGE3gGIyPRlIb5VP
 1fP2evTgCc/r8XLblrtDsXbotLs0OIyeGZ4Ui3IXOfT+/LEhPUCoSrdInURSm7NBJdP9
 Gs6Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778882528; x=1779487328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBR53BbOgZTmuDwtp4Typ0cSR31FzCx3/5xraAvMA14=;
 b=YH+ihS6vfsOHyEJv2TSSQenGJ0PWrZ/nWu5buZy/WeS/Z1QHi/PLsF6Y1ByQACZ5wj
 BjINLqFafu0ETQKDE1mK3jM+XVmacRdAL7h8zMpBtzyBvVXqeseOdjospt8rAnKtzXFc
 +571ZCPDI756/3usMKiTcyVHgYlRvZa0ij69BDOu3q986ZBq7+8fsbGIiBvnsSN6vgWd
 x1geniW3TGvPmo5uxmUqWlOPO+KhW6/C8iqGGiC4KEr9dgQA5o9Tex4AlwfC/K+Tauuv
 68P9CW8Td4NA/cXmZGTK5I1KfECUkGlZf8BA61IVNZZPwomFFCqoaYIj74LaO8lVQuYd
 LTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778882528; x=1779487328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eBR53BbOgZTmuDwtp4Typ0cSR31FzCx3/5xraAvMA14=;
 b=FBs5tiHuwGzmT8QnXMIcdIRJ2YLiUFSk7wnZSRePa7JCPnuP/4WivhLw3zldtgfVGz
 wxVl8Xw55fDMkhyGyWy6mcnZmP+OUwHhgHn2BbiRGdDqS6i3P9bvOjGTuj1SZgsiccUs
 BwEnAELsvW8P+LR3LWA5T7ZhONONiQPUzfiUOkiWO05c4E22jzI3qWEsctQOYcedNDpb
 C0q626RZ3SNfjdGi2WLE0ARbQg3qLRx5DUY4Sf9kG6UneMZnPxIekOfeDtBfFo301Bnl
 uPey9sWRpuaSoykAhkYjgotUVZjAYiNFF0ZiZxA5NGTm33hNScGB+34nLBbgbheurCP6
 uBxg==
X-Gm-Message-State: AOJu0YyE7Yb+pxPb36s4pZ1LIjkQS58jmxE7smZ/ELml68bDFfRcL2XT
 el6LtJM+/UPFBkJLulND3hQBnQQuq4bkodlimuG8SjGQzKPjZj6qvZoQ5U9WDup9F1vjqp9lyJX
 5/14HBY2K2j/JCALAWoX+ID2TV+aOYP8=
X-Gm-Gg: Acq92OGe2sooxUW22mU1VuRhBR0Pyp16G8D4RGS+XcLjs5bD7Tuh/6Dv4cO/sVRY1zz
 h1Bx+awzG6qk2qckzkQ71aDB7odo7FQl5mP8dOtsiHwSFDwsgQo7Vh0DvL/hT2mP1O1D9eKmUm0
 9Ip5aUhA9rkj0nL95IwP+vBMCmQ2AhctJqKz6hilf/WtQ94oYIXqCxuFDUKoe+pOp2J9QZDnadX
 BfjrptAqAoqGccO60Q74AQLwz7Dize+b+FlVu7BTozDz+wfF8s6tlpSvOmzzMJMV91/IDq9EZkp
 wLCGAQbvEI2TdvsLkwyQFPz2bSUtG7SsQDvF4FCfU8AxflEexd2VDRhKhWvWzxQT6XM1PkvBIXk
 5h6Xl
X-Received: by 2002:a05:6122:d84:b0:575:35f9:66b7 with SMTP id
 71dfb90a1353d-5760c062799mr1736022e0c.3.1778882527559; Fri, 15 May 2026
 15:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260515203057.134339-1-mario.limonciello@amd.com>
In-Reply-To: <20260515203057.134339-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 May 2026 18:01:55 -0400
X-Gm-Features: AVHnY4K4WNcbkE1ZyVDW5jIASVm1heXM0QFBr7jWmBm-1LLeq7xzIqXegWhT2mE
Message-ID: <CADnq5_OcR92aLNWE4KzHgmow3V3znfT5xmK5EOzNY5ASMKZgag@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Reduce code duplication in runtime PM
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, May 15, 2026 at 5:49=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> [Why]
> amdgpu_pmops_runtime_suspend() runs almost the same code  that
> amdgpu_pmops_runtime_idle() runs. That is there is pointless code
> duplication.
>
> [How]
> Move amdgpu_pmops_runtime_idle() up, extract common code and then
> call from both functions.  No intended functional changes.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 50 ++++++++++++-------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b422513fe3793..15a2dddede2a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2797,12 +2797,11 @@ static int amdgpu_runtime_idle_check_userq(struct=
 device *dev)
>         return xa_empty(&adev->userq_doorbell_xa) ? 0 : -EBUSY;
>  }
>
> -static int amdgpu_pmops_runtime_suspend(struct device *dev)
> +static int amdgpu_pmops_runtime_checks(struct device *dev)
>  {
> -       struct pci_dev *pdev =3D to_pci_dev(dev);
> -       struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
> +       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
>         struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> -       int ret, i;
> +       int ret;
>
>         if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE) {
>                 pm_runtime_forbid(dev);
> @@ -2812,7 +2811,27 @@ static int amdgpu_pmops_runtime_suspend(struct dev=
ice *dev)
>         ret =3D amdgpu_runtime_idle_check_display(dev);
>         if (ret)
>                 return ret;
> -       ret =3D amdgpu_runtime_idle_check_userq(dev);
> +
> +       return amdgpu_runtime_idle_check_userq(dev);
> +}
> +
> +static int amdgpu_pmops_runtime_idle(struct device *dev)
> +{
> +       int ret;
> +
> +       ret =3D amdgpu_pmops_runtime_checks(dev);
> +       pm_runtime_autosuspend(dev);
> +       return ret;
> +}
> +
> +static int amdgpu_pmops_runtime_suspend(struct device *dev)
> +{
> +       struct pci_dev *pdev =3D to_pci_dev(dev);
> +       struct drm_device *drm_dev =3D pci_get_drvdata(pdev);
> +       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> +       int ret, i;
> +
> +       ret =3D amdgpu_pmops_runtime_checks(dev);
>         if (ret)
>                 return ret;
>
> @@ -2924,27 +2943,6 @@ static int amdgpu_pmops_runtime_resume(struct devi=
ce *dev)
>         return 0;
>  }
>
> -static int amdgpu_pmops_runtime_idle(struct device *dev)
> -{
> -       struct drm_device *drm_dev =3D dev_get_drvdata(dev);
> -       struct amdgpu_device *adev =3D drm_to_adev(drm_dev);
> -       int ret;
> -
> -       if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE) {
> -               pm_runtime_forbid(dev);
> -               return -EBUSY;
> -       }
> -
> -       ret =3D amdgpu_runtime_idle_check_display(dev);
> -       if (ret)
> -               goto done;
> -
> -       ret =3D amdgpu_runtime_idle_check_userq(dev);
> -done:
> -       pm_runtime_autosuspend(dev);
> -       return ret;
> -}
> -
>  static int amdgpu_drm_release(struct inode *inode, struct file *filp)
>  {
>         struct drm_file *file_priv =3D filp->private_data;
> --
> 2.43.0
>
