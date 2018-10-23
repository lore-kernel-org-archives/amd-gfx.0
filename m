From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed
Date: Tue, 23 Oct 2018 11:01:08 +0200
Message-ID: <62aee584-d4b1-dd9b-234e-8ca7d7a23a29@gmail.com>
References: <1540265370-23923-1-git-send-email-Rex.Zhu@amd.com>
 <7b50f2a1-791e-8eab-6777-e7fff572565c@amd.com>
 <BYAPR12MB2775C0F7BCA52B2969C9D16EFBF50@BYAPR12MB2775.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1513739454=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BYAPR12MB2775C0F7BCA52B2969C9D16EFBF50-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "Zhang, Jerry" <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1513739454==
Content-Type: multipart/alternative;
 boundary="------------403058BA37F1A64BE60C5AD4"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------403058BA37F1A64BE60C5AD4
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi guys,

yeah the root PD doesn't necessarily have a power of two entries.

But what exactly was the problem with the original code? Why does 
0xffffffff doesn't work?

The only possible explanation I can see is that somebody tried to use an 
address which is above max_pfn, or how did that trigger?

Thanks,
Christian.

Am 23.10.18 um 07:42 schrieb Zhu, Rex:
>
> No, if the vm size is small, there may only on root pd entry.
>
> we need to make sure the mask >= 0;
>
>
> Maybe this change revert Christian's commit:
>
>
> commit 72af632549b97ead9251bb155f08fefd1fb6f5c3
> Author: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> Date:   Sat Sep 15 10:02:13 2018 +0200
>
>     drm/amdgpu: add amdgpu_vm_entries_mask v2
>
>     We can't get the mask for the root directory from the number of 
> entries.
>
>     So add a new function to avoid that problem.
>
>
> Best Regards
>
> Rex
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Zhang, Jerry(Junwei) <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Tuesday, October 23, 2018 1:12 PM
> *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander; 
> Koenig, Christian
> *Subject:* Re: [PATCH] drm/amdgpu: Fix amdgpu_vm_alloc_pts failed
> On 10/23/2018 11:29 AM, Rex Zhu wrote:
> > when the VA address located in the last PD entries,
> > the alloc_pts will faile.
> >
> > Use the right PD mask instand of hardcode, suggested
> > by jerry.zhang.
> >
> > Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
>
> Thanks to verify that.
> Feel free to add
> Reviewed-by: Junwei Zhang <Jerry.Zhang-5C7GfCeVMHo@public.gmane.org>
>
> Also like to get to know some background about these two functions from
> Christian.
> Perhaps we may make it more simple, e.g. merging them together.
>
> Regards,
> Jerry
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > index 054633b..3939013 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> > @@ -202,8 +202,11 @@ static unsigned amdgpu_vm_num_entries(struct 
> amdgpu_device *adev,
> >   static uint32_t amdgpu_vm_entries_mask(struct amdgpu_device *adev,
> >                                       unsigned int level)
> >   {
> > +     unsigned shift = amdgpu_vm_level_shift(adev,
> > + adev->vm_manager.root_level);
> > +
> >        if (level <= adev->vm_manager.root_level)
> > -             return 0xffffffff;
> > +             return (round_up(adev->vm_manager.max_pfn, 1 << shift) 
> >> shift) - 1;
> >        else if (level != AMDGPU_VM_PTB)
> >                return 0x1ff;
> >        else
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> To see the collection of prior postings to the list, visit the amd-gfx 
> Archives.. Using amd-gfx: To post a message to all the list members, 
> send email to amd-gfx-PD4FTy7X32lNgt0PjOBp9xlNPtJONSTn@public.gmane.org You can subscribe to the 
> list, or change your existing subscription, in the sections below.
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------403058BA37F1A64BE60C5AD4
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi guys,<br>
      <br>
      yeah the root PD doesn't necessarily have a power of two entries.<br>
      <br>
      But what exactly was the problem with the original code? Why does
      0xffffffff doesn't work?<br>
      <br>
      The only possible explanation I can see is that somebody tried to
      use an address which is above max_pfn, or how did that trigger?<br>
      <br>
      Thanks,<br>
      Christian.<br>
      <br>
      Am 23.10.18 um 07:42 schrieb Zhu, Rex:<br>
    </div>
    <blockquote type="cite"
cite="mid:BYAPR12MB2775C0F7BCA52B2969C9D16EFBF50-ZGDeBxoHBPmJeBUhB162ZQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">No, if the vm size is
          small, there may only on root pd entry.</p>
        <p style="margin-top:0;margin-bottom:0">we need to make sure the
          mask &gt;= 0;</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Maybe this change revert
          Christian's commit:</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <div>commit 72af632549b97ead9251bb155f08fefd1fb6f5c3<br>
          Author: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          Date:   Sat Sep 15 10:02:13 2018 +0200<br>
          <br>
              drm/amdgpu: add amdgpu_vm_entries_mask v2<br>
              <br>
              We can't get the mask for the root directory from the
          number of entries.<br>
              <br>
              So add a new function to avoid that problem.</div>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Best Regards</p>
        <p style="margin-top:0;margin-bottom:0">Rex<br>
        </p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Zhang, Jerry(Junwei) <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Tuesday, October 23, 2018 1:12 PM<br>
              <b>To:</b> Zhu, Rex; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
              Deucher, Alexander; Koenig, Christian<br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: Fix
              amdgpu_vm_alloc_pts failed</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">On 10/23/2018 11:29 AM, Rex Zhu
                  wrote:<br>
                  &gt; when the VA address located in the last PD
                  entries,<br>
                  &gt; the alloc_pts will faile.<br>
                  &gt;<br>
                  &gt; Use the right PD mask instand of hardcode,
                  suggested<br>
                  &gt; by jerry.zhang.<br>
                  &gt;<br>
                  &gt; Signed-off-by: Rex Zhu <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <br>
                  Thanks to verify that.<br>
                  Feel free to add<br>
                  Reviewed-by: Junwei Zhang <a class="moz-txt-link-rfc2396E" href="mailto:Jerry.Zhang-5C7GfCeVMHo@public.gmane.org">&lt;Jerry.Zhang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <br>
                  Also like to get to know some background about these
                  two functions from <br>
                  Christian.<br>
                  Perhaps we may make it more simple, e.g. merging them
                  together.<br>
                  <br>
                  Regards,<br>
                  Jerry<br>
                  <br>
                  &gt; ---<br>
                  &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5
                  ++++-<br>
                  &gt;   1 file changed, 4 insertions(+), 1 deletion(-)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                  &gt; index 054633b..3939013 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c<br>
                  &gt; @@ -202,8 +202,11 @@ static unsigned
                  amdgpu_vm_num_entries(struct amdgpu_device *adev,<br>
                  &gt;   static uint32_t amdgpu_vm_entries_mask(struct
                  amdgpu_device *adev,<br>
                  &gt;                                       unsigned
                  int level)<br>
                  &gt;   {<br>
                  &gt; +     unsigned shift =
                  amdgpu_vm_level_shift(adev,<br>
                  &gt; +                                           
                  adev-&gt;vm_manager.root_level);<br>
                  &gt; +<br>
                  &gt;        if (level &lt;=
                  adev-&gt;vm_manager.root_level)<br>
                  &gt; -             return 0xffffffff;<br>
                  &gt; +             return
                  (round_up(adev-&gt;vm_manager.max_pfn, 1 &lt;&lt;
                  shift) &gt;&gt; shift) - 1;<br>
                  &gt;        else if (level != AMDGPU_VM_PTB)<br>
                  &gt;                return 0x1ff;<br>
                  &gt;        else<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk206689" class="OWAAutoLink"
                    previewremoved="true" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                  <div id="LPBorder_GT_15402730099220.06989990489403342"
                    style="margin-bottom: 20px; overflow: auto; width:
                    100%; text-indent: 0px;">
                    <table
                      id="LPContainer_15402730099180.16758172594804666"
                      style="width: 90%; background-color: rgb(255, 255,
                      255); position: relative; overflow: auto;
                      padding-top: 20px; padding-bottom: 20px;
                      margin-top: 20px; border-top: 1px dotted rgb(200,
                      200, 200); border-bottom: 1px dotted rgb(200, 200,
                      200);" role="presentation" cellspacing="0">
                      <tbody>
                        <tr style="border-spacing: 0px;" valign="top">
                          <td
                            id="TextCell_15402730099180.9196994567727107"
                            style="vertical-align: top; position:
                            relative; padding: 0px; display:
                            table-cell;" colspan="2">
                            <div
                              id="LPTitle_15402730099180.46519874882455503"
                              style="top: 0px; color: rgb(0, 120, 215);
                              font-weight: 400; font-size: 21px;
                              font-family:
                              &quot;wf_segoe-ui_light&quot;, &quot;Segoe
                              UI Light&quot;, &quot;Segoe WP
                              Light&quot;, &quot;Segoe UI&quot;,
                              &quot;Segoe WP&quot;, Tahoma, Arial,
                              sans-serif; line-height: 21px;">
                              <a
                                id="LPUrlAnchor_15402730099200.5625533175983499"
                                style="text-decoration: none;"
                                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                target="_blank" moz-do-not-send="true">amd-gfx
                                Info Page - freedesktop.org</a></div>
                            <div
                              id="LPMetadata_15402730099200.935286511114562"
                              style="margin: 10px 0px 16px; color:
                              rgb(102, 102, 102); font-weight: 400;
                              font-family:
                              &quot;wf_segoe-ui_normal&quot;,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 14px;">
                              lists.freedesktop.org</div>
                            <div
                              id="LPDescription_15402730099200.10363074579177611"
                              style="display: block; color: rgb(102,
                              102, 102); font-weight: 400; font-family:
                              &quot;wf_segoe-ui_normal&quot;,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 20px;
                              max-height: 100px; overflow: hidden;">
                              To see the collection of prior postings to
                              the list, visit the amd-gfx Archives..
                              Using amd-gfx: To post a message to all
                              the list members, send email to
                              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>. You can
                              subscribe to the list, or change your
                              existing subscription, in the sections
                              below.</div>
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  <br>
                </div>
              </span></font></div>
        </div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------403058BA37F1A64BE60C5AD4--

--===============1513739454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1513739454==--
