From: "Zeng, Oak" <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: RE: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queue
 doorbells mask on SOC15
Date: Sat, 2 Feb 2019 15:01:56 +0000
Message-ID: <DM5PR12MB25826F20FB8EF1E7E4B6348480930@DM5PR12MB2582.namprd12.prod.outlook.com>
References: <20190131222703.3591-1-Yong.Zhao@amd.com>
 <20190131222703.3591-2-Yong.Zhao@amd.com>,
 <e01f29c1-74e8-4dd6-81fc-b25c0432798f@amd.com>
 <BL0PR12MB250046784085018A70E34EC0F0920@BL0PR12MB2500.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0064705782=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BL0PR12MB250046784085018A70E34EC0F0920-b4cIHhjg/p89/wkoUb0eEAdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0064705782==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB25826F20FB8EF1E7E4B6348480930DM5PR12MB2582namp_"

--_000_DM5PR12MB25826F20FB8EF1E7E4B6348480930DM5PR12MB2582namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Yong,

mmCP_MEC_DOORBELL_RANGE_LOWER/UPPER are used at CP to double check a doorbe=
ll ringing routed to CP. It is a must to program. We have to keep userqueue=
_start/end. Sorry for the confusion.

Regards,
Oak

From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> On Behalf Of Zhao, Yo=
ng
Sent: Friday, February 1, 2019 7:04 PM
To: Kuehling, Felix <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
; Zeng, Oak <Oak.Zeng-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queue doorb=
ells mask on SOC15

Oak,

It is a good idea to remove the userqueue_start/end. However, when doing so=
, I came to the following code in gfx_v9_0_kiq_init_register() :

        /* enable the doorbell if requested */
        if (ring->use_doorbell) {
                WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_LOWER,
                                        (adev->doorbell_index.kiq * 2) << 2=
);
                WREG32_SOC15(GC, 0, mmCP_MEC_DOORBELL_RANGE_UPPER,
                                        (adev->doorbell_index.userqueue_end=
 * 2) << 2);
        }

I remember that you reached the conclusion in one email thread that mmCP_ME=
C_DOORBELL_RANGE_UPPER/LOWER did not have effect at all on gfx9. Have we go=
t any firm conclusions from HW engineer in the end? If those two registers =
are still valid, we should enforce the range for CP queues.

Regards,
Yong
________________________________
From: Kuehling, Felix
Sent: Friday, February 1, 2019 3:03 PM
To: Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org>
Subject: Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queue doorb=
ells mask on SOC15

On 2019-01-31 5:27 p.m., Zhao, Yong wrote:
> Reserved doorbells for SDMA IH and VCN were not properly masked out
> when allocating doorbells for CP user queues. This patch fixed that.
>
> Change-Id: I670adfc3fd7725d2ed0bd9665cb7f69f8b9023c2
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org<mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org>>

One mostly cosmetic comment inline. With that fixed, the series is
Reviewed-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org<mailto:Felix.Kuehling@a=
md.com>>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    | 17 ++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  |  4 +++
>   drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c  |  3 +++
>   drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c  |  3 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  9 +++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 25 +++++++++++++------
>   .../gpu/drm/amd/include/kgd_kfd_interface.h   | 19 +++++---------
>   7 files changed, 56 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index e957e42c539a..13710f34191a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -196,11 +196,20 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device=
 *adev)
