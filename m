From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drm/amdgpu/uvd:Change uvd ring name convention
Date: Wed, 19 Dec 2018 10:08:28 +0100
Message-ID: <f6ac657e-3bee-cbfb-42bc-f25f7d8f1994@gmail.com>
References: <1545167223-8267-1-git-send-email-James.Zhu@amd.com>
 <BN6PR12MB1809289C85582D10810A491CF7BD0@BN6PR12MB1809.namprd12.prod.outlook.com>
Reply-To: christian.koenig-5C7GfCeVMHo@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0809913104=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <BN6PR12MB1809289C85582D10810A491CF7BD0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>, "Zhu, James" <James.Zhu-5C7GfCeVMHo@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Cc: "jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This is a multi-part message in MIME format.
--===============0809913104==
Content-Type: multipart/alternative;
 boundary="------------F0E03D3E1B4FB26882A44B11"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------F0E03D3E1B4FB26882A44B11
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

Am 18.12.18 um 23:06 schrieb Deucher, Alexander:
>
> Reviewed-by: Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org> on behalf of 
> Zhu, James <James.Zhu-5C7GfCeVMHo@public.gmane.org>
> *Sent:* Tuesday, December 18, 2018 4:07:21 PM
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> *Subject:* [PATCH] drm/amdgpu/uvd:Change uvd ring name convention
> Since umr tool can't handle bracket, change uvd ring name convention.
>
> Signed-off-by: James Zhu <James.Zhu-5C7GfCeVMHo@public.gmane.org>
> ---
>  drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c 
> b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> index 089645e..aef9240 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
> @@ -435,7 +435,7 @@ static int uvd_v7_0_sw_init(void *handle)
>                          continue;
>                  if (!amdgpu_sriov_vf(adev)) {
>                          ring = &adev->uvd.inst[j].ring;
> -                       sprintf(ring->name, "uvd<%d>", j);
> +                       sprintf(ring->name, "uvd_%d", ring->me);
>                          r = amdgpu_ring_init(adev, ring, 512, 
> &adev->uvd.inst[j].irq, 0);
>                          if (r)
>                                  return r;
> @@ -443,7 +443,7 @@ static int uvd_v7_0_sw_init(void *handle)
>
>                  for (i = 0; i < adev->uvd.num_enc_rings; ++i) {
>                          ring = &adev->uvd.inst[j].ring_enc[i];
> -                       sprintf(ring->name, "uvd_enc%d<%d>", i, j);
> +                       sprintf(ring->name, "uvd_enc_%d.%d", ring->me, i);
>                          if (amdgpu_sriov_vf(adev)) {
>                                  ring->use_doorbell = true;
>
> -- 
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------F0E03D3E1B4FB26882A44B11
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
      Am 18.12.18 um 23:06 schrieb Deucher, Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BN6PR12MB1809289C85582D10810A491CF7BD0-/b2+HYfkarSEx6ez0IUAagdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;font-family:Calibri,Helvetica,sans-serif;"
        dir="ltr">
        <p style="margin-top:0;margin-bottom:0">Reviewed-by: Alex
          Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher-5C7GfCeVMHo@public.gmane.org">&lt;alexander.deucher-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
        </p>
      </div>
      <hr style="display:inline-block;width:98%" tabindex="-1">
      <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
          face="Calibri, sans-serif" color="#000000"><b>From:</b>
          amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">&lt;amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org&gt;</a> on
          behalf of Zhu, James <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
          <b>Sent:</b> Tuesday, December 18, 2018 4:07:21 PM<br>
          <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
          <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">jzhums-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a><br>
          <b>Subject:</b> [PATCH] drm/amdgpu/uvd:Change uvd ring name
          convention</font>
        <div> </div>
      </div>
      <div class="BodyFragment"><font size="2"><span
            style="font-size:11pt;">
            <div class="PlainText">Since umr tool can't handle bracket,
              change uvd ring name convention.<br>
              <br>
              Signed-off-by: James Zhu <a class="moz-txt-link-rfc2396E" href="mailto:James.Zhu-5C7GfCeVMHo@public.gmane.org">&lt;James.Zhu-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 4 ++--<br>
               1 file changed, 2 insertions(+), 2 deletions(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
              b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
              index 089645e..aef9240 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c<br>
              @@ -435,7 +435,7 @@ static int uvd_v7_0_sw_init(void
              *handle)<br>
                                       continue;<br>
                               if (!amdgpu_sriov_vf(adev)) {<br>
                                       ring =
              &amp;adev-&gt;uvd.inst[j].ring;<br>
              -                       sprintf(ring-&gt;name,
              "uvd&lt;%d&gt;", j);<br>
              +                       sprintf(ring-&gt;name, "uvd_%d",
              ring-&gt;me);<br>
                                       r = amdgpu_ring_init(adev, ring,
              512, &amp;adev-&gt;uvd.inst[j].irq, 0);<br>
                                       if (r)<br>
                                               return r;<br>
              @@ -443,7 +443,7 @@ static int uvd_v7_0_sw_init(void
              *handle)<br>
               <br>
                               for (i = 0; i &lt;
              adev-&gt;uvd.num_enc_rings; ++i) {<br>
                                       ring =
              &amp;adev-&gt;uvd.inst[j].ring_enc[i];<br>
              -                       sprintf(ring-&gt;name,
              "uvd_enc%d&lt;%d&gt;", i, j);<br>
              +                       sprintf(ring-&gt;name,
              "uvd_enc_%d.%d", ring-&gt;me, i);<br>
                                       if (amdgpu_sriov_vf(adev)) {<br>
                                               ring-&gt;use_doorbell =
              true;<br>
               <br>
              -- <br>
              2.7.4<br>
              <br>
              _______________________________________________<br>
              amd-gfx mailing list<br>
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
              <a
                href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx"
                moz-do-not-send="true">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a><br>
            </div>
          </span></font></div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------F0E03D3E1B4FB26882A44B11--

--===============0809913104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0809913104==--
