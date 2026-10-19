Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9633A606A32C
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 20:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gNc9F+xJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BD110E15C;
	Mon, 19 Oct 2026 20:43:21 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8CFB10E15C
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 20:43:14 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3584f70a5aaso316886eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792442594; cv=none;
 d=google.com; s=arc-20260327;
 b=AU2QRZMISNCWMI52RsJ1rBLy8iPrL/JUonXU/4Mn9RdbU2Hr5Jk5JOpZwKnziRZmVJ
 PZ/ywBD8/yuaOSivid0FjQXw/6RjryHZMJcbaZcl7DdqtpbeGJIBlPFlllUeGKSTW1XE
 573xjoSDINXeDUL7RdsvKwjj4rVbUqUa1bnj8ZvNsDbbGOQENe/wtvyxsI/6t+vLfl3+
 cIV+g4kf0cZaR7yAnGPjcWKxoQRYKsbU4DJoMaTTb5eTVmZVdP7Cl+mKOQIPh6m8K5mI
 ad4r/MJA/9wAZ5C2FIDZ5P32zqHBwdt86gdR7jawQ9gilcL6FrP9H3VUwCekHdwgmwMu
 ozyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5RSMnlGsep4BEuQvTqAh0aie2h0AfTjX+l4zT/PrfEk=;
 fh=Q9981pU5STIq36rEL8NnhZul3/sIV0LrQmgtBHxF+Fg=;
 b=ke5hEVYBHU8gJyTbFJEt0YEyNXKjcvqzbQ+ViTittfOn/Nh/LycwL3K1mQ1qwa+rIq
 VaoakTMOHBgQ1eEmq0JPnAJ6QAi3fgqRCbKeW82v0c0z6P5+S07q725JwtWPkDljr7TV
 lI5UJyDMt3NXSOM/rZ4OoxgDpGKkHbAah1bYC1VjJpzBLhK6YzvVz8wHqcaxCdMdwlXX
 r3JJdJisGvgIE9xT/PDmMHwozryZlzed+E6HhcJRehQlD5TSrnS+gK4bwOkp1RTrSQd0
 I6LwxzYtNR83N6d1AHiVnyF36FvqrEsI+yyTlOmCcIUFnHNUQ76GBNyuu3tR9axoKRE/
 js4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792442594; x=1793047394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5RSMnlGsep4BEuQvTqAh0aie2h0AfTjX+l4zT/PrfEk=;
 b=gNc9F+xJHnj0OySW9fPoh88PgT1WqeY918Ihre2/qeLUAuAwBheVa2yMbf40VyhkuG
 duR86NsJTxfaRfXI7W0EuDfE0qTb7TnX7jayTG28LtiZheKqS/RyxxyxqCiPA3UQoQBZ
 Hy1KJJTqBHW8UWP/gBjiZgvp5GGhaAl1n0FlqKQqF/fYFe0o3RRt/ZmSm+coKoxXe1Fn
 +sPhnUs7sIjBFFsWFcot5xDmirL2l2a4MOaoS3CuGHXYnNGEDsqCmoLXhVQMCHBX5q8R
 zN1/wUnp1mjTGyc8cPzbqQNFzu/4hInui+cGiCSFN7h81aiGBoRb0s9S2f9IPFhfzEpj
 Z+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792442594; x=1793047394;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5RSMnlGsep4BEuQvTqAh0aie2h0AfTjX+l4zT/PrfEk=;
 b=MZrPd1rJ19h56kwEvnphxEsHGo39LZG8vTeH14sM9reqcMlOqmjRz6aHsd3j4nz5On
 qxvjAx8Z2qleOtKmsQnBGfM5JIZVB9NEX++9wsKmFDCJZzXN1gbud4IWtzSky4WfBPnm
 ntpoPi/Whj6aiKc9D+fGR/5mJi5JkKMUEQHjWEvf5wnlFjvXjBvnfWp1aSxQEkMd3uRI
 tUL5ufY3GNuhdXoImXYiJzokkE40VJ5I+k9v2/5zNrbP5QypolBDBo9R6pI/FeTrhmSC
 DV1q1mu2vt91jEU4HjOoQxQ8xk4v5aRO9YwF/dY1GlU1yIZNvUdbMu1OAnGlg9tGVD77
 Qzzg==
