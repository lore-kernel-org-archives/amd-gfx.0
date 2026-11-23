Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153E1606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UCnH8ODm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A071C10EBD4;
	Mon, 23 Nov 2026 10:21:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 756C710EBE1
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 10:21:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3CD9441768;
 Mon, 23 Nov 2026 10:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D43C1F000CA;
 Mon, 23 Nov 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795429261;
 bh=fcmQ6IIqJGu6xkVyTi9ska9QPxaIIXByXWu+v7yDP+4=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=UCnH8ODmMhu+dOwa8Os9oUSgZogiLdrUEBYn7rRekZ30VdrcIIQgAOHr3jwW4hvba
 I/eICEuEZu9zrFP+A6d1f8q0/JfdZzJUQurtuEmUHLbF1uDhTP1FvcsSkl1TXhsJni
 F6aIUF/t/zTOi80mVRkDGunCMGbvl+5zMP0Fa96rCrXloZuKQ9xnk0ybmwBTd9crHr
 fKr7pj/vqzquPK1wYdwLj1Xinxwcr0PLBWy10Y2DDTysT060Ai1shmscbB0+RUBPgr
 G7sQJmn5bEvvyek9/lyTq9XeiNXUVweLldnY3e2WFqLAI7b0iZmEC3K2iNjVMe8tRi
 xEfw+wTQZBYyA==
Message-ID: <sashiko-outbox-229033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdkfd: rebuild CWSR trap buffers after hibernation
To: "Heng Zhou" <Heng.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261123095605.162656-1-Heng.Zhou@amd.com>
References: <20261123095605.162656-1-Heng.Zhou@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:21:00 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/amdkfd: kfd_process_rebuild_cwsr() skips S3 resume due to
  in_s4 check
- [Low] drm/amdkfd: missing Fixes trailer for commit 5088a1ba6d6d
--

commit cee0c9930133433e39014ce7869f89cb97cc145b
Author: Heng Zhou <Heng.Zhou@amd.com>

> drm/amdkfd: rebuild CWSR trap buffers after hibernation
>
> The CWSR trap buffer can reside in pinned VRAM, which is skipped by
> TTM eviction during hibernation. Restoring the process GPUVM mappings
> does not restore the buffer contents. This can lead to SQ errors and
> failed queue preemption after resume.
>
> Keep the second-level TBA/TMA and trap flags in system memory. Rebuild
> the buffer from the trap ISA and saved TMA values and flush HDP before
> restoring process queues.
>
> Signed-off-by: Heng Zhou <Heng.Zhou@amd.com>

[Severity: Low]
This fixes the regression introduced when CWSR trap buffers were moved to
pinned VRAM in 5088a1ba6d6d ("drm/amdkfd: move TBA/TMA from system to
device memory").  Should the commit message include:

  Fixes: 5088a1ba6d6d ("drm/amdkfd: move TBA/TMA from system to device memo=
ry")

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 546721b4d59ac..342ad7178ed69 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c

[ ... ]

> @@ -1681,12 +1683,40 @@ void kfd_process_set_trap_debug_flag(struct qcm_p=
rocess_device *qpd,
>  				     bool enabled)
>  {
>  	if (!iosys_map_is_null(&qpd->cwsr_map)) {
> +		qpd->cwsr_tma_flags =3D enabled;
>  		iosys_map_wr(&qpd->cwsr_map,
>  			     KFD_CWSR_TMA_OFFSET + 2 * sizeof(uint64_t),
>  			     uint64_t, enabled);
>  	}
>  }
> =20
> +static void kfd_process_rebuild_cwsr(struct kfd_process *p)
> +{
> +	struct kfd_process_device *pdd;
> +	struct qcm_process_device *qpd;
> +	int i;
> +
> +	for (i =3D 0; i < p->n_pdds; i++) {
> +		pdd =3D p->pdds[i];
> +		qpd =3D &pdd->qpd;
> +
> +		if (!pdd->dev->adev->in_s4 || !qpd->cwsr_base ||
> +		    iosys_map_is_null(&qpd->cwsr_map))
> +			continue;

[Severity: Medium]
Does checking !pdd->dev->adev->in_s4 leave the VRAM CWSR trap buffer
uninitialized after an S3 suspend/resume cycle?

All discrete GPUs with GC >=3D 9.4.2 (including GFX10, GFX11 and GFX12
dGPUs) allocate and pin qpd->cwsr_mem in VRAM.  During S3 suspend,
amdgpu_device_evict_resources() evicts unpinned VRAM BOs while skipping
the pinned qpd->cwsr_mem BO, and VRAM loses its contents while the dGPU is
powered down.  Because adev->in_s3 is set instead of adev->in_s4,
kfd_process_rebuild_cwsr() skips the rebuild on S3 resume before
restore_process_helper() restores the queues, leading to the same SQ
errors and failed queue preemption when CWSR executes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123095605.1626=
56-1-Heng.Zhou@amd.com?part=3D1
