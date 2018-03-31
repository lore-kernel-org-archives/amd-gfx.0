From: Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/pp: Clean register first to avoid read original
 value
Date: Fri, 30 Mar 2018 21:45:41 -0400
Message-ID: <55b19db8-1396-fd5a-e5b2-ea28672920fc@amd.com>
References: <1522395206-5860-1-git-send-email-Rex.Zhu@amd.com>
 <c42b3004-8b75-60d2-0f2b-45e1e9a2f1f6@amd.com>
 <9bac98b9-4add-6214-f461-bfd91d5636ad@amd.com>
 <CY4PR12MB16872AF3D8207BF4ACBC023FFBA00@CY4PR12MB1687.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1183110531=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB16872AF3D8207BF4ACBC023FFBA00-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1183110531==
Content-Type: multipart/alternative;
 boundary="------------3428B6C548F02779EA4B594A"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------3428B6C548F02779EA4B594A
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Please confirm this with SMU team about your assumption.


Regards,

Eric


On 03/30/2018 08:28 PM, Zhu, Rex wrote:
>
> when PPSMC_MSG_PmStatusLogSample sent, firmware will clean the temp 
> sampling date, and add the sample task to dpm loop.
>
> but firmware not  clean the registers.  if firmware not update the 
> registers, we will read out the original value.
>
>
> Best Regards
>
> Rex
>
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Eric Huang <jinhuieric.huang-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, March 30, 2018 11:22 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amd/pp: Clean register first to avoid read 
> original value
>
> On 03/30/2018 10:36 AM, Eric Huang wrote:
> > It is not necessary to do that. The register will reset to 0 after
> > reading.
> The register is not reset after reading. Actually after
> PPSMC_MSG_PmStatusLogSample sent, the register will be updated. So it is
> still not necessary to do that.
>
> Eric
> >
> > Eric
> >
> >
> > On 03/30/2018 03:33 AM, Rex Zhu wrote:
> >> Signed-off-by: Rex Zhu <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>
> >> ---
> >> drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> >> b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> >> index aaa9f5b..38cf3a1 100644
> >> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> >> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
> >> @@ -3368,6 +3368,19 @@ static int smu7_get_gpu_power(struct pp_hwmgr
> >> *hwmgr,
> >>               "Failed to start pm status log!",
> >>               return -1);
> >>   + cgs_write_ind_register(hwmgr->device,
> >> +            CGS_IND_REG__SMC,
> >> +            ixSMU_PM_STATUS_40, 0);
> >> +    cgs_write_ind_register(hwmgr->device,
> >> +            CGS_IND_REG__SMC,
> >> +            ixSMU_PM_STATUS_49, 0);
> >> +    cgs_write_ind_register(hwmgr->device,
> >> +            CGS_IND_REG__SMC,
> >> +            ixSMU_PM_STATUS_94, 0);
> >> +    cgs_write_ind_register(hwmgr->device,
> >> +            CGS_IND_REG__SMC,
> >> +            ixSMU_PM_STATUS_95, 0);
> >> +
> >>       /* Sampling period from 50ms to 4sec */
> >>       msleep_interruptible(200);
> >
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> amd-gfx Info Page - freedesktop.org 
> <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
> lists.freedesktop.org
> Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the 
> following form. Use of all freedesktop.org lists is subject to our 
> Code of Conduct.
>
>
>


