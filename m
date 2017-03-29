From: "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix multi-level page table bugs for large
 BOs
Date: Wed, 29 Mar 2017 03:24:50 +0000
Message-ID: <DM5PR1201MB0235AB2363725D0D8320265292350@DM5PR1201MB0235.namprd12.prod.outlook.com>
References: <1490749231-16157-1-git-send-email-Felix.Kuehling@amd.com>
 <1490749231-16157-4-git-send-email-Felix.Kuehling@amd.com>,
 <58DB21CB.4090800@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0071841744=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <58DB21CB.4090800-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Russell,
 Kent" <Kent.Russell-5C7GfCeVMHo@public.gmane.org>

--===============0071841744==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR1201MB0235AB2363725D0D8320265292350DM5PR1201MB0235_"

--_000_DM5PR1201MB0235AB2363725D0D8320265292350DM5PR1201MB0235_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Jerry,

Let me clarify my understanding of the problem and the intention of the fix=
.

Address range per page: 4KB
Address range per PT (level 3): 2MB
Address range per PD (level 2): 1GB
Address range per PD (level 1): 512GB
Address range per PD (level 0): 256TB

Imagine for example a mapping that spans multiple level 2 page directories.=
 Say from 0.5GB to 2.5GB.

At level 0:
from =3D 0
to =3D 0

At level 1:
from =3D 0
to =3D 2

So for level 2 amdgpu_vm_alloc_levels gets called 3 times (pt_idx =3D [0..2=
]). Without my change, it gets called with the same saddr and eaddr 3 times=
. So it calculates the same "from" and "to" each time:
from =3D 256 % 512 =3D 256
to =3D 767 % 512 =3D 255

Obviously that doesn't work. What we really want is this (from..to in level=
 2 when called for pt_idx values from level 1):

For pt_idx=3D0 we want to fill the second half of the level 2 page director=
y with page tables:
from =3D 256
to =3D 511

For pt_idx=3D1 we need to fill the entire level 2 page directories with pag=
e tables:
from =3D 0
to =3D 511

For pt_idx=3D2 we want to fill the first half of the level 2 page directory=
 with page tables:
from =3D 0
to =3D 255

This creates a contiguous range of page tables across the three level 2 pag=
e directories that are spanned by the allocation. My change achieves that.

I think you're right, there are some extra high bits in saddr and eaddr, bu=
t they get discarded by the modulo-division in the next recursion level. Fo=
r added clarity the modulo division (or masking of high bits) could be move=
d up to the caller.

Regards,
  Felix


--
F e l i x   K u e h l i n g
SMTS Software Development Engineer | Vertical Workstation/Compute
1 Commerce Valley Dr. East, Markham, ON L3T 7X6 Canada
(O) +1(289)695-1597
   _     _   _   _____   _____
  / \   | \ / | |  _  \  \ _  |
 / A \  | \M/ | | |D) )  /|_| |
/_/ \_\ |_| |_| |_____/ |__/ \|   facebook.com/AMD | amd.com
________________________________
From: Zhang, Jerry
Sent: Tuesday, March 28, 2017 10:54:03 PM
To: Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christian; Zhou=
, David(ChunMing)
Cc: Deucher, Alexander; Russell, Kent
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix multi-level page table bugs for la=
rge BOs

On 03/29/2017 09:00 AM, Felix Kuehling wrote:
> Fix the start/end address calculation for address ranges that span
> multiple page directories in amdgpu_vm_alloc_levels.
>
> Add WARN_ONs if page tables aren't found. Otherwise the page table
> update would just fail silently.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 818747f..44aa039 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -278,6 +278,8 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_devic=
e *adev,
>        from =3D (saddr >> shift) % amdgpu_vm_num_entries(adev, level);
>        to =3D (eaddr >> shift) % amdgpu_vm_num_entries(adev, level);
>
> +     WARN_ON(from > to);
> +
>        if (to > parent->last_entry_used)
>                parent->last_entry_used =3D to;
>
> @@ -312,8 +314,11 @@ static int amdgpu_vm_alloc_levels(struct amdgpu_devi=
ce *adev,
>                }
>
>                if (level < adev->vm_manager.num_level) {
> -                     r =3D amdgpu_vm_alloc_levels(adev, vm, entry, saddr=
,
> -                                                eaddr, level);
> +                     uint64_t sub_saddr =3D (pt_idx =3D=3D from) ? saddr=
 : 0;
> +                     uint64_t sub_eaddr =3D (pt_idx =3D=3D to) ? eaddr :
> +                             ((1 << shift) - 1);
> +                     r =3D amdgpu_vm_alloc_levels(adev, vm, entry, sub_s=
addr,
> +                                                sub_eaddr, level);

Do you mean to create a full sub-pt if pt_idx !=3D from and !=3D to?
I didn't catch it up clear.

In my perspective, we may need to clear the saddr and eaddr upper level bit
before going on to allocate the next level PT.
Otherwise, the number of next PT entry will be incorrect, more than num_ent=
ries
as the upper level PT number calculated in.

e.g.
there is a address contains
PD + PT1 + PT2 + PT3

for the first round, we could get correct "from" and "to" address with righ=
t
"shift"(3 blocks), then walk over the address space in PD range.

Then for the 2nd round, we cannot get the expected "from" and "to" address =
with
"shift"(2 blocks), as it walks over the address space in PD + PT1 range.
While we'd like it's in range PT1 indeed.

The fault way goes on with later round.

Perhaps, that's the root cause about the issue you face.

Jerry.

>                        if (r)
>                                return r;
>                }
> @@ -957,9 +962,11 @@ static struct amdgpu_bo *amdgpu_vm_get_pt(struct amd=
gpu_pte_update_params *p,
>                entry =3D &entry->entries[idx];
>        }
>
> -     if (level)
> +     if (WARN_ON(level))
>                return NULL;
>
> +     WARN_ON(!entry->bo);
> +
>        return entry->bo;
>   }
>
>

