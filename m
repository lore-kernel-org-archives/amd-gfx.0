Return-Path: <SRS0=EYW0=OM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695A7C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 18:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F2A6115A
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Sep 2021 18:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 12F2A6115A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5F6A6E02D;
	Wed, 22 Sep 2021 18:00:52 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57A776EC42
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Sep 2021 16:44:04 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0efa00329c23fffea6a903.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0e:fa00:329c:23ff:fea6:a903])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C0821EC051E;
 Wed, 22 Sep 2021 18:43:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1632329038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=gtI3K23I3DhUzNiqPHLOEAfHrx+nTcEGqXkTAZ9qlCU=;
 b=B78ccUbaTflJwSlp4crJv5l0xPOE0KEqw94W2kirQHTVZFGv3UN/IjnwkD4oraE9V/DVLt
 GaS1VJP2KkdG0htPx+7Vfx8V20x9GgNfs9zRr0ge+GZxjzQof8kLPV3kNhQ3FPRtuCowcW
 Lp5GQA9UIZk/+moBWADlWYbCaBg5CQs=
Date: Wed, 22 Sep 2021 18:43:52 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Joshi, Mukul" <Mukul.Joshi@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "mchehab@kernel.org" <mchehab@kernel.org>,
 "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCHv2 1/2] x86/MCE/AMD: Export smca_get_bank_type symbol
Message-ID: <YUtdSO8QZWiPeYwr@zn.tnic>
References: <20210511152538.148084-2-nchatrad@amd.com>
 <20210913021311.12896-1-mukul.joshi@amd.com>
 <YUsUpkvP8zpz8yRz@zn.tnic>
 <BL1PR12MB51444DA94F2DE3D12BBF31D1F7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51444DA94F2DE3D12BBF31D1F7A29@BL1PR12MB5144.namprd12.prod.outlook.com>
X-Mailman-Approved-At: Wed, 22 Sep 2021 18:00:51 +0000
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

On Wed, Sep 22, 2021 at 04:27:34PM +0000, Deucher, Alexander wrote:
> > On Sun, Sep 12, 2021 at 10:13:10PM -0400, Mukul Joshi wrote:
> > > Export smca_get_bank_type for use in the AMD GPU driver to determine
> > > MCA bank while handling correctable and uncorrectable errors in GPU
> > > UMC.
> > >
> > > v1->v2:
> > > - Drop the function is_smca_umc_v2().
> > > - Drop the patch to introduce a new MCE priority (MCE_PRIO_ACEL)
> > >   for GPU/accelarator cards.
> > 
> > Patch changelog information goes...
> > 
> > >
> > > Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> > > ---
> > 
> > ... under this line so that it gets automatically removed by git when applying
> > the patch.
> > 
> > Alex, how do you wanna handle this?
> > 
> > Want me to ACK this and you can carry it through your tree along with the
> > second patch?
> 
> That would be great.  Thanks!

Ok, with the above changelog removed:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
