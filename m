Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0B1C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 13:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6F710F2F7;
	Mon, 18 Mar 2024 13:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eNdZGnTf";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53AC210F2F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 13:44:11 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-29fbe140c24so436054a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 06:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710769451; x=1711374251; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nv+GHXq5bzhob0zzctJe7iJvtc6EhBTWxvZ8Lv+aKF8=;
 b=eNdZGnTfrc+fBM/XACqxQdoBoXdMdZdFoSu6K8U3BAYjxJSqbz1hnwMqRW7DTUpRi2
 +RAWTMhtmtKHNlLnAaWFC4TVogxgGyfu6/D7cUoVPKjP0qAcZCc9tUe8OtqeLCccIZja
 T/W/7mk5+k8sfzxXkDg5XIC36H7CNbN0nHayoyz9Vu5Qe6uXdRWW8tXu5yO8LEKY48fV
 HLRyAYsAwpR9FbcJ35CyO0Qj04ST4uAbzZ+jXUFoNC1G3QLCpCGLLJi0Oz/KYzYajFJX
 e5TXbIaYeWaA7ykzgnZbkujRM7Xicm3bDtkKApmXB0DCOnXcX4T4wyXFKDzRigS5Ndi5
 FMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710769451; x=1711374251;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nv+GHXq5bzhob0zzctJe7iJvtc6EhBTWxvZ8Lv+aKF8=;
 b=qRoYeOZCaACShZK5pZ9nCzllmZ5whFLxqV4rkzlzumMxWMJzrxn6NYWUklk4pQ39ya
 pjnktfIhfXktf8XutCFzcoQ1QE0YnjLLPYiKvX3HhZBZOEzjqyk1Cm9KgsSnuCJcyY1T
 Q8SXoxQb0bwkueF7YXeBA1GSGtR+fYXLFGwD02R2aQtwHSRKELw/faM2OXA0W6Sf6ub7
 WwioShX0DYDnueWSIMQwjxgnnO9ls3d5oyYfiXbBR4TfTIxChQepsTaebKU6z+IXBgbH
 LtyLYx5bMy2xGdde14tG3teCCVwRDms136X/QDbUTzBVclhvpB5pNSH9TnbsRtQI96cd
 +9lQ==
X-Gm-Message-State: AOJu0YyAcKPSSbqzSKmZcatunaxef0zxjMOM+QFrzba/eJgU0TddgAYr
 ZY3omYPWqVkbV/r0AE0X5bhXiar5kvA8JCAA7kYCiWS3aL4nQm745232Qv3s4lsLIE1Aa4xTJR+
 XJXE3XEDJITqUtmHdLxwzj25PY3kx9a2p
X-Google-Smtp-Source: AGHT+IF0kSBInP2T4RzYPNdKQWXT2yrvhLw5aj+yzN/L3fHt2rhnoW0Ybmp2DB5GYYmkRGYJPHvZ9PjGlkZN5NZRo/k=
X-Received: by 2002:a17:90a:fe13:b0:29c:776f:8911 with SMTP id
 ck19-20020a17090afe1300b0029c776f8911mr10136587pjb.21.1710769450757; Mon, 18
 Mar 2024 06:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240318103802.3009373-1-Lang.Yu@amd.com>
In-Reply-To: <20240318103802.3009373-1-Lang.Yu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 18 Mar 2024 09:43:59 -0400
Message-ID: <CADnq5_P7uyATE_MwmkFGFFP5CWqcNn_KG_4bA5qrLuxkDa2vrw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drm/amdgpu/vpe: don't emit cond exec command
 under collaborate mode"
To: Lang Yu <Lang.Yu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Lee Peyton <Peyton.Lee@amd.com>, Alan Liu <haoping.liu@amd.com>, 
 Yifan Zhang <yifan1.zhang@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Mar 18, 2024 at 6:38=E2=80=AFAM Lang Yu <Lang.Yu@amd.com> wrote:
>
> Ready now. Remove this workaround.
> This reverts commit 1a2bb3bb2a84f8364f0a8b338afa9b9025e1bcc0.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> Tested-by: Alan Liu <haoping.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vpe.c
> index 70c5cc80ecdc..7a65a2b128ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
> @@ -575,9 +575,6 @@ static unsigned int vpe_ring_init_cond_exec(struct am=
dgpu_ring *ring,
>  {
>         unsigned int ret;
>
> -       if (ring->adev->vpe.collaborate_mode)
> -               return ~0;
> -
>         amdgpu_ring_write(ring, VPE_CMD_HEADER(VPE_CMD_OPCODE_COND_EXE, 0=
));
>         amdgpu_ring_write(ring, lower_32_bits(addr));
>         amdgpu_ring_write(ring, upper_32_bits(addr));
> --
> 2.25.1
>
