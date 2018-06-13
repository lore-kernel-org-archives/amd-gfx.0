From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Partially revert commit 2dc80b006
Date: Wed, 13 Jun 2018 14:39:51 +0000
Message-ID: <CY4PR12MB1687387C53D92564048587ECFB7E0@CY4PR12MB1687.namprd12.prod.outlook.com>
References: <1528890013-23490-1-git-send-email-Rex.Zhu@amd.com>
 <6526fa0b-474e-102c-6577-5723427970a9@gmail.com>,
 <CABE_ZV06N+_JcnqJMU=78DKNwGMwxpEsg7Tr0Xgw0x=-hyc6bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0731521392=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CABE_ZV06N+_JcnqJMU=78DKNwGMwxpEsg7Tr0Xgw0x=-hyc6bw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0731521392==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1687387C53D92564048587ECFB7E0CY4PR12MB1687namp_"

--_000_CY4PR12MB1687387C53D92564048587ECFB7E0CY4PR12MB1687namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jan,


Thanks for your suggestion. Obvious the patch title was inappropriate. I wi=
ll update it.

In fact, I originally plan to send this patch internally for discussion.  S=
o just thought that "Revert xxxxx" can cause the attention.

Best Regards
Rex




________________________________
From: jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org <jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org> on beha=
lf of Jan Vesely <jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org>
Sent: Wednesday, June 13, 2018 9:30 PM
To: Koenig, Christian
Cc: Zhu, Rex; amd-gfx list
Subject: Re: [PATCH] drm/amdgpu: Partially revert commit 2dc80b006

Hi,

can you please improve the commit message?
seeing "Revert $HASH" conveys zero information about the code change.
I'm sorry for bringing this up again, but following AMDGPU/Radeon driver de=
velopment is an exercise in frustration for anyone who is not on AMD's payr=
oll.
git commit logs like:
"revert XYZ" or "fix bug #123" make it really cumbersome to actually look a=
t history and pick interesting/breaking commits.

thanks,
Jan

On Wed, Jun 13, 2018 at 8:46 AM, Christian K=F6nig <ckoenig.leichtzumerken@=
gmail.com<mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
Am 13.06.2018 um 13:40 schrieb Rex Zhu:
Move the CG enablement out of delay worker thread.

1. CG/PG enablement are part of gpu hw ip initialize, we should
wait for them complete. otherwise, there are some potential conflicts,
for example, Suspend and CG enablement concurrently.
2. better run ib test after hw initialize completely. That is to say,
    ib test should be after CG/PG enablement. otherwise, the test will
    not cover the cg/pg/poweroff enable case.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org<mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org>>

Yeah, that thought came to my mind as well.

Essentially the IB test should simulate a submission from userspace to make=
 sure that the stack is working as expected. I think it was just moved befo=
re CG/PG to avoid issues with that, which is actually not very clever.

Patch is Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org<mailto:ch=
ristian.koenig-5C7GfCeVMHo@public.gmane.org>>, but there could be some fallout we could need to =
deal with.

Thanks,
Christian.


---
  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++------
  1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_device.c
index 9647f54..90b78c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1709,10 +1709,6 @@ static int amdgpu_device_ip_late_set_cg_state(struct=
 amdgpu_device *adev)
        if (amdgpu_emu_mode =3D=3D 1)
                return 0;
  -     r =3D amdgpu_ib_ring_tests(adev);
-       if (r)
-               DRM_ERROR("ib ring test failed (%d).\n", r);
-
        for (i =3D 0; i < adev->num_ip_blocks; i++) {
                if (!adev->ip_blocks[i].status.va<http://status.va>lid)
                        continue;
@@ -1793,6 +1789,9 @@ static int amdgpu_device_ip_late_init(struct amdgpu_d=
evice *adev)
                }
        }
  +     amdgpu_device_ip_late_set_cg_state(adev);
+       amdgpu_device_ip_late_set_pg_state(adev);
+
        queue_delayed_work(system_wq, &adev->late_init_work,
                           msecs_to_jiffies(AMDGPU_RESUME_MS));
  @@ -1921,8 +1920,11 @@ static void amdgpu_device_ip_late_init_func_handle=
