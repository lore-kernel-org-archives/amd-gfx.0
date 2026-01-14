Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C88D3900B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Jan 2026 18:51:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673E710E266;
	Wed, 14 Jan 2026 18:51:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S6sabobq";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC7110E266
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 18:51:20 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1233608c7e9so956c88.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Jan 2026 10:51:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768416680; cv=none;
 d=google.com; s=arc-20240605;
 b=VJ9/Qc9UL3amwBCizJwNUufXJksN+6HHuYUdijYPD0iMNT6yVWrx0O55+nnU9Y180q
 ksGGCpdSLff59ee+y21cGoi9/lo2tMrJ8xE6qEK5BNz2QSm3lqlP88fGsVkwsIXyQyU8
 7cQm3iB4UHVYlXzfqOIxj4z4rmiCmI/PvLvd3RYQpG02vwSNVs1+HQRXMXrVydxka51q
 RD9P0/M5jtTH19kMZDC0+1n9mGgLpB8OMkwDR7ysjGfXO1/WIchFJQhdpXYG/8epGwdM
 BQ5Mymduw+mzemYJZjQpCwlVIN2lGI/O+/ik91OHPVf9DwbxjnOdeB1vOb9Q7oA8LRhw
 8GYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gHrC5RuwshvWuIHXPXR+4XpJrBNiR+UR2u085bpYo5I=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=WoVTEViehe2DweSoYYNW71ZVC9zMfs8gSVta0rJiBr9cqo42wjpXcCkxKMCXVaMvSb
 VehhsXYy6qe4tpOGQp1kOazsyAx6aVzkLFi/MsDxpxhDN5M9Xk5veVKizpipWUk6WsXf
 KIrECovyeREi2kCFbTl1O7MhkNqntKhuImWuucl57c6ZwqyjjFQNL/zZLeZ06FCQNXFO
 bGlzK0vN7TKu2c10sBk0aRhDSxAyp3mecQ0gjVJTmNsQwgkT4k6r/xDZD9yMW9L0rE6A
 L7si1sVGm+mscGNhitb0cYF3L/mpejt1fFE86hwiiXFQnVI3Pd/xFBxrlGH4CsVddT46
 BW9A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768416680; x=1769021480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gHrC5RuwshvWuIHXPXR+4XpJrBNiR+UR2u085bpYo5I=;
 b=S6sabobqZeqsHLHz8DpCAqQQT0ZxUQ5JFUpzmNdhVjA9lP3Xwd+CGwTen0iH3Grv2E
 PzX7qp0QwvMqSwqgNGfg1ckgN716kvCZcFGIB8mA1j7aWoROsp3YqsMik1ksKEzNprev
 gYvo+itTDo1m69BhP7OdIbqC4QICRBId9bIJcI5TZGGVM04nPesn73KeCYvFlusCVPos
 8/o6OIA22op5OExQ9ZRxZI1ASm+aT33ZFjRw+AiN6M+Tw4UqIkMcbvoHiaOyAqgYCURW
 yYCftN+PEQTYRHb3ezJ30dUX+x1FDkGTBxSY8sORj6jyF4GbExztwvpEDBkjnprmJZJT
 nvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768416680; x=1769021480;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gHrC5RuwshvWuIHXPXR+4XpJrBNiR+UR2u085bpYo5I=;
 b=WCsOfI+Lcbr5R07IGOy9UcSKC3s/sSJfQHv7TNXppc9iWn+aq9iuDTwE4MsrmnK2Fb
 MVuebOqgXgWwh+kcWMw00k4qVsoQhIMXGjPWcjEJxcyM5UBcx3rWp6uZZFHs1Ezz42r5
 ZYfC6C4eiWE7sd5pp8tUX84ZV3lsoQfZ9feWc1EeXHniitKiQU9VXXQsU3A6f/3DY+AB
 ntwu00j8D8Wr/7tUkujcpWnERhBrcX+ovkxd+nJqoZ3DrokdkUh8OuIoNsSI1Iyd5reA
 C3eoNldZN/DHekGikDNrWnxTMxj4BTGK3KFn3XLOYZ9GdJOuZcHD3uTD0rO2MOsTKkio
 3TQA==
