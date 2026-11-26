Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21223606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pj3x/r+X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 908AC112158;
	Thu, 26 Nov 2026 08:36:18 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09A6B112158
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 08:36:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CD6B741223;
 Thu, 26 Nov 2026 08:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA451F000D1;
 Thu, 26 Nov 2026 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795682171;
 bh=plaqTR6E0b/jvyRvK53J18mNxxRatlbBe3RlSOnJAYA=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=Pj3x/r+X4Bgs4h5ggJlCB4sTq4vUmLh64d47I+PL6ulSH7oqpBTOKMlqaQa49skOD
 mSUnQXoSv/cHgsI0Xl27Rafd5KZHgY77qD07wkYrYT3wM9SXhx6PEZKv8kqFjXdrfK
 aztdnwdDJ36c0lQ1Eoe7o1xzbGJMHYy8yofOFNCDZKiVQKEzzkuG2WH4+vHyVjPSDv
 Df/ZTfShlF84at6OPg3vsWSFjXQ0HmTZ1pa57MgDIkqKHMPUkveKo1OGrh/wljZfQn
 OqyOCGq/hKn4BlF5y33Ei4qbPOJigROxDkvJQ9OIqkezMo8KAEokNjizJ70gS4Ltx4
 +V04c9LtWNqvg==
Message-ID: <sashiko-outbox-235042@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/9] drm/amdgpu/mes: distinguish rejected from timed
 out commands
To: "Armas Spann" <zappel@simple-co.de>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261125141933.154222-2-zappel@simple-co.de>
References: <20261125141933.154222-1-zappel@simple-co.de>
 <20261125141933.154222-2-zappel@simple-co.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 08:36:11 +0000
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
- [Medium] drm/amdgpu/mes: fence advances before fw_gen increment on MES
  reset/init
- [Medium] drm/amdgpu/mes: uninitialized ticket on ring-full timeout and
  poll check
--

commit e4539326964865817146e78f0e47609a33f0c453
Author: Armas Spann <zappel@simple-co.de>

drm/amdgpu/mes: distinguish rejected from timed out commands

This commit returns AMDGPU_MES_CMD_REJECTED (-EREMOTEIO) when MES responds
to a command with a failure status instead of timing out, and adds a
command ticket mechanism and per-XCC firmware generation counter to track
timed-out REMOVE_QUEUE commands across late completions and MES restarts.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_mes.c
> index b71684d79b21a..c7beee52a790b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c

[ ... ]

> @@ -329,6 +331,89 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
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
> +	    ticket->fw_gen !=3D amdgpu_mes_fw_gen(&adev->mes, ticket->xcc_id))
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
> +	/*
> +	 * MES writes the status before the trailing fence. Look again, and
> +	 * do not let that look be satisfied by a load made before the fence
> +	 * was seen.
> +	 */
> +	dma_rmb();
> +	return lower_32_bits(READ_ONCE(*status)) ?
> +		AMDGPU_MES_TICKET_DONE : AMDGPU_MES_TICKET_FAILED;
> +}

[Severity: Medium]
Can amdgpu_mes_ticket_poll() misreport a stale ticket as
AMDGPU_MES_TICKET_FAILED across a reset or MES re-initialization?

Both during GPU reset and during MES hardware initialization, the
scheduler ring's trailing fence advances to or past ticket->seq before
adev->mes.fw_gen[xcc_id] is incremented:

1. In amdgpu_device_pre_asic_reset(), amdgpu_fence_driver_force_completion()
   writes ring->fence_drv.sync_seq (>=3D ticket->seq) to
   *ring->fence_drv.cpu_addr before MES is suspended or re-initialized.
2. In mes_v11_0_hw_init(), mes_v12_0_hw_init(), and
   mes_v12_1_xcc_hw_init(), mes_v*_queue_init() clears the scheduler ring
   and mes_v*_set_hw_resources() submits a command on that ring that
   waits for the new MES instance to write a new sequence number
   (> ticket->seq) to *ring->fence_drv.cpu_addr before atomic_inc() updates
   fw_gen.

