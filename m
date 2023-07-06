Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64AAEB64D9
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jul 2023 17:36:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541F610E469;
	Thu,  6 Jul 2023 17:36:17 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E86B10E469
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jul 2023 17:36:14 +0000 (UTC)
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-1b06da65bdbso936632fac.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jul 2023 10:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688664973; x=1691256973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r/3sez1nx3dYw3gcyn+ux+WQxixCgqiy6ykJvdwozQU=;
 b=W8i2w3SbSGayVOGqOQ+V/T57rG/7Tar7oqccK54UHB1HBVxBZUJtZeDV5E5yvu6grh
 toc1TvdpbT1EAgMN2sy888kZ7bU/4x45Du9hDwxekPI4OQwICk8DecxNRCePpqc8wQTA
 gf+jpQRmeCNUAPbeqniGDCH+qZDg/vropjzj0+XnCTYRf7MoApUgBFPhgeg/2d7CuSDS
 PrR4dw+KWu8VvXgHKytNWuFIgAfysQQj34IwrVoaY6rBvtcj5CTbqK9Xi2o4Rnhca1eu
 HKSnqsN1j4hqDDiG3fFbuMx8s8mtjZMuvoycTWgLffZTuvYCjWGqhkKhTIvdgVWB3rzt
 Vrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688664973; x=1691256973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/3sez1nx3dYw3gcyn+ux+WQxixCgqiy6ykJvdwozQU=;
 b=Y/ezwXvfwgIInrNf624DaN9VMDtXfToaptIwzp/rMADJtxhuUajibjUKyeGdAAiX2u
 9bymWUaI47I5jSCt5RMGPiFe8+NVYOAZ3h//jDYVSZ9PcZfTmVB6Dd67f2r7feFOXzfI
 gH/G1RSwd11CZ8+OIs2mr0K5h3T4UGZVGm/v1pz94pyhjTryOwWJ+H4dAddmBZJZF4MU
 Oavn3vvHb0DXvmXtz1T704+4y9g1CnfhOZpnn9oMrTS47gtQDNZv/J79U4F0sEYE2fUO
 6Pc5y+fqYGh49aXBqi6OwTHyfqcN64mPbMw2OIMJRjrSRxbLSkI6fGR22GPKD8HGvn03
 OHcA==
X-Gm-Message-State: ABy/qLalVp+9xV8/RaSe6rrc+Jf6YPbwVK4mdXQ+Vw87uMlWSJiCMeww
 7JjljGL3XGvGU64p9+gjCyD9Eu/tG+MbIs9dKKO0hDzS
X-Google-Smtp-Source: APBJJlH6zojEh8q6VlMf1M/mtjRciRAcvkCAuwh/6zVA60EAT84d5Diq7ytMSSbJfQumIbW3BYQ77ZeY3A/Y5P1AHUQ=
X-Received: by 2002:a05:6870:e889:b0:1ad:3647:1fd0 with SMTP id
 q9-20020a056870e88900b001ad36471fd0mr2818647oan.22.1688664973295; Thu, 06 Jul
 2023 10:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230706123602.2331-1-shashank.sharma@amd.com>
 <20230706123602.2331-7-shashank.sharma@amd.com>
 <CADnq5_PS6Q=OqBf1OzYXkKbO=3EiKoTCk++n7fRKv2BGEk7tYg@mail.gmail.com>
 <59b6e3ff-3a5c-3beb-32bc-49720c530b5b@amd.com>
 <CADnq5_O_Os1ToTAodrtXiyj=MQeNpe+SnwBOynXV-MUxUvrU2g@mail.gmail.com>
 <cf57ea27-e72f-d5e2-d8cd-60122090e889@amd.com>
