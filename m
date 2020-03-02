Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824CCC3F2D1
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AFA214DB
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 21:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndmCGiXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AFA214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117DE6E848;
	Mon,  2 Mar 2020 21:34:09 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADDCC6E848
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 21:34:08 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id y17so1710413wrn.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2020 13:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ToGhL5k+H0wz362w1gs1CGsDST4PD1qIfPoLie+zQlM=;
 b=ndmCGiXGaCirdj3aeNh397YVX/qRWQRmz9yOHGuVpQm8VI9FF7K9MucBTLdRA2Bpwz
 joG/xh7uElewxL/H9G+zWrtMQpogZmPRnOKpIHv1WHIKf5meoDxEDzI+l9GJD/t0HZOb
 6TgejmAgIpfehpFa9QDwGJ3nS/b0LQZad0m/z9iWM5pZa4O3PxAOIBxirqL9h28ZxUTt
 i1bqHK18QgVq654tJ30oGRp0MrzpqAbAJMsizgrwU6etMEI9LD7yuPdWZ99v59CWghz2
 OKF5FzqfBDj4oeWWVl1ArCeV4DBXH08iQgntsvxuXN9lxfbHYkzZo4QqJVl+161cbzjX
 Sa3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ToGhL5k+H0wz362w1gs1CGsDST4PD1qIfPoLie+zQlM=;
 b=mw35NbC92zqmobHlwUvRL1j4ha9QHYBR45D+iTVkM/r//fhF3eK4UMuMc2DrlCmQnL
 bFkHLOpPtq7P6fgpaxUDdX1LZVHaL5VsdP8MOI4X3kRZtgGQQTByC/dILEATlGDRhqYV
 //mCkX1uLXMp+6/eedy9UmCB7pNxiYPqjtLd60XEsCZGRz73qQPK32xF5ugR4+VXkGf6
 93xoEwBZG5L6uA9quw1IIdXCw/PQIpVlxIQ2jCcHxBjRt3STbOCackiJNcVD8T4tnsXH
 iLq6Mfl5ZHH0kG5VjfqvwdsbWDkoHyxFkmCLwesOwvlnZszfaG0XciETKwanCo+ApDov
 DhJA==
X-Gm-Message-State: ANhLgQ1PWpfSceY+X2GqS3A+v/DzvuaY+/HQEqdeZVIf6qPvyhwEup5S
 ovPW1hw3+ub21Vh6Nf3aCB8P7AmSaGvk+YxVZBM=
X-Google-Smtp-Source: ADFU+vt2cslYi/NVOmEJASwY9IBQZRo9vnm3+JiEde0NE8Q8JdKjoTaryOHjbMSGS9dTyxdJAoY5FJ4INpa1TAxPFls=
X-Received: by 2002:a5d:5012:: with SMTP id e18mr1486032wrt.419.1583184847357; 
 Mon, 02 Mar 2020 13:34:07 -0800 (PST)
MIME-Version: 1.0
References: <1583177061-3115-1-git-send-email-andrey.grodzovsky@amd.com>
 <1583177061-3115-4-git-send-email-andrey.grodzovsky@amd.com>
In-Reply-To: <1583177061-3115-4-git-send-email-andrey.grodzovsky@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2020 16:33:56 -0500
Message-ID: <CADnq5_Pph22E4fe6nE3-607jZhCo9gfKQc-nuaWFAAEJtSy9jg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Add support for USBC PD FW download
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Abramov,
 Slava" <Slava.Abramov@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Mar 2, 2020 at 2:24 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> Starts USBC PD FW download and reads back the latest FW version.
