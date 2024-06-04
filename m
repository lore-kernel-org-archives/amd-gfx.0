Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2D5C27C5E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 12:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DA0E10E7CE;
	Wed,  5 Jun 2024 12:57:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="GVvKXbub";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRIEV/rx";
	dkim-atps=neutral
Received: from fhigh1-smtp.messagingengine.com
 (fhigh1-smtp.messagingengine.com [103.168.172.152])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD45189DFB
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 14:58:00 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 3C87C1140172;
 Tue,  4 Jun 2024 10:57:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Tue, 04 Jun 2024 10:57:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1717513079;
 x=1717599479; bh=fplh5T/7fyIiNmamZiOb2dL9elPWecdVyAg7EtVLtEk=; b=
 GVvKXbubeABDCq2Ovc6NPnPV4qhJ6oCmJonz8K63H31nFxS4eXuDr1eQpPOLiyMU
 EzKwGFVmzt9R4AKN47f0qgPDe0De/xXOdnC60ebAx76sh+k53IL7tTVGSSc5EY7e
 iz2DC09/Vx+O8aq0reWsmTAYh5YDb/4C7s9qEeWhH5FslCkYUg45tvf1NQ66jhaV
 xDCByq/jCMHyFvDuZkrQhOF9+WuOebWUPl/AjoyCweCqBwwcF2wS5ErgE09EwhRb
 tYY4Les/NrfiXKAHOKVBLAi3UEFxxvWSczLsniQjr61bi1s7ZNglZL/0Ra4CBZmE
 0mw6e+o5ibC5xYlwnQFzCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1717513079; x=
 1717599479; bh=fplh5T/7fyIiNmamZiOb2dL9elPWecdVyAg7EtVLtEk=; b=C
 RIEV/rxzUzMpDrSKDThlK5aDVDUp7UqDdZleRnwudmWhJc9/EvqL7yZDGYAKeQOQ
 Z0izjr2+wZauQTS/VnHOTePsbNE7WCrcQnS+wksM2GxBoOGaMCKL54J6v6VqJaGw
 aBYBFpKh/ek7l7oBsCM8+M8Q7wbQrYYjOPJsY8CMYWw33pCJKeh1iiL+yToBQYXR
 pBI7o8fmbxaPN3qOTH2xUPcu4++j3wYxXe8hgmoYiCHlG5PTv/Ni6MuUxyRwHTzg
 cr9tFuWol03LCBsykdILxuPGJk3bnbDPuPIc2a65rSKHGEv1epzGMS44oJ/ln8PW
 8E0DGMMvzs0YA2TW+nxDA==
X-ME-Sender: <xms:dytfZrJfjzKPxUOwB8PnH4PDRbUTI4MoACwsisZvkrJRP2ufbACPpg>
 <xme:dytfZvLGEzPkTY2NHNaZlwGFSX858yADmrc4Ofx19cDu5J-k2po-2Et6eNzXztdDJ
 eKZ-icHcMUGdN1L18A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedgjeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
 gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:dytfZjt5ob5YkcDKm1enHDD6BQM2TsDtl1AiZiM544wg6H_F4p6IHA>
 <xmx:dytfZkYM827GOAEOMEQzj_Y8q8V-qQXutwRjXcHPGv6ZPBWyqACNIw>
 <xmx:dytfZibiTtunB8Acd17dQJ01QAaJUfSifQuTh4rAEYWZy2-nRCYgfg>
 <xmx:dytfZoAKsy-DD0Ax3MgVLA6g1DXx-_YL_tBQx28RilM55IQgEVuv4w>
 <xmx:dytfZnMVPL34CnrwWPo58mIn9yWLlMjYLxD-LP5LxrMVDCKqI5zrlpiA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id EF531B6008D; Tue,  4 Jun 2024 10:57:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
MIME-Version: 1.0
Message-Id: <3d7c938b-208c-4a73-8287-bc9ff598c47b@app.fastmail.com>
In-Reply-To: <9830fdd9-c738-4b9f-9ecb-2ed83a855243@gmail.com>
References: <20240604135015.479910-1-alexander.deucher@amd.com>
 <9830fdd9-c738-4b9f-9ecb-2ed83a855243@gmail.com>
Date: Tue, 04 Jun 2024 16:57:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Alex Deucher" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "George Zhang" <george.zhang@amd.com>,
 "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>,
 "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH] drm/amd/display: use GFP_ATOMIC for bounding box
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 05 Jun 2024 12:57:07 +0000
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

On Tue, Jun 4, 2024, at 16:22, Christian K=C3=B6nig wrote:
> Am 04.06.24 um 15:50 schrieb Alex Deucher:
>> This can be called in atomic context.  Should fix:
>>
>> BUG: sleeping function called from invalid context at include/linux/s=
ched/mm.h:306
>> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kwo=
rker/u64:8
>> preempt_count: 2, expected: 0
>> RCU nest depth: 0, expected: 0
>> Preemption disabled at:
>> ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
>> CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.=
0+ #35
>> Hardware name: System manufacturer System Product Name/ROG STRIX X570=
-E GAMING WIFI II, BIOS 4204 02/24/2022
>> Workqueue: events_unbound async_run_entry_fn
>
> That most likely only papers over the real problem and is not a valid =
fix.
>
> The question is why is that an atomic context?=C2=A0 If the function i=
s used=20
> under a spinlock then this might indeed be the right fix.
>
> If it's because of floating point operation then that here won't work=20
> either.

It looks like there is only one caller, and this turns on
floating point instructions just for the call:

        if (dc->res_pool->funcs->update_bw_bounding_box) {
                DC_FP_START();
                dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_=
mgr->bw_params);
                DC_FP_END();
        }

but then they are enabled again inside of the function.

If we can drop the outer DC_FP_START(), that means
the GFP_KERNEL allocation works. On the other hand if
we actually have to enabled it before calling into
the function (e.g. because there is an architecture that
has incompatible function calling conventions when FP
is enabled), the inner one is redundant, but we can
potentially move the kmemdup() into the caller and
pass the copy by refernence.

      Arnd
