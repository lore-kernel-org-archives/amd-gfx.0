Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D5C4CF3199
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 07:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9BBF10E6B5;
	Wed,  2 Oct 2024 07:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=johnrowley.me header.i=@johnrowley.me header.b="snEJbei8";
	dkim-atps=neutral
Received: from mail.vapourmail.eu (mail.vapourmail.eu [5.75.183.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A8F10E661
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Oct 2024 19:09:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D1DF1C0076; Tue,  1 Oct 2024 20:09:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
 s=dkim; t=1727809745;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=MmSnUdMKHsGI2VRpu+YhU76rUdbF7+VqmnmZpKCYOqs=;
 b=snEJbei8YxYLT4iP1xOWvTTqLjqcCyv3LcoB2lDQbpe4NXyhkFtx6bdL/OVbavD7K0oYuY
 rND32D2bcfXvaUXky8g6xyxkeerT/ylWq1BZTP/ig6P6nSzjMbTdPXLpDCVy+bpt/cDEga
 31xj0hY7myDisI4XQ/Xx7WVmJmsKURCKUZX2HQ1LwJglTYM44Z5cmdSPd3zsi3hBdqFULc
 lr2cp/Fl0cABCVdNAY/MVGzqEBxxQSuEdnXLdOmTLbcH8iAfkiTmETuXP0h6mqM3QYWNdk
 dlxRPZBGiPFzYX88DXT9YL9w7H3Romje/+V+RuNdveSAIa1hFXQUaNNku1gmHQ==
Message-ID: <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
Date: Tue, 1 Oct 2024 20:09:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 regressions@lists.linux.dev
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
 <95c575a3-100c-4808-b451-b92f14598188@amd.com>
Content-Language: en-US
From: John Rowley <lkml@johnrowley.me>
In-Reply-To: <95c575a3-100c-4808-b451-b92f14598188@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 02 Oct 2024 07:59:18 +0000
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

I was using power-profiles-daemon version 0.23 in balanced mode.

I also tested TLP, and vanilla kernel without any power daemons running. Without any daemons I use the following:

    energy_performance_preference: balance_power

    scaling_driver: amd-pstate-epp

    scaling_governor: powersave

Thanks.

On 01/10/2024 19:48, Mario Limonciello wrote:
> On 9/30/2024 13:42, John Rowley wrote:
>> Oops, forgot to mention that I'm using the AMD variant of the Framework 13 laptop, which uses AMD Ryzen 7 7840U w/ Radeon 780M Graphics.
>>
>> Thanks.
>>
>> #regzbot introduced: 58a261bfc967
>>
>
> Just to make sure we're looking at a pure kernel bug:
>
> 1) What version of power-profiles-daemon are you using?
> 2) What mode are you in, 'balanced' or 'power-saver'?  If 'power-saver' can you reproduce in 'balanced' as well?
