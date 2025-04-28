Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C225C369D5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 17:12:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3553210E222;
	Mon, 28 Apr 2025 17:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f58k4u89";
	dkim-atps=neutral
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D6D410E222
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 17:12:11 +0000 (UTC)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-af5f28ecbcaso309097a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 10:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745860331; x=1746465131; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek8aOtGJ49yB/x/v6V2LOGvo0xYZk1X6cssagwhYZZE=;
 b=f58k4u897uhk0QwB5regBMcOenORs6ErC85/hf5Mk7xMZvMCCRWNMGqWY4Tssfrwf3
 OWbJ7tzzu5Icxsa+oMGbFRD5rwtABna0v4hXcLlvfbqESexdFRrQPSLpG0Ykw8kLPuoZ
 vUEQiFp8OAAxedq2FwbrHIJlIr4y7/Z7cIQlOapKS5Bof+mQJeJCKVV+88IfCCmxRdDl
 N0/zMHuOwdrKZYPC05AM3CST+ujJqe3lHb1tYCXJs0qyNnXI0TJGcpDooSb6iNzFIXcY
 GY9EzGqKclnScVT20PazSK6DH8O/Zk0fK/hm9Of4lCICJElujMCaK+2l24U+aihnVIX3
 WC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745860331; x=1746465131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ek8aOtGJ49yB/x/v6V2LOGvo0xYZk1X6cssagwhYZZE=;
 b=G1nsKmWSwbjYOZu3/ryMwS6RV11HsC5ptZv+4cxWO49WGAGyTAO6zIST9EL/tzkNw8
 O86ebWkTBoqckJyH/lfstSR32OhBvuUcNe1kNvlGhrRQn47htV2rD12d6m9HHMKfARDr
 AseK9iTncUCRON1gJBXqpMqTMyMMv4QesWslO1JS1qFJui0r0gn3uEDhPWtILTsDhJqt
 lgOAh88lPdUcrNjrt15y6dO8jchjmhoEyavlbM28uH7B6iIBpMp8bIsjD4ZxnLbyERRa
 0PTSuoMv/pe9ucx2JNbI+7EBkzkzSBpRQ/R3WK5Txn60+Lvy0KoUhW64n5BnMvNBainJ
 M2cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjJ0dfkSJbwLNuqaH1DFn89GLCBRE/ULITtlbK9nplti0kJNO0yF6CqM0QGp0nQMhncDKYZsal@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgYvpqXVx65qycHbF0IjCXlTmpylu9yRtZEUtqmtuX+sQrGtsQ
 9klQhqkJcURc/rFsEK0zszTUlOtcDYhSVCmcSLBYdSDx2N+pQE2en48eEp8ZlGGw4rDWtD4JXEJ
 v9k/JYtAZ8cbhb05Th75NPa+c80D4SQ==
X-Gm-Gg: ASbGncs3BBQGD79GTuBXf7Znu7J1dmHr6tnchk2J3hyQz+IkZsEuIetz8WPzyQyAmcN
 hJNRwAfD3M04p1KuNTpnpL//x55UVvz1wdf7LuYbbYxnVZZpQYiLC+h/QEAagpV+GRqLOf3E49t
 RWFMNUItXaoquyMWweOHKirA==
X-Google-Smtp-Source: AGHT+IG/vyCch42K7vit2Vk4k+ddvT4BtM2WPsT92WPeLvIRjQO9WmT/eGFq2IFefBrXmKnJDY5luGEM+4wQCWZ8of8=
X-Received: by 2002:a17:902:d483:b0:224:e0e:e08b with SMTP id
 d9443c01a7336-22dbf155e64mr75449255ad.0.1745860330907; Mon, 28 Apr 2025
 10:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250428043754.1125751-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250428043754.1125751-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 28 Apr 2025 13:11:59 -0400
X-Gm-Features: ATxdqUF_1IzVTzOzMy1T5BtDzBgGwkdR-mR6RCcaHx3gdoKPmH2HSp_gHlMW0r8
Message-ID: <CADnq5_PnAbUppnajb7rXRND+sa8DfWCS3P+OOErtg0Awggc5vw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: Fix unreachable code in
 amdgpu_runtime_idle_check_userq()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, Apr 28, 2025 at 12:38=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Changed the control flow to use break statements instead of goto to exit
> loops when a busy user queue is detected.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:2751 amdgpu_runtime_idle_check_us=
erq() warn: ignoring unreachable code.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index b9a1ef343c79..801603510d56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2749,13 +2749,17 @@ static int amdgpu_runtime_idle_check_userq(struct=
 device *dev)
>         mutex_lock(&adev->userq_mutex);
>         list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
>                 idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
> +                       /* Found an active user queue */
>                         ret =3D -EBUSY;
> -                       goto done;
> +                       break;
>                 }
> +               if (ret =3D=3D -EBUSY)
> +                       /* Exit the outer loop if busyness is found */
> +                       break;
>         }
> -done:
>         mutex_unlock(&adev->userq_mutex);
>
> +       /* Return -EBUSY if any user queue was found, otherwise 0 */

I don't understand how this changes anything.

Alex

>         return ret;
>  }
>
> --
> 2.34.1
>
