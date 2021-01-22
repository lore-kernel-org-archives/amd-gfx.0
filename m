Return-Path: <SRS0=Q3L8=G2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DE3C433DB
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Jan 2021 09:38:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51DD3233FA
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Jan 2021 09:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51DD3233FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DDEB6EACA;
	Sat, 23 Jan 2021 09:38:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3412689F49;
 Fri, 22 Jan 2021 18:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=9NCYCn2uu0Groq7HNmcJIKyI4plVDNVRCWewLnn9RN8=; b=cXJUHCxcSZmb3WBbTCOSR35MIH
 SKSZ/AI9tzSgOHhz++Q5LuNVk/ofOefgqfOGpcSMlZwWBvgsKoeC1nEyEVjBVv3ZS6oB2/lECoM+s
 Zv5elCywH+h7Nmoy/IN2QsQCb1IraI5aaHYbGpWAoLx6TqwwJD1DaCPhX+yrN3IJWyrjE5wDWB7Zp
 3xny6jzWKrsozJ6vFU+CStctgeG0CmgnZfCzrajZAcPc1rvIU4rAgpTNufmzG17Q2jvk2AzSezD5u
 6yh3gAOHP6dzU+/9IjeChfFqrTewesgwEUZIEb03HkrEcTX3wimImj/NLUduZmdqclatfa940PiJX
 YC8/qVBw==;
Received: from [2601:1c0:6280:3f0::9abc]
 by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l30l4-0007me-0q; Fri, 22 Jan 2021 18:02:06 +0000
Subject: Re: linux-next: Tree for Jan 22 (amdgpu)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210122180643.7039571c@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <64dd3a50-a836-c1b7-738e-6b6b5433117a@infradead.org>
Date: Fri, 22 Jan 2021 10:02:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210122180643.7039571c@canb.auug.org.au>
Content-Language: en-US
X-Mailman-Approved-At: Sat, 23 Jan 2021 09:38:32 +0000
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 1/21/21 11:06 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20210121:
> 

on i386:

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
ERROR: modpost: "__divdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!



-- 
~Randy
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
