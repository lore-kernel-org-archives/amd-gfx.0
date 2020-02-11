Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633A2C352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 15:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 349C02086A
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 15:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAozThIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 349C02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D07D46E51A;
	Tue, 11 Feb 2020 15:16:41 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BCDA6E51A
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 15:16:40 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id m16so12785771wrx.11
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 07:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=vsWAT1+JmiLIn7Kkp8wQHiMNDlM7werXShu/3O5zUzw=;
 b=cAozThIrdz4x8HPDkjWKQN6t2H+cRe179kaxMSMuR58sy6ctPV9CkpJnVlhGXUgkqm
 QhrZZmAKcOh0W21PfeSvOhUo3Sr5LM+/aifr/bGRJ4Ene53VHwtbonLdYRWyEVPg6Xnc
 sP0fa/ug+HME2AC6QTptIowCPF3sJ/NfmwsXxdnFKxqgCq4av3ANVZQq1Pd71gIevj57
 Cbug6j1Kh15iRXcsDJvlU+IyEPUDZOuT82plnA5WUMvYEyPZz6xH5il/JHChCByJNczM
 GT7WER/3FoKUyK/RRCEtEopvY0EBokTxvTimeSUAS/ATFgmORaQXxwCxZqnRnhqXvLVU
 f7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language;
 bh=vsWAT1+JmiLIn7Kkp8wQHiMNDlM7werXShu/3O5zUzw=;
 b=EXMkYZM/FktgoHJ50Lt4q4irEYr6K6XJn7hvVwN0dCl55DUrSm8Zl92BQL8zcsDI5+
 QE8xxamWevVA3wViWb4UD+2p5bhJkxaGagXBBBXSNCsmTa2hVcm1FsFgYGICUpPCrf4w
 my33gJxECc+qWCLRuq3lx3AJw8FeVtGD4GBlItYQ9lWeuWMrFO2geV5CHR2XhOfbeIG7
 2MywWLk/k0NKxFZLTkfAUl5hNNyLH2Uz1KE8mU9iA6bYKGwAhRsa3s7NwszavUtmr2ap
 uCu4kdN1bxucohM2DjwpsoQcdezgiijOHcHlqbErh0eNaQWtysACRdoPzj4WBz4pcqMj
 gvEg==
X-Gm-Message-State: APjAAAVdIjSsC/jqSwlflIMJwpetnEAXnJGwu0AvOGknr0ye6z+9uDjN
 Mu7KzOAtN+N0sqJ89xYXnc01Jp3D
X-Google-Smtp-Source: APXvYqwmPUYpwNzCCQRV+I3yi+EN7XBn6ioYuoBdL9FzDwQtTe6Eybc0ECpufySq8CCYibjlhocEjA==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr9072977wrx.109.1581434199275; 
 Tue, 11 Feb 2020 07:16:39 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id t13sm5621577wrw.19.2020.02.11.07.16.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Feb 2020 07:16:38 -0800 (PST)
Subject: Re: [RFC PATCH v2] drm/amdgpu: move ttm bo->offset to amdgpu_bo
To: Nirmoy <nirmodas@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?=
 <christian.koenig@amd.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20200211140656.3574-1-nirmoy.das@amd.com>
 <3bf68f81-2825-6b00-af9a-e073c3872384@amd.com>
 <8d4c19f0-9a07-096b-3402-48d82e9d1391@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0aa40eb6-016d-75d2-16b6-080e30ca5d4b@gmail.com>
Date: Tue, 11 Feb 2020 16:16:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8d4c19f0-9a07-096b-3402-48d82e9d1391@amd.com>
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
Reply-To: christian.koenig@amd.com
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com
Content-Type: multipart/mixed; boundary="===============0508861337=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0508861337==
Content-Type: multipart/alternative;
 boundary="------------720D562D52900BF31A8A3AD8"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------720D562D52900BF31A8A3AD8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.02.20 um 15:54 schrieb Nirmoy:
