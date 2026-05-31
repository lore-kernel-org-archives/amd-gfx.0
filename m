Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74DECD6E63
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 07:27:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 709EE112EE2;
	Mon,  1 Jun 2026 07:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=poczta.fm header.i=@poczta.fm header.b="GXmDwvEi";
	dkim-atps=neutral
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 413AE10E151
 for <amd-gfx@lists.freedesktop.org>; Sun, 31 May 2026 12:04:51 +0000 (UTC)
Received: from Stacjonarny (62-133-144-026.dynamicip.ostnet.pl [62.133.144.26])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by www.poczta.fm (INTERIA.PL) with ESMTPSA;
 Sun, 31 May 2026 14:04:48 +0200 (CEST)
From: "Artur Chlebek" <achlebek@poczta.fm>
To: "'Greg KH'" <gregkh@linuxfoundation.org>
Cc: <amd-gfx@lists.freedesktop.org>, <regressions@lists.linux.dev>,
 <stable@vger.kernel.org>
References: <002901dcf0eb$9472e210$bd58a630$@poczta.fm>
 <2026053159-unread-disagree-0da7@gregkh>
In-Reply-To: <2026053159-unread-disagree-0da7@gregkh>
Subject: RE: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression
Date: Sun, 31 May 2026 14:04:48 +0200
Message-ID: <003701dcf0f5$ae8ef350$0bacd9f0$@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFDUGtZMJYvTWCxG+Cy9+QRqeP05ADRSPyrt1S/MJA=
Content-Language: pl
X-IPL-Priority-Group: 0-0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
 t=1780229090; bh=e7/qcnShqUBBb/+p6q0GSpdsFle8DuDHsO56XnzqioA=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=GXmDwvEiA9rdPLAcNyoiRs7Uub7f7a/9nEZ4ZoZGHkQxImZiDAyvHdco+9Iabd1F5
 a0waF3I0hT7NSjIeiiqiUSR6w+haAUCjJkg98zRO8qKKn50erchdMod/whlE3Vo61X
 KY/FkU3AZcd0YVjMRPHgEebkeBHWos+FyRxOj9Mk=
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

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org> 
Sent: Sunday, May 31, 2026 1:43 PM
To: Artur Chlebek <achlebek@poczta.fm>
Cc: amd-gfx@lists.freedesktop.org; regressions@lists.linux.dev;
stable@vger.kernel.org
Subject: Re: 7.0.9 vs 7.0.10/7.1 Radeon 260X regression

On Sun, May 31, 2026 at 12:52:30PM +0200, Artur Chlebek wrote:
>> Hi, I have 5x fps drop on amdgpu Radeon 260X 1GB between kernel 7.0.9 
>> and
>> 7.0.10 or 7.1rc
>> 
>> Original sparse mail got flagged as spam so let me elaborate:
>> Newest vanilla Fedora with Plasma, Gigabyte GA-H97-D3H, looked into 
>> things like clocks, PM, ASPM, tried flags, GTTSIZE, .dc=0 - all seems 
>> fine nothing helps.
> 
> Can you use 'git bisect' to find the offending commit?
> 
> thanks,
> 
> greg k-h

I'm sorry I'm not familiar with git at all, and very new to Linux. I can do
some local tests if led by hand...

