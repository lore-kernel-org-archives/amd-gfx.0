Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075D7606A321
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2026 16:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mMa9t2YK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B09C10F772;
	Tue, 24 Nov 2026 16:19:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D1D10F66C
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Nov 2026 16:19:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 23DE8411F4;
 Tue, 24 Nov 2026 16:19:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82D81F000C4;
 Tue, 24 Nov 2026 16:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795537145;
 bh=OGh+pI4wfNer1qWsBB8I9eVV4GlaUxsz+M/dH9Ed3SA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=mMa9t2YKVkPRsnFVjtRRdag0WT4fNB9JKeB2wtmkrMP1aQ+XeWMwrKRiBL+pdryRG
 u+uf3YtdjmGjGUrSnao3a2MXlf5UvLYpS4sltZIfii7zJVogRFswkCvHNHrqp4+yP3
 8/ALLHPN4Gij1YOJWk0t9fB0iM/hwaLLFxfQzTR05st5mUTI96Lf3yP7KAAHEQ8Xtw
 128WVh/XWKDOL2mpRPIqR0wjvqwV6O550J4QMIs7NTPbMP2vjJTCSXeYQJHU3Kz/sO
 CEWhh+FkL8HdHo5kr0hv52tnmtgQfVqfL941KfmqiZSiggISH/1GDRXLKM26RVQXhM
 YfGUpwWStzr0Q==
Message-ID: <sashiko-outbox-231541@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/9] drm/amdgpu/mes: distinguish rejected from timed
 out commands
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261124143433.49736-2-zappel@simple-co.de>
References: <20261124143433.49736-1-zappel@simple-co.de>
 <20261124143433.49736-2-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 16:19:03 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdgpu/mes: global fw_gen incremented per XCC in
  mes_v12_1_xcc_hw_init()
- [Medium] drm/amdgpu/mes: 32-bit status_ptr in
  mes_v12_1_submit_pkt_ticket() drops upper status
- [Medium] drm/amdgpu/mes: missing dma_rmb() in amdgpu_mes_ticket_poll()
--

commit 8b562c80dbe629587cfa83feaa73d36461087d6f
Author: Armas Spann <zappel@simple-co.de>

drm/amdgpu/mes: distinguish rejected from timed out commands

This commit returns AMDGPU_MES_CMD_REJECTED (-EREMOTEIO) when MES
completes a command with a failure status instead of timing out, and adds
command tickets and a firmware generation counter to track timed-out
REMOVE_QUEUE commands.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index b71684d79b21a..fd1d3d7541a0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -329,6 +330,84 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>  	mutex_destroy(&adev->mes.dbgext_drain_lock);
>  }
> =20
> +/* True when MES has processed the command stream up to @seq. */
> +static bool amdgpu_mes_fence_passed(struct amdgpu_ring *ring, u32 seq)
> +{
> +	u32 cur =3D le32_to_cpu(READ_ONCE(*ring->fence_drv.cpu_addr));
> +
> +	return (s32)(seq - cur) <=3D 0;
> +}
> +
> +/**
> + * amdgpu_mes_ticket_poll - check on a command that timed out earlier
> + *
> + * @adev: amdgpu_device pointer
> + * @ticket: ticket filled in by the command path
> + *
> + * Does not sleep and takes no locks. The caller serialises against
> + * amdgpu_mes_ticket_release() on the same ticket.
> + */
> +enum amdgpu_mes_ticket_state
> +amdgpu_mes_ticket_poll(struct amdgpu_device *adev,
> +		       const struct amdgpu_mes_cmd_ticket *ticket)
> +{
> +	const u64 *status;
> +
> +	if (!ticket->valid ||
> +	    ticket->fw_gen !=3D (u32)atomic_read(&adev->mes.fw_gen))
> +		return AMDGPU_MES_TICKET_STALE;
> +
> +	status =3D (const u64 *)&adev->wb.wb[ticket->status_offs];
> +	if (lower_32_bits(READ_ONCE(*status)))
> +		return AMDGPU_MES_TICKET_DONE;
> +
> +	if (!amdgpu_mes_fence_passed(&adev->mes.ring[ticket->ring_idx],
> +				     ticket->seq))
> +		return AMDGPU_MES_TICKET_PENDING;
> +
> +	/* MES writes the status before the trailing fence. Look again. */
> +	return lower_32_bits(READ_ONCE(*status)) ?
> +		AMDGPU_MES_TICKET_DONE : AMDGPU_MES_TICKET_FAILED;
> +}

