From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 0/8] shadow page table support V5 ---> shadow bo support
Date: Wed, 17 Aug 2016 16:16:32 +0200
Message-ID: <118a152b-7045-880b-26d6-7405b6148b18@vodafone.de>
References: <1471413919-27166-1-git-send-email-David1.Zhou@amd.com>
 <3f0da3d7-ac25-fd73-3b84-d913535512ca@vodafone.de>
 <DM5PR12MB1132177CBD3C3B4630BDE2F9F7140@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0319501555=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1132177CBD3C3B4630BDE2F9F7140-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0319501555==
Content-Type: multipart/alternative;
 boundary="------------9D7089C068F5A0B421CB8AAB"

This is a multi-part message in MIME format.
--------------9D7089C068F5A0B421CB8AAB
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Errors should actually be reported by the caller, not here.

So we should probably remove that DRM_ERROR here as well.

Christian.

Am 17.08.2016 um 16:10 schrieb StDenis, Tom:
>
> Why not be consistent and add a DRM_ERROR on all paths that include an 
> error?  e.g. instead of
>
>
> if (r)
>
>    goto error_free;
>
>
> Throw a DRM_ERROR("") in there.
>
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Wednesday, August 17, 2016 10:04
> *To:* Zhou, David(ChunMing); amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 0/8] shadow page table support V5 ---> shadow bo 
> support
> Patch #1:
>
> Could be that we need to add another module parameter to control this,
> but I think for now that should be sufficient.
>
> Patch is Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
>
> Patch #2:
>
> > +     if (direct_submit) {
> > +             r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs,
> > +                                    NULL, NULL, fence);
> > +             job->fence = fence_get(*fence);
> > +             if (r)
> > +                     DRM_ERROR("Error scheduling IBs (%d)\n", r);
> > +             amdgpu_job_free(job);
>
> When there is an error you should return the code as well.
>
> > +     } else {
> > +             r = amdgpu_job_submit(job, ring, &adev->mman.entity,
> > + AMDGPU_FENCE_OWNER_UNDEFINED, fence);
> > +             if (r)
> > +                     goto error_free;
> > +     }
> >
> >        return 0;
>
> Just changing this to to "return r;" should be sufficient.
>
> With that fixed the patch is Reviewed-by: Christian König
> <christian.koenig-5C7GfCeVMHo@public.gmane.org> as well.
>
> Patch #3:
>
> You mentioned that this isn't used during command submission but rather
> during GPU reset, correct?
>
> In this case I would advise not to use a member in the BO structure to
> note the backup direction and instead have one function for back and one
> for restoring the content (or note that as a parameter to the function).
>
> Otherwise we could run into trouble when the CS wants to backup
> something the GPU reset wants to restore at the same time.
>
> Patch #4: Was already reviewed by me.
>
> Patch #5:
>
> > +     pt = params->shadow ? vm->page_tables[pt_idx].entry.robj->shadow :
> > + vm->page_tables[pt_idx].entry.robj;
> You need to double check here if shadows are actually allocated or not.
> Otherwise we will crash on an APU.
>
> > +     /* double ndw, since need to update shadow pt bo as well */
> > +     ndw *= 2;
> > +
> We don't need to double the IB size, but only the number of commands in
> it (ncmds).
>
> The difference is when we want to write scattered GART entries. In this
> case I've added the PTEs to the end of the IB.
>
> Patch #6:
> > +     spinlock_t shadow_list_lock;
> We might want to use a mutex here instead. Usually I would agree that a
> spin lock is better for a linked list, but during the restore process in
> a GPU reset we probably want to sleep here.
>
> Alternatively you could splice the list to a local version on the stack,
> grab references to the BOs and then drop the lock during the restore
> process.
>
> > @@ -541,6 +546,13 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
> >        if ((*bo) == NULL)
> >                return;
> >
> > +     /* shadow must be freed before bo itself */
> > +     if ((!(*bo)->shadow) && !list_empty(&(*bo)->shadow_list)) {
> > + spin_lock(&(*bo)->adev->shadow_list_lock);
> > + list_del_init(&(*bo)->shadow_list);
> > + spin_unlock(&(*bo)->adev->shadow_list_lock);
> > +
> > +     }
> >        tbo = &((*bo)->tbo);
> >        ttm_bo_unref(&tbo);
> >        if (tbo == NULL)
> That would trigger even when we take a temporary reference. I suggest to
> add a amdgpu_bo_unref_shadow() function instead, unreferencing both the
> shadow and the normal BO.
>
> This can then be used in the VM code to cleanup the shadow created.
>
> Going to skip patch #7 and #8 for now cause our team call begins in a
> moment.
>
> Regards,
> Christian.
>
> Am 17.08.2016 um 08:05 schrieb Chunming Zhou:
> > Since we cannot ensure VRAM is consistent after a GPU reset, page
> > table shadowing is necessary. Shadowed page tables are, in a sense, a
> > method to recover the consistent state of the page tables before the
> > reset occurred.
> >
> > We need to allocate GTT bo as the shadow of VRAM bo when creating 
> page table,
> > and make them the same. After gpu reset, we will need to use SDMA to 
> copy GTT bo
> > content to VRAM bo, then page table will be recoveried.
> >
> >
> > V2:
> > Shadow bo uses a shadow entity running on normal run queue, after 
> gpu reset,
> > we need to wait for all shadow jobs finished first, then recovery 
> page table from shadow.
> >
> > V3:
> > Addressed Christian comments for shadow bo part.
> >
> > V4:
> > Switch back to update page table twice (one of two is for shadow)
> >
> > V5:
> > make it be gerneic shadow bo support. Address Christian comments.
> >
> > Chunming Zhou (8):
> >    drm/amdgpu: add need backup function V2
> >    drm/amdgpu: add direct submision option for copy_buffer
> >    drm/amdgpu: sync bo and shadow V2
> >    drm/amdgpu: update pd shadow while updating pd
> >    drm/amdgpu: update pt shadow while updating pt V2
> >    drm/amdgpu: link all shadow bo
> >    drm/amdgpu: implement recovery vram bo from shadow
> >    drm/amdgpu: recover vram bo from shadow after gpu reset
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 9 ++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 3 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 39 ++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 94 
> ++++++++++++++++++++++++++-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    | 9 +++
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      | 4 +-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 21 ++++--
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 69 
> ++++++++++++++------
> >   8 files changed, 215 insertions(+), 33 deletions(-)
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - lists.freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx 
> Archives. Using amd-gfx: To post a message to all the list members, 
> send email ...
>
>
>


