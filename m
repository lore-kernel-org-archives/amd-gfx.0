Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B3AC531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 13:59:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12D610E781;
	Fri, 16 Aug 2024 13:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A5kmzkwY";
	dkim-atps=neutral
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6213B10E781
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 13:59:02 +0000 (UTC)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-202146e93f6so3047145ad.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 06:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723816742; x=1724421542; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ybh7qVXkF6FrRJrwQQqSjW6h0gVILHaktWL9jmuFlY=;
 b=A5kmzkwYncH0Gh7hnFVuihHKWgMN6yBPo7DpSr5ht9qjatS0TPwY9wb6iBIk4aeNLk
 IAmU7MDctBRVOuR5fb97J1s5T8OxR+yuUGWr9Nwuvz7UvqNZsy6QQ0Mh7t80uxttWqy8
 itLyBUgv8JmgPB3L577xsZikt0Q2qFrl9m5i0IcXtFgvGxYx/mwfQHeWyzX05aEop23f
 zYHafOCgamIdixhFE53GtvKc9uISGfKHOXzd8masIsKwB4AcP3SCzmE3pnWQdUgAi14W
 N5UQqcQYlhmaLpX/Klm6N5TCxNAE+8iO0kAcrUlfg/IwEcgrCl8WGyNyN9TD0FqMpwMY
 p9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723816742; x=1724421542;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ybh7qVXkF6FrRJrwQQqSjW6h0gVILHaktWL9jmuFlY=;
 b=PF2rIiPcZvd0WZwbm964uUVxUM9GjxTASoJ0ajMP61USov64zT4urSGSIylVyp0pag
 GzbvNDKYqRUfmidS6WUAiaruNUduCzkkAZFlwEXXi7NF3sW/Ke0UwcbmP6qCEVg8QU87
 Ls/nOSAd2C6uTUUIv1q5/zU2N8vcIQs+nKxKVWkfyOjpH0saZaqY1aHkstkVKrQYNCdn
 XBAj81QrJ6jg2Wm41m4MJ5eZ2tB/l2/SLihpm6EcC5RAmrTRPBBVU2YATz8O9I7GCp94
 5+tGv9c6foaz4I1aSj6TcZDk5byjpWYVZWuQnSZifCV4G8rVbXIZhXS3XowKfG4b4HHF
 t7Zg==
X-Gm-Message-State: AOJu0YyKKA8VtFknP8C9A0ErByFHQPD6XBItnw7RKsWsGzDNRf9+ogy3
 aC/0+Hfm2qu9GuRGgjo8ycoGkxoaxeJd/oYIK6aU4T9iUi4NMMgL0Ey/97oqQEPqOLxLrLdp/NR
 R4CfkqIQRVH0PGk/xu74Dyy49LdQ=
X-Google-Smtp-Source: AGHT+IEzsnvn37qNqgJ3MrlxLPEOsHLnCW4V+6TdlpC2EqssqhGxxM6PGWE2jee+xC9JHMJ00HolXTOF1iVk7sIIwfU=
X-Received: by 2002:a17:902:f988:b0:201:ff75:fa3a with SMTP id
 d9443c01a7336-20203ea01c9mr25818395ad.23.1723816741608; Fri, 16 Aug 2024
 06:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240816075447.442983-1-Trigger.Huang@amd.com>
 <20240816075447.442983-5-Trigger.Huang@amd.com>
In-Reply-To: <20240816075447.442983-5-Trigger.Huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 16 Aug 2024 09:58:49 -0400
Message-ID: <CADnq5_O340AzmjzDyJT+wrfC4nXUT6h6392+V+nSH2hL0AknGw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/amdgpu: Do core dump immediately when job tmo
To: Trigger.Huang@amd.com
Cc: amd-gfx@lists.freedesktop.org, sunil.khatri@amd.com, 
 alexander.deucher@amd.com
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

