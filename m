From: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Make amdgpu_bo_reserve use uninterruptible
 waits for cleanup
Date: Fri, 28 Apr 2017 14:12:52 +0000
Message-ID: <MWHPR1201MB0045C097101B0EDA13F28BD9F2130@MWHPR1201MB0045.namprd12.prod.outlook.com>
References: <mailman.1551.1493369856.21890.amd-gfx@lists.freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1572300442=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <mailman.1551.1493369856.21890.amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1572300442==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MWHPR1201MB0045C097101B0EDA13F28BD9F2130MWHPR1201MB0045_"

--_000_MWHPR1201MB0045C097101B0EDA13F28BD9F2130MWHPR1201MB0045_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 28.04.2017 um 10:47 schrieb Michel D=E4nzer:
> From: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>
>
> Some of these paths probably cannot be interrupted by a signal anyway.
> Those that can would fail to clean up things if they actually got
> interrupted.
>
> Signed-off-by: Michel D=E4nzer <michel.daenzer-5C7GfCeVMHo@public.gmane.org>

Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Alex X: Just a reminder: amdgpu_unpin_work_func is called by work queue.
Signal is blocked already. un-interruptible waiting might slow thing down v=
ery slightly.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c   |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  2 +-
>   drivers/gpu/drm/amd/amdgpu/dce_v10_0.c      |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/dce_v11_0.c      |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/dce_v6_0.c       |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/dce_v8_0.c       |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/dce_virtual.c    |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c       |  6 +++---
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c       | 10 +++++-----
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c       |  8 ++++----
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c       |  8 ++++----
>   16 files changed, 36 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_display.c
> index 771a6aae58d6..af64448a565c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -123,7 +123,7 @@ static void amdgpu_unpin_work_func(struct work_struct=
 *__work)
