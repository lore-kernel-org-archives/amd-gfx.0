Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBEFC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:20:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E6432078B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 16:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6432078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BFF689D53;
	Tue, 15 Dec 2020 16:20:38 +0000 (UTC)
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 609426E3F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 15:56:29 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0f9e00f1a225f790dae810.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0f:9e00:f1a2:25f7:90da:e810])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74CF01EC052C;
 Tue, 15 Dec 2020 16:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1608047786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=jo3x3cAXCEFcVh/x07VCfdFGsck/d89LJzeAOW0iS4k=;
 b=X5ENld1jV1a5fXRQaZ6bkmGIUHUoQPDXB4a9GjpjYIBRi2ly5nR1A9epDHqoPaFOGsipxL
 UL+c73vyIEv1VjPpNKMRzc1WtYacolOgTo8VdU11ZOLa00IgxS1IQ0zHLo9LaSYR/Kd1BZ
 pbkmNGNtyAMSZ9XBDsA1yrnVmdW/o7k=
Date: Tue, 15 Dec 2020 16:56:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215155622.GC9817@zn.tnic>
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
X-Mailman-Approved-At: Tue, 15 Dec 2020 16:20:37 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Chiawen Huang <chiawen.huang@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 15, 2020 at 10:47:03AM -0500, Rodrigo Siqueira wrote:
> Hi Boris,
> 
> Could you check if your branch has this commit:
> 
>  drm/amd/display: Fix module load hangs when connected to an eDP
> 
> If so, could you try this patch:
> 
>  https://patchwork.freedesktop.org/series/84965/

So I did a bisection between

git bisect start
# bad: [3650b228f83adda7e5ee532e2b90429c03f7b9ec] Linux 5.10-rc1
git bisect bad 3650b228f83adda7e5ee532e2b90429c03f7b9ec
# good: [bbf5c979011a099af5dc76498918ed7df445635b] Linux 5.9

and the patch in $Subject came in in 5.10-rc1.

I can test any tree you want me to so just tell me on which tree to
apply this patch and I'll run it.

In any case, it doesn't apply on v5.10 though:

$ test-apply.sh /tmp/rodrigo.siqueira 
checking file drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
Hunk #1 FAILED at 120

You can push a tree of yours somewhere which I can try directly,
alternatively.

Lemme know.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
