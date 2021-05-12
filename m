Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06939C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 02:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C50C61413
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 02:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C50C61413
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26A2C6E5D3;
	Thu, 13 May 2021 02:09:56 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C926E544
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 21:05:44 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0bb800dc83a7b830fce185.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0b:b800:dc83:a7b8:30fc:e185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ECD991EC04DE;
 Wed, 12 May 2021 23:05:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1620853543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=hwvjlzB9ZjQc1MjZx7Xbk0cwBahbwiqW8zWrf9aO+jg=;
 b=DE6dG2qA9Ee5FoEoNTxlkh7vTDoLsFsYzlzTg3x8Yo6Z4hs2P3t/1hv2VWeVPzzNxn0n5Q
 NqFAH3FfVY8mNRGAk1CXNeZr6h2Cvaah3JN6M9Y034HIVl6OzLHbKn+BmV0nXl3rWr6P1U
 jcOqYpxlriw0LtFrwqqBeSG6Jy5MloU=
Date: Wed, 12 May 2021 23:05:38 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJxDIhGnZ5XdukiS@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Thu, 13 May 2021 02:09:54 +0000
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

On Wed, May 12, 2021 at 07:00:58PM +0000, Joshi, Mukul wrote:
> SMCA UMCv2 corresponds to GPU's UMC MCA bank and the GPU driver is
> only interested in errors on GPU UMC.

So that thing should be called SMCA_GPU_UMC not SMCA_UMC_V2.

> We cannot know this without is_smca_umc_v2.

You don't need it - just export smca_get_bank_type() and test the bank
type at the call site.

> Maybe. I hope its not too much of a concern if it stays the way it is.

That was just a suggestion anyway - it is not code I maintain so not my
call.

> I wasn't really sure if I should use the EDAC priority here or create a new one for Accelerator devices.
> I thought using EDAC priority might not be accepted by the maintainers as EDAC and GPU (Accelerator) devices
> are two different class of devices.
> That is the reason I create a new one. 
> I am OK to use EDAC priority if that is acceptable.

I don't know what's acceptable because I still am unclear as to what
that thing is supposed to do. It seems you are interested only in
uncorrectable errors.

How are those errors reported? #MC exception, deferred interrupt, simply
logged in the bank and we find them by polling?

Then, the commit message is talking about some "bad page retirement".
What does that do? What can the user do when she sees the

"Uncorrectable error detected in UMC..."

message?

It depends on what "retiring" of GPU pages means...

In any case, dmesg should issue a human-understandable message about the
recovery action being done and what that means for the user: should she
replace the GPU, should she ignore, etc, etc.

> A system can have multiple GPUs and we only want a single notifier
> registered. I will change the comment to explicitly state this.

Actually, the notifier registration should be able to return a different
retval to state that a callback has already been registered but that
warns only currently so I'm guessing we're stuck with such ugly
"workarounds" for their shortcomings.

I'm gonna take a look whether they can be fixed though so that you don't
have to do this notifier_registered thing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
