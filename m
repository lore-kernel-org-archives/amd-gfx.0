From: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed
Date: Tue, 23 Oct 2018 03:31:13 +0000
Message-ID: <BYAPR12MB27753552FB75C04C871BEA68FBF50@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <1540224561-4728-1-git-send-email-Rex.Zhu@amd.com>,
 <7eb4b4ef-c72a-9a58-2c99-0bfbe6109f69@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1821627373=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <7eb4b4ef-c72a-9a58-2c99-0bfbe6109f69-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============1821627373==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BYAPR12MB27753552FB75C04C871BEA68FBF50BYAPR12MB2775namp_"

--_000_BYAPR12MB27753552FB75C04C871BEA68FBF50BYAPR12MB2775namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks Jerry.

Good suggestion.

Use the right mask for PD instand of hardcode.

so don't need to revert the whole patch.


Best Regards

Rex


________________________________
From: Zhang, Jerry
Sent: Tuesday, October 23, 2018 10:02 AM
To: Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christian
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed

On 10/23/2018 12:09 AM, Rex Zhu wrote:
> When the va address located in the last pd entry,

Do you mean the root PD?
maybe we need roundup root PD in amdgpu_vm_entries_mask() like
amdgpu_vm_num_entries().

BTW, looks amdgpu_vm_entries_mask() is going to replace the
amdgpu_vm_num_entries()

Jerry
> the alloc_pts will failed.
> caused by
> "drm/amdgpu: add amdgpu_vm_entries_mask v2"
> commit 72af632549b97ead9251bb155f08fefd1fb6f5c3.
>
> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 +++++++--------------------=
-------
>   1 file changed, 7 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index 054633b..1a3af72 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -191,26 +191,6 @@ static unsigned amdgpu_vm_num_entries(struct amdgpu_=
device *adev,
>   }
>
>   /**
> - * amdgpu_vm_entries_mask - the mask to get the entry number of a PD/PT
> - *
> - * @adev: amdgpu_device pointer
> - * @level: VMPT level
> - *
> - * Returns:
> - * The mask to extract the entry number of a PD/PT from an address.
> - */
> -static uint32_t amdgpu_vm_entries_mask(struct amdgpu_device *adev,
> -                                    unsigned int level)
> -{
> -     if (level <=3D adev->vm_manager.root_level)
> -             return 0xffffffff;
> -     else if (level !=3D AMDGPU_VM_PTB)
> -             return 0x1ff;
> -     else
> -             return AMDGPU_VM_PTE_COUNT(adev) - 1;
> -}
> -
> -/**
>    * amdgpu_vm_bo_size - returns the size of the BOs in bytes
>    *
>    * @adev: amdgpu_device pointer
> @@ -419,17 +399,17 @@ static void amdgpu_vm_pt_start(struct amdgpu_device=
 *adev,
>   static bool amdgpu_vm_pt_descendant(struct amdgpu_device *adev,
>                                    struct amdgpu_vm_pt_cursor *cursor)
>   {
> -     unsigned mask, shift, idx;
> +     unsigned num_entries, shift, idx;
>
>        if (!cursor->entry->entries)
>                return false;
>
>        BUG_ON(!cursor->entry->base.bo);
> -     mask =3D amdgpu_vm_entries_mask(adev, cursor->level);
> +     num_entries =3D amdgpu_vm_num_entries(adev, cursor->level);
>        shift =3D amdgpu_vm_level_shift(adev, cursor->level);
>
>        ++cursor->level;
> -     idx =3D (cursor->pfn >> shift) & mask;
> +     idx =3D (cursor->pfn >> shift) % num_entries;
>        cursor->parent =3D cursor->entry;
>        cursor->entry =3D &cursor->entry->entries[idx];
>        return true;
> @@ -1618,7 +1598,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_pte_=
update_params *params,
>        amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
>        while (cursor.pfn < end) {
>                struct amdgpu_bo *pt =3D cursor.entry->base.bo;
> -             unsigned shift, parent_shift, mask;
> +             unsigned shift, parent_shift, num_entries;
>                uint64_t incr, entry_end, pe_start;
>
>                if (!pt)
> @@ -1673,9 +1653,9 @@ static int amdgpu_vm_update_ptes(struct amdgpu_pte_=
update_params *params,
>
>                /* Looks good so far, calculate parameters for the update =
*/
>                incr =3D AMDGPU_GPU_PAGE_SIZE << shift;
> -             mask =3D amdgpu_vm_entries_mask(adev, cursor.level);
> -             pe_start =3D ((cursor.pfn >> shift) & mask) * 8;
> -             entry_end =3D (mask + 1) << shift;
> +             num_entries =3D amdgpu_vm_num_entries(adev, cursor.level);
> +             pe_start =3D ((cursor.pfn >> shift) & (num_entries - 1)) * =
8;
> +             entry_end =3D num_entries << shift;
>                entry_end +=3D cursor.pfn & ~(entry_end - 1);
>                entry_end =3D min(entry_end, end);
>


--_000_BYAPR12MB27753552FB75C04C871BEA68FBF50BYAPR12MB2775namp_
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
<p style=3D"margin-top:0;margin-bottom:0">Thanks Jerry.</p>
<p style=3D"margin-top:0;margin-bottom:0">Good suggestion.</p>
<p style=3D"margin-top:0;margin-bottom:0">Use the right mask for PD instand=
 of hardcode.</p>
<p style=3D"margin-top:0;margin-bottom:0">so don't need to revert the whole=
 patch.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Best Regards</p>
