Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1727EC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Apr 2024 06:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6429C113121;
	Tue, 23 Apr 2024 06:09:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mcZMBo7r";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC0E6113121
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Apr 2024 06:09:41 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-417e327773cso33868735e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 23:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713852580; x=1714457380; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=DgxZASb/Oi7AKcLkPgCin4plhQSzAWZ0lIdTIfT6oEg=;
 b=mcZMBo7rl1OP2NFYDD5ikIvcHewN9Ze23S8v5rKS8V7LUG6hPmpGGxABVZjuqW5C5p
 tmqk6AknEFPuBKe9kb6t4P9jpKAl2smt3ZicCZcXkK4zz+vx0PaWrnCMu3UytjEt0YXb
 nSkX10DbTeem2meO6Hn4Xn2IZQbjzWl7LADI1z5K5fK1fPy+m3RXrHK5IfqtfRHBv4aR
 Ip1VtdnFY60CaEIqUqnXUx3kgkF6syMY//tvLa33IRYtzIr7M3kZ2NC1ff95slmO/r6O
 dmvzH9bRoVq0cyS6MTryE4BOP4q1h5PHbMfzdLYzts5V+Vo21p0fpeI7rRWwJtLrfXLd
 +SkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713852580; x=1714457380;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DgxZASb/Oi7AKcLkPgCin4plhQSzAWZ0lIdTIfT6oEg=;
 b=OuXcFCSSGN6+PRV8Z3ARHa0iHL7kq9+mKvhVwzx4lj0qPZbrSZ7zuzN1IES0k5LZmV
 kAC7v7tZ7Y6d4LvHMnbvHG35LNbZJkW/GHRTLxiqzQqQnTjAByM7wogANFSXYyoRbUVZ
 s+KOHylL4Nxitjzu+rQANKDGNOB7CuJgiXoCNS2v8C93/B06bpD+oczUl5ehNkC7TCIb
 WCQQITUvKNcmwyd9bXEwjC+gY4VwNfhgmqiBVEImdCycI68meZxqhANNGUzmIMeKeEY2
 Gv2LB6+Bs5Eq08rqJg3oAWteF1hh+gph8Ejt9xFajp1a+dwuqfYeSWffErTYjGebcFw5
 Ozew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXH4gy2mG+g0K3kzo0rCTpNddDHw7qZyjYHx9YhYS0/e5oq65buwmuo7U0Uj36geLfu5KArJsy+Q1/ATzpT6Cn+KJf5IPDviq8w5ysfkQ==
X-Gm-Message-State: AOJu0YxjsJDiFcMWlP1x0hfnYUVGlehBDeT8iImiq09kUvD8cjqGbBBK
 4cIWLKGFr+YzoI6DSY5mvQeqedtaOFt12d9wScg7TNu93g2oDpCA
X-Google-Smtp-Source: AGHT+IHnCokuP6hQ00TwBrCPVi2SNx7ZMb95uNNu09WJpmD5YTIc0JMNkQoAEXggAnVwfDsrdLTF0g==
X-Received: by 2002:a05:600c:1f0b:b0:418:fd17:26a6 with SMTP id
 bd11-20020a05600c1f0b00b00418fd1726a6mr1073818wmb.0.1713852579896; 
 Mon, 22 Apr 2024 23:09:39 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a05600c310900b0041aa79f27a0sm1766074wmo.38.2024.04.22.23.09.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 23:09:39 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------RbAlE3kEpHs0rT5brpmzu3XX"
