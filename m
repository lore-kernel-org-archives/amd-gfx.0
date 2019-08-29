From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu: Default disable GDS for compute+gfx
Date: Thu, 29 Aug 2019 16:30:36 -0400
Message-ID: <CAAxE2A7tsiLYZ=vrvv8=+vyh0QcP3ZNPFvLxYy6inJxO_g+SaQ@mail.gmail.com>
References: <7002f783-2223-a524-2c60-03447377bd28@amd.com>
 <20190722153350.29339-1-Joseph.Greathouse@amd.com>
 <c4856ea0-3cd3-1628-54e9-9660be334054@gmail.com>
 <36885047-8915-fb90-fcaa-04f98b4519b1@amd.com>
 <CAAxE2A5MgKswdeHg1YrDs_G7hCuoZAVFuPyoHoA+DbUjA32eHg@mail.gmail.com>
 <bdb61ac5-e1ab-725c-56cf-475d7b41ebc2@amd.com>
 <293feae7-bda5-d8af-2dca-6f2025dc3fba@gmail.com>
 <148e2050-558c-eee6-bb74-3f7f9a341f98@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0542694853=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <148e2050-558c-eee6-bb74-3f7f9a341f98-5C7GfCeVMHo@public.gmane.org>
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
To: zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org>
Cc: "Greathouse, Joseph" <Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org>, "Qiao,
 Ken" <Ken.Qiao-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0542694853==
Content-Type: multipart/alternative; boundary="000000000000029976059147632b"

--000000000000029976059147632b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

If you decide to add it back, use this instead, it's simpler:
https://patchwork.freedesktop.org/patch/318391/?series=3D63775&rev=3D1

Maybe remove OA reservation if you don't need it.

Marek

On Thu, Aug 29, 2019 at 5:06 AM zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org> wrote:

