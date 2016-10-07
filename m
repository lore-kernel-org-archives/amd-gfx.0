From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/6] drm/amdgpu: add info ioctl query for vce clock info
Date: Fri, 7 Oct 2016 18:33:30 +0000
Message-ID: <BN6PR12MB1764E581BC7A01B74C850D83F7C60@BN6PR12MB1764.namprd12.prod.outlook.com>
References: <1475864905-21269-1-git-send-email-alexander.deucher@amd.com>,
 <1475864905-21269-2-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1920763607=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1475864905-21269-2-git-send-email-alexander.deucher-5C7GfCeVMHo@public.gmane.org>
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
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Fang, Peter" <Peter.Fang-5C7GfCeVMHo@public.gmane.org>, "Zhang,
 Boyuan" <Boyuan.Zhang-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

--===============1920763607==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1764E581BC7A01B74C850D83F7C60BN6PR12MB1764namp_"

--_000_BN6PR12MB1764E581BC7A01B74C850D83F7C60BN6PR12MB1764namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Shouldn't there be a version bump if you're adding a new command to the ioc=
tl?


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex Deu=
cher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, October 7, 2016 14:28
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Fang, Peter; Zhang, Boyuan
Cc: Deucher, Alexander
Subject: [PATCH 2/6] drm/amdgpu: add info ioctl query for vce clock info

This is needed to set up the vce clock table in userspace
for proper VCE DPM.

Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
---
 include/uapi/drm/amdgpu_drm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
index b6a04d4..7cb71f8 100644
--- a/include/uapi/drm/amdgpu_drm.h
+++ b/include/uapi/drm/amdgpu_drm.h
@@ -491,6 +491,8 @@ struct drm_amdgpu_cs_chunk_data {
 #define AMDGPU_INFO_NUM_EVICTIONS               0x18
 /* Query memory about VRAM and GTT domains */
 #define AMDGPU_INFO_MEMORY                      0x19
+/* Query memory about VRAM and GTT domains */
+#define AMDGPU_INFO_VCE_CLOCK_TABLE            0x1A

 #define AMDGPU_INFO_MMR_SE_INDEX_SHIFT  0
 #define AMDGPU_INFO_MMR_SE_INDEX_MASK   0xff
@@ -677,6 +679,22 @@ struct drm_amdgpu_info_hw_ip {
         __u32  _pad;
 };

+#define AMDGPU_VCE_CLOCK_TABLE_ENTRIES         6
+
+struct drm_amdgpu_info_vce_clock_table_entry {
+       /** System clock */
+       __u32 sclk;
+       /** Memory clock */
+       __u32 mclk;
+       /** VCE clock */
+       __u32 eclk;
+       __u32 pad;
+};
+
+struct drm_amdgpu_info_vce_clock_table {
+       struct drm_amdgpu_info_vce_clock_table_entry entries[AMDGPU_VCE_CLO=
CK_TABLE_ENTRIES];
+};
+
 /*
  * Supported GPU families
  */
--
2.5.5

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




--_000_BN6PR12MB1764E581BC7A01B74C850D83F7C60BN6PR12MB1764namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Shouldn't there be a version bump if you're adding a new command to the =
ioctl?</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx=
-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Alex Deucher &lt;alexdeuche=
r@gmail.com&gt;<br>
<b>Sent:</b> Friday, October 7, 2016 14:28<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Fang, Peter; Zhang, Boyuan<br>
<b>Cc:</b> Deucher, Alexander<br>
<b>Subject:</b> [PATCH 2/6] drm/amdgpu: add info ioctl query for vce clock =
info</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">This is needed to set up the vce clock table in us=
erspace<br>
for proper VCE DPM.<br>
<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;include/uapi/drm/amdgpu_drm.h | 18 &#43;&#43;&#43;&#43;&#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;1 file changed, 18 insertions(&#43;)<br>
<br>
diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h<=
br>
index b6a04d4..7cb71f8 100644<br>
--- a/include/uapi/drm/amdgpu_drm.h<br>
&#43;&#43;&#43; b/include/uapi/drm/amdgpu_drm.h<br>
@@ -491,6 &#43;491,8 @@ struct drm_amdgpu_cs_chunk_data {<br>
&nbsp;#define AMDGPU_INFO_NUM_EVICTIONS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x18<br>
&nbsp;/* Query memory about VRAM and GTT domains */<br>
&nbsp;#define AMDGPU_INFO_MEMORY&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; 0x19<br>
&#43;/* Query memory about VRAM and GTT domains */<br>
&#43;#define AMDGPU_INFO_VCE_CLOCK_TABLE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x1A<br>
&nbsp;<br>
&nbsp;#define AMDGPU_INFO_MMR_SE_INDEX_SHIFT&nbsp; 0<br>
&nbsp;#define AMDGPU_INFO_MMR_SE_INDEX_MASK&nbsp;&nbsp; 0xff<br>
@@ -677,6 &#43;679,22 @@ struct drm_amdgpu_info_hw_ip {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32&nbsp; _pad;<br>
&nbsp;};<br>
&nbsp;<br>
&#43;#define AMDGPU_VCE_CLOCK_TABLE_ENTRIES&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; 6<br>
&#43;<br>
&#43;struct drm_amdgpu_info_vce_clock_table_entry {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** System clock */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 sclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** Memory clock */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 mclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /** VCE clock */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 eclk;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; __u32 pad;<br>
&#43;};<br>
&#43;<br>
&#43;struct drm_amdgpu_info_vce_clock_table {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_amdgpu_info_vce_clock_=
table_entry entries[AMDGPU_VCE_CLOCK_TABLE_ENTRIES];<br>
&#43;};<br>
&#43;<br>
&nbsp;/*<br>
&nbsp; * Supported GPU families<br>
&nbsp; */<br>
-- <br>
2.5.5<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk721057" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14758651863140.18769845284713105" style=3D"margin-bo=
ttom: 20px; overflow: auto; width: 100%; text-indent: 0px;">
<table id=3D"LPContainer_14758651863120.5943237317888346" cellspacing=3D"0"=
 style=3D"width: 90%; background-color: rgb(255, 255, 255); position: relat=