In-Reply-To: <cf57ea27-e72f-d5e2-d8cd-60122090e889@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jul 2023 13:36:02 -0400
Message-ID: <CADnq5_M58PVJcvW-5-SFHx1=PViDRWCn3m2D3C-baYUx+XBzig@mail.gmail.com>
Subject: Re: [PATCH v5 06/10] drm/amdgpu: map usermode queue into MES
To: Shashank Sharma <shashank.sharma@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jul 6, 2023 at 1:32=E2=80=AFPM Shashank Sharma <shashank.sharma@amd=
.com> wrote:
>
>
> On 06/07/2023 19:26, Alex Deucher wrote:
> > On Thu, Jul 6, 2023 at 1:15=E2=80=AFPM Shashank Sharma <shashank.sharma=
@amd.com> wrote:
> >>
> >> On 06/07/2023 18:52, Alex Deucher wrote:
> >>> On Thu, Jul 6, 2023 at 8:36=E2=80=AFAM Shashank Sharma <shashank.shar=
ma@amd.com> wrote:
> >>>> This patch adds new functions to map/unmap a usermode queue into
> >>>> the FW, using the MES ring. As soon as this mapping is done, the
> >>>> queue would  be considered ready to accept the workload.
> >>>>
> >>>> V1: Addressed review comments from Alex on the RFC patch series
> >>>>       - Map/Unmap should be IP specific.
> >>>> V2:
> >>>>       Addressed review comments from Christian:
> >>>>       - Fix the wptr_mc_addr calculation (moved into another patch)
> >>>>       Addressed review comments from Alex:
> >>>>       - Do not add fptrs for map/unmap
> >>>>
> >>>> V3: Integration with doorbell manager
> >>>> V4: Rebase
> >>>> V5: Use gfx_v11_0 for function names (Alex)
> >>>>
> >>>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 70 +++++++++++++++++++++=
+++++
> >>>>    1 file changed, 70 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/dr=
m/amd/amdgpu/gfx_v11_0.c
> >>>> index 7d3b19e08bbb..b4a0f26a0e8c 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> >>>> @@ -6491,6 +6491,65 @@ const struct amdgpu_ip_block_version gfx_v11_=
0_ip_block =3D
> >>>>           .funcs =3D &gfx_v11_0_ip_funcs,
> >>>>    };
> >>>>
> >>>> +static void gfx_v11_0_userq_unmap(struct amdgpu_userq_mgr *uq_mgr,
> >>>> +                                 struct amdgpu_usermode_queue *queu=
e)
> >>>> +{
> >>>> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> >>>> +       struct mes_remove_queue_input queue_input;
> >>>> +       int r;
> >>>> +
> >>>> +       memset(&queue_input, 0x0, sizeof(struct mes_remove_queue_inp=
ut));
> >>>> +       queue_input.doorbell_offset =3D queue->doorbell_index;
> >>>> +       queue_input.gang_context_addr =3D queue->gang_ctx_gpu_addr;
> >>>> +
> >>>> +       amdgpu_mes_lock(&adev->mes);
> >>>> +       r =3D adev->mes.funcs->remove_hw_queue(&adev->mes, &queue_in=
put);
> >>>> +       amdgpu_mes_unlock(&adev->mes);
> >>>> +       if (r)
> >>>> +               DRM_ERROR("Failed to unmap queue in HW, err (%d)\n",=
 r);
> >>>> +}
> >>>> +
> >>>> +static int gfx_v11_0_userq_map(struct amdgpu_userq_mgr *uq_mgr,
> >>>> +                              struct amdgpu_usermode_queue *queue,
> >>>> +                              struct amdgpu_mqd_prop *userq_props)
> >>>> +{
> >>>> +       struct amdgpu_device *adev =3D uq_mgr->adev;
> >>>> +       struct mes_add_queue_input queue_input;
> >>>> +       int r;
> >>>> +
> >>>> +       memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input)=
);
> >>>> +
> >>>> +       queue_input.process_va_start =3D 0;
> >>>> +       queue_input.process_va_end =3D (adev->vm_manager.max_pfn - 1=
) << AMDGPU_GPU_PAGE_SHIFT;
> >>>> +       queue_input.process_quantum =3D 100000; /* 10ms */
> >>>> +       queue_input.gang_quantum =3D 10000; /* 1ms */
> >>>> +       queue_input.paging =3D false;
> >>>> +
> >>>> +       queue_input.gang_context_addr =3D queue->gang_ctx_gpu_addr;
> >>>> +       queue_input.process_context_addr =3D queue->proc_ctx_gpu_add=
r;
> >>>> +       queue_input.inprocess_gang_priority =3D AMDGPU_MES_PRIORITY_=
LEVEL_NORMAL;
> >>>> +       queue_input.gang_global_priority_level =3D AMDGPU_MES_PRIORI=
TY_LEVEL_NORMAL;
> >>> Was there an option in the MQD to specify a priority?
> >> I checked the gfx_v11_MQD structure and this MQD does have an option t=
o
> >> specify the priority of a queue (offset 134), but as we are re-using t=
he
> >> mqd_init function from gfx_v11_ip_funcs which sets this offset to 0 by
> >> default, its not being used.
> >>
> >> We can add a parameter for queue priority and overwrite the init value=
s.
> >>
> >> The priority which we are setting here in this function, is for queue
> >> mapping using MES, and its the gang priority.
> > Thinking about this more, the priority would come from the context.
> > E.g., ctx->init_priority and ctx->override_priority (see
> > amdgpu_ctx_init()).  We should take that into account when creating
> > the queue.
>
> In the current design, the userqueue is completely independent of the
> GFX ctx (we discussed this in V2 I think, and that's when we introduced
> the user_mgr). I agree that we should consider the queue priority, but
> we might have to get this parameter specifically from the mqd_user_in.

