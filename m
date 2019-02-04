From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queue
 doorbells mask on SOC15
Date: Mon, 4 Feb 2019 17:28:08 +0000
Message-ID: <SN1PR12MB236591C1FC2D9D965C4DA304F06D0@SN1PR12MB2365.namprd12.prod.outlook.com>
References: <20190131222703.3591-1-Yong.Zhao@amd.com>
 <20190131222703.3591-2-Yong.Zhao@amd.com>
 <e01f29c1-74e8-4dd6-81fc-b25c0432798f@amd.com>
 <BL0PR12MB250046784085018A70E34EC0F0920@BL0PR12MB2500.namprd12.prod.outlook.com>
 <DM5PR12MB25826F20FB8EF1E7E4B6348480930@DM5PR12MB2582.namprd12.prod.outlook.com>
 <5aca7b73-2ef6-8a33-4a1c-3f876459de40@amd.com>,
 <BL0PR12MB258041F4A571AE1356CA31B8806D0@BL0PR12MB2580.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0893864210=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BL0PR12MB258041F4A571AE1356CA31B8806D0-b4cIHhjg/p/XzH18dTCKOgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0893864210==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB236591C1FC2D9D965C4DA304F06D0SN1PR12MB2365namp_"

--_000_SN1PR12MB236591C1FC2D9D965C4DA304F06D0SN1PR12MB2365namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The decision we need to make here is which value we should program mmCP_MEC=
_DOORBELL_RANGE_UPPER. It is not very consistent right now throughout our c=
ode. If we let CP to use all the doorbells left over by SDMA, IH and VCN, t=
hen we should probably use 1024 for mmCP_MEC_DOORBELL_RANGE_UPPER. If we co=
ntinue to use adev->doorbell_index.userqueue_end * 2, as is currently in th=
e code, we should limit the CP doorbells in the range of 0 to adev->doorbel=
l_index.userqueue_end * 2 when allocating CP user queue doorbells.

It seems to me that either way would work.

Regards,
Yong
________________________________
From: Zeng, Oak
Sent: Monday, February 4, 2019 12:15 PM
To: Kuehling, Felix; Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: RE: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queue doorb=
ells mask on SOC15

Correct. MEC_DOORBELL_RANGE should cover both user and kernel CP (KIQ/HIQ/D=
IQ/amdgpu kernel MEC rings)queues. USERQUEUE_START/END should be renamed to=
 USER_CP_QUEUE_START/END.

Thanks,
Oak

-----Original Message-----
From: Kuehling, Felix
Sent: Monday, February 4, 2019 11:35 AM
To: Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>; Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>; amd-gfx@l=
ists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queue doorb=
ells mask on SOC15

I don't see anything about userqueue start/end in Yong's patch. That said, =
I think you're mixing up two different things. MEC_DOORBELL_RANGE is not th=
e same as userqueues? We have MEC kernel queues as well that would have to =
fall in the same range. And we have SDMA user queues that don't belong in t=
he MEC doorbell range. Therefore I think the name USERQUEUE_START/END is mi=
sleading.

Regards,
   Felix

