From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: amdgpu: ratelimit on vm faults to avoid spaming console
Date: Tue, 8 Nov 2016 11:10:00 +0100
Message-ID: <02ac0302-1977-feab-575a-96ad69c43c7f@vodafone.de>
References: <1478493309-30328-1-git-send-email-funfunctor@folklore1984.net>
 <CADnq5_NG7GcFJxA8mq0-fEE51Jw7TCjYPn68wSMA846tFB8fNQ@mail.gmail.com>
 <CY4PR12MB1768E71EFBD0472E7E170B72F7A70@CY4PR12MB1768.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1069231647=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1768E71EFBD0472E7E170B72F7A70-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Edward O'Callaghan <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org>, =?UTF-8?Q?Nicolai_H=c3=a4hnle?= <nhaehnle-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Olsak <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1069231647==
Content-Type: multipart/alternative;
 boundary="------------BF3C4FCCB440B47F2EA90DF7"

This is a multi-part message in MIME format.
--------------BF3C4FCCB440B47F2EA90DF7
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I would rather say that we need to add this to the per context lockup 
informations.

Marek had a rather good start for this, but from the VM fault handler it 
is actually rather tricky to figure out reliable who caused it.

Because of this we didn't followed this approach to the end.

Christian.

Am 07.11.2016 um 19:42 schrieb StDenis, Tom:
>
> Could we provide fault information through a ring buffer and a debugfs 
> or drm ioctl interface?
>
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Monday, November 7, 2016 13:35
> *To:* Edward O'Callaghan; Nicolai Hähnle; Marek Olsak
> *Cc:* Michel Dänzer; amd-gfx list
> *Subject:* Re: amdgpu: ratelimit on vm faults to avoid spaming console
> On Sun, Nov 6, 2016 at 11:35 PM, Edward O'Callaghan
> <funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org> wrote:
> > These are rather minor however should help stop some folks
> > machines grinding to a halt when a userspace application somehow
> > gets the GPU into some horrible state causing the console to fill
> > very quickly. Applies on top of master.
>
> I'm generally ok with the idea.  My only concern would be if this
> would adversely affect the radeon GPUVM debugging options in mesa and
> piglit. Nicolai? Marek?
>
> Alex
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



--------------BF3C4FCCB440B47F2EA90DF7
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">I would rather say that we need to add
      this to the per context lockup informations.<br>
      <br>
      Marek had a rather good start for this, but from the VM fault
      handler it is actually rather tricky to figure out reliable who
      caused it.<br>
      <br>
      Because of this we didn't followed this approach to the end.<br>
      <br>
      Christian.<br>
      <br>
      Am 07.11.2016 um 19:42 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:CY4PR12MB1768E71EFBD0472E7E170B72F7A70-rpdhrqHFk06yjjPBNVDk/QdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Arial,Helvetica,sans-serif;"
        dir="ltr">
        <p>Could we provide fault information through a ring buffer and
          a debugfs or drm ioctl interface?</p>
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
                of Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Monday, November 7, 2016 13:35<br>
                <b>To:</b> Edward O'Callaghan; Nicolai Hähnle; Marek
                Olsak<br>
                <b>Cc:</b> Michel Dänzer; amd-gfx list<br>
                <b>Subject:</b> Re: amdgpu: ratelimit on vm faults to
                avoid spaming console</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">On Sun, Nov 6, 2016 at 11:35 PM,
                Edward O'Callaghan<br>
                <a class="moz-txt-link-rfc2396E" href="mailto:funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org">&lt;funfunctor-dczkZgxz+BNUPWh3PAxdjQ@public.gmane.org&gt;</a> wrote:<br>
                &gt; These are rather minor however should help stop
                some folks<br>
                &gt; machines grinding to a halt when a userspace
                application somehow<br>
                &gt; gets the GPU into some horrible state causing the
                console to fill<br>
                &gt; very quickly. Applies on top of master.<br>
                <br>
                I'm generally ok with the idea.  My only concern would
                be if this<br>
                would adversely affect the radeon GPUVM debugging
                options in mesa and<br>
                piglit. Nicolai? Marek?<br>
                <br>
                Alex<br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a moz-do-not-send="true"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  id="LPlnk579816" previewremoved="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                <div id="LPBorder_GT_14785440992340.6054453351200089"
                  style="margin-bottom: 20px; overflow: auto; width:
                  100%; text-indent: 0px;">
                  <table
                    id="LPContainer_14785440992320.1566381865079014"
                    style="width: 90%; background-color: rgb(255, 255,
                    255); position: relative; overflow: auto;
                    padding-top: 20px; padding-bottom: 20px; margin-top:
                    20px; border-top: 1px dotted rgb(200, 200, 200);
                    border-bottom: 1px dotted rgb(200, 200, 200);"
                    cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td
                          id="TextCell_14785440992330.6501901400933325"
                          colspan="2" style="vertical-align: top;
                          position: relative; padding: 0px; display:
                          table-cell;">
                          <div
                            id="LPTitle_14785440992330.4408640782321278"
                            style="top: 0px; color: rgb(59, 87, 119);
                            font-weight: normal; font-size: 21px;
                            font-family: wf_segoe-ui_light, &quot;Segoe
                            UI Light&quot;, &quot;Segoe WP Light&quot;,
                            &quot;Segoe UI&quot;, &quot;Segoe WP&quot;,
                            Tahoma, Arial, sans-serif; line-height:
                            21px;">
                            <a moz-do-not-send="true"
                              id="LPUrlAnchor_14785440992330.7137225661684092"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                              target="_blank" style="text-decoration:
                              none;">amd-gfx Info Page -
                              lists.freedesktop.org</a></div>
                          <div
                            id="LPMetadata_14785440992340.5134728364532262"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); font-weight: normal;
                            font-family: wf_segoe-ui_normal, &quot;Segoe
                            UI&quot;, &quot;Segoe WP&quot;, Tahoma,
                            Arial, sans-serif; font-size: 14px;
                            line-height: 14px;">
                            lists.freedesktop.org</div>
                          <div
                            id="LPDescription_14785440992340.6803326765635758"
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

--------------BF3C4FCCB440B47F2EA90DF7--

--===============1069231647==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1069231647==--