--_000_DM5PR1201MB0235AB2363725D0D8320265292350DM5PR1201MB0235_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p></p>
<div>Hi Jerry,<br>
<br>
Let me clarify my understanding of the problem and the intention of the fix=
.<br>
<br>
Address range per page: 4KB<br>
Address range per PT (level 3): 2MB<br>
Address range per PD (level 2): 1GB<br>
Address range per PD (level 1): 512GB<br>
Address range per PD (level 0): 256TB<br>
<br>
Imagine for example a mapping that spans multiple level 2 page directories.=
 Say from 0.5GB to 2.5GB.<br>
<br>
At level 0:<br>
from =3D 0<br>
to =3D 0<br>
<br>
At level 1:<br>
from =3D 0<br>
to =3D 2<br>
<br>
So for level 2 amdgpu_vm_alloc_levels gets called 3 times (pt_idx =3D [0..2=
]). Without my change, it gets called with the same saddr and eaddr 3 times=
. So it calculates the same &quot;from&quot; and &quot;to&quot; each time:<=
br>
from =3D 256 % 512 =3D 256<br>
to =3D 767 % 512 =3D 255<br>
<br>
Obviously that doesn't work. What we really want is this (from..to in level=
 2 when called for pt_idx values from level 1):<br>
<br>
For pt_idx=3D0 we want to fill the second half of the level 2 page director=
y with page tables:<br>
from =3D 256<br>
to =3D 511<br>
<br>
For pt_idx=3D1 we need to fill the entire level 2 page directories with pag=
e tables:<br>
from =3D 0<br>
to =3D 511<br>
<br>
For pt_idx=3D2 we want to fill the first half of the level 2 page directory=
 with page tables:<br>
from =3D 0<br>
to =3D 255<br>
<br>
This creates a contiguous range of page tables across the three level 2 pag=
e directories that are spanned by the allocation. My change achieves that.<=
br>
<br>
I think you're right, there are some extra high bits in saddr and eaddr, bu=
t they get discarded by the modulo-division in the next recursion level. Fo=
r added clarity the modulo division (or masking of high bits) could be move=
d up to the caller.<br>
<br>
Regards,<br>
&nbsp; Felix<br>
</div>
<p></p>
<p><br>
</p>
<div id=3D"x_Signature">
<div style=3D"font-family:Tahoma; font-size:13px">
<div style=3D"font-family:Tahoma; font-size:13px">
<div style=3D"font-family:Tahoma; font-size:13px">
<div style=3D"font-family:Tahoma; font-size:13px">
<div style=3D"font-family:Tahoma; font-size:13px"><font size=3D"2" face=3D"=
Courier New"></font>
<div align=3D"left">
<div>
<div class=3D"x_BodyFragment"><font size=3D"2" face=3D"Courier New">
<div class=3D"x_PlainText"><font size=3D"2"><span style=3D"font-size:10pt">=
--<br>
F e l i x&nbsp;&nbsp; K u e h l i n g<br>
SMTS Software Development Engineer | Vertical Workstation/Compute<br>
1 Commerce Valley Dr. East, Markham, ON L3T 7X6 Canada<br>
(O) &#43;1(289)695-1597<br>
&nbsp;&nbsp; _&nbsp;&nbsp;&nbsp;&nbsp; _&nbsp;&nbsp; _&nbsp;&nbsp; _____&nb=
sp;&nbsp; _____<br>
&nbsp; / \&nbsp;&nbsp; | \ / | |&nbsp; _&nbsp; \&nbsp; \ _&nbsp; |<br>
&nbsp;/ A \&nbsp; | \M/ | | |D) )&nbsp; /|_| |<br>
/_/ \_\ |_| |_| |_____/ |__/ \|&nbsp;&nbsp; facebook.com/AMD | amd.com</spa=
n></font><br>
</div>
</font></div>
</div>
</div>
<font size=3D"2" face=3D"Courier New"></font></div>
</div>
</div>
</div>
</div>
</div>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Zhang, Jerry<br>
<b>Sent:</b> Tuesday, March 28, 2017 10:54:03 PM<br>
<b>To:</b> Kuehling, Felix; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christia=
n; Zhou, David(ChunMing)<br>
<b>Cc:</b> Deucher, Alexander; Russell, Kent<br>
<b>Subject:</b> Re: [PATCH 3/3] drm/amdgpu: Fix multi-level page table bugs=
 for large BOs</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">On 03/29/2017 09:00 AM, Felix Kuehling wrote:<br>
