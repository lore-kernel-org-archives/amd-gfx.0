Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7FCFA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 12:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2278010E5FE;
	Thu, 27 Oct 2022 12:33:55 +0000 (UTC)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9605010E5CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 10:52:52 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 3F0C95C0060;
 Thu, 27 Oct 2022 06:52:50 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute3.internal (MEProxy); Thu, 27 Oct 2022 06:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1666867970; x=1666954370; bh=P6BuP376AP
 ZnVvR4MDPZPSN+Tu/z5qyDwnUiXT28WNY=; b=FaFTTwv6kEU6BBgsP53yDWl0av
 8yx7Ixc9F+o6Edc+yaY4N7Ey3/G2TD92vSEaJudLAGoj+j8adrw1DB1UHkV567t8
 tQYC2OmkJUzi+wyaEDPjIuFhHDPW1HTrfrW3b+4LWvuEg3TiZyZMg1fP/YSeuMYj
 5PAWAkOPdoT9T5MtUDMTAayXEF/pnPedmu9Ec+3hgz5lv6B5NPcqmUffbmVmFUR2
 jgswD5XLg6UxR75iFG+jL4c/Hzkd/A16E/HW2D4QqmfJgIzDiKxphBKF018m713d
 e8U6vsyGceLsJEnQx/disPGc6qD1MrMYNDxz8D7uH7XBmWFI6oplOEsCzF0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1666867970; x=1666954370; bh=P6BuP376APZnVvR4MDPZPSN+Tu/z
 5qyDwnUiXT28WNY=; b=Nw2Tr6B5/b3wi/KdOScCo9x+gVj8ySpCByak9Zf6JlVW
 fUE3+ajluKncR7LunXncdS7HFUYuJnQNoJSp4MVgw8otkBuXl9zktLodYQdbRK+5
 uaW1BmeI4ZGu4TIwBEeoU6Q8Aft2vbcZLaiyV05jx7Zob13NVLhjJSoD3lu9UK2E
 kdvPSKx2zacpvbHNP+V/0vnzxVQdBGZIL5ksvYHMn/JWyp+yeLPbtSIxXbpc7zvH
 IHQWQ8gtlsJm/vfe8iWIIU2CP6KrX+o5BuKKs/lWFw4oL6veJduDPSL4zSKnqTZ1
 vNOGbCWDpkpksPg7/4IE/cTF/9cepu7Nw9SyNqnISA==
X-ME-Sender: <xms:AWNaY0LuOXQ1PDSFqrksMqjasHLDUnC8l0PkdRgjkBPU3VAQ2CeyeQ>
 <xme:AWNaY0Lah7F-zRIpCyJvg9t4uQZE6-Wk2apqVpxFLx7piDp5mge3I8gmfNMpoMcHt
 Ln6MohdeKyS-hR-Wrc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdefudcutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
 ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
 gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
 ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
 hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:AWNaY0uSJw3OKC7tFyoDH9Sheb4aed_LD-H9RSgzTjPpYbbMnf87Sw>
 <xmx:AWNaYxYYUFNR5dAK96_V4gjjF0E8tMCVLiNbtV3lTYhh2msc2Mk3QQ>
 <xmx:AWNaY7bJSfNxd5ZNfihOh-N3BPTh311M4GKYH-ZrlzCf-RuCNBq3hQ>
 <xmx:AmNaYwNo51fd-lmnpBJbpshBhIgh7fm102UVPc02grGUYeTInaKQcQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id CAF1CB60086; Thu, 27 Oct 2022 06:52:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <c41b45cb-8a1a-4140-b7f9-08aa481a25c1@app.fastmail.com>
In-Reply-To: <20221027002528.15983-2-hacc1225@gmail.com>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
Date: Thu, 27 Oct 2022 12:52:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ao Zhong" <hacc1225@gmail.com>,
 "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>,
 "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 27 Oct 2022 12:33:43 +0000
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

On Thu, Oct 27, 2022, at 02:25, Ao Zhong wrote:
> After moving all FPU code to the DML folder, we can enable DCN support
> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
> code in the DML folder that needs to use hardware FPU, and add a control
> mechanism for ARM Neon.
>
> Signed-off-by: Ao Zhong <hacc1225@gmail.com>

There have been problems with stack frame overflows on this code
in the past, how much have you tested this with random configurations
to see if we still hit them in corner cases on arm64 that may not
show up on x86 or powerpc? I would expect to see a few more of them
for every new architecture port.

> index d0c6cf61c676..3cdd109189e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
>  dml_ccflags := -mhard-float -maltivec
>  endif
> 
> +ifdef CONFIG_ARM64
> +ifdef CONFIG_DRM_AMD_DC_DCN
> +dml_rcflags_arm64 := -mgeneral-regs-only
> +endif
> +endif
> +

>  CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) 
> -Wno-tautological-compare
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := 
> $(dml_rcflags) $(dml_rcflags_arm64)

Why do you need separate $(dml_rcflags) and $(dml_rcflags_arm64)
rather than adding -mgeneral-regs-only to $(dml_rcflags) directly?

    Arnd
