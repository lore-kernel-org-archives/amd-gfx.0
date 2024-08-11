Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03794C531DC
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Aug 2024 07:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6070810E148;
	Mon, 12 Aug 2024 07:31:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=typeblog.net header.i=@typeblog.net header.b="JyxgTnhJ";
	dkim-atps=neutral
X-Greylist: delayed 372 seconds by postgrey-1.36 at gabe;
 Sun, 11 Aug 2024 13:42:35 UTC
Received: from mail.typeblog.net (mail.typeblog.net [88.151.33.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7452F10E037
 for <amd-gfx@lists.freedesktop.org>; Sun, 11 Aug 2024 13:42:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 552E89B05D6; Sun, 11 Aug 2024 15:36:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=typeblog.net;
 s=mailcow; t=1723383379;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=ivigbb9xMm1ZNuDdd5y5spX8twxwH/H+kZwec4D/O+I=;
 b=JyxgTnhJdRhvid7qS+A+E7MsFr5L1oQwnAK/ROxakAzbSrt50j7bkFTlkwlJTvnaMU+pIH
 zCOpXy1i03noxA1dURp0WR68uKCiV/jKSEKV0K/jNZPbqaPmofLz5v3g+FGAdzL5Mx6KQm
 TFl2+sGUN+R9mxDIqt+8nq/gXAo3HW3e6SMrwcIbSBXs6AsNRtPxf6ZzbHaNrdj7bV3jl8
 FtQzPr1nSaFeyNbJYHvf/cvvQPU5i9ZAhiudy1Xnvag0bze7AOPmWANc9RnHJJ+Nk7DAjn
 ImWwSOpfCp6ny13pD+GG4GkPkXaU8eetshPojO0ec34VgRzZs9YfvJ1ugt2bRg==
Message-ID: <872a3e83-9bc5-47de-8514-48abe8ff03c5@typeblog.net>
Date: Sun, 11 Aug 2024 09:36:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Wayne Lin <wayne.lin@amd.com>, amd-gfx@lists.freedesktop.org,
 regressions@lists.linux.dev
From: Peter Cai <peter@typeblog.net>
Subject: [REGRESSION] amdgpu enables DSC unnecessarily over MST hubs on kernel
 6.11+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Mon, 12 Aug 2024 07:31:01 +0000
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

Hi,

I have been using a DisplayPort MST hub with a AMD Ryzen 6800U laptop 
(GPD Win Max 2) for a while. The hub exposes 2 downstream ports, both of 
which are connected to 4K (3840x2160) displays. Recently I was hit with 
another regression in Linux 6.10 (link: 
https://lore.kernel.org/stable/d74a7768e957e6ce88c27a5bece0c64dff132e24@holm.dev/T/#u) 
that caused MST displays to stop lighting up. This was caused by 
4df96ba66760345471a85ef7bb29e1cd4e956057 and later fixed in mainline by 
fa57924c76d995e87ca3533ec60d1d5e55769a27.

However, even with that fix, one of my displays is still misbehaving. 
The display seems to be running at no more than 20Hz even though the 
output mode is clearly set to 3840x2160@60 from the point of view of 
both the Wayland compositor and the kernel. Some debugging again pointed 
to the refactored `dm_dp_mst_is_port_support_mode()` function involved 
in the aforementioned commits as the problem. Specifically, it seems 
that the function before commit 4df96ba66760345471a85ef7bb29e1cd4e956057 
returns `DC_OK` for my setup, while the version after 
`fa57924c76d995e87ca3533ec60d1d5e55769a27` insists that it must set the 
DSC bit, shown by the debug kernel message "Require dsc and dsc config 
found". When the DSC flag is set, this display of mine seems to just 
misbehave like what is mentioned.

I've done some further print-based debugging to identify why the DSC 
branch is now taken. Adding a print right before

 > if (stream_kbps <= end_to_end_bw_in_kbps) {

gives me

 > [   38.079643] [drm:dm_dp_mst_is_port_support_mode [amdgpu]] 
stream_kbps = 12798000, root_link_bw_in_kbps = 12571200, 
virtual_channel_bw_in_kbps = 17176320

Since `end_to_end_bw_in_kbps` is `min(root_link_bw_in_kbps, 
virtual_channel_bw_in_kbps)`, this causes the DSC branch to be taken.

Before the changes that took `root_link_bw_in_kbps` into consideration, 
my setup was clearly working and I haven't encountered any problem 
whatsoever. The value `12571200` also feels a bit off to me since if 
this is fetched from `aconnector->dc_link`, it should represent the 
bandwidth available on the entire DP link between PC <-> MST Hub? In 
this case, it seems to be way too low to be correct; and, again, the 
dual 4K display setup has been working without checking this value. 
Modifying the latest mainline to remove `root_link_bw_in_kbps` from the 
equation also seems to fix the problem for me.

It feels like my display shouldn't misbehave like that with the DSC bit 
set, but again it is the kernel that didn't set the DSC bit before but 
now does. I think this should count as a regression, but I'm not sure if 
it is just me who is seeing this problem.

For reference, the problematic display in question here is a Samsung 
LS27A80. The MST hub used is an Anker 554 USB-C Docking Station / KVM 
Switch.

Regards,
Peter.
