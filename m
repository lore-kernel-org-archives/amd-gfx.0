Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0865CD11DD
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Mar 2024 02:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B5CD10F6BA;
	Wed, 27 Mar 2024 02:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7RxXA70";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C9E10F6BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 02:14:42 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-29ddfd859eeso5172242a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 19:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711505682; x=1712110482; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M5ZGl4boqvaYeVLG/N+JVNsNVW69PqL5nzPfL0wOOLQ=;
 b=S7RxXA70RtFg6V5hYEov1S72x8tdTdngZLRrSxAZ+MiuklkCCMKnHE0fr4H5BsbAbn
 OJEQ1C8vVYKMABkj0LGHPcNpDmhRMaD54411oqcnYRYmsGxWKQpFPzQGU/jYRuCpcEkZ
 VGvYs/xmtHZh1IeBrZn3f47/JC2oOzmvnceo6QstRIztAOfSx4PRiCh+3AZhpDP2Jreu
 PA/jAWDEqldTCdw/drUVQkRMcehaFeOZB7UAcQjtsD3fR1n3v6dBUsvJHwA+46r7wE9A
 ki8u9ONiEG+T1N3BmqqiQ/UWBI7xo4TJT1PNJBebvUa4D8Xw3AuDoPkYdjCySkR2zZyO
 7fQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711505682; x=1712110482;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M5ZGl4boqvaYeVLG/N+JVNsNVW69PqL5nzPfL0wOOLQ=;
 b=XaAdbUuSS+Uk/L9w3KUz61VjiPaVWJc4j1OEWjisErNFnx2taJ6ejzZN5LPbM8XB1i
 Rgz1QPAXFXCu6Dv68UYPgiPgtX3uDNmOrJFtCx0p+9TLn/9N9D7G3tjea9+IEm2rdDdk
 XoOu19PGnrGxSRJa3FNFJp+T+yNhd9whHpDLsrEL9Z9osF6J4XNVkaBAF3VdV3pe3IQF
 3kuvZDcLKGte3/wyxhnzY3vIwp34DFxjeH3jhxHgT/c1lN9hR2sFW3D87xoa9Z2Oqwom
 60AbhOuXAxevAAygOVtnWPP5uuLLgPiF53Lu3mCDSRZspiCoAJZir04tRxXd8L4p2g1z
 5OWg==
X-Gm-Message-State: AOJu0YxwEAA1ygdceWC4dg4utMt5A2ETkFMwBZrfJ7pF0nIZJ3mgx+jF
 FzZiMMHbmZEigximty32ECfkNTbYwqzqB+wX1UPMo+vqLbtRoeD49rmpm+2E4lmjAA1LQIroi8D
 mO9CC8zQnKvSXwDlWlaJUlRgAuoQ=
X-Google-Smtp-Source: AGHT+IGdJcZf9ypSkyxYKPOS+A8NBFnfAvObN9B327ToC2hGnzS2vaC5iCMaKgzhBYYZjM+JIe3SSe3LjrxaHZ4Z3rI=
X-Received: by 2002:a17:90a:4944:b0:29b:b70d:463a with SMTP id
 c62-20020a17090a494400b0029bb70d463amr1543773pjh.12.1711505682031; Tue, 26
 Mar 2024 19:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240326200206.100727-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20240326200206.100727-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Mar 2024 22:14:29 -0400
Message-ID: <CADnq5_OOjF9RWK3Cjc4nycNcswZ_LSP7qNwqJZ8EfLXVn+QwtQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Reset GPU on queue preemption failure
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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

On Tue, Mar 26, 2024 at 4:12=E2=80=AFPM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Currently, with F32 HWS GPU reset is only when unmap queue fails.
>
> However, if compute queue doesn't repond to preemption request in time
> unmap will return without any error. In this case, only preemption error
> is logged and Reset is not triggered. Call GPU reset in this case also.
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 151fabf84040..c08b6ee25289 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2000,6 +2000,7 @@ static int unmap_queues_cpsch(struct device_queue_m=
anager *dqm,
>         if (mqd_mgr->check_preemption_failed(mqd_mgr, dqm->packet_mgr.pri=
v_queue->queue->mqd)) {
>                 while (halt_if_hws_hang)
>                         schedule();
> +               kfd_hws_hang(dqm);
>                 return -ETIME;
>         }
>
> --
> 2.34.1
>
