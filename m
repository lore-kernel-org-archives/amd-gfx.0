Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D03DC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 18:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 213DB10E183;
	Thu, 15 Aug 2024 18:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Hg+1Eady";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2EEC10E183
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 18:15:56 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-1ff67158052so9239105ad.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723745756; x=1724350556; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ij67nvqjleJFyX12s+34/Z3BY2ns0p3dNg8zk+iNHy0=;
 b=Hg+1EadyfXD2REYuZy6klMgtZvICAq5dvKrLbJDvITf0W8UY8M4HcShOZ60nMWJ77R
 NYgmYY2VCEO8shk1+NWFD0jDlNAMzgtWVVUXANuRfqUxd26vfnC2VzrOur5TgjyOsfH6
 44evr+/11BUO9u9gZVZ6NxAOFqJR2A7R03Wg/rYMg6UhwWAi5dG3F08EIUgstUdEdMol
 k9mF+SC+a+2sduHCUy7QEOUe5crFAMLbZFBLVOVBFcBFCGuPiQCufBQNmpqbRiS5bneE
 qJfte8XopqKzoFG8YYyUVK7I8ILYk6lFoP4QDsvPQmvtwrQNVzyLj7cJgg7VSYmZlpBS
 wEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723745756; x=1724350556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ij67nvqjleJFyX12s+34/Z3BY2ns0p3dNg8zk+iNHy0=;
 b=uo8hqQ+kZbwDbF3npJ8lVno70XiVC2N2WOIhHx375om5CNdHk+ZEKBND2aLFA+Xy2y
 t37ubMrcWGaBVtbRJn2PsAy9g7blC5zsNutBwkA28JEqIYNGai2VBb1s7QVBaQ8DfGnc
 +wpXdzejNRRln3D3mhLiNST3MPgu04mOHvdWRDXng7R7u5UG09eiuTognPT2lZ3zczCe
 Y4NBSC3ZjLt7Yo9Tlo0Sgp6Yf99Uo/45Xjpf42lpdwg2OnU3OR2k06IQh5BeboMe8E7p
 axgktCN8gSks/37h1IoM7uLj0cURGWWOT9kUQfuoKdirNQj+AChvhoDn+fm/hNjKf2n5
 ZpGg==
X-Gm-Message-State: AOJu0YzZBxmZwrIIK5S7hKelY0z8QECim73DjieFL3Asu9793NPaCaMK
 Xs/E6ppIcH/GCyVFNZR6bNKFJAT0MAyN4GHjtwKEVBEf1g0HRmKNCU2a4DqC3tO7WlnJPMeGnvy
 djzANEsaDSLqyHWP+ydmsZH2smAY=
X-Google-Smtp-Source: AGHT+IEIMTSu8UYROMeLeoeVI8CDXTYbYwMKyPtwTDT5uLJ/PndZ6tp4HBvC6jwooCCvAWjsh1ltsaPGPJk+pgeZy6I=
X-Received: by 2002:a17:902:f60f:b0:1fb:72b4:8775 with SMTP id
 d9443c01a7336-20203f27dadmr8008625ad.40.1723745756241; Thu, 15 Aug 2024
 11:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240814232754.1119319-1-mukul.joshi@amd.com>
In-Reply-To: <20240814232754.1119319-1-mukul.joshi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Aug 2024 14:15:44 -0400
Message-ID: <CADnq5_MbUsY2MyoUZzPwM+gothLHCO=x49cWj0s5c2Q70yE0dg@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] drm/amdgpu: Implement MES Suspend and Resume APIs
 for GFX11
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Felix.Kuehling@amd.com, 
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

