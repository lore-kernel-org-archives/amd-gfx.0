Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB48EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Jul 2023 18:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A28F10E6DD;
	Fri, 21 Jul 2023 18:01:33 +0000 (UTC)
Received: from mail.mhcomputing.net (master.mhcomputing.net
 [IPv6:2607:f1c0:810:6500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE6510E6DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Jul 2023 18:01:31 +0000 (UTC)
Received: by mail.mhcomputing.net (Postfix, from userid 1000)
 id 384A7112; Fri, 21 Jul 2023 11:01:31 -0700 (PDT)
Date: Fri, 21 Jul 2023 11:01:31 -0700
From: Matthew Hall <mhall@mhcomputing.net>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: AMDGPU crash - request for assistance triaging / reporting
Message-ID: <20230721180131.GA10297@mhcomputing.net>
References: <20230721034359.GA1133@mhcomputing.net>
 <BL1PR12MB514416A3C79BA1E6F43FEF83F73FA@BL1PR12MB5144.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB514416A3C79BA1E6F43FEF83F73FA@BL1PR12MB5144.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jul 21, 2023 at 01:33:02PM +0000, Deucher, Alexander wrote:
> Please file a bug here:
> https://gitlab.freedesktop.org/drm/amd/-/issues

OK, here it is:

https://gitlab.freedesktop.org/drm/amd/-/issues/2718

> I believe the Z16 was certified on ubuntu, so you should have a good 
> experience with the latest ubuntu LTS with the OEM kernel package.

I tried everything stock first, and that causes the crash more than the newer 
kernel, with more serious memory ring corruption sorts of errors.

The messages from the newer kernels are tamer and less frequent, but still 
present.

> One issue we've run into is with the PSR TCON controller on some 
> models. Disabling PSR in the driver can work around that.

I see some directions about disabling the PSR using some sysfs controls. Is 
there a more reliable way of disabling it with a boot flag or something that's 
more... guaranteed to intercept it and shut it off before any display managers 
launch? Here is what I am currently seeing, let me know what else I can dump 
out...

# find /sys/kernel/debug | fgrep -i psr | sort
/sys/kernel/debug/dri/1/eDP-1/psr_capability
/sys/kernel/debug/dri/1/eDP-1/psr_residency
/sys/kernel/debug/dri/1/eDP-1/psr_state

# head -1000 /sys/kernel/debug/dri/1/eDP-1/psr_*
==> /sys/kernel/debug/dri/1/eDP-1/psr_capability <==
Sink support: yes [0x01]
Driver support: yes

==> /sys/kernel/debug/dri/1/eDP-1/psr_residency <==
0

==> /sys/kernel/debug/dri/1/eDP-1/psr_state <==
0

> A newer kernel also fixes the issue.

How new? Or what branch or sub-branch? I have compiled plenty of them back 
when Linux used to need it more often in the 90s. So I will gladly run 
whatever you want and get logs or whatever.

Thanks again for your assistance.

Regards,
Matthew.
