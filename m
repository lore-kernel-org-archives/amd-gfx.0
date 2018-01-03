From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/4] drm/amdgpu: minor optimize VM moved handling v2
Date: Wed, 3 Jan 2018 13:35:54 +0100
Message-ID: <6e6de38b-8282-1c91-bf42-8aaaadb16184@gmail.com>
References: <20180102144715.4278-1-christian.koenig@amd.com>
 <20180102144715.4278-2-christian.koenig@amd.com>
 <MWHPR1201MB0206AFE9297613F6B292C91DB41E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
 <ccfc21d7-57d6-47fd-0019-46a193836e69@gmail.com>
 <2c70dc36-fd93-8e74-6ab9-782c06f1a296@amd.com>
 <f62c15ab-c605-0f16-1448-b38553ec23ad@amd.com>
 <MWHPR1201MB02067E3350544334BF981EE5B41E0@MWHPR1201MB0206.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1718530877=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <MWHPR1201MB02067E3350544334BF981EE5B41E0-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org>
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
To: "Zhou, David(ChunMing)" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: amd-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1718530877==
Content-Type: multipart/alternative;
 boundary="------------6FF252686F09755D18FEC09A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6FF252686F09755D18FEC09A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 03.01.2018 um 12:57 schrieb Zhou, David(ChunMing):
> >>>> +        else if (reservation_object_trylock(resv))
> >>>> +            clear = false;
>
> this will effect bo in bo list，wont it?

Ah, now I get what you mean.

Yeah, that should be fixed or otherwise it will completely disable 
vm_debug support.

Going to send a patch,
Christian.

