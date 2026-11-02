Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3686082C43
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iXKNynng
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B2C10E64C;
	Mon,  2 Nov 2026 16:15:05 +0000 (UTC)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F13A10E64C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:14:59 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1430eec0070so108794c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 08:14:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636098; cv=none;
 d=google.com; s=arc-20260327;
 b=jUFesCiG0e8tL9j/1DYN2zFHfUZmuaDGteVxt+JMdc/6Qdx0NSwSUjSEeFXn7C1y7s
 PMnrTDEbXlHwgG/kKgrfxz0jLDJHOn/j5MxlYzRrZINZ4vJYs4GalRNBSmdi6/iift65
 6ouZpVzNUyTurfM6An7WqDaoNUR6vJwp4C/3cHQSFBAEfFAaiUTWKK4BHn2fIxua1vrq
 aCbazs1EDDbaPHpF7La2iS4ouHpMjPpUg1MgIUgacJCdALoKkL6FQ39W3HLWhw3/egnw
 R6wRb/010+t7yQZW2/rDtnpmvFKaZkuiy1uDCyhKV+OAVfhyMGJauMY/LEkQnG9y/zoL
 zrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
 fh=hG3Zvt08lqltFJYX/rLqYuoVxqwCnHuO4xQ+OddtU8M=;
 b=Ez+WhKkVLDQ7LDN4rEDMaDPJfee0vy/TmzjMG4Kk8OB/Z+qVk/jZd+/EgPJuu5fXdT
 wWPZJnbdRH5wP8AubvHBR+c8Ps3wms8vN+CW+nHKYkdoZh+V54mJixB92pcfwyJMb+T0
 w7ULnFo0h0u3XrOGLvIiPJ13e0T48UEfmdSMOv3Sku/huDtS3vx59NrU1MQUhru6S3ck
 hhZPY8fVY9yjuJlOSeadQ76rU+GE3odGtmSc8F/AqobxHQtX+nwAgHDyi0fZSlQDNwUE
 SMRQWC7Ckid8OnGKcuF1BbO1zY+P62HYK2GB0rvA/SI+gBqPLkvIsxaSCoRaEuaSoRrn
 UeCw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793636098; x=1794240898; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
 b=iXKNynngMEoLXGmkfhN0dbual5BtAbCUUBPeA4KyReLDl9yhiR9Z3tIbun77Xv9xp0
 bJV5ALdnQh4njfDCAN/voGnPqID91UfJCR9gyqlMI31mioqRSHkYG82kQX4H91AykScT
 7AM4srUAPyNzgg8CNjv4Z+m7CIpubMC5xhHsB6WnPBZc/eGcVe1Rh7Kr9+qimipzraKv
 ReJtcMuiZ+N94nLX1tZh69AeJEosLmd0wIkMIvh3wQZkxSdNUbGM1lOnC+n8PADY75Ox
 pjgWM343wX42WnIIqI5E2G6JsPLStXCSnr2Ec9yYNFWOewWrjXZUedTX0ZqQkAV/aR1N
 gzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636098; x=1794240898;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RpuEFdOA57qiMSteSsYhsgM5FdR44dmDyqhBvmhwCMU=;
 b=Za0KK0uqrJ3Q+pP4YsFpFsMH2n9sKAub0M6I0ImUIM6WVEnXRs6+p+ONuIb1G7Sq0A
 VTRmRmkkl81amsLlm0M/QW7tKp9geGu7bpvDT5drO0lzfMqUoCRnidYh11k/6eXuNB2a
 0IMM0OUcHkhn3PITPiMOOrv50QGRimKf3bXW2UJRC+74GB15cUFUDSSBtmqLpy9IT/xP
 qs+bDyrV1bSbPStymOiinUqydEYsxQevoyMnLKINln9mTCDUiALzXGlwYwBNoTjtOGNU
 yrlTNTc2aeEVrzjd59zgewIypMFsw47atqFhrfkRODju00WTL0MF//ENHClEBqDZR/Zd
 YsHg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT5dtjnS0hFQXTYaMx6PogQIzpC0btmqEBxwLYckgmA8UwKdd2Fei3hEFHJhlrAxqqPChXtW6a@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIDnlt8Jf/m//4tJW80/hD6O842UuuHdAs8Wv6eEq3TKws/mTyC
 2aW+GMJx8jbdQG7pYiFhSWWWxjmS3nRm3BoY39eCiYm3PXsG6FAlhghiy0faHelL+EVDBxUO+Oi
 GglqhoiokSqGsq8Ri4swlFSZ8SE56Hec=
