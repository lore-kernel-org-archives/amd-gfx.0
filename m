Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5454C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 16:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A262F6500F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 16:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A262F6500F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C4DC6E040;
	Fri, 12 Mar 2021 16:53:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A7266E17F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 16:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615567614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wU5xQKKzE8qkeDpQ0gzJ/c3p8l6vonPU4w3HcO4zus=;
 b=LqOlvv617hE233OXf6nI0LWyhHgbvD35PUyxqDRPF1zJCT/YRzDL3wH7mjXKnyjER+l6OU
 0cGel6kJY3zDaS724yP4Lz3SpJu/UV9yf70UNKgIqYptteWjUOvi7rzvmzC9rGIT81vezD
 7OzdiapebrXEbim0fcSCk3KURps2SZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-U4Lm9AdVPHalfpzHt-9kYg-1; Fri, 12 Mar 2021 11:46:49 -0500
X-MC-Unique: U4Lm9AdVPHalfpzHt-9kYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED1AB1015C84;
 Fri, 12 Mar 2021 16:46:47 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30EE7610A8;
 Fri, 12 Mar 2021 16:46:36 +0000 (UTC)
To: "Liang, Liang (Leo)" <Liang.Liang@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
 <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
 <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
 <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MW3PR12MB4537D9D86FB67A288A8EC4E7F36F9@MW3PR12MB4537.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
Message-ID: <a434cc35-13f1-7eb2-5828-73cbb1896cea@redhat.com>
Date: Fri, 12 Mar 2021 17:46:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MW3PR12MB4537D9D86FB67A288A8EC4E7F36F9@MW3PR12MB4537.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mailman-Approved-At: Fri, 12 Mar 2021 16:53:14 +0000
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
 George Kennedy <george.kennedy@oracle.com>, "Huang, Ray" <Ray.Huang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Mike Rapoport <rppt@linux.ibm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12.03.21 17:19, Liang, Liang (Leo) wrote:
> [AMD Public Use]
> 
> Dmesg attached.
> 


So, looks like the "real" slowdown starts once the buddy is up and running (no surprise).


[    0.044035] Memory: 6856724K/7200304K available (14345K kernel code, 9699K rwdata, 5276K rodata, 2628K init, 12104K bss, 343324K reserved, 0K cma-reserved)
[    0.044045] random: get_random_u64 called from __kmem_cache_create+0x33/0x460 with crng_init=1
[    0.049025] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.050036] ftrace: allocating 47158 entries in 185 pages
[    0.097487] ftrace: allocated 185 pages with 5 groups
[    0.109210] rcu: Hierarchical RCU implementation.

vs.

[    0.041115] Memory: 6869396K/7200304K available (14345K kernel code, 3433K rwdata, 5284K rodata, 2624K init, 6088K bss, 330652K reserved, 0K cma-reserved)
[    0.041127] random: get_random_u64 called from __kmem_cache_create+0x31/0x430 with crng_init=1
[    0.041309] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.041335] ftrace: allocating 47184 entries in 185 pages
[    0.055719] ftrace: allocated 185 pages with 5 groups
[    0.055863] rcu: Hierarchical RCU implementation.


And it gets especially bad during ACPI table processing:

[    4.158303] ACPI: Added _OSI(Module Device)
[    4.158767] ACPI: Added _OSI(Processor Device)
[    4.159230] ACPI: Added _OSI(3.0 _SCP Extensions)
[    4.159705] ACPI: Added _OSI(Processor Aggregator Device)
[    4.160551] ACPI: Added _OSI(Linux-Dell-Video)
[    4.161359] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    4.162264] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[   17.713421] ACPI: 13 ACPI AML tables successfully acquired and loaded
[   18.716065] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[   20.743828] ACPI: EC: EC started
[   20.744155] ACPI: EC: interrupt blocked
[   20.945956] ACPI: EC: EC_CMD/EC_SC=0x666, EC_DATA=0x662
[   20.946618] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
[   20.947348] ACPI: Interpreter enabled
[   20.951278] ACPI: (supports S0 S3 S4 S5)
[   20.951632] ACPI: Using IOAPIC for interrupt routing

vs.

[    0.216039] ACPI: Added _OSI(Module Device)
[    0.216041] ACPI: Added _OSI(Processor Device)
[    0.216043] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.216044] ACPI: Added _OSI(Processor Aggregator Device)
[    0.216046] ACPI: Added _OSI(Linux-Dell-Video)
[    0.216048] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
[    0.216049] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
[    0.228259] ACPI: 13 ACPI AML tables successfully acquired and loaded
[    0.229527] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
[    0.231663] ACPI: EC: EC started
[    0.231666] ACPI: EC: interrupt blocked
[    0.233664] ACPI: EC: EC_CMD/EC_SC=0x666, EC_DATA=0x662
[    0.233667] ACPI: \_SB_.PCI0.LPC0.EC0_: Boot DSDT EC used to handle transactions
[    0.233670] ACPI: Interpreter enabled
[    0.233685] ACPI: (supports S0 S3 S4 S5)
[    0.233687] ACPI: Using IOAPIC for interrupt routing

The jump from 4.1 -> 17.7 is especially bad.

Which might in fact indicate that this could be related to using
some very special slow (ACPI?) memory for ordinary purposes,
interfering with actual ACPI users?

But again, just a wild guess, because the system is extremely slow
afterwards, however, we don't have any pauses without any signs of
life for that long.


It would be interesting to run a simple memory bandwidth benchmark
on the fast kernel with differing sizes up to running OOM to see if
there is really some memory that is just horribly slow once allocated and
used.

-- 
Thanks,

David / dhildenb

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
