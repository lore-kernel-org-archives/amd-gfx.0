Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4EDC55182
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Aug 2026 13:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 028CF10E612;
	Mon,  3 Aug 2026 13:54:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xqf9TKpJ";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB58F10E612
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Aug 2026 13:54:22 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so395908a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Aug 2026 06:54:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785765262; cv=none;
 d=google.com; s=arc-20260327;
 b=U9UFebHKafWzYgFTVGYPTB41GMBLfhopnR6cx58xq+Px3DPtw2yFyqoNSf5/y1g1Ah
 c8qtXaWHXuzDIZBDamdV1IK+2g/CVoWIJoVEwi59mGAmLlxc6l4JbB6EHM0M2Q8vkn68
 EQJ1tL+rAaGgjJCVOY4gzP3m+0Xlr8cyYCluIALUQzXHot86njp9eOfc27Gvz7KqxmbU
 Nfi4DqhEE+fUeaikTa+ZLCNwgKM1lXVGbbKogo6uyEakhe0skL3vMtPQqzgxvQL0dXn9
 eHtYSnitjRj/jMshEQ37ISpNOx/58qNqDBYep8Q9IorqZcqMBintjUj4wQvYUtU4t4ms
 yCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RjWtjo4FzcGiZk9WmTf1d/Db97RraI/QHAJR0dBahCs=;
 fh=pVXkSRI4iWxMX2nwzh6GHNF3uSMfA8RBUzqfkxIWt8U=;
 b=ZL03oWu+/wYYZbV1gAvUVqV5vi5Ci0utEhn+W+OKTA1pj917xduqnPuKt2McwcPWDi
 J2Ji4ZX54qodyXi4emeS7GGZkEmn4uqb9sUY/FPr5aGpgNSkRGrLEGUrn3QUB4RQ73Fq
 3FGbgyINqtn9M4yYHtH8y3+H6EAsOXfbtCWnaIQPHXW1PHPhj8SLZvBVy11PrmSE0dcG
 wJJKyCNOyjVgenQcD+yUceoCIDd/ozhBpNEaOEKMT4mZqxxREByaXel/KDwNHW3VTyOo
 s1Wey5KbDkumfSlz0dDm5W3/vnI2k3U64ukGvmOqTMfWa39GHwJ+hviZzhdZJB+H5rm8
 EWeQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785765262; x=1786370062; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RjWtjo4FzcGiZk9WmTf1d/Db97RraI/QHAJR0dBahCs=;
 b=Xqf9TKpJKt8igkOg7D9YeCsbQP19ZzizU+L0CzcmfZWa5IfrEDJ+Ft7FaGjvlowc8H
 qqpEy1hl/S3LlYf9zShG9bGwihQSunJtXKNIA9r+GjPcJaICmjc8vy6NWwBr0hw51c/J
 j6bbuBdz3hvMktOT/ZCC4u07xe7OZJo+E4Jm9BCQrYsMILhhc0ziIuTVX8UEdIq3I9LZ
 BubO9obileYlpCD81syf9MTv5PaV+ismHu+etI0UP4IAIzLtdtldabhm96Z1O7pd0PP8
 kr77t+aCqlAx63bmtnq2rCXJ8l/tpnt2ekmcZdKwjEJIh8TAI/E3GI551kVFUzxtoAMG
 FGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785765262; x=1786370062;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RjWtjo4FzcGiZk9WmTf1d/Db97RraI/QHAJR0dBahCs=;
 b=J+dAD1XW8tQLoJfd6fLxz/MYhovzY5xMCMf61X+UDYNXaQaCvV4htMR4gMOVq6l/DF
 r/PwziWPtrJRly4a+a8W9Rch1v0c+RTpN30fZpbeLtlMHz0sk0hZHpH/f+VRKyI76Jvl
 yy4eodQ4TJIYjhxUnaeAHlZLW/YPyU90tBwcRdy0dOuRCW6dYVeqcIPIFtWqt/NX6EKN
 +x1bPOj4JCs0COj9x7tqGdS1G4B6yrBDoVp2HLhftEb/1YNM9FLgU1yLeijaXRGUlrbl
 pFq3GE7l27y1osGZkPYIb8lFANn0b/LlOa2xnnFTfXayE36Ggeomvq+Da6RINrh8bfn/
 MoBQ==
