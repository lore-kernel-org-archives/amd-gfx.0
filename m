Return-Path: <SRS0=mwd6=IK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BCBC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 15:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CD5C64FF3
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Mar 2021 15:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CD5C64FF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05D996F89C;
	Fri, 12 Mar 2021 15:57:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D4826F89C
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Mar 2021 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615564486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvDHhjhApUIGkxAldXJIyTxY9YDcb/M12Kv81Sgxp0k=;
 b=YrhypfsLJuLEQF7nHguAgegL5twfL4m08RqXYvpvHc2uWQLScNxZtqTxPVQxqy64E9fQ/z
 DSixV7sONuxDxfc/u1BGpicjqu/7r15I02GYzUJoqd5kYURYAJIUXqn8kts+Up5MTLIN6M
 qknwYXzA9v01qaWUSJsYCS0OYdakY2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-28-L5H8X6_8ONWGSZHGuZ-8jA-1; Fri, 12 Mar 2021 10:48:33 -0500
X-MC-Unique: L5H8X6_8ONWGSZHGuZ-8jA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 083C99252F;
 Fri, 12 Mar 2021 15:48:32 +0000 (UTC)
Received: from [10.36.114.197] (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED217196E3;
 Fri, 12 Mar 2021 15:48:29 +0000 (UTC)
Subject: Re: slow boot with 7fef431be9c9 ("mm/page_alloc: place pages to tail
 in __free_pages_core()")
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liang, Liang (Leo)" <Liang.Liang@amd.com>
References: <MN2PR12MB448872F0BE8F49C78AF908F3F7909@MN2PR12MB4488.namprd12.prod.outlook.com>
 <2f7c20ea-888f-65b6-6607-c86aab65acce@redhat.com>
 <MN2PR12MB44886034D18F900F4FE45D8DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <15faeb97-d031-f70a-adab-f2966e0b1221@redhat.com>
 <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <b5faa9b9-6f40-f8e4-cf7c-795b429e02a8@redhat.com>
Date: Fri, 12 Mar 2021 16:48:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB44884289499B6B16A0E9017DF76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mailman-Approved-At: Fri, 12 Mar 2021 15:57:38 +0000
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

> 8G (with some carve out for the integrated GPU).
> [    0.044181] Memory: 6858688K/7200304K available (14345K kernel code, 9659K rwdata, 4980K rodata, 2484K init, 12292K bss, 341360K reserved, 0K cma-reserved)
> 
> Nothing particularly special about these systems that I am aware of.  I'll see if we can repro this issue on any other platforms, but so far, not one has noticed any problems.
> 
>>
>> Increasing the boot time from a few seconds to 2-3 minutes does not smell
>> like some corner case cache effects we might be hitting in this particular
>> instance - there have been minor reports that it either slightly increased or
>> slightly decreases initial system performance, but that was about it.
>>
>> Either, yet another latent BUG (but why? why should memory access
>> suddenly be that slow? I could only guess that we are now making sooner
>> use of very slow memory), or there is really something else weird going on.
> 
> Looks like pretty much everything is slower based on the timestamps in the dmesg output.  There is a big jump here:

If we're really dealing with some specific slow memory regions and that 
memory gets allocated for something that gets used regularly, then we 
might get a general slowdown. Hard to identify, though :)

> 
>> [    3.758596] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
>> [    3.759372] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
>> [   16.177983] ACPI: 13 ACPI AML tables successfully acquired and loaded
>> [   17.099316] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
>> [   18.969959] ACPI: EC: EC started
> 
> And here:
> 
>> [   36.566608] PCI: CLS 64 bytes, default 64
>> [   36.575383] Trying to unpack rootfs image as initramfs...
>> [   44.594348] Initramfs unpacking failed: Decoding failed
>> [   44.765141] Freeing initrd memory: 46348K
> 
> Also seeing soft lockups:
>> [  124.588634] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [swapper/1:0]

Yes, I noticed that -- there is a heavy slowdown somewhere.

As that patch is v5.10 already (and we're close to v5.12) I assume 
something is particularly weird about the platform you are running on - 
because this is the first time I see a report like that.

-- 
Thanks,

David / dhildenb

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
