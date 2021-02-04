Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7BEC433DB
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 03:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F7564DFA
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 03:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F7564DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8EA26EC6B;
	Thu,  4 Feb 2021 03:03:38 +0000 (UTC)
X-Greylist: delayed 1376 seconds by postgrey-1.36 at gabe;
 Thu, 04 Feb 2021 01:19:07 UTC
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CB36EC5B
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 01:19:07 +0000 (UTC)
Received: from in02.mta.xmission.com ([166.70.13.52])
 by out03.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1l7SwK-006r63-Tq; Wed, 03 Feb 2021 17:56:09 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]
 helo=x220.xmission.com)
 by in02.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1l7SwJ-002zvR-OT; Wed, 03 Feb 2021 17:56:08 -0700
From: ebiederm@xmission.com (Eric W. Biederman)
To: Alex Deucher <alexdeucher@gmail.com>
References: <CAN_LGv3Go0DgKbjPVHFFXU+U8RRU15m-np3F6_RrVmx6FmBoHQ@mail.gmail.com>
 <20210128052924.GC2339@MiWiFi-R3L-srv>
 <20210203064849.GA11522@dhcp-128-65.nay.redhat.com>
 <CADnq5_MdLTLvVdwFQJxuRaQcQFNkLUNRt267zaxULNH0FUvFeA@mail.gmail.com>
Date: Wed, 03 Feb 2021 18:54:41 -0600
In-Reply-To: <CADnq5_MdLTLvVdwFQJxuRaQcQFNkLUNRt267zaxULNH0FUvFeA@mail.gmail.com>
 (Alex Deucher's message of "Wed, 3 Feb 2021 09:46:56 -0500")
Message-ID: <87wnvoodny.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1l7SwJ-002zvR-OT; ; ; mid=<87wnvoodny.fsf@x220.int.ebiederm.org>;
 ; ; hst=in02.mta.xmission.com; ; ; ip=68.227.160.95; ; ;
 frm=ebiederm@xmission.com; ; ; spf=neutral
X-XM-AID: U2FsdGVkX1/0CcMdMtkYrxbzt7yNQ0ix//DjF5cgC4Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: amdgpu problem after kexec
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-Mailman-Approved-At: Thu, 04 Feb 2021 03:03:37 +0000
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
Cc: kexec@lists.infradead.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Dave Young <dyoung@redhat.com>, "Alexander E. Patrakov" <patrakov@gmail.com>,
 Baoquan He <bhe@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Alex Deucher <alexdeucher@gmail.com> writes:

> On Wed, Feb 3, 2021 at 3:36 AM Dave Young <dyoung@redhat.com> wrote:
>>
>> Hi Baoquan,
>>
>> Thanks for ccing.
>> On 01/28/21 at 01:29pm, Baoquan He wrote:
>> > On 01/11/21 at 01:17pm, Alexander E. Patrakov wrote:
>> > > Hello,
>> > >
>> > > I was trying out kexec on my new laptop, which is a HP EliteBook 735
>> > > G6. The problem is, amdgpu does not have hardware acceleration after
>> > > kexec. Also, strangely, the lines about BlueTooth are missing from
>> > > dmesg after kexec, but I have not tried to use BlueTooth on this
>> > > laptop yet. I don't know how to debug this, the relevant amdgpu lines
>> > > in dmesg are:
>> > >
>> > > amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB
>> > > test failed on gfx (-110).
>> > > [drm:process_one_work] *ERROR* ib ring test failed (-110).
>> > >
>> > > The good and bad dmesg files are attached. Is it a kexec problem (and
>> > > amdgpu is only a victim), or should I take it to amdgpu lists? Do I
>> > > need to provide some extra kernel arguments for debugging?

The best debugging I can think of is can you arrange to have the amdgpu
modules removed before the final kexec -e?

That would tell us if the code to shutdown the gpu exist in the rmmod
path aka the .remove method and is simply missing in the kexec path aka
the .shutdown method.


>> > I am not familiar with graphical component. Add Dave to CC to see if
>> > he has some comments. It would be great if amdgpu expert can have a look.
>>
>> It needs amdgpu driver people to help.  Since kexec bypass
>> bios/UEFI initialization so we requires drivers to implement .shutdown
>> method and test it to make 2nd kernel to work correctly.
>
> kexec is tricky to make work properly on our GPUs.  The problem is
> that there are some engines on the GPU that cannot be re-initialized
> once they have been initialized without an intervening device reset.
> APUs are even trickier because they share a lot of hardware state with
> the CPU.  Doing lots of extra resets adds latency.  The driver has
> code to try and detect if certain engines are running at driver load
> time and do a reset before initialization to make this work, but it
> apparently is not working properly on your system.

There are two cases that I think sometimes get mixed up.

There is kexec-on-panic in which case all of the work needs to happen in
the driver initialization.

There is also a simple kexec in which case some of the work can happen
in the kernel that is being shutdown and sometimes that is easer.

Does it make sense to reset your device unconditionally on driver removal?
Would it make sense to reset your device unconditionally on driver add?

How can someone debug the smart logic of reset on driver load?

Eric
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
