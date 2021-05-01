Return-Path: <SRS0=CzGJ=J6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A064FC43460
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 07:35:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E222961221
	for <amd-gfx@archiver.kernel.org>; Mon,  3 May 2021 07:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E222961221
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lisas.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5401D6E09A;
	Mon,  3 May 2021 07:35:14 +0000 (UTC)
X-Greylist: delayed 509 seconds by postgrey-1.36 at gabe;
 Sat, 01 May 2021 17:12:25 UTC
Received: from rhlx01.hs-esslingen.de (rhlx01.hs-esslingen.de [129.143.116.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B1F6E084;
 Sat,  1 May 2021 17:12:25 +0000 (UTC)
Received: by rhlx01.hs-esslingen.de (Postfix, from userid 1203)
 id 72D0520BE265; Sat,  1 May 2021 19:03:51 +0200 (CEST)
Date: Sat, 1 May 2021 19:03:51 +0200
From: Adrian Reber <adrian@lisas.de>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [RFC] CRIU support for ROCm
Message-ID: <YI2J97Rg4+1+KVNs@lisas.de>
References: <9245171d-ecc9-1bdf-3ecd-cf776dc17855@amd.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9245171d-ecc9-1bdf-3ecd-cf776dc17855@amd.com>
X-Url: <http://lisas.de/~adrian/>
X-Operating-System: Linux (5.10.10-200.fc33.x86_64)
X-Load-Average: 11.33 11.14 10.80
X-Unexpected: The Spanish Inquisition
X-GnuPG-Key: gpg --recv-keys D3C4906A
X-Mailman-Approved-At: Mon, 03 May 2021 07:35:12 +0000
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
Cc: Alexander Mihalicyn <alexander@mihalicyn.com>,
 Pavel Emelyanov <ovzxemul@gmail.com>, Pavel Tikhomirov <snorcht@gmail.com>,
 DRI Development <dri-devel@lists.freedesktop.org>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>, criu@openvz.org, "Yat Sin,
 David" <David.YatSin@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Apr 30, 2021 at 09:57:45PM -0400, Felix Kuehling wrote:
> We have been working on a prototype supporting CRIU (Checkpoint/Restore
> In Userspace) for accelerated compute applications running on AMD GPUs
> using ROCm (Radeon Open Compute Platform). We're happy to finally share
> this work publicly to solicit feedback and advice. The end-goal is to
> get this work included upstream in Linux and CRIU. A short whitepaper
> describing our design and intention can be found on Github:
> https://github.com/RadeonOpenCompute/criu/tree/criu-dev/test/others/ext-kfd/README.md.
> 
> We have RFC patch series for the kernel (based on Alex Deucher's
> amd-staging-drm-next branch) and for CRIU including a new plugin and a
> few core CRIU changes. I will send those to the respective mailing lists
> separately in a minute. They can also be found on Github.
> 
>     CRIU+plugin: https://github.com/RadeonOpenCompute/criu/commits/criu-dev
>     Kernel (KFD):
>     https://github.com/RadeonOpenCompute/ROCK-Kernel-Driver/commits/fxkamd/criu-wip
> 
> At this point this is very much a work in progress and not ready for
> upstream inclusion. There are still several missing features, known
> issues, and open questions that we would like to start addressing with
> your feedback.
> 
> What's working and tested at this point:
> 
>   * Checkpoint and restore accelerated machine learning apps: PyTorch
>     running Bert on systems with 1 or 2 GPUs (MI50 or MI100), 100%
>     unmodified user mode stack
>   * Checkpoint on one system, restore on a different system
>   * Checkpoint on one GPU, restore on a different GPU

This is very impressive. As far as I know this is the first larger
plugin written for CRIU and publicly published. It is also the first GPU
supported and people have been asking this for many years. It is in fact
the first hardware device supported through a plugin.

> Major Known issues:
> 
>   * The KFD ioctl API is not final: Needs a complete redesign to allow
>     future extension without breaking the ABI
>   * Very slow: Need to implement DMA to dump VRAM contents
> 
> Missing or incomplete features:
> 
>   * Support for the new KFD SVM API
>   * Check device topology during restore
>   * Checkpoint and restore multiple processes
>   * Support for applications using Mesa for video decode/encode
>   * Testing with more different GPUs and workloads
> 
> Big Open questions:
> 
>   * What's the preferred way to publish our CRIU plugin? In-tree or
>     out-of-tree?

I would do it in-tree.

>   * What's the preferred way to distribute our CRIU plugin? Source?
>     Binary .so? Whole CRIU? Just in-box support?

As you are planing to publish the source I would make it part of the
CRIU repository and this way it will find its way to the packages in the
different distributions.

Does the plugin require any additional dependencies? If there is no
additional dependency to a library the plugin can be easily be part of
the existing packages.

>   * If our plugin can be upstreamed in the CRIU tree, what would be the
>     right directory?

I would just put it into criu/plugins/

It would also be good to have your patchset submitted as a PR on github
to have our normal CI test coverage of the changes.

		Adrian
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
