Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E60606A327
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=shpXOPHF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0400210E0F6;
	Tue,  3 Nov 2026 14:44:17 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58C8310F61D
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:44:11 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-36a0eecf73fso722964eec.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Nov 2026 06:44:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717050; cv=none;
 d=google.com; s=arc-20260327;
 b=FSUG6XANahsufV0/qsxLD1Fb0+bp8qVgOgV/gbaIgMnagym8Qo1uPnpamRF9+Jifwd
 sYJz1cXn4+pvOAN747VEn424FshYrQ1JDiNBRYUdqm3NE+Yhj6Y3p1ZToDoZOsXQpQM3
 LtrR6NrcuSJJJ3U1a8Mzg37dWx8pgMpCUD801ac6XBHaPPjPAmEMA2buBi7mk8t1tnJ+
 rbSmGDBOitXmltaeiEXAp40V9voCZIhoxYOlG45Q7mpXzVZBXQOSbxTc7GOqJVLfrJEo
 ktTNOStSmu/lWs8ebyWcxbr41o7SThzVzJXYMWyP6DADIoFKYsMf/CnX8QwiSdeQJVC8
 4Q9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UsNAdNzoYrca+OV+CM5jwxNdwhRxDFVLuJ7VRuUaXMU=;
 fh=lVoJ4yXNmmR2wq4eBe2Kh0buLLpeGOL5D0XW55sOy8c=;
 b=l6SLtDgKVCxyFhPzcIUbdrvqFhmcOm1cYINl+iK2eDkLSL6ZstQJldUR7ncMWYyUNd
 /UvuNpJGdVbEK0P1wzxf6aH6OAl4TFacVR9iTQFQ99JCriteSKLAaE49U0wEnLCGQ3N+
 uw6WyugcaQ+ESZoN7y0bajcazq5ow0DhETO271NjBu86j7mS9ptfSqMUFxucvkMzqk17
 K7IesW4TF9OiTgWnSfheKC1Wes50DDm+V4SjNkj3EbkwblS8aoh+jCgaiZtQUxgOG4i3
 9tBqbleRTUvEyQjN+Z62AhphUvTlIDbPkIyARchneuE+rnPH86+Q/zbkdJ75ppHW8k9c
 2F7g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793717050; x=1794321850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UsNAdNzoYrca+OV+CM5jwxNdwhRxDFVLuJ7VRuUaXMU=;
 b=shpXOPHF7uOj7rXQVXdLzxR8IhwEOjrcd7dj0Ic77TBK41VfUU81aS1rHnvnikJDN8
 FObjKYnpGrWSe80jjJiwbHEvPmzTM5c9+yrHPvvP5T8xCXcraeX+FKJ1o4j8yzD2ao9t
 TqKNkEhiNcLrsieRbMlzgvtZH5wISnyo0QQYAtH25hzU9rPqu9wRaTZfgOrm50aXQtIO
 glefnMmcZgCGN8Kkt3osRIH9PlAnDyBkdxnVi1oWdqAJbgG6yf2LFZUlc441Yz4cbuXV
 WAsUYJjLV50E9h89B241M4NQWbei70G9uf68iUXfqUCt3rKbEoAbpb0F+z04n01Fb7Yz
 Z8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793717050; x=1794321850;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UsNAdNzoYrca+OV+CM5jwxNdwhRxDFVLuJ7VRuUaXMU=;
 b=APaKMOVphavRVN28XlHGx4UxMpZfzTio4jamPLDStd9C/VmpzU2p078R0jOpjZOfpJ
 CXLOoTfZO3JR2VUU56T0wz90RENNVz6pvfNb/EoFs3ghITQ+lYgBwwuILzQto0GNkbCO
 PjtIfJQJzykDpppRcAyuSOAubRQCsZ5qjO+CsoB0ZBl6looW/DquY8sdCO1BuFItIJGr
 cU3ZzDOzPRvprCMeKOyYnpzljkR5AyPPqvbISbqrC4EJ/rsBKmOVcYm3LGopuf+kX5Y2
 GcKeZPgtKqFB+p+EZrhqfli/wuYSlIPOR18gUDFLjKskjYG6T0fHjm/IUkLkVG9gWPFL
 NnPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz99h0bLUHlpnmgt3wHF0NK65ZLWldA2nD3itR9vWKVTu+s1uvTZIyNPvoWAitK53lsYzD6w/LG@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/8Mumr5hNPzFSFVBMPUDHyZ/mBXEVOlu1Kr89hdraBjfxNM8Zb
 +wzdoohC+v29OnebD6yAPTBiIiJ2pUj420IlfFZUhY6MjA+Byk7LdKO3RMQVkOgHGPjKWc058F0
 NXWG96hj6Lg091uiMc7jp0CbCA3hIZGY=
