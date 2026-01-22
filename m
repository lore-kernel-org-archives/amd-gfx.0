Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674BFD6CFA3
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 20:10:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA69310EA81;
	Thu, 22 Jan 2026 20:10:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LSXaOA5K";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85CA10EA81
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 20:10:10 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1233e05c77bso151987c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 12:10:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769112610; cv=none;
 d=google.com; s=arc-20240605;
 b=h9hg2Zqyxd7Pg/wYb0zn45kgCN/uCSbVd7Mv/SZVOAqokx1qxabGaQFMlcC3HZHXVn
 c9CCEVZtJnGGYUb3N8C/FwT7jU2P9m2BFfbox28mtiG4fWRqlsIgID93Z1R+7C9BebZs
 wR2c79E8B6u9eH1zG0n0HHagSerxX7bwL8cX1yIi8sHlcW5hb06YJMGZJk0FxVrZ1Hz/
 r12jdi/aFkf755UtdFNYU3Saxae3yWIJT6akxCdjNyoymHSZQpseZ5RT5NQavky4W1XA
 fRykgab+s/HqAv7SOhlqquHXItJwS5+EF/3oYwPJ5TW4ZHGsvPc5/kS4NIYmV0ZvBAAt
 IC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Se2Mg4yJhec0ZfqdZFLTgywwvq6T5kN0i3ETcA44JQI=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=eAGib1Ar42BK41OCjD83vHPJoAtJqfPjANfjkOaL3UFjLoR2vcRdJOtHrgZ/jPoSLm
 g196BX5/CBvzbf3uad1ZfO3oj004owiR+9jdKyeFOziDDrSKx2VHP9QuUh5fOrfcindI
 McRhu6yJeJLimLypjSzvmYfLbV9Hs73gFPCI6mVilMsjzGObzwqV8nNbuVpWkeK+7leA
 vIGCd8E3z6oYJD3PRX0fwvJCdlTR+rIu6aGgsneW5bIXcxApH9YR2ypEbRxyC2gWTF2s
 uhsaT3lE2CvOWXAXsq8M3sL4TUwJ4bWA4bSKnh16Iie+cTJlbaNpCTw33QMGoKJzZlP9
 E6jA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769112610; x=1769717410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Se2Mg4yJhec0ZfqdZFLTgywwvq6T5kN0i3ETcA44JQI=;
 b=LSXaOA5Ksqnbn5eBJ+I3+DpfEUzKtGSKPQxeXRzfcSDGAwo6WJ4FtjzySin/UKtdyc
 CYhVvijJfIs344DE09JFv8cOaBjR/Bog/kMPxtXbNBKi8HP/dKVX2RIuxalHi0GrUIIp
 4ZQmAZK2V7wTZ/4gRCM8p0UFztWxhFJzPRPIEpIQaqqJIiqoDnS5tNVzpsIRECXwDkXC
 6AFyOD3zDV/6tnvkXRtP9347Ck+5Esv9kjagg1BmFa6Mob/VzU1YZDGR0UxT38hKcWYV
 TlBJlM6gXlwmWZ40YgNjqAHGaqCUBAqrVqnaJFH2c+olC0B4U5vjEcMkv1b5OC/NmJcP
 /BtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769112610; x=1769717410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Se2Mg4yJhec0ZfqdZFLTgywwvq6T5kN0i3ETcA44JQI=;
 b=RGptE/KP8bMPcHO4psI/PVfYEKUjEFez8VDVAMub48E2nKK3u/x9xhUyDCHqWrDqmt
 ygldBj0aqP6oG60BOiDkmpxjV/lvlCpceVKKa3KH82gLio8YRv5j6yCO4uxTteGOqNGs
 sNqK0Ta9saKFaL66Mg3nnFj2iurP5xtsN7vDt08s0ab4B08nBOQ3T5O/x3FrXXk0i8Pf
 O6iCAI6/feoyAXN73qQq5eMhCtvw+5eXTFSSw4X49KeszYmLODYATYRNNdMRYkBCfiLZ
 MO6ZYCioxu3NDATGafPONY534WJUjKqHTpla5VYJEbNO0LMRc5H/S9GiBhpsM4tpFAlZ
 C2Xw==
