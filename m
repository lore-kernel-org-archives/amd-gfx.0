Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CFA9EA4E2A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 16:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5D3210E22C;
	Mon,  2 Mar 2026 16:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AKRmS+b2";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6792510E22C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 16:17:50 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12734af2cdcso181496c88.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Mar 2026 08:17:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772468269; cv=none;
 d=google.com; s=arc-20240605;
 b=TyHD/ExAbbSlwvMKLF7Pn9nP2CLw/ZZIziykVSSf/5g989RU6+bVr/CzC+3n95dhR2
 PIpI+q5JVtp71dimS0Ie5lT2ZcbWN+0zQNebd3DXPzHURhig1l4L5nMnlfhk8xeZAwaw
 M0yPSZ7tO9/JIbTK23qH9+iqcaf5P2K+ptFMy0k0574NDJx8m/uAa2FvRPFHmHpnJK+u
 Obwajx0VgvvM6ivltFbayQuAKKV4Eyuyqz9HIkrWL4I+GbTiLYygtkqlIszEsaxXzk+0
 pDZnOTbZsVMCKj9lBIBHQearv5atK1zzLOipwBHAN2VXyJEQ32axPfa54iGA4qAL7zdt
 U/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZfaH/3Wx9Q5ahwsdbZtTYLuubp3CE13eCtbChejtRxg=;
 fh=85U+/urkCTrm9Da6cLdfwv1TTDhZiBG7SWizzD/xO0g=;
 b=hfjRXNgY6r4siYVo2SnhYop9cNShX60U+Ttqlm4grLvfVrpPJChh4lOa8geluUl7BB
 m4t5+g7pWcoPCGnWyfSe5D2+pBIuDxNZdkZ1TOFzpeHK9H9jy3MjDLxLrpjl6XwnZVNg
 P23Su2lF/ugahtqPdzntjYXGxM8TMauQ40SnNjtO6Vy7zWjMawLA3ZWQx1g6z40tPNIZ
 hbMeEkt8AfX55x6kaePakF84+bV1YT8uNa6ql/DnHD22fe5KVaWs9Quv3VOZI3iOnF7g
 In8zMdIBlmmbZ11BIvyEnCVg3Qe4jUvVKhozr6y2l4Pb1LxUVO9OfCkxLmEbNKml/yUS
 7Asg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772468269; x=1773073069; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZfaH/3Wx9Q5ahwsdbZtTYLuubp3CE13eCtbChejtRxg=;
 b=AKRmS+b2Oj2UoY/Hi88+hd1ij0owIJVE0whiYVU7g3dr/BhRtWYXSe52qJOZaQdTjk
 YR0Rrb08iMBAE32NcTjTJ2r8yvn+G40txiLTQubOKb2vp5HnHJZBBrBiB9+OPQ49n/Xi
 RKvzuL7aM3M5aT716M4SyGMHFbIA8CseA4qkjGzAN/GXsOD5PR1MN4oNxxZdXNbE6ETy
 765sCN6tdTwT29smdKHlb5BU+WIfc8YgcCM+uQMbSf6+WH1qBKGsDrafROPi0Z6RLFjt
 CxnFktiFYrqKNOYWTfwur0iKRNQijk8semhlUjuxsaUyLYIC1iCWft0Dm6CLjGBMg26G
 rvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772468269; x=1773073069;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZfaH/3Wx9Q5ahwsdbZtTYLuubp3CE13eCtbChejtRxg=;
 b=XOPxQw3yEG5FlN5HBLokQeAQ28Q1i+a4uacANq+i34T3tRuDIpd40IlcfySEpG52n6
 htJpF8RMmX+JFOQbCrvlkZz8tm+Wxj5sHjZNppvTdACmGN8AS1BhTGI6hpw5X8AvC0Am
 tDtZvOhljpyeyyOFfv3E6LIZ0+FOh6lcciPVcVr9QnhpPikWD78JOYGG4t7BSk4YGVhD
 lsjrTr8/e2M0jsGWa5m9wfkYm4Xf5XUbSCkmCEEHDv/klXx0eIAHC259TM1AprrkLlTH
 YOjpO6S0DDtZzR5WlQ6lWqEuUQ9BALsbMFyZqQ3j37VaRmYDJPJOYGLne9afs3DDWRTs
 xciA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCp+tpIp4khaDUzJO6haV0SOAxow1wNH5bX6aXF4fj6fH39GNQrDr3uxFRxyiy3HLYNgzbRfhd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdjKP5NZlK9ATl9FXnxep4nnIjdufXsakPv/qID2sl5wOhEDzW
 l9PrlWxkgseUdirdQs9q2Nxel/A4q71cA+ruEvf0+C1LHC0ShlbIom5dQdiLfHw7aVihDB+xAoT
 1z/TlxvNlMYXKdl9g65uF6A+9NWRSsCc=
