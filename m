Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00ECD6D232
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Dec 2025 15:49:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7237810EA1A;
	Thu, 18 Dec 2025 15:49:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R/EafRWl";
	dkim-atps=neutral
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D269110EA1A
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 15:49:26 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id
 46e09a7af769-7c6ce4f65f7so662204a34.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Dec 2025 07:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766072966; x=1766677766; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHivnwGNK6H2CvpZNspF1GDDJqkXBdxjiCYiNv/30iM=;
 b=R/EafRWlOxml8MbjC+goDAAR7URNMVbBFW9rndXdznzIxRdO1yMMBtVb2cMmttMCUH
 fDit4z0sHbR0e7YcEJ/huZPbNyZBb5RR200WBKM8EuZIbkBsHb+J09wrx25PfMnA1zEj
 vxP0A4LabDVnzthZsnCNjFxpYYW6T0Pv6ffdRb71zVxZQvzgTbi771FO9B8aj+FdFxli
 X3moO0a2wOdF/QNB2ArcjzWXtWtzD1aRV4ANgIXFApbRc8G27yQwxOnwuLIq8AWW5fFo
 L65Gdt1xhbNNbYioHEdHEW15f+v8IivmdqNUEOSjeBMZM1pgv2/N7rt9lK1pILbM610m
 e9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766072966; x=1766677766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JHivnwGNK6H2CvpZNspF1GDDJqkXBdxjiCYiNv/30iM=;
 b=JZRH7cQqf9lSeDtHT3jzAnnC86mhs8QENMQZg5UHGEZAqYk2//FBm1jS0G3BqJYz7C
 cqIiJ0p21XtqDFhBWrSp5yxfNFCaicph4L++UETp5ffzZVAhUz3lKbTUpRl4x1lFcPnm
 S1p5E2ISKJttS4RLOJVnB1/VdeF61DjygpakMZWiAUeWQuwd1vgJhCRxzmZnYyjWGZ6J
 hAQlnGshKh/6/aXKxETFI647pFykc90UkmB5DpDHeF9nDjmqDkGCnBYjO8h93jSBVU1p
 d4TLwmlJXhtwT317ynfXmZI3+4VgZvoM5NGXV6yDHp0qyY4IxSTV9ZORmHVMKcHi3W7V
 GsPg==
X-Gm-Message-State: AOJu0YwRrYg5Vq5Z0PDadUF8EzD34AwwEw7HGl+zM6MqMq/LgQDzLFvM
 QZQrI/jBgjd9q3hHBQW6et/MYmDO1tY5Bu08yXS5/JP17cie9dvNB6Zi
X-Gm-Gg: AY/fxX7HnS2SJqNpYILMDv5ScQTkKbvJeUl46MuLH1hvRosSocaXTG+B8JiytTFsind
 6fB078GsWVcejvx7T0DdCGi3QB/CSohegZxGLcCAtHrNsqipsH4nNgg/aA33NRryvcp9NOpx86a
 lEahcvehwb/owNmbYpS0Raoe9PSdidfTPk9MKeUVu0fnlTI0GHjm6GLtjz4J4M9pVpOgoxwz14N
 3J2f9j632J4xt/0u2+tf3/fJsEYghbw18J7GNA5H35So3rWaO5nBXFMmVI4yqQphGPbCZh0Wrwt
 chB8SicJ3Dj3xLT7UnDiM3IZQ4hRM8mIDAXejtxxjTn22KCQ1kDS11kmwoCfLSOiymhsr7qucT4
 Y543CbICl/yiNqjiZcH1GvCyHlh+i/0LJiajHrYt30kSu7fkiFIGoh+A11LPWXBw4mkEGfaU42R
 vuQ5zD7fDAlaX91HePsAmoC3DyP/E=
X-Google-Smtp-Source: AGHT+IGy5HpkssdZ240bEGDOU4HS95PTuGXr75gWVsBCDEY0xqufrmP7LU1CniTL6lq83yNk4vpweA==
X-Received: by 2002:a05:6830:43ab:b0:7c7:5d72:567b with SMTP id
 46e09a7af769-7cae835da74mr13029005a34.23.1766072965953; 
 Thu, 18 Dec 2025 07:49:25 -0800 (PST)
Received: from timur-max.localnet ([189.171.135.243])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cc59a7cd4asm1962646a34.8.2025.12.18.07.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 07:49:25 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 4/6] drm/amdgpu: avoid a warning in timedout job handler
Date: Thu, 18 Dec 2025 09:49:25 -0600
Message-ID: <2496432.Hq7AAxBmiT@timur-max>
In-Reply-To: <CADnq5_PABibVsM+d7UtLcRwDKo+O6thYTge__X3eCFd5u3H0nQ@mail.gmail.com>
References: <20251215160711.11832-1-alexander.deucher@amd.com>
 <6025413.IbC2pHGDlb@timur-max>
 <CADnq5_PABibVsM+d7UtLcRwDKo+O6thYTge__X3eCFd5u3H0nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2025. december 18., cs=C3=BCt=C3=B6rt=C3=B6k 9:41:41 k=C3=B6z=C3=A9ps=C5=
=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Alex=20
Deucher wrote:
> On Thu, Dec 18, 2025 at 12:21=E2=80=AFAM Timur Krist=C3=B3f <timur.kristo=
f@gmail.com>=20
wrote:
> > On 2025. december 15., h=C3=A9tf=C5=91 10:07:09 k=C3=B6z=C3=A9ps=C5=91 =
=C3=A1llamokbeli z=C3=B3naid=C5=91 Alex
> > Deucher>=20
> > wrote:
> > > Only set an error on the fence if the fence is not
> > > signalled.  We can end up with a warning if the
> > > per queue reset path signals the fence and sets an error
> > > as part of the reset, but fails to recover.
> >=20
> > Can you please elaborate why this is necessary?
> > I don't entirely see the point of this patch. Why don't want to set an
> > error on the fence when it was signalled by the per queue reset? I would
> > have thought that the next patch does that, and also fixes the warning
> > mentioned in the commit message here.
>=20
> If you call dma_fence_set_error() on a fence that has already signaled
> it triggers a warning.  What could happen is that the queue reset sets
> the error on the fence and then signals the fence as part of the reset
> sequence.  However if the queue reset ultimately fails, the fence is
> already signaled and then we try and set an error again here as we
> fall back to adapter reset, triggering the warning.
>=20
> Alex

I would have thought that the next patch in the series would take care of t=
his=20
problem by itself. Thanks for the explanation. The patch is:

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >=20
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c index
> > > 67fde99724bad..7f5d01164897f 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > @@ -147,7 +147,8 @@ static enum drm_gpu_sched_stat
> > > amdgpu_job_timedout(struct drm_sched_job *s_job) dev_err(adev->dev,
> > > "Ring
> > > %s reset failed\n", ring->sched.name); }
> > >=20
> > > -     dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> > > +     if (dma_fence_get_status(&s_job->s_fence->finished) =3D=3D 0)
> > > +             dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
> > >=20
> > >       amdgpu_vm_put_task_info(ti);




