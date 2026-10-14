Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A878FCC6B2A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 12:37:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E59B10E569;
	Wed, 14 Oct 2026 12:37:26 +0000 (UTC)
X-Greylist: delayed 556 seconds by postgrey-1.36 at gabe;
 Wed, 14 Oct 2026 12:37:19 UTC
Received: from mail.rostovtsev.org (mail.rostovtsev.org [69.164.217.183])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C43F410E569
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rostovtsev.org;
 s=20250925; t=1791980882;
 bh=lgPRutbnL9My5xzu+wkjtSlvKDkwxxyScmeo/GV/L3A=;
 h=From:To:Subject:Date:From;
 b=aE/7SKuHKGR1jfwdZMqd2WbLmLYccMLo65ko593jlgXe7YHKKf0tmG7nLAv8UXQY2
 LBTeVHytVVlfpeotSpa0MpcSX3PAOOXqaS9Fj9pKGmOUGEWPJ9rQI0s2Eoq0dwMkyS
 3E/JZFtfjHGWcSaB543S2N6gE7E7bC6ZaBMgrZFKazYlnkZr4eiW7H5DwHLwkwJXo0
 RWjZUaDb6bYS64WRETHVmXwt+lxw878HcisfsA07JS9BJ2ZLNNJtUVJ6UCHXaKlUef
 i1FwxlAQvQhTrpIPEF5iJ9ydo1H6rSNdUHYU6BMHETb/puiDOWJ0FFk07590ANpkZv
 8QR0p3Ydsj2wA==
Received: by mail.rostovtsev.org (Postfix, from userid 1000)
 id 3F33820209; Wed, 14 Oct 2026 12:28:02 +0000 (UTC)
From: dan@rostovtsev.org
To: amd-gfx@lists.freedesktop.org
Subject: Can xf86-video-amdgpu be used as a replacement for closed-source
 AMD firmware?
Date: Wed, 14 Oct 2026 08:27:58 -0400
Message-ID: <85a4ogwjox.fsf@rostovtsev.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi XOrg / Freedesktop,

I would like to avoid using any closed-source AMD firmware if
possible. I have a Radeon R9700. Does the xf86-video-amdgpu library
offer a solution?

The README says:

"xf86-video-amdgpu - Xorg driver for AMD Radeon GPUs using the amdgpu
kernel driver"

but I can't tell if the amdgpu module and the associated closed-source
firmware blobs are actually necessary. I've checked the following
sources and failed to find a clear answer:

- https://www.kernel.org/doc/html/v4.11/gpu/drm-internals.html
- https://www.x.org/RadeonFeature/
- the xf86-video-amdgpu source
- the kernel source, particularly in: drivers/gpu/amd/amdgpu
- https://lists.freedesktop.org/mailman/listinfo/amd-gfx for related
  questions

I'm particularly confused by the inclusions of "amdgpu.h" in the
xf86-video-amdgpu source tree. Looking at src/amdgpu_probe.h in
xf86-video-amdgpu, for example:

...
#include <amdgpu.h>
...
amdgpu_device_handle pDev;
...

The "amdgpu_device_handle" does not exist in xf86-video-amdgpu or in the
kernel when I search with grep. Where is this handle coming from?

Any response is greatly appreciated!

Thanks,

Dan
