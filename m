Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4013C02182
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2025 13:57:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C1F610E5B8;
	Tue, 21 Jan 2025 13:57:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hxjc8QTH";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BB3010E5B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2025 13:57:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7F517A4199C;
 Tue, 21 Jan 2025 13:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C689C4CEDF;
 Tue, 21 Jan 2025 13:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737467861;
 bh=LqsmMghNzev9q06Xe6vBkbJQBi+l/YCg/+86Y9L4uxk=;
 h=From:To:Cc:Subject:Date:From;
 b=Hxjc8QTHN1guArNTprnw+kJZkQ/UUfraPDwUChEEp/F1Ih1jU7BtMU/Z+5AXLFbM7
 SJoTesPKJKAPgAm7zzik8aoGeQQ9Xt+/r4vCR7y1O2YZS+UB+205wN8+SDvkrir3rQ
 6L250c+DySHwpq6vWDtm377/Suj7yTjZcbClll1Z2rnbbZoGe6w1+7e1eil+awdKD4
 wL8onMdboFpm0cyuuDhUe9DI8DVqiRkeo2+966SFzH5Q3H+lcCGBIKnoeuxfm0A0a6
 KFIxBKnaEUobpatj4rzl+B6GsQGC3yV3FkRb2CuVvJh1wYI8TGVNm+W/XDsdcV7563
 +RiUGIQX6+QWw==
From: Mario Limonciello <superm1@kernel.org>
To: roman.li@amd.com,
	amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/4] Correct a series of off by 1 errors in DML and DML2
Date: Tue, 21 Jan 2025 07:57:15 -0600
Message-ID: <20250121135719.2883833-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

Many people have reported a series of issues that lead to divide
by zero errors in DML2 code on DCN 3.5.

This divide by zero error is caused by accessing outside of the bound
of what is initialized on an array for the number of planes.

The first patch in the series fixes the immediate issue.  This patch
should go to fixes and stable.

The remaining patches fix what appears to be the same problem in other
code in both DML and DML2 that has (presumably) been copy/pasted for
loop iterators.

Mario Limonciello (4):
  drm/amd/display: Adjust plane init for off by one error
  drm/amd/display: Correct off by one errors in DML
  drm/amd/display: Correct some suspect code indentation
  drm/amd/display: Correct off by one errors in DML2

 .../dc/dml/dcn32/display_mode_vba_32.c        |  68 ++++-----
 .../amd/display/dc/dml2/display_mode_core.c   | 131 +++++++++---------
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  40 +++---
 .../dml21/src/dml2_core/dml2_core_shared.c    |  50 +++----
 4 files changed, 144 insertions(+), 145 deletions(-)

-- 
2.43.0

