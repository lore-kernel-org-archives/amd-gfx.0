From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 0/9] misc patches related to powerplay
Date: Fri, 9 Sep 2016 19:51:30 +0200
Message-ID: <bf78afe1-9829-2316-2922-7e04d9babb75@vodafone.de>
References: <1473428259-580-1-git-send-email-Rex.Zhu@amd.com>
 <ead74fd5-6d6f-ba4e-d0a1-fea21e7296dd@vodafone.de>
 <CY4PR12MB16872A6C90804AF1D368A194FBFA0@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1277963987=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16872A6C90804AF1D368A194FBFA0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1277963987==
Content-Type: multipart/alternative;
 boundary="------------CBEF814AF08651B1FC72717A"

This is a multi-part message in MIME format.
--------------CBEF814AF08651B1FC72717A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rex,

exactly as I feared, please don't do this.

I for example have a system with multiple PEG slots to be able to test 
different hardware generations at the same time.

This is rather common setup for testing and will break horrible and 
quite unpredictable when the code suddenly overrides a global function 
table which is used by multiple hardware generations.

Either create one function table for each variant or make the function 
table a member of the hwmgr structure so that you can overwrite it in 
each instance without affecting others.

Regards,
Christian.

Am 09.09.2016 um 18:29 schrieb Zhu, Rex:
>
>
> Hi Christian,
>
>
>
> I used smu7_hwmgr for  all the asics of smu version 7 , CI and Vi. 
> Please see powerplay code refactoring patches.
>
>
> But some functions in the table were different between those asics. so 
> we needed to overload those functions for some asics.
>
>
> for example:
>
> from tonga. we used pptable version 1, but ci and iceland, no pptable,
>
> so needed to overload related functions:
>
>
>        hwmgr->hwmgr_func = &smu7_hwmgr_funcs;
>          hwmgr->pptable_func = &pptable_v1_0_funcs;
>          pp_smu7_thermal_initialize(hwmgr);
> +       if (hwmgr->pp_table_version == PP_TABLE_V0) {
> + hwmgr->hwmgr_func->get_pp_table_entry = &smu7_get_pp_table_entry_v0;
> + hwmgr->hwmgr_func->get_num_of_pp_table_entries = 
> smu7_get_number_of_powerplay_table_entries_v0;
> +               hwmgr->pptable_func = &pptable_funcs;
> +       }
>
>
> Best Regards
>
> Rex
>
>
>
> ------------------------------------------------------------------------
> *From:* Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Friday, September 9, 2016 10:23:26 PM
> *To:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 0/9] misc patches related to powerplay
> Patch #1-#7 and #9 are Acked-by: Christian König 
> <christian.koenig-5C7GfCeVMHo@public.gmane.org>.
>
> Patch #8: That looks fishy, usually we don't want to override static
> functions tables.
>
> So what is the specific use case here?
>
> Regards,
> Christian.
>
> Am 09.09.2016 um 15:37 schrieb Rex Zhu:
> > Rex Zhu (9):
> >    drm/amd/powerplay: mark symbols static where possible on tonga.
> >    drm/amd/powerplay: add feature flags in hwmgr to enable/disable
> >      special features.
> >    drm/amd/powerplay: add module parameter for mask pp feature
> >    drm/amd/powerplay: initialize platform caps in hwmgr_init.
> >    drm/amd/powerplay: add common functiones for visiting pp table.
> >    drm/amd/powerplay: wrap get evv voltage of fiji and polaris
> >    drm/amd/powerplay: move smu related variable definitions to smumgr.
> >    drm/amd/powerplay: delete const flag of hwmgr_funcs for overload.
> >    drm/amd/powerplay: delete dupicated function and definition.
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h |   1 +
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   4 +
> >   drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c |   2 +-
> >   drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c |   2 +-
> >   .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c |  34 ----
> >   drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c | 186 
> ++++++++++++++++++---
> >   .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c |  10 +-
> >   .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c |   7 +-
> >   .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.h |   5 +-
> >   .../drm/amd/powerplay/hwmgr/polaris10_powertune.h |  13 --
> >   drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c |  21 +--
> >   .../gpu/drm/amd/powerplay/inc/hardwaremanager.h |   1 -
> >   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h |  32 +++-
> >   .../drm/amd/powerplay/smumgr/polaris10_smumgr.c |   1 -
> >   .../drm/amd/powerplay/smumgr/polaris10_smumgr.h |  20 +++
> >   drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c |   1 +
> >   16 files changed, 229 insertions(+), 111 deletions(-)
> >
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------CBEF814AF08651B1FC72717A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Hi Rex,<br>
      <br>
      exactly as I feared, please don't do this.<br>
      <br>
      I for example have a system with multiple PEG slots to be able to
      test different hardware generations at the same time.<br>
      <br>
      This is rather common setup for testing and will break horrible
      and quite unpredictable when the code suddenly overrides a global
      function table which is used by multiple hardware generations.<br>
      <br>
      Either create one function table for each variant or make the
      function table a member of the hwmgr structure so that you can
      overwrite it in each instance without affecting others.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.09.2016 um 18:29 schrieb Zhu, Rex:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB16872A6C90804AF1D368A194FBFA0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper" style="font-family: Calibri, Arial,
        Helvetica, sans-serif; background-color: rgb(255, 255, 255);">
        <p style="color: rgb(0, 0, 0); font-size: 12pt;"><br>
        </p>
        <meta content="text/html; charset=UTF-8">
        <div dir="ltr">
          <div id="x_divtagdefaultwrapper" style="font-family: Calibri,
            Arial, Helvetica, sans-serif; background-color: rgb(255,
            255, 255);">
            <p style="color: rgb(0, 0, 0); font-size: 12pt;">Hi
              Christian,</p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><br>
            </p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><br>
            </p>
            <p><span style="font-size: 12pt;">I used smu7_hwmgr for  all
                the asics of smu version 7 , CI and Vi. Please see  </span><span
                style="font-size: 12pt;">powerplay code refactoring
                patches</span><font color="#333333"><span
                  style="font-size: 21px;">.</span></font></p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><br>
            </p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;">But some
              functions in the table were different between those asics.
              so we needed to overload those functions for some asics.</p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><br>
            </p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;">for
              example:</p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;">from tonga.
              we used pptable version 1, but ci and iceland, no
              pptable, </p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;">so needed
              to overload related functions:</p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><br>
            </p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><span
                style="color: rgb(33, 33, 33); font-size: 13.3333px;"> 
                       hwmgr-&gt;hwmgr_func = &amp;smu7_hwmgr_funcs;</span><br
                style="color: rgb(33, 33, 33); font-size: 13.3333px;">
              <span style="color: rgb(33, 33, 33); font-size:
                13.3333px;">         hwmgr-&gt;pptable_func =
                &amp;pptable_v1_0_funcs;</span><br style="color: rgb(33,
                33, 33); font-size: 13.3333px;">
              <span style="color: rgb(33, 33, 33); font-size:
                13.3333px;">         pp_smu7_thermal_initialize(hwmgr);</span><br
                style="color: rgb(33, 33, 33); font-size: 13.3333px;">
              <span style="color: rgb(33, 33, 33); font-size:
                13.3333px;">+       if (hwmgr-&gt;pp_table_version ==
                PP_TABLE_V0) {</span><br style="color: rgb(33, 33, 33);
                font-size: 13.3333px;">
              <span style="color: rgb(33, 33, 33); font-size:
                13.3333px;">+              
                hwmgr-&gt;hwmgr_func-&gt;get_pp_table_entry =
                &amp;smu7_get_pp_table_entry_v0;</span><br style="color:
                rgb(33, 33, 33); font-size: 13.3333px;">
              <span style="color: rgb(33, 33, 33); font-size:
                13.3333px;">+              
                hwmgr-&gt;hwmgr_func-&gt;get_num_of_pp_table_entries =
                smu7_get_number_of_powerplay_table_entries_v0;</span><br
                style="color: rgb(33, 33, 33); font-size: 13.3333px;">
              <span style="color: rgb(33, 33, 33); font-size:
                13.3333px;">+               hwmgr-&gt;pptable_func =
                &amp;pptable_funcs;</span><br style="color: rgb(33, 33,
                33); font-size: 13.3333px;">
              <span style="color: rgb(33, 33, 33); font-size:
                13.3333px;">+       }</span><br>
            </p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><span
                style="color: rgb(33, 33, 33); font-size: 13.3333px;"><br>
              </span></p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;">Best
              Regards </p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;">Rex</p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><br>
            </p>
            <p style="color: rgb(0, 0, 0); font-size: 12pt;"><br>
            </p>
          </div>
          <hr tabindex="-1" style="color: rgb(0, 0, 0); font-size: 12pt;
            display: inline-block; width: 98%;">
          <div id="x_divRplyFwdMsg" dir="ltr" style="color: rgb(0, 0,
            0); font-size: 12pt;">
            <font style="font-size:11pt" color="#000000" face="Calibri,
              sans-serif"><b>From:</b> Christian König
              <a class="moz-txt-link-rfc2396E" href="mailto:deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org">&lt;deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Friday, September 9, 2016 10:23:26 PM<br>
              <b>To:</b> Zhu, Rex; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH 0/9] misc patches related to
              powerplay</font>
            <div> </div>
          </div>
        </div>
        <font style="color: rgb(0, 0, 0); font-size: 12pt;" size="2"><span
            style="font-size:10pt;">
            <div class="PlainText">Patch #1-#7 and #9 are Acked-by:
              Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a>.<br>
              <br>
              Patch #8: That looks fishy, usually we don't want to
              override static <br>
              functions tables.<br>
              <br>
              So what is the specific use case here?<br>
              <br>
              Regards,<br>
              Christian.<br>
              <br>
              Am 09.09.2016 um 15:37 schrieb Rex Zhu:<br>
              &gt; Rex Zhu (9):<br>
              &gt;    drm/amd/powerplay: mark symbols static where
              possible on tonga.<br>
              &gt;    drm/amd/powerplay: add feature flags in hwmgr to
              enable/disable<br>
              &gt;      special features.<br>
              &gt;    drm/amd/powerplay: add module parameter for mask
              pp feature<br>
              &gt;    drm/amd/powerplay: initialize platform caps in
              hwmgr_init.<br>
              &gt;    drm/amd/powerplay: add common functiones for
              visiting pp table.<br>
              &gt;    drm/amd/powerplay: wrap get evv voltage of fiji
              and polaris<br>
              &gt;    drm/amd/powerplay: move smu related variable
              definitions to smumgr.<br>
              &gt;    drm/amd/powerplay: delete const flag of
              hwmgr_funcs for overload.<br>
              &gt;    drm/amd/powerplay: delete dupicated function and
              definition.<br>
              &gt;<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu.h               
              |   1 +<br>
              &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           
              |   4 +<br>
              &gt;   drivers/gpu/drm/amd/powerplay/hwmgr/cz_hwmgr.c    
              |   2 +-<br>
              &gt;   drivers/gpu/drm/amd/powerplay/hwmgr/fiji_hwmgr.c  
              |   2 +-<br>
              &gt;   .../gpu/drm/amd/powerplay/hwmgr/hardwaremanager.c 
              |  34 ----<br>
              &gt;   drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c       
              | 186 ++++++++++++++++++---<br>
              &gt;   .../gpu/drm/amd/powerplay/hwmgr/iceland_hwmgr.c   
              |  10 +-<br>
              &gt;   .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.c 
              |   7 +-<br>
              &gt;   .../gpu/drm/amd/powerplay/hwmgr/polaris10_hwmgr.h 
              |   5 +-<br>
              &gt;   .../drm/amd/powerplay/hwmgr/polaris10_powertune.h 
              |  13 --<br>
              &gt;   drivers/gpu/drm/amd/powerplay/hwmgr/tonga_hwmgr.c 
              |  21 +--<br>
              &gt;   .../gpu/drm/amd/powerplay/inc/hardwaremanager.h   
              |   1 -<br>
              &gt;   drivers/gpu/drm/amd/powerplay/inc/hwmgr.h         
              |  32 +++-<br>
              &gt;   .../drm/amd/powerplay/smumgr/polaris10_smumgr.c   
              |   1 -<br>
              &gt;   .../drm/amd/powerplay/smumgr/polaris10_smumgr.h   
              |  20 +++<br>
              &gt;   drivers/gpu/drm/amd/powerplay/smumgr/smumgr.c     
              |   1 +<br>
              &gt;   16 files changed, 229 insertions(+), 111
              deletions(-)<br>
              &gt;<br>
              <br>
            </div>
          </span></font></div>
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

--------------CBEF814AF08651B1FC72717A--

--===============1277963987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1277963987==--
