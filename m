Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FA6D26D75
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 16:40:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA7FB10E906;
	Fri,  9 Jan 2026 16:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m8uGM0H+";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D2610E907
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 16:40:56 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-11bba84006dso397863c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Jan 2026 08:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767976856; x=1768581656; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h02mgWXp4oVAKUuIYByt434Zk7Q6pXpOhZ+bmCAVLaU=;
 b=m8uGM0H+3Uq8JUWNu0eP6LPAws1RbIzdsk3hII/mTtG2qOEjKM9GYYSsPRGZ0mDtUH
 9Ej7Lmn8RPw0TgIeQEYKGDN5W1yCiMu0QHRplD9KTmpY0heYUtvVDnFBhRvRTLcO84Ku
 31ogbjBrR6YVwEwmSzKoFvp16lGugqd+ONsTpswr0deK8SfbNK8csDsx9/UNHRgc+W2k
 Q7eMgwU7ZOzvnRnkqnrOhDCsdrvv+NW5Jxq/RyusrUxDB1myt7jiQS5+O5HCMZpPkhxm
 RUw7k0e6ULN7P3Tbz//jVhquEBH/WxTkigZWrSzMbRkZCX0UYPaZjaPwDeUmmTTxvjeF
 Zhdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767976856; x=1768581656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h02mgWXp4oVAKUuIYByt434Zk7Q6pXpOhZ+bmCAVLaU=;
 b=XsTG4mFG6Ejm0CW2hkphDxkVj2TqPB2wu6diRdRf56wpnSi+AURMh+S2XN9WGEIYBR
 aDa4MhGd2t/difucBQHPJriMSRU3CMPC9pY0N9lufWn2RYIOVG5hHXitfN1NYPVRH5qh
 +Q72MmxSmkc0AhiJl2JwUHfAD9nGFmGiB9g4+Ei9u15QDYlGtomGGIokpA8Y95Znhikk
 bdvIKAAtHgx5xcU4q5nQrcHRNjnsJ1tdLKUBHOSxIug6xHG2cv8HpTcB83x+j/b2kSfv
 ctFT7rl4sNdNYIQABVwqn/xSPojLhQ23lXzS9Y3TELAOalRIloDGIlOqZESGMkw4Zebk
 oDMA==
X-Gm-Message-State: AOJu0YyyDjP4UP0P3agwUpdH7/Olss4JP6D/0FE4FFe+DTKoX+5VgSpc
 qipjqW4OEaq23wkKPfgj8Zg24XKetZev5U6o4uY/oqrm9dExz0y3Y3uauiNcVHKTtqLKc8vlDQd
 mOdsqul5wJ0+2l2mZA6t/r+Rc/VUoQVM=
X-Gm-Gg: AY/fxX5gi18KyMbrYYT19C7fgsih6kjHlJs0ce8yq6M/pEt7Ga7mUFIPNMzwRJopYFM
 bTPHjBsbvfU9OyV1fQ9aRmWvFT+2D1/DVfJqLHMBy2JvwYdERhzc0cueBUbC4fUxDuX0v+dtHBP
 1Xh4UjxXzAou+Z0+TLRUNtpE3oF/WNwOzGSL6ESVa5bne4/qQEw/KKwwc9zf2C2rg4RvnO/NOjz
 kvl0P0iaSd9HOpcuK7fymWDZLVbO62+cYn9EGxRhMBQ5Y93ATc8JZC5UEwXVM95qOWI8p6X
X-Google-Smtp-Source: AGHT+IETZwhwDQJJdc8Qih/+/eCUPZhvl6yfq+Mk1JGs9qscdPmgoiEvxfC26Qa0zt90rPWze2fIdj8TrXzDWnuMlcs=
X-Received: by 2002:a05:7022:238b:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-121f8b45a84mr5272737c88.4.1767976855374; Fri, 09 Jan 2026
 08:40:55 -0800 (PST)
