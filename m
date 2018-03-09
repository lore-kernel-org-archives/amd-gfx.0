From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module
Date: Fri, 9 Mar 2018 19:29:37 +0100
Message-ID: <afc56834-ab09-ebdf-9292-d4a46915c1ca@gmail.com>
References: <20180308205409.3203-1-alexander.deucher@amd.com>
 <20180308205409.3203-2-alexander.deucher@amd.com>
 <CY4PR12MB1687F2F0D4288F02D750C755FBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
 <b6999bc4-1fae-c293-42f4-2929b08d1821@gmail.com>
 <CADnq5_PK5K5OYG4HVxKa1wCk-MxtJNaxH83HF9F7RzxkaXai_g@mail.gmail.com>
 <CY4PR12MB1687AD7E1DEB313C60E836CFFBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1411126611=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687AD7E1DEB313C60E836CFFBDE0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Koenig, Christian" <Christian.Koenig-5C7GfCeVMHo@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============1411126611==
Content-Type: multipart/alternative;
 boundary="------------10832BEB1699915F84D59FE2"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------10832BEB1699915F84D59FE2
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

That still leaves us with the issue that we need the PSP for the GPU 
reset independent if it is used for firmware loading or not.

Additional to that the PSP is present in the hardware no matter if we 
use it or not. So I think we should always at least add it.

Regards,
Christian.

