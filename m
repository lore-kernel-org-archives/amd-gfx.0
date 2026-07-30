Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68628C55165
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 13:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F140A10EF01;
	Thu, 30 Jul 2026 13:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKhVEZ/+";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7467E10EF00
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 13:05:33 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-c9b3f380006so217747a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 06:05:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785416733; cv=none;
 d=google.com; s=arc-20260327;
 b=UBcjf2W6Io1ogCUjON2jmcDxrKw2fPpGASzPC73eVTNsMOlKjcpKgVG4yPq2NZE+63
 drjfCOTASWQgs2InkXOkgbIV+D0t1s2MHPuQAz6Y5KQc7OpljyrtjMQIUxWw5n8V6tmJ
 peA37ecgMjOMic/FAcv5jzbHPt8tTopsjSbyojY1B3qAidf8QKRYNgTgpKT2y+SrYfOJ
 vG/Ltq5rIJyYRMl9qSpqXzZP9JFhmEx7L3LF5gx2qWUJVpbPC+hhGzd4V5fYGm03lsKb
 H682hdNHUggB4GiU7Tpqqi75e1gwbYw4uhxiaprNl24MStcrAS9sbfbWgCZizRMpbsBm
 YO5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2NqaKweXP4Tn+BsPuTc4YY37K0/50cKIiEErJiI1z7g=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=qswC7LTGtByyVru/426UE8hjGMuuUixGgLW4zGBmYHct3j8JvA51qumt86ivmFSLCD
 +3ld11FIgpq9DXcMDerfnzfaZyPCnuG3+UODjXc4Qg9Tfc+bAeeWFz8b7Cov0486FGwz
 603rXAz6p/kONYCHFH/ovvnwUoOEKPn4UQEUkBkL8zOLvRptHuDhxtTpLSHR45tjusRm
 KC51hNb/nZw4pPVr6mx+sEDoo8PHzm5uGq1MQf5tRrDpFcqT35zZwXe9WHj6sK/UOBNe
 4Ya78ZU3c7dalUATcb0g2mJ7AhkG5d175OuVM8lEtByp+IioUmNxo2Ij0+6QgOzhewc5
 rIWQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785416733; x=1786021533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2NqaKweXP4Tn+BsPuTc4YY37K0/50cKIiEErJiI1z7g=;
 b=WKhVEZ/+TYKi2fm8PGTHUsXQ3J3fAfWH4q+nHGk320gyP/7o29ojWCcxuUsIa00vAF
 KWm8FczPh+yeCRpcvvb8NSOV+xbsIMC8ig7qW4NrQgKuGIGsw4MW+DEkPniyvGQV38BT
 bBEWfJO0GxIUMwgmpsm2TUVOAKZO7Qw1LCClClYz4ToxnSEcu+ZoNijWSScZqP1vniGm
 jCMJjSiaqRDEFhKI4TzMMOUuCirgG+PibZSMgpz4oSc2kjr+elU2teD/rUJSdPP/I4em
 DFpxAF62im7JY8byuXTErv9PcEakh85kb75NYOD28VoGlv0PW58FpIgdj97vcr/F2kv6
 Q+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785416733; x=1786021533;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2NqaKweXP4Tn+BsPuTc4YY37K0/50cKIiEErJiI1z7g=;
 b=iy+Fxug2UwMmqE+Bq8qtHYNDJdL/3m7OH6NP5a+IGXcbqLe4gsAwhcV2mDa57h8fpU
 DUB0zxpisHl9hjrMJFd3TIGhC82MVszpGuko8Bq68b8y+GHj96d1r33tMzWUx76OKhom
 FKlvWQfZkFuzMyM9RmlYEjcaVO28btjgpfBqRjVatpNDLLjqbcALkPhQyNl8LGAMguGh
 avqZO1/ewvASSY/imAQvuK54nIZLf52XwRk/MKh0q04lG9DdbFHtLyB8jrcE9sbbUZPt
 Mjt9u+ywXLonC3o5h6IPzzA+fHd7JaF/Z88Y54CeQcL5uVhrbNDYBrXjskigmvo1ssHP
 Od9A==
