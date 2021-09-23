Return-Path: <SRS0=N7Ef=ON=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70904C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 18:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36528601FA
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Sep 2021 18:17:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 36528601FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D656E0E3;
	Thu, 23 Sep 2021 18:17:33 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F6906E103
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Sep 2021 18:14:21 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0d6800010999bf90259edb.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0d:6800:109:99bf:9025:9edb])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 97FE21EC056A;
 Thu, 23 Sep 2021 20:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1632420855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=R7oLhQbzsvsWj62mAcUhSOp2J72g6MKSMJkSIUrXPks=;
 b=ZPDOHZfv/mpV4aX4K9LrNeUYhNAzsUrOnoVZwtAo9CwQ5VnyKDbcpsONX+MUqJpEm7TKqp
 YyypdTVA8mDa7fOIuQfrLspmdHOYYyn2eQsv+Z1dwc8u+NrjFJib+CEytAaPOCUeHF0Qp1
 CFjyWJep9rSIrqhS0wKp04lWYkby/l8=
Date: Thu, 23 Sep 2021 20:14:15 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCHv3 2/2] drm/amdgpu: Register MCE notifier for Aldebaran RAS
Message-ID: <YUzD9wxtV411S8TC@zn.tnic>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com>
 <YUyPM7VfYFG/PJmu@yaz-ubuntu>
 <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YUy4CdcUWJzQfM4N@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUy4CdcUWJzQfM4N@yaz-ubuntu>
X-Mailman-Approved-At: Thu, 23 Sep 2021 18:17:33 +0000
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

On Thu, Sep 23, 2021 at 05:23:21PM +0000, Yazen Ghannam wrote:
> Shouldn't the error still be reported to EDAC for decoding and counting? I
> think users want this.

You know what happens with users getting ECCs reported, right? They
think immediately their hw is going bad and start wanting to replace
it...

So what does actually tell you if you were a simple user and you had 5
correctable errors in the GPU VRAM?

All you wanna do is play, I'd say.

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
