Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6FFC38142
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Jan 2023 21:33:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9786910E1CA;
	Sun, 22 Jan 2023 21:33:01 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5464410E14E
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Jan 2023 07:20:33 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 14899606DC;
 Sat, 21 Jan 2023 07:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DDCC433D2;
 Sat, 21 Jan 2023 07:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674285631;
 bh=PnVSxXkaLYKWQfgTwGiRvhv/631TKMtH6r7V3MnhUjE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=CGVVHl+901mj841DkQ2+w2VR97373sUHMkCDOghEHcOWA1pfL1RGPRwRzyaDjBZa6
 4rXUkYyPUp6Z2xu2LfLZ3jbO1vDGYF9xbykdYjnEYn2d/LOvYSQYXiraqdQoBmY2Or
 BSSvubc/g2KSCM9x8I36Wk6ssk+5iOM1GQDmzAVo=
Date: Sat, 21 Jan 2023 08:20:28 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tim Huang <tim.huang@amd.com>
Subject: Re: [PATCH v2] drm/amd/pm: drop unneeded dpm features disablement
 for SMU 13.0.4/11
Message-ID: <Y8uSPP34u39uPvvp@kroah.com>
References: <20230121024955.1601467-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121024955.1601467-1-tim.huang@amd.com>
X-Mailman-Approved-At: Sun, 22 Jan 2023 21:32:59 +0000
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
Cc: mario.limonciello@amd.com, Yifan1.zhang@amd.com, Xiaojian.Du@amd.com,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, li.ma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jan 21, 2023 at 10:49:55AM +0800, Tim Huang wrote:
> PMFW will handle that properly for gpu reset case. Driver involvement
> may cause some unexpected issues.
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
