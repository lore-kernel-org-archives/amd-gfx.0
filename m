Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C851C61D97
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Nov 2023 08:09:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E893610E6DE;
	Thu, 23 Nov 2023 08:09:01 +0000 (UTC)
X-Greylist: delayed 600 seconds by postgrey-1.36 at gabe;
 Wed, 22 Nov 2023 18:35:11 UTC
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C164010E0ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Nov 2023 18:35:11 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DF33940E025B; 
 Wed, 22 Nov 2023 18:28:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
 header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
 by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id jTkeBfa8AJj4; Wed, 22 Nov 2023 18:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
 t=1700677695; bh=PtWuSuSCkWZZfZjIwzmVlLQbyyjwyA6jJUHGYUSrrHo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ic3mpnUEnmmXVx6vPl05VZ5se0WvataHLe62DFtnhEwBJWkjjjvXypMxPiZuzdq/e
 1Oh3+C7IgN0Mn9Ok0dL3OlQwIJnVOA3oze/5ljVc3HU8Dzf56RPjDdYNAwx/a/Q+Zb
 9OFE0tMRnJhQkpRIPh609HKOn8R3skP669ufN2ELZYMbFJ/h0xPqvjK3tLue6chCQg
 LzrBNhqsDUNnQAUzhYb2kZ7wLMbczafM6DRLzweQiofZM16A7orNNlXRouyV04dLNS
 UtF58CW2eXZCcoKwIzIX+lH3yFcvins6Nv8PeHsR+PdeEyZIcHnOo3nyj03yPCuv0z
 4y3U7+ugq0anlNP0ecDzdd5w1yt8iszclprZIBWkGkHeoFaTqN5yWoi3ckUzzQpqXD
 uwI5HiXXbSXGMuRSKCW267slQ3bgPPuVYIYewdwg41Bp1yiSFBfW7vcIMkJ/PmZcAD
 4+Z0PLTCS0LOClt0WXoi04WUFKsC1vZwjctp7LLlgRSvFglD5KEzjquRExL2vYqWbQ
 Rif4/mu84vAQrx7gFC/o+sawI2/X7XEtZ20+IWiv6loEjZOc9Ofk6gNrcU7y/mrcDt
 aRLZJFnzpkACT51R0zwtVfTPY1OQjYsxy3CZytAj1cKgtgw838ioTUbP83KITcPv+u
 p1JLhCBhNxeO6270Dn5NM0gk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest
 SHA256) (No client certificate requested)
 by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C38DD40E0257;
 Wed, 22 Nov 2023 18:28:06 +0000 (UTC)
Date: Wed, 22 Nov 2023 19:28:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH 03/20] x86/mce: Use mce_setup() helpers for
 apei_smca_report_x86_error()
Message-ID: <20231122182805.GIZV5INdVuBOhbtjOm@fat_crate.local>
References: <20231118193248.1296798-1-yazen.ghannam@amd.com>
 <20231118193248.1296798-4-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231118193248.1296798-4-yazen.ghannam@amd.com>
X-Mailman-Approved-At: Thu, 23 Nov 2023 08:08:54 +0000
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
Cc: tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Smita.KoralahalliChannabasappa@amd.com, linux-trace-kernel@vger.kernel.org,
 linux-edac@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Nov 18, 2023 at 01:32:31PM -0600, Yazen Ghannam wrote:
> Current AMD systems may report MCA errors using the ACPI Boot Error
> Record Table (BERT). The BERT entries for MCA errors will be an x86
> Common Platform Error Record (CPER) with an MSR register context that
> matches the MCAX/SMCA register space.
> 
> However, the BERT will not necessarily be processed on the CPU that
> reported the MCA errors. Therefore, the correct CPU number needs to be
> determined and the information saved in struct mce.
> 
> The CPU number is determined by searching all possible CPUs for a Local
> APIC ID matching the value in the x86 CPER.

Those below are explaining what the patch does. Not needed here.

> Set up the MCA record after searching for a CPU number. If no possible
> CPU was found, then return early.
> 
> Gather the global MCA information first, save the found CPU number, then
> gather the per-CPU information.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
