Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2790D3C912
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 14:39:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370F410E74C;
	Wed, 10 Dec 2025 14:39:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V0a3Fx/w";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B86EC10E74C
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 14:39:05 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b9a2e3c4afcso690712a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 06:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765377545; x=1765982345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HSms78Ht6NY2yCQ9hp8za/ieYuMCdSkDcfq67wBoXY8=;
 b=V0a3Fx/wGIUhdvd8NDSX8lUtgFBwDMV58uSht4nn9PzVHiCM6uA4hj5xq4FAoCNx66
 QvDtH0yzjVUX6SvdD0ScWEgYmP2TcVtugGkV5FG2Poexb9FTl9BmYSx7v4t4UgmISYnc
 heoRZ1sINJuALCmVIvvgMw9uKYkB8zMHJTdkg3ku16hme22NM5IB6nXRr7nYel1FT5DM
 v6cGB3PoMuaXj5jtU5Mcj0PC49/EDrDnAJ1bbs7JyFpYIypHBGqBmk6/e/b1ZfYxBnmR
 LJaAy94BLUKuSy2wMu/eDyUwjmhuSyXHHSOH6oQAZ6jE8wK5zUf+xXU0piOlrMje9Xqn
 mwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765377545; x=1765982345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HSms78Ht6NY2yCQ9hp8za/ieYuMCdSkDcfq67wBoXY8=;
 b=SEU6ZCCjKjhfobYk/ig8itZ5eJr7OVSHAVzuGXASE5zsZCLGddkJSvminjszXd01wf
 i08T1Wg8lnHAJU0bVJZegixVXprcg98xELnrRKQiZo/S8Xaju6fhnb3QVF3icG6+X0bK
 yolB3Zlqx50Dh8qvKmSqUJl+twhxIh0AZWmHM8+VcqwKuYsTzr4EzIPZ+uIuhJAo+4zu
 7J8V8a27+G2C5oKe6duLFRCe4gbFy4IF9l6nDSpaVlz0hmtQVgcsdwu3nGDEEMwsltyS
 RSsHqx1BYBqjwEslSY1ocQkB3j8hDr9VvqmTihRZJseWsqDnGyzk2XCPnb3VPNRaKa/G
 TCfw==
X-Gm-Message-State: AOJu0YyatbZHgoeAjRTI8D9HFE2KeIKAiJvTNaqic0Eh+CGbQ9M48oNT
 44MIQayBSdTZ3LEoPirQHSB773FsaABixnsSB9FklJJi98A69TXLugIdTLoa6hexIL/wv+gU3P8
 oM+L4Mn1Hwr9zr5bDgYeITiU+tpkUohs=
X-Gm-Gg: AY/fxX4kRpERrBBkPd9tsWS8RxsT7dhibAlCajuqmJHxZLwp4ZX/sBxfFWg1IGsFodV
 7W4Aj0kvkaMz0G6+HfUAWquSBTze2dCq2WZaWNJfsptEjBwkIELMvDqEavE1ffK1R3qhmXw1EVp
 tl3CGn7VvbxhsT4IFTxzmds/eoVg6OZXnQ4vWl9PVa8R56dr804qUkYpGjvgxWvBt9gpKJhniyn
 LVSFLle2kQLgScOrKLHEHLyqHTN5YZNmbAWqq9rk0Mz45RS9yp1fYTxN3ufYkY/nf3Sgi8cniR4
 hcb2gA==
X-Google-Smtp-Source: AGHT+IEgwtljQ6g7wa8Y3rHGGHMymnKamhl58I9VgB1cm+flA61b11P0Zuf9UuWB49Zood3okWKOeWqtq8yRHazfK5k=
X-Received: by 2002:a05:693c:300c:b0:2ab:ca55:8940 with SMTP id
 5a478bee46e88-2ac05568010mr1185568eec.7.1765377545124; Wed, 10 Dec 2025
 06:39:05 -0800 (PST)
MIME-Version: 1.0
References: <20251210071235.510182-1-Prike.Liang@amd.com>
 <20251210071235.510182-2-Prike.Liang@amd.com>
In-Reply-To: <20251210071235.510182-2-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 10 Dec 2025 09:38:52 -0500
X-Gm-Features: AQt7F2pc3fYOK6br7wc14lP8mfoLk3PItrWF2rWyWKgoo_wcbS50R-qEYTwg7yo
Message-ID: <CADnq5_PfuYUMXbEA6rLWcypsaTmCXbBWaZfamVs3yRCoiV5o1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "drm/amdgpu: add UAPI for user queue query
 status"
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

Series is: Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Dec 10, 2025 at 2:29=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> This reverts commit cd4fcfed0dd7fb8d1eb2ec937ae1644534a307bd.
>
> Hold this patch untill the mesa implements the AMDGPU_USERQ_OP_QUERY_STAT=
US.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  include/uapi/drm/amdgpu_drm.h | 14 --------------
>  1 file changed, 14 deletions(-)
>
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 986672e7378c..c1336ed4ff75 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -334,7 +334,6 @@ union drm_amdgpu_ctx {
>  /* user queue IOCTL operations */
>  #define AMDGPU_USERQ_OP_CREATE 1
>  #define AMDGPU_USERQ_OP_FREE   2
> -#define AMDGPU_USERQ_OP_QUERY_STATUS   3
>
>  /* queue priority levels */
>  /* low < normal low < normal high < high */
> @@ -347,12 +346,6 @@ union drm_amdgpu_ctx {
>  /* for queues that need access to protected content */
>  #define AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE  (1 << 2)
>
> -
> -/* the queue is hung */
> -#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_HUNG    (1 << 0)
> -/* indicate vram lost since queue was created */
> -#define AMDGPU_USERQ_QUERY_STATUS_FLAGS_VRAMLOST (1 << 1)
> -
>  /*
>   * This structure is a container to pass input configuration
>   * info for all supported userqueue related operations.
> @@ -434,16 +427,9 @@ struct drm_amdgpu_userq_out {
>         __u32 _pad;
>  };
>
> -/* The structure to carry output of userqueue ops */
> -struct drm_amdgpu_userq_out_query_state {
> -       __u32 flags;
> -       __u32 _pad;
> -};
> -
>  union drm_amdgpu_userq {
>         struct drm_amdgpu_userq_in in;
>         struct drm_amdgpu_userq_out out;
> -       struct drm_amdgpu_userq_out_query_state out_qs;
>  };
>
>  /* GFX V11 IP specific MQD parameters */
> --
> 2.34.1
>
