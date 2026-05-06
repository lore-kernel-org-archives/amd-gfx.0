Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2746CCD3442
	for <amd-gfx@archiver.kernel.org>; Thu,  7 May 2026 10:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADCF310F039;
	Thu,  7 May 2026 10:13:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.b="wbZoa8vJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AxqgQ+t4";
	dkim-atps=neutral
X-Greylist: delayed 572 seconds by postgrey-1.36 at gabe;
 Wed, 06 May 2026 19:50:54 UTC
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB9EC10E280
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 19:50:54 +0000 (UTC)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1778096481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ijqy2/d6J8ZQPVUOuj/buCO3IPceYWbMDmJ2lSlKffY=;
 b=wbZoa8vJnVAQzN2n9Gg5pRURCxDLtKvidUT4grPOrcMuLMSOKLzaq5tOQU0NcII8yqWBKb
 TFwq2hnf0Gf2h+pT2GIv8md19OB0XZBiHur6hvjoA25F9+6buV1w7hTL7DheTlaWsjikoU
 Cz8bPA+I0r0zYl2WkV3z9BAZV6GDhJgVuP3t6dbAxUfESeBXzXT2obJQG8wY1lSLt2MeJz
 TlWktHoifpgmlvKDdFOFnvNRwaL9bJhIre5Hv6jyTKFQGv2DGITHrCbvIiwBROUSxd/MGo
 3Hm/wFCjXIPY/JPKJMU7kdQIW7z4P8c9ODCPTEGhMa3DDyFfctYyfeqgLtrRrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1778096481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ijqy2/d6J8ZQPVUOuj/buCO3IPceYWbMDmJ2lSlKffY=;
 b=AxqgQ+t48lMxky7rv8Yzqy0Y9V1z+YhT8BmuILKMsKY3RHcl6vAFmkfG+H6hXSzUS/JgKV
 F4Sd8RByCEUoItBg==
To: "Ostrowski, Rafal" <Rafal.Ostrowski@amd.com>, Bert Karwatzki
 <spasswolf@web.de>
Cc: "Varone, Dillon" <Dillon.Varone@amd.com>, "Hung, Alex"
 <Alex.Hung@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: kernel panic when resuming from hibernate in next-20260406 with
 PREEMPT_RT
In-Reply-To: <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>
References: <20260409131411.10598-1-spasswolf@web.de>
 <IA1PR12MB6307858BAECC7CC3AE8AA958F8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a67b9159f69e8788a598fb459d8e6d99d1776f2f.camel@web.de>
 <IA1PR12MB6307AC51F4C6E4A77BCB5EDDF8582@IA1PR12MB6307.namprd12.prod.outlook.com>
 <IA1PR12MB630789B32C2104D1FAC2B761F8592@IA1PR12MB6307.namprd12.prod.outlook.com>
 <a1c86a3b83e26d86f95068e8005ce4b2efdca23a.camel@web.de>
 <IA1PR12MB630726FFADF30847A8496012F8362@IA1PR12MB6307.namprd12.prod.outlook.com>
Date: Wed, 06 May 2026 21:41:20 +0200
Message-ID: <87ik90wckf.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 07 May 2026 10:13:28 +0000
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

Rafal!

On Mon, Apr 27 2026 at 09:23, Rafal Ostrowski wrote:
> I am glad to hear that mentioned patch fixed your issue.
> Small clarification - amdgpu is not designed to support
> PREEMPT_RT flag, but it was still worth to fix as obvious regression.

PREEMPT_RT is not a flag. It's a valid supported preemption model and
you have to support it whether you like it or not. 

Please fix your CI to test with CONFIG_PREEMPT_RT=y so future issues
like that can be avoided.

Thanks,

        tglx
