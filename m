From: =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: GART write flush error on SI w/ amdgpu
Date: Tue, 9 May 2017 14:13:40 +0200
Message-ID: <c53a99e5-eea0-17d1-05e6-b6e66746d774@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------170777DC169FA80DC081A666"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--------------170777DC169FA80DC081A666
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I'm seeing some very strange errors on Verde with CPU readback from 
GART, and am pretty much out of ideas. Some help would be very much 
appreciated.

The error manifests with the 
GL45-CTS.gtf32.GL3Tests.packed_pixels.packed_pixels_pbo test on amdgpu, 
but *not* on radeon. Here's what the test does:

1. Upload a texture.
2. Read the texture back via a shader that uses shader buffer writes to 
write data to a buffer that is allocated in GART.
3. The CPU then reads from the buffer -- and sometimes gets stale data.

This sequence is repeated for many sub-tests. There are some sub-tests 
where the CPU reads stale data from the buffer, i.e. the shader writes 
simply don't make it to the CPU. The tests vary superficially, e.g. the 
first failing test is (almost?) always one where data is written in 
16-bit words (but there are succeeding sub-tests with 16-bit writes as 
well).

The bug is *not* a timing issue. Adding even a 1sec delay (sleep(1);) 
between the fence wait and the return of glMapBuffer does not fix the 
problem. The data must be stuck in a cache somewhere.

Since the test runs okay with the radeon module, I tried some changes 
based on comparing the IB submit between radeon and amdgpu, and based on 
comparing register settings via scans obtained from umr. Some of the 
things I've tried:

- Set HDP_MISC_CNTL.FLUSH_INVALIDATE_CACHE to 1 (both radeon and 
amdgpu/gfx9 set this)
- Add SURFACE_SYNC packets preceded by setting CP_COHER_CNTL2 to the 
vmid (radeon does this)
- Change gfx_v6_0_ring_emit_hdp_invalidate: select ME engine instead of 
PFP (which seems more logical, and is done by gfx7+), or remove the 
corresponding WRITE_DATA entirely

None of these changes helped.

What *does* help is adding an artificial wait. Specifically, I'm adding 
a sequence of

- WRITE_DATA
- CACHE_FLUSH_AND_INV_TS_EVENT (BOTTOM_OF_PIPE_TS has same behavior)
- WAIT_REG_MEM

as can be seen in the attached patch. This works around the problem, but 
it makes no sense:

Adding the wait sequence *before* the SURFACE_SYNC in ring_emit_fence 
works around the problem. However(!) it does not actually cause the UMD 
to wait any longer than before. Without this change, the UMD immediately 
sees a signaled user fence (and never uses an ioctl to wait), and with 
this change, it *still* sees a signaled user fence.

Also, note that the way I've hacked the change, the wait sequence is 
only added for the user fence emit (and I'm using a modified UMD to 
ensure that there is enough memory to be used by the added wait sequence).

Adding the wait sequence *after* the SURFACE_SYNC *doesn't* work around 
the problem.

So for whatever reason, the added wait sequence *before* the 
SURFACE_SYNC encourages some part of the GPU to flush the data from 
wherever it's stuck, and that's just really bizarre. There must be 
something really simple I'm missing, and any pointers would be appreciated.

Thanks,
Nicolai
-- 
Lerne, wie die Welt wirklich ist,
Aber vergiss niemals, wie sie sein sollte.

--------------170777DC169FA80DC081A666
Content-Type: text/x-patch;
 name="gfx6_hacks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="gfx6_hacks.diff"

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 6e20536..c1715bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -226,20 +226,23 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 
 	/* wrap the last IB with fence */
 	if (job && job->uf_addr) {
 		amdgpu_ring_emit_fence(ring, job->vm_id, job->uf_addr, job->uf_sequence,
 				       AMDGPU_FENCE_FLAG_64BIT);
 	}
 
 	if (patch_offset != ~0 && ring->funcs->patch_cond_exec)
 		amdgpu_ring_patch_cond_exec(ring, patch_offset);
 
