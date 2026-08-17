Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86DDC5DF66
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Aug 2026 14:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D01C89444;
	Mon, 17 Aug 2026 14:28:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PCvT0rCm";
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3033989444
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 14:28:35 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-73e516d6ddcso91766137.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Aug 2026 07:28:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786976914; cv=none;
 d=google.com; s=arc-20260327;
 b=Dj9enL+ovkSCSFj9wH+CeG5BG3OJMwV1Ooe8fybb+ZbPeNmEQvaAPD8ueXHhtRVVun
 FDVEy0wQHnTnnCbwIe4sXU9BYQDzsDe/joo4OdJhKAKtHHQjD9izCLSjAtZMHtjpwZOG
 yK4AxkVapRZOZTIu40Y76l4B+LW2uO2ge+jXeeADE2esE4z0RJFmqN+7NFeQSEBcVkSp
 eb/yUybvNV9WGjjWR+/53iDZPjPhQbac+m7Gt0kPnqIN8zJCdIT3oDyuVIj7m1fOrfc+
 Jd/lKt3n+yuE71WObdWXtinPrRB+R8wSbLWJ173tlmxk8ZRpwcQ3SwI1fFbvNzSpmP16
 3f9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LsmwwUMpf8aSfATIKJCig0/xE7+ZYyOE3Tto1keU7eU=;
 fh=K1E5gxtmbNiG9bbztkCqsoLprenxFet1PYmRfqHLYeE=;
 b=FGGUXx+AicnLKLebPtDL0EjwaLuXYPDPJX0F52hDrYP1EcPU1XYc7zc0nhZ8d4vknu
 3C90YiyLR30GFq3qpeC4DOGS7OmBeJqigqK3bym1Y6YTPviA0MS+vhWm+wqYxteEzL6j
 7/s9mIblti3Z2iXI5cQ0SmGe6MwAwFHZuw3bxfdRTkXiZqGmbfJKOqTNBIA8lf+FRBqR
 Sx3gcBT5PbvFl19Nl62ifesVQdUqxcfF4OwEJnWRmBNSdHStlqcrZj2W0FUZHyaS2Fry
 U3+X1M3UmHcnkw/IwXdZqxIktIEzPBZjOeeXPwTHJ/S6aFlqxztGVA9MJa5TrtbkSjDp
 RPiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786976914; x=1787581714; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LsmwwUMpf8aSfATIKJCig0/xE7+ZYyOE3Tto1keU7eU=;
 b=PCvT0rCm7aSI0xuUQPDVzLVRgDkewqf73wKgfH1l7f57U+hC8/6fn1nna3ln97BIt6
 3Ti21Ln99QVYTjTO+FsUVnGV4X4bopL7tDOTmsmE3ZsLPZFulQ/t4wAe761tOJ9qTail
 ia6MbiAd0k7JhfomKXop5Bdj0jOo3QPhQOL8SIv4Wybcmzu+WrcPimDtjltO2VmfTzlp
 xVf1+2DSQ9UTbUsgOKmz7GASQDUooVPKMJkIv26IWho+WoIt+9LiZ3Uy5gqZ6YhTw+A1
 gEcpTlCydbo/Zh4MNfmFq5sHAeMLifj3m5I/JDBd5ZZr5t04BHmWXRElS3GG06ilDYQI
 nuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786976914; x=1787581714;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LsmwwUMpf8aSfATIKJCig0/xE7+ZYyOE3Tto1keU7eU=;
 b=QALQPounAzYZvtv5SHfPoNCZTPBHNAgdE6+ZcuXkB8WQ1rcSTEIN+Y7zDWOL/btx/T
 RtqrRgiIaRIfvC42DkVhiPrRnq4ptFDVJqWOyN7874UFuqJhv2y2ZBLnJ42kyOr2O130
 G//egehkAy0ZPsrK/1Ip1NxmiG1xRuGz0ugB7KP2lLI1BNPXYLJKYpin1DNkmH1zNUAZ
 F+nbZTuaxASN66xDLgh5VJDLBpztyCHfpwHIo5yHdshVBkzzQPeUJJ71IJ+y7gXZiNHe
 bijRawoi59g3wt7cnVkDAJ67BDaabLockLv1UfP9L4ZaVTForkK2vZTutBoyBQ7enUNx
 b4ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RpOTwttx8Nq6Qym5hz0kRgDcG3gaqQY6VyFfzQFnXObtgOunHZhXOhZXdRFSFKFjsTpNFDh+jtS@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlFlCnsyVL7ritPXn/0t/a2iMxG4oXtBHh8SSbcyjggtYGyry6
 pG+5t/f2Qj/2b/T5I0rBjthorMiBFeM+Zc84xeYwLTt11OSa2ztzvsC0ePVgQCPE/SAYz2h9a6T
 s0kFuW4l/lDigiQ3iKY8JPejEmi9+pf0=
X-Gm-Gg: AR+sD10arp0jMIygA7UTOEcubDs4TsQuBC231YG1upKHJDM7QFs1xnDYM709RS5sY47
 w2SXUIUIgX01qPx05XMkgXzh0fHLjMPEZ0kN2Tj8Arqn892fodS1R6h+zUmOgNAyNAY/EqUNqco
 Pvkla8Yu0uv4JS9uvrRSl6jIO29i/VDD0a5FjNjaBPETIcid5O0ncbtGXiOSCCW3RK/37v/nmLe
 MI5XW9hfFy8Gf7rS4NARpdqvzDWksggKRY9ta460CiIsztJY6YPqskKkp9BxTXEES6yhT1mr/JF
 G6gpuwRrAuzLCogneDmmCiKHyHwhyjeTgicSGfdSoQ+2UbQHe8ak6iOnNr5n/9/ddHyhTC5Tvh3
 tlxIEjVV/ddW9R02WkH0z3i8e7HOlcAE=
