Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B6C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 15:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74ADD64F8F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 15:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74ADD64F8F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 282176F896;
	Fri, 12 Mar 2021 15:43:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5043E6EE1E
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 14:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615558331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o1r6EhPV88gm94Egq81KekYoIA71BcwdVAvPViuRiMU=;
 b=Pa9bU9m3mlrinbLu7zBzbxtblXSELZ7ukGWsTvmM7LSoqbBSZwtKeeYY1RFn9TIpYYJrWA
 EByYYjOO2geVFGPE7THzg9ahACMXKnbO2ZVyegTYcu+ugeT0y/dbd91U4v4RDfSnLySU6w
 DMQeJsN0uBtnzfop97ahVfQdMcdaWSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-P1mZUFPQPqeTRjKDISWN9g-1; Fri, 12 Mar 2021 09:12:07 -0500
X-MC-Unique: P1mZUFPQPqeTRjKDISWN9g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACEC318460E0;
 Fri, 12 Mar 2021 14:12:05 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C0C5E5DEAD;
 Fri, 12 Mar 2021 14:12:03 +0000 (UTC)
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
 <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
 <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
Date: Fri, 12 Mar 2021 15:12:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mailman-Approved-At: Fri, 12 Mar 2021 15:43:40 +0000
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
Cc: "Liang, Liang \(Leo\)" <Liang.Liang@amd.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
 George Kennedy <george.kennedy@oracle.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"; DelSp="yes"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12.03.21 15:06, Deucher, Alexander wrote:
> [AMD Public Use]
> 
>> -----Original Message-----
>> From: David Hildenbrand <david@redhat.com>
>> Sent: Thursday, March 11, 2021 10:03 AM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>; linux-
>> kernel@vger.kernel.org; amd-gfx list <amd-gfx@lists.freedesktop.org>;
>> Andrew Morton <akpm@linux-foundation.org>
>> Cc: Huang, Ray <Ray.Huang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Liang, Liang (Leo) <Liang.Liang@amd.com>;
>> Mike Rapoport <rppt@linux.ibm.com>; Rafael J. Wysocki
>> <rafael@kernel.org>; George Kennedy <george.kennedy@oracle.com>
>> Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to
>> tail in __free_pages_core()")
>>
>> On 11.03.21 15:41, Deucher, Alexander wrote:
>>> [AMD Public Use]
>>>
>>> Booting kernels on certain AMD platforms takes 2-3 minutes with the patch
>> in the subject.  Reverting it restores quick boot times (few seconds).  Any
>> ideas?
>>>
>>
>> Hi,
>>
>> We just discovered latent BUGs in ACPI code whereby ACPI tables are
>> exposed to the page allocator as ordinary, free system RAM. With the
>> patch you mention, the order in which pages get allocated from the page
>> allocator are changed - which makes the BUG trigger more easily.
>>
>> I could imagine that someone allocates and uses that memory on your
>> platform, and I could imagine that such accesses are very slow.
>>
>> I cannot tell if that is the root cause, but at least it would make sense.
>>
>> See
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.
>> kernel.org%2Fpatchwork%2Fpatch%2F1389314%2F&amp;data=04%7C01%7C
>> alexander.deucher%40amd.com%7Cd1533aaddccd464c59f308d8e49ec563%7
>> C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637510717893096801%
>> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
>> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=xpty77D54Z5S%2FKK
>> JO5SsVQaNsHoojWMR73whpu8VT%2B4%3D&amp;reserved=0
>>
>> You might want to give that patch a try (not sure if it's the latest
>> version). CCing George
> 
> Thanks for the patch.  Unfortunately it didn't help.  Any other ideas?  Is there a newer version of that patch?
> 

@George?

It's interesting that this only applies to these special AMD systems so  
far. Is there anything particular about these systems? How much memory  
do these systems have?

Increasing the boot time from a few seconds to 2-3 minutes does not  
smell like some corner case cache effects we might be hitting in this  
particular instance - there have been minor reports that it either  
slightly increased or slightly decreases initial system performance, but  
that was about it.

Either, yet another latent BUG (but why? why should memory access  
suddenly be that slow? I could only guess that we are now making sooner  
use of very slow memory), or there is really something else weird going on.

Cheers!

> Alex


-- 
Thanks,

David / dhildenb

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
