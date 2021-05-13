Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CA1C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 13:26:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F408C6143B
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 13:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F408C6143B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CE616E883;
	Thu, 13 May 2021 13:26:15 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 821976E86E
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 09:53:19 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0e44003cf6e755e77ac6f1.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0e:4400:3cf6:e755:e77a:c6f1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BE0CA1EC050F;
 Thu, 13 May 2021 11:53:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1620899596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=DOLq0Lj3q5zYgGx2CLe/FoJhWpQJQp54lkJ2OG3LGlw=;
 b=Ba9TPFkuTBKnjcAZWJbjLgg4Jqc+7dcrDpCidnTEcvh8JPPpH9KWBoYcxDx7P8DvvW0uCB
 JI5N/ODTdU7vlmINofsglh0wLRafw3DiIB8QqgwG2q4UsXl7hIbf4+W6v0UzSAthQlC8vf
 +WRdJhdKGeFa3avaQNQiJcNY7toM7Yg=
Date: Thu, 13 May 2021 11:53:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJz3CMBFFIDBzVwX@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Thu, 13 May 2021 13:26:14 +0000
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
Cc: x86-ml <x86@kernel.org>, "Kasiviswanathan,
 Harish" <Harish.Kasiviswanathan@amd.com>, lkml <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, May 13, 2021 at 03:20:36AM +0000, Joshi, Mukul wrote:
> Exporting smca_get_bank_type() works fine when CONFIG_X86_MCE_AMD is defined.
> I would need to put #ifdef CONFIG_X86_MCE_AMD in my code to compile the amdgpu
> driver when CONFIG_X86_MCE_AMD is not defined.
> I can avoid all that by using is_smca_umc_v2().
> I think it would be cleaner with using is_smca_umc_v2().

See how smca_get_long_name() is exported and export that function the
same way.

To save you some energy: is_smca_umc_v2() is not going to happen.

> You can think of GPU device as a EDAC device here. It is mainly
> interested in handling uncorrectable errors.

An EDAC "device", as you call it, is not interested in handling UEs. If
anything, it counts them.

> It is a deferred interrupt that generates an MCE.

Is that the same deferred interrupt which calls amd_deferred_error_interrupt() ?

> When an uncorrectable error is detected on the GPU UMC, all we are
> doing is determining the physical address where the error occurred and
> then "retiring" the page that address belongs to.

What page is that? Normal DRAM page or a page in some special GPU memory?

> By retiring, we mean we reserve the page so that it is not available
> for allocations to any applications.

We do that for normal DRAM memory pages by poisoning them. I hope you
don't mean that.

Looking at

amdgpu_ras_add_bad_pages
|-> amdgpu_vram_mgr_reserve_range

that's some VRAM thing so I'm guessing special memory on the GPU.

If so, what happens with all those "retired" pages when you reboot?
They're getting used again and potentially trigger the same UEs and the
same retiring happens?

> We are providing information to the user by storing all the
> information about the retired pages in EEPROM. This can be accessed
> through sysfs.

Ok, I'm a user and I can access that information through sysfs. What can
I do with it?

> Hope it clears what "bad page retirement" is achieving.

It is getting there.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