>
> On 2019/8/29 =E4=B8=8B=E5=8D=883:22, Christian K=C3=B6nig wrote:
>
> Am 29.08.19 um 07:55 schrieb zhoucm1:
>
>
> On 2019/8/29 =E4=B8=8A=E5=8D=881:08, Marek Ol=C5=A1=C3=A1k wrote:
>
> It can't break an older driver, because there is no older driver that
> requires the static allocation.
>
> Note that closed source drivers don't count, because they don't need
> backward compatibility.
>
> Yes, I agree, we don't need take care of closed source stack.
>
> But AMDVLK is indeed an open source stack, many fans are using it, we nee=
d
> keep its compatibility, don't we?
>
>
> Actually that is still under discussion.
>
> But AMDVLK should have never ever used the static GDS space in the first
> place. We only added that for a transition time for old OpenGL and it
> shouldn't have leaked into the upstream driver.
>
> Not sure what's the best approach here. We could revert "[PATCH]
> drm/amdgpu: remove static GDS, GWS and OA", but that would break KFD. So =
we
> can only choose between two evils here.
>
> Only alternative I can see which would work for both would be to still
> allocate the static GDS, GWS and OA space, but make it somehow dynamic so
> that the KFD can swap it out again.
>
> Agree with you.
>
> -David
>
>
> Christian.
>
> -David
>
>
> Marek
>
> On Wed, Aug 28, 2019 at 2:44 AM zhoucm1 <zhoucm1-5C7GfCeVMHo@public.gmane.org> wrote:
>
>>
>> On 2019/7/23 =E4=B8=8A=E5=8D=883:08, Christian K=C3=B6nig wrote:
>> > Am 22.07.19 um 17:34 schrieb Greathouse, Joseph:
>> >> Units in the GDS block default to allowing all VMIDs access to all
>> >> entries. Disable shader access to the GDS, GWS, and OA blocks from al=
l
>> >> compute and gfx VMIDs by default. For compute, HWS firmware will set
>> >> up the access bits for the appropriate VMID when a compute queue
>> >> requires access to these blocks.
>> >> The driver will handle enabling access on-demand for graphics VMIDs.
>>
>> gds_switch is depending on job->gds/gws/oa/_base/size.
>>
>> "[PATCH] drm/amdgpu: remove static GDS, GWS and OA allocation", the
>> default allocations in kernel were removed. If some UMD stacks don't
>> pass gds/gws/oa allocation to bo_list, then kernel will not enable
>> access of them, that will break previous driver.
>>
>> do we need revert "[PATCH] drm/amdgpu: remove static GDS, GWS and OA
>> allocation" ?
>>
>> -David
>>
>> >>
>> >> Leaving VMID0 with full access because otherwise HWS cannot save or
>> >> restore values during task switch.
>> >>
>> >> v2: Fixed code and comment styling.
>> >>
>> >> Change-Id: I3d768a96935d2ed1dff09b02c995090f4fbfa539
>> >> Signed-off-by: Joseph Greathouse <Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org>
>> >
>> > Reviewed-by: Christian K=C3=B6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>> >
>> >> ---
>> >>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 25 ++++++++++++++++++-----=
--
>> >>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c  | 24 +++++++++++++++++------=
-
>> >>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c  | 24 +++++++++++++++++------=
-
>> >>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c  | 24 +++++++++++++++++------=
-
>> >>   4 files changed, 69 insertions(+), 28 deletions(-)
>> >>
>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> >> index 73dcb632a3ce..2a9692bc34b4 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>> >> @@ -1516,17 +1516,27 @@ static void
>> >> gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
>> >>       }
>> >>       nv_grbm_select(adev, 0, 0, 0, 0);
>> >>       mutex_unlock(&adev->srbm_mutex);
>> >> +}
>> >>   -    /* Initialize all compute VMIDs to have no GDS, GWS, or OA
>> >> -       acccess. These should be enabled by FW for target VMIDs. */
>> >> -    for (i =3D FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
>> >> -        WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>> >> -        WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>> >> -        WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>> >> -        WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>> >> +static void gfx_v10_0_init_gds_vmid(struct amdgpu_device *adev)
>> >> +{
>> >> +    int vmid;
>> >> +
>> >> +    /*
>> >> +     * Initialize all compute and user-gfx VMIDs to have no GDS,
>> >> GWS, or OA
>> >> +     * access. Compute VMIDs should be enabled by FW for target VMID=
s,
>> >> +     * the driver can enable them for graphics. VMID0 should maintai=
n
>> >> +     * access so that HWS firmware can save/restore entries.
>> >> +     */
>> >> +    for (vmid =3D 1; vmid < 16; vmid++) {
>> >> +        WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * vmid, 0);
>> >> +        WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * vmid, 0);
>> >> +        WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
>> >> +        WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, vmid, 0);
>> >>       }
>> >>   }
>> >>   +
>> >>   static void gfx_v10_0_tcp_harvest(struct amdgpu_device *adev)
>> >>   {
>> >>       int i, j, k;
>> >> @@ -1629,6 +1639,7 @@ static void gfx_v10_0_constants_init(struct
>> >> amdgpu_device *adev)
>> >>       mutex_unlock(&adev->srbm_mutex);
>> >>         gfx_v10_0_init_compute_vmid(adev);
>> >> +    gfx_v10_0_init_gds_vmid(adev);
>> >>     }
>> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> >> index 3f98624772a4..48796b6824cf 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> >> @@ -1877,14 +1877,23 @@ static void gfx_v7_0_init_compute_vmid(struct
>> >> amdgpu_device *adev)
>> >>       }
>> >>       cik_srbm_select(adev, 0, 0, 0, 0);
>> >>       mutex_unlock(&adev->srbm_mutex);
>> >> +}
>> >>   -    /* Initialize all compute VMIDs to have no GDS, GWS, or OA
>> >> -       acccess. These should be enabled by FW for target VMIDs. */
>> >> -    for (i =3D FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
>> >> -        WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>> >> -        WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>> >> -        WREG32(amdgpu_gds_reg_offset[i].gws, 0);
>> >> -        WREG32(amdgpu_gds_reg_offset[i].oa, 0);
>> >> +static void gfx_v7_0_init_gds_vmid(struct amdgpu_device *adev)
>> >> +{
>> >> +    int vmid;
>> >> +
>> >> +    /*
>> >> +     * Initialize all compute and user-gfx VMIDs to have no GDS,
>> >> GWS, or OA
>> >> +     * access. Compute VMIDs should be enabled by FW for target VMID=
s,
>> >> +     * the driver can enable them for graphics. VMID0 should maintai=
n
>> >> +     * access so that HWS firmware can save/restore entries.
>> >> +     */
>> >> +    for (vmid =3D 1; vmid < 16; vmid++) {
>> >> +        WREG32(amdgpu_gds_reg_offset[vmid].mem_base, 0);
>> >> +        WREG32(amdgpu_gds_reg_offset[vmid].mem_size, 0);
>> >> +        WREG32(amdgpu_gds_reg_offset[vmid].gws, 0);
>> >> +        WREG32(amdgpu_gds_reg_offset[vmid].oa, 0);
>> >>       }
>> >>   }
>> >>   @@ -1966,6 +1975,7 @@ static void gfx_v7_0_constants_init(struct
>> >> amdgpu_device *adev)
>> >>       mutex_unlock(&adev->srbm_mutex);
>> >>         gfx_v7_0_init_compute_vmid(adev);
>> >> +    gfx_v7_0_init_gds_vmid(adev);
>> >>         WREG32(mmSX_DEBUG_1, 0x20);
>> >>   diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> >> index e4028d54f8f7..d2907186bb24 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>> >> @@ -3702,14 +3702,23 @@ static void gfx_v8_0_init_compute_vmid(struct
>> >> amdgpu_device *adev)
>> >>       }
>> >>       vi_srbm_select(adev, 0, 0, 0, 0);
>> >>       mutex_unlock(&adev->srbm_mutex);
>> >> +}
>> >>   -    /* Initialize all compute VMIDs to have no GDS, GWS, or OA
>> >> -       acccess. These should be enabled by FW for target VMIDs. */
>> >> -    for (i =3D FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
>> >> -        WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
>> >> -        WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
>> >> -        WREG32(amdgpu_gds_reg_offset[i].gws, 0);
>> >> -        WREG32(amdgpu_gds_reg_offset[i].oa, 0);
>> >> +static void gfx_v8_0_init_gds_vmid(struct amdgpu_device *adev)
>> >> +{
>> >> +    int vmid;
>> >> +
>> >> +    /*
>> >> +     * Initialize all compute and user-gfx VMIDs to have no GDS,
>> >> GWS, or OA
>> >> +     * access. Compute VMIDs should be enabled by FW for target VMID=
s,
>> >> +     * the driver can enable them for graphics. VMID0 should maintai=
n
>> >> +     * access so that HWS firmware can save/restore entries.
>> >> +     */
>> >> +    for (vmid =3D 1; vmid < 16; vmid++) {
>> >> +        WREG32(amdgpu_gds_reg_offset[vmid].mem_base, 0);
>> >> +        WREG32(amdgpu_gds_reg_offset[vmid].mem_size, 0);
>> >> +        WREG32(amdgpu_gds_reg_offset[vmid].gws, 0);
>> >> +        WREG32(amdgpu_gds_reg_offset[vmid].oa, 0);
>> >>       }
>> >>   }
>> >>   @@ -3779,6 +3788,7 @@ static void gfx_v8_0_constants_init(struct
>> >> amdgpu_device *adev)
>> >>       mutex_unlock(&adev->srbm_mutex);
>> >>         gfx_v8_0_init_compute_vmid(adev);
>> >> +    gfx_v8_0_init_gds_vmid(adev);
>> >>         mutex_lock(&adev->grbm_idx_mutex);
>> >>       /*
>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> >> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> >> index 259a35395fec..bd7f431a24d9 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>> >> @@ -2025,14 +2025,23 @@ static void gfx_v9_0_init_compute_vmid(struct
>> >> amdgpu_device *adev)
>> >>       }
>> >>       soc15_grbm_select(adev, 0, 0, 0, 0);
>> >>       mutex_unlock(&adev->srbm_mutex);
>> >> +}
>> >>   -    /* Initialize all compute VMIDs to have no GDS, GWS, or OA
>> >> -       acccess. These should be enabled by FW for target VMIDs. */
>> >> -    for (i =3D FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
>> >> -        WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
>> >> -        WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
>> >> -        WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
>> >> -        WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, i, 0);
>> >> +static void gfx_v9_0_init_gds_vmid(struct amdgpu_device *adev)
>> >> +{
>> >> +    int vmid;
>> >> +
>> >> +    /*
>> >> +     * Initialize all compute and user-gfx VMIDs to have no GDS,
>> >> GWS, or OA
>> >> +     * access. Compute VMIDs should be enabled by FW for target VMID=
s,
>> >> +     * the driver can enable them for graphics. VMID0 should maintai=
n
>> >> +     * access so that HWS firmware can save/restore entries.
>> >> +     */
>> >> +    for (vmid =3D 1; vmid < 16; vmid++) {
>> >> +        WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * vmid, 0);
>> >> +        WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * vmid, 0);
>> >> +        WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, vmid, 0);
>> >> +        WREG32_SOC15_OFFSET(GC, 0, mmGDS_OA_VMID0, vmid, 0);
>> >>       }
>> >>   }
>> >>   @@ -2080,6 +2089,7 @@ static void gfx_v9_0_constants_init(struct
>> >> amdgpu_device *adev)
>> >>       mutex_unlock(&adev->srbm_mutex);
>> >>         gfx_v9_0_init_compute_vmid(adev);
>> >> +    gfx_v9_0_init_gds_vmid(adev);
>> >>   }
>> >>     static void gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device
>> *adev)
>> >
>> > _______________________________________________
>> > amd-gfx mailing list
>> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing listamd-gfx-PD4FTy7X32lNgt0PjOBp934avgP/u3fG0wdF1cv0I5s@public.gmane.org://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx
>
>
>

