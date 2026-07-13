Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D679C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 20:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3966910EACD;
	Mon, 13 Jul 2026 20:11:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ncQlVznY";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FFF110EACD
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 20:11:28 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2cea3ab2479so4634515ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783973488; cv=none;
 d=google.com; s=arc-20260327;
 b=UNFJPMWaiv5fsm8nLSXV6RByROikclMygR9RUQ6iBr/W1uMvXIyJlQqUJAtrIh7vZD
 40UFx+uAYdp4NDLj5y9aSnQojNsWU8P3jsZHBD8PU4aBPxS/V8SkaedmCEXpVjIdjuBv
 kZayJy6jKtdv90+UnBvVYfnJtDeAdDDmrON/C7HOFWhH9JEugeTl4eChmlDXsRwBYjMu
 8p/BG2QSim5hrWt0b3goqmE/DP6hp9GHIIVxeX0kwBbHXxnbW5Z/7a5N1an8sEZOUGhd
 o+MtWB2Yvsloze8cXwUQP+pQXZl9VaWsrdHfMZCkXdkEYKOmOYQHLAc/pHJrwi+eNN6j
 gxKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rRS5O3GWX9eEFRdUepaAkox55BnpSjsNp46AEdLh4SQ=;
 fh=nn5+HQlWkSRJUgq1J0Z4JbLbgEIk/a4G+Xj8hbiydio=;
 b=fk56q3dRNnx/PqcSIiv2njcDyjd85zF6DWNm825idFYFTFxFGnV1aWtkBcIv+bHEvE
 tuuPxNMo/mCHaJ1Q0tfurloOzOG0H6O2ax0hEK56kym0AOOzppkx4QAFTuMOtGOwKRkM
 x87n5GiYLkBuSJcbMQ0jds+PvPbew7aj/8NM8pe/ZDpMpDkJ1Qoj+LXp8hihGmmD9jEC
 Zg8WjAf1yQwzQkBqPGsOgSyy4i/IG2uA5vC73O/FmjQaX0KZA2mOcF4lLMMUdbhnJva4
 dANUx4RoJr43kFmhFdg1itOHYxmIJM2JVHCluzJxw6Bppz8GEOJDd2MJIIR7NnWtezAK
 7o5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783973488; x=1784578288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rRS5O3GWX9eEFRdUepaAkox55BnpSjsNp46AEdLh4SQ=;
 b=ncQlVznYie9G8XDBkDMwf9NLvpdc07mXGUvs7LorLHubdpG/iyS7DfkWrZvuy111Mj
 hbeW0TeaFA/VD9+oBugTXa0rI3DEcF/GrEeAYxmRCq3vuY50adHseG5gbTM5UX2MAOml
 9jXY8558tZuzPS+9vzlnu30rpNGUhmKc1ZZcC4Y9fMWQYkfetMkgwgg5W95g0vZNnTji
 xbriCMTZMH8bvS1Xt6hPj1C5hvgqZXsZRGHYvdJlM/OvzZis2AtW6o8IGJp6PU9UTbAO
 SxF96GZAK2GEQahA2PfiHs8216U/MFl7j53jSk9Oy9424Xz1CsQaNUDiiE6kUZClbYvq
 JtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973488; x=1784578288;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rRS5O3GWX9eEFRdUepaAkox55BnpSjsNp46AEdLh4SQ=;
 b=LbwdNHvs4ZY1b+3BIGSNt2q6d7y3lySY3CJFmLYbdLUTPljjcc8La+d0R/7jzI9y3r
 kSsHzyaDTEjpqK8URBltA+wYfj8ID2cPRJe76A05SUAYrGsXNtrr4ZhkBgD3vgrP8Jxy
 P4nJsnv5kcy1Sf3sLG+eQn/Vac/bYMuPsx5AQEombYLcqPbn0aryyCsRj3hZ9lupL7Vh
 rQQFQ4vYbnyGyv8ImbJsXThPSO3wBm2/9teyLP3tFPSrXiHxwSBRm/lwxSsxCyLXai0u
 9/eRPX7vRb0XzNPSWDrMHMbKvbjE7kiSFsgDIxRB3g6NaDSeeVuxBnxW4pSz2ty8ocBw
 BECg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9HM9Jpf/j4ty9T/q7sITxiUIv+fEzn1bp/n4CANCnxzKr1Iu6pyXCddthMuB+lf2K1KfT67NH@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLxZ9Z8tWmr0zX5YvJgEbKQDSgbtSmsQY7CKIB1QKiQGgUZzCl
 y1/ULW6jenK6xqGM73Xq5wDYwOShIwa31aIxJeqYbAenEYPDIc1Z7/TfyYFcbhg5k5ulo+t1NmQ
 MVK5n9n70MM/o+YdXrqzd5p9IIpqJP70=
