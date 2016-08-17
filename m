From: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 0/8] shadow page table support V5 ---> shadow bo support
Date: Wed, 17 Aug 2016 14:20:43 +0000
Message-ID: <DM5PR12MB113254D3903A95649134200BF7140@DM5PR12MB1132.namprd12.prod.outlook.com>
References: <1471413919-27166-1-git-send-email-David1.Zhou@amd.com>
 <3f0da3d7-ac25-fd73-3b84-d913535512ca@vodafone.de>
 <DM5PR12MB1132177CBD3C3B4630BDE2F9F7140@DM5PR12MB1132.namprd12.prod.outlook.com>,
 <118a152b-7045-880b-26d6-7405b6148b18@vodafone.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2051353768=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <118a152b-7045-880b-26d6-7405b6148b18-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
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
To: =?iso-8859-1?Q?Christian_K=F6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>, "Zhou,
 David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

--===============2051353768==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB113254D3903A95649134200BF7140DM5PR12MB1132namp_"

--_000_DM5PR12MB113254D3903A95649134200BF7140DM5PR12MB1132namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Yup, either way is fine as long as it's consistent.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Christia=
n K=F6nig <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Wednesday, August 17, 2016 10:16
To: StDenis, Tom; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Subject: Re: [PATCH 0/8] shadow page table support V5 ---> shadow bo suppor=
t

Errors should actually be reported by the caller, not here.

So we should probably remove that DRM_ERROR here as well.

Christian.

Am 17.08.2016 um 16:10 schrieb StDenis, Tom:

Why not be consistent and add a DRM_ERROR on all paths that include an erro=
r?  e.g. instead of


if (r)

   goto error_free;


Throw a DRM_ERROR("") in there.


Tom


________________________________
From: amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Christian K=F6nig <deathsimple@vodafo=
ne.de><mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Sent: Wednesday, August 17, 2016 10:04
To: Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org<mailto:amd-gfx@lis=
ts.freedesktop.org>
Subject: Re: [PATCH 0/8] shadow page table support V5 ---> shadow bo suppor=
t

Patch #1:

Could be that we need to add another module parameter to control this,
but I think for now that should be sufficient.

Patch is Reviewed-by: Christian K=F6nig <christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:c=
hristian.koenig-5C7GfCeVMHo@public.gmane.org>

Patch #2:

> +     if (direct_submit) {
> +             r =3D amdgpu_ib_schedule(ring, job->num_ibs, job->ibs,
> +                                    NULL, NULL, fence);
> +             job->fence =3D fence_get(*fence);
> +             if (r)
> +                     DRM_ERROR("Error scheduling IBs (%d)\n", r);
> +             amdgpu_job_free(job);

When there is an error you should return the code as well.

> +     } else {
> +             r =3D amdgpu_job_submit(job, ring, &adev->mman.entity,
> +                                   AMDGPU_FENCE_OWNER_UNDEFINED, fence);
> +             if (r)
> +                     goto error_free;
> +     }
>
>        return 0;

Just changing this to to "return r;" should be sufficient.

With that fixed the patch is Reviewed-by: Christian K=F6nig
<christian.koenig-5C7GfCeVMHo@public.gmane.org><mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org> as well.

Patch #3:

You mentioned that this isn't used during command submission but rather
during GPU reset, correct?

In this case I would advise not to use a member in the BO structure to
note the backup direction and instead have one function for back and one
for restoring the content (or note that as a parameter to the function).

Otherwise we could run into trouble when the CS wants to backup
something the GPU reset wants to restore at the same time.

Patch #4: Was already reviewed by me.

Patch #5:

> +     pt =3D params->shadow ? vm->page_tables[pt_idx].entry.robj->shadow =
:
> +             vm->page_tables[pt_idx].entry.robj;
You need to double check here if shadows are actually allocated or not.
Otherwise we will crash on an APU.

> +     /* double ndw, since need to update shadow pt bo as well */
> +     ndw *=3D 2;
> +
We don't need to double the IB size, but only the number of commands in
it (ncmds).

The difference is when we want to write scattered GART entries. In this
case I've added the PTEs to the end of the IB.

Patch #6:
> +     spinlock_t                      shadow_list_lock;
We might want to use a mutex here instead. Usually I would agree that a
spin lock is better for a linked list, but during the restore process in
a GPU reset we probably want to sleep here.

