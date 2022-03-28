Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96FBC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 12:57:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A73D10E441;
	Mon, 28 Mar 2022 12:57:06 +0000 (UTC)
X-Greylist: delayed 2319 seconds by postgrey-1.36 at gabe;
 Mon, 28 Mar 2022 09:52:04 UTC
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com
 [IPv6:2a0c:5a00:149::26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B62710E13F
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 09:52:04 +0000 (UTC)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
 by mailtransmit05.runbox.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.93)
 (envelope-from <ruben.de.smet@rubdos.be>) id 1nYlRC-002v8O-II
 for amd-gfx@lists.freedesktop.org; Mon, 28 Mar 2022 11:13:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rubdos.be; 
 s=selector1;
 h=Content-Transfer-Encoding:Content-Type:Subject:From:To:
 MIME-Version:Date:Message-ID; bh=ijhqsVUMLPeYWtVow5rYnFBuSQElHe+KqBmqGrSger4=
 ; b=LreuDGwwLeoj73AYW1ZOwuIMN1ZLrK1EgysLKg6vvhdqkh4lUaS5Z0PDLJmmbSrDsuMJMGuQv
 QoQSAhmA+KS5z0ns8zdSTLc2C0mVsok2XQT3gMtzoJ5MnIRU91NeFbyY2o66MU62ByQphh18tRFhn
 hMovPYmirHXlti5eAUNqB0aEMSbnoisULFYMAxoGW56N3NXZ3GviCvG3b6MRwikhtOGA8wxWT1cgB
 AnuoIL8f43NTjQuENyz0yl1GL3HRwbX3GaYpn/nfn9vCaJzdFJSiXPmrIt6Dyy2z53F1QrHV5+uZC
 65eyjEH9loNWTPppP3MxVa+Wn1wN5OFfRfYfxA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
 by mailtransmit02.runbox with esmtp (Exim 4.86_2)
 (envelope-from <ruben.de.smet@rubdos.be>)
 id 1nYlR6-0004rM-UJ; Mon, 28 Mar 2022 11:13:17 +0200
Received: by submission02.runbox with esmtpsa [Authenticated ID (977972)]
 (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.90_1)
 id 1nYlQz-0000Ln-Ox; Mon, 28 Mar 2022 11:13:09 +0200
Message-ID: <62e96e28-4809-4380-e71d-715ad030f2d5@rubdos.be>
Date: Mon, 28 Mar 2022 11:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US-large
To: amd-gfx@lists.freedesktop.org
From: Ruben De Smet <ruben.de.smet@rubdos.be>
Subject: Radeon Pro W5500 in passthrough with vfio generates spurious NMI
 reason 25
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 28 Mar 2022 12:57:05 +0000
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


Dear AMD,

I recently posted a bug report on Launchpad 
(https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe-5.13/+bug/1963893). 
  I hoped it would reach you via that channel, but I don't really see 
anything moving.

We have three of your W5500 cards in three identical EPYC 7302P HP DL325 
Gen10 servers, as an experiment.  We wanted to use them in passthrough 
through OpenStack, which works more-or-less.  However, we notice quite 
some suprious NMI's through with "reason 25" appear when we do this.  We 
don't have such issues with our RTX 4000 card in another of those 
servers.  You'll find dmesg dumps, both with the vendor-reset and 
without it on the launchpad bug report.

Please do let me know if you need more data points in order to reproduce 
this behaviour.  If this is not the correct list, I would gladly go 
through a different channel upon your redirect.

Best regards,

Ruben De Smet
