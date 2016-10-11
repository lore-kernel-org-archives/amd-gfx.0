From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read (v2)
Date: Tue, 11 Oct 2016 14:30:58 +0200
Message-ID: <942ca6f5-fb0b-5f6f-7a87-1ffd6335be5d@vodafone.de>
References: <20161009115808.12776-1-tom.stdenis@amd.com>
 <a2035199-429c-d377-b354-bf42148d3820@mailbox.org>
 <CY4PR12MB176836D549B404152F5A1040F7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1671132621=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB176836D549B404152F5A1040F7DA0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
Cc: "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1671132621==
Content-Type: multipart/alternative;
 boundary="------------99C2E16655B4ECAEBCF9B785"

This is a multi-part message in MIME format.
--------------99C2E16655B4ECAEBCF9B785
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I briefly remember reading in some hardware doc that this actually has a 
defined behavior.

It was something about applying either bit wise "and" or "or" on the 
resulting bits and returning that to the reader.

This way you can check with a single broadcast read if an error occurred 
or if any of the instances are busy.

But if you don't actually use it I suggest to not implement this.

Regards,
Christian.

Am 11.10.2016 um 12:26 schrieb StDenis, Tom:
>
> That actually makes sense.  It came up because mmPA_SC_RASTER_CONFIG 
> (and _1) are read by libdrm with a selection of 0/*/* for 
> se/sh/instance so I wanted to be able to reproduce that via the 
> debugfs interface for testing.
>
>
> But ya, if you use the broadcast bit who are you reading from then ... 
> hmm..
>
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Michel Dänzer <michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org>
> *Sent:* Monday, October 10, 2016 23:52
> *To:* Tom St Denis
> *Cc:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH] drm/amd/amdgpu: Allow broadcast on debugfs read 
> (v2)
> On 09/10/16 08:58 PM, Tom St Denis wrote:
> > Allow any of the se/sh/instance fields to be
> > specified as a broadcast by submitting 0x3FF.
> >
> > (v2) Fix broadcast range checking
> >
> > Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>
>
> I'm not sure how a "broadcast read" is supposed to work? I can only see
> the register specs talking about broadcast in connection with writes.
>
>
> -- 
> Earthling Michel Dänzer               | http://www.amd.com 
> <http://www.amd.com>
> Graphics, Processors and Immersive VR Solutions | AMD 
> <http://www.amd.com/>
> www.amd.com
> Explore a wide range of innovative next generation computing 
> processors, graphics, and Immersive VR solutions by Advanced Micro 
> Devices (AMD). Visit AMD.com now!
>
>
>
> Libre software enthusiast             |             Mesa and X developer
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
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------99C2E16655B4ECAEBCF9B785
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">I briefly remember reading in some
      hardware doc that this actually has a defined behavior.<br>
      <br>
      It was something about applying either bit wise "and" or "or" on
      the resulting bits and returning that to the reader.<br>
      <br>
      This way you can check with a single broadcast read if an error
      occurred or if any of the instances are busy.<br>
      <br>
      But if you don't actually use it I suggest to not implement this.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 11.10.2016 um 12:26 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB176836D549B404152F5A1040F7DA0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>That actually makes sense.  It came up because <span>mmPA_SC_RASTER_CONFIG
            (and _1) are read by libdrm with a selection of 0/*/* for
            se/sh/instance so I wanted to be able to reproduce that via
            the debugfs interface for testing.</span></p>
        <p><span><br>
          </span></p>
        <p><span>But ya, if you use the broadcast bit who are you
            reading from then ... hmm..</span></p>
        <p><span><br>
          </span></p>
        <p><span>Tom</span></p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> amd-gfx
                <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on behalf
                of Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org">&lt;michel.daenzer-cl+VPiYnx/1AfugRpC6u6w@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Monday, October 10, 2016 23:52<br>
                <b>To:</b> Tom St Denis<br>
                <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amd/amdgpu: Allow
                broadcast on debugfs read (v2)</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">On 09/10/16 08:58 PM, Tom St Denis
                wrote:<br>
                &gt; Allow any of the se/sh/instance fields to be<br>
                &gt; specified as a broadcast by submitting 0x3FF.<br>
                &gt; <br>
                &gt; (v2) Fix broadcast range checking<br>
                &gt; <br>
                &gt; Signed-off-by: Tom St Denis
                <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">&lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                <br>
                I'm not sure how a "broadcast read" is supposed to work?
                I can only see<br>
                the register specs talking about broadcast in connection
                with writes.<br>
                <br>
                <br>
                -- <br>
                Earthling Michel Dänzer               |               <a
                  moz-do-not-send="true" href="http://www.amd.com"
                  id="LPlnk365128" previewremoved="true">
                  http://www.amd.com</a>
                <div id="LPBorder_GT_14761814794940.12544022877196426"
                  style="margin-bottom: 20px; overflow: auto; width:
                  100%; text-indent: 0px;">
                  <table
                    id="LPContainer_14761814794910.48081554222867373"
                    style="width: 90%; background-color: rgb(255, 255,
                    255); position: relative; overflow: auto;
                    padding-top: 20px; padding-bottom: 20px; margin-top:
                    20px; border-top: 1px dotted rgb(200, 200, 200);
                    border-bottom: 1px dotted rgb(200, 200, 200);"
                    cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td
                          id="TextCell_14761814794930.6330030561431497"
                          colspan="2" style="vertical-align: top;
                          position: relative; padding: 0px; display:
                          table-cell;">
                          <div
                            id="LPTitle_14761814794930.0860209784141206"
                            style="top: 0px; color: rgb(59, 87, 119);
                            font-weight: normal; font-size: 21px;
                            font-family: wf_segoe-ui_light, &quot;Segoe
                            UI Light&quot;, &quot;Segoe WP Light&quot;,
                            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
                            Tahoma, Arial, sans-serif; line-height:
                            21px;">
                            <a moz-do-not-send="true"
                              id="LPUrlAnchor_14761814794930.01359389598361771"
                              href="http://www.amd.com/" target="_blank"
                              style="text-decoration: none;">Graphics,
                              Processors and Immersive VR Solutions |
                              AMD
                            </a></div>
                          <div
                            id="LPMetadata_14761814794940.4677118614629565"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); font-weight: normal;
                            font-family: wf_segoe-ui_normal, &quot;Segoe
                            UI&quot;, &quot;Segoe WP&quot;, Tahoma,
                            Arial, sans-serif; font-size: 14px;
                            line-height: 14px;">
                            <a class="moz-txt-link-abbreviated" href="http://www.amd.com">www.amd.com</a></div>
                          <div
                            id="LPDescription_14761814794940.37923242485275344"
                            style="display: block; color: rgb(102, 102,
                            102); font-weight: normal; font-family:
                            wf_segoe-ui_normal, &quot;Segoe UI&quot;,
                            &quot;Segoe WP&quot;, Tahoma, Arial,
                            sans-serif; font-size: 14px; line-height:
                            20px; max-height: 100px; overflow: hidden;">
                            Explore a wide range of innovative next
                            generation computing processors, graphics,
                            and Immersive VR solutions by Advanced Micro
                            Devices (AMD). Visit AMD.com now!</div>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </div>
                <br>
                <br>
                Libre software enthusiast             |             Mesa
                and X developer<br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  id="LPlnk287571" previewremoved="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                <div id="LPBorder_GT_14761815380460.6817372487984479"
                  style="margin-bottom: 20px; overflow: auto; width:
                  100%; text-indent: 0px;">
                  <table
                    id="LPContainer_14761815380420.37970165615775286"
                    style="width: 90%; background-color: rgb(255, 255,
                    255); position: relative; overflow: auto;
                    padding-top: 20px; padding-bottom: 20px; margin-top:
                    20px; border-top: 1px dotted rgb(200, 200, 200);
                    border-bottom: 1px dotted rgb(200, 200, 200);"
                    cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td
                          id="TextCell_14761815380430.2899884346376056"
                          colspan="2" style="vertical-align: top;
                          position: relative; padding: 0px; display:
                          table-cell;">
                          <div
                            id="LPTitle_14761815380440.5311884203741501"
                            style="top: 0px; color: rgb(59, 87, 119);
                            font-weight: normal; font-size: 21px;
                            font-family: wf_segoe-ui_light, &quot;Segoe
                            UI Light&quot;, &quot;Segoe WP Light&quot;,
                            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
                            Tahoma, Arial, sans-serif; line-height:
                            21px;">
                            <a moz-do-not-send="true"
                              id="LPUrlAnchor_14761815380450.40820370331518996"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                              target="_blank" style="text-decoration:
                              none;">amd-gfx Info Page -
                              lists.freedesktop.org</a></div>
                          <div
                            id="LPMetadata_14761815380450.487355067260703"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); font-weight: normal;
                            font-family: wf_segoe-ui_normal, &quot;Segoe
                            UI&quot;, &quot;Segoe WP&quot;, Tahoma,
                            Arial, sans-serif; font-size: 14px;
                            line-height: 14px;">
                            lists.freedesktop.org</div>
                          <div
                            id="LPDescription_14761815380450.7331276341568305"
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

--------------99C2E16655B4ECAEBCF9B785--

--===============1671132621==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1671132621==--
