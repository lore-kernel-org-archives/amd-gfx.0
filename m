From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: refine vce3.0 initialize.
Date: Mon, 9 Jan 2017 14:16:35 +0000
Message-ID: <CY4PR12MB1768D1BC1BBC50A8228B5C5EF7640@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1483968878-1370-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0533652261=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1483968878-1370-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0533652261==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768D1BC1BBC50A8228B5C5EF7640CY4PR12MB1768namp_"

--_000_CY4PR12MB1768D1BC1BBC50A8228B5C5EF7640CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On my Carrizo, I have to NAK since monitoring the clocks I see GFX and VCE =
pegged high on a setup with a staging kernel .


Doing a test signal encode I see 1000 fences/sec being handled and GFX_POWE=
R throttles (not idle or full) .  I don't see VCE load from SRBM_STATUS2 th=
ough ...


Something is up for sure.


I haven't tried HEAD~ (I last tried a 4.9 kernel about 15 commits ago) so I=
'll try that now.


Tom



________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, January 9, 2017 08:34
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, Rex
Subject: [PATCH] drm/amdgpu: refine vce3.0 initialize.

1. disable vce cg when vce hw initialize.
2. initizlize vce clock to 10KHz.
3: no need to set bypass clock to vce.

Change-Id: I18d5c2debc6688be201af8bb85022ac25020bd8f
Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 +++---------------
 drivers/gpu/drm/amd/amdgpu/vi.c       | 32 +++++++++++++++++++++++++++++++=
-
 2 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c
index 5fb0b7f..eb99ee6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -223,6 +223,9 @@ static int vce_v3_0_start(struct amdgpu_device *adev)
         struct amdgpu_ring *ring;
         int idx, r;

+       vce_v3_0_override_vce_clock_gating(adev, true); /* force all clocks=
 on */
+       amdgpu_asic_set_vce_clocks(adev, 10000, 10000);
+
         ring =3D &adev->vce.ring[0];
         WREG32(mmVCE_RB_RPTR, ring->wptr);
         WREG32(mmVCE_RB_WPTR, ring->wptr);
@@ -701,17 +704,7 @@ static int vce_v3_0_process_interrupt(struct amdgpu_de=
vice *adev,
         return 0;
 }

-static void vce_v3_0_set_bypass_mode(struct amdgpu_device *adev, bool enab=
le)
-{
-       u32 tmp =3D RREG32_SMC(ixGCK_DFS_BYPASS_CNTL);
-
-       if (enable)
-               tmp |=3D GCK_DFS_BYPASS_CNTL__BYPASSECLK_MASK;
-       else
-               tmp &=3D ~GCK_DFS_BYPASS_CNTL__BYPASSECLK_MASK;

-       WREG32_SMC(ixGCK_DFS_BYPASS_CNTL, tmp);
-}

 static int vce_v3_0_set_clockgating_state(void *handle,
                                           enum amd_clockgating_state state=
)
@@ -720,11 +713,6 @@ static int vce_v3_0_set_clockgating_state(void *handle=
,
         bool enable =3D (state =3D=3D AMD_CG_STATE_GATE) ? true : false;
         int i;

-       if ((adev->asic_type =3D=3D CHIP_POLARIS10) ||
-               (adev->asic_type =3D=3D CHIP_TONGA) ||
-               (adev->asic_type =3D=3D CHIP_FIJI))
-               vce_v3_0_set_bypass_mode(adev, enable);
-
         if (!(adev->cg_flags & AMD_CG_SUPPORT_VCE_MGCG))
                 return 0;

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c
index 16ba943..b9924e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -789,7 +789,37 @@ static int vi_set_uvd_clocks(struct amdgpu_device *ade=
v, u32 vclk, u32 dclk)

 static int vi_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u32 ec=
clk)
 {
-       /* todo */
+       int r, i;
+       struct atom_clock_dividers dividers;
+       u32 tmp;
+
+       r =3D amdgpu_atombios_get_clock_dividers(adev,
+                                              COMPUTE_GPUCLK_INPUT_FLAG_DE=
FAULT_GPUCLK,
+                                              ecclk, false, &dividers);
+       if (r)
+               return r;
+
+       for (i =3D 0; i < 100; i++) {
+               if (RREG32_SMC(ixCG_ECLK_STATUS) & CG_ECLK_STATUS__ECLK_STA=
TUS_MASK)
+                       break;
+               mdelay(10);
+       }
+       if (i =3D=3D 100)
+               return -ETIMEDOUT;
+
+       tmp =3D RREG32_SMC(ixCG_ECLK_CNTL);
+       tmp &=3D ~(CG_ECLK_CNTL__ECLK_DIR_CNTL_EN_MASK |
+               CG_ECLK_CNTL__ECLK_DIVIDER_MASK);
+       tmp |=3D dividers.post_divider;
+       WREG32_SMC(ixCG_ECLK_CNTL, tmp);
+
+       for (i =3D 0; i < 100; i++) {
+               if (RREG32_SMC(ixCG_ECLK_STATUS) & CG_ECLK_STATUS__ECLK_STA=
TUS_MASK)
+                       break;
+               mdelay(10);
+       }
+       if (i =3D=3D 100)
+               return -ETIMEDOUT;

         return 0;
 }
--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...




