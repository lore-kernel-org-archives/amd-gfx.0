From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?Q?Re:_=e7=ad=94=e5=a4=8d:_[PATCH]_drm/amdgpu:put_CSA_unmap_?=
 =?UTF-8?Q?after_sched=5fentity=5ffini?=
Date: Fri, 13 Jan 2017 11:23:26 +0100
Message-ID: <936c3f9b-2545-3b18-c7ad-f3440d203ea6@vodafone.de>
References: <1484280664-22845-1-git-send-email-Monk.Liu@amd.com>
 <dadee34c-ca4c-6a2a-8053-4bfdeb1466c3@vodafone.de>
 <BY2PR1201MB11102468908DDFD083C45B5384780@BY2PR1201MB1110.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1544592784=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB11102468908DDFD083C45B5384780-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Liu, Monk" <Monk.Liu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1544592784==
Content-Type: multipart/alternative;
 boundary="------------0E84747C94F1BCF76917282E"

This is a multi-part message in MIME format.
--------------0E84747C94F1BCF76917282E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Ah, in this case please separate the amdgpu_vm_bo_rmv() from setting 
csa_addr to NULL.

Cause amdgpu_vm_bo_rmv() should come before amdgpu_vm_fini() and that in 
turn should become before waiting for the scheduler so that the MM knows 
that the memory is about to be freed.

Regards,
Christian.

