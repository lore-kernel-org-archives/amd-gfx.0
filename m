Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67140C3DA49
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Aug 2024 08:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CCAB10E9B1;
	Fri,  2 Aug 2024 08:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XUmzFVrD";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DFA810E9B1
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Aug 2024 08:30:14 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-428e3129851so10813135e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 02 Aug 2024 01:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722587412; x=1723192212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jDFMHzyewIoOpZDpgk+/wgKqvZvm4VhVGjIAU3I3z4E=;
 b=XUmzFVrDYspg+P0wask9/UmAuyTc4nQf24MjkioqMJAdOdUGaUbG+9n7epupVjM7OT
 i6dZ3N3GD1mkk8e0GWi0Z8aORYMVLYQM5x0fOLr87Z6zOvqg5uzrHxiOuy+BWK1XBfYs
 gIjRVPm3JkWhpGiMOr0W/o5y7ku/HMZ5y4SNjiTDIWQi86WkJvXaKwGYUscEVM+UBK7z
 QPf3+A6vSWEEs5/PTWk0nQ8ffg2cR/1zYM+8xCVlv/ogViAAr5wt8TLQN4//7mxK1AYm
 qVIa/kSH2gFDTLhVcJ22Jr1CQCgzbgGXHUaHr+jlJKOVvi59NbkGNCYZjAQ+KVi5NiS+
 QTSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722587412; x=1723192212;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jDFMHzyewIoOpZDpgk+/wgKqvZvm4VhVGjIAU3I3z4E=;
 b=u/mb7CNrd7jyqfjvnPAeMdf7p/aFGnUwc6Run8gM37L2rIelrD6vzW+UJnRa8ETtgA
 NJx1elQUWmcxJsR6tKUWRYijqWVjU8lEmSFRT/gwSIP999gaG71rqN5mphB4/W8oriNR
 URAWAuLOCbvGlNrmg8ldCnDYEDN3fLmmI7ue5gKz4zFMajAunpX59OTXea2bE1AT/uYo
 IVUB5qvA8IkrhLeRtAvA2fvDoH9GMNqxgOnEpRmYt1VI3X3z/w0zmQnfggmW3vPRacb9
 GrZAaD2toOnwAb+SWFxGzYED0yJTGBlKDqw540VW05JLRV1eVFvs7QhQZsHwB/kdZTK4
 8eiA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf0/rYCZDcpsA83NMx0G/hToRpRU1QNHdJw5JMBKs7HUuP6zbkDUA5K97EJELBoZCy4dOJ2VnmHa9dTIHaqSKPvhuOdSbjy4AFYwoLlw==
X-Gm-Message-State: AOJu0YxDvhK0VVYzVUZ7mRNNjbWBkNNheMLa4sKCGS2Sy3DJA1jchfvP
 8zvmQpUPrij5kKNcybvL4Jj9rDArsqluWC1VEYosNQLPp1R8bI+O
X-Google-Smtp-Source: AGHT+IFW5WdLmz7uruPbI37n2QHgfclR7n+YUA7F1btIGIUNebQWZc/IrYJ6b5x7PXaxxPlRHcb57A==
X-Received: by 2002:a05:600c:4ec6:b0:426:6960:34b0 with SMTP id
 5b1f17b1804b1-428e6afea7fmr16959445e9.14.1722587411424; 
 Fri, 02 Aug 2024 01:30:11 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89aa9esm85094135e9.2.2024.08.02.01.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 01:30:10 -0700 (PDT)
Message-ID: <c600abec-d16b-45d3-afe3-f10ba2fc8871@gmail.com>
Date: Fri, 2 Aug 2024 10:30:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: Forward soft recovery errors to userspace
To: Friedrich Vock <friedrich.vock@gmx.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org,
 "Olsak, Marek" <Marek.Olsak@amd.com>
Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 stable@vger.kernel.org
References: <20240307190447.33423-1-joshua@froggi.es>
 <d9632885-35da-4e4a-b952-2b6a0c38c35b@amd.com>
 <641ce39c-a6a6-4448-bb2a-9c12d2873c1c@gmx.de>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <641ce39c-a6a6-4448-bb2a-9c12d2873c1c@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 01.08.24 um 17:17 schrieb Friedrich Vock:
> Hi,
>
> I happened to come across an issue just now again where soft recovery
> fails to get reported to userspace properly, causing apps to submit
> hanging work in a loop (which ended up hanging the entire machine) - it
> seems like this patch never made it into amd-staging-drm-next. Given
> that it has a Reviewed-by and everything, was this just an oversight or
> are there some blockers to pushing it that I missed?
>
> If not, I'd be grateful if the patch could get merged.

Sorry that was my fault, I've forgotten about it because Alex usually 
picks up stuff for amd-staging-drm-next.

Thanks for the reminder, just pushed it.

Regards,
Christian.

>
> Thanks,
> Friedrich
>
> On 08.03.24 09:33, Christian König wrote:
>> Am 07.03.24 um 20:04 schrieb Joshua Ashton:
>>> As we discussed before[1], soft recovery should be
>>> forwarded to userspace, or we can get into a really
>>> bad state where apps will keep submitting hanging
>>> command buffers cascading us to a hard reset.
>>
>> Marek you are in favor of this like forever.  So I would like to request
>> you to put your Reviewed-by on it and I will just push it into our
>> internal kernel branch.
>>
>> Regards,
>> Christian.
>>
>>>
>>> 1:
>>> https://lore.kernel.org/all/bf23d5ed-9a6b-43e7-84ee-8cbfd0d60f18@froggi.es/ 
>>>
>>> Signed-off-by: Joshua Ashton <joshua@froggi.es>
>>>
>>> Cc: Friedrich Vock <friedrich.vock@gmx.de>
>>> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: André Almeida <andrealmeid@igalia.com>
>>> Cc: stable@vger.kernel.org
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> index 4b3000c21ef2..aebf59855e9f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>>> @@ -262,9 +262,8 @@ amdgpu_job_prepare_job(struct drm_sched_job
>>> *sched_job,
>>>       struct dma_fence *fence = NULL;
>>>       int r;
>>> -    /* Ignore soft recovered fences here */
>>>       r = drm_sched_entity_error(s_entity);
>>> -    if (r && r != -ENODATA)
>>> +    if (r)
>>>           goto error;
>>>       if (!fence && job->gang_submit)
>>

