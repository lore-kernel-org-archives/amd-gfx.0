From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: return tcc_disabled_mask to userspace
Date: Wed, 25 Sep 2019 17:05:10 -0400
Message-ID: <CAAxE2A7vPH-S-Fjk+CfjR+zEZ-hjkTtS=gsBBgbGiD2iNJbOJA@mail.gmail.com>
References: <20190924222901.5621-1-maraeo@gmail.com>
 <CADnq5_N=b0RWk-t8MnjiTNUcr35ZQ5GYMOw2H_oGQOjpGGzeHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0727494074=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CADnq5_N=b0RWk-t8MnjiTNUcr35ZQ5GYMOw2H_oGQOjpGGzeHQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0727494074==
Content-Type: multipart/alternative; boundary="00000000000050d1a2059367047b"

--00000000000050d1a2059367047b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think TCCs are global, because all memory traffic from gfx
engines+cp+sdma has to go through TCCs, e.g. memory requests from different
SEs accessing the same memory address go to the same TCC.

Marek

On Tue, Sep 24, 2019 at 10:58 PM Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote=
:

> On Tue, Sep 24, 2019 at 6:29 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
> >
> > From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> >
> > UMDs need this for correct programming of harvested chips.
> >
> > Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  3 ++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  2 ++
> >  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 11 +++++++++++
> >  include/uapi/drm/amdgpu_drm.h           |  2 ++
> >  5 files changed, 18 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index f82d634cf3f9..b70b30378c20 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -75,23 +75,24 @@
> >   * - 3.25.0 - Add support for sensor query info (stable pstate
> sclk/mclk).
> >   * - 3.26.0 - GFX9: Process AMDGPU_IB_FLAG_TC_WB_NOT_INVALIDATE.
> >   * - 3.27.0 - Add new chunk to to AMDGPU_CS to enable BO_LIST creation=
.
> >   * - 3.28.0 - Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES
> >   * - 3.29.0 - Add AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID
> >   * - 3.30.0 - Add AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE.
> >   * - 3.31.0 - Add support for per-flip tiling attribute changes with D=
C
> >   * - 3.32.0 - Add syncobj timeline support to AMDGPU_CS.
> >   * - 3.33.0 - Fixes for GDS ENOMEM failures in AMDGPU_CS.
> >   * - 3.34.0 - Non-DC can flip correctly between buffers with different
> pitches
> > + * - 3.35.0 - Add drm_amdgpu_info_device::tcc_disabled_mask
> >   */
> >  #define KMS_DRIVER_MAJOR       3
> > -#define KMS_DRIVER_MINOR       34
> > +#define KMS_DRIVER_MINOR       35
> >  #define KMS_DRIVER_PATCHLEVEL  0
> >
> >  #define AMDGPU_MAX_TIMEOUT_PARAM_LENTH 256
> >
> >  int amdgpu_vram_limit =3D 0;
> >  int amdgpu_vis_vram_limit =3D 0;
> >  int amdgpu_gart_size =3D -1; /* auto */
> >  int amdgpu_gtt_size =3D -1; /* auto */
> >  int amdgpu_moverate =3D -1; /* auto */
> >  int amdgpu_benchmarking =3D 0;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > index 59c5464c96be..88dccff41dff 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -158,20 +158,21 @@ struct amdgpu_gfx_config {
> >         struct amdgpu_rb_config
> rb_config[AMDGPU_GFX_MAX_SE][AMDGPU_GFX_MAX_SH_PER_SE];
> >
> >         /* gfx configure feature */
> >         uint32_t double_offchip_lds_buf;
> >         /* cached value of DB_DEBUG2 */
> >         uint32_t db_debug2;
> >         /* gfx10 specific config */
> >         uint32_t num_sc_per_sh;
> >         uint32_t num_packer_per_sc;
> >         uint32_t pa_sc_tile_steering_override;
> > +       uint64_t tcc_disabled_mask;
> >  };
> >
> >  struct amdgpu_cu_info {
> >         uint32_t simd_per_cu;
> >         uint32_t max_waves_per_simd;
> >         uint32_t wave_front_size;
> >         uint32_t max_scratch_slots_per_cu;
> >         uint32_t lds_size;
> >
> >         /* total active CU number */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 91f5aaf99861..7356efe7e2d3 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -775,20 +775,22 @@ static int amdgpu_info_ioctl(struct drm_device
> *dev, void *data, struct drm_file
> >                 dev_info.num_cu_per_sh =3D adev->gfx.config.max_cu_per_=
sh;
> >                 dev_info.num_tcc_blocks =3D
> adev->gfx.config.max_texture_channel_caches;
> >                 dev_info.gs_vgt_table_depth =3D
> adev->gfx.config.gs_vgt_table_depth;
> >                 dev_info.gs_prim_buffer_depth =3D
> adev->gfx.config.gs_prim_buffer_depth;
> >                 dev_info.max_gs_waves_per_vgt =3D
> adev->gfx.config.max_gs_threads;
> >
> >                 if (adev->family >=3D AMDGPU_FAMILY_NV)
> >                         dev_info.pa_sc_tile_steering_override =3D
> >
>  adev->gfx.config.pa_sc_tile_steering_override;
> >
> > +               dev_info.tcc_disabled_mask =3D
> adev->gfx.config.tcc_disabled_mask;
> > +
> >                 return copy_to_user(out, &dev_info,
> >                                     min((size_t)size, sizeof(dev_info))=
)
> ? -EFAULT : 0;
> >         }
> >         case AMDGPU_INFO_VCE_CLOCK_TABLE: {
> >                 unsigned i;
> >                 struct drm_amdgpu_info_vce_clock_table vce_clk_table =
=3D
> {};
> >                 struct amd_vce_state *vce_state;
> >
> >                 for (i =3D 0; i < AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) =
{
> >                         vce_state =3D amdgpu_dpm_get_vce_clock_state(ad=
ev,
> i);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > index cfc0952f6175..ca01643fa0c8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> > @@ -1684,31 +1684,42 @@ static void gfx_v10_0_tcp_harvest(struct
> amdgpu_device *adev)
> >                                 tmp |=3D (gcrd_targets_disable_tcp &
> gcrd_targets_disable_mask);
> >                                 WREG32_SOC15(GC, 0,
> mmGCRD_SA_TARGETS_DISABLE, tmp);
> >                         }
> >                 }
> >
> >                 gfx_v10_0_select_se_sh(adev, 0xffffffff, 0xffffffff,
> 0xffffffff);
> >                 mutex_unlock(&adev->grbm_idx_mutex);
> >         }
> >  }
> >
> > +static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)
> > +{
> > +       uint32_t tcc_disable =3D RREG32_SOC15(GC, 0, mmCGTS_TCC_DISABLE=
) |
> > +                              RREG32_SOC15(GC, 0,
> mmCGTS_USER_TCC_DISABLE);
> > +
> > +       adev->gfx.config.tcc_disabled_mask =3D
> > +               REG_GET_FIELD(tcc_disable, CGTS_TCC_DISABLE,
> TCC_DISABLE) |
> > +               (REG_GET_FIELD(tcc_disable, CGTS_TCC_DISABLE,
> HI_TCC_DISABLE) << 16);
> > +}
>
> Are TCCs per SE/SH?  If so, you'll need to walk each instance and
> create a mask from each instance like we do for setup_rb and cu_info.
>
> Alex
>
> > +
> >  static void gfx_v10_0_constants_init(struct amdgpu_device *adev)
> >  {
> >         u32 tmp;
> >         int i;
> >
> >         WREG32_FIELD15(GC, 0, GRBM_CNTL, READ_TIMEOUT, 0xff);
> >
> >         gfx_v10_0_tiling_mode_table_init(adev);
> >
> >         gfx_v10_0_setup_rb(adev);
> >         gfx_v10_0_get_cu_info(adev, &adev->gfx.cu_info);
> > +       gfx_v10_0_get_tcc_info(adev);
> >         adev->gfx.config.pa_sc_tile_steering_override =3D
> >                 gfx_v10_0_init_pa_sc_tile_steering_override(adev);
> >
> >         /* XXX SH_MEM regs */
> >         /* where to put LDS, scratch, GPUVM in FSA64 space */
> >         mutex_lock(&adev->srbm_mutex);
> >         for (i =3D 0; i <
> adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {
> >                 nv_grbm_select(adev, 0, 0, 0, i);
> >                 /* CP and shaders */
> >                 WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG,
> DEFAULT_SH_MEM_CONFIG);
> > diff --git a/include/uapi/drm/amdgpu_drm.h
> b/include/uapi/drm/amdgpu_drm.h
> > index f3ad429173e3..a69e31929155 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1001,20 +1001,22 @@ struct drm_amdgpu_info_device {
> >         __u32 max_gs_waves_per_vgt;
> >         __u32 _pad1;
> >         /* always on cu bitmap */
> >         __u32 cu_ao_bitmap[4][4];
> >         /** Starting high virtual address for UMDs. */
> >         __u64 high_va_offset;
> >         /** The maximum high virtual address */
> >         __u64 high_va_max;
> >         /* gfx10 pa_sc_tile_steering_override */
> >         __u32 pa_sc_tile_steering_override;
> > +       /* disabled TCCs */
> > +       __u64 tcc_disabled_mask;
> >  };
> >
> >  struct drm_amdgpu_info_hw_ip {
> >         /** Version of h/w IP */
> >         __u32  hw_ip_version_major;
> >         __u32  hw_ip_version_minor;
> >         /** Capabilities */
> >         __u64  capabilities_flags;
> >         /** command buffer address start alignment*/
> >         __u32  ib_start_alignment;
> > --
> > 2.17.1
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>

--00000000000050d1a2059367047b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I think TCCs are global, because all memory traffic f=
rom gfx engines+cp+sdma has to go through TCCs, e.g. memory requests from d=
ifferent SEs accessing the same memory address go to the same TCC.<br></div=
><div><br></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><d=
iv dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 24, 2019 at 10:58 PM Alex D=
eucher &lt;<a href=3D"mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">alexd=
eucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">On Tue, Sep 24, 2019 at 6:29 PM Marek Ol=C5=A1=C3=A1k &lt;<=
a href=3D"mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank">maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&g=
t; wrote:<br>
&gt;<br>
&gt; From: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak-5C7GfCeVMHo@public.gmane.org"=
 target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt;<br>
&gt; UMDs need this for correct programming of harvested chips.<br>
&gt;<br>
&gt; Signed-off-by: Marek Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:marek.olsak=
@amd.com" target=3D"_blank">marek.olsak-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |=C2=A0 3 ++-<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |=C2=A0 1 +<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |=C2=A0 2 ++<br>
&gt;=C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c=C2=A0 | 11 +++++++++++<br=
>
&gt;=C2=A0 include/uapi/drm/amdgpu_drm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 5 files changed, 18 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index f82d634cf3f9..b70b30378c20 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -75,23 +75,24 @@<br>
&gt;=C2=A0 =C2=A0* - 3.25.0 - Add support for sensor query info (stable pst=
ate sclk/mclk).<br>
&gt;=C2=A0 =C2=A0* - 3.26.0 - GFX9: Process AMDGPU_IB_FLAG_TC_WB_NOT_INVALI=
DATE.<br>
&gt;=C2=A0 =C2=A0* - 3.27.0 - Add new chunk to to AMDGPU_CS to enable BO_LI=
ST creation.<br>
&gt;=C2=A0 =C2=A0* - 3.28.0 - Add AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES<br=
>
&gt;=C2=A0 =C2=A0* - 3.29.0 - Add AMDGPU_IB_FLAG_RESET_GDS_MAX_WAVE_ID<br>
&gt;=C2=A0 =C2=A0* - 3.30.0 - Add AMDGPU_SCHED_OP_CONTEXT_PRIORITY_OVERRIDE=
.<br>
&gt;=C2=A0 =C2=A0* - 3.31.0 - Add support for per-flip tiling attribute cha=
nges with DC<br>
&gt;=C2=A0 =C2=A0* - 3.32.0 - Add syncobj timeline support to AMDGPU_CS.<br=
>
&gt;=C2=A0 =C2=A0* - 3.33.0 - Fixes for GDS ENOMEM failures in AMDGPU_CS.<b=
r>
&gt;=C2=A0 =C2=A0* - 3.34.0 - Non-DC can flip correctly between buffers wit=
h different pitches<br>
&gt; + * - 3.35.0 - Add drm_amdgpu_info_device::tcc_disabled_mask<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define KMS_DRIVER_MAJOR=C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt; -#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A034<br>
&gt; +#define KMS_DRIVER_MINOR=C2=A0 =C2=A0 =C2=A0 =C2=A035<br>
&gt;=C2=A0 #define KMS_DRIVER_PATCHLEVEL=C2=A0 0<br>
&gt;<br>
&gt;=C2=A0 #define AMDGPU_MAX_TIMEOUT_PARAM_LENTH 256<br>
&gt;<br>
&gt;=C2=A0 int amdgpu_vram_limit =3D 0;<br>
&gt;=C2=A0 int amdgpu_vis_vram_limit =3D 0;<br>
&gt;=C2=A0 int amdgpu_gart_size =3D -1; /* auto */<br>
&gt;=C2=A0 int amdgpu_gtt_size =3D -1; /* auto */<br>
&gt;=C2=A0 int amdgpu_moverate =3D -1; /* auto */<br>
&gt;=C2=A0 int amdgpu_benchmarking =3D 0;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_gfx.h<br>
&gt; index 59c5464c96be..88dccff41dff 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; @@ -158,20 +158,21 @@ struct amdgpu_gfx_config {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdgpu_rb_config rb_config[AMD=
GPU_GFX_MAX_SE][AMDGPU_GFX_MAX_SH_PER_SE];<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* gfx configure feature */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t double_offchip_lds_buf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* cached value of DB_DEBUG2 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t db_debug2;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* gfx10 specific config */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t num_sc_per_sh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t num_packer_per_sc;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t pa_sc_tile_steering_override=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t tcc_disabled_mask;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 struct amdgpu_cu_info {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t simd_per_cu;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t max_waves_per_simd;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t wave_front_size;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t max_scratch_slots_per_cu;<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t lds_size;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* total active CU number */<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c<br>
&gt; index 91f5aaf99861..7356efe7e2d3 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -775,20 +775,22 @@ static int amdgpu_info_ioctl(struct drm_device *=
dev, void *data, struct drm_file<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info.=
num_cu_per_sh =3D adev-&gt;gfx.config.max_cu_per_sh;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info.=
num_tcc_blocks =3D adev-&gt;gfx.config.max_texture_channel_caches;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info.=
gs_vgt_table_depth =3D adev-&gt;gfx.config.gs_vgt_table_depth;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info.=
gs_prim_buffer_depth =3D adev-&gt;gfx.config.gs_prim_buffer_depth;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info.=
max_gs_waves_per_vgt =3D adev-&gt;gfx.config.max_gs_threads;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (adev-=
&gt;family &gt;=3D AMDGPU_FAMILY_NV)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dev_info.pa_sc_tile_steering_override =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.config.pa_sc_t=
ile_steering_override;<br>
&gt;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info.tcc_d=
isabled_mask =3D adev-&gt;gfx.config.tcc_disabled_mask;<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return co=
py_to_user(out, &amp;dev_info,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0min((size_t)s=
ize, sizeof(dev_info))) ? -EFAULT : 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AMDGPU_INFO_VCE_CLOCK_TABLE: {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned =
i;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct dr=
m_amdgpu_info_vce_clock_table vce_clk_table =3D {};<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct am=
d_vce_state *vce_state;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =
=3D 0; i &lt; AMDGPU_VCE_CLOCK_TABLE_ENTRIES; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0vce_state =3D amdgpu_dpm_get_vce_clock_state(adev, i);<=
br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gfx_v10_0.c<br>
&gt; index cfc0952f6175..ca01643fa0c8 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -1684,31 +1684,42 @@ static void gfx_v10_0_tcp_harvest(struct amdgp=
u_device *adev)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tmp |=3D (gcrd_targets_disa=
ble_tcp &amp; gcrd_targets_disable_mask);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_SOC15(GC, 0, mmGCRD_=
SA_TARGETS_DISABLE, tmp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0=
_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unl=
ock(&amp;adev-&gt;grbm_idx_mutex);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void gfx_v10_0_get_tcc_info(struct amdgpu_device *adev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t tcc_disable =3D RREG32_SOC15(GC, =
0, mmCGTS_TCC_DISABLE) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 RREG32_SOC15(GC, 0, mmCGTS_USER_TCC_DIS=
ABLE);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.config.tcc_disabled_mask =3D<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0REG_GET_FIELD(=
tcc_disable, CGTS_TCC_DISABLE, TCC_DISABLE) |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(REG_GET_FIELD=
(tcc_disable, CGTS_TCC_DISABLE, HI_TCC_DISABLE) &lt;&lt; 16);<br>
&gt; +}<br>
<br>
Are TCCs per SE/SH?=C2=A0 If so, you&#39;ll need to walk each instance and<=
br>
create a mask from each instance like we do for setup_rb and cu_info.<br>
<br>
Alex<br>
<br>
&gt; +<br>
&gt;=C2=A0 static void gfx_v10_0_constants_init(struct amdgpu_device *adev)=
<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 tmp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_FIELD15(GC, 0, GRBM_CNTL, READ=
_TIMEOUT, 0xff);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_tiling_mode_table_init(adev=
);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_setup_rb(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_get_cu_info(adev, &amp;adev=
-&gt;gfx.cu_info);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0_get_tcc_info(adev);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0adev-&gt;gfx.config.pa_sc_tile_steeri=
ng_override =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gfx_v10_0=
_init_pa_sc_tile_steering_override(adev);<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* XXX SH_MEM regs */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* where to put LDS, scratch, GPUVM i=
n FSA64 space */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;adev-&gt;srbm_mutex);=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; adev-&gt;vm_mana=
ger.id_mgr[AMDGPU_GFXHUB_0].num_ids; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0nv_grbm_s=
elect(adev, 0, 0, 0, i);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* CP and=
 shaders */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0WREG32_SO=
C15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);<br>
&gt; diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_d=
rm.h<br>
&gt; index f3ad429173e3..a69e31929155 100644<br>
&gt; --- a/include/uapi/drm/amdgpu_drm.h<br>
&gt; +++ b/include/uapi/drm/amdgpu_drm.h<br>
&gt; @@ -1001,20 +1001,22 @@ struct drm_amdgpu_info_device {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 max_gs_waves_per_vgt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 _pad1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* always on cu bitmap */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 cu_ao_bitmap[4][4];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Starting high virtual address for=
 UMDs. */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 high_va_offset;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** The maximum high virtual address =
*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 high_va_max;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* gfx10 pa_sc_tile_steering_override=
 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 pa_sc_tile_steering_override;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/* disabled TCCs */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0__u64 tcc_disabled_mask;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 struct drm_amdgpu_info_hw_ip {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Version of h/w IP */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 hw_ip_version_major;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 hw_ip_version_minor;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** Capabilities */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u64=C2=A0 capabilities_flags;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/** command buffer address start alig=
nment*/<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32=C2=A0 ib_start_alignment;<br>
&gt; --<br>
&gt; 2.17.1<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; amd-gfx mailing list<br>
&gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=
=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/lis=
tinfo/amd-gfx</a><br>
</blockquote></div>

--00000000000050d1a2059367047b--

--===============0727494074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0727494074==--