>
>
> On 2/11/20 3:09 PM, Christian König wrote:
>> Am 11.02.20 um 15:06 schrieb Nirmoy Das:
>>> GPU address should belong to driver not in memory management.
>>> This patch moves ttm bo.offset and gpu_offset calculation to amdgpu 
>>> driver.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 22 
>>> +++++++++++++++++++--
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  8 +-------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  4 ++--
>>>   4 files changed, 24 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> index 6f60a581e3ba..e25924be33ca 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
>>> @@ -917,7 +917,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo 
>>> *bo, u32 domain,
>>>           bo->pin_count++;
>>>             if (max_offset != 0) {
>>> -            u64 domain_start = bo->tbo.bdev->man[mem_type].gpu_offset;
>>> +            u64 domain_start = amdgpu_bo_gpu_start(adev, mem_type);
>>>               WARN_ON_ONCE(max_offset <
>>>                        (amdgpu_bo_gpu_offset(bo) - domain_start));
>>>           }
>>> @@ -1248,6 +1248,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo 
>>> *bo, void *buffer,
>>>       return 0;
>>>   }
>>>   +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t 
>>> type)
>>
>> Probably better to put that into amdgpu_ttm.[ch] or amdgpu_gmc.[ch] 
>> and name it an amdgpu_ttm_domain_start.
>>
>>> +{
>>> +    switch(type) {
>>> +        case TTM_PL_TT:
>>
>> Coding style here is of, what editor and setting do you use?
> vi with *set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab cindent*
>
>
> My bad, I didn't check existing switch style.
>

Try this one here: https://github.com/vivien/vim-linux-coding-style

That should help,
Christian.

>
> Regards,
>
> Nirmoy
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------720D562D52900BF31A8A3AD8
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 11.02.20 um 15:54 schrieb Nirmoy:<br>
    </div>
    <blockquote type="cite"
      cite="mid:8d4c19f0-9a07-096b-3402-48d82e9d1391@amd.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <p><br>
      </p>
      <div class="moz-cite-prefix">On 2/11/20 3:09 PM, Christian König
        wrote:<br>
      </div>
      <blockquote type="cite"
        cite="mid:3bf68f81-2825-6b00-af9a-e073c3872384@amd.com">Am
        11.02.20 um 15:06 schrieb Nirmoy Das: <br>
        <blockquote type="cite">GPU address should belong to driver not
          in memory management. <br>
          This patch moves ttm bo.offset and gpu_offset calculation to
          amdgpu driver. <br>
          <br>
          Signed-off-by: Nirmoy Das <a class="moz-txt-link-rfc2396E"
            href="mailto:nirmoy.das@amd.com" moz-do-not-send="true">&lt;nirmoy.das@amd.com&gt;</a>
          <br>
          --- <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 22
          +++++++++++++++++++-- <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 + <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  8 +------- <br>
            drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  4 ++-- <br>
            4 files changed, 24 insertions(+), 11 deletions(-) <br>
          <br>
          diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c <br>
          index 6f60a581e3ba..e25924be33ca 100644 <br>
          --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c <br>
          +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c <br>
          @@ -917,7 +917,7 @@ int amdgpu_bo_pin_restricted(struct
          amdgpu_bo *bo, u32 domain, <br>
                    bo-&gt;pin_count++; <br>
                      if (max_offset != 0) { <br>
          -            u64 domain_start =
          bo-&gt;tbo.bdev-&gt;man[mem_type].gpu_offset; <br>
          +            u64 domain_start = amdgpu_bo_gpu_start(adev,
          mem_type); <br>
                        WARN_ON_ONCE(max_offset &lt; <br>
                                 (amdgpu_bo_gpu_offset(bo) -
          domain_start)); <br>
                    } <br>
          @@ -1248,6 +1248,18 @@ int amdgpu_bo_get_metadata(struct
          amdgpu_bo *bo, void *buffer, <br>
                return 0; <br>
            } <br>
            +uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev,
          uint32_t type) <br>
        </blockquote>
        <br>
        Probably better to put that into amdgpu_ttm.[ch] or
        amdgpu_gmc.[ch] and name it an amdgpu_ttm_domain_start. <br>
        <br>
        <blockquote type="cite">+{ <br>
          +    switch(type) { <br>
          +        case TTM_PL_TT: <br>
        </blockquote>
        <br>
        Coding style here is of, what editor and setting do you use? <br>
      </blockquote>
      vi with <b>set tabstop=8 softtabstop=8 shiftwidth=8 noexpandtab
        cindent</b><br>
      <p><br>
      </p>
      <p>My bad, I didn't check existing switch style.</p>
    </blockquote>
    <br>
    Try this one here: <a class="moz-txt-link-freetext" href="https://github.com/vivien/vim-linux-coding-style">https://github.com/vivien/vim-linux-coding-style</a><br>
    <br>
    That should help,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:8d4c19f0-9a07-096b-3402-48d82e9d1391@amd.com">
      <p><br>
      </p>
      <p>Regards,</p>
      <p>Nirmoy <br>
      </p>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------720D562D52900BF31A8A3AD8--

--===============0508861337==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0508861337==--
