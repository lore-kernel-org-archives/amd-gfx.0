Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35BC9C74A5B
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Mar 2023 13:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D24210E0FA;
	Tue, 21 Mar 2023 13:54:52 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36C210E0FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 13:54:50 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id j24so4871493wrd.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Mar 2023 06:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1679406889;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UCFmG2X7YmtIK9dY5twY/plMke3nOX/w6cZp6dwfQ7w=;
 b=XM9KTuk6eIB8dPXcJ29nPrKOi0rVAmvqZPTTMP2szXNC+QF1R4A+C5EKpjBNAzJpSU
 cUSUgQYcntiOqRpHGI+UF3XJMATPyNvXk8GL1ViH3Afj02XYDwN2Y+2uIzqfqoLa5OoC
 mvhTZqCxfLLE9jg4JGqnI+kK1Pw2o84Ye4mzS2rjqvp97Mah3tmcUmwF/v6Z3/EPJH/n
 63n+Z39/WDQLpBGzqXojWEnQ5w4yr7L6+a/MqN+8+L0mvAF91Pxxk/WHr2yiv9NAHOK3
 ZzTm294hOnHlc83BMv2lGqSpsxKMiTI6JZ1GlJX+dk+9WNz6/4MEPCmsG8UpYX0z9s1a
 rAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679406889;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UCFmG2X7YmtIK9dY5twY/plMke3nOX/w6cZp6dwfQ7w=;
 b=HlUt4q7kJ/HKQi0/3nCXWH+JrmWIBzpumUGMoPVE3NPp9+0P75ek7B8kyzT/VMCqBx
 lUhn1USladGIlgIkTq9gqgHRyfW7R/lKnkp50thut5yVfX8jWaYCdkGOcizyrp009zvN
 dyLWMCWx19k/JEi32/1JxNTxPqh5korW5LFEL7cfi+Rg2s0DF+kFmqbTiBx/yR+PKO5O
 AZtwYNoQWSlqqTOYFkzuztIX74WKIirCIJmbVNv3XQn6hPLGkmivRPTnkvFaY/Vcyd/P
 Vf8N81Ybi4W9IMk+8uHh4UdKkqaOMT81YkSBsPJHgINxg+G4IW3WOF005oLNR2bPvLfV
 vimg==
X-Gm-Message-State: AO0yUKVVoYuRmSWArFgXiUenli8eGQyhHdPciDeAJF5GtxK448PewiAQ
 cc7m3PgDMyzoejfCMv+VcH0=
X-Google-Smtp-Source: AK7set83fNrT+ZctvSv2eR0DB7CoKu8f+M8zMg/kQgWmI2d9j4tTofMPt2WnxgXKmr4AfpmGSj4eeA==
X-Received: by 2002:adf:fe51:0:b0:2cf:e689:e60e with SMTP id
 m17-20020adffe51000000b002cfe689e60emr2330382wrs.59.1679406888901; 
 Tue, 21 Mar 2023 06:54:48 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:ecb6:57a3:fc8e:3359?
 ([2a02:908:1256:79a0:ecb6:57a3:fc8e:3359])
 by smtp.gmail.com with ESMTPSA id
 i7-20020adffc07000000b002c5706f7c6dsm11385553wrr.94.2023.03.21.06.54.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Mar 2023 06:54:48 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------HXladQL3w1ZIf9J9it0T1hZ0"
Message-ID: <0e904e40-ee6f-dea2-b2de-3e408a72908e@gmail.com>
Date: Tue, 21 Mar 2023 14:54:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints to ctx
 ioctl
Content-Language: en-US
To: "Sharma, Shashank" <Shashank.Sharma@amd.com>,
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-2-shashank.sharma@amd.com>
 <CAAxE2A67NMxra-a9ZYbY8e8S4fjfdXgB1cpjYZsSS8DcUu=LbA@mail.gmail.com>
 <MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com>
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Somalapuram,
 Amaranath" <Amaranath.Somalapuram@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------HXladQL3w1ZIf9J9it0T1hZ0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Yes, I would like to avoid having multiple code paths for context creation.

Setting it later on should be equally to specifying it on creation since 
we only need it during CS.

Regards,
Christian.

