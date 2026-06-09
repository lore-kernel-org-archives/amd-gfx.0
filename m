Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7039CD98DD
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 08:42:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1CA10E812;
	Wed, 10 Jun 2026 08:42:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vq4v6QBE";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41C6210E315
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 15:30:26 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3074adb8fcaso9886906eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2026 08:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781019025; cv=none;
 d=google.com; s=arc-20240605;
 b=HaBuT3k8Glm+1/MBq0rnjsQBE7rCUZrMZDJgVBL6xMAkObKg9DH/3sukBJ+5aEz5a9
 nh8k8SrEzudtpEM7ciQpJlvdYWoG4jLyAz66UBQMdtJ+2KMDxGBXgC2i9+ZuWa4vQ2f4
 rh7JXYgapuhVYoCDgeggw1ja+UC+Kx1ft+320nMa1sEG8N3HHOt7d5hP4Pan7VbtbomA
 1OAfFJw+xo0SxVbzRWcEhWmP01V0c6TNysBGnDXGOPyE7VBZ/qG8/+pEIH3gGcaamtYz
 IznUWxOBmUnKiuCYe4S2Yyd5ZgwEFSzjhnAdIel1Kouq/fj+Qk8j07MkOQtBAUnS8vLx
 mBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vJU+o++m0aasR83bRIxN574z9aspy1ro3TGM/ArKaY4=;
 fh=GC3O+tR+Guc3Z7Kqv65aKoK9ZqMprSiuaQe4yMKJTUg=;
 b=i/3yiG0tT2UEygm/xd4Zpk6BVKTrvBMDQVW/Th2wn8RMWTqsLN2Xl2qg7kjRSuCVfd
 Uoqm8yaOLo6Oipitx7qKyvHRYS2om3mSfcFXMEgNB1MOOs9cXbFf14r29SnrZLWrLZZY
 wdwwQNWZXmwe0jdvclb71J0yeWW3T/BkeOwy0uOX2ugJOaWPIzpjpB67F0x4LfHJVBoo
 r2EDTGgPo1BRO2FWLDzwRXtujjaV+IlkpdayZGYXByFfYaO/9L59vbYuFur1feQkBxXK
 KFd3iG6dD66fFqwQUeryeduBehyKJjjLx6AeIoSU94ZgqR657PEs5D10bKjyHaX7+YpL
 QMMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781019025; x=1781623825; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vJU+o++m0aasR83bRIxN574z9aspy1ro3TGM/ArKaY4=;
 b=Vq4v6QBEBboFQPVTXbYNm6DI7GbHESlpjC1Oxa95ZCIysVCuyMqxdEH/fMF0uZELCZ
 hsCwX0fa15ahIOk9MszVFklQf4iK/iUIWWwyqxPQnm8BhhbZUQBI5DKWUAhvY0ddV6Q0
 rFqfajeOmYbfIoY3EAPdgK+HP0HYveuGp/0YfLFxLU3Wvet2EccCiw59HS1tnEvYSey3
 nJDYSvYH22wecN9pgMpsYT9rtJ15YeZhmUwAIa7mHERSmJnhDUo/bbMstTZBIypUumt3
 1OQoKZzlKaj02MDkJ4xzstbS1CMoXxZzuowIJC0rY+nP5jbQhAS6se4t9av3ycvbA7eA
 Omuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781019025; x=1781623825;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vJU+o++m0aasR83bRIxN574z9aspy1ro3TGM/ArKaY4=;
 b=Goh/yinP+sDOJvus1W1tC/CA8S8cYBU/tO0pZL3QLkHPbSutqayqd2BG/0U2F37A/8
 yky7AL8fp4XM+WCJSNqixWhZA94No9Fg/A5wAppw5qCAYe8wIYxl3Mp0zkmYVQOa8LFn
 t8sni4h54g7XpSonrqoTtWDecd8EatugqGbrJU4VX2E2enLK5FPcOMDPvDJEvNLfbiqq
 D72ahcnqtuKIv3rR7A2XcuG3yZWnsOgccZh5nJ5NRgn4HvnLcYKxwQkcwi11V+yp5Qvu
 Vy0HF3tSFLT0Wvbfm7k/DxVjsqAdQjGqOhiIjDni4m9K5z0wxGVsE8M04xKcdcmUmfUn
 ZLrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MGFmGcXfc45L05LRgTNQfIVm0JUJf7QrihY5Kt9TRhFckfoSzqvMzrFJ3QXnl52YgINysvsUV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx4TDeRSlILNrQhD0yUoslcmZgCj/jP+T6CIjbCQLcSTzUBppdZ
 Hu1+gsKvLbwNS/bIYTl8N806ueYlX4aFqQdEoRIPF2tgx5MNm2NMwEsRmQaWGHEfO8/PQmvKVky
 cFH/gnGH96KsDhk00F/6WvNBC6Il1N8g=
