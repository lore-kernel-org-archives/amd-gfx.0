Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D80CE7CE1
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Oct 2024 07:30:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705C210E5F1;
	Tue,  1 Oct 2024 07:30:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=johnrowley.me header.i=@johnrowley.me header.b="CI+sX28S";
	dkim-atps=neutral
X-Greylist: delayed 354 seconds by postgrey-1.36 at gabe;
 Mon, 30 Sep 2024 18:16:37 UTC
Received: from mail.vapourmail.eu (mail.vapourmail.eu [5.75.183.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70DC10E10A
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Sep 2024 18:16:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 54A7BC28D7; Mon, 30 Sep 2024 19:10:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
 s=dkim; t=1727719840;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language;
 bh=3dAdbcbJJ9VLoqO4daWg/sllCoK2xWT5SGbvrdPRIIs=;
 b=CI+sX28SdlAOYCpDpU/HUAnvQe6jVi5sXgCXOcetpJz5J31MQh3QPdaNj5PpQRpLhiWu3X
 kXPTfrkOAhc7AxDk4vXBq/vYZEtpTzD0DMMCs342h7oOdP5alecTdgAdkeKJZpULokT+0a
 2zgzFBNhDhmL8/lrSSnlmbT4GJi58tWkfXLYMpVgsOYY93+LRdqbd4wp0z/24ZaJm4E+Wy
 IVhURo2Kk62+jlIzjw5sQII9xrKMt3Ffxw4tChpa1OqT/5k/IT+SppxabsNUgh/5FFznTd
 +UdALfJ4P62i5b/ac/CJbiV7+Q25+R1FukScAdMIV0JiTz9DNCe/Za9jyMw2GQ==
Message-ID: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
Date: Mon, 30 Sep 2024 19:10:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
From: John Rowley <lkml@johnrowley.me>
Subject: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 01 Oct 2024 07:30:08 +0000
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

Since 58a261bfc967, I'm experiencing choppy display performance on my Framework 13 laptop. I ran a git bisect and narrowed it down to:

    commit 58a261bfc96763a851cb48b203ed57da37e157b8
    Author: Hamza Mahfooz <hamza.mahfooz@amd.com>
    Date:   Thu Aug 22 11:58:22 2024 -0400

        drm/amd/display: use a more lax vblank enable policy for older ASICs

Reverting this commit on top of the current mainline 6.12-rc1 (9852d85ec9d4) fixes the problem and GPU performance is back to normal.

Without the revert I get sluggish and janky animations in both GNOME 47 and Sway 1.9 on Chimera Linux, along with slight input delay when typing into text fields, etc.

Nothing else is different between this commit and previous working versions (6.11) of the kernel, i.e. same config, desktop setup.

Please let me know if there's anything I can do to help debug/test. :)

Regards.

Bisect log:

# bad: [9852d85ec9d492ebef56dc5f229416c925758edc] Linux 6.12-rc1
# good: [98f7e32f20d28ec452afb208f9cffc08448a2652] Linux 6.11
git bisect start 'v6.12-rc1' 'v6.11'
# good: [176000734ee2978121fde22a954eb1eabb204329] Merge tag 'ata-6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux
git bisect good 176000734ee2978121fde22a954eb1eabb204329
# bad: [d0359e4ca0f26aaf3118124dfb562e3b3dca1c06] Merge tag 'fs_for_v6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs
git bisect bad d0359e4ca0f26aaf3118124dfb562e3b3dca1c06
# bad: [171754c3808214d4fd8843eab584599a429deb52] Merge tag 'vfs-6.12.blocksize' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
git bisect bad 171754c3808214d4fd8843eab584599a429deb52
# good: [e55ef65510a401862b902dc979441ea10ae25c61] Merge tag 'amd-drm-next-6.12-2024-08-26' of https://gitlab.freedesktop.org/agd5f/linux into drm-next
git bisect good e55ef65510a401862b902dc979441ea10ae25c61
# bad: [32bd3eb5fbab954e68adba8c0b6a43cf03605c93] Merge tag 'drm-intel-gt-next-2024-09-06' of https://gitlab.freedesktop.org/drm/i915/kernel into drm-next
git bisect bad 32bd3eb5fbab954e68adba8c0b6a43cf03605c93
# bad: [8bdb468dd7a5d17f8556afdd4c8d046939ff965f] Merge tag 'drm-xe-next-2024-08-28' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next
git bisect bad 8bdb468dd7a5d17f8556afdd4c8d046939ff965f
# good: [77cc3f6c58b1b28cee73904946c46a1415187d04] drm/xe: Invalidate media_gt TLBs
git bisect good 77cc3f6c58b1b28cee73904946c46a1415187d04
# bad: [42e08287a3185409a7a1923374a557e04fc36e48] drm/ipuv3/parallel: convert to struct drm_edid
git bisect bad 42e08287a3185409a7a1923374a557e04fc36e48
# bad: [071d583e01c88272f6ff216d4f867f8f35e94d7d] drm: Expand max DRM device number to full MINORBITS
git bisect bad 071d583e01c88272f6ff216d4f867f8f35e94d7d
# bad: [e794b7b9b92977365c693760a259f8eef940c536] drm: omapdrm: Add missing check for alloc_ordered_workqueue
git bisect bad e794b7b9b92977365c693760a259f8eef940c536
# good: [cb5164ac43d0fc37ac6b45cabbc4d244068289ef] drm/panic: Add a QR code panic screen
git bisect good cb5164ac43d0fc37ac6b45cabbc4d244068289ef
# good: [e45b6716de4bf06b628a9f3559f7fc8dd5e94d58] drm/amd/display: use a more lax vblank enable policy for DCN35+
git bisect good e45b6716de4bf06b628a9f3559f7fc8dd5e94d58
# bad: [6729c73103bd7a0e60b0c980b51b5434010b4502] drm/ttm: fix kernel-doc typo for @trylock_only
git bisect bad 6729c73103bd7a0e60b0c980b51b5434010b4502
# bad: [58a261bfc96763a851cb48b203ed57da37e157b8] drm/amd/display: use a more lax vblank enable policy for older ASICs
git bisect bad 58a261bfc96763a851cb48b203ed57da37e157b8
# first bad commit: [58a261bfc96763a851cb48b203ed57da37e157b8] drm/amd/display: use a more lax vblank enable policy for older ASICs

