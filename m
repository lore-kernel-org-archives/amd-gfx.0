From: "Zhao, Yong" <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdkfd: Fix a bug when calculating
 save_area_used_size
Date: Tue, 12 Nov 2019 21:14:50 +0000
Message-ID: <DM6PR12MB277837E8CD2700465A7AFE1CF0770@DM6PR12MB2778.namprd12.prod.outlook.com>
References: <20191111232521.10528-1-Yong.Zhao@amd.com>,
 <20191111232521.10528-3-Yong.Zhao@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0408743451=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191111232521.10528-3-Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
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
To: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Cornwall, Jay" <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>, "Morichetti, Laurent" <Laurent.Morichetti-5C7GfCeVMHo@public.gmane.org>

--===============0408743451==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM6PR12MB277837E8CD2700465A7AFE1CF0770DM6PR12MB2778namp_"

--_000_DM6PR12MB277837E8CD2700465A7AFE1CF0770DM6PR12MB2778namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

+ Laurent
________________________________
From: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, November 11, 2019 6:25 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; Cornwall=
, Jay <Jay.Cornwall-5C7GfCeVMHo@public.gmane.org>
Cc: Zhao, Yong <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
Subject: [PATCH 3/3] drm/amdkfd: Fix a bug when calculating save_area_used_=
size

workgroup context data writes from m->cp_hqd_cntl_stack_size, so we
should deduct it when calculating the used size.

Change-Id: I5252e25662c3b8221f451c39115bf084d1911eae
Signed-off-by: Yong Zhao <Yong.Zhao-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c
index d3380c5bdbde..3a2ee1f01aae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -302,7 +302,8 @@ static int get_wave_state(struct mqd_manager *mm, void =
*mqd,

         *ctl_stack_used_size =3D m->cp_hqd_cntl_stack_size -
                 m->cp_hqd_cntl_stack_offset;
-       *save_area_used_size =3D m->cp_hqd_wg_state_offset;
+       *save_area_used_size =3D m->cp_hqd_wg_state_offset -
+               m->cp_hqd_cntl_stack_size;;

         if (copy_to_user(ctl_stack, mqd_ctl_stack, m->cp_hqd_cntl_stack_si=
ze))
                 return -EFAULT;
--
2.17.1


--_000_DM6PR12MB277837E8CD2700465A7AFE1CF0770DM6PR12MB2778namp_
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
&#43; Laurent</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhao, Yong &lt;Yong.Z=
hao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, November 11, 2019 6:25 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&=
gt;; Cornwall, Jay &lt;Jay.Cornwall-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Cc:</b> Zhao, Yong &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdkfd: Fix a bug when calculating save_are=
a_used_size</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">workgroup context data writes from m-&gt;cp_hqd_cn=
tl_stack_size, so we<br>
should deduct it when calculating the used size.<br>
<br>
Change-Id: I5252e25662c3b8221f451c39115bf084d1911eae<br>
Signed-off-by: Yong Zhao &lt;Yong.Zhao-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c | 3 &#43;&#43;-<br>
&nbsp;1 file changed, 2 insertions(&#43;), 1 deletion(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/=
drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
index d3380c5bdbde..3a2ee1f01aae 100644<br>
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c<br>
@@ -302,7 &#43;302,8 @@ static int get_wave_state(struct mqd_manager *mm, v=
oid *mqd,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *ctl_stack_used_size =3D m=
-&gt;cp_hqd_cntl_stack_size -<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; m-&gt;cp_hqd_cntl_stack_offset;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *save_area_used_size =3D m-&gt;cp_hqd=
_wg_state_offset;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *save_area_used_size =3D m-&gt;cp=
_hqd_wg_state_offset -<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; m-&gt;cp_hqd_cntl_stack_size;;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (copy_to_user(ctl_stack=
, mqd_ctl_stack, m-&gt;cp_hqd_cntl_stack_size))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return -EFAULT;<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR12MB277837E8CD2700465A7AFE1CF0770DM6PR12MB2778namp_--

--===============0408743451==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0408743451==--
