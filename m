From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module
Date: Fri, 9 Mar 2018 08:45:55 +0100
Message-ID: <b6999bc4-1fae-c293-42f4-2929b08d1821@gmail.com>
References: <20180308205409.3203-1-alexander.deucher@amd.com>
 <20180308205409.3203-2-alexander.deucher@amd.com>
 <CY4PR12MB1687F2F0D4288F02D750C755FBDE0@CY4PR12MB1687.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1105941083=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <CY4PR12MB1687F2F0D4288F02D750C755FBDE0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Zhu, Rex" <Rex.Zhu-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============1105941083==
Content-Type: multipart/alternative;
 boundary="------------847A898A204D0B1527AB86D7"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------847A898A204D0B1527AB86D7
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rex,

I think still initializing the PSP even when you don't need it for 
firmware upload sounds like a good idea to me.

But take that with a grain of salt since I really on don't know that 
part of the hardware so well.

Christian.

Am 09.03.2018 um 06:10 schrieb Zhu, Rex:
>
> Hi Alex,
>
>
> How about keep the firmware type checking in set_ip_blocks.
>
> and remove the same check code in psp module.
>
> also no need to change load type if psp load firmware failed in psp 
> module.
>
>
> Please review the attached patch.
>
>
> Best Regards
>
> Rex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, March 9, 2018 4:54 AM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Deucher, Alexander
> *Subject:* [PATCH 2/2] drm/amdgpu/soc15: always load the psp IP module
> We already handle the firmware loading type checks in the
> psp module directly, no need for an additional check.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c 
> b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 8dc8b72ed49b..ecf58a68cf66 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -531,8 +531,7 @@ int soc15_set_ip_blocks(struct amdgpu_device *adev)
>                  amdgpu_device_ip_block_add(adev, 
> &vega10_common_ip_block);
>                  amdgpu_device_ip_block_add(adev, &gmc_v9_0_ip_block);
>                  amdgpu_device_ip_block_add(adev, &vega10_ih_ip_block);
> -               if (amdgpu_fw_load_type == 2 || amdgpu_fw_load_type == -1)
> - amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
> +               amdgpu_device_ip_block_add(adev, &psp_v3_1_ip_block);
>                  if (!amdgpu_sriov_vf(adev))
> amdgpu_device_ip_block_add(adev, &amdgpu_pp_ip_block);
>                  if (adev->enable_virtual_display || 
> amdgpu_sriov_vf(adev))
> -- 
> 2.13.6
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
> Code of ...
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------847A898A204D0B1527AB86D7
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Hi Rex,<br>
      <br>
      I think still initializing the PSP even when you don't need it for
      firmware upload sounds like a good idea to me.<br>
      <br>
      But take that with a grain of salt since I really on don't know
      that part of the hardware so well.<br>
      <br>
      Christian.<br>
      <br>
      Am 09.03.2018 um 06:10 schrieb Zhu, Rex:<br>
    </div>
    <blockquote type="cite"
