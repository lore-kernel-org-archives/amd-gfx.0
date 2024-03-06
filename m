Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0566C5475B
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Mar 2024 13:42:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B03A1131C6;
	Wed,  6 Mar 2024 13:42:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gMpud4Fp";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C72A91131C6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Mar 2024 13:42:20 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-412f556b3baso5016575e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 06 Mar 2024 05:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709732539; x=1710337339; darn=lists.freedesktop.org;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+g0DLO2dGGQDdWuhd1YGhjhREO6yfsCX8QjKdhYZa2w=;
 b=gMpud4FpIqDkTyU+efCE285P5bvSlis63gQBKaWuEjCnAQdsyCl6KC+RDpLVkdFM+K
 lOo/F4C6yj1dqMfi6aPuAaXBwkd9nXMN0+LmS3d3R4S/ZP2SB68TA+kLmJXVjVS/7/Au
 Aid5o97zuDsAPDLvMmzlEBIvYPY9Jsl3idvu4hD7cn0MpvHYcszInro404+2MHXFNG1O
 SgTQ9ipQ7qEXlPbOdfVDmROTGQr4dUcTxIm7Pj6yqHT2slxbO9nf/BAnK2al2yjM59fW
 fdgtA1mWvYRiWH0caIsrW64xZYG8EUguxLwDfx2W8wwPZcfgOUqWTRyl/YrxZnVlgTOl
 rPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709732539; x=1710337339;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+g0DLO2dGGQDdWuhd1YGhjhREO6yfsCX8QjKdhYZa2w=;
 b=DnVvkrWerWWw0c2QuhrG0U7131951+DBkgl78tT0dY5vRffH9YTFmWtdyfLlV5qc6x
 RwJpfuTxab59EXeRbyFwPZQk7PrA0Ivci3O1ubTjTIPlTVvawzP2A3iSgOjYtkvk2aoD
 jGNJQecEVNuJYrzhOMEqc5gunxjnU7etUc2xcwokULPqj8inqb9uXQLOateXHN7FDYlF
 6HMiQ44ZhUT2uhSZ2I6bdlw0KGLHUiGfA5eh/+WgkE/Zc2ec1go97pv5+kkKvgCx4xz2
 y3Se4GeYGxLNuzB3e31OKQ8hRYVX1l5j2dSMDHGU6TYpg8SjFTA4djXQOrb2ILNxMdsJ
 ft1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEYKgPj/sd1UjZVy4lxq3v//kSggPF8OcmZyKB6n2NtPANRulWw2T2MeaTCFLF75TfrWdPeTKQoQRJEl9h6/IcN0b3y1W/tEgWITWjhQ==
X-Gm-Message-State: AOJu0YyACsiexOxotfQgqjf7zwfJVlXfqYDXHNS88drqSB6DB5gJokHh
 d7/XaXyP8tV3u4X+L2thXIQ57uAV0Or74Iqr/DgUpYILJnZ6RLav
X-Google-Smtp-Source: AGHT+IF3dQp0WhnPQqtgl7RW/F+ZeWEI3ONyTVRd0e8v9xO5emlAHJeGFMM9EvI4bhW5cFT8Ef/iBA==
X-Received: by 2002:a5d:4404:0:b0:33d:82cb:6595 with SMTP id
 z4-20020a5d4404000000b0033d82cb6595mr11244025wrq.68.1709732538415; 
 Wed, 06 Mar 2024 05:42:18 -0800 (PST)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 bx10-20020a5d5b0a000000b0033df46f70dbsm18320018wrb.9.2024.03.06.05.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Mar 2024 05:42:17 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------tuR7PnCpS3NHjrqcxt8OuCqp"
Message-ID: <1cb14fea-4fe9-45db-b219-ec3999cbdb0d@gmail.com>
Date: Wed, 6 Mar 2024 14:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Why has to offer "/dev/drv/render128" fd when running ROCm demo?
Content-Language: en-US
To: =?UTF-8?B?5pu55a2Q6b6Z?= <gainerying@163.com>,
 amd-gfx@lists.freedesktop.org
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
References: <26c1a512.11d3c.18e0edda56b.Coremail.gainerying@163.com>
 <BL1PR12MB51446D775639DE08F0C909F2F7222@BL1PR12MB5144.namprd12.prod.outlook.com>
 <BN9PR12MB511505BAEBB3578722974CFC92222@BN9PR12MB5115.namprd12.prod.outlook.com>
 <3fadf81a.7dac.18e123934a3.Coremail.gainerying@163.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <3fadf81a.7dac.18e123934a3.Coremail.gainerying@163.com>
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
--------------tuR7PnCpS3NHjrqcxt8OuCqp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Zicao,

that won't work any more the render Node is mandatory for correct ROCm 
operation by now.

Regards,
Christian.

