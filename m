Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE9EE7E656
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 17:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB4C910E145;
	Tue, 26 Sep 2023 17:39:19 +0000 (UTC)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBC6910E145
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 17:39:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 65416CE1686
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 17:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D7DC433C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695749955;
 bh=5ZO/7vh6HL62boq6ksnA2b3dOsJKDalhlsSd1Dkxp+Q=;
 h=In-Reply-To:References:Date:From:To:Subject:From;
 b=jNW/zPvK4aQazHGBPNR47kP0Mantm1O6Zo0yr8AUl4zjFaLF8BIMT2zgfzzoGG6PV
 DsLpWKKT8DmPX6Ow+r/mYUZJ1qlpxOMDHSDzKJIrQrlMrOxVNUGx2OljP0ai2tMHO3
 KJXqMsJtqTHbF/2QjmWBKWEEOSliQvTvFsiDLtRWObUzsQYrDindmsm3rff6czJeCL
 HgcqpqheaO6VSZgZeHogQmOxbxF0ZFiAh/3qBLAOWHJsVFhAwAHI8bkqbXWdvQ4Ay7
 bOIaKOmqTRroXnXqLbMVnWxoEUanHmlk9SZSHGSLzH5s4OLVT9GVoyTPdIkne6mJtU
 ntJWMCa4Loiow==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailauth.nyi.internal (Postfix) with ESMTP id 72E4127C0060;
 Tue, 26 Sep 2023 13:39:14 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Tue, 26 Sep 2023 13:39:14 -0400
X-ME-Sender: <xms:QhcTZa6rI69FmWhZj50VwSg5AMp_aRNwVp0EHiZ8-6bgmJTOzQjnTw>
 <xme:QhcTZT6JzA6sZuwqDDpw3gZLak6HDIXftZVHZiTOwY9ZcNls8_JSQLBk49B7Ux5n-
 _43GEDf1sr4BgK2d3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdekhecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
 uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
 htvghrnhepteetfedtieeiudduvefggeevveeuheetleefjeeiteejjeeuvdevtdfhuefh
 ueeknecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrh
 fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgr
 uhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrg
 hrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:QhcTZZd77FCynt7BOvHVeax8KIOdkJLKsXGEZiUa6RvQ5C2s73djTw>
 <xmx:QhcTZXK10RFND-BirdkADxhIp2VJ5sbedYvqFzPEWrXUOpR-txC7_g>
 <xmx:QhcTZeJxqlwcHrqGoQiYWbT3uXGMHPch0QZGVHvgKHp20FirlB__kw>
 <xmx:QhcTZdllVbmdhqFeD3dfloVWTEN4MQasqb70vkQmsCN2Bz98b8oppA>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 08C99B6008D; Tue, 26 Sep 2023 13:39:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <ab30e882-74af-4ee3-8e41-fc36fb517ec3@app.fastmail.com>
In-Reply-To: <20230926163938.1013775-1-alexander.deucher@amd.com>
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
Date: Tue, 26 Sep 2023 19:38:53 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amdkfd: reduce stack size in
 kfd_topology_add_device()
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Sep 26, 2023, at 18:39, Alex Deucher wrote:
> kfd_topology.c:2082:1: warning: the frame size of 1440 bytes is larger 
> than 1024 bytes
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2866
> Cc: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