X-Gm-Message-State: AOJu0Yz29ofLG8ddmFJOddAXPzxHImmn1s7RaByKkyxau82p1sV9sKk6
 2WJzGLcIBgvCw+MzW8BBnLPtIR2J/jpGNhyKq3ebUnjnU50dzGl0gr/DgeckcknqXJ2ukGvRFJW
 vmcqWvlq7DrF/2RCs+bNK4ev/ts50bz5sKQ==
X-Gm-Gg: AY/fxX5A9lxE2nOew5Hee8N8nNEuFqWOMLTywodQAA36K52I4dPYEzs7yzIWNQH8tND
 s5UgKqkyMRv3+VtZqFsMzR9qkIOD0/wjLbucnUBy7rDxCYEahCUgRVFJpjRnZ7jcSofx5vE5uHS
 wqlKJdGj6F88ncQ4GJCVEsQ8J/nktlsmAgEYqkIQraKuy4OeMlYtPhtoyMtpNQwmjocGf8p3nXx
 LHVstG42X14r2w2KybxQUW5PtM54Qm7DL+sOL6R0MzMXaQo7APkdOqIUMcE93dzdgl/snDU
X-Received: by 2002:a05:7023:907:b0:122:33e:6ec1 with SMTP id
 a92af1059eb24-1233698fff7mr1987147c88.0.1768416679619; Wed, 14 Jan 2026
 10:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20260113082241.291255-1-Jesse.Zhang@amd.com>
In-Reply-To: <20260113082241.291255-1-Jesse.Zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 14 Jan 2026 13:51:08 -0500
X-Gm-Features: AZwV_Qj0rGm4GGUdhzDSWfUG_KALXRKufDZfnp7GlpbvoC0ywNOPcK0b1-T8uRc
Message-ID: <CADnq5_PdSLrZA0bLs4GT5iFo-btBoYnM423nwEtHg29vyWZBWA@mail.gmail.com>
Subject: Re: [PATCH v4] drm/amd/amdgpu: Add independent hang detect work for
 user queue fence
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

On Tue, Jan 13, 2026 at 3:42=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> w=
rote:
>
> In error scenarios (e.g., malformed commands), user queue fences may neve=
r
> be signaled, causing processes to wait indefinitely. To address this whil=
e
> preserving the requirement of infinite fence waits, implement an independ=
ent
> timeout detection mechanism:
>
> 1. Initialize a hang detect work when creating a user queue (one-time set=
up)
> 2. Start the work with queue-type-specific timeout (gfx/compute/sdma) whe=
n
>        the last fence is created via amdgpu_userq_signal_ioctl (per-fence=
 timing)