--000000000000029976059147632b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>If you decide to add it back, use this instead, it&#3=
9;s simpler:</div><div><a href=3D"https://patchwork.freedesktop.org/patch/3=
18391/?series=3D63775&amp;rev=3D1">https://patchwork.freedesktop.org/patch/=
318391/?series=3D63775&amp;rev=3D1</a></div><div><br></div><div>Maybe remov=
e OA reservation if you don&#39;t need it.<br></div><div><br></div><div>Mar=
ek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"=
gmail_attr">On Thu, Aug 29, 2019 at 5:06 AM zhoucm1 &lt;<a href=3D"mailto:z=
houcm1-5C7GfCeVMHo@public.gmane.org">zhoucm1-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div bgcolor=3D"#FFFFFF">
    <p><br>
    </p>
    <div class=3D"gmail-m_-8735832050278227855moz-cite-prefix">On 2019/8/29=
 =E4=B8=8B=E5=8D=883:22, Christian K=C3=B6nig
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div class=3D"gmail-m_-8735832050278227855moz-cite-prefix">Am 29.08.1=
9 um 07:55 schrieb zhoucm1:<br>
      </div>
      <blockquote type=3D"cite">
        <p><br>
        </p>
        <div class=3D"gmail-m_-8735832050278227855moz-cite-prefix">On 2019/=
