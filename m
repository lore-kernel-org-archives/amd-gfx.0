Return-Path: <SRS0=uap9=5Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E958AC43331
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 17:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC52C20BED
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2020 17:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VoE/pOwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC52C20BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D6416E86D;
	Tue, 31 Mar 2020 17:29:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9618689BA5
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2020 16:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=iBIZjEbhUqZOtk5V18poldKYJqWr17L3xpH+eAdVvpQ=; b=VoE/pOwTmbEoLZztds+Z6FQ5Oo
 uqKJwve38PohsGjqmKA7k0xNE+sgE/Tq3j+draqv3XUq/XZ7bZl7K18U+4GiyNjDi5zTQ+quHOrTB
 5oddyo7yRn8muBXIkO5DRQ3juwcUS7bRtAKmlrQmEy6+ZYvnyLvgSJzjBfHm9PZx7T1rV6Klxm6ve
 imTPF+rxbLbqtqtxPCR4DLJxiDGD1jUab3iHF6eH6rCWrf6eF4QGt197Oxh9u5cTtKCdcg9mJfKWP
 /OTD5pQmIqLUpba7IMtZBp6X9jl9au+9LHyd86/hCnvw9AH7dyValneKa8S46/t3cQlgD54BvPoUU
 yxFbkeKA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK4B-0001WE-2W; Tue, 31 Mar 2020 16:48:43 +0000
Subject: Re: mmotm 2020-03-30-18-46 uploaded (freesync)
To: Nathan Chancellor <natechancellor@gmail.com>
References: <20200331014748.ajL0G62jF%akpm@linux-foundation.org>
 <a266d6a4-6d48-aadc-afd7-af0eb7c2d9db@infradead.org>
 <20200331073938.GA54733@ubuntu-m2-xlarge-x86>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <710856c8-b1d9-d03d-457c-99e55a2ff274@infradead.org>
Date: Tue, 31 Mar 2020 09:48:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200331073938.GA54733@ubuntu-m2-xlarge-x86>
Content-Language: en-US
X-Mailman-Approved-At: Tue, 31 Mar 2020 17:29:20 +0000
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
Cc: sfr@canb.auug.org.au, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 mhocko@suse.cz, linux-mm@kvack.org, broonie@kernel.org,
 linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 akpm@linux-foundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 3/31/20 12:39 AM, Nathan Chancellor wrote:
> On Mon, Mar 30, 2020 at 11:18:26PM -0700, Randy Dunlap wrote:
>> On 3/30/20 6:47 PM, akpm@linux-foundation.org wrote:
>>> The mm-of-the-moment snapshot 2020-03-30-18-46 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> mmotm-readme.txt says
>>>
>>> README for mm-of-the-moment:
>>>
>>> http://www.ozlabs.org/~akpm/mmotm/
>>>
>>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>>> more than once a week.
>>>
>>> You will need quilt to apply these patches to the latest Linus release (5.x
>>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
>>> http://ozlabs.org/~akpm/mmotm/series
>>>
>>
>> on i386:
>>
>> ld: drivers/gpu/drm/amd/display/modules/freesync/freesync.o: in function `mod_freesync_build_vrr_params':
>> freesync.c:(.text+0x790): undefined reference to `__udivdi3'
>>
>>
>> Full randconfig file is attached.
>>
>> -- 
>> ~Randy
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Hi Randy,
> 
> I am guessing this should fix it since I ran into this on arm
> allyesconfig:
> 
> https://lore.kernel.org/lkml/20200330221614.7661-1-natechancellor@gmail.com/

works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested


> FWIW, not an mmotm issue since the patch comes from the AMD tree.

Right.

-- 
~Randy
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
