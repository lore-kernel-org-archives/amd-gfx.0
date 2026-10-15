Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8436DCC6B38
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 19:31:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFCAA11246B;
	Thu, 15 Oct 2026 19:31:28 +0000 (UTC)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02251112468
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 19:31:21 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-15943c9be84so193601c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 12:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792092681; cv=none;
 d=google.com; s=arc-20260327;
 b=hndFdmNtuzcsk5f3hay44w+WZQVIWsKcuojeoZew0qyBtr27QsdUJxEHeES+tmF5MR
 qkieG6vRK3GNBYkrEBTwDQ08E6ZR+OVd+Yd8UcJ+aR8A6Aj8tO1jUe3YZolbV8oMpggw
 zlkMIth6hgLSA3goMXrNm3pnhbouXxhY9EPh2Yb9FchzIwStMmLT9ysXJsbC4JibcZJn
 cFdWFkJtHz9HILKmMP9OZDtgXo0IGNRtjvmNGk3NpixLDLLHZoERm/za6UKw5GAqNEkk
 p3fEK9XCIvpyfnkZvm6AC8073PiiNJ1pffzdG0QTlz7lkxJxSgBZizPn7eeFSPPkWZho
 H0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uGcvrjsLZ4+WulN8uwfKX4KHs4acz/cO/aztcXau3kY=;
 fh=Q8XfLa/HsYYJ909fZsdcfL9dG6jXKK0n9+vL1EIokXc=;
 b=f/SxviFSkHN5YYuAPY7O4olS7ziuryadYtFgWZ3S0zR8QD1+WpRkgHRG1pPY3LB8nV
 jRyeZu5AhNlI3OEeLYKUJFPxaaDLCExC0cVDxYWemLNPA+ZqUJ1l2PgQCVTIrev9H/k9
 2tCIBK+8bxZ3XZkAm+ZrXlWMe6XepzUqCPFo9TD5+BZnPPgJ9TmuwmDStxogLPqXkZc2
 oA7KyiEhr9lqf38PvGEmiAMYJecgYmDg0PhfX2bU1aEf4fOx0QiuIMJxg9ZhBirJ2V3w
 lePsQPaDcd63V+xqwmgqpAXmDzryThNp9RnPWSTwN9Fk6w94zpROA0dAbwk6/veBx9Ku
 QT3A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792092681; x=1792697481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uGcvrjsLZ4+WulN8uwfKX4KHs4acz/cO/aztcXau3kY=;
 b=BkeneofRV+386u4x2pjCnHph/oZHESwt2dKfCMjJ2NCyeiZhswIseNmPMqvoIWdyjZ
 nR36I3g/VkWdd33fd32/W9+BjQKXVfgywXhKX/H6oMMmYfE+R38qEto5iob8jLKqUVeB
 W9dJd8owZcZREeuJmtKE4eJes/Fe2hAp2jkaFM8vMYTM0nYgHOwnHe8skHwMMViEZYUh
 Imz7Lpz1g1vkoDmvAIqxNp5mDKclw2n/4aTRBuOoKDZ/KAXNm0J3KqdPut+YrJNoSlvC
 E09RithkwhLTdGSihbea85GoUBWzIm8OfkiEBxpqzb/7fRm8gI+hJDCcSpLHNejNKSFP
 l73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092681; x=1792697481;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uGcvrjsLZ4+WulN8uwfKX4KHs4acz/cO/aztcXau3kY=;
 b=OfQE8ndQw1BQiR1UrN72ygjgKg7MTml82x8Mgk43LgEFcvcYZX9ByVFQ664UoWeAC2
 PUyAAN6z2vPmAiF5JISsVOLQbVR0o7roCvlDh4VigGktW73LQrKd/9DlgUFzAeYAdCY+
 fNcApUafATQVZD1kyX2A3kCLOpcaNjotqTIJMZVJnbLG6UXPDacPvaNSOFnWyHt8QLzg
 uqqbxkqO7/D8eVtD0CR1k6vmko1zU+N9WsHf8er1/MI40iEv05lWApbRLqFYJ+n6HRyh
 2vkUr8zA9dUsQJjrzrxulvz8/G6GUrH7jDo+kVcLSzaP0hLYQZVo1l7QsQ+13jh3LNJJ
 m14w==
