Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187A1C4741F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 12:31:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DB3B20759
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 12:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB3B20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8047989DE1;
	Tue, 29 Sep 2020 12:31:20 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7500589C09
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 07:16:03 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 33B84AD57;
 Tue, 29 Sep 2020 07:16:02 +0000 (UTC)
Date: Tue, 29 Sep 2020 09:16:00 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: Regression in amdgpu driver / kernel v5.8.6
Message-ID: <20200929091600.750c8b41@endymion>
In-Reply-To: <20200929081404.4d8df525@endymion>
References: <20200928111037.51ed4aeb@endymion>
 <CADnq5_OBSxK=Ds7X-e8xfHUDb0js7vtWbz-y7mabpFg0BhB5kw@mail.gmail.com>
 <20200929081404.4d8df525@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
X-Mailman-Approved-At: Tue, 29 Sep 2020 12:31:19 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Navid Emamdoost <navid.emamdoost@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 29 Sep 2020 08:14:04 +0200, Jean Delvare wrote:
> On Mon, 28 Sep 2020 17:44:28 -0400, Alex Deucher wrote:
> > Nice analysis.  I've applied the patch.  
> 
> Unfortunately, further testing shows that this partial revert is
> insufficient to fully fix the problem.

Argh, scratch this. Accidentally booted the wrong kernel this morning,
just noticed. That kernel did not have the fix, so of course the bug
was "back".

Sorry for the noise, I'll keep testing the right kernel today.

-- 
Jean Delvare
SUSE L3 Support
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