On 2019-02-02 10:01 a.m., Zeng, Oak wrote:
>
> Hi Yong,
>
> mmCP_MEC_DOORBELL_RANGE_LOWER/UPPER are used at CP to double check a
> doorbell ringing routed to CP. It is a must to program. We have to
> keep userqueue_start/end. Sorry for the confusion.
>
> Regards,
>
> Oak
>
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> *On Behalf Of
> *Zhao, Yong
> *Sent:* Friday, February 1, 2019 7:04 PM
> *To:* Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>;
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
> *Subject:* Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user
> queue doorbells mask on SOC15
>
> Oak,
>
> It is a good idea to remove the userqueue_start/end. However, when
> doing so, I came to the following code in gfx_v9_0_kiq_init_register() :
>
>         /* enable the doorbell if requested */
>
>         if (ring->use_doorbell) {
>
> WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
>
>                     (adev->doorbell_index.kiq * 2) << 2);
>
> WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
>
> (adev->doorbell_index.userqueue_end * 2) << 2);
>
>         }
>
> I remember that you reached the conclusion in one email thread that
> mmCP_MEC_DOORBELL_RANGE_UPPER/LOWER did not have effect at all on
> gfx9. Have we got any firm conclusions from HW engineer in the end? If
> those two registers are still valid, we should enforce the range for
> CP queues.
>
> Regards,
>
> Yong
>
> ----------------------------------------------------------------------
> --
>
> *From:*Kuehling, Felix
> *Sent:* Friday, February 1, 2019 3:03 PM
> *To:* Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user
> queue doorbells mask on SOC15
>
> On 2019-01-31 5:27 p.m., Zhao, Yong wrote:
> > Reserved doorbells for SDMA IH and VCN were not properly masked out
> > when allocating doorbells for CP user queues. This patch fixed that.
> >
> > Change-Id: I670adfc3fd7725d2ed0bd9665cb7f69f8b9023c2
> > Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org
> > <mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org>>
>
> One mostly cosmetic comment inline. With that fixed, the series is
> Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org
> <mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>>
>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 17 ++++++++++---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  4 +++
> >   drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c  |  3 +++
> >   drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c  |  3 +++
> >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 +++++++
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 25
> >+++++++++++++------
> >   .../gpu/drm/amd/include/kgd_kfd_interface.h   | 19 +++++---------
> >   7 files changed, 56 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > index e957e42c539a..13710f34191a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > @@ -196,11 +196,20 @@ void amdgpu_amdkfd_device_init(struct
> amdgpu_device *adev)
> > gpu_resources.sdma_doorbell[1][i+1] =3D
> > adev->doorbell_index.sdma_engine[1] + 0x200 + (i >> 1);
> >                }
> > -             /* Doorbells 0x0e0-0ff and 0x2e0-2ff are reserved for
> > -              * SDMA, IH and VCN. So don't use them for the CP.
> > +
> > +             /* Because of the setting in registers like
> > +              * SDMA0_DOORBELL_RANGE etc., BIF statically uses the
> > +              * lower 12 bits of doorbell address for routing, in
> > +              * order to route the CP queue doorbells to CP engine,
> > +              * the doorbells allocated to CP queues have to be
> > +              * outside the range set for SDMA, VCN, and IH blocks
> > +              * Prior to SOC15, all queues use queue ID to
> > +              * determine doorbells.
> >                 */
> > -             gpu_resources.reserved_doorbell_mask =3D 0x1e0;
> > -             gpu_resources.reserved_doorbell_val  =3D 0x0e0;
> > +             gpu_resources.reserved_doorbells_start =3D
> > + adev->doorbell_index.sdma_engine[0];
> > +             gpu_resources.reserved_doorbells_end =3D
> > + adev->doorbell_index.last_non_cp;
> >
> >                kgd2kfd_device_init(adev->kfd.dev, &gpu_resources);
> >        }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> > index 1cfec06f81d4..4de431f7f380 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> > @@ -71,6 +71,7 @@ struct amdgpu_doorbell_index {
> >                        uint32_t vce_ring6_7;
> >                } uvd_vce;
> >        };
> > +     uint32_t last_non_cp;
> >        uint32_t max_assignment;
> >        /* Per engine SDMA doorbell size in dword */
> >        uint32_t sdma_doorbell_range;  @@ -143,6 +144,7 @@ typedef
> >enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
> > AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3             =3D 0x18D,
> > AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5             =3D 0x18E,
> > AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7             =3D 0x18F,
> > + AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP             =3D
> AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7,
> > AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            =3D 0x18F,
> >AMDGPU_VEGA20_DOORBELL_INVALID                   =3D 0xFFFF
> >   } AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
> > @@ -222,6 +224,8 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
> >        AMDGPU_DOORBELL64_VCE_RING4_5             =3D 0xFE,
> >        AMDGPU_DOORBELL64_VCE_RING6_7             =3D 0xFF,
> >
> > +     AMDGPU_DOORBELL64_LAST_NON_CP             =3D
> AMDGPU_DOORBELL64_VCE_RING6_7,
> > +
> >        AMDGPU_DOORBELL64_MAX_ASSIGNMENT          =3D 0xFF,
> >        AMDGPU_DOORBELL64_INVALID                 =3D 0xFFFF
> >   } AMDGPU_DOORBELL64_ASSIGNMENT;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
> b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
> > index 4b5d60ea3e78..fa0433199215 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
> > @@ -81,6 +81,9 @@ void vega10_doorbell_index_init(struct
> amdgpu_device *adev)
> >        adev->doorbell_index.uvd_vce.vce_ring2_3 =3D
> AMDGPU_DOORBELL64_VCE_RING2_3;
> >        adev->doorbell_index.uvd_vce.vce_ring4_5 =3D
> AMDGPU_DOORBELL64_VCE_RING4_5;
> >        adev->doorbell_index.uvd_vce.vce_ring6_7 =3D
> AMDGPU_DOORBELL64_VCE_RING6_7;
> > +
> > +     adev->doorbell_index.last_non_cp =3D
> > +AMDGPU_DOORBELL64_LAST_NON_CP;
> > +
> >        /* In unit of dword doorbell */
> >        adev->doorbell_index.max_assignment =3D
> AMDGPU_DOORBELL64_MAX_ASSIGNMENT << 1;
> >        adev->doorbell_index.sdma_doorbell_range =3D 4;  diff --git
> >a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
> b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
> > index 53716c593b2b..b1052caaff5e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
> > @@ -85,6 +85,9 @@ void vega20_doorbell_index_init(struct
> amdgpu_device *adev)
> >        adev->doorbell_index.uvd_vce.vce_ring2_3 =3D
> AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3;
> >        adev->doorbell_index.uvd_vce.vce_ring4_5 =3D
> AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5;
> >        adev->doorbell_index.uvd_vce.vce_ring6_7 =3D
> AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7;
> > +
> > +     adev->doorbell_index.last_non_cp =3D
> AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP;
> > +
> >        adev->doorbell_index.max_assignment =3D
> AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT << 1;
> >        adev->doorbell_index.sdma_doorbell_range =3D 20;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > index e5ebcca7f031..6b8459f852cc 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > @@ -103,6 +103,15 @@
> >
> >   #define KFD_KERNEL_QUEUE_SIZE 2048
> >
> > +/* 512 =3D 0x200
> > + * On SOC15, the doorbell index distance for SDMA RLC i and (i + 1)
> in the
> > + * same SDMA engine, where i is a even number.
> > + * For 8-bytes doorbells, it ensures that the mirror doorbell range
> (in terms
> > + * of low 12 bit address for each HW engine) on the second doorbell
> page is
> > + * the same as the range of the first doorbell page.*/ #define
> > +KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512
> > +
> > +
> >   /*
> >    * Kernel module parameter to specify maximum number of supported
> queues per
> >    * device
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > index 80b36e860a0a..c7b67c65d62d 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -607,13 +607,24 @@ static int init_doorbell_bitmap(struct
> qcm_process_device *qpd,
> >        if (!qpd->doorbell_bitmap)
> >                return -ENOMEM;
> >
> > -     /* Mask out any reserved doorbells */
> > -     for (i =3D 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS; i++)
> > -             if ((dev->shared_resources.reserved_doorbell_mask & i)
> > =3D=3D
> > - dev->shared_resources.reserved_doorbell_val) {
> > -                     set_bit(i, qpd->doorbell_bitmap);
> > -                     pr_debug("reserved doorbell 0x%03x\n", i);
> > -             }
> > +     /* Mask out all reserved doorbells for SDMA, IH, and VCN on SOC15=
.
> > +      * Because of the setting in registers like
> SDMA0_DOORBELL_RANGE etc.,
> > +      * BIF statically uses the lower 12 bits of doorbell address
> > +for
> > +      * routing. In order to route the CP queue doorbells to CP
> > +engine,
> > +      * the doorbells allocated to CP queues have to be outside the
> range
> > +      * set for SDMA, VCN, and IH blocks.
> > +      * Prior to SOC15, all queues use queue ID to
> > +      * determine doorbells. */
> > +     i =3D dev->shared_resources.reserved_doorbells_start;
> > +     while (i <=3D dev->shared_resources.reserved_doorbells_end) {
>
> This should be a for-loop to be more obvious:
>
>          for (i =3D dev->shared_resources.reserved_doorbells_start;
>               i <=3D dev->shared_resources.reserved_doorbells_end;
>               i++) {
>                  ...
>          }
>
>
> > +             set_bit(i, qpd->doorbell_bitmap);
> > +             set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
> > + qpd->doorbell_bitmap);
> > +             pr_debug("reserved doorbell 0x%03x and 0x%03x\n", i,
> > +                     i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET);
> > +
> > +             i++;
> > +     }
> >
> >        return 0;
> >   }
> > diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> > index 83d960110d23..b1bf45419d93 100644
> > --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> > +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> > @@ -137,20 +137,13 @@ struct kgd2kfd_shared_resources {
> >        /* Bit n =3D=3D 1 means Queue n is available for KFD */
> >        DECLARE_BITMAP(queue_bitmap, KGD_MAX_QUEUES);
> >
> > -     /* Doorbell assignments (SOC15 and later chips only). Only
> > -      * specific doorbells are routed to each SDMA engine. Others
> > -      * are routed to IH and VCN. They are not usable by the CP.
> > -      *
> > -      * Any doorbell number D that satisfies the following
> > condition
> > -      * is reserved: (D & reserved_doorbell_mask) =3D=3D
> reserved_doorbell_val
> > -      *
> > -      * KFD currently uses 1024 (=3D 0x3ff) doorbells per process. If
> > -      * doorbells 0x0e0-0x0ff and 0x2e0-0x2ff are reserved, that
> >means
> > -      * mask would be set to 0x1e0 and val set to 0x0e0.
> > -      */
> >        unsigned int sdma_doorbell[2][8];
> > -     unsigned int reserved_doorbell_mask;
> > -     unsigned int reserved_doorbell_val;
> > +
> > +     /* From SOC15 onwards, the doorbell indexes reserved for SDMA,
> > +IH,
> > +      * and VCN
> > +      */
> > +     unsigned int reserved_doorbells_start;
> > +     unsigned int reserved_doorbells_end;
> >
> >        /* Base address of doorbell aperture. */
> >        phys_addr_t doorbell_physical_address;
>

--_000_SN1PR12MB236591C1FC2D9D965C4DA304F06D0SN1PR12MB2365namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The decision we need to make here is which value we should program&nbsp;<sp=
an style=3D"font-family: Calibri, sans-serif; background-color: rgb(255, 25=
5, 255); display: inline !important">mmCP_MEC_DOORBELL_RANGE_UPPER. It is n=
ot very consistent right now throughout
 our code. If we let CP to use all the doorbells left over by SDMA, IH and =