X-Gm-Message-State: AOJu0Yyk6+Nj2kM4WRCkeS7m5obzckCYgNbBVmxc1o1c6YI7vmVVF3Ia
 8wkxF0UQX5Efra/xsk0fuX51Rhhskj2KoysK0clfGdohEgRFC78QT+aN1AuRXCp/8c9zxXqjqVg
 gGnQGYLA2FBmhc/jC0+ak2+PEo1m26eA=
X-Gm-Gg: AR+sD11KiIWkeyfl7QViYyYxqjO7LBlINphU2Du8ksm4ydwEG9i1XM9EoNatJzwH3XQ
 Ezl+wKAtAMHgzS8gUcIOLTu/TQvpM/XI+XaIGpEcvor6QfL4wcsMEf9X9HJCkV4VdXYKJaSB2dv
 PHo+zf39+ld0zAFjG7bNCnzhGsuH2AlNy8HP8NT1C5yQ2gQPZwjVBMwFNl+vxazXta1X8wQcp3a
 3obL1fMT2rZKK8BpJEcptoFzq4lx+hmz117kpA8UykfWbSTudoV3/hKiEdTSjSTHQDQ4iBBcRK1
 aHRGz/q46IRN7buErZrmWh1eqd47O0yf/YfMlKaMEskfqz0cbNBtKvBx2Voz06D01NBeSavJXs5
 7Bxdh8NDci9iMm7IyknOqE9/R/fJ3Dj4=
X-Received: by 2002:a17:90b:3a10:b0:38e:91a8:fb85 with SMTP id
 98e67ed59e1d1-38fbc507730mr12644750a91.3.1785765262211; Mon, 03 Aug 2026
 06:54:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260803093713.1904533-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Aug 2026 09:54:10 -0400
X-Gm-Features: AUfX_mxLePy1mAvvNkmjif8nwc42CQZf_uXN3-pXHRFFd0L8VZAfsJp9CFvSTuw
Message-ID: <CADnq5_NWpg7p=bA8GC1P011FFt6y2Y27i38ZVnyacwMxfNaUzg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: serialize queue map against GPU reset
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

On Mon, Aug 3, 2026 at 6:13=E2=80=AFAM Jesse Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> Creating a user queue can race with a GPU reset. While recovery holds
> reset_domain->sem for write, MES is unresponsive, so the ADD_QUEUE from
> amdgpu_userq_map_helper() times out (-110) and an otherwise valid queue
> create fails:
>
>   amdgpu: MES(0) failed to respond to msg=3DADD_QUEUE
>   [drm:mes_userq_map [amdgpu]] *ERROR* Failed to map queue in HW, err (-1=
10)
>   amdgpu: [drm] *ERROR* ... Failed to map Queue
>   amdgpu: [drm] *ERROR* ... Failed to create usermode queue
>
> Take reset_domain->sem for read around the map so it runs only once MES
> is back up. This mirrors amdgpu_userq_cleanup() and honors the
> userq_mutex -> reset_domain->sem order; the reset path never takes
> userq_mutex, so there is no deadlock.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 652599f08990..770635ab5298 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -745,7 +745,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm=
_amdgpu_userq *args)
>         if (!adev->userq_halt_for_enforce_isolation ||
>             ((queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
>              (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE))) {
> +               /* Serialize the map against an in-progress GPU reset (ME=
S is
> +                * unresponsive during recovery), matching amdgpu_userq_c=
leanup().
> +                */
> +               down_read(&adev->reset_domain->sem);
>                 r =3D amdgpu_userq_map_helper(queue);
> +               up_read(&adev->reset_domain->sem);
>                 if (r) {
>                         drm_file_err(uq_mgr->file, "Failed to map Queue\n=
");
>                         trace_amdgpu_userq_create_end(queue, r);
> --
> 2.49.0
>
