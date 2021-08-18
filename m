Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E49C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 08:59:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73756108E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 08:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B73756108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B2B96E4CA;
	Wed, 18 Aug 2021 08:58:50 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C6076E4CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 08:58:49 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id h13so2348394wrp.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 01:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language;
 bh=rCloK+k90jqtCM7s+iKuk+6VJ6PlrMP8j8Uh1Ph3rLc=;
 b=AoLG9AvAKaG7jy59xaAn0M6rGlIkXkw9j2IuR/ArvipwVm+LOoixHCGpaee2QUnj31
 bRrFpwxPr40UZsIdhPiNfFuJQWBx4dsK5HleSF18fiCipfQ5LoFgiQOvHIaVMMYK8iIG
 Bt99Rjw/xM7nEBvpe18I07vkcpQdIZlVKIg4bxLk2FLmH3ma2q8odWj4j7dv19qDsK+Q
 6f4eCeZnhTcii6D0r8+Kn+N2/oELx1Yfqt53s6m0eUbvpc/HQ6SmucTgrwMTSSb6wORp
 ZdEi44TuoaQDWFgA4BX2UctZjJ85pLAZxl9y/X1JbeH9jcPzORUUIXnnlsFNb2e9Lt3j
 kkLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=rCloK+k90jqtCM7s+iKuk+6VJ6PlrMP8j8Uh1Ph3rLc=;
 b=GB7ZbW60uEQojU8tMdMOT0X894OlEYz3zqtggpsV9KKmBvxn5HkCkxNf5gJhmE1RqF
 +W43H2vPFeYthVWlKYgFfTv9CTsAg153v8TyKEizCguadgIa6M3ikTdtt2SmfPdIygEr
 vdVuPN0rU8qT+BlDUT4bjOtVLJfm9aEvEelTSnSmq/E1kWfzVFdrxKSAwga1oCGPspzH
 VbLotoIVh/lzjzHxOh3Mh3qQkH1ivMWF4nRs0MScSfB2RuhK8OOsclNUTyqoZgjK9VRQ
 XD9romuzEASFxLvfX+2mlwMd9mG2vMY+8SBrRNSRy+3UGfFy1S/WyLFo/OsjV87y0O5J
 Rpig==
X-Gm-Message-State: AOAM530OjRpQBUON7REr8FC020vuAGchan0R4geznEKv7Rkd13H5PNgg
 uiWNBryuch7kqnTO/ZIInK9jklH1iyw=
X-Google-Smtp-Source: ABdhPJwWdg34REL5iDEyaXq6sqzJQ7SS78iQH0wToSTnGvfEIutO3nn4th5elg92rYoEXFJXRt8s3Q==
X-Received: by 2002:adf:ef05:: with SMTP id e5mr9247269wro.237.1629277127856; 
 Wed, 18 Aug 2021 01:58:47 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id 7sm4662194wmk.39.2021.08.18.01.58.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Aug 2021 01:58:47 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix radv vulkan fps drop after s3 resume
To: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <DM4PR12MB52454BBA711B61BA2BD03033FFFE9@DM4PR12MB5245.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0a58b123-67bb-a066-2a36-fde0116a92c3@gmail.com>
Date: Wed, 18 Aug 2021 10:58:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <DM4PR12MB52454BBA711B61BA2BD03033FFFE9@DM4PR12MB5245.namprd12.prod.outlook.com>
Content-Type: multipart/alternative;
 boundary="------------98C4EF351B0B3A8C02595A4B"
Content-Language: en-US
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
--------------98C4EF351B0B3A8C02595A4B
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.08.21 um 20:26 schrieb Mohan Marimuthu, Yogesh:
>
> [Public]
>
>
> [Why]
>
> After s3, In radv there is huge fps drop in games. This is because
>
> when memory is allocated using radv_amdgpu_winsys_bo_create()
>
> with both AMDGPU_GEM_DOMAIN_VRAM and AMDGPU_GEM_DOMAIN_GTT domains
>
> set, the kernel memory management after resume fails to move the data
>
> back to VRAM. In kernel memory management, ttm_bo_mem_compat()
>
> function returns true and hence data is not moved back to VRAM.
>
> [How]
>
> Implement the idea suggested by Christian Koenig. During suspend
>
> move the data to system RAM instead of GTT. Due to this 
> ttm_bo_mem_compat()
>
> will return false and data will be moved back to VRAM.
>
> Signed-off-by: Christian König christian.koenig@amd.com 
> <mailto:christian.koenig@amd.com>
>

Suggested-by: would be better here since I wasn't involved in the coding.