X-Gm-Message-State: AOJu0YxXTeSSHTxpLswzFLRtagrSYh6+vIIZaBC7A8jueXdgy5JQGaXJ
 v2eR60N0HmBG49O7A0b+WeObalfNnlHK7rBl3xFk7ZSwoZA/AcOb/J69/tXByHHYLn8hHzWchnL
 Ei3yqWZOiqksDvtjV1rusFXHDouGy9OA=
X-Gm-Gg: AZuq6aJxJsci+hoWboncBnSLVt3bQ2NxW8wBNA/6en6ho8oolcR3oC9TG/RYqztLW01
 MI+xpGoicvYKpKTtwtG8JW/r4m4I5XmSYoK0xv1EcQfih9YFaxlcdH/E2F8PpSJ9ZqPYFFl2XUb
 WxZo1RdrGfzq90MrgY6XUoHVfxDOVslKuncln4kpcUUtr1n7Zq8WCS4fKWU3kvG1qyYRX2ouUMy
 Yw/ffq6KkYX/XuLM6vuSUGvG26eTqRojFtYsFwuRYv6UW/UzxKZYtbJGjrhEEqFtdOI0Y5J
X-Received: by 2002:a05:7022:f212:b0:11a:2020:ac85 with SMTP id
 a92af1059eb24-1247dbfac84mr138911c88.4.1769112609900; Thu, 22 Jan 2026
 12:10:09 -0800 (PST)
MIME-Version: 1.0
References: <20260122085738.1542800-1-Jesse.Zhang@amd.com>
 <20260122085738.1542800-7-Jesse.Zhang@amd.com>
In-Reply-To: <20260122085738.1542800-7-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 15:09:58 -0500
X-Gm-Features: AZwV_QjqnMmwfErU83usVVxNO30e-APNm_dmbY-5OXOXpSp7Ej6MRLr432rJkDg
Message-ID: <CADnq5_Oy16DcMLTBC0Pffu48XQ5ZU-FAtWE1nwh-eTiQK7HtTQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] amdgpu: Add MQD update functionality for user queues
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Thu, Jan 22, 2026 at 4:07=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> This patch adds support for updating MQD
> properties for user queues, specifically focusing on CU mask updates.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index f2309d72bbe6..ae221eaa5b82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -432,6 +432,39 @@ static int mes_userq_mqd_create(struct amdgpu_usermo=
de_queue *queue,
>         return r;
>  }
>
> +/**
> + * mes_userq_mqd_update - Core MQD update logic for user queues
> + * @queue: Target mes_user_queue structure
> + * @minfo: MQD update information (CU mask/priority etc.)
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int mes_userq_mqd_update(struct amdgpu_usermode_queue *queue,
> +                               struct amdgpu_mqd_update_info *minfo)
> +{
> +       int retval =3D 0;
> +       struct amdgpu_device *adev =3D queue->userq_mgr->adev;
> +       struct amdgpu_mqd_prop *props =3D queue->userq_prop;
> +       struct amdgpu_mqd *mqd_hw_default =3D &adev->mqds[queue->queue_ty=
pe];
> +
> +       if (!queue || !props)
> +               return -EINVAL;
> +

Should return an error for non-compute queues.

Alex

> +       if (minfo) {
> +               props->cu_flags =3D minfo->update_flag;
> +               props->cu_mask_count =3D minfo->cu_mask.count;
> +               props->cu_mask =3D minfo->cu_mask.ptr;
> +       }
> +
> +       if (mqd_hw_default->update_mqd)
> +               retval =3D mqd_hw_default->update_mqd(adev, (void *)queue=
->mqd.cpu_ptr, props);
> +
> +       if (!retval && minfo)
> +               props->is_user_cu_masked =3D true;
> +
> +       return retval;
> +}
> +
>  static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>  {
>         struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> @@ -513,6 +546,7 @@ static int mes_userq_restore(struct amdgpu_usermode_q=
ueue *queue)
>
>  const struct amdgpu_userq_funcs userq_mes_funcs =3D {
>         .mqd_create =3D mes_userq_mqd_create,
> +       .mqd_update =3D mes_userq_mqd_update,
>         .mqd_destroy =3D mes_userq_mqd_destroy,
>         .unmap =3D mes_userq_unmap,
>         .map =3D mes_userq_map,
> --
> 2.49.0
>
