Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E9FC47420
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4332076B
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 15:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWDhyvYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4332076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C3F46E1EC;
	Tue, 29 Sep 2020 15:10:08 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5FD6E1EC
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 15:10:06 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id o5so5780217wrn.13
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k+0RnNyutgCXNNSa0rNK1znXC6RwkjnVhtLYt9YouEE=;
 b=BWDhyvYRE7ZyB1hEcIhrrEU040LjuoxrkfkPxDtPJZiZdn0ykm7cf2CYLZ//8mHh/q
 FmKbePs3W9X7VkiKfhywVWDQvlBh03igULTtpU4Y13tar3TZA0dPiYAZXh8SpmhMhuHs
 IOGCbLc+9tajuWyXi8VxU1H2le07K2yCNzy8DYls4rp6ZZELmTieKjcBaWWt1M6RRv7d
 16AP4lc+YHuJZ8pn+ZcHER1StCggoGZ1AUEn4+xNxXm/3MR9T6BId05NiKY4jTNjM2fd
 BjjbmvKlu0NO+hH8m2D8Xh8/m2r2DC9ZZgEacT3khRNlKOSWbiVmM2YydYbIvHLN/yop
 jbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k+0RnNyutgCXNNSa0rNK1znXC6RwkjnVhtLYt9YouEE=;
 b=lLTOBC95OYY8lXLT87KlHjk3NvnuYR2/oibDT1+55eA+c+MQxeI+ZL/A63wWG2k86M
 ksjpNpNHDBfva6wTdTLOjkwRMz1I2WOEYTp9eLRLCJi6jeLsVkzQ2AGYNZ7+kAUmgRiu
 4JG0mvVNXLR6sWx+WglEWTlM9h3THfIoLoBzwI1iEDfE7VS2hNKunx/2uG0sWTPqPAxX
 e7LfVFU6ABe85p7JriIBcIGh345B0UhZyi15BN5FWnRodSMKNpH0z4v7/emFtBtdlfJW
 6PWmQX1gLaGIhTHMdQ1lPjNiZ2eeElt5VPtMfnwkbRNPBQ3GRQ8wztEgtgLvjtvoQVTL
 j0Og==
X-Gm-Message-State: AOAM5317Up+zikTMSEbm13RxIbPVWNtJ+n0WlU9KIUfqp8ejExCJH4/I
 fNPQly41Z7jbTeJzdUZMCvvyuardtUZZZ5z4eth56r5c
X-Google-Smtp-Source: ABdhPJzQf+NUs9Lv77yfyskTemrHb9VtKxWZQbMKV3nvv+N7gFn60MdKj+S9O2djVawu1YZDwlsJA9aEEpNttMh9gh0=
X-Received: by 2002:adf:f290:: with SMTP id k16mr5246451wro.124.1601392205228; 
 Tue, 29 Sep 2020 08:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
 <20200925201029.1738724-36-alexander.deucher@amd.com>
 <535ea0cc-67e5-a81f-47d5-87b51ee47a82@amd.com>
