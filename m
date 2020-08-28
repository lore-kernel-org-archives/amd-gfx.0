Return-Path: <SRS0=kQKQ=CG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BA9C433E6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A373B2075B
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2020 19:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWZVq0aW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A373B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 716856E51B;
	Fri, 28 Aug 2020 19:30:23 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A086E51B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 19:30:21 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id h15so152822wrt.12
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2020 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GZV0tIKfQFNegtCv2y9HOZHJyYQLk5jqr3tSuW3LSAU=;
 b=CWZVq0aWLBfuO00qQp/vKPqZh7BcKd07+VObw6/FSd8gNoLTcKIcY32dHWfoB+Uua1
 WPrP+cKpMMK0Q5HGULLWSQklL2da2Oy+O5iswUSJoXM/v9eWPQUUhaurnpJbEaeJAhRP
 lfYYN3tCX5SNcKymL7AMb/xTSoFqduXcFMwjSxYzmvTmZ3KvuS2HKKru0C/rY2Pq45Yt
 RiSjSqrWYQUqVxOLcoXz1qNdB+BeKnuUhgiV49LA+U8m4PeVvAezo88G9Vksyy1uVVYI
 aLtFb2VcVO1ipf0Gx8EXxtM69Lzuucb1xZGZgv9MyOOuX+7PcRM7WuQ1BbUxFj2kafOb
 Y9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GZV0tIKfQFNegtCv2y9HOZHJyYQLk5jqr3tSuW3LSAU=;
 b=l8X0L7NWpG492Y0CI846mHj8taIYUhvDGQOG1q9R9iu6rXvWKoYlhWeHyx4AGOCQV/
 5BDQVaTMIEREp91VJiX4dOmGbiY9VwNzUbyM1z05UZwtUmegoKB2xmwZZKo7G42SAXgg
 q7VDByCugF7iIHUp/gpibZDyd7oYdDGiBqm1JorNTsTb7LG7sPgSEp+ZovqwBkPuE0Kh
 8g70Ajdk+mM/JQk8BJrlbpbIzcMx+nDFt8G1XCIM6fNgIJxvOLqVh6nefYWMMvwtZNuH
 07TWcY69SAe8Vowpa0PXPLaugq858pk14H8aqGIh6E9dN4DVcXLzc8XMTH9USz+0qSk6
 +z+g==
X-Gm-Message-State: AOAM531Jv78SPMnXJd5CFMYG/F3CZKG35YzbZEi5NBw+R1s+qZyUWDvB
 nNDfozv9NI2r0VGbgIcx+6bZ7tAbt8aEVDIpTQU=
X-Google-Smtp-Source: ABdhPJyCv5vzpclbrWSPmup47Cx+UP9NbiPOnFliy3o2oPX15tbS41cmT29kOZsvbq2voYshYZkQQFixc/XGwByAIdc=
X-Received: by 2002:a5d:494b:: with SMTP id r11mr426015wrs.419.1598643020527; 
 Fri, 28 Aug 2020 12:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <1598630743-21155-1-git-send-email-andrey.grodzovsky@amd.com>
 <1598630743-21155-7-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1598630743-21155-7-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2020 15:30:09 -0400
Message-ID: <CADnq5_MK21+CF-WZWz7iN5St8ksNEdhdfL82XggV8Zw1N_LtGA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] drm/amdgpu: Trim amdgpu_pci_slot_reset by reusing
 code.
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Nirmoy <nirmodas@amd.com>,
 Christian Koenig <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 28, 2020 at 12:06 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Reuse exsisting functions from GPU recovery to avoid code
