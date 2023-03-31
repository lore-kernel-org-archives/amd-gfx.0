Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F17C761A6
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 22:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A70510E2F6;
	Fri, 31 Mar 2023 22:21:23 +0000 (UTC)
X-Greylist: delayed 436 seconds by postgrey-1.36 at gabe;
 Fri, 31 Mar 2023 22:00:14 UTC
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D71410E298
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 22:00:12 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1680299571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Hyu7B5PMD/6Hjx3PVFsOPviX5E90ag0vc/ISSLayx4=;
 b=Jb+3UqWAMcMCm/IW5t98tTatXDLNhFaDT2PAQ17N7MvuDRPIQFkECCVaAbMTNkBR1MSoS6
 OtHV+jOQJqRzzsfWXBV4j6t8S/xrZ71Tmlud0yfIfr6OlEbZ9pzz5odKzezLIUeiXfmqCv
 e0QWbpYrH7zKpntNUUxHU67KPX3dNlO0P2VQ4lqs5hfrZF6+UVsuajR5ExtGkH+LWB3UXe
 c3fLQLLHgf7VrTC5GliyQ0W854umpcauoNH73Uag6ZKJFH+Ua0yTLw3J7JYFxpRviQrDJJ
 +GTLBGs4hYpCiV7RXNf/PsQIu1thkWu1iojooX+vWKVME7adcHIijjBmSzwjIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1680299571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Hyu7B5PMD/6Hjx3PVFsOPviX5E90ag0vc/ISSLayx4=;
 b=mNy/akH/qQWxhte5iHap01uZz88g/ZXpEUvUU7mQYy1cdFIZMk+SuHC23Ln7e1K3HStM76
 MZWc70grf26T8wAQ==
To: "Yang, WenYou" <WenYou.Yang@amd.com>, Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
In-Reply-To: <DM6PR12MB3531340547BE346D07E88BE3FD8F9@DM6PR12MB3531.namprd12.prod.outlook.com>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
 <20230329071014.GC7701@hirez.programming.kicks-ass.net>
 <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
 <20230329085023.GO4253@hirez.programming.kicks-ass.net>
 <DM6PR12MB3531933678779C5923989925FD899@DM6PR12MB3531.namprd12.prod.outlook.com>
 <DM6PR12MB3531340547BE346D07E88BE3FD8F9@DM6PR12MB3531.namprd12.prod.outlook.com>
Date: Fri, 31 Mar 2023 23:52:50 +0200
Message-ID: <87pm8osi4t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Fri, 31 Mar 2023 22:20:56 +0000
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
Cc: "Phillips, Kim" <kim.phillips@amd.com>, "Li, Ying" <YING.LI@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 "gpiccoli@igalia.com" <gpiccoli@igalia.com>, "Yuan,
 Perry" <Perry.Yuan@amd.com>, "bp@alien8.de" <bp@alien8.de>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Quan, 
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liang, Richard qi" <Richardqi.Liang@amd.com>, "Liu,
 Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Mar 31 2023 at 05:49, WenYou Yang wrote:

<SNIP>
        Removing pointlessly copied mail headers. Please fix your email
        client
</SNIP>

>> >
>> > So what do you want to have happen when someone goes and manually
>> > offlines all the SMT siblings using
>> > /sys/devices/system/cpu/cpu*/online
>> > ?
>> 
>> I don't consider this situation.  Any suggestions will be deeply appreciated.
>
> Hi Peter,
>
> I don't find a good method to handle this situation.
> Yes, manually offlining all the SMT sibling will get the same result of SMT disabling on the fly.
>
> Actually, the normal way to enable/disable SMT on the fly is to echo on/off > /sys/device/system/cpu/smt/control

That's the most convenient way, right.

But why do we need a kernel notifier for this, if you can do the same
with a sysfs knob for your driver?

Then user space can fiddle with SMT control in sysfs and afterwards tell
the driver that it should reconfigure.

That makes a ton more sense than this random notifier.

Thanks,

        tglx
