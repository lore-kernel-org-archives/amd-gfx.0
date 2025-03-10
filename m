Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CB4C282DE
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Mar 2025 13:50:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B81710E09B;
	Mon, 10 Mar 2025 13:50:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oli4RL9f";
	dkim-atps=neutral
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F4410E09B
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 13:50:11 +0000 (UTC)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-2ff67f44fcaso1205524a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Mar 2025 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741614610; x=1742219410; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSIO181fA9SK9EDThTYSCUrcDPz6NiBld82ohnnSQsM=;
 b=Oli4RL9fZbwJxs5r9To0p83Y4PatmzYEQeHf6FAZXHHgKKD0Xvo95U56IobuHkMvSL
 QFdeyH0VYDzHfYU9fvAGt5VegUKj5m/qnjDF21zgumL0iQoSk/ghEr/QkODmWBl7/Y9b
 XyZx7XcwFPMFbyG5gtnS1jJudw5TSVP04a6LZm6k1AnKiCmT0NyYOJVQsK6JXKFJIMEW
 qiZCcu0YzDRvyjism50e1cBcxyll4X5X03mOYbL5nnPGyYTbK7FmG0I1LqJeNy2Vj0uW
 AIk9bLZsa0Q1pM7Zqgu6mhwyCOOiLG+6neuuHWsgQ9WhD3V7Ufm8VCHK5nrNoeAHzAOa
 KAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741614610; x=1742219410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSIO181fA9SK9EDThTYSCUrcDPz6NiBld82ohnnSQsM=;
 b=LU8TRe426zBSO8j0s2fzVZFKuZ4el8v7yk5ar5YlBy2/fXy8z9/+oZCF9AK2kZgTT0
 /w0lM/B7ryFzGwYOyikzHSiAhXR+Is2oVFAgmSchjiXuaMaAqhWTyFyD7j31/m7ZrvLJ
 458TQUbvl6e/aTx8JXgNxm3jSmE9KQOuZYnSJmP5cuEoyQ0OyODa8gzt/za01jJMuasm
 eZIBE/NJZ7XviJfFlS8NbiEJYpbKSFELP+3xmKX3vfvQlTOCW4DQrOPeWHA9xWd0n0h+
 o71bTNtPuyac3vzp+vsLU/+BPVNGYYhUnmH6xzp66uEx7xNY8dQ2hqzmSr/Tm/VF2iFJ
 8uAA==
X-Gm-Message-State: AOJu0YwtHgFmv2bnrQOBYyQyQm9qAWfBhmd+FwHfJ5EIEidVFdiCdHL4
 1mi4951F1Ie3nUJrp2x0Z/LwYRCXg2u39QIcZEfp0Am9KUyjyMyAqDmZvieM7k9AnXyVy3AHvrs
 vq4+g/7mL3MVxvs4PbhTkYu2nXGBmWQ==
X-Gm-Gg: ASbGnctsAaVtRYIeU69vEVfmPLtyfxSr7i0pvYejNlDSZxOeKSoujH0+VqzADApjKQb
 spjz7/dTceq5F3a+DUymN7lGBlgmqX56XoDxD7NkY8vbqtOm8MTu7/SyTof5K7gkjiQDd8NLPhk
 kkTF2PS4oNKdo1Ds/WPFjJ8ifjivRy1SiswETm
X-Google-Smtp-Source: AGHT+IFNRz2szaUljyOJK/uOzOj7mwa9OnhWjZb1S8G4ZcXA6u6xru8GRgeDL7e7g+5aLZRgZ+b2m9+UwdMlr3f55j0=
X-Received: by 2002:a17:90b:38c1:b0:2ff:4be6:c5e2 with SMTP id
 98e67ed59e1d1-300a57a82dcmr5478043a91.7.1741614610405; Mon, 10 Mar 2025
 06:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250310132335.440011-1-Prike.Liang@amd.com>
In-Reply-To: <20250310132335.440011-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Mar 2025 09:49:58 -0400
X-Gm-Features: AQ5f1JoTJTOHMtVXsMc6gY1IgQYp50j_Ci51dt4r-JI8ZYYwKewkkl3xkWGfHf8
Message-ID: <CADnq5_NqhtW0pfpFVNYVyUgSa_herUkemV+9QVLXqiTVk7fcHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: correct the runtime deference for
 mes_userq_mqd_create()
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Mon, Mar 10, 2025 at 9:33=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> When the runtime resume failed, then the runtime uage decreased at
> free_mqd. So the runtime resume error handler doesn't need to decrease
> the runtime usage separately.
>
> Fixes: 4baa0dcac737 ("drm/amdgpu: validate return value of pm_runtime_get=
_sync")
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index 35ae4125cd83..b469b800119f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -291,8 +291,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>         r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>         if (r < 0) {
>                 dev_err(adev->dev, "pm_runtime_get_sync() failed for user=
queue mqd create\n");
> -               pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> -               goto free_mqd;
> +               goto deference_pm;
>         }
>
>         r =3D mqd_hw_default->init_mqd(adev, (void *)queue->mqd.cpu_ptr, =
userq_props);
> @@ -330,6 +329,7 @@ static int mes_userq_mqd_create(struct amdgpu_userq_m=
gr *uq_mgr,
>  free_mqd:
>         amdgpu_userqueue_destroy_object(uq_mgr, &queue->mqd);
>         pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
> +deference_pm:
>         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>
>  free_props:
> --
> 2.34.1
>