Message-ID: <35970d62-692c-4e4c-919f-094a6f06490e@gmail.com>
Date: Tue, 23 Apr 2024 08:09:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Fix Uninitialized scalar variable warning
To: "Ma, Jun" <majun@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
References: <20240422094908.537208-1-Jun.Ma2@amd.com>
 <20240422094908.537208-3-Jun.Ma2@amd.com>
 <3303e24e-d423-47f7-aa01-62fb7a1bed87@amd.com>
 <1cae725a-412d-4b28-b5a1-705e55157983@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <1cae725a-412d-4b28-b5a1-705e55157983@amd.com>
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
--------------RbAlE3kEpHs0rT5brpmzu3XX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.04.24 um 04:53 schrieb Ma, Jun:
>>>    	unsigned int client_id, src_id;
>>>    	struct amdgpu_irq_src *src;
>>>    	bool handled = false;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> index 924baf58e322..f0a63d084b4d 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>>> @@ -1559,7 +1559,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
>>>    {
>>>    	struct amdgpu_device *adev = m->private;
>>>    	struct drm_amdgpu_info_firmware fw_info;
>>> -	struct drm_amdgpu_query_fw query_fw;
>>> +	struct drm_amdgpu_query_fw query_fw = {0};
> Coverity warning:
> uninit_use_in_call Using uninitialized value query_fw.index when calling amdgpu_firmware_info
>
> Even though qeuery_fw.index was assigned a value before it's used, there is still an coverity warning.
> We need to initialize query_fw when declare it.

But initializing it to zero doesn't sounds correct either.

The amdgpu_firmware_info() function is designed to return the FW info 
for a specific block, if the block isn't specified than coverity is 
right that we have a coding error here.

Just initializing the value silences coverity but is most likely not the 
right thing to do.

Regards,
Christian.

>
>>>    	struct atom_context *ctx = adev->mode_info.atom_context;
>>>    	uint8_t smu_program, smu_major, smu_minor, smu_debug;
>>>    	int ret, i;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> index 2b99eed5ba19..41ac3319108b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
>>> @@ -120,7 +120,7 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
>>>    int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
>>>    {
>>>    	struct amdgpu_device *adev = xcp_mgr->adev;
>>> -	struct amdgpu_xcp_ip ip;
>>> +	struct amdgpu_xcp_ip ip = {0};
> Coverity Warning:
> Using uninitialized value ip. Field ip.valid is uninitialized when calling __amdgpu_xcp_add_block
>
> The code is ok. We just need to initialize the variable ip.
>
> Regards,
> Ma Jun
>
>
>>>    	uint8_t mem_id;
>>>    	int i, j, ret;
>>>    

--------------RbAlE3kEpHs0rT5brpmzu3XX
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 23.04.24 um 04:53 schrieb Ma, Jun:<br>
    <blockquote type="cite"
      cite="mid:1cae725a-412d-4b28-b5a1-705e55157983@amd.com"><span
      style="white-space: pre-wrap">
</span>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">  	unsigned int client_id, src_id;
  	struct amdgpu_irq_src *src;
  	bool handled = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 924baf58e322..f0a63d084b4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1559,7 +1559,7 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
  {
  	struct amdgpu_device *adev = m-&gt;private;
  	struct drm_amdgpu_info_firmware fw_info;
-	struct drm_amdgpu_query_fw query_fw;
+	struct drm_amdgpu_query_fw query_fw = {0};
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
Coverity warning:
uninit_use_in_call Using uninitialized value query_fw.index when calling amdgpu_firmware_info

Even though qeuery_fw.index was assigned a value before it's used, there is still an coverity warning.
We need to initialize query_fw when declare it.</pre>
    </blockquote>
    <br>
    But initializing it to zero doesn't sounds correct either.<br>
    <br>
    The amdgpu_firmware_info() function is designed to return the FW
    info for a specific block, if the block isn't specified than
    coverity is right that we have a coding error here.<br>
    <br>
    Just initializing the value silences coverity but is most likely not
    the right thing to do.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:1cae725a-412d-4b28-b5a1-705e55157983@amd.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">  	struct atom_context *ctx = adev-&gt;mode_info.atom_context;
  	uint8_t smu_program, smu_major, smu_minor, smu_debug;
  	int ret, i;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index 2b99eed5ba19..41ac3319108b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -120,7 +120,7 @@ static void __amdgpu_xcp_add_block(struct amdgpu_xcp_mgr *xcp_mgr, int xcp_id,
  int amdgpu_xcp_init(struct amdgpu_xcp_mgr *xcp_mgr, int num_xcps, int mode)
  {
  	struct amdgpu_device *adev = xcp_mgr-&gt;adev;
-	struct amdgpu_xcp_ip ip;
+	struct amdgpu_xcp_ip ip = {0};
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">Coverity Warning:
Using uninitialized value ip. Field ip.valid is uninitialized when calling __amdgpu_xcp_add_block

The code is ok. We just need to initialize the variable ip.

Regards,
Ma Jun


</pre>
      <blockquote type="cite">
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">  	uint8_t mem_id;
  	int i, j, ret;
  
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">
</pre>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------RbAlE3kEpHs0rT5brpmzu3XX--
