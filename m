Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB6606A31A
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Oct 2026 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qCixvp/k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32789112593;
	Thu, 29 Oct 2026 22:06:55 +0000 (UTC)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC382112590
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 22:06:48 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-35159e0092aso16923eec.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Oct 2026 15:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311608; cv=none;
 d=google.com; s=arc-20260327;
 b=P779BKXNmpz//mEkyCpCu2iDvAZxsHD7DpSqji0+cEjX14fLMPmQavXv1mk7NIXM9J
 qXMXZ+kvICfOjTfYizE/UgGCXBit1e+Sw2gtDLQKSAYSiyJBGAOzkNFiJbhbYDj5uJeU
 h8LCM2lSuplnxdGGkOIMi6aVqCXi/pTHWbxODn8FE9zK+3lA8q+FAGYz4bF9Ao/vUpQJ
 TIhfodD956o1aL8fMY2hzbn6u2EvZeWk/zrumdReI80jqVPxFH7AVOXU7SJurEbxW8bi
 8mJ4djBXLA1vGB0ja8MbLgE/XgWZDQ5Yf3ho5ZjXH1mdHegd8j52KCxa5GsFOGVVvkeU
 Kdmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ky9rMIBrdD0V66ZDHy8SD9XNeoKlHoZZUxWgxExAHbA=;
 fh=qQPJ2C1cUZTI88KvdTTxpDqLRX3dsSacqfr/T5CS4Tg=;
 b=pS5G/4gUJW4/VnImmswXtgB9OnxQ6a4w7FoVajVOSrefgGRQwtF4TArQLESQVdDkJx
 qlyeomb8YO1hKOO7NP+V2j67hWnvmXX99wkMuDj5bXPjmE4FwfIq8e/zmOwp0TzKQdBx
 D7u5Ay1XEXKVxNSIwMs9/9IcLxLy/F1XWaD4cFh5zeHrybwETWhQRUeavFiOq7nb3ZWN
 8DoV6RTFLIF0RUHK9eHFF3GlAjx1oHRB4eg/RZkyZgYtWrW7ungZ8uRuRiHgDD+r2rZj
 0fPbbSL3b57MX6/p4vkzJIdE6XY0qae+0GqEbKnIsC9jCe9AArpq+ogJ9wquWUBtcVXb
 YQSA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793311608; x=1793916408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ky9rMIBrdD0V66ZDHy8SD9XNeoKlHoZZUxWgxExAHbA=;
 b=qCixvp/kpNC8mU4ib5sSmcORErhU5YE5FEALwjoV6aH3dFAX0noqaqiNh8/jzlWOow
 MJ9yZfWDQXmVx1q7gbA239Hx2b3zxJpuEffil0X+meKaYlOsWjS3KaX18TNxrsC4lFF1
 mnUm89FnQZa3hEFiaLMdWkG39o+32FgqTiI3l6U6672JKVxCfL4xr08BEjffo/8vKd1q
 7lY7AR3khZCgJs5Y10znUWThIkS3j0Nd8gtQ60ctU9Vd11h7Q8y59G1mWEjL2qM/GgnV
 KtcYzAv3wIxAD5Lb8umQ5tUEc3srv3lZ/ixwcKl7dkjDu4nh0100hWJC+shB51C2xCKW
 5DyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793311608; x=1793916408;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ky9rMIBrdD0V66ZDHy8SD9XNeoKlHoZZUxWgxExAHbA=;
 b=0OsjTjkguAAnmQMcrIAjkMoY2p9AhODULD/ciDpf7BO55z9QJxLmI9KGXkmGC2SToH
 omKUKw6GNwo5XF29ap1Y8TLv6KCuAsSCO4uqePC6qO5sl6MBvZGqexYzDWd6cqqAnZ6F
 caf6qLUvuAgIl/+qglZ77AwzE+FIOVcMK3Ckt2hO3f+tV6wVQ8dJAkiOnI6lxI3OnQ+o
 bjiDmzZufyAp2EWiqtblCHTI9t27bfvmQpp7gHX6E5vSGyEzmRmJcLa9a6NCvDWO/aSD
 ALcnVRYxM8SHVSGw5xX2NGlmNUaTjvZkCWChiT+Nt9+BrPGmkdYi4UYFF6QErI/vmVUj
 E/Zw==