VCN, then we should probably use 1024 for&nbsp;<span style=3D"font-family: =
Calibri, sans-serif; background-color: rgb(255, 255, 255); display: inline =
!important">mmCP_MEC_DOORBELL_RANGE_UPPER.
 If we continue to use&nbsp;<span style=3D"font-family: Calibri, sans-serif=
; background-color: rgb(255, 255, 255); display: inline !important">adev-&g=
t;doorbell_index.userqueue_end * 2, as is currently in the code, we should =
limit the CP doorbells in the range of 0 to&nbsp;<span style=3D"font-family=
: Calibri, sans-serif; background-color: rgb(255, 255, 255); display: inlin=
e !important">adev-&gt;doorbell_index.userqueue_end
 * 2 when allocating CP user queue doorbells.&nbsp;</span></span></span></s=
pan></div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0);"><font face=3D"Calibri,=
 sans-serif">It seems to me that either way would work.&nbsp;</font></div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0);"><font face=3D"Calibri,=
 sans-serif"><br>
</font></div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0);"><font face=3D"Calibri,=
 sans-serif">Regards,</font></div>
<div style=3D"font-size: 12pt; color: rgb(0, 0, 0);"><font face=3D"Calibri,=
 sans-serif">Yong</font></div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zeng, Oak<br>