Alternatively you could splice the list to a local version on the stack,
grab references to the BOs and then drop the lock during the restore
process.

> @@ -541,6 +546,13 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
>        if ((*bo) =3D=3D NULL)
>                return;
>
> +     /* shadow must be freed before bo itself */
> +     if ((!(*bo)->shadow) && !list_empty(&(*bo)->shadow_list)) {
> +             spin_lock(&(*bo)->adev->shadow_list_lock);
> +             list_del_init(&(*bo)->shadow_list);
> +             spin_unlock(&(*bo)->adev->shadow_list_lock);
> +
> +     }
>        tbo =3D &((*bo)->tbo);
>        ttm_bo_unref(&tbo);
>        if (tbo =3D=3D NULL)
That would trigger even when we take a temporary reference. I suggest to
add a amdgpu_bo_unref_shadow() function instead, unreferencing both the
shadow and the normal BO.

This can then be used in the VM code to cleanup the shadow created.

Going to skip patch #7 and #8 for now cause our team call begins in a
moment.

Regards,
Christian.

Am 17.08.2016 um 08:05 schrieb Chunming Zhou:
> Since we cannot ensure VRAM is consistent after a GPU reset, page
> table shadowing is necessary. Shadowed page tables are, in a sense, a
> method to recover the consistent state of the page tables before the
> reset occurred.
>
> We need to allocate GTT bo as the shadow of VRAM bo when creating page ta=
ble,
> and make them the same. After gpu reset, we will need to use SDMA to copy=
 GTT bo
> content to VRAM bo, then page table will be recoveried.
>
>
> V2:
> Shadow bo uses a shadow entity running on normal run queue, after gpu res=
et,
> we need to wait for all shadow jobs finished first, then recovery page ta=
ble from shadow.
>
> V3:
> Addressed Christian comments for shadow bo part.
>
> V4:
> Switch back to update page table twice (one of two is for shadow)
>
> V5:
> make it be gerneic shadow bo support. Address Christian comments.
>
> Chunming Zhou (8):
>    drm/amdgpu: add need backup function V2
>    drm/amdgpu: add direct submision option for copy_buffer
>    drm/amdgpu: sync bo and shadow V2
>    drm/amdgpu: update pd shadow while updating pd
>    drm/amdgpu: update pt shadow while updating pt V2
>    drm/amdgpu: link all shadow bo
>    drm/amdgpu: implement recovery vram bo from shadow
>    drm/amdgpu: recover vram bo from shadow after gpu reset
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  9 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |  3 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 39 ++++++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 94 ++++++++++++++++++++=
++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  9 +++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      |  4 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 21 ++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 69 ++++++++++++++------
>   8 files changed, 215 insertions(+), 33 deletions(-)
>

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





--_000_DM5PR12MB113254D3903A95649134200BF7140DM5PR12MB1132namp_
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
<p>Yup, either way is fine as long as it's consistent.</p>
<p><br>
</p>
<p>Tom</p>
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" co=
lor=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt; on behalf of Christian K=F6nig &lt;deathsi=
mple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;<br>
<b>Sent:</b> Wednesday, August 17, 2016 10:16<br>
<b>To:</b> StDenis, Tom; Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp93rCq3LdnpKM@public.gmane.org=
rg<br>
<b>Subject:</b> Re: [PATCH 0/8] shadow page table support V5 ---&gt; shadow=
 bo support</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"moz-cite-prefix">Errors should actually be reported by the ca=
ller, not here.<br>
<br>
So we should probably remove that DRM_ERROR here as well.<br>
<br>
Christian.<br>
<br>
Am 17.08.2016 um 16:10 schrieb StDenis, Tom:<br>
</div>
<blockquote type=3D"cite">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt; color:#000000; ba=
ckground-color:#FFFFFF; font-family:Calibri,Arial,Helvetica,sans-serif">
<p>Why not be consistent and add a DRM_ERROR on all paths that include an e=
rror? &nbsp;e.g. instead of&nbsp;</p>
<p><br>
</p>
<p>if (r)</p>
<p>&nbsp; &nbsp;goto error_free;</p>
<p><br>
</p>
<p>Throw a DRM_ERROR(&quot;&quot;) in there.</p>
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
<b>Sent:</b> Wednesday, August 17, 2016 10:04<br>
<b>To:</b> Zhou, David(ChunMing); <a class=3D"moz-txt-link-abbreviated" hre=
f=3D"mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">
amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<b>Subject:</b> Re: [PATCH 0/8] shadow page table support V5 ---&gt; shadow=
 bo support</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt">
