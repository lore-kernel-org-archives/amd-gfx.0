From: Bhawanpreet Lakha <Bhawanpreet.lakha-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH] drm/amd/display: Load TA firmware for navi10/12/14
Date: Thu, 28 Nov 2019 15:20:07 -0500
Message-ID: <e883aa84-0a91-d562-3501-927cba50f61d@amd.com>
References: <20191108215721.13316-1-Bhawanpreet.Lakha@amd.com>
 <DM5PR12MB1820C10A42B4FFC83A093710F77B0@DM5PR12MB1820.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2016313954=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1820C10A42B4FFC83A093710F77B0-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "Wentland, Harry" <Harry.Wentland-5C7GfCeVMHo@public.gmane.org>

--===============2016313954==
Content-Type: multipart/alternative;
 boundary="------------EFBA3E412223238D312E71DD"
Content-Language: en-US

--------------EFBA3E412223238D312E71DD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Harry can you please take a look thanks

On 2019-11-08 5:01 p.m., Deucher, Alexander wrote:
> Acked-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Friday, November 8, 2019 4:57 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
> *Cc:* Lakha, Bhawanpreet <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
> *Subject:* [PATCH] drm/amd/display: Load TA firmware for navi10/12/14
> load the ta firmware for navi10/12/14.
> This is already being done for raven/picasso and
> is needed for supporting hdcp on navi
>
> Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c 
> b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> index ffeaa2f5588d..daf11be5416f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
> @@ -186,6 +186,31 @@ static int psp_v11_0_init_microcode(struct 
> psp_context *psp)
>          case CHIP_NAVI10:
>          case CHIP_NAVI14:
>          case CHIP_NAVI12:
> +               snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ta.bin", 
> chip_name);
> +               err = request_firmware(&adev->psp.ta_fw, fw_name, 
> adev->dev);
> +               if (err) {
> + release_firmware(adev->psp.ta_fw);
> +                       adev->psp.ta_fw = NULL;
> +                       dev_info(adev->dev,
> +                                "psp v11.0: Failed to load firmware 
> \"%s\"\n", fw_name);
> +               } else {
> +                       err = amdgpu_ucode_validate(adev->psp.ta_fw);
> +                       if (err)
> +                               goto out2;
> +
> +                       ta_hdr = (const struct ta_firmware_header_v1_0 
> *)adev->psp.ta_fw->data;
> +                       adev->psp.ta_hdcp_ucode_version = 
> le32_to_cpu(ta_hdr->ta_hdcp_ucode_version);
> +                       adev->psp.ta_hdcp_ucode_size = 
> le32_to_cpu(ta_hdr->ta_hdcp_size_bytes);
> +                       adev->psp.ta_hdcp_start_addr = (uint8_t *)ta_hdr +
> + le32_to_cpu(ta_hdr->header.ucode_array_offset_bytes);
> +
> +                       adev->psp.ta_fw_version = 
> le32_to_cpu(ta_hdr->header.ucode_version);
> +
> +                       adev->psp.ta_dtm_ucode_version = 
> le32_to_cpu(ta_hdr->ta_dtm_ucode_version);
> +                       adev->psp.ta_dtm_ucode_size = 
> le32_to_cpu(ta_hdr->ta_dtm_size_bytes);
> +                       adev->psp.ta_dtm_start_addr = (uint8_t 
> *)adev->psp.ta_hdcp_start_addr +
> + le32_to_cpu(ta_hdr->ta_dtm_offset_bytes);
> +               }
>                  break;
>          default:
>                  BUG();
> -- 
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--------------EFBA3E412223238D312E71DD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hey Harry can you please take a look
      thanks<br>
    </div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 2019-11-08 5:01 p.m., Deucher,
      Alexander wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:DM5PR12MB1820C10A42B4FFC83A093710F77B0-2J9CzHegvk8qWyLXlBb1HgdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      
      <style type="text/css" style="display:none;"> P {margin-top:0;margin-bottom:0;} </style>
      <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
        font-size: 12pt; color: rgb(0, 0, 0);">
        Acked-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt" face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Bhawanpreet Lakha <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org">&lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Friday, November 8, 2019 4:57 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
          <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a><br>
          <b>Cc:</b> Lakha, Bhawanpreet
          <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org">&lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Subject:</b> [PATCH] drm/amd/display: Load TA firmware for
          navi10/12/14</font>
        <div>&nbsp;</div>
      </div>
      <div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
            <div class="PlainText">load the ta firmware for
              navi10/12/14.<br>
              This is already being done for raven/picasso and<br>
              is needed for supporting hdcp on navi<br>
              <br>
              Signed-off-by: Bhawanpreet Lakha
              <a class="moz-txt-link-rfc2396E" href="mailto:Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org">&lt;Bhawanpreet.Lakha-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
              &nbsp;drivers/gpu/drm/amd/amdgpu/psp_v11_0.c | 25
              &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
              &nbsp;1 file changed, 25 insertions(&#43;)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c
              b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
              index ffeaa2f5588d..daf11be5416f 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
              &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/psp_v11_0.c<br>
              @@ -186,6 &#43;186,31 @@ static int
              psp_v11_0_init_microcode(struct psp_context *psp)<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI10:<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI14:<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case CHIP_NAVI12:<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; snprintf(fw_name, sizeof(fw_name),
              &quot;amdgpu/%s_ta.bin&quot;, chip_name);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =
              request_firmware(&amp;adev-&gt;psp.ta_fw, fw_name,
              adev-&gt;dev);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err) {<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              release_firmware(adev-&gt;psp.ta_fw);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw = NULL;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev,<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;psp v11.0: Failed to
              load firmware \&quot;%s\&quot;\n&quot;, fw_name);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err =
              amdgpu_ucode_validate(adev-&gt;psp.ta_fw);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err)<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto out2;<br>
              &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ta_hdr = (const struct
              ta_firmware_header_v1_0 *)adev-&gt;psp.ta_fw-&gt;data;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_hdcp_ucode_version
              = le32_to_cpu(ta_hdr-&gt;ta_hdcp_ucode_version);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_hdcp_ucode_size =
              le32_to_cpu(ta_hdr-&gt;ta_hdcp_size_bytes);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_hdcp_start_addr =
              (uint8_t *)ta_hdr &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              le32_to_cpu(ta_hdr-&gt;header.ucode_array_offset_bytes);<br>
              &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_fw_version =
              le32_to_cpu(ta_hdr-&gt;header.ucode_version);<br>
              &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_version
              = le32_to_cpu(ta_hdr-&gt;ta_dtm_ucode_version);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_ucode_size =
              le32_to_cpu(ta_hdr-&gt;ta_dtm_size_bytes);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;psp.ta_dtm_start_addr =
              (uint8_t *)adev-&gt;psp.ta_hdcp_start_addr &#43;<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              le32_to_cpu(ta_hdr-&gt;ta_dtm_offset_bytes);<br>
              &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; default:<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BUG();<br>
              -- <br>
              2.17.1<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx" moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a></div>
          </span></font></div>
    </blockquote>
  </body>
</html>

--------------EFBA3E412223238D312E71DD--

--===============2016313954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============2016313954==--
