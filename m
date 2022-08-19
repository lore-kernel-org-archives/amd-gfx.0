Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192AFC32772
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Aug 2022 11:04:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 573C010E8C4;
	Fri, 19 Aug 2022 11:04:50 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B687410E883
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Aug 2022 11:04:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0DD56B82742;
 Fri, 19 Aug 2022 11:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99889C433C1;
 Fri, 19 Aug 2022 11:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660907078;
 bh=Q1fuI6kaHUAKv7wckjSX+NjcOnO//x+YueLRXxDkRVo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:From;
 b=OiH9oAxVgOifiMh44MQ7+gci9H9HpPzkUVcSXO2NlagkWNs+eW2yhvdrtgbBPsYYk
 rNzaSQ6i6Udw9TmNlTPvYQnZ9Pe/IdaQr5FY1wwpRW0/XK+o7vPgd6w6GAo71JNbnY
 9s6GtGMpRvVicUzj64cVvG6tpr3SWtC1H1GBpu+KrPW+z6AlJFPVU6IHF1LZpOtNXn
 VuHxQI4LBR1x0czrNCfqsU7uDKyhX6njsOkBIsMl/iuzyGaqit1yLwUgHRFJaugeHw
 0IxtxOfAj/x/+FP9LfZ19q9XRtgUaCu0Zfvd9UDqidQr/gaql2+USeEBSgVC63HgtQ
 2YkTgG9vK/aEQ==
Date: Fri, 19 Aug 2022 06:04:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [Bug 216373] New: Uncorrected errors reported for AMD GPU
Message-ID: <20220819110437.GA2432401@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc036a10-5c13-fdd7-9d98-2b5f0f8af383@amd.com>
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
Cc: regressions@lists.linux.dev, David Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Xinhui Pan <Xinhui.Pan@amd.com>,
 amd-gfx@lists.freedesktop.org, Tom Seewald <tseewald@gmail.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Stefan Roese <sr@denx.de>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 19, 2022 at 02:03:59PM +0530, Lazar, Lijo wrote:

> Or, it could be amdgpu or some other software component -
> 
> register mmio base: 0x95E00000
> Address       0x95e7f000
> 
> 0x95e7f000 indicates access from CPU to a register offset 0x7FE000. This
> doesn't look like a valid register offset for this chip (device
> [1002:73df]). Any other clues in dmesg?

The complete dmesg is at
https://bugzilla.kernel.org/attachment.cgi?id=301596