r(struct work_struct *work)
  {
        struct amdgpu_device *adev =3D
                container_of(work, struct amdgpu_device, late_init_work.wor=
k<http://late_init_work.work>);
-       amdgpu_device_ip_late_set_cg_state(adev);
-       amdgpu_device_ip_late_set_pg_state(adev);
+       int r;
+
+       r =3D amdgpu_ib_ring_tests(adev);
+       if (r)
+               DRM_ERROR("ib ring test failed (%d).\n", r);
  }
    /**

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--_000_CY4PR12MB1687387C53D92564048587ECFB7E0CY4PR12MB1687namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Hi Jan,</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
Thanks for your suggestion. Obvious the patch title was i<span>nappropriate=
. I will update it.</span>
<div><br>
<span></span>
<div>In fact,&nbsp;I originally plan to send this patch internally for disc=
ussion. &nbsp;So just thought that &quot;Revert xxxxx&quot; can cause the a=
ttention.</div>
<div><br>
</div>
<div>Best Regards</div>
<div>Rex</div>
<div><br>
<span></span>
<div><br>
</div>
<div><br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> jv356-nChP9VK/LTosYFrO62B2KA@public.gmane.org=
gers.edu &lt;jv356-nChP9VK/LToysehGhLVACCmkPJUwDNjP@public.gmane.org&gt; on behalf of Jan Vesely &lt;=
jan.vesely-kgbqMDwikbSVc3sceRu5cw@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, June 13, 2018 9:30 PM<br>
<b>To:</b> Koenig, Christian<br>
<b>Cc:</b> Zhu, Rex; amd-gfx list<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Partially revert commit 2dc80b006</=
font>
<div>&nbsp;</div>
</div>
<meta content=3D"text/html; charset=3Dutf-8">
<div>
<div dir=3D"ltr">Hi,
<div><br>
</div>
<div>can you please improve the commit message?</div>
<div>seeing &quot;Revert $HASH&quot; conveys zero information about the cod=
e change.</div>
<div>I'm sorry for bringing this up again, but following AMDGPU/Radeon driv=
er development is an exercise in frustration for anyone who is not on AMD's=
 payroll.</div>
<div>git commit logs like:</div>
<div>&quot;revert XYZ&quot; or &quot;fix bug #123&quot; make it really cumb=
ersome to actually look at history and pick interesting/breaking commits.</=
div>
<div><br>
</div>
<div>thanks,</div>
<div>Jan</div>
</div>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">On Wed, Jun 13, 2018 at 8:46 AM, Christian K=
=F6nig <span dir=3D"ltr">
&lt;<a href=3D"mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target=3D"_blank" i=
d=3D"LPlnk23845" class=3D"OWAAutoLink" previewremoved=3D"true">ckoenig.leic=
htzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span> wrote:<br>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
<span class=3D"">Am 13.06.2018 um 13:40 schrieb Rex Zhu:<br>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
Move the CG enablement out of delay worker thread.<br>
<br>
1. CG/PG enablement are part of gpu hw ip initialize, we should<br>
wait for them complete. otherwise, there are some potential conflicts,<br>
for example, Suspend and CG enablement concurrently.<br>
2. better run ib test after hw initialize completely. That is to say,<br>
&nbsp; &nbsp; ib test should be after CG/PG enablement. otherwise, the test=
 will<br>
&nbsp; &nbsp; not cover the cg/pg/poweroff enable case.<br>
<br>
Signed-off-by: Rex Zhu &lt;<a href=3D"mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org" target=3D"_bl=
ank" id=3D"LPlnk396741" class=3D"OWAAutoLink" previewremoved=3D"true">Rex.Z=
hu-5C7GfCeVMHo@public.gmane.org</a>&gt;<br>
</blockquote>
<br>
</span>Yeah, that thought came to my mind as well.<br>
<br>
Essentially the IB test should simulate a submission from userspace to make=
 sure that the stack is working as expected. I think it was just moved befo=
re CG/PG to avoid issues with that, which is actually not very clever.<br>
<br>
Patch is Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koe=
nig-5C7GfCeVMHo@public.gmane.org" target=3D"_blank" id=3D"LPlnk442308" class=3D"OWAAutoLink" pre=
viewremoved=3D"true">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;, but there could be s=
ome fallout we could need to deal with.<br>
<br>
Thanks,<br>
Christian.
<div class=3D"x_HOEnZb">
<div class=3D"x_h5"><br>
<br>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0 0 0 .8ex; border-left=
:1px #ccc solid; padding-left:1ex">
---<br>
&nbsp; drivers/gpu/drm/amd/amdgpu/amd<wbr>gpu_device.c | 14 &#43;&#43;&#43;=
&#43;&#43;&#43;&#43;&#43;------<br>
&nbsp; 1 file changed, 8 insertions(&#43;), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c b/drivers/gpu/=
drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
index 9647f54..90b78c7 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/a<wbr>mdgpu_device.c<br>
@@ -1709,10 &#43;1709,6 @@ static int amdgpu_device_ip_late_set_cg_s<wbr>ta=
te(struct amdgpu_device *adev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; if (amdgpu_emu_mode =3D=3D 1)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return 0;<br>
&nbsp; -&nbsp; &nbsp; &nbsp;r =3D amdgpu_ib_ring_tests(adev);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;if (r)<br>
-&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DRM_ERROR(&quot;ib =
ring test failed (%d).\n&quot;, r);<br>
-<br>
&nbsp; &nbsp; &nbsp; &nbsp; for (i =3D 0; i &lt; adev-&gt;num_ip_blocks; i&=
#43;&#43;) {<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (!adev-&gt;ip_bl=
ocks[i].<a href=3D"http://status.va" id=3D"LPlnk710404" class=3D"OWAAutoLin=
k" previewremoved=3D"true">status.va</a><wbr>lid)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; continue;<br>
@@ -1793,6 &#43;1789,9 @@ static int amdgpu_device_ip_late_init(str<wbr>uct=
 amdgpu_device *adev)<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp; &nbsp; &nbsp; &nbsp; }<br>
&nbsp; &#43;&nbsp; &nbsp; &nbsp;amdgpu_device_ip_late_set_cg_<wbr>state(ade=
v);<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_device_ip_late_set_pg_<wbr>state(ade=
v);<br>
&#43;<br>
&nbsp; &nbsp; &nbsp; &nbsp; queue_delayed_work(system_wq, &amp;adev-&gt;lat=
e_init_work,<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp=
; &nbsp; &nbsp; &nbsp;msecs_to_jiffies(AMDGPU_RESUM<wbr>E_MS));<br>
&nbsp; @@ -1921,8 &#43;1920,11 @@ static void amdgpu_device_ip_late_init_fu=
n<wbr>c_handler(struct work_struct *work)<br>
&nbsp; {<br>
&nbsp; &nbsp; &nbsp; &nbsp; struct amdgpu_device *adev =3D<br>
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; container_of(work, =
struct amdgpu_device, <a href=3D"http://late_init_work.work" rel=3D"norefer=
rer" target=3D"_blank" id=3D"LPlnk420709" class=3D"OWAAutoLink" previewremo=
ved=3D"true">
late_init_work.work</a>);<br>
-&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_device_ip_late_set_cg_<wbr>state(adev);<=
br>
-&nbsp; &nbsp; &nbsp; &nbsp;amdgpu_device_ip_late_set_pg_<wbr>state(adev);<=
br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp;int r;<br>
&#43;<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp;r =3D amdgpu_ib_ring_tests(adev);<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp;if (r)<br>
&#43;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;DRM_ERROR(&quot=
;ib ring test failed (%d).\n&quot;, r);<br>
&nbsp; }<br>
&nbsp; &nbsp; /**<br>
</blockquote>
<br>
</div>
</div>
<div class=3D"x_HOEnZb">
<div class=3D"x_h5">______________________________<wbr>_________________<br=
>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target=3D"_blank" id=3D"LP=
lnk537513" class=3D"OWAAutoLink" previewremoved=3D"true">amd-gfx-PD4FTy7X32mptlylMvRsHA@public.gmane.org=
desktop.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" rel=3D"n=
oreferrer" target=3D"_blank" id=3D"LPlnk798304" class=3D"OWAAutoLink" previ=
ewremoved=3D"true">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-=
gfx</a><br>
</div>
</div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1687387C53D92564048587ECFB7E0CY4PR12MB1687namp_--

--===============0731521392==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0731521392==--
