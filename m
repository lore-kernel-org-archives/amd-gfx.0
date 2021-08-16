Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCF4C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 10:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AE9461BC1
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 10:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1AE9461BC1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daenzer.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A5189DA2;
	Mon, 16 Aug 2021 10:43:36 +0000 (UTC)
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by gabe.freedesktop.org (Postfix) with ESMTP id 9705589DA2;
 Mon, 16 Aug 2021 10:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id C378520201B;
 Mon, 16 Aug 2021 12:43:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id uHGr0nykRnQb; Mon, 16 Aug 2021 12:43:33 +0200 (CEST)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 2774620201A;
 Mon, 16 Aug 2021 12:43:33 +0200 (CEST)
Received: from localhost ([::1]) by thor with esmtp (Exim 4.94.2)
 (envelope-from <michel@daenzer.net>)
 id 1mFa5c-000bDB-7x; Mon, 16 Aug 2021 12:43:32 +0200
To: "Quan, Evan" <Evan.Quan@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Cc: "Liu, Leo" <Leo.Liu@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20210811165211.6811-1-michel@daenzer.net>
 <20210813102920.3458-1-michel@daenzer.net>
 <DM6PR12MB26191AE1AF962B3F7CC02E87E4FD9@DM6PR12MB2619.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: [PATCH] drm/amdgpu: Cancel delayed work when GFXOFF is disabled
Message-ID: <19353c73-1be3-9e62-f2a0-f63fcf6c71bc@daenzer.net>
Date: Mon, 16 Aug 2021 12:43:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <DM6PR12MB26191AE1AF962B3F7CC02E87E4FD9@DM6PR12MB2619.namprd12.prod.outlook.com>
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

On 2021-08-16 12:20 p.m., Quan, Evan wrote:
> [AMD Official Use Only]
> 
> Hi Michel,
> 
> The patch seems reasonable to me(especially the cancel_delayed_work_sync() part).
> However, can you explain more about the code below?
> What's the race issue here exactly?
> 
> +	/* mutex_lock could deadlock with cancel_delayed_work_sync in amdgpu_gfx_off_ctrl. */
> +	if (!mutex_trylock(&adev->gfx.gfx_off_mutex)) {
> +		/* If there's a bug which causes amdgpu_gfx_off_ctrl to be called with enable=true
> +		 * when adev->gfx.gfx_off_req_count is already 0, we might race with that.
> +		 * Re-schedule to make sure gfx off will be re-enabled in the HW eventually.
> +		 */
> +		schedule_delayed_work(&adev->gfx.gfx_off_delay_work, AMDGPU_GFX_OFF_DELAY_ENABLE);
> +		return;
> +	}

If amdgpu_gfx_off_ctrl was called with enable=true when adev->gfx.gfx_off_req_count == 0 already, it could have prevented amdgpu_device_delay_enable_gfx_off from locking the mutex.

v3 solves this by only scheduling the work when adev->gfx.gfx_off_req_count transitions from 1 to 0, which means it no longer needs to lock the mutex.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
