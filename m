Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ECEC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 10:39:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0A6861BC1
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 10:39:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A0A6861BC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2724C899A5;
	Mon, 16 Aug 2021 10:39:02 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 45D34899A5;
 Mon, 16 Aug 2021 10:38:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 2942B20201B;
 Mon, 16 Aug 2021 12:38:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id erHziOd1WCxM; Mon, 16 Aug 2021 12:38:58 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id D26AD20201A;
 Mon, 16 Aug 2021 12:38:58 +0200 (CEST)
Received: from [::1] by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1mFa1B-000bB3-RE; Mon, 16 Aug 2021 12:38:57 +0200
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: Leo Liu <leo.liu@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20210811165211.6811-1-michel@daenzer.net>
 <20210813102920.3458-1-michel@daenzer.net>
 <f63510d7-4449-34e9-98bd-bc2d07b08a03@gmail.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu: Cancel delayed work when GFXOFF is disabled
Message-ID: <c8b741b1-8270-f31f-7ef8-d834211726ea@daenzer.net>
Date: Mon, 16 Aug 2021 12:38:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <f63510d7-4449-34e9-98bd-bc2d07b08a03@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
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

On 2021-08-16 9:38 a.m., Christian König wrote:
> Am 13.08.21 um 12:29 schrieb Michel Dänzer:
>> From: Michel Dänzer <mdaenzer@redhat.com>
>>
>> schedule_delayed_work does not push back the work if it was already
>> scheduled before, so amdgpu_device_delay_enable_gfx_off ran ~100 ms
>> after the first time GFXOFF was disabled and re-enabled, even if GFXOFF
>> was disabled and re-enabled again during those 100 ms.
>>
>> This resulted in frame drops / stutter with the upcoming mutter 41
>> release on Navi 14, due to constantly enabling GFXOFF in the HW and
>> disabling it again (for getting the GPU clock counter).
>>
>> To fix this, call cancel_delayed_work_sync when GFXOFF transitions from
>> enabled to disabled. This makes sure the delayed work will be scheduled
>> as intended in the reverse case.
>>
>> In order to avoid a deadlock, amdgpu_device_delay_enable_gfx_off needs
>> to use mutex_trylock instead of mutex_lock.
>>
>> v2:
>> * Use cancel_delayed_work_sync & mutex_trylock instead of
>>    mod_delayed_work.
> 
> While this may work it still smells a little bit fishy.
> 
> In general you have two common locking orders around work items, either lock->work or work->lock. If you mix this as lock->work->lock like here trouble is usually imminent.
> 
> I think what we should do instead is to double check if taking the lock inside the work item is necessary and instead making sure that the work is sync canceled when we don't want it to run. In other words fully switching to the lock->work approach.

Done in v3, thanks for the suggestion!


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
