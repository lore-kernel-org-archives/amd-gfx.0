Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D00F6C77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 19:56:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5383A10E4C3;
	Tue, 23 May 2023 19:56:09 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC0A10E4C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 19:56:06 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6af812703b6so8253a34.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684871765; x=1687463765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ob1TWqxeCXfkimA2g9CWRbIiYOVlfYN9r9JYa63C64=;
 b=cNWk9eYYyH22Ktgjpa02UMjfdU5mxPlLiRa6YYpBckZhpGPyerf6U4TKgejRrQ6fj5
 oCgwU4Bzwjx5Jz9O9Y1dE577PZxGv56ekwompZrc1EetyVspsdnd63Zmbm8KOUafUbXi
 Ug++R0j8u75uwSbZ1xTi9paI5WvjEjEwUUX0awi+oUq8ATFcmvpOrtV6flQtjml3aJHV
 b6WloF2dV1q4gP3OJ6rbbtECROU14dy2bnufMMJLfSSeK1cLKzhQaUTIKfK9UqrE9KnG
 hQRERaQNYMs+67JrN8SR4ka7Se1bZPRWQnD5kfRuf4RtKddewQEbOkIBCJX8+rCPARsD
 J1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684871765; x=1687463765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+ob1TWqxeCXfkimA2g9CWRbIiYOVlfYN9r9JYa63C64=;
 b=bPn4+0LayFcEXji5ebBB+4rXG2jBK16xt2hpiJabwaD8dQRavGsxD+w/TMVzxuAICS
 vxEyog8URewreXYCEymLvnYdTEs+k3hVb66vUhZtP/GhM3ycBjDtMXcwxfHCRZLSLPfS
 qTbVOmN5XigzqFvS/MICCPmv6IOL2VO7xZxXMl6wSi7kadtVddxUAZx7crYIJGHD0K4y
 0VA/4LILWx5U9IcCGr6gGnPWWbqs3uN1q48Us2r7Y8DuzlhIOFN9Zu944BgGARjJH9zF
 yhAS2Xr6ZBkpxCBf6jbNvniKGbzzl3HBXrPc3+BTBZFirTnEFhkxKT1+rF5AUk8fT71L
 lPEQ==
X-Gm-Message-State: AC+VfDzVUZDS/jkbTu/m8/A+5tMQnklNQG57nQOdu8izNy+F1QdFSx62
 456aNkbjgZdqhupLKLdOyEekewhFZodXI3Xd2eQEBeK5
X-Google-Smtp-Source: ACHHUZ4v6ejZha5dv4d8P4yRjKf5e9arW6RnSRRLNZpB6j1VwhOPNPFJi0DPy0d9MvKGUUx0+y3p0azFGgI4JlYvZHQ=
X-Received: by 2002:a54:4698:0:b0:397:f439:d416 with SMTP id
 k24-20020a544698000000b00397f439d416mr5280964oic.35.1684871765467; Tue, 23
 May 2023 12:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230523195037.3150894-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230523195037.3150894-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 May 2023 15:55:54 -0400
Message-ID: <CADnq5_Nq3VENqDFWJdDx6Kz2E4t5choPXur21Zq_Xb+Mp8ip=A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Fix warnings in amdgpu_irq.c
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, May 23, 2023 at 3:51=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: braces {} are not necessary for any arm of this statement
> +               if (nvec <=3D 0) {
> [...]
> +               } else {
> [...]
> WARNING: Block comments use a trailing */ on a separate line
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 27 +++++++++++++------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index ad5368e15114..00f2106c17b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -125,7 +125,7 @@ const int node_id_to_phys_map[NODEID_MAX] =3D {
>  void amdgpu_irq_disable_all(struct amdgpu_device *adev)
>  {
>         unsigned long irqflags;
> -       unsigned i, j, k;
> +       unsigned int i, j, k;
>         int r;
>
>         spin_lock_irqsave(&adev->irq.lock, irqflags);
> @@ -284,11 +284,11 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
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
> @@ -347,7 +347,7 @@ void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>   */
>  void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
>  {
> -       unsigned i, j;
> +       unsigned int i, j;
>
>         for (i =3D 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>                 if (!adev->irq.client[i].sources)
> @@ -381,7 +381,7 @@ void amdgpu_irq_fini_sw(struct amdgpu_device *adev)
>   * 0 on success or error code otherwise
>   */
>  int amdgpu_irq_add_id(struct amdgpu_device *adev,
> -                     unsigned client_id, unsigned src_id,
> +                     unsigned int client_id, unsigned int src_id,
>                       struct amdgpu_irq_src *source)
>  {
>         if (client_id >=3D AMDGPU_IRQ_CLIENTID_MAX)
> @@ -433,7 +433,7 @@ void amdgpu_irq_dispatch(struct amdgpu_device *adev,
>  {
>         u32 ring_index =3D ih->rptr >> 2;
>         struct amdgpu_iv_entry entry;
> -       unsigned client_id, src_id;
> +       unsigned int client_id, src_id;
>         struct amdgpu_irq_src *src;
>         bool handled =3D false;
>         int r;
> @@ -508,7 +508,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
>   * Updates interrupt state for the specific source (all ASICs).
>   */
>  int amdgpu_irq_update(struct amdgpu_device *adev,
> -                            struct amdgpu_irq_src *src, unsigned type)
> +                            struct amdgpu_irq_src *src, unsigned int typ=
e)
>  {
>         unsigned long irqflags;
>         enum amdgpu_interrupt_state state;
> @@ -517,7 +517,8 @@ int amdgpu_irq_update(struct amdgpu_device *adev,
>         spin_lock_irqsave(&adev->irq.lock, irqflags);
>
>         /* We need to determine after taking the lock, otherwise
> -          we might disable just enabled interrupts again */
> +        * we might disable just enabled interrupts again
> +        */
>         if (amdgpu_irq_enabled(adev, src, type))
>                 state =3D AMDGPU_IRQ_STATE_ENABLE;
>         else
> @@ -571,7 +572,7 @@ void amdgpu_irq_gpu_reset_resume_helper(struct amdgpu=
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
> @@ -601,7 +602,7 @@ int amdgpu_irq_get(struct amdgpu_device *adev, struct=
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
> @@ -635,7 +636,7 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct=
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
> @@ -748,7 +749,7 @@ void amdgpu_irq_remove_domain(struct amdgpu_device *a=
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
