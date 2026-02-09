Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C937E81BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 14:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E7210E133;
	Mon,  9 Feb 2026 14:47:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AQGbkhqv";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E312710E133
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 14:47:17 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2ba85f77203so14468eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Feb 2026 06:47:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770648437; cv=none;
 d=google.com; s=arc-20240605;
 b=CoM1YV/V4pdSTZVRHYtYjv/iI/YXS9X78N6qboiDfvdPGOICkoGRYGkTuZiqnG+BfM
 XL4msbQPYJJ0sBKXQqdX8verw2q5Ew0ImbHdSTHUbwT/tLQYXQUFwbIV7Yt7xPxPX4Nl
 AhFkJXwDznkVSvj4B2N80K+KL9EK9ruiqMWbXkXFUkdzkjXZaJzj2QcRbN+/wrql6yB8
 wIWTcOVSU2/m3jS2zyKzf7bdX1j8a5yT5BGpyDczEC6s9HVIr/SH1IHREzBT2KYqNYAN
 00xQtpXhJjJS8PyoIneRbplhTAtNxsqU3g9EbDlptQjQpTFJ6NU4dGyGIRObvccvkX8/
 9g9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lOe2pfj8iYzFOkelqJPqeuZc12kGigs9YQyg0OEOrdg=;
 fh=XixxS8UTp0s9rliOod19lTT9/1ScFFdgo7I9Dyyw2hI=;
 b=czVJ8XKC7jPRu1vL/jXO5vUb5i6i/2LsnRtEIFejjzO1ridU2nk9CH7wUsI1TBPTcn
 OFkKqRaiKOWNF+AcwrWlrf/znoVfqzd4VDm2dDtRuG8mkQxR2GgzUSYLZNR0t9NLYcc2
 aRDVjExGXxCnLW7ItPGM3XHp+7JzpPKVVhrLzFz8BLOYsO0k3DhD2K1zpbPzsrvKyCfW
 5seTpHLlxslUJyNkHfn25a0n3UvS57Kd/iEeeYlSaxfDf27CRKDL8JZgH5fGFQCCjQbh
 0CR7pW2mU+VTPIntQ5zu6kvsQ/aeBK4cDk/mqakuEjwvef1bl+Y66P8fDYtoNunfWOZp
 x9Vw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770648437; x=1771253237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lOe2pfj8iYzFOkelqJPqeuZc12kGigs9YQyg0OEOrdg=;
 b=AQGbkhqvDcKeLJUupf+1LPUrkOeHomkvwzc7kFlKBX5K7WQA+4Px9iwRr0kRl1yGK0
 a8hz0uH4yc2eV678yeD3cfrGKq8iuyVIrtQ4xqoAAZrFmyqkJ+qIGoYrbxlDJVF+Ewp0
 Y4/aXDv7EzEnX2O9WBoiyGYidXG1m77p4wORVS7PE2CgUPDATTn5b5RPl+9RTLgy0XqX
 8P1TouMdupns4pipKPNkrIfFxt2UPqWN0+i9+j/Du252pKBs+Pcp3xBIuBAfErdI0oUa
 mstkRkhTLAM41/rNEzKidKofw3kdlCuoob9F4Mwxa6m0FKTdHiJlPx2E1k6yyHX2GIyd
 /OBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770648437; x=1771253237;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lOe2pfj8iYzFOkelqJPqeuZc12kGigs9YQyg0OEOrdg=;
 b=Md04S2AuOjt4vOfTBLZbsj/3OKOmECDe5bqeuxcY75FKsMkr5WsMRKiQ09UHHwTrJD
 +fnGIcbBOcQtS2IgszDqsxFHLhRvi3LPOJFEF+M4kbsbEkGMXLvOqYc2DhQAVPbONpZY
 ldme54cDn9a/IIfc4x2UWkPE12K300F7lmDSDvTCXD6MP3KC/RTDZuK4aIY0GrHVvq8r
 HaZZ6Xd0QNEsWkhY8fc8j+Z+V+whO+aHi0EY8Tf+82Kt122vY1bV4QwNGL5VygsP0/Ap
 LmiTas4a3Q3YMQM4+bB55+z4aPNc+NhocQ6VXls9WpMQFSRe3iZjpn8Fy4CHiT/m8ylf
 FEgA==
