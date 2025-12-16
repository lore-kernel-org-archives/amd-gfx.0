Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB141D609D1
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 16:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F30810E030;
	Tue, 16 Dec 2025 16:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ilR3fUas";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E4710E030
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 16:32:56 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7f6bc8a4787so275972b3a.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 08:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765902775; x=1766507575; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEEzdpc1TzdntPB8mMkBX3YK+kbp8iThLSkKx0l5mbI=;
 b=ilR3fUasIMT0JAiZNHRT7P/aU82IAs3ebItb6WKSKoXgfGrnzCkrbjyDQLrAvkD3h6
 A1T07AYGYvGBmyCjxyhCHtIUy+OSKesdR8dvEKxgsfU0Re4WxDzHRyZR9IN2Kq6eQbQj
 PURpgYP118wBNzaHoMmCAMVNKyle/NSOJ58Np2lEqr6/DlbWRtT/ui/3rWxLbOv2UA4S
 fNlyfwa+fRmK8lZvif9FP5uH68ZNqZRM3ewkyXy+VtfLY9S7rf1KXHRUCyX4OVZp9Xl3
 y7vs1juy9EFEODabDj9ll+0Z7hHLgxfxkfPu8mI+Pi801IPmgI9VSC8DdyWnvwG+SIhm
 3m6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765902775; x=1766507575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BEEzdpc1TzdntPB8mMkBX3YK+kbp8iThLSkKx0l5mbI=;
 b=hJxo0v4raiW7wIcdrcNLcrMEF10NhDUgKQ30mhtj+3fV67Pp4/fdOGPfP8SwH2EDWj
 bVDEAzQmx42jqwQmL4ae9rQFkRcBGj2SnkSJO9BHYzQ8ItxA6rbomZVAkFms2s12+mqA
 aqHbx+ntDxQHz8fuoMi0QkaJzgrirzPV0Omz12wV4zXvLHvNdqCr+rZrko1D5Nb7JvTB
 Vbxm4bD3TDZpCl7YEMJ1s5+CdfoZ7YhWkzWLz4Rm3OuBvvp2uOTH6ywsyhK07uqXSF1z
 ykar8DQpXnBlpn4JZymHo89jqbQIlmZYL0+mCIJPMQmKhcpZF+mMdgliWRc1q0e/zF2x
 FlLg==
X-Gm-Message-State: AOJu0YwWiLRIWO1BuSMzyQEuMd4YoudFMUlpYSrut7JB9Xjthhc846XB
 +Ka5grBJVx8jmY3qnmWja1qswxP/oOC2FWXQQHzZ8Go1nEgPT4QmaT+nnfPf3wZmBfDCQJlLSkc
 aT7j2Cr0TfTekvufL0F35naFGxwY2gFM=
X-Gm-Gg: AY/fxX5jLyHYykGdkPjkFx5IozjXogklyS34WsATpgR7NOqpvTmAjGVWYofRJOb9Wqo
 MM3GmR2QVp4ekueKMX/McAIvKDtZLWAhvObPJnBC8NimVcwiZa7hD6lX7fZJUaghcgpgB8zzvII
 HxCSFYyk0ZvwpB4OLjHvU6xeJJaT7DwakizUadMRsPdtAuEouPjBmFIKughMeBxbA0RAFdK0uEr
 MfIRFxPBMr6JdrdASNTCD8QBpTtGNc4Xxyq2CQz0OXOBm3tqVZuIVGW63kK6Creeh+TTEZ3
X-Google-Smtp-Source: AGHT+IEwSZRe6ZgA00q3v52PWZUmupvtYmmNTK95Id8wpGtBY7VQRT/7NsVD7GqhgwuKYp+c27K7tN8zVw2Rp85Jh98=
X-Received: by 2002:a05:7022:e1e:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-11f34c1c62dmr6901196c88.5.1765902775465; Tue, 16 Dec 2025
 08:32:55 -0800 (PST)
MIME-Version: 1.0
References: <20251203130436.745633-1-lijo.lazar@amd.com>
 <20251203130436.745633-2-lijo.lazar@amd.com>
In-Reply-To: <20251203130436.745633-2-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 16 Dec 2025 11:32:44 -0500
X-Gm-Features: AQt7F2qXLs3Mdqn6GA0rGUi2M-WxUw47kG2bXuIhCQM0lYvXw5gd1bc5zY_kNkM
Message-ID: <CADnq5_NrH98o8RN9RXGDgNJRMnE8gEwsTm+5dsNe_RXiNhTYaw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 01/10] drm/amdgpu: Add helper function to get xcc
 count
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Christian.Koenig@amd.com, Jesse.Zhang@amd.com
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

On Wed, Dec 3, 2025 at 8:44=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wrot=
e:
>
> Add a helper function to get the number of XCCs given a parition id. If
> there is no partition manager, return 1 as default.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_xcp.h
> index 8058e8f35d41..b780c12b07e0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
> @@ -217,4 +217,26 @@ amdgpu_get_next_xcp(struct amdgpu_xcp_mgr *xcp_mgr, =
int *from)
>         for (i =3D 0, xcp =3D amdgpu_get_next_xcp(xcp_mgr, &i); xcp; \
>              ++i, xcp =3D amdgpu_get_next_xcp(xcp_mgr, &i))
>
> +static inline int amdgpu_xcp_get_num_xcc(struct amdgpu_xcp_mgr *xcp_mgr,
> +                                        int xcp_id)
> +{
> +       struct amdgpu_xcp *xcp;
> +       uint32_t xcc_mask;
> +       int i, r;
> +
> +       if (!xcp_mgr || xcp_id =3D=3D AMDGPU_XCP_NO_PARTITION)
> +               return 1;
> +       for_each_xcp(xcp_mgr, xcp, i) {
> +               if (xcp->id =3D=3D xcp_id) {
> +                       r =3D amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP=
_GFX,
> +                                                       &xcc_mask);
> +                       if (unlikely(r))
> +                               return 1;
> +                       else
> +                               return hweight32(xcc_mask);
> +               }
> +       }
> +
> +       return 1;
> +}
>  #endif
> --
> 2.49.0
>