+// 	if (job && ring->funcs->emit_hack)
+// 		ring->funcs->emit_hack(ring, job->vm_id, job->uf_addr + 8);
+
 	ring->current_ctx = fence_ctx;
 	if (vm && ring->funcs->emit_switch_buffer)
 		amdgpu_ring_emit_switch_buffer(ring);
 	amdgpu_ring_commit(ring);
 	return 0;
 }
 
 /**
  * amdgpu_ib_pool_init - Init the IB (Indirect Buffer) pool
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 5f10aa6..2c37e9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1867,37 +1867,89 @@ static void gfx_v6_0_ring_emit_vgt_flush(struct amdgpu_ring *ring)
 static void gfx_v6_0_ring_emit_hdp_invalidate(struct amdgpu_ring *ring)
 {
 	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
 	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) | /* engine = 0? */
 				 WRITE_DATA_DST_SEL(0)));
 	amdgpu_ring_write(ring, mmHDP_DEBUG0);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, 0x1);
 }
 
+static void gfx_v6_0_ring_emit_hack(struct amdgpu_ring *ring, unsigned vm_id, uint64_t addr)
+{
+	bool write64bit = false;
+	bool int_sel = false;
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WRITE_DATA, 3));
+	amdgpu_ring_write(ring, (WRITE_DATA_ENGINE_SEL(0) |
+				 (1 << 20) | /* write confirm */
+				 WRITE_DATA_DST_SEL(1)));
+	amdgpu_ring_write(ring, addr & 0xfffffffc);
+	amdgpu_ring_write(ring, (upper_32_bits(addr) & 0xffff));
+	amdgpu_ring_write(ring, 0xdeadbeef);
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
+// 	amdgpu_ring_write(ring, EVENT_TYPE(BOTTOM_OF_PIPE_TS) | EVENT_INDEX(5));
+	amdgpu_ring_write(ring, EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) | EVENT_INDEX(5));
+	amdgpu_ring_write(ring, addr & 0xfffffffc);
+	amdgpu_ring_write(ring, (upper_32_bits(addr) & 0xffff) |
+				((write64bit ? 2 : 1) << CP_EOP_DONE_DATA_CNTL__DATA_SEL__SHIFT) |
+				((int_sel ? 2 : 0) << CP_EOP_DONE_DATA_CNTL__INT_SEL__SHIFT));
+	amdgpu_ring_write(ring, 0xcafecafe);
+	amdgpu_ring_write(ring, 0); /* unused */
+
+	amdgpu_ring_write(ring, PACKET3(PACKET3_WAIT_REG_MEM, 5));
+	amdgpu_ring_write(ring, (WAIT_REG_MEM_MEM_SPACE(1) | /* memory */
+				 WAIT_REG_MEM_FUNCTION(3) | /* equal */
+				 WAIT_REG_MEM_ENGINE(0)));   /* use me */
+	amdgpu_ring_write(ring, addr & 0xfffffffc);
+	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
+	amdgpu_ring_write(ring, 0xcafecafe);
+	amdgpu_ring_write(ring, 0xffffffff);
+	amdgpu_ring_write(ring, 4); /* poll interval */
+}
+
 static void gfx_v6_0_ring_emit_fence(struct amdgpu_ring *ring, unsigned vmid, u64 addr,
 				     u64 seq, unsigned flags)
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
 	bool int_sel = flags & AMDGPU_FENCE_FLAG_INT;
+
+	if (write64bit)
+		gfx_v6_0_ring_emit_hack(ring, 0, addr + 8);
+
 	/* flush read cache over gart */
