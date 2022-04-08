Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABFEBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Apr 2022 17:25:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215F810EB13;
	Fri,  8 Apr 2022 17:25:35 +0000 (UTC)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0622E10EABA
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Apr 2022 17:25:34 +0000 (UTC)
Received: by mail-qv1-xf2f.google.com with SMTP id f3so7986999qvz.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Apr 2022 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lU0csIEsZDzE41MwkALBCybhlERErvcPF+sfVBonqHs=;
 b=NM88+nbc35Zqm447HFRboPxAt50UQeRlmnPlgfN20A29ljQsY9vkOMUn+VGqIdiWmY
 Dcn8FOGQwYIcz83pr07P1FQYr6vwSF168HwNftLKO4abFG8/IwPYns3EvDN/fcJxbIbY
 w7vIf4RBx1g4q3Ri2kXbLAXvpdEwJy1duKfUJOEWtvx9rfX3Exe/iecmR4HWTjR04Ani
 /Smkf5jNYD6+B+EzB8Q1X9JR50QuruKTnTU6dno+QdtD2FxdZem31j8NxXnJ3scSE4kw
 B43o+ngT5M6F8XdvPxgHNI7EdJSlPinoNv2vkzs7G4rHMYRsy1eIXoGixwbv95JVebLQ
 Wi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lU0csIEsZDzE41MwkALBCybhlERErvcPF+sfVBonqHs=;
 b=O5OkSp7Y8nzYAW04WKevmbhUSlWTBhmgJdiQtZCzQxOBgMKlVpRfDKDJdzNEY/ubOD
 5SDYgARovMoiLqRexjF/OGv3i/78+N7BT6N0kOKYNBWFfAEcNvUasimM8sy3VfeMftjg
 K3/xrIWWJGGRyFo7Lwqs788R+O/eQP6kTgfGC2QuUS8QKzQkPsDda7ymoU838dB0k6Rg
 19cvis/t+1JMHW6O26e3bNvG5ADCFVQD/EElQmX5o+qs/SgoGIm4TsF/9yruibgClQ4D
 W2pHnz7N/adrmFScKV0iHQCqp0aGpOOA7gcp7fLslLSTQ9W8mz4vdtUMePFmRq2wXpTz
 xu8w==
X-Gm-Message-State: AOAM530As4E8p9PSMpAHpTxfYQ0OzLU2HhLPrETGW99EeTEO6hgKCyEj
 R2Y8WcVwUcIAgTSKnflDZY2YQKZpy5ztD0IGDdEtK7o8HRrbtwKd4k5lkw==
X-Google-Smtp-Source: ABdhPJwsC8qGfq7jporc/xc6KftTZwUAsHdQsV0w1jvXD4QNmiObbUO6QV0MUeae7mZ/1a1STd2v+f/xOoq03oWzOuA=
X-Received: by 2002:a05:6214:20a6:b0:443:5818:ade2 with SMTP id
 6-20020a05621420a600b004435818ade2mr17297303qvd.84.1649438732926; Fri, 08 Apr
 2022 10:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsNVp=R5zC9B3PXWJ5nddtt3gkRzDsAsRKvhXq7exGjSAg@mail.gmail.com>
 <f3bc34e1-0eaf-84ef-486e-b7759e60b792@amd.com>
 <CABXGCsOD+tDdFcM37NP_1nS9eLym7qC=jUQy3iqYkc1m2iQgxw@mail.gmail.com>
 <0d5f66d8-9852-b6a9-0e27-9eb9e736d698@amd.com>
 <CABXGCsPi68Lyvg+6UjTK2aJm6PVBs83YJuP6x68mcrzAQgpuZg@mail.gmail.com>
 <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
In-Reply-To: <eef04fc4-741d-606c-c2c6-f054e4e3fffd@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 8 Apr 2022 22:25:22 +0500
Message-ID: <CABXGCsNNwEjo_dvWJL7GLULBPy+RmwsC9ObpowR_M1nQ3fKt3g@mail.gmail.com>
Subject: Re: [Bug][5.18-rc0] Between commits ed4643521e6a and 34af78c4e616,
 appears warning "WARNING: CPU: 31 PID: 51848 at
 drivers/dma-buf/dma-fence-array.c:191
 dma_fence_array_create+0x101/0x120" and some games stopped working.
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: thomas.hellstrom@linux.intel.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, Ken.Xue@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, 8 Apr 2022 at 19:27, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> Please test the attached patch, it just re-introduce the lock without
> doing much else.
>
> And does your branch contain the following patch:
>
> commit d18b8eadd83e3d8d63a45f9479478640dbcfca02
> Author: Christian K=C3=B6nig <christian.koenig@amd.com>
> Date:   Wed Feb 23 14:35:31 2022 +0100
>
>      drm/amdgpu: install ctx entities with cmpxchg
>
>      Since we removed the context lock we need to make sure that not two
> threads
>      are trying to install an entity at the same time.
>
>      Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>      Fixes: 461fa7b0ac565e ("drm/amdgpu: remove ctx->lock")
>      Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
>      Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

The all listed games are now working with an attached patch.
Also flood messages "WARNING: CPU: 31 PID: 51848 at
drivers/dma-buf/dma-fence-array.c:191
dma_fence_array_create+0x101/0x120" has gone.

Thanks.

Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

--=20
Best Regards,
Mike Gavrilov.
