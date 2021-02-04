Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEEBC433E6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:37:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E1F64EE2
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 14:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E1F64EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F776ED88;
	Thu,  4 Feb 2021 14:37:35 +0000 (UTC)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0096ED88
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 14:37:34 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id d7so1319562otq.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 04 Feb 2021 06:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iA8xk1w0OGmBpNpknetdotXKM9VURZ0GtcGGiqCSDBY=;
 b=aZmm2SLSEKBialZNvxayOKluGv+Ic2krO0tdA08ixgkNK02jIHqnGu6cXNLfOIjC14
 M7v/JY3tHcgk/TpFMctqLCIR5yzlon4hBROCpc0hJH8Y3PBS/i7kBo+lOjHjRAvELOHY
 otR2s+YHhu6Gt4fYZkouXh0dKpTdyaBQo9qtbNa+U5jLr1rFLTBzCYzMTjHnb2am0k1V
 7X9xpXsJCF8jw2oC2k+3j9JHAl1AfFtPOi85gHd4D6FH7uPUCk6s9jmNE4J/GfR9A4IP
 8QyuEpjXrxKxTZNqQ3G/W1xFOHcwlCSO4UE6nPtUTQ6befpVNr1DXidsBp64pWnjzUcb
 7nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iA8xk1w0OGmBpNpknetdotXKM9VURZ0GtcGGiqCSDBY=;
 b=bFjxtwGtlI64veziQA7owYsxaTlAuNccZNY+uQg1AQvWQ32jIyZV4K0pZxMvTkE0zs
 d5GhYFUE2c2ErssDAIjlKjPbdMzji1R0LjqS6yjQdTr7EtDfoIdvva1VncwR6qKB8mGJ
 pZRYa1P0obfCC3hi1q0dwBNpuhFrFxXNpxoYfqSZZf7dWkXpAYR+bvSZrZtfMrK7GdH1
 y2HH/LDUFcXidU59h8TQcqJ0orTQg/xSYFnynX+dir+VqZytSDJRgmIp2nxnGpP+Ur3e
 gIx4OhyCAIPGA37LYBn5kPjZz9j1myxjDe+vuzOo56tv6oapBBrj53WKN7kDB1AgX745
 D7Kw==
X-Gm-Message-State: AOAM531AOCA10D2PGggI92FtNuT9WXE+xFPos8I0pBNpbGWDwufIM+Z2
 95d9cIfKBZLOTHnSIwL+qT0EOCYaPWloRa+0nj4=
X-Google-Smtp-Source: ABdhPJwH5IQ8UtDiBHaAzv0Zodu8zevLFlFWDIwwmesSPyrawxxijNYxSe8LnuSHueK24DcAP5QEC+PBOXxJR7wsJ14=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr5873288otj.311.1612449453908;
 Thu, 04 Feb 2021 06:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20210202171748.1062530-1-alexander.deucher@amd.com>
 <20210202171748.1062530-2-alexander.deucher@amd.com>
 <MN2PR12MB454926B93FE2B67447AF46A197B49@MN2PR12MB4549.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB454926B93FE2B67447AF46A197B49@MN2PR12MB4549.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 4 Feb 2021 09:37:22 -0500
Message-ID: <CADnq5_NH0ezDtVhOE-teJZBZNdDV22is1jVkaKxe7pcof8-qbg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
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
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 3, 2021 at 2:56 AM Lazar, Lijo <Lijo.Lazar@amd.com> wrote:
>
> [AMD Public Use]
>
>
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
> Sent: Tuesday, February 2, 2021 10:48 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and DPM_FLAG_SMART_SUSPEND flags
>
> Once the device has runtime suspended, we don't need to power it back up again for system suspend.  Likewise for resume, we don't to power up the device again on resume only to power it back off again via runtime pm because it's still idle.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index b4780182f990..b78847fa769b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -206,6 +206,12 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
>                 if (amdgpu_device_supports_atpx(dev) &&
>                     !amdgpu_is_atpx_hybrid())
>                         dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
> +               /* we want direct complete for BOCO */
> +               if ((amdgpu_device_supports_atpx(dev) &&
> +                   amdgpu_is_atpx_hybrid()) ||
> +                   amdgpu_device_supports_boco(dev))
> +                       dev_pm_set_driver_flags(dev->dev, DPM_FLAG_SMART_SUSPEND |
> +                                               DPM_FLAG_MAY_SKIP_RESUME);
>
> Device runtime suspend callback does -
>         amdgpu_device_suspend(drm_dev, false)
>
> System suspend callback does -
>         amdgpu_device_suspend(drm_dev, true)
>
> One of the effects of this flag is for KFD to decide whether to evict all processes. It is done during system suspend but not during runtime device suspend. Will that have an impact if  the system suspend routine is skipped in this way?

+ Rajneesh

Can you comment on this?  Idea of this patch is to not wake the device
for system suspend and resume if it's already in runtime suspend.

Alex

>
> Thanks,
> Lijo
>
>                 pm_runtime_use_autosuspend(dev->dev);
>                 pm_runtime_set_autosuspend_delay(dev->dev, 5000);
>                 pm_runtime_allow(dev->dev);
> --
> 2.29.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C8a6f7c5bbab84c6e71c408d8c79e7edd%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637478830856688013%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=55Rfj9pO3cnGBiB1DkJ9yuyMMrKOvxhgYDajhIeUNkI%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