[Severity: Medium]
Should a dma_rmb() separate the load of *ring->fence_drv.cpu_addr in
amdgpu_mes_fence_passed() from the second READ_ONCE(*status)?

The control dependency on amdgpu_mes_fence_passed() does not order
load-to-load on weakly-ordered architectures.  When a timed-out command
completes concurrently with amdgpu_mes_ticket_poll(), the CPU can satisfy
the second READ_ONCE(*status) from the stale 0 value loaded before the
fence check, returning AMDGPU_MES_TICKET_FAILED for a command that
succeeded.

[ ... ]

> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index 5c046f64b0229..a2e0156ae66b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c

[ ... ]

> @@ -238,7 +241,18 @@ static int mes_v12_1_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
> =20
>  	r =3D amdgpu_fence_wait_polling(ring, seq, timeout);
>  	if (r < 1 || !*status_ptr) {
> -		if (misc_op_str)
> +		/* The fence was reached, so MES processed the command */
> +		bool answered =3D r >=3D 1;
> +
> +		if (answered)
> +			dev_err(adev->dev,
> +				"MES(%d, %d) rejected msg=3D%s (opcode %d), status 0x%016llx\n",
> +				xcc_id, pipe,
> +				misc_op_str ? misc_op_str :
> +				op_str ? op_str : "unknown",
> +				x_pkt->header.opcode,
> +				(unsigned long long)*status_ptr);

[Severity: Medium]
Does dereferencing status_ptr here always print 0x0000000000000000 when
answered is true?

Unlike mes_v11_0 and mes_v12_0, which declare status_ptr as u64 *,
mes_v12_1_submit_pkt_ticket() declares status_ptr as u32 *:

drivers/gpu/drm/amd/amdgpu/mes_v12_1.c:mes_v12_1_submit_pkt_ticket() {
	...
	u32 *status_ptr;
	...
	status_ptr =3D &adev->wb.wb[status_offset];
	*status_ptr =3D 0;
}

Because entering this branch with r >=3D 1 requires !*status_ptr, the
32-bit *status_ptr is guaranteed to be 0 and the firmware error code in
the upper 32 bits of the 64-bit MES_API_STATUS writeback slot is never
read (nor is the upper half cleared before submission).

[ ... ]

> @@ -1901,6 +1941,9 @@ static int mes_v12_1_xcc_hw_init(struct amdgpu_ip_b=
lock *ip_block, int xcc_id)
>  	if (r)
>  		goto failure;
> =20
> +	/* A new scheduler instance is up, it knows none of the old queues */
> +	atomic_inc(&adev->mes.fw_gen);
> +
>  	mes_v12_1_set_hw_resources_1(&adev->mes, AMDGPU_MES_SCHED_PIPE, xcc_id);
>  	mes_v12_1_init_aggregated_doorbell(&adev->mes, xcc_id);

[Severity: High]
Does incrementing a single device-wide adev->mes.fw_gen in
mes_v12_1_xcc_hw_init() invalidate live tickets on other XCCs?

On GFX 12.1 each XCC runs its own MES scheduler instance and can be
reinitialized independently during a partition reset via
gfx_v12_1_xcp_resume() -> gfx_v12_1_xcc_cp_resume() ->
amdgpu_mes_kiq_hw_init() -> mes_v12_1_xcc_hw_init().  Bumping the shared
adev->mes.fw_gen causes amdgpu_mes_ticket_poll() to return
AMDGPU_MES_TICKET_STALE and amdgpu_mes_ticket_answered() to return true
for pending tickets on unreset XCCs, allowing amdgpu_mes_ticket_release()
to free their status writeback slots while those XCCs' MES instances can
still write to them.  Tracking fw_gen per ring or per XCC would avoid
this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124143433.4973=
6-1-zappel@simple-co.de?part=3D1
