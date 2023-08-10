Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30517C001DE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Aug 2023 19:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD5A010E5D8;
	Thu, 10 Aug 2023 19:36:05 +0000 (UTC)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66A5110E5D8
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 19:36:04 +0000 (UTC)
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6bcb5df95c5so1176129a34.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Aug 2023 12:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691696163; x=1692300963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ykWm2eRmQk7s6zbZPdLdkyvf+pdb6tW5Uxthzg0I2Oo=;
 b=dr4FO9JjUKHqZwxM+aYACEnNNgfaSgRrxJMbXhfnoFj7MAjRbvsvhGrVDyGU7wTqJa
 34RX4vgIiCGjK8jfUltqRo5stPItSGfOWh59n5HVzol0HCzVPIKRUWY3++VbaIZofJ3F
 HFyxbmVMjbZhBXm1yrjKAJrVsYKG8JuZHuYINV0FoDblA866xhoUjwYgZ9XKMJfRVKTq
 ZH+rjn4c+pTSPlY89QUSm5hs9NrJuhTSoh/Y/eAXxmn+GiWKrUjfG1ZgRhwrvkd2itl5
 nr3VpfZXJrlzBgXk8D761Eh+fQkKOoac2Tl5Cv/siFUyus3Y9rFJ13f9RSXSnmbyzEg9
 us8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691696163; x=1692300963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ykWm2eRmQk7s6zbZPdLdkyvf+pdb6tW5Uxthzg0I2Oo=;
 b=ECmD3O1l0Y1w9s6JH6RbjTTFnept6JyyEAgTidhlXzrfS8UupuPgBx2TpQY5kr1zre
 VGkxKUWA2JNlqIAv+W3yCouvrsGLhiw7QwAcMbzGKcj+rEyxsYu+GAVuToe2xGeGUKbS
 bUfg7i/8yaNsXZokNFcV1WBxeWRcBVo6CJ11bfX8C3NllFKHo10rvlCambNwj38Ug57b
 VePl41NMlQ7/09hdNQEORY/iDlnJj12hAOu713qI51ACgXCvuNUuotXZmVKZruTj51Fi
 iQdrStkaHFs18ZW7j9LWdfIv8PHxDho9VlyaLpSqRtKfL0GCZbLg4unnBFMLPjDK7TWD
 sPGg==
X-Gm-Message-State: AOJu0YyA7JYVHsX3HVL3sc+i/y96C/wCyW/HL/YRb+MtvgT8UFsBzNAc
 nOcIKa8mZZEf9qL9kRetQEb2hRYyev50jJGQJkE=
X-Google-Smtp-Source: AGHT+IHLFK6rl5g54TNw1PmCBOr5GBUmQHsuZXYtP8SkfuCzcoZQ3Lp6kDvD13o2lcStZskamhLPq0ftjW3L8vTHj0o=
X-Received: by 2002:a05:6870:184e:b0:1be:ceca:c666 with SMTP id
 u14-20020a056870184e00b001bececac666mr4013677oaf.14.1691696163282; Thu, 10
 Aug 2023 12:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230727181048.1222388-1-alexander.deucher@amd.com>
In-Reply-To: <20230727181048.1222388-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 10 Aug 2023 15:35:51 -0400
Message-ID: <CADnq5_PqB9Tehv_+c+cV9_8h3fm-b6+f39HLzQrXB54MTYGkkA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Add GPU page fault query interface
To: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: samuel.pitoiset@gmail.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

On Thu, Jul 27, 2023 at 2:11=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This patch set adds support for an application to query GPU
> page faults.  It's useful for debugging and there are
> vulkan extensions that could make use of this.  Preliminary
> user space code which uses this can be found here:
> https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23238
> https://gitlab.freedesktop.org/mesa/drm/-/merge_requests/298
>
> Note, that I made a small change to the vmhub definition to
> decouple it from how the kernel tracks vmhubs so that we have
> a consistent user view even if we decide to add more vmhubs
> like we recently did for gfx 9.4.3.
>
> I've also pushed the changed to:
> https://gitlab.freedesktop.org/agd5f/linux/-/commits/gpu_fault_info_ioctl
>
> Open question, currently we just expose the raw GPU fault status
> register value for each GPU so UMDs need GPU specific knowlege to decode
> it, although it's largely the same across generations.  One option would =
be to
> translate to a generic GPU independent fault status.  Opinions?
>
> v2:
> - Fix spelling typos noted by Guchun
> v3:
> - Add locking in IOCTL query
> - Only update cache if fault status is valid
>
> Alex Deucher (4):
>   drm/amdgpu: add cached GPU fault structure to vm struct
>   drm/amdgpu: cache gpuvm fault information for gmc7+
>   drm/amdgpu: add new INFO ioctl query for the last GPU page fault
>   drm/amdgpu: refine fault cache updates
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 20 ++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 50 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 31 +++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 ++++--
>  include/uapi/drm/amdgpu_drm.h           | 16 ++++++++
>  10 files changed, 135 insertions(+), 8 deletions(-)
>
> --
> 2.41.0
>