X-Gm-Message-State: AFq9FYKGQ69HMvmur/yYnvbcDjEnhMMZ8u/dLWRbZBYzlDZJ+ivht+Xb
 Ie/lkES337h0R9cflUcpbyoWca3WYnv6P9Ef1j97Cd+lLtvTchO+9ZNutpD4IqbK0CEoONy7YKt
 ls9HEaME6v+0KC38NLNt3sb1a6kvl9pY=
X-Gm-Gg: AYBFou34ip6PVpv31aydoRAOzR7mjKM/EZeQ4sqY+g6WvE6rlqN6Ufzjgm1VMidaMLm
 887ErfvStCvkeONWqShLuV2Ai/J6eGlBiowjfyDpqyf4j8DTpVopluRHrTgUoaCHvinYVDj3mdR
 uxsKuPptMj6ijJTn3LXHcyqgr77ye5yKTzpJcjRX1qpELMGYusxaBZmuZMF/rlY21zTnDg0SKfB
 oVief4rZz2AFkCsLwuqCDyGZ+fSkh1FtnVw13y9a20+S20i7xLfm6CSX5DIGwbWSxPB1LwakugG
 wIJ8ko69vaCmaF6nAsSgugdsJ0zUjwAxoLzY90pz51WlfFWUcAIquVLJ3ew8jTa2NClon35N4mZ
 M+pd5mZ5jXsvnGwl3AEfbAp8Yt+KnmDhLqAIuX+0WOSE=
X-Received: by 2002:a05:701b:4510:20b0:16b:4f52:a08 with SMTP id
 a92af1059eb24-16b4f520f3amr41416289c88.0.1792092679026; Thu, 15 Oct 2026
 12:31:19 -0700 (PDT)
MIME-Version: 1.0
References: <20261015191240.23092-1-David.Francis@amd.com>
In-Reply-To: <20261015191240.23092-1-David.Francis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Oct 2026 15:31:05 -0400
X-Gm-Features: AclHuK-_UMAkm_G-9XtgQbr0NgS_35IM6B415bMPuszQ349lCuQqnI2lzNH9aAQ
Message-ID: <CADnq5_N8hCQ2_f3qMU5G8bHDKOBqn=7HDpbEZWSSidQZh3txRg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Check before ctl stack copy in CRIU restore
To: David Francis <David.Francis@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Thu, Oct 15, 2026 at 3:13=E2=80=AFPM David Francis <David.Francis@amd.co=
m> wrote:
>
> During CRIU restore, if cwsr is enabled, there is expected
> to be a control stack that needs to be restored for
> compute queues. In other cases, there shoudl be no control
> stack, but we were copying one over anyways.
>
> In that case, skip, and warn once.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 75e5a9f67d50..0350c7c2b307 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -463,9 +463,13 @@ static void restore_mqd(struct mqd_manager *mm, void=
 **mqd,
>         if (gart_addr)
>                 *gart_addr =3D addr;
>
> -       /* Control stack is located one page after MQD. */
> -       ctl_stack =3D (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_SIZE);
> -       memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
> +       if (mm->dev->kfd->cwsr_enabled && (qp->type =3D=3D KFD_QUEUE_TYPE=
_COMPUTE)) {

Do you need the queue type check?  Doesn't SDMA use
restore_mqd_sdma()?  Also is a bounds check needed for the memcpy?

Alex



> +               /* Control stack is located one page after MQD. */
> +               ctl_stack =3D (void *)((uintptr_t)*mqd + AMDGPU_GPU_PAGE_=
SIZE);
> +               memcpy(ctl_stack, ctl_stack_src, ctl_stack_size);
> +       } else if (ctl_stack_size > 0) {
> +               drm_warn_once(adev_to_drm(mm->dev->adev), "Control stack =
for non-compute queue in CRIU restore\n");
> +       }
>
>         m->cp_hqd_pq_doorbell_control =3D
>                 qp->doorbell_off <<
> --
> 2.34.1
>
