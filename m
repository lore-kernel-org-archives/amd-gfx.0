From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix vcn_v1_0_dec_ring_emit_wreg
Date: Fri, 26 Jan 2018 21:28:11 +0000
Message-ID: <BN6PR12MB16529454E3497482124B3268F7E00@BN6PR12MB1652.namprd12.prod.outlook.com>
References: <20180126132450.47836-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1008476377=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20180126132450.47836-1-christian.koenig-5C7GfCeVMHo@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1008476377==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB16529454E3497482124B3268F7E00BN6PR12MB1652namp_"

--_000_BN6PR12MB16529454E3497482124B3268F7E00BN6PR12MB1652namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, January 26, 2018 8:24 AM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: [PATCH] drm/amdgpu: fix vcn_v1_0_dec_ring_emit_wreg

That got mixed up with the encode ring function.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c
index 44c041a1fe68..24ebc3e296a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -880,6 +880,22 @@ static void vcn_v1_0_dec_ring_emit_vm_flush(struct amd=
gpu_ring *ring,
         vcn_v1_0_dec_vm_reg_wait(ring, data0, data1, mask);
 }

+static void vcn_v1_0_dec_ring_emit_wreg(struct amdgpu_ring *ring,
+                                       uint32_t reg, uint32_t val)
+{
+       struct amdgpu_device *adev =3D ring->adev;
+
+       amdgpu_ring_write(ring,
+               PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0), 0=
));
+       amdgpu_ring_write(ring, reg << 2);
+       amdgpu_ring_write(ring,
+               PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1), 0=
));
+       amdgpu_ring_write(ring, val);
+       amdgpu_ring_write(ring,
+               PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_CMD), 0))=
;
+       amdgpu_ring_write(ring, VCN_DEC_CMD_WRITE_REG << 1);
+}
+
 /**
  * vcn_v1_0_enc_ring_get_rptr - get enc read pointer
  *
@@ -1097,7 +1113,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_dec_ri=
ng_vm_funcs =3D {
         .pad_ib =3D amdgpu_ring_generic_pad_ib,
         .begin_use =3D amdgpu_vcn_ring_begin_use,
         .end_use =3D amdgpu_vcn_ring_end_use,
-       .emit_wreg =3D vcn_v1_0_enc_ring_emit_wreg,
+       .emit_wreg =3D vcn_v1_0_dec_ring_emit_wreg,
 };

 static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs =3D {
@@ -1124,6 +1140,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_enc_ri=
ng_vm_funcs =3D {
         .pad_ib =3D amdgpu_ring_generic_pad_ib,
         .begin_use =3D amdgpu_vcn_ring_begin_use,
         .end_use =3D amdgpu_vcn_ring_end_use,
+       .emit_wreg =3D vcn_v1_0_enc_ring_emit_wreg,
 };

 static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev)
--
2.14.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB16529454E3497482124B3268F7E00BN6PR12MB1652namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<p style=3D"margin-top:0;margin-bottom:0">Reviewed-by: Alex Deucher &lt;ale=
xander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;ckoen=
ig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, January 26, 2018 8:24 AM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix vcn_v1_0_dec_ring_emit_wreg</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">That got mixed up with the encode ring function.<b=
r>
<br>
Signed-off-by: Christian K=F6nig &lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c | 19 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;1 file changed, 18 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c<br>
index 44c041a1fe68..24ebc3e296a6 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
@@ -880,6 &#43;880,22 @@ static void vcn_v1_0_dec_ring_emit_vm_flush(struct=
 amdgpu_ring *ring,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vcn_v1_0_dec_vm_reg_wait(r=
ing, data0, data1, mask);<br>
&nbsp;}<br>
&nbsp;<br>
&#43;static void vcn_v1_0_dec_ring_emit_wreg(struct amdgpu_ring *ring,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; uint32_t reg, uint32_t val)<br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D ri=
ng-&gt;adev;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA0), 0)=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, reg &lt;&=
lt; 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_DATA1), 0)=
);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, val);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_GPCOM_VCPU_CMD), 0));=
<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_write(ring, VCN_DEC_C=
MD_WRITE_REG &lt;&lt; 1);<br>
&#43;}<br>
&#43;<br>
&nbsp;/**<br>
&nbsp; * vcn_v1_0_enc_ring_get_rptr - get enc read pointer<br>
&nbsp; *<br>
@@ -1097,7 &#43;1113,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_de=
c_ring_vm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D amdgpu_ring_ge=
neric_pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .begin_use =3D amdgpu_vcn_=
ring_begin_use,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .end_use =3D amdgpu_vcn_ri=
ng_end_use,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D vcn_v1_0_enc_ring_emit=
_wreg,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D vcn_v1_0_dec_ring_=
emit_wreg,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_ring_funcs vcn_v1_0_enc_ring_vm_funcs =3D =
{<br>
@@ -1124,6 &#43;1140,7 @@ static const struct amdgpu_ring_funcs vcn_v1_0_en=
c_ring_vm_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .pad_ib =3D amdgpu_ring_ge=
neric_pad_ib,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .begin_use =3D amdgpu_vcn_=
ring_begin_use,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .end_use =3D amdgpu_vcn_ri=
ng_end_use,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .emit_wreg =3D vcn_v1_0_enc_ring_=
emit_wreg,<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static void vcn_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev)<b=
r>
-- <br>
2.14.1<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk314177" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a><br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB16529454E3497482124B3268F7E00BN6PR12MB1652namp_--

--===============1008476377==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1008476377==--
