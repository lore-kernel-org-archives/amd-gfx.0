Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638D0606A692
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=KcLEUMMu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E2311296C;
	Fri, 27 Nov 2026 09:58:54 +0000 (UTC)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CC2A10E24A
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 06:30:37 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jbNp15hTqzKnc3;
 Fri, 27 Nov 2026 07:30:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; 
 t=1795761033; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gb/dsPvSfnt46i4bxHYvdbfRfnsbJN0yW9avptddaZU=;
 b=KcLEUMMu2Qmdg58MGClLRDxg4BJkR039j4No2WGSO87OCDocpwnWgB4kxBSAoxUwv4Kb07
 BFhoM//Bq+5tCoM36M5FTcL6B+Z5tIFZGyKDWgVWZJCO3qSG07yxrcp8zEVFTt9O79a3K6
 ZprseUnKOiWEb5xWQX2GAFskMha9Ch+eqHUN24ZtjVVmyV/VLVAgVHz79KwVANtAnnTBHE
 8vbZxYvYAi1UtwPNSPUj8eRrsYkullO+whhbVp/E5LlyrU9CNCXYoFKZ3ziK3b85wrVUgs
 3/HCGh8NcQnEfDF4WODoNxK93pjB0D+HgfZ6BrHkWjz652uCpqUnTP4AWKuu4w==
Message-ID: <771c562b59828c0e18607a905979252d97a543d1.camel@mailbox.org>
Subject: Re: [PATCH] drm/amdgpu: switch vm->tlb_seq to dma_fence_chain
 handling v2
From: Philipp Stanner <phasta@mailbox.org>
To: christian.koenig@amd.com, Chong.Li@amd.com, timur.kristof@gmail.com, 
 phasta@kernel.org, amd-gfx@lists.freedesktop.org
Date: Fri, 27 Nov 2026 07:30:32 +0100
In-Reply-To: <20261125153036.3278-1-christian.koenig@amd.com>
References: <20261125153036.3278-1-christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: m1ks6z8y8864icq5wzzi3634f17q4qtc
X-MBO-RS-ID: 2853a1eb66c1e96a6fd
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: phasta@kernel.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-25 at 16:30 +0100, Christian K=C3=B6nig wrote:
> This not only fixes rare GPU page faults in the kernel queues but also
> potentially issues with the user queues should a PDE update make a TLB
> invalidation necessary.
>=20
> v2: also handle the case where the chain head is already signaled as
> =C2=A0=C2=A0=C2=A0 pointed out by Alan.
>=20
> Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Reported-by: Li, Chong(Alan) <Chong.Li@amd.com>

You mention "fixes" above and there was a "report". Cc stable?

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 173 +++++++++---------
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 32 +---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 3 +-
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c=C2=A0=C2=A0 |=C2=A0=C2=
=A0 3 -
> =C2=A0.../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c=C2=A0 |=C2=A0=C2=A0 2 =
+-
> =C2=A05 files changed, 94 insertions(+), 119 deletions(-)

Do you think it might be possible to split this rework up into smaller
commits that are more atomic and, thus, easier to review / understand?

> =C2=A0
> =C2=A0	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
> @@ -2876,10 +2885,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, st=
ruct amdgpu_vm *vm)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 false, MAX_SCHEDULE_TIMEOUT);
> =C2=A0	dma_fence_wait(vm->last_unlocked, false);
> =C2=A0	dma_fence_put(vm->last_unlocked);
> -	dma_fence_wait(vm->last_seq_flush, false);
> -	/* Make sure that all fence callbacks have completed */
> -	dma_fence_lock_irqsave(vm->last_seq_flush, flags);
> -	dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);

Certainly nice to see, but I can't derive from the commit message why
it's now ensured that the fence callbacks have ran?


> =C2=A0	dma_fence_put(vm->last_seq_flush);
> =C2=A0	dma_fence_put(vm->last_tlb_inv);

[=E2=80=A6]

> =C2=A0
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_vm_cpu.c
> index d03b9bbe20c7c..17a579dbf7b90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -122,8 +122,7 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_upda=
te_params *p,
> =C2=A0{
> =C2=A0	struct amdgpu_device *adev =3D p->adev;
> =C2=A0
> -	if (p->needs_flush)
> -		atomic64_inc(&p->vm->tlb_seq);
> +	*fence =3D dma_fence_get_stub();
> =C2=A0
> =C2=A0	mb();

Hey look, an undocumented mb! ^_^

Would be a good opportunity to document why it exists. Does it order
against dma_fence_get_stub()? Seems unlikely=E2=80=A6


