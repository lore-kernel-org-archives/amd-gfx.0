Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26042C433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 15:29:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C20AA613DF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 15:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C20AA613DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A81A6EEC1;
	Fri, 14 May 2021 15:29:10 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 440CB6EE91
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 14:38:20 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0b2c001b1c8d89a706f2ca.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0b:2c00:1b1c:8d89:a706:f2ca])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 202691EC0537;
 Fri, 14 May 2021 16:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1621003098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=56UXFskDRro/v9sxWzMI7cd2EQdQ1g/Ab6XrYnboPHY=;
 b=l6ulfs7RoVDOCFi04UqltMLII+y7afq7VEDMQQhzJJPZPFDp6UHaD/pm7/7eODbSlyEhaI
 IK0IZk+2mBuk8WS0N5i28eS2uqsDJ2kq2vKTIoxz1v1fzTBaYZyhaPeh+NPIT3TnQc1gwB
 opRwOpFGOAq43qMhE700hrizvFOpRfs=
Date: Fri, 14 May 2021 16:38:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Register bad page handler for Aldebaran
Message-ID: <YJ6LVqYTwQHReffu@zn.tnic>
References: <20210512013058.6827-1-mukul.joshi@amd.com>
 <YJuhs1WsqtJ7ta1L@zn.tnic>
 <DM4PR12MB5263797EB7B2D37C21427A88EE529@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJxDIhGnZ5XdukiS@zn.tnic>
 <DM4PR12MB52631035F875B77974FA8D21EE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJz3CMBFFIDBzVwX@zn.tnic>
 <DM4PR12MB5263A719B11C6DF8EF9F3A4BEE519@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YJ4hS/SJYmCC9Rpd@zn.tnic>
 <DM4PR12MB52634855954DCE456D244288EE509@DM4PR12MB5263.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DM4PR12MB52634855954DCE456D244288EE509@DM4PR12MB5263.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Fri, 14 May 2021 15:29:09 +0000
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

On Fri, May 14, 2021 at 01:06:33PM +0000, Joshi, Mukul wrote:
> We have RAS functionality in other ASICs that is not dependent on
> CONFIG_X86_MCE_AMD. So, I don't think we would want to do that just
> for one ASIC.

Lemme try again: you said that those errors do get reported through a
deferred interrupt. Which is likely amd_deferred_error_interrupt().

If it is that interrupt and you don't have CONFIG_X86_MCE_AMD enabled,
then you won't get any errors reported and your RAS functionality will
simply sit there inactive.

So if that above is true - something to which I'm still not getting
an answer but maybe one fine day... - so if that above is true, your
RAS functionality *needs* CONFIG_X86_MCE_AMD to be enabled in order to
*actually* function.

So you *must* make your RAS functionality depend on CONFIG_X86_MCE_AMD
- otherwise no deferred interrupts and no errors reported. It is that
simple.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
