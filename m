From: "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma'
 workaround for navi
Date: Thu, 26 Sep 2019 18:02:23 +0000
Message-ID: <6c2ee5a6-8283-4b36-9177-36ddb22a60ad@email.android.com>
References: <93f9508c-2871-4d48-9407-a0c3a6525bab@email.android.com>,
 <BN8PR12MB3602A7F8546E1C581D47B38B89860@BN8PR12MB3602.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1396212037=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN8PR12MB3602A7F8546E1C581D47B38B89860-h6+T2+wrnx1lGJ5xs4l7kQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
Content-Language: de-DE
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
To: "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher,
 Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============1396212037==
Content-Language: de-DE
Content-Type: multipart/alternative;
	boundary="_000_6c2ee5a682834b36917736ddb22a60ademailandroidcom_"

--_000_6c2ee5a682834b36917736ddb22a60ademailandroidcom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Well then you didn't figured out the root cause correctly.

This is to avoid data corruption with the SDMA on Navi 10/14 and should def=
initely not applied to Navi 12.

The hardware team went through quite some work to avoid this.

Christian.

Am 26.09.2019 19:38 schrieb "Yuan, Xiaojie" <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>:
 Hi Alex / Christian,

When gfxoff is enabled for Navi12, I observed sdma0 hang while launching de=
sktop. When this workaround is applied, the issue fades away.
That's why I included this workaround for Navi12 as well.

BR,
Xiaojie
________________________________
From: Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Sent: Thursday, September 26, 2019 10:20 PM
To: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Deucher, Alexander <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>; Yuan, Xiaojie <Xiaojie.=
Yuan-5C7GfCeVMHo@public.gmane.org>; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org=
>
Subject: Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma' w=
orkaround for navi



Am 26.09.2019 15:51 schrieb Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
On Thu, Sep 26, 2019 at 9:47 AM Koenig, Christian
<Christian.Koenig-5C7GfCeVMHo@public.gmane.org> wrote:
>
> Am 26.09.19 um 15:40 schrieb Alex Deucher:
> > On Thu, Sep 26, 2019 at 8:29 AM Christian K=F6nig
> > <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >> Stop, wait a second guys!
> >>
> >> This will disable the workaround for Navi10 and that is certainly not =
correct:
> >>
> >> !(adev->asic_type >=3D CHIP_NAVI10 && adev->asic_type <=3D CHIP_NAVI12=
)
> >>
> > Actually, I think it's correct. When I merged the baco patch, I
> > accidentally dropped the navi checks.  E.g.,
> > @@ -245,8 +245,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct
> > amdgpu_device *adev,
> >          mutex_lock(&adev->mman.gtt_window_lock);
> >
> >          gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB, 0);
> > -       if (!adev->mman.buffer_funcs_enabled || !adev->ib_pool_ready ||
> > -           adev->asic_type !=3D CHIP_NAVI10) {
> > +       if (!adev->mman.buffer_funcs_enabled ||
> > +           !adev->ib_pool_ready ||
> > +           adev->in_gpu_reset) {
> >                  gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB, 0);
> >                  mutex_unlock(&adev->mman.gtt_window_lock);
> >                  return;
> > I think it should have been
> > adev->asic_type !=3D CHIP_NAVI10 && adev->asic_type !=3D CHIP_NAVI14 &&
> > adev->asic_type !=3D CHIP_NAVI12
>
> My last status is that Navi12 is not supposed to need that workaround,
> that's why we checked Navi10 and later Navi14 separately.
>
> It's possible that I miss-read the !(adev->asic_type >=3D CHIP_NAVI10 &&
> adev->asic_type <=3D CHIP_NAVI12) check here, but either way that looks t=
o
> complicated to me.
>
> We should rather mention every affected asic type separately here.

Good point.  navi12 should be dropped from the check.  How about the follow=
ing?

I would rather test explicitly for Navi 10 and 14, cause we can't be sure i=
f there won't be another variant in the future.

Christian.


diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 241a4e57cf4a..280bbd7ca8a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -292,7 +292,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct
amdgpu_device *adev, uint32_t vmid,

        if (!adev->mman.buffer_funcs_enabled ||
            !adev->ib_pool_ready ||
-           adev->in_gpu_reset) {
+           adev->in_gpu_reset ||
+           (adev->asic_type =3D=3D CHIP_NAVI12)) {
                gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);
                mutex_unlock(&adev->mman.gtt_window_lock);
                return;

Alex

>
> Regards,
> Christian.
>
> >
> > Alex
> >
> >> Christian.
> >>
> >>
> >> Am 26.09.19 um 14:26 schrieb Deucher, Alexander:
> >>
> >> Please add a patch description.  With that fixed:
> >> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> >> ________________________________
> >> From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Yua=
n, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
> >> Sent: Thursday, September 26, 2019 4:09 AM
> >> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> >> Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> Subject: Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sd=
ma' workaround for navi
> >>
> >> Hi Alex,
> >>
> >> This patch is to add the asic_type check which is missing after drm-ne=
xt branch rebase.
> >>
> >> BR,
> >> Xiaojie
> >> ________________________________
> >> From: Yuan, Xiaojie <Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org>
> >> Sent: Thursday, September 26, 2019 4:08 PM
> >> To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> >> Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; Yuan, Xiaojie <Xiao=
jie.Yuan-5C7GfCeVMHo@public.gmane.org>
> >> Subject: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from sdma' =
workaround for navi
> >>
> >> Fixes: 767acabdac81 ("drm/amd/powerplay: add baco smu reset function f=
or smu11")
> >> Signed-off-by: Xiaojie Yuan <xiaojie.yuan-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v10_0.c
> >> index cb3f61873baa..dc2e68e019eb 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> >> @@ -292,6 +292,7 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_=
device *adev, uint32_t vmid,
> >>
> >>           if (!adev->mman.buffer_funcs_enabled ||
> >>               !adev->ib_pool_ready ||
> >> +           !(adev->asic_type >=3D CHIP_NAVI10 && adev->asic_type <=3D=
 CHIP_NAVI12) ||
> >>               adev->in_gpu_reset) {
> >>                   gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, =
0);
> >>                   mutex_unlock(&adev->mman.gtt_window_lock);
> >> --
> >> 2.20.1
> >>
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >>
> >>
>


--_000_6c2ee5a682834b36917736ddb22a60ademailandroidcom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta content=3D"text/html; charset=3Diso-8859-1">
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
</head>
<body dir=3D"ltr">
<div dir=3D"auto">Well then you didn't figured out the root cause correctly=
.
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">This is to avoid data corruption with the SDMA on Navi 10=
/14 and should definitely not applied to Navi 12.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">The hardware team went through quite some work to avoid t=
his.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
</div>
<div class=3D"gmail_extra"><br>
<div class=3D"gmail_quote">Am 26.09.2019 19:38 schrieb &quot;Yuan, Xiaojie&=
quot; &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;:<br type=3D"attribution">
</div>
</div>
<div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; col=
or:rgb(0,0,0)">
&nbsp;Hi Alex / Christian,</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; col=
or:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; col=
or:rgb(0,0,0)">
When gfxoff is enabled for Navi12, I observed sdma0 hang while launching de=
sktop. When this workaround is applied, the issue fades away.</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; col=
or:rgb(0,0,0)">
That's why I included this workaround for Navi12 as well.<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; col=
or:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; col=
or:rgb(0,0,0)">
BR,</div>
<div style=3D"font-family:Calibri,Helvetica,sans-serif; font-size:11pt; col=
or:rgb(0,0,0)">
Xiaojie<br>
</div>
<div id=3D"appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Koenig, Christian &lt=
;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;<br>
<b>Sent:</b> Thursday, September 26, 2019 10:20 PM<br>
<b>To:</b> Alex Deucher &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher-5C7GfCeVMHo@public.gmane.org&gt;; Yuan, Xiao=
jie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx=
@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation from =
sdma' workaround for navi</font>
<div>&nbsp;</div>
</div>
<div>
<div dir=3D"auto">
<div><br>
<div class=3D"x_gmail_extra"><br>
<div class=3D"x_gmail_quote">Am 26.09.2019 15:51 schrieb Alex Deucher &lt;a=
lexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;:<br type=3D"attribution">
<blockquote class=3D"x_quote" style=3D"margin:0 0 0 .8ex; border-left:1px #=
ccc solid; padding-left:1ex">
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div>On Thu, Sep 26, 2019 at 9:47 AM Koenig, Christian<br>
&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt; wrote:<br>
&gt;<br>
&gt; Am 26.09.19 um 15:40 schrieb Alex Deucher:<br>
&gt; &gt; On Thu, Sep 26, 2019 at 8:29 AM Christian K=F6nig<br>
&gt; &gt; &lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt; wrote:<br>
&gt; &gt;&gt; Stop, wait a second guys!<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This will disable the workaround for Navi10 and that is certa=
inly not correct:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; !(adev-&gt;asic_type &gt;=3D CHIP_NAVI10 &amp;&amp; adev-&gt;=
asic_type &lt;=3D CHIP_NAVI12)<br>
&gt; &gt;&gt;<br>
&gt; &gt; Actually, I think it's correct. When I merged the baco patch, I<b=
r>
&gt; &gt; accidentally dropped the navi checks.&nbsp; E.g.,<br>
&gt; &gt; @@ -245,8 &#43;245,9 @@ static void gmc_v10_0_flush_gpu_tlb(struc=
t<br>
&gt; &gt; amdgpu_device *adev,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(=
&amp;adev-&gt;mman.gtt_window_lock);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v10_0_f=
lush_vm_hub(adev, vmid, AMDGPU_MMHUB, 0);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_f=
uncs_enabled || !adev-&gt;ib_pool_ready ||<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ade=
v-&gt;asic_type !=3D CHIP_NAVI10) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buff=
er_funcs_enabled ||<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 !adev-&gt;ib_pool_ready ||<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 adev-&gt;in_gpu_reset) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v10_0_flush_vm_hub(adev, vmid, AMD=
GPU_GFXHUB, 0);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;mman.gtt_wi=
ndow_lock);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; I think it should have been<br>
&gt; &gt; adev-&gt;asic_type !=3D CHIP_NAVI10 &amp;&amp; adev-&gt;asic_type=
 !=3D CHIP_NAVI14 &amp;&amp;<br>
