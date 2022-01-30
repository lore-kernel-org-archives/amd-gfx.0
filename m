Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2020C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Jan 2022 08:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FBDF112CB9;
	Mon, 31 Jan 2022 08:43:18 +0000 (UTC)
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com
 [66.111.4.229])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3D0110F3BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Jan 2022 02:16:24 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailnew.nyi.internal (Postfix) with ESMTP id C60A95800EF;
 Sun, 30 Jan 2022 21:16:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute5.internal (MEProxy); Sun, 30 Jan 2022 21:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=turner.link; h=
 cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm1; bh=P9iOim4NrWctmEwZ8zPw3HEkn6EbbINyR5zkQ2
 23ptE=; b=WhZLbraCfAbAiaXMYxdU0JtimnEgffIECycU2prEgxs57Qiv3otomd
 LxciAIQ404Tr+R0QA39S0Sh6TphRwSsKbTW/YyVossjjt9UUp71KVqGDjZU9ha2o
 5kIawzsFib+RlISzbDxQ5dboN1jldudrXsbVhsDG+LAGRN7ibAMaNBi9eIvrejU3
 TZwuD2V1Eh8s5VjcaN+mbp91bSPGhAFy5e8xxRyR6lHU7Fgs0FCJehomiy708/iL
 WotvDHVyRRIPtZo83WBNjzbFgp63qAcmVRjLU0+Zr2lsIUskSzgsjSJ1RqxT/LJc
 YNOPuVMLmuTLqq5zGyYgqMP+g1t6LuAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=P9iOim4NrWctmEwZ8
 zPw3HEkn6EbbINyR5zkQ223ptE=; b=drCIdtq56LgKKAk04BhqRdtXtrABgGh37
 2dky3hCczhXDUV0ToEuDeuG4UJO94oDrN1SsnA8QQX5xq5xAjL0K/CEHgYwergbJ
 1LpooZ28Gk0+tnyKL0jADrmqTwREg3XvV86Tj1NhzvO9a53TDiCWxd5OsUKBQBLM
 dLKo/cF+OCSUk8yaumj02qn5zLVMpqLrpMDr00Hy+0CdfnrjHp7xkGVQQ7x08+jD
 7+in0yYBg4ohQs9Ffyhjvi742vXn8PBYjVsf8EVmi+GYpoaNhcj8Vu8AlUV1xG74
 xwY4XgXI7mBo42ThRuNldJDCdYPh6wWlTmiXnE41qDd9C1BPHgZ4w==
X-ME-Sender: <xms:dUb3YUIhCChgHZeIrE6zkc_6ZfrKQKcLHkLjStd0ZEwlraTF916dKw>
 <xme:dUb3YUKRJYYPlLanL6aHmp8kkMXnlah7UZR_cBEfcLa5zoGQx0XHdCXw-e-RPt6WZ
 UexBb3iuIqgvWpskw>
X-ME-Received: <xmr:dUb3YUt9uPq2KyJJ885awi3jgnQvVZ5VtYouDk-uTK4eGPEAKydpsEZsMQ41>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgedtgdegvdcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpehfhffvufffjgfkgggtsehttdertddttddtnecuhfhrohhmpeflihhmucfvuhhr
 nhgvrhcuoehlihhnuhigkhgvrhhnvghlrdhfohhsshesughmrghrtgdqnhhonhgvrdhtuh
 hrnhgvrhdrlhhinhhkqeenucggtffrrghtthgvrhhnpeetheegvdetueefudelffejieff
 feetuefhveffveffffffhffguddtleehueevleenucffohhmrghinhepsghoohhtlhhinh
 drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
 pehlihhnuhigkhgvrhhnvghlrdhfohhsshesughmrghrtgdqnhhonhgvrdhtuhhrnhgvrh
 drlhhinhhk
X-ME-Proxy: <xmx:dUb3YRYnJlFBzWHktQ4HgM8Bt_RRoMAMwcO58jagwk9FezN-eHnFng>
 <xmx:dUb3YbYs6CyZ00DMOTIk1DepRhSGlr0ziQ-wT3HGC6fAlmVs6M4mKQ>
 <xmx:dUb3YdAptUPRB1unQeUulNxudWKbYRYzLTdQBd3ZfdZUabb-HMGPow>
 <xmx:dUb3YXqLKN47jCphongm7KUYYsj-mkg-zU2tnMhW-lf3ulkV4JRMIg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Jan 2022 21:16:21 -0500 (EST)
References: <87ee57c8fu.fsf@turner.link>
 <acd2fd5e-d622-948c-82ef-629a8030c9d8@leemhuis.info>
 <87a6ftk9qy.fsf@dmarc-none.turner.link> <87zgnp96a4.fsf@turner.link>
 <fc2b7593-db8f-091c-67a0-ae5ffce71700@leemhuis.info>
 <CADnq5_Nr5-FR2zP1ViVsD_ZMiW=UHC1wO8_HEGm26K_EG2KDoA@mail.gmail.com>
 <87czkk1pmt.fsf@dmarc-none.turner.link>
 <BYAPR12MB46140BE09E37244AE129C01A975C9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87sftfqwlx.fsf@dmarc-none.turner.link>
 <BYAPR12MB4614E2CFEDDDEAABBAB986A0975E9@BYAPR12MB4614.namprd12.prod.outlook.com>
 <87ee4wprsx.fsf@turner.link>
 <4b3ed7f6-d2b6-443c-970e-d963066ebfe3@amd.com>
From: Jim Turner <linuxkernel.foss@dmarc-none.turner.link>
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [REGRESSION] Too-low frequency limit for AMD GPU
 PCI-passed-through to Windows VM
Date: Sat, 29 Jan 2022 19:25:07 -0500
In-reply-to: <4b3ed7f6-d2b6-443c-970e-d963066ebfe3@amd.com>
Message-ID: <87pmo8r6ob.fsf@turner.link>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Mon, 31 Jan 2022 08:43:17 +0000
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
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Greg KH <gregkh@linuxfoundation.org>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 Alex Deucher <alexdeucher@gmail.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Lijo,

> Specifically, I was looking for any events happening at these two
> places because of the patch-
>
> https://elixir.bootlin.com/linux/v5.16/source/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L411
>
> https://elixir.bootlin.com/linux/v5.16/source/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c#L653

I searched the logs generated with all drm debug messages enabled
(drm.debug=0x1ff) for "device_class", "ATCS", "atcs", "ATIF", and
"atif", for both f1688bd69ec4 and f9b7f3703ff9. Other than the few lines
mentioning ATIF from my previous email, there weren't any matches.

Since "device_class" didn't appear in the logs, we know that
`amdgpu_atif_handler` was not called for either version.

I also patched f9b7f3703ff9 to add the line

  DRM_DEBUG_DRIVER("Entered amdgpu_acpi_pcie_performance_request");

at the top (below the variable declarations) of
`amdgpu_acpi_pcie_performance_request`, and then tested again with all
drm debug messages enabled (0x1ff). That debug message didn't show up.

So, `amdgpu_acpi_pcie_performance_request` was not called either, at
least with f9b7f3703ff9. (I didn't try adding this patch to
f1688bd69ec4.)

Would anything else be helpful?

James
