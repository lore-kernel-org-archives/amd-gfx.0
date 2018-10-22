From: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed
Date: Mon, 22 Oct 2018 17:42:52 +0000
Message-ID: <BN6PR12MB1809203FCA16A20673605F23F7F40@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <1540224561-4728-1-git-send-email-Rex.Zhu@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0671112812=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <1540224561-4728-1-git-send-email-Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

--===============0671112812==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_BN6PR12MB1809203FCA16A20673605F23F7F40BN6PR12MB1809namp_"

--_000_BN6PR12MB1809203FCA16A20673605F23F7F40BN6PR12MB1809namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This re-introduces a 64 division that is not handled correctly with the % o=
perator.


Alex

________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Rex Zhu =
<Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
Sent: Monday, October 22, 2018 12:09:21 PM
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christian
Cc: Zhu, Rex
Subject: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed

When the va address located in the last pd entry,
the alloc_pts will failed.
caused by
"drm/amdgpu: add amdgpu_vm_entries_mask v2"
commit 72af632549b97ead9251bb155f08fefd1fb6f5c3.

Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 +++++++-----------------------=
----
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index 054633b..1a3af72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -191,26 +191,6 @@ static unsigned amdgpu_vm_num_entries(struct amdgpu_de=
vice *adev,
 }

 /**
- * amdgpu_vm_entries_mask - the mask to get the entry number of a PD/PT
- *
- * @adev: amdgpu_device pointer
- * @level: VMPT level
- *
- * Returns:
- * The mask to extract the entry number of a PD/PT from an address.
- */
-static uint32_t amdgpu_vm_entries_mask(struct amdgpu_device *adev,
-                                      unsigned int level)
-{
-       if (level <=3D adev->vm_manager.root_level)
-               return 0xffffffff;
-       else if (level !=3D AMDGPU_VM_PTB)
-               return 0x1ff;
-       else
-               return AMDGPU_VM_PTE_COUNT(adev) - 1;
-}
-
-/**
  * amdgpu_vm_bo_size - returns the size of the BOs in bytes
  *
  * @adev: amdgpu_device pointer
@@ -419,17 +399,17 @@ static void amdgpu_vm_pt_start(struct amdgpu_device *=
adev,
 static bool amdgpu_vm_pt_descendant(struct amdgpu_device *adev,
                                     struct amdgpu_vm_pt_cursor *cursor)
 {
-       unsigned mask, shift, idx;
+       unsigned num_entries, shift, idx;

         if (!cursor->entry->entries)
                 return false;

         BUG_ON(!cursor->entry->base.bo);
-       mask =3D amdgpu_vm_entries_mask(adev, cursor->level);
+       num_entries =3D amdgpu_vm_num_entries(adev, cursor->level);
         shift =3D amdgpu_vm_level_shift(adev, cursor->level);

         ++cursor->level;
-       idx =3D (cursor->pfn >> shift) & mask;
+       idx =3D (cursor->pfn >> shift) % num_entries;
         cursor->parent =3D cursor->entry;
         cursor->entry =3D &cursor->entry->entries[idx];
         return true;
@@ -1618,7 +1598,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_pte_up=
date_params *params,
         amdgpu_vm_pt_start(adev, params->vm, start, &cursor);
         while (cursor.pfn < end) {
                 struct amdgpu_bo *pt =3D cursor.entry->base.bo;
-               unsigned shift, parent_shift, mask;
+               unsigned shift, parent_shift, num_entries;
                 uint64_t incr, entry_end, pe_start;

                 if (!pt)
@@ -1673,9 +1653,9 @@ static int amdgpu_vm_update_ptes(struct amdgpu_pte_up=
date_params *params,

                 /* Looks good so far, calculate parameters for the update =
*/
                 incr =3D AMDGPU_GPU_PAGE_SIZE << shift;
-               mask =3D amdgpu_vm_entries_mask(adev, cursor.level);
-               pe_start =3D ((cursor.pfn >> shift) & mask) * 8;
-               entry_end =3D (mask + 1) << shift;
+               num_entries =3D amdgpu_vm_num_entries(adev, cursor.level);
+               pe_start =3D ((cursor.pfn >> shift) & (num_entries - 1)) * =
8;
+               entry_end =3D num_entries << shift;
                 entry_end +=3D cursor.pfn & ~(entry_end - 1);
                 entry_end =3D min(entry_end, end);

--
1.9.1

