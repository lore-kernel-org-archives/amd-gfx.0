From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Mon, 19 Mar 2018 20:44:49 +0100
Message-ID: <f25ebe1d-0b19-e972-5eba-84570e625456@gmail.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <898d3377-ee2b-a33d-dbff-b4cb692d650d@amd.com>
 <BY1PR12MB050407EA9472CB2B6E101CE7F5D90@BY1PR12MB0504.namprd12.prod.outlook.com>
 <e416ff00-018b-f206-123e-90b09b4ccd9f@gmail.com>
 <ebe01500-9fa5-e541-86c3-30ff0168e792@daenzer.net>
 <cd4659cb-f030-4938-af44-2fa1389ccdfb@gmail.com>
 <6febc0d1-0171-3cc1-ff22-69aa4ef36036@daenzer.net>
 <12178e4c-6b48-2c3b-9970-2ca30624a5bb@gmail.com>
 <29dba5ab-f4f3-551b-ec94-2d6433e8aa21@daenzer.net>
 <1141c511-597e-c81b-6ffd-800ff846f2c1@gmail.com>
 <1b643a78-d86a-b3bf-5f92-089a43201dd5@daenzer.net>
 <06e9160c-b4d4-6c3a-ff9f-04b40b94c7a0@amd.com>
 <BY1PR12MB0504A300C476CC31C59BFE97F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <2c995c37-0d0b-8fde-0118-57d7a62630ef@amd.com>
 <CAAxE2A5kq2oZtJRm2df1fjtb_p1m2_nvCmzv9y8mbO-GS8cGrw@mail.gmail.com>
 <BY1PR12MB0504183ED35A54559D22E041F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0228251682=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BY1PR12MB0504183ED35A54559D22E041F5D40-PicGAnIBOoZIlHzfMOeg3gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0228251682==
Content-Type: multipart/alternative;
 boundary="------------36A736C4813227F83595037F"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------36A736C4813227F83595037F
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Quoting Alex:
> Regardless of which scenarios we need to support, I think we also need
> to really plumb this through to mesa however since user space is who
> ultimately requests the location.  Overriding it in the kernel gets
> tricky and can lead to ping-ponging as others have noted.  Better to
> have user space know what chips support it or not and request display
> buffers in GTT or VRAM from the start.
And I completely agree with Alex here. So overriding the domain in the 
kernel is a serious NAK from my side as well.

Please implement the necessary bits in Mesa, shouldn't be more than a 
few lines of code anyway.

Regards,
Christian.

