Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65F8C83F0A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Jul 2025 11:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54F6C10E0B9;
	Tue,  8 Jul 2025 11:52:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="ISTuOBWX";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28F610E0B9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Jul 2025 11:52:03 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-450cf0120cdso36600005e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Jul 2025 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1751975522; x=1752580322;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wFnlzrd5NXabsHPg1wjU/KKowUNs+KLtHbpJ8rkv/x8=;
 b=ISTuOBWX5fRehJy7leiJ13I6DjdgZenlWv7qwfq0/clDZHkT8Szdoo/v1vOwyCyn0N
 k/CvMLZ0DsrwzdslJUqSj7hGP6VJzHPI0rdQCIfFI/tATHKqitHhqaPjy/a4c//M5NSP
 WVoQwbwuQyH5sg23THGcSbyBvu+n6i7v8jxUHxjmgueuxDPGXKxqEXSLTwjHQnwEJBVj
 Wx/wXD0d1RcwOrNZdbHdjPobmqqPNtM89ChjR2VjkcRXZk9h8MtAhlAXm36Jn7xWKRJx
 JL6PVs+6BiKRhDlmWbTIjsxuP48NDURsLxJAfCOeirGJEhJbXs+pwojXVPpymvmZU9G4
 +E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751975522; x=1752580322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wFnlzrd5NXabsHPg1wjU/KKowUNs+KLtHbpJ8rkv/x8=;
 b=iFTKbIPMi0oGEeN38tKtqwktamVecJHzY7ZJ3e6uaITJRzF8B3bTMr/313MywVtN7I
 jFfW57ZVmBmkeoMidMmyj9GpLDlzucie1T5ikX7cXVbw/Uktj7HjMauWtOMsUq1yqkHX
 ht5kodr5/BEVOJsJL5ZOgUL5oLQP8J6DpkY2qvjjFFe45jv0WpSJQ8gvaHN63XLtufDe
 9aD2PhO25fLddDHkSRUGerdf38CYmEeWtzcFT5hJN/IJm21tq7EXCSzpW3iS6B7yeZE3
 PSjfaaaX4U1K3cpg+jA4vCoqoHnb4/2WhBUyzA3YgFlTH7vI+Xjlyo7UMR9+0Ur+Uwjc
 9mxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW031MuZwOEpUWIB87KnJ76cHePGTOqrWKQh3MqA4SC/2Y6xOOGS8L2p4i6m6097nFxCvnQTjuQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQDRNz6Z8rWpUkK+rnJxBEsPpsoKPLnOitou/tYdYI1RBUFNbi
 IGH9GLFq5awxgN6gC9n+iKnt0MuDmRWVCK8heEVfFC31EiQfDge1Eiy2MT/WQoZepHs=
X-Gm-Gg: ASbGncurN6GGJKcMrotW1UKI0c/8tGshzr/ZXCosTcnkXfIk41IhUQSqmnxR3E7e/TI
 O8y2k3bUZ3QmdOMfB2jqOrNtEgMtpoVTdHB0U5v5yz0GEzV0FJh65Mv0E1YILkPJBlW5LVPCsKo
 NgMbRtwPFd7Sdu+CLZDy5mIBHLTTg4lJqCGsfi7O4vS5a+PBZu3BBr8k6AKplWXOceBe/xzidWa
 yJaYo/JX30O2uU0cEUZOhlbQQ45O4pRutjJGkLhu8jJttsojzaZkUcKzLdIwpPctIOF/r8T6PwJ
 l/WacC+O5b0+i98pFHYXHCRtXnug/BvztThsI6yYCGvavHgvcwG70ygjX2m1iorFfuyEtz2ClIu
 f
X-Google-Smtp-Source: AGHT+IEuy/Js79OELkEMoVsLW6cXgPt2qbI9DZdo1ofEZpPgLVfu5IuC0tbJAYBepgNgLiv4nhVi+A==
X-Received: by 2002:a05:600c:1c8d:b0:43d:aed:f7d0 with SMTP id
 5b1f17b1804b1-454c6b33dc9mr52681645e9.28.1751975522185; 
 Tue, 08 Jul 2025 04:52:02 -0700 (PDT)
Received: from [192.168.0.101] ([84.65.48.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47040161bsm12650432f8f.4.2025.07.08.04.52.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 04:52:01 -0700 (PDT)
Message-ID: <581c47ea-9ff9-46ca-b693-0ac7862dcec4@ursulin.net>
Date: Tue, 8 Jul 2025 12:52:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Use memdup_user & co where applicable
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20250612104430.41169-1-tvrtko.ursulin@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20250612104430.41169-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 12/06/2025 11:44, Tvrtko Ursulin wrote:
> Replace some allocate + copy_from_user patterns with dedicated helpers.
> 
> This shrinks the source code and is also good for security due SLAB bucket
> separation between the kernel and uapi.

Any takers for easy reviews?

Regards,

Tvrtko

> Tvrtko Ursulin (4):
>    drm/amdgpu: Use vmemdup_array_user in
>      amdgpu_bo_create_list_entry_array
>    drm/amdgpu: Use memdup_array_user in amdgpu_cs_wait_fences_ioctl
>    drm/amdgpu: Use (v)memdup_array_user in amdgpu_cs_pass1
>    drm/amdgpu: Use memdup_user in ta_if_load_debugfs_write
> 
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 41 +++++++---------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 52 ++++++---------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c  | 14 ++----
>   3 files changed, 37 insertions(+), 70 deletions(-)
> 

