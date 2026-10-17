Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF664CCF2CA
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 17:30:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4488A10E466;
	Sat, 17 Oct 2026 17:30:53 +0000 (UTC)
X-Greylist: delayed 342 seconds by postgrey-1.36 at gabe;
 Sat, 17 Oct 2026 14:32:40 UTC
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net
 [178.154.239.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54DFB10E41F
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 14:32:40 +0000 (UTC)
Received: from forward502d.mail.yandex.net (forward502d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d502])
 by forward200d.mail.yandex.net (postfix) with ESMTPS id C27FD80DFB
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 17:26:54 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.yp-c.yandex.net)
 by forward502d.mail.yandex.net (postfix) with ESMTPS id 73F7CC0145;
 Sat, 17 Oct 2026 17:26:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63 with ESMTPSA id
 VQYgGp9dRGk0-6mIrrFy9; Sat, 17 Oct 2026 17:26:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1792247211; bh=zHdS8fzX1vnITF5pIdH/IG5QQ6eX0WxwNF77nTGlmNI=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=MC2ni410jK1cNDj3aw5JjFvLQGuhszJMRZ8RX3EKJT98sAn48++XeHrgqG5p8Bvmo
 Mk2UOwCigfkZEOwPoKAzoT8x2FLBAA7/Mn3GI2cm40OXdAOxToSJC3gpa9r7BayOU4
 XfbIzWQb+KYDOIt0LuUyzn4zVaPztKwik8TYN4bk=
Authentication-Results: mail-nwsmtp-smtp-production-main-63;
 dkim=pass header.i=@yandex.ru
From: Sergey Armodin <dolph-in@yandex.ru>
To: Maciej Kucharek <qchcio@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] drm/amdgpu: reset VI ASIC on Apple boards with
 VRAM at 0
Date: Sat, 17 Oct 2026 21:26:28 +0700
Message-ID: <20261017142628.9186-1-dolph-in@yandex.ru>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015095713.20560-4-qchcio@gmail.com>
References: <20261015095713.20560-4-qchcio@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 17 Oct 2026 17:30:48 +0000
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

Hi Maciej,

I tested this patch on a MacBookPro14,3 with the Radeon Pro 560
(1002:67ef, subsystem 106b:0179, rev c0), which is not in
vi_reset_quirks[].  The kernel is 7.2.5 with commits a5be7ad8f5f0 and
a22e5e4f2ebb backported, plus distribution patches; amdgpu was built
from that tree with this patch on top.

Without the patch this board boots with VRAM at 0 every time
(MC_VM_FB_LOCATION 0x00ff0000), and a re-post moves it to 0xf4fff400
under the driver.

With it, after both a warm reboot and a cold boot (powered off for
three minutes), amdgpu logs "PCI CONFIG reset" and "GPU posting now..."
on load, VRAM is at 0x000000F400000000, MC_VM_FB_LOCATION reads
0xf4fff400 through debugfs, and there are no amdgpu errors.

I then ran five S3 cycles with rtcwake.  After each resume
MC_VM_FB_LOCATION was still 0xf4fff400, the GART table was at
0x000000F401B00000, the internal panel came back, and the kernel log
showed no amdgpu errors, ring timeouts or IOMMU faults.

The 560 is not in vi_reset_quirks[], so v3 3/3 behaves the same way on
this machine.  This also covers the one-line quirk entry I sent for
this GPU [1], so that one can be dropped.

Tested-by: Sergey Armodin <dolph-in@yandex.ru> # MacBookPro14,3, Radeon Pro 560

[1] https://lore.kernel.org/amd-gfx/20261016-amdgpu-pro560-quirk-v1-1-3e5d3fe5ff29@yandex.ru/
