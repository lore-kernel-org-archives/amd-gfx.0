Return-Path: <SRS0=HfWL=CX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB03C43461
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 05:17:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABFF21655
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2020 05:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="krqkoQiX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABFF21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0601C6E0C1;
	Mon, 14 Sep 2020 05:17:42 +0000 (UTC)
X-Greylist: delayed 487 seconds by postgrey-1.36 at gabe;
 Sat, 12 Sep 2020 08:51:06 UTC
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BDB36E0E7;
 Sat, 12 Sep 2020 08:51:06 +0000 (UTC)
Received: from zn.tnic (p200300ec2f1f6200b3d433c484530811.dip0.t-ipconnect.de
 [IPv6:2003:ec:2f1f:6200:b3d4:33c4:8453:811])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77BA11EC0347;
 Sat, 12 Sep 2020 10:42:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
 t=1599900174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Edl34YjZc7cv5n6S9xNqGakk91/esbOTK2KIQRl/MTM=;
 b=krqkoQiXsRhZTUzFtb0YQ6Kb+YN+XhVW3mS4W5DMB85RwBuoiNxkjEHffPN21Gu4OEZ4GA
 KLxEwMRZlcJ6Ejw6i3IimWMjh+WJAg0mriceZC0NoZffsXv8/XnHHWY5e0P9eH8i5i4v5V
 +0VIiw8VcJkcTXHP9Z7xo0E22ksrBxY=
Date: Sat, 12 Sep 2020 10:42:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: first bad commit: [fc8c70526bd30733ea8667adb8b8ffebea30a8ed]
 drm/radeon: Prefer lower feedback dividers
Message-ID: <20200912084255.GB4827@zn.tnic>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 14 Sep 2020 05:17:40 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, dri-devel@lists.freedesktop.org,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

this patch breaks X on my box - it is fully responsive and I can log in
into it from another machine but both monitors are black and show this:

"The current input timing is not supported by the monitor display. Please

change your input timing to 1920x1200@60Hz or any other monitor

listed timing as per the monitor specifications."

Reverting it fixes the issue.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
