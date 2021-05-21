Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4F8C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 000CF611AD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 13:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 000CF611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D9E6F874;
	Fri, 21 May 2021 13:47:25 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB0376F874
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 13:47:23 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id z3so19681172oib.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cq2iTH/te0U2nr8qul2JQysPZQf1AYXW9IfYdcASNrs=;
 b=vh0DrMAH/k6if0YDjS1dSISvUFviLTvKvdIjPoZd9wkVRPEoAyfVa6scJgUedHKXKe
 Kh2q7RS/uo87NZBpGvWR2TVB+KwaUXTWFgFzVoMBo4cPw8aPmpWFBWm8nsokuGlqXgM3
 UV7XQbxuJ0U94uf9LKS2dUWaW0KSh2RB/fDwVGJ6XYseu5JKNUJunHMuPM64FzPPNJkm
 kEfj6MxNmOBepgCYbeSfiqh+SOyWMII9q07S7tepEzF4LVSJ+200t39k2xRdxV9ArinN
 9p4GmiAP45Ru1jBzRNvuPY7gM27F0h+gV5SvcCBGFkXKbbQkfiC1QZG6DPk6GOANpBsq
 74mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cq2iTH/te0U2nr8qul2JQysPZQf1AYXW9IfYdcASNrs=;
 b=L7cd6DSFgU/mWBJemcKwGfyhWmQmgKAVWsErpk9Est82ZwkVpgHCvQM/Zf76BTabyf
 YWdnqByHRiHtuVaCsjNsUfB2JKVFb+QIRbNOLZsdf+J9HVrgmBW+KXniVCCZO7RjuGl8
 YvV/iy+MFJrBmqaN809q59uWglGULBHIIn7F28RlnaTU4LTiSk9dIuW/Q5r7UtytcxvY
 Oqz0m7uqu+czaAgvkESr9B2ofxrnBdmgd8pylyn/25LmSqW3hSNEV2AECKKjCImYLWDx
 ZDjT7/X+MK7MebUiM8ssuPdPO8XTE+mS/zBaI88S911ANXb/TdMNbpQ+0OOcsOPikau3
 2J7g==
X-Gm-Message-State: AOAM533SqS4awj4xvoZt+8yl2li6b0BuilsyuuPnETqT4UXdN7VqFulO
 5fDeDpifRcqW+WFZSUtu2mngwGg/ct0rElcUU6Galyr8
X-Google-Smtp-Source: ABdhPJyHegH/FpubAhjcaodryG4vZZt2y1gqoIF+OXM2ufZ6Zbjq2dKClQOZJw3jSHfqN6v5JoSlF/MGJ/PsGmEp7ng=
X-Received: by 2002:a05:6808:249:: with SMTP id
 m9mr2174027oie.120.1621604843050; 
 Fri, 21 May 2021 06:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210520155614.309986-1-alexander.deucher@amd.com>
 <1afdccca-8659-8fee-5ec6-17645198f0b3@amd.com>
