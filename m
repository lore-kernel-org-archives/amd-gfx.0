From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add ENGINE_CNTL register to vcn10 headers
Date: Tue, 5 Mar 2019 15:26:21 +0000
Message-ID: <BN6PR12MB1809ABD3464A414AACE5B723F7720@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20190304155924.9436-1-tom.stdenis@amd.com>,
 <CAAzXoRLtZG_A4GgscVRo5aGL11i1PqUTrdTtOGyYvNjSgYCpLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0707413084=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAAzXoRLtZG_A4GgscVRo5aGL11i1PqUTrdTtOGyYvNjSgYCpLQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, amd-gfx mailing list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0707413084==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809ABD3464A414AACE5B723F7720BN6PR12MB1809namp_"

--_000_BN6PR12MB1809ABD3464A414AACE5B723F7720BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Tom St D=
enis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, March 5, 2019 10:17 AM
To: amd-gfx mailing list
Subject: Re: [PATCH] drm/amd/amdgpu: Add ENGINE_CNTL register to vcn10 head=
ers

Hi,

Alex can I get an RB on this :-)

Thanks,
Tom

On Mon, Mar 4, 2019 at 10:59 AM StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org<mailto:To=
m.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:
Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org<mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org=
>>
---
 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h  | 2 ++
 drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h b/dr=
ivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h
index 442ca7c471a5..6109f5ad25ad 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h
@@ -141,6 +141,8 @@
 #define mmUVD_GPCOM_VCPU_DATA0_BASE_IDX                                   =
                             1
 #define mmUVD_GPCOM_VCPU_DATA1                                            =
                             0x03c5
 #define mmUVD_GPCOM_VCPU_DATA1_BASE_IDX                                   =
                             1
+#define mmUVD_ENGINE_CNTL                                                 =
                             0x03c6
+#define mmUVD_ENGINE_CNTL_BASE_IDX                                        =
                             1
 #define mmUVD_UDEC_DBW_UV_ADDR_CONFIG                                     =
                             0x03d2
 #define mmUVD_UDEC_DBW_UV_ADDR_CONFIG_BASE_IDX                            =
                             1
 #define mmUVD_UDEC_ADDR_CONFIG                                            =
                             0x03d3
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h b/d=
rivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h
index 63457f9df4c5..f84bed6eecb9 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h
@@ -312,6 +312,11 @@
 //UVD_GPCOM_VCPU_DATA1
 #define UVD_GPCOM_VCPU_DATA1__DATA1__SHIFT                                =
                                    0x0
 #define UVD_GPCOM_VCPU_DATA1__DATA1_MASK                                  =
                                    0xFFFFFFFFL
+//UVD_ENGINE_CNTL
+#define UVD_ENGINE_CNTL__ENGINE_START_MASK 0x1
+#define UVD_ENGINE_CNTL__ENGINE_START__SHIFT 0x0
+#define UVD_ENGINE_CNTL__ENGINE_START_MODE_MASK 0x2
+#define UVD_ENGINE_CNTL__ENGINE_START_MODE__SHIFT 0x1
 //UVD_UDEC_DBW_UV_ADDR_CONFIG
 #define UVD_UDEC_DBW_UV_ADDR_CONFIG__NUM_PIPES__SHIFT                     =
                                    0x0
 #define UVD_UDEC_DBW_UV_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT          =
                                    0x3
--
2.17.2

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809ABD3464A414AACE5B723F7720BN6PR12MB1809namp_
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
Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Tom St Denis &lt;tstdenis82@g=
mail.com&gt;<br>
<b>Sent:</b> Tuesday, March 5, 2019 10:17 AM<br>
<b>To:</b> amd-gfx mailing list<br>
<b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Add ENGINE_CNTL register to vcn=
10 headers</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"ltr">Hi,
<div><br>
</div>
<div>Alex can I get an RB on this :-)</div>
<div><br>
</div>
<div>Thanks,</div>
<div>Tom</div>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Mon, Mar 4, 2019 at 10:59 AM StD=
enis, Tom &lt;<a href=3D"mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a=
>&gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px 0.8ex; bord=
er-left:1px solid rgb(204,204,204); padding-left:1ex">
Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org" targ=
et=3D"_blank">tom.stdenis-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h&nbsp; | 2 &=
#43;&#43;<br>
&nbsp;drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h | 5 &#43;&=
#43;&#43;&#43;&#43;<br>
&nbsp;2 files changed, 7 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h b/dr=
ivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h<br>
index 442ca7c471a5..6109f5ad25ad 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_offset.h=
<br>
@@ -141,6 &#43;141,8 @@<br>
&nbsp;#define mmUVD_GPCOM_VCPU_DATA0_BASE_IDX&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
&nbsp;#define mmUVD_GPCOM_VCPU_DATA1&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x03c5=
<br>
&nbsp;#define mmUVD_GPCOM_VCPU_DATA1_BASE_IDX&nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 1<br>
&#43;#define mmUVD_ENGINE_CNTL&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; 0x03c6<br>
&#43;#define mmUVD_ENGINE_CNTL_BASE_IDX&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1<br>
&nbsp;#define mmUVD_UDEC_DBW_UV_ADDR_CONFIG&nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x03d2<br>
&nbsp;#define mmUVD_UDEC_DBW_UV_ADDR_CONFIG_BASE_IDX&nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp;1<br>
&nbsp;#define mmUVD_UDEC_ADDR_CONFIG&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x03d3=
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h b/d=
rivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h<br>
index 63457f9df4c5..f84bed6eecb9 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.h<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/include/asic_reg/vcn/vcn_1_0_sh_mask.=
h<br>
@@ -312,6 &#43;312,11 @@<br>
&nbsp;//UVD_GPCOM_VCPU_DATA1<br>
&nbsp;#define UVD_GPCOM_VCPU_DATA1__DATA1__SHIFT&nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0x0<br>
&nbsp;#define UVD_GPCOM_VCPU_DATA1__DATA1_MASK&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0xFFFFFFF=
FL<br>
&#43;//UVD_ENGINE_CNTL<br>
&#43;#define UVD_ENGINE_CNTL__ENGINE_START_MASK 0x1<br>
&#43;#define UVD_ENGINE_CNTL__ENGINE_START__SHIFT 0x0<br>
&#43;#define UVD_ENGINE_CNTL__ENGINE_START_MODE_MASK 0x2<br>
&#43;#define UVD_ENGINE_CNTL__ENGINE_START_MODE__SHIFT 0x1<br>
&nbsp;//UVD_UDEC_DBW_UV_ADDR_CONFIG<br>
&nbsp;#define UVD_UDEC_DBW_UV_ADDR_CONFIG__NUM_PIPES__SHIFT&nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; =
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0x0<br>
&nbsp;#define UVD_UDEC_DBW_UV_ADDR_CONFIG__PIPE_INTERLEAVE_SIZE__SHIFT&nbsp=
; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; 0x3<br>
-- <br>
2.17.2<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank">amd-gfx@=
lists.freedesktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank">https://lists.freedesktop.org/mailman/listinfo=
/amd-gfx</a></blockquote>
</div>
</div>
</body>
</html>

--_000_BN6PR12MB1809ABD3464A414AACE5B723F7720BN6PR12MB1809namp_--

--===============0707413084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0707413084==--
