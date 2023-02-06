Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24005C61DA4
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Feb 2023 08:59:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 926F910E330;
	Mon,  6 Feb 2023 08:59:50 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9887910E330
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Feb 2023 08:59:49 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id q8so8102565wmo.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Feb 2023 00:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=IlRcY0vEg10LAacQ5vEbfq+/ZiaS4GrhUrqlMg1biqc=;
 b=B5hvTnCvoZ9gnBJtG1AoiCLG22HjI0ZfOYQsDyqJZcaDLajG3mzgAywuwhfMOKa3O6
 XNOgEqlRwAEnIqvs2H9XZO3VZmF3gV9yA7NkGyJ7zz4uXtX787nrqPZElHpQRMnYPgyY
 B5wUzcs7HoF4RZKS9vENwaR93qDRcCMmBHttUsXlpnzzLvkZdFGz20X3AIkssHD2AOvL
 CXxYLYrEAvTUdibaFcjrZrncFNSc2Hbkiv3gowi4seX9ohmuBelOG6NuPiTOGdn/ptxi
 0rj59foBT0nlX1M2hhsNKtoWK5rH/Y5zIOlClhIow2fNoYIiKO9oHvY+MqdhfBJqrxD7
 RJUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:from:references:to:content-language:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IlRcY0vEg10LAacQ5vEbfq+/ZiaS4GrhUrqlMg1biqc=;
 b=QibIQjmUs0ImYRhxU7lVpSWDjJnXtf1WTmqQicHI+pcOVITEW50BEAmBF5cGKAJprK
 xVxFARWl6dWTjErajBOH8gnEoY9YwhMYuCm8LNHJ3hnHiQThYlSu/tCOrv41L2Fvc1kU
 4Ev8rKO2W1MeWArJU6ef8Sf2Gt4NW29iXBe3Ti6rOpy16l42Ktd+gPoLmxEjuA/jscL1
 ZftRpLX4EC6JcRf1I+rz6GNrpbqz9uZB+K8482OD/GFdWPYDTtBAkM+Ub0bW21kWyXEF
 80gDiYFxzWIbVV2opPBcCLpzyZJG4ral+6Q+af1fnc6EOS/CD60mZh4iHMGReF+TlKjN
 RoNw==
X-Gm-Message-State: AO0yUKVD9T/QCcqdbdPBopIX1oCZ9jCJNWSwojQqfWKFxPD/WQ109m6H
 2OrTFWWvEYjePFVy6a6kAmskeDJt0Y4=
X-Google-Smtp-Source: AK7set8Py4iZtDIEoHnoWfEKbHO17Zr2suRVmvn4Pc+w+/sHIl+WpF/31e2uASZgI+LE4Y/98HFHyg==
X-Received: by 2002:a05:600c:3ca4:b0:3dc:f24:f2de with SMTP id
 bg36-20020a05600c3ca400b003dc0f24f2demr18108120wmb.12.1675673987999; 
 Mon, 06 Feb 2023 00:59:47 -0800 (PST)
Received: from [192.168.178.21] (p5b0ea2e7.dip0.t-ipconnect.de.
 [91.14.162.231]) by smtp.gmail.com with ESMTPSA id
 c7-20020a05600c0ac700b003d1d5a83b2esm15072940wmr.35.2023.02.06.00.59.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Feb 2023 00:59:47 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------s1ueuuzSI60Kp3MBSAigUUgj"
Message-ID: <9cf6c24f-2b91-0431-6098-4ee2230ce57a@gmail.com>
Date: Mon, 6 Feb 2023 09:59:46 +0100
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
 <a4d8d310-c2e0-f2e5-74e8-fe8a5c34501e@gmail.com>
 <MW3PR12MB4458263C5E9B1071F7831EF7EFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
 <9ac594eb-9b59-02e1-fc7f-a745e28ff201@amd.com>
 <MW3PR12MB4458C18F7080280760953EACEFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MW3PR12MB4458C18F7080280760953EACEFDA9@MW3PR12MB4458.namprd12.prod.outlook.com>
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
--------------s1ueuuzSI60Kp3MBSAigUUgj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 06.02.23 um 09:28 schrieb Xiao, Jack:
>
> [AMD Official Use Only - General]
>
>                >> >> It's simply not allowed to free up resources 
> during suspend since those can't be acquired again during resume.
>
>                               >> The in_suspend flag is set at the 
> beginning of suspend and unset at the end of resume. It can’t filter 
> the case you mentioned.
>
>
>                Why not? This is exactly what it should do.
>
> [Jack] If freeing up resources during resume, it should not hit the 
> issue you described. But only checking in_suspend flag would take 
> these cases as warning.
>