X-Gm-Gg: Acq92OEmWlHGwI7ml3KmtcwycwLp4scinrCmcBRikAIxHC4Ttk0OazKx/HoqAo4+Qwa
 um2ERiUs3p9fAyOjXZ5HcNzhSY5RPYBqw9ZhkJZO9nUPiGklbbNFwQKVjBUgoVpny8iAZxf9iVX
 W0dRh23Lr6HCSKcIyTPyB4PDGrtnXsAAhirXRRqnBQ5wP6/bQOTXd72PK9JK2S9CSB6hkB69hQA
 NT69RJJ6rLp722EtIT1q/jDmqMUcYJSmESsO8pZBDekGvrOVA5jpyXQfHJY+P8mX/Z4af8OhbVT
 wDt8ctn4XMmMfUmkoo0=
X-Received: by 2002:a05:7300:730a:b0:307:2e1c:17f1 with SMTP id
 5a478bee46e88-3077b1f6abcmr12851372eec.25.1781019025332; Tue, 09 Jun 2026
 08:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260604063943.1412955-1-lgs201920130244@gmail.com>
 <42b82b4f-43ce-4943-bc64-d7386998473c@amd.com>
In-Reply-To: <42b82b4f-43ce-4943-bc64-d7386998473c@amd.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Tue, 9 Jun 2026 23:30:11 +0800
X-Gm-Features: AVVi8CcZdB41eilVcYzozusawa1g5tNYIXVlt10eHy4mOCLoqWYvJODpLiDSN_s
Message-ID: <CANUHTR9YUmkjrDSGL0uSfHHGxhGtOgfPuF2OudbjTyrCAvd1sA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: clean up VA state on create failure
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Prike Liang <Prike.Liang@amd.com>, 
 Sunil Khatri <sunil.khatri@amd.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 10 Jun 2026 08:41:55 +0000
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

Hi Christian,

Thanks for pointing this out.

On Fri, 5 Jun 2026 at 17:32, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> On 6/4/26 08:39, Guangshuo Li wrote:
> > amdgpu_userq_input_va_validate() is not a side-effect-free validator.
> > When it succeeds, it allocates a VA cursor, links it on
> > queue->userq_va_list and marks the corresponding bo_va as userq mapped.
>
> That was already removed, you are looking at outdated code.
>
> Regards,
> Christian.
>
> >
> > The user queue create path validates queue_va, rptr_va and wptr_va with=
 a
