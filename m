Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD6BCD98EE
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 08:54:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFB4C10EEFF;
	Wed, 17 Jun 2026 08:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iArlWrHW";
	dkim-atps=neutral
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F27C710EEED
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 08:54:50 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ggHjg4P44z9v8h;
 Wed, 17 Jun 2026 10:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781686487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RY/xsByTrOU91RetAIh8oOO6g3ivb2EbISGMITVzFDs=;
 b=iArlWrHWUoZ+jqjxV/71Fo8A+C1Tq7Gl8KPUlxNMvFTA0IGUiY9EfyCdEkynmqsUhf++0E
 ayq1H3oSQI/adPQ62D45Im9utO54Tq+nOqraJLaKMJCznisqREhfW0z7E3Aqjtn4w2j9ka
 CdAQDMxewFA5UWTO9cRyNuBFdBIOTZL3psSNrnvs1rXHM4OMROOIwO05jSwfhy+54Vg38p
 j5HgDIO9idMuJZmFhtfVFujpYkIVVyKeXBh4RCJ03qkSdwRVCWXalSbWPN4SOfx6oY3VjD
 8RPJVs5NKBx5oX98rpc7ypIz4P4qoJ6RVBLW2IT9wC20Mb1vEgtFtzjqPgQY+Q==
Message-ID: <4e3b5744-e797-4026-aae6-e2a4ec49d905@mailbox.org>
Date: Wed, 17 Jun 2026 10:54:44 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] drm/amd/display: check GRPH_FLIP status before
 sending event
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com, stable@vger.kernel.org
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-3-sunpeng.li@amd.com>
From: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Content-Language: en-CA
In-Reply-To: <20260616201828.389985-3-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: eh9fs3zibkf6fj435aya7dt83zcug9o6
X-MBO-RS-ID: 3d650d757189b9313ca
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

On 6/16/26 22:18, sunpeng.li@amd.com wrote:
> 
> 2. There is a window during commit where a flip is armed (pflip_status =
>    SUBMITTED) but not yet programmed into HW. If the VUPDATE_NO_LOCK
>    fires in that window, it's handler would deliver a flip event to
>    userspace before HW has latched to it. If userspace then renders to
>    what it believes is now the back buffer (but HW is still latched to
>    it!), it will cause display corruption. (This issue seemed to have
>    existed ever since the introduction of pflip_status.

AFAICT this issue was introduced by 1159898a88db ("drm/amd/display: Handle commit plane with no FB.").

pflip_status was already there before DC, and AFAICT amdgpu_flip_work_func has always handled this correctly.


-- 
Earthling Michel Dänzer       \        GNOME / Xwayland / Mesa developer
https://redhat.com             \               Libre software enthusiast
