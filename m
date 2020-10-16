Return-Path: <SRS0=ko+j=DX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0631C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 13:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D77620848
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2020 13:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qXlPn3AX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D77620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D196E175;
	Fri, 16 Oct 2020 13:56:51 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02ED6E175
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 13:56:50 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id s9so3025652wro.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2020 06:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OyifPmoE/Fa8lRr7leFdB9vAzuYXSH/kDLfgSYPjxlo=;
 b=qXlPn3AXP+SKy/BQIfa4oMToKIEfXdzW12B98I+kaQjGXbeHn9+6ouwDqrKiVIWSbP
 L8SoV5C8L+GdCNGeq78zJtjmtmr10uG6Nd0KM38g9Wdmsu6TkdRZAm1UnQQ5/h7+VTJ/
 dC7skRDfaKi9kYHGmdc5uFWPdOpaN6sxYbNQmRdlAXs6mWi459PLwewqNkxBhepVvuh0
 Ajq5J4Hm4u72H0byqjMrIAWAYVBCFXoq+ZOBelge7AkFOAI7nIPTMdCp0+0ysNMa27cu
 5hxE0hwzL6KhVzy8o/W/N/iOOMVmGat2nOfHdbf6neHh4vTrOt8UkDTnoXM5MKPZ10KU
 QrgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OyifPmoE/Fa8lRr7leFdB9vAzuYXSH/kDLfgSYPjxlo=;
 b=SfJFYCGfWche7q2Rf0zEukiFlLhkwAAMCLYb/z+2SsKmpVoLu6s4NbNNkZRL/et2YS
 a7NMBA/vK+2yk6iQ4kZ2D8YdXpHoM9UV1h4xVdLNhYrozzefvf+D0OUZ1n5gQ0J0nu6o
 Lvj8F9DpOIqx4a0yRSA0L5YJJNGY0VYOWhWXZRoFUCCc5fh4DySNKxguVQOyoA0KTDfH
 zctxuB6NJSgVYGyt/kwhohaR+Nevq6m0xoshdmZn185zjMgvoFAUTyQW6Tx0W501tPPN
 7abodaYhRIjjsZSWuDOMPxwpWjhfkDvt7byF1qYAusU+q9k+uXNJkLuvEHkcdfg/xuK4
 41zw==
X-Gm-Message-State: AOAM533H+e4NikrDqO5mkXkwbVYIGktlOqkYb/uTgcvP7bWqx743u3fY
 vuQIS/jMgEK70ENTjG/u4L9DTzpOoLkuAVbxthk=
X-Google-Smtp-Source: ABdhPJxczbVF9CqxF+d+wKZmAOIHtQxhqZ0OWV0gPkMeVku1in5yvCF7+KztQ4xOn8xrCHhGL9TjZReDXMF/QvRoPWo=
X-Received: by 2002:adf:f246:: with SMTP id b6mr4087958wrp.111.1602856609286; 
 Fri, 16 Oct 2020 06:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201014135242.24619-1-nirmoy.das@amd.com>
 <20201014135242.24619-2-nirmoy.das@amd.com>
In-Reply-To: <20201014135242.24619-2-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Oct 2020 09:56:38 -0400
Message-ID: <CADnq5_PaAf=+Y7=kJRcw-UijS2_6=693_QUNzuj_QoYM3WdG6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: enable only one compute queue for raven
To: Nirmoy Das <nirmoy.das@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Aaron Liu <Aaron.Liu@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 14, 2020 at 9:53 AM Nirmoy Das <nirmoy.das@amd.com> wrote:
>
> Because of firmware bug, Raven asics can't handle jobs
> scheduled to multiple compute queues. So enable only one
> compute queue till we have a firmware fix.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c |  4 ++++
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 11 ++++++++++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 8c9bacfdbc30..ca2ac985b300 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -195,6 +195,10 @@ static bool amdgpu_gfx_is_multipipe_capable(struct amdgpu_device *adev)
>  bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
>                                                int queue)
>  {
> +       /* We only enable one compute queue for Raven */
> +       if (adev->asic_type == CHIP_RAVEN)
> +               return false;
> +
>         /* Policy: make queue 0 of each pipe as high priority compute queue */
>         return (queue == 0);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 0d8e203b10ef..f3fc9ad8bc20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4633,7 +4633,16 @@ static int gfx_v9_0_early_init(void *handle)
>                 adev->gfx.num_gfx_rings = 0;
>         else
>                 adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
> -       adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +
> +       /* raven firmware currently can not load balance jobs
> +        * among multiple compute queues. Enable only one
> +        * compute queue till we have a firmware fix.
> +        */
> +       if (adev->asic_type == CHIP_RAVEN)
> +               adev->gfx.num_compute_rings = 1;
> +       else
> +               adev->gfx.num_compute_rings = amdgpu_num_kcq;
> +

I would suggest something like this instead so we can override easily
for testing:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index abddcd9dab3d..a2954b41e59d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1376,6 +1376,12 @@ static int amdgpu_device_check_arguments(struct
amdgpu_device *adev)

        if (amdgpu_num_kcq == -1) {
                amdgpu_num_kcq = 8;
+               /* raven firmware currently can not load balance jobs
+                * among multiple compute queues. Enable only one
+                * compute queue till we have a firmware fix.
+                */
+               if (adev->asic_type == CHIP_RAVEN)
+                       amdgpu_num_kcq = 1;
        } else if (amdgpu_num_kcq > 8 || amdgpu_num_kcq < 0) {
                amdgpu_num_kcq = 8;
                dev_warn(adev->dev, "set kernel compute queue number
to 8 due to invalid parameter provided by user\n");


Alex

>         gfx_v9_0_set_kiq_pm4_funcs(adev);
>         gfx_v9_0_set_ring_funcs(adev);
>         gfx_v9_0_set_irq_funcs(adev);
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