> > short-circuit OR expression. If an earlier validation succeeds and a
> > later validation fails, the error path frees the queue directly. The VA
> > cursor added by the successful validation is leaked and
> > bo_va->userq_va_mapped remains set even though no user queue was create=
d.
> >
> > The same stale VA tracking state can also survive later create failures
> > after all VA validations have succeeded, because those paths also free
> > the queue without unwinding queue->userq_va_list.
> >
> > Route the create error paths through common unwind labels and call
> > amdgpu_userq_buffer_vas_list_cleanup() before freeing the queue. This
> > releases any VA cursors added during validation and clears the stale
> > userq VA mapping state.
> >
> > Fixes: 9e46b8bb0539 ("drm/amdgpu: validate userq buffer virtual address=
 and size")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 32 +++++++++++------------
> >  1 file changed, 15 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.c
> > index 0a1b93259887..dba0f786ae4a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -826,17 +826,15 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >             amdgpu_userq_input_va_validate(adev, queue, args->in.rptr_v=
a, AMDGPU_GPU_PAGE_SIZE) ||
> >             amdgpu_userq_input_va_validate(adev, queue, args->in.wptr_v=
a, AMDGPU_GPU_PAGE_SIZE)) {
> >                 r =3D -EINVAL;
> > -               kfree(queue);
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         /* Convert relative doorbell offset into absolute doorbell inde=
x */
> >         index =3D amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, fil=
p);
> >         if (index =3D=3D (uint64_t)-EINVAL) {
> >                 drm_file_err(uq_mgr->file, "Failed to get doorbell for =
queue\n");
> > -               kfree(queue);
> >                 r =3D -EINVAL;
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         queue->doorbell_index =3D index;
> > @@ -844,15 +842,14 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >         r =3D amdgpu_userq_fence_driver_alloc(adev, queue);
> >         if (r) {
> >                 drm_file_err(uq_mgr->file, "Failed to alloc fence drive=
r\n");
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         r =3D uq_funcs->mqd_create(queue, &args->in);
> >         if (r) {
> >                 drm_file_err(uq_mgr->file, "Failed to create Queue\n");
> >                 amdgpu_userq_fence_driver_free(queue);
> > -               kfree(queue);
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         /* drop this refcount during queue destroy */
> > @@ -862,21 +859,17 @@ amdgpu_userq_create(struct drm_file *filp, union =
drm_amdgpu_userq *args)
> >         down_read(&adev->reset_domain->sem);
> >         r =3D xa_err(xa_store_irq(&adev->userq_doorbell_xa, index, queu=
e, GFP_KERNEL));
> >         if (r) {
> > -               kfree(queue);
> >                 up_read(&adev->reset_domain->sem);
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >
> >         r =3D xa_alloc(&uq_mgr->userq_xa, &qid, queue,
> >                      XA_LIMIT(1, AMDGPU_MAX_USERQ_COUNT), GFP_KERNEL);
> >         if (r) {
> >                 drm_file_err(uq_mgr->file, "Failed to allocate a queue =
id\n");
> > -               amdgpu_userq_fence_driver_free(queue);
> > -               uq_funcs->mqd_destroy(queue);
> > -               kfree(queue);
> >                 r =3D -ENOMEM;
> >                 up_read(&adev->reset_domain->sem);
> > -               goto unlock;
> > +               goto free_queue;
> >         }
> >         up_read(&adev->reset_domain->sem);
> >
> > @@ -892,10 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union d=
rm_amdgpu_userq *args)
> >                 if (r) {
> >                         drm_file_err(uq_mgr->file, "Failed to map Queue=
\n");
> >                         xa_erase(&uq_mgr->userq_xa, qid);
> > -                       amdgpu_userq_fence_driver_free(queue);
> > -                       uq_funcs->mqd_destroy(queue);
> > -                       kfree(queue);
> > -                       goto unlock;
> > +                       goto free_queue;
> >                 }
> >         }
> >
> > @@ -915,7 +905,15 @@ amdgpu_userq_create(struct drm_file *filp, union d=
rm_amdgpu_userq *args)
> >
> >         args->out.queue_id =3D qid;
> >         atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
> > +       goto unlock;
> >
> > +free_mqd:
> > +       uq_funcs->mqd_destroy(queue);
> > +free_fence_driver:
> > +       amdgpu_userq_fence_driver_free(queue);
> > +free_queue:
> > +       amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
> > +       kfree(queue);
> >  unlock:
> >         mutex_unlock(&uq_mgr->userq_mutex);
> >
> > --
> > 2.43.0
> >
>

I was looking at an outdated codebase. Sorry for the noise.

Regards,
Guangshuo
