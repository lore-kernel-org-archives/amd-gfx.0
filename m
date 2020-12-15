Return-Path: <SRS0=Z3Jh=FT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6322CC4361B
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 19:10:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 090DF22B2C
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Dec 2020 19:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090DF22B2C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628D089C99;
	Tue, 15 Dec 2020 19:10:43 +0000 (UTC)
X-Greylist: delayed 74265 seconds by postgrey-1.36 at gabe;
 Tue, 15 Dec 2020 19:07:52 UTC
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1D7989B9A
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Dec 2020 19:07:52 +0000 (UTC)
Received: from zn.tnic (p200300ec2f0f9e009c14e1abc4cc14de.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f0f:9e00:9c14:e1ab:c4cc:14de])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6CDC21EC04E2;
 Tue, 15 Dec 2020 20:07:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1608059271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
 bh=Y7ATcfrK47SnWop8qgLP9xxPQlkADRNQks6b3KI3qSA=;
 b=ZwpQI54b4wFb8SBAjZ39YLXdGvbX1HWakm/sfwN42RiBao/TIDrxvVqtbzqB5lOWwUDZFa
 rXJQB0aAX9J36pHeDJ9kInk3JhFksNg6BKo3VHIFQdCc49rtNa27Tygc3EOaxEP5zvYPZx
 eH3gc6/2TFdnD1DFMeKslttQG311d6M=
Date: Tue, 15 Dec 2020 20:07:52 +0100
From: Borislav Petkov <bp@alien8.de>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: 8353d30e747f ("drm/amd/display: disable stream if pixel clock
 changed with link active")
Message-ID: <20201215190752.GF9817@zn.tnic>
References: <20201211155553.GC25974@zn.tnic>
 <20201215154703.6gwm2ew337pqysq4@outlook.office365.com>
 <20201215155622.GC9817@zn.tnic>
 <20201215160720.ewce4usgb53pzt2j@outlook.office365.com>
 <CADnq5_MSJdrmxNW9jhdQPOZLUdkJtZMyA6FmqjyZsgGHBWoXVg@mail.gmail.com>
 <20201215164234.ywgesdqup6zdjxw4@outlook.office365.com>
 <CADnq5_N=CiuGKe4V-4a8s=SEAR9M4W8X_vdshgbwXH2b9u+L2g@mail.gmail.com>
 <20201215184306.GD9817@zn.tnic>
 <20201215190058.p6osaztp6wi6ci3p@outlook.office365.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201215190058.p6osaztp6wi6ci3p@outlook.office365.com>
X-Mailman-Approved-At: Tue, 15 Dec 2020 19:10:42 +0000
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
Cc: Chiawen Huang <chiawen.huang@amd.com>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Deucher <alexdeucher@gmail.com>,
 Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 15, 2020 at 02:00:58PM -0500, Rodrigo Siqueira wrote:
> Thanks for reporting this issue and test the fix.

It was my pleasure. Thanks for the quick fix!

:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
