Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2E3F54AB8
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:32:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB1F10E6D2;
	Tue, 24 Mar 2026 13:32:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ePsdTKWm";
	dkim-atps=neutral
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B44010E6D2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:32:04 +0000 (UTC)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12a6b260693so361027c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774359123; cv=none;
 d=google.com; s=arc-20240605;
 b=DwHiHi3NEhmCB0w9a/En66MXLeJeTLZzhZNck5t/gazYNgAjqOUuqJFxAbkryHJvkQ
 EgQtI6I6etyRr04On1Yp3/+WX4Wfui++gz/rDtwps0fpzpswcj67DMteyAdoHVXgZeMr
 JPMKh4yOmOv2yidHCsJ2FDOkDkk/oGXvyhnKL/z9xXiGez0gF66++HUUpzfNwRKXqMu+
 eJSfGqIB0qQ3rv0pWhA1BEvfJ4CCUVCzSuxs2bZ79vp8MrW6jE0vwk3XPGNKq34PzkNJ
 imVU6SuBNLl/0qqjbzOupLMkaI/ZJ4jnz92z+9oQWwiQKtD5f3B+awrM5+a9heZkKuaQ
 MfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
 fh=wI+ouv168YECt8ESdcDuYVThhZrSxBi2e2g5niu2U0M=;
 b=D7DzOQuy5vj4ce/TtLdbJnErogxA7umlqGIRbNrCoi60dLGzRqX9y3mKDn85gaJbC0
 YutJPqCwxmAKSEwiHGS4v+UD9RhB4L61E48hf87zd6n5i7i0y53/6IPt4Vn+ipoAAcX/
 uXwR6waZXO+40gUjJCLnaiE+ASf803QeZ6sV0JRLQAsLWiMFSvakbK7WpVgWOL9QNcvP
 XLxCRDzxWA+Hn5ytyfPvKMtGSFaVbUsIMuvTcFDIiyoFt0H5PtbnNR4aoq+eygHGWJ7d
 rU9uxVaA8smmXDRS4fRaq7Uahml4QAGjMuieTaLsJ1nO3t37+r3YTKVUTQYvCQGZ/plP
 E+Wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774359123; x=1774963923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
 b=ePsdTKWmlKuBLhY5gaor493LRdIvw/A9fOukZ3DnwdE2Ke2GTeZHcrOK4stEuEuX0W
 GJhG+RZ+lmyMq6c4JqoIV5s/TSoO9NZFtVdgEQ3ryPjx/WESg0phz+JcAp1EJF7W8nbO
 ISaeDgZN56cjUhirq4KIApK8sC5Bo7HN1f1Ih4L/lBUiU91T9TaW9llOwmKFQ5v3Tqy3
 mOJjAz6UqvxQlGiQhBu9/wFVIf2i9bfhWsfgUIXE6ftRtvSYzvmFl6LPwFJC2reeJHaU
 jlj3M+HBFdONmXCqpMkxYetZhgd/n69YpWJHpFLodCIfriQxf7U19krfyNQb7cVjKXNi
 eqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774359123; x=1774963923;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j5883fLgA4Kxp5uDjU6jNZrlbfEleppgZMvpZ9qx8xQ=;
 b=CeCelNSqULFWT44tR/AhW8k3WNLqkHQ4tD4Xfr9pjbvFu8+1GLB1P9JR5Jl3dopyd/
 hEX3PnDv1FqpGkDrQ0hFABbnyn5vXxEq07FcuhZ3fAWEAhoqnCu2c82/qs5uneOTLjd/
 FVF5AlmqjlHcKY6BVzoLifQ/kZzbIBT//IVbq/1PkTimCKSvXZCniDJ20xx01JZy6qbD
 ML3uJB1b1t6lCKpIUfGvuy2tp3z4drniXZ0Liz7EgnlIPLbovSY4C5kkIjz/vo7596nG
 ReZ1RXrY92XAoM7s99jr1tFzqEz22j12V0Pu3nK7G8wpt+iza9B/SiAXH8DBGO79HfCf
 zP5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSVeNUSb9pUFK5TrFf95FDDQgOf+6OMiR+yTbXmW5iIQ9VmUuBYSkzFd33kdjUudX4fWHy6DKL@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw76UaKhwA8jmXmdFiISlUSWHWlMv6nabM6jdvM0nSLWJG8wVfz
 9mgPdrkQgPcjwuIdYdmSV3Vha7WhntB0tZ4OYJ+CwmZbThdKBAC+Vs+u+wkq1ZpkcYiRqwSMWCB
 rfaXk1qvLecKdqrrymfDkILAkIDY17y0=