In-Reply-To: <535ea0cc-67e5-a81f-47d5-87b51ee47a82@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 11:09:54 -0400
Message-ID: <CADnq5_Op9sobQ18HDjQ9TKwcQdhGYQP28CbFQEVCcMLFMZhuyQ@mail.gmail.com>
Subject: Re: [PATCH 36/45] drm/amdgpu: add TOC firmware support for apu (v2)
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 28, 2020 at 6:26 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> On 2020-09-25 4:10 p.m., Alex Deucher wrote:
> > From: Huang Rui <ray.huang@amd.com>
> >
> > APU needs load toc firmware for gfx10 series on psp front door loading.
> >
> > v2: rebase against latest code
> >
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Acked-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 11 ++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 36 +++++++++++++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h |  7 +++++
> >  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c  | 33 ++++++++++++++++-------
> >  4 files changed, 77 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index bd0d14419841..26caa8d43483 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -325,6 +325,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
> >               fw_info->ver = adev->dm.dmcub_fw_version;
> >               fw_info->feature = 0;
> >               break;
> > +     case AMDGPU_INFO_FW_TOC:
> > +             fw_info->ver = adev->psp.toc_fw_version;
> > +             fw_info->feature = adev->psp.toc_feature_version;
> > +             break;
> >       default:
> >               return -EINVAL;
> >       }
> > @@ -1464,6 +1468,13 @@ static int amdgpu_debugfs_firmware_info(struct seq_file *m, void *data)
> >       seq_printf(m, "DMCUB feature version: %u, firmware version: 0x%08x\n",
> >                  fw_info.feature, fw_info.ver);
> >
> > +     /* TOC */
> > +     query_fw.fw_type = AMDGPU_INFO_FW_TOC;
> > +     ret = amdgpu_firmware_info(&fw_info, &query_fw, adev);
> > +     if (ret)
> > +             return ret;
> > +     seq_printf(m, "TOC feature version: %u, firmware version: 0x%08x\n",
> > +                fw_info.feature, fw_info.ver);
> >
> >       seq_printf(m, "VBIOS version: %s\n", ctx->vbios_version);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > index 18be544d8c1e..c8cec7ab499d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> > @@ -2415,6 +2415,42 @@ int psp_init_asd_microcode(struct psp_context *psp,
> >       return err;
> >  }
> >
> > +int psp_init_toc_microcode(struct psp_context *psp,
> > +                        const char *chip_name)
> > +{
> > +     struct amdgpu_device *adev = psp->adev;
> > +     char fw_name[30];
> > +     const struct psp_firmware_header_v1_0 *toc_hdr;
> > +     int err = 0;
> > +
> > +     if (!chip_name) {
> > +             dev_err(adev->dev, "invalid chip name for toc microcode\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_toc.bin", chip_name);
> > +     err = request_firmware(&adev->psp.toc_fw, fw_name, adev->dev);
> > +     if (err)
> > +             goto out;
> > +
> > +     err = amdgpu_ucode_validate(adev->psp.toc_fw);
> > +     if (err)
> > +             goto out;
> > +
> > +     toc_hdr = (const struct psp_firmware_header_v1_0 *)adev->psp.toc_fw->data;
> > +     adev->psp.toc_fw_version = le32_to_cpu(toc_hdr->header.ucode_version);
> > +     adev->psp.toc_feature_version = le32_to_cpu(toc_hdr->ucode_feature_version);
> > +     adev->psp.toc_bin_size = le32_to_cpu(toc_hdr->header.ucode_size_bytes);
> > +     adev->psp.toc_start_addr = (uint8_t *)toc_hdr +
> > +                             le32_to_cpu(toc_hdr->header.ucode_array_offset_bytes);
> > +     return 0;
> > +out:
>
> I'd rather this label be "Err:".
>
> Regardless of whether there already is a variable "err",
> (there is!), capitalizing goto labels is good practice, since
> it distinguishes them from variables (which are all lowercase),
> and macros (which are all caps). Plus, you also avoid conflict
> with the eponymous variable.
>

I see your point, but I find random caps in code hard to read.

> > +     dev_err(adev->dev, "fail to initialize toc microcode\n");
>
> That's a very misleading message. Please print this instead:
>
>         dev_err(adev->dev,
>                 "Failed to load/validate firmware for %s\n",
>                 fw_name);
>
> To make it clear what was being loaded and validated and failed.
>

Updated.

Thanks,

Alex

> Regards,
> Luben
>
> > +     release_firmware(adev->psp.toc_fw);
> > +     adev->psp.toc_fw = NULL;
> > +     return err;
> > +}
> > +
> >  int psp_init_sos_microcode(struct psp_context *psp,
> >                          const char *chip_name)
> >  {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > index 919d2fb7427b..13f56618660a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
> > @@ -253,6 +253,11 @@ struct psp_context
> >       uint32_t                        asd_ucode_size;
> >       uint8_t                         *asd_start_addr;
> >
> > +     /* toc firmware */
> > +     const struct firmware           *toc_fw;
> > +     uint32_t                        toc_fw_version;
> > +     uint32_t                        toc_feature_version;
> > +
> >       /* fence buffer */
> >       struct amdgpu_bo                *fence_buf_bo;
> >       uint64_t                        fence_buf_mc_addr;
> > @@ -386,6 +391,8 @@ int psp_ring_cmd_submit(struct psp_context *psp,
> >                       int index);
> >  int psp_init_asd_microcode(struct psp_context *psp,
> >                          const char *chip_name);
> > +int psp_init_toc_microcode(struct psp_context *psp,
> > +                        const char *chip_name);
> >  int psp_init_sos_microcode(struct psp_context *psp,
> >                          const char *chip_name);
> >  int psp_init_ta_microcode(struct psp_context *psp,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > index 6c5d9612abcb..f2d6b2518eee 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> > @@ -109,20 +109,16 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
> >               BUG();
> >       }
> >
> > -     err = psp_init_sos_microcode(psp, chip_name);
> > -     if (err)
> > -             return err;
> > -
> > -     if (adev->asic_type != CHIP_SIENNA_CICHLID &&
> > -         adev->asic_type != CHIP_NAVY_FLOUNDER) {
> > -             err = psp_init_asd_microcode(psp, chip_name);
> > -             if (err)
> > -                     return err;
> > -     }
> >
> >       switch (adev->asic_type) {
> >       case CHIP_VEGA20:
> >       case CHIP_ARCTURUS:
> > +             err = psp_init_sos_microcode(psp, chip_name);
> > +             if (err)
> > +                     return err;
> > +             err = psp_init_asd_microcode(psp, chip_name);
> > +             if (err)
> > +                     return err;
> >               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
> >               err = request_firmware(&adev->psp.ta_fw, fw_name, adev->dev);
> >               if (err) {
> > @@ -150,6 +146,12 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
> >       case CHIP_NAVI10:
> >       case CHIP_NAVI14:
> >       case CHIP_NAVI12:
> > +             err = psp_init_sos_microcode(psp, chip_name);
> > +             if (err)
> > +                     return err;
> > +             err = psp_init_asd_microcode(psp, chip_name);
> > +             if (err)
> > +                     return err;
> >               if (amdgpu_sriov_vf(adev))
> >                       break;
> >               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", chip_name);
> > @@ -180,10 +182,21 @@ static int psp_v11_0_init_microcode(struct psp_context *psp)
> >               break;
> >       case CHIP_SIENNA_CICHLID:
> >       case CHIP_NAVY_FLOUNDER:
> > +             err = psp_init_sos_microcode(psp, chip_name);
> > +             if (err)
> > +                     return err;
> >               err = psp_init_ta_microcode(&adev->psp, chip_name);
> >               if (err)
> >                       return err;
> >               break;
> > +     case CHIP_VANGOGH:
> > +             err = psp_init_asd_microcode(psp, chip_name);
> > +             if (err)
> > +                     return err;
> > +             err = psp_init_toc_microcode(psp, chip_name);
> > +             if (err)
> > +                     return err;
> > +             break;
> >       default:
> >               BUG();
> >       }
> >
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