<div class=3D"PlainText">Patch #1:<br>
<br>
Could be that we need to add another module parameter to control this, <br>
but I think for now that should be sufficient.<br>
<br>
Patch is Reviewed-by: Christian K=F6nig <a class=3D"moz-txt-link-rfc2396E" =
href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">
&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
<br>
Patch #2:<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (direct_submit) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_ib_schedule(ring, job-&gt;num_ibs, job-&gt;ibs,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL=
, NULL, fence);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; job-&gt;fence =3D fence_get(*fence);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_ERROR(&quot;Err=
or scheduling IBs (%d)\n&quot;, r);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; amdgpu_job_free(job);<br>
<br>
When there is an error you should return the code as well.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; r =3D amdgpu_job_submit(job, ring, &amp;adev-&gt;mman.entity,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_FEN=
CE_OWNER_UNDEFINED, fence);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (r)<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto error_free;<br=
>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
<br>
Just changing this to to &quot;return r;&quot; should be sufficient.<br>
<br>
With that fixed the patch is Reviewed-by: Christian K=F6nig <br>
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"=
>&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> as well.<br>
<br>
Patch #3:<br>
<br>
You mentioned that this isn't used during command submission but rather <br=
>
during GPU reset, correct?<br>
<br>
In this case I would advise not to use a member in the BO structure to <br>
note the backup direction and instead have one function for back and one <b=
r>
for restoring the content (or note that as a parameter to the function).<br=
>
<br>
Otherwise we could run into trouble when the CS wants to backup <br>
something the GPU reset wants to restore at the same time.<br>
<br>
Patch #4: Was already reviewed by me.<br>
<br>
Patch #5:<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; pt =3D params-&gt;shadow ? vm-&gt;page_t=
ables[pt_idx].entry.robj-&gt;shadow :<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; vm-&gt;page_tables[pt_idx].entry.robj;<br>
You need to double check here if shadows are actually allocated or not. <br=
>
Otherwise we will crash on an APU.<br>
<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* double ndw, since need to update shad=
ow pt bo as well */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; ndw *=3D 2;<br>
&gt; &#43;<br>
We don't need to double the IB size, but only the number of commands in <br=
>
it (ncmds).<br>
<br>
The difference is when we want to write scattered GART entries. In this <br=
>
case I've added the PTEs to the end of the IB.<br>
<br>
Patch #6:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; spinlock_t&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; shadow_list_lock;<br>
We might want to use a mutex here instead. Usually I would agree that a <br=
>
spin lock is better for a linked list, but during the restore process in <b=
r>
a GPU reset we probably want to sleep here.<br>
<br>
Alternatively you could splice the list to a local version on the stack, <b=
r>
grab references to the BOs and then drop the lock during the restore <br>
process.<br>
<br>
&gt; @@ -541,6 &#43;546,13 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)<b=
r>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((*bo) =3D=3D NULL)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; /* shadow must be freed before bo itself=
 */<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if ((!(*bo)-&gt;shadow) &amp;&amp; !list=
_empty(&amp;(*bo)-&gt;shadow_list)) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; spin_lock(&amp;(*bo)-&gt;adev-&gt;shadow_list_lock);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; list_del_init(&amp;(*bo)-&gt;shadow_list);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; spin_unlock(&amp;(*bo)-&gt;adev-&gt;shadow_list_lock);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tbo =3D &amp;((*bo)-&gt;tbo)=
;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_bo_unref(&amp;tbo);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (tbo =3D=3D NULL)<br>
That would trigger even when we take a temporary reference. I suggest to <b=
r>
add a amdgpu_bo_unref_shadow() function instead, unreferencing both the <br=
>
shadow and the normal BO.<br>
<br>
This can then be used in the VM code to cleanup the shadow created.<br>
<br>
Going to skip patch #7 and #8 for now cause our team call begins in a <br>
moment.<br>
<br>
Regards,<br>
Christian.<br>
<br>
Am 17.08.2016 um 08:05 schrieb Chunming Zhou:<br>
&gt; Since we cannot ensure VRAM is consistent after a GPU reset, page<br>
&gt; table shadowing is necessary. Shadowed page tables are, in a sense, a<=
br>
&gt; method to recover the consistent state of the page tables before the<b=
r>
&gt; reset occurred.<br>
&gt;<br>
&gt; We need to allocate GTT bo as the shadow of VRAM bo when creating page=
 table,<br>
