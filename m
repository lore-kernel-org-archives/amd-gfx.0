Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94BDC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 21:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2137C10E67E;
	Mon, 13 Jul 2026 21:19:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="E30w/u0u";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02FC010E67E
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 21:19:26 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2ccae46de39so6860325ad.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 14:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783977565; cv=none;
 d=google.com; s=arc-20260327;
 b=FH7CYK2/FBqKoFzNhAsMQQgPiKT2l3JInFY09lx9pXRyxQniyXQOKQFa4boMzv37L3
 sRTwlBVWlzXnNt5/eHAuqD02D55xlTb5GxGHB8mhyyflByV86gyfBtwFcGq+Psx8yXR6
 6/oQHPEA2QbGe88d7TVIhKIAgXn6S8p4ROuESzMfuE0/29KEa9aOwsf+ipc3dT0PwWg4
 0s+9oY2vuvSNVWwQHopv2GviIAHxjvDrhTafDlGlcGZucKNhg7CAwqwOPkNcdiIZJmIj
 /oOMGAbQXT4xjbgbxANzs6Bth0vOHQdtIUvFR3XXTJGCFnGliJwdx8J+DOj6meWWy/pO
 g4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=33TaPqQmEjFsrm7H2HHTx5ta5j9OZEpDZHAN+VT+ZQc=;
 fh=yzBb+3Uy77011+KwgcQKRzDLInMnxr7dimZllKyVGMU=;
 b=AmGCBw4NoXIsS6GBfZLexvpGY1nMGMv+fsEnDxMgba6rCtQpD8Y483qZ9aAtLzA/ii
 AcPOXsHmN8AhdAee7XKWnUSo1vVI7PbsKtnFxsiIDkaZ9L4AfTxj/e9INH2f4pUa74Kw
 isROyRFG+LYngvfWSaTU62gLBohZx65VUwCU3UoawsxestfHCRAg/X9NVYGG67hKyFVr
 Qutpv6WZf2Vt5IPxMI+NrXSYUNx2R1+GF61fXnxEeL5VJFLDTDRB/FGfDHHZwALefKdV
 EmNsN4yPvc9/w7lEAl7JG9EzDx0b9uV+GYy9wRX02sQ6+2cpNlFZRVfA+PmF+MNs0pt8
 Pm4Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783977565; x=1784582365; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=33TaPqQmEjFsrm7H2HHTx5ta5j9OZEpDZHAN+VT+ZQc=;
 b=E30w/u0uD+Lpcf7NCFKU4v5UM/lrfTZnMq/uH0ChR6YBeNciJVOK/oSM8tfV+S2uyk
 1+jioeMFtEcZNrL/jd6yq010FmPLOye56DtJh4wbx74Bj6WeSbhiNzaHx0cnxSxDKFFs
 Zv623LwA6qiK9OMTQo4+h6G6I5th1mTlR7dXusY1hHkAHXh+ZjUNABFrV1xpM8YJAic8
 johsrTcAgUzbMSI7NuWSTqEltVJbHs/MlnEejAu9FyvsyxZ2J4msWVrDoiqdiqI2N59A
 axiq3c4JpQZt5dAlg7dBV3/fdBLI8yqZEzo8nTUIuYoMtoinJnOqqXkhbpZfFr2zmC2b
 yRfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783977565; x=1784582365;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=33TaPqQmEjFsrm7H2HHTx5ta5j9OZEpDZHAN+VT+ZQc=;
 b=IHhFY44GnlStN98AmSGL4Mf51eJ9SF5jOBW7660fyUE1Tp533N1k61j466CLcEiSFB
 1mrVtPQH4wY2TP01x5xgfUgaUe4zjduGZpgBppx3EYVdCJrb4qfHwuU0BOpikcdQwT9n
 f1y6foipB2WzsbzokqopviGUm6s1MsIwvCEXME96D7YW6th9ijgafk3UHv2DjvqILUJ8
 acPvJIdYofMnpyF2gJXpusDIf/1hTtn2uKK8yUHqaiUOoRwq7OFTUCycRkfxyOBKETlR
 956Heun4/k3sH4XX2s3JUn3QRrG8PNZK+R811keCgOd3U+8RerpSxMeZONIzg8q4JlK/
 1qbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqebxXC25JCXBygX1O7eQZXv+toIjBc2TBVvii62KDj3Y32N/nT3B4ZOzevNRJqte53QcyEU6um@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwpJzKPcyjWxfLKzfScQ8b0w1t+ZZ5Mz+AKDoE0ORhVcNVaj4yv
 Qd9KdB+nG0pq6hNrLy1TJPXHlsdRmDnFvLSm/YegAFOXvcHL2yY9+eDTsXR4jp9cRjw99lEPaH9
 hosAjdR+mPx/QqHsd7HtjYvvcqkU50Po=
