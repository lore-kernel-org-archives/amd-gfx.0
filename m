Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA41CA0EE4
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 18:33:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10C6E10E7BF;
	Wed, 20 Aug 2025 18:33:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FyIdVeR+";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E1A410E7BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 18:33:52 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-244581fdfd8so206875ad.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755714831; x=1756319631; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8aRl9t5V6Q7AnpZxPp/thjhXQZ7yIoJiGvCzobrjvA=;
 b=FyIdVeR+dtIkRyvIYexV1UHZb9YjrY8dVNG66vemQPv00wEicNNtHhHoo5vSH/i/HQ
 LwOp/syatY8wX99Y7M1GMLw6jGM/uumN1Mqg6l8hZ6vwF+wcotenEcgOQ3offLLStSpH
 JEb6w7gVPJ1dh4sMOm3Npr5oJURT8ku85EpmDvSl6Qh0wB0l6x3Jt0uA12pJttwoLX9i
 JlNGosHBodpe9sK5mbn3lz9P4UBGEtmvsdBfs3aEfuyiRreyY+hjURIh7SzZW6Qa8TWl
 T61SvqCQP70cKip+GWo6lfOZsbrRw0C+0CN+A/B7eXfEqv1MpRe0ejI49iTy6I7D+hLE
 UhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755714831; x=1756319631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i8aRl9t5V6Q7AnpZxPp/thjhXQZ7yIoJiGvCzobrjvA=;
 b=a5lFTZDPm7h3NgozudItrT/LqyQq/6JaZtx9Gh52x3RYxLGO97ATIwV2emEURxXaR+
 a9Bit+2cNLRzWWrjz+4Tc6s5+VYuIKVXhYwmWgXHCrGPd/n87Ahj6rt3MdXQj+UHFvys
 KZVxhJ9pEvQvoSfaCpS/gZoex+aNUZwDn91uX3ZRy41comffFMmThZ3/+Aizi0/gULe3
 uLqisSF/y0nlnHOhZH+tFMaY5c3QSV4zjbxM8D61auzNyxPQ/u4KMXzgUVpnT6DZ5zC+
 ImOFpCnj1Xt3bAL9hYIiyy+8SO+bJtCgl8HZNsEBYSE1ep0lRt7p4Ht4kmCP1P5dW2h3
 1yuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj8rpgiEgW+2h+bN9oavy+/BZzeLgo0rjw82sa1XP0dNeRJYVHDLIVs6C5DmAsJ8H7buVpcPRz@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxjp41DfEJTkgOI2Ez5jgEnb68LBOzpwuP7vCwHF+RGOPz78cJ4
 Udu9sxmcs+ElsCl3cbp+ZO59U2HQYDZOBXe8jvJ+48QdREGqpcB348xbxmR9cbzgnF5VbhIfRi8
 C+3zcBcAQgkTc0n7XMhWwNDb7//70bp0=
X-Gm-Gg: ASbGncsAOgjZ2ZE8+VqOaXpETAwXMoBmKS9BU+2AFnkq4+sMI7ilatSqMcfxmVaW5Sg
 2Zxy1nxikYQI2GTcjVO/hMFuR2Ol4RTGcYnEdpOtEZ2NBDDPw3Z/HRmk4Ov0BCoYt6EIcM9pAWG
 +Lu2iJvO8nYdPUGLlas+hdPIpWntFg6lqkgPikIenO4K/dovdvmwF7cXQmmxVzqd5sdAJFM0Dic
 /ePbXE=
X-Google-Smtp-Source: AGHT+IHkAy3ca8+jtID/FoWqYaW09/zltQ/aw0SuoLJmcmEe6soi3YAyE7iSaLKvBR0EQAXgHSLAxz7i4pKA8GtkmY4=
X-Received: by 2002:a17:902:c410:b0:240:3c1d:cbe3 with SMTP id
 d9443c01a7336-245ef1117cfmr27184545ad.4.1755714831408; Wed, 20 Aug 2025
 11:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250819211957.17871-2-katharasasikumar007@gmail.com>
In-Reply-To: <20250819211957.17871-2-katharasasikumar007@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 14:33:39 -0400
X-Gm-Features: Ac12FXzaT8tBvm_ZbhXzy1ligYMWZLBJ-gPMSwG1SDqreVmeqsoG3xwj0dX_b9Q
Message-ID: <CADnq5_NJdEtMqMfwW8ZN-nNyJD0dDnB3sYYGHeSb5JnwsUyPTQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/gpu/amdgpu: Fix duplicate word in
 driver-core.rst
To: Kathara Sasikumar <katharasasikumar007@gmail.com>
Cc: skhan@linuxfoundation.org, corbet@lwn.net, alexander.deucher@amd.com, 
 christian.koenig@amd.com, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Wed, Aug 20, 2025 at 8:32=E2=80=AFAM Kathara Sasikumar
<katharasasikumar007@gmail.com> wrote:
>
> Remove duplicate word 'and' in driver-core.rst.
>
> Signed-off-by: Kathara Sasikumar <katharasasikumar007@gmail.com>
> ---
> Hi,
>
> This patch is part of my work for the LFX Linux Kernel Mentorship
> Program (LKMP).
> I would appreciate any feedback.
>
> Thanks,
> Kathara
>
>  Documentation/gpu/amdgpu/driver-core.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gpu/amdgpu/driver-core.rst b/Documentation/gpu=
/amdgpu/driver-core.rst
> index 81256318e93c..bd4be32f2725 100644
> --- a/Documentation/gpu/amdgpu/driver-core.rst
> +++ b/Documentation/gpu/amdgpu/driver-core.rst
> @@ -65,7 +65,7 @@ SDMA (System DMA)
>
>  GC (Graphics and Compute)
>      This is the graphics and compute engine, i.e., the block that
> -    encompasses the 3D pipeline and and shader blocks.  This is by far t=
he
> +    encompasses the 3D pipeline and shader blocks.  This is by far the
>      largest block on the GPU.  The 3D pipeline has tons of sub-blocks.  =
In
>      addition to that, it also contains the CP microcontrollers (ME, PFP,=
 CE,
>      MEC) and the RLC microcontroller.  It's exposed to userspace for use=
r mode
> --
> 2.47.2
>
