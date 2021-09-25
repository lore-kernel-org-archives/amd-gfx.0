Return-Path: <SRS0=K0ja=OR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738EAC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 07:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1886F61165
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Sep 2021 07:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1886F61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 260C76E83C;
	Mon, 27 Sep 2021 07:30:32 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 208BD6E3EC
 for <amd-gfx@lists.freedesktop.org>; Sat, 25 Sep 2021 11:21:10 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1bac00c299c4b579452b16.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f1b:ac00:c299:c4b5:7945:2b16])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20A211EC05E2;
 Sat, 25 Sep 2021 13:21:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1632568864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=7lwTvw436hmF3Y3GbvXEGF+jEH1nN3GmL3cFs+61EGc=;
 b=g9rL/9qJwvzkA7ANvscQ39xtPncQb6k05Ih3B8Bh0saxRL9smQ3EWzhHbMMXb5b9tEQcaV
 9BVufb0EFLlpK+0G3htKz9YgMSO3oVVtB0ChRzHN2H9fiM6E0dasLNARDrXM4mPJrx/ae+
 RAjBwe5hB/I0PdzlRtcvAgu7hX5HtvU=
Date: Sat, 25 Sep 2021 13:20:57 +0200
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
Message-ID: <YU8GGSrQSbAZPz4z@zn.tnic>
References: <20210913021311.12896-2-mukul.joshi@amd.com>
 <20210922193620.15925-1-mukul.joshi@amd.com>
 <YUyPM7VfYFG/PJmu@yaz-ubuntu>
 <DM4PR12MB52639349DF98DB01A3B155EFEEA39@DM4PR12MB5263.namprd12.prod.outlook.com>
 <YUy4CdcUWJzQfM4N@yaz-ubuntu> <YUzD9wxtV411S8TC@zn.tnic>
 <YU4rAigWIh8g6iOl@yaz-ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YU4rAigWIh8g6iOl@yaz-ubuntu>
X-Mailman-Approved-At: Mon, 27 Sep 2021 07:30:31 +0000
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

On Fri, Sep 24, 2021 at 07:46:10PM +0000, Yazen Ghannam wrote:
> I agree with you in general. But this device isn't really a GPU. And
> users of this device seem to want to count *every* error, at least for
> now.

Aha, so something accelerator-y where they do general purpose computation.

So what's the big picture here: they count all the errors and when they
reach a certain amount, they decide to replace the GPUs just in case?

Or wait until they become uncorrectable? But then it doesn't matter
because we will handle it properly by excluding the VRAM range from
further use.

Or do they wanna see *when* they had the correctable errors so that they
can restart the computation, just in case.

Dunno, it would be a lot helpful if we had some RAS strategy for those
things...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
