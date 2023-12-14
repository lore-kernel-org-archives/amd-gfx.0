Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D2EC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 16:41:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FAFA10E04F;
	Thu, 14 Dec 2023 16:41:25 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B449310E04F
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 16:41:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id EE98C62312;
 Thu, 14 Dec 2023 16:41:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8033C433C7;
 Thu, 14 Dec 2023 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702572082;
 bh=aR0AfO4Zo8a3/6CuOkcgFklla3J0GR//5YEavtZmcQs=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=GAkZjkxq8d7vJm4HIljWKOFiPA/2BaPPlaKZHPZLRO4DD9wbOPXlgbeH+TLYP80AN
 FwpgqFP1DI/D308SUJ9TxRb+/r63ETwuEw//2P2LhWxPQv75QE7qZXYHYXty/YuwJW
 pPRySd8xG8XoCoQ55EaAlQIfVfGovXBUuY3xBOeRa8WbqAZ7aU2+N9avI86gzFNPcq
 plgeZFHkfCFUJIXkWPhhYUYjyJfxnlp58CCzIelrlYYYO+TS58TbEWqa1LO2RiWaPV
 hnNMPKstrMT6M9WYuL3zUy4iNnZm1hux6CKimeuWh6NV5lqEsqQ6YD84lp/FSyJIYx
 sWEKi2H6vIl4g==
From: Kalle Valo <kvalo@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and
 wifi / amdgpu due for the v6.8 merge window
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
Date: Thu, 14 Dec 2023 18:36:56 +0200
In-Reply-To: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com> (Hans de
 Goede's message of "Mon, 11 Dec 2023 12:02:16 +0100")
Message-ID: <87le9w4u6v.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 Ma Jun <Jun.Ma2@amd.com>, "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hans de Goede <hdegoede@redhat.com> writes:

> Hi Wifi and AMDGPU maintainers,
>
> Here is a pull-request for the platform-drivers-x86 parts of:
>
> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>
> From my pov the pdx86 bits are ready and the
> platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge
> the wifi-subsys resp. the amdgpu driver changes on top.
>
> This only adds kernel internal API, so if in the future the API needs work that can be done.
>
> I've not merged this branch into pdx86/for-next yet, since I see
> little use in merging it without any users. I'll merge it once either
> the wifi or amdgpu changes are also merged (and if some blocking
> issues get identified before either are merged I can prepare a new
> pull-request fixing the issues).

I was testing latest wireless-testing with ath11k and noticed this:

[  370.796884] ath11k_pci 0000:06:00.0: WBRF is not supported

I think that's just spam and not really necessary. Could someone remove
that or change to a debug message, please?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