X-Gm-Message-State: AFq9FYIHP5bvNOghAgi1ETfTDcRVLCwXzL3ogIcAFuInPoZ7geRg7rHZ
 SCmisc19INwOe6hKxs/vL5lVdZCoKhkYdutvKg3ociRnJH1fQGRCcP2HNA/NMPb8xgiT9XOlY16
 DhAKgykW0eq0QluWMW+0DekIsz0ZQ9qM=
X-Gm-Gg: AYBFou113FCkjJCl/rMHua9qWvvk6ZczgkZuHcmv/onKKKmnTKka1JCFbStPsS9eSvx
 lZPk2lpsmHub8CXTZNZ/JVnhe4/KV08jBK3jEpQQHw4HJIwg8LaovuKPW4K8T4h9L7HWZgbgaio
 1WjxQWgfHFSVU+hvpgLchD4vGVqDoWtR4UPuf3y2mYfMn2WU8cw+ShGx9Io486SqOKrqoaPOtnV
 WJG58utti9RWTRtbZ9Uqq17GLhSr5odY+kGkW2Q5yZm3b1XIa0UMe3WBqapQBC7OaEEWFiT/+Cc
 ERc7yOARb5j+DCfZv2xc4A8qw4AX3IUw364ouGhRjQwzoarMZEla8EjuoUT26gaUX/j+CBXMC7f
 7AeSAgfPOvy/ml9w/NiKJUpk7acIQ7eXWl6f+yBzksjpEvm+0gEEguHd/tp3j21OXL630+Rg7pX
 O3j4ob7+h6hT5EXflWpdiYiBE=
X-Received: by 2002:a05:7022:c46:b0:1a1:9106:cfff with SMTP id
 a92af1059eb24-1ac5c45fd28mr684966c88.2.1793311607851; Thu, 29 Oct 2026
 15:06:47 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261024194334.305636-1-erhan.bilgili@gmail.com>
 <20261026195013.451031-1-erhan.bilgili@gmail.com>
In-Reply-To: <20261026195013.451031-1-erhan.bilgili@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Oct 2026 18:06:36 -0400
X-Gm-Features: AclHuK_7iWNrWVssEdVQx5ejSil2kexDbRtmL9hS5F6FThW7gIawM42WbWukiS8
Message-ID: <CADnq5_M1PSNk4ud0GTEiC8q=4azUG50=r4qE_Oc0d-19pt_xkg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Report MES ring wait timeouts.
To: Erhan Bilgili <erhan.bilgili@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 christian.koenig@amd.com, Jack.Xiao@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 5:51=E2=80=AFAM Erhan Bilgili <erhan.bilgili@gmail.=
com> wrote:
>
> Return -ETIMEDOUT when the fence wait before submission expires instead
> of reporting success without submitting the packet.
>
> Fixes: 34e087e8920e ("drm/amdgpu/mes: fix mes ring buffer overflow")
> Signed-off-by: Erhan Bilgili <erhan.bilgili@gmail.com>

Reviewed and applied.

Thanks!

> ---
> v2: Dropped the redundant check of the wait return value.
>
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c | 4 +++-
>  drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index b2e4da70d208..8ca487829aaa 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -218,8 +218,10 @@ static int mes_v11_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         r =3D amdgpu_fence_wait_polling(ring,
>                                       seq - ring->fence_drv.num_fences_ma=
sk,
>                                       timeout);
> -       if (r < 1)
> +       if (r < 1) {
> +               r =3D -ETIMEDOUT;
>                 goto error_undo;
> +       }
>
>         api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status=
_off);
>         api_status->api_completion_fence_addr =3D status_gpu_addr;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_0.c
> index ce577f49b630..a25e6f6d5a71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
> @@ -195,8 +195,10 @@ static int mes_v12_0_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>         r =3D amdgpu_fence_wait_polling(ring,
>                                       seq - ring->fence_drv.num_fences_ma=
sk,
>                                       timeout);
> -       if (r < 1)
> +       if (r < 1) {
> +               r =3D -ETIMEDOUT;
>                 goto error_undo;
> +       }
>
>         api_status =3D (struct MES_API_STATUS *)((char *)pkt + api_status=
_off);
>         api_status->api_completion_fence_addr =3D status_gpu_addr;
> --
> 2.56.0
>
