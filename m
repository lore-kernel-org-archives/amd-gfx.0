Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67466C55ABA
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 21:57:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F272210E04B;
	Tue,  4 Aug 2026 21:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h9JMYr89";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1A4110E107
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 21:57:21 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-384caf7b168so47760a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Aug 2026 14:57:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785880641; cv=none;
 d=google.com; s=arc-20260327;
 b=GScoPsCU7daQUSQioKOmSnhAmRxY32DRxHQa5JUSKDTjGdOak2BOFTts5g9tRcXppF
 tLZeTCiocMmOy6baYFS4gPXdzwjxDpak3KreT+s3PsVXI16dc8Ekn3av8cqQTmXq/xKX
 giOn4AX08YB4fVVDTSRJum2/rXQYY1Jmxbg4X+/ilOCTAPkx/CqozYWf9MFvmuuLOoW9
 rJQFzPJcZq3uN0fXZbaCccda88uZgY/eCP0ZpkqtvxvOqbKGwYOMRkhzDn8kYrM6ZpMk
 omORX/+vrRK5g6FCimGLdo+ZiTN8kwpETuPG1Nv1ef8LTjPjfv/GmMQHSsNJWh3S5+aY
 OfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DZCk2e8dwgZnA2wgJ0j/ulU+fauL+W7qNr0/bunW0NY=;
 fh=YFqqTxdR3R9j06ZYM4qB+o3OGNiDDAN5wTvPWvcIcoo=;
 b=hHitdaCHyt3Emfcu8PcRC4d7KlXP9n6LEQz+gZJaAbG8RdJC47LUpMt7SQ68UOLKQr
 Anu5Vh+hVabjg3l26t0ReIS9eCZk7sNf9dXz9wvDbGsgmCysdEBQlEkEJRCpt/pMy+B6
 Z2NjQD4nNrw762Mp+5Meisjny79fM/3w46rAhO9I63vZqMDbn0QdpzWL1Xwpa29LWU1b
 jL6F+QcBWTF3xOygASb5oiwYe3XLIrwioplzgw09/JMGPbZ6feDtoQiA7n+Ji/2UAHhP
 ZQVhRF8rq4mOmFE/+DKRhQ80PF4BUDmR0/if12ME+tJseWOcJIaWX6gsUJl1xdKwhQVz
 V3ZQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785880641; x=1786485441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DZCk2e8dwgZnA2wgJ0j/ulU+fauL+W7qNr0/bunW0NY=;
 b=h9JMYr898bVmMBHqWmNX158V03hYoFa4EQ7ra4YMQCu/ywXAXhdmYqSqOFNZuQqove
 6p60wYs93rBL1TaDk35GHPEt9hFVahYy+NqtCpHMviXbse73P9si4Rj+iP/r3j1rGxT/
 1pNQ1O+VNJwjpyLAiX7AWL+Sjas1RNFGgwxUYEBNozXY+RpgYyvhqlBJzxXhJprmaG2u
 pHg7cdNTjlCFCqgdg1YiBIQ/B57x6f/9LqHrpx/a2xp8Wf36Y4MS1eTzQ7eaW6ONJzWf
 Hq44afSfnt5DG3d0JKMUwYpD2giFh7BcvtR9oAyhOBYMroWEq0luuYk8FtJgst40rWAk
 5QuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785880641; x=1786485441;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DZCk2e8dwgZnA2wgJ0j/ulU+fauL+W7qNr0/bunW0NY=;
 b=r7aThEoW9IVPzhjbS6GM01gTResQ+Y+9ZTEjsrVWpq0A01gTaPmwFmOCP79KPQtxBC
 D6qNDoA0sly5JEM8z0A4CiHqBRYVvWkSzED8TOZaQCJ9JI0vREIz1Gb7wjpXbJwCMhU1
 NKXObg7Mj035hJxGR+8iu3mqOg/2oxgGv6J6EDKysZAiWgbGAiZnN4XNZEhgVDPI0PM2
 CJooTfrD+mTY6pfHaiz4LMrfeg0AwgEX1mRCfbdHAKj/A+p0NVGjUm6N1s06DFku0jAw
 dG5Kvfjszg6J59lfENKXHu6XoV7hfLwFJkzSjEGKny4IsdNXg4V/O4DVrVSfXL5K5HpJ
 ISHg==