<p style=3D"margin-top:0;margin-bottom:0">Rex<br>
</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" color=
=3D"#000000" face=3D"Calibri, sans-serif"><b>From:</b> Zhang, Jerry<br>
<b>Sent:</b> Tuesday, October 23, 2018 10:02 AM<br>
<b>To:</b> Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christian<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On 10/23/2018 12:09 AM, Rex Zhu wrote:<br>
&gt; When the va address located in the last pd entry,<br>
<br>
Do you mean the root PD?<br>
maybe we need roundup root PD in amdgpu_vm_entries_mask() like <br>
amdgpu_vm_num_entries().<br>
<br>
BTW, looks amdgpu_vm_entries_mask() is going to replace the <br>
amdgpu_vm_num_entries()<br>
<br>
Jerry<br>
&gt; the alloc_pts will failed.<br>
&gt; caused by<br>
&gt; &quot;drm/amdgpu: add amdgpu_vm_entries_mask v2&quot;<br>
&gt; commit 72af632549b97ead9251bb155f08fefd1fb6f5c3.<br>
&gt;<br>
&gt; Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 &#43;&#43;&#43=
;&#43;&#43;&#43;&#43;---------------------------<br>
&gt;&nbsp;&nbsp; 1 file changed, 7 insertions(&#43;), 27 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_vm.c<br>
&gt; index 054633b..1a3af72 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&gt; @@ -191,26 &#43;191,6 @@ static unsigned amdgpu_vm_num_entries(struct =
amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * amdgpu_vm_entries_mask - the mask to get the entry number of a PD/=
PT<br>
&gt; - *<br>
&gt; - * @adev: amdgpu_device pointer<br>
&gt; - * @level: VMPT level<br>
&gt; - *<br>
&gt; - * Returns:<br>
&gt; - * The mask to extract the entry number of a PD/PT from an address.<b=
r>
&gt; - */<br>
&gt; -static uint32_t amdgpu_vm_entries_mask(struct amdgpu_device *adev,<br=
>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned=
 int level)<br>
&gt; -{<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (level &lt;=3D adev-&gt;vm_manager.root_l=
evel)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0xffffffff;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else if (level !=3D AMDGPU_VM_PTB)<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return 0x1ff;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return AMDGPU_VM_PTE_COUNT(adev) - 1;<br>
&gt; -}<br>
&gt; -<br>
&gt; -/**<br>
&gt;&nbsp;&nbsp;&nbsp; * amdgpu_vm_bo_size - returns the size of the BOs in=
 bytes<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @adev: amdgpu_device pointer<br>
&gt; @@ -419,17 &#43;399,17 @@ static void amdgpu_vm_pt_start(struct amdgpu=
_device *adev,<br>
&gt;&nbsp;&nbsp; static bool amdgpu_vm_pt_descendant(struct amdgpu_device *=
adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amd=
gpu_vm_pt_cursor *cursor)<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; unsigned mask, shift, idx;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; unsigned num_entries, shift, idx;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cursor-&gt;entry-&gt;en=
tries)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return false;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!cursor-&gt;entry-&gt=
;base.bo);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; mask =3D amdgpu_vm_entries_mask(adev, cursor=
-&gt;level);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; num_entries =3D amdgpu_vm_num_entries(ad=
ev, cursor-&gt;level);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift =3D amdgpu_vm_level_sh=
ift(adev, cursor-&gt;level);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&#43;cursor-&gt;level;<=
br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; idx =3D (cursor-&gt;pfn &gt;&gt; shift) &amp=
; mask;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; idx =3D (cursor-&gt;pfn &gt;&gt; shift) =
% num_entries;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor-&gt;parent =3D cursor=
-&gt;entry;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor-&gt;entry =3D &amp;cu=
rsor-&gt;entry-&gt;entries[idx];<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; @@ -1618,7 &#43;1598,7 @@ static int amdgpu_vm_update_ptes(struct amdg=
pu_pte_update_params *params,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_start(adev, par=
ams-&gt;vm, start, &amp;cursor);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.pfn &lt; end) =
{<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *pt =3D cursor.entry-&gt;base.bo;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; unsigned shift, parent_shift, mask;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; unsigned shift, parent_shift, num_entries;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; uint64_t incr, entry_end, pe_start;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; if (!pt)<br>
&gt; @@ -1673,9 &#43;1653,9 @@ static int amdgpu_vm_update_ptes(struct amdg=
pu_pte_update_params *params,<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* Looks good so far, calculate parameters for the upda=
te */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; incr =3D AMDGPU_GPU_PAGE_SIZE &lt;&lt; shift;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; mask =3D amdgpu_vm_entries_mask(adev, cursor.level);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; pe_start =3D ((cursor.pfn &gt;&gt; shift) &amp; mask) * 8;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; entry_end =3D (mask &#43; 1) &lt;&lt; shift;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; num_entries =3D amdgpu_vm_num_entries(adev, cursor.level);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; pe_start =3D ((cursor.pfn &gt;&gt; shift) &amp; (num_entries - 1)) =
* 8;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; entry_end =3D num_entries &lt;&lt; shift;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; entry_end &#43;=3D cursor.pfn &amp; ~(entry_end - 1);<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; entry_end =3D min(entry_end, end);<br>
&gt;&nbsp;&nbsp; <br>
<br>
</div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_BYAPR12MB27753552FB75C04C871BEA68FBF50BYAPR12MB2775namp_--

--===============1821627373==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1821627373==--
