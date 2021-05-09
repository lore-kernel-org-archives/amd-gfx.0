Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E970FC43461
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754E26144F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754E26144F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5176C6E42C;
	Mon, 10 May 2021 08:26:26 +0000 (UTC)
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
 [192.185.148.164])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0CB86E826
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 May 2021 23:02:17 +0000 (UTC)
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
 by gateway34.websitewelcome.com (Postfix) with ESMTP id 660F5266E1
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 May 2021 18:02:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id fsRDlAgovPkftfsRDlB9Fh; Sun, 09 May 2021 18:02:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eDNP3uQ3suDyvGz4i4MH4W18ozvG5y6HtSMp527ZM6s=; b=hA+9xcV3sYum8QyB8EwdI++76J
 970jAffTgCy5VTsmw5ljZnTBQqEBfUfIaMPucDTCliCofiYmKmQkB0Wxi/+wpT2p1aJjSZDBsEXhG
 rJbYyR0hamLJZq33ylLmxrtiHkjiaehbw7qCCdZjVpKv42ZVkO0n1Zen8XsQhR0Ee0rT13wQJv63r
 ifgDuuyYnw+Djt85h0sSpNckN+zP6B3YfNDR9Ra8i+rO8FJYHngLXkz+g3kCT6eWFflv6D8asacBp
 sV4sP566hS5E3F+FirUW9RBNIux/KHFUuGQshpKGGHiDtEYD2Zx0n+996IFZufJEvIDkMw0MB6uVV
 b+B6/24A==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:57998
 helo=[192.168.15.8])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <gustavo@embeddedor.com>)
 id 1lfsRB-002vOJ-WE; Sun, 09 May 2021 18:02:14 -0500
Subject: Re: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE"
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210504184233.2350976-1-alexander.deucher@amd.com>
 <15cc0988-0446-5423-62d7-051ccaf2936e@embeddedor.com>
 <MN2PR12MB44886A5959AA52DF5D3EDF7BF7599@MN2PR12MB4488.namprd12.prod.outlook.com>
 <09c63f79-7245-3863-c070-8bac952a4ca8@embeddedor.com>
Message-ID: <caac4b9d-8999-8c06-80ed-0ddf1ef29c9a@embeddedor.com>
Date: Sun, 9 May 2021 18:02:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <09c63f79-7245-3863-c070-8bac952a4ca8@embeddedor.com>
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - lists.freedesktop.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1lfsRB-002vOJ-WE
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8])
 [187.162.31.110]:57998
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Mailman-Approved-At: Mon, 10 May 2021 08:26:24 +0000
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
Cc: "Gustavo A . R . Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

I've just sent a couple of fixes for the recent radeon problems:

https://lore.kernel.org/lkml/20210509224926.GA31035@embeddedor/
https://lore.kernel.org/lkml/20210509225525.GA32045@embeddedor/

So, there is no need to revert the problematic patches for radeon anymore.

Sorry for the inconveniences.
Thanks!
--
Gustavo

On 5/5/21 08:45, Gustavo A. R. Silva wrote:
> 
> 
> On 5/5/21 08:06, Deucher, Alexander wrote:
>> [AMD Public Use]
>>
>>> -----Original Message-----
>>> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>> Sent: Tuesday, May 4, 2021 6:43 PM
>>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>>> gfx@lists.freedesktop.org
>>> Cc: Gustavo A . R . Silva <gustavoars@kernel.org>
>>> Subject: Re: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element
>>> array with flexible-array in struct SISLANDS_SMC_SWSTATE"
>>>
>>> Hi,
>>>
>>> I thought it was this[1] the one causing problems[2].
>>
>> They are both causing problems.
> 
> Yeah, I already know why and I'll work out a solution soon. In the meantime, both
> should be reverted.
> 
> These other two[1][2] also seem to have the same issue and should be reverted, too.
> I wonder why no one has reported any problems, yet... in particular regarding this[2].
> 
> Thanks
> --
> Gustavo
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e1aa13ca3ffdd1e626532a3924ac80686939848
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4541ea81edde6ce9a1d9be082489aca7e8e7e1dc
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