> Signed-off-by: Yogesh mohan marimuthu yogesh.mohanmarimuthu@amd.com 
> <mailto:yogesh.mohanmarimuthu@amd.com>
>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 +++++++-
>
> 1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>
> index 446943e32..44ec59998 100644
>
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>
> @@ -136,7 +136,13 @@ static void amdgpu_evict_flags(struct 
> ttm_buffer_object *bo,
>
>                             return;
>
>                case TTM_PL_VRAM:
>
> -                            if (!adev->mman.buffer_funcs_enabled) {
>
> +                           /* Move data to system memory for S3 so 
> that while resume
>
> +                           * ttm_bo_mem_compat() will return false 
> and data will be
>
> +                           * moved back to VRAM also in case of bo 
> with both
>
> +                           * AMDGPU_GEM_DOMAIN_GTT and 
> AMDGPU_GEM_DOMAIN_VRAM domain
>
> +                           * set in bo->preferred_domains.
>
> +                           */
>
> +                           if (!adev->mman.buffer_funcs_enabled || 
> adev->in_s3) {
>
> /* Move to system memory */
>
> amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
>
>                             } else if 
> (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
>
> -- 
>
> 2.25.1
>


--------------98C4EF351B0B3A8C02595A4B
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Am 17.08.21 um 20:26 schrieb Mohan Marimuthu, Yogesh:<br>
    <blockquote type="cite"
cite="mid:DM4PR12MB52454BBA711B61BA2BD03033FFFE9@DM4PR12MB5245.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p class="msipheaderc10f11a2" style="margin:0" align="Left"><span
          style="font-size:10.0pt;font-family:Arial;color:#008000">[Public]</span></p>
      <br>
      <div class="WordSection1">
        <p class="MsoNormal">[Why]<o:p></o:p></p>
        <p class="MsoNormal">After s3, In radv there is huge fps drop in
          games. This is because<o:p></o:p></p>
        <p class="MsoNormal">when memory is allocated using
          radv_amdgpu_winsys_bo_create()<o:p></o:p></p>
        <p class="MsoNormal">with both AMDGPU_GEM_DOMAIN_VRAM and
          AMDGPU_GEM_DOMAIN_GTT domains<o:p></o:p></p>
        <p class="MsoNormal">set, the kernel memory management after
          resume fails to move the data<o:p></o:p></p>
        <p class="MsoNormal">back to VRAM. In kernel memory management,
          ttm_bo_mem_compat()<o:p></o:p></p>
        <p class="MsoNormal">function returns true and hence data is not
          moved back to VRAM.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">[How]<o:p></o:p></p>
        <p class="MsoNormal">Implement the idea suggested by Christian
          Koenig. During suspend<o:p></o:p></p>
        <p class="MsoNormal">move the data to system RAM instead of GTT.
          Due to this ttm_bo_mem_compat()<o:p></o:p></p>
        <p class="MsoNormal">will return false and data will be moved
          back to VRAM.<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">Signed-off-by: Christian König <a
            href="mailto:christian.koenig@amd.com"
            moz-do-not-send="true">
            christian.koenig@amd.com</a></p>
      </div>
    </blockquote>
    <br>
    Suggested-by: would be better here since I wasn't involved in the
    coding.<br>
    <br>
    <blockquote type="cite"
cite="mid:DM4PR12MB52454BBA711B61BA2BD03033FFFE9@DM4PR12MB5245.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal">Signed-off-by: Yogesh mohan marimuthu <a
            href="mailto:yogesh.mohanmarimuthu@amd.com"
            moz-do-not-send="true">
            yogesh.mohanmarimuthu@amd.com</a></p>
      </div>
    </blockquote>
    <br>
    Reviewed-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
    <br>
    <blockquote type="cite"
cite="mid:DM4PR12MB52454BBA711B61BA2BD03033FFFE9@DM4PR12MB5245.namprd12.prod.outlook.com">
      <div class="WordSection1">
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal">---<o:p></o:p></p>
        <p class="MsoNormal">drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8
          +++++++-<o:p></o:p></p>
        <p class="MsoNormal">1 file changed, 7 insertions(+), 1
          deletion(-)<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
        <p class="MsoNormal">diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
        <p class="MsoNormal">index 446943e32..44ec59998 100644<o:p></o:p></p>
        <p class="MsoNormal">---
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
        <p class="MsoNormal">+++
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c<o:p></o:p></p>
        <p class="MsoNormal">@@ -136,7 +136,13 @@ static void
          amdgpu_evict_flags(struct ttm_buffer_object *bo,<o:p></o:p></p>
        <p class="MsoNormal">                            return;<o:p></o:p></p>
        <p class="MsoNormal"><o:p></o:p></p>
        <p class="MsoNormal">               case TTM_PL_VRAM:<o:p></o:p></p>
        <p class="MsoNormal">-                            if
          (!adev-&gt;mman.buffer_funcs_enabled) {<o:p></o:p></p>
        <p class="MsoNormal">+                           /* Move data to
          system memory for S3 so that while resume<o:p></o:p></p>
        <p class="MsoNormal">+                           *
          ttm_bo_mem_compat() will return false and data will be<o:p></o:p></p>
        <p class="MsoNormal">+                           * moved back to
          VRAM also in case of bo with both<o:p></o:p></p>
        <p class="MsoNormal">+                           *
          AMDGPU_GEM_DOMAIN_GTT and AMDGPU_GEM_DOMAIN_VRAM domain<o:p></o:p></p>
        <p class="MsoNormal">+                           * set in
          bo-&gt;preferred_domains.<o:p></o:p></p>
        <p class="MsoNormal">+                           */<o:p></o:p></p>
        <p class="MsoNormal">+                           if
          (!adev-&gt;mman.buffer_funcs_enabled || adev-&gt;in_s3) {<o:p></o:p></p>
        <p class="MsoNormal">                                          
          /* Move to system memory */<o:p></o:p></p>
        <p class="MsoNormal">                                          
          amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);<o:p></o:p></p>
        <p class="MsoNormal">                            } else if
          (!amdgpu_gmc_vram_full_visible(&amp;adev-&gt;gmc) &amp;&amp;<o:p></o:p></p>
        <p class="MsoNormal">-- <o:p></o:p></p>
        <p class="MsoNormal">2.25.1<o:p></o:p></p>
        <p class="MsoNormal"><o:p> </o:p></p>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------98C4EF351B0B3A8C02595A4B--
