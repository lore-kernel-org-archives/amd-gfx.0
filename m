Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E711CCD184
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Oct 2025 19:10:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3961210EAFA;
	Thu,  9 Oct 2025 19:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jb7ZG9Sv";
	dkim-atps=neutral
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF05510EAFA
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Oct 2025 19:10:40 +0000 (UTC)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-26e81c17d60so2338945ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Oct 2025 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760037040; x=1760641840; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2sOoh7nsZK582JNQ/XqDjK+l+cDOPOZTvHzw/iyTerw=;
 b=jb7ZG9SvEd3wmtlEm3QeCDa/bxB+Qc5RHtzxiIOUxMeruwJ8nzkTx5MCkffTZeKRsn
 UDJ4L/cV337Pki3kRK5HUJ81XDQN2QCGWTbkpGNBRXAf/gcjjYJWQnnd7RM2rvEv9psG
 YqAgzzZ7vOFujKYOgFKVSJEr3bFrLZNJVOevygRSmaQnIREfxG3NKCbJ0k3CTcrygnhx
 i0iqgm3XdJkp2lFRYMF0Ft98uxj8EcGhrdi5idRrVPVcuheg40AHrUAbunZtDnjW7H0E
 oGY0IMh9FVHhwG1u79eWmGOm+jWSixO84pJGwr4D4mG5Ppb33Y/Q5OiuTcjrxJat2iZb
 t2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760037040; x=1760641840;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2sOoh7nsZK582JNQ/XqDjK+l+cDOPOZTvHzw/iyTerw=;
 b=EJOdbYjCQjeuycMKTBt2i+cqq9vvaLYyKEWSLWizHmmqg/Zdi8JfPsmADrZC2iGHk+
 Ud2xjByGBPz8oh9NGWij8Nxc64Ioqc6CFjXZUj6/VQCqYaRpmjeWTodjOTLTue2oE5jt
 MKcf0Bj3Q+C0kl8lrGjTHlND+k65xT1xv9Qr6cjgbjPnIpfvQ+/H7nNSB7mlMhzkpee9
 8X4KI3ijFTKDy77XGitYLQkFIrKAXXexv3nmpV86ij78kHmxcJ0/pWo3x/6pTFpXnSj3
 I3d9h5q8L08+PaVz/BV21q40iVRHGQgNPbbZuW/WWbf9b6VFbvJC9YHMaiK0ZCFFuWvl
 rqEw==
X-Gm-Message-State: AOJu0Yziq5yx6EaNhq9WEMxtKTnxZCBq0/QX2bX/ZTbb4gtmTIX10GgM
 X3++YSGJm7KIbKnZand62uYAjZ2TB21LW8RRCASfzWmBkpgg8bocDYlBlrkKLWasJSy4G1YQlPB
 oOOBzNJR8MbFAtZ1oOIQU8n4sC358VP6gpA==
X-Gm-Gg: ASbGncsPV9sZuqLozOrOI4TUYhsGb20/3QnrK5d1BOWcFRHoCA4VE2qyvapfilsEB1h
 Oet6ClT1rdbHu7CSHe7Aq8vH+peWxTvh/Vd63Del6khBE9gSPQ75+2M/yVmqB95WldlV0j+ns2m
 XGRNmxXZL8/E71lW+WH27AM3eun6A810SKFTX1xC54phvC/TZVoUjNg4E08kn78ytmkYISzb/z4
 IouZLtQUCLLLbSkqBgRAU8LvxUrec8=
X-Google-Smtp-Source: AGHT+IGYdg2G7ZbSCYPsIq00Ma3Yh4Vr9vrNMn0LMj6NwC6nVEhlL7x27JXOawN8R0fgmnqqmbi5vkYyQh9PnDd8TwI=
X-Received: by 2002:a17:902:e849:b0:27e:e96a:4bf with SMTP id
 d9443c01a7336-290273c6246mr69960805ad.2.1760037040253; Thu, 09 Oct 2025
 12:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <20251009184929.1038298-1-jonathan.kim@amd.com>
 <20251009184929.1038298-6-jonathan.kim@amd.com>
In-Reply-To: <20251009184929.1038298-6-jonathan.kim@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 9 Oct 2025 15:10:27 -0400
X-Gm-Features: AS18NWCSic7vUUq0ESHPxkkBVsrw6-H_v-ky1_b3HRjGQFdQbg4tWbgjSstS6uc
Message-ID: <CADnq5_NB1Tm951Spi60HEBFYykAVGCWtGyNU=ckbqz=Q9qMhRA@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/amdkfd: fix suspend/resume all calls in mes based
 eviction path
To: Jonathan Kim <jonathan.kim@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Shaoyun.Liu@amd.com, Harish.Kasiviswanathan@amd.com, Amber.Lin@amd.com
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

