From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: radeon VS amdgpu: _afmt_init() behavior if kzalloc fails
Date: Fri, 12 Aug 2016 18:39:50 +0200
Message-ID: <b00f6b78-a3fe-8b94-fc0d-a8d943169fed@vodafone.de>
References: <CAPEhTTHK2uF4r4TuR4Vt4oBD9WsxyoAuwLDQ6bRSmus-BKd1eg@mail.gmail.com>
 <DM5PR12MB1132E5443A7E25075E297A30F71F0@DM5PR12MB1132.namprd12.prod.outlook.com>
 <CAPEhTTFw-sk4Hq_6-r2eakVMuYC07DRJc0zKa0fWm_aWF+tADQ@mail.gmail.com>
 <DM5PR12MB11326BF415D31AE5DB0B0A5EF71F0@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1367222042=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB11326BF415D31AE5DB0B0A5EF71F0-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Freedesktop - AMD-gfx <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: Alexander Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is a multi-part message in MIME format.
--===============1367222042==
Content-Type: multipart/alternative;
 boundary="------------D916D1D8EDD7ACDD4F14C8A6"

This is a multi-part message in MIME format.
--------------D916D1D8EDD7ACDD4F14C8A6
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi guys,

yeah, agree totally. When we fail to allocate anything during module or 
device initialization we should cleanup properly and abort loading the 
module.

On the other hand the only time I actually run into such a problem was 
while constantly loading and unloading the radeon module to find bugs.

BTW: Was pretty fruitful to do this, we should try this with amdgpu at 
some time as well.

Christian.

