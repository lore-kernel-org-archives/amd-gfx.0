Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13668CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Aug 2025 20:52:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DBA310E286;
	Wed, 20 Aug 2025 20:52:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PBymYwsB";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A08D410E286
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 20:52:32 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-76e2e8d14a5so49004b3a.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Aug 2025 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755723152; x=1756327952; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v57fqJd9Rf1SMhS0zFsbJX05dNgq+i2ytbR82G2xyTA=;
 b=PBymYwsB3zLweJqqs7IDcuAF+A+axmvCuQB2mZGbEOBeZXMsY5/mEGKBLjnTIukO8+
 Bx6a/V501D7PWpc1KBWEvj4THU0f8wr3sCyz+Qo+fyzIkB5yGg16eDUl6PPxexhlGTlV
 Vio8z2sTbGI97cxF6CBh4EJu7iM+HgDBlws8r2AO/cZx8A11BURHOw4mdzPxbK/QgTz3
 heISPcgaibo15jlD2YViRld/x039jqh/4eIXlR3PernuMrwmX2NzAwFIt4W8atIQO7O+
 uQCNk2JCmhmMUxWg5BLRUcqyhf3z1aYSURs/m6xZ/6AHOrXq2bz9Eq0pzNHKFmTiuDNg
 x2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755723152; x=1756327952;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v57fqJd9Rf1SMhS0zFsbJX05dNgq+i2ytbR82G2xyTA=;
 b=jMnjd0pdW3PPGcG3J+cGlgKhULYEH8FTQa3ixxNyq77CB4DAJJVml6qRzU5hyXrPy9
 MqJSBOlJMoJj/HS8EEKdh029LGzoIsksSgyQsBZ12EbeVb9/7MTpc5i1Ikn9+vcrDVxl
 JOcXmAwh/1CgsOtmhIZVzJ8Mjydlh0FeHGLR1rABUjN55+uZpraXZzPufLi0oRlvkBVe
 onapYGY54KzgL9Q0uIBqQUgkqCW9Ru3pIRqRk34p0ysP5s4/IuKHyaXqYwT1xrkGDu+d
 plKj7PxRZJXwce/dhwvI6hzRJx7WA3eJIUTC62MjyHZWXCGu2a+I0VuR0UYvFf7FIJDQ
 oTGg==
X-Gm-Message-State: AOJu0Yyq8lyGORHmrWiXBqlW2vpPCZjR+FU4fUyneDmJ/n835WPkLMxl
 YCH4T9zr9xj78Phe0NqHKFndub8rnXtjfmiKSJ1f5NMMLbuoS12ElIwOhjYXk8WNHEAp1hNOM70
 b3RGLF4UeTEwZYJLLt4w63RFDPvQpSU4=
X-Gm-Gg: ASbGncuk5Ni9NMsAixnFXfN94KhJ6IZjLi313MkbmxWUeYVjVLzVWQELSfL/X1bwlrN
 brxzLJ01kpgzENAS4Hogl4a9d1oYjvd8e9n3/YZA815zeAMtAhyQXpgYfNoERFy7mM8Uzuh9nHr
 lUKatP5gBfGu3JA7nugvxzLhnrz2GsDNQIDxdSyKGVUTdN8J+DZXKWl99ehFCiixvJzGNEJSXng
 DdA6eFo6874UUcTv2clFAZdXLmZ
X-Google-Smtp-Source: AGHT+IEMtBo4yhU+eZ0Ws7lC+f+vj8VvKQJVJnhgbWtZ1QQfnNyg2YmcT1Veyy/aThdTxsgI/AWGNgzDG9iJxRHaAoc=
X-Received: by 2002:a17:902:ea11:b0:240:8a87:a187 with SMTP id
 d9443c01a7336-245feac97e0mr1392095ad.0.1755723152024; Wed, 20 Aug 2025
 13:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250811095937.1978747-1-Jesse.Zhang@amd.com>
 <20250811095937.1978747-2-Jesse.Zhang@amd.com>
 <CADnq5_Mvb-5F13rB4=iFjc6n6qAxzQSn=W-OsgLTeCUcYk=tbw@mail.gmail.com>