>                        gpu_resources.sdma_doorbell[1][i+1] =3D
>                                adev->doorbell_index.sdma_engine[1] + 0x20=
0 + (i >> 1);
>                }
> -             /* Doorbells 0x0e0-0ff and 0x2e0-2ff are reserved for
> -              * SDMA, IH and VCN. So don't use them for the CP.
> +
> +             /* Because of the setting in registers like
> +              * SDMA0_DOORBELL_RANGE etc., BIF statically uses the
> +              * lower 12 bits of doorbell address for routing, in
> +              * order to route the CP queue doorbells to CP engine,
> +              * the doorbells allocated to CP queues have to be
> +              * outside the range set for SDMA, VCN, and IH blocks
> +              * Prior to SOC15, all queues use queue ID to
> +              * determine doorbells.
>                 */
> -             gpu_resources.reserved_doorbell_mask =3D 0x1e0;
> -             gpu_resources.reserved_doorbell_val  =3D 0x0e0;
> +             gpu_resources.reserved_doorbells_start =3D
> +                             adev->doorbell_index.sdma_engine[0];
> +             gpu_resources.reserved_doorbells_end =3D
> +                             adev->doorbell_index.last_non_cp;
>
>                kgd2kfd_device_init(adev->kfd.dev, &gpu_resources);
>        }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_doorbell.h
> index 1cfec06f81d4..4de431f7f380 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
> @@ -71,6 +71,7 @@ struct amdgpu_doorbell_index {
>                        uint32_t vce_ring6_7;
>                } uvd_vce;
>        };
> +     uint32_t last_non_cp;
>        uint32_t max_assignment;
>        /* Per engine SDMA doorbell size in dword */
>        uint32_t sdma_doorbell_range;
> @@ -143,6 +144,7 @@ typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMENT
>        AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3             =3D 0x18D,
>        AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5             =3D 0x18E,
>        AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7             =3D 0x18F,
> +     AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP             =3D AMDGPU_VEGA20_=
DOORBELL64_VCE_RING6_7,
>        AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT            =3D 0x18F,
>        AMDGPU_VEGA20_DOORBELL_INVALID                   =3D 0xFFFF
>   } AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;
> @@ -222,6 +224,8 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT
>        AMDGPU_DOORBELL64_VCE_RING4_5             =3D 0xFE,
>        AMDGPU_DOORBELL64_VCE_RING6_7             =3D 0xFF,
>
> +     AMDGPU_DOORBELL64_LAST_NON_CP             =3D AMDGPU_DOORBELL64_VCE=
_RING6_7,
> +
>        AMDGPU_DOORBELL64_MAX_ASSIGNMENT          =3D 0xFF,
>        AMDGPU_DOORBELL64_INVALID                 =3D 0xFFFF
>   } AMDGPU_DOORBELL64_ASSIGNMENT;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c b/drivers/gpu/d=
rm/amd/amdgpu/vega10_reg_init.c
> index 4b5d60ea3e78..fa0433199215 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c
> @@ -81,6 +81,9 @@ void vega10_doorbell_index_init(struct amdgpu_device *a=
dev)
>        adev->doorbell_index.uvd_vce.vce_ring2_3 =3D AMDGPU_DOORBELL64_VCE=
_RING2_3;
>        adev->doorbell_index.uvd_vce.vce_ring4_5 =3D AMDGPU_DOORBELL64_VCE=
_RING4_5;
>        adev->doorbell_index.uvd_vce.vce_ring6_7 =3D AMDGPU_DOORBELL64_VCE=
_RING6_7;
> +
> +     adev->doorbell_index.last_non_cp =3D AMDGPU_DOORBELL64_LAST_NON_CP;
> +
>        /* In unit of dword doorbell */
>        adev->doorbell_index.max_assignment =3D AMDGPU_DOORBELL64_MAX_ASSI=
GNMENT << 1;
>        adev->doorbell_index.sdma_doorbell_range =3D 4;
> diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c b/drivers/gpu/d=
rm/amd/amdgpu/vega20_reg_init.c
> index 53716c593b2b..b1052caaff5e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c
> @@ -85,6 +85,9 @@ void vega20_doorbell_index_init(struct amdgpu_device *a=
dev)
>        adev->doorbell_index.uvd_vce.vce_ring2_3 =3D AMDGPU_VEGA20_DOORBEL=
L64_VCE_RING2_3;
>        adev->doorbell_index.uvd_vce.vce_ring4_5 =3D AMDGPU_VEGA20_DOORBEL=
L64_VCE_RING4_5;
>        adev->doorbell_index.uvd_vce.vce_ring6_7 =3D AMDGPU_VEGA20_DOORBEL=
L64_VCE_RING6_7;
> +
> +     adev->doorbell_index.last_non_cp =3D AMDGPU_VEGA20_DOORBELL64_LAST_=
NON_CP;
> +
>        adev->doorbell_index.max_assignment =3D AMDGPU_VEGA20_DOORBELL_MAX=
_ASSIGNMENT << 1;
>        adev->doorbell_index.sdma_doorbell_range =3D 20;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/=
amdkfd/kfd_priv.h
> index e5ebcca7f031..6b8459f852cc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -103,6 +103,15 @@
>
>   #define KFD_KERNEL_QUEUE_SIZE 2048
>
> +/* 512 =3D 0x200
> + * On SOC15, the doorbell index distance for SDMA RLC i and (i + 1) in t=
he
> + * same SDMA engine, where i is a even number.
> + * For 8-bytes doorbells, it ensures that the mirror doorbell range (in =
terms
> + * of low 12 bit address for each HW engine) on the second doorbell page=
 is
> + * the same as the range of the first doorbell page.*/
> +#define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512
> +
> +
>   /*
>    * Kernel module parameter to specify maximum number of supported queue=
s per
>    * device
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_process.c
> index 80b36e860a0a..c7b67c65d62d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -607,13 +607,24 @@ static int init_doorbell_bitmap(struct qcm_process_=
device *qpd,
>        if (!qpd->doorbell_bitmap)
>                return -ENOMEM;
>
> -     /* Mask out any reserved doorbells */
> -     for (i =3D 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS; i++)
> -             if ((dev->shared_resources.reserved_doorbell_mask & i) =3D=
=3D
> -                 dev->shared_resources.reserved_doorbell_val) {
> -                     set_bit(i, qpd->doorbell_bitmap);
> -                     pr_debug("reserved doorbell 0x%03x\n", i);
> -             }
> +     /* Mask out all reserved doorbells for SDMA, IH, and VCN on SOC15.
> +      * Because of the setting in registers like SDMA0_DOORBELL_RANGE et=
c.,
> +      * BIF statically uses the lower 12 bits of doorbell address for
> +      * routing. In order to route the CP queue doorbells to CP engine,
> +      * the doorbells allocated to CP queues have to be outside the rang=
e
> +      * set for SDMA, VCN, and IH blocks.
> +      * Prior to SOC15, all queues use queue ID to
> +      * determine doorbells. */
> +     i =3D dev->shared_resources.reserved_doorbells_start;
> +     while (i <=3D dev->shared_resources.reserved_doorbells_end) {

This should be a for-loop to be more obvious:

         for (i =3D dev->shared_resources.reserved_doorbells_start;
              i <=3D dev->shared_resources.reserved_doorbells_end;
              i++) {
                 ...
         }


> +             set_bit(i, qpd->doorbell_bitmap);
> +             set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
> +                             qpd->doorbell_bitmap);
> +             pr_debug("reserved doorbell 0x%03x and 0x%03x\n", i,
> +                     i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET);
> +
> +             i++;
> +     }
>
>        return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gp=
u/drm/amd/include/kgd_kfd_interface.h
> index 83d960110d23..b1bf45419d93 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -137,20 +137,13 @@ struct kgd2kfd_shared_resources {
>        /* Bit n =3D=3D 1 means Queue n is available for KFD */
>        DECLARE_BITMAP(queue_bitmap, KGD_MAX_QUEUES);
>
> -     /* Doorbell assignments (SOC15 and later chips only). Only
> -      * specific doorbells are routed to each SDMA engine. Others
> -      * are routed to IH and VCN. They are not usable by the CP.
> -      *
> -      * Any doorbell number D that satisfies the following condition
> -      * is reserved: (D & reserved_doorbell_mask) =3D=3D reserved_doorbe=
ll_val
> -      *
> -      * KFD currently uses 1024 (=3D 0x3ff) doorbells per process. If
> -      * doorbells 0x0e0-0x0ff and 0x2e0-0x2ff are reserved, that means
> -      * mask would be set to 0x1e0 and val set to 0x0e0.
> -      */
>        unsigned int sdma_doorbell[2][8];
> -     unsigned int reserved_doorbell_mask;
> -     unsigned int reserved_doorbell_val;
> +
> +     /* From SOC15 onwards, the doorbell indexes reserved for SDMA, IH,
> +      * and VCN
> +      */
> +     unsigned int reserved_doorbells_start;
> +     unsigned int reserved_doorbells_end;
>
>        /* Base address of doorbell aperture. */
>        phys_addr_t doorbell_physical_address;

--_000_DM5PR12MB25826F20FB8EF1E7E4B6348480930DM5PR12MB2582namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
p.msonormal0, li.msonormal0, div.msonormal0
	{mso-style-name:msonormal;
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Yong,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">mmCP_ME=
C_DOORBELL_RANGE_LOWER</span>/UPPER are used at CP to double check a doorbe=
ll ringing routed to CP. It is a must to program. We have to keep userqueue=
_start/end. Sorry for the confusion.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Oak<o:p></o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32mMSPqsTGOZug@public.gmane.org=
esktop.org&gt;
<b>On Behalf Of </b>Zhao, Yong<br>
<b>Sent:</b> Friday, February 1, 2019 7:04 PM<br>
<b>To:</b> Kuehling, Felix &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32k@public.gmane.org=
eedesktop.org; Zeng, Oak &lt;Oak.Zeng-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queu=
e doorbells mask on SOC15<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Oak,<o:=
p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">It is a=
 good idea to remove the userqueue_start/end. However, when doing so, I cam=
e to the following code in gfx_v9_0_kiq_init_register() :<o:p></o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; /* enable the doorbell if requested */<o:p></o:p></spa=
n></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; if (ring-&gt;use_doorbell) {<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WREG32_SOC15(GC, 0, mmCP_M=
EC_DOORBELL_RANGE_LOWER,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (adev-&gt;doorbel=
l_index.kiq * 2) &lt;&lt; 2);<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; WREG32_SOC15(GC, 0, mmCP_M=
EC_DOORBELL_RANGE_UPPER,<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (adev-&gt;doorbel=
l_index.userqueue_end * 2) &lt;&lt; 2);<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp; =
&nbsp; &nbsp; &nbsp; }<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">I remem=
ber that you reached the conclusion in one email thread that&nbsp;<span sty=
le=3D"background:white">mmCP_MEC_DOORBELL_RANGE_UPPER/LOWER did not have ef=
fect at all on gfx9. Have we got any firm conclusions
 from HW engineer in the end? If those two registers are still valid, we sh=
ould enforce the range for CP queues.</span><o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black"><o:p>&n=
bsp;</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black;backgrou=
nd:white">Regards,</span><span style=3D"font-size:12.0pt;color:black"><o:p>=
</o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black;backgrou=
nd:white">Yong</span><span style=3D"font-size:12.0pt;color:black"><o:p></o:=
p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"3" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Kuehling, Felix<br>
<b>Sent:</b> Friday, February 1, 2019 3:03 PM<br>
<b>To:</b> Zhao, Yong; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd=
-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 2/3] drm/amdkfd: Fix bugs regarding CP user queu=
e doorbells mask on SOC15</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">On 2019-01-31 5:27 p.m., Zhao, Yong wrote:<br>
&gt; Reserved doorbells for SDMA IH and VCN were not properly masked out<br=
>
&gt; when allocating doorbells for CP user queues. This patch fixed that.<b=
r>
&gt;<br>
&gt; Change-Id: I670adfc3fd7725d2ed0bd9665cb7f69f8b9023c2<br>
&gt; Signed-off-by: Yong Zhao &lt;<a href=3D"mailto:Yong.Zhao-5C7GfCeVMHo@public.gmane.org">Yong=
.Zhao-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
One mostly cosmetic comment inline. With that fixed, the series is <br>
Reviewed-by: Felix Kuehling &lt;<a href=3D"mailto:Felix.Kuehling-5C7GfCeVMHo@public.gmane.org">F=
elix.Kuehling-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
<br>
<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c&nbsp;&nbsp;&nbs=
p; | 17 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h&nbsp; |&nbsp;=
 4 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c&nbsp; |&nbsp;=
 3 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c&nbsp; |&nbsp;=
 3 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;&#43;&#43;&#43;&#43;&#43;&#43;<b=
r>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; | 25 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;------<br>
&gt;&nbsp;&nbsp; .../gpu/drm/amd/include/kgd_kfd_interface.h&nbsp;&nbsp; | =
19 &#43;&#43;&#43;&#43;&#43;---------<br>
&gt;&nbsp;&nbsp; 7 files changed, 56 insertions(&#43;), 24 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; index e957e42c539a..13710f34191a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c<br>
&gt; @@ -196,11 &#43;196,20 @@ void amdgpu_amdkfd_device_init(struct amdgpu=
_device *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gpu_res=
ources.sdma_doorbell[1][i&#43;1] =3D<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma_engin=
e[1] &#43; 0x200 &#43; (i &gt;&gt; 1);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* Doorbells 0x0e0-0ff and 0x2e0-2ff are reserved for<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; * SDMA, IH and VCN. So don't use them for the CP.<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; /* Because of the setting in registers like<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * SDMA0_DOORBELL_RANGE etc., BIF statically uses the<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * lower 12 bits of doorbell address for routing, in<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * order to route the CP queue doorbells to CP engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * the doorbells allocated to CP queues have to be<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * outside the range set for SDMA, VCN, and IH blocks<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * Prior to SOC15, all queues use queue ID to<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; * determine doorbells.<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gpu_resources.reserved_doorbell_mask =3D 0x1e0;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; gpu_resources.reserved_doorbell_val&nbsp; =3D 0x0e0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; gpu_resources.reserved_doorbells_start =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma_engine[0];<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; gpu_resources.reserved_doorbells_end =3D<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_cp;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; kgd2kfd_device_init(adev-&gt;kfd.dev, &amp;gpu_resource=
s);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_doorbell.h<br>
&gt; index 1cfec06f81d4..4de431f7f380 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h<br>
&gt; @@ -71,6 &#43;71,7 @@ struct amdgpu_doorbell_index {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_=
t vce_ring6_7;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; } uvd_vce;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t last_non_cp;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t max_assignment;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Per engine SDMA doorbell =
size in dword */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t sdma_doorbell_range=
;<br>
&gt; @@ -143,6 &#43;144,7 @@ typedef enum _AMDGPU_VEGA20_DOORBELL_ASSIGNMEN=
T<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE=
_RING2_3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =3D 0x18D,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE=
_RING4_5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =3D 0x18E,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_VCE=
_RING6_7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; =3D 0x18F,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D AM=
DGPU_VEGA20_DOORBELL64_VCE_RING6_7,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_MAX_A=
SSIGNMENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 =3D 0x18F,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_VEGA20_DOORBELL_INVAL=
ID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFFFF<br>
&gt;&nbsp;&nbsp; } AMDGPU_VEGA20_DOORBELL_ASSIGNMENT;<br>
&gt; @@ -222,6 &#43;224,8 @@ typedef enum _AMDGPU_DOORBELL64_ASSIGNMENT<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING4_=
5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0xFE,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_VCE_RING6_=
7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
=3D 0xFF,<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_LAST_NON_CP&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D AMDGPU_DO=
ORBELL64_VCE_RING6_7,<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_MAX_ASSIGN=
MENT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 0xFF,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_DOORBELL64_INVALID&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; =3D 0xFFFF<br>
&gt;&nbsp;&nbsp; } AMDGPU_DOORBELL64_ASSIGNMENT;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c b/drivers/gp=
u/drm/amd/amdgpu/vega10_reg_init.c<br>
&gt; index 4b5d60ea3e78..fa0433199215 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_reg_init.c<br>
&gt; @@ -81,6 &#43;81,9 @@ void vega10_doorbell_index_init(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uvd_=
vce.vce_ring2_3 =3D AMDGPU_DOORBELL64_VCE_RING2_3;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uvd_=
vce.vce_ring4_5 =3D AMDGPU_DOORBELL64_VCE_RING4_5;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uvd_=
vce.vce_ring6_7 =3D AMDGPU_DOORBELL64_VCE_RING6_7;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_cp =3D =
AMDGPU_DOORBELL64_LAST_NON_CP;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* In unit of dword doorbell=
 */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.max_=
