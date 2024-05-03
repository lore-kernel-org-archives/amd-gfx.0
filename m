Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEBDC4345F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 May 2024 16:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03BEC88EF0;
	Fri,  3 May 2024 16:22:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Za1HGLtx";
	dkim-atps=neutral
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 438B01128BC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 May 2024 16:22:27 +0000 (UTC)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-618a2b12dbbso1735439a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 May 2024 09:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714753346; x=1715358146; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKRSQ++a22cy66lHj7ycz8DoyGlanZzrFDHOx2BAZrE=;
 b=Za1HGLtxW1Ekb8qcdNgmBqjJnF/29V049TvAiQmyqOXX8M3iCkwYeQVRGTWgF8VY/v
 RC+7AnInRE/vFq8zRpj6LxKapboS8CzUPFBmwyq/RNm51oLS07nyIOADyBTHXG8yMYRu
 EYCvul8NIAtp8jWfsrjUsJGB4I9IKp5guB8nL6DvOmo4jKVenlCe5myAlEFjRPTedLuX
 yOHsRQ+KAN3hFqAiMfFYoW0OwBY/j46GL5KdkzncHp2m/wTKtR9TCW1Ob24f4Vt1WF7o
 FivLvhqlfJcnhrRNqN1gNTrcu3UicvI0J52iHgSI6V7eSb6/MKI9yY6ISpCY8HpTr+Gf
 Ltbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714753346; x=1715358146;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MKRSQ++a22cy66lHj7ycz8DoyGlanZzrFDHOx2BAZrE=;
 b=eIFq1pOhVT4R3rDF+Oh//KeHb7602JVLn45HZ6L6jyPqwD6Tjwg3Zv0/+m2FU/x7LJ
 7R7BpYKzvhYT0PQxeXhrj9IR3qYDmAyGA1JXf0zZg7y1bCBOfHDiyEPsc8Wkge9Cy9Ar
 hMCS76XeuOyGKlL8I9Vpg/XDIybh2gmQeDMMLwvAiueZP6cgfL+7kKMwF+mq1TG/lZ2a
 w8OAu55nKAlDsTthmqRQIjpmhB3Ta28i4xdBNYZyWKuI8QEdkrTckPSRpCijiaKzYZNG
 8aOeWWyu/WWFDaGgPeZ6VoIUuk8M89NL05CHCTaflKxrM4bPLPZOim0SDHRrXLSu0pqS
 JW0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3+4N4zWdGKeaSCCHigUJiEZrKz6BTDWrnBC4uWapWDa0r2Ux7tNJDXglvjbJPKvwNUaI8ETd73XcNxIQt0ElhqJX8njSMuNs1Z1T7TA==
X-Gm-Message-State: AOJu0YxR1xLLXkJArDehNA36z+UmQWRC6cChBSPf6zWf+ri89tuwNnJg
 DKCj2rZfLYuV/r7uttbPbmXj6GOqsSqaDFxBJ2AJIyp37ab0crq/FFjR/qIwQqsqPVTRCYpvC3K
 IwEBEIn9aBjkX65poIZvO9rBpdZk=
X-Google-Smtp-Source: AGHT+IE4rVpP/sxbo5cjjLrA+A5ghSMe7Gj+v02yLmXq/HY5P1ribQLX40Q2Dtme2CtQt2/BlsdxKpd9qumD0q6H8RA=
X-Received: by 2002:a17:90a:d709:b0:2a5:be1a:6831 with SMTP id
 y9-20020a17090ad70900b002a5be1a6831mr9287807pju.19.1714753346515; Fri, 03 May
 2024 09:22:26 -0700 (PDT)
MIME-Version: 1.0
References: <20240503084447.2451529-1-sunil.khatri@amd.com>
 <20240503084447.2451529-4-sunil.khatri@amd.com>
 <CADnq5_OYxPY6_qUwkbEqMQmDLaiDwopFKdeREn=WabnKjbBA8A@mail.gmail.com>
 <5681bd76-f01e-491d-982d-2448aaf4f9af@amd.com>
 <76aca882-f1f7-4edf-8dcb-2098dc1a52a3@amd.com>
In-Reply-To: <76aca882-f1f7-4edf-8dcb-2098dc1a52a3@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 May 2024 12:22:14 -0400
Message-ID: <CADnq5_MwcLfBNv+y2fEA3Xx+-cKrFc+tevYEGzPQAVzcSA01HA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] drm/amdgpu: add compute registers in ip dump for
 gfx10