In-Reply-To: <CADnq5_Mvb-5F13rB4=iFjc6n6qAxzQSn=W-OsgLTeCUcYk=tbw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 20 Aug 2025 16:52:20 -0400
X-Gm-Features: Ac12FXxwTqrNrXp0BSr1hpcpa_7zwEk_0z4klFHGt-aGDFpLslTmGlh4wrSsIEg
Message-ID: <CADnq5_OqJD9dwYCuoE=C41W9vGaFRmxTSoy7C464fTMPdV5Hcg@mail.gmail.com>
Subject: Re: [v8 02/11] drm/amdgpu: adjust MES API used for suspend and resume
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

On Tue, Aug 12, 2025 at 3:36=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
>
> On Mon, Aug 11, 2025 at 6:18=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com>=
 wrote:
> >
> > From: Alex Deucher <alexander.deucher@amd.com>
> >
> > Use the suspend and resume API rather than remove queue
> > and add queue API.  The former just preempts the queue
> > while the latter remove it from the scheduler completely.
> > There is no need to do that, we only need preemption
> > in this case.
> >
> > V2: replace queue_active with queue state
> > v3: set the suspend_fence_addr
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/d=
rm/amd/amdgpu/mes_userqueue.c
> > index d6f50b13e2ba..46b24035e14c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> > @@ -347,9 +347,60 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_=
mgr,
> >         amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
> >  }
> >
> > +static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
> > +                            struct amdgpu_usermode_queue *queue)
> > +{
> > +       struct amdgpu_device *adev =3D uq_mgr->adev;
> > +       struct mes_suspend_gang_input queue_input;
> > +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> > +       int r;
> > +
> > +       if (queue->state !=3D AMDGPU_USERQ_STATE_MAPPED)
> > +               return 0;
> > +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_PREEMPTED)
> > +               return 0;
> > +
> > +       memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input)=
);
> > +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_=
PROC_CTX_SZ;
> > +       queue_input.suspend_fence_addr =3D queue->fence_drv->gpu_addr;
>
> This will overwrite the user fence value with 0.  You need a separate
> allocation for this.  You might also need to wait for this value to
> verify if the suspend completed successfully.

This still needs to be handled.

Alex

>
> Alex
>
>
> > +
> > +       amdgpu_mes_lock(&adev->mes);
> > +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
> > +       amdgpu_mes_unlock(&adev->mes);
> > +       if (r)
> > +               dev_err(adev->dev, "Failed to suspend queue, err (%d)\n=
", r);
> > +       return r;
> > +}
> > +
> > +static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
> > +                           struct amdgpu_usermode_queue *queue)
> > +{
> > +       struct amdgpu_device *adev =3D uq_mgr->adev;
> > +       struct mes_resume_gang_input queue_input;
> > +       struct amdgpu_userq_obj *ctx =3D &queue->fw_obj;
> > +       int r;
> > +
> > +       if (queue->state =3D=3D AMDGPU_USERQ_STATE_HUNG)
> > +               return -EINVAL;
> > +       if (queue->state !=3D AMDGPU_USERQ_STATE_PREEMPTED)
> > +               return 0;
> > +
> > +       memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input))=
;
> > +       queue_input.gang_context_addr =3D ctx->gpu_addr + AMDGPU_USERQ_=
PROC_CTX_SZ;
> > +
> > +       amdgpu_mes_lock(&adev->mes);
> > +       r =3D adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
> > +       amdgpu_mes_unlock(&adev->mes);
> > +       if (r)
> > +               dev_err(adev->dev, "Failed to resume queue, err (%d)\n"=
, r);
> > +       return r;
> > + }
> > +
> >  const struct amdgpu_userq_funcs userq_mes_funcs =3D {
> >         .mqd_create =3D mes_userq_mqd_create,
> >         .mqd_destroy =3D mes_userq_mqd_destroy,
> >         .unmap =3D mes_userq_unmap,
> >         .map =3D mes_userq_map,
> > +       .preempt =3D mes_userq_preempt,
> > +       .restore =3D mes_userq_restore,
> >  };
> > --
> > 2.49.0
> >
