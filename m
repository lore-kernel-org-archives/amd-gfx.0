Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF67C77B73
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 15:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C504C10E356;
	Mon, 22 May 2023 15:20:05 +0000 (UTC)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D144610E356
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 15:20:03 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-396140d25e0so2428093b6e.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684768802; x=1687360802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+/cAu+lsD47DcMHi/xGc5PLyg2Rj7QUBZl2vardQId4=;
 b=YQ5vQBb8X1zsnFjG5JEXd+jjHFfm6WDdRzXXiEo0tu5/sYPzFNtCrVoWLnOlZhmtL1
 5JHVRdRqzPYErLWObdgoTnd4mGA4RcHgwgtdCQo5K5lfWzfymHnDsJilGDk0AYvcsDNL
 iDcAdaRoyraNJXpU1J0pt0lAY62jbc7qd02iEn5o/IVxbkIHCn3cxPTyN2jDaPAJrXuG
 AdaUPA1K7ub5vTJ9qOhZm+3GGLl67FOx4Hqasb67MkX+y3pn7hZZcX7nHbjccBv0Nw4m
 hg3KNPkJk1NRnbanxMwt9SoPmKVnYz5Ia069WFVuS3AVIgkj1Ua5lPC43sgLNa0ngMVT
 8O1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684768802; x=1687360802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+/cAu+lsD47DcMHi/xGc5PLyg2Rj7QUBZl2vardQId4=;
 b=ZR5GOU8BAZ/IQ4je3r4vC/+pd/jF0LQiNueqUoyEia4I00cy5CKJo93TKvQtQbjQxS
 AILW3WxwKVZQ3FKf2kjUJ9dFsICjHurgNYxxjfFLFQt4gch1HLaxW/sehrP5jNZfaO/J
 TerqH/kB5nZnjilSk78GlIaOVJyNXEyu66qO12omEZgVRp4Kdmi9b9cyXGOH6ZHtyBpv
 9MU7TLcNaDTUG4aYWA6a7Z/3168QuOUyUSTirceVDKlQHQNH3wNgnIvRB8Zl6CdUf7eH
 ol9guTNUkPtbaYM4zGJwS/Q1+ss9A+QkFMQd2K8El+XA9KHBDzUk9iIXVAXOds40sINM
 /08A==
X-Gm-Message-State: AC+VfDxq5wIoDGT7aSsOJZVgBRNCNNSkp8GBQd34vhTpw5lrjbrgqmE+
 cpj16VxYmdPydp2Z7UXm2gRiOIr5JQ20KLXRgv8=
X-Google-Smtp-Source: ACHHUZ5z7ZdOZkUYsVPAStM1yKVkFEK/Ik0gy/ihJU5d5BDLfZiZcX9UvyW1WYMWK1p5hasQNQZ8KAOISpbkDZCFnjc=
X-Received: by 2002:aca:3243:0:b0:396:230f:3fc7 with SMTP id
 y64-20020aca3243000000b00396230f3fc7mr7744032oiy.25.1684768802192; Mon, 22
 May 2023 08:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230508104756.1007978-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230508104756.1007978-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 May 2023 11:19:49 -0400
Message-ID: <CADnq5_MGsc7ULTuM-XU3-ofDiZHQ6K8TwOpYB6K7RbUXgy8kxA@mail.gmail.com>
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