Am 09.03.2018 um 18:53 schrieb Zhu, Rex:
>
>  >I also don't really like the fact that we use the module parameter 
> directly to determine whether to load the >PSP module or not, we 
> should be using adev->firmware.load_type, but that doesn't get set 
> until later.
>
>
> we can move function amdgpu_ucode_get_load_type to 
> amdgpu_check_arguments(adev);
> adev->firmware.load_type will be set.
>
> >The problem with checking the module parameter is that that param is 
> gobal so if you you have multiple >GPUs, you may get messed up.
>
> if user set the load type through module parameters, it is valid for 
> all gpu.
>
> Best Regards
> Rex
>
>
> ------------------------------------------------------------------------
> *From:* Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Saturday, March 10, 2018 1:02 AM
> *To:* Koenig, Christian
> *Cc:* Zhu, Rex; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org; Deucher, Alexander
> *Subject:* Re: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP 
> module
> On Fri, Mar 9, 2018 at 2:45 AM, Christian König 
> <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org 
> <mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>> wrote:
>
>     Hi Rex,
>
>     I think still initializing the PSP even when you don't need it for
>     firmware upload sounds like a good idea to me.
>
>     But take that with a grain of salt since I really on don't know
>     that part of the hardware so well.
>
>
> Right.  We need PSP for GPU resets among other things.  I also don't 
> really like the fact that we use the module parameter directly to 
> determine whether to load the PSP module or not, we should be using 
> adev->firmware.load_type, but that doesn't get set until later.  We 
> should probably just move that earlier in the common code rather than 
> having it in the soc files.  The problem with checking the module 
> parameter is that that param is gobal so if you you have multiple 
> GPUs, you may get messed up.
>
> Alex
>
>
>     Christian.
>
>
>     Am 09.03.2018 um 06:10 schrieb Zhu, Rex:
>>
>>     Hi Alex,
>>
>>
>>     How about keep the firmware type checking in set_ip_blocks.
>>
>>     and remove the same check code in psp module.
>>
>>     also no need to change load type if psp load firmware failed in
>>     psp module.
>>
>>
>>     Please review the attached patch.
>>
>>
>>     Best Regards
>>
>>     Rex
>>
>>     ------------------------------------------------------------------------
>>     *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>     <mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of Alex
>>     Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> <mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>     *Sent:* Friday, March 9, 2018 4:54 AM
>>     *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
>>     <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>     *Cc:* Deucher, Alexander
>>     *Subject:* [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP
>>     module
>>     We already handle the firmware loading type checks in the
>>     psp module directly, no need for an additional check.
>>
>>     Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>>     <mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>>     ---
>>      drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--
>>      1 file changed, 1 insertion(+), 2 deletions(-)
>>
>>     diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>     b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>     index 8dc8b72ed49b..ecf58a68cf66 100644
>>     --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
>>     +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
>>     @@ -531,8 +531,7 @@ int soc15_set_ip_blocks(struct amdgpu_device
>>     *adev)
>>     amdgpu_device_ip_block_add(adev, &vega10_common_ip_block);
>>     amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
>>     amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
>>     -               if (amdgpu_fw_load_type == 2 ||
>>     amdgpu_fw_load_type == -1)
>>     - amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
>>     + amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
>>                      if (!amdgpu_sriov_vf(adev))
>>     amdgpu_device_ip_block_add(adev, &amdgpu_pp_ip_block);
>>                      if (adev->enable_virtual_display ||
>>     amdgpu_sriov_vf(adev))
>>     -- 
>>     2.13.6
>>
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>     amd-gfx Info Page - freedesktop.org
>>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>     lists.freedesktop.org
>>     Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the
>>     following form. Use of all freedesktop.org lists is subject to
>>     our Code of ...
>>
>>
>>     amd-gfx Info Page - freedesktop.org
>>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>     lists.freedesktop.org <http://lists.freedesktop.org>
>>     Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the
>>     following form. Use of all freedesktop.org
>>     <http://freedesktop.org> lists is subject to our Code of ...
>>     www <http://freedesktop.org/>
>>     freedesktop.org
>>     Welcome to freedesktop.org. freedesktop.org is open source / open
>>     discussion software projects working on interoperability and
>>     shared technology for X Window System ...
>>
>>
>>
>>
>>
>>     _______________________________________________
>>     amd-gfx mailing list
>>     amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
>>     https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>     amd-gfx Info Page - freedesktop.org
>>     <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>
>>     lists.freedesktop.org
>>     Subscribing to amd-gfx: Subscribe to amd-gfx by filling out the
>>     following form. Use of all freedesktop.org lists is subject to
>>     our Code of ...
>>
>>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------10832BEB1699915F84D59FE2
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">That still leaves us with the issue
      that we need the PSP for the GPU reset independent if it is used
      for firmware loading or not.<br>
      <br>
      Additional to that the PSP is present in the hardware no matter if
      we use it or not. So I think we should always at least add it.<br>
      <br>
      Regards,<br>
      Christian.<br>
      <br>
      Am 09.03.2018 um 18:53 schrieb Zhu, Rex:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1687AD7E1DEB313C60E836CFFBDE0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0"><span
            style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;"> &gt;I
            also don't really like the fact that we use the module
            parameter directly to determine whether to load the &gt;PSP
            module or not, we should be using
            adev-&gt;firmware.load_type, but that doesn't get set until
            later.</span><br>
        </p>
        <br>
        we can move function <span>amdgpu_ucode_get_load_type to <span>amdgpu_check_arguments(adev);</span></span>
        <div><span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;">adev-&gt;firmware.load_type
            will be set.</span></div>
        <div><span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;"><br>
          </span></div>
        <div><span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;">&gt;The
            problem with checking the module parameter is that that
            param is gobal so if you you have multiple &gt;GPUs, you may
            get messed up.</span><br style="font-family: Calibri,
            Helvetica, sans-serif, EmojiFont, &quot;Apple Color
            Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji,
            &quot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;,
            EmojiSymbols; font-size: 16px;">
          <br>
        </div>
        <div>if user set the load type through module parameters, it is
          valid for all gpu.</div>
        <div><br>
        </div>
        <div> </div>
        <div>Best Regards</div>
        <div>Rex</div>
        <div><br>
        </div>
        <div><span style="font-family: Calibri, Helvetica, sans-serif,
            EmojiFont, &quot;Apple Color Emoji&quot;, &quot;Segoe UI
            Emoji&quot;, NotoColorEmoji, &quot;Segoe UI Symbol&quot;,
            &quot;Android Emoji&quot;, EmojiSymbols; font-size: 16px;"></span><br>
          <div style="color: rgb(0, 0, 0);">
            <hr style="display:inline-block;width:98%" tabindex="-1">
            <div id="divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" face="Calibri, sans-serif"
                color="#000000"><b>From:</b> Alex Deucher
                <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Saturday, March 10, 2018 1:02 AM<br>
                <b>To:</b> Koenig, Christian<br>
                <b>Cc:</b> Zhu, Rex; <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>;
                Deucher, Alexander<br>
                <b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu/soc15: always
                load the psp IP module</font>
              <div> </div>
            </div>
            <div>
              <div dir="ltr">On Fri, Mar 9, 2018 at 2:45 AM, Christian
                König <span dir="ltr">&lt;<a
                    href="mailto:ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
                    target="_blank" id="LPlnk518351"
                    previewremoved="true" moz-do-not-send="true">ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;</span>
                wrote:<br>
                <div class="x_gmail_extra">
                  <div class="x_gmail_quote">
                    <blockquote class="x_gmail_quote" style="margin:0px
                      0px 0px 0.8ex; border-left:1px solid
                      rgb(204,204,204); padding-left:1ex">
                      <div bgcolor="#FFFFFF">
                        <div
                          class="x_gmail-m_-4726930752337344039moz-cite-prefix">Hi
                          Rex,<br>
                          <br>
                          I think still initializing the PSP even when
                          you don't need it for firmware upload sounds
                          like a good idea to me.<br>
                          <br>
                          But take that with a grain of salt since I
                          really on don't know that part of the hardware
                          so well.<span class="x_gmail-HOEnZb"><font
                              color="#888888"><br>
                            </font></span></div>
                      </div>
                    </blockquote>
                    <div><br>
                    </div>
                    <div>Right.  We need PSP for GPU resets among other
                      things.  I also don't really like the fact that we
                      use the module parameter directly to determine
                      whether to load the PSP module or not, we should
                      be using adev-&gt;firmware.load_type, but that
                      doesn't get set until later.  We should probably
                      just move that earlier in the common code rather
                      than having it in the soc files.  The problem with
                      checking the module parameter is that that param
                      is gobal so if you you have multiple GPUs, you may
                      get messed up.<br>
                      <br>
                    </div>
                    <div>Alex<br>
                    </div>
                    <div><br>
                       </div>
                    <blockquote class="x_gmail_quote" style="margin:0px
                      0px 0px 0.8ex; border-left:1px solid
                      rgb(204,204,204); padding-left:1ex">
                      <div bgcolor="#FFFFFF">
                        <div
                          class="x_gmail-m_-4726930752337344039moz-cite-prefix"><span
                            class="x_gmail-HOEnZb"><font color="#888888"><br>
                              Christian.</font></span>
                          <div>
                            <div class="x_gmail-h5"><br>
                              <br>
                              Am 09.03.2018 um 06:10 schrieb Zhu, Rex:<br>
                            </div>
                          </div>
                        </div>
                        <div>
                          <div class="x_gmail-h5">
                            <blockquote type="cite">
                              <div
                                id="x_gmail-m_-4726930752337344039divtagdefaultwrapper"
                                dir="ltr" style="font-size:12pt;
                                color:rgb(0,0,0);
                                font-family:Calibri,Helvetica,sans-serif">
                                <p style="margin-top:0px;
                                  margin-bottom:0px">Hi Alex,</p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px"><br>
                                </p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px">How about keep the
                                  firmware type checking in
                                  <font size="2"><span
                                      style="font-size:11pt">set_ip_blocks</span></font>.</p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px">and remove the same
                                  check code in psp module.</p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px">also no need to
                                  change load type if psp load firmware
                                  failed in psp module.</p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px"><br>
                                </p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px">Please review the
                                  attached patch.</p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px"><br>
                                </p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px">Best Regards</p>
                                <p style="margin-top:0px;
                                  margin-bottom:0px">Rex<br>
                                </p>
                                <div style="color:rgb(0,0,0)">
                                  <hr style="display:inline-block;
                                    width:98%">
                                  <div
                                    id="x_gmail-m_-4726930752337344039divRplyFwdMsg"
                                    dir="ltr"><font
                                      style="font-size:11pt"
                                      face="Calibri, sans-serif"
                                      color="#000000"><b>From:</b>
                                      amd-gfx
                                      <a
                                        class="x_gmail-m_-4726930752337344039moz-txt-link-rfc2396E"
href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"
                                        id="LPlnk866746"
                                        previewremoved="true"
                                        moz-do-not-send="true">
                                        &lt;amd-gfx-bounces@lists.<wbr>freedesktop.org&gt;</a>
                                      on behalf of Alex Deucher <a
                                        class="x_gmail-m_-4726930752337344039moz-txt-link-rfc2396E"
href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" target="_blank" id="LPlnk978603"
                                        previewremoved="true"
                                        moz-do-not-send="true">
                                        &lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                                      <b>Sent:</b> Friday, March 9, 2018
                                      4:54 AM<br>
                                      <b>To:</b> <a
                                        class="x_gmail-m_-4726930752337344039moz-txt-link-abbreviated"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"
                                        id="LPlnk848814"
                                        previewremoved="true"
                                        moz-do-not-send="true">
                                        amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                      <b>Cc:</b> Deucher, Alexander<br>
                                      <b>Subject:</b> [PATCH 2/2]
                                      drm/amdgpu/soc15: always load the
                                      psp IP module</font>
                                    <div> </div>
                                  </div>
                                  <div
                                    class="x_gmail-m_-4726930752337344039BodyFragment"><font
                                      size="2"><span
                                        style="font-size:11pt">
                                        <div
                                          class="x_gmail-m_-4726930752337344039PlainText">We
                                          already handle the firmware
                                          loading type checks in the<br>
                                          psp module directly, no need
                                          for an additional check.<br>
                                          <br>
                                          Signed-off-by: Alex Deucher <a
class="x_gmail-m_-4726930752337344039moz-txt-link-rfc2396E"
                                            href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org"
                                            target="_blank"
                                            id="LPlnk972109"
                                            previewremoved="true"
                                            moz-do-not-send="true">
&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                                          ---<br>
                                           drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c
                                          | 3 +--<br>
                                           1 file changed, 1
                                          insertion(+), 2 deletions(-)<br>
                                          <br>
                                          diff --git
                                          a/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c
                                          b/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c<br>
                                          index
                                          8dc8b72ed49b..ecf58a68cf66
                                          100644<br>
                                          ---
                                          a/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c<br>
                                          +++
                                          b/drivers/gpu/drm/amd/amdgpu/<wbr>soc15.c<br>
                                          @@ -531,8 +531,7 @@ int
                                          soc15_set_ip_blocks(struct
                                          amdgpu_device *adev)<br>
                                                          
                                          amdgpu_device_ip_block_add(<wbr>adev,
                                          &amp;vega10_common_ip_block);<br>
                                                          
                                          amdgpu_device_ip_block_add(<wbr>adev,
                                          &amp;gmc_v9_0_ip_block);<br>
                                                          
                                          amdgpu_device_ip_block_add(<wbr>adev,
                                          &amp;vega10_ih_ip_block);<br>
                                          -               if
                                          (amdgpu_fw_load_type == 2 ||
                                          amdgpu_fw_load_type == -1)<br>
                                          -                      
                                          amdgpu_device_ip_block_add(<wbr>adev,
                                          &amp;psp_v3_1_ip_block);<br>
                                          +              
                                          amdgpu_device_ip_block_add(<wbr>adev,
                                          &amp;psp_v3_1_ip_block);<br>
                                                           if
                                          (!amdgpu_sriov_vf(adev))<br>
                                                                  
                                          amdgpu_device_ip_block_add(<wbr>adev,
                                          &amp;amdgpu_pp_ip_block);<br>
                                                           if
                                          (adev-&gt;enable_virtual_display
                                          || amdgpu_sriov_vf(adev))<br>
                                          -- <br>
                                          2.13.6<br>
                                          <br>
                                          ______________________________<wbr>_________________<br>
                                          amd-gfx mailing list<br>
                                          <a
                                            class="x_gmail-m_-4726930752337344039moz-txt-link-abbreviated"
href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank"
                                            id="LPlnk972475"
                                            previewremoved="true"
                                            moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                                          <a id="LPlnk828600"
                                            href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                            target="_blank"
                                            previewremoved="true"
                                            moz-do-not-send="true">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
                                          <div
                                            id="LPBorder_GT_15206168590980.853081255131565"
                                            style="margin-bottom: 20px;
                                            overflow: auto; width: 100%;
                                            text-indent: 0px;">
                                            <table
                                              id="LPContainer_15206168590890.9899217792441102"
                                              role="presentation"
                                              style="width: 90%;
                                              background-color: rgb(255,
                                              255, 255); position:
                                              relative; overflow: auto;
                                              padding-top: 20px;
                                              padding-bottom: 20px;
                                              margin-top: 20px;
                                              border-top: 1px dotted
                                              rgb(200, 200, 200);
                                              border-bottom: 1px dotted
                                              rgb(200, 200, 200);"
                                              cellspacing="0">
                                              <tbody>
                                                <tr
                                                  style="border-spacing:
                                                  0px;" valign="top">
                                                  <td
                                                    id="TextCell_15206168590930.19447896014313382"
                                                    colspan="2"
                                                    style="vertical-align:
                                                    top; position:
                                                    relative; padding:
                                                    0px; display:
                                                    table-cell;">
                                                    <div
                                                      id="LPTitle_15206168590930.6676613286273705"
                                                      style="top: 0px;
                                                      color: rgb(0, 120,
                                                      215); font-weight:
                                                      normal; font-size:
                                                      21px; font-family:
                                                      wf_segoe-ui_light,
                                                      &quot;Segoe UI
                                                      Light&quot;,
                                                      &quot;Segoe WP
                                                      Light&quot;,
                                                      &quot;Segoe
                                                      UI&quot;,
                                                      &quot;Segoe
                                                      WP&quot;, Tahoma,
                                                      Arial, sans-serif;
                                                      line-height:
                                                      21px;">
                                                      <a
                                                        id="LPUrlAnchor_15206168590950.5455473805207254"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                                        target="_blank"
style="text-decoration: none;" moz-do-not-send="true">amd-gfx Info Page
                                                        -
                                                        freedesktop.org</a></div>
                                                    <div
                                                      id="LPMetadata_15206168590950.8065594362643194"
                                                      style="margin:
                                                      10px 0px 16px;
                                                      color: rgb(102,
                                                      102, 102);
                                                      font-weight:
                                                      normal;
                                                      font-family:
                                                      wf_segoe-ui_normal,
                                                      &quot;Segoe
                                                      UI&quot;,
                                                      &quot;Segoe
                                                      WP&quot;, Tahoma,
                                                      Arial, sans-serif;
                                                      font-size: 14px;
                                                      line-height:
                                                      14px;">
lists.freedesktop.org</div>
                                                    <div
                                                      id="LPDescription_15206168590970.6098635693868852"
                                                      style="display:
                                                      block; color:
                                                      rgb(102, 102,
                                                      102); font-weight:
                                                      normal;
                                                      font-family:
                                                      wf_segoe-ui_normal,
                                                      &quot;Segoe
                                                      UI&quot;,
                                                      &quot;Segoe
                                                      WP&quot;, Tahoma,
                                                      Arial, sans-serif;
                                                      font-size: 14px;
                                                      line-height: 20px;
                                                      max-height: 100px;
                                                      overflow: hidden;">
                                                      Subscribing to
                                                      amd-gfx: Subscribe
                                                      to amd-gfx by
                                                      filling out the
                                                      following form.
                                                      Use of all
                                                      freedesktop.org
                                                      lists is subject
                                                      to our Code of ...</div>
                                                  </td>
                                                </tr>
                                              </tbody>
                                            </table>
                                          </div>
                                          <br>
                                          <div
id="x_gmail-m_-4726930752337344039LPBorder_GT_15205709349260.10638474698232214"
                                            style="margin-bottom:20px;
                                            overflow:auto; width:100%;
                                            text-indent:0px">
                                            <table
id="x_gmail-m_-4726930752337344039LPContainer_15205709349240.2808290117558123"
                                              style="width:90%;
                                              background-color:rgb(255,255,255);
                                              overflow:auto;
                                              padding-top:20px;
                                              padding-bottom:20px;
                                              margin-top:20px;
                                              border-top:1px dotted
                                              rgb(200,200,200);
                                              border-bottom:1px dotted
                                              rgb(200,200,200)"
                                              cellspacing="0">
                                              <tbody>
                                                <tr
                                                  style="border-spacing:0px"
                                                  valign="top">
                                                  <td colspan="2"
id="x_gmail-m_-4726930752337344039TextCell_15205709349240.5375816182761378"
style="vertical-align:top; padding:0px; display:table-cell">
                                                    <div
id="x_gmail-m_-4726930752337344039LPTitle_15205709349250.744041292827629"><a
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                                        id="LPlnk536103"
                                                        target="_blank"
style="text-decoration:none" previewremoved="true"
                                                        moz-do-not-send="true">amd-gfx
                                                        Info Page -
                                                        freedesktop.org</a></div>
                                                    <div
id="x_gmail-m_-4726930752337344039LPMetadata_15205709349250.4352603789039715"><a
href="http://lists.freedesktop.org" target="_blank" id="LPlnk639008"
                                                        previewremoved="true"
moz-do-not-send="true">lists.freedesktop.org</a></div>
                                                    <div
id="x_gmail-m_-4726930752337344039LPDescription_15205709349260.4456905619796764">Subscribing
                                                      to amd-gfx:
                                                      Subscribe to
                                                      amd-gfx by filling
                                                      out the following
                                                      form. Use of all
                                                      <a
                                                        href="http://freedesktop.org"
                                                        target="_blank"
                                                        id="LPlnk830011"
previewremoved="true" moz-do-not-send="true">
                                                        freedesktop.org</a>
                                                      lists is subject
                                                      to our Code of ...</div>
                                                    <div
                                                      id="LPBorder_GT_15206168899720.8833749745803448"
style="margin-bottom: 20px; overflow: auto; width: 100%; text-indent:
                                                      0px;">
                                                      <table
                                                        id="LPContainer_15206168899640.6943990955761994"
role="presentation" style="width: 90%; background-color: rgb(255, 255,
                                                        255); position:
                                                        relative;
                                                        overflow: auto;
                                                        padding-top:
                                                        20px;
                                                        padding-bottom:
                                                        20px;
                                                        margin-top:
                                                        20px;
                                                        border-top: 1px
                                                        dotted rgb(200,
                                                        200, 200);
                                                        border-bottom:
                                                        1px dotted
                                                        rgb(200, 200,
                                                        200);"
                                                        cellspacing="0">
                                                        <tbody>
                                                          <tr
                                                          style="border-spacing:
                                                          0px;"
                                                          valign="top">
                                                          <td
                                                          id="TextCell_15206168899670.5783242277363418"
                                                          colspan="2"
                                                          style="vertical-align:
                                                          top; position:
                                                          relative;
                                                          padding: 0px;
                                                          display:
                                                          table-cell;">
                                                          <div
                                                          id="LPTitle_15206168899670.763851449544301"
                                                          style="top:
                                                          0px; color:
                                                          rgb(0, 120,
                                                          215);
                                                          font-weight:
                                                          normal;
                                                          font-size:
                                                          21px;
                                                          font-family:
                                                          wf_segoe-ui_light,
                                                          &quot;Segoe UI
                                                          Light&quot;,
                                                          &quot;Segoe WP
                                                          Light&quot;,
                                                          &quot;Segoe
                                                          UI&quot;,
                                                          &quot;Segoe
                                                          WP&quot;,
                                                          Tahoma, Arial,
                                                          sans-serif;
                                                          line-height:
                                                          21px;">
                                                          <a
                                                          id="LPUrlAnchor_15206168899690.45324843322065345"