assignment =3D AMDGPU_DOORBELL64_MAX_ASSIGNMENT &lt;&lt; 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma=
_doorbell_range =3D 4;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c b/drivers/gp=
u/drm/amd/amdgpu/vega20_reg_init.c<br>
&gt; index 53716c593b2b..b1052caaff5e 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega20_reg_init.c<br>
&gt; @@ -85,6 &#43;85,9 @@ void vega20_doorbell_index_init(struct amdgpu_de=
vice *adev)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uvd_=
vce.vce_ring2_3 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING2_3;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uvd_=
vce.vce_ring4_5 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING4_5;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.uvd_=
vce.vce_ring6_7 =3D AMDGPU_VEGA20_DOORBELL64_VCE_RING6_7;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.last_non_cp =3D =
AMDGPU_VEGA20_DOORBELL64_LAST_NON_CP;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.max_=
assignment =3D AMDGPU_VEGA20_DOORBELL_MAX_ASSIGNMENT &lt;&lt; 1;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;doorbell_index.sdma=
_doorbell_range =3D 20;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/a=
md/amdkfd/kfd_priv.h<br>
&gt; index e5ebcca7f031..6b8459f852cc 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h<br>
&gt; @@ -103,6 &#43;103,15 @@<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define KFD_KERNEL_QUEUE_SIZE 2048<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;/* 512 =3D 0x200<br>
&gt; &#43; * On SOC15, the doorbell index distance for SDMA RLC i and (i &#=
43; 1) in the<br>
&gt; &#43; * same SDMA engine, where i is a even number.<br>
&gt; &#43; * For 8-bytes doorbells, it ensures that the mirror doorbell ran=
ge (in terms<br>
&gt; &#43; * of low 12 bit address for each HW engine) on the second doorbe=
ll page is<br>
&gt; &#43; * the same as the range of the first doorbell page.*/<br>
&gt; &#43;#define KFD_QUEUE_DOORBELL_MIRROR_OFFSET 512<br>
&gt; &#43;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp; * Kernel module parameter to specify maximum number =
of supported queues per<br>
&gt;&nbsp;&nbsp;&nbsp; * device<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/dr=
m/amd/amdkfd/kfd_process.c<br>
&gt; index 80b36e860a0a..c7b67c65d62d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_process.c<br>
&gt; @@ -607,13 &#43;607,24 @@ static int init_doorbell_bitmap(struct qcm_p=
rocess_device *qpd,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!qpd-&gt;doorbell_bitmap=
)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Mask out any reserved doorbells */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; KFD_MAX_NUM_OF_QUEUES_P=
ER_PROCESS; i&#43;&#43;)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if ((dev-&gt;shared_resources.reserved_doorbell_mask &amp; i) =3D=3D<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; dev-&gt;shared_resources.reserved_doorbell_val)=
 {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; set_bit(i, qpd-&gt;door=
bell_bitmap);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;reserved=
 doorbell 0x%03x\n&quot;, i);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* Mask out all reserved doorbells for S=