CPU0                                  CPU1
amdgpu_mes_ticket_poll()              mes_v12_0_hw_init()
                                        mes_v12_0_queue_init()
                                          amdgpu_ring_clear_ring()
                                        mes_v12_0_set_hw_resources()
                                          /* fence advances past ticket->se=
q */
  ticket->fw_gen =3D=3D fw_gen
  amdgpu_mes_fence_passed() =3D=3D true
  *status =3D=3D 0
  return AMDGPU_MES_TICKET_FAILED;  <-- stale ticket reported as failed
                                        atomic_inc(&adev->mes.fw_gen[0]);

Because *status is still 0 after the unanswered command was wiped,
amdgpu_mes_ticket_poll() returns AMDGPU_MES_TICKET_FAILED instead of
AMDGPU_MES_TICKET_STALE, and amdgpu_mes_ticket_answered() returns true
before MES is halted or fw_gen reflects the new instance.  In addition,
amdgpu_mes_ticket_poll() does not re-check fw_gen after observing
amdgpu_mes_fence_passed(), and mes_v*_submit_pkt_ticket() records
ticket->fw_gen after the 2.1s poll timeout rather than under ring_lock at
submission time.

> +
> +/**
> + * amdgpu_mes_ticket_answered - has MES got past a timed out command
> + *
> + * @adev: amdgpu_device pointer
> + * @ticket: ticket, or a copy of one
> + *
> + * Unlike amdgpu_mes_ticket_poll() this does not look at the status slot,
> + * so it may be used on a copy whose original has been released.
> + */
> +bool amdgpu_mes_ticket_answered(struct amdgpu_device *adev,
> +				const struct amdgpu_mes_cmd_ticket *ticket)
> +{
> +	if (ticket->fw_gen !=3D amdgpu_mes_fw_gen(&adev->mes, ticket->xcc_id))
> +		return true;
> +
> +	return amdgpu_mes_fence_passed(&adev->mes.ring[ticket->ring_idx],
> +				       ticket->seq);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/mes_v12_1.c
> index 5c046f64b0229..5fabf05d5584a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -154,9 +154,10 @@ static const char *mes_v12_1_get_misc_op_string(unio=
n MESAPI__MISC *x_pkt)
>  	return op_str;
>  }
> =20
> -static int mes_v12_1_submit_pkt_and_poll_completion(struct amdgpu_mes *m=
es,
> -					    int xcc_id, int pipe, void *pkt,
> -					    int size, int api_status_off)
> +static int mes_v12_1_submit_pkt_ticket(struct amdgpu_mes *mes,
> +				       int xcc_id, int pipe, void *pkt,
> +				       int size, int api_status_off,
> +				       struct amdgpu_mes_cmd_ticket *ticket)
>  {

[ ... ]

> @@ -200,8 +201,10 @@ static int mes_v12_1_submit_pkt_and_poll_completion(=
struct amdgpu_mes *mes,
>  	r =3D amdgpu_fence_wait_polling(ring,
>  				      seq - ring->fence_drv.num_fences_mask,
>  				      timeout);
> -	if (r < 1)
> +	if (r < 1) {
> +		r =3D -ETIMEDOUT;
>  		goto error_undo;
> +	}

[Severity: Medium]
What happens to *ticket when mes_v11_0_submit_pkt_ticket(),
mes_v12_0_submit_pkt_ticket(), or mes_v12_1_submit_pkt_ticket() returns
-ETIMEDOUT on the error_undo path because the ring is full?

On that path the command is undone with amdgpu_ring_undo(), status_offset
is freed, and the function returns -ETIMEDOUT without initializing or
clearing *ticket.  A caller that receives -ETIMEDOUT from remove_hw_queue()
and inspects the ticket will either read uninitialized fields or, if the
ticket was zeroed by the caller, see ticket->valid =3D=3D false (which makes
amdgpu_mes_ticket_poll() return AMDGPU_MES_TICKET_STALE) and
ticket->fw_gen =3D=3D 0 (which makes amdgpu_mes_ticket_answered(), as it do=
es
not check ticket->valid, compare 0 against fw_gen >=3D 1 and return true, or
index adev->mes.fw_gen[ticket->xcc_id] and
adev->mes.ring[ticket->ring_idx] with untrusted values).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125141933.1542=
22-1-zappel@simple-co.de?part=3D1
