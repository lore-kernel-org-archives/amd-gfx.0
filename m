From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix IH overflow on Vega10
Date: Fri, 14 Dec 2018 15:47:55 +0000
Message-ID: <BN6PR12MB18096E61C433234BC2881BE6F7A10@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20181214143723.5165-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1503797858=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20181214143723.5165-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1503797858==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18096E61C433234BC2881BE6F7A10BN6PR12MB1809namp_"

--_000_BN6PR12MB18096E61C433234BC2881BE6F7A10BN6PR12MB1809namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, December 14, 2018 9:37:23 AM
To: Deucher, Alexander; alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; amd-gfx-PD4FTy7X32lNgt0PjOBp9/EVdHwE84te@public.gmane.org=
g
Subject: [PATCH] drm/amdgpu: fix IH overflow on Vega10

When an ring buffer overflow happens the appropriate bit is set in the WPTR
register which is also written back to memory. But clearing the bit in the
WPTR doesn't trigger another memory writeback.

So what can happen is that we end up processing the buffer overflow over an=
d
over again because the bit is never cleared. Resulting in a random system
lockup because of an infinite loop in an interrupt handler.

This is 100% reproducible on Vega10, but it's most likely an issue we have
in the driver over all generations all the way back to radeon.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 68 ++++++++++++++++----------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c
index 992c8a8b8f77..0ab7785079c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -276,31 +276,49 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *a=
dev,

         wptr =3D le32_to_cpu(*ih->wptr_cpu);

-       if (REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW)) {
-               wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
-
-               /* When a ring buffer overflow happen start parsing interru=
pt
-                * from the last not overwritten vector (wptr + 32). Hopefu=
lly
-                * this should allow us to catchup.
-                */
-               tmp =3D (wptr + 32) & ih->ptr_mask;
-               dev_warn(adev->dev, "IH ring buffer overflow (0x%08X, 0x%08=
X, 0x%08X)\n",
-                        wptr, ih->rptr, tmp);
-               ih->rptr =3D tmp;
-
-               if (ih =3D=3D &adev->irq.ih)
-                       reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);
-               else if (ih =3D=3D &adev->irq.ih1)
-                       reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RI=
NG1);
-               else if (ih =3D=3D &adev->irq.ih2)
-                       reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RI=
NG2);
-               else
-                       BUG();
-
-               tmp =3D RREG32_NO_KIQ(reg);
-               tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR,=
 1);
-               WREG32_NO_KIQ(reg, tmp);
-       }
+       if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+               goto out;
+
+       /* Double check that the overflow wasn't already cleared. */
+       if (ih =3D=3D &adev->irq.ih)
+               reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR);
+       else if (ih =3D=3D &adev->irq.ih1)
+               reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING1);
+       else if (ih =3D=3D &adev->irq.ih2)
+               reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING2);
+       else
+               BUG();
+
+       wptr =3D RREG32_NO_KIQ(reg);
+       if (!REG_GET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW))
+               goto out;
+
+       wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);
+
+       /* When a ring buffer overflow happen start parsing interrupt
+        * from the last not overwritten vector (wptr + 32). Hopefully
+        * this should allow us to catchup.
+        */
+       tmp =3D (wptr + 32) & ih->ptr_mask;
+       dev_warn(adev->dev, "IH ring buffer overflow "
+                "(0x%08X, 0x%08X, 0x%08X)\n",
+                wptr, ih->rptr, tmp);
+       ih->rptr =3D tmp;
+
+       if (ih =3D=3D &adev->irq.ih)
+               reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);
+       else if (ih =3D=3D &adev->irq.ih1)
+               reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING1);
+       else if (ih =3D=3D &adev->irq.ih2)
+               reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING2);
+       else
+               BUG();
+
+       tmp =3D RREG32_NO_KIQ(reg);
+       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
+       WREG32_NO_KIQ(reg, tmp);
+
+out:
         return (wptr & ih->ptr_mask);
 }

--
2.17.1