On Thu, Oct 9, 2025 at 2:50=E2=80=AFPM Jonathan Kim <jonathan.kim@amd.com> =
wrote:
>
> Suspend/resume all gangs should be done with the device lock is held.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 73 ++++++-------------
>  1 file changed, 21 insertions(+), 52 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 6c5c7c1bf5ed..6e7bc983fc0b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1209,6 +1209,15 @@ static int evict_process_queues_cpsch(struct devic=
e_queue_manager *dqm,
>         pr_debug_ratelimited("Evicting process pid %d queues\n",
>                             pdd->process->lead_thread->pid);
>
> +       if (dqm->dev->kfd->shared_resources.enable_mes) {
> +               pdd->last_evict_timestamp =3D get_jiffies_64();
> +               retval =3D suspend_all_queues_mes(dqm);
> +               if (retval) {
> +                       dev_err(dev, "Suspending all queues failed");
> +                       goto out;
> +               }
> +       }
> +
>         /* Mark all queues as evicted. Deactivate all active queues on
>          * the qpd.
>          */
> @@ -1221,23 +1230,27 @@ static int evict_process_queues_cpsch(struct devi=
ce_queue_manager *dqm,
>                 decrement_queue_count(dqm, qpd, q);
>
>                 if (dqm->dev->kfd->shared_resources.enable_mes) {
> -                       int err;
> -
> -                       err =3D remove_queue_mes(dqm, q, qpd);
> -                       if (err) {
> +                       retval =3D remove_queue_mes(dqm, q, qpd);
> +                       if (retval) {
>                                 dev_err(dev, "Failed to evict queue %d\n"=
,
>                                         q->properties.queue_id);
> -                               retval =3D err;
> +                               goto out;
>                         }
>                 }
>         }
> -       pdd->last_evict_timestamp =3D get_jiffies_64();
> -       if (!dqm->dev->kfd->shared_resources.enable_mes)
> +
> +       if (!dqm->dev->kfd->shared_resources.enable_mes) {
> +               pdd->last_evict_timestamp =3D get_jiffies_64();
>                 retval =3D execute_queues_cpsch(dqm,
>                                               qpd->is_debug ?
>                                               KFD_UNMAP_QUEUES_FILTER_ALL=
_QUEUES :
>                                               KFD_UNMAP_QUEUES_FILTER_DYN=
AMIC_QUEUES, 0,
>                                               USE_DEFAULT_GRACE_PERIOD);
> +       } else {
> +               retval =3D resume_all_queues_mes(dqm);
> +               if (retval)
> +                       dev_err(dev, "Resuming all queues failed");
> +       }
>
>  out:
>         dqm_unlock(dqm);
> @@ -3098,61 +3111,17 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node=
 *knode, u32 pasid, u32 doorbel
>         return ret;
>  }
>
> -static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
> -                                  struct qcm_process_device *qpd)
> -{
> -       struct device *dev =3D dqm->dev->adev->dev;
> -       int ret =3D 0;
> -
> -       /* Check if process is already evicted */
> -       dqm_lock(dqm);
> -       if (qpd->evicted) {
> -               /* Increment the evicted count to make sure the
> -                * process stays evicted before its terminated.
> -                */
> -               qpd->evicted++;
> -               dqm_unlock(dqm);
> -               goto out;
> -       }
> -       dqm_unlock(dqm);
> -
> -       ret =3D suspend_all_queues_mes(dqm);
> -       if (ret) {
> -               dev_err(dev, "Suspending all queues failed");
> -               goto out;
> -       }
> -
> -       ret =3D dqm->ops.evict_process_queues(dqm, qpd);
> -       if (ret) {
> -               dev_err(dev, "Evicting process queues failed");
> -               goto out;
> -       }
> -
> -       ret =3D resume_all_queues_mes(dqm);
> -       if (ret)
> -               dev_err(dev, "Resuming all queues failed");
> -
> -out:
> -       return ret;
> -}
> -
>  int kfd_evict_process_device(struct kfd_process_device *pdd)
>  {
>         struct device_queue_manager *dqm;
>         struct kfd_process *p;
> -       int ret =3D 0;
>
>         p =3D pdd->process;
>         dqm =3D pdd->dev->dqm;
>
>         WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
>
> -       if (dqm->dev->kfd->shared_resources.enable_mes)
> -               ret =3D kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
> -       else
> -               ret =3D dqm->ops.evict_process_queues(dqm, &pdd->qpd);
> -
> -       return ret;
> +       return dqm->ops.evict_process_queues(dqm, &pdd->qpd);
>  }
>
>  int reserve_debug_trap_vmid(struct device_queue_manager *dqm,
> --
> 2.34.1
>