&gt; &gt; adev-&gt;asic_type !=3D CHIP_NAVI12<br>
&gt;<br>
&gt; My last status is that Navi12 is not supposed to need that workaround,=
<br>
&gt; that's why we checked Navi10 and later Navi14 separately.<br>
&gt;<br>
&gt; It's possible that I miss-read the !(adev-&gt;asic_type &gt;=3D CHIP_N=
AVI10 &amp;&amp;<br>
&gt; adev-&gt;asic_type &lt;=3D CHIP_NAVI12) check here, but either way tha=
t looks to<br>
&gt; complicated to me.<br>
&gt;<br>
&gt; We should rather mention every affected asic type separately here.<br>
<br>
Good point.&nbsp; navi12 should be dropped from the check.&nbsp; How about =
the following?<br>
</div>
</span></font></div>
</blockquote>
</div>
</div>
</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">I would rather test explicitly for Navi 10 and 14, cause =
we can't be sure if there won't be another variant in the future.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">Christian.</div>
<div dir=3D"auto"><br>
</div>
<div dir=3D"auto">
<div class=3D"x_gmail_extra">
<div class=3D"x_gmail_quote">
<blockquote class=3D"x_quote" style=3D"margin:0 0 0 .8ex; border-left:1px #=
ccc solid; padding-left:1ex">
<div><font size=3D"2"><span style=3D"font-size:11pt">
<div><br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
index 241a4e57cf4a..280bbd7ca8a0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
@@ -292,7 &#43;292,8 @@ static void gmc_v10_0_flush_gpu_tlb(struct<br>
amdgpu_device *adev, uint32_t vmid,<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;mman.buffer_funcs_=
enabled ||<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !adev-&g=
t;ib_pool_ready ||<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_g=
pu_reset) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;=
in_gpu_reset ||<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (adev-&gt=
;asic_type =3D=3D CHIP_NAVI12)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB_0, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;mman.gtt_window_lock);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; return;<br>
<br>
Alex<br>
<br>
&gt;<br>
&gt; Regards,<br>
&gt; Christian.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; Alex<br>
&gt; &gt;<br>
&gt; &gt;&gt; Christian.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Am 26.09.19 um 14:26 schrieb Deucher, Alexander:<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Please add a patch description.&nbsp; With that fixed:<br>
&gt; &gt;&gt; Reviewed-by: Alex Deucher &lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;<b=
r>
&gt; &gt;&gt; ________________________________<br>
&gt; &gt;&gt; From: amd-gfx &lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; o=
n behalf of Yuan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;&gt; Sent: Thursday, September 26, 2019 4:09 AM<br>
&gt; &gt;&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org&gt;<br>
&gt; &gt;&gt; Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH] drm/amdgpu/gmc10: apply the 'invalidatio=
n from sdma' workaround for navi<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Hi Alex,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; This patch is to add the asic_type check which is missing aft=
er drm-next branch rebase.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; BR,<br>
&gt; &gt;&gt; Xiaojie<br>
&gt; &gt;&gt; ________________________________<br>
&gt; &gt;&gt; From: Yuan, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;&gt; Sent: Thursday, September 26, 2019 4:08 PM<br>
&gt; &gt;&gt; To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org &lt;amd-gfx-PD4FTy7X32nrcLQh/DF6ew@public.gmane.org=
op.org&gt;<br>
&gt; &gt;&gt; Cc: alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;; Yuan=
, Xiaojie &lt;Xiaojie.Yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;&gt; Subject: [PATCH] drm/amdgpu/gmc10: apply the 'invalidation fr=
om sdma' workaround for navi<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Fixes: 767acabdac81 (&quot;drm/amd/powerplay: add baco smu re=
set function for smu11&quot;)<br>
&gt; &gt;&gt; Signed-off-by: Xiaojie Yuan &lt;xiaojie.yuan-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 1 &#43;<=
br>
&gt; &gt;&gt;&nbsp;&nbsp; 1 file changed, 1 insertion(&#43;)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers=
/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; &gt;&gt; index cb3f61873baa..dc2e68e019eb 100644<br>
&gt; &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; &gt;&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c<br>
&gt; &gt;&gt; @@ -292,6 &#43;292,7 @@ static void gmc_v10_0_flush_gpu_tlb(s=
truct amdgpu_device *adev, uint32_t vmid,<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (!adev-&gt;mman.buffer_funcs_enabled ||<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; !adev-&gt;ib_pool_ready ||<br>
&gt; &gt;&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; !(adev-&gt;asic_type &gt;=3D CHIP_NAVI10 &amp;&amp; adev-&gt;asic_type=
 &lt;=3D CHIP_NAVI12) ||<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; adev-&gt;in_gpu_reset) {<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gmc_v10_0_flush_vm_hub(adev,=
 vmid, AMDGPU_GFXHUB_0, 0);<br>
&gt; &gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock(&amp;adev-&gt;m=
man.gtt_window_lock);<br>
&gt; &gt;&gt; --<br>
&gt; &gt;&gt; 2.20.1<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; _______________________________________________<br>
&gt; &gt;&gt; amd-gfx mailing list<br>
&gt; &gt;&gt; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
&gt; &gt;&gt; <a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd=
-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;<br>
&gt;<br>
</div>
</span></font></div>
</blockquote>
</div>
<br>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_6c2ee5a682834b36917736ddb22a60ademailandroidcom_--

--===============1396212037==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1396212037==--
