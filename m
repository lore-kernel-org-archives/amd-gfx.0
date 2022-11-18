Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7120EC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Nov 2022 15:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1AD10E761;
	Fri, 18 Nov 2022 15:03:27 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4380510E761
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 15:03:24 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id n12so13632868eja.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Nov 2022 07:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M+LgXiqxfIfXdytq8AKy2ovsuuTHuj0RS3IO5GzyRL0=;
 b=QRbmO/l3rF5VhnzfobWQEVynA+QQL4gPGo0I7hddfogtaYmXDNMfnhT0znvP7w20//
 hOihoL/FQmZfPQWPqBXrlR/XTfkZCCCUf491eYcpuSA3ly7NsCRIcQWbUCtS8gMGRidm
 8fKY+NtQ+IsFaMbU2sYPXRYegv4gOxnKfueNR6gU1wMmNp+1Q5yOzE86SY/ZHneDPPfd
 KC7QS6oHh0TOdBSiiPhR2mm9Fq4ayiae7fnDvQ0eTxiViSeKKHgig2+yOIGM/UoFDLeg
 7x6KCcKRukH0OIyc9AkW4Orqz1TfjB0CBOrWsvPNRFmUMlmMoIgCdeMsqGyXMfsDsfFb
 M+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M+LgXiqxfIfXdytq8AKy2ovsuuTHuj0RS3IO5GzyRL0=;
 b=t+XaS4yBnTk5bWeNbTRSMp/ZZY0iv4xo2JoJJ+aM49Fa8WI2Q8X7H2nb00U1IS98Y6
 9gtYjpvCwFf04p/aD9jxHZKnCveZZ9MiOSEcxpU3jXMGfHMrOtpYkTsDQ8xt3SohLPer
 Hlnz8FuVJN6jtINK8J8VJidxgUxdHkJWvEksye6AbFflBil4uoCBcUZtlWsrKXuN1osw
 hRXG5/uf2nPpj03E3ycsX4Li7WQcJ/V5Rha5MmyCv1WPGcHFHQ1acXobPXu5KZSUuKXW
 6IMIYhiw/eFJkymDEvbKSZUpASZrVpAK0tw3Gt3TuivoO+bggm17G1SytHqDy5VnwQVu
 5hhQ==
X-Gm-Message-State: ANoB5pmacsudbFHW55grbDsTDooWnQvofmK9uzHwIM8cI3ge2+oAtu7/
 lwt+KAUYhxGaqmqkowV1N6o=
X-Google-Smtp-Source: AA0mqf5JpbokbdvkMozzwLp0Er99vfSLpZXCxbOFPpr50L3xT4qxjOK/wcyZlpZUaav9EVFY4SqmkA==
X-Received: by 2002:a17:906:2743:b0:7b2:92ce:faf2 with SMTP id
 a3-20020a170906274300b007b292cefaf2mr6203873ejd.158.1668783802334; 
 Fri, 18 Nov 2022 07:03:22 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:6df3:758:835a:3ec8?
 ([2a02:908:1256:79a0:6df3:758:835a:3ec8])
 by smtp.gmail.com with ESMTPSA id
 mf20-20020a1709071a5400b0078a543e9301sm1748956ejc.200.2022.11.18.07.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Nov 2022 07:03:21 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------zCVYEFT20KxtIgcvH4eK5KKe"
Message-ID: <5f6b244a-acf9-8d96-07c1-e6da08b9716e@gmail.com>
Date: Fri, 18 Nov 2022 16:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: update documentation of parameter
 amdgpu_gtt_size
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yin, ZhenGuo (Chris)" <ZhenGuo.Yin@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20221118084931.1381499-1-zhenguo.yin@amd.com>
 <BL1PR12MB514403BB9F01744715E75F06F7099@BL1PR12MB5144.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BL1PR12MB514403BB9F01744715E75F06F7099@BL1PR12MB5144.namprd12.prod.outlook.com>
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Chen, Jingwen" <Jingwen.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------zCVYEFT20KxtIgcvH4eK5KKe
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Reviewed-by: Christian König <christian.koenig@amd.com>

