Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C0FC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 13:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70749610FC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 13:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70749610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C096EE84;
	Fri, 14 May 2021 13:47:31 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C102D6EE0E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 07:05:47 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0b2c00f343c5c4aba7bf62.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0b:2c00:f343:c5c4:aba7:bf62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53A011EC04DA;
 Fri, 14 May 2021 09:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1620975946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=ksvjS+87xkTe7D27QtQxqyp950apFsTl5xWaEGXi3kc=;
 b=qhnrjx2G/KZbOulEdl4/k8AjV0q1t3cStG639U1CPcyXvIcykEZabxBIxbDnMwIBRzYxQJ
 S0LV/8jrTZmKnQfyHo3SAUtpT20f9XKZPDzwX0XwRbkyTXwt48kwrthR+Cfo4mhUgAICel
 abDNIIwC6BEOp0iaJUzHpLZ0G4FBWmw=
Date: Fri, 14 May 2021 09:05:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJ4hS/SJYmCC9Rpd@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <DM4PR12MB5263A719B11C6DF8EF9F3A4BEE519@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5263A719B11C6DF8EF9F3A4BEE519@DM4PR12MB5263.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Fri, 14 May 2021 13:47:28 +0000
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

On Thu, May 13, 2021 at 11:10:34PM +0000, Joshi, Mukul wrote:
> That's probably not the best example to look at.

Oh, it is the *perfect* example but...

> smca_get_long_name() is used in drivers/edac/mce_amd.c and this file
> doesn't get compiled when CONFIG_X86_MCE_AMD is not defined.
>
> And amdgpu driver has no dependency on CONFIG_X86_MCE_AMD.

... maybe this will make you see it the right way: how much of the
amdgpu RAS functionality you're adding, is going to even function
without CONFIG_X86_MCE_AMD?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
