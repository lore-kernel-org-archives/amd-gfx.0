Return-Path: <SRS0=QkQq=3G=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151CCC3F68F
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 19:23:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4C7A2087E
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jan 2020 19:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI6u5zbe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4C7A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A0EB6F8CE;
	Fri, 17 Jan 2020 19:23:22 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0BD16F8CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 19:23:20 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id t14so8714944wmi.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jan 2020 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jjyqqm3h6GkOeSSeVSLrDA8jPXsGS/vE2dAwQVX/QeQ=;
 b=oI6u5zbeX0HCLJ32u3pB7F+bugbikg4vTgCAlD39QAth+UD8a9VbP8Ml7gEp0v/H5h
 5TTSzk0KMuM156rIK30hj+2XYmJhhDULs/fsd/NIlqcv1GNEbI6bi2bYv2KfdJ1I38HK
 PDaARCAGRmDRNH3hmuP26ss4+k5nzwC4zUELo1DFbijgvV5axRK6pLZtVFdsCRgM6b9J
 RsgaKqumGWeeq+erMezxrv48hUqnbWIjj0+3aJ3jpIjsJt1BNZT4vEx5eWsRM+tZPcbF
 /uYc6LwXhYPN1vlxfr2y40b7SFbAhtJwMG2M866J3BxQe0L6UMuba4fzzW1nCex83ox5
 tz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jjyqqm3h6GkOeSSeVSLrDA8jPXsGS/vE2dAwQVX/QeQ=;
 b=Dci6FPD0nUZXNkwm+/EqwsqDBYJvb9vQU7nHt51rOMhk22d2AWjOr88mPWiBok2/Qr
 WKRLO40IzIvQWfcPTJQPOnbDAzrRhlJBQafm8m4Xd7TUrM6BUoH2KW7GQIalVUsT2MUR
 thKCD1HpqcuUBBe81tM4cTbQSyuEv9L1l3HaLASv8IfB+ywcneGOv8Afua0wdvd64i1K
 VC2esV2lBa4hLTGOsL2Xq4ECDaJLM6Ws1lcJbrUKEEPURzrt1RkOzRyLxLc3/wU/6E7R
 U2iWiV+Tx757+B25jP1OzjL/nHOQG4oe/YGTeiCZX1prEDFt07bmyY8DkaUYsCTEUs6/
 K1hA==
X-Gm-Message-State: APjAAAUxZLK+iYTBJMYPedagUHSDPuUWsgcjudWFs9xvirPNA0McX3IH
 yj2YTlIHuo4D7K9kwrylse1DV2BOEEBRcCMLS8asbQ==
X-Google-Smtp-Source: APXvYqyr0ZrcMCWdF63wpWWC0eY/t0nw6ZcaCbvt4nl0grf1NwV7ms5AV0HDEHlX4ZKnaDQIsWTdrvywihv/pDdq628=
X-Received: by 2002:a1c:3d07:: with SMTP id k7mr6196950wma.79.1579288999211;
 Fri, 17 Jan 2020 11:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
 <20200116202945.21801-4-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20200116202945.21801-4-Bhawanpreet.Lakha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 Jan 2020 14:23:07 -0500
Message-ID: <CADnq5_Ms88BpiKvk5Okitu944yd3Ar5=AAzDb-_ne-SFP7YAEw@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/amd/display: Add sysfs interface for set/get srm
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
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
Cc: "Wentland, Harry" <harry.wentland@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 16, 2020 at 3:30 PM Bhawanpreet Lakha
<Bhawanpreet.Lakha@amd.com> wrote:
>
> [Why]
> We need to set/get SRM and linux kernel is not suppose to write to the
> storage, so we need to provide a interface.
>
> [How]
> Provide interface so usermode can set/get srm
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 124 +++++++++++++++++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   6 +
>  2 files changed, 128 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> index a269916f7dd6..a191c84ad8eb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.c
> @@ -28,6 +28,8 @@
>  #include "amdgpu_dm.h"
>  #include "dm_helpers.h"
>  #include <drm/drm_hdcp.h>
> +#include "hdcp_psp.h"
> +
>
>  static bool
>  lp_write_i2c(void *handle, uint32_t address, const uint8_t *data, uint32_t size)
> @@ -67,6 +69,16 @@ lp_read_dpcd(void *handle, uint32_t address, uint8_t *data, uint32_t size)
>         return dm_helpers_dp_read_dpcd(link->ctx, link, address, data, size);
>  }
>
> +static uint8_t *psp_get_srm(struct psp_context *psp, uint32_t *srm_version, uint32_t *srm_size)
> +{
> +       return NULL;
> +}
> +
> +static int psp_set_srm(struct psp_context *psp, uint8_t *srm, uint32_t srm_size, uint32_t *srm_version)
> +{
> +       return 0;
> +}
> +
>  static void process_output(struct hdcp_workqueue *hdcp_work)
>  {
>         struct mod_hdcp_output output = hdcp_work->output;
> @@ -88,6 +100,18 @@ static void process_output(struct hdcp_workqueue *hdcp_work)
>         schedule_delayed_work(&hdcp_work->property_validate_dwork, msecs_to_jiffies(0));
>  }
>
> +static void link_lock(struct hdcp_workqueue *work, bool lock)
> +{
> +
> +       int i = 0;
> +
> +       for (i = 0; i < work->max_link; i++) {
> +               if (lock)
> +                       mutex_lock(&work[i].mutex);
> +               else
> +                       mutex_unlock(&work[i].mutex);
> +       }
> +}
>  void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
>                          unsigned int link_index,
>                          struct amdgpu_dm_connector *aconnector,
> @@ -302,7 +326,8 @@ void hdcp_destroy(struct hdcp_workqueue *hdcp_work)
>         }
>
>         kfree(hdcp_work);
> -
> +       kfree(hdcp_work->srm);
> +       kfree(hdcp_work->srm_temp);
>  }
>
>  static void update_config(void *handle, struct cp_psp_stream_config *config)
> @@ -338,6 +363,84 @@ static void update_config(void *handle, struct cp_psp_stream_config *config)
>         hdcp_update_display(hdcp_work, link_index, aconnector, DRM_MODE_HDCP_CONTENT_TYPE0, false);
>  }
>
> +
> +/*
> + * This can be called twice, because SRM_SIZE > PAGE_SIZE.
> + *
> + * We set the SRM on each call, if SRM_SIZE > PAGE_SIZE, PSP will fail on the
> + * first call but pass on the second call.
> + *
> + * Because of this we are not throwing any errors as it will stop the next call.
> + * So it is a good idea to call the "read" sysfs to verify that the SRM was set
> + *
> + */