X-Gm-Gg: ATEYQzxV0eh7N6sdyUd5EVNaxLUVyO4Ba4Dm2fuuW+u7OLShHpmnk0N1LEE895SW7IU
 YvC4EBNAw54ecWodmExJybWupiyMtrEsx8nQbUUrXxKvJ10/zv+nr+apNamNWSBpQTxPUpXeERQ
 uJZK/IirBZcZq1lSi1A+u4/+dlDoba/ndqya5Kf+p+zzBNJpT8B1R6h2mJuGpxwTIqa7Zlliy4z
 KJ84ydX40MLX4ueSaGDjrD6Ep0G5wAyuc3L9m9pYDFegR/2ze/rWHMACdhrH91LpJUpiytpAWun
 idKR9YddXkbaF4NJM95byBnSxHoa7kKKRtcOMDR0QbRvx9RmyX++/14I2Z7cZR7a6osSSw==
X-Received: by 2002:a05:7022:e15:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-1278fd33fd9mr2973938c88.7.1772468269383; Mon, 02 Mar 2026
 08:17:49 -0800 (PST)
MIME-Version: 1.0
References: <20260302134702.1238027-1-sunil.khatri@amd.com>
In-Reply-To: <20260302134702.1238027-1-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Mar 2026 11:17:38 -0500
X-Gm-Features: AaiRm51t-G9MaosK6qiKzQhugu9w-qfsinjFUBa28bZO398XJA9i3OvHredfQd8
Message-ID: <CADnq5_Ok2GXTkJCZRoMKYnyadnh+qQQUvwv3-D1a7332oavvdA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu/userq: remove the unused variable from
 cleanup fn
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Mon, Mar 2, 2026 at 8:47=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com> =
wrote:
>
> Remove the queue_id which is no more needed in amdgpu_userq_cleanup
> fn.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

This should really be patch 2/2 since it depends on the ref count patch.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 9eced6cad8fe..0ff774b26145 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -446,8 +446,7 @@ static int amdgpu_userq_wait_for_last_fence(struct am=
dgpu_usermode_queue *queue)
>         return ret;
>  }
>
> -static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue,
> -                                u32 queue_id)
> +static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
>  {
>         struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
>         struct amdgpu_device *adev =3D uq_mgr->adev;
> @@ -657,7 +656,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr,=
 struct amdgpu_usermode_que
>                 drm_warn(adev_to_drm(uq_mgr->adev), "trying to destroy a =
HW mapping userq\n");
>                 queue->state =3D AMDGPU_USERQ_STATE_HUNG;
>         }
> -       amdgpu_userq_cleanup(queue, queue_id);
> +       amdgpu_userq_cleanup(queue);
>         mutex_unlock(&uq_mgr->userq_mutex);
>
>         pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> @@ -1410,7 +1409,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr =
*userq_mgr)
>                         continue;
>                 amdgpu_userq_wait_for_last_fence(queue);
>                 amdgpu_userq_unmap_helper(queue);
> -               amdgpu_userq_cleanup(queue, queue_id);
> +               amdgpu_userq_cleanup(queue);
>                 amdgpu_userq_put(userq_mgr, queue_id);
>                 /* Second put is for the reference taken in this function=
 itself */
>                 amdgpu_userq_put(userq_mgr, queue_id);
> --
> 2.34.1
>