X-Gm-Message-State: AOJu0Ywp+kTZLCdzknjNhZx8/TSvKlDyFmR84w7tiSrKXw1wRLmDviOp
 jl1eSSOxNDdVyVnAypRkrZwok7PidggSazDsWzF46F/wQvd2cPPS0GdVh9HgguvpCKkX5dYGMkt
 61ZBJchZrgNhkEyNqqekcbGSHVVhxKmI=
X-Gm-Gg: AZuq6aKHMa5R4PiK5/RJfsuiddJw/v/On2pxVql9b1seeNs0WHj//nLk1Uh7HUt6VR0
 gaMHHtrtQjEHdQmGSdQCGOoQ/ujrGfz04WPuaWc1TNIA3UMZIsBtjnxpSyYAOebTi7+CRZkhN6x
 EfpPyercgcUIoiUup/7H1kvN6Effs4L1t9VNtAzcfvCzpriSlWrhyG4gB8BFQr1NfCdFKQKxlH5
 kfpuG/Z/FzwOaFC9WlrPTHXndpQYvTHVrGlgxmsG6wmajX+qAvhL9y5gnC1eG0oYnzf8UIs
X-Received: by 2002:a05:7022:458e:b0:11b:ad6a:6e39 with SMTP id
 a92af1059eb24-12703fce96amr2919028c88.5.1770648436782; Mon, 09 Feb 2026
 06:47:16 -0800 (PST)
MIME-Version: 1.0
References: <cover.1770568163.git.perry.yuan@amd.com>
 <25c58434020289fe69f31a9343b5f00a69524edf.1770568163.git.perry.yuan@amd.com>
In-Reply-To: <25c58434020289fe69f31a9343b5f00a69524edf.1770568163.git.perry.yuan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Feb 2026 09:47:05 -0500
X-Gm-Features: AZwV_QjbRU25HTwdy9t-D6p-08tVWENiulERLkKQi-scsniZe4UwqitHhlbmPos
Message-ID: <CADnq5_PuKCh6KD3Oc-jWTy9BO_LGrX-9u25ShWQW6j_8Vsxh2Q@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] Add kfd_ioctl_profiler to contain profiler
 kernel driver changes
To: Perry Yuan <perry.yuan@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Yifan1.Zhang@amd.com
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

On Sun, Feb 8, 2026 at 11:52=E2=80=AFAM Perry Yuan <perry.yuan@amd.com> wro=
te:
>
> From: Benjamin Welton <bewelton@amd.com>
>
> kfd_ioctl_profiler takes a similar approach to that of
> kfd_ioctl_dbg_trap (which contains debugger related IOCTL
> services) where kfd_ioctl_profiler will contain all profiler
> related IOCTL services. The IOCTL is designed to be expanded
> as needed to support additional profiler functionality.
>
> The current functionality of the IOCTL is to allow for profilers
> which need PMC counters from GPU devices to both signal to other
> profilers that may be on the system that the device has active PMC
> profiling taking place on it (multiple PMC profilers on the same
> device can result in corrupted counter data) and to setup the device
> to allow for the collection of SQ PMC data on all queues on the device.
>
> For PMC data for the SQ block (such as SQ_WAVES) to be available
> to a profiler, mmPERFCOUNT_ENABLE must be set on the queues. When
> profiling a single process, the profiler can inject PM4 packets into
> each queue to turn on PERFCOUNT_ENABLE. When profiling system wide,
> the profiler does not have this option and must have a way to turn
> on profiling for queues in which it cannot inject packets into directly.
>
> Accomplishing this requires a few steps:
>
> 1. Checking if the user has the necessary permissions to profile system
>    wide on the device. This check uses the same check that linux perf
>    uses to determine if a user has the necessary permissions to profile
>    at this scope (primarily if the process has CAP_SYS_PERFMON or is root=
).
>
> 2. Locking the device for profiling. This is done by setting a lock bit
>    on the device struct and storing the process that locked the device.
>
> 3. Iterating all queues on the device and issuing an MQD Update to enable
>    perfcounting on the queues.
>
> 4. Actions to cleanup if the process exits or releases the lock.
>
> The IOCTL also contains a link to the existing PC Sampling IOCTL as well.
> This is per a suggestion that we should potentially remove the PC Samplin=
g
> IOCTL to have it be a part of the profiler IOCTL. This is a future change=
.
> In addition, we do expect to expand the profiler IOCTL to include
> additional profiler functionality in the future (which necessitates the
> use of a version number).
>
> Signed-off-by: Benjamin Welton <benjamin.welton@amd.com>
> Signed-off-by: Perry Yuan <perry.yuan@amd.com>
> Acked-by: Kent Russell <kent.russell@amd.com>
> Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>

