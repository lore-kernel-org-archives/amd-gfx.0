From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix addr handling in
 amdgpu_vm_bo_update_mapping
Date: Mon, 26 Sep 2016 17:12:12 +0200
Message-ID: <c6238048-9393-e20c-2b03-6ff11c82ea45@vodafone.de>
References: <1474797313-1994-1-git-send-email-deathsimple@vodafone.de>
 <20160926071900.GF9691@flora> <20160926091624.GG9691@flora>
 <5336fe95-9645-0c9c-e948-1e51811ad907@vodafone.de>
 <CY4PR12MB1768C24C35861367BAD1BA07F7CD0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1783314983=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768C24C35861367BAD1BA07F7CD0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "Cui, Flora" <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
Cc: "Huang, Ray" <Ray.Huang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1783314983==
Content-Type: multipart/alternative;
 boundary="------------52CA9A4A070EA9A61910D63F"

This is a multi-part message in MIME format.
--------------52CA9A4A070EA9A61910D63F
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

The function called is either amdgpu_vm_do_set_ptes() or 
amdgpu_vm_do_copy_ptes().

But that is actually rather unrelated to the local handling of addr in 
the function changed.

The point here is we have handled the address offset by giving it to 
amdgpu_vm_map_gart() and so we shouldn't add the address again.

Regards,
Christian.