X-Gm-Gg: AfdE7cnj4jpMIv7UW914AeAjUcdXe8cRvYvdIo1i2s8cb0SJmakgfPgSm4ZvOR8Azx/
 Y2ONlHkgOpTnb6TsrhCaffhwjoIjhJ83SFf4SmQtt9yhWGOmlxTmorewzVFFjA3HL60Yuo2XJ2c
 oHJ+3ULWAOkPXBi4RMg6JQW9FQA3Z++rfUbVSxT+48TXR1+qVy9pUIxa7obwTx4t4vnXSlxCm0g
 xAdLb7MmXwN3NPDpAFllNKQ9RZnqWYur7EWxOGwh0tShmQKj651yiJfDbCYAoX8j7n7n2XsEXMT
 FrCIJuQP/t2kGhqciJa3F0oMTaoNGGa61R8JvfWBDeeDGyHdJOPndASaEUdUxnoXzL16Sw==
X-Received: by 2002:a17:903:1206:b0:2c9:8287:fd0d with SMTP id
 d9443c01a7336-2ce9ef1bd94mr77890115ad.3.1783973487584; Mon, 13 Jul 2026
 13:11:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260713162722.3349626-1-srinivasan.shanmugam@amd.com>
 <20260713162722.3349626-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260713162722.3349626-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 16:11:16 -0400
X-Gm-Features: AVVi8Ce22J8hpKGXn2Z3prlLHfT58c_VKuuvpLn8epV-XJNMH_o6V4SJF4wT5H4
Message-ID: <CADnq5_O8VpL7D+1dKn_whLa-k6Y796a1ELns0mTsPortXJ441Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] drm/amdgpu: Signal USERQ_EOP EVENTFD notifications
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

On Mon, Jul 13, 2026 at 12:44=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Signal USERQ_EOP EVENTFD subscriptions from the USERQ interrupt path.
>
> The EOP interrupt already identifies the queue that completed. Use the
> queue object directly to notify matching EVENTFD subscribers.
>
> Routing notifications through the queue object keeps delivery tied to
> the queue instance that generated the completion event, avoiding
> ambiguities from reused queue identifiers or doorbell indices.
>
> EVENTFD remains notification-only and carries no event payload.
>
> v2: (per Christian)
> - Move USERQ_EOP EVENTFD signaling into amdgpu_userq_process_fence_irq().
> - Reuse the existing doorbell-to-queue lookup instead of duplicating it
>   in the interrupt handler.
> - Keep fence processing and EVENTFD notification handling together in a
>   single helper.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index fbf783946f6d..ab3ef3a9f655 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -215,6 +215,7 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_dev=
ice *adev, u32 doorbell)
>  {
>         struct xarray *xa =3D &adev->userq_doorbell_xa;
>         struct amdgpu_usermode_queue *queue;
> +       struct amdgpu_eventfd_mgr *eventfd_mgr;
>         unsigned long flags;
>         int r;
>
> @@ -232,6 +233,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_de=
vice *adev, u32 doorbell)
>                 /* Restart the timer when there are still fences pending =
*/
>                 if (r =3D=3D 1)
>                         amdgpu_userq_start_hang_detect_work(queue);
> +
> +               eventfd_mgr =3D amdgpu_userq_eventfd_mgr(queue->userq_mgr=
);
> +               amdgpu_eventfd_signal(eventfd_mgr,
> +                                     DRM_AMDGPU_EVENT_TYPE_USERQ_EOP,
> +                                     queue);
>         }
>         xa_unlock_irqrestore(xa, flags);
>  }
> --
> 2.34.1
>
