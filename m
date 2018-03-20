From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display support
Date: Tue, 20 Mar 2018 21:16:40 +0100
Message-ID: <7bbc4bc8-1b44-efc3-44b7-47ebcb4b9c76@amd.com>
References: <1520033110-29964-1-git-send-email-Samuel.Li@amd.com>
 <BN6PR12MB18099E7295CB0301EF536924F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BY1PR12MB05042F8034B375BAB507EB03F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <BN6PR12MB180952A68A8AF256197D1177F7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <BN6PR12MB1809A2A1591C19CC6E0C952FF7D40@BN6PR12MB1809.namprd12.prod.outlook.com>
 <CAAxE2A4V0=1w_aybBq0dXc3w+D=eJR-dY7Tq=7g3rnj94OY7XQ@mail.gmail.com>
 <BY1PR12MB050483D06AA7D7B08247B1D0F5D40@BY1PR12MB0504.namprd12.prod.outlook.com>
 <CADnq5_O0p30CC0JAnqvrrspXapdN5ZpXGBChGmt+14ekmPHkQw@mail.gmail.com>
 <CAAxE2A4fiM5KjfxOSTTT3Soew8S-EGE7OVWBh-7565+rahMaOg@mail.gmail.com>
 <13996c5e-dc4c-5a9a-b6c3-7fe6bb63ec5d@gmail.com>
 <CAAxE2A7ffe2fkOQG0mFpPfP4uRKZ1BVTKWQ3Q+FhLWQnYU4nww@mail.gmail.com>
 <f7bce36e-d9c6-dc13-6b1f-0e2bf91aaff0@gmail.com>
 <DM5PR12MB18205326885F0857CEC4FAA6F7AB0@DM5PR12MB1820.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1774027606=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB18205326885F0857CEC4FAA6F7AB0-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel-otUistvHUpPR7s880joybQ@public.gmane.org>, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Li, Samuel" <Samuel.Li-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1774027606==
Content-Type: multipart/alternative;
 boundary="------------92A51A8B08371CE6ABD1EC44"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------92A51A8B08371CE6ABD1EC44
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

That's what I meant with use up the otherwise unused VRAM. I don't see 
any disadvantage of always setting GTT as second domain on APUs.

My assumption was that we dropped this in userspace for displayable 
surfaces, but Marek proved that wrong.

So what we should do is actually to add GTT as fallback to all BOs on 
APUs in Mesa and only make sure that the kernel is capable of handling 
GTT with optimal performance (e.g. have user huge pages etc..).

Christian.

Am 20.03.2018 um 21:04 schrieb Deucher, Alexander:
>
> I think we can also have the case of systems with similar amounts of 
> carve out and system ram.  E.g., on a system with 4 GB of system 
> memory with 1 GB carved out for vram.  It would be a big waste not to 
> use VRAM.  We'll probably need a heuristic at some point.
>
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Tuesday, March 20, 2018 2:32:49 PM
> *To:* Marek Olšák; Koenig, Christian
> *Cc:* Alex Deucher; Deucher, Alexander; Michel Dänzer; Li, Samuel; 
> amd-gfx list
> *Subject:* Re: [PATCH 1/2] drm/amdgpu: Enable scatter gather display 
> support
> I don't think that is a good idea.
>
> Ideally GTT should now have the same performance as VRAM on APUs and 
> we should use VRAM only for things where we absolutely have to and to 
> actually use up the otherwise unused VRAM.
>
> Can you run some tests with all BOs forced to GTT and see if there is 
> any performance regression?
>
> Christian.
>
> Am 20.03.2018 um 15:51 schrieb Marek Olšák:
>> On Tue, Mar 20, 2018 at 9:55 AM, Christian König 
>> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
>> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>
>>     Yes, exactly. And if I remember correctly Mesa used to always set
>>     GTT as fallback on APUs, correct?
>>
>>
>> "used to" is the key part. Mesa doesn't force GTT on APUs anymore. It 
>> expects that the combination of BO priorities and BO move throttling 
>> will result in optimal BO placements over time.
>>
>> Marek
>>
>>
>>     The problem seems to be that this fallback isn't set for
>>     displayable BOs.
>>
>>     So what needs to be done is to just enable this fallback for
>>     displayable BOs as well if the kernel can handle it.
>>
>>     Christian.
>>
>>
>>     Am 20.03.2018 um 00:01 schrieb Marek Olšák:
>>>     In theory, Mesa doesn't have to do anything. It can continue
>>>     setting VRAM and if the kernel has to put a display buffer into
>>>     GTT, it doesn't matter (for Mesa). Whether the VRAM placement is
>>>     really used is largely determined by BO priorities.
>>>
>>>     The way I understand scather/gather is that it only allows the
>>>     GTT placement. It doesn't force the GTT placement. Mesa also
>>>     doesn't force the GTT placement.
>>>
>>>     Marek
>>>
>>>     On Mon, Mar 19, 2018 at 5:12 PM, Alex Deucher
>>>     <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>>>
>>>         On Mon, Mar 19, 2018 at 4:29 PM, Li, Samuel
>>>         <Samuel.Li-5C7GfCeVMHo@public.gmane.org <mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org>> wrote:
>>>         >>to my earlier point, there may be cases where it is
>>>         advantageous to put
>>>         >> display buffers in vram even if s/g display is supported
>>>         >
>>>         > Agreed. That is also why the patch has the options to let
>>>         user select where
>>>         > to put display buffers.
>>>         >
>>>         > As whether to put the option in Mesa or kernel, it seems
>>>         the difference is
>>>         > not much. Also, since amdgpufb can request even without
>>>         mesa, kernel might
>>>         > be a better choice. In addition, putting in the kernel can
>>>         save client’s
>>>         > duplicate work(mesa, ogl, vulkan, 2d, kernel…)
>>>
>>>         Why do we even expose different memory pools to the UMDs in
>>>         the first
>>>         place ;)  Each pool has performance characteristics that may be
>>>         relevant for a particular work load. Only the UMDs really
>>>         know the
>>>         finer points of those workloads. In general, you don't want
>>>         the kernel
>>>         dictating policy if you can avoid it. The kernel exposes
>>>         functionality and userspace sets the policy.  With the
>>>         location set in
>>>         userspace, each app/user can have whatever policy makes
>>>         sense for
>>>         their use case all at the same time without needing to tweak
>>>         their
>>>         kernel for every use case.
>>>
>>>         Alex
>>>
>>>
>>>
>>>     _______________________________________________
>>>     amd-gfx mailing list
>>>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>
>>
>>
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>


