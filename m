Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D58C77B75
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 15:21:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 298A310E358;
	Mon, 22 May 2023 15:21:03 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B78D10E358
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 15:21:01 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-397f13944f2so1326122b6e.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 08:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684768860; x=1687360860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMyRJOSK4hmHptJlolPOuaD3Z6B3Nj7DHZ31yZotdjE=;
 b=XWd40HDWHIz8pmzejdjhlgNmneCMrS2YtWPr3bcWikd4iAXT2oLYK+znroMKVo4pUG
 Y7ckWBhARcQlxu6HahVfOUM4rU7Wnn0MtNauf+xDJ4Ij0B+BlmmRVsjYkMLdiezgwlQB
 kuLa2elrV7Sq9frReuxHbWHNyniM7RBFUqwwsOsiB2GXJIuO1/OjdNn5/vEL7rMAXzwc
 qZKAQkU6pgTDsKgh/leZL0tWk8D5hlgNhydRPWqin/ofI7X7vghu1YuYgGRTi7rZyEqF
 FEubAKxnJGsNOp0XVp6jVJBCL8HoEFs/AlnOJJyMQUIJasBeKc8U/HDCKh5vJHQPEaul
 huLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684768860; x=1687360860;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMyRJOSK4hmHptJlolPOuaD3Z6B3Nj7DHZ31yZotdjE=;
 b=GhiSTwGAhnrGKzyP7LX/T3xeTt3rq0/1NuYh/Azu/doTT/R2Y7jrNJp6PU3lg0S/MN
 5enpoOgViag9PxFaw41zohhduHJsvnujPfT9cjB0xsYBDFxOrPF5CW2E+qMysQdIdH17
 o+rNl01/idn3v7Or/xS1QW76BcfLmHTK4q04EgF8RXzGOtq/SCfUHPgqgXUYQaJsjC5b
 DYGF7EWiJvLVvdlCYaAA9RsQGKHnrcx6WL5W3u8Z24/C6XcpmwT/CZyhsiKiB9plKD90
 jjS2L5+vfCEkb6A6d8lHHkhSvp7NYCgW+h+M1QHcWXtOzZIl1qiVimucFfIMzPLYWTYO
 tAkA==
X-Gm-Message-State: AC+VfDynGyPNOfi9U6dksS6NNplKv/Z76d63r44kHaEIt9aLsx7/p5Cc
 QZxnMVSWYZHdOx1XP9X9niH1MK0y/LXUKFlr9IDTs7ReVoo=
X-Google-Smtp-Source: ACHHUZ79/mv710ZarvNDDHk0eTBrfsb8skvzjsEqecRmeT6yEoaF8iyanwICDH93vR1NkQhz1hZmwr3n5mEPj8nWV4Y=
X-Received: by 2002:a05:6808:4d9:b0:392:52a8:62e6 with SMTP id
 a25-20020a05680804d900b0039252a862e6mr6164204oie.46.1684768860366; Mon, 22
 May 2023 08:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230508104756.1007978-1-srinivasan.shanmugam@amd.com>
 <CADnq5_MGsc7ULTuM-XU3-ofDiZHQ6K8TwOpYB6K7RbUXgy8kxA@mail.gmail.com>
