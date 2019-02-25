From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Differentiate two set_pte_pde function
 pointers
Date: Mon, 25 Feb 2019 18:00:55 +0000
Message-ID: <SN1PR12MB23656AEF11DEB92F8AC858FEF07A0@SN1PR12MB2365.namprd12.prod.outlook.com>
References: <20190221225831.10193-1-Yong.Zhao@amd.com>,
 <61a1ea5e-0957-394a-be33-a7bca485e70c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0362089430=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <61a1ea5e-0957-394a-be33-a7bca485e70c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig,
 Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0362089430==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB23656AEF11DEB92F8AC858FEF07A0SN1PR12MB2365namp_"

--_000_SN1PR12MB23656AEF11DEB92F8AC858FEF07A0SN1PR12MB2365namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Agree. That's much better actually.

Yong
________________________________
From: Christian K?nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Monday, February 25, 2019 10:44 AM
To: Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH] drm/amdgpu: Differentiate two set_pte_pde function poi=
nters

Am 21.02.19 um 23:58 schrieb Zhao, Yong:
> There were two set_pte_pde function pointers in amdgpu_gmc_funcs and
> amdgpu_vm_pte_funcs respectively. Because they are so similar, sometimes
> it is confusing. So Rename the one in amdgpu_vm_pte_funcs to
> write_pte_pde.

NAK, we also already have a write_pte function. So this only increases
the confusion.

Instead we should rather just completely remove the gmc_*_set_pte_pde()
functions because they actually do exactly the same on all generations.

Christian.

