Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3A4C47DD9
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 03:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77D1F10E2C9;
	Wed, 28 Feb 2024 03:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=broadcom.com header.i=@broadcom.com header.b="hmbUYBnp";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B964010E2C9
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 03:47:49 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-608ed07bdc5so31756697b3.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Feb 2024 19:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1709092068; x=1709696868;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g/DHH/2GuNtK9+6RCOfdjmOHhlQolPWcSEw0qt7/GJo=;
 b=hmbUYBnprbe8hKUZS6k0HmThEuwEU7ExHRZroES9OZL5jlqcbZ72HouTmNYrlDpMXA
 MCTn0zooFQ8JXlvrgO0U1hlMFaJ4ZSmotTOe+3n0UHGBioa/rPzfljAHZyDYDeKrOu5K
 k3zme458LR7BfNuoD/nB6CYmpmgrg2LqwmqA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709092068; x=1709696868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g/DHH/2GuNtK9+6RCOfdjmOHhlQolPWcSEw0qt7/GJo=;
 b=qRbiDX8YGRdeDHZugKcAVQP0jQWlI+V09J920tVunXVDSgOweO/Ycw7UNj2nCHy9r0
 OxgTLlAKZ0aq3UGXXQnpuiw/jU6eyQeB7oZxhMIV6K1SmsaDzwa6zRNzPReULvr/C/Nb
 aGYt1UwYw68yk4Ziaj3vvSflyBoXxM2EZ4vSjyA9Jy/Sv7g/rA/7jIBth0s8DTQS4IeW
 AgR3zHK1j/8IHRIJkxv02/htv1oT7ZMIKnc3J3YnylCgEWiRR5aeShoZUSn7VZaioXBl
 7sztZQdJL/r7ED5rVfF3BvI0+h7gOdn8cVvlBMmkdVB6Kl5GPT38sEdD2hWF7/xI3h6G
 0GLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUYS8OMlc7BaDo3aQPh/bfdmrP3K9PW3ysBayLKdthF7hdsCqmWDPll+VZWk8lggDSOP1yxZK0bsAFRN2njNSPdVoPC10WIIIVuNN7oA==
X-Gm-Message-State: AOJu0YyjUq2zdpXK7bOXAHi6Jty23LRUmuFcQp57659M0qYbAgp3gNU/
 CYqPQ4aJrI7D76dy5xjmPd1uocUWzpFSQidY5sxA+YMA/ju9BOFQ4WmG5mPzceMoGd2MBZioudi
 UnqZ/iIqTacXkx0Rl4/PfuiwsV0DftbvqsAZ9
X-Google-Smtp-Source: AGHT+IEuu5G9/EtkiJuIqK5DEsLbHEiSicOLnCwW2E1hTZ+I5ANhBoRZTZztYsh0saLiizBliAy4AujGNkSwBQUlm8o=
X-Received: by 2002:a05:690c:f8f:b0:5ff:7cca:a434 with SMTP id
 df15-20020a05690c0f8f00b005ff7ccaa434mr4528537ywb.51.1709092068238; Tue, 27
 Feb 2024 19:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20240227113853.8464-1-tzimmermann@suse.de>
 <20240227113853.8464-9-tzimmermann@suse.de>
In-Reply-To: <20240227113853.8464-9-tzimmermann@suse.de>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 27 Feb 2024 22:47:37 -0500
Message-ID: <CABQX2QP4dCy2nfxXp3tEybtRF1UW_wMAKp1+m=2VA7Lt=C+Vvg@mail.gmail.com>
Subject: Re: [PATCH 08/13] drm/qxl: Acquire reservation lock in GEM pin/unpin
 callbacks
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: daniel@ffwll.ch, airlied@gmail.com, mripard@kernel.org, 
 maarten.lankhorst@linux.intel.com, christian.koenig@amd.com, 
 sumit.semwal@linaro.org, dmitry.osipenko@collabora.com, robdclark@gmail.com, 
 quic_abhinavk@quicinc.com, dmitry.baryshkov@linaro.org, sean@poorly.run, 
 marijn.suijten@somainline.org, suijingfeng@loongson.cn, kherbst@redhat.com, 
 lyude@redhat.com, dakr@redhat.com, airlied@redhat.com, kraxel@redhat.com, 
 alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
 bcm-kernel-feedback-list@broadcom.com, dri-devel@lists.freedesktop.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, virtualization@lists.linux.dev, 
 spice-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
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

On Tue, Feb 27, 2024 at 6:39=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Acquire the reservation lock directly in GEM pin callback. Same for
> unpin. Prepares for further changes.
>
> Dma-buf locking semantics require callers to hold the buffer's
> reservation lock when invoking the pin and unpin callbacks. Prepare
> qxl accordingly by pushing locking out of the implementation. A
> follow-up patch will fix locking for all GEM code at once.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/gpu/drm/qxl/qxl_prime.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_pr=
ime.c
> index 9169c26357d36..f2646603e12eb 100644
> --- a/drivers/gpu/drm/qxl/qxl_prime.c
> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
> @@ -31,15 +31,27 @@
>  int qxl_gem_prime_pin(struct drm_gem_object *obj)
>  {
>         struct qxl_bo *bo =3D gem_to_qxl_bo(obj);
> +       int r;
>
> -       return qxl_bo_pin(bo);
> +       r =3D qxl_bo_reserve(bo);
> +       if (r)
> +               return r;
> +       r =3D qxl_bo_pin_locked(bo);
> +       qxl_bo_unreserve(bo);
> +
> +       return r;
>  }
>
>  void qxl_gem_prime_unpin(struct drm_gem_object *obj)
>  {
>         struct qxl_bo *bo =3D gem_to_qxl_bo(obj);
> +       int r;
>
> -       qxl_bo_unpin(bo);
> +       r =3D qxl_bo_reserve(bo);
> +       if (r)
> +               return;
> +       qxl_bo_unpin_locked(bo);
> +       qxl_bo_unreserve(bo);
>  }

It looks like gem_prime_pin/unpin is largely the same between a lot of
drivers now. That might be a nice cleanup in the future.

z