On Mon, May 8, 2023 at 6:48=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Assignments in if condition are less readable and error-prone.
>
> Fixes below error & warnings reported by checkpatch"
>
> ERROR: do not use assignment in if condition
> +       } else if ((src =3D adev->irq.client[client_id].sources[src_id]))=
 {
>
> WARNING: braces {} are not necessary for any arm of this statement
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>
> v2:
>
> - Validate the client_id and src_id values or otherwise
>   this can crash (Christian)
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 29 +++++++++++++------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index c8413470e057..dfaedb0243ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -110,7 +110,7 @@ const char *soc15_ih_clientid_name[] =3D {
>  void amdgpu_irq_disable_all(struct amdgpu_device *adev)
>  {
>         unsigned long irqflags;
> -       unsigned i, j, k;
> +       unsigned int i, j, k;
>         int r;
>
>         spin_lock_irqsave(&adev->irq.lock, irqflags);
> @@ -269,11 +269,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>                 int nvec =3D pci_msix_vec_count(adev->pdev);
>                 unsigned int flags;
>
> -               if (nvec <=3D 0) {
> +               if (nvec <=3D 0)
>                         flags =3D PCI_IRQ_MSI;
> -               } else {
> +               else
>                         flags =3D PCI_IRQ_MSI | PCI_IRQ_MSIX;
> -               }
> +
>                 /* we only need one vector */
>                 nvec =3D pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>                 if (nvec > 0) {
> @@ -332,7 +332,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>   */
>  void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
>  {
> -       unsigned i, j;
> +       unsigned int i, j;
>
>         for (i =3D 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>                 if (!adev->irq.client[i].sources)
> @@ -366,7 +366,7 @@ void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
>   * 0 on success or error code otherwise
>   */
>  int amdgpu_irq_add_id(struct amdgpu_device *adev,
> -                     unsigned client_id, unsigned src_id,
> +                     unsigned int client_id, unsigned int src_id,
>                       struct amdgpu_irq_src *source)
>  {
>         if (client_id >=3D AMDGPU_IRQ_CLIENTID_MAX)
> @@ -418,8 +418,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>  {
>         u32 ring_index =3D ih->rptr >> 2;
>         struct amdgpu_iv_entry entry;
> -       unsigned client_id, src_id;
> -       struct amdgpu_irq_src *src;
> +       unsigned int client_id, src_id;
> +       struct amdgpu_irq_src *src =3D NULL;
>         bool handled =3D false;
>         int r;
>
> @@ -446,7 +446,8 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>                 DRM_DEBUG("Unregistered interrupt client_id: %d src_id: %=
d\n",
>                           client_id, src_id);
>
> -       } else if ((src =3D adev->irq.client[client_id].sources[src_id]))=
 {
> +       } else if (client_id < AMDGPU_IRQ_CLIENTID_MAX && src_id < AMDGPU=
_MAX_IRQ_SRC_ID) {
> +               src =3D adev->irq.client[client_id].sources[src_id];
>                 r =3D src->funcs->process(adev, src, &entry);
>                 if (r < 0)
>                         DRM_ERROR("error processing interrupt (%d)\n", r)=
;
> @@ -493,7 +494,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>   * Updates interrupt state for the specific source (all ASICs).
>   */
>  int amdgpu_irq_update(struct amdgpu_device *adev,
> -                            struct amdgpu_irq_src *src, unsigned type)
> +                            struct amdgpu_irq_src *src, unsigned int typ=
e)
>  {
>         unsigned long irqflags;
>         enum amdgpu_interrupt_state state;
> @@ -556,7 +557,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu=
_device *adev)
>   * 0 on success or error code otherwise
>   */
>  int amdgpu_irq_get(struct amdgpu_device *adev, struct amdgpu_irq_src *sr=
c,
> -                  unsigned type)
> +                  unsigned int type)
>  {
>         if (!adev->irq.installed)
>                 return -ENOENT;
> @@ -586,7 +587,7 @@ int amdgpu_irq_get(struct amdgpu_device *adev, struct=
 amdgpu_irq_src *src,
>   * 0 on success or error code otherwise
>   */
>  int amdgpu_irq_put(struct amdgpu_device *adev, struct amdgpu_irq_src *sr=
c,
> -                  unsigned type)
> +                  unsigned int type)
>  {
>         if (!adev->irq.installed)
>                 return -ENOENT;
> @@ -620,7 +621,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct=
 amdgpu_irq_src *src,
>   * invalid parameters
>   */
>  bool amdgpu_irq_enabled(struct amdgpu_device *adev, struct amdgpu_irq_sr=
c *src,
> -                       unsigned type)
> +                       unsigned int type)
>  {
>         if (!adev->irq.installed)
>                 return false;
> @@ -733,7 +734,7 @@ void amdgpu_irq_remove_domain(struct amdgpu_device *a=
dev)
>   * Returns:
>   * Linux IRQ
>   */
> -unsigned amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsigned =
src_id)
> +unsigned int amdgpu_irq_create_mapping(struct amdgpu_device *adev, unsig=
ned int src_id)
>  {
>         adev->irq.virq[src_id] =3D irq_create_mapping(adev->irq.domain, s=
rc_id);
>
> --
> 2.25.1
>