>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 94 +++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> index d33f741..76630b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -24,6 +24,7 @@
>   */
>
>  #include <linux/firmware.h>
> +#include <linux/dma-mapping.h>
>
>  #include "amdgpu.h"
>  #include "amdgpu_psp.h"
> @@ -38,6 +39,9 @@
>
>  static void psp_set_funcs(struct amdgpu_device *adev);
>
> +static int psp_sysfs_init(struct amdgpu_device *adev);
> +static void psp_sysfs_fini(struct amdgpu_device *adev);
> +
>  /*
>   * Due to DF Cstate management centralized to PMFW, the firmware
>   * loading sequence will be updated as below:
> @@ -94,6 +98,7 @@ static int psp_early_init(void *handle)
>                 psp->autoload_supported = false;
>                 break;
>         case CHIP_NAVI10:
> +               psp_sysfs_init(adev);

We should add the file as late as possible.  Maybe add a new
psp_late_init() function in amdgpu_psp.c?  Otherwise, you'll get
processes trying to use the sysfs interface before the driver is
ready.

Alex

>         case CHIP_NAVI14:
>         case CHIP_NAVI12:
>                 psp_v11_0_set_psp_funcs(psp);
> @@ -152,6 +157,10 @@ static int psp_sw_fini(void *handle)
>                 release_firmware(adev->psp.ta_fw);
>                 adev->psp.ta_fw = NULL;
>         }
> +
> +       if (adev->asic_type == CHIP_NAVI10)
> +               psp_sysfs_fini(adev);
> +
>         return 0;
>  }
>
> @@ -1816,6 +1825,76 @@ static int psp_set_powergating_state(void *handle,
>         return 0;
>  }
>
> +static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
> +                                               struct device_attribute *attr,
> +                                                               char *buf)
> +{
> +       struct drm_device *ddev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = ddev->dev_private;
> +       uint32_t fw_ver;
> +       int ret;
> +
> +       ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
> +       if (ret) {
> +               DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
> +               return ret;
> +       }
> +
> +       return snprintf(buf, PAGE_SIZE, "%x\n", fw_ver);
> +}
> +
> +static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
> +                                                      struct device_attribute *attr,
> +                                                      const char *buf,
> +                                                      size_t count)
> +{
> +       struct drm_device *ddev = dev_get_drvdata(dev);
> +       struct amdgpu_device *adev = ddev->dev_private;
> +       void *cpu_addr;
> +       dma_addr_t dma_addr;
> +       int ret = 0;
> +       char fw_name[100];
> +       const struct firmware *usbc_pd_fw;
> +
> +
> +       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s", buf);
> +       ret = request_firmware(&usbc_pd_fw, fw_name, adev->dev);
> +       if (ret)
> +               goto fail;
> +
> +       /* We need contiguous physical mem to place the FW  for psp to access */
> +       cpu_addr = dma_alloc_coherent(adev->dev, usbc_pd_fw->size, &dma_addr, GFP_KERNEL);
> +
> +       ret = dma_mapping_error(adev->dev, dma_addr);
> +       if (ret)
> +               goto rel_buf;
> +
> +       memcpy_toio(cpu_addr, usbc_pd_fw->data, usbc_pd_fw->size);
> +
> +       /*TODO Remove once PSP starts snooping CPU cache */
> +       clflush_cache_range(cpu_addr, (usbc_pd_fw->size & ~(L1_CACHE_BYTES - 1)));
> +
> +       ret = psp_load_usbc_pd_fw(&adev->psp, dma_addr);
> +
> +rel_buf:
> +       dma_free_coherent(adev->dev, usbc_pd_fw->size, cpu_addr, dma_addr);
> +       release_firmware(usbc_pd_fw);
> +
> +fail:
> +       if (ret) {
> +               DRM_ERROR("Failed to load USBC PD FW, err = %d", ret);
> +               return ret;
> +       }
> +
> +       return count;
> +}
> +
> +static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
> +                  psp_usbc_pd_fw_sysfs_read,
> +                  psp_usbc_pd_fw_sysfs_write);
> +
> +
> +
>  const struct amd_ip_funcs psp_ip_funcs = {
>         .name = "psp",
>         .early_init = psp_early_init,
> @@ -1834,6 +1913,21 @@ const struct amd_ip_funcs psp_ip_funcs = {
>         .set_powergating_state = psp_set_powergating_state,
>  };
>
> +static int psp_sysfs_init(struct amdgpu_device *adev)
> +{
> +       int ret = device_create_file(adev->dev, &dev_attr_usbc_pd_fw);
> +
> +        if (ret)
> +                DRM_ERROR("Failed to create USBC PD FW control file!");
> +
> +        return ret;
> +}
> +
> +static void psp_sysfs_fini(struct amdgpu_device *adev)
> +{
> +       device_remove_file(adev->dev, &dev_attr_usbc_pd_fw);
> +}
> +
>  static const struct amdgpu_psp_funcs psp_funcs = {
>         .check_fw_loading_status = psp_check_fw_loading_status,
>  };
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