Rather than using a file to get the data directly in chunks, how about
adding a sysfs file where you can specify the path to the srm file.
The driver can then use the path provided to call request firmware and
just get the entire binary in one shot.

Alex


> +static ssize_t srm_data_write(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
> +                             loff_t pos, size_t count)
> +{
> +       struct hdcp_workqueue *work;
> +       uint32_t srm_version = 0;
> +
> +       work = container_of(bin_attr, struct hdcp_workqueue, attr);
> +       link_lock(work, true);
> +
> +       memcpy(work->srm_temp + pos, buffer, count);
> +
> +       if (!psp_set_srm(work->hdcp.config.psp.handle, work->srm_temp, pos + count, &srm_version)) {
> +               DRM_DEBUG_DRIVER("HDCP SRM SET version 0x%X", srm_version);
> +               memcpy(work->srm, work->srm_temp, pos + count);
> +               work->srm_size = pos + count;
> +               work->srm_version = srm_version;
> +       }
> +
> +
> +       link_lock(work, false);
> +
> +       return count;
> +}
> +
> +static ssize_t srm_data_read(struct file *filp, struct kobject *kobj, struct bin_attribute *bin_attr, char *buffer,
> +                            loff_t pos, size_t count)
> +{
> +       struct hdcp_workqueue *work;
> +       uint8_t *srm = NULL;
> +       uint32_t srm_version;
> +       uint32_t srm_size;
> +       size_t ret = count;
> +
> +       work = container_of(bin_attr, struct hdcp_workqueue, attr);
> +
> +       link_lock(work, true);
> +
> +       srm = psp_get_srm(work->hdcp.config.psp.handle, &srm_version, &srm_size);
> +
> +       if (!srm)
> +               return -EINVAL;
> +
> +       if (pos >= srm_size)
> +               ret = 0;
> +
> +       if (srm_size - pos < count) {
> +               memcpy(buffer, srm + pos, srm_size - pos);
> +               ret = srm_size - pos;
> +               goto ret;
> +       }
> +
> +       memcpy(buffer, srm + pos, count);
> +
> +ret:
> +       link_lock(work, false);
> +       return ret;
> +}
> +
> +
> +static const struct bin_attribute data_attr = {
> +       .attr = {.name = "hdcp_srm", .mode = 0664},
> +       .size = PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, /* Limit SRM size */
> +       .write = srm_data_write,
> +       .read = srm_data_read,
> +};
> +
> +
>  struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct cp_psp *cp_psp, struct dc *dc)
>  {
>
> @@ -348,10 +451,19 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
>         if (hdcp_work == NULL)
>                 goto fail_alloc_context;
>
> +       hdcp_work->srm = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm), GFP_KERNEL);
> +
> +       if (hdcp_work->srm == NULL)
> +               goto fail_alloc_context;
> +
> +       hdcp_work->srm_temp = kcalloc(PSP_HDCP_SRM_FIRST_GEN_MAX_SIZE, sizeof(*hdcp_work->srm_temp), GFP_KERNEL);
> +
> +       if (hdcp_work->srm_temp == NULL)
> +               goto fail_alloc_context;
> +
>         hdcp_work->max_link = max_caps;
>
>         for (i = 0; i < max_caps; i++) {
> -
>                 mutex_init(&hdcp_work[i].mutex);
>
>                 INIT_WORK(&hdcp_work[i].cpirq_work, event_cpirq);
> @@ -371,10 +483,18 @@ struct hdcp_workqueue *hdcp_create_workqueue(struct amdgpu_device *adev, struct
>         cp_psp->funcs.update_stream_config = update_config;
>         cp_psp->handle = hdcp_work;
>
> +       /* File created at /sys/class/drm/card0/device/hdcp_srm*/
> +       hdcp_work[0].attr = data_attr;
> +
> +       if (sysfs_create_bin_file(&adev->dev->kobj, &hdcp_work[0].attr))
> +               DRM_WARN("Failed to create device file hdcp_srm");
> +
>         return hdcp_work;
>
>  fail_alloc_context:
>         kfree(hdcp_work);
> +       kfree(hdcp_work->srm);
> +       kfree(hdcp_work->srm_temp);
>
>         return NULL;
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> index 331b50825510..5159b3a5e5b0 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_hdcp.h
> @@ -53,6 +53,12 @@ struct hdcp_workqueue {
>
>         enum mod_hdcp_encryption_status encryption_status;
>         uint8_t max_link;
> +
> +       uint8_t *srm;
> +       uint8_t *srm_temp;
> +       uint32_t srm_version;
> +       uint32_t srm_size;
> +       struct bin_attribute attr;
>  };
>
>  void hdcp_update_display(struct hdcp_workqueue *hdcp_work,
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
