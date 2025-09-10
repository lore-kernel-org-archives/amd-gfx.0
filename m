Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F892CA0FED
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 10:09:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F4B10E8AA;
	Wed, 10 Sep 2025 10:09:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin-net.20230601.gappssmtp.com header.i=@ursulin-net.20230601.gappssmtp.com header.b="xy6FWYvO";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA0F810E8AA
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 10:09:24 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-45dd7b15a64so4465895e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 03:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin-net.20230601.gappssmtp.com; s=20230601; t=1757498963; x=1758103763;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uOTuzZysV5kQ+YDTuaTugOko0DCUNkdlz/KqCUlCKRw=;
 b=xy6FWYvO/+vF1forqjCuQyLeOWKI4HgAmkfpC1V7dS7GhubeTVM74KnYHwoVegVkwT
 ThgGIJv0jMYEag1y3sRuC+E5GSFPaRaFUxotmKhPDLNMQrYrLYJ8mgya1r6SFAsjybKR
 k20o6RqPQzc7HektrMlNwLvhr4aekZjjakps9vnSQvGD1emczLqIL7PU3OQ1Gx9e1oXD
 MYV65JOTpkYMjQE326pbAq/fNKzWoxCbVp8PUldfoaANMEbg6MjUakocUmWcWzUkLbX0
 FlKFFE66LKgdgfYmkvNcQ5T/hLBs0U08mmFGBk6B+DF0LkzTc6oz9pGLoQoCOE7+XIea
 vuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757498963; x=1758103763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uOTuzZysV5kQ+YDTuaTugOko0DCUNkdlz/KqCUlCKRw=;
 b=rkRqfOAxikqkZ0ffi7G/SaAo6Wr2EYPG7DmV2NtFUJQuaBZVNz+iPLFXLZkd6zFlCc
 QG5OcP9MVo6iBRkp2U5ccnk/sMtJ7Io/dmBaqw4pRe+V80623Id18NRgAJQCPwZdQ3C0
 HbfrqWTFwIHr6ubgX+M9ml3HOnYCRrS0O+jwi5FRH3pFJOQE19qh7NZwZ8CX3AErUM+F
 DEKLWp2IgKFB+gnSaLv7m/rsqpJubWG2bPBlyDL0ZS+VOym7JwFzQEFZGHEqXB3jum/j
 CLg2LDgVSFof+10L4E+YLln2Rgf91FPr8waQIpwWwLWT9RWEAvEbF4AgET/U2Zmp9z5E
 4VUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyeN/indj0brV3p6rZP3IZJiNIndWccO7byzdM/+ABuBZOYJfRuOr2eRssHqB9reVrf2hJx+EV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/EDCqHqP139HuT118zPF/1y20ga3b6fwVp9ZnK8s2GwL76110
 H79uhtQwOYlU8XerIB7fOU7D1d1bnQgPBFyJT4+ber4IbYKvtsqFRvLjLizbIcLpchY=
X-Gm-Gg: ASbGnctRZgNFbeSzBYO4G8rHSgsidtQdt19YaExhL4Yt7jkDTq266Iepu2R9h8Z4i8s
 K8ywehldc/+v2SM7GQmnnHYBy+XzUtf9eOdgr5U5t2abGSfThPlA1ug9QGSnUGitpoT/5+F5PTz
 yLx8/kUWwjNf8euRliiO67Ziz6F9/+P30g6dJt+af2U7VkBeHZH8uvc9VTw32OvGA45mpEy9ndk
 OWpQB3rrwNo32gbaMEeSwQlFsxkCrwwfqaFcEhvmmMMJR2AD3k85n5RCZTvGPMYoFb8LC9gvxtl
 aF6d1DpPHCNGAHiHHShKlB6HPq2/H06TMrQ59WLqSUe55SkTVJEuHnxTbhFapqDniMyXw2wDEz/
 JpsuTRp80qGOUjTbfD0rdQKJrxEmFOreMxl8=