Please include the link to the usermode stuff that uses this new IOCTL.

Alex

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      | 82 +++++++++++++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  4 +
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c | 25 ++++++
>  .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 +
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  | 16 +++-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  | 14 +++-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  |  8 +-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 15 +++-
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   | 11 +++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  7 ++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 11 +++
>  include/uapi/linux/kfd_ioctl.h                | 29 +++++++
>  12 files changed, 216 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 732ad1224a61..dbb111a33678 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -21,6 +21,7 @@
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
>
> +#include <linux/capability.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/fs.h>
> @@ -3204,6 +3205,84 @@ static int kfd_ioctl_create_process(struct file *f=
ilep, struct kfd_process *p, v
>         return 0;
>  }
>
> +static inline uint32_t profile_lock_device(struct kfd_process *p,
> +                                          uint32_t gpu_id, uint32_t op)
> +{
> +       struct kfd_process_device *pdd;
> +       struct kfd_dev *kfd;
> +       int status =3D -EINVAL;
> +
> +       if (!p)
> +               return -EINVAL;
> +
> +       mutex_lock(&p->mutex);
> +       pdd =3D kfd_process_device_data_by_id(p, gpu_id);
> +       mutex_unlock(&p->mutex);
> +
> +       if (!pdd || !pdd->dev || !pdd->dev->kfd)
> +               return -EINVAL;
> +
> +       kfd =3D pdd->dev->kfd;
> +
> +       mutex_lock(&kfd->profiler_lock);
> +       if (op =3D=3D 1) {
> +               if (!kfd->profiler_process) {
> +                       kfd->profiler_process =3D p;
> +                       status =3D 0;
> +               } else if (kfd->profiler_process =3D=3D p) {
> +                       status =3D -EALREADY;
> +               } else {
> +                       status =3D -EBUSY;
> +               }
> +       } else if (op =3D=3D 0 && kfd->profiler_process =3D=3D p) {
> +               kfd->profiler_process =3D NULL;
> +               status =3D 0;
> +       }
> +       mutex_unlock(&kfd->profiler_lock);
> +
> +       return status;
> +}
> +
> +static inline int kfd_profiler_pmc(struct kfd_process *p,
> +                                  struct kfd_ioctl_pmc_settings *args)
> +{
> +       struct kfd_process_device *pdd;
> +       struct device_queue_manager *dqm;
> +       int status;
> +
> +       /* Check if we have the correct permissions. */
> +       if (!perfmon_capable())
> +               return -EPERM;
> +
> +       /* Lock/Unlock the device based on the parameter given in OP */
> +       status =3D profile_lock_device(p, args->gpu_id, args->lock);
> +       if (status !=3D 0)
> +               return status;
> +
> +       /* Enable/disable perfcount if requested */
> +       mutex_lock(&p->mutex);
> +       pdd =3D kfd_process_device_data_by_id(p, args->gpu_id);
> +       dqm =3D pdd->dev->dqm;
> +       mutex_unlock(&p->mutex);
> +
> +       dqm->ops.set_perfcount(dqm, args->perfcount_enable);
> +       return status;
> +}
> +
> +static int kfd_ioctl_profiler(struct file *filep, struct kfd_process *p,=
 void *data)
