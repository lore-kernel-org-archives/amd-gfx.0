Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5DECC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 11:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5E8F10E56C;
	Mon, 28 Feb 2022 11:46:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA44010E3DF
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Feb 2022 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645972600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWBd2uqezPG2fToqHlW/A1scR+v8Ogo7G12uSyyLcCQ=;
 b=dlF3G6ngadW3gVNc/Uf9aCEWz2FEk8ELZhRNdjhWxbc7rkzNleYeG4o3iIjNQ/Ol5LUZDx
 ItWXIWjekRTXLY81hgL+KIL45oDT1KvnZbvBvXYFxtocgiuaXtu/JHuKPPeONckf7jdDqB
 j148NZztKeat/CSIE7cPGrtY4oXbGAA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-l2RGGvqtNf6Rsi-SVGs4kw-1; Sun, 27 Feb 2022 09:36:37 -0500
X-MC-Unique: l2RGGvqtNf6Rsi-SVGs4kw-1
Received: by mail-qv1-f71.google.com with SMTP id
 jr12-20020a0562142a8c00b0042d7901650cso9905653qvb.17
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Feb 2022 06:36:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qWBd2uqezPG2fToqHlW/A1scR+v8Ogo7G12uSyyLcCQ=;
 b=cC0KsvaAEt07nDVcedAZHT281ZtumtZpmqyWEO0BQjJi8GLCFw72TBKVKCSUdsX4Ui
 Jx55CumMQFBxottnrDjTa30zIEz1BZp3WhbRHo706W0aL23Wqbvq9qH0aij/h6tXLl3f
 se/pa83mWL5AJogEoc8WByxzkMm/kgWiikLRD4mSEU8dzd6nWpe72+xueZ79Khlq0oHK
 u8PYTR13hT2Wiq7nF9MhKG4GieqhyjDPQblKdxSdMdH7OXM3NHgBU1irdlGEwwIhOjwO
 LNsVzJ+LpPEfXfVMdWrtc2bwkVVlcr2xuD5K2NtTL79acG54rCqFQ5S6mU38Z1Qo0M4j
 N9FQ==
X-Gm-Message-State: AOAM532Le50bhT6kKP1jlGrM1kZ/LWo7GaIzuSibs+fqcLnHnEDb7Tau
 pDrp9kCrUd5q0XlIESwECzhlEGAcW7onELiEyB8J7pOPuXGOggcxhCmYUgJxaEPQ8N1YsSC/jOu
 tvYAIQI+2KSI7WYYRcSj/3VG0VQ==
X-Received: by 2002:ae9:e019:0:b0:648:f1d0:5a6b with SMTP id
 m25-20020ae9e019000000b00648f1d05a6bmr9072847qkk.403.1645972596680; 
 Sun, 27 Feb 2022 06:36:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxdiTObBYWNwgLyr7HxQB9rQWsfgRx6OEQV9Wzfl34xTDHCFV8xS44GTKugd4k/6bgusrhUYg==
X-Received: by 2002:ae9:e019:0:b0:648:f1d0:5a6b with SMTP id
 m25-20020ae9e019000000b00648f1d05a6bmr9072825qkk.403.1645972596417; 
 Sun, 27 Feb 2022 06:36:36 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com.
 [24.205.208.113]) by smtp.gmail.com with ESMTPSA id
 d186-20020a379bc3000000b006490a4e507esm3831221qke.70.2022.02.27.06.36.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Feb 2022 06:36:35 -0800 (PST)
Subject: Re: [PATCH] drm/amdgpu: Fix realloc of ptr
To: David Laight <David.Laight@ACULAB.COM>,
 "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>,
 "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
 "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "nathan@kernel.org" <nathan@kernel.org>,
 "ndesaulniers@google.com" <ndesaulniers@google.com>,
 "nirmoy.das@amd.com" <nirmoy.das@amd.com>,
 "lijo.lazar@amd.com" <lijo.lazar@amd.com>,
 "tom.stdenis@amd.com" <tom.stdenis@amd.com>,
 "evan.quan@amd.com" <evan.quan@amd.com>,
 "kevin1.wang@amd.com" <kevin1.wang@amd.com>,
 "Amaranath.Somalapuram@amd.com" <Amaranath.Somalapuram@amd.com>
References: <20220226155851.4176109-1-trix@redhat.com>
 <f863c19ccba34e50802836bcb3b0b622@AcuMS.aculab.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <a857b5ec-8a6c-9c84-0525-33155261dd41@redhat.com>
Date: Sun, 27 Feb 2022 06:36:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <f863c19ccba34e50802836bcb3b0b622@AcuMS.aculab.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailman-Approved-At: Mon, 28 Feb 2022 11:46:19 +0000
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
Cc: "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2/26/22 2:21 PM, David Laight wrote:
> From: trix@redhat.com
>> Sent: 26 February 2022 15:59
>>
>> From: Tom Rix <trix@redhat.com>
>>
>> Clang static analysis reports this error
>> amdgpu_debugfs.c:1690:9: warning: 1st function call
>>    argument is an uninitialized value
>>    tmp = krealloc_array(tmp, i + 1,
>>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
>> realloc will free tmp, so tmp can not be garbage.
>> And the return needs to be checked.
> Are you sure?
> A quick check seems to show that krealloc() behaves the same
> way as libc realloc() and the pointer isn't freed on failure.

I suck, I'll respin the patch

Thanks

Tom

>
> 	David
>
>> Fixes: 5ce5a584cb82 ("drm/amdgpu: add debugfs for reset registers list")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 9eb9b440bd438..159b97c0b4ebc 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1676,7 +1676,7 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>   {
>>   	struct amdgpu_device *adev = (struct amdgpu_device *)file_inode(f)->i_private;
>>   	char reg_offset[11];
>> -	uint32_t *tmp;
>> +	uint32_t *tmp = NULL;
>>   	int ret, i = 0, len = 0;
>>
>>   	do {
>> @@ -1688,6 +1688,10 @@ static ssize_t amdgpu_reset_dump_register_list_write(struct file *f,
>>   		}
>>
>>   		tmp = krealloc_array(tmp, i + 1, sizeof(uint32_t), GFP_KERNEL);
>> +		if (!tmp) {
>> +			ret = -ENOMEM;
>> +			goto error_free;
>> +		}
>>   		if (sscanf(reg_offset, "%X %n", &tmp[i], &ret) != 1) {
>>   			ret = -EINVAL;
>>   			goto error_free;
>> --
>> 2.26.3
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