<b>Sent:</b> Monday, February 4, 2019 12:15 PM<br>
<b>To:</b> Kuehling, Felix; Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> RE: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queu=
e doorbells mask on SOC15</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Correct. MEC_DOORBELL_RANGE should cover both user=
 and kernel CP (KIQ/HIQ/DIQ/amdgpu kernel MEC rings)queues. USERQUEUE_START=
/END should be renamed to USER_CP_QUEUE_START/END.<br>
<br>
Thanks,<br>
Oak<br>
<br>
-----Original Message-----<br>
From: Kuehling, Felix <br>
Sent: Monday, February 4, 2019 11:35 AM<br>
To: Zeng, Oak &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;; Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt=
;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
Subject: Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queue doorb=
ells mask on SOC15<br>
<br>
I don't see anything about userqueue start/end in Yong's patch. That said, =
I think you're mixing up two different things. MEC_DOORBELL_RANGE is not th=
e same as userqueues? We have MEC kernel queues as well that would have to =
fall in the same range. And we have
 SDMA user queues that don't belong in the MEC doorbell range. Therefore I =
think the name USERQUEUE_START/END is misleading.<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
On 2019-02-02 10:01 a.m., Zeng, Oak wrote:<br>
&gt;<br>
&gt; Hi Yong,<br>
&gt;<br>
&gt; mmCP_MEC_DOORBELL_RANGE_LOWER/UPPER are used at CP to double check a <=
br>
&gt; doorbell ringing routed to CP. It is a must to program. We have to <br=
>
&gt; keep userqueue_start/end. Sorry for the confusion.<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Oak<br>
&gt;<br>
&gt; *From:* amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; *On Beha=
lf Of <br>
&gt; *Zhao, Yong<br>
&gt; *Sent:* Friday, February 1, 2019 7:04 PM<br>
&gt; *To:* Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; <br>
&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Zeng, Oak &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; *Subject:* Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user <br>
&gt; queue doorbells mask on SOC15<br>
&gt;<br>
&gt; Oak,<br>
&gt;<br>
&gt; It is a good idea to remove the userqueue_start/end. However, when <br=
>
&gt; doing so, I came to the following code in gfx_v9_0_kiq_init_register()=
 :<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; /* enable the doorbell if requested */<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; if (ring-&gt;use_doorbell) {<br>
&gt;<br>
&gt; WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
(adev-&gt;doorbell_index.kiq * 2) &lt;&lt; 2);<br>
&gt;<br>
&gt; WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,<br>
&gt;<br>
&gt; (adev-&gt;doorbell_index.userqueue_end * 2) &lt;&lt; 2);<br>
&gt;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&gt;<br>
&gt; I remember that you reached the conclusion in one email thread that <b=
r>
&gt; mmCP_MEC_DOORBELL_RANGE_UPPER/LOWER did not have effect at all on <br>
&gt; gfx9. Have we got any firm conclusions from HW engineer in the end? If=
 <br>