>
> 发自坚果 Pro
>
> Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org> 于 2018年1月3日 
> 下午6:47写道：
>
> Am 03.01.2018 um 11:43 schrieb Chunming Zhou:
> >
> >
> > On 2018年01月03日 17:25, Christian König wrote:
> >> Am 03.01.2018 um 09:10 schrieb Zhou, David(ChunMing):
> >>>
> >>> On 2018年01月02日 22:47, Christian König wrote:
> >>>> Try to lock moved BOs if it's successful we can update the
> >>>> PTEs directly to the new location.
> >>>>
> >>>> v2: rebase
> >>>>
> >>>> Signed-off-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >>>> ---
> >>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 15 ++++++++++++++-
> >>>>    1 file changed, 14 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> index 3632c69f1814..c1c5ccdee783 100644
> >>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> >>>> @@ -1697,18 +1697,31 @@ int amdgpu_vm_handle_moved(struct
> >>>> amdgpu_device *adev,
> >>>>        spin_lock(&vm->status_lock);
> >>>>        while (!list_empty(&vm->moved)) {
> >>>>            struct amdgpu_bo_va *bo_va;
> >>>> +        struct reservation_object *resv;
> >>>>               bo_va = list_first_entry(&vm->moved,
> >>>>                struct amdgpu_bo_va, base.vm_status);
> >>>> spin_unlock(&vm->status_lock);
> >>>>    +        resv = bo_va->base.bo->tbo.resv;
> >>>> +
> >>>>            /* Per VM BOs never need to bo cleared in the page
> >>>> tables */
> >>> This reminders us Per-VM-BOs need to cleared as well after we allow to
> >>> evict/swap out per-vm-bos.
> >>
> >> Actually they don't. The page tables only need to be valid during CS.
> >>
> >> So what happens is that the per VM-BOs are validated in right before
> >> we call amdgpu_vm_handle_moved().
> > Yeah, agree it for per-vm-bo situation after I checked all adding
> > moved list cases:
> > 1. validate pt bos
> > 2. bo invalidate
> > 3. insert_map for per-vm-bo
> > item #1 and #3 both are per-vm-bo, they are already validated before
> > handle_moved().
> >
> > For item #2, there are three places to call it:
> > a. amdgpu_bo_vm_update_pte in CS for amdgpu_vm_debug
> > b. amdgpu_gem_op_ioctl, but it is for evicted list, nothing with moved
> > list.
> > c. amdgpu_bo_move_notify when bo validate.
> >
> > For c case, your optimization is valid, we don't need clear for
> > validate bo.
> > But for a case, yours will break amdgpu_vm_debug functionality.
> >
> > Right?
>
> Interesting point, but no that should be handled as well.
>
> The vm_debug handling is only for the BOs on the BO-list. E.g. per VM
> BOs are never handled here.
>
> Regards,
> Christian.
>
> >
> > Regards,
> > David Zhou
> >
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Regards,
> >>> David Zhou
> >>>> -        clear = bo_va->base.bo->tbo.resv !=
> >>>> vm->root.base.bo->tbo.resv;
> >>>> +        if (resv == vm->root.base.bo->tbo.resv)
> >>>> +            clear = false;
> >>>> +        /* Try to reserve the BO to avoid clearing its ptes */
> >>>> +        else if (reservation_object_trylock(resv))
> >>>> +            clear = false;
> >>>> +        /* Somebody else is using the BO right now */
> >>>> +        else
> >>>> +            clear = true;
> >>>>               r = amdgpu_vm_bo_update(adev, bo_va, clear);
> >>>>            if (r)
> >>>>                return r;
> >>>>    +        if (!clear && resv != vm->root.base.bo->tbo.resv)
> >>>> + reservation_object_unlock(resv);
> >>>> +
> >>>> spin_lock(&vm->status_lock);
> >>>>        }
> >>>> spin_unlock(&vm->status_lock);
> >>
> >
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------6FF252686F09755D18FEC09A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 03.01.2018 um 12:57 schrieb Zhou,
      David(ChunMing):<br>
    </div>
    <blockquote type="cite"
cite="mid:MWHPR1201MB02067E3350544334BF981EE5B41E0-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Exchange Server">
      <!-- converted from text -->
      <style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left: #800000 2px solid; } --></style>
      <div>&gt;&gt;&gt;&gt; +        else if (reservation_object_trylock(resv))<br>
        &gt;&gt;&gt;&gt; +            clear = false;<br>
        <br>
        this will effect bo in bo list，wont it?<br>
      </div>
    </blockquote>
    <br>
    Ah, now I get what you mean.<br>
    <br>
    Yeah, that should be fixed or otherwise it will completely disable
    vm_debug support.<br>
    <br>
    Going to send a patch,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:MWHPR1201MB02067E3350544334BF981EE5B41E0-3iK1xFAIwjrUF/YbdlDdgWrFom/aUZj6nBOFsp37pqbUKgpGm//BTAC/G2K4zDHf@public.gmane.org">
      <div>
        <br>
        <p dir="ltr" style="display:inline"><span style="color:#888888"><span
              style="font-size:0.81em">发自坚果 Pro</span></span></p>
        <style type="text/css">
<!--
* body
	{padding:0 16px 30px!important;
	margin:0!important;
	background-color:#ffffff;
	line-height:1.4;
	word-wrap:break-word;
	word-break:normal}
div
	{word-wrap:break-word;
	word-break:normal}
p
	{word-wrap:break-word;
	word-break:normal;
	text-indent:0pt!important}
span
	{word-wrap:break-word;
	word-break:normal}
a
	{word-wrap:break-word;
	word-break:normal}
td
	{word-wrap:break-word;
	word-break:break-all}
-->
</style>
        <div class="x_quote">
          <div style="margin:0 0px; font-size:105%"><font
              style="line-height:1.4" color="#629140"><span>Koenig,
                Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a> 于 2018年1月3日
                下午6:47写道：</span></font></div>
          <br type="attribution">
        </div>
      </div>
      <font size="2"><span style="font-size:11pt;">
          <div class="PlainText">Am 03.01.2018 um 11:43 schrieb Chunming
            Zhou:<br>
            &gt;<br>
            &gt;<br>
            &gt; On 2018年01月03日 17:25, Christian König wrote:<br>
            &gt;&gt; Am 03.01.2018 um 09:10 schrieb Zhou,
            David(ChunMing):<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; On 2018年01月02日 22:47, Christian König wrote:<br>
            &gt;&gt;&gt;&gt; Try to lock moved BOs if it's successful we
            can update the<br>
            &gt;&gt;&gt;&gt; PTEs directly to the new location.<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; v2: rebase<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; Signed-off-by: Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
            &gt;&gt;&gt;&gt; ---<br>
            &gt;&gt;&gt;&gt;    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c |
            15 ++++++++++++++-<br>
            &gt;&gt;&gt;&gt;    1 file changed, 14 insertions(+), 1
            deletion(-)<br>
            &gt;&gt;&gt;&gt;<br>
            &gt;&gt;&gt;&gt; diff --git
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c <br>
            &gt;&gt;&gt;&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt;&gt;&gt; index 3632c69f1814..c1c5ccdee783 100644<br>
            &gt;&gt;&gt;&gt; ---
            a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt;&gt;&gt; +++
            b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
            &gt;&gt;&gt;&gt; @@ -1697,18 +1697,31 @@ int
            amdgpu_vm_handle_moved(struct <br>
            &gt;&gt;&gt;&gt; amdgpu_device *adev,<br>
            &gt;&gt;&gt;&gt;        spin_lock(&amp;vm-&gt;status_lock);<br>
            &gt;&gt;&gt;&gt;        while
            (!list_empty(&amp;vm-&gt;moved)) {<br>
            &gt;&gt;&gt;&gt;            struct amdgpu_bo_va *bo_va;<br>
            &gt;&gt;&gt;&gt; +        struct reservation_object *resv;<br>
            &gt;&gt;&gt;&gt;               bo_va =
            list_first_entry(&amp;vm-&gt;moved,<br>
            &gt;&gt;&gt;&gt;                struct amdgpu_bo_va,
            base.vm_status);<br>
            &gt;&gt;&gt;&gt;           
            spin_unlock(&amp;vm-&gt;status_lock);<br>
            &gt;&gt;&gt;&gt;    +        resv =
            bo_va-&gt;base.bo-&gt;tbo.resv;<br>
            &gt;&gt;&gt;&gt; +<br>
            &gt;&gt;&gt;&gt;            /* Per VM BOs never need to bo
            cleared in the page <br>
            &gt;&gt;&gt;&gt; tables */<br>
            &gt;&gt;&gt; This reminders us Per-VM-BOs need to cleared as
            well after we allow to<br>
            &gt;&gt;&gt; evict/swap out per-vm-bos.<br>
            &gt;&gt;<br>
            &gt;&gt; Actually they don't. The page tables only need to
            be valid during CS.<br>
            &gt;&gt;<br>
            &gt;&gt; So what happens is that the per VM-BOs are
            validated in right before <br>
            &gt;&gt; we call amdgpu_vm_handle_moved().<br>
            &gt; Yeah, agree it for per-vm-bo situation after I checked
            all adding <br>
            &gt; moved list cases:<br>
            &gt; 1. validate pt bos<br>
            &gt; 2. bo invalidate<br>
            &gt; 3. insert_map for per-vm-bo<br>
            &gt; item #1 and #3 both are per-vm-bo, they are already
            validated before <br>
            &gt; handle_moved().<br>
            &gt;<br>
            &gt; For item #2, there are three places to call it:<br>
            &gt; a. amdgpu_bo_vm_update_pte in CS for amdgpu_vm_debug<br>
            &gt; b. amdgpu_gem_op_ioctl, but it is for evicted list,
            nothing with moved <br>
            &gt; list.<br>
            &gt; c. amdgpu_bo_move_notify when bo validate.<br>
            &gt;<br>
            &gt; For c case, your optimization is valid, we don't need
            clear for <br>
            &gt; validate bo.<br>
            &gt; But for a case, yours will break amdgpu_vm_debug
            functionality.<br>
            &gt;<br>
            &gt; Right?<br>
            <br>
            Interesting point, but no that should be handled as well.<br>
            <br>
            The vm_debug handling is only for the BOs on the BO-list.
            E.g. per VM <br>
            BOs are never handled here.<br>
            <br>
            Regards,<br>
            Christian.<br>
            <br>
            &gt;<br>
            &gt; Regards,<br>
            &gt; David Zhou<br>
            &gt;<br>
            &gt;&gt;<br>
            &gt;&gt; Regards,<br>
            &gt;&gt; Christian.<br>
            &gt;&gt;<br>
            &gt;&gt;&gt;<br>
            &gt;&gt;&gt; Regards,<br>
            &gt;&gt;&gt; David Zhou<br>
            &gt;&gt;&gt;&gt; -        clear =
            bo_va-&gt;base.bo-&gt;tbo.resv != <br>
            &gt;&gt;&gt;&gt; vm-&gt;root.base.bo-&gt;tbo.resv;<br>
            &gt;&gt;&gt;&gt; +        if (resv ==
            vm-&gt;root.base.bo-&gt;tbo.resv)<br>
            &gt;&gt;&gt;&gt; +            clear = false;<br>
            &gt;&gt;&gt;&gt; +        /* Try to reserve the BO to avoid
            clearing its ptes */<br>
            &gt;&gt;&gt;&gt; +        else if
            (reservation_object_trylock(resv))<br>
            &gt;&gt;&gt;&gt; +            clear = false;<br>
            &gt;&gt;&gt;&gt; +        /* Somebody else is using the BO
            right now */<br>
            &gt;&gt;&gt;&gt; +        else<br>
            &gt;&gt;&gt;&gt; +            clear = true;<br>
            &gt;&gt;&gt;&gt;               r = amdgpu_vm_bo_update(adev,
            bo_va, clear);<br>
            &gt;&gt;&gt;&gt;            if (r)<br>
            &gt;&gt;&gt;&gt;                return r;<br>
            &gt;&gt;&gt;&gt;    +        if (!clear &amp;&amp; resv !=
            vm-&gt;root.base.bo-&gt;tbo.resv)<br>
            &gt;&gt;&gt;&gt; +           
            reservation_object_unlock(resv);<br>
            &gt;&gt;&gt;&gt; +<br>
            &gt;&gt;&gt;&gt;           
            spin_lock(&amp;vm-&gt;status_lock);<br>
            &gt;&gt;&gt;&gt;        }<br>
            &gt;&gt;&gt;&gt;       
            spin_unlock(&amp;vm-&gt;status_lock);<br>
            &gt;&gt;<br>
            &gt;<br>
            <br>
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
    <br>
  </body>
</html>

--------------6FF252686F09755D18FEC09A--

--===============1718530877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1718530877==--
