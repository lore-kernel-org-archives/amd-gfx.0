Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D533C83F22
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 14:14:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D989B10E104;
	Sun, 20 Jul 2025 14:14:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="iWOVkPsz";
	dkim-atps=neutral
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CA410E104
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [88.120.44.86])
 (Authenticated sender: ydirson@free.fr)
 by smtp5-g21.free.fr (Postfix) with ESMTPSA id 0597E6012F;
 Sun, 20 Jul 2025 16:13:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1753020844;
 bh=SECKLWyKT95FYCIQjnFFldAaug6rjJ4GFfSS3Tx1Ij4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iWOVkPszb1FFNMj8S7Ngyaqn5F+oCnezxYEJSQO6YyDZw+25sHGV0c0fOt9JTbWMh
 evWjHlaRQPGuhy03OdYfGBHnk8G0CJ30gbpIw94OBcOI9xpLAWFbKoqZ7+qIG29H0K
 AJXYDkTmcP0lz5qwY3shJhdwl8QAyl36xnSF/aITS0r/HtKlD6fwDXbJsE8giIxyon
 qyxwOh5/RnAeKlXh8BAZnLv4q3Ney3StHj9Kpnw4QRpsJT9Ww361fET+UkpfNG3WtG
 Jzr11pdIRSfDYkR85pVqW3byKzDu/Z24totoG+HtHqBbkLzrqQ7OZ8Uki+gNRVIlZs
 nGdZYKuwNy9Gg==
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Yann Dirson <ydirson@free.fr>
Subject: [PATCH 0/3] Minor documentation updates
Date: Sun, 20 Jul 2025 16:13:15 +0200
Message-Id: <20250720141318.4845-1-ydirson@free.fr>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
References: <1103498267.150074445.1752966181999.JavaMail.root@zimbra39-e7.priv.proxad.net>
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

This series fixes a few small things I stumbled upon while reading the
amdgpu doc.

Yann Dirson (3):
  Documentation/amdgpu: fix 'in the amdgfx' formulation
  drm/amdgpu: fix module parameter description
  Documentation/amdgpu: add a few acronyms to glossary

 Documentation/gpu/amdgpu/amdgpu-glossary.rst              | 3 +++
 Documentation/gpu/amdgpu/display/dc-glossary.rst          | 5 ++++-
 Documentation/gpu/amdgpu/display/display-contributing.rst | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                   | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.39.5

