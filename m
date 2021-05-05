Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9042FC433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 14:23:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B9861104
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 14:23:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B9861104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BA646E4A6;
	Wed,  5 May 2021 14:23:32 +0000 (UTC)
X-Greylist: delayed 1282 seconds by postgrey-1.36 at gabe;
 Wed, 05 May 2021 14:06:20 UTC
Received: from gateway34.websitewelcome.com (gateway34.websitewelcome.com
 [192.185.148.104])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7EC6E4CD
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 14:06:20 +0000 (UTC)
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
 by gateway34.websitewelcome.com (Postfix) with ESMTP id 3D5A88EDE1
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 08:44:54 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22]) by cmsmtp with SMTP
 id eHpelUReZMGeEeHpeldu3p; Wed, 05 May 2021 08:44:54 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=N4R49salU5sENNtVSA/WqaqovUJg3vSbwlOL+cJ0uF0=; b=F4cPGkg3c7c2/d9Odh2orEfLzg
 s+iLQgFJb5/GZ2OgCLU2vf0523pm04cXlK5IgH97Nmbk21+Fx7fkfbDf5iw9aZgOQDGXgVnCvFZeb
 f2uMSLv2Hpx3ixNHD6joYxAhG8G1Tmn8vGG2UAhNyHaRXRqIlbgmFg/A3YbPSFaYyZ8jMKmXXkT8O
 dAUAdMoSY8fnjoYsKE5xiVs8A9iUr1bGi5zgN498Ry8PuR0XiIvaXq0DEoQ4im3SjblR4B/7rlomx
 Z68G5v1VgtrIcqnqURDL8h4ZX9OKk7dj/2D3T5BkPPCyM6ag63NuRoiQEbEqqlhjHt616Sn6/gGhv
 hsnsHfPw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:52156
 helo=[192.168.15.8])
 by gator4166.hostgator.com with esmtpsa (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.94.2)
 (envelope-from <gustavo@embeddedor.com>)
 id 1leHpc-003mTy-OJ; Wed, 05 May 2021 08:44:52 -0500
Subject: Re: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element array with
 flexible-array in struct SISLANDS_SMC_SWSTATE"
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210504184233.2350976-1-alexander.deucher@amd.com>
 <15cc0988-0446-5423-62d7-051ccaf2936e@embeddedor.com>
 <MN2PR12MB44886A5959AA52DF5D3EDF7BF7599@MN2PR12MB4488.namprd12.prod.outlook.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <09c63f79-7245-3863-c070-8bac952a4ca8@embeddedor.com>
Date: Wed, 5 May 2021 08:45:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB44886A5959AA52DF5D3EDF7BF7599@MN2PR12MB4488.namprd12.prod.outlook.com>
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
X-Exim-ID: 1leHpc-003mTy-OJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8])
 [187.162.31.110]:52156
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-Mailman-Approved-At: Wed, 05 May 2021 14:23:31 +0000
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



On 5/5/21 08:06, Deucher, Alexander wrote:
> [AMD Public Use]
> 
>> -----Original Message-----
>> From: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> Sent: Tuesday, May 4, 2021 6:43 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
>> gfx@lists.freedesktop.org
>> Cc: Gustavo A . R . Silva <gustavoars@kernel.org>
>> Subject: Re: [PATCH] Revert "drm/radeon/si_dpm: Replace one-element
>> array with flexible-array in struct SISLANDS_SMC_SWSTATE"
>>
>> Hi,
>>
>> I thought it was this[1] the one causing problems[2].
> 
> They are both causing problems.

Yeah, I already know why and I'll work out a solution soon. In the meantime, both
should be reverted.

These other two[1][2] also seem to have the same issue and should be reverted, too.
I wonder why no one has reported any problems, yet... in particular regarding this[2].

Thanks
--
Gustavo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e1aa13ca3ffdd1e626532a3924ac80686939848
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4541ea81edde6ce9a1d9be082489aca7e8e7e1dc

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
