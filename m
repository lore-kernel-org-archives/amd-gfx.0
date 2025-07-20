Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07184C83F1A
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 11:36:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7DA10E04A;
	Sun, 20 Jul 2025 11:36:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="kCeEtibC";
	dkim-atps=neutral
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 639CA10E04A
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 11:36:32 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp5-g21.free.fr (Postfix) with ESMTP id E30B25FFAA
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 13:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1753011390;
 bh=keX1sXaOO3HGAkS35ur8HRH7adcyz31T3tbB1pl02sQ=;
 h=Date:From:To:In-Reply-To:Subject:From;
 b=kCeEtibCa4EF5qhg2NF/6hYJoObFJGM+AsMzbEikluYBKgBZYgroPclbLeXhWAqek
 w3FExiCCl6fppNAssx6MkneV1IURT/9e9FJ8mrDlJump50oHhs8hI4KCO9srwf46/b
 6Af8vyXUMEdHKLSaa7Pm1W/uIexn7ZaqeuFW2153NQ0QWLExEA1HPbEx1H1I9ESsTv
 dB9QuB8gzXJYLeQWjNrHKIPa/6Cz5E6GWYUPioBmwNodta9KD2FPA0Eda+h/138cIK
 n1Vzs99C9TpTpyeTlIr90z3w4adwYq5zSUvsMEput4Q770QsGWTJr/H4WYS+jZE5Cb
 VcRiHI0SaYyyQ==
Date: Sun, 20 Jul 2025 13:36:30 +0200 (CEST)
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Message-ID: <450908979.152326114.1753011390727.JavaMail.root@zimbra39-e7.priv.proxad.net>
In-Reply-To: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
Subject: Re: A few more items for the glossary, and understanding GPU switching
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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

Adding to the list:

* ACA, mentionned in debug_mask flags - digging the source shows it seems to be
  "Accelerator Check Architecture", but maybe some additional details could be
  added?
* DPIA (likely for dc-glossary): listed in DC_DEBUG_MASK values, source code
  in several places shows "DisplayPort Input Adapter", but maybe more details would
  be useful here too?  Often associated with DP USB4 tunneling in source code.

Best regards,
-- 
Yann