8/29 =E4=B8=8A=E5=8D=881:08, Marek Ol=C5=A1=C3=A1k
          wrote:<br>
        </div>
        <blockquote type=3D"cite">
          <div dir=3D"ltr">
            <div>It can&#39;t break an older driver, because there is no
              older driver that requires the static allocation.</div>
            <div><br>
            </div>
            <div>Note that closed source drivers don&#39;t count, because
              they don&#39;t need backward compatibility.</div>
          </div>
        </blockquote>
        <p>Yes, I agree, we don&#39;t need take care of closed source stack=
.</p>
        <p>But AMDVLK is indeed an open source stack, many fans are
          using it, we need keep its compatibility, don&#39;t we?</p>
      </blockquote>
      <br>
      Actually that is still under discussion.<br>
      <br>
      But AMDVLK should have never ever used the static GDS space in the
      first place. We only added that for a transition time for old
      OpenGL and it shouldn&#39;t have leaked into the upstream driver.<br>
      <br>
      Not sure what&#39;s the best approach here. We could revert &quot;[PA=
TCH]
      drm/amdgpu: remove static GDS, GWS and OA&quot;, but that would break
      KFD. So we can only choose between two evils here.<br>
      <br>
      Only alternative I can see which would work for both would be to
      still allocate the static GDS, GWS and OA space, but make it
      somehow dynamic so that the KFD can swap it out again.<br>
    </blockquote>
    <p>Agree with you.</p>
    <p>-David<br>
    </p>
    <blockquote type=3D"cite"> <br>
      Christian.<br>
      <br>
      <blockquote type=3D"cite">
        <p>-David<br>
        </p>
        <blockquote type=3D"cite">
          <div dir=3D"ltr">
            <div><br>
            </div>
            <div>Marek<br>
            </div>
          </div>
          <br>
          <div class=3D"gmail_quote">
            <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 28, 2019 at
              2:44 AM zhoucm1 &lt;<a href=3D"mailto:zhoucm1-5C7GfCeVMHo@public.gmane.org" target=
