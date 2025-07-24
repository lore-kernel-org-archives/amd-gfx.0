Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351D8C87FCA
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 16:58:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A388110E9B6;
	Thu, 24 Jul 2025 16:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=daenzer.net header.i=@daenzer.net header.b="CUCOpCMl";
	dkim-atps=neutral
X-Greylist: delayed 372 seconds by postgrey-1.36 at gabe;
 Thu, 24 Jul 2025 16:58:50 UTC
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8D210E9A4;
 Thu, 24 Jul 2025 16:58:49 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; t=1753375955; x=1753980755; s=webland;
 d=daenzer.net; c=relaxed/relaxed; v=1;
 bh=cUm2b5zlmI1vrx3Kzu7QTDrrIx+kJks4DdJW3FmOvko=;
 h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Transfer-Encoding; 
 b=CUCOpCMlDRC/MJ/Y2+qfLo3et/DpuwjX2cueqT7Fg6UC2j0o49V3I/f3Ab+Viyp7HwgygUgJ9nf/NUYrWjfLDVffe2/hYbHKTi+jcuM9CK3L/KuTG2C1aBUpVf8CRDp5R9VgSnntpFk2d3/2s3DX9Xqb0B8OQSokirPnJJDLbF22qaBNvIYJ8DGKJVnDUKQSTnAUL/IQbkZfVFjy7/du/uB2h4B54/h8vvEYNZTNuBalHw6m9ieY3HAuwGm9fiouVPtuqKqqXBDLUZEWF6DBdCr6NiigGpMOGWnv+wGQ0CeyJeywpVKhEHqVpkTrYNCgJU5qlukkccdoOWdmfvUBYQ==
Received: from kaveri ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202507241852340796; Thu, 24 Jul 2025 18:52:34 +0200
Received: from daenzer by kaveri with local (Exim 4.98.2)
 (envelope-from <michel@daenzer.net>) id 1uezBI-00000004zLw-1vXg;
 Thu, 24 Jul 2025 18:52:32 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Shankar@kaveri.local,
 Uma <uma.shankar@intel.com>, Xaver Hugl <xaver.hugl@kde.org>,
 victoria@system76.com, David Turner <david.turner@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 0/4] Add atomic commit HW done event & deadline property
Date: Thu, 24 Jul 2025 18:40:27 +0200
Message-ID: <20250724165220.1189129-1-michel@daenzer.net>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This work came out of a discussion at the Display Next hackfest in Toronto, see
https://hwentland.github.io/work/2025hackfest-notes.html#scheduling-atomic-commits .

In contrast to David's suggestion in the last paragraph there, I went for a
separate property for the deadline, mainly for these reasons:

1. Communicating the deadline via events would require sending one event
   per CRTC, which I'd rather avoid due to the experience with page flip
   events.
2. I'm assuming the property value doesn't need to change between modesets.
   If this turns out to be wrong for some hardware, may need to reconsider.

libdrm MR: https://gitlab.freedesktop.org/mesa/libdrm/-/merge_requests/426
mutter MR: https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/4540