&gt; Fix the start/end address calculation for address ranges that span<br>
&gt; multiple page directories in amdgpu_vm_alloc_levels.<br>
&gt;<br>
&gt; Add WARN_ONs if page tables aren't found. Otherwise the page table<br>
&gt; update would just fail silently.<br>
&gt;<br>
&gt; Signed-off-by: Felix Kuehling &lt;Felix.Kuehling-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 13 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; 1 file changed, 10 insertions(&#43;), 3 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 818747f..44aa039 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -278,6 &#43;278,8 @@ static int amdgpu_vm_alloc_levels(struct amdgp=
u_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; from =3D (saddr &gt;&gt; shi=
ft) % amdgpu_vm_num_entries(adev, level);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to =3D (eaddr &gt;&gt; shift=
) % amdgpu_vm_num_entries(adev, level);<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(from &gt; to);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (to &gt; parent-&gt;last_=
entry_used)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; parent-&gt;last_entry_used =3D to;<br>
&gt;<br>
&gt; @@ -312,8 &#43;314,11 @@ static int amdgpu_vm_alloc_levels(struct amdg=
pu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (level &lt; adev-&gt;vm_manager.num_level) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_alloc_l=
evels(adev, vm, entry, saddr,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eaddr, leve=
l);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t sub_saddr =
=3D (pt_idx =3D=3D from) ? saddr : 0;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t sub_eaddr =
=3D (pt_idx =3D=3D to) ? eaddr :<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; ((1 &lt;&lt; shift) - 1);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_vm_all=
oc_levels(adev, vm, entry, sub_saddr,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sub_ead=
dr, level);<br>
<br>
Do you mean to create a full sub-pt if pt_idx !=3D from and !=3D to?<br>
I didn't catch it up clear.<br>
<br>
In my perspective, we may need to clear the saddr and eaddr upper level bit=
 <br>
before going on to allocate the next level PT.<br>
Otherwise, the number of next PT entry will be incorrect, more than num_ent=
ries <br>
as the upper level PT number calculated in.<br>
<br>
e.g.<br>
there is a address contains<br>
PD &#43; PT1 &#43; PT2 &#43; PT3<br>
<br>
for the first round, we could get correct &quot;from&quot; and &quot;to&quo=
t; address with right <br>
&quot;shift&quot;(3 blocks), then walk over the address space in PD range.<=
br>
<br>
Then for the 2nd round, we cannot get the expected &quot;from&quot; and &qu=
ot;to&quot; address with <br>
&quot;shift&quot;(2 blocks), as it walks over the address space in PD &#43;=
 PT1 range.<br>
While we'd like it's in range PT1 indeed.<br>
<br>
The fault way goes on with later round.<br>
<br>
Perhaps, that's the root cause about the issue you face.<br>
<br>
Jerry.<br>
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<=
br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }<br>
&gt; @@ -957,9 &#43;962,11 @@ static struct amdgpu_bo *amdgpu_vm_get_pt(str=
uct amdgpu_pte_update_params *p,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; entry =3D &amp;entry-&gt;entries[idx];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (level)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (WARN_ON(level))<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return NULL;<br>
&gt;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WARN_ON(!entry-&gt;bo);<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return entry-&gt;bo;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;<br>
&gt;<br>
</div>
</span></font>
</body>
</html>

--_000_DM5PR1201MB0235AB2363725D0D8320265292350DM5PR1201MB0235_--

--===============0071841744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0071841744==--