&gt; those two registers are still valid, we should enforce the range for <=
br>
&gt; CP queues.<br>
&gt;<br>
&gt; Regards,<br>
&gt;<br>
&gt; Yong<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
<br>
&gt; --<br>
&gt;<br>
&gt; *From:*Kuehling, Felix<br>
&gt; *Sent:* Friday, February 1, 2019 3:03 PM<br>
&gt; *To:* Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <br>
&gt; &lt;<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">mailto:amd-gfx@li=
sts.freedesktop.org</a>&gt;<br>
&gt; *Subject:* Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user <br>
&gt; queue doorbells mask on SOC15<br>
&gt;<br>
&gt; On 2019-01-31 5:27 p.m., Zhao, Yong wrote:<br>
&gt; &gt; Reserved doorbells for SDMA IH and VCN were not properly masked o=
ut <br>
&gt; &gt; when allocating doorbells for CP user queues. This patch fixed th=
at.<br>
&gt; &gt;<br>
&gt; &gt; Change-Id: I670adfc3fd7725d2ed0bd9665cb7f69f8b9023c2<br>
&gt; &gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org <br>
&gt; &gt; &lt;<a href=3D"mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org">mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org=
</a>&gt;&gt;<br>
&gt;<br>
&gt; One mostly cosmetic comment inline. With that fixed, the series is<br>
&gt; Reviewed-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org <br>
&gt; &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">mailto:Felix.Kuehling@am=
d.com</a>&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp=
;&nbsp; | 17 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h&nbsp; |&=
nbsp; 4 &#43;&#43;&#43;<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c&nbsp; |&=
nbsp; 3 &#43;&#43;&#43;<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c&nbsp; |&=
nbsp; 3 &#43;&#43;&#43;<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;&#43;&#43;&#43;&#43;&#43;&#=
43;<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 25 <br>
&gt; &gt;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-=
-----<br>
&gt; &gt;&nbsp;&nbsp; .../gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbs=
p; | 19 &#43;&#43;&#43;&#43;&#43;---------<br>
&gt; &gt;&nbsp;&nbsp; 7 files changed, 56 insertions(&#43;), 24 deletions(-=
)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt; index e957e42c539a..13710f34191a 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &gt; @@ -196,11 &#43;196,20 @@ void amdgpu_amdkfd_device_init(struct<b=
r>
&gt; amdgpu_device *adev)<br>
&gt; &gt; gpu_resources.sdma_doorbell[1][i&#43;1] =3D<br>
&gt; &gt; adev-&gt;doorbell_index.sdma_engine[1] &#43; 0x200 &#43; (i &gt;&=
gt; 1);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /* Doorbells 0x0e0-0ff and 0x2e0-2ff are reserved for<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; * SDMA, IH and VCN. So don't use them for the CP.<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; /* Because of the setting in registers like<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * SDMA0_DOORBELL_RANGE etc., BIF statically uses the<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * lower 12 bits of doorbell address for routing, in<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * order to route the CP queue doorbells to CP engine,<br=
>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * the doorbells allocated to CP queues have to be<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * outside the range set for SDMA, VCN, and IH blocks<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * Prior to SOC15, all queues use queue ID to<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; * determine doorbells.<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; gpu_resources.reserved_doorbell_mask =3D 0x1e0;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; gpu_resources.reserved_doorbell_val&nbsp; =3D 0x0e0;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; gpu_resources.reserved_doorbells_start =3D<br>
&gt; &gt; &#43; adev-&gt;doorbell_index.sdma_engine[0];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; gpu_resources.reserved_doorbells_end =3D<br>
&gt; &gt; &#43; adev-&gt;doorbell_index.last_non_cp;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_device_init(adev-&gt;kfd.dev, &amp;gpu_res=
ources);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
&gt; &gt; index 1cfec06f81d4..4de431f7f380 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br=
>
&gt; &gt; @@ -71,6 &#43;71,7 @@ struct amdgpu_doorbell_index {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ui=
nt32_t vce_ring6_7;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } uvd_vce;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t last_non_cp;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_assignment=
;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Per engine SDMA door=
bell size in dword */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_doorbell_=
range;&nbsp; @@ -143,6 &#43;144,7 @@ typedef <br>
&gt; &gt;enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT<br>
&gt; &gt; AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x18D,<br>
&gt; &gt; AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x18E,<br>
&gt; &gt; AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x18F,<br>
&gt; &gt; &#43; AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D<br>
&gt; AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7,<br>
&gt; &gt; AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0x18F,&nbsp; <br>
&gt; &gt;AMDGPU_VEGA20_DOORBELL_INVALID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0xFFFF<br>
&gt; &gt;&nbsp;&nbsp; } AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;<br>
&gt; &gt; @@ -222,6 &#43;224,8 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMEN=
T<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_R=
ING4_5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0xFE,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_R=
ING6_7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; =3D 0xFF,<br>
&gt; &gt;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_LAST_NON_CP&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D<br>
&gt; AMDGPU_DOORBELL64_VCE_RING6_7,<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MAX_A=
SSIGNMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFF,<b=
r>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_INVAL=
ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFFFF<br>
&gt; &gt;&nbsp;&nbsp; } AMDGPU_DOORBELL64_ASSIGNMENT;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
&gt; &gt; index 4b5d60ea3e78..fa0433199215 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br=
>
&gt; &gt; @@ -81,6 &#43;81,9 @@ void vega10_doorbell_index_init(struct<br>
&gt; amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.uvd_vce.vce_ring2_3 =3D<br>
&gt; AMDGPU_DOORBELL64_VCE_RING2_3;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.uvd_vce.vce_ring4_5 =3D<br>
&gt; AMDGPU_DOORBELL64_VCE_RING4_5;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.uvd_vce.vce_ring6_7 =3D<br>
&gt; AMDGPU_DOORBELL64_VCE_RING6_7;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_cp=
 =3D <br>
