From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH 8/8] drm/amdgpu: move align_mask and nop into ring funcs
 as well
Date: Tue, 11 Oct 2016 19:34:39 +0200
Message-ID: <af0cd5ae-1c2b-7156-d515-ec9dbbb55601@vodafone.de>
References: <1475676809-3061-1-git-send-email-deathsimple@vodafone.de>
 <1475676809-3061-8-git-send-email-deathsimple@vodafone.de>
 <57FCE58E.5040107@gmail.com>
 <82e102e9-cd1b-10ce-75ca-201ef4b802d4@vodafone.de>
 <CY4PR12MB1768C74FCED56F7663ABCE5BF7DA0@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0291202413=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768C74FCED56F7663ABCE5BF7DA0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0291202413==
Content-Type: multipart/alternative;
 boundary="------------9274FCD40C354E9CB4316549"

This is a multi-part message in MIME format.
--------------9274FCD40C354E9CB4316549
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Turned out I just missed adding the three lines to the physical mode for 
VCE on Tonga as well.

Please test and review the patch I've just send to the mailing list.

Regards,
Christian.

Am 11.10.2016 um 15:28 schrieb StDenis, Tom:
>
> It dies on my Tonga just FYI (save you some trouble).
>
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Christian König <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
> *Sent:* Tuesday, October 11, 2016 09:26
> *To:* Andy Furniss; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Subject:* Re: [PATCH 8/8] drm/amdgpu: move align_mask and nop into 
> ring funcs as well
> Am 11.10.2016 um 15:13 schrieb Andy Furniss:
> > Christian König wrote:
> >> From: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>
> >>
> >> They are constant as well.
> >
> > I die on driver load with this commit on R9285 testing on 4.9-wip.
> >
> >
> Probably just a typo in the hardware handling.
>
> Going to switch to my Tonga in a minute, but I only got about half an
> hour left before I need to get my daughter from kindergarten.
>
> Christian.
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



--------------9274FCD40C354E9CB4316549
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">Turned out I just missed adding the
      three lines to the physical mode for VCE on Tonga as well.<br>
      <br>
      Please test and review the patch I've just send to the mailing
      list.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 11.10.2016 um 15:28 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1768C74FCED56F7663ABCE5BF7DA0-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>It dies on my Tonga just FYI (save you some trouble).</p>
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
                <b>Sent:</b> Tuesday, October 11, 2016 09:26<br>
                <b>To:</b> Andy Furniss; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Subject:</b> Re: [PATCH 8/8] drm/amdgpu: move
                align_mask and nop into ring funcs as well</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Am 11.10.2016 um 15:13 schrieb Andy
                Furniss:<br>
                &gt; Christian König wrote:<br>
                &gt;&gt; From: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                &gt;&gt;<br>
                &gt;&gt; They are constant as well.<br>
                &gt;<br>
                &gt; I die on driver load with this commit on R9285
                testing on 4.9-wip.<br>
                &gt;<br>
                &gt;<br>
                Probably just a typo in the hardware handling.<br>
                <br>
                Going to switch to my Tonga in a minute, but I only got
                about half an <br>
                hour left before I need to get my daughter from
                kindergarten.<br>
                <br>
                Christian.<br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  id="LPlnk232679" previewremoved="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                <div id="LPBorder_GT_14761924713750.3264565919104536"
                  style="margin-bottom: 20px; overflow: auto; width:
                  100%; text-indent: 0px;">
                  <table
                    id="LPContainer_14761924713730.05028899734727377"
                    style="width: 90%; background-color: rgb(255, 255,
                    255); position: relative; overflow: auto;
                    padding-top: 20px; padding-bottom: 20px; margin-top:
                    20px; border-top: 1px dotted rgb(200, 200, 200);
                    border-bottom: 1px dotted rgb(200, 200, 200);"
                    cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td id="TextCell_14761924713730.314774573443503"
                          colspan="2" style="vertical-align: top;
                          position: relative; padding: 0px; display:
                          table-cell;">
                          <div
                            id="LPTitle_14761924713740.009190374513265542"
                            style="top: 0px; color: rgb(59, 87, 119);
                            font-weight: normal; font-size: 21px;
                            font-family: wf_segoe-ui_light, &quot;Segoe
                            UI Light&quot;, &quot;Segoe WP Light&quot;,
                            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
                            Tahoma, Arial, sans-serif; line-height:
                            21px;">
                            <a moz-do-not-send="true"
                              id="LPUrlAnchor_14761924713740.4488872061620295"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                              target="_blank" style="text-decoration:
                              none;">amd-gfx Info Page -
                              lists.freedesktop.org</a></div>
                          <div
                            id="LPMetadata_14761924713740.6388958295049414"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); font-weight: normal;
                            font-family: wf_segoe-ui_normal, &quot;Segoe
                            UI&quot;, &quot;Segoe WP&quot;, Tahoma,
                            Arial, sans-serif; font-size: 14px;
                            line-height: 14px;">
                            lists.freedesktop.org</div>
                          <div
                            id="LPDescription_14761924713740.42639052946896294"
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

--------------9274FCD40C354E9CB4316549--

--===============0291202413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0291202413==--
