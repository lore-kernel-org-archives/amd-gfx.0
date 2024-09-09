Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73788ECE577
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 17:55:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1805D10E543;
	Mon,  9 Sep 2024 17:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BATViDD5";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE4F710E543
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 17:55:44 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-502d7fc7d19so28587e0c.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Sep 2024 10:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725904543; x=1726509343; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=602Fr55/we2nYjB+BNp46ykUV5wujP6xoOf+MIsNzuY=;
 b=BATViDD5g0TJ7AfzabLYW827+WX0K57ycDHqNw3/V1d+cgFNqVpBXw9QxPg3+jpAe1
 zz3gkK9gxoA2FKafY3Cu1XmDa9NCApD6fwYq1nPJ1zPOpyBS26dIbKkPkpifHf8H44m8
 Q2lqqkRbnIiYEdovoY9mPJFhIC/x+jnUk8D8q+2Odldvhj2faDmTimn4zPYddtcoPKzP
 aIRGip8dyDKwnPHUWbqIuXHRPCvA1linPebcebEHBVg8PKb1Q/FAHjcxIab1I9ks4Fp/
 t92+uIKqpMRpRgEWa0aGgFYRBVfWixJe4xNd91xBRtBFjIPdcK7iUf0Lhz4eHswLCqSu
 DEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725904543; x=1726509343;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=602Fr55/we2nYjB+BNp46ykUV5wujP6xoOf+MIsNzuY=;
 b=hFHl/gxP2BjOly3W9E3vf5qYByO3jlVvHNKhFNG6ze2U/cxrjedvvrSh33vQv9GXeO
 z9HSE1o/Bz4mMVvZGIeIZcBoPiOqPs7P1vJov6x7CKX+vaRQXCQM6ixmX2xmNEnLuiCQ
 lgjIT8umx+30WqOoJ/jaqnrWlN+yqplHrPFr+zhMF2yLV6Ppcp50jNYA5YNxxE5D1KcV
 xB0rv/k3sqHvcrDFjfk1CADgO/mifcdIX5vz+sg/NYOMp+8R6iqdZnyV+0cGAMYYLv+i
 voMOEIzwFH8/YD52WMZd1mKNcQBLiDsoL3veFcB88c4GF37CXGsRDTh9tSuROjdCeVzm
 +i/w==
X-Gm-Message-State: AOJu0YyctXyd8rp0l+CzwqXMsOx0jrCgMVf7msLuFbEeyStNR+hZE+ld
 MXfFJNP8jv5EhW5zlCmasxSCsvK9SKIhbjOXjawx+k+Nrj2krEvR6GsjDig+BPeTMaAU3kSOmIW
 xJ+Mk36+H4eRoG6In5LQlQMivoFw=
X-Google-Smtp-Source: AGHT+IHDuTy/q8ZnoMxwsFGgY9n/iVp1p5rrnZPScBvg0oVEWOyFc9KgCIcCo4W0b1GEM82cuD7tPPHY47mg2Qa2mjM=
X-Received: by 2002:a05:6102:b02:b0:49b:ba74:f7d0 with SMTP id
 ada2fe7eead31-49bde2ee332mr6559072137.4.1725904543407; Mon, 09 Sep 2024
 10:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240909012041.1433796-1-jesse.zhang@amd.com>
In-Reply-To: <20240909012041.1433796-1-jesse.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Sep 2024 13:55:30 -0400
Message-ID: <CADnq5_N3dU7rrX+R6Fm-iqSU9hG0y_KbhK6P-5Qjh=qABnYCGw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix resource leak in riu rsetore queue
To: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>, Tim.Huang@amd.com
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

On Sun, Sep 8, 2024 at 9:20=E2=80=AFPM Jesse.zhang@amd.com <jesse.zhang@amd=
.com> wrote:
>
> To avoid memory leaks, release q_extra_data when exiting the restore queu=
e.
> v2: Correct the proto (Alex)

should be criu, not riu.

Alex

>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 20ea745729ee..b439d4d0bd84 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1046,6 +1046,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>                 pr_debug("Queue id %d was restored successfully\n", queue=
_id);
>
>         kfree(q_data);
> +       kfree(q_extra_data);
>
>         return ret;
>  }
> --
> 2.25.1
>