X-Gm-Message-State: AOJu0YyFdPufFBcsQhv9qfBCqKl4wVL/K5CRZMbMa/LjqnOZJQ3izUg2
 Kn9tJrOAsNhfGqaqr1OTXK4Gw4aWhIhCSLrTkI/cdb+vMkxh0ti3oQx5IXE7J9+87Wx6qlKeMh5
 qMM+xsofg5sAS6873zIDx4CK6cgWqRJ3eKgEF
X-Gm-Gg: AR+sD12JZ5IpG/f6xv6cTN0ctTfKHSLWUvjn7dlM6jRFH5IOa9V1V8C05pKLxCx5PK3
 4Fkpes4a64A6En9X6GvLkcO2D9AXM0XPNx1/8iKrnTCR49COsQIP27wQpvFKUVqibqaDar5uGaE
 ktR8mLyzTEkNlKfjaZO4Q+whqPpnT6/vi6b0wt9clBURVKfGKvyMDmyNPAFp/q8pKbXwBAbmh0u
 tPuVCkcJ8h2uPXlIO/Z5yOOwRTJD0ual1MDGcDZkp8RSCo9RXjlU2uVav9I9gS+gskDlatULfKN
 EhQoSKWAKjve3Y/fNl/N6TxLvrBEIKDzqBoKwXl+qms22qAzuXO4y9zaCRKMc0Sfji/J5Gyi1yE
 fkotfXN5dFBdwTjehJVS9q869Sl+Qo0c=
X-Received: by 2002:a17:90b:3f48:b0:383:5a16:bd67 with SMTP id
 98e67ed59e1d1-3903c783fc7mr1457865a91.4.1785880641304; Tue, 04 Aug 2026
 14:57:21 -0700 (PDT)
MIME-Version: 1.0
References: <SA1PR12MB8600E8B1821FA7D76923FC259FD42@SA1PR12MB8600.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB8600E8B1821FA7D76923FC259FD42@SA1PR12MB8600.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Aug 2026 17:57:08 -0400
X-Gm-Features: AUfX_mws7C3uzMNbZq1X5Xe6AzFYAO2zS2dLYDUhAsh-V9OStq2K7KHMEOIjdbw
Message-ID: <CADnq5_Ok1WnPpw0obZg5ErSgpK1dKJsvGxAPH-dMJmNbAjFMkQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix NULL pointer dereference in GFX12 CRIU
 queue restore
To: "Marioukhine, Vladimir" <Vladimir.Marioukhine@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
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

On Tue, Aug 4, 2026 at 3:33=E2=80=AFPM Marioukhine, Vladimir
<Vladimir.Marioukhine@amd.com> wrote:
>
> AMD General
>
>
> kfd_mqd_manager_v12.c (GFX 12.0) and kfd_mqd_manager_v12_1.c (GFX 12.1)
>
> initialize their MQD managers without assigning restore_mqd or checkpoint=
_mqd
>
> callbacks, leaving both function pointers NULL.
>
>
>
> Both create_queue_cpsch() and create_queue_nocpsch() in
>
> kfd_device_queue_manager.c unconditionally call mqd_mgr->restore_mqd() wh=
en
>
> a CRIU restore is in progress (qd !=3D NULL), with no NULL guard. On any =
system
>
> with a GFX 12.x GPU, a user holding CAP_CHECKPOINT_RESTORE can trigger a
>
> kernel NULL pointer dereference and panic the machine by issuing
>
> KFD_IOC_CRIU_OP_RESTORE with a crafted queue restore object.
>
>
>
> Fix this by:
>
> 1. Implementing restore_mqd and checkpoint_mqd callbacks for both compute
>
>    and SDMA queues in kfd_mqd_manager_v12.c and kfd_mqd_manager_v12_1.c,
>
>    modeled after the GFX 11 implementation.
>
> 2. Adding a NULL guard at both call sites in kfd_device_queue_manager.c
>
>    as a defensive measure against future regressions.
>
>
>
> Fixes: 48f0bdf4e38e ("drm/amdkfd: Added MQD manager files for GFX12.")
>
> Fixes: 01bbc4a4b947 ("drm/amdkfd: Add MQD manager for GFX 12.1.0")
>
> Signed-off-by: Vladimir Marioukhine <Vladimir.Marioukhine@amd.com>
>
> ---
>
> drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 10 ++++--
>
> drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c      | 69 ++++++++++++++=
+++++++++++++++++++++++++
>
> drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    | 69 ++++++++++++++=
++++++++++++++++++++++++
>
> 3 files changed, 146 insertions(+), 2 deletions(-)
>
>
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>
> index 51ee9c39104b..31bf479212e5 100644
>
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
>
> @@ -794,11 +794,16 @@ static int create_queue_nocpsch(struct device_queue=
_manager *dqm,
>
>                 goto out_deallocate_doorbell;
>
>         }
>
>
>
> -       if (qd)
>
> +       if (qd) {
>
> +               if (!mqd_mgr->restore_mqd) {
>
> +                       pr_err("amdkfd: restore_mqd not implemented for t=
his GPU\n");
>
> +                       retval =3D -EINVAL;
>
> +                       goto out_deallocate_doorbell;
>
> +                }
>
>                 mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q=
->gart_mqd_addr,
>
>                                      &q->properties, restore_mqd, restore=
_ctl_stack,
>
>                                      qd->ctl_stack_size);
>
> -       else
>
> +       } else
>

