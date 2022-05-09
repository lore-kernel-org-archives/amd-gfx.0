Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2492C433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  9 May 2022 18:21:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C73410E5E1;
	Mon,  9 May 2022 18:21:05 +0000 (UTC)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 002C510E5E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 May 2022 18:21:03 +0000 (UTC)
Received: by mail-oi1-x22f.google.com with SMTP id q10so949223oia.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 May 2022 11:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=hBID6mzOrDoLafUH349JYKK/SY4mbFyVpy/YFiMqBu0=;
 b=VR81beedGQ3ZK0+NRsObz20HQ5FAA4HWeNX/JQFt61HgNFqxnGep8lOCnpmZdwVSgQ
 4vqiUqfnb0RsEf+4A/Q7y/X5dAa4FQylMVNxtpBFScd+b9ZwJVR6ZPCg/BBDcwipfjh+
 BCrJaGc6zxq1I9PzDjikhFpIlujCrskavaoD78O+XDRoqbE+OAXR6Q5zOsxUaI9tXWwo
 1Y/khoVkXRMqd9j7iuIObW/qwcVeIdd20CJ6lXModCbzCdEpyJwRO0W62Ur2FlJvfR5F
 lG+q+l4zfgXJAJ0lhbhEsmliMgoiyshhXa3rWkZUbw0z8z9vXPzykDeDTGNdJgMIAChT
 G7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=hBID6mzOrDoLafUH349JYKK/SY4mbFyVpy/YFiMqBu0=;
 b=Ow1xihWIBLCuLSD8L9tY1TcnvKs87l4m0xuLLID+710WzLFXnHJGFGMyqGDSZwuTPd
 FcdBnujzQ17YLS4Qp0GKGwWFoGQQblGdadn20Npv5VxBoZdUvoFx2uhhaL/qO8R8BrPP
 SPYqHkM3mxRYjolVnlBt5nAgCXoAxmR7NnCxH9D5pepDyTEAdlTMzO7Gitk5Igx0zgZX
 VQGbFFkrKLawStFm2TWAG8f3i72273duomDPaQ5zWJ9hSAigRKhnVhNcYRmO3VRLHldN
 ALF9NoXh4oYp57pFE5lnmaoGSLVKJiLyN1g4Wk+pjsiKumlDnWwGY1gre3UHhpBDX4jW
 oXFQ==
X-Gm-Message-State: AOAM531mh/J0159/G7A6udpTFEBEJchl2NnKlf9f6HLxHy3HZu3+N/dv
 K8aNE/YstLliB2/M904PZXHLL+9OFBxxF2QOSwM=
X-Google-Smtp-Source: ABdhPJx/iooYE20NZahaggiwdl7R3kIauOnbYazQMdYcQJYgtOTXFdtJnzwGgB9Q8sGzP1cnWLVHRRqNI7fv4pH9Bp0=
X-Received: by 2002:a05:6808:178d:b0:326:3fe9:7f03 with SMTP id
 bg13-20020a056808178d00b003263fe97f03mr11069497oib.200.1652120463295; Mon, 09
 May 2022 11:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220508173008.281673-1-James.Zhu@amd.com>
 <20220509181933.17376-1-James.Zhu@amd.com>
In-Reply-To: <20220509181933.17376-1-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 May 2022 14:20:52 -0400
Message-ID: <CADnq5_MP9cXMBRZQaDE=sVmys3HfvbBd3v6Ey3FE4z58EZXSdA@mail.gmail.com>
Subject: Re: [PATCH v3] drm/amdgpu/vcn: include header for
 vcn_dec_sw_ring_emit_fence
To: James Zhu <James.Zhu@amd.com>
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 9, 2022 at 2:19 PM James Zhu <James.Zhu@amd.com> wrote:
>
> Fixed warning: no previous prototype for 'vcn_dec_sw_ring_emit_fence'.
>
> v2: regenerate patch after git rebase.
> v3: update commit message.
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> index f4f97f0f5c64..1ceda3d0cd5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> @@ -22,6 +22,7 @@
>   */
>
>  #include "amdgpu.h"
> +#include "vcn_sw_ring.h"
>
>  void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>         u64 seq, uint32_t flags)
> --
> 2.25.1
>
