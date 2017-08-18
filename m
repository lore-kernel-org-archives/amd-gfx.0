From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu: fix a bogus warning
Date: Fri, 18 Aug 2017 09:27:04 +0200
Message-ID: <e2c25269-d0c5-0a60-291f-4e7da1576bf5@vodafone.de>
References: <1503002652-19818-1-git-send-email-alexander.deucher@amd.com>
 <DM5PR12MB1257A35DEC0C4086F7D9D16EF2830@DM5PR12MB1257.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0837315165=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1257A35DEC0C4086F7D9D16EF2830-2J9CzHegvk/NHlLGalgXawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Xie, AlexBin" <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>

This is a multi-part message in MIME format.
--===============0837315165==
Content-Type: multipart/alternative;
 boundary="------------B95EB197ACA04B7877419D57"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------B95EB197ACA04B7877419D57
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Am 17.08.2017 um 23:03 schrieb Xie, AlexBin:
>
> Reviewed-by: Alex Xie <AlexBin.Xie-5C7GfCeVMHo@public.gmane.org>
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Thursday, August 17, 2017 4:44 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* Deucher, Alexander
> *Subject:* [PATCH] drm/amdgpu: fix a bogus warning
> Don't validate the default value. Prevents a needless
> warning. Also fix a spelling typo in the warning message.
>
> Signed-off-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 2554ddf..1a459ac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1077,8 +1077,9 @@ static void amdgpu_check_arguments(struct 
> amdgpu_device *adev)
>          }
>
>          /* valid range is between 4 and 9 inclusive */
> -       if (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size < 4) {
> -               dev_warn(adev->dev, "valid rang is between 4 and 9\n");
> +       if (amdgpu_vm_fragment_size != -1 &&
> +           (amdgpu_vm_fragment_size > 9 || amdgpu_vm_fragment_size < 
> 4)) {
> +               dev_warn(adev->dev, "valid range is between 4 and 9\n");
>                  amdgpu_vm_fragment_size = -1;
>          }
>
> -- 
> 2.5.5
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
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------B95EB197ACA04B7877419D57
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Reviewed-by: Christian König
      <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      <br>
      Am 17.08.2017 um 23:03 schrieb Xie, AlexBin:<br>
    </div>
    <blockquote type="cite"
cite="mid:DM5PR12MB1257A35DEC0C4086F7D9D16EF2830-2J9CzHegvk/NHlLGalgXawdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p>Reviewed-by: Alex Xie &lt;<span class="highlight"
            id="0.433518398008889" name="searchHitInReadingPane"><a class="moz-txt-link-abbreviated" href="mailto:AlexBin.Xie-5C7GfCeVMHo@public.gmane.org">AlexBin.Xie-5C7GfCeVMHo@public.gmane.org</a></span>&gt;<br>
        </p>
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
                <b>Sent:</b> Thursday, August 17, 2017 4:44 PM<br>
                <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Cc:</b> Deucher, Alexander<br>
                <b>Subject:</b> [PATCH] drm/amdgpu: fix a bogus warning</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Don't validate the default value. 
                Prevents a needless<br>
                warning. Also fix a spelling typo in the warning
                message.<br>
                <br>
                Signed-off-by: Alex Deucher
                <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
                ---<br>
                 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++--<br>
                 1 file changed, 3 insertions(+), 2 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                index 2554ddf..1a459ac 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                @@ -1077,8 +1077,9 @@ static void
                amdgpu_check_arguments(struct amdgpu_device *adev)<br>
                         }<br>
                 <br>
                         /* valid range is between 4 and 9 inclusive */<br>
                -       if (amdgpu_vm_fragment_size &gt; 9 ||
                amdgpu_vm_fragment_size &lt; 4) {<br>
                -               dev_warn(adev-&gt;dev, "valid rang is
                between 4 and 9\n");<br>
                +       if (amdgpu_vm_fragment_size != -1 &amp;&amp;<br>
                +           (amdgpu_vm_fragment_size &gt; 9 ||
                amdgpu_vm_fragment_size &lt; 4)) {<br>
                +               dev_warn(adev-&gt;dev, "valid range is
                between 4 and 9\n");<br>
                                 amdgpu_vm_fragment_size = -1;<br>
                         }<br>
                 <br>
                -- <br>
                2.5.5<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <a id="LPlnk419353"
                  href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                  previewremoved="true" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
                <div id="LPBorder_GT_15030037728530.5153393889696549"
                  style="width: 100%; text-indent: 0px; overflow: auto;
                  margin-bottom: 20px;">
                  <table
                    id="LPContainer_15030037728430.2494249700643958"
                    role="presentation" style="width: 90%; overflow:
                    auto; padding-top: 20px; padding-bottom: 20px;
                    margin-top: 20px; border-top-color: rgb(200, 200,
                    200); border-bottom-color: rgb(200, 200, 200);
                    border-top-width: 1px; border-bottom-width: 1px;
                    border-top-style: dotted; border-bottom-style:
                    dotted; position: relative; background-color:
                    rgb(255, 255, 255);" cellspacing="0">
                    <tbody>
                      <tr style="border-spacing: 0px;" valign="top">
                        <td id="TextCell_15030037728460.275720586653841"
                          style="padding: 0px; vertical-align: top;
                          display: table-cell; position: relative;"
                          colspan="2">
                          <div
                            id="LPTitle_15030037728460.6198405029115783"
                            style="top: 0px; color: rgb(0, 120, 215);
                            line-height: 21px; font-family:
                            &quot;wf_segoe-ui_light&quot;,&quot;Segoe UI
                            Light&quot;,&quot;Segoe WP
                            Light&quot;,&quot;Segoe UI&quot;,&quot;Segoe
                            WP&quot;,Tahoma,Arial,sans-serif; font-size:
                            21px; font-weight: 400;">
                            <a
                              id="LPUrlAnchor_15030037728490.6208476016845332"
                              style="text-decoration: none;"
                              href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                              target="_blank" moz-do-not-send="true">amd-gfx
                              Info Page - freedesktop.org</a></div>
                          <div
                            id="LPMetadata_15030037728490.9838872304113444"
                            style="margin: 10px 0px 16px; color:
                            rgb(102, 102, 102); line-height: 14px;
                            font-family:
                            &quot;wf_segoe-ui_normal&quot;,&quot;Segoe
                            UI&quot;,&quot;Segoe
                            WP&quot;,Tahoma,Arial,sans-serif; font-size:
                            14px; font-weight: 400;">
                            lists.freedesktop.org</div>
                          <div
                            id="LPDescription_15030037728510.22017633024383798"
                            style="color: rgb(102, 102, 102);
                            line-height: 20px; overflow: hidden;
                            font-family:
                            &quot;wf_segoe-ui_normal&quot;,&quot;Segoe
                            UI&quot;,&quot;Segoe
                            WP&quot;,Tahoma,Arial,sans-serif; font-size:
                            14px; font-weight: 400; display: block;
                            max-height: 100px;">
                            Subscribing to amd-gfx: Subscribe to amd-gfx
                            by filling out the following form. Use of
                            all freedesktop.org lists is subject to our
                            Code of ...</div>
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

--------------B95EB197ACA04B7877419D57--

--===============0837315165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0837315165==--
