From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: clean up memory/GDS/GWS/OA alignment code
Date: Mon, 28 Jan 2019 12:25:21 -0500
Message-ID: <CAAxE2A5iYwWCcrmUWxecoKtcjtuH=9sx==e3W3-kBnBwmfD1aA@mail.gmail.com>
References: <20190122214532.1822-1-maraeo@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1350293406=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20190122214532.1822-1-maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

--===============1350293406==
Content-Type: multipart/alternative; boundary="00000000000049e7eb058087f86a"

--00000000000049e7eb058087f86a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping

On Tue, Jan 22, 2019 at 4:45 PM Marek Ol=C5=A1=C3=A1k <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wr=
ote:

> From: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
>
> - move all adjustments into one place
> - specify GDS/GWS/OA alignment in basic units of the heaps
> - it looks like GDS alignment was 1 instead of 4
>
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  7 -------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 16 ++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  6 +++---
>  3 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f4f00217546e..d21dd2f369da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -47,24 +47,20 @@ int amdgpu_gem_object_create(struct amdgpu_device
> *adev, unsigned long size,
>                              u64 flags, enum ttm_bo_type type,
>                              struct reservation_object *resv,
>                              struct drm_gem_object **obj)
>  {
>         struct amdgpu_bo *bo;
>         struct amdgpu_bo_param bp;
>         int r;
>
>         memset(&bp, 0, sizeof(bp));
>         *obj =3D NULL;
> -       /* At least align on page size */
> -       if (alignment < PAGE_SIZE) {
> -               alignment =3D PAGE_SIZE;
> -       }
>
>         bp.size =3D size;
>         bp.byte_align =3D alignment;
>         bp.type =3D type;
>         bp.resv =3D resv;
>         bp.preferred_domain =3D initial_domain;
>  retry:
>         bp.flags =3D flags;
>         bp.domain =3D initial_domain;
>         r =3D amdgpu_bo_create(adev, &bp, &bo);
> @@ -237,23 +233,20 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev,
> void *data,
>         if (args->in.domains & (AMDGPU_GEM_DOMAIN_GDS |
>             AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) {
>                 if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>                         /* if gds bo is created from user space, it must =
be
>                          * passed to bo list
>                          */
>                         DRM_ERROR("GDS bo cannot be per-vm-bo\n");
>                         return -EINVAL;
>                 }
>                 flags |=3D AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> -               /* GDS allocations must be DW aligned */
> -               if (args->in.domains & AMDGPU_GEM_DOMAIN_GDS)
> -                       size =3D ALIGN(size, 4);
>         }
>
>         if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
>                 r =3D amdgpu_bo_reserve(vm->root.base.bo, false);
>                 if (r)
>                         return r;
>
>                 resv =3D vm->root.base.bo->tbo.resv;
>         }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 728e15e5d68a..fd9c4beeaaa4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -419,26 +419,34 @@ static int amdgpu_bo_do_create(struct amdgpu_device
> *adev,
>                 .interruptible =3D (bp->type !=3D ttm_bo_type_kernel),
>                 .no_wait_gpu =3D false,
>                 .resv =3D bp->resv,
>                 .flags =3D TTM_OPT_FLAG_ALLOW_RES_EVICT
>         };
>         struct amdgpu_bo *bo;
>         unsigned long page_align, size =3D bp->size;
>         size_t acc_size;
>         int r;
>
> -       page_align =3D roundup(bp->byte_align, PAGE_SIZE) >> PAGE_SHIFT;
> -       if (bp->domain & (AMDGPU_GEM_DOMAIN_GDS | AMDGPU_GEM_DOMAIN_GWS |
> -                         AMDGPU_GEM_DOMAIN_OA))
> +       /* Note that GDS/GWS/OA allocates 1 page per byte/resource. */
> +       if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA)) =
{
> +               /* GWS and OA don't need any alignment. */
> +               page_align =3D bp->byte_align;
>                 size <<=3D PAGE_SHIFT;
> -       else
> +       } else if (bp->domain & AMDGPU_GEM_DOMAIN_GDS) {
> +               /* Both size and alignment must be a multiple of 4. */
> +               page_align =3D ALIGN(bp->byte_align, 4);
> +               size =3D ALIGN(size, 4) << PAGE_SHIFT;
> +       } else {
> +               /* Memory should be aligned at least to a page size. */
> +               page_align =3D ALIGN(bp->byte_align, PAGE_SIZE) >>
> PAGE_SHIFT;
>                 size =3D ALIGN(size, PAGE_SIZE);
> +       }
>
>         if (!amdgpu_bo_validate_size(adev, size, bp->domain))
>                 return -ENOMEM;
>
>         *bo_ptr =3D NULL;
>
>         acc_size =3D ttm_bo_dma_acc_size(&adev->mman.bdev, size,
>                                        sizeof(struct amdgpu_bo));
>
>         bo =3D kzalloc(sizeof(struct amdgpu_bo), GFP_KERNEL);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index b852abb9db0f..73e71e61dc99 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1749,47 +1749,47 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>
>         /* Initialize various on-chip memory pools */
>         r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_GDS,
>                            adev->gds.mem.total_size);
>         if (r) {
>                 DRM_ERROR("Failed initializing GDS heap.\n");
>                 return r;
>         }
>
>         r =3D amdgpu_bo_create_kernel(adev, adev->gds.mem.gfx_partition_s=
ize,
> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_GDS,
> +                                   4, AMDGPU_GEM_DOMAIN_GDS,
>                                     &adev->gds.gds_gfx_bo, NULL, NULL);
>         if (r)
>                 return r;
>
>         r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_GWS,
>                            adev->gds.gws.total_size);
>         if (r) {
>                 DRM_ERROR("Failed initializing gws heap.\n");
>                 return r;
>         }
>
>         r =3D amdgpu_bo_create_kernel(adev, adev->gds.gws.gfx_partition_s=
ize,
> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_GWS,
> +                                   1, AMDGPU_GEM_DOMAIN_GWS,
>                                     &adev->gds.gws_gfx_bo, NULL, NULL);
>         if (r)
>                 return r;
>
>         r =3D ttm_bo_init_mm(&adev->mman.bdev, AMDGPU_PL_OA,
>                            adev->gds.oa.total_size);
>         if (r) {
>                 DRM_ERROR("Failed initializing oa heap.\n");
>                 return r;
>         }
>
>         r =3D amdgpu_bo_create_kernel(adev, adev->gds.oa.gfx_partition_si=
ze,
> -                                   PAGE_SIZE, AMDGPU_GEM_DOMAIN_OA,
> +                                   1, AMDGPU_GEM_DOMAIN_OA,
>                                     &adev->gds.oa_gfx_bo, NULL, NULL);
>         if (r)
>                 return r;
>
>         /* Register debugfs entries for amdgpu_ttm */
>         r =3D amdgpu_ttm_debugfs_init(adev);
>         if (r) {
>                 DRM_ERROR("Failed to init debugfs\n");
>                 return r;
>         }
> --
> 2.17.1
>
>