Am 19.03.2018 um 20:42 schrieb Li, Samuel:
>
> Agreed.
>
> >I think that the consensus with Alex and me is that we should avoid 
> exactly that.
> Christian, Alex’s concern is about ping-pong, not about the preferred 
> domain.
>
> Regards,
>
> Samuel Li
>
> *From:*Marek Olšák [mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> *Sent:* Monday, March 19, 2018 3:39 PM
> *To:* Koenig, Christian <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
> *Cc:* Li, Samuel <Samuel.Li-5C7GfCeVMHo@public.gmane.org>; Michel Dänzer 
> <michel-otUistvHUpPR7s880joybQ@public.gmane.org>; Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>; amd-gfx 
> list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display 
> support
>
> On Mon, Mar 19, 2018 at 3:27 PM, Christian König 
> <christian.koenig-5C7GfCeVMHo@public.gmane.org <mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     I think that the consensus with Alex and me is that we should
>     avoid exactly that.
>
>     Overriding the preferred domain in the kernel is a no-go for that
>     patch set, so please implement the discussed changes in Mesa.
>
> I don't see how Mesa can make a smarter decision than the kernel. If 
> you overwrite the preferred domain of the buffer in the kernel, there 
> will be no ping-ponging between domains. Mesa never changes the 
> initial preferred domain.
>
> Marek
>
>
>     Regards,
>     Christian.
>
>
>
>     Am 19.03.2018 um 20:22 schrieb Li, Samuel:
>
>         I agree with Marek/Michel: since kernel sets the domain before
>         scanning out, it shall update the preferred domain here too.
>
>         Regards,
>         Samuel Li
>
>             -----Original Message-----
>             From: Koenig, Christian
>             Sent: Thursday, March 08, 2018 4:07 AM
>             To: Michel Dänzer <michel-otUistvHUpPR7s880joybQ@public.gmane.org
>             <mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org>>; Li, Samuel
>             <Samuel.Li-5C7GfCeVMHo@public.gmane.org <mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>>; Alex
>             Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>             Cc: amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>             <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>>
>             Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather
>             display support
>
>             Am 08.03.2018 um 09:35 schrieb Michel Dänzer:
>
>                 On 2018-03-07 10:47 AM, Christian König wrote:
>
>                     Am 07.03.2018 um 09:42 schrieb Michel Dänzer:
>
>                         On 2018-03-06 07:23 PM, Christian König wrote:
>
>                             E.g. the last time I tested it placing
>                             things into GTT still
>                             resulted in quite a performance penalty
>                             for rendering.
>
>                         FWIW, I think the penalty is most likely IOMMU
>                         related. Last time I
>                         tested, I couldn't measure a big difference
>                         with IOMMU disabled.
>
>                     No, the penalty I'm talking about came from the
>                     ping/pong we did with
>                     the scanout buffers.
>
>                     See when I tested this the DDX and Mesa where
>                     unmodified, so both
>                     still assumed VRAM as placement for scanout BOs,
>                     but the kernel
>                     forced scanout BOs into GTT for testing.
>
>                     So what happened was that on scanout we moved the
>                     VRAM BO to GTT
>
>             and
>
>                     after unpinning it on the first command submission
>                     which used the BO
>                     we moved it back to VRAM again.
>
>                 In the meantime, I've had the same idea as Marek:
>                 Can't the kernel
>                 driver simply change the BO's preferred domain to GTT
>                 when scanning
>                 out from it? Then it won't move back to VRAM.
>
>             Yes, I've considered this as well.
>
>             But I think making the decision in Mesa is the cleaner
>             approach.
>
>             E.g. so far we only override the placement decision of
>             userspace for two
>             reasons:
>             1. We where running out of memory in VRAM.
>             2. We have a hardware restriction which makes VRAM usage
>             mandatory.
>
>             And even then we never adjust the placement permanently,
>             we just
>             temporary moved the buffer where it was needed and moved
>             it back after
>             the operation completed.
>
>             Additional to that Mesa might want to set even more flags
>             and/or changes
>             it's behavior. E.g. use a tilling mode which both importer
>             and export in an
>             A+A laptop understands etc...
>
>             Regards,
>             Christian.
>
>
>     _______________________________________________
>     amd-gfx mailing list
>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------36A736C4813227F83595037F
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Quoting Alex:<br>
      <blockquote type="cite">
        <pre wrap="">Regardless of which scenarios we need to support, I think we also need
to really plumb this through to mesa however since user space is who
ultimately requests the location.  Overriding it in the kernel gets
tricky and can lead to ping-ponging as others have noted.  Better to
have user space know what chips support it or not and request display
buffers in GTT or VRAM from the start.</pre>
      </blockquote>
      And I completely agree with Alex here. So overriding the domain in
      the kernel is a serious NAK from my side as well.<br>
      <br>
      Please implement the necessary bits in Mesa, shouldn't be more
      than a few lines of code anyway.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 19.03.2018 um 20:42 schrieb Li, Samuel:<br>
    </div>
    <blockquote type="cite"
cite="mid:BY1PR12MB0504183ED35A54559D22E041F5D40-PicGAnIBOoZIlHzfMOeg3gdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman",serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:#2F5496;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Agreed.<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p> </o:p></span></p>
        <p class="MsoNormal">&gt;I think that the consensus with Alex
          and me is that we should avoid exactly that.<br>
          Christian, Alex’s concern is about ping-pong, not about the
          preferred domain. <br>
          <br>
          <span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Regards,<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496">Samuel
            Li<o:p></o:p></span></p>
        <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#2F5496"><o:p> </o:p></span></p>
        <div style="border:none;border-left:solid blue 1.5pt;padding:0in
          0in 0in 4.0pt">
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b><span
                    style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                  Marek Olšák [<a class="moz-txt-link-freetext" href="mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">mailto:maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>]
                  <br>
                  <b>Sent:</b> Monday, March 19, 2018 3:39 PM<br>
                  <b>To:</b> Koenig, Christian
                  <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig-5C7GfCeVMHo@public.gmane.org">&lt;Christian.Koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  <b>Cc:</b> Li, Samuel <a class="moz-txt-link-rfc2396E" href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org">&lt;Samuel.Li-5C7GfCeVMHo@public.gmane.org&gt;</a>;
                  Michel Dänzer <a class="moz-txt-link-rfc2396E" href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org">&lt;michel-otUistvHUpPR7s880joybQ@public.gmane.org&gt;</a>; Alex Deucher
                  <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a>; amd-gfx list
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable
                  scatter gather display support<o:p></o:p></span></p>
            </div>
          </div>
          <p class="MsoNormal"><o:p> </o:p></p>
          <div>
            <div>
              <div>
                <p class="MsoNormal">On Mon, Mar 19, 2018 at 3:27 PM,
                  Christian König &lt;<a
                    href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org"
                    target="_blank" moz-do-not-send="true">christian.koenig-5C7GfCeVMHo@public.gmane.org</a>&gt;
                  wrote:<o:p></o:p></p>
                <blockquote style="border:none;border-left:solid #CCCCCC
                  1.0pt;padding:0in 0in 0in
                  6.0pt;margin-left:4.8pt;margin-right:0in">
                  <p class="MsoNormal">I think that the consensus with
                    Alex and me is that we should avoid exactly that.<br>
                    <br>
                    Overriding the preferred domain in the kernel is a
                    no-go for that patch set, so please implement the
                    discussed changes in Mesa.<o:p></o:p></p>
                </blockquote>
                <div>
                  <p class="MsoNormal"><o:p> </o:p></p>
                </div>
                <div>
                  <p class="MsoNormal">I don't see how Mesa can make a
                    smarter decision than the kernel. If you overwrite
                    the preferred domain of the buffer in the kernel,
                    there will be no ping-ponging between domains. Mesa
                    never changes the initial preferred domain.<o:p></o:p></p>
                </div>
                <div>
                  <p class="MsoNormal"><o:p> </o:p></p>
                </div>
                <div>
                  <p class="MsoNormal">Marek<o:p></o:p></p>
                </div>
                <div>
                  <p class="MsoNormal"><o:p> </o:p></p>
                </div>
                <div>
                  <p class="MsoNormal"> <o:p></o:p></p>
                </div>
                <blockquote style="border:none;border-left:solid #CCCCCC
                  1.0pt;padding:0in 0in 0in
                  6.0pt;margin-left:4.8pt;margin-right:0in">
                  <p class="MsoNormal"><br>
                    Regards,<br>
                    Christian.<o:p></o:p></p>
                  <div>
                    <div>
                      <p class="MsoNormal"><br>
                        <br>
                        Am 19.03.2018 um 20:22 schrieb Li, Samuel:<o:p></o:p></p>
                      <blockquote style="border:none;border-left:solid
                        #CCCCCC 1.0pt;padding:0in 0in 0in
                        6.0pt;margin-left:4.8pt;margin-right:0in">
                        <p class="MsoNormal"
                          style="margin-bottom:12.0pt">I agree with
                          Marek/Michel: since kernel sets the domain
                          before scanning out, it shall update the
                          preferred domain here too.<br>
                          <br>
                          Regards,<br>
                          Samuel Li<br>
                          <br>
                          <o:p></o:p></p>
                        <blockquote style="border:none;border-left:solid
                          #CCCCCC 1.0pt;padding:0in 0in 0in
                          6.0pt;margin-left:4.8pt;margin-right:0in">
                          <p class="MsoNormal">-----Original
                            Message-----<br>
                            From: Koenig, Christian<br>
                            Sent: Thursday, March 08, 2018 4:07 AM<br>
                            To: Michel Dänzer &lt;<a
                              href="mailto:michel-otUistvHUpPR7s880joybQ@public.gmane.org"
                              target="_blank" moz-do-not-send="true">michel-otUistvHUpPR7s880joybQ@public.gmane.org</a>&gt;;
                            Li, Samuel<br>
                            &lt;<a href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org"
                              target="_blank" moz-do-not-send="true">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;;
                            Alex Deucher &lt;<a
                              href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                              target="_blank" moz-do-not-send="true">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                            Cc: amd-gfx list &lt;<a
                              href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                              target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;<br>
                            Subject: Re: [PATCH 1/2] drm/amdgpu: Enable
                            scatter gather display support<br>
                            <br>
                            Am 08.03.2018 um 09:35 schrieb Michel
                            Dänzer:<o:p></o:p></p>
                          <blockquote
                            style="border:none;border-left:solid #CCCCCC
                            1.0pt;padding:0in 0in 0in
                            6.0pt;margin-left:4.8pt;margin-right:0in">
                            <p class="MsoNormal">On 2018-03-07 10:47 AM,
                              Christian König wrote:<o:p></o:p></p>
                            <blockquote
                              style="border:none;border-left:solid
                              #CCCCCC 1.0pt;padding:0in 0in 0in
                              6.0pt;margin-left:4.8pt;margin-right:0in">
                              <p class="MsoNormal">Am 07.03.2018 um
                                09:42 schrieb Michel Dänzer:<o:p></o:p></p>
                              <blockquote
                                style="border:none;border-left:solid
                                #CCCCCC 1.0pt;padding:0in 0in 0in
                                6.0pt;margin-left:4.8pt;margin-right:0in">
                                <p class="MsoNormal"
                                  style="margin-bottom:12.0pt">On
                                  2018-03-06 07:23 PM, Christian König
                                  wrote:<o:p></o:p></p>
                                <blockquote
                                  style="border:none;border-left:solid
                                  #CCCCCC 1.0pt;padding:0in 0in 0in
                                  6.0pt;margin-left:4.8pt;margin-right:0in">
                                  <p class="MsoNormal">E.g. the last
                                    time I tested it placing things into
                                    GTT still<br>
                                    resulted in quite a performance
                                    penalty for rendering.<o:p></o:p></p>
                                </blockquote>
                                <p class="MsoNormal">FWIW, I think the
                                  penalty is most likely IOMMU related.
                                  Last time I<br>
                                  tested, I couldn't measure a big
                                  difference with IOMMU disabled.<o:p></o:p></p>
                              </blockquote>
                              <p class="MsoNormal">No, the penalty I'm
                                talking about came from the ping/pong we
                                did with<br>
                                the scanout buffers.<br>
                                <br>
                                See when I tested this the DDX and Mesa
                                where unmodified, so both<br>
                                still assumed VRAM as placement for
                                scanout BOs, but the kernel<br>
                                forced scanout BOs into GTT for testing.<br>
                                <br>
                                So what happened was that on scanout we
                                moved the VRAM BO to GTT<o:p></o:p></p>
                            </blockquote>
                          </blockquote>
                          <p class="MsoNormal">and<o:p></o:p></p>
                          <blockquote
                            style="border:none;border-left:solid #CCCCCC
                            1.0pt;padding:0in 0in 0in
                            6.0pt;margin-left:4.8pt;margin-right:0in">
                            <blockquote
                              style="border:none;border-left:solid
                              #CCCCCC 1.0pt;padding:0in 0in 0in
                              6.0pt;margin-left:4.8pt;margin-right:0in">
                              <p class="MsoNormal">after unpinning it on
                                the first command submission which used
                                the BO<br>
                                we moved it back to VRAM again.<o:p></o:p></p>
                            </blockquote>
                            <p class="MsoNormal">In the meantime, I've
                              had the same idea as Marek: Can't the
                              kernel<br>
                              driver simply change the BO's preferred
                              domain to GTT when scanning<br>
                              out from it? Then it won't move back to
                              VRAM.<o:p></o:p></p>
                          </blockquote>
                          <p class="MsoNormal">Yes, I've considered this
                            as well.<br>
                            <br>
                            But I think making the decision in Mesa is
                            the cleaner approach.<br>
                            <br>
                            E.g. so far we only override the placement
                            decision of userspace for two<br>
                            reasons:<br>
                            1. We where running out of memory in VRAM.<br>
                            2. We have a hardware restriction which
                            makes VRAM usage mandatory.<br>
                            <br>
                            And even then we never adjust the placement
                            permanently, we just<br>
                            temporary moved the buffer where it was
                            needed and moved it back after<br>
                            the operation completed.<br>
                            <br>
                            Additional to that Mesa might want to set
                            even more flags and/or changes<br>
                            it's behavior. E.g. use a tilling mode which
                            both importer and export in an<br>
                            A+A laptop understands etc...<br>
                            <br>
                            Regards,<br>
                            Christian.<o:p></o:p></p>
                        </blockquote>
                      </blockquote>
                      <p class="MsoNormal"><br>
                        _______________________________________________<br>
                        amd-gfx mailing list<br>
                        <a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                          target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                        <a
                          href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                          target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><o:p></o:p></p>
                    </div>
                  </div>
                </blockquote>
              </div>
              <p class="MsoNormal"><o:p> </o:p></p>
            </div>
          </div>
        </div>
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
    <br>
  </body>
</html>

--------------36A736C4813227F83595037F--

--===============0228251682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0228251682==--