--_000_BN6PR12MB18096E61C433234BC2881BE6F7A10BN6PR12MB1809namp_
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
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, December 14, 2018 9:37:23 AM<br>
<b>To:</b> Deucher, Alexander; alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org; amd-gfx-PD4FTy7X32mqWrfYKbYh0A@public.gmane.org=
ktop.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix IH overflow on Vega10</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When an ring buffer overflow happens the appropria=
te bit is set in the WPTR<br>
register which is also written back to memory. But clearing the bit in the<=
br>
WPTR doesn't trigger another memory writeback.<br>
<br>
So what can happen is that we end up processing the buffer overflow over an=
d<br>
over again because the bit is never cleared. Resulting in a random system<b=
r>
lockup because of an infinite loop in an interrupt handler.<br>
<br>
This is 100% reproducible on Vega10, but it's most likely an issue we have<=
br>
in the driver over all generations all the way back to radeon.<br>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vega10_ih.c | 68 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----------<br>
&nbsp;1 file changed, 43 insertions(&#43;), 25 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/vega10_ih.c<br>
index 992c8a8b8f77..0ab7785079c0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c<br>
@@ -276,31 &#43;276,49 @@ static u32 vega10_ih_get_wptr(struct amdgpu_devic=
e *adev,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr =3D le32_to_cpu(*ih-&=
gt;wptr_cpu);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (REG_GET_FIELD(wptr, IH_RB_WPTR, R=
B_OVERFLOW)) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; wptr =3D REG_SET_FIELD(wptr, IH_RB_WPTR, RB_OVERFLOW, 0);<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* When a ring buffer overflow happen start parsing interrupt<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * from the last not overwritten vector (wptr &#43; 32). Ho=
pefully<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; * this should allow us to catchup.<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D (wptr &#43; 32) &amp; ih-&gt;ptr_mask;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; dev_warn(adev-&gt;dev, &quot;IH ring buffer overflow (0x%08X, 0x=
%08X, 0x%08X)\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr, ih-&=
gt;rptr, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; ih-&gt;rptr =3D tmp;<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (ih =3D=3D &amp;adev-&gt;irq.ih)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D SOC15_RE=
G_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;irq.ih1)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D SOC15_RE=
G_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;irq.ih2)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reg =3D SOC15_RE=
G_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
-<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D RREG32_NO_KIQ(reg);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_NO_KIQ(reg, tmp);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!REG_GET_FIELD(wptr, IH_RB_WP=
TR, RB_OVERFLOW))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Double check that the overflow=
 wasn't already cleared. */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&gt;irq.i=
h)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;=
irq.ih1)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;=
irq.ih2)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_WPTR_RING2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; BUG();<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr =3D RREG32_NO_KIQ(reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!REG_GET_FIELD(wptr, IH_RB_WP=
TR, RB_OVERFLOW))<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; goto out;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wptr =3D REG_SET_FIELD(wptr, IH_R=
B_WPTR, RB_OVERFLOW, 0);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* When a ring buffer overflow ha=
ppen start parsing interrupt<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * from the last not overwri=
tten vector (wptr &#43; 32). Hopefully<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * this should allow us to c=
atchup.<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D (wptr &#43; 32) &amp; ih-=
&gt;ptr_mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;IH r=
ing buffer overflow &quot;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &quot;(0x%08X, 0x%08X, 0x%08X)\n&quot;,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; wptr, ih-&gt;rptr, tmp);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ih-&gt;rptr =3D tmp;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ih =3D=3D &amp;adev-&gt;irq.i=
h)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;=
irq.ih1)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (ih =3D=3D &amp;adev-&gt;=
irq.ih2)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; reg =3D SOC15_REG_OFFSET(OSSSYS, 0, mmIH_RB_CNTL_RING2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; BUG();<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32_NO_KIQ(reg);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, IH_RB_=
CNTL, WPTR_OVERFLOW_CLEAR, 1);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_NO_KIQ(reg, tmp);<br>
&#43;<br>
&#43;out:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (wptr &amp; ih-&gt;=
ptr_mask);<br>
&nbsp;}<br>
&nbsp;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18096E61C433234BC2881BE6F7A10BN6PR12MB1809namp_--

--===============1503797858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1503797858==--