Am 06.03.24 um 06:25 schrieb 曹子龙:
> Hi felix:
>    Thanks for your kindly help.
>
> i still has a question, if on a pure-compute platform, which has no 
> /dev/dri/render node, but only with a single /dev/kfd node, how the 
> compue scenario works since that wei have no "render" fd exists?
> is such platfom(without render node) exists?
>
>  thanks for your kindly help.!
>
> BRs
> zlcao.
>
>
>
>
>
> At 2024-03-06 04:43:30, "Kuehling, Felix" <Felix.Kuehling@amd.com> wrote:
>
>     [AMD Official Use Only - General]
>
>
>     I already answered this question in a reply to another email that
>     was addressed to me:
>
>     The render nodes are used for CPU mapping of VRAM with mmap calls
>     and an offset that identifies the BO. The render node also creates
>     the GPU virtual address space that is used by KFD to create the
>     GPU memory mappings. Applications that use both graphics and
>     compute can share the same GPU virtual address space in this way.
>
>     Zlcao, in the future, this type of question may be better
>     addressed to a mailing list such as amd-gfx@lists.freedesktop.org,
>     instead of writing separately to different maintainers.
>
>     Regards,
>       Felix
>
>     *From:*Deucher, Alexander <Alexander.Deucher@amd.com>
>     *Sent:* Tuesday, March 5, 2024 3:17 PM
>     *To:* 曹子龙<gainerying@163.com>; Kuehling, Felix
>     <Felix.Kuehling@amd.com>; Yat Sin, David <David.YatSin@amd.com>
>     *Subject:* Re: Why has to offer "/dev/drv/render128" fd when
>     running ROCm demo?
>
>     [AMD Official Use Only - General]
>
>     + Felix, David to comment.
>
>     ------------------------------------------------------------------------
>
>     *From:*曹子龙<gainerying@163.com <mailto:gainerying@163.com>>
>     *Sent:* Tuesday, March 5, 2024 8:46 AM
>     *To:* Deucher, Alexander <Alexander.Deucher@amd.com
>     <mailto:Alexander.Deucher@amd.com>>
>     *Subject:* Why has to offer "/dev/drv/render128" fd when running
>     ROCm demo?
>
>     Hi alexander.:
>
>         sorry for bother. but i really need some help to deal with my
>     puzzle.
>
>     i am a freshman to AMD GPU Driver, NOW i am trying to write a
>     simple demo to use "/dev/kfd" and do some  vram alloc/free tests, 
>     but i found you must do the right "AMDKFD_IOC_ACQUIRE_VM" ioctl
>     comamnd before you try GPU to do vram allocation and other
>     things.  from the kfd driver code,the pre-condition to do the
>     right "AMDKFD_IOC_ACQUIRE_VM" is to offer a "/dev/drv/render128"
>     fd  to the parameters.
>
>     so, why need to do this? kfd is used for compute, but
>     "/dev/dri/render128" is specify to gfx usaged, why must open the
>     "/dev/dri/render128" during the KFD compute scenario?
>
>     thanks for your kindly help!
>
>     BRs
>
>     zlcao.
>

--------------tuR7PnCpS3NHjrqcxt8OuCqp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Zicao,<br>
    <br>
    that won't work any more the render Node is mandatory for correct
    ROCm operation by now.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 06.03.24 um 06:25 schrieb 曹子龙:<br>
    </div>
    <blockquote type="cite"
      cite="mid:3fadf81a.7dac.18e123934a3.Coremail.gainerying@163.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div
style="line-height:1.7;color:#000000;font-size:14px;font-family:Arial">
        <div style="margin: 0;">Hi felix:</div>
        <div style="margin: 0;">   Thanks for your kindly help.</div>
        <div style="margin: 0;"><br>
        </div>
        <div style="margin: 0;">i still has a question, if on a
          pure-compute platform, which has no /dev/dri/render node, but
          only with a single /dev/kfd node, how the compue scenario
          works since that wei have no "render" fd exists?<br>
        </div>
        <div style="margin: 0;">is such platfom(without render node)
          exists? </div>
        <div style="margin: 0;"><br>
        </div>
        <div style="margin: 0;"> thanks for your kindly help.!</div>
        <div style="margin: 0;"><br>
        </div>
        <div style="margin: 0;">BRs</div>
        <div style="margin: 0;">zlcao.</div>
        <p style="margin: 0;"><br>
        </p>
        <p style="margin: 0;"><br>
        </p>
        <p style="margin: 0;"><br>
        </p>
        <p style="margin: 0;"><br>
        </p>
        <p>At 2024-03-06 04:43:30, "Kuehling, Felix"
          <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a> wrote:</p>
        <blockquote id="isReplyContent"
style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
          <div xmlns:v="urn:schemas-microsoft-com:vml"
            xmlns:o="urn:schemas-microsoft-com:office:office"
            xmlns:w="urn:schemas-microsoft-com:office:word"
            xmlns:m="http://schemas.microsoft.com/office/2004/12/omml">
            <style></style>
            <div link="#0563C1" vlink="#954F72"
              style="word-wrap:break-word" lang="EN-US">
              <p
