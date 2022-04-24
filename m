Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5434C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9DF310E774;
	Mon, 25 Apr 2022 07:33:13 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1F7D10E728
 for <amd-gfx@lists.freedesktop.org>; Sun, 24 Apr 2022 06:13:01 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4BFE4B80D5F;
 Sun, 24 Apr 2022 06:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA0DC385AB;
 Sun, 24 Apr 2022 06:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1650780775;
 bh=E1MKqD62FevE1GiU9ohHO912BX6dHib5zhdDMAllcyY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gO9dryS/25Vs3WdQbnCYE7g65CKaYN3JpRwDD4gSKafRCV37T3dzW469HegaOdkMQ
 4eN1KUPwgbOcDUUT8WT1jKUvsrRoJoF5CdKA+h0W6vj9Rrs1SbkUHgz7xR5+TRQ535
 MWTTQ6b1ZsF8GPpKjtDLDgBTfnIotuRLiIJG+GIA=
Date: Sun, 24 Apr 2022 08:12:50 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Demi Marie Obenour <demi@invisiblethingslab.com>
Subject: Re: [REGRESSION] AMD GPU regression in 5.16.18..5.17.4
Message-ID: <YmTqYkGEqiz1o2o6@kroah.com>
References: <YmQi7ajZpZ4W7BJL@itl-email>
 <YmQkCXZEqp6TKrhJ@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmQkCXZEqp6TKrhJ@itl-email>
X-Mailman-Approved-At: Mon, 25 Apr 2022 07:33:10 +0000
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
Cc: regressions@lists.linux.dev, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Apr 23, 2022 at 12:06:33PM -0400, Demi Marie Obenour wrote:
> Two Qubes OS users reported that their AMD GPU systems did not work on
> 5.17.4, while 5.16.18 worked fine.  Details can be found on
> https://github.com/QubesOS/qubes-issues/issues/7462.  The initial report
> listed the GPU as “Advanced Micro Devices, Inc. [AMD/ATI] Renoir
> [1002:1636} (rev d3) (prog-if 00 [VGA controller])” and the CPU as
> “AMD Ryzen 5 PRO 4650U with Radeon Graphics”.
> 
> #regzbot introduced: v5.16.18..v5.17.4

That's a big range, can you use 'git bisect' to track it down?

thanks,

greg k-h