&gt; &gt; &#43;AMDGPU_DOORBELL64_LAST_NON_CP;<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In unit of dword doo=
rbell */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.max_assignment =3D<br>
&gt; AMDGPU_DOORBELL64_MAX_ASSIGNMENT &lt;&lt; 1;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.sdma_doorbell_range =3D 4;&nbsp; diff --git <br>
&gt; &gt;a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
&gt; &gt; index 53716c593b2b..b1052caaff5e 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br=
>
&gt; &gt; @@ -85,6 &#43;85,9 @@ void vega20_doorbell_index_init(struct<br>
&gt; amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.uvd_vce.vce_ring2_3 =3D<br>
&gt; AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.uvd_vce.vce_ring4_5 =3D<br>
&gt; AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.uvd_vce.vce_ring6_7 =3D<br>
&gt; AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_cp=
 =3D<br>
&gt; AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP;<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.max_assignment =3D<br>
&gt; AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT &lt;&lt; 1;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index=
.sdma_doorbell_range =3D 20;<br>
&gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &gt; index e5ebcca7f031..6b8459f852cc 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &gt; @@ -103,6 &#43;103,15 @@<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp; #define KFD_KERNEL_QUEUE_SIZE 2048<br>
&gt; &gt;<br>
&gt; &gt; &#43;/* 512 =3D 0x200<br>
&gt; &gt; &#43; * On SOC15, the doorbell index distance for SDMA RLC i and =
(i &#43; 1)<br>
&gt; in the<br>
&gt; &gt; &#43; * same SDMA engine, where i is a even number.<br>
&gt; &gt; &#43; * For 8-bytes doorbells, it ensures that the mirror doorbel=
l range<br>
&gt; (in terms<br>
&gt; &gt; &#43; * of low 12 bit address for each HW engine) on the second d=
oorbell<br>
&gt; page is<br>
&gt; &gt; &#43; * the same as the range of the first doorbell page.*/ #defi=
ne <br>
&gt; &gt; &#43;KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp; /*<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; * Kernel module parameter to specify maximum nu=
mber of supported<br>
&gt; queues per<br>
&gt; &gt;&nbsp;&nbsp;&nbsp; * device<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &gt; index 80b36e860a0a..c7b67c65d62d 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &gt; @@ -607,13 &#43;607,24 @@ static int init_doorbell_bitmap(struct<=
br>
&gt; qcm_process_device *qpd,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!qpd-&gt;doorbell_b=
itmap)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Mask out any reserved doorbells */<b=
r>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; KFD_MAX_NUM_OF_QUE=
UES_PER_PROCESS; i&#43;&#43;)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if ((dev-&gt;shared_resources.reserved_doorbell_mask &amp; i) <br>
&gt; &gt; =3D=3D<br>
&gt; &gt; - dev-&gt;shared_resources.reserved_doorbell_val) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(i, qpd-&gt=
;doorbell_bitmap);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;res=
erved doorbell 0x%03x\n&quot;, i);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Mask out all reserved doorbells =
for SDMA, IH, and VCN on SOC15.<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Because of the setting in r=
egisters like<br>
&gt; SDMA0_DOORBELL_RANGE etc.,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * BIF statically uses the low=
er 12 bits of doorbell address <br>
&gt; &gt; &#43;for<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * routing. In order to route =
the CP queue doorbells to CP <br>
&gt; &gt; &#43;engine,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the doorbells allocated to =
CP queues have to be outside the<br>
&gt; range<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * set for SDMA, VCN, and IH b=
locks.<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Prior to SOC15, all queues =
use queue ID to<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * determine doorbells. */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; i =3D dev-&gt;shared_resources.rese=
rved_doorbells_start;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt;=3D dev-&gt;shared_res=
ources.reserved_doorbells_end) {<br>
&gt;<br>
&gt; This should be a for-loop to be more obvious:<br>
&gt;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D dev-&gt;sh=
ared_resources.reserved_doorbells_start;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; i &lt;=3D dev-&gt;shared_resources.reserved_doorbells_end;<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; i&#43;&#43;) {<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; ...<br>
&gt; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; set_bit(i, qpd-&gt;doorbell_bitmap);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; set_bit(i &#43; KFD_QUEUE_DOORBELL_MIRROR_OFFSET,<br>
&gt; &gt; &#43; qpd-&gt;doorbell_bitmap);<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; pr_debug(&quot;reserved doorbell 0x%03x and 0x%03x\n&quot;, i,=
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i &#43; KFD_QU=
EUE_DOORBELL_MIRROR_OFFSET);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; i&#43;&#43;;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp;&nbsp; }<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; &gt; index 83d960110d23..b1bf45419d93 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h=
<br>
&gt; &gt; @@ -137,20 &#43;137,13 @@ struct kgd2kfd_shared_resources {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit n =3D=3D 1 means=
 Queue n is available for KFD */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(queue_bi=
tmap, KGD_MAX_QUEUES);<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Doorbell assignments (SOC15 and late=
r chips only). Only<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * specific doorbells are routed t=
o each SDMA engine. Others<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * are routed to IH and VCN. They =
are not usable by the CP.<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Any doorbell number D that sati=
sfies the following <br>
&gt; &gt; condition<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is reserved: (D &amp; reserved_=
doorbell_mask) =3D=3D<br>
&gt; reserved_doorbell_val<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * KFD currently uses 1024 (=3D 0x=
3ff) doorbells per process. If<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * doorbells 0x0e0-0x0ff and 0x2e0=
-0x2ff are reserved, that <br>
&gt; &gt;means<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mask would be set to 0x1e0 and =
val set to 0x0e0.<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int sdma_doorb=
ell[2][8];<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbell_mask;<br=
>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbell_val;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* From SOC15 onwards, the doorbell=
 indexes reserved for SDMA, <br>
&gt; &gt; &#43;IH,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and VCN<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbells_sta=
rt;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbells_end=
;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Base address of door=
bell aperture. */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t doorbell_ph=
ysical_address;<br>
&gt;<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB236591C1FC2D9D965C4DA304F06D0SN1PR12MB2365namp_--

--===============0893864210==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0893864210==--
