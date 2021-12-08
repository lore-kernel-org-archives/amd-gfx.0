Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2417BC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Dec 2021 19:53:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95EC56E0A6;
	Wed,  8 Dec 2021 19:53:00 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4BF46E0A6
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Dec 2021 19:52:59 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id m6so5589614oim.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Dec 2021 11:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UdWKYTlWCrLsKYCxtOLVeAZal1Bc01Fj6zBtSqK9nJ0=;
 b=DU+Npu2fg/N8qBn7+HDiOBnndjSGlZ8BSdr9thZQeMduJ2BwghuvL3foqxvXlO7Nhu
 fEBqFl0PFy+VSL4pb3gfUF3aIYf+sd8Mxr3evWFW4QI9R1s9I/qe9I/6P0UYt8IaX1PM
 2E/xkJTK1A0ycfFKkgiRZijmvoh6WB4ctuD5w3UlkMNxFJ0u2C/H/kcMH3t7hMFjBEQl
 dXh/3Bt+mVOpD1L5zZNpQy+InLRwx/IcLtIm2DRgHbMhnM/a0zRfTPFKDy963GxyVO5L
 E7wIl6WBCMEFUxH9A2xZAUwp24SeNSrzDCsNKyoxyL9/vtmdPxPNh9Rr5b6DaqobMtlX
 FEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UdWKYTlWCrLsKYCxtOLVeAZal1Bc01Fj6zBtSqK9nJ0=;
 b=klyM3KFOoTFosnDoAjoY88cqfwGbmoH8Bz9UqwuPexpGHw9/L8O6H6DgUhw92P+dMT
 EXpSVc1BUmSMPfiWD1Sw32aP+ffK6omsMCG9BzTZivfmD/RHJ7e7yq6JDlzrON5Qmau3
 wAK1ams7AMGxjFJP2aabIWpmuwLA/XBhpzeAUqy3lm4X/GKxTeuWfW1hin4DVuVjqx+Y
 /cvVWaAlLO8DsLiNYdIlDLHfOLx/BoUBtL20ujGgsj1K+m5a90cApJDegJIQfjGX1BUB
 Ejzx31hhZe1m7B4Ci10pDTIyBx2o3i+MGfOne58bowdvAuwDG819VeyTsudPn9UkvU12
 juxQ==
X-Gm-Message-State: AOAM530VJk2HsfmEw0qM52VOdczQF7AopmObb3Rf8ENHmXmqpJ3VOPVf
 /VwRde3QTElCln4/tl3CFZog/vHGi1agp1mF2p4=
X-Google-Smtp-Source: ABdhPJz9RKz970Tj6/NfwXGG3ayV3xFNytqTLweQkGT9PaJwVhNb0Od/g2uvimthCELS0596OODzlrT85gikjs4gHts=
X-Received: by 2002:a05:6808:44:: with SMTP id
 v4mr1436478oic.123.1638993178563; 
 Wed, 08 Dec 2021 11:52:58 -0800 (PST)
MIME-Version: 1.0
References: <20211208012529.372478-1-isabbasso@riseup.net>
 <20211208012529.372478-11-isabbasso@riseup.net>
In-Reply-To: <20211208012529.372478-11-isabbasso@riseup.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 8 Dec 2021 14:52:47 -0500
Message-ID: <CADnq5_PbM-eS60A9SSuv5FGyABYJGKMwPV79pEcHbDuK3bTfAw@mail.gmail.com>
Subject: Re: [PATCH 10/10] drm/amdgpu: re-format file header comments
To: Isabella Basso <isabbasso@riseup.net>
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, ~lkcamp/patches@lists.sr.ht,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 7, 2021 at 10:17 PM Isabella Basso <isabbasso@riseup.net> wrote:
>
> Fix the warning below by switching header comments to be more aligned
> with AMD's docstrings:
>
>  warning: Cannot understand  * \file amdgpu_ioc32.c
>  on line 2 - I thought it was a doc line
>
> Signed-off-by: Isabella Basso <isabbasso@riseup.net>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> index 5cf142e849bb..cde5294056cb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ioc32.c
> @@ -1,10 +1,4 @@
> -/**

Might be better to just remove the second * above and convert this to
a regular comment.  I'm not sure the DOC section really provides much
value.

Alex

> - * \file amdgpu_ioc32.c
> - *
> - * 32-bit ioctl compatibility routines for the AMDGPU DRM.
> - *
> - * \author Paul Mackerras <paulus@samba.org>
> - *
> +/*
>   * Copyright (C) Paul Mackerras 2005
>   * All Rights Reserved.
>   *
> @@ -26,6 +20,14 @@
>   * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
>   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
>   * IN THE SOFTWARE.
> + *
> + * Author: Paul Mackerras <paulus@samba.org>
> + */
> +
> +/**
> + * DOC: amdgpu_ioc32
> + *
> + * 32-bit ioctl compatibility routines for the AMDGPU DRM.
>   */
>  #include <linux/compat.h>
>
> --
> 2.34.1
>
