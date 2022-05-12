Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C93C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 21:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A7D410FA0C;
	Thu, 12 May 2022 21:32:47 +0000 (UTC)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 074D910FA0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 21:32:46 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id l16so7997390oil.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HrIsAw2m9oJ/PpZVXj38vbh37sLYwEmgvfjf7yKVny8=;
 b=JHdHSJcGybOOGatfwhUYmEn45Pgkj0joMfURrmqimZTRlpgdBxbeA61+7qKOmTQ3NL
 8qDzR07B3LitcoYLN6cJDudQoxjjUHBPjLZRcEE7VzLNfx5Z1hTysw1w/KcEsMJYU6wL
 iunSW15IluZQK4otgwW6aRIhLX8ut5pPq3+M2d9Wu3G2leSDx6tNu/i4vpzuBko3ywRa
 i9d9cmJj9LOHJvysIXNIH4YNmR1v8d7o8hVCQ4T+7bHWNLusyhH4E5dm6OBofWUL68jc
 ckxq4lr1Gb1YhaqDCAdEkHHwZ4zUvjd3NizzzEAIPFcUJFOaMnw0+zv3xh+v8HJ4Bz5T
 EdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HrIsAw2m9oJ/PpZVXj38vbh37sLYwEmgvfjf7yKVny8=;
 b=KyUzwPr5wtMI2jwynPPqQhnDsBy7xEFRyJrbHqKOSpySxvfo6wXvyba24LRf/Qo28Z
 sBU8nyrHhDDDZyjDNemXYM6SdM9cKPg3+JOWqIooWiyjHiqnP+5RerFghEOQ6LPbwWK+
 QUgFP1OyV7ueoIbXYp9BE2lRhJAOso9Myjx1jN+fngZ+bG8Bu5T5qDX9XVYP0DIqfSnr
 upCJa34TYOLfUWHLCtYQdLMd5UflAlSPyRHn9yhA2hLaP83MCqQSQfHzSedd0E7EsAEs
 PAEzUqM1D7s1b6a1zIo1W1000x9qJK9aZjwd4av1UtgeplJXh222DhE8IVld8OerLLov
 CR/A==
X-Gm-Message-State: AOAM531xeJWJAIJvE+FbjgABMStTM3JYTHvpjSQrWJys918HbMJZC6t2
 g0KCZFv3leIXHYcr6xgf0KCQ27cHokJ14csf6I8=
X-Google-Smtp-Source: ABdhPJxqXkH+UbZ3VDVmh5TvWK+gJy5aZ1XmAL27c8/Jm5pm3eYOKLLTfjkwNd2KyMx90Qhg4Lq3pN2EVzGby72b5h8=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr950865oiw.253.1652391165253; Thu, 12
 May 2022 14:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220512191632.3975470-1-Graham.Sider@amd.com>
In-Reply-To: <20220512191632.3975470-1-Graham.Sider@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 May 2022 17:32:34 -0400
Message-ID: <CADnq5_P+-OUcq_T=KsmKVRVbS01Lnx5vrp7aOgRm+H_RtPicuA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Fix static checker warning on MES queue type
To: Graham Sider <Graham.Sider@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 12, 2022 at 3:17 PM Graham Sider <Graham.Sider@amd.com> wrote:
>
> convert_to_mes_queue_type return can be negative, but
> queue_input.queue_type is uint32_t. Put return in integer var and cast
> to unsigned after negative check.
>
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>

Add a reported-by for Dan's email?

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index e9c9a3a67ab0..e1797657b04c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -176,7 +176,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>         struct amdgpu_device *adev = (struct amdgpu_device *)dqm->dev->adev;
>         struct kfd_process_device *pdd = qpd_to_pdd(qpd);
>         struct mes_add_queue_input queue_input;
> -       int r;
> +       int r, queue_type;
>
>         if (dqm->is_hws_hang)
>                 return -EIO;
> @@ -201,12 +201,13 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>         queue_input.tba_addr = qpd->tba_addr;
>         queue_input.tma_addr = qpd->tma_addr;
>
> -       queue_input.queue_type = convert_to_mes_queue_type(q->properties.type);
> -       if (queue_input.queue_type < 0) {
> +       queue_type = convert_to_mes_queue_type(q->properties.type);
> +       if (queue_type < 0) {
>                 pr_err("Queue type not supported with MES, queue:%d\n",
>                                 q->properties.type);
>                 return -EINVAL;
>         }
> +       queue_input.queue_type = (uint32_t)queue_type;
>
>         if (q->gws) {
>                 queue_input.gws_base = 0;
> --
> 2.25.1
>
