Return-Path: <SRS0=hzS6=OF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CB72C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 17:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7153611CA
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Sep 2021 17:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7153611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E97C6E9B4;
	Wed, 15 Sep 2021 17:19:00 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D15F06E9AC;
 Wed, 15 Sep 2021 17:18:39 +0000 (UTC)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
 by localhost (Postfix) with ESMTP id 4H8n4F0x0Hz9sV4;
 Wed, 15 Sep 2021 19:18:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
 by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PKzNyxImFUbI; Wed, 15 Sep 2021 19:18:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase2.c-s.fr (Postfix) with ESMTP id 4H8n4D73HWz9sV3;
 Wed, 15 Sep 2021 19:18:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D8C808B77C;
 Wed, 15 Sep 2021 19:18:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QXqNkIx7zBCr; Wed, 15 Sep 2021 19:18:36 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.204.250])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 11BA38B763;
 Wed, 15 Sep 2021 19:18:34 +0200 (CEST)
Subject: Re: [PATCH v3 4/8] powerpc/pseries/svm: Add a powerpc version of
 cc_platform_has()
To: Borislav Petkov <bp@alien8.de>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
 linux-efi@vger.kernel.org, Brijesh Singh <brijesh.singh@amd.com>,
 kvm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
 Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
 amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>,
 linux-graphics-maintainer@vmware.com, Tom Lendacky
 <thomas.lendacky@amd.com>, Tianyu Lan <Tianyu.Lan@microsoft.com>,
 kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <cover.1631141919.git.thomas.lendacky@amd.com>
 <9d4fc3f8ea7b325aaa1879beab1286876f45d450.1631141919.git.thomas.lendacky@amd.com>
 <YUCOTIPPsJJpLO/d@zn.tnic> <87lf3yk7g4.fsf@mpe.ellerman.id.au>
 <YUHGDbtiGrDz5+NS@zn.tnic>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f8388f18-5e90-5d0f-d681-0b17f8307dd4@csgroup.eu>
Date: Wed, 15 Sep 2021 19:18:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YUHGDbtiGrDz5+NS@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Sep 2021 17:18:59 +0000
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



Le 15/09/2021 à 12:08, Borislav Petkov a écrit :
> On Wed, Sep 15, 2021 at 10:28:59AM +1000, Michael Ellerman wrote:
>> I don't love it, a new C file and an out-of-line call to then call back
>> to a static inline that for most configuration will return false ... but
>> whatever :)
> 
> Yeah, hch thinks it'll cause a big mess otherwise:
> 
> https://lore.kernel.org/lkml/YSScWvpXeVXw%2Fed5@infradead.org/

Could you please provide more explicit explanation why inlining such an 
helper is considered as bad practice and messy ?

Because as demonstrated in my previous response some days ago, taking 
that outline ends up with an unneccessary ugly generated code and we 
don't benefit front GCC's capability to fold in and opt out unreachable 
code.

As pointed by Michael in most cases the function will just return false 
so behind the performance concern, there is also the code size and code 
coverage topic that is to be taken into account. And even when the 
function doesn't return false, the only thing it does folds into a 
single powerpc instruction so there is really no point in making a 
dedicated out-of-line fonction for that and suffer the cost and the size 
of a function call and to justify the addition of a dedicated C file.


> 
> I guess less ifdeffery is nice too.

I can't see your point here. Inlining the function wouldn't add any 
ifdeffery as far as I can see.

So, would you mind reconsidering your approach and allow architectures 
to provide inline implementation by just not enforcing a generic 
prototype ? Or otherwise provide more details and exemple of why the 
cons are more important versus the pros ?

Thanks
Christophe
