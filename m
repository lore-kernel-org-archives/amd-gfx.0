Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9866C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 17:22:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41D7210E2D5;
	Wed,  5 Jun 2024 17:22:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="iTQDgsUs";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="EVBWFUl7";
	dkim-atps=neutral
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com
 [103.168.172.146])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AF289FC9
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 17:14:58 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 3DEA51380134;
 Wed,  5 Jun 2024 13:14:57 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Wed, 05 Jun 2024 13:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1717607697; x=1717694097; bh=OGEMODQa8x
 tmjCFv3nbYX3sVDyyltE15+4FSbvNobPw=; b=iTQDgsUs8ctuM8O87XWZ+9BuY7
 F2HU4qjlLxbV0VIehJZiCZ1O1bZDWGzYevoJbKPDbYfB/ZLIrMMl25YcRc/b68Hv
 TYKY8xGBHjHWDyAVSl7vSPnk41rpDaLLApLcz9MCfFNFXmQrmqNyGreHcOohg4RC
 ER45slZKhn/5H98IIs8MF+Fmc5iSp2dv/N2cEcIJhWe3/v5JqEcqQs17hn5mHlUR
 O1pw2sbuK5GEfej95Rr/ESPCXm2ctlDEXjOg17sawQw7O4WLbIsK6gEFb7ttNTTx
 flRTwVTVZxlqS6pPdIMDoB3SaMCjVjfUYKjXt10cj6i0keQiXTzOrxLeW6Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1717607697; x=1717694097; bh=OGEMODQa8xtmjCFv3nbYX3sVDyyl
 tE15+4FSbvNobPw=; b=EVBWFUl7qm4YGCkpsvwlRJC76kQsULNC/A6UWEmIyn6k
 s0c1FQAKRFYV8FCMyw/H9I+8XJJC/O8vca3lBZEG1QuCTFb5Q6GNClVF/D1d9O9g
 /Sp5OQjBA5CnJPyaaGlNKrxknWt9usPZV2IxBYx8y1l4TE/yQVqUArZT7SdUre1z
 jyBTbIo531j6wDjsAaAzse+erq4GjYBYeAwWBBrkzB+x2qdlIRuRSGrpaWRjfA9O
 91d4k4R/ESL3SL8bizyRUZub6MHztQYPrSePmB4MQaEHT79nBcjZEPRC2g7gEe36
 FfgfVcySPVj/Vw0bPjpX5tM2dwfg4iCoh8XgQz5teA==
X-ME-Sender: <xms:EZ1gZs9atgshJTXTHcGMRHgK_yWq5YhY5VsVCVwyL1qA3nU-9DTyyA>
 <xme:EZ1gZkvABFOhL17hIcj0OMZZBxEFXOjGwQjemJBxVL46y6zjetxPj3FkP3D3cRlmg
 QnrscJFr2Gx4UaNMNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeliedgudduvdcutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
 keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:EZ1gZiCaTeQqhWTZsrSyQ8xArhqtQ2c98wppTFhT1eW55ZSWBIEzxA>
 <xmx:EZ1gZsfL5gd8BB2ZLiTnRQzlu1Cc088ke9N8yBjKJ3zjp3_l-OoBfw>
 <xmx:EZ1gZhNSEWLrUgEa8XmB8UXRzyciGM3NJ6NDxXqkFJefoTFwYGWIHQ>
 <xmx:EZ1gZmmgh_UF06sA13-wzEUkYuS9GrU9WnalQLnRd_flsj1TeEMAXg>
 <xmx:EZ1gZtARPNdgm8NMO2qOtweNBbs5UKrSa0k8vDBqahF7CshTbezcUCcR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id E6D35B6008F; Wed,  5 Jun 2024 13:14:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <c09a3015-21df-4c3f-93af-96708369cd2a@app.fastmail.com>
In-Reply-To: <20240604202606.697979-2-alexander.deucher@amd.com>
References: <20240604202606.697979-1-alexander.deucher@amd.com>
 <20240604202606.697979-2-alexander.deucher@amd.com>
Date: Wed, 05 Jun 2024 19:14:36 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "Hamza Mahfooz" <hamza.mahfooz@amd.com>,
 "George Zhang" <george.zhang@amd.com>,
 "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>,
 "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH V2 2/2] drm/amd/display/dcn401: use pre-allocated temp
 structure for bounding box
Content-Type: text/plain
X-Mailman-Approved-At: Wed, 05 Jun 2024 17:22:56 +0000
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

On Tue, Jun 4, 2024, at 22:26, Alex Deucher wrote:
> Fixes: 669d6b078ed8 ("drm/amd/display: avoid large on-stack structures")
> Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>
