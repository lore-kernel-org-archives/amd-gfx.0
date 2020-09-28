Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E633C2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 21:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24DD02083B
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 21:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsAs2PO/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24DD02083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6EF889F01;
	Mon, 28 Sep 2020 21:44:41 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B47E89E52
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 21:44:40 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id e17so2555616wme.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 14:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dmXDcQvX3vsEClABhMyzD9jpM9QSz96XMN8+2KDBZGs=;
 b=RsAs2PO/Fo6Z/knLGqqK2JNt1nkASkDU/4J6FjTuyFDhMbH0ecZWzrKZxtVHFeOtb6
 dCABvcbfvJfRCBU47GPFXqrsVb9I3q+vY6Sve1qs84rniAheLp+xotwbFBCQZ+py8Hnx
 gQREjQLUpaFM0q9vjrcYdsONOuOGA8FOyx2vJg+vGbD7RfFiHzybi59QVCBTsGBKEljE
 zsjU+LuQgmFlRBL96Rk74R3OOIQHxyruNDizemvCsn995lUy3yGqZ/VELENmszn6l0nG
 xUb9xkcg5QJEvhXv0FAtw0gcdXT3dF08vamhDwaJPJjmYmkf3dqdCLMfdy4zYpFiJV6Y
 YK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dmXDcQvX3vsEClABhMyzD9jpM9QSz96XMN8+2KDBZGs=;
 b=ZAizYJb4j8QzeQfZpoBsIxxbYn0gJ7VfFoNwb37RrfVesCB62cRYYzSGI4TB8cj3wB
 z3QIU0QbVUitMzvzZ1sDsXRuEdmNN06qYFgI3H3oSt9gTBbbB3yB2U/TDk4leiGrbQIw
 HFX8vXyg52Y7O5LXeb/gLOSej11xmETNj3vC5mf4pFWoeFrxQ8l/3VKrjmNtljPfRsJw
 xI8giPTFELuLaM6muAwXEe6NsVtuYs0WNoeFH0ixyLqAhYvGPS9W12MC5SNB80eT0lfu
 1Rmb1t0miQ4AQbMBjekN/H7t6HZv4u60dsRCFoPQ7WdOOfbEHUM/j3BZfDWn9R/36U97
 029w==
X-Gm-Message-State: AOAM530OquXm4Qm1HKA3jEZ0l4waCMRjSPWVhJZK4slwrG/E8CGc7oDr
 cdzt8iG6i6ytuwlmALsYdMMXtCGOk9AoRvkze80=
X-Google-Smtp-Source: ABdhPJwlZKcqa5XKT+QfIn80TGno4fIfB8WcSMpJCIcMGnNS4x1AAKscZdAvVL7fv1K4/CAOqJ5s4Jdk4ITCRws0xF8=
X-Received: by 2002:a1c:7d4d:: with SMTP id y74mr1111419wmc.73.1601329479262; 
 Mon, 28 Sep 2020 14:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200928111037.51ed4aeb@endymion>
In-Reply-To: <20200928111037.51ed4aeb@endymion>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Sep 2020 17:44:28 -0400
Message-ID: <CADnq5_OBSxK=Ds7X-e8xfHUDb0js7vtWbz-y7mabpFg0BhB5kw@mail.gmail.com>
Subject: Re: Regression in amdgpu driver / kernel v5.8.6
To: Jean Delvare <jdelvare@suse.de>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Navid Emamdoost <navid.emamdoost@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 28, 2020 at 9:23 AM Jean Delvare <jdelvare@suse.de> wrote:
>
> Hi all,
>
> I have recently experienced a regression in stable kernel series 5.8.
> The problem is that my display will randomly turn to black after just a
> few seconds of inactivity. I have to switch to text console then back
> to X to recover.
>
> I bisected it down to:
>
> commit b86657e328b601a5b98f8c4c21d108d356dbceee
> Author: Navid Emamdoost <navid.emamdoost@gmail.com>
> Date:   Sun Jun 14 02:09:44 2020 -0500
>
>     drm/amdgpu: fix ref count leak in amdgpu_display_crtc_set_config
>
>     [ Upstream commit e008fa6fb41544b63973a529b704ef342f47cc65 ]
>
> Reverting this commit on top of 5.8.10 makes the problem go away. My
> hardware setup:
>
> 01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Baffin [Radeon RX 550 640SP / RX 560/560X] [1002:67ff] (rev ff)
> 01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Baffin HDMI/DP Audio [Radeon RX 550 640SP / RX 560/560X] [1002:aae0]
>
> This is a Sapphire Pulse Radeon RX550 card, with two Lenovo P27h-10
> displays connected (one over DP, one over HDMI). I'm using option dc=0
> otherwise the multi-screen setup doesn't work.
>
> Looking at the patch, and at the logic of function
> amdgpu_display_crtc_set_config() in general, I suspect that the middle
> chunk of the patch is incorrect. Calling pm_runtime_put_autosuspend()
> if pm_runtime_get_sync() failed is, albeit surprising, correct due to
> how that function is implemented. Calling it right after
> "adev->have_disp_power_ref = true" however looks wrong. The comment
> right before that line pretty much implies that we *want* to keep the
> reference.
>
> So I think we want to apply a partial revert like the following:

Nice analysis.  I've applied the patch.

Thanks!

Alex


>
> From: Jean Delvare <jdelvare@suse.de>
> Subject: drm/amdgpu: restore proper ref count in amdgpu_display_crtc_set_config
>
> A recent attempt to fix a ref count leak in
> amdgpu_display_crtc_set_config() turned out to be doing too much and
> "fixed" an intended decrease as if it were a leak. Undo that part to
> restore the proper balance. This is the very nature of this function
> to increase or decrease the power reference count depending on the
> situation.
>
> Consequences of this bug is that the power reference would
> eventually get down to 0 while the display was still in use,
> resulting in that display switching off unexpectedly.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Fixes: e008fa6fb415 ("drm/amdgpu: fix ref count leak in amdgpu_display_crtc_set_config")
> Cc: stable@vger.kernel.org
> Cc: Navid Emamdoost <navid.emamdoost@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linux.orig/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c      2020-09-28 10:54:12.634245251 +0200
> +++ linux/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   2020-09-28 10:55:40.569906840 +0200
> @@ -297,7 +297,7 @@ int amdgpu_display_crtc_set_config(struc
>            take the current one */
>         if (active && !adev->have_disp_power_ref) {
>                 adev->have_disp_power_ref = true;
> -               goto out;
> +               return ret;
>         }
>         /* if we have no active crtcs, then drop the power ref
>            we got before */
>
>
> --
> Jean Delvare
> SUSE L3 Support
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
