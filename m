Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FA606A327
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Oct 2026 15:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kyPCadNI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD3411275A;
	Thu, 22 Oct 2026 15:40:10 +0000 (UTC)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com
 [209.85.221.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960D2112768
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 15:40:04 +0000 (UTC)
Received: by mail-vk1-f172.google.com with SMTP id
 71dfb90a1353d-5ea929b2933so859e0c.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Oct 2026 08:40:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792683603; cv=none;
 d=google.com; s=arc-20260327;
 b=hA4DWfpLcdHtgz7wm3rrQ3sVHqeNMQByvkskzEwTGaNjv59L2g6M4NyJNFE85kH6zC
 BQTwYT+K5p8xQpwsrD1gB6nfCSXAD7KQMiwhikDdkqRNxYO7E5t7p0rhhIGIFs91svrP
 Cw3D2R37BJcyH0eUxUe+QgKLn813/LnUBHDCpwcvg0yAoybleCK5kUBrNZpr34DDqtOj
 ylUnoq2wF/AamdY+ecD/1sl8gD9tBodtXeUVhYywMv+Ju9AMBcQFoKU4M0Bt5qhubteO
 JAeavLEKWeRmf3dhFJupiWyYxNaXsj5OcR7QfnAxNFOmX3XHJ+Lslv7QzZFBCg1rIJi6
 TI/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aBVlE0DT5vfTrMiAkGx/Woz+NEI5V6GKD/MopDOABX0=;
 fh=ha0IybXjterB+Z+WUE68InDk1auUb5RYFaNgjgSrE9I=;
 b=KfkFMkCrpaWU40KDj7vAD5yXB9inVpjNZ1+D3GiDZ2fLdgOSJ/I+gOAdm1c8VeXLd8
 xjMJmhCpQG7v1W26TiUCUWauxlNdoNKLZ4JOj/EakwpgV6+20+9q+YEgHlr7rlIIrRL/
 J/a2ROCHSbX6Rg54tWGjijnghw5wQy5r3zaljeNRYo9GQv0nULvnpLB0DbYZMavknsgA
 qrmh2oiMUNOi3D7NERfTLCzeW5pcOEPXWGa+mXRvRVXoXX+jqp+gNTklr5qYUsKvt/SH
 ZFVBqrvWFkyw9f0IZohJdLOVrevhF9HyVqv9w2GD8syO4I7zKukftVaxbLfu9mVBGphA
 A98g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792683603; x=1793288403; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=aBVlE0DT5vfTrMiAkGx/Woz+NEI5V6GKD/MopDOABX0=;
 b=kyPCadNI8EFGEgbhs59Xo25oG7UGo23QeFbcB53veLs9NoD8kroTuedPLXVA7imu/k
 8AjLQG39LT5hSeBf180HOWuGFp5XoePAE5Z3aiRCUUA9cSPqewNbhN3bBI44Jfcz5WIP
 bMlbEo82sdR1eat+oAak23Ec72hAGGc/r/9zGiC/Z7PhLFdoZbuMCVukxc6r7PHRhFk6
 CKx/ThyovGoZA1pQlFVotX4dy7fqwpTAE0Rv5rKpgE+7RzLfBrvZQY7hOn8h5dCUSLUd
 N5+e4Boa7hBPqScN6u+j6ByOUTBWubaxOr4itL6BeloECqVlst7bCCjXWzwYlwjz7dC/
 207g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792683603; x=1793288403;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aBVlE0DT5vfTrMiAkGx/Woz+NEI5V6GKD/MopDOABX0=;
 b=wRJ5/7cP/9p70MfclPJiTOVe3lgbVGHFlFx9O0qCZL8eL9Wd3fCW0kHVSUKuaus+9s
 gvAdlJg2uEPAVhn0JCVYicIteDYvDohvFNK9XlLKuWcrCN0zsUcCOipQpfmeuvMMR651
 kt6ecDUHb4aSf/EWaNDrP5L7W9V1xWA3OL6AR1S6Kn/U5AoEFHCEiuaqVXavZd+Fueo0
 ljTcvrmtJO1diOdxFCfCqkCfyNtW3+uG12ONL8ZzXxD1rgK4dxcSPjSYS5PmliC47kun
 R9BHQXbVDk3mS1T0vcT1uHeApqPFUy7DykdDpVq2nK1gOhqlwNdCP8qhrmXvjZikGegh
 S53A==
X-Gm-Message-State: AFq9FYKUQCqNGG54aa+m5oLCjW+LvWdiCSD3wTq8w9CB3KEjEAO7vvDy
 kD97adBAdvVJ1l2ni/GeDvCwByZKMxPeck+3bwrkzQDcSZXxonDSuvFqfwdVsUDJFn3DJif7iXs
 GxerKszaWtZDyKU/Ie7iw0c5CqUEUBBM=
X-Gm-Gg: AYBFou2u5myz/79tGZ1o8e8EbidgTgBzcji45HcpACh9ui2FOclpN+8y/RHgs4Xf+RR
 cweskxH5zvjaXJP7nqnfVx2cDRGWD0D2BRTEPUyYcoJrpkDBptxo+IxiuHYKcKCcuixS6iBZG8J
 b2JGoYBnGNy+3LyFiCRKW3rFpggiRRY7jKKce4jWTelIPEgkNNUHKossiwy3k4JOSlBcd4yQB6r
 Bb7p09wcqHarINjqWrlT3mKGv/pB1mWUzefd90dnjWYRwK0EdO14cr8Qj3phpejp1Yeb74mzDlv
 MUdJBTD8c+P1WQu4fwhgsxMVci5/EC2yDu6S5gOCbAdIABgqLMkFKgLxKZ71dcoOvNJHlRw4sZ1
 4QyXTds7ufEcHV2HpQcO4eN5ztyPmjHDnSz+QHlQGNVmROx+kGKdsVmRm89k7LW4JO+t1GbtfAN
 zBkYSirZ3xcAjNv8Gzq0bkHOE=
X-Received: by 2002:a05:6102:3ec3:b0:7cc:80ba:94ed with SMTP id
 ada2fe7eead31-7cc926092fdmr1865484137.2.1792683603055; Thu, 22 Oct 2026
 08:40:03 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022014728.84081-1-amber.lin@amd.com>
 <20261022014728.84081-4-amber.lin@amd.com>
In-Reply-To: <20261022014728.84081-4-amber.lin@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Oct 2026 11:39:50 -0400
X-Gm-Features: AclHuK9DcpVbwHXA5zD9k8N38x2Zkg-q3oIFqpZWAIa5byPJNLgGo7zFc-pt9LE
Message-ID: <CADnq5_OhOCymFFs8oiZPGTjq8dJFx16PCA2aZ=yUnAnshS9aGw@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: Correct hung queue number for reset
To: Amber Lin <amber.lin@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Shaoyun.Liu@amd.com, 
 alexander.deucher@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 9:56=E2=80=AFPM Amber Lin <amber.lin@amd.com> wrote=
:
>
> In an ASIC supporting multi-compute partition, the number of queues
> varies with the compute partition mode. We need to adjust the hqd_info
> offset to get the correct hung queues doorbell offset and hqd_info.
>
> Signed-off-by: Amber Lin <amber.lin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 54 +++++++++++++++++--------
>  1 file changed, 37 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index 58766b27e150..5bcab09b15c6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -108,6 +108,24 @@ static inline u32 amdgpu_mes_get_hqd_mask(u32 num_pi=
pe,
>
>  static void amdgpu_mes_userq_notify_unmap_work_handler(struct work_struc=
t *work);
>
> +static int get_num_queues_per_xcp(struct amdgpu_device *adev, int num_xc=
ps)
> +{
> +       int i, num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mas=
k) : 1;
> +       u32 num_queues =3D 0;
> +
> +       for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> +               num_queues +=3D hweight32(adev->mes.gfx_hqd_mask[i]);
> +
> +       for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> +               num_queues +=3D hweight32(adev->mes.compute_hqd_mask[i]);
> +
> +       num_xcc /=3D num_xcps;
> +       for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> +               num_queues +=3D hweight32(adev->mes.sdma_hqd_mask[i]) * n=
um_xcc;
> +
> +       return num_queues;
> +}
> +
>  int amdgpu_mes_init(struct amdgpu_device *adev)
>  {
>         int i, r, num_pipes, num_queues =3D 0;
> @@ -222,21 +240,18 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>                 goto error_doorbell;
>
>         if (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(11, 0, 0)=
) {
> -               /* When queue/pipe reset is done in MES instead of in the
> -                * driver, MES passes hung queues information to the driv=
er in
> -                * hung_queue_hqd_info. Calculate required space to store=
 this
> -                * information.
> +               /* When queue/pipe reset is handled by MES instead of by =
the
> +                * driver, driver provides the buffer for MES to store th=
e hung
> +                * queues information. Calculate required buffer size, wh=
ich is
> +                * the number of maximum queues. This number varies with =
compute
> +                * partition mode. We allocate the biggest size, which is=
 SPX,
> +                * num_xcps =3D 1.
>                  */
> -               for (i =3D 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
> -                       num_queues +=3D hweight32(adev->mes.gfx_hqd_mask[=
i]);
> -
> -               for (i =3D 0; i < AMDGPU_MES_MAX_COMPUTE_PIPES; i++)
> -                       num_queues +=3D hweight32(adev->mes.compute_hqd_m=
ask[i]);
> -
> -               for (i =3D 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++)
> -                       num_queues +=3D hweight32(adev->mes.sdma_hqd_mask=
[i]) * num_xcc;
> -
> +               num_queues =3D get_num_queues_per_xcp(adev, 1);
>                 adev->mes.hung_queue_hqd_info_offset =3D num_queues;
> +               /* Double num_queues. The first half is to store doorbell=
 offset
> +                * and the second half is to store hqd_info.
> +                */
>                 adev->mes.hung_queue_db_array_size =3D num_queues * 2;
>         }
>
> @@ -526,8 +541,9 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>                                             uint32_t xcc_id)
>  {
>         struct mes_detect_and_reset_queue_input input;
> -       u32 *db_array =3D adev->mes.hung_queue_db_array_cpu_addr[xcc_id];
> -       int hqd_info_offset =3D adev->mes.hung_queue_hqd_info_offset, r, =
i;
> +       u32 *db_array =3D adev->mes.hung_queue_db_array_cpu_addr[0];

Does mes.hung_queue_db_array_cpu_addr still need to be an array?

> +       int hqd_info_offset, r, i;
> +       int num_xcps =3D 1;
>
>         if (!hung_db_num || !hung_db_array)
>                 return -EINVAL;
> @@ -537,8 +553,12 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct a=
mdgpu_device *adev,
>             (queue_type !=3D AMDGPU_RING_TYPE_SDMA))
>                 return -EINVAL;
>
> +       if (adev->xcp_mgr)
> +               num_xcps =3D adev->xcp_mgr->num_xcps;
> +       hqd_info_offset =3D get_num_queues_per_xcp(adev, num_xcps);
> +
>         /* Clear the doorbell array before detection */
> -       memset(adev->mes.hung_queue_db_array_cpu_addr[xcc_id], AMDGPU_MES=
_INVALID_DB_OFFSET,
> +       memset(adev->mes.hung_queue_db_array_cpu_addr[0], AMDGPU_MES_INVA=
LID_DB_OFFSET,
>                 adev->mes.hung_queue_db_array_size * sizeof(u32));
>         input.queue_type =3D queue_type;
>         input.detect_only =3D detect_only;
> @@ -554,7 +574,7 @@ int amdgpu_mes_detect_and_reset_hung_queues(struct am=
dgpu_device *adev,
>
>         *hung_db_num =3D 0;
>         /* MES passes hung queues' doorbell to driver */
> -       for (i =3D 0; i < adev->mes.hung_queue_hqd_info_offset; i++) {

Can mes.hung_queue_hqd_info_offset be removed after this change?

Alex

> +       for (i =3D 0; i < hqd_info_offset; i++) {
>                 /* Finding hung queues where db_array[i] is a valid doorb=
ell */
>                 if (db_array[i] !=3D AMDGPU_MES_INVALID_DB_OFFSET) {
>                         dev_dbg(adev->dev, "MES: hung queue doorbell 0x%x=
\n", db_array[i]);
> --
> 2.43.0
>
