Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84619C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Mar 2023 09:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2577E10E5C1;
	Wed,  8 Mar 2023 09:10:25 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72EC10E5C1;
 Wed,  8 Mar 2023 09:10:23 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id k10so38943680edk.13;
 Wed, 08 Mar 2023 01:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1678266622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=motbEo3NY6mz81D1y0KA7IQCNZEkkbhCWQoBlwAGzho=;
 b=eZI3iwUggAzDYYSxhTJwvcrSMoW+xzU7eHbJRQhiHcPmwowxvZyvcpoZhhV5Og4lJD
 NKsBTisfG1ofmTLyhmAveDnX3i8nVSwIgLNNtEdZ2q/GZz9CqeeGzMTWrp1vwymQsbgi
 YaV7FJ0vEzEfZ71bp+kNU9GQpCHBE3ttyChliSU+60J7V52OFmzpSsv083AkoHlJbn+O
 6I6BUvGY7E4rAfjqdJRDk9YHuE4/IXRDndzAJvgKOAl+0zMOIDvDk8otTzCyYQ3LWvZw
 UmJTy3NmX+oQKwAEKfEnFGzvGU9QI9YX9cH2o9ymiANIl8FWsGbz05ELsiiHetfpdgBQ
 GZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678266622;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=motbEo3NY6mz81D1y0KA7IQCNZEkkbhCWQoBlwAGzho=;
 b=rt1oVyHgZ8hNrRTML256ZiyhC2h0gKCBkwBTvzLEKg4m8zlTGfXBoObh73jHnpS7Wv
 FaI/CvFQqsPCmRQojmoc7aCdr+VFMzNhmf8vYYOes75a9D5xRH08hzczdqOMTJ84L3JF
 HUsVMGWxolBjlBHCiPkq8EKpn7NSTQyTEshPcHizNb+zjqtsVUoAkrROGwDc+bGBaDew
 gZQeYccfIhFikThIm9NtIxmbmlDSoWHl6H3AqZs3q587gGol447hqfXyvad2HBB/wstt
 8CFLfwzyfF2Evaeh1mfR+j17OMEFaI7EAT6YoK5Q7K5IPwMbJRJnL2i9FneHLqy650GA
 TIAA==
X-Gm-Message-State: AO0yUKU43rWmbwrfyzOw7Sc/p6w51hngzrM3jDXxd7QjXVzQxiji3C5y
 IAvjt71v5IVvUplbZoxzuAk=
X-Google-Smtp-Source: AK7set/kgopdSIQ0DTRZY/nQjjK7esGlN3bsq+wWKCESF5S+lh5CRex0X9Hj7hiv+eVUpF7RwN0c4g==
X-Received: by 2002:a05:6402:8d1:b0:4af:60c1:1961 with SMTP id
 d17-20020a05640208d100b004af60c11961mr17084363edz.23.1678266622027; 
 Wed, 08 Mar 2023 01:10:22 -0800 (PST)
Received: from ?IPV6:2a02:908:1256:79a0:423c:7396:17af:cdf?
 ([2a02:908:1256:79a0:423c:7396:17af:cdf])
 by smtp.gmail.com with ESMTPSA id
 20-20020a508e54000000b004d8d2735251sm5834286edx.43.2023.03.08.01.10.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Mar 2023 01:10:21 -0800 (PST)
Message-ID: <6933b07b-af79-5350-b161-12ee73732b30@gmail.com>
Date: Wed, 8 Mar 2023 10:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 9/9] drm: move ttm_execbuf_util into vmwgfx
Content-Language: en-US
To: Zack Rusin <zackr@vmware.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20230228083406.1720795-1-christian.koenig@amd.com>
 <20230228083406.1720795-10-christian.koenig@amd.com>
 <b4beeee4b2a004938adc6c502443f7b3311aad50.camel@vmware.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <b4beeee4b2a004938adc6c502443f7b3311aad50.camel@vmware.com>
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
Cc: "dakr@redhat.com" <dakr@redhat.com>,
 "arunpravin.paneerselvam@amd.com" <arunpravin.paneerselvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 08.03.23 um 06:14 schrieb Zack Rusin:
> On Tue, 2023-02-28 at 09:34 +0100, Christian König wrote:
>> VMWGFX is the only remaining user of this and should probably moved over
>> to drm_exec when it starts using GEM as well.
> Is this because vmwgfx piggybacks buffer-id relocations on top of ttm validations or
> did you just find it too hard to port it over? I'd prefer to avoid ttm moves to
> vmwgfx and at least have a clear idea of what we need to do to port.

I've just found it to hard to port it over because vmwgfx does some 
strange things with the validation code here.

If you want we can take a deeper look at this together, but I need to 
find some time.

Alternatively just tell me how to do it and I will add that to the patch 
set :)

Regards,
Christian.

>
> z