X-Gm-Message-State: AFq9FYLvVNlYZ1RnK9aBqRMABj9OziamfXtGjWRJuQW7tIG1i/kRsuvc
 A1hzndPZ4JDlNNKSNwt+VNzUZpCb96M+lHmTLionrz4heS6V9l7Z9vjoHTVBHhJJVPLui1FOU+O
 ZEr+zuvESJgETOVWMk3Wx9RiyAdqYZ/4=
X-Gm-Gg: AYBFou0fIdORJYjlhkS4QR4+XBjoaTXDulx8qYaLA27Xef/VbDMu8BtOf9pYQaF8Y/D
 Sm+6Z7mM6r5A3FdgGzdU/eZjtMwXqZs2Uc+DovtL8JKZ43gFlfY/x9149F8/HbCrSADH9YP+OH6
 MZRmQuS5cKnxkZWAjZ4ycfGKkstgvwgw+KVX4omqOmjhrfEiMkoEC/LtTcTcfZz/eYqrU7tlUnN
 kHRS1o5F+Abuq3e/mhLaBDWkaVLXi1s+ljJqStCEp3Koo7LiW5Rk400C/9URE/mpyY3Bwe+EV4Q
 jYksT09kpOSsvBLGI8HRvOpje06FKeC33LbeMaJHXJQUWsVJ2nn1EuDoA3flEGwjUn+3n1uKvBN
 vcWXaTWpH35O6mAgRmQ7DK9rHquWrRZxLZZNoe2jCG8G7SkwzT43K+TWAlwZ9qS7J27uSEqXrvT
 Qh7wV3q+xQnjfhqe5IOUjxjMU=
X-Received: by 2002:a05:701b:4503:20b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1850771aefamr19267295c88.0.1792442593540; Mon, 19 Oct 2026
 13:43:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019195601.2468302-1-William.Palacek@amd.com>