--------------3428B6C548F02779EA4B594A
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <p>Please confirm this with SMU team about your assumption.</p>
    <p><br>
    </p>
    <p>Regards,</p>
    <p>Eric<br>
    </p>
    <br>
    <div class="moz-cite-prefix">On 03/30/2018 08:28 PM, Zhu, Rex wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB16872AF3D8207BF4ACBC023FFBA00-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">when <span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size:
            14.6667px;">PPSMC_MSG_PmStatusLogSample sent, firmware will
            clean the temp sampling date, and add the sample task to dpm
            loop.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span style="font-size:
            14.6667px;">but firmware not  clean the registers.  if
            firmware not update the registers, we will read out the
            original value.</span></p>
        <p style="margin-top:0;margin-bottom:0"><span style="font-size:
            14.6667px;"><br>
          </span></p>
        <p style="margin-top:0;margin-bottom:0"><span style="font-size:
            14.6667px;">Best Regards</span></p>
        <p style="margin-top:0;margin-bottom:0"><span style="font-size:
            14.6667px;">Rex</span></p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr style="display:inline-block;width:98%" tabindex="-1">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Eric Huang <a class="moz-txt-link-rfc2396E" href="mailto:jinhuieric.huang-5C7GfCeVMHo@public.gmane.org">&lt;jinhuieric.huang-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Friday, March 30, 2018 11:22 PM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amd/pp: Clean register
              first to avoid read original value</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText"><br>
                  On 03/30/2018 10:36 AM, Eric Huang wrote:<br>
                  &gt; It is not necessary to do that. The register will
                  reset to 0 after <br>
                  &gt; reading.<br>
                  The register is not reset after reading. Actually
                  after <br>
                  PPSMC_MSG_PmStatusLogSample sent, the register will be
                  updated. So it is <br>
                  still not necessary to do that.<br>
                  <br>
                  Eric<br>
                  &gt;<br>
                  &gt; Eric<br>
                  &gt;<br>
                  &gt;<br>
                  &gt; On 03/30/2018 03:33 AM, Rex Zhu wrote:<br>
                  &gt;&gt; Signed-off-by: Rex Zhu
                  <a class="moz-txt-link-rfc2396E" href="mailto:Rex.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;Rex.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  &gt;&gt; ---<br>
                  &gt;&gt;  
                  drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 13
                  +++++++++++++<br>
                  &gt;&gt;   1 file changed, 13 insertions(+)<br>
                  &gt;&gt;<br>
                  &gt;&gt; diff --git
                  a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c <br>
                  &gt;&gt;
                  b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  &gt;&gt; index aaa9f5b..38cf3a1 100644<br>
                  &gt;&gt; ---
                  a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  &gt;&gt; +++
                  b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c<br>
                  &gt;&gt; @@ -3368,6 +3368,19 @@ static int
                  smu7_get_gpu_power(struct pp_hwmgr <br>
                  &gt;&gt; *hwmgr,<br>
                  &gt;&gt;               "Failed to start pm status
                  log!",<br>
                  &gt;&gt;               return -1);<br>
                  &gt;&gt;   +   
                  cgs_write_ind_register(hwmgr-&gt;device,<br>
                  &gt;&gt; +            CGS_IND_REG__SMC,<br>
                  &gt;&gt; +            ixSMU_PM_STATUS_40, 0);<br>
                  &gt;&gt; +    cgs_write_ind_register(hwmgr-&gt;device,<br>
                  &gt;&gt; +            CGS_IND_REG__SMC,<br>
                  &gt;&gt; +            ixSMU_PM_STATUS_49, 0);<br>
                  &gt;&gt; +    cgs_write_ind_register(hwmgr-&gt;device,<br>
                  &gt;&gt; +            CGS_IND_REG__SMC,<br>
                  &gt;&gt; +            ixSMU_PM_STATUS_94, 0);<br>
                  &gt;&gt; +    cgs_write_ind_register(hwmgr-&gt;device,<br>
                  &gt;&gt; +            CGS_IND_REG__SMC,<br>
                  &gt;&gt; +            ixSMU_PM_STATUS_95, 0);<br>
                  &gt;&gt; +<br>
                  &gt;&gt;       /* Sampling period from 50ms to 4sec */<br>
                  &gt;&gt;       msleep_interruptible(200);<br>
                  &gt;<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    id="LPlnk194206" previewremoved="true"
                    moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                  <div id="LPBorder_GT_15224555838300.6305618541058784"
                    style="margin-bottom: 20px; overflow: auto; width:
                    100%; text-indent: 0px;">
                    <table
                      id="LPContainer_15224555838230.7487087610706571"
                      role="presentation" style="width: 90%;
                      background-color: rgb(255, 255, 255); position:
                      relative; overflow: auto; padding-top: 20px;
                      padding-bottom: 20px; margin-top: 20px;
                      border-top: 1px dotted rgb(200, 200, 200);
                      border-bottom: 1px dotted rgb(200, 200, 200);"
                      cellspacing="0">
                      <tbody>
                        <tr style="border-spacing: 0px;" valign="top">
                          <td
                            id="TextCell_15224555838250.5092558814385109"
                            colspan="2" style="vertical-align: top;
                            position: relative; padding: 0px; display:
                            table-cell;">
                            <div
                              id="LPTitle_15224555838260.8317841949999445"
                              style="top: 0px; color: rgb(0, 120, 215);
                              font-weight: normal; font-size: 21px;
                              font-family: wf_segoe-ui_light,
                              &quot;Segoe UI Light&quot;, &quot;Segoe WP
                              Light&quot;, &quot;Segoe UI&quot;,
                              &quot;Segoe WP&quot;, Tahoma, Arial,
                              sans-serif; line-height: 21px;">
                              <a
                                id="LPUrlAnchor_15224555838270.3536369120415084"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                target="_blank" style="text-decoration:
                                none;" moz-do-not-send="true">amd-gfx
                                Info Page - freedesktop.org</a></div>
                            <div
                              id="LPMetadata_15224555838270.8339160024590055"
                              style="margin: 10px 0px 16px; color:
                              rgb(102, 102, 102); font-weight: normal;
                              font-family: wf_segoe-ui_normal,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 14px;">
                              lists.freedesktop.org</div>
                            <div
                              id="LPDescription_15224555838290.8158871495654998"
                              style="display: block; color: rgb(102,
                              102, 102); font-weight: normal;
                              font-family: wf_segoe-ui_normal,
                              &quot;Segoe UI&quot;, &quot;Segoe
                              WP&quot;, Tahoma, Arial, sans-serif;
                              font-size: 14px; line-height: 20px;
                              max-height: 100px; overflow: hidden;">
                              Subscribing to amd-gfx: Subscribe to
                              amd-gfx by filling out the following form.
                              Use of all freedesktop.org lists is
                              subject to our Code of Conduct.</div>
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
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------3428B6C548F02779EA4B594A--

--===============1183110531==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1183110531==--