X-Gm-Gg: AfdE7cmcA9A3HT3Md/LKdrDYOQz1Ph8U4zPBpELjX8/bCkTNmAXxQUGLyYSZTTHa5e+
 3Gitd6/bAJ9J5ehn+ehTMdCTpUldCtaEJo2R2QV8fAXH1TWA2j6bzZI4e/lQMMb1SdIVtrOKdTX
 XvXTHP9/Gwac14gaSd8dNTjSPegBJfwJ7MK4Ab8GHt9ZXaqgmgm3Lu4wG/6RQNZ/TRWvTlPTq2Y
 yZN+mA7VqDYH6I7zm9GK+3g/9uzd/7u8V21j/UdeRvXQnBxXViICIM7xUSzfP7CLvbhk3oZaM4e
 G6L9NSv5OYOQ4wNAdw/ZHua/YOkwj0mCBi+wxG4ibLZe8yvyDOkKPP+ic6U=
X-Received: by 2002:a17:90b:564c:b0:37f:eda5:516f with SMTP id
 98e67ed59e1d1-38dc760604fmr7510028a91.0.1783977565391; Mon, 13 Jul 2026
 14:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260713164321.3350036-1-srinivasan.shanmugam@amd.com>
 <20260713164321.3350036-7-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260713164321.3350036-7-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 17:19:13 -0400
X-Gm-Features: AVVi8CcggNroJJND5UlZkDg3bvHCnqUk0cYHHqaUY_2ZkTPayFovTC6uu0dgBh8
Message-ID: <CADnq5_PFOgExqt5BZkDkRGKZi+okxsnqxk-0GbNyZJXR3wFZuA@mail.gmail.com>
Subject: Re: [PATCH v8 6/6] drm/amdgpu: Record QUEUE_RESET WAIT_EVENT
 notifications
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

On Mon, Jul 13, 2026 at 12:54=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> The queue reset path already resolves the affected queue directly from
> the doorbell and funnels successful reset handling through
> amdgpu_userq_handle_hung_queue(). Reuse that common handling point to
> create the corresponding WAIT_EVENT record.
>
> Keeping the notification in the common helper ensures that queue state
> is updated before userspace is notified and that both EVENTFD and
> WAIT_EVENT observe the same reset. It also avoids duplicating the
> doorbell lookup or adding a queue scan in the MES reset path.
>
> No MES or GFX interrupt changes are needed.
>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Patches 5, 6 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 1abc05779192..8d081fda3e52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -271,8 +271,8 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_dev=
ice *adev, u32 doorbell)
>   * @adev: AMDGPU device
>   * @queue: affected user queue
>   *
> - * Mark the queue as hung, notify matching QUEUE_RESET EVENTFD
> - * subscribers, force-complete its fences, and send the DRM wedged event=
.
> + * Mark the queue as hung, notify userspace of the queue reset,
> + * force-complete its fences, and send the DRM wedged event.
>   *
>   * Return:
>   * true when the queue was handled, false for an invalid queue.
> @@ -282,6 +282,7 @@ amdgpu_userq_handle_hung_queue(struct amdgpu_device *=
adev,
>                                struct amdgpu_usermode_queue *queue)
>  {
>         struct amdgpu_eventfd_mgr *eventfd_mgr;
> +       struct amdgpu_wait_event_mgr *wait_event_mgr;
>
>         if (!queue)
>                 return false;
> @@ -293,6 +294,11 @@ amdgpu_userq_handle_hung_queue(struct amdgpu_device =
*adev,
>                               DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
>                               queue);
>
> +       wait_event_mgr =3D amdgpu_userq_wait_event_mgr(queue->userq_mgr);
> +       amdgpu_wait_event_add(wait_event_mgr,
> +                             DRM_AMDGPU_EVENT_TYPE_QUEUE_RESET,
> +                             queue);
> +
>         amdgpu_userq_fence_driver_force_completion(queue);
>
>         drm_dev_wedged_event(adev_to_drm(adev),
> --
> 2.34.1
>
