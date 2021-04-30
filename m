Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A48B8C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 12:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31ABD613CD
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 12:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ABD613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F776E165;
	Fri, 30 Apr 2021 12:56:45 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 171476E165
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 12:56:45 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id f24so6533349ejc.6
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=sELsJtkS+k4B2BCSOZWheSsBfKFHJtZpilZBSZIrlZo=;
 b=jIeNYWCE4OEPhgghLP6ZyRx6Jb+p0um6D6VZ9M+q8J4wwZ88t5hSg1VJLtIqQK5NcL
 kG/6S4FBJf1HNDGZ/TXGwLEyQhj5FWXvBS55YqDi9I3ZMEYTBh9v1e7AcTWC+slFfSJw
 Ky0hyvH+G0ecKFhDTwdpq8Fy3cBRLvpkiV1uvqW5/AiBK2vf8c4n/Lzuuw30nMVQeCmx
 s4VkzVI1UCH16jxIv8sUaCXg/oGcYtfj4E1FrrUuZHiMtHHCxtspLHGrcHBNt5hcdsLZ
 Jfc/Ff4aORXmuPqje2lPhFv3todAAFnKrWEVmcdTHzFZ+hf7cAYdZlRKNZAcrQXkxyjq
 owtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=sELsJtkS+k4B2BCSOZWheSsBfKFHJtZpilZBSZIrlZo=;
 b=GYQj7QpX8rcAwOdcPE4ZLM2B45Jn4yNYU4z+oxEIZScN3OpLcW27xc/drSx/WWhnjn
 zzDOuyxjvT1asuQ86Ef3nLKnwMXMKwpKVEgyDaQClzI1PGhkjsM3J1CPNFYHvAVKRL1c
 nZrXfMeQajwD94trqoUm2CmrXZgdcYvArA8jCJb4PD78rWi1VGeDX2gdkcrqXKrUMVu0
 pzPU0OzJrQgAXjAhdoev0CIcRTlrUmhrY4NZ144+bkLtPWzC0KruzB1kVeC8HoLL7qIz
 z9y58k4KqwOMT4kidWAsdffZFvhM4QVliVDlqX7YUgVzXR8ZrlSeNCJ3CdpshvPypPUv
 OU+Q==
X-Gm-Message-State: AOAM531JBhRj0uoe8Kk+K1HYldn+EFsA2KANXGcJjs/eihCJmFq5Ueje
 TWgVV43nGeF+5067zew1lG8acnAIicU=
X-Google-Smtp-Source: ABdhPJys7T68ofiZuiY0YHTcOiZjPVSBIOzhp7D5O/7cLlK+cfwXm1/RpyMBolKqw/ecViZEZ5c1mg==
X-Received: by 2002:a17:906:3bc6:: with SMTP id
 v6mr4264557ejf.165.1619787403785; 
 Fri, 30 Apr 2021 05:56:43 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:aa4a:1229:bd1a:d432?
 ([2a02:908:1252:fb60:aa4a:1229:bd1a:d432])
 by smtp.gmail.com with ESMTPSA id o6sm1190839edw.24.2021.04.30.05.56.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Apr 2021 05:56:43 -0700 (PDT)
Subject: Re: [PATCH 1/1] drm/amdgpu: remove excess function parameter
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Nirmoy Das <nirmoy.das@amd.com>
References: <20210430114324.14959-1-nirmoy.das@amd.com>
 <20210430125221.3lo5lvioo7nbrlk4@outlook.office365.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <d0cc8e0a-18fa-8218-0ff0-65d69b7eb76b@gmail.com>
Date: Fri, 30 Apr 2021 14:56:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210430125221.3lo5lvioo7nbrlk4@outlook.office365.com>
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
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com,
 amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1810584510=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1810584510==
Content-Type: multipart/alternative;
 boundary="------------8CA303F522B929A77534A467"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------8CA303F522B929A77534A467
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Am 30.04.21 um 14:52 schrieb Rodrigo Siqueira:
> Hi,
>
> On 04/30, Nirmoy Das wrote:
>> Fixes: 49020fc1f5("drm/amdgpu: cleanup amdgpu_vm_init()")
> Just for curiosity, do we need the Fixes tag for this?

It's indeed a bit overkill.

The purpose of the Fixes tag is to mark bug fixes for specific patches 
so that backporters of feature know that when they picked up patch A 
they also need to pick up the fixes for patch A.

But since this is just cleaning up a recently added warning in a code 
documentation we could just push it without.

Christian.

>
> How about adding the warning/error message that this patch fixes? I
> think this can be useful for other people searching for a similar fix in
> the git log (I do it sometimes).
>
> Thanks
> Siqueira
>   
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index dae51992c607..f2513be72980 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2796,7 +2796,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>>    *
>>    * @adev: amdgpu_device pointer
>>    * @vm: requested vm
>> - * @vm_context: Indicates if it GFX or Compute context
>>    * @pasid: Process address space identifier
>>    *
>>    * Init @vm fields.
>> -- 
>> 2.30.2
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7Ca88acdf110bc4994ff3c08d90bcd36f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637553798286590199%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=tS6NA4FPNYFPCbIdngKshN3I%2BwRwAumgC0vdA50h9l8%3D&amp;reserved=0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------8CA303F522B929A77534A467
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Hi,<br>
    <br>
    <div class="moz-cite-prefix">Am 30.04.21 um 14:52 schrieb Rodrigo
      Siqueira:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20210430125221.3lo5lvioo7nbrlk4@outlook.office365.com">
      <pre class="moz-quote-pre" wrap="">Hi,

On 04/30, Nirmoy Das wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Fixes: 49020fc1f5("drm/amdgpu: cleanup amdgpu_vm_init()")
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Just for curiosity, do we need the Fixes tag for this?</pre>
    </blockquote>
    <br>
    It's indeed a bit overkill.<br>
    <br>
    The purpose of the Fixes tag is to mark bug fixes for specific
    patches so that backporters of feature know that when they picked up
    patch A they also need to pick up the fixes for patch A.<br>
    <br>
    But since this is just cleaning up a recently added warning in a
    code documentation we could just push it without.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20210430125221.3lo5lvioo7nbrlk4@outlook.office365.com">
      <pre class="moz-quote-pre" wrap="">

How about adding the warning/error message that this patch fixes? I
think this can be useful for other people searching for a similar fix in
the git log (I do it sometimes).

Thanks
Siqueira
 
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">Signed-off-by: Nirmoy Das <a class="moz-txt-link-rfc2396E" href="mailto:nirmoy.das@amd.com">&lt;nirmoy.das@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dae51992c607..f2513be72980 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2796,7 +2796,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @vm_context: Indicates if it GFX or Compute context
  * @pasid: Process address space identifier
  *
  * Init @vm fields.
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7Ca88acdf110bc4994ff3c08d90bcd36f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637553798286590199%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=tS6NA4FPNYFPCbIdngKshN3I%2BwRwAumgC0vdA50h9l8%3D&amp;amp;reserved=0">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7Ca88acdf110bc4994ff3c08d90bcd36f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637553798286590199%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=tS6NA4FPNYFPCbIdngKshN3I%2BwRwAumgC0vdA50h9l8%3D&amp;amp;reserved=0</a>
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
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

--------------8CA303F522B929A77534A467--

--===============1810584510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1810584510==--