No, once more: Freeing up or allocating resources between suspend and 
resume is illegal!

If you free up a resource during resume you should absolutely hit that, 
this is intentional!

Regards,
Christian.

> Regards,
>
> Jack
>
> *From:* Koenig, Christian <Christian.Koenig@amd.com>
> *Sent:* Monday, February 6, 2023 4:06 PM
> *To:* Xiao, Jack <Jack.Xiao@amd.com>; Christian König 
> <ckoenig.leichtzumerken@gmail.com>; amd-gfx@lists.freedesktop.org; 
> Deucher, Alexander <Alexander.Deucher@amd.com>
> *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers when DMA 
> is unavailable
>
> Am 06.02.23 um 08:23 schrieb Xiao, Jack:
>
>     [AMD Official Use Only - General]
>
>     >> Nope, that is not related to any hw state.
>
>     can use other flag.
>
>     >> It's simply not allowed to free up resources during suspend
>     since those can't be acquired again during resume.
>
>     The in_suspend flag is set at the beginning of suspend and unset
>     at the end of resume. It can’t filter the case you mentioned.
>
>
> Why not? This is exactly what it should do.
>
>     Do you know the root cause of these cases hitting the issue? So
>     that we can get an exact point to warn the freeing up behavior.
>
>
> Well the root cause are programming errors. See between suspending and 
> resuming you should not allocate nor free memory.
>
> Otherwise we can run into trouble. And this check here is one part of 
> that, we should probably add another warning during allocation of 
> memory. But this here is certainly correct.
>
> Regards,
> Christian.
>
>     Thanks,
>
>     Jack
>
>     *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
>     <mailto:ckoenig.leichtzumerken@gmail.com>
>     *Sent:* Friday, February 3, 2023 9:20 PM
>     *To:* Xiao, Jack <Jack.Xiao@amd.com> <mailto:Jack.Xiao@amd.com>;
>     Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org;
>     Deucher, Alexander <Alexander.Deucher@amd.com>
>     <mailto:Alexander.Deucher@amd.com>
>     *Subject:* Re: [PATCH] drm/amdgpu: only WARN freeing buffers when
>     DMA is unavailable
>
>     Nope, that is not related to any hw state.
>
>     It's simply not allowed to free up resources during suspend since
>     those can't be acquired again during resume.
>
>     We had a couple of cases now where this was wrong. If you get a
>     warning from that please fix the code which tried to free
>     something during suspend instead.
>
>     Regards,
>     Christian.
>
>     Am 03.02.23 um 07:04 schrieb Xiao, Jack:
>
>         [AMD Official Use Only - General]
>
>         >> It's simply illegal to free up memory during suspend.
>
>         Why? In my understanding, the limit was caused by DMA shutdown.
>
>         Regards,
>
>         Jack
>
>         *From:* Koenig, Christian <Christian.Koenig@amd.com>
>         <mailto:Christian.Koenig@amd.com>
>         *Sent:* Thursday, February 2, 2023 7:43 PM
>         *To:* Xiao, Jack <Jack.Xiao@amd.com>
>         <mailto:Jack.Xiao@amd.com>; amd-gfx@lists.freedesktop.org;
>         Deucher, Alexander <Alexander.Deucher@amd.com>
>         <mailto:Alexander.Deucher@amd.com>
>         *Subject:* AW: [PATCH] drm/amdgpu: only WARN freeing buffers
>         when DMA is unavailable
>
>         Big NAK to this! This warning is not related in any way to the
>         hw state.
>
>         It's simply illegal to free up memory during suspend.
>
>         Regards,
>
>         Christian.
>
>         ------------------------------------------------------------------------
>
>         *Von:*Xiao, Jack <Jack.Xiao@amd.com>
>         *Gesendet:* Donnerstag, 2. Februar 2023 10:54
>         *An:* amd-gfx@lists.freedesktop.org
>         <amd-gfx@lists.freedesktop.org>; Deucher, Alexander
>         <Alexander.Deucher@amd.com>; Koenig, Christian
>         <Christian.Koenig@amd.com>
>         *Cc:* Xiao, Jack <Jack.Xiao@amd.com>
>         *Betreff:* [PATCH] drm/amdgpu: only WARN freeing buffers when
>         DMA is unavailable
>
>         Reduce waringings, only warn when DMA is unavailable.
>
>         Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
>         ---
>          drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>          1 file changed, 2 insertions(+), 1 deletion(-)
>
>         diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>         index 2d237f3d3a2e..e3e3764ea697 100644
>         --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>         +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>         @@ -422,7 +422,8 @@ void amdgpu_bo_free_kernel(struct
>         amdgpu_bo **bo, u64 *gpu_addr,
>                  if (*bo == NULL)
>                          return;
>
>         - WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend);
>         + WARN_ON(amdgpu_ttm_adev((*bo)->tbo.bdev)->in_suspend &&
>         +
>         !amdgpu_ttm_adev((*bo)->tbo.bdev)->ip_blocks[AMD_IP_BLOCK_TYPE_SDMA].status.hw);
>
>                  if (likely(amdgpu_bo_reserve(*bo, true) == 0)) {
>                          if (cpu_addr)
>         -- 
>         2.37.3
>

--------------s1ueuuzSI60Kp3MBSAigUUgj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 06.02.23 um 09:28 schrieb Xiao, Jack:<br>
    <blockquote type="cite"
cite="mid:MW3PR12MB4458C18F7080280760953EACEFDA9@MW3PR12MB4458.namprd12.prod.outlook.com">
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
	text-decoration:underline;}p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
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
        <p class="MsoNormal" style="margin-bottom:12.0pt">              
                         &gt;&gt; &gt;&gt; It's simply not allowed to
          free up resources during suspend since those can't be acquired
          again during resume.<o:p></o:p></p>
        <p class="MsoNormal">                              &gt;&gt; The
          in_suspend flag is set at the beginning of suspend and unset
          at the end of resume. It can’t filter the case you mentioned.<o:p></o:p></p>
        <p class="MsoNormal"><br>
                         Why not? This is exactly what it should do.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">[Jack] If freeing up resources during
          resume, it should not hit the issue you described. But only
          checking in_suspend flag would take these cases as warning.</p>
      </div>
    </blockquote>
    <br>
    No, once more: Freeing up or allocating resources between suspend
    and resume is illegal!<br>
    <br>
    If you free up a resource during resume you should absolutely hit
    that, this is intentional!<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:MW3PR12MB4458C18F7080280760953EACEFDA9@MW3PR12MB4458.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Regards,<o:p></o:p></p>
        <p class="MsoNormal">Jack<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div style="border:none;border-top:solid #E1E1E1
            1.0pt;padding:3.0pt 0in 0in 0in">
            <p class="MsoNormal"><b>From:</b> Koenig, Christian
              <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a> <br>
              <b>Sent:</b> Monday, February 6, 2023 4:06 PM<br>
              <b>To:</b> Xiao, Jack <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Xiao@amd.com">&lt;Jack.Xiao@amd.com&gt;</a>; Christian
              König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a>;
              <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
              <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN freeing
              buffers when DMA is unavailable<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal" style="margin-bottom:12.0pt">Am 06.02.23 um
          08:23 schrieb Xiao, Jack:<o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="msipheaderdf3d92d6" style="margin:0in"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
              Official Use Only - General]</span><o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">&gt;&gt; Nope, that is not related to any
            hw state.<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">can use other flag.<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal" style="margin-bottom:12.0pt">&gt;&gt;
            It's simply not allowed to free up resources during suspend
            since those can't be acquired again during resume.<o:p></o:p></p>
          <p class="MsoNormal">The in_suspend flag is set at the
            beginning of suspend and unset at the end of resume. It
            can’t filter the case you mentioned.<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
          Why not? This is exactly what it should do.<br>
          <br>
          <o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal">Do you know the root cause of these cases
            hitting the issue? So that we can get an exact point to warn
            the freeing up behavior.<o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal" style="margin-bottom:12.0pt"><br>
          Well the root cause are programming errors. See between
          suspending and resuming you should not allocate nor free
          memory.<br>
          <br>
          Otherwise we can run into trouble. And this check here is one
          part of that, we should probably add another warning during
          allocation of memory. But this here is certainly correct.<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          <o:p></o:p></p>
        <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal">Thanks,<o:p></o:p></p>
          <p class="MsoNormal">Jack<o:p></o:p></p>
          <p class="MsoNormal"> <o:p></o:p></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0in 0in 0in">
              <p class="MsoNormal"><b>From:</b> Christian König <a
                  href="mailto:ckoenig.leichtzumerken@gmail.com"
                  moz-do-not-send="true">
                  &lt;ckoenig.leichtzumerken@gmail.com&gt;</a> <br>
                <b>Sent:</b> Friday, February 3, 2023 9:20 PM<br>
                <b>To:</b> Xiao, Jack <a
                  href="mailto:Jack.Xiao@amd.com" moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                Koenig, Christian
                <a href="mailto:Christian.Koenig@amd.com"
                  moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                <a href="mailto:amd-gfx@lists.freedesktop.org"
                  moz-do-not-send="true" class="moz-txt-link-freetext">
                  amd-gfx@lists.freedesktop.org</a>; Deucher, Alexander
                <a href="mailto:Alexander.Deucher@amd.com"
                  moz-do-not-send="true">
                  &lt;Alexander.Deucher@amd.com&gt;</a><br>
                <b>Subject:</b> Re: [PATCH] drm/amdgpu: only WARN
                freeing buffers when DMA is unavailable<o:p></o:p></p>
            </div>
          </div>
          <p class="MsoNormal"> <o:p></o:p></p>
          <p class="MsoNormal" style="margin-bottom:12.0pt">Nope, that
            is not related to any hw state.<br>
            <br>
            It's simply not allowed to free up resources during suspend
            since those can't be acquired again during resume.<br>
            <br>
            We had a couple of cases now where this was wrong. If you
            get a warning from that please fix the code which tried to
            free something during suspend instead.<br>
            <br>
            Regards,<br>
            Christian.<o:p></o:p></p>
          <div>
            <p class="MsoNormal">Am 03.02.23 um 07:04 schrieb Xiao,
              Jack:<o:p></o:p></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="msipheaderdf3d92d6" style="margin:0in"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                Official Use Only - General]</span><o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">&gt;&gt; It's simply illegal to free up
              memory during suspend.<o:p></o:p></p>
            <p class="MsoNormal">Why? In my understanding, the limit was
              caused by DMA shutdown.<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <p class="MsoNormal">Regards,<o:p></o:p></p>
            <p class="MsoNormal">Jack<o:p></o:p></p>
            <p class="MsoNormal"> <o:p></o:p></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> Koenig, Christian <a
                    href="mailto:Christian.Koenig@amd.com"
                    moz-do-not-send="true">
                    &lt;Christian.Koenig@amd.com&gt;</a> <br>
                  <b>Sent:</b> Thursday, February 2, 2023 7:43 PM<br>
                  <b>To:</b> Xiao, Jack <a
                    href="mailto:Jack.Xiao@amd.com"
                    moz-do-not-send="true">&lt;Jack.Xiao@amd.com&gt;</a>;
                  <a href="mailto:amd-gfx@lists.freedesktop.org"
                    moz-do-not-send="true" class="moz-txt-link-freetext">amd-gfx@lists.freedesktop.org</a>;
                  Deucher, Alexander
                  <a href="mailto:Alexander.Deucher@amd.com"
                    moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                  <b>Subject:</b> AW: [PATCH] drm/amdgpu: only WARN
                  freeing buffers when DMA is unavailable<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"> <o:p></o:p></p>
            <div>
              <p class="MsoNormal">Big NAK to this! This warning is not
                related in any way to the hw state.<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"> <o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal">It's simply illegal to free up memory
                during suspend.<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal"> <o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal">Regards,<o:p></o:p></p>
            </div>
            <div>
              <p class="MsoNormal">Christian.<o:p></o:p></p>
            </div>
            <p class="MsoNormal"> <o:p></o:p></p>
            <div class="MsoNormal" style="text-align:center"
              align="center">
              <hr width="98%" size="2" align="center">
            </div>
            <div id="divRplyFwdMsg">
              <p class="MsoNormal"><b><span style="color:black">Von:</span></b><span
                  style="color:black"> Xiao, Jack &lt;<a
                    href="mailto:Jack.Xiao@amd.com"
                    moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
                  <b>Gesendet:</b> Donnerstag, 2. Februar 2023 10:54<br>
                  <b>An:</b> <a
                    href="mailto:amd-gfx@lists.freedesktop.org"
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
                    href="mailto:Jack.Xiao@amd.com"
                    moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
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
                    href="mailto:Jack.Xiao@amd.com"
                    moz-do-not-send="true" class="moz-txt-link-freetext">Jack.Xiao@amd.com</a>&gt;<br>
                  ---<br>
                   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-<br>
                   1 file changed, 2 insertions(+), 1 deletion(-)<br>
                  <br>
                  diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
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
                           if (likely(amdgpu_bo_reserve(*bo, true) ==
                  0)) {<br>
                                   if (cpu_addr)<br>
                  -- <br>
                  2.37.3<o:p></o:p></p>
              </div>
            </div>
          </blockquote>
          <p class="MsoNormal"> <o:p></o:p></p>
        </blockquote>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------s1ueuuzSI60Kp3MBSAigUUgj--
