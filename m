Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD9A606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Nov 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQf4EWCT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933A410E79E;
	Mon, 23 Nov 2026 10:04:12 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A54C10E79E
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2026 10:04:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 45EB161F1E;
 Mon, 23 Nov 2026 10:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8641F000D8;
 Mon, 23 Nov 2026 10:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795428244;
 bh=Rq9c42NysILGtx1hlyIcjUl/B7Ahm/d0iGHmAnhLHow=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lQf4EWCTgMouRBmJqkfdOQRqgBfyLm/Id7UkMEhsUoxY6DwHh0TqJAS/2kUYo53ss
 4XNfqa0LqauyMtGy88pT4USrhHOgwPiJe1y5O/RyMpapXm0mL+gBrIjV8DQGWtK5wR
 R2MIgucNNYuumP9jZ+C8xVhmbNX/f4hwg0G12wWbd+Z2rna9kpfMtvulv6cu7gLHvU
 gfQRIjng0yfoS6z3Dkv5bVMn89BRDMPzwBgLwPOvSkdbdkfV5umlQpgkiWqpFL8iIS
 nHfygZKqe8Erwvg54yima7oQLaXmiVEy8Jv7+aY2uj7UznSnkLRLiJt1L/QO5WXZsi
 tE96r22/iIgdg==
Message-ID: <sashiko-outbox-229024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] amdkfd: don't give a GPU access to SVM ranges when no VM
To: "Zhu Lingshan" <lingshan.zhu@amd.com>
Cc: amd-gfx@lists.freedesktop.org
In-Reply-To: <20261123094229.12597-1-lingshan.zhu@amd.com>
References: <20261123094229.12597-1-lingshan.zhu@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:04:04 +0000
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
- [High] drm/amdkfd: missing drm_priv check for location attrs in
  svm_range_check_attr()
- [Medium] drm/amdkfd: svm_range_get_attr() reports default access for
  VM-less GPUs
--

commit c034a8aa5ef1d29d58a7b5188aa7d91ba73e78a9
Author: Zhu Lingshan <lingshan.zhu@amd.com>

amdkfd: don't give a GPU access to SVM ranges when no VM

This commit prevents GPUs whose kfd_process_device has not acquired a VM
from receiving default access to new SVM ranges when XNACK is enabled, and
rejects setting SVM access attributes for such GPUs in
svm_range_check_attr().

> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index a571fda5c713a..042ac8081f082 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -339,6 +339,7 @@ svm_range *svm_range_new(struct svm_range_list *svms,=
 uint64_t start,
>  	uint64_t size =3D last - start + 1;
>  	struct svm_range *prange;
>  	struct kfd_process *p;
> +	int i;
> =20
>  	prange =3D kzalloc_obj(*prange);
>  	if (!prange)
> @@ -367,9 +368,17 @@ svm_range *svm_range_new(struct svm_range_list *svms=
, uint64_t start,
>  	mutex_init(&prange->migrate_mutex);
>  	mutex_init(&prange->lock);
> =20
> -	if (p->xnack_enabled)
> +	if (p->xnack_enabled) {
>  		bitmap_copy(prange->bitmap_access, svms->bitmap_supported,
>  			    MAX_GPU_INSTANCE);
> +		for_each_set_bit(i, svms->bitmap_supported, p->n_pdds) {
> +			if (!p->pdds[i]->drm_priv) {
> +				pr_debug("GPU %d has no VM acquired, skip mapping SVM range [0x%llx =
0x%llx] to it\n",
> +					 p->pdds[i]->user_gpu_id, start, last);
> +				clear_bit(i, prange->bitmap_access);
> +			}
> +		}
> +	}

[Severity: Medium]
Should svm_range_get_attr() also clear bits for GPUs with
!p->pdds[i]->drm_priv when reporting default attributes for an
unregistered range?

drivers/gpu/drm/amd/amdkfd/kfd_svm.c:svm_range_get_attr() {
	...
	node =3D interval_tree_iter_first(&svms->objects, start, last);
	if (!node) {
		pr_debug("range attrs not found return default values\n");
		svm_range_set_default_attributes(svms, &location, &prefetch_loc,
						 &granularity, &flags_and);
		flags_or =3D flags_and;
		if (p->xnack_enabled)
			bitmap_copy(bitmap_access, svms->bitmap_supported,
				    MAX_GPU_INSTANCE);
	...
}

When p->xnack_enabled is true and an address range is not yet in
svms->objects, KFD_IOCTL_SVM_OP_GET_ATTR still copies
svms->bitmap_supported into bitmap_access without excluding GPUs where
drm_priv is NULL.  It then reports KFD_IOCTL_SVM_ATTR_ACCESS for those
GPUs, contradicting the default bitmap_access initialized by
svm_range_new() and causing a subsequent KFD_IOCTL_SVM_OP_SET_ATTR with
the queried attributes to fail with -EINVAL in svm_range_check_attr().

> @@ -722,6 +731,13 @@ svm_range_check_attr(struct kfd_process *p,
>  			break;
>  		case KFD_IOCTL_SVM_ATTR_ACCESS:
>  		case KFD_IOCTL_SVM_ATTR_ACCESS_IN_PLACE:
> +			gpuidx =3D kfd_process_gpuidx_from_gpuid(p, val);
> +			if (gpuidx >=3D 0 && !p->pdds[gpuidx]->drm_priv) {
> +				pr_debug("GPU %d has no VM acquired, so SVM does not work on it, ple=
ase acquire VM for it first\n",
> +					 val);
> +				return -EINVAL;
> +			}
> +			break;
>  		case KFD_IOCTL_SVM_ATTR_NO_ACCESS:
>  			gpuidx =3D kfd_process_gpuidx_from_gpuid(p, val);
>  			break;

[Severity: High]
Does svm_range_check_attr() also need to reject GPUs with
!p->pdds[gpuidx]->drm_priv for KFD_IOCTL_SVM_ATTR_PREFERRED_LOC and
KFD_IOCTL_SVM_ATTR_PREFETCH_LOC?

Because the drm_priv check is only performed for ACCESS and
ACCESS_IN_PLACE, a process that has acquired a VM on one GPU can pass
another GPU whose pdd->drm_priv is NULL as PREFETCH_LOC or PREFERRED_LOC.
svm_range_set_attr() -> svm_range_trigger_migration() ->
svm_migrate_to_vram() will then allocate a VRAM BO and migrate pages via
SDMA onto an unacquired GPU that has not gone through
kfd_bind_process_to_device().

When p->xnack_enabled is true and the range is later validated for another
GPU, svm_range_validate_and_map() only adds prange->actual_loc to
ctx->bitmap if test_bit(gpuidx, prange->bitmap_access) is set.  Since
svm_range_new() cleared the unacquired GPU's bit in prange->bitmap_access,
actual_loc is omitted from ctx->bitmap and owner is not cleared to NULL,
causing amdgpu_hmm_range_get_pages() -> hmm_range_fault() to fault on the
unacquired GPU's device-private pages while svm_migrate_to_ram() skips
migration because p->svms.faulting_task =3D=3D current.

Checking !p->pdds[gpuidx]->drm_priv after the switch alongside the
existing gpuidx validation would cover all GPU-targeted attributes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123094229.1259=
7-1-lingshan.zhu@amd.com?part=3D1
