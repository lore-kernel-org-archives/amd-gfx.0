Return-Path: <SRS0=SMOw=MZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0798C4338F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 07:57:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B75160FF2
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Aug 2021 07:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B75160FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53F626E1F4;
	Mon,  2 Aug 2021 07:57:02 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30C016E171;
 Mon,  2 Aug 2021 02:47:31 +0000 (UTC)
Received: by mail-pj1-x1031.google.com with SMTP id
 mz5-20020a17090b3785b0290176ecf64922so29414777pjb.3; 
 Sun, 01 Aug 2021 19:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=XGbL8VwPWjiS4yy4Pnm/5ti4pl6SnxB74geqfXf2DB8=;
 b=LT7iIak5S9eMVKEPZD7f0f9GaeTpf9fgxki9F73OG5+doNYssSWZ0f3lw9FdaLyodW
 H+VftdRCAibeNawcMs/+wyMV07jxOnbL2d85GMVLWLny7/IBriAfc+cOb+mHA6nW71Sx
 +5e9Xv+cfGX0tEiE7nHyJMElLi5Km8LSwGXHcZwBfY9cpcGfgAR2+q2AjdJQ1aNq95mA
 ewqlpUaBT5mu9mYGHzlsh+9ZPR9mbnKe/5Nn193sVNPYJMVvCowTFjQMzJcfWdZF/BM9
 ebe+OlZy1qPrEgPHdxuZBs0OXp5M+PrN3KdfC165JaM+goeJQfUbsVmboOQDq396IF8R
 8SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=XGbL8VwPWjiS4yy4Pnm/5ti4pl6SnxB74geqfXf2DB8=;
 b=mLAKxHmAtYhpg5xQfh1Lox5Fv/VxXzR11NbUfx0vipc2JBu5XJM5+6ToaBqnh2ssGZ
 92agpcz5EbFfWfoj1whRqvo5nkJMfajaGpr9akisf3ylk859f5FOWFd4zM7+ppoKslIE
 fYKOzPaw90BrPdSdRcjfEdwNSHjCXfH47kqEEw/AiyGpBfBgILJrzt1b2kcUOGCCbreW
 Y6vYwMG4eLsHPJYWYlDE1yY879nQxoq6OIZ98rq/cZX83hv949LUSKMCMMAPS4gFYrjr
 xZui2/Tl7ZjGiGOsJ3m9knuPYNBUZBZw52cUTdbaYi6RiHkawrw0AnzXj5DeABANnB6R
 LYcg==
X-Gm-Message-State: AOAM533zG5MxqlOCsms93MKvuF7aSQmMM+fgRlx1iUO7dcWQaJ8LdeOQ
 4WgNpJb4fBoK2YkeUR5rlkI=
X-Google-Smtp-Source: ABdhPJxgLjle+X21msmkhScpohfSjneeqWivm7M3aHQYJvRXfoBdbPMfQOdSLJPQMzM3M/tZB5hKow==
X-Received: by 2002:a17:903:20c1:b029:12c:4a37:5cbb with SMTP id
 i1-20020a17090320c1b029012c4a375cbbmr12001050plb.57.1627872450825; 
 Sun, 01 Aug 2021 19:47:30 -0700 (PDT)
Received: from [10.106.0.86] ([45.135.186.29])
 by smtp.gmail.com with ESMTPSA id l14sm9517229pfd.58.2021.08.01.19.47.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Aug 2021 19:47:30 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: fix possible null-pointer dereference in
 amdgpu_ttm_tt_populate()
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@linux.ie, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, Xinhui.Pan@amd.com, baijiaju1990@gmail.com,
 alexander.deucher@amd.com, Philip.Yang@amd.com,
 TOTE Robot <oslab@tsinghua.edu.cn>, sumit.semwal@linaro.org,
 daniel@ffwll.ch, Felix.Kuehling@amd.com, airlied@redhat.com,
 Oak.Zeng@amd.com, nirmoy.das@amd.com, tzimmermann@suse.de
References: <20210731080437.74539-1-islituo@gmail.com>
 <53ef6ff7-f793-5de4-4ab4-0efbfbfc0a54@amd.com>
From: Li Tuo <islituo@gmail.com>
Message-ID: <fc060208-89b5-51aa-c956-adf7c42d6b79@gmail.com>
Date: Mon, 2 Aug 2021 10:47:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <53ef6ff7-f793-5de4-4ab4-0efbfbfc0a54@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailman-Approved-At: Mon, 02 Aug 2021 07:57:01 +0000
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

Thanks for your feedback! We will remove the null tests according to 
your advice and prepare a V2 patch.

Best wishes,
Tuo Li

On 2021/8/2 1:19, Christian König wrote:
> Am 31.07.21 um 10:04 schrieb Tuo Li:
>> The variable ttm is assigned to the variable gtt, and the variable gtt
>> is checked in:
>>    if (gtt && gtt->userptr)
>>
>> This indicates that both ttm and gtt can be NULL.
>> If so, a null-pointer dereference will occur:
>>    if (ttm->page_flags & TTM_PAGE_FLAG_SG)
>>
>> Also, some null-pointer dereferences will occur in the function
>> ttm_pool_alloc() which is called in:
>>    return ttm_pool_alloc(&adev->mman.bdev.pool, ttm, ctx);
>>
>> To fix these possible null-pointer dereferences, the function returns
>> -EINVAL when ttm is NULL.
>
> NAK, the NULL test is just a leftover from when the objects where 
> distinct.
>
> Please remove the NULL test instead.
>
> Regards,
> Christian.
>
>>
>> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
>> Signed-off-by: Tuo Li <islituo@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 3a55f08e00e1..80440f799c09 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -1120,8 +1120,11 @@ static int amdgpu_ttm_tt_populate(struct 
>> ttm_device *bdev,
>>       struct amdgpu_device *adev = amdgpu_ttm_adev(bdev);
>>       struct amdgpu_ttm_tt *gtt = (void *)ttm;
>>   +    if (ttm == NULL)
>> +        return -EINVAL;
>> +
>>       /* user pages are bound by amdgpu_ttm_tt_pin_userptr() */
>> -    if (gtt && gtt->userptr) {
>> +    if (gtt->userptr) {
>>           ttm->sg = kzalloc(sizeof(struct sg_table), GFP_KERNEL);
>>           if (!ttm->sg)
>>               return -ENOMEM;
>

