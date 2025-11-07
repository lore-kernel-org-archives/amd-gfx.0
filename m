Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86396CCF9F8
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 14:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3078710EAD4;
	Fri,  7 Nov 2025 14:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ln0X+I91";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F05410EAD4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 14:07:42 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-ba3b6f1df66so55835a12.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762524462; x=1763129262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ds+q2neQilw5fsxVSP+mmmDeu4LuM57J5EJorG1onXQ=;
 b=Ln0X+I91M+EFf2aTrSdQhR7ckdsT2820KcBFDXBWbHL79ekFisizAQAWyB+xQ7n0nC
 4UdYW6L0KhyOJNrNWXHTwE3YPAjN3yQNlnRH5G2sBGBDyyOHVEhRDbzOuSW60KK+rNCp
 D2ksIuyH1rLHZZLQkMTxa91cE1elkCHfEKxu87OWgbvGm78OHR6p5AGJ5/iPZZ47jh3q
 xOC6DSpbJoxnbC1Hfdxspt45RgDUttCP+AuwpHjL1FfIRWL1IHQM6MV5qGTz+hWkWiSN
 wFIp+lGNIAxyNSinGxL/aweTwbRuwy9IaBX+IWdiHq4dgnq2gIsmliTVwK5aIt7whAiV
 Epyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762524462; x=1763129262;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ds+q2neQilw5fsxVSP+mmmDeu4LuM57J5EJorG1onXQ=;
 b=dXNHf5WhvQUlogCeYF0J+y7J6endaylc3OYb8PYMllLOR0978fd5X7C+cPUq1Faqs3
 5EC6ebo66YHobEa7KYniXktYKolQ78lSvq6BtzxTTs0ik7Qqv1H4Iex0v/BHC5mf+Omi
 ts1Gy1Pzu82CXjz8o4scyByHEusRa8HtpWUoV16tHLidCOw/EFdNQf4pHwXncBCBAZLX
 Vr7xXfzNrudxZzNlwXj4IdW0WWNtLfTF5mlO3l0+Ks1ckTqfytDbmPpotVppkLOtjhfw
 GSvXjwboygzhniC0S6VCav0ITjNnRL6E25T1IJmPZtt/rK9a0kTxtv4vZ1hne3n0JNn4
 Uy4g==
X-Gm-Message-State: AOJu0YyCs2vu+1FaZiSYtdmxl8e5dYGsHQUQQQ6F2FzFOd2ff6x/9BdE
 fnOXCFMdRtuTQTj2Ox+pX0UjjoNkEg5OjFfbDJ2Tmg7pbKsAvkxjfjq0pBejI+REzsDPoL8OZ2r
 YDTxjcp3cI9VshCZKVy58B1BnYmp8Uob4SA==
X-Gm-Gg: ASbGncsUjww3fX3vi4eDBATQQwC+ZBBvTRxrtvyRAGFLE71hstygtNCcMMcOWPAFFtI
 z0sZICbKBzovebXoBXyAsNztK5+2V6F1IY06RVs+3GM1tlAP9ViV2SAiRkVT9LybsNh7LMgZu1Q
 Phatv7kazqkaqhTPEFGaYdk8QpmEpvzb5Cym67Gxi2u572Tdofd+piBk3f8DQOPJnxDSHLmFFSk
 gy8L+zH+2yITTQF0Az/kWnUYcWkborZX6apsUc2OQlWLeVddXbVlvsgAUBz
X-Google-Smtp-Source: AGHT+IGW4K7jw2NHu86gPfVjIAcfhqPskVvAfFiL+V4XjPQJVBfdZD6AHqTYH6WV6tXKILlTeNzx2dVH3nnwNAC2eNQ=
X-Received: by 2002:a17:902:cec7:b0:295:5898:ff51 with SMTP id
 d9443c01a7336-297c03e1956mr24733255ad.2.1762524461944; Fri, 07 Nov 2025
 06:07:41 -0800 (PST)
MIME-Version: 1.0
References: <20251107112704.4080134-1-Jesse.Zhang@amd.com>
In-Reply-To: <20251107112704.4080134-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Nov 2025 09:07:29 -0500
X-Gm-Features: AWmQ_blwq07ewQhTHr64HdQzBtdUNUGoW6-xZhGQ1GladEmUKVstkEQh2NNEiq0
Message-ID: <CADnq5_MtwYtWN-63DAyeRHnLNKG=4qH5PMXdqfBAtXeoe7aFVw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: resume MES scheduling after user queue hang
 detection and recovery
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

On Fri, Nov 7, 2025 at 6:27=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> wr=
ote:
>
> This patch ensures the MES is properly resumed
> after detecting and recovering from a user queue hang condition.
>
> Key changes:
> 1. Track when a hung user queue is detected using found_hung_queue flag
> 2. Call amdgpu_mes_resume() to restart MES scheduling after completing
>    the hang recovery process
> 3. This complements the existing recovery steps (fence force completion
>    and device wedging) by ensuring the scheduler can process new work
>
> Without this resume call, the MES scheduler may remain in a paused state
> even after the hung queue has been handled, preventing newly submitted
> work from being processed and leading to system stalls.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index b1ee9473d628..6d1af72916a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -208,6 +208,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_d=
evice *adev,
>         unsigned int hung_db_num =3D 0;
>         unsigned long queue_id;
>         u32 db_array[8];
> +       bool found_hung_queue =3Dfalse;
>         int r, i;
>
>         if (db_array_size > 8) {
> @@ -232,6 +233,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_d=
evice *adev,
>                                 for (i =3D 0; i < hung_db_num; i++) {
>                                         if (queue->doorbell_index =3D=3D =
db_array[i]) {
>                                                 queue->state =3D AMDGPU_U=
SERQ_STATE_HUNG;
> +                                               found_hung_queue =3D true=
;
>                                                 atomic_inc(&adev->gpu_res=
et_counter);
>                                                 amdgpu_userq_fence_driver=
_force_completion(queue);
>                                                 drm_dev_wedged_event(adev=
_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
> @@ -241,6 +243,11 @@ static int mes_userq_detect_and_reset(struct amdgpu_=
device *adev,
>                 }
>         }
>
> +       if (found_hung_queue) {
> +               /* Resume scheduling after hang recovery */
> +               r =3D amdgpu_mes_resume(adev);
> +       }
> +
>         return r;
>  }
>
> --
> 2.49.0
>
