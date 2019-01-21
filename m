From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: add flags to emit_ib interface v2
Date: Mon, 21 Jan 2019 09:18:50 +0000
Message-ID: <20fa8f99-8e50-4434-993b-789657a79851@email.android.com>
References: <1548053413-16767-1-git-send-email-Jack.Xiao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0930107173=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1548053413-16767-1-git-send-email-Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
Content-Language: de-DE
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
To: "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Zhang,
 Hawking" <Hawking.Zhang-5C7GfCeVMHo@public.gmane.org>

--===============0930107173==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_20fa8f998e504434993b789657a79851emailandroidcom_"

--_000_20fa8f998e504434993b789657a79851emailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Am 21.01.2019 07:57 schrieb "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>:
Replace the last bool type parameter with a general flags parameter,
to make the last parameter be able to contain more information.

v2: drop setting need_ctx_switch =3D false

Signed-off-by: Jack Xiao <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h  |  2 +-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c    |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_dma.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c    |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  6 +++---
 20 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c
index c48207b3..0b8ef2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -202,12 +202,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsi=
gned num_ibs,
                         amdgpu_asic_flush_hdp(adev, ring);
         }

+       if (need_ctx_switch)
+               status |=3D AMDGPU_HAVE_CTX_SWITCH;
+
         skip_preamble =3D ring->current_ctx =3D=3D fence_ctx;
         if (job && ring->funcs->emit_cntxcntl) {
-               if (need_ctx_switch)
-                       status |=3D AMDGPU_HAVE_CTX_SWITCH;
                 status |=3D job->preamble_status;
-
                 amdgpu_ring_emit_cntxcntl(ring, status);
         }

@@ -221,8 +221,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsign=
ed num_ibs,
                         !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, P=
reamble CE ib must be inserted anyway */
                         continue;

-               amdgpu_ring_emit_ib(ring, job, ib, need_ctx_switch);
-               need_ctx_switch =3D false;
+               amdgpu_ring_emit_ib(ring, job, ib, status);
+               status &=3D ~AMDGPU_HAVE_CTX_SWITCH;
         }

         if (ring->funcs->emit_tmz)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h
index d87e828..d7fae26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -131,7 +131,7 @@ struct amdgpu_ring_funcs {
         void (*emit_ib)(struct amdgpu_ring *ring,
                         struct amdgpu_job *job,
                         struct amdgpu_ib *ib,
-                       bool ctx_switch);
+                       uint32_t flags);
         void (*emit_fence)(struct amdgpu_ring *ring, uint64_t addr,
                            uint64_t seq, unsigned flags);
         void (*emit_pipeline_sync)(struct amdgpu_ring *ring);
@@ -229,7 +229,7 @@ struct amdgpu_ring {
 #define amdgpu_ring_get_rptr(r) (r)->funcs->get_rptr((r))
 #define amdgpu_ring_get_wptr(r) (r)->funcs->get_wptr((r))
 #define amdgpu_ring_set_wptr(r) (r)->funcs->set_wptr((r))
-#define amdgpu_ring_emit_ib(r, job, ib, c) ((r)->funcs->emit_ib((r), (job)=
, (ib), (c)))
+#define amdgpu_ring_emit_ib(r, job, ib, flags) ((r)->funcs->emit_ib((r), (=
job), (ib), (flags)))
 #define amdgpu_ring_emit_pipeline_sync(r) (r)->funcs->emit_pipeline_sync((=
r))
 #define amdgpu_ring_emit_vm_flush(r, vmid, addr) (r)->funcs->emit_vm_flush=
((r), (vmid), (addr))
 #define amdgpu_ring_emit_fence(r, addr, seq, flags) (r)->funcs->emit_fence=
((r), (addr), (seq), (flags))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.c
index 98a1b2c..c021b11 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -1035,7 +1035,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_pars=
er *p, uint32_t ib_idx)
 void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring,
                                 struct amdgpu_job *job,
                                 struct amdgpu_ib *ib,
-                               bool ctx_switch)
+                               uint32_t flags)
 {
         amdgpu_ring_write(ring, VCE_CMD_IB);
         amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.h
index 5029365..30ea54d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -66,7 +66,7 @@ int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, =
uint32_t handle,
 int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx);
 int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p, uint32_t ib_id=
x);
 void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *=
job,
-                               struct amdgpu_ib *ib, bool ctx_switch);
+                               struct amdgpu_ib *ib, uint32_t flags);
 void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se=
q,
                                 unsigned flags);
 int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/am=