--------------92A51A8B08371CE6ABD1EC44
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That's what I meant with use up the
      otherwise unused VRAM. I don't see any disadvantage of always
      setting GTT as second domain on APUs.<br>
      <br>
      My assumption was that we dropped this in userspace for
      displayable surfaces, but Marek proved that wrong.<br>
      <br>
      So what we should do is actually to add GTT as fallback to all BOs
      on APUs in Mesa and only make sure that the kernel is capable of
      handling GTT with optimal performance (e.g. have user huge pages
      etc..).<br>
      <br>
      Christian.<br>
      <br>
      Am 20.03.2018 um 21:04 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB18205326885F0857CEC4FAA6F7AB0-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">I think we can also have
          the case of systems with similar amounts of carve out and
          system ram.  E.g., on a system with 4 GB of system memory with
          1 GB carved out for vram.  It would be a big waste not to use
          VRAM.  We'll probably need a heuristic at some point.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Alex<br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Tuesday, March 20, 2018 2:32:49 PM<br>
          <b>To:</b> Marek Olšák; Koenig, Christian<br>
          <b>Cc:</b> Alex Deucher; Deucher, Alexander; Michel Dänzer;
          Li, Samuel; amd-gfx list<br>
          <b>Subject:</b> Re: [PATCH 1/2] drm/amdgpu: Enable scatter
          gather display support</font>
        <div> </div>
      </div>
      <div style="background-color:#FFFFFF">
        <div class="x_moz-cite-prefix">I don't think that is a good
          idea.<br>
          <br>
          Ideally GTT should now have the same performance as VRAM on
          APUs and we should use VRAM only for things where we
          absolutely have to and to actually use up the otherwise unused
          VRAM.<br>
          <br>
          Can you run some tests with all BOs forced to GTT and see if
          there is any performance regression?<br>
          <br>
          Christian.<br>
          <br>
          Am 20.03.2018 um 15:51 schrieb Marek Olšák:<br>
        </div>
        <blockquote type="cite">
          <div dir="ltr">
            <div class="x_gmail_extra">
              <div class="x_gmail_quote">On Tue, Mar 20, 2018 at 9:55
                AM, Christian König <span dir="ltr">
                  &lt;<a href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                    target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.<wbr>com</a>&gt;</span>
                wrote:<br>
                <blockquote class="x_gmail_quote" style="margin:0 0 0
                  .8ex; border-left:1px #ccc solid; padding-left:1ex">
                  <div bgcolor="#FFFFFF">
                    <div
                      class="x_m_-3838486020630618689m_8572536124089128592moz-cite-prefix">Yes,
                      exactly. And if I remember correctly Mesa used to
                      always set GTT as fallback on APUs, correct?<br>
                    </div>
                  </div>
                </blockquote>
                <div><br>
                </div>
                <div>"used to" is the key part. Mesa doesn't force GTT
                  on APUs anymore. It expects that the combination of BO
                  priorities and BO move throttling will result in
                  optimal BO placements over time.<br>
                  <br>
                </div>
                <div>Marek<br>
                </div>
                <div> </div>
                <blockquote class="x_gmail_quote" style="margin:0 0 0
                  .8ex; border-left:1px #ccc solid; padding-left:1ex">
                  <div bgcolor="#FFFFFF">
                    <div
                      class="x_m_-3838486020630618689m_8572536124089128592moz-cite-prefix"><br>
                      The problem seems to be that this fallback isn't
                      set for displayable BOs.<br>
                      <br>
                      So what needs to be done is to just enable this
                      fallback for displayable BOs as well if the kernel
                      can handle it.<span
                        class="x_m_-3838486020630618689HOEnZb"><font
                          color="#888888"><br>
                          <br>
                          Christian.</font></span>
                      <div>
                        <div class="x_m_-3838486020630618689h5"><br>
                          <br>
                          Am 20.03.2018 um 00:01 schrieb Marek Olšák:<br>
                        </div>
                      </div>
                    </div>
                    <blockquote type="cite">
                      <div>
                        <div class="x_m_-3838486020630618689h5">
                          <div dir="ltr">
                            <div class="x_gmail_extra">
                              <div class="x_gmail_quote">In theory, Mesa
                                doesn't have to do anything. It can
                                continue setting VRAM and if the kernel
                                has to put a display buffer into GTT, it
                                doesn't matter (for Mesa). Whether the
                                VRAM placement is really used is largely
                                determined by BO priorities.<br>
                              </div>
                              <div class="x_gmail_quote"><br>
                              </div>
                              <div class="x_gmail_quote">The way I
                                understand scather/gather is that it
                                only allows the GTT placement. It
                                doesn't force the GTT placement. Mesa
                                also doesn't force the GTT placement.<br>
                              </div>
                              <div class="x_gmail_quote"><br>
                              </div>
                              <div class="x_gmail_quote">Marek<br>
                              </div>
                              <div class="x_gmail_quote"><br>
                              </div>
                              <div class="x_gmail_quote">On Mon, Mar 19,
                                2018 at 5:12 PM, Alex Deucher <span
                                  dir="ltr">
                                  &lt;<a
                                    href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                                    target="_blank"
                                    moz-do-not-send="true">alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
                                wrote:<br>
                                <blockquote class="x_gmail_quote"
                                  style="margin:0 0 0 .8ex;
                                  border-left:1px #ccc solid;
                                  padding-left:1ex">
                                  <span>On Mon, Mar 19, 2018 at 4:29 PM,
                                    Li, Samuel &lt;<a
                                      href="mailto:Samuel.Li-5C7GfCeVMHo@public.gmane.org"
                                      target="_blank"
                                      moz-do-not-send="true">Samuel.Li-5C7GfCeVMHo@public.gmane.org</a>&gt;
                                    wrote:<br>
                                    &gt;&gt;to my earlier point, there
                                    may be cases where it is
                                    advantageous to put<br>
                                    &gt;&gt; display buffers in vram
                                    even if s/g display is supported<br>
                                    &gt;<br>
                                    &gt; Agreed. That is also why the
                                    patch has the options to let user
                                    select where<br>
                                    &gt; to put display buffers.<br>
                                    &gt;<br>
                                    &gt; As whether to put the option in
                                    Mesa or kernel, it seems the
                                    difference is<br>
                                    &gt; not much. Also, since amdgpufb
                                    can request even without mesa,
                                    kernel might<br>
                                    &gt; be a better choice. In
                                    addition, putting in the kernel can
                                    save client’s<br>
                                    &gt; duplicate work(mesa, ogl,
                                    vulkan, 2d, kernel…)<br>
                                    <br>
                                  </span>Why do we even expose different
                                  memory pools to the UMDs in the first<br>
                                  place ;)  Each pool has performance
                                  characteristics that may be<br>
                                  relevant for a particular work load. 
                                  Only the UMDs really know the<br>
                                  finer points of those workloads. In
                                  general, you don't want the kernel<br>
                                  dictating policy if you can avoid it. 
                                  The kernel exposes<br>
                                  functionality and userspace sets the
                                  policy.  With the location set in<br>
                                  userspace, each app/user can have
                                  whatever policy makes sense for<br>
                                  their use case all at the same time
                                  without needing to tweak their<br>
                                  kernel for every use case.<br>
                                  <span
class="x_m_-3838486020630618689m_8572536124089128592m_4947926278827078055HOEnZb"><font
                                      color="#888888"><br>
                                      Alex</font></span><br>
                                </blockquote>
                              </div>
                            </div>
                          </div>
                          <br>
                          <fieldset
class="x_m_-3838486020630618689m_8572536124089128592mimeAttachmentHeader"></fieldset>
                          <br>
                        </div>
                      </div>
                      <span>
                        <pre>______________________________<wbr>_________________
amd-gfx mailing list
<a class="x_m_-3838486020630618689m_8572536124089128592moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="x_m_-3838486020630618689m_8572536124089128592moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank" moz-do-not-send="true">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
                      </span></blockquote>
                    <br>
                  </div>
                </blockquote>
              </div>
              <br>
            </div>
          </div>
          <br>
          <fieldset class="x_mimeAttachmentHeader"></fieldset>
          <br>
          <pre>_______________________________________________
amd-gfx mailing list
<a class="x_moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="x_moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
        </blockquote>
        <br>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------92A51A8B08371CE6ABD1EC44--

--===============1774027606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1774027606==--
