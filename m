Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B445606D567
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFmkVrF+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02C8E10E4E2;
	Thu, 12 Nov 2026 14:18:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E20310E4E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2026 14:18:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 31D4943268;
 Thu, 12 Nov 2026 14:18:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011C61F00A05;
 Thu, 12 Nov 2026 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794493121;
 bh=jCbFRoRFHrTDqV9OrekyTrdy8WiXz4eDesU5KRQdr/g=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=RFmkVrF+PFrziqKRadzJ2IQO/JMMTlTL6IlIUzJClOOf+62WgW6Odk60O9+ydlXId
 7kP/j7wbrh79DjuZK5OvA7WJ01ee0Ncz79AwhtwVbOg/B7g4XUcKoExGRY4A8TIaiP
 9l0HVRsncUwJukKJQDVxVgvRyY6MMrHcv7SxhcW/nwWIsB5D2B2LrbzsVVBEVC80c3
 WGA5zHPSOaVq/8scV7HwT53JIFxL8aakT4tCWEMHxCv9qorJdq8IphpzMarWaMgzar
 D1nRnxMaEGJAL80wmRtzrTn+ff+uDHsyUVkJWwWf5oKI/6rDsGy6dysGNgIhqHJLSC
 W/Tv/YHOVloTg==
Message-ID: <sashiko-outbox-211293@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] drm/amdgpu: Run shader cleaner on all XCCs on faults
To: "Kent Russell" <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org
In-Reply-To: <20261112134340.4122401-1-kent.russell@amd.com>
References: <20261112134340.4122401-1-kent.russell@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 14:18:40 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] drm/amdgpu: unsynchronized direct ring submission in
  gfx_v9_clean_shaders()
- [Medium] drm/amdgpu: physical XCC bit index used to index
  compute_ring[]
- [Low] drm/amdgpu: missing Fixes: trailer on multi-XCC fault cleaner
  fix
--

commit 41cd4653f10e59626a5d04f393619df1808489a0
Author: Kent Russell <kent.russell@amd.com>

> drm/amdgpu: Run shader cleaner on all XCCs on faults
>
> The previous patch only ran on XCC0, giving us a good chance that we
> don't clear the right registers on fault handling in MI3. Loop through
> them all to make sure we clear them all.
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>