cite="mid:CY4PR12MB1687F2F0D4288F02D750C755FBDE0-rpdhrqHFk06Y0SjTqZDccQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Hi Alex,</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">How about keep the
          firmware type checking in
          <font size="2"><span style="font-size:11pt;">set_ip_blocks</span></font>.</p>
        <p style="margin-top:0;margin-bottom:0">and remove the same
          check code in psp module.</p>
        <p style="margin-top:0;margin-bottom:0">also no need to change
          load type if psp load firmware failed in psp module.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Please review the
          attached patch.</p>
        <p style="margin-top:0;margin-bottom:0"><br>
        </p>
        <p style="margin-top:0;margin-bottom:0">Best Regards</p>
        <p style="margin-top:0;margin-bottom:0">Rex<br>
        </p>
        <div style="color: rgb(0, 0, 0);">
          <hr tabindex="-1" style="display:inline-block;width:98%">
          <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
              face="Calibri, sans-serif" color="#000000"><b>From:</b>
              amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
              behalf of Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
              <b>Sent:</b> Friday, March 9, 2018 4:54 AM<br>
              <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <b>Cc:</b> Deucher, Alexander<br>
              <b>Subject:</b> [PATCH 2/2] drm/amdgpu/soc15: always load
              the psp IP module</font>
            <div> </div>
          </div>
          <div class="BodyFragment"><font size="2"><span
                style="font-size:11pt;">
                <div class="PlainText">We already handle the firmware
                  loading type checks in the<br>
                  psp module directly, no need for an additional check.<br>
                  <br>
                  Signed-off-by: Alex Deucher
                  <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                  ---<br>
                   drivers/gpu/drm/amd/amdgpu/soc15.c | 3 +--<br>
                   1 file changed, 1 insertion(+), 2 deletions(-)<br>
                  <br>
                  diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c
                  b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
                  index 8dc8b72ed49b..ecf58a68cf66 100644<br>
                  --- a/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
                  +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c<br>
                  @@ -531,8 +531,7 @@ int soc15_set_ip_blocks(struct
                  amdgpu_device *adev)<br>
                                   amdgpu_device_ip_block_add(adev,
                  &amp;vega10_common_ip_block);<br>
                                   amdgpu_device_ip_block_add(adev,
                  &amp;gmc_v9_0_ip_block);<br>
                                   amdgpu_device_ip_block_add(adev,
                  &amp;vega10_ih_ip_block);<br>
                  -               if (amdgpu_fw_load_type == 2 ||
                  amdgpu_fw_load_type == -1)<br>
                  -                      
                  amdgpu_device_ip_block_add(adev,
                  &amp;psp_v3_1_ip_block);<br>
                  +               amdgpu_device_ip_block_add(adev,
                  &amp;psp_v3_1_ip_block);<br>
                                   if (!amdgpu_sriov_vf(adev))<br>
                                          
                  amdgpu_device_ip_block_add(adev,
                  &amp;amdgpu_pp_ip_block);<br>
                                   if (adev-&gt;enable_virtual_display
                  || amdgpu_sriov_vf(adev))<br>
                  -- <br>
                  2.13.6<br>
                  <br>
                  _______________________________________________<br>
                  amd-gfx mailing list<br>
                  <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                  <a previewremoved="true" id="LPlnk123469"
                    href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                    moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                  <div style="margin-bottom: 20px; overflow: auto;
                    width: 100%; text-indent: 0px;"
                    id="LPBorder_GT_15205709349260.10638474698232214">
                    <table role="presentation" style="width: 90%;
                      background-color: rgb(255, 255, 255); position:
                      relative; overflow: auto; padding-top: 20px;
                      padding-bottom: 20px; margin-top: 20px;
                      border-top: 1px dotted rgb(200, 200, 200);
                      border-bottom: 1px dotted rgb(200, 200, 200);"
                      id="LPContainer_15205709349240.2808290117558123"
                      cellspacing="0">
                      <tbody>
                        <tr style="border-spacing: 0px;" valign="top">
                          <td colspan="2" style="vertical-align: top;
                            position: relative; padding: 0px; display:
                            table-cell;"
                            id="TextCell_15205709349240.5375816182761378">
                            <div style="top: 0px; color: rgb(0, 120,
                              215); font-weight: 400; font-size: 21px;
                              font-family:
                              &quot;wf_segoe-ui_light&quot;,&quot;Segoe
                              UI Light&quot;,&quot;Segoe WP
                              Light&quot;,&quot;Segoe
                              UI&quot;,&quot;Segoe
                              WP&quot;,Tahoma,Arial,sans-serif;
                              line-height: 21px;"
                              id="LPTitle_15205709349250.744041292827629">
                              <a target="_blank"
                                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                                style="text-decoration: none;"
                                id="LPUrlAnchor_15205709349250.5260705269625694"
                                moz-do-not-send="true">amd-gfx Info Page
                                - freedesktop.org</a></div>
                            <div style="margin: 10px 0px 16px; color:
                              rgb(102, 102, 102); font-weight: 400;
                              font-family:
                              &quot;wf_segoe-ui_normal&quot;,&quot;Segoe
                              UI&quot;,&quot;Segoe
                              WP&quot;,Tahoma,Arial,sans-serif;
                              font-size: 14px; line-height: 14px;"
                              id="LPMetadata_15205709349250.4352603789039715">
                              lists.freedesktop.org</div>
                            <div style="display: block; color: rgb(102,
                              102, 102); font-weight: 400; font-family:
                              &quot;wf_segoe-ui_normal&quot;,&quot;Segoe
                              UI&quot;,&quot;Segoe
                              WP&quot;,Tahoma,Arial,sans-serif;
                              font-size: 14px; line-height: 20px;
                              max-height: 100px; overflow: hidden;"
                              id="LPDescription_15205709349260.4456905619796764">
                              Subscribing to amd-gfx: Subscribe to
                              amd-gfx by filling out the following form.
                              Use of all freedesktop.org lists is
                              subject to our Code of ...</div>
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

--------------847A898A204D0B1527AB86D7--

--===============1105941083==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============1105941083==--