dgpu/cik_sdma.c
index 4579519..189599b 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -220,7 +220,7 @@ static void cik_sdma_ring_insert_nop(struct amdgpu_ring=
 *ring, uint32_t count)
 static void cik_sdma_ring_emit_ib(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job,
                                   struct amdgpu_ib *ib,
-                                 bool ctx_switch)
+                                 uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         u32 extra_bits =3D vmid & 0xf;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v6_0.c
index 1dc3013..305276c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1842,13 +1842,13 @@ static void gfx_v6_0_ring_emit_fence(struct amdgpu_=
ring *ring, u64 addr,
 static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job,
                                   struct amdgpu_ib *ib,
-                                 bool ctx_switch)
+                                 uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         u32 header, control =3D 0;

         /* insert SWITCH_BUFFER packet before first IB in the ring frame *=
/
-       if (ctx_switch) {
+       if (flags & AMDGPU_HAVE_CTX_SWITCH) {
                 amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0))=
;
                 amdgpu_ring_write(ring, 0);
         }
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c
index 3a9fb60..7984292 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2228,13 +2228,13 @@ static void gfx_v7_0_ring_emit_fence_compute(struct=
 amdgpu_ring *ring,
 static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
                                         struct amdgpu_job *job,
                                         struct amdgpu_ib *ib,
-                                       bool ctx_switch)
+                                       uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         u32 header, control =3D 0;

         /* insert SWITCH_BUFFER packet before first IB in the ring frame *=
/
-       if (ctx_switch) {
+       if (flags & AMDGPU_HAVE_CTX_SWITCH) {
                 amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER, 0))=
;
                 amdgpu_ring_write(ring, 0);
         }
@@ -2259,7 +2259,7 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_r=
ing *ring,
 static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
                                           struct amdgpu_job *job,
                                           struct amdgpu_ib *ib,
-                                         bool ctx_switch)
+                                         uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 2=
4);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c
index 57cb3a5..a267476 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -6047,7 +6047,7 @@ static void gfx_v8_0_ring_emit_vgt_flush(struct amdgp=
u_ring *ring)
 static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
                                         struct amdgpu_job *job,
                                         struct amdgpu_ib *ib,
-                                       bool ctx_switch)
+                                       uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         u32 header, control =3D 0;
@@ -6079,7 +6079,7 @@ static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_r=
ing *ring,
 static void gfx_v8_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
                                           struct amdgpu_job *job,
                                           struct amdgpu_ib *ib,
-                                         bool ctx_switch)
+                                         uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 2=
4);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c
index fbca049..262ee3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3972,7 +3972,7 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct amdgp=
u_ring *ring)
 static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
                                         struct amdgpu_job *job,
                                         struct amdgpu_ib *ib,
-                                       bool ctx_switch)
+                                       uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         u32 header, control =3D 0;
@@ -4005,7 +4005,7 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_r=
ing *ring,
 static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,
                                           struct amdgpu_job *job,
                                           struct amdgpu_ib *ib,
-                                         bool ctx_switch)
+                                         uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         u32 control =3D INDIRECT_BUFFER_VALID | ib->length_dw | (vmid << 2=
4);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v2_4.c
index 9f3cb2a..cca3552 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -247,7 +247,7 @@ static void sdma_v2_4_ring_insert_nop(struct amdgpu_rin=
g *ring, uint32_t count)
 static void sdma_v2_4_ring_emit_ib(struct amdgpu_ring *ring,
                                    struct amdgpu_job *job,
                                    struct amdgpu_ib *ib,
-                                  bool ctx_switch)
+                                  uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v3_0.c
index 06c5a27..0ce8331 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -421,7 +421,7 @@ static void sdma_v3_0_ring_insert_nop(struct amdgpu_rin=
g *ring, uint32_t count)
 static void sdma_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
                                    struct amdgpu_job *job,
                                    struct amdgpu_ib *ib,
-                                  bool ctx_switch)
+                                  uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index 48a166b..127b859 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -500,7 +500,7 @@ static void sdma_v4_0_ring_insert_nop(struct amdgpu_rin=
g *ring, uint32_t count)
 static void sdma_v4_0_ring_emit_ib(struct amdgpu_ring *ring,
                                    struct amdgpu_job *job,
                                    struct amdgpu_ib *ib,
-                                  bool ctx_switch)
+                                  uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdg=
pu/si_dma.c
index b6e4731..f15f196 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -63,7 +63,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ring=
)
 static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
                                 struct amdgpu_job *job,
                                 struct amdgpu_ib *ib,
-                               bool ctx_switch)
+                               uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
         /* The indirect buffer packet must end on an 8 DW boundary in the =
DMA ring.
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v4_2.c
index d69c8f6..c4fb586 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -511,7 +511,7 @@ static int uvd_v4_2_ring_test_ring(struct amdgpu_ring *=
ring)
 static void uvd_v4_2_ring_emit_ib(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job,
                                   struct amdgpu_ib *ib,
-                                 bool ctx_switch)
+                                 uint32_t flags)
 {
         amdgpu_ring_write(ring, PACKET0(mmUVD_RBC_IB_BASE, 0));
         amdgpu_ring_write(ring, ib->gpu_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v5_0.c
index ee8cd06..52bd8a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -526,7 +526,7 @@ static int uvd_v5_0_ring_test_ring(struct amdgpu_ring *=
ring)
 static void uvd_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job,
                                   struct amdgpu_ib *ib,
-                                 bool ctx_switch)
+                                 uint32_t flags)
 {
         amdgpu_ring_write(ring, PACKET0(mmUVD_LMI_RBC_IB_64BIT_BAR_LOW, 0)=
);
         amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c
index d4f4a66..c9edddf 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -977,7 +977,7 @@ static int uvd_v6_0_ring_test_ring(struct amdgpu_ring *=
ring)
 static void uvd_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job,
                                   struct amdgpu_ib *ib,
-                                 bool ctx_switch)
+                                 uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

@@ -1003,7 +1003,7 @@ static void uvd_v6_0_ring_emit_ib(struct amdgpu_ring =
*ring,
 static void uvd_v6_0_enc_ring_emit_ib(struct amdgpu_ring *ring,
                                         struct amdgpu_job *job,
                                         struct amdgpu_ib *ib,
-                                       bool ctx_switch)
+                                       uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v7_0.c
index aef9240..dc461df 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1272,7 +1272,7 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct amd=
gpu_cs_parser *p,
 static void uvd_v7_0_ring_emit_ib(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job,
                                   struct amdgpu_ib *ib,
-                                 bool ctx_switch)
+                                 uint32_t flags)
 {
         struct amdgpu_device *adev =3D ring->adev;
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
@@ -1303,7 +1303,7 @@ static void uvd_v7_0_ring_emit_ib(struct amdgpu_ring =
*ring,
 static void uvd_v7_0_enc_ring_emit_ib(struct amdgpu_ring *ring,
                                         struct amdgpu_job *job,
                                         struct amdgpu_ib *ib,
-                                       bool ctx_switch)
+                                       uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 2668eff..6ec65cf1 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -834,7 +834,7 @@ static void vce_v3_0_get_clockgating_state(void *handle=
, u32 *flags)
 static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
                                   struct amdgpu_job *job,
                                   struct amdgpu_ib *ib,
-                                 bool ctx_switch)
+                                 uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v4_0.c
index 9fb34b7..aadc3e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c
@@ -947,7 +947,7 @@ static int vce_v4_0_set_powergating_state(void *handle,
 #endif

 static void vce_v4_0_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_=
job *job,
-                                       struct amdgpu_ib *ib, bool ctx_swit=
ch)
+                                       struct amdgpu_ib *ib, uint32_t flag=
s)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c
index 89bb2fe..3dbc51f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1371,7 +1371,7 @@ static void vcn_v1_0_dec_ring_emit_fence(struct amdgp=
u_ring *ring, u64 addr, u64
 static void vcn_v1_0_dec_ring_emit_ib(struct amdgpu_ring *ring,
                                         struct amdgpu_job *job,
                                         struct amdgpu_ib *ib,
-                                       bool ctx_switch)
+                                       uint32_t flags)
 {
         struct amdgpu_device *adev =3D ring->adev;
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
@@ -1531,7 +1531,7 @@ static void vcn_v1_0_enc_ring_insert_end(struct amdgp=
u_ring *ring)
 static void vcn_v1_0_enc_ring_emit_ib(struct amdgpu_ring *ring,
                                         struct amdgpu_job *job,
                                         struct amdgpu_ib *ib,
-                                       bool ctx_switch)
+                                       uint32_t flags)
 {
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);

@@ -1736,7 +1736,7 @@ static void vcn_v1_0_jpeg_ring_emit_fence(struct amdg=
pu_ring *ring, u64 addr, u6
 static void vcn_v1_0_jpeg_ring_emit_ib(struct amdgpu_ring *ring,
                                         struct amdgpu_job *job,
                                         struct amdgpu_ib *ib,
-                                       bool ctx_switch)
+                                       uint32_t flags)
 {
         struct amdgpu_device *adev =3D ring->adev;
         unsigned vmid =3D AMDGPU_JOB_GET_VMID(job);
--
1.9.1


--_000_20fa8f998e504434993b789657a79851emailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto">Reviewed-by: Christian K=F6nig &lt;christian.koenig@amd.c=
om&gt;</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 21.01.2019 07:57 schrieb &quot;Xiao, Jack&q=
uot; &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">Replace the last bool type parameter with a genera=
l flags parameter,<br>
to make the last parameter be able to contain more information.<br>
<br>
v2: drop setting need_ctx_switch =3D false<br>
<br>
Signed-off-by: Jack Xiao &lt;Jack.Xiao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp;&nbsp; | 10 &#43;&#43;&#4=
3;&#43;&#43;-----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |&nbsp; 4 &#43;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h&nbsp; |&nbsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 6 &#4=
3;&#43;&#43;---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c&nbsp;&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c&nbsp;&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c&nbsp;&nbsp; |&nbsp; 2 &#43;-<b=
r>
&nbsp;drivers/gpu/drm/amd/amdgpu/si_dma.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&n=
bsp; 2 &#43;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 4 &#4=
3;&#43;--<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v3_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v4_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 2 &#4=
3;-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c&nbsp;&nbsp;&nbsp; |&nbsp; 6 &#4=
3;&#43;&#43;---<br>
&nbsp;20 files changed, 34 insertions(&#43;), 34 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_ib.c<br>
index c48207b3..0b8ef2d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
@@ -202,12 &#43;202,12 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, =
unsigned num_ibs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgp=
u_asic_flush_hdp(adev, ring);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (need_ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; status |=3D AMDGPU_HAVE_CTX_SWITCH;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; skip_preamble =3D ring-&gt=
;current_ctx =3D=3D fence_ctx;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job &amp;&amp; ring-&g=
t;funcs-&gt;emit_cntxcntl) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (need_ctx_switch)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; status |=3D AMDG=
PU_HAVE_CTX_SWITCH;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; status |=3D job-&gt;preamble_status;<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_emit_cntxcntl(ring, status);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -221,8 &#43;221,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, un=
signed num_ibs,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !amdg=
pu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted=
 anyway */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; conti=