--00000000000049e7eb058087f86a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+UGluZzxicj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUi
PjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUdWUsIEphbiAyMiwgMjAxOSBh
dCA0OjQ1IFBNIE1hcmVrIE9sxaHDoWsgJmx0OzxhIGhyZWY9Im1haWx0bzptYXJhZW9AZ21haWwu
Y29tIj5tYXJhZW9AZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3Jk
ZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5Gcm9t
OiBNYXJlayBPbMWhw6FrICZsdDs8YSBocmVmPSJtYWlsdG86bWFyZWsub2xzYWtAYW1kLmNvbSIg
dGFyZ2V0PSJfYmxhbmsiPm1hcmVrLm9sc2FrQGFtZC5jb208L2E+Jmd0Ozxicj4NCjxicj4NCi0g
bW92ZSBhbGwgYWRqdXN0bWVudHMgaW50byBvbmUgcGxhY2U8YnI+DQotIHNwZWNpZnkgR0RTL0dX
Uy9PQSBhbGlnbm1lbnQgaW4gYmFzaWMgdW5pdHMgb2YgdGhlIGhlYXBzPGJyPg0KLSBpdCBsb29r
cyBsaWtlIEdEUyBhbGlnbm1lbnQgd2FzIDEgaW5zdGVhZCBvZiA0PGJyPg0KPGJyPg0KU2lnbmVk
LW9mZi1ieTogTWFyZWsgT2zFocOhayAmbHQ7PGEgaHJlZj0ibWFpbHRvOm1hcmVrLm9sc2FrQGFt
ZC5jb20iIHRhcmdldD0iX2JsYW5rIj5tYXJlay5vbHNha0BhbWQuY29tPC9hPiZndDs8YnI+DQot
LS08YnI+DQrCoGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9nZW0uY8KgIMKgIHzC
oCA3IC0tLS0tLS08YnI+DQrCoGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmpl
Y3QuYyB8IDE2ICsrKysrKysrKysrKy0tLS08YnI+DQrCoGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uY8KgIMKgIHzCoCA2ICsrKy0tLTxicj4NCsKgMyBmaWxlcyBjaGFuZ2Vk
LCAxNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dlbS5jPGJyPg0KaW5kZXggZjRmMDAyMTc1NDZlLi5kMjFk
ZDJmMzY5ZGEgMTAwNjQ0PGJyPg0KLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X2dlbS5jPGJyPg0KKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2dl
bS5jPGJyPg0KQEAgLTQ3LDI0ICs0NywyMCBAQCBpbnQgYW1kZ3B1X2dlbV9vYmplY3RfY3JlYXRl
KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LCB1bnNpZ25lZCBsb25nIHNpemUsPGJyPg0KwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB1NjQgZmxhZ3MsIGVudW0g
dHRtX2JvX3R5cGUgdHlwZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHN0cnVjdCByZXNlcnZhdGlvbl9vYmplY3QgKnJlc3YsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBzdHJ1Y3QgZHJtX2dlbV9vYmplY3Qg
KipvYmopPGJyPg0KwqB7PGJyPg0KwqAgwqAgwqAgwqAgc3RydWN0IGFtZGdwdV9ibyAqYm87PGJy
Pg0KwqAgwqAgwqAgwqAgc3RydWN0IGFtZGdwdV9ib19wYXJhbSBicDs8YnI+DQrCoCDCoCDCoCDC
oCBpbnQgcjs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBtZW1zZXQoJmFtcDticCwgMCwgc2l6ZW9m
KGJwKSk7PGJyPg0KwqAgwqAgwqAgwqAgKm9iaiA9IE5VTEw7PGJyPg0KLcKgIMKgIMKgIMKgLyog
QXQgbGVhc3QgYWxpZ24gb24gcGFnZSBzaXplICovPGJyPg0KLcKgIMKgIMKgIMKgaWYgKGFsaWdu
bWVudCAmbHQ7IFBBR0VfU0laRSkgezxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFsaWdu
bWVudCA9IFBBR0VfU0laRTs8YnI+DQotwqAgwqAgwqAgwqB9PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgYnAuc2l6ZSA9IHNpemU7PGJyPg0KwqAgwqAgwqAgwqAgYnAuYnl0ZV9hbGlnbiA9IGFsaWdu
bWVudDs8YnI+DQrCoCDCoCDCoCDCoCBicC50eXBlID0gdHlwZTs8YnI+DQrCoCDCoCDCoCDCoCBi
cC5yZXN2ID0gcmVzdjs8YnI+DQrCoCDCoCDCoCDCoCBicC5wcmVmZXJyZWRfZG9tYWluID0gaW5p
dGlhbF9kb21haW47PGJyPg0KwqByZXRyeTo8YnI+DQrCoCDCoCDCoCDCoCBicC5mbGFncyA9IGZs
YWdzOzxicj4NCsKgIMKgIMKgIMKgIGJwLmRvbWFpbiA9IGluaXRpYWxfZG9tYWluOzxicj4NCsKg
IMKgIMKgIMKgIHIgPSBhbWRncHVfYm9fY3JlYXRlKGFkZXYsICZhbXA7YnAsICZhbXA7Ym8pOzxi
cj4NCkBAIC0yMzcsMjMgKzIzMywyMCBAQCBpbnQgYW1kZ3B1X2dlbV9jcmVhdGVfaW9jdGwoc3Ry
dWN0IGRybV9kZXZpY2UgKmRldiwgdm9pZCAqZGF0YSw8YnI+DQrCoCDCoCDCoCDCoCBpZiAoYXJn
cy0mZ3Q7aW4uZG9tYWlucyAmYW1wOyAoQU1ER1BVX0dFTV9ET01BSU5fR0RTIHw8YnI+DQrCoCDC
oCDCoCDCoCDCoCDCoCBBTURHUFVfR0VNX0RPTUFJTl9HV1MgfCBBTURHUFVfR0VNX0RPTUFJTl9P
QSkpIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBpZiAoZmxhZ3MgJmFtcDsgQU1ER1BV
X0dFTV9DUkVBVEVfVk1fQUxXQVlTX1ZBTElEKSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgLyogaWYgZ2RzIGJvIGlzIGNyZWF0ZWQgZnJvbSB1c2VyIHNwYWNlLCBp
dCBtdXN0IGJlPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqIHBh
c3NlZCB0byBibyBsaXN0PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAqLzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERSTV9FUlJPUigm
cXVvdDtHRFMgYm8gY2Fubm90IGJlIHBlci12bS1ib1xuJnF1b3Q7KTs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gLUVJTlZBTDs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCB9PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgZmxhZ3MgfD0gQU1E
R1BVX0dFTV9DUkVBVEVfTk9fQ1BVX0FDQ0VTUzs8YnI+DQotwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAvKiBHRFMgYWxsb2NhdGlvbnMgbXVzdCBiZSBEVyBhbGlnbmVkICovPGJyPg0KLcKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaWYgKGFyZ3MtJmd0O2luLmRvbWFpbnMgJmFtcDsgQU1ER1BVX0dFTV9E
T01BSU5fR0RTKTxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNpemUg
PSBBTElHTihzaXplLCA0KTs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KwqAgwqAgwqAg
wqAgaWYgKGZsYWdzICZhbXA7IEFNREdQVV9HRU1fQ1JFQVRFX1ZNX0FMV0FZU19WQUxJRCkgezxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHIgPSBhbWRncHVfYm9fcmVzZXJ2ZSh2bS0mZ3Q7
PGEgaHJlZj0iaHR0cDovL3Jvb3QuYmFzZS5ibyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9Il9i
bGFuayI+cm9vdC5iYXNlLmJvPC9hPiwgZmFsc2UpOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIGlmIChyKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVy
biByOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJlc3YgPSB2bS0mZ3Q7cm9v
dC5iYXNlLmJvLSZndDt0Ym8ucmVzdjs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYzxicj4NCmluZGV4IDcyOGUx
NWU1ZDY4YS4uZmQ5YzRiZWVhYWE0IDEwMDY0NDxicj4NCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9vYmplY3QuYzxicj4NCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9vYmplY3QuYzxicj4NCkBAIC00MTksMjYgKzQxOSwzNCBAQCBzdGF0aWMg
aW50IGFtZGdwdV9ib19kb19jcmVhdGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmludGVycnVwdGlibGUgPSAoYnAtJmd0O3R5cGUgIT0g
dHRtX2JvX3R5cGVfa2VybmVsKSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAubm9fd2Fp
dF9ncHUgPSBmYWxzZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAucmVzdiA9IGJwLSZn
dDtyZXN2LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5mbGFncyA9IFRUTV9PUFRfRkxB
R19BTExPV19SRVNfRVZJQ1Q8YnI+DQrCoCDCoCDCoCDCoCB9Ozxicj4NCsKgIMKgIMKgIMKgIHN0
cnVjdCBhbWRncHVfYm8gKmJvOzxicj4NCsKgIMKgIMKgIMKgIHVuc2lnbmVkIGxvbmcgcGFnZV9h
bGlnbiwgc2l6ZSA9IGJwLSZndDtzaXplOzxicj4NCsKgIMKgIMKgIMKgIHNpemVfdCBhY2Nfc2l6
ZTs8YnI+DQrCoCDCoCDCoCDCoCBpbnQgcjs8YnI+DQo8YnI+DQotwqAgwqAgwqAgwqBwYWdlX2Fs
aWduID0gcm91bmR1cChicC0mZ3Q7Ynl0ZV9hbGlnbiwgUEFHRV9TSVpFKSAmZ3Q7Jmd0OyBQQUdF
X1NISUZUOzxicj4NCi3CoCDCoCDCoCDCoGlmIChicC0mZ3Q7ZG9tYWluICZhbXA7IChBTURHUFVf
R0VNX0RPTUFJTl9HRFMgfCBBTURHUFVfR0VNX0RPTUFJTl9HV1MgfDxicj4NCi3CoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFNREdQVV9HRU1fRE9NQUlOX09BKSk8YnI+DQor
wqAgwqAgwqAgwqAvKiBOb3RlIHRoYXQgR0RTL0dXUy9PQSBhbGxvY2F0ZXMgMSBwYWdlIHBlciBi
eXRlL3Jlc291cmNlLiAqLzxicj4NCivCoCDCoCDCoCDCoGlmIChicC0mZ3Q7ZG9tYWluICZhbXA7
IChBTURHUFVfR0VNX0RPTUFJTl9HV1MgfCBBTURHUFVfR0VNX0RPTUFJTl9PQSkpIHs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBHV1MgYW5kIE9BIGRvbiYjMzk7dCBuZWVkIGFueSBh
bGlnbm1lbnQuICovPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcGFnZV9hbGlnbiA9IGJw
LSZndDtieXRlX2FsaWduOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHNpemUgJmx0OyZs
dDs9IFBBR0VfU0hJRlQ7PGJyPg0KLcKgIMKgIMKgIMKgZWxzZTxicj4NCivCoCDCoCDCoCDCoH0g
ZWxzZSBpZiAoYnAtJmd0O2RvbWFpbiAmYW1wOyBBTURHUFVfR0VNX0RPTUFJTl9HRFMpIHs8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAvKiBCb3RoIHNpemUgYW5kIGFsaWdubWVudCBtdXN0
IGJlIGEgbXVsdGlwbGUgb2YgNC4gKi88YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwYWdl
X2FsaWduID0gQUxJR04oYnAtJmd0O2J5dGVfYWxpZ24sIDQpOzxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHNpemUgPSBBTElHTihzaXplLCA0KSAmbHQ7Jmx0OyBQQUdFX1NISUZUOzxicj4N
CivCoCDCoCDCoCDCoH0gZWxzZSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLyogTWVt
b3J5IHNob3VsZCBiZSBhbGlnbmVkIGF0IGxlYXN0IHRvIGEgcGFnZSBzaXplLiAqLzxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhZ2VfYWxpZ24gPSBBTElHTihicC0mZ3Q7Ynl0ZV9hbGln
biwgUEFHRV9TSVpFKSAmZ3Q7Jmd0OyBQQUdFX1NISUZUOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIHNpemUgPSBBTElHTihzaXplLCBQQUdFX1NJWkUpOzxicj4NCivCoCDCoCDCoCDCoH08
YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCBpZiAoIWFtZGdwdV9ib192YWxpZGF0ZV9zaXplKGFkZXYs
IHNpemUsIGJwLSZndDtkb21haW4pKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVy
biAtRU5PTUVNOzxicj4NCjxicj4NCsKgIMKgIMKgIMKgICpib19wdHIgPSBOVUxMOzxicj4NCjxi
cj4NCsKgIMKgIMKgIMKgIGFjY19zaXplID0gdHRtX2JvX2RtYV9hY2Nfc2l6ZSgmYW1wO2FkZXYt
Jmd0O21tYW4uYmRldiwgc2l6ZSw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2JvKSk7PGJy
Pg0KPGJyPg0KwqAgwqAgwqAgwqAgYm8gPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgYW1kZ3B1X2Jv
KSwgR0ZQX0tFUk5FTCk7PGJyPg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1k
Z3B1L2FtZGdwdV90dG0uYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0u
Yzxicj4NCmluZGV4IGI4NTJhYmI5ZGIwZi4uNzNlNzFlNjFkYzk5IDEwMDY0NDxicj4NCi0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYzxicj4NCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV90dG0uYzxicj4NCkBAIC0xNzQ5LDQ3ICsxNzQ5
LDQ3IEBAIGludCBhbWRncHVfdHRtX2luaXQoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpPGJy
Pg0KPGJyPg0KwqAgwqAgwqAgwqAgLyogSW5pdGlhbGl6ZSB2YXJpb3VzIG9uLWNoaXAgbWVtb3J5
IHBvb2xzICovPGJyPg0KwqAgwqAgwqAgwqAgciA9IHR0bV9ib19pbml0X21tKCZhbXA7YWRldi0m
Z3Q7bW1hbi5iZGV2LCBBTURHUFVfUExfR0RTLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgYWRldi0mZ3Q7Z2RzLm1lbS50b3RhbF9zaXplKTs8YnI+DQrCoCDC
oCDCoCDCoCBpZiAocikgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIERSTV9FUlJPUigm
cXVvdDtGYWlsZWQgaW5pdGlhbGl6aW5nIEdEUyBoZWFwLlxuJnF1b3Q7KTs8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gcjs8YnI+DQrCoCDCoCDCoCDCoCB9PGJyPg0KPGJyPg0K
wqAgwqAgwqAgwqAgciA9IGFtZGdwdV9ib19jcmVhdGVfa2VybmVsKGFkZXYsIGFkZXYtJmd0O2dk
cy5tZW0uZ2Z4X3BhcnRpdGlvbl9zaXplLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFBBR0VfU0laRSwgQU1ER1BVX0dFTV9ET01BSU5f
R0RTLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDQsIEFNREdQVV9HRU1fRE9NQUlOX0dEUyw8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAmYW1wO2FkZXYtJmd0O2dkcy5nZHNf
Z2Z4X2JvLCBOVUxMLCBOVUxMKTs8YnI+DQrCoCDCoCDCoCDCoCBpZiAocik8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gcjs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCByID0gdHRt
X2JvX2luaXRfbW0oJmFtcDthZGV2LSZndDttbWFuLmJkZXYsIEFNREdQVV9QTF9HV1MsPGJyPg0K
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBhZGV2LSZndDtnZHMuZ3dz
LnRvdGFsX3NpemUpOzxicj4NCsKgIMKgIMKgIMKgIGlmIChyKSB7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgRFJNX0VSUk9SKCZxdW90O0ZhaWxlZCBpbml0aWFsaXppbmcgZ3dzIGhlYXAu
XG4mcXVvdDspOzxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiByOzxicj4NCsKg
IMKgIMKgIMKgIH08YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCByID0gYW1kZ3B1X2JvX2NyZWF0ZV9r
ZXJuZWwoYWRldiwgYWRldi0mZ3Q7Z2RzLmd3cy5nZnhfcGFydGl0aW9uX3NpemUsPGJyPg0KLcKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUEFHRV9T
SVpFLCBBTURHUFVfR0VNX0RPTUFJTl9HV1MsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMSwgQU1ER1BVX0dFTV9ET01BSU5fR1dTLDxi
cj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
ICZhbXA7YWRldi0mZ3Q7Z2RzLmd3c19nZnhfYm8sIE5VTEwsIE5VTEwpOzxicj4NCsKgIMKgIMKg
IMKgIGlmIChyKTxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiByOzxicj4NCjxi
cj4NCsKgIMKgIMKgIMKgIHIgPSB0dG1fYm9faW5pdF9tbSgmYW1wO2FkZXYtJmd0O21tYW4uYmRl
diwgQU1ER1BVX1BMX09BLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgYWRldi0mZ3Q7Z2RzLm9hLnRvdGFsX3NpemUpOzxicj4NCsKgIMKgIMKgIMKgIGlmIChy
KSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgRFJNX0VSUk9SKCZxdW90O0ZhaWxlZCBp
bml0aWFsaXppbmcgb2EgaGVhcC5cbiZxdW90Oyk7PGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgcmV0dXJuIHI7PGJyPg0KwqAgwqAgwqAgwqAgfTxicj4NCjxicj4NCsKgIMKgIMKgIMKgIHIg
PSBhbWRncHVfYm9fY3JlYXRlX2tlcm5lbChhZGV2LCBhZGV2LSZndDtnZHMub2EuZ2Z4X3BhcnRp
dGlvbl9zaXplLDxicj4NCi3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoFBBR0VfU0laRSwgQU1ER1BVX0dFTV9ET01BSU5fT0EsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMSwgQU1ER1BV
X0dFTV9ET01BSU5fT0EsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgJmFtcDthZGV2LSZndDtnZHMub2FfZ2Z4X2JvLCBOVUxMLCBOVUxM
KTs8YnI+DQrCoCDCoCDCoCDCoCBpZiAocik8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBy
ZXR1cm4gcjs8YnI+DQo8YnI+DQrCoCDCoCDCoCDCoCAvKiBSZWdpc3RlciBkZWJ1Z2ZzIGVudHJp
ZXMgZm9yIGFtZGdwdV90dG0gKi88YnI+DQrCoCDCoCDCoCDCoCByID0gYW1kZ3B1X3R0bV9kZWJ1
Z2ZzX2luaXQoYWRldik7PGJyPg0KwqAgwqAgwqAgwqAgaWYgKHIpIHs8YnI+DQrCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCBEUk1fRVJST1IoJnF1b3Q7RmFpbGVkIHRvIGluaXQgZGVidWdmc1xuJnF1
b3Q7KTs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCByZXR1cm4gcjs8YnI+DQrCoCDCoCDC
oCDCoCB9PGJyPg0KLS0gPGJyPg0KMi4xNy4xPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2
Pg0K
--00000000000049e7eb058087f86a--

--===============1350293406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1350293406==--
