Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9731EE49B1
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 07:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556BA10E063;
	Wed, 23 Aug 2023 07:52:51 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A588B10E063
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 07:52:48 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2DAF060C09;
 Wed, 23 Aug 2023 07:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88C7C433C8;
 Wed, 23 Aug 2023 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692777167;
 bh=n9oUBtOY4v6iN8QeG3ySrjb2E4LovnG5A5s20mkNAwU=;
 h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
 b=o4dbetyVcKe/463jEhmKakZIdv0sfO0FZftM7FIZ0vH45iTEYSZ26GGVWIhKi3lbQ
 zFnsbnvIxUzEA4WO47amELVI87xNbsAXaQ3D/tkafCpFg3ijjBTtXG0PMIckt1Ru1W
 ZZLZYu0A5xJ5e3VB+gMs+8QqvUQYmsSYFleqIdk/6vnr6Cw3QjyHn8IWjZmg06zNDV
 wwhthvluYf3IPZyrZpNseQjzG9VAszAw2uu9xSffsAcVyQurCPrj6k5vAImuK9HqfY
 AHNfHsQIkDlfYADV7Fbu0VvVutb9QW1W8II0gR4sIeEwBNYjUrBGRT6wJwiH9+CQue
 mgYgplV8zyurw==
From: Kalle Valo <kvalo@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
References: <20230818032619.3341234-1-evan.quan@amd.com>
 <20230818032619.3341234-2-evan.quan@amd.com>
 <2023081806-rounding-distract-b695@gregkh>
 <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
 <2023081919-mockup-bootleg-bdb9@gregkh>
 <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>
 <2023082247-synthesis-revenge-470d@gregkh>
Date: Wed, 23 Aug 2023 10:53:43 +0300
In-Reply-To: <2023082247-synthesis-revenge-470d@gregkh> (Greg KH's message of
 "Tue, 22 Aug 2023 08:39:00 +0200")
Message-ID: <87a5uiw5x4.fsf@kernel.org>
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
Cc: Andrew Lunn <andrew@lunn.ch>, pabeni@redhat.com, rafael@kernel.org,
 linux-wireless@vger.kernel.org, rdunlap@infradead.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, edumazet@google.com,
 "Limonciello, Mario" <mario.limonciello@amd.com>, horms@kernel.org,
 netdev@vger.kernel.org, alexander.deucher@amd.com, kuba@kernel.org,
 johannes@sipsolutions.net, Evan Quan <evan.quan@amd.com>,
 quic_jjohnson@quicinc.com, davem@davemloft.net, lenb@kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Mon, Aug 21, 2023 at 10:13:45PM -0500, Limonciello, Mario wrote:
>> So I wonder if the right answer is to put it in drivers/net/wireless
>> initially and if we come up with a need later for non wifi producers we can
>> discuss moving it at that time.
>
> Please do so.

Sorry, I haven't been able to follow the discussion in detail but just a
quick comment: if there's supposed to be code which is shared with
different wifi drivers then drivers/net/wireless sounds wrong,
net/wireless or net/mac80211 would be more approriate location.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