nue;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; amdgpu_ring_emit_ib(ring, job, ib, need_ctx_switch);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; need_ctx_switch =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; amdgpu_ring_emit_ib(ring, job, ib, status);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; status &amp;=3D ~AMDGPU_HAVE_CTX_SWITCH;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;emi=
t_tmz)<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_ring.h<br>
index d87e828..d7fae26 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
@@ -131,7 &#43;131,7 @@ struct amdgpu_ring_funcs {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*emit_ib)(struct amd=
gpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struc=
t amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)=
;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t fla=
gs);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*emit_fence)(struct =
amdgpu_ring *ring, uint64_t addr,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint64_t seq, unsigned flags);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*emit_pipeline_sync)=
(struct amdgpu_ring *ring);<br>
@@ -229,7 &#43;229,7 @@ struct amdgpu_ring {<br>
&nbsp;#define amdgpu_ring_get_rptr(r) (r)-&gt;funcs-&gt;get_rptr((r))<br>
&nbsp;#define amdgpu_ring_get_wptr(r) (r)-&gt;funcs-&gt;get_wptr((r))<br>
&nbsp;#define amdgpu_ring_set_wptr(r) (r)-&gt;funcs-&gt;set_wptr((r))<br>
-#define amdgpu_ring_emit_ib(r, job, ib, c) ((r)-&gt;funcs-&gt;emit_ib((r),=
 (job), (ib), (c)))<br>
