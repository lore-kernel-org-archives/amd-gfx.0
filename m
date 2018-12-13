From: Huaisheng Ye <yehs2007@zoho.com>
Subject: [PATCH] drm/amd/display: fix compiler warnings about wm variable
Date: Thu, 13 Dec 2018 17:34:54 +0800
Message-ID: <20181213093454.10872-1-yehs2007@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, harry.wentland@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, tony.cheng@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, chengnt@lenovo.com, Huaisheng Ye <yehs1@lenovo.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Huaisheng Ye <yehs1@lenovo.com>

There are compiler warnings within functions 'dcn10_log_hubbub_state=E2=80=
=99
and 'dcn10_get_hubbub_state=E2=80=99. This patch avoids the compiler report=
s
the following warning when building amdgpu.ko.

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In fun=
ction =E2=80=98dcn10_log_hubbub_state=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:94:9: w=
arning: missing braces around initializer [-Wmissing-braces]
  struct dcn_hubbub_wm wm =3D {0};
         ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:94:9: w=
arning: (near initialization for =E2=80=98wm.sets=E2=80=99) [-Wmissing-brac=
es]

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer_debug.c: =
In function =E2=80=98dcn10_get_hubbub_state=E2=80=99:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer_debug.c:7=
4:9: warning: missing braces around initializer [-Wmissing-braces]
  struct dcn_hubbub_wm wm =3D {0};
         ^
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer_debug.c:7=
4:9: warning: (near initialization for =E2=80=98wm.sets=E2=80=99) [-Wmissin=
g-braces]

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c       | 3 ++-
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/dr=
ivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 193184a..e96933a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -91,9 +91,10 @@ static void log_mpc_crc(struct dc *dc,
 void dcn10_log_hubbub_state(struct dc *dc, struct dc_log_buffer_ctx *log_c=
tx)
 {
 =09struct dc_context *dc_ctx =3D dc->ctx;
-=09struct dcn_hubbub_wm wm =3D {0};
+=09struct dcn_hubbub_wm wm;
 =09int i;
=20
+=09memset(&wm, 0, sizeof(struct dcn_hubbub_wm));
 =09hubbub1_wm_read_state(dc->res_pool->hubbub, &wm);
=20
 =09DTN_INFO("HUBBUB WM:      data_urgent  pte_meta_urgent"
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.=
c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 6415890..f5610ea 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -71,7 +71,7 @@ static unsigned int snprintf_count(char *pBuf, unsigned i=
nt bufSize, char *fmt,
 static unsigned int dcn10_get_hubbub_state(struct dc *dc, char *pBuf, unsi=
gned int bufSize)
 {
 =09struct dc_context *dc_ctx =3D dc->ctx;
-=09struct dcn_hubbub_wm wm =3D {0};
+=09struct dcn_hubbub_wm wm;
 =09int i;
=20
 =09unsigned int chars_printed =3D 0;
@@ -80,6 +80,7 @@ static unsigned int dcn10_get_hubbub_state(struct dc *dc,=
 char *pBuf, unsigned i
 =09const uint32_t ref_clk_mhz =3D dc_ctx->dc->res_pool->ref_clock_inKhz / =
1000;
 =09static const unsigned int frac =3D 1000;
=20
+=09memset(&wm, 0, sizeof(struct dcn_hubbub_wm));
 =09hubbub1_wm_read_state(dc->res_pool->hubbub, &wm);
=20
 =09chars_printed =3D snprintf_count(pBuf, remaining_buffer, "wm_set_index,=
data_urgent,pte_meta_urgent,sr_enter,sr_exit,dram_clk_chanage\n");
--=20
1.8.3.1