href="http://freedesktop.org/" target="_blank" style="text-decoration:
                                                          none;"
                                                          moz-do-not-send="true">www</a></div>
                                                          <div
                                                          id="LPMetadata_15206168899690.3043585253425025"
                                                          style="margin:
                                                          10px 0px 16px;
                                                          color:
                                                          rgb(102, 102,
                                                          102);
                                                          font-weight:
                                                          normal;
                                                          font-family:
                                                          wf_segoe-ui_normal,
                                                          &quot;Segoe
                                                          UI&quot;,
                                                          &quot;Segoe
                                                          WP&quot;,
                                                          Tahoma, Arial,
                                                          sans-serif;
                                                          font-size:
                                                          14px;
                                                          line-height:
                                                          14px;">
freedesktop.org</div>
                                                          <div
                                                          id="LPDescription_15206168899710.8181653055355163"
style="display: block; color: rgb(102, 102, 102); font-weight: normal;
                                                          font-family:
                                                          wf_segoe-ui_normal,
                                                          &quot;Segoe
                                                          UI&quot;,
                                                          &quot;Segoe
                                                          WP&quot;,
                                                          Tahoma, Arial,
                                                          sans-serif;
                                                          font-size:
                                                          14px;
                                                          line-height:
                                                          20px;
                                                          max-height:
                                                          100px;
                                                          overflow:
                                                          hidden;">
                                                          Welcome to
                                                          freedesktop.org.