X-Gm-Gg: ATEYQzx2LSJswHj259fThrAzz+vQc8Chbi7djgkERQXUzBUp+Qtow/+Hfk/9VUdtFg+
 7SpitO4XQc05RErHgvaao4WkoI7K4oEjltXDISlBRF9BGnOzH5pAmj6RsjRt4gJWJiCkp5hVeLN
 NbaCfpkQgzOo4v0cmdTIi+8M2phUyyhMXCU6UlFigpSUCU5VcoCOph3MSCvyYhP2Jc+iGaQrnCW
 BGVXeGwO7lD+kDbeipbzGAWHbiLHH7R1Flzrfo53gtwJwdbVUml5+yWtpK6WHiKFo1b8yOLyNOU
 zHYtifDc3+T2hQznh4akyl4O/gW3HJ9Hooy4UTKuG9gbgc93JmxjHQdzh0VrAWW7uuHSdA==
X-Received: by 2002:a05:7022:60c:b0:127:def:dd72 with SMTP id
 a92af1059eb24-12a72646221mr3600922c88.2.1774359123172; Tue, 24 Mar 2026
 06:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <SYBPR01MB78816FAF00EC3DADFA588E0CAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
In-Reply-To: <SYBPR01MB78816FAF00EC3DADFA588E0CAF48A@SYBPR01MB7881.ausprd01.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:31:51 -0400
X-Gm-Features: AaiRm5082bmB1vEFeF97G50_iqqBjFx7HoPxAOrnxaX1HwxWGKygBeGTgapRc_0
Message-ID: <CADnq5_N83j3ZjNKXH2K8jEod0s64JB_pdugGsx4AURoPjpveSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: validate doorbell_offset in user queue
 creation
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
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

Applied.  Thanks!

On Tue, Mar 24, 2026 at 5:49=E2=80=AFAM Junrui Luo <moonafterrain@outlook.c=
om> wrote:
>
> amdgpu_userq_get_doorbell_index() passes the user-provided
> doorbell_offset to amdgpu_doorbell_index_on_bar() without bounds
> checking. An arbitrarily large doorbell_offset can cause the
> calculated doorbell index to fall outside the allocated doorbell BO,
> potentially corrupting kernel doorbell space.
>
> Validate that doorbell_offset falls within the doorbell BO before
> computing the BAR index, using u64 arithmetic to prevent overflow.
>
> Fixes: f09c1e6077ab ("drm/amdgpu: generate doorbell index for userqueue")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 7c450350847d..0a1b93259887 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -600,6 +600,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_=
mgr *uq_mgr,
>                 goto unpin_bo;
>         }
>
> +       /* Validate doorbell_offset is within the doorbell BO */
> +       if ((u64)db_info->doorbell_offset * db_size + db_size >
> +           amdgpu_bo_size(db_obj->obj)) {
> +               r =3D -EINVAL;
> +               goto unpin_bo;
> +       }
> +
>         index =3D amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>                                              db_info->doorbell_offset, db=
_size);
>         drm_dbg_driver(adev_to_drm(uq_mgr->adev),
>
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260324-fixes-9ee6cab7bc47
>
> Best regards,
> --
> Junrui Luo <moonafterrain@outlook.com>
>