>        int r;
>
>        /* unpin of the old buffer */
> -     r =3D amdgpu_bo_reserve(work->old_abo, false);
> +     r =3D amdgpu_bo_reserve(work->old_abo, true);
>        if (likely(r =3D=3D 0)) {
>                r =3D amdgpu_bo_unpin(work->old_abo);
>                if (unlikely(r !=3D 0)) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_fb.c
> index 9dea2f661f1d..e869e60994ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
> @@ -113,7 +113,7 @@ static void amdgpufb_destroy_pinned_object(struct drm=
_gem_object *gobj)
>        struct amdgpu_bo *abo =3D gem_to_amdgpu_bo(gobj);
>        int ret;
>
> -     ret =3D amdgpu_bo_reserve(abo, false);
> +     ret =3D amdgpu_bo_reserve(abo, true);
>        if (likely(ret =3D=3D 0)) {
>                amdgpu_bo_kunmap(abo);
>                amdgpu_bo_unpin(abo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_gart.c
> index 6d691abe889c..e7406ce7093c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -183,7 +183,7 @@ void amdgpu_gart_table_vram_unpin(struct amdgpu_devic=
e *adev)
>        if (adev->gart.robj =3D=3D NULL) {
>                return;
>        }
> -     r =3D amdgpu_bo_reserve(adev->gart.robj, false);
> +     r =3D amdgpu_bo_reserve(adev->gart.robj, true);
>        if (likely(r =3D=3D 0)) {
>                amdgpu_bo_kunmap(adev->gart.robj);
>                amdgpu_bo_unpin(adev->gart.robj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index ec5b1bc0e428..d40b8ac745cd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -819,7 +819,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *d=
ev,
>
>        if (amdgpu_sriov_vf(adev)) {
>                /* TODO: how to handle reserve failure */
> -             BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, false));
> +             BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
>                amdgpu_vm_bo_rmv(adev, fpriv->vm.csa_bo_va);
>                fpriv->vm.csa_bo_va =3D NULL;
>                amdgpu_bo_unreserve(adev->virt.csa_obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_prime.c
> index 3826d5aea0a6..6bdc866570ab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c
> @@ -113,7 +113,7 @@ void amdgpu_gem_prime_unpin(struct drm_gem_object *ob=
j)
>        struct amdgpu_bo *bo =3D gem_to_amdgpu_bo(obj);
>        int ret =3D 0;
>
> -     ret =3D amdgpu_bo_reserve(bo, false);
> +     ret =3D amdgpu_bo_reserve(bo, true);
>        if (unlikely(ret !=3D 0))
>                return;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_sa.c
> index 7b56d9988aba..de4ebcf4ac2c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
> @@ -130,7 +130,7 @@ int amdgpu_sa_bo_manager_suspend(struct amdgpu_device=
 *adev,
>                return -EINVAL;
>        }
>
> -     r =3D amdgpu_bo_reserve(sa_manager->bo, false);
> +     r =3D amdgpu_bo_reserve(sa_manager->bo, true);
>        if (!r) {
>                amdgpu_bo_kunmap(sa_manager->bo);
>                amdgpu_bo_unpin(sa_manager->bo);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 58873cf027e8..11c6c4494e0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1198,7 +1198,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>                return;
>        amdgpu_ttm_debugfs_fini(adev);
>        if (adev->stollen_vga_memory) {
> -             r =3D amdgpu_bo_reserve(adev->stollen_vga_memory, false);
> +             r =3D amdgpu_bo_reserve(adev->stollen_vga_memory, true);
>                if (r =3D=3D 0) {
>                        amdgpu_bo_unpin(adev->stollen_vga_memory);
>                        amdgpu_bo_unreserve(adev->stollen_vga_memory);
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v10_0.c
> index 7d86ba42efc9..d618f92ae46c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> @@ -2231,7 +2231,7 @@ static int dce_v10_0_crtc_do_set_base(struct drm_cr=
tc *crtc,
>        if (!atomic && fb && fb !=3D crtc->primary->fb) {
>                amdgpu_fb =3D to_amdgpu_framebuffer(fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r !=3D 0))
>                        return r;
>                amdgpu_bo_unpin(abo);
> @@ -2590,7 +2590,7 @@ static int dce_v10_0_crtc_cursor_set2(struct drm_cr=
tc *crtc,
>   unpin:
>        if (amdgpu_crtc->cursor_bo) {
>                struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgpu_crtc->c=
ursor_bo);
> -             ret =3D amdgpu_bo_reserve(aobj, false);
> +             ret =3D amdgpu_bo_reserve(aobj, true);
>                if (likely(ret =3D=3D 0)) {
>                        amdgpu_bo_unpin(aobj);
>                        amdgpu_bo_unreserve(aobj);
> @@ -2720,7 +2720,7 @@ static void dce_v10_0_crtc_disable(struct drm_crtc =
*crtc)
>
>                amdgpu_fb =3D to_amdgpu_framebuffer(crtc->primary->fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r))
>                        DRM_ERROR("failed to reserve abo before unpin\n");
>                else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/amd=
/amdgpu/dce_v11_0.c
> index 3d82181baffe..ea634158ae7a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> @@ -2215,7 +2215,7 @@ static int dce_v11_0_crtc_do_set_base(struct drm_cr=
tc *crtc,
>        if (!atomic && fb && fb !=3D crtc->primary->fb) {
>                amdgpu_fb =3D to_amdgpu_framebuffer(fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r !=3D 0))
>                        return r;
>                amdgpu_bo_unpin(abo);
> @@ -2610,7 +2610,7 @@ static int dce_v11_0_crtc_cursor_set2(struct drm_cr=
tc *crtc,
>   unpin:
>        if (amdgpu_crtc->cursor_bo) {
>                struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgpu_crtc->c=
ursor_bo);
> -             ret =3D amdgpu_bo_reserve(aobj, false);
> +             ret =3D amdgpu_bo_reserve(aobj, true);
>                if (likely(ret =3D=3D 0)) {
>                        amdgpu_bo_unpin(aobj);
>                        amdgpu_bo_unreserve(aobj);
> @@ -2740,7 +2740,7 @@ static void dce_v11_0_crtc_disable(struct drm_crtc =
*crtc)
>
>                amdgpu_fb =3D to_amdgpu_framebuffer(crtc->primary->fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r))
>                        DRM_ERROR("failed to reserve abo before unpin\n");
>                else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 59f6993af0b6..d68c1eabd0ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -2150,7 +2150,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crt=
c *crtc,
>        if (!atomic && fb && fb !=3D crtc->primary->fb) {
>                amdgpu_fb =3D to_amdgpu_framebuffer(fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r !=3D 0))
>                        return r;
>                amdgpu_bo_unpin(abo);
> @@ -2467,7 +2467,7 @@ static int dce_v6_0_crtc_cursor_set2(struct drm_crt=
c *crtc,
>   unpin:
>        if (amdgpu_crtc->cursor_bo) {
>                struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgpu_crtc->c=
ursor_bo);
> -             ret =3D amdgpu_bo_reserve(aobj, false);
> +             ret =3D amdgpu_bo_reserve(aobj, true);
>                if (likely(ret =3D=3D 0)) {
>                        amdgpu_bo_unpin(aobj);
>                        amdgpu_bo_unreserve(aobj);
> @@ -2592,7 +2592,7 @@ static void dce_v6_0_crtc_disable(struct drm_crtc *=
crtc)
>
>                amdgpu_fb =3D to_amdgpu_framebuffer(crtc->primary->fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r))
>                        DRM_ERROR("failed to reserve abo before unpin\n");
>                else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v8_0.c
> index 1629ff9c3949..1e6c40e32cfd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> @@ -2090,7 +2090,7 @@ static int dce_v8_0_crtc_do_set_base(struct drm_crt=
c *crtc,
>        if (!atomic && fb && fb !=3D crtc->primary->fb) {
>                amdgpu_fb =3D to_amdgpu_framebuffer(fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r !=3D 0))
>                        return r;
>                amdgpu_bo_unpin(abo);
> @@ -2441,7 +2441,7 @@ static int dce_v8_0_crtc_cursor_set2(struct drm_crt=
c *crtc,
>   unpin:
>        if (amdgpu_crtc->cursor_bo) {
>                struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgpu_crtc->c=
ursor_bo);
> -             ret =3D amdgpu_bo_reserve(aobj, false);
> +             ret =3D amdgpu_bo_reserve(aobj, true);
>                if (likely(ret =3D=3D 0)) {
>                        amdgpu_bo_unpin(aobj);
>                        amdgpu_bo_unreserve(aobj);
> @@ -2571,7 +2571,7 @@ static void dce_v8_0_crtc_disable(struct drm_crtc *=
crtc)
>
>                amdgpu_fb =3D to_amdgpu_framebuffer(crtc->primary->fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r))
>                        DRM_ERROR("failed to reserve abo before unpin\n");
>                else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/drm/a=
md/amdgpu/dce_virtual.c
> index 8bb9cfde508d..084518301f4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c
> @@ -247,7 +247,7 @@ static void dce_virtual_crtc_disable(struct drm_crtc =
*crtc)
>
>                amdgpu_fb =3D to_amdgpu_framebuffer(crtc->primary->fb);
>                abo =3D gem_to_amdgpu_bo(amdgpu_fb->obj);
> -             r =3D amdgpu_bo_reserve(abo, false);
> +             r =3D amdgpu_bo_reserve(abo, true);
>                if (unlikely(r))
>                        DRM_ERROR("failed to reserve abo before unpin\n");
>                else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v6_0.c
> index 25c3703f838b..03d2a0a2e523 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
> @@ -2437,7 +2437,7 @@ static void gfx_v6_0_rlc_fini(struct amdgpu_device =
*adev)
>        int r;
>
>        if (adev->gfx.rlc.save_restore_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.rlc.save_restore_obj, fal=
se);
> +             r =3D amdgpu_bo_reserve(adev->gfx.rlc.save_restore_obj, tru=
e);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve RLC sr bo failed=
\n", r);
>                amdgpu_bo_unpin(adev->gfx.rlc.save_restore_obj);
> @@ -2448,7 +2448,7 @@ static void gfx_v6_0_rlc_fini(struct amdgpu_device =
*adev)
>        }
>
>        if (adev->gfx.rlc.clear_state_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.rlc.clear_state_obj, fals=
e);
> +             r =3D amdgpu_bo_reserve(adev->gfx.rlc.clear_state_obj, true=
);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve RLC c bo failed\=
n", r);
>                amdgpu_bo_unpin(adev->gfx.rlc.clear_state_obj);
> @@ -2459,7 +2459,7 @@ static void gfx_v6_0_rlc_fini(struct amdgpu_device =
*adev)
>        }
>
>        if (adev->gfx.rlc.cp_table_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.rlc.cp_table_obj, false);
> +             r =3D amdgpu_bo_reserve(adev->gfx.rlc.cp_table_obj, true);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve RLC cp table bo =
failed\n", r);
>                amdgpu_bo_unpin(adev->gfx.rlc.cp_table_obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 75cca54fa216..b2df8e814abb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2792,7 +2792,7 @@ static void gfx_v7_0_cp_compute_fini(struct amdgpu_=
device *adev)
>                struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
>
>                if (ring->mqd_obj) {
> -                     r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> +                     r =3D amdgpu_bo_reserve(ring->mqd_obj, true);
>                        if (unlikely(r !=3D 0))
>                                dev_warn(adev->dev, "(%d) reserve MQD bo f=
ailed\n", r);
>
> @@ -2810,7 +2810,7 @@ static void gfx_v7_0_mec_fini(struct amdgpu_device =
*adev)
>        int r;
>
>        if (adev->gfx.mec.hpd_eop_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.mec.hpd_eop_obj, false);
> +             r =3D amdgpu_bo_reserve(adev->gfx.mec.hpd_eop_obj, true);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve HPD EOP bo faile=
d\n", r);
>                amdgpu_bo_unpin(adev->gfx.mec.hpd_eop_obj);
> @@ -3359,7 +3359,7 @@ static void gfx_v7_0_rlc_fini(struct amdgpu_device =
*adev)
>
>        /* save restore block */
>        if (adev->gfx.rlc.save_restore_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.rlc.save_restore_obj, fal=
se);
> +             r =3D amdgpu_bo_reserve(adev->gfx.rlc.save_restore_obj, tru=
e);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve RLC sr bo failed=
\n", r);
>                amdgpu_bo_unpin(adev->gfx.rlc.save_restore_obj);
> @@ -3371,7 +3371,7 @@ static void gfx_v7_0_rlc_fini(struct amdgpu_device =
*adev)
>
>        /* clear state block */
>        if (adev->gfx.rlc.clear_state_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.rlc.clear_state_obj, fals=
e);
> +             r =3D amdgpu_bo_reserve(adev->gfx.rlc.clear_state_obj, true=
);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve RLC c bo failed\=
n", r);
>                amdgpu_bo_unpin(adev->gfx.rlc.clear_state_obj);
> @@ -3383,7 +3383,7 @@ static void gfx_v7_0_rlc_fini(struct amdgpu_device =
*adev)
>
>        /* clear state block */
>        if (adev->gfx.rlc.cp_table_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.rlc.cp_table_obj, false);
> +             r =3D amdgpu_bo_reserve(adev->gfx.rlc.cp_table_obj, true);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve RLC cp table bo =
failed\n", r);
>                amdgpu_bo_unpin(adev->gfx.rlc.cp_table_obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 2a5b20920ea6..ac64e01c6938 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -1244,7 +1244,7 @@ static void gfx_v8_0_rlc_fini(struct amdgpu_device =
*adev)
>
>        /* clear state block */
>        if (adev->gfx.rlc.clear_state_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.rlc.clear_state_obj, fals=
e);
> +             r =3D amdgpu_bo_reserve(adev->gfx.rlc.clear_state_obj, true=
);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve RLC cbs bo faile=
d\n", r);
>                amdgpu_bo_unpin(adev->gfx.rlc.clear_state_obj);
> @@ -1255,7 +1255,7 @@ static void gfx_v8_0_rlc_fini(struct amdgpu_device =
*adev)
>
>        /* jump table block */
>        if (adev->gfx.rlc.cp_table_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.rlc.cp_table_obj, false);
> +             r =3D amdgpu_bo_reserve(adev->gfx.rlc.cp_table_obj, true);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve RLC cp table bo =
failed\n", r);
>                amdgpu_bo_unpin(adev->gfx.rlc.cp_table_obj);
> @@ -1368,7 +1368,7 @@ static void gfx_v8_0_mec_fini(struct amdgpu_device =
*adev)
>        int r;
>
>        if (adev->gfx.mec.hpd_eop_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.mec.hpd_eop_obj, false);
> +             r =3D amdgpu_bo_reserve(adev->gfx.mec.hpd_eop_obj, true);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve HPD EOP bo faile=
d\n", r);
>                amdgpu_bo_unpin(adev->gfx.mec.hpd_eop_obj);
> @@ -1496,7 +1496,7 @@ static int gfx_v8_0_kiq_init(struct amdgpu_device *=
adev)
>
>        memset(hpd, 0, MEC_HPD_SIZE);
>
> -     r =3D amdgpu_bo_reserve(kiq->eop_obj, false);
> +     r =3D amdgpu_bo_reserve(kiq->eop_obj, true);
>        if (unlikely(r !=3D 0))
>                dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r)=
;
>        amdgpu_bo_kunmap(kiq->eop_obj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index 5249bc7964fb..08daa3fd687b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -453,7 +453,7 @@ static void gfx_v9_0_mec_fini(struct amdgpu_device *a=
dev)
>        int r;
>
>        if (adev->gfx.mec.hpd_eop_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.mec.hpd_eop_obj, false);
> +             r =3D amdgpu_bo_reserve(adev->gfx.mec.hpd_eop_obj, true);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve HPD EOP bo faile=
d\n", r);
>                amdgpu_bo_unpin(adev->gfx.mec.hpd_eop_obj);
> @@ -463,7 +463,7 @@ static void gfx_v9_0_mec_fini(struct amdgpu_device *a=
dev)
>                adev->gfx.mec.hpd_eop_obj =3D NULL;
>        }
>        if (adev->gfx.mec.mec_fw_obj) {
> -             r =3D amdgpu_bo_reserve(adev->gfx.mec.mec_fw_obj, false);
> +             r =3D amdgpu_bo_reserve(adev->gfx.mec.mec_fw_obj, true);
>                if (unlikely(r !=3D 0))
>                        dev_warn(adev->dev, "(%d) reserve mec firmware bo =
failed\n", r);
>                amdgpu_bo_unpin(adev->gfx.mec.mec_fw_obj);
> @@ -599,7 +599,7 @@ static int gfx_v9_0_kiq_init(struct amdgpu_device *ad=
ev)
>
>        memset(hpd, 0, MEC_HPD_SIZE);
>
> -     r =3D amdgpu_bo_reserve(kiq->eop_obj, false);
> +     r =3D amdgpu_bo_reserve(kiq->eop_obj, true);
>        if (unlikely(r !=3D 0))
>                dev_warn(adev->dev, "(%d) reserve kiq eop bo failed\n", r)=
;
>        amdgpu_bo_kunmap(kiq->eop_obj);
> @@ -1786,7 +1786,7 @@ static void gfx_v9_0_cp_compute_fini(struct amdgpu_=
device *adev)
>                struct amdgpu_ring *ring =3D &adev->gfx.compute_ring[i];
>
>                if (ring->mqd_obj) {
> -                     r =3D amdgpu_bo_reserve(ring->mqd_obj, false);
> +                     r =3D amdgpu_bo_reserve(ring->mqd_obj, true);
>                        if (unlikely(r !=3D 0))
>                                dev_warn(adev->dev, "(%d) reserve MQD bo f=
ailed\n", r);
>




------------------------------

Subject: Digest Footer

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - freedesktop.org<https://lists.freedesktop.org/mailman/l=
istinfo/amd-gfx>
lists.freedesktop.org
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...




------------------------------

End of amd-gfx Digest, Vol 11, Issue 407
****************************************

--_000_MWHPR1201MB0045C097101B0EDA13F28BD9F2130MWHPR1201MB0045_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<div style=3D"color: rgb(0, 0, 0);"><font size=3D"2"><span style=3D"font-si=
ze:10pt;">
<div class=3D"PlainText">Am 28.04.2017 um 10:47 schrieb Michel D=E4nzer:<br=
>
&gt; From: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt;<br>
&gt; Some of these paths probably cannot be interrupted by a signal anyway.=
<br>
&gt; Those that can would fail to clean up things if they actually got<br>
&gt; interrupted.<br>
&gt;<br>
&gt; Signed-off-by: Michel D=E4nzer &lt;michel.daenzer-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
Reviewed-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<br>
<span>Alex X: Just a reminder: amdgpu_unpin_work_func</span> is called by w=
ork queue.
<br>
Signal is blocked already. un-interruptible waiting might slow thing down v=
ery slightly.<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_display.c |&nbsp; 2 &#43=
;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c&nbsp;&nbsp;&nbsp;=
 |&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c&nbsp;&nbsp; |&nb=
sp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&=
nbsp; |&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/dce_v10_0.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 6 &#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/dce_v11_0.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; |&nbsp; 6 &#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/dce_v6_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 6 &#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/dce_v8_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 6 &#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/dce_virtual.c&nbsp;&nbsp;&nbsp;=
 |&nbsp; 2 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 6 &#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; | 10 &#43;&#43;&#43;&#43;&#43;-----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 8 &#43;&#43;&#43;&#43;----<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; |&nbsp; 8 &#43;&#43;&#43;&#43;----<br>
&gt;&nbsp;&nbsp; 16 files changed, 36 insertions(&#43;), 36 deletions(-)<br=
>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; index 771a6aae58d6..af64448a565c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c<br>
&gt; @@ -123,7 &#43;123,7 @@ static void amdgpu_unpin_work_func(struct work=
_struct *__work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* unpin of the old buffer *=
/<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(work-&gt;old_abo, fa=
lse);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(work-&gt;old_abo=
, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(r =3D=3D 0)) {<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_unpin(work-&gt;old_abo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0)) {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fb.c<br>
&gt; index 9dea2f661f1d..e869e60994ce 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c<br>
&gt; @@ -113,7 &#43;113,7 @@ static void amdgpufb_destroy_pinned_object(str=
uct drm_gem_object *gobj)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *abo =3D ge=
m_to_amdgpu_bo(gobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(abo, true);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(ret =3D=3D 0)) {<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(abo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(abo);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_gart.c<br>
&gt; index 6d691abe889c..e7406ce7093c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c<br>
&gt; @@ -183,7 &#43;183,7 @@ void amdgpu_gart_table_vram_unpin(struct amdgp=
u_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gart.robj =3D=
=3D NULL) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gart.robj, =
false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gart.ro=
bj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (likely(r =3D=3D 0)) {<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(adev-&gt;gart.robj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gart.robj);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_kms.c<br>
&gt; index ec5b1bc0e428..d40b8ac745cd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
&gt; @@ -819,7 &#43;819,7 @@ void amdgpu_driver_postclose_kms(struct drm_de=
vice *dev,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev)) {=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* TODO: how to handle reserve failure */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; BUG_ON(amdgpu_bo_reserve(adev-&gt;virt.csa_obj, false));<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; BUG_ON(amdgpu_bo_reserve(adev-&gt;virt.csa_obj, true));<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_vm_bo_rmv(adev, fpriv-&gt;vm.csa_bo_va);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; fpriv-&gt;vm.csa_bo_va =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unreserve(adev-&gt;virt.csa_obj);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_prime.c<br>
&gt; index 3826d5aea0a6..6bdc866570ab 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_prime.c<br>
&gt; @@ -113,7 &#43;113,7 @@ void amdgpu_gem_prime_unpin(struct drm_gem_obj=
ect *obj)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *bo =3D gem=
_to_amdgpu_bo(obj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret =3D 0;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(bo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_bo_reserve(bo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(ret !=3D 0))<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp; <br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_sa.c<br>
&gt; index 7b56d9988aba..de4ebcf4ac2c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c<br>
&gt; @@ -130,7 &#43;130,7 @@ int amdgpu_sa_bo_manager_suspend(struct amdgpu=
_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(sa_manager-&gt;bo, f=
alse);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(sa_manager-&gt;b=
o, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!r) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(sa_manager-&gt;bo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(sa_manager-&gt;bo);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ttm.c<br>
&gt; index 58873cf027e8..11c6c4494e0a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<br>
&gt; @@ -1198,7 &#43;1198,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *a=
dev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ttm_debugfs_fini(adev=
);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;stollen_vga_mem=
ory) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;stollen_vga_memory, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;stollen_vga_memory, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (r =3D=3D 0) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unpin(adev-&gt;stollen_vga_memory);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unreserve(adev-&gt;stollen_vga_memory);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/dce_v10_0.c<br>
&gt; index 7d86ba42efc9..d618f92ae46c 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c<br>
&gt; @@ -2231,7 &#43;2231,7 @@ static int dce_v10_0_crtc_do_set_base(struct=
 drm_crtc *crtc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!atomic &amp;&amp; fb &a=
mp;&amp; fb !=3D crtc-&gt;primary-&gt;fb) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(abo);<br>
&gt; @@ -2590,7 &#43;2590,7 @@ static int dce_v10_0_crtc_cursor_set2(struct=
 drm_crtc *crtc,<br>
&gt;&nbsp;&nbsp; unpin:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_crtc-&gt;cursor_b=
o) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgpu_crtc=
-&gt;cursor_bo);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D amdgpu_bo_reserve(aobj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D amdgpu_bo_reserve(aobj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (likely(ret =3D=3D 0)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unpin(aobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unreserve(aobj);<br>
&gt; @@ -2720,7 &#43;2720,7 @@ static void dce_v10_0_crtc_disable(struct dr=
m_crtc *crtc)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(crtc-&gt;primary-&g=
t;fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;failed to reserve abo before unpin\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c b/drivers/gpu/drm/=
amd/amdgpu/dce_v11_0.c<br>
&gt; index 3d82181baffe..ea634158ae7a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c<br>
&gt; @@ -2215,7 &#43;2215,7 @@ static int dce_v11_0_crtc_do_set_base(struct=
 drm_crtc *crtc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!atomic &amp;&amp; fb &a=
mp;&amp; fb !=3D crtc-&gt;primary-&gt;fb) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(abo);<br>
&gt; @@ -2610,7 &#43;2610,7 @@ static int dce_v11_0_crtc_cursor_set2(struct=
 drm_crtc *crtc,<br>
&gt;&nbsp;&nbsp; unpin:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_crtc-&gt;cursor_b=
o) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgpu_crtc=
-&gt;cursor_bo);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D amdgpu_bo_reserve(aobj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D amdgpu_bo_reserve(aobj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (likely(ret =3D=3D 0)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unpin(aobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unreserve(aobj);<br>
&gt; @@ -2740,7 &#43;2740,7 @@ static void dce_v11_0_crtc_disable(struct dr=
m_crtc *crtc)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(crtc-&gt;primary-&g=
t;fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;failed to reserve abo before unpin\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v6_0.c<br>
&gt; index 59f6993af0b6..d68c1eabd0ce 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c<br>
&gt; @@ -2150,7 &#43;2150,7 @@ static int dce_v6_0_crtc_do_set_base(struct =
drm_crtc *crtc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!atomic &amp;&amp; fb &a=
mp;&amp; fb !=3D crtc-&gt;primary-&gt;fb) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(abo);<br>
&gt; @@ -2467,7 &#43;2467,7 @@ static int dce_v6_0_crtc_cursor_set2(struct =
drm_crtc *crtc,<br>
&gt;&nbsp;&nbsp; unpin:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_crtc-&gt;cursor_b=
o) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgpu_crtc=
-&gt;cursor_bo);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D amdgpu_bo_reserve(aobj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D amdgpu_bo_reserve(aobj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (likely(ret =3D=3D 0)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unpin(aobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unreserve(aobj);<br>
&gt; @@ -2592,7 &#43;2592,7 @@ static void dce_v6_0_crtc_disable(struct drm=
_crtc *crtc)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(crtc-&gt;primary-&g=
t;fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;failed to reserve abo before unpin\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/dce_v8_0.c<br>
&gt; index 1629ff9c3949..1e6c40e32cfd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c<br>
&gt; @@ -2090,7 &#43;2090,7 @@ static int dce_v8_0_crtc_do_set_base(struct =
drm_crtc *crtc,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!atomic &amp;&amp; fb &a=
mp;&amp; fb !=3D crtc-&gt;primary-&gt;fb) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return =
r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(abo);<br>
&gt; @@ -2441,7 &#43;2441,7 @@ static int dce_v8_0_crtc_cursor_set2(struct =
drm_crtc *crtc,<br>
&gt;&nbsp;&nbsp; unpin:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_crtc-&gt;cursor_b=
o) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *aobj =3D gem_to_amdgpu_bo(amdgpu_crtc=
-&gt;cursor_bo);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; ret =3D amdgpu_bo_reserve(aobj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; ret =3D amdgpu_bo_reserve(aobj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (likely(ret =3D=3D 0)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unpin(aobj);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
bo_unreserve(aobj);<br>
&gt; @@ -2571,7 &#43;2571,7 @@ static void dce_v8_0_crtc_disable(struct drm=
_crtc *crtc)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(crtc-&gt;primary-&g=
t;fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;failed to reserve abo before unpin\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c b/drivers/gpu/dr=
m/amd/amdgpu/dce_virtual.c<br>
&gt; index 8bb9cfde508d..084518301f4b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/dce_virtual.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/dce_virtual.c<br>
&gt; @@ -247,7 &#43;247,7 @@ static void dce_virtual_crtc_disable(struct dr=
m_crtc *crtc)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_fb =3D to_amdgpu_framebuffer(crtc-&gt;primary-&g=
t;fb);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; abo =3D gem_to_amdgpu_bo(amdgpu_fb-&gt;obj);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(abo, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(abo, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERR=
OR(&quot;failed to reserve abo before unpin\n&quot;);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; else {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v6_0.c<br>
&gt; index 25c3703f838b..03d2a0a2e523 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c<br>
&gt; @@ -2437,7 &#43;2437,7 @@ static void gfx_v6_0_rlc_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.save_re=
store_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.save_restore_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.save_restore_obj, true);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve RLC sr bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.rlc.save_restore_obj);<br>
&gt; @@ -2448,7 &#43;2448,7 @@ static void gfx_v6_0_rlc_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.clear_s=
tate_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.clear_state_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.clear_state_obj, true);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve RLC c bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.rlc.clear_state_obj);<br>
&gt; @@ -2459,7 &#43;2459,7 @@ static void gfx_v6_0_rlc_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.cp_tabl=
e_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.cp_table_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.cp_table_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve RLC cp table bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.rlc.cp_table_obj);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v7_0.c<br>
&gt; index 75cca54fa216..b2df8e814abb 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; @@ -2792,7 &#43;2792,7 @@ static void gfx_v7_0_cp_compute_fini(struct =
amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;gfx.compute_=
ring[i];<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ring-&gt;mqd_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve=
(ring-&gt;mqd_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_res=
erve(ring-&gt;mqd_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unl=
ikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;(%d) =
reserve MQD bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -2810,7 &#43;2810,7 @@ static void gfx_v7_0_mec_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.mec.hpd_eop=
_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.mec.hpd_eop_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.mec.hpd_eop_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve HPD EOP bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; @@ -3359,7 &#43;3359,7 @@ static void gfx_v7_0_rlc_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* save restore block */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.save_re=
store_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.save_restore_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.save_restore_obj, true);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve RLC sr bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.rlc.save_restore_obj);<br>
&gt; @@ -3371,7 &#43;3371,7 @@ static void gfx_v7_0_rlc_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear state block */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.clear_s=
tate_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.clear_state_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.clear_state_obj, true);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve RLC c bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.rlc.clear_state_obj);<br>
&gt; @@ -3383,7 &#43;3383,7 @@ static void gfx_v7_0_rlc_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear state block */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.cp_tabl=
e_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.cp_table_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.cp_table_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve RLC cp table bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.rlc.cp_table_obj);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v8_0.c<br>
&gt; index 2a5b20920ea6..ac64e01c6938 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -1244,7 &#43;1244,7 @@ static void gfx_v8_0_rlc_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* clear state block */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.clear_s=
tate_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.clear_state_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.clear_state_obj, true);<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve RLC cbs bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.rlc.clear_state_obj);<br>
&gt; @@ -1255,7 &#43;1255,7 @@ static void gfx_v8_0_rlc_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* jump table block */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.rlc.cp_tabl=
e_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.cp_table_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.rlc.cp_table_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve RLC cp table bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.rlc.cp_table_obj);<br>
&gt; @@ -1368,7 &#43;1368,7 @@ static void gfx_v8_0_mec_fini(struct amdgpu_=
device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.mec.hpd_eop=
_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.mec.hpd_eop_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.mec.hpd_eop_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve HPD EOP bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; @@ -1496,7 &#43;1496,7 @@ static int gfx_v8_0_kiq_init(struct amdgpu_d=
evice *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, MEC_HPD_SIZE)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(kiq-&gt;eop_obj, fal=
se);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(kiq-&gt;eop_obj,=
 true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;(%d) reserve kiq eop bo fa=
iled\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(kiq-&gt;eop=
_obj);<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/a=
md/amdgpu/gfx_v9_0.c<br>
&gt; index 5249bc7964fb..08daa3fd687b 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -453,7 &#43;453,7 @@ static void gfx_v9_0_mec_fini(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.mec.hpd_eop=
_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.mec.hpd_eop_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.mec.hpd_eop_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve HPD EOP bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.mec.hpd_eop_obj);<br>
&gt; @@ -463,7 &#43;463,7 @@ static void gfx_v9_0_mec_fini(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.mec.hpd_eop_obj =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;gfx.mec.mec_fw_=
obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.mec.mec_fw_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_bo_reserve(adev-&gt;gfx.mec.mec_fw_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_war=
n(adev-&gt;dev, &quot;(%d) reserve mec firmware bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_bo_unpin(adev-&gt;gfx.mec.mec_fw_obj);<br>
&gt; @@ -599,7 &#43;599,7 @@ static int gfx_v9_0_kiq_init(struct amdgpu_dev=
ice *adev)<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(hpd, 0, MEC_HPD_SIZE)=
;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(kiq-&gt;eop_obj, fal=
se);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve(kiq-&gt;eop_obj,=
 true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unlikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;(%d) reserve kiq eop bo fa=
iled\n&quot;, r);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_bo_kunmap(kiq-&gt;eop=
_obj);<br>
&gt; @@ -1786,7 &#43;1786,7 @@ static void gfx_v9_0_cp_compute_fini(struct =
amdgpu_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =3D &amp;adev-&gt;gfx.compute_=
ring[i];<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (ring-&gt;mqd_obj) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_reserve=
(ring-&gt;mqd_obj, false);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_bo_res=
erve(ring-&gt;mqd_obj, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (unl=
ikely(r !=3D 0))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;(%d) =
reserve MQD bo failed\n&quot;, r);<br>
&gt;&nbsp;&nbsp; <br>
<br>
<br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk274699" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14933885618700.08564324282660418" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14933885618660.31851255213751084" style=3D"width: =
90%; background-color: rgb(255, 255, 255); position: relative; overflow: au=
to; padding-top: 20px; padding-bottom: 20px; margin-top: 20px; border-top: =
1px dotted rgb(200, 200, 200); border-bottom: 1px dotted rgb(200, 200, 200)=
;" role=3D"presentation" cellspacing=3D"0">
<tbody>
<tr style=3D"border-spacing: 0px;" valign=3D"top">
<td id=3D"TextCell_14933885618670.7018199738421703" style=3D"vertical-align=
: top; position: relative; padding: 0px; display: table-cell;" colspan=3D"2=
">
<div id=3D"LPRemovePreviewContainer_14933885618670.43477942816972304"></div=
>
<div id=3D"LPTitle_14933885618670.025317354189944186" style=3D"top: 0px; co=
lor: rgb(0, 120, 215); font-weight: 400; font-size: 21px; font-family: &quo=
t;wf_segoe-ui_light&quot;,&quot;Segoe UI Light&quot;,&quot;Segoe WP Light&q=
uot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; lin=
e-height: 21px;">
<a id=3D"LPUrlAnchor_14933885618680.4105438607817886" style=3D"text-decorat=
ion: none;" href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx"=
 target=3D"_blank">amd-gfx Info Page - freedesktop.org</a></div>
<div id=3D"LPMetadata_14933885618680.7841659128532912" style=3D"margin: 10p=
x 0px 16px; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot=
;wf_segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,=
Arial,sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14933885618690.9239757500057303" style=3D"display:=
 block; color: rgb(102, 102, 102); font-weight: 400; font-family: &quot;wf_=
segoe-ui_normal&quot;,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Aria=
l,sans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overfl=
ow: hidden;">
Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the following f=
orm. Use of all freedesktop.org lists is subject to our Code of ...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
<br>
------------------------------<br>
<br>
End of amd-gfx Digest, Vol 11, Issue 407<br>
****************************************<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MWHPR1201MB0045C097101B0EDA13F28BD9F2130MWHPR1201MB0045_--

--===============1572300442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1572300442==--