In-Reply-To: <CADnq5_MGsc7ULTuM-XU3-ofDiZHQ6K8TwOpYB6K7RbUXgy8kxA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 May 2023 11:20:49 -0400
Message-ID: <CADnq5_M62+OozYkoY3u=kzWHrUPyUdqx56zMSMD+1BttcV+8uA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/amdgpu: Fix assingment in if condition in
 amdgpu_irq.c
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, May 22, 2023 at 11:19=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Mon, May 8, 2023 at 6:48=E2=80=AFAM Srinivasan Shanmugam
> <srinivasan.shanmugam@amd.com> wrote:
> >
> > Assignments in if condition are less readable and error-prone.
> >
> > Fixes below error & warnings reported by checkpatch"
> >
> > ERROR: do not use assignment in if condition
> > +       } else if ((src =3D adev->irq.client[client_id].sources[src_id]=
)) {
> >
> > WARNING: braces {} are not necessary for any arm of this statement
> > WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> >
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>

Actually, typo in the patch title:
assingment -> assignment
With that fixed, you can add my Ack.



> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>
> > ---
> >
> > v2:
> >
> > - Validate the client_id and src_id values or otherwise
> >   this can crash (Christian)
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 29 +++++++++++++------------
> >  1 file changed, 15 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_irq.c
> > index c8413470e057..dfaedb0243ba 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> > @@ -110,7 +110,7 @@ const char *soc15_ih_clientid_name[] =3D {
> >  void amdgpu_irq_disable_all(struct amdgpu_device *adev)
> >  {
> >         unsigned long irqflags;
> > -       unsigned i, j, k;
> > +       unsigned int i, j, k;
> >         int r;
> >
> >         spin_lock_irqsave(&adev->irq.lock, irqflags);
> > @@ -269,11 +269,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
> >                 int nvec =3D pci_msix_vec_count(adev->pdev);
> >                 unsigned int flags;
> >
> > -               if (nvec <=3D 0) {
> > +               if (nvec <=3D 0)
> >                         flags =3D PCI_IRQ_MSI;
> > -               } else {
> > +               else
> >                         flags =3D PCI_IRQ_MSI | PCI_IRQ_MSIX;
> > -               }
> > +
> >                 /* we only need one vector */
> >                 nvec =3D pci_alloc_irq_vectors(adev->pdev, 1, 1, flags)=
;
> >                 if (nvec > 0) {
> > @@ -332,7 +332,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
> >   */
> >  void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
> >  {
> > -       unsigned i, j;
> > +       unsigned int i, j;
> >
> >         for (i =3D 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
> >                 if (!adev->irq.client[i].sources)
> > @@ -366,7 +366,7 @@ void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
> >   * 0 on success or error code otherwise
> >   */
> >  int amdgpu_irq_add_id(struct amdgpu_device *adev,
> > -                     unsigned client_id, unsigned src_id,
> > +                     unsigned int client_id, unsigned int src_id,
> >                       struct amdgpu_irq_src *source)
> >  {
> >         if (client_id >=3D AMDGPU_IRQ_CLIENTID_MAX)
> > @@ -418,8 +418,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev=
,
> >  {
> >         u32 ring_index =3D ih->rptr >> 2;
> >         struct amdgpu_iv_entry entry;
> > -       unsigned client_id, src_id;
> > -       struct amdgpu_irq_src *src;
> > +       unsigned int client_id, src_id;
> > +       struct amdgpu_irq_src *src =3D NULL;
> >         bool handled =3D false;
> >         int r;
> >
> > @@ -446,7 +446,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev=
,
> >                 DRM_DEBUG("Unregistered interrupt client_id: %d src_id:=
 %d\n",
> >                           client_id, src_id);
> >
> > -       } else if ((src =3D adev->irq.client[client_id].sources[src_id]=
)) {
> > +       } else if (client_id < AMDGPU_IRQ_CLIENTID_MAX && src_id < AMDG=
PU_MAX_IRQ_SRC_ID) {
> > +               src =3D adev->irq.client[client_id].sources[src_id];
> >                 r =3D src->funcs->process(adev, src, &entry);
> >                 if (r < 0)
> >                         DRM_ERROR("error processing interrupt (%d)\n", =
r);
> > @@ -493,7 +494,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev=
,
> >   * Updates interrupt state for the specific source (all ASICs).
> >   */
> >  int amdgpu_irq_update(struct amdgpu_device *adev,
> > -                            struct amdgpu_irq_src *src, unsigned type)
> > +                            struct amdgpu_irq_src *src, unsigned int t=
ype)
> >  {
> >         unsigned long irqflags;
> >         enum amdgpu_interrupt_state state;
> > @@ -556,7 +557,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdg=
pu_device *adev)
> >   * 0 on success or error code otherwise
> >   */
> >  int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *=
src,
> > -                  unsigned type)
> > +                  unsigned int type)
> >  {
> >         if (!adev->irq.installed)
> >                 return -ENOENT;
> > @@ -586,7 +587,7 @@ int amdgpu_irq_get(struct amdgpu_device *adev, stru=
ct amdgpu_irq_src *src,
> >   * 0 on success or error code otherwise
> >   */
> >  int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *=
src,
> > -                  unsigned type)
> > +                  unsigned int type)
> >  {
> >         if (!adev->irq.installed)
> >                 return -ENOENT;
> > @@ -620,7 +621,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, stru=
ct amdgpu_irq_src *src,
> >   * invalid parameters
> >   */
> >  bool amdgpu_irq_enabled(struct amdgpu_device *adev, struct amdgpu_irq_=
src *src,
> > -                       unsigned type)
> > +                       unsigned int type)
> >  {
> >         if (!adev->irq.installed)
> >                 return false;
> > @@ -733,7 +734,7 @@ void amdgpu_irq_remove_domain(struct amdgpu_device =
*adev)
> >   * Returns:
> >   * Linux IRQ
> >   */
> > -unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigne=
d src_id)
> > +unsigned int amdgpu_irq_create_mapping(struct amdgpu_device *adev, uns=
igned int src_id)
> >  {
> >         adev->irq.virq[src_id] =3D irq_create_mapping(adev->irq.domain,=
 src_id);
> >
> > --
> > 2.25.1
> >
