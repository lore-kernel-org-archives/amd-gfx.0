From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add more config data for debugfs
Date: Mon, 15 Aug 2016 12:26:24 +0000
Message-ID: <DM5PR12MB1132BE10BFA7B652BD16A3E2F7120@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <20160812192852.25500-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0702392315=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20160812192852.25500-1-tom.stdenis-5C7GfCeVMHo@public.gmane.org>
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
To: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0702392315==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB1132BE10BFA7B652BD16A3E2F7120DM5PR12MB1132namp_"

--_000_DM5PR12MB1132BE10BFA7B652BD16A3E2F7120DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all,


If I could get an ACK/NAK that would be appreciated.  I have a commit pendi=
ng on the debug tool (that reads these) that I'd like to get out.


Thanks,

Tom


________________________________
From: Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Friday, August 12, 2016 15:28
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Cc: StDenis, Tom
Subject: [PATCH] drm/amd/amdgpu: Add more config data for debugfs

Adds rev_id as well as cg/pg flags to help debug runtime.

Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 53763614c6e0..bbd3173cc5ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2653,7 +2653,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct =
file *f, char __user *buf,
                 return -ENOMEM;

         /* version, increment each time something is added */
-       config[no_regs++] =3D 0;
+       config[no_regs++] =3D 1;
         config[no_regs++] =3D adev->gfx.config.max_shader_engines;
         config[no_regs++] =3D adev->gfx.config.max_tile_pipes;
         config[no_regs++] =3D adev->gfx.config.max_cu_per_sh;
@@ -2678,6 +2678,11 @@ static ssize_t amdgpu_debugfs_gca_config_read(struct=
 file *f, char __user *buf,
         config[no_regs++] =3D adev->gfx.config.gb_addr_config;
         config[no_regs++] =3D adev->gfx.config.num_rbs;

+       /* rev=3D=3D1 */
+       config[no_regs++] =3D adev->rev_id;
+       config[no_regs++] =3D adev->pg_flags;
+       config[no_regs++] =3D adev->cg_flags;
+
         while (size && (*pos < no_regs * 4)) {
                 uint32_t value;

--
2.9.2


--_000_DM5PR12MB1132BE10BFA7B652BD16A3E2F7120DM5PR12MB1132namp_
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
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;back=
ground-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
<p>Hi all,</p>
<p><br>
</p>
<p>If I could get an ACK/NAK that would be appreciated. &nbsp;I have a comm=
it pending on the debug tool (that reads these) that I'd like to get out.</=
p>
<p><br>
</p>
<p>Thanks,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Tom St Denis &lt;ts=
tdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Friday, August 12, 2016 15:28<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Cc:</b> StDenis, Tom<br>
<b>Subject:</b> [PATCH] drm/amd/amdgpu: Add more config data for debugfs</f=
ont>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">Adds rev_id as well as cg/pg flags to help debug r=
untime.<br>
<br>
Signed-off-by: Tom St Denis &lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 &#43;&#43;&#43;&#43;&#=
43;&#43;-<br>
&nbsp;1 file changed, 6 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c<br>
index 53763614c6e0..bbd3173cc5ea 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
@@ -2653,7 &#43;2653,7 @@ static ssize_t amdgpu_debugfs_gca_config_read(str=
uct file *f, char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -ENOMEM;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* version, increment each=
 time something is added */<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =3D 0;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =3D 1;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;gfx.config.max_shader_engines;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;gfx.config.max_tile_pipes;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;gfx.config.max_cu_per_sh;<br>
@@ -2678,6 &#43;2678,11 @@ static ssize_t amdgpu_debugfs_gca_config_read(st=
ruct file *f, char __user *buf,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;gfx.config.gb_addr_config;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =
=3D adev-&gt;gfx.config.num_rbs;<br>
&nbsp;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* rev=3D=3D1 */<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =3D ade=
v-&gt;rev_id;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =3D ade=
v-&gt;pg_flags;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; config[no_regs&#43;&#43;] =3D ade=
v-&gt;cg_flags;<br>
&#43;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (size &amp;&amp; (*p=
os &lt; no_regs * 4)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint32_t value;<br>
&nbsp;<br>
-- <br>
2.9.2<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB1132BE10BFA7B652BD16A3E2F7120DM5PR12MB1132namp_--

--===============0702392315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0702392315==--
