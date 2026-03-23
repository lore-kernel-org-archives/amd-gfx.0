Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498EDF483D7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 19:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE54510E481;
	Mon, 23 Mar 2026 19:25:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n/p7GgtW";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E498810E481
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 19:25:39 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-127337e3870so396894c88.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 12:25:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774293939; cv=none;
 d=google.com; s=arc-20240605;
 b=UWOIdammeSbjIYflLaEMVgC+rLokgAFihRcreixiqsdNpEqChKEdPmhbHO55IKXmn1
 Ht/441HVqFHfqlOhNJ4gs8Cn7uY5xy3l2vy7SK61odE5aIYGaWxYxbIbYSTZX+2FSHTR
 EWMr8XqdV0dCceeMe23hSTr7HYTIhrnAJ/9Fd+zHl0aJGP43keY+NiURCCqPWaMnDdxu
 PCWfxcfwB3n3cY0K3ny5xSV18W6/L6fthV9oHoMzzhjUYHrSIV1RH+jqS+mJssYNp5DE
 mxEv+wRoGszVl62cOud04+RNVbpDz5kWhls8rM6dioDCdXziLtOYQMZ6hgHoTnFYa9BY
 Sy5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l8j75u+MLrHtIEeWr/WFkcTZvYEDYTn1wi06WGiEMUo=;
 fh=cetcAmHHBh51xnqqpJTNWjYLNW+VIcZhb4PHCr4NRwM=;
 b=fAi4iET7KAUf2It9i75q7a3F3NBDft5JQKmShuVj8DtNHt0nhQLSww5f3Z5WyHHKRJ
 LKN4NxGN7r9Rmx/m4q0RAg1aGisAVMTMhcZ70bNaqPdxCkX6eAau5pk5BVKooNwT82ai
 UcOlGa+ME+LFLdzwTEFOaeti5gl6hTz0EsDo1+bgf7TtzehKirXWCzdvFSxsGAO6VSE4
 YNV9q+awK5v4HdyK6z5fEWcqSjXiNSu6RBI0MmQ8uKYn/seplwH0qsKACFWRk2ywNCyy
 oUuUbbYUV1Mx8KmY4ga3WzixU8/jzSoNwFmkTJbf+XGVNf2Sj9cel4BhjyLqWkQp2Hgr
 dh8g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774293939; x=1774898739; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8j75u+MLrHtIEeWr/WFkcTZvYEDYTn1wi06WGiEMUo=;
 b=n/p7GgtWK/wL+k0P8y1Jeo9A+fkAtZ91HPA1HExamdDo8E776Hq3Q/7SMeZ3YATvqS
 TuUZJeNrGGGBLIEak3u/Cssrp9Vd0BDkOUpgsE6kdQ84ZYsu2IXmk3n7jLd36K2tfqFa
 XE3GELG+6NJ+8mNi0WBXJqvjlBKMI5w6XuwEQN/aD2NITIH7bP4We4sP8eTHnNEYWfEu
 z5LJ6JD54WkW4cnd7WOeYErF0zoserlPu4Lfc1/alEzjH7eqzbCiwXunONa9RQQzASmd
 qqWs+oQWh+2m1LGqgQ5xO/ut0g7yagfrSFFQfg+nt+D0eZa2KleN+GHVXLzuIT7uw2XW
 Dstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774293939; x=1774898739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l8j75u+MLrHtIEeWr/WFkcTZvYEDYTn1wi06WGiEMUo=;
 b=MzTMro6o+U7NGSXTyFF+LGbAhVcpyf0kTVzDQb+K0he/U05jiU+oRKCUW80uczt6Z2
 y0MhT9jR7dl+VY/tHRjO1QF/hZcPiLp1RKbB8uTY8VvG2QGBrWK2CossJRX4aYDLQyfV
 KrVJXTk2anRE3uBmZRfBIIvLd4YcY4q1UghBIZ2CZgejijehd/Da7YhbuOp1virhuRkM
 BfYCwxi0zh781SYbM0VN91+bGk28aJ1Nm2BadDwex3/Er343wAYZQxRpB4VW3Rtq4gYW
 bHHnVtwIJ1it9wKADmtmcKNP/z3OBSg0gGgs8cA5M+b5WYuaRgZ0EmrrrIvAAYO/yK5S
 78Lw==
