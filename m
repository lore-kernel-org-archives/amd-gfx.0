Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD62BC5321E
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Aug 2024 20:46:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D17710E034;
	Sun, 25 Aug 2024 20:46:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nova.fail header.i=@nova.fail header.b="kPhbdCJZ";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="cB9/ciuS";
	dkim-atps=neutral
X-Greylist: delayed 345 seconds by postgrey-1.36 at gabe;
 Sun, 25 Aug 2024 20:46:21 UTC
Received: from fhigh7-smtp.messagingengine.com
 (fhigh7-smtp.messagingengine.com [103.168.172.158])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C775F10E034
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Aug 2024 20:46:21 +0000 (UTC)
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal
 [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id E337F1150836;
 Sun, 25 Aug 2024 16:40:35 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-05.internal (MEProxy); Sun, 25 Aug 2024 16:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nova.fail; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1724618435;
 x=1724704835; bh=wDPoFuHRFQqHcwhSC6e0OxBaywTaTrEEsYpH2T2VM8s=; b=
 kPhbdCJZBWGRJLknI8M78BHk/BWHS/FLR17oVpi3iBHfM3kPwIoa4lA1IQHHEgiO
 33QgxsQiN1ke+7FdIVF+MjFlQWstst8KUn1yN0Eon3aoeLIq0tJ59OCjLcM+CWUK
 jyduoo+aVFoqUMvydfD9X4bFn8YHel8B8DYyZnt7YK8n+VZz8Ilver1H31dl4sla
 dhr3V0523AGNqYzEqdVk6xl1FSYS46/+js+/6lCmnup2Q0L+yg6KCAGTKwbZ94TW
 I3pjtFRoRM1Na5nJQ7uy/9mFu7dcKu6pzAy4yyDWxwQ1C32NeLpQfDiTwfUKl6ys
 diZS37PTRuIq+m0eoA/uRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724618435; x=
 1724704835; bh=wDPoFuHRFQqHcwhSC6e0OxBaywTaTrEEsYpH2T2VM8s=; b=c
 B9/ciuS/DZfxURUNVWOAkorppc1UmNVq1RZk3ATWDl01Ko0bQw7zxylg3wCXxqp/
 ukdo/uMo8HRoUk9MREMwuR2QIdZqvjQvDgwS19jlUiYFHTuEenbu9WHMcYO9LMEg
 j2/eb3l86+0+DPT91Q2G6w6vZndDzdg3l9ENgA+0ZNdplZMvtSQfxyMB0d3Togkh
 7lalFR8HElXPSP9Q+APa/FAPU55DizMwpIgf83qeHBhfYDQggoSn3UNjIMchUH1k
 GnKW5eG+qeWDv3sPTGc9N4WpIZtVJKaDmnJnTnak1WoQ3tXMYcuJVZF6cSZOHKJ1
 h5x+XEX/Y9DJKohJJ6fiw==
X-ME-Sender: <xms:w5bLZhpzsVKCnVvJMoJL7PLPAj2NyGrqRhExsiINq6uCegEARPmfJA>
 <xme:w5bLZjp65ZIbPySeFPodzmWHMhTBUiBT307gk42B907Qt9mkMjTGmOHGJsHuPMWaU
 CxR46UPsLuD_iC7xag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddviedgudehtdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
 tdenucfhrhhomhepfdfnuhhnrgcupfhovhgrfdcuoehmlhdqfhguqdgrmhguqdhgfhigqd
 guvghvvghlsehnhiigrdhnohhvrgdrfhgrihhlqeenucggtffrrghtthgvrhhnpeethffh
 ieeiteefjeefkeevkeeutefgjeegtedugfetfeduheeklefgtdfhfeegieenucffohhmrg
 hinhepfhhrvggvuggvshhkthhophdrohhrghenucevlhhushhtvghrufhiiigvpedtnecu
 rfgrrhgrmhepmhgrihhlfhhrohhmpehmlhdqfhguqdgrmhguqdhgfhigqdguvghvvghlse
 hnhiigrdhnohhvrgdrfhgrihhlpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhp
 ohhuthdprhgtphhtthhopehmrghrihhordhlihhmohhntghivghllhhosegrmhgurdgtoh
 hmpdhrtghpthhtoheprghlvgiguggvuhgthhgvrhesghhmrghilhdrtghomhdprhgtphht
 thhopehsuhhpvghrmhdusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhguqdhgfh
 igsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhukhgv
 sehljhhonhgvshdruggvvh
X-ME-Proxy: <xmx:w5bLZuN-XaiZFI4oqtxYhm2INwgsdlpHHKfW7GDEnH6563ugjVs0-Q>
 <xmx:w5bLZs5k9scOHDF7srLGLW2LyZzdUOK004sLEdPUzBeCV21_2XtpTA>
 <xmx:w5bLZg7EpVC-tvwnqTsG2SbA_LJffRM2Xfbnig6Ggbax2Ut-0cDQ1g>
 <xmx:w5bLZkiqh6Z-ke0NJg22eIUhO4ZjdqDrvWZBy3RumHjAgyZCFrkC3g>
 <xmx:w5bLZr0oqHJmOKD3Fjr1mkRXPpcwvjiwNQdSc-5dIHJoXIR4Wq_ZLkgV>
Feedback-ID: icd4147ec:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 98CACBA0069; Sun, 25 Aug 2024 16:40:35 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Sun, 25 Aug 2024 13:40:14 -0700
From: "Luna Nova" <ml-fd-amd-gfx-devel@nyx.nova.fail>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello" <superm1@kernel.org>, "Luke Jones" <luke@ljones.dev>, 
 "Mario Limonciello" <mario.limonciello@amd.com>,
 "Alex Deucher" <alexdeucher@gmail.com>
Message-Id: <de5eeddc-df9f-4c0d-aa11-8ad077bd8adb@app.fastmail.com>
In-Reply-To: <da2860c4-df08-49d8-b730-68691520f7ec@app.fastmail.com>
References: <20240820020435.472490-1-superm1@kernel.org>
 <CADnq5_O3uTj_Zu9+iY_k8i2MQhXH=Ac2+GhCe5DeW=CWY6jn4w@mail.gmail.com>
 <0e8d0a26-3dca-4669-96fc-d9f4bffbe5f6@amd.com>
 <CADnq5_OL=W_Uz9LCeoYAEZ=XX=1tu0=Hky=pjLmfz0x8vWUT-g@mail.gmail.com>
 <9efbc3a1-c43b-4f8a-a334-6ff77e6de283@amd.com>
 <da2860c4-df08-49d8-b730-68691520f7ec@app.fastmail.com>
Subject: Re: [PATCH] drm/amd: Don't wake dGPUs while reading sensors
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

Raised this as an issue a while back on the bug tracker and it got closed as WONTFIX. https://gitlab.freedesktop.org/drm/amd/-/issues/2229
Been running a patched kernel with a similar patch locally ever since because even figuring out everything on the system that's accidentally waking the GPU was too time consuming.

I'd love if this gets accepted.
I think fundamentally waking the device to ask how much power it is using thus increasing the power usage makes no sense - by trying to measure it we changed it, so if power can't be measured while off it only makes sense to return an error. Same applies for other sensors that currently wake the GPU - most of them are changing the property by waking it.

Because this behavior is odd and it's not obvious on single GPU systems that anything's going wrong app and lib devs are likely to keep making this "mistake" forever.

Luna