Am 18.11.22 um 15:52 schrieb Deucher, Alexander:
>
> [Public]
>
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> ------------------------------------------------------------------------
> *From:* Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
> *Sent:* Friday, November 18, 2022 3:49 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Deucher, Alexander <Alexander.Deucher@amd.com>; Chen, Jingwen 
> <Jingwen.Chen@amd.com>; Yin, ZhenGuo (Chris) <ZhenGuo.Yin@amd.com>
> *Subject:* [PATCH] drm/amdgpu: update documentation of parameter 
> amdgpu_gtt_size
> Fixes: f7ba887f606b ("drm/amdgpu: Adjust logic around GTT size (v3)")
> Signed-off-by: ZhenGuo Yin <zhenguo.yin@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 72b77b3ac4fb..987914532104 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -237,8 +237,7 @@ module_param_named(gartsize, amdgpu_gart_size, 
> uint, 0600);
>
>  /**
>   * DOC: gttsize (int)
> - * Restrict the size of GTT domain in MiB for testing. The default is 
> -1 (It's VRAM size if 3GB < VRAM < 3/4 RAM,
> - * otherwise 3/4 RAM size).
> + * Restrict the size of GTT domain in MiB for testing. The default is 
> -1 (Use 1/2 RAM, minimum value is 3GB).
>   */
>  MODULE_PARM_DESC(gttsize, "Size of the GTT domain in megabytes (-1 = 
> auto)");
>  module_param_named(gttsize, amdgpu_gtt_size, int, 0600);
> -- 
> 2.35.1
>

--------------zCVYEFT20KxtIgcvH4eK5KKe
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
    <br>
    <div class="moz-cite-prefix">Am 18.11.22 um 15:52 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BL1PR12MB514403BB9F01744715E75F06F7099@BL1PR12MB5144.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:10pt;color:#008000;margin:15pt;"
        align="Left">
        [Public]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);" class="elementToProof">
          Reviewed-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a><br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b> Yin,
            ZhenGuo (Chris) <a class="moz-txt-link-rfc2396E" href="mailto:ZhenGuo.Yin@amd.com">&lt;ZhenGuo.Yin@amd.com&gt;</a><br>
            <b>Sent:</b> Friday, November 18, 2022 3:49 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Chen, Jingwen
            <a class="moz-txt-link-rfc2396E" href="mailto:Jingwen.Chen@amd.com">&lt;Jingwen.Chen@amd.com&gt;</a>; Yin, ZhenGuo (Chris)
            <a class="moz-txt-link-rfc2396E" href="mailto:ZhenGuo.Yin@amd.com">&lt;ZhenGuo.Yin@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH] drm/amdgpu: update documentation of
            parameter amdgpu_gtt_size</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">Fixes: f7ba887f606b ("drm/amdgpu:
                Adjust logic around GTT size (v3)")<br>
                Signed-off-by: ZhenGuo Yin <a class="moz-txt-link-rfc2396E" href="mailto:zhenguo.yin@amd.com">&lt;zhenguo.yin@amd.com&gt;</a><br>
                ---<br>
                 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +--<br>
                 1 file changed, 1 insertion(+), 2 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
                b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                index 72b77b3ac4fb..987914532104 100644<br>
                --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
                @@ -237,8 +237,7 @@ module_param_named(gartsize,
                amdgpu_gart_size, uint, 0600);<br>
                 <br>
                 /**<br>
                  * DOC: gttsize (int)<br>
                - * Restrict the size of GTT domain in MiB for testing.
                The default is -1 (It's VRAM size if 3GB &lt; VRAM &lt;
                3/4 RAM,<br>
                - * otherwise 3/4 RAM size).<br>
                + * Restrict the size of GTT domain in MiB for testing.
                The default is -1 (Use 1/2 RAM, minimum value is 3GB).<br>
                  */<br>
                 MODULE_PARM_DESC(gttsize, "Size of the GTT domain in
                megabytes (-1 = auto)");<br>
                 module_param_named(gttsize, amdgpu_gtt_size, int,
                0600);<br>
                -- <br>
                2.35.1<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------zCVYEFT20KxtIgcvH4eK5KKe--