>
> Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/si_dma.c    | 6 +++---
>   7 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 942b5ebc6dc2..fa86be694e48 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -806,7 +806,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *a=
dev,
>                if (level !=3D AMDGPU_VM_PTB)
>                        ats_value |=3D AMDGPU_PDE_PTE;
>
> -             amdgpu_vm_set_pte_pde(adev, &job->ibs[0], addr, 0,
> +             amdgpu_vm_write_pte_pde(adev, &job->ibs[0], addr, 0,
>                                      ats_entries, 0, ats_value);
>                addr +=3D ats_entries * 8;
>        }
> @@ -818,7 +818,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *a=
dev,
>                if (level =3D=3D AMDGPU_VM_PTB && adev->asic_type >=3D CHI=
P_VEGA10)
>                        value =3D AMDGPU_PTE_EXECUTABLE;
>
> -             amdgpu_vm_set_pte_pde(adev, &job->ibs[0], addr, 0,
> +             amdgpu_vm_write_pte_pde(adev, &job->ibs[0], addr, 0,
>                                      entries, 0, value);
>        }
>
> @@ -1235,7 +1235,7 @@ static void amdgpu_vm_do_set_ptes(struct amdgpu_pte=
_update_params *params,
>                                    addr | flags, count, incr);
>
>        } else {
> -             amdgpu_vm_set_pte_pde(params->adev, params->ib, pe, addr,
> +             amdgpu_vm_write_pte_pde(params->adev, params->ib, pe, addr,
>                                      count, incr, flags);
>        }
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.h
> index 81ff8177f092..7e345ec2671f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -161,7 +161,7 @@ struct amdgpu_vm_pte_funcs {
>                          uint64_t value, unsigned count,
>                          uint32_t incr);
>        /* for linear pte/pde updates without addr mapping */
> -     void (*set_pte_pde)(struct amdgpu_ib *ib,
> +     void (*write_pte_pde)(struct amdgpu_ib *ib,
>                            uint64_t pe,
>                            uint64_t addr, unsigned count,
>                            uint32_t incr, uint64_t flags);
> @@ -287,7 +287,7 @@ struct amdgpu_vm_manager {
>
>   #define amdgpu_vm_copy_pte(adev, ib, pe, src, count) ((adev)->vm_manage=
r.vm_pte_funcs->copy_pte((ib), (pe), (src), (count)))
>   #define amdgpu_vm_write_pte(adev, ib, pe, value, count, incr) ((adev)->=
vm_manager.vm_pte_funcs->write_pte((ib), (pe), (value), (count), (incr)))
> -#define amdgpu_vm_set_pte_pde(adev, ib, pe, addr, count, incr, flags) ((=
adev)->vm_manager.vm_pte_funcs->set_pte_pde((ib), (pe), (addr), (count), (i=
ncr), (flags)))
> +#define amdgpu_vm_write_pte_pde(adev, ib, pe, addr, count, incr, flags) =
((adev)->vm_manager.vm_pte_funcs->write_pte_pde((ib), (pe), (addr), (count)=
, (incr), (flags)))
>
>   void amdgpu_vm_manager_init(struct amdgpu_device *adev);
>   void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/=
amdgpu/cik_sdma.c
> index 189599b694e8..07b874a44ddf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
> @@ -769,7 +769,7 @@ static void cik_sdma_vm_write_pte(struct amdgpu_ib *i=
b, uint64_t pe,
>   }
>
>   /**
> - * cik_sdma_vm_set_pages - update the page tables using sDMA
> + * cik_sdma_vm_write_pte_pde - update the page tables using sDMA
>    *
>    * @ib: indirect buffer to fill with commands
>    * @pe: addr of the page entry
> @@ -780,7 +780,7 @@ static void cik_sdma_vm_write_pte(struct amdgpu_ib *i=
b, uint64_t pe,
>    *
>    * Update the page tables using sDMA (CIK).
>    */
> -static void cik_sdma_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
> +static void cik_sdma_vm_write_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
>                                    uint64_t addr, unsigned count,
>                                    uint32_t incr, uint64_t flags)
>   {
> @@ -1365,7 +1365,7 @@ static const struct amdgpu_vm_pte_funcs cik_sdma_vm=
_pte_funcs =3D {
>        .copy_pte =3D cik_sdma_vm_copy_pte,
>
>        .write_pte =3D cik_sdma_vm_write_pte,
> -     .set_pte_pde =3D cik_sdma_vm_set_pte_pde,
> +     .write_pte_pde =3D cik_sdma_vm_write_pte_pde,
>   };
>
>   static void cik_sdma_set_vm_pte_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v2_4.c
> index cca3552b36ed..3161871c1a57 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
> @@ -707,7 +707,7 @@ static void sdma_v2_4_vm_write_pte(struct amdgpu_ib *=
ib, uint64_t pe,
>   }
>
>   /**
> - * sdma_v2_4_vm_set_pte_pde - update the page tables using sDMA
> + * sdma_v2_4_vm_write_pte_pde - update the page tables using sDMA
>    *
>    * @ib: indirect buffer to fill with commands
>    * @pe: addr of the page entry
> @@ -718,7 +718,7 @@ static void sdma_v2_4_vm_write_pte(struct amdgpu_ib *=
ib, uint64_t pe,
>    *
>    * Update the page tables using sDMA (CIK).
>    */
> -static void sdma_v2_4_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
> +static void sdma_v2_4_vm_write_pte_pde(struct amdgpu_ib *ib, uint64_t pe=
,
>                                     uint64_t addr, unsigned count,
>                                     uint32_t incr, uint64_t flags)
>   {
> @@ -1252,7 +1252,7 @@ static const struct amdgpu_vm_pte_funcs sdma_v2_4_v=
m_pte_funcs =3D {
>        .copy_pte =3D sdma_v2_4_vm_copy_pte,
>
>        .write_pte =3D sdma_v2_4_vm_write_pte,
> -     .set_pte_pde =3D sdma_v2_4_vm_set_pte_pde,
> +     .write_pte_pde =3D sdma_v2_4_vm_write_pte_pde,
>   };
>
>   static void sdma_v2_4_set_vm_pte_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v3_0.c
> index 0ce8331baeb2..e369013a6bce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
> @@ -978,7 +978,7 @@ static void sdma_v3_0_vm_write_pte(struct amdgpu_ib *=
ib, uint64_t pe,
>   }
>
>   /**
> - * sdma_v3_0_vm_set_pte_pde - update the page tables using sDMA
> + * sdma_v3_0_vm_write_pte_pde - update the page tables using sDMA
>    *
>    * @ib: indirect buffer to fill with commands
>    * @pe: addr of the page entry
> @@ -989,7 +989,7 @@ static void sdma_v3_0_vm_write_pte(struct amdgpu_ib *=
ib, uint64_t pe,
>    *
>    * Update the page tables using sDMA (CIK).
>    */
> -static void sdma_v3_0_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe,
> +static void sdma_v3_0_vm_write_pte_pde(struct amdgpu_ib *ib, uint64_t pe=
,
>                                     uint64_t addr, unsigned count,
>                                     uint32_t incr, uint64_t flags)
>   {
> @@ -1690,7 +1690,7 @@ static const struct amdgpu_vm_pte_funcs sdma_v3_0_v=
m_pte_funcs =3D {
>        .copy_pte =3D sdma_v3_0_vm_copy_pte,
>
>        .write_pte =3D sdma_v3_0_vm_write_pte,
> -     .set_pte_pde =3D sdma_v3_0_vm_set_pte_pde,
> +     .write_pte_pde =3D sdma_v3_0_vm_write_pte_pde,
>   };
>
>   static void sdma_v3_0_set_vm_pte_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v4_0.c
> index c816e55d43a9..e5e9eac1758d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -1343,7 +1343,7 @@ static void sdma_v4_0_vm_write_pte(struct amdgpu_ib=
 *ib, uint64_t pe,
>   }
>
>   /**
> - * sdma_v4_0_vm_set_pte_pde - update the page tables using sDMA
> + * sdma_v4_0_vm_write_pte_pde - update the page tables using sDMA
>    *
>    * @ib: indirect buffer to fill with commands
>    * @pe: addr of the page entry
> @@ -1354,7 +1354,7 @@ static void sdma_v4_0_vm_write_pte(struct amdgpu_ib=
 *ib, uint64_t pe,
>    *
>    * Update the page tables using sDMA (VEGA10).
>    */
> -static void sdma_v4_0_vm_set_pte_pde(struct amdgpu_ib *ib,
> +static void sdma_v4_0_vm_write_pte_pde(struct amdgpu_ib *ib,
>                                     uint64_t pe,
>                                     uint64_t addr, unsigned count,
>                                     uint32_t incr, uint64_t flags)
> @@ -2088,7 +2088,7 @@ static const struct amdgpu_vm_pte_funcs sdma_v4_0_v=
m_pte_funcs =3D {
>        .copy_pte =3D sdma_v4_0_vm_copy_pte,
>
>        .write_pte =3D sdma_v4_0_vm_write_pte,
> -     .set_pte_pde =3D sdma_v4_0_vm_set_pte_pde,
> +     .write_pte_pde =3D sdma_v4_0_vm_write_pte_pde,
>   };
>
>   static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/am=
dgpu/si_dma.c
> index f15f196684ba..4c1e1ce895f7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
> @@ -353,7 +353,7 @@ static void si_dma_vm_write_pte(struct amdgpu_ib *ib,=
 uint64_t pe,
>   }
>
>   /**
> - * si_dma_vm_set_pte_pde - update the page tables using sDMA
> + * si_dma_vm_write_pte_pde - update the page tables using sDMA
>    *
>    * @ib: indirect buffer to fill with commands
>    * @pe: addr of the page entry
> @@ -364,7 +364,7 @@ static void si_dma_vm_write_pte(struct amdgpu_ib *ib,=
 uint64_t pe,
>    *
>    * Update the page tables using sDMA (CIK).
>    */
> -static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,
> +static void si_dma_vm_write_pte_pde(struct amdgpu_ib *ib,
>                                     uint64_t pe,
>                                     uint64_t addr, unsigned count,
>                                     uint32_t incr, uint64_t flags)
> @@ -829,7 +829,7 @@ static const struct amdgpu_vm_pte_funcs si_dma_vm_pte=
_funcs =3D {
>        .copy_pte =3D si_dma_vm_copy_pte,
>
>        .write_pte =3D si_dma_vm_write_pte,
> -     .set_pte_pde =3D si_dma_vm_set_pte_pde,
> +     .write_pte_pde =3D si_dma_vm_write_pte_pde,
>   };
>
>   static void si_dma_set_vm_pte_funcs(struct amdgpu_device *adev)


--_000_SN1PR12MB23656AEF11DEB92F8AC858FEF07A0SN1PR12MB2365namp_
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
Agree. That's much better actually.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Yong</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K&ouml;nig =
&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, February 25, 2019 10:44 AM<br>
<b>To:</b> Zhao, Yong; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Differentiate two set_pte_pde funct=
ion pointers</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Am 21.02.19 um 23:58 schrieb Zhao, Yong:<br>
&gt; There were two set_pte_pde function pointers in amdgpu_gmc_funcs and<b=
r>
&gt; amdgpu_vm_pte_funcs respectively. Because they are so similar, sometim=
es<br>
&gt; it is confusing. So Rename the one in amdgpu_vm_pte_funcs to<br>
&gt; write_pte_pde.<br>
<br>
NAK, we also already have a write_pte function. So this only increases <br>
the confusion.<br>
<br>
Instead we should rather just completely remove the gmc_*_set_pte_pde() <br=
>
functions because they actually do exactly the same on all generations.<br>
<br>
Christian.<br>
<br>
&gt;<br>
&gt; Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 &#43;&#43;&#43;=
---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 4 &#43;&#43;--<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/cik_sdma.c&nbsp; | 6 &#43;&#43;=
&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 6 &#43;&#43;&#43;=
---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 6 &#43;&#43;&#43;=
---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 6 &#43;&#43;&#43;=
---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/si_dma.c&nbsp;&nbsp;&nbsp; | 6 =
&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; 7 files changed, 20 insertions(&#43;), 20 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 942b5ebc6dc2..fa86be694e48 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -806,7 &#43;806,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (level !=3D AMDGPU_VM_PTB)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ats_val=
ue |=3D AMDGPU_PDE_PTE;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_vm_set_pte_pde(adev, &amp;job-&gt;ibs[0], addr, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_vm_write_pte_pde(adev, &amp;job-&gt;ibs[0], addr, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; ats_entries, 0, ats_value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; addr &#43;=3D ats_entries * 8;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -818,7 &#43;818,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_de=
vice *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (level =3D=3D AMDGPU_VM_PTB &amp;&amp; adev-&gt;asic=
_type &gt;=3D CHIP_VEGA10)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; value =
=3D AMDGPU_PTE_EXECUTABLE;<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_vm_set_pte_pde(adev, &amp;job-&gt;ibs[0], addr, 0,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_vm_write_pte_pde(adev, &amp;job-&gt;ibs[0], addr, 0,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; entries, 0, value);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; @@ -1235,7 &#43;1235,7 @@ static void amdgpu_vm_do_set_ptes(struct amd=
gpu_pte_update_params *params,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; addr | fla=
gs, count, incr);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; amdgpu_vm_set_pte_pde(params-&gt;adev, params-&gt;ib, pe, addr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_vm_write_pte_pde(params-&gt;adev, params-&gt;ib, pe, addr,<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; count, incr, flags);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.h<br>
&gt; index 81ff8177f092..7e345ec2671f 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h<br>
&gt; @@ -161,7 &#43;161,7 @@ struct amdgpu_vm_pte_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint64_t value, unsigned count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; uint32_t incr);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* for linear pte/pde update=
s without addr mapping */<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; void (*set_pte_pde)(struct amdgpu_ib *ib,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void (*write_pte_pde)(struct amdgpu_ib *=
ib,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint64_t addr, unsigned count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; uint32_t incr, uint64_t flags);<br>
&gt; @@ -287,7 &#43;287,7 @@ struct amdgpu_vm_manager {<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; #define amdgpu_vm_copy_pte(adev, ib, pe, src, count) ((ade=
v)-&gt;vm_manager.vm_pte_funcs-&gt;copy_pte((ib), (pe), (src), (count)))<br=
>
&gt;&nbsp;&nbsp; #define amdgpu_vm_write_pte(adev, ib, pe, value, count, in=
cr) ((adev)-&gt;vm_manager.vm_pte_funcs-&gt;write_pte((ib), (pe), (value), =
(count), (incr)))<br>
&gt; -#define amdgpu_vm_set_pte_pde(adev, ib, pe, addr, count, incr, flags)=
 ((adev)-&gt;vm_manager.vm_pte_funcs-&gt;set_pte_pde((ib), (pe), (addr), (c=
ount), (incr), (flags)))<br>
&gt; &#43;#define amdgpu_vm_write_pte_pde(adev, ib, pe, addr, count, incr, =
flags) ((adev)-&gt;vm_manager.vm_pte_funcs-&gt;write_pte_pde((ib), (pe), (a=
ddr), (count), (incr), (flags)))<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; void amdgpu_vm_manager_init(struct amdgpu_device *adev);<b=
r>
&gt;&nbsp;&nbsp; void amdgpu_vm_manager_fini(struct amdgpu_device *adev);<b=
r>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/cik_sdma.c<br>
&gt; index 189599b694e8..07b874a44ddf 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c<br>
&gt; @@ -769,7 &#43;769,7 @@ static void cik_sdma_vm_write_pte(struct amdgp=
u_ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * cik_sdma_vm_set_pages - update the page tables using sDMA<br>
&gt; &#43; * cik_sdma_vm_write_pte_pde - update the page tables using sDMA<=
br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @ib: indirect buffer to fill with commands<br>
&gt;&nbsp;&nbsp;&nbsp; * @pe: addr of the page entry<br>
&gt; @@ -780,7 &#43;780,7 @@ static void cik_sdma_vm_write_pte(struct amdgp=
u_ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * Update the page tables using sDMA (CIK).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -static void cik_sdma_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t pe=
,<br>
&gt; &#43;static void cik_sdma_vm_write_pte_pde(struct amdgpu_ib *ib, uint6=
4_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t a=
ddr, unsigned count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t i=
ncr, uint64_t flags)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -1365,7 &#43;1365,7 @@ static const struct amdgpu_vm_pte_funcs cik_=
sdma_vm_pte_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .copy_pte =3D cik_sdma_vm_co=
py_pte,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte =3D cik_sdma_vm_w=
rite_pte,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .set_pte_pde =3D cik_sdma_vm_set_pte_pde,<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte_pde =3D cik_sdma_vm_write_pte=
_pde,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void cik_sdma_set_vm_pte_funcs(struct amdgpu_device=
 *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v2_4.c<br>
&gt; index cca3552b36ed..3161871c1a57 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c<br>
&gt; @@ -707,7 &#43;707,7 @@ static void sdma_v2_4_vm_write_pte(struct amdg=
pu_ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * sdma_v2_4_vm_set_pte_pde - update the page tables using sDMA<br>
&gt; &#43; * sdma_v2_4_vm_write_pte_pde - update the page tables using sDMA=
<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @ib: indirect buffer to fill with commands<br>
&gt;&nbsp;&nbsp;&nbsp; * @pe: addr of the page entry<br>
&gt; @@ -718,7 &#43;718,7 @@ static void sdma_v2_4_vm_write_pte(struct amdg=
pu_ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * Update the page tables using sDMA (CIK).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -static void sdma_v2_4_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t p=
e,<br>
&gt; &#43;static void sdma_v2_4_vm_write_pte_pde(struct amdgpu_ib *ib, uint=
64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t addr, unsigned count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t incr, uint64_t flags)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -1252,7 &#43;1252,7 @@ static const struct amdgpu_vm_pte_funcs sdma=
_v2_4_vm_pte_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .copy_pte =3D sdma_v2_4_vm_c=
opy_pte,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte =3D sdma_v2_4_vm_=
write_pte,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .set_pte_pde =3D sdma_v2_4_vm_set_pte_pde,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte_pde =3D sdma_v2_4_vm_write_pt=
e_pde,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void sdma_v2_4_set_vm_pte_funcs(struct amdgpu_devic=
e *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v3_0.c<br>
&gt; index 0ce8331baeb2..e369013a6bce 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c<br>
&gt; @@ -978,7 &#43;978,7 @@ static void sdma_v3_0_vm_write_pte(struct amdg=
pu_ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * sdma_v3_0_vm_set_pte_pde - update the page tables using sDMA<br>
&gt; &#43; * sdma_v3_0_vm_write_pte_pde - update the page tables using sDMA=
<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @ib: indirect buffer to fill with commands<br>
&gt;&nbsp;&nbsp;&nbsp; * @pe: addr of the page entry<br>
&gt; @@ -989,7 &#43;989,7 @@ static void sdma_v3_0_vm_write_pte(struct amdg=
pu_ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * Update the page tables using sDMA (CIK).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -static void sdma_v3_0_vm_set_pte_pde(struct amdgpu_ib *ib, uint64_t p=
e,<br>
&gt; &#43;static void sdma_v3_0_vm_write_pte_pde(struct amdgpu_ib *ib, uint=
64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t addr, unsigned count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t incr, uint64_t flags)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; @@ -1690,7 &#43;1690,7 @@ static const struct amdgpu_vm_pte_funcs sdma=
_v3_0_vm_pte_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .copy_pte =3D sdma_v3_0_vm_c=
opy_pte,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte =3D sdma_v3_0_vm_=
write_pte,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .set_pte_pde =3D sdma_v3_0_vm_set_pte_pde,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte_pde =3D sdma_v3_0_vm_write_pt=
e_pde,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void sdma_v3_0_set_vm_pte_funcs(struct amdgpu_devic=
e *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/=
amd/amdgpu/sdma_v4_0.c<br>
&gt; index c816e55d43a9..e5e9eac1758d 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&gt; @@ -1343,7 &#43;1343,7 @@ static void sdma_v4_0_vm_write_pte(struct am=
dgpu_ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * sdma_v4_0_vm_set_pte_pde - update the page tables using sDMA<br>
&gt; &#43; * sdma_v4_0_vm_write_pte_pde - update the page tables using sDMA=
<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @ib: indirect buffer to fill with commands<br>
&gt;&nbsp;&nbsp;&nbsp; * @pe: addr of the page entry<br>
&gt; @@ -1354,7 &#43;1354,7 @@ static void sdma_v4_0_vm_write_pte(struct am=
dgpu_ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * Update the page tables using sDMA (VEGA10).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -static void sdma_v4_0_vm_set_pte_pde(struct amdgpu_ib *ib,<br>
&gt; &#43;static void sdma_v4_0_vm_write_pte_pde(struct amdgpu_ib *ib,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t addr, unsigned count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t incr, uint64_t flags)<br>
&gt; @@ -2088,7 &#43;2088,7 @@ static const struct amdgpu_vm_pte_funcs sdma=
_v4_0_vm_pte_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .copy_pte =3D sdma_v4_0_vm_c=
opy_pte,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte =3D sdma_v4_0_vm_=
write_pte,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .set_pte_pde =3D sdma_v4_0_vm_set_pte_pde,<b=
r>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte_pde =3D sdma_v4_0_vm_write_pt=
e_pde,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void sdma_v4_0_set_vm_pte_funcs(struct amdgpu_devic=
e *adev)<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd=
/amdgpu/si_dma.c<br>
&gt; index f15f196684ba..4c1e1ce895f7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/si_dma.c<br>
&gt; @@ -353,7 &#43;353,7 @@ static void si_dma_vm_write_pte(struct amdgpu_=
ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * si_dma_vm_set_pte_pde - update the page tables using sDMA<br>
&gt; &#43; * si_dma_vm_write_pte_pde - update the page tables using sDMA<br=
>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @ib: indirect buffer to fill with commands<br>
&gt;&nbsp;&nbsp;&nbsp; * @pe: addr of the page entry<br>
&gt; @@ -364,7 &#43;364,7 @@ static void si_dma_vm_write_pte(struct amdgpu_=
ib *ib, uint64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * Update the page tables using sDMA (CIK).<br>
&gt;&nbsp;&nbsp;&nbsp; */<br>
&gt; -static void si_dma_vm_set_pte_pde(struct amdgpu_ib *ib,<br>
&gt; &#43;static void si_dma_vm_write_pte_pde(struct amdgpu_ib *ib,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t pe,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
64_t addr, unsigned count,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint=
32_t incr, uint64_t flags)<br>
&gt; @@ -829,7 &#43;829,7 @@ static const struct amdgpu_vm_pte_funcs si_dma=
_vm_pte_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .copy_pte =3D si_dma_vm_copy=
_pte,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte =3D si_dma_vm_wri=
te_pte,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .set_pte_pde =3D si_dma_vm_set_pte_pde,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .write_pte_pde =3D si_dma_vm_write_pte_p=
de,<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void si_dma_set_vm_pte_funcs(struct amdgpu_device *=
adev)<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SN1PR12MB23656AEF11DEB92F8AC858FEF07A0SN1PR12MB2365namp_--

--===============0362089430==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0362089430==--
