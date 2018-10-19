From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix sdma v4 ring is disabled accidently
Date: Fri, 19 Oct 2018 19:53:53 +0000
Message-ID: <BN6PR12MB18098DF74D09F43AC24CCFFCF7F90@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1539976426-10271-1-git-send-email-Philip.Yang@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0083676869=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1539976426-10271-1-git-send-email-Philip.Yang-5C7GfCeVMHo@public.gmane.org>
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
To: "Yang, Philip" <Philip.Yang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0083676869==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB18098DF74D09F43AC24CCFFCF7F90BN6PR12MB1809namp_"

--_000_BN6PR12MB18098DF74D09F43AC24CCFFCF7F90BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yang, Ph=
ilip <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
Sent: Friday, October 19, 2018 3:13:56 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: Yang, Philip
Subject: [PATCH] drm/amdgpu: fix sdma v4 ring is disabled accidently

For sdma v4, there is bug caused by
commit d4e869b6b5d6 ("drm/amdgpu: add ring test for page queue")'

local variable ring is reused and changed, so amdgpu_ttm_set_buffer_funcs_s=
tatus(adev, true)
is skipped accidently. As a result, amdgpu_fill_buffer() will fail, kernel =
message:

[drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring =
turned off.
[   25.260444] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear me=
mory with ring turned off.
[   25.260627] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear me=
mory with ring turned off.
[   25.290119] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear me=
mory with ring turned off.
[   25.290370] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear me=
mory with ring turned off.
[   25.319971] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear me=
mory with ring turned off.
[   25.320486] amdgpu 0000:19:00.0: [mmhub] VMC page fault (src_id:0 ring:1=
54 vmid:8 pasid:32768, for process  pid 0 thread  pid 0)
[   25.320533] amdgpu 0000:19:00.0:   in page starting at address 0x0000000=
000000000 from 18
[   25.320563] amdgpu 0000:19:00.0: VM_L2_PROTECTION_FAULT_STATUS:0x0080013=
4

Change-Id: Idacdf8e60557edb0a4a499aa4051b75d87ce4091
Signed-off-by: Philip Yang <Philip.Yang-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c
index ede149a..cd368ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1151,10 +1151,11 @@ static int sdma_v4_0_start(struct amdgpu_device *ad=
ev)
                 }

                 if (adev->sdma.has_page_queue) {
-                       ring =3D &adev->sdma.instance[i].page;
-                       r =3D amdgpu_ring_test_ring(ring);
+                       struct amdgpu_ring *page =3D &adev->sdma.instance[i=
].page;
+
+                       r =3D amdgpu_ring_test_ring(page);
                         if (r) {
-                               ring->ready =3D false;
+                               page->ready =3D false;
                                 return r;
                         }
                 }
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB18098DF74D09F43AC24CCFFCF7F90BN6PR12MB1809namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Yang, Philip &lt;Philip.Yang@=
amd.com&gt;<br>
<b>Sent:</b> Friday, October 19, 2018 3:13:56 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> Yang, Philip<br>
<b>Subject:</b> [PATCH] drm/amdgpu: fix sdma v4 ring is disabled accidently=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">For sdma v4, there is bug caused by<br>
commit d4e869b6b5d6 (&quot;drm/amdgpu: add ring test for page queue&quot;)'=
<br>
<br>
local variable ring is reused and changed, so amdgpu_ttm_set_buffer_funcs_s=
tatus(adev, true)<br>
is skipped accidently. As a result, amdgpu_fill_buffer() will fail, kernel =
message:<br>
<br>
[drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring =
turned off.<br>
[&nbsp;&nbsp; 25.260444] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying t=
o clear memory with ring turned off.<br>
[&nbsp;&nbsp; 25.260627] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying t=
o clear memory with ring turned off.<br>
[&nbsp;&nbsp; 25.290119] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying t=
o clear memory with ring turned off.<br>
[&nbsp;&nbsp; 25.290370] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying t=
o clear memory with ring turned off.<br>
[&nbsp;&nbsp; 25.319971] [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying t=
o clear memory with ring turned off.<br>
[&nbsp;&nbsp; 25.320486] amdgpu 0000:19:00.0: [mmhub] VMC page fault (src_i=
d:0 ring:154 vmid:8 pasid:32768, for process&nbsp; pid 0 thread&nbsp; pid 0=
)<br>
[&nbsp;&nbsp; 25.320533] amdgpu 0000:19:00.0:&nbsp;&nbsp; in page starting =
at address 0x0000000000000000 from 18<br>
[&nbsp;&nbsp; 25.320563] amdgpu 0000:19:00.0: VM_L2_PROTECTION_FAULT_STATUS=
:0x00800134<br>
<br>
Change-Id: Idacdf8e60557edb0a4a499aa4051b75d87ce4091<br>
Signed-off-by: Philip Yang &lt;Philip.Yang-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 7 &#43;&#43;&#43;&#43;---<br=
>
&nbsp;1 file changed, 4 insertions(&#43;), 3 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v4_0.c<br>
index ede149a..cd368ac 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c<br>
@@ -1151,10 &#43;1151,11 @@ static int sdma_v4_0_start(struct amdgpu_device=
 *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (adev-&gt;sdma.has_page_queue) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D &amp;ad=
ev-&gt;sdma.instance[i].page;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_rin=
g_test_ring(ring);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgp=
u_ring *page =3D &amp;adev-&gt;sdma.instance[i].page;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu=
_ring_test_ring(page);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r=
) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring-&gt;ready =3D false;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; page-&gt;ready =3D false;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }<br>
-- <br>
2.7.4<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://=
lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
</div>
</span></font></div>
</body>
</html>

--_000_BN6PR12MB18098DF74D09F43AC24CCFFCF7F90BN6PR12MB1809namp_--

--===============0083676869==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0083676869==--