[Severity: Low]
Since this fixes multi-XCC fault cleaning on MI300, should it include:

  Fixes: 923d09ab1f9a ("drm/amdkfd: Fix TCP XNACK scoreboard reset race on =
MI300")

> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_2.c
> index f54f54fe535e0..dc46133ed5068 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_2.c
> @@ -716,51 +716,67 @@ static int gfx_v9_4_2_do_vgprs_init(struct amdgpu_d=
evice *adev)
> =20
>  static int gfx_v9_clean_shaders(struct amdgpu_device *adev)
>  {
> -	int r;
> +	int r =3D 0;
>  	/* CU_ID: 0~15, SIMD_ID: 0~3, WAVE_ID: 0 ~ 9 */
>  	int wb_size =3D adev->gfx.config.max_shader_engines *
>  			 CU_ID_MAX * SIMD_ID_MAX * WAVE_ID_MAX;
>  	struct amdgpu_ib wb_ib;
> +	struct amdgpu_ring *ring;
>  	struct dma_fence *fence =3D NULL;
>  	u32 pattern =3D 0xa;
> +	int xcc_id;
> =20
> -	/* bail if the compute ring is not ready */
> -	if (!adev->gfx.compute_ring[0].sched.ready)
> +	if (adev->gfx.disable_kq) {
> +		dev_warn(adev->dev, "Cannot run shader cleaner with kernel queues disa=
bled");
>  		return 0;
> -
> -	/* allocate the write-back buffer from IB */
> -	memset(&wb_ib, 0, sizeof(wb_ib));
> -	r =3D amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
> -			  AMDGPU_IB_POOL_DIRECT, &wb_ib);
> -	if (r) {
> -		dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
> -		return r;
>  	}
> -	memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
> =20
> -	r =3D gfx_v9_4_2_run_shader(adev,
> -			&adev->gfx.compute_ring[0],
> -			fault_cleaner_compute_shader_aldebaran,
> -			sizeof(fault_cleaner_compute_shader_aldebaran),
> -			fault_cleaner_init_regs_aldebaran,
> -			ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
> -			adev->gfx.cu_info.number * 32,
> -			wb_ib.gpu_addr, pattern, &fence);
> +	for_each_inst(xcc_id, adev->gfx.xcc_mask) {
> +		ring =3D &adev->gfx.compute_ring[xcc_id * adev->gfx.num_compute_rings];

[Severity: Medium]
Does for_each_inst(xcc_id, adev->gfx.xcc_mask) index adev->gfx.compute_ring=
[]
by physical XCC bit position instead of logical XCC index?

In gfx_v9_4_3_sw_init() and amdgpu_gfx_run_cleaner_shader(),
adev->gfx.compute_ring[] is populated and indexed contiguously for
0 <=3D xcc_id < NUM_XCC(adev->gfx.xcc_mask):

drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:amdgpu_gfx_run_cleaner_shader() {
	int num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
    ...
	for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
		for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
			ring =3D &adev->gfx.compute_ring[i + xcc_id * adev->gfx.num_compute_ring=
s];
    ...
}

When lower physical GC instances are harvested in adev->gfx.xcc_mask,
for_each_inst() skips active logical XCCs at the harvested bit positions
(leaving their GPRs and TCP XNACK scoreboard entries uncleared after a VM
fault) and indexes uninitialized compute_ring[] slots at bit positions
>=3D NUM_XCC(adev->gfx.xcc_mask).

> -	if (r) {
> -		dev_err(adev->dev, "failed to clear MI200\n");
> -		goto pro_end;
> -	}
> +		/* bail if the compute ring is not ready */
> +		if (!ring->sched.ready)
> +			continue;
> =20
> -	/* wait for the GPU to finish processing the IB */
> -	r =3D dma_fence_wait(fence, false);
> -	if (r)
> -		dev_err(adev->dev, "timeout to clear MI200\n");
> +		/* allocate the write-back buffer from IB */
> +		memset(&wb_ib, 0, sizeof(wb_ib));
> +		r =3D amdgpu_ib_get(adev, NULL, (1 + wb_size) * sizeof(uint32_t),
> +				  AMDGPU_IB_POOL_DIRECT, &wb_ib);
> +		if (r) {
> +			dev_err(adev->dev, "failed to get ib (%d) for wb.\n", r);
> +			return r;
> +		}
> +		memset(wb_ib.ptr, 0, (1 + wb_size) * sizeof(uint32_t));
> +
> +		r =3D gfx_v9_4_2_run_shader(adev,
> +				ring,
> +				fault_cleaner_compute_shader_aldebaran,
> +				sizeof(fault_cleaner_compute_shader_aldebaran),
> +				fault_cleaner_init_regs_aldebaran,
> +				ARRAY_SIZE(fault_cleaner_init_regs_aldebaran),
> +				adev->gfx.cu_info.number * 32,
> +				wb_ib.gpu_addr, pattern, &fence);

[Severity: High]
Can calling gfx_v9_4_2_run_shader() across all XCC compute rings race on
struct amdgpu_ring and corrupt the hardware ring buffer and fence state?

gfx_v9_4_2_run_shader() submits directly via amdgpu_job_submit_direct() ->
amdgpu_ib_schedule(), which has no internal lock and relies on the DRM GPU
scheduler to serialize ring access.  On multi-partition MI300 devices,
clean_process_queues_cpsch() only holds the per-partition dqm_lock(dqm) and
a shared read lock on adev->reset_domain->sem before calling
hqd_gfx_clean_fault(adev):

CPU0 (node 0 fault wq)                CPU1 (node 1 fault wq / drm_sched)
clean_process_queues_cpsch(dqm0)      clean_process_queues_cpsch(dqm1)
  dqm_lock(dqm0)                        dqm_lock(dqm1)
  hqd_gfx_clean_fault(adev)             hqd_gfx_clean_fault(adev)
    gfx_v9_clean_shaders(adev)            gfx_v9_clean_shaders(adev)
      gfx_v9_4_2_run_shader(ring)           gfx_v9_4_2_run_shader(ring)
        amdgpu_job_submit_direct()            amdgpu_job_submit_direct()
          amdgpu_ib_schedule(ring)              amdgpu_ib_schedule(ring)
                                                  <-- concurrent ring write

Because each partition's fault handler now walks all XCCs in adev rather
than its own partition, concurrent fault handlers (as well as normal jobs
scheduled on ring->sched) can execute amdgpu_ib_schedule(),
amdgpu_fence_emit(), and amdgpu_ring_commit() simultaneously on the same
compute_ring, interleaving PM4 packets and corrupting ring->wptr,
ring->count_dw, and ring->fence_drv.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112134340.4122=
401-1-kent.russell@amd.com?part=3D1