Am 12.08.2016 um 18:17 schrieb StDenis, Tom:
>
> Hi Alex,
>
>
> I'm unsure of what patch you have specifically.  Are you suggesting to 
> modify the radeon side to mimic the behaviour?  Or to revert the 
> amdgpu changes?  I  think reverting the amdgpu side won't go over 
> well.  It's churn and the current approach is arguably better for a 
> number of reasons namely it's better defined behaviour and generally 
> speaking if during module init a kmalloc of 100 bytes fails something 
> bad is happening and you want to abort init anyways (so failing to 
> load just because part of DCE fails is probably a good thing).
>
>
> Tom
>
>
>
>
>
> ------------------------------------------------------------------------
> *From:* Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, August 12, 2016 12:11
> *To:* StDenis, Tom; Freedesktop - AMD-gfx
> *Cc:* Alexander Deucher
> *Subject:* Re: radeon VS amdgpu: _afmt_init() behavior if kzalloc fails
> Thanks for the quick answer Tom. I was thinking mostly as you do, but 
> before sending the patch to the list, I wanted to be sure it was worth 
> it.
>
> I'll send the patch later then, unless someone says otherwise.
>
> Cheers,
> Alexandre
>
> On Fri, 12 Aug 2016 at 11:50 StDenis, Tom <Tom.StDenis-5C7GfCeVMHo@public.gmane.org 
> <mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org>> wrote:
>
>     Hi,
>
>
>     I wrote those changes back in March as part of a cleanup sweep. 
>     The idea being was that if some had failed the state of the driver
>     would be unknown so it was cleaner to simply abort allocating any
>     memory and set all of the pointers to NULL.
>
>
>     Generally speaking if you fail to kmalloc a few bytes you've got
>     bigger problems to worry about than your audio not working ideally.
>
>
>     Tom
>
>
>
>     ------------------------------------------------------------------------
>     *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>     <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>> on behalf of
>     Alexandre Demers <alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
>     <mailto:alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>>
>     *Sent:* Friday, August 12, 2016 11:43
>     *To:* Freedesktop - AMD-gfx
>     *Cc:* Alexander Deucher
>     *Subject:* radeon VS amdgpu: _afmt_init() behavior if kzalloc fails
>     Hi,
>
>     While comparing radeon's radeon_afmt_init() to
>     dce_vX_0_afmt_init() on the amdgpu's side, I saw that on the latter:
>     1- when kzalloc fails to allocate mem for all afmt, an ENOMEM is
>     returned
>     2- all previously allocated afmt are freed
>
>     So on the amdgpu's side, it is an "all or none allocated"
>     situation, while on the radeon's side, some afmt may be allocated
>     and initialized.
>
>     Moreover, returning an ENOMEM prevents any other function calls in
>     dce_vX_0_sw_init() on the amdgpu's side, while it continues on the
>     radeon's side.
>
>     What is the expected behavior here? Should we rewind the memory
>     allocation as it is done under amdgpu when we can't allocate
>     memory for all afmt or is it OK to do as it is done on radeon?
>     Should we stop any remaining steps in radeon_modeset_init() if it
>     fails (thus, returning a ENOMEM from radeon_afmt_init())?
>
>     The patch is already ready if needed, I could send it later from
>     home if the amdgpu's behavior is the one that we are looking for.
>
>     Cheers,
>     Alexandre Demers
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------D916D1D8EDD7ACDD4F14C8A6
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi guys,<br>
      <br>
      yeah, agree totally. When we fail to allocate anything during
      module or device initialization we should cleanup properly and
      abort loading the module.<br>
      <br>
      On the other hand the only time I actually run into such a problem
      was while constantly loading and unloading the radeon module to
      find bugs.<br>
      <br>
      BTW: Was pretty fruitful to do this, we should try this with
      amdgpu at some time as well.<br>
      <br>
      Christian.<br>
      <br>
      Am 12.08.2016 um 18:17 schrieb StDenis, Tom:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB11326BF415D31AE5DB0B0A5EF71F0-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>Hi Alex,</p>
        <p><br>
        </p>
        <p>I'm unsure of what patch you have specifically.  Are you
          suggesting to modify the radeon side to mimic the behaviour?
           Or to revert the amdgpu changes?  I  think reverting the
          amdgpu side won't go over well.  It's churn and the current
          approach is arguably better for a number of reasons namely
          it's better defined behaviour and generally speaking if during
          module init a kmalloc of 100 bytes fails something bad is
          happening and you want to abort init anyways (so failing to
          load just because part of DCE fails is probably a good thing).</p>
        <p><br>
        </p>
        <p>Tom</p>
        <p><br>
        </p>
        <p><br>
        </p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <hr tabindex="-1" style="display:inline-block; width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              color="#000000" face="Calibri, sans-serif"><b>From:</b>
              Alexandre Demers <a class="moz-txt-link-rfc2396E" href="mailto:alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Friday, August 12, 2016 12:11<br>
              <b>To:</b> StDenis, Tom; Freedesktop - AMD-gfx<br>
              <b>Cc:</b> Alexander Deucher<br>
              <b>Subject:</b> Re: radeon VS amdgpu: _afmt_init()
              behavior if kzalloc fails</font>
            <div> </div>
          </div>
          <div>
            <div dir="ltr">Thanks for the quick answer Tom. <span
                style="line-height:1.5">I was thinking mostly as you do,
                but before sending the patch to the list, I wanted to be
                sure it was worth it.</span>
              <div><br>
                <div>I'll send the patch later then, unless someone says
                  otherwise.</div>
                <div><br>
                </div>
                <div>Cheers,</div>
                <div>Alexandre</div>
              </div>
            </div>
            <br>
            <div class="gmail_quote">
              <div dir="ltr">On Fri, 12 Aug 2016 at 11:50 StDenis, Tom
                &lt;<a moz-do-not-send="true"
                  href="mailto:Tom.StDenis-5C7GfCeVMHo@public.gmane.org">Tom.StDenis-5C7GfCeVMHo@public.gmane.org</a>&gt;
                wrote:<br>
              </div>
              <blockquote class="gmail_quote" style="margin:0 0 0 .8ex;
                border-left:1px #ccc solid; padding-left:1ex">
                <div dir="ltr">
                  <div style="font-size:12pt; color:#000000;
                    background-color:#ffffff;
                    font-family:Calibri,Arial,Helvetica,sans-serif">
                    <p>Hi,</p>
                    <p><br>
                    </p>
                    <p>I wrote those changes back in March as part of a
                      cleanup sweep.  The idea being was that if some
                      had failed the state of the driver would be
                      unknown so it was cleaner to simply abort
                      allocating any memory and set all of the pointers
                      to NULL.</p>
                    <p><br>
                    </p>
                    <p>Generally speaking if you fail to kmalloc a few
                      bytes you've got bigger problems to worry about
                      than your audio not working ideally.</p>
                    <p><br>
                    </p>
                    <p>Tom</p>
                    <br>
                    <br>
                    <div style="color:rgb(0,0,0)">
                      <hr style="display:inline-block; width:98%">
                      <div dir="ltr"><font style="font-size:11pt"
                          color="#000000" face="Calibri, sans-serif"><b>From:</b>
                          amd-gfx &lt;<a moz-do-not-send="true"
                            href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org"
                            target="_blank">amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>&gt;
                          on behalf of Alexandre Demers &lt;<a
                            moz-do-not-send="true"
                            href="mailto:alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                            target="_blank">alexandre.f.demers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;<br>
                          <b>Sent:</b> Friday, August 12, 2016 11:43<br>
                          <b>To:</b> Freedesktop - AMD-gfx<br>
                          <b>Cc:</b> Alexander Deucher<br>
                          <b>Subject:</b> radeon VS amdgpu: _afmt_init()
                          behavior if kzalloc fails</font>
                        <div> </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div dir="ltr">
                  <div style="font-size:12pt; color:#000000;
                    background-color:#ffffff;
                    font-family:Calibri,Arial,Helvetica,sans-serif">
                    <div style="color:rgb(0,0,0)">
                      <div>
                        <div dir="ltr">Hi,
                          <div><br>
                          </div>
                          <div>While comparing radeon's
                            radeon_afmt_init() to dce_vX_0_afmt_init()
                            on the amdgpu's side, I saw that on the
                            latter:</div>
                          <div>1- when kzalloc fails to allocate mem for
                            all afmt, an ENOMEM is returned</div>
                          <div>2- all previously allocated afmt are
                            freed</div>
                          <div><br>
                          </div>
                          <div>So on the amdgpu's side, it is an "all or
                            none allocated" situation, while on the
                            radeon's side, some afmt may be allocated
                            and initialized.</div>
                          <div><br>
                          </div>
                          <div>Moreover, returning an ENOMEM prevents
                            any other function calls in <span
                              style="font-size:13.3333px;
                              line-height:normal">dce_vX_0_</span><span
                              style="font-size:13.3333px;
                              line-height:normal">sw_init() on the
                              amdgpu's side, while it continues on the
                              radeon's side.</span><br>
                          </div>
                          <div><span style="font-size:13.3333px;
                              line-height:normal"><br>
                            </span></div>
                          <div><span style="font-size:13.3333px;
                              line-height:normal">What is the expected
                              behavior here? Should we rewind the memory
                              allocation as it is done under amdgpu when
                              we can't allocate memory for all afmt or
                              is it OK to do as it is done on radeon?
                              Should we stop any remaining steps in
                              radeon_modeset_init() if it fails (thus,
                              returning a ENOMEM from
                              radeon_afmt_init())?</span></div>
                          <div><span style="font-size:13.3333px;
                              line-height:normal"><br>
                            </span></div>
                          <div><span style="font-size:13.3333px;
                              line-height:normal">The patch is already
                              ready if needed, I could send it later
                              from home if the amdgpu's behavior is the
                              one that we are looking for.</span></div>
                          <div><span style="font-size:13.3333px;
                              line-height:normal"><br>
                            </span></div>
                          <div><span style="font-size:13.3333px;
                              line-height:normal">Cheers,</span></div>
                          <div><span style="font-size:13.3333px;
                              line-height:normal">Alexandre Demers</span></div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </blockquote>
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
    <p><br>
    </p>
  </body>
</html>

--------------D916D1D8EDD7ACDD4F14C8A6--

--===============1367222042==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1367222042==--