To: "Khatri, Sunil" <sukhatri@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Fri, May 3, 2024 at 12:09=E2=80=AFPM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
>
> On 5/3/2024 9:18 PM, Khatri, Sunil wrote:
> >
> > On 5/3/2024 8:52 PM, Alex Deucher wrote:
> >> On Fri, May 3, 2024 at 4:45=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.=
com>
> >> wrote:
> >>> add compute registers in set of registers to dump
> >>> during ip dump for gfx10.
> >>>
> >>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 42
> >>> +++++++++++++++++++++++++-
> >>>   1 file changed, 41 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> index 953df202953a..00c7a842ea3b 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> >>> @@ -378,7 +378,47 @@ static const struct amdgpu_hwip_reg_entry
> >>> gc_reg_list_10_1[] =3D {
> >>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE0),
> >>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE1),
> >>>          SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE2),
> >>> -       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3)
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmGRBM_STATUS_SE3),
> >>> +       /* compute registers */
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_VMID),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PERSISTENT_STATE),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PIPE_PRIORITY),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUEUE_PRIORITY),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_QUANTUM),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_BASE_HI),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_RPTR),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_DOORBELL_CONTROL),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_CONTROL),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_BASE_ADDR_HI),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_RPTR),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_IB_CONTROL),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_REQUEST),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_BASE_ADDR_HI),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_CONTROL),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_RPTR),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_EVENTS),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_CONTROL),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_OFFSET),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CNTL_STACK_SIZE),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_WG_STATE_OFFSET),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_CTX_SAVE_SIZE),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_GDS_RESOURCE_STATE),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_ERROR),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_EOP_WPTR_MEM),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_LO),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_PQ_WPTR_HI),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_OFFSET=
),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_CNTL_STACK_DW_CNT=
),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_SUSPEND_WG_STATE_OFFSET),
> >>> +       SOC15_REG_ENTRY_STR(GC, 0, mmCP_HQD_DEQUEUE_STATUS)
> >> The registers in patches 3 and 4 are multi-instance, so we should
> >> ideally print every instance of them rather than just one.  Use
> >> nv_grbm_select() to select the pipes and queues.  Make sure to protect
> >> access using the adev->srbm_mutex mutex.
> >>
> >> E.g., for the compute registers (patch 3):
> >>      mutex_lock(&adev->srbm_mutex);
> >>          for (i =3D 0; i < adev->gfx.mec.num_mec; ++i) {
> >>                  for (j =3D 0; j < adev->gfx.mec.num_pipe_per_mec; j++=
) {
> >>                         for (k =3D 0; k <
> >> adev->gfx.mec.num_queue_per_pipe; k++) {
> >>                   drm_printf("mec %d, pipe %d, queue %d\n", i, j, k);
> >>                  nv_grbm_select(adev, i, j, k, 0);
> >>                         for (reg =3D 0; reg < ARRAY_SIZE(compute_regs)=
;
> >> reg++)
> >>                         drm_printf(...RREG(compute_regs[reg]));
> >>                      }
> >>                  }
> >>      }
> >>      nv_grbm_select(adev, 0, 0, 0, 0);
> >>      mutex_unlock(&adev->srbm_mutex);
> >>
> >> For gfx registers (patch 4):
> >>
> >>      mutex_lock(&adev->srbm_mutex);
> >>          for (i =3D 0; i < adev->gfx.me.num_me; ++i) {
> >>                  for (j =3D 0; j < adev->gfx.me.num_pipe_per_me; j++) =
{
> >>                      for (k =3D 0; k < adev->gfx.me.num_queue_per_pipe=
;
> >> k++) {
> >>                                drm_printf("me %d, pipe %d, queue
> >> %d\n", i, j, k);
> >>                                  nv_grbm_select(adev, i, j, k, 0);
> >>                         for (reg =3D 0; reg < ARRAY_SIZE(gfx_regs); re=
g++)
> >>                         drm_printf(...RREG(gfx_regs[reg]));
> I see one problem here, we dump the registers in memory allocated first
> and read before and store and then dump later when user read the
> devcoredump file. Here we do not know how many registers are there
> considering multiple me and then pipe per me and queue per pipe.
>
> Should we run this loop in advance to count no of elements while
> allocating memory or (count =3D gfx.me.num_me *
> adev->gfx.me.num_pipe_per_me * adev->gfx.me.num_queue_per_pipe. No
> matter what we do we need to save these registers in advance.

Keep the multi-instanced registers in separate arrays and then add
them all up to get the total size.

adev->gfx.ip_dump_core[regs]
adev->gfx.ip_dump_cp_compute_instanced[mec][pipe][queue]
adev->gfx.ip_dump_cp_gfx_instanced[me][pipe][queue]

>
> Also another problem in printing drm_printf("me %d, pipe %d, queue
> %d\n", i, j, k); Need to think how we can do that ...

Use multiple arrays to store the data. and just print that between
them in the ip_print callback.

Alex

>
> >>              }
> >>                  }
> >>          }
> >>      nv_grbm_select(adev, 0, 0, 0, 0);
> >>      mutex_unlock(&adev->srbm_mutex);
> >
> > Thanks for pointing that out and suggesting the sample code of how it
> > should be. Will take care of this in next patch set.
> >
> > Regards
> >
> > Sunil
> >
> >>
> >> Alex
> >>
> >>>   };
> >>>
> >>>   static const struct soc15_reg_golden golden_settings_gc_10_1[] =3D =
{
> >>> --
> >>> 2.34.1
> >>>