On Wed, Aug 14, 2024 at 7:28=E2=80=AFPM Mukul Joshi <mukul.joshi@amd.com> w=
rote:
>
> Add implementation for MES Suspend and Resume APIs to unmap/map
> all queues for GFX11. Support for GFX12 will be added when the
> corresponding firmware support is in place.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v1->v2:
> - Add MES FW version check.
> - Update amdgpu_mes_suspend/amdgpu_mes_resume handling.
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 71 +++++++++++++------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  2 +
>  drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 32 ++++++++++-
>  3 files changed, 69 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index c598c3edff7e..e551943da77a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -501,60 +501,50 @@ int amdgpu_mes_remove_gang(struct amdgpu_device *ad=
ev, int gang_id)
>
>  int amdgpu_mes_suspend(struct amdgpu_device *adev)
>  {
> -       struct idr *idp;
> -       struct amdgpu_mes_process *process;
> -       struct amdgpu_mes_gang *gang;
>         struct mes_suspend_gang_input input;
> -       int r, pasid;
> +       int r;
> +
> +       if (!amdgpu_mes_suspend_resume_all_supported(adev))
> +               return 0;
> +
> +       memset(&input, 0x0, sizeof(struct mes_suspend_gang_input));
> +       input.suspend_all_gangs =3D 1;
>
>         /*
>          * Avoid taking any other locks under MES lock to avoid circular
>          * lock dependencies.
>          */
>         amdgpu_mes_lock(&adev->mes);
> -
> -       idp =3D &adev->mes.pasid_idr;
> -
> -       idr_for_each_entry(idp, process, pasid) {
> -               list_for_each_entry(gang, &process->gang_list, list) {
> -                       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &=
input);
> -                       if (r)
> -                               DRM_ERROR("failed to suspend pasid %d gan=
gid %d",
> -                                        pasid, gang->gang_id);
> -               }
> -       }
> -
> +       r =3D adev->mes.funcs->suspend_gang(&adev->mes, &input);
>         amdgpu_mes_unlock(&adev->mes);
> -       return 0;
> +       if (r)
> +               DRM_ERROR("failed to suspend all gangs");
> +
> +       return r;
>  }
>
>  int amdgpu_mes_resume(struct amdgpu_device *adev)
>  {
> -       struct idr *idp;
> -       struct amdgpu_mes_process *process;
> -       struct amdgpu_mes_gang *gang;
>         struct mes_resume_gang_input input;
> -       int r, pasid;
> +       int r;
> +
> +       if (!amdgpu_mes_suspend_resume_all_supported(adev))
> +               return 0;
> +
> +       memset(&input, 0x0, sizeof(struct mes_resume_gang_input));
> +       input.resume_all_gangs =3D 1;
>
>         /*
>          * Avoid taking any other locks under MES lock to avoid circular
>          * lock dependencies.
>          */
>         amdgpu_mes_lock(&adev->mes);
> -
> -       idp =3D &adev->mes.pasid_idr;
> -
> -       idr_for_each_entry(idp, process, pasid) {
> -               list_for_each_entry(gang, &process->gang_list, list) {
> -                       r =3D adev->mes.funcs->resume_gang(&adev->mes, &i=
nput);
> -                       if (r)
> -                               DRM_ERROR("failed to resume pasid %d gang=
id %d",
> -                                        pasid, gang->gang_id);
> -               }
> -       }
> -
> +       r =3D adev->mes.funcs->resume_gang(&adev->mes, &input);
>         amdgpu_mes_unlock(&adev->mes);
> -       return 0;
> +       if (r)
> +               DRM_ERROR("failed to resume all gangs");
> +
> +       return r;
>  }
>
>  static int amdgpu_mes_queue_alloc_mqd(struct amdgpu_device *adev,
> @@ -1608,6 +1598,19 @@ int amdgpu_mes_init_microcode(struct amdgpu_device=
 *adev, int pipe)
>         return r;
>  }
>
> +bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)
> +{
> +       uint32_t mes_rev =3D adev->mes.sched_version & AMDGPU_MES_VERSION=
_MASK;
> +       bool is_supported =3D false;
> +
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 0)=
 &&
> +           amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(12, 0, 0) &&
> +           mes_rev >=3D 0x63)
> +               is_supported =3D true;
> +
> +       return is_supported;
> +}
> +
>  #if defined(CONFIG_DEBUG_FS)
>
>  static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *u=
nused)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.h
> index 548e724e3a75..b2db62e50454 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -494,4 +494,6 @@ static inline void amdgpu_mes_unlock(struct amdgpu_me=
s *mes)
>         memalloc_noreclaim_restore(mes->saved_flags);
>         mutex_unlock(&mes->mutex_hidden);
>  }
> +
> +bool amdgpu_mes_suspend_resume_all_supported(struct amdgpu_device *adev)=
;
>  #endif /* __AMDGPU_MES_H__ */
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index c0340ee3dec0..a5c582674db9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -421,13 +421,41 @@ static int mes_v11_0_unmap_legacy_queue(struct amdg=
pu_mes *mes,
>  static int mes_v11_0_suspend_gang(struct amdgpu_mes *mes,
>                                   struct mes_suspend_gang_input *input)
>  {
> -       return 0;
> +       union MESAPI__SUSPEND mes_suspend_gang_pkt;
> +
> +       memset(&mes_suspend_gang_pkt, 0, sizeof(mes_suspend_gang_pkt));
> +
> +       mes_suspend_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_suspend_gang_pkt.header.opcode =3D MES_SCH_API_SUSPEND;
> +       mes_suspend_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_suspend_gang_pkt.suspend_all_gangs =3D input->suspend_all_gan=
gs;
> +       mes_suspend_gang_pkt.gang_context_addr =3D input->gang_context_ad=
dr;
> +       mes_suspend_gang_pkt.suspend_fence_addr =3D input->suspend_fence_=
addr;
> +       mes_suspend_gang_pkt.suspend_fence_value =3D input->suspend_fence=
_value;
> +
> +       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                       &mes_suspend_gang_pkt, sizeof(mes_suspend_gang_pk=
t),
> +                       offsetof(union MESAPI__SUSPEND, api_status));
>  }
>
>  static int mes_v11_0_resume_gang(struct amdgpu_mes *mes,
>                                  struct mes_resume_gang_input *input)
>  {
> -       return 0;
> +       union MESAPI__RESUME mes_resume_gang_pkt;
> +
> +       memset(&mes_resume_gang_pkt, 0, sizeof(mes_resume_gang_pkt));
> +
> +       mes_resume_gang_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +       mes_resume_gang_pkt.header.opcode =3D MES_SCH_API_RESUME;
> +       mes_resume_gang_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +       mes_resume_gang_pkt.resume_all_gangs =3D input->resume_all_gangs;
> +       mes_resume_gang_pkt.gang_context_addr =3D input->gang_context_add=
r;
> +
> +       return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +                       &mes_resume_gang_pkt, sizeof(mes_resume_gang_pkt)=
,
> +                       offsetof(union MESAPI__RESUME, api_status));
>  }
>
>  static int mes_v11_0_query_sched_status(struct amdgpu_mes *mes)
> --
> 2.35.1
>
