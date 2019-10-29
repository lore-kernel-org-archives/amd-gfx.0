From: "Wang, Kevin(Yang)" <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm: amd: amdgpu: Remove NULL check not needed before
 freeing functions
Date: Tue, 29 Oct 2019 09:33:14 +0000
Message-ID: <MN2PR12MB329687D0CBC265443C4A667AA2610@MN2PR12MB3296.namprd12.prod.outlook.com>
References: <20191029091943.GA10258@saurav>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0497031002=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <20191029091943.GA10258@saurav>
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
To: Saurav Girepunje <saurav.girepunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "airlied-cv59FeDIM0c@public.gmane.org" <airlied-cv59FeDIM0c@public.gmane.org>, "daniel-/w4YWyX8dFk@public.gmane.org" <daniel-/w4YWyX8dFk@public.gmane.org>, "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "xywang.sjtu-u2tTgNRCH2jM1kAEIRd3EQ@public.gmane.org" <xywang.sjtu-u2tTgNRCH2jM1kAEIRd3EQ@public.gmane.org>, "Xiao, Jack" <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>, "sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org" <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "saurav.girepunje-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org" <saurav.girepunje-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>

--===============0497031002==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB329687D0CBC265443C4A667AA2610MN2PR12MB3296namp_"

--_000_MN2PR12MB329687D0CBC265443C4A667AA2610MN2PR12MB3296namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Saurav,

the driver already has the same fix patch,
you can pull the latest driver tree and check it again,
thanks.

>From 2032324682c1ca563e33c56e51d9ae17a2b38105 Mon Sep 17 00:00:00 2001
From: zhong jiang <zhongjiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Date: Tue, 3 Sep 2019 14:15:05 +0800
Subject: [PATCH] drm/amdgpu: remove the redundant null checks

debugfs_remove and kfree has taken the null check in account.
hence it is unnecessary to check it. Just remove the condition.
No functional change.

This issue was detected by using the Coccinelle software.

Signed-off-by: zhong jiang <zhongjiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>

Best Regards,
Kevin
________________________________
From: Saurav Girepunje <saurav.girepunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sent: Tuesday, October 29, 2019 5:19 PM
To: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Koenig, Christian <Chri=
stian.Koenig-5C7GfCeVMHo@public.gmane.org>; Zhou, David(ChunMing) <David1.Zhou-5C7GfCeVMHo@public.gmane.org>; airlied=
@linux.ie <airlied-cv59FeDIM0c@public.gmane.org>; daniel-/w4YWyX8dFk@public.gmane.org <daniel-/w4YWyX8dFk@public.gmane.org>; StDenis, T=
om <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>; xywang.sjtu-u2tTgNRCH2jM1kAEIRd3EQ@public.gmane.org <xywang.sjtu-u2tTgNRCH2jM1kAEIRd3EQ@public.gmane.org>=
; Xiao, Jack <Jack.Xiao-5C7GfCeVMHo@public.gmane.org>; sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org <sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org>; Wang=
, Kevin(Yang) <Kevin1.Wang-5C7GfCeVMHo@public.gmane.org>; saurav.girepunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <saurav.gir=
epunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp93gSJqDPrsil@public.gmane.org=
.org>; dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>; l=
inux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: saurav.girepunje-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org <saurav.girepunje-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH] drm: amd: amdgpu: Remove NULL check not needed before free=
ing functions

Remove unneeded NULL check before freeing functions
kfree and debugfs_remove.

Signed-off-by: Saurav Girepunje <saurav.girepunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c
index 5652cc72ed3a..cb94627fc0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1077,8 +1077,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 =
val)

         ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);

-       if (fences)
-               kfree(fences);
+       kfree(fences);

         return 0;
 }
@@ -1103,8 +1102,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)

 void amdgpu_debugfs_preempt_cleanup(struct amdgpu_device *adev)
 {
-       if (adev->debugfs_preempt)
-               debugfs_remove(adev->debugfs_preempt);
+       debugfs_remove(adev->debugfs_preempt);
 }

 #else
--
2.20.1