ive; overflow: auto; padding-top: 20px; padding-bottom: 20px; margin-top: 2=
0px; border-top: 1px dotted rgb(200, 200, 200); border-bottom: 1px dotted r=
gb(200, 200, 200);">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td id=3D"TextCell_14758651863130.019189628010207516" colspan=3D"2" style=
=3D"vertical-align: top; position: relative; padding: 0px; display: table-c=
ell;">
<div id=3D"LPRemovePreviewContainer_14758651863130.3705829285253708"></div>
<div id=3D"LPTitle_14758651863130.3572217220295699" style=3D"top: 0px; colo=
r: rgb(59, 87, 119); font-weight: normal; font-size: 21px; font-family: wf_=
segoe-ui_light, &quot;Segoe UI Light&quot;, &quot;Segoe WP Light&quot;, &qu=
ot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; line-he=
ight: 21px;">
<a id=3D"LPUrlAnchor_14758651863130.4017346381452327" href=3D"https://lists=
.freedesktop.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-=
decoration: none;">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14758651863130.055356739019825074" style=3D"margin: 1=
0px 0px 16px; color: rgb(102, 102, 102); font-weight: normal; font-family: =
wf_segoe-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Ari=
al, sans-serif; font-size: 14px; line-height: 14px;">
lists.freedesktop.org</div>
<div id=3D"LPDescription_14758651863140.976017929360546" style=3D"display: =
block; color: rgb(102, 102, 102); font-weight: normal; font-family: wf_sego=
e-ui_normal, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, san=
s-serif; font-size: 14px; line-height: 20px; max-height: 100px; overflow: h=
idden;">
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

--_000_BN6PR12MB1764E581BC7A01B74C850D83F7C60BN6PR12MB1764namp_--

--===============1920763607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1920763607==--
