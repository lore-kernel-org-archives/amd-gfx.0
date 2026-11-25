Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F40606A31E
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U79LP3h4
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36F7A10E106;
	Wed, 25 Nov 2026 14:33:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0AA10E106
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 14:33:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9BEF40C33;
 Wed, 25 Nov 2026 14:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46C691F000C0;
 Wed, 25 Nov 2026 14:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795617225;
 bh=uxj1wXvk/xpj7fC+EM+bsys6zVj5tsEBU6pNtQ9yw1Q=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=U79LP3h4Xn9c/gNTvmF2rGaZLHeby3VvyTUsFxHq4N7HSge9MMBa/3ZfQwMDyZh+l
 TVUR5OqYe/0WoJw0QjPrtjvg2Ebs7vu7c3/lCKhJZISyMnd19hgvCMivy8hrJrlmPV
 ZTqJ9QeZwOCwUKbkXliIOLKwUuDxf9guB4HhH72bQfNWTAMDBheRSGfqIGX8pskuQC
 VlmhzXWj5sO6Bb2R914wBD5UxFRN99rGV8vkhaQDTAH6aeu8GQfMTXl/fkmd3/W4BY
 FsJ72A1s+cQ8obBe1Sg8a7Qkp+j1IXqFcPqtjhVbqTbbrDbD8gd0gI/x0y09G5k9lb
 aLyk/ZPdxfoIQ==
Message-ID: <sashiko-outbox-233568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: Add checkpoint handler for mqd 12.1
To: "David Francis" <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125141554.2195270-1-David.Francis@amd.com>
References: <20261125141554.2195270-1-David.Francis@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 14:33:44 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdkfd: heap buffer overflow in checkpoint_mqd_v12_1() on
  SDMA queues
- [Medium] drm/amdkfd: missing multi-XCC iteration in
  checkpoint_mqd_v12_1()
--

commit b939ab2a38bf0604406a6b6f7f0e390220c671fb
Author: David Francis <David.Francis@amd.com>

drm/amdkfd: Add checkpoint handler for mqd 12.1

This commit adds a CRIU checkpoint callback for GFX 12.1 and wires it to
compute and SDMA MQD managers in mqd_manager_init_v12_1().

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c b/drivers=
/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> index 0c116fc8bb532..1a3b3c7103c1f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v12_1.c
> @@ -671,6 +671,15 @@ static int debugfs_show_mqd_sdma(struct seq_file *m,=
 void *data)
> =20
>  #endif
> =20
> +static void checkpoint_mqd_v12_1(struct mqd_manager *mm, void *mqd, void=
 *mqd_dst, void *ctl_stack_dst)
> +{
> +	struct v12_1_compute_mqd *m;
> +
> +	m =3D get_mqd(mqd);
> +
> +	memcpy(mqd_dst, m, sizeof(struct v12_1_compute_mqd));
> +}

[Severity: Medium]
Does checkpoint_mqd_v12_1() need to iterate over NUM_XCC(mm->dev->xcc_mask)
at m->cp_mqd_stride_size stride, like checkpoint_mqd_v9_4_3()?

get_queue_checkpoint_info() sizes the checkpoint buffer for
mqd_mgr->mqd_size * NUM_XCC(mqd_mgr->dev->xcc_mask) bytes, and
criu_checkpoint_queues_device() expects mqd[xcc0], mqd[xcc1], ... in
mqd_dst.  Copying only a single struct v12_1_compute_mqd leaves the
remaining XCC slots zeroed when checkpointing a compute queue on a
multi-XCC GFX 12.1 partition.

[ ... ]

> @@ -813,6 +823,7 @@ struct mqd_manager *mqd_manager_init_v12_1(enum KFD_M=
QD_TYPE type,
>  		mqd->is_occupied =3D kfd_is_occupied_sdma;
>  		mqd->mqd_size =3D sizeof(struct v12_1_sdma_mqd);
>  		mqd->mqd_stride =3D kfd_mqd_stride;
> +		mqd->checkpoint_mqd =3D checkpoint_mqd_v12_1;
>  		mqd->restore_mqd =3D restore_mqd_sdma_v12_1;
>  #if defined(CONFIG_DEBUG_FS)
>  		mqd->debugfs_show_mqd =3D debugfs_show_mqd_sdma;

[Severity: High]
Can wiring checkpoint_mqd_v12_1() to KFD_MQD_TYPE_SDMA overflow the
q_private_data heap buffer in criu_checkpoint_queues_device()?

For SDMA queues, mqd->mqd_size is sizeof(struct v12_1_sdma_mqd) (512
bytes), so criu_checkpoint_queues_device() allocates 512 * NUM_XCC bytes
for mqd_dst, whereas checkpoint_mqd_v12_1() copies
sizeof(struct v12_1_compute_mqd) (4096 bytes).  Should KFD_MQD_TYPE_SDMA
use a dedicated checkpoint_mqd_sdma_v12_1() callback that copies
sizeof(struct v12_1_sdma_mqd) via get_sdma_mqd(), matching
restore_mqd_sdma_v12_1()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125141554.2195=
270-1-David.Francis@amd.com?part=3D1