--_000_CY4PR12MB1768D1BC1BBC50A8228B5C5EF7640CY4PR12MB1768namp_
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
<p>On my Carrizo,&nbsp;I have to NAK since monitoring the clocks I see GFX =
and VCE pegged high on a setup with a staging kernel .</p>
<p><br>
</p>
<p>Doing a test signal encode I see 1000 fences/sec being handled and GFX_P=
OWER throttles (not idle or full)&nbsp;. &nbsp;I don't see VCE load from SR=
BM_STATUS2 though ...</p>
<p><br>
</p>
<p>Something is up for sure.</p>
<p><br>
</p>
<p>I haven't tried HEAD~ (I last tried a 4.9 kernel about 15 commits ago) s=
o I'll try that now.</p>
<p><br>
</p>
<p>Tom</p>
<p><br>
</p>
<p><br>
</p>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org=
&gt;<br>
<b>Sent:</b> Monday, January 9, 2017 08:34<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amdgpu: refine vce3.0 initialize.</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">1. disable vce cg when vce hw initialize.<br>
2. initizlize vce clock to 10KHz.<br>
3: no need to set bypass clock to vce.<br>
<br>
Change-Id: I18d5c2debc6688be201af8bb85022ac25020bd8f<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 18 &#43;&#43;&#43;-----------=
----<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vi.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |=
 32 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;-<br>
&nbsp;2 files changed, 34 insertions(&#43;), 16 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vce_v3_0.c<br>
index 5fb0b7f..eb99ee6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c<br>
@@ -223,6 &#43;223,9 @@ static int vce_v3_0_start(struct amdgpu_device *ade=
v)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int idx, r;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vce_v3_0_override_vce_clock_gatin=
g(adev, true); /* force all clocks on */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_set_vce_clocks(adev, =
10000, 10000);<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;adev-&gt;vce=
.ring[0];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_RB_RPTR, ring=
-&gt;wptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVCE_RB_WPTR, ring=
-&gt;wptr);<br>
@@ -701,17 &#43;704,7 @@ static int vce_v3_0_process_interrupt(struct amdgp=
u_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
-static void vce_v3_0_set_bypass_mode(struct amdgpu_device *adev, bool enab=
le)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp =3D RREG32_SMC(ixGCK_DFS_BYPA=
SS_CNTL);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp |=3D GCK_DFS_BYPASS_CNTL__BYPASSECLK_MASK;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp &amp;=3D ~GCK_DFS_BYPASS_CNTL__BYPASSECLK_MASK;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SMC(ixGCK_DFS_BYPASS_CNTL, tmp=
);<br>
-}<br>
&nbsp;<br>
&nbsp;static int vce_v3_0_set_clockgating_state(void *handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_clockgating_state state)<br>
@@ -720,11 &#43;713,6 @@ static int vce_v3_0_set_clockgating_state(void *ha=
ndle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool enable =3D (state =3D=
=3D AMD_CG_STATE_GATE) ? true : false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((adev-&gt;asic_type =3D=3D CHIP_P=
OLARIS10) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_TONGA) ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (adev-&gt;asic_type =3D=3D CHIP_FIJI))<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; vce_v3_0_set_bypass_mode(adev, enable);<br>
-<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(adev-&gt;cg_flags &a=
mp; AMD_CG_SUPPORT_VCE_MGCG))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/v=
i.c<br>
index 16ba943..b9924e3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vi.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vi.c<br>
@@ -789,7 &#43;789,37 @@ static int vi_set_uvd_clocks(struct amdgpu_device =
*adev, u32 vclk, u32 dclk)<br>
&nbsp;<br>
&nbsp;static int vi_set_vce_clocks(struct amdgpu_device *adev, u32 evclk, u=
32 ecclk)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* todo */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct atom_clock_dividers divide=
rs;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_atombios_get_clock_d=
ividers(adev,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; COMPUTE_GPUCLK_INPUT_FLA=
G_DEFAULT_GPUCLK,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ecclk, false, &amp;divid=
ers);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return r;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 100; i&#43;&=
#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (RREG32_SMC(ixCG_ECLK_STATUS) &amp; CG_ECLK_STATUS__ECLK_=
STATUS_MASK)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mdelay(10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D 100)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_SMC(ixCG_ECLK_CNTL=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp &amp;=3D ~(CG_ECLK_CNTL__ECLK=
_DIR_CNTL_EN_MASK |<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; CG_ECLK_CNTL__ECLK_DIVIDER_MASK);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp |=3D dividers.post_divider;<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SMC(ixCG_ECLK_CNTL, tmp);<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; 100; i&#43;&=
#43;) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; if (RREG32_SMC(ixCG_ECLK_STATUS) &amp; CG_ECLK_STATUS__ECLK_=
STATUS_MASK)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; mdelay(10);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (i =3D=3D 100)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return -ETIMEDOUT;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
-- <br>
1.9.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk226966" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14839711679560.3726773492093203" style=3D"margin-bot=
tom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14839711679530.3421724220553679" cellspacing=3D"0"=
 style=3D"width: 90%; background-color: rgb(255, 255, 255); position: relat=
ive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 2=
0px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted r=
gb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14839711679540.24572540659082542" colspan=3D"2" style=3D=
"vertical-align: top; position: relative; padding: 0px; display: table-cell=
;">
<div id=3D"LPRemovePreviewContainer_14839711679540.014855728509619581"></di=
v>
<div id=3D"LPTitle_14839711679540.301797682645744" style=3D"top: 0px; color=
: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_s=
egoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &quo=
t;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-hei=
ght: 21px;">
<a id=3D"LPUrlAnchor_14839711679550.7962728134566994" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14839711679550.153934526964302" style=3D"margin: 10px=
 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_=
segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial,=
 sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14839711679550.24383781731560905" style=3D"display=
: block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_se=
goe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, s=
ans-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow:=
 hidden;">
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...</div>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CY4PR12MB1768D1BC1BBC50A8228B5C5EF7640CY4PR12MB1768namp_--

--===============0533652261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0533652261==--
