Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBACC2BBCA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 19:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C0C010E033;
	Tue, 25 Jun 2024 19:22:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dOqXF9xF";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C69910E033
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 19:22:23 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-1fa1a542466so24996625ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 12:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719343343; x=1719948143; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gf/NOFDtqK9L/GrQn0rjBQIhxRwurAUnSeIKt3c5eAk=;
 b=dOqXF9xFunoBJXfho23SMEtiM/XQK/ap4bVHtGxwCIb84H6WJ9L7EoiuX+0UuQr6j9
 QnnEjBl/SjMpHrIOhTpby8YYlSpCFgNgbjahDZEo/rbmpW1cx9a81ES73ySftG4Y/YmT
 8Ur+JO4xj/7SaiplMqbNSZnnxfBowKdKsm4bs+NqnbO67pq1xWMy2Li/bhghuZLBb97P
 cf8SAGccz9M60TRdhtnhgAigOP1Be/pg/9+E9hpf81oMaBnHfIWuYuFad3g0jwYGsVQf
 86g2H0TgkuZQo8AhkMknvo6M50S3VtAyAlRLqcemuIDyhsPOGky0Hp3kanFovzby1nvs
 CMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719343343; x=1719948143;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gf/NOFDtqK9L/GrQn0rjBQIhxRwurAUnSeIKt3c5eAk=;
 b=du2QP9sXUDwm5Yg/Yf+vn0XSWx+8ASm3/NU78sm6OQDTmdTOXgmJ6RGQhReny10PPK
 tkGPJgctpKW1wzjKOADTouzpHS9H8FE7OvFqsSKcqPwqD703ZbHsdkdco/WSWE4vYw35
 1JHoTRFEHzpnmzE2C6r6MtcF4Rpb96IGjHwWPU1YUfVrw6yb7OtDwGZGTRRbglf++DFI
 EnKC0rw0n4g2eHaUpdJj1Pry+KqMkm4ZWJRozUxxh4ctk1VM2ypNnWZgR++lIu+hQ8mW
 zCtJ8Tly7+WUP8unyyTUmewC5ryn0DPf5YHf2j5aJLmMFwSF5goZEYOOLs2o+e/RyK+B
 cJjA==
X-Gm-Message-State: AOJu0YzTa5LPBmcrBRV6/4ZkpdGWFCPEzj4NkaVQxkBg3q2/UBunzBg+
 sZji2wRTjvDksTlCRLonahTc0gKJOcf0tSWayHr0pZJhIwS1P3KbZVF0pTb+9Rj8JPgrgMXJj7H
 WWVUvBPk8bT29dzrdw/Yt015zEvb9EA==
X-Google-Smtp-Source: AGHT+IHbied6Jo/LYECSojYncNlI5OFJr/y2AUmPB11zu6KPAZ9DBRiVNqw4seLdTt0KvPSaEK7Y4yp0gpAQfhu5BKw=
X-Received: by 2002:a17:903:2445:b0:1f9:ba4b:57d2 with SMTP id
 d9443c01a7336-1fa0fb0494emr137785935ad.27.1719343342596; Tue, 25 Jun 2024
 12:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240625135618.1221391-1-lijo.lazar@amd.com>
In-Reply-To: <20240625135618.1221391-1-lijo.lazar@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Jun 2024 15:22:10 -0400
Message-ID: <CADnq5_NFOwo6d8fuYZPmfA5m7SQoNBCmkx5U0DdhM2mJe-mRNg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Use device based logging for errors
To: Lijo Lazar <lijo.lazar@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, 
 Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, mukul.joshi@amd.com, 
 Harish.Kasiviswanathan@amd.com
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

