Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DDAECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 21:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4CBA10E70B;
	Thu, 27 Oct 2022 21:53:53 +0000 (UTC)
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com
 [64.147.123.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B090310E00D
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 20:46:33 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.west.internal (Postfix) with ESMTP id D423D320077A;
 Thu, 27 Oct 2022 16:46:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute3.internal (MEProxy); Thu, 27 Oct 2022 16:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1666903589; x=1666989989; bh=0MIjTLkWBg
 T6NXvZsERLKS9RcR9ykm/nrRRv96fvgEI=; b=PlzEXBfamSsGcfzoR6dlwiM3Yk
 nlof6euTTl+QNrLseM4z7Zn0V4Zn0uJHfM5CqACicbFB931jPAvIHuXwWyut7s53
 Gi/Xuny5UbopdM7ke7yIqii2rrahF3mwlENiHk9cGmV66LbXui8isOmEBxFY77or
 I/FzdpUzyfFKriQ1UV8voBt7kiOTFdFebQi0QBzMziedz6X/d6c989Y+In57Ugel
 xQI8EvDtV0Gl3hvSPW7aJ2m9578qb3n8L2IHicmch9XW5T4+Li468faMoNd8WO4a
 QMeVxsEqQEtAghvhP6KiLrTUf0ZlcQOXvJMXg3rIJwJ2MEvU9oNcg+StLgow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1666903589; x=1666989989; bh=0MIjTLkWBgT6NXvZsERLKS9RcR9y
 km/nrRRv96fvgEI=; b=BzrILdRp4Uc2zEDtFZRpyozQGnaWCIlrq1eD4vdZqaC9
 wC6uFdnJP6BmQWyCLKMKBynjs6KhjgB1Rw7UtGiYUWqrRWAkVmU/8dgWXHCf4CSG
 omBMSgsrcFqg8Zqn7zGfQ6cVfVj8C8u0l4NmznEobXuFaQoV9zzkKtrDNduBJvVn
 w6PkofgEdK/0cD5IHU9vorNGniFcP1E5m/ThNlT+aNvNf/tKzsSo0lg6+Y73KFvs
 ls+f9+nECxyojOfNpKapGKSI5hwemGjRbZa/NI1zfhO+GDj3ktJ1c7XLEX6mccfg
 VyyjNxO2CZM2L7FbbXQW11oSxuQwrBl2LPn2hTU3Vg==
X-ME-Sender: <xms:Je5aYxJPT1XAk967RH4ggsJZRKMdyI4DgGeEQejFXJkTSNlTffLNyw>
 <xme:Je5aY9LyXFxA2PdxZrBql9VslTeIEHxuVwKZ-TIUeT_Hs73bVszQRVYI-U3S6V5rh
 qMzueJG3IryF61qt90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdduhedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
 nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
 htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
 teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
 hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Je5aY5tntMISmVPT8NQyVLs6w_Qw1ALSnhaHVIiw3iKZfFyDm_-ubw>
 <xmx:Je5aYybLrC1HIY0uJyrVGfhc30v463mn2m2YvZMyRvsHtjgdSdwjeg>
 <xmx:Je5aY4ZnYijASwtWB_uuCcQARACUug7XXS1Xo8faGVtLsvxKEqO5sA>
 <xmx:Je5aY47VEOea6eQgxL_kDTEr19IzdRhLdfilP4snEpjx_hUoK27E9Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 1BFBDB60086; Thu, 27 Oct 2022 16:46:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <c286a75b-bdfe-4c96-ab9d-2cfd3aac9c7c@app.fastmail.com>
In-Reply-To: <20221027195227.5312-2-hacc1225@gmail.com>
References: <20221027195227.5312-1-hacc1225@gmail.com>
 <20221027195227.5312-2-hacc1225@gmail.com>
Date: Thu, 27 Oct 2022 22:46:08 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ao Zhong" <hacc1225@gmail.com>,
 "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>,
 "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v3 1/1] drm/amd/display: add DCN support for ARM64
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 27 Oct 2022 21:53:48 +0000
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
Cc: linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 27, 2022, at 21:52, Ao Zhong wrote:
> After moving all FPU code to the DML folder, we can enable DCN support
> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
> code in the DML folder that needs to use hardware FPU, and add a control
> mechanism for ARM Neon.
>
> Signed-off-by: Ao Zhong <hacc1225@gmail.com>

Looks good to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