X-Gm-Gg: AYBFou34XwFhjYDpDfYdFvbZSY3zJNfn1MphCzNYNIfKLAip0Lk+5mWR+BXYNtFjUvE
 bLDptmej2CuExti1ZF9qMhRecfmwuHFTE18RqBzyJNb894aFdOmyqbzgsXz9ozgNo/QTd58FC6y
 AMTD1CCf774PIhgN0OmRKLdKSCzz9JwyR6+Wcf8CvyDSqSPOUUbGtALBEiWiyVdI3eHAGtmH3XR
 PQddnGkX0ktgyMRhP3N0T3K31ICSh8xHtMNfZE1R+nrweMqkden8hs8C3g5K8yWUJNQRf4ICDPX
 Pq1m+leQK6ihbU1sqWMmmHZgAj9IWcUJZnGqD6KKaJkiXKj4QswBppASAt+6Im/PT+4mlZPMs+E
 wtX4km61IL/5bnT2J6Jd8AJIkmE/vROooBlwWt5hfluW/VNOOlYB8WCtMr0DLQgEoJY3hs+hVuU
 kbt64Oaaj0P9xMQaIZ4pUzyzyLerLCPlzeolXiIZ0ZoBi2
X-Received: by 2002:a05:7022:b053:20b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1ac500d67e6mr26290103c88.0.1793636098164; Mon, 02 Nov 2026
 08:14:58 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029170831.915318-1-tristmd@gmail.com>
In-Reply-To: <20261029170831.915318-1-tristmd@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Nov 2026 11:14:46 -0500
X-Gm-Features: AclHuK_JcRVN6W2vlVWf4f1-FWgd_LnG4QSNqF29fy2tI4WLRUhM7uUGnOkvvqI
Message-ID: <CADnq5_P9fh0dDU7-vBiBPEY8iNJ2eVZS1kojvObngsYQzb459Q@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: validate ATRM return buffer type and length
To: Tristan Madani <tristmd@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

On Fri, Oct 30, 2026 at 5:13=E2=80=AFAM Tristan Madani <tristmd@gmail.com> =
wrote:
>
> From: Tristan Madani <tristan@talencesecurity.com>
>
> radeon_atrm_call() copies the ACPI ATRM method return data without
> checking that the returned object is actually a buffer or that its
> length fits within the caller-provided size.  If the ATRM method
> returns a non-buffer object type or an oversized buffer, the memcpy
> writes past the destination bounds.
>
> Add a NULL pointer check and ACPI_TYPE_BUFFER type validation before
> accessing the buffer fields, and clamp the copy length to the
> requested size.  This matches the validation already present in the
> amdgpu counterpart amdgpu_atrm_call().
>
> Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX ha=
ndler (v3)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/gpu/drm/radeon/radeon_bios.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeo=
n/radeon_bios.c
> index 1da6bf1c17ff3..579ba1c1f23a4 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -183,8 +183,13 @@ static int radeon_atrm_call(acpi_handle atrm_handle,=
 uint8_t *bios,
>         }
>
>         obj =3D (union acpi_object *)buffer.pointer;
> -       memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
> -       len =3D obj->buffer.length;
> +       if (!obj || obj->type !=3D ACPI_TYPE_BUFFER) {
> +               kfree(buffer.pointer);
> +               return -EINVAL;
> +       }
> +
> +       len =3D min_t(size_t, obj->buffer.length, len);
> +       memcpy(bios + offset, obj->buffer.pointer, len);
>         kfree(buffer.pointer);
>         return len;
>  }
> --
> 2.47.3
>
