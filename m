Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E262BCD5BD1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E65112EF8;
	Mon,  1 Jun 2026 07:28:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="yssDv48P";
	dkim-atps=neutral
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7303D10E60F
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 10:52:30 +0000 (UTC)
Received: from Stacjonarny (62-133-144-026.dynamicip.ostnet.pl [62.133.144.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by www.poczta.fm (INTERIA.PL) with ESMTPSA;
 Sun, 31 May 2026 12:52:26 +0200 (CEST)
From: "Artur Chlebek" <achlebek@poczta.fm>
To: <amd-gfx@lists.freedesktop.org>
Cc: <regressions@lists.linux.dev>,
	<stable@vger.kernel.org>
References: 
In-Reply-To: 
Subject: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression
Date: Sun, 31 May 2026 12:52:30 +0200
Message-ID: <002901dcf0eb$9472e210$bd58a630$@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKsb98F3W6w4/I7L4gnl9a4wKSh5rSI9UcA
Content-Language: pl
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1780224748; bh=23Hr6bVV2eGzZD4V9CAprmCqyNkeGDWQ61jdUyLqKXA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=yssDv48Pev+PIQ+2CWFB85IQ+Bh6vUyB6EcyUY2JsblfJOKTNoUR7JLfmAhe6gNC4
 dqvPb+ENrbHGkxt0B+x00HJ4DMy/YsPADm3FfDuKs0HmsHKhSqJllvi8Tlu5OG7HTU
 s0rGTY07+HRX9nBmszgqidtRxpebVUdIXJG4X9fU=
X-Mailman-Approved-At: Mon, 01 Jun 2026 07:27:37 +0000
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

Hi, I have 5x fps drop on amdgpu Radeon 260X 1GB between kernel 7.0.9 and
7.0.10 or 7.1rc

Original sparse mail got flagged as spam so let me elaborate:
Newest vanilla Fedora with Plasma, Gigabyte GA-H97-D3H, looked into things
like clocks, PM, ASPM, tried flags, GTTSIZE, .dc=0 - all seems fine nothing
helps.

Regards.

