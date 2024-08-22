Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE84C531DF
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Aug 2024 06:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDC5810E73E;
	Thu, 22 Aug 2024 06:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q22V/OQO";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38B8010E73F
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Aug 2024 06:24:48 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-428fb103724so8149445e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 23:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724307886; x=1724912686; darn=lists.freedesktop.org;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeNujMnjx8VMJMox/MSmugjzWmXohxIZaEVfcHNFG4M=;
 b=Q22V/OQOgb8i3nFfutX5jehMbXDE8xmb8Rgvg1Gh5ebxS7tDlKGgcPfcwaBLFew42Q
 rZYBehx2j2x3FFFM3sswG5mgL7ntzbyAuIGISu29irxkumHwsOTTbg66yvllItDNK2/9
 vJXa3sb9LXOcnaUjFQSizylo7wZa8s7Y6Oy9vuOduJzy55znSujVGKJE6QpfhaDSwyig
 i8H4ncJdtOC1s3pGxdCb/hw4olLEFLEH/M27UT18qjVcqNw80gKXG+0y/riSnn8qtVeV
 5lhi2cfoEzMrktR9q+cnOAXbQzwnOfZ+fkQemQF+kPGEQDP4eUjavTo9BtiVBD73hP3G
 bFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724307886; x=1724912686;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NeNujMnjx8VMJMox/MSmugjzWmXohxIZaEVfcHNFG4M=;
 b=WZJf5jt7rSR2poV4wXoA7AAuhfaRay0WPpQKY4cO/ni1+DQm383XYaNqW2yyVB6H2L
 C5obzfMHaR9zvGuluogPy1tuhNGtqdBTudvLWR0qxOnATx6Z9SXgZcVV5d/IEMdVvRRU
 o5Nkglia21jnqyRYQemQGmnOaTtupXFhfp3Ulgu3V9Y8Nkdx64aerr3s1+4r+nVV0FHT
 mW7slpmaIjYI78ZWDyRlrRmoOzRMuY+ip4N5rJHGRKopHJVTBNpMVZ6TsgflcnhmbUrW
 QvmOgoKdlLQ8oLHLGHkp9/vyOF1mxuD2J9q0VQPSsnDbBiebdjv2tNbP+25Aq857QjHC
 dgXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAc3NkVV3qw13uGF55Ba8SgFVyIknnuymISZzLhhNJzHn1FQ8JyDqRd1Dkf+1GyesE+SdDXUt0@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyiPJEChtYHc5arAEBTbpE8gTkoVbBM4MlYZas81sQRMdPj3apZ
 QvGk8ux0ngFJ7bfSY23hIYW4FPAsPSnmB2GL3/paapXXVlFfWLKY
X-Google-Smtp-Source: AGHT+IGQ4lXNnWNSwuIOy+Pbx1NuOQcKqs1SxZ4QRuSHe5L6M/khDyvOQ4jU8fH+VylozeREkdOoqw==
X-Received: by 2002:a05:600c:3b9c:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-42ac3899b27mr10843965e9.4.1724307885398; 
 Wed, 21 Aug 2024 23:24:45 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42abef815d2sm48264355e9.24.2024.08.21.23.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2024 23:24:44 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------KssTU6PGFyvD0mPNbu4phE30"
Message-ID: <e4cc2e51-4d2b-4130-b028-44794c25a30b@gmail.com>
Date: Thu, 22 Aug 2024 08:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/17] drm/amdgpu: Add infrastructure for Cleaner Shader
 feature
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20240815000501.1845226-1-alexander.deucher@amd.com>
 <20240815000501.1845226-3-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240815000501.1845226-3-alexander.deucher@amd.com>
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
--------------KssTU6PGFyvD0mPNbu4phE30
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Am 15.08.24 um 02:04 schrieb Alex Deucher:
> From: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
>
> The cleaner shader is used by the CP firmware to clean LDS and GPRs
> between processes on the CUs.
>
> This adds an internal API for GFX IP code to allocate and initialize the
> cleaner shader.
>
> Cc: Christian König<christian.koenig@amd.com>
> Cc: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam<srinivasan.shanmugam@amd.com>
> Suggested-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 35 +++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 14 ++++++++++
>   2 files changed, 49 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 9be8cafdcecc..4ed69fcfe9c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1416,3 +1416,38 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
>   	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
>   	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
>   }
> +
> +int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
> +				      unsigned int cleaner_shader_size)
> +{
> +	if (!adev->gfx.enable_cleaner_shader)
> +		return -EOPNOTSUPP;

It's probably better to not call the function in the first place instead 
of returning an error.

> +
> +	return amdgpu_bo_create_kernel(adev, cleaner_shader_size, PAGE_SIZE,
> +				       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
> +				       &adev->gfx.cleaner_shader_obj,
> +				       &adev->gfx.cleaner_shader_gpu_addr,
> +				       (void **)&adev->gfx.cleaner_shader_cpu_ptr);
> +}
> +
> +void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev)
> +{
> +	if (!adev->gfx.enable_cleaner_shader)
> +		return;
> +
> +	amdgpu_bo_free_kernel(&adev->gfx.cleaner_shader_obj,
> +			      &adev->gfx.cleaner_shader_gpu_addr,
> +			      (void **)&adev->gfx.cleaner_shader_cpu_ptr);
> +}
> +
> +void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
> +				    unsigned int cleaner_shader_size,
> +				    const void *cleaner_shader_ptr)
> +{
> +	if (!adev->gfx.enable_cleaner_shader)
> +		return;
> +
> +	if (adev->gfx.cleaner_shader_cpu_ptr && cleaner_shader_ptr)
> +		memcpy_toio(adev->gfx.cleaner_shader_cpu_ptr, cleaner_shader_ptr,
> +			    cleaner_shader_size);
> +}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index 6fe77e483bb7..5ff3ab7d429a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -444,6 +444,14 @@ struct amdgpu_gfx {
>   	uint32_t			*ip_dump_core;
>   	uint32_t			*ip_dump_compute_queues;
>   	uint32_t			*ip_dump_gfx_queues;
> +
> +	/* cleaner shader */
> +	struct amdgpu_bo		*cleaner_shader_obj;
> +	unsigned int                    cleaner_shader_size;
This is a parameter now and the member unused.

> +	u64				cleaner_shader_gpu_addr;
> +	void				*cleaner_shader_cpu_ptr;
> +	const void			*cleaner_shader_ptr;

> +	bool				enable_cleaner_shader;
Probably better to test if cleaner_shader_obj is allocated or not 
instead of having a separate bool.

Regards,
Christian.

>   };
>   
>   struct amdgpu_gfx_ras_reg_entry {
> @@ -545,6 +553,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>   		void *ras_error_status,
>   		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
>   				int xcc_id));
> +int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
> +				      unsigned int cleaner_shader_size);
> +void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
> +void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
> +				    unsigned int cleaner_shader_size,
> +				    const void *cleaner_shader_ptr);
>   
>   static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
>   {

--------------KssTU6PGFyvD0mPNbu4phE30
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">Am 15.08.24 um 02:04 schrieb Alex
      Deucher:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20240815000501.1845226-3-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">From: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>

The cleaner shader is used by the CP firmware to clean LDS and GPRs
between processes on the CUs.

This adds an internal API for GFX IP code to allocate and initialize the
cleaner shader.

Cc: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
Signed-off-by: Srinivasan Shanmugam <a class="moz-txt-link-rfc2396E" href="mailto:srinivasan.shanmugam@amd.com">&lt;srinivasan.shanmugam@amd.com&gt;</a>
Suggested-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 35 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 14 ++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 9be8cafdcecc..4ed69fcfe9c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1416,3 +1416,38 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 	device_remove_file(adev-&gt;dev, &amp;dev_attr_current_compute_partition);
 	device_remove_file(adev-&gt;dev, &amp;dev_attr_available_compute_partition);
 }
