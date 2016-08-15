From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple-ANTagKRnAhcb1SvskN2V4Q@public.gmane.org>
Subject: Re: [PATCH] drm/amd/amdgpu: Add more config data for debugfs
Date: Mon, 15 Aug 2016 15:17:53 +0200
Message-ID: <1885d5a1-cc32-dad2-f8eb-7349a39ede2c@vodafone.de>
References: <20160812192852.25500-1-tom.stdenis@amd.com>
 <DM5PR12MB1132BE10BFA7B652BD16A3E2F7120@DM5PR12MB1132.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0089569567=="
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
In-Reply-To: <DM5PR12MB1132BE10BFA7B652BD16A3E2F7120-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
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
To: "StDenis, Tom" <Tom.StDenis-5C7GfCeVMHo@public.gmane.org>, Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>

This is a multi-part message in MIME format.
--===============0089569567==
Content-Type: multipart/alternative;
 boundary="------------0441175A650BD8C3924FEB93"

This is a multi-part message in MIME format.
--------------0441175A650BD8C3924FEB93
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 15.08.2016 um 14:26 schrieb StDenis, Tom:
>
> Hi all,
>
>
> If I could get an ACK/NAK that would be appreciated.  I have a commit 
> pending on the debug tool (that reads these) that I'd like to get out.
>
>
> Thanks,
>
> Tom
>
>
>
> ------------------------------------------------------------------------
> *From:* Tom St Denis <tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> *Sent:* Friday, August 12, 2016 15:28
> *To:* amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> *Cc:* StDenis, Tom
> *Subject:* [PATCH] drm/amd/amdgpu: Add more config data for debugfs
> Adds rev_id as well as cg/pg flags to help debug runtime.
>
> Signed-off-by: Tom St Denis <tom.stdenis-5C7GfCeVMHo@public.gmane.org>

Acked-by: Christian König <christian.koenig-5C7GfCeVMHo@public.gmane.org>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 53763614c6e0..bbd3173cc5ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2653,7 +2653,7 @@ static ssize_t 
> amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
>                  return -ENOMEM;
>
>          /* version, increment each time something is added */
> -       config[no_regs++] = 0;
> +       config[no_regs++] = 1;
>          config[no_regs++] = adev->gfx.config.max_shader_engines;
>          config[no_regs++] = adev->gfx.config.max_tile_pipes;
>          config[no_regs++] = adev->gfx.config.max_cu_per_sh;
> @@ -2678,6 +2678,11 @@ static ssize_t 
> amdgpu_debugfs_gca_config_read(struct file *f, char __user *buf,
>          config[no_regs++] = adev->gfx.config.gb_addr_config;
>          config[no_regs++] = adev->gfx.config.num_rbs;
>
> +       /* rev==1 */
> +       config[no_regs++] = adev->rev_id;
> +       config[no_regs++] = adev->pg_flags;
> +       config[no_regs++] = adev->cg_flags;
> +
>          while (size && (*pos < no_regs * 4)) {
>                  uint32_t value;
>
> -- 
> 2.9.2
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx



--------------0441175A650BD8C3924FEB93
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 15.08.2016 um 14:26 schrieb StDenis,
      Tom:<br>
    </div>
    <blockquote
cite="mid:DM5PR12MB1132BE10BFA7B652BD16A3E2F7120-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
      <style type="text/css" style="display:none;"><!-- P {margin-top:0;margin-bottom:0;} --></style>
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <p>Hi all,</p>
        <p><br>
        </p>
        <p>If I could get an ACK/NAK that would be appreciated.  I have
          a commit pending on the debug tool (that reads these) that I'd
          like to get out.</p>
        <p><br>
        </p>
        <p>Thanks,</p>
        <p>Tom</p>
        <br>
        <br>
        <div style="color: rgb(0, 0, 0);">
          <div>
            <hr tabindex="-1" style="display:inline-block; width:98%">
            <div id="x_divRplyFwdMsg" dir="ltr"><font
                style="font-size:11pt" color="#000000" face="Calibri,
                sans-serif"><b>From:</b> Tom St Denis
                <a class="moz-txt-link-rfc2396E" href="mailto:tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org">&lt;tstdenis82-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org&gt;</a><br>
                <b>Sent:</b> Friday, August 12, 2016 15:28<br>
                <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org">amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org</a><br>
                <b>Cc:</b> StDenis, Tom<br>
                <b>Subject:</b> [PATCH] drm/amd/amdgpu: Add more config
                data for debugfs</font>
              <div> </div>
            </div>
          </div>
          <font size="2"><span style="font-size:10pt;">
              <div class="PlainText">Adds rev_id as well as cg/pg flags
                to help debug runtime.<br>
                <br>
                Signed-off-by: Tom St Denis <a class="moz-txt-link-rfc2396E" href="mailto:tom.stdenis-5C7GfCeVMHo@public.gmane.org">&lt;tom.stdenis-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
    Acked-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig-5C7GfCeVMHo@public.gmane.org">&lt;christian.koenig-5C7GfCeVMHo@public.gmane.org&gt;</a><br>
    <br>
    <blockquote
cite="mid:DM5PR12MB1132BE10BFA7B652BD16A3E2F7120-2J9CzHegvk+UzrhdoDeimQdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org"
      type="cite">
      <div id="divtagdefaultwrapper"
style="font-size:12pt;color:#000000;background-color:#FFFFFF;font-family:Calibri,Arial,Helvetica,sans-serif;">
        <div style="color: rgb(0, 0, 0);"><font size="2"><span
              style="font-size:10pt;">
              <div class="PlainText">
                ---<br>
                 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 ++++++-<br>
                 1 file changed, 6 insertions(+), 1 deletion(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                index 53763614c6e0..bbd3173cc5ea 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
                @@ -2653,7 +2653,7 @@ static ssize_t
                amdgpu_debugfs_gca_config_read(struct file *f, char
                __user *buf,<br>
                                 return -ENOMEM;<br>
                 <br>
                         /* version, increment each time something is
                added */<br>
                -       config[no_regs++] = 0;<br>
                +       config[no_regs++] = 1;<br>
                         config[no_regs++] =
                adev-&gt;gfx.config.max_shader_engines;<br>
                         config[no_regs++] =
                adev-&gt;gfx.config.max_tile_pipes;<br>
                         config[no_regs++] =
                adev-&gt;gfx.config.max_cu_per_sh;<br>
                @@ -2678,6 +2678,11 @@ static ssize_t
                amdgpu_debugfs_gca_config_read(struct file *f, char
                __user *buf,<br>
                         config[no_regs++] =
                adev-&gt;gfx.config.gb_addr_config;<br>
                         config[no_regs++] =
                adev-&gt;gfx.config.num_rbs;<br>
                 <br>
                +       /* rev==1 */<br>
                +       config[no_regs++] = adev-&gt;rev_id;<br>
                +       config[no_regs++] = adev-&gt;pg_flags;<br>
                +       config[no_regs++] = adev-&gt;cg_flags;<br>
                +<br>
                         while (size &amp;&amp; (*pos &lt; no_regs * 4))
                {<br>
                                 uint32_t value;<br>
                 <br>
                -- <br>
                2.9.2<br>
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

--------------0441175A650BD8C3924FEB93--

--===============0089569567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--===============0089569567==--