MIME-Version: 1.0
References: <20251205174647.492240-1-xiaogang.chen@amd.com>
In-Reply-To: <20251205174647.492240-1-xiaogang.chen@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Jan 2026 11:40:44 -0500
X-Gm-Features: AQt7F2rOXI3_RXZ3Stk81oCe4FvlO0pTUCMMlCcFZQQhg2I-k88G5y1tJ1f2hZA
Message-ID: <CADnq5_PBCTDh0H8mZ6UEOkvaUC52id1PjMNR5EKr1o3Cw1H51g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: kfd driver supports hot unplug/replug amdgpu
 devices
To: "Xiaogang.Chen" <xiaogang.chen@amd.com>
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

On Fri, Dec 5, 2025 at 12:54=E2=80=AFPM Xiaogang.Chen <xiaogang.chen@amd.co=
m> wrote:
>
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> This patch allows kfd driver function correctly when AMD gpu devices got
> unplug/replug at run time.
>
> When an AMD gpu device got unplug kfd driver gracefully terminates existi=
ng
> kfd processes after stops all queues by sending SIGBUS to user process. A=
fter
> that user space can still use remaining AMD gpu devices. When all AMD gpu
> devices at system got removed kfd driver will not response new requests.
>
> Unplugged AMD gpu devices can be re-plugged. kfd driver will use added de=
vices
> to function as usual.
>
> The purpose of this patch is having kfd driver behavior as expected durin=
g and
> after AMD gpu devices unplug/replug at run time.
>
> Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>

