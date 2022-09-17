Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 717C8C6FA90
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Sep 2022 08:06:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5FE10E58F;
	Mon, 19 Sep 2022 08:06:12 +0000 (UTC)
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Sat, 17 Sep 2022 17:02:35 UTC
Received: from ach1ajh116.fra1.oracleemaildelivery.com
 (ach1ajh116.fra1.oracleemaildelivery.com [138.1.108.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E87210E44E
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Sep 2022 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-fra1-20220101;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=7ObGGwvkwsbVdVjWBkq3Mel0hVpY0UzSeJwTyf1SSjI=;
 b=OagMmVSVqflvFzEKxeU7ynuwVVJFBl84OLfEsJtSxIp4SU8vPfT0u+ReiakmSOPyVhbfAWFLAl0a
 kC1PJoCYd5kF/y4vvWS6zTzEbkMy0bwujV6ipHftMaArij1YSiMh0ZcVRuG75FquqB2gaiE+SDGv
 j37n7zJcfYHD/h8HXTqpD8ns4p4s6JP1FdtgLPzPAt+QvWe3t8GC6AMpon4CQk4uYaKNAKL8rMKo
 HeMQ13XkxWoR6btLC8vILUxQKsbEErCib+E9MOtb2RtrCREYHxdOsh9zS02l6us5b5LG4J7MOMv1
 nwd2e4vamSPlU08B3b9POvUn3eMapvoPhBehfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-fra-20191115;
 d=fra1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=7ObGGwvkwsbVdVjWBkq3Mel0hVpY0UzSeJwTyf1SSjI=;
 b=MluGiM7iULl1rhbezZi4yTmYN+8DtCDhbMA39YTP1r4FQlt3xhWZUink9X9mu9V4YEbVk3Lqd1sc
 9z/X/8CbACet5HxH7sHWHEvv8zON8g+oSZBkpL3iUKJ/POtrGPXfZ5xFyOHWkDxsYCWS+qSTdSgW
 5CwE31B0aP/A9FkTolFq49GmElzXEeXL5TVdkSrSLDg7yRnm95QIHlx8V+8kUMeKb9d/WCY/T3xi
 tRyBXRbGeTqcjMhTxVay/zUDNjOBZRRdV+5g5WmUiqHwppCzg7/8kHmOYw+tOsmsYBrGLH5dyV76
 pDidXGpxRwXN4OD3ANiV3UpPjKaxwoihzpbdGw==
Received: by omta-ad3-fd3-302-eu-frankfurt-1.omtaad3.vcndpfra.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20220826 64bit (built Aug 26
 2022)) with ESMTPS id
 <0RID00G0J5RWDH10@omta-ad3-fd3-302-eu-frankfurt-1.omtaad3.vcndpfra.oraclevcn.com>
 for amd-gfx@lists.freedesktop.org; Sat, 17 Sep 2022 16:57:32 +0000 (GMT)
Message-id: <c1f8886a-5624-8f49-31b1-e42b6d20dcf5@augustwikerfors.se>
Date: Sat, 17 Sep 2022 18:57:28 +0200
MIME-version: 1.0
From: August Wikerfors <git@augustwikerfors.se>
Subject: [REGRESSION] Graphical issues on Lenovo Yoga 7 14ARB7 laptop since
 v6.0-rc1 (bisected)
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Content-language: en-US
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAF2mgUR8cFnMjGh0lEzMZlmhqwUNFC3wJ4Q40oSCReejZnSNcQxRaC+2EfUW+cL
 Gf0CcJ1iAZGRcDf0h8T5Sv6JdreHdNALvuCN/fTGsAw2F2UWl/lnVBaBfLjUCAEg
 6vckTs1Nxig4r63QQvCyclk050CkshFRQDHbGkYo6wrmSvKVK7i0z+nDg9Z5xSkh
 l4vL1eIBdjfJiHYIz+tf2cCYnFZ8792wCYblEQmSW7pLb2aWPOovJlf+LRIRCfPq
 xz3bXh2O74/oCJZazvNSwcewy2VNGCO7A7h+Gw7d4qm8ujRZcTxteT5+DfLgbV9t
 mGTRzTSf5fWMoqh2h2Q3XpiHL2kWSqr0oUk+0TL71NfM8eayJKOY85wYOL1zeO9M
 AtDxChMe9iDKE5oum7NONkfXg9rZOFfRpoLxXT8daBnfO1BzNA5NP3r0lpy4o9Z0 rHkPoFZKSQ==
X-Mailman-Approved-At: Mon, 19 Sep 2022 08:06:06 +0000
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
 amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,
with every kernel version since v6.0-rc1, including the latest git 
master, there are constant graphical issues on this laptop, such as 
heavy stuttering (this is especially noticeable while typing on the 
keyboard), parts of the screen showing random noise, and the entire 
desktop environment freezing.

I bisected the issue which showed that this is the first bad commit:

> commit 7cc191ee7621b7145c6cc9c18a4e1929bb5f136e
> Author: Leo Li <sunpeng.li@amd.com>
> Date:   Wed Mar 30 12:45:09 2022 -0400
> 
>     drm/amd/display: Implement MPO PSR SU
>     
>     [WHY]
>     
>     For additional power savings, PSR SU (also referred to as PSR2) can be
>     enabled on eDP panels with PSR SU support.
>     
>     PSR2 saves more power compared to PSR1 by allowing more opportunities
>     for the display hardware to be shut down. In comparison to PSR1, Shut
>     down can now occur in-between frames, as well as in display regions
>     where there is no visible update. In otherwords, it allows for some
>     display hw components to be enabled only for a **selectively updated**
>     region of the visible display. Hence PSR SU.
>     
>     [HOW]
>     
>     To define the SU region, support from the OS is required. OS needs to
>     inform driver of damaged regions that need to be flushed to the eDP
>     panel. Today, such support is lacking in most compositors.
>     
>     Therefore, an in-between solution is to implement PSR SU for MPO and
>     cursor scenarios. The plane bounds can be used to define the damaged
>     region to be flushed to panel. This is achieved by:
>     
>     * Leveraging dm_crtc_state->mpo_requested flag to identify when MPO is
>       enabled.
>     * If MPO is enabled, only add updated plane bounds to dirty region.
>       Determine plane update by either:
>         * Existence of drm damaged clips attached to the plane (added by a
>           damage-aware compositor)
>         * Change in fb id (flip)
>         * Change in plane bounds (position and dimensions)
>     * If cursor is enabled, the old_pos and new_pos of cursor plus cursor
>       size is used as damaged regions(*).
>     
>     (*) Cursor updates follow a different code path through DC. PSR SU for
>     cursor is already implemented in DC, and the only thing required to
>     enable is to set DC_PSR_VERSION_SU_1 on the eDP link. See
>     dcn10_dmub_update_cursor_data().
>     
>     Signed-off-by: Leo Li <sunpeng.li@amd.com>
>     Acked-by: Leo Li <sunpeng.li@amd.com>
>     Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

#regzbot introduced: 7cc191ee7621b7145c6cc9c18a4e1929bb5f136e

Note that while bisecting I also needed to apply commit 
9946e39fe8d0a5da9eb947d8e40a7ef204ba016e as the keyboard doesn't work 
without it.

Laptop model: Lenovo Yoga 7 14ARB7
CPU: AMD Ryzen 5 6600U
Kernel config: 
https://raw.githubusercontent.com/archlinux/svntogit-packages/aa564cf7088b1d834ef4cda9cb48ff0283fde5c5/trunk/config
Distribution: Arch Linux
Desktop environment: KDE Plasma 5.25.5

lspci:
> $ lspci -nn
> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b5] (rev 01)
> 00:00.2 IOMMU [0806]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b6]
> 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b7] (rev 01)
> 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b7] (rev 01)
> 00:02.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:14ba]
> 00:02.4 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:14ba]
> 00:02.5 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:14ba]
> 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b7] (rev 01)
> 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:14cd]
> 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b7] (rev 01)
> 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b7] (rev 01)
> 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b9] (rev 10)
> 00:08.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:14b9] (rev 10)
> 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 71)
> 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
> 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1679]
> 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:167a]
> 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:167b]
> 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:167c]
> 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:167d]
> 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:167e]
> 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:167f]
> 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1680]
> 01:00.0 Network controller [0280]: MEDIATEK Corp. MT7922 802.11ax PCI Express Wireless Network Adapter [14c3:0616]
> 02:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd Device [144d:a80b] (rev 02)
> 03:00.0 SD Host controller [0805]: O2 Micro, Inc. SD/MMC Card Reader Controller [1217:8621] (rev 01)
> 33:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Rembrandt [Radeon 680M] [1002:1681] (rev c2)
> 33:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Rembrandt Radeon High Definition Audio Controller [1002:1640]
> 33:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] VanGogh PSP/CCP [1022:1649]
> 33:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:161d]
> 33:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:161e]
> 33:00.5 Multimedia controller [0480]: Advanced Micro Devices, Inc. [AMD] ACP/ACP3X/ACP6x Audio Coprocessor [1022:15e2] (rev 60)
> 33:00.6 Audio device [0403]: Advanced Micro Devices, Inc. [AMD] Family 17h/19h HD Audio Controller [1022:15e3]
> 34:00.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:161f]
> 34:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:15d6]
> 34:00.4 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:15d7]
> 34:00.5 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:162e]
