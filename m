Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C55FC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 13:16:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76C5D1133A3;
	Fri, 22 Jul 2022 13:16:10 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0640712B366
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 13:16:07 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id bp15so8545610ejb.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5XE41gQdPCBU8MKUqSG0o97F3kIyQIsCgKbPGMZ7Dsg=;
 b=JpDaVpTKrr+Eq6w3rPm8nb9aKanSW7ZuH9y01FkBaO/4Z4n7XaSGxN1QHx+d3y1cCm
 Bniv8jUPtWFDuRXyE94xPmhanAjB5T2SADEe/lNDAy0rVFSyTqmxQ8s9OyTW5dFRlwNK
 XwqPzXYZ3/PVXIph92JfrcGvzFen93K09wBIw9+K0bgUFq1hZZA7eLh56K0r+17VtXEm
 TBSDqmSh4zaqEgPVRvV6BZMeD3DNM/rD6+SC26ymk506WMkpB2Q+/0UW8OAzDOemUvot
 uImg7sKhDByLsD/8HrFxT/bZBp6Ew9lJGUwspj59U/W9Omx6P5GfjqfAyr9LkhPEg5aB
 al0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5XE41gQdPCBU8MKUqSG0o97F3kIyQIsCgKbPGMZ7Dsg=;
 b=LKdTtLs2ZlVWcNjJUvemyAWr6dO2etmGEd1/4K52XgKt4zzgJcdw49bv5+0Y8Vg50c
 229lWv8Eg+3LhFYE467PWk8w/q3HClD7hSe7IhrO3brqYYCbD4M551q2ayrpfhLr6PoT
 iP+l/VTBDrTogEiVw4UmVUMwvTIVfj6pNxHesdd7BjH0DK9iG1RuE3pRHAcJRqBjO9E7
 Vwot7kZbkx29/h+Ia6nk+7W4kSo6NGssAjh9pwxBX/kHf3pFvqRR7QlAREvpXXu/9Ody
 kyTurWjjac0NAHRng4yDaKhB47xyHkisS2ld0UmhfEONOd+K/qqPkTtC14knXAaQcI2B
 bKNw==
X-Gm-Message-State: AJIora+nCv/jeStO1TH2Jo3VFMoFFgJct5fBiMO7IEKUaS+7A8xn17E0
 TgygqqqrpAjPqe2Sj+ZVHFZ4kQ38flwuSe3yXAJa/GP4
X-Google-Smtp-Source: AGRyM1uGRulnBj7L6sFX1vO+74fyXeXCVyhbVcBcodV/0eAfDHBfMir3emiCniFmbLRTf3eXWqu60j9KfvZU38xlNU0=
X-Received: by 2002:a17:907:2722:b0:72b:6a93:bf9a with SMTP id
 d2-20020a170907272200b0072b6a93bf9amr444223ejl.424.1658495765458; Fri, 22 Jul
 2022 06:16:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220721095210.37519-1-horace.chen@amd.com>
 <20220721095210.37519-4-horace.chen@amd.com>
In-Reply-To: <20220721095210.37519-4-horace.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 22 Jul 2022 09:15:53 -0400
Message-ID: <CADnq5_PX__UVwQNQOrcWNYYN=JYHr3+h8cTeJ9wZBNeyZGXH0A@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: enable WPTR_POLL_ENABLE for sriov on
 sdma_v6_0
To: Horace Chen <horace.chen@amd.com>
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 Hawking Zhang <Hawking.Zhang@amd.com>, Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Xiaojie Yuan <xiaojie.yuan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 21, 2022 at 5:52 AM Horace Chen <horace.chen@amd.com> wrote:
>
> [Why]
> Under SR-IOV, if VF is switched out then its doorbell will be disabled,
> SDMA rely on WPTR_POLL to get doorbells which was sent during VF
> switched-out time.
>
> [How]
> For SR-IOV, set SDMA WPTR_POLL_ENABLE to 1.
>
> Signed-off-by: Horace Chen <horace.chen@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> index 0200cb3a31a4..23b01b121492 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
> @@ -593,7 +593,10 @@ static int sdma_v6_0_gfx_resume(struct amdgpu_device *adev)
>                        lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
>
>                 rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
> -               rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
> +               if (amdgpu_sriov_vf(adev))
> +                       rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 1);
> +               else
> +                       rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, WPTR_POLL_ENABLE, 0);
>                 rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_QUEUE0_RB_CNTL, F32_WPTR_POLL_ENABLE, 1);
>
>                 WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_QUEUE0_RB_BASE), ring->gpu_addr >> 8);
> --
> 2.25.1
>