I'm not a KFD expert, but it looks correct to me.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  5 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h | 11 +++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  1 +
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 78 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 29 ++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  2 +
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 12 +++-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c  | 22 ++++++
>  8 files changed, 158 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index a2879d2b7c8e..622f613e7627 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -248,6 +248,11 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *a=
dev,
>                 kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
>  }
>
> +void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev)
> +{
> +       kgd2kfd_teardown_processes(adev);
> +}
> +
>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc=
)
>  {
>         if (adev->kfd.dev) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.h
> index 8bdfcde2029b..f79e20cadd70 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -155,6 +155,7 @@ struct amdkfd_process_info {
>
>  int amdgpu_amdkfd_init(void);
>  void amdgpu_amdkfd_fini(void);
> +void amdgpu_amdkfd_teardown_processes(struct amdgpu_device *adev);
>
>  void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool suspend_proc=
);
>  int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool resume_proc);
> @@ -434,6 +435,8 @@ int kgd2kfd_stop_sched_all_nodes(struct kfd_dev *kfd)=
;
>  bool kgd2kfd_compute_active(struct kfd_dev *kfd, uint32_t node_id);
>  bool kgd2kfd_vmfault_fast_path(struct amdgpu_device *adev, struct amdgpu=
_iv_entry *entry,
>                                bool retry_fault);
> +void kgd2kfd_lock_kfd(void);
> +void kgd2kfd_teardown_processes(struct amdgpu_device *adev);
>
>  #else
>  static inline int kgd2kfd_init(void)
> @@ -546,5 +549,13 @@ static inline bool kgd2kfd_vmfault_fast_path(struct =
amdgpu_device *adev, struct
>         return false;
>  }
>
> +void kgd2kfd_lock_kfd(void)
> +{
> +}
> +
> +void kgd2kfd_teardown_processes(struct amdgpu_device *adev)
> +{
> +}
> +
>  #endif
>  #endif /* AMDGPU_AMDKFD_H_INCLUDED */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index f75ede1b1c6b..dd8fc2d42b69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3663,6 +3663,7 @@ static int amdgpu_device_ip_fini_early(struct amdgp=
u_device *adev)
>         amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
>
>         amdgpu_amdkfd_suspend(adev, true);
> +       amdgpu_amdkfd_teardown_processes(adev);
>         amdgpu_userq_suspend(adev);
>
>         /* Workaround for ASICs need to disable SMC first */
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_device.c
> index e3da2f149ae6..30d87e4daad2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -936,6 +936,9 @@ void kgd2kfd_device_exit(struct kfd_dev *kfd)
>         }
>
>         kfree(kfd);
> +
> +       /* after remove a kfd device unlock kfd driver */
> +       kgd2kfd_unlock_kfd(NULL);
>  }
>
>  int kgd2kfd_pre_reset(struct kfd_dev *kfd,
> @@ -1519,10 +1522,14 @@ int kgd2kfd_check_and_lock_kfd(struct kfd_dev *kf=
d)
>         return r;
>  }
>
> +/* unlock a kfd dev or kfd driver */
>  void kgd2kfd_unlock_kfd(struct kfd_dev *kfd)
>  {
>         mutex_lock(&kfd_processes_mutex);
> -       --kfd->kfd_dev_lock;
> +       if (kfd)
> +               --kfd->kfd_dev_lock;
> +       else
> +               --kfd_locked;
>         mutex_unlock(&kfd_processes_mutex);
>  }
>
> @@ -1686,6 +1693,75 @@ bool kgd2kfd_vmfault_fast_path(struct amdgpu_devic=
e *adev, struct amdgpu_iv_entr
>         return false;
>  }
>
> +/* check if there is kfd process still uses adev */
> +static bool kgd2kfd_check_device_idle(struct amdgpu_device *adev) {
> +
> +       struct kfd_process *p;
> +       struct hlist_node *p_temp;
> +       unsigned int temp;
> +       struct kfd_node *dev;
> +
> +       mutex_lock(&kfd_processes_mutex);
> +
> +       if (hash_empty(kfd_processes_table)){
> +               mutex_unlock(&kfd_processes_mutex);
> +               return true;
> +       }
> +
> +       /* check if there is device still use adev */
> +       hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_proc=
esses) {
> +               for (int i =3D 0; i < p->n_pdds; i++) {
> +                       dev =3D p->pdds[i]->dev;
> +                       if (dev->adev =3D=3D adev){
> +                               mutex_unlock(&kfd_processes_mutex);
> +                               return false;
> +                       }
> +               }
> +       }
> +
> +       mutex_unlock(&kfd_processes_mutex);
> +
> +       return true;
> +}
> +
> +/** kgd2kfd_teardown_processes - gracefully tear down existing
> + *  kfd processes that use adev
> + *
> + * @adev: amdgpu_device where kfd processes run on and will be
> + *     teardown
> + *
> + */
> +void kgd2kfd_teardown_processes(struct amdgpu_device *adev) {
> +
> +       struct hlist_node *p_temp;
> +       struct kfd_process *p;
> +       struct kfd_node *dev;
> +       unsigned int temp;
> +
> +       mutex_lock(&kfd_processes_mutex);
> +
> +       if (hash_empty(kfd_processes_table)){
> +               mutex_unlock(&kfd_processes_mutex);
> +               return;
> +       }
> +
> +       hash_for_each_safe(kfd_processes_table, temp, p_temp, p, kfd_proc=
esses) {
> +               for (int i =3D 0; i < p->n_pdds; i++) {
> +                       dev =3D p->pdds[i]->dev;
> +                       if (dev->adev =3D=3D adev)
> +                               kfd_signal_process_terminate_event(p);
> +               }
> +       }
> +
> +       mutex_unlock(&kfd_processes_mutex);
> +
> +       /* wait all kfd processes use adev terminate */
> +       while (!kgd2kfd_check_device_idle(adev))
> +               cond_resched();
> +
> +       return;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  /* This function will send a package to HIQ to hang the HWS
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/am=
d/amdkfd/kfd_events.c
> index 5a190dd6be4e..ea913368e231 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -1380,3 +1380,32 @@ void kfd_signal_poison_consumed_event(struct kfd_n=
ode *dev, u32 pasid)
>
>         kfd_unref_process(p);
>  }
> +
> +/* signal KFD_EVENT_TYPE_SIGNAL events from process p
> + * send signal SIGBUS to correspondent user space process
> + */
> +void kfd_signal_process_terminate_event(struct kfd_process *p)
> +{
> +       struct kfd_event *ev;
> +       uint32_t id;
> +
> +       rcu_read_lock();
> +
> +       /* iterate from id 1 for KFD_EVENT_TYPE_SIGNAL events */
> +       id =3D 1;
> +       idr_for_each_entry_continue(&p->event_idr, ev, id)
> +               if (ev->type =3D=3D KFD_EVENT_TYPE_SIGNAL) {
> +                       spin_lock(&ev->lock);
> +                       set_event(ev);
> +                       spin_unlock(&ev->lock);
> +               }
> +
> +       /* Send SIGBUS to p->lead_thread */
> +       dev_notice(kfd_device,
> +                       "Sending SIGBUS to process %d",
> +                       p->lead_thread->pid);
> +
> +       send_sig(SIGBUS, p->lead_thread, 0);
> +
> +       rcu_read_unlock();
> +}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index 76842bb8e78b..d7b4aba0f488 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1177,6 +1177,7 @@ static inline struct kfd_node *kfd_node_by_irq_ids(=
struct amdgpu_device *adev,
>  }
>  int kfd_topology_enum_kfd_devices(uint8_t idx, struct kfd_node **kdev);
>  int kfd_numa_node_to_apic_id(int numa_node_id);
> +uint32_t kfd_gpu_node_num(void);
>
>  /* Interrupts */
>  #define        KFD_IRQ_FENCE_CLIENTID  0xff
> @@ -1529,6 +1530,7 @@ void kfd_signal_vm_fault_event(struct kfd_process_d=
evice *pdd,
>  void kfd_signal_reset_event(struct kfd_node *dev);
>
>  void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid);
> +void kfd_signal_process_terminate_event(struct kfd_process *p);
>
>  static inline void kfd_flush_tlb(struct kfd_process_device *pdd,
>                                  enum TLB_FLUSH_TYPE type)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index f5d173f1ca3b..5a74469f5bef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -854,6 +854,12 @@ struct kfd_process *kfd_create_process(struct task_s=
truct *thread)
>          */
>         mutex_lock(&kfd_processes_mutex);
>
> +       if (kfd_gpu_node_num() <=3D 0) {
> +               pr_warn("no gpu node! Cannot create KFD process");
> +               process =3D ERR_PTR(-EINVAL);
> +               goto out;
> +       }
> +
>         if (kfd_is_locked(NULL)) {
>                 pr_debug("KFD is locked! Cannot create process");
>                 process =3D ERR_PTR(-EINVAL);
> @@ -1176,7 +1182,6 @@ static void kfd_process_wq_release(struct work_stru=
ct *work)
>         if (ef)
>                 dma_fence_signal(ef);
>
> -       kfd_process_remove_sysfs(p);
>         kfd_debugfs_remove_process(p);
>
>         kfd_process_kunmap_signal_bo(p);
> @@ -1192,6 +1197,11 @@ static void kfd_process_wq_release(struct work_str=
uct *work)
>
>         put_task_struct(p->lead_thread);
>
> +       /* the last step is removing process entries under /sys
> +        * to indicate the process has been terminated.
> +        */
> +       kfd_process_remove_sysfs(p);
> +
>         kfree(p);
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index 5c98746eb72d..062ad5d40d62 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -2349,6 +2349,28 @@ int kfd_numa_node_to_apic_id(int numa_node_id)
>         return kfd_cpumask_to_apic_id(cpumask_of_node(numa_node_id));
>  }
>
> +/* kfd_gpu_node_num - Return kfd gpu node number at system */
> +uint32_t kfd_gpu_node_num(void) {
> +
> +       struct kfd_node *dev;
> +       uint8_t gpu_num  =3D 0;
> +       uint8_t id  =3D 0;
> +
> +       while (kfd_topology_enum_kfd_devices(id, &dev) =3D=3D 0) {
> +               if (!dev || kfd_devcgroup_check_permission(dev)) {
> +                       /* Skip non GPU devices and devices to which the
> +                        * current process have no access to
> +                        */
> +                       id++;
> +                       continue;
> +               }
> +               id++;
> +               gpu_num++;
> +       }
> +
> +       return gpu_num;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  int kfd_debugfs_hqds_by_device(struct seq_file *m, void *data)
> --
> 2.34.1
>
