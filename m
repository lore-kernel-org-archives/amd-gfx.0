Return-Path: <SRS0=fEJB=IO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EB6C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 13:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C9906502B
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Mar 2021 13:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C9906502B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB78A6E194;
	Tue, 16 Mar 2021 13:53:11 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A315D6E23B
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Mar 2021 09:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615885700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=idVxam08guerYh+UThY49AnOxjbt8HD2ng1AgsclHwY=;
 b=YkvnOKdF/A39PnQbvvaPNbeXv7mPu0iaWUvguk7OVjSDU1O+wFllVTQeAc7NnHSvoAnoop
 +Qc2xKNYq9MzbluayAzhwtncV/5wmKLQgx4N8cBTWXDPbDwO2kBGHpzuu4rxYjWTix63b/
 STr8447vbV2rG4PoImR4judBG6U2rXw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-GmrAuuLsOJOt73oh5waFgw-1; Tue, 16 Mar 2021 05:08:16 -0400
X-MC-Unique: GmrAuuLsOJOt73oh5waFgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30D2A1084D68;
 Tue, 16 Mar 2021 09:08:14 +0000 (UTC)
Received: from [10.36.114.203] (ovpn-114-203.ams2.redhat.com [10.36.114.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E34D21F453;
 Tue, 16 Mar 2021 09:08:11 +0000 (UTC)
To: "Liang, Liang (Leo)" <Liang.Liang@amd.com>,
 Mike Rapoport <rppt@linux.ibm.com>
References: <MW3PR12MB4537B49678884A1EB1F75AB5F36E9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0AE49D98-171A-42B9-9CFC-9193A9BD3346@redhat.com>
 <YEzCm/Uwvw7kKpd7@linux.ibm.com>
 <22437770-956e-f7b4-a8f6-3f1cc28c3ec2@redhat.com>
 <MW3PR12MB45371072D7C3FDA6986C6318F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <YFBVNEC7jMZxwleL@linux.ibm.com>
 <MW3PR12MB453781F0AD49AF3787DE4230F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <0cc972a1-5b40-3017-33f8-b2610489ee18@redhat.com>
 <MW3PR12MB453771424C9B2866BBBAE036F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
 <b9b324e4-4c98-b81d-ddae-52e4feb33064@redhat.com>
 <MW3PR12MB4537B6D5911092E456220818F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <9e869214-7a3b-e86d-4832-7117f7c6090f@redhat.com>
Date: Tue, 16 Mar 2021 10:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MW3PR12MB4537B6D5911092E456220818F36B9@MW3PR12MB4537.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mailman-Approved-At: Tue, 16 Mar 2021 13:53:10 +0000
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 George Kennedy <george.kennedy@oracle.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Andrew Morton <akpm@linux-foundation.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 16.03.21 09:58, Liang, Liang (Leo) wrote:
> [AMD Public Use]
> 
> Hi David,
> 
> root@scbu-Chachani:~# cat /proc/mtrr
> reg00: base=0x000000000 (    0MB), size= 2048MB, count=1: write-back
> reg01: base=0x0ffe00000 ( 4094MB), size=    2MB, count=1: write-protect
> reg02: base=0x100000000 ( 4096MB), size=   16MB, count=1: write-protect

^ there it is

https://wiki.osdev.org/MTRR

"Reads allocate cache lines on a cache miss. All writes update main memory.

Cache lines are not allocated on a write miss. Write hits invalidate the 
cache line and update main memory. "

AFAIU, writes completely bypass caches and store directly to main 
mamory. If there are cache lines from a previous read, they are 
invalidated. So I think especially slow will be read(addr), write(addr), 
read(addr), ... which is what we have in the kstream benchmark.


The question is:

who sets this up without owning the memory?
Is the memory actually special/slow or is that setting wrong?
Buggy firmware/BIOS?
Buggy device driver?


> reg03: base=0x0ffde0000 ( 4093MB), size=  128KB, count=1: write-protect
> reg04: base=0x0ff000000 ( 4080MB), size=  512KB, count=1: write-protect


-- 
Thanks,

David / dhildenb

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