Ah, right.  I forgot we decoupled it from the ctx.  We can look at
adding priorities as a future enhancement.

Alex

>
>
> >
> >>>    What about
> >>> secure settings?  If not, we should validate those flags properly and
> >>> return an error if they are not currently supported.
> >>>> +
> >>>> +       queue_input.process_id =3D queue->vm->pasid;
> >>>> +       queue_input.queue_type =3D queue->queue_type;
> >>>> +       queue_input.mqd_addr =3D queue->mqd.gpu_addr;
> >>>> +       queue_input.wptr_addr =3D userq_props->wptr_gpu_addr;
> >>>> +       queue_input.queue_size =3D userq_props->queue_size >> 2;
> >>> Do we validate the size anywhere?
> >> We are validating the whole structure/user_MQD size, but not
> >> specifically queue size. But based on your suggestion on libDRM UAPI, =
we
> >> are planing to add an USERQ_INFO_IOCTL in a separate patch series, whi=
ch
> >> will then introduce the IP based dynamic size checking, and also the
> >> checks related to alignment and queue size.
> > We just want to protect from userspace doing something crazy like
> > making a 10M queue or something like that.  We should add an interface
> > to query the sizes per IP, but we need to validate the inputs as well.
>
> Agree, I will add this queue size validation check in this series
> itself, will cross check some other inputs as well.
>
> - Shashank
>
> >
> > Alex
> >
> >> - Shashank
> >>
> >>>> +       queue_input.doorbell_offset =3D userq_props->doorbell_index;
> >>>> +       queue_input.page_table_base_addr =3D amdgpu_gmc_pd_addr(queu=
e->vm->root.bo);
> >>>> +
> >>>> +       amdgpu_mes_lock(&adev->mes);
> >>>> +       r =3D adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input=
);
> >>>> +       amdgpu_mes_unlock(&adev->mes);
> >>>> +       if (r) {
> >>>> +               DRM_ERROR("Failed to map queue in HW, err (%d)\n", r=
);
> >>>> +               return r;
> >>>> +       }
> >>>> +
> >>>> +       DRM_DEBUG_DRIVER("Queue (doorbell:%d) mapped successfully\n"=
, userq_props->doorbell_index);
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>>    static void gfx_v11_0_userq_destroy_ctx_space(struct amdgpu_userq=
_mgr *uq_mgr,
> >>>>                                                 struct amdgpu_usermo=
de_queue *queue)
> >>>>    {
> >>>> @@ -6601,8 +6660,18 @@ static int gfx_v11_0_userq_mqd_create(struct =
amdgpu_userq_mgr *uq_mgr,
> >>>>                   goto free_mqd;
> >>>>           }
> >>>>
> >>>> +       /* Map userqueue into FW using MES */
> >>>> +       r =3D gfx_v11_0_userq_map(uq_mgr, queue, &userq_props);
> >>>> +       if (r) {
> >>>> +               DRM_ERROR("Failed to init MQD\n");
> >>>> +               goto free_ctx;
> >>>> +       }
> >>>> +
> >>>>           return 0;
> >>>>
> >>>> +free_ctx:
> >>>> +       gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
> >>>> +
> >>>>    free_mqd:
> >>>>           amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_add=
r, &queue->mqd.cpu_ptr);
> >>>>           return r;
> >>>> @@ -6613,6 +6682,7 @@ gfx_v11_0_userq_mqd_destroy(struct amdgpu_user=
q_mgr *uq_mgr, struct amdgpu_userm
> >>>>    {
> >>>>           struct amdgpu_userq_obj *mqd =3D &queue->mqd;
> >>>>
> >>>> +       gfx_v11_0_userq_unmap(uq_mgr, queue);
> >>>>           gfx_v11_0_userq_destroy_ctx_space(uq_mgr, queue);
> >>>>           amdgpu_bo_free_kernel(&mqd->obj, &mqd->gpu_addr, &mqd->cpu=
_ptr);
> >>>>    }
> >>>> --
> >>>> 2.40.1
> >>>>
