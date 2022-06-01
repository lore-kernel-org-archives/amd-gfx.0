Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536F9CCA473
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jun 2022 14:59:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7EF010E999;
	Wed,  1 Jun 2022 14:59:14 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20F1710E999
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jun 2022 14:59:14 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id u3so2743805wrg.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jun 2022 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=TzKfq7E9CEicVwu+G42Kc4ZGKMTepsQz/3pjzCviq18=;
 b=GYMZVPH3V0zPbXe23xeBJb6wFtWFRdinGznt4a6IGiXz6RwQgxYKuIC67JvhTGZVjp
 I3m2ltOSjhogcVBY+BTxxpeIW+jQJkV3OtLcHK4VoPs3O7aCXkmSZ/Qeea7ab7k9qJjw
 IG4QDUjb2/8orbBfYJ7YE6msnLv3XEeYRM04/N/6pSUV9rAUJaB6+39sjTfid8nXCFhH
 s/h7TPP1ULnoN7POx4rLhvG/Jp7gvG32+fN24aVA5wJf0No41d2RZBG3RAOXo2P1fHkO
 zHKgvFz0fCmOeaJVQqBEuTQEBotegZdO6BTa2Y0PgfFP2ERIngu2LKXBlBvd6lE4rVFw
 VXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=TzKfq7E9CEicVwu+G42Kc4ZGKMTepsQz/3pjzCviq18=;
 b=crdtX7ncitMweZH+FO5aNvvBQkwshRcQejvUw1FqjX0KHbpIY3Bxm0r1Zfe+TNXaQw
 n5kLfPf3SHjSJJujKinYY3EjA68vH1xRRSHw4HtXKFiaoI6BnjZaU3qyQtfIrZDqNVes
 Fw7tkpa2RPNU8PYf+KTdv5EX561jUg9BQbujYh3N0AlU6/l6pwfapEWJNg+moQ56XZFC
 BzZ9JIgV6HjveIE5LUt7npio6QnekvHT82Y/jupV72SB7mB6qwss3getPN7Q+XaIM7WL
 1mZ7rQuN0CIvQdHW5v9/PvhW/Pd54vmE49+1RWVtsq+vLwnlP9R5YHsoepqefr9Wcs65
 EcJg==
X-Gm-Message-State: AOAM530fVoOuCqHk616QMjluGxbZ6tiVeMKg7Rl0zmnqsLCU4/LQT3wa
 apEfz94gZN+cJn4mmty/g8rm4+0SMYw=
X-Google-Smtp-Source: ABdhPJzLEM3ct34cP2eWbQF/nurpWxFFA6JmpyVqmxe+oBMnLutmGpf9Is7iheaNssWAvf3apmIWAg==
X-Received: by 2002:a05:6000:1887:b0:20f:de1d:9fc3 with SMTP id
 a7-20020a056000188700b0020fde1d9fc3mr162259wri.111.1654095552721; 
 Wed, 01 Jun 2022 07:59:12 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:d1fb:e1e4:e193:e55f?
 ([2a02:908:1256:79a0:d1fb:e1e4:e193:e55f])
 by smtp.gmail.com with ESMTPSA id
 j22-20020a5d4536000000b0021108003596sm1481517wra.10.2022.06.01.07.59.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Jun 2022 07:59:12 -0700 (PDT)
Message-ID: <d11df4fa-a0bd-63f0-9ae7-ead007868989@gmail.com>
Date: Wed, 1 Jun 2022 16:59:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: (REGRESSION bisected) Re: amdgpu errors (VM fault / GPU fault
 detected) with 5.19 merge window snapshots
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>, Michal Kubecek <mkubecek@suse.cz>,
 "Yang, Philip" <Philip.Yang@amd.com>
References: <20220527090039.pdrazo5e6mwgo3d3@lion.mk-sys.cz>
 <20220527124459.mfo4tjdsjohamsvy@lion.mk-sys.cz>
 <CADnq5_PHR3NMhMAWDLy3SGyzn4bHedWDerXVmaFANbooYhZE0w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <CADnq5_PHR3NMhMAWDLy3SGyzn4bHedWDerXVmaFANbooYhZE0w@mail.gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 01.06.22 um 16:55 schrieb Alex Deucher:
> On Fri, May 27, 2022 at 8:58 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>> On Fri, May 27, 2022 at 11:00:39AM +0200, Michal Kubecek wrote:
>>> Hello,
>>>
>>> while testing 5.19 merge window snapshots (commits babf0bb978e3 and
>>> 7e284070abe5), I keep getting errors like below. I have not seen them
>>> with 5.18 final or older.
>>>
>>> ------------------------------------------------------------------------
>>> [  247.150333] gmc_v8_0_process_interrupt: 46 callbacks suppressed
>>> [  247.150336] amdgpu 0000:0c:00.0: amdgpu: GPU fault detected: 147 0x00020802 for process firefox pid 6101 thread firefox:cs0 pid 6116
>>> [  247.150339] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x00107800
>>> [  247.150340] amdgpu 0000:0c:00.0: amdgpu:   VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x0D008002
>>> [  247.150341] amdgpu 0000:0c:00.0: amdgpu: VM fault (0x02, vmid 6, pasid 32780) at page 1079296, write from 'TC2' (0x54433200) (8)
>> [...]
>>> [  249.925909] amdgpu 0000:0c:00.0: amdgpu: IH ring buffer overflow (0x000844C0, 0x00004A00, 0x000044D0)
>>> [  250.434986] [drm] Fence fallback timer expired on ring sdma0
>>> [  466.621568] gmc_v8_0_process_interrupt: 122 callbacks suppressed
>> [...]
>>> ------------------------------------------------------------------------
>>>
>>> There does not seem to be any apparent immediate problem with graphics
>>> but when running commit babf0bb978e3, there seemed to be a noticeable
>>> lag in some operations, e.g. when moving a window or repainting large
>>> part of the terminal window in konsole (no idea if it's related).
>>>
>>> My GPU is Radeon Pro WX 2100 (1002:6995). What other information should
>>> I collect to help debugging the issue?
>> Bisected to commit 5255e146c99a ("drm/amdgpu: rework TLB flushing").
>> There seem to be later commits depending on it so I did not test
>> a revert on top of current mainline.
>>
> @Christian Koenig, @Yang, Philip Any ideas?  I think there were some
> fix ups for this.  Maybe those just haven't hit the tree yet?

I need to double check, but as far as I know we have fixed all the fallout.

Could be that something didn't went upstream because it came to late for 
the merge window.

Christian.

>
> Alex
>
>
>> I should also mention that most commits tested as "bad" during the
>> bisect did behave much worse than current mainline (errors starting as
>> early as with sddm, visibly damaged screen content, sometimes even
>> crashes). But all of them issued messages similar to those above into
>> kernel log.
>>
>> Michal Kubecek