X-Gm-Gg: AYBFou36oP0si1cxWvQwOXAsVFnlkPdQivJZHIKqEb+jfc+aRruNatIhD4joITLAkh0
 cg/CP6gEOFxQp5MW6H8Np56XQXFyIh/0UnUGdZ7Iar3iiEUXKtWXqY6h8C6i0Wufk1fGDhcE8M9
 2rfIJL4HZNdezY1TlbYxgmvBUiB5NlAVow6APs9bcqr1Usw3YVw7FUVA3zwzqU3HuiWs7iCLgR9
 /++eqzO4t7DF3RhJZDbTxcduVSjXie80pDkx+zuruhvKtTJuWPAM5La8fUTSRm7cQNCJ9QiCXFv
 96ZoviPVSPA1/t0GXNzp0SuKc33SuZa6JACTwtHk+RVv4MHEVjZeveDk+J0dd/MU/ZCovAn2EXo
 OFtK4YBOh0C1iZsScgWQEwYhna43ppdnNay90bMDveNNot2Z/nX/VEUaT17r4RVbn3hwWVprMHp
 IAkAa/i6rBCXB6yTaK/xFtBh4kCsxD8Os3iw8RnQxK48xa
X-Received: by 2002:a05:701b:428f:10b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1ac4f91ef0emr33223893c88.0.1793717050355; Tue, 03 Nov 2026
 06:44:10 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103114053.73761-1-k.chen@smail.nju.edu.cn>
In-Reply-To: <20261103114053.73761-1-k.chen@smail.nju.edu.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Nov 2026 09:43:58 -0500
X-Gm-Features: AclHuK80YDWXw3RH4Lv7ORguPbCuG3Q8k5HJ1e5r-PWy-1oFZs2Ug-jOTbIa5-w
Message-ID: <CADnq5_Oax1FOEx=oGA07rWsWq9DspU6QNxnXv1yR0UAG2bA6jA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: reject invalid ATRM results
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 3, 2026 at 9:21=E2=80=AFAM Kang Chen <k.chen@smail.nju.edu.cn> =
wrote:
>
> radeon_atrm_call() trusts the buffer returned by the ATRM method: it
> copies obj->buffer.length bytes into the VBIOS image without checking
> the object type or that the length fits in the requested chunk.  A
> firmware-provided ATRM method returning a non-buffer object or a buffer
> larger than the requested 4 KiB chunk can write beyond the 256 KiB
> VBIOS allocation.
>
> Reject the response unless it is an ACPI buffer no larger than the
> requested chunk.  The only caller always requests ATRM_BIOS_PAGE-sized
> chunks inside the VBIOS allocation, so checking the returned length
> against len is sufficient.
>
> Fixes: c61e2775873f ("drm/radeon: split ATRM support out from the ATPX ha=
ndler (v3)")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>

Thanks, this was already fixed:
https://patchwork.freedesktop.org/patch/764437/?series=3D177235&rev=3D1

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_bios.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_bios.c b/drivers/gpu/drm/radeo=
n/radeon_bios.c
> index 1da6bf1c17ff..c23892470265 100644
> --- a/drivers/gpu/drm/radeon/radeon_bios.c
> +++ b/drivers/gpu/drm/radeon/radeon_bios.c
> @@ -183,7 +183,12 @@ static int radeon_atrm_call(acpi_handle atrm_handle,=
 uint8_t *bios,
>         }
>
>         obj =3D (union acpi_object *)buffer.pointer;
> -       memcpy(bios+offset, obj->buffer.pointer, obj->buffer.length);
> +       if (!obj || obj->type !=3D ACPI_TYPE_BUFFER || obj->buffer.length=
 > len) {
> +               kfree(buffer.pointer);
> +               return -ENODEV;
> +       }
> +
> +       memcpy(bios + offset, obj->buffer.pointer, obj->buffer.length);
>         len =3D obj->buffer.length;
>         kfree(buffer.pointer);
>         return len;
> --
> 2.34.1
>
