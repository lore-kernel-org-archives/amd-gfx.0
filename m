Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F06EC25B4E
	for <amd-gfx@archiver.kernel.org>; Sun, 22 Jan 2023 21:33:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B15E810E2FE;
	Sun, 22 Jan 2023 21:33:10 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF93F10E05A
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Jan 2023 07:28:22 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 49F57B82A23;
 Sat, 21 Jan 2023 07:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89570C433EF;
 Sat, 21 Jan 2023 07:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1674286099;
 bh=uelgkkZaVqe9jys5JEJEwc7kCy9WMXkTngwZlLUTO98=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RZj7zOmZx4ZeiLs0jZLeZMGauIj7LrvvUlujVoVmB4FMVRDd25R1M1Uh8ou4k2dnS
 e/F9G58buKo8i24ohcNp2za464IXZhUdMUrO9k53bZwFJ0cCMU6u+y17J6QHzRQfPj
 NZKcSJLBmGvT3Dt1yKoE1eUHe9S/prcVM2cIKnvk=
Date: Sat, 21 Jan 2023 08:28:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Tim Huang <tim.huang@amd.com>
Subject: Re: [PATCH RESEND] drm/amdgpu: skip psp suspend for IMU enabled
 ASICs mode2 reset
Message-ID: <Y8uUEUwXCq0yztbq@kroah.com>
References: <20230121021216.1596133-1-tim.huang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121021216.1596133-1-tim.huang@amd.com>
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

On Sat, Jan 21, 2023 at 10:12:16AM +0800, Tim Huang wrote:
> The psp suspend & resume should be skipped to avoid destroy
> the TMR and reload FWs again for IMU enabled APU ASICs.
> 
> Signed-off-by: Tim Huang <tim.huang@amd.com>
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