=3D"_blank">zhoucm1-5C7GfCeVMHo@public.gmane.org</a>&gt; wrote:<br>
            </div>
            <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
              On 2019/7/23 =E4=B8=8A=E5=8D=883:08, Christian K=C3=B6nig wro=
te:<br>
              &gt; Am 22.07.19 um 17:34 schrieb Greathouse, Joseph:<br>
              &gt;&gt; Units in the GDS block default to allowing all
              VMIDs access to all<br>
              &gt;&gt; entries. Disable shader access to the GDS, GWS,
              and OA blocks from all<br>
              &gt;&gt; compute and gfx VMIDs by default. For compute,
              HWS firmware will set<br>
              &gt;&gt; up the access bits for the appropriate VMID when
              a compute queue<br>
              &gt;&gt; requires access to these blocks.<br>
              &gt;&gt; The driver will handle enabling access on-demand
              for graphics VMIDs.<br>
              <br>
              gds_switch is depending on job-&gt;gds/gws/oa/_base/size.<br>
              <br>
              &quot;[PATCH] drm/amdgpu: remove static GDS, GWS and OA
              allocation&quot;, the <br>
              default allocations in kernel were removed. If some UMD
              stacks don&#39;t <br>
              pass gds/gws/oa allocation to bo_list, then kernel will
              not enable <br>
              access of them, that will break previous driver.<br>
              <br>
              do we need revert &quot;[PATCH] drm/amdgpu: remove static GDS=
,
              GWS and OA <br>
              allocation&quot; ?<br>
              <br>
              -David<br>
              <br>
              &gt;&gt;<br>
              &gt;&gt; Leaving VMID0 with full access because otherwise
              HWS cannot save or<br>
              &gt;&gt; restore values during task switch.<br>
              &gt;&gt;<br>
              &gt;&gt; v2: Fixed code and comment styling.<br>
              &gt;&gt;<br>
              &gt;&gt; Change-Id:
              I3d768a96935d2ed1dff09b02c995090f4fbfa539<br>
              &gt;&gt; Signed-off-by: Joseph Greathouse &lt;<a href=3D"mail=
to:Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">Joseph.Greathouse-5C7GfCeVMHo@public.gmane.org</=
a>&gt;<br>
              &gt;<br>
              &gt; Reviewed-by: Christian K=C3=B6nig &lt;<a href=3D"mailto:=