Am 21.03.23 um 14:00 schrieb Sharma, Shashank:
>
> [AMD Official Use Only - General]
>
> When we started this patch series, the workload hint was a part of the 
> ctx_flag only,
>
> But we changed that after the design review, to make it more like how 
> we are handling PSTATE.
>
> Details:
>
> https://patchwork.freedesktop.org/patch/496111/
>
> Regards
>
> Shashank
>
> *From:*Marek Olšák <maraeo@gmail.com>
> *Sent:* 21 March 2023 04:05
> *To:* Sharma, Shashank <Shashank.Sharma@amd.com>
> *Cc:* amd-gfx@lists.freedesktop.org; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Somalapuram, Amaranath 
> <Amaranath.Somalapuram@amd.com>; Koenig, Christian 
> <Christian.Koenig@amd.com>
> *Subject:* Re: [PATCH v3 1/5] drm/amdgpu: add UAPI for workload hints 
> to ctx ioctl
>
> I think we should do it differently because this interface will be 
> mostly unused by open source userspace in its current form.
>
> Let's set the workload hint in drm_amdgpu_ctx_in::flags, and that will 
> be immutable for the lifetime of the context. No other interface is 
> needed.
>
> Marek
>
> On Mon, Sep 26, 2022 at 5:41 PM Shashank Sharma 
> <shashank.sharma@amd.com> wrote:
>
>     Allow the user to specify a workload hint to the kernel.
>     We can use these to tweak the dpm heuristics to better match
>     the workload for improved performance.
>
>     V3: Create only set() workload UAPI (Christian)
>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>     Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>     ---
>      include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++
>      1 file changed, 17 insertions(+)
>
>     diff --git a/include/uapi/drm/amdgpu_drm.h
>     b/include/uapi/drm/amdgpu_drm.h
>     index c2c9c674a223..23d354242699 100644
>     --- a/include/uapi/drm/amdgpu_drm.h
>     +++ b/include/uapi/drm/amdgpu_drm.h
>     @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {
>      #define AMDGPU_CTX_OP_QUERY_STATE2     4
>      #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5
>      #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6
>     +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7
>
>      /* GPU reset status */
>      #define AMDGPU_CTX_NO_RESET            0
>     @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {
>      #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3
>      #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4
>
>     +/* GPU workload hints, flag bits 8-15 */
>     +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8
>     +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff <<
>     AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>     +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 <<
>     AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>     +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 <<
>     AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>     +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 <<
>     AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>     +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 <<
>     AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>     +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 <<
>     AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>     +#define AMDGPU_CTX_WORKLOAD_HINT_MAX AMDGPU_CTX_WORKLOAD_HINT_COMPUTE
>     +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n >>
>     AMDGPU_CTX_WORKLOAD_HINT_SHIFT)
>     +
>      struct drm_amdgpu_ctx_in {
>             /** AMDGPU_CTX_OP_* */
>             __u32   op;
>     @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {
>                             __u32   flags;
>                             __u32   _pad;
>                     } pstate;
>     +
>     +               struct {
>     +                       __u32   flags;
>     +                       __u32   _pad;
>     +               } workload;
>      };
>
>      union drm_amdgpu_ctx {
>     -- 
>     2.34.1
>

--------------HXladQL3w1ZIf9J9it0T1hZ0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Yes, I would like to avoid having multiple code paths for context
    creation.<br>
    <br>
    Setting it later on should be equally to specifying it on creation
    since we only need it during CS.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 21.03.23 um 14:00 schrieb Sharma,
      Shashank:<br>
    </div>
    <blockquote type="cite"
cite="mid:MW4PR12MB56678ED37B6E498D3405F875F2819@MW4PR12MB5667.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
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
        <p class="msipheaderdf3d92d6" style="margin:0cm"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD
            Official Use Only - General]</span><o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US">When
            we started this patch series, the workload hint was a part
            of the ctx_flag only,
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US">But
            we changed that after the design review, to make it more
            like how we are handling PSTATE.
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US">Details:
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US"><a
              href="https://patchwork.freedesktop.org/patch/496111/"
              moz-do-not-send="true" class="moz-txt-link-freetext">https://patchwork.freedesktop.org/patch/496111/</a>
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US"><o:p> </o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US">Regards<o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US">Shashank
            <o:p></o:p></span></p>
        <p class="MsoNormal"><span style="mso-fareast-language:EN-US"><o:p> </o:p></span></p>
        <div style="border:none;border-top:solid #E1E1E1
          1.0pt;padding:3.0pt 0cm 0cm 0cm">
          <p class="MsoNormal"><b><span lang="EN-US">From:</span></b><span
              lang="EN-US"> Marek Olšák <a class="moz-txt-link-rfc2396E" href="mailto:maraeo@gmail.com">&lt;maraeo@gmail.com&gt;</a>
              <br>
              <b>Sent:</b> 21 March 2023 04:05<br>
              <b>To:</b> Sharma, Shashank
              <a class="moz-txt-link-rfc2396E" href="mailto:Shashank.Sharma@amd.com">&lt;Shashank.Sharma@amd.com&gt;</a><br>
              <b>Cc:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>; Deucher,
              Alexander <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a>; Somalapuram,
              Amaranath <a class="moz-txt-link-rfc2396E" href="mailto:Amaranath.Somalapuram@amd.com">&lt;Amaranath.Somalapuram@amd.com&gt;</a>; Koenig,
              Christian <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a><br>
              <b>Subject:</b> Re: [PATCH v3 1/5] drm/amdgpu: add UAPI
              for workload hints to ctx ioctl<o:p></o:p></span></p>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div>
            <p class="MsoNormal">I think we should do it differently
              because this interface will be mostly unused by open
              source userspace in its current form.<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal"><o:p> </o:p></p>
          </div>
          <div>
            <p class="MsoNormal">Let's set the workload hint in
              drm_amdgpu_ctx_in::flags, and that will be immutable for
              the lifetime of the context. No other interface is needed.<o:p></o:p></p>
          </div>
          <div>
            <p class="MsoNormal"><o:p> </o:p></p>
          </div>
          <div>
            <p class="MsoNormal">Marek<o:p></o:p></p>
          </div>
        </div>
        <p class="MsoNormal"><o:p> </o:p></p>
        <div>
          <div>
            <p class="MsoNormal">On Mon, Sep 26, 2022 at 5:41 PM
              Shashank Sharma &lt;<a
                href="mailto:shashank.sharma@amd.com"
                moz-do-not-send="true" class="moz-txt-link-freetext">shashank.sharma@amd.com</a>&gt;
              wrote:<o:p></o:p></p>
          </div>
          <blockquote style="border:none;border-left:solid #CCCCCC
            1.0pt;padding:0cm 0cm 0cm
6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0cm;margin-bottom:5.0pt">
            <p class="MsoNormal" style="margin-bottom:12.0pt">Allow the
              user to specify a workload hint to the kernel.<br>
              We can use these to tweak the dpm heuristics to better
              match<br>
              the workload for improved performance.<br>
              <br>
              V3: Create only set() workload UAPI (Christian)<br>
              <br>
              Signed-off-by: Alex Deucher &lt;<a
                href="mailto:alexander.deucher@amd.com" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">alexander.deucher@amd.com</a>&gt;<br>
              Signed-off-by: Shashank Sharma &lt;<a
                href="mailto:shashank.sharma@amd.com" target="_blank"
                moz-do-not-send="true" class="moz-txt-link-freetext">shashank.sharma@amd.com</a>&gt;<br>
              ---<br>
               include/uapi/drm/amdgpu_drm.h | 17 +++++++++++++++++<br>
               1 file changed, 17 insertions(+)<br>
              <br>
              diff --git a/include/uapi/drm/amdgpu_drm.h
              b/include/uapi/drm/amdgpu_drm.h<br>
              index c2c9c674a223..23d354242699 100644<br>
              --- a/include/uapi/drm/amdgpu_drm.h<br>
              +++ b/include/uapi/drm/amdgpu_drm.h<br>
              @@ -212,6 +212,7 @@ union drm_amdgpu_bo_list {<br>
               #define AMDGPU_CTX_OP_QUERY_STATE2     4<br>
               #define AMDGPU_CTX_OP_GET_STABLE_PSTATE        5<br>
               #define AMDGPU_CTX_OP_SET_STABLE_PSTATE        6<br>
              +#define AMDGPU_CTX_OP_SET_WORKLOAD_PROFILE     7<br>
              <br>
               /* GPU reset status */<br>
               #define AMDGPU_CTX_NO_RESET            0<br>
              @@ -252,6 +253,17 @@ union drm_amdgpu_bo_list {<br>
               #define AMDGPU_CTX_STABLE_PSTATE_MIN_MCLK  3<br>
               #define AMDGPU_CTX_STABLE_PSTATE_PEAK  4<br>
              <br>
              +/* GPU workload hints, flag bits 8-15 */<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_SHIFT     8<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_MASK      (0xff &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_NONE      (0 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_3D        (1 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_VIDEO     (2 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_VR        (3 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_COMPUTE   (4 &lt;&lt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +#define AMDGPU_CTX_WORKLOAD_HINT_MAX     
              AMDGPU_CTX_WORKLOAD_HINT_COMPUTE<br>
              +#define AMDGPU_CTX_WORKLOAD_INDEX(n)      (n &gt;&gt;
              AMDGPU_CTX_WORKLOAD_HINT_SHIFT)<br>
              +<br>
               struct drm_amdgpu_ctx_in {<br>
                      /** AMDGPU_CTX_OP_* */<br>
                      __u32   op;<br>
              @@ -281,6 +293,11 @@ union drm_amdgpu_ctx_out {<br>
                                      __u32   flags;<br>
                                      __u32   _pad;<br>
                              } pstate;<br>
              +<br>
              +               struct {<br>
              +                       __u32   flags;<br>
              +                       __u32   _pad;<br>
              +               } workload;<br>
               };<br>
              <br>
               union drm_amdgpu_ctx {<br>
              -- <br>
              2.34.1<o:p></o:p></p>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------HXladQL3w1ZIf9J9it0T1hZ0--
