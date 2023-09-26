Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF358E7E654
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 17:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E20010E3FE;
	Tue, 26 Sep 2023 17:49:17 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E7010E3FE
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 17:49:16 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4DFC3614B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 17:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3B5C433C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695750555;
 bh=xK4BAvjBDq6ZBgfBH6UoKZqSPubXK2112wus9WHGdk4=;
 h=In-Reply-To:References:Date:From:To:Subject:From;
 b=I2WKG1k3QdJP8ofUyJF2WFpoZf/jNSvyZ7TrQfDvwOhGCYLhxseBLhsYGJH4mJnQj
 6jG+lGCyt/lRRAsomvG75ZZ/cIoDBOMB1PZcZbtxkq75Ml1UPxdpNY0oSAJy+HOU+B
 7GQb2Odo+F6TzTZrZNjixXhkbsTk5s/BAqXlSkA4hGtdl7OcYYJDF7oOBiV2womDNI
 YjaIczbOFE1VPXfozumZHGm5dYJQ/Y2f6QEJTnV4Poys7lq9lXrhxlce/DyCJHI3CD
 PPXAONgIuBj9GDWFrco9YZPmoJ++LZwdFlc9Fv9nEC/sLSDQ8QP8vMwELg40XHwHNq
 uxqZg41Zjc2iA==
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailauth.nyi.internal (Postfix) with ESMTP id CA9F327C0054;
 Tue, 26 Sep 2023 13:49:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute6.internal (MEProxy); Tue, 26 Sep 2023 13:49:13 -0400
X-ME-Sender: <xms:mRkTZZhfLWksHS3E4LRbZ_3HalGss8mWhj9AzpF749W0AJED9RVM0Q>
 <xme:mRkTZeBfSsQaZRSvLcED8wDPoMIKTKitrBO-dn1iG15PiPfY_YSxxQbKPY1hS4Mbt
 9VkXbiy5sB4jk7SROw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvjedrtddtgdekjecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedftehrnhgu
 uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
 htvghrnhephfetveetffevlefggfduteffgfehieffueejkedvjeetveffueekvedviedu
 feeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
 qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mRkTZZFqrv8Yg73tiTncJo9dV6iqKNVBeoSVEPfteIaEFqOcfs4BIw>
 <xmx:mRkTZeQRkdF4tq2UlGxRNqscN0UrlhXuFSBa0hRHnqzCC6SQ_P5_Zg>
 <xmx:mRkTZWw6SwOEpl07vBBvgvMCKe19Y25qEC2NDIVUasda2pVTK07RnA>
 <xmx:mRkTZbuuRurB4xImjSW6-21A8mwPWrAmkXDkPHJBx8Nyv5M0yj1ReQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 98CEAB6008D; Tue, 26 Sep 2023 13:49:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-957-ga1ccdb4cff-fm-20230919.001-ga1ccdb4c
MIME-Version: 1.0
Message-Id: <df3b7de0-972d-4df4-a52e-828015f062f6@app.fastmail.com>
In-Reply-To: <20230926163938.1013775-2-alexander.deucher@amd.com>
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
 <20230926163938.1013775-2-alexander.deucher@amd.com>
Date: Tue, 26 Sep 2023 19:48:52 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Sep 26, 2023, at 18:39, Alex Deucher wrote:
> I think this was an abstraction back from when
> kfd supported both radeon and amdgpu.  Since we just
> support amdgpu now, there is no more need for this and
> we can use the amdgpu structures directly.
>
> This also avoids having the kfd_cu_info structures on
> the stack when inlining which can blow up the stack.
>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Nice cleanup!

Acked-by: Arnd Bergmann <arnd@arndb.de>

I guess you could fold patch 1/2 into this as it removes
all the added code from that anyway.
