From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: =?UTF-8?B?UmU6IOetlOWkjTog562U5aSNOiBbUEFUQ0ggNy83XSBkcm0vYW1kZ3B1?=
 =?UTF-8?Q?:map/unmap_static_csa_accordingly?=
Date: Tue, 10 Jan 2017 13:19:49 +0100
Message-ID: <2e2f00da-a5b6-1ade-6061-dba03cef697b@vodafone.de>
References: <1483948982-27056-1-git-send-email-Monk.Liu@amd.com>
 <1483948982-27056-8-git-send-email-Monk.Liu@amd.com>
 <4f78e5dd-f7e8-0976-5abf-305e0b793ba1@vodafone.de>
 <BY2PR1201MB11108A5E8A3EF7F10C0392AE84670@BY2PR1201MB1110.namprd12.prod.outlook.com>
 <cd95519f-f45b-6865-0fab-e75a970a48b0@vodafone.de>
 <BY2PR1201MB1110632E66A596FA820250E584670@BY2PR1201MB1110.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1910182533=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY2PR1201MB1110632E66A596FA820250E584670-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
--===============1910182533==
Content-Type: multipart/alternative;
 boundary="------------2E4AD5CD15CAB4CD501A6D1D"

This is a multi-part message in MIME format.
--------------2E4AD5CD15CAB4CD501A6D1D
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> Do you suggest that rip out of amdgpu_map_csa() routine totally,
>
Yes, mapping the CSA is not something specific to virtualization, so we 
shouldn't put that into amdgpu_virt.c.

> and manually call "amdgpu_vm_bo_map" as well as "amdgpu_vm_bo_update" 
> in sequence in "amdgpu_vm_bo_update" ?
>
No, during command submission it is to late to allocate the PT. Better 
put this a layer up into amdgpu_driver_open_kms() after the VM is 
initialized.

Regards,
Christian.

