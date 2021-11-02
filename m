Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62020C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 20:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2201A604DA
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 20:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2201A604DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7AE737A0;
	Tue,  2 Nov 2021 20:34:48 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3F83737A2
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Nov 2021 20:34:47 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id w193so634573oie.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Nov 2021 13:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=W3Wzhh0a4OhoTS14sFM38OjP3cwmZ7DyDaJsBE8mg+M=;
 b=FXgqpRY05L8Maz6YllRq+VhC1uO591mXdpt5K581z3yixtLY4Av+GhUXDQ/gRPJK1j
 hrQ2m8eYN6zeIIB8SLZstwdR3qVpdrdC/KURjxG6T4ZEsDWMY67O+2X7rEyhQfalVmD6
 RLfP3AsPGX0oNF2unjezAdBt0bplnP99cNaojQM6FU6yWokYX4gTqWpzm9dQPfvnp2Yd
 p8hSP+GnCUf6HHDljkqofIZgZOfwoPKWKvfGo7lbIuVUS9qUMSIoLPDY2XVc9h9NaqnJ
 J6basGHKY2yBlhA2S7ZMeW4PiH/RGV0GhiQ3O2abwvEwMnu3t+uTFeTyfairSZvzUWtt
 mfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=W3Wzhh0a4OhoTS14sFM38OjP3cwmZ7DyDaJsBE8mg+M=;
 b=DKbhyUXD9t6/mAqI14CIDHp+N4AeVpnNbxxdm6RRWUKZgHi3X0LSuLQq0yhUbIW+VT
 f9NcSECwV5Q9LMTDtXyQvy3Q2+6F3lWzIR6Q0cx41dWjo57gnXsEozBP4aDwdabT9p6b
 W/zZPPlbORi+I/+nVwbBxa5+qpm3k31To9McDo09sGv/un+GITKTaSiDXE7hzTG/KLLt
 LWWdltgacU89IZkRq2vuefY5sMIZ5QV3mq+QwnmOs2IpOmsF4ovcHET53FDkKA8PeFJm
 4J99hzu/CORtQq+NVlHfioxmMLB5PjgBW1LoISXjDzHXyvnE0ZZ09KnfFRgEUh+hydPA
 WIJg==
X-Gm-Message-State: AOAM532EII1q/JZkgWaTN8twrJjapYxHQOkOwymCt235BmOj7V9xzZo9
 Uvz5i6tUMZjjbUUUKcS6i/OJHCi35EpTCDQHwYw=
X-Google-Smtp-Source: ABdhPJxISsUfJbATtC+seB35LMMrL2s8ggPw7EOCEQUweT1Pa0mqROgcxYG6+jmTLqK2y4z+07WBnKH1FuSP3DUJ+Bs=
X-Received: by 2002:aca:e08a:: with SMTP id x132mr6893707oig.120.1635885287113; 
 Tue, 02 Nov 2021 13:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211102192324.3402-1-James.Zhu@amd.com>
In-Reply-To: <20211102192324.3402-1-James.Zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Nov 2021 16:34:36 -0400
Message-ID: <CADnq5_OnTAKba1CzcmrzxZZMwzJqn5WyuLqC7kst7qCoD5cYBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amdkfd: fix boot failure when iommu is
 disabled in Picasso."
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 Yifan Zhang <yifan1.zhang@amd.com>, James Zhu <jamesz@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Ken Moffat <zarniwhoop@ntlworld.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Nov 2, 2021 at 3:23 PM James Zhu <James.Zhu@amd.com> wrote:
>
> To revert wrong merge during rebase.
> This reverts commit afd18180c07026f94a80ff024acef5f4159084a4.

Missing your signed-off-by.  Might be better to just merge these two
patches into one unless they are individually applicable to different
kernels (e.g., 5.15 vs drm-next).  Also these will probably fix the
following:
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=214859
Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1770

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 7677ced16a27..be26c4016ade 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -1031,9 +1031,6 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>
>         svm_migrate_init(kfd->adev);
>
> -       if(kgd2kfd_resume_iommu(kfd))
> -               goto device_iommu_error;
> -
>         if (kfd_resume(kfd))
>                 goto kfd_resume_error;
>
> --
> 2.25.1
>
