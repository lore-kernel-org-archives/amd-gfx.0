Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07048FF8862
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 12:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65D8E10E72B;
	Mon, 27 Apr 2026 12:41:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="iYyaOGDh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fo3QIksx";
	dkim-atps=neutral
X-Greylist: delayed 444 seconds by postgrey-1.36 at gabe;
 Mon, 27 Apr 2026 10:21:48 UTC
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7611A10E692
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 10:21:48 +0000 (UTC)
Date: Mon, 27 Apr 2026 12:14:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1777284862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwvNzA77cTupsEIv6dal9H7A7nSRcWczX8S6oci8yxk=;
 b=iYyaOGDhytUqJvSrIxSK+nkq/ZSyMs2/DpwRlCS0wldcYHIn7O2NrESm62Qe2jamiaGE/w
 H0KS+3L0Bdf0tTBWc53JFEHN2yZVjLLhn2GAzlZ5m8Y/BvZxG8NBs7AIYmrxtz2SHop5VU
 VHN/wEzsUGeD4gIzz5vcTfE6q94OWGTC3nnoK6QkStrKJ3tRmftEM+piRSMypzAmOU7/Jc
 +TMHy0x8TQdjGLz+RCKZ2l/TKBnWb7sSarQTLuYMxNwmAn9VfpWG/+gO57wYRFgxAWY6Xx
 oia3mHBV3TIHiJ3rfQqbrLEC9d3Cm925+zLjDp4yekxxNvhIYl+9c9GatjrVoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1777284862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwvNzA77cTupsEIv6dal9H7A7nSRcWczX8S6oci8yxk=;
 b=fo3QIksxWzVdamRewmKjdxtyjLbotkLf90WEvnAeL5AaBHDvw2IBCUHnAy5M2zOQgtw4aL
 NuKtOe7cqy2nJNAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>
Cc: Bert Karwatzki <spasswolf@web.de>,
 "Varone, Dillon" <Dillon.Varone@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
Message-ID: <20260427101421.7N9_OOk5@linutronix.de>
References: <20260409131411.10598-1-spasswolf@web.de>
 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a1c86a3b83e26d86f95068e8005ce4b2efdca23a.camel@web.de>
 <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Mon, 27 Apr 2026 12:41:11 +0000
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

On 2026-04-27 09:23:32 [+0000], Ostrowski, Rafal wrote:
> Hi Bert,

Hi Rafal,

> I am glad to hear that mentioned patch fixed your issue.
> Small clarification - amdgpu is not designed to support
> PREEMPT_RT flag, but it was still worth to fix as obvious regression.

What does this mean? It is not a flag but a preemption model. It is part
of the official kernel.

> Kind Regards,
> Rafal Ostrowski

Sebastian