> +{
> +       struct kfd_ioctl_profiler_args *args =3D data;
> +
> +       switch (args->op) {
> +       case KFD_IOC_PROFILER_VERSION:
> +               args->version =3D KFD_IOC_PROFILER_VERSION_NUM;
> +               return 0;
> +       case KFD_IOC_PROFILER_PMC:
> +               return kfd_profiler_pmc(p, &args->pmc);
> +       }
> +       return -EINVAL;
> +}
> +
>  #define AMDKFD_IOCTL_DEF(ioctl, _func, _flags) \
>         [_IOC_NR(ioctl)] =3D {.cmd =3D ioctl, .func =3D _func, .flags =3D=
 _flags, \
>                             .cmd_drv =3D 0, .name =3D #ioctl}
> @@ -3325,6 +3404,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls=
[] =3D {
>
>         AMDKFD_IOCTL_DEF(AMDKFD_IOC_CREATE_PROCESS,
>                         kfd_ioctl_create_process, 0),
> +
> +       AMDKFD_IOCTL_DEF(AMDKFD_IOC_PROFILER,
> +                       kfd_ioctl_profiler, 0),
>  };
>
>  #define AMDKFD_CORE_IOCTL_COUNT        ARRAY_SIZE(amdkfd_ioctls)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index 9a66ee661e57..f231e46e8528 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -936,6 +936,9 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
>
>         svm_range_set_max_pages(kfd->adev);
>
> +       kfd->profiler_process =3D NULL;
> +       mutex_init(&kfd->profiler_lock);
> +
>         kfd->init_complete =3D true;
>         dev_info(kfd_device, "added device %x:%x\n", kfd->adev->pdev->ven=
dor,
>                  kfd->adev->pdev->device);
> @@ -971,6 +974,7 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>                 ida_destroy(&kfd->doorbell_ida);
>                 kfd_gtt_sa_fini(kfd);
>                 amdgpu_amdkfd_free_kernel_mem(kfd->adev, &kfd->gtt_mem);
> +               mutex_destroy(&kfd->profiler_lock);
>         }
>
>         kfree(kfd);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 804851632c4c..4170a283db5b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -305,6 +305,29 @@ static int remove_queue_mes(struct device_queue_mana=
ger *dqm, struct queue *q,
>         return r;
>  }
>
> +static void set_perfcount(struct device_queue_manager *dqm, int enable)
> +{
> +       struct device_process_node *cur;
> +       struct qcm_process_device *qpd;
> +       struct queue *q;
> +       struct mqd_update_info minfo =3D { 0 };
> +
> +       if (!dqm)
> +               return;
> +
> +       minfo.update_flag =3D (enable =3D=3D 1 ? UPDATE_FLAG_PERFCOUNT_EN=
ABLE :
> +                                                UPDATE_FLAG_PERFCOUNT_DI=
SABLE);
> +       dqm_lock(dqm);
> +       list_for_each_entry(cur, &dqm->queues, list) {
> +               qpd =3D cur->qpd;
> +               list_for_each_entry(q, &qpd->queues_list, list) {
> +                       pqm_update_mqd(qpd->pqm, q->properties.queue_id,
> +                                               &minfo);
> +               }
> +       }
> +       dqm_unlock(dqm);
> +}
> +
>  static int remove_all_kfd_queues_mes(struct device_queue_manager *dqm)
>  {
>         struct device_process_node *cur;
> @@ -2967,6 +2990,7 @@ struct device_queue_manager *device_queue_manager_i=
nit(struct kfd_node *dev)
>                 dqm->ops.reset_queues =3D reset_queues_cpsch;
>                 dqm->ops.get_queue_checkpoint_info =3D get_queue_checkpoi=
nt_info;
>                 dqm->ops.checkpoint_mqd =3D checkpoint_mqd;
> +               dqm->ops.set_perfcount =3D set_perfcount;
>                 break;
>         case KFD_SCHED_POLICY_NO_HWS:
>                 /* initialize dqm for no cp scheduling */
> @@ -2987,6 +3011,7 @@ struct device_queue_manager *device_queue_manager_i=
nit(struct kfd_node *dev)
>                 dqm->ops.get_wave_state =3D get_wave_state;
>                 dqm->ops.get_queue_checkpoint_info =3D get_queue_checkpoi=
nt_info;
>                 dqm->ops.checkpoint_mqd =3D checkpoint_mqd;
> +               dqm->ops.set_perfcount =3D set_perfcount;
>                 break;
>         default:
>                 dev_err(dev->adev->dev, "Invalid scheduling policy %d\n",=
 dqm->sched_policy);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index ef07e44916f8..74a3bcec3e4e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -200,6 +200,8 @@ struct device_queue_manager_ops {
>                                   const struct queue *q,
>                                   void *mqd,
>                                   void *ctl_stack);
> +       void    (*set_perfcount)(struct device_queue_manager *dqm,
> +                                 int enable);
>  };
>
>  struct device_queue_manager_asic_ops {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 97055f808d4a..993d60a24d50 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -124,10 +124,9 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>          */
>         m->cp_hqd_hq_scheduler0 =3D 1 << 14;
>
> -       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
> +       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL)
>                 m->cp_hqd_aql_control =3D
>                         1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> -       }
>
>         if (mm->dev->kfd->cwsr_enabled) {
>                 m->cp_hqd_persistent_state |=3D
> @@ -142,6 +141,12 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>                 m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>         }
>
> +       mutex_lock(&mm->dev->kfd->profiler_lock);
> +       if (mm->dev->kfd->profiler_process !=3D NULL)
> +               m->compute_perfcount_enable =3D 1;
> +
> +       mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>         *mqd =3D m;
>         if (gart_addr)
>                 *gart_addr =3D addr;
> @@ -221,6 +226,13 @@ static void update_mqd(struct mqd_manager *mm, void =
*mqd,
>         if (mm->dev->kfd->cwsr_enabled)
>                 m->cp_hqd_ctx_save_control =3D 0;
>
> +       if (minfo) {
> +               if (minfo->update_flag =3D=3D UPDATE_FLAG_PERFCOUNT_ENABL=
E)
> +                       m->compute_perfcount_enable =3D 1;
> +               else if (minfo->update_flag =3D=3D UPDATE_FLAG_PERFCOUNT_=
DISABLE)
> +                       m->compute_perfcount_enable =3D 0;
> +       }
> +
>         update_cu_mask(mm, mqd, minfo);
>         set_priority(m, q);
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index 7e5a7ab6d0c0..4a574bbb5f37 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -164,10 +164,9 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>         if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
>                 m->cp_hqd_hq_status0 |=3D 1 << 29;
>
> -       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
> +       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL)
>                 m->cp_hqd_aql_control =3D
>                         1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> -       }
>
>         if (mm->dev->kfd->cwsr_enabled) {
>                 m->cp_hqd_persistent_state |=3D
> @@ -182,6 +181,11 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>                 m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>         }
>
> +       mutex_lock(&mm->dev->kfd->profiler_lock);
> +       if (mm->dev->kfd->profiler_process !=3D NULL)
> +               m->compute_perfcount_enable =3D 1;
> +       mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>         *mqd =3D m;
>         if (gart_addr)
>                 *gart_addr =3D addr;
> @@ -259,6 +263,12 @@ static void update_mqd(struct mqd_manager *mm, void =
*mqd,
>         }
>         if (mm->dev->kfd->cwsr_enabled)
>                 m->cp_hqd_ctx_save_control =3D 0;
> +       if (minfo) {
> +               if (minfo->update_flag =3D=3D UPDATE_FLAG_PERFCOUNT_ENABL=
E)
> +                       m->compute_perfcount_enable =3D 1;
> +               else if (minfo->update_flag =3D=3D UPDATE_FLAG_PERFCOUNT_=
DISABLE)
> +                       m->compute_perfcount_enable =3D 0;
> +       }
>
>         update_cu_mask(mm, mqd, minfo);
>         set_priority(m, q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index a51f217329db..7173f6470e5e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -139,10 +139,9 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>         if (amdgpu_amdkfd_have_atomics_support(mm->dev->adev))
>                 m->cp_hqd_hq_status0 |=3D 1 << 29;
>
> -       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL) {
> +       if (q->format =3D=3D KFD_QUEUE_FORMAT_AQL)
>                 m->cp_hqd_aql_control =3D
>                         1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
> -       }
>
>         if (mm->dev->kfd->cwsr_enabled) {
>                 m->cp_hqd_persistent_state |=3D
> @@ -157,6 +156,11 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>                 m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>         }
>
> +       mutex_lock(&mm->dev->kfd->profiler_lock);
> +       if (mm->dev->kfd->profiler_process !=3D NULL)
> +               m->compute_perfcount_enable =3D 1;
> +       mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>         *mqd =3D m;
>         if (gart_addr)
>                 *gart_addr =3D addr;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index dcf4bbfa641b..d4659a438be5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -218,10 +218,9 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>                 m->cp_hqd_aql_control =3D
>                         1 << CP_HQD_AQL_CONTROL__CONTROL0__SHIFT;
>
> -       if (q->tba_addr) {
> +       if (q->tba_addr)
>                 m->compute_pgm_rsrc2 |=3D
>                         (1 << COMPUTE_PGM_RSRC2__TRAP_PRESENT__SHIFT);
> -       }
>
>         if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_addres=
s) {
>                 m->cp_hqd_persistent_state |=3D
> @@ -236,6 +235,11 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>                 m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>         }
>
> +       mutex_lock(&mm->dev->kfd->profiler_lock);
> +       if (mm->dev->kfd->profiler_process !=3D NULL)
> +               m->compute_perfcount_enable =3D 1;
> +       mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>         *mqd =3D m;
>         if (gart_addr)
>                 *gart_addr =3D addr;
> @@ -318,6 +322,13 @@ static void update_mqd(struct mqd_manager *mm, void =
*mqd,
>         if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_addres=
s)
>                 m->cp_hqd_ctx_save_control =3D 0;
>
> +       if (minfo) {
> +               if (minfo->update_flag =3D=3D UPDATE_FLAG_PERFCOUNT_ENABL=
E)
> +                       m->compute_perfcount_enable =3D 1;
> +               else if (minfo->update_flag =3D=3D UPDATE_FLAG_PERFCOUNT_=
DISABLE)
> +                       m->compute_perfcount_enable =3D 0;
> +       }
> +
>         if (KFD_GC_VERSION(mm->dev) !=3D IP_VERSION(9, 4, 3) &&
>             KFD_GC_VERSION(mm->dev) !=3D IP_VERSION(9, 4, 4) &&
>             KFD_GC_VERSION(mm->dev) !=3D IP_VERSION(9, 5, 0))
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> index 09483f0862d4..e8967f5e3892 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
> @@ -149,6 +149,11 @@ static void init_mqd(struct mqd_manager *mm, void **=
mqd,
>                 m->cp_hqd_wg_state_offset =3D q->ctl_stack_size;
>         }
>
> +       mutex_lock(&mm->dev->kfd->profiler_lock);
> +       if (mm->dev->kfd->profiler_process !=3D NULL)
> +               m->compute_perfcount_enable =3D 1;
> +       mutex_unlock(&mm->dev->kfd->profiler_lock);
> +
>         *mqd =3D m;
>         if (gart_addr)
>                 *gart_addr =3D addr;
> @@ -231,6 +236,12 @@ static void __update_mqd(struct mqd_manager *mm, voi=
d *mqd,
>                 m->cp_hqd_ctx_save_control =3D
>                         atc_bit << CP_HQD_CTX_SAVE_CONTROL__ATC__SHIFT |
>                         mtype << CP_HQD_CTX_SAVE_CONTROL__MTYPE__SHIFT;
> +       if (minfo) {
> +               if (minfo->update_flag =3D=3D UPDATE_FLAG_PERFCOUNT_ENABL=
E)
> +                       m->compute_perfcount_enable =3D 1;
> +               else if (minfo->update_flag =3D=3D UPDATE_FLAG_PERFCOUNT_=
DISABLE)
> +                       m->compute_perfcount_enable =3D 0;
> +       }
>
>         update_cu_mask(mm, mqd, minfo);
>         set_priority(m, q);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 9849b54f54ba..8983065645fa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -384,6 +384,11 @@ struct kfd_dev {
>         int kfd_dev_lock;
>
>         atomic_t kfd_processes_count;
> +
> +       /* Lock for profiler process */
> +       struct mutex profiler_lock;
> +       /* Process currently holding the lock */
> +       struct kfd_process *profiler_process;
>  };
>
>  enum kfd_mempool {
> @@ -556,6 +561,8 @@ enum mqd_update_flag {
>         UPDATE_FLAG_DBG_WA_ENABLE =3D 1,
>         UPDATE_FLAG_DBG_WA_DISABLE =3D 2,
>         UPDATE_FLAG_IS_GWS =3D 4, /* quirk for gfx9 IP */
> +       UPDATE_FLAG_PERFCOUNT_ENABLE =3D 5,
> +       UPDATE_FLAG_PERFCOUNT_DISABLE =3D 6,
>  };
>
>  struct mqd_update_info {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 8511fbebf327..deca19b478d0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1110,6 +1110,16 @@ static void kfd_process_free_outstanding_kfd_bos(s=
truct kfd_process *p)
>                 kfd_process_device_free_bos(p->pdds[i]);
>  }
>
> +static void kfd_process_profiler_release(struct kfd_process *p, struct k=
fd_process_device *pdd)
> +{
> +       mutex_lock(&pdd->dev->kfd->profiler_lock);
> +       if (pdd->dev->kfd->profiler_process =3D=3D p) {
> +               pdd->qpd.dqm->ops.set_perfcount(pdd->qpd.dqm, 0);
> +               pdd->dev->kfd->profiler_process =3D NULL;
> +       }
> +       mutex_unlock(&pdd->dev->kfd->profiler_lock);
> +}
> +
>  static void kfd_process_destroy_pdds(struct kfd_process *p)
>  {
>         int i;
> @@ -1121,6 +1131,7 @@ static void kfd_process_destroy_pdds(struct kfd_pro=
cess *p)
>
>                 pr_debug("Releasing pdd (topology id %d, for pid %d)\n",
>                         pdd->dev->id, p->lead_thread->pid);
> +               kfd_process_profiler_release(p, pdd);
>                 kfd_process_device_destroy_cwsr_dgpu(pdd);
>                 kfd_process_device_destroy_ib_mem(pdd);
>
> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioct=
l.h
> index e72359370857..a8b2a18d07cf 100644
> --- a/include/uapi/linux/kfd_ioctl.h
> +++ b/include/uapi/linux/kfd_ioctl.h
> @@ -1558,6 +1558,29 @@ struct kfd_ioctl_dbg_trap_args {
>         };
>  };
>
> +#define KFD_IOC_PROFILER_VERSION_NUM 1
> +enum kfd_profiler_ops {
> +       KFD_IOC_PROFILER_PMC =3D 0,
> +       KFD_IOC_PROFILER_VERSION =3D 2,
> +};
> +
> +/**
> + * Enables/Disables GPU Specific profiler settings
> + */
> +struct kfd_ioctl_pmc_settings {
> +       __u32 gpu_id;             /* This is the user_gpu_id */
> +       __u32 lock;               /* Lock GPU for Profiling */
> +       __u32 perfcount_enable;   /* Force Perfcount Enable for queues on=
 GPU */
> +};
> +
> +struct kfd_ioctl_profiler_args {
> +       __u32 op;                                               /* kfd_pr=
ofiler_op */
> +       union {
> +               struct kfd_ioctl_pmc_settings  pmc;
> +               __u32 version;                          /* KFD_IOC_PROFIL=
ER_VERSION_NUM */
> +       };
> +};
> +
>  #define AMDKFD_IOCTL_BASE 'K'
>  #define AMDKFD_IO(nr)                  _IO(AMDKFD_IOCTL_BASE, nr)
>  #define AMDKFD_IOR(nr, type)           _IOR(AMDKFD_IOCTL_BASE, nr, type)
> @@ -1684,4 +1707,10 @@ struct kfd_ioctl_dbg_trap_args {
>  #define AMDKFD_COMMAND_START           0x01
>  #define AMDKFD_COMMAND_END             0x28
>
> +#define AMDKFD_IOC_PROFILER                    \
> +               AMDKFD_IOWR(0x86, struct kfd_ioctl_profiler_args)
> +
> +#define AMDKFD_COMMAND_START_2         0x80
> +#define AMDKFD_COMMAND_END_2           0x87
> +
>  #endif
> --
> 2.34.1
>