X-Gm-Message-State: AOJu0YzJQXCk1LXZtu31PrG6bug8Upk6yqeyidDjIDPjsGn+VSPgOgql
 Hl4XH5H2qxhKCLZHVwhrq0lAGF8L9etNocTWUmDna1MD7xHI9Y7upPuQ7ZEVmavGyjYuy2MterW
 VjxdGfL+klVb8RZLbcOAAR4Idkoy2ygk=
X-Gm-Gg: ATEYQzwZLTY6RCiAK+S+mr7nkUKAa+yCb5FT0Xv5pjZPlOp4DEqgs3evhZZYl66P9x7
 1HoU/cw9cvoqcbCX5vWLU1MCQQPmagBlozuro4tyALaOGZwEnpbrYfa7PCbVeZfYMOU+2npzbVu
 xvhmlO1fhXRBa4cZ+lQxWx+ElDpfu9KMQYGcaQebmSKQrelwRAnSZOU41gUfDfBqOMsbR/jwK93
 Q2pQlkNEaue32OFHXfLIu7R8h/ahq/qHYEi5p0ObTnpVDormk1vy6iacpISbw2eNdAA8wlqwc14
 ViLCcmFABNepsK6naB+ilP7P99oxs01OUdkOKNAA/P5Jm4Hwymwh16zLABfbeddWhqqRCw==
X-Received: by 2002:a05:7022:419b:b0:12a:6cff:2e7e with SMTP id
 a92af1059eb24-12a726e44b4mr2806576c88.7.1774293939138; Mon, 23 Mar 2026
 12:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260323184457.1244422-1-Amber.Lin@amd.com>
 <20260323184457.1244422-2-Amber.Lin@amd.com>
In-Reply-To: <20260323184457.1244422-2-Amber.Lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 23 Mar 2026 15:25:27 -0400
X-Gm-Features: AaiRm53PSZIoeiqevVg2zD9JB2Z6eoRp4-x1-hCRS8X1hCQfmIPIdacROCXHnEE
Message-ID: <CADnq5_MP5uTK67hCSwLuMjMgCmDZjR1n9cqY8ULpARE-u+ibxw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Support MES suspend_all_sdma_gangs
To: Amber Lin <Amber.Lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Michael.Chen@amd.com, Shaoyun.Liu@amd.com
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

On Mon, Mar 23, 2026 at 2:54=E2=80=AFPM Amber Lin <Amber.Lin@amd.com> wrote=
:
>
> suspend_all_sdma_gangs is supported in new MES firmware for gfx 12.1
>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c  | 1 +
>  3 files changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index fd6b40d9da58..dfe18f0a3501 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -311,6 +311,9 @@ int amdgpu_mes_suspend(struct amdgpu_device *adev, ui=
nt32_t xcc_id)
>         memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
>         input.suspend_all_gangs =3D 1;
>         input.xcc_id =3D xcc_id;
> +       if ((amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12, 1,=
 0)) &&
> +               ((adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >=3D=
 0x71))
> +               input.suspend_all_sdma_gangs =3D 1;
>
>         /*
>          * Avoid taking any other locks under MES lock to avoid circular
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 44fa4d73bce8..2d08e33eb1e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -298,6 +298,7 @@ struct mes_unmap_legacy_queue_input {
>  struct mes_suspend_gang_input {
>         uint32_t        xcc_id;
>         bool            suspend_all_gangs;
> +       bool            suspend_all_sdma_gangs;
>         uint64_t        gang_context_addr;
>         uint64_t        suspend_fence_addr;
>         uint32_t        suspend_fence_value;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index ac9e26b8bb52..8a0c3dc0ecb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -479,6 +479,7 @@ static int mes_v12_1_suspend_gang(struct amdgpu_mes *=
mes,
>         mes_suspend_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
>
>         mes_suspend_gang_pkt.suspend_all_gangs =3D input->suspend_all_gan=
gs;
> +       mes_suspend_gang_pkt.suspend_all_sdma_gangs =3D input->suspend_al=
l_sdma_gangs;
>         mes_suspend_gang_pkt.gang_context_addr =3D input->gang_context_ad=
dr;
>         mes_suspend_gang_pkt.suspend_fence_addr =3D input->suspend_fence_=
addr;
>         mes_suspend_gang_pkt.suspend_fence_value =3D input->suspend_fence=
_value;
> --
> 2.43.0
>