--_000_MN2PR12MB329687D0CBC265443C4A667AA2610MN2PR12MB3296namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Saurav,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
the driver already has the same fix patch,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
you can pull the latest driver tree and check it again,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
thanks.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>From 20=
32324682c1ca563e33c56e51d9ae17a2b38105 Mon Sep 17 00:00:00 2001</i></span><=
span><i><br>
</i></span>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>Fr=
om: zhong jiang &lt;zhongjiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org&gt;</i></span><i><br>
</i></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>Da=
te: Tue, 3 Sep 2019 14:15:05 &#43;0800</i></span><i><br>
</i></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>Su=
bject: [PATCH] drm/amdgpu: remove the redundant null checks</i></span><i><b=
r>
</i></div>
<div><i><br>
</i></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>de=
bugfs_remove and kfree has taken the null check in account.</i></span><i><b=
r>
</i></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>he=
nce it is unnecessary to check it. Just remove the condition.</i></span><i>=
<br>
</i></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>No=
 functional change.</i></span><i><br>
</i></div>
<div><i><br>
</i></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>Th=
is issue was detected by using the Coccinelle software.</i></span><i><br>
</i></div>
<div><i><br>
</i></div>
<div><span style=3D"font-family: &quot;Courier New&quot;, monospace;"><i>Si=
gned-off-by: zhong jiang &lt;zhongjiang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org&gt;</i></span><i><br>
</i></div>
<i><span style=3D"font-family: &quot;Courier New&quot;, monospace;">Signed-=
off-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</span><br>
</i></div>
<i><span></span></i>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: Calibri, Arial, Helvetica,=
 sans-serif; font-size: 12pt;">Best Regards,</span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Kevin</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Saurav Girepunje &lt;=
saurav.girepunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Sent:</b> Tuesday, October 29, 2019 5:19 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;; Zhou, David(ChunMing) &lt;David1.=
Zhou-5C7GfCeVMHo@public.gmane.org&gt;; airlied-cv59FeDIM0c@public.gmane.org &lt;airlied-cv59FeDIM0c@public.gmane.org&gt;; daniel@ffwll.c=
h &lt;daniel-/w4YWyX8dFk@public.gmane.org&gt;; StDenis, Tom &lt;Tom.StDenis-5C7GfCeVMHo@public.gmane.org&gt;;
 xywang.sjtu-u2tTgNRCH2jM1kAEIRd3EQ@public.gmane.org &lt;xywang.sjtu-u2tTgNRCH2jM1kAEIRd3EQ@public.gmane.org&gt;; Xiao, Jack &lt;Ja=
ck.Xiao-5C7GfCeVMHo@public.gmane.org&gt;; sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org &lt;sam-uyr5N9Q2VtJg9hUCZPvPmw@public.gmane.org&gt;; Wang, Kevin=
(Yang) &lt;Kevin1.Wang-5C7GfCeVMHo@public.gmane.org&gt;; saurav.girepunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org &lt;saurav.g=
irepunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org&gt;;
 dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;; l=
inux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org &lt;linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org&gt;<br>
<b>Cc:</b> saurav.girepunje-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org &lt;saurav.girepunje-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org&gt=
;<br>
<b>Subject:</b> [PATCH] drm: amd: amdgpu: Remove NULL check not needed befo=
re freeing functions</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText">Remove unneeded NULL check before freeing function=
s<br>
kfree and debugfs_remove.<br>
<br>
Signed-off-by: Saurav Girepunje &lt;saurav.girepunje-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 &#43;&#43;----<br>
&nbsp;1 file changed, 2 insertions(&#43;), 4 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_debugfs.c<br>
index 5652cc72ed3a..cb94627fc0f4 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
@@ -1077,8 &#43;1077,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, =
u64 val)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_unlock_delayed_work=
queue(&amp;adev-&gt;mman.bdev, resched);<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (fences)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; kfree(fences);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(fences);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
@@ -1103,8 &#43;1102,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *ade=
v)<br>
&nbsp;<br>
&nbsp;void amdgpu_debugfs_preempt_cleanup(struct amdgpu_device *adev)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;debugfs_preempt)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; debugfs_remove(adev-&gt;debugfs_preempt);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; debugfs_remove(adev-&gt;debugfs_p=
reempt);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;#else<br>
-- <br>
2.20.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_MN2PR12MB329687D0CBC265443C4A667AA2610MN2PR12MB3296namp_--

--===============0497031002==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============0497031002==--
