Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A7FD66BB3
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 05:17:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE0E810E4C9;
	Thu, 18 Dec 2025 05:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="muPJRmLy";
	dkim-atps=neutral
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D00C10E4C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 05:17:05 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-7c7613db390so115801a34.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 21:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766035024; x=1766639824; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VDFORpGl89wmXWP4oxqkoOJ9uaZN8eWqHSP7qm+bKjQ=;
 b=muPJRmLy8blCLKrVGQMvI3I2SVytlJ17TZ79En0p6XcFVSvlPyGcSPLKSxZqHgQ4nc
 PwqBR/ZXkyoQnQBcE8bVgR6R6egE4eFZPF1opKC2n5n6VFzkmHDCFPUqpqL6E7oueksB
 isC2VW1VzOKsrif1J/HsYkON8iz5PfpoqQrmvULzg2tY2yQ09A0hbecxtOuSh9MrHXKW
 a8f3E0bW3o/b5+eIXeYP9S5b7eHDQ9uAIj9CJyGyCNZEOJtYPvXwL5yH52k87tPUDx4T
 T81FYPybrutXdL0ZfiM7MqnHtUga1i07O6BMcSmAjGF7WbyqEzaDOPxCr+Shg7SiMdXQ
 vupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766035024; x=1766639824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VDFORpGl89wmXWP4oxqkoOJ9uaZN8eWqHSP7qm+bKjQ=;
 b=K3bt3LJ3fBN5es4JXYC/8JSGe7Y7fB2qPnztPfLoPXuy8tV4U68mcG8tiWq8fQwSnY
 lpTJkj2OL0c9BKEAJbKBzeYBaFHnxhwcIyI9FzMbUIONPtse/Ux7iNsCj3G4ai20kV3S
 5HLxqdwLtvMShlerMZayv1kzhPDTq5HeUG9vKBPxdX4T/tfVyLYslVw/4BCjoDZ1mWGW
 4hI5XjecHqzG8RtpKUtp/+SjxJH/MgKjKt4404YY0gLEzjBns98QKkZNNOuGIEiaMP1s
 fJxnsXcSozgbYrT/UDoBFzQJexNwTP2U0HF1hYWTpO5gbWIi4xc/5rpG+psjDGLyxoER
 7Cwg==
X-Gm-Message-State: AOJu0YxGpRzFIX8xs90FtxILx/B7WlimtoIyFj81jNlO3594rWEngTcV
 klnDJj4JzMWiNMNMKOBWSWoHRZzlMW4szCFN2elNtVDWoenpRb0Gv9YkNH+1SAPt7E4=
X-Gm-Gg: AY/fxX4MMOFzTd0USjYBJi5JRqeIPzUWt9yTkMjPihXgzva0IFUOGQY4LGpfalfPg3+
 YY8QULZWYmi2WQZt5t8qL6Pn7CzxmAobSs7FPfgaJq0wPIm31FKY6tX9w1J3g8rI2DpeLm5ENjk
 4eJOyAs33pbquLKzGSEpvUAI+kbkdGheZ5O73dfE38IBiNdEV9ypfBbidNuu5w5VlylkSWDXg7p
 qepiqtBnUIrO5X3SIC6HqdtjFf6PONWH06SEK/lKXmD1cze1/AYiEOCcdFqvS9CWWCIZcfMzEO9
 y4P9rJGJYkjdXkxvjyWeMdRPzBySW+/Of9eoe7gXfT4KfZ8krKUm3BqE5E1RITzvWp4xpeab0Zs
 sSHJKovM6nj5Scsg4cZxUSSY0vDP86lxICGZbhxxDWSA0yDJDqQlRRdA8JOqHbqdgZ+YGY2nTnU
 3zGpdeojY2xmu94YO/DrjCjTg6hYE=
X-Google-Smtp-Source: AGHT+IE9Y6z75XLEUNZCPxLCwlWo/NwuIvcInVn3opJRvgsQIIJ5SBRJRH8bPSWdtWZX+LQetCBM9A==
X-Received: by 2002:a05:6830:6d95:b0:7c7:5dd3:ee7e with SMTP id
 46e09a7af769-7cae839e804mr10078705a34.32.1766035024328; 
 Wed, 17 Dec 2025 21:17:04 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc59b78e5dsm938969a34.19.2025.12.17.21.17.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 21:17:03 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 2/6] drm/amdgpu: always backup and reemit fences