X-Received: by 2002:a05:6102:c13:b0:738:8d0f:72a3 with SMTP id
 ada2fe7eead31-76f2d5762b4mr1556548137.4.1786976913943; Mon, 17 Aug 2026
 07:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260814103005.9924-1-lingshan.zhu@amd.com>
In-Reply-To: <20260814103005.9924-1-lingshan.zhu@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 17 Aug 2026 10:28:20 -0400
X-Gm-Features: AcwNN1UAJs_uKttYvTHLbji1dlCNOGz89lZ087UoxRhfY07dneqfTcYR1-pPS4I
Message-ID: <CADnq5_PY20QzNikfEy-BZ7ZsOD3YATx9hZDGATi_dEfEgw+z_Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix hang and race in userq destroy
To: Zhu Lingshan <lingshan.zhu@amd.com>
Cc: Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 felix.kuehling@amd.com, Ray.Huang@amd.com, amd-gfx@lists.freedesktop.org
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

On Fri, Aug 14, 2026 at 6:55=E2=80=AFAM Zhu Lingshan <lingshan.zhu@amd.com>=
 wrote:
>
> When a queue is hung, the hang_detect_work is the
> only way to recover it. However in amdgpu_userq_destroy(),
> the hang_detect_work is cancelled too early,
> resulting in amdgpu_userq_wait_for_last_fence()
> may never return, leaving an uninterruptible dma_fence_wait()
> hang there.
>
> To fix this problem, this commit moves the cancelling of
> hang_detect_work after amdgpu_userq_wait_for_last_fence(), and it has
> to be before the unmap helper, because hang_detect_work resets the
> queue, so it races with amdgpu_userq_unmap_helper() for MES operations
> and queue state.
>
> This commit splits amdgpu_userq_cleanup() into two parts:
>
> 1) amdgpu_userq_detach_doorbell(), which detaches the queue from
> userq_doorbell_xa. This has to be called before the cancel, otherwise
> the IRQ handlers (for example amdgpu_userq_process_fence_irq)
> can re-schedule the hang_detect_work and the cancel is not final.
>
> 2) amdgpu_userq_fence_driver_free(), this has to be called after the
> unmap helper, because it can release the seq64 slot that the GPU
> writes fence values to.
>
> Only one cancel_delayed_work_sync(&queue->hang_detect_work) is needed,
> so other redundancies are removed.
>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 17cc48d87c4d..24adad7be251 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -418,19 +418,12 @@ static void amdgpu_userq_wait_for_last_fence(struct=
 amdgpu_usermode_queue *queue
>         dma_fence_wait(f, false);
>  }
>
> -static void amdgpu_userq_cleanup(struct amdgpu_usermode_queue *queue)
> +static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *q=
ueue)
>  {
> -       struct amdgpu_userq_mgr *uq_mgr =3D queue->userq_mgr;
> -       struct amdgpu_device *adev =3D uq_mgr->adev;
> +       struct amdgpu_device *adev =3D queue->userq_mgr->adev;
>
> -       /* Wait for mode-1 reset to complete */
>         down_read(&adev->reset_domain->sem);
> -
> -       /* Use interrupt-safe locking since IRQ handlers may access these=
 XArrays */
>         xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
> -       amdgpu_userq_fence_driver_free(queue);
> -       queue->fence_drv =3D NULL;
> -
>         up_read(&adev->reset_domain->sem);
>  }
>
> @@ -551,18 +544,19 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mg=
r, struct amdgpu_usermode_que
>
>         cancel_delayed_work_sync(&uq_mgr->resume_work);
>
> -       /* Cancel any pending hang detection work and cleanup */
> -       cancel_delayed_work_sync(&queue->hang_detect_work);
> -
>         mutex_lock(&uq_mgr->userq_mutex);
>         amdgpu_userq_wait_for_last_fence(queue);
>
> +       amdgpu_userq_detach_doorbell(queue);
> +       cancel_delayed_work_sync(&queue->hang_detect_work);
> +
>  #if defined(CONFIG_DEBUG_FS)
>         debugfs_remove_recursive(queue->debugfs_queue);
>  #endif
>         r =3D amdgpu_userq_unmap_helper(queue);
>         atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
> -       amdgpu_userq_cleanup(queue);
> +       amdgpu_userq_fence_driver_free(queue);
> +       queue->fence_drv =3D NULL;
>         mutex_unlock(&uq_mgr->userq_mutex);
>
>         /*
> @@ -574,7 +568,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr,=
 struct amdgpu_usermode_que
>         if (r)
>                 queue_work(adev->reset_domain->wq, &uq_mgr->reset_work);
>
> -       cancel_delayed_work_sync(&queue->hang_detect_work);
>         uq_funcs->mqd_destroy(queue);
>         queue->userq_mgr =3D NULL;
>
> @@ -748,7 +741,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>             ((queue->queue_type !=3D AMDGPU_HW_IP_GFX) &&
>              (queue->queue_type !=3D AMDGPU_HW_IP_COMPUTE))) {
>                 /* Serialize the map against an in-progress GPU reset (ME=
S is
> -                * unresponsive during recovery), matching amdgpu_userq_c=
leanup().
> +                * unresponsive during recovery), matching amdgpu_userq_d=
etach_doorbell().
>                  */
>                 down_read(&adev->reset_domain->sem);
>                 r =3D amdgpu_userq_map_helper(queue);
> --
> 2.53.0
>
