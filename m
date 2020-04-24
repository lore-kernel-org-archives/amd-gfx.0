Return-Path: <SRS0=W/Sk=6I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95AFC55194
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 14:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C95620776
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Apr 2020 14:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAxjbXch"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C95620776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E5989C3F;
	Fri, 24 Apr 2020 14:03:12 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D08389C3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 14:03:11 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id u16so10858074wmc.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Apr 2020 07:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xlDXi5nG9tZSH/2w5PdbxcQle2H7CifsinEdamvBtu8=;
 b=QAxjbXchTTxsp7YWv5etGQadR1bK/U7q9IlranWy+kqGZb+aZfHWJmHbmYc0TuSQLd
 f0jpOZqmLCMGjQHvUIWtpKsDhSAUY0+oqb3skx75TP96c7c7p2OB4xhlhJHIpdu/O1yN
 Mw9Nb/XSIJeIQ3oDlB4OmykA+IG+0ru2f0hIHCrUJFpJZgD/5NGEs/cZDvypw5wKAeV6
 W20xEeSXbXPlex/v8FoxVONcI8NiGlZQ1W5faT38fzbZVIQq2WdSUfOxi+Ipr8+JNsqY
 pCFvsV+MOTLzO92OOxCDOm6JBvkgLvviJtFIhjF+p2W1qUAjDnTxu9GTpwSJCrYaHM9X
 B/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xlDXi5nG9tZSH/2w5PdbxcQle2H7CifsinEdamvBtu8=;
 b=VvLkcVNfxAMfRSFiApNvKzPClKU/E9G6rAJYDXcosoD8SWi71+9FYWKUPS+seltnlz
 klFm/YrhHQZSMmTx8udyi5zb4B8vZeyifXCB1WLH40QCZmBxdVNh+Tg7hHXf+zLvMEsK
 FxeGk/8Lk7LnIwboJZ5YaC3NQCU4u1mbAa2iD9kMXfPsupJZgj+/i9/C4idNAdA0T8ps
 CjRfY3K2uktmyueEQpjeiXjhYdOVQWDA/tNeOQwI02fxKCNZwX7AmHtqUPY5q+6OPpa1
 GvX8G+4WH7Rb0qU+efdCX+GluzWoTLOTce1UpPD/3uvlr5+Cd9vxPTDLGi9/U+BATjr1
 HKiQ==
X-Gm-Message-State: AGi0PuYPFKvIRo5yENvF/VFyjF+sTAdow/DZkEDNUEPT0w9d2JbS4kXy
 nAHWZ8nNlP2jvrmWdM1ptPpG/JtobyWjSDXjX2TBPjDI
X-Google-Smtp-Source: APiQypLGAupxkYdK9tht6JhZ1PimN+V0Y3ZY1S8A96VYa1x11viZREs3uVMEx/qc09DQ1VzRRPWoUryrMoVz+IR+76o=
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr10326757wmh.39.1587736989984; 
 Fri, 24 Apr 2020 07:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200424080547.25599-1-evan.quan@amd.com>
 <20200424080547.25599-2-evan.quan@amd.com>
In-Reply-To: <20200424080547.25599-2-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 24 Apr 2020 10:02:58 -0400
Message-ID: <CADnq5_PB_1Pef-C923gNut2+neF_1yxXPhzQUCWGvgLsyc1-eg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drma/dmgpu: drop redundant cg/pg ungate on runpm enter
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Prike Liang <prike.liang@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Also, I just noticed a typo in the patch title:

drma/dmgpu -> drm/admgpu

Alex

On Fri, Apr 24, 2020 at 4:06 AM Evan Quan <evan.quan@amd.com> wrote:
>
> CG/PG ungate is already performed in ip_suspend_phase1. Otherwise,
> the CG/PG ungate will be performed twice. That will cause gfxoff
> disablement is performed twice also on runpm enter while gfxoff
> enablemnt once on rump exit. That will put gfxoff into disabled
> state.
>
> Change-Id: I489ca456770d3fe482b685f132400202467f712b
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 08eeb0d2c149..71278942f9f0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3453,9 +3453,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>                 }
>         }
>
> -       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> -       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> -
>         amdgpu_ras_suspend(adev);
>
>         r = amdgpu_device_ip_suspend_phase1(adev);
> --
> 2.26.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