_______________________________________________
amd-gfx mailing list
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--_000_BN6PR12MB1809203FCA16A20673605F23F7F40BN6PR12MB1809namp_
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
<p style=3D"margin-top:0;margin-bottom:0">This re-introduces a 64 division =
that is not handled correctly with the % operator.</p>
<p style=3D"margin-top:0;margin-bottom:0"><br>
</p>
<p style=3D"margin-top:0;margin-bottom:0">Alex<br>
</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&g=
t;<br>
<b>Sent:</b> Monday, October 22, 2018 12:09:21 PM<br>
<b>To:</b> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Koenig, Christian<br>
<b>Cc:</b> Zhu, Rex<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">When the va address located in the last pd entry,<=
br>
the alloc_pts will failed.<br>
caused by<br>
&quot;drm/amdgpu: add amdgpu_vm_entries_mask v2&quot;<br>
commit 72af632549b97ead9251bb155f08fefd1fb6f5c3.<br>
<br>
Signed-off-by: Rex Zhu &lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 34 &#43;&#43;&#43;&#43;&#43;=
&#43;&#43;---------------------------<br>
&nbsp;1 file changed, 7 insertions(&#43;), 27 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c<br>
index 054633b..1a3af72 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
&#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
@@ -191,26 &#43;191,6 @@ static unsigned amdgpu_vm_num_entries(struct amdgp=
u_device *adev,<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;/**<br>
- * amdgpu_vm_entries_mask - the mask to get the entry number of a PD/PT<br=
>
- *<br>
- * @adev: amdgpu_device pointer<br>
- * @level: VMPT level<br>
- *<br>
- * Returns:<br>
- * The mask to extract the entry number of a PD/PT from an address.<br>
- */<br>
-static uint32_t amdgpu_vm_entries_mask(struct amdgpu_device *adev,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
nsigned int level)<br>
-{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (level &lt;=3D adev-&gt;vm_manager=
.root_level)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0xffffffff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else if (level !=3D AMDGPU_VM_PTB)<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return 0x1ff;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return AMDGPU_VM_PTE_COUNT(adev) - 1;<br>
-}<br>
-<br>
-/**<br>
&nbsp; * amdgpu_vm_bo_size - returns the size of the BOs in bytes<br>
&nbsp; *<br>
&nbsp; * @adev: amdgpu_device pointer<br>
@@ -419,17 &#43;399,17 @@ static void amdgpu_vm_pt_start(struct amdgpu_devi=
ce *adev,<br>
&nbsp;static bool amdgpu_vm_pt_descendant(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct a=
mdgpu_vm_pt_cursor *cursor)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned mask, shift, idx;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned num_entries, shift, idx;=
<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!cursor-&gt;entry-&gt;=
entries)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG_ON(!cursor-&gt;entry-&=
gt;base.bo);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mask =3D amdgpu_vm_entries_mask(adev,=
 cursor-&gt;level);<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_entries =3D amdgpu_vm_num_ent=
ries(adev, cursor-&gt;level);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; shift =3D amdgpu_vm_level_=
shift(adev, cursor-&gt;level);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &#43;&#43;cursor-&gt;level=
;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx =3D (cursor-&gt;pfn &gt;&gt; shif=
t) &amp; mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; idx =3D (cursor-&gt;pfn &gt;&gt; =
shift) % num_entries;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor-&gt;parent =3D curs=
or-&gt;entry;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cursor-&gt;entry =3D &amp;=
cursor-&gt;entry-&gt;entries[idx];<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
@@ -1618,7 &#43;1598,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_pt=
e_update_params *params,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_pt_start(adev, p=
arams-&gt;vm, start, &amp;cursor);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; while (cursor.pfn &lt; end=
) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo *pt =3D cursor.entry-&gt;base.bo;<br=
>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; unsigned shift, parent_shift, mask;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; unsigned shift, parent_shift, num_entries;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; uint64_t incr, entry_end, pe_start;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; if (!pt)<br>
@@ -1673,9 &#43;1653,9 @@ static int amdgpu_vm_update_ptes(struct amdgpu_pt=
e_update_params *params,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Looks good so far, calculate parameters for the up=
date */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; incr =3D AMDGPU_GPU_PAGE_SIZE &lt;&lt; shift;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; mask =3D amdgpu_vm_entries_mask(adev, cursor.level);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; pe_start =3D ((cursor.pfn &gt;&gt; shift) &amp; mask) * 8;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; entry_end =3D (mask &#43; 1) &lt;&lt; shift;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; num_entries =3D amdgpu_vm_num_entries(adev, cursor.level);<b=
r>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; pe_start =3D ((cursor.pfn &gt;&gt; shift) &amp; (num_entries=
 - 1)) * 8;<br>
&#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; entry_end =3D num_entries &lt;&lt; shift;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; entry_end &#43;=3D cursor.pfn &amp; ~(entry_end - 1);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; entry_end =3D min(entry_end, end);<br>
&nbsp;<br>
-- <br>
1.9.1<br>
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

--_000_BN6PR12MB1809203FCA16A20673605F23F7F40BN6PR12MB1809namp_--

--===============0671112812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0671112812==--