christian.koenig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt=
;<br>
              &gt;<br>
              &gt;&gt; ---<br>
              &gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 25
              ++++++++++++++++++-------<br>
              &gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c=C2=A0 |=
 24
              +++++++++++++++++-------<br>
              &gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c=C2=A0 |=
 24
              +++++++++++++++++-------<br>
              &gt;&gt; =C2=A0 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c=C2=A0 |=
 24
              +++++++++++++++++-------<br>
              &gt;&gt; =C2=A0 4 files changed, 69 insertions(+), 28
              deletions(-)<br>
              &gt;&gt;<br>
              &gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c <br>
              &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt;&gt; index 73dcb632a3ce..2a9692bc34b4 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
              &gt;&gt; @@ -1516,17 +1516,27 @@ static void <br>
              &gt;&gt; gfx_v10_0_init_compute_vmid(struct amdgpu_device
              *adev)<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nv_grbm_select(adev, =
0, 0, 0, 0);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;ade=
v-&gt;srbm_mutex);<br>
              &gt;&gt; +}<br>
              &gt;&gt; =C2=A0 -=C2=A0=C2=A0=C2=A0 /* Initialize all compute=
 VMIDs to have no
              GDS, GWS, or OA<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acccess. These=
 should be enabled by FW
              for target VMIDs. */<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0 for (i =3D FIRST_COMPUTE_VMID; i=
 &lt;
              LAST_COMPUTE_VMID; i++) {<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_VMID0_BASE, 2 * i, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_VMID0_SIZE, 2 * i, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_GWS_VMID0, i, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_OA_VMID0, i, 0);<br>
              &gt;&gt; +static void gfx_v10_0_init_gds_vmid(struct
              amdgpu_device *adev)<br>
              &gt;&gt; +{<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 int vmid;<br>
              &gt;&gt; +<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 /*<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * Initialize all compute a=
nd user-gfx VMIDs
              to have no GDS, <br>
              &gt;&gt; GWS, or OA<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * access. Compute VMIDs sh=
ould be enabled
              by FW for target VMIDs,<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * the driver can enable th=
em for graphics.
              VMID0 should maintain<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * access so that HWS firmw=
are can
              save/restore entries.<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 for (vmid =3D 1; vmid &lt; 16; v=
mid++) {<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_VMID0_BASE, 2 * vmid, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_VMID0_SIZE, 2 * vmid, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_GWS_VMID0, vmid, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_OA_VMID0, vmid, 0);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
              &gt;&gt; =C2=A0 }<br>
              &gt;&gt; =C2=A0 +<br>
              &gt;&gt; =C2=A0 static void gfx_v10_0_tcp_harvest(struct
              amdgpu_device *adev)<br>
              &gt;&gt; =C2=A0 {<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, j, k;<br>
              &gt;&gt; @@ -1629,6 +1639,7 @@ static void
              gfx_v10_0_constants_init(struct <br>
              &gt;&gt; amdgpu_device *adev)<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;ade=
v-&gt;srbm_mutex);<br>
              &gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfx_v10_0_init=
_compute_vmid(adev);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 gfx_v10_0_init_gds_vmid(adev);<b=
r>
              &gt;&gt; =C2=A0 =C2=A0 }<br>
              &gt;&gt; =C2=A0 diff --git
              a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c <br>
              &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
              &gt;&gt; index 3f98624772a4..48796b6824cf 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
              &gt;&gt; @@ -1877,14 +1877,23 @@ static void
              gfx_v7_0_init_compute_vmid(struct <br>
              &gt;&gt; amdgpu_device *adev)<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cik_srbm_select(adev,=
 0, 0, 0, 0);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;ade=
v-&gt;srbm_mutex);<br>
              &gt;&gt; +}<br>
              &gt;&gt; =C2=A0 -=C2=A0=C2=A0=C2=A0 /* Initialize all compute=
 VMIDs to have no
              GDS, GWS, or OA<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acccess. These=
 should be enabled by FW
              for target VMIDs. */<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0 for (i =3D FIRST_COMPUTE_VMID; i=
 &lt;
              LAST_COMPUTE_VMID; i++) {<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
              WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
              WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(a=
mdgpu_gds_reg_offset[i].gws, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(a=
mdgpu_gds_reg_offset[i].oa, 0);<br>
              &gt;&gt; +static void gfx_v7_0_init_gds_vmid(struct
              amdgpu_device *adev)<br>
              &gt;&gt; +{<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 int vmid;<br>
              &gt;&gt; +<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 /*<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * Initialize all compute a=
nd user-gfx VMIDs
              to have no GDS, <br>
              &gt;&gt; GWS, or OA<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * access. Compute VMIDs sh=
ould be enabled
              by FW for target VMIDs,<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * the driver can enable th=
em for graphics.
              VMID0 should maintain<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * access so that HWS firmw=
are can
              save/restore entries.<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 for (vmid =3D 1; vmid &lt; 16; v=
mid++) {<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
              WREG32(amdgpu_gds_reg_offset[vmid].mem_base, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
              WREG32(amdgpu_gds_reg_offset[vmid].mem_size, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(a=
mdgpu_gds_reg_offset[vmid].gws,
              0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(a=
mdgpu_gds_reg_offset[vmid].oa,
              0);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
              &gt;&gt; =C2=A0 }<br>
              &gt;&gt; =C2=A0 @@ -1966,6 +1975,7 @@ static void
              gfx_v7_0_constants_init(struct <br>
              &gt;&gt; amdgpu_device *adev)<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;ade=
v-&gt;srbm_mutex);<br>
              &gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfx_v7_0_init_=
compute_vmid(adev);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 gfx_v7_0_init_gds_vmid(adev);<br=
>
              &gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(mmSX_DE=
BUG_1, 0x20);<br>
              &gt;&gt; =C2=A0 diff --git
              a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c <br>
              &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
              &gt;&gt; index e4028d54f8f7..d2907186bb24 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
              &gt;&gt; @@ -3702,14 +3702,23 @@ static void
              gfx_v8_0_init_compute_vmid(struct <br>
              &gt;&gt; amdgpu_device *adev)<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vi_srbm_select(adev, =
0, 0, 0, 0);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;ade=
v-&gt;srbm_mutex);<br>
              &gt;&gt; +}<br>
              &gt;&gt; =C2=A0 -=C2=A0=C2=A0=C2=A0 /* Initialize all compute=
 VMIDs to have no
              GDS, GWS, or OA<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acccess. These=
 should be enabled by FW
              for target VMIDs. */<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0 for (i =3D FIRST_COMPUTE_VMID; i=
 &lt;
              LAST_COMPUTE_VMID; i++) {<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
              WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
              WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(a=
mdgpu_gds_reg_offset[i].gws, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(a=
mdgpu_gds_reg_offset[i].oa, 0);<br>
              &gt;&gt; +static void gfx_v8_0_init_gds_vmid(struct
              amdgpu_device *adev)<br>
              &gt;&gt; +{<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 int vmid;<br>
              &gt;&gt; +<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 /*<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * Initialize all compute a=
nd user-gfx VMIDs
              to have no GDS, <br>
              &gt;&gt; GWS, or OA<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * access. Compute VMIDs sh=
ould be enabled
              by FW for target VMIDs,<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * the driver can enable th=
em for graphics.
              VMID0 should maintain<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * access so that HWS firmw=
are can
              save/restore entries.<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 for (vmid =3D 1; vmid &lt; 16; v=
mid++) {<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
              WREG32(amdgpu_gds_reg_offset[vmid].mem_base, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
              WREG32(amdgpu_gds_reg_offset[vmid].mem_size, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(a=
mdgpu_gds_reg_offset[vmid].gws,
              0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32(a=
mdgpu_gds_reg_offset[vmid].oa,
              0);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
              &gt;&gt; =C2=A0 }<br>
              &gt;&gt; =C2=A0 @@ -3779,6 +3788,7 @@ static void
              gfx_v8_0_constants_init(struct <br>
              &gt;&gt; amdgpu_device *adev)<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;ade=
v-&gt;srbm_mutex);<br>
              &gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfx_v8_0_init_=
compute_vmid(adev);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 gfx_v8_0_init_gds_vmid(adev);<br=
>
              &gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&am=
p;adev-&gt;grbm_idx_mutex);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*<br>
              &gt;&gt; diff --git
              a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
              &gt;&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
              &gt;&gt; index 259a35395fec..bd7f431a24d9 100644<br>
              &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
              &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
              &gt;&gt; @@ -2025,14 +2025,23 @@ static void
              gfx_v9_0_init_compute_vmid(struct <br>
              &gt;&gt; amdgpu_device *adev)<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soc15_grbm_select(ade=
v, 0, 0, 0, 0);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;ade=
v-&gt;srbm_mutex);<br>
              &gt;&gt; +}<br>
              &gt;&gt; =C2=A0 -=C2=A0=C2=A0=C2=A0 /* Initialize all compute=
 VMIDs to have no
              GDS, GWS, or OA<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acccess. These=
 should be enabled by FW
              for target VMIDs. */<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0 for (i =3D FIRST_COMPUTE_VMID; i=
 &lt;
              LAST_COMPUTE_VMID; i++) {<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_VMID0_BASE, 2 * i, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_VMID0_SIZE, 2 * i, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_GWS_VMID0, i, 0);<br>
              &gt;&gt; -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_OA_VMID0, i, 0);<br>
              &gt;&gt; +static void gfx_v9_0_init_gds_vmid(struct
              amdgpu_device *adev)<br>
              &gt;&gt; +{<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 int vmid;<br>
              &gt;&gt; +<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 /*<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * Initialize all compute a=
nd user-gfx VMIDs
              to have no GDS, <br>
              &gt;&gt; GWS, or OA<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * access. Compute VMIDs sh=
ould be enabled
              by FW for target VMIDs,<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * the driver can enable th=
em for graphics.
              VMID0 should maintain<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 * access so that HWS firmw=
are can
              save/restore entries.<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0 */<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 for (vmid =3D 1; vmid &lt; 16; v=
mid++) {<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_VMID0_BASE, 2 * vmid, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_VMID0_SIZE, 2 * vmid, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_GWS_VMID0, vmid, 0);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WREG32_S=
OC15_OFFSET(GC, 0,
              mmGDS_OA_VMID0, vmid, 0);<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }<br>
              &gt;&gt; =C2=A0 }<br>
              &gt;&gt; =C2=A0 @@ -2080,6 +2089,7 @@ static void
              gfx_v9_0_constants_init(struct <br>
              &gt;&gt; amdgpu_device *adev)<br>
              &gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_unlock(&amp;ade=
v-&gt;srbm_mutex);<br>
              &gt;&gt; =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gfx_v9_0_init_=
compute_vmid(adev);<br>
              &gt;&gt; +=C2=A0=C2=A0=C2=A0 gfx_v9_0_init_gds_vmid(adev);<br=
>
              &gt;&gt; =C2=A0 }<br>
              &gt;&gt; =C2=A0 =C2=A0 static void
              gfx_v9_0_wait_for_rlc_serdes(struct amdgpu_device *adev)<br>
              &gt;<br>
              &gt; _______________________________________________<br>
              &gt; amd-gfx mailing list<br>
              &gt; <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=
=3D"_blank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              &gt; <a href=3D"https://lists.freedesktop.org/mailman/listinf=
o/amd-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.o=
rg/mailman/listinfo/amd-gfx</a><br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_b=
lank">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd=
-gfx" rel=3D"noreferrer" target=3D"_blank">https://lists.freedesktop.org/ma=
ilman/listinfo/amd-gfx</a></blockquote>
          </div>
        </blockquote>
        <br>
        <fieldset class=3D"gmail-m_-8735832050278227855mimeAttachmentHeader=
"></fieldset>
        <pre class=3D"gmail-m_-8735832050278227855moz-quote-pre">__________=
_____________________________________
amd-gfx mailing list
<a class=3D"gmail-m_-8735832050278227855moz-txt-link-abbreviated" href=3D"m=
ailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx-PD4FTy7X32lMiVNPc3mojA@public.gmane.org=
sktop.org</a>
<a class=3D"gmail-m_-8735832050278227855moz-txt-link-freetext" href=3D"http=
s://lists.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank">https=
://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
      </blockquote>
      <br>
    </blockquote>
  </div>

</blockquote></div>

--000000000000029976059147632b--

--===============0542694853==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0542694853==--
