Return-Path: <SRS0=Seja=5K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4264C2D0E6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:20:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EBFF206F6
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2020 19:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EBFF206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=earthlink.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4585389C61;
	Wed, 25 Mar 2020 19:20:07 +0000 (UTC)
Received: from elasmtp-kukur.atl.sa.earthlink.net
 (elasmtp-kukur.atl.sa.earthlink.net [209.86.89.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 982CB89C61
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 19:20:06 +0000 (UTC)
Received: from [104.136.253.32] (helo=[192.168.0.11])
 by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4)
 (envelope-from <mrmazda@earthlink.net>) id 1jH2We-0001rM-M7
 for amd-gfx@lists.freedesktop.org; Wed, 25 Mar 2020 05:40:40 -0400
To: amd-gfx@lists.freedesktop.org
From: Felix Miata <mrmazda@earthlink.net>
Subject: rv200 video corruption caused by what? kernel? Xserver? DDX? Mesa?
Organization: less than infinite
Message-ID: <08b2d969-67e4-336c-1fce-3b5f24157ee4@earthlink.net>
Date: Wed, 25 Mar 2020 05:40:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 SeaMonkey/2.49.5
MIME-Version: 1.0
X-ELNK-Trace: 7235c9a3853724b974bf435c0eb9d478486f62d0a25b55cb25ca934dbac66878b9bdbca6983c9fcb350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 104.136.253.32
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] RV200 [Radeon 7500/7500 LE] [1002:5157]

Debian Buster and Mageia 7 are OK, but with Fedora 30 and Tumbleweed with
kernels newer than 5.3.x, solid background and mouse pointer are all that
paint properly: http://fm.no-ip.com/SS/rv200corrupt.png

Is this a known problem? If not, whose bug tracker do I file this on, and
which component?

# Debian 10 Buster
ii libdrm-amdgpu1:i386       2.4.97-1        i386
ii libdrm-common             2.4.97-1        all 
ii libdrm-radeon1:i386       2.4.97-1        i386
ii libdrm2:i386              2.4.97-1        i386
ii libgl1-mesa-dri:i386     18.3.6-2+deb10u1 i386
ii libva-drm2:i386           2.4.0-1         i386
ii libdrm-radeon1:i386       2.4.97-1        i386
ii xserver-xorg-core         2:1.20.4-1      i386
ii xserver-xorg-video-radeon 1:19.0.1-1      i386
ii linux-image-4.19.0-8-686  4.19.98-1       i386  # OK Xorg video
# Mageia 7
libdricore1-9.2.4-1.mga4
libdri-drivers-20.0.1-1.mga7
libdrm2-2.4.100-1.mga7
libdrm_amdgpu1-2.4.100-1.mga7
libdrm_radeon1-2.4.100-1.mga7
libmesaegl1-20.0.1-1.mga7
libmesagl1-20.0.1-1.mga7
libmesaglu1-9.0.0-8.mga7
mesa-20.0.1-1.mga7
radeontool-1.6.3-9.mga7
x11-driver-video-ati-19.1.0-1.mga7
x11-server-xorg-1.20.7-1.mga7
kernel-desktop-5.3.13-2.mga7-1-1.mga7	# OK
kernel-desktop-5.4.17-1.mga7-1-1.mga7	# OK Xorg video
# Fedora 30
libdrm-2.4.100-1.fc30.i686
mesa-dri-drivers-19.1.8-1.fc30.i686
mesa-libEGL-19.1.8-1.fc30.i686
mesa-libgbm-19.1.8-1.fc30.i686
mesa-libGL-19.1.8-1.fc30.i686
mesa-libglapi-19.1.8-1.fc30.i686
mesa-libGLU-9.0.0-17.fc30.i686
xorg-x11-drv-ati-19.0.1-2.fc30.i686
xorg-x11-server-Xorg-1.20.6-1.fc30.i686
kernel-core-5.3.7-200.fc30.i686		# OK
kernel-core-5.4.19-100.fc30.i686	# Corrupt Xorg video
# openSUSE Tumbleweed 2020030322
Mesa-20.0.1-245.1.i586
Mesa-dri-20.0.1-245.1.i586
Mesa-gallium-20.0.1-245.1.i586
Mesa-libEGL1-20.0.1-245.1.i586
Mesa-libGL1-20.0.1-245.1.i586
Mesa-libglapi0-20.0.1-245.1.i586
libdrm2-2.4.100-2.2.i586
libdrm_amdgpu1-2.4.100-2.2.i586
libdrm_radeon1-2.4.100-2.2.i586
xf86-video-ati-19.1.0-2.2.i586
xorg-x11-server-1.20.7+0-3.1.i586
kernel-default-5.3.12-2.2.i586		# OK
kernel-default-5.4.14-2.1.i586		# corrupt Xorg video
-- 
Evolution as taught in public schools is religion, not science.

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
