From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 4/6] drm/amdgpu: implement PRT for GFX6
Date: Mon, 30 Jan 2017 14:15:59 +0000
Message-ID: <CY4PR12MB1768D597CD5AA969E892F02FF74B0@CY4PR12MB1768.namprd12.prod.outlook.com>
References: <1485781060-1910-1-git-send-email-deathsimple@vodafone.de>
 <1485781060-1910-5-git-send-email-deathsimple@vodafone.de>
 <CY4PR12MB1768231152C68AFABF76535AF74B0@CY4PR12MB1768.namprd12.prod.outlook.com>,
 <fc54cc73-6b75-59b3-f67a-9a395d749e23@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0222655619=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <fc54cc73-6b75-59b3-f67a-9a395d749e23-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org" <bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>, "airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============0222655619==
Content-Language: en-US
Content-Type: multipart/related;
	boundary="_004_CY4PR12MB1768D597CD5AA969E892F02FF74B0CY4PR12MB1768namp_";
	type="multipart/alternative"

--_004_CY4PR12MB1768D597CD5AA969E892F02FF74B0CY4PR12MB1768namp_
Content-Type: multipart/alternative;
	boundary="_000_CY4PR12MB1768D597CD5AA969E892F02FF74B0CY4PR12MB1768namp_"

--_000_CY4PR12MB1768D597CD5AA969E892F02FF74B0CY4PR12MB1768namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Christian,


I have SI,CI,VI gear in my office if you have a unit test to try it with.


Cheers,

Tom


________________________________
From: Christian K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Monday, January 30, 2017 09:14
To: StDenis, Tom; bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org; airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 4/6] drm/amdgpu: implement PRT for GFX6

The changes to the GFX6/7/8 look reasonable though only question is you rea=
d from mmVM_PRT_CNTL and then write to mmVM_CONTEXT1_CNTL .  Is that expect=
ed?
Not at all! Looks like a copy&paste error while modifying the original patc=
h. Thanks for catching this.

Also the whole set is so far only compile tested, still need to give it a r=
un on all hardware generations anyway.

Christian.

Am 30.01.2017 um 14:59 schrieb StDenis, Tom:

Minor nit: the comment says v8 [??]


The changes to the GFX6/7/8 look reasonable though only question is you rea=
d from mmVM_PRT_CNTL and then write to mmVM_CONTEXT1_CNTL .  Is that expect=
ed?


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Christian K=F6nig <deathsimple@vodafo=
ne.de><mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Monday, January 30, 2017 07:57
To: bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org<mailto:bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org>; airlied@gmail.=
com<mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Subject: [PATCH 4/6] drm/amdgpu: implement PRT for GFX6

From: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christian.koenig@=
amd.com>

Enable/disable the handling globally for now and
print a warning when we enable it for the first time.

Signed-off-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christia=
n.koenig-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 63 +++++++++++++++++++++++++++++++=
++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v6_0.c
index e2b0b16..c23503e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -398,6 +398,68 @@ static void gmc_v6_0_set_fault_enable_default(struct a=
mdgpu_device *adev,
         WREG32(mmVM_CONTEXT1_CNTL, tmp);
 }