Am 26.09.2016 um 15:46 schrieb StDenis, Tom:
>
> I'm reading through the amdgpu_vm.c to try and see if the patch is 
> correct but I'm not that familiar with the VM side of things.  It 
> seems to boil down to calling params->func() with a new dst value of 
> NULL but that's where I'm stopped at the moment since I don't know 
> what func() is.  Nothing up to that point looks overtly wrong (like 
> trying to use that address as a source for a read/write).
>
>
> Tom
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Monday, September 26, 2016 09:29
> *To:* Cui, Flora
> *Cc:* Huang, Ray; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amdgpu: fix addr handling in 
> amdgpu_vm_bo_update_mapping
> Yeah, that wouldn't really help but just make the problem more unlikely
> to happen once more.
>
> Anyway Tom St confirmed that the patch seems to work for the open stack.
>
> Anybody brave enough to throw an rb on this so that I can commit it?
>
> Thanks,
> Christian.
>
> Am 26.09.2016 um 11:16 schrieb Flora Cui:
> > please ignore this patch. it actually revert the gtt mgr changes.
> >
> > On Mon, Sep 26, 2016 at 03:19:01PM +0800, Flora Cui wrote:
> >> On Sun, Sep 25, 2016 at 11:55:13AM +0200, Christian König wrote:
> >>> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >>>
> >>> Otherwise we will look at the wrong place in the IB when GART
> >>> mappings are split into smaller updates.
> >>>
> >>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >>> ---
> >>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 +
> >>>   1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> index 2bb78dc..da31189 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>> @@ -1017,6 +1017,7 @@ static int 
> amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
> >>>AMDGPU_GPU_PAGE_SIZE);
> >>>                      pte[i] |= flags;
> >>>              }
> >>> +           addr = 0;
> >>>      }
> >>>
> >>>      r = amdgpu_sync_fence(adev, &job->sync, exclusive);
> >>> --
> >>> 2.5.0
> >>>
> >>>
> >> IMHO this could fix the vmfault issue.
> >>
> >> 8<---
> >>  From cc7b5618665defd88e2adcd6f735562ecd784298 Mon Sep 17 00:00:00 2001
> >> From: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
> >> Date: Mon, 26 Sep 2016 15:14:02 +0800
> >> Subject: [PATCH] drm/amdgpu: add ttm_bind in amdgpu_vm_bo_update()
> >>
> >> Change-Id: If73d5b06e9188e40250ccdfd1a2a659ed1ef52a6
> >> Signed-off-by: Flora Cui <Flora.Cui-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >> index 2bb78dc..7f17127 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >> @@ -1166,6 +1166,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device 
> *adev,
> >>                       ttm = container_of(bo_va->bo->tbo.ttm, struct
> >> ttm_dma_tt, ttm);
> >>                       pages_addr = ttm->dma_address;
> >> + amdgpu_ttm_bind(&bo_va->bo->tbo, mem);
> >> +                    addr = (u64)mem->start << PAGE_SHIFT;
> >>                       break;
> >>
> >>               case TTM_PL_VRAM:
> >> --
> >> 2.7.4
> >>
> >>
> >> _______________________________________________
> >> amd-gfx mailing list
> >> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> >> https://lists.freedesktop.org/mailman/listinfo/amd-gfx 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> amd-gfx Info Page - lists.freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx 
> Archives. Using amd-gfx: To post a message to all the list members, 
> send email ...
>
>
>
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------52CA9A4A070EA9A61910D63F
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=windows-1252"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">The function called is either
      amdgpu_vm_do_set_ptes() or amdgpu_vm_do_copy_ptes().<br>
      <br>
      But that is actually rather unrelated to the local handling of
      addr in the function changed.<br>
      <br>
      The point here is we have handled the address offset by giving it
      to amdgpu_vm_map_gart() and so we shouldn't add the address again.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 26.09.2016 um 15:46 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1768C24C35861367BAD1BA07F7CD0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>I'm reading through the amdgpu_vm.c to try and see if the
          patch is correct but I'm not that familiar with the VM side of
          things.  It seems to boil down to calling params-&gt;func()
          with a new dst value of NULL but that's where I'm stopped at
          the moment since I don't know what func() is.  Nothing up to
          that point looks overtly wrong (like trying to use that
          address as a source for a read/write).</p>
        <p><br>
        </p>
        <p>Tom</p>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf
                of Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Monday, September 26, 2016 09:29<br>
                <b>To:</b> Cui, Flora<br>
                <b>Cc:</b> Huang, Ray; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: fix addr
                handling in amdgpu_vm_bo_update_mapping</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Yeah, that wouldn't really help but
                just make the problem more unlikely
                <br>
                to happen once more.<br>
                <br>
                Anyway Tom St confirmed that the patch seems to work for
                the open stack.<br>
                <br>
                Anybody brave enough to throw an rb on this so that I
                can commit it?<br>
                <br>
                Thanks,<br>
                Christian.<br>
                <br>
                Am 26.09.2016 um 11:16 schrieb Flora Cui:<br>
                &gt; please ignore this patch. it actually revert the
                gtt mgr changes.<br>
                &gt;<br>
                &gt; On Mon, Sep 26, 2016 at 03:19:01PM +0800, Flora Cui
                wrote:<br>
                &gt;&gt; On Sun, Sep 25, 2016 at 11:55:13AM +0200,
                Christian König wrote:<br>
                &gt;&gt;&gt; From: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; Otherwise we will look at the wrong place
                in the IB when GART<br>
                &gt;&gt;&gt; mappings are split into smaller updates.<br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; Signed-off-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt;&gt;&gt; ---<br>
                &gt;&gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |
                1 +<br>
                &gt;&gt;&gt;   1 file changed, 1 insertion(+)<br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt;&gt;&gt; index 2bb78dc..da31189 100644<br>
                &gt;&gt;&gt; ---
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt;&gt;&gt; +++
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt;&gt;&gt; @@ -1017,6 +1017,7 @@ static int
                amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,<br>
