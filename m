Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC73C7EE24
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 15:40:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDD1F10E373;
	Tue,  6 Jun 2023 15:40:43 +0000 (UTC)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3383B10E373
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 15:40:41 +0000 (UTC)
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-558b70c715cso933242eaf.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 06 Jun 2023 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686066040; x=1688658040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zh3kBxccXTUmgGHhltpsCcD3ngoS8S6ot5L8YqHxryI=;
 b=dai4tUhbNEVfamcC2tgpwOejjK6s+WXNPncQ/kFu31i7qY/57AlFRVKJifdlTj/wom
 gmyDGnIRpPcMYRV/aoDPimxrdv9vgWIjzR9XTGAk21DWTUBZI2Hn76VEYOmgasiJsf75
 KbXhCkmbY83bcXKOfHqkvu6VinnT7nr6JABqAm9gI1OBa4/Mr6SV4hisZ3hC9Uyhx/B4
 k+JuwfguXoywjacWazrkCJ2mLIUz5LOw2VPSUjmSIIq4X6BBQBZ4wEr19ekX6/Me3S7R
 8g2/H7LkgfQZZt44yV9h7cdW7nZhsrAKZy4/O2HS7eRMjDlkY8DkC2v51e1dlaOwAeJi
 6hIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686066040; x=1688658040;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zh3kBxccXTUmgGHhltpsCcD3ngoS8S6ot5L8YqHxryI=;
 b=hOwfAVKmj76TOXx3sDezCdwCIZsEk+9pml9LaoOEDj3s+68+4q4AcyWWYbolJUCiXk
 Sq/4VMbB1sdRflMrUOwTFUUTXkk//T5T4/UWJ0y7CzYq34GF8JwqOoP/a436seme1sDl
 Qx0+LurKAzK+09TGA8lStXIL/PvQ/SJweOdERo2X65IPl6SJ1XzZfEcUyMvFGVjBKTMS
 tYCvPdLxmCDWLn2w2MAHOJKvURD9r2DEk9KTmpEY29NmI+sZoCOsMFrgvV3VWFhOyKc7
 CJA6zhM+r9FXUewZukb2ewY28FCFuiXRd+3XG/Y3v0vYpd/3qjffsFQG/XQeiqKx6Inx
 YYSQ==
X-Gm-Message-State: AC+VfDxSD6qHvUnkZBcrtKj7zDB8BphGO5xl9Vm312jKZPat569P7/2e
 nPAwF0jsApqlQagaHxoXpVHAC1dvpareRkptwr8=
X-Google-Smtp-Source: ACHHUZ6VfPj8iLdehjBXyJS9KSlJJjcb4iem4o/dtigdSiJ3+bgijf3m8mi19CtumHXAr9pRRH20bBTLufi9bqjshR0=
X-Received: by 2002:a4a:c20c:0:b0:558:af69:6b7e with SMTP id
 z12-20020a4ac20c000000b00558af696b7emr835947oop.0.1686066039934; Tue, 06 Jun
 2023 08:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230525165219.544671-1-alexander.deucher@amd.com>
In-Reply-To: <20230525165219.544671-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 6 Jun 2023 11:40:28 -0400
Message-ID: <CADnq5_PVG5tTSYc79_TMR9cY_kuame+asdG9SjRR1tih9DYVRw@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add GPU page fault query interface
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

Ping on this series?

Alex

On Thu, May 25, 2023 at 12:52=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
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
>
> Alex Deucher (3):
>   drm/amdgpu: add cached GPU fault structure to vm struct
>   drm/amdgpu: cache gpuvm fault information for gmc7+
>   drm/amdgpu: add new INFO ioctl query for the last GPU page fault
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 16 +++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 45 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 31 +++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 ++
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 11 +++---
>  include/uapi/drm/amdgpu_drm.h           | 16 +++++++++
>  10 files changed, 126 insertions(+), 8 deletions(-)
>
> --
> 2.40.1
>
