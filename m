Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE76DCD128A
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 13:14:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2EA10F091;
	Thu, 11 Apr 2024 13:14:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="fAFRq2a4";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzSFGGOr";
	dkim-atps=neutral
X-Greylist: delayed 564 seconds by postgrey-1.36 at gabe;
 Thu, 11 Apr 2024 07:41:15 UTC
Received: from wfhigh5-smtp.messagingengine.com
 (wfhigh5-smtp.messagingengine.com [64.147.123.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B81FD10F107
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 07:41:15 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.west.internal (Postfix) with ESMTP id 81E2218000CB;
 Thu, 11 Apr 2024 03:31:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Thu, 11 Apr 2024 03:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1712820708; x=1712907108; bh=ss9obh18Sk
 iQHEXzh7qcLFdvdlxpa80B0Z7MJyyJWOs=; b=fAFRq2a4RR5m0uoGjxvbSDZhhg
 XBLt22beIqBHO1PhCVLZIYorAfbGnpIs6i0KjnrNMag6CtHF8mAtIX4+g4JkM/y4
 oNakw3qvrAtMITJTRe3dP5XCRbSlUNRMtgb+FJogTSdTceTcdRzappHrax+eWmGC
 C48KZTiW2+745Tpmz56zPJgFu5sXmnDOXQgOHhBxECqtppJaW42Os3TNEDRkpPfI
 7xKy28dP14Q+rdv1IglqoN1MM2Wo71oJ88dpxu76wssTF5yL3dssA5ZNSuq2aEsa
 sQ7EBo/MLbjI9e+DTEeltLlDImftLLOUzlWPomQgt5r5GI+C7bz29lbepBoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1712820708; x=1712907108; bh=ss9obh18SkiQHEXzh7qcLFdvdlxp
 a80B0Z7MJyyJWOs=; b=DzSFGGOr+zqR4sfSmeOxAZvA6tvMP0LGFanC2+BgYdJy
 +4hbOwbt0daWkKElaJ7hw1qTgNt7659JrHfKx7+c2NRv2nXqcVlsOuvhc37YXOZ6
 /5MKG6iTFCQ6aufnWu+0iv1mQHtdHJ4K9QX9ZNac5sLfv829dYcU7OrtBhvzAPeJ
 qvI5fpyEZjo1rJqt0In+B4EMVZTz3BIN6xIPeqBy76lVWIdHpPj7mI1hWq7dyIWT
 CnWqJQpCHMCE2NVdUfy2AgXYjJNlhFvPsLF/BoiRix4BR68kBN/e6viA7DoExAkP
 1lsK1ob4cyEjdsraiMT0hwoBXzOe78DNkW/8wTm9dg==
X-ME-Sender: <xms:45EXZr7T_OnGStrr7SKzpEUpju9NZAoJ-lpF9Idxf_AAZawFa25PqQ>
 <xme:45EXZg74AAZ239bjRLX7EeRcHaT8wGi_jFHosNYQYKIaCYvcpDRxLFrBw8T1Wh8fR
 jo4RGsgbbTYIfp5aDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudehjedguddujecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
 keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:45EXZieKjjVog6Wf67CQD8NJtTers1M6KFeWe75e-UlBkt2QP7uJXg>
 <xmx:45EXZsJIp1DUMatuZM3plg1HZpaO63G81PNWgtOVl7mQ4q3U6QDMgA>
 <xmx:45EXZvIKtC1NGjybHKKb-88n2S8h7w1gUs0XzOcd8JC5HH3wCWVBpA>
 <xmx:45EXZlyxfKvoW4q6bfCKoSeKRYfJBEypsh0ZQzt4uZT200LeFEQ3Rw>
 <xmx:45EXZuaOX9x1nVPc-UnZtz-zaIuHLseO3kmjE2oKiQEaEOt4QcV-JewM>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id 5E761B60092; Thu, 11 Apr 2024 03:31:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
MIME-Version: 1.0
Message-Id: <c0e170f7-5498-40ed-ba35-2ac392c2dd2a@app.fastmail.com>
In-Reply-To: <CAMj1kXGW5XQxXrYaPhT6sCjH7s0EwqzNjWies3b8UWnUBW5Ngw@mail.gmail.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
 <20240329072441.591471-14-samuel.holland@sifive.com>
 <87wmp4oo3y.fsf@linaro.org> <75a37a4b-f516-40a3-b6b5-4aa1636f9b60@sifive.com>
 <87wmp4ogoe.fsf@linaro.org> <4c8e63d6-ba33-47fe-8150-59eba8babf2d@sifive.com>
 <CAMj1kXGW5XQxXrYaPhT6sCjH7s0EwqzNjWies3b8UWnUBW5Ngw@mail.gmail.com>
Date: Thu, 11 Apr 2024 09:31:27 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ard Biesheuvel" <ardb@kernel.org>,
 "Samuel Holland" <samuel.holland@sifive.com>
Cc: "Thiago Jung Bauermann" <thiago.bauermann@linaro.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 "Christoph Hellwig" <hch@lst.de>, loongarch@lists.linux.dev,
 amd-gfx@lists.freedesktop.org, "Alex Deucher" <alexander.deucher@amd.com>
Subject: Re: [PATCH v4 13/15] drm/amd/display: Use ARCH_HAS_KERNEL_FPU_SUPPORT
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 11 Apr 2024 13:14:24 +0000
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

On Thu, Apr 11, 2024, at 09:15, Ard Biesheuvel wrote:
> On Thu, 11 Apr 2024 at 03:11, Samuel Holland <samuel.holland@sifive.com> wrote:
>> On 2024-04-10 8:02 PM, Thiago Jung Bauermann wrote:
>> > Samuel Holland <samuel.holland@sifive.com> writes:
>>
>> >> The short-term fix would be to drop the `select ARCH_HAS_KERNEL_FPU_SUPPORT` for
>> >> 32-bit arm until we can provide these runtime library functions.
>> >
>> > Does this mean that patch 2 in this series:
>> >
>> > [PATCH v4 02/15] ARM: Implement ARCH_HAS_KERNEL_FPU_SUPPORT
>> >
>> > will be dropped?
>>
>> No, because later patches in the series (3, 6) depend on the definition of
>> CC_FLAGS_FPU from that patch. I will need to send a fixup patch unless I can
>> find a GPL-2 compatible implementation of the runtime library functions.
>>
>
> Is there really a point to doing that? Do 32-bit ARM systems even have
> enough address space to the map the BARs of the AMD GPUs that need
> this support?
>
> Given that this was not enabled before, I don't think the upshot of
> this series should be that we enable support for something on 32-bit
> ARM that may cause headaches down the road without any benefit.
>
> So I'd prefer a fixup patch that opts ARM out of this over adding
> support code for 64-bit conversions.

I have not found any dts file for a 32-bit platform with support
for a 64-bit prefetchable BAR, and there are very few that even
have a pcie slot (as opposed on on-board devices) you could
plug a card into.

That said, I also don't think we should encourage the use of
floating-point code in random device drivers. There is really
no excuse for the amdgpu driver to use floating point math
here, and we should get AMD to fix their driver instead.

     Arnd