freedesktop.org is open source / open discussion software projects
                                                          working on
                                                          interoperability
                                                          and shared
                                                          technology for
                                                          X Window
                                                          System ...</div>
                                                          </td>
                                                          </tr>
                                                        </tbody>
                                                      </table>
                                                    </div>
                                                    <br>
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
                              <fieldset
                                class="x_gmail-m_-4726930752337344039mimeAttachmentHeader"></fieldset>
                              <br>
                              <pre>______________________________<wbr>_________________
amd-gfx mailing list
<a class="x_gmail-m_-4726930752337344039moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" target="_blank" id="LPlnk362977" previewremoved="true" moz-do-not-send="true">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="x_gmail-m_-4726930752337344039moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" target="_blank" id="LPlnk454668" previewremoved="true" moz-do-not-send="true">https://lists.freedesktop.org/<wbr>mailman/listinfo/amd-gfx</a>
</pre>
                              <div
                                id="LPBorder_GT_15206169213320.2568680993662593"
                                style="margin-bottom: 20px; overflow:
                                auto; width: 100%; text-indent: 0px;">
                                <table
                                  id="LPContainer_15206169213230.11439653090999924"
                                  role="presentation" style="width: 90%;
                                  background-color: rgb(255, 255, 255);
                                  position: relative; overflow: auto;
                                  padding-top: 20px; padding-bottom:
                                  20px; margin-top: 20px; border-top:
                                  1px dotted rgb(200, 200, 200);
                                  border-bottom: 1px dotted rgb(200,
                                  200, 200);" cellspacing="0">
                                  <tbody>
                                    <tr style="border-spacing: 0px;"
                                      valign="top">
                                      <td
                                        id="TextCell_15206169213260.72102435629418"
                                        colspan="2"
                                        style="vertical-align: top;
                                        position: relative; padding:
                                        0px; display: table-cell;">
                                        <div
                                          id="LPTitle_15206169213270.5090766411535075"
                                          style="top: 0px; color: rgb(0,
                                          120, 215); font-weight:
                                          normal; font-size: 21px;
                                          font-family:
                                          wf_segoe-ui_light, &quot;Segoe
                                          UI Light&quot;, &quot;Segoe WP
                                          Light&quot;, &quot;Segoe
                                          UI&quot;, &quot;Segoe
                                          WP&quot;, Tahoma, Arial,
                                          sans-serif; line-height:
                                          21px;">
                                          <a
                                            id="LPUrlAnchor_15206169213280.020882264522205762"