X-Gm-Message-State: AOJu0YzxWLebxxQTOZbEr6N16bZiEGxc0mXQpfInltBFrU31ydERhowL
 8sD6PC6I3hEbSk3ApRsdc9Y7QetgtbkfA/H48GnWTGFcCe+OQzm/xhjYx8Xz5tgLwtyjTdR6Axy
 McMIPc53o+bqqzsQ3J6Vv9GSQf7370Ss=
X-Gm-Gg: AR+sD12DKJDSNGnDNr3F38Ums7ewUrKGwAgRZ/ptDKHYleXwjQvlWzd8Mw78PfNYk2w
 Edt+X1OlwgWhoE9canGYUqseU0iYJoIyK3E6XbGo7r4Zw2NvFF5TDEWLksnYDWD5xi7+z1PIKZI
 sRDN5o/0FUb1McKzU/CDwOru6vxjtVSzaQMmTa1gNEzmRBglKKaTShYsZwLLlGe+zmVf5zBU/Rj
 noKNOsF7+CKuV+s0vos4ANqr7o9kq1IVjr6FAWcgtFo2mYVmnozndPmU0AYh1PSQS+MCwSW5bGq
 fjfi+jvemuQ2TiRonBSbPHaYmDCyDI/0KV6hb78xpckFJ+jqw2NVzODVu2rp12Tx73wPyjVps/G
 rRpfozc1CHxHD4ZsRC0Xl4L/6Z7QyMgg=
X-Received: by 2002:a17:903:2f44:b0:2cb:2b50:d9da with SMTP id
 d9443c01a7336-2d03dcc7deamr6267525ad.3.1785416732805; Thu, 30 Jul 2026
 06:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260730025904.1993364-1-Jesse.Zhang@amd.com>
 <20260730025904.1993364-4-Jesse.Zhang@amd.com>
In-Reply-To: <20260730025904.1993364-4-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Jul 2026 09:05:21 -0400
X-Gm-Features: AUfX_mxrg_97PLHmCeFZk4ECz50bBRWuxcR1zTcMLcLTXeXvblIHUj2djTSlCEM
Message-ID: <CADnq5_PWra3C60rOsiR_itAOPLTKeSCwqUnGkQ76gfc6PsdbGw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amdgpu/userq: mark a queue unmapped after a
 per-queue reset
To: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Wed, Jul 29, 2026 at 11:18=E2=80=AFPM Jesse Zhang <Jesse.Zhang@amd.com> =
wrote:
>
> mes_userq_reset() unmaps the queue via the low-level mes_userq_unmap()
> (REMOVE_QUEUE) but does not update queue->state, so the queue still looks
> MAPPED. The destroy path then issues a second, redundant REMOVE_QUEUE for
> the already-removed queue; for gfx that unmap waits on an EOP that never
> arrives, times out (-110) and escalates to a full GPU reset.
>
> Mark the queue UNMAPPED on a successful reset-path unmap so destroy skips
> the redundant REMOVE_QUEUE.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 639e4a37f872..b5816f9a8ffd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -26,6 +26,7 @@
>  #include "amdgpu_gfx.h"
>  #include "mes_userqueue.h"
>  #include "amdgpu_userq_fence.h"
> +#include "amdgpu_trace.h"
>
>  #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>  #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
> @@ -205,7 +206,16 @@ int mes_userq_reset(struct amdgpu_usermode_queue *qu=
eue)
>         amdgpu_mes_unlock(&adev->mes);
>         if (r)
>                 return r;
> -       return mes_userq_unmap(queue);
> +
> +       /* mes_userq_unmap() does not update queue->state; mark it UNMAPP=
ED so the
> +        * destroy path does not issue a second REMOVE_QUEUE for the remo=
ved queue.
> +        */
> +       r =3D mes_userq_unmap(queue);
> +       if (!r) {
> +               trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STAT=
E_UNMAPPED);
> +               queue->state =3D AMDGPU_USERQ_STATE_UNMAPPED;
> +       }
> +       return r;
>  }
>
>  int mes_userq_reset_queue(struct amdgpu_device *adev,
> --
> 2.49.0
>