&#43;#define amdgpu_ring_emit_ib(r, job, ib, flags) ((r)-&gt;funcs-&gt;emit=
_ib((r), (job), (ib), (flags)))<br>
&nbsp;#define amdgpu_ring_emit_pipeline_sync(r) (r)-&gt;funcs-&gt;emit_pipe=
line_sync((r))<br>
&nbsp;#define amdgpu_ring_emit_vm_flush(r, vmid, addr) (r)-&gt;funcs-&gt;em=
it_vm_flush((r), (vmid), (addr))<br>
&nbsp;#define amdgpu_ring_emit_fence(r, addr, seq, flags) (r)-&gt;funcs-&gt=
;emit_fence((r), (addr), (seq), (flags))<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.c<br>
index 98a1b2c..c021b11 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c<br>
@@ -1035,7 &#43;1035,7 @@ int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_=
parser *p, uint32_t ib_idx)<br>
&nbsp;void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VC=
E_CMD_IB);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lo=
wer_32_bits(ib-&gt;gpu_addr));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vce.h<br>
index 5029365..30ea54d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h<br>
@@ -66,7 &#43;66,7 @@ int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ri=
ng, uint32_t handle,<br>
&nbsp;int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_=
idx);<br>
&nbsp;int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p, uint32_t =
ib_idx);<br>
&nbsp;void amdgpu_vce_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_=
job *job,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib, bool ctx_switch);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib, uint32_t flags);<=
br>
&nbsp;void amdgpu_vce_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u=
64 seq,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned flags);<br>
&nbsp;int amdgpu_vce_ring_test_ring(struct amdgpu_ring *ring);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/am=
dgpu/cik_sdma.c<br>
index 4579519..189599b 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
@@ -220,7 &#43;220,7 @@ static void cik_sdma_ring_insert_nop(struct amdgpu_=
ring *ring, uint32_t count)<br>
&nbsp;static void cik_sdma_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 extra_bits =3D vmid &a=
mp; 0xf;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v6_0.c<br>
index 1dc3013..305276c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
@@ -1842,13 &#43;1842,13 @@ static void gfx_v6_0_ring_emit_fence(struct amd=
gpu_ring *ring, u64 addr,<br>
&nbsp;static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 header, control =3D 0;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* insert SWITCH_BUFFER pa=
cket before first IB in the ring frame */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx_switch) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; AMDGPU_HAVE_CTX_S=
WITCH) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER=
, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v7_0.c<br>
index 3a9fb60..7984292 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
@@ -2228,13 &#43;2228,13 @@ static void gfx_v7_0_ring_emit_fence_compute(st=
ruct amdgpu_ring *ring,<br>
&nbsp;static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 header, control =3D 0;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* insert SWITCH_BUFFER pa=
cket before first IB in the ring frame */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ctx_switch) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (flags &amp; AMDGPU_HAVE_CTX_S=
WITCH) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PACKET3(PACKET3_SWITCH_BUFFER=
, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
@@ -2259,7 &#43;2259,7 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdg=
pu_ring *ring,<br>
&nbsp;static void gfx_v7_0_ring_emit_ib_compute(struct amdgpu_ring *ring,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 control =3D INDIRECT_B=
UFFER_VALID | ib-&gt;length_dw | (vmid &lt;&lt; 24);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v8_0.c<br>
index 57cb3a5..a267476 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
@@ -6047,7 &#43;6047,7 @@ static void gfx_v8_0_ring_emit_vgt_flush(struct a=
mdgpu_ring *ring)<br>
&nbsp;static void gfx_v8_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 header, control =3D 0;=
<br>
@@ -6079,7 &#43;6079,7 @@ static void gfx_v8_0_ring_emit_ib_gfx(struct amdg=
pu_ring *ring,<br>
&nbsp;static void gfx_v8_0_ring_emit_ib_compute(struct amdgpu_ring *ring,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 control =3D INDIRECT_B=
UFFER_VALID | ib-&gt;length_dw | (vmid &lt;&lt; 24);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/am=
dgpu/gfx_v9_0.c<br>
index fbca049..262ee3c 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
@@ -3972,7 &#43;3972,7 @@ static void gfx_v9_0_ring_emit_hdp_flush(struct a=
mdgpu_ring *ring)<br>
&nbsp;static void gfx_v9_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 header, control =3D 0;=
<br>
@@ -4005,7 &#43;4005,7 @@ static void gfx_v9_0_ring_emit_ib_gfx(struct amdg=
pu_ring *ring,<br>
&nbsp;static void gfx_v9_0_ring_emit_ib_compute(struct amdgpu_ring *ring,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 control =3D INDIRECT_B=
UFFER_VALID | ib-&gt;length_dw | (vmid &lt;&lt; 24);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v2_4.c<br>
index 9f3cb2a..cca3552 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
@@ -247,7 &#43;247,7 @@ static void sdma_v2_4_ring_insert_nop(struct amdgpu=
_ring *ring, uint32_t count)<br>
&nbsp;static void sdma_v2_4_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v3_0.c<br>
index 06c5a27..0ce8331 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
@@ -421,7 &#43;421,7 @@ static void sdma_v3_0_ring_insert_nop(struct amdgpu=
_ring *ring, uint32_t count)<br>
&nbsp;static void sdma_v3_0_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index 48a166b..127b859 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -500,7 &#43;500,7 @@ static void sdma_v4_0_ring_insert_nop(struct amdgpu=
_ring *ring, uint32_t count)<br>
&nbsp;static void sdma_v4_0_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_=
ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdg=
pu/si_dma.c<br>
index b6e4731..f15f196 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
@@ -63,7 &#43;63,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *=
ring)<br>
&nbsp;static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* The indirect buffer pac=
ket must end on an 8 DW boundary in the DMA ring.<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v4_2.c<br>
index d69c8f6..c4fb586 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c<br>
@@ -511,7 &#43;511,7 @@ static int uvd_v4_2_ring_test_ring(struct amdgpu_ri=
ng *ring)<br>
&nbsp;static void uvd_v4_2_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_RBC_IB_BASE, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, ib=
-&gt;gpu_addr);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v5_0.c<br>
index ee8cd06..52bd8a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c<br>
@@ -526,7 &#43;526,7 @@ static int uvd_v5_0_ring_test_ring(struct amdgpu_ri=
ng *ring)<br>
&nbsp;static void uvd_v5_0_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, PA=
CKET0(mmUVD_LMI_RBC_IB_64BIT_BAR_LOW, 0));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, lo=
wer_32_bits(ib-&gt;gpu_addr));<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v6_0.c<br>
index d4f4a66..c9edddf 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c<br>
@@ -977,7 &#43;977,7 @@ static int uvd_v6_0_ring_test_ring(struct amdgpu_ri=
ng *ring)<br>
&nbsp;static void uvd_v6_0_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
@@ -1003,7 &#43;1003,7 @@ static void uvd_v6_0_ring_emit_ib(struct amdgpu_r=
ing *ring,<br>
&nbsp;static void uvd_v6_0_enc_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/am=
dgpu/uvd_v7_0.c<br>
index aef9240..dc461df 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
@@ -1272,7 &#43;1272,7 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct=
 amdgpu_cs_parser *p,<br>
