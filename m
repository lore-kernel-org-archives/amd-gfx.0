Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26448C87FD2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Aug 2025 13:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B804410E46A;
	Mon, 11 Aug 2025 13:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="WoC74Z0A";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8332A10E396
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Aug 2025 09:09:01 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c0pj62jwWz9t2V;
 Mon, 11 Aug 2025 11:08:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1754903338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tH1hpIMu3ktWLNOXWlau3JPmcpfEHZwfM1ioDAqpgb4=;
 b=WoC74Z0A3Fa/+KeAiSZMTPb3357soBYCKpKgWuWX41oct7VVPzSHkhDu0UGsKDlO4fAoN+
 +JsTaRdBd2mBNUMyMi2kfb13ox1fftRD3JrdHGUjNE02FkOxBRL3qOJCntY2SgSrTD68et
 /7BLu36NPSbpdXH/K+0W13zlMLeIq1n6sKpAovwD/XGwPsgKIOm9Yrn+RiU9f1pfTlVQLv
 V2AnnKUSeuR+pp74vcb+A9jHJcasMLNgEMAXoc+etcH2yITR7rc+MA13zgBxGO+CTV/83f
 9fEeOKibtEpzCgR4R9Q+buE0DLicHvoP3np5OPJ3okprtQkORAKCAU7dpU3CKg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=listout@listout.xyz
Date: Mon, 11 Aug 2025 14:38:47 +0530
From: Brahmajit Das <listout@listout.xyz>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux-next@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 alexander.deucher@amd.com, airlied@redhat.com
Subject: Re: drm/radeon/r600_cs: Build failures with GCC 16
Message-ID: <e7hzkdghjyo73wdfcql6agfmjrgo3j2eb5nsoff5ix5246zhdw@hypc6t6uilbp>
References: <pqpvdwxmqler2mg4ou665v56g6qe36vwi5jeavqeszj2mrk5m7@io6dy7jsvuhe>
 <smpcrwsua5kwutn5ynzz4eiupocvw5c7b4tmk3xugynvmnr53d@zxyraythnybm>
 <9846b386-87c4-4f86-ae11-6361470cbce7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9846b386-87c4-4f86-ae11-6361470cbce7@amd.com>
X-Rspamd-Queue-Id: 4c0pj62jwWz9t2V
X-Mailman-Approved-At: Mon, 11 Aug 2025 13:02:38 +0000
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

On 11.08.2025 10:48, Christian König wrote:
...snip...
> 
> Looks valid to me. Potentially just copy&pasted from some older HW generation and not correctly adjusted for r600.
> 
> But the HW handled here is >15 years and the code easily >10 years old. I'm really wondering why gcc only complains now?
> 
> Regards,
> Christian.
> 
> > 
> > Would really appreciate some feedback.
> > (CC-ed Dave)
> > 
> 
That option -Werror=unused-but-set-variable= is new in GCC 16, maybe
that's why it was never caught before?

Would you like me to send a patch?
-- 
Regards,
listout
