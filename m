Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6CCEB64DD
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jul 2023 21:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F1B410E35C;
	Mon, 24 Jul 2023 21:19:55 +0000 (UTC)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 36ABE10E35C
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 21:19:54 +0000 (UTC)
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-56584266c41so2960588eaf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jul 2023 14:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690233593; x=1690838393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tf8ifrW/+sZRcE/IDTmWQ/Qg9rHEYTQMcj081sO2BDM=;
 b=DCms+iChpyWj9h98ktkHOcg3IHCNkxtoBtcVu1c05eaucBSsugNi+uHqgDlxv4MVOn
 bto/AoTc0/3ksYlPZt6Kn9e291H3XkZywox7CXyuuxbuflYskDiFXLnEpLrwOt2HGhRx
 4oBREznHIBPb9wwa9F0W4r1zJFJgeLDWvxNIxr6PmZvl2DWrI/BeZqJDfAlbWtN1TBP6
 agba3ADtd+5YEGQnmqf7QVX21FoHcf2BFgfdvvH9Sg0o1L4joCGnP3v2KVGfZsyGmRaj
 pgE9k9uBHEFBC/DjO0/vKWDL7kIWuEus3mPjRksGnMST8MZFdj62EmbyA6pqvWDGb1q/
 ptHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690233593; x=1690838393;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tf8ifrW/+sZRcE/IDTmWQ/Qg9rHEYTQMcj081sO2BDM=;
 b=bey+LHg+zAn6g5u44zrSUrr6I3YxIexUwRiy9NttlZB0n0BGm/52kdMldIZhpkNhTv
 z8XdW2YlDrCqceY1CaE3Fsxz3Nc61ALQQ3ymz594RUc90+5zfunaEEkASYUFuk9X7YqR
 t7pXodXq1zBc4iaI27NPQLXdRs1x2ktEgwJKx23vy4T6AbpXLQgZjviSPix4xMSbcQ+P
 GZ5VDt9rkRjW5VBRrysi4iWMY1SupeCRe18y18jbKwZ4oD1W7sVjbUoQAWSScdmSouQq
 GoeKXpbTOGOCsXEGpENKkTEnXZZZPvgdwErirbHkJTdpiBwyUBsmA3SkGoDUXjG/Z2oM
 2F5Q==
X-Gm-Message-State: ABy/qLb6GxadWlLXOUxQrOjqRSRAdklmRi8SB0Re53yuh7vHXUKt1c0p
 9yNHQ1QqCgkYGwaXouKOQjv8y0AqeyhKFCgi7w0=
X-Google-Smtp-Source: APBJJlHTdrn6Sgl45kvGk4HCuIWTyoPxH8pxYDHfUy2qkg8GQHB79yA7OhusVArmdIJxG6r6aK5LSQ+kvvcg7qdmX7A=
X-Received: by 2002:a4a:91d0:0:b0:566:fa3f:82af with SMTP id
 e16-20020a4a91d0000000b00566fa3f82afmr8524257ooh.5.1690233593252; Mon, 24 Jul
 2023 14:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230723065007.2022758-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230723065007.2022758-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Jul 2023 17:19:42 -0400
Message-ID: <CADnq5_O5YkscgpZVpnw7Z_GnwDY-w2aZgbHk=0rPxU_K65UqWA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Use seq_puts() instead of seq_printf()
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

