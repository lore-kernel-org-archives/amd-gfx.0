Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307FAC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 06:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B5A10E329;
	Fri, 15 Dec 2023 06:35:46 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEB1910E95A
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 06:35:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id EA377CE27AD;
 Fri, 15 Dec 2023 06:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BCD7C433C8;
 Fri, 15 Dec 2023 06:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702622140;
 bh=Dn71pnp1Fex8QG4wBzzTBZfQB4hdIO33Nsn74V1lK2I=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=fOePsk9bBNBlA1shPOJMUTrvU7RBq6fRxexVtCBTacxkiDhTiMOfoZEHdCUC7Ati7
 j5dSki9HgTHaM81FW66DPJB9K5hLaFvNiTsLRbip71VCTu3ifwEsf1fTvqu+5h9lxW
 d3OJiI6+tJk1gkIfsO6GTQr7v+P59e/rQHR5BUeXyknGpsKtOHrdkWDKRNywBA9cwk
 TO2pAy8gttM30GwW2ueLNioLr0X3ia5uLs3ACi0EmdZ0npsrc69fS2jW+nrOeAoqIl
 AG3mJZNaFjSyuLJ7jmMK6JrKy0+hkNFnf8dViVPT4GqdmmwJzG5+6yNj+cDaqz9G0f
 l95v+vmnK5zpA==
From: Kalle Valo <kvalo@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and
 wifi / amdgpu due for the v6.8 merge window
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
 <87le9w4u6v.fsf@kernel.org>
 <8bd60010-7534-4c22-9337-c4219946d8d6@amd.com>
Date: Fri, 15 Dec 2023 08:35:35 +0200
In-Reply-To: <8bd60010-7534-4c22-9337-c4219946d8d6@amd.com> (Mario
 Limonciello's message of "Thu, 14 Dec 2023 10:47:01 -0600")
Message-ID: <87bkasm0qw.fsf@kernel.org>
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
Cc: Ma Jun <Jun.Ma2@amd.com>, linux-wireless <linux-wireless@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, Alex Deucher <alexander.deucher@amd.com>,
 Ilpo =?utf-8?Q?J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mario Limonciello <mario.limonciello@amd.com> writes:

> On 12/14/2023 10:36, Kalle Valo wrote:
>
>> Hans de Goede <hdegoede@redhat.com> writes:
>> 
>>> Hi Wifi and AMDGPU maintainers,
>>>
>>> Here is a pull-request for the platform-drivers-x86 parts of:
>>>
>>> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.Ma2@amd.com/
>>>
>>>  From my pov the pdx86 bits are ready and the
>>> platform-drivers-x86-amd-wbrf-v6.8-1 tag can be merged by you to merge
>>> the wifi-subsys resp. the amdgpu driver changes on top.
>>>
>>> This only adds kernel internal API, so if in the future the API
>>> needs work that can be done.
>>>
>>> I've not merged this branch into pdx86/for-next yet, since I see
>>> little use in merging it without any users. I'll merge it once either
>>> the wifi or amdgpu changes are also merged (and if some blocking
>>> issues get identified before either are merged I can prepare a new
>>> pull-request fixing the issues).
>> I was testing latest wireless-testing with ath11k and noticed this:
>> [  370.796884] ath11k_pci 0000:06:00.0: WBRF is not supported
>> I think that's just spam and not really necessary. Could someone
>> remove
>> that or change to a debug message, please?
>> 
>
> Do you have dynamic debug turned up perhaps?  It's already supposed to
> be a dbg message.
>
> +	dev_dbg(dev, "WBRF is %s supported\n",
> +		local->wbrf_supported ? "" : "not");

Oh, I should have checked that. I do have it enabled:

CONFIG_DYNAMIC_DEBUG=y
CONFIG_DYNAMIC_DEBUG_CORE=y

But that shouldn't enable the debug message unless I specifically enable
it via debugfs, right? But then I noticed this in net/mac80211/Makefile:

ccflags-y += -DDEBUG

I'm guessing this is the reason why the debug message is always printed?

It looks like wbrf.c has the only dev_dbg() call in mac80211, all others
use the macros from net/mac80211/debug.h. I think wbrf.c should also use
one of the macros from debug.h and not dev_dbg().

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