Date: Wed, 17 Dec 2025 23:17:03 -0600
Message-ID: <20303714.fSG56mABFh@timur-max>
In-Reply-To: <20251215160711.11832-2-alexander.deucher@amd.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <20251215160711.11832-2-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 15., h=C3=A9tf=C5=91 10:07:07 k=C3=B6z=C3=A9ps=C5=91 =C3=
=A1llamokbeli z=C3=B3naid=C5=91 Alex Deucher=20
wrote:
> If when we backup the ring contents for reemit before a
> ring reset, we skip jobs associated with the bad
> context, however, we need to make sure the fences
> are reemited as unprocessed submissions may depend on
> them.
>=20
> v2: clean up fence handling, make helpers static

Nice work!
We definitely need this when amdgpu_sched_hw_submission>2.

This patch is:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 24 ++++++++++++++++++-----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  5 ++++-
>  2 files changed, 23 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c index
> 334ddd6e48c06..3a23cce5f769a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -89,6 +89,16 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>  	return seq;
>  }
>=20
> +static void amdgpu_fence_save_fence_wptr_start(struct amdgpu_fence *af)
> +{
> +	af->fence_wptr_start =3D af->ring->wptr;
> +}
> +
> +static void amdgpu_fence_save_fence_wptr_end(struct amdgpu_fence *af)
> +{
> +	af->fence_wptr_end =3D af->ring->wptr;
> +}
> +
>  /**
>   * amdgpu_fence_emit - emit a fence on the requested ring
>   *
> @@ -116,8 +126,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, stru=
ct
> amdgpu_fence *af, &ring->fence_drv.lock,
>  		       adev->fence_context + ring->idx, seq);
>=20
> +	amdgpu_fence_save_fence_wptr_start(af);
>  	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>  			       seq, flags | AMDGPU_FENCE_FLAG_INT);
> +	amdgpu_fence_save_fence_wptr_end(af);
>  	amdgpu_fence_save_wptr(af);
>  	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
>  	ptr =3D &ring->fence_drv.fences[seq & ring-
>fence_drv.num_fences_mask];
> @@ -743,10 +755,6 @@ void amdgpu_fence_driver_guilty_force_completion(str=
uct
> amdgpu_fence *af) /* if we've already reemitted once then just cancel
> everything */ amdgpu_fence_driver_force_completion(af->ring);
>  		af->ring->ring_backup_entries_to_copy =3D 0;
> -	} else {
> -		/* signal the guilty fence */
> -		amdgpu_fence_write(ring, (u32)af->base.seqno);
> -		amdgpu_fence_process(ring);
>  	}
>  }
>=20
> @@ -796,9 +804,15 @@ void amdgpu_ring_backup_unprocessed_commands(struct
> amdgpu_ring *ring, * just save the content from other contexts.
>  			 */
>  			if (!fence->reemitted &&
> -			    (!guilty_fence || (fence->context !=3D=20
guilty_fence->context)))
> +			    (!guilty_fence || (fence->context !=3D=20
guilty_fence->context))) {
>  			=09
amdgpu_ring_backup_unprocessed_command(ring, wptr,
>  							=09
       fence->wptr);
> +			} else if (!fence->reemitted) {
> +				/* always save the fence */
> +			=09
amdgpu_ring_backup_unprocessed_command(ring,
> +							=09
       fence->fence_wptr_start,
> +							=09
       fence->fence_wptr_end);
> +			}
>  			wptr =3D fence->wptr;
>  			fence->reemitted++;
>  		}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h index
> d881829528976..87c9df6c2ecfe 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -146,12 +146,15 @@ struct amdgpu_fence {
>  	struct amdgpu_ring		*ring;
>  	ktime_t				start_timestamp;
>=20
> -	/* wptr for the fence for resets */
> +	/* wptr for the total submission for resets */
>  	u64				wptr;
>  	/* fence context for resets */
>  	u64				context;
>  	/* has this fence been reemitted */
>  	unsigned int			reemitted;
> +	/* wptr for the fence for the submission */
> +	u64				fence_wptr_start;
> +	u64				fence_wptr_end;
>  };
>=20
>  extern const struct drm_sched_backend_ops amdgpu_sched_ops;