Kernel coding style requires converting all clauses to using parens.


>                 mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>
>                                         &q->gart_mqd_addr, &q->properties=
);
>
>
>
> @@ -2153,11 +2158,16 @@ static int create_queue_cpsch(struct device_queue=
_manager *dqm, struct queue *q,
>
>         q->properties.is_dbg_wa =3D qpd->pqm->process->debug_trap_enabled=
 &&
>
>                                   kfd_dbg_has_cwsr_workaround(q->device);
>
>
>
> -       if (qd)
>
> +       if (qd) {
>
> +               if (!mqd_mgr->restore_mqd) {
>
> +                       pr_err("amdkfd: restore_mqd not implemented for t=
his GPU\n");
>
> +                       retval =3D -EINVAL;
>
> +                       goto out;
>
> +                }
>
>                 mqd_mgr->restore_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj, &q=
->gart_mqd_addr,
>
>                                      &q->properties, restore_mqd, restore=
_ctl_stack,
>
>                                      qd->ctl_stack_size);
>
> -       else
>
> +       } else

Same here.  With those fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
>                 mqd_mgr->init_mqd(mqd_mgr, &q->mqd, q->mqd_mem_obj,
>
>                                         &q->gart_mqd_addr, &q->properties=
);
>
>
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>
> index 7c387fa90076..c6a8e99ad069 100644
>
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
>
> @@ -380,6 +380,75 @@ static int debugfs_show_mqd_sdma(struct seq_file *m,=
 void *data)
>
>
>
> #endif
>
>
>
> +static void checkpoint_mqd(struct mqd_manager *mm, void *mqd,
>
> +                           void *mqd_dst, void *ctl_stack_dst)
>
> +{
>
> +       struct v12_compute_mqd *m;
>
> +
>
> +       m =3D get_mqd(mqd);
>
> +
>
> +       memcpy(mqd_dst, m, sizeof(struct v12_compute_mqd));
>
> +}
>
> +
>
> +static void restore_mqd(struct mqd_manager *mm, void **mqd,
>
> +                        struct kfd_mem_obj *mqd_mem_obj, uint64_t *gart_=
addr,
>
> +                        struct queue_properties *qp, const void *mqd_src=
,
>
> +                        const void *ctl_stack_src, const u32 ctl_stack_s=
ize)
>
> +{
>
> +       uint64_t addr;
>
> +       struct v12_compute_mqd *m;
>
> +
>
> +       m =3D (struct v12_compute_mqd *) mqd_mem_obj->cpu_ptr;
>
> +       addr =3D mqd_mem_obj->gpu_addr;
>
> +
>
> +       memcpy(m, mqd_src, sizeof(*m));
>
> +
>
> +       *mqd =3D m;
>
> +       if (gart_addr)
>
> +               *gart_addr =3D addr;
>
> +
>
> +       m->cp_hqd_pq_doorbell_control =3D
>
> +               qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_=
OFFSET__SHIFT;
>
> +       pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doorbe=
ll_control);
>
> +
>
> +       qp->is_active =3D 0;
>
> +}
>
> +
>
> +static void checkpoint_mqd_sdma(struct mqd_manager *mm, void *mqd,
>
> +                                void *mqd_dst, void *ctl_stack_dst)
>
> +{
>
> +       struct v12_sdma_mqd *m;
>
> +
>
> +       m =3D get_sdma_mqd(mqd);
>
> +
>
> +       memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));
>
> +}
>
> +
>
> +static void restore_mqd_sdma(struct mqd_manager *mm, void **mqd,
>
> +                             struct kfd_mem_obj *mqd_mem_obj, uint64_t *=
gart_addr,
>
> +                             struct queue_properties *qp,
>
> +                             const void *mqd_src,
>
> +                             const void *ctl_stack_src,
>
> +                             const u32 ctl_stack_size)
>
> +{
>
> +       uint64_t addr;
>
> +       struct v12_sdma_mqd *m;
>
> +
>
> +       m =3D (struct v12_sdma_mqd *) mqd_mem_obj->cpu_ptr;
>
> +       addr =3D mqd_mem_obj->gpu_addr;
>
> +
>
> +       memcpy(m, mqd_src, sizeof(*m));
>
> +
>
> +       m->sdmax_rlcx_doorbell_offset =3D
>
> +               qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET_=
_SHIFT;
>
> +
>
> +       *mqd =3D m;
>
> +       if (gart_addr)
>
> +               *gart_addr =3D addr;
>
> +
>
> +       qp->is_active =3D 0;
>
> +}
>
> +
>
> struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD_TYPE type,
>
>                 struct kfd_node *dev)
>
> {
>
> @@ -407,6 +476,8 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD=
_TYPE type,
>
>                 mqd->mqd_size =3D sizeof(struct v12_compute_mqd);
>
>                 mqd->get_wave_state =3D get_wave_state;
>
>                 mqd->mqd_stride =3D kfd_mqd_stride;
>
> +               mqd->checkpoint_mqd =3D checkpoint_mqd;
>
> +               mqd->restore_mqd =3D restore_mqd;
>
> #if defined(CONFIG_DEBUG_FS)
>
>                 mqd->debugfs_show_mqd =3D debugfs_show_mqd;
>
> #endif
>
> @@ -453,6 +524,8 @@ struct mqd_manager *mqd_manager_init_v12(enum KFD_MQD=
_TYPE type,
>
>                 mqd->is_occupied =3D kfd_is_occupied_sdma;
>
>                 mqd->mqd_size =3D sizeof(struct v12_sdma_mqd);
>
>                 mqd->mqd_stride =3D kfd_mqd_stride;
>
> +               mqd->checkpoint_mqd =3D checkpoint_mqd_sdma;
>
> +               mqd->restore_mqd =3D restore_mqd_sdma;
>
> #if defined(CONFIG_DEBUG_FS)
>
>                 mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;
>
> #endif
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
>
> index 431a940f91f3..7ee98ef084ea 100644
>
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
>
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
>
> @@ -641,6 +641,75 @@ static int debugfs_show_mqd_sdma(struct seq_file *m,=
 void *data)
>
>
>
> #endif
>
>
>
> +static void checkpoint_mqd_v12_1(struct mqd_manager *mm, void *mqd,
>
> +                                 void *mqd_dst, void *ctl_stack_dst)
>
> +{
>
> +       struct v12_1_compute_mqd *m;
>
> +
>
> +       m =3D get_mqd(mqd);
>
> +
>
> +       memcpy(mqd_dst, m, sizeof(struct v12_1_compute_mqd));
>
> +}
>
> +
>
> +static void restore_mqd_v12_1(struct mqd_manager *mm, void **mqd,
>
> +                              struct kfd_mem_obj *mqd_mem_obj, uint64_t =
*gart_addr,
>
> +                              struct queue_properties *qp, const void *m=
qd_src,
>
> +                              const void *ctl_stack_src, const u32 ctl_s=
tack_size)
>
> +{
>
> +       uint64_t addr;
>
> +       struct v12_1_compute_mqd *m;
>
> +
>
> +       m =3D (struct v12_1_compute_mqd *) mqd_mem_obj->cpu_ptr;
>
> +       addr =3D mqd_mem_obj->gpu_addr;
>
> +
>
> +       memcpy(m, mqd_src, sizeof(*m));
>
> +
>
> +       *mqd =3D m;
>
> +       if (gart_addr)
>
> +               *gart_addr =3D addr;
>
> +
>
> +       m->cp_hqd_pq_doorbell_control =3D
>
> +               qp->doorbell_off << CP_HQD_PQ_DOORBELL_CONTROL__DOORBELL_=
OFFSET__SHIFT;
>
> +       pr_debug("cp_hqd_pq_doorbell_control 0x%x\n", m->cp_hqd_pq_doorbe=
ll_control);
>
> +
>
> +       qp->is_active =3D 0;
>
> +}
>
> +
>
> +static void checkpoint_mqd_sdma_v12_1(struct mqd_manager *mm, void *mqd,
>
> +                                      void *mqd_dst, void *ctl_stack_dst=
)
>
> +{
>
> +       struct v12_sdma_mqd *m;
>
> +
>
> +       m =3D get_sdma_mqd(mqd);
>
> +
>
> +       memcpy(mqd_dst, m, sizeof(struct v12_sdma_mqd));
>
> +}
>
> +
>
> +static void restore_mqd_sdma_v12_1(struct mqd_manager *mm, void **mqd,
>
> +                                   struct kfd_mem_obj *mqd_mem_obj, uint=
64_t *gart_addr,
>
> +                                   struct queue_properties *qp,
>
> +                                   const void *mqd_src,
>
> +                                   const void *ctl_stack_src,
>
> +                                   const u32 ctl_stack_size)
>
> +{
>
> +       uint64_t addr;
>
> +       struct v12_sdma_mqd *m;
>
> +
>
> +       m =3D (struct v12_sdma_mqd *) mqd_mem_obj->cpu_ptr;
>
> +       addr =3D mqd_mem_obj->gpu_addr;
>
> +
>
> +       memcpy(m, mqd_src, sizeof(*m));
>
> +
>
> +       m->sdmax_rlcx_doorbell_offset =3D
>
> +               qp->doorbell_off << SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET_=
_SHIFT;
>
> +
>
> +       *mqd =3D m;
>
> +       if (gart_addr)
>
> +               *gart_addr =3D addr;
>
> +
>
> +       qp->is_active =3D 0;
>
> +}
>
> +
>
> struct mqd_manager *mqd_manager_init_v12_1(enum KFD_MQD_TYPE type,
>
>                 struct kfd_node *dev)
>
> {
>
> @@ -668,6 +737,8 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_M=
QD_TYPE type,
>
>                 mqd->mqd_size =3D sizeof(struct v12_1_compute_mqd);
>
>                 mqd->get_wave_state =3D get_wave_state_v12_1;
>
>                 mqd->mqd_stride =3D kfd_mqd_stride;
>
> +               mqd->checkpoint_mqd =3D checkpoint_mqd_v12_1;
>
> +               mqd->restore_mqd =3D restore_mqd_v12_1;
>
> #if defined(CONFIG_DEBUG_FS)
>
>                 mqd->debugfs_show_mqd =3D debugfs_show_mqd;
>
> #endif
>
> @@ -714,6 +785,8 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_M=
QD_TYPE type,
>
>                 mqd->is_occupied =3D kfd_is_occupied_sdma;
>
>                 mqd->mqd_size =3D sizeof(struct v12_sdma_mqd);
>
>                 mqd->mqd_stride =3D kfd_mqd_stride;
>
> +               mqd->checkpoint_mqd =3D checkpoint_mqd_sdma_v12_1;
>
> +               mqd->restore_mqd =3D restore_mqd_sdma_v12_1;
>
> #if defined(CONFIG_DEBUG_FS)
>
>                 mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;
>
> #endif
