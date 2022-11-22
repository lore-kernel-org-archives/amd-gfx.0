Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DCDC433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 16:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF95710E1D7;
	Tue, 22 Nov 2022 16:59:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95BEE10E128;
 Tue, 22 Nov 2022 16:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=Z2J/AOx23miWElPmE+7zDiqIr927sWbMxM+vCpv8Szo=; b=wTtbG4QhN7bfXNkk5Lo4RVfuaq
 ZxHvocPeWadBgn/JFrjJ2RElxv3AzRYNQwycazhkpATW1uTxbxStM0GmQ75nLVgGlZ+O+ym+klS0z
 Cm9hG4G7V3+oqlbQblo8aNmQAqb78/oJYjH+sm+dpW9fYGLmocYm4+/9C+OGUvQ3917A8vlXDUlNM
 4J8zQwm5A5iQNa7QHsUQnL1/lP4SOdG91Loikz90io5tazIE1JHT9oBaJL1ADokpG8e1tCsfdoBAG
 EQuJTM8rGkMDHns0UrOsUAN0q6J3+xOfXjZuFXdRweMyPeaHLg4Bx8clpx07A1I1AW5QjgDBpTDfs
 AwAq39vQ==;
Received: from [2601:1c2:d80:3110::a2e7]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oxWao-00AtEM-BC; Tue, 22 Nov 2022 16:57:54 +0000
Message-ID: <5e27ba9e-69a1-bf70-941e-88637b4f5a3c@infradead.org>
Date: Tue, 22 Nov 2022 08:57:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Build regressions/improvements in v6.1-rc6
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
 Alex Deucher <alexdeucher@gmail.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com>
 <20221122105054.4062213-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
 <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
 <021efb6c9295402cf05406bb319c441c0b0229b3.camel@sipsolutions.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <021efb6c9295402cf05406bb319c441c0b0229b3.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 22 Nov 2022 16:59:10 +0000
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
Cc: linux-rdma@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 11/22/22 07:00, Johannes Berg wrote:
> On Tue, 2022-11-22 at 08:55 -0500, Alex Deucher wrote:
>>>
>>>    + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called object is not a function or function pointer:  => 94:18
>>>    + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1934:1
>>>
>>> um-x86_64/um-all{mod,yes}config (in kfd_cpumask_to_apic_id())
>>
>> Presumably cpu_data is not defined on um-x86_64?  Does it even make
>> sense to build drivers on um-x86_64?
> 
> Drivers in general yes ;-)
> 
> This driver, probably not.
> 
> But the issue is that a lot of drivers "depends on X86_64" or such,
> where only "X86" is the arch symbol. You could add "X86 && X86_64" to
> really build on x86 64-bit only.
> 
> I didn't check this driver, but this has mostly popped up since UM got
> PCI support some time ago (which I added.)

I have patches for lots of these issues, but some people said that they
would want to build DRM drivers for use with KUNIT (i.e. UML), so I thought
that meant my patches were not needed.

-- 
~Randy
