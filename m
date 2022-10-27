Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A31FA3740
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 15:37:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0941F10E685;
	Thu, 27 Oct 2022 15:37:34 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0846110E66C
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 15:08:10 +0000 (UTC)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 41C3B5C012E;
 Thu, 27 Oct 2022 11:08:09 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute3.internal (MEProxy); Thu, 27 Oct 2022 11:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1666883289; x=1666969689; bh=Ntd0npd+6X
 jjks/O0Njc7Sa6rifWM593ZCyxHJVsjtk=; b=SqqgCN+cFxbkFVxX3hempYUO7e
 L64TZDR6uX8qsSZY8re1EkpmfG7HKoGC4wnehIUBGL/xR/gKfTecdK5JcgBkNmJa
 r1tFBOi8uhJ5lynFw/RPcDxbX8d3IqNTHte2hM2GA83O6VdyfYcdS0Y1XAtRq4Yg
 m24hnvh1NueKVpqLI13brZohdLXvC+5kXG7wfo10Ls19DxDCQ4kbU8QlL/MsdP34
 ChidQAhfnAq4kUvaZyxkthrq6UoOT8c/kw/4K5zcvK7tvmkAwgFb9E+B70Ks6AV1
 BwNtFFL1woNKk3jXjOf25fZFyohvsgYrSPiAAldF0onAKBeWJVU76myx090w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
 :feedback-id:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:sender:subject:subject:to:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1666883289; x=1666969689; bh=Ntd0npd+6Xjjks/O0Njc7Sa6rifW
 M593ZCyxHJVsjtk=; b=FtSbBrWbH9J9OKid+rszZc1HGgic+co2ywsWxZ49ChPl
 WG80UygURbmnwTrweXiniuKX3rX0iyBKaKFIfTdJpBH57mzrBUmsN2R6Ln0McWVo
 O1YXYzqXGdFI3Zb0O1NtMcuvsQGDxAkOhp3YrmcYBXCTREv05iMZ2jittOhFcVn+
 J0dhY601bV0gn+6EWC/K7BPuDeCPXOQRgxdftVMsXCLygWiC06cSCTrjU2/yY281
 s/JgVNyhdnvlZp2NuF5q/+FH+S72/PQMX65FmZAQJBjdu8yHDg1W8xeE45Vafgd6
 4JzokLymQKdThZUBvqK1XeZ9SMIZGZ7zHgb8fYG05g==
X-ME-Sender: <xms:2J5aY36Ns_1yBU0olwIw-lef0OtJlH22LAIT8nVum6lyv1hHA6nLgQ>
 <xme:2J5aY86OsFIY65ZDvp7HXGW6zldWDkvxdrcSFeu69qlTe7avMq_9WKyLHYzFckOil
 Xne4cZzW4sSOE4-IgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrtdeggdekfecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
 ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
 gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
 ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
 hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:2J5aY-c5whZwWigXHlZLtbrGaBsoxxhAjxETutoexTh8wacJpaDFJw>
 <xmx:2J5aY4KdjyiGoQ5h96n-cIbV_55uvFG2yfvTrUJGKTqcBtTxU7QZoA>
 <xmx:2J5aY7KgxHiRar5csn7WKgkih6jBPWXP0Nbb8oCsV_kN8OAR9SbdrA>
 <xmx:2Z5aY4pos0dDQKIZxGbkNj8PsyWD_v1PwgiblmNGhjNqVKeE2s1qFQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 52A08B60086; Thu, 27 Oct 2022 11:08:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <ebfb81b9-a4fc-43b2-b052-2702048d71f2@app.fastmail.com>
In-Reply-To: <20221027144527.4247-2-hacc1225@gmail.com>
References: <20221027144527.4247-1-hacc1225@gmail.com>
 <20221027144527.4247-2-hacc1225@gmail.com>
Date: Thu, 27 Oct 2022 17:07:48 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ao Zhong" <hacc1225@gmail.com>,
 "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>,
 "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 "Stephen Rothwell" <sfr@canb.auug.org.au>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 1/1] drm/amd/display: add DCN support for ARM64
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 27 Oct 2022 15:37:31 +0000
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

On Thu, Oct 27, 2022, at 16:45, Ao Zhong wrote:
> After moving all FPU code to the DML folder, we can enable DCN support
> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
> code in the DML folder that needs to use hardware FPU, and add a control
> mechanism for ARM Neon.
>
> Signed-off-by: Ao Zhong <hacc1225@gmail.com>

> 
> +ifdef CONFIG_ARM64
> +ifdef CONFIG_DRM_AMD_DC_DCN
> +dml_rcflags := -mgeneral-regs-only
> +endif
> +endif

I don't think the CONFIG_DRM_AMD_DC_DCN check is needed here,
if the dml_ccflags doesn't have this.

> +ifdef CONFIG_ARM64
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := 
> $(dml_rcflags)

Similarly, this bit should not need a check for CONFIG_ARM64.

> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := 
> $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := 
> $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := 
> $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := 
> $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := 
> $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := 
> $(dml_rcflags)
> +endif
>  endif
>  CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := 
> $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)

Having the #endif for the CONFIG_DRM_AMD_DC_DCN list is
a bit confusing (this is the preexisting state, not your
change).I'd probably drop the CONFIG_DRM_AMD_DC_DCN check
for the per-file cflags entirely.

      Arnd
