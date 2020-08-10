Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A3CC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 07:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C2C2073A
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 07:37:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C2C2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEA36E3D8;
	Mon, 10 Aug 2020 07:36:16 +0000 (UTC)
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4414F6E083
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2020 06:43:59 +0000 (UTC)
Received: from monopod.intra.ispras.ru (unknown [10.10.3.121])
 by mail.ispras.ru (Postfix) with ESMTPS id 435F440A2060;
 Mon, 10 Aug 2020 06:43:57 +0000 (UTC)
Date: Mon, 10 Aug 2020 09:43:57 +0300 (MSK)
From: Alexander Monakov <amonakov@ispras.ru>
To: Ignat Insarov <kindaro@gmail.com>
Subject: Re: Non-deterministically boot into dark screen with `amdgpu`
In-Reply-To: <CAB-2Q08KQmS0D06k1QEUpccybGqCY+HYaZkF=sY0t1EX8Y_u2Q@mail.gmail.com>
Message-ID: <alpine.LNX.2.20.13.2008100928010.2454@monopod.intra.ispras.ru>
References: <CAB-2Q08KQmS0D06k1QEUpccybGqCY+HYaZkF=sY0t1EX8Y_u2Q@mail.gmail.com>
User-Agent: Alpine 2.20.13 (LNX 116 2015-12-14)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="168458499-1805300261-1597041837=:2454"
X-Mailman-Approved-At: Mon, 10 Aug 2020 07:36:09 +0000
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
Cc: Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--168458499-1805300261-1597041837=:2454
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

you should Сс a specialized mailing list and a relevant maintainer,
otherwise your email is likely to be ignored as LKML is an incredibly
high-volume list. Adding amd-gfx and Alex Deucher.

More thoughts below.

On Sun, 9 Aug 2020, Ignat Insarov wrote:

> Hello!
> 
> This is an issue report. I am not familiar with the Linux kernel
> development procedure, so please direct me to a more appropriate or
> specialized medium if this is not the right avenue.
> 
> My laptop (Ryzen 7 Pro CPU/GPU) boots into dark screen more often than
> not. Screen blackness correlates with a line in the `systemd` journal
> that says `RAM width Nbits DDR4`, where N is either 128 (resulting in
> dark screen) or 64 (resulting in a healthy boot). The number seems to
> be chosen at random with bias towards 128. This has been going on for
> a while so here is some statistics:
> 
> * 356 boots proceed far enough to  attempt mode setting.
> * 82 boots set RAM width to 64 bits and presumably succeed.
> * 274 boots set RAM width to 128 bits and presumably fail.
> 
> The issue is prevented with the `nomodeset` kernel option.
> 
> I reported this previously (about a year ago) on the forum of my Linux
> distribution.[1] The issue still persists as of  linux 5.8.0.
> 
> The details of my graphics controller, as well as some journal
> excerpts, can be seen at [1]. One thing that has changed since then is
> that on failure, there now appears a null pointer dereference error. I
> am attaching the log of kernel messages from the most recent failed
> boot — please request more information if needed.
> 
> I appreciate any directions and advice as to how I may go about fixing
> this annoyance.
> 
> [1]: https://bbs.archlinux.org/viewtopic.php?id=248273


On the forum you show that in the "success" case there's one less "BIOS
signature incorrect" message. This implies that amdgpu_get_bios() in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
gets the video BIOS from a different source. If that happens every time
(one "signature incorrect" message for "success", two for "failure")
that may be relevant to the problem you're experiencing.

If you don't mind patching and rebuilding the kernel I suggest adding
debug printks to the aforementioned function to see exactly which methods
fail with wrong signature and which succeeds.

Also might be worthwhile to check if there's a BIOS update for your laptop.

Alexander
--168458499-1805300261-1597041837=:2454
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--168458499-1805300261-1597041837=:2454--
