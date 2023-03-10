Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C876C6FD1F
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Mar 2023 03:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3048610E92E;
	Fri, 10 Mar 2023 03:14:38 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED1B410E92E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Mar 2023 03:14:35 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 m25-20020a05683026d900b006941a2838caso2236269otu.7
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Mar 2023 19:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678418075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2LyM7BULV2JC3rftuwHvCUA32nmzc/4IzuvOLnf/7C4=;
 b=ono5Tr3B8X4Ve13f89suWC6omkmRo4f7Bo1Vihu/vAozpXFpH3E7zDDAupOea3LoNd
 RTy2elZmEb3CmTTkeaexNfmsuYAyIXxuGmteJToJZkBk00eVm5D2iazZY79HiJMcayzG
 xMfvSE6Sp/7mtF7Kp2PA6Qz6oAHyV0BRK+JpWhakW6vhgX3t9CH7XouLeGbo3OD8EKuV
 gN1n4Y62hQV8ZSE+V9G7yHBy8Pk+LbxQHag4YM3WsxXZiqZdsw73ImK/YdhwgA8NB6J/
 j9gRfWHcl9gkAESw6PhL0YfTEvBTDKfi6O4y5iHdxy9vWPXaucHVgJMv7q5sp7teB4nE
 RJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678418075;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2LyM7BULV2JC3rftuwHvCUA32nmzc/4IzuvOLnf/7C4=;
 b=OByjvqW5bm2tQO5uDpe7XoaqwY1VLfuONdBjCUM35oe8+V+dOoUEIuBx80Iw5OVML2
 b3sRgJLlS5nq0Ob45jzHr5PxkZN0uEDlUzgOVTSEYFCEnEPbRolNU9LFrLedMWzewRYw
 ZOTzmrS05a/uaYt7SZElbJ62Ge8qk9+HKjGNpclJTVwqGbvqEoJCnPUEWIASTS9V34vF
 pbnJlhqxcnVXvUE9WtNW9JI+oaheBKaRoMrN2VIOhXLHw79XjSooVqbisK3nOqxU4dtT
 KUw1ekk1eRF9IMthJQ+NIj4NEe0bsfdFZPDqvvPSsIhSH486U+5CxTtGyCUL45Izu98w
 H/HQ==
X-Gm-Message-State: AO0yUKVa1FM/fnAeoDdJ+jVg1wvzdvkDUcOX8bHqHUMJBQN+V6Lhg/Jy
 8gB5xYXeBgVEg8AY8UVMBjqvs/tAl7AsTlKjcPI=
X-Google-Smtp-Source: AK7set8+UVMhlifFjoRQrSG0CManeQmIoxsiFdNybKptG63v7Ln1YpW2cqjpSAwJt5N/D0u3jf8xNJ1NvstWyOb4M6E=
X-Received: by 2002:a05:6830:3347:b0:690:ee75:741b with SMTP id
 l7-20020a056830334700b00690ee75741bmr8090663ott.6.1678418075202; Thu, 09 Mar
 2023 19:14:35 -0800 (PST)
MIME-Version: 1.0
References: <20230309035021.1860501-1-alexander.deucher@amd.com>
In-Reply-To: <20230309035021.1860501-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Mar 2023 22:14:23 -0500
Message-ID: <CADnq5_PLiokwzsa-zUmv-LRHYkCZMCw5odP-21m-d_CXnJcs8g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/nv: fix codec array for SR_IOV
To: Alex Deucher <alexander.deucher@amd.com>
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
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 Abaci Robot <abaci@linux.alibaba.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Wed, Mar 8, 2023 at 10:51 PM Alex Deucher <alexander.deucher@amd.com> wrote:
>
> Copy paste error.
>
> Fixes: 384334120b66 ("drm/amdgpu/nv: don't expose AV1 if VCN0 is harvested")
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4454
> Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/nv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
> index 855d390c41de..22e25ca285f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> @@ -1055,8 +1055,8 @@ static int nv_common_late_init(void *handle)
>                         amdgpu_virt_update_sriov_video_codec(adev,
>                                                              sriov_sc_video_codecs_encode_array,
>                                                              ARRAY_SIZE(sriov_sc_video_codecs_encode_array),
> -                                                            sriov_sc_video_codecs_decode_array_vcn1,
> -                                                            ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn1));
> +                                                            sriov_sc_video_codecs_decode_array_vcn0,
> +                                                            ARRAY_SIZE(sriov_sc_video_codecs_decode_array_vcn0));
>                 }
>         }
>
> --
> 2.39.2
>
