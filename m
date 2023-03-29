Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF67C77B60
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 13:08:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A965A10E528;
	Wed, 29 Mar 2023 13:08:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70D310E506
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 08:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tu8D8sNJ5RV0W3AuFiycIVvG6n0AuLvN4txSs88tZ2E=; b=JiL4y62ZsZ1uxjqtNN9l2NqWSl
 wxFK6o6H4pWzhxVAQSDIXQNVDR9pMKbYaap0flqtbJgYCElstOCLDlAbI/ZULqUin+B0mfNOdsmnC
 3toxNj3QkKeaWcpC6vNXDFdV2DWS2t6hEYTOD17aFe59/LrKoSStR1TqhbRQT+nxq86CY12GTC4oc
 duwoqyzBovddWn3KGZNYoRP2n2e76Up0t6hdkgKqJ9KJC07xYnxz7QWmkrWeFD50dq/1WxRcP93+g
 rYg2MU4TGWl4Ls13rt7Sz0OwILovO1FM6FZZtNF9EpmsgPnckV7RHBqy617mSrUTTWwwJK/eE8sej
 MEhM3vrA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
 id 1phRVg-006oAq-35; Wed, 29 Mar 2023 08:50:25 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 88D12300237;
 Wed, 29 Mar 2023 10:50:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 348AA262EE29D; Wed, 29 Mar 2023 10:50:23 +0200 (CEST)
Date: Wed, 29 Mar 2023 10:50:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Yang, WenYou" <WenYou.Yang@amd.com>
Subject: Re: [PATCH v3 1/2] cpu/smt: add a notifier to notify the SMT changes
Message-ID: <20230329085023.GO4253@hirez.programming.kicks-ass.net>
References: <20230329015149.870132-1-WenYou.Yang@amd.com>
 <20230329015149.870132-2-WenYou.Yang@amd.com>
 <20230329071014.GC7701@hirez.programming.kicks-ass.net>
 <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB352749E2864A87C3C32B7D0FFD899@BYAPR12MB3527.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Wed, 29 Mar 2023 13:08:17 +0000
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
 Perry" <Perry.Yuan@amd.com>, bp@alien8.de, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Liang,
 Richard qi" <Richardqi.Liang@amd.com>, "Liu, Kun" <Kun.Liu2@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 29, 2023 at 07:23:29AM +0000, Yang, WenYou wrote:
> [AMD Official Use Only - General]

^^^ that has no business being in a public email.

> Hi Peter,
> 
> Thank you for your review.
> 
> The purpose of the patch set is to improve the performance when playing game for some AMD APUs with SMT enabled/disabled.
> 
> When change the SMT state on the fly through " echo on/off > /sys/devices/system/cpu/smt/control", the kernel needs to send a message to notify PMFW to adjust a variable's value, which impacts the performance.

When top posting I normally ignore the email. When not wrapping email I
typically get cranky. You 'win' *3* 'I cannot use email' trophies in a
singly try. Surely AMD has a HOWTO somewhere you can read?

So what do you want to have happen when someone goes and manually
offlines all the SMT siblings using /sys/devices/system/cpu/cpu*/online
?

I'm thinking that wants the same PMFW (whatever the heck that is)
notification change done, right?

If the answer is "yes", then your patch does not meet the goals and is
inadequate.