+
+int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
+				      unsigned int cleaner_shader_size)
+{
+	if (!adev-&gt;gfx.enable_cleaner_shader)
+		return -EOPNOTSUPP;</pre>
    </blockquote>
    <br>
    It's probably better to not call the function in the first place
    instead of returning an error.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20240815000501.1845226-3-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
+
+	return amdgpu_bo_create_kernel(adev, cleaner_shader_size, PAGE_SIZE,
+				       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT,
+				       &amp;adev-&gt;gfx.cleaner_shader_obj,
+				       &amp;adev-&gt;gfx.cleaner_shader_gpu_addr,
+				       (void **)&amp;adev-&gt;gfx.cleaner_shader_cpu_ptr);
+}
+
+void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev)
+{
+	if (!adev-&gt;gfx.enable_cleaner_shader)
+		return;
+
+	amdgpu_bo_free_kernel(&amp;adev-&gt;gfx.cleaner_shader_obj,
+			      &amp;adev-&gt;gfx.cleaner_shader_gpu_addr,
+			      (void **)&amp;adev-&gt;gfx.cleaner_shader_cpu_ptr);
+}
+
+void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
+				    unsigned int cleaner_shader_size,
+				    const void *cleaner_shader_ptr)
+{
+	if (!adev-&gt;gfx.enable_cleaner_shader)
+		return;
+
+	if (adev-&gt;gfx.cleaner_shader_cpu_ptr &amp;&amp; cleaner_shader_ptr)
+		memcpy_toio(adev-&gt;gfx.cleaner_shader_cpu_ptr, cleaner_shader_ptr,
+			    cleaner_shader_size);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6fe77e483bb7..5ff3ab7d429a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -444,6 +444,14 @@ struct amdgpu_gfx {
 	uint32_t			*ip_dump_core;
 	uint32_t			*ip_dump_compute_queues;
 	uint32_t			*ip_dump_gfx_queues;
+
+	/* cleaner shader */
+	struct amdgpu_bo		*cleaner_shader_obj;</pre>
    </blockquote>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite"
      cite="mid:20240815000501.1845226-3-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">+	unsigned int                    cleaner_shader_size;</pre>
    </blockquote>
    This is a parameter now and the member unused.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20240815000501.1845226-3-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	u64				cleaner_shader_gpu_addr;
+	void				*cleaner_shader_cpu_ptr;
+	const void			*cleaner_shader_ptr;</pre>
    </blockquote>
    <br>
    <blockquote type="cite"
      cite="mid:20240815000501.1845226-3-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
+	bool				enable_cleaner_shader;</pre>
    </blockquote>
    Probably better to test if cleaner_shader_obj is allocated or not
    instead of having a separate bool.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
      cite="mid:20240815000501.1845226-3-alexander.deucher@amd.com">
      <pre class="moz-quote-pre" wrap="">
 };
 
 struct amdgpu_gfx_ras_reg_entry {
@@ -545,6 +553,12 @@ void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		void *ras_error_status,
 		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
 				int xcc_id));
+int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
+				      unsigned int cleaner_shader_size);
+void amdgpu_gfx_cleaner_shader_sw_fini(struct amdgpu_device *adev);
+void amdgpu_gfx_cleaner_shader_init(struct amdgpu_device *adev,
+				    unsigned int cleaner_shader_size,
+				    const void *cleaner_shader_ptr);
 
 static inline const char *amdgpu_gfx_compute_mode_desc(int mode)
 {
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------KssTU6PGFyvD0mPNbu4phE30--
