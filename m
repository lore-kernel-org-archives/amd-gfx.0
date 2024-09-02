Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DC9BCD3427
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Sep 2024 15:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5032E10E33C;
	Mon,  2 Sep 2024 15:44:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=math.uni-bielefeld.de header.i=@math.uni-bielefeld.de header.b="TLRV6lKA";
	dkim-atps=neutral
Received: from smtp1.math.uni-bielefeld.de (smtp1.math.uni-bielefeld.de
 [129.70.45.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9F010E05E;
 Mon,  2 Sep 2024 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=math.uni-bielefeld.de; s=default; t=1725270032;
 bh=JuciOZUWnwmsd95UL+c9j94VNtanG9PAaCmxSTjMw+k=;
 h=From:To:Cc:Subject:Date:From;
 b=TLRV6lKAGAlIJpgGPHTjRqWcsFs9lSM857jqefJMxI0zGWmDEiD8YAzPsnyy9XDSp
 oqwCMATSJnBGJy4YADwe4lAdsjFckuP13wju08KVTlhEpDTkUSdnwlwQzI1/KiJOSW
 w4MUdZzSmnXfB1ke5SbBEXEwDchjZfrhuz1ng4Nb0tcj/BXLsVjTEQFX/Cdan/JLr4
 hszysbH5mPVzCdFkiND3pGEDAvEwoDPFEhEQL2ERRW0GwcTh6N+FHZhjdKkW43T6Wv
 S5Hg61b1cxSgSdW/b9Qnno6roz3grdnxJduhg99ydaHpoSLO7zrZQREIMs/JwU+LyZ
 0gOxGiJTjpx5g==
Received: from localhost (dslb-088-074-203-146.088.074.pools.vodafone-ip.de
 [88.74.203.146])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (Client did not present a certificate)
 by smtp1.math.uni-bielefeld.de (Postfix) with ESMTPSA id DDD0820810;
 Mon,  2 Sep 2024 11:40:31 +0200 (CEST)
From: tjakobi@math.uni-bielefeld.de
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Subject: [PATCH 0/2] drm/amd: fix VRR race condition during IRQ handling
Date: Mon,  2 Sep 2024 11:40:25 +0200
Message-ID: <cover.1725269643.git.tjakobi@math.uni-bielefeld.de>
X-Mailer: git-send-email 2.44.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Sep 2024 15:44:22 +0000
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

From: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>

Hello,

this fixes a nasty race condition in the set_drr() callbacks for DCN10
and DCN35 that has existed now since quite some time, see this GitLab
issue for reference.

https://gitlab.freedesktop.org/drm/amd/-/issues/3142

The report just focuses von DCN10, but the same problem also exists in
the DCN35 code.

With best wishes,
Tobias

Tobias Jakobi (2):
  drm/amd/display: Avoid race between dcn10_set_drr() and
    dc_state_destruct()
  drm/amd/display: Avoid race between dcn35_set_drr() and
    dc_state_destruct()

 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 20 +++++++++++--------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++--------
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.44.2