In-Reply-To: <20261019195601.2468302-1-William.Palacek@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Oct 2026 16:43:01 -0400
X-Gm-Features: AclHuK-VrbsXBzbLMqNehQ8Xm_pydFSJZhnh7-1FD2LWDXFvVfru53mRmATTLTE
Message-ID: <CADnq5_NBCQDgV=PkxywUX2M=R9XvPoSqZ=QyDETmWd5Di2M0vQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Validate the control stack of a restored queue
To: William Palacek <William.Palacek@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Harish.Kasiviswanathan@amd.com, Felix.Kuehling@amd.com
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 19, 2026 at 3:57=E2=80=AFPM William Palacek <William.Palacek@am=
d.com> wrote:
>
> kfd_criu_restore_queue() takes the control stack size from the
> checkpoint image without the topology check create-queue does in
> kfd_queue_acquire_buffers(), which restore stopped calling in
> commit ad770bbc9dbe ("drm/amdkfd: Don't acquire buffers
> during CRIU queue restore."). An image size of 0x300000 is accepted and
> sizes the MQD allocation, and 0xFFFFFFFF trips a page allocator warning
> in kmalloc().
>
> restore_mqd() also keeps the image's cp_hqd_cntl_stack_size,
> cp_hqd_cntl_stack_offset and cp_hqd_wg_state_offset. With offset > size
> or wave state offset < size, get_wave_state() returns wrapped sizes.
>
> Take the per-XCC size from topology, 0 for queues without a control
> stack, and reject larger images. In restore_mqd(), set the size to it
> and bound both offsets as init_mqd() does.
>
> Fixes: 626f7b3190b4 ("drm/amdkfd: CRIU add queues support")
> Fixes: 42c6c48214b7 ("drm/amdkfd: CRIU checkpoint and restore queue mqds"=
)
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  9 ++++++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  2 ++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 ++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c  |  2 ++
>  .../drm/amd/amdkfd/kfd_mqd_manager_v12_1.c    |  2 ++
>  .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   |  2 ++

kfd_mqd_manager_vi.c and kfd_mqd_manager_cik.c should use the same
code for consistency.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>  .../amd/amdkfd/kfd_process_queue_manager.c    | 30 +++++++++++++------
>  7 files changed, 40 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/d=
rm/amd/amdkfd/kfd_mqd_manager.h
> index 38b46b696243..d63f7e9fae30 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
> @@ -138,6 +138,15 @@ struct mqd_manager {
>         uint32_t ctl_stack_size;
>  };
>
> +/* Keep offset <=3D size <=3D wave state offset, as init_mqd() and CP do=
 */
> +static inline void kfd_mqd_restore_ctl_stack(u32 *size, u32 *offset, u32=
 *wg_offset,
> +                                            u32 ctl_stack_size)
> +{
> +       *size =3D ctl_stack_size;
> +       *offset =3D min(*offset, ctl_stack_size);
> +       *wg_offset =3D max(*wg_offset, ctl_stack_size);
> +}
> +
>  struct mqd_user_context_save_area_header {
>         /* Byte offset from start of user context
>          * save area to the last saved top (lowest
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> index 4f8a8a1a6186..6c9bafa3962e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
> @@ -305,6 +305,8 @@ static void restore_mqd(struct mqd_manager *mm, void =
**mqd,
>         addr =3D mqd_mem_obj->gpu_addr;
>
>         memcpy(m, mqd_src, sizeof(*m));
> +       kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_=
cntl_stack_offset,
> +                                 &m->cp_hqd_wg_state_offset, qp->ctl_sta=
ck_size);
>
>         *mqd =3D m;
>         if (gart_addr)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> index bf015dc5b868..5709949de2eb 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
> @@ -340,6 +340,8 @@ static void restore_mqd(struct mqd_manager *mm, void =
**mqd,
>         addr =3D mqd_mem_obj->gpu_addr;
>
>         memcpy(m, mqd_src, sizeof(*m));
> +       kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_=
cntl_stack_offset,
> +                                 &m->cp_hqd_wg_state_offset, qp->ctl_sta=
ck_size);
>
>         *mqd =3D m;
>         if (gart_addr)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c b/drivers/g=
pu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> index 6ea09b031caf..aea80266d254 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12.c
> @@ -393,6 +393,8 @@ static void restore_mqd(struct mqd_manager *mm, void =
**mqd,
>
>         memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size));
>         memcpy(m, mqd_src, sizeof(*m));
> +       kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_=
cntl_stack_offset,
> +                                 &m->cp_hqd_wg_state_offset, qp->ctl_sta=
ck_size);
>
>         /* Update MQD base address to the newly allocated location */
>         m->cp_mqd_base_addr_lo =3D lower_32_bits(addr);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 2bbf5e63f615..15dbe8e5f286 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -692,6 +692,8 @@ static void restore_mqd_v12_1(struct mqd_manager *mm,=
 void **mqd,
>         memset(m, 0, AMDGPU_MQD_SIZE_ALIGN(mm->mqd_size) *
>                      NUM_XCC(mm->dev->xcc_mask));
>         memcpy(m, mqd_src, sizeof(*m));
> +       kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_=
cntl_stack_offset,
> +                                 &m->cp_hqd_wg_state_offset, qp->ctl_sta=
ck_size);
>
>         /* Update MQD base address to the newly allocated location */
>         m->cp_mqd_base_addr_lo =3D lower_32_bits(addr);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gp=
u/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> index 6e6bc1ec0b64..fca43017ee7e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
> @@ -462,6 +462,8 @@ static void restore_mqd(struct mqd_manager *mm, void =
**mqd,
>         addr =3D mqd_mem_obj->gpu_addr;
>
>         memcpy(m, mqd_src, sizeof(*m));
> +       kfd_mqd_restore_ctl_stack(&m->cp_hqd_cntl_stack_size, &m->cp_hqd_=
cntl_stack_offset,
> +                                 &m->cp_hqd_wg_state_offset, qp->ctl_sta=
ck_size);
>
>         *mqd =3D m;
>         if (gart_addr)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index a15a826519ad..78ab759ad854 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -26,6 +26,7 @@
>  #include <linux/list.h>
>  #include "kfd_device_queue_manager.h"
>  #include "kfd_priv.h"
> +#include "kfd_topology.h"
>  #include "kfd_kernel_queue.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_reset.h"
> @@ -983,7 +984,7 @@ int kfd_criu_checkpoint_queues(struct kfd_process *p,
>  }
>
>  static void set_queue_properties_from_criu(struct queue_properties *qp,
> -                                         struct kfd_criu_queue_priv_data=
 *q_data, uint32_t num_xcc)
> +                                         struct kfd_criu_queue_priv_data=
 *q_data)
>  {
>         qp->is_interop =3D false;
>         qp->queue_percent =3D q_data->q_percent;
> @@ -996,11 +997,6 @@ static void set_queue_properties_from_criu(struct qu=
eue_properties *qp,
>         qp->eop_ring_buffer_size =3D q_data->eop_ring_buffer_size;
>         qp->ctx_save_restore_area_address =3D q_data->ctx_save_restore_ar=
ea_address;
>         qp->ctx_save_restore_area_size =3D q_data->ctx_save_restore_area_=
size;
> -       if (q_data->type =3D=3D KFD_QUEUE_TYPE_COMPUTE)
> -               qp->ctl_stack_size =3D q_data->ctl_stack_size / num_xcc;
> -       else
> -               qp->ctl_stack_size =3D q_data->ctl_stack_size;
> -
>         qp->type =3D q_data->type;
>         qp->format =3D q_data->format;
>  }
> @@ -1012,6 +1008,7 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>  {
>         uint8_t *mqd, *ctl_stack, *q_extra_data =3D NULL;
>         struct kfd_criu_queue_priv_data *q_data;
> +       struct kfd_topology_device *topo_dev;
>         struct kfd_process_device *pdd;
>         uint64_t q_extra_data_size;
>         struct queue_properties qp;
> @@ -1048,6 +1045,24 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>                 goto exit;
>         }
>
> +       memset(&qp, 0, sizeof(qp));
> +       set_queue_properties_from_criu(&qp, q_data);
> +
> +       /* Per-XCC control stack size from topology, as create-queue requ=
ires */
> +       if (qp.type =3D=3D KFD_QUEUE_TYPE_COMPUTE && pdd->dev->kfd->cwsr_=
enabled) {
> +               topo_dev =3D kfd_topology_device_by_id(pdd->dev->id);
> +               if (!topo_dev) {
> +                       ret =3D -EINVAL;
> +                       goto exit;
> +               }
> +               qp.ctl_stack_size =3D topo_dev->node_props.ctl_stack_size=
;
> +       }
> +
> +       if (q_data->ctl_stack_size > (u64)qp.ctl_stack_size * NUM_XCC(pdd=
->dev->xcc_mask)) {
> +               ret =3D -EINVAL;
> +               goto exit;
> +       }
> +
>         *priv_data_offset +=3D sizeof(*q_data);
>         q_extra_data_size =3D (uint64_t)q_data->ctl_stack_size + q_data->=
mqd_size;
>
> @@ -1077,9 +1092,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>         mqd =3D q_extra_data;
>         ctl_stack =3D mqd + q_data->mqd_size;
>
> -       memset(&qp, 0, sizeof(qp));
> -       set_queue_properties_from_criu(&qp, q_data, NUM_XCC(pdd->dev->xcc=
_mask));
> -
>         print_queue_properties(&qp);
>
>         ret =3D pqm_create_queue(&p->pqm, pdd->dev, &qp, &queue_id, q_dat=
a, mqd, ctl_stack, NULL);
> --
> 2.43.0
>