In-Reply-To: <1afdccca-8659-8fee-5ec6-17645198f0b3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 May 2021 09:47:12 -0400
Message-ID: <CADnq5_Oo2LSXwc49Kpv7qtvEUZdeivJQ4-BqQsk6FbR5e2wpWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/acpi: unify ATCS handling (v3)
To: Lijo Lazar <lijo.lazar@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, May 21, 2021 at 3:12 AM Lijo Lazar <lijo.lazar@amd.com> wrote:
>
>
>
> On 5/20/2021 9:26 PM, Alex Deucher wrote:
> > Treat it like ATIF and check both the dGPU and APU for
> > the method.  This is required because ATCS may be hung
> > off of the APU in ACPI on A+A systems.
> >
> > v2: add back accidently removed ACPI handle check.
> > v3: Fix incorrect atif check (Colin)
> >      Fix uninitialized variable (Colin)
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  17 +--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 128 ++++++++++++++++-------
> >   2 files changed, 93 insertions(+), 52 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index b6435479cac8..ece1aee5a667 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -268,6 +268,7 @@ struct amdgpu_irq_src;
> >   struct amdgpu_fpriv;
> >   struct amdgpu_bo_va_mapping;
> >   struct amdgpu_atif;
> > +struct amdgpu_atcs;
> >   struct kfd_vm_fault_info;
> >   struct amdgpu_hive_info;
> >   struct amdgpu_reset_context;
> > @@ -681,20 +682,6 @@ struct amdgpu_vram_scratch {
> >       u64                             gpu_addr;
> >   };
> >
> > -/*
> > - * ACPI
> > - */
> > -struct amdgpu_atcs_functions {
> > -     bool get_ext_state;
> > -     bool pcie_perf_req;
> > -     bool pcie_dev_rdy;
> > -     bool pcie_bus_width;
> > -};
> > -
> > -struct amdgpu_atcs {
> > -     struct amdgpu_atcs_functions functions;
> > -};
> > -
> >   /*
> >    * CGS
> >    */
> > @@ -825,7 +812,7 @@ struct amdgpu_device {
> >       struct amdgpu_i2c_chan          *i2c_bus[AMDGPU_MAX_I2C_BUS];
> >       struct debugfs_blob_wrapper     debugfs_vbios_blob;
> >       struct amdgpu_atif              *atif;
> > -     struct amdgpu_atcs              atcs;
> > +     struct amdgpu_atcs              *atcs;
> >       struct mutex                    srbm_mutex;
> >       /* GRBM index mutex. Protects concurrent access to GRBM index */
> >       struct mutex                    grbm_idx_mutex;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > index 6cf6231057fc..29708b5685ad 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
> > @@ -72,12 +72,25 @@ struct amdgpu_atif {
> >       struct amdgpu_dm_backlight_caps backlight_caps;
> >   };
> >
> > +struct amdgpu_atcs_functions {
> > +     bool get_ext_state;
> > +     bool pcie_perf_req;
> > +     bool pcie_dev_rdy;
> > +     bool pcie_bus_width;
> > +};
> > +
> > +struct amdgpu_atcs {
> > +     acpi_handle handle;
> > +
> > +     struct amdgpu_atcs_functions functions;
> > +};
> > +
> >   /* Call the ATIF method
> >    */
> >   /**
> >    * amdgpu_atif_call - call an ATIF method
> >    *
> > - * @atif: acpi handle
> > + * @atif: atif structure
> >    * @function: the ATIF function to execute
> >    * @params: ATIF function params
> >    *
> > @@ -237,6 +250,35 @@ static acpi_handle amdgpu_atif_probe_handle(acpi_handle dhandle)
> >       return handle;
> >   }
> >
> > +static acpi_handle amdgpu_atcs_probe_handle(acpi_handle dhandle)
> > +{
> > +     acpi_handle handle = NULL;
> > +     char acpi_method_name[255] = { 0 };
> > +     struct acpi_buffer buffer = { sizeof(acpi_method_name), acpi_method_name };
> > +     acpi_status status;
> > +
> > +     /* For PX/HG systems, ATCS and ATPX are in the iGPU's namespace, on dGPU only
> > +      * systems, ATIF is in the dGPU's namespace.
> > +      */
> > +     status = acpi_get_handle(dhandle, "ATCS", &handle);
> > +     if (ACPI_SUCCESS(status))
> > +             goto out;
> > +
> > +     if (amdgpu_has_atpx()) {
> > +             status = acpi_get_handle(amdgpu_atpx_get_dhandle(), "ATCS",
> > +                                      &handle);
> > +             if (ACPI_SUCCESS(status))
> > +                     goto out;
> > +     }
> > +
> > +     DRM_DEBUG_DRIVER("No ATCS handle found\n");
> > +     return NULL;
> > +out:
> > +     acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> > +     DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);
> > +     return handle;
> > +}
> > +
> >   /**
> >    * amdgpu_atif_get_notification_params - determine notify configuration
> >    *
> > @@ -486,14 +528,15 @@ static int amdgpu_atif_handler(struct amdgpu_device *adev,
> >   /**
> >    * amdgpu_atcs_call - call an ATCS method
> >    *
> > - * @handle: acpi handle
> > + * @atcs: atcs structure
> >    * @function: the ATCS function to execute
> >    * @params: ATCS function params
> >    *
> >    * Executes the requested ATCS function (all asics).
> >    * Returns a pointer to the acpi output buffer.
> >    */
> > -static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
> > +static union acpi_object *amdgpu_atcs_call(struct amdgpu_atcs *atcs,
> > +                                        int function,
> >                                          struct acpi_buffer *params)
> >   {
> >       acpi_status status;
> > @@ -517,7 +560,7 @@ static union acpi_object *amdgpu_atcs_call(acpi_handle handle, int function,
> >               atcs_arg_elements[1].integer.value = 0;
> >       }
> >
> > -     status = acpi_evaluate_object(handle, "ATCS", &atcs_arg, &buffer);
> > +     status = acpi_evaluate_object(atcs->handle, "ATCS", &atcs_arg, &buffer);
> >
> >       /* Fail only if calling the method fails and ATIF is supported */
> >       if (ACPI_FAILURE(status) && status != AE_NOT_FOUND) {
> > @@ -551,7 +594,6 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
> >   /**
> >    * amdgpu_atcs_verify_interface - verify ATCS
> >    *
> > - * @handle: acpi handle
> >    * @atcs: amdgpu atcs struct
> >    *
> >    * Execute the ATCS_FUNCTION_VERIFY_INTERFACE ATCS function
> > @@ -559,15 +601,14 @@ static void amdgpu_atcs_parse_functions(struct amdgpu_atcs_functions *f, u32 mas
> >    * (all asics).
> >    * returns 0 on success, error on failure.
> >    */
> > -static int amdgpu_atcs_verify_interface(acpi_handle handle,
> > -                                     struct amdgpu_atcs *atcs)
> > +static int amdgpu_atcs_verify_interface(struct amdgpu_atcs *atcs)
> >   {
> >       union acpi_object *info;
> >       struct atcs_verify_interface output;
> >       size_t size;
> >       int err = 0;
> >
> > -     info = amdgpu_atcs_call(handle, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
> > +     info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_VERIFY_INTERFACE, NULL);
> >       if (!info)
> >               return -EIO;
> >
> > @@ -604,8 +645,10 @@ static int amdgpu_atcs_verify_interface(acpi_handle handle,
> >    */
> >   bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *adev)
> >   {
> > -     struct amdgpu_atcs *atcs = &adev->atcs;
> > +     struct amdgpu_atcs *atcs = adev->atcs;
> >
> > +     if (!atcs)
> > +             return false;
> >       if (atcs->functions.pcie_perf_req && atcs->functions.pcie_dev_rdy)
> >               return true;
> >
> > @@ -623,19 +666,15 @@ bool amdgpu_acpi_is_pcie_performance_request_supported(struct amdgpu_device *ade
> >    */
> >   int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
> >   {
> > -     acpi_handle handle;
> >       union acpi_object *info;
> > -     struct amdgpu_atcs *atcs = &adev->atcs;
> > +     struct amdgpu_atcs *atcs = adev->atcs;
> >
> > -     /* Get the device handle */
> > -     handle = ACPI_HANDLE(&adev->pdev->dev);
> > -     if (!handle)
> > +     if (!atcs)
> >               return -EINVAL;
> > -
> >       if (!atcs->functions.pcie_dev_rdy)
> >               return -EINVAL;
> >
> > -     info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
> > +     info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_DEVICE_READY_NOTIFICATION, NULL);
> >       if (!info)
> >               return -EIO;
> >
> > @@ -658,21 +697,18 @@ int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev)
> >   int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
> >                                        u8 perf_req, bool advertise)
> >   {
> > -     acpi_handle handle;
> >       union acpi_object *info;
> > -     struct amdgpu_atcs *atcs = &adev->atcs;
> > +     struct amdgpu_atcs *atcs = adev->atcs;
> >       struct atcs_pref_req_input atcs_input;
> >       struct atcs_pref_req_output atcs_output;
> >       struct acpi_buffer params;
> >       size_t size;
> >       u32 retry = 3;
> >
> > -     if (amdgpu_acpi_pcie_notify_device_ready(adev))
> > +     if (!atcs)
> >               return -EINVAL;
> >
> > -     /* Get the device handle */
> > -     handle = ACPI_HANDLE(&adev->pdev->dev);
> > -     if (!handle)
> > +     if (amdgpu_acpi_pcie_notify_device_ready(adev))
> >               return -EINVAL;
> >
> >       if (!atcs->functions.pcie_perf_req)
> > @@ -692,7 +728,7 @@ int amdgpu_acpi_pcie_performance_request(struct amdgpu_device *adev,
> >       params.pointer = &atcs_input;
> >
> >       while (retry--) {
> > -             info = amdgpu_atcs_call(handle, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
> > +             info = amdgpu_atcs_call(atcs, ATCS_FUNCTION_PCIE_PERFORMANCE_REQUEST, &params);
> >               if (!info)
> >                       return -EIO;
> >
> > @@ -768,32 +804,26 @@ static int amdgpu_acpi_event(struct notifier_block *nb,
> >    */
> >   int amdgpu_acpi_init(struct amdgpu_device *adev)
> >   {
> > -     acpi_handle handle, atif_handle;
> > +     acpi_handle handle, atif_handle, atcs_handle;
> >       struct amdgpu_atif *atif;
> > -     struct amdgpu_atcs *atcs = &adev->atcs;
> > -     int ret;
> > +     struct amdgpu_atcs *atcs;
> > +     int ret = 0;
> >
> >       /* Get the device handle */
> >       handle = ACPI_HANDLE(&adev->pdev->dev);
> >
> >       if (!adev->bios || !handle)
> > -             return 0;
> > -
> > -     /* Call the ATCS method */
> > -     ret = amdgpu_atcs_verify_interface(handle, atcs);
> > -     if (ret) {
> > -             DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
> > -     }
> > +             return ret;
>
> Is this return ok? Is it possible not to have ACPI handle for the dGPU,
> but has a valid handle for iGPU - like ATIF/ATCS functions that exist in
> iGPU space?

We are just checking for an ACPI handle here.  Presumably if the
device were part of the platform it would have an ACPI handle.  ATIF
and ATCS are only relevant to devices which are part of the platform.
E.g., they wouldn't apply to a card plugged into a PCIe slot or
thunderbolt.

Alex

>
> --
> Thanks,
> Lijo
>
> >       /* Probe for ATIF, and initialize it if found */
> >       atif_handle = amdgpu_atif_probe_handle(handle);
> >       if (!atif_handle)
> > -             goto out;
> > +             goto atcs;
> >
> >       atif = kzalloc(sizeof(*atif), GFP_KERNEL);
> >       if (!atif) {
> >               DRM_WARN("Not enough memory to initialize ATIF\n");
> > -             goto out;
> > +             goto atcs;
> >       }
> >       atif->handle = atif_handle;
> >
> > @@ -802,7 +832,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
> >       if (ret) {
> >               DRM_DEBUG_DRIVER("Call to ATIF verify_interface failed: %d\n", ret);
> >               kfree(atif);
> > -             goto out;
> > +             goto atcs;
> >       }
> >       adev->atif = atif;
> >
> > @@ -811,7 +841,8 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
> >               if (amdgpu_device_has_dc_support(adev)) {
> >   #if defined(CONFIG_DRM_AMD_DC)
> >                       struct amdgpu_display_manager *dm = &adev->dm;
> > -                     atif->bd = dm->backlight_dev;
> > +                     if (dm->backlight_dev)
> > +                             atif->bd = dm->backlight_dev;
> >   #endif
> >               } else {
> >                       struct drm_encoder *tmp;
> > @@ -863,6 +894,28 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
> >               atif->backlight_caps.caps_valid = false;
> >       }
> >
> > +atcs:
> > +     /* Probe for ATCS, and initialize it if found */
> > +     atcs_handle = amdgpu_atcs_probe_handle(handle);
> > +     if (!atcs_handle)
> > +             goto out;
> > +
> > +     atcs = kzalloc(sizeof(*atcs), GFP_KERNEL);
> > +     if (!atcs) {
> > +             DRM_WARN("Not enough memory to initialize ATCS\n");
> > +             goto out;
> > +     }
> > +     atcs->handle = atcs_handle;
> > +
> > +     /* Call the ATCS method */
> > +     ret = amdgpu_atcs_verify_interface(atcs);
> > +     if (ret) {
> > +             DRM_DEBUG_DRIVER("Call to ATCS verify_interface failed: %d\n", ret);
> > +             kfree(atcs);
> > +             goto out;
> > +     }
> > +     adev->atcs = atcs;
> > +
> >   out:
> >       adev->acpi_nb.notifier_call = amdgpu_acpi_event;
> >       register_acpi_notifier(&adev->acpi_nb);
> > @@ -893,6 +946,7 @@ void amdgpu_acpi_fini(struct amdgpu_device *adev)
> >   {
> >       unregister_acpi_notifier(&adev->acpi_nb);
> >       kfree(adev->atif);
> > +     kfree(adev->atcs);
> >   }
> >
> >   /**
> >
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