&gt;&gt;&gt;                                                 
                AMDGPU_GPU_PAGE_SIZE);<br>
                &gt;&gt;&gt;                      pte[i] |= flags;<br>
                &gt;&gt;&gt;              }<br>
                &gt;&gt;&gt; +           addr = 0;<br>
                &gt;&gt;&gt;      }<br>
                &gt;&gt;&gt;   <br>
                &gt;&gt;&gt;      r = amdgpu_sync_fence(adev,
                &amp;job-&gt;sync, exclusive);<br>
                &gt;&gt;&gt; -- <br>
                &gt;&gt;&gt; 2.5.0<br>
                &gt;&gt;&gt;<br>
                &gt;&gt;&gt;<br>
                &gt;&gt; IMHO this could fix the vmfault issue.<br>
                &gt;&gt;<br>
                &gt;&gt; 8&lt;---<br>
                &gt;&gt;  From cc7b5618665defd88e2adcd6f735562ecd784298
                Mon Sep 17 00:00:00 2001<br>
                &gt;&gt; From: Flora Cui <a class="moz-txt-link-rfc2396E" href="mailto:Flora.Cui-5C7GfCeVMHo@public.gmane.org">&lt;Flora.Cui-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt;&gt; Date: Mon, 26 Sep 2016 15:14:02 +0800<br>
                &gt;&gt; Subject: [PATCH] drm/amdgpu: add ttm_bind in
                amdgpu_vm_bo_update()<br>
                &gt;&gt;<br>
                &gt;&gt; Change-Id:
                If73d5b06e9188e40250ccdfd1a2a659ed1ef52a6<br>
                &gt;&gt; Signed-off-by: Flora Cui
                <a class="moz-txt-link-rfc2396E" href="mailto:Flora.Cui-5C7GfCeVMHo@public.gmane.org">&lt;Flora.Cui-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt;&gt; ---<br>
                &gt;&gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++<br>
                &gt;&gt;   1 file changed, 2 insertions(+)<br>
                &gt;&gt;<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt;&gt; index 2bb78dc..7f17127 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                &gt;&gt; @@ -1166,6 +1166,8 @@ int
                amdgpu_vm_bo_update(struct amdgpu_device *adev,<br>
                &gt;&gt;                       ttm =
                container_of(bo_va-&gt;bo-&gt;tbo.ttm, struct<br>
                &gt;&gt;                                         
                ttm_dma_tt, ttm);<br>
                &gt;&gt;                       pages_addr =
                ttm-&gt;dma_address;<br>
                &gt;&gt; +                   
                amdgpu_ttm_bind(&amp;bo_va-&gt;bo-&gt;tbo, mem);<br>
                &gt;&gt; +                    addr = (u64)mem-&gt;start
                &lt;&lt; PAGE_SHIFT;<br>
                &gt;&gt;                       break;<br>
                &gt;&gt;   <br>
                &gt;&gt;               case TTM_PL_VRAM:<br>
                &gt;&gt; -- <br>
                &gt;&gt; 2.7.4<br>
                &gt;&gt;<br>
                &gt;&gt;<br>
                &gt;&gt; _______________________________________________<br>
                &gt;&gt; amd-gfx mailing list<br>
                &gt;&gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                &gt;&gt; <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  id="LPlnk752113">
                  https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                <div id="LPBorder_GT_14748974921180.061148974248180776"
                  style="margin-bottom: 20px; overflow: auto; width:
                  100%; text-indent: 0px;">
                  <table
                    id="LPContainer_14748974921150.5420295662969261"
                    style="width: 90%; background-color: rgb(255, 255,
                    255); position: relative; overflow: auto;
                    padding-top: 20px; padding-bottom: 20px; margin-top:
                    20px; border-top: 1px dotted rgb(200, 200, 200);
                    border-bottom: 1px dotted rgb(200, 200, 200);"
                    cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td
                          id="TextCell_14748974921160.9203516131537464"
                          colspan="2" style="vertical-align: top;
                          position: relative; padding: 0px; display:
                          table-cell;">
                          <div
                            id="LPTitle_14748974921170.667584414663523"
                            style="top: 0px; color: rgb(59, 87, 119);
                            font-weight: normal; font-size: 21px;
                            font-family: wf_segoe-ui_light, &quot;Segoe
                            UI Light&quot;, &quot;Segoe WP Light&quot;,
                            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
                            Tahoma, Arial, sans-serif; line-height:
                            21px;">
                            <a moz-do-not-send="true"
                              id="LPUrlAnchor_14748974921170.2600095206173294"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                              target="_blank" style="text-decoration:
                              none;">amd-gfx Info Page -
                              lists.freedesktop.org</a></div>
                          <div
                            id="LPMetadata_14748974921170.8198680036506909"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); font-weight: normal;
                            font-family: wf_segoe-ui_normal, &quot;Segoe
                            UI&quot;, &quot;Segoe WP&quot;, Tahoma,
                            Arial, sans-serif; font-size: 14px;
                            line-height: 14px;">
                            lists.freedesktop.org</div>
                          <div
                            id="LPDescription_14748974921180.08916125964466382"
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
                &gt; _______________________________________________<br>
                &gt; amd-gfx mailing list<br>
                &gt; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                &gt; <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
                <br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------52CA9A4A070EA9A61910D63F--

--===============1783314983==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1783314983==--
