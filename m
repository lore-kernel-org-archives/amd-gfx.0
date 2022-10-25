Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFFAC38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 13:34:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99DFC10E148;
	Tue, 25 Oct 2022 13:34:56 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B73F10E148
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 13:34:54 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id y67so14195485oiy.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 06:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ocGYehJ7XDLTck5EN4M5oVWE4+l3CHwUl66h4ItjhOo=;
 b=lji167deRi8fr0BgJS0N+JkQS5Tzjd8h+Xzrt/i31A/yF1HW0brcKyp/R7HTOu7L4Z
 USGu7Jxj9MXUAUoNm5qszXoExml+zhDgpavbDnpQBnxacToTcYMmUZUAVIpTkKMsr0nM
 M/FyhxFbzHift1FGahC+iNtxX/Im+XJLzR/oyKoGV+ygkAIFGjqKMOnRF2wXTtZ+1syy
 Rnh6+lkb+MiVE2eyEMm3/LxwAEYcrc0RsyO84OYOyB4cdeRl+lIVo0fJQ3ImAhc7RnZ6
 zJ0HGck8JtX6xlRSXfonb+wmnwfEZGr+/9Yl0AAuziL62m6kAk5rINnoIIcKQBoZPC7W
 IrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ocGYehJ7XDLTck5EN4M5oVWE4+l3CHwUl66h4ItjhOo=;
 b=6gtwVzGUwWjbuExA0xZaDtfc3UAg7UwgavSt32yP6Oc5VxkEVxLaSimpJaZd0MA4V5
 m/UYArZlsFoRqnbnygb33SpMvWi1UdFnEP+o0jw30TKeGlIoIcFf02ytSuPedcJlJko9
 GNaDgmOiUIGH3Wz/x2lqR7q70zbzTWdxOifb07Yb9ECv3b2GNXPp+yXjCEn8LH0iUbz0
 a7CwYdm/Km9C+NMbkvrK8vBauYjDezWUEfj3qMUPSGBC2GTrWSnSkxm/9L4hu+mjMH74
 WLrOa6DdJp2QjbwiSpfRsUuDtJv8XZEWLdO+q3SDJIE6ofUXUnu9ReM/BMMn+8fR7aSk
 fTsQ==
X-Gm-Message-State: ACrzQf0zIIt/Mlrg+f7t2NHGefWTvyy1EaCK67BT4Ln6zUNXnsW+Hx4H
 I/IB8oRJ12UxZsRJI8wlabRseNced5ryKlQ0Jigsa55+
X-Google-Smtp-Source: AMsMyM57f6RoHFiOvlrxk6SVmx26nCwMXvk4xrTVr54Ur9QGyk1wybrjPeZG1Qi9MgcYZynN9aaVj3mUMV0yD9jXOp0=
X-Received: by 2002:a05:6808:14d2:b0:354:c733:abd3 with SMTP id
 f18-20020a05680814d200b00354c733abd3mr19020560oiw.96.1666704893373; Tue, 25
 Oct 2022 06:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221025082824.1509079-1-Yifan.Zha@amd.com>
In-Reply-To: <20221025082824.1509079-1-Yifan.Zha@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Oct 2022 09:34:41 -0400
Message-ID: <CADnq5_NU94+R0ZJ1CQOiR-kBPhN95teD19qofDxBFhDz+5K_ng@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Skip program gfxhub_v3_0_3 system aperture
 registers under SRIOV
To: Yifan Zha <Yifan.Zha@amd.com>
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
Cc: Alexander.Deucher@amd.com, Horace.Chen@amd.com, Hawking.Zhang@amd.com,
 amd-gfx@lists.freedesktop.org, haijun.chang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Oct 25, 2022 at 4:29 AM Yifan Zha <Yifan.Zha@amd.com> wrote:
>
> [Why]
> gfxhub_v3_0_3 system aperture registers are removed from RLCG register access range.
>
> [How]
> Skip access gfxhub_v3_0_3 system aperture registers under SRIOV VF.
> These registers will be programmed on host side.
>
> Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> index 5d3fffd4929f..716ae6f2aefe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
> @@ -154,6 +154,9 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
>  {
>         uint64_t value;
>
> +       if (amdgpu_sriov_vf(adev))
> +               return;
> +
>         /* Disable AGP. */
>         WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
>         WREG32_SOC15(GC, 0, regGCMC_VM_AGP_TOP, 0);
> --
> 2.25.1
>
