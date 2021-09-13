Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63EDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:18:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 055A460F92
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 16:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 055A460F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9074C89F3C;
	Mon, 13 Sep 2021 16:18:16 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9A2F289F3C
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 16:18:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id 8200320201C;
 Mon, 13 Sep 2021 18:18:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 2s3DeW7emzJn; Mon, 13 Sep 2021 18:18:13 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 3BA2E20201A;
 Mon, 13 Sep 2021 18:18:13 +0200 (CEST)
Received: from [127.0.0.1] by thor with esmtp (Exim 4.95-RC2)
 (envelope-from <michel@daenzer.net>) id 1mPoeq-000ae9-Hz;
 Mon, 13 Sep 2021 18:18:12 +0200
Message-ID: <0f683a3e-dcec-9d20-565d-b301a82bd05b@daenzer.net>
Date: Mon, 13 Sep 2021 18:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc: Lyude Paul <lyude@redhat.com>, amd-gfx@lists.freedesktop.org
References: <20210913141946.1884173-1-michel@daenzer.net>
 <06496dcf-67cd-6695-e993-23d46dfd91e9@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdkfd: Cast atomic64_read return value
In-Reply-To: <06496dcf-67cd-6695-e993-23d46dfd91e9@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 2021-09-13 17:19, Felix Kuehling wrote:
> Am 2021-09-13 um 10:19 a.m. schrieb Michel Dänzer:
>> From: Michel Dänzer <mdaenzer@redhat.com>
>>
>> Avoids warning with -Wformat:
>>
>>   CC [M]  drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.o
>> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.c: In function ‘kfd_smi_event_update_thermal_throttling’:
>> ../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_smi_events.c:224:60: warning: format ‘%llx’ expects argument of type
>>  ‘long long unsigned int’, but argument 6 has type ‘long int’ [-Wformat=]
>>   224 |         len = snprintf(fifo_in, sizeof(fifo_in), "%x %x:%llx\n",
>>       |                                                         ~~~^
>>       |                                                            |
>>       |                                                            long long unsigned int
>>       |                                                         %lx
>>   225 |                        KFD_SMI_EVENT_THERMAL_THROTTLE, throttle_bitmask,
>>   226 |                        atomic64_read(&adev->smu.throttle_int_counter));
>>       |                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>       |                        |
>>       |                        long int
> 
> That's weird. As far as I can see, atomic64_read is defined to return
> s64, which should be the same as long long. Which architecture are you
> on?

This was from a 64-bit powerpc build. atomic64_read returns long there.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