style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-style:normal;font-weight:normal;text-decoration:none;"
                align="Left">
                [AMD Official Use Only - General]<br>
              </p>
              <br>
              <div>
                <div class="WordSection1">
                  <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">I
                      already answered this question in a reply to
                      another email that was addressed to me:<o:p></o:p></span></p>
                  <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p> </o:p></span></p>
                  <p class="MsoNormal" style="margin-left:36.0pt"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">The
                      render nodes are used for CPU mapping of VRAM with
                      mmap calls and an offset that identifies the BO.
                      The render node also creates the GPU virtual
                      address space that is used by KFD to create the
                      GPU memory mappings. Applications that use both
                      graphics and compute can share the same GPU
                      virtual address space in this way.<o:p></o:p></span></p>
                  <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p> </o:p></span></p>
                  <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Zlcao,
                      in the future, this type of question may be better
                      addressed to a mailing list such as
                      <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>, instead of writing
                      separately to different maintainers.</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p></o:p></span></p>
                  <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p> </o:p></span></p>
                  <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US">Regards,<br>
                        Felix<o:p></o:p></span></p>
                  <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p> </o:p></span></p>
                  <p class="MsoNormal"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;mso-fareast-language:EN-US"><o:p> </o:p></span></p>
                  <div>
                    <div
style="border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm 0cm 0cm">
                      <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                          Deucher, Alexander
                          <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>
                          <br>
                          <b>Sent:</b> Tuesday, March 5, 2024 3:17 PM<br>
                          <b>To:</b> </span><span
                          style="font-size:11.0pt" lang="ZH-CN">曹子龙</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">
                          <a class="moz-txt-link-rfc2396E" href="mailto:gainerying@163.com">&lt;gainerying@163.com&gt;</a>; Kuehling, Felix
                          <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a>; Yat Sin, David
                          <a class="moz-txt-link-rfc2396E" href="mailto:David.YatSin@amd.com">&lt;David.YatSin@amd.com&gt;</a><br>
                          <b>Subject:</b> Re: Why has to offer
                          "/dev/drv/render128" fd when running ROCm
                          demo?<o:p></o:p></span></p>
                    </div>
                  </div>
                  <p class="MsoNormal"><o:p> </o:p></p>
                  <p style="margin:5.0pt"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
                      Official Use Only - General]<o:p></o:p></span></p>
                  <p class="MsoNormal"><o:p> </o:p></p>
                  <div>
                    <div>
                      <p class="MsoNormal"><span
style="font-family:&quot;Aptos&quot;,sans-serif;color:black">+ Felix,
                          David to comment.<o:p></o:p></span></p>
                    </div>
                    <div class="MsoNormal" style="text-align:center"
                      align="center">
                      <hr width="98%" size="2" align="center">
                    </div>
                    <div id="divRplyFwdMsg">
                      <p class="MsoNormal"><b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">From:</span></b><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                        </span><span
                          style="font-size:11.0pt;color:black"
                          lang="ZH-CN">曹子龙</span><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">
                          &lt;</span><a href="mailto:gainerying@163.com"
                          moz-do-not-send="true"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">gainerying@163.com</span></a><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&gt;<br>
                          <b>Sent:</b> Tuesday, March 5, 2024 8:46 AM<br>
                          <b>To:</b> Deucher, Alexander &lt;</span><a
                          href="mailto:Alexander.Deucher@amd.com"
                          moz-do-not-send="true"><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif">Alexander.Deucher@amd.com</span></a><span
style="font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&gt;<br>
                          <b>Subject:</b> Why has to offer
                          "/dev/drv/render128" fd when running ROCm
                          demo?</span>
                        <o:p></o:p></p>
                      <div>
                        <p class="MsoNormal"> <o:p></o:p></p>
                      </div>
                    </div>
                    <div>
                      <div>
                        <p><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black">Hi
                            alexander.:<o:p></o:p></span></p>
                        <div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black"> 
                                    sorry for bother. but i really need
                                some help to deal with my puzzle. <o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black">i
                                am a freshman to AMD GPU Driver, NOW i
                                am trying to write a simple demo to use
                                "/dev/kfd" and do some  vram alloc/free
                                tests,  but i found you must do the
                                right "AMDKFD_IOC_ACQUIRE_VM" ioctl
                                comamnd before you try GPU to do vram
                                allocation and other things.  from the
                                kfd driver code,the pre-condition to do
                                the right "AMDKFD_IOC_ACQUIRE_VM" is to
                                offer a "/dev/drv/render128" fd  to the
                                parameters.<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black">so,
                                why need to do this? kfd is used for
                                compute, but "/dev/dri/render128" is
                                specify to gfx usaged, why must open the
                                "/dev/dri/render128" during the KFD
                                compute scenario?<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black">thanks
                                for your kindly help!<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black">BRs<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black">zlcao.<o:p></o:p></span></p>
                          </div>
                          <div>
                            <p class="MsoNormal"><span
style="font-size:10.5pt;font-family:&quot;Arial&quot;,sans-serif;color:black"><o:p> </o:p></span></p>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------tuR7PnCpS3NHjrqcxt8OuCqp--