> 3. Trigger queue reset logic if the timer expires before the fence is sig=
naled
>
> v2: make timeout per queue type (adev->gfx_timeout vs adev->compute_timeo=
ut vs adev->sdma_timeout) to be consistent with kernel queues. (Alex)
> v3: The timeout detection must be independent from the fence, e.g. you do=
n't wait for a timeout on the fence
>         but rather have the timeout start as soon as the fence is initial=
ized. (Christian)
> v4: replace the timer with the `hang_detect_work` delayed work.
>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 70 ++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  3 +
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   |  1 +
>  3 files changed, 73 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 98110f543307..664a15278c1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -148,6 +148,69 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_u=
serq_mgr *uq_mgr)
>         return r;
>  }
>
> +static void amdgpu_userq_hang_detect_work(struct work_struct *work)
> +{
> +       struct amdgpu_usermode_queue *queue =3D container_of(work,
> +                                                         struct amdgpu_u=
sermode_queue,
> +                                                         hang_detect_wor=
k.work);
> +       struct dma_fence *fence;
> +       struct amdgpu_userq_mgr *uq_mgr;
> +
> +       if (!queue || !queue->userq_mgr)
> +               return;
> +
> +       uq_mgr =3D queue->userq_mgr;
> +       fence =3D READ_ONCE(queue->hang_detect_fence);
> +       /* Fence already signaled =E2=80=93 no action needed */
> +       if (!fence || dma_fence_is_signaled(fence))
> +               return;
> +
> +       mutex_lock(&uq_mgr->userq_mutex);
> +       amdgpu_userq_detect_and_reset_queues(uq_mgr);
> +       mutex_unlock(&uq_mgr->userq_mutex);
> +}
> +
> +/*
> + * Start hang detection for a user queue fence. A delayed work will be s=
cheduled
> + * to check if the fence is still pending after the timeout period.
> +*/
> +void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *q=
ueue)
> +{
> +       struct amdgpu_device *adev;
> +       unsigned long timeout_ms;
> +
> +       if (!queue || !queue->userq_mgr || !queue->userq_mgr->adev)
> +               return;
> +
> +       adev =3D queue->userq_mgr->adev;
> +       /* Determine timeout based on queue type */
> +       switch (queue->queue_type) {
> +       case AMDGPU_RING_TYPE_GFX:
> +               timeout_ms =3D adev->gfx_timeout;
> +               break;
> +       case AMDGPU_RING_TYPE_COMPUTE:
> +               timeout_ms =3D adev->compute_timeout;
> +               break;
> +       case AMDGPU_RING_TYPE_SDMA:
> +               timeout_ms =3D adev->sdma_timeout;
> +               break;
> +       default:
> +               timeout_ms =3D adev->gfx_timeout;
> +               break;
> +       }
> +
> +       /* Store the fence to monitor and schedule hang detection */
> +       WRITE_ONCE(queue->hang_detect_fence, queue->last_fence);
> +       schedule_delayed_work(&queue->hang_detect_work,
> +                    msecs_to_jiffies(timeout_ms));
> +}
> +
> +static void amdgpu_userq_init_hang_detect_work(struct amdgpu_usermode_qu=
eue *queue)
> +{
> +       INIT_DELAYED_WORK(&queue->hang_detect_work, amdgpu_userq_hang_det=
ect_work);
> +       queue->hang_detect_fence =3D NULL;
> +}
> +
>  static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue =
*queue,
>                                            struct amdgpu_bo_va_mapping *v=
a_map, u64 addr)
>  {
> @@ -572,7 +635,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue=
_id)
>
>         cancel_delayed_work_sync(&uq_mgr->resume_work);
>         mutex_lock(&uq_mgr->userq_mutex);
> -
>         queue =3D amdgpu_userq_find(uq_mgr, queue_id);
>         if (!queue) {
>                 drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Invalid queue =
id to destroy\n");
> @@ -580,6 +642,11 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>                 return -EINVAL;
>         }
>         amdgpu_userq_wait_for_last_fence(queue);
> +       /* Cancel any pending hang detection work and cleanup */
> +       if (queue->hang_detect_fence) {
> +               cancel_delayed_work_sync(&queue->hang_detect_work);
> +               queue->hang_detect_fence =3D NULL;
> +       }
>         r =3D amdgpu_bo_reserve(queue->db_obj.obj, true);
>         if (!r) {
>                 amdgpu_bo_unpin(queue->db_obj.obj);
> @@ -818,6 +885,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         queue->debugfs_queue =3D debugfs_create_dir(queue_name, filp->deb=
ugfs_client);
>         debugfs_create_file("mqd_info", 0444, queue->debugfs_queue, queue=
, &amdgpu_mqd_info_fops);
>  #endif
> +       amdgpu_userq_init_hang_detect_work(queue);
>         kfree(queue_name);
>
>         args->out.queue_id =3D qid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.h
> index 1eaa94f8a291..06a06272b41a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -72,6 +72,8 @@ struct amdgpu_usermode_queue {
>         u32                     xcp_id;
>         int                     priority;
>         struct dentry           *debugfs_queue;
> +       struct delayed_work hang_detect_work;
> +       struct dma_fence *hang_detect_fence;
>
>         struct list_head        userq_va_list;
>  };
> @@ -146,6 +148,7 @@ int amdgpu_userq_start_sched_for_enforce_isolation(st=
ruct amdgpu_device *adev,
>  void amdgpu_userq_reset_work(struct work_struct *work);
>  void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
>  int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
> +void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *q=
ueue);
>
>  int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
>                                    struct amdgpu_usermode_queue *queue,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 25f178536469..374fbd0e859a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -569,6 +569,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev,=
 void *data,
>
>         dma_fence_put(queue->last_fence);
>         queue->last_fence =3D dma_fence_get(fence);
> +       amdgpu_userq_start_hang_detect_work(queue);
>         mutex_unlock(&userq_mgr->userq_mutex);
>
>         drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT,
> --
> 2.49.0
>