--------------9D7089C068F5A0B421CB8AAB
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Errors should actually be reported by
      the caller, not here.<br>
      <br>
      So we should probably remove that DRM_ERROR here as well.<br>
      <br>
      Christian.<br>
      <br>
      Am 17.08.2016 um 16:10 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB1132177CBD3C3B4630BDE2F9F7140-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>Why not be consistent and add a DRM_ERROR on all paths that
          include an error?  e.g. instead of </p>
        <p><br>
        </p>
        <p>if (r)</p>
        <p>   goto error_free;</p>
        <p><br>
        </p>
        <p>Throw a DRM_ERROR("") in there.</p>
        <p><br>
        </p>
        <p>Tom</p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf
                of Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Wednesday, August 17, 2016 10:04<br>
                <b>To:</b> Zhou, David(ChunMing);
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH 0/8] shadow page table
                support V5 ---&gt; shadow bo support</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Patch #1:<br>
                <br>
                Could be that we need to add another module parameter to
                control this, <br>
                but I think for now that should be sufficient.<br>
                <br>
                Patch is Reviewed-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <br>
                Patch #2:<br>
                <br>
                &gt; +     if (direct_submit) {<br>
                &gt; +             r = amdgpu_ib_schedule(ring,
                job-&gt;num_ibs, job-&gt;ibs,<br>
                &gt; +                                    NULL, NULL,
                fence);<br>
                &gt; +             job-&gt;fence = fence_get(*fence);<br>
                &gt; +             if (r)<br>
                &gt; +                     DRM_ERROR("Error scheduling
                IBs (%d)\n", r);<br>
                &gt; +             amdgpu_job_free(job);<br>
                <br>
                When there is an error you should return the code as
                well.<br>
                <br>
                &gt; +     } else {<br>
                &gt; +             r = amdgpu_job_submit(job, ring,
                &amp;adev-&gt;mman.entity,<br>
                &gt; +                                  
                AMDGPU_FENCE_OWNER_UNDEFINED, fence);<br>
                &gt; +             if (r)<br>
                &gt; +                     goto error_free;<br>
                &gt; +     }<br>
                &gt;   <br>
                &gt;        return 0;<br>
                <br>
                Just changing this to to "return r;" should be
                sufficient.<br>
                <br>
                With that fixed the patch is Reviewed-by: Christian
                König <br>
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> as well.<br>
                <br>
                Patch #3:<br>
                <br>
                You mentioned that this isn't used during command
                submission but rather <br>
                during GPU reset, correct?<br>
                <br>
                In this case I would advise not to use a member in the
                BO structure to <br>
                note the backup direction and instead have one function
                for back and one <br>
                for restoring the content (or note that as a parameter
                to the function).<br>
                <br>
                Otherwise we could run into trouble when the CS wants to
                backup <br>
                something the GPU reset wants to restore at the same
                time.<br>
                <br>
                Patch #4: Was already reviewed by me.<br>
                <br>
                Patch #5:<br>
                <br>
                &gt; +     pt = params-&gt;shadow ?
                vm-&gt;page_tables[pt_idx].entry.robj-&gt;shadow :<br>
                &gt; +            
                vm-&gt;page_tables[pt_idx].entry.robj;<br>
                You need to double check here if shadows are actually
                allocated or not. <br>
                Otherwise we will crash on an APU.<br>
                <br>
                &gt; +     /* double ndw, since need to update shadow pt
                bo as well */<br>
                &gt; +     ndw *= 2;<br>
                &gt; +<br>
                We don't need to double the IB size, but only the number
                of commands in <br>
                it (ncmds).<br>
                <br>
                The difference is when we want to write scattered GART
                entries. In this <br>
                case I've added the PTEs to the end of the IB.<br>
                <br>
                Patch #6:<br>
                &gt; +     spinlock_t                     
                shadow_list_lock;<br>
                We might want to use a mutex here instead. Usually I
                would agree that a <br>
                spin lock is better for a linked list, but during the
                restore process in <br>
                a GPU reset we probably want to sleep here.<br>
                <br>
                Alternatively you could splice the list to a local
                version on the stack, <br>
                grab references to the BOs and then drop the lock during
                the restore <br>
                process.<br>
                <br>
                &gt; @@ -541,6 +546,13 @@ void amdgpu_bo_unref(struct
                amdgpu_bo **bo)<br>
                &gt;        if ((*bo) == NULL)<br>
                &gt;                return;<br>
                &gt;   <br>
                &gt; +     /* shadow must be freed before bo itself */<br>
                &gt; +     if ((!(*bo)-&gt;shadow) &amp;&amp;
                !list_empty(&amp;(*bo)-&gt;shadow_list)) {<br>
                &gt; +            
                spin_lock(&amp;(*bo)-&gt;adev-&gt;shadow_list_lock);<br>
                &gt; +            
                list_del_init(&amp;(*bo)-&gt;shadow_list);<br>
                &gt; +            
                spin_unlock(&amp;(*bo)-&gt;adev-&gt;shadow_list_lock);<br>
                &gt; +<br>
                &gt; +     }<br>
                &gt;        tbo = &amp;((*bo)-&gt;tbo);<br>
                &gt;        ttm_bo_unref(&amp;tbo);<br>
                &gt;        if (tbo == NULL)<br>
                That would trigger even when we take a temporary
                reference. I suggest to <br>
                add a amdgpu_bo_unref_shadow() function instead,
                unreferencing both the <br>
                shadow and the normal BO.<br>
                <br>
                This can then be used in the VM code to cleanup the
                shadow created.<br>
                <br>
                Going to skip patch #7 and #8 for now cause our team
                call begins in a <br>
                moment.<br>
                <br>
                Regards,<br>
                Christian.<br>
                <br>
                Am 17.08.2016 um 08:05 schrieb Chunming Zhou:<br>
                &gt; Since we cannot ensure VRAM is consistent after a
                GPU reset, page<br>
                &gt; table shadowing is necessary. Shadowed page tables
                are, in a sense, a<br>
                &gt; method to recover the consistent state of the page
                tables before the<br>
                &gt; reset occurred.<br>
                &gt;<br>
                &gt; We need to allocate GTT bo as the shadow of VRAM bo
                when creating page table,<br>
                &gt; and make them the same. After gpu reset, we will
                need to use SDMA to copy GTT bo<br>
                &gt; content to VRAM bo, then page table will be
                recoveried.<br>
                &gt;<br>
                &gt;<br>
                &gt; V2:<br>
                &gt; Shadow bo uses a shadow entity running on normal
                run queue, after gpu reset,<br>
                &gt; we need to wait for all shadow jobs finished first,
                then recovery page table from shadow.<br>
                &gt;<br>
                &gt; V3:<br>
                &gt; Addressed Christian comments for shadow bo part.<br>
                &gt;<br>
                &gt; V4:<br>
                &gt; Switch back to update page table twice (one of two
                is for shadow)<br>
                &gt;<br>
                &gt; V5:<br>
                &gt; make it be gerneic shadow bo support. Address
                Christian comments.<br>
                &gt;<br>
                &gt; Chunming Zhou (8):<br>
                &gt;    drm/amdgpu: add need backup function V2<br>
                &gt;    drm/amdgpu: add direct submision option for
                copy_buffer<br>
                &gt;    drm/amdgpu: sync bo and shadow V2<br>
                &gt;    drm/amdgpu: update pd shadow while updating pd<br>
                &gt;    drm/amdgpu: update pt shadow while updating pt
                V2<br>
                &gt;    drm/amdgpu: link all shadow bo<br>
                &gt;    drm/amdgpu: implement recovery vram bo from
                shadow<br>
                &gt;    drm/amdgpu: recover vram bo from shadow after
                gpu reset<br>
                &gt;<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 
                9 ++-<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 
                3 +-<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |
                39 ++++++++++-<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |
                94 ++++++++++++++++++++++++++-<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    | 
                9 +++<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_test.c      | 
                4 +-<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |
                21 ++++--<br>
                &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |
                69 ++++++++++++++------<br>
                &gt;   8 files changed, 215 insertions(+), 33
                deletions(-)<br>
                &gt;<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  id="LPlnk214970">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                <div id="LPBorder_GT_14714429737800.4406300387876183"
                  style="margin-bottom: 20px; overflow: auto; width:
                  100%; text-indent: 0px;">
                  <table
                    id="LPContainer_14714429737780.3993206472027586"
                    style="width: 90%; position: relative; overflow:
                    auto; padding-top: 20px; padding-bottom: 20px;
                    margin-top: 20px; border-top: 1px dotted rgb(200,
                    200, 200); border-bottom: 1px dotted rgb(200, 200,
                    200); background-color: rgb(255, 255, 255);"
                    cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td
                          id="TextCell_14714429737790.7705126490415855"
                          colspan="2" style="vertical-align: top;
                          position: relative; padding: 0px; display:
                          table-cell;">
                          <div
                            id="LPTitle_14714429737790.7634184458877278"
                            style="top: 0px; color: rgb(59, 87, 119);
                            font-weight: normal; font-size: 21px;
                            font-family: wf_segoe-ui_light, &quot;Segoe
                            UI Light&quot;, &quot;Segoe WP Light&quot;,
                            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
                            Tahoma, Arial, sans-serif; line-height:
                            21px;">
                            <a moz-do-not-send="true"
                              id="LPUrlAnchor_14714429737790.6135333253292945"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                              target="_blank" style="text-decoration:
                              none;">amd-gfx Info Page -
                              lists.freedesktop.org</a></div>
                          <div
                            id="LPMetadata_14714429737790.9058058508163938"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); font-weight: normal;
                            font-family: wf_segoe-ui_normal, &quot;Segoe
                            UI&quot;, &quot;Segoe WP&quot;, Tahoma,
                            Arial, sans-serif; font-size: 14px;
                            line-height: 14px;">
                            lists.freedesktop.org</div>
                          <div
                            id="LPDescription_14714429737800.03199008072574672"
                            style="display: block; color: rgb(102, 102,
                            102); font-weight: normal; font-family:
                            wf_segoe-ui_normal, &quot;Segoe UI&quot;,
                            &quot;Segoe WP&quot;, Tahoma, Arial,
                            sans-serif; font-size: 14px; line-height:
                            20px; max-height: 100px; overflow: hidden;">
                            To see the collection of prior postings to
                            the list, visit the amd-gfx Archives. Using
                            amd-gfx: To post a message to all the list
                            members, send email ...</div>
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
  </body>
</html>

--------------9D7089C068F5A0B421CB8AAB--

--===============0319501555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0319501555==--
