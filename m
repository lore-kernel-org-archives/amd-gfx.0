From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/1] drm/amdgpu: Raise KFD unpinned system memory limit
Date: Mon, 25 Nov 2019 23:19:06 +0000
Message-ID: <DM6PR12MB277806E387DFC479BDD8AB47F04A0@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191125212819.21392-1-Felix.Kuehling@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0857346548=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191125212819.21392-1-Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
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
To: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0857346548==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB277806E387DFC479BDD8AB47F04A0DM6PR12MB2778namp_"

--_000_DM6PR12MB277806E387DFC479BDD8AB47F04A0DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Felix Ku=
ehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 25, 2019 4:28 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH 1/1] drm/amdgpu: Raise KFD unpinned system memory limit

Allow KFD applications to use more unpinned system memory through
HMM.

Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index e43a95514b41..b6d1958d514f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -85,7 +85,7 @@ static bool check_if_add_bo_to_vm(struct amdgpu_vm *avm,
 }

 /* Set memory usage limits. Current, limits are
- *  System (TTM + userptr) memory - 3/4th System RAM
+ *  System (TTM + userptr) memory - 15/16th System RAM
  *  TTM memory - 3/8th System RAM
  */
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
@@ -98,7 +98,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
         mem *=3D si.mem_unit;

         spin_lock_init(&kfd_mem_limit.mem_limit_lock);
-       kfd_mem_limit.max_system_mem_limit =3D (mem >> 1) + (mem >> 2);
+       kfd_mem_limit.max_system_mem_limit =3D mem - (mem >> 4);
         kfd_mem_limit.max_ttm_mem_limit =3D (mem >> 1) - (mem >> 3);
         pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
                 (kfd_mem_limit.max_system_mem_limit >> 20),
--
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cyong.zha=
o%40amd.com%7C808d3732d1d74a7cd05208d771ee6f9b%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637103141200385929&amp;sdata=3DyywimvE%2FuidOPQb9IYLZi95Mb=
fnFrW0Swmp11iYi4%2BI%3D&amp;reserved=3D0

--_000_DM6PR12MB277806E387DFC479BDD8AB47F04A0DM6PR12MB2778namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; backgrou=
nd-color: rgb(255, 255, 255); display: inline !important">Reviewed-by: Yong=
 Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Felix Kuehling &lt;Felix.Kueh=
ling-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, November 25, 2019 4:28 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;<br>
<b>Subject:</b> [PATCH 1/1] drm/amdgpu: Raise KFD unpinned system memory li=
mit</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Allow KFD applications to use more unpinned system=
 memory through<br>
HMM.<br>
<br>
Signed-off-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 &#43;&#43;--<br>
&nbsp;1 file changed, 2 insertions(&#43;), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
index e43a95514b41..b6d1958d514f 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c<br>
@@ -85,7 &#43;85,7 @@ static bool check_if_add_bo_to_vm(struct amdgpu_vm *a=
vm,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/* Set memory usage limits. Current, limits are<br>
- *&nbsp; System (TTM &#43; userptr) memory - 3/4th System RAM<br>
&#43; *&nbsp; System (TTM &#43; userptr) memory - 15/16th System RAM<br>
&nbsp; *&nbsp; TTM memory - 3/8th System RAM<br>
&nbsp; */<br>
&nbsp;void amdgpu_amdkfd_gpuvm_init_mem_limits(void)<br>
@@ -98,7 &#43;98,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mem *=3D si.mem_unit;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_init(&amp;kfd_me=
m_limit.mem_limit_lock);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.max_system_mem_limit =
=3D (mem &gt;&gt; 1) &#43; (mem &gt;&gt; 2);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.max_system_mem_limi=
t =3D mem - (mem &gt;&gt; 4);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_mem_limit.max_ttm_mem_=
limit =3D (mem &gt;&gt; 1) - (mem &gt;&gt; 3);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pr_debug(&quot;Kernel memo=
ry limit %lluM, TTM limit %lluM\n&quot;,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; (kfd_mem_limit.max_system_mem_limit &gt;&gt; 20),<br>
-- <br>
2.24.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Cyong.zhao%40amd.com%7C808d3732d1d74a7cd05208d771ee6f9b%7C3dd8961fe48=
84e608e11a82d994e183d%7C0%7C0%7C637103141200385929&amp;amp;sdata=3DyywimvE%=
2FuidOPQb9IYLZi95MbfnFrW0Swmp11iYi4%2BI%3D&amp;amp;reserved=3D0">https://na=
m11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop=
.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cyong.zhao%40am=
d.com%7C808d3732d1d74a7cd05208d771ee6f9b%7C3dd8961fe4884e608e11a82d994e183d=
%7C0%7C0%7C637103141200385929&amp;amp;sdata=3DyywimvE%2FuidOPQb9IYLZi95Mbfn=
FrW0Swmp11iYi4%2BI%3D&amp;amp;reserved=3D0</a></div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB277806E387DFC479BDD8AB47F04A0DM6PR12MB2778namp_--

--===============0857346548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0857346548==--
