Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211D9E92733
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Dec 2025 16:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 902C610E54B;
	Mon, 29 Dec 2025 16:22:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GZCacrrh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D2A510E50A
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Dec 2025 15:40:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id E1E7A6000A;
 Mon, 29 Dec 2025 15:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17530C16AAE;
 Mon, 29 Dec 2025 15:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1767022826;
 bh=3Z8D+V4bPrmjRWPUc4/T1IQEppsi7x5xJn5ti8fdgl8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GZCacrrhB9ZrtVqsp0fEzkyOnBtbzWRuk3bIfJCuy4ov0KB0u3oW8d+gN0V7FgJdr
 sl/qX1LQA758vQlCxGowQmh5f5AQEmK+WVMIgD0j/uIoUalM0RS2aGS6gN4Y6yZGm3
 Bess4oeXRYbcZyzNRG/9qQW32wZdWooJTNoJDG9Y=
Date: Mon, 29 Dec 2025 16:40:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com, ivan.lipski@amd.com, Jerry.Zuo@amd.com,
 bugs@lists.linux.dev, regressions@lists.linux.dev, daniel.wheeler@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?iso-8859-1?Q?P=E9ter?= Bohner <peter.bohner@student.kit.edu>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 aurabindo.pillai@amd.com
Subject: Re: [6.12.61 lts] [amdgpu]: regression: broken multi-monitor USB4
 dock on Ryzen 7840U
Message-ID: <2025122914-province-vividly-fea1@gregkh>
References: <9444c2d3-2aaf-4982-9f75-23dc814c3885@student.kit.edu>
 <ea735f1a-04c3-42dc-9e4c-4dc26659834f@oracle.com>
 <b1b8fc3b-6e80-403b-a1a0-726cc935fd2e@student.kit.edu>
 <bfb82a48-ebe3-4dc0-97e2-7cbf9d1e84ed@oracle.com>
 <7817ae7c-72d3-470d-b043-51bcfbee31b1@student.kit.edu>
 <d5664e24-71a1-4d46-96ad-979b15f97df9@student.kit.edu>
 <ee6e0b89-c3d0-4579-9c26-a9a980775e55@leemhuis.info>
 <24e5cb3b-73dd-43d3-9d35-b29d1d18340a@amd.com>
 <c7bec14b-ee8b-448f-a7ad-a741ff974ea9@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7bec14b-ee8b-448f-a7ad-a741ff974ea9@leemhuis.info>
X-Mailman-Approved-At: Mon, 29 Dec 2025 16:22:13 +0000
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

On Tue, Dec 16, 2025 at 12:14:23PM +0100, Thorsten Leemhuis wrote:
> Greg, Sasha, could you please pick up 72e24456a54fe0 ("Revert
> "drm/amd/display: Fix pbn to kbps Conversion"") [v6.19-rc1] for 6.12.y
> and 6.17.y (if there is another 6.17.y version), as it fixes a a
> regression there? See below for details.
> 
> Note, the mentioned patch contains "Cc:stable@vger.kernel.org # 6.17+",
> but needs to go to 6.12.y, too: the culprit was backported there and
> causes problems there, too.


Now queued up, thanks.

greg k-h