On Fri, Aug 16, 2024 at 4:05=E2=80=AFAM <Trigger.Huang@amd.com> wrote:
>
> From: Trigger Huang <Trigger.Huang@amd.com>
>
> Do the coredump immediately after a job timeout to get a closer
> representation of GPU's error status.
>
> V2: This will skip printing vram_lost as the GPU reset is not
> happened yet (Alex)
>
> Signed-off-by: Trigger Huang <Trigger.Huang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 64 +++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_job.c
> index c6a1783fc9ef..009551335d05 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -28,9 +28,63 @@
>  #include <drm/drm_drv.h>
>
>  #include "amdgpu.h"
> +#include "amdgpu_dev_coredump.h"
> +#include "amdgpu_xgmi.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_reset.h"
>
> +static void amdgpu_job_do_core_dump(struct amdgpu_device *adev,
> +                              struct amdgpu_job *job)
> +{
> +       int i =3D 0;
> +
> +       dev_info(adev->dev, "Dumping IP State\n");
> +       for (i =3D 0; i < adev->num_ip_blocks; i++) {
> +               if (adev->ip_blocks[i].version->funcs->dump_ip_state)
> +                       adev->ip_blocks[i].version->funcs
> +                               ->dump_ip_state((void *)adev);
> +               dev_info(adev->dev, "Dumping IP State Completed\n");
> +       }
> +
> +       amdgpu_coredump(adev, true, false, job);
> +}
> +
> +static void amdgpu_job_core_dump(struct amdgpu_device *adev, struct amdg=
pu_job *job)
> +{
> +       struct list_head device_list, *device_list_handle =3D  NULL;
> +       struct amdgpu_device *tmp_adev =3D NULL;
> +       struct amdgpu_hive_info *hive =3D NULL;
> +
> +       if (!amdgpu_sriov_vf(adev))
> +               hive =3D amdgpu_get_xgmi_hive(adev);
> +       if (hive)
> +               mutex_lock(&hive->hive_lock);
> +       /*
> +        * Reuse the logic in amdgpu_device_gpu_recover() to build list o=
f
> +        * devices for code dump
> +        */
> +       INIT_LIST_HEAD(&device_list);
> +       if (!amdgpu_sriov_vf(adev) && (adev->gmc.xgmi.num_physical_nodes =
> 1) && hive) {
> +               list_for_each_entry(tmp_adev, &hive->device_list, gmc.xgm=
i.head)
> +                       list_add_tail(&tmp_adev->reset_list, &device_list=
);
> +               if (!list_is_first(&adev->reset_list, &device_list))
> +                       list_rotate_to_front(&adev->reset_list, &device_l=
ist);
> +               device_list_handle =3D &device_list;
> +       } else {
> +               list_add_tail(&adev->reset_list, &device_list);
> +               device_list_handle =3D &device_list;
> +       }
> +
> +       /* Do the coredump for each device */
> +       list_for_each_entry(tmp_adev, device_list_handle, reset_list)
> +               amdgpu_job_do_core_dump(tmp_adev, job);
> +
> +       if (hive) {
> +               mutex_unlock(&hive->hive_lock);
> +               amdgpu_put_xgmi_hive(hive);
> +       }
> +}
> +
>  static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job =
*s_job)
>  {
>         struct amdgpu_ring *ring =3D to_amdgpu_ring(s_job->sched);
> @@ -48,6 +102,12 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(st=
ruct drm_sched_job *s_job)
>                 return DRM_GPU_SCHED_STAT_ENODEV;
>         }
>
> +       /*
> +        * Do the coredump immediately after a job timeout to get a close=
r
> +        * representation of GPU's error status.
> +        */
> +       if (amdgpu_gpu_coredump)
> +               amdgpu_job_core_dump(adev, job);
>
>         adev->job_hang =3D true;
>
> @@ -101,6 +161,10 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(s=
truct drm_sched_job *s_job)
>                 reset_context.src =3D AMDGPU_RESET_SRC_JOB;
>                 clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
>
> +               /* To avoid a double coredump, as we have already done it=
 */
> +               if (amdgpu_gpu_coredump)
> +                       set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flag=
s);
> +

I could go either way on this hunk.  Do you see any problems with a
double core dump?  We are effectively doing two resets...

Alex

>                 r =3D amdgpu_device_gpu_recover(ring->adev, job, &reset_c=
ontext);
>                 if (r)
>                         dev_err(adev->dev, "GPU Recovery Failed: %d\n", r=
);
> --
> 2.34.1
>
