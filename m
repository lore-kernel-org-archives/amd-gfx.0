Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B815CFF8855
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2026 13:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F07E10E538;
	Wed,  6 May 2026 13:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q05cm8xA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E128C10E538
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2026 13:06:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A10960103;
 Wed,  6 May 2026 13:06:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45389C4AF09;
 Wed,  6 May 2026 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778072776;
 bh=IlZMq3fE6mU3e6b01+hjI7/b5NF+jy11Nd49eJo7tAs=;
 h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
 b=Q05cm8xAv/imj8L62aXVFsrtiHmKuu5vU2INRd2cvECRvFL6y3Ypoz5X3nP+2cxgW
 5o+mCNo9su2USupsqmfYdimCl9SUZzlKBnjAvnU5mH3T9uH5jbuNosDXaZUiIUOQsr
 7s58EHZBda0V2GNfMJpZV7nJuwT+6u5JhD61qFSfmaCBa6oahd0+egoc3OtY6MkCfF
 nH1K2yCH9XBdQS0f/26esN1ODtKAqcjE80NeENcLDVg4MKNn7liBi727+lsXcO/rlQ
 W7Mz1j7D4BHqDkBt+Mh6uCSndb5giyYmj+jZ82cfg6V+ZfmV7DrnGjrM7WRPU+kMOO
 ABqwJX1EP6WHw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfauth.phl.internal (Postfix) with ESMTP id 5581AF40070;
 Wed,  6 May 2026 09:06:15 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
 by phl-compute-01.internal (MEProxy); Wed, 06 May 2026 09:06:15 -0400
X-ME-Sender: <xms:xzz7aeiEAkDVE1Dla1pQVxoIUdnLaKAeat0cMr-buPHHqct8pZgpKg>
 <xme:xzz7aZ3a6RU6tCXB62njDMDWDilYJF36YfMy9XcGhVnR3K7U36gDL7VLxmjGbPH_C
 D2Clt5C2W6JKbtcOufR5fY93QJ9Vm1u77Lh2qLR9MsXz0HZZKcJo1Y_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdegieejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
 uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
 jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
 qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
 gurdgtohhmpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghp
 thhtoheprghlvgigrdhhuhhnghesrghmugdrtghomhdprhgtphhtthhopegruhhrrggsih
 hnughordhpihhllhgrihesrghmugdrtghomhdprhgtphhtthhopegthhhirghhshhurghn
 rdgthhhunhhgsegrmhgurdgtohhmpdhrtghpthhtoheptghhuhgrnhihuhdrthhsvghngh
 esrghmugdrtghomhdprhgtphhtthhopegurghnihgvlhdrfihhvggvlhgvrhesrghmugdr
 tghomhdprhgtphhtthhopeguihhllhhonhdrvhgrrhhonhgvsegrmhgurdgtohhmpdhrtg
 hpthhtohephhgrrhhrhidrfigvnhhtlhgrnhgusegrmhgurdgtohhmpdhrtghpthhtohep
 ihhvrghnrdhlihhpshhkihesrghmugdrtghomhdprhgtphhtthhopehjvghrrhihrdiiuh
 hosegrmhgurdgtohhm
X-ME-Proxy: <xmx:xzz7aYr534LODIB2K9RagrcLB8RkeIPB_bIRbNbhkAC6uLx23dyDkw>
 <xmx:xzz7aafbjVeOKYgrBlNOzMV3RhoWauyvvqX8Vg0U_XhITuYMhI59VQ>
 <xmx:xzz7aTq0GSaFwqr8M4aqgSXG6vIJCZGeavsZWudqkS4pGuGxdOgoWw>
 <xmx:xzz7acndgFbFRT-C9c31HDKIkxO_6-OzDw6PMvQxTXwO6JrcyNuZNw>
 <xmx:xzz7acR3F5PGWAjd8F00_Ulosvqxtv-Q9Fr2QDWbZawTaQt1q0dQBxqu>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 2F2A8700065; Wed,  6 May 2026 09:06:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Wed, 06 May 2026 15:05:54 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Rafal Ostrowski" <Rafal.Ostrowski@amd.com>,
 "ChuanYu Tseng" <ChuanYu.Tseng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Harry Wentland" <Harry.Wentland@amd.com>, "Leo Li" <Sunpeng.Li@amd.com>, 
 "Aurabindo Pillai" <Aurabindo.Pillai@amd.com>,
 "Roman Li" <Roman.Li@amd.com>, 
 "Wayne Lin" <Wayne.Lin@amd.com>, "Tom Chung" <ChiaHsuan.Chung@amd.com>,
 "Fangzhi Zuo" <Jerry.Zuo@amd.com>, "Dan Wheeler" <Daniel.Wheeler@amd.com>,
 "Ray Wu" <Ray.Wu@amd.com>, "Ivan Lipski" <IVAN.LIPSKI@amd.com>,
 "Alex Hung" <Alex.Hung@amd.com>, "Dillon Varone" <Dillon.Varone@amd.com>
Message-Id: <343bbe40-0bca-4315-b295-f6cb7507835d@app.fastmail.com>
In-Reply-To: <DM4PR12MB632884CFB2718FF565461C43F83F2@DM4PR12MB6328.namprd12.prod.outlook.com>
References: <20260326030153.406612-1-ChuanYu.Tseng@amd.com>
 <20260326030153.406612-24-ChuanYu.Tseng@amd.com>
 <2c3edb6b-fb1c-4b5c-90d4-48d2aba7c986@app.fastmail.com>
 <DM4PR12MB632884CFB2718FF565461C43F83F2@DM4PR12MB6328.namprd12.prod.outlook.com>
Subject: Re: [PATCH v2 23/30] drm/amd/display: Move FPU Guards From DML To DC
 - Part 1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
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



On Wed, 6 May 2026, at 11:45, Ostrowski, Rafal wrote:
> On Tue, 05 May 2026, at 12:55, Ard Biesheuvel<ardb@kernel.org> wrote:
>> This looks wrong to me. If _LINUX_FPU_COMPILATION_UNIT is #define'd,
>> it means the code runs within a DC_FP_START/END pair, and so doing
>> nothing will not re-enable preemption.
>> 
>> I think this #define should probably just be dropped. If that breaks
>> the build, it means the code is already fundamentally broken and
>> needs fixing.
>
> Hi Ard,
>
> I appreciate your feedback. Yes, you are right, it is not needed.
> I decided to replace it with:
> #define DC_RUN_WITH_PREEMPTION_ENABLED(code)	BUILD_BUG()
> I compiled it on various supported platforms without issues.
> Is that ok to you? If yes, I will work on patch.
>

Yes, that is fine.
