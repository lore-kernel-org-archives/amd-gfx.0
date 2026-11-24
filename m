Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE51606A323
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aP8xl98g
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C444F10F632;
	Tue, 24 Nov 2026 16:09:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C111210F632
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:09:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7345741793;
 Tue, 24 Nov 2026 16:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 967241F000C0;
 Tue, 24 Nov 2026 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795536580;
 bh=bNzU0bWdgs8Y2aKNB4+6ws/nQ8XZPn3jHga5EVbS7rY=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=aP8xl98g6gQApKrL+mCHYIaGKvmbPNL3wt6Kw+8ZHKb03Ge4Vy91C2ckWCp5wvtls
 OElvOIXNyGYF9vBOxkr7EtEB0qadLvqzueFuc7x4R/3gqAeoeuMcRKU9No9nDzJ+UI
 +LSmUsJ4fGg7HWuAOxhbafSGNnJN8Rob5L+kefR4oU0Fa9BDxb1WbT0f/L0U9jEx8Z
 KT/PVMYTviyDpHzHzk2wnvEvuQ6GDoWOPCRw7hjFW97XGpYsYlliv1OGo7LQnbnRVq
 ePVC4qKssszGf1wTZdoYd8D79+h+3G1uBOECOsikbgdn9IK/TNcJkZb+y18XzZcu0T
 PdAMNTOQ9C6FQ==
Message-ID: <sashiko-outbox-231532@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/9] drm/amdkfd: factor out freeing of per-queue MES
 resources
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124143433.49736-3-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
 <20261124143433.49736-3-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:09:40 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/amdkfd: memory leak in pqm_create_queue() [1]
--

commit 287e7ae4498cc9b3a4da82d8515d5e0f04fa7f42
Author: Armas Spann <zappel@simple-co.de>

drm/amdkfd: factor out freeing of per-queue MES resources

This commit factors out the cleanup of per-queue MES resources
(gang_ctx_array_index, gang_ctx_bo, and wptr_bo_gart) from
pqm_clean_queue_resource() into a new kfd_queue_free_mes_resources()
helper.

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index b68e884b1c37a..89e95b70e2763 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -186,6 +186,21 @@ int pqm_init(struct process_queue_manager *pqm, stru=
ct kfd_process *p)
>  	return 0;
>  }
> =20
> +/*
> + * Free the storage that only exists so MES can run the queue: the gang
> + * context and the GART mapping of the write pointer. MES addresses both
> + * directly, so the queue must be out of MES before this is called.
> + */
> +void kfd_queue_free_mes_resources(struct kfd_node *dev, struct queue *q)
> +{
> +	if (!dev->kfd->shared_resources.enable_mes)
> +		return;
> +
> +	amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, q->gang_ctx_array_index=
);
> +	amdgpu_amdkfd_free_kernel_mem(dev->adev, &q->gang_ctx_bo);
> +	amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&q->wptr_bo_gart);
> +}
> +
>  static void pqm_clean_queue_resource(struct process_queue_manager *pqm,
>  				     struct process_queue_node *pqn)
>  {
> @@ -210,11 +225,7 @@ static void pqm_clean_queue_resource(struct process_=
queue_manager *pqm,
>  		pdd->qpd.num_gws =3D 0;
>  	}
> =20
> -	if (dev->kfd->shared_resources.enable_mes) {
> -		amdgpu_mes_free_gang_ctx_index(&dev->adev->mes, pqn->q->gang_ctx_array=
_index);
> -		amdgpu_amdkfd_free_kernel_mem(dev->adev, &pqn->q->gang_ctx_bo);
> -		amdgpu_amdkfd_free_kernel_mem(dev->adev, (void **)&pqn->q->wptr_bo_gar=
t);
> -	}
> +	kfd_queue_free_mes_resources(dev, pqn->q);
>  }
> =20
>  void pqm_uninit(struct process_queue_manager *pqm)

[Severity: High]
This problem wasn't introduced by this patch, but should pqm_create_queue()
also call kfd_queue_free_mes_resources() on the err_create_queue error path
when q is non-NULL [1]?

init_user_queue() allocates gang_ctx_bo, gang_ctx_array_index, and
wptr_bo_gart before pqm_create_queue() calls dev->dqm->ops.create_queue():

drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c:pqm_create_queue() {
    ...
		retval =3D init_user_queue(pqm, dev, &q, properties, *qid);
		if (retval !=3D 0)
			goto err_create_queue;
		pqn->q =3D q;
		pqn->kq =3D NULL;
		retval =3D dev->dqm->ops.create_queue(dev->dqm, q, &pdd->qpd, q_data,
						    restore_mqd, restore_ctl_stack);
    ...
	if (retval !=3D 0) {
    ...
		goto err_create_queue;
	}
    ...
err_create_queue:
	uninit_queue(q);
	if (kq)
		kernel_queue_uninit(kq);
	kfree(pqn);
    ...
}

If dev->dqm->ops.create_queue() fails, err_create_queue only calls
uninit_queue(q), leaking those MES resources and allowing a local user to
exhaust kernel memory and MES gang context slots.

[1] https://sashiko.dev/#/bug/linux-0b93a0b0-d6d5-41d7-ac1d-c1955556cf28

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124143433.4973=
6-1-zappel@simple-co.de?part=3D2
