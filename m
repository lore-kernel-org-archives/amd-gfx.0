Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE47C2FC0E
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Aug 2023 10:53:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F49610E43D;
	Thu, 17 Aug 2023 10:53:07 +0000 (UTC)
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184A110E43D
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Aug 2023 10:53:06 +0000 (UTC)
Date: Thu, 17 Aug 2023 10:52:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
 s=protonmail2; t=1692269584; x=1692528784;
 bh=s7aCTVpmQZ32M+jxsMxqyZ7j69n6blBge8/OHkU91mo=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=NwngBgjpwI2zX215zkQDazXtjzTx0/gGqripb6VvaUutfM9z+Ozi+2SoRX8SmrgMf
 N500ofs5FDchEr65Rwoyx3w+yP6jTgVQZkZpFQ0kyGk+ocN0Lo95eLawEYRNvA+vZa
 N74YFCjciSSpKN6927HGy/cFrGr3wE03cNLcNqa+owP8jyEWWBttxGIQwnGLFR7HrW
 CRRknZ3znn2O7dOXxM7QX3LY81yMFEpXOVlodSQMoHOfu+mvlgubkFpHLWEshSId7r
 Ln8xtptodKUbci7Hrc+NafN5QOwT8AzvwEeMBvLrnuQJ2AW+lfRL8WIO52NAQt+zPA
 8OqrC1J4EJ+CA==
To: amd-gfx@lists.freedesktop.org
From: Simon Ser <contact@emersion.fr>
Subject: [PATCH v3 0/4] amd/display: improve atomic cursor checks
Message-ID: <20230817105251.103228-1-contact@emersion.fr>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Changes in v3: rebase, split cursor rotation patch into 2.

Simon Ser (4):
  amd/display: add cursor check for YUV underlying pipe
  amd/display: add cursor alpha and blend mode checks
  amd/display: add cursor rotation check
  amd/display: re-introduce cursor plane rotation prop

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  3 +-
 2 files changed, 31 insertions(+), 2 deletions(-)

--=20
2.41.0


