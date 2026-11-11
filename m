Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1203E606A321
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2026 13:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jW47DLpC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5CF5112158;
	Thu, 12 Nov 2026 13:56:08 +0000 (UTC)
Received: from mta0.migadu.com (out-10.mta0.migadu.com [91.218.175.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 594F210FC2D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 16:58:18 +0000 (UTC)
X-Envelope-To: amd-gfx@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=S5159V/Pr/U9wfU6GuHiJLwFjQaFGKXwt7ZwLcTa2AI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794416294; v=1; x=1795021094;
 b=jW47DLpCrKhZ08wXaS5Q+pe20b2Hb+bVB/oHugaPzfaoWmuEM578oFIEhslG8PbOFgEdXHyZ
 50GHV5WAbXNStQu/z/9Rz1K+IceLiBVl8mdwuRMQv7vQ3WY3egEuWUSEUZukt4PlbmEyNVCLrqX
 F5f63SFQ6O/sQeSvG4L+7w3A=
X-Envelope-To: amd-gfx@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 5984f67eb3c1846a;
 Wed, 11 Nov 2026 16:58:12 +0000
X-Mizu-Trace-ID: 5984f67eb3c1846a
X-Migadu-Flow: FLOW_OUT
Message-ID: <784dadf6-41c9-4c91-b341-4d4179d7a8b8@linux.dev>
Date: Wed, 11 Nov 2026 22:28:05 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: use the VBIOS trained UCLK levels on the
 MacBookPro16, 1
To: Alex Deucher <alexdeucher@gmail.com>, James Skillen <jahs@jahs.net>
Cc: Andre Eikmeyer <dev@deq.rocks>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261024162109.307247-1-dev@deq.rocks>
 <20261102232450.61301-1-jahs@jahs.net>
 <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
Content-Language: en-US
From: Aditya Garg <aditya.garg@linux.dev>
In-Reply-To: <CADnq5_P5Ly4Pb8WqPaN28yDHG8jSjoEHAfDKAqSgTrSj14Pr1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Nov 2026 13:56:07 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 03/11/26 20:05, Alex Deucher wrote:
> On Tue, Nov 3, 2026 at 3:21 AM James Skillen <jahs@jahs.net> wrote:
>>
>> On Sat, 24 Oct 2026 18:21:09 +0200, Andre Eikmeyer wrote:
>>> The Radeon Pro 5300M and 5500M of the MacBookPro16,1 (Navi 14 boards
>>> 1002:7340/106b:0210 and 1002:7340/106b:020f) stop answering SMU messages
>>> as soon as UCLK switches into its third level.
>>
>> This is the hang reported in drm/amd issue 6005, which has the
>> umc_info analysis and test results from both boards:
>>
>>   https://gitlab.freedesktop.org/drm/amd/-/work_items/6005
>>
>> Could v2 carry a Closes: tag for it?
>>
>> I tested the patch on a MacBookPro16,1 with the Pro 5300M (1002:7340
>> rev 0x43, 106b:0210, VBIOS 113-D32207P1-019), on linux-t2 7.2.11 (Arch
>> v7.2.11-arch1 plus the t2linux patches) with this patch on top. The
>> userspace pp_table upload from the issue was disabled for these boots,
>> so the corrected levels came from the patch alone.
> 
> Can you try this patch instead:
> https://patchwork.freedesktop.org/patch/765668/?series=174386&rev=2
> 
> Alex


The patch is the above link is a vibe coded mess that sometimes works, sometimes won't with appropriate discussion done by the author himself. The once sent by Andre in this series is clean, simple and logical.

Reviewed-by: Aditya Garg <aditya.garg@linux.dev>
Tested-by: Aditya Garg <aditya.garg@linux.dev> # MacBookPro16,1 with AMD Radeon Pro 5300M

Support for more models as claimed by the vibe coded patch should be done after appropriate feedback from the users in another series. Unfortunately after every few kernel versions the most number of regressions we face are from AMD GPU drivers and untested patches are the cause everytime.