Am 10.01.2017 um 10:53 schrieb Liu, Monk:
>
> then what about "amdgpu_vm_bo_map" ? we need call it first before call 
> "amdgpu_vm_bo_update" in "amdgpu_bo_vm_update_pte" , correct ? 
> otherwise we even not create PT bo for the CSA ...
>
>
> Do you suggest that rip out of amdgpu_map_csa() routine totally, and 
> manually call "amdgpu_vm_bo_map" as well as "amdgpu_vm_bo_update" in 
> sequence in "amdgpu_vm_bo_update" ?
>
>
> BR Monk
>
> ------------------------------------------------------------------------
> *发件人:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *发送时间:* 2017年1月10日 17:44:21
> *收件人:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *主题:* Re: 答复: [PATCH 7/7] drm/amdgpu:map/unmap static csa accordingly
> Adding the BO and it's mapping is VM specific code, we should initialize
> that directly in amdgpu_vm_init() and not call any helper to delegate
> the work.
>
> Especially don't call from the VM code into the virt code and back into
> the VM code.
>
> If you really want to keep that in amdgpu_virt. an alternative would be
> to put the call into amdgpu_driver_open_kms() directly after calling
> amdgpu_vm_init().
>
> Regards,
> Christian.
>
> Am 10.01.2017 um 03:40 schrieb Liu, Monk:
> >
> > why you want to drop that "adev->virt.map_csa()" calling ?  without
> > that calling you don't have CSA's initialized bo_va and mappings as
> > well, and without bo_va and mappings how you can make
> > "amdgpu_vm_bo_update()" invoke work ?
> >
> >
> > Monk
> >
> > ------------------------------------------------------------------------
> > *发件人:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> > *发送时间:* 2017年1月9日 19:04:44
> > *收件人:* Liu, Monk; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> > *主题:* Re: [PATCH 7/7] drm/amdgpu:map/unmap static csa accordingly
> > Am 09.01.2017 um 09:03 schrieb Monk Liu:
> > > and update CSA bo_va in each submit
> > >
> > > Change-Id: I5ed73e1b7f89743d90298bc814a42a91e166be3b
> > > Signed-off-by: Monk Liu <Monk.Liu-5C7GfCeVMHo@public.gmane.org>
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 14 ++++++++++++++
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++++++
> > >   2 files changed, 25 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > index 6159afc..083ab73 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > > @@ -771,6 +771,20 @@ static int amdgpu_bo_vm_update_pte(struct
> > amdgpu_cs_parser *p,
> > >        if (r)
> > >                return r;
> > >
> > > +     if (amdgpu_sriov_vf(adev)) {
> > > +             struct fence *f;
> >
> > A new line is needed between deceleration and code.
> >
> > > +             bo_va = vm->vm_virt.csa_bo_va;
> > > +             BUG_ON(!bo_va);
> > > +             r = amdgpu_vm_bo_update(adev, bo_va, false);
> > > +             if (r)
> > > +                     return r;
> > > +
> > > +             f = bo_va->last_pt_update;
> > > +             r = amdgpu_sync_fence(adev, &p->job->sync, f);
> > > +             if (r)
> > > +                     return r;
> > > +     }
> > > +
> > >        if (p->bo_list) {
> > >                for (i = 0; i < p->bo_list->num_entries; i++) {
> > >                        struct fence *f;
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > index d05546e..b9cd686 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > > @@ -1576,6 +1576,14 @@ int amdgpu_vm_init(struct amdgpu_device
> > *adev, struct amdgpu_vm *vm)
> > >        vm->last_eviction_counter = 
> atomic64_read(&adev->num_evictions);
> > >        amdgpu_bo_unreserve(vm->page_directory);
> > >
> > > +     if (amdgpu_sriov_vf(adev)) {
> > > +             BUG_ON(!adev->virt.map_csa);
> > > +             BUG_ON(!adev->virt.unmap_csa);
> > > +             r = adev->virt.map_csa(adev, vm);
> > > +             if (r)
> > > +                     goto error_free_page_directory;
> > > +     }
> > > +
> >
> > Just completely drop that. Updating the VM on the first command
> > submission should be sufficient.
> >
> > Christian.
> >
> > >        return 0;
> > >
> > >   error_free_page_directory:
> > > @@ -1606,6 +1614,9 @@ void amdgpu_vm_fini(struct amdgpu_device
> > *adev, struct amdgpu_vm *vm)
> > >        struct amdgpu_bo_va_mapping *mapping, *tmp;
> > >        int i;
> > >
> > > +     if (amdgpu_sriov_vf(adev))
> > > +             adev->virt.unmap_csa(adev, vm);
> > > +
> > >        amd_sched_entity_fini(vm->entity.sched, &vm->entity);
> > >
> > >        if (!RB_EMPTY_ROOT(&vm->va)) {
> >
> >
>


--------------2E4AD5CD15CAB4CD501A6D1D
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <p>Do you suggest that rip out of amdgpu_map_csa() routine
          totally,</p>
      </blockquote>
      Yes, mapping the CSA is not something specific to virtualization,
      so we shouldn't put that into amdgpu_virt.c.<br>
      <br>
      <blockquote type="cite">
        <p> and manually call "<span>amdgpu_vm_bo_map</span>" as well as
          "<span>amdgpu_vm_bo_update</span>" in sequence in "<span>amdgpu_vm_bo_update</span>"
          ?</p>
      </blockquote>
      No, during command submission it is to late to allocate the PT.
      Better put this a layer up into amdgpu_driver_open_kms() after the
      VM is initialized.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 10.01.2017 um 10:53 schrieb Liu, Monk:<br>
    </div>
    <blockquote
cite="mid:BY2PR1201MB1110632E66A596FA820250E584670-O28G1zQ8oGliQkyLPkmea2rFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org"
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
          <p>then what about "<span>amdgpu_vm_bo_map</span>" ? we need
            call it first before call "<span>amdgpu_vm_bo_update</span>"
            in "<span>amdgpu_bo_vm_update_pte</span>" , correct ?
            otherwise we even not create PT bo for the CSA ... </p>
          <p><br>
          </p>
          <p>Do you suggest that rip out of amdgpu_map_csa() routine
            totally, and manually call "<span>amdgpu_vm_bo_map</span>"
            as well as "<span>amdgpu_vm_bo_update</span>" in sequence in
            "<span>amdgpu_vm_bo_update</span>" ?</p>
          <p><br>
          </p>
          <p>BR Monk</p>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="x_divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            color="#000000" face="Calibri, sans-serif"><b>发件人:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            <b>发送时间:</b> 2017年1月10日 17:44:21<br>
            <b>收件人:</b> Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            <b>主题:</b> Re: 答复: [PATCH 7/7] drm/amdgpu:map/unmap static
            csa accordingly</font>
          <div> </div>
        </div>
      </div>
      <font size="2"><span style="font-size:10pt;">
          <div class="PlainText">Adding the BO and it's mapping is VM
            specific code, we should initialize
            <br>
            that directly in amdgpu_vm_init() and not call any helper to
            delegate <br>
            the work.<br>
            <br>
            Especially don't call from the VM code into the virt code
            and back into <br>
            the VM code.<br>
            <br>
            If you really want to keep that in amdgpu_virt. an
            alternative would be <br>
            to put the call into amdgpu_driver_open_kms() directly after
            calling <br>
            amdgpu_vm_init().<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            Am 10.01.2017 um 03:40 schrieb Liu, Monk:<br>
            &gt;<br>
            &gt; why you want to drop that "adev-&gt;virt.map_csa()"
            calling ?  without <br>
            &gt; that calling you don't have CSA's initialized bo_va and
            mappings as <br>
            &gt; well, and without bo_va and mappings how you can make <br>
            &gt; "amdgpu_vm_bo_update()" invoke work ?<br>
            &gt;<br>
            &gt;<br>
            &gt; Monk<br>
            &gt;<br>
            &gt;
            ------------------------------------------------------------------------<br>
            &gt; *发件人:* Christian König <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
            &gt; *发送时间:* 2017年1月9日 19:04:44<br>
            &gt; *收件人:* Liu, Monk; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
            &gt; *主题:* Re: [PATCH 7/7] drm/amdgpu:map/unmap static csa
            accordingly<br>
            &gt; Am 09.01.2017 um 09:03 schrieb Monk Liu:<br>
            &gt; &gt; and update CSA bo_va in each submit<br>
            &gt; &gt;<br>
            &gt; &gt; Change-Id:
            I5ed73e1b7f89743d90298bc814a42a91e166be3b<br>
            &gt; &gt; Signed-off-by: Monk Liu <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu-5C7GfCeVMHo@public.gmane.org">&lt;Monk.Liu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt; &gt; ---<br>
            &gt; &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 14
            ++++++++++++++<br>
            &gt; &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11
            +++++++++++<br>
            &gt; &gt;   2 files changed, 25 insertions(+)<br>
            &gt; &gt;<br>
            &gt; &gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            &gt; &gt; index 6159afc..083ab73 100644<br>
            &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
            &gt; &gt; @@ -771,6 +771,20 @@ static int
            amdgpu_bo_vm_update_pte(struct <br>
            &gt; amdgpu_cs_parser *p,<br>
            &gt; &gt;        if (r)<br>
            &gt; &gt;                return r;<br>
            &gt; &gt;<br>
            &gt; &gt; +     if (amdgpu_sriov_vf(adev)) {<br>
            &gt; &gt; +             struct fence *f;<br>
            &gt;<br>
            &gt; A new line is needed between deceleration and code.<br>
            &gt;<br>
            &gt; &gt; +             bo_va = vm-&gt;vm_virt.csa_bo_va;<br>
            &gt; &gt; +             BUG_ON(!bo_va);<br>
            &gt; &gt; +             r = amdgpu_vm_bo_update(adev, bo_va,
            false);<br>
            &gt; &gt; +             if (r)<br>
            &gt; &gt; +                     return r;<br>
            &gt; &gt; +<br>
            &gt; &gt; +             f = bo_va-&gt;last_pt_update;<br>
            &gt; &gt; +             r = amdgpu_sync_fence(adev,
            &amp;p-&gt;job-&gt;sync, f);<br>
            &gt; &gt; +             if (r)<br>
            &gt; &gt; +                     return r;<br>
            &gt; &gt; +     }<br>
            &gt; &gt; +<br>
            &gt; &gt;        if (p-&gt;bo_list) {<br>
            &gt; &gt;                for (i = 0; i &lt;
            p-&gt;bo_list-&gt;num_entries; i++) {<br>
            &gt; &gt;                        struct fence *f;<br>
            &gt; &gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
            &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; &gt; index d05546e..b9cd686 100644<br>
            &gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt; &gt; @@ -1576,6 +1576,14 @@ int amdgpu_vm_init(struct
            amdgpu_device <br>
            &gt; *adev, struct amdgpu_vm *vm)<br>
            &gt; &gt;        vm-&gt;last_eviction_counter =
            atomic64_read(&amp;adev-&gt;num_evictions);<br>
            &gt; &gt;        amdgpu_bo_unreserve(vm-&gt;page_directory);<br>
            &gt; &gt;<br>
            &gt; &gt; +     if (amdgpu_sriov_vf(adev)) {<br>
            &gt; &gt; +             BUG_ON(!adev-&gt;virt.map_csa);<br>
            &gt; &gt; +             BUG_ON(!adev-&gt;virt.unmap_csa);<br>
            &gt; &gt; +             r = adev-&gt;virt.map_csa(adev, vm);<br>
            &gt; &gt; +             if (r)<br>
            &gt; &gt; +                     goto
            error_free_page_directory;<br>
            &gt; &gt; +     }<br>
            &gt; &gt; +<br>
            &gt;<br>
            &gt; Just completely drop that. Updating the VM on the first
            command<br>
            &gt; submission should be sufficient.<br>
            &gt;<br>
            &gt; Christian.<br>
            &gt;<br>
            &gt; &gt;        return 0;<br>
            &gt; &gt;<br>
            &gt; &gt;   error_free_page_directory:<br>
            &gt; &gt; @@ -1606,6 +1614,9 @@ void amdgpu_vm_fini(struct
            amdgpu_device <br>
            &gt; *adev, struct amdgpu_vm *vm)<br>
            &gt; &gt;        struct amdgpu_bo_va_mapping *mapping, *tmp;<br>
            &gt; &gt;        int i;<br>
            &gt; &gt;<br>
            &gt; &gt; +     if (amdgpu_sriov_vf(adev))<br>
            &gt; &gt; +             adev-&gt;virt.unmap_csa(adev, vm);<br>
            &gt; &gt; +<br>
            &gt; &gt;        amd_sched_entity_fini(vm-&gt;entity.sched,
            &amp;vm-&gt;entity);<br>
            &gt; &gt;<br>
            &gt; &gt;        if (!RB_EMPTY_ROOT(&amp;vm-&gt;va)) {<br>
            &gt;<br>
            &gt;<br>
            <br>
          </div>
        </span></font>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------2E4AD5CD15CAB4CD501A6D1D--

--===============1910182533==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1910182533==--
