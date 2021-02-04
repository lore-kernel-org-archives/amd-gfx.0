Return-Path: <SRS0=vrAH=HG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA829C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 13:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 704F864F53
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Feb 2021 13:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704F864F53
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210AC6E07D;
	Thu,  4 Feb 2021 13:38:12 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1636D6EC97
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Feb 2021 10:20:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AC618B039;
 Thu,  4 Feb 2021 10:20:52 +0000 (UTC)
Date: Thu, 4 Feb 2021 10:20:47 +0000
From: Michal Rostecki <mrostecki@suse.de>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: enable DPM_FLAG_MAY_SKIP_RESUME and
 DPM_FLAG_SMART_SUSPEND flags
Message-ID: <20210204102047.GA22909@wotan.suse.de>
References: <20210202171748.1062530-1-alexander.deucher@amd.com>
 <20210202171748.1062530-2-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210202171748.1062530-2-alexander.deucher@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailman-Approved-At: Thu, 04 Feb 2021 13:38:11 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Feb 02, 2021 at 12:17:48PM -0500, Alex Deucher wrote:
> Once the device has runtime suspended, we don't need to power it
> back up again for system suspend.  Likewise for resume, we don't
> to power up the device again on resume only to power it back off
> again via runtime pm because it's still idle.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I tested those patches on Dell G5 SE 5505 (RX 5600M / Renoir / 4800H),
which currently suffers from the dc_link_set_backlight_level issue[0].
I have an interesting observation. They don't fix the issue completely,
but after applying them, I'm able to susepnd the laptop once, without
loosing the brightness. Though after suspending the second time, I'm
loosing the brightness and the same usual
amdgpu_dm_backlight_update_status call trace pops out in dmesg.

Everything works properly (with and without patches) on my PC (RX 6900
XT / 5950X).

Since those patches improve the situation a bit on 5600M and work
without issues on 6900 XT, and the backlight race condition needs to be
fully fixes separately, feel free to add:

Tested-by: Michal Rostecki <mrostecki@suse.com>

[0] https://gitlab.freedesktop.org/drm/amd/-/issues/1337
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