On Tue, Jun 25, 2024 at 10:32=E2=80=AFAM Lijo Lazar <lijo.lazar@amd.com> wr=
ote:
>
> Convert some pr_* to some dev_* APIs to identify the device.
>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c  |  3 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c | 21 ++++---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  8 ++-
>  .../gpu/drm/amd/amdkfd/kfd_packet_manager.c   | 63 ++++++++++++-------
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 24 ++++---
>  5 files changed, 74 insertions(+), 45 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/d=
rm/amd/amdkfd/kfd_flat_memory.c
> index 4a64307bc438..dbcb60eb54b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
> @@ -380,7 +380,8 @@ int kfd_init_apertures(struct kfd_process *process)
>
>                 pdd =3D kfd_create_process_device_data(dev, process);
>                 if (!pdd) {
> -                       pr_err("Failed to create process device data\n");
> +                       dev_err(dev->adev->dev,
> +                               "Failed to create process device data\n")=
;
>                         return -ENOMEM;
>                 }
>                 /*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_kernel_queue.c
> index 3ea75a9d86ec..4843dcb9a5f7 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
> @@ -69,7 +69,7 @@ static bool kq_initialize(struct kernel_queue *kq, stru=
ct kfd_node *dev,
>                 kq->mqd_mgr =3D dev->dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
>                 break;
>         default:
> -               pr_err("Invalid queue type %d\n", type);
> +               dev_err(dev->adev->dev, "Invalid queue type %d\n", type);
>                 return false;
>         }
>
> @@ -79,13 +79,14 @@ static bool kq_initialize(struct kernel_queue *kq, st=
ruct kfd_node *dev,
>         prop.doorbell_ptr =3D kfd_get_kernel_doorbell(dev->kfd, &prop.doo=
rbell_off);
>
>         if (!prop.doorbell_ptr) {
> -               pr_err("Failed to initialize doorbell");
> +               dev_err(dev->adev->dev, "Failed to initialize doorbell");
>                 goto err_get_kernel_doorbell;
>         }
>
>         retval =3D kfd_gtt_sa_allocate(dev, queue_size, &kq->pq);
>         if (retval !=3D 0) {
> -               pr_err("Failed to init pq queues size %d\n", queue_size);
> +               dev_err(dev->adev->dev, "Failed to init pq queues size %d=
\n",
> +                       queue_size);
>                 goto err_pq_allocate_vidmem;
>         }
>
> @@ -341,7 +342,7 @@ struct kernel_queue *kernel_queue_init(struct kfd_nod=
e *dev,
>         if (kq_initialize(kq, dev, type, KFD_KERNEL_QUEUE_SIZE))
>                 return kq;
>
> -       pr_err("Failed to init kernel queue\n");
> +       dev_err(dev->adev->dev, "Failed to init kernel queue\n");
>
>         kfree(kq);
>         return NULL;
> @@ -360,26 +361,26 @@ static __attribute__((unused)) void test_kq(struct =
kfd_node *dev)
>         uint32_t *buffer, i;
>         int retval;
>
> -       pr_err("Starting kernel queue test\n");
> +       dev_err(dev->adev->dev, "Starting kernel queue test\n");
>
>         kq =3D kernel_queue_init(dev, KFD_QUEUE_TYPE_HIQ);
>         if (unlikely(!kq)) {
> -               pr_err("  Failed to initialize HIQ\n");
> -               pr_err("Kernel queue test failed\n");
> +               dev_err(dev->adev->dev, "  Failed to initialize HIQ\n");
> +               dev_err(dev->adev->dev, "Kernel queue test failed\n");
>                 return;
>         }
>
>         retval =3D kq_acquire_packet_buffer(kq, 5, &buffer);
>         if (unlikely(retval !=3D 0)) {
> -               pr_err("  Failed to acquire packet buffer\n");
> -               pr_err("Kernel queue test failed\n");
> +               dev_err(dev->adev->dev, "  Failed to acquire packet buffe=
r\n");
> +               dev_err(dev->adev->dev, "Kernel queue test failed\n");
>                 return;
>         }
>         for (i =3D 0; i < 5; i++)
>                 buffer[i] =3D kq->nop_packet;
>         kq_submit_packet(kq);
>
> -       pr_err("Ending kernel queue test\n");
> +       dev_err(dev->adev->dev, "Ending kernel queue test\n");
>  }
>
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/d=
rm/amd/amdkfd/kfd_mqd_manager.c
> index ccfa5a0a8f6b..50a81da43ce1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
> @@ -118,12 +118,14 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manag=
er *mm,
>          * attention grabbing.
>          */
>         if (gfx_info->max_shader_engines > KFD_MAX_NUM_SE) {
> -               pr_err("Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
> -                      gfx_info->max_shader_engines);
> +               dev_err(mm->dev->adev->dev,
> +                       "Exceeded KFD_MAX_NUM_SE, chip reports %d\n",
> +                       gfx_info->max_shader_engines);
>                 return;
>         }
>         if (gfx_info->max_sh_per_se > KFD_MAX_NUM_SH_PER_SE) {
> -               pr_err("Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
> +               dev_err(mm->dev->adev->dev,
> +                       "Exceeded KFD_MAX_NUM_SH, chip reports %d\n",
>                         gfx_info->max_sh_per_se * gfx_info->max_shader_en=
gines);
>                 return;
>         }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_packet_manager.c
> index a05d5c1097a8..37930629edc5 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
> @@ -45,7 +45,8 @@ static void pm_calc_rlib_size(struct packet_manager *pm=
,
>         unsigned int process_count, queue_count, compute_queue_count, gws=
_queue_count;
>         unsigned int map_queue_size;
>         unsigned int max_proc_per_quantum =3D 1;
> -       struct kfd_node *dev =3D pm->dqm->dev;
> +       struct kfd_node *node =3D pm->dqm->dev;
> +       struct device *dev =3D node->adev->dev;
>
>         process_count =3D pm->dqm->processes_count;
>         queue_count =3D pm->dqm->active_queue_count;
> @@ -59,14 +60,14 @@ static void pm_calc_rlib_size(struct packet_manager *=
pm,
>          */
>         *over_subscription =3D false;
>
> -       if (dev->max_proc_per_quantum > 1)
> -               max_proc_per_quantum =3D dev->max_proc_per_quantum;
> +       if (node->max_proc_per_quantum > 1)
> +               max_proc_per_quantum =3D node->max_proc_per_quantum;
>
>         if ((process_count > max_proc_per_quantum) ||
>             compute_queue_count > get_cp_queues_num(pm->dqm) ||
>             gws_queue_count > 1) {
>                 *over_subscription =3D true;
> -               pr_debug("Over subscribed runlist\n");
> +               dev_dbg(dev, "Over subscribed runlist\n");
>         }
>
>         map_queue_size =3D pm->pmf->map_queues_size;
> @@ -81,7 +82,7 @@ static void pm_calc_rlib_size(struct packet_manager *pm=
,
>         if (*over_subscription)
>                 *rlib_size +=3D pm->pmf->runlist_size;
>
> -       pr_debug("runlist ib size %d\n", *rlib_size);
> +       dev_dbg(dev, "runlist ib size %d\n", *rlib_size);
>  }
>
>  static int pm_allocate_runlist_ib(struct packet_manager *pm,
> @@ -90,6 +91,8 @@ static int pm_allocate_runlist_ib(struct packet_manager=
 *pm,
>                                 unsigned int *rl_buffer_size,
>                                 bool *is_over_subscription)
>  {
> +       struct kfd_node *node =3D pm->dqm->dev;
> +       struct device *dev =3D node->adev->dev;
>         int retval;
>
>         if (WARN_ON(pm->allocated))
> @@ -99,11 +102,10 @@ static int pm_allocate_runlist_ib(struct packet_mana=
ger *pm,
>
>         mutex_lock(&pm->lock);
>
> -       retval =3D kfd_gtt_sa_allocate(pm->dqm->dev, *rl_buffer_size,
> -                                       &pm->ib_buffer_obj);
> +       retval =3D kfd_gtt_sa_allocate(node, *rl_buffer_size, &pm->ib_buf=
fer_obj);
>
>         if (retval) {
> -               pr_err("Failed to allocate runlist IB\n");
> +               dev_err(dev, "Failed to allocate runlist IB\n");
>                 goto out;
>         }
>
> @@ -125,6 +127,8 @@ static int pm_create_runlist_ib(struct packet_manager=
 *pm,
>  {
>         unsigned int alloc_size_bytes;
>         unsigned int *rl_buffer, rl_wptr, i;
> +       struct kfd_node *node =3D pm->dqm->dev;
> +       struct device *dev =3D node->adev->dev;
>         int retval, processes_mapped;
>         struct device_process_node *cur;
>         struct qcm_process_device *qpd;
> @@ -142,7 +146,7 @@ static int pm_create_runlist_ib(struct packet_manager=
 *pm,
>         *rl_size_bytes =3D alloc_size_bytes;
>         pm->ib_size_bytes =3D alloc_size_bytes;
>
> -       pr_debug("Building runlist ib process count: %d queues count %d\n=
",
> +       dev_dbg(dev, "Building runlist ib process count: %d queues count =
%d\n",
>                 pm->dqm->processes_count, pm->dqm->active_queue_count);
>
>         /* build the run list ib packet */
> @@ -150,7 +154,7 @@ static int pm_create_runlist_ib(struct packet_manager=
 *pm,
>                 qpd =3D cur->qpd;
>                 /* build map process packet */
>                 if (processes_mapped >=3D pm->dqm->processes_count) {
> -                       pr_debug("Not enough space left in runlist IB\n")=
;
> +                       dev_dbg(dev, "Not enough space left in runlist IB=
\n");
>                         pm_release_ib(pm);
>                         return -ENOMEM;
>                 }
> @@ -167,7 +171,8 @@ static int pm_create_runlist_ib(struct packet_manager=
 *pm,
>                         if (!kq->queue->properties.is_active)
>                                 continue;
>
> -                       pr_debug("static_queue, mapping kernel q %d, is d=
ebug status %d\n",
> +                       dev_dbg(dev,
> +                               "static_queue, mapping kernel q %d, is de=
bug status %d\n",
>                                 kq->queue->queue, qpd->is_debug);
>
>                         retval =3D pm->pmf->map_queues(pm,
> @@ -186,7 +191,8 @@ static int pm_create_runlist_ib(struct packet_manager=
 *pm,
>                         if (!q->properties.is_active)
>                                 continue;
>
> -                       pr_debug("static_queue, mapping user queue %d, is=
 debug status %d\n",
> +                       dev_dbg(dev,
> +                               "static_queue, mapping user queue %d, is =
debug status %d\n",
>                                 q->queue, qpd->is_debug);
>
>                         retval =3D pm->pmf->map_queues(pm,
> @@ -203,11 +209,13 @@ static int pm_create_runlist_ib(struct packet_manag=
er *pm,
>                 }
>         }
>
> -       pr_debug("Finished map process and queues to runlist\n");
> +       dev_dbg(dev, "Finished map process and queues to runlist\n");
>
>         if (is_over_subscription) {
>                 if (!pm->is_over_subscription)
> -                       pr_warn("Runlist is getting oversubscribed. Expec=
t reduced ROCm performance.\n");
> +                       dev_warn(
> +                               dev,
> +                               "Runlist is getting oversubscribed. Expec=
t reduced ROCm performance.\n");
>                 retval =3D pm->pmf->runlist(pm, &rl_buffer[rl_wptr],
>                                         *rl_gpu_addr,
>                                         alloc_size_bytes / sizeof(uint32_=
t),
> @@ -273,6 +281,8 @@ void pm_uninit(struct packet_manager *pm)
>  int pm_send_set_resources(struct packet_manager *pm,
>                                 struct scheduling_resources *res)
>  {
> +       struct kfd_node *node =3D pm->dqm->dev;
> +       struct device *dev =3D node->adev->dev;
>         uint32_t *buffer, size;
>         int retval =3D 0;
>
> @@ -282,7 +292,7 @@ int pm_send_set_resources(struct packet_manager *pm,
>                                         size / sizeof(uint32_t),
>                                         (unsigned int **)&buffer);
>         if (!buffer) {
> -               pr_err("Failed to allocate buffer on kernel queue\n");
> +               dev_err(dev, "Failed to allocate buffer on kernel queue\n=
");
>                 retval =3D -ENOMEM;
>                 goto out;
>         }
> @@ -344,6 +354,8 @@ int pm_send_runlist(struct packet_manager *pm, struct=
 list_head *dqm_queues)
>  int pm_send_query_status(struct packet_manager *pm, uint64_t fence_addre=
ss,
>                         uint64_t fence_value)
>  {
> +       struct kfd_node *node =3D pm->dqm->dev;
> +       struct device *dev =3D node->adev->dev;
>         uint32_t *buffer, size;
>         int retval =3D 0;
>
> @@ -355,7 +367,7 @@ int pm_send_query_status(struct packet_manager *pm, u=
int64_t fence_address,
>         kq_acquire_packet_buffer(pm->priv_queue,
>                         size / sizeof(uint32_t), (unsigned int **)&buffer=
);
>         if (!buffer) {
> -               pr_err("Failed to allocate buffer on kernel queue\n");
> +               dev_err(dev, "Failed to allocate buffer on kernel queue\n=
");
>                 retval =3D -ENOMEM;
>                 goto out;
>         }
> @@ -373,6 +385,8 @@ int pm_send_query_status(struct packet_manager *pm, u=
int64_t fence_address,
>
>  int pm_update_grace_period(struct packet_manager *pm, uint32_t grace_per=
iod)
>  {
> +       struct kfd_node *node =3D pm->dqm->dev;
> +       struct device *dev =3D node->adev->dev;
>         int retval =3D 0;
>         uint32_t *buffer, size;
>
> @@ -386,7 +400,8 @@ int pm_update_grace_period(struct packet_manager *pm,=
 uint32_t grace_period)
>                         (unsigned int **)&buffer);
>
>                 if (!buffer) {
> -                       pr_err("Failed to allocate buffer on kernel queue=
\n");
> +                       dev_err(dev,
> +                               "Failed to allocate buffer on kernel queu=
e\n");
>                         retval =3D -ENOMEM;
>                         goto out;
>                 }
> @@ -407,6 +422,8 @@ int pm_send_unmap_queue(struct packet_manager *pm,
>                         enum kfd_unmap_queues_filter filter,
>                         uint32_t filter_param, bool reset)
>  {
> +       struct kfd_node *node =3D pm->dqm->dev;
> +       struct device *dev =3D node->adev->dev;
>         uint32_t *buffer, size;
>         int retval =3D 0;
>
> @@ -415,7 +432,7 @@ int pm_send_unmap_queue(struct packet_manager *pm,
>         kq_acquire_packet_buffer(pm->priv_queue,
>                         size / sizeof(uint32_t), (unsigned int **)&buffer=
);
>         if (!buffer) {
> -               pr_err("Failed to allocate buffer on kernel queue\n");
> +               dev_err(dev, "Failed to allocate buffer on kernel queue\n=
");
>                 retval =3D -ENOMEM;
>                 goto out;
>         }
> @@ -464,6 +481,8 @@ int pm_debugfs_runlist(struct seq_file *m, void *data=
)
>
>  int pm_debugfs_hang_hws(struct packet_manager *pm)
>  {
> +       struct kfd_node *node =3D pm->dqm->dev;
> +       struct device *dev =3D node->adev->dev;
>         uint32_t *buffer, size;
>         int r =3D 0;
>
> @@ -475,16 +494,16 @@ int pm_debugfs_hang_hws(struct packet_manager *pm)
>         kq_acquire_packet_buffer(pm->priv_queue,
>                         size / sizeof(uint32_t), (unsigned int **)&buffer=
);
>         if (!buffer) {
> -               pr_err("Failed to allocate buffer on kernel queue\n");
> +               dev_err(dev, "Failed to allocate buffer on kernel queue\n=
");
>                 r =3D -ENOMEM;
>                 goto out;
>         }
>         memset(buffer, 0x55, size);
>         kq_submit_packet(pm->priv_queue);
>
> -       pr_info("Submitting %x %x %x %x %x %x %x to HIQ to hang the HWS."=
,
> -               buffer[0], buffer[1], buffer[2], buffer[3],
> -               buffer[4], buffer[5], buffer[6]);
> +       dev_info(dev, "Submitting %x %x %x %x %x %x %x to HIQ to hang the=
 HWS.",
> +                buffer[0], buffer[1], buffer[2], buffer[3], buffer[4],
> +                buffer[5], buffer[6]);
>  out:
>         mutex_unlock(&pm->lock);
>         return r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 6251f37c312a..17e42161b015 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1311,7 +1311,8 @@ int kfd_process_init_cwsr_apu(struct kfd_process *p=
, struct file *filep)
>                 if (IS_ERR_VALUE(qpd->tba_addr)) {
>                         int err =3D qpd->tba_addr;
>
> -                       pr_err("Failure to set tba address. error %d.\n",=
 err);
> +                       dev_err(dev->adev->dev,
> +                               "Failure to set tba address. error %d.\n"=
, err);
>                         qpd->tba_addr =3D 0;
>                         qpd->cwsr_kaddr =3D NULL;
>                         return err;
> @@ -1611,7 +1612,8 @@ struct kfd_process_device *kfd_create_process_devic=
e_data(struct kfd_node *dev,
>                                                 &pdd->proc_ctx_cpu_ptr,
>                                                 false);
>                 if (retval) {
> -                       pr_err("failed to allocate process context bo\n")=
;
> +                       dev_err(dev->adev->dev,
> +                               "failed to allocate process context bo\n"=
);
>                         goto err_free_pdd;
>                 }
>                 memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE=
);
> @@ -1676,7 +1678,7 @@ int kfd_process_device_init_vm(struct kfd_process_d=
evice *pdd,
>                                                      &p->kgd_process_info=
,
>                                                      &ef);
>         if (ret) {
> -               pr_err("Failed to create process VM object\n");
> +               dev_err(dev->adev->dev, "Failed to create process VM obje=
ct\n");
>                 return ret;
>         }
>         RCU_INIT_POINTER(p->ef, ef);
> @@ -1723,7 +1725,7 @@ struct kfd_process_device *kfd_bind_process_to_devi=
ce(struct kfd_node *dev,
>
>         pdd =3D kfd_get_process_device_data(dev, p);
>         if (!pdd) {
> -               pr_err("Process device data doesn't exist\n");
> +               dev_err(dev->adev->dev, "Process device data doesn't exis=
t\n");
>                 return ERR_PTR(-ENOMEM);
>         }
>
> @@ -1833,6 +1835,7 @@ int kfd_process_evict_queues(struct kfd_process *p,=
 uint32_t trigger)
>
>         for (i =3D 0; i < p->n_pdds; i++) {
>                 struct kfd_process_device *pdd =3D p->pdds[i];
> +               struct device *dev =3D pdd->dev->adev->dev;
>
>                 kfd_smi_event_queue_eviction(pdd->dev, p->lead_thread->pi=
d,
>                                              trigger);
> @@ -1844,7 +1847,7 @@ int kfd_process_evict_queues(struct kfd_process *p,=
 uint32_t trigger)
>                  * them been add back since they actually not be saved ri=
ght now.
>                  */
>                 if (r && r !=3D -EIO) {
> -                       pr_err("Failed to evict process queues\n");
> +                       dev_err(dev, "Failed to evict process queues\n");
>                         goto fail;
>                 }
>                 n_evicted++;
> @@ -1866,7 +1869,8 @@ int kfd_process_evict_queues(struct kfd_process *p,=
 uint32_t trigger)
>
>                 if (pdd->dev->dqm->ops.restore_process_queues(pdd->dev->d=
qm,
>                                                               &pdd->qpd))
> -                       pr_err("Failed to restore queues\n");
> +                       dev_err(pdd->dev->adev->dev,
> +                               "Failed to restore queues\n");
>
>                 n_evicted--;
>         }
> @@ -1882,13 +1886,14 @@ int kfd_process_restore_queues(struct kfd_process=
 *p)
>
>         for (i =3D 0; i < p->n_pdds; i++) {
>                 struct kfd_process_device *pdd =3D p->pdds[i];
> +               struct device *dev =3D pdd->dev->adev->dev;
>
>                 kfd_smi_event_queue_restore(pdd->dev, p->lead_thread->pid=
);
>
>                 r =3D pdd->dev->dqm->ops.restore_process_queues(pdd->dev-=
>dqm,
>                                                               &pdd->qpd);
>                 if (r) {
> -                       pr_err("Failed to restore process queues\n");
> +                       dev_err(dev, "Failed to restore process queues\n"=
);
>                         if (!ret)
>                                 ret =3D r;
>                 }
> @@ -2065,7 +2070,7 @@ int kfd_reserved_mem_mmap(struct kfd_node *dev, str=
uct kfd_process *process,
>         struct qcm_process_device *qpd;
>
>         if ((vma->vm_end - vma->vm_start) !=3D KFD_CWSR_TBA_TMA_SIZE) {
> -               pr_err("Incorrect CWSR mapping size.\n");
> +               dev_err(dev->adev->dev, "Incorrect CWSR mapping size.\n")=
;
>                 return -EINVAL;
>         }
>
> @@ -2077,7 +2082,8 @@ int kfd_reserved_mem_mmap(struct kfd_node *dev, str=
uct kfd_process *process,
>         qpd->cwsr_kaddr =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_Z=
ERO,
>                                         get_order(KFD_CWSR_TBA_TMA_SIZE))=
;
>         if (!qpd->cwsr_kaddr) {
> -               pr_err("Error allocating per process CWSR buffer.\n");
> +               dev_err(dev->adev->dev,
> +                       "Error allocating per process CWSR buffer.\n");
>                 return -ENOMEM;
>         }
>
> --
> 2.25.1
>
