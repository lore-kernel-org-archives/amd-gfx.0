Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31EFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 06:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7FFF611AE
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 06:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7FFF611AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39E716F619;
	Wed,  6 Oct 2021 06:27:43 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FC26F619
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 06:27:42 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae933.dynamic.kabel-deutschland.de
 [95.90.233.51])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id D2B2B61E64784;
 Wed,  6 Oct 2021 08:27:39 +0200 (CEST)
Subject: Re: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on
 Ryzen: amdgpu: SME is not compatible with RAVEN
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
References: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
 <YVxjgFScCZNwliMi@zn.tnic>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <946736c0-d3bc-ed87-70bc-93c0c3cb998a@molgen.mpg.de>
Date: Wed, 6 Oct 2021 08:27:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YVxjgFScCZNwliMi@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

Dear Borislav,


Thank you for your reply.

Am 05.10.21 um 16:38 schrieb Borislav Petkov:
> On Tue, Oct 05, 2021 at 04:29:41PM +0200, Paul Menzel wrote:
>> Selecting the symbol `AMD_MEM_ENCRYPT` – as
>> done in Debian 5.13.9-1~exp1 [1] – also selects
>> `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT`, as it defaults to yes,
> 
> I'm assuming that "selecting" is done automatically: alldefconfig,
> olddefconfig?
> 
> Because CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT only depends on
> CONFIG_AMD_MEM_ENCRYPT and former can be disabled in oldconfig or
> menuconfig etc.

Sorry for being unclear. Distributions want to enable support for that 
feature, but as long as it breaks systems, it should be opt-in via the 
Linux kernel command line, and not opt-out. Also the Kconfig help texts 
do not mention anything about these problems, and the AMDGPU log message 
is of level info and not error. It’d be even better, if the message 
would contain the information, how to disable SME (`mem_encrypt=off`).


Kind regards,

Paul
