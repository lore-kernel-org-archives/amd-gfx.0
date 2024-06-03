Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDCDC25B7E
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 12:48:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1C610E476;
	Tue,  4 Jun 2024 12:47:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=arndb.de header.i=@arndb.de header.b="Pw35Wizs";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbFx6qa7";
	dkim-atps=neutral
X-Greylist: delayed 314 seconds by postgrey-1.36 at gabe;
 Mon, 03 Jun 2024 21:11:04 UTC
Received: from fhigh5-smtp.messagingengine.com
 (fhigh5-smtp.messagingengine.com [103.168.172.156])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AEC310E3E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Jun 2024 21:11:04 +0000 (UTC)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 24D1D1140172;
 Mon,  3 Jun 2024 17:05:49 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
 by compute5.internal (MEProxy); Mon, 03 Jun 2024 17:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm3; t=1717448749; x=1717535149; bh=RVc8clFFK5
 CAtWGtbwv6MGHMPpk+XIz+AajTXxYbNJ8=; b=Pw35Wizssd0Q2VN4qjiZtZIDrT
 ICcGxNNSLaX/rLB7YmTt+tdONo8mjl7ZHnIoWCTKWfuX7faeXodKdWwWwhxBzP9j
 T1GIZvRH0aWdUy7+3IU2eBxBz7Q3HubI1PdNnlngopFAN8mi4b2Ext+Df7A+tPK6
 hHpnjXW5+oI0KZoaXUJJZsl1LVUFK6ooWHpBuokC7BsAovmRphENnO6ob2bbBTIK
 dyaJLNyMeUM4Gu+R27G0pemlYrVVum1t9VO2zqWBM5OKqZdyxTjoAnNxxynu7zJq
 f00ITVismvY1lZwW0bCzy2gOkYBdkICexte4IvlwzFKf/CN767QS7524ZdDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm1; t=1717448749; x=1717535149; bh=RVc8clFFK5CAtWGtbwv6MGHMPpk+
 XIz+AajTXxYbNJ8=; b=MbFx6qa7cP2hw0HArRaUY/D93JmQxhuosKjExBUukyby
 +FYg58s5uhO6TxWNZjPbxFs4cDrLXvLgJCioLR+ARSgZJVXgWvBXzpfEPehT1k1/
 sUXjxOhN6f8LmUhGT65dhdrKoesWSVZK97yxYld+iMxP6WewWnY3VNHAjg1MxqXl
 s64aCVlPu2Ro2L2xUcgJ40LhyZ5/ZbRdijp/BbtztFKhLwbsWi++RTVFXAkdY/zZ
 MeUPwinOwWFN4mMx900pqqxI472w5evYOHooIXlfgywzewwGGzIkIhFwrk/PXRAB
 jP10SifuKaXFiRtKjH9J/Ke84cVW6O6f6oWCWqoxVQ==
X-ME-Sender: <xms:LDBeZibkVCazI9JjXQJnm1pXhVIdw4zwPDTjL7NZQuQjowQcfbQHkA>
 <xme:LDBeZlZkHSahQPISWOSa-zfJi7xtp9moEbBqR5BcCItL6dSMFaUZV_EmiIS8BQuzV
 dJd5oFXd-zcFer8ykc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudehiecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
 rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
 htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
 keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:LDBeZs9UUa1qyMr2NI_keji9JFPPYZ3PAanlTn69MbgDH6FYwO2DcQ>
 <xmx:LDBeZkqCitOJggTY2rN0vfXEhDNlOTSwNMgk0FOa8OBw33gnB7Dg9A>
 <xmx:LDBeZtq5gwfefFmbTZpF9xwCGQ70HxU7swnYLkTVJDkpytuZxdJWuA>
 <xmx:LDBeZiSa7m1NZCfOmxyhMENIDOrP9K36FR83TkjH8PSI3ZVGfdRZnw>
 <xmx:LTBeZmCBJrEt6N0UDVrIluWVZyvALXO8XMf4Sjz1EBb_6nL_lyy6yr0g>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
 id D8AAFB6008D; Mon,  3 Jun 2024 17:05:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-491-g033e30d24-fm-20240520.001-g033e30d2
MIME-Version: 1.0
Message-Id: <275bd9cd-99dc-4c0d-95b7-7d3707e1bfed@app.fastmail.com>
In-Reply-To: <20240603205918.28435-1-george.zhang@amd.com>
References: <20240603205918.28435-1-george.zhang@amd.com>
Date: Mon, 03 Jun 2024 23:05:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "George Zhang" <george.zhang@amd.com>,
 "Harry Wentland" <harry.wentland@amd.com>, "Leo Li" <sunpeng.li@amd.com>,
 "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amd/display: dynamically allocate
 dml2_configuration_options structures"
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 04 Jun 2024 12:47:56 +0000
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

On Mon, Jun 3, 2024, at 22:59, George Zhang wrote:
> This reverts commit 416b5c5eec9e708b31c68f00cb79130f2cfaf7ed.
>
> This patch caused a regression on DCN 3.2 on the IGT test 
> assr-links-suspend, with
> the dmesg warning:
>
> BUG: sleeping function called from invalid context at 
> include/linux/sched/mm.h:306
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: 
> kworker/u64:8


>  static void dcn32_update_bw_bounding_box(struct dc *dc, struct 
> clk_bw_params *bw_params)
>  {
> -	struct dml2_configuration_options *dml2_opt;
> -
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), 
> GFP_KERNEL);
> -	if (!dml2_opt)
> -		return;
> +	struct dml2_configuration_options dml2_opt = dc->dml2_options;
> 
>  	DC_FP_START();

This means we also enable floating-point mode inside of an
atomic section. Is that safe?

      Arnd
