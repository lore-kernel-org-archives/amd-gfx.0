Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849B1CD11DD
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Mar 2024 13:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1011B10EF97;
	Tue, 26 Mar 2024 13:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KtRfRjOf";
	dkim-atps=neutral
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D06310EF97
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 13:44:55 +0000 (UTC)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-5dbf7b74402so3123861a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Mar 2024 06:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711460695; x=1712065495; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaViRZdTz1pe7K5Ve+A+jDi4rEh6BzJpbuDAry0oTGU=;
 b=KtRfRjOf/LbCWLdtaeK1Re3AGVxqCX/W+qxc5exGUfVLvl0GavO/aOrsejIy2TilW8
 aH7uC9dOBwrvju9P7F2rQAJexqFl1OFm3qIakYwnsL8l3DafvaQJfmhPUV1A7HLGgggZ
 MNQ/WKLhwQUQV82expA5hHQUxIyIzt/6uuJCcnx5ciS1mAZlO7OBvG0hX0DnUy7rYTWA
 0YQ8l8Os2XciULRkeDQe8K33/7Ft+GyaL8dl4JHek6QsppQwwyPZfvxAJymTmc+e9NwH
 QJwsaVSXVGiovkACD2UYOVlp+ZhYnRqFVKiHHRJPDsucE2ZAIm+ukXz+mjqExVbOrtLv
 Nz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460695; x=1712065495;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eaViRZdTz1pe7K5Ve+A+jDi4rEh6BzJpbuDAry0oTGU=;
 b=tSwzP8JGdGEUXH15/PVKYQ9ms42zS1zA9Y5yZgWh329zvCqUqSg6R7e5KYbH2rMPVK
 JapnjbVaN5QzJfVUBPIyRMRVI/LnSJxbMnYEiPJ5BcKLwz6h3LUF6PHF4RD7m0+Vdn7p
 XsInj5nQ9S2mXcwELQOzWlU/3gaN9j8ylWr9F7z9GaOQRVScicXGjCRWKLkZVBEn8C7K
 jlaUs40wMwolwCOzsmHB5i/YxCIvw+1UT7xSQqcAyvtwQ8sUuyHirCj8IsxN/svOe4Y8
 wBI0xSCAyqxOir3iWv8sRRh7vnVh95JLzlga2nyKtiEYQ9vHF3Y2V2QL9Rsw0dMxKpGl
 dWIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNTudzoiF6JGRNqmsTBW0SgMPNcRF2uZIUy6jcM0VsOQV4XdUSNVSTIybEXddp+WuzxehLZQ++HDZbBXoTmzBlQxP86dmS1eie98Jjeg==
X-Gm-Message-State: AOJu0YxE+QtHHgTM7igc4j/YUUL5RlBCaqRpgtmVQpUzztpeayWrO1as
 7Olkkgdcv0Ixz1Q9O3MjHttGP9+fdCiCmu4jui40aCfGmuLLkfpm9qHf068nT9fmnqKxLX42PrQ
 Ij1IKUt3bDr4Qe6+la3XbPtS14II=
X-Google-Smtp-Source: AGHT+IFXkM0o9adu14F0TEdcrjqFLjcEnAF0/6YnSKgfNLWihCbmfX9gFfCTTGzqqQX5wyNfk+jdgOj0eF+m2ePnqjI=
X-Received: by 2002:a17:90a:12ce:b0:29d:9c46:a6aa with SMTP id
 b14-20020a17090a12ce00b0029d9c46a6aamr2528388pjg.17.1711460695347; Tue, 26
 Mar 2024 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240322164956.167498-1-shaoyun.liu@amd.com>
 <1d3c4b3a-733e-4820-ba8f-0466cb26a45c@amd.com>
 <CH0PR12MB5372C29628094DCF2C51D2BBF4362@CH0PR12MB5372.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5372C29628094DCF2C51D2BBF4362@CH0PR12MB5372.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Mar 2024 09:44:43 -0400
Message-ID: <CADnq5_OVp-31BUV2T78d4h9PEnSG7z_yhLFf3WsXpy3sRx_i4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu : Increase the mes log buffer size as per new
 MES FW version
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Mar 25, 2024 at 7:52=E2=80=AFPM Liu, Shaoyun <Shaoyun.Liu@amd.com> =
wrote:
>
> [AMD Official Use Only - General]
>
> It can  cause page fault  when the  log size exceed the  page size .

I think we should make sure this patch goes back to stable for all
kernel versions where the logging is enabled.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex


>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com>
> Sent: Monday, March 25, 2024 2:58 PM
> To: Liu, Shaoyun <Shaoyun.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu : Increase the mes log buffer size as per=
 new MES FW version
>
>
> On 2024-03-22 12:49, shaoyunl wrote:
> >  From MES version 0x54, the log entry increased and require the log
> > buffer size to be increased. The 16k is maximum size agreed
>
> What happens when you run the new firmware on an old kernel that only all=
ocates 4KB?
>
> Regards,
>    Felix
>
>
> >
> > Signed-off-by: shaoyunl <shaoyun.liu@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 5 ++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 +
> >   2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > index 9ace848e174c..78e4f88f5134 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> > @@ -103,7 +103,7 @@ static int amdgpu_mes_event_log_init(struct amdgpu_=
device *adev)
> >       if (!amdgpu_mes_log_enable)
> >               return 0;
> >
> > -     r =3D amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> > +     r =3D amdgpu_bo_create_kernel(adev, AMDGPU_MES_LOG_BUFFER_SIZE,
> > +PAGE_SIZE,
> >                                   AMDGPU_GEM_DOMAIN_GTT,
> >                                   &adev->mes.event_log_gpu_obj,
> >                                   &adev->mes.event_log_gpu_addr, @@ -15=
48,12 +1548,11 @@
> > static int amdgpu_debugfs_mes_event_log_show(struct seq_file *m, void *=
unused)
> >       uint32_t *mem =3D (uint32_t *)(adev->mes.event_log_cpu_addr);
> >
> >       seq_hex_dump(m, "", DUMP_PREFIX_OFFSET, 32, 4,
> > -                  mem, PAGE_SIZE, false);
> > +                  mem, AMDGPU_MES_LOG_BUFFER_SIZE, false);
> >
> >       return 0;
> >   }
> >
> > -
> >   DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_mes_event_log);
> >
> >   #endif
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > index 7d4f93fea937..4c8fc3117ef8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> > @@ -52,6 +52,7 @@ enum amdgpu_mes_priority_level {
> >
> >   #define AMDGPU_MES_PROC_CTX_SIZE 0x1000 /* one page area */
> >   #define AMDGPU_MES_GANG_CTX_SIZE 0x1000 /* one page area */
> > +#define AMDGPU_MES_LOG_BUFFER_SIZE 0x4000 /* Maximu log buffer size
> > +for MES */
> >
> >   struct amdgpu_mes_funcs;
> >
