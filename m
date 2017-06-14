From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: Question about porting VCE1 to amdgpu
Date: Wed, 14 Jun 2017 19:39:22 +0200
Message-ID: <c0453c45-9032-2451-c8c3-6e5b2d8faf21@vodafone.de>
References: <CAPEhTTGyy4jehNXhe93h=kB29ThOxctWzuaiwrfjkyDVu5wMww@mail.gmail.com>
 <c3b779e6-3a65-770d-5ba5-40cd293ded3e@vodafone.de>
 <BN6PR12MB165227C924CF7BC1E0D71D92F7C30@BN6PR12MB1652.namprd12.prod.outlook.com>
 <CAPEhTTEUBR-wXeXetU=uzA42o_2KXJfCi0s8rr_AK_7ygA3RiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1849832021=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CAPEhTTEUBR-wXeXetU=uzA42o_2KXJfCi0s8rr_AK_7ygA3RiA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1849832021==
Content-Type: multipart/alternative;
 boundary="------------528E61031B8AC84B8E2AE813"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------528E61031B8AC84B8E2AE813
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

> OK. Then,  is it expected to have a validation failure with the 
> current firmware?
Yeah, that won't work. We never released the firmware with the header 
for SI parts.

See for CIK we have upper and lower case firmware files, the lower case 
are the new ones with the header.

> I've been using VCE2 port as my template for VCE1. My initial 
> intention was to work on UVD, but I ended up plugging in VCE in the 
> first place. UVD is on my todo list right next, I was expecting to 
> working on it after fixing the VCE part.
That stuff would be really nice to get fixed. But i fear you won't get 
far without AMD internal help. I will see what I can do about that.

Thanks for the effort,
Christian.

