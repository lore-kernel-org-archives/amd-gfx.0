Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52ADCC05027
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 13:20:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B715D10E799;
	Fri,  3 Feb 2023 13:20:05 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E05510E797
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 13:20:02 +0000 (UTC)
Received: by mail-ej1-x62e.google.com with SMTP id me3so15247931ejb.7
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Feb 2023 05:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ABEFePbgEezpbtkHqVsgVQfs3w+dG4wbt4xQA6VGoWU=;
 b=NFOoyuV3tCiqJE9VgbdfynuYzDqlVXgnH1RrsCV7oA3PZjBCnqutZIMX4Cy4/eoKD5
 uxaQKD2d0Fdr0eIlMtvEoE5h8VntUSZToeuTzI5iy8qEfDp0LDkekyeV2WOj+6Dq23wG
 wHQrllK6G7QHYSjDdpTi07fjkMNyFKRnDIs9Bmf4g/oFDG+89MR4sBZjGfq538jvhePU
 EMAzRknVJNHWWxUhP44rKaq6lcU/3o/jvqVU5qyj0tFR6RxH5TN8AbFBCPG3Wq5RYno/
 jmVAKiL4zLCg0fG7dIaYChpmI9jxSl99yBv/c1xh7gKMqxNFYMitrPem6hRemRvtDN4X
 aZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ABEFePbgEezpbtkHqVsgVQfs3w+dG4wbt4xQA6VGoWU=;
 b=c5vphYyTnQqhOPaE7f8z0+k3Vo7sj/Y8na6VrOoxdNv75BOUAyNhbGQ8IwL5d63WFo
 xNCAgaY5kDfp4ZqSPmu2qThOcPcZc6OnQkQqqGXfXmesncvehjSVjo+L1VVAR0pip4Np
 0Ugfjk8aGBhpUQFi6pRKPfD6T3vBN6lk5P8aV6AjdRTkEhuBzH2mVWJK179DDLHuzoUa
 NyIH+5FF5M119VhGZOzvQXReaZa1kNb3Xz04aqkLJYCtHXAhc1yv0rV8WHZ+ClWVjy54
 ECkDQanCnOzsrJKqSupXFzW51vVJC5dCCbY6qYApT68PScO6CvlVoYllhHpqMEKx0rS/
 NEsA==
X-Gm-Message-State: AO0yUKWBm8RdAEytU4Ao5I1kn9mDvNjNSQ0HL5Lx8fxsyHHaCKN3QgPx
 6QsDCcTY3/4dYvfOGgJFVbg=
X-Google-Smtp-Source: AK7set8EqMwFrPMklHNXJY0Xj40tuvk1mC5rrW1tTBazHoOwiU7i//xWi0HOHl401K6ysU0G7kvWDA==
X-Received: by 2002:a17:906:7141:b0:877:7157:9358 with SMTP id
 z1-20020a170906714100b0087771579358mr1904881ejj.10.1675430401514; 
 Fri, 03 Feb 2023 05:20:01 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:e69f:4344:5e2b:198b?
 ([2a02:908:1256:79a0:e69f:4344:5e2b:198b])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a170906580900b00877ec3b9b8bsm1359068ejq.153.2023.02.03.05.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Feb 2023 05:20:00 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------NsKfu8AAjyG0Pgl6qn0W808n"
Message-ID: <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
Date: Fri, 3 Feb 2023 14:19:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is
 unavailable
Content-Language: en-US
To: "Xiao, Jack" <Jack.Xiao@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230202095416.4039818-1-Jack.Xiao@amd.com>
 <BYAPR12MB35899E39061894E55AC07FE383D69@BYAPR12MB3589.namprd12.prod.outlook.com>
 <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------NsKfu8AAjyG0Pgl6qn0W808n
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Nope, that is not related to any hw state.

It's simply not allowed to free up resources during suspend since those 
can't be acquired again during resume.

We had a couple of cases now where this was wrong. If you get a warning 
from that please fix the code which tried to free something during 
suspend instead.

Regards,
Christian.

