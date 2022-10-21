Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C177C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 14:57:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CBEE10E20C;
	Fri, 21 Oct 2022 14:57:47 +0000 (UTC)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A190910E20C
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 14:57:39 +0000 (UTC)
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-13ae8117023so3824440fac.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Oct 2022 07:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZPKg4nA1oQImeRsX+Bf1fIJhzf/8ugzuPiuwhtZ9+9M=;
 b=LMPpLv9WRIfSNxhfnzr1k88ioqlcKjKbuxNCpi1l35nNdNAiofnIwvd4zRegVLw7ff
 fMWxK5/TRyG6SFn7HNIrPT1B4A6dSxASzg3xCRP/X5etkkQlzdTAunQiNNXgOZjog+LM
 Hd+UH7aEZL1jSOfTJS7Uoup9ApMBpGR/dLIJXBGbPH7midH3EpjcdtgwXKGhOqsU7XNb
 aOLBNWcjQGsMMHx+z21YCP3QcPGf4WcBwFqNVr5u+7YCTSxXrW06E+LxFPXyd+3DfGAE
 dsmRtzFolMdvEPmWz6OZ6ZOJCVLj+j9dcLs1FmZtTnvGZCpedeax4ivymzT5qDHRoK/B
 H1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZPKg4nA1oQImeRsX+Bf1fIJhzf/8ugzuPiuwhtZ9+9M=;
 b=6d8UR8/2ze2NkZXU8iUH2meD1OBMFMC2t38UR6AfKQfT2l1W20gZDWKhRTDWcmC+AO
 s9J8LPthzoyzRq/ug4ThZ75vFvnwvHuH9fk7GsMQ+x8dkKq5Vd/3SJrSI2PU5nIS7iXA
 fWLfhLl6BZ/p03NtFAtM1I3WbN9NRKAe7p8W1LDDvQouSRJ5NIlqWipzhP4fxwjLfHGd
 fv430TI1d+yYnXQ8m1abOGj/xjDRj53HIwDq5dNC/M2y6+8UlUMmD5xjqhJ2A9vHe6Dr
 hj3X4QkKPyNq72XG2pBAk0Uylj0DIRG/1Roya0I9p4q3Wq5UrxZqtQyT8nIA2ExZMS/M
 XMDA==
X-Gm-Message-State: ACrzQf3c5Z6xb5qJnHIR3yZp1rK7cRqwPkstoxivOH+q8eQ4blKDw6nU
 F7KMtniT1Vi4dyj2le0gcze/+FbO2BqX1j8R8tJRpX8OyNc=
X-Google-Smtp-Source: AMsMyM7NXKw772xlcjGM/Mr50EMPYa+Atnfg5C0gZW7CResOCC122gEe2Mv7oTAiCTUVDYxG2jnfOerMPll/Jy1inV0=
X-Received: by 2002:a05:6870:a7a4:b0:136:7c39:979e with SMTP id
 x36-20020a056870a7a400b001367c39979emr12646976oao.96.1666364258956; Fri, 21
 Oct 2022 07:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221021144728.2798803-1-Prike.Liang@amd.com>
In-Reply-To: <20221021144728.2798803-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 21 Oct 2022 10:57:27 -0400
Message-ID: <CADnq5_O4Uw=OK_xtrfnS4idJUWU5MOjUMvn9Uzi2L9D8cskSiA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: disallow gfxoff until GC IP blocks
 complete s2idle resume
To: Prike Liang <Prike.Liang@amd.com>
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
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Oct 21, 2022 at 10:47 AM Prike Liang <Prike.Liang@amd.com> wrote:
>
> In the S2idle suspend/resume phase the gfxoff is keeping functional so
> some IP blocks will be likely to reinitialize at gfxoff entry and that
> will result in failing to program GC registers.Therefore, let disallow
> gfxoff until AMDGPU IPs reinitialized completely.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
> -v2: Move the operation of exiting gfxoff from smu to higer layer in amdgpu_device.c.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5b8362727226..36c44625932e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3210,6 +3210,12 @@ static int amdgpu_device_ip_resume_phase2(struct amdgpu_device *adev)
>                         return r;
>                 }
>                 adev->ip_blocks[i].status.hw = true;
> +
> +               if (adev->in_s0ix && adev->ip_blocks[i].version->type == AMD_IP_BLOCK_TYPE_SMC) {

Add a comment here something like:
/* disable gfxoff for IP resume.  gfxoff is re-enabled in
amdgpu_device_resume() after IP resume */

> +                       amdgpu_gfx_off_ctrl(adev, false);
> +                       DRM_DEBUG("will disable gfxoff for re-initializing other blocks\n");
> +               }
> +
>         }
>
>         return 0;
> @@ -4185,6 +4191,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
>         /* Make sure IB tests flushed */
>         flush_delayed_work(&adev->delayed_init_work);
>
> +       if (adev->in_s0ix) {

Add a comment here something like:
/* re-enable gfxoff after IP resume.  This re-enables gfxoff after it
was disabled for IP resume in amdgpu_device_ip_resume_phase2() */

This those comments added, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> +               amdgpu_gfx_off_ctrl(adev, true);
> +               DRM_DEBUG("will enable gfxoff for the mission mode\n");
> +       }
>         if (fbcon)
>                 drm_fb_helper_set_suspend_unlocked(adev_to_drm(adev)->fb_helper, false);
>
> --
> 2.25.1
>