Am 14.06.2017 um 19:30 schrieb Alexandre Demers:
> On Wed, 14 Jun 2017 at 13:09 Deucher, Alexander 
> <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org <mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     *From:*amd-gfx [mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>] *On Behalf Of
>     *Christian König
>     *Sent:* Wednesday, June 14, 2017 12:37 PM
>     *To:* Alexandre Demers; Freedesktop - AMD-gfx
>     *Subject:* Re: Question about porting VCE1 to amdgpu
>
>         - Would we need a different firmware version with a different
>         "hdr" for the amdgpu driver?
>
>     Yes, we should probably release the latest one instead of reusing
>     the one used with radeon.
>
>     Actually, we should probably stick the same one as radeon for now
>     until we can verify the new firmware in general.  Easier to start
>     with a known working case.
>
> OK. Then,  is it expected to have a validation failure with the 
> current firmware? Is the header compatible with how the validation is 
> done under VCE2 and others or should I keep how it was done under radeon?
>
>
>     BTW: Does VCE work on CIK? Alex, don't we run into the same issue
>     there as well?
>
>     VCE works on CIK.  We ported VCE and UVD to CIK as part of the
>     initial amdgpu bring up.
>
> I've been using VCE2 port as my template for VCE1. My initial 
> intention was to work on UVD, but I ended up plugging in VCE in the 
> first place. UVD is on my todo list right next, I was expecting to 
> working on it after fixing the VCE part.
>
>     Alex
>
>
>
>     - Wouldn't it be better to continue loading the driver while
>     having VCE disabled IF we fail when loading or validating the FW?
>     Completely failing to load the driver for this reason seems
>     overkill IMO, since nothing has been loaded in memory and no
>     registry have been modified up to that point.
>
>     UVD and VCE are actually needed for correct power management. When
>     the blocks fail to initialize you usually sooner or later run into
>     problems with power management (e.g. stuck inside a certain power
>     level).
>
> OK, but right now it is disabled, so the situation wouldn't be worst 
> isn't it?
>
>
>     - Would it be a good idea to send a patch as a RFC so some of you
>     could help me finish the job and maybe pinpoint where the last
>     modifications need to be done?
>
>     Well you could, but to be honest without AMD releasing new
>     firmware that is most likely a futile effort.
>
>
> I'll send a patch then, and we'll navigate from there. This will allow 
> me to work on UVD in parallel.
>
> Alexandre Demers
>
>
>     Regards,
>     Christian.
>
>     Am 14.06.2017 um 18:22 schrieb Alexandre Demers:
>
>         Hi,
>
>         I've been working on porting VCE1 from radeon to amdgpu in the
>         last few weeks. I'm pretty much done and I've enabled the
>         functionality to see how it goes. However, I ended up with an
>         error on the firmware validation (size doesn't seem to fit),
>         thus failing completely in loading the driver. I'm testing on
>         a R9 280X (Tahiti).
>
>         Three questions then:
>
>         - Would we need a different firmware version with a different
>         "hdr" for the amdgpu driver?
>
>         - Wouldn't it be better to continue loading the driver while
>         having VCE disabled IF we fail when loading or validating the
>         FW? Completely failing to load the driver for this reason
>         seems overkill IMO, since nothing has been loaded in memory
>         and no registry have been modified up to that point.
>
>         - Would it be a good idea to send a patch as a RFC so some of
>         you could help me finish the job and maybe pinpoint where the
>         last modifications need to be done?
>
>         Thank you!
>
>         Alexandre Demers
>
>
>
>
>         _______________________________________________
>
>         amd-gfx mailing list
>
>         amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>         <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>
>         https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------528E61031B8AC84B8E2AE813
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">
      <blockquote type="cite">
        <div>OK. Then,  is it expected to have a validation failure with
          the current firmware?</div>
      </blockquote>
      Yeah, that won't work. We never released the firmware with the
      header for SI parts.<br>
      <br>
      See for CIK we have upper and lower case firmware files, the lower
      case are the new ones with the header.<br>
      <br>
      <blockquote type="cite">
        <div>I've been using VCE2 port as my template for VCE1. My
          initial intention was to work on UVD, but I ended up plugging
          in VCE in the first place. UVD is on my todo list right next,
          I was expecting to working on it after fixing the VCE part.</div>
      </blockquote>
      That stuff would be really nice to get fixed. But i fear you won't
      get far without AMD internal help. I will see what I can do about
      that.<br>
      <br>
      Thanks for the effort,<br>
      Christian.<br>
      <br>
      Am 14.06.2017 um 19:30 schrieb Alexandre Demers:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAPEhTTEUBR-wXeXetU=uzA42o_2KXJfCi0s8rr_AK_7ygA3RiA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org">
      <div dir="ltr">
        <div class="gmail_quote">
          <div dir="ltr">On Wed, 14 Jun 2017 at 13:09 Deucher, Alexander
            &lt;<a href="mailto:Alexander.Deucher-5C7GfCeVMHo@public.gmane.org"
              moz-do-not-send="true">Alexander.Deucher-5C7GfCeVMHo@public.gmane.org</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"> </span></p>
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <div style="border:none;border-top:solid #b5c4df
                      1.0pt;padding:3.0pt 0in 0in 0in">
                      <p class="MsoNormal"><b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext">From:</span></b><span
style="font-size:10.0pt;font-family:&quot;Tahoma&quot;,&quot;sans-serif&quot;;color:windowtext">
                          amd-gfx [mailto:<a
                            href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            target="_blank" moz-do-not-send="true">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>]
                          <b>On Behalf Of </b>Christian König<br>
                          <b>Sent:</b> Wednesday, June 14, 2017 12:37 PM<br>
                          <b>To:</b> Alexandre Demers; Freedesktop -
                          AMD-gfx<br>
                          <b>Subject:</b> Re: Question about porting
                          VCE1 to amdgpu</span></p>
                    </div>
                  </div>
                  <p class="MsoNormal"> </p>
                </div>
              </div>
            </div>
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <blockquote
                      style="margin-top:5.0pt;margin-bottom:5.0pt">
                      <p class="MsoNormal">- Would we need a different
                        firmware version with a different "hdr" for the
                        amdgpu driver?</p>
                    </blockquote>
                    <p class="MsoNormal">Yes, we should probably release
                      the latest one instead of reusing the one used
                      with radeon.<br>
                      <br>
                      <span style="color:#1f497d"></span></p>
                  </div>
                </div>
              </div>
            </div>
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Actually,
                        we should probably stick the same one as radeon
                        for now until we can verify the new firmware in
                        general.  Easier to start with a known working
                        case.</span></p>
                  </div>
                </div>
              </div>
            </div>
          </blockquote>
          <div> </div>
          <div>OK. Then,  is it expected to have a validation failure
            with the current firmware? Is the header compatible with how
            the validation is done under VCE2 and others or should I
            keep how it was done under radeon?</div>
          <div><br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"></span></p>
                  </div>
                </div>
              </div>
            </div>
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"> </span></p>
                    <p class="MsoNormal"><br>
                      BTW: Does VCE work on CIK? Alex, don't we run into
                      the same issue there as well?<br>
                      <br>
                      <span style="color:#1f497d"></span></p>
                  </div>
                </div>
              </div>
            </div>
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">VCE
                        works on CIK.  We ported VCE and UVD to CIK as
                        part of the initial amdgpu bring up.</span></p>
                  </div>
                </div>
              </div>
            </div>
          </blockquote>
          <div> </div>
          <div>I've been using VCE2 port as my template for VCE1. My
            initial intention was to work on UVD, but I ended up
            plugging in VCE in the first place. UVD is on my todo list
            right next, I was expecting to working on it after fixing
            the VCE part.</div>
          <div><br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"></span></p>
                    <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d"> </span></p>
                    <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&quot;;color:#1f497d">Alex</span></p>
                  </div>
                </div>
              </div>
            </div>
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <p class="MsoNormal"><br>
                      <br>
                    </p>
                    <div>
                      <p class="MsoNormal">- Wouldn't it be better to
                        continue loading the driver while having VCE
                        disabled IF we fail when loading or validating
                        the FW? Completely failing to load the driver
                        for this reason seems overkill IMO, since
                        nothing has been loaded in memory and no
                        registry have been modified up to that point.</p>
                    </div>
                    <p class="MsoNormal">UVD and VCE are actually needed
                      for correct power management. When the blocks fail
                      to initialize you usually sooner or later run into
                      problems with power management (e.g. stuck inside
                      a certain power level).<br>
                      <br>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </blockquote>
          <div> </div>
          <div>OK, but right now it is disabled, so the situation
            wouldn't be worst isn't it?</div>
          <div><br>
          </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <p class="MsoNormal">
                      <br>
                    </p>
                    <div>
                      <p class="MsoNormal">- Would it be a good idea to
                        send a patch as a RFC so some of you could help
                        me finish the job and maybe pinpoint where the
                        last modifications need to be done?</p>
                    </div>
                    <p class="MsoNormal">Well you could, but to be
                      honest without AMD releasing new firmware that is
                      most likely a futile effort.<br>
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </blockquote>
          <div><br>
          </div>
          <div>I'll send a patch then, and we'll navigate from there.
            This will allow me to work on UVD in parallel.</div>
          <div><br>
          </div>
          <div>Alexandre Demers</div>
          <div> </div>
          <blockquote class="gmail_quote" style="margin:0 0 0
            .8ex;border-left:1px #ccc solid;padding-left:1ex">
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <div>
                    <p class="MsoNormal">
                      <br>
                      Regards,<br>
                      Christian.<br>
                      <br>
                      Am 14.06.2017 um 18:22 schrieb Alexandre Demers:</p>
                  </div>
                </div>
              </div>
            </div>
            <div bgcolor="white" link="blue" vlink="purple" lang="EN-US">
              <div class="m_-2481367577652910062WordSection1">
                <div style="border:none;border-left:solid blue
                  1.5pt;padding:0in 0in 0in 4.0pt">
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <div>
                      <p class="MsoNormal">Hi, </p>
                      <div>
                        <p class="MsoNormal"> </p>
                      </div>
                      <div>
                        <p class="MsoNormal">I've been working on
                          porting VCE1 from radeon to amdgpu in the last
                          few weeks. I'm pretty much done and I've
                          enabled the functionality to see how it goes.
                          However, I ended up with an error on the
                          firmware validation (size doesn't seem to
                          fit), thus failing completely in loading the
                          driver. I'm testing on a R9 280X (Tahiti).</p>
                      </div>
                      <div>
                        <p class="MsoNormal"> </p>
                      </div>
                      <div>
                        <p class="MsoNormal">Three questions then:</p>
                      </div>
                      <div>
                        <p class="MsoNormal">- Would we need a different
                          firmware version with a different "hdr" for
                          the amdgpu driver?</p>
                      </div>
                      <div>
                        <p class="MsoNormal">- Wouldn't it be better to
                          continue loading the driver while having VCE
                          disabled IF we fail when loading or validating
                          the FW? Completely failing to load the driver
                          for this reason seems overkill IMO, since
                          nothing has been loaded in memory and no
                          registry have been modified up to that point.</p>
                      </div>
                      <div>
                        <p class="MsoNormal">- Would it be a good idea
                          to send a patch as a RFC so some of you could
                          help me finish the job and maybe pinpoint
                          where the last modifications need to be done?</p>
                      </div>
                      <div>
                        <p class="MsoNormal"> </p>
                      </div>
                      <div>
                        <p class="MsoNormal">Thank you!</p>
                      </div>
                      <div>
                        <p class="MsoNormal">Alexandre Demers</p>
                      </div>
                    </div>
                    <p class="MsoNormal"><br>
                      <br>
                      <br>
                    </p>
                    <pre>_______________________________________________</pre>
                    <pre>amd-gfx mailing list</pre>
                    <pre><a href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a></pre>
                    <pre><a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></pre>
                  </blockquote>
                  <p> </p>
                </div>
              </div>
            </div>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------528E61031B8AC84B8E2AE813--

--===============1849832021==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1849832021==--