+	if (false && vmid != 0) {
+		amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONFIG_REG, 1));
+		amdgpu_ring_write(ring, (mmCP_COHER_CNTL2 - PACKET3_SET_CONFIG_REG_START));
+		amdgpu_ring_write(ring, vmid);
+		amdgpu_ring_write(ring, PACKET3(PACKET3_SURFACE_SYNC, 3));
+		amdgpu_ring_write(ring, PACKET3_TCL1_ACTION_ENA |
+				  PACKET3_TC_ACTION_ENA |
+				  PACKET3_SH_KCACHE_ACTION_ENA |
+				  PACKET3_SH_ICACHE_ACTION_ENA);
+		amdgpu_ring_write(ring, 0xFFFFFFFF);
+		amdgpu_ring_write(ring, 0);
+		amdgpu_ring_write(ring, 10); /* poll interval */
+	}
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SET_CONFIG_REG, 1));
 	amdgpu_ring_write(ring, (mmCP_COHER_CNTL2 - PACKET3_SET_CONFIG_REG_START));
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, PACKET3(PACKET3_SURFACE_SYNC, 3));
 	amdgpu_ring_write(ring, PACKET3_TCL1_ACTION_ENA |
 			  PACKET3_TC_ACTION_ENA |
 			  PACKET3_SH_KCACHE_ACTION_ENA |
 			  PACKET3_SH_ICACHE_ACTION_ENA);
 	amdgpu_ring_write(ring, 0xFFFFFFFF);
 	amdgpu_ring_write(ring, 0);
 	amdgpu_ring_write(ring, 10); /* poll interval */
+
 	/* EVENT_WRITE_EOP - flush caches, send int */
 	amdgpu_ring_write(ring, PACKET3(PACKET3_EVENT_WRITE_EOP, 4));
 	amdgpu_ring_write(ring, EVENT_TYPE(CACHE_FLUSH_AND_INV_TS_EVENT) | EVENT_INDEX(5));
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, (upper_32_bits(addr) & 0xffff) |
 				((write64bit ? 2 : 1) << CP_EOP_DONE_DATA_CNTL__DATA_SEL__SHIFT) |
 				((int_sel ? 2 : 0) << CP_EOP_DONE_DATA_CNTL__INT_SEL__SHIFT));
 	amdgpu_ring_write(ring, lower_32_bits(seq));
 	amdgpu_ring_write(ring, upper_32_bits(seq));
 }
@@ -3640,28 +3692,30 @@ static const struct amd_ip_funcs gfx_v6_0_ip_funcs = {
 
 static const struct amdgpu_ring_funcs gfx_v6_0_ring_funcs_gfx = {
 	.type = AMDGPU_RING_TYPE_GFX,
 	.align_mask = 0xff,
 	.nop = 0x80000000,
 	.support_64bit_ptrs = false,
 	.get_rptr = gfx_v6_0_ring_get_rptr,
 	.get_wptr = gfx_v6_0_ring_get_wptr,
 	.set_wptr = gfx_v6_0_ring_set_wptr_gfx,
 	.emit_frame_size =
+		32 + /* slack for hack */
 		5 + /* gfx_v6_0_ring_emit_hdp_flush */
 		5 + /* gfx_v6_0_ring_emit_hdp_invalidate */
 		14 + 14 + 14 + /* gfx_v6_0_ring_emit_fence x3 for user fence, vm fence */
 		7 + 4 + /* gfx_v6_0_ring_emit_pipeline_sync */
 		17 + 6 + /* gfx_v6_0_ring_emit_vm_flush */
 		3 + 2, /* gfx_v6_ring_emit_cntxcntl including vgt flush */
 	.emit_ib_size = 6 + 8, /* gfx_v6_0_ring_emit_ib */
 	.emit_ib = gfx_v6_0_ring_emit_ib,
+	.emit_hack = gfx_v6_0_ring_emit_hack,
 	.emit_fence = gfx_v6_0_ring_emit_fence,
 	.emit_pipeline_sync = gfx_v6_0_ring_emit_pipeline_sync,
 	.emit_vm_flush = gfx_v6_0_ring_emit_vm_flush,
 	.emit_hdp_flush = gfx_v6_0_ring_emit_hdp_flush,
 	.emit_hdp_invalidate = gfx_v6_0_ring_emit_hdp_invalidate,
 	.test_ring = gfx_v6_0_ring_test_ring,
 	.test_ib = gfx_v6_0_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
 	.emit_cntxcntl = gfx_v6_ring_emit_cntxcntl,
 };

--------------170777DC169FA80DC081A666
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------170777DC169FA80DC081A666--
