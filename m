Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5CDE7E65A
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 19:29:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03E3010E158;
	Tue, 26 Sep 2023 19:29:32 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0272610E158
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 19:29:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 1E984B811C7;
 Tue, 26 Sep 2023 19:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48385C43391;
 Tue, 26 Sep 2023 19:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695756567;
 bh=ozfACd/aFOxTVeZVEqBY9ZYsLQRbtoNKNkBULeIPIE0=;
 h=In-Reply-To:References:Date:From:To:Subject:From;
 b=VfLULX3jSEJMwMplrawhPMCrDpfGsgVSHBX3fy8z4osQb7QSIc+R7B6VUyq6ozfwe
 kqcINoh6I+RpMld7jxmX7ByaS6AsFk4y1/tTqzs/VvgKZQCgWTijBPF03BUNINzmpH
 94jYoCERIp+I7AejHNm2tyYitw092CwY6SvAKu9eygPj9f5B/C9RTM50HfmIoAmVk+
 h6ntAj8u0CD1lSy0SKQT+c7Shl1zpYXBb6aqj6vN+QSsMQ/yK6JbyLnTY3K9DYPKSZ
 mhK3LO8+BKGLShCWOkJMSah2+LeIlhPKI0MdUYfSsK1cKF1AGQGB2h8PRjtUuyC1aH
 2/poHDl1D22ow==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailauth.nyi.internal (Postfix) with ESMTP id 2AA0427C005C;
 Tue, 26 Sep 2023 15:29:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Tue, 26 Sep 2023 15:29:26 -0400
X-ME-Sender: <xms:FTETZTYKGyIH7pCN8abAYFOukm7KBO4iuVLWlKHn7eOuQTOFkbg_bQ>
 <xme:FTETZSb5bVb4eR9VO456H4CVkrOzcc_W7yGU_Hc6elb1Rdo062XIN9hvBCzygY8ld
 ydSl78JKrpgIquE07Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgddutdekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
 ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
 htthgvrhhnpefhteevteffveelgffgudetfffgheeiffeujeekvdejteevffeukeevvdei
 udefieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddv
 gedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdrug
 gv
X-ME-Proxy: <xmx:FjETZV-REzUNUqJY2cwGEvZof-pvMRXg1zu76Hd-TRWX4T-TuDM_RQ>
 <xmx:FjETZZqrZ9hfscNp_aXbhDM85gLZ59J-jDzOUjj38dkMwVzW8JBTHw>
 <xmx:FjETZeowjELLUVGlTWYBwVKR4KLQc3tPdf5vK01rFNK3QqpxcTu5iw>
 <xmx:FjETZcHqLX6CUveclejX8btVnyNvSl482U-zE-FViZJZquXRmtsm7w>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D3351B60089; Tue, 26 Sep 2023 15:29:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <bee15872-1ed6-44b8-815e-c9480e931c98@app.fastmail.com>
In-Reply-To: <BL1PR12MB514412C97B429FEF7218EFD2F7C3A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
 <20230926163938.1013775-2-alexander.deucher@amd.com>
 <df3b7de0-972d-4df4-a52e-828015f062f6@app.fastmail.com>
 <BL1PR12MB514412C97B429FEF7218EFD2F7C3A@BL1PR12MB5144.namprd12.prod.outlook.com>
Date: Tue, 26 Sep 2023 21:29:04 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Alex Deucher" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
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

On Tue, Sep 26, 2023, at 20:47, Deucher, Alexander wrote:
>> From: Arnd Bergmann <arnd@kernel.org>
>> Subject: Re: [PATCH 2/2] drm/amdkfd: drop struct kfd_cu_info
>>
>> On Tue, Sep 26, 2023, at 18:39, Alex Deucher wrote:
>> > I think this was an abstraction back from when kfd supported both
>> > radeon and amdgpu.  Since we just support amdgpu now, there is no more
>> > need for this and we can use the amdgpu structures directly.
>> >
>> > This also avoids having the kfd_cu_info structures on the stack when
>> > inlining which can blow up the stack.
>> >
>> > Cc: Arnd Bergmann <arnd@kernel.org>
>> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> Nice cleanup!
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>> I guess you could fold patch 1/2 into this as it removes all the added code from
>> that anyway.
>
> I left it as a separate patch as I didn't get a chance to see when the 
> stack warning appeared and figured it might be a good way to mitigate 
> that on stable kernels if necessary without pulling in the whole 
> rework, but if not, I can just squash it into the second patch.

Makes sense. FWIW, I had never seen the warning before updating
to linux-next this week from an older snapshot from last month.

My guess is that one of the recent changes made gcc take
different inlining decisions so we end up with two copies
of the cu_info in the same stack frame, even though the
fundamental problem was there already.

    Arnd
