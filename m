Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397A8ECAAA1
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 14:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8221910E121;
	Thu, 27 Oct 2022 14:11:49 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27E2810E63E
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 13:45:16 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 8F4535C01D6;
 Thu, 27 Oct 2022 09:45:13 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute3.internal (MEProxy); Thu, 27 Oct 2022 09:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1666878313; x=1666964713; bh=M21rCitFFB
 TaXpadp6FmZQZ51uA0a7d+ABau4bHC5yQ=; b=Bj/cAg8MIF9kISiAs3HmCI+NRB
 PNbheVd3eNwTqY9SVtgY9H+LGNv3rl8SrYGNQ2JbJBhztwCNFNJrMUvl04jaReQp
 DDXa9ePHbHwEARv06oovKcp92qZCCnkpa/zPcmLr6qUFUAH2+E8NMMpIxD0PVh7Y
 1QeUngHpahrzEtFREdZuZEvqmyA5azVoSekBJzDaLz4h3+giPRm6AWuV+jpAb7qX
 gNfIVnIwAXtbmz0OVFmsmEw7QipKmj7f5ohhoXC7ji/iizmkPW6j4mi5+VGK64so
 S3Xa3o49OKm4qol2jjwaIyIB6fV5gHMOzp27fICznHkvH8dXdswyyVmPNtJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1666878313; x=1666964713; bh=M21rCitFFBTaXpadp6FmZQZ51uA0
 a7d+ABau4bHC5yQ=; b=tizxdo4Af2g8TR7wsLjCuY5PTxiGGgI1CCguZH5s/dKn
 zxo6pf+Ef8GV901sJmQc4v7DaZe9yGGbsDuQ7ej0Ub7+jmlWuzj5oC2A+RzpnQ8U
 d8lQYs7knm8vmB1rmafaT1Oc+QnDR8S8MyGfFXo9UV1FiI6529LrW5Jd9o0qx9Wy
 0KlX0t/vt3uYOTMIJ1zFHQJ8clvevY2QW7hW4xaW4rUtdGOb24WKIzmrf++1aNpG
 iUDJ50YmgH6lSAXUZS02oTGIIcd0FSjjVNWKBfWDBhF/lS8jrq05WBYUE9eVJ0ou
 ocL9HCXLa6U5B8nOQclWkEg0LWOUHE7PeEAG/ZKcTw==
X-ME-Sender: <xms:aYtaY7t9mpGHqtYS01C7rqihMogJ18SU2pG2eeYush0HvFZgxn9l5A>
 <xme:aYtaY8emFyZUE10bcam-yJpeCpfNbhBgP_uGIvd9iGHuJiYjy8I9sS0OwN7CtCQio
 Ic6SgET7YPFZHMQsEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdeijecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
 ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
 gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
 ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
 hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:aYtaY-wkvcCB9ghFxU6cnQO08GmbpA1DDpdS6QoerTZjgAB15cxsQw>
 <xmx:aYtaY6MsKPaITkEhrxJRxSX1l7ANAEE3uzi4T01sGaaU9PEeUbdN0g>
 <xmx:aYtaY783vaMdyB-rJA0PHWwEytXGdOS7qK67H1YlflRtuom7itqJEQ>
 <xmx:aYtaY7zHXvF10tRKxS-BU-Gi7eoLIdmRycfoYNa-YWwx_NUx3FKuUQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 15E42B60086; Thu, 27 Oct 2022 09:45:12 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <7de4285f-1bdb-421f-9e40-e5657400ce1e@app.fastmail.com>
In-Reply-To: <CAG9e_p3PH02ecZwVVdY8uXzxLTMNkhg-aPRjfY4aePCduc=dSQ@mail.gmail.com>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
 <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
 <CAG9e_p3PH02ecZwVVdY8uXzxLTMNkhg-aPRjfY4aePCduc=dSQ@mail.gmail.com>
Date: Thu, 27 Oct 2022 15:44:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ao Zhong" <hacc1225@gmail.com>
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 27 Oct 2022 14:11:48 +0000
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 27, 2022, at 15:38, Ao Zhong wrote:
> Am Do., 27. Okt. 2022 um 12:52 Uhr schrieb Arnd Bergmann <arnd@arndb.de>:
>
>> Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
>> rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?
>
> I don't know if $(dml_rcflags) has any other use. I'm afraid my patch
> will break something.

From the git history, it looks like dml_rcflags was introduced for
arm64 support originally and left in place when this support got disabled.

       Arnd
