Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6F6606A32A
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OG9KEf9P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E836A10E676;
	Tue, 17 Nov 2026 19:37:59 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CEC10E676
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 19:37:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 96A6E45BBC;
 Tue, 17 Nov 2026 19:37:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26981F000C6;
 Tue, 17 Nov 2026 19:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794944273;
 bh=3ZlLlHBn6Y/XqMSeC59HGqpOx5+R6gP6z32JYx48qiA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=OG9KEf9PuPKMzEffPnbIpmU+/A+ouhJ2BQOCSs7up208saKeNLWjjPfBkwPI0fF/+
 eKlwS3FN5CIwQSoOkWMcUQzLSL3Md3f6bP05w+/QTL14Oe9R9U9J3OSWAtWtgT4ZUZ
 UfXlVIHPeDhgyaymJq4PMBr9Swq6I0dOlHJBjeHapwzOvZAXPSALW00oBDu7P/GDWD
 AvDmxgWqoMJlJ7UdE5FBgJoP86lUigZ1sAk7DCGaNCHGQOMbGGTosm3RhYnbc5OlYG
 JAUaq9a8kh4LYYtSzbwGliYVEthJny1YyKnKK0mmZFsYNr63pNFm9HedeP+UBvSiZf
 uNj7N9CyCBBug==
Message-ID: <sashiko-outbox-219507@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] drm/amdgpu/mes11: add support for setting gang submit
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261117192415.810117-3-alexander.deucher@amd.com>
References: <20261117192415.810117-1-alexander.deucher@amd.com>
 <20261117192415.810117-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 19:37:52 +0000
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
- [High] drm/amdgpu: unrolled sync_seq increment on MES error_undo paths
  [1]
--

commit 285ec5bbb9066cd84ed61683a42ebeae06434475
Author: Alex Deucher <alexander.deucher@amd.com>

drm/amdgpu/mes11: add support for setting gang submit

This commit implements the set_gang_submit callback for MES v11 to allow a
primary and secondary queue to schedule together.

> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v11_0.c
> index 75e6079e6e332..d67dbc93e10d4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -1275,6 +1275,27 @@ static int mes_v11_0_enable_dbgext_irq(struct amdg=
pu_mes *mes, bool enable)
>  	return 0;
>  }
> =20
> +static int mes_v11_0_set_gang_submit(struct amdgpu_mes *mes,
> +				     struct mes_set_gang_submit_input *input)
> +{
> +	union MESAPI__SET_GANG_SUBMIT mes_gang_submit_pkt;
> +
> +	memset(&mes_gang_submit_pkt, 0, sizeof(mes_gang_submit_pkt));
> +
> +	mes_gang_submit_pkt.header.type =3D MES_API_TYPE_SCHEDULER;
> +	mes_gang_submit_pkt.header.opcode =3D MES_SCH_API_SET_GANG_SUBMIT;
> +	mes_gang_submit_pkt.header.dwsize =3D API_FRAME_SIZE_IN_DWORDS;
> +
> +	mes_gang_submit_pkt.set_gang_submit.gang_context_addr =3D
> +		input->primary_gang_context_addr;
> +	mes_gang_submit_pkt.set_gang_submit.slave_gang_context_addr =3D
> +		input->secondary_gang_context_addr;
> +
> +	return mes_v11_0_submit_pkt_and_poll_completion(mes,
> +			&mes_gang_submit_pkt, sizeof(mes_gang_submit_pkt),
> +			offsetof(union MESAPI__SET_GANG_SUBMIT, api_status));
> +}

[Severity: High]
This problem wasn't introduced by this patch, but can
mes_v11_0_submit_pkt_and_poll_completion() leave ring->fence_drv.sync_seq
incremented when amdgpu_fence_wait_polling() times out [1]?

drivers/gpu/drm/amd/amdgpu/mes_v11_0.c:mes_v11_0_submit_pkt_and_poll_comple=
tion() {
	...
	seq =3D ++ring->fence_drv.sync_seq;
	r =3D amdgpu_fence_wait_polling(ring,
				      seq - ring->fence_drv.num_fences_mask,
				      timeout);
	if (r < 1) {
		r =3D -ETIMEDOUT;
		goto error_undo;
	}
	...
error_undo:
	dev_err(adev->dev, "MES ring buffer is full.\n");
	amdgpu_ring_undo(ring);
	...
}

The error_undo path rolls back the ring write pointer without decrementing
ring->fence_drv.sync_seq and without emitting the status fence packet.
Once ring->fence_drv.num_fences_mask timeouts accumulate, seq -
ring->fence_drv.num_fences_mask exceeds the highest fence sequence number
ever emitted to the ring, causing all subsequent MES submissions to time
out waiting on an unemitted fence until a GPU reset.  The same issue also
exists in mes_v12_0_submit_pkt_and_poll_completion() and
mes_v12_1_submit_pkt_and_poll_completion().

[1] https://sashiko.dev/#/bug/linux-dce92d12-1446-4f12-a395-575847569192

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117192415.8101=
17-1-alexander.deucher@amd.com?part=3D3
