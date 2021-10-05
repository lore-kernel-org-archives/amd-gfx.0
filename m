Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2457C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 14:29:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BBA56120F
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 14:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1BBA56120F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5FA06E40A;
	Tue,  5 Oct 2021 14:29:45 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6DC46E40A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 14:29:43 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae91d.dynamic.kabel-deutschland.de
 [95.90.233.29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id EF0BD61EA1936;
 Tue,  5 Oct 2021 16:29:41 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Tom Lendacky <thomas.lendacky@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org
Subject: `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=y` causes AMDGPU to fail on Ryzen:
 amdgpu: SME is not compatible with RAVEN
Message-ID: <8bbacd0e-4580-3194-19d2-a0ecad7df09c@molgen.mpg.de>
Date: Tue, 5 Oct 2021 16:29:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
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

Dear Tom, dear Linux folks,


Selecting the symbol `AMD_MEM_ENCRYPT` – as done in Debian 5.13.9-1~exp1 
[1] – also selects `AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT`, as it defaults 
to yes, causing boot failures on AMD Raven systems. On the MSI B350M 
MORTAR with AMD Ryzen 3 2200G, Linux logs and the AMDGPU graphics 
driver, despite being loaded, does not work, and the framebuffer driver 
is used instead.

     [   19.679824] amdgpu 0000:26:00.0: amdgpu: SME is not compatible 
with RAVEN

It even causes black screens on other systems as reported to the Debian 
bug tracking system *Black screen on AMD Ryzen based systems (AMDGPU 
related when AMD Secure Memory Encryption not disabled -- 
mem_encrypt=off)* [2].

Should the default be changed?


Kind regards,

Paul


[1]: 
https://salsa.debian.org/kernel-team/linux/-/blob/master/debian/changelog#L1138
[2]: https://bugs.debian.org/994453