href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                            target="_blank"
                                            style="text-decoration:
                                            none;"
                                            moz-do-not-send="true">amd-gfx
                                            Info Page - freedesktop.org</a></div>
                                        <div
                                          id="LPMetadata_15206169213290.6035465984423496"
                                          style="margin: 10px 0px 16px;
                                          color: rgb(102, 102, 102);
                                          font-weight: normal;
                                          font-family:
                                          wf_segoe-ui_normal,
                                          &quot;Segoe UI&quot;,
                                          &quot;Segoe WP&quot;, Tahoma,
                                          Arial, sans-serif; font-size:
                                          14px; line-height: 14px;">
                                          lists.freedesktop.org</div>
                                        <div
                                          id="LPDescription_15206169213300.07041936860112408"
                                          style="display: block; color:
                                          rgb(102, 102, 102);
                                          font-weight: normal;
                                          font-family:
                                          wf_segoe-ui_normal,
                                          &quot;Segoe UI&quot;,
                                          &quot;Segoe WP&quot;, Tahoma,
                                          Arial, sans-serif; font-size:
                                          14px; line-height: 20px;
                                          max-height: 100px; overflow:
                                          hidden;">
                                          Subscribing to amd-gfx:
                                          Subscribe to amd-gfx by
                                          filling out the following
                                          form. Use of all
                                          freedesktop.org lists is
                                          subject to our Code of ...</div>
                                      </td>
                                    </tr>
                                  </tbody>
                                </table>
                              </div>
                              <br>
                            </blockquote>
                            <br>
                          </div>
                        </div>
                      </div>
                    </blockquote>
                  </div>
                  <br>
                </div>
              </div>
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

--------------10832BEB1699915F84D59FE2--

--===============1411126611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1411126611==--