Am 13.01.2017 um 10:56 schrieb Liu, Monk:
>
> only with amdgpu_vm_bo_rmv() won't has such bug, but in another branch 
> for sriov, we not only call vm_bo_rmv(), and we also set csa_addr to 
> NULL after it, so the NULL address is inserted in RB, and when 
> preemption occured, CP backup snapshot to NULL address.
>
>
> although in staging-4.9 we didn't set csa_addr to NULL (because as you 
> suggested we always use HARDCODE/MACRO for CSA address), but logically 
> we'd better put CSA unmapping stuffs behind "sched_entity_fini", which 
> is more reasonable ...
>
>
> BR Monk
>
> ------------------------------------------------------------------------
> *发件人:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> 代表 Christian 
> König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *发送时间:* 2017年1月13日 17:25:09
> *收件人:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: [PATCH] drm/amdgpu:put CSA unmap after sched_entity_fini
> Am 13.01.2017 um 05:11 schrieb Monk Liu:
> > otherwise CSA may unmapped before gpu_scheduler scheduling
> > jobs and trigger VM fault on CSA address
> >
> > Change-Id: Ib2e25ededf89bca44c764477dd2f9127024ca78c
> > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
>
> Did you really run into an issue because of that?
>
> Calling amdgpu_vm_bo_rmv() shouldn't affect the page tables nor already
> submitted command submissions in any way.
>
> Regards,
> Christian.
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 --------
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 8 ++++++++
> >   2 files changed, 8 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 45484c0..e13cdde 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -694,14 +694,6 @@ void amdgpu_driver_postclose_kms(struct 
> drm_device *dev,
> >        amdgpu_uvd_free_handles(adev, file_priv);
> >        amdgpu_vce_free_handles(adev, file_priv);
> >
> > -     if (amdgpu_sriov_vf(adev)) {
> > -             /* TODO: how to handle reserve failure */
> > - BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, false));
> > -             amdgpu_vm_bo_rmv(adev, fpriv->vm.csa_bo_va);
> > -             fpriv->vm.csa_bo_va = NULL;
> > - amdgpu_bo_unreserve(adev->virt.csa_obj);
> > -     }
> > -
> >        amdgpu_vm_fini(adev, &fpriv->vm);
> >
> > idr_for_each_entry(&fpriv->bo_list_handles, list, handle)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index d05546e..94098bc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -1608,6 +1608,14 @@ void amdgpu_vm_fini(struct amdgpu_device 
> *adev, struct amdgpu_vm *vm)
> >
> >        amd_sched_entity_fini(vm->entity.sched, &vm->entity);
> >
> > +     if (amdgpu_sriov_vf(adev)) {
> > +             /* TODO: how to handle reserve failure */
> > + BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, false));
> > +             amdgpu_vm_bo_rmv(adev, vm->csa_bo_va);
> > +             vm->csa_bo_va = NULL;
> > + amdgpu_bo_unreserve(adev->virt.csa_obj);
> > +     }
> > +
> >        if (!RB_EMPTY_ROOT(&vm->va)) {
> >                dev_err(adev->dev, "still active bo inside vm\n");
> >        }
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------0E84747C94F1BCF76917282E
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Ah, in this case please separate the
      amdgpu_vm_bo_rmv() from setting csa_addr to NULL.<br>
      <br>
      Cause amdgpu_vm_bo_rmv() should come before amdgpu_vm_fini() and
      that in turn should become before waiting for the scheduler so
      that the MM knows that the memory is about to be freed.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 13.01.2017 um 10:56 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:BY2PR1201MB11102468908DDFD083C45B5384780-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <meta content="text/html; charset=UTF-8">
      <style type="text/css" style="">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
      <div dir="ltr">
        <div id="x_divtagdefaultwrapper" dir="ltr"
          style="font-size:12pt; color:#000000;
          font-family:Calibri,Arial,Helvetica,sans-serif">
          <p>only with amdgpu_vm_bo_rmv() won't has such bug, but in
            another branch for sriov, we not only call vm_bo_rmv(), and
            we also set csa_addr to NULL after it, so the NULL address
            is inserted in RB, and when preemption occured, CP backup
            snapshot to NULL address.</p>
          <p><br>
          </p>
          <p>although in staging-4.9 we didn't set csa_addr to NULL
            (because as you suggested we always use HARDCODE/MACRO for
            CSA address), but logically we'd better put CSA unmapping
            stuffs behind "sched_entity_fini", which is more reasonable
            ...</p>
          <p><br>
          </p>
          <p>BR Monk<br>
          </p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> 代表
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>发送时间:</b> 2017年1月13日 17:25:09<br>
            <b>收件人:</b> Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>主题:</b> Re: [PATCH] drm/amdgpu:put CSA unmap after
            sched_entity_fini</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Am 13.01.2017 um 05:11 schrieb Monk
            Liu:<br>
            &gt; otherwise CSA may unmapped before gpu_scheduler
            scheduling<br>
            &gt; jobs and trigger VM fault on CSA address<br>
            &gt;<br>
            &gt; Change-Id: Ib2e25ededf89bca44c764477dd2f9127024ca78c<br>
            &gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            <br>
            Did you really run into an issue because of that?<br>
            <br>
            Calling amdgpu_vm_bo_rmv() shouldn't affect the page tables
            nor already <br>
            submitted command submissions in any way.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            &gt; ---<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 --------<br>
            &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 8 ++++++++<br>
            &gt;   2 files changed, 8 insertions(+), 8 deletions(-)<br>
            &gt;<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
            &gt; index 45484c0..e13cdde 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c<br>
            &gt; @@ -694,14 +694,6 @@ void
            amdgpu_driver_postclose_kms(struct drm_device *dev,<br>
            &gt;        amdgpu_uvd_free_handles(adev, file_priv);<br>
            &gt;        amdgpu_vce_free_handles(adev, file_priv);<br>
            &gt;   <br>
            &gt; -     if (amdgpu_sriov_vf(adev)) {<br>
            &gt; -             /* TODO: how to handle reserve failure */<br>
            &gt; -            
            BUG_ON(amdgpu_bo_reserve(adev-&gt;virt.csa_obj, false));<br>
            &gt; -             amdgpu_vm_bo_rmv(adev,
            fpriv-&gt;vm.csa_bo_va);<br>
            &gt; -             fpriv-&gt;vm.csa_bo_va = NULL;<br>
            &gt; -            
            amdgpu_bo_unreserve(adev-&gt;virt.csa_obj);<br>
            &gt; -     }<br>
            &gt; -<br>
            &gt;        amdgpu_vm_fini(adev, &amp;fpriv-&gt;vm);<br>
            &gt;   <br>
            &gt;       
            idr_for_each_entry(&amp;fpriv-&gt;bo_list_handles, list,
            handle)<br>
            &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; index d05546e..94098bc 100644<br>
            &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; @@ -1608,6 +1608,14 @@ void amdgpu_vm_fini(struct
            amdgpu_device *adev, struct amdgpu_vm *vm)<br>
            &gt;   <br>
            &gt;        amd_sched_entity_fini(vm-&gt;entity.sched,
            &amp;vm-&gt;entity);<br>
            &gt;   <br>
            &gt; +     if (amdgpu_sriov_vf(adev)) {<br>
            &gt; +             /* TODO: how to handle reserve failure */<br>
            &gt; +            
            BUG_ON(amdgpu_bo_reserve(adev-&gt;virt.csa_obj, false));<br>
            &gt; +             amdgpu_vm_bo_rmv(adev, vm-&gt;csa_bo_va);<br>
            &gt; +             vm-&gt;csa_bo_va = NULL;<br>
            &gt; +            
            amdgpu_bo_unreserve(adev-&gt;virt.csa_obj);<br>
            &gt; +     }<br>
            &gt; +<br>
            &gt;        if (!RB_EMPTY_ROOT(&amp;vm-&gt;va)) {<br>
            &gt;                dev_err(adev-&gt;dev, "still active bo
            inside vm\n");<br>
            &gt;        }<br>
            <br>
            <br>
            _______________________________________________<br>
            amd-gfx mailing list<br>
            <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <a moz-do-not-send="true"
              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
          </div>
        </span></font>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------0E84747C94F1BCF76917282E--

--===============1544592784==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1544592784==--