&nbsp;static void uvd_v7_0_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
@@ -1303,7 &#43;1303,7 @@ static void uvd_v7_0_ring_emit_ib(struct amdgpu_r=
ing *ring,<br>
&nbsp;static void uvd_v7_0_enc_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c<br>
index 2668eff..6ec65cf1 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
@@ -834,7 &#43;834,7 @@ static void vce_v3_0_get_clockgating_state(void *ha=
ndle, u32 *flags)<br>
&nbsp;static void vce_v3_0_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job *j=
ob,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ib *ib=
,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v4_0.c<br>
index 9fb34b7..aadc3e6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v4_0.c<br>
@@ -947,7 &#43;947,7 @@ static int vce_v4_0_set_powergating_state(void *han=
dle,<br>
&nbsp;#endif<br>
&nbsp;<br>
&nbsp;static void vce_v4_0_ring_emit_ib(struct amdgpu_ring *ring, struct am=
dgpu_job *job,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; struct amdgpu_ib *ib, bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct amdgpu_ib *ib, uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c<br>
index 89bb2fe..3dbc51f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
@@ -1371,7 &#43;1371,7 @@ static void vcn_v1_0_dec_ring_emit_fence(struct a=
mdgpu_ring *ring, u64 addr, u64<br>
&nbsp;static void vcn_v1_0_dec_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
@@ -1531,7 &#43;1531,7 @@ static void vcn_v1_0_enc_ring_insert_end(struct a=
mdgpu_ring *ring)<br>
&nbsp;static void vcn_v1_0_enc_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
&nbsp;<br>
@@ -1736,7 &#43;1736,7 @@ static void vcn_v1_0_jpeg_ring_emit_fence(struct =
amdgpu_ring *ring, u64 addr, u6<br>
&nbsp;static void vcn_v1_0_jpeg_ring_emit_ib(struct amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_job *job,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; struct amdgpu_ib *ib,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; bool ctx_switch)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t flags)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned vmid =3D AMDGPU_J=
OB_GET_VMID(job);<br>
-- <br>
1.9.1<br>
<br>
</div>
</span></font>
</body>
</html>

--_000_20fa8f998e504434993b789657a79851emailandroidcom_--

--===============0930107173==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0930107173==--