> duplications.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 75 ++++++------------------------
>  1 file changed, 14 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 7f1b970..429167b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4115,7 +4115,8 @@ static int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>
>  static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>                                struct list_head *device_list_handle,
> -                              bool *need_full_reset_arg)
> +                              bool *need_full_reset_arg,
> +                              bool skip_hw_reset)
>  {
>         struct amdgpu_device *tmp_adev = NULL;
>         bool need_full_reset = *need_full_reset_arg, vram_lost = false;
> @@ -4125,7 +4126,7 @@ static int amdgpu_do_asic_reset(struct amdgpu_hive_info *hive,
>          * ASIC reset has to be done on all HGMI hive nodes ASAP
>          * to allow proper links negotiation in FW (within 1 sec)
>          */
> -       if (need_full_reset) {
> +       if (!skip_hw_reset && need_full_reset) {
>                 list_for_each_entry(tmp_adev, device_list_handle, gmc.xgmi.head) {
>                         /* For XGMI run all resets in parallel to speed up the process */
>                         if (tmp_adev->gmc.xgmi.num_physical_nodes > 1) {
> @@ -4521,7 +4522,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>                 if (r)
>                         adev->asic_reset_res = r;
>         } else {
> -               r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset);
> +               r  = amdgpu_do_asic_reset(hive, device_list_handle, &need_full_reset, false);
>                 if (r && r == -EAGAIN)
>                         goto retry;
>         }
> @@ -4850,14 +4851,19 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>         struct drm_device *dev = pci_get_drvdata(pdev);
>         struct amdgpu_device *adev = drm_to_adev(dev);
>         int r, i;
> -       bool vram_lost;
> +       bool need_full_reset = true;
>         u32 memsize;
> +       struct list_head device_list;
>
>         DRM_INFO("PCI error: slot reset callback!!\n");
>
> +       INIT_LIST_HEAD(&device_list);
> +       list_add_tail(&adev->gmc.xgmi.head, &device_list);
> +
>         /* wait for asic to come out of reset */
>         msleep(500);
>
> +       /* Restore PCI confspace */
>         amdgpu_device_load_pci_state(pdev);
>
>         /* confirm  ASIC came out of reset */
> @@ -4873,70 +4879,15 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
>                 goto out;
>         }
>
> -       /* TODO Call amdgpu_pre_asic_reset instead */
>         adev->in_pci_err_recovery = true;
> -       r = amdgpu_device_ip_suspend(adev);
> +       r = amdgpu_device_pre_asic_reset(adev, NULL, &need_full_reset);
>         adev->in_pci_err_recovery = false;
>         if (r)
>                 goto out;
>
> -
> -       /* post card */
> -       r = amdgpu_atom_asic_init(adev->mode_info.atom_context);
> -       if (r)
> -               goto out;
> -
> -       r = amdgpu_device_ip_resume_phase1(adev);
> -       if (r)
> -               goto out;
> -
> -       vram_lost = amdgpu_device_check_vram_lost(adev);
> -       if (vram_lost) {
> -               DRM_INFO("VRAM is lost due to GPU reset!\n");
> -               amdgpu_inc_vram_lost(adev);
> -       }
> -
> -       r = amdgpu_gtt_mgr_recover(
> -               &adev->mman.bdev.man[TTM_PL_TT]);
> -       if (r)
> -               goto out;
> -
> -       r = amdgpu_device_fw_loading(adev);
> -       if (r)
> -               return r;
> -
> -       r = amdgpu_device_ip_resume_phase2(adev);
> -       if (r)
> -               goto out;
> -
> -       if (vram_lost)
> -               amdgpu_device_fill_reset_magic(adev);
> -
> -       /*
> -        * Add this ASIC as tracked as reset was already
> -        * complete successfully.
> -        */
> -       amdgpu_register_gpu_instance(adev);
> -
> -       r = amdgpu_device_ip_late_init(adev);
> -       if (r)
> -               goto out;
> -
> -       amdgpu_fbdev_set_suspend(adev, 0);
> -
> -       /* must succeed. */
> -       amdgpu_ras_resume(adev);
> -
> -
> -       amdgpu_irq_gpu_reset_resume_helper(adev);
> -       r = amdgpu_ib_ring_tests(adev);
> -       if (r)
> -               goto out;
> -
> -       r = amdgpu_device_recover_vram(adev);
> +       r = amdgpu_do_asic_reset(NULL, &device_list, &need_full_reset, true);
>
>  out:
> -
>         if (!r) {
>                 amdgpu_device_cache_pci_state(adev->pdev);
>                 DRM_INFO("PCIe error recovery succeeded\n");
> @@ -5022,4 +4973,6 @@ bool amdgpu_device_load_pci_state(struct pci_dev *pdev)
>                 DRM_WARN("Failed to load PCI state, err:%d\n", r);
>                 return false;
>         }
> +
> +       return true;

Looks like this should have been part of a previous patch.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


>  }
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