X-Google-Smtp-Source: AGHT+IEPG+lyxFIlIpxH80LQ7aYbGd+s/txpQcAp+CxqWZwvUkzOGr9U4ZUXp3PY2MRxFE9ROgpc0w==
X-Received: by 2002:a05:600c:c0c5:b0:45d:e531:99df with SMTP id
 5b1f17b1804b1-45de64869d9mr77361225e9.3.1757498962954; 
 Wed, 10 Sep 2025 03:09:22 -0700 (PDT)
Received: from [192.168.0.101] ([84.66.36.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45df82037c1sm22413075e9.9.2025.09.10.03.09.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Sep 2025 03:09:22 -0700 (PDT)
Message-ID: <d51e11fa-54b0-41f4-9b06-95b46094de39@ursulin.net>
Date: Wed, 10 Sep 2025 11:09:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Replace kzalloc + copy_from_user with
 memdup_user
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20250908211559.519892-1-thorsten.blum@linux.dev>
 <4005498b-d866-4e41-a8a4-d8228b2062e7@ursulin.net>
 <CADnq5_NDrq_S7rcpr6_MY-USfVGr8-QcJ2hqnai7VEm5D_OyxQ@mail.gmail.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <CADnq5_NDrq_S7rcpr6_MY-USfVGr8-QcJ2hqnai7VEm5D_OyxQ@mail.gmail.com>
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


On 09/09/2025 14:36, Alex Deucher wrote:
> On Tue, Sep 9, 2025 at 4:17 AM Tvrtko Ursulin <tursulin@ursulin.net> wrote:
>>
>>
>> On 08/09/2025 22:15, Thorsten Blum wrote:
>>> Replace kzalloc() followed by copy_from_user() with memdup_user() to
>>> improve and simplify ta_if_load_debugfs_write() and
>>> ta_if_invoke_debugfs_write().
>>>
>>> No functional changes intended.
>>>
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 20 ++++++--------------
>>>    1 file changed, 6 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>> index 38face981c3e..6e8aad91bcd3 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
>>> @@ -171,13 +171,9 @@ static ssize_t ta_if_load_debugfs_write(struct file *fp, const char *buf, size_t
>>>
>>>        copy_pos += sizeof(uint32_t);
>>>
>>> -     ta_bin = kzalloc(ta_bin_len, GFP_KERNEL);
>>> -     if (!ta_bin)
>>> -             return -ENOMEM;
>>> -     if (copy_from_user((void *)ta_bin, &buf[copy_pos], ta_bin_len)) {
>>> -             ret = -EFAULT;
>>> -             goto err_free_bin;
>>> -     }
>>> +     ta_bin = memdup_user(&buf[copy_pos], ta_bin_len);
>>> +     if (IS_ERR(ta_bin))
>>> +             return PTR_ERR(ta_bin);
>>>
>>>        /* Set TA context and functions */
>>>        set_ta_context_funcs(psp, ta_type, &context);
>>> @@ -327,13 +323,9 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
>>>                return -EFAULT;
>>>        copy_pos += sizeof(uint32_t);
>>>
>>> -     shared_buf = kzalloc(shared_buf_len, GFP_KERNEL);
>>> -     if (!shared_buf)
>>> -             return -ENOMEM;
>>> -     if (copy_from_user((void *)shared_buf, &buf[copy_pos], shared_buf_len)) {
>>> -             ret = -EFAULT;
>>> -             goto err_free_shared_buf;
>>> -     }
>>> +     shared_buf = memdup_user(&buf[copy_pos], shared_buf_len);
>>> +     if (IS_ERR(shared_buf))
>>> +             return PTR_ERR(shared_buf);
>>>
>>>        set_ta_context_funcs(psp, ta_type, &context);
>>>
>>
>> More complete than the one I sent in June^1.
> 
> I never received this series.  I didn't see it in patchwork either.
> Seems it never made it to amd-gfx.  Sorry I missed it. I've applied
> the applicable patches now.

Thank you and no worries, it wasn't anything urgent.

Regards,

Tvrtko
