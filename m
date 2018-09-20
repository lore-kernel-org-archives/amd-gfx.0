From: "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH v2] drm/amdgpu:No action when VCN PG state is unchanged
Date: Thu, 20 Sep 2018 14:19:35 +0000
Message-ID: <CY4PR1201MB010247778F5EA9205E9B138CE4130@CY4PR1201MB0102.namprd12.prod.outlook.com>
References: <1536598142-19689-1-git-send-email-James.Zhu@amd.com>,
 <1536872144-18347-1-git-send-email-James.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0020415243=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1536872144-18347-1-git-send-email-James.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0020415243==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1201MB010247778F5EA9205E9B138CE4130CY4PR1201MB0102_"

--_000_CY4PR1201MB010247778F5EA9205E9B138CE4130CY4PR1201MB0102_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Ping


Alex and Christian,


Could you give a review on this updated patch?


Thanks & Best Regards!


James Zhu


________________________________
From: James Zhu <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Thursday, September 13, 2018 4:55 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Zhu, James
Subject: [PATCH v2] drm/amdgpu:No action when VCN PG state is unchanged

When VCN PG state is unchanged, it is unnecessary to reset power
gate state

Signed-off-by: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index 0b0b863..d2219ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -69,6 +69,7 @@ struct amdgpu_vcn {
         struct amdgpu_ring      ring_jpeg;
         struct amdgpu_irq_src   irq;
         unsigned                num_enc_rings;
+       enum amd_powergating_state cur_state;
 };

 int amdgpu_vcn_sw_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c
index 2664bb2..2cde0b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -1633,12 +1633,20 @@ static int vcn_v1_0_set_powergating_state(void *han=
dle,
          * revisit this when there is a cleaner line between
          * the smc and the hw blocks
          */
+       int ret;
         struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;

+       if(state =3D=3D adev->vcn.cur_state)
+               return 0;
+
         if (state =3D=3D AMD_PG_STATE_GATE)
-               return vcn_v1_0_stop(adev);
+               ret =3D vcn_v1_0_stop(adev);
         else
-               return vcn_v1_0_start(adev);
+               ret =3D vcn_v1_0_start(adev);
+
+       if(!ret)
+               adev->vcn.cur_state =3D state;
+       return ret;
 }

 static const struct amd_ip_funcs vcn_v1_0_ip_funcs =3D {
--
2.7.4


--_000_CY4PR1201MB010247778F5EA9205E9B138CE4130CY4PR1201MB0102_
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
<p style=3D"margin-top:0;margin-bottom:0">Ping</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex and Christian,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Could you give a review on this u=
pdated patch?<br>
</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<div id=3D"Signature">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size: 12pt; colo=
r: rgb(0, 0, 0); font-family: Calibri,Arial,Helvetica,sans-serif,&quot;Emoj=
iFont&quot;,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,NotoCo=
lorEmoji,&quot;Segoe UI Symbol&quot;,&quot;Android Emoji&quot;,EmojiSymbols=
;">
<p>Thanks &amp; Best Regards!</p>
<p><br>
</p>
<p>James Zhu<br>
</p>
</div>
</div>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> James Zhu &lt;jzhum=
s@gmail.com&gt;<br>
<b>Sent:</b> Thursday, September 13, 2018 4:55 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Zhu, James<br>
<b>Subject:</b> [PATCH v2] drm/amdgpu:No action when VCN PG state is unchan=
ged</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When VCN PG state is unchanged, it is unnecessary =
to reset power<br>
gate state<br>
<br>
Signed-off-by: James Zhu &lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |&nbsp; 1 &#43;<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c&nbsp;&nbsp; | 12 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;2 files changed, 11 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h<br>
index 0b0b863..d2219ab 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
@@ -69,6 &#43;69,7 @@ struct amdgpu_vcn {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; ring_jpeg;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq_src&nbsp=
;&nbsp; irq;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nu=
m_enc_rings;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum amd_powergating_state cur_st=
ate;<br>
&nbsp;};<br>
&nbsp;<br>
&nbsp;int amdgpu_vcn_sw_init(struct amdgpu_device *adev);<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v1_0.c<br>
index 2664bb2..2cde0b4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c<br>
@@ -1633,12 &#43;1633,20 @@ static int vcn_v1_0_set_powergating_state(void =
*handle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * revisit this when =
there is a cleaner line between<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * the smc and the hw=
 blocks<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D (struct amdgpu_device *)handle;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(state =3D=3D adev-&gt;vcn.cur_=
state)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return 0;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (state =3D=3D AMD_PG_ST=
ATE_GATE)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return vcn_v1_0_stop(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D vcn_v1_0_stop(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return vcn_v1_0_start(adev);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; ret =3D vcn_v1_0_start(adev);<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if(!ret)<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;vcn.cur_state =3D state;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static const struct amd_ip_funcs vcn_v1_0_ip_funcs =3D {<br>
-- <br>
2.7.4<br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_CY4PR1201MB010247778F5EA9205E9B138CE4130CY4PR1201MB0102_--

--===============0020415243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0020415243==--