DMA, IH, and VCN on SOC15.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Because of the setting in regist=
ers like SDMA0_DOORBELL_RANGE etc.,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * BIF statically uses the lower 12=
 bits of doorbell address for<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * routing. In order to route the C=
P queue doorbells to CP engine,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the doorbells allocated to CP qu=
eues have to be outside the range<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * set for SDMA, VCN, and IH blocks=
.<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Prior to SOC15, all queues use q=
ueue ID to<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * determine doorbells. */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; i =3D dev-&gt;shared_resources.reserved_=
doorbells_start;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; while (i &lt;=3D dev-&gt;shared_resource=
s.reserved_doorbells_end) {<br>
<br>
This should be a for-loop to be more obvious:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D dev-&gt;shared_=
resources.reserved_doorbells_start;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; i &lt;=3D dev-&gt;shared_resources.reserved_doorbells_end;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; i&#43;&#43;) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; set_bit(i, qpd-&gt;doorbell_bitmap);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; set_bit(i &#43; KFD_QUEUE_DOORBELL_MIRROR_OFFSET,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; qpd-&gt;doorbell_bitmap);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pr_debug(&quot;reserved doorbell 0x%03x and 0x%03x\n&quot;, i,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i &#43; KFD_QUEUE_D=
OORBELL_MIRROR_OFFSET);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; i&#43;&#43;;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers=
/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; index 83d960110d23..b1bf45419d93 100644<br>
&gt; --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h<br>
&gt; @@ -137,20 &#43;137,13 @@ struct kgd2kfd_shared_resources {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Bit n =3D=3D 1 means Queu=
e n is available for KFD */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DECLARE_BITMAP(queue_bitmap,=
 KGD_MAX_QUEUES);<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; /* Doorbell assignments (SOC15 and later chi=
ps only). Only<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * specific doorbells are routed to eac=
h SDMA engine. Others<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * are routed to IH and VCN. They are n=
ot usable by the CP.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Any doorbell number D that satisfies=
 the following condition<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * is reserved: (D &amp; reserved_doorb=
ell_mask) =3D=3D reserved_doorbell_val<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * KFD currently uses 1024 (=3D 0x3ff) =
doorbells per process. If<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * doorbells 0x0e0-0x0ff and 0x2e0-0x2f=
f are reserved, that means<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * mask would be set to 0x1e0 and val s=
et to 0x0e0.<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int sdma_doorbell[2=
][8];<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbell_mask;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbell_val;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* From SOC15 onwards, the doorbell inde=
xes reserved for SDMA, IH,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * and VCN<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbells_start;<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int reserved_doorbells_end;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Base address of doorbell =
aperture. */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; phys_addr_t doorbell_physica=
l_address;<o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB25826F20FB8EF1E7E4B6348480930DM5PR12MB2582namp_--

--===============0064705782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0064705782==--
