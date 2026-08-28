Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACA4C61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B520810F3FD;
	Fri, 28 Aug 2026 15:47:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LoOVXAwO";
	dkim-atps=neutral
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com
 [209.85.217.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B39B10F3FD
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:47:25 +0000 (UTC)
Received: by mail-vs1-f50.google.com with SMTP id
 ada2fe7eead31-7395b602bb9so50882137.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787932044; cv=none;
 d=google.com; s=arc-20260327;
 b=PvG98fFBUubUi/cib4yEf8bQf04CH1DTk3CML/FKRAmV6UksdwbYdNIusMQpx+blFb
 S+/yWlJ+HtWH5AWDA9OfCOYgOXIyWRmFIs9ll2gPKja+RG8duumZNA4VPabLbRilN6/t
 XoWXdGN1/os20mwoCghGUBKyM7iK20+mgIke1ZYZj3aMhRqXKFjLY9bz1mDjNNpNIwd0
 Q13XuWV2ifoZ3elYN6ikb9UVYxJ9kYTzmZ9/IewYUqNQY8Qujcah9adfS4M/mDukZ9fP
 cVLZmuN2vHW1D+qvQflHJv40yQhqZ59dOq7zLo6bTUBvZ1/2Rzb+o+mvRrjJCZ5liqOv
 9PHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w1ncIeJS9w8awWYP0QLqKZZig7pXMUMycMWgzLmvcMM=;
 fh=6b5tz4EEr/2Mq1hsVlz2MpTGxvimzRT9WaUb8Z/aqxY=;
 b=JntP2tqX8eeOIcfhCwX8Uxq0phXJXSu1MduLyxL6eV8IHppGC+x3LRni8I40Nlalwn
 CMyXNOKqYcx+W5RUPlFTmfwlb/g2C5KhAJqJGEIqx/7fhpcbscxoRlg9cPJzShUlrLuv
 kcA18LeUyYu6X3PlLRtFRV2eZvvnNEjhpzE0o2Ly5hb31GHX1mbiHr13j9dkEGCFYq9n
 Oq62zkl2eZ4UUR/qeUbxQ7832gGnor3A319af57MV6j9v/aUsrY19y0IuUGKEc4awlzQ
 KEYrS6stZrtGWnLhxa5BINfy2n3IyQbSKcM2OdlzgB8STJIUYA2Wo7Rvt08m7FkaMFef
 IBzg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787932044; x=1788536844; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=w1ncIeJS9w8awWYP0QLqKZZig7pXMUMycMWgzLmvcMM=;
 b=LoOVXAwOkKU6KBZp88PVa3hKWSJQsmE//VePrul63GaizoJJFodXJOCUEhqYCrN0Sh
 ywGvrnuF0Xn4QKh6fWaNDeJe65P+0+EDHuhsJ5vRGoOyUpLoZis2BkTW/x82EU5/G/pP
 cxOQJ8xZcQVRuavE9YZseDvqF3ZkEGxFzenbZFQkF45GzhNN5CWaGW2CsAU0+Z1ox4Vd
 thU6BZFKGFi40N2uKaME+iEyMKQ5ZNCSr2v1kKeNwLas4scq2BhWSQUBbBtUpe3wDolj
 lu4E8ed3K1y4OuH6nEHcFaDI8vSjxSivsJ5OSDEN7tH7dPe9vCT9O+cR04qI2/hzkYQ+
 evKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787932044; x=1788536844;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=w1ncIeJS9w8awWYP0QLqKZZig7pXMUMycMWgzLmvcMM=;
 b=JqRyAg6yZeGGrt2NB/XlOsjKiGK4pwu89CGEusZm5/pXk4wIrT1CdGXm0wACejcVnz
 aA1QypZg4WcU4tt9ORADhVVNDUNyJmV6pA1DFFKJpS1hKwGtXRDVi4hiPNv7hl2dXQXM
 yXSLs125Kt3up1rohZ6to/Rn2Lf20G5jIUU/MOnKvblVpRUlUUpfQ770avw7IeaMXxoK
 xz1b+w49ypmzKrGQ3yKkD3TYxqp1Lit7gUn/1YaYjfoDGW4xdeu91/DPx2cNgZ/8pffX
 P1zJaOJPNNSZ9iIqignG5kucjBsAPkmHXqB3Bfl8YJE9x5Zcam3CHDA/P7auCqFUTseb
 rtAA==
X-Gm-Message-State: AFuF++nLSY2EO9IRraHxPsfyKkZF/MfqEuO2B0knCG2KM8CXuEJHjZXd
 05xUxbCZNtRujDIAVvt6nbTBGAcdd+wHJw/BBmVgQbRvW8MUdDRIFoCXvKbbFYF4niZnrlPEb2E
 969Yhp0XF9ts+ZG7R/yH0ZN7NoIHaQpw=
X-Gm-Gg: AR+sD11lLtrdo4UtOcsADbppSbvXLBHEY7S+Tfgp6gjTtQEe2mLXQIEEw6+L59ZUrL6
 6jpFXFdbA6JiHIa7HqmvOYxVwtRUVe1Hqr5o3EJe4daSks4l9HGrgO85WOxa+1xJ6u3gleKFBmL
 Lvjq/A71mHmVoEB7XOEAj5m81LDun3yB1spAm6dIL5L+3O8e0wz4rFhCca8jcXap6voHa8YChrv
 guO9/xJzZU/1j8sv5NVruPyMSjbMZVxvzwpWkUVWzpoojE+JUBTJGCacmxOYZANJmdh7aM9QvAn
 yV1W61TT/z4T2xbXmmLcfpuYftO1xmAbqNJTMURhkptQqQqoETgLX7bRzm71DWxlDqi3zKejCAG
 1CtkftwldMqJR89adpN96M4e9YGkZXeU=
X-Received: by 2002:a05:6102:a50:b0:781:9922:78f3 with SMTP id
 ada2fe7eead31-78596fd0a53mr1040544137.2.1787932043700; Fri, 28 Aug 2026
 08:47:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260828114113.13523-1-timur.kristof@gmail.com>
 <20260828114113.13523-2-timur.kristof@gmail.com>
In-Reply-To: <20260828114113.13523-2-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Aug 2026 11:47:10 -0400
X-Gm-Features: AcwNN1XZum7taAw5mRCyfl6x_Z8Yt0pKLUnCSe5Me5Dlcp8heOAHuFlFWc_4Oz8
Message-ID: <CADnq5_PzAgTz3ULCTEoe5avqxAWmJtL5r7c_8kYT0+LVzW90Lg@mail.gmail.com>
Subject: Re: [PATCH 01/11] drm/amdgpu: Respect noretry flag for retry faults
 on GFX12.1
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, 
 Philip Yang <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
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

Applied the series.  Thanks!

Alex

On Fri, Aug 28, 2026 at 7:41=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> When retry faults are disabled (amdgpu.noretry=3D1),
> we should program the RETRY_PERMISSION_OR_INVALID_PAGE_FAULT
> bit to zero.
>
> Note that retry faults are enabled by default on GFX12.1
> so this just fixes the case when they are explicitly disabled.
>
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/=
amd/amdgpu/gfxhub_v12_1.c
> index 15d2a8ec55a6..7fa451b373fc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
> @@ -436,7 +436,7 @@ static void gfxhub_v12_1_xcc_setup_vmid_config(struct=
 amdgpu_device *adev,
>                         /* Send no-retry XNACK on fault to suppress VM fa=
ult storm */
>                         tmp =3D REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
>                                             RETRY_PERMISSION_OR_INVALID_P=
AGE_FAULT,
> -                                           1);
> +                                           !adev->gmc.noretry);
>                         WREG32_SOC15_OFFSET(GC, GET_INST(GC, j), regGCVM_=
CONTEXT1_CNTL,
>                                             i * hub->ctx_distance, tmp);
>                         WREG32_SOC15_OFFSET(GC, GET_INST(GC, j),
> --
> 2.55.0
>