&gt; and make them the same. After gpu reset, we will need to use SDMA to c=
opy GTT bo<br>
&gt; content to VRAM bo, then page table will be recoveried.<br>
&gt;<br>
&gt;<br>
&gt; V2:<br>
&gt; Shadow bo uses a shadow entity running on normal run queue, after gpu =
reset,<br>
&gt; we need to wait for all shadow jobs finished first, then recovery page=
 table from shadow.<br>
&gt;<br>
&gt; V3:<br>
&gt; Addressed Christian comments for shadow bo part.<br>
&gt;<br>
&gt; V4:<br>
&gt; Switch back to update page table twice (one of two is for shadow)<br>
&gt;<br>
&gt; V5:<br>
&gt; make it be gerneic shadow bo support. Address Christian comments.<br>
&gt;<br>
&gt; Chunming Zhou (8):<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: add need backup function V2<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: add direct submision option for copy_buf=
fer<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: sync bo and shadow V2<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: update pd shadow while updating pd<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: update pt shadow while updating pt V2<br=
>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: link all shadow bo<br>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: implement recovery vram bo from shadow<b=
r>
&gt;&nbsp;&nbsp;&nbsp; drm/amdgpu: recover vram bo from shadow after gpu re=
set<br>
&gt;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu.h&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 9 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c |&nbsp; 3 &#=
43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c&nbsp;&nbsp;&nbs=
p; | 39 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.c&nbsp;&nbsp;&nbs=
p; | 94 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_object.h&nbsp;&nbsp;&nbs=
p; |&nbsp; 9 &#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_test.c&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp; 4 &#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; | 21 &#43;&#43;&#43;&#43;--<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; | 69 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#=
43;&#43;&#43;&#43;&#43;------<br>
&gt;&nbsp;&nbsp; 8 files changed, 215 insertions(&#43;), 33 deletions(-)<br=
>
&gt;<br>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a class=3D"moz-txt-link-abbreviated" href=3D"mailto:amd-gfx-PD4FTy7X32lzq7FAFJ/aeQ@public.gmane.org=
top.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
<a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx" id=3D"LP=
lnk214970">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
<div id=3D"LPBorder_GT_14714429737800.4406300387876183" style=3D"margin-bot=
tom:20px; overflow:auto; width:100%; text-indent:0px" contenteditable=3D"fa=
lse">
<table id=3D"LPContainer_14714429737780.3993206472027586" cellspacing=3D"0"=
 style=3D"width:90%; overflow:auto; padding-top:20px; padding-bottom:20px; =
margin-top:20px; border-top:1px dotted rgb(200,200,200); border-bottom:1px =
dotted rgb(200,200,200); background-color:rgb(255,255,255)">
<tbody>
<tr valign=3D"top" style=3D"border-spacing:0px">
<td id=3D"TextCell_14714429737790.7705126490415855" colspan=3D"2" style=3D"=
vertical-align:top; padding:0px; display:table-cell">
<div id=3D"LPTitle_14714429737790.7634184458877278" style=3D""><a id=3D"LPU=
rlAnchor_14714429737790.6135333253292945" href=3D"https://lists.freedesktop=
.org/mailman/listinfo/amd-gfx" target=3D"_blank" style=3D"text-decoration:n=
one">amd-gfx Info Page - lists.freedesktop.org</a></div>
<div id=3D"LPMetadata_14714429737790.9058058508163938" style=3D"">lists.fre=
edesktop.org</div>
<div id=3D"LPDescription_14714429737800.03199008072574672" style=3D"display=
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

--_000_DM5PR12MB113254D3903A95649134200BF7140DM5PR12MB1132namp_--

--===============2051353768==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============2051353768==--