+ /**
+   + * gmc_v8_0_set_prt - set PRT VM fault
+   + *
+   + * @adev: amdgpu_device pointer
+   + * @enable: enable/disable VM fault handling for PRT
+   +*/
+static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)
+{
+       u32 tmp;
+
+       if (enable && !adev->mc.prt_warning) {
+               dev_warn(adev->dev, "Disabling VM faults because of PRT req=
uest!\n");
+               adev->mc.prt_warning =3D true;
+       }
+
+       tmp =3D RREG32(mmVM_PRT_CNTL);
+       tmp =3D REG_SET_FIELD(tmp, VM_PRT_CNTL,
+                           CB_DISABLE_READ_FAULT_ON_UNMAPPED_ACCESS,
+                           enable);
+       tmp =3D REG_SET_FIELD(tmp, VM_PRT_CNTL,
+                           CB_DISABLE_WRITE_FAULT_ON_UNMAPPED_ACCESS,
+                           enable);
+       tmp =3D REG_SET_FIELD(tmp, VM_PRT_CNTL,
+                           TC_DISABLE_READ_FAULT_ON_UNMAPPED_ACCESS,
+                           enable);
+       tmp =3D REG_SET_FIELD(tmp, VM_PRT_CNTL,
+                           TC_DISABLE_WRITE_FAULT_ON_UNMAPPED_ACCESS,
+                           enable);
+       tmp =3D REG_SET_FIELD(tmp, VM_PRT_CNTL,
+                           L2_CACHE_STORE_INVALID_ENTRIES,
+                           enable);
+       tmp =3D REG_SET_FIELD(tmp, VM_PRT_CNTL,
+                           L1_TLB_STORE_INVALID_ENTRIES,
+                           enable);
+       tmp =3D REG_SET_FIELD(tmp, VM_PRT_CNTL,
+                           MASK_PDE0_FAULT, enable);
+       WREG32(mmVM_CONTEXT1_CNTL, tmp);
+
+       if (enable) {
+               uint32_t low =3D AMDGPU_VA_RESERVED_SIZE >> AMDGPU_GPU_PAGE=
_SHIFT;
+               uint32_t high =3D adev->vm_manager.max_pfn;
+
+               WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);
+               WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);
+               WREG32(mmVM_PRT_APERTURE2_LOW_ADDR, low);
+               WREG32(mmVM_PRT_APERTURE3_LOW_ADDR, low);
+               WREG32(mmVM_PRT_APERTURE0_HIGH_ADDR, high);
+               WREG32(mmVM_PRT_APERTURE1_HIGH_ADDR, high);
+               WREG32(mmVM_PRT_APERTURE2_HIGH_ADDR, high);
+               WREG32(mmVM_PRT_APERTURE3_HIGH_ADDR, high);
+       } else {
+               WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, 0xfffffff);
+               WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, 0xfffffff);
+               WREG32(mmVM_PRT_APERTURE2_LOW_ADDR, 0xfffffff);
+               WREG32(mmVM_PRT_APERTURE3_LOW_ADDR, 0xfffffff);
+               WREG32(mmVM_PRT_APERTURE0_HIGH_ADDR, 0x0);
+               WREG32(mmVM_PRT_APERTURE1_HIGH_ADDR, 0x0);
+               WREG32(mmVM_PRT_APERTURE2_HIGH_ADDR, 0x0);
+               WREG32(mmVM_PRT_APERTURE3_HIGH_ADDR, 0x0);
+       }
+}
+
 static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)
 {
         int r, i;
@@ -1080,6 +1142,7 @@ static const struct amd_ip_funcs gmc_v6_0_ip_funcs =
=3D {
 static const struct amdgpu_gart_funcs gmc_v6_0_gart_funcs =3D {
         .flush_gpu_tlb =3D gmc_v6_0_gart_flush_gpu_tlb,
         .set_pte_pde =3D gmc_v6_0_gart_set_pte_pde,
+       .set_prt =3D gmc_v6_0_set_prt,
 };

 static const struct amdgpu_irq_src_funcs gmc_v6_0_irq_funcs =3D {
--
2.5.0

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
amd-gfx Info Page - lists.freedesktop.org<https://lists.freedesktop.org/mai=
lman/listinfo/amd-gfx>
lists.freedesktop.org
To see the collection of prior postings to the list, visit the amd-gfx Arch=
ives. Using amd-gfx: To post a message to all the list members, send email =
...





--_000_CY4PR12MB1768D597CD5AA969E892F02FF74B0CY4PR12MB1768namp_
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
-family:Calibri,Arial,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hi Christian,</p>
<p><br>
</p>
<p>I have SI,CI,VI gear in my office if you have a unit test to try it with=
.</p>
<p><br>
</p>
<p>Cheers,</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &lt=
;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Monday, January 30, 2017 09:14<br>
<b>To:</b> StDenis, Tom; bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org; airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org<br>
<b>Cc:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<br>
<b>Subject:</b> Re: [PATCH 4/6] drm/amdgpu: implement PRT for GFX6</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">
<blockquote type=3D"cite">The changes to the GFX6/7/8 look reasonable thoug=
h only question is you read from
<span style=3D"">mmVM_PRT_CNTL</span>&nbsp;and then write to <span style=3D=
"">mmVM_CONTEXT1_CNTL</span>&nbsp;. &nbsp;Is that expected?</blockquote>
Not at all! Looks like a copy&amp;paste error while modifying the original =
patch. Thanks for catching this.<br>
<br>
Also the whole set is so far only compile tested, still need to give it a r=
un on all hardware generations anyway.<br>
<br>
Christian.<br>
<br>
Am 30.01.2017 um 14:59 schrieb StDenis, Tom:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Minor nit: the comment says v8 <img naturalheight=3D"19" naturalwidth=3D=
"19" class=3D"EmojiInsert" id=3D"OWAEmoji249760" alt=3D"&#55357;&#56842;" s=
tyle=3D"vertical-align:bottom" src=3D"cid:part1.A7DC9569.EFDA65F4@vodafone.=
de"></p>
<p><br>
</p>
<p>The changes to the GFX6/7/8 look reasonable though only question is you =
read from
<span style=3D"">mmVM_PRT_CNTL</span>&nbsp;and then write to <span style=3D=
"">mmVM_CONTEXT1_CNTL</span>&nbsp;. &nbsp;Is that expected?</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color:rgb(0,0,0)">
<div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font color=3D"#000000" face=3D"Cal=
ibri,=0A=
                sans-serif" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces-PD4FTy7X32mzQB+pC5nmwQ@public.gmane.org=
edesktop.org">
&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf of Christian K=
=F6nig <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:deathsimple@vodafo=
ne.de">
&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
<b>Sent:</b> Monday, January 30, 2017 07:57<br>
<b>To:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:bas@basnieu=
wenhuizen.nl">
bas-dldO88ZXqoXqqjsSq9zF6IRWq/SkRNHw@public.gmane.org</a>; <a class=3D"moz-txt-link-abbreviated" href=3D"=
mailto:airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">
airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br>
<b>Cc:</b> <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx@lis=
ts.freedesktop.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> [PATCH 4/6] drm/amdgpu: implement PRT for GFX6</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText">From: Christian K=F6nig <a class=3D"moz-txt-link-r=
fc2396E" href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
Enable/disable the handling globally for now and<br>
print a warning when we enable it for the first time.<br>
<br>
Signed-off-by: Christian K=F6nig <a class=3D"moz-txt-link-rfc2396E" href=3D=
"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 63 &#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&=
#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<=
br>
&nbsp;1 file changed, 63 insertions(&#43;)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/am=
dgpu/gmc_v6_0.c<br>
index e2b0b16..c23503e 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c<br>
@@ -398,6 &#43;398,68 @@ static void gmc_v6_0_set_fault_enable_default(stru=
ct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVM_CONTEXT1_CNTL,=
 tmp);<br>
&nbsp;}<br>
&nbsp;<br>
&#43; /**<br>
&#43;&nbsp;&nbsp; &#43; * gmc_v8_0_set_prt - set PRT VM fault<br>
&#43;&nbsp;&nbsp; &#43; *<br>
&#43;&nbsp;&nbsp; &#43; * @adev: amdgpu_device pointer<br>
&#43;&nbsp;&nbsp; &#43; * @enable: enable/disable VM fault handling for PRT=
<br>
&#43;&nbsp;&nbsp; &#43;*/<br>
&#43;static void gmc_v6_0_set_prt(struct amdgpu_device *adev, bool enable)<=
br>
&#43;{<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u32 tmp;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable &amp;&amp; !adev-&gt;m=
c.prt_warning) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Disabling VM faults because of =
PRT request!\n&quot;);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; adev-&gt;mc.prt_warning =3D true;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D RREG32(mmVM_PRT_CNTL);<br=
>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_PRT=
_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; CB_DISABLE_READ_FAULT_ON_UNMAPPED_ACCESS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_PRT=
_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; CB_DISABLE_WRITE_FAULT_ON_UNMAPPED_ACCESS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_PRT=
_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; TC_DISABLE_READ_FAULT_ON_UNMAPPED_ACCESS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_PRT=
_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; TC_DISABLE_WRITE_FAULT_ON_UNMAPPED_ACCESS,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_PRT=
_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; L2_CACHE_STORE_INVALID_ENTRIES,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_PRT=
_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; L1_TLB_STORE_INVALID_ENTRIES,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_FIELD(tmp, VM_PRT=
_CNTL,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; MASK_PDE0_FAULT, enable);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32(mmVM_CONTEXT1_CNTL, tmp);<=
br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (enable) {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t low =3D AMDGPU_VA_RESERVED_SIZE &gt;&gt; AMDGPU_GPU=
_PAGE_SHIFT;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; uint32_t high =3D adev-&gt;vm_manager.max_pfn;<br>
&#43;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, low);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, low);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE2_LOW_ADDR, low);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE3_LOW_ADDR, low);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE0_HIGH_ADDR, high);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE1_HIGH_ADDR, high);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE2_HIGH_ADDR, high);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE3_HIGH_ADDR, high);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE0_LOW_ADDR, 0xfffffff);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE1_LOW_ADDR, 0xfffffff);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE2_LOW_ADDR, 0xfffffff);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE3_LOW_ADDR, 0xfffffff);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE0_HIGH_ADDR, 0x0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE1_HIGH_ADDR, 0x0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE2_HIGH_ADDR, 0x0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; WREG32(mmVM_PRT_APERTURE3_HIGH_ADDR, 0x0);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&#43;}<br>
&#43;<br>
&nbsp;static int gmc_v6_0_gart_enable(struct amdgpu_device *adev)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r, i;<br>
@@ -1080,6 &#43;1142,7 @@ static const struct amd_ip_funcs gmc_v6_0_ip_func=
s =3D {<br>
&nbsp;static const struct amdgpu_gart_funcs gmc_v6_0_gart_funcs =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .flush_gpu_tlb =3D gmc_v6_=
0_gart_flush_gpu_tlb,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_pte_pde =3D gmc_v6_0_=
gart_set_pte_pde,<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_prt =3D gmc_v6_0_set_prt,<br=
>
&nbsp;};<br>
&nbsp;<br>
&nbsp;static const struct amdgpu_irq_src_funcs gmc_v6_0_irq_funcs =3D {<br>
-- <br>
2.5.0<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk685925" previewremoved=3D"true">https://lists.freedesktop.org/mailman/li=
stinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14857846636950.18213166157152716" style=3D"margin-bo=
ttom:20px; overflow:auto; width:100%; text-indent:0px" contenteditable=3D"f=
alse">
<table id=3D"LPContainer_14857846636930.6345001279342901" cellspacing=3D"0"=
 style=3D"width:90%; background-color:rgb(255,255,255); overflow:auto; padd=
ing-top:20px; padding-bottom:20px; margin-top:20px; border-top:1px dotted r=
gb(200,200,200); border-bottom:1px dotted rgb(200,200,200)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"TextCell_14857846636940.48014062491777976" colspan=3D"2" style=3D=
"vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPTitle_14857846636940.9893355573948246" style=3D""><a id=3D"LPU=
rlAnchor_14857846636950.10171241072401171" href=3D"https://lists.freedeskto=
p.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-decoration:=
none">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14857846636950.8672987540780379" style=3D"">lists.fre=
edesktop.org</div>
<div id=3D"LPDescription_14857846636950.14446370601966319" style=3D"display=
:block; color:rgb(102,102,102); font-weight:normal; font-family:wf_segoe-ui=
_normal,&quot;Segoe UI&quot;,&quot;Segoe WP&quot;,Tahoma,Arial,sans-serif; =
font-size:14px; line-height:20px; max-height:100px; overflow:hidden">
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
</blockquote>
<p><br>
</p>
</div>
</div>
</div>
</body>
</html>

--_000_CY4PR12MB1768D597CD5AA969E892F02FF74B0CY4PR12MB1768namp_--

--_004_CY4PR12MB1768D597CD5AA969E892F02FF74B0CY4PR12MB1768namp_
Content-Type: image/png; name="ATT00001.png"
Content-Description: ATT00001.png
Content-Disposition: inline; filename="ATT00001.png"; size=488;
	creation-date="Mon, 30 Jan 2017 14:14:38 GMT";
	modification-date="Mon, 30 Jan 2017 14:14:38 GMT"
Content-ID: <part1.A7DC9569.EFDA65F4-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJ
bWFnZVJlYWR5ccllPAAAAYpJREFUeNpi/P//PwO1ACM2wf9njBWAVD4QBwCxApLUAyDeAMQTGU3O
PkDRA3QUIxaD+oFUAREOaQQa2IDTMKBB84FUAgk+WwA0MBFmGBOaixJIDKYEoD6465igBjkge+3C
rW94TUCTr4eGMdxl8TCZxMYHDIZR1xk2HPiA1SCQOEgepA4J5CMbFgAPhM1vwfTFW9+xGgYTh6lD
1s8IdKIAkH4PEz1w9jOYVpBiZ1CQZMMw7MHzXwwPnv0Esx2MeRESxmcYWYCUAbJiFAVYAMgCbJbA
vPmAWjmACZqS4aHdOOs5wdgEBcWE5a8Y0HIGPAIOwETtjXkYJqIqxAAgeQM1ThTzkQ2biB5mC7a8
xZ7kgeICvMzoYTsRJaMDY3U9chIBpaMHz34xxPsKgwMcFIsLgckB5KL+YllkgyYAg6oQJW9Ck8h+
5NgFhd3GAx/humAGI2cGIHYEGvYBW0YHGTgf2YX4MjkQF4IMwlkEIeXVfByGwsqzAwTLMywGg7wN
cvED9AIR3TCAAAMAqh+p+YMVeBQAAAAASUVORK5CYII=

--_004_CY4PR12MB1768D597CD5AA969E892F02FF74B0CY4PR12MB1768namp_--

--===============0222655619==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0222655619==--