Am 03.02.23 um 07:04 schrieb Xiao, Jack:
>
> [AMD Official Use Only - General]
>
> >> It's simply illegal to free up memory during suspend.
>
> Why? In my understanding, the limit was caused by DMA shutdown.
>
> Regards,
>
> Jack
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Thursday, February 2, 2023 7:43 PM
> *To:* Xiao, Jack <Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org; 
> Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* AW: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA 
> is unavailable
>
> Big NAK to this! This warning is not related in any way to the hw state.
>
> It's simply illegal to free up memory during suspend.
>
> Regards,
>
> Christian.
>
> ------------------------------------------------------------------------
>
> *Von:*Xiao, Jack <Jack.Xiao@amd.com>
> *Gesendet:* Donnerstag, 2. Februar 2023 10:54
> *An:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>
> *Cc:* Xiao, Jack <Jack.Xiao@amd.com>
> *Betreff:* [PATCH] drm/amdgpu: only WARN freeing buffers when DMA is 
> unavailable
>
> Reduce waringings, only warn when DMA is unavailable.
>
> Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 2d237f3d3a2e..e3e3764ea697 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, 
> u64 *gpu_addr,
>          if (*bo == NULL)
>                  return;
>
> - WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
> + WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
> + 
> !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);
>
>          if (likely(amdgpu_bo_reserve(*bo, true) == 0)) {
>                  if (cpu_addr)
> -- 
> 2.37.3
>

--------------NsKfu8AAjyG0Pgl6qn0W808n
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Nope, that is not related to any hw state.<br>
    <br>
    It's simply not allowed to free up resources during suspend since
    those can't be acquired again during resume.<br>
    <br>
    We had a couple of cases now where this was wrong. If you get a
    warning from that please fix the code which tried to free something
    during suspend instead.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 03.02.23 um 07:04 schrieb Xiao,
      Jack:<br>
    </div>
    <blockquote type="cite"
cite="mid:MW3PR12MB4458B37F3A4E9AF91F35279FEFD79@MW3PR12MB4458.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <div class="WordSection1">
        <p class="msipheaderdf3d92d6" style="margin:0in"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only - General]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">&gt;&gt; It's simply illegal to free up
          memory during suspend.<o:p></o:p></p>
        <p class="MsoNormal">Why? In my understanding, the limit was
          caused by DMA shutdown.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Regards,<o:p></o:p></p>
        <p class="MsoNormal">Jack<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> <br>
              <b>Sent:</b> Thursday, February 2, 2023 7:43 PM<br>
              <b>To:</b> Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Subject:</b> AW: [PATCH] drm/amdgpu: only WARN freeing
              buffers when DMA is unavailable<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <p class="MsoNormal">Big NAK to this! This warning is not
            related in any way to the hw state.<o:p></o:p></p>
        </div>
        <div>
          <p class="MsoNormal"><o:p> </o:p></p>
        </div>
        <div>
          <p class="MsoNormal">It's simply illegal to free up memory
            during suspend.<o:p></o:p></p>
        </div>
        <div>
          <p class="MsoNormal"><o:p> </o:p></p>
        </div>
        <div>
          <p class="MsoNormal">Regards,<o:p></o:p></p>
        </div>
        <div>
          <p class="MsoNormal">Christian.<o:p></o:p></p>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div class="MsoNormal" style="text-align:center" align="center">
          <hr width="98%" size="2" align="center">
        </div>
        <div id="divRplyFwdMsg">
          <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span
              style="color:black"> Xiao, Jack &lt;<a
                href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true"
                class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
              <b>Gesendet:</b> Donnerstag, 2. Februar 2023 10:54<br>
              <b>An:</b> <a href="mailto:amd-gfx@lists.freedesktop.org"
                moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>
              &lt;<a href="mailto:amd-gfx@lists.freedesktop.org"
                moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>&gt;;
              Deucher, Alexander &lt;<a
                href="mailto:Alexander.Deucher@amd.com"
                moz-do-not-send="true" class="moz-txt-link-freetext">Alexander.Deucher@amd.com</a>&gt;;
              Koenig, Christian &lt;<a
                href="mailto:Christian.Koenig@amd.com"
                moz-do-not-send="true" class="moz-txt-link-freetext">Christian.Koenig@amd.com</a>&gt;<br>
              <b>Cc:</b> Xiao, Jack &lt;<a
                href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true"
                class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
              <b>Betreff:</b> [PATCH] drm/amdgpu: only WARN freeing
              buffers when DMA is unavailable</span>
            <o:p></o:p></p>
          <div>
            <p class="MsoNormal"> <o:p></o:p></p>
          </div>
        </div>
        <div>
          <div>
            <p class="MsoNormal" style="margin-bottom:12.0pt">Reduce
              waringings, only warn when DMA is unavailable.<br>
              <br>
              Signed-off-by: Jack Xiao &lt;<a
                href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true"
                class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
              ---<br>
               drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-<br>
               1 file changed, 2 insertions(+), 1 deletion(-)<br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              index 2d237f3d3a2e..e3e3764ea697 100644<br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c<br>
              @@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct
              amdgpu_bo **bo, u64 *gpu_addr,<br>
                       if (*bo == NULL)<br>
                               return;<br>
               <br>
              -      
              WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;in_suspend);<br>
              +      
              WARN_ON(amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;in_suspend
              &amp;&amp;<br>
              +              
!amdgpu_ttm_adev((*bo)-&gt;tbo.bdev)-&gt;ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);<br>
               <br>
                       if (likely(amdgpu_bo_reserve(*bo, true) == 0)) {<br>
                               if (cpu_addr)<br>
              -- <br>
              2.37.3<o:p></o:p></p>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------NsKfu8AAjyG0Pgl6qn0W808n--