On Sun, Jul 23, 2023 at 2:51=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> For a constant format without additional arguments, use seq_puts()
> instead of seq_printf(). Also, it fixes the following warning.
>
> WARNING: Prefer seq_puts to seq_printf
>
> And other style fixes:
>
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> WARNING: Block comments should align the * on each line
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ib.c
> index e0d3e3aa2e31..0cbaf78e8828 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -62,7 +62,7 @@
>   * Returns 0 on success, error on failure.
>   */
>  int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -                 unsigned size, enum amdgpu_ib_pool_type pool_type,
> +                 unsigned int size, enum amdgpu_ib_pool_type pool_type,
>                   struct amdgpu_ib *ib)
>  {
>         int r;
> @@ -123,7 +123,7 @@ void amdgpu_ib_free(struct amdgpu_device *adev, struc=
t amdgpu_ib *ib,
>   * a CONST_IB), it will be put on the ring prior to the DE IB.  Prior
>   * to SI there was just a DE IB.
>   */
> -int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
> +int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
>                        struct amdgpu_ib *ibs, struct amdgpu_job *job,
>                        struct dma_fence **f)
>  {
> @@ -131,16 +131,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed num_ibs,
>         struct amdgpu_ib *ib =3D &ibs[0];
>         struct dma_fence *tmp =3D NULL;
>         bool need_ctx_switch;
> -       unsigned patch_offset =3D ~0;
> +       unsigned int patch_offset =3D ~0;
>         struct amdgpu_vm *vm;
>         uint64_t fence_ctx;
>         uint32_t status =3D 0, alloc_size;
> -       unsigned fence_flags =3D 0;
> +       unsigned int fence_flags =3D 0;
>         bool secure, init_shadow;
>         u64 shadow_va, csa_va, gds_va;
>         int vmid =3D AMDGPU_JOB_GET_VMID(job);
>
> -       unsigned i;
> +       unsigned int i;
>         int r =3D 0;
>         bool need_pipe_sync =3D false;
>
> @@ -282,7 +282,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned num_ibs,
>                 amdgpu_ring_emit_gfx_shadow(ring, 0, 0, 0, false, 0);
>
>                 if (ring->funcs->init_cond_exec) {
> -                       unsigned ce_offset =3D ~0;
> +                       unsigned int ce_offset =3D ~0;
>
>                         ce_offset =3D amdgpu_ring_init_cond_exec(ring);
>                         if (ce_offset !=3D ~0 && ring->funcs->patch_cond_=
exec)
> @@ -386,7 +386,7 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
>  {
>         long tmo_gfx, tmo_mm;
>         int r, ret =3D 0;
> -       unsigned i;
> +       unsigned int i;
>
>         tmo_mm =3D tmo_gfx =3D AMDGPU_IB_TEST_TIMEOUT;
>         if (amdgpu_sriov_vf(adev)) {
> @@ -403,7 +403,7 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
>                 /* for CP & SDMA engines since they are scheduled togethe=
r so
>                  * need to make the timeout width enough to cover the tim=
e
>                  * cost waiting for it coming back under RUNTIME only
> -               */
> +                */
>                 tmo_gfx =3D 8 * AMDGPU_IB_TEST_TIMEOUT;
>         } else if (adev->gmc.xgmi.hive_id) {
>                 tmo_gfx =3D AMDGPU_IB_TEST_GFX_XGMI_TIMEOUT;
> @@ -466,13 +466,13 @@ static int amdgpu_debugfs_sa_info_show(struct seq_f=
ile *m, void *unused)
>  {
>         struct amdgpu_device *adev =3D m->private;
>
> -       seq_printf(m, "--------------------- DELAYED --------------------=
- \n");
> +       seq_puts(m, "--------------------- DELAYED ---------------------\=
n");
>         amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DELAY=
ED],
>                                      m);
> -       seq_printf(m, "-------------------- IMMEDIATE -------------------=
- \n");
> +       seq_puts(m, "-------------------- IMMEDIATE --------------------\=
n");
>         amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_IMMED=
IATE],
>                                      m);
> -       seq_printf(m, "--------------------- DIRECT ---------------------=
- \n");
> +       seq_puts(m, "--------------------- DIRECT ----------------------\=
n");
>         amdgpu_sa_bo_dump_debug_info(&adev->ib_pools[AMDGPU_IB_POOL_DIREC=
T], m);
>
>         return 0;
> --
> 2.25.1
>
